Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7963CD8C92
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 02:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C51410EC09;
	Mon,  8 Jun 2026 02:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xwN+wAjm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B22F10EC09
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 02:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2Lfhw9uoafG3BWUn6Nvd3umBLQw4Tgx2TOux3KXkTobaNYpdSRJgqDqH8Dy7AhzxccFAGpq5tTTjGGAeuaIL6BNh1dmSJrAGhGYx5EQwyUNsjs4pMF73FgT7P+WFSH20Q7IAiC0HszQgKpWuLLkBN4e/ShX0iMrxfTVTgqMCh4taNU4t9iSO4wcX1vLr8n92QqoUeQbg4YA0lLDNod8XYs7GsorzPMK8q9Ma+NrPzzLVVUDNDBnBrAbtUeqqlQ5yJgBK3dzcoCikdV691hak6IVySoCKj9JZk2zDNRIqQqHaZiJ1svxMLHjY5gI0xY/ZY/vlr2fPqxraed58Ud3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n35eIh2X9sGmstux/gaYrB/OT6NR6XdNQ/KkharD2hU=;
 b=n5X/tP6N02MkC1GAQ85ci5IWW+KjQTKAbiYzE5B1UJ7B2XoQ0YuIJeGe9esX/IOGzBngy+Lf3YmwKHuX7/agjq2LUo2sdCNN6ikNvYIYC1/Mxzp5AdHFCNHdV35A222DtjT+N4TdCNGTt5XkMC9pDIp8hIUUdaPIE1oMqS589DkPlF0YKgBhfydzIaL6GaI1dinE6xKADjY7st3psD+Q55UfndhuuL3/wb3URkBSczkukNbwWMam8H+8TjUSw2aIRExAqOpoMFC9/YqSHCax8eJ8qrzduWWz69GW7YOIH1uBTi3iHxX0CnCcywcuiGxSs39PWUy/Ti5LLl7AmHHFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n35eIh2X9sGmstux/gaYrB/OT6NR6XdNQ/KkharD2hU=;
 b=xwN+wAjmSqc/ZU0ifC4EHCrvow3mLXFeHSxzAfvo/iDtcQZGXpM8PP/rCh+3GOsYHb/yoXzOYUGUBju1mKcWSyy5vWd50UdMw6yZOYn5WskEaFlnF6MMJPSSHRbp3jZkLa2x7K8UmWxsBdvUzc+DIHZ6uR7rLxkW2S8L2X3DzV0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Mon, 8 Jun 2026 02:01:24 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:01:24 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: allocate lockdep mutex on the heap to fix
 stack overflow
Thread-Topic: [PATCH] drm/amdgpu: allocate lockdep mutex on the heap to fix
 stack overflow
Thread-Index: AQHc9MuZNEz/5hBmS0+6oP7aIdY+wrYwR+8AgAOf6AA=
Date: Mon, 8 Jun 2026 02:01:24 +0000
Message-ID: <DS7PR12MB6005ABDB6A40FC9BCEFD61EFFB1C2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260605091322.144703-1-Prike.Liang@amd.com>
 <748a0cfc-528a-43af-9dc7-59d58428962a@amd.com>
