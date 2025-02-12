Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7003C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B6910E126;
	Wed, 12 Feb 2025 19:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCzhPGoJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88E310E126
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUeKDxcUXB3HJwFXvyAQHBWw1pt4BpMFFOk0CkEWx+ld/ApCaPic87+myEN50br5rObTt3dIsXwT4C0KFKf3B0Hxla+H6z8ppQv9nD5C0VfM4XpsSnayn51AzFHRGWkmfHIa461XCaEU5Uask6eGVdprMXsiSdWkldK0poxFgoyU+ORr0ro+ZD5UNxMSaF5jub+QE3+IURQFkX7AvNwz3oJ7VsoAlzh75V02xHEHM8Xuu7al3UX7qLqp9FypySiZNq2VuyPTFew3M00WXakIeucBCxKwmlDhg9o9+dbS3nwHbbW2HT+XFU88P8q31uyUQfrJpw1NNGacHxjU6zQmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6gZBMHxW6S8FJZtlKVvZcdEeGuXc4QTo73f89TeI+w=;
 b=XIC8rzvDABUGatdHe8PFnMetdo74D4lNIEOkTpL63ZzXxwUFjTBb6YIbEcO1WB0ffczVlDUMpjsC1Ac2xtIZIwpL0dav4C7KHWRZ/z+cZ3HJjdbhE296wlr7ri1a6m8BeEv6LEgSLdq44b7ZMiblPV7nwF/Zy0d/mQ8JzCJUzHslrQHv8tV2LMh2lRg48XZ4ATSJOt87vJWmEojRc48FCf87JsJAWOzgZHYplzYjzjQsZUgjszq4k0f9b1SZuYw/qVN2Dgsf3yVcJ3sZV1krNydEiW+j3bsyB5StQ+gY/z4/XWIdQSWvfAYURGa0UUbjZEC3HURmlRW92zt5mbPJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6gZBMHxW6S8FJZtlKVvZcdEeGuXc4QTo73f89TeI+w=;
 b=gCzhPGoJ2FNuqTF+z60f8CdzS3urFScVjRLkAPrm/FX+EH0UCNBxIqFM1+phU25ncuSNw54KkSG5kxg5GYH/ZbEkuNI8XlIVW2JqbLUCKfTpgA1W8u0Rzg2CtA2HtW08zPXu6ZyrPhCgApeSevY+IHTlTK5WQFYBNFE5VnDHruo=
