Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F76C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD89064E22
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 08:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD89064E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523CB6E29D;
	Thu, 18 Mar 2021 08:58:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A136E29D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 08:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnClSnJSzLeXqqCgPi6aM4rbGBUpNKVJcDkgxkZXnj8dN8Ujyx8tODDWFioE2XeufhFzVOCwjBe788uxtxQ2ViIWqfS4o5EIZQ/TctDNMQaZMpDKD5EViQKenjqA0yZne9flwl46vzkBNIP67EIBKTzcvg2uwh5myQJJl9IKQN4DuYI0Ap6wvp19Mu7qFr3KVHGPIgy2hnVYBSZJMFrISZUqSJgGSXy3v/rK3q53qmKzmkyhHFunDt/5wB87lJiRLmeOkiImd4Qfx16OoGuqeoa8NeIxoLki0xBUKhVySFgAuMcyDZOUtZ4wOhrA1tpP3SRL0IzZYNvOVlyOVfC21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha2TPhRPXmUb3WRNhuMl9OrD1n/lX2e/Q5797THJZbU=;
 b=OPgPsCzm2kJVvhVSSebhcuGe6qLejxDJlMeIQPPOZzZlCBvWrMA8n3DXzlF+YS3fhFRlxu3XZHOiIkw4LImF0LNFeZaM5s158witTNfuaA+l9Naf4HB+upg3Hn/86/7xEp+yOcUzpqV9cjgpiqqk1v/dv+82rCqGL0RFOI1dQN9VkXcbGaKaMuIUy9KYyzba4ci2MKQJslwZwOkndW2Vs9X27FJ9ZP1xLwBc32qUgGzaQSy+tyBzIVZc6DrYq8qKOj/hxGP6you1ZLmLSrnLNTw6uPP2OESrAaWJrRhLWLPWh5i2T/o4eyuSIHzIAbcAs1g/XSQLyTS0df7h7yOEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha2TPhRPXmUb3WRNhuMl9OrD1n/lX2e/Q5797THJZbU=;
 b=g//YC0rpjhThoyEmIny3prEFgItR+M+MT88+oMzD1MlRXWGKD0ca6E+lJS/PQzmeyi7M7XAZCigmugrQ7P0qqJVjfOhXnwALkIG2fEuUdDzCwXyYqgIbEeRUEP3OpULWTFALv5JjFDTNpiwGi+iv8jaKhTLbINrADxvOMUfpKgk=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 08:58:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 08:58:53 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: AW: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Topic: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Thread-Index: AQHXG8elvgsidymFUkaXIi/8fPz0+KqJYAuAgAAJmwCAAAdycg==
