Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D3EC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 02:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1241A23442
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 02:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1241A23442
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6FD89581;
	Thu, 14 Jan 2021 02:00:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249FE89581
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 02:00:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0jW9u4m3vTPaeoSU7Wm7KehPPlB2TC/ABcI8pKqIy1wgkKZutT6wa+4W1+ScmdeToYo8bai6sVu1e2V9+E697GN+E+bqAF82Il9QfDyklMkfo5u9Mn/G1i9jpcaWQH4oaYr4Ag3LyNyt1hvo22ZDqlWt/OOIwlYITiUPedB8gRiamM7dusUV2bO+QRV+8eChDeJMLBU/nkmQIiR1orvfqiQQ/k0s5116hSBGHGOX6P9wjC68t7cdVolrCxfHx2QFOR4aFuNP4fkyvQG1izDA+zN6lIe2G2tS2tAa925rmChNjZfqTkfGo2OaUQM2N26WFgY7tAYIh7UicYglprzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H12F81AlMoY6yKt+FDn0+q/uLhpyqUU70bVVbJ7Owys=;
 b=RnuAOGakIR2xNbQOz34qAMKDcxz+AvAMeGF3JKgELx+o2rqVLnjvsWDj1aga38hdBzecLgoUKo//QOuyN+YgASkryk9GLlzMfopVZSEKpOLmq1O/bi3GmEUp2+L3nJd4YBy9gvUXiMPXEO2A5I//QyTrSMnY6xpgAKXDeS1Mw0JxHraF6HA00iHpQWKC19emzhcRaerHBHb2UoPSHtaw7PRFCDNsxS9Mmp7bakxPGUuRpLMxlMWOX+3yfgZl4Q/4BULcypHvUlupMU8ZM2LeEpMf3WpoCjm5iu+wE50AxouVuQTPzXjTlek8KbUUEEROXU+5GTCaIbGuamkvDmWQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H12F81AlMoY6yKt+FDn0+q/uLhpyqUU70bVVbJ7Owys=;
 b=PaUeI/uqL/IR3B/t9H7vccxLhxdqzkl6/Go+T04P5HgkgIvNuMChavBZaRmrcRNejUNPP1wVtEykMWeCG1UEokNF4aQ5NJUGGxYilaVYcq8kn3t1jU3WXzNA0AXi2Y9aWY3SOm9L5HES3x9izXQIF16vUUx6N2l1ONXmIWdU70g=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2968.namprd12.prod.outlook.com (2603:10b6:a03:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 02:00:23 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 14 Jan 2021
 02:00:23 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Sun, Roy"
 <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Topic: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Index: AQHW6XZ9N1P5j4AyYk2NBhFMHNW1HaollrIAgADHCuA=
Date: Thu, 14 Jan 2021 02:00:22 +0000
Message-ID: <BY5PR12MB41152A0706EA9F1A7D0E88288FA80@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210113063612.31468-1-Roy.Sun@amd.com>
 <318aa468-c009-8edf-d6bd-8408ee79c42e@gmail.com>
In-Reply-To: <318aa468-c009-8edf-d6bd-8408ee79c42e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6adf7bcb-c453-4aad-bdf0-10032adc481c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-14T01:55:27Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.113.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9bb2e1d-bf73-492f-f6f2-08d8b830274a
x-ms-traffictypediagnostic: BYAPR12MB2968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB296853FD9C0B2B6792DFE5408FA80@BYAPR12MB2968.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UR81mq6uknt+emhQ+XH+wC+S8i4AXdLRubqPZRNGsW5w2lGAjWGTXeQGn27b+Znp6RGwzyLf6HrZIxS21H1KKGazjrYcmBM+uYIb0fdFPRfftzI1z9K6Tq/QcYqM7or9ljq4jkLkMug9KVBYpEbuEJ4zBL3l2TCz1I+FoA2KssLCsZdCyjfsGj4E9CrVgn/hlulAp0Pzi+AxnsFK7aOqj0z95fGY6Uqpy2KVp5d27EfVufM0VsRrT9ZN0nEPm/xAZmUuxhNThBmBf/WdHTSaa6RwaJA27lW18vPK3qMfzGMYC/T5RX6klGQIIcIEJi0GPAwyS5jNtaG3hiFNNQl/GoN2o1Wn5ZXP8V04tkHKQ+zUWzUwhYXX0HUZy31+pURok0oqI268R6siqO7IzWtcyoknk8nKjcpnmJE8acKFOlPDHydtoGTfgMq0FVgoGe+5+2hDIgYsjaoJitr/MnnCbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(33656002)(66446008)(76116006)(478600001)(316002)(83380400001)(86362001)(66556008)(8676002)(64756008)(26005)(186003)(66476007)(52536014)(71200400001)(7696005)(2906002)(9686003)(5660300002)(6506007)(8936002)(45080400002)(55016002)(66946007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?LP0tkaptNrzZrqw6a4X+uuswBLtL9HmUVmFxTH8F9KIeQq4PnvZbwmEjJI?=
 =?iso-8859-1?Q?JNRaolwSCKijFlbRZdZqrhxV4AVaKE6fRh0lS/rFpXmQ1DexSzq0AoaYeW?=
 =?iso-8859-1?Q?AQ9rKwaOnWyWMXS26dlJvUiANySNt+/wXZ0Rz4JyP0kg0fpWuMC/YMc95V?=
 =?iso-8859-1?Q?wM4dXGpOMZ99fouUE2fz3zNeqrkUuRtAtSL989iAygw0ZQjFmHmCH+gfj6?=
 =?iso-8859-1?Q?7JM89KPLez6Zsi1MdZSAeEWX00KkCKqXgC+gYMjOW7fEntNk5koU48ZEs9?=
 =?iso-8859-1?Q?u6ceMiSKpmJGcRGXdDsgvz8wdK75TIkYh74hbYsLJFDgIg2MFsDWmHw73B?=
 =?iso-8859-1?Q?nfJCDBj3bzlCZW0ERwb6BslOSDGuKS3UoaNnJHtkNtcHm1OZUBMKcwUJ8o?=
 =?iso-8859-1?Q?hpuc6wYx+psZr6RLfFea3LeJmD2EL1pSWtauef7KCFomINZNSUBO/H4ITl?=
 =?iso-8859-1?Q?TVuV3t5Vnb6+5k1Pb42yVyMhyHlqOM79b0tn01D/5eE0Z8eOdvNooRW+Qb?=
 =?iso-8859-1?Q?wshEbO4ZgSVFOIAHOoCetYeMkuBMDVmaXSh2TZ+VBMlxT1XXGsk/EQqbRF?=
 =?iso-8859-1?Q?6wz1rcxFCZhDaXJ/s0fflZ3DUxJSf6lcpc5R3N40AHHwJPpYI4r4sp2GhV?=
 =?iso-8859-1?Q?EUdCOsESkN7KciZqaAUbiERzUODSP+rxf2f8HBgZl8K0RGjwecMBy4SqG5?=
 =?iso-8859-1?Q?97Mi6EzNVruuTCjGwR304Em+QrNUpvAXtnfNWtni+JNJyKr3DtUJbGLcWZ?=
 =?iso-8859-1?Q?XkoSLkkC+SGi2d6soXTVZP7eyznD9+LYenvnfpVAivmRPKnpTXero+wWnv?=
 =?iso-8859-1?Q?dezvp7Jh8ZokCvt1vmV4924jmBFnhl/Ksgrh8t3zH7IJVZzW36GELiuiMd?=
 =?iso-8859-1?Q?Yhn+8woCxbxtLai+h0Me0CGJbVb5cWvMVMyF29vN4s9+pmBoC6H/Eks0/t?=
 =?iso-8859-1?Q?XIlkxZjGfu4EdXSkFtVyc2FHo4pgPQumwfpXBJKwMAStcQRl556OdtcgNI?=
 =?iso-8859-1?Q?DhXx+ZPY1RnG20+X8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bb2e1d-bf73-492f-f6f2-08d8b830274a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 02:00:22.8736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ewtx2iwP2gwkm1fyBy5JQrnOGcwZGBLwvWij+lcuxH64UKVCxD+cfkBucN7wUOH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2968
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

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Christian K=F6nig
>Sent: Wednesday, January 13, 2021 10:03 PM
>To: Sun, Roy <Roy.Sun@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
>
>Am 13.01.21 um 07:36 schrieb Roy Sun:
>> This fix bug where when the engine hang, the fence ring will wait
>> without quit and cause kernel crash
>
>NAK, this blocking is intentional unlimited because otherwise we will caus=
e a
>memory corruption.
>
>What is the actual bug you are trying to fix here?
When some engine hang during initialization, the IB test will fail, and fen=
ce will never come back, then never could wait the fence back. Why we need =
to wait here forever? We'd better not use forever wait which
will cause kernel crash and lockup. And we have amdgpu_fence_driver_force_c=
ompletion will let memory free. We should remove all those forever wait, an=
d replace them with one timeout,  and
do the correct error process if timeout.

>
>Regards,
>Christian.
>
>>
>> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 48
>++++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 6b0aeee61b8b..738ea65077ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -41,6 +41,8 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_trace.h"
>>
>> +#define AMDGPU_FENCE_TIMEOUT  msecs_to_jiffies(1000) #define
>> +AMDGPU_FENCE_GFX_XGMI_TIMEOUT msecs_to_jiffies(2000)
>>   /*
>>    * Fences
>>    * Fences mark an event in the GPUs pipeline and are used @@ -104,6
>> +106,38 @@ static void amdgpu_fence_write(struct amdgpu_ring *ring, u32
>seq)
>>   *drv->cpu_addr =3D cpu_to_le32(seq);
>>   }
>>
>> +/**
>> + * amdgpu_fence_wait_timeout - get the fence wait timeout
>> + *
>> + * @ring: ring the fence is associated with
>> + *
>> + * Returns the value of the fence wait timeout.
>> + */
>> +long amdgpu_fence_wait_timeout(struct amdgpu_ring *ring) {
>> +long tmo_gfx, tmo_mm, tmo;
>> +struct amdgpu_device *adev =3D ring->adev;
>> +tmo_mm =3D tmo_gfx =3D AMDGPU_FENCE_TIMEOUT;
>> +if (amdgpu_sriov_vf(adev)) {
>> +tmo_mm =3D 8 * AMDGPU_FENCE_TIMEOUT;
>> +}
>> +if (amdgpu_sriov_runtime(adev)) {
>> +tmo_gfx =3D 8 * AMDGPU_FENCE_TIMEOUT;
>> +} else if (adev->gmc.xgmi.hive_id) {
>> +tmo_gfx =3D AMDGPU_FENCE_GFX_XGMI_TIMEOUT;
>> +}
>> +if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_UVD ||
>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCE ||
>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_UVD_ENC ||
>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_DEC ||
>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC ||
>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_JPEG)
>> +tmo =3D tmo_mm;
>> +else
>> +tmo =3D tmo_gfx;
>> +return tmo;
>> +}
>> +
>>   /**
>>    * amdgpu_fence_read - read a fence value
>>    *
>> @@ -166,10 +200,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring,
>struct dma_fence **f,
>>   rcu_read_unlock();
>>
>>   if (old) {
>> -r =3D dma_fence_wait(old, false);
>> +long timeout;
>> +timeout =3D amdgpu_fence_wait_timeout(ring);
>> +r =3D dma_fence_wait_timeout(old, false, timeout);
>>   dma_fence_put(old);
>>   if (r)
>> -return r;
>> +return r < 0 ? r : 0;
>>   }
>>   }
>>
>> @@ -343,10 +379,12 @@ int amdgpu_fence_wait_empty(struct
>amdgpu_ring *ring)
>>   return 0;
>>   }
>>   rcu_read_unlock();
>> -
>> -r =3D dma_fence_wait(fence, false);
>> +
>> +long timeout;
>> +timeout =3D amdgpu_fence_wait_timeout(ring);
>> +r =3D dma_fence_wait_timeout(fence, false, timeout);
>>   dma_fence_put(fence);
>> -return r;
>> +return r < 0 ? r : 0;
>>   }
>>
>>   /**
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7C8b116229938b463
>df87f08d8b7cbf607%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637461433936049544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=3DHOcLHmmblOUHXATFBl5HC6LOmFq0oXglAh2GFwd6sus%3D&amp;reserve
>d=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
