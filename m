Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF76CC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC5E10EB49;
	Fri,  8 Dec 2023 22:38:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E533210EB49
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKP0F4rK6hhI0AZUMSqkjI4gMAsUTtKdF74lbFTK7bXvxY05CHRa+qtVMGa2iGciu78EfpEK/313yGrQnzWOkj9KZ52FQkTklMkdUVDH4o5uWRbjficCHm4+xeEDjG4Gnoy1jaIDNaNm+em2UqLe2kBmIrXJL956K5WMChId+Bdg29vF8ENtSP+l7Jsc3xeCl+Ip+eB6dzRvMlHL21iFOQMttgNBDtwy3w7NDvN86Zs9snnbt0uX+0e9v8KIJjHN3qzIQJGjViTlXNWpE36QI1m8dqDtMQ7ykUT5WRIzByvlTh+WMz7W1edjcex8j6H4kBoFQ7HaizGeJQBR+TPcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnZnZhko3RHxGbGU734X8KMve6DYA68HEdxbdBetDn4=;
 b=Bysx4kr6QOq2iGhYO90dSVYiOVfsgP2SsVEDMxZhtu5UquqTUnYBEkOtXw7g+nExy2rAm2TfkmHdrrH4WWA177G5apkDr0sh9dybCOAD0NcL65uM7/4bTMUYEftLtjZhK83mvmQvdC6blPQk1IMtXHiNLecq5MZr3foENg1aFylo7Ei/Bd3yNHQTminqjBy+dLLzwIECql0XbQ1mHt8srmws910f7ShLOJzFScoJ5zgipbgx32V8uObq/POI9UrUDtlOcisRAM7VohgXTn2dnc+fbvjOf+szdEJ36gvlOONISzdVy/yM2w7vuUYtoyZszgkdHcWFEjY2I24GzISy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnZnZhko3RHxGbGU734X8KMve6DYA68HEdxbdBetDn4=;
 b=RrkQjVGijpDJNRZAqZzUGCgvRP3lZGFSeHX89FLCV3i02nuYDpGYe1MAN6/YId4PQPvK4xFowZX3cLojSwWM4e2rc6VmIkKagdEAaQlUbxrNtfTzhbiLvgtKaDtio08q9QQC4Tag+hd8HLnzKyE0RSPXJZ+DqAjqMwaaUfO19sw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:38:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:38:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu/sdma5.0: add begin/end_use ring callbacks
Thread-Topic: [PATCH 2/3] drm/amdgpu/sdma5.0: add begin/end_use ring callbacks
Thread-Index: AQHaKiSlUvwx4D5YhUuCwPdaPPrnNrCf+aXQ
Date: Fri, 8 Dec 2023 22:38:26 +0000
Message-ID: <BL1PR12MB514481593150F1E68DBF99EEF78AA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231208221928.5679-1-alexander.deucher@amd.com>
 <20231208221928.5679-2-alexander.deucher@amd.com>
