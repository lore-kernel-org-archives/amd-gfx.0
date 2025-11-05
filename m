Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CECACCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2127210E69A;
	Wed,  5 Nov 2025 02:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMwZITgB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864DC10E69A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs7C3RnqGwaUZ4ZpgwMHrPeMprSxNhmxLGs9OvmiebQTUhXQNma4IUzbOG1l25yIwDCa7S15Yg+r6zpn65DfrJiWMFBt5+pxJUpwejh0UwulZqOs7TfQyKpS1OMT7tMlJAn+SGOcdFEAWiEgHPM9PxfnKv5ogSf0J5AjHXedQnDS6WEWMfqEq4sCmAK+XavYm8rRuLpXLqH+3qJA0fCiUde+2rXgKsLvqzvMDKdwJGf23zwz9KRz+mqTjnnZDrV4De6X/IDAonsULHALKBCOa/PcDuJECGtNpT15Mog1qNU8M/zXUO10o7O9+vfONGtOOQMSDc2xCjyXQsFPGfTAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viPA1KQEtVVi0vL7NjZJq/29tPm1ZDB3HG3TiBQ1qcI=;
 b=P1DzZdUzQptQAfJrwtxqge4DOa+dSkP//q9jvtM2xnyxNh8ycZYP6NX9ClOke3G7vXRfpfy3hBvdytLutuwOiiJnyoI1OfmY4DPtN/f7n4KzdftJt6H+cQTUdot6ePOnwlT9OxObXvXDR/1IL42b2HOtVp6bIiMUARvNlbp/GDdwSYPGvHrRHdWGTmo+W1EgDPCj35DOHyMG5lNbs2wXj/Mcav1LF/UrcfZnRhAgg0ZQcoGF11QqhEv2MxWNSSA8Kp0ikqgq2uHMAhgdJx1q+8mvnr7TcqAI3/7WyV4qB1+p/iqF+hOdDhxXKAcIh4EsGRBYB4J7dcJI5R7o668Hsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viPA1KQEtVVi0vL7NjZJq/29tPm1ZDB3HG3TiBQ1qcI=;
 b=kMwZITgBA4CzNVQ2A1D4HZP4/FJm/FTVZAiGP7a2B/I8kfLj8Oc2MeMrf+5BSxdF4Mo8FF/wEJ4V0MM7AqfATrux7O20Z7ZJqPp1wS6N/k7ci4k6mUkLQTB8QysgnMKfRjqc/GiS7ktqx7D/qq3uv0htxKyuV1f5Egd7qFmv3T0=
