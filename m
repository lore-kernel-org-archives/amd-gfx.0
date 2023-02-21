Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD0C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 08:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2327910E11C;
	Tue, 21 Feb 2023 08:29:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928B410E11C
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 08:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBfoyrx3ijucuIBrHtoFaU5BZ6kS1pJ8wQ2p2+oUhBhPUrQzCbElnPA6NA+DglngfqFfEA8KCc3zoMeESTqOHZhZUOwAnaUKQiDllgAV9mp7apncXENrMiZATRLgL4MjUWXU3UdJYWO3Wqpw8rgWvKznQFHKASeVkqmLmEgXq+MP7L6yKNz0MpZdhwDn3RgzIyL/4MhhVj9FWNdXR4/vhFkV37s4C0ddH7ywAdmhJUxRBZyBZSs/6qNWyaI/13vixeJAsHtmeEuUKo3dMMzo9RDOBpb29f91m27X3vMbpforLNHg2blS3FoxHu1FRhvOp3T4K9jfYtgJASxOMgWJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0xwM9jHJzukUhgbU2lU8pi9/y7m2B0el+0NKYnNJDQ=;
 b=Yx4ppLR1FptFLICelKt8OdyCWApZXY6FAiyCDKbA6qQ0TnsWAB3jxtjcznUF87Dp6qOj5PlSLQOUzxmQm3FIVAxNagqSn9ZM2nD3YtPD2yAbFeHXhJNdP07Xrmls9otlv/Yk2BHLLDwKAO2lHabTAw09TdUBGLyN2ISA/VhYO3lWgovGo6IgnVjgCu7CukdiScSL18JmILiY8faxrdIBtli0obpucmIiaaXaVsVbCUrR6RueH+7piw+YylKAIP9Q6+T4KMBKDe3ezHCyChT/UZRFWkLVP7iXPeSZQYYtEJ8g8gH3jVN+v8kh5rt6FSRyyYepVtryF5fAkk+yaas4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0xwM9jHJzukUhgbU2lU8pi9/y7m2B0el+0NKYnNJDQ=;
 b=04hv0niwggTv1hJGWy7r6PewJkUcHhEkpi9ikthC0COCTsCrH8w7gAO6yfAyVhg/hDnQX4HaYccYeY639gMu+yGVWUWSyfoAI2ObxlHNzoa5C1RVMZLAQt3JrEzPI7hZpwV5dUjoE3IZ7BZRHn4ji/1IUbeCK0zGojFwtJIlT3k=
Received: from DM6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:5:14c::33)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 08:29:35 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::79) by DM6PR11CA0056.outlook.office365.com
 (2603:10b6:5:14c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 08:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Tue, 21 Feb 2023 08:29:35 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 02:29:32 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: change default behavior of bad_page_threshold
 parameter
Date: Tue, 21 Feb 2023 16:29:22 +0800
Message-ID: <20230221082923.19190-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a527eb-7733-498b-1e95-08db13e5c379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0UMxIPWoJ7cNcYshKiNwiqI0N79vBZ7VSsfUygUJug2zvynHfryXGQg7f8YgSiv5TlIfo8vVi3qGiBDKZUKdslT837JaTCUyCvZ33Zo06Tp2cIxqX9iUi6V4VMAL+aEZMeGFVgqEY30Xoca0s3Jt9ta6xq9mB/az+rzy1JGGtpeU5HRAXl0AOAmP+XcsWWlzqhz1DTjkaeHrsrG/PADA8zlKeBcbPN7QDPrdMOyto2N/6mF/Rs5dD5VEU5ZFL4AuP3M77PjQvGrHrWxolgtqEQ6V2NdbJH2lP5oqGYvlBI5/pL7R6NK49IKC9TQB9e4lEVFonSwgRPxA+k3BTK+Fp/nGhEpUABq2N2XKymEu6+zgVfcjAvZ+Lbn/FGiiXPy5IumYPpvgsE7SnxUKBllu1Ocx8SrxHILT0zU8u8cgP/LbWdaF5G1dhHtsp8qxjJwLPfE7hYd+GWN7L4kN9ONqNHnV/WCXa/frrZx6zmoN9oZSvmX+Ds2Wp1LG8YkcXkmR49XtLaZ/KjsJyu6eq8WXZOV3Zrnn7wuFCjWd3J14jda1ZXZsVousaEyBDxp7dqYdUXBDx9WMajexzVEYtF78adGbdNPJQJNgHoWaOxD4S3bDU6B1RSdL14oNDT3S5WhXo+YI7+BQLMU0kXXgbOj/RrFCuvnmqAtBi5QnW/f2tOo9a/y8qoITYOgtZKPlbodUfC13dM2c6Pw+s/3DEOARyLgeuEs9CBE9uFD5wl5Xwg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(36756003)(40460700003)(86362001)(36860700001)(5660300002)(2906002)(8936002)(81166007)(110136005)(356005)(40480700001)(82310400005)(47076005)(426003)(336012)(70206006)(1076003)(7696005)(8676002)(82740400003)(6666004)(478600001)(70586007)(316002)(41300700001)(186003)(26005)(4326008)(2616005)(6636002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 08:29:35.0209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a527eb-7733-498b-1e95-08db13e5c379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ignore ras umc bad page threshold by default, GPU initialization won't
be stopped in this mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6c2fe50b528e..76c0af45f21c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -921,7 +921,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = ignore bad page threshold (default value), 0 = disable bad page retirement, -2 = auto)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5c02c6c9f773..63dfcc98152d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2196,11 +2196,12 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 	/*
 	 * Justification of value bad_page_cnt_threshold in ras structure
 	 *
-	 * Generally, -1 <= amdgpu_bad_page_threshold <= max record length
-	 * in eeprom, and introduce two scenarios accordingly.
+	 * Generally, 0 <= amdgpu_bad_page_threshold <= max record length
+	 * in eeprom or amdgpu_bad_page_threshold == -2, introduce two
+	 * scenarios accordingly.
 	 *
 	 * Bad page retirement enablement:
-	 *    - If amdgpu_bad_page_threshold = -1,
+	 *    - If amdgpu_bad_page_threshold = -2,
 	 *      bad_page_cnt_threshold = typical value by formula.
 	 *
 	 *    - When the value from user is 0 < amdgpu_bad_page_threshold <
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2d9f3f4cd79e..9d370465b08d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1191,8 +1191,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		} else {
 			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
-			if (amdgpu_bad_page_threshold == -2) {
-				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
+			if (amdgpu_bad_page_threshold == -1) {
+				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -1.");
 				res = 0;
 			} else {
 				*exceed_err_limit = true;
-- 
2.35.1

