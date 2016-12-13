From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Tue, 13 Dec 2016 10:40:35 +0100
Message-ID: <20161213094035.GA10916@wunner.de>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>
 <CAPM=9tx+j9-3fZNY=peLjdsVqyLS6i3V-sV3XrnYsK2YuhWRBA@mail.gmail.com>
 <5a1f2762-f1e0-05f1-3c16-173cb1f46571@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <5a1f2762-f1e0-05f1-3c16-173cb1f46571@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Cheng, Tony" <tony.cheng@amd.com>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gTW9uLCBEZWMgMTIsIDIwMTYgYXQgMDk6NTI6MDhQTSAtMDUwMCwgQ2hlbmcsIFRvbnkgd3Jv
dGU6Cj4gV2l0aCBEQyB0aGUgZGlzcGxheSBoYXJkd2FyZSBwcm9ncmFtbWluZywgcmVzb3VyY2Ug
b3B0aW1pemF0aW9uLCBwb3dlcgo+IG1hbmFnZW1lbnQgYW5kIGludGVyYWN0aW9uIHdpdGggcmVz
dCBvZiBzeXN0ZW0gd2lsbCBiZSBmdWxseSB2YWxpZGF0ZWQKPiBhY3Jvc3MgbXVsdGlwbGUgT1Nz
LgoKRG8gSSB1bmRlcnN0YW5kIERBTDMuanBnIGNvcnJlY3RseSB0aGF0IHRoZSBtYWNPUyBkcml2
ZXIgYnVpbGRzIG9uIHRvcApvZiBEQUwgQ29yZT8gIEknbSBhc2tpbmcgYmVjYXVzZSB0aGUgZ3Jh
cGhpY3MgZHJpdmVycyBzaGlwcGluZyB3aXRoCm1hY09TIGFzIHdlbGwgYXMgb24gQXBwbGUncyBF
RkkgRmlybXdhcmUgVm9sdW1lIGFyZSBjbG9zZWQgc291cmNlLgoKSWYgdGhlIExpbnV4IGNvbW11
bml0eSBjb250cmlidXRlcyB0byBEQywgSSBndWVzcyB0aG9zZSBjb250cmlidXRpb25zCmNhbiBn
ZW5lcmFsbHkgYmUgYXNzdW1lZCB0byBiZSBHUEx2MiBsaWNlbnNlZC4gIFlldCBhIGZ1dHVyZSB2
ZXJzaW9uCm9mIHRoZSBtYWNPUyBkcml2ZXIgd291bGQgaW5jb3Jwb3JhdGUgdGhvc2UgY29udHJp
YnV0aW9ucyBpbiB0aGUgc2FtZQpiaW5hcnkgYXMgdGhlaXIgY2xvc2VkIHNvdXJjZSBPUy1zcGVj
aWZpYyBwb3J0aW9uLgoKSSBkb24ndCBxdWl0ZSBzZWUgaG93IHRoYXQgd291bGQgYmUgbGVnYWwg
YnV0IG1heWJlIEknbSBtaXNzaW5nCnNvbWV0aGluZy4KClByZXN1bWFibHkgdGhlIHNpdHVhdGlv
biB3aXRoIHRoZSBXaW5kb3dzIGRyaXZlciBpcyB0aGUgc2FtZS4KCkkgZ3Vlc3MgeW91IGNvdWxk
IG1haW50YWluIGEgc2VwYXJhdGUgYnJhbmNoIHNhbnMgY29tbXVuaXR5IGNvbnRyaWJ1dGlvbnMK
d2hpY2ggd291bGQgc2VydmUgYXMgYSBiYXNpcyBmb3IgY2xvc2VkIHNvdXJjZSBkcml2ZXJzLCBi
dXQgbm90IHN1cmUgaWYKdGhhdCBpcyBmZWFzaWJsZSBnaXZlbiB5b3VyIHJlc291cmNlIGNvbnN0
cmFpbnRzLgoKVGhhbmtzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVsCg==
