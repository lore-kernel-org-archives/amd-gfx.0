Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A482BC19F53
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 02:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0495F10E104;
	Tue, 30 Apr 2024 02:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tOdbKfI8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3F310E104
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 02:10:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V82ziJiqH/fiN4i0zU4roomqnsolhPXp3RtqnjZocpkmNikxlEnn0C1MnJH9soZul6tBHoVZpiXubR6uCxPP2cnqNnuq/lk4pW0/fbVSsrU3iJYtF2vAFOAb1qa9vp/bdYgC1xMniOIKRHbJ17xRiQgl++FsjtXRHKueZyNmSMxzgCWl6VkTu1QEsJaD6dSEDy2AM0izFjkz6eojQZbNAme5AQ/u/nT2FrDtQyn1PF2YQ8QIkI0eeVuvaeOuU9N2i0EYoul4AzIZKgpdHTM4UBYlqezQg89XlIPsYGbYDHf2q+JnOjJH2ZpoFa5FM0tsCE1+C3ynCX5507DNOP3TVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAOOKZqVutqCtNBEIwLr1Jkmnc8hWhIL1mK3cp1Smag=;
 b=SdvbAh31BXRWsPtUpmMyhYqJr/f/95XnD7Kdxs3dMLDajbLe0DM1o8GFPz8joC4+A3yDHjhLzSA53a5AMofY9qwsKi3J29X17CxRibcdKso1BYcZCVR4vxQMk9fbx6o+4zxEUPy12GyNQZoMsbzDpxnrPs67rhpZWTEvHSXYeQe8qhHM01FY2IiktYdVBmgsi3cv4s6yBU+LzC1DwccXUDd7D1G1PMMjNZnY2Wtex4KYDHGtYsEwlb5yuInyWOA26herIPacDq02ZWyMvFRjMrhczFgHWKPboZ+R5KmB8Y6uxI4bgAxZyL97pqQGRzhNgIsCcNaCCYx/V8TS9KL/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAOOKZqVutqCtNBEIwLr1Jkmnc8hWhIL1mK3cp1Smag=;
 b=tOdbKfI854hYaOX5qEimGN44Zuc5aRIIiu3n4iguPJb+oezCX1oaod7PYisIA3FUK2bq1nm9/RPOCrX97Pg/HaB9I64mu8lkEfjofAWg5FNZX81GkF80LDtNAPDJTunUXFVjR4Nm97UUWqpf1qQeWyq2wr3SZBVPW2mvWkkmo7c=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 02:10:06 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 02:10:05 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning
 for pptable->DpmDescriptor
Thread-Topic: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning
 for pptable->DpmDescriptor
