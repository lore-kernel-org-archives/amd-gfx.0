Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3251CC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E526C6195C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 09:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E526C6195C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DACF6E885;
	Tue, 30 Mar 2021 09:11:55 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB1F6E883
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksLN+Z4EyDk40GNPd48hL+I+ENaLV3hcXre6EM2QQBym20HBEgvf1fF/f8k9KzjpD4305mk2T+NxKJqW5b92/XwrJn0qQFHU900QR0wij3etd6rd+OR5X/Pqc5GK1XoZV+juyFC98TZPwqVAtt7CxFSXWD4w9H15qcAb8j4ZUF7sg2S6lw0y8m5CiSCktEGJy5IiGOisfAALgNTDOsUL7dn37GItLa2LSGNetEJJt77b4NkFb3okEW0oUDr2ce04bfOVUvAxEE3xaRs4BlvZuLbxM1xCzD6JolAfYAHcXjP63L533Umx5pKpGDpfZyFLxkp5IeRC3DaMmqpCMPmZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6XnBBvESG6oTF/JPdYmGTRNrcRAWmWdVGb2NVUKGdg=;
 b=mF2NnJT2Q7eBEkgOLGDTT9VtqzbDijCOptCOJm2BtZJRteziN4EHR6ZbFDgL2G+ZWwoyNx4/msH1VgqcO0jv3dugQFIcz48HzMPxOQWOtIWG8V2cmumFo+5eIg5KJ1ul2p4xQZg1bWZC3qFf26nIIGCJ+kcK6kS3MQohKoThSrLVqTegqmnFo5vUaWzmdI2LVGtQ+PDeBqhuMDI3S/PNO3TXjSQWFPXttFiXShdiT6tGuM3x4is0NYDM6brUZkbylZzAf4+VUv7TI0+PkqjnSqVGsHKP+VWH3M1OFh5Yw/w39IcFTPx6ZLpupP9Ft1qOKFcqHuuvxWOPwNXk4Crhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6XnBBvESG6oTF/JPdYmGTRNrcRAWmWdVGb2NVUKGdg=;
 b=w2ITbMFMUBwVecdj0uAJ9OLY4q2Lv4MctPElJUB2gHdJ2cg/wP9gtCNp+H6EFk7X9xR5dzZSTjmOGas1kab7VEZqNBW/XUUPBM9WeTwnbRdWvO5Qj8ozn2ahnXSDzOMGxqjLmJrJUCuZBqssl7J07VEI2IITAr5vvB2L3BeB9oc=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3142.namprd12.prod.outlook.com (2603:10b6:a03:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 09:11:50 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 09:11:50 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Topic: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Thread-Index: AQHXJR8L/peRjH4zbEygsNZNCOiQ/KqcF2cAgAAD3/CAAAIggIAAEpPwgAAFvwCAAAd98A==
Date: Tue, 30 Mar 2021 09:11:50 +0000
Message-ID: <BY5PR12MB4115FB3C4AB29EA63028515A8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
 <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <a9a978f1-fbd6-a90a-d966-ab2ebc2bc4f5@gmail.com>
 <BY5PR12MB41156DDEF8EAF5CE77B2AD598F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <df01f5bf-b4f0-9e93-0ef7-0caee4633fb7@gmail.com>
In-Reply-To: <df01f5bf-b4f0-9e93-0ef7-0caee4633fb7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=68f8b601-9544-4faa-9bed-9113c6a6ed56;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T09:04:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b32d6c82-48df-48c7-96ee-08d8f35bda44
x-ms-traffictypediagnostic: BYAPR12MB3142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31426D24BB205DBF8B5647D98F7D9@BYAPR12MB3142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IH+x7Axpz388uLvWZN6eYcs/OqfMEfJ0VnXeyRPuBwDhfN9lz0ExrpG0ZW7uh7F70lyzgj85QSilrQT3MVG5ggEBcYW+oYI3PD1OSx1vdtAut50NIIvqHrDoPc3pxAUArnfEJeYcOupshtCXvWQvC7y3lbVMeuTJ9IecxrhvEFfNW9yRmymk745lvYsXUEqYiSuDQ8k42OkUmhu/VPs8QNdtV452QFTVBnvkZcIhG+o1WF+Gyai5SnZxSQOgi3QUpja2u6zpsPqKcGdYVjjnA44lyxJPt3ub3ZKnpFjulFyU8PWDwNkYVMfUuGvUvy1WhCZ/1ecVYNLYvxxqyb7boEdLzeORLKgr60TMgfW+o2M7aCCO88JctCnjm1phdb/j3KmW3S/my5Sxa1ZfyW9hmDVeDiHzAsi05IW4WBABjHaM7DlEJ18r77o3nKv20kSNmo4/EnwCK+knY3yhzJQUidBxzvUIS0xZj0m+LE8jjNalYZdlkQRUelXeoojDbHQ+Q7FKHChERk2f1AHm2yjwBbP422Ijo1vncaoKQdD5p9WHANAX+5idlUbLn644TCTApHPk33W3dwG1z5HwNfWjFgaoXrnGq++fB9nzEfnifgVRppo/cD2N0tUOUuHtdCrYlsZo+EX3hHKmIj1YXW4qGQQyeuKy/DKMNbhlUNTmu6bQ2O4gX1+vcmYyIuiEqwkRjvcz3OD6gxWGm/oETYDeK8D38z+cEJdfGr/tKDByCJUNXwDoy9AjSA71EbEpYlka
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(5660300002)(186003)(478600001)(52536014)(110136005)(64756008)(45080400002)(9686003)(66556008)(83380400001)(66446008)(55016002)(86362001)(316002)(26005)(2906002)(53546011)(38100700001)(7696005)(8676002)(76116006)(33656002)(71200400001)(66476007)(66574015)(66946007)(8936002)(966005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?60a6XwJcsi1hMX7fWZzC6SIAIzLdNdK/tnyzN7si0IX978T0bn73Cl2Z+t?=
 =?iso-8859-1?Q?htHmV9w8NwAODQtBN/WN5CCtc3bALo2d5Z7R87zGrZHcjuFgNrRMU3TgTd?=
 =?iso-8859-1?Q?Tc4CL/Gb5ChBfz1RIBsNOJRfRTPwwiZ6slEmPby3wtc3IU990pD9fbYd9/?=
 =?iso-8859-1?Q?ZwXM3/3im4D9tX+1cfr2RdGTFeGPgAVcxjvC+ZyYPj3moQD8kErfLzpPUI?=
 =?iso-8859-1?Q?DiM1Zc6ualWGcpvrGDYram0r6UZSU/eQVrC7ySzh9tZWAAZKvIieIXAX11?=
 =?iso-8859-1?Q?DG++yuYcxJ1lJXWm+mxBBNzm5ceTlRTFjRpo1NEN4yUno7Om6xsGs54CTW?=
 =?iso-8859-1?Q?RZR3iXiwSMRJAvmrfS/S/hpNFdVkirT1hH5NsjREVVm9Shv9UBJpqroea5?=
 =?iso-8859-1?Q?Z8Ilx4+plHYucAHyIVi+p4yItm5OqVtxdf5O0AEIW1L1+Cv51CBSV5C0gb?=
 =?iso-8859-1?Q?+9AQU9k9MRKWxBzfR7UAH+YDnn2uqxOZ3xfhYz4CmPnq0/rItylI4XnhGh?=
 =?iso-8859-1?Q?CaVjzzkX6j1eaHmLCug3YgNhyvtMiVQnUakJzozaIdDeh1ph31rDdKZDA3?=
 =?iso-8859-1?Q?Y9IaCj3MKjH6evEZFKuVUU7dKinyZMDxYU9GzOapDFgH81/OoVa5JSmp3g?=
 =?iso-8859-1?Q?5d0agbVWAvffgaiaC9n3uLW+/TVEsY1ttgX4qS3E4kGzlncBy247/GnE/Q?=
 =?iso-8859-1?Q?S5rYWAr3MT32Xqd8ww1z7e+uduaY6xI1JrESTRYGDfI3Kmb+W1//qwz2AM?=
 =?iso-8859-1?Q?vTX5XPz2okorAbJN4ypw5hngx3AbaiSJJ+JF46UTjvGTyIOstyLoz1mp5l?=
 =?iso-8859-1?Q?srZCK6YGc8tvQxs0BNLZDyYKibYqgCA9GImq8rxIpqqSr/d6fhezjB6Ipj?=
 =?iso-8859-1?Q?yKG0SmEPjDAv4ivYCV5+sDCb30ANZoLnCuqfcnEH6Q3jmXtJV8zDUho5qD?=
 =?iso-8859-1?Q?Rh8vYP6UUmLOoe3wyDw1J/i7vNSnumHN6vqUBZ10+ts3OYyxP852Yx1sYj?=
 =?iso-8859-1?Q?WgG7DtnFCDUNc614zZgV+zqs+O3A/VaJXbL6Eat6fVOFF2UuWD6RGSlMcz?=
 =?iso-8859-1?Q?tEigcyp06tEbgLW8Auj24ZWJs5LTcVDKlSZNka6ZTkchtFuqZP0rjXvRvK?=
 =?iso-8859-1?Q?b9H4I4G/I9ggt5vaHEW91FdkgTWBDEyyOAmAWpRXlmnOIdph+oMjoO6anC?=
 =?iso-8859-1?Q?hfekCnfKEWPJ/y4dSrlAnN798sGQ3rKoq4b8Eau7YrQkZguiOBguWcR/HK?=
 =?iso-8859-1?Q?mMzcmpZe1uFuZcGhtqIu8Twt4yUPXpW9QYaYrV6FcclcQbl+juvGLSJ0Qx?=
 =?iso-8859-1?Q?mCtSBqupLLbTRjvLMVmqONniJPT9/Fw+A/s4SyemYEWUrj5aHJMpRI9LE1?=
 =?iso-8859-1?Q?nAgRWgUK+2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32d6c82-48df-48c7-96ee-08d8f35bda44
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 09:11:50.0495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQf6IBW6Q3KSWjbBSS2hpC2oSDFONuL/oapv6gS3Zh4PZWdNbmQj6YrINopaKXwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3142
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
     Ok, will investigate this more for memory leak. But even I fixed this =
memory leak this time, it couldn't promise anymore memory leak in future. M=
emory leak shouldn't cause kernel crush, and couldn't
be used anymore.

Best wishes
Emily Deng



>-----Original Message-----
>From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>Sent: Tuesday, March 30, 2021 4:38 PM
>To: Deng, Emily <Emily.Deng@amd.com>; Chen, Jiansong (Simon)
><Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>
>Hi Emily,
>
>as I said add a WARN_ON() and look at the backtrace.
>
>It could be that the backtrace then just shows the general cleanup functio=
ns,
>but it is at least a start.
>
>On the other hand if you only see this sometimes then we have some kind of
>race condition and need to dig deeper.
>
>Christian.
>
>Am 30.03.21 um 10:19 schrieb Deng, Emily:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Hi Christian,
>>       Yes, I agree both with you. But the issue occurs randomly and in
>> unload driver and in fairly low rate. It is hard to debug where is the m=
emory
>leak. Could you give some suggestion about how to debug this issue?
>>
>>
>> Best wishes
>> Emily Deng
>>
>>
>>
>>> -----Original Message-----
>>> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Tuesday, March 30, 2021 3:11 PM
>>> To: Deng, Emily <Emily.Deng@amd.com>; Chen, Jiansong (Simon)
>>> <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>>
>>> Good morning,
>>>
>>> yes Jiansong is right that patch is really not a good idea.
>>>
>>> Moving buffers can indeed happen during shutdown while some memory
>is
>>> still referenced.
>>>
>>> Just ignoring the move is not the right approach, you need to find
>>> out why the memory is moved in the first place.
>>>
>>> You could add something like WARN_ON(adev->shutdown);
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 30.03.21 um 09:05 schrieb Deng, Emily:
>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>
>>>> Hi Jiansong,
>>>>        It does happen,  maybe have the race condition?
>>>>
>>>>
>>>> Best wishes
>>>> Emily Deng
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
>>>>> Sent: Tuesday, March 30, 2021 2:49 PM
>>>>> To: Deng, Emily <Emily.Deng@amd.com>; amd-
>gfx@lists.freedesktop.org
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>> Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>>>>
>>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>>
>>>>> I still wonder how the issue takes place? According to my humble
>>>>> knowledge in driver model, the reference count of the kobject for
>>>>> the device will not reach zero when there is still some device mem
>>>>> access, and shutdown should not happen.
>>>>>
>>>>> Regards,
>>>>> Jiansong
>>>>> -----Original Message-----
>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>> Emily Deng
>>>>> Sent: Tuesday, March 30, 2021 12:42 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>>>> Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>>>>
>>>>> During driver unloading, don't need to copy mem, or it will
>>>>> introduce some call trace, such as when sa_manager is freed, it
>>>>> will introduce warn call trace in amdgpu_sa_bo_new.
>>>>>
>>>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>>>> ---
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
>>>>> 1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index e00263bcc88b..f0546a489e0d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct
>>>>> amdgpu_device *adev,  struct dma_fence *fence =3D NULL;  int r =3D 0;
>>>>>
>>>>> +if (adev->shutdown)
>>>>> +return 0;
>>>>> +
>>>>> if (!adev->mman.buffer_funcs_enabled) {  DRM_ERROR("Trying to move
>>>>> memory with ring turned off.\n");  return -EINVAL;
>>>>> --
>>>>> 2.25.1
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
>>>>> is
>>>>> ts.fr
>>>>> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>>>>>
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
>>>>> =3D0
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
>>>> st
>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>>> gfx&amp;data=3D04%7C01%7CEm
>>>
>ily.Deng%40amd.com%7Cffacb4715aff4ba4336808d8f34af62d%7C3dd8961fe4
>>> 884e
>>>
>608e11a82d994e183d%7C0%7C0%7C637526850578585302%7CUnknown%7CT
>>> WFpbGZsb3
>>>
>d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>>> 3D%7
>>>
>C1000&amp;sdata=3Du26JPASmJOF5nkXFSJP89PiUUFehvzf%2B2qxQM%2FgT9Ek
>>> %3D&amp
>>>> ;reserved=3D0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
