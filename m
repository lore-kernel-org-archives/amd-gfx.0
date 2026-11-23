Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE6606A32E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zadOgchM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC8210E195;
	Mon, 23 Nov 2026 02:47:56 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFDE10E134
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 02:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM2W2yBbnvRzti35vAbYFPHqlM6FpBQjGmzU+HgQaLW9cBwka+J2rYu8HREgIUOcxTo50aviGcgWXqWdGrvXJW9g8mEyAP/ePsM4trUOl23ovI6+hg6vNaMVycBZuEkEytQcfp/r5AZiVNgII6/IaSjJQs8kaAbsY48pdqSkLc0g8BUY7RZwgv1AayfOadDj+buLUBRVqeR6lrE93ZtEvFKx2gvebXtGop3t3AuFGNYMJNNZXrGM+iXyu6QfaledWk3J+OhK5XTuBOUXyPMSxK9YZIKySP/hWXMoB/Dc2k6e6iBAnmtxJ/3z+tSy391/MNXcJkuflMRO/6sOWLnisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+cS7gT+ru8zHTnALRE0jKg5g1flpPeFT7K/dZcodSc=;
 b=jesOjE0dxxE5Pf2EE0WQZ6UAQ7mXCGy44JweVNExARy5ubQL0xyfWAxYe5U24t1nd7aXGKlLaTIIhRyd/Sl2iGZaMxeMObkXPBCOXsPBBLujiavNiiK/IktuPpjK1d7eQTDM64NVIhyKJVLJ1hhXHFLT68v5wHNpPOKLIlRwlnwU4QdI/oBnuC6w/CzVXQDqofS0IHzwOP7p58jOEaEWFkPt2JgtA1x5uevNdPrRSxXdHqHmn386uhA/Swh8N6A48Bn9TG4RaUu86YB7uqkLhU5qMnqkGnraB9hU32MilDA0KKhW5sQh5NKCvc6Q9tZaimvZviK26jEuu4eZKI+f9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+cS7gT+ru8zHTnALRE0jKg5g1flpPeFT7K/dZcodSc=;
 b=zadOgchMs2hfMdXgFnLvcfenRDIP9WAsoTndE7vZs2Y/lDOkym9Px5OHoop27vxBNiHkLkV2EbmehhgwtXN6MZ8k/OaieJfRlrcJ4v/q3onXR4LgVTsv+TxXxZTmw4fBoATQbGBdN5+neF/U66ArmBV7BJXp3zcm5hs2YtE1UjE=
Received: from CH0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:610:e4::26)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 02:47:42 +0000
Received: from DS2PEPF0000710B.namprd05.prod.outlook.com
 (2603:10b6:610:e4:cafe::c) by CH0PR03CA0201.outlook.office365.com
 (2603:10b6:610:e4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 02:47:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000710B.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 02:47:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 20:47:41 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 20:47:41 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 22 Nov 2026 20:47:39 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 2/3] drm/amdkfd: return the memory violation data to the
 debugger
Date: Mon, 23 Nov 2026 10:47:07 +0800
Message-ID: <20261123024737.1475714-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
References: <20261123024737.1475714-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000710B:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc1e439-e45f-4169-0f5a-08df490c255c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|261009223027099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: LkOBeUndszsjjDX8uSUEOetwHT/jg2Pde6ZG7FLgZaV1O1f3s5oX5HD/XN9uPHwchit/gJGSv5A3D1CqIQzWN2yq7OwEeMe3FUAVtx/3zBjFRwPuZqr0RgONYcTuNf6kX0yimr+e8CjFbghBAYlGSUYK0J10L/sZpQbIFNS08vRiF3AVqnsyXXIPX9cUSuawUL7f44AP04otseBf+KOMraiXwJaCF1UjKxg2VuiMec88hIqJrP0D2LIw4GCNQgGyeJ6DHXpVwHv3JEM7xnqTbMYQNPrMN20AOwipgw3AMdJXbZWwPmc3DW/O1DIIPt00hGLsY1Wx4jqS3yHT42D/oK6hVvvHBzZ/0g5GqCsPdGGY067/ziFoLsSGPS7hqLkVoh12TA3SpNRqXYNgDECfjQ8nUOlk+U0DKfwbnVjgFmg3cOkajRRdpRqk+fmWfU4GtQ386FUcDofqBnoQ/PM7BekBGKsqI16uoiBIVhNEOMAd57ZOEbdwMFanDsauAUdE0YFPGmNH5E6r30c8/avGzKw9arUFk1UST6fmQbLPg5MpKcEIUHXKV/UMv/Fqn47XQbHyebMNI/+TkwbtFqXM5/xJVdxahp2BuBVgwSiMwpBQNoP+U6daIrWGaTxebmqVidMyx4TjW3ffD5KO7S4aUDxBaY1n9Uq8bBlYMHUfwxpiupYqb5UfdOyjCnlYjV8frIvdK/MT09J0FlHkz1pMtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(261009223027099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dz7mX00Dr3Zl/ViO8TWiwLF93mQhaD3HRvMJ+YW8S5Jyw6LpMge1RbOIJ55+t3h9lg7G/vw+SCqgRzuhoM8OphaUbWpHfDS/Gi3qmIHoUZgVfgw5oIDDc0nehT6m9ZFndSj2r6FcnhR3sQBxffSqyvzVMOtsyxgazUELtMhHcG1CoGXlc33cljGgaiEJWxai6PZhUU2L5Gt+wZ5OFcmQ6XEhpLAOTRJpQQIkJ7X3xRZsfI9rIfb0WgPGu9DUGF2DFDABSVeY3IFjpWlmB4L5v7wD8hUHYan2WD5Z3CDhoD9mTRGfIAddFBAwJE175HZyiuyUgAzDRyFj+5ueEdqATdnsZyAu/Q2w2o+YKCJgmWeu05eOXU4YFSmFZyTO8vvXaMyKw2SdwlpmPtwIFDYlU3bTSKtqUBag0ThWt/Q2tpkrwmF+E9foLu1ng1cZGskh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 02:47:42.4339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc1e439-e45f-4169-0f5a-08df490c255c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000710B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

kfd_dbg_ev_raise() saves the memory exception data of a GPU VM fault for a
debugger subscribed to EC_DEVICE_MEMORY_VIOLATION, but never sets
vm_fault_exc_data_size. QUERY_EXCEPTION_INFO copies that many bytes, so the
debugger always gets 0 bytes and no fault address.

With a process debugging itself and a KFD SDMA queue writing to an
unmapped VA:

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:8 pasid:63)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000060200000 from client 10
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA0 (0xd)
  memory violation info: 0 bytes, va 0x0 gpu_id 0, fault at 0x60200000

With the size set:

  memory violation info: 32 bytes, va 0x60200000 gpu_id 51573, fault at 0x60200000

The data is also only freed by a query clearing the exception, free it with
the process device as well.

Fixes: 2b36de971d25 ("drm/amdkfd: add debug query exception info operation")
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d5c87de519ac..14e7ee30cbdf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -143,7 +143,9 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 							exception_data,
 							exception_data_size,
 							GFP_KERNEL);
-					if (!pdd->vm_fault_exc_data)
+					if (pdd->vm_fault_exc_data)
+						pdd->vm_fault_exc_data_size = exception_data_size;
+					else
 						pr_debug("Failed to allocate exception data memory");
 				} else {
 					pr_debug("Debugger exception data not saved\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index aae2c698103e..44b11950b7db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1289,6 +1289,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
 		mutex_destroy(&pdd->doorbell_mutex);
 
+		kfree(pdd->vm_fault_exc_data);
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
-- 
2.50.1