Date: Thu, 18 Mar 2021 08:58:53 +0000
Message-ID: <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>,
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2a01:598:91b0:db8a:8549:e251:5673:4f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09a112e3-56a2-4459-f9f4-08d8e9ec0e3c
x-ms-traffictypediagnostic: BL0PR12MB4963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB496311F3EF05E0A99682D92583699@BL0PR12MB4963.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2G2VYSG7r/F1g4hno6Z6SLJm+HKgqE11Upkyb5UdZCHQjJUuje53bFXHwTH4lBWJNw9G0xd9YS7mYg/4B6KucdFU6vDFVERxQdlguzqDn2j3Z8HL2lNVrIWDQAsEfzI43JSEjrkvvwy+2lwXBoZRfA+To6TCGn4SUWx1xFKP7diakYoHKsRjL2pGPyfM04KNoNxkQhdJjYsocoFgfBWIYkVvkeeAwVbln/CRX1jJhnWLkGskF6UULJzHazaJU9c1KqeIrTJE2+hoh9zRZOvX5ogAIbxel5kXxZM4tNKebqCHiuhhGtK9HH7oZyNo1F/aGDiKQN9rmO/VFqMAtO9kOPHV2WWCjC49KyHmeS60plbHJWMlChvIZxRLhgBV4PiAYCLwg28a1PW4IJtoD+Nq7KGiOTKZv44rXZDOkwuJ1wuwU4p5nEMS1ah0N6ym/IiBE//Q1hiSMoJZJdPdYa8GVUM8qhDmI37N1X9ecg55pEX23ZbqewBZxKYu7Rn8U2dGCzzCsIM8iGpDu+AIdkecjL+xOgBsY8H61IKaQhnxohEseEund3xWBT4RqHus0zRpb4tLxDRbBQZMU0RJHr5wm65o/Enad05BrbbBlBte0x9qpwBOiKcAQ/ZemRtyxLwl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(8936002)(9686003)(91956017)(53546011)(52536014)(38100700001)(316002)(66556008)(8676002)(7696005)(186003)(66446008)(64756008)(6506007)(66946007)(71200400001)(76116006)(86362001)(83380400001)(66574015)(6636002)(33656002)(55016002)(5660300002)(478600001)(2906002)(110136005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bDVKLDlJXjcBpewfY7WVOxNq/1OS+A5XGVlNLgU1zvs93bNayrU8W/rOWr?=
 =?iso-8859-1?Q?PZmR6Q+tin3MB0wTQ0/rx52MwrNA+j+7EuUW0Fr8exlgYaSE0oPqRtG55J?=
 =?iso-8859-1?Q?hT6v6Ks5wdU0lQ7C51YFic0k6+1qX2p7FAbgiHMqpDgfRXYjpiKL6yzQDy?=
 =?iso-8859-1?Q?6UU8tXU3YWYYm9XOsR4TNopUvXFAeIcvu4tx37qLKuwJ/MuPehf0RcERZM?=
 =?iso-8859-1?Q?6FB+KSbA+hoRnlOd/SLJ1GV2jlHa0mdiy/M8MmXrbLtyolGwTJnuxwPP/F?=
 =?iso-8859-1?Q?Y7aeHef2aEksgGNQjOGq0k9fTt4m6eS7YMa69x8FUaNUyi021KQzVZx5yr?=
 =?iso-8859-1?Q?X2tLIw7lkX3W9++a14mdSbuaoM9zlVdA33qVPd5B8el2AfwCezqhjzXAFM?=
 =?iso-8859-1?Q?fRaqJQ2HFU14ntPEP0iOwIDdMEG/h7rn2Xvf90tinsXoWrbextursv0W0T?=
 =?iso-8859-1?Q?piwflq18P6WLW7SyBv/sNmUT8ni6q5GjCIhoQTJ/TPZIbm9cjCFSK0NlLO?=
 =?iso-8859-1?Q?7Huky2J4DzN+OaBp+MvUfYtA5L6uWlL0Ber6h9093+AYPpr1/gdE7TioLv?=
 =?iso-8859-1?Q?eXeMJKweuFRLszxgbVYnFz8+2CMx/3L3dPmERfVxvr5IVvx5fNWOtCos9E?=
 =?iso-8859-1?Q?ly9VKRyHW0SrplhmOBO1Q1Yw/tgcxFe8TQIzuQTFesaRVgb+DQS/+EGxl9?=
 =?iso-8859-1?Q?io4nAkEpF+UGg1MZORTp6z3zhLlJ6TAz48yovCMaokovZ6WpZWCplTCZ2A?=
 =?iso-8859-1?Q?Umk/y9JtEtV/4wXGA50r+Q6Q5qhBFD66jIZFN4ZenDqa5xjrTdf5TR0uPp?=
 =?iso-8859-1?Q?0aqfYU2qY5vWA57VC6dF9VeyeJlToJBqbrrUNQsl9L5Ai/FkwcHfZTUOdF?=
 =?iso-8859-1?Q?mZAmrIutxBFS67az5jZl3skrkS0VFJ1kwtknbZuAFaPTpZtOJIcj7aII63?=
 =?iso-8859-1?Q?8rDrLnX+NQ6oiPqw2DEpfbADCFCdFtgWUCEC/cEfW/2ShDquzCWUBOsUT6?=
 =?iso-8859-1?Q?EuxyHOKVObDzhIwBQeDNmmMOZA8N+OW3hJXyMSHdUUIJun0vwIUm8Cqy/R?=
 =?iso-8859-1?Q?mWSKIzE2yCQzvpU3x6jRS6jLl12j4qwUrstQx+XamxbHjXTX6O9qywJZyG?=
 =?iso-8859-1?Q?2ERwa2LDpJsxlbBT86ums4txXdZIXN/Mmm+LOExIoxXtA+9qc52Udhmgfv?=
 =?iso-8859-1?Q?8j/KlwOceW9sf65z4lV/c+bGvhgOzEyuO/oxwUxxDLN/iE3d2B5jMrnk49?=
 =?iso-8859-1?Q?RRV+OoOdhqGRpmqH6egaehjq6ZfB17kWRORv9i6VCbHN/c38nfeEhlpYiv?=
 =?iso-8859-1?Q?gMTF7EVYfkU7o/ZNqGDQKCgSXjAaCphi87YbkdyjGOMH2tkJBMbzhY26CQ?=
 =?iso-8859-1?Q?aUIozGiu5jzvWmhCw6NwsKqjdSp+3VHhMjJJJhKAhlzVF9kFsLc/c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a112e3-56a2-4459-f9f4-08d8e9ec0e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 08:58:53.1447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSDP8XXJmGbaJ7DZ64yyEP5epPJo+8WCYhqd+J3yBZOfvOsL55v6X2DiDAWnr49x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
