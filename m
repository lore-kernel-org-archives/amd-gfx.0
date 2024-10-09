Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A4CED62A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 08:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FEC10E689;
	Wed,  9 Oct 2024 08:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ypc1rDkq";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13CC10E687
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 08:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLqVJYkKvd7QnBTkpjnVS0g7YDHIY1k7tkHzGH9dC2vBp6btFD5sSMuKPkGSzUcw205iIwx1DvD4siPTTsO0o/XfbwQJtFZi5gW/Rwo2/KZM/t4RA4n17zZ3HZWwtIYK+QLG1eTdiphhzuo5I/+jfdI+yfqTezjwlAI2W+fDTvlc2K5mJLVniTQ1gbIcU5Duxef2VViBUcBSrj4mWsm4M6bC6d6yM8PMoZA7Hr0RAgyVWc1Gry4tFssczq0PkDmcQsf2grniTK6Gr27HdYOlgCQZIodyl1Vq4E2M4vw0P/bDX8JsiWNmXYHwdTvXxBKEBn+pyaKHLZVFXKRGqrPVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S0MGK9kPgslEp9YNnv4LY29a5RNkhunmLWbQDTE4GA=;
 b=Zfk0HTk/rqtcipEOAV+Tc7lye70HdD3oqX0bYAH+xDMQmT8STOqA4Zs+BOaAro1ya1lX5ssu20A5C5tC1KxtYtWoZu4ihGkfeJBqzb4rKZ3YvOoQvmx94dl9DdMI3NcDF/zOa2n8uV37LOFqG9bGRL6TOwdGQqlw6prnSYlzxOvBxAiTY8SuCNHErnTncsuo8tPCPM9dsLdwtXdp6h7e/4eURdg22MKjcRtsfXMRh1/IUmzaAM3Y9UgtayHMqbKE2+0YJCb+bcPrWAuV9n9lN0ewZoMUcEn62eBVGLztpmest7qTMm2sV0zmhqyVDpT6HXQjqionnVsVx5cNmmPUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S0MGK9kPgslEp9YNnv4LY29a5RNkhunmLWbQDTE4GA=;
 b=Ypc1rDkqj6tAeMVsfLjtIiAqm1hZ8rz3dzsU2ouXhOs9hvdr/JHrVfpzBtDEDeZX5tkQwk2EmBdqvkNcseyq0fI6hfQu/xoLfAPRXuJnI0UzPisTFd/KcwbvDR24q4XzQFeOz8UsxQjviTFEsBAepSqQx0cP9pNDzHlGy7KOTxo=
