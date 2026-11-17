Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02744606A329
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 04:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gaoNMTJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920BE10E3AE;
	Tue, 17 Nov 2026 04:21:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2859610E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 04:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gaq2J9RW7DonURzPo1WyHNz1eD6VnHP4GspPFPpaCQrvtgqUK9fWGRDmRXzC0F4elO5t3fQ9CsTblJTKAO94C19XO7Acq02jaHNM9dHDnGAhZfBjbexcB16Gll/UolLVRLwjSXAwt07Zddcna6kehJPogfKruHIEjC+dd3T0QWZGH7blO0B6uKGNfaOAIh2xunNmeRjgMl9hpU165H3KhtgFHZQ1x2nyjFGGcg4KTrVjsboNiFH9vdvbQX9CEpJO+KoKHp952IR1SyMSyEQq7yE1JdK5tK1NioILRhCGPl8ChvG+hRbHyHqQlq/Kze+FD69wa98IiXM9Caut0CQ8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR1A1SzI4eMUjRTsZdLLrN5BIFV7szzm/lY5lRlVY4o=;
 b=GBOpGgV4vPIY3hQtX0r5b63Skh7sV+0mC6ae9u7g8ASsHX8AfBqldeO6GS7MC0Bqn99AwcrnLy+MjyK+4ErXZDuuqBXbDCENy2I/3qag7vv6oUg2QXqiy/qXfslMLH1UMHNPTEIqkE2BFd3XlfJkUx9yeDUvT3qljx8qYanrsl+8BfI1HnORp/HKtP46HlFXB0APHGEfFe37DZsymwh5bF48Us6iLn4R8j4hv7J8dr+bGmBijFTaDTokRWvqo5GZgYVEXs8oDX8PC0dEZF1zaMg+qSKlCi34/EMI0ccI1bR6NEFkTdu3IvO8Nspz70udUjcepTe3CRqm/5CB/E3Dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR1A1SzI4eMUjRTsZdLLrN5BIFV7szzm/lY5lRlVY4o=;
 b=gaoNMTJOMnDA7rjupu3GQHE7OBgy8U47Gr2q2YckxvSUzOMhA0luBMU0Gk1+S3KW5jnrJIqkp92TPD+iKqoEDBbdbe5Dwj3fX3RJI6Zv1ljs5u3EdjKW00tGTQbzN5ycgJssBVflyLMB24AeN6lgGunFaJX7DSBUFOjI4ZwnEjI=
Received: from CH0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:610:74::31)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 04:21:12 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::6d) by CH0PR04CA0086.outlook.office365.com
 (2603:10b6:610:74::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 04:21:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 04:21:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:21:11 -0600
Received: from junhua-NucBox-EVO-X2.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Mon, 16 Nov 2026 22:21:07 -0600
From: Junhua Shen <Junhua.Shen@amd.com>
To: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Chris Freehill <Chris.Freehill@amd.com>, Kent Russell
 <Kent.Russell@amd.com>, Maneesh Gupta <Maneesh.Gupta@amd.com>, Denny Iriawan
 <Denny.Iriawan@amd.com>, David Yat Sin <David.YatSin@amd.com>, Huang Rui
 <ray.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Honglei Huang <honglei1.huang@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH v1 2/2] drm/amdkfd: honor KFD_IOCTL_SVM_FLAG_GPU_RO for
 read-only SVM ranges
Date: Tue, 17 Nov 2026 12:20:51 +0800
Message-ID: <20261117042051.768201-3-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117042051.768201-1-Junhua.Shen@amd.com>
References: <20261117042051.768201-1-Junhua.Shen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8b2fd5-6aef-43f8-b8c5-08df446236cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: euOz9Wcys/oJWGBVav/xEiYn48KbTWa3vxf6X1G1tHweBIrtF0LglH9HOFCOS/Yp/crXmzmgLq4Z34pvDoq2LpMSOU1Jd7MJDYCJ//ynEAtsmpP65ze2T3i8DjmASubvfAmHUQwExOueU2f9dGTlSMuyXMcanGgLoMdQBUhjYboAPl1uhSRqHMY2m+MlDQvVgKKR39sA0K3H+gHlKXRAE6K+pS7N+yCF4ZAPEpLiLct3I65xWKSj0UatSED9imfw04iZfxxMxptue50NYRMIiQCMBOW+91Y8R6BWmHBjLHJxPbqDktuUj3QkU2mTJXXa9k2v2cblfNQ2EAeF+hpeK27amY/fNC3KiN57CMLSS8ydOcyG/oQ/AQaYJxabOCxQkuoHuu4PchjLmmVwLaO+oNKFyz7PIsJxnoO8+i82Tk/yK+j1ijfbFOnADjeE5OfhfOLW05hDV1qye7KwlzSGAWJK0md5+40B3K1SMCy9fyCf1ekRCu7c87cR1d074PdNbgNOSyTrgIe63eEHQFQe95pquqmY7ZdEWUMDLbpV5spAuy76S+uQUpZkNiY9FzWH1M2bo4N/1cnSRr1UNgFqkwdQaXcP5rkZGFiHdZXNBiAWPWDSaTAjheohj+rUEXB/77mxh9WVTK/mj9nGKrQbwf2JnUHaG95gsusqlagYZdvIEypspByfI9w4fjzfWYl0TqXSGYkRCAp14P4CvWW74w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5ueXjzmCbC7MLtIROzY+xNkv03w4iIV+gVIs9kenmI+B6v+xaOG0WHecwMLTy6kINHIPQmzw/f47jf2+HLXQflQWMdL/E1rHg1I0xAdbBXlwINZGoXo6VurxWU6f8fQjvapFG4+BunWI9XApwcUGCClVRrl1QoUL2lqT6uiqIGBVBNgt+OK6spUei/ZfQUPNZO7uZ5dLEsGoL4eHcONeVY6EsC/PLRARaiTdsAQPA7g2zg6OKE/5/qWwcHyzQdu17DZpFji9ogrFQnPcPn8Ids1v2QRTImBUviWK8bzQIbWuv3ble1ZI66wY9rAsXhXzDAlPFqcYrf9/n6uNeZYhC5w7/uCsw0yOLMxDNb1z85nG7G9GEEbYluNXmInUV7Ivxx4V/Nq9VNe/q2m4U8ymvIh+p87OoEhXTVe0RLx+SS7JLHk4KqHWuWrN6OERPgls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 04:21:12.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b2fd5-6aef-43f8-b8c5-08df446236cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

When mapping an SVM range, svm_range_validate_and_map() faults the pages
with hmm_range_fault(), requesting write access unless the range is
read-only. It decides read-only from the VMA write permission alone, so
KFD_IOCTL_SVM_FLAG_GPU_RO is ignored and the range is faulted for write.

svm_range_get_pte_flags() already honors GPU_RO for the page table; honor
it for the fault too.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877b..1b94b3b6d069 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1840,7 +1840,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		vma = vma_lookup(mm, addr);
 		if (vma) {
-			readonly = !(vma->vm_flags & VM_WRITE);
+			readonly = !(vma->vm_flags & VM_WRITE) ||
+				   (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_RO);
 
 			next = min(vma->vm_end, end);
 			npages = (next - addr) >> PAGE_SHIFT;
-- 
2.53.0

