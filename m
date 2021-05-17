Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C39C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120E461108
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120E461108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F4D6E1D7;
	Mon, 17 May 2021 07:20:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A094D6E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 07:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O62ihYG6Bh7FxsAWRJ5j92m2l/Q2E1oPrh0ciEp7rI8+G1wcDi4MFq2MhkB98gNDqg+KJ3bNUGl2RbMXGMqUiSw3FYyWMNXU78ZQh69Q047fvtp70bpyyUM4YvtoxsJIDx0xbG0osFOwIDViG91suQLBZFIg3dC0fYkyDYvYkUVIkbfHoInfGzmfjuemka6JJFo4Ks0aNiy3MYbkkR+EKF3aP2NcJRUMBfWpZGVYOOfcGL5V/mZH/8SnJBdtTnWwelkAjrcxJQFgAfqCqHIHSbEZ7nKdF1VfyKPy/3LWHzZCdIvkl3znH3GPCrlJzStHZaKfACVC90YG/dhz+nWTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrq1x5sikh8TSu60ULyHJWKiy6DbwQ4o9SWXV1kbLWo=;
 b=JfTZzZD8ggIlZZhWUY4O0nNA3tPM/xS611YIlKhfrtwGR6xtm6Tv4gkr4QeCzavrolyAPJ67PCD7IJ8rchOqsPtYoBTBKGS6H32yyqFWa0cQc+I1jdwYWt69OQ5O7U3WiLKfBE8v+PJqrQPuqzEPT5bzzZZ917mlG4r2ceSGltU0j3er9VBO38uAv92SDaXP0auW8AcSEL8sl7TMkiv9mrltxfAbWSkFWjgX6mXEywpoUjDrKWdjDH7jBXhqcYqhhFGiq7z9iqOTwM1iI6HaTzAJFdiO9+ZBvj0fvZElrjhCM52ayVUIMxtnLH0Upj5+wflheis15Qq0ZcWlWsmswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrq1x5sikh8TSu60ULyHJWKiy6DbwQ4o9SWXV1kbLWo=;
 b=029QrxS3Axw1HzhDVIdWTBRHZtKqrIEYQCdSBcy+4SWdgyjaXUGMj0vh7vdDd2HwAsERVzYJ8buwmHDahN+o1GVrj1n6lZPiQoPiBPheerPzKdtvMosyEdCFeqiQO9a4G0ut54ntjfLf63uCILP8WxQXvS3cajvGxrFCwTwORg8=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3125.namprd12.prod.outlook.com (2603:10b6:a03:dc::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 07:20:47 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:20:46 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
Thread-Topic: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
Thread-Index: AQHXStauMcp5hdyczE26kG7wgOFEKarnObiAgAABT4CAAALKgIAABacw
Date: Mon, 17 May 2021 07:20:46 +0000
Message-ID: <BY5PR12MB488585C22712D75B9B36E50BEA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210517043940.99603-1-Jiansong.Chen@amd.com>
 <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
 <BY5PR12MB48858069A0EBCDBED03B6052EA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <492b38eb-bf99-bdd1-b874-c95905b79a5f@gmail.com>
In-Reply-To: <492b38eb-bf99-bdd1-b874-c95905b79a5f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b2abe5ce-55c4-4728-9960-c6279b8cd5aa;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-17T07:16:36Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b72ce07-95ad-4c07-d969-08d919044a77
x-ms-traffictypediagnostic: BYAPR12MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31253AE65CFBEE328972E88DEA2D9@BYAPR12MB3125.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDWipfAUl4FFoAORtbxqPTfI40umn5DpPKuwaRsFWj27tP2J+oNBPlVBhDqo05Wxb8rVjfIXqaAnOO61kTvlTp3M9006XK5gMDOwTAPUiXXYU6kJrVEf7noSXxzAiZFUtMIU4NoMvIlbhKDJOys5PJz2TGdV7yNqormNZfME+QPK7Ue9S24PfI0oCJDEmYjyB9kcSUYhyhMFQ9IO25dpDZ/INa94KujmXp413yMoEB9Xazub1ftNMblEU0QtpH3CnsEyjQQ4cU2Nf7GS2nW7mi9xEF54u+wTKRP7p9pqQkKKpS+41YRUWljM5ih9IE63YTgewMZIclVbwc4V/eVpNUha3mKNDH299UpEfqHu04+RbB5abIxOccE6l5bMBcePSABmsMneEPDUmDMWJwt4oCp26Y89mGlp0OjynJjBT8Bu5h08uJE7uDqyzFsNpsXE9eNbNVvwVlz+Y72rQqxsf132RtHeWj+VUEAwokT/6LiHYvKNdw9IKNGyVnT4rsGkC1oZwBKgta5++d4QEwDkR+547y3gTdcwhC9XDp4eZ0LSIPn8zldmAMXTkXvbZZnEeVW7AKqVm6AP+SK2gdbaE6N7fMFfVzS3hEhC7UboIpIpUjmfv+BT3oGamrplRSXeZy8Mqr0CTQcyIif3re/chZ2XFPoRJsFFHU5xD7pON1xVIHbbXyOuti8PyGCuMBbc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(122000001)(45080400002)(53546011)(83380400001)(66446008)(38100700002)(64756008)(110136005)(316002)(26005)(33656002)(8676002)(966005)(8936002)(6506007)(66556008)(9686003)(66476007)(76116006)(7696005)(71200400001)(55016002)(52536014)(5660300002)(66946007)(2906002)(66574015)(86362001)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Bo965pSUudLspW/yi37cE4NrCXhqse3dvSuVIGrob/gyTPuT22/ryUaVqK?=
 =?iso-8859-1?Q?9L7p1z6J5fc2yw4velG+g5dgd+yw50SHUz2fI5IOwevgwFtTsDJWMSOsvd?=
 =?iso-8859-1?Q?KTpyfQKVNQeQ2beY2QVrnHoog15yiAJWvJVeZsGRQMnZLsj+NODKTWKKs+?=
 =?iso-8859-1?Q?OdLO4Y37yY8dUD3UUQKptBiC5us/uczBfRNeH3NDsHCDzzFbkLhVeBaYOU?=
 =?iso-8859-1?Q?rIZV5uKFns0H7K3Q0xmSJDA1AEdhB66iodxo5AO8MfIymqEbDWUauMAsyV?=
 =?iso-8859-1?Q?TxBkzmkH17avV6+ReemBxk4klb8EiytxjT2Ni55RPSgkIcqHAbuuW14F3G?=
 =?iso-8859-1?Q?5XNJXzxAFIog8fkofwf2UYuYMdZ3fB8KSfEC+pVYqpK77PwZ+KFAtWdT/D?=
 =?iso-8859-1?Q?tbRFrC6ljwHC8S264w3/J27mTRURRIKpTP3II+2EsWksI56BkYmYqaTyI6?=
 =?iso-8859-1?Q?uCW2gFWIQXiTJSktcFUdQRorQ8L3Veajx7+ctG2PGYLQj8l6JVEF/ucyTG?=
 =?iso-8859-1?Q?Gl+fGIVNAt1DUOPKGhrADajzvSV/ObVEM83oEij6qyh1x5nb4G2rQnucp3?=
 =?iso-8859-1?Q?chnIL3xSXtOB8vqG/Bf4weJbMZKXlwFODSRBwSUvjQ30NCT7eCtmyV9cXs?=
 =?iso-8859-1?Q?edRpzL/H86F73smMsPumWliY0Z0tsbr7BOxfswSU62yQ+fBK3jZXA8vDJ+?=
 =?iso-8859-1?Q?+KHbwolX39ryEXh9YST3qYvNYLhQxBLTdiaAu3giqeEYWF86rofnBEvKIQ?=
 =?iso-8859-1?Q?iRVoO6/vYUbCWLuDhV/bSqbjkwFKh/wR524fLm4Sy7YYy2PVX0uKiwZvAj?=
 =?iso-8859-1?Q?s1WWun1B+h3VLWNgIonSdLHUMgThWhVKD2X64RaXBpQVpbI+HH0Zy7rLl5?=
 =?iso-8859-1?Q?zArIg6AMFIcjAlEUGeEK9Bssz5J/B69oQ9xDVxPA/GfTPna5uSwaT5HmmC?=
 =?iso-8859-1?Q?i+/RrFof5dIqA6Z0tCstBUi+3znozVXhY4a7AfjbvvaucPZrySp7e47BSC?=
 =?iso-8859-1?Q?rlT2leEn9Fgnn2hS2lHLqnJKFEqH4iQOwK8JSBhrBajXLCMakfK5InBesV?=
 =?iso-8859-1?Q?kSkl446h1Cej+x9wPVM7nQuMbY3U7Rf6WPUDGWlJN/W5kyoDFfb258dQfo?=
 =?iso-8859-1?Q?EpBkjk0pKyjH+2B7Ywikgf/DYcj4l9O9pDwap5sUGvRDbLukJFloSBDTKp?=
 =?iso-8859-1?Q?P49VCRX8cCPi11n3PrVVqFvswxRbZSFqjxBnvkymviZuf/utFS1+YNxGqB?=
 =?iso-8859-1?Q?g3AobqgOq2GOYDiEJYLFkNsGoxvc/egOQcq9m8ug/oXtUkGf4FOZzb7QBF?=
 =?iso-8859-1?Q?TqSBLKHuvPgcC0SzSAoFfK3aoy7v927sHNmJxNBqH3Wtwe2UiYJhuZ/VSa?=
 =?iso-8859-1?Q?htRaM3DKYf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b72ce07-95ad-4c07-d969-08d919044a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 07:20:46.8193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfiG1eq1A5AZ5rxsqiqAAuj+qg960iIOONrUC37a178jPCzeKqRkx3Wsfzzo7gyK5hDWC4iokA2MgGtXSLJskQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3125
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

Does't the below code in gfx_v8_ring_emit_cntxcntl do almost the same thing=
 as dropping the preamble ib. I cannot understand why bother to duplicate t=
he optimization and cause a mess
In the common code.
                /* set load_ce_ram if preamble presented */
                if (AMDGPU_PREAMBLE_IB_PRESENT & flags)
                        dw2 |=3D 0x10000000;
        } else {
                /* still load_ce_ram if this is the first time preamble pre=
sented
                 * although there is no context switch happens.
                 */
                if (AMDGPU_PREAMBLE_IB_PRESENT_FIRST & flags)
                        dw2 |=3D 0x10000000;
        }

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, May 17, 2021 2:56 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs

