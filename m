Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2E9C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 06:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E8B112A64;
	Tue, 16 Apr 2024 06:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kO6VIi43";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C6D112A64
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZiObBZY6EtSaUp+9iuEx6tGSu5Yv2dCG3K3YAPRP7l7J2oHlyDQtTqLOF08fnzHeIS0qLQUHuDnnr5Ow4oU8qMGwEqoDIiJ8bkif4T/uxVXy2+waaoLKqrPk2tw4O/znQXF/Beb7Wg6AjNJ7ccqsdv/Neucusf2F9qJ0hSP2/LqfiDWOXBM9CrsuR77WNKzIEz00y8mevCEU6wlnRrznTX+m/VDKQDMfL4BzQ8XbmWt4q98Zm+jCM52mPlsi3OpxbFM0ka+b5dg1MZOeNny642NbAE+oPP+nwOpmBn3wmtDt8shGMoeliiYaaD65cHpqF0zHphBz9AXAjlkyAvbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nQlEg329MIusIg2YXzUed94r3l2RzM0wgmK6Un/CTs=;
 b=Ln19oYXV0JkL3J3vFtlkXLu8CQ2ZMMz7xAlwFAeo1n5f9kAsVpuZqVKcKhw+1MbMYIjgQCkB6hVgv/hqhQyV6jHNJVjymm6Ln+4i+v9hQvUsE3jvNJCL8gvs8AqnJ+Mky3123GcS91Jo2d+dWJQzqi7dGH7ObM5rB/qWelWVilfAzher3p6DhApGzJECTgNanvvant39JZXf2GOQN2qQv4DrUZ75iGF9/foe+LbHq4t6j4YP9rWpkuMvVda5+n2dOtN8UyLLEo91mnYjs8+vUGuy0AxP1V77L2X62kKjsEF6gn39VVlTIK+HsxeFI9ArJyR57XoDNIdRmKJKCPRjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nQlEg329MIusIg2YXzUed94r3l2RzM0wgmK6Un/CTs=;
 b=kO6VIi43I/ic/HQx6PBKYrZlHY79ykHBNx1rK2nbeZZyVFtTZr2PmNF39q6ntKzk+uyBp5Et+ncPqQbzYgB/W8ugo1QjymEwfgR8lQi4ycL7Y2kMTWcAubZi49+2hIw9AXEapuyCvM0pA9EWP2ofeuJ0P4lODbq/w2eWRApTEqY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:21:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 06:21:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Thread-Index: AQHaj8Wj5Ik91SlTC0KwJ6NCZVRqb7FqbSrg
