Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06E1C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE8B60FF0
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE8B60FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3693E6E985;
	Wed,  9 Jun 2021 15:36:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C659F6E982
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 15:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edGk24Z2ho8OyRlnSnKeP0sasVeLPVXdA+uXuR69ssg58fqHhkAa77eWP4frJo3DjwSvtlupqlStTL4F6zikvzOBjW4Ix7EYxYjHE9uaE4A7Q7YYOaH7GrP7VOGgcdy8OisERGc4LglFmLwHuNzsN/cVP4vi8SsSY4IfhtUnoyhKJ3enYULrJVqPM2cS+f3lGbJD3ujbFS2/s1Cq1Wx0q5mFYBiLPiujd5pXWeae9xM26CIMN5l5Ffr/89ytGMsp5R3ylPEKMmgVSTCMl2btiWdm1bsbjrcoA4T/e1hw9Y9Y0k5B5iOcosH1Fm3mXZoph405JuT/dBX34aTkV+T5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gIXZVmzQxsjo+2qvFcjHVi/Gw1GKIUZddvQxvUIAa8=;
 b=jhIgPohmbMLgyQB+5fDsBCmBwbkMDPGfeqehwW5KYgEkuryPCwnWbgDQ88zn3NAiC6ZVd/AXHJBbOoPIHu/8+PTz7KC1oVfgL8uiQQlD0qR8VOnCQ6+fyw0/6MR25cpNk5Za8uRdKm4Z3fXwwhphfk3quay2DdTjaZR5p4xwUz7e/dBpgD7dMhjrExt2w/CM+1E/VeiQu0q0G8OFTR0DXfwpiuw8UvJCnaKfhjG5kUIV4vLHnOJOpmSwD9Bjilx0skMo56Me/BK31/HQDO5viHf6OjY0D7R0yyebiDmPPcK/A8On1AxGlHXr15VzatPd5nKIvsuoYZChPRLlRqHYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gIXZVmzQxsjo+2qvFcjHVi/Gw1GKIUZddvQxvUIAa8=;
 b=wR+CnEx6wyjHNMSht+fGX9jb/FsgDGo4jkHPN583t6njByecTxyYK7WfETjWf0UR9LT7r8YUwPNmIiB62FZA3lFFOjj40E2wAiMzHQw3vJIrrUtEQvAfXVLf9ojE5XHNfHCzRphBH6XQZkGT52fJWSeVSnLwF2P2gUPPqwKs8WI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 15:36:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:36:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
Thread-Topic: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device
Thread-Index: AQHXXREnjWVMvp/sIEKyJeRcc2mWo6sLtbmAgAAWMQCAAAMugIAAAQBl
Date: Wed, 9 Jun 2021 15:36:18 +0000
Message-ID: <MN2PR12MB4488BDB99B37E508707AB242F7369@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210609092323.32650-1-guchun.chen@amd.com>
 <ab48ac1a-16a4-3bc2-13e4-bb3c1fb6a3ba@amd.com>
 <59df3448-f49c-1390-5031-327293bc1f38@amd.com>,
 <b8747525-02ac-e41c-c0e4-1b8a7bcd4b7b@amd.com>