Am 17.05.21 um 08:51 schrieb Chen, Jiansong (Simon):
> [AMD Official Use Only]
>
> Doesn't  current solution always enable the optimization in a safe and mo=
re clear way?

No, we also need this for gfx8 where gfxoff is currently not implemented.

Additional to that we mix common frontend handling into the backend with th=
is approach.

But you could clean up the code in amdgpu_ib_schedule() quite a bit.

Regards,
Christian.

> 1. for gfx8/9/10 we use load_ce_ram in context_control to control the opt=
imization.
> 2. for gfx6/7, we directly drop the preamble ib.
>
> Regards,
> Jiansong
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, May 17, 2021 2:42 PM
> To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>;
> amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old
> GPUs
>
> Well NAK, as discussed checking the global flag is more flexible since it=
 will still enable the preamble drop when gfxoff is disabled.
>
> Christian.
>
> Am 17.05.21 um 06:39 schrieb Jiansong Chen:
>> The optimization is safe for old GPUs and can help performance.
>>
>> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
>> Change-Id: Id3b1250f1fe46dddbe8498894fb97e9753b7cafe
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 6 ++++++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++++
>>    2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 3a8d52a54873..c915cc439484 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -1873,6 +1873,12 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_r=
ing *ring,
>>                amdgpu_ring_write(ring, 0);
>>        }
>>
>> +     /* drop the CE preamble IB for the same context */
>> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
>> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
>> +             return;
>> +
>>        if (ib->flags & AMDGPU_IB_FLAG_CE)
>>                header =3D PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>        else
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index c35fdd2ef2d4..6d9ccae48024 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2269,6 +2269,12 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,
>>                amdgpu_ring_write(ring, 0);
>>        }
>>
>> +     /* drop the CE preamble IB for the same context */
>> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
>> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
>> +             return;
>> +
>>        if (ib->flags & AMDGPU_IB_FLAG_CE)
>>                header =3D PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>        else
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJi
> ansong.Chen%40amd.com%7Cf80f7d9888f4427c2b1408d91900e335%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637568313869095131%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3DMF1%2BhakHpB8N9B8JwXCA9yB1hIy4CNNMok6ASz3AOU0%3D&am
> p;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
