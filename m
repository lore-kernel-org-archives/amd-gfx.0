Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D507C61DB2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 06:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C495410E1BA;
	Fri, 13 Jun 2025 06:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgWQ0RJK";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5C110E1BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 06:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6lvCjwXYRLAfPd8Fdo9G6OJlSciKVt4uVcmql89PwnSUWpEbZn1pykuYqieJdlwZEK4Ve37I/7P4DiA/mXwwinRBTwgpbfiIWzmQQkrOuGsWMqKkZED5YiHzhoI2/VoNMes1Sb9c92zDLIlby5aYoiQFFDUAS5tNRyMYJhOG1X68xtZ7MHEYX6DwQMbz/mQb2w4r3L6tg3H0MfTBaQZ4VrvKvQTPcipWIL4q5f3jy9Vz2NiwAbG+jne8Vf7PEAHCPxfL28WAKr42zw1b6WrMEeKEj0Kw10k5baG+ic8moiTGQGZk8qOX3OssLNFF3CPB7XtiengNu3/3STVxes6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb7EWvpgKCqJrsgSjhSPBniYtbaC9CkBVIchVgbdtKI=;
 b=TQgNXASOR75s0GkSrT4eMUTToynoMDceK9e51w7oWT96jX2jUZDpiFLVVXu/kzxpE5uczaBPmkR3YnPlkrHjCWaGYKa2R8RcSJMGZUoiMjQMVOCooTtNVUgLru1c9Qicuzz++vECQla4bIdt1Q/GMNRDVF9STVmAl4/J57jvSRXT9eB7TRpccuV/J0z8m1eOTn/Sor2g6D/uCa3IqS8uK3c1HyI1TxN1DjzpvSWi7EMPIrlvdcPnMnMNu3wz/zburHvTCSDOw2Rcq827iyCcAlExxuWhbItZLS5XPytEPWh2oElGbqoOV55QqEQo6isIli2Bd1bYy8B4GHCV/JW8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb7EWvpgKCqJrsgSjhSPBniYtbaC9CkBVIchVgbdtKI=;
 b=WgWQ0RJK9DS/BSh3FjILTKfYulEXStGSmoCb4KVefR9o4gG0/77PL2GxLDElygDQRt44JJEnYWgOMrv7cYhRsZPl75gYMXwR0jIbib+Ak7DmVg3gmZdjjvAxDcfmdiFE1TvQ1aJDO6PImbCdMDFPJvBQ5SSOV+o/wkO0AKuQvNA=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 06:43:50 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 06:43:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: get sdma instance from irq id
