Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52849ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917C610F316;
	Mon, 29 Aug 2022 14:30:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47E510F2FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wpvwu03N0W1rRXR30gNQ5HwdJDE0sdOoIOYQzh2sL3uwmynykcXdFedpDPGBwfXWPkF4lkhnahaYOHY58TTyLzUSLTtHfRhSM7g3bMldwA7IozQbkHQfsN0ggUIArk2N978UlsbLduwgekWQmz9jo48k6tzEb6o+uvFY1KVVOj9d1v/cUF6F0JvPerqnbBAtaCDI1IoNg+jHJ3PoaQ0smRrfmEEgqDtK36Nej7276yF4/BqaegJjPWgcJrHplcIcn2Bp0QlYrZ7rDn2b2hoBYQ5Fe+/gj1lfAmNZ2mgCW9shC4rVRwlGBPx2DukTv3OQ47YmMYS3gKXn65tEk/f5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGlUoKFOpcfsC0IETfxD5E0J8XIJt7naWbChUzTtU14=;
 b=O+B17ku5I4VPDNZL7b2YXYHrbfmWr0AFp+bwawk8Wbb3J49PEszHFPAkUQ6dyVc+BSlzx+9s7JhvczuHlau2bechRPXbkNiBBDdRYL+fEAIfJX4WwDRPMgE94FyORt9EWxpUyhvcOKgudFmX8uEk+/kFC25cpNWAKBvTzM/OiSjGGnQmZvIf5i4xQ4goe72Kh1Y5VlmeS0Ou+qNVtR+N74EAhGKqAg3xVIG5lWtv/QKtDRfukCS2LOrzU0rVYWQ11lixMEXXL/fDC2yC1ACpJxNRmmP965qQ02OKYKwG2JebI37jPfTbBMDQB6L7at406SGS4e7lpOZ0gsw63j59mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGlUoKFOpcfsC0IETfxD5E0J8XIJt7naWbChUzTtU14=;
 b=MrgkTX53BKjFPaBlNFaZ+IHRqvfEj4mVGd3I2mbdxmUTTR8FVis+xyG1EBTHT+y/8sk8wBE4G2Z0w+alp/TCXbVLu0EXDKMG/QZvUCdCtT/Y3HEKT95+qbXYa6luvN/ifUNpbPMSBaiXdQ+iwKzUD8AP4tcO8AJLTZoVdNLIDM8=
Received: from MW4PR04CA0095.namprd04.prod.outlook.com (2603:10b6:303:83::10)
 by BN6PR12MB1603.namprd12.prod.outlook.com (2603:10b6:405:b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 14:30:44 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::6f) by MW4PR04CA0095.outlook.office365.com
 (2603:10b6:303:83::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:30:44 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:40 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/29] drm/amdkfd: add debug and runtime enable interface
Date: Mon, 29 Aug 2022 10:29:58 -0400
Message-ID: <20220829143026.1509027-2-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6293f051-a0f8-4665-68b1-08da89cb0eae
X-MS-TrafficTypeDiagnostic: BN6PR12MB1603:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7ZWFYjCLOmyYraWDvFmEaN0rNriaC3gYrt4sCzYfk5ov6ss8natTjDBC1lpe4M1GKZPLxRhQSbbkauMR1CWpuM24Dilzs9MWuCXY1BZe1w7LXQKVDJm7xLMELYBiHueUH8wjryE/9pv8JA1DWeyBRCL1v1mRX8tyh0abuZoCtWH57uKp5g9MhMkOpt/QVHawA9G4EgKJhVeowmjNcXS8LwpuY7492U6BtGSmDm9Ifwll37XCBDkCmhfSR5fg8E9RYarBhCf/aOmkvPhEr71mbWegl+UvyHqFPboF6rcKEzROpqet/PXUquzvLw+7LcLqI/b7utI0W32/lUaRexbelnHM8a+ithtALXC3NzTuljMYHQrtNtbeGWeonXNjdqo0ceOcKTqe+jyqTtlL9mky2DXpoIxGva0U2bZ/55UT7u69I33mTSojtLUoMmAvair2QRelPkcfV1MzRmMJCKDmwweUnBmgoSrz5YcSrv3ks5phSfrJ9oHNacT4iAntgTSPAnAxdA+hWCD2K21COg99yerOjHMfjOyF+VHDZYTTlt7hZTzX1hA7HRUfyMwCkC4PfUh54kOqvF9iOH7eAkc4E5w2+8dk2qVCLU/uVx7AnCi7vW+FpNmBMOoAMZ2y98AdQnLI+5yt63YZl7W8W9i4FGAwnrGOj0QjcBbCltzRbyww65PSkJNGA+8PvadMiYoAjHmweXBQJEFEAqvhQfg42kH7L1KnGvHdNYlbxRf/EgfFeoULELBZctrpvqdEIYjMquFr9zbu71kJ9s9Zw7AN/RThz/zV+8CdwVSssm4bwukVb9fHDFV89ihI7Tz++ut
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(40470700004)(36840700001)(41300700001)(8936002)(40460700003)(26005)(7696005)(478600001)(6666004)(40480700001)(356005)(36756003)(82740400003)(86362001)(81166007)(82310400005)(83380400001)(2906002)(426003)(186003)(16526019)(336012)(1076003)(47076005)(36860700001)(2616005)(4326008)(8676002)(70586007)(70206006)(5660300002)(6916009)(30864003)(44832011)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:30:44.2149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6293f051-a0f8-4665-68b1-08da89cb0eae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1603
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce the GPU debug operations interface.

