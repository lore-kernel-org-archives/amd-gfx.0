Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23D6CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7960210E42E;
	Wed, 20 Sep 2023 03:20:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA1410E42F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yaj6U+oINjp5oTjzMcyeP3ktql3nt0dZ+EsHFGE983uFwmwyENtiLfU5LLVDcRTqNNejnYBKBuxkfsa6DC1zS433OxU4vxWOm4nkaIkTeK2lzLxo5k/yPAc+8zVOGPB9MIhNUkbw5+G1/kiF3d3sa6dLC7AjWYraN9H9Mb93j/Y5ZgcJLSIdpAi9Nl79yDZmNdm44zzJQaEIiYR8eg59lIcAn+4aOB8C2ZIz5ZoeJpl+mfVG9nvhKCsWBAvsb6OudkoCn9/vaeW9+SywvqOHH3tDr6hpyudSlmbdx5IhqZRiuvU0DyaCixbXdGsdGPe6r2WXSZt+ztPTe7IAbXlqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFK4SoO+hoSqEoEnVPXoVFdh2mEI/RFULYMEXIr76cM=;
 b=mzdcQOcnmj3TpdfY7rhZcNgLwbEqu3bf8V8WoA0l9w7SqqCltnBbaFV6yx5G6sGNJhZLgclTWz2AS93HN2krfeAhi4BdxfXSPXPWZ6AvrHbm6mGHxW351+b7rS555zw1vABNPl/TiU7NSO/TSZND+GJHvrmjK2rhZveLOCGnRrcAGPlMb4F7scz7jnV+Q1I68soDxT6Vk+vNHC1mmpH+c+BgdNUJir0YgDGwQ8k5UgWp/QgkSqGdYCHtp3eIRpGkBk+o4r0F8T114pB4b8IsgsSE+aoFxk2RSo7xM9sxwycDq9oCtBOssLZ6raxLCEokVaRdPbSZnUr1OQ+7uWtOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFK4SoO+hoSqEoEnVPXoVFdh2mEI/RFULYMEXIr76cM=;
 b=X8DKk6o+OK+rosesqDv7KJLwzoKZKcF10fYsbnipurp2xIOdP91DT652xgwI+UaSu8JUABXisaoIIgRURgUeqHj0uMUCnIGfAgV2quUCSvBihyizBAZI24AzG32Rm4M7er07k9WrckyXRYqn5RTN5KZgkKyfMAvAE3SYSxABd1U=
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by BY5PR12MB4854.namprd12.prod.outlook.com (2603:10b6:a03:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Wed, 20 Sep
 2023 03:20:51 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::2) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:20:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:20:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:20:37 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/19] drm/amd/display: Update OPP counter from new interface
Date: Wed, 20 Sep 2023 11:16:17 +0800
Message-ID: <20230920031624.3129206-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|BY5PR12MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 799dd404-4460-418f-5c97-08dbb9889794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AafzoY6ndPcm3Vk5qWGx9AdSmz4JkWgxqNRSu6vQg6KVzrjx1i7vN9X2749EPrPFGQJ7qe8aG0FRgImzIxfwvbp04iPIYcySHsnyrnXy8k3mnH7L/c1eVYmK54MRGjqL9r6pNYsoKmaOS1tInyXBpOF6J/xAxz6Jm8bYT24eEN/dOyhyZWyOB7pYlP6T33DuUChPs1F3tSgjjr5/smpx4ngzUbyyPSy5mASgYcF3jo1VENR0UKy4qBvwIz+8Qy2/qHQKVeFctksCm4qMC6Z25KvAS9d37kI0R3HsCXiO4Xl8A/Ts256fUj2wARi5IsNBGItsbqkabCwXR6KaT1D2d3jv9KR+Wi6+UZT+mtyhn4bon8MrUySWLxnj4eYbdC8RGiFTdS1iKHbRn/fHFa9TypGo55ujQcD2zBoeER2JSffY6zt7I26FVQKpAfX0EOp7HcVLzp8KroaWU6H3ZgGJFrEqEi4tCh6LeyL/mfGzlCmZrSCz/UiUnHsYn7y9Qr/BCKzAa4Q17p1ZvLHZiPXyseHxxZyGtqQeyxfd/S/nC7Y4j8u+WbkYAS1v8LSzxJPr9e0koLg5jNNe1p2fm7B/E9S65lye3mNs/fNO62r6fH4VXZTI3VHWdARp2fRdCIp+yXZDs+RsORqjBzSqzAzbOdjko2dCGsWWaI5sU7mK2h9wNpZWgjvelZfF2bxSclqR7AKVXvMeBnfHWIEWStrl1f/K0JDsaDJTps6yUx9EXDCVwDKljShEj2P58YwDJ6Y5N5mPC77keIBwykempCwKJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(426003)(336012)(2616005)(1076003)(26005)(7696005)(36756003)(478600001)(6666004)(36860700001)(83380400001)(81166007)(47076005)(40480700001)(86362001)(356005)(82740400003)(8676002)(41300700001)(5660300002)(4326008)(8936002)(6916009)(54906003)(316002)(70206006)(4744005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:20:51.2049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799dd404-4460-418f-5c97-08dbb9889794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4854
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: stylon.wang@amd.com, Hong-lu Cheng <hong-lu.cheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jaina Han <jaina.han@amd.com>,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 Gang Chu <gang.chu@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hong-lu Cheng <hong-lu.cheng@amd.com>

[Description]
Change to new interface for notifying OS of cursor support changes

Reviewed-by: Gang Chu <gang.chu@amd.com>
Reviewed-by: Jaina Han <jaina.han@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Hong-lu Cheng <hong-lu.cheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 293489c41086..07d960e7bac7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3495,7 +3495,7 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
  */
 	int pipe_idx;
 	int opp_inst;
-	int opp_count = dc->res_pool->pipe_count;
+	int opp_count = dc->res_pool->res_cap->num_opp;
 	struct hubp *hubp;
 	int mpcc_inst;
 	const struct pipe_ctx *pipe_ctx;
-- 
2.37.3

