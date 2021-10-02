Return-Path: <SRS0=D5He=OW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 10:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AEB61216
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Oct 2021 10:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62AEB61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033AD6E83B;
	Sat,  2 Oct 2021 10:34:20 +0000 (UTC)
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Sat, 02 Oct 2021 10:34:18 UTC
Received: from sender4-pp-o93.zoho.com (sender4-pp-o93.zoho.com
 [136.143.188.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F95E6E83B
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Oct 2021 10:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1633169954; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PgQmyflizmzCgHsUFwzEb0U2P+34Fseu0hdXBHo/dlxESPAPMLlx0pDwvAYCk86XYnsHm3izrGVElSKU9Ay04QNkhcOKQUh7d1zrhb90ATgIH/0E5LujGRIOIPRw5eWpPyZjBX0U3qi2c0PYXOG278GdVWw/WfOPLzno7Yn+B/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; 
 t=1633169954; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
 bh=2Bvhf78KylY3fN1OuolghHe0A9d5xPfN/rMVTBxE1Jo=; 
 b=oHe2TgnynkrhCOYJzT+wjMuCPaWzZg3zrZRy8WxcSe4RVE7pE98lvJIehx2neC/2gaKh6h0RtCJ4mEhF6gyczyClANwIBj/pqvwUV+SrN6FQT8GBJpkXhzyUMKkR+Qnl8tPjybesItByluf13EBeqaR5bTvOk0j+bns/bDgxdiw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=dufresnep@zoho.com;
 dmarc=pass header.from=<dufresnep@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=zapps768; d=zoho.com; 
 h=date:from:to:message-id:in-reply-to:subject:mime-version:content-type:user-agent;
 b=KIc2Q3ZpOedVsHVAo+VRBiHpOgWx0FsZOrrX3oK7Jwqc0izBWgw5duJ0mnIsMREq605OwcLnJSFm
 FkFRmC1e5Jzs3X/QYyetQl4heXERMQgyBTIYCfoRtPzBSxdZ8/fr  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633169954; 
 s=zm2020; d=zoho.com; i=dufresnep@zoho.com;
 h=Date:From:To:Message-Id:In-Reply-To:Subject:MIME-Version:Content-Type;
 bh=2Bvhf78KylY3fN1OuolghHe0A9d5xPfN/rMVTBxE1Jo=;
 b=KIA0HMWpTD03RlXV0rWkiMBlgkaw6tRLJHsVVKQQwnttYsKMxp9n4CJkclAUVG7P
 8h8bjILWFEglp2MNzX2RFyQrpk2/1NVhRok9Bc/pxfGmL2fcwa2D4XJca9EW+71FTQO
 XaLHfUaKqd60lYg+/xMzcBQtKiQZxgPy0N2F+E5Y=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1633169947002547.8195777189461;
 Sat, 2 Oct 2021 03:19:07 -0700 (PDT)
Received: from  [66.129.153.16] by mail.zoho.com
 with HTTP;Sat, 2 Oct 2021 03:19:06 -0700 (PDT)
Date: Sat, 02 Oct 2021 06:19:06 -0400
From: Paul Dufresne <dufresnep@zoho.com>
To: "amd-gfx" <amd-gfx@lists.freedesktop.org>
Message-Id: <17c4083b965.fc30d96a13861.7509103532064047090@zoho.com>
In-Reply-To: 
Subject: how to help pinpoint ring 0 stalling on resuming from suspend only
 when ShadowPrimary is disabled?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_35035_1037527480.1633169946981"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
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

------=_Part_35035_1037527480.1633169946981
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi! I am a unsure how this message is appropriate here as most messages are patches.



I have temporary access (while helping the computer with a full disk situation), to test a computer with RS780C GPU,

where when resuming with default ShadowPrimary off, ring 0 stalled happens on almost each resume from suspend to ram.

Seems fixed by enabling ShadowPrimary (radeon driver).

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1944991

I mentions this bug on: https://bugzilla.kernel.org/show_bug.cgi?id=85421



The question is there some test I could do that would help pinpoint the problem?

Like a particular drm.debug value boot parameter or something similar?
------=_Part_35035_1037527480.1633169946981
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>=
<meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type"></h=
ead><body ><div style=3D"font-family: Verdana, Arial, Helvetica, sans-serif=
; font-size: 10pt;"><div>Hi! I am a unsure how this message is appropriate =
here as most messages are patches.<br></div><div><br></div><div>I have temp=
orary access (while helping the computer with a full disk situation), to te=
st a computer with RS780C GPU,<br></div><div>where when resuming with defau=
lt ShadowPrimary off, <span class=3D"colour" style=3D"color:rgb(42, 42, 42)=
">ring 0 stalled happens on almost each resume from suspend to ram.</span><=
br></div><div><span class=3D"colour" style=3D"color:rgb(42, 42, 42)">Seems =
fixed by enabling ShadowPrimary (radeon driver).</span><br></div><div><span=
 class=3D"colour" style=3D"color:rgb(42, 42, 42)"><a target=3D"_blank" href=
=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1944991">https://b=
ugs.launchpad.net/ubuntu/+source/linux/+bug/1944991</a></span><br></div><di=
v>I mentions this bug on: <a target=3D"_blank" href=3D"https://bugzilla.ker=
nel.org/show_bug.cgi?id=3D85421">https://bugzilla.kernel.org/show_bug.cgi?i=
d=3D85421</a><br></div><div><br></div><div>The question is there some test =
I could do that would help pinpoint the problem?<br></div><div>Like a parti=
cular drm.debug value boot parameter or something similar?<br></div></div><=
br></body></html>
------=_Part_35035_1037527480.1633169946981--

