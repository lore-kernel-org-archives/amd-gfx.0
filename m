Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B246606A32C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hZNSm/uH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1284F10FF81;
	Wed, 18 Nov 2026 19:07:51 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB08F10EC78
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY4PgMiwb2qKLvJs6DOpClYQxMSf9+JNm/56LYkZ8I14TYMcCNWRAk3CSyqMFz9ezXQdUcy6LBaF8dD6mAmU7P1VCMNhmCqcJHZY+yxQS0FIlZHL/PiAoZOGgxco5lMWNvA5pVLof0KyMgo2fs01d6j+WaUcsT2kSgXjDfL41Y1j6lLHkdps0sDIeKkUNCCW1n/jJdsN7Ml9hwPp6IULzrVTdlw10d99+hDJ2tb9KRLhfJSW+9JtGYQNlDlqU9pPlQPlFuPU6Q3zEIlKbCL13ua7T7nClXt1dqAyc7dplzF+fOWDsT3We5LxwHTFq10fX1OqFT6MQXR/qYYdtv6pTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEznIVEB6ZgYm2rEMXdt0KWSzPYjMYx9X/KI7CKNA5U=;
 b=vEhBQl/hy3RK/V6dIY+/CRtDRpvH8zdwqYxRr+RsiUScCmuFtGEYvAKRunpL+ih6CUolGXtZlGa1aiD5IT+3k3aDS7jPBI8zCodZ6KU6TexwtjdFh0iPQSVX0eLArhQ6SXTglTLdRdARGJFVzH4O6NihF0x9ucJ5c1d0hhHLgR7veai1u5ErJYj4TEjQAkZEGvOFFMhBnTMJS9Cmrcv3ihlr++wITsmqZZq1KpReoISvB86g7E3afGdt8BgOhqGdFYSXUT6iQEw7/HBeo0ZWogVQzCOIw0JFcoUT1vSve1L7Kjf+VTkqktDR6OQxj9p82bVN+uyfDF+k5BSkYoFHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEznIVEB6ZgYm2rEMXdt0KWSzPYjMYx9X/KI7CKNA5U=;
 b=hZNSm/uHgTU3rYzGYZgbc7BdovPwFmBwb5/SKUI83JvpRR/Aqprxs+820shVMVG89Rr+ZJ2IradTVH86GH0oWBxwxWxxNKVqgwj4Kczb1Trvmp7w02dL34m0ESrKYYkCcj5+K1rIbZl4GMRYcA3+wwmVdEKHecdLU/LKj02lhyI=
Received: from CY5PR19CA0036.namprd19.prod.outlook.com (2603:10b6:930:1a::27)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:42 +0000
Received: from DS1PEPF00053453.namprd04.prod.outlook.com
 (2603:10b6:930:1a:cafe::1e) by CY5PR19CA0036.outlook.office365.com
 (2603:10b6:930:1a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 19:07:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053453.mail.protection.outlook.com (10.167.23.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:41 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:40 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 04/10] drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES
 for move_notify
Date: Wed, 18 Nov 2026 14:07:29 -0500
Message-ID: <20261118190735.1863676-5-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053453:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ccc6fd-253a-45d4-8f0e-08df45a73840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|261009223027099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261022075727099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: QxH3E0777pwL/jtNKC/3cjUEJotIrTuewsxmxkJZ/RpYWxB9Pn2t5RQgmyxrBtWBPP1uBGGFgmGRIX9tpnpi3YATblIhCg9FrRz0x0X+9fh5Hy4QfhR9Q+AgEY2EHnfPqLqc7shW9nVxFlML3BsuOtMid2op4yuril3l6JNRDrUGNFaAnqdOimBsX8ILIrRkpke+Ik3GxungfHkaG9zE0nWppj3fjz9iaUoK8v3LEkFCH6zntUco/kT1L04fkIGCBBd+DTLus219IoPp+crCcaP5E3mMbL/TNw4TmTNeLqTvDPz+7hLdSz3tVqeTdqCNM1hh7PPDzjWcLvDKnp6REKdyD16QVD6sRvo5XCk6vBl5sgx/9bp+iS/jNU+mQqEjuXVBNssKjZ+6J7sfsxXq9qhGZQqhZyiHJ4QqPUElfWM3GryfCdN1X6smq6YfO7ZbMRRo8rERoDnKGgv4Nqdh4iVDyDNEj5EKsperj4iG8rJAJsYo9dtJ9QJupaqefjk3J2o3LGdVyD5RCiUs99FtLbiTd4q3WroLsCYUK1ALgNmjicbyGA54oyol8TqxmNtE2iXrPxAz1pfcQC1bkfz2oIURb761xkLOSEfZ8AqV26bYfmoHAJ+ub0MmpIguyRvSfxvzV8ZcExcX0wW7J0NlOoE1jxjrp2avsHE5tED0UsnjfUn4Gp27ER1HoOWSkuxlXEbiV6ISMFXqVJRU+t37kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(261009223027099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: npYYxqZjxvCbmp3mqhPanz8H85neIRdNNMPMm3K5OxWJQGsr1+o4uzUjAbQDWAwnMfvEAC/d7hl+PgQDmHK+kbrA3OeRlqW+zFth7CzBeeZwfTj9esillgk7ZA+yjltcBNw28iM3AwrzohO6WXiEfDh+G2TBM5i3GjRh8OoBh8SmWB6obpri5Xs0eUOL4wWbY1/N0FgCO0t8phDTrzaPq8dJihyHMkqOP3wUNzGgHq4bT3qzE2XasZegnPAVB2Dcvp2F/2VVKRjrsns4mbFKqbZP2uSQfJMVl84ZoIEOT6t4z2Pf8H2Q5H+6pdH5eQSsjqHTEbqOt6jZPaTc1kNrIDo1KCNQyMf9hSMZtFC2Kp0kL7UuMaR4I170dfqCyLjP+bm7550sgQx+YmshEgkKgV80psmsEKhrDUlTLFTHLKAepw9ad4+wnObF0cGGIBtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:41.5094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ccc6fd-253a-45d4-8f0e-08df45a73840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053453.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is about to update the VM so we need to use the macro previously
introduced to make sure there are enough fence slots.

Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 7b85152d6872..d3a7cf9c274c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -562,7 +562,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 		}
 
 		/* Reserve fences for two SDMA page table updates */
-		r = dma_resv_reserve_fences(resv, 2);
+		r = dma_resv_reserve_fences(resv, AMDGPU_VM_UPDATE_FENCES);
 		if (!r)
 			r = amdgpu_vm_clear_freed(adev, vm, NULL);
 
-- 
2.56.1

