Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1445AC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7726010F005;
	Thu, 30 Mar 2023 19:46:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072A210EFF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApUmk1RsLBzwd7IijfF+NjAYdfFuoc73SaWDfDL8aQ5D3vIrnc2YK2fLmAf+V+M3YAXfqrtTgkMCmKyF/HjIplhVI6nshq2n/qFOsUtA9dWp0HgYIlMuvTkpMKMPsNjRxI++tuRsR+Oxe1Z49qF2fZjs8gfCYRZtNBHjngcVB1BW/B+8H5fMVkZZW7xX+l/lMcqLjbG4vWZXboLlGs7dBizaUD3cJVBTf0CHn4WMIS68ktNzt8nXI+s/bEVKXG/JL6/90vZxMZbYMPH8fujgiDUyX2GTeXbOdXKviP1NI40wzWHILNe7GLRmozO3wwIVMPfC5XSCsWuFPCW+t+49JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkXwAL9Q4p5/ynsBa+XOD6njFMQI4IL3oLvzZJcq9iI=;
 b=jcRUt1I+0PiqCvrnFwDjp9fRpa11juBIMh5ctHp/Ka0hnwTgyPlJoygNOibGsAdxja+nYGTeKtcjuaFckVNfw6IcObaI39AO2sL4nfxPErkcum2t5wJKXmYeFAKeKshN5hxlHIxQZ037v6fRJLbgSNWFEpYWeyTvyVffJUuVGtqGOqd5GGg36M4cMbTnD9F0rUQruZw6XXIG7A+gAya9Z5gFpoCVwF4hvdePsNAZXcbkAOFFySt/LkwncgIGk5N5AmWsUNedv6iMn536HKYq1Ad09LMW1aNK2AY+VlifLInv9qQrPS9XRG+OAufCOaLYJURnjYdQfH0ZwziOPQG79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkXwAL9Q4p5/ynsBa+XOD6njFMQI4IL3oLvzZJcq9iI=;
 b=hpTpsoY/ZaQwZJhrgmc9DobYEkBucGtZodqiqasEEahGT562Lo5nEntv36AzqC+PkdjOBy3n9tCkpVw8zaBSIdw/YYr2fhIdb236xObj2caMYQuKcH2JRHsd3Ct5uYXF+10sL/dlQVb4Wj+nYE3Hh6sj3xuGkN9KmUVeguEeSmg=
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:46:02 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::50) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:46:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:46:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: Remove SMU powergate message call for SDMA
Date: Thu, 30 Mar 2023 15:45:44 -0400
Message-ID: <20230330194547.1135862-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194547.1135862-1-alexander.deucher@amd.com>
References: <20230330194547.1135862-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 010617d0-d19b-4c57-55b2-08db315764a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MulNb8PuUSrJvSsNHvd8TbPzwpHWSLWohBDFNKHm5+30rjXNYvxmHZihMHXlxxcwA/b+G8EGx/EWBKttaHKtW0PHg4lrD++vFv5U5nj8QEJffp0FA5fP2zGOU15A6t7vmonTjAGMB4vwhHBo6ABzYwi4N+L0s7w4ArjqEk2lag7P5MBUh+t2YgIZNmtwf/j70sTnZRqRyMTNKHWXJXcGZP5J+wFvceS5+gWODXY/nViKGHNCgc6MC1wP2ByITaNIJ+F/zZt5NzX/xi1Si6t0FJ/9wjTYvNvr8P5Fla9K1xoY/GBj/Z++1BRIwM26dDpTzjTQb49SQoiFa7FcnH8Jg7eAFgbynjon/Y6C/hPb+kRkRgp9zaidXokgOQncvImvnuuZKuCqkr+xAB6MlmvlcP7gnvwLCYCKiz0rMYi+opdQEDroZSMMc8O7auQAqepdTeBL1FQgP+s9jTgUPm/xHq/lPfeKIrH9ZarHaCyyn00zRL/q9PpPlNcUfZZRzrFd/yb512NYC4alMgfDXc80v8hKfsXZHjhmNUAuXvTfht95O5NSx9lNvSEkO1/ReMOutaDu5k9iMaCIL8Vm1lxZAbqrLo34rxNIHe/lpDCLsnUu4PxhhMgv5mQ6IJWgR3EgEcOTJMJ4gJ6oqZctkJ9EhoZYytI5stnSKfkTnFlZ2JZZDJeLGzxYIKaeMavI51krjQEH2qViJICCo/iuHTJNYZ6hUSzeCifQhF+5r9giiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(82740400003)(81166007)(8936002)(356005)(41300700001)(4326008)(5660300002)(86362001)(40480700001)(36756003)(82310400005)(40460700003)(478600001)(6916009)(316002)(54906003)(7696005)(6666004)(26005)(1076003)(336012)(8676002)(83380400001)(16526019)(70586007)(70206006)(426003)(2616005)(186003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:46:02.2748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010617d0-d19b-4c57-55b2-08db315764a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
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
 Asad kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad kamal <asad.kamal@amd.com>

SDMA v4.4.2 doesn't need explicit power gating control through PMFW

Signed-off-by: Asad kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 184eb7902722..7c91cbd91ac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1398,10 +1398,6 @@ static int sdma_v4_4_2_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	uint32_t inst_mask;
 
-	/* TODO: Check if this is needed */
-	if (adev->flags & AMD_IS_APU)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
-
 	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
-- 
2.39.2

