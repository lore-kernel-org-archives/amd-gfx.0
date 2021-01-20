Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3610C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CCC21D79
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 01:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CCC21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDDE6E045;
	Wed, 20 Jan 2021 01:57:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F99F6E045
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 01:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSeCA05uRQp+Is51ichP+eoQVgOJvaKNEOcLDf8bcruVH+eopufvyBI4D1ij4EhUShwJTLCODEn2Xdb6HqH43SBlSmbVk9aIjWdgfFPgDp8EzZb40cHM45kDxyymbDyg1vlItpIdARHeKf2OcIOvgDFPRP586AJb1i49k6Zm/5Jko9mWazWBwFz11nzKS7zQHC0PUbXpriXSfByyt9SshGZiZzezJBagqOEWe1einT3W7R85l8RS1x+ZTYiA4Py3GLBF8ITiwsGy+Qdpi3YnkhvdPphDmFk/8QexHQuJboYv05kw/A+o2cvRYOWg58LIUOhfAHXREUkdNxx3fs5pig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZeCBwxWKqgXtyNQpURiL4yruJKOO54UBeZFAsxy5RE=;
 b=HF8CIpcrYLSdXSsi/lbBT9J+ymy8VC3+KsuA/OAxartk1Nigg6HebpwZQbekxTuxI0QsAzghoVDXlsYsjlf7524VMfnBa6xEiOmtp21zmtB0PbS74I5aB7lUeS2e23qKjtbnDjrQlMppSJupvGtBMUB6Dn8tDRAfmhjqtu67vVSL6wyIdDREnYHmM4sL+02p/BvLElSI6b3ys7/2kxV+033MgsIUdz6CAOde+fH3EyvZRW6yLaXvnYZ+/6RXiTE/QRBH7/GyDT+XQ6e7Z7Ax9YG4fIorNhmFSZemM0k4JvUYYkz3msPDFqPos5ibnYFYdN23L1sRlGKKX1dAio48XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZeCBwxWKqgXtyNQpURiL4yruJKOO54UBeZFAsxy5RE=;
 b=VeIjD1l9qy1qAvTekErTlWWR+1um4u4DFvdcqEZs+iB2i4OOpjoAb+cBeu2Y5j3RXRu22PF0QIuHv91QPKlCFEJb8DEefeLuLV1dZBiG2U3EfyxmgKeJXRdfnvKrEGkfWX6KWo4gC5LAuQUnRdKrwkhv5fmdvdFyk9G++oTXYYw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 01:57:51 +0000
