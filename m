Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D6C87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 04:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65B10E14F;
	Tue, 29 Jul 2025 04:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2WQRrgxY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1862110E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 04:16:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npQTZLcki5D1LkD2yBhnQOqzTO1BeS8C+g4INkPdmghuPs2P0ajuDILUdoMCkEf4wFXIyEHgGcct/glc/OQGYlD2TawD8WWpSjA3xmQ6LRshauAzlj/yeFGuyd66o4ilWV2FrAkR60wDB9ziXjaMDAz9BRrhdWi5SMi0chn+ZBqwDffuX/4b4hLjn3OraXxaGUhZCEvOGkrQ/iJh20hXu0AoUShgKskzMsQeSardBABw0C1TrFovwtsGtGoRp1DGEtVuYvUst93635vvfaRDObz/lIGMk7pnf7fW8zpxf2bp3lf3ltNJkEXJzZXxLHCIfv1OE/02Awgy0AZeaIWIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0u8eKj/KpsmnrFaUSKaxK8Kw+q4qTiuOwmRki2OiJI=;
 b=u2aUK7WDUXqXbyA8ueN5+HnjicWSsJEHTieRXfL5oJ/3E8rEo4oxqGBNeFpgYaHpIQTMIke71xQQKhHHPXjlAJE1aB2aFIT3xsxaFOvyXZcCHkqwh5BSZTiWUBHPWekprkxNewUyJtxUhiyQq3XQuGS99Z3tk8x5/Un69NHb6/iGg0t0G9mtcsVEPAoNJyBaoCxkljNvpokhJkF26yY92W8rSB9ZJnF4JAwHBL5O+WHwhWfciBUtC3Wf4xkkOgsbsPypJj0eiRa/IyKkSswH5ujgL4gldVmeA3JMIOOK0XOUXnwqV40Jg/2FINzINMaa9pe2wCVByqNqJx7zIWfDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0u8eKj/KpsmnrFaUSKaxK8Kw+q4qTiuOwmRki2OiJI=;
 b=2WQRrgxY+Hk+q0KvIbeyB3BADO1PSZGI3Tf4rq8J0cV8jefwV47wmU7cEgDJ93iNn4XEhLQbD+7m8OcMISSVEpvOX28t8JqP/ViyXtywGuvpbb/H7H4ix7rzmkcz8Qr/lHJyevOuvfXnFx83i3jmJawThqeyc422QKaO59l+VBI=
