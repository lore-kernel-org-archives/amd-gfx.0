Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A131606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=dDI9CewA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86F110FA04;
	Wed, 25 Nov 2026 08:41:53 +0000 (UTC)
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com
 [148.163.139.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B315A10E590
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 19:37:15 +0000 (UTC)
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOJY84i4118647
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=OMjg
 nMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=; b=ArQqb01Alvqy+ezQ3O+b
 wFGaLKLkRPslDfTTnR/1n3YHEnzFvpSAXsSLtAema3OMBGvQTr8MjsfnQdizF1DR
 Y35c9K1YbdbrokVp6lJBFIYVrUHqLLS3WYYBtEDDKg/6m1bODWncA+LZwiNP1MH8
 Z3bx2LUxG6sfpmxDdUI+/kyZI7guQlRgIUWOBYQ6reZ57nqjYw3JFREOmJXGhsy0
 5UyyJqrfI8VjX2MlX1xqtk46jQix4pqRNZv16i1aL2PIz3aAJytU8fQlN33iF7Uo
 xruvXaD2EFNKvtzNiOaeLj7AUiUNlwagsbKMIv+l5TRcoparlTssaELubPi31AEG
 DQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5dsc237g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 14:37:14 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d33f412b1so94172981cf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795549034; x=1796153834;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
 b=dDI9CewADpfltMyOctEQPXef6qPnURtuo0OcT6SbxH3+FlE/qJUYzqIk1vx6CB7hPF
 m6heUBxPsiywc1A4mOJnWGJwRRXEqaqBogcevklS8h/hpO3VLwG7q3GE941ZMYkFoo9i
 XahTHRfSjvaBgI6h8sX5v34XHSjDDnj0zvhERWBJ0HHcphspAyPUoVsNvhy9yTd6ETuN
 RM7j+08t2tuHma+g4qDjVAmbDUS1peebrC/jMUMIUPcW8QYTTw2zc8RAMZREcvdTfTd5
 IuyZ8DVXX3Zm6RdVgJIsaAuaftrJbgRWsBdsmotXmbtpQZc14BWHCN7sfRk56hHDtw2E
 w4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795549034; x=1796153834;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
 b=rknEAVVK++PcySw6vkIdXGWfE0xdPDaJ/Gzk3pP/7MVnO8TPnHs0LZ7Wbm6OUCeK8k
 DNufzPleaKoTkE2X1cx/3eefp7KcCGuEBk7iIer50++YjU8GzgrxAz0ySK7+Htl899lO
 ZcKE7B9ElcD7EEknSYsKdLPmbX6L5AZNuAhaqIkQa1zxnDW0i/vOXyhfdz2a5VbFlqP+
 A3dJrGvZyoNOHsNuJ/Cg9K92A4+ez4JXb5nzucAO6/Z8sRmFnAoEuOgg3X7D3h4Ezez4
 sttc55Spwtp8mVb5TYqTbFOoH3zQq15B47kDMX82ZNEtoFe9Ysfwab7LrahPI0T/szQS
 XKxA==
X-Forwarded-Encrypted: i=1;
 AL+hErG4M7Q97abClyGjeFYG0PNCuxk4iCy3D8rStSFYOleCLDa6V2Nc/UQBFigJJVi4FxVA+aBbSa8f@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1f5z3mJZeQvj+7juOE6qIwcq02A+lSs9La0bTAGzeXCb4UR7B
 WyUPxvEQ3Rqsc2KfKMuTdyzDI4joguTsgXEF0FTI7NTq0L3W0JArGrzvdxENnpKghSSeRGCp6su
 3QoHMsM2SIHwQAOIdUhnh6Ce4/cV2s+Ubj6IL7/95VxB9ixpLLeOs0Fi8D/QDel8=
X-Gm-Gg: AZFdTZc7ploE1U0pOsZ+SkqhX9Lhe8N2msXUfkIYgeRIvorETILJZVPCiwRxvHI3m5a
 hwMoMhi9pSL1ZZ7wJEYcwVVYujj5/QwUH8f9gkY1pI82vxdojEnqI5LubOU6OUL6PU1TZ8KXsJV
 M0ABfbFKOCxdKN7FLWh96qqtm4z1BbrG4buPrzDeIyyEGchgqk3MpoCFAUpGWhdrTkhzUDTMCvt
 LBOzg+WcE/0kFEdIW+wY6ANviaWa8SiRQFt7N+bzdbPknmf6CGB78FF4T6B4cF/udx+N8PbI4Fr
 68/j+wgKoaQtW9xepskmcZ3tCiBtmabrTwlOEEfEpzODrEaxDs10XzC6w8SQ8DvZGWocgLZ/E/4
 4I6wBjLixpICEulXb9Lz6rN34ATz3W4wQ8+2HYL26/SqR1e8BCU6HipbacoQQrpYJYw==
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr288718471cf.49.1795549033829; 
 Tue, 24 Nov 2026 11:37:13 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr288717631cf.49.1795549033344; 
 Tue, 24 Nov 2026 11:37:13 -0800 (PST)
Received: from [10.206.101.158] ([129.236.231.128])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9213515f467sm140631006d6.41.2026.11.24.11.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:37:12 -0800 (PST)
Message-ID: <3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
Date: Tue, 24 Nov 2026 14:37:11 -0500
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX1gxZVFmLWQsL
 ICdAB+jclOGlo8qvZD4juXmr9Nso82oIDFLwh4TXWG8taVrkMakeaLLYeeMXJkVUCpMg4MmvJB+
 4CxZFMU81JTIiOgw4UEcAH+/athzin/y0khdy2LCxi0TZe77tzYQKJbKs/zyWbxfYwv4qZMr4fW
 D3Cttbe4Yeo+FkeUI21wctbAma/ZE3rBjo3VzCHs9KKW+zCpE/u6YzX6ChPorH6ZxfTLuh7uIMk
 uYCcIUNzltYIS0O4kS9h8EDOXY4Lz64Vl255BkevJz8GdBJoFR9uMFVwmfmjO4Pl0wtGeuj2uLJ
 O4aWvo8XFxRGtNovE7tqbn/m/evasnqmCeIKnRn6Yd8lGWqhPF5ggAaH+klThI6X8sYqCb8GnUf
 BoPnmvbF2rz3e5mZHCL6v8AKl4yy5uZyCFt+IgAiHRQfbHhVG5Tqx7dZ4kx7uwtqXKOCQpc7xzO
 Kte0AT7iGnW6O+Zu4Ug==
X-Authority-Analysis: v=2.4 cv=de4VTnXe c=1 sm=1 tr=0 ts=6b05e76a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX9vIR7VoSChxD
 7lj6e+GGCKABzsP1nGLVYGTS42Jzi4zrb9rwxA2j5rvrt93TeCR6UDuGnP7o5TLOqvXDakY/Taj
 TwfGzzoSa/d16EqfMyVzOfq3CCG393JPByZuQ1tu67bPaLWz+Hgi
X-Proofpoint-ORIG-GUID: 685SsJqj3_IQQlIi8P5Dp0RdutbpEbWk
X-Proofpoint-GUID: 685SsJqj3_IQQlIi8P5Dp0RdutbpEbWk
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 adultscore=0 suspectscore=0 impostorscore=10 clxscore=1015 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240076
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:41 +0000
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
...
> 
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

@Andrew, could you pick up the rest of these (everything but 4 and 8)?
I'd like to send the next batch of uffd fixes I have on top of these.

Thanks,
Tal

