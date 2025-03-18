Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BC6C28B28
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 14:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D253610E48F;
	Tue, 18 Mar 2025 14:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GI94aIWC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D1F10E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdvTTDvWecwtW9s0bU9wu1t6EPqLPZLDE54L9hhE/J+GDrzaPTKFJLORbh4DvRIzOu5qW6EvwkF8H+KwxiU16YgqKEULFMKHLPtgvLAm5JQW0fw1vq2AEzkrvF0hyHzgMIkioQMqDFMapyRzRp+Ro0ShHQDamlegYtLmT6VcyUuvMVH1aKVRLo31SBI7S61wiS4I30p32sJGKm4uC4m4QL28Ww1lDROl7g9BdwcqxUi/JbhZz/JHZRRgjo2FAyB7kF7styCYtrkYIAN+fBdnv1iNxjuUqVV6dtnicqYWIF3tgWKHDD9J0ErIBDmS1K2gcta6D6hwlk8KvWUcsPdhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cthE69uDw3Pd2M9LsexRO81LgvY3ubXkLV0I1MemqwE=;
 b=HiTVYXLNc1KaAtzCwrEkNiwK2enRVFINIPyukga8aS32qcDvAC8w8krfdpdhEcKCfL27ZpJRzUAG5oCgeF2bI0dRjkU9HmVUq3GSikT7ugxf8GHImN4AmARRvg98+49eiCjjr5jdrsq6meAxTvwWsje6ckEydMp5CV1nSSv2cW9VToIXBnisL+s6sAWLAWWmXjfGTUW+2nZenjtgIRRvtz/KRYPnf+zjRgFuWtFSs+LEsAHgJ7c6YVOioIvHm5j9d9n0f8rggck/XFgXzgcfL+AuXHv7V1N6DdCT+TdbaP9YmsIivQS6PsWzQrCt95tO5DaZdodRPPADsuj0AOC4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cthE69uDw3Pd2M9LsexRO81LgvY3ubXkLV0I1MemqwE=;
 b=GI94aIWCSBkc8EoEbs9dhd9fAotX7Ah9WKTnGdl6iIfLMc0GwvFVOHf1MgQgoOafg8VUNYF+XIznXF26Jo30yDfHxfO4tbeSZO13IM7TXUGra24orFsSjjg77GR/hmipIu1ZZNfJngxuJICeAjDi3/MajlJLPpnxMOjXPKHGKug=
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:00:07 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5a) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 14:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Tue, 18 Mar 2025 14:00:06 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Mar 2025 09:00:05 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shravankumar.gande@amd.com>, <Victor.Skvortsov@amd.com>,
 <Ahmad.Rehman@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Enable amdgpu_ras_resume for gfx 9.5.0
