From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
Subject: Re: [PATCH 1/6] drm/amdgpu/pm: handle fan properly when card is
 powered down
Date: Fri, 26 Jan 2018 00:05:35 +0100
Message-ID: <654cb0f671aeb2a6646909b0cfa85fc1@nuetzel-hh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-devel <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Rm9yIHRoZSBzZXJpZXM6CgpDT09MIHN0dWZmIQoKUlg1ODAgKFBvbGFyaXMyMCkgZHVyaW5nICdp
ZGxlJyAoc2luZ2xlIEhEIDE5MjB4MTA4MCk6CmFtZC1zdGFnaW5nLWRybS1uZXh0CgphbWRncHUt
cGNpLTAxMDAKQWRhcHRlcjogUENJIGFkYXB0ZXIKdmRkZ2Z4OiAgICAgICArMC43NSBWCmZhbjE6
ICAgICAgICAgOTA0IFJQTQp0ZW1wMTogICAgICAgICsyNS4wwrBDICAoY3JpdCA9ICs5NC4wwrBD
LCBoeXN0ID0gLTI3My4xwrBDKQpwb3dlcjE6ICAgICAgIDMyLjAwIFcKClRoYW5rIHlvdSB2ZXJ5
IG11Y2ggQWxleCBldCBhbC4hCgpEaWV0ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
