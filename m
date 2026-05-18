Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BA5CD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 10:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F024010E77A;
	Mon, 18 May 2026 10:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpUb2Dgb";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90CE10E77A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 10:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeydRq63kUOb7XtxBIZAY9O5M2PyTpr/UlEAoKlxtqyLPy+Uck9OPxRWXB868BW6+Pij0GSxKZYFjqbUEN7AAfos//E0mprRucpCLHk/WD+eKgp3sROImAEKzfzQ8W6r6YRnK5gpgsTq2iDBHj4OoIznm6BX4hMC7wW34+BtH7P4Vn6SLCio4vRfDiyZA3GZXYx9DiD2qnmSc6+l6uwsyY3DFgH4CSBJ9lv48JBjKth7P1e3CRlCK/iUU8i6NpBo8NyeTIB3TbMzzEx19Sz1+NVmMNYa1Dy6ZBTeIpoVXsZeV+x63CvFYZ9dGgfoCC5VdJWRqvA/rljXF9sJIfmZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytS0skDtKwGbIgK0gIKr0Mnn8ZWoEfll2mODCVxByNU=;
 b=Ejpe3g9AFL647rJyqr+o2ACEREYKQr7OkpJfP7a2m4ig3aaRcYHJ6T5G86gV9xo+2LBF/egTMoze3mt5UMuu4LI96eKAPruJpn65Lq0RCj8m9m41hfO8S3NY/PUJTiwyhiZd+R3QDnN2RRbcFPXYC3/Lj3hKbxwLEeD10HzF8iGzyrpMXV2lIXqK/k/DuyPug1XxGwFKqwGtT1/hCTDFeZSPYxNQQ7QjT6MkX6IPq1y769O8TXvVVWeYDBXpaRaJDc5X8ZBXA4xNq2+GnCPG/He6ueo/bYz3oS5LyM38XF0HSHCHP9arj3v847yWErbZ8kVUpcvljkCsaF58nrDgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytS0skDtKwGbIgK0gIKr0Mnn8ZWoEfll2mODCVxByNU=;
 b=QpUb2Dgb6mSF36s0i4JT9riWx98qVlDotrQ8kvNR+vfw2ELcMvJvhkxioMMIy/4VDwHEKQEH7979S9+MLg6RsJi0OAFcjcMGvw/tfTuECcViTTxEapZDa0ZhiT07KbdyEeGf5Sqq+LmC7RK/qS796B+cZsKJn72yMcVLik9DI00=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:07:09 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 10:07:09 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: validate and share PSP fw_pri_buf copies
 via psp_copy_fw
Thread-Topic: [PATCH 4/4] drm/amdgpu: validate and share PSP fw_pri_buf copies
 via psp_copy_fw
