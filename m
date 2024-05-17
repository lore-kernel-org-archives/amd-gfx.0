Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC895C25B78
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 08:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FD110E1DB;
	Fri, 17 May 2024 08:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mE4O2SCh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF4F10E1DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZpdD1MjwVEJDrmEKwBD5Vz+rGnDl8HrLj9g140kHGfrtOjCofBmLBEfXmbNg70Xr+36JJRiF+AumFs28OFJ6bC7rzwDc+j3sdLxXcuZBAFmPMZc/xXX72mEQ2B6SxhmE+2RXjZdzYrLrrfWe8v47IaPL5hFTeKqT72hz6EwKsmbnya1d6gV7TtbPTjUbJ57pCPaGbJCwrm5MFwlC8+wmEr/Z6S81m+m0eyhQZjBIESimJW1zVxmhNYffWmADkGD5cMcM1jRhgoL9kzMtvlFMSZqPwgqYiRhDilEqOxAQyoRszqcBcVRSvEPIEqHyGQYryJEz08AOzbMgJtlFbimJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY13iabagb/G+Ru9/ya8Daw/JT+qRHl2yLez1kXg1xU=;
 b=AcgyFUz4d17PhNJPJP1pOKaSJiJOEmQmX08xwDw47c0/NWdjKpvH1ZkB45mhlMlgO3BU5QDrPj1ZpBsN0pnA78n1WmRs/my6fY64s5yr/1VQCCciZzLMMr3jr/l4/ZVci2iriOMsuO1bbZjXnXARvORLJGqw1PSsHDCRtpGls+iYHapBIBxZCaD0Y6MQeKr+W3M4wLikGvnCDbonQCWupTZkrubFeQ7SWjk2vuUtqHeEK33mMeUi+Nhfzn9sEGbHoujEeeEZvsa6k27sB+Ht598N0sTOv2vKOlzaFk72H0gOzuvuQ5Gjcajl9hsg1FGKiZImU82GfA43YadiS0eD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY13iabagb/G+Ru9/ya8Daw/JT+qRHl2yLez1kXg1xU=;
 b=mE4O2SChdR4X6K9eP+tFt6pxD8Qql/o7OXBkMf0DLQ18C3V+JOlSwArObeLGdBa2KVlNsxX5tnmxIRkmFC8bQsovokyTxcBK69O0BqL0zKXExzpy0Wtf/nSsCMnIBt//ouB9v5+qAyXsFBL9+/dS91D5xnaE+kq0Qv4XRb9xkxU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 08:44:46 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 08:44:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: fix ACA no query result after gpu reset
Thread-Topic: [PATCH 3/3] drm/amdgpu: fix ACA no query result after gpu reset
Thread-Index: AQHaqAw2LaheBnRvJkiQ793UlSEBKbGbHMHg
Date: Fri, 17 May 2024 08:44:45 +0000
Message-ID: <PH7PR12MB8796B49675E555BEC628B4CEB0EE2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240517034057.2015624-1-kevinyang.wang@amd.com>
 <20240517034057.2015624-3-kevinyang.wang@amd.com>
