From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable huge page handling in the VM v4
Date: Mon, 17 Jul 2017 17:30:07 -0400
Message-ID: <c2b1e857-67c1-fd51-adf4-c4f84ea37368@amd.com>
References: <1500325342-26253-1-git-send-email-deathsimple@vodafone.de>
 <1500325342-26253-2-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500325342-26253-2-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTctMDctMTcgMDU6MDIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gKwlpZiAocC0+
YWRldi0+YXNpY190eXBlIDwgQ0hJUF9WRUdBMTAgfHwKPiArCSAgICBucHRlcyAhPSBBTURHUFVf
Vk1fUFRFX0NPVU5UKHAtPmFkZXYpIHx8Cj4gKwkgICAgcC0+ZnVuYyAhPSBhbWRncHVfdm1fZG9f
c2V0X3B0ZXMgfHwKPiArCSAgICAhKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkpIHsKCkJlY2F1
c2Ugb2YgdGhpcyBjb25kaXRpb24sIEkgdGhpbmsgdGhpcyBzdGlsbCB3b24ndCB3b3JrIGNvcnJl
Y3RseSBmb3IKY3B1IHBhZ2UgdGFibGUgdXBkYXRlcy4gcC0+ZnVuYyB3aWxsIGJlIGFtZGdwdV92
bV9jcHVfc2V0X3B0ZXMuCgpSZWdhcmRzLAogIEZlbGl4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
