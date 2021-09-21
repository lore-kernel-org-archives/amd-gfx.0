Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D7E60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77D7E60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AA826EA3E;
	Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A0F6EA3A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZVPhkZRW84+P4+F3XlaLi+CNBoJq/HT+YQFj+TJRb82BV+iduGPXH/7IRl9pFjQU5AyveBVnMxuiZ/8FEyTdUKaG9//63YL/41dELngejATgVY7lHDAs8hNmPQEy2jUPIbQCJXScML0dpTz4k9fwT97DSWpjmb0NxU7shnxxXFmlUt2jZswV+/iWaMLHTE9Co+wBqtRsoTaOmY80cTEkb5yDMR0tsoPWJwdMt90Dht5qt1r72KycwVPoFPzf9j63n59nsU8tkyqNI7ealYGB1betdN6/lfjHbO32t8IfK4QIWgV2zh8EVzzul4fy+zv3R7Twn8YHWArnFcMpkvknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=OSNarE4yNLSLysRB4dZkkWufZkcrH2LKSrB3e78EuI4=;
 b=obtLN+3cIoZ7XXlrM4X20Dv3ZXxN38663RB+sV0mLAnveBZeThq+sjBPZlX4KWAaBCDVDt51DnkSNK9G9SJgBqkmVi8FOJZYJU/fDUI/73o5xNVSzroXwpWOd1OoWTgwoGmUpXoYgZXUwnrK5Pc2vnkXQB60T7ay9+q6hBSjXwiJFkJ6XVPtSTQwyjB5LQqSq2lwFz7vasTfMbvgRTZr5T166FUvvclzKubFcEkzd0dBFQYn9hdTRpCJsj80EJ5KiVyX9DO3DOdwwFA7vgYQ7Gr1WO9Q5f6hkjNTPi/i7E7IwZsN1YEfR+w9etdwKKG471AXsjD3fnybgi5dgfkmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSNarE4yNLSLysRB4dZkkWufZkcrH2LKSrB3e78EuI4=;
 b=1JVna6rMAN+VO6IUK4N+XNmvzMZJjULZnIay3HbosSsPL3jIpU8wV9AAx3naLIYBBNFBu3sWHRmLKFYZQ4D09fMiDg/4hYHyGG36r+gP7TcDWv3073uuo1VLaXRDc54YYtu0VHUx60bGwxrk4ks0mFFZGz2Fm682PgSnFqGE9n0=
Received: from DM5PR11CA0015.namprd11.prod.outlook.com (2603:10b6:3:115::25)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:43 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::d5) by DM5PR11CA0015.outlook.office365.com
 (2603:10b6:3:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:43 +0000
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
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/66] drm/amdgpu: add XGMI HWIP
Date: Tue, 21 Sep 2021 14:06:24 -0400
Message-ID: <20210921180725.1985552-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00c8bb00-d85f-49d2-3b18-08d97d2ab548
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-Microsoft-Antispam-PRVS: <BL0PR12MB251479519B2A53C9F48AD18EF7A19@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpFY2gDWolkkHBOPClM4310ced0y4X/8A3aA9Y3RPKeImUCPSi6YtQ5jh0xt8+2BQgun5r/Cipm54luyrTOIBMofalrf6Uo4sL9OZmYxZk3t/efhzW/daJkPVpSIWMjUYq0KhLUmJ4Rj2T/0DVJe+KyrdATwxaHD4vBeU0n0N1mwGXics0ubM03sZtyr2SyFj9LtgRH2ykNR07uVPGLX2pu3Ou2M2BhMOBZOcX+IrtsI1C3f8a8oeWWUKXiighhcoq9T3elKSAEYi7+enAu2Z/TqRswgora8CLKqZFWwdFNY7f0OY+a5sag1NmTvC4S4CbtxmWEJtAuqHT8yDq1R8JQgaIWdf+uIILUsgKFkFsBYbydKIGECJkhF4HHSCxpsBg26nJ2ztRrjLYTDrR5iA2K+8/23gBtkvWopEUpBl4uWahOoYm3/V3nXMb1jUgsZPArTvBMrFQo6JL2oMGaHuqm0lVQS5YoMG9Q1xRzVSshXPNMgK3Fkf9XPAFNYFFDOhpYfVzFSPC/tXGrT0iAUNHWJB4fBm6LbwFtRBZr73Asy3ZNxCGqAiLIArqIySVW0KSMdHRUhXjq3YKfFdSg9XvUaYu2I5EjNp6Ywvk+yG1SSb3FlTSuKjB1DS02sXUxZR1IFKY03C4yPqc9o7PVJPLj8IFE12a8h/CqD+5PHgd+EiCDbDk0Mb+8xd1LBGxkqR5I64yzhJaDonPwdVTmrrG5A7NesdWc0I1Jhoo3rsc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(336012)(36860700001)(8676002)(426003)(82310400003)(6666004)(7696005)(186003)(70586007)(47076005)(5660300002)(508600001)(81166007)(2616005)(86362001)(6916009)(356005)(16526019)(1076003)(26005)(316002)(36756003)(2906002)(4326008)(70206006)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:43.2344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c8bb00-d85f-49d2-3b18-08d97d2ab548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can track grab the appropriate XGMI info out of the
IP discovery table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 61ef0d81a957..8df4be702870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -755,6 +755,7 @@ enum amd_hw_ip_block_type {
 	CLK_HWIP,
 	UMC_HWIP,
 	RSMU_HWIP,
+	XGMI_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ff52fcce1f93..13d143c668a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -128,6 +128,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[THM_HWIP]	= THM_HWID,
 	[CLK_HWIP]	= CLKA_HWID,
 	[UMC_HWIP]	= UMC_HWID,
+	[XGMI_HWIP]	= XGMI_HWID,
 };
 
 static int amdgpu_discovery_read_binary(struct amdgpu_device *adev, uint8_t *binary)
-- 
2.31.1

