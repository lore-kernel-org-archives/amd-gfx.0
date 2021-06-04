Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A0C47098
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B0D61404
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 14:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B0D61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 463616EC0A;
	Fri,  4 Jun 2021 14:06:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99376EC2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 14:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=busA9n824Fw47oXm5Ja17TwXn4k964aE0DeboL+jmpoxyXDusVpYdtaE45ASvH9pwz3hfXZ/jnfp/mMi3QL2v8y+kknzGj+8fbYcBLKPkBw6Gwlt13KaV1Mwnn38+UCPaDNKQphImtK8HNsAGtBCJt55Xu45EDeqC5W5DwPdzo8iXbq2hiQEH4Mflcr0QkFxdypE/OEYXXYUk+seTm5atxL4AlcZqvt7QSKWRW+3eM1QBSV7QOvXXoxu6iMpSCFJ+7m7VsiY8kkOROkKQypYOmV+W4NDGylwzW5eO8+fusX91eIH5D7G759N34Y0pr+nT5CYOZju95YKFtPKviBuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJwPVWGnPNsqvy4lED+I4S+XrwqjBRMmy7yxBeJUUjM=;
 b=X/0mXqDBDX4nl1+zqFgRjtBPzsI3F6IwVx53pdMT6CYszFoBFQabGR6pKBQLj4ha8UDlBYlIsWPq1XsXwogCn16abUU4E7OZd3CVpmtWfZ7iyOAKYyZjTaXihe86sBgETgXe/Da5v4omOyVSj614e1fx/84AqwRtw7mJ8/mYwHvnb7B2uyxYmWJtNB/JRRTu3/x1xVluOUgO+q7tKo7TAv2jo4Xj5Rdg1DjE8Byan2WRl0J+YNoz1B/bDeWrO0zRalZus3QpA8qcWxxc5SVRhjOawN4U9zdEFrzKM1HcCsW00Y2bNplbcwVK0X5KL5hDeq7FHor2TIaNTKZWyKKONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJwPVWGnPNsqvy4lED+I4S+XrwqjBRMmy7yxBeJUUjM=;
 b=rp6Me7IXPzOucvAGOc6uw/BgeWNv2+W199qrGjnvn2foNWLF7VY/QvOTYZpVPQDlXoX++Jl4MuUqNWsws8U6FERH8sTwV8rfveF2kn//+h0k4/DvmiByPbsNfbjJ4zjY82Y+Wn9i3pG5JsQxPttT+tE869KpSFNm54I6gQ4iWh4=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:06:08 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:06:08 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Topic: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
Thread-Index: AQHXWIKb+pWjkPWDaUeLFBGTwcv11KsCY/aAgAColQCAAKfvgIAAIb9QgAAIugCAAAC6AA==
Date: Fri, 4 Jun 2021 14:06:08 +0000
Message-ID: <BL1PR12MB53175232AF244672831AB84EF13B9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
 <befc7f07-613a-d1bd-434a-516035552a79@gmail.com>
 <BL1PR12MB531733CB397DBB9AF12C13FBF13B9@BL1PR12MB5317.namprd12.prod.outlook.com>
 <0126c234-be22-f615-d9ad-c671e615cb37@gmail.com>