For ROCm-GDB to extend the GNU Debugger's ability to inspect the AMD GPU
instruction set, provide the necessary interface to allow the debugger
to HW debug-mode set and query exceptions per HSA queue, process or
device.

The runtime_enable interface coordinates exception handling with the
HSA runtime.

Full documention is available in the kern docs at uapi/linux/kfd_ioctl.h.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  48 ++
 include/uapi/linux/kfd_ioctl.h           | 562 ++++++++++++++++++++++-
 2 files changed, 609 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index dc774ddf3445..f6f4a348b94b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2614,6 +2614,48 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
 	return ret;
 }
 
+static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
+{
+	return 0;
+}
+
+static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
+{
+	struct kfd_ioctl_dbg_trap_args *args = data;
+	int r = 0;
+
+	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("Debugging does not support sched_policy %i", sched_policy);
+		return -EINVAL;
+	}
+
+	switch (args->op) {
+	case KFD_IOC_DBG_TRAP_ENABLE:
+	case KFD_IOC_DBG_TRAP_DISABLE:
+	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
+	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
+	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
+	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
+	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
+	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
+	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
+	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
+	case KFD_IOC_DBG_TRAP_SET_FLAGS:
+	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
+	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
+	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
+	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
+		pr_warn("Debugging not supported yet\n");
+		r = -EPERM;
+		break;
+	default:
+		pr_err("Invalid option: %i\n", args->op);
+		r = -EINVAL;
+	}
+
+	return r;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
 			    .cmd_drv = 0, .name = #ioctl}
@@ -2723,6 +2765,12 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
 			kfd_ioctl_get_available_memory, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_RUNTIME_ENABLE,
+			kfd_ioctl_runtime_enable, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
+			kfd_ioctl_set_debug_trap, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 42b60198b6c5..5517dd28b974 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -109,6 +109,18 @@ struct kfd_ioctl_get_available_memory_args {
 	__u32 pad;
 };
 
+struct kfd_dbg_device_info_entry {
+	__u64 exception_status;
+	__u64 lds_base;
+	__u64 lds_limit;
+	__u64 scratch_base;
+	__u64 scratch_limit;
+	__u64 gpuvm_base;
+	__u64 gpuvm_limit;
+	__u32 gpu_id;
+	__u32 pad;
+};
+
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
@@ -766,6 +778,548 @@ struct kfd_ioctl_set_xnack_mode_args {
 	__s32 xnack_enabled;
 };
 
