Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08086D73EB5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919C010E8D2;
	Fri, 30 Jan 2026 02:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4xjZ3nm5";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2902310E355
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3Eyz7wC6uKHhAf0632DUkXdav24JH48gNpCDzmqb+oAGX6i5wU3A25z4rEaCdstb7hx7Vx+JP8sZf8vLH7Rp9eRC6WlxepkJRn92BovilSHnRNFsA2/iDOHrHsdjuWoy7ODycquKBvQhUUzkv65l9o0E2HSrreVOlwOzGFuYVNYyKYieRRpiQfPCMXPwpZ1lJJLtlioRAY9rUiMh2Y+3sZ2EmaPSRzD/Rf9VbR2d9zL7f/GVZqHctXM1yswOuvNnIguYfE+PV5GJcmvKQF8vgM8QVHLCo12rfKMUM441wXimMzYrAbCApCZVM21MVsQ3Ry/FQoMZBFNW/be2AOHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwGKvy3ksz6CtDaY8KWJIQGouVF6yK+c6rqVt6pEggc=;
 b=nWCNENd76KY1MKpd2eN7zRotv1dW0Hthqg393zUcNo2dC9e5Bn0FGrSm864rLbHgE+LNBpj5UZmO7sNpzig07A7Yk6Jw4LMNfbc7WLyRFIOCGbPZcUGf8i0PLVsCBJcbmhn36o0gjbTuj3paU4AgJ0u6BzWqEbiBFpu0ZsKumIEwr6Gpg/lUv1fvU79lhZ/1DmpMygSTElv97KYO/ZBKchipbW1CJCaw1UfOtLYi9eAYt5hJaRcZvKI6ul+CXfN3WIBs1XaA+cDz13zgScJ6XX5D6mo4W4S41n4TuLrKit1LZ0g0bryJpwm7pnLr1YAuAjy9cLmPHP9tEH3ux1mThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwGKvy3ksz6CtDaY8KWJIQGouVF6yK+c6rqVt6pEggc=;
 b=4xjZ3nm5gFfGqwvk45PXYI/BjSmH/GW858mI3qNBSCneIGAKaF+tkdhpEEsuZmYarfSmyFsgWaKaychro2nqbA34nfOTK1JvG/BPAUSa4ucVCUcrTdzp8K7rlzU2xtUjdF/uwiE8Guti6dfjasKgheShEW0hKIEphN/crfx+6fU=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by DS0PR12MB9448.namprd12.prod.outlook.com (2603:10b6:8:1bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:30:35 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::e6) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Fri,
 30 Jan 2026 02:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:34 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:32 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 08/14] drm/amd/ras: add append func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:44 +0800
