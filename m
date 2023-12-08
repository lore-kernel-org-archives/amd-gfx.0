Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C64C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 14:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831B510E07F;
	Fri,  8 Dec 2023 14:49:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B6A10E07F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 14:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwYmfIM4b3oUvBbAx7DAP0KTKh+LKHn1cvXy0nfcH68QUpMM1/+o7dJ07v2BW9hmWJ+tu15POCWjCfFH0E7wixoYyLebly9bBH/RXSWD0zGcqgaZscZfSZEuhwp89Xq0EgZhVr9V7FMt+4g7y5hoQiL8z6hvPAqEc1yg6uDEne7ihe+JYTKiqEg8kK4mjguINoIdhFWJZFKvPuqbBOs13e1qt1UStGIGMjL6WVHTeCep6LZPkSd8F8DYgD5It8epekJ/T9IQ8+1x5X3mo6wUYaQZKRQd5aQ3UXqJlBScD1i5amV607jlHIq0ixGGbi36jGGelngkwrmxJF6mnre5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tijMO4Y1d3H9lMSp9gw59bdeqpn5IuFpN9p0qfxWvCU=;
 b=OmUqpREwdTMyAhmFXJd1Ts1fohVoLPrYYLpoIAWoGyMPsv0rawbbzduBGIP+aJKdESVzamYklvHp9nqqpvp/37OX1kn+PakTbPUh3qlCk20EA5/e5KGyo+v6e1K8aCqhntxxhWIWdqhRWUsOhsph2VXHEbckBPwBpyfoG5R5uOKhVV4e37h7KFEpZLr1uunh8+OuRmhN3gbz4Kzee+JCR94F73MxSCnn9TvdlnbXCJi8vnwITdFIN5pf5k1jPU7BQ5aFmuW8H4h8EqzZrxomrOILGGCVcUUL4P+9AWKn5H8g87z4MvZ+ChLS6YxdQKdABwxtFruvdL0wb02uAxkFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tijMO4Y1d3H9lMSp9gw59bdeqpn5IuFpN9p0qfxWvCU=;
 b=BsqdtuJlJLndozSi//0XQ2wJ0Y5fXpPjLNRpSeY1AN+A622EM48WEKjQMkzCvSSaIDgN072f9eLqjnkkudz5TsQbaXBN2yuDi+7tyqzhjw1XkgDMCkdMMw73P8mQm1BtLg6U9nZWLcIcFrEtnXyIz+mK+JlPQKPBvnoYTd2K9Qk=
Received: from DM6PR12MB4731.namprd12.prod.outlook.com (2603:10b6:5:35::11) by
 IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 14:49:31 +0000
