Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736DAC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C7C10E3DF;
	Mon, 24 Jun 2024 09:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NVxLFTUM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4393410E3DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiZVlJEyzeKPPxQmct/EBbZ4AkPD0/AE8CTN8nUuTR4k5EiOhEXZNdHNZ/P6uR5vdKK/h1w0EIJbbIwMPsL/1vttz19StoK095DZnoPGvHQWE2cwk98uRLNq4zmfqGewAkeGT3cXWla3jnH0wjGezhUnXaLf0UkyxGW/I/XlKAN56JL+YZt9ZAD5gEIa1x7OR6aRpTybwrTEJzYfONhVoB5BA3ZnVabx0H8xhlQJNfQbRb/8aweg7axQlHORullEyPbPR7YDXYCjtAz0odzohiRgE3ftpeJqo1WouYDrh0gSpmVtgr0OLD0g+WJrC74d454W5EIwHktOb4pQCUxXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUuqN6QzLuxwevEu+cqweBv4clas3YHuDRp6lg0zC1Y=;
 b=IjaPfgnfj3EUzPcSEK/d2F8i5R9Jn3wcoV65KT3f/pd85Ur0oyRlDYwG910H5fyuCbT4ZDmFfvKTzRMzxS22zHJiRXGnpYVyT1qCr0D2K1DNFji/JL5q3YzIJaslilJpxnYFL9iFW9J2LDIvr292UdYYM3//oQTg9Q1ZrvuaXLn8MZ8BpuGbEiXW8fd1W7VoQJDGBNtGy4NgEthhhY/nDzyNoqWcSowIUxczCwSMU0swof7YBkFMgFSlEW3oF2dfRC3U/CsZpt8yCK1pEb0wwHQ7sAt1ki2gkUdKGAAJcJ3QWDt24MGHS85VitL9FG+L8bwu4AwuHONN+nKjZuouww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUuqN6QzLuxwevEu+cqweBv4clas3YHuDRp6lg0zC1Y=;
 b=NVxLFTUMGPioE1hzzQX2HM64kcgOaZx0mpznaZJeEpDqxwmOcpj8Se2YJADQae5AsriLL25hJsKJHBPoFMyddgiw6REiXbEW1ScyAibI+hw877XDDeYtqOgiIt8VrZOO8UFPXoYTAjeQklw+WXIBuNM1ADRpJ5atK5T6bP9rgSk=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Mon, 24 Jun 2024 09:57:41 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::d6) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 09:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 09:57:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 04:57:40 -0500
Received: from sriov-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 24 Jun 2024 04:57:39 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nikola.prica@amd.com>
CC: Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts
Date: Mon, 24 Jun 2024 12:06:49 +0200
Message-ID: <20240624100649.14971-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: danijel.slivka@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7fe661-c62f-4404-d9c9-08dc94341677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|1800799021|376011|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pdr9PGY9N+vLGphC96gWC9vSB+45R/CK6rviSJ7P2G5Idp5lkDZYypVmtDP6?=
 =?us-ascii?Q?XknJfaeCju16pUT1l7YRmuZLmFUDayoDg0gGx22HY2b+b4JuRXM1OlKcW5hu?=
 =?us-ascii?Q?XjY2BD+zMstNWFaPepk9llC6jWt9QySeg1N5EqzQ+FnmWTUg2B8qPGVRqRqJ?=
 =?us-ascii?Q?Ad/XxULqI1GFrzI+zJ7pNJ6w4j2lypet7d2ffRySnLRE/jO1FmenBj6AwlUA?=
 =?us-ascii?Q?KGh3Ge5esTkYHM39FUFb6RyHhGYO84DBXrY3CaZbi/4pSXIL79dcJ5OJjjSo?=
 =?us-ascii?Q?Yo93sv41yqt2L2iDfmI03qzch+tkdqxNneC5Y3H8jpEJ35dfLG6bgzsFlYPo?=
 =?us-ascii?Q?9JPnX1JB2SZ8AhteQbMeWV1fixKFVHp/QhqH9gZU3pYAlEiF3cAg4MTzAiaP?=
 =?us-ascii?Q?sV2aLo3NbV9Ti5wSTLVPsVDZCHEhTnVaO8L4cz+QIGzCTU+WiKYX+tICqeTo?=
 =?us-ascii?Q?WGxBwS9HnGKleBB2DDcP8lL90ypadaLHuL9EpFrMbNV//SASzQcRflWOolte?=
 =?us-ascii?Q?oYX3Ty0lXPBN4LOXG/h+QcmHsp+z0X+oIEK4RhhqftdzYyeDoFCQymWvIkCo?=
 =?us-ascii?Q?YZHLu8BBjIhWp30/jwYyKOVli7Vnh0c8Lfj+hMR+lLTUpV+P0GaneGXWnuf2?=
 =?us-ascii?Q?JOVjwCRg1tDh0T9/2wljrlJ3vA3BM/wPCrvTA3b73brmtfUPSM1t0vzF4Pz0?=
 =?us-ascii?Q?RtpjDMlhL3hfqJaSZKCJY3HiwT3LuAXGc6FLR/nPMqXk09u5rL3mL83WVf3R?=
 =?us-ascii?Q?tb4x/0NnSJu4/8qUvhRseotVxEU/JMawXolTzuU688B579wj0p94XNq4o+sP?=
 =?us-ascii?Q?QOg9RnL273JO2tx7lD6lBK8ssZRgxASt9lX7pRMERkkTPvDFhEsQA2aHhPgg?=
 =?us-ascii?Q?I2C/BowawjhzhajGVkwLARzSrDSFR31Y/6RiHAT4w3c86rQ2qO/d5zbjhjZC?=
 =?us-ascii?Q?Xu1UoIGaXUl/lHdZ4q7gQVG2u7YxAflnM7cNQwvEb0xFfogpTaYAQFmoEQ0d?=
 =?us-ascii?Q?vlWbf5UVue4USN9kXnjuGtZK8l66Uvj2T9HL/uAMs1C2tONTgoPmExC4jinB?=
 =?us-ascii?Q?8xICvEsAVzq7+Z3XcFXdChQ8OUDAz8zO/gf04id5h5UYHBNAmvxE0z5nJbDK?=
 =?us-ascii?Q?IF3E//SciAqKpj1uB/AhiqwWOXK6EJg5SebOm2F4hVJiA8ozG7F5LNeNlkfe?=
 =?us-ascii?Q?qhR/1cbg0pJ/YLNBkgczOrgeaJsV2GFmH6l7bFIcnX4VJ4XTuEIjJm2R5eGy?=
 =?us-ascii?Q?T4A5wp9oiQyu8VBYxZ0jb262Xrl1Pyn4Abmgp+oQvNT6q7+KXSQr/YDaF8NJ?=
 =?us-ascii?Q?qTK5iXUs2AKaEx/K0h80IV34ndKjtMG0+82KiV1+GXqBFIHzaHObtBqDaEgZ?=
 =?us-ascii?Q?qzQjNPAP7P92tAX0f93/mB7L8d3SqI78fTqrUM3FkYMb6wUDug=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(1800799021)(376011)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 09:57:41.4837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7fe661-c62f-4404-d9c9-08dc94341677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
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
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 3cb64c8f7175..cbc70016f479 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -135,6 +135,40 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+
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

