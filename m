Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B461BC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686B4206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 03:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686B4206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FB36E288;
	Wed,  6 May 2020 03:45:16 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700060.outbound.protection.outlook.com [40.107.70.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305A76E112
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 03:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6WfRsKJp85Ql/p7Ja96OLPUmWfGaPiW7i4a7Dr+RMFkyhrZW2JegffuKTorwtBBzFibOVY8JcRVzfwUN2cCIDSMgOy/hJSHC6D2zz61hxYHNdAZI9SbMspPkn027PumuEjU7nrC78SSQ6fvG+IRYdfS20dOX6zZ3CYvCzb7VE2c7uPoj4gaDpx9XkF0loXZhXvNmUs//c8vNjQhMVzL2kwDiiiYtRpMeti1QNX9AEmDS6XL+XZqDzPOwYnyvIYxja4XHhUDSKaTK7VrqLwj0nVJPCn1LOajUfWaIzNNLLSx43lpoNh7B+kYtdDcouzzzUZV8tsvsb/BtwxuRWzjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4nuI4BR+2dV2B48QLLN7F3UO2Kdlk0IyapvOoSbMR4=;
 b=dMpj9EvKPgbvMxio2z51HuS3I4RQ1/1LrG7zE3Z0QQZoaACifhS06wqBCWpF0clgftK/MNnjBzjN0jIRE0cXoP1cnrXFU0mO/E09WQMVMWloOapJlAMrPpAkfjybxAObDy/xgRIpXIzLimq44lf7vFAyRWP9MbNTDswLTzbMokTnchcGGDiMvY7kypzFBA/xoaqzxrgKe5ECg2h4u0W+20mwghPJN9DPw2LKGUC0OmU0V2zlF35cpolwB4MirXh3eXpi70Go/Nl7y6bsIgfB8NZU5SO/YwawBjCB327AubigfqoyoHcuNzwKCcE+s1O0g/CNmngWto2H6n0GtAtyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4nuI4BR+2dV2B48QLLN7F3UO2Kdlk0IyapvOoSbMR4=;
 b=XvLIzPWUPNjwoplaHFbC3PjJFGOtGNx2YTXcxZ7EhE0Xu4he6R9Cj6QgqjCHo/HRXby2/G+9RJtPZ2LVnTsTuXYUNnl1rAkwt8fW2F0T74HLL5ii7q7diei/rGHghF0M7GX1gAUHVHhD0zAdAGQII75eIi1quDPYSlNus3UaxQI=
Received: from BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 by BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 03:45:13 +0000
Received: from BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829]) by BY5PR12MB3844.namprd12.prod.outlook.com
 ([fe80::28a7:8f61:f016:d829%6]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 03:45:13 +0000
From: "Zhao, Jiange" <Jiange.Zhao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Topic: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4
Thread-Index: AQHWHeQFneDjep8xxUawreSEa51HXqiPjHKkgACWEoCAAAEOgIAKSwBw
Date: Wed, 6 May 2020 03:45:13 +0000
Message-ID: <BY5PR12MB384471B8C75E4001456A187AE1A40@BY5PR12MB3844.namprd12.prod.outlook.com>
References: <20200429050639.20859-1-jianzh@amd.com>
 <BY5PR12MB38443C7B1DE143B954671CECE1AD0@BY5PR12MB3844.namprd12.prod.outlook.com>
 <3b89b70e-6f21-241d-77e1-9cfbcbbde60b@amd.com>
 <c8ed8549-3cc7-2b67-70f9-016fab7016ad@amd.com>
In-Reply-To: <c8ed8549-3cc7-2b67-70f9-016fab7016ad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-06T03:45:09Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=799be26b-14b8-4e85-88de-00004fa473bf;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-06T03:45:09Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a098314b-4362-4da9-a804-0000f7fbeebc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4547abde-3971-4c10-d83c-08d7f16fe252
x-ms-traffictypediagnostic: BY5PR12MB3764:|BY5PR12MB3764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB37644C491DD9818144849302E1A40@BY5PR12MB3764.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iw1huZ7GiakuQA2dtMoccmmfXY7EFHyiBFYyAPY47v78tTP0t/E1QNb1qE/V6sFSf86EA3GDM/NFlt0Y0tdUxpz8bcnGzN1ZJIPr+haQ2hBnFE+Y7hIYCUMI4i0zx/eQFT37R99qsG8h28rGN/eCYrrBMLzOVnMR69W/lsoeJgQy4HycdD4oriiIgaaeG4Btlr6eWk6aTZeYozV/KlD8yoy72D1tsPrI/arnSTpifLN7qKRM5hPRQJM+7/jZc7QctS57sDVQUw2U2T53c9kSDm30b8YfdWsFiFHIth3Wx7z09Bup2RJTm0dMR8FWUtFgCw+/IKPWEyOkFEHYbEUN7dhb28XChc5Lu8UNgN4G+x4qAnMPo0/w2sBTkyGpyhHLdbrtxbc0BYNmpfimE47aZ2iXUqeXmDMU14M6yi/M3XPmNl3alnIHMzQO+fV1WqOrGKMoUPhHDMEaij2Mr2jQ+sKrvNbfEFed/TdAsELkHgmcVQRvlwYLLw/tMr85//RGZv2qPSDbFf+uOGsLUqwE+Nrr5p1GSSbqKtRETr8LYszD7Hk4BIU+En7ctH7q15ns
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3844.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(33430700001)(66446008)(76116006)(64756008)(55016002)(66946007)(7696005)(66476007)(9686003)(5660300002)(316002)(2906002)(30864003)(110136005)(54906003)(66556008)(4326008)(8676002)(33656002)(26005)(8936002)(71200400001)(33440700001)(478600001)(966005)(52536014)(86362001)(186003)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +3l13jmyUMyJRPzcpwxU+2M8UiNg7f4bXMoqvgWrxb6IGgkQdHOtGuSkuBWg/R5nrctUU+Mzw7OjxzdFTDGOIG1L7WImjXqKSyGunzEhv7E8tE8N2Nnigs2Oc6CencIlI2QbyG1gNUEIE04vIOSFRRaSotNRkozPrXJoD1RbXLd9hjaLyb+tKWUlIPTu5/XR8cAJT5XXO8sUzsb2yYbGQlMeFYp6Jpe1TMndEImI9PsIKAkaEyUXA71lzYT3zunorlldm6rhp6f3rzI6eitYhRq9IFFJwK9tPmxqp1rIrYbZTwmkL6q49IbMDu+4Gr1oKCMyi8w7OdwccPIVJ4bBYIrZ1kml4Gp3RMzyAS2E1k87fUZ6mwv9hNKJ0+xj+w21Q4+HRYgEvgNr7YVALUNc50qgSFgaNEfOeASv7xDxhneSKTDW6KgRLonZfjd6mkAKqn/5Gx4GlsjbHuB+zf5xYF5QRI4hdeiyDn0rAM2IdcsywbiS5mYGR/OlXt4dl8SC9G5kIcHv9+HqGQuZ/vydBunrGc7p57jiJgSGftYS1OvdP3E5FytQQf8/6XvcniHhGD9t1iTrbRHZmR7uEnmdpVDChmmKw73LzTp2jw57IAIdxq/BDfIYKdx55Gh41JsP2NKvPnWEsf0sKvd6gqdL/96Uc2YiYXUSKqAtkJt7RR+1RwYH3ey2wR1hc8NhH3P7/l3GXSH8HHVr96nhyFHe4msZtaQGO1u2AHzAZrZxzWNLsjzBAleFWhCpccscTRExQsgf9jjcezfJEzA06yBWmig8SENIVHNxXHR3rOjtjcg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4547abde-3971-4c10-d83c-08d7f16fe252
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 03:45:13.5789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp99OXOsgqNx5RuPKyHfHcWf1PPiYAtsLTEuaKMhlpKpJrJsB3GcuGVKvRYfnt5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3764
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Christian,

> Hi Jiange, well that looks correct to me, but seems to be a bit to compli=
cated. What exactly was wrong with version 3?
(1) If you open amdgpu_autodump, use it and close it, then you can't open i=
t again, because wait_for_completion_interruptible_timeout() would decremen=
t amdgpu_autodump.dumping.done to 0, then .open() would always return failu=
re except the first time.
(2) reset lock is not optimal in this case. Because usermode app would take=
 any operation at any time and there are so many race conditions to solve. =
A dedicated lock would be simpler and clearer.

> Please completely drop this extra check. Waking up the queue and waiting =
for completion should always work when done right.
This check is very necessary, because if there is no usermode app listening=
, the following wait_for_completion_interruptible_timeout() would wait unti=
l timeout anyway, which is 10 minutes for nothing. This is not what we want=
ed.

Jiange

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> =

Sent: Wednesday, April 29, 2020 10:09 PM
To: Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Zhao,=
 Jiange <Jiange.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zh=
ang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add autodump debugfs node for gpu reset v4

Am 29.04.20 um 16:04 schrieb Pierre-Eric Pelloux-Prayer:
> Hi Jiange,
>
> This version seems to work fine.
>
> Tested-by: Pierre-Eric Pelloux-Prayer =

> <pierre-eric.pelloux-prayer@amd.com>
>
>
> On 29/04/2020 07:08, Zhao, Jiange wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi all,
>>
>> I worked out the race condition and here is version 5. Please have a loo=
k.
>>
>> Jiange
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ---------------------------------------------------------------------
>> ------------------------
>> *From:* Zhao, Jiange <Jiange.Zhao@amd.com>
>> *Sent:* Wednesday, April 29, 2020 1:06 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix =

>> <Felix.Kuehling@amd.com>; Pelloux-prayer, Pierre-eric =

>> <Pierre-eric.Pelloux-prayer@amd.com>; Deucher, Alexander =

>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; =

>> Liu, Monk <Monk.Liu@amd.com>; Zhao, Jiange <Jiange.Zhao@amd.com>
>> *Subject:* [PATCH] drm/amdgpu: Add autodump debugfs node for gpu =

>> reset v4
>>   =

>> From: Jiange Zhao <Jiange.Zhao@amd.com>
>>
>> When GPU got timeout, it would notify an interested part of an =

>> opportunity to dump info before actual GPU reset.
>>
>> A usermode app would open 'autodump' node under debugfs system and =

>> poll() for readable/writable. When a GPU reset is due, amdgpu would =

>> notify usermode app through wait_queue_head and give it 10 minutes to =

>> dump info.
>>
>> After usermode app has done its work, this 'autodump' node is closed.
>> On node closure, amdgpu gets to know the dump is done through the =

>> completion that is triggered in release().
>>
>> There is no write or read callback because necessary info can be =

>> obtained through dmesg and umr. Messages back and forth between =

>> usermode app and amdgpu are unnecessary.
>>
>> v2: (1) changed 'registered' to 'app_listening'
>>  =A0=A0=A0 (2) add a mutex in open() to prevent race condition
>>
>> v3 (chk): grab the reset lock to avoid race in autodump_open,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 rename debugfs file to amdgpu_autodump,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 provide autodump_read as well,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 style and code cleanups
>>
>> v4: add 'bool app_listening' to differentiate situations, so that
>>  =A0=A0=A0 the node can be reopened; also, there is no need to wait for
>>  =A0=A0=A0 completion when no app is waiting for a dump.
>>
>> v5: change 'bool app_listening' to 'enum amdgpu_autodump_state'
>>  =A0=A0=A0 add 'app_state_mutex' for race conditions:
>>  =A0=A0=A0=A0=A0=A0=A0 (1)Only 1 user can open this file node
>>  =A0=A0=A0=A0=A0=A0=A0 (2)wait_dump() can only take effect after poll() =
executed.
>>  =A0=A0=A0=A0=A0=A0=A0 (3)eliminated the race condition between release(=
) and
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wait_dump()

Hi Jiange, well that looks correct to me, but seems to be a bit to complica=
ted. What exactly was wrong with version 3?

One more comment below.

>>
>> Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
>> ---
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 2 +
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 =

>> ++++++++++++++++++++-
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 14 ++++
>>  =A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=A0 |=A0 2 +
>>  =A04 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h =

>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index bc1e0fd71a09..6f8ef98c4b97 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -990,6 +990,8 @@ struct amdgpu_device {
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_number[16];
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 product_name[32];
>>  =A0=A0=A0=A0=A0=A0=A0=A0 char=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serial[16];
>> +
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_autodump=A0=A0=A0=A0=A0=A0=A0=A0=A0 au=
todump;
>>  =A0};
>>   =

>>  =A0static inline struct amdgpu_device *amdgpu_ttm_adev(struct =

>> ttm_bo_device *bdev) diff --git =

>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c =

>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 1a4894fa3693..1d4a95e8ad5b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -27,7 +27,7 @@
>>  =A0#include <linux/pci.h>
>>  =A0#include <linux/uaccess.h>
>>  =A0#include <linux/pm_runtime.h>
>> -
>> +#include <linux/poll.h>
>>  =A0#include <drm/drm_debugfs.h>
>>   =

>>  =A0#include "amdgpu.h"
>> @@ -74,8 +74,96 @@ int amdgpu_debugfs_add_files(struct amdgpu_device =

>> *adev,
>>  =A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>>  =A0}
>>   =

>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev) { #if =

>> +defined(CONFIG_DEBUG_FS)
>> +=A0=A0=A0=A0=A0=A0 unsigned long timeout =3D 600 * HZ;
>> +=A0=A0=A0=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state !=3D AMDGPU_AUTODUMP_LI=
STENING) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump=
.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> +=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);

