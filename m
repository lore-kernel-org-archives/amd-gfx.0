Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF8DC5478A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 18:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AF910E79C;
	Wed, 21 Feb 2024 18:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UFq4Orh2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180A910E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 18:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/bXPTxUECD0o625UQ1No2PSS6m+Ol8MMDpEUAW6DvECpZ8Q+oIwzCH009famp3lgxZ4T0tpQF6e9T6EfOENSWxWMjPefzywzQFEKW134k+p4EKe38/i1U/1aeumVrusXY96/w/QYQeYTCM8alio2Uayc45geQmsatwAtaXben0GmsvPC/75S8EFpcCU+Ma8ztilhOpG62dEcjLDv/d49/aS75YekHDtsmBWXAy86QbuZlbpJO9f+llAD+9Cr942WcKcnWcyk67osudpwPmrKyp2Y6JgUJwQNahpbxh2X1hEWXL5Kb14YOUOuPx7yhl0T9AG/Ylvo6l8mbLIU/ZtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4zfrhBk+db6crCz3BotjtI0S7T3f2rT4ePGNvtWkmA=;
 b=WvBMbRarw55+0xswRmgCpxN4xTIf6eSGXOvdd2IwtY61hvqv0CcQF2hLuZXjzIKHlosLfmunCTlyz2mCuC9rFVyI4u63/T8wPM/S8v5azvX0Q0fE2SEt1R1Oewz24kp1/LfB6VnB+D7ZXPdsmT90AwnnsZBAqtM4Ozx4CBe99Eyljowhr0Gy7FaoMWHh7gXFM82Z6oy2DDfG+OUAyffufuE/GporHN4fcFZdclYb0QMt4ut7+vHU3hnj/gK8axpmQ2343uDffBIlZCYcxrQMSYmJjGqw8helI621RlosOb6D1e7fzS8OHlI5FFjNnpxzvqB5IxKRMdnx0n54JLA8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4zfrhBk+db6crCz3BotjtI0S7T3f2rT4ePGNvtWkmA=;
 b=UFq4Orh2uYWSFwQbMdnZ5L7ro7o4PHZLiHgEduwc/Tf8TzYpRYVilOncJVFeJo3Ooa/+EyXXjJN5d4mqgkrBu+604L2gi0+D85kcpDrZd5HyrKaxdv+fah69Nj8OKhrS1XnH0N4DyjH78FRVKTG2kTOgOLg9zaCT6GU5+RGpjug=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 18:39:40 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 18:39:40 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add vcn 4.0.6 discovery support
Thread-Topic: [PATCH 4/4] drm/amdgpu: add vcn 4.0.6 discovery support
Thread-Index: AQHaZOeCxw1ZzSu2rE+Hh6N8cSbEiLEVIJnQ
Date: Wed, 21 Feb 2024 18:39:40 +0000
Message-ID: <DM8PR12MB539960EB3F519BC284EE9C52E5572@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240221170015.8866-1-alexander.deucher@amd.com>
 <20240221170015.8866-4-alexander.deucher@amd.com>