Content-Type: multipart/mixed; boundary="===============0794093820=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0794093820==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3775531A74B886A207134B1583699MN2PR12MB3775namp_"

--_000_MN2PR12MB3775531A74B886A207134B1583699MN2PR12MB3775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Exactly that's what you don't seem to understand.

The GPU reset doesn't complete the fences we wait for. It only completes th=
e hardware fences as part of the reset.

So waiting for a fence while holding the reset lock is illegal and needs to=
 be avoided.

Lockdep also complains about this when it is used correctly. The only reaso=
n it doesn't complain here is because you use an atomic+wait_event instead =
of a locking primitive.

Regards,
Christian.

________________________________
Von: Li, Dennis <Dennis.Li@amd.com>
Gesendet: Donnerstag, 18. M=E4rz 2021 09:28
An: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawkin=
g.Zhang@amd.com>
Betreff: RE: [PATCH 0/4] Refine GPU recovery sequence to enhance its stabil=
ity

>>> Those two steps need to be exchanged or otherwise it is possible that n=
ew delayed work items etc are started before the lock is taken.
What about adding check for adev->in_gpu_reset in work item? If exchange th=
e two steps, it maybe introduce the deadlock.  For example, the user thread=
 hold the read lock and waiting for the fence, if recovery thread try to ho=
ld write lock and then complete fences, in this case, recovery thread will =
always be blocked.

Best Regards
Dennis Li
-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, March 18, 2021 3:54 PM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stabil=
ity

Am 18.03.21 um 08:23 schrieb Dennis Li:
> We have defined two variables in_gpu_reset and reset_sem in adev object. =
The atomic type variable in_gpu_reset is used to avoid recovery thread reen=
ter and make lower functions return more earlier when recovery start, but c=
ouldn't block recovery thread when it access hardware. The r/w semaphore re=
set_sem is used to solve these synchronization issues between recovery thre=
ad and other threads.
>
> The original solution locked registers' access in lower functions, which =
will introduce following issues:
>
> 1) many lower functions are used in both recovery thread and others. Firs=
tly we must harvest these functions, it is easy to miss someones. Secondly =
these functions need select which lock (read lock or write lock) will be us=
ed, according to the thread it is running in. If the thread context isn't c=
onsidered, the added lock will easily introduce deadlock. Besides that, in =
most time, developer easily forget to add locks for new functions.
>
> 2) performance drop. More lower functions are more frequently called.
>
> 3) easily introduce false positive lockdep complaint, because write lock =
has big range in recovery thread, but low level functions will hold read lo=
ck may be protected by other locks in other threads.
>
> Therefore the new solution will try to add lock protection for ioctls of =
kfd. Its goal is that there are no threads except for recovery thread or it=
s children (for xgmi) to access hardware when doing GPU reset and resume. S=
o refine recovery thread as the following:
>
> Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>     1). if failed, it means system had a recovery thread running, current=
 thread exit directly;
>     2). if success, enter recovery thread;
>
> Step 1: cancel all delay works, stop drm schedule, complete all unreceive=
d fences and so on. It try to stop or pause other threads.
>
> Step 2: call down_write(&adev->reset_sem) to hold write lock, which will =
block recovery thread until other threads release read locks.

Those two steps need to be exchanged or otherwise it is possible that new d=
elayed work items etc are started before the lock is taken.

Just to make it clear until this is fixed the whole patch set is a NAK.

Regards,
Christian.

>
> Step 3: normally, there is only recovery threads running to access hardwa=
re, it is safe to do gpu reset now.
>
> Step 4: do post gpu reset, such as call all ips' resume functions;
>
> Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads and rel=
ease write lock. Recovery thread exit normally.
>
> Other threads call the amdgpu_read_lock to synchronize with recovery thre=
ad. If it finds that in_gpu_reset is 1, it should release read lock if it h=
as holden one, and then blocks itself to wait for recovery finished event. =
If thread successfully hold read lock and in_gpu_reset is 0, it continues. =
It will exit normally or be stopped by recovery thread in step 1.
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


--_000_MN2PR12MB3775531A74B886A207134B1583699MN2PR12MB3775namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Exactly that's what you don't seem to understand.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
The GPU reset doesn't complete the fences we wait for. It only completes th=
e hardware fences as part of the reset.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
So waiting for a fence while holding the reset lock is illegal and needs to=
 be avoided.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Lockdep also complains about this when it is used correctly. The only reaso=
