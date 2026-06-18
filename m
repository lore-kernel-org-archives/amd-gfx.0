Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859CCD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 06:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E66E10E605;
	Thu, 18 Jun 2026 06:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jar4P3Oq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A29B10E605
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 06:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccuri/0Q5cKr7EqkSjYtzy4FDEpZpFeBVQVbkioHjFWQG/Iv7C9EA/H6lb52lOEPdh+OWuvuf9E4hZWKRSrZ9qQWPUNqjaA7HhQQHeI+3pqbmyCXzGZw4PLraIC2AMAVwFkYtvM9FXneLOwVVal/EgJbE8HAt5v9QH98c9m+oLuQuOtf3wTYRpBhci0ZMmpEeQ9oEtbSbqaK5d5AM2YRM6Z+gd7i8jTAKD5Or3g2kz9LvjnruUdpYWFtwj2tIGBh09yKjJo3fOa0E1+PuzrV7AcxUxTu40YAHcrjT2ZCNnwxyGKnVM3olJ+ib5VCuf1Ajy1PbyzOKx7m1g6OIRB+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+7TOm2sP/YppHaVSrWLTUj9NS1L32iMP69h8f/RX9Y=;
 b=bRxjXvPqY7S6T7mpPMhaFfMj1azDQLKWnP4LkCw29//sJGc6KhIucKr8hqXaUHgv3z23CTMAlgrrhzMu4/lUO0fZOP/aNyF23p+lANNUUwrtr5LNII7zit0hp5NaJeggYWdzBglQ81EExc/ip6q8S9flsxtVdMlDmI1hFifDDqpiv7fqKkPmEbs/TqyDhvtKUa1TArZcr0tl40ocU6GN4VktdRqa4oE7O1nu0S37JShX+lvaVc4X7N6o18G7vkyAwDvTXvEGfmtnBNEwGYDjt+xp9vlHXm1XVycKPjUlfLDAfmvt4jMOxFs8B5jvSIsj6PZHE8yqy2C+6ZzaSqarzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+7TOm2sP/YppHaVSrWLTUj9NS1L32iMP69h8f/RX9Y=;
 b=jar4P3Oq8PPjowiUuZlAWGFXZ1leE7cKrKz4F3W+9jGqAP3MO8uWOB+yTiQDNbHub+FV3KJipDv2EYTT4W+JgiBFM+GDfo4b8iX4GtJApk48+eBzNqf3D1/Xb00bL/aoytNzzGa3V8QyrpiOshHN1B+C0bkxixbK77mqukEBnF8=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Thu, 18 Jun 2026 06:01:19 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 06:01:19 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/pm: validate vega10 profile mode inputs
