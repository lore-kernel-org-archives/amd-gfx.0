Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D931EC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 04:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CA410E4DF;
	Thu, 18 Jul 2024 04:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7hrvXMp";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A4010E4DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 04:06:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls0KA8SGjsGbi6vz+nci2FlAQDKj6HVvixW7GMq2b0OFPUfYDHDukAgDkeG4bZZFqmfyr4xRs4j77uWNhuhuAXxoMtAVBWz3/3C36CcjJurBM5+nQEgvj+Up4xQAPheHZAAEYmmyj9FLfKMFyZolJXVFKfZVkWzclq/5fVZrrTvZxN4hoQBaNbSRn68XLz7cWaCmddc04Uwz3UnQ9tdXV9hbTjjCbFW7vczwLYr0dZegd6L5oOHg0FpU6phAPHgLs8EHhrltwu1fCQzlFjdamWLf+vQfhYgOOMrJMJNepgqjccQ7NGkkFrNtM5xgUGd4rS8MsjWMGMJMD7Y9tNWbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0qSfF6K87h2q8o4EnOcENI+PsFMFBrSO8QHdBBNPEo=;
 b=dArma8aPAD32n4iYzDFsgEEA5XJN3DljYJp0eNbBxkjP6Nl4RjiHnTQRin6JDsqjufMQhd5iQXGDZHQdMvr9KoE0CGpd2R92+dGV5RFUCh7V1ZvYzzvq0QPOontLIfYTTE3LuZ5YonwPAaBPVxi6R6T7hBUACQMh9XOTvIULJoYGab2XQVdO1bhHPJZuizkCGH/t25ZB/5JBqajbUqBiidYqvpuRp/JfThFq+5X59sJgFbKSK6A3LdXq0gldcXM2G+x6Vej9ioejdQMgplhcAZyg3njUDwo100EL83n8ER1566OebUqLxUeGsR019Wxnxchf5+sOGn5hnZs6nsXLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0qSfF6K87h2q8o4EnOcENI+PsFMFBrSO8QHdBBNPEo=;
 b=M7hrvXMpIrmmiM/UNE0ulplvEJmUMYgngSsinXtDSmfznURDPKl5qwsH+/xZDw5/I+URsW2CPAiFa3ml2GUHwcro3beJuMlIzEWV/KnYrcyCLMrJLza/RAhMWY5fLILBz2cdEE3y6S6MiHRhhhCBXDGOkuv8orLaMzvEG9rHPXc=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 04:06:24 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%5]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 04:06:24 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Topic: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record count
