Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0798CD2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 06:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F24110E4C4;
	Tue, 20 Jan 2026 06:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HxFzL8+G";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 853A610E256
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8egwBGbyUlooeIMWh8v1bTq6d7soqM5zICKBzB1q7bhjfrjf2xX+lc31RCrh6nsptw8bpS27HnWBdDh3lEZUXgyxWukfWJ1W9qgiWOIUPo1gWvCbBePSrsupLFlN0HeMtYKKk0hxEd+AW1+bJedyV0qGLm8EqYD7qJtBIH8NJF50XbAr0eZc+o+pWo8LmaD6WRua3uZqxLf5OJog62ewbbz1jkJIabwoJYif3tkp6clv7BA1Ky7bDMNY8MMRWOBTJVH5f60yIOI9xLjyFBjFIEPHSLLXxmkX8pxIoUosj3ZoEW3TurrilwdFXYhYZvTZxxEwtPm0DMoBaDqXnmffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BU7n7gTx3+yP/d9yxqOzvZnMWuTNS1U0Ob+3DGo7h0E=;
 b=OFlQ4Nvpf1LDXVINwAAX5lZilQlPCTC7lipWZx6qRD+Vpac9HV4rt2WzpaJxTb/TCCoNVqORC0ZlwMmr+CKxNC7yZ8Oe2AigZfq0ewo6J36ZZ81ECUwL7+LBnYAs210CNx/R2OtO7VXEcYIt3tyHdASfUscZKGyB/PgQpvzhhiGETHyZeSFM6SLtVLTwI1/r+1xpvMenBTqinMED15LGRvZkwt2etaBJr52NoEHlgXZWYXe6M30VSU9/bcgQe6KSnzeRkB2drQNHJJJRiU1qSyh6skIMLD3FZvq48LsgTAv51yoqn55hKOoQmzIfXz0VR3qo6CdtDR8Vsqsb9kP/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU7n7gTx3+yP/d9yxqOzvZnMWuTNS1U0Ob+3DGo7h0E=;
 b=HxFzL8+GFgFPRHPjnhxlSL8akgoMpwitJBq7J0AAQTXxk29SFvTKFXAv3cAZrS365lBKYSWV8r7ysmXLap79rbaGOIyvZl+7fYvTQbSct4MVtzD4741FmRnWQ1GAXwd169Uj2C1PSxyDdLdyneh+0LtQXLqbxhyY4GRtOamT1+0=
Received: from CY8PR10CA0033.namprd10.prod.outlook.com (2603:10b6:930:4b::28)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 06:14:26 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::c1) by CY8PR10CA0033.outlook.office365.com
 (2603:10b6:930:4b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 06:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 06:14:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 00:14:24 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 1/7] drm/amd/pm: Add smu feature bits data struct
