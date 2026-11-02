Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7C60A2606
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kEpg3Ml9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8F710E51E;
	Mon,  2 Nov 2026 07:02:58 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AC510E51E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 07:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmFqdQQduDmrdmTyHsbViZzXyWVFB9a2rXIqlFToPJKDlqhV7iBTg2eVBVm7CtCW3moDNyyFNq4E1LaxuRddk1rpu5WdwrdNmKYhU6gH8y7AVV5oRvinP3/k7tHuTbO8liJPtmrrHG7OQRBlxYPEvqobu6Wjc0YZhGHV/wZ9/Lm04hhpcUIZ/OpOrbGlbFtoQIoOyP+g/9QEVszct3jkCugNxUsjdqr+MaDK04NtjAmVHvx6mlpyTZTHL6wmsU9+dIUimUq3gWbmQSPF9r9lhqlnfE/iVjXUuWjTPGxlDPy5+r1vapLlei8yAatAMJnb0KYztpYKQfB2n+Prs6hu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDunPe2jwSbMCPcLF6adB6orwEyKlvGJQphvyZ1vxCo=;
 b=STXJFx2yefDKrDBmOe3ilzl0qweZz+d7WpeS+P1lfUkzcJJEQFrO3y9ukUjKBDXhZZaGupQz+o1ZsjaHxyNUXQ4wRj6F4HnkZRUndc4yGcn/Wrck5MuV6siiL9+PWqeo7AsFiDHKKoLIj+GVbpoVTj0HwNb70EBBuADKXL5YRKheEhBIR8qVdnjEeTHZfhogLorUxru77TqQt4H7+FGh7cvOjdys0Ykqe4h4aboVM+6u/xzEfEzMBtZ5lbwiWTo61sGglj2ZgFu1qXaVDqoxSxWWBAjsTpUgL0XOgf55+b8GFWiCEbwbkf94Is/aJJSuLA+2OrWAYAcq8rjvyygwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDunPe2jwSbMCPcLF6adB6orwEyKlvGJQphvyZ1vxCo=;
 b=kEpg3Ml9jrdAducMa59X7jWRJbEwVfvFne+AUWCFu3KGuzzEa6TyTFbl0MZ0mraTx0NknXz3MwWtJmYkYJQWS5r/2DyQ40pGGCp2sRB6E+jwLiBaRRbkfRr8vSHtCxaUkdfViTLOqxDnKY3DfFQabx6tsOenveNx/5FfsQ7/298=
Received: from CH2PR19CA0029.namprd19.prod.outlook.com (2603:10b6:610:4d::39)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:02:47 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::31) by CH2PR19CA0029.outlook.office365.com
 (2603:10b6:610:4d::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:02:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 07:02:46 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 01:02:42 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Yifan1.Zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdkfd: check CRIU SVM priv data bounds before allocating
Date: Mon, 2 Nov 2026 15:02:27 +0800
Message-ID: <20261102070227.2217976-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: a8439dd2-526e-4dcc-8559-08df38af4c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: AjiAXVM05ZdRy38lCFAFHc+vEBDTgfG/jiCACebGdX6Sekn9zRWpdeZu7XSqtt7FtEefOfvbvkIQuPyf5dajXSQdNa82EX10Uj+ZlvGRenM6Lfms2+cOdHCIwDiB0NOlJD2DcfYIK8w88vTtHhWxyErhSf59cAP70iMLl/dRpXu3pABzsQm+JOGDaFI9dC6G7WUjBLMXtq1sJqP8F/MITzEAwP9MPFWhx8WmhC/TVSHf37QGCobR/NvDmKNk77rjbih2ZugBvP2sWugssubmTcRxvX3Ush53QmZQ0OtU2fd2K4BvPpd9NTgpOGA6m1PvwM8zyPCbzsfkB63FHx7GY0guZ36EzDBnxAvA07l7lrIT/0E8oTF3TzMSHxaOfYGtGCnPhI9f4DsBUdEWD/nIv3K5KZWeLSOJIFFN8zMNc/8B/gJLhyCuk8AzL+f7x0qUZEXDYipmYgsECbY3U6VRjtuCtwtJ0MFLQW+xT5M6yVHjzQ2/Djcs0x7IVYPlkF+CURVcd14JEVSuphPgwpcMbN6a8iK4j7pEj2l9RiXGdwGzFX3kQPz/Mv2y4DrJQRberT1dTMHNvrYf18ysVXncV8B+ZMf54LoWwZ9snnnG7EV3W6PLgGpTr0KVBAqGdOE7hMUeaXoJo+nPio3M6bWUwR2X/e+C4PxCAxXHvn8sUFYo9Fzo1HWB050jbc6ZY47r+xd8GZFpZqeaWgTlBFrC1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZmbeHEGZDS+nz1UNLCV75fH8Qj+mc5wZuV9MftLSd9ms2se27uFUT2JoAm6GLhXugcbM3kjuy/jXvY4Gm1iGAgn6CLrzACPRiMqSUcENdFiKlwQ74h3S1s0/7zHhU7ltcyy73Yd5cHYriVUtpgJYPH6OR16g6pg70pJjnAXC1nELejUQd6AEpYmvBPuo5nEBq3nhJ4f4jNJIY7oLyGvDREecqajLdJjYb92C9a1EMWgMvuX/ebZXlXb4FrwUfNEUCh2SVtLqxSMF1uBu0HrEREmfYtkyBJIrstIk7D0Sk6v+S6E/D1Nlqwr8GX41R4l2P39+/XbUQJyIb4xUJBxrGPUoLbWS9C+MQ7GzuCa7M1jslrKiIBw6lEsw0nJ63mCnwxxc2XoaH+19qvI5AY9eCIV/YwGg+F2YsEexAiMcoded4bs1c2laKJKfeohzmfkc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:02:46.0745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8439dd2-526e-4dcc-8559-08df38af4c57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

kfd_criu_restore_svm() allocated the per-range metadata before checking
that the range fits in the user supplied private data buffer, so an out
of range offset cost a pointless kzalloc()/kfree() round trip. Do the
bounds check first and return -EINVAL directly.

copy_from_user() returns the number of bytes not copied, not an errno.
Test it directly instead of storing it in ret, so ret only ever holds an
error code.

No functional change for valid input.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3023b0159ba5..b9bf369a9fe3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4236,19 +4236,17 @@ int kfd_criu_restore_svm(struct kfd_process *p,
 	svm_priv_data_size = sizeof(struct kfd_criu_svm_range_priv_data) +
 								svm_attrs_size;
 
+	if (*priv_data_offset + svm_priv_data_size > max_priv_data_size)
+		return -EINVAL;
+
 	criu_svm_md = kzalloc(svm_object_md_size, GFP_KERNEL);
 	if (!criu_svm_md) {
 		pr_err("failed to allocate memory to store svm metadata\n");
 		return -ENOMEM;
 	}
-	if (*priv_data_offset + svm_priv_data_size > max_priv_data_size) {
-		ret = -EINVAL;
-		goto exit;
-	}
 
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

