Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD3C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFD62223E
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFD62223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1109F89C1F;
	Tue, 19 Jan 2021 03:23:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7597889B84
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 03:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2bCS8fSjdAtV1QeoUE3Zi4mjbIOB8q2pDdo0P6lF+wrNGHYiEziLIw119IvtzF+ihahG4mfXkRSSsGTiSgzegvLnCKMCTZ0ltfZvPzXv66b6kV16+2Xyl0iDpdsZGm+YUaqv8e6V8caXi8bj5fIO23wo5RkILUQ8qRImB4/FDrXXtZora8CnapqmxD9MS042E3sDqi9hF5N37zdc86kxu/9JpjtVaqV0WB2Yr1Pa/+0W72Xw5gqB3lvLQfG49MRf1mOFbSKq9f2IhAxcoMigZ+AYzmfy8pPpWJJrD+jAQXqY1YWsOvh+zw2wVt+845ZGd8tWy6Hl7GQWZWC3UIhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuyDAtGmHkcbDvhNOa9EUbPKtByqL8io+heJwhg2gmY=;
 b=K2m2zVNrtroFEntx7M5+kc3zjPFgvvsw9XIVgysRi03bnZffdBakA1cl8Qb85hfobrpcDgYw9URg32BVpx6Zz+9taH2wr7EZ+AKjoFxD4XTKKIf39tcIWZLUyFq6jXLIlH/CiXXF7jXFG9SDlum41HWGCmHP6sLIW/x+IWK+bpqrj6keAzGNWe1rKsgF1Gg83wHUCp8Mbk4HqutKNgH8BwKG10L4gG9FMVFn6k34D7p0Xys/itEUUEXs0K2JlTxdCaXGo06qK8XKv/NAwBRs5rSjIr4RWY6mXBk6dxzt4keLVTDXJ0p8XgMvnU257e/WvJ6DT3DXQGiIlUJFGQTSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuyDAtGmHkcbDvhNOa9EUbPKtByqL8io+heJwhg2gmY=;
 b=fJYMU2GvUd/7AsEvBxMZSH5+KZ6u+JXWPqOU4tnnLvpul8twr73wIXXes1AVDTj0ij/OSccUu39u8+wo6+bu74qnm4H7X5baOZUUPr5/Gr3HsSd6spddMSCFGbi43VB45EOygJ6r9+1y+fDoOxbdj5LH7EJEzoW7bJodVU9PqcU=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 03:23:51 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 03:23:51 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Sun, Roy"
 <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Topic: [PATCH] drm/amdgpu: change the fence ring wait timeout
Thread-Index: AQHW6XZ9N1P5j4AyYk2NBhFMHNW1HaollrIAgADHCuCAAMeggIAFgmlwgABh9wCAAEUEUIAARU+AgAC7pLA=
Date: Tue, 19 Jan 2021 03:23:51 +0000
Message-ID: <BY5PR12MB4115F1DB8C96B09C763A487E8FA30@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210113063612.31468-1-Roy.Sun@amd.com>
 <318aa468-c009-8edf-d6bd-8408ee79c42e@gmail.com>
 <BY5PR12MB41152A0706EA9F1A7D0E88288FA80@BY5PR12MB4115.namprd12.prod.outlook.com>
 <bf77173f-1c26-70bd-75c7-81178f1b3e70@amd.com>
 <BY5PR12MB4115F8236F52722D43CA0BDF8FA40@BY5PR12MB4115.namprd12.prod.outlook.com>
 <05ae70f5-2692-7b64-359d-c307f02b93bf@amd.com>
 <BY5PR12MB41150A7947A27D2A52F76B9E8FA40@BY5PR12MB4115.namprd12.prod.outlook.com>
 <e34e2deb-2c52-a4ad-c436-1b59ecdaa28b@gmail.com>
