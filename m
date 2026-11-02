Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F9606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJmWxti1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B8E10EEFC;
	Mon,  2 Nov 2026 14:16:02 +0000 (UTC)
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D6610EDCA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:02:50 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2ea19bc317dso28356065ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 05:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793624569; x=1794229369; darn=lists.freedesktop.org;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+rVghLVE5+gMoBZCIIvb0ZQoGty/hiEa5No/b+jM194=;
 b=EJmWxti1MnTBeFxvoONDSBdVcyErLp2iFNosSyu+bnTO1cn/XvXFqf8tr1CHCfgDk4
 n+hPK4RjwLARLsHIDIMS2dJzVGfmq6ARZZPKrAN06akaOxD3UsfPSc573SovsybzJJpa
 BZr1+7hI/T8XDlXnQ8lXzArNdoNMDlzsG87XsMjAzWgNj3Imy1FdRzwThqcpDW8Evqxb
 DEkdsbfh3Pok3v+6Z9Z1C0dqQBhGVnGDweh2HXZ2rGAsiXqw/KwmL5EOFVq3qUy+IHYM
 S+a6gxfonjtP4oSKdL6VRphY68/rrXbnneRFqsJ460OCwpqvgy8xe7WHP5wUifDltQBl
 GzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624569; x=1794229369;
 h=references:in-reply-to:cc:to:message-id:date:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+rVghLVE5+gMoBZCIIvb0ZQoGty/hiEa5No/b+jM194=;
 b=vtrEl5cdIfjAPvlRenSl5UvgBdfdMQ90KnVKYatU+mtiFSmCAMeup34pj0WA7fjGCJ
 qjRoqVtdDz6uvnWjdcOmsAY9+tG2uTn2YM7OZDtCDPWfqBTx4iU6Pd0YG2QPEkrTGDxw
 Jc4SOZp6peDgDl3h1+oj/sGY5tIJ2lKn+JWe/Ezq6/opUdVXIap3yrgxEkK2T9UE+C+b
 3RCSxwSm4FyoNlHERJ2eY18UQ+eCCA/Oc9+UiWgveOF+m/1hhR4tOWA810alB7HG7cYP
 AqEWVzgyrKsXrNPBzicseqxbR7Y6/jHTRaLT+DGOO51vwg3WKFzMKPxv9bUdUKzueysz
 hQ+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/lp/kTv0kre08s4MUtrSrckIbeXgCPhcq8r7+sMlzVokTsWXAA61AF89GY2nRQMM2Ei1X6L4V@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Sn7jL1jAZhTsJczuc7myE3yNf/LbvjPDEVAjT3UexoPr0iiNm
 tq6j52LFjusASecrwE8nUWf9xcKzmUl66kcH3Ah0CR+E+9vEOohNgrKH
X-Gm-Gg: AYBFou3VpeZd5tHVmiD7ySBKsjvX4Sq0+TUhlMoSpxyBUYhACa8da5xoAWKwNF+/a2b
 E1J4ssUiHmm8vsr/4TJYUBybelIs1bZvOjIP76QnPXb52kgbuhdJby9glbttkRnNLQ1Kif0qayN
 dfLrbUmGQF87nYTifRmoZg+xG4n9pKXV7Ox/WYFW84LIoG9MPhsTvVijvqOLtq3PWedUHpXDQVh
 K1NU1GXhT4Z9M8/YYp8rqrgk7+nqe0/Y6FZqTfFcb5ZL95kVT5p+XGk+YENFsn98OPDX7qshLRL
 EKd9dLiwxQFNKQFyXQwX5RNsjJsmetkbMIb+YHynWsc66rXsLyTmWEfTCwXG3gUH90zIxJi+2V1
 SoiDFkW4EaHlsOjHNj63hWnlnoLAZnS1qkmI9BAbe7qTB/4tcEYxhOHJi+PEqgWggPt4zNaHRl1
 ZMMsG1yQP6GTdVGd1xvSu7LCCRsHbp8tXFJZf0oMp6i9QcZDq0vAt5Cin8PjDtqcVy7LjJujjCJ
 ECS3rJTrExmcWybj4ZFWAXSAdRCcTUMzfRr4DDtkVoAfhKLZA1rd85Rgi8ONZN8/V5IUzaQ0qnJ
 8FyIKZ/2t9yBWq7WLB/WoqDzr2qW0uBE7YxD3k/Bdcu5mq61QzAjNuD566ng8INPtlVM+GHwGGy
 cANhJHSJayWIxdqXDcfx/n7iQDU1WvZzuBMbo6Z618n5vyGr/IEOVGY4=
