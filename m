Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACEC47097
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E12061208
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E12061208
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEDE6F4A1;
	Thu,  3 Jun 2021 15:17:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7AB6F4A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyAKGrd1GTApiGbsM2Nc798Y0UwV++m5WyGwmGUwPY+kZAfnUy66dk+Q070U8W0RxSYBCmC9no8fa7AaMOdM7ze6DyGF1wciu5mhyGz+8dhuCxKRfFvcocC50mydCb3t07bvM24Zva8cM6wMCxsYoIsRdhjRsPl8nXRdDPWPZ1uBFz4RV3AuofLsSxVB6agyL6GzhuB6QCRqT4Ccl1O0l2gF5hhkhLuJouElcNXAQFLcuAqrNd2SK3DJKfh5AjsFxIFvN+Wd4Dbd54ep9JXOO17tLR9pyUfuDaQLb2+puZXlW+7KPX1QiLn6LjERaLxo/38f9QgDgvwAWiw+I3+m1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGBMUbVNTsrHY/eEHBFMqeQGfKRAe7y6JaxAPDNHeU0=;
 b=O1L58yV/0DKmX/Bmnu6iF/hjrUylnpio0jGJbKLmiclQ0SSt/ryT3OPr+Z8DRm1w9ztxkhS04gYyld96Wxi3KHrTyHXXwI+cPb5iKZfyB06AfdK4buXaTKzQOau4v9aS402wRLOevQNONp9yIvaYws1j/UVjE+s2tdnZbID7ftW69E4c5zuYt+l0U8OlB9kwAFTZNhnZ5zcCtu/AIbhk+jPBnSMuv2uK7SGpBhH203G/Q1r2bCWhBwNNfsMREiFnG2Vt3ATbwTUwhUcb9J7k4oLB1Wfhy7YIX1qRDR0UlDJpeeX+wN3781oLsdp5WMlZdAraobiEl3WyvaKAIc710w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGBMUbVNTsrHY/eEHBFMqeQGfKRAe7y6JaxAPDNHeU0=;
 b=B/oaA92EfDSG6u8A9nNF9uq3sIyEkliFyOo+p3F/NKEskQJ8XMc/bsxLV3GzOGJHtzuRpjWs+ep4LhQ3mMXKNTZKp/sYWFxKpfG026OsAsu6DNKKYTmBoKJDtFRNxefmF6kbeN1fRZWHRIqvrgr++WZVkxbBWpjdUoA9+ozIilg=
Received: from DM5PR2201CA0002.namprd22.prod.outlook.com (2603:10b6:4:14::12)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 15:17:37 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::c3) by DM5PR2201CA0002.outlook.office365.com
 (2603:10b6:4:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 15:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 15:17:36 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 3 Jun 2021
 10:17:31 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/9] drm/amd/pm: Add ASIC independent throttle bits
Date: Thu, 3 Jun 2021 11:16:35 -0400
Message-ID: <20210603151642.14014-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603151642.14014-1-Graham.Sider@amd.com>
References: <20210603151642.14014-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b695bf7d-8aa0-4818-4cb8-08d926a2b817
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4199573053D87C170BFBD9438A3C9@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PT2K00lZc0qB93M1MCkcjh5NR4VJ/cGxPqNsCUYTBp0jQjNHbZNkIHhZ6VRfq7wyermu74VDXZCJ+CqPsDHdr2vbiP7NY6v9UcFLFt5dJdBNBjs+aI6DzE09FGFVSpXRb5D+9ii4r3+i273Ng5vztzrWCznoTI31vnrDbqMfMJafyloE/1dh2kB22hIFqztUzvP8NtUfcrxQqwaz1RdBrbHHj5oD1Gac+9zECuWrkes+l89G/+Xx4PCenlKOXOXjZBGHnce0ACmq5zndouM6OG79E9H/9HyOztESFhvSxqrAabp65EOmVPpILB3X1c1Cu7LeKZ4s9/D/UuG25K7jITElNzH2YT0xtapAZ8o9vE/r3sRwKlQ4X2De7A8uxRoltbRai5+gUR0SZSSWyyWQLTRs3J7pg7fXr5oNUI1YmGcCZV8PeoqLdIErC+fncJ+hiowJ2+t7iNKeiSHeyKK4WWG2tXZtFcVYCkJwmPL8d5qOZ0ykRVogcScZ0POXHhqS1jEF2CqQsYy8evOyHapqCyMEuxIcWFEV8/219WNOd5u/fFbD1Ywvv2vBentk9cHxAV0q0bZwUzxFWyyrz54wy13X0XposPWAZr0LPhgYAYGpmDLDa7KJc6h4tJdq3G/TusCM/QvydSWubVSOcR+Yjeyam/dd5BlWYlVDtgTWRh/MBKvIpHw1V2eQraRdnbyA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(376002)(396003)(346002)(46966006)(36840700001)(36860700001)(426003)(8676002)(47076005)(5660300002)(1076003)(16526019)(186003)(26005)(478600001)(8936002)(336012)(2616005)(2906002)(81166007)(6916009)(36756003)(82310400003)(86362001)(4326008)(356005)(70586007)(316002)(70206006)(7696005)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 15:17:36.3678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b695bf7d-8aa0-4818-4cb8-08d926a2b817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new defines for thermal throttle status bits which are ASIC
independent. This bit field will be visible to userspace via
gpu_metrics alongside the previous ASIC dependent bit fields. Seperated
into four 16-bit types: power throttlers, current throttlers,
temperature, other.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..441fe0254e56 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -35,6 +35,45 @@
 
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
 struct smu_hw_power_state {
 	unsigned int magic;
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
