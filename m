Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B3CD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A3010F9A3;
	Fri, 29 May 2026 06:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Z9ImkMP";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA6010F9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=labsK6fZM9UIlBXt9/oWiYENJ/w/olcEUa06dvnsCSSrpaeSuomss1mjuil7BoHQfLfWGhH7yZM2xAwbrwBA86SuQyOQjoQhYI76v70gS9MKWG+f7wh6CA2qVv/WywOXhGp8bLRtwk48RT0acYqehma3noRCEJJGzrFSnRaPmLlvkbFG2DhiEv+5F66j2Qe0dISEN5pnPrXfbqCTuQVmSbwSbrPRgVLH/FDUFpJSMyibpy8Kytw2SmVPsjZhkHocEIThHpsJVcJQBUKr0t/xgWodGhpKzNwSPTEkjRioJX5OUuvx0UdgGL+wK4smAHpucquTjknU13RytuH/eHeK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cVuKxU1oiigAS0wPtK18CLKCWoeafnC7X0V+VvpB4o=;
 b=e6Jeg4YFhtyF/8aBy7KdadIF9pBf8MAIB9xl3P5BJXxfuorMXzory6t85njJPAkutYvyqszx0tizKwWqbP/strD88YaDZixd0p48kVjQq89KE7o46Oo4lO38wubBkOuaFkNpimYMd7sGozSFIRakHVA3ZYeRfLLgbw0iRUxroGQZ/Puf8c055z9cXjWJ78HXUJBQIFaHgyNtilCdmqSI75BzA4ah3sV6lROGotaDlS3eJ2PgMQw3iyj3yxgJR5L0AxK8IBT17p+rsJ3mC9BkWsPjAZV/vSFS8TL3mARofOaJvXTogaEgk6MA7f4cnbw3k9aSqV+h9IX/0KuH9Cuz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cVuKxU1oiigAS0wPtK18CLKCWoeafnC7X0V+VvpB4o=;
 b=5Z9ImkMPqGNQALqa2OVXP5VUvbmrh5VSwzp4bdjRd99O1lmIVQHNb8/K1d6ZvpwDJK/hV+uokyF8WLZ+9R/PDvPFwG+vOiP0pMjgARv7VBIJxyosu74XzVV7yTN39Zb+9h4PxCIqZaS8Y+7Qg/KjaipAP0ej7GURJXGifryjShU=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Fri, 29 May 2026 06:55:33 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:55:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Topic: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
