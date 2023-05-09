Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5379DC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E9510E439;
	Tue,  9 May 2023 22:22:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A3D10E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKd+gAinAdZ2IDAYX0gQ+ZimoaEL7yv9V96WjrH4kcc4Tz+hz80tzwyFT4CspmkPFjKgqzJUIOl9MvURspxP5Y3ag9IaMHQFDQuj62RqUJMtlAXHdcrjC2f5Pw1UgsTmq+koYNXHEZ09QLk3Ir+MaIqFh3JDXPLewBc/pUbN1O4XWqu7RIcU/EXwZTA3XMX8DjI50mEBv4Hcl03KQZO0Tp89eIL+qARh6nUMf+sLbHZNpHdphMSj+zsgt714GDtwxHo7Pdrs/2Nwgq5HG5rRyupDYHvPniZ0lW5LZioDVgz5AATzyn4UKxzCatJUPKNhzNRv+WkFHk+kvUoegDXprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir/KDWnqm2/kjg3Ibwxu4SCdz8JZzZTLf0y6YCydXMk=;
 b=ie4QvWChlpH40+z2673+g4Gzp0iG4IbaW9cxY8lW/tFlHwBWDmObls0/6/+NlEet9XodxGA5uhUwsspLv5vs2V4ppJupkhegPIH9B2UtxVlErriM7DpW3f0prF066I/E3oY2nam+6TUN3MBZCfa8SYNlys0EZ4zSYmdZ1OTDiVqn8J2ntqU1LfHi1J5xB/fW/dufExUEemvrv+TAmcWeiy3GhLGdzGNbcK+VSzZFPr28mtbc1m2AaRGPVoUzDWy6TYBEPsssi/XUelXYxARLqbdADhpNlmGKj4UaZ+HZTYcj7SqdGi2Ei4aV4uLSrsj+k9NJlI3lsafGNXydo+xsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir/KDWnqm2/kjg3Ibwxu4SCdz8JZzZTLf0y6YCydXMk=;
 b=eC/FPM59nUIESNASaRJ0fCftLrRvYH4539DBm9AtoVP6HXf6ZzrEnMCD08ufIcq5mav21I0eetkSSxlKkN3tWRNJVhHGqSV5ds2KqJ9Eoupgaq4N+S6QrMS8vDG2zlyW8xoiU87XDWujIZf9f5D9SS6Ngnf/WB1xjb2e8GSjHdw=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:22:51 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::d7) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/6] drm/amdgpu: Fix register accesses in GFX v9.4.3
Date: Tue, 9 May 2023 18:22:33 -0400
Message-ID: <20230509222237.478097-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222237.478097-1-alexander.deucher@amd.com>
References: <20230509222237.478097-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: b08459b2-787b-495d-e5cd-08db50dbed63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCDm6TSy+pNgnzvwUQSTQaLZnWOBuIQI7CvMdUXfySRHtWb81V43xYN+HlO7mzUGP7ZyDmVjthQxpd8xrHG4D3+FT8Q4KOMZbtutdUDPw+Q2HrqzVx8U97ZK8BXbilQciDI6eZjbBt0e65aQo/WWKWh0htCgFiNjDWJiZSrnJW479YSst47o9vgyFDBj6MF+TnrRwtqi5jkXl/UFyt7x2y6u+v2bLYnpYZ8db7ll8OhQbqC4naSBS7Z01WXiu9HKgxzOjp/kUxIAWB1J5ogffXqaxZQoSgbIndTTWyJFyoEpmwM0Rp5nBftprXqbJvcqoYhUeSUskAftnjeYlhO4bKLgXWYijsrttCoASe7V7bExiIDOBKaKURNECJ4hHJMHf6+LV3MuK1aojzbhEOq6UXPbJUZibpf0DiJaJRGhxw+K/5cxf+tagB+zJGxsu3PQkUNz1NCqfnLPJriWdYnTxOeRkqefa3/19BPNWZFu/6SbNjJfVkau5rtGS+octw601CcYtV3BSg7ksF7RcAm4ND38iwLe9JQgGnkWHSrVPsaurI4wXXBjSREgjHqJZn2IQGrmdApY7N6K7KT4QqaC0YKQPLEwzN5YiYreTEGycvPSV4J0Koo+GV9XhFPlyuTBHr6G94437YijvWAz0wri7ETInN7MZ/pAf97XHH1YVHyJMCBiu8crWVb6mBtiM5QksZwn/IdS07k2YT/2qkTDorLeq68SQyg6P57ciZ4krbc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(54906003)(478600001)(41300700001)(8676002)(8936002)(16526019)(6666004)(2906002)(70206006)(5660300002)(6916009)(70586007)(4326008)(47076005)(1076003)(26005)(40480700001)(356005)(186003)(7696005)(40460700003)(82740400003)(83380400001)(36756003)(2616005)(426003)(336012)(36860700001)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:51.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08459b2-787b-495d-e5cd-08db50dbed63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Access registers with the right xcc id. Also, remove the unused logic as
PG is not used in GFX v9.4.3

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d0ddcd751432..7ef2c9b515ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1004,16 +1004,6 @@ static void gfx_v9_4_3_xcc_init_pg(struct amdgpu_device *adev, int xcc_id)
 	 */
 	if (adev->gfx.rlc.is_rlc_v2_1)
 		gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
-
-	if (adev->pg_flags & (AMD_PG_SUPPORT_GFX_PG |
-			      AMD_PG_SUPPORT_GFX_SMG |
-			      AMD_PG_SUPPORT_GFX_DMG |
-			      AMD_PG_SUPPORT_CP |
-			      AMD_PG_SUPPORT_GDS |
-			      AMD_PG_SUPPORT_RLC_SMU_HS)) {
-		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_JUMP_TABLE_RESTORE,
-		       adev->gfx.rlc.cp_table_gpu_addr >> 8);
-	}
 }
 
 static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
@@ -1071,7 +1061,7 @@ static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id)
 
 	/* wait for RLC_SAFE_MODE */
 	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
+		if (!REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
 			break;
 		udelay(1);
 	}
@@ -1107,7 +1097,7 @@ static void gfx_v9_4_3_xcc_wait_for_rlc_serdes(struct amdgpu_device *adev,
 			gfx_v9_4_3_xcc_select_se_sh(adev, i, j, 0xffffffff,
 						    xcc_id);
 			for (k = 0; k < adev->usec_timeout; k++) {
-				if (RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SERDES_CU_MASTER_BUSY) == 0)
+				if (RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
 				udelay(1);
 			}
@@ -1131,7 +1121,7 @@ static void gfx_v9_4_3_xcc_wait_for_rlc_serdes(struct amdgpu_device *adev,
 		RLC_SERDES_NONCU_MASTER_BUSY__TC0_MASTER_BUSY_MASK |
 		RLC_SERDES_NONCU_MASTER_BUSY__TC1_MASTER_BUSY_MASK;
 	for (k = 0; k < adev->usec_timeout; k++) {
-		if ((RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_SERDES_NONCU_MASTER_BUSY) & mask) == 0)
+		if ((RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SERDES_NONCU_MASTER_BUSY) & mask) == 0)
 			break;
 		udelay(1);
 	}
-- 
2.40.1

