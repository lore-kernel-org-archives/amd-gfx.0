Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFACCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEE110E788;
	Wed, 29 Oct 2025 10:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWGnlt/2";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A4A10E788
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk+OErvvdbhfFbRLB37SjleQ+12SaxNcJd2jprVEZj+9pndojvs0jwvbnjSTauKI1Q8HYq+0akfFR+ufpEO6OcIOvstJVNnz2GgzyqUrVIxaJ3aL1QswLeDhdWyYcaEbWylpDwxhvQvDEofxm5Cq98iGFnDK8TtfSqGVNTnnn5DNnLtPrYSLRrZFdFP/StjBWPSQ7YInza/Da+XgfuvVMKw6bV6UIxnB4CdzR6G5uGy+xicgwZtFZSb8AUM2FpKZpV0dTluBRGw00Yrko1N91HG7HmAQ6+BQTJsU9YWudvd7iIqP8LzOB68x5+pHpmXRV8YfIG0HJ/lk8DddTqWLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQGjiRHRdxN8ssj4Hv3RReCHxT+S3YwIj/Dq9oKrHvM=;
 b=jsEJVRcXH4zGQZhM/QbB0GBFFKQi8rynKIliC+06HVf+LSv6TQY1ZzkC8pKLHC09GIuSem8BherHk+hK9e0YFeALwryXS5L7mOIjEq+k59sdcfKfBeTZfPnusabWZ+Zfp/eKpQrORITZbhsOPpm83Y2USR+IrZnHdOSJwDh34tB0RDAol5ld1ON2ZEbDd/GIUzyT8kMGo7GY0IKTd+Mi5O0JPoBR66FQCJoobR59yxXg5D7+xVR0pVitK2ThjCsnBsJTB+Q1TDU3cOQi2oZwMZnOKDKMMaXT+UQVaEbxEDXjD48/a4+ExsKbUqC1S6TXRMqDT/Q6I3K0QC7RA4B2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQGjiRHRdxN8ssj4Hv3RReCHxT+S3YwIj/Dq9oKrHvM=;
 b=BWGnlt/2rsPOrSKMXkRaj8e2AcTCklzeLuNHErpRqUhquCjzkMkn7fn0lRd+kP0fV3/U3kNUTc7LUgsV+8leui02Dur0aPmwbit5sKKTspnMcvMVnkxIADN0o6EiBDRiKtewObfMzLu9K+kx44prkq5RpLtYdd7LtL/PFdnFADI=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 10:38:20 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::92) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 10:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 10:38:20 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:38:19 -0700
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for PMFW
 manages eeprom
