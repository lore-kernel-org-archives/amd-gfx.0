Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E0C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:20:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FFF6196C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FFF6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B506E876;
	Tue, 30 Mar 2021 08:19:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9C36E876
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I103uDCD8Ag+8qQpTP1/qfxWtGJUrYGniv8zv7TUaKy6lRnHGfFmjfRXKEPWdVVTQnvkBlMxIlD2ySgC3L0XasJAgsQsndlK1ObzLhgFZsLQAI5pVXFwZwrDhU7xwDco5brdl4xnQlxzGOE8AGwrbh6vK1HyfcIHB1Eze4Wl/st+0SDm3eQWaoWUdaaORR2ikiURpHMkJ1k5O+TnoT2kT6GzO5KZhaYSQpoBUtsXb2aPEvkRWN2ZbJIGDfL/zmKgiXG43l4TIWLhjkiLewGyUrqTCwOy5Z5a8aupsCbVkF2O4RGc10yERbu42U31itrgeA3FsFMSEmiBdndUNFrT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T615UGgi9/bD/NZfIFmEm/d9244YoJC86k7yz3PuwEQ=;
 b=GwL6lUZoTcpBKwxXDT4fPDXTxEhLNDudgkbgUclHHt5fS4/UXlDBBeAN+CtyaVWKOvCM7a6MC0hQj+zxpPoWv7OuWq3KLuGKtXpwx8YixHyeC8L9PAPAa0xfccSqXrUffUUg7OhT3dmGXYyMuPGUczp0VZpgOhhCUTiP8iiT07s7g5mlC7Sz1kZTZL1WfABiX+yGqXV8yrtW25hjOlNlg7N3giR16j24hVAq0aic7Bp5dTi58u4i6q04WlO/FZG5H+lAlKXDdDWNO7inLfuW/3XbiYtWgyFmG3X32QFw5ueMjTjpwIptV3lOMhqDcC728hN//Gj88kYViS+aEfDC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T615UGgi9/bD/NZfIFmEm/d9244YoJC86k7yz3PuwEQ=;
 b=j12OXjhuDnNUBYYR/deqxu4+EYX/Wt8pyw1uXoiHxM0FoJaXLcxT5OIiR+mttd2Bh9hbxo7EdPrsH+Fox3UERjKtu/sKNQybU280vUXlSmVKRgaF0wa/EKfwnsKgz1e7Xsnfy10/rkXYs1exM8BnjsfM4rqnU+XnRehLpYZkT8o=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 08:19:55 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 08:19:54 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Topic: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Index: AQHXJR8L/peRjH4zbEygsNZNCOiQ/KqcF2cAgAAD3/CAAAIggIAAEpPw
Date: Tue, 30 Mar 2021 08:19:54 +0000
Message-ID: <BY5PR12MB41156DDEF8EAF5CE77B2AD598F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
 <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <a9a978f1-fbd6-a90a-d966-ab2ebc2bc4f5@gmail.com>
