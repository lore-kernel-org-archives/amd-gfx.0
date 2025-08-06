Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639BAC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C420810E18A;
	Wed,  6 Aug 2025 14:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mawgfI8W";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3774E10E18A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNzhSCqQiBWY+dCNmH4FwvmCusHmV7w2bFyo/bHO8ljSE0EiZP6+1vaHBxov1qCru/aicTISdVP4KiMG7gfcgBDYlaUG1JGrLEt5nAMtlNxax9jaBlzLLfgXsojCym93ek+UKoau0iCRPO/F5eUC85P6DhFr0J7dXJlX73VgdjOAAVNRf0pvNIURvVTXXueKfmMhp1Bl/ONrKKY6DqfMaIwn1wNxghTnFIOXOcAOOAe8Ws3M7Uz5nb9m2Sd6PFho0pMnOFHCj2uDcmylCVSlr5p4dmh+2/xJuwgnBK7jlWllhfZ3HgU/7LFqLLnxgVW5VpA6fDapwdB/+ZNJa8Ebnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7atz89YnNvZS22FgkVfRRz6guVWIaLGQuEfrIw+spw=;
 b=aQjsK0tEgQBRpJPhvKx9WVcRD9XK771TR1fnSXTCIlvUCaFbD4Jxs8/Y7NNAJeidKVtf8lWYVhUTMCqwRyBWfVtHalozEdjFXeabIicbIgtCuLTMUEfj3u3RFtg/r53VwmdUSuPZrAgllgQnv9m6g1rR/o3t3H6P9MoN97OM2U2IXDW76x2u/8yozRe6PhOZaoyyzH84THIhEmT517jTgg5hAFHZkidRrznDS9aMosPhbhhdJGtmTemU3DEJknjwOJbL/n+JxgzramH2oxMOAcuO+B+ngyIHP9N9B3OWbk5ZpCf7LI+HQKuhyfqEICEwwZ59ulBsrkjjUBD1EH8eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7atz89YnNvZS22FgkVfRRz6guVWIaLGQuEfrIw+spw=;
 b=mawgfI8WBrijhUw9jxuYeTAABaK4HMiK7eU4gMgZaZ8cRdnKnCff/AXbaNXL7eVeVhLu/RbWHSMAP3rwuoITrF6CnArC42TYFeXZZR/iqcdIHdeLImL0KW7+qqkFH39Uo6v36Afd48sA2LHWbREunVt9a+Lg2FlQZMGNTzu/+cE=
