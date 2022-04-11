Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B38FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 21:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8DA10E06A;
	Mon, 11 Apr 2022 21:54:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C95110F7C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649712113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hYNVq0t1WrkTI/K6D/l/f7tQTRIta/302c+AVM0dqpk=;
 b=bCaLrqyThmXbjYrDuXyrQTCUDNWRkNfzYCRovpsqzAQt60bG92wTCtRWiNkFMM1fEjV87L
 kLSifGXTFo4TnXovkziuKFC1vI7mOauEpi6+KJfc0bzic9Abvrzvlvf+zSIfv5JwhrtOH4
 zFuSPUkxzCKCCQWi/gZDzeK8OxoYfY4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-PCLCKfmRMeisw7VBMB77DA-1; Mon, 11 Apr 2022 17:21:48 -0400
X-MC-Unique: PCLCKfmRMeisw7VBMB77DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 824D4185A7BA;
 Mon, 11 Apr 2022 21:21:47 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.195.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6192E40CF914;
 Mon, 11 Apr 2022 21:21:46 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
 by tucnak.zalov.cz (8.16.1/8.16.1) with ESMTPS id 23BLLg5f2961636
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 11 Apr 2022 23:21:42 +0200
Received: (from jakub@localhost)
 by tucnak.zalov.cz (8.16.1/8.16.1/Submit) id 23BLLe6o2961635;
 Mon, 11 Apr 2022 23:21:40 +0200
Date: Mon, 11 Apr 2022 23:21:40 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Sergei Trofimovich <slyich@gmail.com>
Subject: Re: gcc inserts __builtin_popcount, causes 'modpost: "__popcountdi2"
 ... amdgpu.ko] undefined'
Message-ID: <YlSb5D3rDTyCWpay@tucnak>
References: <YlSYv3d9a5cZR9KE@nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSYv3d9a5cZR9KE@nz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Mailman-Approved-At: Mon, 11 Apr 2022 21:54:12 +0000
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
Reply-To: Jakub Jelinek <jakub@redhat.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 linux-kbuild@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Andy Lutomirski <luto@kernel.org>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 10:08:15PM +0100, Sergei Trofimovich wrote:
> Current linux-5.17.1 on fresh gcc-12 fails to build with errors like:
> 
>     ERROR: modpost: "__popcountdi2" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
>     ERROR: modpost: "__popcountdi2" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> It is occasionally seen by others on previous gcc versions as well:
> 
>     https://lkml.org/lkml/2021/7/11/261
>     https://lkml.org/lkml/2018/10/24/403
> 
> '__popcountdi2' are inserted by gcc for code like the following
> from 'drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c':
> 
>     static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
>     {
>         uint64_t n = 0;
>         uint8_t count = 0;
>         u8 bksv[sizeof(n)] = { };
> 
>         memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
>         n = *(uint64_t *)bksv;
> 
>         /* Here gcc inserts 'count = __builtin_popcount(n);' */
>         while (n) {
>                 count++;
>                 n &= (n - 1);
>         }
> 
>         return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
>                                MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
>     }
> 
> Note that gcc can insert it regardless of -mno-* options.

Just FYI, this has been added in GCC 9 for https://gcc.gnu.org/PR82479
If the kernel implements its own __popcount?i2, it can perhaps with
runtime patching use hw instructions when those are available and
fallback to the generic version.

	Jakub