Received: from CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a]) by CY4PR12MB1159.namprd12.prod.outlook.com
 ([fe80::82f:2413:1026:786a%12]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 01:57:50 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3
Date: Wed, 20 Jan 2021 09:57:32 +0800
Message-Id: <20210120015732.3986339-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:c9::13) To CY4PR12MB1159.namprd12.prod.outlook.com
 (2603:10b6:903:36::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (180.167.199.189) by
 HKAPR03CA0026.apcprd03.prod.outlook.com (2603:1096:203:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6 via Frontend Transport; Wed, 20 Jan 2021 01:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a78d136b-858b-4b3d-bf19-08d8bce6caf2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1413C3849BDF32527A56CD52F0A20@CY4PR12MB1413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7b5tv1Edj7LJyMkCfSoVbqvmlHpo43ZvnO6OoqyBttCiF/PAgz/Mfx3gn0eHuH+zMda1xbB4YlwW0Q7TvwpPuo2be7D7lkCrn6kPTuxScfw+JcE6oReswerJAuaAGDWfY8ntD+epc/4LHII2CwGFhLL2JRR0ixb0o27rpXEfPZNcfcfSCE184eokxaJ3gEzItqnoUze3FAJheKmJKLzITN0snXtzQklBWFLJ3nn2jJmq+1PkvKNXbCu9gEtSKULD6EsmregZ70ia/WiRM7HGogxSSMLvJBCuPZPD1B6o9cy0J8s5Oxiix/bBjQ0f7gBwe9DYkvBalPHGkcAmv2V5PYISq/Wa2WP8rFVJIwEkPOKdsjyTR/jL7qvkn1kXurYGQI1R9UB/UlonUok8IeQXXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1159.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(83380400001)(36756003)(8676002)(478600001)(5660300002)(2906002)(956004)(6486002)(44832011)(66946007)(66556008)(66476007)(6916009)(8936002)(316002)(2616005)(16526019)(6666004)(4326008)(1076003)(26005)(52116002)(7696005)(86362001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tmIO/t0q0t0EhPkNbP1uMZo1z0C39rFgcbnW7mC5fEFV1MtWfo2Ysc6aHhqN?=
 =?us-ascii?Q?Ky2jVvFMV3iABbR2tv5UfErVK3xIbHX6n46vdOY1/YtmxY5U0OPPJsG+xu4e?=
 =?us-ascii?Q?a2V4+rZ8BESprllrITYenvhIqEIHCsnluEllLtXmbw60i0um2oxKGZSFfFUJ?=
 =?us-ascii?Q?fRk6efUUx+5Mm8I+WSwtEsW1lI4X+MEXRqpmHwWtmHe/gGDYuv/JWlM4ma1g?=
 =?us-ascii?Q?+mFX5dgykOKx1wS0PX4wLcVnEdT5+HuFNUHbViFwW9QX6J4wEJ94oWwPa+y6?=
 =?us-ascii?Q?Y06U8hK4OL7VmM3Fe4M92z89LBZQ5T5UiWDXCWDZ1Pj4MkHMkyzLcC2fBRRH?=
 =?us-ascii?Q?HGdLYSk/7BSmPExys3g6EbQbPedzehEmnFuuPeslYNw/aS7E7fA4MggWwuDt?=
 =?us-ascii?Q?Q6HnWDMqeSkfr2SJxL9hAkUTiUkdW3AoA3wbafiE58EA0AiDt6JlytC/FoSm?=
 =?us-ascii?Q?+Ps09/8TKflcK7Jp7wU+HOWwkO4WFcxSl7J8RediN8FSJP6yUr1WpQn5I0O7?=
 =?us-ascii?Q?Q0KT7kpaeT9AnalIZ2L5KE/Nh2ttBI6Z01zCqu3w9fwZ+PaTN8cBWVjLBSDd?=
 =?us-ascii?Q?VAYvffEJ3HVMQ1yYg/QphDUduWqF8WfDPqFyMG6ayl3sGuAjxC5SLdtJWZyj?=
 =?us-ascii?Q?yV3E+fd59kcPDeumnXd8Eoc6WILOf1jrbKR4Z5wE1ZmvPRH3vfOSBvY12Gyj?=
 =?us-ascii?Q?iJlyAS+JNy24wSx4FL5yzhrwjUPKFBFYNcBQ6O9WoyTzw+iYep+BVgJXf0X3?=
 =?us-ascii?Q?tomjeRUesALAJxotBogFhaHj6XVLompXSW58w/piawgS8/lGkgVLq4mA3m1h?=
 =?us-ascii?Q?jW0HTDX5+qa6nDtEYi07Pc4liDG6h1rfZw26TycSAZx1aoJ9pDC/NYhp4Gax?=
 =?us-ascii?Q?q9yQh1tHlvpI/J8lDTg1PGtFIzE6mbPP4QbbKTQos7HKyi6jZUzJ8M12pIvr?=
 =?us-ascii?Q?u4kn7LZr/5IwT1rtqZv4FyKMCunZmuwNRU5r6VHhbKlLHDFZ5Y0Dr5ykYYFP?=
 =?us-ascii?Q?C/YJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78d136b-858b-4b3d-bf19-08d8bce6caf2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 01:57:50.8290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIqPmSikWK8Ec8H0CskJR22JmCynzlJdlH5xeuJh6OqFNoKrHl3Csp9ulSXo6sru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from vangogh, the ATCL2 and DAGB0 registers relative
to mgcg/ls has changed.

For MGCG:
Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.

For MGLS:
Replace mmMM_ATC_L2_MISC_CG with mmMM_ATC_L2_CGTT_CLK_CTRL.
Add DAGB0_(WR/RD)_CGTT_CLK_CTRL registers.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 84 ++++++++++++++++++-------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 92f02883daa3..8f2edba5bc9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -492,12 +492,11 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data, def1, data1;
 
-	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
+	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
 	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
 
 	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG)) {
-		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
-
+		data &= ~MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
 		data1 &= ~(DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
 		           DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
 		           DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
@@ -506,8 +505,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 		           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
 
 	} else {
-		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
-
+		data |= MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK;
 		data1 |= (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
 			  DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
 			  DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
@@ -517,7 +515,7 @@ mmhub_v2_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 	}
 
 	if (def != data)
-		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
+		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL, data);
 	if (def1 != data1)
 		WREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2, data1);
 }