In-Reply-To: <748a0cfc-528a-43af-9dc7-59d58428962a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-08T01:47:28.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB6704:EE_
x-ms-office365-filtering-correlation-id: 360ab059-dd3c-46c0-2f52-08dec501d815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: qSGmskPKb/uMVdIwK/du2dyEHOUwOgysJPsesctWMb6DTS5ZYBj8mXp05NVOydjL/Hw5CeKwqTtApYFgyNDVBlnDgY8XIOv1f56GIMWat5xMbdlcvJRWNdJ4ttlgY4V0NeaXCLawa6H76KwT/bnyWKbXcrBrpMae/XWNF8bXvXuLVJdpleA3EEHrmYX835UvBJ4GARtKixOyGHDU3/WYOp2zdGowwLmEZt209IY23s4cV80r2KM6Jduj+Aje86QfSJnuPAkX77MwmFbwQyogPeD+5qH7vpbewe9VhEVr04kam3nOZ3HwOjXNnbG3GEUQPvWHOk1EII7bMUJq6QjUkRiWYJMAtG15eYWmncMQGkeCZBuWaRP0YnvCgPcMZ6v4W0QpGPNXAlMpJIf5FcOEvgDUiKnmTv88pr4K1EF6yl2rd66eIiY+4oDIbraQCJLMEUdoJr2G2WsCbLxzjqBfr+AVUdV5IpqtH9oH5GNeAkHp0G7NbxxYa0Ve3qJjsHIALdspbJo6SlJhqgeotbQvpZ887O0s84Vm0bE5I2AgacBGZ+zRyn7+1YXf7ODXnpRh8XCXatY6XMohp6myqAkmqgJ25rzFDoA9Wcn+j+UG8zZbKptkgL3sXTeo/Qi9+u0sfUgM27+vZ+amGWy/a2uXo3158kvb5DCTdG8wztsX+x76qJlP0mjuWTccfR43HJ+vWUyo0xeiCph4xVldw8z9ozcEaftYS6p3HTWNLba1bC72FHCSw1M5KuCIEJYkcd0V
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JYMUQgui/Tn4iN2Px/0vEVr1Yi9s9BY03kCswqoDQGvbeFx2G5G8f1CZ5e5A?=
 =?us-ascii?Q?IuvDNCmWn6eYtJ52rTnXpx2X+KihG/9VGpnrDEhijZkEQ0VavusGlY7Fw4t7?=
 =?us-ascii?Q?JWXy/ZDjVv4cnYyGJp5qCm0J3B9qZ1nD6YKR7fUsIXSTTT06omCtPbFG4z4E?=
 =?us-ascii?Q?Xd9AIFhju3RduaArCfqL1Jms3qLDKEdr3UriUaoaxmLg0NIg6ALGErh0Cc9v?=
 =?us-ascii?Q?KqsgrPXj+QE+k1+4vynvF2n2sqWDT6dD79/Qs5ep93bSTsz7v/J2HwqqPbtZ?=
 =?us-ascii?Q?x4sI4WcHkxBWWnVN6mE/cuFbRR3RsLZRRprxqV8ckXFv2aAS4NELD+Sz7Kpl?=
 =?us-ascii?Q?y0q3fUStuI1+ArF7cPtAE3kxHuAVdTD4aqxXEHt5PH7lQmh2AM8xtGAG2LD7?=
 =?us-ascii?Q?RlrJsJRqjazAN+wBqCXbgeAeRqV8hdD1UxUhWXAeEsbV8vesG5qlmNXa+G4T?=
 =?us-ascii?Q?Ijl0K3T7yOayTxGWE3H9CeJmt4qRfuh0UXhghYHq8oOrK87Qleqc/ZhqUWz+?=
 =?us-ascii?Q?kODv5SapYjkVyRVGaHpShsm1t3MaBAIQQr+8sM7O4TrU58AClNgH+z7Ik9be?=
 =?us-ascii?Q?pSOfc+DIPFw0wVdLLGtOup60QdEephIiuFCnXoZOOb9Js2FnLcJlffDKvZJK?=
 =?us-ascii?Q?mFZFSOQZUeqvFPxzCuFErPOtraRO3x34PkIkW4p1RkDzBIpRkXvYHKkhX40L?=
 =?us-ascii?Q?svbGC9hc50aBGsMq3j3meBDWWjEu7e3qKtOM5xW2NWJ1IOJiLz2qf5/HN53E?=
 =?us-ascii?Q?1/jdQYns6/CnWomimqO0BBgkvXUdzKTA/lxT7l5VWDtFhDhT3ZjV8gdwv5Fa?=
 =?us-ascii?Q?/ghfHo+sumR6OfFK2M05i6QRnZXU1aqn3UEtrErMTcLkzQE4npJrnQagwq82?=
 =?us-ascii?Q?yVOOSE1tjHocShShYuiUo1rW+pHo/Y5KXA+xHT62Q1W/YFiHvAqi+YZ2agmi?=
 =?us-ascii?Q?Chb7OtLus5nPn1qylMkfVXCc7Cr8+4FB94R1bdf9+XreiLEtv1W5iUd+rbHZ?=
 =?us-ascii?Q?rB0W6sXiWbx8C/vU5Kiu9j/no+Iw5QAm2Z0babpUdFV+BG9cLEbgMMiD8u6/?=
 =?us-ascii?Q?h8zF/964NJbIzX6DxsLWfOaOB+PVrPaWvj21dBF9dePRGKnXb1yZnk49SmDs?=
 =?us-ascii?Q?whxmPOMzvdg0z9K16Gag6L+1OlJkZ0Fz6993Ov7u0Kz6zyaens//x115Lv6l?=
 =?us-ascii?Q?tY3x0B4MlRY6FQ143pioIee82NFc5Aeau4OkBwQWeThW0BlGRexYukvRxvRd?=
 =?us-ascii?Q?jTrF/BmlZRNai/oar2my9Fuiflz5FAmTx3o2QJvPR3wEOd8VWs7u4bM+VHs/?=
 =?us-ascii?Q?JbHrk+jVl5i/z8Vp0edSCplWKJLnAkn22tIjb5VYdyE4dHXz1VqwxBzqN0uy?=
 =?us-ascii?Q?0fZM2ozWaE5C/Fz2fcOoSlmxe2pJHrLDh7UiC6YZSjDorAKtFBnK+WMdq8f3?=
 =?us-ascii?Q?8Wot14u7bgAjmccXyKmrZL5UkuR9t9QXVVSpb/BkP9C9SMlOaROZiCR0Za3y?=
 =?us-ascii?Q?eDwe5VlQFpFe681aCFa0nFkFl0xj93XvWCUz5lyJRy1wPCKY7/YRteNr6xQG?=
 =?us-ascii?Q?MAKv4yE+im1VqgxZjvtGCzBUFDz7GKQmnpS0IZviS2SqYEtvTu33x7FPo5Am?=
 =?us-ascii?Q?Q7fCema+B/JpdwIkh8D+yzlA2qhIkvV/AyUxYQAHcoXsTVJEdCEgkklPHdZr?=
 =?us-ascii?Q?ms0VK6pxxHWh+LwI+ROQ5BLlvWich3D+0v0VEFdWFPHGDS8O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ab059-dd3c-46c0-2f52-08dec501d815
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 02:01:24.4014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLEfzsV5CkKzs0pcXx11clViapRh8ZKq1bEGHuurQKnEN41SWkg/ijvga+8Uk4NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Public

