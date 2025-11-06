Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1097CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570DB10E889;
	Thu,  6 Nov 2025 10:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XK/iqpLy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810E610E889
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=houQ7gH1IE9TXrrS7LHFGeNhBl1s8XJmRrtpqsz4aMaSAnl407Sz+iV1ygxut/H1ViO4OkFaHYV9HWSODseDWsHiYCtI4lUdh4suhA+LYzheGNHsTOfo8/7kb7TGtukUMU1jVS35QuVmLOJEj6S9mDChhDMp/N9hFXsiztq2u9POT0+4LOegyEy0N6Lo1kL39PlhxmSqnzYIfWRofUZi1+p4Ngy9jBlRCgyPXan/Owkv5HLH9hD1C38B8G+GQpm7ox8uS32nUgFvt4qFiyUPMa64BtIzWm1/ee9a/CywZZwYlxgEeqwtaEoj+TRILeytNHjI/Ii/24NEVUKdFkf7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHMv//s2ctrNcVw3YWKUswSj5hYAcQrMERQk2yPeayg=;
 b=YKGFIKDMQ3L2ww3MqlG7Fk3N89GLclTgsxtpn9kj/ZEVJpEbzQZ4cSzvi5Ixtj2RmqBP+F+kG52wz2Jp4xxJTXI9a5X3NDpdHTNguDnXSgWlzbjlS3mKAboiGspTFllzAM79eTYDn3tq/aDL0M/1SDP1C9pCUcxwXl6D1wZrdN1tmuTuSfrr3P5fKDteIFR90Mv0HaVwlBSGjEp0O9jvzSvxOhwcRpu3aw18dnjokbgvtvYg8vZQgJT+ATW2CETsmqZjrnOc3FNH3LcYtI6RyyIXFHhYy8I3RJIr4Z7pG9AiSKaYbdEwbhaPeZVJM+fkFSqOBKlqEXnQQAHldg0MGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHMv//s2ctrNcVw3YWKUswSj5hYAcQrMERQk2yPeayg=;
 b=XK/iqpLyRmNchL9CfLfvz9VSe5XtAPzlDcDKkMfTWvfQQsV6/NYWjVbr1ecjV3QqlGwHsGwHHCOEcjR3BSnGPG0MHRo+lwCXumgLCdE6voGqo60+al586dJxUyjQ5/DVvPXak6B0aO2+/iaHIoULfQALNxUFchn53qfrVUSuw70=
