Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30FCCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 14:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EFE10E2A9;
	Fri, 10 Oct 2025 14:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VECcDwq+";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D6C10E2A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 14:07:26 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-269640c2d4bso3187695ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760105246; x=1760710046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qp0fN0o5bP0fy1/93QRMyiBHjQKsXJrox7Lzs0LIJ58=;
 b=VECcDwq+2Xb5kvDZslcXyhwXcD06WRzVo0KR5rinObleF2ngJChqQPPKjBwMxP79zn
 ihH92NLwRuEnCjtO0AdMOePrgev405TWVi2tyS81rba+ETigYEq+JTaaHY6aHrBw7RUH
 X/zAfUjzTBRhFKc+eVNutVFYaJ44nbrBFzdtS3bU8MY569D7Do50enp1tYXV6BPBBJdd
 r3NkFuiPlkHj1zSHWcLtth+EOQXAnGb/DiIVxvC3KNugnHArpjNgxIL8nIqCL4dKeT2L
 88f8bUeVFoDMZGojGy1Ul42zFuxYdLX27w5S/hbkWd8I+3Uup4Z8WsBNxQEiDnUsJFk5
 jtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760105246; x=1760710046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qp0fN0o5bP0fy1/93QRMyiBHjQKsXJrox7Lzs0LIJ58=;
 b=KS/FqFhjhCNDeRlJ71HtFimzOHbSUgOzd0Pq6T0nBqPnkKFuJa1gObRtIlrVYZNhQ/
 0/Z7stUvqgbFmFZ1bx99gX0W0H1tA9eZIQi+AsEKYg4lTnQPIlGCWuY/NAvTOslx89z5
 tpLroaOZGejWbaMJzzTMzK07qUjqgnSWcFaTNY4REHqD2SDcM+UJ4q8t8DFOyobL7mTw
 0PDvemYO2fGflSrquulYymkDezXitZP4/1N7p0i0F9yt6RkI6AJsZvEdzmwfUuocu13z
 aS62P4c2WBAwbvPTYGFEdj7HC+djY9f/BKempO2rsMYlHz/bXrGHzvz8RA0Z+h7bWKVI
 mHiA==
X-Gm-Message-State: AOJu0YzOlp/ftiVYH9Q3xEzzCULG18X4/ElGXHluI9Er75ide4FzKXBk
 0Ka97/lbAsQDbAIWq96dOqhvafL1a3yyg93VitUdtRj68AzJ0jWUrgCfoTLN60x4cBtSSUCKKAM
 Zg/YJfENvX17K7UrtdoZ15FUXVVC/e6I=
X-Gm-Gg: ASbGnctMc0WGFBZhvbAkYsqKvHAIMbUQYdck+Ve5AJMbVBk+BYSsNREIQL+78/45X+/
 EQFe8yY7POaG6n4N6hs3SdSrDvcQlGn9ukq/SW4GE05dvtTMWyXEHLUmuJcE3i23TTyr9iWMcpw
 9xRVZJr55yYdQ3ymJnqC2YUIPk5fxLndA33Zgdf1cbzqAglmko10SegQuZScYOdj+xjfSRg7WCK
 F+z67992l8yoQeR/f2EoHyu5A==
X-Google-Smtp-Source: AGHT+IHrcQgSSNf4rQA+YUOe0jU7J1Z/gNN6Mm+6A+oyLePrp8EQqrOL4USJsxx20uOIbfT3hUQbjdoN26PyUbaU8aQ=
X-Received: by 2002:a17:903:1a68:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-2902733fb0dmr88338305ad.11.1760105246002; Fri, 10 Oct 2025
 07:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20251010140201.3492361-1-lijo.lazar@amd.com>
