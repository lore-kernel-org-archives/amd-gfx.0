Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BCC3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 00:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E28246A1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 00:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E28246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659496ED9B;
	Fri, 28 Feb 2020 00:21:29 +0000 (UTC)
Received: from mailbnc111.isp.belgacom.be (mailbnc111.isp.belgacom.be
 [195.238.20.245])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9836ED9C;
 Fri, 28 Feb 2020 00:21:26 +0000 (UTC)
IronPort-SDR: JPow1+KEiQYaKfpguQ0Bp1vQUQ8b/vL6U5+Bmn+V74P4po3QIXY6svr7NPDtPwyFFcjcZARiWg
 leGnU9HPI7Q37JhH/750IHePhjkpQthl3mnYtSIFtIY8g2Cl3/KGURmmvMZcFAC5yjrtEAS3Kv
 XR0JApVGCixra1o71DIgHhJhUCdcw/XA//zPUN6NZrBhMUieB0dxZJcpYLZ5HYzBDYe80v52pp
 fw2ez+3CHy9vruZwgrH+A3/p6Mz/K54fgQmG16WqMNGS0Z2JuGHejC0f6c1yU5rvt50nETHQLL
 Jt4=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CBBgBNXFhe/37G9C5QFhwBAQEBAQc?=
 =?us-ascii?q?BAREBBAQBAYF7gX0sKAU/BU8hEiqDTIlLhjYPCQUBgTMEiXGPZYFnCQEBAQE?=
 =?us-ascii?q?BAQEBAQgbEQECBAEBhDoEAgIIgX0nOBMCAwEBAQMCBQEBBgEBAQEBAQQEbQQ?=
 =?us-ascii?q?BAQcKhFECAQMBAQUKATcMhWQBBTocGgkQCAMYCQoCGQ8FKCEtgw2CVimxBYk?=
 =?us-ascii?q?HgT4igRaGBIY7eYEHhCQ+hAQCgQSDBIIsBJAmn3CCRpZZDByCSYw9LIt8ngy?=
 =?us-ascii?q?MU4FpIoFYTSAYgycJRyWPRAEIh1eFQkMwgQIBHggTBQUBAY1sAQE?=
X-IPAS-Result: =?us-ascii?q?A2CBBgBNXFhe/37G9C5QFhwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X0sKAU/BU8hEiqDTIlLhjYPCQUBgTMEiXGPZYFnCQEBAQEBAQEBAQgbEQECB?=
 =?us-ascii?q?AEBhDoEAgIIgX0nOBMCAwEBAQMCBQEBBgEBAQEBAQQEbQQBAQcKhFECAQMBA?=
 =?us-ascii?q?QUKATcMhWQBBTocGgkQCAMYCQoCGQ8FKCEtgw2CVimxBYkHgT4igRaGBIY7e?=
 =?us-ascii?q?YEHhCQ+hAQCgQSDBIIsBJAmn3CCRpZZDByCSYw9LIt8ngyMU4FpIoFYTSAYg?=
 =?us-ascii?q?ycJRyWPRAEIh1eFQkMwgQIBHggTBQUBAY1sAQE?=
Received: from ppp-46-244-198-126.dynamic.mnet-online.de (HELO albert)
 ([46.244.198.126])
 by relay.proximus.be with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Feb 2020 01:21:23 +0100
Received: from libv by albert with local (Exim 4.84_2)
 (envelope-from <libv@skynet.be>)
 id 1j7TP8-0007yR-JM; Fri, 28 Feb 2020 01:21:22 +0100
Date: Fri, 28 Feb 2020 01:21:22 +0100
From: Luc Verhaegen <libv@skynet.be>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: gitlab.fd.o financial situation and impact on services
Message-ID: <20200228002122.GB24271@skynet.be>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>, gstreamer-devel@lists.freedesktop.org,
 Mesa Dev <mesa-dev@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 10:27:04PM +0100, Daniel Vetter wrote:
> Hi all,
> 
> You might have read the short take in the X.org board meeting minutes
> already, here's the long version.
> 
> The good news: gitlab.fd.o has become very popular with our
> communities, and is used extensively. This especially includes all the
> CI integration. Modern development process and tooling, yay!
> 
> The bad news: The cost in growth has also been tremendous, and it's
> breaking our bank account. With reasonable estimates for continued
> growth we're expecting hosting expenses totalling 75k USD this year,
> and 90k USD next year. With the current sponsors we've set up we can't
> sustain that. We estimate that hosting expenses for gitlab.fd.o
> without any of the CI features enabled would total 30k USD, which is
> within X.org's ability to support through various sponsorships, mostly
> through XDC.
> 
> Note that X.org does no longer sponsor any CI runners themselves,
> we've stopped that. The huge additional expenses are all just in
> storing and serving build artifacts and images to outside CI runners
> sponsored by various companies. A related topic is that with the
> growth in fd.o it's becoming infeasible to maintain it all on
> volunteer admin time. X.org is therefore also looking for admin
> sponsorship, at least medium term.
> 
> Assuming that we want cash flow reserves for one year of gitlab.fd.o
> (without CI support) and a trimmed XDC and assuming no sponsor payment
> meanwhile, we'd have to cut CI services somewhere between May and June
> this year. The board is of course working on acquiring sponsors, but
> filling a shortfall of this magnitude is neither easy nor quick work,
> and we therefore decided to give an early warning as soon as possible.
> Any help in finding sponsors for fd.o is very much appreciated.
> 
> Thanks, Daniel

So this cost is all about fd.o?

I feel that this was not communicated to x.org members at all, when fd.o 
"merging" was suggested. In as far as this was a merge.

Luc Verhaegen.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
