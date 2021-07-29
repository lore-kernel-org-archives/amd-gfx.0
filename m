Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54620C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF7860F21
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DF7860F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B146ED94;
	Thu, 29 Jul 2021 12:39:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0516ED9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 12:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxjnS6vO9Q3Lc7tBt2emJ0u4gn9j0dnarLTOo5f7C1tqz09mDnx8gBs1VTWiQxLNesM746bN7yBzitSPUXxr84KrWO7IYqAc7o4g+Sp/FhYLMG3KvZ8Q8VPcsG6fefTDG5QxhIEBBBlr6VZcOt1cdVggulpEPx80Z/NiRuohwmxaBwttava93yyXrc6DOOx+K8t8GMi4ajWiUS6vRI6fGr517oblYER5a3H4wZumsTM5TbG1m+VRfdaLgcJM4n2aohYmF1qpQPtAN5q/iLRn+CEbOs2APdmeLx5vXdwckXpM967oOzFa8ykXh91JUWoWfSo9+wfR7dXQoLK+zhMY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj5nM694ga9PkL+py7BmQmnWMrU6uZdw7JT+z28JiBA=;
 b=Jp0gyu7RZKGX/b4L6MEgSSi23Pu1Vz+458AWgbgpyE48N7aqutN5ukY1rh0i2f+8Ju39m2SbAvGA2GXRN0gtyV9Mp5kbb+67mhDoL2kc94cI0mjOPjcSXSLDBBIq+95ctVPVYWHW5nFkOhz4Xw87gB002tIR38YRhnC6xBUZRaXG8dGoCgtBrQ0besgcv3zOzrwzWUFV/r6d6oPFnJau+m1JOxCFBNg2TTTLu871/uXW0iTztFE+Z8IVwKZuGwafQwPHUyUSp1HQ2TxEhLGnrlASy24eodI8sbcf1cgrciMGPUxABocJx/isBBT7XerHalM6YQq4S64ho+uGpkJzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj5nM694ga9PkL+py7BmQmnWMrU6uZdw7JT+z28JiBA=;
 b=jVQFN/bQ0j09v2RgYz6B5MskwKQFtrdUtZqNLOnwDO1Mz95UY5mQraSDPkEFJDFtNeR02U/gTEzhPsB9MedIeGHDAzlceUM3+sDEnh55mYGwHIIMzXIuYe7lCk/M4DozoZQ+b0HLocxZpQMDHbYZ0iA40//vb91EnAPJEumCPuM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 12:39:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.018; Thu, 29 Jul 2021
 12:39:04 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
Thread-Topic: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
Thread-Index: AQHXhGeBq+wz9Lib0E23927kO1FWFatZzCOAgAATOgA=
Date: Thu, 29 Jul 2021 12:39:04 +0000
Message-ID: <DM5PR12MB2469251ADA20439E8A116209F1EB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210729104945.25312-1-guchun.chen@amd.com>
 <f862776c-a329-19f6-34bb-68f5ff5f6b50@amd.com>
