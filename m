From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 21/37] drm/amdkfd: Add topology support for dGPUs
Date: Mon, 11 Dec 2017 11:20:54 -0500
Message-ID: <5fe5041f-ff7a-da4b-df5f-87313dcd108a@amd.com>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-22-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf10_AOKQaQU31Mnn+2fO=awvO-DWaM7bTzO-khjk=yw+8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10_AOKQaQU31Mnn+2fO=awvO-DWaM7bTzO-khjk=yw+8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, Amber Lin <Amber.Lin-5C7GfCeVMHo@public.gmane.org>, Ben Goz <ben.goz-5C7GfCeVMHo@public.gmane.org>, Harish Kasiviswanathan <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>

T24gMjAxNy0xMi0xMSAwOTo0NiBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4+ICsKPj4gKyAgICAg
ICAvKiBGaWxsIGluIElPTElOSyBzdWJ0eXBlLgo+PiArICAgICAgICAqIFRPRE86IEZpbGwtaW4g
b3RoZXIgZmllbGRzIG9mIGlvbGluayBzdWJ0eXBlCj4+ICsgICAgICAgICovCj4+ICsgICAgICAg
c3ViX3R5cGVfaGRyLT5pb19pbnRlcmZhY2VfdHlwZSA9IENSQVRfSU9MSU5LX1RZUEVfUENJRVhQ
UkVTUzsKPj4gKyAgICAgICBzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fZnJvbSA9IHBy
b3hpbWl0eV9kb21haW47Cj4+ICsjaWZkZWYgQ09ORklHX05VTUEKPj4gKyAgICAgICBpZiAoa2Rl
di0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCj4gSGFkIHRvIGFkZCAjaW5j
bHVkZSA8bGludXgvcGNpLmg+IGF0IHRoZSBoZWFkIG9mIHRoZSBmaWxlIHRvIG1ha2UgdGhpcwo+
IGxpbmUgY29tcGlsZQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoYXQuCgpJIHJlbW92ZWQgc29tZSAi
dW5uZWNlc3NhcnkiIGluY2x1ZGVzIGFzIEkgd2FzIHNwbGl0dGluZyBhIGxhcmdlciBwYXRjaApp
bnRvIENQVSBhbmQgZEdQVSBzdXBwb3J0IGZvciB0b3BvbG9neS4gSSB0aGluayB0aGUga2VybmVs
IGNvbmZpZyBJIHVzZWQKZm9yIHRlc3RpbmcgdGhhdCBkaWRuJ3QgaGF2ZSBOVU1BIGVuYWJsZSBm
b3Igc29tZSByZWFzb24sIHNvIEkgZGlkbid0CmNhdGNoIHRoaXMuCgpSZWdhcmRzLArCoCBGZWxp
eAoKPgo+IE9kZWQKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
