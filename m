Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A72C27C7B
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 22:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2218C10E2B2;
	Fri, 14 Jun 2024 22:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNy04wNX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC45010E2B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 22:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqJH/eeVVRHgpg1NJrBHtiZG0ez4EUkRt/q5VaGgx+QgRTqG4sMNECPqcBzkV+zO+CaFrWMwrOL9qne1b5YwMVnXL26PUjw/7sIFYwZEEH99ZrLgSSde16kSWK5+Iba6Tb9UIV2rQUhODBsyopShRHsUxdtnLENEwBSk1KQkg360jYgxLTPAxQH47UnunNAo7cUX4W4sqZxJPVTAvRJk0WrJa89mNeu49/1U9LoI6b7f56VyXqUpIy+TMJpdKGiQGTeo1NwuwCD2virQ3SiNfbXrVn/FbYu0bhQEM1UnYiC0m5K06sbOXkXXu7UTH0pS2iEt5H5ZemqsGaZp+WjjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTl17j3GGoQIp1ha+y6/BwieOPleuU9HY90/y0gltzs=;
 b=KzgFzkS5SPcmgBqqHgybF/U9ayLU+HEpI/BEW14GeFfBLmNQnkb0XdcmnPEDGFCqRHJs8JD/6koSV7CguckY57To+8rYOmBb9cvLq3PGDzKmI94QL6/GIZpffpM/KZaytBCSHeypIYrBrwEe14KabTrHgCMOptppXiJUo0e6HkHsec/NHD0JnzAXwlfwfSvF20D02gp4jXfzWdY+MMsLDNSV7jgBmajv0iTLzxmM2vNHx5R7vb7pBVIeOFM84zuH5MbKX+sj13b8tiyHuBKepOvW7ji+h+km6sbak6tWWOQmVC759mw/vmOVlsKHynPnowPpSHLF3w7PGoq466XRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTl17j3GGoQIp1ha+y6/BwieOPleuU9HY90/y0gltzs=;
 b=NNy04wNXxgd0K8Oygkd/g/+tfbC3MTH6JdFdHxGFvqv1Pao2HjHxmHqKtHhhICX2cwiLVx0B6VfD/oMhZk+WZoBwGS5goJG6HuTt6yPQFPnX0qkS3D0JnvpYe9UhIiOel5j5uAalHAtiilOflL89sl6KNp9sfkLDDi7/rH51AMk=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 22:32:28 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%3]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 22:32:28 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: remove amdgpu_mes_fence_wait_polling()
Thread-Topic: [PATCH 3/3] drm/amdgpu: remove amdgpu_mes_fence_wait_polling()
Thread-Index: AQHatfmAmV1csNse50KAjDux+wFY37HH6WZg
Date: Fri, 14 Jun 2024 22:32:28 +0000
Message-ID: <BL3PR12MB642516BDA65837A8913ED558EEC22@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240603210300.31057-1-alexander.deucher@amd.com>
 <20240603210300.31057-3-alexander.deucher@amd.com>
