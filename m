Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D759C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 10:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDF610E054;
	Tue,  6 Aug 2024 10:33:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csTlFrWL";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8534F10E054
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 10:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y92XMQvXxpfeY3eIDcbCR629Js0npJvugYxBg8d8uqJdz72j9REeOB0Wi/Qi4z+kGn7Tpek3S8dkIFQmy8Io0G/oNhkOlG5EWHKQj9S5k9QatjqvaVY+iPuP7EvFOXDM2l+3IG98i+B87Yt/ZJmN9+lxQo7W57/z2m7gz8Q1VVXzLMEUdNnECYGf9TOzbWifvJoPg9YGIeBg//4jvozHR+PZJBpeme/GshmKpqBnfZoMecS9Q0No32Fkesn2OQ6h3ONtpJcODMXdzfTcTpKz9lzs5UPHQtlVxTlOl8IJW2/D26WJmwMVRtjf9SyYUPlIBRrXa4aVblcVpXtL0BOxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmHCP3GXArl5sRvmRKnOSg2YK+LLv10nibcI6+Tj6i8=;
 b=meBeHaBBcLHL04fbndErn0hkOA79EIohsQ69EPT03uchryZuKpwsWsJhI7GIhfjyMKOYDrxvxW3OSPM1UM93mXWV/nOQag3H5quQI09alDxEBUNw6eMJ0mkdwT0+J586d7DxZSfnhit5bamv8x9/qPYS3cn8KiCY/ZvlEVSao8IowEnrBzHOfxJ7pTBw7VqY1mb6g7BgWO7fuCWQZfm4NyU1hftA7B62QqgKA3IeTFGUAGxEdyT6IFk0TAVmOUTYg/6GrgjpdCgRB9dbr6n61fB12mVscv2q3umeUDfQ6kpEJQxo390GU4Aovca8rUq6FngbIXsiJhV24J0wM6Paqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmHCP3GXArl5sRvmRKnOSg2YK+LLv10nibcI6+Tj6i8=;
 b=csTlFrWLDDG6mmR8bQrirnnNRNKuN7s3C8cujqGcnRm6h/NDFILt+rHT86I7ZIj7PNyzCoy2HAUyu0Ykno6UBONe1F1p+gTEte35THwn7y95ERdU49vaMcQsJuXwa4CIGgplPOIhCB7CQfU7MNgPpfMIhsawD4gtwIEAzg2ZTP0=
Received: from SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) by DS0PR12MB8788.namprd12.prod.outlook.com
 (2603:10b6:8:14f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 10:33:44 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::b0) by SN4PR0501CA0011.outlook.office365.com
 (2603:10b6:803:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Tue, 6 Aug 2024 10:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 10:33:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 05:33:40 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Yifan1.zhang@amd.com>, <roman.li@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH] drm/amd/display: fix double free issue during amdgpu module
 unload
