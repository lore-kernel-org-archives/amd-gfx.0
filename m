From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix VA hole handling on Vega10 v2
Date: Fri, 17 Nov 2017 17:09:40 +0100
Message-ID: <d5aafe10-1b90-ceeb-db50-99afb412eccb@daenzer.net>
References: <20171116102252.10173-1-christian.koenig@amd.com>
 <d995f9a6-f76a-aa7c-4b61-fe848bfb549a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d995f9a6-f76a-aa7c-4b61-fe848bfb549a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTcvMTEvMTcgMTE6MjggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gUGluZz8gTWlj
aGVsLCBBbGV4IGNhbiBzb21lYm9keSB0YWtlIGEgbG9vaz8KClBhdGNoIDIgaXMKClJldmlld2Vk
LWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCgpXaXRoIHBhdGNo
ZXMgMSAmIDMsIGl0J3Mgbm90IDEwMCUgY2xlYXIgdG8gbWUgd2hhdCB0aGUgaWRlYSBpcyBiZWhp
bmQKdGhlIGhhbmRsaW5nIG9mIHRoZSBob2xlIG9uIHRoZSBrZXJuZWwgYW5kIHVzZXJzcGFjZSBz
aWRlLiBNYXliZSB5b3UgY2FuCmFkZCBzb21lIGV4cGxhbmF0aW9uIGluIGNvZGUgY29tbWVudHMg
b3IgdGhlIGNvbW1pdCBsb2dzPwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJl
IGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Bl
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
