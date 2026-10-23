Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747D606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CoP7nRO0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17356112A57;
	Fri, 23 Oct 2026 09:09:08 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBF910E604
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvaFmR1eLPxDfTFur8rawzpQEzvAGEvAKrrCLm6FEr4WahQpc28EI/6jkTptAllpeBut6JmLtCkxncd6QYjb1a6F3GVbnR0GWuIKbRFNCnSVSE1+JVlYvqtLWe1qh0SLu3zEbkdDOaj0GsAGywIemR5udYubmxd9wOhGNZpYGVpu06wxSFp6dHEAx2dNLg75pwnwursV9WNbX8EuHw48eKpXkFxvCA3FHUmpiAB1NIf+yPCqVmD2bhy5RosZhIf4LXPOlV/ItXLZ//Hg2fSUlaxZZ1KqeuT688OKDHjoq7FofMosdiKlgm8t9JSZUtD/nHijJ0u3DoTwG4kX8HKmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0Z32EbXET6q6gK0Oavae+f6J4sN6j7wTHoQBaqaCVQ=;
 b=PXWpq+Poik/ldAUVuayzRWLJWHBJ/CtKWz5w2MvD0vyCLq6WugaS9I4+TdHt48QU8eh4ZbIV1iT+RVT/oQmArCb8hFieoEitDHlKeOxWIvSkjjU0ZKS5cC1U94kcOZVo+N1FiI2ZvUlzlQtj7GCjkJxECcNyoKLhMH0GbhtYeCBOQXTIVs4NhcrzNrQ1boB+vIPG5eUWOSfdnXyM3nR3TAkBx6KVv2ONiH3qUeD0PgQ6Gi8N1KmYlAlZubFno0klUeQHvNYu/rY6rra/tNdIiFvGf3D7Mq2mAfikI3flQEz3JPEXK479w7Hk0K6fGYnJuQxBYc0MS2ciX9ZcdiaQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0Z32EbXET6q6gK0Oavae+f6J4sN6j7wTHoQBaqaCVQ=;
 b=CoP7nRO08z6oiZYvFACnc+tlFW4wV/sdRBDF9oWiCzASNuIpsvsncgna8eoBnA0AyOg28QaNElRQwPno00V4P429P+VFkKoTyfmgARSvLhe534T7//V2B1nnbye+GbqK6kicmor4j6s6pg+uhvsovzBUtXbQYXEJ3bVW2gmmF2M=
Received: from BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::29)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 09:08:55 +0000
Received: from IA0PEPF00000043.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::25) by BL1P223CA0024.outlook.office365.com
 (2603:10b6:208:2c4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:08:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000043.mail.protection.outlook.com (10.167.249.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:54 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:52 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 08/13] drm/amdgpu/gfx12.1: set mqd->perfcount from mqd_prop
Date: Fri, 23 Oct 2026 17:08:40 +0800
Message-ID: <20261023090845.670581-9-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000043:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a10095f-68ad-49b3-070a-08df30e54329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LK+vv9yPnUJkwIunLVLRPP2n6ukgaxBRbjWzpCieYPbN9zOPCz7pfF+A+NeyMQy8N8zxCYP+gjwUhhNDp5IWxVpLyOxe/NvG8kIA1hJsd/9sQ9txiorZiIK/ymVxhD9kkdIVSTsF98ZJCO1PtSwmAb0/gi0XCc4x7RmUW+Uwea3PJz5Ro0hiVrnYgnywfDtFzUBOuY9MFPbMKhGiZgOtcjbpebI/w8ae03fqM+M1KwGWKI1xCn2zhBPKxKMtd61DJfYNEBhhSKuTA1RioVALwkOcRLqoQhp2BULQ5kr7gcB5KnUCJKdLc5qzmoUyWZkEOy3Y6MD4CIDBXhBIRuQnaNQHk+lpZ6HyEKws57XaFjmgcfoZ767F6SORfWYkUHT78vqgAp6bYP9xbmoIG5/syN2LmAtn6deue+asL8Ht9O/Ouhzfx8NqmM6Yf1vKV5w3RuvYR6yQNH2Ug6KqvigjcIb4ceI5oSu6/60V8dJmbDyxHrwgfA/4UrdnEzPAlTlHWRzpYUoqT8Yds2ZdPrntAJdEU2M3nuKs2caAQ0LHfqij6Zb/J/vy9apkktjqC0bNs8KTo34bJBd1PcFopvGD1hbwR82HOowlCvsnQLOmbfzFN49ZA8o/7YxBG62C7P6CbRVDKrDytyqC9pLdX5jsiSl9LYMh2PU9QHYJ6s+xGhh5RZ6LgOYOShW2V+y5Cpynluvf15kekSAe5kTC8BYAkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WfYx0dvMPy4YtJS91cdmjMvI0GsMW63AWwy2KF2NIOkV+ulCY37C92ZPPOVQMk8i5jDURWHSnfWcnBSsP2wwTnNmS83sF96iwJZ985DSg98ABEdr3j5Q2aSytwmLSwH8i6a3uyUmhS/ISY43jj8LVns11JiaZPDHOpeomu1CIMhLuFfXTsC2Gcv/m3/oqXf49p0ELq1889D0RVKFTtanBLlz8luPWefFPKIqcZfbENvdaKlRsLq9aO3dy+Lq7nbvJ1jTU7jFcjNFzNdAwzu32TcPHkinvVMDFUtwLl42dQURnf76drIFMsiw+vuJ1PGhe4DEeNLtU8xxdqU/BGJqJKGTl8A3aC4ppc01r5hadvL+GnPeVll9WWhRqgz7fL65MUz8rBcnQJH04yLJHbngBXFsVj7PNx3vDBuvygNzBqjNm4kY0QaNFxoDtjcJLI03
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:54.1957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a10095f-68ad-49b3-070a-08df30e54329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000043.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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

This commit sets GFX12.1 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b19a4956c222..b1caf97f4166 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2170,6 +2170,7 @@ static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

