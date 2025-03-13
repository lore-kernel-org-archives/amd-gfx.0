Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8E7C282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 03:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7372A10E1B0;
	Thu, 13 Mar 2025 03:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QLeZmnsp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A9410E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 03:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgweInm/RlzYZlavzMpr+DbtWfCHKr6QQU4s7mYr0UL/PlJD2YDKAm9Vek0wNqnzMVaVFGgLMILI1JLsj2E2zpsH1MQuIATtAE8h39L0pa1UEwQqDzDTKA6qvLNzno2FeLGbsNyDTCx/vES/9nUOOOQf7SYW6/t2Gn1VKJAs6LWZmiordlC6Le64NQPvlVId5jt/axHEbSlGOVM5CSkMdqEq06r3QengJID30N0i9CJ0T7DRM+Pc5BTaN1a3ShfV4UUdSU06+ER/IR+/nfp3V8Fl6RTn8zbL8dY+hiDmk4f7X5a4IvMtuDg4RJmK9LPLn9jwhmBX8QdjV+FLZ17tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T22ChG0uwiBwgx3j59LGmC8GSHhKTmzdHOsEVRHawJE=;
 b=y1diGpK2SukzIdVj9+ZpsSD1m2g6063LZGk9evR3FtnRPY99vmtIYa/0THK7BeziwVxV46PyFA8wJvPZaC7/ER14zbRf3bphiV439t05+F5u/63XNVXVLh0QQAQYd9pHbrqtTSekSxjV4dBBlNyBj5Ot4ytGbPt34jftduZStZARjtly19wwGlb2dTfSGMiCh/tZGhvdmUoS/AbX9UnyCdN+Z42TWqJkZ9QUk3Cs4JeERsaWtbn66feyQzjSKLce3KjnTs80C//4+QIiYLTRYjwpcjY7LIOMUxjnkPl0jycJmAIVWnz8rzWA7pXwA1uJdZhk8CwuXKGppFASpxT52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T22ChG0uwiBwgx3j59LGmC8GSHhKTmzdHOsEVRHawJE=;
 b=QLeZmnspq/AOrvOvRuG90JdKW+A9ibpkYo2pKmFXpu+xfMb9JB5krHNvt0SXotmThmJQPWXNx1bcqS2y6VEhBsOX45EDznoTT8KQaVgqjKE3Qr1mAG2LaanON5394JSJxw8SVtuBp1AyqkUEYbcFy4rjJYZaSUCqhOQBZuKBnRY=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 03:41:18 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%5]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 03:41:18 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
