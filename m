Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDA4C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 09:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE3510E623;
	Tue, 20 Aug 2024 09:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C1U28umj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5618C10E623
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 09:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMoDwlADCRrR4NbMC6Yq25DVin4dOj9bShVlqDUesH5b+dZePrOqqJ08qDCa838BqviHay271p0Yy3WaNyJNBnwr3Lz8sJr6hNv+3qaVDkrUidxaiCr4YoDBvVhl7X43XuL1+2BtF5GSTMeobWPSsK5mkcFkplWl0uCj49qTIpAYT7eCehUFnM1seiaWd8hMtqQYDKGFHF/ZQowEdW46z8FG63WSGV4PlEiUP6GSMEuzPZpLiLJFJzfIyUE4zOfeIVzovcM6oX0shOW/6IcMbZzIkWonGT9bq690qIKVozuX2k4Wq53KqvImLSVi7QsIgnNzhhLhn7/syIhOYiSqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0aMeEpdFQPSfHw+flOPih6nOTR7IJXxGnqYYwf1idE=;
 b=CjapqBLPZP1LgkyyCktLXVhfONLFP+a/CXhbVVi2/IfMFXlkLz1gGpD+8Q0TnKFRHSsaejbx/zfNJMD0DaokRvZOL+hJohoHkhe3hwtW4XeqB/f+AuxnCYm4wnNZWq8Csx4IbllNQsPaMg3Js4JwYjHALy7V6pr3OY9CMAoc9PEDb7NZs1cwqRfkeOTIbJSvoYJbCfZ3qao9WIo+a0yjvfbMWYTvOf4S3TfS8x/IfnAY8HB3DRiMz02jB/PK0AO5Fe5pdAtWEXsh2E7mk9mZdZOy9ESPWivVCCyllk1Ko/R1s9bZVQrEYhgEzYKcK/oFe6trO8r1GfQlnB0X5wgF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0aMeEpdFQPSfHw+flOPih6nOTR7IJXxGnqYYwf1idE=;
 b=C1U28umjv3nzQXuFC9oh2OcTNiz2lbYLrwflcYaNJdFdKCyJLbVAzOvOq++Xj24f7zNnADDeFBwMimKP4tarogF8XGlXe1hg5rD3VnF8zn3yAUYJ3f4JohAPvltVpxTqDOyc9HwiW6TZUSLU0gm3xQEjjXd7hgeMfCA4w6DJ4B8=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 09:37:35 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:37:35 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Thread-Topic: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Thread-Index: AQHa8t8jjswmZoXsAEu/fk9dkDwWsLIv4csQ
