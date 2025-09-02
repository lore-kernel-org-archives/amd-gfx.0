Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E5CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 06:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBC110E5A1;
	Tue,  2 Sep 2025 06:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWi9BoiY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C2110E5A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 06:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMlUF0QD3/tUdDCNdHJ4CKA/x5OsC1YRoeUSeMs0g2mbIUUOQtfl4eTjJ9GybxyFEZ8IfnjuRqA5BMLSYZOnQOjbS6iu4PLPic7zz/jAzljcWvkdqqnulcViBUTxh//RuKNE3HnqCbc1FA5xOx3W7dFSZoM8f47BAnmYykWpsDtTaRaUfj7PY0K1Q9Zm7O+7bFOjVagS83I752eOMPPi75/uDVrPSXe8J9Oif08UM6qAW8rlCnUINV4mGMQVvN5lB+sRMRapv9mVUa9f37sa61+ooPus9wH7aktkO7zpsn052MCweb1uYAvExAHusTQKlAJKANBAMiItZ29JI6Bu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiCvpVX/GHeVxmmZ0u6YV0wPCX+JlQHE3BLqrqo5a8M=;
 b=jB/nQDot9y+6oVlCus3Y74n5ONM2sbof4tP/hVL6qVP89wp6iVAFtsit8JzeM33+9XdFOCnuv6zFUvIrR00+a9WZnRFUnkYOSEutAQyDtLHHMoqOLz6vacC1u+wNDKcwK4T0JBdcthZSC8TumhLIrwjk1Ly8UILZNh6H0xIaQ4f63SnEdUM3XX6k8vkZWJFII8dtojNnBECuhlRKCUvDHLMIIbWJnNRSm1w7h2j3h9iCog2iL3//oxPWcJms2ui17tH3DwLwn9SAOErTl1dcCjB7JWYMt+d8zpdGKpgcVC6xLlqM/+MA35ChrnbWVmVahBY2PvcxYYj7bXQVKffcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiCvpVX/GHeVxmmZ0u6YV0wPCX+JlQHE3BLqrqo5a8M=;
 b=pWi9BoiYJpZAetb3l37YDQQURL1KeA2MGPidCCx+UjVj8yjpTgyqlK+CqlD9W2JhW1W5S7x/IaZwHsyYZRD0CBGIpt1C3n3ODY1dIWQ3aibs4xDMwAHESGTYTEEfQqhTXsfBkwPj5xTRAzJjc7zC3CutoLJY/F9wpVPylty14YI=
