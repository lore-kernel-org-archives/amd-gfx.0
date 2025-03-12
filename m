Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E609C35FF5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C3110E7B6;
	Wed, 12 Mar 2025 18:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00ZYRig4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5169A10E7A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqEibbE6b5U96eUSHvGfuJEDsTkwIf1bvYaBZ6q5s517h4RthHXd1RRwKgcVDoMm0ZQJ65P8yMWQ2HmacMFpP4oqF1kzW9vj0KPUGAvVOsqZ8gNKW1NN9Km0NxceTuTWorDP0KvZBttNLav6vjSZXzh8JCI+FVuzU6/wWt1Ylw5x74ZUyjKyWRmqf8XYQOrXhElJlkfaa7y0NDReKOkpGjXGFOh2oak+3lgGGEd44NuBMw+3umxmJviUBphPGOKF/b2NtrhQ/aq0hItuEnfHe1LW7HiARiZ7+TwiqXNhBaEqehi5rLJSxjYQjQOCsNeXoKbL2I36EmqwBpRViYjLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=AjzIUv9kx5x0LS59hpybb6dWTgM+iG09L2NBZkQBv9lJVjnqd5KOrL57y/LgEWdZOM2YPi3qXR5i8BauqywQFF4J3vLZEBP2Aa8II4/ZKM/9GYFrcDwCUvigjvEbBCLCZaAK4A1yDEU7KRN7ZGAFliaznRI0ei3PLKmEzTcHSBTM6KcJEZOg4Xr+6DrqwaKuYZbFjdi8npb+Wg5OAN85GCakC0ksSqTDn7RDoEMqGgCsBw6q1X7ACW+pWdu4OGdPVRglpWtTDgO/7kuVgFbVpamS5Ec00iNFFhfpqdibo1vlNVjtKv+mfiOqevsfGW+hoYYLTKO97jpkQtcX0oKm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0EhQIz4W0DWkwIX/GicJMAJXptGDqbO98sGli8gKYc=;
 b=00ZYRig4+e8HqMNpxuC4WwY7bqDmXjs2t2Nxy3sb4KSVPESKwgGcs+7zOMrAp6tC7OOPVAm8FD80IHxPDNK5FMEWNkVfWG/GPG0E+FlHhiIW0ryVHNk5fs9uVk+EJszju4tfo5ekAOW+CAzH0cErNB4BPVE/aoin1zvk3OlKcUo=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 18:57:53 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::35) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 18:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 18:57:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 13:57:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 10/11] drm/amdgpu/sdma6: add support for disable_kq
