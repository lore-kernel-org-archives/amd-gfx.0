From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH]_drm/amdgpu:fix_amdgpu=5fs?=
 =?UTF-8?Q?a=5fbo=5fnew_error?=
Date: Thu, 9 Feb 2017 00:52:02 +0900
Message-ID: <99ba2b49-6409-0a47-1bc1-f873d69a58d8@daenzer.net>
References: <1486546917-1464-1-git-send-email-Monk.Liu@amd.com>
 <4ac7f30d-fde6-b1e3-e5de-fc518b180548@vodafone.de>
 <a2254528-29ca-44bb-8cb9-09fd428af241@daenzer.net>
 <DM5PR12MB161067C1383FC5829F4FCD8984420@DM5PR12MB1610.namprd12.prod.outlook.com>
 <c4776332-809a-da57-88a9-172b72743ede@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c4776332-809a-da57-88a9-172b72743ede-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDkvMDIvMTcgMTI6MzAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gVGhlIElCIHRl
c3QgbWFrZSB0aGUgZGVjaXNpb24gaWYgdGhlIGhhcmR3YXJlIGlzIHdvcmtpbmcgb3Igbm90Lgo+
IAo+IFNvIHRoZXkgc2hvdWxkIGJlIHRoZSBmaXJzdCBjb21tYW5kcyAoZXhjZXB0IGZvciB0aGUg
cmluZyB0ZXN0cykgd2Ugc2VuZAo+IHRvIHRoZSBoYXJkd2FyZS4KPiAKPiBXaGVuIHdlIGFsbG9j
YXRlIHRoZSBmYiBiZWZvcmUgdGhlIHRlc3Qgd2Ugc2VuZCB0aGUgY2xlYXIgY29tbWFuZCB0byB0
aGUKPiBoYXJkd2FyZSB3aXRob3V0IGtub3dpbmcgaWYgdGhlIGhhcmR3YXJlIHJlYWxseSB3b3Jr
cyBvciBub3QuCj4gCj4gTm90IGEgYmlnIGlzc3VlLCBidXQgSSB0aGluayB0aGUgb3JkZXIgbWFr
ZXMgbW9yZSBzZW5zZSB0aGF0IHdheS4KCkkganVzdCB3b25kZXIgaWYgaXQncyB3b3J0aCBhbGwg
dGhlIHRyb3VibGUsIGp1c3QgdG8gY2xlYXIgdGhlIGZiY29uCmJ1ZmZlclswXSwgaWYgdGhlIHJl
c3VsdCBpcyB0aGF0IHRoZSBjb25zb2xlIG91dHB1dCBpcyBkZWxheWVkLCBwb3NzaWJseQppbmRl
ZmluaXRlbHkuCgpbMF0gV2UgZG9uJ3QgaGF2ZSBhbnkgb3RoZXIgaGFyZHdhcmUgYWNjZWxlcmF0
aW9uIGZvciBmYmNvbiwgc28gaXRzIEJPCmlzIG9ubHkgYWNjZXNzZWQgYnkgdGhlIENQVSBhbmQg
ZGlzcGxheSBoYXJkd2FyZSBhZnRlciB0aGlzLCBhbmQgaGFzIHRvCmJlIHBpbm5lZCBpbiB0aGUg
Q1BVIHZpc2libGUgYXJlYSBvZiBWUkFNIGF0IGFsbCB0aW1lcyBhbnl3YXkuCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