Thread-Index: AQHbk8nHpIdrU5wZekeXoY/5fqNYgQ==
Date: Thu, 13 Mar 2025 03:41:18 +0000
Message-ID: <MW5PR12MB568415D133F1AD9683B4FABBE5D32@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <mailman.1086.1741774146.1020.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.1086.1741774146.1020.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=48f76271-f2c0-4938-8fd1-0dc6c22c5998;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T03:33:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|PH7PR12MB9173:EE_
x-ms-office365-filtering-correlation-id: cbb47e6c-c519-48ee-a7b5-08dd61e0ea01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|4022899009|366016|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?T7PsxL+J+BZyVOWFW5vxO58OSqjdh9SNQMY5y9tRB6ppf6W1xHYqMl8uoMN6?=
 =?us-ascii?Q?mX0GxvaRfEmDGxdfTaUfowpw6y9zWQyt5bzO8mt2pPUu5BKjVl0AmJJG0DaO?=
 =?us-ascii?Q?A81BG0Kbjs3clMPRVfEo0fQiBcMDshse/qObNuIQE6JPowP91I2dz56truTD?=
 =?us-ascii?Q?vUb0cxy6mmwRmqezV7RpANvqFnIIPvUDym8i4tU94j14FCWJ62KXR4MUVeGz?=
 =?us-ascii?Q?CA4YWE78GQi5iKhZ70EdW0v0XhxFMQLuwOZWuLc7WF3FeDTl7R1GfH6d+rWl?=
 =?us-ascii?Q?JT6W88sXn2DKDoUT3pRs8Q+mFwg6M2c9rYkyLQUixA5ntcpXcB9YdAtS4Z+t?=
 =?us-ascii?Q?0RMXaJJFghkbE1Lh2fLf22bZdod+JCNFoBq1pyWlOQRCx9iAHiosZNkrWmnN?=
 =?us-ascii?Q?ru2qvKDPDCtD+A6U0Vj7tuW49/9BaLDaFXtYuYK99EBMxdXnK/0OZkJIoehS?=
 =?us-ascii?Q?sJgY/skSizfeIiLjq3SO4yX/H/tCo342ZTEgjS5qVAAW7MxEn0etO3cFmRac?=
 =?us-ascii?Q?dEO8BdA7s+mcuxPYil3tflqHvR9h2ksa/YjTDs1B+vuCcuarg8GV6vPXtbuP?=
 =?us-ascii?Q?ZMDq0A4ChPbTuzhRW5lUUfPGbzvE81+7I1EBvj8uXB3aaZN4rKiEVZVQFVxK?=
 =?us-ascii?Q?SP9hu1oUtzD/YHgDo4r1K61eJgZ6GYr1r3+ZQpgRkUxh6FDlrvI1SNymYwJv?=
 =?us-ascii?Q?KkVm1rxjCCZf7IVgj9AEN+Y+8wbbfMc+l3l06wlYw/UVedK/XjoPzZchT0wD?=
 =?us-ascii?Q?wHGcIiJew/PPGl2fmLXsuM0Wb+puHVfJhDQq+Yg52PZUUDo6l6PAEsWeaAs5?=
 =?us-ascii?Q?4E4gXpp3x0UNkR8CXaV1cin7xdPNLPjQViofzzOyazMzhYtTYZKeYAEO9TNM?=
 =?us-ascii?Q?YTCP/ZN4tMLLo9he3xiSyzkDg0FBzzXWaWdabezjCVfkic5gmxorH1QCyGBs?=
 =?us-ascii?Q?83W6034i0vHu5mFRMX5l5bvmsRxIXWOm92lSMX1jiXIMAUDxAvH/5lrOvfVC?=
 =?us-ascii?Q?FfV7QxfJzwIRKw0w0XpuTjekFeYcGpwKuW2vDzPNP1o4L8Ziw2NS4gQ1USnU?=
 =?us-ascii?Q?0lNBmOpHHhAVRuHP74vS1xmFuk+iqcSxfxQB+KkTEg1eimUSEZeirtQhxw/D?=
 =?us-ascii?Q?TGvVifKL5SYlD1VCWjNMOAumEXf+YuvTYHkZiqi8MJqtfh4k1bUGZm8IkDW8?=
 =?us-ascii?Q?4XpnaPIHWMoiuem0mQ2t02A26swMKVFTUzDylWoPHVZbtspLC2ZjaWg/9ekG?=
 =?us-ascii?Q?H239PvkbjICHgZ22LgDYpnFSMZvO6pCY8JN4OTqalFnvnI9JsAux2IuewzwP?=
 =?us-ascii?Q?GBVRBvoGnj/AXqVK6QUH5bZhW/td7TPsBRsjMwW7Jw7G8kPZMujQMSRD9B6b?=
 =?us-ascii?Q?Ow7N4S40mcEtRk0yFI5zTrkc6d2L?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(4022899009)(366016)(13003099007)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8N1e3dSWAbob9zU3hNoPENxto/V4QTbqvGv+qXpCgIc3cgm6PtKLzL/iq9Ox?=
 =?us-ascii?Q?dzpgq2vnG4a/JCAq11iaF1OHXaGk24qgm6O1sHnuLKijDd5DiY3EFrOigHgM?=
 =?us-ascii?Q?aGT+lA1CQhhdORevkzfPyAV7hpohkyaELePGH03gBnytWHTd1jE4mFM2BcLY?=
 =?us-ascii?Q?zm4N9PcprwVPk5/BGiL1npSaZRnouZIbkZchtm6eMN7MLL5so/HYi2kSspIN?=
 =?us-ascii?Q?SoPtp2qr7OdYc8I7Y7r0yoGVv74E+lh1Fg4g/K1P3kajNFNZS+Oj7nIEkyad?=
 =?us-ascii?Q?1E83K6/R+SFTIUI0KtLPx5yC0CvArgcrwOM1rgk6JC2RU5J+kyVBhy644Nhz?=
 =?us-ascii?Q?E45mV8KwzfmmBIYipALrrNigXpcBStm1grVURG3zcorO0DScqMLf/j9KNjjK?=
 =?us-ascii?Q?rspb7URM9wJROEM3HiJJNor4bXI+oGuTUx5n+EhtITrpOgOkiNVxwn9KORt9?=
 =?us-ascii?Q?JefOKPbv/Fat4yc5D4QIL+21oSJX8ct5mUkOm3RwS7von6m1yyf/0518ZQSc?=
 =?us-ascii?Q?BHWfxztFEK00Jmp90x//ua4kvwvpxq+jFNkEIMDkO9AVGX5DfyN+HJY/nBiu?=
 =?us-ascii?Q?GtWiedgeWdeuwMTpzolhdjy1NKCHjTMJNjlwSQRe3jZdev6ftE96Ilg0cfLA?=
 =?us-ascii?Q?P1N6h1pjkFta0dvLqpIjQVTXbw8t9OP4yY41rSDWyXWtD1yjNzXtlVX+ITwJ?=
 =?us-ascii?Q?lQj8DciCMRYxzu6p/gzEiUAA9zMeFPzHTBCdrlyMwcceCzSICDAvgE6RuxFc?=
 =?us-ascii?Q?nELn8i7t6J0nyz2xNjCnmuGOHc9C7ejqUdHM94PhzBqJevAx7M6aM9ND+Z39?=
 =?us-ascii?Q?hv03iNrJXh4skBPYYStaqOZI6BlGqwgsFZppJXor9KRQLElo/a2BZ9L4qdE8?=
 =?us-ascii?Q?Ha1IiYBflRIpkTjz7Lmm1J9K58ihBSLYLPtISTDPTLpT2UOWeLsgsfNX8u1e?=
 =?us-ascii?Q?YkDrlXYKMTXfcuIE/e9QgDm7sNAD827SiOJuVYLVGK9eMmL5xI/mfOZb+W/n?=
 =?us-ascii?Q?iU5iBPoIWKiZo5exQKysVaMeEP3wqZPjoJWN0+YIk9kHxRloa8MF48b0bUh9?=
 =?us-ascii?Q?Y/58L/fyioKll1aYz88mCes6PzYdb23o0AkLlgEAE7uguuXy+svsbGYuY75b?=
 =?us-ascii?Q?t3OcjyVV53OWXaZHU0STmIGgEXwU/8I8jX8B2yi2yd0NWfcHT8xsAsbHPnKq?=
 =?us-ascii?Q?bmpnqVlKR1ivvnl8LuBFTWiX+E4UoD7R3806p2U3zpYzJDl2JfQyfli58BHt?=
 =?us-ascii?Q?GSKNcnhPIdUAHOGNUo0Zb7/isWy3QY3+AqC16qeUqU6gAgKLtjHoojl00Nhu?=
 =?us-ascii?Q?H3Psiw5wcDHnjEU1DL3r6bWTgI/2onvi29GbV9DThRfLZqSSQM6uZ6FYxwut?=
 =?us-ascii?Q?yYoFHUNDZJ5AIkNtFoeGBRRRKN+brjEJcSZNtfQGjpWqzTVvFiPa8WypUepG?=
 =?us-ascii?Q?JX+eLTBwyfYrt2POkKNSZz6E8vDqAq6N/Uz2wQWL06BwTkJPJ/MXFLPttu/d?=
 =?us-ascii?Q?98tcr2l3Kl/e3AFMAUOpvQIFGUEW4ZyNkkMXqm915+hyWZXUwYaQGIw0W6b3?=
 =?us-ascii?Q?cfLptcalrCQDanMc8QI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb47e6c-c519-48ee-a7b5-08dd61e0ea01
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 03:41:18.2702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zZ6ed3v19OxJuwhLOm2bxmyV9+L4/3oApt74meapOEwisLLZbScIn32+BR6vYDko41MXdg91y0Ct8AFQF/hvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173
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

