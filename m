Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD0CCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 09:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5497010E857;
	Thu,  6 Nov 2025 09:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TAQGSunC";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E412210E857
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 09:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkHgoikwxhAGkIbnqD0cf+mC/B8SPBx0/TYauvoG7/XUMDK9JYtMLjvmui9UDBZEIqqEf8xbI6aD0Oh5ibVc2mUdsNbfEwLENmjvIxc4Drg9KYFX64Pi5CnTKljy+eOFJiWL6LIKUs8PqR8zqDkMA77IeoyapaKV7/eK8JFWoM10aV6W4DGJbATazFxadgIRnp8mhlk4K8HJ5rM3RCIgKpMhNzjwslGka1uDNEzKR9x0VtmcGsFq7aroAL72RlxRyRyYdvZmYt09w5CYvhIceooUcpG9M7H5g2FhtmvED5xCFpzR6f01fLKUO7b7aFWOfS1GmsKI/zyutZStnZy8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+KJhVBRY/Fj1AtCfs8sNeb7zVDFh6fY/zHUeYH7AGA=;
 b=MxY9B1XKUq+DFagDpzx15SNxUSjIaErR1J36eaZ66WDrMkjvRy9GWimPcKgifF4CUiUu4F96upzIIpyBw+EUiqrAHvsIUIS36j00s8BhzOdlZvLBUN/5XlISIyQPqFQ5PiPL2Ryp4+ZE/hDXQHcAsRBGwftPiiRzATOzEd86JlFvoYybEIaxT8oNhO+V2FH4gYR+EY/tW8BRHgBTDxWFku0mZEBStDDLIZIqDzXQCnCoIvpZbmisv0e4fHp5FKdGYYAnKmAmMG9dFF/OzmiOFvtJl/dz8wHPENeqijPi2Mu4G9IHTm+4/vQME0k98v98JFAtBEqh2334X0U0cVR54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+KJhVBRY/Fj1AtCfs8sNeb7zVDFh6fY/zHUeYH7AGA=;
 b=TAQGSunCxGyT1gLu8r1Ff37Cr7P1B3PLwXmPtTjkc9wAyPGqPS8+o34jtMmYFkoh8H9a5i9jd0yD/3MObCb7Znpo+pROnfCIM7eIkJ+zMmKBKbW3gPVx5NTqZGbGF1lGOWP6GKT0yeSSTQNw9ootn1IRUQW9z6JESkFc+3nSIy8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 09:42:14 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 09:42:14 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Update default power1_cap