Date: Tue, 20 Aug 2024 09:37:34 +0000
Message-ID: <PH0PR12MB5404B927720EA127895F155DF68D2@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20240820085810.2831063-1-Prike.Liang@amd.com>
In-Reply-To: <20240820085810.2831063-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=21a6c5c7-e0c2-4c21-b175-8200273d6bbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-20T09:31:43Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|SN7PR12MB8057:EE_
x-ms-office365-filtering-correlation-id: 165a2035-9096-4422-f20b-08dcc0fbb8dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZYzIsc537u+NuI/+o3odWUpRumcXcPtkSLgUmBonIjQK2ZUdUNgxoc03Hbwg?=
 =?us-ascii?Q?VPSwPYBAMpRfxKZm/Pt9NFhLg03hoOBJFJmTC2x7U9iDRmd7Stv7PU/GLnIl?=
 =?us-ascii?Q?dMf4MMS475UMg4BmAUY+dbAf8eDhcnj4cspRtvYIvltWlFaU/rlofvZbOIwZ?=
 =?us-ascii?Q?WXES9I6ciN393KjSec4MHPg0EA1eOI9H5zlWafiGJtgXgQMgQXjJ5a6bAEaM?=
 =?us-ascii?Q?kos1qDSBIZJr8mw8dZSs13eTSRKM8ex+LJFKeN1UZOw4SwFEoL96hav4iLde?=
 =?us-ascii?Q?AFV9VXalDj4DMzfhm4SRuQCzdIG09xac6N0Jqb8NwXOby+W8eYEINFbHjgPF?=
 =?us-ascii?Q?MQyb6ObhS8UvPQvoYf3qRcZnrXqR1ovU0lyfLunDW66wuWj0Diw2+DjIwgJi?=
 =?us-ascii?Q?D27eXSsZCp0vd3UXsTT6MpNfZUPBVWG6M1WdgNJqqJXgJWpetWeWXBz7LhAZ?=
 =?us-ascii?Q?qEgcL3uW1iQVP1RTD3xNbeSQ3TS2MLmhq2jDH5rwwQ2whX6wKhFU5Ura6Pfv?=
 =?us-ascii?Q?80hkYU/Y/A8yQfVwWehkOnoE8nIC4RrMgpOow/IXd4Pz5Vv6wMHvvHEPFScx?=
 =?us-ascii?Q?nd7bKrXyxcw9tXM+mduC09L1YSrWBNh2JSpWm5PiV0jVaZKunJmu14klO2KL?=
 =?us-ascii?Q?fa63hhuyC2ky4b5SqLx943EnnvM5cTDSr6b1Kq1cfCdFQPkhnOL1TUwftrUK?=
 =?us-ascii?Q?wAoeUl/veEciHaZOjq065eiKljeHhzZFwv5FQ2JcalJtQkVffDnAYiNNlTv2?=
 =?us-ascii?Q?olATtDYAl2UqtZkXmSTY/zgDK9G8mnsCNjOAPNjk49zCki31zDK9PHwMrgf9?=
 =?us-ascii?Q?pock9O9FQG41jlD3E/3bKMNmS5PRvJCPQoVwxjBUT+d2JlmpcwERC/EiUQRG?=
 =?us-ascii?Q?6YG7nOoP4Z/53Lr+TvsMw/rnDIoiYLsn/ejYwcUe5utikgnObP0GqSwcyJHj?=
 =?us-ascii?Q?LQ6iZIwF6cctlb3quGn6kHUn0eic55yjjYEMfqiXbWHnnr1+cMQsDrpRcJEL?=
 =?us-ascii?Q?Fw7Ht9qtVe1fPxRyNbcy70PO301O1g/IIm5Mv+rVdQecC3XfRH0jrwK6+WJI?=
 =?us-ascii?Q?Bh9ylzWTmUGKcPzoKNUX/dovGtzrt5US67gDXtpovHXRYLHTedjH8Dy/LY86?=
 =?us-ascii?Q?CCDivbFGVkdka0BrPNi8g2KTsABjbN3kVGzCDhKh1Z81696V2UtoCrh6x4wG?=
 =?us-ascii?Q?qNcy6Q7lU4QADBFATzjHz/g6LhlFg31cWvJYyS+0gmndJcpYD/+1TdoQt6lq?=
 =?us-ascii?Q?wM0irjIFTKxatgL89mC1FEw5C7CwsIFeSIh/HL5d9scCOgd+t0XVOvrcWu5P?=
 =?us-ascii?Q?FJzrwEvdzfxtpYxAxRdsd9DCfyeZRXwv/zvbyeTW7HupVsJ1QC9sL/Ok2ziT?=
 =?us-ascii?Q?X/SR8qAJhcy6kbiQ1NFeSZZihtdqRp8uU/r0aENAYDGknDS1TA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k63IFx17L6VYWycrhj0lA2fz2zzNneGS4lXq4dEe2Pok51KgO7kGjJUrax6I?=
 =?us-ascii?Q?mXLLL4CeCGs2r06h/dIj/qR/gQbB/ASd0FTqlnRXNXX4s3dDU5JDkFGgtQb/?=
 =?us-ascii?Q?vOpH5H++T2CtFhTNJmZZykAWH77ly1jfdIqRny55YPxICqCnD3q6TGpDCald?=
 =?us-ascii?Q?bX9GxHfXd5hC0ncDCoVEDnIjzo2FJhtKz9dPshHIrAG+SRhKZssobo1y5x5h?=
 =?us-ascii?Q?UW81xmpIWorfPlzo4zVbOywpqRUz/NYvYUSFCPPSqSefv+r1/uXAXjEleqp8?=
 =?us-ascii?Q?LBo0PJMhkRHrLXgdgXhy7klO41Yr37SPTDe4eDSFux3aJKvAA5hU6V1jVJtP?=
 =?us-ascii?Q?Gqr7zJ9tbL2RAiVf2HZM9w3BzrXRaxfn3VgUT9s/PX2c5MyZ+bZELQqCeL5H?=
 =?us-ascii?Q?5lsKfqSsB5+fY5J8uGlR6K19nZskTTs2jDh19zyNADiCZh+go/Kdujj2fnQt?=
 =?us-ascii?Q?cyun2O86Kuw/HO02ZLzrwc/HVhdwGCIfjpEGjDH/xjrEfJLOgaQssmaNnD2v?=
 =?us-ascii?Q?ASFy9PtAdGoopSqJfs+julJiOXhktLN2bol0e//r3WeRjsvr86woOI0URCyP?=
 =?us-ascii?Q?bCY/pGdsojG9rc6NucY92jLJiVXuEvrt7aE8n3n1F7VNoXETR6oe8jaloyvU?=
 =?us-ascii?Q?2a9R2CeDFb4etfCis+D+Jf52R0E2KheqhzfwH3Ql6wsinBkCHbyFDzl7Q7qh?=
 =?us-ascii?Q?yx1yvtySkFVYDWaPBNrwmKw6YnMLUjNhzxJ4FctAc2xOdplU9XHcd+w8zrC6?=
 =?us-ascii?Q?hVjGHfAOSiRvx56SYMHjP+ZAni64JV/KCKuVi3doW2H2MxGZUaLw4kxs/+rd?=
 =?us-ascii?Q?xYSl3Oe3BxwlW8kr8NmemVISjQI1KmZEMqwGVByp9dPs75FO2zjTcOvOw+6l?=
 =?us-ascii?Q?U+c0sXaB03mjIXep4REidZ9QFMLgZMNznRinhKyz+9SmOPOE35kbvliBt0jF?=
 =?us-ascii?Q?VLYTciZx5+4ztz33vCbfKu+QZghtEnzqPOXJ2g3Hp0UYtuJlAupstopdW2Z1?=
 =?us-ascii?Q?9vNEoQOwSk087oVGY+VAyvow4sThIGB0mkuXHIV/Lbap6kohQUuqmgFoNwrO?=
 =?us-ascii?Q?18uXrvULVhD1hJtTCKxyjnxHvRW3aQpRDwYJwyIi35vr/eiRavwAi6MWtixB?=
 =?us-ascii?Q?jLLPES/w9xe7x3MQuyljzfVoMFbcdUlnfHvg0GsmfXx6WDpd1+ooI7xPhRdl?=
 =?us-ascii?Q?j9x8Ng4pJlDzF6xATGSvmLUeytb6mDONFvXkZxqpx8HfxilBU1MJWBHSOou5?=
 =?us-ascii?Q?w45pfFhfhL+qztml3zqS3oD757M22b0fnPbejLEO1zKulWoo2i+UsVWNClWn?=
 =?us-ascii?Q?Z7eohN397cri1M2z5w9N8/8u/fkEB5B6RQXtk4/jAGTcEH6hrQRHhG0N5HQi?=
 =?us-ascii?Q?QGCkl7YCewN3/2gH/4W7U4I2K9E1B6SV64NXDBsL6nrlJ+LHF2ulqJ/8ZPUZ?=
 =?us-ascii?Q?c3DHNNBTX3v2SbS8Vaj6vnbwdCi7hO63nnrgVEj5hO6eulpdPByh0K5sIqWD?=
 =?us-ascii?Q?C1TgKLImU+iUqdfFtqtG55YDRqa4kPsB5QhjoKouXeZ0PJ1fwwMWj7BG/gLW?=
 =?us-ascii?Q?OeNfxff69+9rOXt2+KI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165a2035-9096-4422-f20b-08dcc0fbb8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:37:35.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8+3qxxI+ZMjN33KlyCAiZyPnLDcTeSwBxunXUeCSvr/3M+hlL4xyFMmhY2rueQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike
