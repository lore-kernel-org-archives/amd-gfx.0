Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C57E98FC2
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 06:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1382B10E72B;
	Thu,  9 Apr 2026 06:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vjsX02Cv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AB310E729
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 06:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2m05it9nDGSxYeOIHnhMk6vT247iIP9JpeJh5h0sPbXbdLbRDaJale6HE68GyUTXKlcM7sWnRL4A6iquZeErMEuV7EytJFSPIvSgLMm7Q05QSlIw3Yx7HaabGBXMhIvWEJGbHtPjqE0ZDBBOwAZOmRIhCnr2gbaohTBmq9z13svsrbUl0irei9iHQvx2NGc0Jv24s8j8v3adJLFmNH4BqnKr+vqyKcOGdx5tJ53feJUg52zA+ccfAoyLJmWFnAQmqZOIFGh0BSbh3+XTyuQkqV2CnhT48GsOXCfpQgWdNWDT73+eWYX7tQBxYEf29nBQvbeHbduqic8DilkeD6qKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Wqmlc0QUMcrGo0FMVrphZmG47mBAx9DVXKC4yiEcgo=;
 b=O2anlL9Z59WpBWdXns1osuCIMnLvvE5EM1gQ750GWrw7qH3nLraeW+n5NW0dBuVDIumEGVbPIQ46GSnVyeJ5nSC0p9XDhHg0nKmBEJvUMx1xH9IC9wlZ7HqSOTcNNn31gcMPmpz6Yyl70fMqh6FMdbNr/7nk0B6EG8xN9L3kwCizLF4tXobSyBn7Mso+o/RiTI72vnv6TzXHgD5acEVijF38g5+9CIutjz0bdsXJdPxxWV6hW5+/7XWkzRydxtLa4GQXWUnBIVQUcduFREU4VHQHZZ5zL5v9BLUto0BVznuEzIXqfYfN6jUCNgxLITWrrjXSDyzcb8UvdXTniIIsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wqmlc0QUMcrGo0FMVrphZmG47mBAx9DVXKC4yiEcgo=;
 b=vjsX02CvStd6X1Z06IPFaKksTMT7D8iHHKQ2TMUztS1E61rFrI6jKQ8QI4EyNmoR1DNg52ev77ZBkvFLK/Bemzjk+Y7++GWr6c6Sualy9yyOwfuFgoB04umf0l5giCPLINeCye68UKASWd/V68OXlbLt9IrNCNm/Unmcu0f7kEU=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 06:46:05 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d%7]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 06:46:05 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Topic: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Index: AQHcxz4uyV6yQ2TmwkGH8Rm+NMJadbXVBTGAgAFEriA=
Date: Thu, 9 Apr 2026 06:46:05 +0000
Message-ID: <PH0PR12MB54204DD72541956A251F7C09E0582@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20260408095739.59807-1-YuanShang.Mao@amd.com>
 <DM6PR12MB297293A460D5D4D174BBB7E7825BA@DM6PR12MB2972.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB297293A460D5D4D174BBB7E7825BA@DM6PR12MB2972.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T11:18:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|SAWPR12MB999141:EE_
