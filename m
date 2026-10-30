Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635A606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1iblaFBe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EED11264D;
	Fri, 30 Oct 2026 06:31:34 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B41610E850
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAC8wsSiY87ryYvbXZhUMMO7DDK79ezZ6I7t2hX0zHRaG4FlYmBCvHYsHw6iMonwWNuGew6pvEdO/QSDOhpEksD52wLIAjJpKeDY5hykyyGYKVIc5X5WadFbYqXaMng594iEaTZHscK7WSpIRshdHceWX04+x0b9vypc9lf2s7CVi3jRGbwn1HsJC2CmXWudYYtjdLQ2h2lpIHeFRxc4TUucnKbr1LFC83RVqNFEP4JhbyDWvR6jHtrviSWxGiR98GgYmVaJ7N4lzFEp8QsmjonHPENuBRxEEk1P+wuqzb+JHxg+e7LRgW/dbH7dwkEAnCZGmibh+GXiSanRrFbVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3N1uC7cUt6gnCLBAtUGW8MQA17XJENKNKLprKrUsL8=;
 b=wQ99FMeZL+X/vbK+SD9ipdb/pI7RlOdty6cqqp0G+OMbCrwOpdeIb3RMQx6JtCm/anXhfLBctdZl5Ko5+ePdu0OhD+nUB9lTQprIbWGynrHGtMuORvQ1Ft/8IY+6yrbBPIlrymSWUSNdqvUJEURCC0ohKyVNXokWrwmOsZhP69hd4L0mXLidOPyy6ZP3kge0eUxW9lIfnoQwkXcFB9N9jjCTCFZ3nk70FXv3nClKXk9zLQeAsdrAK+RarQiRee6yRkaa7YV2wLyDNvV6EAEZU5Wlz4lNxR15G+3Onj0f/GGwqHa3qwm/cKyuPMciqYRtGuaznzxW6rOwmScyGz7JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3N1uC7cUt6gnCLBAtUGW8MQA17XJENKNKLprKrUsL8=;
 b=1iblaFBeG7h67zHP1s61ep18i1htubMGpdPljUJuKdBGKG6/CDYoeBgKUJaa6SMEJLzr7l1CkXWHt3A7XVp8CZ0DxEVv3rlXTXMYjixUEwotQ83yj+UaB9u/xF8sThRnt+GrgybmZt9qJN87yT2oyojzTJvI+54U2NLC5yHv6Xs=
Received: from CYZPR17CA0007.namprd17.prod.outlook.com (2603:10b6:930:8c::9)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:31:22 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::2f) by CYZPR17CA0007.outlook.office365.com
 (2603:10b6:930:8c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 06:31:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8952.mail.protection.outlook.com (10.167.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:22 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:20 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 10/13] drm/amdgpu/gfx12: set pmc_supported for GFX12
 family
Date: Fri, 30 Oct 2026 14:31:38 +0800
Message-ID: <20261030063141.2773032-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7522f5-e55f-4cf0-365e-08df364f6a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|5023799004|11063799006|56012099006|261009223027099003|261022075727099003|261021121427099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PPtipUFuHg1mlPOAz6yKO9cU1SSf/KCv1s8rEZr/G74bKXBCw5Cyb/s9nNe5UOe9ssgg7QvDkNrKfZT/TrP+EUu563BQBJf7bWvW7wr0D268r6TH/9GX19zodZbY/1klvf3unLtN30wDnTiiEMoPatMnJI0uijSFzl9Jndo4SI7BqWvpvOwCIXFaoXEhDLcSRt44PSyzQF8xQzWVgTD8kKS9piEF3MLQI/bssAekP2a0q7hsTK8D3WwW8uKCUh3ICI4Q2bGeNjIu74bqjdnxThYUJmPcuDtZgq5wNt6kuO7cBJWQsjUcZLIWL1TWHFHWbocX08IrsjJOSgvnIJDRQWaCyKNek8cs8paBSAEYM9CqdVSXDZdewHfx5QwRYK//S8r9L3cP2WcY6T4VOX10X28CCwl8eP0Vj3BBZ27uSJH5qwqazKogT02NTYa2r1mIo6F8ygt9+r+XlCS8aSlXZjcnNrrAhu+XedzOnZvQv/Fxjb8nzzoJFTzhHxOaEQZwSsasIj8yx+I2RDcSLT2mF9RpqRCBXD8bslDR1ulQoZLiCiVv8cPrIUkwCvvqWvJ/mKJj0ae8PxYONrabPhVDDZZP+CcV6SpQ5nnDX1W+YDrSiGEBXIdjmoUGJ8hslPYPNpTPCBxVXrhxCXUPTT7j4w833EQ9tab19xjSZg7cf8ULqGN2olq6ovUkPahWtAmpKKBg4elJaiUUSfPzxOoXIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRw1M6l32fnMX0iySHmVF8grMfDMNyMo0oT/Qx8NeAXVDseQ/VWqPUkA89JN0GlkcUTvSB/vhHzR+5pDyO4iy74y12yX0lN10Sw4s2LVE5gw1cZwDYOuhI6cZULn7XulnOsd+dP9clzp3Zk5Uh4O+ZNsJGXFgY2yT2Z4rIvrZFrCWgQhZa/UVRe9YSeu4TJoKQu8LB1QzQwAiC/hyWpbVAejScvgYvfsMOw3v9oE0ZdGF49R1tKesL4BFAnOLBxvSkKTvbmQMRQfyXl9D8e+xLXgdODmfXryrOE4xRsSia/B+S0e9iNzOSe3b/JE+H49gzIv5ACSrIwzSGSJhlE63zJpRH6VxMDLU9PChiIPfzSNwocOC6U7/ae0h7JH7Y8Hze+KKCu2Jj+e7XBze5p2vsmCwR9UlBFdHTBnbBERNF3Lm4YZeWsZ1m9s+WM7u2xb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:22.1954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7522f5-e55f-4cf0-365e-08df364f6a3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
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

Some GFX12 models are capable of user queues and have
mqd->compute_perfcount_enable, therefore they
support PMC.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 655b1784860d..fe6e9ac7b170 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1439,6 +1439,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    adev->mes.fw_version[0] >= 123) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+			adev->pmc_profiler.supported = true;
 		}
 		break;
 	default:
-- 
2.53.0

