Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CB606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xSIqmHsn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043DF1122C5;
	Thu, 22 Oct 2026 02:44:40 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0122C1122C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YA3TvPqM7lG38VwhOHpX3d+uqv3hufJw3j3Cgjs8pdYJ6XhXl6yqb0N0lgPLK2Ufskap5H50TbC9/MLBp4b+RMEGNTw7/Z0nZbhe6EU11aact6WjQyxWuL1iQ4vSTTyLilh3VKU1QECTOk3MJvDD0tNgZSHRhwwTSpIxHmJ5xEBKonF9fqv0T+EXJghD9mQZaUSN4b4cfJcte6I9t61nWBfSeVA+cEEmLL0vIglJm9msmbnXKPxk9WJUs4qN3FR6JCKQ+ubDauK+fkbNLD5OuWZCsgxigb9t+gy7tK/W7B/SqkAoin2/Ujaif8gU/Ss8oQxU1p6GCLh3qxJIKCQp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz7tTR71hWB1pwFRliT2pivrEzT3aOg1w9yE/ZdNYkk=;
 b=lf7oEIKeg5O7PPUihHvgjb53pR560xT+3Geab/s5W/4Y0bx3651KTtqSfBaI205H8S2VLa8nOZIpsyjoFZbcmdJFtzsnj1S6ZcfIE2fmfRtxbx1GfPoie0CPtfhUvvzMpL2kWOo+xIDXOsTPV1Iky/Egg21AvqAp3mcafZQq650ZEBX9+MpMWRaVSQttz0PREv2xBTstkIaiy5xjEnZhAzjmBJVileT01CR5Ce6f/kHl+8mo3mGNwS4RGcK4Y7tTVx3GnXECu1WbSOIPD1Oa+sB00OPxYakev3IRJ7hU6MXwMiOwdQJlYn3XZYROOct3rjd/akJ+Lrf+R+1FW8W7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz7tTR71hWB1pwFRliT2pivrEzT3aOg1w9yE/ZdNYkk=;
 b=xSIqmHsn2cCwYnCBtJIvsmu6g+lbR5q9cJgrqvPqid1qjk9+dLPCVEGHjvfyPIDnC717hKeIqdbQkvLLNaseWsXrLHjsphA/63on8iIUMe9W5iUOQdlbg31Q/AiZGHRfTi6dHt50ebs/vOUv6udgMvV9GRdWLhp1A/buEJnVf0c=
Received: from SJ0PR13CA0100.namprd13.prod.outlook.com (2603:10b6:a03:2c5::15)
 by DS0PR12MB999265.namprd12.prod.outlook.com (2603:10b6:8:432::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 02:44:29 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::3c) by SJ0PR13CA0100.outlook.office365.com
 (2603:10b6:a03:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 02:44:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 02:44:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:44:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 21:44:26 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Thu, 22 Oct 2026 10:44:19 +0800
Message-ID: <20261022024425.4187361-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|DS0PR12MB999265:EE_
X-MS-Office365-Filtering-Correlation-Id: fa882ffd-b8bc-4b7a-cdb3-08df2fe6648a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|6133799003|10067099003|18002099003|261009223027099003|11063799006|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: GHJjHteKDx9kQRrnVC57cRL+Sby91MGcnIp9J1ap8D/k8T9kJsxXG/MiI6c24MxvwUM/6B8FUVSRACytqBTj6vxom9KKfNCKFEf2C6Dn6htPFul58Wz613M86BY845FL8sMOcJV19iFvSn3GIi+RAkInR9Xf73nABTrnXXGNnTgL2mx1rK20/rpcXOXr0vHax7SsICz3DDEr2k9EqfoPBWDh4ZeBEam9grpR38WVBbavwKwyex6yinV67qsx8u07jOIw/A/WfytYBlYozhMNgtI/2iHd++X5SZFNQ7qrbd69vqxoB7yLCba8ixmPcL7koO32PZNoMlPwbbJ8fkk32Y/F3NqpvNH3Dq2kVAEz7R0mabF/0cdDUvLPyDqJiuQi3vuvNqOk0Scq+Hk4bwa6MBTAQToXNmC1BbG4ph00MJd8tsOIUupbf30t0w6GHz/6OVrb9VUo7/7eG8kbVPNk0OO94lUp2e3OrN8h6c25dJsJJG5NXmk4LumQD5XetSsZYyhbIcZux4nzCNZYqL9gJOPjK99Uy5IcrK4vJpNvwXwp5eRYtTWZps6wMbNzqYcXq0cZJg0dPw+830kAzCd2RU7ZWSYTQGKwu8RT4ZS0yO6xHulxRMvMKHRFpTdRxxIWBhUejQxek0EjnWF4baOzZGyLV/v5WC19MBS1O1wLF8bs7vC/T4dKQGhunkPcY4jg2S67oJXg9+HGCtEEz3ttfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(261009223027099003)(11063799006)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5qIWEU3WtK4dUpTEWyDn0HkKpdflJcRnu/sAfGacTHVGGqO7BPpbmGYIkUM8HLW7WJ+t29xDFyNa7lvxu1QpTlaSh/L0FLZaewd3dEgdAo1PdllLSyas1wtEvMbKF8R5Yx9+HS6yef9RTfqmv5VFVkaNUgblakXa6QyDVepCs0XUVsuABtBlNcbh3PavKBH0rlijdbg4bH0qCtxldN04o48m4Z133LX2CqhyDTJEoDyjT/B3s4HncL5FgJ9hKOWXxqqVcGv4xZDgOUJ7yAjIwvuulj21WEp/2CCaVVmffJQFarU1MQYT2u2BlCLslAgG8diTg4w9UulqMTMZ0D9GefWn2sxSrMZ+L201ewxpkZfuimiy1omIKJK6UBAsrHE7qyFg6LJBfnVhx6PE9xbeOq4qwclmGzTCk5iHhy/T9gwN0YZcpHjhrqyniZdcnjBw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:44:28.4407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa882ffd-b8bc-4b7a-cdb3-08df2fe6648a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999265
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