Date: Tue, 18 Mar 2025 09:59:55 -0400
Message-ID: <20250318135955.57341-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: a48d88c5-0c4f-4c76-8bc5-08dd6625308a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ORci2QzZSHcUxdXcn5Z/A9X/Apv1juXHFrPR3JvDY93WS0ktwqeWjUMTxY1R?=
 =?us-ascii?Q?t5UCSxVxBKvPjCOQy7NxITyihl7F0gY4h1AjHtvomOwzjk3hQ4yC0TVJwbd7?=
 =?us-ascii?Q?OGHAqHVR3Ewotk/mhDKCQ6ynC78BVV2ki9rp+7kAzvG517XQT/Xy2U/+ALKL?=
 =?us-ascii?Q?qumj2Shi50+SGLKAa+RDq24kIbgea7Wkxg45MLFT9JUcORHZOI1qR6ZI9BQ5?=
 =?us-ascii?Q?pFs0D7bpt0Jn6DjEJJvFkkTB69emoz5qkEbs2PsNbBhs4c3ggX0zSN6DMrxf?=
 =?us-ascii?Q?fWairr7UFDBAdh+NHJTVomkuDMJzMMjpBlIJxjf0nplfOVA07E8rSf4Fh97c?=
 =?us-ascii?Q?4ELptFBAK7LYGae1RstxGOCM/zO4B0iwUrMv1/NqMnsaf/0vOsG2FcE16zOU?=
 =?us-ascii?Q?wPRXyXhnr5vsEJpC8zxi1AJaDQOXQ0pJ1UdpYE69/pt4rcOZJIyRsZxFjs/i?=
 =?us-ascii?Q?C5kwFzt+u5UOnsvdKve7LnnkXxHv2M2P4PVT2JQJ16PuEk2eH/CQL8Ck8B6X?=
 =?us-ascii?Q?rIXDmzgGCCcfWI8GEuKSFENQ/D/5zP86vKaeitAv+UFegan2LMTz/8HOManh?=
 =?us-ascii?Q?Zu67j9TQuPPpcDlGGhWYxQdULAVX68voJZb7oADrKrUO7KcS3lMw2il6VeWN?=
 =?us-ascii?Q?XCyGGUKKpj69e1oZ/+tiQ/Ub3XkV15iXbTXsh9+1D8DqtOAypEscbNaVCQgr?=
 =?us-ascii?Q?wx2mkorundKJvlpjwNxT2+vJ0WwtfOVCe8zM/QAZ0K69ciGRviar+VvJhtTI?=
 =?us-ascii?Q?T99XxKD3LvAlMO5k3OeMlPtJbdZLRu98sZuoBKac/RTMgEFl7/apH1VUTh3m?=
 =?us-ascii?Q?S8IuIo7HuMhaCM4po/T2MHkwdLrUckdb5H/81KpJiSX0XcUo1xjFVi4Th3eO?=
 =?us-ascii?Q?a3lgQs0LSl1PJBNX+epYi0FnJRn3suKKfLmhTMvwMLFa5vgbKNry4k8uSBID?=
 =?us-ascii?Q?628M9zePtr2RMCqZsVBx3nTS1sDgiUB9T82SukTAQBkgxmrCMIdugX2MGDrB?=
 =?us-ascii?Q?rp/h4V52lOndIgBnd0wA9aTauiNpt6ysDdTCxS4XEwATCvFruMRtPWd03k/k?=
 =?us-ascii?Q?fo2L9c44V2AiqkQbz5PQ+ErWF+nbYXz7nuDgHAy+h+MMkA3wZX1hvnGAaOy9?=
 =?us-ascii?Q?We6CyyUi1G3MisK9W/r0pTHyFkeniujs+TzDDUjnmBzRt4Dz8COY8nqSEV8w?=
 =?us-ascii?Q?eJO3EVjYgz7t5xqg8Qrxw7W76GBUFrd0sv2e2NHah3qMOuP70PBYhj2HBmmw?=
 =?us-ascii?Q?DEPU3ygMVio4cCgKBjDz7s2qt9fiYkcP/bTeDz3esn7sc2rtpWDyeZqU5Cfd?=
 =?us-ascii?Q?0PJvng1EVyaNid4XMIsBHv+DgSDuCFsIL4fIfUDiqP5Z4dFkexFgweq4ylOk?=
 =?us-ascii?Q?EEWrdUiTjsuM/NNERsSApgQzr8HLdLuyZji2GcdzJ9GOKSHCs95dOnqN8i3Y?=
 =?us-ascii?Q?VdnkBTyGHDTOkhwBxHlqEi5tHXgNRbbSJw+CuvmJQfBCuphjPEqKAxYUm+qe?=
 =?us-ascii?Q?DKKRq9yGmUZ4oEE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:00:06.8500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48d88c5-0c4f-4c76-8bc5-08dd6625308a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

This enables ras to be resumed after gpu recovery on mi350 sriov.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3e39b01e054c..82001d5ade4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5334,6 +5334,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 3))
 		amdgpu_ras_resume(adev);
 
-- 
2.34.1

