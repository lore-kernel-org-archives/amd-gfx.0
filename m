Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A46C47092
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A24613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A24613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCB46EAA6;
	Tue,  1 Jun 2021 18:14:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47EA6E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duP8KgwtbbOQUcgDtkuHfX3zErY+/4gfE5eUZkvSdlTyiXdJdddGkMJagDsXw+nuhtqIF/qNHfdsOcwO0PvoHCIJxOxc6o7KHWyDxlWc2Cps/JhRtwP/v46i9StNQfc7jrhgNV4zL5sZDWZ1OAtRoQKU2E/XZszG21rKB3tMh7D6186lz9aOQY++TBkp4q5AmomOrnGaIosu+lvW4fzV6vyT20SUuAqyotqONUW2QG/LpXZI3FSKGHbLzVKFbBU1DNNxXXX6zQHRv94CI5IkHNPJUYBTk6D9Q10+N2WuBUdKkXOCnrIDK3jXZuyJluG3202VAoMrdLJg4pSwe0N53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy9E+fwSh29rPz31psJKO3zg3+xBY/3x/NO3q7STo/M=;
 b=kfAJzXTWWVf35AHW+v089ijHVfG9lhhcT4+fngVX4v95t3wbR9bMPHRLHJB1pfw2GsWXOkk1W1Ni88pl5HfbYZ8XAjKcDQz9JfxkVHPttGqFlGrEEZqcwcAqhr9UsgxH8MDOUMRIeif1ct33rDgAuNXn25keJrkXgaivMjKrqy24SoTXKhd2PvAcKXJTsl7vhJlMV99Skwv/tiuWZrSJ2teYB0OBQ2w5qeTte1npxK09hwykfCl6mN1R/GmE/SttIEQlM/4WLAs5cKvx/Z6f1N2yekwZI/RoKEs0X+xFhTpbi5L8pJr+pYD8aoyYzjrdi/CV6EPEf6qopGSmOHgxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy9E+fwSh29rPz31psJKO3zg3+xBY/3x/NO3q7STo/M=;
 b=BEoqFkk+EkoNnZbOTQ/R3CVtPQIuBGkroztZ1nDM+SsqB7KPLW69n91S73XVeCnNORHxriGCs1o8BAXbT9N9OGY2Pl6VrB9optVzOzrsXtCTVvf0CLaSmhNwWP0f4Qcm/lvP/Q0nXZKfp3gSRoLfj2ix60Q+xXMZ2JWDDOuZfCU=
Received: from DM5PR22CA0015.namprd22.prod.outlook.com (2603:10b6:3:101::25)
 by CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 18:13:57 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::f6) by DM5PR22CA0015.outlook.office365.com
 (2603:10b6:3:101::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:13:57 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:13:55 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/8] drm/amd/pm: Add ASIC independent throttle bits
Date: Tue, 1 Jun 2021 14:12:25 -0400
Message-ID: <20210601181231.24773-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a6e326-345b-4418-f115-08d9252905fc
X-MS-TrafficTypeDiagnostic: CH2PR12MB4924:
X-Microsoft-Antispam-PRVS: <CH2PR12MB492453806A7DAB341EA2B4928A3E9@CH2PR12MB4924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQWo/FHlVC56dr4zPFu4JajFxwzE+sbejXd27A8lQm7TqkA7lhydimqUHyy7iB6WSZO4y0mNDrzS0amziUZR6GUUAWv+2zTMjGttA8hZomgXsQhkuZKQ9GaxlOC5DOqwh9kQSDdN7hKr6DcCAelh99O5dB4gFKTbaaRqKFIlhMf6lHM1H7E5jYLg4HhXZHERXjkA7kBKv6vqAOh7x33Yl1AN/RXz8Nyo5D3Dm2/wynInROMUmlFPtVeZ0Oryaxa3jWZhG/UoDkGjnhs61xKSZxZhn9WfOpRAaiQSBCwK5svzLSGQHZA/SsNm4WIC2qraFqlT020eA1p0eInOoNXF8JdRD53K66jNB5Z3Tk14AROFRKqJIodjr51/k5xCJKMSB86jMk2Lile7Ei7saJVPZmIWYfHN6lUnrDKMaD16/SmkpSqmkUwVphkK20aoVG9YOoDZNAgNCJhLnxVQ3/UELnVrd9JzKFhR6pgnZgARAKIztxima0SzCQlG2VrzKnYzNnn2KinbNGLCES0quvfzh0upNb6QmL9/qogolXVyjj708m0lMqbLLsoJaDdMbYGeqWSvWOyIxeRDI2Cj7S212bCs384LnNgAhU4YE1uGNSwKe/Ve57wGya81I1fbcw52Msd0TpCyBYocyper2CnPtD3YU9N0X8/0ZRwg7T+BCDFmu8Mnqn7nW8RSeK5NUlmk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(356005)(82740400003)(81166007)(47076005)(26005)(86362001)(2616005)(478600001)(82310400003)(36860700001)(70586007)(16526019)(2906002)(83380400001)(6916009)(316002)(1076003)(8936002)(36756003)(4326008)(70206006)(6666004)(336012)(5660300002)(186003)(426003)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:13:57.2956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a6e326-345b-4418-f115-08d9252905fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
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
gpu_metrics alongside the previous ASIC dependent bit fields. Separated
into four 16-bit types: power throttlers, current throttlers,
temperature, other.

Define macro smu_u64_throttler_bit to handle u32 -> u64,
dependent -> independent throttle bit translations.

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
