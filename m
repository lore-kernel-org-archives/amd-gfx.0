Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD050C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71394613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71394613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E3C6EE22;
	Fri, 14 May 2021 07:27:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2856A6EE23
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQv+NK6zlVxq9EZOtIztX/Tg6VplOMc04SHixynq5dmGp8GCT1uN2Cl5Qe4XYzXUVsyZaWMWmVnuv9Oa3ioAXN7Bfa/TghESoTTv44SuJv92oItDk6Ly0QqYGaECGoYDUMDiLIZREp/CR/cehuk+7PyrwasPAYFWvwFkVtDiDC27O3mFHUsPT/UQ1hh+Sc+ymZCwTwuJe99zIGGj9+32Tz+O7+TFJnWVbyY5QrY422DeTfUmvLUk8bK0DBrCZQOhSIUqaWRtUwhrdRXpgiV+QFE9f4/LBv/8bmFzfliAtN43SALHPQW21QJgU/373y/8GUpcLvmZpVBHQxLPhlXhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDR+4e+iBivYx89UKTEFkAmUee/bcDGWNIRbg9f9a2k=;
 b=TQWJOaML2zPvE869llC11n0mQtJh15oII35rfAejswfmUfZEcIZeBHFcCzvRNPXq6l+vcVcZPB04hG39Tz3wclUAPi5faRPPYf4VcmNrUlQPLhxz9ZaHxyGJB5O3uFe83cz05Bgps01SJs42l7pGsx+MUKVkFcI8bB5rn5Hoi59ocTZ97prxZjoQtXAaAPDxMMod2wKXhdat+D5j27Kwn2SgDmQd0CzLNVabCAgCnzEOpWDyneo0Nq5Mhk3aTcoxRZNLxffch+gFKY+orCO+PeXkMwq4EeZr9GEuR8BKZ7wPA/22AC/6XHNaDhGi50tihrkw7epVHq8wbiDEHD/kWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDR+4e+iBivYx89UKTEFkAmUee/bcDGWNIRbg9f9a2k=;
 b=rUN0t9sRV9H0RVnQLFmBGmv0UsNLG4rbLZMPrIc5Eorzzp4mujXyaV+VpKGGSg6bhARF7ffuIWnHIUQHkaJgecE+gSwvdk5d6lIJKd1KmI1LE73PUwkaClQSd94fMmzAk2vpOhpv4pafXcmPvCZo1x8Kig8tHKkjj5Bpe9Cv1Qw=
Received: from DM5PR1101CA0022.namprd11.prod.outlook.com (2603:10b6:4:4c::32)
 by CY4PR12MB1495.namprd12.prod.outlook.com (2603:10b6:910:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Fri, 14 May
 2021 07:27:22 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::14) by DM5PR1101CA0022.outlook.office365.com
 (2603:10b6:4:4c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 14 May 2021 07:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:15 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:14 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 02/16] drm/amdgpu: Indirect register access for Navi12
 sriov - SOC15 macro
Date: Fri, 14 May 2021 15:26:52 +0800
Message-ID: <20210514072706.4264-2-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 699ce68c-cc37-445d-70ae-08d916a9b69e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:
X-Microsoft-Antispam-PRVS: <CY4PR12MB149551DA053095C881F0F666F8509@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS/p8sO/lxkdUNcN/A7CT25kqewNYknrq/J8ot1PI5kXDIYRTdjBuJ3Ye5ul672vwr5k0ejU0fljfPALZ7zmoE/ZYeLdX9CTyQWw7Bj620MV+GHLbR+rc3eKMGZGRq/KjjBCnvMJeHzilwsYdavmiK5BjpHfJ8VofyjISeW6tNo175kUMr8fCwwZ9/ybJpGECUK9QfXFjCaX6NfriuJa1F0wLonOEkCywMXzZaw8TH5rNgvY88ZHbBI4gZaMl91gNNVNbqf7CVqR+ECvkLHPC/vcg2H04fcNkhN40sHz5DtNMGvOlHFXGUe1x//kp3w7Xyx1mhm12Li9CagmE+vxWR2guvVEJVaiFEOlgBWbHa9n6WYyzVkXYL3WaolLf9bbkoCeJlflMU3JCQln8EJd+D5XXCishhfDTms9MBo0zyctDtUEdn0bX80joBx29UGJQfgl+wfukW5qLEM9dfJNbZ1lB0+K8q0/7RsPlfPPwf6qUi54miPniN3bNmb/d69cd+Grgijb9NSeL11evbFDkLmMs3u44/cfmgR5Hb6xNdEXH8c0LZZAfkHOsqHfRHHB0MJJk0pLzxM/sxFCxGqxgFIH64U0gXCi2VSRGHctGUZ+3Rnj8KYmhvkFM5JaXe7rve30csuqiC1PVeS0tv8mkEZH2fMMB7WNqynaUqk1DN/Ji/oAjesdEeB3fOwRW1tT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(2906002)(36860700001)(6666004)(316002)(26005)(36756003)(186003)(7696005)(70586007)(70206006)(1076003)(336012)(4326008)(8676002)(83380400001)(86362001)(6916009)(82310400003)(2616005)(5660300002)(478600001)(426003)(47076005)(82740400003)(8936002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:21.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699ce68c-cc37-445d-70ae-08d916a9b69e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change RLCG/SOC15 register access interface to triage
GC/MMHUB access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 31 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 9b18e19f4c73..1c4262dc94e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -38,27 +38,40 @@
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
-	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg)	\
-	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
+	 __WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
+				(__RREG32_SOC15_RLC__( \
+					adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
+					0, ip##_HWIP) & \
+				~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field), \
+			      0, ip##_HWIP)
 
 #define RREG32_SOC15(ip, inst, reg) \
-	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			 0, ip##_HWIP)
+
+#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
 
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
-	RREG32_NO_KIQ(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
 
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
-	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset)
+	 __RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, 0, ip##_HWIP)
 
 #define WREG32_SOC15(ip, inst, reg, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
+			  value, 0, ip##_HWIP)
+
+#define WREG32_SOC15_IP(ip, reg, value) \
+	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
 
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
-	WREG32_NO_KIQ((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
+	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
+			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
 
 #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
-	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, value)
+	 __WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
+			  value, 0, ip##_HWIP)
 
 #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
 ({	int ret = 0;						\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