> Liang
> Sent: Tuesday, August 20, 2024 4:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
>
> Implement the compute pipe reset and driver will fallback to pipe reset w=
hen
> queue reset failed.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 153 ++++++++++++++++++++----
>  2 files changed, 138 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index e28c1ebfa98f..d4d74ba2bc27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
>                                  uint32_t queue_type, uint32_t me_id,
>                                  uint32_t pipe_id, uint32_t queue_id,
>                                  uint32_t xcc_id, uint32_t vmid);
> +     int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
> +                                uint32_t queue_type, uint32_t me,
> +                                uint32_t pipe, uint32_t queue,
> +                                uint32_t xcc_id);
> +
>       /* Packet sizes */
>       int set_resources_size;
>       int map_queues_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2067f26d3a9d..09caa5a1842b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct
> amdgpu_device *adev,
>                               struct amdgpu_cu_info *cu_info);
>  static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int
> xcc_id);  static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device
> *adev, int xcc_id);
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +                                     uint32_t queue_type, uint32_t me,
> +                                     uint32_t pipe, uint32_t queue,
> +                                     uint32_t xcc_id);
>
>  static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>                               uint64_t queue_mask)
> @@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs
> gfx_v9_4_3_kiq_pm4_funcs =3D {
>       .kiq_query_status =3D gfx_v9_4_3_kiq_query_status,
>       .kiq_invalidate_tlbs =3D gfx_v9_4_3_kiq_invalidate_tlbs,
>       .kiq_reset_hw_queue =3D gfx_v9_4_3_kiq_reset_hw_queue,
> +     .kiq_reset_hw_pipe =3D gfx_v9_4_3_kiq_reset_hw_pipe,
>       .set_resources_size =3D 8,
>       .map_queues_size =3D 7,
>       .unmap_queues_size =3D 6,
> @@ -3466,6 +3471,115 @@ static void gfx_v9_4_3_emit_wave_limit(struct
> amdgpu_ring *ring, bool enable)
>       }
>  }
>
> +static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me=
,
> +                             uint32_t pipe, uint32_t queue,
> +                             uint32_t xcc_id)
> +{
> +     int i, r;
> +     /* make sure dequeue is complete*/
> +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +     for (i =3D 0; i < adev->usec_timeout; i++) {
> +             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))

