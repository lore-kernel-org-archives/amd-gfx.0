Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF1606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=XcKb/MaK;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=bt94kWjZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C9110EBE8;
	Wed, 18 Nov 2026 08:25:51 +0000 (UTC)
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com
 [148.163.139.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A31610E155
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 04:29:10 +0000 (UTC)
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI1XfIn465737
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 23:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pps01; bh=rqAEWub6b+VNUKauWaWsmC6HlM
 EYDyZPR4KLlxu12zc=; b=XcKb/MaK0eyLn/5OAfV8yBM2KRS2M6b5kR5SMr6EFm
 CWnmQAF2vdwVgdMUDq9LQ0B1kytwzgnyCHTWOs93YThc0KuTvsQ7CyIyQ6JAqsTV
 Vo6jACRz1trjeOQMhdWiAi67KSg8HHnKjoHZxfXLgexeC7XX/nXfNR5TghfdcWs9
 82JWEd7BocL6iqzZD8yUP0rTVLepl/bIT6esC2voCKjI4lBaTYN6n5inDvO5NPKj
 On7x8D2GIiZH7BRMNehP59V5pbtScQPMsHQW9s4RMZ2FMmTPuhdw5wwBdi3nvERz
 AUrzScQCknu8WiqXoILhp7DXNRWCD+iuhydQEqmBaQaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu61g4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 23:29:09 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9493e89d4f9so102997485a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 20:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1794976149; x=1795580949;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rqAEWub6b+VNUKauWaWsmC6HlMEYDyZPR4KLlxu12zc=;
 b=bt94kWjZxnotzbRyoghWeLkVTY91qUBQ/U2mMoMNxq/BzAwnMCjpqvf3INguSkaIO/
 wqXTikFt97xjHh3xWI/idRSeYzIUgzxzzz4T5azJAm5v20vs0eAVuuyR1oDKvHTQ3IHu
 tdvmWvUBniQqneAW6qPaT+Injh2E9TM2OLu9op3nmPa7pgb0dvErwybVQKzA3EwYQSaB
 iLguOjUeO+AYlR07jX4PJVCBT2jg4EaOO/M5G1AVTTgibCFfxW7pFqtELA5KhxSO/8FQ
 eRgRp+IBdf+XJfFqCj/z+BeOIsy5zGybJKDED82cfAkWdTMp4NQVr3lcKvohHSg1GTvn
 n40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794976149; x=1795580949;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rqAEWub6b+VNUKauWaWsmC6HlMEYDyZPR4KLlxu12zc=;
 b=U/Ei/DDT/chXUogjsVFxq7ZVsXceng4W9pmk7sQCxPzTCZGJuHpCFKVSE+9IVjVS2F
 pu30ZowuFMgTbsWN55wxSGwXqRMsAA7PbMUGaKkJQv0IVDws0ElNFrqFrI1jzePXk6u5
 SEvrJrqYM3byIcDFhu5qEYm7an+zKEeyJuPj/uh50ShsqO/HywFA58shREKwoGHCgzKZ
 4vbDUizVvLtA/b+O4C97Qw+EZ/LaXCLZVfr1rAM9KmXGxCoB//nWO+PQy/5MZ9/d69tI
 IIUv+evmV8NiRY44tQdoQRP4u/gqNSIPSzy0DBh/4y2MgIjQnjpKPWSRFBfMK7Nf/las
 Q5kQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFQ7HKacv/5AAMUdgN9BkF6P/mNA6vURT1D/kc3LAlaI/VG+fezL02mMpQAm4M67huTwd8Inlup@lists.freedesktop.org
X-Gm-Message-State: APuU4Z80PAg4kQYxCeMA82Hh7bBzZj7ys6gbhjE9ruthrEarZ9u3xuHJ
 Xqngm6LpNl9BNAGcqtNLf5pXmulHDAir63RdUkG1FbuYqEbMs1YM2ZWU9LaLiRj8Rr6rbmTia5c
 3KzCzS3mNXUKdsvPPmoM8ca4sbqnLVU5fnis6/z/G7v3lNFehvlHNjgjPXR4Uy0Y=
X-Gm-Gg: AYBFou0vaSRW3VCHoXl+sRzjYee7a+yzNTh01GqPQt0U+DwizB55B031yhDvwo+xYxA
 tsiHSsliQM9jx9PqzqXK87t4yMM5yQ9PjIpc4pyd3idU4aDix9O2hry6WWytE/PhTMAFeDC8v5W
 uKTZhh1UlQf+yuMPQtSB1s8dKIp9lXEgCQEsebGf/6q9WOhDBc8GSEA6IoIPqgBbbkiNBojLb00
 lMb7dOX+/wUkL95hDYkSKyOZ6d6I8gHUZkuRJchv/a3ANE5+WvAbmZQQUys3GwbLgGvy90LWFb+
 9tVfJ/TxoywhrVYe6cy1kavUDKn0PiHVAonOhwD980PSrOADYl8X/g8OZj5E2EtkN08LCRJpVLM
 Pf93TkAsYtnhUwrn5szpjitnMA0acC9N280FJ1k08DIqMT/vvPE9TB/TlUTBZn5indhFG9FdZIg
 2PbX3M1dc6qknHZnej6Q==
X-Received: by 2002:a05:620a:462c:b0:949:6655:1dc6 with SMTP id
 af79cd13be357-949995581e2mr304665585a.1.1794976149063; 
 Tue, 17 Nov 2026 20:29:09 -0800 (PST)
X-Received: by 2002:a05:620a:462c:b0:949:6655:1dc6 with SMTP id
 af79cd13be357-949995581e2mr304662385a.1.1794976148573; 
 Tue, 17 Nov 2026 20:29:08 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu.
 [160.39.33.242]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b743a8bsm89678085a.17.2026.11.17.20.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 20:29:08 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
Date: Tue, 17 Nov 2026 23:28:40 -0500
Message-Id: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgp/WoC/22OQQ7CIBBFr9KwFsNAA8WV9zAuaJlajLamUKJpe
 nehujDq8mX+f39m4nF06MmumMmI0Xk39AnEpiBNZ/oTUmcTE864BGCSTm1rqQ8mIG3dHT21HAC
 Qm9qWFUm124jrIbUOxxf7qT5jE7InJzrnwzA+1s0IOffWA/zqI1BGGVMgrJCVVnLfDJfpWjuzR
 TuRvBD5p+PPi5EnRym0Mgy0LJX+cizL8gQt+SI3CQEAAA==
X-Change-ID: 20261106-uffd-state-fixes-d2111e2abd48
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
 Andrei Vagin <avagin@gmail.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, Breno Leitao <leitao@debian.org>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794976146; l=5552;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bXJ7iH6e45hLHohGwDiKQ9KsP+1zcP933ybsR6EgSrU=;
 b=dqh64GH8I96mPK7VNluwWf3s4AmFQRkzSpniRlUIwEYtg3kFz4EHguoBj2QLxVBG1mkCZeBug
 0LRNUk3kmaPDIqzhQnW/BSVWhwsMA7urrdIkuDWhgi5/FPZBC9tkQ3O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=NItAaE6g c=1 sm=1 tr=0 ts=6afd2995 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=bC-a23v3AAAA:8 a=28s7c6AVXC2H7J1PSfAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfXypCu1RkVq8GL
 Z7URjimDUCzi3wAtjDah293D0JohKsY3K+jZjK80NFj7OH57Hxa762H/PJ3GS209NkhKK4bYXz/
 BOKCuDCAmAqAHn30O0QfHVpIhRbZRNRtSo4WIOIPDQprxLPZHoAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxNyBTYWx0ZWRfX5ruYGOjTtK/s
 tOXiCvxEVETOIHL73NrH4aDqGWEn6HCwl2Lw/Frocbp2H3urjEoLKO2mTACpTAmoExriBuOPvPe
 Nx6qOAN/XuVyXj6Rx3yHay2PcIhNaUGBlFLlwdP/eMR0FweFL7XMGZUS3ygW/I8O0xu68guNTBU
 lvMaQ5fB3qWHhfRMsAmalrrYTD2WWDN5X4mp5vjlkkXhK+eI+MLB/8jhJMib5S5XESB0zvzr6sl
 RdgJUae7wojuX0oNcKYiXK3Fc/iNSLwO7heCrpeVScneA3HaLPkZ3yC1+BNaAdN7jmFyXhHU23K
 iRtNvPVnDCU7UxfCX+q3hIjTPnj/sWyJDc9rOTXvpZlifUouzkN1jKS2H1AVQ9ytSXwpxDOVZlH
 teWA5/YCUJzXaS8C6u/FFT7hNJw2Fhse8OsknM2mB/JGiVrN4A0hfCFJrcyLKTm9IPu2H+QTVA7
 JRaMfWUimH/HUX/fVsw==
X-Proofpoint-GUID: Jta24JGGUBEW_zHiHa2aWpRWiAOdAV5w
X-Proofpoint-ORIG-GUID: Jta24JGGUBEW_zHiHa2aWpRWiAOdAV5w
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11969
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=10
 clxscore=1015 priorityscore=1501 impostorscore=10 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180017
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:25:50 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a first batch of userfaultfd fixes, with more to come.

These were found by a mix of regular old LLM review and by having an LLM
write a TLA+ model of uffd interactions with PTE bits and other state
and seeing what issues fell out.

Most of these fix places where mm code loses uffd-wp or RWP protection
while moving or migrating an entry. Userspace then either misses writes
and accesses, or gets pages reported that nobody touched.
There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
file through a private mapping.

Patches 1-2:   UFFDIO_ZEROPAGE and UFFDIO_MOVE fixes, cc stable
Patch 3:       PAGEMAP_SCAN write-protect vs. writable migration
               entries, cc stable
Patch 4:       warn on a writable migration entry with the uffd bit set
Patch 5:       PAGEMAP_SCAN write-protect vs. device-private THPs
Patch 6:       UFFDIO_MOVE of the huge zero page from an RWP source
Patch 7:       mremap() losing uffd state when a move fails halfway
Patch 8:       migrate_vma losing uffd state of a zero page
Patch 9:       hugetlb alignment checks in UFFDIO_REGISTER and
               UFFDIO_UNREGISTER

A few of the fixes change what userspace sees:

 - UFFDIO_ZEROPAGE on a private file mapping no longer fails with
   -EEXIST where the file already has a page, on an mm that cannot use
   the zero page (patch 1)
 - UFFDIO_MOVE returns -EEXIST for any huge destination PMD, not only
   for a present THP (patch 2)
 - UFFDIO_UNREGISTER with a misaligned hugetlb end fails before
   unregistering anything, also if that hugetlb VMA is not registered
   (patch 9)
 - UFFDIO_REGISTER and UFFDIO_UNREGISTER accept a misaligned start that
   lies in a gap before the first hugetlb VMA of the range (patch 9)
 - UFFDIO_REGISTER returns -EINVAL rather than -EPERM for a misaligned
   end in a hugetlb VMA without VM_MAYWRITE (patch 9)

Patch 6 has little user impact on its own. It is included because,
together with patch 7, it allows removing clear_uffd_wp_pmd().

Patch 7 adds spurious write faults on shmem and hugetlb after mremap():
when dropping uffd protection there, change_protection() makes writable
pages that were never protected read-only. UFFDIO_UNREGISTER and
UFFDIO_WRITEPROTECT already behave this way and lead to the same
spurious faults. This will be fixed in change_protection() in a separate
series.

Based on mm-new.

---
Changes in v3:
- Collect tags (Thanks David!)
- Patch 1: use vma_is_cow_mapping(), per David
- Patch 4: warn on a writable migration entry with the uffd bit set, and
  make the PMD path match the PTE path, per David.
- Patch 4: Drop the Fixes: tag and the review tags due to changes
- Patch 8: add helpers and read the PMD once with pmdp_get(), per
  David
- Patch 9: move the hugetlb alignment checks into a helper and use it in
  both ioctls, per David
- Link to v2: https://patch.msgid.link/20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu

Changes in v2:
- Collect tags (Thanks Kiryl, Lorenzo, Gregory, Alistair!)
- Patch 2: say "softleaf entry" in the commit message, per Lorenzo
- Patch 3: add softleaf_is_writable() and softleaf_mkreadable() to
  leafops.h and rename the helpers to say softleaf, per Lorenzo
- Patch 3: add Reported-by and Closes for Breno's report, and cc stable
- Patch 4: explain in the commit message how PAGEMAP_SCAN set the uffd
  bit on writable migration entries, per Lorenzo
- Patch 5: use pmd_is_valid_softleaf() rather than open-coding it, per
  Lorenzo
- Patch 7: say "write faults" rather than "minor faults" in the commit
  message, per Kiryl
- Patch 7: trim the commit message, per Lorenzo and Gregory
- Patch 8: trim the commit message, per Gregory
- Patch 8: Cc the GPU driver maintainers and lists, per Gregory and
  Alistair
- Patch 9: use IS_ALIGNED() and a local variable for the VMA's ctx, and
  shorten the comment, per Lorenzo
- Drop the three guard region patches, per Lorenzo
- Link to v1: https://patch.msgid.link/20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu

---
Tal Zussman (9):
      userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
      userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
      fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
      mm/migrate: warn on a writable migration entry with the uffd bit set
      fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
      mm/huge_memory: build the moved huge zero PMD from the destination VMA
      mm/mremap: resolve uffd state when the context is dropped, not during the move
      mm/migrate_device: do not migrate a uffd-protected zero page
      mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan

 fs/proc/task_mmu.c            |  42 ++++++++++++++--
 include/linux/leafops.h       |  51 +++++++++++++++++++
 include/linux/userfaultfd_k.h |  24 +++++++++
 mm/huge_memory.c              |  38 +++-----------
 mm/hugetlb.c                  |  27 +---------
 mm/migrate.c                  |   7 ++-
 mm/migrate_device.c           |  34 ++++++++++---
 mm/mremap.c                   |  46 +----------------
 mm/userfaultfd.c              | 112 ++++++++++++++++--------------------------
 9 files changed, 195 insertions(+), 186 deletions(-)
---
base-commit: 25fee5b1762b8799dd8b72c2f6d666eb01680cc7
change-id: 20261106-uffd-state-fixes-d2111e2abd48

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

