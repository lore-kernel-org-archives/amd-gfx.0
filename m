Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA9606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DxPkJDcB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4432110FFB2;
	Thu,  5 Nov 2026 03:06:59 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF8E10FFB2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPDcFveuyBegcaohsXKdhgH/wi3druc6g5xDsDvQI8wxyoocY/A39FxDRjf9HrdWvdWnNKqqjjd8Ax/PHsfzbLa11JaZ6crdmvOuCAmgh/39r03mvwuptbSzx3IgS40EbM5uNPtDh4jn1uywEI3G/3SPysGXG2qe7w/QfOSurWAZqiFmgbGAb80J3HNjXFp3fB4sONLxoRq0yyNaV51/e6aiAM6Dd9SjX9zijTHxt3YRVzehsjluEGAvs8aLTuvLg9xV6tD1MPqbvvXgaDzdw9NIiUJetJG616DH7XrVEl+w0Es59crj74KZjbENkKNnLGKzVhGD+dtaX2ysrXt0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NPoU8TjKI7hduqR4XZjPYjFm1oG6wqrsHxsWM4wfXk=;
 b=SzxmWrR7OWtmYym4KORGPUjbHnqq13sVinttOiKTkQFYzyNZ5sfD9fqysL8QXeXe8p9jXG3yIIjTKDBGGs3oO9rK9JoDvZ8SOJ9ixTYrnfAZdoY7FPwLRBd0P3G4zQAV5MHtnb8tdcocLvl8IAQ0B0kW9kucv3Si5QPa1HvHYH/ECPFM998obIcqhcxspDyAG1DgJ32LhmDbNP2xd3xdgMIeszX3ctQyQPnKrHsq7cFYh2pf5jJJNb+GVY9HyU7E/fUY3KaSlFK0O+TbP/DywSccseoX3Y4jE0+Nowu0TUKILKrqd9C8dITNKLlk4UrbeI6QfO+fAO5DmJrfnQTibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NPoU8TjKI7hduqR4XZjPYjFm1oG6wqrsHxsWM4wfXk=;
 b=DxPkJDcB+/+MD8Jb9yAmeDj2h2ZOLmFVblM3Tb+etJEgrFgeeVHcjm87yGV1zfe3v6Whm3Qs0kiXjOWJvs+xR3jXz3DAZjwhdZukfINLGR1ipTXpkapif4uxi1exDPFSxcMuLdpK44CWRdK6AvT5UTP96nhooQBWvCOtNCA+o4Y=
Received: from CH2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:610:5a::22)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:06:48 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::f) by CH2PR08CA0012.outlook.office365.com
 (2603:10b6:610:5a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 03:06:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:43 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:41 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 12/13] drm/amdgpu/gfx12: enable the gfx engine soft reset
Date: Thu, 5 Nov 2026 11:05:54 +0800
Message-ID: <20261105030612.726542-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1642ac-51ff-4885-ed47-08df3ae9d4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|18002099003|22082099003|56012099006|261102123227099003|11063799006|261009223027099003|261021121427099003|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: NJOqFn7PT2wmZ3iz91XXTantM8rDUALpGgYONLA/NrwDYGu/vzaGTzWOMTPnbtf45pFIbbRWpqwM6cLaAo4y9C1VEzRWlM8fpYEjTpD1h71KOB32JS7AQ0+XIij1Q7d/XfYLCmT9I/r9hY3usHmMLh+BSoDoPcaW5gOuI73KIdQkI61wfRwdYHVfjQ187RuWi5cQtQnbe9DZyjtDOccCj75P0XxsXp6vmYqJ+zdYnR93ldruzSX7R2U727qlLWZdPSxh4d77qhnnC9lzwJBYduT61kodL7ZD3PT3LqpJm0CGKxd3qlIhidaUskQyT1kCI61eNUb+eCmGzgsg/OUuVJQ6GsrFJ2pHbWE3SNZuuxHEJuUO/JLrTm+7c9C6UbqYNbqwgwWSkoKMP1KIP4iv/ZH3DvBhI7Mou87aiTm/OVIGaDlx21n8aQU+2u+P/uVJLyrSOlREPj91uoNuF03gUACy/dIwT3Mu5dNAOEw4nnKU9X9ULAEb/KVh453ACuXmghwU1VZA/6v3MZPfohD8e67eGMKo2uCbxt3PYGPrqjmUu0gWwPIeuliMq7TRtFI9CFpX9D6d/U7hEXSbmjdE9V7R0ylWMu/wm1O4LeEkkYPAoVutNj4Q/6OpkeZegPsNO2yzlQaSwCsIIUOaiSN4mLT19+HqM8V8RCBzaizyXZh3Uhgze+zxLtizs6IvoR9c6Z4EfAytPXFmarGex+FaAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6U5T3eGu8dP1ggzKWDlv+w3gjRBByYk50YESjl8MkVPmiY8BYevvJc6pCR3bzBnH132kG48MDqYkV+szZ6WyAas4TKBxgTlsH3PMM+OgD7iwoa+RF1aRlpCSd+9uFYfyPSokxAPgr0/hmGmklJ9z9USpz6RgSdICvEkPKKK3fYO2TxXUxwSLq21drmQpEC7Q0Jl9gFNgO8RLr6WY+0eQh9ZNFrKpX6XUlBUla6KVNC6t6UZ5kN2hDFAjwIr9RHnrytBrG8zudY3kaCsFhV9wTgDpCc5kB0lSb5O3TKsi6/w17J+3yIbfuwYRbm3U3I4QUiS1iMhEbpSGAmldLwsp+uGjtGdPg3dOkYl8KCFYKZNtz08Ze9gR5kX/ZbzN8WRASeIZe9FZ44olR1XO7OTUkzH4mQY57Xjo5aq7yYmRojWaa8v4yTcG1WmeB/WUfxd2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:48.2625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1642ac-51ff-4885-ed47-08df3ae9d4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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

Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with MES,
which the reset uses to map the kernel gfx queue again. Not on SR-IOV
VFs.

The kernel gfx queue and gfx user queue resets then fall back to a soft
reset of the gfx engine before a full reset.

v4: The soft_reset_engine() callback is set by the patch that adds it.
    No async gfx ring check: they are always used now.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 8b96f2a29b1f..55baeda02d6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1593,6 +1593,11 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
+	/* The reset remaps the kernel gfx queue through MES. */
+	if (!amdgpu_sriov_vf(adev) && adev->enable_mes &&
+	    !adev->debug_disable_ip_block_soft_reset)
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
 		if (r) {
-- 
2.50.1

