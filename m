Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D7EA3F3D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218C210E605;
	Tue, 10 Feb 2026 21:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0b6H+jIa";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D564A10E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUPFsGJ+gbHieeh2pSka/sE9Ks8V3pet1XY7cTTgnSEAs0AmyoAc49xyh7zOJJRW8N8Sy1GDXRbrD4rLnxmw5ycOw9j9021HULtVTNoCSHkXA8882KTfSU7h87qKfJ6PXq/dYeddpr9vRiv7zMuOxtTTzbtUiOmQlUUrZV3UUWpwFRbq6VRZKQu1vViLKoQBHgpxXOTEy8NsUubVrMzHcBm9ZsQp3ylIHxqv+nKQpR09kc1uwAwU11FIjW54LnGBVewRykMQ70CmNYlrhLfo6LCYy+gUqQjjquR9NdSYX6CkvcNuwP/xJX4fYNJlR2qBUvnBZK2rLIx8WxsKRuV00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fat19NU8VCeSH/2eH2xsi7NJWVR8r/GB2mqr+rqeUYU=;
 b=svXHunkdq3jnlYmo5LX6yZjHZSUH2JXEBxyD69CKGsolrbirYr2x/ZtHg4ecOrtAF9ByQvU99n1hEZhbv/vdkHYz655VZaC773YThJSs384GQFju9/wzFRUskokzHleXQf5U/XegACr1FFC2k37nC7oafn22ireo8+taCJyUaKzrUt9UhYhwkcg2pqTG7M2QnmkpEskGzTotnZHr2Q5qC0JmH1TgSrurykLyElYWpp+YLnsOcRQI/dLaY30rmki2pdGNfBumaRxSk7Cu/7oyDh79iIa8In5BvEwXtB4h+23nzkx9rOsFlnFbf3rtJaovaep93unV+JOcPGm5O1IYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fat19NU8VCeSH/2eH2xsi7NJWVR8r/GB2mqr+rqeUYU=;
 b=0b6H+jIaTpMKFyEDegETG/LzelvugUIPlxmdYDW4bnVQKQ0+ZjmZgw0sVAyl8tl3i8k3P+1Ykys3thWlpobq3cIkoNnxFJbwPxvvo5vPtmoTwwjCQFEUM8VlOWGqdccNhz1blxj56NytGA7Qa3DyX3gG6GLsjlePfWcUpeQWxoo=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:48:10 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::ac) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:09 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:48:01 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>
