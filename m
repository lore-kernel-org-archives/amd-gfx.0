Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D62C5AE59
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 02:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3848D10E042;
	Tue, 27 May 2025 02:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fjDHqnS+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B682610E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 02:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru8xz/PhJ+uyM2U4NKSISyFsSoQUAm8LNOeS1muzBKm8VF/ZpvMLuJZJdEzScfQBkfg52jVkJ/ri4SfSvftOinnwDbfxfVw2aL14zt0lRomZYSTUOtB6y9+rfygH82rarUkp0EpSRx9+f9p6a3x9tCKnMH+5RNIEGqAfjxruuD86cFhIrdk4oGsengD36UXsuHd8b8a7RLgj4FiIuQiKkqPd70WKF9djMlg7+clWqVGhPOxxT5Df8SifQtlK4Z27TzvVTRYxr+AJQTxGeFQlAhY+SMNJlV4JC+8XDiOVqr88rXAs6z8QQ3+trk4tRaSu9027uNfs8CgWwDDnlwTxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qs+YMBDn5xWj00ql5dR/H740fxgtPP0LAl8UfbHteGw=;
 b=xWka3d36kR4ud6ZM9VDUELh870FaQo/bDszU4C6g6WUEV7Az6bRsvDYBALGikszgzGHGgsbLTh8Qiju83AMn/L2oQZBV4ohFeSskHulcfS+UonuQ4aCJIgbqoOtWeS9hga8KGNJvWYQkfx5x4BtChWN4tmMbzm2Exy/KcTWW2Thz5byGPha9G0nLdm3IY/d553sqzLPqdIL2B/uphFwcv7TS7Rr+hZkHu9Wq5CTnZTmetAAHbs2dqJETwIrWOAOtiMopN2dfHyk+pLsPC/fuTfDPXAz10F/Z4uTofl0J8vTRinmvizOfVXdNJbrGHUtY8e4M3NeveP4VugVL+74A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qs+YMBDn5xWj00ql5dR/H740fxgtPP0LAl8UfbHteGw=;
 b=fjDHqnS+fF2udLssAbtEpUP2UbwVNQcGvGVL05lEfhMzlSRAfE9Hv43zVR2fhoz+3IAG9IL3MVYXmR15JXeHI6cfmQnoWjlM/4woDygyvm/3wTV2H/0VLLGuugEJhWsIbDTa86j7Kj3jQHU5fgctqcE/jWU4vhLF747FKgjqo1Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 02:02:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Tue, 27 May 2025
 02:02:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: Enable static metrics table support
Thread-Topic: [PATCH 2/2] drm/amd/pm: Enable static metrics table support
Thread-Index: AQHbzlClg0hqW664AUKnXqNFaoB8krPlufRQ
Date: Tue, 27 May 2025 02:02:00 +0000
Message-ID: <BN9PR12MB52570C56EAE72684E43C3764FC64A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250526151230.732802-1-asad.kamal@amd.com>
 <20250526151230.732802-2-asad.kamal@amd.com>
