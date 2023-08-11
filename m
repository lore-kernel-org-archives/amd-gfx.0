Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD3C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 19:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330E010E0FC;
	Fri, 11 Aug 2023 19:11:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001DD10E0FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 19:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXe25jegQgtjKrJZ+XAfMG8VYYU+o1+dW3oeLCBWsUnvvHoTTPHAN1OlVe+MmgOuVVC+4DSLSjqZrpqYpWyQbdTb0ac8H+0h8WBTyEzfh7XquXddtnQ96MSJmythEnY5RzaanE2AfhR0GJtcTiwv3mjoxusIHpebhpVl1fydTbnduTfXdjD1S9WOucbNEP1iReqL8vmvrupgQuvuUVjk1acIK/JiPYS0RefzCvpyrPrNT+KD1BZR31Vnph+rzGW7BOx7Mm8gptBi6cHIqD6lGLDmLV9+ZYaJStf6iF8wuAAWCEW5G2ZzyjGxxGyBSVgodq/RJXKVaOI9oN3I6SSrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsUeIVgmNmq8uqqtUPEHzrwJgoq5SqLhGmhG271FKVM=;
 b=UkJtkzXMXjeINIvIIMhnFZpJUlKeSwGkYVtRaXN4ryanR0/PsOieCVw5pKa8i8yZXbSCrKWXD2Yd9MJSomVnd9M1JOYDKkk0n9+Guw5IhLJeGv5S3QoQ/ZQKv8Gvobu6bDBwa8yAmVDKLhM3daeiRNScuSe4TmgapMYC3CzL0D/oorK/6C56jux1KaOKNpK/angPDyE+kb4/Ikxx1wFAEFLtTpXmt6K5FaiP19lauvfUtzPFibMUCOQAssas5O65Fo2bR3fYymPOPYuHv+/CfDFeG5rtYSpfUpo23tIYhNa8yYclFYyDuiIlI0Bg3Nm3jh7H3P4/2lqf+f2ifjbFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsUeIVgmNmq8uqqtUPEHzrwJgoq5SqLhGmhG271FKVM=;
 b=SjLHanYHdqXKUj0MqGIaoHgW/d+BfJaWTKuGwPHcaPeKW4/n/9a5w0fjEHP0oCAZq9Gmmel3UsSzmfzzjgDEBkrmG0o88ZXG2p4+bswbzSYD0TCqFgj83Iw3LxGy1Vvd0y360def4RrRiOmoRDU1CgdMLbOfP5+lrjV4rCPQKJ8=
Received: from BN9PR03CA0929.namprd03.prod.outlook.com (2603:10b6:408:107::34)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 19:11:37 +0000
Received: from BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::56) by BN9PR03CA0929.outlook.office365.com
 (2603:10b6:408:107::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 19:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT106.mail.protection.outlook.com (10.13.177.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.20 via Frontend Transport; Fri, 11 Aug 2023 19:11:37 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 14:11:35 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Date: Fri, 11 Aug 2023 15:11:08 -0400
Message-ID: <20230811191108.1808648-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT106:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c765e4-fb3f-478a-a3c9-08db9a9ec8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdyV02H5E9cTBblPJc2U+c316DruGt890AGJnP2fYhPwYnETPhOE9qscmZcYtRWiU6nKdibdQEwnk0L/AmNupLJvf7mdgsSL44VtGFtkKbTVvUrEVHfP9GYLYkvvd976BlTacf6sgGRlBDkbQiEWdm2+IoDbTCVMmngMCTe2vbwg7W1/g4zGbArBmOOySUaRilf6bNeMeCxEuY533N9UhfqC2uRZUPqttVstDvRVlcol7LwkVP3Rkpckj1enPmfuOZ1DDsggJrpSvY8ESgpOxiJzT+wWYvcUXYcUJD9++ZmxBW0iXdpXi4cVcWvcC+0wmbugLzli2cNwiPopVaSBuKfODEqxSkWzA/4zVEntLmvYo6tDpkS0INRBihk8nvMCRZkOYHxgeSEXXhSqVZz/Q3x/X6GRY/8eRgVavJnUgUmli+J7uWpDwv7ylPDpkvRRb/szhRT4QkNJ6FUDn+i7NLks+keHXtP/ebZBXtDaG7jspDvEr8oVw1aXsvRHd/FPSdnIMuyEMbM01tdAd3BHdYLS3v0mb1Hr6QBO1DrJ4E2KNqb5qcrjyFpKnYmdtsXMeVVNCdNP8+g4XLIH3Za1V4kTcFGVbX+lOvA58puMbGY0olBzEIh2gkrkID7Akr473+P3o0qkr5NalRand3ftl7+1RTAalZPpdYmjkdbJIoml4WsWg8ue5klHUJ1KvTaQvDigBtyBdfO1Zv62SYXWKjGy3RG96N/zo1RFyJisyiI8PmEwIpHioSAuKcnTlNdR7wGzBuBaroCu0DJQz14Saw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(82310400008)(186006)(1800799006)(40470700004)(36840700001)(46966006)(7696005)(6666004)(426003)(54906003)(47076005)(83380400001)(1076003)(26005)(336012)(478600001)(16526019)(2616005)(2906002)(70586007)(5660300002)(4326008)(6916009)(70206006)(8676002)(8936002)(316002)(86362001)(40480700001)(36756003)(40460700003)(356005)(36860700001)(82740400003)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 19:11:37.0164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c765e4-fb3f-478a-a3c9-08db9a9ec8fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update_list could be big in list_for_each_entry(prange, &update_list, update_list),
mmap_read_lock(mm) is kept hold all the time, adding schedule() can remove
RCU stall on CPU for this case.

RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
__mmu_notifier_invalidate_range_start+0x132/0x1d0
? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
migrate_vma_setup+0x6c7/0x8f0
? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
svm_range_set_attr+0xe34/0x11a0 [amdgpu]
kfd_ioctl+0x271/0x4e0 [amdgpu]
? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
__x64_sys_ioctl+0x92/0xd0

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 113fd11aa96e..9f2d48ade7fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		r = svm_range_trigger_migration(mm, prange, &migrated);
 		if (r)
 			goto out_unlock_range;
+		schedule();
 
 		if (migrated && (!p->xnack_enabled ||
 		    (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
-- 
2.34.1

