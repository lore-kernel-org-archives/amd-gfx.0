Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47880C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF20B64F33
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF20B64F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868E76E188;
	Thu, 18 Mar 2021 08:28:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0C46E188
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 08:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktEZKECXHmddPg43SVFa1om0xpxgAeNYkPSyGC6rHkcDrHHbYWp323K1gKyJgESmQ0GtGbbDqjze8RC0d3+YbC3dizpO59rTxOvhnH6zNDY8DMDHSGhFroegrawXo58k+68Q1ZfKDy9KNw+D0Pa7AequfjfrTZsPGqU95b8eZBCsm8Ua6Ni5WMEbPSAt2rJmYIXpfC7cgmkWsf4E9ZcL61xOdt5Le3dSlDAeqE79k+J+VOSXisASG8/6Bu+cbpNCz2EM5DASPrtIsiWbCLHy5ERR3UDh/KWn8YSaRGvBYyfnxruUGt52VH9Qw733mTi7AMICSlZMWZm2/sytLl/EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV6N2DPrFpl+EJV3B+1yyKIW1YfahMQWFNK2yOxZ/kQ=;
 b=QkD6hk7g3KOqycCaVHok7QDDne9soVk0mB/YynHFt0xOidr4xrDBP8HLUjPrTV/rS1A7ZYGUsS0t0+sG40MnRsJIIJLb1rl19Wb9oqAsUNmClbYlcspog68To01sCFifKVD/scyFS55PbYqH7+pVmD3f3smVYJOqXVST3LDUpfPDT4gosU6ySvLrETd24MrKxlA3CqtKBWlkYGLPy7F79vTFeubN1/6Np6mFf/Qry6UDAaRC/HAP4EC4Uh+brLM2du4yJMuVbEwi+3HSPzWmLjHNVp7e3KZRyUTTHxwB4hF5AyPhUMRB6bc5sk2iu57lmyoHrLl07QhluEYLXuGKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV6N2DPrFpl+EJV3B+1yyKIW1YfahMQWFNK2yOxZ/kQ=;
 b=ZZbGb4Po0hEuTTZjndlVUZDvTkEeI6IR6DkWnCLFYTBKyszKsJcYGSZ2KFxnMzZcVSbAYf5uwqAxq9z2GfUIVKoYYP5wSHQAx463gNKGF2dYEJ/+PnIaxbnwQco4fvhcVjYe+yu//kJFn2kVf8vNlRHutvtwZ9b4rBHBEAMnW+E=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3995.namprd12.prod.outlook.com (2603:10b6:5:1c6::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 08:28:01 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401%7]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 08:28:01 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Topic: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Index: AQHXG8elcJAV9p/5oU2z0/KQ/z+nPqqJYAuAgAAGL5A=
