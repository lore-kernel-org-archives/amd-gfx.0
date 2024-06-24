Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A49FC2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 06:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AF110E0F6;
	Mon, 24 Jun 2024 06:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3tqAif+2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984F410E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 06:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLuk62eqleJ30qpGvcww9K1sH5PLnCqBWJ0UdbUENzeukTjsOkeh9SuptiqERgpVz+kf9tNgJyQWymx4fBiKFGjendmMpaFEim/sWxIHFQCJxw8lVL2FwO2g5w64M68d6xkSCoHKjHWWCTCzxvq5wLD695VSUz1oByptR4cs+LSNgOGl6m8uIg/Wc3g59ZYtbrTtBg3e6ZmFDJah/heIs3L1CHcnajWetjsXxFEcM4vbYlME69Lrnd3CoocZL29B7qkLU2gpk2vcDMDcTvTWawhf6o09Yi2ZTCNT3xjta17UiiSMEizNj/htqIJVT11tRW5JHrJFGx/oRN2iHGegCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crTGDHuPjh4eWIwNIjmtWHsvzO4EQaB7rs3VkUWstQ8=;
 b=LlIjdgeQlP4SdD38clDCoTj4sv/NUqOS3lrlu7uPYFvtlFYFp/B7x9VJ1dl6JldGk4yAzTYbYHIW/t2QZLVsNvAPfgph1ffJWSzaj3WZRR+YYl4UCoY1JDgLd5I41GlazSOV1XFJWOHQmcsZypOcRVkLuQjbvnxlNQ9w4YPLXSWt8Q7/zXS1Uh1ggG3Tk4SUoJOp8xdi5WL9lxd6HkITJKTijo7zacusdysSbfo9GU2zPdPz58oYPOC7xW/6lfQyE6UTtwFz23iOnEiuxDReiwWXCUx2zvMkNb/wC9b51htWfAwSnYJoVyX6lY6DgQcaaAT4J89lYuYqOW9zX+euaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crTGDHuPjh4eWIwNIjmtWHsvzO4EQaB7rs3VkUWstQ8=;
 b=3tqAif+2XjufmPgowwGmdZKVCXFc4ERCj6+mExNOur3VS6bYu6IGLPa47aZzn9U3wGiVPApPUKbcDmXSRXJ3Ja6J210N7xABgK72EKbsLWANqKq6zASVa0+wmAZAXLJ5/cg39918udjRyEFwN+UaFowz6n/P7Z7+SLrLGGVwOkU=
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:49:57 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::20) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 06:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 06:49:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 01:49:56 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 24 Jun 2024 01:49:56 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nikola.prica@amd.com>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit if detected when enabling
 interrupts