Date: Tue, 6 Aug 2024 18:33:03 +0800
Message-ID: <20240806103303.680657-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: d24cbe81-ea3a-47e4-e223-08dcb6033f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WUOaIYjQk221FpRUyHX02XNSShKINYpebxqH5hz03qANPRdkK2wPXQogEY+6?=
 =?us-ascii?Q?lSv3xSbLZgtwrF1eROWCcnc3TPQ9qC2YdJs5VX4GT+rSRyzIkkdWnHL1KqzH?=
 =?us-ascii?Q?cdYsqu5FTY5inLmPJ6w39WZc6R1MThG/i3MsecfOGEti8URs1WOWd46DONg2?=
 =?us-ascii?Q?41dQug+jFqysdeGN78vY2/FZVuJJNHEnbxhE0cmnmmvRmfzbt3Oi7PcXffrB?=
 =?us-ascii?Q?KmP8cVy86XfB6Kxl2SQNzpMUSeuNZK20RAGHqeFmuav+cFG0XEOqac+FApbP?=
 =?us-ascii?Q?M3Yzo6T1JhmwLXS4pj/4u6Y0JEJzy9dXGs7OyQefyYinQefgNJhEuOw1Ec2D?=
 =?us-ascii?Q?EXEOya7FeI9Z6hVzS73XODCkWUAhQhQxmPQ2beMLcQxOnv/VKL+MTeLmkoeZ?=
 =?us-ascii?Q?ePlkFozgrqPnuzez6TP40b2e9Bc3j8HKh2HIi45CmIFRbdUSq3A/NuGzjxd4?=
 =?us-ascii?Q?9hJaMNM8xG2dardIdTQu4/LhipgwPjxrHI/8iXkCgzrxqI9cR+gf6UyssAon?=
 =?us-ascii?Q?E9SF2D4KZsya89JHejLTq4myKxFxbxyYHMy5uTjtOaQ+QQveNJ2xOgqjjAoW?=
 =?us-ascii?Q?/FV6htEQxcHPM2hxHFAHpWdCmbmi4HO7fgIHOC5ramnxROKg2Ga3XJgCiRdG?=
 =?us-ascii?Q?ZsTHFmPxUjUTkAWczQaE7YiHIBbt+LHu0A3VVmSvU6bCAFndeCi920Fm097+?=
 =?us-ascii?Q?1+pBnuwlXGuHGrvS7wxoMNAtIU/IBIKm4qw5+Dbx5LrXTbGLgug6FRz/wMl4?=
 =?us-ascii?Q?7y1BJstAvlIVRygvnBqiVwz+r1EQS2qgPiBIuzraE6D4L9bWfUSX2dGRJOYZ?=
 =?us-ascii?Q?R1yArUwml5+rVtgrtn/sQln7A56qava/GgNyJYdJgteLEfJ76uVY3q4TmKSZ?=
 =?us-ascii?Q?7jbDlndj7Y0SFBvvWan8s7IJTHB0KpH2oRv40DkOS3JH0k/kXKml+Ezns46t?=
 =?us-ascii?Q?OWw6C5Gq+TxQjTA++fSdxjljMwFcm8S0Evdd9yzGBHdyDrAmWObMLKDYzudE?=
 =?us-ascii?Q?Si7J+U/1Xy0P2tOyd6uz0xuXqRHrIn5tuYsUQIlwPsCjoEaIW6eqiviNX3Qb?=
 =?us-ascii?Q?Xl31TR9Up0QxzrE2LxkXzu4bwIcCL+U1EJ9D28r0JcObQhjaYqmKFrLJ1m3n?=
 =?us-ascii?Q?g3Li8CkAq4svQyAy1sdgDdBEY1929u/Sqt8KIPrrq10fcNNxwNqU7hH+YOiq?=
 =?us-ascii?Q?49VD30Op0+83+aIW9n8jEX+uyYTO9CqrNQcvHhPbtK7wfFHVrE+Wh6P10Q1O?=
 =?us-ascii?Q?sNZDG9KTfWPievTvr7+lF8emkshnYmN4Zqpxo0PcjZG5+tUiUFTS32PZIevL?=
 =?us-ascii?Q?y9Wvq+tlBT4V1dT45Qa2WyVEYlu01zzvCCzk0+e2C/Vl/+AnbSs6Gt+O2fWB?=
 =?us-ascii?Q?A2fa+jKfKmt1u9oL+OO1gDhYAsitEcXiImwWLi7Ap8EpK95h/0BpjqfENnZk?=
 =?us-ascii?Q?b/tQjuAVaioQ6levMRIZOUMh3mvDmGoG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:33:43.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24cbe81-ea3a-47e4-e223-08dcb6033f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

Flexible endpoints use DIGs from available inflexible endpoints,
so only the encoders of inflexible links need to be freed.
Otherwise, a double free issue may occur when unloading the
amdgpu module.

[  279.190523] RIP: 0010:__slab_free+0x152/0x2f0
[  279.190577] Call Trace:
[  279.190580]  <TASK>
[  279.190582]  ? show_regs+0x69/0x80
[  279.190590]  ? die+0x3b/0x90
[  279.190595]  ? do_trap+0xc8/0xe0
[  279.190601]  ? do_error_trap+0x73/0xa0
[  279.190605]  ? __slab_free+0x152/0x2f0
[  279.190609]  ? exc_invalid_op+0x56/0x70
[  279.190616]  ? __slab_free+0x152/0x2f0
[  279.190642]  ? asm_exc_invalid_op+0x1f/0x30
[  279.190648]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191096]  ? __slab_free+0x152/0x2f0
[  279.191102]  ? dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191469]  kfree+0x260/0x2b0
[  279.191474]  dcn10_link_encoder_destroy+0x19/0x30 [amdgpu]
[  279.191821]  link_destroy+0xd7/0x130 [amdgpu]
[  279.192248]  dc_destruct+0x90/0x270 [amdgpu]
[  279.192666]  dc_destroy+0x19/0x40 [amdgpu]
[  279.193020]  amdgpu_dm_fini+0x16e/0x200 [amdgpu]
[  279.193432]  dm_hw_fini+0x26/0x40 [amdgpu]
[  279.193795]  amdgpu_device_fini_hw+0x24c/0x400 [amdgpu]
[  279.194108]  amdgpu_driver_unload_kms+0x4f/0x70 [amdgpu]
[  279.194436]  amdgpu_pci_remove+0x40/0x80 [amdgpu]
[  279.194632]  pci_device_remove+0x3a/0xa0
[  279.194638]  device_remove+0x40/0x70
[  279.194642]  device_release_driver_internal+0x1ad/0x210
[  279.194647]  driver_detach+0x4e/0xa0
[  279.194650]  bus_remove_driver+0x6f/0xf0
[  279.194653]  driver_unregister+0x33/0x60
[  279.194657]  pci_unregister_driver+0x44/0x90
[  279.194662]  amdgpu_exit+0x19/0x1f0 [amdgpu]
[  279.194939]  __do_sys_delete_module.isra.0+0x198/0x2f0
[  279.194946]  __x64_sys_delete_module+0x16/0x20
[  279.194950]  do_syscall_64+0x58/0x120
[  279.194954]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  279.194980]  </TASK>

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 8246006857b3..49d069dae29b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -385,7 +385,7 @@ static void link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
-- 
2.43.0

