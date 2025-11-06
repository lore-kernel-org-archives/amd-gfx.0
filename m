Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FEECCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 07:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E6910E828;
	Thu,  6 Nov 2025 07:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="meoIfVGR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2BB10E828
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 07:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tna4HuMq1xVQ59KNY4ic4E/i/iMrHBiwcSMI8NLbJ1woWU5PVpbaZGzrtUN4OsChhPGb/yOafpcMZ8QvPqpT8cdO68ZIUR4X0kFn6GiFlbeMTRVEYlOD+aHvGWzU7Bl/HuurxaizrqtpLQTh6PcWsZxyNxiUt44UUM+H3RXvpqd3CMEF766iGy4U3KV/o8bQ7kwMeOvmAMGWtLO9U/zyhXYD1MjCnEQtkrEGbkd6ueywsDi9UWxXQFg0Fzpo2J6MzyT3aGb4X+mtIx2QqeUgcsBISJfAlnODoNOlLi5BNNt5G3Jk7NkT8ShUJXOD4VkDw0YzahBjA/Pb+P6nuJjWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGYOWYPTe8QWc0PEPmvaxQ1qeLrjoUYorz+GsXRLNfI=;
 b=nxyGrjI7NkcQWMdMiXV17AFhOMJ02b1buxeri9R4RESJ9wvyWUfLVLmME1vQFrr2quUtM1xjPpzFdszS0GyXiH+JRSWA8oyOPRA0U4MG8wLqqO5zNcwqYZIkshOSHwWbGQr8Da8zM8zURP+pZXZ/7+kTLyS4jvWGwZZ7d5dp4dtWkKKuHzEtOtWbN8kxy3e6ojR2K12YQ0O+SyNYJAQjish4Vj/6bMhL3Y2vblwu0cIQrq0tuu3R9jeHfVh849vV7LGfHoVe2QT5+2rijXqm4BGSHf0jJJl2NqQNzJuS/3UQrQeA8VyFUnwua8So3K6mb/+poMo1ybfUAokpdhuPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGYOWYPTe8QWc0PEPmvaxQ1qeLrjoUYorz+GsXRLNfI=;
 b=meoIfVGR/TR0UGHnmx/NHMla9QYb+JP0DNYJuIzS87NsgemaMyteDMYvtgKufd8/ZjzC0kZSyMk1uB69IXxZ3pyx4sL9wHiySCe7NFvPKT/pO2lF1q6EZduswKvYWsG8CeC/TktIRlZJzz2lOqQug2XlitORuGnqCfDLmubSO70=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 07:50:24 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::d9) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 07:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 07:50:23 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 23:50:12 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH] drm/amd/pm: remove unnecessary prints for smu busy