Thread-Index: AQHamU/VMR0vG8TMK0WUgrY0QwAqf7GAFCFw
Date: Tue, 30 Apr 2024 02:10:05 +0000
Message-ID: <CH3PR12MB80744FC973924E054854BA52F61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240428093816.2035537-1-jesse.zhang@amd.com>
In-Reply-To: <20240428093816.2035537-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b06511b0-3fc2-46c4-ac4e-a18ae1e9bd13;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T02:09:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH7PR12MB8179:EE_
x-ms-office365-filtering-correlation-id: 858d657b-ef2b-46af-87d1-08dc68baa722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?s2nkoUSHD8UO4j4JWGsSivN/Lz7ruGiW3z67xpHXDaHMsOsofaeZ0serIKYX?=
 =?us-ascii?Q?YzufD21SlxJ+L1oCUfgblB588hctb38+u+lIhKLwclsuLptRbREKsFYr6hbX?=
 =?us-ascii?Q?/pQkxng5XYFdFE8Xr7UCejrE8OxL/QhcqdClEPbwsmtVtlU5qU9Tdf9LY12N?=
 =?us-ascii?Q?4TwLq/aCchOCfrgaC8zdY5LyyK6T7Bj6TW4CKQeGPW4UGH4o8qRLtuck3Gjg?=
 =?us-ascii?Q?w0JiB2UMGhzLBc7cfC75Zkl3VijSurDadcTUmjhZORcWSYUcX0iPyLneAqrk?=
 =?us-ascii?Q?9AMWa/lWrUxyiUnl50sLOjc0xgHskfgsUgiqK5laYa8TNeQrlDVutEQp/aAt?=
 =?us-ascii?Q?P04QbITVJgpObs7Jqzs0zEBKiGri+hDcelcsaJBgpqXxJl33zzQMGmtkWnF1?=
 =?us-ascii?Q?jI7P5Gnw/53Ck0FR76wI1+TrBZev2zzDxWILDzHl+3dLTieAMfElz/o8coRP?=
 =?us-ascii?Q?nQAgHGo4f2R/M8YR7Z9+ArtWjVXQambDWWSz8MKF1gpLNp3OYvZRscBgLwC4?=
 =?us-ascii?Q?QMLX60wndK6VrPviZeiOIS7EinYDE88KCxgge2gv0GtEVM9BQWRApebRT+rH?=
 =?us-ascii?Q?q9FiEIKF79WA5Lkb4/cXG9yrFYybG7O/DqjmXR8Jiaj1qSEEjxY31eQlyOkK?=
 =?us-ascii?Q?IA9prvzeSzVkcsmh2CxH9eVwEAYbW6W5YiehN8u4PEz8we79YhAGj5/+r1VN?=
 =?us-ascii?Q?TpiUihLBYgACuP1oR5eS5HAKjt7myeeX6lzHEfxT77/TTrCxfIs2pJD8OKNp?=
 =?us-ascii?Q?E6Y2ZRyF1D8l2Yx4BoF6a3fQVC+Vbz5nAISBzjsNnlYim2OOzsjVXbgHzp0c?=
 =?us-ascii?Q?09o1Fjhi2brb1LSZ06yla7RIXDQ6o2umSh7hd3ikiRtvZLbUUbrR6+mm/ZYi?=
 =?us-ascii?Q?GN8ox1uWIDScfQyCimFplAE2Bu4kRDjXrugMBuQb7kxfOFctdGoitrzDpZc3?=
 =?us-ascii?Q?fdcrTjCeBPG6xXvDcVHSoOeJnCXCMawusH2a6XtZlodvFKPg90buNd+n8+9N?=
 =?us-ascii?Q?/cwdwiGMVb1KAPMuLrIDXZv6ulnV8i3KXECMYO6jq+rViOnkdPMdm4QUUIhl?=
 =?us-ascii?Q?+BOTV5B+AiaARWyDXB6xPSlgxILRE/HKcjzZsaCuiYq8Hbk1RlzbiD3QBe4d?=
 =?us-ascii?Q?fZoeIjvObk56wY7CaalbQRSUZ1bRthi890/DGhFdVCAwLZrbJKlu8Spt9fUg?=
 =?us-ascii?Q?J/9Fx3XIVZKsbnsEQNv+xhqQkOr8hh+qnIVg0gf58TEqhlZ2gB9fbgh3K7qg?=
 =?us-ascii?Q?lubSFWGQsYXkTfFufgHZO+0hheXkwBlmUgWlW4WdVzIg1PqMehm+9okqEISs?=
 =?us-ascii?Q?W3JW+JBboV7KpPSy8qWfmUGf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fRtR/Xegqh41HL84ZyxCGNhODhvG/1jSE1DK0kBzZUGN0C9L0fF0AejLkWyS?=
 =?us-ascii?Q?+yvJ+UomFEn/DCo3DjgTxyrdDDG4xlWTl+FmLsoERhdvM0K9C68efqrESzXx?=
 =?us-ascii?Q?r02rDrPRyuOyNi0+3zQG4cGgEs3u9P6YhF4AH5jMmbYI7x4asLBO6UzHit8H?=
 =?us-ascii?Q?Wn31YFYEAGjehg6qQQdJgjPk/X0yqatvoCyjhth+sd5GR6qgUADmCYcIREJ9?=
 =?us-ascii?Q?LBZJM+52XjTc/TBz4J7Oy1gkT5tw6lJPoVVRzBpIuvVf7PL2eEKx4BIbGts/?=
 =?us-ascii?Q?zIWN7OCixixeshtuHTQA/630bgJTQA6nckaItveSUPO5p3rmiZ25PbFztKAn?=
 =?us-ascii?Q?Q6SKo/hF/78tD9kjUgbHRUQk0xvVFIQbBbeldGKS4L38xIoPF0YcdkZffdKp?=
 =?us-ascii?Q?etLXlwXPRM47hFKyldk8dPNR1j7XvlovhxYk0HJ8AYhLIbWfOBa5H5gakCFO?=
 =?us-ascii?Q?uIViYKb1j/JhOyfnaiVVLSQQG6YAaPpqzEHWbiMW31PrWfWM92GcVgCWretK?=
 =?us-ascii?Q?/XvRy9p4EJF8Sjv2Wl7CyihSuTSiSbRjDvcGFcymR+ShuVDXQY79GxPObDTt?=
 =?us-ascii?Q?Hf1O7ZKBcXiggxsOxIfvSj5VPu0tyTOPXy/TgeTvruenL5rLIWmMPWFsfZy1?=
 =?us-ascii?Q?HJRTh6s9tQvCq/JrT2nBoHJiQjKObyXzhoqY2sQ/mF/PT2OPrIRp4iwFutxx?=
 =?us-ascii?Q?Kp5bDzcKFzIXI5C5M2xi97EJu4i8QpT2zSMGkyJmDsXnCKm68M1s2/lxWwrO?=
 =?us-ascii?Q?V4DoDDrM2TSCkU4tjO0CTFyvsZdQAQ4pr2IIVBBLC1XV9Ars2emDs3wv14lj?=
 =?us-ascii?Q?qsBTUcQdjN6+UC77cbU4jDk2xXPGm3rWW9NbT8g46rax3uTLad8N08tC+uPk?=
 =?us-ascii?Q?RPRSwl/Rg0k6bsRkqUSN8LMX3ToVU+pkprv7KieB4bHQgdp7RCTq2Nn1tIHq?=
 =?us-ascii?Q?etq9r5/o6cPw2eWMwUxIwTvJUMf+IocJM7ALK4YGzJMQOe/PxLJQ72IJnAG5?=
 =?us-ascii?Q?lp4+SxFxC8gd1O6W8KdFAVAYQvUt3VmDyd9vFtGPc9OwF5LHBjmSs/2VM3s2?=
 =?us-ascii?Q?aeGmOWYrjhUXeIvlwCj5clTSJUFzbWOQ19OgVC9nF8GW2YLg49vdG6+0rU4W?=
 =?us-ascii?Q?+rfeS+7H+r+iXFPpNoOG0PDZGyuueOBfG9THy3IHdLPoWxC28VMKKrswYCcq?=
 =?us-ascii?Q?epor3xZ2ImOQgxECS+nl9scXVfWzlP+/AVAzoufCgKmBCn1pEAZBX+DD6gk0?=
 =?us-ascii?Q?WIVhJxuetNgJZn2k3DMfbfRbTap9YGphxHmaywW5Czm1NqBJWFbBLa4cJdm+?=
 =?us-ascii?Q?bm9Zj5n6uWhVYxvAl18QePPpnIzOP/XbBHBZrS9h5ATdTsEUTy2JI87IwlNz?=
 =?us-ascii?Q?4gi/gUE1kdtTEuHZ2O5PF/v9zPaQowqoHhcFhtr32+b7CFv5RWThC5iLORaf?=
 =?us-ascii?Q?/Wu7cRCo1DU1pPPYCfww8MjDnczLa+6sop+kjyLQxZEWRRUnEpkKxeJUSQJv?=
 =?us-ascii?Q?ev6Z5NROSzKnm3li7io51FDlzkOltTBuGVx5QVoyHmqzjSlIVtw2BUHEI83V?=
 =?us-ascii?Q?yt8F84XFnBL1HjXopr0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d657b-ef2b-46af-87d1-08dc68baa722
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 02:10:05.6406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWi3m207ZL7yz8DZnB43JrpeFoY7ZuF/ShKd118FNt+u3+vUFy7CDWYxUguzfIH4DiMX39TC1279Q6xbq9ep6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Sunday, April 28, 2024 5:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 1/3 V2] drm/amd/pm: Fix negative array index read warning=
 for
