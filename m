Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E44CD98F2
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 13:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC9A10E5BA;
	Mon, 22 Jun 2026 13:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oMorkOVO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3E210E5BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 13:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT2y/XBeYRWbuRB324+c+iNU0LLDRmGqVVHNEOhZMwltgZYhJdOujv6Eo8gq7C9v44MJ09Q9yuFuLalLNDN9pFIOxvYIwmU4dJwNS39R00gfkyldF+HwWN5RUxCy4K5u3r3AcitBvrJSuoZh/OvJ8Y8QN2SkWlmpI8l/sa2NvJ2nRp7RrTsW27Z3wGMgytghLvBbnxQfMpwUD2cIGnJz8kZO3KEuUL1mL0PQKDmevXH/LJvXtskS3JlWCz6wieY0HSVR2VF/F8CU/Fu5/5peXyXj3PR8FHQXoc4vKAPolG93bUw//PnxAqEiOYpcTGwt3AK4nuulucPhPcTWCJUXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stnGkkM3T/xIGCtWZjk3jrvvdsdtp+K9HBAuPZyPioM=;
 b=bg+XkR1T2C1RZjqkiHvAIOjiX0n92pJ1Rflpc7aX3MrW8FxzIAAut/gjPo/naA6sfx80sfdxPyJhhK4de7k2OEMYdHgV+5VC6IMqpPwWFOmCttCjomADoHw9THApEfMCc5AKfTvn3gXm7fG+NH1ghy78qprVTHwPlaPT+tkUODJxnjmZ0zMI+IJkGIfZrzymDssQZ8B3Npwj4P216UocvqmGXiSqKvlJHPzBaLCpqvBUOvMgrdwHHNuYgfJyCnGg9oshgmecXZ0Iu1U7hjIj8hQ9GJUlbD0jrX112xaJzder7CSIIgbwlPMSSHEFT4medUWhZFRFVj7f4XGJT/E69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnGkkM3T/xIGCtWZjk3jrvvdsdtp+K9HBAuPZyPioM=;
 b=oMorkOVOQPOwYU0YAoJuhDHOnP7SdxY8cIVbl/tRSfsYaOXzfFb7rI2G3L/7hizvXaGjokxC/Ln2hiI2LrG87u/6p1mNmCEDU3QYMhEpaQEJJfa7d/TGCjr2lgYHAzVk9RN1CZEnA+6ExzkCIPYAbjjoSUgea87GcodsYDyHFw4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 13:02:54 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 13:02:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bounds check VBIOS name extraction