Thread-Index: AQHc5qESJqmbmvdNN0ejDnWTbAN047YTjtZg
Date: Mon, 18 May 2026 10:07:09 +0000
Message-ID: <PH7PR12MB8796431B557634EC7F4E087BB0032@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260518083337.790208-1-candice.li@amd.com>
In-Reply-To: <20260518083337.790208-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T10:06:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB6896:EE_
x-ms-office365-filtering-correlation-id: 4ae73d41-9e48-40e5-5403-08deb4c53930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: jJYGC0gFyBvVkeihJcg4M1VAUkWcCXpNBgG0MV4sx6YuA0BWLmk5sTpcQgQmZddePieHoJo/41rxealWEpzWvsTcxI9VlzPemXdKa1/icQjOGmZ8h1V/39FwStH9qFAuWQjd5f231E+u3xPBmlMv/TlXK/oKxjJo2uEwy8ZKjVAOQJw4Uf10qWDCikRK0IqBSZPVpYoNIfDxcXheDGhTf5+DVd2T45jNuzFJeysDtqzJWz6ge3BjHEiIdW0Uymdtye0vM5H6wLK8t6t6+ikWNSYW11XfRFe5wjbDX3CXN+PFDY86HoJjaMxJl65XOEacR+j8MYUl3pJz2UcXIkVRJ7OHrPBGKxl/zHg47k1riAd3lWnHWFgDkv8dyZSfct2SpZoOJHFPiYlMOghTTT3+O3UQe1k3etpbpW7gVQN4FN97PsYk/6dkxY57m8oO/xSncnPQODZaO8Lgsye1NmuOzoDWYddCn0YL9LSebmv/cmD6ZOOq+WDr5YRVasve/gvEKoXbY+xbrFi9FPlkYKtS8kTRfKKTUohFzu4gRj19Rs+vZ5u4P71t53zbJ9x92OAj+fra/oM4vaSA8f7OEOn4+IhsDcE7G/mKhbKl97+ZMF6DH9YuzvOOVGmwbAH/1wX1WPkolXkp0nfsQdc4JrAXAZPN6k9OZ3EYstCFegqd3nRfjHkMRSlB/EishiDX4PMwNNH2xqkZ81Tc30EkZyTU/eIBVBAuoXrbdPUaaL37vQOPng5vIZ7TX8liu8uVCfDs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XHKsGTP6LtXmswEqAVMDj+5twwapxB+xoRrTNzCrrUpOv9HB67CcVCfZv5iN?=
 =?us-ascii?Q?xuBimmc6oP483hOMc5D+cx+iazM8S5u4c78L1LJOkH6n00a/qtjsPLRvy1gt?=
 =?us-ascii?Q?/t3UCdYMec24hHEe6p93SYxGMaexLrTgFYebb5bMdLmR79ZAhudiG7JNYK0D?=
 =?us-ascii?Q?K8XkpA7BWEmFgyHJJxwjTt5ZIHGoSJ91kvRKO5cOoEhec6MBlhU1wkvqTi45?=
 =?us-ascii?Q?e8oDl/6Rc9LxZk9IFE5UGv1Swg7jWNNFhVYl8w7JWvrpUsMokoSMSs9WSsrl?=
 =?us-ascii?Q?v5nqykSrbRQtPA5k3NcyvUa9946J4IUpAzX4MPFOTZ91Dnfy0LWAehO60gL3?=
 =?us-ascii?Q?GXhCh/saMUyfgZ9xl9ikldCZRtjaLboV4J6JsiwTpKS7aFA0uG3bHExQtDt6?=
 =?us-ascii?Q?Al7VxHHT8N6k6mP3AKTTnutpgX/nrkCTC0fWkiOl5xGfm7QXvv7FRx2cYv4B?=
 =?us-ascii?Q?UXHtOhw0Gl097pL6neL9RHbxif1/SpbBunrVGsUIazSdDxACGYkjQbt3TQfH?=
 =?us-ascii?Q?W3Sma8nBR46OvaI7PImu4UnvcXz9whiOVPt6T8MVR4BFJm7GY3JfVFQZ215W?=
 =?us-ascii?Q?Wm5ICQAEEP1fdC85kzFHtMxa/uW/lBwKRW0fOch2T9jR+iBXusFEXc6deLZh?=
 =?us-ascii?Q?eyHdom3s7k3i0j5VKJFaTJZjLG+gLPFRuGR4USweFKIfUv4pVicDyPLVIkQS?=
 =?us-ascii?Q?XUkL8e5VJag2FYiTAzaIpyFOgTUt7p4qyQxiK/ypkfEuDQnUSMqyGarsnkmq?=
 =?us-ascii?Q?DKCwYAFfCkBgxmFtn2fPu8vIuEX2TfWLlR3doZDDOS/Ka8/zc4zI3RrOqQJU?=
 =?us-ascii?Q?08+9xYvxVNP3r+r5bzxiW9sdQgf5uDGBkT3V/r28Gm4orjLlPsSJFL/VNGtD?=
 =?us-ascii?Q?glHcZjyJcus5LfjIDWqIVuC+FK219r2PuJ7UBNE7brSNKVhzdc6jc2qFXVW8?=
 =?us-ascii?Q?wjT62stZhrMwcd4PsKYNfoWfgrRVGKvdG+mXE5deUDsgVh24UWrPjg5+l/KB?=
 =?us-ascii?Q?+6DeplqRpjdkChnuDZ9flx5h6yEp+E5tfWTL6sYAO/HKFn2cU2NBV/Em0xkh?=
 =?us-ascii?Q?gopNdVmh7koC36zk0Yk8dtGPI663oK51xakFwniQ5xjYPKLLRT+c71GNb/j6?=
 =?us-ascii?Q?0jaSKlvzFlmyDKsz+Tt6Yde/OCBSsSqIzaTjvMcRSYjOU2WMtqI8t2DL3Rbn?=
 =?us-ascii?Q?r8plPT9yNYXga0pu+fx0z3lx5bH39VdBJj7ohGqOzfpFn3a7KgBrsqcCDvH1?=
 =?us-ascii?Q?S9jQs6ICOV4QVdrjp1ibF7NHpcHjLCIB7DA5RRTgP9JP2BTDVt/UdUksQLDF?=
 =?us-ascii?Q?84h7p+uL++QLx/8hi7va63cSCi03019KdMGa2LSDqsYJUg+vRLXu/q2Ur42g?=
 =?us-ascii?Q?yqzlDitOjWjoxQ0hj1bjLNj8uhOJGpEC8X1oGwnVFzT13pE+FMIcvB2zlKuT?=
 =?us-ascii?Q?ebFjX/THqB04JT3/yP1N++apfrtgaqxxfC5VBRfb38Ba6Hy3nSKKqcyzJylP?=
 =?us-ascii?Q?qqiBfuoae0gB5VSWzv119idiq8aCpUezqN8VOq90gritbNuRqXIpx3ibaoJ8?=
 =?us-ascii?Q?uq/IYYhoiKB07FGD7gAhnItJrzG4GaaHNcnh0haUrYWFMfX3//+aN1UL0otk?=
 =?us-ascii?Q?K87wy5oFcIpnewi7tNBCffUNtmUIR2YSEENugxPxfvNGw9aVFgaBiNckW3pf?=
 =?us-ascii?Q?vaE+895lh4cRaM9d9WZq8goXxhmpQRbAwpF4HIdTCmbpBaxV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae73d41-9e48-40e5-5403-08deb4c53930
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 10:07:09.3597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J9YBLdgKr99QKFhsgO5PCAg70p5leeL1rBsJh4/9VwnZuD59L3Wkw7AnkuAuUyTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

