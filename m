Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6C1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 02:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AFA10E128;
	Fri, 18 Feb 2022 02:05:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471F110E128
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 02:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFAHdN5hZ4qiqXU9cM9zB9jiHSaI8IoyF8iVZkYdNhkJMoEJxHxwaAI1+sIoXqdhFA9NkqtTUzZ3XREuO5IGvPPppWBmyT8PN+stWF1FC0CFI35OwopuALTx913GcuOckY1yXPbtD85oz7PIGp89yk9p30yog05LKTdqEPnpuxD0vIYEpik5SMABPR8zqRqfTUIlSY33/fsCaeH+yjWrReWxLYL4+6CI7PuPzbawBo9cldNVmLq1yCv2Zk/veoJ21c82kPsNp3mEytiwYEl1kvikePR1vhdukbDMc3hEJCFe+jrTvTvr9n3G3sTbobLm26R89GgMtm8fueM0UZ9k8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTTM4j0IZBnICrCfwI0CPYVcCZXklAKfocdobnh/y/w=;
 b=j83xgvyqAYkvfKViP/+x+ohr3qYC9iKuLAn60PA6K+7au5+LesCnahoZ/YeCUlBUrhB0nXjkVJkKng4Q3Zau6AC3K6ErNbGH1mJkQ+FrL0UAzc4l3pcmPsGQViG6j0k41rfXNREI+7FGTwRMkkTP/7XpofF4TodkBEkc1AGJcS16b32tCF4uXYqhxakocyAuQLgkbEXtuKWr8mtATWWYnfgauwvWjQg9S9OfAVlEypg/UQbblmLaWv1GTPCecTvTOvmIUYNy3odphI49Yp3mdHoemg+FFzZhLrW+CQUq9AQ3/r5SAXWwKRCeDhdpH7F1Z3Nt5x0xE/t/qkfUyons5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTTM4j0IZBnICrCfwI0CPYVcCZXklAKfocdobnh/y/w=;
 b=3/Tj9lS/9BY+PGgy0DqRqEKdhtDb2dGtKq8Kl/aru/Gb3zikCdK0qWhGDL5JS79CSoGQnlNnZmgqb7pLqAxuKkOpKdIqjln2DE7VWUnm14sHAX4EhL+XFtiEl/rHMHxVZDeNupaAjXHvrQSlQu30j3khB0N+U4pb4i82k8eZtHQ=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 02:05:53 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba%7]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 02:05:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Topic: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
Thread-Index: AQHYJGhdaANyqYiqR0ir5carEEJMH6yYjJ8AgAACMwA=
Date: Fri, 18 Feb 2022 02:05:52 +0000
Message-ID: <BYAPR12MB3238F4B926C4729B5577532CFB379@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1645148219-17774-1-git-send-email-Prike.Liang@amd.com>
 <BL1PR12MB523753998E7CF358807C1A42F0379@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB523753998E7CF358807C1A42F0379@BL1PR12MB5237.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=65f5b86a-cf04-4882-8d29-afb2b5638b8b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T02:05:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f78cd8f1-baad-4c5f-defa-08d9f2833141
