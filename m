Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D475C47BCA
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231110E328;
	Tue,  6 Jan 2026 08:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KxlhubmU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C55C10E328
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 08:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcXvQLVPxKC48tCzLKchwHa4hMLfFOP5d/op/QGndDPYymxli7tDvs/UoTAR0yz469YKQJS7VpJFPBrs1ZfXrNLiTqgNgDMS4fxZJaFYc6He2I/rqLBXGGpoESIVEjvBMRDiS7A8bjgLBnpERoxc62vfL7coLDwkNvsC9gSGnBckY1JuQrsvIg/XBc5b0d9GPMOKbgcKVnS/o/jKirLgjCvQuqod52SzhQo65tIJYc01RABxduBoL+nLpWz9ejmQTLLZ2ykiuO9/SW3w0E+x3WG+xCY5QGdd6tdsNzphjijBw7EM3bAeR6IRdvQs2vV997Vf9DIgIZpECl0q9XV0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIo264jKYjLhpJe1qdeWB/U2O7Wiiu+QqnhkIHEgIbE=;
 b=mH1EEiVhZqBVDt1vLeXjlk/Zje8YHTlupmHzFpwJdvzXpiI1oxcoLKp1T3mGdKADkXCFn3aTJTNSf6cg55aSnXCvvnbL6qHBXSWApClHPMcWcXycp5toDVF5WgObzY7oMN9pELjr1U02RbbtyCgmbrTHcg5b0ROUK74YX3+GXbvt2L0ZskHwxHVA4Z9hp25EnmZlHU3TsltP1vA92TqfLQU1xmfZsSaHtTf9wLcUuM1KJaAkQwIkDrZ05E+40SRyMTDFP0xpwK6RzHQHD25Ehxax8V+tbK7LJ6M5HbFwCoKQ/VUajIZdbHbkqILrpuU4jeyiiinM0yUK1DWurFjQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIo264jKYjLhpJe1qdeWB/U2O7Wiiu+QqnhkIHEgIbE=;
 b=KxlhubmUYQGR9acXq4wHuHtDMLnIh2/NM0LhsatYnIQIQNM+mF0BeQNI1M93C/GanZSNSzUS6E0AHuD6G68xQQk16BCyIexDrSTCQDVpNJjhst/8udnuNzr+C0fPQTHjmLCeXpLwoW/sOdzxy2ziEr64joJII0uYsHCjsxQ6MHE=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 08:53:09 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::5a65:263:c1fd:cd59]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::5a65:263:c1fd:cd59%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 08:53:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu overdrive data type wrong issue on
 smu 14.0.2
Thread-Topic: [PATCH] drm/amd/pm: fix smu overdrive data type wrong issue on
 smu 14.0.2
