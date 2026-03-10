Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A926FFD064E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09F210E39A;
	Wed, 11 Mar 2026 08:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Zo0CYay3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD5610E286
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773148928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
 b=Zo0CYay3fNS6nNUgO9JjxVGq9cPty8oV+Lr9ojdybQ8yTkOX4mN9U3Jy00cnf/ksl5lySC
 yySxefhsO579pYAHU3v/+4/Km7BtCaevJSSgvrsHg4X0Gz9yvYwnOWWC6jIDZFWyj++WtH
 +b+fK8uNDufV9iRkUqAPcaEBErJYWuI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-YrmSOHnBNmuFZYt2uOz1xw-1; Tue, 10 Mar 2026 09:22:05 -0400
X-MC-Unique: YrmSOHnBNmuFZYt2uOz1xw-1
X-Mimecast-MFC-AGG-ID: YrmSOHnBNmuFZYt2uOz1xw_1773148925
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd773dd39bso2180666485a.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773148925; x=1773753725;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5/adDEbR57gUpYJcJq84OoDVxrrM3xMPFmZCRo0jKXM=;
 b=Db7Wd1nPfDezv4UjZjSa6SeTtt7sYCJY6vD3s5DJmXl41Xq7CJzjQxt8UwUO9lJrVv
 1mTH/C5FaLo1aqZwYXHmVdNC9txh+JHC//jufdgVI7ZHIcOOVABRb251XO5PUvGP3Had
 4kOflRTSZ91hw7oXf6YwvM9WRtXyugOlzxdH8mxaydEHUmouWCznYxjcA2MubwU+N20A
 CpA7h6iDDbAI5j9aN4Ky/FVn6x+HizDU7PiaFeHqXIx1O0ZHbFltiOknaCNpcaeIvKvP
 bnCCuFm/ASGusExF6RkZgXyqkPkJSA5KHH7E7CsvSFAq4NsKIVOFdYF0FGgZGoNnfKDD
 UOsw==
X-Gm-Message-State: AOJu0YwMyjBpSKWkAO5qWPf52jS/hUU3Ej724MRN+CfH2tF0kwy1uzfd
 IAqUSP6M7O2ZM66MrHfu+uFpLfKIaChWl8w3q2uArtzpo0ADo+tHJ3LEttgcHYNVM7nLd0VRqDF
 ngwoSBqbL1vGzODsaHqkFesdqD3buJfW1BuM3aCfdwtaIWxrPum2coHmyUDj/t0OkGtw=
X-Gm-Gg: ATEYQzyYq/pCBbwr0Z86JQQC/WHOV6Ys+0iqVHrDTUzoppWtHZbf/kAgMjU3en41jVf
 nkWun/almnew32VGSxvYsFPPg9GD6m+ldlq8TeJlnvuWXsRmikuE6Y6udwjwx47A16dtIZuF8zg
 H9PUdRLOOhYPeQP0PZpief3bYVCToDFqKVb1c24e7t1k0ygncAN2tvvwxeqC6zzTJXHkaaaA66v
 Nz589kBCzXXsbm5Y8dChSbewXryIoB45uU/FEL9F6k7B0x04JzQGXg2ZxxLHnHXcljP7X0bU95G
 gQcGA2zYcJv67uXLpxmlQYHoxZ3PwHc8QaXUlURLzRb0YlbGpgUojfPRk8dvHMXuNd412CsPYyV
 tLPpfJJKu7GgIn9riM4sKMavuJ3pqAwOjpJ3bY/OXaOv3XELD8vqhohdx
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id
 af79cd13be357-8cd6d4f9469mr1830784085a.45.1773148924655; 
 Tue, 10 Mar 2026 06:22:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3713:b0:8ca:1240:4991 with SMTP id
 af79cd13be357-8cd6d4f9469mr1830766185a.45.1773148922638; 
 Tue, 10 Mar 2026 06:22:02 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net.
 [73.183.52.120]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm474754485a.47.2026.03.10.06.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 06:22:01 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:21:58 -0400
From: Brian Masney <bmasney@redhat.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Message-ID: <abAa9vQg4BSxl1BJ@redhat.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
MIME-Version: 1.0
In-Reply-To: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iR4TcSC_JMFe_qyU8CJHw321eKOaztD0Gzl1d7bAq88_1773148925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

On Tue, Mar 10, 2026 at 12:49:22PM +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Semantich change: Previously the code only printed the warning on error,

Semantic ...

> but not when the pointer was NULL. Now the warning is printed in both
> cases!
> 
> Change found with coccinelle.
> 
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Daniel Lezcano <daniel.lezcano@kernel.org>
> To: Thomas Gleixner <tglx@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

With the minor typo addressed:

Reviewed-by: Brian Masney <bmasney@redhat.com>