x-ms-traffictypediagnostic: BL1PR12MB5731:EE_
x-microsoft-antispam-prvs: <BL1PR12MB573152F68BB53E86A423F74AFB379@BL1PR12MB5731.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpbxXOGpAIQCtyeIseRCRZdSKYN8OmZxgg4IP2KnTFbZVYxPN7oTjX3+UWgJr6eFWafEZlLNYumfNRGR6OTuoLZfPEq9cgRxsbYWVswV1ROMubFcIzHO05Q7sfrOV65LrzGzKnijAEtWpJ9MVj4v1KrZdTFFOeMsU25FVJ/nmHMC/AEjU1c7UWqyTs5R2gBmJfoQqFg29vxn5Cr748abWtnFR2mtVz2JAGF5bxAiTkAdpbQDZmtDostpCNgQV57h1688nZlRnxWSzsdztrOHMD4+5fE39+FmTUEaiYPscqX0W4MIPCS1B5m8DPUTkcdygANRSEFylUciF6OmAoJzEkhXZiYlGYKemWBmQDRE50CuPzaGhdT26BKxsu/AnnzEL6y1ZtV1VPiOFnseOYQ85GZV0iEaz9hdLd/fkJLOcRsGKbq9/Hw3K21KK9trP9QXCKInz6bJGk58J6RmjGQlMIZUFnqn78NpiZds8f9r8TvubCqMcG2Yco5jQCqbRUpfx3qAECFbW7huEITUS8gQBLSIZxVERsougOSgkAbcF8xPtCf33LUEK/FGuZNlXUY6Ozv8diGCCHrSeUoyDo9Nw+GFqhxYz08I0ml30EhSzC4HcA6AJqzWI5ukN4/LDfbNlaXR0rKnNrZ6mwtN6m9wUtcuEk2n4CpxyUz7Ffn0lPjE88Fu3FHR7gYxEohW+e5nJreXfcUkH7/ttwh+nFTzUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(186003)(86362001)(53546011)(2906002)(5660300002)(83380400001)(33656002)(26005)(8936002)(6506007)(508600001)(52536014)(8676002)(9686003)(4326008)(64756008)(38100700002)(66446008)(55016003)(7696005)(66556008)(122000001)(71200400001)(66476007)(316002)(54906003)(76116006)(66946007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hBZzoRkanFK8wiAPn1btigNBGlQhQfHrnMe/KejyZtyPs+y/3uOwysk1M0kX?=
 =?us-ascii?Q?cX1CSu7NzbAPuItYkw3qgbGWJzTLC3rL0EXL0lUVXpNMKIn+rhU+MWd+M2fp?=
 =?us-ascii?Q?3iCWdvVrQVYmGHflLAPFyfuYjrjA9rynI7gKURITybnqjaNbKH6KBKaJcknQ?=
 =?us-ascii?Q?exjBLV52GM5QaQAsE0TACS7kDUCL8Dp+hWHUh1LZUCrHJijNpLgUsAanHxXY?=
 =?us-ascii?Q?yh7niuuHYkaCdt3RjNbPXhwWqARdr9+7alSqtbRRgtSBmtWF+alinV2xVGW1?=
 =?us-ascii?Q?rn98w+lG5mreygjlJnunXA0ccxznIGQYrJ5QFzmCXn7ZI//hulh2S798LcYw?=
 =?us-ascii?Q?KlINp+iMe3krPC6Qqp9pMtD2tTj8z39aL0EhDviyckPbtoGrzNiMcdjldnWr?=
 =?us-ascii?Q?ngjm2TnuBRTQD3zSFVZf8VBZqFQp47Pbxwz5isF4byPUFo13dhheLptoJTHx?=
 =?us-ascii?Q?fau19Y5vEXSiS6Xx+juKT8mdi74hSVayGPYgXGTSys2ruCugUqJTDKwg9H4o?=
 =?us-ascii?Q?DiMwGFwAc9fNhw9IpIu9s8N4lJDv7H28HNARd0CxA2pJau28mHdFxXO4ytGD?=
 =?us-ascii?Q?lFcDveC6vYyNBJf+S0g8G9Of8wphfaPnXbzDESCDq9k447cu8/rvUBNsaN1T?=
 =?us-ascii?Q?Y6h0RcR/gSV6NJ+24IsPJIwDxL5h8bf3eJO6gKeSTkzZwsP+ZCG5phowoTNO?=
 =?us-ascii?Q?X5KGT//G9Wak9GqjIUFqn2JsUCdN+y3+ellNIzCzSpHdERdkLbC9vB7hgJHJ?=
 =?us-ascii?Q?YLnFbK6xKnmNIsG5VEdrb+pvyvkIoZnI0IFYCb/YoJRRBJIbanuKHMOungSs?=
 =?us-ascii?Q?5fMtbKqp9o4ZzKlkyrb9MQatxmD4n5fSXwae//IXR4k4BAIcFzYVXyIgXqEl?=
 =?us-ascii?Q?5iUCv2bUy4ViXOQFiohijrqYqYsXlIgjc6l2n9DR8qWhQp7oqd2t8VJi6Gjd?=
 =?us-ascii?Q?zunRa0uO6qCDFsRn5bgozxTmztGJVlNKdZMdmJ0B4aGfiNEs1xfpd8Kg5vOk?=
 =?us-ascii?Q?N3DPmqy1xsBzdJ+RR+TEuLNGjSgL+39rK7gt5ejX/e/HumrWfik54Muftj7d?=
 =?us-ascii?Q?GbpZeiWDsCHnDXRqTjD74XgoO75EfyTd39TFtXsMFbGMeNbBcu0jBvC/jnBf?=
 =?us-ascii?Q?yZRlOtjjlCtp6pZGoQzDO3CZjkYJxj0E9xEFeFCAdIzm1DR2dItoUq7dfReY?=
 =?us-ascii?Q?cMx89N+pvfiy0ihpWBRUMCiWzkZvPqZnc7Kub54MHky2X+Q+6cYLpmWaNKGD?=
 =?us-ascii?Q?TPJY/fjT+Ofj2xAt8cQkz/QScUccjyW6RYbXRHTjResd1tbDdVAePAtzQiaG?=
 =?us-ascii?Q?GOyPOEmlypOtUxN4nnkaqWvUZE2TyDpgxEFxK7AbfZnS8+fAJQujuEOkE6fn?=
 =?us-ascii?Q?ED4qOdYfZ53KdzcbyI3iahOl0nNVmSG3OQTlcjGpO1kkl4D3qj1e4BaLvmQ/?=
 =?us-ascii?Q?TFurfcFlqA8A5j0gG6M+0IGEyErxM//BLBVXWejXUB/5YSKcoNEOKcTmzSh4?=
 =?us-ascii?Q?j0ObyPxFzy6HcttpcKhbnwG/ONdyEHHwtW4334Q/q1hJfW+zeD17jmH6/Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78cd8f1-baad-4c5f-defa-08d9f2833141
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 02:05:52.9580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ls5y3YXrJ/fjLTaC/4em4RLdZwwGq1FJ/PFHv2wiJK0l2PSqcQI4msD7swdLoViK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Ah, it's a typo, will re-sent a new patch.

> -----Original Message-----
> From: Liu, Aaron <Aaron.Liu@amd.com>
> Sent: Friday, February 18, 2022 9:56 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
>
> [AMD Official Use Only]
>
> ":" is expected behind "case CHIP_IP_DISCOVERY"
>
> --
> Best Regards
> Aaron Liu
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Prike Liang
> > Sent: Friday, February 18, 2022 9:37 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > Subject: [PATCH] drm/amdgpu: enable TMZ option for onwards asic
> >
> > The TMZ is disabled by default and enable TMZ option for the IP
> > discovery based asic will help on the TMZ function verification.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > index 956cc994ca7d..d2dd526a4c80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -581,6 +581,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device
> > *adev)
> >     case CHIP_NAVI12:
> >     case CHIP_VANGOGH:
> >     case CHIP_YELLOW_CARP:
> > +   case CHIP_IP_DISCOVERY
> >             /* Don't enable it by default yet.
> >              */
> >             if (amdgpu_tmz < 1) {
> > --
> > 2.17.1