Regards,
      Prike

> -----Original Message-----
> From: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> Sent: Saturday, June 6, 2026 2:26 AM
> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: allocate lockdep mutex on the heap to fi=
x stack
> overflow
>
>
> On 2026-06-05 05:13, Prike Liang wrote:
> > Replace the stack-allocated amdgpu_lockdep mutex with a heap
> > allocation via kmalloc to fix a stack overflow caused by the large stru=
ct size.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 93
> > ++++++++++-----------  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h |
> > 12 +++
> >  2 files changed, 55 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > index d5d71fd7c70d..c13bfaa3dfa7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> > @@ -13,6 +13,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_reset.h"
> > +#include "amdgpu_lockdep.h"
> >
> >  #ifdef CONFIG_LOCKDEP
> >
> > @@ -84,72 +85,65 @@ void amdgpu_lockdep_set_class(struct amdgpu_device
> > *adev)  int amdgpu_lockdep_init(void)  {
> >     struct amdgpu_reset_domain *reset_domain =3D NULL;
> > -   struct amdgpu_reset_control reset_ctl;
> > -   struct mutex userq_sch_mutex;
> > -   struct mutex userq_mutex;
> > -   struct mutex notifier_lock;
> > -   struct mutex vram_lock;
> > -   struct mutex srbm_mutex;
> > -   struct mutex grbm_idx_mutex;
> > -   spinlock_t mmio_idx_lock;
> > +   struct amdgpu_lockdep_dummy_locks *locks;
> >     unsigned long flags;
> >
> > +   locks =3D kzalloc(sizeof(*locks), GFP_KERNEL);
> > +   if (!locks)
> > +           return -ENOMEM;
> > +
> >     /*
> >      * Initialize dummy reset domain
> >      */
> >     reset_domain =3D amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
> >                                                     "lockdep_test");
> > -   if (!reset_domain)
> > +   if (!reset_domain) {
> > +           kfree(locks);
> >             return -ENOMEM;
> > -
> > +   }
> >     /* Initialize dummy locks */
> > -   mutex_init(&userq_sch_mutex);
> > -   mutex_init(&userq_mutex);
> > -   mutex_init(&notifier_lock);
> > -   mutex_init(&vram_lock);
> > -   mutex_init(&reset_ctl.reset_lock);
> > -   mutex_init(&srbm_mutex);
> > -   mutex_init(&grbm_idx_mutex);
> > -   spin_lock_init(&mmio_idx_lock);
> > +   mutex_init(&locks->userq_sch_mutex);
> > +   mutex_init(&locks->userq_mutex);
> > +   mutex_init(&locks->notifier_lock);
> > +   mutex_init(&locks->vram_lock);
> > +   mutex_init(&locks->reset_lock);
> > +   mutex_init(&locks->srbm_mutex);
> > +   mutex_init(&locks->grbm_idx_mutex);
> > +   spin_lock_init(&locks->mmio_idx_lock);
> >
> >     /*
> >      * Associate dummy locks with the same class keys used for real
> >      * driver locks. This ensures lockdep connects the ordering learned
> >      * here with the actual locks used at runtime.
> >      */
> > -   lockdep_set_class(&userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
> > -   lockdep_set_class(&userq_mutex, &amdgpu_userq_mutex_key);
> > -   lockdep_set_class(&notifier_lock, &amdgpu_notifier_lock_key);
> > -   lockdep_set_class(&vram_lock, &amdgpu_vram_lock_key);
> > +   lockdep_set_class(&locks->userq_sch_mutex,
> &amdgpu_userq_sch_mutex_key);
> > +   lockdep_set_class(&locks->userq_mutex, &amdgpu_userq_mutex_key);
> > +   lockdep_set_class(&locks->notifier_lock, &amdgpu_notifier_lock_key)=
;
> > +   lockdep_set_class(&locks->vram_lock, &amdgpu_vram_lock_key);
> >     lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
> > -   lockdep_set_class(&reset_ctl.reset_lock, &amdgpu_reset_lock_key);
> > -   lockdep_set_class(&srbm_mutex, &amdgpu_srbm_lock_key);
> > -   lockdep_set_class(&grbm_idx_mutex, &amdgpu_grbm_lock_key);
> > -   lockdep_set_class(&mmio_idx_lock, &amdgpu_mmio_lock_key);
> > -
> > +   lockdep_set_class(&locks->reset_lock, &amdgpu_reset_lock_key);
> > +   lockdep_set_class(&locks->srbm_mutex, &amdgpu_srbm_lock_key);
> > +   lockdep_set_class(&locks->grbm_idx_mutex, &amdgpu_grbm_lock_key);
> > +   lockdep_set_class(&locks->mmio_idx_lock, &amdgpu_mmio_lock_key);
> >     /*
> >      * Take locks in the correct order to train lockdep.
> >      * This establishes the dependency chain.
> >      */
> >
> >     /* Level 1: Global userq scheduler mutex (outermost) */
> > -   mutex_lock(&userq_sch_mutex);
> > +   mutex_lock(&locks->userq_sch_mutex);
> >
> >     /* Level 2: Per-context userq mutex */
> > -   mutex_lock(&userq_mutex);
> > -
> > +   mutex_lock(&locks->userq_mutex);
> >     /* Level 3: MMU notifier lock */
> > -   mutex_lock(&notifier_lock);
> > -
> > +   mutex_lock(&locks->notifier_lock);
> >     /* Level 4: VRAM allocator lock */
> > -   mutex_lock(&vram_lock);
> > -
> > +   mutex_lock(&locks->vram_lock);
> >     /* Level 5: Reset domain semaphore */
> >     down_read(&reset_domain->sem);
> >
> >     /* Level 6: Reset control lock */
> > -   mutex_lock(&reset_ctl.reset_lock);
> > -
> > +   mutex_lock(&locks->reset_lock);
> >     /*
> >      * Mark potential memory reclaim boundary.
> >      * GPU operations might trigger memory allocation/reclaim.
> > @@ -157,36 +151,35 @@ int amdgpu_lockdep_init(void)
> >     fs_reclaim_acquire(GFP_KERNEL);
> >
> >     /* Level 7: SRBM register access */
> > -   mutex_lock(&srbm_mutex);
> > -
> > +   mutex_lock(&locks->srbm_mutex);
> >     /* Level 8: GRBM index access */
> > -   mutex_lock(&grbm_idx_mutex);
> > +   mutex_lock(&locks->grbm_idx_mutex);
> >
> >     /* Level 9: MMIO index access (innermost lock, spinlock) */
> > -   spin_lock_irqsave(&mmio_idx_lock, flags);
> > -
> > +   spin_lock_irqsave(&locks->mmio_idx_lock, flags);
> >     /*
> >      * All locks acquired in order.
> >      * Lockdep has now learned the valid dependency chain.
> >      */
> >
> >     /* Release in reverse order */
> > -   spin_unlock_irqrestore(&mmio_idx_lock, flags);
> > -   mutex_unlock(&grbm_idx_mutex);
> > -   mutex_unlock(&srbm_mutex);
> > -
> > +   spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
> > +   mutex_unlock(&locks->grbm_idx_mutex);
> > +   mutex_unlock(&locks->srbm_mutex);
> >     fs_reclaim_release(GFP_KERNEL);
> >
> > -   mutex_unlock(&reset_ctl.reset_lock);
> > +   mutex_unlock(&locks->reset_lock);
> >     up_read(&reset_domain->sem);
> > -   mutex_unlock(&vram_lock);
> > -   mutex_unlock(&notifier_lock);
> > -   mutex_unlock(&userq_mutex);
> > -   mutex_unlock(&userq_sch_mutex);
> > +
> > +   mutex_unlock(&locks->vram_lock);
> > +   mutex_unlock(&locks->notifier_lock);
> > +   mutex_unlock(&locks->userq_mutex);
> > +   mutex_unlock(&locks->userq_sch_mutex);
> >
> >     /* Cleanup */
> >     amdgpu_reset_put_reset_domain(reset_domain);
> >
> > +   kfree(locks);
> >     pr_info("AMDGPU: Lockdep annotations initialized (9 lock
> > levels)\n");
> >
> >     return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> > index 04adb58665bf..8bff09bd2dbb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> > @@ -9,9 +9,21 @@
> >  #define __AMDGPU_LOCKDEP_H__
> >
> >  #include <linux/lockdep.h>
> > +#include <linux/mutex.h>
> >
> >  struct amdgpu_device;
> >
> Hi Prike,
>
> Thanks for the fix -- the heap allocation approach is correct and address=
es the stack
> overflow cleanly.
>
> One minor suggestion: could we move struct amdgpu_lockdep_dummy_locks fro=
m
> the header into amdgpu_lockdep.c (inside the #ifdef CONFIG_LOCKDEP block)=
?
> Since it is only used locally in amdgpu_lockdep_init(), keeping it in the=
 .c file avoids
> exposing implementation details in the header interface.

Sure, will push with this update.

> With that change:
>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> > +struct amdgpu_lockdep_dummy_locks {
> > +   struct mutex reset_lock;
> > +   struct mutex userq_sch_mutex;
> > +   struct mutex userq_mutex;
> > +   struct mutex notifier_lock;
> > +   struct mutex vram_lock;
> > +   struct mutex srbm_mutex;
> > +   struct mutex grbm_idx_mutex;
> > +   spinlock_t mmio_idx_lock;
> > +};
> > +
> >  #ifdef CONFIG_LOCKDEP
> >
> >  /**
