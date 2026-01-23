Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF5DD6CFDE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 06:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F6710E237;
	Fri, 23 Jan 2026 06:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUh8YG9r";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DA610E237
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 06:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLTY6gyDbi59ox8CF/HwlpBDShuAW+Mer1mucj7xLtwbl9OVqH3LvN33kD29ukNBxUGrE/2cd7JAmsVcaBfut/T6fizdCre8k+P/hrKgZ65D7wUzlJjkwPr1iTlOWpkGGtPsN3oEI27XV+++fqDudJRf38QLx7Lhs1owCu6WxcCSeQU0vCYrAD79ELLrIo30G6eVUlx36BjnmUeXCcjfXZFrgUsV9lUuHS7JRjRX5kOQQ38w/Xs6xLJQYdWSbW89sHndbEdDQ6yYeD9UnGLdF2BBtJNxFuhqCHnMPkIoonOJlvONVeSQkbLuJNvtGrwF0DFWzImdozbEqWcYaLZKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVjSl+C5RhAeFg+sxEnG5KtO616R4UpQ7flEeQC88bA=;
 b=s311kjICHa2eLdoTCvRTj/ErslPQMK2VQ0nm5kJHojZwJWfdv/Cvy05C+zWY2cnYc5l2wErCE3f4AuB8cEErqgrfbNX7phqqodx1x350ORqmwIUQyP5XRRpiz1r7F3ZEqNca6ZXBeznMNaXqBB4B610mxI1BaRbOGuU2mTW06ux8xe6FgV9uRsTt4c8ux4oG7vmCFeJYzC3KLpDDQuO5mjDVea6t5+eudVOCrbidijkRailAZ2OUfHUnMcQsrIciyw9carY8DHPeWMoEJq6ziDa4cU9Ilm+2/RWA5KLDwH7lFlpUhB3bZ03kzsVUnrmjC7yU/B4IcuiuGjz/6yATyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVjSl+C5RhAeFg+sxEnG5KtO616R4UpQ7flEeQC88bA=;
 b=XUh8YG9rjvK0NmOB+OeTDBiOmtZBh61zzhizbgucmnW3qmNwlzjoD/canmOZsnjk3QngQipi6w4dYMPD0rAnQNCGtydQDETryeT/AcGFa6IixOHwOKs8yFBc+rNx6mPmjFfTH6CXyYF5l78kWHE7pIoAsUurjqlFG2jAu6370/M=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 06:13:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 06:13:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Topic: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Index: AQHci7NcWqicV1uOgU2xzIOvuGM2iLVfRk2w