Date: Wed, 12 Mar 2025 14:57:30 -0400
Message-ID: <20250312185731.211350-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312185731.211350-1-alexander.deucher@amd.com>
References: <20250312185731.211350-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e6f254-3f9d-4844-91ae-08dd6197cb43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A2mu0UKvLNWaRRVTavR7tA1ANtovyMGd0CEw0Kw9npFhEWnRLdUMYPx4BCQO?=
 =?us-ascii?Q?psiHWFUpnBLg7iBFJAsmSf6eZELCeU4N/obxL4yl2xtKFXZJHPgTg3PTUWEY?=
 =?us-ascii?Q?xq/pphpk9D0xdwqqfhGVNfrrD4HGrLddaBPIkz6fWoZ9uX9ZOZezNqFe27di?=
 =?us-ascii?Q?GdAZdb6U7uLS+p3E0t8hoFTi2SnW5U/9v/X8a25dSFs9gQJxG47+hSF/6OMX?=
 =?us-ascii?Q?yomQZ5w6dH60ttc/Vt69ozJl/ysQ6qJNNIG2BNLKsXaUGP4yEBee7peK5ipm?=
 =?us-ascii?Q?IAPSIdyvAItutjdxpsdLBVyt0fC7crtIc4WFhSUnQRO7X6CD2NvgrwTkO8ts?=
 =?us-ascii?Q?7U0mNg+fSp0T+ApE1jpJb08PbmbclCZyt+nPbsB5F3r4NQkUp+DvZHkSstni?=
 =?us-ascii?Q?qujHPbBHVhaheLfUiu7ovJUUxz2M9o6iNT2nvUiWLOVnYOhG0ItmWuVld7Ei?=
 =?us-ascii?Q?CVxaTXlJWdn3g2bKCRHKz/nVZcyjPkefwf45FcSPr4vG+ODan4g8Ukq/ufCk?=
 =?us-ascii?Q?m82Qy7Pz4cMxwFOxT85BeynRP/EnSBVWg9yRhKP1BLEh+hs8vFQ+i64PZk3l?=
 =?us-ascii?Q?gxA09800GlsQ3FiG7jF/SOHIBqy6fm75enrKPhJy3Zwj5xnieByOxpS62UgO?=
 =?us-ascii?Q?xyaJx+5njlkVOjxi5m4qV/garGPixKv/12GYFDQbKbWx5saTv42T2RrZvrxg?=
 =?us-ascii?Q?V1X6VNKhDKmamvz7FKlrR743Itr7yZSFM8SDr84Ib25HJdrBAlC8CFYCedKe?=
 =?us-ascii?Q?Eu0Vflq/DBLMoA1dJE8iLaI48ivYxd46exJMnIzvR1de3kUkyFBqnrHbN0rE?=
 =?us-ascii?Q?lTCBds/waBTGK9pEdFgvtigiDnaHkrp672+V+xyo4f0hATnGa3g39yhuQayN?=
 =?us-ascii?Q?IHr76FkQvV7SiimuaLXcavDDP+aLhZNUrZEO2otLspzrkgLT3RCgYNnsiHcO?=
 =?us-ascii?Q?bIMbaJjwHlgqaXNIDjR+9Skr6luvgy65Oid5ipQpb8ISg6xS4WYroAtaxVvI?=
 =?us-ascii?Q?S7WdqQ6369ktYaQrKdh952shjGJKhJ26v72QVWXjbUt2ft//RT2eufjbOJW7?=
 =?us-ascii?Q?rUJC98q+FTQrp2erPPVk1yVpz9dnzsf7Kl3BGDudOQvOwW8fUFSsnurZ50pv?=
 =?us-ascii?Q?9xRtPToSY/LB9UI2lU1wtdgYdE8RlYtuaUHXeDjaBUk+XDdq2dp3F05LlKyY?=
 =?us-ascii?Q?kULTCCbEtDGw+tKt7sLoWcjykkvTKQW9kwfwrfEGWyycwmfWcTY48PICIrlt?=
 =?us-ascii?Q?UfKYXCxQNwpOA/d4RxFcAFZsf5Q1cUOCWUTbTOIShAGZR0HwYR78F2iCcHrH?=
 =?us-ascii?Q?JYAqAvMIlh7JALObDvmU85sRO1I6WiFjoWApw4jHGvXpUXfn4DrHDKx93u46?=
 =?us-ascii?Q?d1XyLqzd5mivxcjsowm+eM9mTzw5CrKkePtpSRefe1dyZdo85XgWkiv13zA0?=
 =?us-ascii?Q?WufRovEhqN5mF+2lgVI26fMMKPGG6/jOVimLNTRyHOzh9TNHYPbCXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:57:53.4012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e6f254-3f9d-4844-91ae-08dd6197cb43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
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

When the parameter is set, disable user submissions
to kernel queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3aa4fec4d9e4a..bcc72737f8084 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1304,6 +1304,9 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_disable_kq == 1)
+		adev->sdma.no_user_submission = true;
+
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
 		return r;
@@ -1338,6 +1341,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->ring_obj = NULL;
 		ring->use_doorbell = true;
 		ring->me = i;
+		ring->no_user_submission = adev->sdma.no_user_submission;
 
 		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n", i,
 				ring->use_doorbell?"true":"false");
-- 
2.48.1

