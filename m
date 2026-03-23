Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA5D58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1088910E2D1;
	Mon, 23 Mar 2026 04:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="jSzPso2t";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD1710E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:28:56 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MFEgS73932645; Mon, 23 Mar 2026 04:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=olaZHq3z1OjSxF5CO
 EJmt/EgmzlvqC1eOsuNXN2h/rI=; b=jSzPso2tkoaw2FFnWS2GIa9fl6XiS93n3
 iXTf5Qx6w+2VKeIxe0y3nsFPLF0hXDO4AEHEgNOWiRhRc/01grhjeY5vlu6+916J
 wUVfdjKsYjHfsr17hug0vYrwiGRLJou+vfjCdQTIHDzouGZp4Qzo3B6GOv4HQtLU
 DmK526tcAqz0EXtXGPb97UiTnA6SHjySf2mWydU7Z5ueX1MYJnOFlO+Vwku4UQQT
 OtFw8cFh6imgLPAGPVSJ0RIVO9pd8o5CfTdQjxkBS4iJAg8p7e5+ArcVAMkz+x7O
 fWjbRqfg9vS0CbR0G/iVeMh9eNYgBcXJsoU+ceMPL5JaEzTLy/CAg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxnbx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N1cR5b008749;
 Mon, 23 Mar 2026 04:28:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnbyk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4SnTJ48497100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:28:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 224E52004E;
 Mon, 23 Mar 2026 04:28:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28C2020049;
 Mon, 23 Mar 2026 04:28:46 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:28:45 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com,
 stable@vger.kernel.org
Subject: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
Date: Mon, 23 Mar 2026 09:58:34 +0530
Message-ID: <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c0c186 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=4rmLHU1oXFswgLKNxjYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfX8dp7pNyuc234
 ZChP5JtT2yE9pnyzpm8EqXnOg/DCydeFo80d41xWOwUvXci+nTx75vGt0lUPNERWHY3QHgSv96l
 tiHzWW66l6ccdLnQyCHVRY3+kxJEfgYK2vKZZd+VTPxWBdH+g3tyis8oYlPFg3+WUMzovRupf/z
 q3UZ7oshPSbxdOkLK2lslwkH3jjeb4RtF3glx9oFUBdyBuYaU41Z99EufRPReCh+zpY5j04DlQp
 vbEH3qrqWGxJNogtBLXBdkm41Ya3pXmnFjp82e0yi+FYDlxNmkb4cLQE+zOjm5FRNdeKc+OdXJn
 QoZYxpjVRwbP4NVDzb4FkW/HiaQnhDUJXvdqj1ogbS2Zl+ouGR/HQMOFUkTpSL9sWcpDqYNsj+P
 mGyRXKNIH0ehbKPdwpqoCvrxhZKkEyD20L4wawDg7MNVbanwTFHxf0+DMUlpDZXbCCN9qNvHIV1
 MIMmgwIPrM9/cynJcEA==
X-Proofpoint-GUID: 6-DNrD8gvDVZQRwPh-NJycJH0A2czzIe
X-Proofpoint-ORIG-GUID: Evr5bp8VfxnoR1SUv2P8HanaLS8_k6Bu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230030
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

Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
4K pages, both values match (8KB), so allocation and reserved space
are consistent.

However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
while the reserved trap area remains 8KB. This mismatch causes the
kernel to crash when running rocminfo or rccl unit tests.

Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
BUG: Kernel NULL pointer dereference on read at 0x00000002
Faulting instruction address: 0xc0000000002c8a64
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
Tainted: [E]=UNSIGNED_MODULE
Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
XER: 00000036
CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
IRQMASK: 1
GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
c00000013d814540
GPR04: 0000000000000002 c00000013d814550 0000000000000045
0000000000000000
GPR08: c00000013444d000 c00000013d814538 c00000013d814538
0000000084002268
GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
0000000000020000
GPR16: 0000000000000000 0000000000000002 c00000015f653000
0000000000000000
GPR20: c000000138662400 c00000013d814540 0000000000000000
c00000013d814500
GPR24: 0000000000000000 0000000000000002 c0000001e0957888
c0000001e0957878
GPR28: c00000013d814548 0000000000000000 c00000013d814540
c0000001e0957888
NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
Call Trace:
0xc0000001e0957890 (unreliable)
__mutex_lock.constprop.0+0x58/0xd00
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
kfd_ioctl+0x514/0x670 [amdgpu]
sys_ioctl+0x134/0x180
system_call_exception+0x114/0x300
system_call_vectored_common+0x15c/0x2ec

This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
ensuring that the reserved trap area matches the allocation size
across all page sizes.

cc: stable@vger.kernel.org
Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..a5eae49f9471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
 #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
 						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-- 
2.52.0

