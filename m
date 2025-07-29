Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D1C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 05:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3894F10E1CC;
	Tue, 29 Jul 2025 05:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jo/mODwo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1566010E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 05:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsCbe027HcRbg9peqjyrqwJ0JdCzFfnFe3JGet8cJvzPHCfota2twgKwPOMv8apt/k1sTVXI+7wqqTr8IMy2i7J0qDB3AapdEz/0EsRmZ/yClVfSQrCXVTq1iUW9SeQQ1JjbfwSABu1bOwVchyLiGJJEo59/SFMmn7NBMuvAdCHKeE2sYT+4qjtF6PXCDdwAr2t8r4Zz7EVevXYLTxk/IqR+9PPRAGICcsaDgPtMG5k+jpBOfCNius6dcUyTBRJKrAZKkh7hmB+Jp2z9WtFdLNjsIGKZivWjFSKiNnnn22+d2lNXxJnVqlddIZsjajXUdTMoNhYG4Ru3pwWjWJYtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2LzqsdbR9mqhxV0nxcD0OT3LqqFZJVCiiGQVC0Lwyg=;
 b=h9N0DTlH+p67dbj3xuE/ijScbBXLWaYyG910OFJbO3miavvEGQ4dfATFbOmsdFONJuuFeeHUvht+/RpF5nQvqI47CXs9ENhXXnMuljU5F0VLZpR3QmT12vL0jDxSfNp+fSotqbA0Fdvl1byS5Jhx8+SJ9zG52tcTY0IZ/7NaYcSH9Q/V+3UdAMilmgIZcmpSY7NAM487O60f50G2+rRorP9/NcbHNkVDorQtGz9OvVSkFc3NxV/pbmNueXidfWzGGWAsYshQB8nRu2/EzAO8B+339qI68Zbxm1aXjUw9MjTgvH9PPl0Qvn9KFyLy3uLHh/m+9ess1rG8XBGUbOYzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2LzqsdbR9mqhxV0nxcD0OT3LqqFZJVCiiGQVC0Lwyg=;
 b=Jo/mODwoRPZ+jT4lCcutzNOOomws53qywypWUXmkW7+ayEvNr1OXGSjzMKx6Ko6iUpCIeHDZ0limgjmlGtxKunzwbJ78szXfNpB3AyTjsarPu+OPWxEi1qNpHba2KQ9MbZfGAGc/4iLMJD4KI2l553f5uU6RNZYFehEcy61+VvQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 05:51:52 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 05:51:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG
 new chain
Thread-Topic: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG
 new chain
Thread-Index: AQHcADl0lKABEgCW7EuWly2ubGc0TbRImJeQ
Date: Tue, 29 Jul 2025 05:51:52 +0000
Message-ID: <PH7PR12MB5997CD799A393D24D404C80B8225A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250729033205.826312-1-Stanley.Yang@amd.com>
 <20250729033205.826312-2-Stanley.Yang@amd.com>
