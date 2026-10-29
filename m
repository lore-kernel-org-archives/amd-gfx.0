Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EDC606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kZfw3Gun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3AE10FFAC;
	Thu, 29 Oct 2026 07:05:08 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B5910FFA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 07:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2OcuzOEG97+DqhLG1o4c8tar0E53CCYOJGqgA0pSX8QV4ZDiir4wVosfaa+VOgpYWDMNJBYyAV9HdT6AsnywTZuYf+JaH89bDl+VP+IVJ+uM5ZtbL3YWIvCrqDY6z7Kc/4HJ2xI7ZP/7HBnVOTO79L9ka4KqxTo+0uVeMMD6saVGRRtbBF/EGIiZW4j2XCgqrE4bn1eeyEt7xO9jFYFGXCBSlbGSGt1JD4Z/kDGydbH4RlqrRnaEpx6UtfS4pfRj1mMn2qxqFA1pFri4vgAa0Zvb5dtNNiVw21vu89Mz5K1x0pK7Faeomc9kwuxbNLy9U7q8UcKkOfvj6hxNsPQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0T/cPbOCNu1ZHQfhtPqWnmKOekgLWZ5i8YnM+SDHbM=;
 b=LTdNMtMZnbZq241NkPiFSmjRLyoyaCg1co0keihA1JxdlpqnAPET6F9X5XsZoyIp/BmqC9J8MXPqNIW9U2RrFgVKAtRzRMuSMbxn58n8YJoZDCNEVPJQyyUzKQMF49I5wkusXZp4MLMvNyGxBueeTERRnHs6Jl/4UgGeqNKV38CP40jG/La1LITTlsWIQRSVwwyqtR13WTs3xJRVHbBgBcelVRNjoHlvr9dslSF141gHs8BeS+a6jonMuU0mhoRN1u5IFGL+szqnlu4GnwFjGc/yEturiGyIiKk70BCPUvAyQJSfKtV8I1T4u3D9gXTS9MGgFaFadjg1rOBGZCMl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0T/cPbOCNu1ZHQfhtPqWnmKOekgLWZ5i8YnM+SDHbM=;
 b=kZfw3Gun+fqrW1lFLauP35e4dN+vDe6Y6GTtvCIjLKSZe7q8Wk02CMhYnC+eaWM/GXdiThtXU1y1c9ZXgeQRYTpYZi8++M6gF1iL6cyW+V0yzzXVMp5/eLT0ZuPnm2iqBNTTldzItKQtyGWVLWHPoNPkRFNW+Q5SClkBvKUH4Iw=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 07:04:10 +0000
Received: from BY1PEPF000264B4.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a9) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.4 via Frontend Transport; Thu, 29
 Oct 2026 07:04:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B4.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 07:04:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 02:04:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 02:04:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: program the SH_MEM registers of the SPM VMID
Date: Thu, 29 Oct 2026 15:03:26 +0800
Message-ID: <20261029070403.22012-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029070403.22012-1-Jesse.Zhang@amd.com>
References: <20261029070403.22012-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B4:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ed7895-e0d0-47ee-95ed-08df358ad4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9E9H8BmztBGICWsvLEpA63llxpJew9Qk+0sHGztigPx/cAm3RMx3cSJTynrQwvUJQuJcOVUD7ioNK5j5siHBwg6ByqMFllzbueRsARJBExj29vqiJu5p5/pCgSYGaWkRWxo7wI0Xi61Zjcnpll+drEJXkmVG/+h9+pcsIS8F6pLFIurQ6JCTzWrbmIGnXv52mO4kzOG8pQ2LgDkA57kpXDRa2SQ6hpvMk9Ftwt2dcrFBllyCBNMGsucMCsFleUVegLo8i5xg9F8mdmdsYExqaE67G7x/eZERnz03e0m5rrhlupvIhWgQO1089I3l5y+ZcoQyEO1jklblP5yRHRlYum8pswy8uKg++eWx9v0voFzPlJkabrb2kHwNv4eO2QgSlH9U3L7JD+6LU/E78rLaQnHKoUCqK+OP0G4cu+VZJEZ0z6ARmEthEF1DLAgWAa5lSArl0h2/K3PbGYzdrlH+PS4NSlszgffgga8OOa1RQaTbhsqm194XJMHs3eRClXdMsaur8cg9TV/YLuXU833/upqXYA43cYFm7y9VuBcSI1sLWdiJUUV6pTgCQsJyVWPcxJQrus7dexFXa+vNbuS1XB7WdMY1HkqqZOmuwcei7QpPjY0FFJ77U9NDx3GwZkPZXIosI5drx/d3N5feLuODzJH9+d/aUK3pKwN2D0Zybk7ggtf3E/JucxbcS9B1ccssp/PsL1EZcvIftDGj6t5JBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z3gydpMtoH1xmwQR/mRqRQDuKgWRO88nhENmZwsJPP6B52TpNLfagT+OrkEw5aeGYxpLtozbrbWLclsWm416nCDMhv4HrCiqtBqzTE++yddkWz1OEd932Zc1KpRDn8mKOHnDpXj8chIm0dKjDcMAbBc1jtdJ/Zkm1uHk8AWRP5t9nnNB89IgV9mtqa1jWN9KVVgYLakuRgrZRtT+McgDCPOUQ8JBc9TJXSq1Tu+IcUESKe8ruuZYN7YXOVEJMmvANaWjtJ3TnC7sU83UFYRoy08lmmymNN+l0Lne+KqFdXaaEo3Jw1BCuZtV+KwHoF7vkJCZ0Fzq+Q7WW0nDOZB8AY/I03qh2Vy+FTKkAafczN2UQRJqrCCN8Md2j4pY8dnUdK9x1Yir9c26QKMQEUAOM4vY1FcYz3s2nUnK0DvWhnl2RQ9yU7NfTTfUvJhQk44j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:04:10.0724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed7895-e0d0-47ee-95ed-08df358ad4c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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

