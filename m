Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3855DC83F10
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 10:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BB910E5F4;
	Tue,  8 Jul 2025 10:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="YYTBxV9u";
	dkim-atps=neutral
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Mon, 07 Jul 2025 15:17:04 UTC
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12C910E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 15:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1751900517; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RMSIsovZ8wAaBsxC7pDM8UY15vJgeiQGL9TmHKnQCKQj1Vrwah0rzvuFvJUnyxtfyyMjcRBfWNxKjaEARNKsRM+HmsqiE97u9XaRj7b3vJdtKNkmXd//UvghOZPO4/p5iNxuH8o8FeILYgg1z/jH2JKJ04ljO5oBD6BNMUNsHMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1751900517;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=F353p308cAFAebFrvdZCUK7Q0Jty8Jgzhy1vv7SqF3g=; 
 b=HS5rKnpNXnaj6/HdKG13xru+TCFYDUU9x2IrNIJdLQIFFybMeTYn+T1EdG2pmE/+Cqb/fYcaP5voIMPsbCkf3+3mINSNsJB2FKqvsFzfzEt/hUcqMv2urDbzzT1LH6fiRqwYd4uXFD94kUjxUKQNws+Phnpofdgijsi4dMqYIKA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751900517; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:MIME-Version:Message-Id:Reply-To:Cc;
 bh=F353p308cAFAebFrvdZCUK7Q0Jty8Jgzhy1vv7SqF3g=;
 b=YYTBxV9uakcMu9UZQEEZEC9pcjToyrUNg0wL58tjKUXecA+r1g03xpEv+RG3j53f
 jppYtC09oCkDuYJkXGVymh0k7dL3Uj8MmOax3mE99IWBsRYepS6qMAkHWJSYkBGt7y7
 BGYNlOgwPsgHeFa6Fzvfg6epMiBjmJ6woJ8muoeQ=
Received: by mx.zohomail.com with SMTPS id 1751900514127718.8835910629498;
 Mon, 7 Jul 2025 08:01:54 -0700 (PDT)
Message-ID: <61e9af9288d83e764de34eb13d3c3f6d95db44e1.camel@collabora.com>
Subject: Reminder: Final week to submit a talk for XDC 2025!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Mon, 07 Jul 2025 11:01:52 -0400
Content-Type: multipart/alternative; boundary="=-sNpkJEXFOt/iebB/OTLT"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 08 Jul 2025 10:29:18 +0000
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

--=-sNpkJEXFOt/iebB/OTLT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

It's the final week to submit a talk for XDC 2025, which will
take place at the TU Wien Kuppelsaal in Vienna, Austria on 29
September to 1 October. CfP ends this coming Friday, 11 July at 23:59
CEST.

=C2=A0=C2=A0=C2=A0=C2=A0https://xdc2025.x.org
=C2=A0=C2=A0
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible:

=C2=A0=C2=A0=C2=A0=C2=A0https://indico.freedesktop.org/event/10/registratio=
ns/

In addition to registration, the CfP is now open for talks, demos, and
workshops at XDC 2025. While any serious proposal will be gratefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more:

=C2=A0=C2=A0=C2=A0=C2=A0https://indico.freedesktop.org/event/10/abstracts/

The deadline for submissions Friday, 11 July 2025.

We are looking forward to seeing you in Vienna! If you have any
questions, please email the organizer (hfink at snap.com), adding on
CC the X.org board (board at foundation.x.org).

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

=C2=A0=C2=A0=C2=A0=C2=A0https://floss.social/@XOrgDevConf

Best,

Mark

--=-sNpkJEXFOt/iebB/OTLT
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
</style></head><body><div style=3D"unicode-bidi: plaintext; font-family: &q=
uot;Adwaita Sans&quot;; font-style: normal; font-variant-caps: normal; font=
-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tap-h=
ighlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-de=
coration: none; caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);">H<span sty=
le=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &q=
uot;Adwaita Mono&quot;;">ello!</span></div><div style=3D"unicode-bidi: plai=
ntext; font-family: &quot;Adwaita Sans&quot;; font-style: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stro=
ke-width: 0px; text-decoration: none; caret-color: rgb(0, 0, 0); color: rgb=
(0, 0, 0);"><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 5=
4); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb=
(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;=
;">It's the final week to submit a talk for XDC 2025, which will</span><br =
style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family:=
 &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); co=
lor: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">take place at=
 the TU Wien Kuppelsaal in Vienna, Austria on 29</span><br style=3D"caret-c=
olor: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita M=
ono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52,=
 54); font-family: &quot;Adwaita Mono&quot;;">September to 1 October. CfP e=
nds this coming Friday, 11 July at 23:59 CEST.</span><br style=3D"caret-col=
or: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mon=
o&quot;;"><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54)=
; font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(4=
6, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"=
>&nbsp;&nbsp;&nbsp;&nbsp;</span><a href=3D"https://xdc2025.x.org/" title=3D=
"Click to open https://xdc2025.x.org/" style=3D"color: rgb(46, 52, 54); fon=
t-family: &quot;Adwaita Mono&quot;;">https://xdc2025.x.org</a><br style=3D"=
caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Ad=
waita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(=
46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">&nbsp;&nbsp;</span><br=
 style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family=
: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); c=
olor: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">As usual, th=
e conference is free of charge and open to the general</span><br style=3D"c=
aret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adw=
aita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(4=
6, 52, 54); font-family: &quot;Adwaita Mono&quot;;">public. If you plan on =
attending, please make sure to register as early</span><br style=3D"caret-c=
olor: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita M=
ono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52,=
 54); font-family: &quot;Adwaita Mono&quot;;">as possible:</span><br style=
