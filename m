Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33791E7C716
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Feb 2026 10:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADB610E0CD;
	Sun,  1 Feb 2026 10:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="j2G1+XR1";
	dkim-atps=neutral
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Fri, 30 Jan 2026 16:38:37 UTC
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA0310EA15
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 16:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1769790215; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GUtyMrn+sZkWeF3hJNJfgwxXzlwTwdCclqrFbdwyUnGvwKadxqMmofzxGUVNqt/DfD4i3fc4sQHeltSPjsOec0HdG+jdKnIZBYtp84HLSACsyE3sUPxkTEO+UnJObppOFHaq4ergw8z+3f0EzisOnUwIc1NjQeJgnrLGWlrclU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769790215;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=ubmhhz7B61pt9kxVD/5GzWIEdW0nZ1t1y7EKoHxDhEA=; 
 b=lSKXPgTKtSPtqb+cHAAFDpendKuSIznhuPIfBczjbKPYhgpa38068HbShFYjr/sFK785rju7xHGZvhYwK1LlHdoElefeCkovQFI9fHeV+m+DyfpVb8DYGajJi4bXxYut49wzxDxsoBNxvw4lNG4msrfDZI1O5TsejSutzoh6U18=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769790215; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:MIME-Version:Message-Id:Reply-To:Cc;
 bh=ubmhhz7B61pt9kxVD/5GzWIEdW0nZ1t1y7EKoHxDhEA=;
 b=j2G1+XR15/ZkNAiASB6d+hL/K5aedoDWqO49Sh0Op+b0CfttWFnHtjFY0jxlHZDZ
 pk4T2xK24myPUU9YZDsF94MfEVtubjbqO5V+JX98SZMu84zB6cW1dR0VnKbWXMmPLjC
 KNcbH/NL+OmN9PTNBPqbJPbylb8nVOroAPSyZhMY=
Received: by mx.zohomail.com with SMTPS id 1769790214324771.9133735906909;
 Fri, 30 Jan 2026 08:23:34 -0800 (PST)
Message-ID: <0b6e101935479ec7c9cffb5452e39015be28f480.camel@collabora.com>
Subject: Save the Date! XDC 2026 comes to Toronto
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Fri, 30 Jan 2026 11:23:31 -0500
Content-Type: multipart/alternative; boundary="=-66kTK8QK+FQ47G6AXzNi"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43app1) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 01 Feb 2026 10:52:53 +0000
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

--=-66kTK8QK+FQ47G6AXzNi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

We=E2=80=99re excited to announce that XDC 2026 will take place September 2=
8=E2=80=9330
in Toronto, Canada =E2=80=94 mark your calendars!

The conference will be held in person at Daniels Spectrum, a vibrant
community cultural hub in the heart of Toronto=E2=80=99s Regent Park
neighbourhood, just minutes from Yonge=E2=80=93Dundas Square.

We=E2=80=99d also like to extend a sincere thank you to Arm for organizing =
this
year=E2=80=99s conference and helping make XDC another great success.

Registration and the Call for Proposals will be opening soon, so stay
tuned!

Until then, be sure to follow us on Mastodon for the latest news and
updates:
https://floss.social/@XOrgDevConf

Best,

Mark

--=-66kTK8QK+FQ47G6AXzNi
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head><body><div>Hello!</div><div><br></div><div>We=E2=80=99re exc=
ited to announce that XDC 2026 will take place September 28=E2=80=9330 in T=
oronto, Canada =E2=80=94 mark your calendars!</div><div><br></div><div>The =
conference will be held in person at Daniels Spectrum, a vibrant community =
cultural hub in the heart of Toronto=E2=80=99s Regent Park neighbourhood, j=
ust minutes from Yonge=E2=80=93Dundas Square.</div><div><br></div><div>We=
=E2=80=99d also like to extend a sincere thank you to Arm for organizing th=
is year=E2=80=99s conference and helping make XDC another great success.</d=
iv><div><br></div><div>Registration and the Call for Proposals will be open=
ing soon, so stay tuned!</div><div><br></div><div>Until then, be sure to fo=
llow us on Mastodon for the latest news and updates:</div><div><a href=3D"h=
ttps://floss.social/@XOrgDevConf">https://floss.social/@XOrgDevConf</a></di=
v><div><br></div><div>Best,</div><div><br></div><div>Mark</div><div><span><=
/span></div></body></html>

--=-66kTK8QK+FQ47G6AXzNi--
