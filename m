Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDE4C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8DF112E32;
	Tue,  6 Feb 2024 20:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TErD4KEj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70C2112E32
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9gE7UBBneNF1aXKXpdrO5W5tDSRYvawwcUL55xTKbsBoD1oisz3PqTZ/rwSiQwwu7PpBqMb/NAUpTJTl6HoSExBpPv9pHXY/yZgF8UGzNDFCRVsle7nEXXNQRQqZ3HRH5WVpNqQ0MYjB31FdVBv+Biy+TMfd9yU+/ah/606MRE3guH4UG1dwUfFHkUvSrYKOWX5aqirkxisGwyxXGEZulgFt0kheVeHGClveXlGsukhqusFPkydLgU8T9EdOroZJSl00TTvMoWUO3OpcO54vWh+y51zkQzKfyphfbAKHyWX6VsVwUdkFVF4VhRHsqUPKNvagGbwJrNCAFk7zNrZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29u+nzjEjdtnV3eOgeBA8Dg7B4O1oLYnXdbEtp9QFHQ=;
 b=e/6hc8S6GqRhJeh1xR3icz0SLJHUBtt4iiws8RfKfldhZ8Rsew7fAqwWEj32BbtQv2UipyjdM4H+84/kSeu6IODLD/reTWF68E6WcJbN1lxFH1nMbPAxNUOZ++0Hoqy7LZQBP2ExhnbYJsYKPwpBzBXrQ6oTmih/ReJPCbHZwIOpj4VFU4JhkRO0EmKfzsYeShHC76jat9o/dk5r172y1KYtz0HDG6E2I0vFOKwsnBd/De9zyG/F5OLyi4a/0kNfb9Qx85I4erfFmtODfuRmmw8e3PxqOmw0BXokUDR22Moe2eV3Ad318HSTkxmjEu/iO1IPWYMskBiaAK9rfmh22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29u+nzjEjdtnV3eOgeBA8Dg7B4O1oLYnXdbEtp9QFHQ=;
 b=TErD4KEjEMGV+fA9Am3Af7WqxGmIZQlsXHEd+jMaKyyT29oGmism7R3Vh0nkRtpj1zcPgKNYT+5/mHoJg78N5CqJdgMF7STwIq87kdCSysxPq7LqYYCv3l1kp8YR85hSxQyjG4nV0Q2D04eI34Aa7iWIcBC2C4+AhWhaF3Baw3c=
Received: from PH7PR17CA0062.namprd17.prod.outlook.com (2603:10b6:510:325::23)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 20:55:54 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::f1) by PH7PR17CA0062.outlook.office365.com
 (2603:10b6:510:325::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:55:54 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:55:53 -0600
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Joseph Greathouse <Joseph.Greathouse@amd.com>
Subject: [PATCH] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD topology
Date: Tue, 6 Feb 2024 14:55:24 -0600
Message-ID: <20240206205524.2697359-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 50eda262-ead3-42fe-8fce-08dc2756026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAfTzzl+pk19Gfq5rVb5Nxu5J6v6Un28A64VxsIcNN3DWElgQVQgi4Kp0scSk8+iz5Mhu87IqAuN3OjaHLXqBA8Y9cU1resgyty4alB+fbsv3hnix2+CRl1or9RayytevjiwFOdH4pFGWnWiZ/fAvmu/cua3yySI1aYqlNklsXvTGe7V+4CJTowb/dbSmH0OEM09pHpnA3fR1QqYoAyxXAkRNOdtl28KtiwHe1tIQe1QkjYP3Q1KMBEoC3C9GL/N7SsYqxMm0d4Be/oU/SxMYwhRbDQUcrv7s8GezbB2MSQK3xTJpOyCu+cWrRZy2qZTLLoxCqjwFzfyMkCk8cS3IwlWI+48L378QEtQ2vulCn0zUDCO4XZm9XwI0GGQ9Pt79CT03ohdmhxSoUDKqXS2o7lmJuvzaIniE8JwaiOaHhsz0rC8qpq3gzi1UosLJsA9d2BvnsclBSCMr4kpCINleTHWwNNqVxDCxDxiY111TZnq7teoBaUQ5bzRM1PDOIEXGb/axFS/nKzgmCfj2VYnf1eKkFsD95dqeUFwzhqyse5cGo0aS/RTXDDrW6IkBfXkHLmxpdASTGq9XFOgUVWLRp5e1Jp0C12f6qmJeca5RVbEdnmHEEYQV9SZ8tRCf4d74ZUgF7r8bFCbZhC+H0TpDL6/x/S7qC/Xmd0JZUTEVKxZaYNlLVwQqg+QM87W+Xn5Lm366CU3V6IwSVCZcGTZdFRJQPcUzCGeP/fIDp0fgzb747j29pcUN+SVZQAkavmwnP0DKN2m07ZcfQUC0WjmCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(70586007)(70206006)(336012)(6916009)(8676002)(316002)(36860700001)(40480700001)(40460700003)(356005)(81166007)(426003)(8936002)(4326008)(41300700001)(86362001)(2616005)(26005)(1076003)(36756003)(6666004)(16526019)(7696005)(478600001)(82740400003)(47076005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:55:54.0523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eda262-ead3-42fe-8fce-08dc2756026f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

The current kfd_gpu_cache_info structure is only partially
filled in for some architectures. This means that for devices
where we do not fill in some fields, we can returned
uninitialized values through  the KFD topology.
Zero out the kfd_gpu_cache_info before asking the remaining
fields to be filled in by lower-level functions.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3df2a8ad86fb..67c1e7f84750 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1707,6 +1707,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 
 	gpu_processor_id = dev->node_props.simd_id_base;
 
+	memset(cache_info, 0, sizeof(struct kfd_gpu_cache_info) * KFD_MAX_CACHE_TYPES);
 	pcache_info = cache_info;
 	num_of_cache_types = kfd_get_gpu_cache_info(kdev, &pcache_info);
 	if (!num_of_cache_types) {
-- 
2.20.1