Thread-Topic: [PATCH 1/4] drm/amdgpu: get sdma instance from irq id
Thread-Index: AQHb2oHVIyBNhyRpGEu//y3l5W1LcbQAp+pQ
Date: Fri, 13 Jun 2025 06:43:50 +0000
Message-ID: <PH7PR12MB879689548EAB56AAA4DF3A8DB077A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250611033453.48610-1-tao.zhou1@amd.com>
In-Reply-To: <20250611033453.48610-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-13T06:43:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB7443:EE_
x-ms-office365-filtering-correlation-id: dadf6381-971d-4e2c-7fd5-08ddaa45a81a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XGD781XDCcrPFCKiLpFLqR9ZxwdZJwrr3m/TlRQvBpVzezVBsGTy++gPidIZ?=
 =?us-ascii?Q?K/G32xP7vH5rfcRkQiyW2vefyJI6xdhyUwIOCBUFYZzdKUd6dPSDsL2j0J7i?=
 =?us-ascii?Q?jyac5NPiLGR5wVKDaNZFM9YIWvRsbgf7SoXhXT0fl39UPoLoq+cxLY9SKY2n?=
 =?us-ascii?Q?G5BwLyI1Kcyaa46qnZ59C5BqeeEDosQJ4m5F+JpoCnM4eqSdBJFM6IZ1PU7M?=
 =?us-ascii?Q?7g0aeLxBKWMDqZLxPtFfCVxKzpZtgTb5E2SKpdggOCOYDy5jwOtxCy738kjl?=
 =?us-ascii?Q?CN4lFw/H/m9KiRd0znWHnmkoDE8BbKCbGQyZu/5g3WO3b8Co5RCw04hsQ9O2?=
 =?us-ascii?Q?yd1YdEAr0ouoHbOf31Khm7EQNow4PCWPOW/qSzUUDW8vwOUjxZNtVPr3K8Wa?=
 =?us-ascii?Q?NFsWSyWsnF9XG/RQfpL7Pa79DZGh58aOcB60fAqxI4jtB/Kq+HEYFv90O/5B?=
 =?us-ascii?Q?66Cy98QQujuOSdGIHAhB2J+C7O6nO+pgYKthIA9BkZcZXOVWnut3tCY3hFya?=
 =?us-ascii?Q?2B2+zFcjIrltYNZjD1qMDoWvClHBAhJk9TX+YqDQOqP1gtFCNNA3UWyocgWp?=
 =?us-ascii?Q?qj44fIx0Rsxk/DmZkqMdWExqBTqCCc75JqHRsBzNbBHF7HtFQ6BGhOJJQKvD?=
 =?us-ascii?Q?6VB8NsDR8PbCu39jhnDkSYI087iYn7jAcQIYC0JFbAwmpAWaKcOsEuCNMJkN?=
 =?us-ascii?Q?oBh/VNRUvP/L+bpPL771Ro9qOk2na65c/LmE720xXYjJy8a64ezOetd47MFb?=
 =?us-ascii?Q?VY8fhta5SjbLxkPadRvPlKpoJ/OmXFj9ADxTtoBV6wUaV/OLJL9cdACKOzc9?=
 =?us-ascii?Q?d4u4EPdFizgzE+fpgTbeCqG/ZsfZaOYiI4kS4zAXrmEKxCp58feNZl/sTSnx?=
 =?us-ascii?Q?nFi/VMNgqeNjjSLX5bSX35OxT7AjwpEzZxrvM03M3+KW1jp4z1TDD+IMZKtJ?=
 =?us-ascii?Q?CH2vK9LCLZnMjW4joSxK56f3b8SzLskUfijbx6ht1kLrel5mjSPsf3Rv88s3?=
 =?us-ascii?Q?ZE1OZDQanTc2SQiVhXDdlula+xTYFGh+b+zcpq3WRVQTBEi0eAoGj+G5nijl?=
 =?us-ascii?Q?6qviXwL7AnMLrYsbYrPwZttdQ9+TCzV2cWnnUn8X9PMZf1qwkRvNDnJbrd83?=
 =?us-ascii?Q?4msp7wj5jD+qp5rzk4cVzabQsEu7hfruUfTBINMI5Zx5g3THpfdQYwE/tI2s?=
 =?us-ascii?Q?KialqdioCHHUq7af6DUgEbEkkjTFEEGUMrHmV+4AKDbWeYy65sRNwPrUD7bl?=
 =?us-ascii?Q?ShdB1jMFSieCs5+ACmZ2Ep/U0R3Y9GzcrJcmZxxn/LgWw4aXZFCuvPHFDcKx?=
 =?us-ascii?Q?6tcoR3/WDLigvLVd5kVIkCu8azJnR9RBNwAHlKOw4QVlQMNblpjWOdcZw3DQ?=
 =?us-ascii?Q?i84+I0JNBHRCLC/qxgyZt8Se23/DsXkRHlAL6uRyaYzGAfR0wfUs5uQZOPda?=
 =?us-ascii?Q?qfwRAa/sdwbvN1N7LakgohoMYxPiPdvlBwAYlHfumY3wOdpKe54WZg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qVjyJbDu/2qBBCqM00NztNVINkDRX/f/e5KL5VDg6MUAKmfgnT961GP5HUqU?=
 =?us-ascii?Q?T+f84nk/IytGG7xJUh5blh9YGrONwijV54nYeZRv+N4END2HRZqRCsISoWAx?=
 =?us-ascii?Q?4JbbZeQPDxk/PbtuoFozZE5ipZOztx5IFltWsQMmSNoj7e/98HZN+o1B5Zmv?=
 =?us-ascii?Q?Nzp7gcTFTffE+X8JgJ/oU0an/ENDyIHeAeeygkWlUco5c2oIPGVDM3vwtmvx?=
 =?us-ascii?Q?z1NAUSMbEinZl2sAsmdZBb2yFjke7ic8GAreau2zNJsfO+Jwok+edc0rqEvn?=
 =?us-ascii?Q?A+SqJKM7S1LMA10uZtaOJqPj147ZLovg9+bwGCcPGpZzmgbMJMNG3Ky66LL/?=
 =?us-ascii?Q?oLEm4xZxtLK44tyEnYU8yxALUjtcLBBYp5EB9GnPE4rCOj9zgHdxW62aUEdY?=
 =?us-ascii?Q?JYu4zeOEZGEzKe/Za4UkmUevw5amsOiv7GAKs5ygd366XFn2I8KhkS+97CYu?=
 =?us-ascii?Q?5mog3hr+DSYxlVcEcpethmm5aIumRYob45Y+yjz2NYgmk/wjOJ6maN4kVnF0?=
 =?us-ascii?Q?52eqadZ71zmjvRN/gWGI9T4r+WtqffKqnSyoF/94aiMwMoAmhNgV516qHwB+?=
 =?us-ascii?Q?JfFPgsByWonkhbz+Nxgb6PRHuewqfGEnoy6NDz30J+vzDsrRg5hB34WjGXpq?=
 =?us-ascii?Q?ApJUoaJWFqWL8qR9dHNQDd94dqRAxNDakB7qZevg2fY2gRowaVFLZNfquk/O?=
 =?us-ascii?Q?48t/88e+iHR0ZBtc8GwILK5OtDbMUEbFS6DrFjF1kIZaJFWY2nNxZM/wMfR+?=
 =?us-ascii?Q?bThGKCGycmxpCrRYhKr6xCJErSipkj6QVnbP5meyzanVBN8V2VlJejJsHiwu?=
 =?us-ascii?Q?2ilmR4UYqyRuXpMpYNRDS1KEQW+G9zg/m+sHCsDOkcLH/gfMAxkGtoBvynNf?=
 =?us-ascii?Q?C3tYr00PiiVJxx36X9cH8gkFwJ3XWPcTHNsYuKfnrYC7UCZBowiDSQIBW7E5?=
 =?us-ascii?Q?xr+RvdMbyKTIEVLy/6sSvBO8yMtP7cZFcMJnqL+Hhj/9XPyVCAW2JvJdXgpT?=
 =?us-ascii?Q?zcQBLBW9Vz6I+AmJSdBFgvOQxnfVpEJ0hapo6lzJitE6RKbAUdNSWocThLIm?=
 =?us-ascii?Q?8GXGQciGWhrEoVkSAfeFWMAl09XIz/TAVHRMHhtkM/XXKk6ErI7TqgdeWA1m?=
 =?us-ascii?Q?JoMbIkksjBQ34MAziRNzlUThkO1o92wZ0/0gy+DiX/ttLm8I5LW9rb8s50mG?=
 =?us-ascii?Q?8gu/eMG0wFpZO+7ZqH7xgMaYEBdNolrTTaOCqa9kypa4mhtkszpFHftOWqaT?=
 =?us-ascii?Q?EeleFLDblsFzPTOia0U5FPKeBjXEP4VQLl7AUGCk1guqZd8uLwNQUlYnYQm7?=
 =?us-ascii?Q?hgoHzoBlG59mMgDZFuQLTWwNqdKWvueal6JSTMgNB2F8xVqNdDMsDOPcwK2b?=
 =?us-ascii?Q?LYaLplXHyx/8mRDN93zsMw9sNlMAyeiA0ZFd1iHnARKxxqj2RGBNzI0Rl/7N?=
 =?us-ascii?Q?nc4c3GN3fe6RznnFhJvRTdjJn/HYomG3bNBBjI0254skBdfk6cSlVnHfMfHI?=
 =?us-ascii?Q?Sq8/VEUEzUFpTQWz6pKDG6MwLG3AvQWeeo9Y9cp8DvqGaG/wl07BX61yjJa8?=
 =?us-ascii?Q?zximto3C7F1dZuscsmo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadf6381-971d-4e2c-7fd5-08ddaa45a81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 06:43:50.6141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WroNPbfb/xcVE9M0Jy1l0nQgKhRfwd4m7AaF0EC0cpVS/1WhEQomHyp9J/ZcI8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

