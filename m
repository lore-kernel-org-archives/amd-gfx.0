Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0259C982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6328A10E38E;
	Thu, 17 Sep 2026 11:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rhdIkZJd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6774D10E38E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iej6xiqJ3ce5ux9jA1A+Z52PDYImKr2aBKOcRtgRwtC8I8/vlIryO9HriMjOsFmYxKqeOuY5VfnpzmIkn0J7UiP9Pmg8JX94UhsgCYLIFCgVGPePZ51pRstlKXOzOoYZiumiRpr1H/Kruk5F1ykXytaxr2nPOQwFnUo/DIu0HSNqYjhX20iJZVzDLoZ6Z82DsDYOynPigVx6IrVI47Bwsvk64yF7yFYfQM+4+JcADHTJq58dd40D2c51DovSLtG4RvnqPZddrrA3N0hYQfTE0eJNOorgyluBlEW5GWIX4tsBDE2Trra2A8wujLkdErexnB9ykj6Se+SREWEsE2r0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t54JUm/ZewVv8Cz40EfQRdPMJ1Ehz4O4DiEb+QH2ksI=;
 b=P/0zfgukHrQIEUTGIaipiLZiQbybamE98UPsfvNPSdNUvhv5/+u8tnsT6a5xKa7fnOocxQycvN3POCMxODCl+Ot7Q2aharrZAryW7140PASLY4x5HIZTjnODxHu+bYTzdEkc/ZlE76CQMXTo6Nq3zrboyhBbFWFpZB1sjmpqsPhSyyFdaXIqhtGuCa3ndJ/oWU02p2etz57DrIBXwqwfmBb3Z16A8H/7Dx6fVkSfXh8hxoH/TgN53+aoUMssH6HkZmiHpAduNzPLXbAbF5wGXOwKPOui8uj65rrzHv9uC0T8oRZMa/TzC4StO/G/8dYn3SKzMlUqPfe3O/pES06BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t54JUm/ZewVv8Cz40EfQRdPMJ1Ehz4O4DiEb+QH2ksI=;
 b=rhdIkZJdjjtIusVLnB8EAsP9FN/rEXUWt9ROHI3Pul8uxWbQv8d4gRTrdDHYWhH/TqRvenRElwXIoJ5fO0cDA1ER1oXLCttmxfUrJR6C7vb5PZtiDstU/eZXFvyZVP74TelHXB40c3mH9JSoWMWo23SCwohy8FQgsMa52e+jpc0=
Received: from RI1P284CA0016.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:150::15)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 17 Sep
 2026 11:02:43 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10d6:10:150:cafe::21) by RI1P284CA0016.outlook.office365.com
 (2603:10d6:10:150::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:41 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:38 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] drm/amdgpu: fixes for the VM critical section and page
 fault rework
