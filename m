Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F8C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 03:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D0110E787;
	Thu,  9 Mar 2023 03:50:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE40010E787
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 03:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPh5f8nPWm4ectkLS4fyOiVJStnI91OtsYGdSZjTvu1mdHbfBQ0OM0dq+qfx5E1HD01Fmf5qoNkD/8szianmGT2bkCHBYfLcyvRSsm/rvlERc//7PP0ZrcwWXGJ1nNTWj317CEr3sQyCMFL4B8OGq7k95LEL9yFnIQpx3m4qPAdPGg36lCFfsxQEkXlcRxw1XM5h/EOx6UH6nVKWDVJB7YifZxGoN3AjWeIcDx6sfYC3TsdhesoUvc83IgOdjkUItMEsj5fPtEAlxiktFsCywwNgIYH4hzuvZ3o4c/L3TD8SBLIYNcnqpefCC4bYL0tEwzdauWtmCQAROFON1fEjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2ONSxY2d2XkosxkBXpQrYHbFFMK3bZULKmza8awDhA=;
 b=H+8fOuhYQpimM1qey+/pJ9rLnkmj2voxpWKwFnEVOsyxu56v7nzyThxQjayUmY14I7cixhwnu9q1iDcsqMX+Kufvo55P+FL5JdCZFxX16rgKRMoaQxN+qDNFIwjq1em/v0MUhwx/yZvcwe0uwtCzWeTa9TdqeVq1BUSkMc0yrqe4+UV0Oc2hvJp2JrfXo2QpWasBZSDYzjXUpsY6L0GEqrPE6rW0cJwafF2nUTBAqdu+sDSzBIpPeIVrLbtELVVKkxZyfKl57GMFeLpQhFCA6JrnnJmmSR8SNKoZUVJi+gj3lxeELcjPOLh56kM+PmQ4XpbrPPScRDlPniAzz4gojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2ONSxY2d2XkosxkBXpQrYHbFFMK3bZULKmza8awDhA=;
 b=rnTFIQGjE0hwtt3IeTql6hUbqCpSvO8D84JLm7hB1+eEDDuG4OWBxH0nVeAKa6kJctCXL4/Cx303doTmP8jYMLOil3BI1sdYGOJ4Srl9jU6HJhMFaFu5iJNkpYeJVSfPUkhcZBQS4tTArZSMqCwDSfdFzNTdMxNJXaEsqqYAgEg=
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 03:50:56 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ca) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 03:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 03:50:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 21:50:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/nv: fix codec array for SR_IOV
Date: Wed, 8 Mar 2023 22:50:21 -0500
Message-ID: <20230309035021.1860501-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4581fc-5786-470f-a46f-08db20517cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAnCQcpo0W9BN+MCQWKt1NKIrQJ5hWBnG05UKTJfqJzwUuFJNvZHEEkTVEdxVWL2et/EFHdrHbwrOjDCcHipi4uvAyfsS3Fllbudo+m0EmY6+o8ixGV0lYTQ4pf7fOEWvazZyfxgE8tK9PoK1mVPTw9WXx5kLRq7hfhhEK/NVJwSBR8TiXa61t/zLDFkY3tsfuEw00VlWe0mJ87izlFt/lZKmmo0s3TQkOC5FtrNOpLtD9q12UAa+e/GH/5fWb0RLzrAYpUVKS5HvLJtk2sQLS/o70WdtEpNFAt3o4NoH677PpwLYCLvC5u1vb2cOBpsJnS7F5j4+6ek16dQ3Go02qOUo/hQh/jOZLpOubSE6n1kdvGXp6D8dGF2ZMqi7Pt9yqdyupqJXFu4V+5PMnhNoEG5dOTUj9lNP3iW4wuU/QD3FOfVZ9ylzsInazUSgezkhliaW3SGf77hAs7EI2JfF98obapBkGeUKC+TP+K7eGhqNbM9dt0W3qyxNpPvzfnfLmbF8PsekWHexvzDO8RWRCOUox+1evcR9n2Hqix6EzDd5Zf3mmZ7hTc6cZg2w5MggEot2I8k55PdRTYTrqT1A/zeoQxb9AqUhVHlx3EoMs8NjANorXWu2j6ed2u00gWcox55CYnyx8FXN9U6aQsba+/w8bZW3TXN11TfuaAPZ2/uNBW60NElag2exxnXg/GGdXamokNhmHzstrzjtuLNAGFpBobsiYgi63WIhZDwsg8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(478600001)(36756003)(186003)(81166007)(54906003)(82740400003)(426003)(82310400005)(70586007)(356005)(16526019)(70206006)(40480700001)(8676002)(4326008)(7696005)(6916009)(26005)(2906002)(1076003)(2616005)(6666004)(336012)(5660300002)(36860700001)(316002)(47076005)(966005)(41300700001)(40460700003)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 03:50:56.2342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4581fc-5786-470f-a46f-08db20517cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Copy paste error.

Fixes: 384334120b66 ("drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4454
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 855d390c41de..22e25ca285f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1055,8 +1055,8 @@ static int nv_common_late_init(void *handle)
 			amdgpu_virt_update_sriov_video_codec(adev,
 							     sriov_sc_video_codecs_encode_array,
 							     ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
-							     sriov_sc_video_codecs_decode_array_vcn1,
-							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
+							     sriov_sc_video_codecs_decode_array_vcn0,
+							     ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0));
 		}
 	}
 
-- 
2.39.2