In-Reply-To: <b8747525-02ac-e41c-c0e4-1b8a7bcd4b7b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-09T15:36:17.748Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad463f17-a3c6-4342-f49f-08d92b5c535f
x-ms-traffictypediagnostic: MN2PR12MB4286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4286166487BB602588B1992AF7369@MN2PR12MB4286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rUclGk6qsxySVOu7lg7yyBEjMySzs9u0gIBdHyTrDFWYrweMFS8hvuokXzAHvAULq3mp0M0f3hfKslMDiClODh07LN9JESaY8Lh50YddDaRcpY1ijX5EYJGJ7eD2/D4VjYCqiCxQpHCbUQyVLe7m6j+X9W2je2R6Jhtm5NPWNAACclHpGdvMi6q3jAQJ5mqFexKZr/AYnPDm1yY/XSsZs1BcSoFwbWwvVQHbwoxCmeIaA3OxRSKoumjK2Leh+dbmM3EpziScmvP35mLHxTXaDA/gZwLF/jxywziyhdMyy2AkiqghZuR6PpKhNn3wDNC+TM9/bstA2CWnsixG0RAys9bJ/ekhgmRyq3CLANSvfTl3V5z+R5G+7/Zp+S/Ie/NeH88zdfU0qd7h5fNvocG7vgSNDm06Li1eAF7jCyckRNmMRYIrct+6bLsP4cMRfGO39Ai9zAf75lxYzXpeeA24UMyVN8lUs2OMUMN9xEwiOTDofAghWpkSvrGTT9gNRuFgunGsIhQDJLrLWL+8G+sfhX3xDGfI6gOLO3SKGw1tMse5bI615V2jfEbAoDPJtxuttnPExSChQP7kAaqI6sf/O6nmHNR8iM6a824IjY5Laio53K05mHAYIdkmN4bONzVMRrQ90aXTHBgkuqfNPRn2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(5660300002)(8936002)(66476007)(52536014)(6506007)(66946007)(33656002)(86362001)(9686003)(38100700002)(66446008)(66556008)(122000001)(83380400001)(53546011)(55016002)(64756008)(166002)(110136005)(7696005)(8676002)(71200400001)(76116006)(966005)(316002)(186003)(26005)(478600001)(45080400002)(2906002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DSdNAamqsy9OJHQINtxrXC6mkhdigQnD8JVA5CMVxPE/MAajTjqzH2bx9bv1?=
 =?us-ascii?Q?HWZTng8zJoPar6WutEnlfgBTNjyqMYONG7JGM3Hq88T0t5v/jQNZS4Ccbxnr?=
 =?us-ascii?Q?zOGfgTCltpWJpeTZnKY0c+EoNoDxgth+6PkvFqfkWsprrhx74nOHc2lqFyin?=
 =?us-ascii?Q?JZS9gDxRbgfw+pEoHDcHIUrmryAuBzT1XE27Dze2s61QEZiLqOKywTmDaX9s?=
 =?us-ascii?Q?BWmVCaoPnNTY5HL9JLcIgVonYqEK7qoIZUpjOpjb4mhqkaVpxvCdmmT6kLOR?=
 =?us-ascii?Q?IVZ6j4OIYyiRp8jaBKgjYxfbv1JYdJe/R8CSvyvbRNwAd7uWSXqGXgro3ffn?=
 =?us-ascii?Q?aekRWwbmtcZwGF59pp/EfG90MWFMxklmfsuEGN8VKTdyWSRJHcm0vvB1CUaH?=
 =?us-ascii?Q?2UZI7lFC8+Mu145jMqT7gNBSS/oqbBhQ+LgcJTBfbmN7q6hKFPSoAaEsXZxk?=
 =?us-ascii?Q?Co6moylFO3xTDPzMWCp+2jk0HGCePUPWnriDKS1wuF4Zop5XEfAAJw/V7zMI?=
 =?us-ascii?Q?YpGpBMzouH1xhDfgvbWbbidVd1tfx1aFooDRa9PNl1ySudPrrjgvCsKHbFDa?=
 =?us-ascii?Q?BJHgGq/RAFgiPLHhRq/nGP7wmFlMvt3lOErRTadhnNlNaP/VvvXM+NiM7Jdx?=
 =?us-ascii?Q?CSNp4ZEkaD5n9NvJfqksCvCvms3tEA9JT8jQiOIwvzFhL0idHg1HXHTrG94T?=
 =?us-ascii?Q?kUWJtjddZjy0/C/gtTduEAaOOA04gez/doaeVQoVNM/gLz9A20pzJ0OA56Dt?=
 =?us-ascii?Q?prazyTDApYeh3djK3Mxnuc9RTaxgU+YLmEdQ+WjEpbclYL6vCRyBSjIDMdFm?=
 =?us-ascii?Q?M+eDXyVMCuWnVEU8ckCZyjiwgRJ1PrkO6T7K1pVtuEYqC2/yaYad8rKILwJM?=
 =?us-ascii?Q?yorp5x+QRRbhk12nh3nbMBLG6Y8kipnMEr+SEpY1Hw04tiNOwSBb8ycC+OSz?=
 =?us-ascii?Q?zOVDjjt9ACDV7zPo9JEoN3fIJo+ft/cGvktgrR3H/PdjHiiN1+CK9fQm/qaC?=
 =?us-ascii?Q?JB9NVn5c//+K9KmwrLztCZmlqqF9egBXm2C3lj6im3V6GeHoCg65BFfBdPoB?=
 =?us-ascii?Q?q9HLVti/NSvx9AqCRXoC8uV+EgS1Qm3BIOvVZONQ9EBZGqOl5Z9+GLFJNjNw?=
 =?us-ascii?Q?J50DNJAQ/BPyjq0Kxuc35PyUGEq8Ot6jjIc69qWB0To1D1npUeLWjRWd4Yn6?=
 =?us-ascii?Q?L+xcffplZUoEifcuXPz6OLQls/Mt8AUbhTcH7Eea4NVPvUR+EO3DXsqLcf+r?=
 =?us-ascii?Q?JVuTavLEJjT7Hwa078DX2v3t5DcrOApohfS+1ExtXj8v62tVDsGX7pLUL3lY?=
 =?us-ascii?Q?uvAJ4JtJsrWs7rEgoCvRmgpH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad463f17-a3c6-4342-f49f-08d92b5c535f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 15:36:18.4492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nymahOIde432BDT36/M5c1fp57Pf5vDFq2FcEapCGEUjKDNqztBQ/r8Nre/495LZGKPGMW9hy/Nzn1J4/7ffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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
Content-Type: multipart/mixed; boundary="===============1286130454=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1286130454==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488BDB99B37E508707AB242F7369MN2PR12MB4488namp_"

--_000_MN2PR12MB4488BDB99B37E508707AB242F7369MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

We already use the macro everywhere else upstream, so this just makes it co=
nsistent.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <felix.kuehling@amd.com>
Sent: Wednesday, June 9, 2021 11:32 AM
To: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.com=
>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device

Am 2021-06-09 um 11:20 a.m. schrieb Luben Tuikov:
> On 2021-06-09 10:01 a.m., Felix Kuehling wrote:
>> Am 2021-06-09 um 5:23 a.m. schrieb Guchun Chen:
>>> Fixes:
>>> 9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs
>>> 090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error counters
>> A Fixes tag implies that something was broken. However, the
>> implementation of adev_to_drm does the exact same thing. I don't see the
>> point of this patch. It doesn't fix any problem, and IMHO doesn't make
>> the code more readable.
> We added this due to some changes in DRM:
>
> 8aba21b75136c3 drm/amdgpu: Embed drm_device into amdgpu_device (v3)
> 4a580877bdcb83 drm/amdgpu: Get DRM dev from adev by inline-f
>
> It's good to use this inline function, to accommodate more flexible DRM.

Thanks for the explanation. I found your changes as well and it makes
sense now, especially for the DKMS branch. Unfortunately that's not a
justification we can use for upstream.

Regards,
  Felix


>
> Regards,
> Luben
>
>> Regards,
>>   Felix
>>
>>
>>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 016815b7a773..fb6bcc386de1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, s=
truct kgd_mem *mem,
>>>              }
>>>      }
>>>
>>> -   gobj =3D amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
>>> +   gobj =3D amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>>>      if (IS_ERR(gobj))
>>>              return PTR_ERR(gobj);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ras.c
>>> index ec936cde2726..bfbcb9ff2453 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_stru=
ct *work)
>>>      struct amdgpu_ras *con =3D container_of(work, struct amdgpu_ras,
>>>                                            ras_counte_delay_work.work);
>>>      struct amdgpu_device *adev =3D con->adev;
>>> -   struct drm_device *dev =3D &adev->ddev;
>>> +   struct drm_device *dev =3D adev_to_drm(adev->ddev);
>>>      unsigned long ce_count, ue_count;
>>>      int res;
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C310371950837474774fc08d92b5bc3a6%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637588495393971133%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DQMJ31mr9By5%2FAnnJ0QotXy3iNc8Bjn56oC2jeoKBVEg%3D&amp;reserved=3D0

