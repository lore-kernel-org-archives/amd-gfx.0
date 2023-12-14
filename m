Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3EBC4167D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 18:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ACB10E204;
	Thu, 14 Dec 2023 18:58:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DC910E204
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 18:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GazLik1ucCsZfKk8J3ufYNUcU0z4iWmFAWOPoC7WEvWryFzhM4CH8i0gIga75rtxvOKl4JAdvO2/M2hzZeFdz7n546PsJMtkibT1hU4SJokq0/y/gex6FYTVBpkq57/Opq4CC2oq2VctL2Da4bx3NRS9IQ5InwJPTbkuENAtAxpi2u2gL8g5/J7nvblwCd8xPXYfirbAY+2TlGocvJf2h8fNSgIr32PuEbTzRrO04e5QqpoIAiLRE5tLMFnevx3JMHWFal8dZnqkqxFOZQRr5++LsI2gczT25f6XNu9fKdc1vEoQHX3VqP8FGjVpv/O3jgQIkFRA6kSYOuFVXqYOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZK83qbIPciru1pzCglP2VdbghrDsE6+UcXdK02eO10=;
 b=i/SSyDtRv33mTBGDpYCnrfMJb35yO6YeELG3uwK5QcO13VIj2Zc052p5IGZNmeQwJ2KkTU1yHlo5aOu+rtpU/9nWH6LB7iItrDHVGFzNMy67f50JZl3AsmQaziNINk99SykizEaX7yOzmFFbTDM6Olp2lI2ow9OArAHLbYV43GpGOTyMGGnHeSIX4v3GHYMwhIP7uASW/bE93XRofQ7OTdiAFeaGbReQUblnXR+wd4p9B8Kufi2DckygY9/Cp/EwTEOuWmCZ/0VVRkyQOb3b9HoOXS2qHBwGxBoU+0Q+/NYtBtdgNaYEgcfJeagDFD90e2lJ7SvCd9a+8RxkFnX8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZK83qbIPciru1pzCglP2VdbghrDsE6+UcXdK02eO10=;
 b=ILPNs1Aad2CwSswmT2seh3+ofdRxFaMw2gJt1PjSOdH2w7SkKvpe3Z9IuVr8iYgLSXVvgKUrVnpGvcwAXIlmcpVyG8M3f4bYVw8xw+vVZ6qR27dOJXGOqfhcnlWRGK0AcmVghb6a4SdmPhdo9wT2AOQ+DrPfZCVMc+I95pxltCY=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 18:58:01 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::19fe:6718:e3a5:e855%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:58:01 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix NULL ptr for debugger mes flush on
 non-mes asics
Thread-Topic: [PATCH] drm/amdkfd: fix NULL ptr for debugger mes flush on
 non-mes asics
