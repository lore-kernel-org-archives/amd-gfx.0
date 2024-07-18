Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5CEC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 07:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98CE10E592;
	Thu, 18 Jul 2024 07:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VoSekbX7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60AE610E592
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 07:30:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtSbI+1Oh45O9Rgf9njln8lrLj20w7blOXHkFifys1whXqkyj6KiUQ+9m+4MiQR0xce9gDnR+dUg8+j4GF3mrrgicr7fm3F2zi2U7X/lFfFP+hG9vlKeYnatFTkX7D0IH4eycysWh/dDDI2vgQ7H0XxyzoOSxRNQB2JEXwS4TxkHov/nKsYr3Wa/4uyboqtrd5TVmJI5a7fVfYdVCbwihc+7iT7pUBZh6CXZJ9P3oyQ8co5R7jGjt/h4D/xmtXC6lX3Aertt2PcPMWqTWG/Om0C3G/FPCDwOhgcK2CGR3Fho/exvrRgYo19ZZCrjUVySkQ35A5ZlvPsJa0DZnKqc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYtEtZsZzS9rsfnS02MRtrZ9lOn3Uz/YoWHRvknfq1M=;
 b=qBJWiaPVzurR8kJb4E81LOwXQ/s1P8Swnc3EjnXetCxtfVHOeL/XTekZMlYWNKba2Zkt1OpsKT3atV5rA2Nfwpkp671n5/RrLDM9kpqm5DYJSEZYBivh3sY3/KBqbuqVmvwA1UUavCZ2PYW7SClQ+BJsqxRX88pJcF7KaCY9pbkZHU/s21NB+vdkCe87swxEkyUhSCRirAQhbDFwfFCrzw8l0f/UYhIxHQr3ZkLS7fCGJ3Ycx+p/KaNzhIW4GE9D6rxysGaZ74RlwiQKLzZ/xC9ovYfJ2yvWX/+hMYBW79iLP02SX6XlLGh/D+HcGEa2KDz1a8TmTkGBnuEcg7DeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYtEtZsZzS9rsfnS02MRtrZ9lOn3Uz/YoWHRvknfq1M=;
 b=VoSekbX7R7bhwXd9egkIWSSKcSZpvLoyxrhE4Qm6ATTyEcxENCExfOAannLVxybect7GFdO48C+ud87fu8tqLDO72HKarK793vFIVdPxlNawKURz5jKZWFNuGcA+xKes3viDpbxTPTNoDiu+lmWjPLd6NLFPiOaPMVaAZ3tLQBI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Thu, 18 Jul
 2024 07:30:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:30:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Index: AQHa2MFonsg9X/o4Ck+3ZnaoWDju3bH72XuQgAAEtwCAADkBkA==