Received: from BL1PR13CA0384.namprd13.prod.outlook.com (2603:10b6:208:2c0::29)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 19:40:58 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::16) by BL1PR13CA0384.outlook.office365.com
 (2603:10b6:208:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 19:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 19:40:57 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 13:40:56 -0600
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Remove extra checks for CPX
Date: Wed, 12 Feb 2025 14:40:03 -0500
Message-ID: <20250212194003.3774783-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbb2e67-ab45-496d-7f04-08dd4b9d2c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AUV18eKqNWPcVLFJMtHH7RkfFTzoQ6A7cCDNB19WyxyA2lT1Iq6js/ZHUPDE?=
 =?us-ascii?Q?XBYv4ydc35SB07vi02+pEnDb8h4HteLoXaxry9UmVhHzShtP9glyZUKzO3Oi?=
 =?us-ascii?Q?3cIxtLmKOi7i7EgCe6iqVP7tZ59Be5ygJ/R+1HoF3QNDIsSlMpvkuhfEgZZI?=
 =?us-ascii?Q?TMsjvC1M53nCbEwonqfXHULQrDxlg0HSJPE6LP5ikCQ0VQUBJYyn2USaGLtH?=
 =?us-ascii?Q?Z40BpvM6iu3lYH88tMRz0HDGUSyiFf2ANcB4b4VSKQdiBhtKKD4BKylRkiXz?=
 =?us-ascii?Q?uF6NJr5mk79NmZMp2kiQ04J0+3jHNkRamgOGZ0iBBg6OJtGpn8NXB9c3gdbm?=
 =?us-ascii?Q?wTuFUQMk4VAPEni5vHfbiOIQm9olGZIoSI8oEGVSISeojPhsRP1OlmuxGaxF?=
 =?us-ascii?Q?bVXvQyQJ4r5rLTNuwWl7DGDjgMf1KBwub4rlJ9Cu9QkrSkCbnRM56ke7eGqk?=
 =?us-ascii?Q?MUbuRMCOm3qSdnqqiir736AHRvfx61pqIgyWokliANBBt6UC33Mzm8K0LXEl?=
 =?us-ascii?Q?zADA7y2ZSIgzLgTV7KeVjCUQH0JjkCFq1JTNU4pfQ/zkvQd0pac9rKRGl3HL?=
 =?us-ascii?Q?7p7ccvy2LSiAkj0nf90PPimN32P4EyMuyfsNLFns+UHYNEjcimm8fid4VBuT?=
 =?us-ascii?Q?Z4l2N4ID2qIRqkLX9JjZulBo20zhp83BgFkJCZLxrLsBM1wfZ1C2GZuuTXQU?=
 =?us-ascii?Q?g/NsXXwUuS3Bb7E2IZF8K4XKSRaQnCVNdPmGQTNChmDXZRY547CuAEa7IZ6s?=
 =?us-ascii?Q?20BgueCegcLvcJl1FsPdqkBi1khyY8YTFqzVsdlyPVLk88qwgHZ08pSTUGF6?=
 =?us-ascii?Q?2Dtsxp8w1zERPtgN3a11QqEzRT+FPH5qfAVoCj1qMwyfY3nprp7xhj9ceg6r?=
 =?us-ascii?Q?DZr/E/H1CGmCX+cKSAjZCvJFeSMVsUeNvNFdjtboSSkf7I6/rQSWOTHZyZbv?=
 =?us-ascii?Q?FQUz52caHoLf5wikXB/Yn83Yxiby9nQ0kFeGc55+rQs5K4x1/ytGfjiB5pTX?=
 =?us-ascii?Q?0c7GkVlBKAJt+AkqUO0X8J3/Q+DMF0rg0pU+Hl3h61K2ecg4E6cDqpxvb/mO?=
 =?us-ascii?Q?Mp8fYky0SUbP0hQXdG16LCVxjGULBr0Jlu19IAZ5X5Ftw4A3UmeHpXnn31al?=
 =?us-ascii?Q?V495O6RPAVmB1zuD7/OtCjsx2zueG9bqzjitnLjvBWBf3cH+w/eo+JSHUBoL?=
 =?us-ascii?Q?BhRJ1EJblSs+O6HqXJr+R2D6C7aLHDlXhVzHhxeXlY9jxYfNUasMxf7fkwoc?=
 =?us-ascii?Q?hRkuoDYORxic7TuIwIN822SXZWvaKNEmcODUksUjA0/eHw956b8CzPnoPfYL?=
 =?us-ascii?Q?+hm7cCuRT+k3pxfhqxb+5m2BSPdE4P1QZpSQgZn3kxkaxLJON5gbGhErzWth?=
 =?us-ascii?Q?j+PLbGtTuvj6Sk98Y9CQlQdJ00K2/dAOQuu4KAzONoOdOXWTs/0ylv5xaTux?=
 =?us-ascii?Q?Y+Mf0UuBluKSBPJnRa28sLvFfledrKFv0UGsIRQvviGlcK89Vp3ztWCJA9Xm?=
 =?us-ascii?Q?XOnxWj+Y6qUkD8o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 19:40:57.6072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbb2e67-ab45-496d-7f04-08dd4b9d2c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

As far as the number of XCCs, the number of compute partitions, and the
number of memory partitions qualify, CPX is valid.

Change-Id: I65696f25e2afd75f2f4a177dabc0991b15293d9a
Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index e157d6d857b6..2753f282e42d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -559,8 +559,11 @@ static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 			adev->gmc.num_mem_partitions == 4) &&
 		       (num_xccs_per_xcp >= 2);
 	case AMDGPU_CPX_PARTITION_MODE:
+		/* (num_xcc > 1) because 1 XCC is considered SPX, not CPX.
+		 * (num_xcc % adev->gmc.num_mem_partitions) == 0 because
+		 * num_compute_partitions can't be less than num_mem_partitions
+		 */
 		return ((num_xcc > 1) &&
-		       (adev->gmc.num_mem_partitions == 1 || adev->gmc.num_mem_partitions == 4) &&
 		       (num_xcc % adev->gmc.num_mem_partitions) == 0);
 	default:
 		return false;
-- 
2.34.1