Received: from BY3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:254::34)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 02:04:57 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::a6) by BY3PR05CA0029.outlook.office365.com
 (2603:10b6:a03:254::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 02:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:04:57 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:04:55 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Date: Wed, 5 Nov 2025 10:04:39 +0800
Message-ID: <20251105020445.1423034-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a6b7d8-f25c-4c4e-e487-08de1c0fb82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1nkKrQkmEyOqbzUQpvEtEDvtEl+L+VSfVjALyO7GbnKGe+zFN7pMySbi/4z8?=
 =?us-ascii?Q?gRTymzr1bK/c8CKdnoPPh1LVUGRBPRM2jd6NoNj1Ywx4HmCf12/4MjBoL1Tq?=
 =?us-ascii?Q?wDcrjKI1RqETVS7QsHPcH0jFhnjz06GDxLqsv38jIdnI3Cz6NOR6YgrqevPZ?=
 =?us-ascii?Q?TCMNAMQvEa4eZ199Z6L6jDvzzFB6uxM6EsHJjX2Yk/tRdOfbfIGAO0UkJpG9?=
 =?us-ascii?Q?d/IMNaRhjlx0cPm7k1Qlm0b0UGM16lvsaXFk39j67L6kPUuD/PT2A8kVhiFI?=
 =?us-ascii?Q?sZ6TL6vHjmyShYVPIzZcNSmag/puLt+yuFLgl5L2sthUjsw9IYET6zhmegCr?=
 =?us-ascii?Q?uwvwvrp+h1/voXz1aShXCejD6oiZ4h18ejyyDtQ7z/nXOXyz/EEKRrD8hYrr?=
 =?us-ascii?Q?MLcNEFzwWBUXYfBl9GvYRpfq61ZZCiLE+hyKwbqLfc65HBUjW0/E7WnW6LEN?=
 =?us-ascii?Q?vggjpdbizleOPzIruA+h4PjJMfXk7nTjFscwwUhOp1+vluA7emihXTjM7q5m?=
 =?us-ascii?Q?KAWlVuuLUh8bHenmhHIKSMon0F3KPGV+wFvPdYdEfAv+Kku9nVOFlMY/QMUI?=
 =?us-ascii?Q?SaI+5/V29R6MwZlUNiuui0OS0diyaACHdDIlYEGnfmQF8bvLiV7H8HlZVSiG?=
 =?us-ascii?Q?0yZl6Qj2oaZmD2de88YvzkFXZKm4XysrpeKzzlYEka4xiGXHQy4T6ZCAJ6EH?=
 =?us-ascii?Q?lBSGb4Tog/eVZ/Fg682/emRKSK7bhuDit/34UY/UqYgSr8qSmAcJs4mWPgDR?=
 =?us-ascii?Q?tAxXIH/dILYKIOyaGKtat3c7qWowDaoZArCc6fn4zI/w36SFeeSvQntvqh3s?=
 =?us-ascii?Q?Q7gO5ucnfLtPJR/nUMgB82946VhhyC3PNefOsjtsJSFo82jJEuXcr/g6Avo+?=
 =?us-ascii?Q?tkEr7IteYAz/jcCVa3yP+MzGFdxksYMDZrT+skoBH6OjXzYJUgzTi47amc+c?=
 =?us-ascii?Q?FXQAjgJK5/njeoG7OphwsYmhitIh6tTX5lIm37n/Ck7quOank2N+dUCVk0wc?=
 =?us-ascii?Q?FtB5TYhfaUodwIMzasVvrr2OPmH0C/jc3orPoEGxBsxnFSLPcddztZ0qnxqM?=
 =?us-ascii?Q?z66ryc4C+G7lmy9CRJM3GGpvsfYxnQcjeAScQhHTCeeuFHTWyqSGCLpXChtH?=
 =?us-ascii?Q?AC+gnoblVdZGgnYv6qi/igqJH+EG0YT7cgy99X+U89f3cbd5dvdLhoDAbEGw?=
 =?us-ascii?Q?YNu+N/theIHpKAF69HTuzMsjQGfNDgoF6MM4EstA9QHuHhMzjtMRQ/qP0ytf?=
 =?us-ascii?Q?/7mk/vRcHD23vdaTwwpPd0PimmkEh5bFByMARLNiuO1UfKnTNZrm0KZuFgws?=
 =?us-ascii?Q?UxO60mlTFcJ1WTRBCZ6mKtP1no74JfIiNnmCubOzjYRTSeWTVJmFjmHW5MFd?=
 =?us-ascii?Q?+vyGIetAOi0yGPnoelNKnQQxY25jVKh/9p9T4RXhtdnXDFjSti+cgCkTpycp?=
 =?us-ascii?Q?7xf8KipATPdHdE2k9WipEvu0h9bKhw3QTWi9LntpTo2dHY4DncTHY9Cy2yhZ?=
 =?us-ascii?Q?SsAEcNJRQsbrvwiM7s+JpYds6Wmsi2TCv9hdru2O7PJV8+Dte1qPEIUm3Pxz?=
 =?us-ascii?Q?uEG0SMSLWEf8VX5LJD4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:04:57.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a6b7d8-f25c-4c4e-e487-08de1c0fb82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669
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

PMFW will manage RAS eeprom data by itself, add new interface to read
eeprom data via PMFW, we can read part of records by setting index.

v2: use IPID parse interface.
    pa is not used and set it to a fixed value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d7e2a81bc274..47f292557a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -970,6 +970,50 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	return res;
 }
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	uint64_t ts, end_idx;
+	int i, ret;
+	u64 mca, ipid;
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	end_idx = rec_idx + num;
+	for (i = rec_idx; i < end_idx; i++) {
+		ret = amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
+		if (ret)
+			return ret;
+
+		ret = amdgpu_ras_smu_get_timestamp(adev, i, &ts);
+		if (ret)
+			return ret;
+
+		record[i - rec_idx].address = mca;
+		/* retired_page (pa) is unused now */
+		record[i - rec_idx].retired_page = 0x1ULL;
+		record[i - rec_idx].ts = ts;
+		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
+		record[i - rec_idx].cu = 0;
+
+		if (adev->umc.ras->mca_ipid_parse)
+			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+				(uint32_t *)&(record[i - rec_idx].mem_channel),
+				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
+		else
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_read -- read EEPROM
  * @control: pointer to control structure
@@ -991,6 +1035,9 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	u8 *buf, *pp;
 	u32 g0, g1;
 
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_eeprom_read_idx(control, record, 0, num);
+
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
@@ -1162,6 +1209,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct file *f, char __user *buf,
 	int res = -EFAULT;
 	size_t data_len;
 
+	/* pmfw manages eeprom data by itself */
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
 	mutex_lock(&control->ras_tbl_mutex);
 
 	/* We want *pos - data_len > 0, which means there's
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index cfbd402ddea2..e881007f715b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -186,6 +186,10 @@ int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_device *adev,
 int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
 									uint32_t *result);
 
+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+			struct eeprom_table_record *record, u32 rec_idx,
+			const u32 num);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

