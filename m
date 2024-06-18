Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBCDC2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB52610E6E7;
	Tue, 18 Jun 2024 15:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzqvMKLs";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E5610E6E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 15:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5BnRbLaWdyR1nSn2WmB45A4RX5KbB+/7sfqmP+nVoSyOxk7riZOmhB5ULVp0/tPgxsaw6aBKjxFfB2+OMb1YusJyJw5iRMTlAkTp74x8IrE903IJC2fr84Q+FNHEjaigKhrKBePecNmkNyKPtLGGElm0A/7xkP4nF3Zv3wqQ+2kNcUwxkTxV1ZwiPzmUvrKUqmmUCk/xjTMrCpbzLEb0sEpevTLxRY7+ds/kCl+rD8uRowiIA7Gaz43y74Uli8E3N98OcHfaPhBo1WVKpS7/Kdc3DK1gfMupm0NsxTDL1F9lMHVipSdyEGmYYeA4FfIDbnAlV/vTPLqrHH8uan6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYY1EAfM4VMI1MIOt9vUhWrCmJTG0QNeD6vxyqJSK2A=;
 b=F+tYhc4fNnqPCTgD6i9RjQu254sHDJYGXI7f2mtJ73TCney1uW1a5GFzUfZjpHmljzcg8BrJxMWO9u0INYwmRq5gd1NC1encOZWcaul9isTp5DK6Am/MbS3mcxPLwdra4WCElmQyXIO7SBmU5NAncVMIAMJS8ydsjClxl1x40brlcm6qp0Tv1sSBT3PsWHB2ozG9JP8TRPyLdPE2DK6b9PsR5f19o/vDpqnWnsPfRU3inRJorrf7hRygx2w/pvGxE/2RZgXkCYmEShww6by7mwyW5HogdzYxLt+J27QEQYvyc3xnN+0hSQQhH7b5vDqD273ETM0IUmZfmvaxGW4Zeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYY1EAfM4VMI1MIOt9vUhWrCmJTG0QNeD6vxyqJSK2A=;
 b=CzqvMKLsKVCAojUN6b6DpXQJK3IbK3SGBMunrfEJx9T5TOtpugcsZ5e9SpBd8EK2dp4kfoWVMbAaEhM0I1PfH1f4+STLxBByF8xib2AV7IBcA7JIgn8GXxqxPAKjf51qcOXEUmDzYSQ5lnXefECsczGG55d+57AvMRL+X4aIZvg=
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 15:30:40 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::61) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28 via Frontend
 Transport; Tue, 18 Jun 2024 15:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:30:40 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 10:30:38 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: skip runtime pm for selected ioctls
