From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/13] mmu_notifier kill invalidate_page callback
Date: Thu, 31 Aug 2017 19:19:19 -0400
Message-ID: <9a76dd3e-e266-c77e-721a-379092d714f1@amd.com>
References: <20170829235447.10050-1-jglisse@redhat.com>
 <f46585ee-7a89-1d68-5698-b6de76152cde@amd.com>
 <20170831135953.GA9227@redhat.com>
 <4a58e441-5430-3b9d-a5e8-7b88b46f82cf@amd.com>
 <20170831190021.GG9227@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170831190021.GG9227-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: intel-gfx <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0wOC0zMSAwMzowMCBQTSwgSmVyb21lIEdsaXNzZSB3cm90ZToKPiBJIHdhcyBub3Qg
c2F5aW5nIHlvdSBzaG91bGQgbm90IHVzZSBtbXVfbm90aWZpZXIuIEZvciBhY2hpZXZpbmcgQiB5
b3UgbmVlZAo+IG1tdV9ub3RpZmllci4gTm90ZSB0aGF0IGlmIHlvdSBkbyBsaWtlIE9EUC9LVk0g
dGhlbiB5b3UgZG8gbm90IG5lZWQgdG8KPiBwaW4gcGFnZS4KSSB3b3VsZCBsaWtlIHRoYXQuIEkn
dmUgdGhvdWdodCBhYm91dCBpdCBiZWZvcmUuIFRoZSBvbmUgcHJvYmxlbSBJCmNvdWxkbid0IGZp
Z3VyZSBvdXQgaXMsIHdoZXJlIHRvIHNldCB0aGUgYWNjZXNzZWQgYW5kIGRpcnR5IGJpdHMgZm9y
IHRoZQpwYWdlcy4gTm93IHdlIGRvIGl0IHdoZW4gd2UgdW5waW4uIElmIHdlIGRvbid0IHBpbiB0
aGUgcGFnZXMgaW4gdGhlCmZpcnN0IHBsYWNlLCB3ZSBkb24ndCBoYXZlIGEgZ29vZCBwbGFjZSBm
b3IgdGhpcy4KCk91ciBoYXJkd2FyZSBkb2Vzbid0IGdpdmUgdXMgbm90aWZpY2F0aW9ucyBvciBh
Y2Nlc3NlZC9kaXJ0eSBiaXRzLCBzbyB3ZQpoYXZlIHRvIGFzc3VtZSB0aGUgd29yc3QgY2FzZSB0
aGF0IHRoZSBwYWdlcyBhcmUgY29udGludW91c2x5CmFjY2Vzc2VkL2RpcnR5LgoKSSdkIGFwcHJl
Y2lhdGUgYW55IGFkdmljZSBob3cgdG8gaGFuZGxlIHRoYXQuIChTb3JyeSwgSSByZWFsaXplIHRo
aXMgaXMKZ29pbmcgYSBiaXQgb2ZmIHRvcGljLikgQSBwb2ludGVyIHRvIGEgZG9jdW1lbnQgb3Ig
c291cmNlIGNvZGUgd291bGQgYmUKZ3JlYXQuIDopCgpUaGFua3MsCiAgRmVsaXgKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
