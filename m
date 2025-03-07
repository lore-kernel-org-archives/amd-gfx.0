Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843D1C28B25
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD37710EBCD;
	Fri,  7 Mar 2025 15:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="er9w64Av";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDAD10EBCA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5pAvjjdy16ReYBjEJB2YgwSY7HpowsKFBu4UPt3n0rBqchXSH6h44XYVn1K82RcQM4FNu9aYEt/Gu6PWjwSEfFdPVqC1M0jkfNwFvkSm26EVYECZhXv3pzDUZdOoHzIboy/OF0AuotCUCh2BmPG9vsjU05p/YMqMEIezHfZibhRiRI0vAVOMhslxjxir1egKo9FqhtHv3EgAdJ4zNCqZ9jKfHpFNFkNnQhn6rhpz0WhzKKZUo9wCR5cccwJCcs1MEPllrH6fVY2CiVFnVZeALbRYzm213klmS0d4RNtwzpaSSHFvGJzlAifs9lkOBQbAkVYuXrf5pXs+1JGu7Fw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL+cbhtfLsRaOfC8SjkTfGA/E5gJffmyWg9HEtDnubw=;
 b=Zui4aE9nCOzKRW03/UDLPTD6n1JVte/ayZYg6yA1TD2Bbfkn7oqmOHiZAqLQyhvWQ8kqTEIKpB/voWI9AEuQmNJ5QdJc/CN4xaBczxTu8cKiBQBMs2JQfuBMPxPfHAVIRg5d3HZTymfKiGnEYlLvtSDf6UrjlnD986ueFH2eFkg+e9j+6Vlwe8HbPAKpouck/kzUhUU3Pv5ke2cvvQmQiexRgEfUpthf8A9euXJmNvGPsmkNqvWuLe72PkXqP1zn1Tu3SYYZHO50IJZJUzb39LK4K9L5oFCdQuGg3GxTNJ+G0XIbXIAHK6megKiLca2zTQRWi2+1+hitI0Km741mtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL+cbhtfLsRaOfC8SjkTfGA/E5gJffmyWg9HEtDnubw=;
 b=er9w64Av8954dp8gHZoZ75/3x86cE3FfDWrYxZ3B4S63IcJrdT67XVraIm7pYy1AuBkEvrXXFV0XUR+Mduw3EoKNwioupjblnkYPM9UApmjInHKYNp8H6eOYBMC8/hloh/FCbEHI9Q7gGyiNAq7yYHcjbSvllWqyinVFpY12KY0=
