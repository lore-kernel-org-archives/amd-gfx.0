From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:fix race condition
Date: Tue, 11 Apr 2017 10:50:33 +0900
Message-ID: <e6a269b0-a7cb-cf7f-fd90-ab8ea0c5ebc1@daenzer.net>
References: <1491819882-19868-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491819882-19868-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTAvMDQvMTcgMDc6MjQgUE0sIE1vbmsgTGl1IHdyb3RlOgo+ICAKPiAgc3RydWN0IGRybV9h
bWRncHVfd2FpdF9jc19pbiB7Cj4gLQkvKiogQ29tbWFuZCBzdWJtaXNzaW9uIGhhbmRsZSAqLwo+
ICsJLyogQ29tbWFuZCBzdWJtaXNzaW9uIGhhbmRsZQoKQW55IHBhcnRpY3VsYXIgcmVhc29uIGZv
ciBkcm9wcGluZyB0aGUgLyoqIGNvbW1lbnQgb3BlbmluZz8KCgo+ICsgICAgICAgICAqIGhhbmRs
ZSBlcXVhbHMgMCBtZWFucyBub25lIHRvIHdhaXQgZm9yCgpUaGlzIGxpbmUgYW5kIHRoZSBmb2xs
b3dpbmcgbGluZXMgYXJlIGluZGVudGVkIGluY29ycmVjdGx5ICg5IHNwYWNlcywKc2hvdWxkIGJl
IDEgdGFiICsgMSBzcGFjZSkuCgoKPiArICAgICAgICAgKiBoYW5kbGUgZXF1YWwgfjB1bGwgbWVh
bmFzIHdhaXQgZm9yIHRoZSBsYXRlc3Qgc2VxdWVuY2UgbnVtYmVyCj4gKyAgICAgICAgICovCgpU
eXBvOiAibWVhbmFzIiAodmkobSkgYWNjaWRlbnQ/IDopCgoKLS0gCkVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20K
TGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2Eg
YW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