Thread-Topic: [PATCH] drm/amd/pm: Update default power1_cap
Thread-Index: AQHcTvDKyimLHEZRJE2MoVs+gZZ6XLTlZUhA
Date: Thu, 6 Nov 2025 09:42:13 +0000
Message-ID: <PH7PR12MB5997F5666F73A783FE9FD21C82C2A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251106074124.3763139-1-asad.kamal@amd.com>
In-Reply-To: <20251106074124.3763139-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T09:41:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB8860:EE_
x-ms-office365-filtering-correlation-id: b1749c4a-becd-4e57-2272-08de1d18c421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AeIAhIiH8HcgilOLxmnOKH6RmQ/cBNosLHa4IdvEGj8f2giuk7txuhoTAOMu?=
 =?us-ascii?Q?ehZuh5vXcZFkOa7VETNCXgLIK1AhaYybkIScKM+W6JanUiWC/GS4hacKKPVD?=
 =?us-ascii?Q?OVUPDFCTLl64vRF8qERWq/gL4DIngONfpm7mYj/hcUJDOQDbUdc4iSjZGy02?=
 =?us-ascii?Q?mKr09EJCicKWcksAGmIuSU1aGk5Qr2lBpUajosJeWUF/xHzHsEKy44IDYEKh?=
 =?us-ascii?Q?+feozprny5g5hR/AYli+BG8VZQLHfPDMqcb6/5VuLhFjE96mtVx6ifXJcSu8?=
 =?us-ascii?Q?u+vpcH5oP0NMXnGGvX4/dCUZ3Ms8SVP0J8OiVKc8woRWwkYAfAQas2oqhjDi?=
 =?us-ascii?Q?tfgWpuep8ZAgXk9RsqXOc4XU11JYMnI2zWx7YNLlDJIMal4amyTVrnKvsUC1?=
 =?us-ascii?Q?zCCp4gmQ94dBlGncCtlCuJTteg096T6jLUFUPOK4yv/mPrkuFODHY+S6RmRt?=
 =?us-ascii?Q?piRLLKYt/sy/HEnFoUfWURc5B+wlFqdf6UkNFrLkkC/RbbZaY5ejVStHAqEH?=
 =?us-ascii?Q?oBYMt0aria2wAfy/AsvMPoNpGMWIj6a55MA/Cjum6q+nPaOMGGfhc2lugmbX?=
 =?us-ascii?Q?FCJ0XnM6cebB+Sm7NwgdfyY9ppdRA1jhjM9VXOoMBybEEhahtilGyJOafSou?=
 =?us-ascii?Q?AjNDi/RpSscUvqaD7LcOi5ir6JQOogMb2jK+kScuhZlRyPzfP3lRCZWfmQeW?=
 =?us-ascii?Q?0gtg1rcme9l8gYjkuh5vyiNxYJUEmv4ksaFcKq/sRJJS2bGIT5nHU0SAFT7Z?=
 =?us-ascii?Q?QC9CfHotUWuY87mgZaTuihGh8//LD+plqeZPGyaZv50gRJYsj7BSfMMqt8xB?=
 =?us-ascii?Q?AcpErX6xRZTLkmD81jWTWtVGhH6oHqRK+ZxRCo8MH7A6PGi/fFHhigpjUvXJ?=
 =?us-ascii?Q?ynZU0aZY1U9DpfDXpUxmPH5xY58cqm242EgFS6tyY6L9/YX2siC1eIrpFZc1?=
 =?us-ascii?Q?jAOSU+YD/dhgwkWqzYCLSt1L6SQWRh8mU+4uG2+9yYmTdiNGqFa1n4c2/o9s?=
 =?us-ascii?Q?whMN1rWD1lavq+gJuyPjlFJZgECX7k8ubv9YfrMdsgnGfJ4TWPu8sZZm6sNK?=
 =?us-ascii?Q?DOxdvgP4VUKSmFk2YfP4KhmDAQoIxGrTiqOpwUsov/I7KNFT8eEnyZJFopbE?=
 =?us-ascii?Q?IAoA3CdRC7SBlb9YdXUuTR+s0FaOUy+LPEjxAtNwHEWT5YU0hyrqIy2zdZcc?=
 =?us-ascii?Q?JPNgUgTC2Vt0fzKK0eFHQUcZr8J79gACpbTUXGy0QgPon+s1lVrkqbSs6Byc?=
 =?us-ascii?Q?WAKugpD5CWetTDaht8Z8dOss4uVO+azsgim5wfAxRUUCgvGQk4JOgpfu+wnH?=
 =?us-ascii?Q?CrwNmpHBwmGNzZzuMNzuGQOOeuIVqQJgD8/pmRJ3e68enPR45Z6ZmA4mZF+R?=
 =?us-ascii?Q?TOfd5OB0EQonjMwgoWn9E3HYRzIxNxBY+oiJ1xBp9lNSxyghBrQrPEnvtzxz?=
 =?us-ascii?Q?0YF0yfL043CpK5K33TfAhItK2f/KWHNhyeXqcE68gJC/NBwTxkPHUEMvlPAA?=
 =?us-ascii?Q?A+e/F6bu9oOdgvcUv7zjnZsdAsZwUHgs05w4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1DBhmDxbcD+ijg2r8utbvVi0JrkGQwKLxlEp61W7sGk1pqNgbzqlrUTuhat9?=
 =?us-ascii?Q?rR1fkFLNnJbd84wkFihlvWoCZiCxpGj6WO1kjc4GKknYZPXWwHT4iA27n5e0?=
 =?us-ascii?Q?4TpdYNaSjxZO2ypfApTZEGSjmpZF/Ml8a3Qd4nf8begO9YMNkD41rEQueAq/?=
 =?us-ascii?Q?4L8AYb5bAu4ZkHbTYvpfLZ72JHs/ficBliEA4QlpjjOPLFsfgl4rgkUjNbvF?=
 =?us-ascii?Q?dre4A6aR8z01tZs2OR+5Bx2QzZOmUz8Qm/JpyAiu4Rmff+Leq2CQSxOY7j8x?=
 =?us-ascii?Q?MrFONDqacs+A9mPw/gAYn1FpBg8QAX2OJtEnpTvLi/AlNTDcsT4OpQF1EyMO?=
 =?us-ascii?Q?udbFc+TzA26GRY4qvqFKVR36Qf/DMOSKQOsNIEjtQxld+6pE2mGqh11KoaDT?=
 =?us-ascii?Q?Ah0qPlj2BW6BA8snHpSlTEqS36SJuHhtQbyrWidE2exuuQPQ7eLKZsoCRFx8?=
 =?us-ascii?Q?dNnQiIfRfaRsBYdYLr2yc5CQhF6C0yFe/1XVdfIOn6HsMWtX2tX/vhA1P+lH?=
 =?us-ascii?Q?Vm6oIFYBjrcGrQBAS0T8rdpJYJi7TOeI6KtURyEG2ZD8EjKmaFBZ5AqCANKq?=
 =?us-ascii?Q?KWc8IUErYvvB5YWXi8d3NfLnK8tCfXldOg2E5Jtqegza7ZAz2qaUs2KgBLz4?=
 =?us-ascii?Q?d4okOxGT8UQsjlT1VI+4dshWnQFHkbKF/18GxK2/imQ3IevisPRg01WVOy7c?=
 =?us-ascii?Q?Xqi8ehA6HcLvY2mnGuVpzfi6hPq4GFk+sv+B8iJqmF43tjW7J2alJ6XVNEZH?=
 =?us-ascii?Q?uVYo8/6lw+JUnlVIWYWHDp7jW0GrAgAXLqv4c91VfvLRecuT59TNhoSAItlA?=
 =?us-ascii?Q?p/EWpGSEHUSyaQc2PydhEOEOPVZiHxkeD4tJsPUPgbXL2uQ5W2v3ilFPfeaE?=
 =?us-ascii?Q?NtdMuvUSm3IMdcCb6JKy+9hwWcVYLBIOyt5+66TXqesQBP0iNhGZ+1RIZIsY?=
 =?us-ascii?Q?Pp1YPO2DnsIARzDIVdP0k2c5+F6KS/v//f5X+0v8T4/FfJjhR0rN95Ud2MtE?=
 =?us-ascii?Q?ls9fXbVRiUTWNdnP5d825sOgCHJ3+eGDKrKu/5r/pTkTyipwWVa+UMHl2vxq?=
 =?us-ascii?Q?GtMLNZS27Ar6oJTObLBqsiMQJrmNVgrgpPLMACPT8lpy3JYFnuE7w6jGBJyO?=
 =?us-ascii?Q?5Nyjb+Z+wxxbZMPMDhNXtJoT/BulcaIJjZ6hFhoeSGEZ06WmifMUPvErir5a?=
 =?us-ascii?Q?oLfRln7WaGAwkX3dRtzwJX2ZpVom2gOtVLtWffNQMUxHNdCAkpkKnn4E0B32?=
 =?us-ascii?Q?UdnL+oFlBUJ5fvdgHiWZ8//ZnWbaZ3Y5jen68XTJPUhE2TkNjzzHUG9ktn4+?=
 =?us-ascii?Q?IVXdP2crrKisW3fr47E+5qQwVo6YbLYOFQ0VfAM14nGSMn08bCvFzrwe+cO6?=
 =?us-ascii?Q?XBvHmrO05M7LFiszCjLC3jrf5NSSSZZ7VRJhqhrOZyJQbNb5bgQkXlI8sSJV?=
 =?us-ascii?Q?AGLzY9CX3eh8gyV1++EC4onMvl9Hg/NwT0G/suHwDtYG/T6vOgtYOIJyxiO1?=
 =?us-ascii?Q?9mGLrzsYldXaJ5/RDuE7USKL6ZiCVE5mM/wFFJcnQjKMSwW1itnmkw7+Kbyl?=
 =?us-ascii?Q?3sh90s81UWoxBnr/0AM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1749c4a-becd-4e57-2272-08de1d18c421
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 09:42:13.9615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GF4B3uUA8gAQ5T6ZkvrdEYayM/fqb9OwjHZiCple13r9GNvdltTshToJr8Kr8JVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, November 6, 2025 3:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update default power1_cap

Update default power1_cap to max limit for smu_v13_0_6 and smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 04b6a8c7042b..115ccb5a6c3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1870,7 +1870,7 @@ static int smu_v13_0_6_get_power_limit(struct smu_con=
text *smu,
        if (current_power_limit)
                *current_power_limit =3D power_limit;
        if (default_power_limit)
-               *default_power_limit =3D power_limit;
+               *default_power_limit =3D pptable->MaxSocketPowerLimit;

        if (max_power_limit) {
                *max_power_limit =3D pptable->MaxSocketPowerLimit;
--
2.46.0

