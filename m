Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DCD29C36
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 15:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE09710E4A0;
	Mon, 19 Jan 2026 15:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r185a5ya";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7046D10E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 15:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICzE1Er38m5CpIu2+wiHxDeisl0GqduLa8y9diJsC+8IOAe3vulciItiqBxtg9sCmaWTk3Ij6DTX6ASEJYjmTTGvkfy8vceO4vbLU6H/fsOZDhcgEZSlaCjB2PLc3egVEUxknRTCYALhj7cwrRbhevvf39ngpj+M5BUajo+C5Ie7TGLhQlcL6OXcxJvRcxYqW8DkIrHbgxJGjr7XJvQl0HtbnkkNlwPtkc/7+C0gHH4bclv9gXDYXcS77D2+qzuWnxrYTd5lQRpp2uAWu7wZTVs+kIbABZhhLyRRbXml6upPkO0EjEnUiZi0q0UtRZEwEW+7UebAswucYu4qglJFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU7n7gTx3+yP/d9yxqOzvZnMWuTNS1U0Ob+3DGo7h0E=;
 b=ACF+3rDWKQXwpAPK0Gb74D+i+umAp07lnBvqS9VT8B/sBKSqC0ysQHVxV5sJZADYgIbguZerceMkzAQ7DU1+vKIrtsyNURKlU5jaiQKGxaQqWtZF6Wf2uNUaAafikMokitB++u8TPsgffiDPNe9RQT8Z7EACmPQwJYWEMX1afpttrbQY5FvxqNAIrQqdBEmp8L9U9GQfZgdB7fMa3t8neYn+ZTRZMyqCIG7Fq7AlyqYu0eZhm26Hiu3c0FsnHMPoObOg60IuHhWiu9M3Kjs83pIqazDs9Vv2KA3WrH5ZGC0lnZdnNrJgQPCG2JbEEwlP4BQ6RzTwbVt8Eag4wzqycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU7n7gTx3+yP/d9yxqOzvZnMWuTNS1U0Ob+3DGo7h0E=;
 b=r185a5yaoaUo8cGECvDMZzBQ+cfRl/FJvFf9xf+aXvRShDXP9VLWlt+5l0FiNz+XbURcx2d0dasKMEIP6AQXEd8fxk3dTb2DzcH1qCl2AVDapEtSu5+uPdb1OC6mFHFBvKajyyUyctIccEop9w4q16EjR5omre9a1zHkT5RcrNo=
Received: from MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 15:33:39 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::df) by MN2PR20CA0059.outlook.office365.com
 (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 15:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 15:33:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 09:33:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/7] drm/amd/pm: Add smu feature bits data struct
Date: Mon, 19 Jan 2026 20:58:18 +0530
Message-ID: <20260119153309.1234663-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260119153309.1234663-1-lijo.lazar@amd.com>
References: <20260119153309.1234663-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ac1b79-f8ca-4732-b69b-08de57701ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wjbCOxVC3W5VO+Z5n9M1Sb6ajXxSyWXEELZaz+lV5Otr8obeTw3+B7Ni1LT+?=
 =?us-ascii?Q?tFwC3XvexDIBGJOA1d0sKhCU4Xr7zLu1kk9qS2folw44OeoGG2blZ7HY4sq4?=
 =?us-ascii?Q?4iLtdvYck1Kb9wu3n205ieJxMlUGd3PVoiCVT5LWUHD81GAUnaUShy2fiMIT?=
 =?us-ascii?Q?xs12k/NT3VkvjA04dmjonF2MYBmcn+NVnKFVaTOJ9jA5ounz6fR18B4YALcM?=
 =?us-ascii?Q?XFOE8ohjx+M46FC57TG/c7PN7rSi8z4mA951hCxc0ibbZuMStJx7zN6cL5+Z?=
 =?us-ascii?Q?DjBUr9OmThb2pPYaTQn8F5XtaI1zj864hLWRgpBo2UQfW6JB45gAoqSBNTVV?=
 =?us-ascii?Q?NWwTiZyxdTSBW4OFFmRyX0sb7LBA7D9FL3GFnYJtPiqMj8VjTlfX/pIREG4X?=
 =?us-ascii?Q?KF9tvBksrAofV3Cou1Uog9lIHj/KFD/0iK0FrYwKH/aS/Rp5tYQotgVz7Vv1?=
 =?us-ascii?Q?Pz+AfcMwFfQH5XIXotOTEDewwgyNx+EOUp5WJDxFdkPsbYpLGlND8o3U9pR2?=
 =?us-ascii?Q?owUAkhcjtJ/xUZLpBW6N+OK35LLHJjOVN8rlHAcQmIZA0QKKxzB4tJnMQcm8?=
 =?us-ascii?Q?rbBeikU4bWq4snrK76j/qXNhigzWEMxlqm+kJuS8VymiVebuPZ8FdQDPdVgl?=
 =?us-ascii?Q?7zxJ2dXwcUtof/yp+2leISU4j9XP1KYbtbsYCMc/tjWqfeV6WW7WpQ+SiP0i?=
 =?us-ascii?Q?d+KHKfDEcZ6toSg6/v+aWS9Gge8VbUvYyD/sh2N7jLrUlt3efyMT0l2aGnZ1?=
 =?us-ascii?Q?sxy4DUFHz7JYvdXwI37prG0d/2yrho6pJwatIniIHln5jWUcj2N3978uvCMT?=
 =?us-ascii?Q?dxbl7MDAJQ+BgPf82GEBukoe9WQDUIe6sSuLYOeRkp4fNEzv21u3faJUpmuL?=
 =?us-ascii?Q?VDMu42UZprphA8hTRdWgltRea6vWDpoklKnJ4Q8HIf+IEx5HwkVQjaCJp12p?=
 =?us-ascii?Q?49jKYMsmC457PmiDILuz3q0sg8PwGKPBLsCuZCyjP9m4CRe3bzwCvcFReOGO?=
 =?us-ascii?Q?xGgJhmXB71aD6d/egfrMUEYvkrGnM9pKqztMf/mRzB3+5wXIov4nV51y16mX?=
 =?us-ascii?Q?/2LgBQC44wqNO04YJPCzuLmci5d3AemOmbNOkry3OBLfbxGvWieOSfOX11HR?=
 =?us-ascii?Q?yWtQy4MGyf8sOAvpRZCA3aaP6MZISk9TkmgosDLOJm6JZTCHGoyelTi4DXrl?=
 =?us-ascii?Q?+u0JWzGqPctXqXMguS1dlNXWSX+wqV6QOcsC6wWbm4BtXdA+dijZDvHQx+Pw?=
 =?us-ascii?Q?YHPYA4hJ2qc1xQNvs5fZD047eEESpQ4eQScOb02KE3wQHBH2BvYyHBLsFRBS?=
 =?us-ascii?Q?YfYmx/ejjfLbVVW3q2UHxCWUcNv5Qd6RXFhCxYvJoR/ZsTSR6/dJkbvQYkSc?=
 =?us-ascii?Q?wjMT+g+yJ9CTGsTnQp7LXPcz+mZoyOG9M6tFQSuTf2rO8FuyekV+2kadSbKk?=
 =?us-ascii?Q?HaYuTKhmi241gGo+gPuPpwSmAeBwX38EhXc4SJCvvFec743mm5WH1P3dj3Mu?=
 =?us-ascii?Q?S1DD5vbIwkNzRY2yX8FDGyPi6k1JUam4lGJg9wqgK4iCxjeh0AbAtt/bTrr/?=
 =?us-ascii?Q?b1n45aqC3vJaNLQHphbJ0ZgPqP1978RcwgWxzJed45qqQlIl4J6+fuDgXSNm?=
 =?us-ascii?Q?izONh54Ggg6pfhG5Pkg4QjVEqM/vcW0uEsr6XV64k60M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 15:33:36.1586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ac1b79-f8ca-4732-b69b-08de57701ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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

