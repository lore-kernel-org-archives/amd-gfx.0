From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: remove ttm trace and add iova debugfs (v2)
Date: Mon, 18 Sep 2017 23:53:05 +0000
Message-ID: <DM5PR1201MB0074EAF81AFAFF1A779611B5F7630@DM5PR1201MB0074.namprd12.prod.outlook.com>
References: <20170918173350.9543-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170918173350.9543-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

U2hvdWxkIGFkZCBJIHdhcyBhYmxlIHRvIHJlYWQvd3JpdGUgc3lzdGVtIG1lbW9yeSBtYXBwZWQg
YnkgYW1kZ3B1IHdpdGggdGhlc2UgcGF0Y2hlcyBpbiBwbGFjZSBvbiBteSBwb2xhcmlzMTAgZGV2
aWNlICh3aXRoIGlvbW11IGVuYWJsZWQgb2YgY291cnNlKS4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4gb24gYmVoYWxmIG9mIFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNA
YW1kLmNvbT4KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTcgMTM6MzMKVG86IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnClN1YmplY3Q6IHJlbW92ZSB0dG0gdHJhY2UgYW5kIGFkZCBpb3ZhIGRlYnVnZnMgKHYyKQoK
SW4gdGhpcyByZXNwaW4gSSBhZGQgc29tZSBjaGFuZ2VzIHBlciBmZWVkYmFjayBhbmQgbWFrZSB0
aGUgaW92YQplbnRyeSBoYXZlIHByb3BlciByZWFkL3dyaXRlIG1ldGhvZHMgd2hpY2ggYWNjZXNz
IHBhZ2VzIG1hcHBlZApieSBhbWRncHUuICBTbyB0aGVyZSBpcyBubyBuZWVkIGZvciAvZGV2L21l
bSBvciAvZGV2L2ZtZW0gYW55bW9yZQp3aGVuIHJlYWRpbmcgc3lzdGVtIG1lbW9yeS4KClBhdGNo
ZXMgMy80IGFyZSB1bmNoYW5nZWQgYW5kIHJlbW92ZSB0aGUgVFRNIHRyYWNlIGZyb20gYW1kZ3B1
CmFuZCBmcm9tIFRUTSBpdHNlbGYuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
