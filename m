Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82040606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VmPp7q7i;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Zu0tisbo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34A210EF81;
	Tue, 17 Nov 2026 08:09:27 +0000 (UTC)
X-Greylist: delayed 2202 seconds by postgrey-1.36 at gabe;
 Mon, 16 Nov 2026 20:41:21 UTC
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com
 [148.163.135.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA3C10F44B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 20:41:21 +0000 (UTC)
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJXQvW2058223
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=OoLT
 YMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=; b=VmPp7q7ixR/GQmSlNvEE
 kjmcyohLdB0C4sFEehPP88ZgwKMUFwGkFDkqrb2shv1Cy7FPgg0x0r+Z9sjlHc/U
 NuVTsGNgAkBRak1je4y8WwazCm93d9hmEu/dCxQbQ6BBI9tkC8MGMN0GJDzDzYAo
 HXE0iPoGzC2ycj9VXVdzPX8bPAyV8R+vEwZEIpKQksNa8VmYKjUSxaECMxx4RK5y
 MrHC1Dhn2b4sQDsej82n76kYp/RVPD1H3+7ugnCS/qVwCiaN6+h17CRFn6ZUWi6t
 zHDCuP5vvBjNK3/GrhKIuVowWPwAE7dn9kj1ax/2kXEjEk1RejzlGDP8vTHQCmbk
 yw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0583j3hn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:04:38 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91eb3a63064so4571656d6.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1794859477; x=1795464277;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OoLTYMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=;
 b=Zu0tisboFPvslt0G6WDY9KmH7wQ4zJFHMP4IHQ5UM4N5+TKhUJgG+A+e56Nrk90aCG
 iIWHZ7OhJCVWlImb6L50NJ8xrFzmDxa7DkOVGp06xShakr0luZu66iV29YqIFRmwJBuC
 qSgFzQy0RLi/OQYzyVCBuKtNf2+wqy3IY+3m3OaC/3h8U2koI26UbX1UKSrCgvPD/FPB
 lmQe3yrx+xHk6cQHbt8Ojof5XMvCScEFNmG8J7p+BlwuhS3/sHyrBG9Yn1JgTxo5loxa
 Jr1yN08UXAyXRXOOjsttGv2YgmdpA/VHRm/b26aSyNhx7XMXsrzK3EEsaZgln37o5MB2
 rWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859477; x=1795464277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OoLTYMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=;
 b=LWPuteg2Ky9XeC761nXJaSK3/N8FhE6uslItY+Ab7NlYjPOZu2+sKSsB/TIvVZFWgO
 OA2KkINDMNk5hZi9xQTeD0P3E2UpiA07HWTXrWBdTD/ph/izZNgU+PsTWzTydcB8afly
 DpEPEYaEP5Nla33zJOB81766f5k5oR1U0ckXsQk9Iln70DlvepcauUrwe7tWiCK8Iar6
 eZIjZldFPs9ZltGH6/mRLnV4A0NivTYuuR67+OQuHztHzzRUolh3eMh373iim8MsgK//
 Hw+wFeeiip1BYxk+uCTXvcHmG93iyczEWl6642MsoTmTO7dUu4sOhHXmTJNrNSGpwlJy
 /qHg==
X-Forwarded-Encrypted: i=1;
 AL+hErHvQo5Vc2zwiv0C1oG2RxWDvWvvwhTTZL1Xgx1UuYMzBGyeHqrVZNKgKJXgECTvLuyN9BbS3nr0@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HCZlNMQ3OZ9Y3t/e0v731M2SFOseApJ9cha93F94WUbZaCRK/
 lAh/lARAMoXNAo5s797xXLTEAGMcuYTLtGr02XshnSg3CYman6O85HOQgwriLStlajNMLHhZLlW
 djbnmh5j8GVNHi5kWl0k6AoX9iaDYQZ/1Helj+5oq1/OCEq2MFTGfM7jMCh5R9tM=
X-Gm-Gg: AZFdTZeQ1TmsESOS7GwxeNuB4QSaW35OKZUbmdsmLJDYbAzn/ArvOJA0/nK+6hZV/KU
 XLiOYentK46R6LBcEBeP6Cfng39aSqo3CYrVPBqdzf0kXYMHe3MZ4K/HMhnFe8TM8Uq5r7OYc4C
 +x/Oh7e3BxFjAnPN2ZOSursLMF1J7Tg5MOilYkxdrj7pL0DZ+q9pI4zLdp2HYdLx8gJC9UGoVeY
 SYZbujv2yBIhwnsJ9Ps86kOx2T361Alpp9dHLFg9WUmY3/LoSy8sX+X2YHg4xQMU1NC8vgtgKp4
 yP/slQCUdn3v0jULjt0yc7spPBQUySCFuECzS5VnJcmc9p9CAzqItmC0C1HyeB/Euui0xKMrbGa
 +UiZ0M8U/ohWTCwIheLT8V+GtD67S6Xuxy92PQlhipYHX4fUiCO5cNFZ+8NYb4wUcvXViu5z53Q
 rlD3K3OIPY+Gfl/6hwYLyY
X-Received: by 2002:a05:6214:404:b0:91f:3063:6b2f with SMTP id
 6a1803df08f44-920fd34f33cmr9007386d6.17.1794859477444; 
 Mon, 16 Nov 2026 12:04:37 -0800 (PST)
X-Received: by 2002:a05:6214:404:b0:91f:3063:6b2f with SMTP id
 6a1803df08f44-920fd34f33cmr9006626d6.17.1794859476833; 
 Mon, 16 Nov 2026 12:04:36 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu.
 [128.59.176.174]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:04:34 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:50 -0500
Subject: [PATCH v2 8/9] mm/migrate_device: do not migrate a uffd-protected
 zero page
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-uffd-state-fixes-v2-8-4397a0196479@columbia.edu>
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
In-Reply-To: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
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
 linux-fsdevel@vger.kernel.org,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=3477;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rmChA7WgdOrC/88AxZpfJODdWq+Xphq5oh6yqVMIGRQ=;
 b=Aq8YehfZb6/OHRe5fm5im+wKKZvGIc/GWSlOLY0dwMWs4pJkhwuqJqx9nc8S+eDs6q4djpisX
 UCoLnNhweecC9FQQb7bS+LJGWbllO0Kys1HABgExaohJoPu9hSmT0f5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: ZBR468I5jVdNqJiVoBrlwMsMFEoJVOBD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX+1q72zypHcjC
 /4x41DndFXNDir8udxjhUlJFBh7sGQKEUv3amGTr4nIEIVrkVHq3n3G8IhqP3RzpMWeCfZIYKoK
 oemDEswrwmMY4+ctO+9wCs73lLyAdrHtwkhfVOJw4zP+pzalFXlA
X-Authority-Analysis: v=2.4 cv=QfjzLcbv c=1 sm=1 tr=0 ts=6afb61d6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=9jRdOu3wAAAA:8 a=e5mUnYsNAAAA:8 a=Ikd4Dj_1AAAA:8 a=El0B2wc1DFe8a7cR29wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=ZE6KLimJVUuLrTuGpvhn:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ZBR468I5jVdNqJiVoBrlwMsMFEoJVOBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX8ohD78r9/k2a
 cuNctQOrPM9anVEWtTn+UkoxFCmb/Wx0vFWoYerCaX2yepXtnITTazUiamr4Vi9qxSj5dRNeFsJ
 W2sQLpHJ4DoKKM/5ahpdjNj36dAZytcM3omwwdMrmqUQ0eJqrJGg65bhvVFjnlCMyg2Mhe5dc3I
 /WKyTYDSTrN7vCHwHRw4hkPZjGFHPznSb8pE3cPmYW2rht0szR+N+u6Iozc2z8eFZIUl2CfT5Zl
 L+io9Eh2ec6qBIBHkoNIy+QCJSofRtgEM+pcpDGgSBkrKP+41SplQKM1VePq+msMU6llU8JHZ/Z
 Uwq1NIp361J5B/C0K+58EamqECIdfkA68qBoiV4GoPci/mj4XwaPbd3wacGsV2j5Ow+8G4kX/gP
 seVb+6zjGYCpSgB6+nXuaipOjE1CdLS8jbkU4LWNDvrra9EK3mXj+fzxEojGvEEuQMHxtmUPJn9
 IOEFOFNH7qrHIDFMgAQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=10 suspectscore=0
 impostorscore=10 adultscore=0 lowpriorityscore=10 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:09:26 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Device migration replaces a PTE that maps the zero page with a new PTE
that is built only from the VMA flags, so its userfaultfd WP or RWP
protection is lost. The same applies to the huge zero PMD. Writes and
accesses to the page are then no longer reported to userfaultfd.

To fix it, do not migrate a uffd-protected zero page. Skip it during
collection, and check again under the page table lock before inserting,
as another thread can protect the page after it was collected.

The alternative would be to carry the uffd state over to the new entry,
but a uffd-protected zero page in a range that a driver migrates should
be rare.

Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/migrate_device.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..140b99f72508 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -159,7 +159,16 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 
 		folio = pmd_folio(*pmdp);
 		if (is_huge_zero_folio(folio)) {
+			/*
+			 * Nothing carries the uffd state of the zero page
+			 * over, so skip it if its uffd bit is set.
+			 */
+			bool protected = userfaultfd_protected(walk->vma) &&
+					 pmd_uffd(*pmdp);
+
 			spin_unlock(ptl);
+			if (protected)
+				return migrate_vma_collect_skip(start, end, walk);
 			return migrate_vma_collect_hole(start, end, -1, walk);
 		}
 		if (pmd_write(*pmdp))
@@ -337,6 +346,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			pfn = pte_pfn(pte);
 			if (is_zero_pfn(pfn) &&
 			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
+				/* See migrate_vma_collect_huge_pmd(). */
+				if (userfaultfd_protected(vma) && pte_uffd(pte))
+					goto next;
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
 				goto next;
@@ -871,10 +883,14 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	if (userfaultfd_missing(vma))
 		goto unlock_abort;
 
-	if (is_huge_zero_pmd(*pmdp))
+	if (is_huge_zero_pmd(*pmdp)) {
+		/* The uffd bit can have been set since the collection. */
+		if (userfaultfd_protected(vma) && pmd_uffd(*pmdp))
+			goto unlock_abort;
 		flush = true;
-	else if (!pmd_none(*pmdp))
+	} else if (!pmd_none(*pmdp)) {
 		goto unlock_abort;
+	}
 
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
@@ -1074,6 +1090,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 		if (!is_zero_pfn(pfn))
 			goto unlock_abort;
+		/* The uffd bit can have been set since the collection. */
+		if (userfaultfd_protected(vma) && pte_uffd(orig_pte))
+			goto unlock_abort;
 		flush = true;
 	} else if (!pte_none(orig_pte))
 		goto unlock_abort;

-- 
2.39.5