Thread-Index: AQHc7zL3OcbT5I3dHEufP0x0EAzU3rYkkIDA
Date: Fri, 29 May 2026 06:55:33 +0000
Message-ID: <DM6PR12MB2972B5C6F3EACBEF419362FE82162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529061811.357041-1-asad.kamal@amd.com>
In-Reply-To: <20260529061811.357041-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T06:50:34.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|IA0PR12MB8421:EE_
x-ms-office365-filtering-correlation-id: 763ea718-1803-46e8-ede9-08debd4f477b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: WDJUqBUXlUfaQqiH1Xuoz1NI49PLCAfPmgFk0bIOmScMDkIpOR3o5XwufMhvaicDQAxwdGKTbCZeCzQBNGanKAc8NzUWMXHzbteAyjqXfmqJoKBCJ/u5bQOSlVZJCj3wx6VIWTQofyRejcUl0FaMxSp+ewdo6n8RYJcibbnHOnkabtIAFK/t/tDCR2NLTUuUGD5fwVwimehr42/X5THh2C+M5eDi33RwmvfmvJg+uxqLgFU+ifeplmKWtOFUbFLZgWX4xabhWrEYYn2luLzhWiKoxDfv8YKq7cqod40V6zXqCBSvlKIJvm5e1uwQxIdk3tTxs5gTbHyGkGMWnkp2E0QVWHeHDHwldIKMBpIAwoCcEpiOAW5c+PAlia1tv3Wqa3VFucvRtRruJ7nSdpWSPP0ETKscXtzHoc0jIFMfDqid5IttWdZi/KmNSMms8iniXXktkDTGcgqbgaoACL/75JR6+FJo/RMFJmj4sJzRknV9xcBkiA+bx4bMpVkhmnHajku6gDfs941WV9nVM/dtmrElWiBhgp30epMhgmqs3ca1hvC5Y3DRx4ou8NYe7Vi9wPhgTtAun/18P7QBJvFM/r41WofpHrlQYPt7g/HR1q1jJ1ypfQA/erWXe/0tkyqc7+yJrTG5+wPDlpd7P2wUYyFswHi4229FDQxqH/j75senAPLgk0hGRvdFdmMP4kvjpVsoHQhEnz++YVJb3v3IE/dXCzKP0KtnscBnSuFxA22IuJMV+LR8kJ188pXeDd3H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jDqJ3KYKR57AdSICPfuwUEsi0MbxuCPLjbPyLiMLrv/BrHnX0gAImWoWczaM?=
 =?us-ascii?Q?Sazb2f/oCtFceJV+/fWAi9PWKFSganhtp9/2kFfPAjom9FJ/O2dlDc+Ra2V2?=
 =?us-ascii?Q?aV0QVy1h+slLOTZPFYiPLL+ie2px44c4ZfZgu8cE/ACpaXyObhR67vUSv8Fi?=
 =?us-ascii?Q?HNge3+NDJ3zDWjPnL8gxLc2vhR+DV49D5HEwFBstXGVXcC1iZ2zRtwwCVwdD?=
 =?us-ascii?Q?HdtBpTVQd6lQ1Rxtr+GLs8Yln80J17qUw5zKnq6kFiaNy6XcfTCxNISz69AC?=
 =?us-ascii?Q?Y88VlGUDYnxcg57aiRIMnpiOfrkp1MrLWAw5Tj9/sa2rEv8LAaoBQlGW6egX?=
 =?us-ascii?Q?yNfET+ZJ6cLjPyJhxb/LnLr9FLwBiulW0cHKkk3VDDX3t2EdU4DSSsb7GvYd?=
 =?us-ascii?Q?FNP1Y9/5LR338nGQtHDdUANg4rvFiBo9fTBdV8jShkhETmpEopF5Ars6izen?=
 =?us-ascii?Q?AkcMNupkjE1tywptAmXqxThIiuuwoioveGCGVds+jvBAwDCbvQm27yTlviwj?=
 =?us-ascii?Q?b2zH+H4BCcbXEHRz4tksyQx0lfqSLsZinK2Rvk826SxDR/vk+y8JCfwOv0YB?=
 =?us-ascii?Q?nInWklv+/vMq1Pd5QBjm1bt5iNOMPtnwWxGOq9UoMNO7DTvwSPUjR5Qubkaq?=
 =?us-ascii?Q?MttX7gMBI+oAeo5wVxGTCjMzV7Eap/DLzFz/hmiFnlZJGz1mwWzksNxuBw0y?=
 =?us-ascii?Q?x2XakA1nqwt5yHJv+FAcccyZAzDbNkT9pvi3ww7gshJHt8D5wLW2W1dfZ46C?=
 =?us-ascii?Q?qAMDtiGvy/NwIz7EhF3YEFItRm7ousMNm3bf2JCl7YNulpFIryzy2aQ02rLv?=
 =?us-ascii?Q?AyOxYFEc8Cgi1Wot8ZcxqKuBIoC3gkTlLzTLwCgc3ujWBmLg+0hRpZujv1Rr?=
 =?us-ascii?Q?fPC8MAKWHBqYc9Dk1hx+JcQSh4R4K80GwLJpg6r3jfHvSRiObIby+Wy0ct/b?=
 =?us-ascii?Q?yQvbXR0CK0JMW+69CF7gEVuyxaBMtnbPPHnmToK8DwA513E9x04gqB3wnZUG?=
 =?us-ascii?Q?UCv88MGAZYfoxzHn+U2u7k1uugXNbKifj7MtbI17UVP1oIealG1pB0BZmtx8?=
 =?us-ascii?Q?7ohFwhfo8SatQ6M+C+9ZgDi0qlL072YLim2SPaSkwpTBVNYmWY9AlsUo90Bq?=
 =?us-ascii?Q?Bb7A8gcgZDMks9NeWx8qviCdeN4aRy6s4TpgqC+CKOPXTGvQtuT5j3Gr6fj1?=
 =?us-ascii?Q?PGxH8ht3iHyumLqOS/XcbaOfdI3PVPDKc2d3XXvZWc94encyu5gENbi1z08s?=
 =?us-ascii?Q?KwaejzvLAopbXOcHKHtBQVy14iq/R2AqMCDiYaIztrlydFmK5fsqy84ia4aJ?=
 =?us-ascii?Q?sHmHzVR7tLr6IfGZcd1JL0AGARC79m48Iyj4WdmYoLbVyyN9OXlEV4X1AzHp?=
 =?us-ascii?Q?T4Q+ZTZdutbm4QTVRNKj4T73AktbjZX1i5racoMLk+vXkhsDmqaRy9yfQEpc?=
 =?us-ascii?Q?NhdPsL5ZKy/GNWWhkfLlaKbxaeec2UUDx4VZjC8g1sQqURzrI4OhGYQx8p5d?=
 =?us-ascii?Q?gfem8CsKPDc9RDZLZ1PJwXV0AK508swirIZ6W9/HNH432oEFc11DJ/r0s5uN?=
 =?us-ascii?Q?75OL3uWRjKRJnLa+89jSuiJY+w7OrJIZOYFiSBRXxOZoS8/RZWCYtfzVdiGZ?=
 =?us-ascii?Q?dGVShBVeJkRjTElI7cykxVN3tas+zqU/B+C7170RBtQBEmYTQ9ozrgzNN9QM?=
 =?us-ascii?Q?JmzYee4A5iU6fz0hmBblQex0deJk1MV9a9+PlEXXbfby5bKw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763ea718-1803-46e8-ede9-08debd4f477b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:55:33.2072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woCz75McYa59LL2r7wgQV2Zj0X57RIAVHinVFNfGLb/sZMptqMhXg4Jv7oX7oSJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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

