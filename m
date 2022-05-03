Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0EE10E9E4;
	Tue,  3 May 2022 20:09:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A6810E9DF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1+tKemNX560nAgfgp9D/S8ydQE3HG9HH4dJunVlYgQGNN9zHcRot7QdjlSF0Dd0EgsCzUXoQD7ZGEJelsryT3O3V7X5FxmhtbU9hqHwRKBMA8ncULBNwg2F40yHWSWzjvkQXHFu5YTIu/+pw6Sl7RDTUDtdhhHJjupvugkUs1vvCgV85xxdfhPuCkYPxOJINGApzZ/kjvcALCIlSnzN1xcH2OT8g+YgD8ALehyyanhFYfHb0GUoErTZnIJNaS/8f/aBkFkKEvGIfRwmNvjTZ7QjFZ/eIMwcIH+p68U/6iKYCkPiu7YXhFYBavW+1GKqbjWvXzBOhi73M+m2Cpg4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4u90IPlXJvSzVzWrRIwuK1kZW2McW6dN45ZlUxSNrs=;
 b=Gr2qkUfvWlK56ard33sjr0ukcfw8zl0E5Upbc/s47UUvURyRq3mYH4bZKVWVjJM0kVKqiLx8iMVlBInOp6NJt37bpXnknkxcTLhdrTpyiTuBFtdhz1UmWqJtp+AbOm13UhJhiRjr08ilEi+O6XUrDHg66ikbYbqmUBxqLCI6IKYN5Hb3V7tZEu1PFheIFmByvVRmCiOLyJnszj2eR1Dnl+ZPBg7uNJ6gbpYpDS1vOmzjvejzGKDAomr/MeJ4xEQtqP7PB3RC9lr1P2qj/kT2UNv8UtlKah3a42oxrncoSUmBgZafeHHL4ZBFCqddMrB017YrKuXcHtH28cUH5ZsHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4u90IPlXJvSzVzWrRIwuK1kZW2McW6dN45ZlUxSNrs=;
 b=kAWqaIxyNfQ2pSG+J2FQx+ocEi16NCpV8vZBX56a60Kvm9gT6Kxrrma7P6AjZ4lTGW7U41HrfA9Fl4TR21ivWgjl8uxG3dpBIe6b5JDZDZZfIam2UUXfS9oV/bKZwf/Dbo7hhByeECU0gXVXArmlALABgbAeq9sP3PG9W2YwjTQ=
Received: from DM6PR07CA0060.namprd07.prod.outlook.com (2603:10b6:5:74::37) by
 DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Tue, 3 May 2022 20:09:08 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::20) by DM6PR07CA0060.outlook.office365.com
 (2603:10b6:5:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Tue, 3 May 2022 20:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable ac/dc switching for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:32 -0400
Message-ID: <20220503200855.1163186-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e6d00f6-5f32-497e-2eac-08da2d40c835
X-MS-TrafficTypeDiagnostic: DS7PR12MB6096:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB60964595685C22A3016EAB84F7C09@DS7PR12MB6096.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kjiBlyBwB2HDQ7h03dAek8515ssjwRwg5DfnPmKpoYWKbxnIhFP8iEanp9gdskKztTIiG6k9jwdZRUWQndAjzSaJ6jiwnJMiulZH8nsQsoS4jcfhMADum20txheJXct3lEVGX6rULxetoByhj6Cc6cOhhgsX+Gb+VisBKq5O5sok9iKHEFCxz6F2Tb4OtaCvvQPftMYOdSXK2QHHD0Xb+S5HQT+jZpUsEUYCZnnow34nGenWOehpwCujgcxTt9XNJD9ZJrAiOYroVbRl24Iy2LcXzge2q4SaSKdtMAX/WAZIk4QzRTTVAYkH5VWHun2qPse1CZChlR8dz4CwmaWSGOhRI13kYkT+FL2DIPOcrKJ3Wurq6CJmmTNhAUNsOYN96mYbaldXtpmcPdVU60jRBAubD97oJgp9LIixSY+R1uxagrU1HBfAC4pWiNZcD9PgsGyNRvi1+ehM+kei/VCuiCRGpliAQGjiLZlkmtCLeXGIQ5ytiJojZ1sRPQEv6+EdmZi/KUYxPBJMaCagIv/x9lmJQ7NJu7d5UJZxr6r8vgYAkOPMwqFuEL0ctjFR6kixqp8pTq8UEi3Q+Z232C/jp46qKwnLQndHoBPNLJgMUBkDhkK01gWLX0/j50CDmguaAZvMnW/LMP0K20xGB4YjVpOj93M1FAVpTPAxFjyJS+ccnAQbUkA31pFCu8FsAP4P1YFADGMa4uQ4fD9WNSKTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(7696005)(86362001)(26005)(36860700001)(356005)(81166007)(16526019)(186003)(426003)(336012)(47076005)(40460700003)(1076003)(2616005)(83380400001)(316002)(5660300002)(70206006)(70586007)(4326008)(8676002)(82310400005)(36756003)(2906002)(8936002)(6916009)(54906003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:08.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d00f6-5f32-497e-2eac-08da2d40c835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the ->set_power_source interface which notifies
PMFW the current system power source(AC/DC).

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index f4184ea90e86..2bebc69d6f62 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -115,6 +115,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1393,6 +1394,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_0_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