Date: Wed, 29 Oct 2025 18:38:02 +0800
Message-ID: <20251029103802.1402199-8-tao.zhou1@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cd924d-b074-4b1f-a4b9-08de16d74761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|30052699003|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3D8dscE7rknAdmGML3F2cTWrdQ6lq52G9reKPK+Md68UhydFtrZes+GfZnlR?=
 =?us-ascii?Q?cau4S8oDKR4aqB2i6F4Q2PmSyfRWu6/n2/bAsj2Xdu6mqlS0o1yyn8Iro16b?=
 =?us-ascii?Q?b+PlKoE/6duhcqaS8mXlUE3uSDCID6K2HCsnsKoauCIkTJeJHTvxwAZxWNfD?=
 =?us-ascii?Q?hCxiuJE935ZcljC1jxcbu1OMw0o/KmuygepHtjszUHA8SBjl+VjiOdeC2jId?=
 =?us-ascii?Q?UJBYZubCwjiFKH7agcr6wMijsWbYU2Nv3Ue/bsZUJ9ZbSeVzXc4zHpCd6ugm?=
 =?us-ascii?Q?Uh3yxahagRFg6ASXBF0FsbRi3fMw6hHRkrVFw6dpcF8KQhBbHeb0Yre4ge4S?=
 =?us-ascii?Q?Yz2LFxsgJp0K0+s1FS+tL+tL8zsQgzJE5fx6nqgCT6H+7RrA/qRtHHRDrqRc?=
 =?us-ascii?Q?tCCOpj7a7SgEvpEGxQrizf63rmXxzUH2ZbmiWhcpVcIKruC2FLXOfmO8k8Q+?=
 =?us-ascii?Q?j1/hXqlkfsj/b4JQM5BOLU8Flk2LlsP2zT7+775xUrNtPghKVAm+1Rdly74o?=
 =?us-ascii?Q?h+ttOg0WzDwjnr2zTqoqiPoxJcYUlYqXNkUTpOxzH5V2r53U+iPe/WnKhTjk?=
 =?us-ascii?Q?SW6ogz1MCnRtjlIGDONf2FSKir39uH/HVIYRm/Q4gF+KNKIRxEYe2AnC6wJX?=
 =?us-ascii?Q?b1YozWWn73qj9i0RN3qIlcBnXSdNXCMpjapBsETCLQsdxhrBbGHT9tADIGbT?=
 =?us-ascii?Q?wP+zI5QoUoVw4Gcv4dvv5cYQWPYlPEFsofAVbs6GvXn7Csb0lSsX3kSWXUgq?=
 =?us-ascii?Q?2Y/agOmyxNZ3N4nvopdEgNVDkNXMJ7zZZS2Ea3DkcDyjvO6f8e8RDbASbQpC?=
 =?us-ascii?Q?+FBeUwwZNVryLtDVyxyVF6h8pKCOy6FRfeJ12zYd8AWkevzfFyzsqMaFaX0j?=
 =?us-ascii?Q?xdJgMZK7kll/1xK3QLdH8GuwMy2cvIQmZrD7GQohBwzM7CENm+OjnnbndA5l?=
 =?us-ascii?Q?FijAeDgE6oJsBA7K2fTME3rtZHW4fxwKf9YP3zYbxPy5WL7Kxj9ai3hP/It2?=
 =?us-ascii?Q?RoEIeGPdQ16SJ4xQqpLFublV/rTXYGp05VbJ2n9uLo7R76tKl2yRcXGuqD+q?=
 =?us-ascii?Q?Of2itcyNjpA56/cyxeDf5ug0gMzmuCTvMNN47yzmB4mvztAFg7W2tPqdNofe?=
 =?us-ascii?Q?sSmQMQBZBTRPBU703q7PfbKdvqgJNJRzO8Xg35goqW9obuG/1mkdInGKP54O?=
 =?us-ascii?Q?1bD93TFRvnUj8uw97Bz99XPVxYTtDJaMt6+CmrF4JTj6vcZFT9RFvZ0es/V1?=
 =?us-ascii?Q?wl9EWyWiybcTIJqt/wVmPYvd8IKy/tZyXko3KikPoayu6AluNoemw6i+4kDG?=
 =?us-ascii?Q?8e/5MplS3VLfDL2W2DlnFZ0iJV1OF0l4h4PM5+Ds8JaK9t6DwvKJEOmoMRLz?=
 =?us-ascii?Q?fapyQD69tmjoiBMSTRD3gEzLcWodj3A08z+rc8TWd2u8jv++tvhNEp1EtOjh?=
 =?us-ascii?Q?2QqFzbtUtYyrwRTHikF2e/qBKsREzMyMeMgeGJtx6a8UYMyGZBFi7JN0l/cR?=
 =?us-ascii?Q?QAChhy1OxfmUsLtGNL6w12ALm9VWTvZBEavHY6rVzlprRrHbhLDbD99YnzGq?=
 =?us-ascii?Q?lQN5kL5RDPsmLA1hsco=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(30052699003)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:38:20.4136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cd924d-b074-4b1f-a4b9-08de16d74761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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

Check if bad page threshold is reached and take actions accordingly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index de7b268a9862..0acf45d5fc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -896,6 +896,36 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
+static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_bad_pages = con->bad_page_num;
+
+	if (amdgpu_bad_page_threshold != 0 &&
+	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
+		dev_warn(adev->dev,
+			"Saved bad pages %d reaches threshold value %d\n",
+			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
+
+		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+
+		if ((amdgpu_bad_page_threshold != -1) &&
+		    (amdgpu_bad_page_threshold != -2))
+			con->is_rma = true;
+
+		/* ignore the -ENOTSUPP return value */
+		amdgpu_dpm_send_rma_reason(adev);
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -914,17 +944,14 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev)) {
-		control->ras_num_bad_pages = con->bad_page_num;
-		return 0;
-	}
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_append(control);
 
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
-- 
2.34.1

