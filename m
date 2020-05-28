Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1E7C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16382088E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RhHHMFJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16382088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645156E0F8;
	Thu, 28 May 2020 09:03:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B756E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 09:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7f3rgmjC8Tuf5YlG+C60aQMhO4XftW8aPR2gRQamizZGDLwiJPlRkCLmzyu2U/6ELfYLq0+M1ZxL9vXGv5E32SFWW8dMHiibhbf82Yb7SyHWAkYJO4FoyqiDxt+IPsdKuBQyhj8uPsNTGDVTRZENNf+z5/58qA9yeoJ99PRV9XL1SXAxzx4NQLeHqOdZaYgo0ngK3+iOSztM8h/Qt2vqHcQkr3RayIS+PN3VizmWOiWCYbys2p2J66Ngd/bYhOOvz6KQAyQ5/DK6BLpHOf+ToYXp/ZhZyGhBQCYoSKZRmAkz46paenDmqWUOK8QaNQpoFIfer2yi4fuOvb9XDHevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5++lH0sdr3R4tN03xWAn34Cii+X+ARmylt+JD4HE1HY=;
 b=Uy5UeoQfVKrA7uGbWfxqEXl8IWt1Eh/dCVx+M05DN0LntTqbDiWRyeUUPjGw0evyBx4OmIrrlB3eScj1Eb6VXn6s26opTI+hpYx61f4D3Dtvdr8tIyBmD59clOYhHuXeG0qDEGnrb36WMs56/dUPAXvtczlAr1hajKCeCRFJscx9S2xWiBIAs1vfryfZ3qWUKJDocDxkgu0fWORrX+KMr8zthMo80jWtcVe+6P1hotsUyZhfzQRC3OdZpQ2Pdcim07uB8pMevxmwi3bH+4Ud+rU8xct8E+vYixdXIBwF50SWhi69HOuA7dlidcwa7DgKqMEC9YX9QDQ0mbU/83tRTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5++lH0sdr3R4tN03xWAn34Cii+X+ARmylt+JD4HE1HY=;
 b=RhHHMFJL+IiyN2i4hA7Zd9UzDlq//FtvieVk75XDPQ3lMq886VEoEAu22VES+gv4kB96Uaz+IYuP0s4JBuglzh4pDQinbb3xPULMz7h2zPaL7nztX8nZ3z/o527Jj+7ieYtnxgXPsX5+xh5xAG3GxpAXRFeTVq0LCrB60ufKnFY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Thu, 28 May 2020 09:03:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.029; Thu, 28 May 2020
 09:03:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/powerplay: use the common APIs for IRQ
 disablement/enablement
Date: Thu, 28 May 2020 17:02:40 +0800
Message-Id: <20200528090241.25291-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528090241.25291-1-evan.quan@amd.com>
References: <20200528090241.25291-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 09:03:04 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d227fc55-8a94-47ee-2094-08d802e5eee3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353E66BB9F839B1B03B80B1E48E0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0JVTUhaNmKZwzuHZRLj5qlZGDA244uGQBlIE/tmfwPirazihjC4xAhNwSOZrS2r/ZE4B6oxEMCMipMd9jZyINhsZL40M2/RqUL38vFxg0RhMVBoWLSkIO+YobHGvXNN3btsb+O/4f2pyQznegOyM6GjEFN/lj19H8cOPGjwRYcv6jya/LmmnUhsIAxQOVhp7HqsaZZ8LX89rfdTSGONqvT9UrF6ViPrFv3SszLgwce9M16A3Mwy3YLkxUO0TGSwwsft8KXvZhD6ORJox8azw9mCLz9+d2gVnrvCA7sFvCImYuRbbma6/77tLNUhOaO08VIVAv63KWkzVeBMEhs6EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6486002)(2616005)(44832011)(66556008)(66476007)(66946007)(4326008)(5660300002)(2906002)(186003)(83380400001)(1076003)(316002)(52116002)(956004)(36756003)(7696005)(16526019)(478600001)(8676002)(8936002)(26005)(86362001)(6666004)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 89+6U4gk37NUV/QTpm6Ft8lAOIVcRDgfJm3e+C45lFYLeWcnQo4TcaEjz0qRjneS/1OI8OshweaiGvPAHeSuTzU0xVUpNRrRSQRlj4iykW2JDN0CjfYhRunZ8ACK0fFCqZpshmgg7jl/Jbt2Vkr3qPGeVO9XQdYJEwKpS2d+nb5o04zLQAKRKLlQBN5UeflS3d1RKu/BIyFmHlpi/wWjMd2hnhfl2DeDMWAJ/p+vAKDLDiReDLQ8AkY28strYqZVfN+DXPcxEDmBSk23m8qcbInejV+FGe7Hl2qEFT/TL2gjzMDmeqDTLOXcIbw0GstyhVXm41QsnbIMQPc18iO/elf4jUo3IKKx7SO5YftyGt5fwhQBlfGrffFSmu/+S7UBmoK+H0dsU/OO0sPCWvdzq7g4fu5JoRoXb+Gz2EnQLu+50+zCWRMx3JhXet6Gza0+EMVCKk7sut8YYhvyKT6KxZeQMppRne2ytLaf3/eD22ULgJUxFSnfqZyVJQWBEaJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d227fc55-8a94-47ee-2094-08d802e5eee3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:03:05.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGUPuwecArgx8TReiVY4HmKDQMkQpbMSi8ztNtMcr4YN9o3Ebdqm1ugF5y2qe0Gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also the new logics for MP1 SW IRQs disablement/enablement are added.

