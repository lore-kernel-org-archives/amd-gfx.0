Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B04D1D895
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 18:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 764F610E14D;
	Tue, 15 Oct 2024 18:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLf9ToLe";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A9510E14D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 18:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBtlGvgIwD1sGV0+Au1JzxlifX7txnS17iagu2Ndc/C73WgU0Efck6A/58+iXUTldW9ig1BMQpVSowwszM1D7jLFgQrW0QpVlJCAAoc48e7mEv6rbmovTYJW+dS/MktB+Qq8xFpbGgsf8toQKzeVGKTtMu4LrCnZGEcu0MPnfVlGVsG4Effk1k+m84kmEkqJ4mKxKt3jiFiT6T84EG1ttLgShrLM5ga4bLn3pI2uJOtihICmRtjZLpLIH0XGC+u1cWBE33eEmK7G4lyYxA4oyLfkn65wX62Z4Ds7AT0khO8dAYXIxNhkQiU+HVlHA2yW2PpgkheLxqc2CKKfoY8VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x73C+DUoJG3+MGDn1rsIGdxt9MfORdDz8Au0Pj402cc=;
 b=nslW1oyPQn7BxZsfgdCvKk+W4xUGeprFBblZmMy6P+m4OGHsXuN0UnUk2yLWItKm+aRRAOZpggCNwPxMJ0M+cxR9UqvnB54WcQ3jmxgJDRco4TNU65mb8JDVa/AFL/h/a2CgIP6r+VE2WOpNB1Y02jVwzGI0cVxs021lBlmu0xGjj5T7WuJIXudx/4imo0jzpswj+fhzUwGDoaurQFBO+ouC5S4K2xDWEp3o3SApFYAbxEfPOeFXRJ6zkobDK5jLfsmZpCRHzw1HoMsbGozUXM81VF8eakcIySUQOuwjac+F/Ek62gBO2h/63kLHnOV75Y6Mch/Ak89nS3O2GfpRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x73C+DUoJG3+MGDn1rsIGdxt9MfORdDz8Au0Pj402cc=;
 b=FLf9ToLeBGy2ZCdAYI2D5uQ/Kq426LONZveVdtJm3c0NOcnxKUX7Dfwd3bt6oyz6O2IQMRWl0uhmRGF4uysPBgc33cRzHT04Q64MFdM8voipfo2mAeFtsogMnMTJWPjgXLWshNSVThptX31kEhmlGIZIwC21e2mOdsy3/I6kwOY=
Received: from SJ0PR13CA0141.namprd13.prod.outlook.com (2603:10b6:a03:2c6::26)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 18:13:54 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::bd) by SJ0PR13CA0141.outlook.office365.com
 (2603:10b6:a03:2c6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 18:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 18:13:53 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 13:13:52 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <danijel.slivka@amd.com>, <christian.koenig@amd.com>, Victor Lu
 <victorchengchi.lu@amd.com>
Subject: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts
 for vega20_ih
Date: Tue, 15 Oct 2024 14:13:35 -0400
Message-ID: <20241015181335.2327-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: ad63789e-3280-4d32-9f63-08dced4520e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A8PxYALAciQkU4nLJjGmvEZvaLeN8iOonFy+4R3CIYmOkBn2Hz9hy5/lMCoE?=
 =?us-ascii?Q?jNCosJrY6Fi9J2J+kUL/Ddq7khK6O5DW93Gae6B7Z3PhSC1Ps+vywWmrZySu?=
 =?us-ascii?Q?sK9jG+9zeWueUTGYZ2BFvwWwzabCDM0e0FLoxWVSVFJcAb9SMBwNj4eTIdOu?=
 =?us-ascii?Q?Xfgest0t242vjVeoBtDK81I7pbFkDBoTg5QI04HXEXLLlME6gqNMp5aojV/1?=
 =?us-ascii?Q?tblEIvPjTDo+Ya1Rv2V9RFkGvfa38xjsAZzkyiD8Da5B9L2Ncfx2fhI3p8OJ?=
 =?us-ascii?Q?ccw/PiCyFVi//PDqf3tWsx+GSh01zSdNw6eF0plRufCp66Kug0eqYLM5zLM7?=
 =?us-ascii?Q?asO0DSRl3XtIKwSMUcINkl4d9I63ZPVUWyeumNtYSZWRtKT8xKcg5vBqFLIz?=
 =?us-ascii?Q?Nk3Kvh6dChIlPETO1gJ95MOWl3r95mCmNS++x4vzZtLSBoRNl1R6YqCVKxnu?=
 =?us-ascii?Q?RGty8RhC66Aqw55CHhkkqG6Y4ZY5rx9rIUPMIoiRSapj7ELbF1ybGoa4mbjI?=
 =?us-ascii?Q?H13DPAzo/kONSN+87i+iBYJ0l6jZ41MS89iaCw91ogq+LrZnTWksxfvlv8LQ?=
 =?us-ascii?Q?C7RM3wgS/u66rkIqQVFiuVHAiQ2Jkyl1B1db3M+b00ZPvRFtARytrf12EOd7?=
 =?us-ascii?Q?5Onotc4Y1qcd314F1+XfC53HbcLyMcwCrfsOwjyP+Tb/4HGzACFu3VT5OOwn?=
 =?us-ascii?Q?gxW4eiL4Lp6wbqM9QRjlBsX58vHu1287zzneUmfPRKzohQiFoLzmRvcuuBHT?=
 =?us-ascii?Q?D1NAn/J1mNrkWt/E0TWYdBR8BN3pmV2KUA76RUXZRBdrTsVfuLsqCGlB0yiu?=
 =?us-ascii?Q?+mRYgIdRcYKRolpDKSyCUoNsLpkFK+fv8GWW8deCJE0viILyXjQdriuhuLpi?=
 =?us-ascii?Q?y60OY4teGK0haQMttUNhqsb8giIbQ14RK3860A47ErI/rHjJOczi+CYLhCPc?=
 =?us-ascii?Q?OAnPkNqLnLfzV7/lu6k6F5fEjZkhxvj5+bwHDRGrsbsh9tbhch1EFJDmjvul?=
 =?us-ascii?Q?Eu11BgZN5S/Ei1EzfABaYekOH9uJ3T8SUNwFRXs5eGxWcOLt8BuT5N8Xjjyv?=
 =?us-ascii?Q?OQHXTqGthlZJF4Oa/dp8cIpdsOiOYBL0WnUuHmUFsNGoaIzSCS7PNmHiKkiv?=
 =?us-ascii?Q?2jYuGHhn/hmVdi2aUdQ5gPlDHoAIAtCbEXINDpKk8ISUySnUOP0kz1lp1ikB?=
 =?us-ascii?Q?rtc56q4rrp5KcMwI7k5HyLxJgo68PEoNDKkmTO8aXh28TFauxuGciX0lwyLu?=
 =?us-ascii?Q?D65h/tX5bXP1na91WXhrnBEkoK/DvVtW7hPzaxztuBMxDgdTPbMlpJCjxgI/?=
 =?us-ascii?Q?PkOoeW2ZJ8uYqVFWjlWy5wltmKW1Me4pTgPZgBJn/if2jhlqJJNUr9o1zTfd?=
 =?us-ascii?Q?kkTUi/Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:13:53.8651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad63789e-3280-4d32-9f63-08dced4520e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
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

Port this change to vega20_ih.c:
"89ae318001e5 drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts"

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index a42404a58015..a71552ffe0f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -114,6 +114,33 @@ static int vega20_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
 
+	if (enable) {
+		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
+		 * is switching the bit from 0 to 1
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Clear RB_OVERFLOW bit */
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
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.34.1