Hi, Tao:
        I am worried about host reboot or power down during the eeprom form=
ating, which will make the bad page info lost.
        If the issue needs to be considered, I suggest save bad page info o=
n host disk before eeprom formatting, and make a mark on eeprom

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of amd-gfx-=
request@lists.freedesktop.org
Sent: Wednesday, March 12, 2025 6:09 PM
To: amd-gfx@lists.freedesktop.org
Subject: amd-gfx Digest, Vol 106, Issue 157

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific than "R=
e: Contents of amd-gfx digest..."


Today's Topics:

   1. [PATCH] drm/amdgpu: format old RAS eeprom data into V3
      version (Tao Zhou)
   2. Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
      (Raag Jadav)
   3. [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in
      overdrive for smu 14.0.2 (Tomasz Paku?a)


----------------------------------------------------------------------

Message: 1
Date: Wed, 12 Mar 2025 18:05:48 +0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3
        version
Message-ID: <20250312100548.283389-1-tao.zhou1@amd.com>
Content-Type: text/plain

Clear old data and save it in V3 format.

v2: only format eeprom data for new ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 837f33698b38..d3b9b4d9fb89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3465,6 +3465,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_devic=
e *adev)
                                adev, control->bad_channel_bitmap);
                        con->update_channel_flag =3D false;
                }
