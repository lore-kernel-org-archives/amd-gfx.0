From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 05/15] drm/amd/display: Fix gamma colour corruption for 10
 bit surfaces
Date: Wed, 1 Mar 2017 10:01:08 -0500
Message-ID: <5b7a6fe3-9ef1-145d-dc09-e238b68be3fc@amd.com>
References: <20170301002620.24595-1-harry.wentland@amd.com>
 <20170301002620.24595-6-harry.wentland@amd.com>
 <440e5b55-ec15-a939-1626-f546208e37df@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <440e5b55-ec15-a939-1626-f546208e37df-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wMi0yOCAwODoxNyBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMDEvMDMv
MTcgMDk6MjYgQU0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+PiBGcm9tOiBKb3JkYW4gTGF6YXJl
IDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+Cj4+Cj4+IEdhbW1hIExVVCBzaG91bGRuJ3QgYmUgdXNl
ZCBmb3IgMTAtYml0IGFuZCBhYm92ZS4gU2hvdWxkIGluc3RlYWQgYmUKPj4gdXNpbmcgcHJlc2Nh
bGUgYW5kIGJ5cGFzc2luZyBpbnB1dCBnYW1tYS4KPj4KPj4gQ2hhbmdlLUlkOiBJNTVjMDhjNzQ2
YmIxZTFhYjE3MzllNDcxNjJkZGYwNmRiMTJmZTg3Mwo+PiBTaWduZWQtb2ZmLWJ5OiBKb3JkYW4g
TGF6YXJlIDxKb3JkYW4uTGF6YXJlQGFtZC5jb20+Cj4+IEFja2VkLWJ5OiBIYXJyeSBXZW50bGFu
ZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRv
bnkuQ2hlbmdAYW1kLmNvbT4KPj4gLS0tCj4+ICAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2Rj
ZTExMF9od19zZXF1ZW5jZXIuYyAgICB8IDE1ICsrKystCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlODAvTWFrZWZpbGUgICAgICB8ICAzICstCj4+ICAuLi4vZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9pcHBfZ2FtbWEuYyB8IDcxIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPgo+IFRoZSByZW1vdmFsIG9mIGRjZTgwX2lwcF9nYW1tYS5jIGFuZCBjb3JyZXNw
b25kaW5nIE1ha2VmaWxlIGNoYW5nZSBsb29rcwo+IHVucmVsYXRlZCBhbmQgc2hvdWxkIGJlIGEg
c2VwYXJhdGUgY2hhbmdlLgo+Cj4KClRoZSBjaGFuZ2UgaXMgcmVtb3ZpbmcgZGNlODBfaXBwX2dh
bW1hLmMgYW5kIGhhcyB0byByZW1vdmUgaXQgZnJvbSAKTWFrZWZpbGUgYXMgd2VsbCwgdW5sZXNz
IHRoZXJlJ3Mgc29tZXRoaW5nIEknbSBub3Qgc2VlaW5nLgoKSGFycnkKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
