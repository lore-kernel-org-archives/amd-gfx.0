Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C4BC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CEE10E734;
	Mon, 27 Mar 2023 19:36:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A8310E728
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BljbWWgXYIG2zEemx7Xc41mgUuUZGVmq9sMWJNNvy2cjiKmbhHLg1OqeXHG2l7WhUcQdmt/8ydAvXwTC01/C3iyJeyk3T3Uz8OpT5iXCncWSrGBdYAGfyUl3Ht/C7jg3hiKGRRa9yKxSlR/n/qh4D8MSLJiiWRHTCbwc65+YiFMYTm+lBGEfBSRVtdc7dKMVOCj7aLOOd/Bz2Q1bCP3Hql/fedPlV4rADP02S38NjaGzQYcdS9SqMcI+zw3NKxN5avira2lmyxE4UUdhIcDNfvxiy7OjJqHTuDGghqy69GoJ/tJ1LCZd/QLwsINgVqPka/FnHQtIrzqL4F9uBNETgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgmRFav4SWeFi0ke3FOL3/Nv+BDG0LOBnhmAepVZJPc=;
 b=k5oKNufaSpEbjXqyOp8MUnaMv8TKttP7BmLbBnw6O0cKhHpjPhVNAik2hb4XjaVDNHvg7vhYlYXh7a9emSfT9lbRm2YQ1t7heNbB2P0gHuCCy47jiRqcv0QAFCGqtn0umMlFX6lYuatWGt9Ah0LlDZyseDdjVTxTJCakUmC2d0nRLrJWoYLUUffe6uyxlzLqDK3clHJN3PrY9VThFJAAvPqWMNci/yQIJMzHV05JSk/h7GHFzkyq8Gz/SRHVttQlEWKvUFEKRqw7fQpyaeGuhnFONDAcWX8xhjo234XRnYCgyCHoo5vFZJI2nBRrxCBNxKoCioQx+m9seI1lRyxjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgmRFav4SWeFi0ke3FOL3/Nv+BDG0LOBnhmAepVZJPc=;
 b=BgpOYHs5pQ10bpwZPwwkot1CKxGppWEhpVn0eCW8v0BGjHZxp+WlMx1Ezqas9tMrPwNe+ciKGhsykiMSat8pVyP7OYN2he0VOfI2vdHxl1mc8Q8bJJW9id/MLbLlPivs8fJ85Kgh9AHgiYvayOvKbx8HwitaPJ6FKHA9tQqq0L0=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:40 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::88) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/28] drm/amdgpu/: add more macro to support offset variant
Date: Mon, 27 Mar 2023 15:36:02 -0400
Message-ID: <20230327193602.7901-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|BL1PR12MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: adcbb705-3b72-4581-74aa-08db2efa9657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsDKekheJn7QFiTuTqQiziENOyKdFGl1+c4TxVr44QGNfirrlfxQUw7GFNvnvcRfErT7wf1pEA7cfFsGVkdnX/caD+2i0aiaiSXTErLAHj5DFRajwkPT5FmfSUn+ynznqrc3mek6O5tknJ55EyAUXa24gHCiaiFxS8XKQnE0QQFIAZYr3OquOtZrESykxEDpt4oFQT91Vfy3T9XAaGeoWcWKisUK9mJoLgF7adG2jzuBkfMDMn5x7CuYSfcxYhPTqIa6XZdG5jgNXLqNGSRMP87CNSFs7cZaNDjYv2KQggEl0YLtstPFZh0nYFAS5hycO9D6GbnML9oVTx+CB3QvIlt3gk0zeYG5Lk/1gq5MqdQa88rIHBJDoiqcqnJl8WRQo6R0G6lCyF7ZBqFaJt4eDt9++LJcSWP99sbXRv6rYfvhdVdROaF1JzVhrnkFMpEfCHU1zYOocDl+UqA3fB+SX9Q/uoEwI+HqzKRn8SxNO7I+QsQbqD26ji2ZPCNT6QijaanMH/oItEfCmScIulmUfWbo/WmL6yfDyq5kZuIpdOC/Ey4I49m25mafY8QVYi3yVQdfH/SL0HyEAkctP1m1et4FrsOYMioxnZIhV+l1oB8duk1a5SqQAnAcRf+dhZOY0xhUxwfYPV63zOmjMFwoE7HgY1UnuIj+wvuRyC7ntoiRYZjM7CEEv3sQn6hddry4LQToLMLWDC65BH0kuvS4qlLCC0FgonEm0UTs2cgJEcw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(2616005)(47076005)(7696005)(82310400005)(83380400001)(356005)(40460700003)(86362001)(70586007)(26005)(1076003)(426003)(70206006)(6666004)(36860700001)(16526019)(186003)(41300700001)(8676002)(6916009)(478600001)(316002)(54906003)(336012)(36756003)(4326008)(5660300002)(2906002)(81166007)(8936002)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:40.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbb705-3b72-4581-74aa-08db2efa9657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Add more macro to support offset variant and
simplify macro SOC15_WAIT_ON_RREG.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 28 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 36 +++++++---------------
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bdc1190601d4..786b28821324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1103,6 +1103,9 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			       void *buf, size_t size, bool write);
+uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
+			    uint32_t inst, uint32_t reg_addr, char reg_name[],
+			    uint32_t expected_value, uint32_t mask);
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 			    uint32_t reg, uint32_t acc_flags);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 12dd2aa85b39..aa3c27b6035a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6059,3 +6059,31 @@ bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
 		return true;
 	}
 }