Received: from PH0PR07CA0098.namprd07.prod.outlook.com (2603:10b6:510:4::13)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.10; Thu, 6 Nov 2025 10:43:20 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::b9) by PH0PR07CA0098.outlook.office365.com
 (2603:10b6:510:4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Thu, 6
 Nov 2025 10:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:43:19 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 02:43:06 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: optimize timeout implemention in
 ras_eeprom_update_record_num
Date: Thu, 6 Nov 2025 18:42:56 +0800
Message-ID: <20251106104256.1440318-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d01c2c-af56-4d2f-c395-08de1d214cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/5gbFYjSAIZI5dvBJMvwOSH6nL4M2gY/259nfpC0WDYSkd1QJ/yreLv1Pnba?=
 =?us-ascii?Q?nBZpvgLW3O+6Kl679Y0Rioy1fuuLP9Xl1QeLyzWYB3WzTf6VKKLj1O+PkqrF?=
 =?us-ascii?Q?HyAm+DKOMCv6zLQXx7x3/3RKFyJavVPW7w7dM/7ey0l6gUtLdrhvknmHRmDe?=
 =?us-ascii?Q?XtVv8shh5VIyCDomVddRzUOVyV3S1ZriEN9dCqY/sPaWzz6QdADir2JS7IQW?=
 =?us-ascii?Q?SI0EWlwmLodWmkq9mEJsyvnFkU22PhXMsWjn5bkTPQRqMiOpeFR5NDmFx6Nq?=
 =?us-ascii?Q?J5eqPfLVGmMLihe7Q9YXvIhUSRVeFhOz6QEKjmEUbDXegKYvyerGalgYzxH+?=
 =?us-ascii?Q?pZWsWDXO3Kx/o/beuUJXc7kWo/mh4crw8rJ7jN0e/jckIUWTERqlKTydS3tc?=
 =?us-ascii?Q?Z0YsTtBq3X+6NRbhcO8mbfZrt+phebGa2CzUHo9xpEcbR2D2BN1TI2V1GcOB?=
 =?us-ascii?Q?5+w7HFQzEdUEd1sRmskbQrdhc9v8+OHlVSokAmWT1qTL1CMjYEbdwEKjJ/tK?=
 =?us-ascii?Q?H3cdg7F05Dmp+uAMXti/Xhw/mpvFuJWSntoYQDm0nNMd4/7ABkWqWL2HZoX9?=
 =?us-ascii?Q?RYGKP/pbWIhyVqRmy4VDfb1eX0q1J/o1zDbWJls7kUh7dA+9GCeQv6K95ZL9?=
 =?us-ascii?Q?3Cbzy2O6d0yGnHxKwj2n5jhfH7oGj4EybDGBJbYJulTqpKcrOn4oCBpyg+oX?=
 =?us-ascii?Q?1ZwrvVg2lSxVMMCG87ndZPtlxazKKAYxQL9YhIByFUk0TN175jhMcrovzRON?=
 =?us-ascii?Q?urQ1PXmtEFEw7znRSK/QFrGmh5FdmSW9Jm94mbE4/vIMi0Z1wJmGZjli3BgB?=
 =?us-ascii?Q?uoOdi4Bn94XdvB+dSpizQbd1OGvk1P0XtcQJhFXwEHBuCSjYSK7ic+wyUObu?=
 =?us-ascii?Q?gcCuVR6xEscgN/vWLqYCCIiXxpBMDV40fylRjwzTH8kyprnElPcjvz/qQ6RO?=
 =?us-ascii?Q?4ula81NzGcR80luLVLVP+Y5zCeY+JpOMfHf8Bx50oWz+0u5h/LnyVnS9Rt0L?=
 =?us-ascii?Q?tSCMAt/tZO9oHUO08OSjsVlY3sEJ3Tq/gjC0Yfk6yo6oqHMZmJWH1LemG5mP?=
 =?us-ascii?Q?e2t4XwLyivZ2EVv5ZxnV5XJKOOhREiTwmEZCXzVULiCb6P5HLUPp/V5BAjEm?=
 =?us-ascii?Q?7lkm7umsSOjNqCjxDiw/6Kw0aKK0zCa1WNKkr2j5ZUOTbFpgVSeCXyU9NW41?=
 =?us-ascii?Q?Duo+4mLyQexD9k51PTdFm8QWrywcK3+a7TmiGMPzOO/cFRuTaArfAzwqD+qC?=
 =?us-ascii?Q?2aOiYYDN0TbN3dLh3jytUeHUPonAkWA1iMw+Qka8lgK7n8D2YLZd9j5WYIP0?=
 =?us-ascii?Q?fcf5GzFACWwtBd98lDX1nQBne3UuMm0hquo47GwZm1hiAZol6vFVRF83+62J?=
 =?us-ascii?Q?BkvLadRS+H+LggR2ld6JbV+2JoeHOo6ia/AiDrGLaWTMMoVTwPV9pkeVpa9G?=
 =?us-ascii?Q?bIeWttYQ2v7tBoYs/qrX8ziK1IFsXmBslFXEM0uLiWkzfuVj/pXEUuOE8OJ/?=
 =?us-ascii?Q?rlVVMiQQaUt88NxAD0CnJn+kBS+VqiODlQxrA06z77ji+QzPsRrq8H7a/f9t?=
 =?us-ascii?Q?vq48sFs3zAHzHHjZrhc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:43:19.1054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d01c2c-af56-4d2f-c395-08de1d214cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

The busy status returned by ras_eeprom_update_record_num may not be
an error, increase timeout to exclude false busy status. Also add more
comments to make the code readable.

v2: define a macro for the timeout value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 99aa1908833d..64dd7a81bff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -124,6 +124,8 @@
 					RAS_TABLE_V2_1_INFO_SIZE) \
 					/ RAS_TABLE_RECORD_SIZE)
 
+#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
+
 /* Given a zero-based index of an EEPROM RAS record, yields the EEPROM
  * offset off of RAS_TABLE_START.  That is, this is something you can
  * add to control->i2c_address, and then tell I2C layer to read
@@ -874,7 +876,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int ret, timeout = 1000;
+	int ret, retry = 20;
 
 	if (!amdgpu_ras_smu_eeprom_supported(adev))
 		return 0;
@@ -882,17 +884,23 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	control->ras_num_recs_old = control->ras_num_recs;
 
 	do {
+		/* 1000ms timeout is long enough, smu_get_badpage_count won't
+		 * return -EBUSY before timeout.
+		 */
 		ret = amdgpu_ras_smu_get_badpage_count(adev,
-			&(control->ras_num_recs), 12);
+			&(control->ras_num_recs), RAS_SMU_MESSAGE_TIMEOUT_MS);
 		if (!ret &&
 		    (control->ras_num_recs_old == control->ras_num_recs)) {
-			/* record number update in PMFW needs some time */
+			/* record number update in PMFW needs some time,
+			 * smu_get_badpage_count may return immediately without
+			 * count update, sleep for a while and retry again.
+			 */
 			msleep(50);
-			timeout -= 50;
+			retry--;
 		} else {
 			break;
 		}
-	} while (timeout);
+	} while (retry);
 
 	/* no update of record number is not a real failure,
 	 * don't print warning here
-- 
2.34.1

