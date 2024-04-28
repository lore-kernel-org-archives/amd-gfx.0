Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2778C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 04:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C807E10F940;
	Sun, 28 Apr 2024 04:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mTMQ7R2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77A5710F940
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 04:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHDamaEaQyDLKKsi0e8DFsm56XTF3HJXVrEq/yZVUERJBw2DJzS+dV5xXQd/wms+pw1wf1rtRiEb1ov3Fu5UoWaGyO9Sw6p7bExFK02BjLicWQn8F0E5A5jEbnhpS0THTP0mPKONZSI7fc0YK5vODQjvAAEBYo5mMcg0di/DsMS2KjI84XyFj21u3/P6KhtI5B0BGzM86t9B0Vg1WWWzWsPCU1NVsbH3zIaWPSTw2uZyhYzB7UaJHjii7qane1rqlcOUZE/Rz19ftMwPRIeitGS0iFFCkjRgbqy8Q0LdMl7m6pEBIwrCtsH7Zx2i9RSm1ifLJcCZlSpZlS05+AkXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/lQqO3WR8yA/WCITIYSu/U+F1j9d9X4NxxM1ux4rdw=;
 b=R84DN8xYNj87N6Cy+ua9tclkPzgLg9S7EMo3a1WhSQVpkO40bVfGnu1lMwo2Ck+JnAbSEo3zGj+ndR1/yb4fPxxZrDM9T0dV+hkr+QeAKwhn6jM7tXL1m6dtE0bL9d3X1UVDqkVnRgZCbN+35ziWjTpibmAzRbI/qjc1YrXO187YnAulhjobbe/j2iZ9LTAa4TU3AodSPoKgzte3Hu4iuPEjuCCFtGURajmnsZR2wdMZgWQUemtfRn59goti7jOGMgWZmEmZZqzEA1K1YgW8rY9/dmMpcSGC3MhdHFBrqaWbsp5jmrBItSnisgGd4JAdF3ckg+rYrSaMIDSwK+Fvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/lQqO3WR8yA/WCITIYSu/U+F1j9d9X4NxxM1ux4rdw=;
 b=2mTMQ7R2wKfnBGIQPlRO3Km+KlAQAs4Nzmy7rju7pa41Etm0V4v32DohhCcXwbLHDP0KfWSfQY3qjEQxYoZLjXYqO5XlTmsXkec977V2AK8Sf13KQ+eoxzr5l8aj/vJzRjiVj48tCHJ46tIvUpaenrtT6Sf5/vYqf63ntMTlEfs=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 04:34:17 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 04:34:17 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
