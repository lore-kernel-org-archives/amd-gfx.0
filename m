Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B19C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EDB20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wwwkCd86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EDB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777536EB2B;
	Wed,  4 Mar 2020 10:52:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5EF6EB21
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 10:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNncSWqHQj2ir1uV8XwUYiE1GXStHNcfAtWgXQ5nyrgF1ANur8ly5ok1w1s1fJWC1BXGXYU8IeBd+I2ij3HF29HdOokQompwuYdeDZk3r5qoxqcBYAu+lqXSJzLkva6xigLVxzF0I0Z6Jeu4rTECICQoOpKPuH60tTXfKwTKH2DNq2XRBkutkxyRBvz1UoQx7hemSg58/Y0gGbHFaZaAiTD6K7OL8b4DH5ZQu1NSo2QGFDhy2z86E0NOMK544BQDv7+jghKxUfZK9YpQ7k2o10a6RgkOE3Zz5D/YJ0NvwRy2vFpeU6zXVdp5o5vvR1/0PTeF/mT6zRDRony+zEglBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNaVxwS1dEiX2f9QC3MOKzJgM3Jc4RjdhqecZVAa148=;
 b=cIDiCSWUpm3eZ0RX0QsXrZoOBUuHr0b/I4t6mo7gfZyPTXifXYpXV2XShLXUAxdEPt1Ukatu9RPFYjX5KLJC/6AbW96ps9MVIcPEjTPdQenzmtmLHgfoUFqzJjpqwo3SodL+Rits4BsyJG7cKaX3QACWhvZBTnLq4cMdhf2Bks7keP04aPHIq5hxt4gVqQnA3IFOTp6WDpa7J7ryC9F4avDo1fX0uiJi0BQ9GyNv8E8eQ+2g529bxw6Dowq82ONs7AMyxqAVF2qo43U6AjXgsKjpsgdeJH1gUOpd9RJhl1dJ4flVoCOx5o4n9K9a6JkEypqAE43NeG+Vwfwp7HQzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNaVxwS1dEiX2f9QC3MOKzJgM3Jc4RjdhqecZVAa148=;
 b=wwwkCd86A7c4EfAngjG5rv73hJSzrExvxgGzHX2xeoG4sNgs9tfuOjekDe57FcC75S5UAOgwmVGPaUzMzTdRdxFj2hJ9irhFjLWwusF+Si9VYF4G4ENJU53DWJ0dXVIBI6DdHmizyzGed1VVMxQydO3Z2PGONrkEx7zqJj0Ka+0=
Received: from MN2PR01CA0022.prod.exchangelabs.com (2603:10b6:208:10c::35) by
 BN7PR12MB2625.namprd12.prod.outlook.com (2603:10b6:408:2b::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 10:52:26 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:10c:cafe::46) by MN2PR01CA0022.outlook.office365.com
 (2603:10b6:208:10c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend
 Transport; Wed, 4 Mar 2020 10:52:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:52:25 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:25 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 04:52:23 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: enable PCS error report on arcturus
Date: Wed, 4 Mar 2020 18:52:03 +0800
Message-ID: <20200304105203.6660-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304105203.6660-1-Hawking.Zhang@amd.com>
References: <20200304105203.6660-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(428003)(199004)(189003)(2906002)(26005)(478600001)(336012)(6666004)(8676002)(81166006)(81156014)(70206006)(7696005)(4326008)(8936002)(70586007)(186003)(356004)(86362001)(110136005)(1076003)(426003)(36756003)(2616005)(316002)(5660300002)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2625; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92338fa9-6b3c-45dc-6be2-08d7c02a2054
X-MS-TrafficTypeDiagnostic: BN7PR12MB2625:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26254892A8525CFCF5E6FC00FCE50@BN7PR12MB2625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsYeQK5D4RxlJwr2QqpVLGVIdd9Bzoyse0MS5sGIA5rf9dShFYa8hNw4+EBpZX/O9h6Riz34sFnvv1TD6zmh4l4Zu4IbjKz/wnak1954W+1I8lBqGTMNklel+bL9Tz6p+RKO75G3Qf54lNTbTf14K7ABwf2FOqsR1KFJS32dUHb1zfx8pj0dlJ926e7B1k0YyeDXwgl4YhJ5sZpmIuW0D1zDVd9GWFcvjE5qKZgud1/DnLh0H/XjWPJDpUMQv1i7FckpVKiAWgQVdRk5qaj8EeqElkv2nKrQzFJVAXhXLP/jkbQW7AZpDzX88j15R954cMYeSZYTt5dRinci+jw8cPWbjQcusNUuzoJkkzWGzDuA25yzh0AieNRn/RtYJSDkNeWGS5TS+eF5Wf4PBsypnThHhq1p3CdU+wXuKQlo2lFTeJ/t7Nd24XLwBscPld1m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:52:25.9347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92338fa9-6b3c-45dc-6be2-08d7c02a2054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2625
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add arcturus xgmi/wafl pcs err status group to support
PCS error detection and report on arcturus

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61a28f8ec34e..4ade71330c83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -51,6 +51,21 @@ static const int wafl_pcs_err_status_reg_vg20[] = {
 	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS + 0x100000,
 };
 
+static const int xgmi_pcs_err_status_reg_arct[] = {
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x100000,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x500000,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x600000,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x700000,
+	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS + 0x800000,
+};
+
+/* same as vg20*/
+static const int wafl_pcs_err_status_reg_arct[] = {
+	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS,
+	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS + 0x100000,
+};
+
 static const struct amdgpu_pcs_ras_field xgmi_pcs_ras_fields[] = {
 	{"XGMI PCS DataLossErr",
 	 SOC15_REG_FIELD(XGMI0_PCS_GOPX16_PCS_ERROR_STATUS, DataLossErr)},
@@ -679,6 +694,22 @@ int amdgpu_xgmi_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count = 0;
 
 	switch (adev->asic_type) {
+	case CHIP_ARCTURUS:
+		/* check xgmi pcs error */
+		for (i = 0; i < ARRAY_SIZE(xgmi_pcs_err_status_reg_arct); i++) {
+			data = RREG32_PCIE(xgmi_pcs_err_status_reg_arct[i]);
+			if (data)
+				amdgpu_xgmi_query_pcs_error_status(adev,
+						data, &ue_cnt, &ce_cnt, true);
+		}
+		/* check wafl pcs error */
+		for (i = 0; i < ARRAY_SIZE(wafl_pcs_err_status_reg_arct); i++) {
+			data = RREG32_PCIE(wafl_pcs_err_status_reg_arct[i]);
+			if (data)
+				amdgpu_xgmi_query_pcs_error_status(adev,
+						data, &ue_cnt, &ce_cnt, false);
+		}
+		break;
 	case CHIP_VEGA20:
 	default:
 		/* check xgmi pcs error */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