--_000_MN2PR12MB4488BDB99B37E508707AB242F7369MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We already use the macro everywhere else upstream, so this just makes it co=
nsistent.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 9, 2021 11:32 AM<br>
<b>To:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guc=
hun.Chen@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freed=
esktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: use adev_to_drm to get drm_device</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 2021-06-09 um 11:20 a.m. schrieb Luben Tuikov:<=
br>
&gt; On 2021-06-09 10:01 a.m., Felix Kuehling wrote:<br>
&gt;&gt; Am 2021-06-09 um 5:23 a.m. schrieb Guchun Chen:<br>
&gt;&gt;&gt; Fixes:<br>
&gt;&gt;&gt; 9faf262c32d3 drm/amdgpu: Add DMA mapping of GTT BOs<br>
&gt;&gt;&gt; 090f3a60d7e8 drm/amdgpu: Use delayed work to collect RAS error=
 counters<br>
&gt;&gt; A Fixes tag implies that something was broken. However, the<br>
&gt;&gt; implementation of adev_to_drm does the exact same thing. I don't s=
ee the<br>
&gt;&gt; point of this patch. It doesn't fix any problem, and IMHO doesn't =
make<br>
&gt;&gt; the code more readable.<br>
&gt; We added this due to some changes in DRM:<br>
&gt;<br>
&gt; 8aba21b75136c3 drm/amdgpu: Embed drm_device into amdgpu_device (v3)<br=
>
&gt; 4a580877bdcb83 drm/amdgpu: Get DRM dev from adev by inline-f<br>
&gt;<br>
&gt; It's good to use this inline function, to accommodate more flexible DR=
M.<br>
<br>
Thanks for the explanation. I found your changes as well and it makes<br>
sense now, especially for the DKMS branch. Unfortunately that's not a<br>
justification we can use for upstream.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Luben<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; &nbsp; Felix<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-<=
br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&gt;&gt;&gt;&nbsp; 2 files changed, 2 insertions(+), 2 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt;&gt; index 016815b7a773..fb6bcc386de1 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt;&gt;&gt; @@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device=
 *adev, struct kgd_mem *mem,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp; <br>