Date: Fri, 23 Jan 2026 06:13:56 +0000
Message-ID: <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260122152501.351937-1-kent.russell@amd.com>
In-Reply-To: <20260122152501.351937-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T06:09:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV3PR12MB9166:EE_
x-ms-office365-filtering-correlation-id: b7889ae5-d3f5-449d-dc7d-08de5a469726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rNtVfge7DTts959NZwm8QQpmj4dw0hV0X10tDHlj8OsjoSdI6hpHXfwy1lNt?=
 =?us-ascii?Q?NXW50KBxjs8mTtU5hb6UnzC+lPtQfmvtg4uKfmdHNOo0kqKotPig8fW4WL70?=
 =?us-ascii?Q?m8CGw11NDcBTFRNRC8VfyxzxCFbc1ESzbMm2UsJs6CB39XKoU8dnDsOFYiQ/?=
 =?us-ascii?Q?yNAHSb7UkJerkzf1YHsVupozpLb+2L8dLEa5n6chzWKmAGYMt6/XK2CsE/Pr?=
 =?us-ascii?Q?p/E4odU15nWH20dZB8YzKntLwmui1b0q3d4sHFM3EigXdbZRIpaD4g8im9xp?=
 =?us-ascii?Q?CtbiFV217gbGwRBwerSnEfMxSdfT3Cy8c6ZHSgerR/AOfK3vDJHoHKac+BVq?=
 =?us-ascii?Q?OV8IlwNSUIVdcA6IanT8mes4t4da2s6M2rgOWUv+rbaE/m+rGfZT0RvRmDDy?=
 =?us-ascii?Q?WDfwT0neS22Ma6+RiOvtFyKBKN8E484Ksndl34G2vHVgGLRkviO46KiGsZMS?=
 =?us-ascii?Q?S35AQKGibmb/WlFJXG3RD3g4yHPU/9PeDQ1NPZWQkOps7ELBAwdlRMRoBL6y?=
 =?us-ascii?Q?9gLGw7XnMQig2Nv4CfJe7dzvkbuTQl80+Wa3jRITBJl1/4VePmQf/9HqiOv5?=
 =?us-ascii?Q?TBJIn+9kGMWGRGfUbqGoOPd1Ef4JguokIMQBar/ZmqhC8Rzd+XODSMl9qu7Q?=
 =?us-ascii?Q?zOjiZbM3v1iVeE5D4nYJonkRX/QoCDYHbMOXhLwzgf+JFjacnoe3MOSNyHRg?=
 =?us-ascii?Q?HL7uzsmo7hRiLOCd5F6xmvsyzCzaZFdX0tvQBuo5B9Ic1eZo+hi8EgGHTKOE?=
 =?us-ascii?Q?q96YoAV1kbK6IJYZH7gihyCgiPzSn15lxF8+SuKMBngJOoODZCVsOZGtRL7p?=
 =?us-ascii?Q?x8EYIA5hEncEKtgJ6lOONgoTWCZZzyOSYOMc/IYTbpyPUo2SMvAH3zy7tQwf?=
 =?us-ascii?Q?71L5omJokaa1WA1RJFyr8GqM/LJVLuVz1abqPooqzyCrDaVfP/XYTukz3/Sz?=
 =?us-ascii?Q?yfOH9BOfakvDax7SYXlZgbeE6/JoO4hEBwsN/wE5jsxYnXKcSD1jZk0UvWMG?=
 =?us-ascii?Q?4eBpIN8z/gEnZoLKgksLPeynDB+N+gXMrfMWlgl8xTvx+AwaVGTQ00ySPbHD?=
 =?us-ascii?Q?llLWPHLxuoJBI/ehWwMa/RFYdeCBZlHwuVxFl+l1tIawz+l2+FcWRysN8txH?=
 =?us-ascii?Q?cu/M282Z+VMqEljwI5nS++HmZtweg0KMbM+phe1K/wMeQnLQKNcBztmq3T4X?=
 =?us-ascii?Q?6zNPOEnY2GDe7i5UPfthxxPOsn0NQLpK+Ws3+UBr0t45FcEAqYd0S+/x9e4N?=
 =?us-ascii?Q?0gPJWhOGdc0BT2UThJSunuUZIl/hQVVWsyl4QHl8ealxQBtMPHeArQR0j6e9?=
 =?us-ascii?Q?oxexD9ouzzlokqoLYMUATkYrNevGj3bwvcrtBRapPWSoDqL7LEcyS4UI2Xeh?=
 =?us-ascii?Q?xAoYjdRNUrz4bavThVLGzyBzm74W7/qHvzmU8YuyIf0D2H+KNUJWDIKfKwQu?=
 =?us-ascii?Q?6Y0BbSNiQd7sl/dP9wAOAVUeo5fbqoWKufxaziJmM3KSln2GSSeQB/6J8FBC?=
 =?us-ascii?Q?GvpB1GiIompycTyAF+XM1g3uz+vj6817bp7PTHc1DDm4PyMhctqfSi1+QOnc?=
 =?us-ascii?Q?UV/wgau9nqeesRu3KAZGq/HPLMjxqPCN0PgP5WXhYh5bcIBbzdTY/obfX/Pk?=
 =?us-ascii?Q?Lwx219+6GYDOheRs4EjLwgY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28JqvYBsco3cbd3SNULq0m+EiXQ+8+1i6yxXt3AJpZbzuI2WdIIWsblst2CL?=
 =?us-ascii?Q?GS5rSfkI9Ycwd68I0VyHBGXOwc1Yt0gCskwqhOG18SOLklvTMhDkLJyKJFmg?=
 =?us-ascii?Q?tWOfHljzClvzJbKIOJ1F7eDhsON0H5FtZei4ytnEMLhVNObJw0zNxnSUPlq+?=
 =?us-ascii?Q?HarhqcH9NW302fM88rPdsMgkrM7Ulm/ZGHNqa8U+M/qKIaxd6WcgMiqPqHeZ?=
 =?us-ascii?Q?UhE5KoFSQLg3pgZxCSIi8Z0kmKe4Vp9WeV5yd4ATYVxip6ZyMgDSaQub19k4?=
 =?us-ascii?Q?9QlW27zuZAkmi8D5eLje+G3KlwHKVIa0EBFoznmztvh3cSRwc5IKc3KTwzo8?=
 =?us-ascii?Q?fIWiaDYjvB2UwfP/BrwXxTzIGkjVCZC3KxwkzaYpZMXlN5QbpBa+9hhUnKaK?=
 =?us-ascii?Q?TItEA7ZAVSZWwIkGr84g9KtZfPAPE+4f1Lg7kdOtULDepQb7lDI5meONyIAZ?=
 =?us-ascii?Q?7+3/xfi5FxOBtcqryMR9IDqul9i/dYT4o6oEcOw/f8OTWwUGSCtDMIAA0yKY?=
 =?us-ascii?Q?LEjgLe+Fd1npGd+UOVRY4QLPi01FPD7ERV7s71zF6vRBEWsXfkuq2PX+2b01?=
 =?us-ascii?Q?1LiLqmD5LpKXlegufLBLeMfyLZLghTrHMETYO0g6zkxvb30J4DSMKCZDPr+h?=
 =?us-ascii?Q?L+ul1Pmr+D7/G57EhIZUXzGkgaVhwZ00Rr/QKNxnTWCN/6DPerX6njp+nQ+F?=
 =?us-ascii?Q?D0GdU1DM4+KklWdgSzgoH2+1pXx3ykV7lPUyqsV11Eu56djkJbdOjzchW+E4?=
 =?us-ascii?Q?ImsJvoq6GLtWkkU66cr41uenukhkyNVSzNMhdnKXDkO++/sqHb/dHRTfJ557?=
 =?us-ascii?Q?tgZmygOfopCoQBNzxX+Kqq9jvbmnSIc8axoZDeyBj9/hbf9e3TjJpdr1w6Y2?=
 =?us-ascii?Q?5RDdpANoUl7vAaYJAccR07YanBOb9SyfyCxuXXDLG+ub2tSP3z12JHXZsdFs?=
 =?us-ascii?Q?ha3PH02omecqa//u85nUNUsSZo+EpQD4QnJ60nDPbEmj7UzToAB6zt490mBj?=
 =?us-ascii?Q?d9R3wPWRNUMxGhBZ1c6e0nMw7vrP2Ij14a0WxJuNq8uUhkulcbm8jQOPDUbg?=
 =?us-ascii?Q?2nJCbqjU6Wdn8Z9yajmYLaXuOHnYBf6OMiUGWLXJzO8gT9KH7u0QRCKmixee?=
 =?us-ascii?Q?YhXoHUZ0t5D/xOeCjUbBtVu0QKaiHWzjfGOY9hBRaN2lv1Lr02YkS4Bprdbs?=
 =?us-ascii?Q?gBAOvCytkiYC46nbNHgN8JHrX8Q5au+tPK3Ru30MVNMBRqSCnAVIaKwUnILF?=
 =?us-ascii?Q?kIBCRaITN5viW+vcYfkuCf1pCIzyPbYb1yhGgnEg/WBUiE1ulab1nWHf/1Il?=
 =?us-ascii?Q?0vNOQZG90IERJNTzFq4sCRgFpYw5TIlMmHeJLFntM9QEF/xtghuzoFjwlqxN?=
 =?us-ascii?Q?pML8X/U+7uC6gb3pW68F0OUGgrVCuSExe4viUWRymzdy3ObUR21gTPCls5cB?=
 =?us-ascii?Q?kxwKXWGPl8V3mEt9BjcPjhHP55JdngWgSopAXmpAd6gYOxc+3oHnTYsZ8Zg8?=
 =?us-ascii?Q?YOoVIuHbF/40gPUlK8rSXxdi39LedtBAi0YYlXpjNDaF+DYSrPOFF2F5EmL+?=
 =?us-ascii?Q?VnKufBcD69LMGQICYgibjx7vs757t1Gz1QQsfuemZ30WVcVBrbtxtnQRctRM?=
 =?us-ascii?Q?CFXxokxkgjP5CKDXe5Y6AjOW+gCe6kqn6y9a6V5h8llOnpX/3GDoIfoHO51O?=
 =?us-ascii?Q?6Z1OmtmVlI08VVm1TU4GvGlsAY3E3NeGJuMV6bM5zmdSIwqm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7889ae5-d3f5-449d-dc7d-08de5a469726
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:13:56.2741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ftMabGgVy60L98j6rrxTtu99N4TnlojNXyVLEmxDaRa7LzXScNVMGdUKy8zurqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent R=
ussell
> Sent: Thursday, January 22, 2026 11:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
>
> Some older builds weren't sending RMA CPERs when the bad page threshold w=
as
> exceeded. Newer builds have resolved this, but there could be systems out=
 there
> with bad page numbers higher than the threshold, that haven't sent out an=
 RMA
> CPER. To be thorough and safe, send an RMA CPER when we load the table, i=
f the
> threshold is met or exceeded, instead of waiting for the next UE to trigg=
er the CPER.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 64dd7a81bff5..469d04a39d7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                       dev_warn(adev->dev, "RAS records:%u exceeds 90%% of
> threshold:%d",
>                                       control->ras_num_bad_pages,
>                                       ras->bad_page_cnt_threshold);
> +             if (amdgpu_bad_page_threshold !=3D 0 &&
> +                     control->ras_num_bad_pages >=3D ras-
> >bad_page_cnt_threshold)
> +                     amdgpu_dpm_send_rma_reason(adev);
> +

[Tao]: 1. Better to add comment to describe this special case;

2. Do we need to trigger in-band cper as well? Like:

if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
    amdgpu_cper_generate_bp_threshold_record(adev))
        dev_warn(adev->dev, "fail to generate bad page threshold cper recor=
ds\n");

>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
>               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> --
> 2.43.0