Thread-Topic: [PATCH] drm/amd/pm: validate vega10 profile mode inputs
Thread-Index: AQHc/uSDNYq7uPfYtUyoxzU5PN+WJLZD0fRg
Date: Thu, 18 Jun 2026 06:01:19 +0000
Message-ID: <DM4PR12MB50382BD126594CF3AFD8E02C8EE32@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260618053650.937168-1-lijo.lazar@amd.com>
In-Reply-To: <20260618053650.937168-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T06:01:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 72186ab5-fcc5-4dc4-0a0b-08deccff0433
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: qNcuHwpbh81k/k/OgYT/w7vg8UzNxRIJfpvL4zRzA7t1I2KZDjE9f7FKs9UnZCVByktQxI+kRvsF1AQMeo/6cM1kxSg5t0Wi1mu6bJO4bGLH8vdG3Jzh6jpspIMqKUf2IZHL49jkekw5Q1wzGL8wCZiGC+b7oxKhaTAnDwoTdh638mFRnAhrb9JS1yi+qlh47MpT3TxPYBFy5FAcgINvxAIXL8nr72NQ3svawk2qzauiIByLr414kwc6zOgcQCHR8MF4S3CtVZ8yyDp77qXeeGf5lUqp02XVbIAM7kOItikl1AKICzthlTGFN5dC35RNKu12/1rqkhuGeeZmbESWUfTC/TEBs2/v2V29n27EuY8SH+nRh8XunVboa1014iRp0YMkg0tcL2BTXZCjWal6dBYnr1Vbm/HxGby1M4Ykhp8/tZdDojGyBmxg9CsV3ET/KZoMNUrZGbiPqyxh637KBNUPaWxuVxtI3aB5z5oMrcOEkW1t0Sx3Xp0wreZTjhTpaTuXXYfjaDgAIx/xWz7oKheRa8OcL1BdBW6rFIOEJvhHPMpx/bZs/uW7kcclQw/3aAp8d0I0KU578xlajR55SqlfNuE4pRKSybgWdAYN+MP4ctklaUSFMMVfRmqQwORzIPl9uKKNPMu93JR5mnH6R0Cr/es2Ify2sTXzfIFUzX88NUBsXFrBT8KF+3ygk1jHl1L0B9TKrg2mFWtwsqWTYT7Sdw6FIylymIJnn2n25vxixhlf97QCckT/xcgOGvHw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U+RVB9tZowv49G+P8k2KPQnPA13Bt5Do4muWfho+rsDD2oFdNS/FZaMhQbIw?=
 =?us-ascii?Q?RQxKRDbpx0PxEOfi3/CRgJv0Yu6omF7WaEULOXg2ej69RmiiFZ2dd3/O6vhb?=
 =?us-ascii?Q?Z/G8Pjpe6BMjsKj4O5e0iVBNf044Ngf1WC5qdUabatkKR5jcw+nfZwNB3T8q?=
 =?us-ascii?Q?4jQMzLOw/bCOH+6fqdsptW62R7xObxAXXQ3EBSkxNmR8+n5Eb4bvzQDEPouK?=
 =?us-ascii?Q?AJe235uKosZcQiq8pM9wF9WxblCMSl/3mKyoOao5E0AP9OkYbXjPGxagaFRX?=
 =?us-ascii?Q?5A3TYQuEztrRawQA78pdBg7lbMi/YMdz+H2VfvENE1SkEkqKJsl9EF+CnbRh?=
 =?us-ascii?Q?vNH8nZWArGnkX+v9rcfgFIk8IrRjP7kmKf3P64E95LuyJtSbrFwFY/Dw47vY?=
 =?us-ascii?Q?KYnz8DYd7SvX5GhgEZM/Vpti7bbOIdLYFA1O4UWIPxB8xmE3TJCFB+Wcysof?=
 =?us-ascii?Q?74SwFF/N2OSEN8a0U/nQNHS71febFOoVZbRFB/5yZDQHTjHXrowpN7/I/1D7?=
 =?us-ascii?Q?xm49d5Redx7n3MftfpxNRkbgDUdSYnIQxGFGCYBhAMvcguxwfDS2LPuiO16m?=
 =?us-ascii?Q?j4mRb7CEsYdIkqQxwbjXZLB8eexvhD/+wRwiQIWoMGbwo+Ww3MhQwKF9fLwc?=
 =?us-ascii?Q?2rZ4mYaiNnSkRBjybJ+tllCuzvd5SmFW8mgPKLY4iVHJjg8CHhuZVitWKd30?=
 =?us-ascii?Q?DgQHoA8Cft3jrMraVJS7KrDzKu1ZzJGQa1jgDvTfn2+e1Uuy0/rTguz7CvA0?=
 =?us-ascii?Q?yBlhfsxoPRogZXUGrZ2TByD6zpAFlWdUZotoKTw8eXMalc8dPY9PfkyO+aAV?=
 =?us-ascii?Q?y2qXgsyQ9cqspVC7F2anQbAZi2cmrynMBpS+19jHsgvJ7IqBo4GKPTur9WRk?=
 =?us-ascii?Q?lj0Mid8H/r+ddoBk5P9c6tB7MgPywOeyw4BUWP/2Q6KkKhyJDRWDIq9GTbkr?=
 =?us-ascii?Q?fWxoC5LZ9l8Ollji6dPgmSw3LMK55TzUNtgTnwJf64qekXI0m5uquKQg8zjq?=
 =?us-ascii?Q?62Sy//2tt7W1vAdpNGL+quG50J6fIy5PJd7USvncLRqqWys8s0vkHL7ypUqm?=
 =?us-ascii?Q?7lqWTQhMQjuKxC9a217bXNNdYrIffDKKbNfgrX9ne9nuy0j7jfTEpjoZ4Lrw?=
 =?us-ascii?Q?bWRt1ue1dUHcuEzFHaQTBo6hUib4nrDY2uDU15+g117ibwOmRK12XEXFYhgt?=
 =?us-ascii?Q?eslTgaNGZ5wQuGkBvtrDKfrqeROrZEmeAF7FCZ5TUMmgrDApR3bRKPYs8L59?=
 =?us-ascii?Q?1QY83s9qhBle12n3f4JLJVMoLZXK9O8ddVctEGhwJa1vF9jC6cHe8+kIoPqZ?=
 =?us-ascii?Q?zL2TK8NMT6PiYtcTp+ICn0xJ33gBLqRFDMopH+N97RwApPE8GLVToVmxBekl?=
 =?us-ascii?Q?gyifVxEYyC58+splP2ff73v5bZZm9OVvmBEj0qTp4mMaR47lL5PwtIUFmeW2?=
 =?us-ascii?Q?Q00i/tf3T0aNaC8FJh9oB7u0YUuK8igO4JBka3Ka8iKCJWFwOiG5PlyGZrri?=
 =?us-ascii?Q?Z39Gi3jfFU6jcLyivL700V7GfHstLI+KNeUV3VUFSUY21eHk48q5crBd8swe?=
 =?us-ascii?Q?Cn4uKRB8hSM3ZvQ6xDjgVBD+F3b070NiqYrkFXIiCJeP5txjUHM3+7s70tw5?=
 =?us-ascii?Q?Xx1wIcltmmEbAD2QFayTbd71MU57VA2uvk+uW1Ph0ePInWmcrIzzGATDJLmp?=
 =?us-ascii?Q?Le8oXxO9/lEW74A+YkKb3sa7WqbdIHfJb6SGAajqq1R7IyB7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72186ab5-fcc5-4dc4-0a0b-08deccff0433
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 06:01:19.2080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d84H9vNjBkuwitUkUq2Dt/zppUs87B4fgM1A96AZnKSqe9qaxF4J/aTLa1hIelhI7RUoQ/+RNK+WF5BERwKajQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, June 18, 2026 11:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li, Candice <Candice.Li@=
amd.com>
Subject: [PATCH] drm/amd/pm: validate vega10 profile mode inputs

Check for out of range profile modes and custom params that exceed 8 bits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 076e10f26546..649cfad7d36c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5216,6 +5216,11 @@ static int vega10_set_power_profile_mode(struct pp_h=
wmgr *hwmgr, long *input, ui
        uint8_t min_active_level;
        uint32_t power_profile_mode =3D input[size];

+       if (power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+               pr_err("Invalid power profile mode %u\n", power_profile_mod=
e);
+               return -EINVAL;
+       }
+
        if (power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
                if (size !=3D 0 && size !=3D 4)
                        return -EINVAL;
@@ -5231,6 +5236,10 @@ static int vega10_set_power_profile_mode(struct pp_h=
wmgr *hwmgr, long *input, ui
                                return -EINVAL;
                }

+               if ((input[0] & ~0xFF) || (input[1] & ~0xFF) ||
+                   (input[2] & ~0xFF) || (input[3] & ~0xFF))
+                       return -EINVAL;
+
                data->custom_profile_mode[0] =3D busy_set_point =3D input[0=
];
                data->custom_profile_mode[1] =3D FPS =3D input[1];
                data->custom_profile_mode[2] =3D use_rlc_busy =3D input[2];
--
2.49.0

