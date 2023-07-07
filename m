Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16E9EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 14:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4866E10E00B;
	Fri,  7 Jul 2023 14:49:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE9310E00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 14:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9LOel1MWzCtuEJhm9+n0baZiNv84sAw4dlVHxBJh6Tk2rmhXAZZtscGNeYDDVJgIpJekzn/m2nENl7dWy0X3BAFOB8GrlXYAKmpxUa8fcRpFDJ6i74xq9LzfdB7JrGCEzFvmHa+bAlD1D1f3nW5kZoYwq7CCXT+9zG8mE3TdJpeyjBbuqT4BSU0DGlQBhKWQzE7Dxiot4OJG3LziwLPdqSSLUK2miYYN2g4iCidDisxE01Fw46pqLcHd9sm+2ppFXqlJPx0ZERRPk+g3TnlaMMTVaiGgpxGWsb7RONiAio66RwfL3sYbn8LfJMN2pz1wqDr2QPY0sBCdMuhYLHR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbiPXrD1cZ8Q027PM3cqSOIrFvcDJ8ibC2VScR6PsyE=;
 b=RoU6GVFjK7vGONiDF3nxjlJaCcCsjQEtOYYQvwt1YevC6hyitLMVlSXTNnNpf03uLAMA85de1i46zBytu5NI8WmUcZZ0prbpqwu1EE5wQB89t33EumpkgyYj00IPwrKI7D7aw+mxTxhJeaeA2SiNr3V+hMzm9L4CghRQdJLQaT6Ilq4XNiwCgXj+pZEYXj2HokeJUx1a5CC99dmERDzaZZmnIQ8zGGRq1KaoYukppQDb5Fr/9DmbY4F8P2Ffa/S7ukUURpqMi86BYVNVC4GJOYXlq/PR/LxaCr57NRibd+dVgeT1tMJmeKlAgFr9gFlF9cI8O80986A7oqPPUCd2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbiPXrD1cZ8Q027PM3cqSOIrFvcDJ8ibC2VScR6PsyE=;
 b=HyoRt5aAH5OEmqg4XDbBLEODr215ML7i4eYPJ58PykaySKN0i35lmTS8Trwg+TyaDAQYSWN3EKng+RyJVIsjWLwXFWgX3M4ij6KrzA9QJt4C74d9C+yUeWbsRWnfk2X2S6SFdMNrBesWdPUtM7s8MQRzxQY7IThvT/aGxjQRNCM=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:49:13 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::f135:615c:ba53:17f4%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 14:49:13 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase IH soft ring size