Received: from BYAPR21CA0011.namprd21.prod.outlook.com (2603:10b6:a03:114::21)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Tue, 29 Jul 2025 04:15:57 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::98) by BYAPR21CA0011.outlook.office365.com
 (2603:10b6:a03:114::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.2 via Frontend Transport; Tue,
 29 Jul 2025 04:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 04:15:56 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 23:15:54 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Effective health check before reset
Date: Tue, 29 Jul 2025 12:15:45 +0800
Message-ID: <20250729041545.75232-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9b513f-081d-465c-e7e3-08ddce569db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkMtzPB+yUYmmpm41MiWQxDuvJzkHsosOKZb24mj3+xrBhvHwXsNn+rNuJ/+?=
 =?us-ascii?Q?w4CnPBcdBvQNXJwZvY67I8afF6pJLiXxmM7O+78ExonQBrvf1D4DkIsi2+oe?=
 =?us-ascii?Q?YllO2ie208nWvRE/t2hGTpC2ONMolHuS9lO7YgIkef2wyXZ4FOCMII0jZOLY?=
 =?us-ascii?Q?zJphKjYckEThpnINe7y1ob+nuF0elyEEGQVSazMUbOCJfL1DG/S9QxZUecsH?=
 =?us-ascii?Q?OEH5QA9SyieEZPAH1Yh5+PzAj8qv9dsePK4BaHnLx+0rsvCISwahl8DqsLGC?=
 =?us-ascii?Q?+kk3bxbxc8ZyTD7IHLikIrOrw40okYB8jPLzklDj04vq2Qvu3+8UxX7TGbpf?=
 =?us-ascii?Q?8i5dW+jTMi+UHEXBV+I3qNQfqrOP4EP3zFy/K0NtL8YSk2V4YCVkFOmTlyvi?=
 =?us-ascii?Q?buf1Tp2gbdo/tpFWx435QWX9OKtJoXpKMis4VFCz/0Uc7JVeuL03U7mxPB52?=
 =?us-ascii?Q?I3TXb6EJqQl+3WAQxTl1zPKzlYTDMUDuhDiPL+VcSn10ugJNwyI8NNI+My7y?=
 =?us-ascii?Q?sQ+4MOcUW5X3FldmNpnSw5IGSuh2CCVDhYmRBD0jLNeOI+A26/HAm+n7RLLi?=
 =?us-ascii?Q?UPEt6xB1+y3grZNlzsFJh1tUCSKlZzm1l9hNA7hA6kcTW/rIpBBtJ/TOY0nL?=
 =?us-ascii?Q?7aaIGGRlO73Yp/eu5tYrXVXk8u3QPlK56RL/D6k+lOKMReNtPqd6xIqcgPcJ?=
 =?us-ascii?Q?5m3Wbo825p+/MZRheNUhOzjmNempvMIwZpW0rm8pggNd2nuAGrfV5lzcJRtC?=
 =?us-ascii?Q?7LWI5waMG1GX1IloFEf6EyfyjL84l+8TrgPHaBsrQPwYSsoVPk4WEnEP8/Ia?=
 =?us-ascii?Q?nrEQ3dokAg4kl2Ziu9qxkj65+8slMmNIH40aXHIONSXvsUozieLieE2dzMWe?=
 =?us-ascii?Q?mkrYz8yfpf2e4bcLYmEHBjG6WDekPwpQPJr//k+areBfyyHTdoJ/5K1VV9Ks?=
 =?us-ascii?Q?9qO414Er/aaK1ZJ2C9AaGAtEfddAI6uqI8zvjDILTeIsEB0pJeMTyD9RiLvP?=
 =?us-ascii?Q?XS3USKzppijMb3qA5Ut+KcINOPnYqkST/zUJ13U1BSMn9j40xI8bqNHSKGLo?=
 =?us-ascii?Q?ze/+wdfkWuOt+1y3FBrWBvvnNfIEKGDU7Q04l+8Akg8sWLO0GL/9Jfd8koAz?=
 =?us-ascii?Q?fsZoNmnmBeXtMAFCcv7OgaEQf9GZa0IRwVvYqSeo1Mla7NNDqMzEwBMgSUHW?=
 =?us-ascii?Q?h1UU8btDldTX3gy2aTlS5GeeYCjd3q+UIv16NwMYayhojQWdLZjFa/67hlYp?=
 =?us-ascii?Q?7G1XVDvryQcNlpogTfnNEQdaDtlBo8ILphec5QeRtH+gtiUBIe4QeGavfF2Z?=
 =?us-ascii?Q?lOSqhtvfSs2ivdqdpY/EWoIhVEivKAj268EEKhCt68MEYWNN3HTGKvgtLmGQ?=
 =?us-ascii?Q?4Ie7gvL3xp+3BqygpVzmDbQjWsv9Qt7bET9GBKCtVMOfoCPmBetVCDSzs4An?=
 =?us-ascii?Q?2AKJc2KOFG97nyZD9xM5SIo2D3r5uBMpekchNhcY2mQzHbKtA1sisadVisbZ?=
 =?us-ascii?Q?IxhLCWTnXlQQ0VFBWpVMY5QXCf23u1/eAra2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 04:15:56.3947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9b513f-081d-465c-e7e3-08ddce569db0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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

Move amdgpu_device_health_check into amdgpu_device_gpu_recover to
ensure that if the device is present can be checked before reset

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2659e3ebbe49..176712225037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6129,12 +6129,11 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 	return ret;
 }
 
-static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
+static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 					  struct list_head *device_list,
 					  struct amdgpu_hive_info *hive)
 {
 	struct amdgpu_device *tmp_adev = NULL;
-	int r;
 
 	/*
 	 * Build list of devices to reset.
@@ -6155,13 +6154,6 @@ static int amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 		list_add_tail(&adev->reset_list, device_list);
 	}
 
-	if (!amdgpu_sriov_vf(adev) && (!adev->pcie_reset_ctx.occurs_dpc)) {
-		r = amdgpu_device_health_check(device_list);
-		if (r)
-			return r;
-	}
-
-	return 0;
 }
 
 static void amdgpu_device_recovery_get_reset_lock(struct amdgpu_device *adev,
@@ -6449,8 +6441,13 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	reset_context->hive = hive;
 	INIT_LIST_HEAD(&device_list);
 
-	if (amdgpu_device_recovery_prepare(adev, &device_list, hive))
-		goto end_reset;
+	amdgpu_device_recovery_prepare(adev, &device_list, hive);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		r = amdgpu_device_health_check(&device_list);
+		if (r)
+			goto end_reset;
+	}
 
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
@@ -6956,12 +6953,6 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	int r = 0, i;
 	u32 memsize;
 
-	/* PCI error slot reset should be skipped During RAS recovery */
-	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    amdgpu_ras_in_recovery(adev))
-		return PCI_ERS_RESULT_RECOVERED;
-
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
-- 
2.34.1