In-Reply-To: <20251010140201.3492361-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Oct 2025 10:07:12 -0400
X-Gm-Features: AS18NWDADqHbC-yAWR5j0J7yQTMGAm9drs6B97EjyBsKtyaCy0L39axrZNFygt4
Message-ID: <CADnq5_P5OpNi=HknAx5Cwi070vv-=U1tmDmgqF13R42k6-XK=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add amdgpu_discovery_info
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 10, 2025 at 10:02=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Add amdgpu_discovery_info structure to keep all discovery related
> information.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 196 ++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   7 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   2 +-
>  6 files changed, 129 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 9cbc8648f837..fcc8c31ffd51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -972,8 +972,7 @@ struct amdgpu_device {
>         struct notifier_block           acpi_nb;
>         struct notifier_block           pm_nb;
>         struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> -       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> -       struct debugfs_blob_wrapper     debugfs_discovery_blob;
> +       struct debugfs_blob_wrapper debugfs_vbios_blob;
>         struct mutex                    srbm_mutex;
>         /* GRBM index mutex. Protects concurrent access to GRBM index */
>         struct mutex                    grbm_idx_mutex;
> @@ -1063,6 +1062,9 @@ struct amdgpu_device {
>                 u32                     log2_max_MBps;
>         } mm_stats;
>
> +       /* discovery*/
> +       struct amdgpu_discovery_info discovery;
> +
>         /* display */
>         bool                            enable_virtual_display;
>         struct amdgpu_vkms_output       *amdgpu_vkms_output;
> @@ -1265,8 +1267,6 @@ struct amdgpu_device {
>
>         struct list_head                ras_list;
>
> -       struct ip_discovery_top         *ip_top;
> -
>         struct amdgpu_reset_domain      *reset_domain;
>
>         struct mutex                    benchmark_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index a70651050acf..062a8ee50a77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2123,10 +2123,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev=
)
>         debugfs_create_blob("amdgpu_vbios", 0444, root,
>                             &adev->debugfs_vbios_blob);
>
> -       adev->debugfs_discovery_blob.data =3D adev->mman.discovery_bin;
> -       adev->debugfs_discovery_blob.size =3D adev->mman.discovery_tmr_si=
ze;
> -       debugfs_create_blob("amdgpu_discovery", 0444, root,
> -                           &adev->debugfs_discovery_blob);
> +       if (adev->discovery.debugfs_discovery_blob.size)
> +               debugfs_create_blob("amdgpu_discovery", 0444, root,
> +                                   &adev->discovery.debugfs_discovery_bl=
ob);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f3d42c5b1547..4eada22cca4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2626,7 +2626,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>                 chip_name =3D "arcturus";
>                 break;
>         case CHIP_NAVI12:
> -               if (adev->mman.discovery_bin)
> +               if (adev->discovery.discovery_bin)
>                         return 0;
>                 chip_name =3D "navi12";
>                 break;
> @@ -5038,7 +5038,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *ad=
ev)
>
>         if (IS_ENABLED(CONFIG_PERF_EVENTS))
>                 amdgpu_pmu_fini(adev);
> -       if (adev->mman.discovery_bin)
> +       if (adev->discovery.discovery_bin)
>                 amdgpu_discovery_fini(adev);
>
>         amdgpu_reset_put_reset_domain(adev->reset_domain);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 73401f0aeb34..bd324385e18a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -254,9 +254,10 @@ static int amdgpu_discovery_read_binary_from_sysmem(=
struct amdgpu_device *adev,
>         pos =3D tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
>
>         /* This region is read-only and reserved from system use */
> -       discv_regn =3D memremap(pos, adev->mman.discovery_tmr_size, MEMRE=
MAP_WC);
> +       discv_regn =3D
> +               memremap(pos, adev->discovery.discovery_tmr_size, MEMREMA=
P_WC);
>         if (discv_regn) {
> -               memcpy(binary, discv_regn, adev->mman.discovery_tmr_size)=
;
> +               memcpy(binary, discv_regn, adev->discovery.discovery_tmr_=
size);
>                 memunmap(discv_regn);
>                 return 0;
>         }
> @@ -301,7 +302,8 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
>         if (sz_valid) {
>                 uint64_t pos =3D vram_size - DISCOVERY_TMR_OFFSET;
>                 amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> -                                         adev->mman.discovery_tmr_size, =
false);
> +                                         adev->discovery.discovery_tmr_s=
ize,
> +                                         false);
>         } else {
>                 ret =3D amdgpu_discovery_read_binary_from_sysmem(adev, bi=
nary);
>         }
> @@ -389,6 +391,7 @@ static void amdgpu_discovery_harvest_config_quirk(str=
uct amdgpu_device *adev)
>  static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
>                                            struct binary_header *bhdr)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct table_info *info;
>         uint16_t checksum;
>         uint16_t offset;
> @@ -398,14 +401,14 @@ static int amdgpu_discovery_verify_npsinfo(struct a=
mdgpu_device *adev,
>         checksum =3D le16_to_cpu(info->checksum);
>
>         struct nps_info_header *nhdr =3D
> -               (struct nps_info_header *)(adev->mman.discovery_bin + off=
set);
> +               (struct nps_info_header *)(discovery_bin + offset);
>
>         if (le32_to_cpu(nhdr->table_id) !=3D NPS_INFO_TABLE_ID) {
>                 dev_dbg(adev->dev, "invalid ip discovery nps info table i=
d\n");
>                 return -EINVAL;
>         }
>
> -       if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + =
offset,
> +       if (!amdgpu_discovery_verify_checksum(discovery_bin + offset,
>                                               le32_to_cpu(nhdr->size_byte=
s),
>                                               checksum)) {
>                 dev_dbg(adev->dev, "invalid nps info data table checksum\=
n");
> @@ -447,49 +450,55 @@ static int amdgpu_discovery_init(struct amdgpu_devi=
ce *adev)
>  {
>         struct table_info *info;
>         struct binary_header *bhdr;
> +       uint8_t *discovery_bin;
>         const char *fw_name;
>         uint16_t offset;
>         uint16_t size;
>         uint16_t checksum;
>         int r;
>
> -       adev->mman.discovery_tmr_size =3D DISCOVERY_TMR_SIZE;
> -       adev->mman.discovery_bin =3D kzalloc(adev->mman.discovery_tmr_siz=
e, GFP_KERNEL);
> -       if (!adev->mman.discovery_bin)
> +       adev->discovery.discovery_bin =3D kzalloc(DISCOVERY_TMR_SIZE, GFP=
_KERNEL);
> +       if (!adev->discovery.discovery_bin)
>                 return -ENOMEM;
> +       adev->discovery.discovery_tmr_size =3D DISCOVERY_TMR_SIZE;
> +       adev->discovery.debugfs_discovery_blob.data =3D
> +               adev->discovery.discovery_bin;
> +       adev->discovery.debugfs_discovery_blob.size =3D
> +               adev->discovery.discovery_tmr_size;
>
> +       discovery_bin =3D adev->discovery.discovery_bin;
>         /* Read from file if it is the preferred option */
>         fw_name =3D amdgpu_discovery_get_fw_name(adev);
>         if (fw_name !=3D NULL) {
>                 drm_dbg(&adev->ddev, "use ip discovery information from f=
ile");
> -               r =3D amdgpu_discovery_read_binary_from_file(adev, adev->=
mman.discovery_bin, fw_name);
> +               r =3D amdgpu_discovery_read_binary_from_file(adev, discov=
ery_bin,
> +                                                          fw_name);
>                 if (r)
>                         goto out;
>         } else {
>                 drm_dbg(&adev->ddev, "use ip discovery information from m=
emory");
> -               r =3D amdgpu_discovery_read_binary_from_mem(
> -                       adev, adev->mman.discovery_bin);
> +               r =3D amdgpu_discovery_read_binary_from_mem(adev, discove=
ry_bin);
>                 if (r)
>                         goto out;
>         }
>
>         /* check the ip discovery binary signature */
> -       if (!amdgpu_discovery_verify_binary_signature(adev->mman.discover=
y_bin)) {
> +       if (!amdgpu_discovery_verify_binary_signature(discovery_bin)) {
>                 dev_err(adev->dev,
>                         "get invalid ip discovery binary signature\n");
>                 r =3D -EINVAL;
>                 goto out;
>         }
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>
>         offset =3D offsetof(struct binary_header, binary_checksum) +
>                 sizeof(bhdr->binary_checksum);
>         size =3D le16_to_cpu(bhdr->binary_size) - offset;
>         checksum =3D le16_to_cpu(bhdr->binary_checksum);
>
> -       if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + =
offset,
> -                                             size, checksum)) {
> +       if (!amdgpu_discovery_verify_checksum(discovery_bin + offset, siz=
e,
> +                                             checksum)) {
>                 dev_err(adev->dev, "invalid ip discovery binary checksum\=
n");
>                 r =3D -EINVAL;
>                 goto out;
> @@ -501,15 +510,16 @@ static int amdgpu_discovery_init(struct amdgpu_devi=
ce *adev)
>
>         if (offset) {
>                 struct ip_discovery_header *ihdr =3D
> -                       (struct ip_discovery_header *)(adev->mman.discove=
ry_bin + offset);
> +                       (struct ip_discovery_header *)(discovery_bin + of=
fset);
>                 if (le32_to_cpu(ihdr->signature) !=3D DISCOVERY_TABLE_SIG=
NATURE) {
>                         dev_err(adev->dev, "invalid ip discovery data tab=
le signature\n");
>                         r =3D -EINVAL;
>                         goto out;
>                 }
>
> -               if (!amdgpu_discovery_verify_checksum(adev->mman.discover=
y_bin + offset,
> -                                                     le16_to_cpu(ihdr->s=
ize), checksum)) {
> +               if (!amdgpu_discovery_verify_checksum(discovery_bin + off=
set,
> +                                                     le16_to_cpu(ihdr->s=
ize),
> +                                                     checksum)) {
>                         dev_err(adev->dev, "invalid ip discovery data tab=
le checksum\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -522,7 +532,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>
>         if (offset) {
>                 struct gpu_info_header *ghdr =3D
> -                       (struct gpu_info_header *)(adev->mman.discovery_b=
in + offset);
> +                       (struct gpu_info_header *)(discovery_bin + offset=
);
>
>                 if (le32_to_cpu(ghdr->table_id) !=3D GC_TABLE_ID) {
>                         dev_err(adev->dev, "invalid ip discovery gc table=
 id\n");
> @@ -530,8 +540,9 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>                         goto out;
>                 }
>
> -               if (!amdgpu_discovery_verify_checksum(adev->mman.discover=
y_bin + offset,
> -                                                     le32_to_cpu(ghdr->s=
ize), checksum)) {
> +               if (!amdgpu_discovery_verify_checksum(discovery_bin + off=
set,
> +                                                     le32_to_cpu(ghdr->s=
ize),
> +                                                     checksum)) {
>                         dev_err(adev->dev, "invalid gc data table checksu=
m\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -544,7 +555,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>
>         if (offset) {
>                 struct harvest_info_header *hhdr =3D
> -                       (struct harvest_info_header *)(adev->mman.discove=
ry_bin + offset);
> +                       (struct harvest_info_header *)(discovery_bin + of=
fset);
>
>                 if (le32_to_cpu(hhdr->signature) !=3D HARVEST_TABLE_SIGNA=
TURE) {
>                         dev_err(adev->dev, "invalid ip discovery harvest =
table signature\n");
> @@ -552,8 +563,9 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>                         goto out;
>                 }
>
> -               if (!amdgpu_discovery_verify_checksum(adev->mman.discover=
y_bin + offset,
> -                                                     sizeof(struct harve=
st_table), checksum)) {
> +               if (!amdgpu_discovery_verify_checksum(
> +                           discovery_bin + offset,
> +                           sizeof(struct harvest_table), checksum)) {
>                         dev_err(adev->dev, "invalid harvest data table ch=
ecksum\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -566,7 +578,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>
>         if (offset) {
>                 struct vcn_info_header *vhdr =3D
> -                       (struct vcn_info_header *)(adev->mman.discovery_b=
in + offset);
> +                       (struct vcn_info_header *)(discovery_bin + offset=
);
>
>                 if (le32_to_cpu(vhdr->table_id) !=3D VCN_INFO_TABLE_ID) {
>                         dev_err(adev->dev, "invalid ip discovery vcn tabl=
e id\n");
> @@ -574,8 +586,9 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>                         goto out;
>                 }
>
> -               if (!amdgpu_discovery_verify_checksum(adev->mman.discover=
y_bin + offset,
> -                                                     le32_to_cpu(vhdr->s=
ize_bytes), checksum)) {
> +               if (!amdgpu_discovery_verify_checksum(
> +                           discovery_bin + offset,
> +                           le32_to_cpu(vhdr->size_bytes), checksum)) {
>                         dev_err(adev->dev, "invalid vcn data table checks=
um\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -588,7 +601,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>
>         if (0 && offset) {
>                 struct mall_info_header *mhdr =3D
> -                       (struct mall_info_header *)(adev->mman.discovery_=
bin + offset);
> +                       (struct mall_info_header *)(discovery_bin + offse=
t);
>
>                 if (le32_to_cpu(mhdr->table_id) !=3D MALL_INFO_TABLE_ID) =
{
>                         dev_err(adev->dev, "invalid ip discovery mall tab=
le id\n");
> @@ -596,8 +609,9 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>                         goto out;
>                 }
>
> -               if (!amdgpu_discovery_verify_checksum(adev->mman.discover=
y_bin + offset,
> -                                                     le32_to_cpu(mhdr->s=
ize_bytes), checksum)) {
> +               if (!amdgpu_discovery_verify_checksum(
> +                           discovery_bin + offset,
> +                           le32_to_cpu(mhdr->size_bytes), checksum)) {
>                         dev_err(adev->dev, "invalid mall data table check=
sum\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -607,8 +621,8 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>         return 0;
>
>  out:
> -       kfree(adev->mman.discovery_bin);
> -       adev->mman.discovery_bin =3D NULL;
> +       kfree(adev->discovery.discovery_bin);
> +       adev->discovery.discovery_bin =3D NULL;
>         if ((amdgpu_discovery !=3D 2) &&
>             (RREG32(mmIP_DISCOVERY_VERSION) =3D=3D 4))
>                 amdgpu_ras_query_boot_status(adev, 4);
> @@ -620,8 +634,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu=
_device *adev);
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>         amdgpu_discovery_sysfs_fini(adev);
> -       kfree(adev->mman.discovery_bin);
> -       adev->mman.discovery_bin =3D NULL;
> +       kfree(adev->discovery.discovery_bin);
> +       adev->discovery.discovery_bin =3D NULL;
>  }
>
>  static int amdgpu_discovery_validate_ip(struct amdgpu_device *adev,
> @@ -646,6 +660,7 @@ static int amdgpu_discovery_validate_ip(struct amdgpu=
_device *adev,
>  static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_devic=
e *adev,
>                                                 uint32_t *vcn_harvest_cou=
nt)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> @@ -655,21 +670,21 @@ static void amdgpu_discovery_read_harvest_bit_per_i=
p(struct amdgpu_device *adev,
>         uint8_t inst;
>         int i, j;
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset=
));
> +       bhdr =3D (struct binary_header *)discovery_bin;
> +       ihdr =3D (struct ip_discovery_header
> +                       *)(discovery_bin +
> +                          le16_to_cpu(bhdr->table_list[IP_DISCOVERY].off=
set));
>         num_dies =3D le16_to_cpu(ihdr->num_dies);
>
>         /* scan harvest bit of all IP data structures */
>         for (i =3D 0; i < num_dies; i++) {
>                 die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);
> -               dhdr =3D (struct die_header *)(adev->mman.discovery_bin +=
 die_offset);
> +               dhdr =3D (struct die_header *)(discovery_bin + die_offset=
);
>                 num_ips =3D le16_to_cpu(dhdr->num_ips);
>                 ip_offset =3D die_offset + sizeof(*dhdr);
>
>                 for (j =3D 0; j < num_ips; j++) {
> -                       ip =3D (struct ip *)(adev->mman.discovery_bin +
> -                                          ip_offset);
> +                       ip =3D (struct ip *)(discovery_bin + ip_offset);
>                         inst =3D ip->number_instance;
>                         hw_id =3D le16_to_cpu(ip->hw_id);
>                         if (amdgpu_discovery_validate_ip(adev, inst, hw_i=
d))
> @@ -711,13 +726,14 @@ static void amdgpu_discovery_read_from_harvest_tabl=
e(struct amdgpu_device *adev,
>                                                      uint32_t *vcn_harves=
t_count,
>                                                      uint32_t *umc_harves=
t_count)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         struct harvest_table *harvest_info;
>         u16 offset;
>         int i;
>         uint32_t umc_harvest_config =3D 0;
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>         offset =3D le16_to_cpu(bhdr->table_list[HARVEST_INFO].offset);
>
>         if (!offset) {
> @@ -725,7 +741,7 @@ static void amdgpu_discovery_read_from_harvest_table(=
struct amdgpu_device *adev,
>                 return;
>         }
>
> -       harvest_info =3D (struct harvest_table *)(adev->mman.discovery_bi=
n + offset);
> +       harvest_info =3D (struct harvest_table *)(discovery_bin + offset)=
;
>
>         for (i =3D 0; i < 32; i++) {
>                 if (le16_to_cpu(harvest_info->list[i].hw_id) =3D=3D 0)
> @@ -1021,8 +1037,8 @@ static void ip_disc_release(struct kobject *kobj)
>                                                        kobj);
>         struct amdgpu_device *adev =3D ip_top->adev;
>
> -       adev->ip_top =3D NULL;
>         kfree(ip_top);
> +       adev->discovery.ip_top =3D NULL;
>  }
>
>  static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *a=
dev,
> @@ -1060,6 +1076,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu=
_device *adev,
>                                       const size_t _ip_offset, const int =
num_ips,
>                                       bool reg_base_64)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         int ii, jj, kk, res;
>         uint16_t hw_id;
>         uint8_t inst;
> @@ -1077,7 +1094,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu=
_device *adev,
>                         struct ip_v4 *ip;
>                         struct ip_hw_instance *ip_hw_instance;
>
> -                       ip =3D (struct ip_v4 *)(adev->mman.discovery_bin =
+ ip_offset);
> +                       ip =3D (struct ip_v4 *)(discovery_bin + ip_offset=
);
>                         inst =3D ip->instance_number;
>                         hw_id =3D le16_to_cpu(ip->hw_id);
>                         if (amdgpu_discovery_validate_ip(adev, inst, hw_i=
d) ||
> @@ -1164,17 +1181,20 @@ static int amdgpu_discovery_sysfs_ips(struct amdg=
pu_device *adev,
>
>  static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
>  {
> +       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> -       struct kset *die_kset =3D &adev->ip_top->die_kset;
> +       struct kset *die_kset =3D &ip_top->die_kset;
>         u16 num_dies, die_offset, num_ips;
>         size_t ip_offset;
>         int ii, res;
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> -                                             le16_to_cpu(bhdr->table_lis=
t[IP_DISCOVERY].offset));
> +       bhdr =3D (struct binary_header *)discovery_bin;
> +       ihdr =3D (struct ip_discovery_header
> +                       *)(discovery_bin +
> +                          le16_to_cpu(bhdr->table_list[IP_DISCOVERY].off=
set));
>         num_dies =3D le16_to_cpu(ihdr->num_dies);
>
>         DRM_DEBUG("number of dies: %d\n", num_dies);
> @@ -1183,7 +1203,7 @@ static int amdgpu_discovery_sysfs_recurse(struct am=
dgpu_device *adev)
>                 struct ip_die_entry *ip_die_entry;
>
>                 die_offset =3D le16_to_cpu(ihdr->die_info[ii].die_offset)=
;
> -               dhdr =3D (struct die_header *)(adev->mman.discovery_bin +=
 die_offset);
> +               dhdr =3D (struct die_header *)(discovery_bin + die_offset=
);
>                 num_ips =3D le16_to_cpu(dhdr->num_ips);
>                 ip_offset =3D die_offset + sizeof(*dhdr);
>
> @@ -1217,30 +1237,32 @@ static int amdgpu_discovery_sysfs_recurse(struct =
amdgpu_device *adev)
>
>  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
> +       struct ip_discovery_top *ip_top;
>         struct kset *die_kset;
>         int res, ii;
>
> -       if (!adev->mman.discovery_bin)
> +       if (!discovery_bin)
>                 return -EINVAL;
>
> -       adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
> -       if (!adev->ip_top)
> +       ip_top =3D kzalloc(sizeof(*ip_top), GFP_KERNEL);
> +       if (!ip_top)
>                 return -ENOMEM;
>
> -       adev->ip_top->adev =3D adev;
> -
> -       res =3D kobject_init_and_add(&adev->ip_top->kobj, &ip_discovery_k=
type,
> +       ip_top->adev =3D adev;
> +       adev->discovery.ip_top =3D ip_top;
> +       res =3D kobject_init_and_add(&ip_top->kobj, &ip_discovery_ktype,
>                                    &adev->dev->kobj, "ip_discovery");
>         if (res) {
>                 DRM_ERROR("Couldn't init and add ip_discovery/");
>                 goto Err;
>         }
>
> -       die_kset =3D &adev->ip_top->die_kset;
> +       die_kset =3D &ip_top->die_kset;
>         kobject_set_name(&die_kset->kobj, "%s", "die");
> -       die_kset->kobj.parent =3D &adev->ip_top->kobj;
> +       die_kset->kobj.parent =3D &ip_top->kobj;
>         die_kset->kobj.ktype =3D &die_kobj_ktype;
> -       res =3D kset_register(&adev->ip_top->die_kset);
> +       res =3D kset_register(&ip_top->die_kset);
>         if (res) {
>                 DRM_ERROR("Couldn't register die_kset");
>                 goto Err;
> @@ -1254,7 +1276,7 @@ static int amdgpu_discovery_sysfs_init(struct amdgp=
u_device *adev)
>
>         return res;
>  Err:
> -       kobject_put(&adev->ip_top->kobj);
> +       kobject_put(&ip_top->kobj);
>         return res;
>  }
>
> @@ -1299,10 +1321,11 @@ static void amdgpu_discovery_sysfs_die_free(struc=
t ip_die_entry *ip_die_entry)
>
>  static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
>  {
> +       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;
>         struct list_head *el, *tmp;
>         struct kset *die_kset;
>
> -       die_kset =3D &adev->ip_top->die_kset;
> +       die_kset =3D &ip_top->die_kset;
>         spin_lock(&die_kset->list_lock);
>         list_for_each_prev_safe(el, tmp, &die_kset->list) {
>                 list_del_init(el);
> @@ -1311,8 +1334,8 @@ static void amdgpu_discovery_sysfs_fini(struct amdg=
pu_device *adev)
>                 spin_lock(&die_kset->list_lock);
>         }
>         spin_unlock(&die_kset->list_lock);
> -       kobject_put(&adev->ip_top->die_kset.kobj);
> -       kobject_put(&adev->ip_top->kobj);
> +       kobject_put(&ip_top->die_kset.kobj);
> +       kobject_put(&ip_top->kobj);
>  }
>
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D */
> @@ -1323,6 +1346,7 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>         struct binary_header *bhdr;
>         struct ip_discovery_header *ihdr;
>         struct die_header *dhdr;
> +       uint8_t *discovery_bin;
>         struct ip_v4 *ip;
>         uint16_t die_offset;
>         uint16_t ip_offset;
> @@ -1338,22 +1362,23 @@ static int amdgpu_discovery_reg_base_init(struct =
amdgpu_device *adev)
>         r =3D amdgpu_discovery_init(adev);
>         if (r)
>                 return r;
> -
> +       discovery_bin =3D adev->discovery.discovery_bin;
>         wafl_ver =3D 0;
>         adev->gfx.xcc_mask =3D 0;
>         adev->sdma.sdma_mask =3D 0;
>         adev->vcn.inst_mask =3D 0;
>         adev->jpeg.inst_mask =3D 0;
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> -                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset=
));
> +       bhdr =3D (struct binary_header *)discovery_bin;
> +       ihdr =3D (struct ip_discovery_header
> +                       *)(discovery_bin +
> +                          le16_to_cpu(bhdr->table_list[IP_DISCOVERY].off=
set));
>         num_dies =3D le16_to_cpu(ihdr->num_dies);
>
>         DRM_DEBUG("number of dies: %d\n", num_dies);
>
>         for (i =3D 0; i < num_dies; i++) {
>                 die_offset =3D le16_to_cpu(ihdr->die_info[i].die_offset);
> -               dhdr =3D (struct die_header *)(adev->mman.discovery_bin +=
 die_offset);
> +               dhdr =3D (struct die_header *)(discovery_bin + die_offset=
);
>                 num_ips =3D le16_to_cpu(dhdr->num_ips);
>                 ip_offset =3D die_offset + sizeof(*dhdr);
>
> @@ -1367,7 +1392,7 @@ static int amdgpu_discovery_reg_base_init(struct am=
dgpu_device *adev)
>                                 le16_to_cpu(dhdr->die_id), num_ips);
>
>                 for (j =3D 0; j < num_ips; j++) {
> -                       ip =3D (struct ip_v4 *)(adev->mman.discovery_bin =
+ ip_offset);
> +                       ip =3D (struct ip_v4 *)(discovery_bin + ip_offset=
);
>
>                         inst =3D ip->instance_number;
>                         hw_id =3D le16_to_cpu(ip->hw_id);
> @@ -1517,16 +1542,16 @@ static int amdgpu_discovery_reg_base_init(struct =
amdgpu_device *adev)
>
>  static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct ip_discovery_header *ihdr;
>         struct binary_header *bhdr;
>         int vcn_harvest_count =3D 0;
>         int umc_harvest_count =3D 0;
>         uint16_t offset, ihdr_ver;
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>         offset =3D le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset);
> -       ihdr =3D (struct ip_discovery_header *)(adev->mman.discovery_bin =
+
> -                                             offset);
> +       ihdr =3D (struct ip_discovery_header *)(discovery_bin + offset);
>         ihdr_ver =3D le16_to_cpu(ihdr->version);
>         /*
>          * Harvest table does not fit Navi1x and legacy GPUs,
> @@ -1573,22 +1598,23 @@ union gc_info {
>
>  static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         union gc_info *gc_info;
>         u16 offset;
>
> -       if (!adev->mman.discovery_bin) {
> +       if (!discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>         offset =3D le16_to_cpu(bhdr->table_list[GC].offset);
>
>         if (!offset)
>                 return 0;
>
> -       gc_info =3D (union gc_info *)(adev->mman.discovery_bin + offset);
> +       gc_info =3D (union gc_info *)(discovery_bin + offset);
>
>         switch (le16_to_cpu(gc_info->v1.header.version_major)) {
>         case 1:
> @@ -1681,24 +1707,25 @@ union mall_info {
>
>  static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         union mall_info *mall_info;
>         u32 u, mall_size_per_umc, m_s_present, half_use;
>         u64 mall_size;
>         u16 offset;
>
> -       if (!adev->mman.discovery_bin) {
> +       if (!discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>         offset =3D le16_to_cpu(bhdr->table_list[MALL_INFO].offset);
>
>         if (!offset)
>                 return 0;
>
> -       mall_info =3D (union mall_info *)(adev->mman.discovery_bin + offs=
et);
> +       mall_info =3D (union mall_info *)(discovery_bin + offset);
>
>         switch (le16_to_cpu(mall_info->v1.header.version_major)) {
>         case 1:
> @@ -1737,12 +1764,13 @@ union vcn_info {
>
>  static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct binary_header *bhdr;
>         union vcn_info *vcn_info;
>         u16 offset;
>         int v;
>
> -       if (!adev->mman.discovery_bin) {
> +       if (!discovery_bin) {
>                 DRM_ERROR("ip discovery uninitialized\n");
>                 return -EINVAL;
>         }
> @@ -1757,13 +1785,13 @@ static int amdgpu_discovery_get_vcn_info(struct a=
mdgpu_device *adev)
>                 return -EINVAL;
>         }
>
> -       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
> +       bhdr =3D (struct binary_header *)discovery_bin;
>         offset =3D le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
>
>         if (!offset)
>                 return 0;
>
> -       vcn_info =3D (union vcn_info *)(adev->mman.discovery_bin + offset=
);
> +       vcn_info =3D (union vcn_info *)(discovery_bin + offset);
>
>         switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
>         case 1:
> @@ -1823,6 +1851,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_dev=
ice *adev,
>                                   struct amdgpu_gmc_memrange **ranges,
>                                   int *range_cnt, bool refresh)
>  {
> +       uint8_t *discovery_bin =3D adev->discovery.discovery_bin;
>         struct amdgpu_gmc_memrange *mem_ranges;
>         struct binary_header *bhdr;
>         union nps_info *nps_info;
> @@ -1839,13 +1868,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_d=
evice *adev,
>                         return r;
>                 nps_info =3D &nps_data;
>         } else {
> -               if (!adev->mman.discovery_bin) {
> +               if (!discovery_bin) {
>                         dev_err(adev->dev,
>                                 "fetch mem range failed, ip discovery uni=
nitialized\n");
>                         return -EINVAL;
>                 }
>
> -               bhdr =3D (struct binary_header *)adev->mman.discovery_bin=
;
> +               bhdr =3D (struct binary_header *)discovery_bin;
>                 offset =3D le16_to_cpu(bhdr->table_list[NPS_INFO].offset)=
;
>
>                 if (!offset)
> @@ -1855,8 +1884,7 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_dev=
ice *adev,
>                 if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
>                         return -ENOENT;
>
> -               nps_info =3D
> -                       (union nps_info *)(adev->mman.discovery_bin + off=
set);
> +               nps_info =3D (union nps_info *)(discovery_bin + offset);
>         }
>
>         switch (le16_to_cpu(nps_info->v1.header.version_major)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h
> index b44d56465c5b..842cb59cea6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -27,6 +27,13 @@
>  #define DISCOVERY_TMR_SIZE      (10 << 10)
>  #define DISCOVERY_TMR_OFFSET    (64 << 10)
>
> +struct amdgpu_discovery_info {
> +       struct debugfs_blob_wrapper debugfs_discovery_blob;
> +       struct ip_discovery_top *ip_top;
> +       uint32_t discovery_tmr_size;
> +       uint8_t *discovery_bin;

You can drop the "discovery" from the elements in the structure, it's
superfluous in the code.

Alex

> +};
> +
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index d13d28a5923c..73336291984a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1955,7 +1955,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>          * If IP discovery enabled, a block of memory should be
>          * reserved for IP discovey.
>          */
> -       if (adev->mman.discovery_bin) {
> +       if (adev->discovery.discovery_bin) {
>                 r =3D amdgpu_ttm_reserve_tmr(adev);
>                 if (r)
>                         return r;
> --
> 2.49.0
>
