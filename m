Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E10BCF2560
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D8E10E53E;
	Tue, 18 Nov 2025 22:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rRSIfPKu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA0B10E53F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:58:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhv7RVSO7c6iTpb356sQr3ZbAr7G5B1LpFUo9N0nwiSFQ/AZsJNTnbR6Vidwq7N/E+kAOdGDnnb7XPClk4IpCSKP5gv8+IAIuvSwq//ei/Z5YL5aSJo+IMMl7B04HVVhp7xt+Ep6q8CMdE52A0FOGzwM8JkaB01ouChd6HNsUpmkRsK7rWzVU2hPKqg6yGS9/3JS2/t0RzH8PZSMWnMIfjdP+CBFRGGLXB/IRPkBX3g1gulNFgqy0kFhb/NRFImVFY+EQkpdmEKZEEEJWXgTX+TX5+xUXCeGeFZ83QW0UpsOiAS5PTSzXhkMU1Va38hoVKw/NZ9XdhMVsiaqPCniUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frohGxyPd4I8SRtaBbkpr2/X8VGNzv6R+amV2X4niwQ=;
 b=Es8aIrb5FPXaZL6wLWcK1fZv2jHZq1kbVWCwDzu/lDjw0snpjHrJ7CuzZUqwR6UQsTI0R4o4sPRd/SlPpWAnaZBWwqHzytIDw/D0t3QLHO82SkplYpzreL1onFe/bvGnoD29vw+tBoFCSz2E1grvCwBKOUHbfYkkL+HD7ehOY8oCVIkUzap+3w6/pW/KP/VQpFbkZoYT/lzikzDUQLQnQ6C6q7njP1m1vxukcfSapiEjtLkGf5TDej/eihQ9ZpuHEgyQZSPbx9ObHDLRDHTMwbeVOCnGBmIowdHNK05R3BLj/qrmCVL1wsXHRsvaBOLOaAdl4XRNgN+Po7pWNbIryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frohGxyPd4I8SRtaBbkpr2/X8VGNzv6R+amV2X4niwQ=;
 b=rRSIfPKuVjMpzVdmzKG4+uu3zzTeUdv1VdiVYDPaGx++2rTKD6ttSr0pc+TyLqBA8t1DXDbyyQ2JC5Mn+Rfk9rwg0Z5YYkD9i7vgtoxoCwv4QBbGWqrcSeG5pBLrsEkdm4zL/2fQC+mMNQIKcKeiPFQ4OWiRF+NkvvhUiLbfPZc=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.18; Tue, 18 Nov 2025 22:58:08 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::8) by CH2PR17CA0024.outlook.office365.com
 (2603:10b6:610:53::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:58:05 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:58:03 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Upload a single sdma fw copy when using psp
 v15.0.8
Date: Tue, 18 Nov 2025 17:57:49 -0500
Message-ID: <20251118225750.3613219-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118225750.3613219-1-alexander.deucher@amd.com>
References: <20251118225750.3613219-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 956af0b4-f76d-4985-7f83-08de26f5ef48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W04LkdXhKMQMhBemNr9moNZifmw5SxBXtXs6VXNCSyNugHgjzM2EdX4Yyl1K?=
 =?us-ascii?Q?kRJQitIQgV9AT19NbzeopOybwklh3dBzfpoVNd7jeY8AoOmR49igxe4jrzX3?=
 =?us-ascii?Q?oFy3FUh9+6O8eGisIrOpTq4kTuV2zWTNSYyI1+LF82GutbaWb0emYdKX1JTz?=
 =?us-ascii?Q?jkmU2T32nwsmBQl+UqzO725rz5nemRWBue2pEqdPhCwPZ7KK+aW3XqUVOR8q?=
 =?us-ascii?Q?ZWlNKQeo+yrPiUqy17rVmy+4t9zBwy9p4MALhnhch84sKz7hE8OhpOvIxr5S?=
 =?us-ascii?Q?VSNBXTKIoL23IEzGqVfp3gKZ401+PpJb+b5AIS4cpjhpZ7d6erMvQYevz1pJ?=
 =?us-ascii?Q?RcgI9oV5nWZEaWYo3kWRl49X3/nCRxa8NLgKOp0/pVZy+zBdmEXnq4RZB05l?=
 =?us-ascii?Q?P5qx4NRdqrSiMyLl3Hio+hGTl2OsqCkzYsH3cgEMw17AI3NH8lwdSz8EK9UA?=
 =?us-ascii?Q?WIFkn8vyGMgsktLbhaMbL1mLBsJqql+maCwIrNzyaA5nyyN/+id5RjcjNsG+?=
 =?us-ascii?Q?3O0EjRdZC4IrtBOg1s/yD3bLzfs9iqTruD1jVzcdduXrMRshrlC1Jd3tByPw?=
 =?us-ascii?Q?zmoM1HhrCatNs2agb08ZfQw+4AW77hZQwNQ1XwoxvWjbjLf0Wsadz35fsghz?=
 =?us-ascii?Q?yE/eEa6Hhb5+QR7jNiBywzYuoySRG62bf4Lf8hmNiiS+MlCf9oHwy6cveadz?=
 =?us-ascii?Q?hvOF4w2iRJP4ZWmc97FbZFEcpu0QR0SF8HbFClKl2ZJgjemJVpHG0jH8c9rU?=
 =?us-ascii?Q?fWWQaP1HR2PCyyFgaij3Asix2bMqsMrrZGZncbWGZE7Fr6FfZ2l/oF3lk3eU?=
 =?us-ascii?Q?2W5gvD5cz0vJKFHQzKxPtYZ7/76jehLc9V2aOPMbECw59AUDUeGvaDqLb2aJ?=
 =?us-ascii?Q?Uyz/Ooh/rgAwONx72d9dzRPrInp3Sy6n63Z0YP27lsz5LG2HnBv5veg2849w?=
 =?us-ascii?Q?E7jJEd5k3PDRmAsxQKSFYxRJWCkGGeY17QOLfMz8/OXn3bqZ7D6NuCefiWSn?=
 =?us-ascii?Q?59xdWAiSPlDstMX3mAReiNq99/XnAnrY/WdjTX3bbqTsLfGHASisTLZAzqQD?=
 =?us-ascii?Q?Xmve/iO2GbwuhOISBlF68boYhTVjINgNJ+NuPhl9uzlFpCdqBXFOPweLO7jx?=
 =?us-ascii?Q?nhzrBDm3tEzvr+38xjHmwrwM96rF0IkurNg0fxpGwTDI0Olqov2kLg2xps1K?=
 =?us-ascii?Q?SjfBiDckpRLM2z7T+DXgV5mkO/cGNq6EWlgpDcF3ZL7tPBfQq/tsjxaDDnQf?=
 =?us-ascii?Q?1h99Pz843/k9osQH4UOx4rlcXAXNeq4/IlGxzpGdZbdaJkRaq37cjZs6o44Z?=
 =?us-ascii?Q?Z5Y7AFxlZut4GJSXVCXv4ub5UNpDOp5JaQa63Na0ydSnkC0i077qfSb8foGm?=
 =?us-ascii?Q?BJxB4M/RMpMFjpa1Dd6ZaahbbWtx5W8OkfY/Qz7cNF2ks3fRC3dJQC8W5fF9?=
 =?us-ascii?Q?y4dUMFyRXlda55twhypQSCgJDshkhbIUSZwZM9fkTbu/sV0GuKkTBvxXAOzi?=
 =?us-ascii?Q?kY6HFI7XxkfsEtErmzZDmKDwM43VY+2UEKl36H96EVF7jbhhvT311Mn3tn15?=
 =?us-ascii?Q?M0+oYQK/ecs3nS0jsSY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:58:05.6118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956af0b4-f76d-4985-7f83-08de26f5ef48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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

driver only need to upload sdma firmware copy for
all sdma instances when using PSP v15.0.8

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 204005ad6252d..9c1c8b4125fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3085,7 +3085,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(11, 0, 11) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
-			     IP_VERSION(11, 0, 12)) &&
+			     IP_VERSION(11, 0, 12) ||
+		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+			     IP_VERSION(15, 0, 8)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
-- 
2.51.1

