Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF62C021AF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 20:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF2F10E773;
	Tue, 18 Feb 2025 20:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWcSUm11";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A29710E774
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 20:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEGMVtgCOhyGYNbh5woycOI4moJIFgMNADdSrDSXs+pF3HZU3zzrfL61coswRIzWLCfm8hXCzDpAONO+9bYVguxvOSCtojcYawSliGJVY8IdkuQErvYg0Y5J/mwfZkDEEY/sRPC6zPWxny7dByn7VfdwL8CrlOyrIVJ7kHV3zYsJ2NSct1UIVmd0rbDgh8CXgojXtu03waruf+lw5yEt1NhhKed3vKQ3sUFm5WQZVS58IFIc8S0slTQWOVL184fmqFHpfIRTOPkF3sgUbAI1F78ctxsn2YeZB+Idnww454v1UEMxbCm09FDTPrHmYkWuh9gAaOmgHCXQgHiGI3qixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4bjAMtAb5DV4CAIfETJdl890qsiw4e5VGiKJgJd8F4=;
 b=fzjTHtyYR9LkiUGWvOGF2I4Zo7+oNTlHL7d/aV5NzlwXkNKJPWpIueYiQzO2NX3ONFMm7BujUQJYNjumYWnszjATQgMS/x2R1oGz/gb3hf7B4uypCYMllUDGOpz1wltikK9wagRZPCfcae9kKaEb0hmHXz9yerpcuLr9+4zQL8ny/TIlehEp4d1ezohDkLkfVGw8mJ9yq36Sz3P17GxeI3KFdtSZDlYI9XvO5f5ehJqhwolPw5kbKewK2psibK39e5F0HPf4lCudTl0bnTz1jT2bS9QsFgK6RRvSqdoZhYDJLeui0yWRdfGvdwNBf1RVlWPhPFNM+MmBrsPoWO2aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4bjAMtAb5DV4CAIfETJdl890qsiw4e5VGiKJgJd8F4=;
 b=VWcSUm11irgBgJ0RiRTVBIraj5z6bX6HdB1EUAnPLqqXsvGSp9edEXMbdX7vF0bojkosk42rlWJiB54275hx1uONfZ/uAoE9yh0tkLbVvY4RhXt/xKpbEwiDSGmmqCOe1MiGPrH820UrHg/191GO8Qncp6VRmc173ofDicwBMyo=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 20:28:18 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 20:28:18 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Set lower queue retry timeout for gfx9
 family
Thread-Topic: [PATCH 4/4] drm/amdgpu: Set lower queue retry timeout for gfx9
 family
Thread-Index: AQHbfZoUg318NYskoEmTNcXXe3UpQrNNgd7Q
Date: Tue, 18 Feb 2025 20:28:18 +0000
Message-ID: <CY8PR12MB7435B2179E69F761749FF11685FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250212220341.373072-1-Harish.Kasiviswanathan@amd.com>
 <20250212220341.373072-4-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250212220341.373072-4-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a40cbe43-e244-409f-9ae3-1cf21a434296;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-18T20:10:19Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BN5PR12MB9485:EE_
