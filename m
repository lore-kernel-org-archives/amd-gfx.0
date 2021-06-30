Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB59C11F67
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06E161D3D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06E161D3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F6A89CDE;
	Wed, 30 Jun 2021 03:26:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693DD89CDE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 03:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrT7QesjpEkZ90/2WN20P+X/1Qpi9DEBhP3wwU/8LeMtbrOF83w3t0LgG3tSUoDjFZ05v8Iuycti69uFvUFdf5FTubxvPvbHGhQ//L/b+zagS7vFOgp0d8NDewmYxrC4p6kQYOuGe3OpOe87XNeXBuvl29OGHB+NI5erqGFfkPS8Qfx7hAJ3HkqpWlUU7USsdrRzunrKy5nABdvcuxI+9Q7WBJ+hBUuks49ACDSWCQlElkZV5ZFnuIa/IaWXWyb2a/4JxGRlpgCqAnllm5cNgX0vhohNnPNoq9c/hME/GOloHxGbla6qRj//FXcqlZ6z+zPOSDnuOaR5uBRNCnjTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eN0FM+IoZCEVQuYPVKZS7g2Mo442jDujCqfeE8RF9w=;
 b=A8KJodeBr3JOErHFWF5WsYu8Jmx/RDryygfeHeMLbebrWuIFSwYkgI+mVfJhM1Z+vhte7DcsANNqMncjh++vGTvWRyh9x+DFkUL3RQHHCDxpBI/pgNEFZ89rwzZFQKWmokvwBnNiVz9HZt8pQ2HO0fE8iToeIeUvqv04gASEV9WwuzeB7RWDfyexQ9ixvtVAisIaB1BeE9LdiiNESboAWxSaETarNY6W5WgW//8t/nRjDcDF9VPOctSveGK0n3PteIFRpYzgklN3h560Bfq8/WEVNnblmsr37+U/PXNuapCx5nd2WVuMGPQe+48HD97Bf/kcSUGTSMBAiLyKDU6SOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eN0FM+IoZCEVQuYPVKZS7g2Mo442jDujCqfeE8RF9w=;
 b=hgTKFPg8ft+u8ZCVwqA27zEQYwTgZcjaLNrdnZo9IFFuXjGrN1WNompX1IQl/993JBxtwS0VFttHYpN+yymBbaMN1jReQ8Wl7LlFjUb+1RWQX75zefcVihrOzFMk/1lfueXe6bodgXVzuw+1MrQzm92ecpk25c2ZDDL5Vdh3GL4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 30 Jun 2021 03:26:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 03:26:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Topic: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
Thread-Index: AQHXaZnS3tnW57ggTUOcbwWfISbVqKsrBOCAgADleEA=
Date: Wed, 30 Jun 2021 03:26:04 +0000
Message-ID: <DM6PR12MB2619CF378B8CDD0856459A29E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210625081203.978006-1-evan.quan@amd.com>
 <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
