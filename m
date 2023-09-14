Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DEEEEAA60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 18:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EFB10E2AC;
	Thu, 14 Sep 2023 18:22:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB6410E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 18:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZfGGTLZcU/emjKyOQi3BWpZpGC2XTrpXHklcaH6qdR+fUfkuJ067CP5UcbdUfX3z8S25TQd3RcKwcDA3oMYvsdNwaBhQw86fNriQ8MnJHyQro5PJDgyNM6OHF8B4rDl3cFzF/CsJ/2kQ5j1Hx9oOWo4W48tMiBdXQed9GzLyEKwS101iRFs1NLWG8BLyBXGp8Y6eA4+BTHkXVbSu0DigAqolH46kRrjWyYaP3nWuPB2jBcYLLGfJ3YuqqnAbSKAleG2CqD1A0INTRXbwQhhVy7GUjAsS0JrmoALYvz08SED+95Q/uLdTjBt15FOdmNWXf951itURlUPAY9/9wKABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICEH0uxHUioV40zUDLDqw8s0cZFXWMjoMv+9/qU8qn0=;
 b=RLu2YWst4GTBhQSYEBzfonE3fgGGHE4dO9vx0U+ZnGHVQYA6Dbuy8gyJC7tFF15F+6y9p+NIdLtLYsKDq/9yEL+vuR0pO5rU3B5Olq1bCDwn8Gmf+/ml4E+NiBVEZ2wB+FnxJRhBRX7Yvz1Fq1ixch1K8qj+/L1AmxsCBVjksbrbiG8jnD+0RVsoxtNHucmVH2QTeJ7PYtUCvcMwltNfWlE5XXTLPanlssaL8r0ho2aMsDwaGV+iIh3EPCQ0Iy+s2HojxeagDHHDZhywtBCiTG4n94AxltXeN8wxzGb0Y06abHBBly4AK3KI9uPaQADrTW45Jwqy6YKwVDZwjvsTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICEH0uxHUioV40zUDLDqw8s0cZFXWMjoMv+9/qU8qn0=;
 b=s8fqAWtJknh2PK0Bas9FMD6tqimBqZVk0uskVPlzTfy9xXkpo31eBbZvWoy5A9QyukKLEAIbgSy82wDzbLbN/Bio6AaP3+7N8sEMn2dbQvPEY4/fqW6Fr0S5Uaub7xN1k4YBGmB1Fc0Ok1nYkBo7ds3ikCL6BZQQtdZjhvde1Xg=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 18:22:26 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::22) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 18:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 18:22:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:22:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu/gmc: add a flag to disable AGP
Date: Thu, 14 Sep 2023 14:21:59 -0400
Message-ID: <20230914182200.679059-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914182200.679059-1-alexander.deucher@amd.com>
References: <20230914182200.679059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|BL1PR12MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: ea81ce80-8061-4724-5e42-08dbb54f8c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKdlmO+kZBz2O6KaNVmtqJtdhzZEoCXr0X+Gb7Lz/6nimAyNQFWZ6J1YL38ezSLlHcjQHBGWBiM6wObg0RUuFQIuJwEjt2ch5ryAkrTQqoRNTepGfDN9wC7C8yvuHF5A+p5cAlCIpRO+ClN1YW63z0qIJPIhA6PnF5AYVJFBdmRZmlywG2pGi1DiDyOu+qFdHeYeUEKlE9UF+If8wZu91wUo6ydQytcvVSWOTWeCPzBqxa7gwriWm0yiqLPcRvI13oyiz9fAhzpSjoN+xWZ+xweOn2AsT6ztNk2VVE6ntxoQaDhVGqnd02bcYxEPmOGzMV7hrgXMOSDjvVUBlHsOzTSavs2v24gHeWGR8Fkrmro8b0pXnM7x6WScAOc6ItDkblKxevzQf/A4f5bMCDbgE5K53wfB8InswVFXCJdEAs49U5BzjSnD9x6TaZittYwjvOo/CoY0TqrJAk+rfgVqq/J6qBtGivpiQgSiceO9pU614cVguV2qNDmr1TA1zdijUCZnki3QKvAAATLaewRJayeFKNEXeoW8WDt2w6aRbNa2IzeX+1Hg8LcBdV1+4aG8t6/Av1T2nbmRU15WUEjvlICuEcC3JuMqku3IGskMxjMUcRAbpuiBLNm9pGTVpAiSG/E34SZJXxRavtK7v2NYUS/FcqDPCNLAAtc/X+wft9t3hTfhc9/LWPrermKEvy1NZr34XQPvzkK180JswG9bQnnbkYUDLtE9Ni/pY7mrcsq7TXOCZavZZlqxlJKIBAR8SSBhqVg6p6m7yyU4mEGArQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(16526019)(26005)(356005)(2616005)(1076003)(478600001)(81166007)(6666004)(7696005)(40480700001)(2906002)(40460700003)(82740400003)(426003)(36860700001)(5660300002)(47076005)(8676002)(4326008)(8936002)(36756003)(336012)(41300700001)(86362001)(70586007)(70206006)(316002)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:22:25.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea81ce80-8061-4724-5e42-08dbb54f8c0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows the driver to disable the AGP aperture when
it's not needed.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c41321c456fe..ed9be37eca66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -326,7 +326,7 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
 	u64 size_af, size_bf;
 
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) || mc->no_agp) {
 		mc->agp_start = 0xffffffffffff;
 		mc->agp_end = 0x0;
 		mc->agp_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index caa15639d3d5..65641d7da212 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -340,6 +340,7 @@ struct amdgpu_gmc {
 
 	u64 noretry_flags;
 	enum amdgpu_gart_placement gart_placement;
+	bool no_agp;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-- 
2.41.0

