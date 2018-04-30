From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [REGRESSION] drm/amd/dc: Add dc display driver (v2)
Date: Mon, 30 Apr 2018 11:40:44 -0400
Message-ID: <497193e8-0be8-0353-ff09-7c7a35ac53f7@amd.com>
References: <fbb549e9-88a9-cc85-f8f3-e4bd0157b58c@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fbb549e9-88a9-cc85-f8f3-e4bd0157b58c-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Joseph Salisbury <joseph.salisbury-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "1761751-T8XWwAfLipRB/Vz2p19nDaxOck334EZe@public.gmane.org" <1761751-T8XWwAfLipRB/Vz2p19nDaxOck334EZe@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

UmVwbGllZCBvbiB0aGUgdGlja2V0LgoKSWYgdGhpcyBpcyBhYm91dCBub24tZnVuY3Rpb25pbmcg
TFZEUyBvciBWR0EgSSdtIGF3YXJlIG9mIGl0IGFuZCB0cnlpbmcgdG8gZmluZCB0aW1lIHRvIGZp
bmQgYSBnb29kIHNvbHV0aW9uLgoKSGFycnkKCk9uIDIwMTgtMDQtMzAgMTE6MTQgQU0sIEpvc2Vw
aCBTYWxpc2J1cnkgd3JvdGU6Cj4gSGkgSGFycnksCj4KPiBBIGtlcm5lbCBidWcgcmVwb3J0IHdh
cyBvcGVuZWQgYWdhaW5zdCBVYnVudHUgWzBdLsKgIEFmdGVyIGEga2VybmVsCj4gYmlzZWN0LCBp
dCB3YXMgZm91bmQgdGhlIGZvbGxvd2luZyBjb21taXQgaW50cm9kdWNlZCB0aGUgYnVnOgo+Cj4K
PiBjb21taXQgNDU2MjIzNmIzYmMwYTI4YWViNmVlOTNiMmQ4YTg0OWE0YzRlMWM3Ywo+IEF1dGhv
cjogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4gRGF0ZTrCoMKgIFR1
ZSBTZXAgMTIgMTU6NTg6MjAgMjAxNyAtMDQwMAo+Cj4gwqDCoMKgIGRybS9hbWQvZGM6IEFkZCBk
YyBkaXNwbGF5IGRyaXZlciAodjIpCj4KPgo+IFRoZSByZWdyZXNzaW9uIHdhcyBpbnRyb2R1Y2Vk
IGFzIG9mIHY0LjE1LXJjMSBhbmQgc3RpbGwgZXhpc3RzIGluCj4gY3VycmVudCBtYWlubGluZS7C
oCBUaGUgY29tbWl0IGRvZXMgbm90IG5lZWQgdG8gYmUgcmV2ZXJ0ZWQgdG8gcmVzb2x2ZQo+IHRo
ZSBidWcuwqAgRGlzYWJsaW5nIHRoZSBDT05GSUdfRFJNX0FNRF9EQ19QUkVfVkVHQSBvcHRpb24g
bWFrZXMgdGhlIGJ1Zwo+IGdvIGF3YXkuCj4gwqDCoMKgCj4gSSB3YXMgaG9waW5nIHRvIGdldCB5
b3VyIGZlZWRiYWNrLCBzaW5jZSB5b3UgYXJlIHRoZSBwYXRjaCBhdXRob3IuwqAgRG8KPiB5b3Ug
dGhpbmsgZ2F0aGVyaW5nIGFueSBhZGRpdGlvbmFsIGRhdGEgd2lsbCBoZWxwIGRpYWdub3NlIHRo
aXMgaXNzdWU/Cj4gwqDCoMKgCj4KPiBUaGFua3MsCj4KPiBKb2UKPgo+Cj4gWzBdIGh0dHA6Ly9w
YWQubHYvMTc2MTc1MQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