x-ms-office365-filtering-correlation-id: 4e23cf43-19fe-4dbf-8869-08dd505ac7e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YqN6/ElsrhDKR48dUQkCHcguyT70JdQbXnDZ6KKoF97tLYVs14sBhEEQEGqp?=
 =?us-ascii?Q?pV7VBb0YpmmsvybK71qTF4jUixlomhV71C4tyWv1K/gid/DHfo4TQQ7qK1QT?=
 =?us-ascii?Q?CF1HTxoQP7AAyRdN4FFId0l0D3AJVSimhwKbdXvLhcIHPxREYvNos9pBxzkq?=
 =?us-ascii?Q?pzFxS3+payoFNXQiZAg8CmOHMoVeqARMBPCmD860Gn3A/f0c2YVw5hcJnCIe?=
 =?us-ascii?Q?BfwmtHEI75DSciUaAy8YFL5wVT4a3/rd91TIm3ZvNwOplb+56OpWt4khIzyY?=
 =?us-ascii?Q?CjJHl/GcLuqC2sY1KdYnaZ0ZUkch9Tay6E4v1uq4TVNRaIx7CZOgFYcucjtJ?=
 =?us-ascii?Q?HIfntXfK4qFKUGklZjz7l6ZMyL2vfQToD5ojTg2YhgHewqWM50g3WrdMnyVw?=
 =?us-ascii?Q?5l+IcE9wcqYLc8u2Z/fG64ECfRlQCZJzJ68GRA2RI3M5lcV+MCLaz8H9bFml?=
 =?us-ascii?Q?GUyQ5uD1/eLruioRjM/ZVHtTnjfzrU1Mva/6BS+n5TeI34elkJ7Q8t5J6qSb?=
 =?us-ascii?Q?EJzqHZGhNkTx50DYllS289OpkGX+c81jBY70FGjcBDCtEw9I3f5yACG9ZSxK?=
 =?us-ascii?Q?uavjf7sBj4A1tAdYXBzzDw7mWkCH9CAARyPWLFfqCnZYO3g/YlRFd+5NtOvI?=
 =?us-ascii?Q?SWFdCHTHv/+uEoD8xcB4XsH6FYKNxudbCdhLV5LiFwxpOmwp/NVxfask3bbm?=
 =?us-ascii?Q?aHhHx8VZoIWwTSdYAXziBAruymjDO6FF1efZSnkfSAenBNsPFCZVr/dEJm9G?=
 =?us-ascii?Q?9ORr4gME1/mHy7gkk0Npwra/r9piOlSHcBIX0xpqteSHogDm1ijYUVVKOMLl?=
 =?us-ascii?Q?psOhIIVPPRFdAW4x7qVKVwV4XvYSs7UHEjmywbdYyJnogBU+XO0JrNmhgp1Z?=
 =?us-ascii?Q?8sVvpkmulFcOUKdjYb2sbZwlhCfHu+Kj/tXUX5pZ89Kx52Lt94wDeI+XZvBb?=
 =?us-ascii?Q?ej2rerPzzVak/W7P65lZcQnck7lOWa1/sx4Hd8v0LEnZZ/HWfMLwHNqN+mMu?=
 =?us-ascii?Q?2UYAUX4Xh8NytMD3UEpO1HL9kmx/rtOcgy13pQ05r24ZRXp3GZe/M7PJuSpT?=
 =?us-ascii?Q?yHZLk7mP1DhD2aixxzvvZdmxy3aVaTDl/XR1gKXkeBITVEllosxODpL9qsY7?=
 =?us-ascii?Q?Jkh1sdEGDk8hxK1FiCQh9e6oWeJ2PMEd6okFBxAKc4qB06H8tWPO+gT7yfQF?=
 =?us-ascii?Q?oMZaUPX2vma4y6ItyCTqnVZIGh9oE3I8eNMqPmonLPN4WQyFg6gwHxiaVv+2?=
 =?us-ascii?Q?lKV8xF53ir7+KHRrEgtSRMDhURBsZGP/l11fotdAP/QFJAjSDYqvRamKiJnf?=
 =?us-ascii?Q?nmQ1neN+cC9si8WJay/Yghs/9GnoT2iGYePJeTyNnypz0ecJcemG0JyJiuCM?=
 =?us-ascii?Q?tnhb4p61HFLlbNZLMCaKOTrFv+YsZneK+KijAlfzlOg10k37d9EenjxuoVjB?=
 =?us-ascii?Q?N0orBUjyEUn3PbKiJB4u4aO3kkrH7NVA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yw2OVVLSYi/XY9evS4Ihwc/MGsVoWdhEfuHDmvwWamm8oCOaAtOX1hSghXKg?=
 =?us-ascii?Q?MsuEBQDmiE7sxJ6WJVuBeQdcQdt8vDMNM5/j+8diJ9TxTg+D7jG8Tv1bgfWb?=
 =?us-ascii?Q?e621T6uu+dQSW1+Oop62jE2nlOtLqpDQYr/7QFp8GRCEfPRh+jTFSj2KlBcQ?=
 =?us-ascii?Q?WZfVNTGd63E/WbtL3APrpqFD5p7rICfcXEjx1Ml103Ty6kQgF/lCcmSaq9PY?=
 =?us-ascii?Q?CmFUn85hKy9DPIFWl1V4g4vymGLxzHtbWzWRrKEbDVXe76TR2J19CwWgjG3G?=
 =?us-ascii?Q?i8FTWY2nUaZJ1y40sRbmt7eIj+8X5eMCxH+brSZz/fwjKRsu1wiCB2aUwuDS?=
 =?us-ascii?Q?ID4XBU9V3LGvkXaSU0JDaO0H6pYNHcl3dn7pVNNui5GUGdatNFUgWpJVxCKX?=
 =?us-ascii?Q?vIdK8wJn5Cvue0ZPqpO2TsDUeD7SULigYPRVaTREXE198hghBRW4wUnNQ8n6?=
 =?us-ascii?Q?3cXxLDIoaz7IzOL/JiBo9S71jWNxEnG/hPSBgOWXulnp6nePoK6qpV2Mu76N?=
 =?us-ascii?Q?x9uX9kyQONnJFTyPiid/RuTzu8JghKumHS7evKzDfXTxDSUsIeZmH9Z6R0+v?=
 =?us-ascii?Q?v40VyyU/dRRDHlBAPMhf/fhs3wsMqZM7aLHdLkjJBe4HklklFejFQIvdE8Zw?=
 =?us-ascii?Q?CcRbmSFgLn0s4atkne6jZHmzdHJmJFCgozkccG3sxvOfoWuTXERU6L3IL6sA?=
 =?us-ascii?Q?oaxfEzKQVLQgWI81G03vCata6v17xoyZdzInMgRYiKeVi5/Z5yo0u19GKfMe?=
 =?us-ascii?Q?h09C2/F/fgSi19DId5gbvUk67eVn03pLZqgm3PSpIdvX76pkk3zMfR+vfsr3?=
 =?us-ascii?Q?Ug3idlCwA0AdCdch/JBYGA89n4WgMffLAgn8/kWH+x3lH1/EsuT8hUENmddr?=
 =?us-ascii?Q?nyu4FbDHWd7IO0WCudYTE+ebjkDThucGzq1kRCXFtPaElqM+nUEGEOW7FTcT?=
 =?us-ascii?Q?7HvqL/DTnF6+w/fOJ0rWmDTZmzvjf5QdD4Iq4OfLit5DxcsIYjqafow+W4j7?=
 =?us-ascii?Q?HBZvMWj+8FHAKTrf5/TseJtr0bDlv3scqE7/S2q5v7sU0eif1J4HVJe44bB3?=
 =?us-ascii?Q?TG4Yj6Sns+uJrtAjQQ/usVVIKfICGqpMeLkbgD+dfcRGG4vRgi/xgALGzP2X?=
 =?us-ascii?Q?oG7++Co98WVPLCIqJjZyVSieOHyiH3iyLYKEoPzGv6T+/O7G7xOvrVViJwlV?=
 =?us-ascii?Q?bKR2lyTDOliLQaXJ8U89G3QImCUGsHvInr5t4ps7Zou45zScXICsAtp1/VMf?=
 =?us-ascii?Q?xIFbgS1UD6/X+7Nn9kSMTTJv7zxp9emjd4Zi//ZGWYTeKNLcF/kpn4a/3zpQ?=
 =?us-ascii?Q?5vrrzlN2F/PDpnc88oUGTacTIZt3ADGjvLpzA7Izn4KISvihiJgbx6Laf4YF?=
 =?us-ascii?Q?xj2WRmNPAU3OBNeoZZbXprgZmNxdGU4Qg/RDH/E9bQX3roSl/gWPuz8s6WKI?=
 =?us-ascii?Q?Huz6V5aJ9ssiVGP/+h9wACmzAT9A1QAMenfRUdAfXD0Ioh2XfR5hM6dL+mGm?=
 =?us-ascii?Q?CPMMSeIwQQhcNozsWQRgu5JY2g2uskHHG/EPovQrlJJEh2MJMIJGj2DD3RQC?=
 =?us-ascii?Q?QoVXo7936NIspKRZr3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e23cf43-19fe-4dbf-8869-08dd505ac7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 20:28:18.7243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Er7ohy6DVTQAqF7/0Alq2NsxbuaOx/tq6Nh/5DYrNb+SP5j2GRhesmpf8RZ6q7Fg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Harish