Thread-Index: AQHaLrzSz7J0idC0tESDaVGPAkGROLCpISzw
Date: Thu, 14 Dec 2023 18:58:01 +0000
Message-ID: <BL3PR12MB6425DD33247F6CFDEAC46667EE8CA@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20231214183839.129977-1-jinhuieric.huang@amd.com>
In-Reply-To: <20231214183839.129977-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7485c95d-4e56-4162-a951-434cdc99c980;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-14T18:57:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ0PR12MB7034:EE_
x-ms-office365-filtering-correlation-id: bd2f17db-1306-4383-f3f2-08dbfcd69843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4p2hQ7kx+eP6zrhoKtHgLcr30ONt76Oqf8bLTJBP+7FDLs6tEp7XmdmQeO4tY+88FDYIBiuOmiq6237WvzVp2ClEVhOj5dFCUjIQ6IB+NVtB4Lo1h94NauxQhA3FsKW1Yv3tNFFb4MmSDSoJ0CZdGvHDXIfihcSJVmDX1GWkUfM2lk2QjNboylVlU8L7zHMG+6hqwifgUk2KqYB2okluC7NPU7UUQQfAuFjoTGOi7iVHqPh5PhiRDeNm0+abK9ACl+G1PU1VdNUFWUvGkHYl2uD8Fig3KFM7KdKMG3YHIofWLOgVQ6XovSnetDxcZBAFapaHvklpTifc8Devz/PCuUTEk2YtCcknyNIt/HRvXyIhqLBMkD1yNPt5T/mPcQyjvzLDuEww+xL37H+cPAaPas/a4tvhl5uK6RrAKDkbpTLtAR+b6D4JEz2uEMehcJEGaj9wWQkHKHVgWc4w+AYoAdsoBlhb4A33rp3NDrNKNhy2JPLP+yvZcNrspuaWWYlnWwnEk0E6zPU0k2Q0o/FZJzyWVReYZlipsRAXnivNIRZZqJm6WTHeISUbDJyEjolLTLe5KyrraAjwIP70VOuc8jFIvc7KtF3DQ7H/QA/Al+oGBNuXfx0dpWE35WEvx8DOjvNH/xRGEzEcAC30SgzLj9Pj77eRk+MuB58aDRcIu/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(478600001)(64756008)(6506007)(7696005)(9686003)(66556008)(66446008)(316002)(53546011)(66476007)(2906002)(122000001)(52536014)(38070700009)(86362001)(26005)(71200400001)(55016003)(76116006)(66946007)(110136005)(4326008)(8936002)(8676002)(41300700001)(83380400001)(38100700002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?um4rK1wjsdKRp8CVFJ1IrEilCUn4c+MQcuZFYpJaKWgwzIizT2OToRXopREz?=
 =?us-ascii?Q?pL8cwVQm2jhqfNrXHp846qp6C86OF/UTFGE3vVp3ZQAJ9zJxKtFFr0i6CJnt?=
 =?us-ascii?Q?NIpP05fKcxvXy3heJ+Vgy+vj+y4rLRyDGud3nYxedXKAyuC0ykvdyowAmkU9?=
 =?us-ascii?Q?+sW+MPfg6WPKMV+gY8yoNWDiwmXPZuqWh5cKl6eIdEX8QR/uFlqoBGG562WA?=
 =?us-ascii?Q?qCflULjq+c5obpGV3KyiH+3PmnJr0mW1e+IotgHA8crme/PuAWOQoC3p8/b6?=
 =?us-ascii?Q?PZDaz9jn3dMFJY59JA3nwAk7Vr/i2NqrrsoYav2dOEd4+6/ytB/hR9nzNOW/?=
 =?us-ascii?Q?amiLA0hlt+pXOBp+wWNh6m4XhgVst1qHqRI+JNhG8jGS5kEw3MbKYnFlUaiV?=
 =?us-ascii?Q?4KVdw5PB0HjUKlR2TnHAMkG/QifF85zYIJiq2t60v307aTAj8hayJPagckrn?=
 =?us-ascii?Q?G5n2sdDyWPjOeNtsIIoS8eXe52305j73Sekk2YYS3uZU5IPpWH+ioq8Yx7El?=
 =?us-ascii?Q?UyXN9BuNH27E92J9YBE/FBNIi2wMrEH3dMURGekAGHOH8uxfQZAvFU6VfQ9n?=
 =?us-ascii?Q?LMacan22A+wgEX84zRU4czJZViGgRMBeBX+aL9yjZCeb7HlwG1lCFdr1ki3s?=
 =?us-ascii?Q?k+ghzczlCDArBPQSFaudH3wZyJ7jk1U2uJKbDyTATB4PM1nuGFcahDRKqhSY?=
 =?us-ascii?Q?9RAynZ2ULbdiGgHnUJDSAd6hAj9YeUCmdomf3AjPwt/uhzfPSrzpwVXRHdvv?=
 =?us-ascii?Q?WeIKfRZo7Moh3QLkyItnEvluqUMVOvqLSUmwJ7qE5+81G8ABr8TUDOdOVGYg?=
 =?us-ascii?Q?+nmxGKgTCuoilGdx29Drjvie/K/5a6UnoRvG4b2Nu5ak7cJjsEz1sv3oSJsv?=
 =?us-ascii?Q?sM/E+N2SBNhRUNRcwed1N+grno4WlnQhiOnCQQ2D5ONCMvzq0wTfo5FF7fBn?=
 =?us-ascii?Q?YTGcwbKvAwZDBy3jpnoUckF1Jpct1udZfZqwS2l2AOaKgi4c8/Hy2KwjeVqi?=
 =?us-ascii?Q?HHKH84qIUp76TOD3xyNxm1UPyG1ma8hMS1KsIXvte2dZguj4nHgSbu9m937O?=
 =?us-ascii?Q?2190fBKgVSDKr1ip9plgeqjpkaWDaC4EplVFZ8wTeH7O+YEwLuyxyb7IuDEA?=
 =?us-ascii?Q?SG8zm5dunCxcq18n2ogBHtvnsJhk1C9BX9co55feNbQu0zbZsOxdk79CtojA?=
 =?us-ascii?Q?6cqvcWg7UsJ1DgdsG92B63LhGsJZwd6l+924DENXLBqGDRODRqD2wma/nh0u?=
 =?us-ascii?Q?DYxBnWQNuRpiO/KXrBAFFEn1UqH5P1RBH/LHC93xmu0iRqA00Zkb2X2UpDII?=
 =?us-ascii?Q?i9pwy7uqi6STCMbjzXolO3DUL5MJDW8V5EoGERXlRxvjNgHLCZ0s1W5LsocT?=
 =?us-ascii?Q?EEizDAF3kVsxrQmvyMrLDi323/Ywso8mkakQZK0OFGPHTge7OVsEw7ljaw0y?=
 =?us-ascii?Q?IRFVfjnq8r+KOOcEwrzVYlld+8V224aaoNMw1qoudnaCS20yW8mFDwsngqth?=
 =?us-ascii?Q?MvsCaUC+fPjys9nLRkhouQy5QZyLKPBzvuPNEPajeYynHEDhbEgm29mCedgp?=
 =?us-ascii?Q?aQCdKmSS3pG4aoLrTkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f17db-1306-4383-f3f2-08dbfcd69843
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 18:58:01.0790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zo/kmKAihTvpHtMEaEqWJhMci9PpTC5ERRZugnKp0QdFrTramo6daoM117mc4Hsl0IOFmaLo/tR72Ng90obP1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Jon Kim sent out the same patch ("drm/amdkfd: only flush mes process contex=
t if mes support is there") yesterday.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric
> Huang
> Sent: Thursday, December 14, 2023 1:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH] drm/amdkfd: fix NULL ptr for debugger mes flush on non-
> mes asics
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The field adev->mes.funcs is NULL in function
> amdgpu_mes_flush_shader_debugger on non-mes asics, add mes enabling
> check for call this func to resolve the error.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 8e55e78fce4e..43eff221eae5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -87,7 +87,8 @@ void kfd_process_dequeue_from_device(struct
> kfd_process_device *pdd)
>                 return;
>
>         dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -       amdgpu_mes_flush_shader_debugger(dev->adev, pdd-
> >proc_ctx_gpu_addr);
> +       if (dev->kfd->shared_resources.enable_mes)
> +               amdgpu_mes_flush_shader_debugger(dev->adev,
> + pdd->proc_ctx_gpu_addr);
>         pdd->already_dequeued =3D true;
>  }
>
> --
> 2.34.1