&gt;&gt;&gt; -&nbsp;&nbsp; gobj =3D amdgpu_gem_prime_import(&amp;adev-&gt;d=
dev, mem-&gt;dmabuf);<br>
&gt;&gt;&gt; +&nbsp;&nbsp; gobj =3D amdgpu_gem_prime_import(adev_to_drm(ade=
v), mem-&gt;dmabuf);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(gobj))<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return PTR_ERR(gobj);<br>
&gt;&gt;&gt;&nbsp; <br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt;&gt;&gt; index ec936cde2726..bfbcb9ff2453 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt;&gt;&gt; @@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct =
work_struct *work)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D conta=
iner_of(work, struct amdgpu_ras,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_counte_delay_work.work);<=
br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D c=
on-&gt;adev;<br>
&gt;&gt;&gt; -&nbsp;&nbsp; struct drm_device *dev =3D &amp;adev-&gt;ddev;<b=
r>
&gt;&gt;&gt; +&nbsp;&nbsp; struct drm_device *dev =3D adev_to_drm(adev-&gt;=
ddev);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ce_count, ue_count=
;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int res;<br>
&gt;&gt;&gt;&nbsp; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C310371950837474774fc08d92b5bc3a6%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637588495393971133%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DQMJ31mr9By5%2FAnnJ0QotXy3iNc8Bjn56oC2jeoKBVEg%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C310371950837474774fc08d92b5bc3=
a6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637588495393971133%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DQMJ31mr9By5%2FAnnJ0QotXy3iNc8Bjn56oC2jeoKBVE=
g%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488BDB99B37E508707AB242F7369MN2PR12MB4488namp_--

--===============1286130454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1286130454==--
