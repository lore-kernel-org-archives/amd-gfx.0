Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10C2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 05:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC2F6121F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 05:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC2F6121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318F56E037;
	Mon, 17 May 2021 05:54:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBBE6E037
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 05:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQidec1Ddt/30uYpv6C+VekBGUSano/2CboyVIqfyhiEeqE0nWEuBk88kXS1o+TSFW9rHJ+IbTpVkVROoOqeYGBVNn17IC96/t86dVZBFfYKuc7DAUPkLwIp2Pjxvd9x3DAgRZMrMIhEAgqjC5aboagxRd/963wdoxkPjAQhLC2NAn38ROFzRVjC3I/ebx2RYdkNxoc64sSbTDQUmJ1fqlSmT9S9WhlKk1FRkN4SBLk00WVQnI6822rTyXd42RbUKfk2KUahWkWXUNyVc97Vdce0L5HsQEmVHjfz1dByGw4ob3HAprQkcv43NYXFnCWuEDqnq5rn5T+YePQTr3VeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UnfkMjg5CXIihP/yYMNkweB67Dqh5topenH8gZn11k=;
 b=HQAlayCw4Sniv/UGZ4Q9NIT9TiqusCKmTQdGulAOrUlBuJCCLUvsCDB6X7t1kefyAFLs+mzJH0R2ygGwEGEYgy5V+ckdxOPZQ/rAbrKELDtG/GFIU9T9HyQWBR9Tv1HPSVEjjBGwcwhOp3RypVL0HkJEVGPQeSBMlvFot4Lq2Ai2hleccyZxvB9NxT/mljN9tGo7Aij3iBgqSzsRzoVHEHyTmXjneXARlQuxMIl79aAE3KEoLSm9ehMGdexcLOsl+Gt3ie+KRVoFqSzvYwCa45Ho5tlbI6+ja5Gkp2IE5yu3U0Z5+IH9ePnnSxoxjh1XP2lIVGxlIFxqwWr1TMkzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UnfkMjg5CXIihP/yYMNkweB67Dqh5topenH8gZn11k=;
 b=dRWGfdCvwkyRmMgQ68neiVHiF/qunVZH73eTVUpVlwDxVfIF94wKnn0MYSEVegXj7cXJEkYCOs8hyWZJ5eiNVWnZNq2HPfM5Lpyd1pwDDYGH6F2CrUv6AgKvNpuIml0nUCt+4rEK2D0sw1i+Uwua0UbgAyryNwYGlJyQn7fMIhw=
Received: from DM5PR07CA0107.namprd07.prod.outlook.com (2603:10b6:4:ae::36) by
 DM6PR12MB2650.namprd12.prod.outlook.com (2603:10b6:5:4a::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 05:54:31 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::c4) by DM5PR07CA0107.outlook.office365.com
 (2603:10b6:4:ae::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Mon, 17 May 2021 05:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 05:54:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 00:54:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 00:54:30 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 00:54:29 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Expose rfc4122 compliant UUID
Date: Mon, 17 May 2021 13:54:13 +0800
Message-ID: <20210517055413.28417-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d55d9ab-d463-4471-a632-08d918f83dc1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2650:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26507859A6248ECD6EC7D96BF82D9@DM6PR12MB2650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhmwSkSu0rKPjmSimFsuEyq+aeVHrDj7Mjg6M4VBXK3Mb+geC15TpguoQK4dbceK9d2vNWUkYBMPIxZOsPfGZi/8240wwILHA9LG+1WBGTvgOvXFDFVjoBrZHvwlTTlRg3ORmXA7tZEkN5dzTrB92jrpj7w8MQZTVD66rOmlP0Ao3VG0yVtp+VgXIPqq/AwSQ/xJOoGk2CEE/LgT6PK4hbkPUofbPo5LE1zKZ1plnn9fXQfDZ8gT49F6UDqtn7xgZV9VeJkzsyZTnflBP3u7VWGnu+dR/acgn9ieg2H7ve9eupNzxDPe68aFS1rIzj8QduRLPKHHJuIWsIwnbRrFfzJx96nQO6WMSsire2GQgxfH9w3HLr1aH8VaWiLF9yVXpJ9qX/YugYpOMK5Hh6fbv1bjCIWVnXoV6moWuAOrRepxYHPojYkARCJpg5tp2mnRcq4C1zoioKVXeuattnjGA0LJXcDBkkE6FiTQ2otBkCiMYy83yLQM7Gaonn6aJJlGP4vUxyCOlVw/3nINAiuDzOu049u7MMdgdmztQMxK77OZCtcvPobZ4jqnQJ9XJAZkAdURwvElnsJo/EDx5+0ohQCnS6oAXiJTUnnqSbKLWE17Wer/IZcrdqoS3mlpwwF0/Nj+u9dKpo+pu8dErIrCiIvvi9SE1/1Ry9ne7aw14v29IOadAUr4gl9z56JR+Hm3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(81166007)(54906003)(478600001)(47076005)(82310400003)(356005)(36756003)(82740400003)(70206006)(70586007)(6916009)(8676002)(8936002)(36860700001)(2906002)(83380400001)(426003)(2616005)(4326008)(1076003)(336012)(5660300002)(186003)(316002)(26005)(86362001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 05:54:31.5703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d55d9ab-d463-4471-a632-08d918f83dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
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
Cc: emily.deng@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>, david.nieto@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce an RFC 4122 compliant UUID for the GPUs derived
from the unique GPU serial number (from Vega10) on gpus.
Where this serial number is not available, use a compliant
random UUID.

For virtualization, the unique ID is passed by the host driver
in the PF2VF structure.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 36 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c             |  5 ++
 drivers/gpu/drm/amd/amdgpu/nv.h             |  3 +
 6 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3147c1c935c8..ad6d4b55be6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -802,6 +802,40 @@ struct amd_powerplay {
 					  (rid == 0x01) || \
 					  (rid == 0x10))))
 
