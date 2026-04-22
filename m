Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C8F94CBE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 22:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6693510EAB2;
	Wed, 22 Apr 2026 22:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B8dxzBHk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F70F10EAB1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuTW9ZaDWGhR8pvv5N3dHGe0rhl7qypT03Mvn3le9dy8GtdMMdmEdcT/O0WBOLSZEK8uVnshSbEz6Nx082OqgR9Lqd4O5XaLTjOBaMZP+NX0KQO6jsjvdvDCkR1UbmZz1vN2SCSDs652S7ay1pjZv7gF2EOTe/UG1GMZZ6eF5lbEX0FCw0M1Oj9jkVqbtPCXNwWMmhigkkoRIlLPLHspdutkQNM52na0bPpygvOoyG+EnwO7eIh8aVSf6lIYRM1wgAtrQSURe7on3vrwNVJrgwVQYrogwRT3OG8IMSu94LH4V1H/yCgiqMtqgSF6Vyh2E96z7tR7Mw5y5RVySO207A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+B+rtPTHpftIUpb8DzLl6s/KMgUQsF9VJi7MHrQhr0=;
 b=aANcTpEGzT04ljFUPeE08a/6+AafNZbLX/E/6Q/iC46OzkSWCoE8MG11tFkupPUd47qJYc9X1KQfBARZk3/Q0JScDSfs9Ejm+b+J5s9LgedaORj9xSF3/XTK63cNsHZi0+n3oIaYtmZySu254jIHpdjUR7tzXj/YfbkaWZsthq6dRac14GojaNPlBhbNqwdlmFwmPz3MDWd51L0cpAbMj/YepcUJ4MUkH1m6nzvREHJ9t5WlikXw82bfVu7h9Yq8YXSVECnWF2Wobs6MsOIHop/SCXpSGTqRMt95yCub2rVsS+vo7DHtOG5/HWo3dZfEKAH8Og5Po+2haFAnNWXomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+B+rtPTHpftIUpb8DzLl6s/KMgUQsF9VJi7MHrQhr0=;
 b=B8dxzBHkqMNVoOBhX6eb6DWTJbm+7KjW/j8PbmnuZdvOb8CsqcFDGG0a15n0RdQtelS2SQACO9715N5K92ByCcWX2CCAPoAiU5quzDsWShCxSBHbdqqEfD/KpUVMVhZhA72ccsUq61FldKJBLm0h5lbZdawhWH5zOEwK6FKYZIw=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 22:06:26 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::46) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.20 via Frontend Transport; Wed,
 22 Apr 2026 22:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 22:06:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Apr
 2026 17:06:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Apr
 2026 17:06:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 17:06:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add node_id-to-die-name decoding for ih v7_1
Date: Wed, 22 Apr 2026 18:06:14 -0400
Message-ID: <20260422220614.2259600-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422220614.2259600-1-alexander.deucher@amd.com>
References: <20260422220614.2259600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d2a4c5-f54d-490b-93e1-08dea0bb656b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MqQQuzh0UTo9U9mMyrQZ5TDyMhod/+XcvcfAzyJCP+17LXPeR1+EBENvn13qRdeHiFULaqoIrOTANlD6ItNxapKhzRIp9828R3EC3CT2c63Dn5Eok/r9PP+8MsmkjbAn6+vFhYz4/nVsFMWyZv+x5Isytw7NTuO3l5AjPSLySqthyAFa8AXSbxmOTUxgmpYgMeY4no3f55HlXwy+E1KsCFRxdvO6w6FklG6xjH9XdQiujXcglsHEeXGjB4tbwe0HeYzK+dGan1mk+NjYpeS0et4COIErys+2Z9l4HsmPVyE8yvKRP1ZNo7/klF9WmPHhjGAX2bV3BiTTjeO56tSTeA7eUKoRSuYJ7S52TyyohjPXxnTlz6DyClnYU5GlGDRcWE+fribggmCV7CKkDDGosdhZZ7ph712bWmIyXGdtHrShT1Doo7OOVS/3/JVyV6ylJymGVzz8BcgPUq8VHUhn+yhjsoj/pXvtOmYs6pqEuQkEx5VYNXG+P1tFah2QyeciDRXbmizI3BvhAEkkIopyoMgBPB5yEFxvC3L0uc8oLSt17pHlBJ0v5j5Jk3ixWxLd6WZem3vgSglsnj6RzqIZ5lY8qlzb48Y5AgE1nVq7w7J+yRqk0hxzLE0revkjC28HJa+lEVJUzSgwhgLO7+n40XKvDD2/Yxb4ePFXNr1baPQpghhxEYoMmwF8rKM4kPTwRzHau6UrWWFmH8nYlPZNQlYUynvkxB/ffjPp0/7rZcj8RKlPYhe7DcVjC6jymK27MdV5rceBHIpcExL8YqtWEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NXAfsk9VdwzR1EtQK9JgddhqAJ2cIIJ4fmu+tpJy470IsuxPVlcJjiI9lxQsouSjHIAhkxcrsiI63xN+KMBVjtS8fmPIcHrIP8eIWXyNa9Pp3UVbgBhCEesfK1OU/PIpyGlRCrF9lrb1cXMAyWos/bExrMLqfuWnp4QARwjy6nPZSW0/EWE1ECdUVx6s32hJPOA8XbwYCRwdteOp2MFMReZFzZYUSUQqHGoytq2G8V9qX7SUT6ySqsz+dgR9wkfrt8ke1ubLXsoVZBlBHThW9v+Ry9tPiiYvxLFyPauJrvSl6w6whzCUwlF/kj8gKpcx5/fHXqJyUFK8wtPSz9uaPyIGxEAacSsXoy0R+QfCzaBo3sT+yLEBbc1nORO7x3vfXnCThLYEMrT/lp1D0cJtOIlL3axBWcokSeEAScedy2tMX8ozFXxtkRBZfkb5JHb3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 22:06:25.2945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d2a4c5-f54d-490b-93e1-08dea0bb656b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Converts node_id values into human-readable die
names to facilitate debugging

