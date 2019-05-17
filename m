From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: set correct vram_width for vega10 under sriov
Date: Fri, 17 May 2019 10:34:30 -0400
Message-ID: <CADnq5_O00Ts0RA+ntfC8Sqfb3WGCi+xE6SwReOXUfJzJji7nTw@mail.gmail.com>
References: <1558008150-20674-1-git-send-email-yttao@amd.com>
 <MN2PR12MB3039BD8CF5208A1667D34B29E50B0@MN2PR12MB3039.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000906a300589164800"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3039BD8CF5208A1667D34B29E50B0-rweVpJHSKTr/fpeVZQY9RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Trigger" <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>

--000000000000906a300589164800
Content-Type: text/plain; charset="UTF-8"

How about combining these two patches into one?  This seems cleaner.

Alex

On Thu, May 16, 2019 at 10:39 PM Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Ping...
>
> Hi Christian and Alex
>
>
> Can you help review this? Thanks in advance.
>
>
> Best Regards
> Yintian Tao
>
> -----Original Message-----
> From: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> Sent: Thursday, May 16, 2019 8:03 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Tao, Yintian <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>; Huang, Trigger <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amdgpu: set correct vram_width for vega10 under sriov
>
> For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN, and DF related registers is not readable, seems hardcord is the only way to set the correct vram_width
>
> Signed-off-by: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Yintian Tao <yttao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c221570..a417763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -848,6 +848,13 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>                 adev->gmc.vram_width = numchan * chansize;
>         }
>
> +       /* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
> +        * and DF related registers is not readable, seems hardcord is the
> +        * only way to set the correct vram_width */
> +       if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
> +               adev->gmc.vram_width = 2048;
> +       }
> +
>         /* size in MB on si */
>         adev->gmc.mc_vram_size =
>                 adev->nbio_funcs->get_memsize(adev) * 1024ULL * 1024ULL;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000906a300589164800
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-gmc9-set-vram_width-properly-for-SR-IOV.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-gmc9-set-vram_width-properly-for-SR-IOV.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jvs6oh4p0>
X-Attachment-Id: f_jvs6oh4p0

RnJvbSAyOGNmZjU4OWU1NjQwODdkMjJlOWJlMzViYThmOTBlMGEzMDQwOWU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMTcgTWF5IDIwMTkgMDk6MzE6NDMgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2dtYzk6IHNldCB2cmFtX3dpZHRoIHByb3Blcmx5IGZvciBTUi1JT1YKCkZv
ciBTUi1JT1YsIHZyYW1fd2lkdGggY2FuJ3QgYmUgcmVhZCBmcm9tIEFUT00gYXMKUkFWRU4sIGFu
ZCBERiByZWxhdGVkIHJlZ2lzdGVycyBpcyBub3QgcmVhZGFibGUsIHNvIGhhcmRjb3JkCmlzIHRo
ZSBvbmx5IHdheSB0byBzZXQgdGhlIGNvcnJlY3QgdnJhbV93aWR0aC4KClNpZ25lZC1vZmYtYnk6
IFRyaWdnZXIgSHVhbmcgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogWWlu
dGlhbiBUYW8gPHl0dGFvQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jIHwgMTAgKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCmluZGV4
IDU5YzU4MGJkNWEzYi4uOTc1MGI2MzJlOWFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMKQEAgLTgzNSw4ICs4MzUsMTYgQEAgc3RhdGljIGludCBnbWNfdjlfMF9tY19pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWludCBjaGFuc2l6ZSwgbnVtY2hhbjsKIAlp
bnQgcjsKIAotCWlmIChhbWRncHVfZW11X21vZGUgIT0gMSkKKwlpZiAoYW1kZ3B1X3NyaW92X3Zm
KGFkZXYpKSB7CisJCS8qIEZvciBWZWdhMTAgU1ItSU9WLCB2cmFtX3dpZHRoIGNhbid0IGJlIHJl
YWQgZnJvbSBBVE9NIGFzIFJBVkVOLAorCQkgKiBhbmQgREYgcmVsYXRlZCByZWdpc3RlcnMgaXMg
bm90IHJlYWRhYmxlLCBzZWVtcyBoYXJkY29yZCBpcyB0aGUKKwkJICogb25seSB3YXkgdG8gc2V0
IHRoZSBjb3JyZWN0IHZyYW1fd2lkdGgKKwkJICovCisJCWFkZXYtPmdtYy52cmFtX3dpZHRoID0g
MjA0ODsKKwl9IGVsc2UgaWYgKGFtZGdwdV9lbXVfbW9kZSAhPSAxKSB7CiAJCWFkZXYtPmdtYy52
cmFtX3dpZHRoID0gYW1kZ3B1X2F0b21maXJtd2FyZV9nZXRfdnJhbV93aWR0aChhZGV2KTsKKwl9
CisKIAlpZiAoIWFkZXYtPmdtYy52cmFtX3dpZHRoKSB7CiAJCS8qIGhibSBtZW1vcnkgY2hhbm5l
bCBzaXplICovCiAJCWlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpCi0tIAoyLjIwLjEKCg==
--000000000000906a300589164800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--000000000000906a300589164800--
