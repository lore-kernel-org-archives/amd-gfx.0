From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Wed, 13 Sep 2017 16:06:32 +0200
Message-ID: <CAAxE2A72RAC61KOF10GTuged-pM4kpKGnnMJh-nmtF-xM4f9AQ@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <1505248934-1819-3-git-send-email-maraeo@gmail.com>
 <7413e296-b7f5-5963-b477-b04acfb4bb91@amd.com>
 <CAAxE2A7aR15Y9C2r_V_+6fTp-kEuFKwDApQRCnx_rxdsDOKtmw@mail.gmail.com>
 <MWHPR1201MB020689874960A24D32C4A39CB46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A5UKZTuseX1Sqggc-XRprnfG+eQSZqbiytRyge5KJrCUg@mail.gmail.com>
 <MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <8927d6b6-f87c-00d9-57af-fdf4fb6dfcb8@vodafone.de>
 <MWHPR1201MB0206CBA3C079C15A7EAC6117B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <MWHPR1201MB0206CBA3C079C15A7EAC6117B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gV2VkLCBTZXAgMTMsIDIwMTcgYXQgMzo0NiBQTSwgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpCjxE
YXZpZDEuWmhvdUBhbWQuY29tPiB3cm90ZToKPiBGb3IgYW5kcm9pZCB1c2luZyBtZXNhIGluc3Rh
bmNlLCBlZ2wgZHJhdyB3aWxsIGRlcXVldWUgYW4gYW5kcm9pZCBidWZmZXIsCj4gYWZ0ZXIgZWds
IGRyYXcsIHRoZSBidWZmZXIgd2lsbCBiYWNrIHRvIGFuZHJvaWQgYnVmZmZlciBxdWV1ZSwgYnV0
IG5lZWQKPiBhcHBlbmQgYSBzeW5jZmlsZSBmZC4gSWYgZ2V0dGluZyBzeW5jZmlsZSBmZCBmb3Ig
ZXZlcnkgZWdsIGRyYXcgYWx3YXlzIG5lZWRzCj4gc2V2ZXJhbCBzeW5jb2JqIGlvY3RscywgdGhl
IGlvIG92ZXJoZWFkIGlzbid0IHNtYWxsLiBCdXQgaWYgd2UgZGlyZWN0bHkKPiByZXR1cm4gc3lu
Y2ZpbGUgd2hlbiBlZ2wgZHJhdyBDUywgIGlzbid0IGl0IGJldHRlcj8KCllvdSBoYXZlIGEgZ29v
ZCBwb2ludC4gSSdkIGJlIE9LIHdpdGggZWl0aGVyIGFwcHJvYWNoLCBvciBldmVuIHdpdGgKaGF2
aW5nIGJvdGggb3B0aW9ucyBpbiB0aGUga2VybmVsLgoKTWFyZWsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
