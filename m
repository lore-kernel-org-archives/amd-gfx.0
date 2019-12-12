Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2010BC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E369D206A5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hqK+SGkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E369D206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8493E6E14E;
	Thu, 12 Dec 2019 14:50:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279176E14E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 14:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTIiQjOkOhOPmAKOdw1g6XCOwkFEyHKZXspx5yRdeyRDvSsMzMtp4PCclVD7XjfBXhnMjZ8w8Ffki4lYxzNjp09mpH7UuHNNBJoE7THE9zhRqcfM7BhTWuKDRWVbA+bFDscaKwAtfvK7hUaN8DsNGhEpgZpB3YjCQaJVA0Mc0HcqYMkdTPFe2Jb2UDGzKNn5o6eKo7Fa1/sph+bMOaDtgcm4oOyCrg/nqyBDVdMGz+8zbCD59At+yxNXpqR5G9C4A0vwGeYyhRA7GXM14Y59KC1eej0DPOW38bSsB96G5y+F1KDJeOReseJLbqRFYENXDzf550tMdSKhXDc8eCvanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTqDYthY+0q+FhFj4yInHfDxKpdS9JUPnfcObsjFhyw=;
 b=CTGCuwdwuVVPowcLqpFoibYVaQuzDQ2qYxhfabVWiJkr7+RitYUaoqtUqEM+ADbBGXVc7pGrpQTSCWs3jcENL95AWAinCqKsi5UbHV7oESj+G+ia42PBFJTOIXFQsqdSxUkcHvqMiUB+KTGL5VMjwZmTttHpc2yvrIttOiJEYrFmNhNnX8TJB8dJTiPqQIa7EDRiTQStBJ0OT80USM3HnPPUa5NGvOycOrha5OPt6NYw72tgAqMXQ6vDcJ+RF207R8slsGAoVQ60IoUxVNFQT+PW+6DMX69Ifjqn8J5cHumN6+k7SYDoM94cQUX0yFYV6RjLwrmAx+pDbMrDM2XX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTqDYthY+0q+FhFj4yInHfDxKpdS9JUPnfcObsjFhyw=;
 b=hqK+SGkNKNB0aJ2VMafOlYB3w0UCRZ05rp+U1mJBIERno2NfuOJb6x3WQUbBRuwF2k5K5dFFpq26+Krk0MkcCRBoWRY0CVFw/onY+PXCmBms+yRaXMXth2E9lAJUc7fIuhvjioNJZJqR3Lvswna9Z5vnfgkT/DOsnURkIP2Zj9E=
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1581.namprd12.prod.outlook.com (10.172.55.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 14:50:26 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 14:50:26 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.
Thread-Topic: [PATCH 2/5] drm: Add Reusable task barrier.
Thread-Index: AQHVsF6bdH7QeByFJEeo4pZsu0JAW6e1X/GAgADKmoCAAAHZAIAAaYPB
Date: Thu, 12 Dec 2019 14:50:25 +0000
Message-ID: <MWHPR12MB1453492D18A1C692AFFE701AEA550@MWHPR12MB1453.namprd12.prod.outlook.com>
References: <1576094829-2245-1-git-send-email-andrey.grodzovsky@amd.com>
 <1576094829-2245-2-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_OCzqh_t5YHithp2Kh0rxHsk4XxnfHm-Cm2_T7ZGSA4Ow@mail.gmail.com>
 <2b12b91a-e40f-25f4-bc7c-71566ffdabd4@gmail.com>,
 <fa72ffe9-39fb-4bf2-f8e7-8b4f53cfa7ad@gmail.com>
In-Reply-To: <fa72ffe9-39fb-4bf2-f8e7-8b4f53cfa7ad@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-12T14:50:24.914Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
x-originating-ip: [208.98.222.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec1f3dfd-f579-43e6-53e7-08d77f129fbd
x-ms-traffictypediagnostic: MWHPR12MB1581:|MWHPR12MB1581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB15811E15D899A9DFC032F53DEA550@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(9686003)(81156014)(45080400002)(71200400001)(7696005)(478600001)(52536014)(8936002)(8676002)(81166006)(2906002)(66574012)(64756008)(66446008)(33656002)(186003)(5660300002)(966005)(86362001)(26005)(54906003)(55016002)(6506007)(316002)(110136005)(53546011)(66556008)(66476007)(4326008)(76116006)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1581;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGYAZtz7+Bz8wgVsIDMBy+m/1K7nJ80Wk0imwYUVw4PavNzOWIFWrWWT7exbSNsz1BL4gMVZLI+9UrP1w6A3WUcf6RcVFB/lGbSqbln8ndUu6rA4hePEu5AGN78V4lAAS4oaSdJY/B+KZV97ImatolXDFZDksOSqlw1+8EexBxQpEYBGmXmIPqY2zcpsVJEnrb5HZ4R97QeypK4Ta3PglRJVYgCudQAkKj1HbQt821RXuDNbH0BvwcJyGsXwaRaEXOmuLX2ck1A9uFsw9h13iqVKQTR44UWNDhSLIWe1x7aXySJqRBFzfabDPmo+UI3YzPTYbqB4t9Umifd5sfHCBdyyne6NaXNrdszzF/fQTC7z99OFbIuCu9F80+cHCvTuIuXTlqtx8w4XtKwg1iwC8QPdIgmRznxz4jjuE+dW066T36ndtEcDpGdZKQenF5d+
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1f3dfd-f579-43e6-53e7-08d77f129fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 14:50:26.0019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcTW93lqPWqbD7NMBe1BrlE8Y5yMVmUIizUmY/ZaQokNppvMnCvpA4gPKq46vopsm6Hb45SExSjgRsD1SAECZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

______________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: 12 December 2019 03:31
To: Alex Deucher; Grodzovsky, Andrey
Cc: Deucher, Alexander; Ma, Le; Quan, Evan; amd-gfx list; Zhang, Hawking
Subject: Re: [PATCH 2/5] drm: Add Reusable task barrier.

Am 12.12.19 um 09:24 schrieb Christian K=F6nig:
> Am 11.12.19 um 21:19 schrieb Alex Deucher:
>> On Wed, Dec 11, 2019 at 3:07 PM Andrey Grodzovsky
>> <andrey.grodzovsky@amd.com> wrote:
>>> It is used to synchronize N threads at a rendevouz point before
>>> execution
>>> of critical code that has to be started by all the threads at
>>> approximatly
>>> the same time.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> You should resend to dri-devel since this task barrier is being added
>> to common code.
>
> Additional to that this whole thing has the potential to raise lockdep
> warnings and if I'm not completely mistaken doesn't even work correctly.

Can you give me a potential lockdep scenario ?

Andrey

>
> See Linux kernel semaphores don't allow negative values (the count
> field in struct semaphore is unsigned).

Ok, forget what I've wrote. That indeed seems to be supported, some
other drivers are already using semaphores the same way.

Regards,
Christian.

>
> Regards,
> Christian.
>
>>
>> Alex
>>
>>> ---
>>>   include/drm/task_barrier.h | 106
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 106 insertions(+)
>>>   create mode 100644 include/drm/task_barrier.h
>>>
>>> diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
>>> new file mode 100644
>>> index 0000000..81fb0f7
>>> --- /dev/null
>>> +++ b/include/drm/task_barrier.h
>>> @@ -0,0 +1,106 @@
>>> +/*
>>> + * Copyright 2019 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person
>>> obtaining a
>>> + * copy of this software and associated documentation files (the
>>> "Software"),
>>> + * to deal in the Software without restriction, including without
>>> limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>> sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to
>>> whom the
>>> + * Software is furnished to do so, subject to the following
>>> conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>>> EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>> DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>> OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>> USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#include <linux/semaphore.h>
>>> +#include <linux/atomic.h>
>>> +
>>> +/*
>>> + * Reusable 2 PHASE task barrier (randevouz point) implementation
>>> for N tasks.
>>> + * Based on the Little book of sempahores -
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgre=
enteapress.com%2Fwp%2Fsemaphores%2F&amp;data=3D02%7C01%7Candrey.grodzovsky%=
40amd.com%7C96f8c28ae4bd43f2922208d77eddb60f%7C3dd8961fe4884e608e11a82d994e=
183d%7C0%7C0%7C637117363029062995&amp;sdata=3D6xXZXyDIKmQM8ET5hPIZ%2FbJrOMQ=
qK4oYw8dGYS1rxcY%3D&amp;reserved=3D0
>>> + */
>>> +
>>> +
>>> +
>>> +#ifndef DRM_TASK_BARRIER_H_
>>> +#define DRM_TASK_BARRIER_H_
>>> +
>>> +/*
>>> + * Represents an instance of a task barrier.
>>> + */
>>> +struct task_barrier {
>>> +       unsigned int n;
>>> +       atomic_t count;
>>> +       struct semaphore enter_turnstile;
>>> +       struct semaphore exit_turnstile;
>>> +};
>>> +
>>> +static inline void task_barrier_signal_turnstile(struct semaphore
>>> *turnstile,
>>> +                                                unsigned int n)
>>> +{
>>> +       int i;
>>> +
>>> +       for (i =3D 0 ; i < n; i++)
>>> +               up(turnstile);
>>> +}
>>> +
>>> +static inline void task_barrier_init(struct task_barrier *tb)
>>> +{
>>> +       tb->n =3D 0;
>>> +       atomic_set(&tb->count, 0);
>>> +       sema_init(&tb->enter_turnstile, 0);
>>> +       sema_init(&tb->exit_turnstile, 0);
>>> +}
>>> +
>>> +static inline void task_barrier_add_task(struct task_barrier *tb)
>>> +{
>>> +       tb->n++;
>>> +}
>>> +
>>> +static inline void task_barrier_rem_task(struct task_barrier *tb)
>>> +{
>>> +       tb->n--;
>>> +}
>>> +
>>> +/*
>>> + * Lines up all the threads BEFORE the critical point.
>>> + *
>>> + * When all thread passed this code the entry barrier is back to
>>> locked state.
>>> + */
>>> +static inline void task_barrier_enter(struct task_barrier *tb)
>>> +{
>>> +       if (atomic_inc_return(&tb->count) =3D=3D tb->n)
>>> + task_barrier_signal_turnstile(&tb->enter_turnstile, tb->n);
>>> +
>>> +       down(&tb->enter_turnstile);
>>> +}
>>> +
>>> +/*
>>> + * Lines up all the threads AFTER the critical point.
>>> + *
>>> + * This function is used to avoid any one thread running ahead of
>>> the reset if
>>> + * the barrier is used in a loop (repeatedly) .
>>> + */
>>> +static inline void task_barrier_exit(struct task_barrier *tb)
>>> +{
>>> +       if (atomic_dec_return(&tb->count) =3D=3D 0)
>>> + task_barrier_signal_turnstile(&tb->exit_turnstile, tb->n);
>>> +
>>> +       down(&tb->exit_turnstile);
>>> +}
>>> +
>>> +static inline void task_barrier_full(struct task_barrier *tb)
>>> +{
>>> +       task_barrier_enter(tb);
>>> +       task_barrier_exit(tb);
>>> +}
>>> +
>>> +#endif
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Candr=
ey.grodzovsky%40amd.com%7C96f8c28ae4bd43f2922208d77eddb60f%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637117363029067994&amp;sdata=3D4skEGGfYBmQco%2=
FaCXneWuR1p8l%2F0JS8IrLNx%2Bddzxos%3D&amp;reserved=3D0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist=
s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Candre=
y.grodzovsky%40amd.com%7C96f8c28ae4bd43f2922208d77eddb60f%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637117363029067994&amp;sdata=3D4skEGGfYBmQco%2F=
aCXneWuR1p8l%2F0JS8IrLNx%2Bddzxos%3D&amp;reserved=3D0
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