Change-Id: I57ef8f21ab3d51aa0d557f511d89f5fa2ce08144
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 79 ++++++++++++++++-------
 1 file changed, 57 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index edc9782743d2..728965ab6d83 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1167,8 +1167,6 @@ static int smu_v11_0_set_thermal_range(struct smu_context *smu,
 	val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
-	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (high & 0xff));
 	val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (low & 0xff));
 	val = val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
@@ -1178,20 +1176,6 @@ static int smu_v11_0_set_thermal_range(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v11_0_enable_thermal_alert(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	uint32_t val = 0;
-
-	val |= (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
-	val |= (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
-	val |= (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);
-
-	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, val);
-
-	return 0;
-}
-
 int smu_v11_0_start_thermal_control(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1209,7 +1193,7 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 		if (ret)
 			return ret;
 
-		ret = smu_v11_0_enable_thermal_alert(smu);
+		ret = amdgpu_irq_get(adev, smu->irq_source, 0);
 		if (ret)
 			return ret;
 
@@ -1233,11 +1217,7 @@ int smu_v11_0_start_thermal_control(struct smu_context *smu)
 
 int smu_v11_0_stop_thermal_control(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-
-	WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, 0);
-
-	return 0;
+	return amdgpu_irq_put(smu->adev, smu->irq_source, 0);
 }
 
 static uint16_t convert_to_vddc(uint8_t vid)
@@ -1508,6 +1488,59 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   unsigned tyep,
+				   enum amdgpu_interrupt_state state)
+{
+	uint32_t val = 0;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* For THM irqs */
+		val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 1);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 1);
+		WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+		WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, 0);
+
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 1);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* For THM irqs */
+		val = RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTH_MASK, 0);
+		val = REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_INTL_MASK, 0);
+		WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);
+
+		val = (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
+		val |= (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
+		val |= (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);
+		WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, val);
+
+		/* For MP1 SW irqs */
+		val = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, ID, 0xFE);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT, VALID, 0);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT, val);
+
+		val = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
+		val = REG_SET_FIELD(val, MP1_SMN_IH_SW_INT_CTRL, INT_MASK, 0);
+		WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, val);
+
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu)
 {
 	return smu_send_smc_msg(smu,
@@ -1593,6 +1626,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 
 static const struct amdgpu_irq_src_funcs smu_v11_0_irq_funcs =
 {
+	.set = smu_v11_0_set_irq_state,
 	.process = smu_v11_0_irq_process,
 };
 
@@ -1611,6 +1645,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 		return -ENOMEM;
 	smu->irq_source = irq_src;
 
+	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v11_0_irq_funcs;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_THM,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
