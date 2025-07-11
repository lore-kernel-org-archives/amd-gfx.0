Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D138C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 02:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FC010E162;
	Fri, 11 Jul 2025 02:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HpwlvW63";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77FF10E162
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 02:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suuBFKmJdRejB3I7Gd2hQQrkVFVOh4pQlm0jqVBhR7+m/yO2qqRL0aScEADeTHnlsiMaKrcFClAkV6+3JolCV9YV2F0HXBnQF03nHqQfz1q4yZI+d0tWmTIjzorixnHfmxvUmanrTc1Eawj9gBHO8sBUQE6VZHS9bDbaNwczk7bkm7RCibp5JTwljt0JdIsV5XuMTPNuJyiFaY5im0D8d/0weAJ+8ZT+NnoWLZlvlPmB1SfOObK0oM3Dt1qMOzvP72LoE/OxmfLJeaa9c4pjxk6rQGH2AWSdEead8FP8sIAfEYXodtxgk97A4XfUlyFE4HVe/cyXm6qnvCdc9yUH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlnksYBe452VevOKGF4xCk9MdcdrfrkTi/X5TccJso4=;
 b=EYO3eVQ2CKtoQmezY7z768KWwoRsvZEE+pOCpk2Eu7zYT/BCHDgGp1LTWV9LkPZgxx7IMNdGI1E6T2CqQmUMfIbDvPb212Td/wvK4R+5q/aCcFhekM12wXLx/RZfDasT7xrJ+ym8EoP8ONfqXHEEuBX+C9twnAcq5XH8NvDnW2OWyi/ElPfNxbDQWRhxRfNSm4WopenIxY+Mu2329sv3LWkT6O8RasUc5pz4EeR0PerS2lZRbV7jKiT62WheSYv7eSOpayfM0REslGFPC8qfhHdfmnhPiLiqdqKNV8/Pz2Joroy5T9JSxdrho3HJQRzQGixf1VF8u/+Psny7ICG4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlnksYBe452VevOKGF4xCk9MdcdrfrkTi/X5TccJso4=;
 b=HpwlvW632Fvyr8DrERdcuIWFJ6mOlPwvMdf1uluLVP15qlHn6rayJ0zoOf11rKw/O+2rjemu7ys2drBZp/hA67UmHiTxpaOmwNgRsGpdhtPaoDraZOxkLK4nQ8Z8BVvoR9ojYvB227ccmp9YrDd3ncngys1ZBQobMz9aiMPRt8w=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 02:41:19 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::bf) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 02:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 02:41:18 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Jul 2025 21:41:16 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Date: Fri, 11 Jul 2025 10:40:58 +0800
