From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 4.20 034/117] drm/amdgpu: Correct
 get_crtc_scanoutpos behavior when vpos >= vtotal
Date: Wed, 23 Jan 2019 09:03:46 -0500
Message-ID: <20190123140346.GJ202535@sasha-vm>
References: <20190108192628.121270-1-sashal@kernel.org>
 <20190108192628.121270-34-sashal@kernel.org>
 <199e52c4-7e19-03c0-2d60-c638dda86bd4@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <199e52c4-7e19-03c0-2d60-c638dda86bd4-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBKYW4gMDksIDIwMTkgYXQgMTA6MjA6NDlBTSArMDEwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj5PbiAyMDE5LTAxLTA4IDg6MjUgcC5tLiwgU2FzaGEgTGV2aW4gd3JvdGU6Cj4+IEZy
b206IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4KPj4K
Pj4gWyBVcHN0cmVhbSBjb21taXQgNTIwZjA4ZGY0NWZiZTMwMGVkNjUwZGE3ODZhNzQwOTNkNjU4
YjdlMSBdCj4+Cj4+IFdoZW4gdmFyaWFibGUgcmVmcmVzaCByYXRlIGlzIGFjdGl2ZSBbLi4uXQo+
Cj5WYXJpYWJsZSByZWZyZXNoIHJhdGUgKEZyZWVTeW5jKSBzdXBwb3J0IGlzIG9ubHkgbGFuZGlu
ZyBpbiA1LjAsCj50aGVyZWZvcmUgdGhpcyBmaXggaXNuJ3QgbmVlZGVkIGluIG9sZGVyIGtlcm5l
bHMuCgpJJ2xsIGRyb3AgaXQsIHRoYW5rIHlvdS4KCi0tClRoYW5rcywKU2FzaGEKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
