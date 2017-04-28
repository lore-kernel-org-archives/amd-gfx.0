From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: Refactor flip into prepare submit and
 submit. (v2)"
Date: Fri, 28 Apr 2017 17:48:55 +0900
Message-ID: <36fdc234-42e9-5e94-8d6a-886ff5ad5ea3@daenzer.net>
References: <20170427081838.2424-1-michel@daenzer.net>
 <4e89bf8d-1620-e0e8-a331-9e2d53341635@vodafone.de>
 <64d1457a-8edb-b4bd-8b22-c8cad1bc53d9@daenzer.net>
 <a9e60838-eee6-f420-7c66-210158f72262@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a9e60838-eee6-f420-7c66-210158f72262-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjgvMDQvMTcgMDU6MjMgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjguMDQu
MjAxNyB1bSAwODo1OSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAyNy8wNC8xNyAwNzow
NCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDI3LjA0LjIwMTcgdW0gMTA6MTgg
c2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVs
LmRhZW56ZXJAYW1kLmNvbT4KPj4+Pgo+Pj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgY2IzNDFhMzE5
ZjdlNjZmODc5ZDY5YWY5MjljM2RhZGZjMWE4ZjMxZS4KPj4+Pgo+Pj4+IFRoZSBwdXJwb3NlIG9m
IHRoZSByZWZhY3RvciB3YXMgZm9yIGFtZGdwdV9jcnRjX3ByZXBhcmUvc3VibWl0X2ZsaXAgdG8K
Pj4+PiBiZSB1c2VkIGJ5IHRoZSBEQyBjb2RlLCBidXQgdGhhdCdzIG5vIGxvbmdlciB0aGUgY2Fz
ZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnpl
ckBhbWQuY29tPgo+PiBbLi4uXQo+Pgo+Pj4+ICtwZmxpcF9jbGVhbnVwOgo+Pj4+ICsgICAgaWYg
KHVubGlrZWx5KGFtZGdwdV9ib19yZXNlcnZlKG5ld19hYm8sIGZhbHNlKSAhPSAwKSkgewo+Pj4g
V2VsbCBoZXJlIHdlIGV4cGxpY2l0bHkgc2hvdWxkbid0IHVzZSBhbiBpbnRlcnJ1cHRpYmxlIHdh
aXQsIG90aGVyd2lzZQo+Pj4gd2Ugd291bGQga2VlcCB0aGUgQk8gcGlubmVkLgo+PiBNYWtlcyBz
ZW5zZSwgYnV0IHRoaXMgcGF0Y2gganVzdCByZXZlcnRzIGFub3RoZXIgY29tbWl0IGFuZCBtb3Zl
cyB0aGlzCj4+IGNvZGUgdW5jaGFuZ2VkLgoKQWN0dWFsbHksIGFmdGVyIHJlYmFzaW5nIHRvIGN1
cnJlbnQgYW1kLXN0YWdpbmctNC45LCBpdCBhbHJlYWR5IGxvb2tzCmxpa2UgeW91IHN1Z2dlc3Rl
ZC4gQ2FuIEkgZ2V0IHlvdXIgUmV2aWV3ZWQtYnkgZm9yIHRoYXQ/CgoKPj4gSSdsbCBzZW5kIGEg
Zm9sbG93LXVwIHBhdGNoIHdoaWNoIGZpeGVzIHRoaXMgKHBvc3NpYmx5IGFsc28gaW4gb3RoZXIK
Pj4gZXJyb3IgcGF0aHMpLgo+IAo+IFNvdW5kcyBnb29kLCBhbmQgZmVlbCBmcmVlIHRvIENDIG1l
IGFzIHdlbGwuCgpEb25lLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVu
dGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
