Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B81C4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB82B613E3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB82B613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971E46F625;
	Fri, 28 May 2021 20:01:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7231B6E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgY+x1CAg7zHoNvPIDUrwRc28GMOF4iAihH7bNMMTTwgMJhVG4InVuHpDmop2OmiiTeG08nHLAESbsZ+FpW2YfAT8Lm7hEBcOVsuwJ2YkGcwnNlJnJm+P1WPtT0QJQRaQPttJts8aehVEvdsppfbOjWXgsVjOnvbkQvzzpEMF6sq0uyaaAaopkH9KquSFPXsEKUGCkbwSu7gPRPX0XjFzmpjYHHFQorpl68lqyLsT9Qw52gkQ5/cbdDwIuYTVmI1UG9kgGednTnzJp9UfuLqjwSV4iQI//k9tGS05z4SLkzgNhpZJOVR4ZdRgZnWyMEJP3HUEXq5h4fHG0J1Sxmy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eRON/Ee3OBEdSnYsmzaW5Yo8s7qjxlgzXstxZibcm4=;
 b=KXXegJloktXxqJiM8OZtySE3LIjMstdOXHtxGubTbc1qJQmSTjN++RRZGgAxZQXBrsITt315K8GDMiorusJqD1EuifzVugPbScEwvJqMNv3cU695r2n/ndLchm+8MaNx7RpzDzWQb0hFoRJ+Z1xdQDB5I7TTTY7RufthQGWlXf7oG/q3sAPWV+P+rl7NkyWDPqGt9F2IUrr57QG3eYxSI2Ig5nL3iTaIoMb1shqt3FojNmCnRSEY6/la7jdYIs+I3cIMI1OQzL7L3feXPGtu8LtmpnUF97Y1kvju8AbBQ79pbF09Q3Ora2dNtVZGAQX9g8vw3elGS0fFsO9fqP1mcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eRON/Ee3OBEdSnYsmzaW5Yo8s7qjxlgzXstxZibcm4=;
 b=vVhf07bFHA6R3Y0VDMJTCW13YITq/IMTtoMck3xCpWjnrB/b5AIAsl64Wcyr4s3qRbTqOXZAmn0dO3ZaUyK6iouMz5Ty/CS6wlnHx69SB/h7Y/D9z3ZtlTcKF4F863j9ySTYFkCkRXZVNlwZ3H6Efg2zKZ6CQJiXco11IKK9yUE=
Received: from MWHPR03CA0001.namprd03.prod.outlook.com (2603:10b6:300:117::11)
 by MWHPR12MB1423.namprd12.prod.outlook.com (2603:10b6:300:14::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 20:01:16 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::75) by MWHPR03CA0001.outlook.office365.com
 (2603:10b6:300:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:15 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:14 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/8] drm/amd/pm: Add ASIC independent throttle bits