Message-ID: <20250711024059.25658-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e4075a-485f-4ed1-8874-08ddc02469ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TcwrE8pZKHGEXKQvlWkoGYn1t9fXPyhtYPUeD8Jsznmuz4cN7cxVpgTt73Yu?=
 =?us-ascii?Q?DYkFjs9u3Uny430CdJ4ijO7HJmcADktxic0H/sJeRrXEo+eGiBs3szetgKkx?=
 =?us-ascii?Q?WeHim5S6Zijbkyvfja3V2tUDQvRrZVdbDEL5E4lHObGj79JpELWXZAXGgbGq?=
 =?us-ascii?Q?JULt9bTkafLRl8EmJVcITDByvg30wXneINdPXtvigKGKiVfaMFNvmV3bT1pk?=
 =?us-ascii?Q?eVYX43V2nlHfzDwOF9ZPRgVY131/N9u28lIFZakD1zqNDioXBMI+wefM9jp0?=
 =?us-ascii?Q?JTMGgcHVhS6p+E2EmgQcK9O/2TK+lR6cd6yauLJlFNKdqEqaR1c4FXNmPZq7?=
 =?us-ascii?Q?h7bgUS6ZnIoUrrTLpYTF3aavkF/wt0P5NPWQ/vxvGxH0PDM4k9c1o0YgFPZj?=
 =?us-ascii?Q?y8igxHY/ivGwzXkF2WRYYn5JuQXci7OjStFgMrCFv2Mi2tmNEvIrqcdjXttA?=
 =?us-ascii?Q?JYIkRdgYGViT+RaK4Na8SaY6scooa0mXdCa8utynLqg2r6NWkHSMCKhPkPgb?=
 =?us-ascii?Q?OhX7kXdI3b6tfXW5bLBFtZS4FD3U4vIm2QED73IRuTs1EYZ5V87YKeYEGVkN?=
 =?us-ascii?Q?MJvM098Vfcqqi7ApVYhNlgrkwHDvf/EpjIRsXyqNdRE476yBCRBaUhD7wkAp?=
 =?us-ascii?Q?9X92w4J4PMaYfeSllq96GICndtmD1gA169+0y+7rmXiD6T+IcnL881zznmgv?=
 =?us-ascii?Q?W6w/TsvKhn4ulzDlJOqScg+8Hw37JH1L66u9+dmCDiqi8XhsS43QBQrSb5TG?=
 =?us-ascii?Q?XZFuMV2RYn5cqfU8LZt0I5WOlQZ684Wjwvz0Cjmgl9vesFvDzhjd8bguuEc+?=
 =?us-ascii?Q?MTUE6Y8DpePTBJLrKvq1EjXqXugSXTVDzbW/IKszkZG6n+xcxhsXzi6cSw3P?=
 =?us-ascii?Q?IeI/QNlt8LQHLRQoG78wLXQ6dGDQF74OFkhMAyMjv2KcuycooOG7MtcfVJA3?=
 =?us-ascii?Q?qY4FagFpkq1Lh9QFXfkRKy01Hx62J5g0BZqnM979ll2OqHN6GVfT1eDCNpwY?=
 =?us-ascii?Q?VnaO9gLzXt5UJ24o1Cyk9evIWLpZnoEftWqlBk94K27PkVpCWuHU3PqnaoLk?=
 =?us-ascii?Q?tOwP4fm1m2JDa0cDpYRqzvyJvgzcegwphBlkkljHAYFvv8CpZXRNh3Xg3VSK?=
 =?us-ascii?Q?ViX0tL5cVGhpu3vVEzCVRUSixdpIa6b7XOW1SCRx9oKpjlrK+bGkOXg7lrST?=
 =?us-ascii?Q?CCqTtSPB90yjxoRZhKCBe+d8CzsaJqnvn73uZwA5XdAp+/M0NoDbcCxZX2go?=
 =?us-ascii?Q?U1NwH4WDthtih8pqqo6+mkKWo4FUgWlo9Ploy55XLK9XyqtLIHRTnJGX9/dv?=
 =?us-ascii?Q?M/5hkvQJpf9Oe6PlH/YSPR3uaGiJc+BAY4JlZjwDpNT4hfCWVMtE8mE/8JN6?=
 =?us-ascii?Q?K7EACJUecusa8cwh5yqJ+jbLSJrO5Qz2bgs46kYZNuavCnfrjtnQHrYXeCM0?=
 =?us-ascii?Q?A4LiBjgFireVbX6zPh/aiHqCBqOyy9k7RWgDe3+QyxU5ogoUTPBRO2Gf9Kre?=
 =?us-ascii?Q?EbZCAdZfXLmZ2SEQ5FoAK6F3+5ymqr8St+TH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:41:18.5531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e4075a-485f-4ed1-8874-08ddc02469ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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

add eeprom data checksum check before driver unload. reset eeprom
and save correct data to eeprom when check failed

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 571b70da4562..1009b60f6ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_ras_eeprom_check_and_recover(adev);
 	amdgpu_xcp_dev_unplug(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2af14c369bb9..2458c67526c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 
 	return res < 0 ? res : 0;
 }
+
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
+	int res = 0;
+
+	if (!control->is_eeprom_valid)
+		return;
+	res = __verify_ras_table_checksum(control);
+	if (res) {
+		dev_warn(adev->dev,
+			"RAS table incorrect checksum or error:%d, try to recover\n",
+			res);
+		if (!amdgpu_ras_eeprom_reset_table(control))
+			if (!amdgpu_ras_save_bad_pages(adev, NULL))
+				if (!__verify_ras_table_checksum(control)) {
+					dev_info(adev->dev, "RAS table recovery succeed\n");
+					return;
+				}
+		dev_err(adev->dev, "RAS table recovery failed\n");
+		control->is_eeprom_valid = false;
+	}
+	return;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 35c69ac3dbeb..ebfca4cb5688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
+void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