Date: Thu, 18 Jul 2024 07:30:48 +0000
Message-ID: <BN9PR12MB52577AF9F78F1801215DCB67FCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240718031932.1353653-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257199C05DE3DA98B4853BAFCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB7988B3653E3FE2F10DCE83AF9AAC2@PH7PR12MB7988.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB7988B3653E3FE2F10DCE83AF9AAC2@PH7PR12MB7988.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9879bbd3-390d-43fd-a2a2-f97369c1c448;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T03:49:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6595:EE_
x-ms-office365-filtering-correlation-id: 31802faa-4a92-45ee-d35a-08dca6fb8b77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uXhgrjZVJl3+wbsGd+AeotLMcfLC54GN6V15+m5u/WeKjm76jOY1N4tRC14p?=
 =?us-ascii?Q?kRjm7ruo3brdb8/h1uF+H3K/bCJ0gVNgrVS7bMRKuSx3uO0TUK9wxZWCXv2Q?=
 =?us-ascii?Q?9y5E/tq1q66GuWkSMSUyElriONsctynjslAxvbw0NPlTsdbEVk2+ITZ8noFn?=
 =?us-ascii?Q?6tYNLvyfUMz9+veIquGVN+Wzx/Z6Dce1N/3E/6QNQPyuv8O68sERs52jElYc?=
 =?us-ascii?Q?cL8tpqNLc78abnoIgfgsMyMKWmdzfJ6FLSl/g/OURW8Bq38kmBFixnvY0Kls?=
 =?us-ascii?Q?Js1of4RrzYKEDZycnGBJFdUm/uN8eFD15Ii/Bsiq7Sx03DVqbIxLK74qVW5m?=
 =?us-ascii?Q?VO1D4KqklMLdAkH7y0MwkyYeEGavZ+1bFCN/0i6qA/k7A1aeSFTJ99GqDU51?=
 =?us-ascii?Q?+VD3JWQQOExi/RLbvlwfWW6oeim9QcbUtJ/tGHd1y4lrjJPwfzClEtnKwElP?=
 =?us-ascii?Q?e0EtZU25UyaEU5S5NJqxRAr0zoZAdKPD0D0tw/rELBp13Llcmzb/RndH97GQ?=
 =?us-ascii?Q?Nh8VCQI2VxAYt2K3d8Uk8Xqah7+Q/n0cjdrhcXSKwuzrCxX8dosMMFzG87p8?=
 =?us-ascii?Q?BEZfpGeKaaQP4vEwmLCarGoaHkkckvEq0FjMWpGG/OFDSkLIrX/UXQbWtHrh?=
 =?us-ascii?Q?c43FGOkee/2AxFOmT3LkdkBSYc0ZN/z6XL19lh+qzfswiBoWYy5XKUZbtPel?=
 =?us-ascii?Q?buwy8EwkvbwYJu0nVnnO8RqEvjgOvbKG8NDycj+KaSNGVeO6oNya1W3WnIpN?=
 =?us-ascii?Q?nqQbJlIuW00jDLnUHoEedBA2nXrFsMo4G87+I+BCMmVzKvjnyUSNK3iaDcsD?=
 =?us-ascii?Q?pR/rArKxFOJCxq6CDPwqyDz/oOBDa3yru7WMKT4SwufhER6vy/sUySd9febH?=
 =?us-ascii?Q?wiyJ+K9CWQQUQ+vVkw3fmJzyBKUdf4iqkwXdQqQPIbVMVIOm69kTd3FsttSg?=
 =?us-ascii?Q?GNFRY2JKJe0+72fgGgknBAqw23EnR+/qV4XBetqmeRYqrPmZ6FRDjNsrJ4j5?=
 =?us-ascii?Q?0lN8pMjchiNbfZCjI1EcX4xjzz5iWFDnEHEYgZhDHQnmWZsKkuTI7pPrcdIc?=
 =?us-ascii?Q?xI37/UVFxfdQpqf9yWtKY4nUFUxtecif0Ty2WhgAtwkIGwzLcDJHAsmO55/Q?=
 =?us-ascii?Q?3Cxz0NtYqfPvHb3r0rdUEevwvswCkF9nRv9tTEDnvByKdCm0e8y/mnAO5lUy?=
 =?us-ascii?Q?8jSYLBDu4KEJJVQF7HU9vF2X0gzeirOq8Zco3tvU377Z62fAZerimZxeWhac?=
 =?us-ascii?Q?/vME5vyruAP/9RoScZrX9rjzF1OMsiN7/hSziKWJcDWE9ENeAeQklUjXxEhG?=
 =?us-ascii?Q?ZUzwM9DYvqDjzfwqAX953c3nHpHyWowaEljHcAsRMX3Uu1PQsgfkijQtdOLY?=
 =?us-ascii?Q?a8kyfQDmTP/6I5fN+um35ID9gr7brJ8GcknASQUUTHLyO1Gk1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k1qL4gNr9daE/lbFCMVR06iAv4Aogt8sghIFpzamEOFNMZIvhwfi7NjLl1Q4?=
 =?us-ascii?Q?SPaHMsctMDa6zsO/yHShAmEq3vCo12NM5UyzZvciDm8W9CfRG+TYidC1AEFl?=
 =?us-ascii?Q?qSd88N4/T7XFHZWv6fR8AZYnPk6T9v+mHVddaXisr3wP9X7K9QQJopRHwVMK?=
 =?us-ascii?Q?qx4Zf91IdFGRuVhju6UfdER+zN94kgjnQOj334i3aOS81qRRlyJFqbkO0QKV?=
 =?us-ascii?Q?VLrYtUY0WhIbsEcqPOj/Ww5BYPGAryCWWLzJ72VjpFFLL0h8SVpdRWVk0eq9?=
 =?us-ascii?Q?+rMCttyCHqGGvfHgSGQmi9FB/bkg/2M+1rO9i8AZih6plmo1YauzQK9N8f7I?=
 =?us-ascii?Q?uKB4qshQ8lQ7QFUIwiql7VknNKxbv3R/zFskwyOJIUavW7drfu1t4byuaBMW?=
 =?us-ascii?Q?bgy0ylfJXUD+nhh3rxnDlLKblXCMvLYEB/36hMeRZLopZD2X/fLwUGV8krrV?=
 =?us-ascii?Q?8sb1L5EQc3WGi8k78ml9S9GgmmV3oDslwo7JN8OYBdtpGnHjEsz4ws9tL4xm?=
 =?us-ascii?Q?4WYeNvjOO6LcFjOl4ayK5NIGUk0BFsiCMlZmSubUnLALxThpYYPi/9iJDDkL?=
 =?us-ascii?Q?0oiBOksjBCJpq18NupQN/3NEKwQmgoYtmSaMP9qkMEPfwjHtUg3Ek8NErPEY?=
 =?us-ascii?Q?6xmcgGEtPrpVyJOi+LUDs1pqSGhUiG+E6MxcYeqdgrLvX9+ZVycQKLhv40l7?=
 =?us-ascii?Q?8XeNIcRvu0nnCBpzNWC6BzxVDZm+mZvagnE47AUChh1VsoPzVjsrKJiD/lMl?=
 =?us-ascii?Q?744gKFFM7qz8ODJs6gEt+eb1A71IZ90uZUGpsdngurb+ts0D86IqMsQw6zAx?=
 =?us-ascii?Q?xdpOIII1PuD/buUlpGd+n8SpXbhrksZkcn5sRggVG0vwqswN+hGS4TlwTqRt?=
 =?us-ascii?Q?bdCxr3DmnoLKaQISl0aTpAwGp7aR2DeA2iE4nV33Iv0p6usZ+WRnf8Y8gTxp?=
 =?us-ascii?Q?/5KX9i7pKZ2XN2ciYa3aU9IzpDLKIvXbI9ThF0BCG2xCBb3G1HjTAKVSzV1E?=
 =?us-ascii?Q?Xo5RZGuiRI8iH7/8jqU6hWgIcc/cwFiPykhNozKLvf3zVlu8VMno1V8gduTL?=
 =?us-ascii?Q?SZAvsIWk6Ky0p0cx23cy9emYy5wwNTgZaJ9AvnLsr3dkRuK30HpLSYug+tML?=
 =?us-ascii?Q?swSLri9ycmfUS5XuzMUS74cgs3Fhgfdw+0sWefVnxFVDwS0vcoluwVVA79Zv?=
 =?us-ascii?Q?bCOCeXwqqmIdVX6cdchKPNTX3aR0lPlWQ5hSbMHJCNPRGXArydjENo9BB+Rt?=
 =?us-ascii?Q?WDPH+knTMjq4c81UZpNV6HuJ821h/RN7oDBTafVK6TcaVsgw4cDar4vpcSTe?=
 =?us-ascii?Q?z9wjNWd61olLeZoVNGY8B7XiZ2pep/M8j75vHoA2WAszJ0yUvPV7beBsURqP?=
 =?us-ascii?Q?RuMNMioQuss6hz3fQWwIbpGiDD61Dx040bomjKvb+/y5w0/zPmPEwSY3WFPA?=
 =?us-ascii?Q?JhdyS8YFTFTIRi5377CQQk1N/XBbYT10Kg8EoNeutJdmmMazm8V9ByPrf6ec?=
 =?us-ascii?Q?17fRqDfNc7uLaUZv5PWvIusHJFfV8bWSXxWPqCKRxPeAZCGHWlgR7Cjo9b5G?=
 =?us-ascii?Q?p6cjtKF4sQpKKFheiFuH0fe3cnxjOwAUsyuc8ywh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31802faa-4a92-45ee-d35a-08dca6fb8b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:30:48.6465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFhA8dBMwWhYkJ+rK1Hu3HJgnirTeixCHXYCCcLAm7xCmxxVZMDnJaiF6L8lVyud6vHqu2Xu/kjd+H4tzJAtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Thanks for the clarification.