In-Reply-To: <0126c234-be22-f615-d9ad-c671e615cb37@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=15d84d45-58a4-43c9-adf7-8fa64ef3e485;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T13:48:50Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da2d1767-b8cf-4779-a657-08d92761e6ce
x-ms-traffictypediagnostic: BL1PR12MB5239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB52390A93E59073962DB1D108F13B9@BL1PR12MB5239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7sQ1X8qT33mdNXiPqwGMVeHQeD2KAW3KAvu87DwcHgcnpIU8LjV95fd9INs5NK3R6WUB+em6CpvjqpkuyQmUWiXCspEVuDXgsoQ4x0Cymt20RM+G4FZMi38hD/BhD/gh0iSxV5HzPtWEQhON2+QGiF6oH9YWiJT03ZOmmI9q1cW2HGZN1dXN6W5yNH6dO4lV7aUfIOBmmtVn/FkWnNLf1/LwR21NCdBpoS1xXrVxTIGveSmrzoXGnVxUpdLrAk24j2fLzcYsozaaSEMhnfwtnQfeGCL9rEkqm4mnyypj3kFndCmuCGgZssKvzBf2ETLHHyqHn6Gsj4Q9BNuOK55f5THysN1QBtFfJZkJLXKPtLDcbPw9wGloRs2YTe2oidCyInPeBn+FnYMsAro9o06nplVPO1QV/vtGFtvOgR4kxvYBcMAEpOTpdoRbEZEpL99elPV729FkbLfRiXlR6hBWPGtE5MmhiiiUOynPMXwh5vs6LMo2o9trkU6qC+CMKKzMF/dMwBrx78wID1CRoT2va899lsPyjR2kYpw+Xv4q3JTqP4rJYSD0skPb+OXoN9z33OA61/J9ewuAih7xPelqhHtYWNOSrbC/lIvgG1Fs5zTYIAjbBbgzc65ilFWIKF20ygYX4LatYwRX2M1/kkYBnHqeIz0yDwPc5PMmIT74eH0/hHABdXLNhSKmSvGHHi8M1tl7uqM0lH8UxRx3tQUYBaPuVJV4lhygdKyNIMfjko3o9iiQwRvOOHQxO1Dw9nt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(376002)(346002)(6506007)(110136005)(53546011)(7696005)(122000001)(86362001)(186003)(38100700002)(316002)(76116006)(66446008)(64756008)(66476007)(66946007)(66556008)(55016002)(6636002)(26005)(66574015)(9686003)(5660300002)(966005)(8676002)(71200400001)(33656002)(45080400002)(2906002)(478600001)(83380400001)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Fu9ynhDq/tuUazHn1Px98Y2NkI7ZxdDASNrajCzbRy2Qx9WacPRDO91HkW?=
 =?iso-8859-1?Q?jbZwV/2MbQpKKzWq26EPJvXvnT7Mx5MB7fhfDPBMZjiARg+hr/WRurgVfZ?=
 =?iso-8859-1?Q?Fq73FsnFnOdKjFkon3QnFk8R3hViHpf2q28bHeUEEqUg2ykx7knZKxqDTo?=
 =?iso-8859-1?Q?tiF/4bcS24f8uCOdHDp9Q2WQ/YoxgXeJ5HmDzCVA0yWWsFxjJuDNvZe/St?=
 =?iso-8859-1?Q?pYoSyes6Gkpkjr9lDOVUCeI74F5TQj3fa+sL5GXs0SilJRL0heP6K7cdzK?=
 =?iso-8859-1?Q?BBmfO+7Aj0vClkFf7leKfFnIYhUScl2N8iUv6QvCH38Mj8VadfGSgxrseV?=
 =?iso-8859-1?Q?qsWzn2hBsrAYj5Vb4gpo0Ex++j00TIpmmtyDFWvmT2y72TEFNV/oJ/0y+p?=
 =?iso-8859-1?Q?aFILZDniJ3JnZA0DW+4UCYvSCg5EGQUNmCwCf7EsCBQdswGkCQRQwJkaem?=
 =?iso-8859-1?Q?aUygRYltg8zmCsHoxX4ZLKPhxatIHJJaTJVXYg794OeTueCceOg1ci/lS0?=
 =?iso-8859-1?Q?6JDgx99qgXuqJWDdF8W22llYxoRejjF3I2/DVyOnJH0oRUIekjH2V59+cZ?=
 =?iso-8859-1?Q?P0Y58o/LKDjl1HqVXKVR8zJwWhgw1GrqgrJZI/xekskRUW2vJy0H3Wuri/?=
 =?iso-8859-1?Q?0FrIh7n22h0mH4DG7fwFrl15HPwl7hTCJfWC+Olv9mePGYw/CLBBCq9tAG?=
 =?iso-8859-1?Q?HrKevs10Yn/Qs/WvGBSitYlH5HyNIf2SzE3tvL0tvWf6f4l+fmA4HE6h9+?=
 =?iso-8859-1?Q?PxnBfv0YSfZh4vh2MBg4LbvGD2vcuzbqlgekM22XfUebhmvnilq0TWdjeC?=
 =?iso-8859-1?Q?023yYLK2rL3myhBox7p61T2UgHi6ezmYp705WRyFtEELcBFW00heY1j0N9?=
 =?iso-8859-1?Q?AqsMwpVv8ugVIPxCoVUYHVLuNLGEdlQ11nS/0RMJMZI9FRIOYfGi/KdtO+?=
 =?iso-8859-1?Q?D4DezMouw09RVgViZgGqVubPR/v3peS82SUuFlceuLkrIXleWFYZDxrB70?=
 =?iso-8859-1?Q?4ksyhHBDMmEKF6bA4d0xsOUJtDh8mSwe/UoFNHpPR4BeIzxkxgd4DAP7QB?=
 =?iso-8859-1?Q?z107PjWCpPsKYS3sYY533N/ApDyAXPJwospCcZL6O3jwa9BmYu+U84Brny?=
 =?iso-8859-1?Q?MT42ft7MIvSucVygxUHYIuxaLtpBDlePggm0eNqZ2NjZf++HKt4e3dhE47?=
 =?iso-8859-1?Q?GgpRJ2i3ynie88j82agSQZwvokI4bNe6+cWLwKBpP5eNXhjw7ApmPf8ZIB?=
 =?iso-8859-1?Q?isaEDQwTXdGWMjPOv/u1nxfP3QrQyBUc+Gaxsnruc0YDMDs4387w5hyZBt?=
 =?iso-8859-1?Q?dTN4PX9kpGwv/y3I1mFwyCrNPJL0suYaDNOM4D/wKMnvIs4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2d1767-b8cf-4779-a657-08d92761e6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:06:08.5855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQ7XIznLIS/bMh9rA7Cv+DZIbxK141x3N5L3RRT9nldYZsecka4JQ6YYSlh9TYBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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

