Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC5606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1zgA+vhJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A165610E0CB;
	Wed, 18 Nov 2026 05:50:32 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A42D10E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 05:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xh2V3wfLklW84+PjLWaR8yv6jrdaDDF+eBuCC8PwN9vtHAqV49Bfoa3IveD5memSuhJzc7K8SD0e1+JQuhR7iXCHkzEq01af8Iu2/GeIPI7R81oV+CMwFtGrRl/dt91ZS/jBFJZZVhUel37Eck2HQDCpsyBULZS68awfOGKSGJHieHwRFklDXYY9DNaG16eTj5u809/JeD8/YyHcdk/lXpf1bJzIqNiqIC/w3GJ7DT0e7qbqHh+RDIIo3ZUI6eKfznnpFfqlh4DlOyYWIfWQUT5S6OrKYm+VR9Kn0ubs2DhMEjlzdsBfprGLphk1rshELqAL6Dx3bIovEaRTTiMyfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI1si2wtkY6b3MMoty+DSG5hfpBfejqXK/sh77fuQr4=;
 b=PzcVPMs+Q6NOSqwXAU5MoiIhOViZ9uwB/imFZeJ1V5HJRjcWOK8gN7PrpA6PMTkuu8a5Y5C1MxDMsjrqxTQ/qA767YrJcdhLDhKKPZhBE5jCbC0J+BJA0QFirZzG0H+haRADj4Nxen1nOTT4F1C6fKkphxTw05GMYosVGZc/xG5OvqjUWRgHsaYPYDEq0STgq0V1jfL0Hcf9zA3v2HyS9hO/d1zOCwgMMW/iyXj8FtRU5w3zRxF0pftWzYvW8vLzttM/WEpaVzEZCSY+dFo+uMN/5A0ext0NXqnWHFhmTOXTyetCanfsUqujSKsJ7V0n8ap7HNuU/GQhYrvP7rJOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI1si2wtkY6b3MMoty+DSG5hfpBfejqXK/sh77fuQr4=;
 b=1zgA+vhJDHWbt5DVEgHx1aPdbEng13v7UH2x/wACyBa+XRH6y2FTYO2tw76BdpWOxfNqYkDovqhuqtkxobReKwRihyRDjZTEVizSq9qf8uDQv82i3obPI+aA/KTDCOhptbWIUWq8WLRp72YtQX+uwKTKMpq8Rn68gb2hQcCCeEE=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 05:50:20 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::70) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 05:50:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 05:50:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 23:50:18 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 23:50:17 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amdkfd: return the memory violation data to the
 debugger
Date: Wed, 18 Nov 2026 13:49:59 +0800
Message-ID: <20261118055009.3005630-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
References: <20261118055009.3005630-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: c3296743-fe2c-4c2b-1054-08df4537d473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|11063799006|10067099003|261102123227099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: laUd/bFRVuMjvdepOPw+vHIyv0sRxmXy+eeKkwEZoMezo44v9uRxbLfD0T3TjPKS88lgXEuC/zCL/AH2T+uOXf5RxsXsllpueiBpjzzez9RnCyNaREiVqLnaQAq9Tzj8/5+sBc+R7RAJki4YzNdHuTmKBS2F4itUFz1ZSA2Y0pcCVcfOTc3bX0jwuo1E7ho4YCcE1DfZ0dJBExCcPJ6yQi8ppTZIVGjD+EHqwoaBozCtGPmGryHRCVlA9E7pNFJAICIfnFWxWgRs634z6pQ0hErkWe9jjyJyiJsz83ROMVudliuXXcCp5+HEIIj541pftWYD3XRWNSp0WzdIorMSB82ueqtriGx3dqR8ikZ1BYxPl+tLZy/p4HsOJ3ECHYwVFWacerwygRSmy8M8EzSshWy8umKEoR0K0H59LDnjfIChBNQ3XdapOQb0dTfiA59wpYgUGdT4kr1Bn9yc9sy/pYYMwlSgkzZkmW9QjGrsbdfREGn5SxsPpT68zIy1v/e2BR5MsDtQw0NXs7k9YxaQRNnYc+JaAaoNRwA6t6jT4I54KbJhZFGKs87wCLVeyRwDBHh+6EjL6F8XDUSyWrN6UNOBJA6DhbMuS56CO75AES9QoIDOpmw2d8C4DCnuz5sqCKXnwkH1pgfBoVgHiShtOceH1Wc1DKQBxcUMSKpexIUfkdmkh8FnA6SzDCfpzilFBlkX0vjaTaDeRbw8b0/qMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EOgrFOXTtWJ3xgyzB7aW5O8pi9lmIFfUo1snE+7czKRu72EGWho65g+oJdysAh++K8v5n3OOmczW4ovDaVrEIn3k3d4jjEFncL8eAELYKZj1g+c9XJ0SS+O413Z3qBO+pkjUnXWRHbfZI5ey+moaj4s+8RlvmQ/zxNnb2UlsOUBoNeV7tpk04tsEG+iVcW7crW+4jXSixG4YtNcB8vlAtFu6Ml2kKIKuLZIKZCduTPejyIJI1KDjMk2IbuzZM5x6GGvXZZhzG/yZnSl3sY+4jyyzTFKfvt2DLhkoqxuhYZrX2+ZYjETjVZxdq7odz+lzK5CN4COApvNqQ+qwE2f2JlW3lXlVY9gqcb6VdgsykO5ot/pp4o0pUcjVeJbct4d6DpUtgudDKPYQJed9/0X/WYhOCu28KwMP95aTj1B4RbSk83GQeE59rKB8A+nMD4NJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 05:50:19.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3296743-fe2c-4c2b-1054-08df4537d473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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

On navi48, with a process debugging itself and a KFD SDMA queue writing to
an unmapped VA:

  amdgpu 0000:03:00.0: [gfxhub] page fault (src_id:0 ring:40 vmid:8 pasid:63)
  amdgpu 0000:03:00.0:   in page starting at address 0x0000000060200000 from client 10
  amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID: SDMA0 (0xd)
  memory violation info: 0 bytes, va 0x0 gpu_id 0, fault at 0x60200000

With the size set:

  memory violation info: 32 bytes, va 0x60200000 gpu_id 51573, fault at 0x60200000

The data is also only freed by a query clearing the exception, free it with
the process device as well.

Fixes: 2b36de971d25 ("drm/amdkfd: add debug query exception info operation")
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
index f959f19d92d2..d57eebec063c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1288,6 +1288,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
 		mutex_destroy(&pdd->doorbell_mutex);
 
+		kfree(pdd->vm_fault_exc_data);
 		kfree(pdd);
 		p->pdds[i] = NULL;
 	}
-- 
2.50.1