In-Reply-To: <20250526151230.732802-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d852e45a-08a8-4f7f-8fb1-ac3ff05603e4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-27T02:01:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: 2f323c39-3855-468c-7a98-08dd9cc277ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xqyESKTz00FByV7+rUPQwXzA4fvI9txfrQdFa0TRyI87WQNbqTqypgbDpjtB?=
 =?us-ascii?Q?ttAsskh59+JMjY1Or+PGnpJOUkVf7whXQYpKxU6sHI9A2PDU0ugFeyoI4IAN?=
 =?us-ascii?Q?pf+sVrDuO+prtB4JOJUCMykKOzQA2OAMnhU2yLeS27zoiPCT4H3Lxx58T+xh?=
 =?us-ascii?Q?l29Md3KV5rzRW+zcFHcwXZHbqO2mtMYSsez8HxAHbCfjpLSgPF6UcdphmUAY?=
 =?us-ascii?Q?njk/jTe8FbIkCmpJ1EwRKgkrsFULp/25DrCzodk3Urvtjr33pzKKu3gGsTrm?=
 =?us-ascii?Q?ZvxBMqJpXesSLVei233HhPUuYFa3wn/CQ5QgC2YFDD652qNL7AQqFVUmsgDL?=
 =?us-ascii?Q?jL7mLbyQy0k8lPYooCsbQPZotQpMWcR4X09e6gB0BlntVIRstoAoWnH1Q6xp?=
 =?us-ascii?Q?Wui3fbEc2I0PtlyWIMGyxizkXH9x4+OKJCJxQGcqlYek008hVmKpw5SCq1zY?=
 =?us-ascii?Q?gMcsX6E/iewfIqLXeooeaQcbhgBzXfarp4L6vltoBiLhUImRDlkX7F+B5kBf?=
 =?us-ascii?Q?k07Of9ISGFGqySVl1J1402waCbjWpHUhXN+kQhyoCBeooz0A/ACIXlgMC/U6?=
 =?us-ascii?Q?lUVPZrDygDN5bjruVcFvN3igTkQLc1wzgOfObugOv3C/NiqEnxMvbvPsFbyl?=
 =?us-ascii?Q?NI3ApvkIox4QJcJQ/PZB1OWsIOi0X8nxvpKNYiahDrbfG35r8scr7HK2fAxo?=
 =?us-ascii?Q?1O3vaqnrf1vFI82Td9DufmUjBg9M3YmVjeLhHbN2Ryf9TjJFrN4guHUpKFPa?=
 =?us-ascii?Q?np6dlx7kBaHG8SDYUCgnSF9M42sialoO0IMh4tXUiy6PIIurgk6w/XMylnwM?=
 =?us-ascii?Q?K8FfSjgUZv1OGDjxIbfChvKszrBxXNcvOOGTPZQ9nM6dK0DpkOpeOUoOhnis?=
 =?us-ascii?Q?EiwFjcx7EYP5WjdEiPE+wkWFrkva9fIFdIobwfpypdXQ7p3k3o42RIffiJeY?=
 =?us-ascii?Q?yj2eHRo22kj06+FmbocerYKNESloR5J747/q8HsvMrpHD7i3WVEB45r2VBYa?=
 =?us-ascii?Q?mzseGALShlzpfnSVnJZk5YVV3PkBzAtrOYhgFO4WwVUIaEKWvX0w3rjJmEFy?=
 =?us-ascii?Q?MOr9BN+LAc80qdNs6KMWJbZaWKjEzWQpW3+NoyPDFRefbuWuwSMS93tWcQvz?=
 =?us-ascii?Q?y3lq5FnIu31p0b1xI5UBV1u+7gFQZhl05pZlxCKwvfJHJ6n/bsGdJ3PuallM?=
 =?us-ascii?Q?nqw6noahDc1ZbNBp+5LzMU8bhjHegXWA7Ktym4NSAL52o3sh5AWzF08ycNr/?=
 =?us-ascii?Q?zV+Al6rGK/eZ7FFUM5n1ukmPInDTLUboDuGhcppVe3Zbk2bFV4dmXF5JTkb5?=
 =?us-ascii?Q?QZ/RE+BEPJQ4D0Kmvy7eNLd/cdQA0NTmLZd1JjEHXpJ7Motl8jsNyDHkuIzX?=
 =?us-ascii?Q?PD6Ixc7ibtxgaeY+1ufEceCiKf/hh6jqjTdm7lN/xkYripcn+aS7SW+B+Rcg?=
 =?us-ascii?Q?XYjh2dgBEoRcHSz+VlZDUKPyz1qe6UC7iAs06lC1gqb+J9k7nNXTjfedGMO8?=
 =?us-ascii?Q?Fm2gbuc1ruwDi8o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Vw7+Hb+bkICl0Dkxlzp0JyN6iBsnR5HrTdelrQf4oXtn8/QHecSkdYAwuzk?=
 =?us-ascii?Q?se0K1S+bwTRG0cgCnZwfQNp+botbK3phDgpFhQxzAO506qm9UmNPr8IhqJcO?=
 =?us-ascii?Q?2c/3PQNtb01b0QLu5hBLK+S0xHhKQeQCXLgx8hh1AXz/qtcVYPj8zW57AuJH?=
 =?us-ascii?Q?MB60DkJHVydXVMo0Pje+PgRImp7CMyzSqki1Cik9CQgfNWMIXg7bGCC4jRFW?=
 =?us-ascii?Q?qoimMMLmXKk5wgnFz6bA2rv8R1ICAytkD+hItQyCR30X0k+qze7sVQOXZJ5K?=
 =?us-ascii?Q?PlPbIT61rrVvdy/JORIRgjjve0t8tI4pG/F9kzAEjuY0VLOyxr0vqWBnekTv?=
 =?us-ascii?Q?+SrN7N517RtVEcC3hareihNQgwYh4/+Al3ykrJJhr7fgkFxz/H0nQYYNQ+Mm?=
 =?us-ascii?Q?AUg39DN6Jvk/f/U9EIbIMmT4wG/fBpcXzTcDfS2M4dDpHATC1D2SS+5Lv+YN?=
 =?us-ascii?Q?in6eXo73/Ad+1ekRjFFXpBKbNEvM+5rwngvMYM9d6Mw3jOr6MjD5AXZsPFXU?=
 =?us-ascii?Q?zZOR4vudlv862jUrSdno0VLwPJmtuSdXD5r31740xoGfJ1QSu1g2qyqImKQA?=
 =?us-ascii?Q?dxkqoDwzeF01Cn2u/djujsfL5dOo9mGxQ7YcaqRYuoAmnhTAnsQD6+gFvwBq?=
 =?us-ascii?Q?bAW3Wo7O/Wel/yKHNsNfAybdvBHo2Fbq+f5KuyEQhLsj7mHUOAkyISV7Bcsv?=
 =?us-ascii?Q?yZTRm7QdI4vsoj5JTlkO/aNsZrBL9l8wNGbPzkVgCVffS8AdsulKshZj3AhB?=
 =?us-ascii?Q?k/fAlCL2Oh9foTgcB1KvE1V96w9g7xcz5kXD8MF9YnHPfiVAfYFY9iVN18N4?=
 =?us-ascii?Q?+EIomS01KcBIg3baLea/nzcACiXgYepT5PNUzJjXQRbutTPTpg7Vs07GWfOm?=
 =?us-ascii?Q?/mVgbRYs6LBbYu20X+gN6G2g6qYW7SX3iNCicEao4EcISCIjkHarBAwOFbjm?=
 =?us-ascii?Q?CxuczGweoM3Bs6RZtnd+SuSeCmufkZbbeuX9pg/mXR57q2lJjoQ2d97NLj54?=
 =?us-ascii?Q?R6/Doc3OgVWNlQTy6LBJqGEVk1IlzzEgyrJpRJnqDLEks0fJV+NGnXnIl5Pe?=
 =?us-ascii?Q?/pu8tlIq+KSna5pA93s+dToQqV+pK8Jz2BtLEDGkos6jZAvgET8Wc/TrScGN?=
 =?us-ascii?Q?m0Egy86/saJT8WHbG+n7mdYlqqn+irLJWBDDKQ4Fuq/jCro+ZPBoeWWtBjlr?=
 =?us-ascii?Q?Qhf2hwxvYmT9mkj+SpaRWxe/xApyHaMtYy3i4pK61ZUi87CNOoy0MecL5Prv?=
 =?us-ascii?Q?FiucDwjeLmvzY0eqGU6yDOLAlDiPH7PALjlRMyy+4j5XGTkEgfXqTorVLrZe?=
 =?us-ascii?Q?I2ml0XCUUntF5LhXwlDjpFviI/anFCfDxO6JKnYAYEaflZlZgrHK8V+ehuzO?=
 =?us-ascii?Q?kqBFj3nOpf+z0jGFe0nugr68SD+dwWj9TnN26btOUZRhFcy3/XKu+DUEzlPC?=
 =?us-ascii?Q?7F6+M17EldFljo4g56bFz1H+NdIacjurCmIabNdD/f/0PEaJRcowIRCAhYk2?=
 =?us-ascii?Q?/WBwGwwjJLrq1N4UBNIT1aqhsDhQxEV9+1GKKh6vrw4tMP7bH1mlga2JotXM?=
 =?us-ascii?Q?hyI5FRWBJsZB9+G98aE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f323c39-3855-468c-7a98-08dd9cc277ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:02:00.5615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAMbg77qq8ajOZu8Ez9rr7dkZvfasNRtbZi8FYbhGCI5TgzUqzdVmPfQHYm4QM25tinX5shjD3O7gPX5lilcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Monday, May 26, 2025 23:13
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Enable static metrics table support

Enable static metrics support to fetch board voltage and pldm version for s=
mu_v13_0_14

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2651c8c41ad7..f00ef7f3f355 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -312,6 +312,11 @@ static void smu_v13_0_14_init_caps(struct smu_context =
*smu)
                smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
        if (fw_ver >=3D 0x5551200)
                smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+       if (fw_ver >=3D 0x5551600) {
+               smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+               smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+               smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
+       }
 }

 static void smu_v13_0_12_init_caps(struct smu_context *smu)
--
2.46.0