Thread-Index: AQHcftigGGpptpZGikKkyZTI8CDdibVE1fCw
Date: Tue, 6 Jan 2026 08:53:02 +0000
Message-ID: <BL1PR12MB525482F2E2D1E94653EB4962FC87A@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20260106064911.1653986-1-kevinyang.wang@amd.com>
In-Reply-To: <20260106064911.1653986-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T08:52:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|MW4PR12MB7310:EE_
x-ms-office365-filtering-correlation-id: 04fa41bf-f3b4-45ad-e22f-08de4d010013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DD9GpAmLnt/eQDj5yMXcuI5AIgLJl8C435YNhL6IWbMYKaBESrqoTf3tGYge?=
 =?us-ascii?Q?sg3lKe3yGjB8wHaFKKDWQZ74ktx6sXFsewlzxj1BBPTxBgz8GCzCui5epAHn?=
 =?us-ascii?Q?32OAqeVOV8vSKWCcfALtJQzCJSJ6zeH7Wuar+xitDRodvRscpc9uGzQ2hdgt?=
 =?us-ascii?Q?lPEyRgYd32pMd2ZxPTilk7nbYwkcn/Du/8S5wh+S8AKfppiKU6Hb7no76RZa?=
 =?us-ascii?Q?hk34mTlpUHdD/F/SOL8g1HdHJqXVO34Za+IEIGPQ39KsaWkSHKx7ZgQ9Aael?=
 =?us-ascii?Q?CtYDB9zIb59+rF4mOIjIsnuZGJ8FxIKBRXThHVAZtZhXfIMbAW23MvDNXhzq?=
 =?us-ascii?Q?lNnTJ+U1Vm4zS3vxzYSFdfGMQl4j/9S2zRTQLo+8X4wdh6drBL45IjwRWw20?=
 =?us-ascii?Q?CtJN3FuGzDfu2IUtfDIzB3LDMDJuXgPB3Q6r6IVxMaB3x4bK3EvuP3o6jxBo?=
 =?us-ascii?Q?xm//Sav1TplBmD/toM5qzLCQmn9j8x4cxTujLAz101nR8+TWg6fnQF2MJtX2?=
 =?us-ascii?Q?6rekG1Ei60vpPLTlIuX5DHT/zLPSVBnlhjqJXG9HPQasC8fjSi/6V45faP+s?=
 =?us-ascii?Q?dd5XHe1YSRl3ljtKLVtnQchaOqZA7xJha3rQqYa6SWPHCg/fmGqR/L6x7N5s?=
 =?us-ascii?Q?rM4+ynurGRvv08FfOJsnAIRgtMOTk48eprrluor8dKftyAmPmQjlnEHEPk+l?=
 =?us-ascii?Q?AE1PGBHKMU6y2UATV0/0nc6mwbbSLLe92Tf7cyTarjuSZlYnB8nvsedc/MFB?=
 =?us-ascii?Q?IRw6W1pjLmx70Z/uClxbcKAFzTWomaYiq81ypJfxOhMTZ1d6NM0s2BU7vczx?=
 =?us-ascii?Q?iZ+SwLaJyj9RNvro9i2pFG7CZP8gESmOMtO0SRShnp9/0/uts/k18hUZiKy6?=
 =?us-ascii?Q?j45XQcT17Cm+dY92no/dMEAZcHHIfIBt6LkRaXwLFDdsE0WmES8luj9sLHPL?=
 =?us-ascii?Q?63RI2rYahakSmanH7puOAiHVqv7ggtNO8DHMMQ5rw8PxPWsNEw0BbiZVqDCy?=
 =?us-ascii?Q?Gh1ZrVyDJdQ97zCAuKRZBqOCiFJYtrAQFs5O33ajmKlsfQ+QA8YEj/LnrmxP?=
 =?us-ascii?Q?wfb1lKFzom9UE1Lkq9qdhPlRePaYdmmpSZyIQxApD0lLcke+aaTQ4C/4ZTAO?=
 =?us-ascii?Q?3uUknQ9+R1ipsFHY2UCsnKXdhqVb6Q+i8USLKfbx9Lm2IobrXUQwqTRrl4Cb?=
 =?us-ascii?Q?kqVljifoLwUKphWkLwP0JV15WCfWS2EkycTN8UjUUpexGztQTCNhGc+JHbgA?=
 =?us-ascii?Q?H4rKl5WwuaPVUvu6iFlfMRcxUdwxMFr0XA3exDK3q3B/8TzsttHQNtEA4TmM?=
 =?us-ascii?Q?G7DKFpv/3PLKod5QvtRrTwlV7G8BEQgxUOqtlp45TB2oYyYBEC/q0lPwz7za?=
 =?us-ascii?Q?sgY0PQbPV5AjlT2OYzsXehZFTk3S2Eou7tySnGzdDsXX8C6sE43w3qNgyw7i?=
 =?us-ascii?Q?7MqtELfZMMlTLSVcTiKgEuoXQ/0/vh0v4wysuuDPTwS4Mz4HQY7duxwBHjUe?=
 =?us-ascii?Q?mBLrcFA6vvf/bPQEkW8c5d6AZH7lO2qVIHAx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t1e81xUlGKZccSwykx9v5WL1Yc8m27g8TfykNTJOnsRpylM49PLeqEczr7xn?=
 =?us-ascii?Q?XePO6xQmmFqhXPq26BFISY+O0i83VVL1mty4t5xkCIqDBM7far+NqukKOp2T?=
 =?us-ascii?Q?mcW8pv2NLuNHJkDGFxUfwMVaG6C3M878sbZFxLsHfBIJcsTV+qz7wVv+bcvJ?=
 =?us-ascii?Q?m629WHaJMSV5UD9+z6FNBNufwMbm59+S+4FenEuodUWmjWt28L4AX1EujjdS?=
 =?us-ascii?Q?CQ8ExoPxwW6DSUJQ1+47NJAeMVO8vK1tlsfeCNW+w9hg691xq+Xm+d4fpLY+?=
 =?us-ascii?Q?rWqbh5TWR6bMck5ATrchDPo1pTOD18ylSjoAK1sDlZ5G4cGe/j9hK0FEYlgY?=
 =?us-ascii?Q?05x1hMQ8WSWcP9khW6nI2LJKHC57FJuotEw0MivW4fGi/lkNmINYV95qw3dr?=
 =?us-ascii?Q?OgkML+huWz4YWU6IeGiyMQOP/yqosCOWDZmd5Nj9E2dpLI9Bsxlg7+d1E3fO?=
 =?us-ascii?Q?zXAzQPsSfMr8AzAip05nFp5IsfgegxCNm0mHDLDmP/zbiUFsweFKcqtX4cQ3?=
 =?us-ascii?Q?N1kALQwbMcHLC8zuyME/pYjUBcHzTGunvXUYSfYJFmCf6s5et75JuKcfs6vQ?=
 =?us-ascii?Q?+UJyoOn4VO4G0a5D6weitSo+vvQ+8/Gnvdxd21J1j7oyOddtDsoC2l9a4g3v?=
 =?us-ascii?Q?vFYqVZAakkebFFu2DosKFyBSBWv5DivMnKzMeapmmHQfKpGh3ijhCJLE90pX?=
 =?us-ascii?Q?jVi6afknHIdeQPRHHUyg/D/AERyEtprKRgCerR+YVlyTu5zybhf+XMEEOFIG?=
 =?us-ascii?Q?j9Rm8bp6Mqhc4CbAMAQadlUDqXv/1nDseHdT0kZv2Op2LNP+NmIxrkjyiwHv?=
 =?us-ascii?Q?i0TnpmyltbVbqUwvauR+WbTgJ1g/q++R3YbO0lR8f0b+6o5qbQJYxYd47/55?=
 =?us-ascii?Q?VFfJ2CjC3AaUNFwwh10juJUJUv7m8t8KQbYzu5o81vBCF5n8Wp+aKZeP8eo3?=
 =?us-ascii?Q?VIuEvhiaFMzT6kIyfwiDHj9xws4y7MkVh5I9HU2JlibRyfaN96n2ekSmhTBy?=
 =?us-ascii?Q?4GIx0JgYd+3HRQQrnzjmYV4qBGBhnWLD+EiZHWNe5t4UNIzTguZxbcVIeE5i?=
 =?us-ascii?Q?goYJem9fOqSnupxS4qutbbWhDWQKiC2neNwy1wuYNeCSCT7Rzw8R49geY/wq?=
 =?us-ascii?Q?cnEn7acOGCJtLUMA9ba5qZG6YqWMNnNttTghWbH6bYjLkB+3MfRlpXIJBaxY?=
 =?us-ascii?Q?xiUg4y4leC/UJKIPeV+UOc5x2s96JbBpjaJzfXAi97QUYd0ARsnpow2U1+VP?=
 =?us-ascii?Q?drVf0Whk4DAbngizetK3TBdgGheYijuum4lpkmUj3QLGIiLjKoS25B/bXvPA?=
 =?us-ascii?Q?Sl2ZnZ6VhnCK3lOEMuWzOo1qSfDXHGH6ShgGRnbYIoQHSEitnJSXpg/k6iMh?=
 =?us-ascii?Q?QQx+0Gwh2pLVdPNJPrgStt9xv89SnPBdKdA8hFSAuCPNDCfzajb5qBhtjxID?=
 =?us-ascii?Q?1dzC85VB/ec4hRTtZfnOJiDB4NH3cUn6gtzQGVKiEsJ1cLiIcX7Ow16trgaq?=
 =?us-ascii?Q?rDVaNpm3R/EAi/R/Xd2THtJRxKBDXHYt6HvpyBlpUmK9rRpPcZEikz2V+HRc?=
 =?us-ascii?Q?2t/Wnd4Aev+jpElGypGPp7s+QIWpuZZu9XX8plM7mnBrhW1GZFSXJW5s1LOU?=
 =?us-ascii?Q?o8sXGJoDcBX00krbuFcGha9zeKqwAcCJOhl99+A2VIlvqIvSnFjjnGI6GiEM?=
 =?us-ascii?Q?q6DLjrd7WE73fn/fGxNzWA0iLfMEX7drHKk+8YeDQy2f+urn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fa41bf-f3b4-45ad-e22f-08de4d010013
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 08:53:02.4661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JDv4c9aQPtpE+AlqEfr3hEOfWzfy2LE8+PsgCA5mathfWuR9caSOmgGtG7hxZ3r1I7ZtuEIM2oLqKvQlzN68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, January 6, 2026 14:49
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu overdrive data type wrong issue on smu=
 14.0.2

resolving the issue of incorrect type definitions potentially causing calcu=
lation errors.

Fixes: eaa4293e87aa ("drm/amdgpu/swm14: Update power limit logic")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 4c6f62665b7a..5fad09e25136 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1633,8 +1633,9 @@ static int smu_v14_0_2_get_power_limit(struct smu_con=
text *smu,
                table_context->power_play_table;
        PPTable_t *pptable =3D table_context->driver_pptable;
        CustomSkuTable_t *skutable =3D &pptable->CustomSkuTable;
-       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =3D =
0;
+       int16_t od_percent_upper =3D 0, od_percent_lower =3D 0;
        uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THROTT=
LER_PPT0][POWER_SOURCE_AC];
+       uint32_t power_limit;

        if (smu_v14_0_get_current_power_limit(smu, &power_limit))
                power_limit =3D smu->adev->pm.ac_power ?
--
2.34.1

