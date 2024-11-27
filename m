Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B61D6ACFA
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2024 18:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9123989FD4;
	Wed, 27 Nov 2024 18:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1G71N2q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8469889FD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2024 18:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw2QMYgxZyBNeMF1zEqOKD3PdFogx+xOUCgMzaHF0pjfb8uwow+YrqxbLXpSCQQ7FHSJ23KrSkqMTvwpNDKTl/I2RVmFqryeQ5K8D2yZ6FeKodzQT1V9KphESSkfn3CAzHqt8TAJF3E8om0V1HF403dPORN1WZc0n2CV0hlNZIhL51+L5aL1OeUWquKtanRFdYfQeTR3FgCM2z3k3zGNd6v6Gk1pWiPK0RgYmpVVlr6Xa7ksI2oCdVSiiHQWrekv1r3LVO7fR0x10JniBNSfJ79yYSEMAeAR8gv3DUeEEKmDlCy9FAG97QAw1Fp7VsEyzu0iJBoQrrQFIaYDcwzURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLchUNmyBo3q1nlMv+8z39lQrv7pK+trTtKZKDo7OwI=;
 b=K93ecYW+DIRs2Mh4VAUrOslsGtLez/AYZBH+rgJasZ7bB3iZUGFe6buqbgW4d2E1z4ix6GGzk6ffWqaQZ6Gk4Dg5bnxtpjOZk222/Pf1eZYDzvp2jevpNzVYu7ML8WuZVbOSzJhwBsRDmsJLzN1RzWIs5iNy7lSPnbR7PUSQcpOx4yUjM6Uw7Ngsrgn/3I0kRHDTIALosuDhKIMY0DYVu1/4IZ8Ps4VV1KkLyuLje3Hk0/NHEiPk+s5EuxHgCHTYjX0EB4Wc/QgUmkFBsHu6ZFpW/R8LqFaFZ1mdUmno3OlMmEyPcBQQ0yY77KO/yjQi5a525fOjJiess+l/bnizpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLchUNmyBo3q1nlMv+8z39lQrv7pK+trTtKZKDo7OwI=;
 b=M1G71N2qg7Djshwq6XKWBiHkHM1ZiGSctdXJr6QkvGhd3//gKNjDfMm3Nq3O3ss/V+ObrydqSTPhxYRAMS2lCC5ZhZXYlxOHVjhgvYmPAnzBVHvCJToUH/bC3u1S+5Y7K/T23i3WNUMDOGx/uoQzuNda5W4YhNCZdmEhNwdwgY8=
