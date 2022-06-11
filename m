Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749E2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jun 2022 01:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025CD10F399;
	Sat, 11 Jun 2022 01:04:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A30010F399
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jun 2022 01:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQwkXsXLm7Dn4KbuznkAnJERD0cQ4caO1ojbWqqVttkTW0D4nEA9W+FDKvGZO0Z8aKeyOKrRMywgEcmiWOXZG8wjWUnEMuMa7BhlL5+n8PH2sfkR9kTdWjpotLIngFvBvrGOCU8M0NPNlXlnitS1CB2v60XxCn52c7lXx4bNsrdXbnmBPKd1GXZAMJGdlNZWSeFW0c4jtGLlWLlcnD9mgR8KH57QB7MaWMsOY/jxTKn4TxoVL9P2N2ws0x9tb7/Vg2bDEyifF/eAdclGMdHRb0s0BGtP7qTP367PQM35HuEuOJ5DW1N7c4t4U3uOp8TcYfFxCm8TRG4GsO5DroSzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La0CrbI6q6pdWEKQVTXTixX2FLnQN3shkgkwvR3ER8c=;
 b=ZFefinCl9wFwX2Y+PRp8mPXwN/BpZGI6XBm2NpVWyBGmNDd/STMZnFNX/TLdFukhCGkhVxXq3rMCyNarWgsL/wIniwFtCjz+p1Amod8n5JUc1dr3eDSnqLyj7IVKEmOqXpxAnLWmq4/InnuwCRwycY4VRKW8yQvn1QG8U09wG1WZhnN2ryXWDDEFCyjaVNFZNbcNTz9k5THUXQ2740kwXTAXJ24IgxuiHwDKbSPNM3R3Qgvw+KQJgXdwtSQCA/C2VDSXPLCcbzsruwjh6q4wJruHpGFSHmPU2vMuZCdFTD8agrT5ZsWd1ImXJRRE8TUV64tOZUk3Jfa0+f+N1eRjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La0CrbI6q6pdWEKQVTXTixX2FLnQN3shkgkwvR3ER8c=;
 b=sekk3QaSPxo3DvJiQsiZKL13foBqECCCkv9cpX0Qa+Vp5yJC6D+Dnt8pcE/5Rv+WRGUXxl6WG92pPQ88O8Q+YstV8lghQtha73LPAwba5lhKHvZXmbYm6lMpltTPcCHjq0ARMNTrDmEJWZQBnq7RqaNPg3d/TX2K7f3kdTL6pq0=
Received: from MWHPR12CA0056.namprd12.prod.outlook.com (2603:10b6:300:103::18)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 01:04:31 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::82) by MWHPR12CA0056.outlook.office365.com
 (2603:10b6:300:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Sat, 11 Jun 2022 01:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Sat, 11 Jun 2022 01:04:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 20:04:30 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Remove queue sysfs and doorbell after
 unmapping
Date: Fri, 10 Jun 2022 21:03:34 -0400
Message-ID: <20220611010334.23401-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bac905d-1f8d-4f8d-2c72-08da4b46574d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6384:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB638471A9F1B055B2E01CDB6FE6A99@CY5PR12MB6384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKf0QKtJ/Q+nPgIZmU86Ac+tEjP5UrPvwTTudG/BBiQZ0gdpe8PaMOELXK1uH8Vau5VH6GXeC8YbkcykQoDc8LH3gFnJFaIoACgJOLCQkeEFu8sc5zyMmGQGroG6AS2b1Qd/9SMAxXBoVIJ07J9wwz2pmsr8Zw9nFqCGfC0WLyN0/jyBKIzOHwWUiiwAE3Pu5DpGqdFQiNfDQdOK3y0goe8wvjrR8kyF7xaf6wtlm2e72NYYfps5rC/RCDodAVVo40Fndx0tY1E1s0xURa7RJe1tiMmV1Q8wqsVYbeJ9MpBWW5Ug9vW2CN7rMWiZL1CrI59N5XH5oAsZHZRHF2++P187w3ZKX6Hjd0pM63f2wQ5zHyBeZUPOV2ew6FfhHCTI0hcNVT/aUrEZx8AsNoU/TGNhDCT/EfeyDGogCcHSMcRYHynqMPjp3+xlbBrVi6h+AgePIOGMYelDDTVjxSihGWJI+O+mHdMdnEB0gVavnLEQnQFOaKoKfAj1CM7ZDV5nIk8TQrJo6/7OlBFh3Zb3YY/kso8O5qKXGup7j1l01CBOvTSWknUkXGH+4nN0STFqrWNKq73ixbp1kXTN5Bn1bMXUdvgcu/ewtjJ4VHuN0+iorWz5yH5DaHPFVnvprgjfx87P/HXa5RMIfMcK5PzDyzgV5b9EW4hqmOwnj5pGYesLBDQrFeSMG9CMvXo3NjuD37sDGKBde/johHgpcQIe5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(7696005)(2906002)(336012)(47076005)(426003)(36860700001)(8936002)(5660300002)(26005)(508600001)(81166007)(8676002)(4326008)(82310400005)(316002)(6916009)(356005)(36756003)(1076003)(186003)(2616005)(16526019)(86362001)(70586007)(70206006)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 01:04:30.8941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac905d-1f8d-4f8d-2c72-08da4b46574d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If destroying/unmapping queue failed, application may destroy queue
again, cause below kernel warning backtrace.

For outstanding queues, either applications forget to destroy or failed
to destroy, kfd_process_notifier_release will remove queue sysfs
objects, kfd_process_wq_release will free queue doorbell.

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
  Call Trace:
   kobject_put+0xd6/0x1a0
   kfd_procfs_del_queue+0x27/0x30 [amdgpu]
   pqm_destroy_queue+0xeb/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]
   do_syscall_64+0x35/0x80

 WARNING: CPU: 2 PID: 3053 at drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
  Call Trace:
   deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
   destroy_queue_cpsch+0xb3/0x270 [amdgpu]
   pqm_destroy_queue+0x108/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e1797657b04c..1c519514ca1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1876,8 +1876,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
-	deallocate_doorbell(qpd, q);
-
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
 		deallocate_sdma_queue(dqm, q);
@@ -1898,6 +1896,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		}
 	}
 
+	deallocate_doorbell(qpd, q);
+
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
 	 * type
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index dc00484ff484..99f2a6412201 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -419,7 +419,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
@@ -439,6 +438,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		if (dev->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
 						   pqn->q->gang_ctx_bo);
+		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