+/* Wave launch override modes */
+enum kfd_dbg_trap_override_mode {
+	KFD_DBG_TRAP_OVERRIDE_OR = 0,
+	KFD_DBG_TRAP_OVERRIDE_REPLACE = 1
+};
+
+/* Wave launch overrides */
+enum kfd_dbg_trap_mask {
+	KFD_DBG_TRAP_MASK_FP_INVALID = 1,
+	KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL = 2,
+	KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO = 4,
+	KFD_DBG_TRAP_MASK_FP_OVERFLOW = 8,
+	KFD_DBG_TRAP_MASK_FP_UNDERFLOW = 16,
+	KFD_DBG_TRAP_MASK_FP_INEXACT = 32,
+	KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO = 64,
+	KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH = 128,
+	KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION = 256
+};
+
+/* Wave launch modes */
+enum kfd_dbg_trap_wave_launch_mode {
+	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_NORMAL = 0,
+	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_HALT = 1,
+	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_KILL = 2,
+	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_DEBUG = 3,
+	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL = 4
+};
+
+/* Address watch modes */
+enum kfd_dbg_trap_address_watch_mode {
+	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_READ = 0,
+	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_NONREAD = 1,
+	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ATOMIC = 2,
+	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ALL = 3
+};
+
+/* Additional wave settings */
+enum kfd_dbg_trap_flags {
+	KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP = 1,
+	KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP = 2
+};
+
+/* Trap exceptions */
+enum kfd_dbg_trap_exception_code {
+	EC_NONE = 0,
+	/* per queue */
+	EC_QUEUE_WAVE_ABORT = 1,
+	EC_QUEUE_WAVE_TRAP = 2,
+	EC_QUEUE_WAVE_MATH_ERROR = 3,
+	EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION = 4,
+	EC_QUEUE_WAVE_MEMORY_VIOLATION = 5,
+	EC_QUEUE_WAVE_APERTURE_VIOLATION = 6,
+	EC_QUEUE_PACKET_DISPATCH_DIM_INVALID = 16,
+	EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID = 17,
+	EC_QUEUE_PACKET_DISPATCH_CODE_INVALID = 18,
+	EC_QUEUE_PACKET_RESERVED = 19,
+	EC_QUEUE_PACKET_UNSUPPORTED = 20,
+	EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID = 21,
+	EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID = 22,
+	EC_QUEUE_PACKET_VENDOR_UNSUPPORTED = 23,
+	EC_QUEUE_PREEMPTION_ERROR = 30,
+	EC_QUEUE_NEW = 31,
+	/* per device */
+	EC_DEVICE_QUEUE_DELETE = 32,
+	EC_DEVICE_MEMORY_VIOLATION = 33,
+	EC_DEVICE_RAS_ERROR = 34,
+	EC_DEVICE_FATAL_HALT = 35,
+	EC_DEVICE_NEW = 36,
+	/* per process */
+	EC_PROCESS_RUNTIME = 48,
+	EC_PROCESS_DEVICE_REMOVE = 49,
+	EC_MAX
+};
+
+/* Mask generated by ecode in kfd_dbg_trap_exception_code */
+#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
+
+/* Masks for exception code type checks below */
+#define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
+				 KFD_EC_MASK(EC_QUEUE_WAVE_TRAP) |	\
+				 KFD_EC_MASK(EC_QUEUE_WAVE_MATH_ERROR) |	\
+				 KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION) |	\
+				 KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION) |	\
+				 KFD_EC_MASK(EC_QUEUE_WAVE_APERTURE_VIOLATION) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
+				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED)	|	\
+				 KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR)	|	\
+				 KFD_EC_MASK(EC_QUEUE_NEW))
+#define KFD_EC_MASK_DEVICE	(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) |		\
+				 KFD_EC_MASK(EC_DEVICE_RAS_ERROR) |		\
+				 KFD_EC_MASK(EC_DEVICE_FATAL_HALT) |		\
+				 KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION) |	\
+				 KFD_EC_MASK(EC_DEVICE_NEW))
+#define KFD_EC_MASK_PROCESS	(KFD_EC_MASK(EC_PROCESS_RUNTIME) |	\
+				 KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
+
+/* Checks for exception code types for KFD search */
+#define KFD_DBG_EC_TYPE_IS_QUEUE(ecode)					\
+			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
+#define KFD_DBG_EC_TYPE_IS_DEVICE(ecode)				\
+			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
+#define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)				\
+			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
+
+
+/* Runtime enable states */
+enum kfd_dbg_runtime_state {
+	DEBUG_RUNTIME_STATE_DISABLED = 0,
+	DEBUG_RUNTIME_STATE_ENABLED = 1,
+	DEBUG_RUNTIME_STATE_ENABLED_BUSY = 2,
+	DEBUG_RUNTIME_STATE_ENABLED_ERROR = 3
+};
+
+/* Runtime enable status */
+struct kfd_runtime_info {
+	__u64 r_debug;
+	__u32 runtime_state;
+	__u32 ttmp_setup;
+};
+
+/* Enable modes for runtime enable */
+#define KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK	1
+#define KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK	2
+
+/**
+ * kfd_ioctl_runtime_enable_args - Arguments for runtime enable
+ *
+ * Coordinates debug exception signalling and debug device enablement with runtime.
+ *
+ * @r_debug - pointer to user struct for sharing information between ROCr and the debuggger
+ * @mode_mask - mask to set mode
+ *	KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK - enable runtime for debugging, otherwise disable
+ *	KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK - enable trap temporary setup (ignore on disable)
+ *
+ * Return - 0 on SUCCESS.
+ *	  - EBUSY if runtime enable call already pending.
+ *	  - EEXIST if user queues already active prior to call.
+ *	    If process is debug enabled, runtime enable will enable debug devices and
+ *	    wait for debugger process to send runtime exception EC_PROCESS_RUNTIME
+ *	    to unblock - see kfd_ioctl_dbg_trap_args.
+ *
+ */
+struct kfd_ioctl_runtime_enable_args {
+	__u64 r_debug;
+	__u32 mode_mask;
+};
+
+/* Queue information */
+struct kfd_queue_snapshot_entry {
+	__u64 exception_status;
+	__u64 ring_base_address;
+	__u64 write_pointer_address;
+	__u64 read_pointer_address;
+	__u64 ctx_save_restore_address;
+	__u32 queue_id;
+	__u32 gpu_id;
+	__u32 ring_size;
+	__u32 queue_type;
+	__u32 ctx_save_restore_area_size;
+	__u32 reserved[17];
+};
+
+/* Queue status return for suspend/resume */
+#define KFD_DBG_QUEUE_ERROR_BIT		30
+#define KFD_DBG_QUEUE_INVALID_BIT	31
+#define KFD_DBG_QUEUE_ERROR_MASK	(1 << KFD_DBG_QUEUE_ERROR_BIT)
+#define KFD_DBG_QUEUE_INVALID_MASK	(1 << KFD_DBG_QUEUE_INVALID_BIT)
+
+/* Context save area header information */
+struct kfd_context_save_area_header {
+	__u32 control_stack_offset;
+	__u32 control_stack_size;
+	__u32 wave_state_offset;
+	__u32 wave_state_size;
+	__u32 debug_offset;
+	__u32 debug_size;
+	__u64 err_payload_addr;
+	__u32 err_event_id;
+	__u32 reserved1;
+};
+
+/* Debug operations */
+enum kfd_dbg_trap_operations {
+	KFD_IOC_DBG_TRAP_ENABLE = 0,
+	KFD_IOC_DBG_TRAP_DISABLE = 1,
+	KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT = 2,
+	KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED = 3,
+	KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE = 4,
+	KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE = 5,
+	KFD_IOC_DBG_TRAP_SUSPEND_QUEUES = 6,
+	KFD_IOC_DBG_TRAP_RESUME_QUEUES = 7,
+	KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH = 8,
+	KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH = 9,
+	KFD_IOC_DBG_TRAP_SET_FLAGS = 10,
+	KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT = 11,
+	KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO = 12,
+	KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT = 13,
+	KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT = 14
+};
+
+/**
+ * kfd_ioctl_dbg_trap_enable_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_ENABLE.
+ *
+ *     Enables debug session for target process. Call @op KFD_IOC_DBG_TRAP_DISABLE in
+ *     kfd_ioctl_dbg_trap_args to disable debug session.
+ *
+ *     @exception_mask (IN)	- exceptions to raise to the debugger
+ *     @rinfo_ptr      (IN)	- pointer to runtime info buffer (see kfd_runtime_info)
+ *     @rinfo_size     (IN/OUT)	- size of runtime info buffer in bytes
+ *     @dbg_fd	       (IN)	- fd the KFD will nofify the debugger with of raised
+ *				  exceptions set in exception_mask
+ *     Return - 0 on SUCCESS.
+ *		Copies KFD saved kfd_runtime_info to @rinfo_ptr on enable.
+ *		Size of kfd_runtime saved by the KFD returned to @rinfo_size.
+ */
+struct kfd_ioctl_dbg_trap_enable_args {
+	__u64 exception_mask;
+	__u64 rinfo_ptr;
+	__u32 rinfo_size;
+	__u32 dbg_fd;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_send_runtime_event_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT.
+ *     Raises exceptions to runtime.
+ *
+ *     @exception_mask (IN) - exceptions to raise to runtime
+ *     @gpu_id	       (IN) - target device id
+ *     @queue_id       (IN) - target queue id
+ *
+ *     Return - 0 on SUCCESS.
+ *		If exception_mask contains EC_PROCESS_RUNTIME, unblocks pending
+ *		AMDKFD_IOC_RUNTIME_ENABLE call - see kfd_ioctl_runtime_enable_args.
+ *		All other exceptions are raised to runtime through err_payload_addr.
+ *		See kfd_context_save_area_header.
+ */
+struct kfd_ioctl_dbg_trap_send_runtime_event_args {
+	__u64 exception_mask;
+	__u32 gpu_id;
+	__u32 queue_id;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_set_exceptions_enabled_args
+ *
+ *     Arguments for KFD_IOC_SET_EXCEPTIONS_ENABLED
+ *     Set new exceptions to be raised to the debugger.
+ *
+ *     @exception_mask (IN) - new exceptions to raise the debugger
+ */
+struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args {
+	__u64 exception_mask;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_set_wave_launch_override_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE
+ *     Enable HW exceptions to raise trap.
+ *
+ *     @override_mode	     (IN)     - see kfd_dbg_trap_override_mode
+ *     @enable_mask	     (IN/OUT) - see kfd_dbg_trap_mask
+ *     @support_request_mask (IN/OUT) - see kfd_dbg_trap_mask
+ *
+ *     Return - 0 on SUCCESS.
+ *	      - EPERM if mode is not supported.
+ *	      - EPERM if mode is not supported.
+ *	      - EACCES if trap support requested is not actually supported.
+ *		Previous enablement is returned in @enable_mask.
+ *		Actual support is returned in @support_request_mask.
+ */
+struct kfd_ioctl_dbg_trap_set_wave_launch_override_args {
+	__u32 override_mode;
+	__u32 enable_mask;
+	__u32 support_request_mask;
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_set_wave_launch_mode_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE
+ *     Set wave launch mode.
+ *
+ *     @mode (IN) - see kfd_dbg_trap_wave_launch_mode
+ *
+ *     Return - 0 on SUCCESS.
+ */
+struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args {
+	__u32 launch_mode;
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_suspend_queues_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SUSPEND_QUEUES
+ *     Suspend queues.
+ *
+ *     @exception_mask	(IN) - raised exceptions to clear
+ *     @queue_array_ptr (IN) - pointer to array of queue ids (DWORD per queue id)
+ *			       to suspend
+ *     @num_queues	(IN) - number of queues to suspend in @queue_array_ptr
+ *     @grace_period	(IN) - wave time allowance before preemption
+ *
+ *     Return - Number of queues suspended on SUCCESS.
+ *		KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK masked
+ *		for each queue id in @queue_array_ptr array reports unsuccessful
+ *		suspend reason.
+ *		KFD_DBG_QUEUE_ERROR_MASK = HW failure.
+ *		KFD_DBG_QUEUE_INVALID_MASK = queue does not exist, is new or
+ *		is being destroyed.
+ *		Suspended queues can never be destroyed.
+ *		Automatically copies per queue context save area header information
+ *		into the save area base
+ *		(see kfd_queue_snapshot_entry and kfd_context_save_area_header).
+ */
+struct kfd_ioctl_dbg_trap_suspend_queues_args {
+	__u64 exception_mask;
+	__u64 queue_array_ptr;
+	__u32 num_queues;
+	__u32 grace_period;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_resume_queues_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_RESUME_QUEUES
+ *     Resume queues.
+ *
+ *     @queue_array_ptr (IN) - pointer to array of queue ids (DWORD per queue id)
+ *			       to resume
+ *     @num_queues	(IN) - number of queues to resume in @queue_array_ptr
+ *
+ *     Return - Number of queues resumed on SUCCESS.
+ *		KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK mask
+ *		for each queue id in @queue_array_ptr array reports unsuccessful
+ *		resume reason.
+ *		KFD_DBG_QUEUE_ERROR_MASK = HW failure.
+ *		KFD_DBG_QUEUE_INVALID_MASK = queue does not exist.
+ */
+struct kfd_ioctl_dbg_trap_resume_queues_args {
+	__u64 queue_array_ptr;
+	__u32 num_queues;
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_set_node_address_watch_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH
+ *     Sets address watch for device.
+ *
+ *     @address	(IN)  - watch address to set
+ *     @mode    (IN)  - see kfd_dbg_trap_address_watch_mode
+ *     @mask    (IN)  - watch address mask
+ *     @dev_id  (IN)  - target device to set watch point
+ *     @id      (OUT) - watch id allocated
+ *
+ *     Return - 0 on SUCCESS.
+ *		Allocated watch ID returned to @id.
+ */
+struct kfd_ioctl_dbg_trap_set_node_address_watch_args {
+	__u64 address;
+	__u32 mode;
+	__u32 mask;
+	__u32 dev_id;
+	__u32 id;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_clear_node_address_watch_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH
+ *     Clear address watch for device.
+ *
+ *     @dev_id  (IN)  - target device to clear watch point
+ *     @id      (IN) - allocated watch id to clear
+ *
+ *     Return - 0 on SUCCESS.
+ */
+struct kfd_ioctl_dbg_trap_clear_node_address_watch_args {
+	__u32 dev_id;
+	__u32 id;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_set_flags_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_SET_FLAGS
+ *     Sets flags for wave behaviour.
+ *
+ *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
+ *
+ *     Return - 0 on SUCCESS.
+ *	      - EPERM if any debug device does not allow flag options.
+ */
+struct kfd_ioctl_dbg_trap_set_flags_args {
+	__u32 flags;
+	__u32 pad;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_query_debug_event_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT
+ *     Find a raised exception.
+ *
+ *     @exception_mask (IN/OUT) - exception to clear (IN) and raised (OUT)
+ *     @gpu_id	       (OUT)    - gpu id of exceptions raised
+ *     @queue_id       (OUT)    - queue id of exceptions raised
+ *
+ *     Return - 0 on raised exception found
+ *            - EAGAIN if no raised exception has been found
+ *              Raised exceptions found are returned in @exception mask
+ *              with reported source id returned in @gpu_id or @queue_id.
+ */
+struct kfd_ioctl_dbg_trap_query_debug_event_args {
+	__u64 exception_mask;
+	__u32 gpu_id;
+	__u32 queue_id;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_query_exception_info_args
+ *
+ *     Arguments KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO
+ *     Get additional info on raised exception.
+ *
+ *     @info_ptr	(IN)	 - pointer to exception info buffer to copy to
+ *     @info_size	(IN/OUT) - exception info buffer size (bytes)
+ *     @source_id	(IN)     - target gpu or queue id
+ *     @exception_code	(IN)     - target exception
+ *     @clear_exception	(IN)     - clear raised @exception_code exception
+ *				   (0 = false, 1 = true)
+ *
+ *     Return - 0 on SUCCESS.
+ *              If @exception_code is EC_DEVICE_MEMORY_VIOLATION, copy @info_size(OUT)
+ *		bytes of memory exception data to @info_ptr.
+ *              If @exception_code is EC_PROCESS_RUNTIME, copy saved
+ *              kfd_runtime_info to @info_ptr.
+ *              Actual required @info_ptr size (bytes) is returned in @info_size.
+ */
+struct kfd_ioctl_dbg_trap_query_exception_info_args {
+	__u64 info_ptr;
+	__u32 info_size;
+	__u32 source_id;
+	__u32 exception_code;
+	__u32 clear_exception;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_get_queue_snapshot_args
+ *
+ *     Arguments KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT
+ *     Get queue information.
+ *
+ *     @exception_mask	 (IN)	  - exceptions raised to clear
+ *     @snapshot_buf_ptr (IN)	  - queue snapshot entry buffer
+ *				    (see kfd_queue_snapshot_entry)
+ *     @buf_size	 (IN/OUT) - number of queue snapshot entries
+ *     @entry_size	 (IN/OUT) - size per entry in bytes
+ *
+ *     Return - 0 on SUCCESS.
+ *              Copies @size(IN) queue snapshot entries into @snapshot_buf_ptr if
+ *              @buf_size(IN) > 0.
+ *              Otherwise return @buf_size(OUT) queue snapshot entries that exist.
+ */
+struct kfd_ioctl_dbg_trap_queue_snapshot_args {
+	__u64 exception_mask;
+	__u64 snapshot_buf_ptr;
+	__u32 buf_size;
+	__u32 entry_size;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_get_device_snapshot_args
+ *
+ *     Arguments for KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT
+ *     Get device information.
+ *
+ *     @exception_mask	 (IN)	  - exceptions raised to clear
+ *     @snapshot_buf_ptr (IN)	  - pointer to snapshot buffer (see kfd_device_snapshot_entry)
+ *     @buf_size	 (IN/OUT) - number of debug devices to snapshot
+ *     @entry_size	 (IN/OUT) - size per entry in bytes
+ *
+ *     Return - 0 on SUCCESS.
+ *            - ENOSPC if requested number of debug devices is less than the
+ *		actual number of debug devices.
+ *	        Copies @buf_size(OUT) number of device snapshot entries into
+ *		@snapshot_buf_ptr.
+ *	        Actual number of device snapshot entries returned in @buf_size.
+ */
+struct kfd_ioctl_dbg_trap_device_snapshot_args {
+	__u64 exception_mask;
+	__u64 snapshot_buf_ptr;
+	__u32 buf_size;
+	__u32 entry_size;
+};
+
+/**
+ * kfd_ioctl_dbg_trap_args
+ *
+ * Arguments to debug target process.
+ *
+ *     @pid - target process to debug
+ *     @op  - debug operation (see kfd_dbg_trap_operations)
+ *
+ *     @op determines which union struct args to use.
+ *     Refer to kern docs for each kfd_ioctl_dbg_trap_*_args struct.
+ */
+struct kfd_ioctl_dbg_trap_args {
+	__u32 pid;
+	__u32 op;
+
+	union {
+		struct kfd_ioctl_dbg_trap_enable_args enable;
+		struct kfd_ioctl_dbg_trap_send_runtime_event_args send_runtime_event;
+		struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args set_exceptions_enabled;
+		struct kfd_ioctl_dbg_trap_set_wave_launch_override_args launch_override;
+		struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args launch_mode;
+		struct kfd_ioctl_dbg_trap_suspend_queues_args suspend_queues;
+		struct kfd_ioctl_dbg_trap_resume_queues_args resume_queues;
+		struct kfd_ioctl_dbg_trap_set_node_address_watch_args set_node_address_watch;
+		struct kfd_ioctl_dbg_trap_clear_node_address_watch_args clear_node_address_watch;
+		struct kfd_ioctl_dbg_trap_set_flags_args set_flags;
+		struct kfd_ioctl_dbg_trap_query_debug_event_args query_debug_event;
+		struct kfd_ioctl_dbg_trap_query_exception_info_args query_exception_info;
+		struct kfd_ioctl_dbg_trap_queue_snapshot_args queue_snapshot;
+		struct kfd_ioctl_dbg_trap_device_snapshot_args device_snapshot;
+	};
+};
+
 #define AMDKFD_IOCTL_BASE 'K'
 #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
 #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
@@ -877,7 +1431,13 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_AVAILABLE_MEMORY		\
 		AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
 
+#define AMDKFD_IOC_RUNTIME_ENABLE		\
+		AMDKFD_IOWR(0x24, struct kfd_ioctl_runtime_enable_args)
+
+#define AMDKFD_IOC_DBG_TRAP			\
+		AMDKFD_IOWR(0x25, struct kfd_ioctl_dbg_trap_args)
+
 #define AMDKFD_COMMAND_START		0x01
-#define AMDKFD_COMMAND_END		0x24
+#define AMDKFD_COMMAND_END		0x26
 
 #endif
-- 
2.25.1