Received: from DM6PR12MB4731.namprd12.prod.outlook.com
 ([fe80::8ac:80b7:a7b6:dd3f]) by DM6PR12MB4731.namprd12.prod.outlook.com
 ([fe80::8ac:80b7:a7b6:dd3f%6]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 14:49:31 +0000
From: "Olsak, Marek" <Marek.Olsak@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Friedrich Vock
 <friedrich.vock@gmx.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Thread-Topic: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute
 queues
Thread-Index: AQHaKcvRMNZPFzai5kuitxo3KUso9LCfdLSAgAACsic=
Date: Fri, 8 Dec 2023 14:49:31 +0000
Message-ID: <DM6PR12MB47311E2E63582B226AF4556AF98AA@DM6PR12MB4731.namprd12.prod.outlook.com>
References: <20231202001740.120840-1-friedrich.vock@gmx.de>
 <3525f437-9537-4fb4-80d0-65acd9d55d2f@gmx.de>
 <3cf226b8-c80b-43f6-9f6c-9610d224717a@amd.com>
 <1939f568-f780-4e34-b5c5-dab461f93b57@gmx.de>
 <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
In-Reply-To: <8041be7c-64d5-4b1d-a734-4326db98f256@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-08T14:49:31.120Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4731:EE_|IA0PR12MB8648:EE_
x-ms-office365-filtering-correlation-id: c0646d09-ca2a-4865-8aa1-08dbf7fce2ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGZgGUAxy750vD1Mw0KxFDGkEpwoutgVJb4VS3FAm+LzZVLNzmBuc6yoSUNVRVht1fRW+Xqt/8GEzf0WuJPn9opfDFCnkYyx2U1A0fl5nbO/1MPQqHA/mG2ry9yOZZoP4amIaN9v+Ics7kVTBvibNW07K4wP0zbYlLsIpdkpjC+ChJ7qwodmaWCiUKeCLjzsTuUbVOAl3rlT9kKZ3zznQ6wOVImaXiJ6dEZviAw7izSVUr3FEgMfX0XVMGnwdmituCN60YU7t5WoPU+0coLjQG+XfiUOlUT5X663vbF/q4ILplQCRaQx1vo+2wuUpOQLKHd9NL457EOi4NADgV+8jYlky5HzXoZoeBLUobZH/fOG0lX9PguZdcyuraYxKZTCj8D6ZZdACmdiG6EHLX49pRDc1mWf6LWd07dGZfvKqI4tkhm1AsxiHZCU8cqu/IumVYMHYTLN+9uQR1haT7UcDh4uP03N/Rr7X7PFWN0HPRw12A4FsBMnXOmTjNh2+JMPpCCgNUBd6dz80149FtuGpDXsZkAoKUCy1v54PRy28r3iXP55xSGYnBgJ3GBnHb9MsFw6lGV1aauVvPi/jyM+A3Ek5hLiTuU5tCjdyC16kTY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4731.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(19627405001)(55016003)(53546011)(966005)(26005)(71200400001)(478600001)(7696005)(6506007)(9686003)(166002)(38100700002)(122000001)(38070700009)(86362001)(33656002)(41300700001)(2906002)(5660300002)(110136005)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(83380400001)(66574015)(76116006)(8676002)(4326008)(52536014)(8936002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JbxHnKELxFtVIxrSy0iAqWx2XPK1KkKrt5byh+W/KlJya9fQ1lKpJJfX59?=
 =?iso-8859-1?Q?h68G/AHr/ZvWeRq2WdQCzg4NySjXWT1RxAr67Wy3taBnsElIzJhG1z7QPu?=
 =?iso-8859-1?Q?UNFu+17KAYpDpfMYjFOmPKjnM+SabttJqtdycOjS0gpKQTdXqt57HWaY0V?=
 =?iso-8859-1?Q?pekD1loLrJI5mWZ87UYtKc8la3OM1I9AnzBsqdkwI5m3OZLT3z9lqDz9fC?=
 =?iso-8859-1?Q?ABNkAnxenDj9lKj5SgTPVf/i+WIMOGIe45mzfyJR/2obqqCvYk/ftLN9f/?=
 =?iso-8859-1?Q?givtjfoez3haPd5Bqz6mGDuIuup4kB/SwjT96DhDSCeRnLHKXPJreckHIU?=
 =?iso-8859-1?Q?ZUIDyTAhAmL8xq5/cPaB0x1eZlSwQYwec1Qh7OxSkG7QPna3VMgtM6rFh/?=
 =?iso-8859-1?Q?M2HpK3LVD8lln6CiWBO0XZ4GBwSqktEK17KgGbfCkqKW8poDO6COyVQxgB?=
 =?iso-8859-1?Q?g0oKi7CmiW4sokQCQamq2M+CQIJYzJrYlUO9xqD9110MTXIhdm7788nU7g?=
 =?iso-8859-1?Q?7AKi9PZq2Lz9zQ5Ins4W6nPf6YFKlaLn++GA+Y/9mBIlDIuq/6AKgt4TSW?=
 =?iso-8859-1?Q?KOLTkX6lKb3bZKJTXTyU9BlP+K19WHKc9V7kLdt0duOVhc7cYoHUpI2xHE?=
 =?iso-8859-1?Q?EgkZWXYlnI2+oJAC/m+swcXG353K0hJt3ElZWPrpMsoDU9R/GVBOiHMx5V?=
 =?iso-8859-1?Q?KjEMmPo4NMDFvxQ7yuioFvJRmog8mlMtz/KCWw0iIpM1fAgvaFncdDrgzm?=
 =?iso-8859-1?Q?Rdu6t5t6aX+tn5LZ7UB3taWuWqcRUo/iZzJOtha5ZeoUIdeEN5hnpYra1a?=
 =?iso-8859-1?Q?VesbhnyrWq8Mvv55omwnzf9J5wNtCvln7O9GAV7Tae0sg2lCvxToN/jxTH?=
 =?iso-8859-1?Q?mixUtXP9aQeE2jBl+G9RvJAkB9w8MwIsdy3vYoGo6R2hRnKdJEhYFwNEIF?=
 =?iso-8859-1?Q?03z5Urr8zGip2FpqEWdGGtdCV0siEBGHbsLkwaLTcwmA70Pe4KdaGJsvjN?=
 =?iso-8859-1?Q?4QJoL+WEs/gVMal9heDSHSLboc4UBkr0PDmOMjd6flq4ADwkEjrEEM5wbJ?=
 =?iso-8859-1?Q?b/4SjeANMbPX0/Eh9BpSFDXqGbXDtVJmyRPQdPPCFwSAndMk7rVwyX2EhV?=
 =?iso-8859-1?Q?v2Dmh0UYNnoMIPYmqH22qnnJzt3Vfg3pS+b1fS0m3Wluzbkef8ywX74mp9?=
 =?iso-8859-1?Q?MurTPRI0c8MybEsJAKEqM8tuGd+Dfbe6UwOYPeLEEqkPdX/YuqkGlSesaz?=
 =?iso-8859-1?Q?mhQRJBcyWUMbv6oaufpL6bBtqQAr/lcbXMhDw4Vok8rbfPEvUu3ExNRXx9?=
 =?iso-8859-1?Q?KJ/174iFR/qDIwsGz8iv/CiWAg8uK7FFuVisO/949KFzMtzVRkLNYzyv0A?=
 =?iso-8859-1?Q?zAGjzuupudLIK6oLH09Ytp2/PtyEvLQ1AAEWTb6ZC/1oIPg51GGadAJ2su?=
 =?iso-8859-1?Q?pSz3jdkZRzpL7q2ZoIHAFp7GHcUNgF+HfP7aS8glYkSo7zrxpkrCuwqW/k?=
 =?iso-8859-1?Q?LQ4Id19xH/2WWO3fIMgKT0D1M5ccNfLCXQnezF6M9RauZUn+S64u9lxUzY?=
 =?iso-8859-1?Q?wKoHSrI97bIpoktCIkH33Yb5n8gkisoBn6AUYdc2RF7fP8quTN2f7Nx7pg?=
 =?iso-8859-1?Q?AFolcLETOilTY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB47311E2E63582B226AF4556AF98AADM6PR12MB4731namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4731.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0646d09-ca2a-4865-8aa1-08dbf7fce2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 14:49:31.5183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRF7MSTDFpeI8yG+ZAX2zhzLu7EMA2oGmnQqXqQGlKuuRz9qNKjNKsypsrCcxFlc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB47311E2E63582B226AF4556AF98AADM6PR12MB4731namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Christian, firmware has nothing to do with it and doesn't control it. That =
was a wrong group of people to ping. It's only implemented in the SPI and t=
ested by the SPI team and PAL team.

Marek
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: December 8, 2023 09:38
To: Friedrich Vock <friedrich.vock@gmx.de>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Olsak, Marek <Marek.Ols=
ak@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority compute =
queues

Am 08.12.23 um 12:43 schrieb Friedrich Vock:
> On 08.12.23 10:51, Christian K=F6nig wrote:
>> Well longer story short Alex and I have been digging up the
>> documentation for this and as far as we can tell this isn't correct.
> Huh. I initially talked to Marek about this, adding him in Cc.

Yeah, from the userspace side all you need to do is to set the bit as
far as I can tell.

>>
>> You need to do quite a bit more before you can turn on this feature.
>> What userspace side do you refer to?
> I was referring to the Mesa merge request I made
> (https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462).
> If/When you have more details about what else needs to be done, feel
> free to let me know.

For example from the hardware specification explicitly states that the
kernel driver should make sure that only one app/queue is using this at
the same time. That might work for now since we should only have a
single compute priority queue, but we are not 100% sure yet.

Apart from that the hardware documentation only says that it's a nice to
have feature and when we pinged firmware engineers to get more
information they didn't know the feature immediately either.

That is usually a strong indicator that stuff was implemented in the
hardware, but not fully completed and tested by the firmware team and
validation team.

Alex and I need to confirm that this feature actually works the way it
should and that it's validated/stable/read for production use.

Regards,
Christian.

> I'm happy to expand this to add the rest of what's needed as well.
>
> Thanks,
> Friedrich
>
>>
>> Regards,
>> Christian.
>>
>> Am 08.12.23 um 09:19 schrieb Friedrich Vock:
>>> Friendly ping on this one.
>>> Userspace side got merged, so would be great to land this patch too :)
>>>
>>> On 02.12.23 01:17, Friedrich Vock wrote:
>>>> This improves latency if the GPU is already busy with other work.
>>>> This is useful for VR compositors that submit highly latency-sensitive
>>>> compositing work on high-priority compute queues while the GPU is busy
>>>> rendering the next frame.
>>>>
>>>> Userspace merge request:
>>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462
>>>>
>>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 ++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 ++-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  3 ++-
>>>>   4 files changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 9505dc8f9d69..4b923a156c4e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {
>>>>       uint64_t eop_gpu_addr;
>>>>       uint32_t hqd_pipe_priority;
>>>>       uint32_t hqd_queue_priority;
>>>> +    bool allow_tunneling;
>>>>       bool hqd_active;
>>>>   };
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 231d49132a56..4d98e8879be8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(struct
>>>> amdgpu_ring *ring,
>>>>                       struct amdgpu_mqd_prop *prop)
>>>>   {
>>>>       struct amdgpu_device *adev =3D ring->adev;
>>>> +    bool is_high_prio_compute =3D ring->funcs->type =3D=3D
>>>> AMDGPU_RING_TYPE_COMPUTE &&
>>>> + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);
>>>> +    bool is_high_prio_gfx =3D ring->funcs->type =3D=3D
>>>> AMDGPU_RING_TYPE_GFX &&
>>>> + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);
>>>>
>>>>       memset(prop, 0, sizeof(*prop));
>>>>
>>>> @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(struct
>>>> amdgpu_ring *ring,
>>>>        */
>>>>       prop->hqd_active =3D ring->funcs->type =3D=3D AMDGPU_RING_TYPE_K=
IQ;
>>>>
>>>> -    if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE &&
>>>> -         amdgpu_gfx_is_high_priority_compute_queue(adev, ring)) ||
>>>> -        (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX &&
>>>> -         amdgpu_gfx_is_high_priority_graphics_queue(adev, ring))) {
>>>> +    prop->allow_tunneling =3D is_high_prio_compute;
>>>> +    if (is_high_prio_compute || is_high_prio_gfx) {
>>>>           prop->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;
>>>>           prop->hqd_queue_priority =3D
>>>> AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
>>>>       }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index c8a3bf01743f..73f6d7e72c73 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_init(struct
>>>> amdgpu_device *adev, void *m,
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
>>>>   #endif
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0)=
;
>>>> -    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
>>>> +    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>>>> +                prop->allow_tunneling);
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>>>       mqd->cp_hqd_pq_control =3D tmp;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index c659ef0f47ce..bdcf96df69e6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_init(struct
>>>> amdgpu_device *adev, void *m,
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>>>>                   (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0)=
;
>>>> -    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
>>>> +    tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
>>>> +                prop->allow_tunneling);
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
>>>>       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
>>>>       mqd->cp_hqd_pq_control =3D tmp;
>>>> --
>>>> 2.43.0
>>>>
>>