In-Reply-To: <e34e2deb-2c52-a4ad-c436-1b59ecdaa28b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2b5053dd-1712-4fbe-918f-e3e626421441;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-19T03:15:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1316abc6-036e-4943-9ac0-08d8bc29a4b9
x-ms-traffictypediagnostic: BYAPR12MB3141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3141F235B5503C26C14CF46E8FA30@BYAPR12MB3141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgEZ7d3rVhAVtLY+z0mmq37HDIdxhm/5u+HWGE5+7Iks0hHys/ZRgBJgS0tXtTHGwwgTHDcYYpMjFETg5qe04wzNLZNwdlQV0LGSgvqS8dv6v1Y/9ALCE0h1uBnRjw0a1iuOIuJzHLJBe0D92OQXBWpKoiSrUXY9z+nk+95acj43GmGInbiAFxkky2aUMFzK2XY7PdLLFBftZRrIbQ7sC2egNmK/T1Prhs2mlDfE8UiOqcLya56CVAd9ID638k+kPKzHpBE+oyMRWTj4iKb+Lbw/KAy8hgXw+UMMqOYncRYbbL0AgOTaYoS7EflTYlKns3yZFPeae/9tsQae14GSY88mW5JjB5XYNBh7626XQigDLS/eFSn+g72c0O+DkXVMCWrRULqJyyQbxO0AAQqojanxyVLSyBJ5R1PLwsSUoyj9E2rLeBJnotg10DtryWzcha5s6xv6MnVeG6uTpnqdMna/SjUadm7NuZC87DHz8mz/S/z2znkiaN7pJRngN730mnlbuzhzXA39I204cG+hekma5NO5D5/IuASZMnFriNJzSTJm9+In8OGm2QIxDOhfkPGlR6s2KANQMa+J2pnN6dfXBES3Rr4PVzU+ETgi7OQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(6506007)(33656002)(86362001)(9686003)(966005)(478600001)(110136005)(55016002)(52536014)(5660300002)(8936002)(66946007)(8676002)(30864003)(83380400001)(64756008)(2906002)(316002)(76116006)(45080400002)(53546011)(66446008)(71200400001)(186003)(66574015)(66476007)(66556008)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Xozm5Ro+8cdvfIMLR3XxU2ygFH9/FuzKH2B1bsMUYNjy+LOUr3GpLBdbL3?=
 =?iso-8859-1?Q?8ATtc6ajrhYNR6dB1BS5mv9X9ZsSxx9eMGxyJVcyT+36n5t8F5InCU7LJm?=
 =?iso-8859-1?Q?BHII/QmAcJ5Og//xv2s8HI4HUrrRgEgbByNqU26hMZQ/wGT31lz7anc/Sr?=
 =?iso-8859-1?Q?/E7e4Wc6gUGoJx9HUcDU2h/+iCG3NhLioef4yCd6w9BaDGyN+z4sII5CHy?=
 =?iso-8859-1?Q?NOgIm1UdHIk24gAuircgcI74bww6YxwbdDwEGhPJOnKnH2yAuo6SVHzCir?=
 =?iso-8859-1?Q?dJS40/Af4is237rX3XbnfXvBiSkZFmuaEgpNBvPW2idutFR8zrGBLmOJ4R?=
 =?iso-8859-1?Q?k5ALpB6iKKKn1wkXNde8t9VyExvi0Z3AALg1j1qK8f3ST8PQlCuLtJLPB1?=
 =?iso-8859-1?Q?2XoTw1RqHXuQqwnX2bG6rHXxSAKbrZsSEzQz0b2ORaKIw9uGwJjdKHUa/w?=
 =?iso-8859-1?Q?lBsjdGU/BpQY/FA2FZeOZ98BLwhfwGpUNa5rRbXLnv5KAizIPqsipvglL4?=
 =?iso-8859-1?Q?NoSEBPs0B0nTVSi1aZ5t9W56QzMvOyDYZ1MhUoX71ekmn9XjgtJDOzhUzF?=
 =?iso-8859-1?Q?iN9kYQJz5wjuZXREDoqD4k+7P4qV1ydZqPao4wY75NT3TLWhNGJMbsWpB2?=
 =?iso-8859-1?Q?fetdM49vV2X0lGbL+MIUgW9qL4oGW8k6cr/gXDBEgOuBn9FjNGqo6t+CqI?=
 =?iso-8859-1?Q?pNyeuSa6ORsHt+E9Q2MCcv+MV0LOym9uSgXRGDMicmx0MgyQ9XOnhOfvCV?=
 =?iso-8859-1?Q?SaNLTbJ6o+7diDo4qSWrnXuIa5GXNNjR5vfyECUdUNYHAXWFqqdWaFG+qw?=
 =?iso-8859-1?Q?9iujGMsDyIIFQtmODRw3CtVofF+NurHEAnC7+7IjZBPdtArInygF0RsZ3s?=
 =?iso-8859-1?Q?kqNTY97SCjje1iEOiQ8SBM2pfzPJuvBvMnCm+YW6hXC2so9geA1YjPD2ym?=
 =?iso-8859-1?Q?a4grPhZHICHRZwIhUJOFNL9qH66EG3qnwwhZduaXU6yPuw+98bqIkzFKnM?=
 =?iso-8859-1?Q?ga5JCcKaYWFiglRLmq0IjplKjdFBdtmfAfgPgTYqweyvHvgwlackI0xZEx?=
 =?iso-8859-1?Q?prUYX679RLI9J2mKAxWcWSZr+wJasTMsJarfyiyq4nf5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1316abc6-036e-4943-9ac0-08d8bc29a4b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 03:23:51.4640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kr3I7S6anFakCe4XmWUwZ+w/QjchNDzbWMiMjPaI5P7vyyyqqAnSdYRC0B3WkEGg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
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
>Sent: Tuesday, January 19, 2021 12:04 AM
>To: Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Sun, Roy <Roy.Sun@amd.com>; amd-
>gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
>
>Am 18.01.21 um 12:56 schrieb Deng, Emily:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Monday, January 18, 2021 3:49 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; Sun, Roy <Roy.Sun@amd.com>;
>>> amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
>>>
>>> Mhm, we could change amdgpu_fence_wait_empty() to timeout. But I
>>> think that waiting forever here is intentional and the right thing to d=
o.
>>>
>>> What happens is that we wait for the hardware to make sure that
>>> nothing is writing to any memory before we unload the driver.
>>>
>>> Now the VCN block has crashed and doesn't respond, but we can't
>>> guarantee that it is not accidentally writing anywhere.
>>>
>>> The only alternative we have is to time out and proceed with the
>>> driver unload, risking corrupting the memory we free during that
>>> should the hardware continue to do something.
>> Hi Christian,
>>      Thanks your suggestion, but still not quite clearly, could you deta=
il the
>solution to avoid kernel not lockup?
>
>Well as I said that the kernel locks up is intentional here.
So you think the lock up is better than only some memory corruption? Becaus=
e we could give more time, such as 60s to wait, I don't think the fence won=
't be signaled within 60s if the engine is good. So
when the engine is ok, it won't cause memory corruption with the timeout. W=
hen engine is bad, the fence will never be signaled, so even we force compl=
etion, it still won't cause memory corruption. As for sriov, when engine
is bad, we still could do recover, and do driver reload to make the driver =
works ok again, so we don't want the kernel lockup.
>
>Regards,
>Christian.
>
>>> Regards,
>>> Christian.
>>>
>>> Am 18.01.21 um 03:01 schrieb Deng, Emily:
>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Thursday, January 14, 2021 9:50 PM
>>>>> To: Deng, Emily <Emily.Deng@amd.com>; Sun, Roy
><Roy.Sun@amd.com>;
>>>>> amd-gfx@lists.freedesktop.org
>>>>> Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait timeout
>>>>>
>>>>> Am 14.01.21 um 03:00 schrieb Deng, Emily:
>>>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf
>>>>>>> Of Christian K=F6nig
>>>>>>> Sent: Wednesday, January 13, 2021 10:03 PM
>>>>>>> To: Sun, Roy <Roy.Sun@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: change the fence ring wait
>>>>>>> timeout
>>>>>>>
>>>>>>> Am 13.01.21 um 07:36 schrieb Roy Sun:
>>>>>>>> This fix bug where when the engine hang, the fence ring will
>>>>>>>> wait without quit and cause kernel crash
>>>>>>> NAK, this blocking is intentional unlimited because otherwise we
>>>>>>> will cause a memory corruption.
>>>>>>>
>>>>>>> What is the actual bug you are trying to fix here?
>>>>>> When some engine hang during initialization, the IB test will
>>>>>> fail, and fence will never come back, then never could wait the fence
>back.
>>>>>> Why we need to wait here forever? We'd better not use forever wait
>>>>>> which
>>>>> will cause kernel crash and lockup. And we have
>>>>> amdgpu_fence_driver_force_completion will let memory free. We
>>>>> should remove all those forever wait, and replace them with one
>>>>> timeout, and do the correct error process if timeout.
>>>>>
>>>>> This wait here is to make sure we never overwrite the software
>>>>> fence ring buffer. Without it we would not signal all fences in
>>>>> amdgpu_fence_driver_force_completion() and cause either memory
>leak
>>>>> or corruption.
>>>>>
>>>>> Waiting here forever is the right thing to do even when that means
>>>>> that the submission thread gets stuck forever, cause that is still
>>>>> better than memory corruption.
>>>>>
>>>>> But this should never happen in practice and is only here for
>>>>> precaution. So do you really see that in practice?
>>>> Yes, we hit the issue when vcn ib test fail. Could you give some
>>>> suggestions
>>> about how to fix this?
>>>> [  958.301685] failed to read reg:1a6c0
>>>>
>>>> [  959.036645] gmc_v10_0_process_interrupt: 42 callbacks suppressed
>>>>
>>>> [  959.036653] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.038043] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.039014] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.040202] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.041174] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.042353] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.043325] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.044508] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.045480] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.046659] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.047631] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.048815] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.049787] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.050973] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  959.051950] amdgpu 0000:00:07.0: [mmhub] page fault (src_id:0
>>>> ring:0 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
>>>>
>>>> [  959.053123] amdgpu 0000:00:07.0:   in page starting at address
>>> 0x0000000000567000 from client 18
>>>> [  967.208705] amdgpu 0000:00:07.0: [drm:amdgpu_ib_ring_tests
>>>> [amdgpu]]
>>> *ERROR* IB test failed on vcn_enc0 (-110).
>>>> [  967.209879] [drm:amdgpu_device_init [amdgpu]] *ERROR* ib ring
>>>> test
>>> failed (-110).
>>>>
>>>>
>>>> [ 1209.384668] INFO: task modprobe:23957 blocked for more than 120
>>> seconds.
>>>> [ 1209.385605]       Tainted: G           OE     5.4.0-58-generic #64~=
18.04.1-
>>> Ubuntu
>>>> [ 1209.386451] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>>> [ 1209.387342] modprobe        D    0 23957   1221 0x80004006
>>>>
>>>> [ 1209.387344] Call Trace:
>>>>
>>>> [ 1209.387354]  __schedule+0x293/0x720
>>>>
>>>> [ 1209.387356]  schedule+0x33/0xa0
>>>>
>>>> [ 1209.387357]  schedule_timeout+0x1d3/0x320
>>>>
>>>> [ 1209.387359]  ? schedule+0x33/0xa0
>>>>
>>>> [ 1209.387360]  ? schedule_timeout+0x1d3/0x320
>>>>
>>>> [ 1209.387363]  dma_fence_default_wait+0x1b2/0x1e0
>>>>
>>>> [ 1209.387364]  ? dma_fence_release+0x130/0x130
>>>>
>>>> [ 1209.387366]  dma_fence_wait_timeout+0xfd/0x110
>>>>
>>>> [ 1209.387773]  amdgpu_fence_wait_empty+0x90/0xc0 [amdgpu]
>>>>
>>>> [ 1209.387839]  amdgpu_fence_driver_fini+0xd6/0x110 [amdgpu]
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 48
>>>>>>> ++++++++++++++++++++---
>>>>>>>>      1 file changed, 43 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> index 6b0aeee61b8b..738ea65077ea 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>> @@ -41,6 +41,8 @@
>>>>>>>>      #include "amdgpu.h"
>>>>>>>>      #include "amdgpu_trace.h"
>>>>>>>>
>>>>>>>> +#define AMDGPU_FENCE_TIMEOUT  msecs_to_jiffies(1000)
>#define
>>>>>>>> +AMDGPU_FENCE_GFX_XGMI_TIMEOUT msecs_to_jiffies(2000)
>>>>>>>>      /*
>>>>>>>>       * Fences
>>>>>>>>       * Fences mark an event in the GPUs pipeline and are used
>>>>>>>> @@
>>>>>>>> -104,6
>>>>>>>> +106,38 @@ static void amdgpu_fence_write(struct amdgpu_ring
>>>>>>>> +*ring,
>>>>>>>> +u32
>>>>>>> seq)
>>>>>>>>      *drv->cpu_addr =3D cpu_to_le32(seq);
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * amdgpu_fence_wait_timeout - get the fence wait timeout
>>>>>>>> + *
>>>>>>>> + * @ring: ring the fence is associated with
>>>>>>>> + *
>>>>>>>> + * Returns the value of the fence wait timeout.
>>>>>>>> + */
>>>>>>>> +long amdgpu_fence_wait_timeout(struct amdgpu_ring *ring) { long
>>>>>>>> +tmo_gfx, tmo_mm, tmo; struct amdgpu_device *adev =3D ring->adev;
>>>>>>>> +tmo_mm =3D tmo_gfx =3D AMDGPU_FENCE_TIMEOUT; if
>>>>> (amdgpu_sriov_vf(adev))
>>>>>>>> +{ tmo_mm =3D 8 * AMDGPU_FENCE_TIMEOUT; } if
>>>>>>>> +(amdgpu_sriov_runtime(adev)) { tmo_gfx =3D 8 *
>>>>> AMDGPU_FENCE_TIMEOUT;
>>>>>>>> +} else if (adev->gmc.xgmi.hive_id) { tmo_gfx =3D
>>>>>>>> +AMDGPU_FENCE_GFX_XGMI_TIMEOUT; } if (ring->funcs->type =3D=3D
>>>>>>>> +AMDGPU_RING_TYPE_UVD ||
>>>>>>>> +ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCE || type =3D=3D
>>>>>>>> +ring->funcs->AMDGPU_RING_TYPE_UVD_ENC || type =3D=3D
>>>>>>>> +ring->funcs->AMDGPU_RING_TYPE_VCN_DEC || type =3D=3D
>>>>>>>> +ring->funcs->AMDGPU_RING_TYPE_VCN_ENC || type =3D=3D
>>>>>>>> +ring->funcs->AMDGPU_RING_TYPE_VCN_JPEG)
>>>>>>>> +tmo =3D tmo_mm;
>>>>>>>> +else
>>>>>>>> +tmo =3D tmo_gfx;
>>>>>>>> +return tmo;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      /**
>>>>>>>>       * amdgpu_fence_read - read a fence value
>>>>>>>>       *
>>>>>>>> @@ -166,10 +200,12 @@ int amdgpu_fence_emit(struct
>amdgpu_ring
>>>>>>>> *ring,
>>>>>>> struct dma_fence **f,
>>>>>>>>      rcu_read_unlock();
>>>>>>>>
>>>>>>>>      if (old) {
>>>>>>>> -r =3D dma_fence_wait(old, false);
>>>>>>>> +long timeout;
>>>>>>>> +timeout =3D amdgpu_fence_wait_timeout(ring); r =3D
>>>>>>>> +dma_fence_wait_timeout(old, false, timeout);
>>>>>>>>      dma_fence_put(old);
>>>>>>>>      if (r)
>>>>>>>> -return r;
>>>>>>>> +return r < 0 ? r : 0;
>>>>>>>>      }
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -343,10 +379,12 @@ int amdgpu_fence_wait_empty(struct
>>>>>>> amdgpu_ring *ring)
>>>>>>>>      return 0;
>>>>>>>>      }
>>>>>>>>      rcu_read_unlock();
>>>>>>>> -
>>>>>>>> -r =3D dma_fence_wait(fence, false);
>>>>>>>> +
>>>>>>>> +long timeout;
>>>>>>>> +timeout =3D amdgpu_fence_wait_timeout(ring); r =3D
>>>>>>>> +dma_fence_wait_timeout(fence, false, timeout);
>>>>>>>>      dma_fence_put(fence);
>>>>>>>> -return r;
>>>>>>>> +return r < 0 ? r : 0;
>>>>>>>>      }
>>>>>>>>
>>>>>>>>      /**
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
>>>>>>> Fl
>>>>>>> is
>>>>>>> ts.f
>>>>>>> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>>>>>>>
>>>
>gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7C8b116229938b463
>>>
>df87f08d8b7cbf607%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>>>
>C637461433936049544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>>>
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>>>
>ta=3DHOcLHmmblOUHXATFBl5HC6LOmFq0oXglAh2GFwd6sus%3D&amp;reserve
>>>>>>> d=3D0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEm
>>
>ily.Deng%40amd.com%7C5a6d3a94dc7d4190477a08d8bbcaa509%7C3dd896
>1fe4884e
>>
>608e11a82d994e183d%7C0%7C0%7C637465826316473967%7CUnknown%7
>CTWFpbGZsb3
>>
>d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>3D%7
>>
>C1000&amp;sdata=3D7XUhFg5H0FTO8RByofukETH7yBz9RBHKkUQmHZP3z34%3
>D&amp;res
>> erved=3D0
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7C5a6d3a94dc7d4190
>477a08d8bbcaa509%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637465826316473967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=3D7XUhFg5H0FTO8RByofukETH7yBz9RBHKkUQmHZP3z34%3D&amp;reserve
>d=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
