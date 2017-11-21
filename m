From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move UVD/VCE and VCN structure out from union
Date: Tue, 21 Nov 2017 12:51:56 -0500
Message-ID: <40bac634-f15b-599a-2643-898ecfd9da73@amd.com>
References: <20171121142804.4047-1-leo.liu@amd.com>
 <8e1d3d87-c2f6-9892-4646-810ce9e9acfa@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8e1d3d87-c2f6-9892-4646-810ce9e9acfa-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-GB
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAxMS8yMS8yMDE3IDEyOjE3IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE3
LTExLTIxIDAzOjI4IFBNLCBMZW8gTGl1IHdyb3RlOgo+PiBXaXRoIHRoZSBlbmFibGVtZW50IG9m
IFZDTiBEZWMgYW5kIEVuYyBmcm9tIHVzZXIgc3BhY2UsIFVzZXIgc3BhY2UgcXVlcmllcwo+PiBr
ZXJuZWwgZm9yIHRoZSBJUCBpbmZvcm1hdGlvbiwgaWYgSFcgaGFzIFVWRC9WQ0UsIHRoZSBpbmZv
IGNvbWVzIGZyb20gdGhlc2UKPj4gSVAgYmxvY2tzLCBidXQgdGhpcyBjb3VsZCBlbmQgdXAgbWlz
LWludGVycHJldCBmb3IgVkNOIHdoZW4gdGhleSBhcmUgaW4gdGhlCj4+IHVuaW9uLCB0aGVyIG90
aGVyIHdheSBzYW1lIHdoZW4gSFcgd2l0aCBWQ04gYmxvY2suCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KPiBQbGVhc2UgYWRkOgo+Cj4gRml4ZXM6IDk1ZDA5
MDZmODUwNiAoImRybS9hbWRncHU6IGFkZCBpbml0aWFsIHZjbiBzdXBwb3J0IGFuZCBkZWNvZGUK
PiAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RzIikKPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwo+IFJldmlld2VkLWFuZC1UZXN0ZWQtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFl
bnplckBhbWQuY29tPgpUaGFua3MgZm9yIHRoZSBjb21tZW50LgpTb3JyeSB0aGF0IEkgaGF2ZSBh
bHJlYWR5IHB1c2hlZCBpdCB0byBpbnRlcm5hbGx5IGJyYW5jaCwgc2luY2UgbXkgClBvbGFyaXMx
MCBmYWlscyB0byBsaWdodCB1cCB3aXRoIG5ld2VyIE1lc2EuCgpMZW8KCgoKPgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