Regards,
Hawking
-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Thursday, July 18, 2024 12:06
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count

[AMD Official Use Only - AMD Internal Distribution Only]

Only set eeprom table version in the beginning of amdgpu_ras_recovery_init =
is not enough, because the table version value is set to zero read from dev=
ice eeprom table in function amdgpu_ras_eeprom_init due to no available eep=
rom info in a new device that have never loaded driver before.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, July 18, 2024 11:52 AM
> To: Yang, Stanley <Stanley.Yang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record
> count
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Can you please try moving amdgpu_ras_set_eeprom_table_version to the
> beginning of amdgpu_ras_recovery_init?
>
> In such way, we don't need to invoke this function from both
> amdgpu_ras_eeprom_max_record_count and amdgpu_ras_eeprom_init
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Thursday, July 18, 2024 11:20
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
>
> The eeprom table is empty before initializing, set eeprom table
> version first before initializing.
>
> Changed from V1:
>         Reuse amdgpu_ras_set_eeprom_table_version function
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index eae0a555df3c..aab8077e5098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1011,6 +1011,9 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>
>  uint32_t amdgpu_ras_eeprom_max_record_count(struct
> amdgpu_ras_eeprom_control *control)  {
> +       /* get available eeprom table version first before eeprom table i=
nit */
> +       amdgpu_ras_set_eeprom_table_version(control);
> +
>         if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
>                 return RAS_MAX_RECORD_COUNT_V2_1;
>         else
> --
> 2.25.1
>


