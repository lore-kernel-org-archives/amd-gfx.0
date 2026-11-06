Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A606A328
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Au5WDo0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 768BE10E19F;
	Fri,  6 Nov 2026 06:26:44 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CF810E3AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 06:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPQuDBcGddQ+fxfa6DCjeft9RnE40v1lNTqx6FGm/L4aGyVoHhYmmfBu0B5KaaMiUyDIQu1WHUhZw9ASUugVRptxyQPsfDdbOvHG9IHhbAFmM8Q1hPy3vyJZ2siPngmb0KdzAy5Q42HP71LPIn6gksOvhhB0W7xd94orodTAG72M+B4BEwmDRaW1M/eMbyRRcFT6B6MXwhemqaNn2VgtS2KpUpPBt1A5xj4JJrq2b6ncGvRd8YmPncH/tyXIAEoBFJ86OwZyZJlzFtTA0RwKj0gMATvyIKxyOQEKQukU1VvQVmzhVnEYqGGC3xDSWDThWI8wAeZ4qAzIE1/6/cmFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWME2mPhmIbuTUAtEOeDNNYLDnQ6Zw3CBt7nq1RhX0c=;
 b=Uhx/QhBfbur9iwzHnwFHYNEEdOSuJJj55KLUK0N3D6tcou39bht37zGev66o4r6OhNWNXvD0HhVI8Jfc7ojat/oGD7zaQaOcpC4Weh5pNAkl413TvADpg/aaZWBjIRFiED+sZbdRyk3uzvkHvvnE0sgmk8eaFZUHsE7+BexaIKNQEdB1uXAkXrCbHpxBuM56PpRylow+2bTLczPwnx3DGPdjO1R+T747mUa0/Y6i4cuxuRTb71W+cuOvSfeLd73TME49X0MLyWcG5VC7DKPJtVCWUFu2hWQxon5ZM/RLGh/cZ1IG9BfKkfGEsKb/2OdD0WseB9wUTxVnht018nGLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWME2mPhmIbuTUAtEOeDNNYLDnQ6Zw3CBt7nq1RhX0c=;
 b=Au5WDo0ugDny0SZ3gSmgdUSRlGzxsf28YghAu8jQ3XVjDPiMIHu+xJbBD/0MdT2vZ1slPXGSEYp/wXj90qEoze9p+3dU0J5WWcg6nNt88s8uHfArcnEJrC1VCVBTSjrzUkFoOltszK5Kz25syqrCyUP6XjdGF7Aoc5DGr7M1Y3E=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Fri, 6 Nov
 2026 06:26:33 +0000
Received: from PH2PEPF00048913.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::6f) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 06:26:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048913.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 06:26:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 6 Nov 2026 00:26:29 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: test copy_from_user() directly in
 kfd_criu_restore_svm()
Date: Fri, 6 Nov 2026 14:26:16 +0800
Message-ID: <20261106062616.851993-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106062616.851993-1-perry.yuan@amd.com>
References: <20261106062616.851993-1-perry.yuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048913:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a30671b-d8e7-47ea-b307-08df3bcee6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261021121427099003|261021123027099003|11063799006|56012099006|261009223027099003|10067099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lgHpBZOk+0vTqI2EU0MteNP+rpvOJd7Oid6qTjQofLj/tDwE8u0TrYrLQoV3UvLvMQMv/9ISqU3QOK4h5NqpPl4nUeb5qalEStaf57Wgb1/yharA4Kd9DZycLiTRB+0bMc5/RbHhcor9c9zDS3p9yk0UzorGc5wa10ugvbwENioH0S8UoSNFhDN3ZYauJGShbjD8QnRhZc+GoUfvf1BS/EK/Y7zdeorMwq2qSiJuiIQ95IurxN/fG3rP/IGbKncKR+TMCzX5kCj8wxiPlYLO8D/1v5HEtcb7Arv1Fz3gYAyFGfUF7+zQOsyttqf4bSbuWvEXZzDfx33p/XAYUaWDckwBiVhJjdVBg8KgnwZtH5RfTyFrvWQUQm+UHAdK/Hkp24Z4kKmfRBRf36BLVe2r3ppHpdJ0f4pc+9MAeU9SrccrTk8pteUSAaN+L0mAf+YM4DQAnBIahcQH93+evMnrqhC0JE4d5kqPmDXzqCfa5N70KmyMPpT0AabjrK9YbqNrpneIuCzpKgIDqPUHyb61fWse6azw5K3T8YjY4Pq0Y0fN1mNPOFPWt/3xC5Z28imB/TTUK/O0FZqkmiY+fhWC7ei3PGAWWpJbm2AmJUmsZi2bsJ3/uLn52+9DTV2Sb/jQwnwyGKI5vTyQuNfOSf6oYLVLoxgL6FeF9RPua4EXcjhWKnrfRDVTZHMI1P1y8LA4GVY234+ocw6meYwJuRgSUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(10067099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +J5RJf8Qsk/zNJ3z88bXJqyd3eBelij1guoseVkmIxYeqbx3lEzBbV48rXJd7lwL+cmqA12X2/CEeiHDhkrC4EtcYpWCtydmb2re58yBh35uYB4tMDwAsbzD9eUYOLc4BsSYl5q8Tj0epO1EweyVlEFff7My2CITuhVE2T6osJ11GBu7C/v0QWxxQLMU/MyOh5Mr4Kmd5vwKb7DMmFis+44K5WMcN/kjBw3c+8s0Ns3cMS27r5AusA86toPNudFLJV3iYZ6DI2+2ZIPmwvGUAUcR8dZEw/ANrzzg5uMew/FnTqka7Myk5V7EpASl/LY9ptQdsA13yxRQfOhh0tKaNuYXy6r0KOSsTI0CzbIFcVeqrebO1FBY40yQPnA+YZftT3SjyaUEgZYVprfU/hxOMuO2DaCcuM6OdrP2LMuJcWqjJ9CDLI3YUnQ1sZakqDuL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:26:32.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a30671b-d8e7-47ea-b307-08df3bcee6c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048913.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

copy_from_user() returns the number of bytes not copied, not an errno.
kfd_criu_restore_svm() stored that count in ret before overwriting it
with -EFAULT. Test the return value directly so ret only ever holds an
error code.

v2:
- split the original patch into two, one change per patch (Yifan)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a571fda5c713..ea1a2cca6a06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4257,9 +4257,8 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 		return -ENOMEM;
 	}
 
-	ret = copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_offset,
-			     svm_priv_data_size);
-	if (ret) {
+	if (copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_offset,
+			   svm_priv_data_size)) {
 		ret = -EFAULT;
 		goto exit;
 	}
-- 
2.34.1

