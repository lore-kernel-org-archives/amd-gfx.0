Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD01C2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF5E21734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j2ALx/a8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF5E21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 168E56E1B4;
	Fri,  3 Jan 2020 09:48:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D834D6E1B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD+nmXNjwNoLMG1DgAovu5aS/uaFEM3tn5bTo7jpZoaGYc0QkyetTqkmyz0czIoLFFx7UQ9ccScPu5IEknJ1Y73NdzvOREWUPgJpgQLXjXS3VkuKxLqgX8hEBOD1JPLOze2xudLaYiqb3a5A6+/IsbEeil2SbwBKnGXJRpqB2c8JKAs/lqLhzpyeR5zBrtLyJpuWKfnIoOe5g6PhZW77HeQqkktVu1IAR1HUeODoifaejQ2fAx1WmFigQxTnbYTwI7jPFleTxfE3Jjz/LXbXuHFz7o0QYjduQTGNdU6MUkOxFxshQAyPR3SGmpoSUROP2VTEECV2IYh+0u5NUL7sLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRtPyGCzMXuzgoP4v6OgjPPnzKECJ7L1cvSNHQOh1RQ=;
 b=EUNKzTycV8gdZqLHUPOeZvBl7GGRQveOzHZcOT/PH8Q2yz5KJ/i0GM23Ao4jcSvDv7iSGTUGht+xpp3uKr6Q0Y2ce9/EUHODJ/UVvqi3GEy1XmqPp1FUeb+mjq0ZJU5lNaFdVJdszPKyaUQftqmvgDX1bqnjeID50k41VEX2wIum0ReLeWX/MrLfhFNf6ziDcvIwQsAEXKeBKhK8v44ZQ8QZ67iBAMjQmBpla4kOX/ELUjJOjkZlCgLTZFOxaJdvO7sks4oJbIGHTDcXiZ/JnPwI/icfI02RFRlDCpuavec0txU1i9U0Kb95YWpKd6ogz39Dx0KCOtHLbUPHobEFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRtPyGCzMXuzgoP4v6OgjPPnzKECJ7L1cvSNHQOh1RQ=;
 b=j2ALx/a8u6P8sL/crZKOhtQlv670Yi1E9pY7yvgjdNYcVox11hEm/HMj4WuytQeYrPotOmNtetFFDT6QzrBOg4wdmZGf2bj59BIhIKFzlq1Ro35Mm6VXE2b/58HH+k41nQkmP3jeXQmgkRb0A7Vx8sz8aMY6f9XOt17GHTuARAE=
Received: from DM5PR12CA0018.namprd12.prod.outlook.com (2603:10b6:4:1::28) by
 BY5PR12MB3922.namprd12.prod.outlook.com (2603:10b6:a03:195::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Fri, 3 Jan
 2020 09:48:19 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by DM5PR12CA0018.outlook.office365.com
 (2603:10b6:4:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Fri, 3 Jan 2020 09:48:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2602.11 via Frontend Transport; Fri, 3 Jan 2020 09:48:19 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Jan 2020
 03:48:18 -0600
Received: from guest.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Jan 2020 03:48:11 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Leo.Liu@amd.com>, 
 <Frank.Min@amd.com>
Subject: [PATCH 3/5] drm/amd/amdgpu: L1 Policy(3/5) - removed ECC interrupt
 from VF
Date: Fri, 3 Jan 2020 17:47:42 +0800
Message-ID: <20200103094744.2127-3-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103094744.2127-1-Jane.Jian@amd.com>
References: <20200103094744.2127-1-Jane.Jian@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(428003)(199004)(189003)(6636002)(316002)(5660300002)(2906002)(478600001)(186003)(86362001)(70586007)(4326008)(110136005)(8936002)(54906003)(70206006)(36756003)(26005)(336012)(2616005)(1076003)(426003)(8676002)(81156014)(6666004)(81166006)(7696005)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3922; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8905126c-09ec-4922-f2f2-08d79032105b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3922:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39228C4160703664AC057EBEFF230@BY5PR12MB3922.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0271483E06
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9X4BJehCTk6H+9dlZoTjsgbaMEzc7iwB5dS3R7TzFmU2Q/4/TqHhyCr+LRpo31KaxWki3oEbyO2XsVvxS/7ceVSq+6ZcErs138UHGqVyaEHPoE4yIlcbILALUOO5Bzo+F97D4pg5KjGzEDgMmihTRuNX4lYAtEgkjKzHCSCuGMK1ZmMqNVRk99i3vnvhsPnpoEnaA2Eoo0BuMBZbRSZwYeVkIWsBEZ7U3BiVvJYTp5dpRkfrZki1vQOOAMl9RpC/+7Yxyvz9l/0SpBbFW+Q4Xarcx/wxIQpR/uWD+XU3hed1RYytEEbuZMcjPDWt0leBmEZNTPGjiXJuafjT/l5ywL+jaz0nWYiEQ9I8xNGKDGKW/aiKN3WegmHBcLP/FpAsx899sc9ZMCyPUXARsF1MdLa4Fp9Ws7DtFEud8WZ9YGkbJKAbOkLnIhvT+W6btef
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:48:19.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8905126c-09ec-4922-f2f2-08d79032105b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3922
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
Cc: Zhigang Luo <zhigang.luo@amd.com>, Jane Jian <jane.jian@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhigang Luo <zhigang.luo@amd.com>

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Jane Jian <jane.jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2f4a013b3344..e91e2604c277 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -398,8 +398,10 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	adev->gmc.vm_fault.num_types = 1;
 	adev->gmc.vm_fault.funcs = &gmc_v9_0_irq_funcs;
 
-	adev->gmc.ecc_irq.num_types = 1;
-	adev->gmc.ecc_irq.funcs = &gmc_v9_0_ecc_funcs;
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->gmc.ecc_irq.num_types = 1;
+		adev->gmc.ecc_irq.funcs = &gmc_v9_0_ecc_funcs;
+	}
 }
 
 static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
@@ -1117,11 +1119,13 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	/* interrupt sent to DF. */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DF, 0,
-			&adev->gmc.ecc_irq);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		/* interrupt sent to DF. */
+		r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DF, 0,
+				      &adev->gmc.ecc_irq);
+		if (r)
+			return r;
+	}
 
 	/* Set the internal MC address mask
 	 * This is the max address of the GPU's
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