Add a bitmap struct to represent smu feature bits and functions to set/clear features.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1def04826f10..017df903a7bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -472,6 +472,11 @@ struct smu_power_context {
 };
 
 #define SMU_FEATURE_MAX	(64)
+
+struct smu_feature_bits {
+	DECLARE_BITMAP(bits, SMU_FEATURE_MAX);
+};
+
 struct smu_feature {
 	uint32_t feature_num;
 	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
@@ -1974,4 +1979,80 @@ int amdgpu_smu_ras_send_msg(struct amdgpu_device *adev, enum smu_message_type ms
 
 void smu_feature_cap_set(struct smu_context *smu, enum smu_feature_cap_id fea_id);
 bool smu_feature_cap_test(struct smu_context *smu, enum smu_feature_cap_id fea_id);
+
+static inline bool smu_feature_bits_is_set(const struct smu_feature_bits *bits,
+					   unsigned int bit)
+{
+	if (bit >= SMU_FEATURE_MAX)
+		return false;
+
+	return test_bit(bit, bits->bits);
+}
+
+static inline void smu_feature_bits_set_bit(struct smu_feature_bits *bits,
+					    unsigned int bit)
+{
+	if (bit < SMU_FEATURE_MAX)
+		__set_bit(bit, bits->bits);
+}
+
+static inline void smu_feature_bits_clear_bit(struct smu_feature_bits *bits,
+					      unsigned int bit)
+{
+	if (bit < SMU_FEATURE_MAX)
+		__clear_bit(bit, bits->bits);
+}
+
+static inline void smu_feature_bits_clearall(struct smu_feature_bits *bits)
+{
+	bitmap_zero(bits->bits, SMU_FEATURE_MAX);
+}
+
+static inline void smu_feature_bits_fill(struct smu_feature_bits *bits)
+{
+	bitmap_fill(bits->bits, SMU_FEATURE_MAX);
+}
+
+static inline bool
+smu_feature_bits_test_mask(const struct smu_feature_bits *bits,
+			   const unsigned long *mask)
+{
+	return bitmap_intersects(bits->bits, mask, SMU_FEATURE_MAX);
+}
+
+static inline void smu_feature_bits_from_arr32(struct smu_feature_bits *bits,
+					       const uint32_t *arr,
+					       unsigned int nbits)
+{
+	bitmap_from_arr32(bits->bits, arr, nbits);
+}
+
+static inline void
+smu_feature_bits_to_arr32(const struct smu_feature_bits *bits, uint32_t *arr,
+			  unsigned int nbits)
+{
+	bitmap_to_arr32(arr, bits->bits, nbits);
+}
+
+static inline bool smu_feature_bits_empty(const struct smu_feature_bits *bits,
+					  unsigned int nbits)
+{
+	return bitmap_empty(bits->bits, nbits);
+}
+
+static inline void smu_feature_bits_copy(struct smu_feature_bits *dst,
+					 const unsigned long *src,
+					 unsigned int nbits)
+{
+	bitmap_copy(dst->bits, src, nbits);
+}
+
+static inline void smu_feature_bits_or(struct smu_feature_bits *dst,
+				       const struct smu_feature_bits *src1,
+				       const unsigned long *src2,
+				       unsigned int nbits)
+{
+	bitmap_or(dst->bits, src1->bits, src2, nbits);
+}
+
 #endif
-- 
2.49.0