Date: Tue, 16 Apr 2024 06:21:56 +0000
Message-ID: <PH7PR12MB8796DD7E619C143DB8CACDACB0082@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240416061625.2557-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240416061625.2557-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc878d63-0c83-4ec7-8f11-235983ddebc3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-16T06:21:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6756:EE_
x-ms-office365-filtering-correlation-id: d356161f-fb56-4e6c-6164-08dc5ddd83ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3r5GGEivjiUpdegkP+QxwLq+GPKGNmWR/CK1SRX/HgACl0I4ShieD4hFJ+TLdmozyuuYS7kkcYrT7e1MN493URPVQc4UvkBeFaxhUGWh5Bxkdj9rJAIsY+DPUf4RQPSR8a0cg//eecT7zV3QMq6vhAL2dnTIjtPt733oqICZJQWSxSKMzLPDmJdvZ+PrKAI+HKfSN0u64cjOZM6TnOY5O020P5ZxaAYsvP1AufmyODboT+1gqvWxU+kuqMunk24kHriVGIh7fp0YxspnIlv1Fhm5P3u1Ju+CcjMC5HIBaY+T7HqptJkB8GqNImeOmDSO3aHpPz68sYUqoXDVkCRZmwd1WFcjS6GnC9sILBN/WBtDTfBffODpleWAXYPI3ty9Q8GCHuLg22NdJO4hyCa6mFB+xMsB3RvR6B+MbAtP2RPTGfkmgucwG9FXd+jDwOADmZ9MGL98SZsTFH+L3DWKjqe7n6wNDzcrkYPBnrAg/tAKZv2jTEhnNfrNUtXPwBf7xi5Xkm31ctJppPC8K62uS47mSEVGqiw1EOi9INIf8NXprx52ccsM37SgLt4Q/NpSiRR95RLTkPcK3AftWjjN8VycT9vovCCu+wHY3A7poEb048sPaDAzJiKvUTORVwuRPqFR5JgRtRH7roX5L8exIluyZFzZyGyqi+Y3D6vMHTXfaL2T9wAAAtH+JeG9G7tUE503wm5TDhc2/68MSbaog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Upk5OccTNGC1Wzs8HIoDEIrPqWn2RBrmHXSArW6DHgaZ00J/uFUSjWWFH/Q6?=
 =?us-ascii?Q?0FXa5j6eaxxoLiCiJwyOCH045gvxd4I4iUNI1t0uSCC0N0fWaKeZ5C/rLMg5?=
 =?us-ascii?Q?dHhgPB6U2EmMafFih+su6LecWl4K2Ua9GWIwxLhtmj8qIl38df/5baKggte5?=
 =?us-ascii?Q?xOm5mlCkwcR2g39XIjb1wl9lR1H5R48y8T6jLVG0HwWwtREo+gLgefNO1so0?=
 =?us-ascii?Q?XSozNOnmzy843VIeuS0aaxJIojfRgRVK3VSe4y3YFxsZ44unzEi2Om7O+4Sv?=
 =?us-ascii?Q?DpvVZYuXXUZF/5fD2bXlfAvjr3xMBfMW3OvdxJfLZYgIOUXdILGK5rxRwwNp?=
 =?us-ascii?Q?oBZuEvgIegYkZYS8NI81Q4+EimCch1k0Q2qBmERrVeTNDyQQx3H/3MxDlipb?=
 =?us-ascii?Q?lCTo4ybciEKSVvOeSMmQb3ktSeHm6AnZ+WBCZ/IciD+KIh6+UqEvXzMco1yD?=
 =?us-ascii?Q?uCA7rEv4V0YJ6f9qpGSF2c/XudyH+aQ9kW6tOaF/kMwkfX4XnAITbOFMBb7A?=
 =?us-ascii?Q?RK42LGRHIvLKSEA5LsPSnRap1CebFZGN66VZxFdVqKvgwNbaXrCbdAHCb1YC?=
 =?us-ascii?Q?hUvwKls4nBM9/AFXLhiXvgXlzVh0aNAuPhT/HIQ6wJryO6QNI95vXtJMUKng?=
 =?us-ascii?Q?7GnK6SQW6QK4J/4tUhfcasoXjHtETp7iM5g2oBT+57rsmnZJKfkWrfiPQM7E?=
 =?us-ascii?Q?dEgYammbrVZ9R2iziQ5qanT6Y6WEu+6eHB+fgxh52xXiQ2l9p1Qs8vTVRSxV?=
 =?us-ascii?Q?K9CIKqgrCTlntvpjpbD2z96JmR1+jLaJQX9yMIWBvkXnVZ9V9+qx3uRSC9Vk?=
 =?us-ascii?Q?fVPck0pcyS55PFlJAEg9wJk3jMkMf7kofN1sXmng8jVkGrbW3LmOvCGYGNPA?=
 =?us-ascii?Q?UvyFhdyuKrxhCVAH3Qt66Pi85MIUDxle7weQU2S375Nk3Z6u6bRneFUuHmSk?=
 =?us-ascii?Q?seXcLXaBTztfy3704c/6+GL8PWADnUfVA37h+sOpuHGTwSO6PKp5ORC7fAqU?=
 =?us-ascii?Q?l8fv1GHpvpngDdzWa65Ap5rcJ3sQyecEynZfV/6hrCZuvPEiCpnGAteSY5FN?=
 =?us-ascii?Q?r6bKGu8/yDsbQ+ph5O4DFoeR3vVjf1fF66lfvI6tUjn2aMHy4la4Eapsnrd/?=
 =?us-ascii?Q?M9kfeC9kdOW5XJfEXjQqcMyAOyN76Jne4C4Y+tMHMZf/L1UrnEHKuvCUL6rZ?=
 =?us-ascii?Q?zAjGBgod2fxXq8WfrsatE3Ap5cziw7epDFnwCpOpSo+aioZKuORuH4nu5lzo?=
 =?us-ascii?Q?NsB4Kw0tskY/rSZFNkgb2uCs98IIMbh9TgscOFnau4iwbZB81V7shzuJqhdR?=
 =?us-ascii?Q?g80L44ehFUmmkLc28CsO/UlDPPphTVnKYKnN9MP3VxeuYtVFZBNF+e32gTuA?=
 =?us-ascii?Q?h1xy2reh1SM/prh8QrlxEgZLJAFQWZSjNdRH51YnKW42LdaPTpyzObXaNcsp?=
 =?us-ascii?Q?qVfr6aTvfxpbqjk2Qfx+UcOeziC/XCdZC+5H7phAwh4gpwfdC9NPU8lxgqni?=
 =?us-ascii?Q?EGI69tidau+pArLmeDz99zvIwII6RY4LaNmTyWBaAfSXCY5/6qCuRqn6Xy2P?=
 =?us-ascii?Q?CKSSW0MkARiFAlJUE2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d356161f-fb56-4e6c-6164-08dc5ddd83ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:21:56.1669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDxX7RiXHWGMEfncFIyNh1rExcX40F+VbZCOJ62DA6YvZlaBXmBdxOl2OLaBy2NW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, April 16, 2024 2:16 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison
>
> mode-2 reset is the only reliable method that can get GC/SDMA back when
> poison is consumed. mmhub requires
> mode-1 reset.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++-------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index c368c70df3f4a..c3beb872adf8d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -144,7 +144,7 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>                               uint16_t pasid, uint16_t client_id)  {
>       enum amdgpu_ras_block block =3D 0;
> -     int old_poison, ret =3D -EINVAL;
> +     int old_poison;
>       uint32_t reset =3D 0;
>       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
>
> @@ -163,17 +163,13 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE2SH:
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>               break;
>       case SOC15_IH_CLIENTID_SDMA0:
>       case SOC15_IH_CLIENTID_SDMA1:
> @@ -184,22 +180,15 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>               break;
>       default:
> -             break;
> +             dev_warn(dev->adev->dev,
> +                      "client %d does not support poison consumption\n",
> client_id);
> +             return;
>       }
>
>       kfd_signal_poison_consumed_event(dev, pasid);
>
> -     /* resetting queue passes, do page retirement without gpu reset
> -      * resetting queue fails, fallback to gpu reset solution
> -      */
> -     if (!ret)
> -             dev_warn(dev->adev->dev,
> -                     "RAS poison consumption, unmap queue flow
> succeeded: client id %d\n",
> -                     client_id);
> -     else
> -             dev_warn(dev->adev->dev,
> -                     "RAS poison consumption, fall back to gpu reset flo=
w:
> client id %d\n",
> -                     client_id);
> +     dev_warn(dev->adev->dev,
> +              "poison is consumed by client %d, kick off gpu reset flow\=
n",
> +client_id);
>
>       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block,
> reset);  }
> --
> 2.17.1

