Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE296CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 08:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E42710E10F;
	Fri,  3 Oct 2025 08:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x86tozOA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E71510E10F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 08:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQwIVwZLLqgT1d/pzPc4tOVB+ibjue3emFll3ZHePsTCgy3th0eecxTT2ci6HnI/AD626751c9sTuE4LR05vqObivHbHWmXz2J2Hg9PX3DQm0qeMXDJdCh9Xfi/kwA4UHRyiZtwaiu6Js+4l1YsxEOOa+NZtZP6ujURXmzinFu9OAVCrYobRI69NYPiJgZ5un0l3JuM7Tzokatihw1RjWyUmsWSwAw/ZAW1VZX3cof+mV4zTyEEI7rLqM/zSmjdMEUMEhWJwrAHPQTHf7+gQbCzyVjU/AAiNFQqOey+KyTwXtY9bwTZ1Q2krI2mP2jzKegcU6cJtNxpAARc0qgvi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbOL7ObFTMws+/6fu8IIA6iyFGYfASOAatsDx6Gz39Q=;
 b=dk2LsgzUpKPh+Qc+oLjxJOstzLuNfp+CFeyeLwNyZvJ5gurwDCvordDWx6qtoc0E0QpQqkGcjbO4OHCUP9NEtybhrsAUsQjL44KSSi63TGuiLsQW09qTeDf0N1/8Z4NTdo39PTu4DHq7o/3k9em0bIVJagmG8T3XSCJLmUv9X6YhOQgz8TS7IgasmGB9W9h+FcHnYbFtZzH0LE94A9D8LwDwfj3V7KNXHkaeDbpc7J+greTJDUcSfi6qI7XyVaLUYagvUhDvWXMjaLyh14yymoH5fTeFYUfj1DTWTCYjhA49oGfpsIMpsPm/JfdLtGJPjPz4+Psedb1jwboH0mV1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbOL7ObFTMws+/6fu8IIA6iyFGYfASOAatsDx6Gz39Q=;
 b=x86tozOAJneX0UH72KF7peBCH2ccKTgueKl5nm5b86HN1mW9ZjCyM4C7XtNVpxzt8SUfzsPqOazQYxMwZJvKR0zu6Q0cfAMy2qh0GWNiIxQIvCojhVCV1Hm/R/4xVGGttUls3SeVeQdhmon+cJ5uOGJhfnR0+KRxZ0vbDHPmtRg=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 3 Oct
 2025 08:36:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 08:36:22 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Drop superfluous call to set_power_limit()
