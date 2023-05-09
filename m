Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FE9C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722DB10E426;
	Tue,  9 May 2023 22:17:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA2C10E425
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJAlBmw1yJyvTV4nGihJmfXkA6d0hxLsXz5ETZNLPIRxgY1SYhX2YMQvc0V1PaZ7pHKcd+SN39J29Sw2KXe6NcQPZ1zP60aEKXS0wCnei0+q3mSkBeOAHAkJQGX1/Bqkmm36bGkmOMdXkIHzw38uBlWlYtBoLF18xbvHT2IYPrFLAkfQEIwOJCvuqHUYDXdJ3alRhQgJHbhuCsPhU+AO0qW2dMVvuV2mptMhgPAF1Wes0VgrWWe6RiBle7/qFltqxw0Az7g6CFd5cQIplcVOtSZciFgPtKY+zE9F+Ela4+2cewiHPeZWnPhiEqaHsF+qSEh/zrzmuG8F1atlfYHUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRax+zLEzjsEWesJm1Om6RKjqIIzze6/LM1K3CJiEng=;
 b=c6HyWfIsivFgEgtyqbKCTrRQrjKuJ5xDFVoO2AYZGWiepij2UB3LG/4kOXbe9iJbCYYupeJXoF+Igpwt5T9YW9Zx809J6uN6C4fJv7nYwSYVt939Yusi7w051lwsyb1m8Q66zcHrqK/m7F1OsZv6qB5jvONmhcQS/UBSXXa1FsrDnhks1OmWXHhrlMmLW6s3gNPYaO8jtEZ/SHZn9Iqrl0rZs28k6CJvgcadNQa37Tjdp8KRezvcqL23c/q6JcKpKMel43j39e7i5KLI6p9AN4sDN3CQWZisK0qDPV+WyPfo2VmTFwtQRDfEqc2mCuQKTGOpzDYbNxUOKTRzzjcz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRax+zLEzjsEWesJm1Om6RKjqIIzze6/LM1K3CJiEng=;
 b=UbeD5TJad0Zqw8R8BW1wzvl8bHRIsMyPwJi7Tmbe1Po6SzhZpFTsDyTtAt2gmxQHvTOHbm1ow/2F4Fif6eti6D4i48LbosstvUkS/EEKEa7S7ofjGJUTCiz/SRBkhG3IPj1YC0vTuGZdNe74UomFQs527PhHrjex+igsEITpw/w=
Received: from MW4PR04CA0231.namprd04.prod.outlook.com (2603:10b6:303:87::26)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:17:53 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::41) by MW4PR04CA0231.outlook.office365.com
 (2603:10b6:303:87::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:17:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:17:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove skiping userptr buffer mapping when mmu
 notifier marks it as invalid
Date: Tue, 9 May 2023 18:17:37 -0400
Message-ID: <20230509221738.477282-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221738.477282-1-alexander.deucher@amd.com>
References: <20230509221738.477282-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ee47f9-e312-401c-7498-08db50db3bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSbNahcGsavsmfPAG2/uexlmEKDUvquN1ww0QlDpatPd+m8PdDtwcM/Zika2/i0ReaXYyis/M7RE/TQYV1lNCbC0a8t4qgqZUvn60qlWwCjW0p6xlcZKjFQ5fl2YiT7Yj5yHqvxF2Vrnqk+oLLVdJhifBfcoVOW5ENQwVpu3po9RPm3w+LsaoBo7DjN57bQ73VlCU0P3yqBwM6MEcbads9g8WgOJNpY/Qb/OvVUMLnhamm++GnA4bJYpjYXriZ2KdAwKeKnLJJDyiq4vFO2/m3PKxx2Q6DGJkmrsFNu5UN8RUG9TYppfHSyVt+Z4PD3iG5+XcmvUSyqT5CuYc0xwg826fgzJFJr8AeTGkSb8f14HZTKzWAZ2nCWGCJ6Q7T3Jnm38FOHLybUyhe86wiFKprMByTq/O4IJRjfkaQNqfA5hvfpz9r/M7kMn8FaW80HB2Zxp1oJgOhL9CKBLInHgMb2NU+g2A11uFpgvOSD/f1Cyxq0/RlvJUBjrhsR9Z8Yyo2VQnBiytDwBVRsr2ZvcycTXgJwNpmkTWDV0tuvOTUHKd0Z4JFA8qgOwy6nTuj+iD8XRHciuE2SdYLew3ZtsLWtbOCDFH8sdhP0Z5pPA3WV7p3Jiiqnl0iAkLM+KW8EtLl1Ipks0TIZLmfqFhKqaXz2gikDAKSFg3wHYm7nv6d4QjYZUAupTCsHYKtrkkk3fxkRYcFXxmMMEtZUG9IG0KzVdvwezuIk8Cazb24k9aUhp+/dx60pD/R9ghirft9Li+waiVF3f4eXYX/IWrbTl/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(36756003)(2906002)(70586007)(40480700001)(40460700003)(316002)(86362001)(8676002)(70206006)(4326008)(8936002)(5660300002)(356005)(6916009)(41300700001)(81166007)(82310400005)(426003)(47076005)(336012)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(2616005)(478600001)(7696005)(82740400003)(54906003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:17:53.1302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ee47f9-e312-401c-7498-08db50db3bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

mmu notifier does not always hold mm->sem during call back. That causes
a race condition between kfd userprt buffer mapping and mmu notifier
which leds to gpu shadder or SDMA access userptr buffer before it has been
mapped to gpu VM. Always map userptr buffer to avoid that though it may make
some userprt buffers mapped two times.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 58a774647573..40078c0a5585 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1942,16 +1942,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	 */
 	mutex_lock(&mem->process_info->lock);
 
-	/* Lock notifier lock. If we find an invalid userptr BO, we can be
-	 * sure that the MMU notifier is no longer running
-	 * concurrently and the queues are actually stopped
-	 */
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		mutex_lock(&mem->process_info->notifier_lock);
-		is_invalid_userptr = !!mem->invalid;
-		mutex_unlock(&mem->process_info->notifier_lock);
-	}
-
 	mutex_lock(&mem->lock);
 
 	domain = mem->domain;
-- 
2.40.1

