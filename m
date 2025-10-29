Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDD2CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5050910E78A;
	Wed, 29 Oct 2025 10:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s32r/QL2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF1610E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKU3KMbbNzA3hEpzOeMdy6LPIKVBo21wbu6Cp/vS7kgYvpGPkOoX4oyFekpdlUFH1HuFzyIxMsMTsRZSV8YR4iTB6WruUW3gaIgGonGRRsYuimAvMzPk7qveu4U2vMVFR2h52LswQSa1K8QXVe/HXEZLpFSL5lAqK/lRhkd7qbrpJFQJUx/bDp41QmuV5FuJ5qnQHQ0RF22n4Nh9VeqgEZHm1EmP3UMHjzJQ5RVEl9Gir3tGZVOKVWVgONIg7sZWeFaqnMA1HGVoTVywNd4Oiy4DqFLJbG+bERFfWpcc3p38vSstea2nKM/rs1WybbSH4at23hIsqFnb7a4zTqXOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeQsBpBQcl9hxRtoBvdessMy/YQgIhmPjP7rBJA4DEI=;
 b=Y1TzM/DmmB5eea7RTRR6if8wboWt1yIQtI4gjSY7c1JqApALVPKmkqcBR+FgNE1QFmo5yhyiVqOkXkGzMCNwFLJHr18LMBXn5Q11jt36zU++8cxyyrRINzDC5J2ve/DsJwpuO3pc563X9ogrce334PBi3W47EflX99iXTjJbMQ74gCP3n200iv5VYg4cQUYqWTxJxXHXU21P8ihbob4yZbBpWHmpe80evGc1N/Bq1D7XYUQWrxpy224ZkhwclWT9/aJ+6k5EWUUTWa236Om6pDfBW9BMZy8+NIiFFDhYKWxXyYF3ecUslXirECMOMMMFUwzudaRWary26927pW5kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeQsBpBQcl9hxRtoBvdessMy/YQgIhmPjP7rBJA4DEI=;
 b=s32r/QL2w8DOn6QpYb5uOtSNmVUmm97iLX3gh0378Qye3bHD0AoBOdE+VguVBGR+e0b+xfehpes+uilX9EQrtdWpYFXmLgJkFhMKv49hwvbFplxbYR93+qpVmnaU0bsCvxBISP+h2tVwdHjHXBdvYXgkYTLaa2tpeUPsv/WHTSw=
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:38:16 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::6d) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:15 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:14 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: skip writing eeprom when PMFW manages RAS data
Date: Wed, 29 Oct 2025 18:37:58 +0800
Message-ID: <20251029103802.1402199-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029103802.1402199-1-tao.zhou1@amd.com>
References: <20251029103802.1402199-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5174b1f7-0229-4a7a-bfc6-08de16d744b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80TIVJFWcXpKKeIH/xuJdlXemzpul34kTobzFNVIFmR1HMKMQ3lYYpvE7KuN?=
 =?us-ascii?Q?VQ6dX7UDRzvM6RGFa9ht464dStXiQ23pTQJtPmuE25Ojg8SHobMBAHhWVNq+?=
 =?us-ascii?Q?dEnas2P7YrZQK49TUU677gbpTwJ6dY4uZ76gZ628uMpgD6HDnxtf+Vd+km+p?=
 =?us-ascii?Q?qLy97p8F/MNjcHdMk9OSOQKa57/BakLBKAVmAbAEXiHxhINKUCZA7uqS1gKH?=
 =?us-ascii?Q?3S8dqNqicPK3Hrm3wO296TvCQRd/rSXFL2Qu5k1uVb4qIXCN20zeyKh0npKh?=
 =?us-ascii?Q?Xxp2B/U6seHE79aK5/xuHRslOubpWtOozhVu6rPQEeQzMVw5hMywHwfuPH56?=
 =?us-ascii?Q?flKO7oPFgGGahc67AuvZbjWhfXa8Y6Bko2bQVEQzsVU9G+EgoMVj9X76OtdO?=
 =?us-ascii?Q?lKhBS1kgCSlxQoKeTo5HxzWW9n+yqLMDaWUpMuZ+dJIBfBi+NsO0YSmQnael?=
 =?us-ascii?Q?nNZE/G4iiHMYBgsN1ZsyjILc0Bxx50cJGXoBosCsAzcwOEc8JpKdhV/CBhmR?=
 =?us-ascii?Q?i2oEMggFbk1tRtg717qPt5HU23sEeelZCTF+LwtInAqV1ix2eCM7ycUMuU4g?=
 =?us-ascii?Q?LUP38n5Uxd9ggy5lIsmQ39xSElKKnwtFOnmbMUbRjbS3IR6ExCbjuEpm7wuN?=
 =?us-ascii?Q?2/aLy692vuWaIm4FZ0Eg1FEsN3DKB2MOpXcyv/qDF6aBwdnnZO449fyNpS1i?=
 =?us-ascii?Q?aeeF7djK7NFZax6hzl56H37wWsxtyjWWUJqM1NfLKdxre8oPpoUVIB9zIV8o?=
 =?us-ascii?Q?SgC8n6aQZzlcPGj9fbrGXcLwq8EA0TF/g9d4fG8NdfbYwG48xkVhTmdKLGFS?=
 =?us-ascii?Q?4bFFegXcV+w9oVtSWCkSk7Fa4uY/B91Sa5TPQgk5rCfESVow7MZI+Ty+BtXe?=
 =?us-ascii?Q?QizMgjbqc1L2d1LafFW4SEfG9PW+8nra/VFYVMj53awnc5x7qmLnTw2Oz204?=
 =?us-ascii?Q?aP1udvBrAiUJpn4xxm5le4biSIvk5F/T3oBO/KtiTkn2JPU3uPwx6O9AkRiH?=
 =?us-ascii?Q?H0fEiuhlgLb9hJVUcP+Ch5diC1EY/U7HorK6GmDldopD4vG3p4z0q0dzMMpH?=
 =?us-ascii?Q?9tAm+G41zeSLcpbjuVaqNAlqv1qFatYlaPeQm6QW7Gfkw1qnFgBgMpGZzypi?=
 =?us-ascii?Q?W9VKCNevYRgDYF8ihihZ3/r6c7m23s6m0k5i6kGzWRDLvGPd99G4vHMoJxxc?=
 =?us-ascii?Q?UhMksIJ4irAHwmpmaAtfOMdVTimJSi8byxAuLBF7QU+5R2fbWmDOV48UY/xH?=
 =?us-ascii?Q?Rf/cT1oxzju6z5NzF26iLYQyX713g3sTtWaPJv/alUHTmMQY0/jg2aF9wcoM?=
 =?us-ascii?Q?3tYSfbBCD0OqBtIL3xlTFae/lbKYRspUZj8qOvtqY98Ry4OE0kVsL7B8fuv9?=
 =?us-ascii?Q?tFmXglX2iS9N5lkrRn0A91AMRHXvG1VUWDXy+b+PTce6yOKCxFpjyAvfBsoK?=
 =?us-ascii?Q?DctKpavFrIpGgx4Ao2dSzmyswzIhdy7ey6z9uVJaOucQJwixJinOK/XomglG?=
 =?us-ascii?Q?unAootAJlFTjoGQRRfBW9qv/c1Wbf/H0p7kTq9bXaSiSK30ct29hEIwOXTRF?=
 =?us-ascii?Q?FyZhMZc7GL6LEIvvFRI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:15.9309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5174b1f7-0229-4a7a-bfc6-08de16d744b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

Only update bad page number in legacy eeprom write path.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 20d296a68934..3bf633158fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -864,6 +864,18 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	return res;
 }
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_recs_old = control->ras_num_recs;
+	return amdgpu_ras_smu_get_badpage_count(adev,
+			&(control->ras_num_recs), 12);
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -882,12 +894,18 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev)) {
+		control->ras_num_bad_pages = con->bad_page_num;
+		return 0;
+	}
+
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index e881007f715b..2e5d63957e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,6 +82,7 @@ struct amdgpu_ras_eeprom_control {
 	/* Number of records in the table.
 	 */
 	u32 ras_num_recs;
+	u32 ras_num_recs_old;
 
 	/* the bad page number is ras_num_recs or
 	 * ras_num_recs * umc.retire_unit
@@ -190,6 +191,8 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 			struct eeprom_table_record *record, u32 rec_idx,
 			const u32 num);
 
+int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

