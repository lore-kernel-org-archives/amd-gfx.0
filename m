Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7609BC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35B910E662;
	Fri, 11 Aug 2023 06:31:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C11610E662
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVsqQHjSi8xVHUuk2ax8pKkc57vLISG5WNA6991n5zloLSa3WskIG9rvt0OAW9hR+rX6MFY5iot2XlcmEk0ZZcr72hjyANC/+wWpCkUJYetOcZsRoKRnXiIW4WJLixcvol8pYv/MYrTUGPAyu0mZmDlBYBy5Nli/NwfKtI02p6t9OT/XJ/zCTzlyWLosEGHncibEzGaC9TGdPjcTRq7vcPKbGZE5WBuV6ZrDS7HOGyb7vJM0laNbHN0+xorpQwOafM414VMmMv0qFkprTuKnCqcgXug8XIn2bGRqSHuvLSZ8DUjEUYtBAv4tP48m283UfHyazUxSeRtFa8dxdD2Dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btYwQbONnrgpjj61MEYeB+gypdlyuUJ8LNtfZZ1bXtQ=;
 b=SwvgF51Djd1ncQt7sbU/sKKsUM0GfWFZSa2lzTpSdDDaz/d2p15n2+NC7zQ8N1l3eXpfQfzthraG9guf4FXl0IcDehafYHihzH8hCUK0b6gFLNuc2SykeQmfPKhd4MdWCtSGd8yPHhvAUJLRhPyUYWvQ4/JufRjMmdIDVYXchRh1s8cqjf9qa7ea7yHYFsKzCLyqqw9gmm6KbQWIyYFgNjYwjKc8BHEt73XIFYv3m8/LOIMiKMJae5xPexJC+ZLhBhOJkII4cJRuSccSEY/VlKt5ZYnb2Pa6OQeAn+mKWWdzaCIV2LZBJa9OYtL2vHRGPcKZdffewVsUadQ78O9YXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btYwQbONnrgpjj61MEYeB+gypdlyuUJ8LNtfZZ1bXtQ=;
 b=LYCA6LWrHxHO7R7EENtPv7uDPmNRqSZ2JVoC3mvcORSicYgIx1SAAXEghL3gpR0aZ4ftbJIxg00bzVOt+wzHhCUsCdwXSd4VpCA2fVU88wbcbP4YNEEG9QizJctE0BNVR5yxYHlzomtPOfLcUCp+zfoTz6OEU9fXadmPqGNfaJI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 06:31:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:31:53 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: Add bootloader status check
Thread-Topic: [PATCH 2/4] drm/amdgpu: Add bootloader status check
Thread-Index: AQHZzBNWLBvtvyPPZkKw4PUHSRpbcK/kokzQ
Date: Fri, 11 Aug 2023 06:31:53 +0000
Message-ID: <DM5PR12MB2469340D4250777272F6960AF110A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230811051756.653422-1-lijo.lazar@amd.com>
 <20230811051756.653422-3-lijo.lazar@amd.com>