Date: Tue, 18 Jun 2024 17:23:23 +0200
Message-ID: <20240618153003.146168-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240618153003.146168-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d803159-3a8e-4775-cfe1-08dc8fab9c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jIrQ/iOsbfxtU6M1JrehZuqz33Gtjah5ndwlgSEupn61FNYQk56jne7Qb6CP?=
 =?us-ascii?Q?WiBsbxxnAqSFrtWEyIxpdufyeDNCf7nfXuqOeWWKJTo1xd98Ij8wyEHjCYU/?=
 =?us-ascii?Q?ikXDDc1FiQ3hvjJmNf4we5I0c576MYiYajQeC9Rxo/THD9pOFl/uHHePWj0L?=
 =?us-ascii?Q?q5f0P6lcDITlFuUeOdW0YhOWEW+aC7IH3b/F4/P8Zd6v3r/7Vqgq474FhOzw?=
 =?us-ascii?Q?B9tmkJhXtJZQmz9S0UPLoSAIBF5PN7u+klKaGo101Re08kuNEByKDhI0dS6Z?=
 =?us-ascii?Q?W1hNs446eOpRoyNKGQh0og9TSp1UzYNowkS2FMRpJMeYTMV63vazrSYT9Mu3?=
 =?us-ascii?Q?n9gUyid6sgkMChayKG9ObSKGdmYVRnelSg3yy/kIoHj0xfsR4R2hBaqU5xZE?=
 =?us-ascii?Q?zEADtS00GNq/cIPs6N3/YnNg89GiULEUbwuuCWNouSUdcGNfTXDJZWM6WgEO?=
 =?us-ascii?Q?EguFlZwgg2aBWnIz2uVYkl3pkoO4XUHnH0HCV4V6yCtOgF51Kh4YCxfHyfX7?=
 =?us-ascii?Q?ktywdn0SVFOSQJX4BGOpo6iH5lIKLvpm+j6r0nHeePOooSpnhXEN1AD7A6ut?=
 =?us-ascii?Q?TLjQBd2JwTl0b/vdvfePu96Z804PvrldimwBQe0d2OCl9hbD5KAKDW6qQ9zz?=
 =?us-ascii?Q?FPxwSDnFYPjralZFiwua5NP7h3Wbgp4Ssw/M59Dog6ot9W5lXZTXXek7Q7dx?=
 =?us-ascii?Q?mtWZXdLnr9tk/ZPpdpqwqKa4b3/6dNRJhC3p57GRn+9wbjfX1F9+fVbQrdzL?=
 =?us-ascii?Q?HWq3h30BKtiwTsiFRj5IIdVbH9nifI03cCdP36YCuxNYc0QkPd4K4r6eJ1sG?=
 =?us-ascii?Q?s2RNV1itGpRWRW33OB/4R/V2aopZDyE4WFK2RckEVh9Kp8hwnMl41ePXCKtq?=
 =?us-ascii?Q?uWk4J+Hp/P0kUAVfyoNNLMga+2wyqbgu6jDw0+xCCx/9feaG/1B59m7H3XDO?=
 =?us-ascii?Q?uJjg4PpeP7AMdxTDU6uT4TEO+h4axoCjQa9asZBNYZ3wFm36hdOokQ1TZzk4?=
 =?us-ascii?Q?GbQeJNKv90TRVo5TaVGRdvSjvrPYp9/UIypNMq028bsoFtqT3QJ6r7xLRcLQ?=
 =?us-ascii?Q?ucDCmbjtHBRfAJY/1fRHu3MqmORoLSJ2H2IFaikQX/rBxRcKzlo+CBxIE6MY?=
 =?us-ascii?Q?o7uTt2/8kXLxhac+VKyRK6mtcBjGUhOUEDUDo+rbUN+U39/L2PJyCKcort8k?=
 =?us-ascii?Q?/dmqFJI+LAM0+xbeMAcr0mGINN8DJZGIbO8C/D0RP26+L0S8Lvqo1BpusDwK?=
 =?us-ascii?Q?NevBrqfFtnu6oXLSz6fuqIcpMT54sj5Wn7QZCuk+0jQpdNkvfnZFGZmzv4p/?=
 =?us-ascii?Q?lwpUu1qCU712i+w3tVHwhIiISH1ieHcnFGT+LUx93BwQwvWS7p+xshmNg21O?=
 =?us-ascii?Q?9j4Pt5zvboeJ7WHHTgom0WeBJ9qZ2ZzydJKxgRF07ZXvxZ6Vwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:30:40.5548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d803159-3a8e-4775-cfe1-08dc8fab9c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
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

These ioctls don't need to GPU, so don't resume it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 45 +++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a9831b243bfc..d21d5af7f187 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2855,7 +2855,9 @@ long amdgpu_drm_ioctl(struct file *filp,
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
+	bool is_driver_ioctl;
 	bool needs_device;
+	unsigned int nr;
 	long ret;
 
 	dev = file_priv->minor->dev;
@@ -2863,9 +2865,46 @@ long amdgpu_drm_ioctl(struct file *filp,
 	/* Some ioctl can opt-out of powermanagement handling
 	 * if they don't require the device to be resumed.
 	 */
-	switch (cmd) {
-	default:
-		needs_device = true;
+	nr = DRM_IOCTL_NR(cmd);
+
+	is_driver_ioctl = nr >= DRM_COMMAND_BASE && nr < DRM_COMMAND_END;
+
+	if (is_driver_ioctl) {
+		switch (nr - DRM_COMMAND_BASE) {
+		/* These 4 only operate on kernel data structure. */
+		case DRM_AMDGPU_VM:
+		case DRM_AMDGPU_SCHED:
+		case DRM_AMDGPU_BO_LIST:
+		case DRM_AMDGPU_FENCE_TO_HANDLE:
+		/* All the waits don't need to resume up the device. If there are
+		 * jobs in progress, the device can't be in suspended state. And if
+		 * there's nothing no in-flight jobs, then the waits are no-op.
+		 */
+		case DRM_AMDGPU_GEM_WAIT_IDLE:
+		case DRM_AMDGPU_WAIT_CS:
+		case DRM_AMDGPU_WAIT_FENCES:
+			needs_device = false;
+			break;
+		default:
+			needs_device = true;
+		}
+	} else {
+		/* Most drm core ioctls don't need the device, but to avoid missing one
+		 * that requires it, implement the "can skip pm" logic as an allow list.
+		 */
+		switch (nr) {
+		case DRM_IOCTL_NR(DRM_IOCTL_VERSION):
+		case DRM_IOCTL_NR(DRM_IOCTL_AUTH_MAGIC):
+		case DRM_IOCTL_NR(DRM_IOCTL_GET_CAP):
+		case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_CREATE):
+		/* Same logic as DRM_AMDGPU_WAIT_* */
+		case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_WAIT):
+		case DRM_IOCTL_NR(DRM_IOCTL_SYNCOBJ_DESTROY):
+			needs_device = false;
+			break;
+		default:
+			needs_device = true;
+		}
 	}
 
 	if (needs_device) {
-- 
2.40.1