v2: squash in fix (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  6 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 40 +++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index f58b6be7fccc0..444437c300886 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -91,6 +91,12 @@ struct amdgpu_ih_funcs {
 	uint64_t (*decode_iv_ts)(struct amdgpu_ih_ring *ih, u32 rptr,
 				 signed int offset);
 	void (*set_rptr)(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
+	/* Decode IH cookie node_id into a human-readable die name string.
+	 * Returns buf, or NULL if this IH version does not support node_id decoding.
+	 */
+	const char *(*node_id_to_die_name)(struct amdgpu_device *adev,
+					   unsigned int node_id,
+					   char *buf, size_t size);
 };
 
 #define amdgpu_ih_get_wptr(adev, ih) (adev)->irq.ih_funcs->get_wptr((adev), (ih))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 7ea7b9c30bca9..855cd29cbffaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -112,6 +112,8 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	const char *hub_name;
 	int ret, xcc_id = 0;
 	uint32_t status = 0;
+	const char *die_name;
+	char die_name_buf[32];
 	u64 addr;
 
 	node_id = entry->node_id;
@@ -201,6 +203,17 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client %d (%s)\n",
 		addr, entry->client_id, soc_v1_0_ih_clientid_name[entry->client_id]);
 
+	if (adev->irq.ih_funcs &&
+	    adev->irq.ih_funcs->node_id_to_die_name) {
+		die_name = adev->irq.ih_funcs->node_id_to_die_name(adev, node_id,
+								   die_name_buf,
+								   sizeof(die_name_buf));
+		if (die_name)
+			dev_err(adev->dev,
+				"  cookie node_id %d fault from die %s\n",
+				node_id, die_name);
+	}
+
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 1fbe904f4223b..6de9e87e04e1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -798,6 +798,43 @@ static void ih_v7_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 	return;
 }
 
+/*
+ * ih_v7_0_node_id_to_die_name - Decode IH cookie node_id to a die name string
+ *
+ * Currently, only applies to IH v7_1. For other IH versions returns NULL.
+ *
+ * IH v7_1 node_id encoding:
+ * node_id[N:3] = MID index
+ * node_id[2:0] = sub-slot: 0=MID, 1=AID, 2-5=AID.XCD, 6-7=RSV
+ */
+static const char *ih_v7_0_node_id_to_die_name(struct amdgpu_device *adev,
+					       unsigned int node_id,
+					       char *buf, size_t size)
+{
+	int mid_id, sub_slot;
+
+	/* Node ID to die name decoding is only defined for IH v7_1 currenlty. */
+	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) != IP_VERSION(7, 1, 0))
+		return NULL;
+
+	mid_id = node_id >> 3;
+	sub_slot = node_id & 0x7;
+
+	if (mid_id > 1)
+		return "UNKNOWN";
+
+	if (sub_slot == 0)
+		snprintf(buf, size, "MID%d", mid_id);
+	else if (sub_slot == 1)
+		snprintf(buf, size, "AID%d", mid_id);
+	else if (sub_slot <= 5)
+		snprintf(buf, size, "AID%d.XCD%d", mid_id, sub_slot - 2);
+	else
+		snprintf(buf, size, "RSV");
+
+	return buf;
+}
+
 static const struct amd_ip_funcs ih_v7_0_ip_funcs = {
 	.name = "ih_v7_0",
 	.early_init = ih_v7_0_early_init,
@@ -819,7 +856,8 @@ static const struct amdgpu_ih_funcs ih_v7_0_funcs = {
 	.get_wptr = ih_v7_0_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
 	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
-	.set_rptr = ih_v7_0_set_rptr
+	.set_rptr = ih_v7_0_set_rptr,
+	.node_id_to_die_name = ih_v7_0_node_id_to_die_name,
 };
 
 static void ih_v7_0_set_interrupt_funcs(struct amdgpu_device *adev)
-- 
2.53.0

