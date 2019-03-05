From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ENGINE_CNTL register to vcn10 headers
Date: Tue, 5 Mar 2019 10:17:47 -0500
Message-ID: <CAAzXoRLtZG_A4GgscVRo5aGL11i1PqUTrdTtOGyYvNjSgYCpLQ@mail.gmail.com>
References: <20190304155924.9436-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1486490871=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190304155924.9436-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1486490871==
Content-Type: multipart/alternative; boundary="000000000000d7439105835a60b9"

--000000000000d7439105835a60b9
Content-Type: text/plain; charset="UTF-8"

Hi,

Alex can I get an RB on this :-)

Thanks,
Tom

On Mon, Mar 4, 2019 at 10:59 AM StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h  | 2 ++
>  drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
> b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
> index 442ca7c471a5..6109f5ad25ad 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
> @@ -141,6 +141,8 @@
>  #define mmUVD_GPCOM_VCPU_DATA0_BASE_IDX
>                               1
>  #define mmUVD_GPCOM_VCPU_DATA1
>                              0x03c5
>  #define mmUVD_GPCOM_VCPU_DATA1_BASE_IDX
>                               1
> +#define mmUVD_ENGINE_CNTL
>                               0x03c6
> +#define mmUVD_ENGINE_CNTL_BASE_IDX
>                              1
>  #define mmUVD_UDEC_DBW_UV_ADDR_CONFIG
>                               0x03d2
>  #define mmUVD_UDEC_DBW_UV_ADDR_CONFIG_BASE_IDX
>                              1
>  #define mmUVD_UDEC_ADDR_CONFIG
>                              0x03d3
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
> b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
> index 63457f9df4c5..f84bed6eecb9 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
> @@ -312,6 +312,11 @@
>  //UVD_GPCOM_VCPU_DATA1
>  #define UVD_GPCOM_VCPU_DATA1__DATA1__SHIFT
>                                     0x0
>  #define UVD_GPCOM_VCPU_DATA1__DATA1_MASK
>                                     0xFFFFFFFFL
> +//UVD_ENGINE_CNTL
> +#define UVD_ENGINE_CNTL__ENGINE_START_MASK 0x1
> +#define UVD_ENGINE_CNTL__ENGINE_START__SHIFT 0x0
> +#define UVD_ENGINE_CNTL__ENGINE_START_MODE_MASK 0x2
> +#define UVD_ENGINE_CNTL__ENGINE_START_MODE__SHIFT 0x1
>  //UVD_UDEC_DBW_UV_ADDR_CONFIG
>  #define UVD_UDEC_DBW_UV_ADDR_CONFIG__NUM_PIPES__SHIFT
>                                      0x0
>  #define UVD_UDEC_DBW_UV_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT
>                                     0x3
> --
> 2.17.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000d7439105835a60b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5BbGV4IGNhbiBJIGdldCBhbiBS
QiBvbiB0aGlzIDotKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+
VG9tPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
IiBjbGFzcz0iZ21haWxfYXR0ciI+T24gTW9uLCBNYXIgNCwgMjAxOSBhdCAxMDo1OSBBTSBTdERl
bmlzLCBUb20gJmx0OzxhIGhyZWY9Im1haWx0bzpUb20uU3REZW5pc0BhbWQuY29tIj5Ub20uU3RE
ZW5pc0BhbWQuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5TaWduZWQtb2ZmLWJ5
OiBUb20gU3QgRGVuaXMgJmx0OzxhIGhyZWY9Im1haWx0bzp0b20uc3RkZW5pc0BhbWQuY29tIiB0
YXJnZXQ9Il9ibGFuayI+dG9tLnN0ZGVuaXNAYW1kLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0K
wqBkcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfb2Zmc2V0
LmjCoCB8IDIgKys8YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy92
Y24vdmNuXzFfMF9zaF9tYXNrLmggfCA1ICsrKysrPGJyPg0KwqAyIGZpbGVzIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2luY2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfb2Zmc2V0LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfb2Zmc2V0Lmg8YnI+DQppbmRleCA0NDJj
YTdjNDcxYTUuLjYxMDlmNWFkMjVhZCAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfb2Zmc2V0Lmg8YnI+DQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfb2Zmc2V0Lmg8YnI+
DQpAQCAtMTQxLDYgKzE0MSw4IEBAPGJyPg0KwqAjZGVmaW5lIG1tVVZEX0dQQ09NX1ZDUFVfREFU
QTBfQkFTRV9JRFjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxPGJyPg0K
wqAjZGVmaW5lIG1tVVZEX0dQQ09NX1ZDUFVfREFUQTHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MDNjNTxicj4NCsKgI2RlZmluZSBtbVVWRF9H
UENPTV9WQ1BVX0RBVEExX0JBU0VfSURYwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgMTxicj4NCisjZGVmaW5lIG1tVVZEX0VOR0lORV9DTlRMwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwM2M2PGJyPg0KKyNk
ZWZpbmUgbW1VVkRfRU5HSU5FX0NOVExfQkFTRV9JRFjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCNkZWZpbmUgbW1VVkRfVURFQ19EQldfVVZf
QUREUl9DT05GSUfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDAz
ZDI8YnI+DQrCoCNkZWZpbmUgbW1VVkRfVURFQ19EQldfVVZfQUREUl9DT05GSUdfQkFTRV9JRFjC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE8YnI+DQrCoCNkZWZpbmUgbW1VVkRfVURFQ19B
RERSX0NPTkZJR8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgMHgwM2QzPGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVk
ZS9hc2ljX3JlZy92Y24vdmNuXzFfMF9zaF9tYXNrLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvYXNpY19yZWcvdmNuL3Zjbl8xXzBfc2hfbWFzay5oPGJyPg0KaW5kZXggNjM0NTdmOWRm
NGM1Li5mODRiZWQ2ZWVjYjkgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2FzaWNfcmVnL3Zjbi92Y25fMV8wX3NoX21hc2suaDxicj4NCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy92Y24vdmNuXzFfMF9zaF9tYXNrLmg8YnI+DQpA
QCAtMzEyLDYgKzMxMiwxMSBAQDxicj4NCsKgLy9VVkRfR1BDT01fVkNQVV9EQVRBMTxicj4NCsKg
I2RlZmluZSBVVkRfR1BDT01fVkNQVV9EQVRBMV9fREFUQTFfX1NISUZUwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwPGJyPg0KwqAjZGVmaW5lIFVWRF9HUENP
TV9WQ1BVX0RBVEExX19EQVRBMV9NQVNLwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgMHhGRkZGRkZGRkw8YnI+DQorLy9VVkRfRU5HSU5FX0NOVEw8YnI+DQor
I2RlZmluZSBVVkRfRU5HSU5FX0NOVExfX0VOR0lORV9TVEFSVF9NQVNLIDB4MTxicj4NCisjZGVm
aW5lIFVWRF9FTkdJTkVfQ05UTF9fRU5HSU5FX1NUQVJUX19TSElGVCAweDA8YnI+DQorI2RlZmlu
ZSBVVkRfRU5HSU5FX0NOVExfX0VOR0lORV9TVEFSVF9NT0RFX01BU0sgMHgyPGJyPg0KKyNkZWZp
bmUgVVZEX0VOR0lORV9DTlRMX19FTkdJTkVfU1RBUlRfTU9ERV9fU0hJRlQgMHgxPGJyPg0KwqAv
L1VWRF9VREVDX0RCV19VVl9BRERSX0NPTkZJRzxicj4NCsKgI2RlZmluZSBVVkRfVURFQ19EQldf
VVZfQUREUl9DT05GSUdfX05VTV9QSVBFU19fU0hJRlTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDB4MDxicj4NCsKgI2RlZmluZSBVVkRfVURFQ19EQldfVVZfQUREUl9DT05GSUdfX1BJUEVf
SU5URVJMRUFWRV9TSVpFX19TSElGVMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4Mzxicj4NCi0tIDxicj4NCjIuMTcu
Mjxicj4NCjxicj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fPGJyPg0KYW1kLWdmeCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86YW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmciIHRhcmdldD0iX2JsYW5rIj5hbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzwvYT48YnI+DQo8YSBocmVmPSJodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeDwvYT48L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--000000000000d7439105835a60b9--

--===============1486490871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1486490871==--