Received: from BYAPR07CA0090.namprd07.prod.outlook.com (2603:10b6:a03:12b::31)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 18:12:40 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::46) by BYAPR07CA0090.outlook.office365.com
 (2603:10b6:a03:12b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 18:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Wed, 27 Nov 2024 18:12:39 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Nov
 2024 12:12:38 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Yat Sin <David.YatSin@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: hard-code cacheline for gc943,gc944
Date: Wed, 27 Nov 2024 13:12:24 -0500
Message-ID: <20241127181224.2894983-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 908193bd-48c1-44ac-61b4-08dd0f0f145e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dqxBhwZNRf7bKby+QSyIOdMXgMqAKJEzrDjev5jY5pO92tDuuQK9GFXPAm/7?=
 =?us-ascii?Q?15EPLf3isDvIMwttexftmm4eGdGZhiBJPygiO9klwdWziP7M5H//fmznkkms?=
 =?us-ascii?Q?TlnmCT2AkwzdqMtk4vFQffefOA6e4wn6/CU3V/yrthhbriW5kJ2/RftMkqNq?=
 =?us-ascii?Q?VDjuIpucbWmCdvl+alewa2/2wGxKYghxk2xAV5uAdG2w0wEUCjf6P6FUhi7T?=
 =?us-ascii?Q?iIYFlcZ9mjG9FN94DXoRpNC/4chsYGDBmY6QyZN+ofwbpdt8csFNAIRHerxt?=
 =?us-ascii?Q?2ybU7UJtpRHWCTMlJ5vFEAAgbDRUGcyBxxI7hgdnvejmosQDSEn4WmrvzSzr?=
 =?us-ascii?Q?VSvwrdcyMVNsC/1zvww5GCK2TzBCaclCc66UfILX1DBjRtLJ3+qv9092uND6?=
 =?us-ascii?Q?Vt2um+Mo9y4vImkvwXxIq/G6gOM4U/qcVvBrT3pYMPpuaNblH2tGvuktWJpc?=
 =?us-ascii?Q?Bd0FOi7UASpj3rb0PuROGmK2Qi6oMTaO6mRg58C9wUmJAtBjTh1EB9JKNyWK?=
 =?us-ascii?Q?HwGnuslg6fmltJPaJZoUVMNJi6m2jFFXjC5BgCMTD1Hjdafn+yf7I1L9w7kU?=
 =?us-ascii?Q?eHe/BWk0134SbWAOXwIEgwukJkkPO9uAiCxDQy+cUaJlrC4WNqRdIbkvscPa?=
 =?us-ascii?Q?cNeEjIBoKA2DmDCxT1LF0k9ywQPvul6EFXJWQddRkNmd0eQxs9pynB3lsrul?=
 =?us-ascii?Q?fm4uwPExxZU2j3ijqzau2i30TuGupeohe5IVAK/i5mnM+PGMWba0SPMp8O7y?=
 =?us-ascii?Q?7fVW3xUZmR3rSYpaI96AebNzsDfsEokBNn/STjImMQkFgBc0MwU29d6+6ary?=
 =?us-ascii?Q?k39s5KQqK5BHf86zWqM0zCTQIWzr0rCImVrHqSN0PbvNScfSHfDBi5gkbZHl?=
 =?us-ascii?Q?mNk+ZwgXz1AR9vhK2+dPI0aoFPKkVS7RHaWIVKbQSYEmby0diXr4gjFXqz3m?=
 =?us-ascii?Q?a6DH7vMBE56jPIGUvadA850tm5rlG0bCnfHKa4mB1FASdH2QfrjtY8oLPvjY?=
 =?us-ascii?Q?5MI8ggL7hx4iwrCOhlyJ8Fqq6y0zdOOjWVaMQjVy/9lT2jkNLoZOZM9pVA55?=
 =?us-ascii?Q?FvQLEtfAD+VoKYIq9fEo0/pu2+gBprw1k5iivmuDTsyPO9fRr4jl/kIN4V5E?=
 =?us-ascii?Q?9fARk1eE0KBm2e8zW9YGy4qRfNLLQIvBXh2x6Ui3bolKbOy7gLsthm6MTTJE?=
 =?us-ascii?Q?7O6JulVm0FrN5iypdGzxQAJBMUpnlf0YtvSTGHnBEY/3qgH4NY+32qgVo3DK?=
 =?us-ascii?Q?qmK4LCH/bM1kpnOewjsJlx2dk0N5JjK/bxH0Z66A5us2bn5WYn23TZV0JK7x?=
 =?us-ascii?Q?XIBs/S2SEXy0SHVz2g99hBKYQ6kGWMAYD2Nf6ibfc+/gzOadcSmnhrArLfMZ?=
 =?us-ascii?Q?MshDvx0sLTVBbi5j7S7Yr8GAo/+vVfKaLYhWIKWsoRfKgUErvYEzLt02dikS?=
 =?us-ascii?Q?W11GW+maoQcE6vxqMLgg9B5fO8J5HUkX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 18:12:39.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 908193bd-48c1-44ac-61b4-08dd0f0f145e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

Cacheline size is not available in IP discovery for gc943,gc944.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cd7b81b7b939..3a43c816f03d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1503,6 +1503,8 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 	if (adev->gfx.config.gc_tcp_size_per_cu) {
 		pcache_info[i].cache_size = adev->gfx.config.gc_tcp_size_per_cu;
 		pcache_info[i].cache_level = 1;
+		/* Cacheline size not available in IP discovery for gc943,gc944 */
+		pcache_info[i].cache_line_size = 128;
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
@@ -1514,6 +1516,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 		pcache_info[i].cache_size =
 			adev->gfx.config.gc_l1_instruction_cache_size_per_sqc;
 		pcache_info[i].cache_level = 1;
+		pcache_info[i].cache_line_size = 64;
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_INST_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
@@ -1524,6 +1527,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 	if (adev->gfx.config.gc_l1_data_cache_size_per_sqc) {
 		pcache_info[i].cache_size = adev->gfx.config.gc_l1_data_cache_size_per_sqc;
 		pcache_info[i].cache_level = 1;
+		pcache_info[i].cache_line_size = 64;
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
@@ -1534,6 +1538,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 	if (adev->gfx.config.gc_tcc_size) {
 		pcache_info[i].cache_size = adev->gfx.config.gc_tcc_size;
 		pcache_info[i].cache_level = 2;
+		pcache_info[i].cache_line_size = 128;
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
@@ -1544,6 +1549,7 @@ static int kfd_fill_gpu_cache_info_from_gfx_config_v2(struct kfd_dev *kdev,
 	if (adev->gmc.mall_size) {
 		pcache_info[i].cache_size = adev->gmc.mall_size / 1024;
 		pcache_info[i].cache_level = 3;
+		pcache_info[i].cache_line_size = 64;
 		pcache_info[i].flags = (CRAT_CACHE_FLAGS_ENABLED |
 					CRAT_CACHE_FLAGS_DATA_CACHE |
 					CRAT_CACHE_FLAGS_SIMD_CACHE);
-- 
2.34.1