Received: from CY5PR22CA0004.namprd22.prod.outlook.com (2603:10b6:930:16::29)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 14:50:22 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::7d) by CY5PR22CA0004.outlook.office365.com
 (2603:10b6:930:16::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 14:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:50:22 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 09:50:21 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/include : Update MES v12 API header(INV_TLBS)
Date: Wed, 6 Aug 2025 10:50:00 -0400
Message-ID: <20250806145000.293315-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: fccb4fa5-b7ab-4214-e65c-08ddd4f89229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|3613699012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JeDKlUH/014/lamzhV2InBJK1Im3dd0XsZeKXTZqs/psGyP8d80jTLa/5oyW?=
 =?us-ascii?Q?fKoMkB3cP9tp3+eVkg2vZw8DkagDCdCWRf6AYMyWqQsTFZQI6lxmJNydgMtS?=
 =?us-ascii?Q?nt6/LcXjvOX3+AnpzNS1g+y+2ftDO2oIMYozxHY/uzJ9wuRurpCr09Ve246t?=
 =?us-ascii?Q?kmfOIsU+x27g/LfQpkYwzUOR7Rg6z9QbQ7SucZlfseDMG3hKJtmuS9DCxvdh?=
 =?us-ascii?Q?ZOHyIv3tMVOHgokl6x+XUj1jx6m8wkeom+t9LQU+LVKB7j+kG2T7j8zoMTzE?=
 =?us-ascii?Q?l4lWtd010NohQ5/a3hRXDPM2/zzpg/H5ekRN0QZNuS2q+annPq9J6P1d8KYd?=
 =?us-ascii?Q?rhuqo3xXbRwN0ylN8uJm/OSYjG4L4Oj8UDF+DSI+TYNGwOq3osGJrFwIXcfB?=
 =?us-ascii?Q?kvSGTOrvOgQ+mQP9Rk2hl0gYnisnzFkSfdd37vqD2Il1mUfDKLN8AknYkn+4?=
 =?us-ascii?Q?L7X+YgtC4gBtTf1B4iudHt3PYA/PWbTuz4iSYd/b4CXjB3CzXjsXqWwdq6DN?=
 =?us-ascii?Q?CF5MmK+S2ZJcqYlUWTHWzIOUCjro7ocJ9P18dTZrNEVtO4We7OKBSlceK9M4?=
 =?us-ascii?Q?gqALc1uWZO/xLzKOqN6kTcpzDKEXE+qBwba499nHijz/VHDYRAoc8uHd8kYu?=
 =?us-ascii?Q?eKxYfjfTxjzCK2fPEHT/CoeVTSBXrFyDuL661QQ4vEUBcL+XkkOwnM8ijfZ5?=
 =?us-ascii?Q?u2003bnDzg2PVshRzVARjzIKoGMTcxWCANLx4Nciaa0evCMi43Lw9EvZHV2K?=
 =?us-ascii?Q?3RlDi5wUUAtozSpTHDnn0C3D7OqZEhy/a/E5e1aDK68jzuCzFeWns/09QC9N?=
 =?us-ascii?Q?bxxYqUunzosv6WO4NQDz/69W6JI+3GBIjPe7jCBmkITVc4p3x+9+u+cKo5MH?=
 =?us-ascii?Q?exNr0HKxu7gqzY56YNkcWGaFiAzgc0lYenSTm7IC4q5WK1XPd0DzVYjDbZkL?=
 =?us-ascii?Q?2ZHVI2/RqMf/gcEToFCvFNc4e6MXj/fpML5j8ZHBFQULTbyv9hT41SJG7rnH?=
 =?us-ascii?Q?GLNnWJArK4ckUq8i2DcZuQU+7r/YFNBYOpzgwFemly9UR9kLX/Ts8QWRPNO8?=
 =?us-ascii?Q?hEpbHr58sKjdDUNyxFkyNYYxwHMjDocaQjCbczj6/Cjvsn1HNPsE+zjdEkZ4?=
 =?us-ascii?Q?Zolz5MxVLUugACrVs4qYknm9h9W6fax9s/KEcl9aBKNa2di0Vr/IALVvZ653?=
 =?us-ascii?Q?lyUk+PvxnT9984Rhn19gpwV+prhm0F8A6ik2y6tDhMRDX3/WB0uBFtAin8EY?=
 =?us-ascii?Q?S92OJmdlBzPxgSarFuHxrdCXaY1/jXUWBqaVvenopIhMfNMtSaF2lnmvFe2c?=
 =?us-ascii?Q?vuo9wmKhtbrGsYLptxo1PWKY2if7EZJLAJqgZcCsBE02MjTDXhHIctQnfxop?=
 =?us-ascii?Q?ahZO7x6nN9VAo/2D/agBCkvGPcC2oyxs1kk7sAnwPuOJHvD5YC+rgUNaSXeb?=
 =?us-ascii?Q?aue/FPGxw/2/qHVcc0MkQKPymUYknAv+3ddGDwvEjbCgC8xs07k2jRILC8G5?=
 =?us-ascii?Q?mWg18favkI6L9smJ9fgMhXPtmntf3uezOa1HVyFYR9buHRdw1iV9W4w2FRXJ?=
 =?us-ascii?Q?YlmOxvJ3FSx633O1TBY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(3613699012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:50:22.4802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccb4fa5-b7ab-4214-e65c-08ddd4f89229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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
index d85ffab2aff9..f6d08e3cdb54 100644
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
+ * @inv_sel        0-select pasid as input to do the invalidation , 1-select vmid
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
+	 * otherwise only required range be invalidated
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