+union amdgpu_uuid_info {
+	struct {
+		union {
+			struct {
+				uint32_t did	: 16;
+				uint32_t fcn	: 8;
+				uint32_t asic_7 : 8;
+			};
+			uint32_t time_low;
+		};
+
+		struct {
+			uint32_t time_mid  : 16;
+			uint32_t time_high : 12;
+			uint32_t version   : 4;
+		};
+
+		struct {
+			struct {
+				uint8_t clk_seq_hi : 6;
+				uint8_t variant    : 2;
+			};
+			union {
+				uint8_t clk_seq_low;
+				uint8_t asic_6;
+			};
+			uint16_t asic_4;
+		};
+
+		uint32_t asic_0;
+	};
+	char as_char[16];
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 struct amdgpu_device {
@@ -1074,6 +1108,8 @@ struct amdgpu_device {
 	char				product_name[32];
 	char				serial[20];
 
+	union amdgpu_uuid_info uuid_info;
+
 	struct amdgpu_autodump		autodump;
 
 	atomic_t			throttling_logging_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7c6c435e5d02..079841e1cb52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -37,6 +37,7 @@
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/efi.h>
+#include <linux/uuid.h>
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_i2c.h"
@@ -3239,11 +3240,104 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	return ret;
 }
 
+static bool amdgpu_is_uuid_info_empty(union amdgpu_uuid_info *uuid_info)
+{
+	return (uuid_info->time_low    == 0 &&
+			uuid_info->time_mid    == 0 &&
+			uuid_info->time_high   == 0 &&
+			uuid_info->version     == 0 &&
+			uuid_info->clk_seq_hi  == 0 &&
+			uuid_info->variant     == 0 &&
+			uuid_info->clk_seq_low == 0 &&
+			uuid_info->asic_4      == 0 &&
+			uuid_info->asic_0      == 0);
+}
+
+static void amdgpu_gen_uuid_info(union amdgpu_uuid_info *uuid_info,
+				uint64_t serial, uint16_t did, uint8_t idx)
+{
+	uint16_t clk_seq = 0;
+
+	/* Step1: insert clk_seq */
+	uuid_info->clk_seq_low = (uint8_t)clk_seq;
+	uuid_info->clk_seq_hi  = (uint8_t)(clk_seq >> 8) & 0x3F;
+
+	/* Step2: insert did */
+	uuid_info->did = did;
+
+	/* Step3: insert vf idx */
+	uuid_info->fcn = idx;
+
+	/* Step4: insert serial */
+	uuid_info->asic_0 = (uint32_t)serial;
+	uuid_info->asic_4 = (uint16_t)(serial >> 4 * 8) & 0xFFFF;
+	uuid_info->asic_6 = (uint8_t)(serial >> 6 * 8) & 0xFF;
+	uuid_info->asic_7 = (uint8_t)(serial >> 7 * 8) & 0xFF;
+
+	/* Step5: insert version */
+	uuid_info->version = 1;
+	/* Step6: insert variant */
+	uuid_info->variant = 2;
+}
+
+/* byte reverse random uuid */
+static void amdgpu_gen_uuid_random(union amdgpu_uuid_info *uuid_info)
+{
+	char b0, b1;
+	int i;
+
+	generate_random_uuid(uuid_info->as_char);
+	for (i = 0; i < 8; i++) {
+		b0 = uuid_info->as_char[i];
+		b1 = uuid_info->as_char[16-i];
+		uuid_info->as_char[16-i] = b0;
+		uuid_info->as_char[i] = b1;
+	}
+}
+
+/**
+ *
+ * The amdgpu driver provides a sysfs API for providing uuid data.
+ * The file uuid_info is used for this, and returns string of amdgpu uuid.
+ */
+static ssize_t amdgpu_get_uuid_info(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);//ddev->dev_private;
+	union amdgpu_uuid_info *uuid = &adev->uuid_info;
+
+	return sysfs_emit(buf,
+					"%08x-%04x-%x%03x-%02x%02x-%04x%08x\n",
+					uuid->time_low,
+					uuid->time_mid,
+					uuid->version,
+					uuid->time_high,
+					uuid->clk_seq_hi |
+					uuid->variant << 6,
+					uuid->clk_seq_low,
+					uuid->asic_4,
+					uuid->asic_0);
+}
+static DEVICE_ATTR(uuid_info, S_IRUGO, amdgpu_get_uuid_info, NULL);
+
+static void amdgpu_uuid_init(struct amdgpu_device *adev)
+{
+	if (amdgpu_is_uuid_info_empty(&adev->uuid_info)) {
+		if (adev->unique_id)
+			amdgpu_gen_uuid_info(&adev->uuid_info, adev->unique_id, adev->pdev->device, 31);
+		else
+			amdgpu_gen_uuid_random(&adev->uuid_info);
+	}
+}
+
 static const struct attribute *amdgpu_dev_attributes[] = {
 	&dev_attr_product_name.attr,
 	&dev_attr_product_number.attr,
 	&dev_attr_serial_number.attr,
 	&dev_attr_pcie_replay_count.attr,
+	&dev_attr_uuid_info.attr,
 	NULL
 };
 
@@ -3551,6 +3645,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_fbdev_init(adev);
 
+	amdgpu_uuid_init(adev);
+
 	r = amdgpu_pm_sysfs_init(adev);
 	if (r) {
 		adev->pm_sysfs_en = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index b71dd1deeb2d..2dfebfe38079 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -429,6 +429,7 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_pf2vf_info_header *pf2vf_info = adev->virt.fw_reserve.p_pf2vf;
+	union amdgpu_uuid_info *uuid = &adev->uuid_info;
 	uint32_t checksum;
 	uint32_t checkval;
 
@@ -498,6 +499,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 
 		adev->unique_id =
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
+
+		memcpy(uuid, &((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid_info_reserved,
+			sizeof(union amdgpu_uuid_info));
 		break;
 	default:
 		DRM_ERROR("invalid pf2vf version\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index a434c71fde8e..0d1d36e82aeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -203,9 +203,9 @@ struct amd_sriov_msg_pf2vf_info {
 		uint32_t encode_max_frame_pixels;
 	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
 	/* UUID info */
-	struct amd_sriov_msg_uuid_info uuid_info;
+	uint32_t uuid_info_reserved[4];
 	/* reserved */
-	uint32_t reserved[256 - 47];
+	uint32_t reserved[256-47];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 32c34470404c..16d4a480f4c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1167,6 +1167,11 @@ static int nv_common_early_init(void *handle)
 		if (amdgpu_sriov_vf(adev))
 			adev->rev_id = 0;
 		adev->external_rev_id = adev->rev_id + 0xa;
+		if (!amdgpu_sriov_vf(adev)) {
+			adev->unique_id = RREG32(mmFUSE_DATA_730);
+			adev->unique_id <<= 32;
+			adev->unique_id |= RREG32(mmFUSE_DATA_729);
+		}
 		break;
 	case CHIP_SIENNA_CICHLID:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 515d67bf249f..520ac2b98744 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -26,6 +26,9 @@
 
 #include "nbio_v2_3.h"
 
+#define mmFUSE_DATA_729 (0x176D9)
+#define mmFUSE_DATA_730 (0x176DA)
+
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