--_000_DM6PR12MB47311E2E63582B226AF4556AF98AADM6PR12MB4731namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">Christian, firmware has nothing to do with it and doesn't control it. Tha=
t was a wrong group of people to ping.
 It's only implemented in the SPI and tested by the SPI team and PAL team.<=
/span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Marek</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> December 8, 2023 09:38<br>
<b>To:</b> Friedrich Vock &lt;friedrich.vock@gmx.de&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Olsak, Mar=
ek &lt;Marek.Olsak@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Enable tunneling on high-priority c=
ompute queues</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 08.12.23 um 12:43 schrieb Friedrich Vock:<br>
&gt; On 08.12.23 10:51, Christian K=F6nig wrote:<br>
&gt;&gt; Well longer story short Alex and I have been digging up the<br>
&gt;&gt; documentation for this and as far as we can tell this isn't correc=
t.<br>
&gt; Huh. I initially talked to Marek about this, adding him in Cc.<br>
<br>
Yeah, from the userspace side all you need to do is to set the bit as <br>
far as I can tell.<br>
<br>
&gt;&gt;<br>
&gt;&gt; You need to do quite a bit more before you can turn on this featur=
e.<br>
&gt;&gt; What userspace side do you refer to?<br>
&gt; I was referring to the Mesa merge request I made<br>
&gt; (<a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/=
26462">https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/26462</a>)=
.<br>
&gt; If/When you have more details about what else needs to be done, feel<b=
r>
&gt; free to let me know.<br>
<br>
For example from the hardware specification explicitly states that the <br>
kernel driver should make sure that only one app/queue is using this at <br=
>
the same time. That might work for now since we should only have a <br>
single compute priority queue, but we are not 100% sure yet.<br>
<br>
Apart from that the hardware documentation only says that it's a nice to <b=
r>
have feature and when we pinged firmware engineers to get more <br>
information they didn't know the feature immediately either.<br>
<br>
That is usually a strong indicator that stuff was implemented in the <br>
hardware, but not fully completed and tested by the firmware team and <br>
validation team.<br>
<br>
Alex and I need to confirm that this feature actually works the way it <br>
should and that it's validated/stable/read for production use.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; I'm happy to expand this to add the rest of what's needed as well.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Friedrich<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 08.12.23 um 09:19 schrieb Friedrich Vock:<br>
&gt;&gt;&gt; Friendly ping on this one.<br>
&gt;&gt;&gt; Userspace side got merged, so would be great to land this patc=
h too :)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 02.12.23 01:17, Friedrich Vock wrote:<br>
&gt;&gt;&gt;&gt; This improves latency if the GPU is already busy with othe=
r work.<br>
&gt;&gt;&gt;&gt; This is useful for VR compositors that submit highly laten=
cy-sensitive<br>
&gt;&gt;&gt;&gt; compositing work on high-priority compute queues while the=
 GPU is busy<br>
