Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00D9C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 17:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE2910E2C3;
	Wed, 16 Jul 2025 17:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K3aCtuEC";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38DD310E2C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 17:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEPITwEp3FEVcTbPvcpDGCSjgEG9DQpFOQJp7gBmy+72ShpmhqTM8UxOa0SaBqOHwJDg49lWc40A8pxSKTshaT4xV59mQOsAYhcsu7AAJNZOOx0YnN2PycTnGZLEQuBNiMt3S6HiloaL1QakqXVB0Ez7TPYLOB9OGVMjKgs81o6lL+IIcwsctv2Ylv3wr3/ooDn7E/uDby0J8Oe6xflndmbeR1bZlvmR6DjHR+pjwt5OHpkHBM3cN9MvDCtp8KD4hxMBCeMCqhe4hrFEsebmHXIRcteuR+dbnMi/UJ4AIb/rqeka+/iHGrZfM6FNHZSM7TtYB380SdUPpVx1Pv4nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1/hrqsX48EU6vnpI1BK639kqp/p+dc+E7QHO4EjUdc=;
 b=DtOU+PGc5j5q4OXfwKIfuMjiN5utF3tT9jKYdShmnw0G37wbNtIOsXWmXwDgbS2+CzFAwmsiKyh2r1Wib1CukLMIp/kjo9AyljXkYMyN3IPStZefsBWBhylLPDm7cmjmLC2zZsQQp6qQZunHWVvgDAe88tVDMzlIG9efc6jgCJoKIVxey6tPWcpzM67nlGdiWqC/puM9oWa5nR0st2pkG6IZT40iJ1Jxa09xLxUTix+04VlSIxnYnqhjoS+nynlTfgsWJMy8t7KE/tcvMYcs6KHLCnXaNye+Jg0cEbG88FXnpH+osSFi3mU8rabYhIYC+Mj3Lpvc1j/PxSMm26pnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1/hrqsX48EU6vnpI1BK639kqp/p+dc+E7QHO4EjUdc=;
 b=K3aCtuECqwrZHR48ZkoH3AT2bo+aCKOew2UCtNcLfuc+Of1Qy6csmj/FR2y7Osmy5/cmAJgOZ6X5rdbCy23OFChoDAH90qlBfGoHVL4VGUtxsyfcVVVWD9iRtNGprWjuidIZe/7APnHY43i7gF8dWfRzUJ38/8PnQjhaH75DNgA=
