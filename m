Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BE9C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 17:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D02C113CD0;
	Wed, 24 Apr 2024 17:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnFBv84C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5CC113CD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 17:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqvfGqP509jdMQ+STiGii4/GFtEJVmWMux4NPE4IEIT7Cz9pYoPLHK8igK9dKAQ0EYVG/cK2saI9YiXFgI17rCdvv5fl2HYmOp4Pwc07RzZvwYqfYBNFsF1eDC76OkbX+jmr80FWdB1DiN074/Ib1w4CnbuT61h43b6PIKlSyKQ7GaIKmYc/+o07O1Q8bFNFphNC4302ovjTnV07760+GesG5s8CcrtnkPxdXmumcM1HYpxDYR7x6X3MFxpfDg1K8+ygRINmg10r45tco57DdmGjt6m8lEe6BQOgDbvxGIBrPQhz0+Rg38S/VyjKjLrFymBGmmj1QdERkPxJSMU6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WlRB4qWWwJJk0lg+zzt2Ts7fX65FL+v3XJ0D9AEtQA=;
 b=KJ58pHjzyMXYceuVy7pcWGWsSzKc5LNS1rek5lGbnSlcCaiEeJqiYthfJ6AsQPDfVIRubzVHBF6wiplgY9IpoOLk1KDdZVccuVDHagAlKJ6vQzKJmbaaPhoi7lGn/lZTzpK4M4JKBa9S6/+6aYXDBDJU4eg+GHU4SooC3Lgcc5HNQWopbUMIz7heBBAamYSC5WgTZQMhtO0j99aLw3pp8k/6iphMgqEvZYkBxs9LCtxm6AmycS3HxUuQ1/3dPBZ5yAlRNqHrRVbymIXgsmWBsnEvkoE/rTC5usQhMo7rJJBmRFX+NfkUG4pw1nqHUb9R6xyTLbRiuMtmOSmvx/d89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WlRB4qWWwJJk0lg+zzt2Ts7fX65FL+v3XJ0D9AEtQA=;
 b=BnFBv84C74CiGwwReh9cmVQjr45xVnAlAL2DS0sIkxYxBHbNe0/pxROzFQHRGIc18LQTpvCjHA+lB4rSSZNr09rrPE1J6ojKs496nlQqZ1CjUOx6j6woKH/N4Hez2Chc39N4eff/yTL1UimW8QTt3G0PwB8/f0Rz2GL4yUF/NVA=
