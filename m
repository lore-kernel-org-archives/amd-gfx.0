Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C08761207
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 03:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C08761207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F286E140;
	Tue, 19 Oct 2021 03:53:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5F76E140
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 03:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyoPe/U5hzBorTymHcQHzh6i6TTwrl1MZDtqQ9AK9RkuIxA+ZkFmgKzHQe7SgdQ0O4DHHORRlKDWPCbllFziwfuBB1J6/ZlUu+zvyzmJjAraXcscBPyl+tppKOErWuaRi5+WQv9L8kouDHNfAGi5nGHp8TESEhecwvx/SDFTscXn3Jq7fTMPwDd4bDutrJpE7NnyBXRimdegzgJ8mP4pkCeLJr2cfaJ0vIjDZk92+vPZcGvQIxpQ9HnS4CO/uqM2zzEx3Q+s2yIOt+wxzkBsOmcRwsskvR441mS+CBDCg8c51zQd/jwhuWTZ5ERENXKGix3ycXS/NpSIdBvLR5zQAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKwnuaju9Ao68Pl1NSJMpO3iBeAWYG8Sl3Wihg1rdxA=;
 b=XNRKAAT9p651dVwopJKkWFiCw1NU5WMqroalm0HUN02AN/ewbjCeCRw9cTysz0WN6Yb2Xx1N4zz9CP/eggj9YT4cCD/wwiwCQkDq5IaC4ztgUuLcy5/2/3ZNrsTvscDJWP6MLVRZMCawiqINmcTaCPrMgOo8UyIXrS/SjvlY5kVHN0yO3ljRchf6H1sMg6+Xjco4L0Cq+rVOhOvbuXP0Jq7WleyN6DF26mK4VRn31mnX3dMvPkyKDBS0xqh/FqsCvvYr4WSZIyhMji7jDc5ENQrxU9XKhrTNNRGu7VLcZvDjY6oXHAF5BTB7bTAH6Uw7VUIxAGyPl4LpGWGc30llag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKwnuaju9Ao68Pl1NSJMpO3iBeAWYG8Sl3Wihg1rdxA=;
 b=b5CGuWo20nIwdZ1uLXdD3T/L7Ffbm3IReDEvveJwSiX0Ma6u4ttd2IMwmMDp8X5VR2dV640lsn7p5/S5iKZDEDfMVT/LSVMThEiDoGD3Neo2900nPy8v5NphxZ7/Xuk2mK/izWmYMIxfBtKO+qAhCmcg7q1m7ItnOUsMc2qR8q8=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1445.namprd12.prod.outlook.com
 (2603:10b6:910:11::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 03:53:26 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 03:53:26 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support B0&B1 external revision id for yellow
 carp
Thread-Topic: [PATCH] drm/amdgpu: support B0&B1 external revision id for
 yellow carp
Thread-Index: AQHXxJiYLNwtOKmHM0+3jaxVKby0QKvZr8uQ
Date: Tue, 19 Oct 2021 03:53:26 +0000
Message-ID: <CY4PR1201MB0246E67CFC2E504C224D5DE6ECBD9@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20211019032232.2202316-1-aaron.liu@amd.com>
In-Reply-To: <20211019032232.2202316-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-19T03:53:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6ec6f51d-5a8f-46d4-986d-008ee272dd6f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7475c20-a28e-4a60-26e9-08d992b4015b
x-ms-traffictypediagnostic: CY4PR12MB1445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1445919204496B9EE476F1DBECBD9@CY4PR12MB1445.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GEcc4exZNHeEPqe3Q2oC62dDCF0XBHW3JaFkZEyZFA6DBc3s7ya3IdzzI945ptrjSqTqxxQ2Vt0dzkxavaImMKbZKgyrQCqLzv+n84HXniXDcnNkNI1lXCq/JmMkOqgfAa2pS5PKrabsHKkd3fd8mluu4sWgp7SzmWnGRnIz3kQ9co2F5HpS4WLGRkzKm9KQ/CXmYKFhvQvJuXaC9oG7rzxWDYCvzn+cDvR8aFebx7TWab6a/ag6p0i1WDth7K5YnvjkdShraCULW5IGLy05fwx3gYiE6Bvm6YAZUDuVYflfjqgQnp985F87WHQUdWvvKqfRx4IFnTVZo5gwQnLGaKrCuYxfd4NQp8qNblU2Wnz2GL9hFgvJgVEttKaYNsXHad0BwBGFqYh3hu/zVgEX/AE8NPvYyM25Yp+x93QChes72dhwHRwVt7N+SHeNiTCOwUOSGt9Vl6HqaHziOGromxF24e00ZS1G0ErgCGAuzr9JRrDXhBAbw9ITCXGaa7+dAjTwGvCmBTiMrsLrCDTJE2T7MiMqcPCh1EGpwtr/heE0v6rd7ybPMZGr62WzqJzprVrPQmUudW9P2SDE6ozMZFWomN8IcZRoQts37FIOLjBcJjM/hWRQxYjSd11uZAXCn7KXLAQ43zQGne1dAXpuioNdiS1y48+/BwTWMEwx+rGcOhFcfUNuYuXQRWqFfCt0CdM5p2Ifsow3kVryD1X1tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(53546011)(38070700005)(66556008)(186003)(64756008)(66946007)(9686003)(4326008)(76116006)(66476007)(38100700002)(316002)(8676002)(122000001)(66446008)(2906002)(110136005)(86362001)(7696005)(55016002)(508600001)(5660300002)(8936002)(33656002)(71200400001)(83380400001)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JQow4yLBR1ekLeIP3q+rt0s0+hDHk0OC5wDO7B0INg3T7iYfJT5yO89DHLWE?=
 =?us-ascii?Q?Ug+VWI45LfIjk3YI8krI+s0Q/8ug3PflFxUDowFpTCMmaeFKlW4LK/0t9Syq?=
 =?us-ascii?Q?PqWipme6HJk1ZmgzURY+QyhquVFz1fYDW1FigDapzZSwkXToqfHPNsEfTJ2R?=
 =?us-ascii?Q?cK+1usMvt4fw4UxlB7YVVbrGM6W4Z+WYxGNV/1/11bzWUJMORVkRRmYOSUyD?=
 =?us-ascii?Q?ONnXaj/gnstfSlSMX+cT28/7+MV1C/TDoTfMH17wILcQ+8PqzkqNQoVgm+Ds?=
 =?us-ascii?Q?7QtZZ51f8+O27SpRG0NK82BTkoPbsnSdTI8R3C4t2W2DDt7wgizagnzsb4Kd?=
 =?us-ascii?Q?eBXU0Yz+z+xSFEqRjbuDMXUwpTjDzqPerkej6s6eY7NX+N6Lac0S1kXDwYel?=
 =?us-ascii?Q?OX7KZW6TTB/OiOrTOk9RIpFynVjswJURK8GemqOPJIlCts/7lsnkllzYPoqD?=
 =?us-ascii?Q?ECcopUujAtSDsUu1Wr4f+kQkwf7fApuP4jUM1m2jgOuh7Pcz2BXjHxHPSjhK?=
 =?us-ascii?Q?xokpbnSXzX67oucOZozOPz9FFC171PSxo3VlTaicr2sXo6QTadHWWH/JwaTn?=
 =?us-ascii?Q?nr77ukM7aHu1G1gb3LbvrxzLrq2FTuYTd4vTw32UCGN8I+qDVz/I+YkmJ4g5?=
 =?us-ascii?Q?P2bbpeQSk6psoL2rAllBgUU4oQpwnfiF/UDDhoxdWltXckqRgiWVcCpTSmYn?=
 =?us-ascii?Q?LK9gi9lf+d+ft2xmyO+rLG8zUeJgG1l9CcdbBulWoHVqEZYl+LSoApYs+r2g?=
 =?us-ascii?Q?Zah6W5xaV18OGVAsrSNITObxL2BvfI4ty3lHPV6OqZtevZzyXzpjNQpQtLEY?=
 =?us-ascii?Q?1CwAz29iPnF5DYJsQ+aoguQ86P1S2Iq6Jpt4CgiU4AuExc+gOr+QUEjWBpUx?=
 =?us-ascii?Q?KiVUNuzaVLOYeYll0W0WFBifTwUJ0/JPPtNaG5eMU3zDiJ2Bv/FOJOgvLC+G?=
 =?us-ascii?Q?XFyvJtFfyo0XrZBmRCdsSyllzlh+vifqt6viuIwKyHygD8GCXooIb3IpARea?=
 =?us-ascii?Q?zHE33CKkrF24xRzfCmRgfpgW4mRiAATwtcQCE4MKoj96NPGhJW3b7g+btHb5?=
 =?us-ascii?Q?h+BO0iu6mrPQeSxRFL8TUvcmVRjuelQRh/Lm2boSuRjgVaeekRuI7nKSociA?=
 =?us-ascii?Q?jbquPwH9P7sxKYTfZM4vLKPH4+n5A0bQWuHLOEN68BycRX8Iszk9LFkWZzwR?=
 =?us-ascii?Q?e7hzQVZXAnv3L91mDXIUmi0M7L8O0RUNkdpQLlF4SWQ87t2T4a0FfD4K5h4e?=
 =?us-ascii?Q?VRZA2zWmWaax0nPmeVros2yOb1U8e0kfAXRInye/Q3K/OqEcntCt3eT5k9xg?=
 =?us-ascii?Q?bawJsFmlmnuyYGG2rhkmfiRA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7475c20-a28e-4a60-26e9-08d992b4015b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 03:53:26.2316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc9COYJrrWs2F2EA+Dimty7K8F3IWkYtOPujMZf9tCDagZ1C2YveM9fZ519aiC+vwaJmBaiVQWrUKrMKwyuZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1445
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

[AMD Official Use Only]

> -----Original Message-----
> From: Liu, Aaron <Aaron.Liu@amd.com>
> Sent: Tuesday, October 19, 2021 11:23 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: support B0&B1 external revision id for yello=
w
> carp
>=20
> B0 internal rev_id is 0x01, B1 internal rev_id is 0x02.
> The external rev_id for B0 and B1 is 0x20.
> The original expression is not suitable for B1.
>=20
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c index 898e688be63c..5166a1573e7e
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1248,7 +1248,7 @@ static int nv_common_early_init(void *handle)
>  			AMD_PG_SUPPORT_VCN_DPG |
>  			AMD_PG_SUPPORT_JPEG;
>  		if (adev->pdev->device =3D=3D 0x1681)
> -			adev->external_rev_id =3D adev->rev_id + 0x19;
> +			adev->external_rev_id =3D 0x20;
>  		else
>  			adev->external_rev_id =3D adev->rev_id + 0x01;
>  		break;
> --
> 2.25.1
