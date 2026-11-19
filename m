Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB28606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MJR/0hLt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C321124CC;
	Thu, 19 Nov 2026 14:41:13 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD351124CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2Sbq+NesULOHa+3TnbV0Iqi4iW0uTLqCOr6dLxGMlZHbqoJMIzxBCPA7Z/77GCewfMdyy6lOnB9RZq3lj3z+ota4tqdDJ/7S8nnkWmOPUyRXaK6Va1qkLwBkUq3lVYqypRlhsL3UQqJDvWqEJ3Ns0Vw4SVKXM3jesdAovg1dSE3LDF9ix0QKvTJL6IUxrfc00SBM5fPXJVemZN2Xo2KSV7yFHsrADG+FXDBrimVyE2TfxxXbgHdhvNHRhGfOX59WQVmIZvP0EPQQLkXH0ORS0aKyWek+U5h92VzLsR+wJbxGeq+klJFyKmQ0glrFrEr23f62O3yx2nJJCwRuY4Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BagkvzkNNLfyDt4ALAK+A6f7WpbHojuB03ddpvX0lI=;
 b=rCRbv8onFFOKSqlohPwKDdpYNBHPDX5o8ngncALNzUxNjPcY7+/J44N4Az8dETBsfRTd410cAngwIrwG5nkQnohuNlSbrDJ1Lr0Mm+haZ9czJ1HEIi+2LTL1nHudiiOnA1Dys1oDJLd5+FOlDExXVWlocXHxRolBYhy+tzpz/kWBgXXHf8lXlPxD5wJvzIFZS47HHUw69H+IQMESdGojQrcqdkaSFxdO4O1glvE4MfZ7/k1geeDF8vu+rWhPD0C3kK/0dNnTqocfemmmU1kbQ1Jkhdt9u+yI3EiEkfe5cF2eSBQnuiyihOqZKgHvzKaSU7ysVUyJIdiHgJmNY6ldaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BagkvzkNNLfyDt4ALAK+A6f7WpbHojuB03ddpvX0lI=;
 b=MJR/0hLt9+DPKkIQ+lES8txhL22xxOvsCvMTbuCqnQKTsxtfziNKZ+HPbCtP/9jpmxWmA9Tz/qBB4D6d8cHbA2Rb6b159vTA/8yfmSh1V+Jw9rcwbBV8sjdZdO19ck5sRCvP2Gfidp+Y3MOrH+wXinmCS7q//duEZD+lGRG4aXA=
Received: from CY5PR19CA0126.namprd19.prod.outlook.com (2603:10b6:930:64::15)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 14:41:00 +0000
Received: from PH3PEPF00059618.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::82) by CY5PR19CA0126.outlook.office365.com
 (2603:10b6:930:64::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 14:41:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF00059618.mail.protection.outlook.com (10.167.243.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:40:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 08:40:59 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 08:40:58 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 2/7] drm/amdgpu/gem: reserve fences on the VM root PD
Date: Thu, 19 Nov 2026 09:40:44 -0500
Message-ID: <20261119144049.2057674-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119144049.2057674-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059618:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: bf59eb81-6a04-456e-936d-08df464b20cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|11063799006|4143699003|56012099006|10067099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uZ7RW06AD1kFZCBpo4ZOCogXBywRnveUoPuMh6NJPdkks9XsVizIZXQFWaYFXVAG3qcZF4t6QoKRl4HL/CjpXbvv7ZYkGoig0DYd/K/QEfha4ZOdzZHdvQJ+AeF3GV+FXyX8MKxVpmT8vEGOvBsFlauEAoscGbmEXuRpbX1NiSJ3wICMcTC1TGC6fedpabKM7kA4JWGu2yjY+CFfjT3cBKRLdwVH0+Rm8Y9EO+v6Dc1VzDP23IP2KHwV4dd9n6hriq2aLNb2tSOit/ksd24ACw6+/gZNlDPo01xYCO8/CC6Ta97NAa7NBqfyfd4yj9psOJyUvt2BvWAiG3+WBE0/Dosln7KJUp+5OeFvrPa0AuMY5JiBD+Wv6vQOJDiD4Hh5DBsav1Egetzewn66msTSwevKJ49WWEvhfP33sQgtwCbd8Qe0dHvtCiNSZv/oEuIKilJ7X2kli9YYB/v24WjlYXUnBSApzOcgzVYRwRiSDMBFFJT/mu4VApdT/dewldQOTxh26Ubh/wtv9F/P6cClz170ObTbX8WNzgBoGydNAHbMqcB4XwsXeKfgU2t/ADlt+OVYLvy+gQFrMoEw+294OWNFTa2td6y5WwpIn3bFjNNtdd3yxjee2QYGo9chvAmuG1rhxXNNdnWj6ESJmzYZxME9TuFe2M+DunP9Bui3q/FtUNpuPalku72C83nJBS6sjD3T+jAcqUOT0XcNBqkIcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2j+ZjcYmpRE0nBLUgDCx00i04UpDUd2sH4QQvbypp0ZmZaclAf6nuFfnYiWhIsNIi+CeECYBmQHa+Y/uDDvNMOtp+dZen2BwQsu+QJ7BGUvlDqEfwDaDHX30crtHsioIXhr58Rz3hEgzjtmZaWwBEBpzVDyMEaqt6pbZJaZpQZ/Qy4x62Nr7vVdN4BiqjoJVfean9SKofiofu0xwZOLBH9bMe8JrjlZj2m8cSLoMW8cc30C9+lbGDoefbeP0tjXLsjn77xxDzkEnvxqCvP1B/8j1hV27TOXw23/cfusWoFb7oL26c7Ggg6yCnGCtoZV5dpcbLmANNuNNu+ui4ZorpPIl97Cr6bG1two5p36eQ9ioYXXHav92TdGV7UwM362+1EH9m2GHa7NO+zLmtZoQL3WTek3Qc25dSH3W0AWXFJwUD3mkVbJ9rMCUo1jmWxb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:40:59.6011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf59eb81-6a04-456e-936d-08df464b20cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059618.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

When creating a BO that shares the VM root PD's resv, TTM eviction
fences are added to the resv, and there is another fence added for the
BO clear job.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v3:
- Christian pointed out this is most likely only a theoretical bug that
  doesn't matter in practice so dropped the Fixes tag.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9da7ae6b9ef3..eb7473ed9e0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -504,6 +504,14 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			return r;
 
+		/* ttm_bo_init_reserved() + clear fence */
+		r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv,
+					    TTM_NUM_MOVE_FENCES + 1);
+		if (r) {
+			amdgpu_bo_unreserve(vm->root.bo);
+			return r;
+		}
+
 		resv = vm->root.bo->tbo.base.resv;
 	}
 
-- 
2.56.1