Thread-Index: AQHal7+HsIm4xrNX3ESv6mT2P4HkS7F9F9vQ
Date: Sun, 28 Apr 2024 04:34:17 +0000
Message-ID: <CH3PR12MB8074B30E07BEC18FAB4686CBF6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426095243.1075290-1-jesse.zhang@amd.com>
In-Reply-To: <20240426095243.1075290-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c78b9bf5-e470-4bb4-8016-b2e7bd9ac8d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T04:22:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SJ2PR12MB8781:EE_
x-ms-office365-filtering-correlation-id: 0266c42c-91be-4e40-620e-08dc673c76fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?/M3hFxL4QtFYqtcrgDMke+oDgibzsCldjjdmssQeGo9EtQOXKoMqqK6QGphg?=
 =?us-ascii?Q?5G88DBmthrhZAXPc4RNx3y2tgEHqMkHwXiWQDg1/r9miRv375QzLXJ/txVwQ?=
 =?us-ascii?Q?QX6yetJbtEmV7NjBNu0RlK5L0BU/fus6Wn4GMYaBvSo0++vFBHxRFpp7u/23?=
 =?us-ascii?Q?i4rALvge8QcUqjzOXSDxer/gb2oKRNCGpYnV6zlIhzfpDkRl0rfXXEdOGhFa?=
 =?us-ascii?Q?Zr9Ype7ssKPriIs+RsEBkFU/DU//ZTX9BfLfUUU8GzOKRatn6ekfODhbRao4?=
 =?us-ascii?Q?Bq1Z/j8bWA2Kql3KdTX6tUTireNwSV6OlwIkoe/5DTxzzrw/C9KqSa+nCyYv?=
 =?us-ascii?Q?hJIKAdkjNCBnYAf3njx4v30H4ZviBPPlTshdNfaBEgQstwr8jWNhLyo7IQzF?=
 =?us-ascii?Q?nfNWP5bVQqB3F6IOZf45qjxA2/TvmBp+HJRzCUUEs5i07kQPmn2L83RDsqmt?=
 =?us-ascii?Q?xUCDUk5W6DR2kASc1w1pfLO6HbuZncXXM+1Yj8jjkQKTV9KTCt8xMq46Ntst?=
 =?us-ascii?Q?RTGNEdxi6icTMpRuHbusceok3BqvnzFhskHsKol6uQZ+QmZ7WlePxfaMXYSM?=
 =?us-ascii?Q?+aLOOs5khDhse1XvdeKpwjE64XnqGhIdLtZ3CPhkx9Lg6YSXReX1yb91H+mu?=
 =?us-ascii?Q?00+krLtOFH+WyaaLoIW3y2jYSCmDeJJDqAqdaz2/Ro+SaBqZ20gpAZRSyDsY?=
 =?us-ascii?Q?lWmUIVSKtgJippeAefJdTcSMwU7bSiaK86bj6a67RjNJf512NV+5mFUmqBqR?=
 =?us-ascii?Q?pm0z80tpCS9gPbC0amik8yUSJckk6UpC6hfOhhEndhqHHDW561S0GWcwCpGm?=
 =?us-ascii?Q?cV6hfyCAB5FN9MchtghXRgcSTB+2lNvC/Df1mzU0qPGGAxd9qRz7TCaI7V46?=
 =?us-ascii?Q?2GmEI0h0UT5ySffef+4zOTvNE4t/dfHDtExM+iU0sOqknnbws+C3XZePlqEq?=
 =?us-ascii?Q?HzbJZs5LjNHZi5aCfaOAPNz5+Fk7BTYKl1aZhA98lLw/Kkoz963OHSUqqZcd?=
 =?us-ascii?Q?iXmGPPIH5IMkNM1EzlD23047mN3MnDXlwM/M4Su4j1JYditZXcThc2NvyK1I?=
 =?us-ascii?Q?kqLTOkbgrr0FY7CWKweN1v2vg9KVI04JgBqeKJRA/dmor3zFy1sYIjPBpU3t?=
 =?us-ascii?Q?Fi5+Em/ZWQF1ut2BDG89Wg4hLkIuDQA7xMG+WL3S741Hk+Zbr8tHNXFpwTSs?=
 =?us-ascii?Q?FO/59TYU5uQzkfwTZIQvhphiuhy5PCEugaajEXxGIGl4HXaMG4BW9SVuXcrf?=
 =?us-ascii?Q?7q8e94unxro6gy9GZWPyQC9/FA6BgNoeoUL6uM3OUcYGodZWSavzbho5c/IL?=
 =?us-ascii?Q?jJjdvoC5yb+Q42MD6JQxSTBWX1vL7rThCtyn8+MJaP/cXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxQkh2p3voxYYULNrxuW+kqNEHzk9MfDDbT16Fz5/haJOgqLJCo68gcURKz/?=
 =?us-ascii?Q?ShTz36RawGOSJz7B8/YG4929wo1Dt54AcKQxyY5Rgh3bcaeikdXBnXR3Akj1?=
 =?us-ascii?Q?0+5n1k90pQE1UlAEfcDCWq0t2/B7NPjoqTm3te1escm02v0f65yihJcHYR1g?=
 =?us-ascii?Q?F05tLwfeQoqX7XaOsDD1OXdg/5S7kHbf2mmij8HcD+hgu2NqVJ+JBpZWcDJ6?=
 =?us-ascii?Q?hibJW0jIWCNkg8k0/B886AYZqmS5mDZiVT0akbQnaoqL0aRZb3MgsVTX/+Z1?=
 =?us-ascii?Q?PsmdoauN6yL7ptL5g95EfKSmpOdUKYoGb95Rk+az22UhO8vuigN927jHjaZC?=
 =?us-ascii?Q?qBu4vKOfri7qFRgtOJ9l9huFv2NLCrBvI5W+wFKC926Y2Ob3zgz73KJUZu8R?=
 =?us-ascii?Q?rTxUOjvKHR8WPLsqRKIKsaMfZE6odMHcnJH8V9mVx1ZQLa50ddfzJHCTO2sT?=
 =?us-ascii?Q?k/kMSFCCvTSsg5L5KSKZllcrYQFKBJWtZow0DwfWxZU0cJYCar20SItlS4Cc?=
 =?us-ascii?Q?svOlPQuiY82cgSjr/i7quRZQShyH8dFMBIOb168VptogYh4rr8A6V/U2vMZK?=
 =?us-ascii?Q?AvzkdVDEO4WQZc+AWvF4H7ZY33f2YSP2yRcQgfD2AfG7t2sKXucvyQyDcgn4?=
 =?us-ascii?Q?n9kULb2dHsoZ5KhO8enl6uRmQ+fZlhqOLWsBXbiB+VOh8uW2EfzFiQMn0gQy?=
 =?us-ascii?Q?fmPYPKlPlwK22+ua2Ml2H06j0XcO40FLQN8lDEgG0B4jyQBnMQsvYYB686Bc?=
 =?us-ascii?Q?xwLhry6z43OjE33P0V1sNUB8nfsJelouUiecpj0FDHc/SBgwwVJgs+AB+FgW?=
 =?us-ascii?Q?wm1T7apd9vNPPbTCBfqTHG79XbsduBqKej1/mTLvEaP0LjUHth1bupZXgHgd?=
 =?us-ascii?Q?XrVb6vObUL2zpPDT3RF2rNqLJDD/kBLI5ChAO07G847Axvfw/hzRNGLzpL90?=
 =?us-ascii?Q?A6JLmVWcydttKuQnLWT6a3XnlAE8Nm4g+BSLDmiXHT+5QkEORysJUJPBsPvf?=
 =?us-ascii?Q?MJLLegcW2k8o8FHvG46mKiAeVuf8jQlubOkEwgCsKGwzWusocvUacivvjDUp?=
 =?us-ascii?Q?h6mpXhNsFXBeeROlmmCHz7HIm3AhtSVuCkFlwcvICCLUT+jdE2AZhINbJi5R?=
 =?us-ascii?Q?UHV20oX4NChRreA5kkJmJwRK5QktHRs5GEJ7oG+N5U5b1uvoQVcsYw6HzcSU?=
 =?us-ascii?Q?IENgsHDKFqUYh3IH9laBASQdJFDgEFDtojikKb/fcvVTCITmaB8eJUN0CCVn?=
 =?us-ascii?Q?sjj6AUeSuZH91c+atC+5A5xPp3MPgI0EnPir8pgaUV8wBFTGvgx7t9SNdb/+?=
 =?us-ascii?Q?WGJBYbWUCJTyhjb3VtLcZ6Fcwa457zbiJw9Ir/SVukoWaA7NM+SWhZWTzsso?=
 =?us-ascii?Q?w16M6syDrd+boX14lrsEKRaFHgQxr4z3Q2HCXzeM/GKvk864ejnnlzMml/mx?=
 =?us-ascii?Q?OmbN9NTfSP8bXP9j47JNbLd622bIn0a9anNGGRVoYAOBsH2hpA9peW2rfAFC?=
 =?us-ascii?Q?B33RVP0t4nuqocBERbWS+ff45dtztutLEkKEfabORyf5n7GrETiK2wz1cKMI?=
 =?us-ascii?Q?R+UmxTGzfwfIMrL0VAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0266c42c-91be-4e40-620e-08dc673c76fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 04:34:17.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfD0bhc8n5JBrxe4/m0NVhdNsL9oswGvA10u1AHyh0uPjcs5Jm2GhuzR8VHjsFAPi36cVFWLuXPVbTdkgFkM4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, April 26, 2024 5:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: fix uninitialized variable warning
