Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B12C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 08:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643A410E102;
	Thu, 13 Oct 2022 08:29:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B8210E102
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 08:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0P5ZW8K182A4sCjEfAHM1pcHD2KmKzClploi2o/az6fhq1/fHvNgb8Bi3HLksjKSdkEs7+yDHXKsjnGcBGOqmwt7kbvDH20j6LmoIkwG/SfQiNWx3S+DU3QJ7Z3xPog87hFn6xEyW8Fwy7o4qjsJlGZZShkMxhvsA0xCw7LG5YmgFaO8XNS1c3OziOqPhFnd/Zpzm9zyW6c3Nly3uUy60fJcSmpE5379pl3+no6WtssH1xMiWvcd6yvBm1a3Cfhkn5qWEb7QdHdHE+k6Ra8j5DoL1ggdDXriB71LGMcQkc73+rTm8Pc1CaKn/lFrEpI9fjKQ0LIAp5QAlpGWJmDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SG70paaZkBq2TbPwq8EiZzGJRkyvnIc/y/btj5Ges8=;
 b=la7yixJCKVxGoB864c2uS2DJeOV8Q0yyneLPRtHXApKXjP1HaKYolZ+85w/CLgUilsj00uu9ka7Sjr5Zvqwh/nHabrllQE+7U6DeuCwXBHv0tmveZv+mvaTCV1ph2BZoqhh9sb44pk3X6TANwIKcXT7xADuRQxRR41XQYm1bJF6hbnJVnwA6scf9thwxScPYQqp2Giq983aDJbLrxzSSQBmcfqcZqk4kPszzowWCWIPI9QJw0c+zPBIB/T2w7Cgoi7B7saQLEgP9CLULJNMdiz+3pa0p19YkjxQBvGCTYkkodIAm4BeOqI0IZ9ggzVESc90Yf2XeTIvDbnOjaNz7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SG70paaZkBq2TbPwq8EiZzGJRkyvnIc/y/btj5Ges8=;
 b=T+QhuyGDJPtXPWvLStxt5nS54VmAZffq/w+4RPNHQITZbc5zUKzuJocoVZour6P+TshEkTB/d6LmIaxNsKlI12KcOZuI2J94aKPxsvl870P+EeKemxsdpn2lTbi9/Y+nutay9HB0A4LB6UjXgpPpQG/cZE2ZNpBxdtLerRfn6CE=
Received: from DM6PR06CA0044.namprd06.prod.outlook.com (2603:10b6:5:54::21) by
 CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.32; Thu, 13 Oct 2022 08:28:59 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::9a) by DM6PR06CA0044.outlook.office365.com
 (2603:10b6:5:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 08:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 08:28:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 03:28:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 01:28:57 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 13 Oct 2022 03:28:56 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Refactor mode2 reset logic for v11.0.7
Date: Thu, 13 Oct 2022 16:27:45 +0800
Message-ID: <20221013082745.46143-3-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013082745.46143-1-Victor.Zhao@amd.com>
References: <20221013082745.46143-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 409aa23f-3003-4575-9d5a-08daacf4fa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpa8w2n1/iEsvsjnXuf+W5ny+VWXYAXjQqZ8irFXeIc9ReVmLs0uVv2odSGqRQb4b3uTu0PiVAsD+riKnF/Tj772OW37uMf83mp/puhgqEDG6aEK5K3UMTiIk9XJF6SgyZVK2BM59oFQoY2Nucci5CJ6ImO6nVXWI0Fsv4Bn4b21biJWtxsiO21gQ78IwBJXU8tb9fgc/WX5WE/2UZ270RNTjwdyCDMnR+jCjYRpIV8r0LRxgIdz4Mk1GlEKbKkylMbNTO/PwofHRyU2alTrPqOG9Zwi2c7neS0/GqdP8LQUG47Plq3M6s7tcFaQ/nsRd1jh29bXoy4YUTl7TUCmQdpTb5eG2KBx+F73BWpiVlOgWraW74B+J9Rzk+ZQXWq2riuPmCFs5MLImzSJvCChBBfQxrW5OgIogmVnUQYsUZ6aofHWTcm75qGUStxV1dWbvzNuOhUi+IAZVy05LbkHiZasd+KqDASEeWpUWKyPFACRTwUamiDUeH6miDxe4al/lZBvBBl3KnRqJ500J3SCtVSCoiXyDwe/gi9+vZxjpLt1wb3tPLIwB/obSMDCjIwxvNzZr1yVw/xsJA1i2xO545/wA03TM+EeyBn6ZvVjkC28X2w2bdI8aJLbMuiCvSxNULiBP6hj59yGwobHL55NpigThMNkmFTWIxaksp69o8lj4ext3VHTg8A/EbmG64XhZXBAsA17RbzzdCc0vf/6NUfnt6i/TWqoxzq+52RHTm9/WjwUYqon4t984W+zhtS40ypojBzmph2j+JHsMlqw+DrY16sekb+zSkUpHnRegMfO8qvCFEIwO7SWaIovKkDx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(54906003)(40460700003)(41300700001)(356005)(2906002)(8936002)(6916009)(81166007)(36860700001)(70206006)(316002)(86362001)(4326008)(82310400005)(8676002)(7696005)(40480700001)(6666004)(2616005)(70586007)(1076003)(5660300002)(478600001)(26005)(83380400001)(426003)(82740400003)(336012)(186003)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 08:28:59.4463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409aa23f-3003-4575-9d5a-08daacf4fa27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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
Cc: Andrey.Grodzovsky@amd.com, Lijo.Lazar@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- refactor mode2 on v11.0.7 to align with aldebaran
- comment out using mode2 reset as default for now, will introduce
another controller to replace previous reset_level_mask

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 23 ++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 7aa570c1ce4a..a096f0b740ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -31,6 +31,17 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
 
+static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *reset_ctl)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
+#if 0
+	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7) &&
+	    adev->pm.fw_version >= 0x3a5500 && !amdgpu_sriov_vf(adev))
+		return true;
+#endif
+	return false;
+}
+
 static struct amdgpu_reset_handler *
 sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context)
@@ -44,15 +55,13 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			if (handler->reset_method == reset_context->method)
 				return handler;
 		}
-	} else {
-		list_for_each_entry(handler, &reset_ctl->reset_handlers,
+	}
+
+	if (sienna_cichlid_is_mode2_default(reset_ctl)) {
+		list_for_each_entry (handler, &reset_ctl->reset_handlers,
 				     handler_list) {
-			if (handler->reset_method == AMD_RESET_METHOD_MODE2 &&
-			    adev->pm.fw_version >= 0x3a5500 &&
-			    !amdgpu_sriov_vf(adev)) {
-				reset_context->method = AMD_RESET_METHOD_MODE2;
+			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
 				return handler;
-			}
 		}
 	}
 
-- 
2.25.1