Thread-Topic: [PATCH] drm/amdgpu: bounds check VBIOS name extraction
Thread-Index: AQHdAi0lE0gbi6mzE0uyeQzp5NMqyrZKim4A
Date: Mon, 22 Jun 2026 13:02:53 +0000
Message-ID: <BN9PR12MB5257641169AB31D94AC1C129FCEF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260622095404.1317549-1-lijo.lazar@amd.com>
In-Reply-To: <20260622095404.1317549-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T13:02:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: 9b519e76-293e-42a8-58c7-08ded05e92a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: IJkPG0cM2HbdvKhE9h/0MCB8k5FPZga2kNzj837B93U54eGdLsousXnOriV6wzKZzTs2kBblqcSbJG/+O+oQmMjERJYH/UxgwFgluEaJQDnEqJcL/QmZXzayLmPbSAvYygdteD+wtXgGaG9sUB/lthbkA9Um1CfWmJKL94q1q8b3Yve3CGfRtqxybHk+9L6RolqxRjGZIgn+sEGvS+u1Y8799u+6p071oMRuYFLpSyPOQwRL94xHluXPKWs/YEo5uTm0fMncLMPkPuGQ+I4FJAYhUpC32wZHJ2TGsH4Wvb44ZSJ2EzjcB1aMWInJwW8LrgEksUcmNtOYhTM3AuMYG94FaMpynT+lF+7vF3qZOYGxh8YZ/r2VsVf081Sm289VVO8Yochz3qCHdhw3XhKh7pI4pyZyaAH8nsnc9XPmlWvGeKizTLtkgXmwlWhOhSaofVjuk4bhT7jG/HmmbuL/uVIt1SYPTGvIV5/xr+25aaPeMPs6gZ9m80IAWuzuaekd53uCLDpcCEuMZh15hoBM219fpocQkxJdyk5BUGm+hO9AQ5GR7xnwm13UcwPYcAaOJd/eTBj1xaOVR/GywFb5yiHf+3p7xc3NjSgVyIApLHbcfp1d+ACIo+ISEWsczXYO5/TtbI5DZ6PsnSDAukfnPem85ZK4MPIU7W/vscZVTl9EHbeT7ZbZJPk0pg2iYX6nOwdvfpjJTVH7g+LMs3TXtmoVwiBGTrmn/7kWggTEpLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jqa1Qqk3vFryz3H8e5wCyovXQ02ZyQjvYT41TpOmIfAM7q9IYhHaGTLEhXct?=
 =?us-ascii?Q?abc4lAdNay+WK4hX4I6oLf+u1lojhUtlNzegHKdJDWupt3Nh+ooOGYMqsT+F?=
 =?us-ascii?Q?ZrG5DIcG7YLynTlBk4L8fvM5Oq5OJ6Ibd3B35tPxhsSi5+kY12U8jITMnOEY?=
 =?us-ascii?Q?XxpzfsO7se0iGpaHw0chL2kZFEoQI8cdUOY9RTcX+O1PIVEjqSAUzo6s4Z6H?=
 =?us-ascii?Q?EGRBIiDnkkflPhsLg4uSFrRcjGjbZ6tG7yOVga7/a2TLa3K9nG7uJ74JS2bo?=
 =?us-ascii?Q?7IVCHG0q0YY49lhifrjFe4iZpBMb48Q5h7/HffstDbyC1/TGHKVuS8rx8Kku?=
 =?us-ascii?Q?2GIpEDzSgJ4dJyogbLeclXpKPi5qi7QoeZ8i/On4/XQkvA1LOl3ueA8JxgVj?=
 =?us-ascii?Q?07mcpDidrMGRsxwvPjX6H5P4KW4z3Awhbetth/bLtKrgJ8+CjHDeRxfULxj0?=
 =?us-ascii?Q?TO8Gx0Q7CyOU2RG5UF8/g7zMWFkZ1GUL1X/RRjUViOQMj1iJA7tJjiI6H20L?=
 =?us-ascii?Q?Vw12BB2NO8EjG+HxX4iayknQxz/o+a7b+kqb2fM+re38XNx/EGt7zVyVvYTt?=
 =?us-ascii?Q?UeqkshGaTezgWAPq6dg9hA8DCCe3KrnPATs1gPqAAeRQbbWWqAJVcChZFh6V?=
 =?us-ascii?Q?YnL0cz/RklevLdrWPB3SWMJSxtnv4GChEhq2i8OD3SOk0dlChWCwXLj78CF2?=
 =?us-ascii?Q?bdfiMng17oXRIU3CX4dE6wnDJZWUgrX9VqEyghlTl8mJHIwbttrvsybZ/UdF?=
 =?us-ascii?Q?cM2moh1BhSz3J4uUg6qKlQ6NHyfWWw51xEvIS1KQWU5MPYjelm4q6nTM9e51?=
 =?us-ascii?Q?XgZ7fc08De7RDRMC/fnF3wrMOIilU7NqD5fdexZS0/4LsSyt/duu4P0kb8qv?=
 =?us-ascii?Q?UvvTlt2S5hHVl4MV4m0EFxlgH/D+w2YPrfjGwSeLwgb4RYwZU+c2isvImkqP?=
 =?us-ascii?Q?1gUMwBkiy4n39Wh8k1t3YbkcmYr/J2+9sDReaHskj4+1+8zU1Rk+vpqqhrOi?=
 =?us-ascii?Q?4KEAJnff0hPLxsYrHFJJysjrHktYrxfy0uB9ECzMtT3QW85Oujm5tv2xma72?=
 =?us-ascii?Q?Zl0/Z+6SUnxezLFVAVjzid/zyTDfAxRq5eEegDZFBoQ8U0eqiepJ7Obm8/mm?=
 =?us-ascii?Q?ZyhTgrs4DjOLS8BTkSDWjUXxPWMShWr99+pWPP3UXhfRv+VfQGsJ5Jzn8rSO?=
 =?us-ascii?Q?UvQYtORfRr/6makR9aJ57NBb9O7bC+b76gTLjYs0OPV2NNpGznFogk786qXm?=
 =?us-ascii?Q?3ewloQUrQDw6C6fFHRO66MUrQcsE84XBfcyoncndfeicj4i0fzGBHjLiO/n9?=
 =?us-ascii?Q?yAzfO2nYK6lhc41bI2J3rlh//tHbLcqYZH+M2a2cyMj6RM6uWwZcqXG5uCYq?=
 =?us-ascii?Q?4dZfG5tET0wZ8UDuFZcPZw9umebN+9IWOkuokgtEN7HKTLA8z32JercAtbUd?=
 =?us-ascii?Q?SgaCMc8qeNGWtn3HB5XNRD7gVgDsPvNh9lBVvq4p5FdRGfQeRA8JBPAoJHzJ?=
 =?us-ascii?Q?LepW/fVyJDk24dZFOUA5IH/FcYrYkWyd4irshQmiGos/85r92Afw8IM7W+ze?=
 =?us-ascii?Q?n4VAGV1B+5OakOu2tK9Pe3VJR7+zBe18oIWN2V6gIlCG/JtiDu/oT6ZHUz/8?=
 =?us-ascii?Q?InuyLPMZA3mBEKdRe6FcLyEDaYC1Roe8VCQ39h9QcM+0OBW14xyRGuNzf+M4?=
 =?us-ascii?Q?9f5legXQVWC5AyhLImBQxoaJjy2WlHZXcyYSTj7aQFd98yFt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b519e76-293e-42a8-58c7-08ded05e92a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 13:02:53.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaPjcPNrsFwgvhC0Irj1aP//5IrIKSbMZJjg08S5lernesUkQ/SQ6j1DVJLWDxAiXyNsleCJ5e5lcksS8ZKhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 22, 2026 5:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: bounds check VBIOS name extraction

