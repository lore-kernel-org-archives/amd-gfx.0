Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0862D690EC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 09:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6203110EC56;
	Thu, 28 Nov 2024 09:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThP7f8YP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C9A10EC56
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 09:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at/SlVlCZrtXRMbwVi8CQxA4odejWywRV2Ehr1UehmJgoTqM5AjyZauZ3ShHEupn5DJv62j7pvS58CfSckI0d1qiHXoTU1Vtqr5Q8C3oFjykD+sYWuqMdL4UyJoy7laxWkjwMs4rIk/DaCYPjUkXCzNLLTn7LQawvvB25yliVliWd0FyreDloe+Jo1GQ/sPILZZD08Q0UH4nxKfhc5CZLYT2RviDpAfz4G0DLCwYFIiQR/Y7uE5clks1S3LJq6VP730L764tJAbWXFk0moU4pUEKNtX6mwKF7DLPpdHkobnEUzUVgWURk+Agxl+g+yJaRzblPOZdKuJkHertEPMERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/+3SZOJygGmv3tKmtjs5EZyGqpQhcJFAlwbjaYmJB0=;
 b=ZfYmGg1VHyi06JCzJRXvGanWgW3HIczOIytrarUDuZh34JlAUX0b4g0whv1hPVDmWZ0yaua9gtkL15Ufmpam191GGNcgglq8tVpCjLHWFu3Kv99pPneB81lWjvV+BUhU+b0zERTNE2ZNPacyo1JRu0/x4xKStekvQHGqGiAgDfop2wIWMk4ujN9MQdoG5Rtp1Xm5oNXDGqj3USGwZnohXq1PR3eOMt+iWv3ICYulH15bgcYcH2/5ot7mRSnK62WmVrolK5mZLGesiJQNMyf2XBnRiedK+NuEL/2dJyQVpZBria6z0YJ0TJICpwJwGt5fz88jTUuKXmfec4dYHp/CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/+3SZOJygGmv3tKmtjs5EZyGqpQhcJFAlwbjaYmJB0=;
 b=ThP7f8YP2OR4e6jQKH7jVimaYYZvJnUOaVV1PTLEy1c7+aVVjbWY2fWQZ5eVlJvOjmScpeMzeIrIBbhB2Zll7fknCtXTDVYxjwvKmiAyGN8BFV552vOFpVnlsHqALNl5/fmIbA5DE/f0At9HziRqMISdNtsqo4M4+X+FFtii+q4=
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.20; Thu, 28 Nov 2024 09:16:26 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::d7) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 09:16:25 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 03:16:23 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Fix out-of-bounds issue in user fence
Date: Thu, 28 Nov 2024 14:45:46 +0530
Message-ID: <20241128091546.462159-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 939015a8-976a-4dc2-7300-08dd0f8d559b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WXPj0FPvdrIEKdsJbxfm574TcyjIgKGf+WjAyICoLkDqK9andDaN8NxINheM?=
 =?us-ascii?Q?88+ppEQmlartcPOfhSLBNrqQF3P4uVIrsTBMwDyM+t7wEOKzpRhCTcvnGbe6?=
 =?us-ascii?Q?tK9Na3OewFA6DchNVlosQaM/igY7jhGqHlJoZRHMwLyL4fgcrSCDzsuZvbB9?=
 =?us-ascii?Q?OdPNP4OCJzaGZFzm9WjdU5AhcDZQXGq5xuclgeUByWB8sScUDdVlKQyoW+Kj?=
 =?us-ascii?Q?NAQTNOmP46h663Gtw9sTMfrnE0Lftl9uh9PSYRJqvwknIfvCmEDjqdu1f0My?=
 =?us-ascii?Q?q+PY/HMToc1ldvhC0Y3nuwGorZj5GJRl5XgG+98+RoQ3w3+k9FwtRa9v6HSv?=
 =?us-ascii?Q?q4hB8d4A0zmYZao2kOSeOCT0HpbizIRCasdUzzqm97cIOFJLsT5PrJrMr/Ci?=
 =?us-ascii?Q?Sj1smFIy94OMSSgABjN/blPfhCoR5yUVM3SF8kAQVmlU0GeuNzQfTm2PHFYI?=
 =?us-ascii?Q?WPbs0Hfz1P5ezibjbsTW0LEVcqKh28EqDLG+g9hInz/9urE+pIVa794tnD19?=
 =?us-ascii?Q?yIpHRDvsSjYcCyTK2nyjI4ectIOkyecuDh0uu39laxS7n1eC+a2QLSZr1jsh?=
 =?us-ascii?Q?JhtvKJI7p+9/TZutf10N1Zl+ydm+om/wJvKadJSS/OI9x880YkjJjEcr0LfT?=
 =?us-ascii?Q?7mKVlkooTfmiWst5+jPb/pfzaWyTDSTd9QX5C06dM/0G6EZHelEyAPq3yKm9?=
 =?us-ascii?Q?9nlaT07QdhwxchRM7ovec6NktChJBi3tnIqEDUYI71JFn/+49GIDt6NRCdUy?=
 =?us-ascii?Q?YWY1wnBN6B/ZGN9rpXcjoIJEr5v5O/Ud5YS7VDvx4Tsqo37OWmGySlNFKmsK?=
 =?us-ascii?Q?tJ1xuWsFKXRTMv/fwLNLu18KIn1N8A494OnB1fmmwYSxxCr4q51Gss+oCkcg?=
 =?us-ascii?Q?COxs9L2ZTxSEDxcwquj5xESAjD1gHuMfvVDLSTLaQpeM4OlowIcBkZtSAPHQ?=
 =?us-ascii?Q?y+ZDNDkXc36wBRuXIlm37LEGO0aX2XZ6OyR4e8BIYYpcI4sjLQk7sNZOHXJv?=
 =?us-ascii?Q?0jA1sBXS+14N64eYndGH1GougGgN9uIMsSEz5eG5KDbvxkp85qc2iNjAcbvY?=
 =?us-ascii?Q?SNA6vtHCmpPS66bRAkrD4BVTEUrb0Cq5Q3jq90XUvutRDN6Ss35hn6tdcz0p?=
 =?us-ascii?Q?srrUx50rszWH4SoJ31CoYHTHq2VO+gxJbY81tVyCTDAxb3HQ9us82ftl/f4r?=
 =?us-ascii?Q?peu8gOGbwiGfgzIz7n2bX1k3VHM0EZnlba4DOwtHzowvUfsalQoWXCuLT2UE?=
 =?us-ascii?Q?2Y9k3A6vqoImMZwplcAY4fmkKBFlBLzy/jnvacJsxeXfQzvi80p9cVG7IYtI?=
 =?us-ascii?Q?uxj8B/kLQ2+uq9+9Ik03LGNI95BM0x2JDKQsWsWuhzHV6vMvyjoDs85ugYpY?=
 =?us-ascii?Q?cnNE37wTnNHQypbkR+QhNEWzfbvCfWjeX3eV31C6lfORQqCr+Xuuq+8/cVq0?=
 =?us-ascii?Q?WZaVDYoWtaS1gtM3/cLkOdQaccZJH8B6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 09:16:25.5972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939015a8-976a-4dc2-7300-08dd0f8d559b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

