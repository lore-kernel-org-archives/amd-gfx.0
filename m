From: Yrjan Skrimstad <yrjan@skrimstad.net>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay
 with non-blocking
Date: Sun, 16 Jun 2019 16:43:10 +0200
Message-ID: <20190616144309.GA8174@obi-wan>
References: <20190530000819.GA25416@obi-wan> <20190604202149.GA20116@obi-wan>
 <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBKdW4gMTMsIDIwMTkgYXQgMDk6NTc6MjRBTSAtMDQwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IFRoZSBwYXRjaCBpcyBmaW5lIGFuZCBJIGNhbiBhcHBseSBpdCAoSSBkb24ndCB0aGlu
ayB0aGVyZSBhcmUgYW55Cj4gcmVzdHJpY3Rpb25zIG9uIHNsZWVwaW5nIGluIHN5c2ZzKSwgYnV0
IHRoaXMgY29kZSBvbmx5IGdldHMgZXhlY3V0ZWQKPiB3aGVuIHlvdSBhY3R1YWxseSByZWFkIHRo
ZSBwb3dlciBzdGF0dXMgZnJvbSB0aGUgY2FyZCAoZS5nLiwgdmlhIHN5c2ZzCj4gb3IgZGVidWdm
cykuICBQcmVzdW1hYmx5IHlvdSBoYXZlIHNvbWV0aGluZyBpbiB1c2Vyc3BhY2UgcG9sbGluZyBv
bmUKPiBvZiB0aG9zZSBmaWxlcyBvbiBhIHJlZ3VsYXIgYmFzaXM/Cj4gCj4gQWxleAoKVGhhdCBp
cyBhbiBpbnRlcmVzdGluZyBvYnNlcnZhdGlvbiB0byBtZS4gSSBhbSBhY3R1YWxseSBydW5uaW5n
CmxtLXNlbnNvcnMsIGFsdGhvdWdoIG9ubHkgZXZlcnkgMTUgc2Vjb25kcy4gSSBzdXBwb3NlIHRo
YXQgdGhpcyBtaWdodApiZSB0aGUgcmVhc29uIHRoaXMgaGFwcGVucyB0byBtZS4KCi0gWXJqYW4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
