From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH][next] drm/amd/display: fix double assignment to msg_id
 field
Date: Wed, 27 Nov 2019 11:51:33 -0500
Message-ID: <9056b19a-f63c-8fc0-d2f7-6df3a20c95a7@amd.com>
References: <20191120172242.347072-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191120172242.347072-1-colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
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
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

T24gMjAxOS0xMS0yMCAxMjoyMiBwLm0uLCBDb2xpbiBLaW5nIHdyb3RlOgo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4gCj4gVGhlIG1zZ19pZCBmaWVs
ZCBpcyBiZWluZyBhc3NpZ25lZCB0d2ljZS4gRml4IHRoaXMgYnkgcmVwbGFjaW5nIHRoZSBzZWNv
bmQKPiBhc3NpZ25tZW50IHdpdGggYW4gYXNzaWdubWVudCB0byBtc2dfc2l6ZS4KPiAKPiBBZGRy
ZXNzZXMtQ292ZXJpdHk6ICgiVW51c2VkIHZhbHVlIikKPiBGaXhlczogMTFhMDA5NjVkMjYxICgi
ZHJtL2FtZC9kaXNwbGF5OiBBZGQgUFNQIGJsb2NrIHRvIHZlcmlmeSBIRENQMi4yIHN0ZXBzIikK
PiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29t
PgoKUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZD4KCkhhcnJ5Cgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNw
LmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9o
ZGNwL2hkY3BfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNw
L2hkY3BfcHNwLmMKPiBpbmRleCAyZGQ1ZmVlYzhlNmMuLjY3OTFjNTg0NGU0MyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNwLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNw
LmMKPiBAQCAtNDIsNyArNDIsNyBAQCBzdGF0aWMgdm9pZCBoZGNwMl9tZXNzYWdlX2luaXQoc3Ry
dWN0IG1vZF9oZGNwICpoZGNwLAo+ICAJaW4tPnByb2Nlc3MubXNnMl9kZXNjLm1zZ19pZCA9IFRB
X0hEQ1BfSERDUDJfTVNHX0lEX19OVUxMX01FU1NBR0U7Cj4gIAlpbi0+cHJvY2Vzcy5tc2cyX2Rl
c2MubXNnX3NpemUgPSAwOwo+ICAJaW4tPnByb2Nlc3MubXNnM19kZXNjLm1zZ19pZCA9IFRBX0hE
Q1BfSERDUDJfTVNHX0lEX19OVUxMX01FU1NBR0U7Cj4gLQlpbi0+cHJvY2Vzcy5tc2czX2Rlc2Mu
bXNnX2lkID0gMDsKPiArCWluLT5wcm9jZXNzLm1zZzNfZGVzYy5tc2dfc2l6ZSA9IDA7Cj4gIH0K
PiAgZW51bSBtb2RfaGRjcF9zdGF0dXMgbW9kX2hkY3BfcmVtb3ZlX2Rpc3BsYXlfdG9wb2xvZ3ko
c3RydWN0IG1vZF9oZGNwICpoZGNwKQo+ICB7Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