Received: from BYAPR02CA0067.namprd02.prod.outlook.com (2603:10b6:a03:54::44)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 17:58:12 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::b6) by BYAPR02CA0067.outlook.office365.com
 (2603:10b6:a03:54::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 17:58:10 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 12:58:08 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: Avoid extra evict-restore process.
Date: Wed, 16 Jul 2025 13:57:53 -0400
Message-ID: <20250716175753.703955-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8357c4-5129-4a74-6342-08ddc49253d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1kvb1JzYlI2QzdRTG40TzBzeTVlSFoyZlJ5bTM2SW4zMDFNa1hneEVMdjZn?=
 =?utf-8?B?dnUrcCtEaEhYOFIwZDBrL2RWOTBpamtacGV0Y1R4Ri9hZzh6OGFuUDFZM20w?=
 =?utf-8?B?NzhHbVMxTkJwbFJJOHpMZGZWVFVpVEhFVnp1cXhvU3RBV2gwSGtMSHlnSW16?=
 =?utf-8?B?d1MwSGg0WkxoeW1NK2c0ZmFFSmYrNWVaV0dYZWhxNzlXUTZLYnNXL2gwT2N2?=
 =?utf-8?B?azlXOW1TMzZBOVBTRktiaWdZTjJIUWNibzVja3dJK2gveU1WK25FM0VqeFVB?=
 =?utf-8?B?djhVZTdsL1VMeHlVKzQwdFJqQ2R1WUV6TURFaXRFb2JlWC9UZzlVRlhlR1dL?=
 =?utf-8?B?T2xEQlVqUHE1aVFUZVI1N3V5V2dqTlV1SkNZTFEyekZTRWlDSEd2Y1FOYjEr?=
 =?utf-8?B?L1I1UElON3RzdWlMQ1gwTzMyalhyUldWcm9kMFQ4ZXpOd25kNTNOUlhZN21h?=
 =?utf-8?B?M1RJbFhFU0ZqMWh5QnZxbTlUQVFhelNjRFVFS0s1eFdQM1l1Skk5M0lBckhN?=
 =?utf-8?B?L01oZWQxTXVRT1R4WFd1cWdxdkl6VmtQVDhpR0lHMnZRMW8wZURRcjVkMWFX?=
 =?utf-8?B?RHdPamNmQzJ3c292YkZscDloSEpmZWFDRjRkNW9kOFVId3NOWHpWd0x5ay9l?=
 =?utf-8?B?MmU3Q0dhSFA5V1lXS0ZKTTN3SVNDMldiek9HUFQrOUJKOWxoa2wrN0t0RlNG?=
 =?utf-8?B?WUg3N2loWEo5RGkwQzJ2bmJra1hhU3hPcHh3bDM1ZlZYaEFXbUNTOGlyQWI1?=
 =?utf-8?B?aTZtNlJZbFdMU3VOb2RIaitUUk5vNzBYQS9kQVord3pWYXNjeWpNb25FRS9I?=
 =?utf-8?B?cEtCWjZ2REdUYXdabjRvMTFJZElHOURpNk82RXMrMThaQmJvUGZzcnpCdHkx?=
 =?utf-8?B?aGx6YWl4VG0yL1g4OVdBUUlqSU53ekZCWDNNdy9wQ0taeDR3UUNBWG9KTVJ4?=
 =?utf-8?B?dUxDaHFUSEdBbTBkdU5WTXF0ZEsxWnVFVjNxSGxHZG1qajhpVm5HZWV3czhu?=
 =?utf-8?B?UjRxYUJGdmpxOUU1OFg2UXVGcnBNWlo4akY1Ymw2T3lhdXB0TlIrN2g5d1F0?=
 =?utf-8?B?MFBaZmlmYUlKUGlFUmJoQ0lST3F1b1dOTC9hMFg5eGtOT1F1QnNRUGhnM2ls?=
 =?utf-8?B?ZGNWYU12eWNCSVJtWUg1T2NoTXduQlFrQVZMNDlKKzVHcHRvMFd2ZTRQS1VU?=
 =?utf-8?B?ak1Ic2cxWEJvY2NRUURhUVpiMktKVXFJTnBWR2VFYVZnaGxLRXVtNHhCaGxz?=
 =?utf-8?B?UzNVQVFLQmxTSXprQkZBUjF6dVRmS1RYVndmdStZbUthVHNMUmlvd2wwNkZD?=
 =?utf-8?B?K2dhZlRCN2JDem85TmhOZnRNQ2VDR0VXUjFpMjJxdEx0OGJtQVEyeUFIYWJi?=
 =?utf-8?B?QS9adXFUcVhBVjR2dllJWkFsZ2VYT0o5NkpnZGM4SXdWL3dqampudVFPVVg4?=
 =?utf-8?B?ZjE2eDdYZ25mKytmVHdYT0ZZSElSSnF5dHE1ZEJSbHZJcW1kc2YxL3VmNjI3?=
 =?utf-8?B?VEFCVlQ2Q2g4UFRmZEZwbWdnU2dhQ1kxeVEzL2V2blNjaTdncU9kZkxLdmJR?=
 =?utf-8?B?bDMvRnlvWGowdUw1SVMxRmdZUUNJRXRCMW5YbGNlUEIyLzZRcjlPTWlhc3N3?=
 =?utf-8?B?bFpFSDBXd1ZqMktoMkluWWxETFlOc0s3VDI4bDZpN3krM1UxL1prS0Y2cDRB?=
 =?utf-8?B?Q25BSlNsbzI3YXB0eG1iSm9STGJKY1JhK1RoOHFmazYvNDZNYTdtUTl5UUhj?=
 =?utf-8?B?OVpxSDJTaDYwYk9qd2hLaFFYbWdkQmUwcFFQZVptN2J2LzhRZjR2U0piVnRX?=
 =?utf-8?B?b09yNDVoT3VObTFsWVQvK25KclV2OUcxTGM5TzZGcXpOWG9SUmtFYzNDdEE1?=
 =?utf-8?B?K0Z1QWFIanp5dFZHQTZqa2NuZ1RiTVVMckh1VXFtZmowMmZ4c0lselAvS2Zl?=
 =?utf-8?B?Q2xPalczRkpDL1lQMFM2cHlyR0hCVUVpWkwzck5yKzNEQWpiNDNJR1V1UEQz?=
 =?utf-8?B?R3pvdEgxRjlJbWd1OHpseStVZ2gvdTlXMnE4elE2NkFKKzdtN2dIcE5iOTRJ?=
 =?utf-8?Q?J5kH4m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:58:10.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8357c4-5129-4a74-6342-08ddc49253d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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

If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.

[677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
[677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
[677852.634820]  dma_fence_wait_timeout+0x3a/0x140
[677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
[677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
[677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
[677852.635208]  filp_flush+0x38/0x90
[677852.635213]  filp_close+0x14/0x30
[677852.635216]  do_close_on_exec+0xdd/0x130
[677852.635221]  begin_new_exec+0x1da/0x490
[677852.635225]  load_elf_binary+0x307/0xea0
[677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
[677852.635235]  ? ima_bprm_check+0xa2/0xd0
[677852.635240]  search_binary_handler+0xda/0x260
[677852.635245]  exec_binprm+0x58/0x1a0
[677852.635249]  bprm_execve.part.0+0x16f/0x210
[677852.635254]  bprm_execve+0x45/0x80
[677852.635257]  do_execveat_common.isra.0+0x190/0x200

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea9b0f050f79..2f75f967f95f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2414,13 +2414,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
-					DMA_RESV_USAGE_BOOKKEEP,
-					true, timeout);
+	guard(mutex)(&vm->eviction_lock);
+
+	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
+	return drm_sched_entity_flush(&vm->delayed, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
-- 
2.34.1