Bound atom_get_vbios_name() by the BIOS size to avoid out-of-bounds reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 34 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index d4a652d2b453..ebb4ac279393 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1358,6 +1358,7 @@ static void atom_index_iio(struct atom_context *ctx, =
int base)  static void atom_get_vbios_name(struct atom_context *ctx)  {
        unsigned char *p_rom;
+       unsigned char *p_end;
        unsigned char str_num;
        unsigned short off_to_vbios_str;
        unsigned char *c_ptr;
@@ -1368,39 +1369,48 @@ static void atom_get_vbios_name(struct atom_context=
 *ctx)
        char *back;

        p_rom =3D ctx->bios;
+       p_end =3D p_rom + ctx->bios_size;
+
+       if (p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START + 1 >=3D p_end)
+               goto no_name;

        str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
-       if (str_num !=3D 0) {
-               off_to_vbios_str =3D
-                       *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_=
STRING_START);
+       if (!str_num)
+               goto no_name;

-               c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
-       } else {
-               /* do not know where to find name */
-               memcpy(ctx->name, na, 7);
-               ctx->name[7] =3D 0;
-               return;
-       }
+       off_to_vbios_str =3D
+               *(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_S=
TART);
+
+       c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
+       if (c_ptr >=3D p_end)
+               goto no_name;

        /*
         * skip the atombios strings, usually 4
         * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
         */
        for (i =3D 0; i < str_num; i++) {
-               while (*c_ptr !=3D 0)
+               while (c_ptr < p_end && *c_ptr !=3D 0)
                        c_ptr++;
                c_ptr++;
        }

        /* skip the following 2 chars: 0x0D 0x0A */
        c_ptr +=3D 2;
+       if (c_ptr >=3D p_end)
+               goto no_name;

-       name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
+       name_size =3D strnlen(c_ptr, min(STRLEN_LONG - 1, (int)(p_end -
+c_ptr)));
        memcpy(ctx->name, c_ptr, name_size);
        back =3D ctx->name + name_size;
        while ((*--back) =3D=3D ' ')
                ;
        *(back + 1) =3D '\0';
+       return;
+
+no_name:
+       /* do not know where to find name */
+       strscpy(ctx->name, na, sizeof(ctx->name));
 }

 static void atom_get_vbios_date(struct atom_context *ctx)
--
2.49.0

