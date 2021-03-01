Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5D4C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157BC64F2B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 16:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157BC64F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E0B6E834;
	Mon,  1 Mar 2021 16:24:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DC76E83E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 16:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/vF1GpY8sQxNjVRTX5IZtOpEdbjOZzrLeElG59XnZ+yMEE14rQMo0992aCx0qFZbMIsRtbjnFoM2BJ9njzRsi3AC9x1TYQafVDFpdauTRMJvN1flfhT5csaMvPJXhfu+96k2j3bg31dHYpe++DR6W+qbR6ZMIXsQAyHM9w00iTyjEbpZVjJNGjhGVdUCaTQCFjUnNsXRnkCq6XB9XnuQVvEQjQM0q78WM2Q3jRBnNVFOi83I0QEAL1sMSNbk25GYK/bprduO2zNANxbXcqmPgayzovp+TaVC6Q2k+Vp67Y3uD90CA3P0l9f/2Hq3hY4OLLnuHZ567SLhfGFG+9vcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2lW1es46U+5jynUivCbo2ShDp4qprsn7RdF9o1H3AQ=;
 b=Mo4GmDkgYVcahu5rOkGG5P3UHWk1rrZFjVXhmEf414tuOpqgkItcZMRl4kkCla7GwRfQPrBwghRl8oBPbQ0yFaCADMqwCGJf74GZnu/B4UJCIGv9uSB3q+f/BK3/SHaWoL4zPG+KEOK8drZZ84Sies0XEYjIvlF4gR3xib0yNsQy71tKE0BEFmeRUVY4DwBVNBf/g4NLM/ZMgB++yHCeavbG5ahrpdo5AwYssiGTepPK0VqVe2k5GG3SSEQcuXLFRgHthZJYZyXv+M8lY2G7/u3ZBPORq2goQwDsalxXzoDknBM2dj3Zsyz5OUXS8odW9pECABAH5rgrEEDY9qO6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2lW1es46U+5jynUivCbo2ShDp4qprsn7RdF9o1H3AQ=;
 b=eWNjgwK0UNNSJ439sn5OnuYsi02ZN7gbnivLDYRVmRLTQtSOaUvvz6sT1s6cB/JDPpsP0VCwSQcxeOOk+zkTGjsqiBZF+4ZEbZQMydBXSMxz/ncatptXaW9QGI1Y3NLBeARUNvQutx1fA9OnbUiMVg0wo8hOPTQVBiK2PjuAmRA=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4809.namprd12.prod.outlook.com (2603:10b6:5:1f9::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Mon, 1 Mar 2021 16:24:36 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3868.033; Mon, 1 Mar 2021
 16:24:36 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add missing df counter disable write
Thread-Topic: [PATCH] drm/amdgpu: add missing df counter disable write
Thread-Index: AQHXCiurKILnbyq31UaeYVkk2T85hKppZYmAgAX0tBA=
Date: Mon, 1 Mar 2021 16:24:36 +0000
Message-ID: <DM6PR12MB2761AC9373ED021D32F81DEA8C9A9@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210223213408.65847-1-jonathan.kim@amd.com>
 <CADnq5_NC9+2Egkeo9aGEb+9hdBiaxs=x5WWEVTrF4s=yidkRKg@mail.gmail.com>
In-Reply-To: <CADnq5_NC9+2Egkeo9aGEb+9hdBiaxs=x5WWEVTrF4s=yidkRKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0c0696db-c4af-4588-8c8e-610d2828c8fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-01T16:24:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec8bbfa9-6f60-46e0-32b6-08d8dcce8161
x-ms-traffictypediagnostic: DM6PR12MB4809:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4809EFEF710F04E245CC62898C9A9@DM6PR12MB4809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAk7TRascgNEwj/dFuzoa8tx2UkM6Hln5NzpVPX7YRVj69umSwsMp8l+39bD1P65u7GBmvkGFvGkhwa2sSSDQpDoJdRHotyzCn3oXumGpTfDMsDiD2jWzVtN3+tCoz6VSXs4uKATHsEwtF0aIjw+Bh5CRLTCg1V134XpR8uJRKVD0JbfeghJSL/2VRcWLEszpg7asCYoANpMNUMOD81wbkR/Pw9RTl5hARdctoq4Xp/bqBZG3uZDJTPHMHiQEtthTjicr5p5d4IsoqND4cCtRRxXLSbCKXhBBaSxlk1HyI78x0GfPGlGLYiHd/wzizlb+N5DnjnhvnOW3U6X6ooDgvnujRRVkmCG/13UQmIUEmeEbZSq5Ji6UA4c23BSDyxiRP3/hd9wtGM2pfqcgK+Nk8zpEFqjjHTsJNG6PGTvxFsODkPtP7c+IlTU5apnj4Rl6Tus1vEpHD9w82AZHJBT20RA2gEf3aFMgYkOAToGTS1M9IxR09apYUh9LnZbaUQ2VolHC4tGRAUtWmP60qT3LkQGKHWjmqwClksyeoPSrWrDXza9g2d5We077Yt35YgE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(316002)(478600001)(71200400001)(45080400002)(9686003)(33656002)(186003)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(55016002)(7696005)(86362001)(53546011)(6506007)(4326008)(5660300002)(6636002)(8676002)(8936002)(83380400001)(966005)(2906002)(52536014)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fcBh82G703keqpmAAUw77J95U/klK8ORBgKKSBY47RAktiEcbrVVBM6FzxPw?=
 =?us-ascii?Q?lli1LzAw4uht3qpfZTsdKrGzEKLil9bjRNR9+ZvkAuiiMiAshZOBXsXquo7M?=
 =?us-ascii?Q?uPvutoo/grE3EiEFnTla0M78nrES85TzFDzT/9MF0aWrs0E6OOJw8Zumq6Ty?=
 =?us-ascii?Q?RdaFe8/GeEHn3gtuAw3dAGXmfiCAar2EKZHdklN39aPkRNbd3EjTi6hDWEpM?=
 =?us-ascii?Q?IyKLYxwFtlc2NrFHplz3JuIlLTS+cozGgkbKbnIkCMfyeRZEhowW2KlaYwpD?=
 =?us-ascii?Q?iphdsQGKv8s1m6CWFCtE6lMo/Gy5qOX5/IytUUxyQlbktnah2bXOYd83F0vc?=
 =?us-ascii?Q?/LapwGd0FXI04nbaVy3dzcJjr3/tf/vEsGtmYJ4A6+6gWtP5VNmPCauLqPCQ?=
 =?us-ascii?Q?Gj+YOBDgmY42QR3l9BQSjg0fGhge7DeXSfCdWmT+hpFH8iSIVcOET77ZxvEC?=
 =?us-ascii?Q?SKCqeMwEGkjJkskfJ8ACOibe9EXg1BLwerqutL+jkFLCu9BY6+bDxe3PET5b?=
 =?us-ascii?Q?QIrYSp41o+Yg92tLpQiFeO4/dYR1co4tv5sS1Foy28iqQESsGOhDVj7UlrQq?=
 =?us-ascii?Q?Af09xydsqhy+1S5s+FwwlkObHBa/OSHUbhe4tvupEd004SpaJyCo+oxNL8Cc?=
 =?us-ascii?Q?H5IKoEA6niTMQzaVFfgBvLHBLYIeu9iqnBIEHUAwpfLB06Oxh0rzDu8vSpxH?=
 =?us-ascii?Q?fATp++uyaTr4DDEr2N/4X7Emu0r6biodhKYHdfqMmd9ZSiqDxaMJ0j0ZmS6y?=
 =?us-ascii?Q?4QK20li3arKTt1BWv9Vcxn5sxloFRW4ipfv/nMKeTEQLsr6ZeqPI6YCQDoCa?=
 =?us-ascii?Q?dGuVYeV6DENgKt9n8plPrM2a0q4x2XF4gvwo83iu5Ykk92EQa3Fq+AH1/paB?=
 =?us-ascii?Q?DzKFaq5G82ZgFu3J81Hyc2MHh88fsSvmXL3RArf3HhQ75WC+e53rAGvK6arO?=
 =?us-ascii?Q?sCAZ568Qi2je1WjCUDpxoCY55HghvZmTOgNfEc/Mayv8SZTYySk/lNRWFqt8?=
 =?us-ascii?Q?hs5sQe1JeHTSFvHoEU2ecyDPOcG4aNXGE5ETBLB9u1TFwOPGJNpK8XAqy8FK?=
 =?us-ascii?Q?pVIuIndRWP4EjkG+N2zVlGbBxpIjaoChavSFYM3+gfnwGE8KTPKaflTXTrAd?=
 =?us-ascii?Q?Ky9TYicWtumaPVoFOCJTh5m0y4uE/7On23E9lw46v+Ki3c/a0YuLm9gDA7Ca?=
 =?us-ascii?Q?dT/pjPdPWjx/HeyX1fgr+vam3QBNkigrUfPtDldfaMs5dgRv96DyI5quO0XW?=
 =?us-ascii?Q?xO9TUdhh3TQv5g4Lc63QM++BcMRv5vlySBKX+3Gry5A0f+w+B9it2yKK3WZs?=
 =?us-ascii?Q?wamCJBS2w6GXLVfOqEh3VY9mH2lywzjXlp5i8/BnwLf+FSmc7xct1Vz6aDFD?=
 =?us-ascii?Q?Tv41Utob4/oY81P7f4W0H3kQ0M+L?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8bbfa9-6f60-46e0-32b6-08d8dcce8161
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 16:24:36.3400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNBdHvNGL2tX1LrGLWjw2Te519OGgqY6mgTLK08i3N8aK4OhSrLqkDgEsRSoC6hHkcV4OJJ/4RHjPtl2UnFVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4809
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, February 25, 2021 4:27 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add missing df counter disable write

On Tue, Feb 23, 2021 at 4:34 PM Jonathan Kim <jonathan.kim@amd.com> wrote:
>
> Request to stop DF performance counters is missing the actual write to the
> controller register.
>
> Reported-by: Chris Freehill <chris.freehill@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 6b4b30a8dce5..44109a6b8f44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -568,6 +568,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
>                 if (ret)
>                         return ret;
>
> +               df_v3_6_perfmon_wreg(adev, lo_base_addr, lo_val,
> +                                                       hi_base_addr, hi_val);
>
>                 if (is_remove) {
>                         df_v3_6_reset_perfmon_cntr(adev, config, counter_idx);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CHarish.Kasiviswanathan%40amd.com%7Cb6226ef6319b42b8211008d8d9d41a5d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637498852287647783%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VEuHTYnsJLYbTSmMhu7NEWUaLndUfOh8XKiqJy1%2Fjyk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
