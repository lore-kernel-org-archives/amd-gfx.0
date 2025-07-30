Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D5C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 14:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D8B10E20B;
	Wed, 30 Jul 2025 14:27:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qz9PjzNT";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F5F10E20B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 14:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpK12GPtQ9gYyOEnD2cfSmZRHqutSqzmKorLozXFCvc/i3915LvyO7syi6zTh9UrEgTYZwWPZJbxm8i9SNlYyroPMM3SU7m7QHzz+TmzkKNESd/Rmz0sdje6mKLB4KLnVmcpE8jBsFE7LC99/7JIktifaJvzK17JgbTTrUcVMUZvXjsOCPUdos56JPw/Cs9p476pa3RHzE3YHy3YFrTrIBrnA3j09TtxknB7bGb1DtjH/5R1fEBPmAqtTcb7gXdZLswhywTuxOG/hs5vBEdJK5JJoqlTNh5Ywlw0yh9wCabkovUi/pI7J1nC0eQhtew13uuWyVcSIprqbGyJRwR0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np6sMUkjDjNLklnLlh/o4U+hMeEtV+8QQJgDhypSsa4=;
 b=mhhBOs7bfEYMGaKrjK0e786wwvFSpLdxXTwXd3uWI7Zfww/iDjmJCb2XgQAaYSwuXSjg84mbWetbQrGNG0vkB9kgVXq8g0OMFDetwtJFtg3MwK8G6b1n5uXgVui8rscbE0rPg0tgkm2tkxGCwjNinvTJlPVkbLry/AlTUsjo9pDduTzOZACY4Ppi9KucRp0fTcX11p+cauZkNMwWWlVtm+SjjD2FY8e1bd/9bsrKh5IOnvkIplgPAHqqcBvWeNFDzartebXaxuZcysqObgCWCjmm/ZzWcO8tpMqcSXPFCHOSNtzQaxjNX+RTQ+fWRdCR86fOmVL1uFGH+Sk4OKk4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np6sMUkjDjNLklnLlh/o4U+hMeEtV+8QQJgDhypSsa4=;
 b=Qz9PjzNTBzLaklNvc48J2RWaC9XvW1z3SdVdAysXAPH6NSDYiZ2qWHg1u69glDxj3N42Ec1n68I8Z1LXOXcF7UWzTkJueqm9yOM2C4VJAcfKxNRwy7xsV8xallb9QVa8m8LldkLSZ0hYGGxKnPnVR1y+qJH5NCBc3/mp8Y4HA3k=
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 30 Jul
 2025 14:27:12 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::d2) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Wed,
 30 Jul 2025 14:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 14:27:12 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 09:27:11 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/include : Update MES v12 API header(INV_TLBS)