&gt;&gt;&gt;&gt; rendering the next frame.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Userspace merge request:<br>
&gt;&gt;&gt;&gt; <a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merg=
e_requests/26462">https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests=
/26462</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Friedrich Vock &lt;friedrich.vock@gmx.de&gt=
;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 10 +++++=
+----<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp; =
|&nbsp; 3 ++-<br>
&gt;&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp; =
|&nbsp; 3 ++-<br>
&gt;&gt;&gt;&gt; &nbsp; 4 files changed, 11 insertions(+), 6 deletions(-)<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt; index 9505dc8f9d69..4b923a156c4e 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt; @@ -790,6 +790,7 @@ struct amdgpu_mqd_prop {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t eop_gpu_addr;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hqd_pipe_priority;=
<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hqd_queue_priority=
;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool allow_tunneling;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool hqd_active;<br>
&gt;&gt;&gt;&gt; &nbsp; };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt;&gt;&gt; index 231d49132a56..4d98e8879be8 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&gt;&gt;&gt;&gt; @@ -620,6 +620,10 @@ static void amdgpu_ring_to_mqd_prop(s=
truct<br>
&gt;&gt;&gt;&gt; amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct=
 amdgpu_mqd_prop *prop)<br>
&gt;&gt;&gt;&gt; &nbsp; {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D ring-&gt;adev;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool is_high_prio_compute =3D ring-&gt=
;funcs-&gt;type =3D=3D<br>
&gt;&gt;&gt;&gt; AMDGPU_RING_TYPE_COMPUTE &amp;&amp;<br>
&gt;&gt;&gt;&gt; + amdgpu_gfx_is_high_priority_compute_queue(adev, ring);<b=
r>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; bool is_high_prio_gfx =3D ring-&gt;fun=
cs-&gt;type =3D=3D<br>
&gt;&gt;&gt;&gt; AMDGPU_RING_TYPE_GFX &amp;&amp;<br>
&gt;&gt;&gt;&gt; + amdgpu_gfx_is_high_priority_graphics_queue(adev, ring);<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(prop, 0, sizeof(*pro=
p));<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; @@ -637,10 +641,8 @@ static void amdgpu_ring_to_mqd_prop(s=
truct<br>
&gt;&gt;&gt;&gt; amdgpu_ring *ring,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prop-&gt;hqd_active =3D rin=
g-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_KIQ;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; if ((ring-&gt;funcs-&gt;type =3D=3D AM=
DGPU_RING_TYPE_COMPUTE &amp;&amp;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_g=
fx_is_high_priority_compute_queue(adev, ring)) ||<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ring-&gt;func=
s-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX &amp;&amp;<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_g=
fx_is_high_priority_graphics_queue(adev, ring))) {<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; prop-&gt;allow_tunneling =3D is_high_p=
rio_compute;<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (is_high_prio_compute || is_high_pr=
io_gfx) {<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pro=
p-&gt;hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pro=
p-&gt;hqd_queue_priority =3D <br>
&gt;&gt;&gt;&gt; AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt;&gt;&gt; index c8a3bf01743f..73f6d7e72c73 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt;&gt;&gt;&gt; @@ -6593,7 +6593,8 @@ static int gfx_v10_0_compute_mqd_ini=
t(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev, void *m,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);<br>
&gt;&gt;&gt;&gt; &nbsp; #endif<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_C=
ONTROL, TUNNEL_DISPATCH, 0);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_C=
ONTROL, TUNNEL_DISPATCH,<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prop-&gt;allow_tunneling);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, PRIV_STATE, 1);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_control =
=3D tmp;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt;&gt;&gt; index c659ef0f47ce..bdcf96df69e6 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
&gt;&gt;&gt;&gt; @@ -3847,7 +3847,8 @@ static int gfx_v11_0_compute_mqd_ini=
t(struct<br>
&gt;&gt;&gt;&gt; amdgpu_device *adev, void *m,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (order_base_2(AMDGPU_GPU_PAGE_=
SIZE / 4) - 1));<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);<br>
&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_C=
ONTROL, TUNNEL_DISPATCH, 0);<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_C=
ONTROL, TUNNEL_DISPATCH,<br>
&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prop-&gt;allow_tunneling);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, PRIV_STATE, 1);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, =
CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pq_control =
=3D tmp;<br>
&gt;&gt;&gt;&gt; -- <br>
&gt;&gt;&gt;&gt; 2.43.0<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB47311E2E63582B226AF4556AF98AADM6PR12MB4731namp_--
