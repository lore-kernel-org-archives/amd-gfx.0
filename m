Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65A606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QYTm5tgJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFFF10EAD8;
	Mon, 19 Oct 2026 20:08:04 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8E410EAD8
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaJFWZyWtq0nwsmkC7k61+CzRI2L1m+prOxR7+ChIHGAq3VVqSuHIDtbR00LACjpLfkVkdgJttDrN7VqTm/+bSHS+pxUsqbXvzVaYCaxGppmSB0NYotUqzGQB5fkwNLnr9SHYd7mGKWNmTbs3/KFFSAFFbHE6gjWc3iQ8KM0HNwEinqhNNQ89QCptHt6IA1/ucVLf1ADlCZZE5tSLdUPVTdOn7zsOkg/BaiWcgRjzHs9SdGx5Z1yM7qnneGkL47aRKJCJrSFW+z0JLl7rQW8zqrVFzSV5n/muZYOjmHHfpxsZPiv57LnOQJPJoCS71OAGTg3wN4GV+jKfprJMjTE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs+Ot2Jw66+ArXopFDSv6y01p2+yMaPEr7vuz4OE+S4=;
 b=oV2NZEqTcUSAT4U9S8FwGhrLlzF8kk6sSg+477zXVjOrKbLL/xDNz3UmzKcJ5cYL8hWPNwHlTK2cd2Xro+sPWk0C2stVRXXW2JzUZgc9spt4E677KrL1KFOm/JS+gigM7FC2jyWdMfaKhYU6INvJfq6ph6yFh9Aip4aCu8InYRmZmIbdXL1d+AJInSuo2p2bSZ1bGEPv1t8o8zURlIaGhCi7mPb9mJGU0H+3x92UvcPGcoZ3s5/JAHtd9FoNDls8HidEy9bDbjLrLJ3BbR5srfte8XjUzf2rx3O9PyzU8rKDsYV/99UgQj7OUk6ErZsxB0Zc1TQBRIjB/Wia7SuoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs+Ot2Jw66+ArXopFDSv6y01p2+yMaPEr7vuz4OE+S4=;
 b=QYTm5tgJuAWhZtBN3qPhf4Gns4x4e/OS28jOMCJmNj5QdH1C+QxjAzp+iIwddtrPHQi1yX/yhHMkgRZSAFjMmjgHi9/R7ldUFUf8yvb6xaFOKOfEQEBLhawVkqS/BtQwtKD1nEIhJ1hglYUoistQp1D5yiDVikudue6QNS+gK/0=
Received: from PH8P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::9)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:07:52 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::6b) by PH8P223CA0017.outlook.office365.com
 (2603:10b6:510:2db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Mon,
 19 Oct 2026 20:07:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:07:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:52 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 15:07:50 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/jpeg_v2_0: set only IB_RD_VMID to 0
Date: Mon, 19 Oct 2026 16:07:24 -0400
Message-ID: <20261019200726.15262-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019200726.15262-1-benjamin.cheng@amd.com>
References: <20261019200726.15262-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: fe88227a-1767-4f6b-9aa6-08df2e1ca7fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: s6IQOGrljTJ42gNxxEMFGX7JXtMm5IBT4H92zzj4tWFeXCW1qQKNGqkRxCINSBn5H9tc2Gl6qsaD5IXns56HLwwBUslBt52KR7mAJHtI3/j4ugeiuoBCzCqeMvlIUn5WgYDLh3kOW6wY2/Q+VSK6a85PqaIWo6v+wSFnFzX/0ptg/sDKLemJMOVstDJl4tB0z4lv1cgSfXgOMod1WdFs+Lw7lSow8s/ZmiqONn0lFYcoJ3Hku64IFhRMUI/VIlM/YaVea1i1MZMr7quzDuPrzC/NzDoCqIL6jsqtgMugvEPDYspsgXdBfZMyZIH3+BcuwAvohW8tMR3RkIa01TMvMX7abhERTDqFjyq3Tr8H/3X9JiMaEgsgOaSzw581qiZJIE720yQWpulVeRZ6C1y9o+9USbvfk4f7AnNh+sw2fmTzNF3TvwpNtV6glz+3sTr3lyZMPhcbaHPhw6VHEhPl67iTv5HYCpBUWw0zOspQ3FaNx8IfMPO/3iUB0FNW1woqU8DN3zOKbDpEubTazyJHc7QWwHZ3hzSbQQnLmfUrbCjMPIStMrlO6YFJOwBKEsShxo3gT8B0p3prlVzodxkZklkbLdxmPFbN98ZwPkX8xQahR+8P2q4qdXv355W5gYzQWdwavyhU3j8moYk0kXLvmBXF8JpS8xkP+GKNvoMSSyjeqGY9LNy+J1vkJrU/dbrmJWsVYTt1Pixa237riFUQIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UB7ct1hLSixNSob52XquW60OaIJzcPwHvyxAH/JfeORAibyMAjlifE1ZBRcgCo5F63o8og8hfZEDHwOT3J7YYn6HG1fG4WnaeryAVy6bMdRmo1BXeLtDSFJ4czaX7jxLwbgJBhVrEyasaAogCsqbTI8JNVx59i+KRRoV3RVk1TCBaOLb8IAKukV3YkEAo0ASIqE7PYdlmS+eQTuDGwexMqcqJM+hjbgT2jkC1kCVl73oyh+KyIgsgzUPhZu3cgNco87pV0TNfFjuhMgoodxL+vqmL9kfVgd7wjagsMuT+h/uDoQV9uLsbCSpUAJW/ZK6bo3a8nwIRh17ntbMiYyyivF9/zdMPYidQziVeaJI7EE2XW/ADIJ/1NsuRtzy+1+NXLp9ypVJ/0NeiCfOnkBcPiFE1+8k32tE/i5C7JyhrTliwpeOVEjwrtdFClZooa1O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:07:52.1060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe88227a-1767-4f6b-9aa6-08df2e1ca7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

If IB parsing is done by kernel, the IB will need to be read from VMID 0.
However, memory read/write operations from within the IB should stay in
the job's VMID. This will allow us to enable packet type 4.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 72069b77f6f1..eb26c21de532 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -557,18 +557,19 @@ void jpeg_v2_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
 				uint32_t flags)
 {
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	uint32_t reg;
 
 	amdgpu_ring_write(ring,	PACKETJ(mmUVD_JPEG_IH_CTRL_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
 	amdgpu_ring_write(ring, (vmid << JPEG_IH_CTRL__IH_VMID__SHIFT));
 
+	reg = (vmid << UVD_LMI_JRBC_IB_VMID__IB_WR_VMID__SHIFT) |
+	      (vmid << UVD_LMI_JRBC_IB_VMID__MEM_RD_VMID__SHIFT);
+	if (!ring->funcs->parse_cs)
+		reg |= (vmid << UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-
-	if (ring->funcs->parse_cs)
-		amdgpu_ring_write(ring, 0);
-	else
-		amdgpu_ring_write(ring, (vmid | (vmid << 4) | (vmid << 8)));
+	amdgpu_ring_write(ring, reg);
 
 	amdgpu_ring_write(ring, PACKETJ(mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
 		0, 0, PACKETJ_TYPE0));
-- 
2.56.0