@@ -526,17 +524,44 @@ static void
 mmhub_v2_3_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 					   bool enable)
 {
-	uint32_t def, data;
-
-	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
-
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
-		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
-	else
-		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	uint32_t def, data, def1, data1, def2, data2;
+
+	def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
+	def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
+	def2 = data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_MC_LS)) {
+		data &= ~MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
+		data1 &= !(DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
+		data2 &= !(DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
+	} else {
+		data |= MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK;
+		data1 |= (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+			DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
+		data2 |= (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+			DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK);
+	}
 
 	if (def != data)
-		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG, data);
+		WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL, data);
+	if (def1 != data1)
+		WREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL, data1);
+	if (def2 != data2)
+		WREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL, data2);
 }
 
 static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
@@ -555,26 +580,39 @@ static int mmhub_v2_3_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
-	int data, data1;
+	int data, data1, data2, data3;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG);
-	data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+	data = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2);
+	data1  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_CGTT_CLK_CTRL);
+	data2 = RREG32_SOC15(MMHUB, 0, mmDAGB0_WR_CGTT_CLK_CTRL);
+	data3 = RREG32_SOC15(MMHUB, 0, mmDAGB0_RD_CGTT_CLK_CTRL);
 
 	/* AMD_CG_SUPPORT_MC_MGCG */
-	if ((data & MM_ATC_L2_MISC_CG__ENABLE_MASK) &&
-	    !(data1 & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
+	if (!(data & (DAGB0_CNTL_MISC2__DISABLE_WRREQ_CG_MASK |
 		       DAGB0_CNTL_MISC2__DISABLE_WRRET_CG_MASK |
 		       DAGB0_CNTL_MISC2__DISABLE_RDREQ_CG_MASK |
 		       DAGB0_CNTL_MISC2__DISABLE_RDRET_CG_MASK |
 		       DAGB0_CNTL_MISC2__DISABLE_TLBWR_CG_MASK |
-		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK)))
-		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+		       DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK))
+		&& !(data1 & MM_ATC_L2_CGTT_CLK_CTRL__SOFT_OVERRIDE_MASK)) {
+			*flags |= AMD_CG_SUPPORT_MC_MGCG;
+	}
 
 	/* AMD_CG_SUPPORT_MC_LS */
-	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+	if (!(data1 & MM_ATC_L2_CGTT_CLK_CTRL__MGLS_OVERRIDE_MASK)
+		&& !(data2 & (DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+				DAGB0_WR_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK))
+		&& !(data3 & (DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_MASK |
+				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_WRITE_MASK |
+				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_READ_MASK |
+				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_RETURN_MASK |
+				DAGB0_RD_CGTT_CLK_CTRL__LS_OVERRIDE_REGISTER_MASK)))
 		*flags |= AMD_CG_SUPPORT_MC_LS;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
