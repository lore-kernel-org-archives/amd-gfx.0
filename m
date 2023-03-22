Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC8C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 02:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CDD10E241;
	Wed, 22 Mar 2023 02:37:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC9410E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 02:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2XxlKk+E1FHg6P/YvON090Fbpf6PR6IOwWEa5j5v0nME7wRMyna1xOJnOYIVpjw91Kd6phimtqeSffuoAGyFT5LmNVCkbWByoSaIxLW7uB2EpZrAbv8CTekb9FE1PFesLuSnenrrpVA3oFWV3hb/nYZnXQG4FMaJ0BCCNhL5NY8i4XC+lp9BOug0N0DacQq5CGy4iMqwz/omTcdetBlxGzrSCtIwkQ9cK138ns35vpSPbmMGyxVfam/nI00sFRq9ECV2DfnfElDGyz37h89jTUG1uGzgCvsZ/eWY39rOkPnh6dbqkg9A8h/RpAWYvlyRiN9OTHBvwdzrSFzN3G+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uyJpc29xePVyUAz2JNlQBcDb3otqHTYSCqupOQZXoQ=;
 b=TVxXZ92iF++jr3lbHJb99BHXyd0cMb8sIL12iN5r0TEnCNqA11zLZDRixRbpsMpmKxHEOGA9dIoOPhopU4Zd4z8Gf4J5Ml/Qh0JrfUjAgn7OK9o6GXqhgVC6pIJutKYjiXVYMTy4Qmblp3zw9tLPbiehl0elyELBW0dYXbF03+RksyPSgd1scB83+p1vFIYMhQEu0amDqxd73+n7pc+0IjWiWn+fYJZdm48cIDRsx4iOJJduUCyAGZSZhD5/n1WKVLcFuZfXmK0jG06hG7ude2jmomGpOjc8YeTeAQwFAEBUHaxBFGfE47goFCs6hNjrppSkzEgF48zn5aLIuFJcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uyJpc29xePVyUAz2JNlQBcDb3otqHTYSCqupOQZXoQ=;
 b=FicYCRDC4t72ufAMxyUpuHhXdAI3JNhu0kUVl22hp04sT33JRsDKeAE3qKavRwQRi3hCfqxSlGP3JfvcME9fvraPwuBV8joKkhzYvZyVBodODLflxvTTAkdn97qT4JWwSDhH9uViBSR6zr4Z2hFv3/8NLHDverrfgWqPxZq1jPY=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 02:37:46 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::45) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 02:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 22 Mar 2023 02:37:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 21:37:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 19:37:44 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 21 Mar 2023 21:37:41 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip unload tmr when tmr is not loaded
Date: Wed, 22 Mar 2023 10:36:55 +0800
Message-ID: <20230322023655.337567-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 044430ed-da47-4b45-1ef2-08db2a7e6b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 019YeqUeBxZdV7ReKU8OJ6vimAECGNyAWfw4TpCR0zLWWjA05cIoW4MvdZje4Bx7EIpL54HpE1lviXlDt5n2FsioSEHFClKm8BIt0Q8UGg5ue8IGnmFsbCODbqvBwgnQQvFOh5ZaJBtYBRkFxmQwRUFNsACBB296F6pS7f9rpQSe5fqhsosRH+E9vLZj3oiHhGY+v5DW5rgV+xkwOebXh8vyPBv+m5P//kRZkdPO3FIsRqSX12Rsib4/oyLV+B7Z3eP69GYamJu+PR4K5yWsn9pGB4WxWaCORd/X599t6RCka1ECpGsTmvsk7KnljKdu8ax2dkqEeIAV2VewSpQl4rT/qeIK0RqjUsD1gGZPrq1/hCSJrcdkGtYy+d/7PnZ9tfTHDSXUIQFN1wJP9kkIyhTi56VQRWAt2JMlJKBTE7DlFGT0c3anfxgxUU+Uk1F/V17dLikTy3QKxYlSALWEGTPUtCzuu+szUGRifrOqlw/DP30UyeLpqMm6uv2QBO42OFsLHpntID+gMKH62rPaMod/UEeQ5yYJXHlPIGH92O836qde3kg2nBpw4cEwnuTw/THp8tK6NB8Bb/q+ofsoJcg3CIcn011JWVzSPY7xEvWZFkQoUvuS3a59Z9bDGYaKQhYALUOFopE/FzZV8Kbd0WplM2kaTVMlaSUxj7DrqCaEHfrdo5x5BIUjU3EFxAKC3YAbDyAcylE0ReKo/FnltbMtVmOeuFJoPNRvrgjvduI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(478600001)(316002)(54906003)(70586007)(6916009)(8676002)(6666004)(4326008)(70206006)(186003)(8936002)(41300700001)(7696005)(1076003)(26005)(5660300002)(2616005)(2906002)(47076005)(336012)(40460700003)(426003)(83380400001)(36860700001)(82740400003)(36756003)(81166007)(40480700001)(86362001)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 02:37:45.9465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044430ed-da47-4b45-1ef2-08db2a7e6b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, guchun.chen@amd.com,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tong Liu01 <Tong.Liu01@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
For Navi12 and CHIP_SIENNA_CICHLID SRIOV, TMR is not loaded. Should
also skip tmr unload

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b9e99c35a05..0a3d9f7e277b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -839,7 +839,15 @@ static void psp_prep_tmr_unload_cmd_buf(struct psp_context *psp,
 static int psp_tmr_unload(struct psp_context *psp)
 {
 	int ret;
-	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
+	struct psp_gfx_cmd_resp *cmd;
+
+	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
+	 * Already set up by host driver.
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
+	cmd = acquire_psp_cmd_buf(psp);
 
 	psp_prep_tmr_unload_cmd_buf(psp, cmd);
 	dev_dbg(psp->adev->dev, "free PSP TMR buffer\n");
-- 
2.34.1