Date: Mon, 24 Jun 2024 08:58:54 +0200
Message-ID: <20240624065854.17711-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: danijel.slivka@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 944271e8-6cfe-4205-9333-08dc9419dc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|1800799021|36860700010|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lYUU1zmb8tMfciJ6a6NNG3nLwQp4hfdTKz9VXO54RPLOTWg7AIwLgh2iTZky?=
 =?us-ascii?Q?Rd1FanWjpQf4+bZK5Q28jNK36kPNDett1K/7XdG2r8fKkgBqGWvBJd4KYYgK?=
 =?us-ascii?Q?SV/tt1Ihc4bqak9+TjLNyWdTS/Hu/QgrtxOtznc3X2OzhdBu9BPDeSKrfOLk?=
 =?us-ascii?Q?fTyGii3Sml4g8LVemhPY3wPkaUAJ8jU7+I7vHy82xGWfgXYTpmPDdFsjEJ0Y?=
 =?us-ascii?Q?g1Id084j0lcN04ErqVF6vgc1u9Ov5Rnx1XvD08vWSG1mvvdI+ZnDsmf3Q6ss?=
 =?us-ascii?Q?gDU/3CeLj5PGmIjGCNkRZgnIBjwV9HPkGLDe0oKFodGAwaLj58tCy3AAQ9QL?=
 =?us-ascii?Q?A+HXAAJQqggWDfXLGDmUZmKNOmOFrKw9X17vLyuN5GieE2J/flLShmbjUavP?=
 =?us-ascii?Q?n7E4V7PPYF3FLTeEKTcBvCp1bz9KIZ8/xucojOn4b/eITCf3bJDStVtdpgqP?=
 =?us-ascii?Q?VgJQRjxeAKeryaOKc5DNwpUZWWpLbPDNtvM6H0IDP8LHucspnwXmhhcyaiTe?=
 =?us-ascii?Q?dc4lBoy2/8Tl8Idx4MX6BBfwIcWHEDTw5NMY/dW0DhDpoIG2NvKop4r7FAtA?=
 =?us-ascii?Q?L1w2TJxCJF4qxGEIXCWzwc2hrjEZ360cs5km0aOZk+FDO+lJE1LOBzj2Lbm1?=
 =?us-ascii?Q?ftNMF9Kh5Md90tlW0IC3oOQx2fmT1VVw8dlHbVMe1G/ysZclVAO91oUpTnOO?=
 =?us-ascii?Q?PtLdf9tvDEa0qykeSf3bjAIWnIJysUPCldQCIgxtyHNIW2JgIjNWkOAuBWuQ?=
 =?us-ascii?Q?8z+8CiqnbdJ9s0ZJSzWfLnRKuD+XojD3TtUfgflsL6e01n5OvXRC5+gx04/j?=
 =?us-ascii?Q?P67tUvupLIGvQpGdTeELczHkSgNZIA7Rjmj1vRRc01GaCFqwe7hS2xhlIznE?=
 =?us-ascii?Q?hxw1UfijEKh5nIOTvzi6JfgVpU805DkNsDolOouOsafqiNx9vVHlDS18IeJG?=
 =?us-ascii?Q?ft8xLBVfmGnoia7EDJKS6lYmMUy7fkub4RCJ1wGP02M7Dv2uX0AtjhruTs2e?=
 =?us-ascii?Q?4b7L5ItANXun1ZPLFv35lGMWVr9M+axSSu0zEjsx0Q87kCmM6lzvESMdyQln?=
 =?us-ascii?Q?eUuSH0dMj5d8PvmHDV91LCeHRDbazZI4MwuMc6XB1/ZzNCQvNaTqatOLqsj7?=
 =?us-ascii?Q?zgUxTvxIJ7LnCw8c7/skDDh0Vu8/3pw7ApYDtCsAL+RE7btY3KoIAu+sfWsF?=
 =?us-ascii?Q?FUMuE6I7mev2HIBE+hrvIr+Jv1pqvofb0yprbHMkobASC1aOMP9Q4GjNuhWL?=
 =?us-ascii?Q?vEBOpqLTXDUbL5FcjeBEbngnGt0B41q5RXLOdYatevsPXGthxkADZb9ju0RY?=
 =?us-ascii?Q?YsEDO4w6pzbd96QLcehsQI3N+ASPwxA+Eq0zcdgluChCcam79R/2mhPcexUJ?=
 =?us-ascii?Q?LuMe6gldtrVHD05j6+pKNtf52w4OeoYxw8Ahd5vBaczHDc7d7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(36860700010)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:49:57.3060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 944271e8-6cfe-4205-9333-08dc9419dc77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

Why:
Setting IH_RB_WPTR register to 0 will not clear the RB_OVERFLOW bit
if RB_ENABLE is not set.

How to fix:
Set WPTR_OVERFLOW_CLEAR bit after RB_ENABLE bit is set.
The RB_ENABLE bit is required to be set, together with
WPTR_OVERFLOW_ENABLE bit so that setting WPTR_OVERFLOW_CLEAR bit
would clear the RB_OVERFLOW.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 3cb64c8f7175..44872a8ce6a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -135,6 +135,29 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+
+	if (enable && REG_GET_FIELD(RREG32_NO_KIQ(ih_regs->ih_rb_wptr), IH_RB_WPTR, RB_OVERFLOW)) {
+		/* Clear RB_OVERFLOW bit if detected */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.34.1