+
+               /* The format action is only applied to new ASICs */
+               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >=
=3D 12 &&
+                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
+                       if (!amdgpu_ras_eeprom_reset_table(control))
+                               if (amdgpu_ras_save_bad_pages(adev, NULL))
+                                       dev_warn(adev->dev, "Failed to form=
at RAS EEPROM data in V3
+version!\n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09a6f8bc1a5a..71dddb8983ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -413,9 +413,11 @@ static void amdgpu_ras_set_eeprom_table_version(struct=
 amdgpu_ras_eeprom_control

        switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
        case IP_VERSION(8, 10, 0):
-       case IP_VERSION(12, 0, 0):
                hdr->version =3D RAS_TABLE_VER_V2_1;
                return;
+       case IP_VERSION(12, 0, 0):
+               hdr->version =3D RAS_TABLE_VER_V3;
+               return;
        default:
                hdr->version =3D RAS_TABLE_VER_V1;
                return;
@@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)
        hdr->header =3D RAS_TABLE_HDR_VAL;
        amdgpu_ras_set_eeprom_table_version(control);

-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
                hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
                                RAS_TABLE_V2_1_INFO_SIZE;
@@ -461,7 +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)
        }

        csum =3D __calc_hdr_byte_sum(control);
-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1)
                csum +=3D __calc_ras_info_byte_sum(control);
        csum =3D -csum;
        hdr->checksum =3D csum;
@@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
                        "Saved bad pages %d reaches threshold value %d\n",
                        control->ras_num_bad_pages, ras->bad_page_cnt_thres=
hold);
                control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
-               if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
                        control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
                        control->tbl_rai.health_percent =3D 0;
                }
@@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
                amdgpu_dpm_send_rma_reason(adev);
        }

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
                                            RAS_TABLE_V2_1_INFO_SIZE +
                                            control->ras_num_recs * RAS_TAB=
LE_RECORD_SIZE; @@ -805,7 +807,7 @@ amdgpu_ras_eeprom_update_header(struct =
amdgpu_ras_eeprom_control *control)
         * now calculate gpu health percent
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
-           control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
+           control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
            control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
                control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
                                                   control->ras_num_bad_pag=
