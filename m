Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E3C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 05:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02810E37D;
	Tue, 25 Mar 2025 05:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ucqyl6+b";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8609C10E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 05:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo6+tKvhX7GZV/CQgwzbUhXFNoC0fKB2dXPBm9Kw52rDTIrwrlh+Som5KS5ISLoGiHv7oxonkpU0hah3b104GeQGTV62drDIaLdFhheOELMURWElLXEt7I7enCKKBUTuZs6zGXbH/bCo8idjFoZNuGMwdGyL+TW+j3NLLrv1FUVHzcOR0g/tKhg3QkGO8qoHlkJq/fmr6MK9W5jEA1uTZx2D+uXtgIk4ITf2RT0Dz3fiMOQaJq8QcUMfIaE3KPWymKu//EPNnpnCfElu50dR69DPNnlHGoxNA9qmgvuTVshFdg0HL6yWAu+65lB6KOZjBicj3MWWrj1J9sa7ItrSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtUSHSLIf15J59Uln0zLhmxhr11l705uXjm0DX/caic=;
 b=CAuezhQXU3UYsVv0P58FPTdPp6oZM5/zGr+cEEWZkfRM1pp10nNnQxzU60teydcnBnBCVYzootBRnbpnPLHPMSGnr6G1HTJP1GcYdkxGnpXwF1B6bIXq1fPuXVWIxTNxEgcsinm4uayN1MpVum9Aj3uDjo6V9zwgdvZJVzlXmKBxiSYHXjBLPlE3hPfGV/U5m7WLn91QSXOOmfbyXDY9UHxAu4fgFZ0fNQWphiHOaWwv0smd/vXsTJPu4sKXYtWutpCNIy8u6Ifi6RUF/Mq1oojs5Tl9Y7yf0Uochz2C+147F922fUrcwEWfLZNkkHxsd8ZYIv0G4vIHJz0ZojpT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtUSHSLIf15J59Uln0zLhmxhr11l705uXjm0DX/caic=;
 b=Ucqyl6+bYEhlJI62jvcr62shfAuNdHESURg1Uo8ls+g+mbgZE6p0ezwKEv3+tmIaTpzCrYcDt3ARp2J/XYKZxct/J0WlcGPtPOm8UaRL3E7iJigAIHZk1Ui42vZfwyZ9sj8zMsQglwifqaez1fbHnzIno6gZO0XusCnOhQXlPdY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 05:10:12 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 05:10:11 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Update ta ras block
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Update ta ras block
Thread-Index: AQHbnTtWpG72gWRpVECc1nB3fR5XXbODP6hQ
Date: Tue, 25 Mar 2025 05:10:11 +0000
Message-ID: <PH7PR12MB8796C05F43588BA5E69AA11CB0A72@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250325040531.2592549-1-Stanley.Yang@amd.com>
In-Reply-To: <20250325040531.2592549-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4ae1b915-8627-4908-9f49-74abb305f630;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-25T04:19:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB7809:EE_
x-ms-office365-filtering-correlation-id: 198837c6-f1d5-4ba6-7be0-08dd6b5b51d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?t+q4VeQapSdreX9Gyvkl9kpVaTXTsQ2Ot4FlCJZaynAmo2Jmkf9wmKw8AjVm?=
 =?us-ascii?Q?HPHAPE5QY84PKy2ahcOTLbmHB1j6/gMgKjwm0ticy9VbJjT9r8OG41sv/RZ0?=
 =?us-ascii?Q?dtbY3QBchs560Up6O5DqqiBQuDqv9i0tdQG/VWG5rOTwC1mnmbozbbS3hjFi?=
 =?us-ascii?Q?uj2ASu70Jx9NHzLGhnZLhM5laqLDayAccRq3R9m+OuP4zbnTEtziGVR3PYs9?=
 =?us-ascii?Q?EIiU2WGPA+8DNv2MgruFGHQSeEdyB0zLdOaalIfKybravECd2fxzpSlDAUkC?=
 =?us-ascii?Q?oN6I+Q9BaiHuR8BXF4Dadg+NesvbnhjL+Brp/w/IWhhVWkHYvIeFnQaeVtpM?=
 =?us-ascii?Q?u0X2bDmpGh2G+rPrZgAawuKMdHnhVigUn+JHND+iwRkbES6Z6ct/3scR51c+?=
 =?us-ascii?Q?921rirBnDHoHTsTl01QidCPPizhxIEhgMVMuGMH2dUYSU400SOEBtJgnr6/K?=
 =?us-ascii?Q?O/pyYJhPsZ9/1XIJLxQeLYKxgyI1vJScYSrB8jX63judEpQ4bUMNVQyKFKmI?=
 =?us-ascii?Q?xTN89DWmqH02a7ykaSf3CPk9GYIJtEVoJ5tZ+xdZT/zAjeT5hxa/AwAIyTkY?=
 =?us-ascii?Q?JhOg+17ZCNM8yqUHfdzhvGCx8YckOArYsQw25zTNrST2pAEEd/fyy+ilHL7v?=
 =?us-ascii?Q?a4jNpliFAhHBOQCtRVU/Fbr9TGqmD2AFNL9qhOE/Df05CzFWOy0MZJqeIgXs?=
 =?us-ascii?Q?dIit+rzpg9Ju3UvDdADBUdKhq7xtA4evS7ygZQ05UiS4KSzUABMw2sdEGXQi?=
 =?us-ascii?Q?iybMFwB62TO7Hgpe6SD9rL3PgD+v4ksgArKZZFQjMBT5AjhPinMgNnFbsdAm?=
 =?us-ascii?Q?2EkTey8EQIGBuiW3thtYja+KQMwvH0f9O8ok1goyQcf5f3YcageAmSIjJYDQ?=
 =?us-ascii?Q?ozckgY3BiJ87TBU7G7M/w1WvwZ5OO9V7ntiGgh+sY/yLge3A4c9cbZddRrCB?=
 =?us-ascii?Q?Z9dH4T2lRIbEHafX6h4NP/E7Y92xDnpsJqfh/kKbe5yD/0izMjR/YEQBgG2h?=
 =?us-ascii?Q?W4WEFY8wh5Z5cDv7kf6X+G32qEnc5/FpmCzhCKLO0faO3Bh/m/iEX2Au0fly?=
 =?us-ascii?Q?lF2FrX3vk3rtV5RcKVvZY6XyOg4gK560LAYk99SvHvBUQkhs+NxH/smjaMsz?=
 =?us-ascii?Q?BgcRiFn+dWijoxApMczR21YLGQMLxr6sT1YG+201rm7VGa99Bh+yx+Pvc7zD?=
 =?us-ascii?Q?y7pI1bSmfakjavjuy2oZyy2SGDN0vP3CfLeI1G3oZt7E88zfF8OnIIAX3Em0?=
 =?us-ascii?Q?UI2OWLHRkwrwfdj+yrUVgfvRKu3G18iSmctLsxh3p9FOk3KgjdcqG6sGb5H1?=
 =?us-ascii?Q?XiV399bm0S6k7xmhB3nB/E+u9Yy7NxRZt0nKl737VetNO4XJ/C5pJ+TFahSO?=
 =?us-ascii?Q?K3sW5povVJVZU5djRrDnu9Hj37rVx5r6/4qURmt4C1g2cuxFJqaMCf5FDwTD?=
 =?us-ascii?Q?Iipp/be1ESJUkYtDjAL0P4sJUA/33zwT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKKnLZYu1DeQEnFjWhYofSr/OJi/LZg06MdJnVlPW/EchIoTgAKVKsvM7CR+?=
 =?us-ascii?Q?QhzCL64TaCsjSaw9lKqXdMQJHLPhKnmlr4zeMzrWPzDF0NnopzXDMkV+KqEy?=
 =?us-ascii?Q?HSWsMvY5OfvBIPTFBxbBVAuO3XGcXS8NVmTbkvBDtPeelK1a0XqTUrUHWKWU?=
 =?us-ascii?Q?LbtO7p/eYJXR0OAnqlmJtVzSk8sHm2tU/fmsxu6ke+o2taQzA+DV4/UEE+qa?=
 =?us-ascii?Q?/6bUbM5dM8/qHfcDMyprsXCHBjjetj8q3XOo9ceCCwdOWujeAe7MP6QjQIWP?=
 =?us-ascii?Q?NutIR2W+Flh6nbughZRkCSrhvNWLoBB0B/P1lyvYBFeYhT3wmFbosqrlIK6l?=
 =?us-ascii?Q?Wjl9VwvPA8S56cl2XX064PtZP/V1HQWTVpYsWoBtepSFfb2LvLXeCc4zN5ln?=
 =?us-ascii?Q?NOyWvyKctS9Tl4JuE17URxSQ3H3N8F7R5PE9eDj33Cb0O/F5P6nc3CcS0G3U?=
 =?us-ascii?Q?knnmwNuEGfm+/IuWul2atABcCC4sHdMYTprl25GyTpKZksmkOFVSSpDI4NUr?=
 =?us-ascii?Q?6aiLlG8/whVNAzYR4XicCpYJn7k2bp6nVPJezgZBYGN5JFyejXh9krv8YWcg?=
 =?us-ascii?Q?0bXEMkM/M3Ndv5j4OusD/tpf53/eUZRnU4xGlnoNMtAfQGL8D7asMmZ6r+9j?=
 =?us-ascii?Q?AaOgG443olDrh78iQb5megY7Zs+55onv7ockDohg6/GTRniWSKTnDRnIc8Qq?=
 =?us-ascii?Q?75yUK6952N9iP8dTJXW5Q8weah0nsTMUvvP4qOOlhPZrsHwIOxQf+vZNbHMs?=
 =?us-ascii?Q?76a/zKN6lQUSyszXQDG/qVtagDEKxeq4bo8xyD2qNxf7TYGA5kzGYwy/Gwyx?=
 =?us-ascii?Q?K6TUZbrNsLWRHNpuUu+3at7mYfJ0L6QFlsssf5UbESkywqBuSfKQaA/J6bq1?=
 =?us-ascii?Q?idZJ87Xmkr5eddlQBiIeIsFAu8tp2WRKcET0N3ea14FWArjyTDnH1TkqOkZB?=
 =?us-ascii?Q?NZJWjQ1K0DwRDiNq34euh7wWLHJVhBiHgEJl/srZskH7T01C5AMgBbbZSWZV?=
 =?us-ascii?Q?pjRvVAKc7kkEukAuh6SovrKcd/r4KX8PlV3VtE7FQr2BxbvGLlN7vEbiSvBw?=
 =?us-ascii?Q?KnUHVXxAszVDcPJ8ahyDGbeyPEet+zGWeEM1xl45MjUwAjx8sCiZcUd/bMHl?=
 =?us-ascii?Q?D9nkQNxeIHVVcTevRYYNwjzaLG0vk88JeQP73EeO3URSPnijAdk/+Fu6Rf/0?=
 =?us-ascii?Q?zZf5b8mp5O1QWudfTLhtfDdRWKBnZnHpxN7+XDquoaup7pd2SsqAxSlnW5Tp?=
 =?us-ascii?Q?z9sMzkG0O6KJabtEEgNrFUwQwo1hCK6H88viLcgWk9bPuDPYHsnOjH/VqO8e?=
 =?us-ascii?Q?iKbHbBqt5csR38EiF6rFFRLJRUPkkNoFcyuSjxAx8JXwnJw36U5Py0QChudf?=
 =?us-ascii?Q?5F2QBaNScSjlvqDjCz7FRgq3BuVtwQg0El1nXDkP5P5qgWVig0FghiMNuygg?=
 =?us-ascii?Q?Ezowwf1SmsienVoWdKkTbPYGa40pmh2MQs/gjEoZj7SBOV5E9RoPOVltrxcU?=
 =?us-ascii?Q?tTUtfagoNybnxBBnsJBYhke8WRE95oH64K40jDtSzhgt/F3tXOnRwc1raURm?=
 =?us-ascii?Q?iDqpl6LqL7aCz3RmCYU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198837c6-f1d5-4ba6-7be0-08dd6b5b51d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 05:10:11.5494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuAYDHUK/kMt5P7UkX6HYZ4vBsDYJkMVZ3uMYB7y7DcyxNlpZMWuDr7qPJ07G1Xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Tuesday, March 25, 2025 12:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Update ta ras block
