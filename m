Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CCBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB1810F11F;
	Fri, 18 Feb 2022 15:25:34 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DDB10EE19
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:01:55 +0000 (UTC)
Received: by mail-qv1-xf32.google.com with SMTP id d7so15224188qvk.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qQOuPloDj1FDvrT18I7yp3YumR1JEJ9ojjlV/rcHoPw=;
 b=RoS0gyblqR/tsGfQ7lArc8WXX3kNZMvPTfZET3nsnl+Rr8n361EoMRIfa1S+T8g8oc
 NmAlJEUUOZ5XHaM5YrjNSr5VsFbJTayGS5be9bu+8ZuTGnnxnkPavDlHAMpATFRtc11K
 fiKwKgEOqF+51vJxLCJG62RY8EQ2KpYmP7mAntkiGoPgLp6RQG9Lz93DB55QoyA5iy4K
 jD0aW9yE0JKDtqB8vCY2rRZ02xMADfrBesx1EB/DYj+qq78BrufP6AkXF4xsqmELAlVq
 1FXz/tX3UyRzucAxKzmHRYKSZZAyzlWABCgkRcxEK/GH/tUhjJjJ7pXdKtahQ8czEgJj
 SqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qQOuPloDj1FDvrT18I7yp3YumR1JEJ9ojjlV/rcHoPw=;
 b=a+BNSzUbH7QE+nfN4tbz9fYRD3xi+IYg3DOtmahjtDMOVg7G54K8o62NxdRdD+LqGy
 oyKtvsb+LkihFZ/QlCqOsrmAkSNH2J8wcuzyE07NRLtnMFufCs+k323KwcS/lPSOZL/H
 UBfDmDITW/Vi25NC6U6reRGncT9DpKd6LEw+tnF3w1SlQx9In2B3nJY/ShJWJ5vEma2C
 zYbPYd1iKVgGkPrvB0u4Tkz1Mt9Jf/+ZMFiGiL4IB4xjq4yHC9XqoongxhgzK8jOzvql
 BdVVBWcJGX2Gqsx3xzlpJ4xThUTDt08T/1v2opuunN+ceoo0z2sNaWH4LPw0XLkKJuMy
 o/lg==
X-Gm-Message-State: AOAM532HoNuS7uWGROLh97YLRi2T60EqySAAM72r2Dl/jmSoUfKp0zUr
 fqKX7AZOakkLKJ8hN7qeEXkX/g==
X-Google-Smtp-Source: ABdhPJxj9yyCZvW5c4Ugzq0ieNoelSzlHZ5AUX07DsgnGoll6g+QZTPyJ2Fq/jgnUxsgsAq5KC011A==
X-Received: by 2002:ac8:7fd5:0:b0:2cf:93ff:5638 with SMTP id
 b21-20020ac87fd5000000b002cf93ff5638mr7063274qtk.435.1645196514006; 
 Fri, 18 Feb 2022 07:01:54 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id s4sm23008395qko.113.2022.02.18.07.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Feb 2022 07:01:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nL4lb-006cts-Vr; Fri, 18 Feb 2022 11:01:51 -0400
Date: Fri, 18 Feb 2022 11:01:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Gow <davidgow@google.com>
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
Message-ID: <20220218150151.GD1037534@ziepe.ca>
References: <20220218075727.2737623-1-davidgow@google.com>
 <20220218075727.2737623-5-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218075727.2737623-5-davidgow@google.com>
X-Mailman-Approved-At: Fri, 18 Feb 2022 15:25:33 +0000
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
Cc: x86@kernel.org, linux-rdma@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Brendan Higgins <brendanhiggins@google.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-um@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, kunit-dev@googlegroups.com,
 felix.kuehling@amd.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 18, 2022 at 03:57:27PM +0800, David Gow wrote:
> There are a number of Kconfig options which break compilation under UML with
> allyesconfig.  As kunit_tool's --alltests option is based on allyesconfig and
> UML, we need to update the list of broken options to make --alltests build
> again.
> 
> Note that, while this does build again, it still segfaults on startup,
> so more work remains to be done.
> 
> They are:
> - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache

It doesn't make sense to patch qib and then turn this option off, it
is required to build qib.

Jason
