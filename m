Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CD8C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4230112CB9;
	Mon, 29 Apr 2024 14:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzWjIa/X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20D810E962
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn+s8fErrhzIirod+wskoXRxq2bEyxNZ7Cx4KRiVBo0Krb0+BfLX3z7rbzkg0+3NPeRBrtcGx80BJm+yCizVwuApB66WJHXu68bCC3cyPLNRiPHAw2xKvcKvsdlZcXUQEZWQcu1CI81S9ApAV++2fU/j5EVSXjlcN97FE3ywJ2VZcD7vNDjKUcAU8NlGb8pdFiZwVyOIYj2E4v05AG08kprv6dXsO8r4Nbs9RVbx0npW/n/1pTrws2Zugk8QUv4uDL/rTsCAXMy9SN1WEGba+gIHa180a9MUggycwiTa3HFgjp0Mh1GAesRGplzO5sI0xWf0ZWZD2XvZn9yiDvFBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiC+ZsV/XLlCpY1V5KszO1qpZNf2po6a5sedyEhpNng=;
 b=nJ3x+oF1By3beLaDg1Yq4hl7icGzLOCXyYGLd/uRDNFN0fN0RmLsF//O7X+iVMhl9DEBQFkqceZejj+ee1LEfV69rT3GAXP+Nf3mlXyWAXqNU+vtGtBDh1ctKwivNc3lLH8KnOUbSjUhBXZSLxWzMVDpEKFE9ZEoKW4liTyKRZbnSui24fcL/mvkvXK9kqL/aONfRK2xs4V6YbOT9WAQxBfvEXqHiZi51GJMQ99x3L4eBKEdiMNekmKU++laScj3BhZotfMrzA9CvQpli+GzLq09o1GUqAUMNNUKxwGKCGGDmLzmm6wYcVgs+4v19t0QiNwlrVyeZXz4I14zueGorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiC+ZsV/XLlCpY1V5KszO1qpZNf2po6a5sedyEhpNng=;
 b=hzWjIa/X4DxofscdB+zqKrHl8tjKdqjqh8F95tC+efI1TkN6bRiSeFgHk3f9Do5hpJdVywrMkk+KeZlgaJyGngGZqAgxB8XubsuKIj/9pC6h/08hoVwbK992qBVykjZ2LH3J6GOFlOSRX6a9+YGAY5hPsTqsR8nXb2uwvEpfWbA=
Received: from BYAPR06CA0022.namprd06.prod.outlook.com (2603:10b6:a03:d4::35)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 14:34:13 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::36) by BYAPR06CA0022.outlook.office365.com
 (2603:10b6:a03:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/31] drm/amdgpu: Enable MES to handle doorbell ring on
 unmapped queue
