From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu:Always save uvd vcpu_bo in VM Mode
Date: Tue, 6 Mar 2018 15:21:05 -0500
Message-ID: <21096155-8b38-db52-062f-63c95c72190a@amd.com>
References: <1520367246-8734-1-git-send-email-James.Zhu@amd.com>
 <1520367246-8734-2-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520367246-8734-2-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-GB
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
To: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

U2VyaWVzIGFyZToKClJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+CgoKT24g
MDMvMDYvMjAxOCAwMzoxNCBQTSwgSmFtZXMgWmh1IHdyb3RlOgo+IFdoZW4gVVZEIGlzIGluIFZN
IG1vZGUsIHRoZXJlIGlzIG5vdCB1dmQgaGFuZGxlIGV4Y2hhbmdlZCwKPiB1dmQuaGFuZGxlcyBh
cmUgYWx3YXlzIDAuIFNvIHZjcHVfYm8gYWx3YXlzIG5lZWQgc2F2ZSwKPiBPdGhlcndpc2UgYW1k
Z3B1IGRyaXZlciB3aWxsIGZhaWwgZHVyaW5nIHN1c3BlbmQvcmVzdW1lLgo+Cj4gQnVnemlsbGE6
IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEwNTAyMQo+IFNp
Z25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCAzICsrLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IGluZGV4IDlkMDM3Y2IuLjYxYTMxZTUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gQEAgLTMwMyw3ICszMDMsOCBA
QCBpbnQgYW1kZ3B1X3V2ZF9zdXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAg
CQlpZiAoYXRvbWljX3JlYWQoJmFkZXYtPnV2ZC5oYW5kbGVzW2ldKSkKPiAgIAkJCWJyZWFrOwo+
ICAgCj4gLQlpZiAoaSA9PSBhZGV2LT51dmQubWF4X2hhbmRsZXMpCj4gKwkvKiBvbmx5IHZhbGlk
IGZvciBwaHlzaWNhbCBtb2RlICovCj4gKwlpZiAoaSA9PSBhZGV2LT51dmQubWF4X2hhbmRsZXMg
JiYgYWRldi0+YXNpY190eXBlIDwgQ0hJUF9QT0xBUklTMTApCj4gICAJCXJldHVybiAwOwo+ICAg
Cj4gICAJc2l6ZSA9IGFtZGdwdV9ib19zaXplKGFkZXYtPnV2ZC52Y3B1X2JvKTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