n it doesn't complain here is because you use an atomic+wait_event instead =
of a locking primitive.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Regards,</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Christian.</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Li, Dennis &lt;Dennis.=
Li@amd.com&gt;<br>
<b>Gesendet:</b> Donnerstag, 18. M=E4rz 2021 09:28<br>
<b>An:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehling@amd.=
com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Betreff:</b> RE: [PATCH 0/4] Refine GPU recovery sequence to enhance its=
 stability</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt;&gt;&gt; Those two steps need to be exchanged =
or otherwise it is possible that new delayed work items etc are started bef=
ore the lock is taken.<br>
What about adding check for adev-&gt;in_gpu_reset in work item? If exchange=
 the two steps, it maybe introduce the deadlock.&nbsp; For example, the use=
r thread hold the read lock and waiting for the fence, if recovery thread t=
ry to hold write lock and then complete
 fences, in this case, recovery thread will always be blocked.</div>
<div class=3D"PlainText"><br>
Best Regards<br>
Dennis Li<br>
-----Original Message-----<br>
From: Koenig, Christian &lt;Christian.Koenig@amd.com&gt; <br>
Sent: Thursday, March 18, 2021 3:54 PM<br>
To: Li, Dennis &lt;Dennis.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org; De=
ucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Fel=
ix.Kuehling@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stabil=
ity<br>
<br>
Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
&gt; We have defined two variables in_gpu_reset and reset_sem in adev objec=
t. The atomic type variable in_gpu_reset is used to avoid recovery thread r=
eenter and make lower functions return more earlier when recovery start, bu=
t couldn't block recovery thread when
 it access hardware. The r/w semaphore reset_sem is used to solve these syn=
chronization issues between recovery thread and other threads.<br>
&gt;<br>
&gt; The original solution locked registers' access in lower functions, whi=
ch will introduce following issues:<br>
&gt;<br>
&gt; 1) many lower functions are used in both recovery thread and others. F=
irstly we must harvest these functions, it is easy to miss someones. Second=
ly these functions need select which lock (read lock or write lock) will be=
 used, according to the thread it is
 running in. If the thread context isn't considered, the added lock will ea=
sily introduce deadlock. Besides that, in most time, developer easily forge=
t to add locks for new functions.<br>
&gt;<br>
&gt; 2) performance drop. More lower functions are more frequently called.<=
br>
&gt;<br>
&gt; 3) easily introduce false positive lockdep complaint, because write lo=
ck has big range in recovery thread, but low level functions will hold read=
 lock may be protected by other locks in other threads.<br>
&gt;<br>
&gt; Therefore the new solution will try to add lock protection for ioctls =
of kfd. Its goal is that there are no threads except for recovery thread or=
 its children (for xgmi) to access hardware when doing GPU reset and resume=
. So refine recovery thread as the
 following:<br>
&gt;<br>
&gt; Step 0: atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0, 1)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a recovery =
thread running, current thread exit directly;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
&gt;<br>
&gt; Step 1: cancel all delay works, stop drm schedule, complete all unrece=
ived fences and so on. It try to stop or pause other threads.<br>
&gt;<br>
&gt; Step 2: call down_write(&amp;adev-&gt;reset_sem) to hold write lock, w=
hich will block recovery thread until other threads release read locks.<br>
<br>
Those two steps need to be exchanged or otherwise it is possible that new d=
elayed work items etc are started before the lock is taken.<br>
<br>
Just to make it clear until this is fixed the whole patch set is a NAK.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Step 3: normally, there is only recovery threads running to access har=
dware, it is safe to do gpu reset now.<br>
&gt;<br>
&gt; Step 4: do post gpu reset, such as call all ips' resume functions;<br>
&gt;<br>
&gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0, wake up other threads a=
nd release write lock. Recovery thread exit normally.<br>
&gt;<br>
&gt; Other threads call the amdgpu_read_lock to synchronize with recovery t=
hread. If it finds that in_gpu_reset is 1, it should release read lock if i=
t has holden one, and then blocks itself to wait for recovery finished even=
t. If thread successfully hold read
 lock and in_gpu_reset is 0, it continues. It will exit normally or be stop=
ped by recovery thread in step 1.<br>
&gt;<br>
&gt; Dennis Li (4):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from low level functio=
ns<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU recovery sequence<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using down/up_read directly<b=
r>
&gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock protection for kfd entry =
functions<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&=
nbsp; 14 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p; | 173 +++++++++++++-----<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 8 -<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 172 ++++++++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 4 +<br>
&gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 17 ++<br>
&gt;&nbsp;&nbsp; 12 files changed, 345 insertions(+), 75 deletions(-)<br>
&gt;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3775531A74B886A207134B1583699MN2PR12MB3775namp_--

--===============0794093820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0794093820==--
