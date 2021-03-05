Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B58C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F5664F73
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F5664F73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BBE6EAAF;
	Fri,  5 Mar 2021 15:32:38 +0000 (UTC)
X-Greylist: delayed 2007 seconds by postgrey-1.36 at gabe;
 Fri, 05 Mar 2021 11:50:24 UTC
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE37F6E1E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 11:50:24 +0000 (UTC)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DsQDP6krLz9txfD;
 Fri,  5 Mar 2021 12:16:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IaumhEy4LJKR; Fri,  5 Mar 2021 12:16:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DsQDP5NzTz9txf7;
 Fri,  5 Mar 2021 12:16:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0909B8B81F;
 Fri,  5 Mar 2021 12:16:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ahQmwKGZx4cI; Fri,  5 Mar 2021 12:16:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A0DF8B78B;
 Fri,  5 Mar 2021 12:16:54 +0100 (CET)
Subject: Re: Build regressions/improvements in v5.12-rc1
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20210301104316.2766484-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2103011342520.710098@ramsan.of.borg>
 <CADnq5_O-j8EWL+Eb8zK-7WqUuWKWETVWYRQNFdS_ymUSgo1jrg@mail.gmail.com>
 <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <09155bb0-4403-bcde-239f-eae4067953ca@csgroup.eu>
Date: Fri, 5 Mar 2021 12:16:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVFstnce-WKmj=4h3ZdtSThJNOLz_f1ervcZxE6hg=KsA@mail.gmail.com>
Content-Language: fr
X-Mailman-Approved-At: Fri, 05 Mar 2021 15:32:37 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpMZSAwMi8wMy8yMDIxIMOgIDIxOjAxLCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDDqWNyaXTCoDoK
PiBIaSBBbGV4LAo+IAo+IE9uIFR1ZSwgTWFyIDIsIDIwMjEgYXQgODozMCBQTSBBbGV4IERldWNo
ZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+IE9uIE1vbiwgTWFyIDEsIDIwMjEg
YXQgOToyMSBBTSBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPiB3cm90
ZToKPj4+IE9uIE1vbiwgMSBNYXIgMjAyMSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+Pj4+
IEJlbG93IGlzIHRoZSBsaXN0IG9mIGJ1aWxkIGVycm9yL3dhcm5pbmcgcmVncmVzc2lvbnMvaW1w
cm92ZW1lbnRzIGluCj4+Pj4gdjUuMTItcmMxWzFdIGNvbXBhcmVkIHRvIHY1LjExWzJdLgo+Pj4+
Cj4+Pj4gU3VtbWFyaXplZDoKPj4+PiAgIC0gYnVpbGQgZXJyb3JzOiArMi8tMAo+Pj4KPj4+PiBb
MV0gaHR0cDovL2tpc3NrYi5lbGxlcm1hbi5pZC5hdS9raXNza2IvYnJhbmNoL2xpbnVzL2hlYWQv
ZmUwN2JmZGEyZmI5Y2RlZjhhNGQ0MDA4YTQwOWJiMDJmMzVmMWJkOC8gKGFsbCAxOTIgY29uZmln
cykKPj4+PiBbMl0gaHR0cDovL2tpc3NrYi5lbGxlcm1hbi5pZC5hdS9raXNza2IvYnJhbmNoL2xp
bnVzL2hlYWQvZjQwZGRjZTg4NTkzNDgyOTE5NzYxZjc0OTEwZjQyZjRiODRjMDA0Yi8gKGFsbCAx
OTIgY29uZmlncykKPj4+Pgo+Pj4+Cj4+Pj4gKioqIEVSUk9SUyAqKioKPj4+Pgo+Pj4+IDIgZXJy
b3IgcmVncmVzc2lvbnM6Cj4+Pj4gICArIC9raXNza2Ivc3JjL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNuX2NhbGNzLmM6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnZGlzYWJsZV9rZXJuZWxfdnN4JyBbLVdlcnJvcj1pbXBs
aWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl06ICA9PiA2NzQ6Mgo+Pj4+ICAgKyAva2lzc2tiL3Ny
Yy9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2Rjbl9jYWxj
cy5jOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2VuYWJsZV9rZXJu
ZWxfdnN4JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl06ICA9PiA2Mzg6
Mgo+Pj4KPj4+IHBvd2VycGMtZ2NjNC45L3BwYzY0X2Jvb2szZV9hbGxtb2Rjb25maWcKPj4+Cj4+
PiBUaGlzIHdhcyBmaXhlZCBpbiB2NS4xMS1yYzEsIGJ1dCByZWFwcGVhcmVkIGluIHY1LjEyLXJj
MT8KPj4KPj4gRG8geW91IGtub3cgd2hhdCBmaXhlZCBpbiBmb3IgNS4xMT8gIEkgZ3Vlc3MgZm9y
IFBQQzY0IHdlIGRlcGVuZCBvbiBDT05GSUdfVlNYPwo+IAo+IExvb2tpbmcgYXQgdGhlIGtpc3Nr
YiBidWlsZCBsb2dzIGZvciB2NS4xMSosIGl0IHNlZW1zIGNvbXBpbGF0aW9uIG5ldmVyCj4gZ290
IHRvIGRyaXZlcnMvZ3B1L2RybS8gZHVlIHRvIGludGVybmFsIGNvbXBpbGVyIGVycm9ycyB0aGF0
IHdlcmVuJ3QgY2F1Z2h0Cj4gYnkgbXkgc2NyaXB0cy4gIFNvIHRoZSBlcnJvcnMgbGlzdGVkIGFi
b3ZlIHdlcmUgbm90IHJlYWxseSBmaXhlZC4KPiAKCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBw
cm9ibGVtIGhhcyBiZWVuIHRoZXJlIGZvciBhbnkgY29uZmlnIHdpdGhvdXQgQ09ORklHX1ZTWCBm
cm9tIHRoZSBiZWdpbm5pbmcgCmllIHNpbmNlIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eHBwYy9s
aW51eC9jb21taXQvMTZhOWRlYTExMGE2CgpUaGUgZm9sbG93aW5nIHNob3VsZCBmaXggaXQgdXA6
CgpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3N3aXRjaF90by5oIGIvYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCmluZGV4IGZkYWI5MzQyODM3Mi4uOWQx
ZmJkOGJlMWM3IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3dpdGNoX3Rv
LmgKKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCkBAIC03MSw2ICs3
MSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZGlzYWJsZV9rZXJuZWxfdnN4KHZvaWQpCiAgewog
IAltc3JfY2hlY2tfYW5kX2NsZWFyKE1TUl9GUHxNU1JfVkVDfE1TUl9WU1gpOwogIH0KKyNlbHNl
CitzdGF0aWMgaW5saW5lIHZvaWQgZW5hYmxlX2tlcm5lbF92c3godm9pZCkKK3sKKwlCVUlMRF9C
VUcoKTsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGRpc2FibGVfa2VybmVsX3ZzeCh2b2lkKQor
eworCUJVSUxEX0JVRygpOworfQogICNlbmRpZgoKICAjaWZkZWYgQ09ORklHX1NQRQotLS0KQ2hy
aXN0b3BoZQpDaHJpc3RvcGhlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
