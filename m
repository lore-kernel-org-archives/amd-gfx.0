Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8AECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB34A10E97C;
	Fri,  9 Sep 2022 03:36:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8338310E97C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cja+cPMtWQAatB1Pszx6LEzj779JgNYNrOCqL7rQwnl9kztsr0oTMnO0O0LRuRuVZ1ZlHbRS0LVPlk5uLHLDOlQRWu48OxXhIjRroAExIsyO13Xqz6GgdQC23EIs8ZfII7BLyt3v0neNnr74bg9XfNE/TAVpRZ5qrF1iqaYxEsZW9NklU6AZ6apoer63VV9OBIPpafGm+dowjMEulkK4Sl/2gOY4VKP4He0o3S1T0mLX7/THKqD/Im6/XuT/XLLIzB+p+DP2PjldF7o/YO7AwAKZ0rsbLCXGejZ8pqfEMwAHvnBcV/JFYUS747bPj9gtyPTpmy9zy1O54GujtaoSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRPLqoOomLwLP8+Nca1huY/FKuh4brxbrmWwleZ2B1Y=;
 b=mzjxwPz1KegYEbzlmL/jpoBGLI17/tOSfNgYu4yYHy5GmufAIYnTyY87BYeydv0RoMRe8UzW+YQVjJHbqlMpjzlNea8TE0hCB0yQlav5at2GebbVkcRb3eKsCLxK2sLdJNmk92ULA2joM/by8WKkpT6Jf9IkDdCVKJKPlp9p2EGNG73Clq2bfYBy1JhbABFBuLdYcaRRZ+8LAFrczWv8uJ+dxi4HeRCfBXfscjkN7cLivNYImy3AKN76F3aF0bOWGFwJ86JixYI9YURYQyexgemYvMb8OEX8qWCdL9BmWutssxuU+PEcv6zC7pSduLKjxYiuZ5EWJM/d/AvNO31ZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRPLqoOomLwLP8+Nca1huY/FKuh4brxbrmWwleZ2B1Y=;
 b=sP/8tPLm5eAx44vp52ccaFFyjoiBotDrHgvpaVaaxcRbpiB8D2v1bSmW6LC5GH3dafDYMQMfzJ/U4UkevK+Ci90dUmcit2YcmqqXqwOqhF4TNs2z+/mJJxpu6ZSV42y55GsZoLE5jJL9vSzSVZLKIel1dILHN0HbarpOVuE6J4g=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 03:36:20 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::53) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 03:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 03:36:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 22:36:17 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: change the alignment size of TMR BO to 1M
Date: Fri, 9 Sep 2022 11:35:54 +0800
Message-ID: <20220909033554.3600333-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bcca4b-c84c-4481-a7c3-08da921475e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKXYWtiV1CHkDTDv6PS8SgH2yVlMwye34MRZI5ljXFwQfvP8GHTrjnTbtQgM3q/c7cFV+936XBLQCT0I4nvUVtBTBoc34ncwfqTYeLneozvTG+CX3+xD1zHkyGNS81wIWMnIOw26h8vciEO6vYi2mjabUDXpKfw4Oc3qjjv8DpGDL21dJY1qULdyar7P7a7HICZclEje1AyQ8EE6g/x1uF+V7xHp16N6wF5cDcKfp3p07Wb54GzonUpLAnGyQOJTz1PxGw0zQIQhzsanWzwvJ31123tT2t7Iu17LpPIJ+6iOcnos7guYcartMjifA9w6m1WSfrZX5/r4zFoMyw0DKfNevbm2AzvkytlAriHvlw2wMXJ/FcDzOSL0kOiGpkQJ7CPFS5t9fMQsh9B/nm2RysFMj4J9fM/+RUiAjWm30PqLognMom0ATmm1n1jf7lWvogmXS6SL1bdtLsT6NtEsnUgVvK36DKlO+j5fccIDAjoeh1RPHCwBIsGNYtvzOAlMfpJ/FyDJF2eexbOzIUPhWUlVjM/ZqGEA5e2LUprByym7Tq5vsizOusKsuAPUiESDak1C8dFJ2vHxqiMBZZmBxM0VvrfsjCp1bdqJfu5qhGzJvEpUAxUwftMKH5BaJF1y1BYAoLWHiV0/Q4Phd7iUZfk2Tc5cNZ7f3LAAIWrfg/sASBinph18SRqmBqaU3s5oj1Oq//BSJ/EKpctGK9dtB0EPgXpJhf4JYacMDBXmju7LiNW/Lqi3af5izDnxePyLE1oagplEQvkS9cFT3wjMZOcMabHP3103mHhTkAWn4YMzZLNcAOuGEJ6I5pyBxYOl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(5660300002)(8936002)(40480700001)(7696005)(26005)(41300700001)(47076005)(70586007)(4326008)(36756003)(70206006)(8676002)(36860700001)(86362001)(82310400005)(316002)(54906003)(6916009)(82740400003)(6666004)(16526019)(1076003)(478600001)(2616005)(186003)(81166007)(336012)(426003)(83380400001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 03:36:19.9432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bcca4b-c84c-4481-a7c3-08da921475e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688
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
Cc: Yang Wang <KevinYang.Wang@amd.com>, Hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

v2:
add new macro PSP_TMR_ALIGN_SIZE(adev)
to add ASIC specific TMR alignment size support.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cfcaf890a6a1..8ab4797ba204 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	}
 
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(psp->adev),
+	ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGN_SIZE(adev),
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c32b74bd970f..869675c9037b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -36,6 +36,7 @@
 #define PSP_CMD_BUFFER_SIZE	0x1000
 #define PSP_1_MEG		0x100000
 #define PSP_TMR_SIZE(adev)	((adev)->asic_type == CHIP_ALDEBARAN ? 0x800000 : 0x400000)
+#define PSP_TMR_ALIGN_SIZE(adev)	(SZ_1M)
 #define PSP_FW_NAME_LEN		0x24
 
 enum psp_shared_mem_size {
-- 
2.25.1

