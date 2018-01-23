From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Avoid leaking PM domain on driver unbind
Date: Mon, 22 Jan 2018 23:22:58 -0500
Message-ID: <CADnq5_PrAtz=rO1E_Tkg0+n880FwOAyowMW2WampSpVx+69CLA@mail.gmail.com>
References: <8cbcbe7f57f72bc1d4e36c9cfaf670140e311da9.1516538481.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="94eb2c0940fedc2d99056369e6d2"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8cbcbe7f57f72bc1d4e36c9cfaf670140e311da9.1516538481.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--94eb2c0940fedc2d99056369e6d2
Content-Type: text/plain; charset="UTF-8"

On Sun, Jan 21, 2018 at 7:46 AM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> amdgpu_device_init() calls vga_switcheroo_init_domain_pm_ops() either
> if the device has the PowerXpress flag set or if the user has set the
> "runpm" module param to 1.
>
> However amdgpu_device_fini() calls vga_switcheroo_fini_domain_pm_ops()
> only under the first of those two conditions.

Good catch.  Forcing runpm=1 doesn't do anything useful anyway so just
remove it in device_init().  See the attached patch.

Alex


>
> (Note this issue isn't present in radeon.  It was introduced when the
> driver was forked.)
>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d09c4ee9f7e1..f07eedc53761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2083,7 +2083,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         adev->bios = NULL;
>         if (!pci_is_thunderbolt_attached(adev->pdev))
>                 vga_switcheroo_unregister_client(adev->pdev);
> -       if (adev->flags & AMD_IS_PX)
> +       if (adev->flags & AMD_IS_PX || amdgpu_runtime_pm == 1)
>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
>         vga_client_register(adev->pdev, NULL, NULL, NULL);
>         if (adev->rio_mem)
> --
> 2.15.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c0940fedc2d99056369e6d2
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-Avoid-leaking-PM-domain-on-driver-unbind-.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Avoid-leaking-PM-domain-on-driver-unbind-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jcr4x64w0

RnJvbSA0MjBhMWEzZTdjMWMxMmI2M2NkOTNkMzA2YjhjZTgwNzUwZDliYzhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMjIgSmFuIDIwMTggMjM6MTM6MzIgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBBdm9pZCBsZWFraW5nIFBNIGRvbWFpbiBvbiBkcml2ZXIgdW5iaW5kICh2
MikKCldlIG9ubHkgc3VwcG9ydCB2Z2Ffc3dpdGNoZXJvbyBhbmQgcnVudGltZSBwbSBvbiBQWC9I
RyBzeXN0ZW1zCnNvIGZvcmNpbmcgcnVucG0gdG8gMSBkb2Vzbid0IGRvIGFueXRoaW5nIHVzZWZ1
bCBhbnl3YXkuCgpPbmx5IGNhbGwgdmdhX3N3aXRjaGVyb29faW5pdF9kb21haW5fcG1fb3BzKCkg
Zm9yIFBYL0hHIHNvCnRoYXQgdGhlIGNsZWFudXAgcGF0aCBpcyBjb3JyZWN0IGFzIHdlbGwuICBU
aGlzIG1pcnJvcnMgd2hhdApyYWRlb24gZG9lcyBhcyB3ZWxsLgoKdjI6IHJld29yayB0aGUgcGF0
Y2ggb3JpZ2luYWxseSBzZW50IGJ5IEx1a2FzIChBbGV4KQoKUmVwb3J0ZWQtYnk6IEx1a2FzIFd1
bm5lciA8bHVrYXNAd3VubmVyLmRlPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEx1a2FzIFd1bm5lciA8bHVrYXNA
d3VubmVyLmRlPiAodjEpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMiAtLQogMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jCmluZGV4IDAyYTkxNTdlNzJhYy4uNzE5OGViOTczNGVkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0xODc3LDggKzE4NzcsNiBAQCBpbnQgYW1k
Z3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCSAqIGlnbm9yZSBp
dCAqLwogCXZnYV9jbGllbnRfcmVnaXN0ZXIoYWRldi0+cGRldiwgYWRldiwgTlVMTCwgYW1kZ3B1
X2RldmljZV92Z2Ffc2V0X2RlY29kZSk7CiAKLQlpZiAoYW1kZ3B1X3J1bnRpbWVfcG0gPT0gMSkK
LQkJcnVudGltZSA9IHRydWU7CiAJaWYgKGFtZGdwdV9kZXZpY2VfaXNfcHgoZGRldikpCiAJCXJ1
bnRpbWUgPSB0cnVlOwogCWlmICghcGNpX2lzX3RodW5kZXJib2x0X2F0dGFjaGVkKGFkZXYtPnBk
ZXYpKQotLSAKMi4xMy42Cgo=
--94eb2c0940fedc2d99056369e6d2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--94eb2c0940fedc2d99056369e6d2--