Message-ID: <20260130022950.1160058-8-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8950f505-7b28-49dd-6ab0-08de5fa78c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fitawp4+e8+pr+OSaq5SBaRksmFf0W8CjDpVkWFtXzYIpTnd8LQQEEbXrs/y?=
 =?us-ascii?Q?qB3udSvqoFgtK612xIKT4TK4S+LiOhUcj04vPTTnVJuTnxFHfYiHT8OSoz9i?=
 =?us-ascii?Q?dK2vLAITto8+GfCOHhg2DGtLrcxy8GLId2ZBrZOjRdGatpuPxlwU/frUYLBN?=
 =?us-ascii?Q?USaCwpnoa7grWECXP4tkZvDiOUzH1GQD9H6ve4tE0hC0hhDNys5dcTmsa7E+?=
 =?us-ascii?Q?K05MqeFlAkd8m/XD8LFG+iCj/dw1Y+tkG10UrVIfK2uauQb8uefbmtW4fy9N?=
 =?us-ascii?Q?pHJ4Zh6cPvXrP6gRDreo1WVfsPE/bEdgFS8HmuGQmzXb/aNIdnokleuMsAui?=
 =?us-ascii?Q?6QhdE9MYshf+fTj0Q08A2ixX7V3rDU7IriENRZxROL9cvMcDmiGf49oOZhtc?=
 =?us-ascii?Q?tlwgDjfT1GNWEQvfoJib7HN8do4B8gzsNiE/a8W0FSCNB030E/Pwy+B+ZKbP?=
 =?us-ascii?Q?pIi8ncUlL+tcE2QqaHWhjclo4FHbG85eeY7NTMz/+SKYrm5nBhAmq7wSxOwm?=
 =?us-ascii?Q?/ks431dfLe9UBSeDRN3sRi1aXQfI+qZXP8tyhwwf/6dl6mFb0pm2YR0npjG6?=
 =?us-ascii?Q?dTW+o1zoIlAr5hAunX3i1EH9+1ENgcCsn4E4lM3d1PWux6VrzQz2U7Uu4IeS?=
 =?us-ascii?Q?8anKmw5HSG6L4L4O2EpuNGJ9boN33kyc5l9wFzYape3teJ6fFA/5jXKRzF1X?=
 =?us-ascii?Q?Wm/BjIMtnwMwTTz48A6PKC21EuNIHayHGpgrjrNKmilnT2QsqQP3Mp19+Aps?=
 =?us-ascii?Q?nz8fDl+MvxikRTNe1HZs4pBWWvp2IUyiWDJGvyftUQWE8UfRQYmbpLBW9IMr?=
 =?us-ascii?Q?SVQSu8HNTAsw43GrhjOLp4xL5As2e3F0hM6vq5OcbVgH8+sYv+saFs6kuy5q?=
 =?us-ascii?Q?EPeNqNhb7rjTQEhkgaKGUxyrg69GK7EBPtYqLwrIyUFMtFMVV570pdwWcKM6?=
 =?us-ascii?Q?I7PORvlkcby0DOYIM93zNJRhbInopYOS0leB+is0iFnB9Jt+nfab1ilKD28/?=
 =?us-ascii?Q?nvsWpX4h9sq91y10l/nL/4lmdeA1l9VS3kRvf/Kc18UTXwRDOgOmoCbVwxuH?=
 =?us-ascii?Q?0DzpxkKzVjS+rIs788rycXUQE8KFzcuXaXQPgPaFHwhAiddLbwyCAEWgxhdL?=
 =?us-ascii?Q?XTf13cuWQZS1HRSvbfN3c5kubrAcsAlQwEMDeGl/f7wX1VbRm7u5FHGvBIzy?=
 =?us-ascii?Q?ZLmbdIVCUParyZzM/+hTGqygTjG4dceCDjp2SxLdorkUBHfnp/iIk5yM8dDG?=
 =?us-ascii?Q?pkwKwNxUR6L81S2YEwtQoUXt4QE+8qkSKNgkATHKNlo6AkXR3E772Oo/n+t6?=
 =?us-ascii?Q?AMHTzIVHNmXJSjUo+CCSUrqEs4g7svhrbTcyfmpQtnhSvC0CWaep92JbQcas?=
 =?us-ascii?Q?2Lf7KiE+IVNvg2pelfUpVq0u1dksx7MK8CjiGh3tsIiqyGQT5O+Mk6DBIUXY?=
 =?us-ascii?Q?kq40LlxAavoeeh4sSykKuJXg/3ng0SlSJAvAiDLiQKYhoxvVhInJ22hx5pLa?=
 =?us-ascii?Q?WWCeR3wGgyGRt469lGYtastxvdDHxYjTy7u/7SmmV0mUrO3ENOu9vJ2mbSuf?=
 =?us-ascii?Q?3NWKgsiN2lp8RuPyIgGFp9B8rXfV4fXw5K+lDZm0ime0pMvZUSmxHXceeJlV?=
 =?us-ascii?Q?eAhwtOfZxv1tpybIvIUT2+wWJ4U/i0KsUScIMa9eI8eyf0Aup71NUY9ggRTp?=
 =?us-ascii?Q?hpv5gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pP/EII3v8uWsA7LpVKbQKOzLx252ZB7MVvTwwsCibxDPk803slv+MGBP0VWmuDKgAWq1vbSPakzRij24zVpG1orYFYwLLwHWsw0YepvBP+pHduka0GKNiNNyQM+JRlwd+qsM2UeC/Ef3XkjOok2PFLvlVL2N76oPR3WpWiOx0EDeEQ3YhsO2uuitw8Ccvkj8ryefjfHuqjOMScneE+hCn6x34I0DI8WX/Ci21OxsvQ9AMhp54+VGmVG0/0zBTbYfVllNXpEjKChmm3qo+JQubJ8PwBdCYvy/pt2PXUSIsk4Jo9ILaJl6en1rIQ24NlynnIpFCgz6OmN2sNdMMDzwJUNWLWzJfWx7XjUYXuhvbZIrtk35C/KOVByHSAf1e51bLeO2MA/70i0rKRZtniky0JmolY04XkoC9ljctFFh6jRMl+YlBWi2Dd2xwN5Fv6LZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:34.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950f505-7b28-49dd-6ab0-08de5fa78c16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9448
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

add append func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 39 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 10 +++--
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 34a4161251b3..580dd7b09d00 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -220,3 +220,42 @@ bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
 
 	return ret;
 }
+
+int ras_fw_eeprom_append(struct ras_core_context *ras_core,
+			   struct eeprom_umc_record *record, const u32 num)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int threshold_config = control->record_threshold_config;
+	int i, bad_page_count;
+
+	mutex_lock(&control->ras_tbl_mutex);
+
+	for (i = 0; i < num; i++) {
+		/* update bad channel bitmap */
+		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
+			!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
+			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
+			control->update_channel_flag = true;
+		}
+	}
+	control->ras_num_recs += num;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if (threshold_config != 0 &&
+		bad_page_count > control->record_threshold_count) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Saved bad pages %d reaches threshold value %d\n",
+			bad_page_count, control->record_threshold_count);
+
+		if ((threshold_config != WARN_NONSTOP_OVER_THRESHOLD) &&
+			(threshold_config != NONSTOP_OVER_THRESHOLD))
+			ras_core->is_rma = true;
+
+		/* ignore the -ENOTSUPP return value */
+		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
+	}
+
+	mutex_unlock(&control->ras_tbl_mutex);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index b0d3eade4377..b94d3c9703e3 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -68,5 +68,7 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
 				   uint32_t *result);
 int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
 bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
+int ras_fw_eeprom_append(struct ras_core_context *ras_core,
+			   struct eeprom_umc_record *record, const u32 num);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4dae64c424a2..fd427fd59ecf 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -479,9 +479,13 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
 	save_count = data->count - eeprom_record_num;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (ras_eeprom_append(ras_core,
-					   &data->bps[eeprom_record_num],
-					   save_count)) {
+		if (ras_fw_eeprom_supported(ras_core))
+			ret = ras_fw_eeprom_append(ras_core, &data->bps[eeprom_record_num],
+					save_count);
+		else
+			ret = ras_eeprom_append(ras_core, &data->bps[eeprom_record_num],
+					save_count);
+		if (ret) {
 			RAS_DEV_ERR(ras_core->dev, "Failed to save EEPROM table data!");
 			ret = -EIO;
 			goto exit;
-- 
2.34.1