In-Reply-To: <20240517034057.2015624-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d6d9602d-eb28-40fa-ada2-fe379505351b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-17T08:44:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB6539:EE_
x-ms-office365-filtering-correlation-id: c2469529-a553-4962-537a-08dc764d9ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PWf6IH0+KqXm/Ewh1lalFJ5kSAcostMJK0cIZ0yl5/T/rBCVryiKJC8kYv78?=
 =?us-ascii?Q?9Rj3Va+RC6IIj8MMtn3WHPN6eHaNwE4fZoHuD1/H6/BragcTYKraByqcvdxc?=
 =?us-ascii?Q?gW8BxXUzl+plGg7itzGOvuQf3v7Nzt2DrqlZS4Sy52GWFPEpE7+/kWpjshvl?=
 =?us-ascii?Q?epGIkAImAeKC4BI17Pm8J+uiywWYds4LZbKh4vCXbJ7de5Nxx7HDDy/nVqXg?=
 =?us-ascii?Q?tE5esj+TQZWz94DWcIxP30mXPjiUvgyKKEzRFd+Ybl1n+E+B3IRvgbJgNDOt?=
 =?us-ascii?Q?FcI401KGL1FlIjITZHJA7iIU0I/Y1PpyX7sALsn9fnMKhSxygcQWOOm7cvPK?=
 =?us-ascii?Q?F5lWhnc07cMrNpKffJgE9bf0YbGjmjQeiqIfNhfRoSjFOyr1dknbrSDPkHZI?=
 =?us-ascii?Q?KE0c0bTEmBDXYkcZ3RG4MkzOubJptqix3e7pfDZE4uDFQ4lN9ETGyznaO/WX?=
 =?us-ascii?Q?CAcy8Ns0vDfu0YllWJpG3LmXx36f90t58pobmljDmdsrAh6XiFeWzkFECaDc?=
 =?us-ascii?Q?XcLWFmQhIDAUGI7/e6n7SRip9IJsV9fICJ1YX6KolZh/wIss+0Qia0PCv4Fd?=
 =?us-ascii?Q?I+9diiC+sC0g0p3lRiC39A2EXqYLWd30vgUHJVL7h1V4NagqX6No9uSg2MPr?=
 =?us-ascii?Q?ux55PIOLecU3WgqqcQ/e6G1HCSF786vkEKUUZdxYkAfZdqTGJslWOWaaVZtM?=
 =?us-ascii?Q?35/r3HzhS46zt7yGL3WJO27ZIxbInGuClPZw2EY6ScqFkMCFJh4uYE8NrJOA?=
 =?us-ascii?Q?dl+vCHA9zhdsGVBcFFHoVOTG0yWMZXi4GXCJgWAISMGs87fYDN5c/zpaNn8A?=
 =?us-ascii?Q?8ZDDMNMYyNh9VssCd575b2zrMVC1Gy+Hw9KYtVIEj28YD5CgoAqiDq3Pwkn5?=
 =?us-ascii?Q?i9Hp69nLmdR3eUqvB7M4bAU70L64ZXPC8QnYXwlMezA285+uGppCsUDixYQd?=
 =?us-ascii?Q?m19/xks8Gp3tfMxwac+2Iz/O71Der6ndQSm3MS1yROcY+pX8VHiTvpWPlDOG?=
 =?us-ascii?Q?qZ1Jq0TuACEuHjcMbDSDnti+fVC4KavFiY+x+ZIxZDEdf/H6WRI1Pbppm+xX?=
 =?us-ascii?Q?zM9hKD+YVUjkOVvNXo8YyIR/G8YLmBtHFLScFX64AlxiNfVPFK+Ev42u39UE?=
 =?us-ascii?Q?eHLGjQjUBjr99UQ/SBAsA0DEqLdkxc2egMypZCDclZZ9nu+gMdmcpDTv4IKJ?=
 =?us-ascii?Q?KkKheHo26ud5nFwkZATpgGYtcnhzrmyQTAo4pmuf+0FCNaLDyxX1hWXAYCcb?=
 =?us-ascii?Q?oSAFJQAxz9jcgg6QQxbVC0dRiHx60TAv4SxrB5+NhZXWWS3CPnpx+/6C00ue?=
 =?us-ascii?Q?aBSkdcyCq3gYC2khJlHtMNDUKwk+or7N/NTrqMdBrUhdNQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h1Sq7W6PwhKyQM+512ImwN1TmwZ5FVSoKt4p7LV0g1fMTSP5mNWPWWPJhokc?=
 =?us-ascii?Q?sKQBQe2ufnpzvZTO9A0m7yLYG0WG7WCJLljvEpReqFRqEC/l/wRyvl7SowO/?=
 =?us-ascii?Q?eCfI0N1ADPJtaOR1H21AzkpptkIT9Y3xET5L+YtB2nveBe/AqZBkUlvxqwY5?=
 =?us-ascii?Q?z9Jue96iRoBdeBMDlKrOLtxU5U3dFkKkVFxnuINiGZuhRdox5yqpaBATAUtM?=
 =?us-ascii?Q?XCO5gg/C5xHUFM1qFyhEWeAv3X4IoEzmAqZQcooqHJQrMFM4OJVfXIqQMfy/?=
 =?us-ascii?Q?FdMRFi/pohqTKjxd1UR/1VUeBnUUg+a5gyI1/HwtIgD27/nCXqcgO8XqZfuC?=
 =?us-ascii?Q?bH0KyAzEmvSmmDkEn6Cqu6UvVIY9GZYwZ0lMC5ycyGbpSCWAJeroAakbwDGq?=
 =?us-ascii?Q?3akDoR8E9mvYlvn3D8/xKa3ZS5iJjyODZRFc5V730dHaJ9e+JRo9lxYE0CWd?=
 =?us-ascii?Q?lTlXrYvADbuEvzgSV2FVKDaJ+o351psGPJqxJPzENvF4cQSWDH2ljkBAR3/p?=
 =?us-ascii?Q?AMu/6bj/PGUNL7X2pW67nzEkx134HqvXHJyCCwAu8ufKRfs8ygUWl08mWUFf?=
 =?us-ascii?Q?sHaBTh5Y1DnKjOKfXkzcpXjJN1GA/QaXpDYNCCUU4JoRU0KOCMDb3y8dgYIs?=
 =?us-ascii?Q?5HjuRL3Ciq56xHYy3wq9nUpZJRh7rkaKcTVpYSaN+UuFI4AGk5pN2rmStb/r?=
 =?us-ascii?Q?BdvLjak1MPQdQvy3W0HX13rTc1POIAgFtY96iPSFB2m7NE95pH7JcoOL4/zN?=
 =?us-ascii?Q?iFH8h/A1QlLhc9kv3JZZFvrDx5G4LZeLe71GMh5dgYZKC0SIcrd5FzWrdaUp?=
 =?us-ascii?Q?/CGpZh48qWWi6+j8C/kotJ7tk9XVWuRXv4gDJe56R2b/1rqNr42Dv14j8mOa?=
 =?us-ascii?Q?hb5YPDC77ULgVUL2Hsc5rZvjXgmhlUTmEUWEpZlpQnlYFWSJlgA5H1XjimFB?=
 =?us-ascii?Q?QXSBRgPfT425VbMXabybN/050ZdeG/HaaW2IFbhHcn147Fh/3UcS2oxzyG3m?=
 =?us-ascii?Q?esLVOpEFDS3fEIJVAi3zYdUnRFcud55KNOUt2a8Gb1o5MmvmzaPBHi1e0Kam?=
 =?us-ascii?Q?orPQVANjoSp2TE+kefKZSJpTdRfQPXM9LIw3KkNaAwV+oyyWiaRZBPXD2hxr?=
 =?us-ascii?Q?fc+sNoiv+v4+0sjK+XzfY3sKmEYe8kNOA6WNyKiEYChWmNZergQVXQx1Lrbv?=
 =?us-ascii?Q?zgW88lPiQJZAOhXH/IH5Uy4j9pA97twAW1aZDbbdl62tLSt5+qI/VjJKbVDH?=
 =?us-ascii?Q?C5qIFBqwMutG/0/saFexbeGb4Mj4yNuCVa7z1BZ8UnYPQGfGIoW+05X5kP4F?=
 =?us-ascii?Q?J5bVLMAOXCMN++T2tZ+Fnqdylh/g+jmKkNGJqMFSSLKXTrB+bP9Za25YJSpH?=
 =?us-ascii?Q?laKGW50IRKFQ68ob6QFCqtj8S/TKKXz+g7UQhD3DLMQACpl6/cegcbWTPIrt?=
 =?us-ascii?Q?xhV0L+KpuJCOgPDj+oIVSy7Rk12b9OP5WdxbNYxudYU3OH2FyQ4xApZI9mWF?=
 =?us-ascii?Q?Abti8NN+V98ra/lL7RTAUSxA7bek6Ya9KFX36e5J50KTrkKXhSUk3BbXjzvn?=
 =?us-ascii?Q?6bjkoTZymrdzOxrNB3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2469529-a553-4962-537a-08dc764d9ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 08:44:45.9368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egaWVGQa87NexR4K7Da+hO536IpAP+hOcgkQYstwzQpRIQfGvrjgQOBYKQ57cbTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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