>
> Check the return of function smum_send_msg_to_smc as it may fail to
> initialize the variable.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  8 +++++--
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 21 ++++++++++++-----
> --
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 19 +++++++++++------
>  .../amd/pm/powerplay/smumgr/smu10_smumgr.c    |  5 ++++-
>  4 files changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 02ba68d7c654..f9f016cb60ce 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1310,13 +1310,17 @@ static int smu10_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetGfxclkFrequency, &sclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D sclk * 100;
>               *size =3D 4;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetFclkFrequency, &mclk);
> +             if (ret)
> +                     break;
>                       /* in units of 10KHZ */
>               *((uint32_t *)value) =3D mclk * 100;
>               *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 1fcd4451001f..5c95eda6cbd2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4000,6 +4000,7 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>       uint32_t offset, val_vid;
>       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr-
> >backend);
>       struct amdgpu_device *adev =3D hwmgr->adev;
> +     int ret =3D 0;
>
>       /* size must be at least 4 bytes for all sensors */
>       if (*size < 4)
> @@ -4007,12 +4008,16 @@ static int smu7_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &sclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D sclk;
>               *size =3D 4;
>               return 0;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &mclk);
> +             if (ret)
> +                     return ret;
>               *((uint32_t *)value) =3D mclk;
>               *size =3D 4;
>               return 0;
> @@ -4965,13 +4970,14 @@ static int smu7_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>       struct smu7_odn_dpm_table *odn_table =3D &(data->odn_dpm_table);
>       struct phm_odn_clock_levels *odn_sclk_table =3D &(odn_table-
> >odn_core_clock_dpm_levels);
>       struct phm_odn_clock_levels *odn_mclk_table =3D &(odn_table-
> >odn_memory_clock_dpm_levels);
> -     int size =3D 0;
> +     int size =3D 0, ret =3D 0;
>       uint32_t i, now, clock, pcie_speed;
>
>       switch (type) {
>       case PP_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetSclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < sclk_table->count; i++) {
>                       if (clock > sclk_table->dpm_levels[i].value)
>                               continue;
> @@ -4985,8 +4991,9 @@ static int smu7_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>                                       (i =3D=3D now) ? "*" : "");
>               break;
>       case PP_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> -
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency, &clock);
> +             if (ret)
> +                     return ret;
>               for (i =3D 0; i < mclk_table->count; i++) {
>                       if (clock > mclk_table->dpm_levels[i].value)
>                               continue;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 9f5bd998c6bf..b47e1ab12430 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -2481,10 +2481,12 @@ static int
> vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr
> *hwmgr)
>       struct vega10_hwmgr *data =3D hwmgr->backend;
>       AvfsFuseOverride_t *avfs_fuse_table =3D &(data-
> >smc_state_table.avfs_fuse_override_table);
>
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> -
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> -
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> +     if (result)
> +             return result;
> +     result =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     if (result)
> +             result;

