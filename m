From: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: return error when sriov access requests
 get timeout
Date: Tue, 31 Oct 2017 07:48:41 +0000
Message-ID: <BY2PR1201MB09351EC6F91217A9403AB1BAEB5E0@BY2PR1201MB0935.namprd12.prod.outlook.com>
References: <1509433855-21354-1-git-send-email-Pixel.Ding@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1509433855-21354-1-git-send-email-Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Ding, Pixel" <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>

PkBAIC00NTAsNyArNDUwLDcgQEAgc3RhdGljIGludCB4Z3B1X3ZpX3NlbmRfYWNjZXNzX3JlcXVl
c3RzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiAJCQlwcl9lcnIoIkRvZXNuJ3QgZ2V0
IGFjayBmcm9tIHBmLCBjb250aW51ZVxuIik7DQoNCldoeSBkb24ndCByZXR1cm4gZXJyb3IgaW4g
dGhpcyBwbGFjZT8NCg0KID4JfQ0KID4NCj4tCXJldHVybiAwOw0KPisJcmV0dXJuIHI7DQogPn0N
CiANCiBzdGF0aWMgaW50IHhncHVfdmlfcmVxdWVzdF9yZXNldChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikNCi0tIA0KMi45LjUNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
