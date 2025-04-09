Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DEEC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 09:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A05110E816;
	Wed,  9 Apr 2025 09:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DCF7TRhh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A11F10E813
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 09:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIhfGWv8/jtAfBkRmgBKGcXBTpmWWTwZ0cnNde9EFNFtij0C8nBjC+tyw5OnQBMiUc8+BBrrDwBp5Pd/nLiDC5szcAMUuJp9VFsvRQH9PbGoZGELg2Tioui8ZDy0LPj6TkSNB2xKI9Ut5wUEoygvgrwxJvUuyZssmpPqlH3/7EHB7aoRMxgfgR9lTyJK9gl5NVTCCaDUtiG2p91oQMRAF/YEoDBWX4E3kOkVkljVVH/rZJdDW5pEUrS3t6izqtjiskcjzvdP3+tvdawXmtazM4oHvhQuIHKDFJ0KkMYnR7IYt+QeLD1yYxTeDHHBrUcjUEEXBmYsOH7V7lN1UfGenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGXSthIJbCB229/246gIklDXxglwy+nKafjWxFjDMGk=;
 b=VVZTMeJH9oZ87AkZEHBundgk770zagsTsWBmjR2DUd1UbAOrACdQpaB6Nu37xuuleAZdVb3EvM9+gRS27EY2oU5b1xtjPMTOcDCndGodaXPjcYO0sISAjVyKNADF0EYrPzV9Hwd4bSqiIBBW/PphyTce7cYpXKXCt4M1aB001WqE8s7GeSnEbhJYNIiHnIvngtoMnUF3VqlJXpNWX6kbBbi1pk3BZ5C8pwzggPDXnph8oc6ZQhDgFtZupF2aJBuphK8wcc/O/8PW5Bhz/ufTa09JzOIhC2fZaAQiTSpgtmmKygFMMtqnfhER2aA6vh3GxozDiP8SxBOgvncph1Om4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGXSthIJbCB229/246gIklDXxglwy+nKafjWxFjDMGk=;
 b=DCF7TRhh5Ae6uPfxGRvwOM0IMP4KC66Fe2mFrGfjVHK/7wvWIqOftVXCQ4frqthEO6nJozJmd6r+SwbbGO7U1u6hAN41+v4uaghk4g8hEZH3n+sDmfXkJIOcVF+tg434Ddf/X/4WQUqIYYw9iTl49kR/NZw4VU440FFMQxJw4sc=