Date: Wed, 30 Jul 2025 10:26:50 -0400
Message-ID: <20250730142650.7167-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 86716778-7ea3-4a42-8591-08ddcf752ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BklOUgDCTRzVoBOLJZ4Tw16XzkhU8FRon8b974j+vY3PKq7FZZas8kARlpHr?=
 =?us-ascii?Q?aBThgPX6+lKGaKF9JG/OzeiEgHmMkNT8ce6+4mPrq6ie2xbc1MdYRyKQTAYu?=
 =?us-ascii?Q?LXOWXprL5LutMjZ9g9AwenvM55VyzeIZgEoqU9kW725QKhGgOTwMRnTg5Z8k?=
 =?us-ascii?Q?sLVR/vc7jsWJgMPkb0/aMW/CfTjU1kofrifBTgr1lt6TnEN/a8vHpaRs8KcN?=
 =?us-ascii?Q?6Fo9DTRIhI6xvvUo0VsfjFTNpyGreVjdPgNcLE5VyFyXjsj6BiSpDzgo/ceq?=
 =?us-ascii?Q?zmTb7FVHuPeTTIkEC0mNmo6TCy3R11XAWzJV4Piur4/hQ27W8PsMYQzGGRgA?=
 =?us-ascii?Q?77sbggbwBv8ASgrZkrj84s4N8HUCcrORTfkzmfAyZf1BciVQKU6+Kw959P9P?=
 =?us-ascii?Q?d3/bKuF/XJsvPRPn+6a5xqeoUBAfos16Owimz2HlB65w94A1daTfKPqySpyW?=
 =?us-ascii?Q?9SqiePNnw3NmqxtaPEusg8UqIfplb5h7lh9cJWvORL67zdaD5N3jrTH0fE+a?=
 =?us-ascii?Q?cJDZdfeMQnuBvwtD80dwG7hU2JtofjTaA0tAGaX9chkzAH4mb7Mp2+9z/cbt?=
 =?us-ascii?Q?vP7FAE41rlLNPpVRXRR898F8ARrYv0/l6YuhQ8XpOBEfjChqk59a9dUILFen?=
 =?us-ascii?Q?2XN/f5N5xYHIxPNhrRgQ3E24HffCk2DV12zUCKs0amT9wC1KW+xWiHzfT2wL?=
 =?us-ascii?Q?pzjdo+1xFRB5IP2cVryBRxgduugjkXnWMRzHz+rRKvl/INYbxyxhMNiiNvVS?=
 =?us-ascii?Q?aVQxS8PVkfuzFSaagmLLWXRA05Xj3vZm5wiJUHnm/Uec3vhSpXHI185dYo++?=
 =?us-ascii?Q?KN1U9YRqNqtjZTI3eu6BqbsKSdBLkSY3MJf2mlFQD+sXEOGKdxgvmB3iIVbJ?=
 =?us-ascii?Q?P1j2Q46XptswedPlmmBy4EqXgQN/tExHsRRSsWR+9NJ3Z2NoglV0kQks7PPZ?=
 =?us-ascii?Q?MBzoXlB10JTc3rW0MRgDpr21xAo6k7gT0+C0xwFODjQvxFOS7ruB518z6q2c?=
 =?us-ascii?Q?RNE6JPjp7wuPjSwPgXeHp3h52MIJ9rVDMoYHcc0d5AgW563JOvBDP05qIAvm?=
 =?us-ascii?Q?o+TRfVUnQetc3kWOacFs4r16Yc+QghYt/oCIS6Nt+5Bw8fzfcg9fXoqi+MO+?=
 =?us-ascii?Q?r/k817iqCcGB2MqYeyWr7MIhMkppEbcO6QMz0PZy3A3G0CT5DeWeh+bo/NtH?=
 =?us-ascii?Q?uL08nsYSS1vlM6uShKkKVbX1eL+raE56eldqVnMtfXuOi/caHgltC0L3tIkr?=
 =?us-ascii?Q?NTnk99PMHh4pSKe2iW0jKmcW1qmW6SSi+YwLx+9YA1Neu/2mH8+qjVJMtlx4?=
 =?us-ascii?Q?zucudKynYXQFcocX6M6PAFFio9eF9lpwmhAQSHEBfPE80+hBgwAduoJdLYiY?=
 =?us-ascii?Q?h0vlcz/m57cEp/si5nynMx7jlaLvrls0+sfiWoQLjLswI/ye13eJ1Tu8tX8x?=
 =?us-ascii?Q?lcEUgygi5PSUIkTKFaY2y+E0KR/t7g0ryD8u070Br5AQ3VQ4GvnC2QPQguGr?=
 =?us-ascii?Q?wlATGGZJXHoLBiTBjBjb8uYG2ZOuxm3xf332RoZg27bnUdjV6t6EswWtT9ZC?=
 =?us-ascii?Q?Qg6hsbWE0sT83Sf97G4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:27:12.3371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86716778-7ea3-4a42-8591-08ddcf752ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

The requirement from driver side is to have an API that can do the
tlb invalidation on dedicate pasid since driver don't know the vmid
and process mapping.
Make the API generic to support different tlb invalidation related
request. Driver can specify pasid, vmid, hub_id and vm address range
need to be invalidated.
With this API the old INV_GART in MISC Op can be deprecated.

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index d85ffab2aff9..a17efbd17272 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -66,6 +66,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_SET_SE_MODE			= 17,
 	MES_SCH_API_SET_GANG_SUBMIT		= 18,
 	MES_SCH_API_SET_HW_RSRC_1               = 19,
+	MES_SCH_API_INV_TLBS                    = 20,
 
 	MES_SCH_API_MAX = 0xFF
 };
@@ -870,6 +871,39 @@ union MESAPI__SET_GANG_SUBMIT {
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+/*
+ * @inv_sel        0-select pasid, 1-select vmid
+ * @flush_type     0-old style, 1-light weight, 2-heavyweight, 3-heavyweight2
+ * @inv_sel_id     specific pasid when inv_sel is 0 and specific vmid if inv_sel is 1
+ * @hub_id         0-gc_hub, 1-mm_hub
+ */
+struct INV_TLBS {
+	uint8_t     inv_sel;
+	uint8_t     flush_type;
+	uint16_t    inv_sel_id;
+	uint32_t    hub_id;
+	/* If following two inv_range setting are all 0 , whole VM will be invalidated,
+	 *  otherwise only required range be invalidated
+	 */
+	uint64_t    inv_range_va_start;
+	uint64_t    inv_range_size;
+	uint64_t    reserved;
+};
+
+
+union MESAPI__INV_TLBS
+{
+    struct
+    {
+        union MES_API_HEADER    header;
+        struct MES_API_STATUS   api_status;
+        struct INV_TLBS         invalidate_tlbs;
+    };
+
+    uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+
 #pragma pack(pop)
 
 #endif
-- 
2.34.1