> pptable->DpmDescriptor
>
> Avoid using the negative values
> for clk_idex as an index into an array pptable->DpmDescriptor.
>
> V2: fix clk_index return check (Tim Huang)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 5a68d365967f..c06e0d6e3017 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1219,19 +1219,22 @@ static int
> navi10_get_current_clk_freq_by_table(struct smu_context *smu,
>                                          value);
>  }
>
> -static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu,
> enum smu_clk_type clk_type)
> +static int navi10_is_support_fine_grained_dpm(struct smu_context *smu,
> +enum smu_clk_type clk_type)
>  {
>       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>       DpmDescriptor_t *dpm_desc =3D NULL;
> -     uint32_t clk_index =3D 0;
> +     int clk_index =3D 0;
>
>       clk_index =3D smu_cmn_to_asic_specific_index(smu,
>                                                  CMN2ASIC_MAPPING_CLK,
>                                                  clk_type);
> +     if (clk_index < 0)
> +             return clk_index;
> +
>       dpm_desc =3D &pptable->DpmDescriptor[clk_index];
>
>       /* 0 - Fine grained DPM, 1 - Discrete DPM */
> -     return dpm_desc->SnapToDiscrete =3D=3D 0;
> +     return dpm_desc->SnapToDiscrete =3D=3D 0 ? 1 : 0;
>  }
>
>  static inline bool navi10_od_feature_is_supported(struct
> smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
> @@ -1287,7 +1290,11 @@ static int navi10_emit_clk_levels(struct smu_conte=
xt
> *smu,
>               if (ret)
>                       return ret;
>
> -             if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +             ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
> +             if (ret < 0)
> +                     return ret;
> +
> +             if (!ret) {
>                       for (i =3D 0; i < count; i++) {
>                               ret =3D smu_v11_0_get_dpm_freq_by_index(smu=
,
>                                                                     clk_t=
ype, i,
> &value);
> @@ -1496,7 +1503,11 @@ static int navi10_print_clk_levels(struct smu_cont=
ext
> *smu,
>               if (ret)
>                       return size;
>
> -             if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +             ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
> +             if (ret < 0)
> +                     return ret;
> +
> +             if (!ret) {
>                       for (i =3D 0; i < count; i++) {
>                               ret =3D smu_v11_0_get_dpm_freq_by_index(smu=
,
> clk_type, i, &value);
>                               if (ret)
> @@ -1665,7 +1676,11 @@ static int navi10_force_clk_levels(struct smu_cont=
ext
> *smu,
>       case SMU_UCLK:
>       case SMU_FCLK:
>               /* There is only 2 levels for fine grained DPM */
> -             if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
> +             ret =3D navi10_is_support_fine_grained_dpm(smu, clk_type);
> +             if (ret < 0)
> +                     return ret;
> +
> +             if (ret) {
>                       soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
>                       soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);
>               }
> --
> 2.25.1