In-Reply-To: <f862776c-a329-19f6-34bb-68f5ff5f6b50@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-29T12:39:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f1d82fce-290d-4d59-8147-a1e63364a87b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d952bae-8030-4e2b-98e8-08d9528dd9f1
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40754124ABEB699944B8F5CCF1EB9@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koSv96J7FK2O/1C5hAmBi1BWmVTJRK9IcDQVJn/+PMkJxq25kvsUpYDIa+IU89Tjiiz261YrLaPqtrDMapDCZ5UjB99+Kx9uL3c4gQ1+07RWXjf1XMSu5Eg/IW8e3L88ZtryeH1SKPbRnVlaj+yltp0bJ8eaaL2TuDWQbkCW+qo5KxlVNjDSQzfnQcu0O4fuO6nPmv13Zk7zsgwz3sih+uTZMnngWzTvnw5uVDrSH7F4iuwNfzaLSZw1Usvhub+tlvU+nYny00uztSfbkAGNlNuENRjtZhTldzKkEkgF7FRCQPAmSPyXg2/ONHxPY14ck999JRvHgtmiWxrA/nfSj6B7ZmNAsFaOWSF4Plgh9Ql9cW5V1YD2kZMl4OKKrLjZDMu4cjtEnTaqVqcSvQKKLWKKmY7H5unbKmwf25gW737ISkW3GGljGsM9W7lGk6wsptoutjs6mnsYsyAoHfNF9/FOy3vlkDmfNuFGbxa4vCWJvwqUvwOF7Mn7TdjdcBw4ah14xlGRzO+nZSiGnw/u4V/B0p32aWAssW6ic1wFy6LjdTXOaNHNAtBGUY0jlc0D9JzvWec0sjf4PYmOSyN1dTC37I/OFHPb3GtvPgx3nFlkPe9lZPeQFjjgOMpn9t09UF9GqTQJaiGBg376YEKE14IiT3tC3tiqlxz661VfYPCqeBNkV1ZLKTm6PUnz3IGdQ3NY33QFOB+mHi+6Ez/VEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(64756008)(66556008)(6636002)(66446008)(38070700005)(53546011)(66476007)(6506007)(8936002)(186003)(26005)(2906002)(86362001)(71200400001)(316002)(76116006)(8676002)(478600001)(5660300002)(83380400001)(52536014)(110136005)(38100700002)(33656002)(7696005)(122000001)(9686003)(55016002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEc2MEMveXJtZmdWYWR0dGlXSW1PdFFOYnhMODFiNWJ2TnNxOVRGZk9aaW56?=
 =?utf-8?B?MlUxZUlNRDB3ams0OGwydU93SVVvazZOSHVwa2xjWFNYVExqcHpMNExJOHhH?=
 =?utf-8?B?T2JlNWoyYWR4UTBwQ1hWUlpuSjd4MXVTNmVJUk1XNEEraEV3OE10aGtjVXBI?=
 =?utf-8?B?amdRVnNmQXBldlRDM1N1RWlFdEpqV21nRWprYkI5VmVvN09EUlBOSHp6MDhy?=
 =?utf-8?B?amMyQ3pOUmROSlRQV1d5R2d1V1VTbmlPRG1PU3RNcVhMMFFMTUdIanluUWd0?=
 =?utf-8?B?NTVoQzBhdUVhKzhMZDZTOFgrdkNhdndHeVBKYWoydjFhZkhzMWFuOERZejh3?=
 =?utf-8?B?aGRsM3hRV1dQeExJditNODJ6UnhmR1VSaEY4bklIUndUU1Y1SjJCVlJrL0FN?=
 =?utf-8?B?Q2JWQllYTjV4Mjd0MjgrSjl0RlpyRFNOYXlqVVFBWmd2Z0NUWjQ3ajdjblhL?=
 =?utf-8?B?bWsxVHJvYjgraGtiSEpNdG42TnZOaVRxRWxiOTNYeTgvUldSai81MFlFbG1R?=
 =?utf-8?B?a3liQkUzK3RhWnpjYk1GYzg0NmVPM3d6ZGUyamVJbDdnOW1mSFNYQ1MwUWZR?=
 =?utf-8?B?Z1RXSzJNVllKU1JJcU1VTHJLRVczeS9TYkJGZ3BkVm1pd1RZWDl2OFlBZFAr?=
 =?utf-8?B?b3ZOM3dEME1QZkVONXQzREtzZ0QrYmNuOU5STUJqMjJoS1NEZEExT2VSS2pJ?=
 =?utf-8?B?eXRENWVrOVowcEw2YWg0cENWbHJGQ3BFRGNqMTNxNVl0aXkvSEdNYUxMcXNR?=
 =?utf-8?B?Q0YxWlpKSFdMaDhEM0JOTnhpOTNGL1BvNWtaR3hqbUVFYlpKc3F2MjQyWGhI?=
 =?utf-8?B?V3JLRDVCcUVMZi9zVTdyeWt6RlIvbkc2Z29MNzkvM3RSeTFRdUczc01uZGRi?=
 =?utf-8?B?Um5nQnpKdkRBdkRsckFuTitsbVFZeDRvMENaRExCcE11ZTBJbXZNM0J4U1Vl?=
 =?utf-8?B?OEJUS0h6bFIxY0J6ZVEzSmFBaFlOYk9RVEwrVlhYaVBsSEsydHdrRjgzZDJz?=
 =?utf-8?B?Qk9iTGFnS004bmlTQktqa0o1UVU3YitydjBCeEZyMnVLYWE2bnVJTTc2NUJv?=
 =?utf-8?B?Q0FOWFVqMVo4VFBvUkRyVDE5ZE5xSjRGNkNHaTdUaTdBdHk2eEViMnFyRUlu?=
 =?utf-8?B?L092WEg4cjZRdVlZTXdVQlhNYS8vVzdpV29YTGlhRnh6NWU3blN6WHdXN3Zq?=
 =?utf-8?B?cjVwS2Q3eHlHN3U0VlJQaUdYL2dFWXNmVjdxWm83MzRQZW0wbG1LNlJKRndE?=
 =?utf-8?B?KzNiV2FjR3YrakQ5TUxsTlE0dzhJSHlQZlZFcmVTSm5SMnovb09hTnEvTUVF?=
 =?utf-8?B?ZlNPZ1RZZVMxaWEvTExSMkRNR1FyQjFCZjJoRzQybHREOS9VU2l5TEo1aFht?=
 =?utf-8?B?Y3ZBaTF3Vmtxa25mYVY5QldFZnlUb3I4SjJQT3I4aVBoanBnUzFZTlE2aXZR?=
 =?utf-8?B?dDJRS1g1YWt0d1NXYS9ZMDhlYmY2SkNNd0xrR3VHTWVpWUxITXpicURCNlBG?=
 =?utf-8?B?Rmo0RldqTXorQWRGV1FWNU1UNXVpazVKTHdCWG1LWEx6dFN5NGtTM1RLaTFL?=
 =?utf-8?B?QTRVRUNlcjMwWjZGd3I1ZmZKTHg0T3RNK0hJbHVtWW0wSjVDemNScEtiMXln?=
 =?utf-8?B?UGlQTGNoZjAyWTJkOG02L2VDbGwvTzBONjM4NGt2V01sWTlleC9PVEl1ZjVp?=
 =?utf-8?B?SHJrSGt2d0E5M3RDdk9ReVNCMlJKL1p5ZHFaN3d1bDVBQUlYZjRKamMrMjVO?=
 =?utf-8?Q?HwXyqf3QmdTAShlU6CQ8IJ+MtrjsdvsBBUtwsI6?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d952bae-8030-4e2b-98e8-08d9528dd9f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 12:39:04.7752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7Q86JpARDrI7iHz+E26nKDso7QUgstjq7plirIbbUYEK3o37kzfFZYXh7XgjxCLRCB3Q0CYSsw4JHNjqjB9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Christian,

Thanks for your feedback.

Originally, drm_sched_fini is part of amdgpu_fence_driver_hw_fini, I did not move it.
Former patch " cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence " has dropped amdgpu_fence_driver_suspend, and called amdgpu_fence_driver_hw_fini instead in function amdgpu_device_suspend. I checked the code difference between  amdgpu_fence_driver_hw_fini and amdgpu_device_suspend, they are almost the same except drm_sched_fini part, so I think we can leave it as it is, while skipping the execution of drm_sched_fini in suspend/resume case.

Regards,
Guchun

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Thursday, July 29, 2021 7:11 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3 test

Am 29.07.21 um 12:49 schrieb Guchun Chen:
> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop 
> scheduler in s3 test, otherwise, fence errors will occur after resume.
> So introduce a new parameter to distingiush the case in this API.

NAK, the problem is rather that drm_sched_fini() is part of the sw shutdown and should never be called during hw_fini.

Christian.

>
> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   | 2 +-
>   3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b1d2dc39e8be..aaff8ebbb7dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3844,7 +3844,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		else
>   			drm_atomic_helper_shutdown(adev_to_drm(adev));
>   	}
> -	amdgpu_fence_driver_hw_fini(adev);
> +	amdgpu_fence_driver_hw_fini(adev, false);
>   
>   	if (adev->pm_sysfs_en)
>   		amdgpu_pm_sysfs_fini(adev);
> @@ -3941,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	/* evict vram memory */
>   	amdgpu_bo_evict_vram(adev);
>   
> -	amdgpu_fence_driver_hw_fini(adev);
> +	amdgpu_fence_driver_hw_fini(adev, adev->in_suspend);
>   
>   	amdgpu_device_ip_suspend_phase2(adev);
>   	/* evict remaining vram memory
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 49c5c7331c53..7e6a73c2919d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -515,14 +515,15 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_fence_driver_fini - tear down the fence driver
> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>    * for all possible rings.
>    *
>    * @adev: amdgpu device pointer
> + * @in_reset: indicator to distingiush device removal case or s3 case
>    *
>    * Tear down the fence driver for all possible rings (all asics).
>    */
> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool 
> +in_reset)
>   {
>   	int i, r;
>   
> @@ -531,8 +532,9 @@ void amdgpu_fence_driver_hw_fini(struct 
> amdgpu_device *adev)
>   
>   		if (!ring || !ring->fence_drv.initialized)
>   			continue;
> -		if (!ring->no_scheduler)
> +		if (!ring->no_scheduler && !in_reset)
>   			drm_sched_fini(&ring->sched);
> +
>   		/* You can't wait for HW to signal if it's gone */
>   		if (!drm_dev_is_unplugged(&adev->ddev))
>   			r = amdgpu_fence_wait_empty(ring); diff --git 
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 27adffa7658d..42cbecfc26a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -115,7 +115,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>   int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   				   struct amdgpu_irq_src *irq_src,
>   				   unsigned irq_type);
> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool 
> +in_reset);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence 
> **fence,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