> Kasiviswanathan
> Sent: Wednesday, February 12, 2025 5:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: Set lower queue retry timeout for gfx9 f=
amily
>
> Set more optimized queue retry timeout for gfx9 family starting with
> arcturus.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  7 ++++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  8 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 25 +++++++++++++++----
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
>  6 files changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8e72dcff8867..e62f5dc2529d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1024,6 +1024,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct
> amdgpu_device *adev,
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
>                                               uint32_t wait_times,
>                                               uint32_t grace_period,
> +                                             uint32_t que_sleep,
>                                               uint32_t *reg_offset,
>                                               uint32_t *reg_data)
>  {
> @@ -1035,6 +1036,12 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>                               SCH_WAVE,
>                               grace_period);
>       }
> +     if (que_sleep) {
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
> +     }
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 9efd2dd4fdd7..11aedaa8a0b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -54,6 +54,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device
> *adev,
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 04c86a229a23..3f74307d466d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1080,6 +1080,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev,
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
>               uint32_t wait_times,
>               uint32_t grace_period,
> +             uint32_t que_sleep,
>               uint32_t *reg_offset,
>               uint32_t *reg_data)
>  {
> @@ -1091,7 +1092,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(str=
uct
> amdgpu_device *adev,
>                               SCH_WAVE,
>                               grace_period);
>       }
> -
> +     if (que_sleep) {
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
> +     }
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index b6a91a552aa4..3f159d477f5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -100,6 +100,7 @@ void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_devic=
e
> *adev,
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index ecabf95d972f..a1b615dc9a19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -305,13 +305,27 @@ static int pm_set_compute_queue_wait_counts_v9(stru=
ct
> packet_manager *pm,
>       struct device_queue_manager *dqm =3D pm->dqm;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
> +     uint32_t que_sleep =3D 0;
>
>       if (wait_counts_config =3D=3D KFD_INIT_CP_QUEUE_WAIT_TIMES) {
> -             /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
> -             if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_=
apu
> &&
> -                 KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))
> -                     wait_counts_config =3D 1;
> -             else
> +             /*
> +              * For all GFX9 ASICs -
> +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +              * On a 1GHz machine this is roughly 1 microsecond, which i=
s
> +              * about how long it takes to load data out of memory durin=
g
> +              * queue connect
> +              * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              */
> +             if (KFD_GC_VERSION(dqm->dev) >=3D IP_VERSION(9, 4, 1) &&
> +                 KFD_GC_VERSION(dqm->dev) < IP_VERSION(10, 0, 0)) {
> +                     que_sleep =3D 1;

Why not do the IP check directly in the KGD v9 callbacks if this is only fo=
r select GFX 9 devices and you're tethering this to setting the default wai=
t count override?
The only time anything wait related is ever updated is when the KFD starts =
the DQM or the debugger requests it to be something different.
This way, you don't have to update the definitions of the KGD call.

Jon

> +                     wait_counts_config =3D 0; /* use default dqm->wait_=
times */
> +
> +                     /* Set CWSR grace period to 1x1000 cycle for GFX9.4=
.3 APU
> */
> +                     if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev-
> >gmc.is_app_apu &&
> +                         KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4=
, 3))
> +                             wait_counts_config =3D 1;
> +             } else
>                       return 0;
>       } else if (!wait_counts_config)
>               /*
> @@ -328,6 +342,7 @@ static int pm_set_compute_queue_wait_counts_v9(struct
> packet_manager *pm,
>                       pm->dqm->dev->adev,
>                       pm->dqm->wait_times,
>                       wait_counts_config,
> +                     que_sleep,
>                       &reg_offset,
>                       &reg_data);
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index e3e635a31b8a..1ed3fbedf50b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -316,6 +316,7 @@ struct kfd2kgd_calls {
>       void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
>                       uint32_t wait_times,
>                       uint32_t grace_period,
> +                     uint32_t que_sleep,
>                       uint32_t *reg_offset,
>                       uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> --
> 2.34.1