X-Received: by 2002:a17:902:db01:b0:2e9:8b2f:3561 with SMTP id
 d9443c01a7336-2eb3650034amr96629035ad.54.1793624569079; 
 Mon, 02 Nov 2026 05:02:49 -0800 (PST)
Received: from [10.131.7.109] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3922f5dasm27542985ad.25.2026.11.02.05.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:02:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/hmm: honor write requests for owned device-private
 pages
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 02 Nov 2026 23:23:28 +1100
Message-Id: <179362220860.2958105.9509793190720553695.b4-reply@b4>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>, Danilo Krummrich <dakr@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 dri-devel@lists.freedesktop.org, 
 Francois Dugast <francois.dugast@intel.com>, Christoph Hellwig <hch@lst.de>, 
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>, 
 Honglei Huang <honghuan@amd.com>, Jann Horn <jannh@google.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Leon Romanovsky <leon@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Matthew Brost <matthew.brost@intel.com>, Michal Hocko <mhocko@suse.com>, 
 Nico Pache <nico.pache@linux.dev>, nouveau@lists.freedesktop.org, 
 Pedro Falcato <pfalcato@suse.de>, Philip Yang <Philip.Yang@amd.com>, 
 Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 Ryan Roberts <ryan.roberts@arm.com>, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev, Simona Vetter <simona@ffwll.ch>, 
 Shuah Khan <skhan@linuxfoundation.org>, Sunil Khatri <sunil.khatri@amd.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Usama Arif <usama.arif@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Zi Yan <ziy@nvidia.com>
In-Reply-To: <179352350180.2.12918668886938034091.b4-reply@b4>
References: <179343062238.2.2773026701442863377@gmail.com>
 <sashiko-outbox-192310@kernel.org>
 <179352350180.2.12918668886938034091.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 02 Nov 2026 14:15:56 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Sun, 01 Nov 2026 19:58:21 +1100 Aveline Noir wrote:

> Oh, I missed that. I'll try to fix it.

While working on this, I found that the fix reaches well beyond
mm/hmm.c and would likely need rework in several subsystems, so I'd
like to hear your views before going further. v1 shouldn't be applied
as is.

amdkfd holds svms->lock and prange->migrate_mutex across
hmm_range_fault(), and svm_migrate_to_ram() needs both, so it can't
migrate the page for the validating task. Migrating under those locks
can deadlock, since do_swap_page() waits for the device page lock, which
a concurrent CPU fault can hold while waiting for svms->lock. From
reading the code, amdkfd also maps such read-only pages writable today,
as it takes GPU write permission from the VMA rather than from
HMM_PFN_WRITE, so GPU writes after fork() would be visible to the child.
I haven't been able to confirm this on hardware.

One option I tried is an opt-in HMM flag that returns -EDEADLK and the
page address instead of faulting, so amdkfd can drop its locks, fault
the page and validate again. It works with test_hmm, but the amdkfd
side grew to about 550 lines across the GPU fault handler, the restore
worker and svm_range_set_attr(), and is only compile-tested. Read-only
entries also come from NUMA hinting scans and mprotect(), so pages that
aren't shared would be moved out of VRAM too, and Xe and nouveau would
see their pages migrated in the same cases.

Would you prefer an opt-in interface like this, a change to the amdkfd
locking so that migrate_to_ram() can run during validation, or
something else? I can post the amdkfd part as an RFC if that helps.

I also found a few smaller related issues, and I'll send fixes for them
separately.

Thanks,
Aveline Noir
