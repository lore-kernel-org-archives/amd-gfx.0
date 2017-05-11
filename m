From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Thu, 11 May 2017 11:32:50 +0900
Message-ID: <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM3PR1201MB10392013EC4407011C4F9B84F5EC0-BBcFnVpqZhVMmo+XJk11QmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMTEvMDUvMTcgMDY6MTAgQU0sIExpLCBTYW11ZWwgd3JvdGU6Cj4gQWxzbyBhdHRhY2ggYSBz
YW1wbGUgaWRzIGZpbGUgZm9yIHJlZmVyZW5jZS4gVGhlIG5hbWVzIGFyZSBmcm9tIG1hcmtldGlu
Zywgbm90Cj4gcmVsYXRlZCB0byBzb3VyY2UgY29kZSBhbmQgbm8gcmV2aWV3cyBuZWNlc3Nhcnkg
aGVyZTopCgpKdXN0IGJlY2F1c2UgaXQncyBub3Qgc291cmNlIGNvZGUgZG9lc24ndCBtZWFuIG5v
IHJldmlldyBpcyBuZWNlc3NhcnkuIDopCgoKPiBJdCBjYW4gYmUgcHV0IGluIGRpcmVjdG9yeSAv
dXNyL3NoYXJlL2xpYmRybS4KCldoYXQgaXMgdGhlIGNhbm9uaWNhbCBsb2NhdGlvbiB3aGVyZSBk
aXN0cm9zIG9yIHVzZXJzIGJ1aWxkaW5nIHVwc3RyZWFtCmxpYmRybSBjYW4gZ2V0IHRoaXMgZmls
ZSBmcm9tPyBUaGVyZSBuZWVkcyB0byBiZSBhIGdvb2Qgc29sdXRpb24gZm9yCnRoYXQgYmVmb3Jl
IHRoaXMgY2FuIGxhbmQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
