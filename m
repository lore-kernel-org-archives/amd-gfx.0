Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110C110A3D87
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A696C10E393;
	Thu, 26 Mar 2026 12:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="CkbR7Cms";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 434B210E393
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:21:46 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QCHXYt3448655; Thu, 26 Mar 2026 12:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=P3aeitCKfjFVvAv6lIAyCFS29d1j
 2SoHcWxeFgmRA2s=; b=CkbR7CmsabdFLk0WF/x6K+I8LQjo2D/CLlbc7AqZSr6J
 lH+QjbG+CL9Ftp2EsZX+Z4kkUsRvS5HGKHAqnRc9B/N3oDEuIe9wOOs66XJkAuUQ
 jrdZYOfMVVhToQ9Qq61iZVZn06+ZPUPbAh+hcsi/WaaUPCymf7mSIUiB5IMxPTAv
 3BaTCsyD8wFb2kdijv3rBNB5OK5e9mG7wA2JJtyWoAiTBLXi6N2O09upzkuiykog
 E9h7u9Z3VtI/tMCVOxWNKaAO3J4RRg7VEVynIC43+igDn1XlUVdG5JDwCuMCnwRf
 ibttWE67aDUu05+u80Lx0Rla78nUIs0n4MmaVf2K+Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa54aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 12:21:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QAK8Jv006009;
 Thu, 26 Mar 2026 12:21:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yu06p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 12:21:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QCLchg61735324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 12:21:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AF5F2004D;
 Thu, 26 Mar 2026 12:21:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BA9320040;
 Thu, 26 Mar 2026 12:21:35 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.29.115]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Mar 2026 12:21:35 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [PATCH v4 0/2] drm/amd: Add support for non-4K page size systems
Date: Thu, 26 Mar 2026 17:51:27 +0530
Message-ID: <cover.1774521183.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dOD-u6JvnGP9OTA3-4BMKSRAL2EFys_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4NiBTYWx0ZWRfX3h005U+a6zZ6
 X3epc2lGmcKpgekgz9dlC2rHSdYtKS9Z9uNV3vF2NfTiy1AAw5Tdyy+CDWcr8ABVF+IOPikwGRI
 SAXzWAqYvom49T/boCe30/e12oOLaMkXrGgbNsRi8exR1jXUeetjw0/PsmfSw6kkaAeQu8+ys8q
 Ts/ncl2o1VhKU3fc9SlEls0Ea3W7gdi4yYjKkMWuOzctDNyhaVdJVHC1iUhjNgjtq+sjaqifXGW
 Fv4tQfVKKte0h9pv6rCOeZKIN9yuRmubwaeFWs9djPjTREJele7sieydxcmn3PzpJGbIbjIh14S
 s+yVypJtQOAvRBtr2iaswy8Y8r3GOjeqCaHexV0I6b9Eqpv1IR/IjKm46Z7Yl3Bl+dblgMTDL0d
 WKXXiUULImyH5ZeWj/H59xyNPO39jMXoVpZcMq3usCwfhPtOllb50DzDna4x4DCrhJIzbZEjz3i
 KDUqAzBy/EQMkC4SGvw==
X-Proofpoint-GUID: vv1I8FecHg6A3hCqprd11xXTN4JV28TC
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c524d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=SG35aDaeF4Zs4cq6RUUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260086
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

This is v4 of the patch series enabling 64 KB system page size
support.

v3 of this series [1] contained 6 patches, of which 4 have been
picked up and applied to drm-next. The initial minimal
infrastructure required for 64 KB page size support has already
been merged upstream [2].

This series includes the remaining fixes:

- Patch 1 fixes a kernel crash observed when running rocminfo
  on systems with a 64 KB page size by updating the trap
  reservation size.

- Patch 2 updates AMDGPU_GTT_MAX_TRANSFER_SIZE to always match
  the PMD size across all page sizes.

Setup details:
==============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
Name:                    gfx90a
Marketing Name:          AMD Instinct MI210

Changes since v3:
-----------------
- Based on feedback from Felix and Christian,
  AMDGPU_VA_RESERVED_TRAP_SIZE has been updated. The virtual
  address space now reserves 64 KB for the trap, while only
  8 KB is allocated for both 4 KB and 64 KB page sizes. This
  ensures that the allocation remains within the reserved
  region.

Links:
------
[1] https://lore.kernel.org/all/cover.1774239489.git.donettom@linux.ibm.com/
[2] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/

Previous versions:
------------------
RFC v3 resend:
https://lore.kernel.org/all/cover.1774239489.git.donettom@linux.ibm.com/
RFC v3:
https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm.com/
RFC v2:
https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/
RFC v1:
https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/

Donet Tom (2):
  drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
  drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 4 ++--
 5 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.52.0