The policy is defined by our virtualization team to guarantee end user expe=
rience and reduce maintenance work.

Added David, virtualization team architect.

David, could you help to add more comments?

Thanks,
Zhigang

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: June 4, 2021 9:46 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; Deng, Emily <Emily.Deng@amd.com>; L=
iu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting =
fb location

Well, but are you the one defining the compatibility policy?

See usually Linux kernel code compatibility policy is that existing stuff n=
eeds to work forever.

We could argue a bit that the hypervisor components are not open source nor=
 uAPI, but that argument is rather thin.

Christian.

Am 04.06.21 um 15:23 schrieb Luo, Zhigang:
> [AMD Official Use Only]
>
> Here is our hypervisor driver compatibility policy:
>          - Host.y supports Guest.y-1, Guest.y, Guest.y+1
>          - Guest.y supported by Host.y-1, Host.y,Host.y+1
>
> Host driver had the feature for gfx9 2 years ago. So, this change meet ou=
r compatibility policy.
>
> Thanks,
> Zhigang
>
> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: June 4, 2021 7:14 AM
> To: Deng, Emily <Emily.Deng@amd.com>; Liu, Shaoyun
> <Shaoyun.Liu@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
> amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from
> getting fb location
>
> I was just about to question the same thing.
>
> It looks really good to me to have that cleaned up, but if this breaks wi=
th older versions of the hypervisor then it is a bit questionable change.
>
> Regards,
> Christian.
>
> Am 04.06.21 um 03:13 schrieb Deng, Emily:
>> Do we need to consider backward compatibility?
>>
>>
>> Best wishes
>> Emily Deng
>>
>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Liu, Shaoyun
>>> Sent: Thursday, June 3, 2021 11:10 PM
>>> To: Luo, Zhigang <Zhigang.Luo@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>>> Subject: RE: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from
>>> getting fb location
>>>
>>> [AMD Official Use Only]
>>>
>>> Looks ok to me .
>>>
>>> Reviewed-By : Shaoyun.liu <shaoyunl@amd.com>
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Zhigang Luo
>>> Sent: Thursday, June 3, 2021 10:13 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
>>> Subject: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from
>>> getting fb location
>>>
>>> host driver programmed fb location registers for vf, no need to check a=
nymore.
>>>
>>> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +----
>>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index ceb3968d8326..1c2d9fde9021 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1292,10 +1292,7 @@ static int gmc_v9_0_late_init(void *handle)
>>> static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>>>                                       struct amdgpu_gmc *mc) {
>>> -    u64 base =3D 0;
>>> -
>>> -    if (!amdgpu_sriov_vf(adev))
>>> -            base =3D adev->mmhub.funcs->get_fb_location(adev);
>>> +    u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
>>>
>>>       /* add the xgmi offset of the physical node */
>>>       base +=3D adev->gmc.xgmi.physical_node_id * adev-
>>>> gmc.xgmi.node_segment_size;
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
>>> s
>>> ts.fre
>>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>>> gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNsz
>>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=3D0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
>>> s
>>> ts.fre
>>> edesktop.org%2Fmailman%2Flistinfo%2Famd-
>>> gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cd41e78b1a3af4f08ff
>>> d108d926a1a2d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
>>> 7583297946242271%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
>>> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DNsz
>>> ZyRZHCxj%2FIJ1hYoSrkv3LpTmF9FbchpNMtQ2GE5M%3D&amp;reserved=3D0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> t
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CZ
>> h
>> igang.Luo%40amd.com%7C9b87dfa195ed4e84a8c808d92749e416%7C3dd8961fe488
>> 4
>> e608e11a82d994e183d%7C0%7C0%7C637584020581460118%7CUnknown%7CTWFpbGZs
>> b
>> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> %
>> 7C1000&amp;sdata=3D3S6ZEnCCMHHlfc%2B6xmLDz7Bgn91Is7EIpMS7WRxq0Jo%3D&amp
>> ;
>> reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