Thread-Topic: [PATCH] drm/amd: Drop superfluous call to set_power_limit()
Thread-Index: AQHcMvbM9UL6cCRMR0ieG+i/6M/yJLSwGv7A
Date: Fri, 3 Oct 2025 08:36:22 +0000
Message-ID: <DS0PR12MB7804768DA193EA233BA32C7F97E4A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251001171340.561444-1-mario.limonciello@amd.com>
In-Reply-To: <20251001171340.561444-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-03T08:34:05.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|PH7PR12MB6489:EE_
x-ms-office365-filtering-correlation-id: 1d1790f9-7394-4fa5-96af-08de0257eea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CNUL9aLdi7WclLM4eklu2xvKqwWHRR/OjK9jdGNls3QHYRIPKiw/MfYvOMpZ?=
 =?us-ascii?Q?lidCOoG5nSgv8nKCxCAX4JVqKIWv7D7BJq849OxJyz7pX1tvCyi3E5BcW3GG?=
 =?us-ascii?Q?sxVr4YwxLj2Ir/MZdTALfjWGXScJF+UvUTwingHc4OwVY1vQR1y/zdlGIjAP?=
 =?us-ascii?Q?9LsVtk7amp9KeZu2NwHDUY5CIuMC8HgWbgtUEzLfyDa6Bx1PkyIZsEW8ny1U?=
 =?us-ascii?Q?4Y5SqhGA7Qn67U8PhKOoB3ETGtBlqY8mIbG2/5M4QIYDUuPdFNDm6FNFTwO0?=
 =?us-ascii?Q?ZTh6fBQ2d2+h0g1SlUdYd9sIrlfVRqRyzbxRBZtugJm1ioEOO1/JMRgv6rD3?=
 =?us-ascii?Q?84yLMikG7XLwJcjaDoI3jVxay+Z6ljG+uBoytQQKa+eTpftM8smCgxjSiLjK?=
 =?us-ascii?Q?fmw9mRbKmzGBMZK1mbHMkQ4xaiBpAfBoDCZqzcuDlYilACL5UniA6xNC49nP?=
 =?us-ascii?Q?BEJTBSzJgpsSzB8RiVrRg7GKfpPx9qgZypUYPfvgnXzlqcfwNRgKu0ztumC5?=
 =?us-ascii?Q?aRstVF5Prv2k3nUy67r2q/zreLytOgwAQk1OcDg7I9f6xZopnyB/E27uBOyN?=
 =?us-ascii?Q?jYsNyexafjUSKBqR2JgHHTTDWQCs96Y7yBp+Ke3siJfibGCTGjYFrVqQzKYS?=
 =?us-ascii?Q?mNfAq1lqIctA9MVJq1w4nDjav3CUJpmxDKo2vN3ABiJCOODwC+rwBsHQPtfH?=
 =?us-ascii?Q?JbdjWwL2QbLyD+y/tALUPta+Kt+ePWHWSdX/qInYcZ3WtKCM+OVX82xXWhPS?=
 =?us-ascii?Q?aFomewIzO8iR4BPT9aMnGQLjHZCJeicz+A3K06fSeou8GdWCsRlJtsBg8k4q?=
 =?us-ascii?Q?ygVZ6vI7Rp/bbnCm0Car5/02LP0zX+7YJtd9172kOwYN87xt5i2p3I5iV3yk?=
 =?us-ascii?Q?yjGBN7XNxBG6NepKn0qWQZY2kCdtIgpCdrdsyrJ3J3xACRLpVprs7Y1/0Q7p?=
 =?us-ascii?Q?0aqMm7u5uZw7gd+5pQvflDqzlZJyoMu++pdeDnSSqECgyMyxprtKM7jrl2Kx?=
 =?us-ascii?Q?4Pj/3Z1ypUAxJO9NHN8Sxe6o7NgSm0pO8zGwaiLFaNL6AVQgNFeAn6usSBa/?=
 =?us-ascii?Q?KvspB2xtaxeFp3Os0zVNCgPf6mK7HoBcthDBDGGHPGkTdHdl+zwmj9Vy04AW?=
 =?us-ascii?Q?gCQLU5HLSdjSg7NY1AX+J86rV6q2l8z6oz1LOuMPynML7tiV5uuWGtq7Dj2U?=
 =?us-ascii?Q?zWmN821bb7nDEm6+x8fCUlGYnK4VZBgcTyvT6IM6gGapAXmnKUTBPKEHl80h?=
 =?us-ascii?Q?ASaHRLIqMkv8U7lPS6aIp7FBeqxqnzH8NrwVrzSrr28C43yALQp9HmPgH8Ws?=
 =?us-ascii?Q?WscFfUtHMo6GvpGdC9zvRhHCq+pilnMu4iV+jcWsj15eksbKjJ5hWQjFKwmR?=
 =?us-ascii?Q?L999iIdikZ/92Iio+S0mGIkLy/Cu8TEhDkLlDQcubu5aP3827wVINyrvCEJW?=
 =?us-ascii?Q?WBb8yXHAmR3LT7tlRLs4O2ihZPeHMoVvhegLM042yGkS9V5Z4GfZiF1ZAbJG?=
 =?us-ascii?Q?s0WMaOb/igQp4cZTu57twNsyrWtWy6uixV8r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ocxOuU3xcXXmJSQBqnYsUJdJfAIfrQHD6yTEOSYMOCuZ2VtgHkt5q/k5/tO?=
 =?us-ascii?Q?xRcIocrMLb25pMha8+/s7uS+RHahpvdsRA+EhvFDa+VQb1NZjdnjIiXjysmx?=
 =?us-ascii?Q?FtOzv1KZ8knzoB9giwEyME2tM2500AAmbJzW6KStDQZRkhtfh8xGN740VunJ?=
 =?us-ascii?Q?FdmreTC8pUhvqpPsv5CQiTuT8cZMdH5iA0a2PMgpNcBb++JWL6TzJy6S4Ni3?=
 =?us-ascii?Q?dV+1uNHUAMoMtIfsSVuv4xsRvzzNIuiKhBPnlzT0kzuNDFiOJXiGeaBvPhV6?=
 =?us-ascii?Q?lTof0t6skEmlZhMzh0Bb0dmKWxT912Id48YT4TuRX5KolsnDM8lt91uPzNrC?=
 =?us-ascii?Q?xLHUA5rvmNKgyAJhF7qF8pwE8tKtvBviSkK1sDLi6+xDqxbE8Fc6FcaH5Ulu?=
 =?us-ascii?Q?wZ0Tiu3IrGGueWTj3Vn6ZJSBLHSv3o6CIZHPqJ+OR9iZpUpn71rV0oKGuOG5?=
 =?us-ascii?Q?9wW+B+TkVgQMw3IiR95zvOqkJHsPqqroCNDJT3O49kkXEqI8pNrsLRY8ADf0?=
 =?us-ascii?Q?ZWWGzEG2ryaa+6/6wSPZoPesXl0w1AFknrPhfTlfxAvu1rNrbYDjCzvbTO8W?=
 =?us-ascii?Q?h6g89J25hRa9eoS51bX8HhSBLnrzJCtUkGBq6dDaKBI+iCYJOJgFGDhtljBY?=
 =?us-ascii?Q?8zmqBu5GH+F7dU+xxKmkU2oMo2EHoXw1/gBcME9NwFQOTkEixlXlfFVlNTVF?=
 =?us-ascii?Q?Te4oFAW2+49g/J/IkGRNR3Zz3UF816VxBzslITYYjiGi1w8AKUaNXqOCU149?=
 =?us-ascii?Q?iz31dX4SxAxRV2JhazEBzny99WBhLp40uinb706EtQ9ZAqqWnxlxLAe+3mcI?=
 =?us-ascii?Q?pM23yQP7Ih0oJr2T7O7up7VD7YfFbFj09lR9Z85a2Y+EohI3q6xXIFCDqVWn?=
 =?us-ascii?Q?5GwqOtNy0ndrdNgZHAKaYarlwrzqZF75/hKN4TAKNx+36gFZtNKeQoz1rlvx?=
 =?us-ascii?Q?A4USFVkaFiaViB3jg3/rwP7k1ipMcb5RIVW1hiiXBTp/aJUJHSFO+k2fgShV?=
 =?us-ascii?Q?alYET2ed81FKH6bUsFJKHVcS7iv5Qjda0CMAjMqdCnJm7qAyandyusGOM9UG?=
 =?us-ascii?Q?yRCDZsM9cYoMwp5eyB8ak4PEQVvWuXa+FQcue3w1XnQTXegzgKpfYEs+al9w?=
 =?us-ascii?Q?NSX8pmYQfdeELcUQG3qBCXiNT0Nlk9PfPILBpktS4hIwhGWxfNiOXozzPXrD?=
 =?us-ascii?Q?uS4hpOtVOBagXWbDqsewoqV+/BIeqXMWhUXAFJmHjh+oaR1b8aU7yVkgIc1u?=
 =?us-ascii?Q?/5/loDMVZ6Pp78NvZU03kb/JG0yFuK09t+hF/kX0AGZKeW3C5r0KKfrdKBhJ?=
 =?us-ascii?Q?Ic90s8OJ6msL8LoxcdX6pPdAvN3B6sbzA17o/MsL0jWaug2DYrbdOdDkBj1k?=
 =?us-ascii?Q?gdfYdiafcZ61f42ANi8Ld5mUv3ho9ils/gcP1BS7pF/H0XrKP4kTli0HPJgI?=
 =?us-ascii?Q?SWUhQbCz4jm7HROuJNxnFPPD8UCBkCjUZmm7IB+pzZjb7KzveisiPZoZ3wBX?=
 =?us-ascii?Q?1UZcp5EU95lo6wD9yeayBo6E2BXX5db6uxP/OeGRN3Dlp0hFiEDhCsotY2eJ?=
 =?us-ascii?Q?160hTRrmHt6cA1RYeL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1790f9-7394-4fa5-96af-08de0257eea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 08:36:22.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSIyKLFlUNS7jKe8w7yeESeqxT23X4AP2SE3FYq4aAEUoKyBPz/cfcUpDMUxZ503
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

This is because currently only Vangogh has Fast PPT limit. The limit for th=
at is not the same as default one. It will be higher than the max_power_lim=
it. Since this is Vangogh-only, it's left to the implementation to handle t=
hat check.

Thanks,
Lijo
-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Wednesday, October 1, 2025 10:44 PM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd: Drop superfluous call to set_power_limit()

smu_set_power_limit() will call set_power_limit() if the limit type isn't d=
efault ppt, but after a bound check will call set_power_limit() regardless.

The first callpath is not necessary, remove it and do the bounds check for =
all calls.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ac99bb7e2e7b..431333060b72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2939,10 +2939,6 @@ static int smu_set_power_limit(void *handle, uint32_=
t limit)
                return -EOPNOTSUPP;

        limit &=3D (1<<24)-1;
-       if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
-               if (smu->ppt_funcs->set_power_limit)
-                       return smu->ppt_funcs->set_power_limit(smu, limit_t=
ype, limit);
-
        if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit=
)) {
                dev_err(smu->adev->dev,
                        "New power limit (%d) is out of range [%d,%d]\n",
--
2.51.0

