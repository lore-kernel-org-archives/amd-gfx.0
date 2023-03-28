Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4BAC761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D9810E91A;
	Tue, 28 Mar 2023 15:14:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2561710E90E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPmAVL5p/+NuvlGStMgXhI3eRZDpQk4CV4a/V/jFV4k6xKkz6Ezv5c9ck3bIIXmDhDQRDaLCiHGHi4J+A1nYI4O5MUlw7GTS69VAFtmYrbNYd/LfB9+YFPrMku7XHVTMcDPwBYhxv60b85eUonSbxV+aowVFqAZLAB+4TA1+6Y4OeHSqt9PSQAojuWHfWdTJW1wTUknC7gFSOre6TzHrdvHS+26QeEdHz1m5I8rzArkpuHY2sfFPbnV3/QDht1g5s/PeDDwApQ2Wn4eCMM8MLmVJZ6dzE1nsG3buqEJrVorgUQbzWk2YoPDX2BJ95/orP6Ex6qd/xMSoQjloXB3ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLrXhRg9C41pV0pYWYoEGE5dT9nLS51K8YQqBC31uOY=;
 b=CQfJ+l+ukpevWWmS4GSbXVLoLpwbA0t/0uiw1IoGZECOl6CWIlrthZW9WFKnVnqyG40pSVIdc+Q07CUdrHHIYNPJdAnfB9XyEhw1V8dFKTF4vnNoUh+HZC7Bj+mN+Z1ea9cw8upIjpKuBOibF/S0NqYJR/fpe89ek7EiJbN9zIjYS6TYy9Wa/2lUq6d4rPrUAbvfNU0nuTP6jMxAQGlJ8dcskyOozOSNjfhi9V5x7OjySKHruhk8veMZ7SDN940eYGyz9Nl5R87C4AGYOiA/jI0mYUgtv+J4AHYITDBikXRIy2zVViNgWpl0dvZ+WqOlfEFpIhU+YE2qKBGH5a51Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLrXhRg9C41pV0pYWYoEGE5dT9nLS51K8YQqBC31uOY=;
 b=UUPVved0aNyZdgDK3iLfGubNtE0/D5aWWVctF55GbzjoI1iQB/t0xiVCE2oY9prlVQd0g0C+5+4miHZ9wyJzgm+sfIem/dJjZqXedfX3GX9VQZBlV5o2OyfkyohEpYjy4hn2lZh4PyyvbTGmITasQgluKtJ0a0A+4td0mC/KZbo=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:48 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::4c) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/32] drm/amdgpu: correct the vmhub reference for each XCD in
 gfxhub init
Date: Tue, 28 Mar 2023 11:13:38 -0400
Message-ID: <20230328151344.1934291-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: b6001b6c-58e4-4223-268a-08db2f9f2bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNY4uOypEzzMl/kZY2AFNf2jNXUPUITIUM3wBbD3RipTUKeHDvyXY/Xi64hyNEsPfwEjfUa+khigXzzlytATfcK4CuIS9qiZ7RPNU98mQONCWRTXn9szd2ip2GphRDOt7PrzV2evBDnox1wXTrjylEFQ3fh0nYsJ/65h0Ka2vSWb7f6snEIXMt+oL0p03nzSYiR8l0xkt0ZUzOo27R4fORsvQsvRZej1FcXKKrJYVqB+MQxcpKIuqYEJuLuciJP/B/+VGiA87DM4YZYLurzPnZoJt1jwZ/Mu9bXYsLmRPywVEnSXlqF1zyJNHcdBvjioB9w/t6v38nvl5XX/4YOG94pktWz0vW6nZ/B2sm0ojgXVCDyn3fSiqlydRJXwXIhOGAP0ltabIZ0oHPzhTSCHR1nQ5uagUrRdCW8l0kBLfGy55dtvrYZqlEH/kwoMqhiTKF3sS+QOAC1f77qY04DIoI1Scw7v9cDe2k6GXjsmaF5ySHL5fuTwZv+rR4WUr14U/FlUpd35VIxM3FJkZWLGZUhvuqC2MU0fdQvrxUv5zXX0matzSFjzZk+sDU80KwYk1e2FAjVtPx51V00/icvJ1MOcq/tCwp9RrtmsfGW77/oEm+a9IA8F0ZLGjLxqBpPKc4jmi3NCd3/LoM3oUnd//SVjIBTcVd0V9T7p0VfZL2FNW3CRVH7fct9B8DbcDYwqqlYvt42T3VrWHRMOc2qxlI0njfBmmCy33pGee+deMQE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(81166007)(36860700001)(356005)(40480700001)(40460700003)(6916009)(82310400005)(8936002)(186003)(36756003)(8676002)(5660300002)(1076003)(41300700001)(4326008)(26005)(336012)(16526019)(2616005)(2906002)(54906003)(478600001)(6666004)(70206006)(316002)(70586007)(7696005)(86362001)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:48.6249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6001b6c-58e4-4223-268a-08db2f9f2bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Correct this though the value is same across different vmhub.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index d74621662311..d3424ce97aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -42,10 +42,11 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint32_t vmid,
 					 uint64_t page_table_base)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_vmhub *hub;
 	int i;
 
 	for (i = 0; i < adev->gfx.num_xcd; i++) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 		WREG32_SOC15_OFFSET(GC, i,
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
 				    hub->ctx_addr_distance * vmid,
@@ -291,7 +292,7 @@ static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_vmhub *hub;
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i, j;
@@ -304,6 +305,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL, i);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
@@ -359,10 +361,11 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_vmhub *hub;
 	unsigned i, j;
 
 	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0 ; i < 18; ++i) {
 			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 					    i * hub->eng_addr_distance, 0xffffffff);
@@ -408,11 +411,12 @@ static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 {
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	struct amdgpu_vmhub *hub;
 	u32 tmp;
 	u32 i, j;
 
 	for (j = 0; j < adev->gfx.num_xcd; j++) {
+		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
 			WREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT0_CNTL,
-- 
2.39.2