+
+uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
+		uint32_t inst, uint32_t reg_addr, char reg_name[],
+		uint32_t expected_value, uint32_t mask)
+{
+	uint32_t ret = 0;
+	uint32_t old_ = 0;
+	uint32_t tmp_ = RREG32(reg_addr);
+	uint32_t loop = adev->usec_timeout;
+
+	while ((tmp_ & (mask)) != (expected_value)) {
+		if (old_ != tmp_) {
+			loop = adev->usec_timeout;
+			old_ = tmp_;
+		} else
+			udelay(1);
+		tmp_ = RREG32(reg_addr);
+		loop--;
+		if (!loop) {
+			DRM_WARN("Register(%d) [%s] failed to reach value 0x%08x != 0x%08xn",
+				  inst, reg_name, (uint32_t)expected_value,
+				  (uint32_t)(tmp_ & (mask)));
+			ret = -ETIMEDOUT;
+			break;
+		}
+	}
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 3f6dac856d49..eb35096756b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -26,6 +26,8 @@
 
 /* Register Access Macros */
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+#define SOC15_REG_OFFSET1(ip, inst, reg, offset) \
+	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)+(offset))
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
 	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.rlcg_reg_access_supported) ? \
@@ -86,31 +88,15 @@
 	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
 			  value, 0, ip##_HWIP)
 
-#define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
-({	int ret = 0;						\
-	do {							\
-		uint32_t old_ = 0;				\
-		uint32_t tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
-		uint32_t loop = adev->usec_timeout;		\
-		ret = 0;					\
-		while ((tmp_ & (mask)) != (expected_value)) {	\
-			if (old_ != tmp_) {			\
-				loop = adev->usec_timeout;	\
-				old_ = tmp_;			\
-			} else					\
-				udelay(1);			\
-			tmp_ = RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg); \
-			loop--;					\
-			if (!loop) {				\
-				DRM_WARN("Register(%d) [%s] failed to reach value 0x%08x != 0x%08x\n", \
-					  inst, #reg, (unsigned)expected_value, (unsigned)(tmp_ & (mask))); \
-				ret = -ETIMEDOUT;		\
-				break;				\
-			}					\
-		}						\
-	} while (0);						\
-	ret;							\
-})
+#define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask)      \
+	amdgpu_device_wait_on_rreg(adev, inst,                       \
+	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg)), \
+	#reg, expected_value, mask)
+
+#define SOC15_WAIT_ON_RREG_OFFSET(ip, inst, reg, offset, expected_value, mask)  \
+	amdgpu_device_wait_on_rreg(adev, inst,                                  \
+	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg) + (offset)), \
+	#reg, expected_value, mask)
 
 #define WREG32_RLC(reg, value) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
-- 
2.39.2

