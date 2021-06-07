Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A7C4743F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94E9611AC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94E9611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3810C6E8CD;
	Mon,  7 Jun 2021 13:45:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB7E6E8CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmcKEX0JIZgj9HVN7mCpNHRnLlzt87aq0Bhvq/VAiun6vmH+8NTT2+B5rfmbEKar3ly6gy2dGxjBpn4L4mKgkUQMLdOtzcEfUXtgN4xrQIC9mYMi04cItgQEMiXD+jyLVYGjGTWniWK8ZilFnA+UCk6D7VlmzPuzIbp7pwHWU56J48tM2uL9PGSBg4L6NG+GylQQA34gYPYzy1fdB42p7k2EHovG+9/W8OBCzcxpz3TOtAa2BCPZmPcrBebcWn//7Jq6tBlrqJDzWih0IT8AiecOxzQ7PmyS9px/tRFKr5vmOn8nmru5/q1OcTdjHUL4vZaYQxU91xquWXZKczyYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnZ10G2UJhPYGyPX/uXVKj3hEZ4ZeoNzATRGc4qRc7E=;
 b=M/3eO8ptv+Okrk5RP0NLWd4+El/WrBVKHPMSNrejxShOBdeXNIFJyht/9Cw7H5ttDGH50stltPiqv038A4NK2QjMiIDG6e4gM7N5pGu255W/Htonh9AEHYSstwSiIw8yL81H78d6F4bDyRcTMhVTkA76h8PaVQxKIF/5IbibpWQFaIocoKnNWvvImGoR6hCihfoI1xMKiNVQPQpyxYQhHBLDdp8kdmU4oPpRg1gLz02nb0MpoHM1qGurLreWrJ+vBNbtNesfZgOcmaC3TGpwxufX3BS94QxLcZsWuCgcUxc6XOEGum6g8PgO7z2W/b7CBEttx6J+7z2x5mFHoPEp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnZ10G2UJhPYGyPX/uXVKj3hEZ4ZeoNzATRGc4qRc7E=;
 b=Pnyb8WqRcpyl44tzUyZfoZ+XeE8lgsp56F/U53L+Lug64EhlgX9uY7LB6vdi7lk84P144EZHQbK8iSNauEJkcOfCS6W4eWlxi/wS/YLnJbAF1j8vkazFJYUWeCr/RD+QlW7Pfg60lM9/BWdl9rIF3GO6R9cX8lqUXVGJYFb0THA=
Received: from BN6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:404:121::25)
 by BYAPR12MB3559.namprd12.prod.outlook.com (2603:10b6:a03:d9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Mon, 7 Jun
 2021 13:45:15 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::15) by BN6PR18CA0015.outlook.office365.com
 (2603:10b6:404:121::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:14 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:13 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 2/9] drm/amd/pm: Add ASIC independent throttle bits
Date: Mon, 7 Jun 2021 09:44:32 -0400
Message-ID: <20210607134439.28542-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14a03b06-af6f-49c6-be38-08d929ba7a8b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3559:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3559ED7095B60A60E527B9AE8A389@BYAPR12MB3559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMXpUoQTxCm92nImfvdJRArH4QR2feibJ1pbmYCCHkvw8JllC4DUy8a5SN4WI3DVgNlaZPSFFmN9J84JDucSoBpUmYu4528R/ptWFdmIiw0goBLnfhl+iFuRO8tIcfedjoiS76CAhotGOWMb9iFLqXUq2F7vsmST4OgCYP5LMRcaojqfB/v7FYUM6ePvo8aMCvByNYu3MrW/19MpPGWbAEKJDEf/7mFLjZdpeQdd40sWU+Qtl+0WYhYudFRa3toBVGRL+JwAxVFL6Egh5dqwmZ4TPcPrW2DadILGEgM/RA/7UDpDQzzNJOEhXv9luvVE62XKs/MsM8RLiirYyrPjJNMOje4R4RFmr2PjdR3MerAE6pj4xpFzj3fxBUe++M3nu2X8mC34+i7TG7OLMPiCwkF0J+yiuJgfOX3Iky4rmI6ji3FATaKMs0PZyqUmJ6d+Pt4cRdt2j7E+osWu3P98Nhky8xkmlppfJk9UkNq7FxcvpuhP/z0I71zki02Zh3Je4fH4DCWLgf+uJ+Z6k6wNGdtzqWvmrKCMZnOPLbqBeX0ofOVVVSmyNSpMXHlxA5UpffgePKutKBLwPefx09rlbpzJSzaxpJEb/LAcHBUgnmdc/nqM1QovepS3im071LbUAz6N8AEyDpDAo88Yo63lqxCsIacGq/dnCX/QFGm/NOqKIoD4z2G+1SJiqeA+XE0y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(46966006)(36840700001)(36756003)(1076003)(4326008)(16526019)(6666004)(186003)(426003)(336012)(2906002)(47076005)(5660300002)(26005)(2616005)(478600001)(82310400003)(36860700001)(8676002)(54906003)(83380400001)(8936002)(82740400003)(70206006)(7696005)(70586007)(356005)(86362001)(316002)(6916009)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:14.5831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a03b06-af6f-49c6-be38-08d929ba7a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3559
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
into four 16-bit types: power throttlers, current throttlers,
temperature, other.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..829fd8651221 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -35,6 +35,47 @@
 
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
+#define SMU_THROTTLER_TEMP_VR_MEM0_BIT		39
+#define SMU_THROTTLER_TEMP_VR_MEM1_BIT		40
+#define SMU_THROTTLER_TEMP_LIQUID0_BIT		41
+#define SMU_THROTTLER_TEMP_LIQUID1_BIT		42
+#define SMU_THROTTLER_VRHOT0_BIT		43
+#define SMU_THROTTLER_VRHOT1_BIT		44
+#define SMU_THROTTLER_PROCHOT_CPU_BIT		45
+#define SMU_THROTTLER_PROCHOT_GFX_BIT		46
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