AMD General

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 14:18
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Kamal, Asad
> <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: fix off-by-one over-read in pp mode
>
> After consuming the leading profile digit in tmp[0] and skipping i bytes =
of whitespace
> via *++buf, buf points at original + 1 + i. The number of bytes still ins=
ide the sysfs
> buffer is count - (1 + i), not count - i; using the latter copied one byt=
e past the store
> buffer.
>
> NUL-terminate buf_cpy before strsep() so parsing cannot run past the copi=
ed
> payload.
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 60db9b66d08c..450ecb188aed 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1379,6 +1379,7 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>       char tmp[2];
>       long int profile_mode =3D 0;
>       const char delimiter[3] =3D {' ', '\n', '\0'};
> +     size_t len;
>
>       tmp[0] =3D *(buf);
>       tmp[1] =3D '\0';
> @@ -1391,7 +1392,9 @@ static ssize_t
> amdgpu_set_pp_power_profile_mode(struct device *dev,
>                       return -EINVAL;
>               while (isspace(*++buf))
>                       i++;
> -             memcpy(buf_cpy, buf, count-i);
> +             len =3D count - 1 - i;
There is still a risk of signed integer overflow here, please review this p=
art.
btw, the variable 'i' may be greater than 'count' ?
>               while (isspace(*++buf))
>                       i++;

Best Regards,
Kevin
> +             memcpy(buf_cpy, buf, len);
> +             buf_cpy[len] =3D '\0';
>               tmp_str =3D buf_cpy;
>               while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NULL)=
 {
>                       if (strlen(sub_str) =3D=3D 0)
> --
> 2.46.0