Received: from BN9PR03CA0546.namprd03.prod.outlook.com (2603:10b6:408:138::11)
 by SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 09:16:49 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::b) by BN9PR03CA0546.outlook.office365.com
 (2603:10b6:408:138::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Wed,
 9 Apr 2025 09:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 09:16:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 04:16:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 04:16:48 -0500
Received: from chengjya-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 9 Apr 2025 04:16:46 -0500
From: chengjya <chengjya@amd.com>
To: <Roman.Li@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dominik.kaszewski@amd.com>, <daniel.wheeler@amd.com>, <alvin.lee2@amd.com>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Bob.Zhou@amd.com>, chengjya <chengjya@amd.com>
Subject: [PATCH] drm/amd/display: Fix drm_err argument type error
Date: Wed, 9 Apr 2025 17:16:40 +0800
Message-ID: <20250409091640.122655-1-chengjya@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: bff7ffe0-ada3-43fb-7f41-08dd774741eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eZAS8FbrdqlfvafQXC6WX2hWiEmeKlVD1v6OXFVa96lFvaDAYV9BWYf01NMv?=
 =?us-ascii?Q?ERUJkQqBOHw8LWWwoNzfBCTY5Sk2R+pc/GB2yJMj0L4ktulYGR0m2NnJNpiQ?=
 =?us-ascii?Q?nq2slgCip8nipaVa1Dytqt7ZyO5vj6mx2k29jKzyfPVfmCoGLFZKtvr2CnU2?=
 =?us-ascii?Q?vi4gV8FWavgob14r+oCM+/63CaSKljKufRpl8TSeOPtJnwSELQLiBxX43Yh/?=
 =?us-ascii?Q?RgPF2KuQrI7PsKKLrFuIX3sDtPXk3Xc5kZ2pszULYeOIsLO7H/+z88mmehfp?=
 =?us-ascii?Q?9FMhGjQdhTuD3rXcTg9dOicBVPvkAyuVoELuu4J73Z6Sr9h6X629nvwmt/fh?=
 =?us-ascii?Q?3G0/JSoI8c37M4uhUtG13dZDwd/YIueC140Ci4/vda3f9RVoTJ4QV78FNy9Y?=
 =?us-ascii?Q?gZzwzzSZ9lLMAIb1dBxOz1j+FjgEXKS5osNFVFVJijtVX3dRiexX7Fb1J3z8?=
 =?us-ascii?Q?pHcRYIH8fz+Dh9MZegpTGtdnuQRMrzMX6IYBvIn1SV0+5g9EL70M0VC3ky+H?=
 =?us-ascii?Q?wYi5/cWiKsFFGUTjyE1WvSKKXUkhRb4lUezzTik81iFst8uJF4D3L7zxkY5O?=
 =?us-ascii?Q?zlAtYAJrIQP3/55UjZPeRX2P3dUjNrWx4ZE3DY4u2h3WYPyDUTF/lH3iQ0wH?=
 =?us-ascii?Q?6Vr7wVVcRi3jTGPRcHZo9Xft6QgGnS4ROABsQCz+Z1GXYoi3FdNENnxEOryo?=
 =?us-ascii?Q?8+hx6Pv9BLJRy39ypPUxMfKNAkqe7LDiR0GpnOpwjDJ6QEkUKEP5PIwadFYg?=
 =?us-ascii?Q?IXza+7f6wkHyeZDbTo2EyT0seO+c5eigYSaicuzkqxS/mMwedpTcFQJnacvH?=
 =?us-ascii?Q?AckPC/GUjpe83BVQCXf7ZkYQTX9Sn4MB/8WzMPpXaU/VjYycOmVhu1ML4Nga?=
 =?us-ascii?Q?3wo6sjXiNw+CijEqByiTywmBpQ7Pg0mjIVcbYVffa5xAqdrJS2hGH7xFT+eC?=
 =?us-ascii?Q?zSi20h0BNDInRAx0lykvT/qB9jiZ+1U2Pf8vaLTCKI69NzJkGH1GeW5v0gw8?=
 =?us-ascii?Q?/Puf3ZIsrJm5WkSzo6hPzszKBgkRGgkH/JCVuPAu6sye1bMH01TJ9qcYLOnc?=
 =?us-ascii?Q?ZketCCPLRz+Q4E/24vCtzRrtCjaIHfrqwkmewXz1QAgnQo+sn0n87vkZ/K2X?=
 =?us-ascii?Q?g5dglduvTHf/yTA6nLdogGNAG4XvLzbRKZgV08ud/wj4nV4gRK/CmZNUNc4w?=
 =?us-ascii?Q?CTISBgwjARA26vs1cJfV5+u76dPkb5jV/ulxd4Eawvgui0AlMICn47dT9GdO?=
 =?us-ascii?Q?yXwv2IMS8SlNHW5TETBqtD80yrCXuiAXyUodyqlde4zi/F0yIszAkG8lS9kB?=
 =?us-ascii?Q?94ZOUCMTpwIsAypWCymLToxmFnsHXFrcKFja8wBm2mDLADNluNbesCnZafHh?=
 =?us-ascii?Q?cnCrU+cFuLLcTGOfMf/CHUkEqwHJ2P9xiw92/VeYHmkQVJeiV2gsRXZvixI/?=
 =?us-ascii?Q?BQHkcSm1qelw3cKkJNWEd2BUYOduLNTOmBq4fm9eawX9ClBYh0Y855MaDmjg?=
 =?us-ascii?Q?NrBzuX7LIcrpPZc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:16:48.8381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff7ffe0-ada3-43fb-7f41-08dd774741eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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

The drm_err function expects a struct drm_device * pointer, so fix it.

Fixes: af632d3f59e6 ("drm/amd/display: HDCP Locality check using DMUB Fused IO")
Signed-off-by: chengjya <chengjya@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5e6fdb0066b0..60d10d8cdf59 100755
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2300,7 +2300,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 		if (!register_dmub_notify_callback(adev, DMUB_NOTIFICATION_FUSED_IO,
 			dmub_aux_fused_io_callback, false)) {
-			drm_err(adev, "amdgpu: fail to register dmub fused io callback");
+			drm_err(adev_to_drm(adev), "amdgpu: fail to register dmub fused io callback");
 			goto error;
 		}
 		/* Enable outbox notification only after IRQ handlers are registered and DMUB is alive.
-- 
2.43.0

