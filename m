From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: GPU vs CPU page size fixes in
 amdgpu_vm_bo_split_mapping
Date: Fri, 22 Jun 2018 16:12:38 +0200
Message-ID: <a3a30887-bb0e-1d90-69ca-21fac8f35b62@daenzer.net>
References: <20180622091035.4119-1-michel@daenzer.net>
 <a2824504-f765-251c-5adb-dda69ecc9ca7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a2824504-f765-251c-5adb-dda69ecc9ca7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

T24gMjAxOC0wNi0yMiAxMjozNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMi4w
Ni4yMDE4IHVtIDExOjEwIHNjaHJpZWIgTWljaGVsIETDpG56ZXI6Cj4+IEZyb206IE1pY2hlbCBE
w6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+Pgo+PiBzdGFydCAvIGxhc3QgLyBtYXhf
ZW50cmllcyBhcmUgbnVtYmVycyBvZiBHUFUgcGFnZXMsIHBmbiAvIGNvdW50IGFyZQo+PiBudW1i
ZXJzIG9mIENQVSBwYWdlcy4gQ29udmVydCBiZXR3ZWVuIHRoZW0gYWNjb3JkaW5nbHkuCj4+Cj4+
IEZpeGVzIGJhZG5lc3Mgb24gc3lzdGVtcyB3aXRoID4gNEsgcGFnZSBzaXplLgo+Pgo+PiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiBCdWd6aWxsYTogaHR0cHM6Ly9idWdzLmZyZWVkZXNr
dG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA2MjU4Cj4+IFJlcG9ydGVkLWJ5OiBNYXR0IENvcmFs
bG8gPGZyZWVkZXNrdG9wQGJsdWVtYXR0Lm1lPgo+PiBUZXN0ZWQtYnk6IGZveGJhdEBydWluLm5l
dAo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNv
bT4KPiAKPiBOaWNlIHdvcmshCgpUaGFua3MuCgoKPiBKdXN0IG9uZSBjb21tZW50OiBDYW4gd2Ug
c29tZXdoZXJlIGFkZCBhIGRlZmluZSBmb3IKPiAiKFBBR0VfU0laRSAvIEFNREdQVV9HUFVfUEFH
RV9TSVpFKSI/Cj4gCj4gSUlSQyB0aGF0IHRlcm0gd2FzIHVzZWQgaW4gdGhlIEdBUlQgY29kZSBh
cyB3ZWxsIGFuZCBqdXN0IGFkZGluZyBpdAo+IHNvbWV3aGVyZSBjb3VsZCBtYWtlcyB0aGluZ3Mg
Y2xlYW5lciBpZiB5b3UgYXNrIG1lLgoKU3VyZSwgYnV0IHRoYXQgY2FuIGJlIGEgZm9sbG93LXVw
IHBhdGNoLCByaWdodD8KCkNhbiBJIGdldCB5b3VyIFItYiBmb3IgdGhpcyBvbmU/CgoKLS0gCkVh
cnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRw
Oi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAg
ICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
