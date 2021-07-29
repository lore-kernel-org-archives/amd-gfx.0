Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E2C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FF56054E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4FF56054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A9A16EDA1;
	Thu, 29 Jul 2021 12:56:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADE16EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 12:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en8wIsxDb1FUaxv0h23wcDrxcdcwdkMZ42jJ9WFRibvNw0RCHDuV+G0xvNdzxq2DMwSx9q6+8NMcd1KYYzRzlBGpvCqqAwNdBLLypYKl/ntouOuQf8A2lDMliV9qbtsoO6VPiE1aoTHLRwJ4yBRv8WsLbpH7uV3uqWmVOCLW7oHcSMlT+0HO4udzsDX3yYyr6gitfuPKYBW+5Ls51xYQxxD3bJfjrsdUNxXbjXUln6Zml89tz7YZnUnJA2dLpZaEZAUgQy+VQ7DgCi4IjkS2n0LPVVdH1AObQgBKC7r/RUASRr1xqYei0ze6Jy/sQDRmwbDytuPLMN8A8lebUbo79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEkzeUfKPN5sMo3yBsMLPXlyJfPPoaEP3PpkzsksJ8A=;
 b=D/XN++xEXs3REYQgioZhmGUVPVBC4dVKwSZypJJKXubvc7MBElkBJInFnhbX0vdnOeHCfw3FqQEVTwAXltt4JxIZUSrNLY3Xi+dRvPB9bXP+pXPgUj8Y6XxyLqyouUALfXByyfbo7tcfuWEPBhqBvhU81xtxjvsmS8v71OYCwdoZQyvsLfDvs4a8F+kQ3Zfry0NOnE0nIcYLD6TlyqO9w/UjDc0j8q0rIPsW8TXw9ENGFL1vsap4d/+W8mBPx9UjcVB/35kgOmC8o/JOFQQcTZJTTPSk6Z0/W7ftf/3FETITDEVjzuH2ToOpPSNGKmlJdODXjS10N6h9YqgupJUoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEkzeUfKPN5sMo3yBsMLPXlyJfPPoaEP3PpkzsksJ8A=;
 b=iyDNabrr7qPCvEl3NwS0o+/7tM7CY8A0pqPjpNCrFIgXm6rivR4x+dJVXpC17rvHrFSKo4Sz5y0c0orUTMeeAx5kCyPFB6WXZ8UISPpc4b1ORqh7lHMBarmAUvjz7NfB7u01fsclcwj2wnqo97HWI7Z8PaaHPVWoWJvx2KLZ2qw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 12:56:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.018; Thu, 29 Jul 2021
 12:56:09 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
Thread-Topic: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
Thread-Index: AQHXhGeBq+wz9Lib0E23927kO1FWFatZzCOAgAATOgCAAAhfgIAAAIgw
Date: Thu, 29 Jul 2021 12:56:09 +0000
Message-ID: <DM5PR12MB24699DF8685B9E7993EDE4E6F1EB9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210729104945.25312-1-guchun.chen@amd.com>
 <f862776c-a329-19f6-34bb-68f5ff5f6b50@amd.com>
 <DM5PR12MB2469251ADA20439E8A116209F1EB9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <37859d3a-dbb7-88f7-e932-0086eb0ca95f@gmail.com>