Thread-Topic: [PATCH] drm/amdgpu: Increase IH soft ring size
Thread-Index: AQHZsN1+4Y/7lCB+PECjJrfCe+f5iq+uYdew
Date: Fri, 7 Jul 2023 14:49:13 +0000
Message-ID: <BL3PR12MB6425DC012090F3564CDDCD91EE2DA@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20230707141452.10908-1-Philip.Yang@amd.com>
In-Reply-To: <20230707141452.10908-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c44a5c1a-7787-4ced-aa2c-5ca5727a7605;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-07T14:46:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ1PR12MB6217:EE_
x-ms-office365-filtering-correlation-id: 954d766f-6f56-461a-d65a-08db7ef95497
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hkFnIiJnJM/YbO3JK8WKhskvV+kcXLVEXUm7aKFIXrquHJp55GDyNuoH6Cj/qg6oIgosTibcjVbxCHKvlWhHKTke4pSjS60Gg4mOHlbf7Q/3ijyEXuQ5Uxdh107qdKjoJzfYHa8mpsi3QUshnuffC2U3yHRjjoCWjmzvGQ//NZgYSXA3OVasdoHar1+ikIP+Yp/37D/CnRL4qED8/jzIv782wE3D0HwdYvjgIrNORfLm0l7ijqejwLNeOegrzVt558GZEqYL0BgKeSTvIRqmQKkKwp2x9V32hJBUg9+x5b8Vkysu3yUs3B9aIvvBX9hIxThRljnEDhW5GgJuWhIqOUoysdpDE1oHp4wdQcdcux7a+mUTNiQYdmnZB4PY/IjUn3r6dFhSNFieLNAha3gN0cDXw9I5Y0lSlI257/8ot1TwTPFWMJbT6bdS7gG37BugaFQQA6eoo8kyFHZiZT7yv/L3VQK/GeqOdQTr/JrpAzT4sMGcGuty6vTAOONIQVawiCxXCymrx1Oa3EAYtvdk0taqoJs2NXjn10yxyja/33dCBWqlQ54w33PbXGNtiDR59583I6EBShPtU/Q2L/Qa5VYnoLPNr7DQEW8tiZVhd0lZi182o/pERTQe9mEd5NYA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(8936002)(8676002)(478600001)(9686003)(52536014)(5660300002)(41300700001)(66476007)(2906002)(316002)(64756008)(66446008)(66556008)(4326008)(76116006)(66946007)(110136005)(71200400001)(7696005)(26005)(6506007)(186003)(53546011)(122000001)(83380400001)(33656002)(86362001)(55016003)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?laDEikVnq7m+RnTIOHKwfrTzEjp3wN7OlNzu84JrejDTJ9XVIzUn+7mP7O5b?=
 =?us-ascii?Q?YFu4Qw84c7M/fbgWFOzNGZ+HJSPWU1D9fXNeEZ75wYDPGmSKc0K3MSQAe8ro?=
 =?us-ascii?Q?616PsxUtsHuHctXMMtlWY6LTOxaMuOYwynPPVTBlBbF6f3zKFqBbnjeviX2p?=
 =?us-ascii?Q?IJZijeDlCQViZpY69oDSgn/v8c6pj9ZNyXbW8qR7ASMnbMrr26+COYH0vKAn?=
 =?us-ascii?Q?kbWyWI23tpINA9TzEVszAdduE4Hn3zsKK0Vv+BYr57ChpHcho+lrCpNAcI4q?=
 =?us-ascii?Q?I7GgwqMmFC79jbx9Va9HhpGpD+43nYqBkR3vyCE8dagWQ3mL4L17oDZxBIc7?=
 =?us-ascii?Q?2DJz9HMeDJjtLP05+oo1YV7X1uKy7HVsnzY6t+dn4H0ApmO+UgJ7Nq7km9bt?=
 =?us-ascii?Q?EwbndcTJRgMqvecxJeUpTnbEpStg/kaokD6vh9KTiWUZ5Hm130+jJ3cPhs0U?=
 =?us-ascii?Q?vlStM+YTbDTsYeZ6v/GYudFnklorXSeWKX8QWVbJ3gIyswi0JBfoNX8XpVQD?=
 =?us-ascii?Q?TdEh7+rvkPpHCxefoKh9mjTVfL8KYFtWCQ26Up45mSPUxfnqjOg1uuDWFb7P?=
 =?us-ascii?Q?4k8vcUOiDdyoPZpYPV7yex2W4W2AMl2dnr52V7HDalRR8trp440NQgXUaY4i?=
 =?us-ascii?Q?aNEHIXpi0MjJdRd4I5NK5YJ0Z45bp6WgtAk3vzBThH3QMnEiJ4HrJBx91WiY?=
 =?us-ascii?Q?NKei+LssEo2MY/TyYGaJmkzyO8hshXt+h2WoZiYD94yCxtxaPRbVC+QNUbdG?=
 =?us-ascii?Q?+Nxb1dI+TU2BCdxYUNIT7R17rmigtNtmS1WOiHgSpOERzWl2trRPMna5Lxys?=
 =?us-ascii?Q?8rKrZUM5uNqZpFoLSBbV0GHGqwNdsQQmOfFLvI5vBvNTqJKR2odqJkGK263j?=
 =?us-ascii?Q?tahRiMRZ04n81GhiFFtEPx43AoCJV5BqnlpD0aIy9ABKFe2FpCEaz9hquLpV?=
 =?us-ascii?Q?h0wh0oDSz06AEPgEj+guy4oJZdVKLKVqlpAupXZUOPvwHBj7JceU1bK76L7u?=
 =?us-ascii?Q?zLkgJjUjrVbJCamsgUzHsg+eqyn47m8OyK8g0tzXEwLqnuun6mkeLPb4t0CE?=
 =?us-ascii?Q?bGv/nZrDFehCOS6woC4ofLAHHgFgWtV5GJzXFche04RqZlk5sq5kajwSw2S1?=
 =?us-ascii?Q?QKa113nR8C2jvueBGHN/sYZh4ynJnvpVjy6PQL+E1O5HOhfqBwRxld6yCoAi?=
 =?us-ascii?Q?U1thpOqTLcy1X/D//Em5ArJt8nAJb6maWKGTGhMDC3lWodxM5JaRVy33VVId?=
 =?us-ascii?Q?0KKgolN28I9iNX1weG762vVTvZFVZVuMxmHCzUzV660D/EBq0MsAbgeS1YQk?=
 =?us-ascii?Q?CaABpOeRqNnp4B9sXhh5d+6IILH2lwbW2gRv/OwUO0uUORVI5ZkRrKutLr7d?=
 =?us-ascii?Q?Q+IhpvErEqvi0mMCEA1lMyKFK2xD0IELnOayhuHfQumaIUWr6c3aCraaVnZs?=
 =?us-ascii?Q?eAqZOZqB9NYw5Q20zBsuLN4kVCkt1iadVmNFRl7sGLy3cjH+sxI15BU6Hft/?=
 =?us-ascii?Q?yVywnhN8+8oJfva4r9c0kpt7iD12YbUknQcRS5S4vCj23rsu43Yn4FsgehCs?=
 =?us-ascii?Q?/N6vaVDTqmBbYqDLgIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954d766f-6f56-461a-d65a-08db7ef95497
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 14:49:13.4032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVk9hWpjNOjrCXEe5A+XV+TJJZ788m1mCFjaSei9A2k78HK0r6+9QD35bbEFWoPLTLZpAWdFxlu5i6xlgWFIEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Friday, July 7, 2023 10:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul
> <Mukul.Joshi@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: [PATCH] drm/amdgpu: Increase IH soft ring size
>
> Retry faults are delegated to IH soft ring and then processed by deferred
> worker. Current IH soft ring size PAGE_SIZE can store 128 entries, which =
may
> overflow and drop retry faults, causes HW stucks because the retry fault =
is not
> recovered.
>
> Increase IH soft ring size to the same size as IH ring, define macro
> IH_RING_SIZE to remove duplicate constant.
>
> Show warning message if IH soft ring overflows because this should not
> happen any more.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 4 ++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 5 +++--
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 5 +++--
> drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 5 +++--
> drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 5 +++--
>  7 files changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> index fceb3b384955..51a0dbd2358a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
> @@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device
> *adev, struct amdgpu_ih_ring *ih)
>  /**
>   * amdgpu_ih_ring_write - write IV to the ring buffer
>   *
> + * @adev: amdgpu_device pointer
>   * @ih: ih ring to write to
>   * @iv: the iv to write
>   * @num_dw: size of the iv in dw
> @@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device
> *adev, struct amdgpu_ih_ring *ih)
>   * Writes an IV to the ring buffer using the CPU and increment the wptr.
>   * Used for testing and delegating IVs to a software ring.
>   */
> -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
> -                       unsigned int num_dw)
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct
> amdgpu_ih_ring *ih,
> +                       const uint32_t *iv, unsigned int num_dw)
>  {
>       uint32_t wptr =3D le32_to_cpu(*ih->wptr_cpu) >> 2;
>       unsigned int i;
> @@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring
> *ih, const uint32_t *iv,
>       if (wptr !=3D READ_ONCE(ih->rptr)) {
>               wmb();
>               WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
> +     } else {
> +             dev_warn(adev->dev, "IH soft ring buffer overflow 0x%X,
> 0x%X\n",
> +                      wptr, ih->rptr);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> index dd1c2eded6b9..a8cf67f1f011 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> @@ -97,8 +97,8 @@ struct amdgpu_ih_funcs {  int
> amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih=
,
>                       unsigned ring_size, bool use_bus_addr);  void
> amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring
> *ih); -void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_=
t
> *iv,
> -                       unsigned int num_dw);
> +void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct
> amdgpu_ih_ring *ih,
> +                       const uint32_t *iv, unsigned int num_dw);
>  int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
>                                           struct amdgpu_ih_ring *ih);
>  int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring
> *ih); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 5273decc5753..fa6d0adcec20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device
> *adev,
>                        struct amdgpu_iv_entry *entry,
>                        unsigned int num_dw)
>  {
> -     amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
> +     amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry,
> +num_dw);
>       schedule_work(&adev->irq.ih_soft_work);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index b02e1cef78a7..21d2e57cffe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -32,6 +32,7 @@
>  #include "soc15_common.h"
>  #include "ih_v6_0.h"
>
> +#define IH_RING_SIZE (256 * 1024)

