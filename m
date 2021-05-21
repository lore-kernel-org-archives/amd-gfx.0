Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84933C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA60613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 14:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA60613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C116F87D;
	Fri, 21 May 2021 14:06:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925B66F87D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 14:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ8h++BQgQHHYvNBMyWH4XO/QPYvW4pUR2MAJaAV64kvtdDWY1N6/8bytIy3/L1osVEPeESvVCEDD3l0GeJTITP12EtIl33pRL/wKz9F9e0JzkIQT7xdIWxQUXzhzFtPMmDSGshyk0FSWSSj4oH9Pg/0IQR0WFMrqXQU/bXabUi6dLytP6ghPOtrBn6wnZjMlRErVJQUXejDZCE+4LP5jWpnffDadbQ/yRmlBSXe9f7GNDmZJmJV8+a1GwCZvpNJ9MFq4sl39tra3J2TIg2AvFBR0G4uYMPw0mNSv5oGeAyfcy2vP4MxAWXIza5QztbMVW7tnVcoTOl1+qqRI8II2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFbI596/zzNI5VN4+WLunqrGc9hAKg1dKg0wYdiQ3/Q=;
 b=hwDeUxSer1yjMIDtdVxEoEIzziuUR6x1wD9HrMZ/Wx1QzJW3xe+oZxarloh+Y/s+myNfu/WiIm2hLnbMY1H4k306R19W06XVIJMIWg8qwe44TAxIXaWB9C4PxhyZGJSkAhsu6lC0tVuju1xTn75WfwtBp8zSCdapYH3eWhYrFL/J3DmnGBplgGn6vUhkjqhNYONS8xxyLp5EvgtcL7fUThz46cnTvkMCk6LWYRdiNEuULs4VUdRZRC/8ojXANlqXbzenO5ETt8pCG77jQ7AjUEcGUF7P4JOqKZUx3SBbVUrNQxvbHkooTIczhKYwbF5m06f6j6XbGmQoWT/WH2QtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFbI596/zzNI5VN4+WLunqrGc9hAKg1dKg0wYdiQ3/Q=;
 b=ULXLROODpPIj3eE3p/0yvVirMz1o7lNvmYXIGHfc/JswzYx74GWBTET6r4/MBJJntTMtZxJX0zKcUqfz+JDrTBAqGMh7EtAdWXogv+RgPzOxfsUcbHcyQPrLrYCzqWOzD3+oB6al5x1kyg6iSws0xhD+3OpAUt4KyD9c+Fn8Nmw=