es) * 100) / @@ -818,7 +820,7 @@ amdgpu_ras_eeprom_update_header(struct amd=
gpu_ras_eeprom_control *control)
                csum +=3D *pp;

        csum +=3D __calc_hdr_byte_sum(control);
-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                csum +=3D __calc_ras_info_byte_sum(control);
        /* avoid sign extension when assigning to "checksum" */
        csum =3D -csum;
@@ -1035,7 +1037,7 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct am=
dgpu_ras_eeprom_control *co
        /* get available eeprom table version first before eeprom table ini=
t */
        amdgpu_ras_set_eeprom_table_version(control);

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                return RAS_MAX_RECORD_COUNT_V2_1;
        else
                return RAS_MAX_RECORD_COUNT;
@@ -1280,7 +1282,7 @@ static int __verify_ras_table_checksum(struct amdgpu_=
ras_eeprom_control *control
        int buf_size, res;
        u8  csum, *buf, *pp;

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                buf_size =3D RAS_TABLE_HEADER_SIZE +
                           RAS_TABLE_V2_1_INFO_SIZE +
                           control->ras_num_recs * RAS_TABLE_RECORD_SIZE; @=
@ -1383,7 +1385,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_co=
ntrol *control)

        __decode_table_header_from_buf(hdr, buf);

-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
                control->ras_record_offset =3D RAS_RECORD_START_V2_1;
                control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT_V2_1=
; @@ -1423,7 +1425,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eepro=
m_control *control)
                DRM_DEBUG_DRIVER("Found existing EEPROM table with %d recor=
ds",
                                 control->ras_num_bad_pages);

-               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control);
                        if (res)
                                return res;
@@ -1443,7 +1445,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                        ras->bad_page_cnt_threshold);
        } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
                   amdgpu_bad_page_threshold !=3D 0) {
-               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control);
                        if (res)
                                return res;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.h
index 13f7eda9a696..ec6d7ea37ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -28,6 +28,7 @@

 #define RAS_TABLE_VER_V1           0x00010000
 #define RAS_TABLE_VER_V2_1         0x00021000
+#define RAS_TABLE_VER_V3           0x00030000

 struct amdgpu_device;

--
2.34.1



------------------------------

Message: 2
Date: Tue, 11 Mar 2025 19:13:15 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Andr? Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Al=
ex
        Deucher <alexander.deucher@amd.com>, Christian K?nig
        <christian.koenig@amd.com>, siqueira@igalia.com, airlied@gmail.com,
        simona@ffwll.ch, rodrigo.vivi@intel.com, jani.nikula@linux.intel.co=
m,
        Xaver Hugl <xaver.hugl@kde.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
Message-ID: <Z9BvK55_Nim54eOu@black.fi.intel.com>
Content-Type: text/plain; charset=3Dutf-8

