Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7EC55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8470110E980;
	Tue,  4 Aug 2026 09:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="hzz6RQS2";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6106F10E980
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:53:03 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HWBv295902; Tue, 4 Aug 2026 09:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YtpchHFmebZFdcGvj9WFlxc1Ze1Yh0+mNVdsm24Tk
 no=; b=hzz6RQS2hCE/fdjbLsjt4M8DJY4u2E1vi/rnx4nTEmjSBUya3TSgLPJwI
 POcEUuEFv1vbemksTt4UYQz9zF8KSu5+bHz6n+IN6cVy+h/Lzc5GMd19zgJeOyP0
 VnhZK1f2S1mA/hjLgJo0shxz2AcLxgXJKcoNoPPzcwUPHp7wkXifZ16oJMFdoeUg
 lr7mRHQY7+s9l4CN7yY2DnKpV/paOVIEC3dkx2UWAImTDPS9SIwRgaiPMhyyC/fA
 Lfa7LmcZCH1XeDo2vl5bFCEXljljICT2JMGBzvBMFmJwO9UaafxA8aTZdNcqQ9fd
 228IjswFw1pwvt+EDzytKS/c3kSrQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3w7g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:52:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fFiO017377;
 Tue, 4 Aug 2026 09:52:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9b0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:52:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749qscZ29688072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:52:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D08B20043;
 Tue,  4 Aug 2026 09:52:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4366320040;
 Tue,  4 Aug 2026 09:52:45 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:52:44 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
Subject: [PATCH 0/7] drm/amdgpu: Fix topology device creation and proximity
 domain mappings for sparse and CPU-less NUMA systems
Date: Tue,  4 Aug 2026 15:22:29 +0530
Message-ID: <cover.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71b67c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=2zSX4gdP8V0RTsvhW8wA:9
X-Proofpoint-ORIG-GUID: ow-MMzZeb7h3-vS2fcbPF_kezL8caHkY
X-Proofpoint-GUID: 680oqXTRYjWReb6SIFtBg0zP9L0kTdEf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX2jB+ltGeeNQr
 0RaeHPCetrh3U8CDs6v0dWCCL98ttXZJjhFzvTMjuNFe6Da7srGDaix0ZWgUVkV9AlBhKiYJk8q
 yj0KhbJeG5EPjkx/GG+zrpvoRmA/V7A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX7MPnkGuOxGTx
 ydJ/ZX64rPkZckvvb2jvKu7GxHNpC8jS5C9EyzXR9oUWcI8xdDq53AYt/h0HmiyJUGHOk7BeKTI
 cr94XH3KjfRwsmpfgRO/mJKdQhjxjTtSPEtW9lFlDAAEiyg8M61z8O0Eilz6aoRDXD56L19gG82
 E02HIWftTtwOtlOQ2aEXOYawAk7RyksQc9Y8/vDOa8s6mwpoxsbNhCitfCABe5WdbL9tRmGy/4o
 D0qhkrQtndk2Q7xcU2iS7WEulGuef/0zaHheOPgvxWU2+nJrfBJ+uvChTUdaXsH1wqxjkrZDuCA
 bO3GDK31JTVH36Tr/6F8C/nvuNoEVXpg2Ki9L3WW4eUtW1F/tx8LJSsOmvEZ6BGNn5r7sEGBUy2
 uVmZG+q7g9s2E3qdNZg17Mlwbs3+GmTyooU7mNZyUzp/z8BLpko/wnxleogvexbrHvgj5H7sawn
 Se0WUWdBz9bA0m5SPqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040077
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

This series fixes topology device creation and proximity domain mappings in
AMDKFD when a system does not provide a CRAT table and the driver generates a
Virtual CRAT (VCRAT).

The current implementation assumes that CPU NUMA node IDs are contiguous and
that every NUMA node contains CPUs. During VCRAT generation, CPU topology
entries and proximity domains are created only for NUMA nodes that have CPUs.
GPU proximity domains are then allocated immediately after the CPU proximity
domains, and the GPU I/O link (proximity_domain_to) is initialized using the
NUMA node ID to which the GPU is attached, implicitly assuming that NUMA node
IDs and proximity domains have a one-to-one mapping.

