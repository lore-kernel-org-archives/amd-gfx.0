Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE25C47DD9
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222D610E4E7;
	Thu, 28 Mar 2024 03:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oJv1ng+2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662ED10E4E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9/iAXzzJImzpVLhY8st+2xTBR7NSExIusklz8OMHA7YOLNZ++StIxRSQ/NXDuYOl0c3BIjfRaTb4lRIFS6eCxafaDlH7w65nh+/tPqB1b2CSYc2fcM0KcpwTi4tvJB/VWVNSYNAHGjo/cZ1YGcovTKZYwXkRRJXF6QjshfksfDXFMCcPw6ArVIimsAcNSCYELLcaNp5zz7k9pyeUvhfM+yADcsBg8+h2bskRRZ1/FlGwcVoqU8wWyS3sppwJRbJvL71yMloxCaXCYzfE/GLadNXsclbaTjA1xq6nZr4mz6fuKSzkDEiyRI6a072JDBv/JKp48mcSg8hstQ6UgB6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B36lW4q0txlqrJKuS4p0w9x2e37X40rB1wmnlP8hsiI=;
 b=Yc5g8tQfwZR7gTdWFLfwzaN7O/6zS5jOEuonZlHuheHb8uX2hSmfX6CeI1hI6faz1p3C2i5+zIknCNpjqBgXr8HF2t/8yCyKkqC2Og8dVrmTj0NNBpSDk+Ad6eEABVhKiuHQSrGUcLxwm27H1Q1QPEZ0JJUAqOpSa/h1GjNFP4GlpwxUTP/0qabPqaHH+8hlK/mTzpBLCsNkQyLmWHpz2tTV1UcdKrmwrz8aZkGYVLHgZzaRFFxPU4mijfHQu/9iUJ7T6TyGPRBGIpWOADDaKNLTmWT+fT7Rz7I3BinkuOTyMHeD8a+JepOi23w04nVwL+8YRkPt606/yuqlGAjYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B36lW4q0txlqrJKuS4p0w9x2e37X40rB1wmnlP8hsiI=;
 b=oJv1ng+2wM74cq9SI1o1SoTU82I9Lr29CsrJ/YKwyaQLhY4NMo+akNod/xRKiP/zI9kCLbDMzA1DQ3i83HoJcJzy/TrXyT9AYoTL8Ho0xeo6vgg6D/JAgWFW0KV3Gv1oj8IxoUB5rUvsik8V5O4I8/4FDm6/ZrxQme9juug0eio=
Received: from SJ0PR13CA0098.namprd13.prod.outlook.com (2603:10b6:a03:2c5::13)
 by SN7PR12MB7179.namprd12.prod.outlook.com (2603:10b6:806:2a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:08:08 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1) by SJ0PR13CA0098.outlook.office365.com
 (2603:10b6:a03:2c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 03:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 03:08:07 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 22:07:36 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted
Date: Thu, 28 Mar 2024 08:36:29 +0530
Message-ID: <20240328030629.820663-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SN7PR12MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: da0a7b98-ff96-41d1-1971-08dc4ed44b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBRuwvovzB61Bb7ylipTPpTh6CRZTBkACo5pKW4UGTY4s6s0oUTb9XtxytsxlklbX0zZigXQC9M0OpqA+LxQP3Q38Mi44w1p9RBbP4pRspvNbEGFPv4sFSEU0ODD2AFGXvU+Z5oEv8Q3t3RQUE/hXB7R05RMr0HLomseohdkwdxxZiQoL5A0KRKxy1AJyJ+uipeSACOO1VQUgM+Tw5TIzNcBH+Yj9imXMAFHaiRBO04+sFGEdTLE4onBe6FyMsQzG/GuV5EPQtTOASXWvm6JaOuHdcrAWCB/FKJePnFworR4rPOtr+1LaPvu6Q46m9joZQWn8B6M3UsEuC5JXk1c/yo7Ow7h39qubnd9FDCC0pt78hPE06QOyz7x9rLeQMU94guhfDtjop/++nfhiN060CMlkAJMjyMPxb/zuHMPAVJDMY18TvcEAAGY2XR0RinbeoDNynp7EC4OdtLB18Zb9r9yITIM7lHkLyuLDKGSt9cNOk9rMy2xg9caCySpZqCGeDHLIdL3Ybr+Dq/mMAlr3H/Rx/FK/6yGCONIampmp9OmEi54LjqZ6n9pvaH5GdS4gLgcQKLpqJjQfrGio7kc5af+VI/5P4x3ZgG9T8rkfqe/qx61QW//vAgthitg9dRf+/hN+2QYYLuGZ/Ld2hU6+PkJ1qH0pwmyO1ZdPBaYSB/xRXdsHwj/03rOTIyMNjMoT3DTwRjpBygT7ArFJXaGTFbX1GMDoVM+DCE3k9UX8vnjSypyGc9OxXS2SKvD2Exz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:08:07.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0a7b98-ff96-41d1-1971-08dc4ed44b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7179
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SOC21 ASICs, there is an issue in re-enabling PM features if a
suspend got aborted. In such cases, reset the device during resume
phase. This is a workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8526282f4da1..a5305ce9b4bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,37 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+	bool sos_alive;
+
+	sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+	msleep(100);
+	sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+	sos_alive = (sol_reg1 != sol_reg2);
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend abort and TOS already launched.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete && sos_alive)
+		return true;
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev,
+			 "S3 suspend abort case, let's reset ASIC.\n");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 
-- 
2.25.1