Please completely drop this extra check. Waking up the queue and waiting fo=
r completion should always work when done right.

Regards,
Christian.

>> +
>> +=A0=A0=A0=A0=A0=A0 wake_up_interruptible(&adev->autodump.gpu_hang);
>> +
>> +=A0=A0=A0=A0=A0=A0 ret =3D =

>> +wait_for_completion_interruptible_timeout(&adev->autodump.dumping, =

>> +timeout);
>> +=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("autodump: timeout, m=
ove on to gpu =

>> +recovery\n");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ETIMEDOUT;
>> +=A0=A0=A0=A0=A0=A0 }
>> +#endif
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>>  =A0#if defined(CONFIG_DEBUG_FS)
>>   =

>> +static int amdgpu_debugfs_autodump_open(struct inode *inode, struct =

>> +file *file) {
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D inode->i_private;
>> +=A0=A0=A0=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0=A0=A0=A0 file->private_data =3D adev;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 if (adev->autodump.app_state =3D=3D AMDGPU_AUTODUMP_=
NO_APP) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D =

>> +AMDGPU_AUTODUMP_REGISTERED;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;
>> +=A0=A0=A0=A0=A0=A0 } else {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EBUSY;
>> +=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 return ret;
>> +}
>> +
>> +static int amdgpu_debugfs_autodump_release(struct inode *inode, =

>> +struct file *file) {
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 complete(&adev->autodump.dumping);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>> +static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, =

>> +struct poll_table_struct *poll_table) {
>> +=A0=A0=A0=A0=A0=A0 struct amdgpu_device *adev =3D file->private_data;
>> +
>> +=A0=A0=A0=A0=A0=A0 mutex_lock(&adev->autodump.app_state_mutex);
>> +=A0=A0=A0=A0=A0=A0 poll_wait(file, &adev->autodump.gpu_hang, poll_table=
);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_LISTENI=
NG;
>> +=A0=A0=A0=A0=A0=A0 mutex_unlock(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 if (adev->in_gpu_reset)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return POLLIN | POLLRDNORM |=
 POLLWRNORM;
>> +
>> +=A0=A0=A0=A0=A0=A0 return 0;
>> +}
>> +
>> +static const struct file_operations autodump_debug_fops =3D {
>> +=A0=A0=A0=A0=A0=A0 .owner =3D THIS_MODULE,
>> +=A0=A0=A0=A0=A0=A0 .open =3D amdgpu_debugfs_autodump_open,
>> +=A0=A0=A0=A0=A0=A0 .poll =3D amdgpu_debugfs_autodump_poll,
>> +=A0=A0=A0=A0=A0=A0 .release =3D amdgpu_debugfs_autodump_release, };
>> +
>> +static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev) =