In-Reply-To: <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-30T03:26:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bb280243-9fda-4bc1-aea2-dbb9615d2cbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2294b73-0fba-42e2-5875-08d93b76cab0
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB308370FEE51C815FEF25B0D5E4019@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/2T72V2wFmvbYBPIlijM98bfadMY9XVJYjezB9Q6ff3FMzgGF8iubfN2GkrqEEZudIQU7FkTkS+3gn6gMhx/KfnjhnYNZkV2KVxEoqBTYMMm+ZTCcakhCV7b+O4V4ar2CmR5axfuRi4K3dhP6McDqo0zltxjXA3O49JnCENZQyKZiAKE0MDzYXJ7v0EQ/MRlVSdenRmveaupyqaYMrBfd8ad//F2l4POT6Qw9TGudiyyoobtw4SxgcS+dTUZQ5igkQJLykxmaIVtrrmg4A9SAm5knWaPTnhRP2ASWvHf4Om7BxbwICbTvi/+fV6munvDrbVYqJPn0AVXOt2w0X41zFKKORtMTt60iYW8mBoMG8ggX/V5Q3wxYeAuKEcDsLSuLBNP9XQwMUeSf+oDZH/ONnh9p32ODsOsK+myBKhWkPBgvCUogULGsLH8QOK26UZFBRdS/Obu1NLg3aUcET9cIQStgiERpkSljtkWL2nAUjXXPag3G+LnQMxRE2wuGkHWFITR6bLFPy7Yaa5wsk7kbAoHuRsN3L1hysgoisVC3OZ6AKuUSFEn8qTLYUmENVPrKiHPVBYli5pzpguOrNppxu/63BhCmVQ2IcOvbwijWWZlLbvAhnmlT9NcyI4Ckt9fN9MyJXoLsHHlU/qzcDzGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(71200400001)(8676002)(26005)(122000001)(38100700002)(30864003)(19627235002)(7696005)(110136005)(53546011)(316002)(8936002)(6506007)(5660300002)(33656002)(52536014)(55016002)(66476007)(83380400001)(86362001)(66446008)(2906002)(478600001)(9686003)(64756008)(66946007)(4326008)(186003)(66556008)(15650500001)(76116006)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzBCTzdHVVRyUE1jaFFNV0hiV2lpOWE0enFzclA2SlBnanlINHFzRjFoMTNX?=
 =?utf-8?B?YndOV1FSc2ltc3MvbjVLZkZTQVpITlZtN1g5SFQ0aURWTUtkUkFSWXAyYnlZ?=
 =?utf-8?B?ZkZjWnNhNDV0by9OdVpieXJ1eDZIZVJQSVhzc2QyRHR2eTk0UHVqSGFWL3pR?=
 =?utf-8?B?eVVrYlJnNkF4YmZ2OGVJZHdKVW14QzR4S0VzcXVSUzRScGpjSXZjMXI3SnRz?=
 =?utf-8?B?eVBYTi9LNm8rbWVsQUcwL3Y2RG5IOTJWYmxTTVQrYisyWVUvT3ljRDhoQ1h4?=
 =?utf-8?B?aXdyUk5jdkZISWdkK3kyTE5Rbjd2WU1UWGFhaTFkTFV5V0trNzJyT3lISVZm?=
 =?utf-8?B?eG5tU2g0anFxUy9OT1FFSFZ0OXhpR21KMDZueDRlTkJXc01GMm9DQlNEalZZ?=
 =?utf-8?B?ZlV3NnY5WEMycEdBWi9SWExVMFRPaHFld3E4bHpON0JGZ2lJOHppWldVc1h0?=
 =?utf-8?B?bm1QeWh3d0Y3WnQvbmEyZmxVK2RFRUszUVZpK2NBajRPWUxWQXFqaGo0Njdv?=
 =?utf-8?B?Rys1VGJ0V3JRaU15VVovTEE2SDJaTmh4TkNLY1hPNm53dUhvd3lrNVBaajh0?=
 =?utf-8?B?SXVtV1k4V1ptdGt0SWx6Nkx0Y05QaVVMdFdNbVFsVStJRllRZnh4QUMxcFU4?=
 =?utf-8?B?c3QxTFdQb3V6d2l1MHNZckptc3dETmw4NWE1ZXVEMmxqMHJENWp0RjZwUTFU?=
 =?utf-8?B?eWF3bnNLSWIyYzYwdklEcDZDdlIrWGtRbzhQRUFGbXN2QTJWU3VCNk05STFr?=
 =?utf-8?B?VXpQOFloYlVoQk94d1VYZjNIK1N1S1oycWtYbm5hSzJvQUFKbng4UkpRNXpt?=
 =?utf-8?B?cURtalhBYkp2ZzJzQ2oyZEptZlRZWDRXNENmMmpyNUdONmxzdXYweW9VbFo0?=
 =?utf-8?B?L3ZscEQrUjd2YUJBdXVwQVpkWU9KSFhtQWtlV2FzdmR6NCttS3RNMVpoUHA1?=
 =?utf-8?B?N1g5a0NCN3FNN01vaVloOHY2Vks1WGViZ1AvSGVsZ1ZockVnQ0RDYm1YVjU5?=
 =?utf-8?B?R1FSOVdNdjh1K0Mra3ZxS3p2ZEFpeVczbnVwRW1SL3dwNjFTWmwxNUtXWUtJ?=
 =?utf-8?B?dVBzejdMS05YWjNlRjdvdXh0Z3hXYm1nMzNKTjIrNHl1cy85YjZJeG4xOXdm?=
 =?utf-8?B?TU1ZaWdqc3hlZ004Ulg1b1lSdGc1bDhyUURIWlFBL0RuRDFtWnp0Tk1WaU5T?=
 =?utf-8?B?bUhDV1ZoWXJzQ3VDNTgzNURlUmZhWG1RVHRyUFVvNHJkZmEvaE85UERuN0Z6?=
 =?utf-8?B?RjBHWEhnbkc4L083RlJ4WmgzdWhSZS9Bdk4rdlZrblBoYVlMMWZmQzMzSWll?=
 =?utf-8?B?bUlLZCtnWFNiSTgwWkF5bnRFN0ZoQTV3dEZiNzVDbHEvTzVsVXNHcVlXTm5E?=
 =?utf-8?B?N3d3dFJzaTR0TjkrM1k2RHdvNTRGMVc4VVlrdHYvOEJoc2dkVVRFekhKQkRZ?=
 =?utf-8?B?bk1vUVYzVlZZelpiRzhDd3RuUEJzMGxDeFBKYnNsZXpGQm8zQjFkTWhqRHBP?=
 =?utf-8?B?QTZjTmNOOUZ0VkFpRGpod2ZiQi80WHBKdXUvbXA4VFlDa29henI2OHJvNk9K?=
 =?utf-8?B?ZnBaMStya1NnL1NLS085eVNiUnl6Sm9Ia3g3cUtFYmRDZUM0U2w3aXZ2WDhE?=
 =?utf-8?B?Vk5YRkJLQU9hUDVwMmN2dUFkVkpPRmY2b3VNY0UrdWRUYW1ZeVVFeDArN0FI?=
 =?utf-8?B?Rms3dGo5OFZNN2JVSSsvYWdOVTg5RDRzSHRVUWNWSGt1K1Jtaks5bGpWR3My?=
 =?utf-8?Q?OWUIDW+hXSZfREec+LvSH9H7iw9d9+Sem0FcR0C?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2294b73-0fba-42e2-5875-08d93b76cab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 03:26:04.1270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPn3d2RB852n2U+dDeZpP476f5hQlFJx9vIhQLBHGSwM7k4DS/c4T+lNer3oUgF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, June 29, 2021 9:38 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
