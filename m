Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83A606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XSyRbWq9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EA410FF6C;
	Wed, 18 Nov 2026 18:53:00 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2E410FF61
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv12e39Zek6aDr5SKSsfBxdGtrA3H9jP4gejH1nT3KsGExWwdvCJPboxNyCSqWT00SlAPOO17dyAVoE980JAuaUrXNmWTSsZqp/v14CLyn5I1KdSRUrexaw5piLOohQIw9xIC9ECmB3Cr5WFyxYhWHdu362okLG3r4S5nohte6T1sUmilgPJukC1W6m2wFJ+sUwoLVIXxZObleIZ9c6H+10mpaAa/o4BtCozWQdMduDHvHNWhmRY6pg2hPCAg3oXDS4TfvKCOrX6pZ6y8Lp2APCvIWGt4oKwm1ruTJxNQ0YzOmzXSrD5kClF1vNCLiu7UZ5vVdK3djySg2cUhapXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEznIVEB6ZgYm2rEMXdt0KWSzPYjMYx9X/KI7CKNA5U=;
 b=JjW2wed0GFSh9QZQZmqA+qA6i40GiwE34j/Lzk6gZhg34/gycLb4pGDjtAL/apnZGilLTOWMd9Od91Vv/dYh0+ip4hzsONAvfhn+jcgQcRABWMY2LRImsCsZEj22u3qsVhlOAdrXuMkFjRLHYGcm7jlXYPkJ75SShLOiyttDwnmosJ6WPY5Z4onfVk/x6CoqlsObepZ2Fs3MC9VDTZv4fL/7mYT1xrdS2R70wGx6q2ndo78Lp6JK8H9Xp68RlCksN6kQtTrEF9YPrwjFuZoRsnYq5m5bWCq5AdnD8Dok3f7dRFWVRjAUbVCSzTWXt9eJ/N6DgpGg52lRLT5ERYUMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEznIVEB6ZgYm2rEMXdt0KWSzPYjMYx9X/KI7CKNA5U=;
 b=XSyRbWq99AIrGE8Togz9fRn1hkinCKkqiUugYMaoX1p1aioiI81FC6oAmqoQhSRd75FVxbOrwAZ1zymQn5OrZG91uNFjxQ3SdAtrlC35ZU2HdUyfr1/pwp8cY8QiXmGy3Uzr0DRuOsnik/odPbz9gMpnkj6prHiH0XkCzS7zEyg=
Received: from CH0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:610:11a::13)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:40 +0000
Received: from DS2PEPF00006E1F.namprd05.prod.outlook.com
 (2603:10b6:610:11a:cafe::2f) by CH0PR03CA0351.outlook.office365.com
 (2603:10b6:610:11a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 18 Nov 2026 18:52:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E1F.mail.protection.outlook.com (10.167.23.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:39 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:39 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:38 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES for
 move_notify
Date: Wed, 18 Nov 2026 13:52:19 -0500
Message-ID: <20261118185225.1857845-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E1F:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 51566c94-3c30-477a-bd3b-08df45a51ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Qe1j4JDsjan0d/bWWwJi8sdXWD9p6+9tFs2Y3T0sMJzNcpsZ/hdjELkS+oZLL006JTdMxIC060I7MbceIHdZFr68JNi6G6wnlPAnk7D3oCg5l7hrls5pYAGEpzJSNNW6+A1xdTp5HsDkYZZEs8tOwAjKNFQPE6suW7VXwbWgjOdwx+SPfybnbhfzRMixTxhDs7Y17b+SGhJs2Mp7gq5u9i0ykjrIyHAt6e2VLQ99Ni7WcYCVk/jAt++PLtTvjS0TMUlJOZQ7sQ/G4j+IgIGJwLJ8jX/3hg5PwH17ca8rRrxIgjHUSlAoHtIX7tc84vPP426e4IlMmq2jWLMjl9TeDhd3p1dpB8ZlUlF3cLUwvQOaVibaOhMyc3o9IhmY4TOvJVIqsubtpgrFjVcY2Vb2x4sTrlJR4DgJnbEtXmkwdUaGwhaN6zB0UJdDSr5AaXlxjeLMZ/ijgaw0JU911moKBE/HmzTxFNuEE7dvqT8laPuqHCIZyFzI1DFGMA3uNYJV1mwsL5GfH4SQCD1GfCtMaKRy3JyZzyOF/dCmwpaaBM9zwyPH9MetKVXLLyM9TywzGN2fvHOxBV8F7VU5TFFJ4qKf89yqetCqW9MkDYfrgXpblwcpd5he2thzLRTwZ8VGXEY57akjKgX3aMoztfoIPMphr5iOzbZ44fq/3ysTlkOwpbEerg0I+nTIBDU3Vl9uRqilPCtN6jbe23oiKkslwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VFpMiV4n4bePWlE7J7zrF6gE9H8qQc+ugehQI6ao5JLJPmyOWM8I2cPL5xI16puVJTPKcYsmwk5nm4nI1MQoifd3R/Og6Pw3OKxybXYBSgixIb4QYFHg14K5ab+sxB2iGqyqEK5nLY1fQodSOxPBZ2vRse4+PTQ+XiJRssRH461w6jLOZa93HLBHY5mLvnFwLD9Wd6rOUdTvYEpY+rQXItHUYPO/F1xv7TSLJt4NFl9NlKR3Epv4uGLmPdsTC/n+mgGG0GSGbEwe5r4yo+04b/nACHHiJjgcJ9RRpIRqqF0rWzieQQIBq8UwbB1zLkIHNBczQCr9I6qhUsDtRzKki1qiM4rV1rkz8Q5nHr8o0AoQbGpjLyLeM+1HWkCYEa1/gQ3yCSPQTE+6uSlmMmIRNtabe+uDwyinAmaD9u0giPNiZRthaEu1bb1kr65QO5XS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:39.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51566c94-3c30-477a-bd3b-08df45a51ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E1F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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