AMD General

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Monday, May 18, 2026 4:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: validate and share PSP fw_pri_buf copies
> via psp_copy_fw
>
> Change psp_copy_fw from void to int: return -ENODEV when drm_dev_enter
> fails, and -EINVAL when the image size is zero or larger than the
> 1 MiB PSP private buffer.
>
> Replace open-coded memset/memcpy into fw_pri_buf with psp_copy_fw.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 32 ++++++++++++++++++---
> ---  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   |  8 ++++--
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   |  8 ++++--
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 14 +++++------
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 14 +++++------
>  drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 14 +++++------
>  drivers/gpu/drm/amd/amdgpu/psp_v3_1.c    |  8 ++++--
>  8 files changed, 62 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 9f79109acbeee5..e66943f85997cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -857,7 +857,11 @@ static int psp_load_toc(struct psp_context *psp,
>       struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
>
>       /* Copy toc to psp firmware private buffer */
> -     psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->toc.start_addr, psp->toc.size_bytes);
> +     if (ret) {
> +             release_psp_cmd_buf(psp);
> +             return ret;
> +     }
>
>       psp_prep_load_toc_cmd_buf(cmd, psp->fw_pri_mc_addr, psp-
> >toc.size_bytes);
>
> @@ -1173,8 +1177,11 @@ static int psp_rl_load(struct amdgpu_device
> *adev)
>
>       cmd =3D acquire_psp_cmd_buf(psp);
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -     memcpy(psp->fw_pri_buf, psp->rl.start_addr, psp->rl.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->rl.start_addr, psp->rl.size_bytes);
> +     if (ret) {
> +             release_psp_cmd_buf(psp);
> +             return ret;
> +     }
>
>       cmd->cmd_id =3D GFX_CMD_ID_LOAD_IP_FW;
>       cmd->cmd.cmd_load_ip_fw.fw_phy_addr_lo =3D lower_32_bits(psp-
> >fw_pri_mc_addr);
> @@ -1760,8 +1767,12 @@ int psp_ta_load(struct psp_context *psp, struct
> ta_context *context)
>
>       cmd =3D acquire_psp_cmd_buf(psp);
>
> -     psp_copy_fw(psp, context->bin_desc.start_addr,
> -                 context->bin_desc.size_bytes);
> +     ret =3D psp_copy_fw(psp, context->bin_desc.start_addr,
> +                       context->bin_desc.size_bytes);
> +     if (ret) {
> +             release_psp_cmd_buf(psp);
> +             return ret;
> +     }
>
>       if (amdgpu_virt_xgmi_migrate_enabled(psp->adev) &&
>               context->mem_context.shared_bo)
> @@ -4562,17 +4573,24 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct
> device *dev,
>       return count;
>  }
>
> -void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t
> bin_size)
> +int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t
> +bin_size)
>  {
>       int idx;
>
>       if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
> -             return;
> +             return -ENODEV;
> +
> +     if (!bin_size || bin_size > PSP_1_MEG) {
> +             dev_err(psp->adev->dev, "PSP firmware is invalid\n");
> +             drm_dev_exit(idx);
> +             return -EINVAL;
> +     }
>
>       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
>       memcpy(psp->fw_pri_buf, start_addr, bin_size);
>
>       drm_dev_exit(idx);
> +     return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 4197179a770182..2d838b1b2b116c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -638,7 +638,7 @@ int psp_get_fw_attestation_records_addr(struct
> psp_context *psp,  int psp_update_fw_reservation(struct psp_context *psp)=
;
> int psp_load_fw_list(struct psp_context *psp,
>                    struct amdgpu_firmware_info **ucode_list, int
> ucode_count); -void psp_copy_fw(struct psp_context *psp, uint8_t
> *start_addr, uint32_t bin_size);
> +int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t
> +bin_size);
>
>  int psp_spatial_partition(struct psp_context *psp, int mode);  int
> psp_memory_partition(struct psp_context *psp, int mode); diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index fb7aaf5ae05cfb..479690c44f0d54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -217,7 +217,9 @@ static int
> psp_v11_0_bootloader_load_component(struct psp_context        *psp,
>               return ret;
>
>       /* Copy PSP System Driver binary to memory */
> -     psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
> +     ret =3D psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes=
);
> +     if (ret)
> +             return ret;
>
>       /* Provide the sys driver to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, @@ -263,7
> +265,9 @@ static int psp_v11_0_bootloader_load_sos(struct psp_context
> *psp)
>               return ret;
>
>       /* Copy Secure OS binary to PSP memory */
> -     psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index c3cae29eeca1e5..f823f042788d15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -87,7 +87,9 @@ static int psp_v12_0_bootloader_load_sysdrv(struct
> psp_context *psp)
>               return ret;
>
>       /* Copy PSP System Driver binary to memory */
> -     psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the sys driver to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, @@ -123,7
> +125,9 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context
> *psp)
>               return ret;
>
>       /* Copy Secure OS binary to PSP memory */
> -     psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index a0c84f81c0c9d5..00b4a34e6601f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -271,10 +271,9 @@ static int
> psp_v13_0_bootloader_load_component(struct psp_context        *psp,
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy PSP KDB binary to memory */
> -     memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc-
> >size_bytes);
> +     ret =3D psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes=
);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP KDB to bootloader */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, @@ -353,10
> +352,9 @@ static int psp_v13_0_bootloader_load_sos(struct psp_context
> *psp)
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy Secure OS binary to PSP memory */
> -     memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> index 5f39a2edcc9562..3d5e26b3fa00ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> @@ -105,10 +105,9 @@ static int
> psp_v13_0_4_bootloader_load_component(struct psp_context      *psp,
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy PSP KDB binary to memory */
> -     memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc-
> >size_bytes);
> +     ret =3D psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes=
);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP KDB to bootloader */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, @@ -168,10
> +167,9 @@ static int psp_v13_0_4_bootloader_load_sos(struct psp_context
> *psp)
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy Secure OS binary to PSP memory */
> -     memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_36, diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> index 38dfc5c19f2a7e..040a61aefa8669 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> @@ -140,10 +140,9 @@ static int
> psp_v14_0_bootloader_load_component(struct psp_context        *psp,
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy PSP KDB binary to memory */
> -     memcpy(psp->fw_pri_buf, bin_desc->start_addr, bin_desc-
> >size_bytes);
> +     ret =3D psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes=
);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP KDB to bootloader */
>       WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, @@ -214,10
> +213,9 @@ static int psp_v14_0_bootloader_load_sos(struct psp_context
> *psp)
>       if (ret)
>               return ret;
>
> -     memset(psp->fw_pri_buf, 0, PSP_1_MEG);
> -
> -     /* Copy Secure OS binary to PSP memory */
> -     memcpy(psp->fw_pri_buf, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_36, diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> index f5030efc6c804a..24856c91c1351b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
> @@ -96,7 +96,9 @@ static int psp_v3_1_bootloader_load_sysdrv(struct
> psp_context *psp)
>               return ret;
>
>       /* Copy PSP System Driver binary to memory */
> -     psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the sys driver to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36, @@ -135,7
> +137,9 @@ static int psp_v3_1_bootloader_load_sos(struct psp_context
> *psp)
>               return ret;
>
>       /* Copy Secure OS binary to PSP memory */
> -     psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     ret =3D psp_copy_fw(psp, psp->sos.start_addr, psp->sos.size_bytes);
> +     if (ret)
> +             return ret;
>
>       /* Provide the PSP secure OS to bootloader */
>       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
> --
> 2.25.1

