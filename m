From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Adjust the VM size based on system memory
 size v2
Date: Fri, 24 Aug 2018 14:59:43 -0400
Message-ID: <8e91ee0a-d4e1-80a5-a406-331e78b57a23@amd.com>
References: <1535063830-8078-1-git-send-email-Felix.Kuehling@amd.com>
 <2acc80ae-64a3-534c-c006-97d905b84933@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2acc80ae-64a3-534c-c006-97d905b84933-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wOC0yNCAwMzozMiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBUaGUgcm91
bmR1cCB0byBhIHBvd2VyIG9mIHR3byBoZXJlIGlzIG5vdCAxMDAlIGNvcnJlY3QsIGJ1dCBJIGRv
bid0Cj4gdGhpbmsgaXQgd2lsbCBodXJ0IHVzIG11Y2guCj4KPiBGb3Igbm93IHRoZSBwYXRjaCBp
cyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZwo+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+LiAKVGhhbmtzLiBEbyB5b3UgbWluZCBlbGFib3JhdGluZyBvbiB3aGF0J3Mgbm90IDEwMCUg
Y29ycmVjdCBoZXJlPwoKTWF5YmUgZG8gdGhlIG1pbiguLi4sIG1heF9zaXplKSBhZnRlciByb3Vu
ZHVwX3Bvd19vZl90d28/CgpSZWdhcmRzLArCoCBGZWxpeApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