Date: Thu, 6 Nov 2025 15:49:44 +0800
Message-ID: <20251106074944.1948995-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4b4fe3-6290-42db-0b5e-08de1d09243b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGpz6Sl0ee0+1P7DydFZXchizOky8V6SG0F4+6DDpzamrm6G/h578mTlsvcD?=
 =?us-ascii?Q?KHjX72O7N/UOELxaAYevayAcj3dcT57QhHev0m9MNMpk/IPdlyHVg3wzg1mo?=
 =?us-ascii?Q?uQki7Rks1rlya6OkhkaVhLAraWFsYYhJnRrN1iQ+x8MFl0Sh5FkKvHR9H7jT?=
 =?us-ascii?Q?f50Z8AvUHtXkfcCPBoN6dRlZ3JDHOvZAkuy13y40bseAy8eDrXKJx9+NI5rn?=
 =?us-ascii?Q?C55aFykSjDQWfdiXcEciA4mCdZQS13dC91MSHjnq1l/AZk7nvpHHCKImInoN?=
 =?us-ascii?Q?or7i0A+nLTc5yy+dPSwYDg+UDS2eHQWhOCDoZXxFZO42Qlwi7hASixzWnT/E?=
 =?us-ascii?Q?i0kgJemCtxcZFzZxbW4szPRZVdQwy0MVIkatGb4vde2qKTQgIRul7PAs3qDX?=
 =?us-ascii?Q?r/N0wsHF0roPJyneIy6bQrm5nG1UjcDXaabz+yo4L5qwI0jSzBjlqvudlpEs?=
 =?us-ascii?Q?IzIU+bdR7GKLJgyOHEPGB7Z657mZiKGs0dozHXt/dsTdww5a6/9NqM3mtwID?=
 =?us-ascii?Q?TzekYqZyhDeRJ2EUm3bLDQLDUKYthY9RcOIVstrK5Yg5D4gZb0jFqSCpoCd/?=
 =?us-ascii?Q?fvxeUdTez6evVlhZn9zNFSU6hGNEvNmdfT3P6K/6C3lFD1aoBJUSVj7QK7lp?=
 =?us-ascii?Q?zIbVksLUNG6cfUM5EmvPB8FFdiINJ3vNVsTgOhmqjOvyF5Abze8ulaSLm2tI?=
 =?us-ascii?Q?rq8Ad8pBVvsnKmiM29ywnDopA9AbMN4Tg3qoVDbpSc1UzbTPvHBLBvx48W45?=
 =?us-ascii?Q?Aw7PLprNJa+4YWpD81PXbQZA/86BA7s3E+V3K5x7ip97LF9TAg3/5Jthz4GZ?=
 =?us-ascii?Q?L2iXY3T+LicmS0BJzUVCRnygAJ0uD379XRIXIH+eubolKiWpM9sec+5PG+IB?=
 =?us-ascii?Q?HoAX/KJGRVowSs/ADDOQukzMlkNyK4/IWJUKlkb6pGdIrtZlvK0fg92pSt8R?=
 =?us-ascii?Q?EvjbkiWmfWhVxXfa/nbUaNooqHMlk2BJ5Xybc80wKXxRzLs+Qtrb5R8YUyTO?=
 =?us-ascii?Q?4B5CKtZ/iI+cO4MKzaUcsDUgykdZJ68Voj59aGtEjoAN1ZG/iiysmu/pm4yP?=
 =?us-ascii?Q?WaWRw5laZLE3d1eJibx/4e2uURMkT86IE91X7AKS+pKaSCcqf5vyYImkhOZl?=
 =?us-ascii?Q?u0j9odHzLF1MiSuhsKXtIEz/qgHK/6d/QeSWPgBUAVflo93qfQDzvqgeGpKr?=
 =?us-ascii?Q?7bmv5lKiDIP5AhjNAVcJEK8xhsCHdbbalpJhR7ZybaHkoDVuUiGImXBH4loL?=
 =?us-ascii?Q?7Msda/TVQ/eJE/vKGqx+2lopqIsCubwhHeC0TGJw3KjysbvEybC70vJkzglo?=
 =?us-ascii?Q?WU82Tivvn8VldFFpdYwy+3FEpBaFPupO4cSs5yEzy1M7ZIUHq58FEeIrFdBQ?=
 =?us-ascii?Q?BsjkQqfOXurmnn1qbvcJ6N4FbDttngrGbYwQGBexi3P+QCz5TKk9HuVztI2Y?=
 =?us-ascii?Q?lbLFcR1C467o1cep6t4p0178s7w4xYdKydXH4xf8697pL5KlkAVVhWV5eX6k?=
 =?us-ascii?Q?KITxcCpVm8ZgsMyAL5RNslAbBBoUm44MIkeXtcZk7Z5ByR5o/jIwO1h8xY+f?=
 =?us-ascii?Q?QiZgNlhdpIdF0H95SBA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 07:50:23.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4b4fe3-6290-42db-0b5e-08de1d09243b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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

smu busy is a normal case when calling SMU_MSG_GetBadPageCount, so no need
to print error status at each time.Instead, only print error status when
timeout given by user is reached.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 0ce8cff27bf9..fc580800609c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -956,6 +956,8 @@ static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uint32_t *
 		now = (uint64_t)ktime_to_ms(ktime_get());
 	} while (now < end);
 
+	dev_err(adev->dev,
+			 "smu get bad page count timeout!\n");
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 3b98065dac1d..ca575ecbe36f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -164,9 +164,10 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 				    msg_index, param, message);
 		break;
 	case SMU_RESP_BUSY_OTHER:
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
-				    msg_index, param, message);
+		if (msg != SMU_MSG_GetBadPageCount)
+			dev_err_ratelimited(adev->dev,
+						"SMU: I'm very busy for your command: index:%d param:0x%08X message:%s",
+						msg_index, param, message);
 		break;
 	case SMU_RESP_DEBUG_END:
 		dev_err_ratelimited(adev->dev,
-- 
2.34.1

