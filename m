Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DE606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=WlLntvbl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09F3112449;
	Thu, 19 Nov 2026 14:10:22 +0000 (UTC)
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com
 [148.163.135.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA0610E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:26:59 +0000 (UTC)
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIEgJnQ3421322
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 10:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=y03Y
 2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=; b=nkgzzLi3h9HeG8fKyYEG
 uDh31vyXH1oYKrz4We4FN7MFzIgxKgw5bbl/1yYWvjel0KI9TY0DcA4tf8wyHfUO
 E9S3VBpfvNnGIkq1nWd7rxaJV0Lqs7OrEOCpyx0/oBVIQHwhYGWzDerPT+uUwcIw
 UNDOHrTbQpKsrdIawLbTecxwoOgThMzBSetvGLfhD1Fr+I+bJ8XjXzV/tn3a/mwj
 WnmC1oaXxkPmI1tAL5NMf/NM2XxF0DEM+oYOVbl6k3afNC9MEBBmKm7ao0MfRmEk
 9PYcQAKRmMuhT+Cw6VRw5kLAg34WlAdslNZkvKUYJ/1MhKqj8LIxnHzWfAB0TDWa
 AQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu84css-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 10:26:58 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so242387785a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795015617; x=1795620417;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
 b=WlLntvblwnONcfhUxAoMG/YrAGVztFECiTcxtIRPsKR96f0ysNTpo8JfRH1FkUJXrR
 5FA6chq87kfh8uK0vn+L/4UW7WD4+2j7MoZcphn+8lE6x8tNMSPEbHUScGas6YU6m4Po
 azvgX44tvhversno90UqRQNdB31YDeFHGszpHrWwstEo4Le/fV5zoDz0qZORflySCMop
 s6pCLeFEOXDO7UEqAHlG1RRErnde50zY0ydbk5Ge0b7mBoDywQO0EJ6zy2UqDKLnm4T+
 Lpejv1M922inJtBSArsfzy2v38WRVCGpmLELG0D/BawpS7duF0wdZafdjszQs+g8H0wZ
 P8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015617; x=1795620417;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
 b=CIZXveHupo7hGnGfEl6HIE0ixTMaYz/UYXWJLstiyfsKocmwFY9JVtaktcEPe2w+x9
 k3EaA01yCUhQCyzPmieKw6lWXLWrHYfZH4evp4VrMPplJgl1k6SsIpMvtpJxdDmIwh/C
 sKeM440zCTW5sWcBdGNrZ6f01bHAOjuAz29mrPk5TBx4veHIEFxmLns8VML4XzhG8tOs
 U1u6DT8GLJ6t43ZR52C4BUBIXfWQeR8kMtgTtD7ygivpmBh4MCUOsviT5FahZRzrw3gk
 mBkEvTS74V8aQXXMfq2sZxSGO6zDu6r0NS+ZnQn1E29hU9srMjsrIoB5Nyl074lOE6k5
 G9/A==
X-Forwarded-Encrypted: i=1;
 AL+hErFGPuMQbCsXnM/HQ10YiJyi9UezX3EN6wNckvzFImqyXA8q/Pc4eM0NjXUPgZzRMZuZnXmS/oF4@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/X0iVmTsxEjziUk9Zbqw33oVwGbGvllwfd8fSJni6/JTG5h3XB
 PpYHVrMBfEixhECkTBQE2rSgZLyWIkftK7hkqriawr6WuAFbJP+g4wmruxMR08UqWL+CJZ62cZn
 4CSCclq5CX6wOBe+w9jgLHiTd9UOpWHNCY5kSX076VLx9K827dwJ0k+nc/d7q714=
X-Gm-Gg: AYBFou2It8mLGyXbRcaNNwqYfbtDZ3UxjlD477uFf9zahMKHuBccD9DZIAatUD4zAzf
 5dB+tuOg/IfXz2D8HNQE2g1me+LVc4t+d04xqCYVQm69f+tRu9t9fwacAKBelQjkVOpiyefk6F4
 Hu/jC3pUS2VRXxFVirZRHhJAndDJOpD0vJU93pRm/H9y5y4KcUTb/e/IiZpDCYVjckzGsFOmB7I
 eu267WIJZD3lIbFsPkIWY++wNgnuPqi8vB307rViPUkggoVAdjQF1kaeRB9s1xvfNZQlF8N/Luk
 2Z9DE2fvdHXKO1P3MZz65JxU+R+e0T7HinhIdQ+Xc8jtMum5yyr9G/B9q/KCnsTeYp6P2TzOnJ/
 glocSFYzLiO7z0aT50lUZLcPPCmLWncbmhIsoOfdWhiKjk2aqz7wGxjsiRR+H964iqBf1HRM2fO
 I3TnYAZsU8e41C+J+Mvf5Rig==
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id
 af79cd13be357-949995f04bamr536128585a.59.1795015617486; 
 Wed, 18 Nov 2026 07:26:57 -0800 (PST)
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id
 af79cd13be357-949995f04bamr536117585a.59.1795015616695; 
 Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu.
 [128.59.176.14]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b72055bsm204599485a.12.2026.11.18.07.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Message-ID: <7d31ba34-8b5f-4eb2-9864-145ea80c3412@columbia.edu>
Date: Wed, 18 Nov 2026 10:26:54 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Michal Hocko <mhocko@suse.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX+XHe8qQiQrit
 v9KK4dcx2DVMHIzEGPbeLc4SNgMBKWKzdiAOGwgLON6SsCWYxrgytVJtSolpT5xyRO79Kq+Ewlm
 mi6BmcBUgpYmeBChZVcyvraD4LFwUlD7BJZ8wbhzBGL5EdPR/+0/
X-Authority-Analysis: v=2.4 cv=IeISymqa c=1 sm=1 tr=0 ts=6afdc3c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX0RdRxoYsuAMb
 TCVzh/WPr4hA58ZWSkwX2BGoqJjF4dFzzp1+5/hIDPpnXVkIhCfGKQGZOQKBLMz6Ckun4VkrHzF
 mGRbAcbx0nSgkjqG6kPg05nmgqPgpsT/JPOCoDowwG5yz0FQN8MTwgAFW6HGvCWOs4f/aIH8oNg
 O54fkl5j/JU4No2jdKhVmwuqN+KgwZ7bjJdVayKuTBUDwqNux0zi+BXc1WZKAcbZ/4Tojz1YCrX
 CX3ebwPtZoJ9/Qq1B+lZET/V6l127e1+3bo68f5hAg502d66d+7Nz8WyF9wuYQJERwtV8F4cDBY
 8BYarJzhcHnyyTqOYYpvGXPYAP6dfpHYM2rJyhCFVZX91RdXHG2rGLgeb7akDX6YxGbIYkci8ME
 Q99nHQUZ3LXMb4vNTFXsMDIiHjUtbmgnjd/zRADyiMHrzz0+v2gTVsQMavkiPaHLwfeOzYP/eki
 A+RBl1EpIsIZ+9gNa3Q==
X-Proofpoint-ORIG-GUID: cxN4XHdMll0SEJTDvHyMr0ilWh3H_NLc
X-Proofpoint-GUID: cxN4XHdMll0SEJTDvHyMr0ilWh3H_NLc
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=10 adultscore=0
 impostorscore=10 phishscore=0 suspectscore=0 lowpriorityscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180061
X-Mailman-Approved-At: Thu, 19 Nov 2026 14:10:22 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 05:28, Tal Zussman wrote:
...

>> Patch 6 has little user impact on its own. It is included because,
>> together with patch 7, it allows removing clear_uffd_wp_pmd().
>> 

...> 
> So, I would be picking up ...
> 
>> Tal Zussman (9):
>>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
>>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
>>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
>>       mm/migrate: warn on a writable migration entry with the uffd bit set
> 
> This
> 
>>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
>>       mm/huge_memory: build the moved huge zero PMD from the destination VMA
> 
> This
> 

So my one concern is that (as per above), the mremap patch removes 
clear_uffd_wp_pmd() after the huge_memory patch removes the other user.
Splitting them may break compilation. I would've left clear_uffd_wp_pmd()
alone but then it throws a nice ugly unused code warning :\

>>       mm/mremap: resolve uffd state when the context is dropped, not during the move
>>       mm/migrate_device: do not migrate a uffd-protected zero page
> 
> This
> 
>>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan
> 
> 
> After waiting a bit longer for more review. Andrew can take the rest.
> 
> 
> -- 
> Cheers,
> 
> David
> 

