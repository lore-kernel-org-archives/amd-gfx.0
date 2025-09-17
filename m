Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7090CCAC59D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAEA10E85B;
	Wed, 17 Sep 2025 14:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DitEB5cr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A9410E858
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmPEc9muosoyegJZerbXjrdT8kPMjNUe9XaTkplW7m0JLKrdqMXNuIU+eMlGG6Mdl7FocH+6mrqoVA+Ywv99ZRGxFtju6CJrl6ffTI5hi1JSUZaEcCA8FAE4PlNlGvFrgprIxrefBvNv1YOVVZSSIh8YnzMQ10GpUYqgVB9g20Fy2uvqX2FbBYk1zxjPRGQP6bDSIo9/wYG3HE73Aa9sOCIGmZWSTW0fJHgs1PtS2kzpBTpUXxEB91HEzHlvAEpOXCneGYH/uXNiK5i0BAyVrNnPKlyinLgBZ9hgrFp8951le5/ZncmSF5LAneE7tTsWmztjpox8Ww+PeJYIJmrafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Bfbzu7I4s9VYV4ETQG1opK3JaRQwrAehY+wko4YTM=;
 b=mHUWhxFe9TlNl+fwU4tnJ/vx0kUPbOWV5i+paHB1ookyKFI9iVymzhOeK5btAYcvzAIITMbBbIrcgfcWX9674ody3mu3DXjLyXqpZN/8ktoOvwUFLMBirPmE32vDPuKtInHZsRXAo5BFKBCJRQXmy90VYZA13fMZi4TV64qNVSWnSOeumDlou/u8SWc6GLUfGIkuvDjRDWFynhYpJh9jfIcGbQEeOeF1iLwrYU7bKIjfCkEntcF6wlf3TNho93cYA+w2Sor0Mb5bQDOyKR/v33cEvid0Pe8kKHb4FHpbia4Xqvk2Qf+xTCF+pyFpaFJxwZG5OKwwBv5q75YXk4lXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Bfbzu7I4s9VYV4ETQG1opK3JaRQwrAehY+wko4YTM=;
 b=DitEB5crRaGx8Epx3+bCeadewhgu5NeN2YTn6FMIR5NGK6skXNsbfxlkfHyBmHTRDLBukXmJ34DLOkJ1Jk6uuRLGBCzSZOGALr8twMt22164ERUagwwXkOENwDGXYKcsPPU1txbprckr/l2kSv5h76el1lHvKZVGEWZmYoz0jJo=
