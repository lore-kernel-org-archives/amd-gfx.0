From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdkfd: CWSR and trap handler support
Date: Mon, 13 Nov 2017 11:44:44 -0500
Message-ID: <80d6b94b-6a27-ad4c-1459-667993cf281f@amd.com>
References: <1510194541-4919-1-git-send-email-Felix.Kuehling@amd.com>
 <043f9fb6-68fd-7a9d-65c2-b834f1535e65@amd.com>
 <CAFCwf12-V8TygUAwjVG6qJQncPq6r4_MoomxHCXd8wwnOCyu7w@mail.gmail.com>
 <DM5PR1201MB02351ACA783A0038DB827D8C92570@DM5PR1201MB0235.namprd12.prod.outlook.com>
 <CAFCwf10x+ygpv1cXkx3Bu0YrmYvVV3h2nnv+2nyF-1xAxLGMew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf10x+ygpv1cXkx3Bu0YrmYvVV3h2nnv+2nyF-1xAxLGMew-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0xMS0xMyAxMToxMiBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gb2ssIHRoYW5rcyBm
b3IgdGhlIGV4cGxhbmF0aW9uLgo+IEknbGwgd2FpdCBmb3IgeW91ciB2Mi4KSSB3YXMgb24gdmFj
YXRpb24gZm9yIGEgZmV3IGRheXMuIEknbGwgd29yayBvbiB2MiB0aGlzIHdlZWssIG9uY2UgSQpj
YXVnaHQgdXAgd2l0aCBteSBlbWFpbCBiYWNrbG9nLgoKUmVnYXJkcywKwqAgRmVsaXgKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