In-Reply-To: <a9a978f1-fbd6-a90a-d966-ab2ebc2bc4f5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=862999c7-e255-48d5-9055-7e74595ac6e8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T08:17:22Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 448c63b9-b451-4771-e48f-08d8f354994f
x-ms-traffictypediagnostic: BY5PR12MB4276:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42762882602403E4F32E8E8A8F7D9@BY5PR12MB4276.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/oZb8asYlTrbapetbFB0krhTV6o62IjNdMVJGIZBl0vY34Xs6eSr8vB9uLhP+5aof6HxrXcB7zAFG1dgDgfPRxQh4TBhTdI3bTpufFm6VaVKLaCYCW3ZPaHk3pa+AO0th7lc2cSnumgFWtxzo7Xt0AbwNg/NgmFOlnH7pCuDKrrxDwnyXrDKnQ6ceQjSmLiBmNDm1yK/m6vkUtXvIutGDmz9YfCGI8W0emyAskgy+QG8wKYSs60etd82fgc0gRM0A5D7SQfr1GMoyXrsEuuVCqe6BJmhD3cIzxpN2Z/hNWWjN6MHgVodAzx9PvkuhR2t3oThQLQDATpp11h9naThVx3Z6/ELtcrUQboyolTH5A16TzEGh4BWW4LQH8u3C0mUDSmp1JvgzbV4X7HG1vtV5rbAzE7mSJhfe6L2MhaHXPyE/Z+5wBuPwyC2EfrSEtowNUyZmmL9MsBbgVT8iIs9wGVjvXfSyRmkOK59/ZU42JTOlhaJQicLJc1bmXkdYoPEfIwPUfmD4s1+4BGZi542ZTiKqYmgS6ZrPfks+b5EO7HvkkKooUk17h1Mrzic6ksfxdJVNFQR4ryqz/f89OACzeBFLrt4ig4/9/MJiaNOPJFQqisgLVl/uPsNuUjGHaBJy3sOmTyNJh+DM6ycpgtAfBL6Wkq6uXZxaaBP5TWCTwxhm/vwssCWu2aXf0oEhTkFns9l2GFnMlCfMrMsvl6g0pMogGPiib1N/TEn/BcNcAEsq8Jd/KxjpehGQoPWJlH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(2906002)(55016002)(9686003)(66556008)(6506007)(45080400002)(53546011)(7696005)(66446008)(52536014)(86362001)(71200400001)(8676002)(186003)(66574015)(26005)(33656002)(64756008)(5660300002)(76116006)(966005)(316002)(8936002)(38100700001)(478600001)(66946007)(110136005)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?PvLRlXi5PLjb7THeVL9RZRAHpsYy4g7xBLlmRCDej/RDIp45PBEt311Nx9?=
 =?iso-8859-1?Q?LzCyun+ukUqzok12crZf9ZWamapJwTkG/qmxPMbhOUrcv+xQAMz5980Wmw?=
 =?iso-8859-1?Q?b33NRDUkNMcqNH41M/0ztvWjanIUqk2pHvRl8EpM7Pn/33/gi1d2mv8xqS?=
 =?iso-8859-1?Q?SeUsESU70vcICaAkAm4Fv5CvpP+wVbOkPBQN4yuNYvQOZLIaVOvVHWRezr?=
 =?iso-8859-1?Q?hDchHamC2EbAPSaLNMPiJSGCj9nsAuz+yq8NQ8UUJkNg160l0eb/pZxyB3?=
 =?iso-8859-1?Q?6rbRs4R/hHXcIviVXO41y5m6qu+AMr6SmlwZvLXhdYubsMcLbkdza2AThl?=
 =?iso-8859-1?Q?ltjhyL0tATIACluqRQEnlCRV6J7shVxUi/xVLHMepQX/oUhvVz95q8mpUg?=
 =?iso-8859-1?Q?Ee4le5lWT65wbvbDofDRaQGd8BDCBSovFHjxjJUg0/ZY40jZP3LwTmwzCv?=
 =?iso-8859-1?Q?w0rDJ+KSQWyXnmAth3S8EV4XXfdQR4NwBLgXH1XZ5m0Dha7KkaoRXF4hvd?=
 =?iso-8859-1?Q?0KhUaOXXYVH9b7E3M1kiRcNt3ids2X8Pt13Elcsi4+NkbukeiLqwPmm/Ze?=
 =?iso-8859-1?Q?Vy2SbCyGQ1NooHW2b2Y3RnO2naVlngFTyGmVgZf4hZJoGkgM3avq/fmxSl?=
 =?iso-8859-1?Q?ADHXwDFMoM03hiUuK2QjsAxHJg1Txe7DlyODtVIRDgy4SNNCCy0GWrjoFw?=
 =?iso-8859-1?Q?xfsmTKC0jnjOzNKgNnMR50trzYMx6MrPEDt0NYZmr20s7bkbIz3KAs+QSR?=
 =?iso-8859-1?Q?5H4zjgr30bCEoPrXTP+uR/cbnEc0F36x0BCH+UOjpmI2+F1Auh4UEpjrpg?=
 =?iso-8859-1?Q?RLq6ETmXyyxjgn21i1xhYzIPS6UiB3aBr32MY/IJLGzRSACHoF2QoLUEuL?=
 =?iso-8859-1?Q?TQ9jpwgIo4doWsw4IGNV17WpLyayf9YNDe5iyKjM1N/3PU0081KrMkjF+E?=
 =?iso-8859-1?Q?6QKxQRmz5EiQcY21Z2d+r4L4KIjl/NHndbM3VTwkv4NglYzMktSZv1jcVq?=
 =?iso-8859-1?Q?UFc5Hn77xpyUGfO69LjL5/Qegyg6xnR6JLhXRBj+k6BnamXniWkT/+onOC?=
 =?iso-8859-1?Q?USEOrbYhesxM2ydJZ+7W7tXUxiyr1ADP2IwjL62ufutjwl9dEg5BjUiVyS?=
 =?iso-8859-1?Q?RQBJ0z52oSeJZfy8j4oeQnxKTRFXv8+sCX4OUndqVvxHKQGLwlUSxh9nsD?=
 =?iso-8859-1?Q?UZri1QcmXxPcmHe7VgmIw78HbA2Ew9HieiEDBIe5vt+QwCyPNnIHsBTuTt?=
 =?iso-8859-1?Q?bbolS3M/bbywrQxNKM48j5+IFexS5JYd6ytknPeUNfSA+lDebLzh/H4BIx?=
 =?iso-8859-1?Q?dUD/9lf5wq2Z26TROD75tnP8waBVRIy7IEk/K2iLccMycxhzWz36OCGKnV?=
 =?iso-8859-1?Q?olsKLXP7Wm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448c63b9-b451-4771-e48f-08d8f354994f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 08:19:54.5776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHg44UKVhJOZ8ZsCgZVEUS9IFDGMj10wIgABMjk5EW0cC/2WmY2AApI+WFqj9DWZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

