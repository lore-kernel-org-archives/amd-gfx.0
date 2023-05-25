Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA690C7EE2F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 17:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778B410E6E1;
	Thu, 25 May 2023 17:29:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA5210E6E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 17:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQVRi7THpSnxo6oZgL7Si3KEAIHbskKGPZZEuD90jlkHTgTAS0UJ6whUl6MO4/f6KlecU9C11mtSnqZVvQ2LPG6P2G7+Ju/KATFygVu1ApZFGyPv+QGG7TkXGvVnJJZxVGNm/nvmJeBGQ5MjRXo49PCFlNIIvKsHKtH2CWwDa0k5BpavmZnWxo+Gu404wehMLl53YC7aAMDXnlJC1N72POiRPANwuoa+z8Gfy7Yni8xv6Jr9+la5189YvJrj4tqT/oEcVud5zRc3b3huDMWRIB4w1Tvdk/KkYd7iFvzIZhDkXxfuvhhibPLrErquuuhVkIyCcEdEmSINChZ7gUPwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI/LZK1xKa4iCAqWux4Po+MWckAZSfJPLEB+pRvmBQs=;
 b=ceMapLwsK7ni00FPNl15PibW1Al4VmObuPM0a7rmSTby3TktBXtKAcva+RTOUwoBrw0YxPwdboru89/RrPSD1iz0TgtTeTExK5Asid/dsv8T5RWJxX0nPOqViGTRZOLWl6tuEtTbOT+JtfgPvJ+wlY1mG/wpaxOFAzFhGZJ/6NyDGXA2vtv5m0Ip2zCp9Wljzxd0NXnbIVOHg3qe6UmoL36TBikJTDmV+WrCuBFppXjvTjsbdvrR1S0hSxm/hqUtChhaw9NAVL08psQgjNg4921Rhy4QBw3omqfvirgfUv0SHKJeQ10vcLFmHxoF4NS85mL+VDJbrt3ABrLnODgZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI/LZK1xKa4iCAqWux4Po+MWckAZSfJPLEB+pRvmBQs=;
 b=XjM/fi8PYikN5PzPslQ0bn3HjVW+7nEtU+1ukBZ0xbK5Rr6g022gHrgwKipIqKfaFQjPLwja1GMtpQnN0Zj538s7ylwJoJa6i+7DSecgRy3CGuEXTSFwFf3ADssBjvqumImsU2GnZvGysmHDz9Bw5HW0yjAyLV52PRGZo/UIdLo=
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 17:29:09 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33b:cafe::55) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 17:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.16 via Frontend Transport; Thu, 25 May 2023 17:29:08 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 12:29:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix up kdoc in amdgpu_device.c
Date: Thu, 25 May 2023 22:58:46 +0530
Message-ID: <20230525172846.818521-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 384506b2-20ce-4dc6-051d-08db5d458c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGVcMMYXYiJS4BQC7QESpUizESmYUFiS8JuNjgdbkAOm2Odp6iQvP6fOSEjdl7Ru41lCRuoqu1VNOhs3AYFCSsoM/6Vw622A2VN+rhHzwOjG7IeN3kcQ7P1/bdR0xKgqNulg5H62varTSNeFmJAL44KvaEKMSL0YG7Gez/7PIKxj2oR3ESmf/04g1Oa5Jpi1SzjvW0lM88uA83E1OaKyafPmT9zQOEn2V6P7s4KRqUTc4jROBLrrcNpHc/JTiEOzVtf6NpAZjanEDCGbOE/ocRmTwg+t0eBiJKxp3/3D1ikjEQsZIDhymf156V9QXxivtrnLlcwb8qi5xzbSOn4sGQEzbPYIjFktDk++TWUWvmr3xMtDCJIr2SfR3FHbMLRAgx0XcmGHucru9lcftwgUdwsmAy66yUORBJ5PA5iZ4EIzI8DjxrEah0nVEhpuTXRDJlTdQWW1by34/SmtSrFrZFYQ/6q7c0sgeM01CwWQ/3/QAIQQXNQUzzF5L0LtrQhv9/MyK8RZJYL/N6MhRQLFDYMfcsZZpQPKeNkgLdXFWRIbgfYqFIOhO+JignK0SiWdvczv4/APebnB1W8eUFg/NNJvZyz4b5oygEPUDXHD7RiIPYKVixyMPBAXDrqFcLF82Daaim0SP5CUNZq/hej4KGHRZ0c5MkE7S/ilTHMB/IDEyyiIrP/JiP21Dsuao5MeWZbI/O0Xtdtexk/mxHtlpZY5YkyL67MYad6e8aqDdBxwkgKAnayHXbocx2x0o9CCLMf4XnyLOGFCIC3PljbjNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(5660300002)(54906003)(1076003)(110136005)(478600001)(41300700001)(7696005)(8936002)(316002)(6666004)(26005)(44832011)(70586007)(6636002)(70206006)(4326008)(186003)(16526019)(40460700003)(2616005)(2906002)(336012)(47076005)(66574015)(426003)(83380400001)(36860700001)(356005)(82740400003)(81166007)(40480700001)(82310400005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 17:29:08.8037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384506b2-20ce-4dc6-051d-08db5d458c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix these warnings by deleting the deviant arguments.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:799: warning: Excess function parameter 'pcie_index' description in 'amdgpu_device_indirect_wreg'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:799: warning: Excess function parameter 'pcie_data' description in 'amdgpu_device_indirect_wreg'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:870: warning: Excess function parameter 'pcie_index' description in 'amdgpu_device_indirect_wreg64'
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:870: warning: Excess function parameter 'pcie_data' description in 'amdgpu_device_indirect_wreg64'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c1e9ed26b7bf..301abfb7a0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -788,8 +788,6 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
  * amdgpu_device_indirect_wreg - write an indirect register address
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register offset
  * @reg_data: indirect register data
  *
@@ -859,8 +857,6 @@ void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
  * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register offset
  * @reg_data: indirect register data
  *
-- 
2.25.1

