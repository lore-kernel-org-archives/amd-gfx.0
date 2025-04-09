Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC450C369A6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 453FA10E9A9;
	Thu, 10 Apr 2025 13:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="C9J/FURb";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3032110E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 20:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1744229485; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=czm2qFoODJeqgZ3E/gpDxBZhlEAb3uHX5ar9Nm7sVVLI2j9SQksw4Z1ZIWXmSeXm3UOprN4q445YgnZ6yH7VfEd6ps8UbfaQGNYa4Z/U88GxWoeVaFW5Oj6IFFVfim6Q1rbxUCbqaefeawA5VuIMQ5qgPogM86JZYbWBhEOu6c4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1744229485;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=JW/C6cE8UWtIZDTwVFNBJYx6n8+qHLzNILNbLXN6luc=; 
 b=mc4SGXi5LU1Z26Zba0q98iww7WbjPqX5MYBEia1Rm5QghIyGGUb+EZCZJ4h+rvApGcjt5zRhfBFrsl9VfsvN/kdfiMMwb1PM67GVxxub5ie9A3E6GsGfdIAqu9Ig1WIrVLM8BWPXZEeaJVzZfWGBAZRV8e49qZbKWoumm02OAqE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744229484; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:MIME-Version:Message-Id:Reply-To:Cc;
 bh=JW/C6cE8UWtIZDTwVFNBJYx6n8+qHLzNILNbLXN6luc=;
 b=C9J/FURbMS0OxCByfxwN4ktObj33jjW8ivRD3U3x4vcFlj2S91d/ehCkIQzF+e7D
 nFWPfjGKe/V/id82+JCqdeQlpXuLZQcJmDLfdVmvfxMGaohBN0PSHpbtqtc6GJLz4CS
 sgPDodV1UNBnUeQOvKqXoD4w9hS+LTQrelXpQ1tk=
Received: by mx.zohomail.com with SMTPS id 1744229483458461.91819530798057;
 Wed, 9 Apr 2025 13:11:23 -0700 (PDT)
Message-ID: <775765f4d227753f1987735cd6574bc7823ac11b.camel@collabora.com>
Subject: Reminder: Seeking nominations for the 2025 X.Org Board of Directors
 Elections
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 09 Apr 2025 16:11:22 -0400
Content-Type: multipart/alternative; boundary="=-D+SBiO2g7VrgO50FwxbD"
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41app1) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:15 +0000
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

--=-D+SBiO2g7VrgO50FwxbD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

The nomination period is currently open for the upcoming election to
the X.Org Foundation Board of Directors. All X.Org Foundation members
are eligible for election to the board.

Nominations for the 2025 election are now open and will remain open
until 23:59 UTC on 16 April 2025.

The Board consists of directors elected from the membership. Each year,
an election is held to bring the total number of directors to eight.
The four members receiving the highest vote totals will serve as
directors for two year terms.

The directors who received two year terms starting in 2024 were Erik
Faye-Lund, Mark Filion, Neal Gompa and Simon Ser. They will continue to
serve until their term ends in 2026. Current directors whose term
expires in 2025 are Lyude Paul, Arkadiusz Hiler and Christopher
Michael. Additionally, a fourth board position is open following the
resignation of Simona Vetter in Q3 2024.

A director is expected to participate in the bi-weekly BBB meeting to
discuss current business and to attend the annual meeting of the X.Org
Foundation, which will be held at a location determined in advance by
the Board of Directors.

A member may nominate themselves or any other member they feel is
qualified. Nominations should be sent to the Election Committee
at=C2=A0elections@x.org.

Nominees shall be required to be current members of the X.Org
Foundation, and submit a personal statement of up to 200 words that
will be provided to prospective voters. The collected statements, along
with the statement of contribution to the X.Org Foundation in the
member's account page on=C2=A0http://members.x.org, will be made available
to all voters to help them make their voting decisions.

Nominations, membership applications or renewals and completed personal
statements must be received no later than 23:59 UTC on 16 April 2025.

The slate of candidates will be published 23 April 2025 and candidate
Q&A will begin then. The deadline for Xorg membership applications and
renewals is 28 April 2025.

Best,=C2=A0

Mark Filion, on behalf of the X.Org BoD

--=-D+SBiO2g7VrgO50FwxbD
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
</style></head><body><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px;=
 text-decoration: none; unicode-bidi: plaintext;">Hello!</div><div style=3D=
"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; fo=
nt-style: normal; font-variant-caps: normal; font-weight: 400; letter-spaci=
ng: normal; text-align: start; text-indent: 0px; text-transform: none; whit=
e-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0,=
 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; unicode-bi=
di: plaintext;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: r=
gb(0, 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps:=
 normal; font-weight: 400; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width:=
 0px; text-decoration: none; unicode-bidi: plaintext;">The nomination perio=
d is currently open for the upcoming election to the X.Org Foundation Board=
 of Directors. All X.Org Foundation members are eligible for election to th=
e board.</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0);=
 font-family: Cantarell; font-style: normal; font-variant-caps: normal; fon=
t-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tap-=
highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-d=
ecoration: none; unicode-bidi: plaintext;"><br></div><div style=3D"caret-co=
lor: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style:=
 normal; font-variant-caps: normal; font-weight: 400; letter-spacing: norma=
l; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4);=
 -webkit-text-stroke-width: 0px; text-decoration: none; unicode-bidi: plain=
text;">Nominations for the 2025 election are now open and will remain open =
until 23:59 UTC on 16 April 2025.</div><div style=3D"caret-color: rgb(0, 0,=
 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; font-=
variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; word-s=
pacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-=
stroke-width: 0px; text-decoration: none; unicode-bidi: plaintext;"><br></d=
iv><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-famil=
y: Cantarell; font-style: normal; font-variant-caps: normal; font-weight: 4=
00; letter-spacing: normal; text-align: start; text-indent: 0px; text-trans=
form: none; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-c=
olor: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: =
none; unicode-bidi: plaintext;">The Board consists of directors elected fro=
m the membership. Each year, an election is held to bring the total number =
of directors to eight. The four members receiving the highest vote totals w=
ill serve as directors for two year terms.</div><div style=3D"caret-color: =
rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style: norm=
al; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; te=
xt-align: start; text-indent: 0px; text-transform: none; white-space: norma=
l; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -web=
kit-text-stroke-width: 0px; text-decoration: none; unicode-bidi: plaintext;=
"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); f=
ont-family: Cantarell; font-style: normal; font-variant-caps: normal; font-=
weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; t=
ext-transform: none; white-space: normal; word-spacing: 0px; -webkit-tap-hi=
ghlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-dec=
oration: none; unicode-bidi: plaintext;">The directors who received two yea=
r terms starting in 2024 were Erik Faye-Lund, Mark Filion, Neal Gompa and S=
imon Ser. They will continue to serve until their term ends in 2026. Curren=
t directors whose term expires in 2025 are Lyude Paul, Arkadiusz Hiler and =
Christopher Michael. Additionally, a fourth board position is open followin=
g the resignation of Simona Vetter in Q3 2024.</div><div style=3D"caret-col=
or: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); =
-webkit-text-stroke-width: 0px; text-decoration: none; unicode-bidi: plaint=
ext;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0=
); font-family: Cantarell; font-style: normal; font-variant-caps: normal; f=
ont-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0p=
x; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-ta=
p-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text=
-decoration: none; unicode-bidi: plaintext;">A director is expected to part=
icipate in the bi-weekly BBB meeting to discuss current business and to att=
end the annual meeting of the X.Org Foundation, which will be held at a loc=
ation determined in advance by the Board of Directors.</div><div style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font=
-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0=
, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; unicode-bidi=
: plaintext;"><br></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb=
(0, 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: n=
ormal; font-weight: 400; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0=
px; text-decoration: none; unicode-bidi: plaintext;">A member may nominate =
themselves or any other member they feel is qualified. Nominations should b=
e sent to the Election Committee at<span class=3D"Apple-converted-space">&n=
bsp;</span><a href=3D"mailto:elections@x.org" title=3D"Click to mail electi=
ons@x.org" style=3D"color: rgb(46, 52, 54);">elections@x.org</a>.</div><div=
 style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cant=
arell; font-style: normal; font-variant-caps: normal; font-weight: 400; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: r=
gba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; u=
nicode-bidi: plaintext;"><br></div><div style=3D"caret-color: rgb(0, 0, 0);=
 color: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; font-vari=
ant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stro=
ke-width: 0px; text-decoration: none; unicode-bidi: plaintext;">Nominees sh=
all be required to be current members of the X.Org Foundation, and submit a=
 personal statement of up to 200 words that will be provided to prospective=
 voters. The collected statements, along with the statement of contribution=
 to the X.Org Foundation in the member's account page on<span class=3D"Appl=
e-converted-space">&nbsp;</span><a href=3D"http://members.x.org/" title=3D"=
Click to open http://members.x.org/" style=3D"color: rgb(46, 52, 54);">http=
://members.x.org</a>, will be made available to all voters to help them mak=
e their voting decisions.</div><div style=3D"caret-color: rgb(0, 0, 0); col=
or: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; font-variant-=
caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-w=
idth: 0px; text-decoration: none; unicode-bidi: plaintext;"><br></div><div =
style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Canta=
rell; font-style: normal; font-variant-caps: normal; font-weight: 400; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rg=
ba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; un=
icode-bidi: plaintext;">Nominations, membership applications or renewals an=
d completed personal statements must be received no later than 23:59 UTC on=
 16 April 2025.</div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px;=
 text-decoration: none; unicode-bidi: plaintext;"><br></div><div style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font=
-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0=
, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; unicode-bidi=
: plaintext;">The slate of candidates will be published 23 April 2025 and c=
andidate Q&amp;A will begin then. The deadline for Xorg membership applicat=
ions and renewals is 28 April 2025.</div><div style=3D"caret-color: rgb(0, =
0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font-style: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-tex=
t-stroke-width: 0px; text-decoration: none; unicode-bidi: plaintext;"><br><=
/div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-fam=
ily: Cantarell; font-style: normal; font-variant-caps: normal; font-weight:=
 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-tap-highlight=
-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px; text-decoration=
: none; unicode-bidi: plaintext;">Best,<span class=3D"Apple-converted-space=
">&nbsp;</span></div><div style=3D"caret-color: rgb(0, 0, 0); color: rgb(0,=
 0, 0); font-family: Cantarell; font-style: normal; font-variant-caps: norm=
al; font-weight: 400; letter-spacing: normal; text-align: start; text-inden=
t: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webk=
it-tap-highlight-color: rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px;=
 text-decoration: none; unicode-bidi: plaintext;"><br></div><div style=3D"c=
aret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: Cantarell; font=
-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-tap-highlight-color: rgba(0, 0, 0=
, 0.4); -webkit-text-stroke-width: 0px; text-decoration: none; unicode-bidi=
: plaintext;">Mark Filion, on behalf of the X.Org BoD</div><div><span></spa=
n></div></body></html>

--=-D+SBiO2g7VrgO50FwxbD--
