Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA32E7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB0410E4D6;
	Wed,  4 Dec 2024 15:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y6wvKRI6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA6C10E4D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO4s0E331ymuOFN3t+X0Tv5KKrrq24F3fqW+9bnbmSa6oDJGImYCugplpxGsLbpo7w/iUGIjmv2GGw28nFbKS4crN1j/lnswtfF08DzeL18vedBx31/uQiAUvY4nZ1VZ/JWP3KAyPAxlxg+l2ivvPwOfSTuUoBXlJpM2vAnx3R3nmFbyLgccNRv4JQnNSRVOkn4o8V+WQJpDrmNUdUYKPVASL4bgB5wiRh+0kVv3XHPnzyyT4bd/aFgw5guza1BO0rh+/ScODPXcS2FWQ/t/GovgJz9aMhcDnGnenDZKExOMGrAn9/Cd54edtysbqcdu/dic12t3ddRApbAva3iE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/1Gh/95iXGpadetjKjHzNL4nIMwF/51Dt0/sR/G1O4=;
 b=FfhscgpAhYSETZKLVm+ZcZCN9mbzJV1SGy817EwxJ8h9eassdhzq6HhyHZOE10mSVdDXuuc2W904lptkSH8NCcTH8IaWyQUlHGlD7JVK0vSbGSduXgGdWf4z2CxAgv7hJ3IdttKXWxrDVBXkAdneqhFriF4EMZh/5ASk1EONXVDpqS1ZCu7LQdVfxLZ5ZmnsJIF3gQKCVFGiv9ov++6fXR79JYnGyZg5XxR8nLsBQ6Z6OzwiVIfiuPwJ/i8+coY2j2MyzIAAYEE4lsnk/E5NsFiGnSm8iZM6gWlycDkRY/55wAZs2roE4zF82aEd3FwNCyqd8VUdqXSrR8162IQEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/1Gh/95iXGpadetjKjHzNL4nIMwF/51Dt0/sR/G1O4=;
 b=Y6wvKRI6bX8BGSDGblwu3u07sCoGZrhl7l9/NmDyCcG5u3a5yWdgS/B76TPrHV+MlfOSLoJux7sq8XSa0N8dcreLsJS9Do2G1ZDz2jzGs9ftL1rukYfrvr+STv2Vv+1hZlG9ndiInIlnBe0L8rlzD1ARGxAmM/CLdAKrkv1zEH8=
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 4 Dec
 2024 15:09:32 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::26) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 15:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:09:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:09:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fetch refclock for SMU v13.0.12
Date: Wed, 4 Dec 2024 10:09:13 -0500
Message-ID: <20241204150913.3425270-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204150913.3425270-1-alexander.deucher@amd.com>
References: <20241204150913.3425270-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: b5985fc8-33c0-4856-c7db-08dd1475a7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IurKda/lrS/iKN4wEiyQP/gv+yXjxDFgGllsINDFXzviMKfKFw9GTODg3oGj?=
 =?us-ascii?Q?4sPoqInSSne9U+2ThBFCDItiwRKNqSsPgZTKpMOmuZ+U4S5hrFBP9k1zqWyn?=
 =?us-ascii?Q?wBXyp213i4vYHh2EhO9SLtmN9nSAeSNCXOivTQs4AOHFPfMAo9GaXF/QDhrz?=
 =?us-ascii?Q?WQVFkzstmXOdCaa9z69BuN5ZvvZDF6+97VA039ZVJq2vghC1UF/In4Wq3ZtS?=
 =?us-ascii?Q?DRpblwsztKOO6PR19L2brqmMNOyBq8oJhNMMGGQx8z7Cy8DsYTgbVvhjIUsi?=
 =?us-ascii?Q?6h+uzfoQPvqlf7AIRJEvFBt7sb9mEzyTij2Xa9u+nEj7BmxUpfZoygqFA3ee?=
 =?us-ascii?Q?K3ZFU7v/zJEqBw1Wugkz47NuMlrdGCWmE9wLx3U62m2b4BWfK5ksLPwfFmPV?=
 =?us-ascii?Q?Z89S6uv8hMMV250NON5vpYvBqVbcca+LgvpybIaZPrPpM05c01cZWFmhhmFq?=
 =?us-ascii?Q?e0Yay6eauqOmekL+BP4c21juVo84t/1UksRkRBJCnI3TOqA+xpP9yKiwO8NK?=
 =?us-ascii?Q?Z0tgak9WcNkXMMdntt7dOy+ZQ2tBJ8a1A7oWZ57IzCvnX8wnvaQD7E6x5XCr?=
 =?us-ascii?Q?Nxs3M4bRzQxbwhQHcTxFDL6BVd0TzIbbpm1OiuxGVsVeCIEC7E/PQgTDytR1?=
 =?us-ascii?Q?YUCWylA9lcOnx18j8uDJujhrLLunQ0yexvNjLIZytE6YvkYHcqgQZeD/c6TV?=
 =?us-ascii?Q?0kRbrVTDSeBqvPvnMyqeFv8/wQwNjAnP3r/GXEdI7Ycpqbhsln4jPgM162EM?=
 =?us-ascii?Q?tGzYydTl2TOit0kmXSKfEsNQxmihVfwV7WQOs0sJwbFq7JwO4ZBsEY6ydjNU?=
 =?us-ascii?Q?M8UldBh2/26C/Dj44cB175MzoWPkcGlB7kEKRIFwrOr7SS+CqcOkJ61d8fak?=
 =?us-ascii?Q?sT1a/Ct+kENiQIY17iuNbKwgujeVFQN6dIIEplgFeVntYIVuDjPrHEvqfFHO?=
 =?us-ascii?Q?SC8ChBzm+ej4mJAUjjabpBrTRZD7Ix8v6V0bNiK7E6q5PRrhmTNeVIITkE2n?=
 =?us-ascii?Q?IJjXDzgMsP4AE4t8a3omLL5NTAnpGvkjDXFe1lCSVO88dlnUAIOLmB2ZUYnp?=
 =?us-ascii?Q?ITBPg+RgcegsZBX4chTz/IAA/Zp1/05pTtTKlPuMA2iACPFnKIqjR8FspUeI?=
 =?us-ascii?Q?kbPlDWMw1w2oDeaJW10IR2K3cXniglA55EI7L3wekR333R8qKrKPhEg43ERo?=
 =?us-ascii?Q?AVaIq6Ino9XGIdHe/bZGKRD4s2aevK+apzbZBibtUhouClxcI2cDL7/lHoDZ?=
 =?us-ascii?Q?cj8iE9FGGIULzH2DICcFVkg+M5uVyFkgX5ArJmSYthY/x7b/X1kHH4kpDWMI?=
 =?us-ascii?Q?/Xxn05nyqQgEcOEFb4DyJZO4jLblX+m9lbWpbGqdRFyxQZ+heooO0GMjIMzY?=
 =?us-ascii?Q?vEcQoQwN0aMwepagE7xKba2jNMZBFpRBRZ/+3K4DaLo98jf/vbJH2zk8ATxO?=
 =?us-ascii?Q?Ocnh3UpjeY0RijqzptRiDqROyIViGH+l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:09:31.1829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5985fc8-33c0-4856-c7db-08dd1475a7ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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

From: Asad Kamal <asad.kamal@amd.com>

Add support to fetch refclock value for SMU v13.0.12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 020530f978142..3bb4a573e07b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -327,6 +327,7 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(12, 0, 0) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(12, 0, 1) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 14))
 		return 10000;
 	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(10, 0, 0) ||
-- 
2.47.0