In-Reply-To: <20250729033205.826312-2-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-29T05:49:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: a78c5956-5d6c-4dae-f628-08ddce640459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wMItnpQjwTGFy4BlPMUZb02VpcSs0F6UkuPDktHjTSqgVUqyVek3qxStj1va?=
 =?us-ascii?Q?ybV5OLZZhTfp+XG2Ahmp8LH+0slz0elD/jvJbGtM0v+xieB7YWt9f6kzFTlC?=
 =?us-ascii?Q?D/YCH32BCN8ylfe837ztRm3VIH8prcyX+b1hqlEe8yGcV545txYM9OujQbOs?=
 =?us-ascii?Q?Tc11WKWYH+uLyMYNyRgpiRG90dz/VZ4iueaopaxvk3xP+tP2ag+Q3iHSBrHU?=
 =?us-ascii?Q?e2xGVVnYly1ANSA+rNTC+ccW7eU4oHQX/RxDd8wG8G7U4L8m36CjVl/ycLl6?=
 =?us-ascii?Q?rHUwwG1TOB2me13P5x5CsVhN1YsdiZsWuxu3IMfYeZwjlkXtAtdN7BQokxFx?=
 =?us-ascii?Q?D+94HdaKR30nAf3+uUPn1TaurjZ88JgCfoYou0+0rct2uS3wmQyxWDR2HtLD?=
 =?us-ascii?Q?+yubezzJLM4v8p8hZzp8FcYPkyC0dY6Fav8ITUjZ6KERD+d4YhP8KZuMKvn0?=
 =?us-ascii?Q?hQQS4agYLzL/PiUBO/pp2mrnVi2sWvzJf8G8S4MOB7fR7TrUH25kGFCX/7Un?=
 =?us-ascii?Q?6hGAUS6L93Sxu+9HtpO9e5R1jxV0po0Hak2RerqKEFet2J7ozJcpm52B2tyo?=
 =?us-ascii?Q?8ZRM/wbOh8yENocmv+F/XwOe8qXyKAIeaDMRIOTWlYo3tbxin05X+CRvb7QM?=
 =?us-ascii?Q?j3aGX1sLheT+jdAiITMoBwZjD9xSoOoNyVe1x7jZmVx1K5w1BEXMaF4/SrCq?=
 =?us-ascii?Q?fWKVY2v1+oq5bEeuubSwU0dRqO3PgcYeZv1rj578Fq1MiI+RpOo3dXMKz9c/?=
 =?us-ascii?Q?s3SulZLZJ/gd0+q26+2Tk4OISav8MmadwjaErlblLIhkINmsPNCLS6j7e3pl?=
 =?us-ascii?Q?xfXF7J4D3axOGJhocKUIPv7d5RoHLWPyvTEWXmj+UZS0qenS5duLKsRgPNku?=
 =?us-ascii?Q?RdKizDiOl8BNrde96Rt9MaMdhg1Q/ght4aZxhh8t0KeyhRCm9oObZ1E8vuNP?=
 =?us-ascii?Q?ZQBcssIDh2QPG0wtGuhP8TH9VCdEs0lHGdFQp8LSz69ItQRl409NTKqA3N/R?=
 =?us-ascii?Q?yRdh2k7NOvf79Ck6LPpDzAP2Q5GDs+b52mPahVw3KEtrhcZz8EHG3/z+g/cN?=
 =?us-ascii?Q?HqPq14K/Tn/4il+/8K6z+kc6XCNzNdaG9HF14JgzqZYpup2WD7lSEnVPD8Qa?=
 =?us-ascii?Q?XEyyYEmzaiBpKKsNXdndL/eugN0idtca21sily9xIzzZStTejYmD6mIha5XX?=
 =?us-ascii?Q?L7cdzS2fmMyafJf3JQWyxTd9B3bCcj1RoLHwZB1Ypf9t9SxGoVllPVCZQaHX?=
 =?us-ascii?Q?aYoowNlP+39PpIX1oHe4ZMhUVVlNvDQPiZ9cPKbmTIyrx0NufLzq3noNnZLo?=
 =?us-ascii?Q?K7M1opz/7kQoToWE2SWC7mM8q3cWTJQ/vUe8Ber+GF9iXz+j3jENtYl7hCAy?=
 =?us-ascii?Q?aowzaVv4OyGI6TYCPXpFBchHzKrN7HsPLl0wZEoRuMk4Ibj1sXBPlbCwrZTo?=
 =?us-ascii?Q?DGiWYmJOsZ+OtE6Sjo5KFXJiOJlZWE1n6jeqxlQCVytsohHXYxuWdQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O8qXWMzhuyOE3FJtBTMzWYwFlWGI1xWzN7+W8Y2URSH3RPCKJ/q/8tNhGm6h?=
 =?us-ascii?Q?TCPm72adpsEJ9S3Umnq6w2gJli1/F5fgifnnTtdwcXZdpB9yr2oBTpcOsoGJ?=
 =?us-ascii?Q?dzpHBlI7vqjs3GDFAhqyaR0yA5g+O9rpAZCiDa37SAUvJISPV5Q5Uz5IVtfm?=
 =?us-ascii?Q?mEOb3hl/GoObG2FOgIgkca7NALmRg3R1jCbzLUZ59JjNVqGORCSpR6VIYmAO?=
 =?us-ascii?Q?B6bpJfRSfrrJNYqISsBy+UE0lq1tgWZzRS8Gyl96rXaPDwXq/7M5/CQKSmCm?=
 =?us-ascii?Q?k0kq/unO5josrV8913YWbhV+yu6UlKvnK/nEMBpy7oxPOaTRapYdj5RxzK/E?=
 =?us-ascii?Q?jbUsMTZ0mNBtH2YRwBj/+OvkCcZqgkBBhFaFki6RhgMaGPLd93tYEJZV2dDa?=
 =?us-ascii?Q?PHJ/k+RmSiEADggNj5jsCpbDJvw5aAwwLmOemBqtoqZ5y0vYecV0tiGbQWaq?=
 =?us-ascii?Q?Y1j1rZ1XQ3Htp7Oi10cCaJitnb0H/alUYbyESumW6LVT+mwoEBZ5T2J5i66r?=
 =?us-ascii?Q?buO4aHVYNxVb3LDSsJGV65HEwfZ5/vlo1odhXPyrWuwXdPFmNlNG1sVy0B0W?=
 =?us-ascii?Q?1AWq20oHlw+7poafObm7/bcMmnUYisS73wUiUl7/aVBGshIBMybHinGaF+zN?=
 =?us-ascii?Q?6TsWW4e+tzbZSZWWMyXO0ebV3s5GSrprijGhSpzggEMGU8u2MiINuhhWvWU9?=
 =?us-ascii?Q?afhOTTabyg9w1fVKuqC+eOpCjvptmqzsuXlNMiFkGprW+3wGV9fbXWyvl+qs?=
 =?us-ascii?Q?nQ7qTkQdRVPHelVwz20bpMPWyUtWZX0l7VcQrMQXnjjjTpVpaXAZow6beCOh?=
 =?us-ascii?Q?JBZI1rv6dKgrccwYtVDYflL/R4AY1PRAlwfNjeoT+RxBnlJWg//v/QMb93/8?=
 =?us-ascii?Q?/lmqZD2USo9bqqDyAxOERBMlSVSHGNsS/POqdOnh0KprAq06N+klR84MTcWu?=
 =?us-ascii?Q?YGLRQURq4VZ+DvaXU/TS+PNOL6GFdxA0uba6d5aE2ydvULmIEPqfKBzHT1c6?=
 =?us-ascii?Q?l+chfi0ssda0B7xzlG7jmZF4HBKxXt7u32L+cPAETGKEasHuuKHZ6W9yD30h?=
 =?us-ascii?Q?PTphJjTk0H+1SLkwl3oZx9T8B57EBhRRi5xvr4+p+A8Mn+nWMEpU19Nvv8lf?=
 =?us-ascii?Q?s2Z9fNRuxzMvHslDeuigGeb1JV6jXuh2s3AazMzhS+A3q9ziH9ZrZSHaSzRw?=
 =?us-ascii?Q?CYVphc1+spZ/rG80qO5RuOdyxZClElRL+gNBUoFTaU3CEDZhs5WULkmzkxFm?=
 =?us-ascii?Q?GAc/lI78qxSlifp31fn41euimYEzXSnpJlNhuwPF2dNq77NL+HnGXlT47JDq?=
 =?us-ascii?Q?QmvRKSBYBUWWH+8Tih93mIXNR8tBCvDn2+U8Wxs9zcDRZercN5yG8QC8vubO?=
 =?us-ascii?Q?EhNJXyxtsqkqZoIA6RuWmbPtr2m6HtwAp5VJBeOCyEz7jVuWyAXLWD5bmr1G?=
 =?us-ascii?Q?l6Zirkq+mSbCvi/IgPHSxZHY1T3mofqIkh5s4KKAZhP8JYtAMGvdriuvKzvr?=
 =?us-ascii?Q?EoSQpTnFrpmJGhjY+ZarfJBck2HrBWNpkNqBW0J2QSbrwzRpFp3QfXhhgllv?=
 =?us-ascii?Q?nBUOMqVKnv83Bc0li6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78c5956-5d6c-4dae-f628-08ddce640459
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 05:51:52.1503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfqtyDq3rxkuf7t/9v9N/FQH3+nTDIp/7pm6C3/HnDtz2K0SjX2VNm7ue3D55bV2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

        16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */

it is better to correct/add the code comments before submit patch, after th=
at the series patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Tuesday, July 29, 2025 11:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>
Subject: [PATCH Review 2/2] drm/amdgpu: Add new error code for VCN/JPEG new=
 chain

Add VIDS and JPEG8/9 S|D chain error code for VCN/JPEG v5.0.1.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 ++-  drivers/gpu/drm/amd/amdg=
pu/vcn_v5_0_1.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_1.c
index 51b9148626fc..961ab557fed7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -1028,7 +1028,8 @@ static int jpeg_v5_0_1_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
 /* reference to smu driver if header file */  static int jpeg_v5_0_1_err_c=
odes[] =3D {
        16, 17, 18, 19, 20, 21, 22, 23, /* JPEG[0-7][S|D] */
-       24, 25, 26, 27, 28, 29, 30, 31
+       24, 25, 26, 27, 28, 29, 30, 31,
+       48, 49, 50, 51,
 };

 static bool jpeg_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struc=
t aca_bank *bank, diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/dr=
ivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 0333a2833b2e..120414fb024d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1565,7 +1565,7 @@ static int vcn_v5_0_1_aca_bank_parser(struct aca_hand=
le *handle, struct aca_bank

 /* reference to smu driver if header file */  static int vcn_v5_0_1_err_co=
des[] =3D {
-       14, 15, /* VCN */
+       14, 15, 47, /* VCN [D|V|S] */
 };

 static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct=
 aca_bank *bank,
--
2.25.1