In-Reply-To: <37859d3a-dbb7-88f7-e932-0086eb0ca95f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-29T12:56:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=096de7d3-b652-4a59-9182-f9bc9c4d76f2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77afa43f-be5e-47e1-e922-08d952903cb4
x-ms-traffictypediagnostic: DM5PR1201MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00255C7B0B1129D01898CF8BF1EB9@DM5PR1201MB0025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1EIC6K7tXQplQQWx1w6pBGFF8mYq234AXVGuZ0OrmWYTG911s/vUBpy3NGclQd5CDbBrFdQCyUSdAh6HZUojHNXC0JuLY7eQGCmA7JQj12ReQi7Hk2il2HctX6umywH8MnPO+ZkOQWE0IzwzmgHLxFdusCpLZt3p554LMbUniwSzFiKNaDFuBGSh27ZMl9kynBdYtHeo1kiubeqro+oNtEDlkNpuRZteQwq+8f0IUlfvOTSeMmCfVNaLJIHsQo4QGi5lTVv6Yqinv6C4CFl0hKYSCZw4fLN3kH3g8wgdqnu0fDFWdhB+nANWh6vrp9Ogo+UUe1Oyus5ija2trh6cP4q07ResB4SO3yg4KjAMgLZV2gBYTfcvf1LEkE8jNw25tT3PHy0RP9MxQJt643XJ6aN3r1qyqzgzHHHMJMzPk0WfspZHG0TKNyR4Bm1Ab/IIju/xr/zekTmZ2GHqV+lu9oK0olzy7toBD2jpAiG+nW7vP6vLrWmDgKLtjhfMoLKEjn/ECKUrxLIxcohclPtgkFdRA2gW9JEVBMd3J815wIGH7Uc7CNULuqNpVMiWUHN2I90+EUm/lw024NW0fkW9d1uVKLMIlLgJURxINcJJ8HP58Mcqmq6XQR/m5mBMiD5Pc/G3V2TM0AwXJnb9EBchzl8PJ4/HPywyXmBxmmW1iAHWfC6KbnXFaX+t8RLnLtRhKv/5NKONp5qPjd6kOFqc6P6cmR5WgLbePaqp0mJduz1TcubjJACs/KvxeGDoG563zF1CLAi4Jg/FDbe/UVNoskwvMYBDeQwZiHobUTs+g1GQke4IYlzND4n/5qpjXkN9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(66476007)(66556008)(966005)(64756008)(71200400001)(53546011)(8676002)(66446008)(6506007)(8936002)(45080400002)(52536014)(122000001)(7696005)(6636002)(478600001)(5660300002)(38100700002)(83380400001)(66574015)(186003)(38070700005)(76116006)(55016002)(33656002)(316002)(26005)(66946007)(86362001)(2906002)(921005)(9686003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5y9EWfO3ziXqK6jFz4ChnujOUYx8zsiDe4tdL3AQRcVBAQp+pxN1jaCPho?=
 =?iso-8859-1?Q?CvPjkZ/ACGNBxhUnjJlAJKaB+ka7qu8X3x8zlrobR9sjmllEsxVLg4jjXS?=
 =?iso-8859-1?Q?zpwFszbkbBa7AtPwJn9brhz2aZ3SEYFfwebkOUEI/bPIN0rN9ambLJRFmz?=
 =?iso-8859-1?Q?RyhTZraia4d4GJTcGPg6OLmgC7j7biNK1p4CcuDPn9m6oC7+MCCuInC6pB?=
 =?iso-8859-1?Q?jym69MthATuIVAODcZlF1Xq+R49TaPgYP+WlqyE9RO1I+7HhTd5dUdPyx5?=
 =?iso-8859-1?Q?2ZBewczFcaoudwwPi+0ZO8wOoAwj0nSi9/uPHjppHV5kLdfN7CoZfd9wJi?=
 =?iso-8859-1?Q?fsCGkBBA8QO5+vU4iwekzg8UO1F6x1f0ZA8pd7zISurd6GzC/+0gzzLwou?=
 =?iso-8859-1?Q?OYYv4ODZr0AVOcNcIwmZBgjQ3hRy/66391eFanh77LRC1rk/zJ2rtMEnT8?=
 =?iso-8859-1?Q?8Dz0JdfYOGBdkQ68pSeIjrzH2gBHYGwOu1vSMVbpSYiOG8QJzDVHq7y7bd?=
 =?iso-8859-1?Q?daBUQP2iE+QuJCqR2xBb+IPMiYyQXQNhtXMTNl86O4TGrs4H1bhJzQz2HX?=
 =?iso-8859-1?Q?i4LFwgNaznMBWuc7xJKGthjxUfxGpsW6Yj99oNWTHNSVfo+NQAmqGOwUsd?=
 =?iso-8859-1?Q?/tUFcm+LSdV8BxPD/e+maLzTD/TZmLoQdrKgGPOUfVswZmbroVzquxzqcT?=
 =?iso-8859-1?Q?f4q/bGnnT1GBWuRF9qFYSzE7bjMSbHgtXOSbWdHRZWHNuayjsUGoAItzij?=
 =?iso-8859-1?Q?YnIToO8yqDmLOMXtD+sMOIzXPxLl+JA5zeKvZJUidH9xCUUp/PFbIaV9Ru?=
 =?iso-8859-1?Q?+rpE2uZvhIjyEqeBK07HmCwfvd1T8aIkVwzUES+GoQWKXNDkwQ0kyAXDpS?=
 =?iso-8859-1?Q?h145rLeZtHD7jTji1BA6OuWPSKeCTjj8/XyfEuVt7ReOk07IJ6AsuEQ5Mg?=
 =?iso-8859-1?Q?0bMWoXbbYVYOnjRBI3ARdlqEgjeKt80wC7ApuUBpFT+CJ12kVIuiNKM5nV?=
 =?iso-8859-1?Q?JrDqgFjztp85VHd4hrU8QDGQzfjAp5S3X7LUb1KLSJUIUq+q0VgdT7rBou?=
 =?iso-8859-1?Q?sMF4kLzrC429G5XcQk4ZmPRxjrH2IuWjH+2v3w7KbPC6cUEznkgOYNnEc5?=
 =?iso-8859-1?Q?IOJ/Kk+TRnb8kQjMlTjFgUv0piTMU6Y7lBU+J4xrvt7/VLaezLI3TL99xQ?=
 =?iso-8859-1?Q?emQwKWfy8xJT6lRiD+6Ao1y8ip81lz6Lff/ZKo4ZwK5EQM733jOUEwEg+Q?=
 =?iso-8859-1?Q?MFcTt5Q2edalEglCKjNFjvnOuLmC8R04QkJLqBNPl/22+TV6dbX0qEIcIp?=
 =?iso-8859-1?Q?VwWw+KvUTQDGIbMS7dgPW3y3sq3A34GaY6Q41wpKZjPR8/r3VUTjS6H6bI?=
 =?iso-8859-1?Q?TjGrsCUR06?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77afa43f-be5e-47e1-e922-08d952903cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 12:56:09.5424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yw8R3X/Es8viDat+NJu6CcKnMxFd56Q8RJom9/Pcyg9xg8TuuMzvG4S1GUEmGOVhgbXgLwOToNb3nw22WA1ntA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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

[Public]

Got you, so the target is to take this chance to make the code logic more c=
lear instead of making it just workable on top of mixed functionality code.

I will post a more reasonable patch later on to address this. Thank you.

Regards,
Guchun

-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com> =

Sent: Thursday, July 29, 2021 8:50 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuche=
r@amd.com>
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in =
s3 test

Hi Guchun,

see below.

Am 29.07.21 um 14:39 schrieb Chen, Guchun:
> [Public]
>
> Hi Christian,
>
> Thanks for your feedback.
>
> Originally, drm_sched_fini is part of amdgpu_fence_driver_hw_fini, I did =
not move it.

Yeah, not saying that this is your fault, you should just clean that up mor=
e thoughtfully.

> Former patch " cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequen=
ce " has dropped amdgpu_fence_driver_suspend, and called amdgpu_fence_drive=
r_hw_fini instead in function amdgpu_device_suspend. I checked the code dif=
ference between  amdgpu_fence_driver_hw_fini and amdgpu_device_suspend, the=
y are almost the same except drm_sched_fini part, so I think we can leave i=
t as it is, while skipping the execution of drm_sched_fini in suspend/resum=
e case.

And exactly that's a bad idea and the reason why I already said during the =
review of patch "cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequen=
ce" that the callers of those functions need to be adjusted instead.

1. If not already done please rename the functions as Hawking suggested as =
well, they should be amdgpu_fence_driver_hw_(init|fini) and amdgpu_fence_dr=
iver_sw_(init|fini).

2. Remove drm_sched_fini() from amdgpu_fence_driver_hw_fini() and add that =
to sw_fini instead.

3. Adjust the callers so that we have the same functionality as before. =

E.g. by calling both hw_fini and sw_fini at the same time.

Regards,
Christian.

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, July 29, 2021 7:11 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; =

> Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking =

> <Hawking.Zhang@amd.com>; Deucher, Alexander =

> <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver =

> fini in s3 test
>
> Am 29.07.21 um 12:49 schrieb Guchun Chen:
>> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to =

>> stop scheduler in s3 test, otherwise, fence errors will occur after resu=
me.
>> So introduce a new parameter to distingiush the case in this API.
> NAK, the problem is rather that drm_sched_fini() is part of the sw shutdo=
wn and should never be called during hw_fini.
>
> Christian.
>
>> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 8 +++++---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   | 2 +-
>>    3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b1d2dc39e8be..aaff8ebbb7dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3844,7 +3844,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *a=
dev)
>>    		else
>>    			drm_atomic_helper_shutdown(adev_to_drm(adev));
>>    	}
>> -	amdgpu_fence_driver_hw_fini(adev);
>> +	amdgpu_fence_driver_hw_fini(adev, false);
>>    =