Date: Fri, 28 May 2021 15:58:09 -0400
Message-ID: <20210528195815.2615-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1902997f-0e15-49a2-51e6-08d922135a14
X-MS-TrafficTypeDiagnostic: MWHPR12MB1423:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1423D3C11FBEE57D1C3D1E7B8A229@MWHPR12MB1423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpoG/tVDIgmxMBoCISfn4q1pxtWyCVsAKLoeEyR0F0dBgjUb1dxVI5hGJBUn40I3iRauz2aQ1CheaMS5gUv7tdNVoXzt9fSKZ76O96BeZDEkgcBswMAz3LBTb3CEfRNpL16Bb8mDjK/Rfvb9Ef0X1LpWJNZLoH9D4H5BGk4IMlWDGRS6jl0s6LNsA2yYWwtkYS3E8RDX9p0ZT+CVg7W30IITu1v7LMGMPmCJBeCOC2K8dFMpYcth5sCzbEIU3a+6O1VxQESd+Mdz5ldg8Yr3Qx0Is7uPhpnaS2H7JOzDiW/e/dURL5AMSB4UnrTdnVJxUREKNxXcMFmpdXOY4ml67P9DhARQukY2jHSZhY6wx7X067w6NivtVOgbeYJET5G0AMcIGX6aTWqYtvE1PDBw7n1jeHvwR6YznQv0iICXHsnGZKRXIFnOYB0AKEdxRqr84smAcH/+H3dHysM7sP+2221jbleNRWKuARs2aMEfbbNMbjiYGD63R+4/48/i0euOurNVMyR1Xy6qdIh8cIu030rqL07oSfXzmOutbOQRS1jgFefWWeXkJm96kMPv3Uhz7ShNfSob0TW7SMStPf0czH8j3Uy0hNpL1c78mt5fKlLdgxdNSzUMl83r96USOdoph9BaSlan9E9T6A+ybfStPtca2iIQ4+SA3KZeeqWo6KuKdcui6AeZ2FzyoQJdpqaq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(70206006)(8676002)(16526019)(316002)(26005)(6916009)(186003)(2616005)(1076003)(70586007)(5660300002)(36756003)(36860700001)(47076005)(356005)(6666004)(81166007)(2906002)(54906003)(8936002)(83380400001)(4326008)(478600001)(426003)(336012)(82740400003)(82310400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:15.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902997f-0e15-49a2-51e6-08d922135a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1423
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new defines for thermal throttle status bits which are ASIC
independent. This bit field will be visible to userspace via
gpu_metrics alongside the previous ASIC dependent bit fields. Seperated
into four 16-bit "types": power throttlers, current throttlers,
temperature, other. Also added extra defines new to v2 applicable to
renoir, namely PROCHOT and EDC bits.

Defined macro smu_u64_throttler_bit which is used instead of
__assign_bit + test_bit from previous patch revision due to upgrading to
64-bit field.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..86aa699f6c0c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -35,6 +35,48 @@
 
 #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
 
+// Power Throttlers
+#define SMU_THROTTLER_PPT0_BIT			0
+#define SMU_THROTTLER_PPT1_BIT			1
+#define SMU_THROTTLER_PPT2_BIT			2
+#define SMU_THROTTLER_PPT3_BIT			3
+#define SMU_THROTTLER_SPL_BIT			4
+#define SMU_THROTTLER_FPPT_BIT			5
+#define SMU_THROTTLER_SPPT_BIT			6
+#define SMU_THROTTLER_SPPT_APU_BIT		7
+
+// Current Throttlers
+#define SMU_THROTTLER_TDC_GFX_BIT		16
+#define SMU_THROTTLER_TDC_SOC_BIT		17
+#define SMU_THROTTLER_TDC_MEM_BIT		18
+#define SMU_THROTTLER_TDC_VDD_BIT		19
+#define SMU_THROTTLER_TDC_CVIP_BIT		20
+#define SMU_THROTTLER_EDC_CPU_BIT		21
+#define SMU_THROTTLER_EDC_GFX_BIT		22
+#define SMU_THROTTLER_APCC_BIT			23
+
+// Temperature
+#define SMU_THROTTLER_TEMP_GPU_BIT		32
+#define SMU_THROTTLER_TEMP_CORE_BIT		33
+#define SMU_THROTTLER_TEMP_MEM_BIT		34
+#define SMU_THROTTLER_TEMP_EDGE_BIT		35
+#define SMU_THROTTLER_TEMP_HOTSPOT_BIT		36
+#define SMU_THROTTLER_TEMP_VR_GFX_BIT		37
+#define SMU_THROTTLER_TEMP_VR_SOC_BIT		38
+#define SMU_THROTTLER_TEMP_VR_MEM_BIT		39
+#define SMU_THROTTLER_TEMP_LIQUID_BIT		40
+#define SMU_THROTTLER_VRHOT0_BIT		41
+#define SMU_THROTTLER_VRHOT1_BIT		42
+#define SMU_THROTTLER_PROCHOT_CPU_BIT		43
+#define SMU_THROTTLER_PROCHOT_GFX_BIT		44
+
+// Other
+#define SMU_THROTTLER_PPM_BIT			48
+#define SMU_THROTTLER_FIT_BIT			49
+
+#define smu_u64_throttler_bit(dep, INDEP_BIT, DEP_BIT)	\
+	((1ULL & (dep >> DEP_BIT)) << INDEP_BIT)
+
 struct smu_hw_power_state {
 	unsigned int magic;
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
