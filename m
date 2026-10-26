Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C06606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aUqWQKXX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9260210E2A0;
	Mon, 26 Oct 2026 03:21:14 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D620710E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlmyiFjQE3HliJ8kARBdHKl2mCMKDT52BsBbR4SAnPuuHjjP6jEPeoqlPp3yy0K+Lwn92phntrtZB97gFOITWE+oUZSgqgV/p9EHeoSjJ3+AYlN+533EvA2A5BVyr9jLqSrcP5LYZmAcMN7y3eur9yZ7mQ3Pf4B0x4Elrb1kOPLPXuzLPd0zsPdv2chRA/cIXtwVOof3Pgd25pJJ7uRIOUA/2eVJaYXaQxbC2vbcllYZyX9sQO7qCrtL2qg6od80P+bMCQE+hmDylEMjp1RnkHFKIONJ6dDVPK+AXahM1CkkNfx4SUrfmQmW8vkfBQ/lRHW+hdTJy3qh0bOl0ho2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcUV60E3cPkzpyawBWt+YT4njTg6NGc4xNHLzUcHeG4=;
 b=SsNeM1guHuFvrOWuq8Q8XxNXiYIQhyD5yTKWtowHaRxjTJHltV2/BaorRgSNvlNZja9Tc/e+5hrMmpD0/zuM7EJdsZZTi/8EIayOY90hgVL2sWG6K9c1tTqBQH5CrVWEV/yCVYsGaxRgswH+Xd49oU1v9+P52wV1XUih2uckqG8t4+yYQb5kTcxu5lrozmeiOhT1+2NZj4XueIPqmD/gfPH48U4jO2yyxwrIkpF7lV4ZDEUR9W7b8MpyksXz3vcY4g1LZUAWj5+cpTnY2FvwiISEIdeXD2HHXDjn2G2R3hOxMPH3RANtyYBn6+cBqB/hgKVB7JY4mtTHAb4PszQBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcUV60E3cPkzpyawBWt+YT4njTg6NGc4xNHLzUcHeG4=;
 b=aUqWQKXXsaTfRSt1DCuUJ+QlSegpqWuh2RKqGvmw/KT7kW5OdjbOrqqUslaUeQ7KjO+c9P95wii50s/yViYSamxq++piTbsRz3Teni2JrWPFTzQc0WIEK1eg/9iqaG2HyeX2ForITb8lF/AfYATDJSCKvROiMNDKBZAWJq86++k=
Received: from DS7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:259::13) by
 DS4PR12MB033229.namprd12.prod.outlook.com (2603:10b6:8:50c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:21:06 +0000
Received: from DS4PEPF000001C2.namprd21.prod.outlook.com
 (2603:10b6:8:259:cafe::11) by DS7P220CA0080.outlook.office365.com
 (2603:10b6:8:259::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:21:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C2.mail.protection.outlook.com (10.167.23.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 03:21:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:21:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:21:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:20:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu/gfx8: flush the scratch register write in
 the ring test
Date: Mon, 26 Oct 2026 11:20:19 +0800
Message-ID: <20261026032042.2266892-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C2:EE_|DS4PR12MB033229:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f89554-620e-4c81-6bd5-08df33102c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: bkjSW4C0kISBO6PL5K/ZupQazsFIziOKAWoP/MaEkh9e/OQcdlJ5oRj1L+fIzp9kcDikKSgwyZtFf4QGOdstTeaNDgglLifX8zI99AzAPSg8HQ8RumOUngbFM3rzxk2vhBm4QCdvS5ZPBHiElON6WU6GJmQMnZplleyQNNdavIGfNsxoePkyXyzQY1N9jweV0rmzh/o0L7Lt5phWB3ZhosQny1NQgFdWVWLVCDZ9hFoHV12UgKfq3r2u53YGKvkCfmGLcvhIKERb2+YAqkraS3nyrNiUa+13qiX30fW8qaCg8LrRojTZ1QLFwYf6P5gtSRRU9fsDmcXXTmkHSsduz3ZLzOIwToBMsA+Rhl8U/Xrk7/jamNsvlEKMa0Svuoh2E3c3kEZDPiTgx84Zsh3vPGuenHnlujpDuYlWLXzetjDAjbEuE0XQObaMkfHMusNXQSdFAxWMxTl+LzwB0mVpql5zSGXiWLaLKoyMPx4NNzzGHjItk3z6kkIaJ6v75Q+yohE/SNiNQfD78SULssBV7iARWIm3Qlviib4S/er72Ef7ZmSsGGZkoGV6xQAfUg13pBsFsM4lquYNEMc1kAC/ej6YKMpbhUhNHHEdxmyhKvZG/A1BnhLLzR/9dOg8aQoQwcySLXC3bAE+JTKrz2bla+GDByFShsEeueek41VaLBAEa6O05k9vvrPM62XWar1Tnd5/AwwCwuSk1cRxKmMYNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YZtS4In0F9qv/QNDrNzQOtevWDJHKr1CqeJb7bFaUa11N63/neSzDH3KNF0GHFocR6z8sGUF0YUy1ke5mCt/FTyCT5p/eEPPyZ2N8+gQrIr11vTSx6UO+8ZFzYy8LVsXEfuY8s5PZOqtAFsPfRUqPDjhLGY19mc3wTWK86dJAVjf7+q2VkM/6SrUIviJ5I/dbh4rPso6AN6w4XvnZj4dP2f+x/PfbVMi04Q5KaUkD75ngw+HPIZsBdvhFICkrISZr4/gGym4iM44A9paXgsQnDeXw9if3tEyMQ1jcKpS8JMsEik2GDBNTBEQ8omOaNkcFKB0xFQG17P08t7dMiKlu8RHeZdfS8QII1+GpQZQodwLkv83wyIh+aEkSigrzTnRcgLnKzaBDqrfiEHStnuyp/3QimNw+J7hzsLobKTl+wQW5Uipo8OnfsvmNUIgaLvt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:21:06.1543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f89554-620e-4c81-6bd5-08df33102c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C2.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB033229
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

The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, then has
the CP write 0xDEADBEEF to it and polls for the new value.

Nothing orders the posted MMIO write against the CP's write, so it can
land after it. The test then reads 0xCAFEDEAD forever and fails,
although the CP executed the packet. A false ring test failure in a
queue or pipe reset escalates the recovery to a full GPU reset.

Read the scratch register back before submitting the packet.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7e2f9c13dec3..4666aa5b38c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -843,6 +843,8 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(mmSCRATCH_REG0);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
-- 
2.50.1

