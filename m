From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Adjust the VM size based on system memory
 size v2
Date: Fri, 24 Aug 2018 21:09:47 +0200
Message-ID: <a3c22bc8-7022-4b67-1926-fb5d4722caaf@amd.com>
References: <1535063830-8078-1-git-send-email-Felix.Kuehling@amd.com>
 <2acc80ae-64a3-534c-c006-97d905b84933@gmail.com>
 <8e91ee0a-d4e1-80a5-a406-331e78b57a23@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8e91ee0a-d4e1-80a5-a406-331e78b57a23-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjQuMDguMjAxOCB1bSAyMDo1OSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IE9uIDIwMTgt
MDgtMjQgMDM6MzIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFRoZSByb3VuZHVwIHRv
IGEgcG93ZXIgb2YgdHdvIGhlcmUgaXMgbm90IDEwMCUgY29ycmVjdCwgYnV0IEkgZG9uJ3QKPj4g
dGhpbmsgaXQgd2lsbCBodXJ0IHVzIG11Y2guCj4+Cj4+IEZvciBub3cgdGhlIHBhdGNoIGlzIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnCj4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Lgo+IFRoYW5rcy4gRG8geW91IG1pbmQgZWxhYm9yYXRpbmcgb24gd2hhdCdzIG5vdCAxMDAlIGNv
cnJlY3QgaGVyZT8KCldlbGwgaXQncyBub3QgYSBwb3dlciBvZiB0d28gd2hhdCBnaXZlIG9wdGlt
YWwgcm9vdCBQRCBzaXplcy4KCklJUkMgdGhlIG9wdGltYWwgY29uZmlndXJhdGlvbiBmb3IgZGlm
ZmVyZW50IHZtIHNpemVzIGFyZToKMUdCOsKgwqDCoCA0ay80awoyR0I6wqDCoMKgIDhrLzRrIG9y
IDRrLzhrCjRHQjrCoMKgwqAgOGsvOGsKNkdCOsKgwqDCoCAxMksvOGsKOEdCOsKgwqDCoCAxNksv
OGsgb3IgOGsvMTZrCjEyR0I6wqDCoMKgIDEyay8xNmsKLi4uLgoKQXMgeW91IGNhbiBzZWUgNkdC
IGFuZCAxMkdCIGFyZSBzdGlsbCB1c2luZyBhbGwgdGhlIGFsbG9jYXRlZCBQRCwgYnV0IAphcmUg
bm90IHBvd2VyIG9mIHR3by4KCj4gTWF5YmUgZG8gdGhlIG1pbiguLi4sIG1heF9zaXplKSBhZnRl
ciByb3VuZHVwX3Bvd19vZl90d28/CgpXZSB3b3VsZCBuZWVkIHRvIGluY3JlYXNlIHRoZSB2bV9z
aXplIGJhc2VkIG9uIHRoZSBQRCBzaXplIGFmdGVyIApmaWd1cmluZyBvdXQgYWxsIHRoZSBwYXJh
bWV0ZXJzLgoKQnV0IHRoZSB3aW4gaXMgcHJvYmFibHkgbm90IHdvcnRoIHRoZSBlZmZvcnQuCgpS
ZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