Date: Mon, 29 Apr 2024 10:33:19 -0400
Message-ID: <20240429143339.3450256-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: fa01e331-0281-4da9-e3e3-08dc6859709e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovf2A43nLJBRno/Ch0gqVJArqWA+xTVwaUWT320C4KuI8Bl1eZ/RTid0h95U?=
 =?us-ascii?Q?4WkYse2pyOje1g5lDtH7DmSCXnqjS6yX51/GR5qLKx2vu/yyAlmtrefJnCYW?=
 =?us-ascii?Q?QSHJ5qKM6BhzB8SWcpmu1qDhc6zj3cu4hfaTsrXuv4AMuY/kKMNrSs6CKgyu?=
 =?us-ascii?Q?+dSLf+WNZGNqVpb9wqD3MWWxSXpe3hAGiqHmQ0gpVYbONrUZFx0hoMdsW5RP?=
 =?us-ascii?Q?3TZq0Hg7ATE1IX/PgqBoP67diHX9eFy7t3BxFFLfOQ9voEop3vBIj/8v0YoK?=
 =?us-ascii?Q?MROmo88EEB5amo1DCSSgnLVFp76Dt5UaA/Y59F3aR7wUW/fKcDhadT4HjeVY?=
 =?us-ascii?Q?wL91NnPo0sGdX/p053p9h7+Mpm8BaGGQylzEBXqYKkhZ7ONmhsrme7EDHt1P?=
 =?us-ascii?Q?veTQrsyCjqnOXvOrOFfcKjtR1iFhf6H/0Gg4YtUbcLpLY3yqII7I8F08CCcv?=
 =?us-ascii?Q?oPnm8R+gdQecGDVwUXAFNfmIBsxpMEkZ+BEuDwEvAH4pNfapRHaTDJtfEilq?=
 =?us-ascii?Q?SHhAR1V9FdCWly8xXbWcC0zi7039qpu56+mARHqwJM88ea9oizGnO+qfTv3p?=
 =?us-ascii?Q?gJQa8YOQ9w1IYRbBZfZaJK1OVdoYbAlMRKmkl2EKIZWhYkqnLwdJfSV1di7+?=
 =?us-ascii?Q?np5EZ2Fh3hSHZCo0VHBcFNabUnDKjvmCwU706rVMSum530jCr8E/k7nRoqTy?=
 =?us-ascii?Q?egYzn9TZYLVY9vhiFCuyG+pIl6mpI2Gc5lAiPHmT+EcviSyPDbe5lsNPUCv2?=
 =?us-ascii?Q?fW07fyPp34b+My5zcwLCP7War+7ispD7ZuUfM+C2zOoZSVfe41sIQvzPdnqD?=
 =?us-ascii?Q?HUvsMKNWOqcm72qFV0ANZzq/YsA4h7Mqwjpi1vTssIr1k1gughJITiDrp7ie?=
 =?us-ascii?Q?Fm7zwD8z+U0UgDRAaa8FYnViuoDVA0u85LV1zVouar0O46LBkToRbw+XPEXq?=
 =?us-ascii?Q?SkjuX1R1snWbuNJamOmY9bfAdvmTejwG4k61MGyMel+LLRLS8kxkJbZPCBft?=
 =?us-ascii?Q?j+b6MWtstlvHhZPGoK1gV0wyq/OPeor1fDtXmAOzr0HsiMU1OpueVMyGl1To?=
 =?us-ascii?Q?GVQylcu86favFao/3wHokQLzlgJ8pDMzVpRdKdZulLAR4X6/6vtcme8nbZtH?=
 =?us-ascii?Q?z9ITSfB6Jq4HpknS6pv0Yu+vTQrhUw3U9RH7PV05cMgYj8dGRKRWdaTbAiwu?=
 =?us-ascii?Q?HdDJBim+zQQkAcSJ6oDFm9HP83LdVeNS0e6nAnxai6MuhcdTJhWCAp5PC48W?=
 =?us-ascii?Q?4n6hsjke6sXl9DXCnpn0q3UVG55aTRgbf9qCyQ3yD4f7iNbo94Tz5DfDumlH?=
 =?us-ascii?Q?fIuILPRNoi2Igag17VmDB1GpTyRIkya6tZBT6Ew03mD4WpRw17chG9QLNRid?=
 =?us-ascii?Q?xWl4gmjKp2i0MTsdGSgdyiux6v2B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:12.9200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa01e331-0281-4da9-e3e3-08dc6859709e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850
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

From: shaoyunl <shaoyun.liu@amd.com>

On MES12, HW can monitor up to 2048 doorbells that not be
mapped currently and trigger the interrupt to MES when these unmapped
doorbell been ringed.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d20bb78280b15..d8ccf580bcf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -454,6 +454,27 @@ static void mes_v12_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
 	WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
 }
 
+
+static void mes_v12_0_enable_unmapped_doorbell_handling(
+		struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data = RREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL);
+
+	/*
+	 * The default PROC_LSB settng is 0xc which means doorbell
+	 * addr[16:12] gives the doorbell page number. For kfd, each
+	 * process will use 2 pages of doorbell, we need to change the
+	 * setting to 0xd
+	 */
+	data &= ~CP_UNMAPPED_DOORBELL__PROC_LSB_MASK;
+	data |= 0xd <<  CP_UNMAPPED_DOORBELL__PROC_LSB__SHIFT;
+
+	data |= (enable ? 1 : 0) << CP_UNMAPPED_DOORBELL__ENABLE__SHIFT;
+
+	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
+}
+
 static const struct amdgpu_mes_funcs mes_v12_0_funcs = {
 	.add_hw_queue = mes_v12_0_add_hw_queue,
 	.remove_hw_queue = mes_v12_0_remove_hw_queue,
@@ -1233,6 +1254,9 @@ static int mes_v12_0_hw_init(void *handle)
 
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
+	/* Enable the MES to handle doorbell ring on unmapped queue */
+	mes_v12_0_enable_unmapped_doorbell_handling(&adev->mes, true);
+
 	r = mes_v12_0_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
-- 
2.44.0

