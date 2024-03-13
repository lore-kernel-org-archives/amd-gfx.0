Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D06DC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 09:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A9410F723;
	Wed, 13 Mar 2024 09:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3W9dvDnd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0097110F721
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 09:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgfWi/BsUcb58Vpd75xNlIVDgZAzJpmJJzXcLDa4Zetsm+/W+mue4fbGFXZTDYmyPFdCoYSjhXVr7Mtr4jIpNu5RuaCIIRSKodVJ0oIODj1+msE08vQI/7JafN14hljGQh+ZQE8FpnjFZLNkEs1fDQDz3DvDvLGJl/Q9+hh9VSptMFrJW3P2KATIJxfONutyrm2dPruX2Ns/L7q3C7r+cweJbv2RE+bQpCTigKk08rOkh1TIvA6zOC0huPTyyzd1O2hCMWOLCa6GfdVBziRIMN8KdG1HJOE/6jtslfvl7iPImXwBzAya9oECotshqo6mH2VUQRQaSTGasN9roIA3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN/NktmIIVZBbL5pPJ/k1u948vuOyIRLWEu91i4KAVE=;
 b=avvrnhyoyn39lx9mnnHT0R8xa2E4KFY5KVPNH07ma0mb4Fj49QNoZ66R3REgzL/BqOVyamwqd3tPBri2LGklyKpDj3pj52pjKQimj/UNAdkC4kqjq/3ZUOyjuuKXSrmshA5IVGkPtbekWajjq7OM4HYZplrTSh8rPwu3gvbBQ68WAlZ3oQXXZm4vQdIU6IdvLWVrRqnUi7Fa9vamZDP2UBFabiWct++naFqIHwiqcH4TaD5muWRyivXDQaFVV87Dk+8CSrVQPLPFo0lwWezQbjSX9w7xX64aq6vyZRVMT1Hn7kaNyliE10+BBKSbHHCMiXbo+dUq5Ux0q47pwYqznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/NktmIIVZBbL5pPJ/k1u948vuOyIRLWEu91i4KAVE=;
 b=3W9dvDndOftb1FH5JfCSzv3yy1+rTgDAkxVcgNAHnCFBYTWkbh/kOXouHvkH+0wSgWhUTb5c+7Y+xn6pxo/JjUODa9STCtpw4/5W4oRG/J++3UjMyhI5LrPPVAQn+acEw56+Wdz4Wqv/d/XMGnnaUgGEkjWg047aleyxBR+2lE4=
Received: from BL1PR13CA0310.namprd13.prod.outlook.com (2603:10b6:208:2c1::15)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 09:12:05 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::28) by BL1PR13CA0310.outlook.office365.com
 (2603:10b6:208:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 09:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 09:12:04 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 04:12:03 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add utcl2 RAS poison query for mmhub
Date: Wed, 13 Mar 2024 17:11:53 +0800
Message-ID: <20240313091155.347161-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2935a3b0-95ab-4912-a6cc-08dc433da6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djC8bpQB//bKCIurws0EN0cS5ZXvDVuZu5daVbOwJkOCelE/ySsCmzcUmrr9HEmPGEzGPB5oApGugNTzgRpDzK+hlt+GkyuwAC/xsxIcrqsZGdzpW9HwhgMsh447o0TJWAul0ch7/7bQfTkq1cnLZ7/IQAoffWs3v5jeUKc7Cbx/wLMCcC4dF4RU1BINOUXLzFO89HhCR81ZgvzK9DnA7UsiXFWqA9en+y5RqwF0kAcNdjrXp+amTKzpYQKvQwTpXtC7OyBEOesDo+zLOVon6e/uZTciTFpiEKQ3RAH6dcQXSG95ZaxrieZC9s6nxK9O2lQ+gyE0VjMfQGaL4BHvJ+LCWMXsCMrTfT/2RyHZmMkqDMz0NDouC36wCKA15ATjnzEgGbUnxLqSUQyHibM2W9o/1GP6qCcQ0LkonTwcv44Tv00wuArOIPBR0BDXcp6kfhUIqWgPYTCjIyC8IpY2pIsYpk2H/Z9J30lV5pcf5Sznf+yuSpMi+7hutXukSygTy0B1dzK35hGK5JIYzjUdoiITb/edeLwagzEIrVbBVQcd7Pvz6sGUeMB7dEvMHsjyj409D93pmjJ6YWXMJqNJfAFMGpe+oo1PXW2swid4W82h5eibHGkO/S0Et3eqOvrEtgLYXDZyXxZ9JKLMn8nDSEaluOiKVP4uKAStm2YyaWiez8EdXlDsEwrc4VE0BcoYzkHyYAh40Tne98h1xxmdVn8Z724UzNwNutG36rRZe47mcxBTy6UgGEpeuH+nMkmM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:12:04.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2935a3b0-95ab-4912-a6cc-08dc433da6b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

Add it for mmhub v1.8.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 1ca9d4ed8063..95d676ee207f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -63,6 +63,8 @@ struct amdgpu_mmhub_funcs {
 				uint64_t page_table_base);
 	void (*update_power_gating)(struct amdgpu_device *adev,
                                 bool enable);
+	bool (*query_utcl2_poison_status)(struct amdgpu_device *adev,
+				int hub_inst);
 };
 
 struct amdgpu_mmhub {
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index c0fc44cdd658..b7aa05dbef86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -559,6 +559,20 @@ static void mmhub_v1_8_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 
 }
 
+static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
+				int hub_inst)
+{
+	u32 fed, status;
+
+	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
+	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+	/* reset page fault status */
+	WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
+			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+
+	return fed;
+}
+
 const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.get_fb_location = mmhub_v1_8_get_fb_location,
 	.init = mmhub_v1_8_init,
@@ -568,6 +582,7 @@ const struct amdgpu_mmhub_funcs mmhub_v1_8_funcs = {
 	.setup_vm_pt_regs = mmhub_v1_8_setup_vm_pt_regs,
 	.set_clockgating = mmhub_v1_8_set_clockgating,
 	.get_clockgating = mmhub_v1_8_get_clockgating,
+	.query_utcl2_poison_status = mmhub_v1_8_query_utcl2_poison_status,
 };
 
 static const struct amdgpu_ras_err_status_reg_entry mmhub_v1_8_ce_reg_list[] = {
-- 
2.34.1

