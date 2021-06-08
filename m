Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29FC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271C16128A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 15:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271C16128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D18206EC04;
	Tue,  8 Jun 2021 15:08:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFB36EC04
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 15:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcDugSyVyySGAd2ZYkCwqThJqRIjpkFI1gADku3tHkWAhzRGg9YnGYkg6lH9CItpmLBYGlroglq5Ao5ucOR5RlTeXRfqB1dYwmSfiBdc51SD+P76nDIAqQrQRNS/+QGmQrO5r5fWpv1dc4GtPC4/xxUP+Q1Y4CeV5qNOGzTqZv/A1g4SFPC5CsQaVJHcmgr4r6lDuPsg2PWko9J6hbGRvPfsAh8IyX8w4qf8z4Hq7uEsZ8gcsI0bhTKOl7Xy2Nrtm0zJ5ISo8/eNAwemwboWu10IQ8NHvG6n47C4AozPtl8g2eUuw3Q7A1wQcda3i6sWR/9s7kpBlKgvZ4SGIm9yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYOelHeNjFd8knPdaYqI8fhvp4X2DsnUeGF7CszioYU=;
 b=FBsLLTg0e/0RxF3wLtEEdNVnkhtkISElNaEo1l4GULSI9WxCwhHjmWgEUnp7qYv05WE8UetexpfPFLQ8+s+az/FesnotDLe9iEEZ7wwdPXAHhYIRHhQ8xsXnWXEoV1EPisRLfYyWnEzadvwzn7GDWoGPGqrgRPHJoQsS4NJ2jwF2xnDb/aHaIA+YyrAmpepA/iY4JoVw7wqhKalWiQo0ie8smCbc5P+0H+qFT6rMeAo7gLW6ErFziHTrrQikER4sux5oELWyOKIa8XP9XIKBB8mRh3tX98Bo1jLvAcxBC8IL0Jea6AbnY3SUNvYOCKr5RL4Sq2cQ7qlYch6OI7QYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYOelHeNjFd8knPdaYqI8fhvp4X2DsnUeGF7CszioYU=;
 b=I7tM+Rb725iX4cFvcFdKQNAuA4ad1g7hMEhAlIPuegDp0EWqGA1sOIJweTdB0W1i9lK9qv57ZqL1ujYL4YrtG6RiH/kDO2/9DMU1RShLJCj3REH397mVmjW3Brf+BLAt9tFu/k40DYJn5gevdXgJR8JL4yhYOEYcb3b1IUEobeg=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 15:08:26 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::46) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Tue, 8 Jun 2021 15:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 15:08:26 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 8 Jun 2021
 10:08:24 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 2/9] drm/amd/pm: Add ASIC independent throttle bits
Date: Tue, 8 Jun 2021 11:08:03 -0400
Message-ID: <20210608150810.9679-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
References: <20210608150810.9679-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32bda8a-dbd1-45bd-d2dd-08d92a8f4429
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5182C0C1D16730B150FC3ED48A379@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVAS7Je7MGhl1LkXiPWUrjxnx27oydtdlQHGZXKfQDK0w+4vS7XK4SAowG8bOP/VL+k81BchXjhwKI608kIcDZAo4SzRfPrnL3W1z9vOuNKoQp90FPcICDQnj8JapVtDuGzOAr7hdPi9H29d+l1qIOjTF2sPl6wbyPlkkyRDvry4epu3h1ycq6f3tex8q9Tp608+blB3xIlaUb/ECe/e2Rfguq3dsQ4+iL+Scmc0yvVi13odtRfN+sXzIaTfcKEzqERbSF6wIH2sZfDgFtURnZMSdH+ANdA039DvOrP2QALRz/bMQGJaPFaX0ASbuZ1Kyn0NiXVo/Pc2f0lI8hYnZClXmTYvvsQceRG/gW+1WtV+iYfNIGkCnvScgWm7M/wtRkdsielkxToFs/RQuGLcDO19n2c5HiXpEJnbBxOk4tXjowS9snT7k1z/778HmLLe+LC+pSTKQAQmIvkO8s+AHeXbq46Qp4FpkZcMyS8whI3zA9OUMrdHBk9kWEw70BXeYn/L/ZxPzvm0FlwOPcNgegFKOyopjfer19oG/K2CymGusQFa4pVotL6Zujzm1jJDxtruMA+qm02IDmdY4q7pp56dPfodRJhTPVd/ceZBtSVutCt4+CuN3FSR3eqCC/WApENugYzAfYu5SbnrWQbN6jht44c8DTNXO/DZXpENDCzjxcTPi047RHlS12e9KHjF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(136003)(346002)(396003)(36840700001)(46966006)(82310400003)(2616005)(316002)(2906002)(4326008)(26005)(5660300002)(1076003)(47076005)(16526019)(54906003)(426003)(336012)(70206006)(7696005)(83380400001)(478600001)(36860700001)(86362001)(36756003)(6916009)(356005)(8676002)(81166007)(70586007)(6666004)(8936002)(186003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:08:26.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32bda8a-dbd1-45bd-d2dd-08d92a8f4429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
into four types: power throttlers (16 bits), current throttlers (16
bits), temperature (24 bits), other (8 bits).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 71adb9e76a95..4993daa60895 100644
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
+#define SMU_THROTTLER_TEMP_SOC_BIT		37
+#define SMU_THROTTLER_TEMP_VR_GFX_BIT		38
+#define SMU_THROTTLER_TEMP_VR_SOC_BIT		39
+#define SMU_THROTTLER_TEMP_VR_MEM0_BIT		40
+#define SMU_THROTTLER_TEMP_VR_MEM1_BIT		41
+#define SMU_THROTTLER_TEMP_LIQUID0_BIT		42
+#define SMU_THROTTLER_TEMP_LIQUID1_BIT		43
+#define SMU_THROTTLER_VRHOT0_BIT		44
+#define SMU_THROTTLER_VRHOT1_BIT		45
+#define SMU_THROTTLER_PROCHOT_CPU_BIT		46
+#define SMU_THROTTLER_PROCHOT_GFX_BIT		47
+
+// Other
+#define SMU_THROTTLER_PPM_BIT			56
+#define SMU_THROTTLER_FIT_BIT			57
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
