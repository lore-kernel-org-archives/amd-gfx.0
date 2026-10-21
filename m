Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F5606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EPguJzW5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB52710EC44;
	Wed, 21 Oct 2026 05:10:52 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BC010EC44
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 05:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVF3whjmeTXbj58K3734TWeLEH0wHWG+pbEefLI6uOaevaBYA/u0xzJtsjzwjkEz7kcofYO0uWkrNMDMT3Yv60Io3Ja4UKV7XpmclarCTqqHJeVuGx8iSRfj3Moe3IfGMxODBgHRfNxj2+ouiS8hm3d3RC+UcUa+Div34wqEH9oaKKdoJs3vcsl+2zZ1sB8Eg/apPPfQXJYTElmkoeG8BuhgLMW9nqAbIuP4GfaEnKbKuYx9W4ihjFc4SgBlQYx2PQ7+h390hu2kejiOCHCVSFNHzg+MZNCh/xgZZFkq+LZGeM7auE9HTQmA/syF0HU5cdqQpND76xyFckn/tHnUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz7tTR71hWB1pwFRliT2pivrEzT3aOg1w9yE/ZdNYkk=;
 b=qAoAbj4SRXGVJUdBLGy9Jj5KsOso397JlTabK3zqqaRwkjEFtx6mH2qIt/FlcM29oQCZgtDWUXV8slNLK0Pb7E/HS16qQhDY7kld6IZHgHXbOVYx2nEDNT/Q926Je0xiS3eyYHbo3K8SBKmY2GyG1pcUzrJZ4jmsraJp90slXj369SFprnWrw78ryoobfmjwiQzurWdt5a5cPUuGNOyhEoznAwgxK1ogBCqYmPOWg8cYMF4gwiHv6otPUUj1G58SyBo2LeCD5f2uqVjGH05jjvYnX6F9pUgJkHoP4OqplqZPTX5/NH6rUeAPO91RNueMNYLZd4wjcWR+JJLink7jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz7tTR71hWB1pwFRliT2pivrEzT3aOg1w9yE/ZdNYkk=;
 b=EPguJzW5WIokoX660wTnNEve9sQQ3h/4M7bI4C5cnNWJHnVvcYBLAFPtBJ6h5XDUQUvzMrDi0MPyAWvIKBho6dX97oXuFfwUroxdY1eGzrpGvcQqPr3fIvGm7gUmB8Y420gJcoB2vyBdd2OJdYx+GDjlalDS8BGqFKrp9OJelZw=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:10:40 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::82) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 05:10:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 05:10:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 00:10:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 00:10:38 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH V2 3/3] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Wed, 21 Oct 2026 13:09:59 +0800
Message-ID: <20261021051033.3287259-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
References: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9f5996-162a-4c0c-8158-08df2f31a69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4wfpbG9N2RUtEBdqXmtonRVXiEFu7XFQUOG5JhElTah99UWJRLEYlL13Dfjh8woZCVHmsQqOqZn2Zs1cwjKdbsAEYKbpfX6ZBvKTqGQ5XsQleVt4ROdDwnyqxTVpB+sH5D6CKN4AZUZGyCd+L8mcK1O84H6r9Hu7Vx/yj1ZsMxYQ6CpN0ZwQy/xqdIkZuji7XEUg23TmMqdsPABJcr7XMGlK8KTXtdLTx6RKFu/GyVKtfTx7gBEroOrhADowgE70kTO/GgAo+AlFPz4emuHccE4HLpdsiH4/L+qwCs/ovmPvUqwotnpVbuhhFIzDDgadw/RK6xmL/5O/3ixgcQC4tPzlQntAGVfziW25avKHLdN2OxzMkfFBL+m37P96akgRgKZN5W5UfS9M84+7bUtNu39VN15IGqTRd4wS7+/RY0wqJfVbINfsnkCNPtSv0ApQd4EZqLRZajVFdaHaMLewWBO+Mp9mf23pflgja3lv27KFstbnLGgspFWlIl618leZXVAFvy8MnrnazSMUzHtEJaKqqp3uE5kasi1vK3PC/5CuY/9jub7sPAvo0UP2tlJWiRAy0vALDAp88/hHpj3UAMnKwoDJmlPc5a179AQBq3lsVc/iadell++Ll9JBs+PgYW9C1D/bVdvvh48zdAEFfo8azSN517T9faVwz5oTicgGH2xvbJ1dwAsT00Vcq44JEc3r8PCXvJPziG6L6p/3yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WmV4/L/yiIH9wnKRFMmovPO9OeqIRgYggnJkj9dQTOngLgfIIPhoXpn3hXDGMHGkEzORXTnfIOPay3bpX2l5kDpA48oiD/nwSaEMuS8Ig3MnBSAM8A4xcjVMk2MYNZyKnWQi8D9TrZSqvSMEekjU0SbK85xqWe48aQs3h232nqAmkAvpDQzRSVrD0sBf91bGCM5UyTs8qssHCczEXgQ79qUJNufvytIAPxn2P86TI1CFpuk6w0fvfru0aJvCfvHLDkRkIF1up1QnvOhREEsSfLfZod09ZiFxfzm4hMoXu34ojta2OOHV3Fa4utCBUUgjbfDvcSeVfoKwSnGMezNSk5FYrBdbLdF0Pan9v8myJG+eKkkMJAaPXkXTaFhLsRYfaCLlyK+oGhNnYiecNGYezDF1JcBGu/kTTJXDi6NeoSwM13rydYFT4mnE5HTfqI+E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:10:40.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9f5996-162a-4c0c-8158-08df2f31a69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 62758866378e..7c76d8305947 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -221,6 +221,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.50.1