Fix out-of-bounds issue in userq fence create when
accessing the userq xa structure. Added a lock to
protect the race condition.

BUG: KASAN: slab-out-of-bounds in amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000006] Call Trace:
[  +0.000005]  <TASK>
[  +0.000005]  dump_stack_lvl+0x6c/0x90
[  +0.000011]  print_report+0xc4/0x5e0
[  +0.000009]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
[  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  kasan_report+0xdf/0x120
[  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  __asan_report_store8_noabort+0x17/0x20
[  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
[  +0.000408]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
[  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? try_to_wake_up+0x165/0x1840
[  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
[  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
[  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000043]  ? __kasan_check_read+0x11/0x20
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? __kasan_check_write+0x14/0x20
[  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
[  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000044]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
[  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
[  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
[  +0.000009]  x64_sys_call+0x1205/0x20d0
[  +0.000007]  do_syscall_64+0x4d/0x120
[  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000007] RIP: 0033:0x7f7c3d31a94f

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3a88f754a395..49dc78c2f0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		unsigned long index, count = 0;
 		int i = 0;
 
+		xa_lock(&userq->fence_drv_xa);
 		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
@@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		if (userq_fence->fence_drv_array) {
 			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->fence_drv_xa, index);
+				__xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
 
 		userq_fence->fence_drv_array_count = i;
+		xa_unlock(&userq->fence_drv_xa);
 	} else {
 		userq_fence->fence_drv_array = NULL;
 		userq_fence->fence_drv_array_count = 0;
-- 
2.25.1