Subject: [PATCH 11/14] drm/amdgpu: add AMDGPU_INFO_DOORBELL
Date: Tue, 10 Feb 2026 16:47:26 -0500
Message-ID: <20260210214729.80964-12-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3765e7-e2c1-4384-4767-08de68ee14e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZtK8Gg2Cr+hiZSe3qQp430c9DvkhY4B95/U1D1bnTucmKH3Yt+irxqy6+F8i?=
 =?us-ascii?Q?fYyhFPPJhmIDZ6R28CjyvasRO4Ahg24cc1RrLV0ggd9thM23ID3g83tWA7Di?=
 =?us-ascii?Q?GtFx+w3/8joTuAHWXcj8Xq7AVLH5GQw3s3JmbZdNQjkgB0e7ZPvrhjkk64Pa?=
 =?us-ascii?Q?9xniLdXHxdGAM4FxlTa8dz6RbIcwaXDsYiNRWzCNnJW+ywi1PVGudwcewvct?=
 =?us-ascii?Q?lT09I7wAdjWDwd067C4iE+j6Pyfj1T3iKRJfIVicBiFkOdauWaWXGXMD/EGp?=
 =?us-ascii?Q?4sEzKrBw5L5LMPqUMOWTah3tc5ItJqGqI7FYiiEEdfaFwjdzEqof9L3tZzR1?=
 =?us-ascii?Q?YYnBqR8uPre1Kt44wbL65hLUPp+DYhqSK9I7EELGivOR8gZ5B3TFicrzf1/e?=
 =?us-ascii?Q?1waIx4dgYilLRn4T8Ajf4cZlFxDe8j2bjqnqJjrhG7bv5+YIvT/eusBTkDFL?=
 =?us-ascii?Q?dnqBiUKpmX2COld/XAQGNReq0YQAH+17aWdlzUHuj6O9mgbuhkEtl/HXAHmA?=
 =?us-ascii?Q?sA1jQLNvekuW5r60W5yFjG6oA4h2BGRsaZvANWdOdaVA+/c22tUQvnzSBv3M?=
 =?us-ascii?Q?3B7kkULFjHQ3nEGWuWo5OpAwyzjC7xDoEWtA0bwtwoziv+TnWaTxpsHCeYMl?=
 =?us-ascii?Q?PNxhD3UjAZvJ349oFaGnietR3+BHDv408rliBi4Bujr7MMkf4j9RoHDxGvYI?=
 =?us-ascii?Q?ysOvtVJmAlUqpDxE+9pThEZujzAT/Gg1767/b267b5aFwJByvTe8h3TtykVU?=
 =?us-ascii?Q?hua2ocmotk4EHo7gFV4Sg78bi6GgN2LD3FbrW4RT+/ABYev6HKSun33yHNqU?=
 =?us-ascii?Q?v0phIWHXJlP5D/Hw6iwwTTYA0rOFgsUEm4SjIfzyE4eKJyF9o3p8G1zcu89Q?=
 =?us-ascii?Q?Xlbtv4lFvsAnQOzlDYK4niEX5DiZhmb1vPXFyLMorGj8cJZZZhk+5G/E3Tlx?=
 =?us-ascii?Q?/Fjixg3r6EWVi2rQ26yFrDiFaP8/FXc65ZmftGYHfdohAHGOYLYQN8gLaILn?=
 =?us-ascii?Q?0b7BgXCrOROf09yR+K1FX6lr9rROobIw1aZa7NeWGCmv59nopPEKhh2Ljk8D?=
 =?us-ascii?Q?u+8xtCboctLBIinDgngSJ1zODw6mdKjkYWPpi3Q3dq/NyZvA13HmgNHLaL9p?=
 =?us-ascii?Q?jc5STuhhtu/xXQwAfWafJ52MEgeBgDfqRpRL9tbDwuBFMkO6oqW9z2PcsdP+?=
 =?us-ascii?Q?6saJQvxtjUOQQui+ndNfzlxxit1BpwvvY36Gl0eYxhP803ISaKsUq03GCD3/?=
 =?us-ascii?Q?okvFlehZmWkkM556K1kkO6yEHCjkRh2javrAvZkxLycmT8vF3PanNlhWgWCX?=
 =?us-ascii?Q?kat6uefbzEAvU2wXcvosFDfKRpRVi3/0JS68+3vY6u3smPDBmCtzJiNfW5uM?=
 =?us-ascii?Q?8UCBvu6rLbOTlV4BnPqHUAh03+qnFNnQjiUzNercRBv8bTQXDhnAiQCYlEmq?=
 =?us-ascii?Q?grRfp0u6J/ShircvK/Z6cbAud6GDpCthmCvvV9gNYn5rzW+bkH3G8ePXzR2q?=
 =?us-ascii?Q?U29f6scEWjucfKFq2TSmCHO7QU1PF/HRHBPmodL9FgVDdNwECRDA0pS5YeUn?=
 =?us-ascii?Q?Y92WSSyhutEzO2VL/G17o6zQKtXL3qZoY7ALMxuO+ELWU8IhxjtnJ9iyVioh?=
 =?us-ascii?Q?3qBTMThMveqRaGl+Yaoa8xYEak6Yca1DWhutNNcX0Hivne9x0oe5nSs/2iS6?=
 =?us-ascii?Q?kiH7Dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XJw1q9c+dzAjKbFKjiRj688cE36QrzT7o+IwyoDqnqYJ6S0j6SoS9gqLdtKLCROS4oD77n25sfDeg0qpj7ckumISb+e8fZtMVdLyXDnGCimh1IaqrcZ9vvP8XblB48fyQ4X4OoCbWQKgB5LnGJZlzqorI4nwvBH6IzsnP9AL7N7IBoZGhr+xd+zkOMLW/AHWGQzxnFjAHKtuyrt6MRZjwaLaVrc23MjCANxbN6TluGuE0+UPLcVU3r/ef+xC8fbgy+nCLZdRgxjXM65bJIXZkdZAnsaaY21XQOiDjQXM2XR+6EGOe1UZEzj4aZrF3a4hTeBeGTZ6TkQUkSA+TzbX0apLE29JtSqRZdnbgD2CNRG5BIjjOCfrIkY0VpiswJEUsuW8ncl6Rbtj/YPXmmW9GL9ZDh2EzcFGm7nCiXT6eZeQeo1tUQp2ljq6jmu1moF2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:09.3648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3765e7-e2c1-4384-4767-08de68ee14e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

Use it to get the doorbell range and aggregated doorbell
enablement and offset. This patch only supports VCN for now.

V2 - drop VPE and use vcn.agdb_offset saved in
     umsch_mm_agdb_index_init() (suggested by Alex)

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 18 ++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f512b6ec6c53..1b935d285053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1425,6 +1425,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_DOORBELL: {
+		struct drm_amdgpu_info_doorbell doorbell_info = {};
+		/* note: may need to check asic_type */
+		switch (info->query_hw_ip.type) {
+		case AMDGPU_HW_IP_VCN_ENC:
+			if (adev->agdb_bo) {
+				doorbell_info.agdb_enable = 1;
+				doorbell_info.agdb_offset = adev->vcn.agdb_offset;
+			}
+			doorbell_info.index_start = adev->doorbell_index.vcn.vcn_ring0_1 << 1;
+			doorbell_info.index_end = (adev->doorbell_index.vcn.vcn_ring6_7 << 1) + 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return copy_to_user(out, &doorbell_info,
+				    min((size_t)size, sizeof(doorbell_info))) ? -EFAULT : 0;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3e7c12d5987f..902201303700 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1279,6 +1279,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query doorbell info */
+#define AMDGPU_INFO_DOORBELL			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1688,6 +1690,17 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+/* for AMDGPU_INFO_DOORBELL query */
+struct drm_amdgpu_info_doorbell {
+	__u32 index_start;
+	/* could be equal to index_start */
+	__u32 index_end;
+	/* aggregated doorbell, 0 for disable */
+	__u32 agdb_enable;
+	/* if agdb_enable, it is a value in [index_start, index_end] */
+	__u32 agdb_offset;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.43.0

