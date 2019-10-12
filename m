From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 02/19] drm/amdgpu: add supports_baco callback for soc15
 asics.
Date: Sat, 12 Oct 2019 13:45:27 +0200
Message-ID: <20191012114527.akspejxsm3hvrzil@wunner.de>
References: <20191011014536.10869-1-alexander.deucher@amd.com>
 <20191011014536.10869-3-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191011014536.10869-3-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMDg6NDU6MTlQTSAtMDUwMCwgQWxleCBEZXVjaGVyIHdy
b3RlOgo+IENoZWNrIHRoZSBCQUNPIGNhcGFiaWxpdGllcyBmcm9tIHRoZSBwb3dlcnBsYXkgdGFi
bGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgpbLi4uXQo+IEBAIC05OTcsNiArMTAyMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YW1kZ3B1X2FzaWNfZnVuY3MgdmVnYTIwX2FzaWNfZnVuY3MgPQo+ICAJLnJlYWRfYmlvc19mcm9t
X3JvbSA9ICZzb2MxNV9yZWFkX2Jpb3NfZnJvbV9yb20sCj4gIAkucmVhZF9yZWdpc3RlciA9ICZz
b2MxNV9yZWFkX3JlZ2lzdGVyLAo+ICAJLnJlc2V0ID0gJnNvYzE1X2FzaWNfcmVzZXQsCj4gKwku
cmVzZXRfbWV0aG9kID0gJnNvYzE1X2FzaWNfcmVzZXRfbWV0aG9kLAo+ICAJLnNldF92Z2Ffc3Rh
dGUgPSAmc29jMTVfdmdhX3NldF9zdGF0ZSwKPiAgCS5nZXRfeGNsayA9ICZzb2MxNV9nZXRfeGNs
aywKPiAgCS5zZXRfdXZkX2Nsb2NrcyA9ICZzb2MxNV9zZXRfdXZkX2Nsb2NrcywKPiBAQCAtMTAw
OSw3ICsxMDMzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfYXNpY19mdW5jcyB2ZWdh
MjBfYXNpY19mdW5jcyA9Cj4gIAkuZ2V0X3BjaWVfdXNhZ2UgPSAmdmVnYTIwX2dldF9wY2llX3Vz
YWdlLAo+ICAJLm5lZWRfcmVzZXRfb25faW5pdCA9ICZzb2MxNV9uZWVkX3Jlc2V0X29uX2luaXQs
Cj4gIAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50ID0gJnNvYzE1X2dldF9wY2llX3JlcGxheV9jb3Vu
dCwKPiAtCS5yZXNldF9tZXRob2QgPSAmc29jMTVfYXNpY19yZXNldF9tZXRob2QKClNlZW1pbmds
eSB1bnJlbGF0ZWQgY2hhbmdlIHdpdGhvdXQgZXhwbGFuYXRpb24uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