Received: from BN0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:408:142::29)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 17:40:51 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::c0) by BN0PR08CA0018.outlook.office365.com
 (2603:10b6:408:142::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 17:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 17:40:51 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 12:40:50 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Enforce queue BO's adev
Date: Wed, 24 Apr 2024 13:40:38 -0400
Message-ID: <20240424174038.840827-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: adfbeb04-f39b-4e1e-58f2-08dc6485af39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yhLP8Q3lnhAmlJl893YKHoDeJypYIw4/3ykbf4fQGjnQuZKzhrNJGStrNazW?=
 =?us-ascii?Q?3asX2d/8zQ2jdLk2GcYFA0X3AtbDhrz5SwJfvaGHj9ppfMfZ7UO443d6pIap?=
 =?us-ascii?Q?HxxlRnfhNZJcXsTppSkHomTotRFNvnXyij7sUjnTfnCLK5J3Fy6zxnEgCI2S?=
 =?us-ascii?Q?qo7TJK1VoAeTLSr5Zy19098LSj9uOtzllE8qn56DCqJmrrKpgM6zYIq7MF2r?=
 =?us-ascii?Q?tKIR4RCfC6S5NP9X1xtgnN8+e1WF9g8T32p5kklS4Nnn3Gc6p7peS009mERa?=
 =?us-ascii?Q?t6yNUAaW8PnFq93oTxAuSgWplmCHaDvReDbCR0XBh8v71u+jY6w4eS4guQ1s?=
 =?us-ascii?Q?vnBQap3Y8snngjgdVeW8uQPwy+hyQiLmJE9zLwOcMu3bB5n+EzZEMBtgggWA?=
 =?us-ascii?Q?PvUngwA22dmhBEx+5u2BRQhhmZMWkNqq4CtxQT8NUJ/0G2cjBnNw70yf617f?=
 =?us-ascii?Q?X6cRuBTUQWftwXodqK0GzWbPayI+xblpotVkr70L/aZ7KnSPd0XnhzSqc1m9?=
 =?us-ascii?Q?axFTZV59m04VaUTv6lWl3qZ2+ks/ZlZV/bsTDh7jEsnym7zCm83J3/uItKPg?=
 =?us-ascii?Q?LD2iAXcx2B9nOFOQ6rhlUR66381pVJsvyW0H9fEkAXSgfotVjy6zNVpAH+Ia?=
 =?us-ascii?Q?VLCJ3sF5Dvy1/B785oCm+ZlR9NfoEKzRRNaG/2PJZSj+UxoySB/caPvQiiCS?=
 =?us-ascii?Q?L7rmczW2g01Sfd6IQ2diMuhLhmUAAHhpBnCVpXrGwR0aOWZbmsYxoyBR3MLi?=
 =?us-ascii?Q?iMtTDMOFvNHtgYbEhIhdWLmWulzxrkfmgEIokEAiOFSUZNuU6Rv6kMFDRypJ?=
 =?us-ascii?Q?r0FzJ7x1mTD6+ZOiqOz6fdJrc8FH7z8zIS7XKaFP/c5FQZcvM9j0UJkp2AH3?=
 =?us-ascii?Q?YPM1BY47j4BeKT5LxZ2u42ZmT6bI2q+q/Sc2RDbE4auOWPDwmdESeutyqVF/?=
 =?us-ascii?Q?XRlofjz3fkKPjw657eze9RQUW5iHKnUhyDHMz+a9gybrn0CkNRw04ZYzKR3S?=
 =?us-ascii?Q?HKBRxK2UgxoJJDysqa6VZtqBLXjDkFbPxHgk8qY2l19Vdxi0F2fGZu+qMJP1?=
 =?us-ascii?Q?2cUHZyVgDSM4OfMCLEUeP60e70wGOqfqWweo6/iwH3wPGia/vDJbc2iinaR4?=
 =?us-ascii?Q?QBDy9N3bMPfTIGgvptlref4H6ZWym0+qVapTnwVtfZ+hc1aKb/Eaj5G7Cyf6?=
 =?us-ascii?Q?cNd8GjxlB1dmsgg2o6AwTZkvngQZmeWpa06rNNCyBAdXbusbFhs/jSxiNG4X?=
 =?us-ascii?Q?TJfvg/s4dw2cvZh3PS9RqxbmtKu2BWYyisw3d/AyNE7lbCJSUi9mfQ1x5NBz?=
 =?us-ascii?Q?Z5np1O05ko/iaPg6UMFtjPr1+tIX0emMKhz4Y1bTG3wB9LdwnN/ABfb5mKa7?=
 =?us-ascii?Q?97m+0uB4H3YKgpmla1p/duleVV9p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 17:40:51.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adfbeb04-f39b-4e1e-58f2-08dc6485af39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

Queue buffer, though it is in system memory, has to be created using the
correct amdgpu device. Enforce this as the BO needs to mapped to the
GART for MES Hardware scheduler to access it.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8fd5e0da628c..963cf6d657cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -373,6 +373,11 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 			err = -EINVAL;
 			goto err_wptr_map_gart;
 		}
+		if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
+			pr_err("Queue memory allocated to wrong device\n");
+			err = -EINVAL;
+			goto err_wptr_map_gart;
+		}
 
 		err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_bo);
 		if (err) {
-- 
2.34.1