Date: Tue, 20 Jan 2026 11:42:18 +0530
Message-ID: <20260120061402.1287680-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120061402.1287680-1-lijo.lazar@amd.com>
References: <20260120061402.1287680-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: c8709a9b-0013-464d-7670-08de57eb29b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DodcwtPJxUZjBpWHu9skxr91XbQ+Zmjlsn51TxcGnY/OrkRiGE2LdXCictzu?=
 =?us-ascii?Q?fuJ7FYtbGMPdwmSF/yQ+xQxNPgigh6s+px65kj7649RTun3rGx7MlmIYZ/Uu?=
 =?us-ascii?Q?iqM1RR5l6YzUlRVaAhjuMdp4/rTdTmZmS62zbNbbsfgjhNvs45ww0mfdr8cH?=
 =?us-ascii?Q?2BL4MI038+uow07OA3kIwTU7hOMAmZwZTnQnqQyXQ1oEl2PCmh1L7z8WG++i?=
 =?us-ascii?Q?2n7BZopvHF4bbVcKMW76Td6ppAcJGjPLbwGEIReJsBk4Dh1C59EUC6EjUlBL?=
 =?us-ascii?Q?R4vKGi5JaAKeim88dVxbmDvNrZBX4B5I+dqvpVdBK64ocU1r1QWp4W1WeQrZ?=
 =?us-ascii?Q?PHlS3PhVsLxtUVpRYhBgwTPwYLKdwYq27C8YTDGFusixmZdsqLpexi1pSwgw?=
 =?us-ascii?Q?T1Bkx2hPjthnpxmv3FzGEApZ67rd6QrkDl7CMxEz5HbpxQJC1lOY2xWPwUD6?=
 =?us-ascii?Q?cXrD1fXmeMpAXVyIXLA4XjX51Srce5wiQydlNUrvZvmC5U4d5FE+vXbABe5f?=
 =?us-ascii?Q?3wTj55Sk0Y9NbISyiWgMsOKhZEDtQWyV+cjzQOzFleLevHB/XCmsFSris0xH?=
 =?us-ascii?Q?NrK37+Xz6GPQZN1K3KYUdmo34gvOUBBD8jc0/B8LuMKj9b0LrGmuLTgf9I0D?=
 =?us-ascii?Q?Vhi7qDif8tsLprTA/qTQnjfsKX/asUAKGWFHM5wiXoJ3644HucP3D8fs0mlq?=
 =?us-ascii?Q?5iLMBXv22XLTklmHYn8JYxZJ+bHlH2PNYjnm7L4nc2NUaC44OrLK6kDeeNhH?=
 =?us-ascii?Q?Ifww7VgB374lYSVyhMr5H+LB63lWJwY9z8fwBfFR//CPT8jLh666bRsqiuzO?=
 =?us-ascii?Q?TL3z9YwdOV6SBzOz6jXA2mN6fW/oZuz+243Y0nYOMZ/g/hyC9EzzfOFH8lus?=
 =?us-ascii?Q?JycZ1+IhADwY6UAVvqIK/wrPuCdh1ofoIaZ58ir+PXRtBJUSGOYcRKTt6RqQ?=
 =?us-ascii?Q?zd2ZKk6GCniCj6/vgKgsK3AqvjQ6ghE0T466AMvKrrwZ2UkHLqgtz4Ho9Pev?=
 =?us-ascii?Q?gAwNCPs4qN8mCw0/D7s3pM5FrMXP86SvzXiOMnxU/ZMFSPPcFw8cI8vIqJsD?=
 =?us-ascii?Q?2eJOLTwRp6jcHv4wjPigS5IeEb/2jRKJsoEIPA5T7cY461DWHJVAZutL3FQc?=
 =?us-ascii?Q?vVMh32I/wIJMrxdqyZCStOUNWB3LK2v4uHIdkE0PCDvU523N1c3ZJRb2SeN4?=
 =?us-ascii?Q?5k4Gu8z6ev1V4eraRSHR5xK8ne1yPqmVPWIwP28q//cOUFeUlU3P4dwbqvbn?=
 =?us-ascii?Q?QC8iO4a8C+jhd9SJ1wSEWh9ecs9ReD7hn9fkHzKG8JeqJOtiD3CcuGEYB8sx?=
 =?us-ascii?Q?7XzSGcPCxlGKQhzL3SyvjgyZlI/klzoEBX8NP3LsvyTU4gsg2e2AFTho2e1Z?=
 =?us-ascii?Q?jnDYEvoM+PQ32Uo+SfJu1PnBMuSJ5H+SpsMIxMd57wy1tpDtL4mInjuwIVwO?=
 =?us-ascii?Q?mAT+AcYCZlkvStH1izKZL2BKiHTnn+hE/kF93D+vWFCZmbIQff/w8tx/UZ1W?=
 =?us-ascii?Q?Qaj4jeGrVlatTC9qKkXLRXYIn3sdsvYm3b/tuSqFdKvnYv+B2Uz9Q4PSeB+Y?=
 =?us-ascii?Q?W5su6c9YhUrOO0refU5mAstqOEVg/FCAfb/WgSiMI1X5NNdKCqksU4OXNTbW?=
 =?us-ascii?Q?SNcSWoFn9oom1ZALMRaN6+mWryTHniJxbZdT0gQkxBwe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 06:14:26.1082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8709a9b-0013-464d-7670-08de57eb29b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