x-ms-office365-filtering-correlation-id: 4f260ea9-5147-4c2c-0ee1-08de9603ac3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Q2FBq14pRyF/Ai7UOgRfMY0eXdxefYxckQmFWkEWHG5S5GsTN7z83RVtx1FBxXDjjDKefHrenuNHAMnV0qUeuc5IN/3Jwfp2rEKlN85eiEM3MfaRG1Bk3W32fy/pjDZ3sVBQoYMX3LcUiDqdvpZcC/GsCVb8pGfPccLoNuMEEVD9keFX55NLUp5OrmigB5ode3P0rKZBFXyCXJ2MdQlfH93WyMYnm5iG71vhludYV/FtJjFlw09UfOOyTPf/qBbBqy4c7IF/giLlxj6zzSn7hnWqPY1ii/3mjYZqDMI2zWq0cei5SPZUNLMslHQFzzuKPAbZUchFMIkNzUd8P302TLuUVKaSdWESdNlvrVMv5yTHPsLp090z6hW7JE4ocgN8BT1UJ4v2tpJPsJpIPHXWpfQDkzpwHhIwgQO2uv8FZJxSKpB4/pTGBC1VpG93Ccjg/yJ9qTzy75n6s5eeTHoNIf/xHFvXy6oBw4ImCyqoFxU3M1GEDdHiyIOVmgA9/nMDuF1yUtc4axAVlC/Y3/n4cQYdnDjiN0BsukJKDy2k8gIm1o9j5DXPV6cIjvFUOR1h+iAyM1GcdjMF2ShnQsA+4hr9PN2RAWSEit/pfHUFahefivxR1T/gqisW4n6BhgHcopno+yZV9DRg3bHBhy6Qw3ZVVjE2BJHRHQDYvxu5wxX/pVnwFAWC2hDlWwo7Q1i3yL5zaY1YOmhVlqrF/l6ijqoX6gdWAT6b6SvHh4JCUH/U5CzZmXq3cNpIOU+YOywD5LdFdGWwv9KYWsQmNcR7P8DyoPb6loJeIyI6F3X3/+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?83PGKVh3/wUrxicEW44ali1ZrsbGrtVTq/DQtNqE+yPtsK2Kvum3DBYVc7MN?=
 =?us-ascii?Q?hk2g3wvriS43DP9NTe+HoykmsNRybQeG4E1VG+vEZgFXF+O1oa5vu729tEhq?=
 =?us-ascii?Q?/yMWqcH3z9nd1ajWI4iouwgpbmIGmLeWShN5Xr9ovGL9/nLHvCMoCaoC6Qym?=
 =?us-ascii?Q?09KkLxw4zSemIHPeJ3bcSHsqya4a64uIyIJqGqZD65gMot8DwG2+tF9gRqYa?=
 =?us-ascii?Q?lKevRCkAMCBtEJ9jc+msXZIkfDWozz8D49YZL6/QwedEmS51hHoK5ae+bnXN?=
 =?us-ascii?Q?1qjCsbaKAG4NJXtVNZk+lKPVg4Eil11J6gafwau2Sqe/GiGBSZTW0onBNzcy?=
 =?us-ascii?Q?rVRWE1OVofeEx5b6ZJM+AUJrl0wva04NHgP3D04XTNGNnUw6fWbdDG5cXRWF?=
 =?us-ascii?Q?fO8Cc+C7WKhe/a5KtQgk4xjMd9lRzFoD0NJvbfHSDS8tpUenLVx8SvFyEVZ3?=
 =?us-ascii?Q?If8Y5XkQYOiHGzHlHT4OZk+64PLWuOGEFXCKsZ53Y0S09xShdkAgeN6QxO0e?=
 =?us-ascii?Q?KEsPV3M5nS28m4G2dvzxtY5qwNymp4Itlr+LeVqvsCjWlJpWF1lJCRnUjTgR?=
 =?us-ascii?Q?f7zxuUsVzQ+2gBtuOXTlDfNEKoXJ5dIziegOyVFgLnsHc9FRdYuJYXxfc77D?=
 =?us-ascii?Q?w/YotwkswBD5yZVk6mBInen8Ie0OCdTvo3KVmNZLu4is593lduBOJAGgyIab?=
 =?us-ascii?Q?0gRUpUyVmIcAT0o2X1Z1zE9fJTopi1RjY/nt692OCAqbtScuT9GnAa9t1SyG?=
 =?us-ascii?Q?C1Mcju5rZywY92wZHPHRGHc4pPtZcnEGdfU9hA0ZvGqEUB0DUjjizsVy8zYv?=
 =?us-ascii?Q?eH8RCW/HYSsmzlwtA/d2rPXpkVgnf6OqbarsxGerduxdvG6N/OmgW1wu8QL5?=
 =?us-ascii?Q?2vhZ6jHSu69s0IsLUEfTUn3/JeDnfjET+YPeEbBX8cX+WNJFSxFbITYySeKo?=
 =?us-ascii?Q?Ad6lB8U2FBP2XqR2+V7N0imE3hKfkOH2JeN/g4Rz9Jw75GEjCN0Hq9MaHL5A?=
 =?us-ascii?Q?Ypy+DgoKphkFEjArHAotpwZtkVh7TMms+acWTEc+V3nOqYfWYDq5TCJ2CUu9?=
 =?us-ascii?Q?cBUXCgjwUgEFca8vrGJ6tz0pSZ4eFs7+0P9shUHbhpp6/w4XMIpEHown8g+p?=
 =?us-ascii?Q?BgII7L6YoNPHPWqonjAdiG+wY3K+HkvA4RCy6z+AHBLYx2IwHzRVKfa8OfP+?=
 =?us-ascii?Q?Xee5EE0CG6+QEU1Z9tH+xD4XtQESCybK+ndlvkoJDWsEvdZShH14/ycjhPID?=
 =?us-ascii?Q?l+Gr7WK2taev1i0sW4OaPEKoAeXPCuF8nJKQwt8tRsW//NeWJDgUUtIhiXBt?=
 =?us-ascii?Q?W/84E2fxbmNkYhH0hvBq4Fsgw3HesMu1L/GsYaQGGpC/twTSZ/hA9pPQLz2E?=
 =?us-ascii?Q?t8U+EpDog/eMPIzca98Uuz6owm8ZS3hh9/QrUfROwT4J5GxwIzBl3wWPcXjF?=
 =?us-ascii?Q?JxfSjbVsf1K9cuMolOjoML4lZA0qn+N/M80eBUNEOXQuflWkNJ/OWR+NWnLM?=
 =?us-ascii?Q?OZ7FTxWvXYIXmRlmjBqwmy+tP+oS3hNlGLNeosBHrImFXiidmNwZ9nfHLKJG?=
 =?us-ascii?Q?HTPrbn9icUN/RQIcIfNF4Kgbbk0xxyUakimDUDP2VEbXvF6KmJU8nGVX6lay?=
 =?us-ascii?Q?jT+odLOgPl+8MAhU1n/u5JgazLC9T0prur52itC6jEBs+lg9hHb0aPfpiqfd?=
 =?us-ascii?Q?q/ePW5TNiRNQt0sV0S3+dF6KsCBFrLeC3pV8jYvH1OxdUOwf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f260ea9-5147-4c2c-0ee1-08de9603ac3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 06:46:05.1502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNSNcZ7MXI4iXI/AH/rth0tiF90DvxQWdLkuscajzLtsP+uaObZwWOz0z5PJh644LjiYuqVCDj4MZ6OZ21BVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
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

Comment " setting should not be allowed from VF if not in one VF mode" mean=
s setting is allowed in one VF mode, right?

I am testing the function of setting clk level on one VF mode and find the =
node cannot be written.

Thanks
River

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, April 8, 2026 7:21 PM
To: YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedeskto=
p.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission che=
ck

[AMD Official Use Only - AMD Internal Distribution Only]

I'm a bit confused about your patch.

The original intent was to disallow write operations when in one-VF mode.

After your change, the condition becomes if (is_vf && !is_one_vf) , does th=
is mean multi-VF mode?

In multi-VF mode, we should not create any power-related nodes, as the SMU =
IP block will not be enabled on the guest VF side.

BTW, what issue are you having?

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g
Sent: Wednesday, April 8, 2026 5:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check

The condition was checking if VF is in one-VF mode to disable writes, but s=
hould check if VF is NOT in one-VF mode. Add the missing negation.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 938361ecae05..17fea9a2aa28 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2057,7 +2057,7 @@ static int pp_dpm_clk_default_attr_update(struct amdg=
pu_device *adev, struct amd
        }

        /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
                dev_attr->attr.mode &=3D ~S_IWUGO;
                dev_attr->store =3D NULL;
        }
--
2.25.1