>>    	if (adev->pm_sysfs_en)
>>    		amdgpu_pm_sysfs_fini(adev);
>> @@ -3941,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool fbcon)
>>    	/* evict vram memory */
>>    	amdgpu_bo_evict_vram(adev);
>>    =

>> -	amdgpu_fence_driver_hw_fini(adev);
>> +	amdgpu_fence_driver_hw_fini(adev, adev->in_suspend);
>>    =

>>    	amdgpu_device_ip_suspend_phase2(adev);
>>    	/* evict remaining vram memory
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 49c5c7331c53..7e6a73c2919d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -515,14 +515,15 @@ int amdgpu_fence_driver_init(struct amdgpu_device =
*adev)
>>    }
>>    =

>>    /**
>> - * amdgpu_fence_driver_fini - tear down the fence driver
>> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>>     * for all possible rings.
>>     *
>>     * @adev: amdgpu device pointer
>> + * @in_reset: indicator to distingiush device removal case or s3 =

>> + case
>>     *
>>     * Tear down the fence driver for all possible rings (all asics).
>>     */
>> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool
>> +in_reset)
>>    {
>>    	int i, r;
>>    =

>> @@ -531,8 +532,9 @@ void amdgpu_fence_driver_hw_fini(struct
>> amdgpu_device *adev)
>>    =

>>    		if (!ring || !ring->fence_drv.initialized)
>>    			continue;
>> -		if (!ring->no_scheduler)
>> +		if (!ring->no_scheduler && !in_reset)
>>    			drm_sched_fini(&ring->sched);
>> +
>>    		/* You can't wait for HW to signal if it's gone */
>>    		if (!drm_dev_is_unplugged(&adev->ddev))
>>    			r =3D amdgpu_fence_wait_empty(ring); diff --git =

>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 27adffa7658d..42cbecfc26a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -115,7 +115,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring=
 *ring,
>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>    				   struct amdgpu_irq_src *irq_src,
>>    				   unsigned irq_type);
>> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool =

>> +in_reset);
>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>    void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>    int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence =

>> **fence,
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CGu
> chun.Chen%40amd.com%7Cb9ef02c0084240178aaa08d9528f69a3%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637631598168273235%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=3DO7Gbls7ikrhXrGnsChLJEmPTTFgEg1XJwqydZ1BccNk%3D&amp;re
> served=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
