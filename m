Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFF4C021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E2A10E3F1;
	Mon, 24 Feb 2025 13:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yasM6seN";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63DC10E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 01:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8QJXNpLH7saB06jc8AmnWKgxi7vx4k0zE2wVz0xs2I91VQmR4fR/7yH0/7F1hwIW52CHovLV1onl3D7JfL0ltG/Q/HxFC5O7BDvc5UWlSiBql6sH+UHiIlpJayIe8t8g8Sk+2g8qxKSRs802NbRFfABHYsqzgw4fP8Xajv79LqbG/wUQ/wBCbhgh8p+GLE6V8ZALfyy4v0XrqF9ViRwtJks20kupd5vFYxOhNrtlGl+yuLlvwXFePomt/3D8+Uosf9lUytjS5BOaeXeYqzBI6W4Yp5AA2WJKnF12jGZJhIYO8vJj1uzufb6M/kXdCfaxZuFrqHbNQKDbn+ZYx72Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cS8qVkSbC5EvTzh8d4vjq42i8tjrOLbL/VTjjaTgVA=;
 b=KpYxoPkI0eYimsXSf58tMvxT75ODJ2YOjunkZ9fMG3//0o8NQmkC8vT2C/cYqbBA4gwUhK1XIURK/XTNrLVneORlP/LcodYwfzC1qUvYlcjP5w3CFJEfWYZKP1FbdH2wuVpW2dkImN5NWkRKaZ6lWA5gOZP9K2FPCSAKnDD+o8VyR4xZnFblpilpbQDptLXg+JtOpXcbhiHlj9NZ3WWDaumgVv4WjCSGL/OYrzOZjC/LoM3Em+Dd2NPshMx9rvKXbZGxG/VcIv67eGDj2YqIQe7HwfVG5yWPJbc3MgC/CphmJSBvO2Tqtaa4k1nTV8HEoy8zUAOuuxJa6uZwfFedMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cS8qVkSbC5EvTzh8d4vjq42i8tjrOLbL/VTjjaTgVA=;
 b=yasM6seNGAHTuZBii9ETWwNt8MGHv2n7a+oxlFXGc8sIhdRBTZWf6Zf4k8ohgO61O/jbkeIf1cc40h0tGBthKjYgIHxYa7azweCTPaZ9lM39zSIg6MmXrXMfwllJ2heKHs3GRm2bRNIizilrPQTJ8ooxPktaqQwcZOxzVZV21kI=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 01:52:40 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 01:52:40 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Topic: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Thread-Index: AQHbg2A83gtUpFkbEU2j4DQWnCY1sLNQ/U8QgAS5RlA=
Date: Mon, 24 Feb 2025 01:52:40 +0000
Message-ID: <PH0PR12MB54179719DAD3729506B19EC28FC02@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
 <20250220062515.2050499-3-Emily.Deng@amd.com>
 <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5417321889D7A86F9EA6D6B18FC72@PH0PR12MB5417.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20eea709-1c3c-4ab6-a31b-da2884a9d2e2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T01:43:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB7325:EE_