Ping for the series.

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, June 11, 2025 11:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: get sdma instance from irq id
>
> And the interface can be accessed globally.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
> drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 51 ++++++++++++++++--------
>  2 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index e5f8951bbb6f..262321a0aa4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -54,6 +54,8 @@ struct amdgpu_sdma_funcs {
>       int (*stop_kernel_queue)(struct amdgpu_ring *ring);
>       int (*start_kernel_queue)(struct amdgpu_ring *ring);
>       int (*soft_reset_kernel_queue)(struct amdgpu_device *adev, u32
> instance_id);
> +     int (*sdma_irq_id_to_seq)(struct amdgpu_device *adev,
> +                     uint16_t client_id, uint16_t node_id);
>  };
>
>  struct amdgpu_sdma_instance {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c169112a5e7..96ea9a0f952c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -156,6 +156,35 @@ static int sdma_v4_4_2_irq_id_to_seq(struct
> amdgpu_device *adev, unsigned client
>       }
>  }
>
> +static int sdma_v4_4_2_irq_id_to_seq_global(struct amdgpu_device *adev,
> +             uint16_t client_id, uint16_t node_id) {
> +     uint32_t instance, i;
> +
> +     instance =3D sdma_v4_4_2_irq_id_to_seq(adev, client_id);
> +
> +     /* Client id gives the SDMA instance in AID. To know the exact SDMA
> +      * instance, interrupt entry gives the node id which corresponds to
> +      * the AID instance. Match node id with the AID id associated with
> +      * the SDMA instance.
> +      */
> +     for (i =3D instance; i < adev->sdma.num_instances;
> +              i +=3D adev->sdma.num_inst_per_aid) {
> +             if (adev->sdma.instance[i].aid_id =3D=3D
> +                     node_id_to_phys_map[node_id])
> +                     break;
> +     }
> +
> +     if (i >=3D adev->sdma.num_instances) {
> +             dev_WARN_ONCE(
> +                     adev->dev, 1,
> +                     "Couldn't find the right sdma instance in trap hand=
ler");
> +             return -EINVAL;
> +     }
> +
> +     return i;
> +}
> +
>  static void sdma_v4_4_2_inst_init_golden_registers(struct amdgpu_device =
*adev,
>                                                  uint32_t inst_mask)
>  {
> @@ -1337,6 +1366,7 @@ static bool
> sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)  static c=
onst
> struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs =3D {
>       .stop_kernel_queue =3D &sdma_v4_4_2_stop_queue,
>       .start_kernel_queue =3D &sdma_v4_4_2_restore_queue,
> +     .sdma_irq_id_to_seq =3D &sdma_v4_4_2_irq_id_to_seq_global,
>  };
>
>  static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block) @@ -=
1764,27
> +1794,14 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device
> *adev,
>                                     struct amdgpu_irq_src *source,
>                                     struct amdgpu_iv_entry *entry)  {
> -     uint32_t instance, i;
> +     int i;
>
>       DRM_DEBUG("IH: SDMA trap\n");
> -     instance =3D sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>
> -     /* Client id gives the SDMA instance in AID. To know the exact SDMA
> -      * instance, interrupt entry gives the node id which corresponds to=
 the AID
> instance.
> -      * Match node id with the AID id associated with the SDMA instance.=
 */
> -     for (i =3D instance; i < adev->sdma.num_instances;
> -          i +=3D adev->sdma.num_inst_per_aid) {
> -             if (adev->sdma.instance[i].aid_id =3D=3D
> -                 node_id_to_phys_map[entry->node_id])
> -                     break;
> -     }
> -
> -     if (i >=3D adev->sdma.num_instances) {
> -             dev_WARN_ONCE(
> -                     adev->dev, 1,
> -                     "Couldn't find the right sdma instance in trap hand=
ler");
> +     i =3D sdma_v4_4_2_irq_id_to_seq_global(adev, entry->client_id,
> +                             entry->node_id);
> +     if (i < 0)
>               return 0;
> -     }
>
>       switch (entry->ring_id) {
>       case 0:
> --
> 2.34.1

