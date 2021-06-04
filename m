Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE6DC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C37613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C37613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB946E3F0;
	Fri,  4 Jun 2021 13:23:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E059F6E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 13:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXnrKOj6WoVvOpY1epMebQcAL8s4IsAX5gfJy+8pk698N4Z/FlgR2YZwzmRNNkAdYjE1mwE9OKO5A7TfFo71t7DnXwUZxn5I1NI5hUSLUGszKjTVTV46YooUhnkkH46ygWbDPY4d3KLkhgxOYxBXtCkx7iJdPxefmA/jqpai/OMg4fXNgdf3u5UE/RkwF1XPtAc+/R2HQawIS5lCkI4iNo5IaztCQiNwYqESoYDIMoeO/DAWIfZzE3sm8GO7iU1fBj0pJhnyNY4rvb5jxRFbEJLOqczoM6Hv+YYeTeKAoYvLg4+zdsk72TzLbNzhaoKK637LPetCi5jJYN20yqw6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu+yK6XuTUB6TMxgMEDWsN+lFjv/jqmTh6GWMmJrbag=;
 b=NLA9IgymPDP8ZPxaIg2Eyr3+Egw/x5gXzV2QU59JTV3Gw934LhGshZg4JwHDnR6BeBGV+Z1D3MJms9f+i55oNGel4cS/i10EpM+QlwdDqGTwBlGYn/Qe5LWkv6EJaDDowDk9vmt+W4oxbBiV9xEt6kMxX8djeJcozHpGBaVxezF7nH2QRBzkzb4ZfCh3W+Wbgtr1H6iZNdetU4mW2CgFmWm+3ba+gAN7A5JZZ24Bq4XQhCT2P6tvddXDznZ8fIqyoMgao/q2PXCZy9HrYDfKcuplyUZkYSm91HWq25z7aNema8BSF0Px6fKkFMVyClSrNCUUdTxIU7Gh+Qwno0rwYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu+yK6XuTUB6TMxgMEDWsN+lFjv/jqmTh6GWMmJrbag=;
 b=XcZB1GjSf5z6vbOSogMakLnrnVl5mgHs21ETArg+38X13FejDRLxFnzxTwKhnPd20PauYy8iFN+II4sU6KUN4pzxCgazuEOQ0O0PamRK9UyvzWviV4Wg1/njwUdfvRP0HJxJU23BMZk2i9tD+foQLhCKVFLhUj4/P6JEEKECS1k=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 13:23:15 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 13:23:15 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Topic: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Index: AQHXWIKb+pWjkPWDaUeLFBGTwcv11KsCY/aAgAColQCAAKfvgIAAIb9Q
Date: Fri, 4 Jun 2021 13:23:14 +0000
Message-ID: <BL1PR12MB531733CB397DBB9AF12C13FBF13B9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
 <befc7f07-613a-d1bd-434a-516035552a79@gmail.com>
