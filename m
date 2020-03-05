Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07CC3F2D8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE6E208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kkyBmW08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE6E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532EC6E329;
	Thu,  5 Mar 2020 13:33:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7436E321
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qep+7hEc+8NpAYDteVCJFx75xudDt0Oz6LH40SXVo50XDatJ4dKp+wQnzdF559SzjHP0UtRwOS3rrJZOnORJqNreGeVwOzWV16DCamoZ3KFHqSslGIwZR5zXZU2mJbCsyArH4bTvmRBZrdRGGvyzEuDbQg+MzWcZS9w36Y9zG7eqgmNmRrQzJk7s6XgCXsFZmaIxlGXpwemu9chFsOM5SIJFYaXqKTrKrc03O7Uyo4gO+V4lOgH5rTmeOflVezdWPZmCMo2KbUiOyMk139cfeskuuzdGvqt2wP0D3aU2czA/iOCCc1u6f7WSgmLXNpQDJ0W77MgY2+n5PFtTQNA48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuWqAv6UI07XyfzBagTjQEHpwO06BDrKgw55Pu/7tWc=;
 b=QwnXyQ0Uw8VMVPCOs52XjwKYTZIyHuSyEB4roQe/X0OKiK5W6ogOAyfRz3uTAxYmxY/kPDlx+hDRXjmkWMiMUZKscCTipM56ssJIeXUv8ZibCnTt8Dh+UZvFkKrm80jtQdvCPovVuk6SYjaY0FC1AqZBNtoVTgXOKJyrZUe5uPhevzNuGsic+CnNWDPd6sNx4cfEGXNy/4DNsFx7Iwjd4ghVpS+BmGBiQAwwvGihId8Y/7g+PApTEjV68bukxP4XdvlrUMW8i/tRiMEFkQyWgPXNf3BQzl0yyrTvLX7BoHbh08+Ur9A5UvNxjGFvSGO4+tSPBRak7p481S33PdaTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuWqAv6UI07XyfzBagTjQEHpwO06BDrKgw55Pu/7tWc=;
 b=kkyBmW08NbXOFW2XSbUzV8gcz0NNqgphBq1wVQ5ua8mFQ+ATeJNUu3SxYp1tP3KQGvm2SXTnQ/LXi+x8st/KzPXqLcxwSxqZ3ZaSZehrASRyiWctCVyzs20izxVC4GLnk4RB1eUyujmZmLKdAxdMzY/o5iGmuDB9zwPD2JQom4Q=
Received: from MN2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:23a::14)
 by DM5PR12MB1545.namprd12.prod.outlook.com (2603:10b6:4:7::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 5 Mar 2020 13:33:26 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:23a:cafe::b1) by MN2PR03CA0009.outlook.office365.com
 (2603:10b6:208:23a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:25 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:25 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:24 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:23 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 5/6] drm/amdgpu: disable clock/power
 gating for SRIOV
Date: Thu, 5 Mar 2020 21:33:06 +0800
Message-ID: <1583415187-16594-5-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(428003)(189003)(199004)(36756003)(70586007)(70206006)(2906002)(8936002)(6916009)(8676002)(7696005)(86362001)(478600001)(26005)(186003)(81166006)(4326008)(81156014)(5660300002)(2616005)(336012)(316002)(426003)(356004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1545; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39bb300b-1d71-4124-107d-08d7c109c85a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1545:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1545254A4942325B9DFF4C3584E20@DM5PR12MB1545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4eTQzzxTL2HU9c70Hd+raeLzZ196I0sxFVdnwk6BAB02EGKmomfnTQTR+wK5BSCXQu+YyviK0Nq8D/lpHPHQxodZhFLjCfR7w4J0Lnfm1RW8ZVMlv1MRoJavGJWGBXYXELiHSf7dFffesKNr9hdK5h4rUF6Dvqalg3ldofwJoKWNwYBewVvLp+Y2jzPR1O6jGV3wbUxP4hwe/acCtxwPFaIiG5FMHoNXXKkbBMHsnYpbEMnNOf0lltY870Lu7ybcI3yX6YX6/ifthl7ktEZ4gsp+HSH2MG72QDCJZ+bGVV/Hyi2hAqW+kQvjHICY8Xk0/7l2JfNWmRpbEA9fkuPucmipVhQNJ4xYi4iKZgpbgFFI4TDRRjrpCYIBTwkh5LT0mDxi5BLzad7yWsT5sHKrSnZ8uTuG69zM52oGUM0RA56NawF1lrM/IyDnnwUW6ql
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:25.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bb300b-1d71-4124-107d-08d7c109c85a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1545
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

and disable MC resum in VCN2.0 as well

those are not concerned by VF driver

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index dd500d1..f2745fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -320,6 +320,9 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 	uint32_t offset;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
@@ -464,6 +467,9 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* UVD disable CGC */
 	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -622,6 +628,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* enable UVD CGC */
 	data = RREG32_SOC15(VCN, 0, mmUVD_CGC_CTRL);
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -674,6 +683,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 	uint32_t data = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
 			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
@@ -721,6 +733,9 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 	uint32_t data = 0;
 	int ret;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
 		/* Before power off, this indicator has to be turned on */
 		data = RREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS);
@@ -1231,6 +1246,9 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (vcn_v2_0_is_idle(handle))
@@ -1686,6 +1704,11 @@ static int vcn_v2_0_set_powergating_state(void *handle,
 	int ret;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