Received: from BL0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:207:3d::22)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:16:24 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::22) by BL0PR02CA0045.outlook.office365.com
 (2603:10b6:207:3d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 15:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 15:16:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 09:16:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Date: Fri, 7 Mar 2025 10:16:00 -0500
Message-ID: <20250307151605.946109-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307151605.946109-1-alexander.deucher@amd.com>
References: <20250307151605.946109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: a24e5349-a834-4ac4-8cae-08dd5d8b059f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EgNqY6l1h0ENuy1W2KMBk8t0/5ejDAQm2n1qSZDc8dUYKzMH23lD3d7NrrsA?=
 =?us-ascii?Q?hzISMJBSj1p+rNZwriDENpXDCzRAl775Jm+mh8BSdhjtKtYFQWjdn5YDY3XH?=
 =?us-ascii?Q?F9Bw8y6Gp7j6v1fW0PCgqgjFQtrd2Q8dx4OvpyJajmuaYTBp4RjAvBHHcRzi?=
 =?us-ascii?Q?RZh53cSh7QSXW1LHuL0W6nzJljmWeCCoA516BSvxuQFK9ipKJKz3tQZMw3vq?=
 =?us-ascii?Q?/J3EMoxh5Upyk4g0RjXKkcuTPOXFFXoeR/PyLBpBw4IKzBYrFT76/VcxeiCQ?=
 =?us-ascii?Q?TD5HYNWu8Ii0LJbZ+epIk2KPAbJbJ13OIhdT9ktfU99BoC3t+WHwF7U/o1B3?=
 =?us-ascii?Q?xj3au6+XtFhbHlhS6q28mfBvPo5Pn5Fw6Fy2bxCDWOia4d5Iv80tTF/DDl3x?=
 =?us-ascii?Q?HpL0qAZWulWedC/wdBV2cqU9BVOw135ddupHtjtVVQiK1NB6FJqA9CyPUDef?=
 =?us-ascii?Q?yM2ashVGEMzL4FZDzm4h/HpiZ3pMNU1VWW+8w+BLGL67k+uaJoIvIWRkA9ZF?=
 =?us-ascii?Q?JiBqIOHfGJQgx+lPjJ15wzHrOz8zd2FN5ukKh7x0nSEcM8Xsdbm2+4NjElJ1?=
 =?us-ascii?Q?K2utcBL71jPfD1PQ053+eNy0/eTvYcDOzBE/aNfiTVwMO8MSjkXtRaCld2sh?=
 =?us-ascii?Q?6v0zH5Gl3QNbabvJ7ceTwuHa7oVLDpPIb01bwup2xa+usQTmSIB2jX628fwi?=
 =?us-ascii?Q?T/+LKU7GxYS3qiNLIV0Uh7Byhhhxz2cwvt4hWuNNY+/lORx8ELZ5yYEuYmSU?=
 =?us-ascii?Q?oyqAiB8qVhowmfz5F67XFg/hyrjfQu49Hd2cQvCxx3hBtvT5pTKp4I0YZ0tH?=
 =?us-ascii?Q?qeW9idJQPqiw0bAG2K4n6QL7zpwDJdy7ZHInuR1PQBYLg3cWUhjjBLJtWMNw?=
 =?us-ascii?Q?Oel7n1WdbxXc8aeUJRVlq6a16L0NWIRTDmswS/rjIFnTN9SXR7C1PkEtmYhJ?=
 =?us-ascii?Q?nVkUol5uEmFYAwL09VP7p5C9PHvVt/qUdLBZCoIUtMkRyJ1UHpZjCDWmcWPS?=
 =?us-ascii?Q?gR36HJOaRcW6rZU5Qh4Ry5F+YkTtGTfplitzw2ANeQ8k4XKOl8n7T54Fz9kC?=
 =?us-ascii?Q?a8w5miut9D2CELNODJmDXIKMQyjWABVhyb4SXob5NsuIEJhzV6gFiu0l4bhY?=
 =?us-ascii?Q?oOKIuiJQD61MfHbRukdMH56Fu9lg9PfW73/NpMl6H6bFrePJJQOO2wxurzfg?=
 =?us-ascii?Q?bmVTo62CnypDFtI2Aiuf5jMKdFWpqYZ+6KvgNrrA3MSRbf1zF/Sc9C7/lcWM?=
 =?us-ascii?Q?ED5FVYQ8qhXASZuqHjDqR8JF6q6Dx9NIIJgLa9y4zTbBvFSUTZdLDKyVfVMs?=
 =?us-ascii?Q?4HkGs6p09/v+sE31uz50zj5+ehGX2YzX7DLtZ8wkKPhGiSCGOoTdaNMv7/jR?=
 =?us-ascii?Q?WbDJcoXjaqnAjdbkFMY9jTXsbmP+aBq2FUtC1P6NDpqvx9KaAxJVccHQzzde?=
 =?us-ascii?Q?J0bRCdXRXQkEmh/gP6Bnf3x01I3Cto+TND2WQH96ozu5wPK24M6MxhwrjLPM?=
 =?us-ascii?Q?KjRyDA5mEy35TbQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:16:23.2189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24e5349-a834-4ac4-8cae-08dd5d8b059f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
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

If we don't have kernel queues, the vmids can be used by
the MES for user queues.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e585e8690edf0..d7cdd2895889a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -142,7 +142,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	adev->mes.total_max_queue = AMDGPU_FENCE_MES_QUEUE_ID_MASK;
 	adev->mes.vmid_mask_mmhub = 0xffffff00;
-	adev->mes.vmid_mask_gfxhub = 0xffffff00;
+	adev->mes.vmid_mask_gfxhub = adev->gfx.disable_kq ? 0xfffffffe : 0xffffff00;
 
 	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
 		/* use only 1st ME pipe */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 95d894a231fcf..19a5f196829f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ea7c32d8380ba..598324e736092 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -837,7 +837,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.first_kfd_vmid = 8;
+	adev->vm_manager.first_kfd_vmid = adev->gfx.disable_kq ? 1 : 8;
 
 	amdgpu_vm_manager_init(adev);
 
-- 
2.48.1

