Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D94C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 14:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1EF663214
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 14:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1EF663214
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830656EC47;
	Tue, 16 Nov 2021 14:54:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527226EC47
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 14:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXiX2LdRQfnc6uqNulr0bu3Wwp/Wsio8gamQf2C/YbRQlF21x8NR9a91iw+883fNKCMtl+Etw2vIVbAfS8q0ChdYDpRTasODi8QQf4X/OdNIFqbs9721/QfctavlQoFQf+LrmmlTOt6sC6uFt/6fmtfxDtB9KAREAhc3Bf2QYRTTotTdmBwhjzdMPhQpmOGzssj0RlDJko/trUv8WWR1EwX/2EjTMvTCFPhhq0M1P86CE8pLSvZYPleLMWcxzqWWPQNizKEw0T5N0nkHFGrambXT9zE0jXQhk9xdkDDw2ZGotpSLvcLv75nqgPQaeMf1SVB6qIbW3M70eK5dDglGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk7OWv5RjDSBOMNDhXH9RhWLuZ/5G+iFkTmYs/3sQz4=;
 b=FpA6Eq/eDkNJw3XbqCc19CfwD7CMCm8S/x7VyB+H5XzDFsyTTMXujHMl+t9DLVDActQOnjA/JFjHOzJah1s7GGT7MjaJfCdU6Wgfyv8m6T4c1IWB85SVwZ6uTAR4HFV9UDdcc227t7YPpxSk6WURGdbXPH1CNrzjWSs0gsc58Ha1tHzf1JYZ/eWYvaHrB1qzO6YW127StHUibj+xMksghGmR6r/GJBwgIxnh2S4yPCJ6SyubwbI9uQqIY9LLAEvEcWz0DuP2LFd8Rn09YwJJGRo2sOhymO24YecueoXui7EUzZZGmpmN4X3sMYgeurCvTOQS3f7+v6ErlUvqlyW6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk7OWv5RjDSBOMNDhXH9RhWLuZ/5G+iFkTmYs/3sQz4=;
 b=1MuXtTuY8l0HB+X+iMvuxBvHi+6SIR/hE6TLfCBBDx8pgIHaLU14jkDDIMYE/a6f9cQn4vqceSjCNI5F98+E5wumjkaWoiPCYEH68XekswGZkONvk8KpK1jSedfPrq3AWRtJpA3Rl1835tfL3RiF+OQVohusg8bzvyUGBu0xg/o=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 14:54:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 14:54:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] drm/amdgpu: stop getting excl fence separately
Thread-Topic: [PATCH 2/6] drm/amdgpu: stop getting excl fence separately
Thread-Index: AQHXy/90e58HNXRXKEmeqC0EbqgNuav+HLCAgAf5B4CAAEX+pg==
Date: Tue, 16 Nov 2021 14:54:39 +0000
Message-ID: <BL1PR12MB5144364CCC4069636EAC7140F7999@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211028132630.2330-1-christian.koenig@amd.com>
 <20211028132630.2330-2-christian.koenig@amd.com>
 <d82038f9-c1f5-2ede-f867-efe843cee1a6@gmail.com>
 <e263bccc-41f0-4183-884e-dc07ca1bcbc9@gmail.com>