Received: from BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:22:59 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a7) by BY5PR17CA0036.outlook.office365.com
 (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 06:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 06:22:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 01:22:58 -0500
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 23:22:56 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Release hive reference properly
Date: Tue, 2 Sep 2025 11:52:39 +0530
Message-ID: <20250902062239.2310628-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e818b9-0914-40ea-0efc-08dde9e9297b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eotDwv2WvZR6Fj6jRWb678n2NfordJDcfgCKO/zZRHs5tB9K0Y32PTlDhYh+?=
 =?us-ascii?Q?pN6qpcOHj6PIO7NovUO0SrquMcqgfyn9YTPB/xdmDMQfX+SY2pgqCbjtefG0?=
 =?us-ascii?Q?5sycFRQxEV3N3WQpk5i61jDsqN0bDSYi4h9iDkuPHeEYa93hVAoTAsb/1AjJ?=
 =?us-ascii?Q?QL4klZhlXtV8jED1RUkiSOalCGvT6LR4WW+vXh1+uzB85Qr/ZgXdjWAxzm3g?=
 =?us-ascii?Q?hN0etrkkYA4i87Ub2+Gkx6YMorIcERD9YeBhxBdQzvV68v1uwIA9Qi6CsPTn?=
 =?us-ascii?Q?9jR8Gpf6IlIpWerJmBqpf2V1GDv1Vwx3AWgB0BVm6gCECSCb5f0R9kjipcIC?=
 =?us-ascii?Q?YlZQmk2pa2MQXEI/YQhPKlEKNNMbuoXNvShxgpmdMT/iYQdQqFi1wWQi9B+x?=
 =?us-ascii?Q?A6zpAGT7Wg5bjzUhOtMVjdNNgxT4c1jwoxQLZH0q4XxrlxiAEoKuSfOFPWaS?=
 =?us-ascii?Q?OZwZZq8d3moAJaxIhX6xpqbjaMdklrRO9weUyiRjbkTfgigXwPClis9DZBSw?=
 =?us-ascii?Q?RGA2YsIpaorGu8yez7Q7jrwK7aFPQc2Medl5CXQjDzfooIPE5AiI8BzZoARJ?=
 =?us-ascii?Q?vHfKCa2zBCP+yRD6Pfa/phy6BcoJPZuSxyR88jUMH9zW3R0t+G3CVeUq5aAX?=
 =?us-ascii?Q?kioeVRG9RHFhKfbSqvgENeLchsHxqFz8m5lei8DbGopmgADVvHWaIVDdrWKj?=
 =?us-ascii?Q?d3fuVrUSAQR6merFdbUsqjfilGy9sxPHOZOiioWnAO1Vm1sosGrhprA79Lsg?=
 =?us-ascii?Q?puYMkdjqijVxostnLj+zyRzYDQAKSnzcs4daY53Umqi9UfiM5HmQ1zTUAMFJ?=
 =?us-ascii?Q?K/fUPoBSq4OSgdcK5Ip5PeiUZO0wsw8L8WNjHNimDByTOyS8KhJ2bekKKHc/?=
 =?us-ascii?Q?6YOHnQQSLYtWbd6WywhSZ6vicbpVbv4D7vogB4fRt/t8FzLftTYuXUoV3sXG?=
 =?us-ascii?Q?8eudeOSIbfnZ3CLYw20l/DdGg0neYIYW8xU5oxoJsOJDs5f+jdpeXuAomnX4?=
 =?us-ascii?Q?pz8vNSovoCG19DOJCTbBUpaaBajSSnJc7G1O+qfk4RiYyfeKOhL4rA/1PW+j?=
 =?us-ascii?Q?GukUHpvIQE6OtqA1otSMz9FPr3y3xFwT5VfBKJ6s2IHNke0y8C8mu2UxIiQF?=
 =?us-ascii?Q?6buMiAv+r7uU7UL55ZpVfINd11RPgKd0fqm02Xp59KmlAwzOqHM5Bgk/C4Wx?=
 =?us-ascii?Q?rjmdFg08D8i4rpHmrqFCvHWAoTeWqiiuhBEFcqX+lsn3SPZgUq+11vo+5uPt?=
 =?us-ascii?Q?UQ1+NScy4pTL5V8JLeHzdqYwFTJqhQkACLRWpLV9R9mBeoHAfMSnNnwd0egT?=
 =?us-ascii?Q?SakSjp1MsgEudFODZ1et7SMC8ZTywHTDUi/kdYqCuJ8puRFJiPOhHI7TWcKH?=
 =?us-ascii?Q?YkS+APSpOSXE+h6oxCtz167R4J7CsCF2QmL1em0VQSsOoDg2BLd64xmB7MNp?=
 =?us-ascii?Q?LCHX4nQXxHilaS5a7S15Xsy9tKFxZYiFRuUpEhV+WPHQPZVa/V+IgutTPIKx?=
 =?us-ascii?Q?TSNsaued+eYsRaFNy4ja934NEHAml9G1NQb6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:22:58.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e818b9-0914-40ea-0efc-08dde9e9297b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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

xgmi hive reference is taken on function entry, but not released
correctly for all paths. Use __free() to release reference properly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7783272a7930..5d128414c283 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6924,7 +6924,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	struct amdgpu_hive_info *hive __free(xgmi_put_hive) =
+		amdgpu_get_xgmi_hive(adev);
 	struct amdgpu_reset_context reset_context;
 	struct list_head device_list;
 
@@ -6963,10 +6964,8 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 		amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 		amdgpu_device_halt_activities(adev, NULL, &reset_context, &device_list,
 					      hive, false);
-		if (hive) {
+		if (hive)
 			mutex_unlock(&hive->hive_lock);
-			amdgpu_put_xgmi_hive(hive);
-		}
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		/* Permanent error, prepare for device removal */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index bba0b26fee8f..5bec657acf96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -126,4 +126,9 @@ uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
 
 void amgpu_xgmi_set_max_speed_width(struct amdgpu_device *adev,
 				    uint16_t max_speed, uint8_t max_width);
+
+/* Cleanup macro for use with __free(xgmi_put_hive) */
+DEFINE_FREE(xgmi_put_hive, struct amdgpu_hive_info *,
+	    if (_T) amdgpu_put_xgmi_hive(_T));
+
 #endif
-- 
2.49.0