Received: from CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::22)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 14:46:11 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c8) by CH5P221CA0003.outlook.office365.com
 (2603:10b6:610:1f2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Wed,
 17 Sep 2025 14:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 14:46:10 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 07:46:07 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd: Run KFD/userq suspend and resume routines for s0ix
Date: Wed, 17 Sep 2025 09:45:44 -0500
Message-ID: <20250917144544.299678-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: f165205f-f6c2-4adb-25e8-08ddf5f8f16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pednJeHRflV8obmCvlrTLPmsDdGX13z2/A8XgJSp/BsddezoenJeCdPo5xAC?=
 =?us-ascii?Q?qPGsCIPeSexGaEo0MY5RUj1WiOjdBVOil0fQ8RwN8yn5YX/dDcbiadKmi+vX?=
 =?us-ascii?Q?26J/4BvJuxewSUQOoz+y/x/cpMYdGQC7ehS8ipF+CIjX86GkZXhzjZSpblrj?=
 =?us-ascii?Q?Z7QYimRmH5591y9R4yry3+UjWysbHY+nLE4vXVWJV0cYc2Ft8GyzajJmWJ6G?=
 =?us-ascii?Q?X0kbwQ+BgDgugLnR6vdFo4//sWNvvp9/DmvTVOWLJEFimPjKORTMLJkadIUp?=
 =?us-ascii?Q?8A+2Nh0t9FrImy7qs0kAPEQrKgsrL6plRPfqie5g3TNm2wdaclJZiwDAd7bu?=
 =?us-ascii?Q?lUqAZAlkkg1Teb9QLk6QnJefVkmFxVeThLa3NtTID2FsQ4DuVsxIwgWieMpJ?=
 =?us-ascii?Q?roY4oE/6mlnvFpcbDorV4UwcI8krziMs+RRxWzInFqZmNnIsTws82B3pjh9A?=
 =?us-ascii?Q?WRr2ocUROUzzH/lsvSHYqNpzbJ9q8HlJo0rv+TkX2qKojjvxqdbPmJUNPIHp?=
 =?us-ascii?Q?bm7I5pOKeXvGKFfC26DVTJGTrd5KYbbpuYz0Qkeq/UGNUaXC2Eeavl93EVSA?=
 =?us-ascii?Q?UfGBatdlyFgQBPNEf4SgIFS+K51zhfzaAl0zsOElkacGX2j/dZTr0YmL/0bp?=
 =?us-ascii?Q?0x0xSRji+9cRktsorGTBlisBxawn9fIpDbb2/kTxIU6TxCRCR59kPHF2/fLY?=
 =?us-ascii?Q?T/vX4d05XZNW7QajeyK73zYnmBRasvgsVo5AhdNjq583M/yTCPNhNQAf6jRN?=
 =?us-ascii?Q?VqKWPnb2vcATu+rhZFAeSjMnJBSfATCQCal7k37lR5Mx4chvmbI704lgQ8f9?=
 =?us-ascii?Q?YqSLOh8jzGw+c8+eerXX4AOPTJmmfE2Lu7IwrtT9mvALxAY7qaS6J226uCLw?=
 =?us-ascii?Q?r1rFQYLf0b6n8IONLM4Uj5otVY/+OGwZ4idrAA9atV+Hye7/lT5tYgvoW79o?=
 =?us-ascii?Q?LnRnY9vFD7lrT47DR7QBNwSHUgLUR/oWrtc87kDatS69vgQp8soY/DhRm56q?=
 =?us-ascii?Q?kKhM8PWdKNWbJkfCNF/t0/3UO69KMqAe1LmPhfc1NHgK4F8Kt9npsbhr+wdX?=
 =?us-ascii?Q?Aqss/AePiIh86u5gy/YOW/9urBSkYOC+S0yx4FD+Q5hbvm7aderW0iNv0RYn?=
 =?us-ascii?Q?FXwhZqHH2p4Kz6trDUJo5OkMUb+bst+ziUEfdF07jB8cgB9BvieGu08xqeHF?=
 =?us-ascii?Q?78LqIuqoZhs/3xpNhEJ39D4lVApMPzdwQvsv6sAYnsp1VKDF9G1n2g4IU3Ej?=
 =?us-ascii?Q?6exFkIFcMMoYFAQvBtVmP30A/H6xTETG111cSiJx4uBE2CISLqhAqZcQTPnd?=
 =?us-ascii?Q?sEJOFf1YVMh7oVX/vqvV0ySyn/OOEMXJpMAz/es/X7WCgk2/NVsXE8sunkVd?=
 =?us-ascii?Q?D9J2Je/r+8vSA26izpxJuCULdzdi9rGaegNdVRGZZpeNItfr9Yx34n/hJz96?=
 =?us-ascii?Q?J1OXESpWAd0hQlbOxPv6bSaAZ3xPnogxdtOHQhFGcM3QH/PQ6O7NiJiV6aQZ?=
 =?us-ascii?Q?fUj3gMmS1BlpHfXXYmsXrfqsP6CCXha0wbLc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:46:10.7222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f165205f-f6c2-4adb-25e8-08ddf5f8f16f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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

KFD suspend and resume routines have been disabled since commit
5d3a2d95224da ("drm/amdgpu: skip kfd suspend/resume for S0ix") which
made sense at that time.  However there is a problem that if there is
any compute work running there may still be active fences.  Running
suspend without draining them can cause the system to hang.

The same problem can also occur with user queues too.

So run KFD and user queue suspend/resume routines even in s0ix on GFX11 or
newer.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * only apply to GC 11.0.1 and later
 * drop tags

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0fdfde3dcb9f..70b61c1a0a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5220,7 +5220,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix) {
+	if (!adev->in_s0ix || (adev->in_s0ix && amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 1))) {
 		amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 		amdgpu_userq_suspend(adev);
 	}
@@ -5318,7 +5318,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
-	if (!adev->in_s0ix) {
+	if (!adev->in_s0ix || (adev->in_s0ix && amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 1))) {
 		r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 		if (r)
 			goto exit;
-- 
2.50.1

