From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: KASAN use-after-free report during piglit run
Date: Mon, 30 Oct 2017 15:54:23 +0100
Message-ID: <967212f2-5558-f8ee-6f6a-660c1879cb10@daenzer.net>
References: <e9df6a9b-19bc-4b2f-eeb2-a06ebb2f22c2@daenzer.net>
 <bb31e238-502c-eda7-5bcb-302ef6c04c15@gmail.com>
 <9d301254-6ce8-f8e0-ea3f-dc73f0440d08@daenzer.net>
 <77e5ed00-bc39-4faa-c189-c27191ed4d72@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <77e5ed00-bc39-4faa-c189-c27191ed4d72-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMzAvMTAvMTcgMDM6NTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gV2VsbCBJJ3Zl
IGZvdW5kIGEgbWlub3IgYnVnIGluIFRUTSAoZmFsc2UgcG9zaXRpdmUgd2FybmluZyksIGJ1dCB3
YXMKPiBuZXZlciBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIGlzc3VlLgoKSSd2ZSBiZWVuIHJlcHJv
ZHVjaW5nIGl0IGZhaXJseSByZWd1bGFybHkgc2luY2UgSSByZXBvcnRlZCBpdC4KCgo+IFdoYXQg
aGFyZHdhcmUgZ2VuZXJhdGlvbiBkaWQgeW91IHVzZSBmb3IgdGVzdGluZz8KClRvbmdhLgoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