x-ms-office365-filtering-correlation-id: 21df74f3-6fd8-4871-85be-08dd5475ec12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?X1brQ6FAdsf4wP+wlGem2cA+fuwPvsJSm1fE6sRw5qkd5euDI9JAVuLUs3PL?=
 =?us-ascii?Q?p83WegBaq/RQZK8viDhIE5FMD9p4Krp4GYQluSypJ2yg5f8phS430HvoMcvG?=
 =?us-ascii?Q?OsLgrMG31j4NbzVxPMRXReEUGV4EWrmy/8nPsR9HwFvFb1dDOtHHrea2Y9dU?=
 =?us-ascii?Q?B4yRsDJJZ2grP0nW1ke4/+2c++jhsePn+uHTyBPMV6vbbtu6bwXEQ1XVKNYh?=
 =?us-ascii?Q?ibTVPH2ZrhcQ2MpG8EkW8PikIDBGvZMpEixYw5gBTGepQwFLNJmbyk7npH7U?=
 =?us-ascii?Q?DadGiE1O9BgKu4AVjhSIuE8jq136ybQw0NPaQ0il4aQpr1w3qKwz9oY9ckGn?=
 =?us-ascii?Q?pv5qgJ9h06wYf/lK564agwHqHvUzgp7l0Iw4r3cI5q84BOiPCXvDwickVoPh?=
 =?us-ascii?Q?EPd515E6TDf2gayUtYR/bWlIuP+Y4X3S3e+EFRcmqbv/iXL5IPXVj6iXImB8?=
 =?us-ascii?Q?ayaryE9f2Q5i4bVfSa5NSDoLawtUnBcWM3/q6k5R3tS3A8c2UmudxSimnh4C?=
 =?us-ascii?Q?/rVprQSyjThPkn0GIyoSePpjdx4dXOgorcFZLtx+AzPrkmXWxFs8D71Ea9C3?=
 =?us-ascii?Q?h1c5s+psMJQawNExzsj8arRBP3EiaC6FY+CP+8r4Tj4ifZtZGJIc6O26eRFF?=
 =?us-ascii?Q?32Gyi1uF3x6A9M3LzUDYTDwxDuD3WnPk775qzo8qokPWlxN8vbCguxfiPkbB?=
 =?us-ascii?Q?2soX32bmEXwtcfU+pc7zjuK/MpA+5kCx4oQVekGAAC8wT1vCSZbirn74K+o+?=
 =?us-ascii?Q?b6w+C1A3dvNEvRtCn+BI8/3DCpm1TES8hp7jSi50wMCJklnjzQWBBt0qhR3q?=
 =?us-ascii?Q?ydEYBSv3XYW1nKeooahaA0V6qhQHc2SLGQDErgh1HNlJAS/i3C+nib1zwImr?=
 =?us-ascii?Q?dgZ9iDBXGzVW/ZZATHBqNADuwSyVjonH9cZaE7AmgBarJC/T+u7aM9xMwPLZ?=
 =?us-ascii?Q?BmqdG41vyuxqr8Wh8h2CaQsjBZW+R0jT7dlZjw1HDcwmEXoWUHflvQ0ySuio?=
 =?us-ascii?Q?ulOIJ1Yq7z997MBji7GmcVg3E3WmgB9D4PszbjsWxMHUiQGs1RrlY/VGmAPq?=
 =?us-ascii?Q?WBAOXtdz8R0/uj434YlaPnBuFRB8cuDaRUXrx5PV0UCKyEFgZylpYbUal/ng?=
 =?us-ascii?Q?oZhjtEJxIk8USwqUULMcdMl/CmdY6Hhg603dtuzlwcHtYqU2g1UQUE5InfH9?=
 =?us-ascii?Q?o2QDoxuNRN7gEoTDwJjv40/g1qONk70nGT9mUGZR10JOMQOerbtjFuG4wNm/?=
 =?us-ascii?Q?vNxdUGbF614vdeEmhBzJJuEVU/ChPFLXkI9K8fxCVjUWh+Bv1NyzEjA9GVxQ?=
 =?us-ascii?Q?K0z5ihfF+k/mOlYqtxlP1GHdABjhJvRQFDMyBM/VIba7ZJfVrA0CqxQ46tkW?=
 =?us-ascii?Q?Ievd+U/czRs6geu/xlLhpGtF3Nks6k15+JpaRBlmxFpScFeERt0PH37HUeiz?=
 =?us-ascii?Q?TXBdjOGiyApV47vFwpTj5o3yQUdpL3sl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vaxYIMcxI8LuGJbPDOtezf2loAoSwc0bbKdjDQRqrWOaZf1RNhE4BnAc4OHf?=
 =?us-ascii?Q?wx95uZ8xHYYhFCR+spvxJElfKUczqF1BV5YfTdFQKFcOmfZOEc3ZGhfGRsGt?=
 =?us-ascii?Q?vQGSn6dli/AzKu2tgngV3uezF04iIzC6HkIM1eZOyMM92jd7hAB6JRDSuoVn?=
 =?us-ascii?Q?LGIAeMyo16QUQkMqK25BR37PzPMjD7+9i1/PnYt+Iq6oS8rVjXHR1P0/rvyO?=
 =?us-ascii?Q?SI/k94cW/lwP+ro8+GQE4prbI0TZx66ete4I7QcnFlUp7pIourVFzXTeS0JE?=
 =?us-ascii?Q?Eh7ktJ3HfDeOT32fzDJZ5xzMfe4USxjqwStv1VphqtuueAFrd0n3UnVwHoLR?=
 =?us-ascii?Q?jtTdMyrh21IcZN6a4cgDmLKMl7SPLVrcQOrM+PmSLUcgiFdet0MWTOJNL8EP?=
 =?us-ascii?Q?l2pAl9C2Ge8pSfpcZ2Det7hcsATs+Te0k+RsdWZYw06ZSZZgo4IMXjRGCxHS?=
 =?us-ascii?Q?8i1FYhS24sbmxXxhi31Kcdz8Mzg2Cml8RdKJdh9l1yax311LIIiaSPNjoe9Y?=
 =?us-ascii?Q?tjeWwlI6JceLKLBYx+vx3W5P7Ft50qN7ZNYF2qVr0S8Ba85TxHp4OKdqwcHo?=
 =?us-ascii?Q?LOh7xd43MGdL6vDfgm+LbNaWhx3vq69pqT0eNWoaaDpuJeZxkl+X4/JB4UQg?=
 =?us-ascii?Q?reXQr/+/N9CSBrvSz0LoD/4cY1GcyRHFbdxT1vVODjPi285ni7/XYHt3h0wj?=
 =?us-ascii?Q?ltLWl8lDM4WfiJ5PCFuowWl9tsN7hbVRezDRcYiczMj2mhU4F5jnhdgl0vbB?=
 =?us-ascii?Q?Sr7ndybPK+WCgnf2IlOcISGp7rTCijt7XOd98CdO0JjhGGbdn6kiftzKxLfQ?=
 =?us-ascii?Q?zAIAhTXb5D3s/UzqtgNgCj9zpTbB6zJumn5MnIUc88f7hpwXKOO2jj/Rn1LT?=
 =?us-ascii?Q?FqXZXNaJeyn51MdVf9oe7WAzCSQvCPJUXSb3HV+eOzKJbJSJlbhAKkSAnAa5?=
 =?us-ascii?Q?XJ8SfYWGqV/oJGKEb7kQj+SgrTKP8HX3geIetMiuE8mhnxJrY0auVUXDJGw3?=
 =?us-ascii?Q?gD0uV9I+kZQFV3u4kvdC5y/zAnWVM3m3LrFJh1IcQuAtM1Hz4zd6Zx1VX/yZ?=
 =?us-ascii?Q?GTjXbT2zPsKW+cK1mTBZyLfiEJzAuBVdAqqUSRB+3Eo6rXJjiBQaJ8N9pQ0d?=
 =?us-ascii?Q?DZ8QWcrIrfuRXOhdMc7kjN1a5zVgVAeWRqLQIHPK1FDoEdVmSdg9JQ6J8z3k?=
 =?us-ascii?Q?2DEZVHXvSACsG+qV3y/eAIY85Z5L9ufZTtE25YDKU2ty22DDgTVmNrIN/1ZT?=
 =?us-ascii?Q?4w4KGZUr4Mr9OhXTWswr0DK5Yv1llX9q53LuVfmqhfGnN58sSkqiN3agUHOh?=
 =?us-ascii?Q?EUCXX6S25BdBeDC/lvaingtf+8X6ZUGTpLs/NqfuMWezNLOkBNL5b2B4EfzB?=
 =?us-ascii?Q?9zulFmkxu4s+kYIIOV3iDcsrJ6vNjdaHPaxDWWDHp3TwQDzHy+pJm2VvDEVb?=
 =?us-ascii?Q?yQXLEUVTFjEDOLU+8zgq9C4tEzcMumKB4vmCRiZIxKpLbcix4FMp6fI+7Qwd?=
 =?us-ascii?Q?0Dsc/5YJbWkS8tRQsNilkL8xdo6QhRtvC9uJNzBxCLcFtwUPT3mqNcUJ2p/f?=
 =?us-ascii?Q?E2+Fb3srmOaSuUks+J8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21df74f3-6fd8-4871-85be-08dd5475ec12
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 01:52:40.4789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fi6JDyDa97dD1xyc/KtqnfN3LNzIikoVCZ4p18MrjIsn5LVnNbd9wNq5nD+BpkOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

Hi Felix,
    Could you help review this? Thanks.

Emily Deng
Best Wishes



>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Friday, February 21, 2025 9:44 AM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queu=
e
>
>[AMD Official Use Only - AMD Internal Distribution Only]
>
>Ping......
>
>Emily Deng
>Best Wishes
>
>
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Thursday, February 20, 2025 2:25 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
>>
>>Avoid updating the vmid to 0 during the queue update process, as this
>>may trigger a wptr poll address page fault when a ring doorbell is activa=
ted  in
>doorbell_mode=3D1.
>>
>>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>index 6b38967d5631..3028c16264b2 100644
>>--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm, void **m=
qd,
>>               m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>>       }
>>
>>+      m->cp_hqd_vmid =3D q->vmid;
>>+
>>       *mqd =3D m;
>>       if (gart_addr)
>>               *gart_addr =3D addr;
>>@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager *mm, void
>>*mqd,
>>
>>       m->cp_hqd_iq_timer =3D 0;
>>
>>-      m->cp_hqd_vmid =3D q->vmid;
>>-
>>       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>>               m->cp_hqd_pq_control |=3D
>>CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>>                               2 <<
>>CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
>>--
>>2.36.1
>