=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quo=
t;Adwaita Mono&quot;;"><br style=3D"caret-color: rgb(46, 52, 54); color: rg=
b(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret=
-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita=
 Mono&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;</span><a href=3D"https://indico.free=
desktop.org/event/10/registrations/" title=3D"Click to open https://indico.=
freedesktop.org/event/10/registrations/" style=3D"color: rgb(46, 52, 54); f=
ont-family: &quot;Adwaita Mono&quot;;">https://indico.freedesktop.org/event=
/10/registrations/</a><br style=3D"caret-color: rgb(46, 52, 54); color: rgb=
(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><br style=3D"caret-co=
lor: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mo=
no&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, =
54); font-family: &quot;Adwaita Mono&quot;;">In addition to registration, t=
he CfP is now open for talks, demos, and</span><br style=3D"caret-color: rg=
b(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot=
;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); fo=
nt-family: &quot;Adwaita Mono&quot;;">workshops at XDC 2025. While any seri=
ous proposal will be gratefully</span><br style=3D"caret-color: rgb(46, 52,=
 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span=
 style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family=
: &quot;Adwaita Mono&quot;;">considered, topics of interest to X.Org and fr=
eedesktop.org developers</span><br style=3D"caret-color: rgb(46, 52, 54); c=
olor: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=
=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quo=
t;Adwaita Mono&quot;;">are encouraged. The program focus is on new developm=
ent, ongoing</span><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46=
, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-col=
or: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mon=
o&quot;;">challenges and anything else that will spark discussions among</s=
pan><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font=
-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52,=
 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">atten=
dees in the hallway track.</span><br style=3D"caret-color: rgb(46, 52, 54);=
 color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><br style=
=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quo=
t;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: =
rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">We are open to tal=
ks across all layers of the graphics stack, from the</span><br style=3D"car=
et-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwai=
ta Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46,=
 52, 54); font-family: &quot;Adwaita Mono&quot;;">kernel to desktop environ=
ments / graphical applications and about how</span><br style=3D"caret-color=
: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&=
quot;;"><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54)=
; font-family: &quot;Adwaita Mono&quot;;">to make things better for the dev=
elopers who build them. Head to the</span><br style=3D"caret-color: rgb(46,=
 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><=
span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-fa=
mily: &quot;Adwaita Mono&quot;;">CfP page to learn more:</span><br style=3D=
"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;A=
dwaita Mono&quot;;"><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(4=
6, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-co=
lor: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mo=
no&quot;;">&nbsp;&nbsp;&nbsp;&nbsp;</span><a href=3D"https://indico.freedes=
ktop.org/event/10/abstracts/" title=3D"Click to open https://indico.freedes=
ktop.org/event/10/abstracts/" style=3D"color: rgb(46, 52, 54); font-family:=
 &quot;Adwaita Mono&quot;;">https://indico.freedesktop.org/event/10/abstrac=
ts/</a><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); f=
ont-family: &quot;Adwaita Mono&quot;;"><br style=3D"caret-color: rgb(46, 52=
, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><spa=
n style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-famil=
y: &quot;Adwaita Mono&quot;;">The deadline for submissions Friday, 11 July =
2025.</span><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 5=
4); font-family: &quot;Adwaita Mono&quot;;"><br style=3D"caret-color: rgb(4=
6, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"=
><span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-=
family: &quot;Adwaita Mono&quot;;">We are looking forward to seeing you in =
Vienna! If you have any</span><br style=3D"caret-color: rgb(46, 52, 54); co=
lor: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=
=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quo=
t;Adwaita Mono&quot;;">questions, please email the organizer (hfink at snap=
.com), adding on</span><br style=3D"caret-color: rgb(46, 52, 54); color: rg=
b(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret=
-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita=
 Mono&quot;;">CC the X.org board (board at foundation.x.org).</span><br sty=
le=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &q=
uot;Adwaita Mono&quot;;"><br style=3D"caret-color: rgb(46, 52, 54); color: =
rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"car=
et-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwai=
ta Mono&quot;;">And don't forget, you can follow us on Mastodon for all the=
 latest</span><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52,=
 54); font-family: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: r=
gb(46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quo=
t;;">updates and to stay connected:</span><br style=3D"caret-color: rgb(46,=
 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><=
br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-fami=
ly: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 54);=
 color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">&nbsp;&nbs=
p;&nbsp;&nbsp;</span><a href=3D"https://floss.social/@XOrgDevConf" title=3D=
"Click to open https://floss.social/@XOrgDevConf" style=3D"color: rgb(46, 5=
2, 54); font-family: &quot;Adwaita Mono&quot;;">https://floss.social/@XOrgD=
evConf</a><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54)=
; font-family: &quot;Adwaita Mono&quot;;"><br style=3D"caret-color: rgb(46,=
 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;"><=
span style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-fa=
mily: &quot;Adwaita Mono&quot;;">Best,</span><br style=3D"caret-color: rgb(=
46, 52, 54); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;=
"><br style=3D"caret-color: rgb(46, 52, 54); color: rgb(46, 52, 54); font-f=
amily: &quot;Adwaita Mono&quot;;"><span style=3D"caret-color: rgb(46, 52, 5=
4); color: rgb(46, 52, 54); font-family: &quot;Adwaita Mono&quot;;">Mark</s=
pan></div><div><span></span></div></body></html>

--=-sNpkJEXFOt/iebB/OTLT--