Hi jesse,

Not have a return, Is this a typo?

Tim

>       serial_number =3D ((uint64_t)bottom32 << 32) | top32;
>
>       if (pp_override_get_default_fuse_value(serial_number, &fuse) =3D=3D=
 0)
> { @@ -3924,11 +3926,16 @@ static int vega10_read_sensor(struct pp_hwmgr
> *hwmgr, int idx,
>
>       switch (idx) {
>       case AMDGPU_PP_SENSOR_GFX_SCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetAverageGfxclkActualFrequency, &sclk_mhz);
> +             if (ret)
> +                     break;
> +
>               *((uint32_t *)value) =3D sclk_mhz * 100;
>               break;
>       case AMDGPU_PP_SENSOR_GFX_MCLK:
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &mclk_idx);
> +             if (ret)
> +                     break;
>               if (mclk_idx < dpm_table->mem_table.count) {
>                       *((uint32_t *)value) =3D dpm_table-
> >mem_table.dpm_levels[mclk_idx].value;
>                       *size =3D 4;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> index 7eeab84d421a..ac9ec8257f82 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
> @@ -185,10 +185,13 @@ static int smu10_copy_table_to_smc(struct
> pp_hwmgr *hwmgr,  static int smu10_verify_smc_interface(struct pp_hwmgr
> *hwmgr)  {
>       uint32_t smc_driver_if_version;
> +     int ret =3D 0;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetDriverIfVersion,
>                       &smc_driver_if_version);
> +     if (ret)
> +             return ret;
>
>       if ((smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION) &&
>           (smc_driver_if_version !=3D SMU10_DRIVER_IF_VERSION + 1)) {
> --
> 2.25.1

