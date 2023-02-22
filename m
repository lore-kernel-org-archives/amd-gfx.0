Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28A9C61DA3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 02:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D801410E083;
	Wed, 22 Feb 2023 02:52:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D44ED10E083
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 02:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xy9dlM91AmHPfTFSlLNAVENVlbm+10ukwOdHWeSTsTUc8VXSR8ieO0JO3RkcrFRg5SQwEYmUs0yltt8hYoYXStLJZLBMg0526Tx1+4KU4gJ0hW18NwAcOB16v7XQiVzMQeu/q5+rEWaH8TpseuuaSAd3wvuukosRW4IMASEG6/+v4xXfPeXmfPQp8/AnHL99iuMw6nZMgHjCnQOU9ZsnBGH2TMWjIqAEtEZf6vZv5hieMXnFG6OSbEY9eCPpRYxMGhrZearR7dbfeZDK1apRI0yLOO5g3xny2BumVMd3Jl534zFhbFaQcpBvVsZ/z5+QYtcvpOtShABVxFiXL1U2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imWlpLQCpd1nCT9xX++BdmRkefP9I9EVk175YItV5T0=;
 b=ObOtEA+As97O9DXgG0Ed4bFxjU1Q9JfW956LqCe4k9ioAOBwEXZ9fPacDnr2m0CbDPuTxNykR7/Qjx756p/xqaM9Ey+GpuqunC4aQDEOBsRcmk4rMz4LpIKK7BS9zqKE2c2Ppexo0Ou5JCET7+ZV2/YRUv8X2qTil2i1i4Cn6N8XRsr3A25LNz7pOATOTzGeZ2ZTWIr1CT1OwMvhOkoWbJSAMhO/v260r4ADfBWVlzAkYJolIagq6XfgzDP1Nq0SzbSBLtcHHkg5SLOKpPp+l/+Lqo/2nBCk8qhQ6Dr3/rRIZWXwqd+sPwnh7oRlH+RwB5md8r+TeMyOfFDEjGQD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imWlpLQCpd1nCT9xX++BdmRkefP9I9EVk175YItV5T0=;
 b=DfRNekhnv/mZWvxUxc+VhiySkiEVI9UWU/rK3uYQkXfuoKN+2O9gt7TH9BcZKL2v/DH8Wqh7I5EYOM/+z8NMmohOa7Ji6IzAoekPbTgfSmjoCv4qxCfNFLcKFi58SFSZqKOGJ2w4cXUquojSSurC/Lh9QGcGZM0EryVqkkPp3ow=
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Wed, 22 Feb
 2023 02:52:00 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::19) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 02:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 02:52:00 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 20:51:57 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <candice.li@amd.com>,
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: change default behavior of bad_page_threshold
 parameter
Date: Wed, 22 Feb 2023 10:51:47 +0800
Message-ID: <20230222025148.29652-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0effff7a-3410-4e5c-888d-08db147fc53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69ZrSuduNc5h5S+hXym6eh1TL1Z0QQKR0q7hEdMXXi05rwDLF1QDQzRclIivvi9NC0vi+X6opNvVvYAgKhTapCOZFB/iserRLBnD3pGSWabAYT2KslFVplJF/oK1a0Cpa1HVkjUC9SqldaHTcAFKjMcQHvgM4iYGWrlfIJUeIhi7qrNo682ZhxKU0p/B8FARprM5Op0zLxcq1j/kmR5PbBYIzPYcpWdA9Rrha6X3aYUqy1ya/bN3Firt3UxukYGXQiPWQsJrV6IE2WVGlNO1ibNvLKnbOjavZwBHry4iCRxVgHrRvyc91yJj0dkIj5fZi2+6quNFpNQnpVuo4XJ9ByGCuBYv2ZlxIl1Z2EQNk4OYJ2ql7B+N5dZTs50SCbiRyt8l7e0GtfoHPmE8y1SdDpefHEqnE0nVUjKsLmz5sRbIkgW/XDr1V294i/Nt/BQOsdoVvEYdXKU4uc2XbiRm06m2Zhkx0FArrZlzA9C46iYxA0avdFNQ7cg1u2/6ulOVMkNVr5Ylpzw/g2Y7CV1KaE3HydrL+XstrEKORrSAtyX4qJZbSyIdNC8dsq6SzULdF+r3ZQvJ7LsgjThQX3AhASmQ9AWsHr7vgE8npfQxuh3nrusBMZOsY9Q1w1iwhHle1qruC8uaQcbfHNAmSHJGdgQZ1oRqVst/JgIRThwQ6gqf9wXCukfrJW4mjICk+brrQhf9HiEQ7esZ2Cb2q6OPmMNEAa/EVHlZQW5B+FqdOEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(186003)(26005)(16526019)(356005)(82740400003)(6666004)(81166007)(41300700001)(1076003)(36860700001)(5660300002)(2616005)(8936002)(40460700003)(316002)(86362001)(70586007)(4326008)(70206006)(8676002)(478600001)(7696005)(426003)(40480700001)(47076005)(82310400005)(336012)(36756003)(110136005)(83380400001)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 02:52:00.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0effff7a-3410-4e5c-888d-08db147fc53c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
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

v2: refine the description of bad_page_threshold.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6c2fe50b528e..8a375394db0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -921,7 +921,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = ignore threshold (default value), 0 = disable bad page retirement, -2 = driver sets threshold)");
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

