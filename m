Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237A606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JTriCpbZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0BB112A77;
	Fri, 23 Oct 2026 10:13:11 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BDE112A77
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 10:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh82+I/LBtJVle9h22BEABKHNfW61hSmP1E63fhM9/UEXABmqz4SSW9CjcTWL5NkcTWsYZgMjqYLxrM0Tq3MiD0u61dy1+JnVQaStkqaPDn7iMlCA9j2hSegAH9C7stMNMaVReRgY7kThd2o3SwwHTcuErQclxbXxumcdrZO/4dAET03bVlbmeX2zQQG3T7N48Q8lqqwHL7DVlzDYsoci4OiHTu+Sd6Ln7LExTUFgM0C2UcJNqqI6S00qfP4PFFET8aynhenqhqMoMjVyAzXz+OWv8mHhRXH6Q6Coicx+83Q18XMXD3N0rMUduxvEgt4RDlovrzN7pmw/tJ68SN4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWSMrUTFnrJQ/bc2qmzcAlIwc+hMjHPwxWdSqa3xad4=;
 b=e+xBcqPvcYPGeOoCBZz047VhzsWGzE4mP72MYSotRjF4eVd5AOtIM/MDwg1Mb4PdVWUMRZ0eQd6LGCPI1Fmv/tCV2/TxcBBMehEHHsQ2D5eLrzpQ1DCfZLtxnXbWbYQR7Js9r5Maxpjp4peEoez/M4abl10rOBMqD1S+faLXcjmEED185HQHiHhEgNAhb9tybA5Ir3T7BBySmx2SZXo8zReoXAOROly+QslVgsE94hV1tIBsAXkGrWWeaXj0BAnCOEeYUvOL+LOe1kWhI/e7+ycgxJDfa9JbZpzidYCcPXCAa7Mxkv/WyhPStPAcXT3AePnzPXeEiRMmoJ+kr0PCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWSMrUTFnrJQ/bc2qmzcAlIwc+hMjHPwxWdSqa3xad4=;
 b=JTriCpbZt4hcQ5f0mII8lhIRGzgg5UfO1bsoGRO5B6o/cVnELhURWCA3elMyuFs65zAlCQwOJChwrcLeHCxY7LBHCR9OvWF2HldTH5toQWoZ1pWmyI36sXyUY2xfVHMpTkVImj8oHqX5wcrWtGUSxJsCukhxAVE97m6tWLKTt0w=
Received: from BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::18)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 10:12:57 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::5d) by BN9P221CA0016.outlook.office365.com
 (2603:10b6:408:10a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 10:12:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 10:12:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 05:12:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 05:12:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 05:12:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <David.Francis@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: parse CS IBs at the BO offset their VA
 mapping starts at
Date: Fri, 23 Oct 2026 18:12:33 +0800
Message-ID: <20261023101246.937830-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261023101246.937830-1-Jesse.Zhang@amd.com>
References: <20261023101246.937830-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c30c16c-62b8-46b6-4ebf-08df30ee3561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|56012099006|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: DEhrdAhQmSjQ93sAOdg28/O9rEHI3Jv+VJl1I6QK+FXjEclm7LQ/cHv1NIseZZUyZozRgqnkGuaMdqVEnZcLzCc6tQ9ZD8DAyYcLQMgbiNkOKPrgnGrUW3Yk5po51Ws1Ew5pZ3yDigN2p8Vwrew/dIHlrGb9QGsghw+SnyMEdr3saxmiBus2ETVnoJxh0r49v6E0oI35mDEJiOJteSqAVAWqzoAKBHFOILlH/Zo/y2UCI4Z80i/NoQydZiAur+R7CUm0F/1C69wsqIDzO0kYr9B029b3NWhp7BECihx5LezxaNshvUTxlOy5mCeuUZF1BtBW1harhBnrZYj2NBpxvidPwb8sksI/z5iuOCxHiljfpOz8bprt4iB1Lk80sAdC8XvWkB/MqwgushBB0fLKWw+dQdn7ZCifqN05AD/cSJBtCfpIk4h5aL44M2p/4jXdTkFBIC3Sx0jD7sKdWShNx7NLQs5zLJFOPv0YevJRf1QcyjpJgYmrvyeb84Wly0URCu1CtQkG+N8nhhFSFDXJXbHlvWJxU1bPTLTHjeO6PcL6CViEwe7xOdNmrDgQM5sRFp6GzICMO8YTG2Enx0fSUg+qGaYO56dWTeaHveXIHtbSzYHhs8Jmo9QZsHYv2S9c46nzCPArcoKfDUbCEHTjd/84jexb5aVmVR50Ni48NKUHtKwVLk7rLan2NGgoz3dTvzI+t6x5uN1pcju06Spqvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jj0E7cpVtaTtiYk8sqCyg47jLMbwikaHHWTgKz2P0GL4Y7ku3MsH8bYF274ln+GjyrmIpC92YP2I+KrWQjbxwi+boU3ZWfUxSSsWadal/ElQ2BiA7TxmEm6CG0NCMsMITIsFeyz8Ls0dc+9ZNtpAXoQjtUY5shhZYUjs78trmhMUcbNTpMmNzgouc6p5VmtXKa1rYOjg2qOYXJMi3yw+Tqt1Ci6tootUWZGIXVxpLyT4NABXeU4q8BAwiQvUzM8C7OhayXvXhBs0J+rtvm2v1hKV6m2y1y92E32IPUmkpJG1JBmEQHyr3eJLJFg0OlVwcqYDzun+oEJ3y1a10OuJAVVU6c1WBWJ8A4ok/PC5CrkvqQa5iGyANSl24NPFFtyQf6Q3F9EBrwTBs5sNo4EIsEZm01e60CdmttQtreEXMpJUmhEIVAUaigghjvn1BUXo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:12:56.5387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c30c16c-62b8-46b6-4ebf-08df30ee3561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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

For rings which parse or patch the IBs on the CPU, like JPEG and VCN,
the CS looks the IB up through its VA mapping and maps the BO, but
ignores the offset in the BO the mapping starts at. It then parses
other data than the GPU executes. On navi31, an IB of JPEG NOPs in the
second page of a BO, mapped with offset_in_bo 4096, is parsed from the
zeros in the first page and rejected:

  amdgpu 0000:03:00.0: Invalid packet [0x00000000]!

while the same IB submitted through a mapping of the whole BO works.

Add the mapping offset when locating the IB in the BO.

Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fa301c71b782..4a277f04cde5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1073,7 +1073,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		if (r)
 			return r;
 
-		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
+		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE) + m->offset;
 
 		if (ring->funcs->parse_cs) {
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);
-- 
2.50.1

