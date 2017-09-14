From: zhoucm1 <david1.zhou@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Thu, 14 Sep 2017 10:34:10 +0800
Message-ID: <2c390773-cf63-580f-7772-f1dfe6efae38@amd.com>
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
 <CAPM=9tway48fUhviS_qCQGYa5g5F452WaouiXUKyGhxqELn72g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAPM=9tway48fUhviS_qCQGYa5g5F452WaouiXUKyGhxqELn72g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

CgpPbiAyMDE35bm0MDnmnIgxNOaXpSAxMDozMywgRGF2ZSBBaXJsaWUgd3JvdGU6Cj4+IEJ1dCB0
aGluayBhIGJpdCBtb3JlLCBpZiBub3QgYnkgZGVmYXVsdCwgdGhhdCBpc24ndCBtZWFuaW5nZnVs
LCB3ZSBjYW4KPj4gY29udGludWUgdG8gdXNlIHNlcV9ubyBiYXNlIGZlbmNlIGFuZCBNYXJlaydz
IHN5bmNmaWxlIGZkIGFwcHJvYWNoLgo+Pgo+IEF0IGxlYXN0IGZvciByYWR2IEkndmUgbm8gaW50
ZXJlc3QgaW4gZXZlcnkgQ1MgaW9jdGwgcmV0dXJuaW5nIGFuIGZkCj4gdGhhdCBJIGhhdmUgdG8K
PiBjbG9zZS4KT0ssIGxldCdzIHBlbmQgaXQgbm93LiBJdCBkb2Vzbid0IG1hdHRlci4KClJlZ2Fy
ZHMsCkRhdmlkIFpob3UKPgo+IERhdmUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