On Mon, Mar 10, 2025 at 06:03:27PM -0400, Alex Deucher wrote:
> On Mon, Mar 10, 2025 at 5:54?PM Andr? Almeida <andrealmeid@igalia.com> wr=
ote:
> >
> > Em 01/03/2025 03:04, Raag Jadav escreveu:
> > > On Fri, Feb 28, 2025 at 06:49:43PM -0300, Andr? Almeida wrote:
> > >> Hi Raag,
> > >>
> > >> On 2/28/25 11:58, Raag Jadav wrote:
> > >>> On Fri, Feb 28, 2025 at 09:13:53AM -0300, Andr? Almeida wrote:
> > >>>> To notify userspace about which app (if any) made the device get i=
n a
> > >>>> wedge state, make use of drm_wedge_app_info parameter, filling it =
with
> > >>>> the app PID and name.
> > >>>>
> > >>>> Signed-off-by: Andr? Almeida <andrealmeid@igalia.com>
> > >>>> ---
> > >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++=
++--
> > >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
> > >>>>    2 files changed, 22 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>> index 00b9b87dafd8..e06adf6f34fd 100644
> > >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > >>>> @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu=
_device *adev,
> > >>>>            atomic_set(&adev->reset_domain->reset_res, r);
> > >>>> -  if (!r)
> > >>>> -          drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOV=
ERY_NONE, NULL);
> > >>>> +  if (!r) {
> > >>>> +          struct drm_wedge_app_info aux, *info =3D NULL;
> > >>>> +
> > >>>> +          if (job) {
> > >>>> +                  struct amdgpu_task_info *ti;
> > >>>> +
> > >>>> +                  ti =3D amdgpu_vm_get_task_info_pasid(adev, job-=
>pasid);
> > >>>> +                  if (ti) {
> > >>>> +                          aux.pid =3D ti->pid;
> > >>>> +                          aux.comm =3D ti->process_name;
> > >>>> +                          info =3D &aux;
> > >>>> +                          amdgpu_vm_put_task_info(ti);
> > >>>> +                  }
> > >>>> +          }
> > >>> Is this guaranteed to be guilty app and not some scheduled worker?
> > >>
> > >> This is how amdgpu decides which app is the guilty one earlier in th=
e code
> > >> as in the print:
> > >>
> > >>      ti =3D amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> > >>
> > >>      "Process information: process %s pid %d thread %s pid %d\n"
> > >>
> > >> So I think it's consistent with what the driver thinks it's the guil=
ty
> > >> process.
> > >
> > > Sure, but with something like app_info we're kind of hinting to users=
pace
> > > that an application was _indeed_ involved with reset. Is that also gu=
aranteed?
> > >
> > > Is it possible that an application needlessly suffers from a false po=
sitive
> > > scenario (reset due to other factors)?
> > >
> >
> > I asked Alex Deucher in IRC about that and yes, there's a chance that
> > this is a false positive. However, for the majority of cases this is th=
e
> > right app that caused the hang. This is what amdgpu is doing for GL
> > robustness as well and devcoredump, so it's very consistent with how
> > amdgpu deals with this scenario even if the mechanism is still not perf=
ect.
>
> It's usually the guilty one, but it's not guaranteed.  For example,
> say you have a ROCm user queue and a gfx job submitted to a kernel
> queue.  The actual guilty job may be the ROCm user queue, but the
> driver may not detect that the ROCm queue was hung until some other
> event (e.g., memory pressure).  However, the timer for the gfx job may
> timeout before that happens on the ROCm queue so in that case the gfx
> job would be incorrectly considered guilty.

So it boils down to what are the chances of that happening and whether
it's significant enough to open the door for API abuse.

Considering this is amd specific accuracy, it's still an open question
how other drivers are/will be managing it.

Raag


------------------------------

Message: 3
Date: Tue, 11 Mar 2025 22:38:33 +0100
From: Tomasz Paku?a <tomasz.pakula.oficjalny@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu/pm: Handle SCLK offset correctly in
        overdrive for smu 14.0.2
Message-ID:
        <20250311213833.870840-1-tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset=3DUTF-8

Currently, it seems like the code was carried over from RDNA3 because
it assumes two possible values to set. RDNA4, instead of having:
0: min SCLK
1: max SCLK
only has
0: SCLK offset

This change makes it so it only reports current offset value instead of
showing possible min/max values and their indices. Moreover, it now only
accepts the offset as a value, without the indice index.

Additionally, the lower bound was printed as %u by mistake.

Old:
OD_SCLK_OFFSET:
0: -500Mhz
1: 1000Mhz
OD_MCLK:
0: 97Mhz
1: 1259MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK_OFFSET:    -500Mhz       1000Mhz
MCLK:      97Mhz       1500Mhz
VDDGFX_OFFSET:    -200mv          0mv

New:
OD_SCLK_OFFSET:
0Mhz
OD_MCLK:
0: 97Mhz
1: 1259MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK_OFFSET:    -500Mhz       1000Mhz
MCLK:      97Mhz       1500Mhz
VDDGFX_OFFSET:    -200mv          0mv

Setting this offset:
Old: "s 1 <offset>"
New: "s <offset>"

Signed-off-by: Tomasz Paku?a <tomasz.pakula.oficjalny@gmail.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 59 ++++++-------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 5cad09c5f2ff..62bd9647541a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1193,16 +1193,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_c=
ontext *smu,
                                                         PP_OD_FEATURE_GFXC=
LK_BIT))
                        break;

