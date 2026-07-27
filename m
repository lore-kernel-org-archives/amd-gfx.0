Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72348C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 19:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E276710E283;
	Mon, 27 Jul 2026 19:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QjeqXcY9";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012044.outbound.protection.outlook.com
 [40.107.200.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEE810E283
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 19:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Utl+VQ/i7cbKxO3AdHGvDaYaathDO1GuG8QX6DpDGNyBBXMMm2CjmxL2qSL9wgjdxnggV8NurK6GfTJkiXoTo7ngicQJ+bjnz1GWebXGjToLEI2JvzwQwXjBtIMAozOsjqV+0HR3oOxEAPn+sddDRUpOiswZBFZ+7t8th2knBeqH7tQcx9AB15Rys/qTaHemtNpx2Maer5CM0eInq8s6RWaOsut2cJJwgMY/aQoXlRnCjMnhr/R7vhoiju+NJw2BwnlzidvuoK4w8bBPqZjqkLSqttJrz2X/WT0afULxzJ/2MMsSMhI6uDnEnjCrZwE/la/0vbWT7JPcUz/qJ+DJDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3R4vaP1c2AqhiVJ0YPHg7A687RQ76Lnq/I2iXJFaoo=;
 b=eWnDBwLpEF8ZG1419L/e13x3Gf2CC5x3fe0RMYIyUhbhFq2FeSBWaoADEH9Dd+FLXS3o5ONKxA0XI1b0cduF6Q7A6VpBMa0CBBrhBH03dS7ba43uqzNci2kaS3rLRzntEu0j6SbLovpj9yQwodrE95+niN8dLW/zn+J5jkN0ghfD5+tVoDhtzq3EN7OYrfjKNuvg/oDN56Lf0S4AnqhoEo1M8jt+oAYkQjrjTXAUQO3unrkJoL6vAE4iicK5pcQ0NGmLebNJN62/rTXZ264dMTBkgHoomE1Zz3LbGFvb7gTJ4KiRD56aafEiqo0ul3EKa+dh+aiMb0dyPZ8OzLNX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3R4vaP1c2AqhiVJ0YPHg7A687RQ76Lnq/I2iXJFaoo=;
 b=QjeqXcY9YnDDy896gZK6FcCaC2m/LbBWWjmdvypuvi96sYhxw5gHdy8sJdePouZE+rFBy0rAcrkDv/5UGeFFv2lgKI0R6jlbFtuPZzeV07ZB0/yh0Jc0a4t4P98KhIIzJBaItbWNiep2c8xs3JdIFdf8GzeHFs06ZwQjkqPA/Wk=
Received: from MN2PR06CA0027.namprd06.prod.outlook.com (2603:10b6:208:23d::32)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:39:58 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:23d:cafe::80) by MN2PR06CA0027.outlook.office365.com
 (2603:10b6:208:23d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 19:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 19:39:56 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:39:55 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 0/2] drm/amdkfd: Unmap SVM range from GPU set to no-access
Date: Mon, 27 Jul 2026 15:39:28 -0400
Message-ID: <20260727193930.612490-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f87f89-15f4-4b79-ba15-08deec16d646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 3gT5J/vC4kZpntsyjSPkQTZNtQ0z+O44f4iSI6GYbBLB0b1nIkmTfeyaFKQ2totrqqgZAtcOivtPc0hUGTVdi4hvTInldAI3QpQI6qtVoSmSyVMTkGwDCaD0/EjWbm1MifzQdfoReIDIviOHG67MfD7GNigex6ZMkh2Pz866vsKNWdAvZ+G0vZlxVOBEpk8f2VP/AOP6T+1EFmuV5dfpMKCJ8ZD6SAObrLwiNRvUzYCHn2PUN14pFQs1LlsEgjcufww5CWeYT0DXaaRXe9ynQjn6N3IA2B7rIZVBFSPOHe8bgqsQvisGdvOO9cNazszxrquR5Lw0NMXLE1EsS6krlO5Ltm0OhJyqCTksICtRYfR6SEGnUGG2xmqvrMNwredYRN5SfJu8SF/vAV6eaz53Q3Hb+8nrkBtvw3ByA6mvju1Izlr+e0b3PdI6UxiN6Ni+5b9wV++FUB6wpDrg7NNkmPx/+CqjRPe66EkHxquHJeIYO05gW6pBRMaSU3e71EjneYEXxyhYe4FdaPfOvjKGiBz5ry/1KDqtKRrco0W4nip85UujqxXXsYL0Y0rZLslLEkzTvN/+oIKc4P7DmQEZraIdlofVvby3ANq8WfI+ZV6k76PCB0ZyApoOvumAd2+/gaz1AQYMLLBpeO22yD97MNl5vXPYhY5OrvNw8KEVdGWZbj7tnn+uSA8LOcQAAKr863g2X470PH0L4qvuTkZZ/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YRib7TpVO844XVmk63H9JIs/3doTHw4n9DPh91s7tcTxCbK8KMTD6Lq6kzsmnYpjAFyM2SYIxW5t219FOysQA8E1O9u8N05U60xlVwmUpMDlmR3IcgAvZ+L3Mx7vpMREHhmdltA+r9oNqJTb6+/hHoj+TU302yQRx8LBSLMKderczCAPyugtHD181GKsSaM8HHJmsT4YW6iAV4Ag/EoDgdToyIV5hSIvNa8w6t3ltfv2jsugPSi1O1j7zTyqtP2rW6IjlLlGj19hXwferqlwUH8u7IFY618sIKbSQDaK1sB0+Mf5w0vI0IwL5TNE2+Ulp7dzG/FRAh6ZNAKBR/iUI7W0ZgJUH1BuxX+/tart0AuaLN8xThfl+8lyGv/YCJPJmxc7G9akI4+EnM8vv6AQYSQ6jUMNYbmWsjbN6BSUnBF+Q91Vbt7ka/Q4lmx/Zrio
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:39:56.1155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f87f89-15f4-4b79-ba15-08deec16d646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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

Setting KFD_IOCTL_SVM_ATTR_NO_ACCESS on a GPU used to do nothing: the
range stayed mapped, so the MMU notifier kept evicting GPU queues on CPU
page faults even though the app wanted no access from that GPU.

Patch 1 adds a helper to update the fault checkpoint timestamp and makes
the timestamp atomic so the page fault handler can read it locklessly.

Patch 2 unmaps the range from each GPU set to no-access. Once no GPU maps
the range, the MMU notifier skips queue eviction. It bumps the checkpoint
timestamp so retry faults queued before the unmap are dropped.

Philip Yang (2):
  drm/amdkfd: Add helper svm_range_update_checkpoint_timestamp
  drm/amdkfd: Unmap svm range from GPU set to no-access

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 190 +++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 4 files changed, 125 insertions(+), 79 deletions(-)

-- 
2.50.1