In-Reply-To: <20230811051756.653422-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8c5f4b21-fe7f-497f-8fab-f93a46ffcd32;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-11T06:29:51Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB6391:EE_
x-ms-office365-filtering-correlation-id: 04fb4f5e-255f-4b47-1220-08db9a34a752
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xe6c7onfaXZTmQ/1amHIY8OELeW18zN4GE4pK93wDdy3lLP/17TNjvQIGWtiCPez0TpjNfOi1bqpL697+/gBfa/RqYqKbnZ3EfQI75NM84KFzxxSX6O3CoEET9apFVeSx9UnH2bPVANkPuCkqFBD11HTMP5M3GyjosKMFCSn5zQUel4hnASb2hvpLhulqS7spOz46kv4Nav7g+mzceZcIQKqCy9L2uEORnfNcdftTrjWVldwxJe/nS4/EZAFyB9NvH0fW40jONLX3bYQoh5qNNuWQs0hwRXj2Oq+DmI7h+TItPCvqiCyRZqogYp1KfpPynYJFy3gOn2jrbZs9qPXrDAtY71OF8xmgHGybPVReJvem4Sc5FusLRihBjgO6lK9/GA4/nZe9ddeqhQops5t+3iyLYBJCg8x0Eu2H/+H1FPfwHla8o67mJ2Ym+/PckyfYcg/URSN/1hmlf+oWjnaoFFaA3qQ5VRe4yVLDMWRs682u2eBlXefIOgvdpO8sPdsGaUlbL5+8xM50EiLAInSG/hzF8eWyaDASZ+bx8QzIpVPUCNN0YriEbP5pEXFAFU2OfD8n5r8WV8o87eQVT4vo69azYK3Nwpblvc6raCv5ZoGp2MRbMis3w3hgjcNpqGz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(186006)(451199021)(1800799006)(478600001)(316002)(4326008)(54906003)(64756008)(110136005)(5660300002)(52536014)(7696005)(8936002)(6506007)(26005)(66946007)(86362001)(9686003)(66556008)(66476007)(66446008)(8676002)(33656002)(71200400001)(55016003)(76116006)(2906002)(38100700002)(38070700005)(41300700001)(83380400001)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?27N4IcSZIe1dFrKzWPmJ02CovXOfLJ/v4Y3k8uBQfIkUtkbQ3DkaPi2d/H+h?=
 =?us-ascii?Q?p9jpekI8BeQcJqQ49LHZFCxIdxQKsqQGT1gFS7enmfInt4q4A+ebvFqi0PKa?=
 =?us-ascii?Q?A4Eeo/Z1gh+tvEy+tGwq12l6qeh+R1UsxzP6td9BKifD6UBsY7a61LAZSghy?=
 =?us-ascii?Q?KlSz9vqFE6d6ENQlljorqBiye3/Ftd7gpDVkeFwv0KNdXSnjd7KOz/3z2Ezu?=
 =?us-ascii?Q?1k5VhEMk70XBXdSb0QDiSd6T6R7DE3hzNDBvfVh6Vhy52V9zt0MZtgvwBHEp?=
 =?us-ascii?Q?aaZYsGAYC+4Y+c98bmqr4vq76zWD8FgKzk56wgyXtrNte+gSwucBQY5R58UK?=
 =?us-ascii?Q?26Sl1WsXc8+5fgYlL1zcUpGIoBS3IlWsI5cRAu2+H7uwps59p4yCBBx0UVvY?=
 =?us-ascii?Q?FyInypxvdDlr0d0u+H50638oxWVL0UtLs+R0kedGHYV8svV9+LR7A6DRx70x?=
 =?us-ascii?Q?B+5WrPeYFYBTgecsIH+ZdA7xsnmOmlDDy+JpdGbQ9H1bkYGy3DjFtmpqdFzh?=
 =?us-ascii?Q?WsmUAZMkZSpTdaQeflk323fnn5RZcVKrsBZJ/bKUaCfuA+vF+kKQrinALevE?=
 =?us-ascii?Q?Hk2ipeGu1Y5fxa9+cuHDS/vF07enrNtxQu/WEpQNRq0xLs5ddXxM4bbL3TFu?=
 =?us-ascii?Q?qRy9UGKdAZi4+talQ+gM+sl7gDy98+SXxpOIXEekic5f7eTeHARCwev0HnLC?=
 =?us-ascii?Q?ln05xMvPuCxX2TlFdNrAAllNbi97xzhcfDHjka+n5ZH0inEjtUsz3eAkfGE5?=
 =?us-ascii?Q?0O7g5GGGnL0i0YVU2Gj8iwTpGdCpiUAZ/tf5r2PIAGUB0KAtZ/5GQFsvMeBJ?=
 =?us-ascii?Q?u6yWq19uNgKqMbkl9wZT5kjZwKo5mmGqJmRZ8o4TB733CMyD3icgFxFvURCd?=
 =?us-ascii?Q?RS8y1uuHIEsqN5K09jRpIiwO1aG3I2tsCQnwN2CoaINC5GfTMXyirbTiDOtN?=
 =?us-ascii?Q?11JdywQC/pY7bdPQMnL+dKmaKVGegJ8Vj5l3z/CiTNIoG3aT4VsY4BCGybqh?=
 =?us-ascii?Q?haccjAMqb24P3pbkmGH/yJTySymf5oEAlQ21R0Ho5ziUdQdYmuG4OE3/5m/d?=
 =?us-ascii?Q?34pak2Pd/ax6pluCbJlarzCYICGA/3KR2Vnlc6V67PgY70hpB+j2b11cJVXD?=
 =?us-ascii?Q?XTqtmZRYSKCZHyvyGvgfNSlq9oDhmIgNZkQeUQwnL7hFhPKxP4GDBZknPzw7?=
 =?us-ascii?Q?j0KWYPurne4eRDkhx35fzeSQqR5uZ/hCwQIryiadI2oC6mVShPWBeBcW6TPE?=
 =?us-ascii?Q?wl/enFFILPDvCKfR896EhqnSVUEqpESzNj4DidsuTzaJdmYwM3xutBhIP3eU?=
 =?us-ascii?Q?HAMh23o0hK5LJZavSFzbwfDMic1LsGfuUsjSN+ckoqy818KeQy8kY/sAJGGJ?=
 =?us-ascii?Q?aslx8tX8AfYORNgv6txS0IAK/81/6hVyr7iFxJulUKZmh6xjFRsKeMFrSHy6?=
 =?us-ascii?Q?dt+C1E/9L3hdG+duXMScp64rQ+YXYPUxgmpaGDffIz435uqqUUl1vSB9Huzz?=
 =?us-ascii?Q?AngaJ924zNYgTj3iU5RoXX+WfVmLV5SJjBEltzw/x2s58bON2GfVkB2lASL9?=
 =?us-ascii?Q?/eCr2bj2fRyREupU1tU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb4f5e-255f-4b47-1220-08db9a34a752
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:31:53.8717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpuHFNAeq3tVLq94Yx0HzkY9KV+F+qWR1p1GCeXrX2+nVf9/fR6qO2Rrrwhjd2NWrcZJ+0QjiMtZltuEaGLl8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Friday, August 11, 2023 1:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/4] drm/amdgpu: Add bootloader status check
>
> Add a function to wait till bootloader has reached steady state.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>
> Tested-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  3 +++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6809bf7dae57..9061d79cd387 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -885,13 +885,20 @@ static void amdgpu_block_invalid_wreg(struct
> amdgpu_device *adev,
>   */
>  static int amdgpu_device_asic_init(struct amdgpu_device *adev)  {
> +     int ret;
> +
>       amdgpu_asic_pre_asic_init(adev);
>
>       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3) ||
> -         adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0))
> -             return amdgpu_atomfirmware_asic_init(adev, true);
> -     else
> +         adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)) {
> +             amdgpu_psp_wait_for_bootloader(adev);
> +             ret =3D amdgpu_atomfirmware_asic_init(adev, true);
> +             return ret;

'return amdgpu_atomfirmware_asic_init(adev, true);' may be more simple. The=
n you can drop variable 'ret'.

Regards,
Guchun

> +     } else {
>               return amdgpu_atom_asic_init(adev-
> >mode_info.atom_context);
> +     }
> +
> +     return 0;
>  }
>
>  /**
> @@ -4702,6 +4709,9 @@ int amdgpu_device_mode1_reset(struct
> amdgpu_device *adev)
>               dev_err(adev->dev, "GPU mode1 reset failed\n");
>
>       amdgpu_device_load_pci_state(adev->pdev);
> +     ret =3D amdgpu_psp_wait_for_bootloader(adev);
> +     if (ret)
> +             return ret;
>
>       /* wait for asic to come out of reset */
>       for (i =3D 0; i < adev->usec_timeout; i++) { @@ -4713,6 +4723,7 @@ =
int
> amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>       }
>
>       amdgpu_atombios_scratch_regs_engine_hung(adev, false);
> +
>       return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 8fdca54bb8a1..429ef212c1f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2078,6 +2078,17 @@ int psp_securedisplay_invoke(struct psp_context
> *psp, uint32_t ta_cmd_id)  }
>  /* SECUREDISPLAY end */
>
> +int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev) {
> +     struct psp_context *psp =3D &adev->psp;
> +     int ret =3D 0;
> +
> +     if (!amdgpu_sriov_vf(adev) && psp->funcs && psp->funcs-
> >wait_for_bootloader !=3D NULL)
> +             ret =3D psp->funcs->wait_for_bootloader(psp);
> +
> +     return ret;
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)  {
>       struct amdgpu_device *adev =3D psp->adev; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3384eb94fde0..3e67ed63e638 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -109,6 +109,7 @@ enum psp_reg_prog_id {
>
>  struct psp_funcs {
>       int (*init_microcode)(struct psp_context *psp);
> +     int (*wait_for_bootloader)(struct psp_context *psp);
>       int (*bootloader_load_kdb)(struct psp_context *psp);
>       int (*bootloader_load_spl)(struct psp_context *psp);
>       int (*bootloader_load_sysdrv)(struct psp_context *psp); @@ -533,4
> +534,6 @@ int psp_spatial_partition(struct psp_context *psp, int mode);
>
>  int is_psp_fw_valid(struct psp_bin_desc bin);
>
> +int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
> +
>  #endif
> --
> 2.25.1

