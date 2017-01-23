From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Bring bo creation in line with radeon driver
Date: Mon, 23 Jan 2017 11:29:37 +0100
Message-ID: <3632c484-020b-d494-4373-04032d305385@vodafone.de>
References: <20170122191527.GA3125@tisys.org>
 <854d801c-cf4d-9ea7-a23c-f2d3399dd270@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <854d801c-cf4d-9ea7-a23c-f2d3399dd270-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Nils Holland <nholland-iI9p2NPcQ/rYtjvyW6yDsg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjMuMDEuMjAxNyB1bSAwMzo0NiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIzLzAx
LzE3IDA0OjE1IEFNLCBOaWxzIEhvbGxhbmQgd3JvdGU6Cj4+ICBGcm9tIGQ0NGFjMTE1N2ZkYjg2
ZTY3ODIyYjY1MzhhZTYxMTNjOGQ2MjA0MTIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCj4+IEZy
b206IE5pbHMgSG9sbGFuZCA8bmhvbGxhbmRAdGlzeXMub3JnPgo+PiBEYXRlOiBTdW4sIDIyIEph
biAyMDE3IDEzOjI0OjUyICswMTAwCj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogQnJp
bmcgYm8gY3JlYXRpb24gaW4gbGluZSB3aXRoIHJhZGVvbiBkcml2ZXIKPj4KPj4gQWRkIHRoZSBi
byBjcmVhdGlvbiBjaGFuZ2VzIHRoYXQgaGF2ZSBiZWVuIGRvbmUgdG8gdGhlIHJhZGVvbiBkcml2
ZXIgaW4KPj4gcmVjZW50IHRpbWVzLCBlLmcuIGRpc2FibGUgR1RUIFdDIG9uIDMyIGJpdCBiZWNh
dXNlIGl0IGlzIGJyb2tlbiB0aGVyZSwKPj4gYW5kIGFsc28gZGlzYWJsZSBpdCBnZW5lcmFsbHkg
KGFuZCBwcmludCBhIHdhcm5pbmcgbWVzc2FnZSkgd2hlbgo+PiBDT05GSUdfWDg2X1BBVCBpcyBu
b3Qgc2V0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaWxzIEhvbGxhbmQgPG5ob2xsYW5kQHRpc3lz
Lm9yZz4KPiBMb29rcyBncmVhdCwgdGhhbmtzIE5pbHMhCj4KPiBSZXZpZXdlZC1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBhcyB3ZWxsLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
