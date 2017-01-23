From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Bring bo creation in line with radeon driver
Date: Mon, 23 Jan 2017 11:46:41 +0900
Message-ID: <854d801c-cf4d-9ea7-a23c-f2d3399dd270@daenzer.net>
References: <20170122191527.GA3125@tisys.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170122191527.GA3125-iI9p2NPcQ/rYtjvyW6yDsg@public.gmane.org>
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
To: Nils Holland <nholland-iI9p2NPcQ/rYtjvyW6yDsg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjMvMDEvMTcgMDQ6MTUgQU0sIE5pbHMgSG9sbGFuZCB3cm90ZToKPiBGcm9tIGQ0NGFjMTE1
N2ZkYjg2ZTY3ODIyYjY1MzhhZTYxMTNjOGQ2MjA0MTIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
Cj4gRnJvbTogTmlscyBIb2xsYW5kIDxuaG9sbGFuZEB0aXN5cy5vcmc+Cj4gRGF0ZTogU3VuLCAy
MiBKYW4gMjAxNyAxMzoyNDo1MiArMDEwMAo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTog
QnJpbmcgYm8gY3JlYXRpb24gaW4gbGluZSB3aXRoIHJhZGVvbiBkcml2ZXIKPiAKPiBBZGQgdGhl
IGJvIGNyZWF0aW9uIGNoYW5nZXMgdGhhdCBoYXZlIGJlZW4gZG9uZSB0byB0aGUgcmFkZW9uIGRy
aXZlciBpbgo+IHJlY2VudCB0aW1lcywgZS5nLiBkaXNhYmxlIEdUVCBXQyBvbiAzMiBiaXQgYmVj
YXVzZSBpdCBpcyBicm9rZW4gdGhlcmUsCj4gYW5kIGFsc28gZGlzYWJsZSBpdCBnZW5lcmFsbHkg
KGFuZCBwcmludCBhIHdhcm5pbmcgbWVzc2FnZSkgd2hlbgo+IENPTkZJR19YODZfUEFUIGlzIG5v
dCBzZXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmlscyBIb2xsYW5kIDxuaG9sbGFuZEB0aXN5cy5v
cmc+CgpMb29rcyBncmVhdCwgdGhhbmtzIE5pbHMhCgpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56
ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnpl
ciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