Date: Thu, 18 Mar 2021 08:28:00 +0000
Message-ID: <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
In-Reply-To: <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a418274-2ffa-4f5b-ab61-08d8e9e7be2e
x-ms-traffictypediagnostic: DM6PR12MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39953DD23724C898850CDBEDED699@DM6PR12MB3995.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Czo8jLLCQv/W1hhKgECM3lyBczPfzK3cjnt93v52RXWhSM+PuCmsmd2XnbVeM+IUmaPA7MyRvZfl2wGq/uNuHP84eOooopkgB3QIkaiXviokmHJnW1kDmmDJoyJbCYq3wX1DnVhLSDoMSpScWpcNmf8JdwBA3Dpq4N2CGVQxxeHiNJIUIBraXhgJcpcw+47byg/c2Fqs21uwFwEkPF+kvHZCevaX2IkVHuqjMJrIYT6NRYUxONfwweecm0p02BVvnhd6xLizzJMmXYc18p1ssARxtCH0q4v0CQBkqDaYsxHFbBidSk4LdIcmtHK7+b8cFQPoRvYOn0CJY/Pqqb/HIstpo4t1CG4WcEhv/c1klUftRNqI12rXJaRsZz63WxBfN/fYopMBApcbb25Pm4KT421CZLDqbzscoAUNPEZNOmDS2V+fhv+nk8w5oOdUJXD1UH5J1VuoNYWF5r0OQHyxDhu33DvI2tKlDmzZlYZm5AmjsQgm0C2vY7Oik5vS/krKCGtAwDjqNxHZXgHpb2P3xdQ2TCu713FScCB+NUEpNXIBt/bfCJkIwtcKsNTU1glCRJUQGuMMNnvJN+pBlMlbn5j253aTZn3IKkw1Vd2Tm+3lNOnq4d1nPoLpFoVgAZxn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(66946007)(38100700001)(76116006)(64756008)(66476007)(66446008)(66556008)(5660300002)(478600001)(86362001)(6636002)(52536014)(33656002)(186003)(6506007)(110136005)(8936002)(53546011)(8676002)(7696005)(316002)(55016002)(83380400001)(71200400001)(9686003)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVgxYXkzUHpmMkVJLytEVS9zb1NRZ1pFbGZpTnJra2YrVWNWMThERk5KL0lo?=
 =?utf-8?B?TlFhRzZ1OG1od254Q1lFYTc1NlVRdE9pek5udnpjVzRTYUprNDkwNFNyQjZ2?=
 =?utf-8?B?V1dWdHBpNURWSGhQZXo2ejRaQUl0NmNjbktlTDRRdncwcFJEY0NGQlA2N3Fz?=
 =?utf-8?B?WlJtaWpheUVTblhFZVpXdVFHY2J2NkJjbGU5aFRmVk1KWUFnRmRoVjYzQnMr?=
 =?utf-8?B?cmlTdkxDSjB1QjBvMFd0VUxPREtNTHBRdDcwQnAxY1NZaksyL2tSR1hoUmRM?=
 =?utf-8?B?QmtsejAxTGlOSnRyK3RHcXBILzl2YVZUYVNuR2ozNU5PVklDYk9tNTUrc0pI?=
 =?utf-8?B?T3BpYzNjdEFmbHBacmpHUE1nMWswcUZsNmtxNXp6eU1xS0RnVVhFTmdrTHlk?=
 =?utf-8?B?dzVUMXdwZ000ODVBek5VS0tPSGlLOTNIY1JYMk92Wk9BUnl3MGFDWTBDcGJN?=
 =?utf-8?B?TWxkMVFuM2pkNDYyRW9mZXF1YXJiUmd3SXZBc2ppamI4MlNvS2RremtGN0FH?=
 =?utf-8?B?UWxSWFJpSGNUOFg5c3pldG9zTFRjRmlUT3l6WVBGbUdmUm9EQXdoL1E2OWov?=
 =?utf-8?B?Z0ZWU3YwUUkyc1dETVVSYWNRSjIzeE5ZYzN2NksyaFE3MTRMSFNMQmhsSCt3?=
 =?utf-8?B?TmdDdTloWXJDN0cxWDc2TlIyajB5MFIxZGwzUmp2WjdwZWVjWEdOT001ZTZD?=
 =?utf-8?B?bXIwZ0VwUk83V2lSVlllL3ZzdEJweG02akt2YWVOZTVPSmpzeitJSE1BN2lN?=
 =?utf-8?B?ZmJaSVVmRUZ5ZFo1VW4rcFRyZVh5VFFab0J1NUpJM3IxTksyS1VOZDFoZU4x?=
 =?utf-8?B?cHhCWXF1eExQU3lhSUhrbDBYemgwRXJsY01EYlFpT0wxTmpQb2JHek9Kbzl3?=
 =?utf-8?B?Y25KcWN5TFpaTHBNdWtLSGsvR1F5Q1c3VG1HLzFrQnlOelNMTkg0MEhVK1Ex?=
 =?utf-8?B?ME04ZWI1L3pjQ0MzSFhoQytsS3E5MG5Fa0JjcWoxeGJWUVRmeXU1OWZrWUNq?=
 =?utf-8?B?c2Nsb3FhbTc2bXVmTEtLYlV0TU9GSkU1YmpXN24rcnptdG9qQkhqT1N5aHha?=
 =?utf-8?B?ZkhHRjFaaVFuWGdDSys1MDZDMTV2bzEzbng1S3RRT0ZGNGc3S05QbkdjbEFX?=
 =?utf-8?B?eDVVeEJWalBLcTRnbmpTMW1GakZKQ1Jab3NJcW1naEhucWZnbTg4eXB3MlBz?=
 =?utf-8?B?U05FTHpPb25PR09TK3pDS29iUWVMOTh6RDNyZ09scHZ1ZGtUZ2pzTy9LK1ly?=
 =?utf-8?B?UlpuYTV6LzAwZmgwcU0xTXYrQTRISTBOSlFLV1VwUVFwQjBmYndNbmMxZzVp?=
 =?utf-8?B?b3d2azN1dlJGWmU3RUdmYnVLNVljSUl6L2tYVWM1dzZKT1FSMzI5cGRza041?=
 =?utf-8?B?NkZlY0gxT0VLTlV1MHR2UklpNzhHd2E2MVV0R2FUWDZ1MDcrR3ZZcUNUSENK?=
 =?utf-8?B?VFhiV0RpcFFvbW9tL213SUNIYUFVdlNNWFY5VGlhd3c3UnU0VHRLSXJQNkxy?=
 =?utf-8?B?RTR6YTE5NzdZQ3VrQUZZcXV0eEFodmlzTXdHV2hJYlplRFFPNlVXOW9udzV2?=
 =?utf-8?B?WVZidm9YVWQzNWJpUnh2UFZpbDUvbVhQV3F2STlzQ3pYMlBrakhidStGNk1O?=
 =?utf-8?B?a3kzOWU2djUrK0MzVms5dU9xc25YTW9ZMFU1VzhBWExaTE9DSXFaV0NTd1dS?=
 =?utf-8?B?aGxuOURYeXozOGl0NXJhU3BQTlFIbkJzamNjejkwTHFRalVieFg4UmJ2aU9P?=
 =?utf-8?Q?OBON6QoklsWv+bhI/xNIE0UwCyZYKPlGku+uYSE?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a418274-2ffa-4f5b-ab61-08d8e9e7be2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:28:00.9692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xE7if/z8micYoKa/7Eh1Pkx19IwJvPWfsLagxEyPhrmJ0znQHkbXWwHzEbSYs9gN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3995
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

