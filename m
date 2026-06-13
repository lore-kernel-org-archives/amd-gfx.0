Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13243CD98D2
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Jun 2026 02:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7562810EBCB;
	Sat, 13 Jun 2026 02:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAF8vcpg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE5810EBC5
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2026 02:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwtKGUc7+mcWRc/z7pHbGsSUIH60b6nQFJEFqOAbH4Knh8R5qjKXXAQpxiJ9lzKNBr/ywYpJlAH7udlm/g9kng3LTmnBCcVjdQT3QO6RdTzFKi0y9PET4XNi3fTaOKIvIFRBuGoie3FaiFTKvYr/503b2WCh6qDG1ohwgtoeYSJ5Q9QtVcSI7VdsL76A07eyQiim3MaYudmAx2Fw+GS46Ae8lxgGMHYf8jKVKqCKzl3F6Udi8IlQn+bNYW3z+D+R6DROMd2oTjSdC7n9IT6+x5RvQ5RHKelQ3MPIq/AGCK3hf30QBLniAVk2MkpU0ygMku7ez1hw7d320DIBXVUquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGi9Yjx+ohKtUvZIikjWTuCacXA/Lz0K/NT2KO8vlT4=;
 b=gHE8lvOq+i13BO/CJGdwYTYhRp76qBFBIh/j+vxtQJgBqogovHP8mZ+idVXdHaye+AYzU4WTA0wZK3hq0xQxPFXTDFMz6zMKkb6HRrKbFRSqtiiG/a1mrSj9YvI+FKc1sRN4JQAsJbaHjLXw5yCinuP97/C/wln41qsHtKULXUeN3l/Zzbh3t3GWfiNvrthZjW2/hEXHgfXHB3vqe9nyStTKAsTkJE/67Z8s5DY5ByX/3K5bOaBWaRXaW3pRWcSOjUw+MHtNdgPCxDYPN7y2ETC80ZfdjtVFc5ON686X28rx4vKQ6ltKaYSAFOneFRn9bQImknbZCI6GBH1bsDJssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGi9Yjx+ohKtUvZIikjWTuCacXA/Lz0K/NT2KO8vlT4=;
 b=dAF8vcpgSrlldtAkuOL5aq+WJimNTmgkmKKBE3WcKab5vvXCsTAZHVr8PgTCQcbEAmKJ7WgyvBsQWLw7RY6zmqorMmrdA66/DWqM24fuvVxFxOfN8Ij8rrjEVq6whR/Sd+Cm4PaxxONXzFgSGzNMazpdJmm/5lox5Z59I60MekM=
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sat, 13 Jun
 2026 02:07:52 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::2b) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Sat,
 13 Jun 2026 02:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sat, 13 Jun 2026 02:07:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 21:07:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: validate CP_GFX_SHADOW chunk size in CS pass1
Date: Fri, 12 Jun 2026 21:07:24 -0500
Message-ID: <20260613020724.1131374-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc1f023-a1ff-4565-fc8b-08dec8f09346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tvltGNoymDRgRiTqsK0vun9TaCI2ilkkKoJdRf2X7qAY+Au2WrnwJDgx5Z7sud/rahnLeFY6ktoovJij7JVLQDalm01cF6Csbx7HyETXcZNoSwyGUATxu52hDtjlIRyFYVqonLZSAANG3mfBut5DLtJyGFb8zZo2EU2wJfZaKY5g3HeoTn4ych8r7sE3pJO69wdi8Z9ORj4YuFrfIVu4Jj2/JF3N1OmvwFuk76uFr2rNZcYuVrLMGotiLN9isvZljS0cbXiUpTM30um1w+kn3QD49WRHSLEqA0bQ67CUN2TNW7c9dkjXjWnj5uTSDd75VCWnmdJ0IgY5n2oXlfMuKfvf+aq7nXGRwIfleQN1Vtebt9HSkhfQ7oDZnVCz78EFv3j49/n+l8/Sd5hG7lvuTjg7RdTtHdRchua+xSXjdD0BQqiPgr7R377EfwG22T8OQfvn8ENuSyxZfhRBZKUKfVm2dCSEcbNZwCoaXlCe8sxcQQ2q4OaHEDtTVaPtP5DHCO2ZTuZeKhAhxzAvez1h78FivvE8GHaxaElBfJin9g2tGUZjRB9t6RAP6BytGq1hicd7JG42bh5WeAqOni1C8PeZMjpDrkIbkroFdMqKWEuUwuRvH2cdfKNC2G4H2yGkSyG+GP8RTCLPlZl/VtfoyYaC5Anr2H7sbDHP4bVB7ojzZYqlf/tSjZtx+l411+k2tRvUDhedTAoo8D0tk/PqC1FqYafasYcYtFVDENkNTuo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nvKitum1qowr4QOXeEuGeVy2mYZFpAqVwoaIo/wZM0fYcMgkW0zw1IOjL7wYXNLJlrFF+NjUGmDZngt3eZL2xeXhIIR+SPBdtfewqbUpy+hjME5hMDRbHvhqz6RX6N2+QHMsgLBqqHP9qEMFyj1rKOkMRavDtRgeI01Zf7HR+NT6VLas37LASiowUPX//UA4uyvi/4FPASb9HmZvP9LaOtUgSpRYLZxlryw0GT6YKolHMc5gPQagV/aoecG23khKrKUoNLV+5RyNnFzMFXXYPPYf9fsLuphPfjmJvpBFRi2nndbtNdkZuJzN27uo7KjJ3OO2fnVGgnltbCXi9JawU6e/h11vi1D0eLg6fBogfM8LXjWNFnYUSrAv3VgZx7zU53zLhmC8ff5GcQv+iDEVpGgQUM1YESMZ/IHaYGRzpcfDSElvskEsDBTV8q1hHpq1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 02:07:52.0734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1f023-a1ff-4565-fc8b-08dec8f09346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a minimum-length check for the AMDGPU_CHUNK_ID_CP_GFX_SHADOW chunk in
amdgpu_cs_pass1(), matching the gate already present for the IB, FENCE and
BO_HANDLES chunk types.

The CP_GFX_SHADOW case previously shared a bare break with the dependency
and syncobj chunk types, which do not dereference a fixed-size struct. When
userspace submits this chunk with length_dw == 0, vmemdup_array_user() is
called with size 0 and returns ZERO_SIZE_PTR, which passes the IS_ERR()
check. amdgpu_cs_p2_shadow() then dereferences chunk->kdata as a struct
drm_amdgpu_cs_chunk_cp_gfx_shadow (reading shadow->flags), faulting on the
ZERO_SIZE_PTR and causing a NULL-pointer dereference.

This is reachable by an unprivileged process in the render group. Reject
undersized chunks with -EINVAL during pass1 so the bad submission is
rejected before pass2 ever dereferences the data.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0416827b4bb45..d63fbc7c568de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -248,13 +248,17 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 				goto free_partial_kdata;
 			break;
 
+		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
+			if (size < sizeof(struct drm_amdgpu_cs_chunk_cp_gfx_shadow))
+				goto free_partial_kdata;
+			break;
+
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
-		case AMDGPU_CHUNK_ID_CP_GFX_SHADOW:
 			break;
 
 		default:
-- 
2.43.0