>> +{
>> +=A0=A0=A0=A0=A0=A0 init_completion(&adev->autodump.dumping);
>> +=A0=A0=A0=A0=A0=A0 init_waitqueue_head(&adev->autodump.gpu_hang);
>> +=A0=A0=A0=A0=A0=A0 adev->autodump.app_state =3D AMDGPU_AUTODUMP_NO_APP;
>> +=A0=A0=A0=A0=A0=A0 mutex_init(&adev->autodump.app_state_mutex);
>> +
>> +=A0=A0=A0=A0=A0=A0 debugfs_create_file("amdgpu_autodump", 0600,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->ddev->primary->debugfs=
_root,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev, &autodump_debug_fops);=
 }
>> +
>>  =A0/**
>>  =A0 * amdgpu_debugfs_process_reg_op - Handle MMIO register =

>> reads/writes
>>  =A0 *
>> @@ -1434,6 +1522,8 @@ int amdgpu_debugfs_init(struct amdgpu_device =

>> *adev)
>>   =

>>  =A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_ras_debugfs_create_all(adev);
>>   =

>> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_autodump_init(adev);
>> +
>>  =A0=A0=A0=A0=A0=A0=A0=A0 return amdgpu_debugfs_add_files(adev, amdgpu_d=
ebugfs_list,
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =

>> ARRAY_SIZE(amdgpu_debugfs_list));
>>  =A0}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h =

>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index de12d1101526..51b4ea790686 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -31,6 +31,19 @@ struct amdgpu_debugfs {
>>  =A0=A0=A0=A0=A0=A0=A0=A0 unsigned=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 num_files;
>>  =A0};
>>   =

>> +enum amdgpu_autodump_state {
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_NO_APP,
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_REGISTERED,
>> +=A0=A0=A0=A0=A0=A0 AMDGPU_AUTODUMP_LISTENING
>> +};
>> +
>> +struct amdgpu_autodump {
>> +=A0=A0=A0=A0=A0=A0 struct mutex=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 app_state_mutex;
>> +=A0=A0=A0=A0=A0=A0 enum amdgpu_autodump_state=A0=A0=A0=A0=A0 app_state;
>> +=A0=A0=A0=A0=A0=A0 struct completion=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 dumping;
>> +=A0=A0=A0=A0=A0=A0 struct wait_queue_head=A0=A0=A0=A0=A0=A0=A0=A0=A0 gp=
u_hang; };
>> +
>>  =A0int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_init(struct amdgpu_device *adev);
>>  =A0void amdgpu_debugfs_fini(struct amdgpu_device *adev); @@ -40,3 =

>> +53,4 @@ int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
>>  =A0int amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>  =A0int amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> +int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c =

>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index e6978a2c26b7..8109946075b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3912,6 +3912,8 @@ static int amdgpu_device_pre_asic_reset(struct =

>> amdgpu_device *adev,
>>  =A0=A0=A0=A0=A0=A0=A0=A0 int i, r =3D 0;
>>  =A0=A0=A0=A0=A0=A0=A0=A0 bool need_full_reset=A0 =3D *need_full_reset_a=
rg;
>>   =

>> +=A0=A0=A0=A0=A0=A0 amdgpu_debugfs_wait_dump(adev);
>> +
>>  =A0=A0=A0=A0=A0=A0=A0=A0 /* block all schedulers and reset given job's =
ring */
>>  =A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct amdgpu_ring *ri=
ng =3D adev->rings[i];
>> --
>> 2.20.1
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
