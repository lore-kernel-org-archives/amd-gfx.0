From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/1] drm/amdgpu: export gfx config double offchip LDS
 buffers (v3)
Date: Mon, 20 Feb 2017 15:58:12 +0000
Message-ID: <CACvgo52TOx9qFt=d_nrbDj=DDHnSi1abqsQG13Q4LZ5r12t8wg@mail.gmail.com>
References: <1487559054-30974-1-git-send-email-Jerry.Zhang@amd.com>
 <DM5PR12MB18181E995F962015A84AF955FF5E0@DM5PR12MB1818.namprd12.prod.outlook.com>
 <BN4PR12MB07879854436D0D552919A32BEE5E0@BN4PR12MB0787.namprd12.prod.outlook.com>
 <CACvgo50WQeRgdrCotSONnzE08DVapv=8K=LNzEeg8dDYe1qWUQ@mail.gmail.com>
 <41391F3D-9B21-4E3B-AC06-50ABDB919357@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <41391F3D-9B21-4E3B-AC06-50ABDB919357-5C7GfCeVMHo@public.gmane.org>
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
To: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAgRmVicnVhcnkgMjAxNyBhdCAxNToyMiwgTWFvLCBEYXZpZCA8RGF2aWQuTWFvQGFtZC5j
b20+IHdyb3RlOgo+IFRoYW5rcyBmb3IgdGhlIEluZm8sIGJ1dCBpdCBzZWVtcyB0aGUgUEFDS0FH
RV9WRVJTSU9OIGlzIG5vdCB0aGUgdmVyc2lvbiBpIGFtIGxvb2tpbmcgZm9yLgo+IElzIHRoZXJl
IGFueSB3YXlzIHRoYXQgbGliZHJtLnNvL2xpYmRybV9hbWRncHUuc28gY2FuIHByb3ZpZGUgaW4g
dGhlIHJ1bnRpbWUgdG8gaW5kaWNhdGUgdGhlIEFCSSBzdGF0ZSBiZXNpZGVzIHRoZSBTT19WRVJT
SU9OPwo+IEkgbWF5IHdhbnQgdG8gY29tcGlsZSB0aGUgZHJpdmVyIGFnYWluc3QgdGhlIGxhdGVz
dCBsaWJkcm0gYnV0IHN0aWxsIGhvcGUgaXQgY2FuIGNvLXdvcmsgd2l0aCBwcmV2aW91cyB2ZXJz
aW9uIGxpYmRybS9saWJkcm1fYW1kZ3B1Lgo+IElzIGl0IG5vdCBzdXBwb3J0ZWQ/Cj4KSWYgeW91
IHdhbnQgdG8gYnJlYWsgdGhlIEFCSSB5b3UgbXVzdCBidW1wIHRoZSBTT05BTUUgdmVyc2lvbi4g
Tm90CnRoYXQgYmFkIG9mIGlkZWEsIGJ1dCBzaG91bGQgeW91IF9leHBsaWNpdGx5XyBlbnN1cmUg
dGhhdCBzYXkgbm8gQVBJCmdldHMgcmVtb3ZlZC4KCkJlZm9yZSB5b3UgYXNrIC0gdGhlcmUncyBb
YXQgbGVhc3RdIHR3byBjb21wb25lbnRzIHdoaWNoIGxpbmsgYWdhaW5zdApsaWJkcm1fYW1kZ3B1
LnNvIGFuZCBoYXZlIHVucmVzb2x2ZWQvdW5zb2x2ZWQgc3ltYm9scy4gSWYgYW55IHN5bWJvbApn
ZXRzIHJlbW92ZWQgZXhpc3RpbmcsIHRoZXNlIHBhY2thZ2VzIHdpbGwgYnJlYWsuCgpUaGlzIGlz
IGhvdyB0aGluZ3MgYnJva2Ugd2l0aCBub3V2ZWF1IGFuZCB5b3UgZG9uJ3Qgd2FudCB0byByZXBl
YXQgdGhhdC4KClRsO0RyOyBJJ2Qgb3B0IGZvciBDaHJpc3RpYW4ncyBzdWdnZXN0aW9uIDstKQoK
UmVnYXJkcywKRW1pbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