In-Reply-To: <e263bccc-41f0-4183-884e-dc07ca1bcbc9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T14:54:39.189Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: fccbb0e7-99ad-a4d2-f8ad-e9c54e006388
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 788d9285-f414-4269-4904-08d9a9110437
x-ms-traffictypediagnostic: BL1PR12MB5109:
x-microsoft-antispam-prvs: <BL1PR12MB5109DA9F694D5E3BFB52BAC5F7999@BL1PR12MB5109.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C95NTSp78O9RUDWQvcgCLIb7OPxEljCD28AhDqEHVqe3CICcQMb77lo4rg6809GXOXn1DZq0p57BFOcjqo37uPTsHWryzJnqDIzI3j82chK1BVl7RmiReOjVuZWpSulq+RSq5d2odHg1jsM7WIn0LITRJEYHe6Lzt9ccHNWlmdNNEbRZ1oIUhUDUq3G9XUc0nkE7b/UMstM4qepUm5sqNHK05PZakEIf6V22iX+5LGHj25ZEI07z4ZAiQC19MsHXPoPdTqHV+DFnZ67DFrYIxswrZMKAu1mjBSBQwEOPjOmyV6yov3X1EuJK4G3ckyNPwCVCmUm1UiEDCUw201BpwIzkrCE63esjAVgvNM37nZxiAjEsFsqxx3AFntFqTSJbHef5or3DL88XnEgFv4O4GlWEk6+b024BspPl0O+Hhb9qFCxeu4ZEvHr7bJBJ6xiWFHAckYfVcI4lQg3SLYP+iaNN/PD8HzHEw6OxvLimd0Iwdnx7Pc+ySQaHrE5QXhle/PWu+75maIYxPIFofgdxp/vW6mqlzLhnw7PtSYbtKbNAPKbgZ8L0UJwNyd+vvqE3B7vW0z7FCUuFdJJs3A7vY6K8lHgnh2EmZRkhkSrNypx+LZCUBvfUkqP4vv55Pp+Oi4oh/lz7kGHP+OmJKJ9dXupwYeohHjN+NuLy2/Dkjt6tVe+6IAIo2Dqp0Dm1Goevm5axCq9Rb6XImFpLvTIeCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(86362001)(122000001)(55016002)(8936002)(19627405001)(8676002)(38100700002)(66574015)(186003)(53546011)(508600001)(6506007)(66476007)(66446008)(5660300002)(66946007)(64756008)(66556008)(110136005)(38070700005)(2906002)(71200400001)(316002)(33656002)(7696005)(52536014)(76116006)(83380400001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uINlUmKomatpvNMqSeuGX7d75zHcvaEg2TDbb2cmFCrAi06/V7NYuGm2kY?=
 =?iso-8859-1?Q?JEEwfgY2Aj/Hy7PbI63ShK86a+UxqDDjRphRA26DrJ31eoEVXUnceW5UKc?=
 =?iso-8859-1?Q?Gc/RFEzzDp6zUeI/CBABzLmi/3gYBZvNx82kILdFuAWNY48lwDHwEAKYu/?=
 =?iso-8859-1?Q?9nadjMpgkQQzg/yUK9aQQYQzd3/DXGKlPZqZHR+wL+v0eMh+2lrwmSJFy+?=
 =?iso-8859-1?Q?WHVmC3hupFe7FlYSrWvW3iE2yW1vZmm3T4Cu7T8Lziap3op49HOdw4rGzB?=
 =?iso-8859-1?Q?HvsjQqtU1mmQbDsPwmC8x7X6xjiRWyHRKTbPtyy0W19/QwTNxV2tPAtRHa?=
 =?iso-8859-1?Q?5CwDvHVB5Fq8w5Pz6sHgMPhwV16m51P6vATm/NcOMtFhWviDGMcw/2uaY2?=
 =?iso-8859-1?Q?1yaYRF0KeSCKXYwypNd2SIBGg+UB+194hDJ0W76lYQZ3/+NQUdJNeVUzN2?=
 =?iso-8859-1?Q?eIAe55/hFE8WNwJXkaNFGy1VQfLI2pBKT71ShzAsNLYtn2MFVUje+W6wek?=
 =?iso-8859-1?Q?vySpatmiwVLlDliiLf5/AEFFNwPKUlfp898sYyGawlIJuDGK+rAgTQTZwN?=
 =?iso-8859-1?Q?Lkcdx7Vk9qt5nJRqoZlvrZQQEefG/egcO2rmBkA1pScQN08Hc4QV1WGyvR?=
 =?iso-8859-1?Q?ZaxddaDqG5Y3fGaWh7wNEytQOcDNmK+fB4MnYxgj2tb+k+gyLp/C6H0V7z?=
 =?iso-8859-1?Q?4vVnn0cwOmKbr69+PCmAAuzgS66OtSbjbq1Eb0DHVgPu/7NXVlxfS4Xbu8?=
 =?iso-8859-1?Q?x5glO3M/LFinB8VHfQDRELu1vuxCLt33ZtqWt98oHBs3MrzcwKrMDpeFus?=
 =?iso-8859-1?Q?JPPBx4P/7frsZ6p/oM34i2jN/q5NHQoJIstT0JYzMOElOSV1XtewI2i/Yj?=
 =?iso-8859-1?Q?4dQQW7cyyGAzap9NJEuaEWh7vNdSdoYBK/F/+Q/ZhOlMfwAAxBcaC7Y2M1?=
 =?iso-8859-1?Q?x5Q6tM+e7RgS/sJJdMbZ3cWpeA2Ijc3NW40zT9eu0VH3wKv9eSvUcgSn7d?=
 =?iso-8859-1?Q?j0GgROaxf7U3M8DilaA0L1PwYvi93cYqF+NjQBGMoW6IPUcZjTBY27JQXu?=
 =?iso-8859-1?Q?Fgco+oz3m4CqIC7mrrOD8+mmJIWuOzQrMra/DeU4iaALdBdl0EwQs4V6+e?=
 =?iso-8859-1?Q?eWEdr0jZM+Et7PXS5RU3jvM4s9DTT4IQu7gGBYK11OkeNykblf2NbL6j8P?=
 =?iso-8859-1?Q?RukjhhAceoDbGBraVV/vyzBPviyJ2hHbrJc6xw7Fp1A0hFEY0Vkk9T8BXQ?=
 =?iso-8859-1?Q?tyIaa5W++pM55oyhvrPAj022e7a8J1weUKYA6VypqusY20CBH+bxWj2vl4?=
 =?iso-8859-1?Q?tY6UDLQ5PgaXqFRn33iYBD73IA5u/shuOmaROaQr5qfemOuDNoa1jZqmzE?=
 =?iso-8859-1?Q?g31EmN1w/7jPFjlyX7fGy42jVfjB2dHkSATqUWSxY7rSeGqPyfCvJ5gvth?=
 =?iso-8859-1?Q?LeHsPzfpGnfS7FF/dvtd13W1kf+ONTIfZUSkFy74lsY0nHdcXQG0QDGBUm?=
 =?iso-8859-1?Q?Fw5siu0AiCWqCWMgZydmTw+apDCBeFl0C0d/uliHmylo7P00JUdAR1jg28?=
 =?iso-8859-1?Q?vHfab7Zd4YyyiJnFPWi4GFS0dkrGytRrDyVo1Ehd79BzxXjbxWhQApzf1V?=
 =?iso-8859-1?Q?nH4+GWKA28qQQ7ZkdXTf46IR+45seFK+csIIZoPBTOPZeKmKl2n2SI3KBs?=
 =?iso-8859-1?Q?XJE5vjWlyHxjssVD31c=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144364CCC4069636EAC7140F7999BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788d9285-f414-4269-4904-08d9a9110437
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:54:39.7476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQcM4RvDTmlRD4pnqw5WPe6TTyvYw17Knk7F5kbUjsGKydlGBRYbgSqGPDs73zPbZ/wUABKXm0PRjfmf+z8/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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

--_000_BL1PR12MB5144364CCC4069636EAC7140F7999BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, November 16, 2021 5:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: stop getting excl fence separately

Adding Alex.

Once more a ping to the mailing list.

Thanks,
Christian.

Am 11.11.21 um 09:58 schrieb Christian K=F6nig:
> Just a ping to the amd-gfx list.
>
> Trivial cleanup, can anybody give me an rb for that?
>
> Thanks,
> Christian.
>
> Am 28.10.21 um 15:26 schrieb Christian K=F6nig:
>> Just grab all fences for the display flip in one go.
>>
>> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +-----
>>   2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d58e37fd01f4..4da7eb65e744 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -457,7 +457,6 @@ struct amdgpu_flip_work {
>>       uint64_t            base;
>>       struct drm_pending_vblank_event *event;
>>       struct amdgpu_bo        *old_abo;
>> -    struct dma_fence        *excl;
>>       unsigned            shared_count;
>>       struct dma_fence        **shared;
>>       struct dma_fence_cb        cb;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index dc50c05f23fc..68108f151dad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -83,9 +83,6 @@ static void amdgpu_display_flip_work_func(struct
>> work_struct *__work)
>>       unsigned i;
>>       int vpos, hpos;
>>   -    if (amdgpu_display_flip_handle_fence(work, &work->excl))
>> -        return;
>> -
>>       for (i =3D 0; i < work->shared_count; ++i)
>>           if (amdgpu_display_flip_handle_fence(work, &work->shared[i]))
>>               return;
>> @@ -203,7 +200,7 @@ int amdgpu_display_crtc_page_flip_target(struct
>> drm_crtc *crtc,
>>           goto unpin;
>>       }
>>   -    r =3D dma_resv_get_fences(new_abo->tbo.base.resv, &work->excl,
>> +    r =3D dma_resv_get_fences(new_abo->tbo.base.resv, NULL,
>>                   &work->shared_count, &work->shared);
>>       if (unlikely(r !=3D 0)) {
>>           DRM_ERROR("failed to get fences for buffer\n");
>> @@ -253,7 +250,6 @@ int amdgpu_display_crtc_page_flip_target(struct
>> drm_crtc *crtc,
>>     cleanup:
>>       amdgpu_bo_unref(&work->old_abo);
>> -    dma_fence_put(work->excl);
>>       for (i =3D 0; i < work->shared_count; ++i)
>>           dma_fence_put(work->shared[i]);
>>       kfree(work->shared);
>


--_000_BL1PR12MB5144364CCC4069636EAC7140F7999BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, November 16, 2021 5:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/6] drm/amdgpu: stop getting excl fence separat=
ely</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Adding Alex.<br>
<br>
Once more a ping to the mailing list.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 11.11.21 um 09:58 schrieb Christian K=F6nig:<br>
&gt; Just a ping to the amd-gfx list.<br>
&gt;<br>
&gt; Trivial cleanup, can anybody give me an rb for that?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 28.10.21 um 15:26 schrieb Christian K=F6nig:<br>
&gt;&gt; Just grab all fences for the display flip in one go.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<=
br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 1 -<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +-----<br>
&gt;&gt; &nbsp; 2 files changed, 1 insertion(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; index d58e37fd01f4..4da7eb65e744 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt; @@ -457,7 +457,6 @@ struct amdgpu_flip_work {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_pending_vblank_event *ev=
ent;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; *old_abo;<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; *excl;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_count;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; **shared;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; cb;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt;&gt; index dc50c05f23fc..68108f151dad 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt;&gt; @@ -83,9 +83,6 @@ static void amdgpu_display_flip_work_func(struct=
 <br>
&gt;&gt; work_struct *__work)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int vpos, hpos;<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (amdgpu_display_flip_handle_fence(wo=
rk, &amp;work-&gt;excl))<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt; -<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; work-&gt;share=
d_count; ++i)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_=
display_flip_handle_fence(work, &amp;work-&gt;shared[i]))<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return;<br>
&gt;&gt; @@ -203,7 +200,7 @@ int amdgpu_display_crtc_page_flip_target(struc=
t <br>
&gt;&gt; drm_crtc *crtc,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unpin;=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; r =3D dma_resv_get_fences(new_abo-&gt;t=
bo.base.resv, &amp;work-&gt;excl,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; r =3D dma_resv_get_fences(new_abo-&gt;tbo.base=
.resv, NULL,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;work-&gt;shared_count, &amp;work-=
&gt;shared);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0)) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&=
quot;failed to get fences for buffer\n&quot;);<br>
&gt;&gt; @@ -253,7 +250,6 @@ int amdgpu_display_crtc_page_flip_target(struc=
t <br>
&gt;&gt; drm_crtc *crtc,<br>
&gt;&gt; &nbsp; &nbsp; cleanup:<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;work-&gt;old_a=
bo);<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; dma_fence_put(work-&gt;excl);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; work-&gt;share=
d_count; ++i)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_p=
ut(work-&gt;shared[i]);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(work-&gt;shared);<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144364CCC4069636EAC7140F7999BL1PR12MB5144namp_--