Date: Thu, 17 Sep 2026 19:01:45 +0800
Message-ID: <20260917110158.296198-1-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e87d27-7d11-4745-f5a6-08df14ab31c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lRE/qhghe7k6bpQxNaAVvo7RszA1NO97tBdFyBVyqFTxB/CguUJcX8OzqAip286uissNJXVUUbOadrAvMvfeXsp+2jQBX2PxTpHg+lKD3dUIYpV0omAARLWvujq+aHCj6agHDLda6ttO8IfCIG0i9kopkTZanHbVoBJozlKKkYEx0776zpFHq7gtT+OxEd7E6+1vnIXQf5Dr7I6lWecB4nf8JkHC8MhLOwA3Oro/LZkhT3F9WaLhdWcFsMVxSUVc5czeiZXD10vT1whRT2rJMuh1Ov9T/50cBTx7GmBXfh6ulZ9aYd9swCMeYl/2kQPs+132hnwM7Q1ocXTD6ypAV7+eNFrQSAt3R4HrL3XwUXCoVLpNWkAbtHxO7Khsm2hc8IgbTQh961MeP6+hHdZ/eX6SU5FshoX6h4B1sSbzJw4Z9mjzjviPf7MLIkHE9zy+SZujPoNXIznmSm8aYHd06SnhnDw13OLiSXAkoRM2oL8gh2ozSPmeeRCraWCvxKcjUECCIydjl2pC1C7UG8RTtdj4gHbGzFrOkKuz4fnUedhAm85hWL0PlSgQDajCTMHzIPuptNsZ3y/GwE8K6jEPz2cixxbPFjVBZcNxwwT24M6Cf4MMpkCI1reRkg1kq45VqhJFjuShLwoLWE0HDozc7KP7XxFzdbepvK7reI7GSnH1FygMaki+jE4IS81rwgjzkQ4HCTL/tUX4EvGsh1+ZTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h6BZUcZgsjPAaQgPUVqzYs9L6//UVUF9JjP6dL9mfSaVrqKHviNUkjakJt4ugAPxmxlFjZhRT0CbkFFnCPspkjEwxs1i7s/Ddk9QGdRnimfOsxadfRCZbBt/sKIAJ82L9QscSiYygDTmsRJEEzz42mHBxMRyZ14t0wKOO1FmOuiFTxtXJiXIwUdw7P73P8cilgzjbegCdwnjlC4nypfwhU0HndBrSKn1tZJbWC6PDHOsWc1inwLQ1RGmNZ4ivbOQxJ8ahZ9TZNBCxXsknkBn0jVUlJCvuzQ/Sv9Ty5eYtCRtmGKc08/Oyc5DoTb2W8E64ULvDu/FVUfeGUT8aQlGjeQ7OJmz0FgVv81JwP5n2KlzhfSZ9ZHgLxxL2V3dEL5B7Blz/920tHqtOxtsEFTMDBGMsUHO+fdbYSRZ5wqXFs2TDDRx79IGWENfv8r90y7z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:41.5857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e87d27-7d11-4745-f5a6-08df14ab31c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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

Hi Christian,

patches 1-8 and 10 are your VM rework. The other four are fixes found
while testing it with KFD SVM on top:

1. patch 09: amdgpu_vm_pt_alloc() leaks the new PT BO when the
   allocation succeeds but the VM is evicting once the critical section
   is re-entered. Release the unpublished BO, keep the critical section
   owned by the caller.

2. patch 11: amdgpu_vm_pt_leaves() always updated cursor.parent->bo, so
   a walk stopping at an allocated PTB wrote a PDE in the parent instead
   of the PTEs in the leaf. Use the entry's own BO and level, and go
   through amdgpu_vm_pte_update_flags().

3. patch 12: both callers passed an inclusive last address, but
   amdgpu_vm_pt_leaves() works on a half-open range. That dropped the
   last page in amdgpu_vm_unmap_range(), and made amdgpu_vm_handle_fault()
   skip the loop entirely, so AMDGPU_VM_NORETRY_FLAGS were never written
   and the wave kept retrying.

4. patch 13: for a redirect to the dummy hierarchy above the PTE level
   the entry points to the next-level dummy PD/PT, but
   amdgpu_vm_pte_update_flags() treats everything above PTB as a leaf and
   applies AMDGPU_PDE_PTE_FLAG(). Encode it with
   amdgpu_gmc_get_pde_for_bo() instead.

One question on patch 13: it special cases the dummy PDE inside
amdgpu_vm_pt_leaves(), which adds a second update path next to
amdgpu_vm_pte_update_flags(). The alternatives are to let
amdgpu_vm_pte_update_flags() encode a directory entry when the level is
not AMDGPU_VM_PTB, or to pass already encoded dummy PDEs in dst[] from
amdgpu_vm_handle_fault(). Which one do you prefer?

Thanks,
Yu

Christian König (9):
  drm/amdgpu: start to move VM internals into amdgpu_vm_internal.h
  drm/amdgpu: remove unecessary parameters from
    trace_amdgpu_vm_update_ptes
  drm/amdgpu: allocate and fill dummy PDs/PTs
  drm/amdgpu: add amdgpu_vm_pt_leaves()
  drm/amdgpu: drop immediate updates from amdgpu_vm_update_range
  drm/amdgpu: split amdgpu_vm_update_range
  drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses
  drm/amdgpu: rework eviction lock handling into critical section v2
  drm/amdgpu: fix the HMM range handling for KFD SVM

Yu Huang (4):
  drm/amdgpu: free PT when VM critical section cannot resume
  drm/amdgpu: update the PTB itself in amdgpu_vm_pt_leaves()
  drm/amdgpu: pass an exclusive end to amdgpu_vm_pt_leaves()
  drm/amdgpu: use directory flags for dummy PDEs

-- 
2.53.0

