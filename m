From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v6 1/2] drm/amd: validate user pitch alignment
Date: Tue, 8 Jan 2019 16:25:45 +0100
Message-ID: <ecadd993-9202-2212-9451-d1e2f126b4d8@daenzer.net>
References: <20181230010021.196990-1-yuzhao@google.com>
 <20190107225115.163992-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190107225115.163992-1-yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
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
To: Yu Zhao <yuzhao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Daniel Stone <daniels-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wMS0wNyAxMTo1MSBwLm0uLCBZdSBaaGFvIHdyb3RlOgo+IFVzZXJzcGFjZSBtYXkg
cmVxdWVzdCBwaXRjaCBhbGlnbm1lbnQgdGhhdCBpcyBub3Qgc3VwcG9ydGVkIGJ5IEdQVS4KPiBT
b21lIHJlcXVlc3RzIDMyLCBidXQgR1BVIGlnbm9yZXMgaXQgYW5kIHVzZXMgZGVmYXVsdCA2NCB3
aGVuIGNwcCBpcwo+IDQuIElmIEdFTSBvYmplY3QgaXMgYWxsb2NhdGVkIGJhc2VkIG9uIHRoZSBz
bWFsbGVyIGFsaWdubWVudCwgR1BVCj4gRE1BIHdpbGwgZ28gb3V0IG9mIGJvdW5kLgo+IAo+IENj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQuMisKPiBTaWduZWQtb2ZmLWJ5OiBZdSBaaGFv
IDx5dXpoYW9AZ29vZ2xlLmNvbT4KCkJvdGggcGF0Y2hlcyBhcHBsaWVkIHRvIGFtZC1zdGFnaW5n
LWRybS1uZXh0IChzaG91bGQgbGFuZCBpbiA1LjApLCB0aGFua3MhCgoKLS0gCkVhcnRobGluZyBN
aWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFt
ZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAg
IE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
