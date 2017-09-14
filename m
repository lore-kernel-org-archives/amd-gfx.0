From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Thu, 14 Sep 2017 12:33:42 +1000
Message-ID: <CAPM=9tway48fUhviS_qCQGYa5g5F452WaouiXUKyGhxqELn72g@mail.gmail.com>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <1505248934-1819-3-git-send-email-maraeo@gmail.com>
 <7413e296-b7f5-5963-b477-b04acfb4bb91@amd.com>
 <CAAxE2A7aR15Y9C2r_V_+6fTp-kEuFKwDApQRCnx_rxdsDOKtmw@mail.gmail.com>
 <MWHPR1201MB020689874960A24D32C4A39CB46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A5UKZTuseX1Sqggc-XRprnfG+eQSZqbiytRyge5KJrCUg@mail.gmail.com>
 <MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <8927d6b6-f87c-00d9-57af-fdf4fb6dfcb8@vodafone.de>
 <MWHPR1201MB0206CBA3C079C15A7EAC6117B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A72RAC61KOF10GTuged-pM4kpKGnnMJh-nmtF-xM4f9AQ@mail.gmail.com>
 <be64ba03-3aa9-6eaf-9267-c3ec51882c12@vodafone.de>
 <CAPM=9typSOcf3L5Y6acDChY6R5fKMQ44LdCvKp_YZbX7B1LWiw@mail.gmail.com>
 <8a800613-07ce-b417-8a1e-0db5a2e31758@amd.com>
 <5264b020-c850-2765-d0d7-dc49d96815cf@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5264b020-c850-2765-d0d7-dc49d96815cf@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhoucm1 <david1.zhou@amd.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

Pgo+IEJ1dCB0aGluayBhIGJpdCBtb3JlLCBpZiBub3QgYnkgZGVmYXVsdCwgdGhhdCBpc24ndCBt
ZWFuaW5nZnVsLCB3ZSBjYW4KPiBjb250aW51ZSB0byB1c2Ugc2VxX25vIGJhc2UgZmVuY2UgYW5k
IE1hcmVrJ3Mgc3luY2ZpbGUgZmQgYXBwcm9hY2guCj4KCkF0IGxlYXN0IGZvciByYWR2IEkndmUg
bm8gaW50ZXJlc3QgaW4gZXZlcnkgQ1MgaW9jdGwgcmV0dXJuaW5nIGFuIGZkCnRoYXQgSSBoYXZl
IHRvCmNsb3NlLgoKRGF2ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
