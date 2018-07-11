From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Allow to create BO lists in CS ioctl.
Date: Wed, 11 Jul 2018 14:53:23 -0400
Message-ID: <df2c5155-6704-514d-e5f8-d3bb18a486bd@amd.com>
References: <1531320677-24655-1-git-send-email-andrey.grodzovsky@amd.com>
 <0c347c2e-c664-9c91-f2eb-b5699d0f8925@gmail.com>
 <6f71bc32-b5b9-aee5-57ea-6682cf33c544@amd.com>
 <fbce5cc9-3fc4-6a85-6679-cb0ad24d7f04@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fbce5cc9-3fc4-6a85-6679-cb0ad24d7f04-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Marek.Olsak-5C7GfCeVMHo@public.gmane.org

VGhpcyB3YXMgdG8gYXZvaWQgZXh0cmEgY29kZSBpbiBhbWRncHVfY3NfcGFyc2VyX2JvcyB3aGVu
IAphbWRncHVfYm9fbGlzdF9nZXQgaXMgY2FsbGVkLiBCdXQgSSBzZWUgeW91ciBhcmd1bWVudCBh
Ym91dCByYW5kb20gaWQgCmd1ZXNzIChwcmFjdGljYWxseSB1bnJlYWxpc3RpYyB0byBoYXBwZW4g
YnV0IHN0aWxsIGEgdmFsaWQgYXJndW1lbnQpLiBJIAp3aWxsIGRvIHNvbWUgbWlub3IgYWx0ZXJh
dGlvbnMgdG8gYXZvaWQgdGhpcyBhbmQgcmVzcGluIHRoZSBwYXRjaC4KCkFuZHJleQoKCk9uIDA3
LzExLzIwMTggMTE6NDIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2h5IGlzIHRoZSBi
b19saXN0IG9uIHRoZSBpZHIgaW4gdGhlIGZpcnN0IHBsYWNlPwo+Cj4gVGhhdCBzb3VuZHMgbGlr
ZSBpdCBpcyB1bm5lY2Vzc2FyeSBhbmQgbWF5YmUgZXZlbiBxdWl0ZSBkYW5nZXJvdXMgd2hlbiAK
PiBzb21lYm9keSBndWVzc2VzIHRoZSB0ZW1wb3JhcnkgYWxsb2NhdGVkIGlkIGFuZCBtZXNzZXMg
aXQgZnJvbSBhbm90aGVyIAo+IENQVSBhdCB0aGUgc2FtZSB0aW1lIHdoaWxlIHRoZSBDUyBJT0NU
TCBpcyBwcm9jZXNzaW5nIHRoaW5ncy4KPgo+IENocmlzdGlhbi4gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