In-Reply-To: <20240603210300.31057-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d6aca52f-7668-48d4-9f44-0d8e02001527;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-14T22:32:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DS0PR12MB7728:EE_
x-ms-office365-filtering-correlation-id: ba5f435c-9709-4e2c-9feb-08dc8cc1df3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?c1RMrq5JGGAr906rQPg1XDs2cTlDs1Uj6gZNH/t1ATE1NqmyGG2QXJs32sqN?=
 =?us-ascii?Q?9BykrraHp50inOHrS0MZuZ8DtyRrv8HglQFxjg69VWgJSaiTBKguduUMDhdq?=
 =?us-ascii?Q?HL5lV66p1cMWvUbTnTmDoQ1WPoR7//09V6EOKvnkK7hj7BGzyXhhIs6weGut?=
 =?us-ascii?Q?mjVtgn1BkkOyf+NeE1rKu2s++7z+KmuNAo2boPMOQ8ZSB05iVLC8Mqb/DwvZ?=
 =?us-ascii?Q?1+LgpdDeH6JKpNzWFJXX72As2bVadnJx48b6VuZ1PuYymI2SYU8m+pPa1h5N?=
 =?us-ascii?Q?yEpdRZmQmTFem+3gTaJ6NB8qcLlUS1u+4Fo3liQ0ZaEe4LvnAY+NyjN4V2oM?=
 =?us-ascii?Q?6gC6QxB2U9DqN4qv1DJwhBLOG+P4xqfpnO70GGHjZX/YGujCYjxej6uerYgZ?=
 =?us-ascii?Q?HJqFq0on/EfHktymZQVn/AmbfZhH1FpPtliWafaY1mnCItMPq9scLF9gq1he?=
 =?us-ascii?Q?2DAdbQVh8Trc/jUx94YPxbgZZJGo4Sl/5b2tzNjtvXM4XLRnFS7WWGqK8CvG?=
 =?us-ascii?Q?DoqV57w272M6JGIE7JHN8VYM01LplxVCdryXnxJku+TGIfr6JJLOaltV+gd2?=
 =?us-ascii?Q?GraOtMFAdDS0JQm29TgwUQZDKw8f0QJETWphkQ1QUFrW9Ni/mr+A7KcelytF?=
 =?us-ascii?Q?HqTnmFpFeEaKcGjnrPklQDUAhCQiD5o9rFA/FAvPL0QH0iGado6HxlMCS1o6?=
 =?us-ascii?Q?GjjKm0LegiLAS1j/u+we1iCO5B+Tb4RU7sPfd7ki7Uo5dw+Tzwcrsir+MB0X?=
 =?us-ascii?Q?XTMBbhBBI0yNXB7IsNNUuza/fzPmcKp1QSiBrrfBLQPJw/3a6fxI22WtypCI?=
 =?us-ascii?Q?IxbQrPCujHl2vwd2qDPHa5PARtZAkHrpqZsIwHWWsmnqARe23B2R89SVo43B?=
 =?us-ascii?Q?ssLW+XcoH9HJ/nNeQyvSD7Ah0WnGkfkIN0FX7o2P1Pc+g6oXfZdAI+oua3vZ?=
 =?us-ascii?Q?YeOegzFn//DTsyPCsfBqjE85WrrOaHuBMVXQrl+Sl6t7QTK619RoheBCNURN?=
 =?us-ascii?Q?0fjRH8bRh1Qyl6risAqNdhETnvM5FjBG7pc6GWInltBYtX/BGuKRDfInPbNg?=
 =?us-ascii?Q?vwtL/g1M9uNn8/i7LuF68T6s9JNPi8/AFAwAKbqq7/2D0FmN7YcL6HLwOsox?=
 =?us-ascii?Q?4DTWs9shxi0OkiEsRCTxrQoFGGP+nDfYSlrykMiJM4YEHnVftgXMr/bUupRI?=
 =?us-ascii?Q?RqaxVyKuMWwpL6BzXIlDdbkS89G8W0oiAnBd+OobCzqMAojDNcIpxt5Yrm3U?=
 =?us-ascii?Q?Y+yF0Dlt4T1VS6Hsz+vXLv/Lno0EOARkUyOG5/hooB1x/mhMlqDugzF8i6OE?=
 =?us-ascii?Q?b+kBdEyDdzEiXnAXPzALJeJj/8s1LlCPBC0twWXAYleV33OSYtbWy3HoMByn?=
 =?us-ascii?Q?w3BOKVM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HfPcH8LTwQN2PNkHz1rdOR4ZydedyluqgAZcHPJaRV2qnQ9wKPZ2ajngNJXm?=
 =?us-ascii?Q?houNh/fu7PbFfPfbviwAOcntRZ5zTio2jQuGzYOJ59/wPC1hX9v8iuz0DMOQ?=
 =?us-ascii?Q?Mzk2uFkUCaK34auQRXJ0bwxBK/gsS3LBeFJAyJyoaX97UOFtuhwZphx7HwXz?=
 =?us-ascii?Q?gsycyTbJ3cX0gFl5/M0TYB0oCo3TUMogNy65O5m/WBUdaWsGQTKopYmL2CkP?=
 =?us-ascii?Q?ndAflXWyWbND1j370rqt4ip5ZJOz3cctWuduXQaqOHu9/eHtduiaj7GD4tmE?=
 =?us-ascii?Q?dVq/7Y1Ceae/Pr3YKvQnzlZcVdFriAGTlOMxyJea64E1/yauYl2/fFp7No78?=
 =?us-ascii?Q?OdcsExHOrAR5rwHnzXKBNWIQCrBy7yciltw2f1QyjDw/1KZwOGD+pMZIEJQT?=
 =?us-ascii?Q?1fK3LQ5BZxIOMuaZunQH8qGK+9sOYVJ2p16Gd/XAihJjU+prYJ5foRB6f3fU?=
 =?us-ascii?Q?zroeRbN9Qqx2xE0rBaQtVYI0SOkgoJ3V5HvNBEyCjPLusWIqVlTB3g/pNyZj?=
 =?us-ascii?Q?uxY1QDlZaC+SgjwbMvzBm4a/UQVMK9JV9XWtylNuGnA5NSNB1+nLsz1mQDsV?=
 =?us-ascii?Q?aUmwmKUK4w8mYdSNTpWaV0Oz8uKeNxuwmo8jBFAsVvYLKepBqsoKwHPlk/a4?=
 =?us-ascii?Q?DebHQe1Qa5S9Uem0ZreqjV/s+lQRr49IUnBPnN66zsRYfJalwhOrWtMHr9QL?=
 =?us-ascii?Q?v6i+IB6j3TZCCu2cGmwy2jxSFT++Airdikx7Wt89E5gGiahcoLy7P/HIzyX9?=
 =?us-ascii?Q?8N3vgMKN1CN0h4ep2gI0mcBo+xPX71l+b9ZaEKQFwdCUxB/rV92isKREK8+8?=
 =?us-ascii?Q?lhAT55zEfzDAzz/mX7fuusGFYlP93URuK1ptQPcMtedBibGcbb2ujFk2yiNc?=
 =?us-ascii?Q?01F2bWc4OtXbH8ivONRnsV29066DiA5ug1ZyYvo3AAZHBecp5pXwtvE5gqF4?=
 =?us-ascii?Q?IBb1dLXqcs66PfX8bRJHV9//JDfIL1pcXqLhD1K7s8djDFFeVKDItOnj2iAy?=
 =?us-ascii?Q?9unrvzvZsO3W7PR1AiKiscltVFPnoVT3ZfTUNuvOcD6iObowGUaC+U0eA9Vv?=
 =?us-ascii?Q?i5ATh+h1nma44laAyNXaCN6hIHvnnqHWYJHXA4IfB0Kl8jXmAq7Zm7mKaMqf?=
 =?us-ascii?Q?BXhOt9nE5hLKbFSXbqJbNsFjfARWP2f6BgzsbSWk0voTPfBlkARwbWI8u3Yh?=
 =?us-ascii?Q?TcxgLTcErSvVLsRml1l/8k4EhWwmZ/BYRbWaIKVjDAUgGEiY6YkFnpB/hATQ?=
 =?us-ascii?Q?MWUC0tL06tgr3sLbdKqotERx+Y/kNd3ZiLAzcZm7+j/uYAHULI996n9IrkM+?=
 =?us-ascii?Q?6JjPVq/fabVyN59MslNyi71Zmn4HM5W2wwDxtvcwjd9b7OVnBi6FHxvlmXXQ?=
 =?us-ascii?Q?1BG8sxag+P4c6LghfnoHWRRfMDBi2UP5U/uxj7RJvGGDKLfo55AQpULryRGg?=
 =?us-ascii?Q?kDf6rl1Ukl5GaRnNZFQI9t+LHOylPjD5Fy0eFHsYaHE0jeE0P9chSM5F43Q5?=
 =?us-ascii?Q?4LNCxeMuH/07yxzzYdYD6RTAG8QrUPaNWCJqaBNf/YCrstCbS+mvXQOHIy1u?=
 =?us-ascii?Q?RRLL6Iqqo2mwLkDjMu8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5f435c-9709-4e2c-9feb-08dc8cc1df3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 22:32:28.1217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQg64Bsa99NnD4Bq8ahFIhgvRGwqh9shcPKB0JHhm1ZpzhZaIb/XIRcA/t7ZqHvdzeo6gNRH7kJ09cistuTv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is:
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Monday, June 3, 2024 5:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: remove
> amdgpu_mes_fence_wait_polling()
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> No longer used so remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ------------
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ----
>  2 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 62edf6328566..e0c36e0d7beb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -32,18 +32,6 @@
>  #define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
> #define AMDGPU_ONE_DOORBELL_SIZE 8
>
> -signed long amdgpu_mes_fence_wait_polling(u64 *fence,
> -                                         u64 wait_seq,
> -                                         signed long timeout)
> -{
> -
> -       while ((s64)(wait_seq - *fence) > 0 && timeout > 0) {
> -               udelay(2);
> -               timeout -=3D 2;
> -       }
> -       return timeout > 0 ? timeout : 0;
> -}
> -
>  int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)  {
>         return roundup(AMDGPU_ONE_DOORBELL_SIZE * diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index df9f0404d842..e11051271f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -352,10 +352,6 @@ struct amdgpu_mes_funcs {  #define
> amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))  #define
> amdgpu_mes_kiq_hw_fini(adev) (adev)->mes.kiq_hw_fini((adev))
>
> -signed long amdgpu_mes_fence_wait_polling(u64 *fence,
> -                                         u64 wait_seq,
> -                                         signed long timeout);
> -
>  int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *ring, unsigned int
> id_offs);
>
>  int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
> --
> 2.45.1

