From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: kernel BUG at drivers/gpu/drm//ttm/ttm_bo.c:196!
Date: Thu, 7 Feb 2019 10:58:02 +0100
Message-ID: <f4543d33-233d-b242-d3cf-f087a5dcd755@gmail.com>
References: <b1448d56-5dc4-d3f4-db04-e7993533240b@daenzer.net>
 <95cef707-4d19-cbd4-c913-523f4b22c89a@gmail.com>
 <b5a55494-356d-31a3-fe5a-491d337f6a66@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b5a55494-356d-31a3-fe5a-491d337f6a66-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDUuMDIuMTkgdW0gMTg6NDAgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDE5LTAy
LTA1IDQ6NDUgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gUG9zc2libGUsIGJ1dCB1
bmxpa2VseS4KPj4KPj4gVGhhdCBzb3VuZHMgbW9yZSBsaWtlIGEgcmVmZXJlbmNlIGNvdW50aW5n
IHByb2JsZW0gd2hlcmUgc29tZXRoaW5nIGlzCj4+IGtpbGxpbmcgdGhlIEJPIHdoaWxlIGl0IGlz
IHN0aWxsIG9uIHRoZSBMUlUuCj4gRldJVywgSSd2ZSBoaXQgdGhpcyB0d2ljZSBub3cgdG9kYXks
IHdoZXJlYXMgSSBkb24ndCByZW1lbWJlciBldmVyCj4gaGl0dGluZyBpdCBiZWZvcmUgKG5vdCAx
MDAlIHN1cmUgdGhvdWdoKS4KPgo+IEkgcmV2ZXJ0ZWQgdGhlIHJlbWFpbmluZyBodW5rIG9mIHRo
ZSAiY2xlYW51cCBzZXR0aW5nIGJ1bGtfbW92YWJsZSIKPiBjaGFuZ2UsIGFuZCBpdCBzdXJ2aXZl
ZCBhIHBpZ2xpdCBydW4uIENvdWxkIGp1c3QgYmUgbHVjaywgdGhvdWdoLi4uCgpEaWQgeW91IGhh
dmUgS0FTQU4gZW5hYmxlZD8KClRoZSBvbmx5IHBvc3NpYmxlIGV4cGxhbmF0aW9uIEkgaGF2ZSBp
cyB0aGF0IHdlIGVpdGhlciBzb21laG93IGNvcnJ1cHQgCnRoZSBjb3VudGVyIG9yIHRyeSB0byBm
cmVlIGEgQk8gdHdpY2UuIEJvdGggc2hvdWxkIGJlIHJlY29nbml6ZWQgCmltbWVkaWF0ZWx5IGJ5
IEtBU0FOLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
