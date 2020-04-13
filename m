Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A5C2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C0420692
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr9vO3PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C0420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E4ED89CBE;
	Mon, 13 Apr 2020 18:43:04 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6253489CBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 18:43:03 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id i19so5078834qtp.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9hdOyb+Q0mokX/44CwUiOk5xqFj7SYWIPZ+lCG7T0Eg=;
 b=Kr9vO3PMsgCeOyFWhO3TclJuGWbs0fHJc2AQA/LmQCGhLqsm5iDtr/GcnANGo/OM3o
 KoRhQfZLMOcf9LqLKw9VUUol0zQmx9m48N01HKzdS+cNkKFmU1R9ANNu48Io0ip4VsLA
 xgWlYxpDYPP/kex3O9362IwKK1Qi0dcXIs7xJi8Trxi3tSqpdxfmUIuNvqTN+rq2uxqa
 +gKc5WUlclLNcMNdYMeApePAtb7m9ZaAbOkV0i42+yd4fm3e/uhcE4ydDIj4aTJ+rPr0
 x5YwDs2/H0omUWxqjCnnP1d5aANFrnG2xTJtU3wuna9/0xLMgy4id0Rl0koe65gBtn5M
 JluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=9hdOyb+Q0mokX/44CwUiOk5xqFj7SYWIPZ+lCG7T0Eg=;
 b=YRBBM7dDmdvdGaAPQJro7yJiDkFdfDeqPfgwcmDVVWAJQWLjaeIkic+t1HG2EsSjhb
 uwOeKAH9i98k39Gc4b8zFPiyI03fZP9b+ypLAtLxVkyM4aenhWhUe3O4ehF8ZqEqaQLi
 U/LekfxkqfH5uQafSj+0fsjqzdkqnzKSyiDdsVXx55xodjGaR5maz5kZ83QpbMdgh3m7
 GTSgvkIc+/wDM+W6C3+SCR9JSRWAT485Hmpkix7kA4dstB/qX3m5C4wIls3hHRK1khZ7
 91YhnaIa29RDgWLpZklILNhq0PsUVMp+qNjIJLQWp4LinZbPmTbnUvHi4BLl6mX8eSIf
 yZTg==
X-Gm-Message-State: AGi0PuYOl6roqifbheEMnqXH5ZgtA54SkeZ1nDJsis/CuCta71USoCO+
 ADO6GKyGW0phbSxI/1AIxWo=
X-Google-Smtp-Source: APiQypIPdW/QJJZqLP/TkerWlwHpaMuPK/bLBUC9J5nqxzuhhRMaFL7EwWWnl1+xrYlNcjysRl71yA==
X-Received: by 2002:ac8:27f9:: with SMTP id x54mr12450620qtx.45.1586803382293; 
 Mon, 13 Apr 2020 11:43:02 -0700 (PDT)
Received: from localhost ([199.96.181.106])
 by smtp.gmail.com with ESMTPSA id z3sm9060905qtq.7.2020.04.13.11.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 11:43:01 -0700 (PDT)
Date: Mon, 13 Apr 2020 14:43:00 -0400
From: Tejun Heo <tj@kernel.org>
To: Odin Ugedal <odin@ugedal.com>
Subject: Re: [PATCH] device_cgroup: Cleanup cgroup eBPF device filter code
Message-ID: <20200413184300.GE60335@mtj.duckdns.org>
References: <20200403175528.225990-1-odin@ugedal.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200403175528.225990-1-odin@ugedal.com>
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
Cc: Harish.Kasiviswanathan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, guro@fb.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 03, 2020 at 07:55:28PM +0200, Odin Ugedal wrote:
> Original cgroup v2 eBPF code for filtering device access made it
> possible to compile with CONFIG_CGROUP_DEVICE=n and still use the eBPF
> filtering. Change 
> commit 4b7d4d453fc4 ("device_cgroup: Export devcgroup_check_permission")
> reverted this, making it required to set it to y.
> 
> Since the device filtering (and all the docs) for cgroup v2 is no longer
> a "device controller" like it was in v1, someone might compile their
> kernel with CONFIG_CGROUP_DEVICE=n. Then (for linux 5.5+) the eBPF
> filter will not be invoked, and all processes will be allowed access
> to all devices, no matter what the eBPF filter says.

Applied to cgroup/for-5.7-fixes.

Thanks.

-- 
tejun
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