> retrieving for Sienna Cichlid
> 
> 
> 
> On 6/25/2021 1:42 PM, Evan Quan wrote:
> > Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
> > uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
> >
> > Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >   .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
> >   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234 ++++++++++++---
> ---
> >   2 files changed, 222 insertions(+), 75 deletions(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> > b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> > index 61c87c39be80..0b916a1933df 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> > @@ -211,6 +211,7 @@ typedef enum {
> >   #define THROTTLER_FIT_BIT          17
> >   #define THROTTLER_PPM_BIT          18
> >   #define THROTTLER_APCC_BIT         19
> > +#define THROTTLER_COUNT            20
> >
> >   // FW DState Features Control Bits
> >   // FW DState Features Control Bits
> > @@ -1406,7 +1407,67 @@ typedef struct {
> >   } SmuMetrics_t;
> >
> >   typedef struct {
> > -  SmuMetrics_t SmuMetrics;
> > +  uint32_t CurrClock[PPCLK_COUNT];
> > +
> > +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
> > + AverageGfxclkFrequencyPostDs;  uint16_t AverageFclkFrequencyPreDs;
> > + uint16_t AverageFclkFrequencyPostDs;  uint16_t
> > + AverageUclkFrequencyPreDs  ;  uint16_t AverageUclkFrequencyPostDs  ;
> > +
> > +
> > +  uint16_t AverageGfxActivity    ;
> > +  uint16_t AverageUclkActivity   ;
> > +  uint8_t  CurrSocVoltageOffset  ;
> > +  uint8_t  CurrGfxVoltageOffset  ;
> > +  uint8_t  CurrMemVidOffset      ;
> > +  uint8_t  Padding8        ;
> > +  uint16_t AverageSocketPower    ;
> > +  uint16_t TemperatureEdge       ;
> > +  uint16_t TemperatureHotspot    ;
> > +  uint16_t TemperatureMem        ;
> > +  uint16_t TemperatureVrGfx      ;
> > +  uint16_t TemperatureVrMem0     ;
> > +  uint16_t TemperatureVrMem1     ;
> > +  uint16_t TemperatureVrSoc      ;
> > +  uint16_t TemperatureLiquid0    ;
> > +  uint16_t TemperatureLiquid1    ;
> > +  uint16_t TemperaturePlx        ;
> > +  uint16_t Padding16             ;
> > +  uint32_t AccCnt                ;
> > +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> > +
> > +
> > +  uint8_t  LinkDpmLevel;
> > +  uint8_t  CurrFanPwm;
> > +  uint16_t CurrFanSpeed;
> > +
> > +  //BACO metrics, PMFW-1721
> > +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
> > + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> > +
> > +  //PMFW-4362
> > +  uint32_t EnergyAccumulator;
> > +  uint16_t AverageVclk0Frequency  ;
> > +  uint16_t AverageDclk0Frequency  ;
> > +  uint16_t AverageVclk1Frequency  ;
> > +  uint16_t AverageDclk1Frequency  ;
> > +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full
> sequence
> > +  uint8_t  PcieRate               ;
> > +  uint8_t  PcieWidth              ;
> > +  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
> > +
> > +} SmuMetrics_V2_t;
> > +
> > +typedef struct {
> > +  union {
> > +    SmuMetrics_t SmuMetrics;
> > +    SmuMetrics_V2_t SmuMetrics_V2;
> > +  };
> >     uint32_t Spare[1];
> >
> >     // Padding - ignore
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 0c3407025eb2..f882c6756bf0 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -80,6 +80,13 @@
> >   		(*member) = (smu->smu_table.driver_pptable +
> offsetof(PPTable_t, field));\
> >   } while(0)
> >
> > +#define GET_METRICS_MEMBER(field, member) do { \
> > +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu-
> >smc_fw_version >= 0x3A4300)) \
> > +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu-
> >smu_table.metrics_table))->SmuMetrics_V2)) + offsetof(SmuMetrics_V2_t,
> field)); \
> > +	else \
> > +		(*member) = ((void *)(&(((SmuMetricsExternal_t
> > +*)(smu->smu_table.metrics_table))->SmuMetrics)) +
> > +offsetof(SmuMetrics_t, field)); \ } while(0)
> > +
> >   static int get_table_size(struct smu_context *smu)
> >   {
> >   	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) @@ -489,13
> +496,33 @@
> > static int sienna_cichlid_tables_init(struct smu_context *smu)
> >   	return -ENOMEM;
> >   }
> >
> > +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
> > +smu_context *smu) {
> > +	struct smu_table_context *smu_table= &smu->smu_table;
> > +	SmuMetricsExternal_t *metrics_ext =
> > +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
> > +	uint32_t throttler_status = 0;
> > +	int i;
> > +
> > +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
> > +	     (smu->smc_fw_version >= 0x3A4300)) {
> > +		for (i = 0; i < THROTTLER_COUNT; i++) {
> > +			if (metrics_ext-
> >SmuMetrics_V2.ThrottlingPercentage[i])
> > +				throttler_status |= 1U << i;
> > +		}
> > +	} else {
> > +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
> > +	}
> > +
> > +	return throttler_status;
> > +}
> > +
> >   static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> >   					       MetricsMember_t member,
> >   					       uint32_t *value)
> >   {
> > -	struct smu_table_context *smu_table= &smu->smu_table;
> > -	SmuMetrics_t *metrics =
> > -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
> >SmuMetrics);
> > +	uint32_t *data_u32;
> > +	uint16_t *data_u16;
> >   	int ret = 0;
> >
> >   	mutex_lock(&smu->metrics_lock);
> > @@ -510,78 +537,100 @@ static int
> > sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
> >
> >   	switch (member) {
> >   	case METRICS_CURR_GFXCLK:
> > -		*value = metrics->CurrClock[PPCLK_GFXCLK];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> 
> One problem with this style is the need to track the datatype of each field.
> Why not use the old style?
> 
> metricsv1? metricsv1->field : metricsv2->field; 
[Quan, Evan] With that, there will be too many "if{}else{}".  Also I see there seems coming some new changes for the metrics table. I'm afraid the situation will be worse in the further.
With this macro way, we can keep the code clean and tidy.

BR
Evan
> 
> Thanks,
> Lijo
> 
> > +		*value = data_u32[PPCLK_GFXCLK];
> >   		break;
> >   	case METRICS_CURR_SOCCLK:
> > -		*value = metrics->CurrClock[PPCLK_SOCCLK];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_SOCCLK];
> >   		break;
> >   	case METRICS_CURR_UCLK:
> > -		*value = metrics->CurrClock[PPCLK_UCLK];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_UCLK];
> >   		break;
> >   	case METRICS_CURR_VCLK:
> > -		*value = metrics->CurrClock[PPCLK_VCLK_0];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_VCLK_0];
> >   		break;
> >   	case METRICS_CURR_VCLK1:
> > -		*value = metrics->CurrClock[PPCLK_VCLK_1];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_VCLK_1];
> >   		break;
> >   	case METRICS_CURR_DCLK:
> > -		*value = metrics->CurrClock[PPCLK_DCLK_0];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_DCLK_0];
> >   		break;
> >   	case METRICS_CURR_DCLK1:
> > -		*value = metrics->CurrClock[PPCLK_DCLK_1];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_DCLK_1];
> >   		break;
> >   	case METRICS_CURR_DCEFCLK:
> > -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_DCEFCLK];
> >   		break;
> >   	case METRICS_CURR_FCLK:
> > -		*value = metrics->CurrClock[PPCLK_FCLK];
> > +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +		*value = data_u32[PPCLK_FCLK];
> >   		break;
> >   	case METRICS_AVERAGE_GFXCLK:
> > -		if (metrics->AverageGfxActivity <=
> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> > -			*value = metrics->AverageGfxclkFrequencyPostDs;
> > +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> > +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> > +
> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> &data_u16);
> >   		else
> > -			*value = metrics->AverageGfxclkFrequencyPreDs;
> > +
> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	case METRICS_AVERAGE_FCLK:
> > -		*value = metrics->AverageFclkFrequencyPostDs;
> > +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs,
> &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	case METRICS_AVERAGE_UCLK:
> > -		*value = metrics->AverageUclkFrequencyPostDs;
> > +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs,
> &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	case METRICS_AVERAGE_GFXACTIVITY:
> > -		*value = metrics->AverageGfxActivity;
> > +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	case METRICS_AVERAGE_MEMACTIVITY:
> > -		*value = metrics->AverageUclkActivity;
> > +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	case METRICS_AVERAGE_SOCKETPOWER:
> > -		*value = metrics->AverageSocketPower << 8;
> > +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> > +		*value = *data_u16 << 8;
> >   		break;
> >   	case METRICS_TEMPERATURE_EDGE:
> > -		*value = metrics->TemperatureEdge *
> > +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> > +		*value = *data_u16 *
> >   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >   		break;
> >   	case METRICS_TEMPERATURE_HOTSPOT:
> > -		*value = metrics->TemperatureHotspot *
> > +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> > +		*value = *data_u16 *
> >   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >   		break;
> >   	case METRICS_TEMPERATURE_MEM:
> > -		*value = metrics->TemperatureMem *
> > +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> > +		*value = *data_u16 *
> >   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >   		break;
> >   	case METRICS_TEMPERATURE_VRGFX:
> > -		*value = metrics->TemperatureVrGfx *
> > +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> > +		*value = *data_u16 *
> >   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >   		break;
> >   	case METRICS_TEMPERATURE_VRSOC:
> > -		*value = metrics->TemperatureVrSoc *
> > +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> > +		*value = *data_u16 *
> >   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> >   		break;
> >   	case METRICS_THROTTLER_STATUS:
> > -		*value = metrics->ThrottlerStatus;
> > +		*value = sienna_cichlid_get_throttler_status_locked(smu);
> >   		break;
> >   	case METRICS_CURR_FANSPEED:
> > -		*value = metrics->CurrFanSpeed;
> > +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> > +		*value = *data_u16;
> >   		break;
> >   	default:
> >   		*value = UINT_MAX;
> > @@ -3564,68 +3613,103 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >   	struct smu_table_context *smu_table = &smu->smu_table;
> >   	struct gpu_metrics_v1_3 *gpu_metrics =
> >   		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> > -	SmuMetricsExternal_t metrics_external;
> > -	SmuMetrics_t *metrics =
> > -		&(metrics_external.SmuMetrics);
> > -	struct amdgpu_device *adev = smu->adev;
> > -	uint32_t smu_version;
> > +	uint32_t *data_u32;
> > +	uint16_t *data_u16;
> > +	uint8_t *data_u8;
> >   	int ret = 0;
> >
> > -	ret = smu_cmn_get_metrics_table(smu,
> > -					&metrics_external,
> > -					true);
> > -	if (ret)
> > +	mutex_lock(&smu->metrics_lock);
> > +
> > +	ret = smu_cmn_get_metrics_table_locked(smu,
> > +					       NULL,
> > +					       true);
> > +	if (ret) {
> > +		mutex_unlock(&smu->metrics_lock);
> >   		return ret;
> > +	}
> >
> >   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
> >
> > -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
> > -	gpu_metrics->temperature_hotspot = metrics-
> >TemperatureHotspot;
> > -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
> > -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
> > -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
> > -	gpu_metrics->temperature_vrmem = metrics-
> >TemperatureVrMem0;
> > +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> > +	gpu_metrics->temperature_edge = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> > +	gpu_metrics->temperature_hotspot = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> > +	gpu_metrics->temperature_mem = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> > +	gpu_metrics->temperature_vrgfx = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> > +	gpu_metrics->temperature_vrsoc = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
> > +	gpu_metrics->temperature_vrmem = *data_u16;
> >
> > -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> > -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> > -	gpu_metrics->average_mm_activity = metrics-
> >VcnActivityPercentage;
> > +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> > +	gpu_metrics->average_gfx_activity = *data_u16;
> >
> > -	gpu_metrics->average_socket_power = metrics-
> >AverageSocketPower;
> > -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
> > +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> > +	gpu_metrics->average_umc_activity = *data_u16;
> >
> > -	if (metrics->AverageGfxActivity <=
> SMU_11_0_7_GFX_BUSY_THRESHOLD)
> > -		gpu_metrics->average_gfxclk_frequency = metrics-
> >AverageGfxclkFrequencyPostDs;
> > +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
> > +	gpu_metrics->average_mm_activity = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> > +	gpu_metrics->average_socket_power = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
> > +	gpu_metrics->energy_accumulator = *data_u32;
> > +
> > +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> > +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> > +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
> &data_u16);
> >   	else
> > -		gpu_metrics->average_gfxclk_frequency = metrics-
> >AverageGfxclkFrequencyPreDs;
> > -	gpu_metrics->average_uclk_frequency = metrics-
> >AverageUclkFrequencyPostDs;
> > -	gpu_metrics->average_vclk0_frequency = metrics-
> >AverageVclk0Frequency;
> > -	gpu_metrics->average_dclk0_frequency = metrics-
> >AverageDclk0Frequency;
> > -	gpu_metrics->average_vclk1_frequency = metrics-
> >AverageVclk1Frequency;
> > -	gpu_metrics->average_dclk1_frequency = metrics-
> >AverageDclk1Frequency;
> > -
> > -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
> > -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
> > -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
> > -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
> > -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
> > -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
> > -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
> > -
> > -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
> > +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
> &data_u16);
> > +	gpu_metrics->average_gfxclk_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
> > +	gpu_metrics->average_uclk_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
> > +	gpu_metrics->average_vclk0_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
> > +	gpu_metrics->average_dclk0_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
> > +	gpu_metrics->average_vclk1_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
> > +	gpu_metrics->average_dclk1_frequency = *data_u16;
> > +
> > +	GET_METRICS_MEMBER(CurrClock, &data_u32);
> > +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
> > +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
> > +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
> > +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
> > +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
> > +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
> > +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
> > +
> > +	gpu_metrics->throttle_status =
> > +			sienna_cichlid_get_throttler_status_locked(smu);
> >   	gpu_metrics->indep_throttle_status =
> > -			smu_cmn_get_indep_throttler_status(metrics-
> >ThrottlerStatus,
> > +			smu_cmn_get_indep_throttler_status(gpu_metrics-
> >throttle_status,
> >
> sienna_cichlid_throttler_map);
> >
> > -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
> > +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> > +	gpu_metrics->current_fan_speed = *data_u16;
> >
> > -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> > -	if (ret)
> > -		return ret;
> > +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu-
> >smc_fw_version > 0x003A1E00) ||
> > +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu-
> >smc_fw_version > 0x00410400)) {
> > +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
> > +		gpu_metrics->pcie_link_width = *data_u8;
> >
> > -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version >
> 0x003A1E00) ||
> > -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version >
> 0x00410400)) {
> > -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
> > -		gpu_metrics->pcie_link_speed = link_speed[metrics-
> >PcieRate];
> > +		GET_METRICS_MEMBER(PcieRate, &data_u8);
> > +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
> >   	} else {
> >   		gpu_metrics->pcie_link_width =
> >
> 	smu_v11_0_get_current_pcie_link_width(smu);
> > @@ -3633,6 +3717,8 @@ static ssize_t
> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >
> 	smu_v11_0_get_current_pcie_link_speed(smu);
> >   	}
> >
> > +	mutex_unlock(&smu->metrics_lock);
> > +
> >   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
> >
> >   	*table = (void *)gpu_metrics;
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