Hi Christian,
     Yes, I agree both with you. But the issue occurs randomly and in unloa=
d driver and in fairly low rate. It is hard to debug where is the memory le=
ak. Could you give some suggestion about how
to debug this issue?


Best wishes
Emily Deng



>-----Original Message-----
>From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>Sent: Tuesday, March 30, 2021 3:11 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Chen, Jiansong (Simon)
><Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>
>Good morning,
>
>yes Jiansong is right that patch is really not a good idea.
>
>Moving buffers can indeed happen during shutdown while some memory is
>still referenced.
>
>Just ignoring the move is not the right approach, you need to find out why=
 the
>memory is moved in the first place.
>
>You could add something like WARN_ON(adev->shutdown);
>
>Regards,
>Christian.
>
>Am 30.03.21 um 09:05 schrieb Deng, Emily:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi Jiansong,
>>       It does happen,  maybe have the race condition?
>>
>>
>> Best wishes
>> Emily Deng
>>
>>
>>
>>> -----Original Message-----
>>> From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
>>> Sent: Tuesday, March 30, 2021 2:49 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>> Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>>
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> I still wonder how the issue takes place? According to my humble
>>> knowledge in driver model, the reference count of the kobject for the
>>> device will not reach zero when there is still some device mem
>>> access, and shutdown should not happen.
>>>
>>> Regards,
>>> Jiansong
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>> Emily Deng
>>> Sent: Tuesday, March 30, 2021 12:42 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>> Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>>
>>> During driver unloading, don't need to copy mem, or it will introduce
>>> some call trace, such as when sa_manager is freed, it will introduce
>>> warn call trace in amdgpu_sa_bo_new.
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index e00263bcc88b..f0546a489e0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct
>>> amdgpu_device *adev,  struct dma_fence *fence =3D NULL;  int r =3D 0;
>>>
>>> +if (adev->shutdown)
>>> +return 0;
>>> +
>>> if (!adev->mman.buffer_funcs_enabled) {  DRM_ERROR("Trying to move
>>> memory with ring turned off.\n");  return -EINVAL;
>>> --
>>> 2.25.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>>> ts.fr
>>> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>>>
>gfx&amp;data=3D04%7C01%7CJiansong.Chen%40amd.com%7C1b4c71d7b96247
>>>
>6a367508d8f3362f40%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>>>
>C637526761354532311%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>>>
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
>>>
>a=3DRxRnZW0fmwjKSGMN1nf6kIHRdAPVs9J5OBluDYhR6vQ%3D&amp;reserved
>>> =3D0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEm
>>
>ily.Deng%40amd.com%7Cffacb4715aff4ba4336808d8f34af62d%7C3dd8961fe4
>884e
>>
>608e11a82d994e183d%7C0%7C0%7C637526850578585302%7CUnknown%7CT
>WFpbGZsb3
>>
>d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>3D%7
>>
>C1000&amp;sdata=3Du26JPASmJOF5nkXFSJP89PiUUFehvzf%2B2qxQM%2FgT9Ek
>%3D&amp
>> ;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
