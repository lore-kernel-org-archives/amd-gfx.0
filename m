Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9585D7234D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 08:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9061C10EA64;
	Fri, 23 Jan 2026 08:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nbhvWI6F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC2E10EACE;
 Thu, 22 Jan 2026 21:41:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AD66160018;
 Thu, 22 Jan 2026 21:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E1C116C6;
 Thu, 22 Jan 2026 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1769118076;
 bh=o3gdWNkDSd9Vm/DMgr4/ykIAOvt43+NsJA/Imw15e/A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nbhvWI6FsmrV2v6DkoSqN8213V2yIRhOd6eP75LypoUaN54UBoDiDxVp1akq7FG3f
 CVLIelPV0CkF4x7Juc3HDczRCXMl0AOZY4EUYaiK0pNhQfi7cbwzUhOkV6AnNppJ9U
 SqiE6hXL+nm2nlnc5o4hmp73evXdLpeOeMX2qi64=
Date: Thu, 22 Jan 2026 13:41:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Brost
 <matthew.brost@intel.com>, Zi Yan <ziy@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Alistair Popple
 <apopple@nvidia.com>, Francois Dugast <francois.dugast@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, adhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
 <dakr@kernel.org>, David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Leon Romanovsky <leon@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 1/5] mm/zone_device: Reinitialize large zone device
 private folios
Message-Id: <20260122134114.a04ddf4c34a4b926d057032f@linux-foundation.org>
In-Reply-To: <626c34fc-34df-4629-baf3-fbebc9abafbb@nvidia.com>
References: <eb94d115-18a6-455b-b020-f18f372e283a@nvidia.com>
 <aWsdv6dX2RgqajFQ@lstrano-desk.jf.intel.com>
 <4k72r4n5poss2glrof5fsapczkpcrnpokposeikw5wjvtodbto@wpqsxoxzpvy6>
 <20260119142019.GG1134360@nvidia.com>
 <96926697-070C-45DE-AD26-559652625859@nvidia.com>
 <20260119203551.GQ1134360@nvidia.com>
 <ef6ef1e2-25f1-4f1b-a8d4-98c0d7b4ad0c@nvidia.com>
 <EE2956E3-CCEA-4EF9-A1A4-A483245091FC@nvidia.com>
 <20260120135340.GA1134360@nvidia.com>
 <F7E3DF24-A37B-40A0-A507-CEF4AB76C44D@nvidia.com>
 <aXHPkQfwhMHU/oP6@lstrano-desk.jf.intel.com>
 <9077ab5b-f2c8-4c8d-8441-631e7c2cf384@suse.cz>
 <626c34fc-34df-4629-baf3-fbebc9abafbb@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Jan 2026 08:20:06 +0000
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

On Thu, 22 Jan 2026 20:10:44 +1100 Balbir Singh <balbirs@nvidia.com> wrote:

> >> - Intel has demonstrated that this works and is still getting blocked.
> >>
> >> - This entire thread is about a fixes patch for large device pages.
> >>   Changing prep_compound_page is completely out of scope for a fixes
> >>   patch, and honestly so is most of the rest of what’s being proposed.
> > 
> > FWIW I'm ok if this lands as a fix patch, and perceived the discussion to be
> > about how refactor things more properly afterwards, going forward.
> > 
> 
> I've said the same thing and I concur, we can use the patch as-is and
> change this to set the relevant identified fields after 6.19

So the plan is to add this patch to 6.19-rc and take another look at
patches [2-5] during next -rc cycle?

I think the plan is to take Matthew's work via the DRM tree?  But if people
want me to patchbunny this fix then please lmk.

I presently have

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>

If people wish to add to this then please do so.

I'll restore this patch into mm.git's hotfix branch (and hence
linux-next) because testing.
