From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/12] drm/amdgpu/sriov:return -ENODEV if gpu reseted
Date: Tue, 10 Oct 2017 09:57:31 +0200
Message-ID: <36f5b680-c881-3b4f-0784-3cd624064004@gmail.com>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-10-git-send-email-Monk.Liu@amd.com>
 <6e81d8b0-267a-1ea8-b228-93286fc6a954@gmail.com>
 <BLUPR12MB0449531313F50BE080F7746D84740@BLUPR12MB0449.namprd12.prod.outlook.com>
 <71b411c8-21a6-fe9b-ed33-7928571a88da@gmail.com>
 <BLUPR12MB04492B28DF57EACE2149562D84750@BLUPR12MB0449.namprd12.prod.outlook.com>
 <85c67ae9-bfe2-390a-79d0-6e5872b9be62@amd.com>
 <0c91bb14-a874-9ee6-8756-2a31eb41d5b2@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0c91bb14-a874-9ee6-8756-2a31eb41d5b2-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMTAuMTAuMjAxNyB1bSAwOTo0NyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDEwLzEw
LzE3IDA4OjU4IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBcyBOaWNvbGFpIGV4cGxh
aW5lZCB0aGF0IGFwcHJvYWNoIHNpbXBseSB3b24ndCB3b3JrLgo+Pgo+PiBUaGUgZmQgaXMgdXNl
ZCBieSBtb3JlIHRoYW4ganVzdCB0aGUgY2xvc2VkIHNvdXJjZSBWdWxrYW4gZHJpdmVyIGFuZCBJ
Cj4+IHRoaW5rIGV2ZW4gYnkgc29tZSBjb21wb25lbnRzIG5vdCBkZXZlbG9wZWQgYnkgQU1EIChj
b21tb24gWCBjb2RlPwo+PiBNaWNoZWwgcGxlYXNlIGNvbW1lbnQgYXMgd2VsbCkuCj4gVGhlIG9u
bHkgdGhpbmcgdGhhdCBjb21lcyB0byBtaW5kIHBvc3NpYmx5IG1hdGNoaW5nIHlvdXIgZGVzY3Jp
cHRpb24gaXMKPiB0aGUgZ2VuZXJpYyBtb2Rlc2V0dGluZyBYb3JnIGRyaXZlciwgYnV0IHRoYXQg
b25seSBjYWxscyBLTVMgQVBJIGlvY3Rscy4KPiBDb21tYW5kIHN1Ym1pc3Npb24gYW5kIG1lbW9y
eSBtYW5hZ2VtZW50IGlvY3RscyBzaG91bGQgb25seSBiZSBjYWxsZWQgYnkKPiBoYXJkd2FyZSBz
cGVjaWZpYyB1c2Vyc3BhY2UgY29kZS4KClllYWgsIHRoYXQgd2FzIGluIG15IG1pbmQgYXMgd2Vs
bC4KCkJ1dCBkb2VzIHRoYXQgdXNlIHRoZSBzYW1lIGZkIGFzIHRoZSBHTCBkcml2ZXIgdXNlZCBm
b3IgR2xhbW9yPwoKSWYgeWVzIHdlIGNhbid0IGp1c3QgY2FsbCBjbG9zZSgpIG9uIHRoYXQgZmQu
CgpDaHJpc3RpYW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
