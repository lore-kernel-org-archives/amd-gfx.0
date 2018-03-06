From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 6 Mar 2018 19:15:55 +0100
Message-ID: <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <3f0a85f6-ac67-cd8c-716e-1c1655d40226@gmail.com>
 <c23ddc4b-c785-be3b-8321-416bb8417b6d@amd.com>
 <CADnq5_OAnM2p2NHnOAduCd+yomFXKqKhrag+JaayZD1Ri9z_2Q@mail.gmail.com>
 <BY1PR12MB05044ACBE8424866B3CCA243F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cd4659cb-f030-4938-af44-2fa1389ccdfb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMy0wNiAwNzowMiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNi4w
My4yMDE4IHVtIDE4OjUxIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IE9uIDIwMTgtMDMtMDYg
MDY6NDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAwNi4wMy4yMDE4IHVtIDE4
OjIyIHNjaHJpZWIgTGksIFNhbXVlbDoKPj4+Pj4gYWRkaXRpb24gdG8gdGhhdCBJIGFncmVlIHdp
dGggTWljaGVsIHRoYXQgdGhlIG1vZHVsZSBwYXJhbWV0ZXIgaXMKPj4+Pj4gb3ZlcmtpbGwuCj4+
Pj4gVGhhdCBJIGFscmVhZHkgZXhwbGFpbmVkLiBDdXJyZW50bHkgU0cgZGlzcGxheSBmZWF0dXJl
IG5lZWRzIHRvCj4+Pj4gcHJvdmlkZSBvcHRpb25zIGZvciBhbGwga2luZHMgb2YgdXNlIGNhc2Vz
LiBBbGwgYW1kIGRyaXZlcnMgc28gZmFyCj4+Pj4gcHJvdmlkZXMgb3B0aW9ucywgYW5kIHRoZSBk
ZWZhdWx0IGNvbmZpZ3VyYXRpb24gaXMgYWN0dWFsbHkgdG8KPj4+PiBhbGxvY2F0ZSBldmVyeXRo
aW5nIGZyb20gR1RUIHdoZW4gcG9zc2libGUuCj4+PiBUaGF0IGlzbid0IGpvYiBvZiB0aGUga2Vy
bmVsIHRvIGhhdmUgdGhpcyBwYXJhbWV0ZXIuIFNheWluZyB0aGF0IHdlCj4+PiBzaG91bGQgcHJv
YmFibHkgYWRkIGEgRERYIGFuZC9vciBlbnZpcm9ubWVudCBvcHRpb24gdG8gY29udHJvbCB0aGF0
Lgo+PiBXaHkgd291bGQgd2UgbmVlZCB0aGF0PyBJdCdzIHRoZSBrZXJuZWwgZHJpdmVyJ3Mgam9i
IHRvIGhhbmRsZSB0aGlzIGFzCj4+IG5lZWRlZC4KPiAKPiBCdWZmZXIgcGxhY2VtZW50IGlzIHNw
ZWNpZmllZCBieSB0aGUgRERYL01lc2EsIHdoZW4gd2Ugb3ZlcnJpZGUgdGhhdCBpbgo+IHRoZSBr
ZXJuZWwgd2UganVzdCBmb3JjZSB1bm5lY2Vzc2FyeSBidWZmZXIgbW92ZXMuCgpVc2Vyc3BhY2Ug
anVzdCBuZWVkcyBhIHdheSB0byBrbm93IHdoaWNoIGRvbWFpbnMgY2FuL3Nob3VsZCBiZSB1c2Vk
IGZvcgpzY2Fub3V0IGJ1ZmZlcnMsIGUuZy4gdmlhIGFuIGluZm8gaW9jdGwuCgoKLS0gCkVhcnRo
bGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8v
d3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