>
> Update ta ra block to keep sync with RAS TA.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 7 +++++++
> drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 3 +++
>  3 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5b4ffcd37ba8..e85143acf3a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -77,6 +77,7 @@ const char *ras_block_string[] =3D {
>       "jpeg",
>       "ih",
>       "mpio",
> +     "mmsch",
>  };
>
>  const char *ras_mca_block_string[] =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 764e9fa0a914..927d6bff734a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -98,6 +98,7 @@ enum amdgpu_ras_block {
>       AMDGPU_RAS_BLOCK__JPEG,
>       AMDGPU_RAS_BLOCK__IH,
>       AMDGPU_RAS_BLOCK__MPIO,
> +     AMDGPU_RAS_BLOCK__MMSCH,
>
>       AMDGPU_RAS_BLOCK__LAST,
>       AMDGPU_RAS_BLOCK__ANY =3D -1
> @@ -795,6 +796,12 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block)
> {
>               return TA_RAS_BLOCK__VCN;
>       case AMDGPU_RAS_BLOCK__JPEG:
>               return TA_RAS_BLOCK__JPEG;
> +     case AMDGPU_RAS_BLOCK__IH:
> +             return TA_RAS_BLOCK__IH;
> +     case AMDGPU_RAS_BLOCK__MPIO:
> +             return TA_RAS_BLOCK__MPIO;
> +     case AMDGPU_RAS_BLOCK__MMSCH:
> +             return TA_RAS_BLOCK__MMSCH;
>       default:
>               WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
>               return TA_RAS_BLOCK__UMC;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> index a3b5fda22432..8a3f326474e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
> @@ -92,6 +92,9 @@ enum ta_ras_block {
>       TA_RAS_BLOCK__MCA,
>       TA_RAS_BLOCK__VCN,
>       TA_RAS_BLOCK__JPEG,
> +     TA_RAS_BLOCK__IH,
> +     TA_RAS_BLOCK__MPIO,
> +     TA_RAS_BLOCK__MMSCH,
>       TA_NUM_BLOCK_MAX
>  };
>
> --
> 2.25.1

