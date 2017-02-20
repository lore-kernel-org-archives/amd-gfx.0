From: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 1/1] drm/amdgpu: export gfx config double offchip LDS
 buffers (v3)
Date: Mon, 20 Feb 2017 15:22:28 +0000
Message-ID: <41391F3D-9B21-4E3B-AC06-50ABDB919357@amd.com>
References: <1487559054-30974-1-git-send-email-Jerry.Zhang@amd.com>
 <DM5PR12MB18181E995F962015A84AF955FF5E0@DM5PR12MB1818.namprd12.prod.outlook.com>
 <BN4PR12MB07879854436D0D552919A32BEE5E0@BN4PR12MB0787.namprd12.prod.outlook.com>
 <CACvgo50WQeRgdrCotSONnzE08DVapv=8K=LNzEeg8dDYe1qWUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo50WQeRgdrCotSONnzE08DVapv=8K=LNzEeg8dDYe1qWUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <77D6EE6E1EC5214B9DE4DDDE1B8168D0-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

VGhhbmtzIGZvciB0aGUgSW5mbywgYnV0IGl0IHNlZW1zIHRoZSBQQUNLQUdFX1ZFUlNJT04gaXMg
bm90IHRoZSB2ZXJzaW9uIGkgYW0gbG9va2luZyBmb3IuCklzIHRoZXJlIGFueSB3YXlzIHRoYXQg
bGliZHJtLnNvL2xpYmRybV9hbWRncHUuc28gY2FuIHByb3ZpZGUgaW4gdGhlIHJ1bnRpbWUgdG8g
aW5kaWNhdGUgdGhlIEFCSSBzdGF0ZSBiZXNpZGVzIHRoZSBTT19WRVJTSU9OPwpJIG1heSB3YW50
IHRvIGNvbXBpbGUgdGhlIGRyaXZlciBhZ2FpbnN0IHRoZSBsYXRlc3QgbGliZHJtIGJ1dCBzdGls
bCBob3BlIGl0IGNhbiBjby13b3JrIHdpdGggcHJldmlvdXMgdmVyc2lvbiBsaWJkcm0vbGliZHJt
X2FtZGdwdS4gCklzIGl0IG5vdCBzdXBwb3J0ZWQ/CgpCZXN0IFJlZ2FyZHMsCkRhdmlkCj4gT24g
MjAgRmViIDIwMTcsIGF0IDg6NDUgUE0sIEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21h
aWwuY29tPiB3cm90ZToKPiAKPiBPbiAyMCBGZWJydWFyeSAyMDE3IGF0IDA5OjIwLCBNYW8sIERh
dmlkIDxEYXZpZC5NYW9AYW1kLmNvbT4gd3JvdGU6Cj4+IEhpIEplcnJ5ICYgQ2hyaXN0aWFuLAo+
PiBSZWdhcmRpbmcgdG8gdGhlIHZlcnNpb24gY29udHJvbCwgd2hhdCBpcyB0aGUgcnVsZSBvZiBi
dW1waW5nIHRoZSBQQUNLQUdFX1ZFUlNJT04gb2YgbGliZHJtPwo+PiBXZSBtYXkgbmVlZCBzb21l
dGhpbmcsIGxpa2UgdGhlIHNpemUgb2YgZ3B1X2luZm8gc3RydWN0dXJlIG9yIHRoZSBzb21ldGhp
bmcgbGlrZSBQQUNLQUdFIFZFUlNJT04gb2YgdGhlIHJ1bm5pbmcgbGliZHJtX2FtZGdwdS5zbywg
dG8gZW5zdXJlIHRoYXQgd2UgZGlkIG5vdCBicmVhY2ggdGhlIEFCSS4KPj4gCj4gUGxlYXNlIHNl
ZSB0aGUgUkVMRUFTSU5HIChhbmQgaW5jbHVkZS9kcm0vUkVBRE1FKSBkb2N1bWVudHMgaW4gbGli
ZHJtLgo+IAo+IFRoYW5rcwo+IEVtaWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