In-Reply-To: <20231208221928.5679-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=50fe7a43-7630-4355-b089-9fb2ab18b485;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-08T22:36:30Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8200:EE_
x-ms-office365-filtering-correlation-id: 7866ec93-bb4a-4502-e5e3-08dbf83e649b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: odHVR9O1auJt3Q5tM31wmvneQb9P9HynKa4AWctvY/uIqWNGiJNO9K+whIvmMyC9tQvMQZ8SBo4Z6lNmN5EZ6bIgKtZLeBmaOtdxxH6WYO+y4LBdHW97++b+9PdlGU6ak/kX0IH2FJ/yJswOr8KP5mmz/CEbTvkjr92bHU3XeokevJJJwCdfYDVYIeMAIjqWbt9fSGH4jiXZbpwp0PbqHCGn6d2GQiNOB5ZbwtT/Cuh9biO+I+rPU0+w2LNScriWaPC1+eWH1iYOExw2cuZWoceXmo690KySxtseGeSJ6AfWUX3zrmIpS1/f2IllZSPU85HxdrMy5SgdrqlSpz03MLt2Bss2pe8cL6JvK6tNpnAMVttmicC8Ke1obQFOvL+jhfQy9PDwfLs4egLhBoKmT1fRt90KcdLEpjJzNw1kFaOETVXpaLMd2Ar2fDPNYjDogVm0hO7zEObGRnCFwToBVv3zwzlnL26l1KcqnWafwkETonzhUVQmj6AkCA6uR1cC5gD1upSk8II9OFgU+dDU24arIlKLnXHPciy6p7DH5rHfCTbOco6NPUwlXQ2/oVkSEwMgV7eO0udkMO1tLEaVDGgdkkkxqZ6Ha1uHbrqRBfvqQhoGqk1IV3ve88mlnEvgwMV7poFc+8UTimpyn+8SuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(41300700001)(38100700002)(122000001)(2906002)(316002)(6916009)(38070700009)(5660300002)(8676002)(8936002)(33656002)(76116006)(9686003)(53546011)(71200400001)(7696005)(26005)(6506007)(478600001)(64756008)(86362001)(66556008)(66946007)(66446008)(66476007)(52536014)(83380400001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8A6KYu1i3sm02OKR27N1BR/n1EeHGMFV41S2mB3o5FVId7Ac+6UBZiCNEQOf?=
 =?us-ascii?Q?N8JkK8s+LQYcWDv70zZTrokiAS3ob8OnoUKwJaEsbuwPNkGTs6AJ7xNcUJrv?=
 =?us-ascii?Q?sYkh09IM7lcOWGBh4/BBIkE5umlWIgNWVzaLknN8owQ0ZXP4N322zFxRMCL/?=
 =?us-ascii?Q?OFAh80G270AuTwd1YqigdJPo1ufSWb/E17CA7U8Nt/DLZ28TAJj2c9hC7abw?=
 =?us-ascii?Q?1B6xITQroqLC8IfobcA+tCpuRI3J3igwmstrcYsx4EIblS8zXcdbBhbR2eUu?=
 =?us-ascii?Q?v53bDvxambNMMERNzaMZ/fnpiYSs8RPYjJKfAUN5YIWxF3Lh3uxPof2BMlzI?=
 =?us-ascii?Q?orBtQzZqIgut/AeiAm8l8P1WB3MLVP6nCgEnpYUaxkCfNLa8mznedJIukzZC?=
 =?us-ascii?Q?i9zO+zv2/HcAZmEOcXrVKQ/4E815A3ao9oK5uEgyLeB1XwNDHjiqir7f6NOL?=
 =?us-ascii?Q?7bNgK/jtme/1qqAPxRJ7V/D190sLDkX7Za+pSAL2o+rBdBQhWnBtUpqk5xZM?=
 =?us-ascii?Q?YEq9sKZvkHyNK4irv0WyLREjA7qJGoXRjSMdywTdMOwDviMu19z5oKO4mQOI?=
 =?us-ascii?Q?+lo7o9b0FlNA+9C7GvAOlPIzz1L9+KrnyTZtNZrsLDTsYT51fRTMpBBOJuXF?=
 =?us-ascii?Q?aTFR0Zq0oiOO56CoTpj9gbWxFL6SHrljyElIIWZKJkwzJiivqYKnNyHmjZsG?=
 =?us-ascii?Q?72MmggiaU0z8Z88AInQBAq/LTE8CkGv4kooWnEjsZp9W5EdJnjuEwcPrx143?=
 =?us-ascii?Q?Q9BjTwyRPV3VeXb8zopa+Ltd1WtUACjJP7ZS/Hb0Lbani9tiq40TS3O7FPtt?=
 =?us-ascii?Q?9rSutlNyU2Pu+GUpYN5E11UcmdP63jlPCcM4OumQhT4BA8X6He4BfQtvsPId?=
 =?us-ascii?Q?rCNek/AfcXHmbtWSY9MpLdTKGIMIkBGCDQqmgouycJjOYUQY4XnZWGG2QuS/?=
 =?us-ascii?Q?4f07qClb6clD5Ezmyu2YqF5Xtguq31QJhgU4BhSsAkniDtsmTEjYUAbmOGG0?=
 =?us-ascii?Q?ydEkllOeTQMjmesM5h4jtdzJZeRl4Q6TVW1DWEev8J/sNhXEW8r8cwNk1J9y?=
 =?us-ascii?Q?r1Vu+lhNuL9rdmyoi/Ya8bIHjfiXs5iYuR0p8BLKrj09sle3PWueP6UhXRxq?=
 =?us-ascii?Q?RJe6vTEqMdjNsXiE0qumrTwPHq0EC3pohJeZjrwLoHHg8Pl5qGk5pdg52Hjy?=
 =?us-ascii?Q?ljQTORQdfbvdnc3gS6GRrOUMvzS9V/A2n/RAJPVqPKbR1KlSRPTchvUdK2dm?=
 =?us-ascii?Q?5js+KLDGPVu5cFPJcVG3ESxlU+toHPyr6UqT0G7BaRhRvpsyTtNu8a8OcAID?=
 =?us-ascii?Q?uEuQOOH9BWEbGwMPWOYgBuZcxsv5TjyZH1WLgC0Zrkx/QJ4+PGpNrigFzQZZ?=
 =?us-ascii?Q?BJfjyIRouF+YDZqjbnCH339CO+PkZij+yEZdaD4tV/suBDMbg1E1mrHU/aG1?=
 =?us-ascii?Q?NwEUffD9xjw7q+sGtVHYJQwffOwCSLaAH9gtrl11R0SIDoHTeAcy+R2hvg04?=
 =?us-ascii?Q?B8WjSZIdEy6mlYUaxnB/F2CwjNRraO0uQh4cSoATfmmSq+2l4bwh1t83J8IW?=
 =?us-ascii?Q?FMzytFaf9zhdFg7uksQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7866ec93-bb4a-4502-e5e3-08dbf83e649b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 22:38:26.1923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGCAGIWCvOry5FCgsV9VurEypNY53IN8WKTroDTixN/qC4aAuJULmgSw2X8qiqcZD2Or9o0ybXCTcO2vqibNXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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

[Public]

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, December 8, 2023 5:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/sdma5.0: add begin/end_use ring
> callbacks
>
> Add begin/end_use ring callbacks to disallow GFXOFF when SDMA work is
> submitted and allow it again afterward.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

This one can probably be dropped.  It's only needed if anyone on navi1x is =
experiencing a similar issue.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5c1bb6d07a76..1a68cd2de522 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1790,6 +1790,8 @@ static const struct amdgpu_ring_funcs
> sdma_v5_0_ring_funcs =3D {
>       .test_ib =3D sdma_v5_0_ring_test_ib,
>       .insert_nop =3D sdma_v5_0_ring_insert_nop,
>       .pad_ib =3D sdma_v5_0_ring_pad_ib,
> +     .begin_use =3D amdgpu_sdma_ring_begin_use,
> +     .end_use =3D amdgpu_sdma_ring_end_use,
>       .emit_wreg =3D sdma_v5_0_ring_emit_wreg,
>       .emit_reg_wait =3D sdma_v5_0_ring_emit_reg_wait,
>       .emit_reg_write_reg_wait =3D
> sdma_v5_0_ring_emit_reg_write_reg_wait,
> --
> 2.42.0