-               PPTable_t *pptable =3D smu->smu_table.driver_pptable;
-               const OverDriveLimits_t * const overdrive_upperlimits =3D
-                                       &pptable->SkuTable.OverDriveLimitsB=
asicMax;
-               const OverDriveLimits_t * const overdrive_lowerlimits =3D
-                                       &pptable->SkuTable.OverDriveLimitsB=
asicMin;
-
                size +=3D sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
-               size +=3D sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n",
-                                       overdrive_lowerlimits->GfxclkFoffse=
t,
-                                       overdrive_upperlimits->GfxclkFoffse=
t);
+               size +=3D sysfs_emit_at(buf, size, "%dMhz\n",
+                                       od_table->OverDriveTable.GfxclkFoff=
set);
                break;

        case SMU_OD_MCLK:
@@ -1336,13 +1329,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_c=
ontext *smu,
                size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");

                if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_=
GFXCLK_BIT)) {
-                       smu_v14_0_2_get_od_setting_limits(smu,
-                                                         PP_OD_FEATURE_GFX=
CLK_FMIN,
-                                                         &min_value,
-                                                         NULL);
                        smu_v14_0_2_get_od_setting_limits(smu,
                                                          PP_OD_FEATURE_GFX=
CLK_FMAX,
-                                                         NULL,
+                                                         &min_value,
                                                          &max_value);
                        size +=3D sysfs_emit_at(buf, size, "SCLK_OFFSET: %7=
dMhz %10uMhz\n",
                                              min_value, max_value);
@@ -2417,36 +2406,24 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu=
_context *smu,
                        return -ENOTSUPP;
                }

-               for (i =3D 0; i < size; i +=3D 2) {
-                       if (i + 2 > size) {
-                               dev_info(adev->dev, "invalid number of inpu=
t parameters %d\n", size);
-                               return -EINVAL;
-                       }
-
-                       switch (input[i]) {
-                       case 1:
-                               smu_v14_0_2_get_od_setting_limits(smu,
-                                                                 PP_OD_FEA=
TURE_GFXCLK_FMAX,
-                                                                 &minimum,
-                                                                 &maximum)=
;
-                               if (input[i + 1] < minimum ||
-                                   input[i + 1] > maximum) {
-                                       dev_info(adev->dev, "GfxclkFmax (%l=
d) must be within [%u, %u]!\n",
-                                               input[i + 1], minimum, maxi=
mum);
-                                       return -EINVAL;
-                               }
-
-                               od_table->OverDriveTable.GfxclkFoffset =3D =
input[i + 1];
-                               od_table->OverDriveTable.FeatureCtrlMask |=
=3D 1U << PP_OD_FEATURE_GFXCLK_BIT;
-                               break;
+               if (size !=3D 1) {
+                       dev_info(adev->dev, "invalid number of input parame=
ters %d\n", size);
+                       return -EINVAL;
+               }

-                       default:
-                               dev_info(adev->dev, "Invalid SCLK_VDDC_TABL=
E index: %ld\n", input[i]);
-                               dev_info(adev->dev, "Supported indices: [0:=
min,1:max]\n");
-                               return -EINVAL;
-                       }
+               smu_v14_0_2_get_od_setting_limits(smu,
+                                                 PP_OD_FEATURE_GFXCLK_FMAX=
,
+                                                 &minimum,
+                                                 &maximum);
+               if (input[0] < minimum ||
+                   input[0] > maximum) {
+                       dev_info(adev->dev, "GfxclkFoffset must be within [=
%d, %u]!\n",
+                                minimum, maximum);
+                       return -EINVAL;
                }

+               od_table->OverDriveTable.GfxclkFoffset =3D input[0];
+               od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD_F=
EATURE_GFXCLK_BIT;
                break;

        case PP_OD_EDIT_MCLK_VDDC_TABLE:
--
2.48.1



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 106, Issue 157
*****************************************