In-Reply-To: <20240221170015.8866-4-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c96422db-3961-42ee-ba6c-f974afd776eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-21T18:38:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SJ2PR12MB8061:EE_
x-ms-office365-filtering-correlation-id: d56d87f8-f4b6-4290-6881-08dc330c76e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuqJKwKBaNMc1wZr9gIuOTAxR5aLaXfbSjmKJRchIFx+eVXQStrfwnp/N+TdXMeIrf9Edz1lQCTETfRs7I6+F45/BiQB1+eTm6sKqFjjTkj40fFXG/Yu65BN532kEuc4i+0JQsJpMlhnkYDf4PBR+Ufbi/x2GA+EHsHO2nWUuL0rVJCHYdT7d8Kw0cg7KaMrbCUG4x2lzLt+X1UIpHdqTVkvTgaDtHmT3/WvtZYqkkpsPNm4FZdPQSN/SkqI0qdKK/JMuRwYoWLhR1VK9ek8XGHm34lwqgW9pjoY5koPIdBYgcX0OmcviDFSe0jkdjebIQk8GD8Dp4PgYXOtxthSXdqZJmZI/VceONFwuGHKG794P2wzUWJmX5HXv4lAOup5Hf9bd1ms7+lptUM3+SjSfn2HszwU1mUgvanQOefaJMjvUeSpErCuj+tvPDZcl8EyMUHlRHJgtgjFO8MFeMjhjpTJrHjhorrkb1RHGUahTmfLnHZ/ZSWhN7bHfyLFki5wdc7NYQAAMtB4oZuBh2jO1MoPHoLslu9PAhTlars/SjHIJiQbJ+v5Ep0fSJq0AbPIzTR3XXvykkbN9aD1Ei+u63C3fI4rdFaW5LD1x8A5BX1SGkohcZ8jb5969UoqbGkI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DNrSvT767FcD2wIbHeVhb/zpmLyM9yiQdBjc12X32J9HaZo0BWGMKCNMTxqS?=
 =?us-ascii?Q?0XfNbMGfLMoVqMNHs/5abxSHLkwzgAaIbRzf5ZgdG+JWh1vSbgpWL9MfgNpT?=
 =?us-ascii?Q?Vk2DCFwxXWiwwFSlKDH3dP3oByjPEcwqaa/+O4O9GTziFZ1V//u66O69Qcc5?=
 =?us-ascii?Q?G3IwNXyVBpqyvjJShxjVLOeZ3x1uehNi1Y+vmoNlhixzYFdTLYyxm3NHZIcD?=
 =?us-ascii?Q?gFbnWcc6mNJVRA6IT73XmDLZuSMwHpu0uwBenbzzFSr/81PfyTeDceMajk2W?=
 =?us-ascii?Q?qaofh/VMW1d4G0NvmxUlvF6M9+/b+8qwU7GrZ7Io8rPxVdIAnpJy/OtHTqdn?=
 =?us-ascii?Q?+LdosaB3jO3Jp8Rm7yn4wBYIIgF1sJ0JsUOgAG0eiRtDGrhJwDQjtHmUXw1C?=
 =?us-ascii?Q?KwYX0FDUdUk/Vj5UrnNL8cKsireLdVL2VIi3kX+wOivHE1wdq4Lg0rUvRx6Y?=
 =?us-ascii?Q?2gdHS7FA1EoJjeBCnPEPcO+kuaAAiK8pkRkwngGEDLdYE1k29R9ZV/QIdtUw?=
 =?us-ascii?Q?v9qRA8Ja8Mh/ImCfudy5LSSnXEEPQxtEOjpTCWcZ1mBpO5vD0gUEqglwMkZ+?=
 =?us-ascii?Q?lzybqwLzHEuWoxEc+gReL2Bymxu4ezKoPRdQA/JvLpcygl8N4I78hVw/vWFG?=
 =?us-ascii?Q?TaAOvTDoTcALknoUqYhmP2nKVaog1vm+BqbJTAr+KHoy2DKvSjMbWzPSVzgC?=
 =?us-ascii?Q?j6qmcTWzhl9J3c0haxcaSSkeW/9DwntcyJnoQ1sycAYBaadR4ol5hfQxHC3e?=
 =?us-ascii?Q?Fu5vH0AdruK/lPgoFOPxTOGV42D5jU6+EJBpLxwLmZK3/QSIqDG/QJI8uZR2?=
 =?us-ascii?Q?ULnPrmbG1I2orQyqBYGy7Z2D6kPFpXOaxr4h/ERCMiPb9PuZLJxRMLAW0wDe?=
 =?us-ascii?Q?wn6exyAc9HNbZF/r1CzJWuQVLReNyTP9ymxZ3/py8JEGCkVeEpVvbwrZk426?=
 =?us-ascii?Q?U90lTt4xpPxTBdTtd2TLVQa5CgaZ4ZtGFc3NZFaISdRo6jLX2KgOL8CWSkfh?=
 =?us-ascii?Q?QG40/w38a4JZwnBQQbLzjvq13tCLReH/r81RcauDGoooe8ecsvhCd/gc2MOn?=
 =?us-ascii?Q?GA6Ysz3gsJMdMTi5EOK8WaL6lUFVmK+DiYKfIseBz0ew/r8CM3pUpg4mCDER?=
 =?us-ascii?Q?7oZaISobBs+d0meNM9iIacSfN9+qLLg9iLBxX8LM9rvlu7EtTb67zwhD/JGb?=
 =?us-ascii?Q?EVJwDEAKaUrEvTzQ/5TYmZapKK8Whyuq1Zwp3CI4p3F6UBHHfEwwVY67186T?=
 =?us-ascii?Q?v0EjD+SzmC6N1B8xxd6ORtZW1MatGtmV209PBflQAnbhPpDpfLpFQTF7xagx?=
 =?us-ascii?Q?GCIW3wpBuJnfnpDVbVpcTZRVCCEmkbxnROL6O6cQMqv9698VJQglwauG6U7Q?=
 =?us-ascii?Q?boeoYxypPo/ek/Ry2s8NUOJpHlGB9ZHuxkGXqNb2BNjecMBJZr9gE0cu0XWv?=
 =?us-ascii?Q?d2bw6YFk64anNidTdo/vfj1eo/lEvv2aVhgm0F0s0oEn/TGYNcfDrQ5eteZo?=
 =?us-ascii?Q?w+vm7BtgGaJj7WeO08dIrugldzRHWI46WjzLVZQfEXiyFutkaKUN9v5kU9FM?=
 =?us-ascii?Q?yGVYeCxrJXUYhO3VN4o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56d87f8-f4b6-4290-6881-08dc330c76e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 18:39:40.6785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVzjiOZsu0mskOa1lCruc/eH+hp3IFL5x5hg4hKDbxNK9nckWtBlbmA+iw7B834K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061
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

The series of 4 patches are:
Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, February 21, 2024 12:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: add vcn 4.0.6 discovery support
>
> From: Yifan Zhang <yifan1.zhang@amd.com>
>
> This patch is to add vcn 4.0.6 support
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 704b7820c47c..6e4d26753aac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2140,6 +2140,7 @@ static int
> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                       amdgpu_device_ip_block_add(adev,
> &jpeg_v4_0_3_ip_block);
>                       break;
>               case IP_VERSION(4, 0, 5):
> +             case IP_VERSION(4, 0, 6):
>                       amdgpu_device_ip_block_add(adev,
> &vcn_v4_0_5_ip_block);
>                       amdgpu_device_ip_block_add(adev,
> &jpeg_v4_0_5_ip_block);
>                       break;
> --
> 2.43.2