These assumptions break on systems with:

Sparse (non-contiguous) NUMA node IDs
CPU-less NUMA nodes
CPU-less and memory-less NUMA nodes

For example:

available: 3 nodes (0,2-3)

node 0: CPUs present
node 2: CPU-less
node 3: CPU-less

In this case, the driver creates a CPU topology device only for node 0 and
assigns a single CPU proximity domain (0). However, the GPU VCRAT still
references the NUMA node ID to which the GPU is attached (for example, node 3)
in the proximity_domain_to field. Since no corresponding CPU proximity domain
exists for node 3, the parser cannot find a matching proximity domain during
VCRAT parsing, causing topology initialization to fail.

The failure is observed as:

amdgpu: Virtual CRAT table created for GPU
amdgpu: Error parsing VCRAT
kfd: amdgpu: Error adding device to topology
kfd: amdgpu: Error initializing KFD node


Since every online NUMA node is a valid topology object and can contain
CPUs, memory, I/O links, or any combination of these, topology devices
and proximity domains should be created for every online NUMA node
rather than only for NUMA nodes that contain CPUs.

To address this, this series introduces a new VCRAT subtype that
records the mapping between the NUMA node ID and the generated VCRAT
proximity domain. When topology devices are created, this information
is stored in the corresponding topology device, allowing the driver to
translate a NUMA node ID into its associated proximity domain whenever
required.

Returning to the previous example, the system contains three online
NUMA nodes, so three CPU topology devices and three proximity domains
are created, even though only one NUMA node contains CPUs. The NUMA
node ID is stored in each topology device together with its generated
proximity domain.

Later, when the GPU VCRAT is generated, the driver only knows the NUMA
node ID to which the GPU is attached (for example, node 3). Instead of
assuming that the NUMA node ID is equal to the proximity domain, the
driver walks the existing topology devices to locate the corresponding
NUMA node and retrieves its generated proximity domain. In this
example, NUMA node 3 maps to proximity domain 2, so
proximity_domain_to is populated with the correct value.

Since the GPU I/O link now references a valid proximity domain, VCRAT
parsing completes successfully and topology initialization proceeds
without errors on systems with sparse NUMA node IDs, CPU-less NUMA
nodes, and CPU-less/memory-less NUMA nodes.

This series consists of the following patches:

Patch 1 removes an unused argument from
kfd_create_crat_image_virtual() as a preparatory cleanup.

Patch 2 introduces a new VCRAT NUMA affinity subtype that stores the
NUMA node ID and its corresponding proximity domain.

Patch 3 populates the NUMA affinity entries during VCRAT generation
for every online NUMA node.

Patch 4 parses the NUMA affinity entries from the VCRAT and stores the
NUMA node ID and proximity domain in the corresponding topology
device.

Patch 5 fixes GPU VCRAT proximity domain mappings by translating the
GPU's NUMA node ID to the corresponding CPU proximity domain before
programming proximity_domain_to.

Patch 6 creates proximity domains and VCRAT entries for all online
NUMA nodes, including CPU-less and memory-less nodes.

Patch 7 adds a numa_node sysfs attribute for CPU and GPU topology
devices, exposing the associated NUMA node through the topology sysfs
interface.

Please note that the changes in this series are on a best effort basis from our
end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
HW & SW stack) to kindly help with the review and provide feedback / comments on
these patches

Donet Tom (7):
  drm/amdgpu: Remove unused argument from kfd_create_crat_image_virtual
  drm/amdgpu: Add VCRAT NUMA affinity entry
  drm/amdgpu: Populate NUMA affinity entries in VCRAT
  drm/amdgpu: Parse NUMA affinity entries from VCRAT
  drm/amdgpu: Fix VCRAT proximity domain mappings for GPU nodes
  drm/amdgpu: Create proximity domains and VCRAT entries for CPU-less
    and memory-less NUMA nodes
  drm/amdgpu: Add numa_node in cpu/gpu topology device sysfs entry

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 152 +++++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  19 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  49 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   4 +
 4 files changed, 168 insertions(+), 56 deletions(-)

-- 
2.54.0