Received: from PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 08:25:51 +0000
Received: from PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a]) by PH8PR12MB6841.namprd12.prod.outlook.com
 ([fe80::8cad:63eb:fd59:940a%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 08:25:51 +0000
From: "Xiao, Jack" <Jack.Xiao@amd.com>
To: "Chen, Michael" <Michael.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: fix issue of writing to the same log
 buffer from 2 MES pipes
Thread-Topic: [PATCH] drm/amdgpu/mes: fix issue of writing to the same log
 buffer from 2 MES pipes
Thread-Index: AQHbGcKfbmKalbKjw06A8gFScFZcKbJ+FiYg
Date: Wed, 9 Oct 2024 08:25:51 +0000
Message-ID: <PH8PR12MB6841A72C8CE26A6A91105AE3EF7F2@PH8PR12MB6841.namprd12.prod.outlook.com>
References: <20241008204208.603265-1-michael.chen@amd.com>
In-Reply-To: <20241008204208.603265-1-michael.chen@amd.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=24852bf2-6659-4e33-aff5-2120d4527448;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T08:25:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6841:EE_|CH2PR12MB4069:EE_
x-ms-office365-filtering-correlation-id: fb44f00e-ba48-4068-da4c-08dce83bfc39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IdrIu31iw1Mhf6M+0QFHBCPN48GeRNXENWuSrBqXzHwirUjejZ45ruDpAvKv?=
 =?us-ascii?Q?tsDyRnFLeRmHDSNqAKZ7+ln2ZPKYYsiz+n2t6fM8cKc6lX247Drv83iL12qZ?=
 =?us-ascii?Q?yVQ+B+/QzuAPFgBrlMsx5a/nvjiizAq6+gy/qWiRbLs7/poEvPnd+OAJBg/f?=
 =?us-ascii?Q?jXK53bXKtSzGfPzgZa2HMYdYBJwfbSiHHqEWjNkLVmzKqUpOFSQP8V/qm3ZN?=
 =?us-ascii?Q?IDAoOgfLBWriU6aglYwQMV5urptYGcU/MWlHqJpyeS7BZtjUgQyakm+EUcoJ?=
 =?us-ascii?Q?DZQTkRVY4bJIEYPpENA/7X8sUQkECALFVFD8H7UomTj5GA3hkN0t6NhieCcQ?=
 =?us-ascii?Q?f9UZsHpvdyWcUEKPgKGrPzrj8VZV0rgFfcinj5CmUV6U4kaId5HMhnT2svB7?=
 =?us-ascii?Q?/KkS8qNW1m5ss1WL41mGiG+lJb7vtYaBjkaS7hLgy8uSdzhtOg6X++gn0uy1?=
 =?us-ascii?Q?GZDMrujH+8pcjInxqVevaZ0azpK1zksZkUikZPjdQ8AEvCaCFBf+QHMRLtJ5?=
 =?us-ascii?Q?p7uD2V41FnrO5GZrrHEIUK3ORZvlodePMYtTj5rpcpGvqqQVo2D4ScsJmiHK?=
 =?us-ascii?Q?Jubtk4qJrQGN2hS4JjxOVYTJSYtnI8kpnhr4poPu18mqIRXXt1cbI7wyeWvQ?=
 =?us-ascii?Q?KlJ45wCglaaNb07+CeAtLbKHbbW3p0XysKPypxrvG5sp5ioEA6qSne2wmiaT?=
 =?us-ascii?Q?JNpLRMFIV6Vd7W1pJ03InS0eQ0fCTfbi1WmIbU3U1RnPZdLWDHxVwUeLQ/g3?=
 =?us-ascii?Q?UhGJqG6M8Jgm31IdtnbGtQzQkqFApwMC71qW2+s0gLVfeCHe0wtFWjeAtFAA?=
 =?us-ascii?Q?Vf6eLf7yIm6rm5LIUoi4IOfKR9vdHlPZ2xrEzoMJY6cwR7cTrLReD92krYuW?=
 =?us-ascii?Q?Lww00meY3n8jLLkCypScHBHFBGeTse9l+dQM4YLgXoOfv5zz1U7BOBZacHXc?=
 =?us-ascii?Q?HOs+oEv7hUFz+iTFqRKaA+kErvqjPjlvV99umGr/qrBYqI3LJnlUFx6gxY0Z?=
 =?us-ascii?Q?aBsWRiu47cAEEsBkMXDUK0LH2hJlaeRkM83jpV8QIeaPe3oZyLzbDH9YRPYm?=
 =?us-ascii?Q?WK3prdKKyuu5mwKnjERXof4X+JTYTvo7Z4QuEspPGiM8+VEMuEjkbyt818ZE?=
 =?us-ascii?Q?NeVy4IwfDPDOiA4yX1nrMUVVVXwtq9RrKkOPq3oLxe+BAdz1LSh6zd9H7SWa?=
 =?us-ascii?Q?pip5/JDA+dALdYLy+JVErJh49ut6uuWXfSRyubmcor7BhC9u8zcKctSU/38g?=
 =?us-ascii?Q?+uBzaGFZHwc1jJCVXh8BasAT6iwzV/VCHtpeXNThdIM+xWvWQyechuL0syPk?=
 =?us-ascii?Q?ayXxOT9sIlFugcgw7cb06837cnwavouLunDPm6zvFtSdTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6841.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XKPCl4x1MP6WV8lcQnHE/7ZsCJXl4waG0yRscd/o0bJ7xSbFPYiLB3UmPyzx?=
 =?us-ascii?Q?YPnpk/u5jsGRpUpgxOEKI30BTnOXBUyxRInSwiNmcHH5J0xZgvFF6a4CVjc4?=
 =?us-ascii?Q?1pdjtb87LVH2xthGWwDY5MMkchoWqdE+fD1iw9E42WMU8KcRPsdRyH4zY1tI?=
 =?us-ascii?Q?/86lYNKhHyC8Rg2IUVeV87dPQMv4QaJij3X4J3V/98CzDXxlVG16shBpjBXy?=
 =?us-ascii?Q?/h1Xo5IyPepHxj1FVQLvvrgnQYcRdZ+QhAPoqyuo8WNm+C9LjiYNmtsgYYIg?=
 =?us-ascii?Q?ZmgojBBdVQaIz66S62rOUNGicbvJeB6iGF/9awUS2i/XV75k/HRzO/A7S4W1?=
 =?us-ascii?Q?X+ttls+EjxcmzeCp50VJ8oMC7pkQf/afvvy3QLBWJOGNOampGvlWkLxFsJbf?=
 =?us-ascii?Q?Wycbq8ig1Kj8eAwnsVXalSFOtMNzb7VeUVySedIwmWgfrfJInagWi1lEtm92?=
 =?us-ascii?Q?lv5OZYB8qTAUZ8WwZl6WGCDluAU52HjCH6TV5Cki6sYC/ocHYy0StVXn4FOd?=
 =?us-ascii?Q?6sMzqCS1ng9Z2AHdX1Hq4WzsQUoPb02WJeK+5NPOe3lt2dDGXmKTGtFfXp5y?=
 =?us-ascii?Q?IeI1dRido9i2PDOwjE5S+7rKE80rtRHLCX/7ZmblW+QvnvdFHGcm5OcBNWbT?=
 =?us-ascii?Q?WHUpc9RysORpd7F+NtQ3LNimHojyoNURMZgy/z5usP3DW8gwZL54aaMoRg4e?=
 =?us-ascii?Q?g5jsiyBA+5gLZfmvsZ4mRlEb++9jQXHQT/NxLUCVpDYq7znicP16Mj4eHgoK?=
 =?us-ascii?Q?zs5QNBPaiolDHWOr8TngWVxmBX+sglUoM/KcJLWzR2ptxWx9naq7/fp9U1SP?=
 =?us-ascii?Q?2259P60mhHwLp4BWwHZQJbtcwqI41rt8xJiYFs5fNYt2rX7L/0EPsBUZqMmB?=
 =?us-ascii?Q?3QEj5gf85D1UgCnKTxHMefGc26fTkNWYVI8MBNQeK4L+uUGWWZwpBG+XT8NQ?=
 =?us-ascii?Q?iUvOyKBRA90fz3PrLwyAJaqbT2FEX6EjABOqVXLMIiwzT/ML6WR8Twn17Bkn?=
 =?us-ascii?Q?w9Uz/j9jqKf4T4a9NUdqDA9OGZnvdU8Le8Lk4YSps8a6TztEaRXjw2pkKXVg?=
 =?us-ascii?Q?+WSxF49rA9AEZmO03xv9K4i8RQXVamYVkzA7grIfWvTn2Ul532zKnHEU9D2v?=
 =?us-ascii?Q?1F6h3r59P1IRszsNm61nAT1uXPzHWdF3LrtQaT5xM8zPqCutR0OgoOwsiUV3?=
 =?us-ascii?Q?XlyQZxn4vgyuPtSJLfxHAyvr8MMxwJDCxleg+V85U942r4dewwVE6Mz1wdMu?=
 =?us-ascii?Q?RX2VaWO5s+kqDJmPEQqi/Y/ns6Hd29OIPbD8fV/RLRcT9oE7m5PIm2mvZlR1?=
 =?us-ascii?Q?Y47vT2z1tZu3OdSMt0hzCGrgNChoI5fi3MAP4Uf6/mo3pgo42pvb8LzESebu?=
 =?us-ascii?Q?3taeEMegmqXieHrR+rYhciXS7DPKSUfofq2TBfd2t7PxnYYPB4VOhbJRUHHT?=
 =?us-ascii?Q?tablzT4Gm7ZUsIdYxhEngwzFTo7DrwYP7AnBtly8QBfBoCfjS7L3kBHNmbQd?=
 =?us-ascii?Q?jk0PJFAvMInJvdx6UjPosZwvNbFXE5C17LpXQWQumEIgNqgdc8IVR/zUU8Fr?=
 =?us-ascii?Q?O8Dt0s0+XUf52vjKSmI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6841.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb44f00e-ba48-4068-da4c-08dce83bfc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 08:25:51.1697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsMw5a7Mf7B+hyOkVB3OjjcT7RXFAKEJYc7wqKclAQRT5Yn1VLQowF84FnzxY+rt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>

Regards,
Jack

-----Original Message-----
From: Chen, Michael <Michael.Chen@amd.com>
Sent: Wednesday, October 9, 2024 4:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@a=
md.com>; Chen, Michael <Michael.Chen@amd.com>
Subject: [PATCH] drm/amdgpu/mes: fix issue of writing to the same log buffe=
r from 2 MES pipes

With Unified MES enabled in gfx12, need separate event log buffer for the
2 MES pipes to avoid data overwrite.

Signed-off-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index f50071cf95b9..3daa8862e622 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -621,7 +621,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes=
 *mes, int pipe)

        if (amdgpu_mes_log_enable) {
                mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
-               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D mes->e=
vent_log_gpu_addr;
+               mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
+mes->event_log_gpu_addr + pipe * AMDGPU_MES_LOG_BUFFER_SIZE;
        }

        return mes_v12_0_submit_pkt_and_poll_completion(mes, pipe, @@ -1336=
,7 +1336,7 @@ static int mes_v12_0_sw_init(struct amdgpu_ip_block *ip_block=
)
        adev->mes.kiq_hw_fini =3D &mes_v12_0_kiq_hw_fini;
        adev->mes.enable_legacy_queue_map =3D true;

-       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
+       adev->mes.event_log_size =3D adev->enable_uni_mes ?
+(AMDGPU_MAX_MES_PIPES * AMDGPU_MES_LOG_BUFFER_SIZE) :
+AMDGPU_MES_LOG_BUFFER_SIZE;

        r =3D amdgpu_mes_init(adev);
        if (r)
--
2.34.1

