Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C107606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s4xYZM2V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA62510E209;
	Wed, 21 Oct 2026 09:16:34 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E0A10E209
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 09:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPs3c7FUdoSndtQ1jWU0+IB91PgUYcso7ZpvdqK31Jl519k4uSai0BiYVw4KbwzH7uluYszkVUWUlYMXwWo4dJtkkh2fzok2g4Hgtljyx2jt2iG8Bh8Nkxw1NupitJq0MiejaE2pa8P/57xcDMyqtGmJqAhqk+ByHxlJoN7hjNp7M+yXspof7Z227aeQNwKBsVH6b3G1nwYPif5usKFoSG/e9bOBNFGGPZYr9PFOYlegax+HHvXvIvC8IGOqXTySciyrkYfSvnwRHgHRayeMiJ4s8q3Oee1HyVOV2lcN8SKNacT+NQyfgb/jFycH2K2+4KuEQNeAX14/Wmdsu3Xh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk4c3PFYSC1hm/TXr7Nu/YyemMnqdAEk/VBXDLEtbKI=;
 b=O5LgcWmlWUW4phHRoLfuylazLeqOvwXLJhhCaegtxeGIViZOJi34Su8lL8rvM17K5peJZEezJ5lhdBxaNd1ZCvZEMFuM9vp8FGICLwybQ/gq05QM4leWAZTde5y2ITLdPb7N6N0MPNvTxeeJv/IrGjbFchiAGz/CtiR14Dv2KoXxuvSu96GZkwgft0OWlaiqLTExvph8XLYc2vuujA4ftdIh1SqzoeL2R5wEt4X/A7vCqUrbo0peMk+vptsJIcjYkCEYF6S9z18tY90RkJXHm2UIftVtP77Y+y2oTj/o6a+aL4mKluhMGWXoxxNnicUfBrQYEP6Z6LnLpIVPS+a/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4c3PFYSC1hm/TXr7Nu/YyemMnqdAEk/VBXDLEtbKI=;
 b=s4xYZM2VLasru6ObkzWXAFdhOFcW9+B3Sz8DV5K8IwdfGfi5uDU5er1GU0YwApN2sYg4xQJjBmm4YrNOpMzFatj2p1P+CTQfok8IxVO3PdMItHaU9kZHAHV4t4Elf+wwARKLTmJOhML/M9i/JtMQfegVAv8nKJTedJcpHoumtm4=
Received: from DSSP221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::18) by
 BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 09:16:24 +0000
Received: from DS8PEPF000000DE.namprd05.prod.outlook.com
 (2603:10b6:8:3d5:cafe::6a) by DSSP221CA0007.outlook.office365.com
 (2603:10b6:8:3d5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:16:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000DE.mail.protection.outlook.com (10.167.23.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:16:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:16:21 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, <Mangesh.Gadre@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: skip RAS error count reset in debug mode
Date: Wed, 21 Oct 2026 17:16:07 +0800
Message-ID: <20261021091607.245415-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DE:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 10266f66-8853-461f-dd1f-08df2f53fa3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|5023799004|11063799006|261009223027099003|10067099003|18092099006|18002099003|6133799003|10086099003;
X-Microsoft-Antispam-Message-Info: g5U8vBNOoHWFDhk4dh0Tz/N83KTSirSiM9i3H2oXC7nnvzscOKA3wqAsUNkXJyyRqGKRildeV7b8beQgSpGV93WzXkiDbWdtCJdEK4vjYgesl0m55xe+G0mILpOr5ARCrgV5f0ljR1sTw3Db62bhrMwL6qEPWLIUIo6B5I2iq3sgetCnUfMVGeTA901YkOUh2IqBlR525D4EFt2QvJbXannQfXW39FLHNhresNmNC/uprEPGO1xAjW1XIADWR9lgdu7maMgfgitQCJSH3QfUog7IndlyrtZvdeMkAu/wP4urkp5Yjnb+pDMeyQB4CaLpBQTKzMxLq3mRpBwaUfxmWdrrjjjm7KMiwSOqD99cgc0awkoMPEqpA3PGN4+vN/fc6uxCoCeR181OdUKnZBBIk1QpW8Dkd9cr3ONRguzw7VP9sCN4EFiwtBcyvgrhO9hFMHAimejYOD+ofOG1wDQwN+CuOEbxsDY5viAjSarwgA0cZRXof7MuUarKk3xe+5PsOmyPqLWm/ovj2F3cub4FoZmytpPAQbt/Ip5u3l4SA5xNyoGP3KiFaWsWBkhmE29W+UzA3K1PmycE9xW3nK1S14M6tu4/OCmYsrI4K6oxrMSfneIC8Wg6ZfBqbj36iJgodEscBiaz6X5f0TzmkFOMa9vI7kD1Y/stZCMu9FIutDCKD/oun/UTVN6JgFZQwFAcTR1AYrOm6YM9PMbbkKlkXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18092099006)(18002099003)(6133799003)(10086099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vpm4FGgS1NYam27UVPU4AWCuI6AMQBiWOLHugEG2Mxf0q2Amr0xOwLP5BfwjtW5rnPZlPhw0ldSagc/klPGw0YPKE4fxUAK63MnWoZmdvarBtZjsRplGw7XACOqMXacI85c995rjUZ3p6iCd5fzpj8ZZe1wxcwRZOGQsIkHeKCs8x0HUR9Rpjks8nfWg74GDw0JFH43Cg8hPe4OBKcKyRP46xLV13cVWiKoaeVJj38Ftnagj7TUCJEBTnfnkRGDsMcjW40CAYxFyzicT1pqIIxbAN6WdwXFcyiw4iwtXIKeeyq168uWjv3qSnCjEaPb1nJZoc3YvPaWab9BMnO3rfm+8A75T9+NN/iMSKdbVBXL5iKhlwkqBzhzQfdYV5HXqtrkcYxmKN++dfIdgzjsLRT6rU7LVGMNLoZOoqkP2pZ9tAHBJ8cOXwMwu6CANN1Xd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:16:23.6057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10266f66-8853-461f-dd1f-08df2f53fa3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS8PEPF000000DE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

Fixes: c65c9fc19b6e ("drm/amdgpu: retire legacy ACA support")

After legacy ACA support was retired, some ASICs systems may trigger
security violations during driver load when
amdgpu_ras_reset_error_count() is invoked in debug mode.

The function only checks whether RAS is supported for the target
block before proceeding. In debug mode, ACA/RAS handling is not
available and attempting to access the reset path can lead to
unexpected HW accesses, resulting in security violation reports
during driver initialization.

Prevent this by treating debug mode as unsupported for RAS error
count reset and return -EOPNOTSUPP early.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 557baca454a9..e8a4fe22317f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1506,7 +1506,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		return -EOPNOTSUPP;
 	}
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_mgr_get_debug_mode(adev))
 		return -EOPNOTSUPP;
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.34.1

