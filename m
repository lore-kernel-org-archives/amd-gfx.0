Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0635C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF5C10EDF7;
	Fri, 14 Apr 2023 15:55:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFDA10EDF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnFvRv8Rxxh4rvkJObPN13K6sQezw9k45hKkX/ePpi8iBtvGLHIY/KCUOlXC9Cvs5GNvQfORte2o/VMkJjYPIKgBV9UCWxdn14UEOidNu49qzqmuwTWRdVuRsiY+9W7BCBx8spVYAKAC2oFnQCkMwpGI/ufZERnkDDckE7Ggt1JP6l8Oal5p78w6EuI/BhwusY9sHJhiVx9ogelXTmZAtbJUWxSI93yCz8vGGL7olFU8TxbX7yP1zElnP1cb+FmSlbrGvUgoXg5kj9IqI3VdUqfVgEqPMk0Rt80PRGOFxDxskXX1Gl32Y7+3mBr5lkuztJh0WBKB2wLCGuK/6KBMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ8j7VEa1yBhtiZzoEUa/8cj2Qf09sMnFuDzPt7t1mk=;
 b=UxNps/3GZp3aHovL2VDIG7cszzUmYV6bDEvsbNqbNMD1wZ9mt39H9NR2kCWIL4aDKearkN5Zm5islfom7N+KB1/rUAsbrGMaHgxjeWvTEiDqXY530LCWvVI1JRSvQ6SmgLTcowezjqUxhPxp3JuJ/jJFxyPU5CM/ue/4/G+/U9b1Ager0nBo6CT3JW1GpTOwOvml8HojfNyCxYEu0FAyBvNpvo1oc2fxwR5kx7jFhacUrZxROm/4Z0JhM1FSqU8x5PE9SvoNFQjtNnqXIwdjTRXPPVOv3AwGzydRbDWwkGeaR/ulzBzxoCv1W1/h7TNtCSaoeChZErrvkTch2h96Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ8j7VEa1yBhtiZzoEUa/8cj2Qf09sMnFuDzPt7t1mk=;
 b=OjXCsGc0/T1hJvnz4a8tDCY5lb3ODQCIJwpW44u6hSIr3sgXCOXtqixBzxLfmysz1qxquwVH0xYxgDeR4Fi2KNLTSos9ZdwdD3LJ+QeVaamzqX0C+G7/tSGia0DBzTwhRiAeD/n/5JA8vQKOlozY8IyDGEZLS6iAFHDH6a4S3+8=
Received: from BN0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:141::7)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:55:19 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::11) by BN0PR07CA0014.outlook.office365.com
 (2603:10b6:408:141::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:55:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:17 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 61/66] drm/amd/display: fix dpms_off issue when disabling bios
 mode
Date: Fri, 14 Apr 2023 11:53:25 -0400
Message-ID: <20230414155330.5215-62-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: df9894ae-adcb-4ebc-474d-08db3d00a5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JkZITeMFtDTqRrHRuuDw1UgMRVaE26qHOamiiYHG3Xolh5ukppYOXrrrgR1E+E8D6YIjPjMIcCoIkcp7svJXChYiTgpPdzU5/esNlTTCJ+sqZ5fa4xpvPAw+pjJjR6rYbvD8gLXrlDN1ebk1LJfZt1gHW0XuyrkhGmmIUaGvCyshLqEzewPS1Fx5xNC71PyaLCFMsbkLDjsmbzeUWarpuqit3yoGvnBGtJVpSMf4c29DvUGrTN6Zw5hM6Clvgo67Xj95u7JAH8NuLAeVvJgbFfrfP3lN4GS6xLrCCKK0Cw1S6FxLTJBKOz0xYrcwW3PKMc83FSPIP38D4jxVvWDMPAGH6QkFNr2KHFnsvdO4dAINBh9M67PANc1xnS8KADgFspz3srkrjY5a/9metF4f9z/PGs3FYoPgJmzeM5kXNhTQsGahvAzSag9smKO5AnArA+pVF9n9ufVz7HfL5/X4jJKxp85Y/EaOxjf9zGwAdXwQOzPve8APMr1yGvqsSq7zrLFCk+DeWqg70Fo9zzhEKyljewSR289kOkca+8Oht9wp6PM2GcalDmSrxXVclIr/QzAg8HdZ/HnJkDR73QhSZjB/atdAfCiCtbDGCuPy7C98KYfnmDQExyb8+pvfDt+TNNf9TdZ8IPRVCw/DzzcUDmRkXYKbxUu36AZ8uqhubVMZ4kRd2AnHN9kjecMsOF5AOVM6I56DN9Jca/i7PFKtde0ZFCnW0PZbQlKNbC4RR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(478600001)(6666004)(1076003)(5660300002)(186003)(16526019)(316002)(26005)(82310400005)(40480700001)(2906002)(4744005)(70586007)(70206006)(4326008)(54906003)(41300700001)(8936002)(8676002)(356005)(81166007)(82740400003)(36756003)(47076005)(83380400001)(336012)(426003)(36860700001)(2616005)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:19.5608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9894ae-adcb-4ebc-474d-08db3d00a5ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Zhongwei <Zhongwei.Zhang@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why]
disable_vbios_mode_if_required() will set dpms_off to false during boot
when pixel clk dismatches with driver requires. This will cause extra
backlight on and off if OS call 2 times setmode.

[How]
Set dpms_off to true to keep power_off and let OS control backlight by
display's powerState.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9304eb66a1af..238a13266ad8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1268,7 +1268,7 @@ static void disable_vbios_mode_if_required(
 
 					if (pix_clk_100hz != requested_pix_clk_100hz) {
 						dc->link_srv->set_dpms_off(pipe);
-						pipe->stream->dpms_off = false;
+						pipe->stream->dpms_off = true;
 					}
 				}
 			}
-- 
2.34.1