Commit 02232367be23 ("drm/amdgpu: add spm_vmid and exclude it from the
MES, KFD and kq pools") took the SPM VMID out of the kernel queue and the
user queue VMID masks, and since commit 8a9263fc8812 ("drm/amdgpu: use
dedicated SPM VMID from the reserved path") the kernel queue jobs of a VM
with a reserved VMID run on it. The gfx constants_init() only programs
SH_MEM_CONFIG and SH_MEM_BASES for VMID 0 and the kernel queue mask
though, and init_compute_vmid() for the user queue mask, so the SPM VMID
keeps the reset defaults: no unaligned access mode and no apertures.

On navi48 VMID 15 has SH_MEM_CONFIG 0xc000 and SH_MEM_BASES 0 while the
other graphics VMIDs have 0xc00c and 0x20001000. A shader storing a dword
to an address with a byte offset of 1 writes it there in a normal
process, but at the dword aligned address in one which reserved a VMID,
e.g. for profiling with SPM:

  $ umr -i 0 -sb 0 0 0 15 -r '*.*.regSH_MEM_CONFIG'
  gfx1201.regSH_MEM_CONFIG => 0x0000c000
  $ amd_pmc --run-subtest reserved-vmid-unaligned-store
  unaligned store: 0x0000000000002a00 normally, 0x000000000000002a with a reserved VMID

Include the SPM VMID in for_each_vmid_and_zero() for the GFXHUB so the
constants_init() of all gfx generations program it like the other
kernel queue VMIDs.

Fixes: 8a9263fc8812 ("drm/amdgpu: use dedicated SPM VMID from the reserved path")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index c134000eecfd..6d0f302c1344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -45,14 +45,17 @@
  * Equivalent to OR-ing BIT(0) into id_mgr[hub].vmid_mask and walking
  * the result with for_each_set_bit(). Used by the gfx_v*_constants_init()
  * paths which must always touch VMID 0 (system) in addition to the regular
- * VMIDs owned by the hub.
+ * VMIDs owned by the hub. On the GFXHUB this includes the SPM VMID, which is
+ * kept out of the pool but runs the kernel queue jobs of the VM reserving it.
  *
  * Relies on AMDGPU_NUM_VMID (16) fitting in a single unsigned long, i.e.
  * vmid_mask[] being a 1-element bitmap.
  */
 #define for_each_vmid_and_zero(vmid, adev, hub)				\
 	for (unsigned long __vmid_mask =				\
-		(adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0);	\
+		(adev)->vm_manager.id_mgr[(hub)].vmid_mask[0] | BIT(0) |	\
+		((hub) == AMDGPU_GFXHUB(0) && (adev)->vm_manager.spm_vmid ?	\
+		 BIT((adev)->vm_manager.spm_vmid) : 0);			\
 	     __vmid_mask; __vmid_mask = 0)				\
 		for_each_set_bit((vmid), &__vmid_mask, AMDGPU_NUM_VMID)
 
-- 
2.50.1