Thread-Index: AQHa2MFlfk7a/KXQ/keSvXKYwYB9BrH72jyAgAABpuA=
Date: Thu, 18 Jul 2024 04:06:24 +0000
Message-ID: <PH7PR12MB7988B3653E3FE2F10DCE83AF9AAC2@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240718031932.1353653-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257199C05DE3DA98B4853BAFCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257199C05DE3DA98B4853BAFCAC2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
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
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS0PR12MB8455:EE_
x-ms-office365-filtering-correlation-id: ca8a5b04-c093-43ea-0962-08dca6defd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4l9J8T1R4ompQBDtjAwNOAafKsnL+TeayxZ+oidgnHe0suZertSsv5syKB9l?=
 =?us-ascii?Q?7VmM/FiYQxPsYg3+OPFn6A7uLVjakN/mAPGoRewKIh/x+ud3G1NL2PDTiKEs?=
 =?us-ascii?Q?JjY3pwYU5WAMM5EXqkUrk+2x/ub0tv+uLVOA9sJ6fTgg9XL6wpBLbPbXIQHo?=
 =?us-ascii?Q?J1A9xQ/SMX0uwJWuPFw93/cMJlRqYdj5N12WmVuyuer0OX8cC5JYEkEY1kJ8?=
 =?us-ascii?Q?XAkme3PniqQsl+V77O77DAdHNtOpRad6gbMCjcY4kJkSP2f0hZmMiBOvlF/I?=
 =?us-ascii?Q?HetXN82PgxNO7T8Rj0IFl17NuvgkNZp4aIC8cDXFZgIyOJj2JHke7F2GlGot?=
 =?us-ascii?Q?KlUL+VgKUUR2Uzaeh8/X8vIzHXhn28mcVYpd65zBjfPAKZfQdxhoVNKJKQcm?=
 =?us-ascii?Q?KAf2cJgefPu0xAJPgov9iuZ9u9Nt4P5306ThQM/OGey+Jp+am+exArU/s+/D?=
 =?us-ascii?Q?YfwYmtQQTQeROsNaz+HNB+QwHC1cDIQabgCv9gELSIjWU+NVJsU7i0AXUMFo?=
 =?us-ascii?Q?5BXY3G9/uSqU74iVNyn+nECIwdb7/byTMoDfrCoD1J/8GaZCjA87VDJYuZen?=
 =?us-ascii?Q?Fl8lUtkk/qCtPO4Q2uUN16vn4K9TROUq/q1sOXDtjnJ1HBhBCV4wCUEdNGmn?=
 =?us-ascii?Q?8U02mKOA4qwHS6qIwS7yIDFcu3T7fG3s9CMXJaGCKonrqNQPPcuFxPP2iWnq?=
 =?us-ascii?Q?fOBrf1jaes5EX+pdlbVj+oqhdcb+IcelxduLDbBLM0xJoW7bSTgyc6nmDQgE?=
 =?us-ascii?Q?PvFC3fyOU/ekbPEaswkGz9Gyq9TrjqBU2pVMJYsA3yEamxv3NYD2ki5s26W9?=
 =?us-ascii?Q?CwjhmF/Ry3cKtX2xNaBrDhue1YjM2v0i6oxCUbCmMQrFDn12BP1ISw87tXCv?=
 =?us-ascii?Q?qYTRCfjJj3GzFw0bgas45TxewKnigNX9r4Ujx3/DB+PzH0++euTjog19SWFr?=
 =?us-ascii?Q?f6cOzKWyLlbKGdLW4Idleb1cscLfiLOfWhzhWz1r9ohUyBQxYRPutfo6wihi?=
 =?us-ascii?Q?ZJySsW/YPKpyxnr2WkvZyIAMpyX/Q0OYdKbOiZXQrkds8FuBNBys0VXJqa5q?=
 =?us-ascii?Q?R6dIIZYk4t4MfyFbtz+Avq1RvLZCgY0bRUv/Y67knh7kVTAjCCAz+WESgfbk?=
 =?us-ascii?Q?Io2UGN5AzuHA8s+Urdohin21ksxFxuM46eXwjGJWbzqHZ9zKBabAIOHra/66?=
 =?us-ascii?Q?F86SB161rFijCe6w3yWctbRq4bxeL/EhleAPD9xRDZkCy0cr9/jGERZJKO66?=
 =?us-ascii?Q?yN+cOAm81A4/icvZHFGp66nQTZfa0bru7rF+WoBGWkZUOL1b5tqwqtUFM0Io?=
 =?us-ascii?Q?p7HEbOe6dRdzFeOde8nlME++6jDJeJmVzSZrxrAfIEdYbPhNtTVMSjcjCbqF?=
 =?us-ascii?Q?BecQMDHMHs5jgl9mMtkfylpVdxygQ/ZrBVgnBg718V0dpqZrKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xc0Q602Py0lKTpb7/worQFnW8nJeTjNDTCLe/d5LY4d3hNnGqFFz8s5Lx4rr?=
 =?us-ascii?Q?xHV3kEu+8DgkgfT1jYBuwIbxZwWZKaVoPeHVa4pTaTD5WgC0qgYVAHnvJPuw?=
 =?us-ascii?Q?HIXiQr6x9NgJ9gPUNgySEiPY3MwA0pInXLuHSFWJb90JekZlivJ25N5Q3Eqk?=
 =?us-ascii?Q?w/cHqLGdg6ZLBsV2nzB5OAvOjKZmzxqnieblz1x7G4DaNTdovhYDreO/M2Uh?=
 =?us-ascii?Q?8KxGP70gcmraZyD9YOAJJ0lewTbuDpRMj9Fdjt9haGXInrQz+Hcrp1ryBwUM?=
 =?us-ascii?Q?OEvOf2j1z6anMaJKdaea1l98QZ+wNmsJv4+vH77MFfyXDQFyzUwefyWtV2wJ?=
 =?us-ascii?Q?RDqn6UDCACit9BIna5RafjC7NUe0CX6bTU7uz7HviCh4IzaVPPyviUcyPojU?=
 =?us-ascii?Q?yHED6hfRU71Km9rqy9lbjEDQcntJEntdWeH6YvTN5tkmiKT7gOO2UzCx0X10?=
 =?us-ascii?Q?OSbUQJjk6qQtY6bLYeOX35tAvbP+0kReix0N+4b8i1JzJJtZ+0X7BohhwgEo?=
 =?us-ascii?Q?ehKBTXQ2Mq5qhKXn3Wmjc+aa5G5UUGSiYnuN83K9vRe/HFLjFstRJ+q8vTK5?=
 =?us-ascii?Q?QnS0Wor+LSoqStXUE883ZQ3oD0s1vLK3NVnMhpHdsE5t7X6FfLgiM9JKCOgd?=
 =?us-ascii?Q?jJkQ4r9Ikafev5yvlvc5uGiRPnpQaPYUrHUO2oARHbjNfXLMMOce8j/Dx04E?=
 =?us-ascii?Q?yxEOZfJD2IeQxelvmwOM+QgkTWl1Y5CSNGF43tICc1JexfNIeCGOj8HMo4ai?=
 =?us-ascii?Q?5xTfnGVIKQJccw3GJnsxCRodpzvOgfSjsYRT8RBdB4VP8iEn6uRkf1xKUmZM?=
 =?us-ascii?Q?tmGd8XmvWqcOjJOqk4iXqz5ZGwPDgOIMnOTkzE5pGmLRYztRT4pFfhvnUWHl?=
 =?us-ascii?Q?Cl9wIOOjyirqkWIJ9k437aVvsg21quR+zQev6QEAn9ET4qCKOARnksJKTOYU?=
 =?us-ascii?Q?DOxyh39JdF0GTXyj1gjEL9JlMQkEQM5x0fv+7npHLUsa0KMWGPlf/CeZ6DP3?=
 =?us-ascii?Q?1Fazp15gXtPbeBx5cH4YnMVc19fNuKXYNbhFCexvzdQlsEUurRI55WgjjJjC?=
 =?us-ascii?Q?3d/yGQwOPpcnO2oUi/FuB1gemf6sX33vpH+59Z3tO09Vk4Xx/nYhx77zoHvM?=
 =?us-ascii?Q?xz0xr45QEucfi2L+WiYezjeYzZqqdXZncllXBuOxds05O1RYHPhR21jkzuzT?=
 =?us-ascii?Q?7acUsbGdYZxILin9PbPO5Xm3pBym7xNMgQKPWj1iSxRy7YyqIvqIzfjCfj3J?=
 =?us-ascii?Q?t9ILjuQu08OAiX75j1l45nXqhBNW8U/GQ+kk19R9B1YbWpfkBE5IwKRXhWZY?=
 =?us-ascii?Q?+qvSbgkiTOIf0I+VWEW1Wnn1EC1yyr8XUFPR/I3NMN7kwQQ+PkveTsjfmSFn?=
 =?us-ascii?Q?MwRZi5RqD0udqZOGEX29mAXVqnw97FyjPeONuEFePL7KUjpkHqoX27hducY1?=
 =?us-ascii?Q?T8faUN4cIlJAt+dQQ4Cvw82m1YyvhYeqI3ehYeM/Dmwi69Xdf1DvkLVWVnbv?=
 =?us-ascii?Q?sbvXr6YNToo2W7xwckUyMKyLFD0p4zXvtlFXDcLmVQl2LYQW8YExDoIrF/JD?=
 =?us-ascii?Q?pVfGeARyWi/zUvqwTfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8a5b04-c093-43ea-0962-08dca6defd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 04:06:24.5059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XG7Sf4NTIjrmVeKqWz7YM1baTRkrbl5UvYfWjH1zxdLHK2psZF81upQm0ppKqcAteqFGWz1IfryzdEth4jiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

Only set eeprom table version in the beginning of amdgpu_ras_recovery_init =
is not enough,
because the table version value is set to zero read from device eeprom tabl=
e in function amdgpu_ras_eeprom_init
due to no available eeprom info in a new device that have never loaded driv=
er before.

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, July 18, 2024 11:52 AM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review V2 1/1] drm/amdgpu: Fix eeprom max record coun=
t
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
> The eeprom table is empty before initializing, set eeprom table version f=
irst
> before initializing.
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