>>> Those two steps need to be exchanged or otherwise it is possible that new delayed work items etc are started before the lock is taken.
What about adding check for adev->in_gpu_reset in work item? If exchange the two steps, it maybe introduce the deadlock.  For example, the user thread hold the read lock and waiting for the fence, if recovery thread try to hold write lock and then complete fences, in this case, recovery thread will always be blocked. 

Best Regards
Dennis Li
-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Thursday, March 18, 2021 3:54 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability

Am 18.03.21 um 08:23 schrieb Dennis Li:
> We have defined two variables in_gpu_reset and reset_sem in adev object. The atomic type variable in_gpu_reset is used to avoid recovery thread reenter and make lower functions return more earlier when recovery start, but couldn't block recovery thread when it access hardware. The r/w semaphore reset_sem is used to solve these synchronization issues between recovery thread and other threads.
>
> The original solution locked registers' access in lower functions, which will introduce following issues:
>
> 1) many lower functions are used in both recovery thread and others. Firstly we must harvest these functions, it is easy to miss someones. Secondly these functions need select which lock (read lock or write lock) will be used, according to the thread it is running in. If the thread context isn't considered, the added lock will easily introduce deadlock. Besides that, in most time, developer easily forget to add locks for new functions.
>
> 2) performance drop. More lower functions are more frequently called.
>
> 3) easily introduce false positive lockdep complaint, because write lock has big range in recovery thread, but low level functions will hold read lock may be protected by other locks in other threads.
>
> Therefore the new solution will try to add lock protection for ioctls of kfd. Its goal is that there are no threads except for recovery thread or its children (for xgmi) to access hardware when doing GPU reset and resume. So refine recovery thread as the following:
>
> Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>     1). if failed, it means system had a recovery thread running, current thread exit directly;
>     2). if success, enter recovery thread;
>
> Step 1: cancel all delay works, stop drm schedule, complete all unreceived fences and so on. It try to stop or pause other threads.
>
> Step 2: call down_write(&adev->reset_sem) to hold write lock, which will block recovery thread until other threads release read locks.

Those two steps need to be exchanged or otherwise it is possible that new delayed work items etc are started before the lock is taken.

Just to make it clear until this is fixed the whole patch set is a NAK.

Regards,
Christian.

>
> Step 3: normally, there is only recovery threads running to access hardware, it is safe to do gpu reset now.
>
> Step 4: do post gpu reset, such as call all ips' resume functions;
>
> Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads and release write lock. Recovery thread exit normally.
>
> Other threads call the amdgpu_read_lock to synchronize with recovery thread. If it finds that in_gpu_reset is 1, it should release read lock if it has holden one, and then blocks itself to wait for recovery finished event. If thread successfully hold read lock and in_gpu_reset is 0, it continues. It will exit normally or be stopped by recovery thread in step 1.
>
> Dennis Li (4):
>    drm/amdgpu: remove reset lock from low level functions
>    drm/amdgpu: refine the GPU recovery sequence
>    drm/amdgpu: instead of using down/up_read directly
>    drm/amdkfd: add reset lock protection for kfd entry functions
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  14 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 +++++++++++++-----
>   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   9 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   5 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   4 +
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  17 ++
>   12 files changed, 345 insertions(+), 75 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