The series is Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, May 17, 2024 11:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: fix ACA no query result after gpu reset
>
> fix ACA no query result after gpu reset.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 7 -------
> drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 1 -
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++-----
>  3 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 05062f2581a1..6c6c387e5a06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -712,13 +712,6 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
>       atomic_set(&aca->ue_update_flag, 0);
>  }
>
> -int amdgpu_aca_reset(struct amdgpu_device *adev) -{
> -     amdgpu_aca_fini(adev);
> -
> -     return amdgpu_aca_init(adev);
> -}
> -
>  void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
> aca_smu_funcs *smu_funcs)  {
>       struct amdgpu_aca *aca =3D &adev->aca;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> index ba724c2a997d..4327ce1ceacf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> @@ -192,7 +192,6 @@ struct aca_info {
>
>  int amdgpu_aca_init(struct amdgpu_device *adev);  void amdgpu_aca_fini(s=
truct
> amdgpu_device *adev); -int amdgpu_aca_reset(struct amdgpu_device *adev);
> void amdgpu_aca_set_smu_funcs(struct amdgpu_device *adev, const struct
> aca_smu_funcs *smu_funcs);  bool amdgpu_aca_is_enabled(struct
> amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 06c5f6e2ef7c..5af813eacfb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3617,12 +3617,11 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev)
>       amdgpu_ras_event_mgr_init(adev);
>
>       if (amdgpu_aca_is_enabled(adev)) {
> -             if (amdgpu_in_reset(adev))
> -                     r =3D amdgpu_aca_reset(adev);
> -              else
> +             if (!amdgpu_in_reset(adev)) {
>                       r =3D amdgpu_aca_init(adev);
> -             if (r)
> -                     return r;
> +                     if (r)
> +                             return r;
> +             }
>
>               if (!amdgpu_sriov_vf(adev))
>                       amdgpu_ras_set_aca_debug_mode(adev, false);
> --
> 2.34.1