In-Reply-To: <befc7f07-613a-d1bd-434a-516035552a79@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=924d5394-35a8-4a83-97a3-7b88aa2e9feb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T13:14:59Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19f01bb0-0214-44f8-836f-08d9275be8d5
x-ms-traffictypediagnostic: BL1PR12MB5285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5285E6D76144FFF115148217F13B9@BL1PR12MB5285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1AHq/4KEcjzUpyFxDq0OxyspzkK33SmX6NX8kt/18Kd1QEoVPcLW0MBdnLHV4qs5Xrsg+Q6e9uymk4VbeOMxeO6iFYa5Rvsoi3GwX7qca3YqCYBU266cc0ZWUqWVqkjniW+EPJotYgZp7mwwOxaHEXQD+oI+mLTcIQK/SFFw75DtTDRKuk+KE9FwKh8QnGCDOh3oKQ2jjktEnm3g8oBkT3eZ8qiYTFBg5uOWI9pww1EzgAxOSca9n1kW7Ce8LBhl3+J3CjZVu1T5kogTRipVYcP08Ldy9ZExnD5Cm3so7CzR64Ri5wuY6j8r+Ms2LTfUOVnlIw+04PLRkCBpFNUel9UeyRVRNG9AOyS18t8al219qkuUJfm1mJV154+rg/yAwUASmMS4fbv8aZ3Qs31EZpPNoRxiD0n+SGBo0nFM0Q0ghWHHzHMJKsCG4JuEXJt/MlXNwj8vB812rzwlvsiHhsKhmfcjnskI1/nU9SrQqc6NDGuIlErRern/pzn4YMhEe0kKdacI2N6sARaR7nxUy87PBtoswBr0FShVMI7qLHUuR1KCD8kK/OjFVq0Yb5MqtRZGvgPBpNycuuIltLGsIqpEaXZA7Rj+OC4U0OyVRNfa4Z7vjupKPZ8N12LsfHkRAO+5DJdmj4uO7gBneengt1/stvmaZUVyCqrr0y+cupkTKabe/BVpUNQbA36xbTs6uDMgkpDMABnjSfhIqamzAd0kKEARkWS0TCFuv7QL0upO9xgwv4eXduWklMTHM34
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(376002)(396003)(346002)(366004)(76116006)(122000001)(52536014)(186003)(26005)(71200400001)(66446008)(45080400002)(8936002)(8676002)(508600001)(66946007)(110136005)(64756008)(66556008)(66476007)(83380400001)(55016002)(2906002)(9686003)(38100700002)(6506007)(53546011)(86362001)(966005)(33656002)(5660300002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?J/9peLfJGbnMSg2Gh9kN783uPgdFZSsIcOC5yRF+N6YDd/xImZa2v7zedw?=
 =?iso-8859-1?Q?GwYlaR1KqaGlHIZyEoAYJND/OyivKH+MuWxYMn6KIDnyKvQEG6t3p15CqU?=
 =?iso-8859-1?Q?c6kflQq2AsokU74XyLuo+LAz3iOHyK6NhTlgU6nB1Pa2zTkNhitGrwf+54?=
 =?iso-8859-1?Q?nRg+tlA2WlctqIkllxHcMWPxiOOoCiBj/NoA/ywsGNxp6w4dXuh9efW8ea?=
 =?iso-8859-1?Q?bZaNCGJpCErnqbQ301VJFPI92KuxapyWKSz1lBTEmQq1VYISpRNBcHBBYR?=
 =?iso-8859-1?Q?MVHz4DOzUiIVrj1SGYNsyYFluWTkvhnW3nV9X1K7Isapy5cYGCNibNGGyc?=
 =?iso-8859-1?Q?PbkG2jhylqFVVAWuIjrp6wPSQngkvs/ekiiIKV9tNlnODXSIBMiotHrtjQ?=
 =?iso-8859-1?Q?O1CrqDnfD3LLUesVLmM+8KESjTB2X33DO5WAaH9tbbo/SX5fhDgX87RhuK?=
 =?iso-8859-1?Q?EfBMvMUL+L45mPXsC4dA3EKr2uPibiORQ7QGNzBYvL6W4zhy4brO2eHTRl?=
 =?iso-8859-1?Q?xoOdEUJ3vDB+TriPJtjNVPlPAmHIsJKtF0lHhTrKGoXiIot1AK3s3a4NXX?=
 =?iso-8859-1?Q?gTLtgw/Te9H5BodEjkglH3ZFekh319nKLRRoSKMRoWNGXLk0osSPpm0Fk3?=
 =?iso-8859-1?Q?JlfrHq29KAQn+cAuYDiEuYIpD/l+wIu2BVq1WyHgDae0XZwZWUr24BOADN?=
 =?iso-8859-1?Q?N9Vz3g2wd+QtxOGI2IpA+cuZeKRtEKUw77CQ2owY9IeZGkFT870TCi6Y+0?=
 =?iso-8859-1?Q?gP3MNStU6FT/ZXRgdtYfmklAXdDL7LO0gVrdef3HF52HCjE0bATgUSTxDf?=
 =?iso-8859-1?Q?qpatxD+KxFb3176sLboRcQBJoovY9wEKHr5PaWn49iyJ0YWUZXWiSSGkyQ?=
 =?iso-8859-1?Q?2iDr6WxcoCG/MTpbywUEy2EB05U4zGsN1rk/mR84gIVzCTIhWr+c6h8HNY?=
 =?iso-8859-1?Q?20tNuC2+LGhkbqnBqlrtdWMVaRxSEuFj8x9ybIVQaxUuBa+5ZB8TvDPK6i?=
 =?iso-8859-1?Q?sWyhmHSbcs/VBpKq/n3zQbPMEv/c4yn6HIOUFgCbpxpOZiDHLfb2WXqx77?=
 =?iso-8859-1?Q?xlGZ/YMOcxhhi79Uwn6JH17SKwDBuy5P37Qw5GuQLY1T1okaHkIqj42g+A?=
 =?iso-8859-1?Q?rSYrlu1xx/ATGi+THEIVHsOIBB3MJhrP+fca+E/Ps9b2L03gfEUgKHCyGe?=
 =?iso-8859-1?Q?pxkm25bzDf4nZUWepmnvZIKj8wHnYzFzol9XN1D5jzLDKytdix1cXYRRwH?=
 =?iso-8859-1?Q?mwWWM5D/oNjjNK/gN62Zmy4KenGZNRWgYlwkY3lwy9ewBtc39WMLbGnG3T?=
 =?iso-8859-1?Q?d32mxAmBZk4SnNTxAlFWEzGlf2vEomci2/IgS5s0DeOAVEI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f01bb0-0214-44f8-836f-08d9275be8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 13:23:15.0484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DCbVuvIRfiGk6c5U660AEcp2gQlAVxTxmBFwDNDSjxgF8y7pHSG+WRtqOXu01TW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Here is our hypervisor driver compatibility policy:
        - Host.y supports Guest.y-1, Guest.y, Guest.y+1
        - Guest.y supported by Host.y-1, Host.y,Host.y+1

Host driver had the feature for gfx9 2 years ago. So, this change meet our =
compatibility policy.

Thanks,
Zhigang

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: June 4, 2021 7:14 AM
To: Deng, Emily <Emily.Deng@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; L=
uo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting =
fb location

I was just about to question the same thing.

It looks really good to me to have that cleaned up, but if this breaks with=
 older versions of the hypervisor then it is a bit questionable change.

Regards,
Christian.

Am 04.06.21 um 03:13 schrieb Deng, Emily:
> Do we need to consider backward compatibility?
>
>
> Best wishes
> Emily Deng
>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Liu, Shaoyun
>> Sent: Thursday, June 3, 2021 11:10 PM
>> To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>> Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from
>> getting fb location
>>
>> [AMD Official Use Only]
>>
>> Looks ok to me .
>>
>> Reviewed-By : Shaoyun.liu <shaoyunl@amd.com>
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Zhigang Luo
>> Sent: Thursday, June 3, 2021 10:13 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>> Subject: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from
>> getting fb location
>>
>> host driver programmed fb location registers for vf, no need to check an=
ymore.
>>
>> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +----
>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index ceb3968d8326..1c2d9fde9021 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1292,10 +1292,7 @@ static int gmc_v9_0_late_init(void *handle)
>> static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>>                                      struct amdgpu_gmc *mc)
>> {
>> -    u64 base =3D 0;
>> -
>> -    if (!amdgpu_sriov_vf(adev))
>> -            base =3D adev->mmhub.funcs->get_fb_location(adev);
>> +    u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>>
>>      /* add the xgmi offset of the physical node */
>>      base +=3D adev->gmc.xgmi.physical_node_id * adev-
>>> gmc.xgmi.node_segment_size;
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> ts.fre
>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNsz
>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=3D0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> ts.fre
>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNsz
>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CZh
> igang.Luo%40amd.com%7C9b87dfa195ed4e84a8c808d92749e416%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637584020581460118%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=3D3S6ZEnCCMHHlfc%2B6xmLDz7Bgn91Is7EIpMS7WRxq0Jo%3D&amp;
> reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
