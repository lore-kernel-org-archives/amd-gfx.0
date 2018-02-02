From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: fix mclk fixed in high when no display
 connected
Date: Fri, 2 Feb 2018 10:23:35 -0500
Message-ID: <CADnq5_Nu75QhsdVKEA4xSyRPsPnrZRniJzAU8PtR1MUyP1EmcQ@mail.gmail.com>
References: <1517547179-30756-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c06b932ce552f05643c4bda"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1517547179-30756-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--94eb2c06b932ce552f05643c4bda
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 1, 2018 at 11:52 PM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> Change-Id: I2d7663e164ff8eeafe0a4fed99e106b1d130a285
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index ba3c7d6..6700839 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2919,10 +2919,10 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
>                                     PHM_PlatformCaps_DisableMclkSwitchingForFrameLock);
>
>
> -       disable_mclk_switching = ((1 < info.display_count) ||
> -                                 disable_mclk_switching_for_frame_lock ||
> +       disable_mclk_switching = ((1 < info.display_count) &&
> +                                 (disable_mclk_switching_for_frame_lock ||
>                                   smu7_vblank_too_short(hwmgr, mode_info.vblank_time_us) ||
> -                                 (mode_info.refresh_rate > 120));
> +                                 (mode_info.refresh_rate > 120)));

I think this will break the logic to handle single display over 120 hz
and the vblank too short cases.  I think you want 1 <= display_count.
It might be better to make the logic more clear.  How about the
attached patch?

Alex

>
>         sclk = smu7_ps->performance_levels[0].engine_clock;
>         mclk = smu7_ps->performance_levels[0].memory_clock;
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c06b932ce552f05643c4bda
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amd-pp-fix-mclk-fixed-in-high-when-no-display-co.patch"
Content-Disposition: attachment;
	filename="0001-drm-amd-pp-fix-mclk-fixed-in-high-when-no-display-co.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd62xky70

RnJvbSBiYzgyNTA2MzIwZTU5NGIxYjQ2NTE1ZmYwOWMwODAxODdmM2QyNjU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMiBGZWIgMjAxOCAxMDoxOToxMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWQvcHA6IGZpeCBtY2xrIGZpeGVkIGluIGhpZ2ggd2hlbiBubyBkaXNwbGF5IGNvbm5l
Y3RlZAogKHYyKQoKQWxzbyBjbGVhbiB1cCB0aGUgbG9naWMgdG8gbWFrZSBpdCBjbGVhcmVyIGhv
dyBtY2xrIHN3aXRjaGluZwppcyBkZXRlcm1pbmVkLgoKdjI6IE1ha2UgdGhlIGxvZ2ljIGNsZWFy
ZXIsIGZpeCB0aGUgc2luZ2xlIGRpc3BsYXkgY2FzZS4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgfCAxNyArKysrKysrKysrKystLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmluZGV4IGM1OWNi
OTQ5OWUwNi4uYmM1NmU2ZjJmN2E5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bv
d2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvaHdtZ3Ivc211N19od21nci5jCkBAIC0yOTAzLDExICsyOTAzLDE4IEBAIHN0YXRpYyBp
bnQgc211N19hcHBseV9zdGF0ZV9hZGp1c3RfcnVsZXMoc3RydWN0IHBwX2h3bWdyICpod21nciwK
IAkJCQkgICAgaHdtZ3ItPnBsYXRmb3JtX2Rlc2NyaXB0b3IucGxhdGZvcm1DYXBzLAogCQkJCSAg
ICBQSE1fUGxhdGZvcm1DYXBzX0Rpc2FibGVNY2xrU3dpdGNoaW5nRm9yRnJhbWVMb2NrKTsKIAot
Ci0JZGlzYWJsZV9tY2xrX3N3aXRjaGluZyA9ICgoMSA8IGluZm8uZGlzcGxheV9jb3VudCkgfHwK
LQkJCQkgIGRpc2FibGVfbWNsa19zd2l0Y2hpbmdfZm9yX2ZyYW1lX2xvY2sgfHwKLQkJCQkgIHNt
dTdfdmJsYW5rX3Rvb19zaG9ydChod21nciwgbW9kZV9pbmZvLnZibGFua190aW1lX3VzKSB8fAot
CQkJCSAgKG1vZGVfaW5mby5yZWZyZXNoX3JhdGUgPiAxMjApKTsKKwlpZiAoaW5mby5kaXNwbGF5
X2NvdW50ID09IDApCisJCS8qIG5vIGRpc3BsYXlzLCBlbmFibGUgbWNsayBzd2l0Y2hpbmcgKi8K
KwkJZGlzYWJsZV9tY2xrX3N3aXRjaGluZyA9IGZhbHNlOworCWVsc2UgaWYgKGluZm8uZGlzcGxh
eV9jb3VudCA9PSAxKQorCQkvKiAxIGRpc3BsYXksIGVuYWJsZSBtY2xrIHN3aXRjaGluZyBpZiBw
b3NzaWJsZSAqLworCQlkaXNhYmxlX21jbGtfc3dpdGNoaW5nID0KKwkJCWRpc2FibGVfbWNsa19z
d2l0Y2hpbmdfZm9yX2ZyYW1lX2xvY2sgfHwKKwkJCXNtdTdfdmJsYW5rX3Rvb19zaG9ydChod21n
ciwgbW9kZV9pbmZvLnZibGFua190aW1lX3VzKSB8fAorCQkJKG1vZGVfaW5mby5yZWZyZXNoX3Jh
dGUgPiAxMjApOworCWVsc2UKKwkJLyogPjEgZGlzcGxheSwgZGlzYWJsZSBtY2xrIHN3aXRjaGlu
ZyAqLworCQlkaXNhYmxlX21jbGtfc3dpdGNoaW5nID0gdHJ1ZTsKIAogCXNjbGsgPSBzbXU3X3Bz
LT5wZXJmb3JtYW5jZV9sZXZlbHNbMF0uZW5naW5lX2Nsb2NrOwogCW1jbGsgPSBzbXU3X3BzLT5w
ZXJmb3JtYW5jZV9sZXZlbHNbMF0ubWVtb3J5X2Nsb2NrOwotLSAKMi4xMy42Cgo=
--94eb2c06b932ce552f05643c4bda
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--94eb2c06b932ce552f05643c4bda--
