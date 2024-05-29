Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4124C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7BE10EF6A;
	Wed, 29 May 2024 13:24:38 +0000 (UTC)
X-Greylist: delayed 571 seconds by postgrey-1.36 at gabe;
 Wed, 29 May 2024 04:15:35 UTC
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1BE10E38F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 04:15:34 +0000 (UTC)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 378BB1008D377;
 Wed, 29 May 2024 12:05:56 +0800 (CST)
Received: from [10.181.93.186] (unknown [10.181.93.186])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id C5D0137C91F;
 Wed, 29 May 2024 12:05:52 +0800 (CST)
Message-ID: <ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn>
Subject: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux 6.10-rc
From: Wang Yunchen <mac-wang@sjtu.edu.cn>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com,  Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org
Date: Wed, 29 May 2024 12:05:51 +0800
Organization: Shanghai Jiao Tong University
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 29 May 2024 13:24:12 +0000
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

Hello,

After upgrading to Linux 6.10-rc1 (Mesa is left untouched) I identified a s=
trange bug that could cause the GPU to
crash and reset while playing videos online with VA-API. The screen would f=
irst start to jitter, then flicker once or
twice, but the desktop session couldn't be brought back. After a reboot I f=
ind the following messages in system logs:

10:13:05 kernel: gmc_v11_0_process_interrupt: 52 callbacks suppressed
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be8000 from client 18
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be8000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b01000 from client 18
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:10 kernel: gmc_v11_0_process_interrupt: 222971 callbacks suppressed
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be8000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b01000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b01000 from client 18
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:15 kernel: gmc_v11_0_process_interrupt: 236783 callbacks suppressed
10:13:15 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00103A11
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: unknown (0x1d)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x1
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be8000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b05000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b01000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b00000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103be6000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_id:0 =
ring:8 vmid:1 pasid:32777)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process pid 2=
857 thread firefox:cs0 pid 2909)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at address=
 0x0000800103b01000 from client 18
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_STAT=
US:0x00000000
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client =
ID: VMC (0x0)
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0=
x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x0
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_unifie=
d_0 timeout, signaled seq=3D5197, emitted
seq=3D5200
10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process informa=
tion: process RDD Process pid 2857 thread
firefox:cs0 pid 2909
10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
10:13:16 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reach va=
lue 0x00000001 !=3D 0x00000002n
10:13:17 kernel: [drm] Register(0) [regUVD_RB_RPTR] failed to reach value 0=
x00000340 !=3D 0x000002c0n
10:13:17 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reach va=
lue 0x00000001 !=3D 0x00000002n
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying t=
o resume
10:13:17 kernel: [drm] PCIE GART of 512M enabled (table at 0x000000801FD000=
00).
10:13:17 kernel: [drm] VRAM is lost due to GPU reset!
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
10:13:17 kernel: [drm] DMUB hardware initialized: version=3D0x08003A00
10:13:17 kernel: [drm] kiq ring mec 3 pipe 1 q 0
10:13:17 kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]] JPEG=
 decode initialized successfully.
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv en=
g 0 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv e=
ng 1 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv e=
ng 4 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv e=
ng 6 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv e=
ng 7 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv e=
ng 8 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv e=
ng 9 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv e=
ng 10 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv e=
ng 11 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 12=
 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses VM in=
v eng 0 on hub 8
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng=
 1 on hub 8
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM in=
v eng 13 on hub 0
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow s=
tart
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow d=
one
10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) succeeded!
10:13:17 kernel: [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initializ=
e parser -125!

A crash of the program playing video (Firefox) is then triggered. It could =
happen any moment while playing videos. The
problem is not observed in Linux 6.9, it appeared only after upgrading to 6=
.10-rc1.

I'm new to amdgpu and I've peeked into source codes but couldn't find a cal=
l chain for the error reporting code. I've
also went through drm-next commit logs, and from my understanding the updat=
es introduced to 6.10 are many and I
couldn't bisect them all. However, I'm happy to provide you with a kdump or=
 a process dump if you request so. Please
also allow me to know how I can provide you with more information.

My system information: Ryzen 7840 HS, 512MB dedicated VRAM configured, Mesa=
 24.0.8, kernel 6.10-rc1.

Hoping to hear from you soon.

--=20
Sincerely yours,
WANG Yunchen
Senior, UM-SJTU Joint Institute