Should GET_INST be used to locate the target xcc_id here?

> +                     break;
> +             udelay(1);
> +     }
> +     if (i >=3D adev->usec_timeout)
> +             r =3D -ETIMEDOUT;
> +     else
> +             r =3D 0;
> +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +     mutex_unlock(&adev->srbm_mutex);
> +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +     return r;
> +
> +}
> +
> +static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev) {
> +
> +     if (unlikely(adev->gfx.mec_fw_version < 0x0000009b)) {
> +             DRM_WARN_ONCE("MEC firmware version too old, please use
> FW no older than 155!\n");
> +             return false;
> +     }
> +
> +     return true;
> +}
> +
> +static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
> +                                     uint32_t queue_type, uint32_t me,
> +                                     uint32_t pipe, uint32_t queue,
> +                                     uint32_t xcc_id)
> +{
> +     struct amdgpu_device *adev =3D kiq_ring->adev;
> +     uint32_t reset_pipe, clean_pipe;
> +     int r;
> +
> +     if (!gfx_v9_4_3_pipe_reset_support(adev))
> +             return -EINVAL;
> +
> +     gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
> +     mutex_lock(&adev->srbm_mutex);
> +     soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
> +
> +     reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);

Here the xcc_id is also missed to address.

> +     clean_pipe =3D reset_pipe;
> +
> +     if (me =3D=3D 1) {
> +             switch (pipe) {
> +             case 0:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE0_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE0_RESET, 0);
> +                     break;
> +             case 1:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE1_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE1_RESET, 0);
> +                     break;
> +             case 2:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE2_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE2_RESET, 0);
> +                     break;
> +             case 3:
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE3_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME1_PIPE3_RESET, 0);
> +                     break;
> +             default:
> +                     break;
> +             }
> +     } else {
> +             if (pipe) {
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME2_PIPE1_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME2_PIPE1_RESET, 0);
> +             } else {
> +                     reset_pipe =3D REG_SET_FIELD(reset_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME2_PIPE0_RESET, 1);
> +                     clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_CNTL,
> +                                                MEC_ME2_PIPE0_RESET, 0);
> +             }
> +     }
> +
> +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> reset_pipe);
> +     WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> clean_pipe);
> +     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> +     mutex_unlock(&adev->srbm_mutex);
> +     gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
> +
> +     r =3D gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
> +     return r;
> +}
> +
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>                               unsigned int vmid)
>  {
> @@ -3473,7 +3587,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring
> *ring,
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
>       struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>       unsigned long flags;
> -     int r, i;
> +     int r;
>
>       if (amdgpu_sriov_vf(adev))
>               return -EINVAL;
> @@ -3495,26 +3609,25 @@ static int gfx_v9_4_3_reset_kcq(struct
> amdgpu_ring *ring,
>       spin_unlock_irqrestore(&kiq->ring_lock, flags);
>
>       r =3D amdgpu_ring_test_ring(kiq_ring);
> -     if (r)
> -             return r;
> -
> -     /* make sure dequeue is complete*/
> -     amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
> -     mutex_lock(&adev->srbm_mutex);
> -     soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0,
> GET_INST(GC, ring->xcc_id));
> -     for (i =3D 0; i < adev->usec_timeout; i++) {
> -             if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> -                     break;
> -             udelay(1);
> -     }
> -     if (i >=3D adev->usec_timeout)
> -             r =3D -ETIMEDOUT;
> -     soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
> -     mutex_unlock(&adev->srbm_mutex);
> -     amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
>       if (r) {
> -             dev_err(adev->dev, "fail to wait on hqd deactive\n");
> -             return r;
> +             DRM_ERROR("kiq ring test failed after ring: %s queue reset\=
n",
> +                             ring->name);

Normally the dev_xxx print is used to trace the socket number where error h=
appens.

Thanks.

> +             goto pipe_reset;
> +     }
> +
> +     r =3D gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue=
,
> ring->xcc_id);
> +     if (r)
> +             DRM_ERROR("fail to wait on hqd deactive and will try pipe
> reset\n");
> +
> +pipe_reset:
> +     if(r) {
> +             r =3D gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->t=
ype,
> +                                             ring->me, ring->pipe,
> +                                             ring->queue, ring->xcc_id);
> +             DRM_INFO("ring: %s pipe reset :%s\n", ring->name,
> +                             r ? "failed" : "successfully");
> +             if (r)
> +                     return r;
>       }
>
>       r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> --
> 2.34.1