I would recommend moving IH_RING_SIZE to amdgpu_ih.h instead of duplicating=
 in the .c files.
The rest looks good to me.

Regards,
Mukul

>  #define MAX_REARM_RETRY 10
>
>  static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev); @@ =
-
> 535,7 +536,7 @@ static int ih_v6_0_sw_init(void *handle)
>        * use bus address for ih ring by psp bl */
>       use_bus_addr =3D
>               (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) ?
> false : true;
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024,
> use_bus_addr);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE,
> +use_bus_addr);
>       if (r)
>               return r;
>
> @@ -548,7 +549,7 @@ static int ih_v6_0_sw_init(void *handle)
>       /* initialize ih control register offset */
>       ih_v6_0_init_register_offset(adev);
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true=
);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE,
> true);
>       if (r)
>               return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eec13cb5bf75..df33db6fd07b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -32,6 +32,7 @@
>  #include "soc15_common.h"
>  #include "navi10_ih.h"
>
> +#define IH_RING_SIZE (256 * 1024)
>  #define MAX_REARM_RETRY 10
>
>  #define mmIH_CHICKEN_Sienna_Cichlid                 0x018d
> @@ -565,7 +566,7 @@ static int navi10_ih_sw_init(void *handle)
>               use_bus_addr =3D false;
>       else
>               use_bus_addr =3D true;
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024,
> use_bus_addr);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE,
> +use_bus_addr);
>       if (r)
>               return r;
>
> @@ -578,7 +579,7 @@ static int navi10_ih_sw_init(void *handle)
>       /* initialize ih control registers offset */
>       navi10_ih_init_register_offset(adev);
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true=
);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE,
> true);
>       if (r)
>               return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 1e83db0c5438..c9b37983a18d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -33,6 +33,7 @@
>  #include "soc15_common.h"
>  #include "vega10_ih.h"
>
> +#define IH_RING_SIZE (256 * 1024)
>  #define MAX_REARM_RETRY 10
>
>  static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev); @=
@
> -485,7 +486,7 @@ static int vega10_ih_sw_init(void *handle)
>       if (r)
>               return r;
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
>       if (r)
>               return r;
>
> @@ -510,7 +511,7 @@ static int vega10_ih_sw_init(void *handle)
>       /* initialize ih control registers offset */
>       vega10_ih_init_register_offset(adev);
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true=
);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE,
> true);
>       if (r)
>               return r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 4d719df376a7..06d4176e4c68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -33,6 +33,7 @@
>  #include "soc15_common.h"
>  #include "vega20_ih.h"
>
> +#define IH_RING_SIZE (256 * 1024)
>  #define MAX_REARM_RETRY 10
>
>  #define mmIH_CHICKEN_ALDEBARAN                       0x18d
> @@ -539,7 +540,7 @@ static int vega20_ih_sw_init(void *handle)
>           (adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2)))
>               use_bus_addr =3D false;
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024,
> use_bus_addr);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE,
> +use_bus_addr);
>       if (r)
>               return r;
>
> @@ -565,7 +566,7 @@ static int vega20_ih_sw_init(void *handle)
>       /* initialize ih control registers offset */
>       vega20_ih_init_register_offset(adev);
>
> -     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE,
> use_bus_addr);
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_RING_SIZE,
> +use_bus_addr);
>       if (r)
>               return r;
>
> --
> 2.35.1