Received: from DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 14:06:11 +0000
Received: from DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297]) by DM4PR12MB5374.namprd12.prod.outlook.com
 ([fe80::dd20:3f66:e06a:2297%4]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 14:06:11 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug
Thread-Topic: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug
Thread-Index: AQHXTehHPHFg6/udf0OUQz1EhgYA6artnlYAgABVeYCAAASzhA==
Date: Fri, 21 May 2021 14:06:11 +0000
Message-ID: <DM4PR12MB53741C6084FB48DDAD5EFB0E80299@DM4PR12MB5374.namprd12.prod.outlook.com>
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
 <20210521022256.14184-3-Felix.Kuehling@amd.com>
 <b8803012-3642-4817-1ae4-e546b5605a47@gmail.com>,
 <f04777f5-0de1-fd61-41e4-28487e63a899@amd.com>
In-Reply-To: <f04777f5-0de1-fd61-41e4-28487e63a899@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-21T14:06:04.8321971Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.112.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da7113ef-b603-4386-17f5-08d91c619697
x-ms-traffictypediagnostic: DM4PR12MB5103:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5103620BE73D8F7F7F80E5B080299@DM4PR12MB5103.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5S3JoK9KBW8ScR5V93x/OSQ0fDd5kj3RuLBBuSiNAMFenFBxdi5OUCQchbH2fzHTIPwEKKj5Zh+n17dXD6M90wlESdk/TEqWLgVnpjKD+FupGb2WkeHR+iMwzdowJiY12LJ9uVuRBWtpCWLMyoe3So7qjx6dOnbd7e6tmOlkYfSsk/zjljm+PgDLh9Veds+1S/7GuFrJx5EOSXDifLH9chxtW9vYe9GHNXoY5od6PnKkpNGkcwAW2Pi+Ka9xpFw233PaanlbvI/Y4YXU2Hr7gDQAAS72pXtOric5pNNDPH28xtmBcavqLpGE1czwPwUhfQPzs3MHJ+/wxpR/mnuMZXahUMyoSUrZL0so7Zm7wvhKwiCGlxDE/43pPHpATC+UxVf6Umq1wjjOu+YNV7JgjqKh67hSVX7I4caaTJZc+zXReVglfXQnqCAEkygCjbHhvQTWfDcycP23jBSR75KjGXg75AZ2HSsqcxCbwhiwg/8ny7YtoEysNZPhxxjyYu5U7CjsPRjGhg64040oGx6hvBEWId/PXwxzZo6gNTRl4FcmC4Mu22wgYR5zKnJ9gx8fEg9EoWfBj2JbYc0CHme2OMwp6AdBew5T/d1hQY/3DHTOd/6yAfgdNAIETPMZYTs8DW7L3LnXKeYdnovc9RoboeZS6UOvMdTfXVyKbu/pp3QyrnwGpi/8FSp+7R1vVZ5/hyReSixqw0WhbS9KZjqikPdJTiBxlaOtdzNBVQZnL2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(366004)(396003)(346002)(376002)(8936002)(26005)(33656002)(83380400001)(122000001)(508600001)(966005)(5660300002)(166002)(86362001)(45080400002)(38100700002)(52536014)(6636002)(110136005)(66476007)(76116006)(91956017)(66556008)(186003)(64756008)(71200400001)(66946007)(66446008)(8676002)(2906002)(9686003)(55016002)(7696005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?rfhS4jg8Vzch72jzboka6hbJ/EobAEywPc3iGpCHB4RPhMm7nXyFHHHS7A?=
 =?iso-8859-1?Q?k2gsV+DQyLL56Nhrs0PAIegRTBa6kDE5Md2CSv833svd9nVmNd09XnknwG?=
 =?iso-8859-1?Q?rWdTv5GPfIMlA/bTvEvsLZbAdT953llLJu3rIqvvKgyj2dBwyzgxVjD16s?=
 =?iso-8859-1?Q?7z7iE+tBMpwnLkHfAQT3dKDdX65aRayulvz18WUmU4+dlsAmu7b0RBHLq+?=
 =?iso-8859-1?Q?CypsLb8DVZpb01NG0hz009AUovJGnKsTzFLCmlMb6TxLws6m01gNDMIV+u?=
 =?iso-8859-1?Q?yOHWMVpcIk5dlIg3ZEh8R/fC/p06SJlk54yg+hXXRhz+4YfK8ShAGW3iMN?=
 =?iso-8859-1?Q?/tZV7nRUfDjXk5zJZQs4F+vJPNFC68dEtXlxyBTwxQ4Iksv2WEEukk8OKi?=
 =?iso-8859-1?Q?pNm++SzeSG9890qmi3e6kch/peBSAfX1Ta1G36AlNMJt1A2Rf799is9P7h?=
 =?iso-8859-1?Q?Vf3u5peNRcSZoqj8bUwiAcnE07B6cS4jlKAGo8CuIXz0XQs/+SiyLKi5e1?=
 =?iso-8859-1?Q?FeV4RNpiCTIGD0ScQwCFqBYbyHATv4jaGDXI3mNi6+YJCPB2PPjThPvfjO?=
 =?iso-8859-1?Q?bHpnsOmVtNSAT7C+QgxyfVBq5FNrTP1DjZI5bN1xp/f/FU0urhfhZj7e+a?=
 =?iso-8859-1?Q?QYXJBl/rrNp3Sfh0SpWylWyFbHe2194cffld3z3v3BobBaHTCNeahG1jQj?=
 =?iso-8859-1?Q?xeEbpXi2K6Wa+0C8y3dWkLu7x+0qPE52P9MTXws5U2M2y70/H38Zt9s2YU?=
 =?iso-8859-1?Q?+D6tSSzRWF17czj6izCqaUO/dud2FKdxcFgvz9W0/CZzXjVimZDUhrrbHU?=
 =?iso-8859-1?Q?0h89r0yp68qNBw/ILuaWuSqxuVn04NfXtrOrq2F6b514PkLVMA51Y/6gCS?=
 =?iso-8859-1?Q?fBFYGlstAm/u+1gXS1AN8CUllv2W0J5FaemmXr4EdQjFrZewxJTUocPczb?=
 =?iso-8859-1?Q?/OSzstbTLCg9/phCmQsCZtCF5SHa5Nb/7LkEyTmM6mVBeYMsS/Z08EtxLR?=
 =?iso-8859-1?Q?5ZGdWE7N+MFis5G/0YkqQnR3wQtHDoabbfd+7a/pz7YiaN6jBaf/F2vcdg?=
 =?iso-8859-1?Q?LXb1yLNcHdtWCWWOMMSNHjfVY0zQDWVNm9OWW2fdyB7KIcMMgpagAe7Hwj?=
 =?iso-8859-1?Q?qYn9Ufpw27Hl9C1uE5jEtW+soFAQdujndtcCV02ylYHKvcNLoGnRqXE/y6?=
 =?iso-8859-1?Q?cHNE+v0nXvlwvtILPPQTcE2IUaXtsSkrAWDkVzcmzw+hBmA44aTDF9uHuM?=
 =?iso-8859-1?Q?0hFwHwzQFBYmPBu0WS+8Uq8J3aayq4Om4KS+xcnxqndhodNR447P0xSPE1?=
 =?iso-8859-1?Q?JojnVXJTwB/b2xz1m5+w62OOSdGy2gOqiPaWaotnjAN0ppomEsmkqc7zR8?=
 =?iso-8859-1?Q?f2+TgYPnKeXVja1MwxYaiK+HUt47wMxA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7113ef-b603-4386-17f5-08d91c619697
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 14:06:11.1723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvwUx6iUOpxlLUESyL5JgvWyFNaWVtBGS7gDD4kE/96h5uUetQQvMw6PUiDheNQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
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
Content-Type: multipart/mixed; boundary="===============1968918940=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1968918940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM4PR12MB53741C6084FB48DDAD5EFB0E80299DM4PR12MB5374namp_"

--_000_DM4PR12MB53741C6084FB48DDAD5EFB0E80299DM4PR12MB5374namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: oak zeng <oak.zeng@amd.com>


Get Outlook for Android<https://aka.ms/AAb9ysg>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <felix.kuehling@amd.com>
Sent: Friday, May 21, 2021 9:47:17 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug

Am 2021-05-21 um 4:41 a.m. schrieb Christian K=F6nig:
> Am 21.05.21 um 04:22 schrieb Felix Kuehling:
>> The intel IOMMU driver causes kernel oopses or internal errors flooding
>> kernel log when mapping larger SG tables. Limiting the size of
>> userptr BOs
>> to 6GB seems to avoid this.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> CC whoever is the maintainer of the Intel IOMMU driver?
>
> Would be nice to have that bug fixed instead.

Yeah, I'm not ready to submit this hack. I want to run some more
experiments to see what's going on.

Regards,
  Felix


>
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 2b8b89535198..3becf9d9f8fd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1409,6 +1409,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>           domain =3D alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;
>>           alloc_flags =3D 0;
>>       } else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>> +        /* workaround IOMMU driver bug */
>> +        if (size >=3D (6ULL << 30))
>> +            return -ENOMEM;
>>           domain =3D AMDGPU_GEM_DOMAIN_GTT;
>>           alloc_domain =3D AMDGPU_GEM_DOMAIN_CPU;
>>           alloc_flags =3D AMDGPU_GEM_CREATE_PREEMPTIBLE;
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Coak.zeng=
%40amd.com%7C123862fb48234bfa897008d91c5ef74d%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637572016476523870%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2HM3h=
csYI7i5LWoaiyOUlWLvUHAhCdudGsBrpT7E73Y%3D&amp;reserved=3D0

--_000_DM4PR12MB53741C6084FB48DDAD5EFB0E80299DM4PR12MB5374namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Reviewed-by: oak zeng &lt;oak.zeng@amd.com&gt;<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></div>
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Friday, May 21, 2021 9:47:17 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH v2 3/3] drm/amdgpu: Workaround IOMMU driver bug<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2021-05-21 um 4:41 a.m. schrieb Christian K=F6n=
ig:<br>
&gt; Am 21.05.21 um 04:22 schrieb Felix Kuehling:<br>
&gt;&gt; The intel IOMMU driver causes kernel oopses or internal errors flo=
oding<br>
&gt;&gt; kernel log when mapping larger SG tables. Limiting the size of<br>
&gt;&gt; userptr BOs<br>
&gt;&gt; to 6GB seems to avoid this.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt;<br>
&gt; CC whoever is the maintainer of the Intel IOMMU driver?<br>
&gt;<br>
&gt; Would be nice to have that bug fixed instead.<br>
<br>
Yeah, I'm not ready to submit this hack. I want to run some more<br>
experiments to see what's going on.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++<br=
>
&gt;&gt; &nbsp; 1 file changed, 3 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt; index 2b8b89535198..3becf9d9f8fd 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt; @@ -1409,6 +1409,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(=
<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D =
alloc_domain =3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags=
 =3D 0;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; KFD_IOC_ALLO=
C_MEM_FLAGS_USERPTR) {<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* workaround IOMMU dr=
iver bug */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt;=3D (6ULL=
 &lt;&lt; 30))<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return -ENOMEM;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D =
AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_domai=
n =3D AMDGPU_GEM_DOMAIN_CPU;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags=
 =3D AMDGPU_GEM_CREATE_PREEMPTIBLE;<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Coak.zeng%40amd.com%7C123862fb48234bfa897008d91c5ef74d%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637572016476523870%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am=
p;amp;sdata=3D2HM3hcsYI7i5LWoaiyOUlWLvUHAhCdudGsBrpT7E73Y%3D&amp;amp;reserv=
ed=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C0=
1%7Coak.zeng%40amd.com%7C123862fb48234bfa897008d91c5ef74d%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637572016476523870%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;a=
mp;sdata=3D2HM3hcsYI7i5LWoaiyOUlWLvUHAhCdudGsBrpT7E73Y%3D&amp;amp;reserved=
=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB53741C6084FB48DDAD5EFB0E80299DM4PR12MB5374namp_--

--===============1968918940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1968918940==--
