Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6363FC83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 11:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC20C10E46C;
	Mon, 14 Jul 2025 11:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9gABX95";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568A510E46C
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 11:31:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS0Kvbfa/KlMR9wK9euhqsI1DKO9J+VjpaAjJ1KhT9+o6djOGSVedup4+FzjGbMd/eRLU+1BvGM6jBWXA1CORFR8lwnaRIAwbPsMCIsEORMEu72uf0SYVat2pU4XeUa1CBekVwPqRppB2avFGYJ3O5dVgUgfD/WX3tmCiCJUywman1dYifYrSGx9jO1Ad8+Vt019ky5zAJGcKF2lk+/SJzQJjgoCNL/C9uE4F9gKNAn72nksmMYxfuqjW6sWCK7B50edF0rnGdAzxVU88Sg6oAcDhI+B8sIIPxQoJ3qIoPQVspql2s5MYNojM7l523CUQ4yP1YV9OdHCOubwNyK7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGb5FSzUzyB/ZWuGk9nnSOLpP+grQF9QWfnsqe8ANRU=;
 b=Y7PLYjgq65bSA5znqNgt4eSnHcLIfd9ELFYzAaoVDrsAMcx7wwNrGVBsF0MgQE6ieSi11lHHSkhamuuYvhK+brDX5oP5qjwNxnS6BRc9WClh7AP+f8wwgCvvBP3D77adUEEVR7Pqh3DysN7EaLl3yt13qM8Z65OS+a6srTSwiKfJdtreXv65At3WZO1BhVUH7zsV+HgiarOr0L3wm27Zl7W/Lm73aXcg5F94/49DRs/pGZ6N+HJVMKNDik6H3+QwooiI0gHbWrpK28pn2BTU3bryruVRvMnV0MP3xvxtrjTvyoTAWIxNqWdoBYow7Fr2Wwpsk0SAwn2u5Vm9E165tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGb5FSzUzyB/ZWuGk9nnSOLpP+grQF9QWfnsqe8ANRU=;
 b=X9gABX95facBV5Ppmlpuc6IM7BFatNmokUN797GWaiLO7y9H1/TmdiaUq+Fxx3zvl7JqigdV/gQfSQ6VIqBJO74xGZJDKfs05Zh49xBHSf3HV8lU0QJtU56lGBR8Rl99OpItVxkg5RTfcnQuuGz4E2INIg2VqF8WN+tqcivYzQw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Mon, 14 Jul 2025 11:31:43 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8922.025; Mon, 14 Jul 2025
 11:31:43 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Use cached metrics data on SMUv13.0.6
Thread-Topic: [PATCH 1/3] drm/amd/pm: Use cached metrics data on SMUv13.0.6
Thread-Index: AQHb8kcsIU3RjcWKHky+NbVoTW/a+LQxgLtg
Date: Mon, 14 Jul 2025 11:31:43 +0000
Message-ID: <DS7PR12MB6071F6BA06636E2B4FCED24E8E54A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250711093523.1468431-1-lijo.lazar@amd.com>
In-Reply-To: <20250711093523.1468431-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T11:30:04.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB6038:EE_
x-ms-office365-filtering-correlation-id: 40b6780f-b51c-4adb-b1b8-08ddc2ca027b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wDyDVFabCL8B3lwH4K+db9+atJN+cQRelTcY9rRrIizrrVohKWgeddi0dkqV?=
 =?us-ascii?Q?abb2BMeluK0iX6innGo+oxGkfzdAhrQzCQ+0U1fSkLU1Qt2UGz4jE4xR7sBF?=
 =?us-ascii?Q?Nz+0SBsmCAyBXG9sxmONYILtFxBbxPDd1m7+LCULa2EIIxtu/RfZ/vVnTl1F?=
 =?us-ascii?Q?GJH0ZoKR74AwPn06etNtgaEjNjiZO+G7E/hRkSeN4hPq59MM2KsuUw/KL92k?=
 =?us-ascii?Q?OQfRwa6RwtU1eiGMf40+3fHegF4QyDBLpMV2Rvn/Lh1mrF4iytZtM4lpQNrS?=
 =?us-ascii?Q?XOviet5j5QEBwC4BiNlKqDDCevCMH5/WM8hOlhyYOJJgmPck2oel+CT367W/?=
 =?us-ascii?Q?nxiHLSzi2qzzR8M+ePkEKGcsywshXFn0GfiMQosNGKkj31qzss9CizmFRW7W?=
 =?us-ascii?Q?uwYEa1nEjZGezo+Qum8lWk+76DXGeMPzqCgzMMrE4FVXYWsOZK7o7kPquc4Y?=
 =?us-ascii?Q?MKselCpNSm5d2lqsE0CFdMTdrPh/3gJ+u6i9yHOUfPKGblI9JAgpN1Jp662T?=
 =?us-ascii?Q?hMEl5/Q3br6E4sg7ZdaLkp3aGwS6hAceo4m327r60jJ2A2Nae6y0xjxzEpRD?=
 =?us-ascii?Q?+B+a4BiMIO8vrQ3YKiPhuzDPzOYvMreyf3mmj5ufypvNW+/+VvrYr6t8aeW7?=
 =?us-ascii?Q?ulzF1FnAqA+PRxbP0OBLNCiVROm1/0N0qTf/2huJUgjvl5lG9JmmKx/7wElj?=
 =?us-ascii?Q?+erHhF8Rbj6hZLYBXHMkaerhyXUwSlHguYY5PIB0B09jx5Oh9X6Pp0H8l/2L?=
 =?us-ascii?Q?EEW5MlEqtDtnY1F4AQk5zc11wBUwKt/LuhadgjN686PbVN65gc4iDO1e/bwz?=
 =?us-ascii?Q?WFCkRNpwWGw7Mgpn6tIt9R6cZbZpdxnL4yayeH8W7zi08bC+c4liRVLcB3FM?=
 =?us-ascii?Q?Yl9CAsatgSGfQ2U4EDStoUTQ07GoB4ycoHhN7oCxj42qohmkPngTqvWLOnlW?=
 =?us-ascii?Q?f14uW23DtlaOoBHmS0612RJaPzRLKPEHiDlIYTvoSp55rgSVJH3NqaRA3KSU?=
 =?us-ascii?Q?lh8h8gBYNOoSkSaPHlwpveL6667Zlc6RaqEIEcYTPBT7EzI0QynQT1ZGPMIe?=
 =?us-ascii?Q?U16bfb+xcYD2/v5aCnJbG7C2RxuPgfGMQ0HR0FlY1rmdrTo9u5A+oCif8pZg?=
 =?us-ascii?Q?FWSsHMCCqRXY+QXz2wzH5Z6lTj5ZWqjcLBPXfmvCpEA1IT0buO6gpdF+mWGC?=
 =?us-ascii?Q?Y+QHifegA+qTtPgQcfBhGNJL3P7aut0rjTLccz1Y7SQlDuZT3ue+k96AAKun?=
 =?us-ascii?Q?R7jGYEmWv/EO2oBnz78zXAE9M9giA2u9tQJR8a0sivvd4lNzKo7YqHHXddg9?=
 =?us-ascii?Q?N5g2Feob7Hh4ZlM8xFXZPOveFh1E216pjxA59mWZPtp/sHH+qozlWihk5Q14?=
 =?us-ascii?Q?32rodZ61alju1rtLF42WXniQbYnyWom9Iy30w7N+yqW8OOcPTUlb7deWZPr4?=
 =?us-ascii?Q?q0mqhizpM6SRY7AG50Vbbwer2PZAdQvF4QPZNxmQEdqPKZ39PDv2Rw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bpXQkqIdhCgq+0blo1aPR1pnD9FzIlLQr3pEiQ05DLop2+fZd9FzpP/tesUz?=
 =?us-ascii?Q?sCicQcEqBp/r9V21CKYdOw1/5v75YGHoE/9+MeS1ONod+HG7pcq7ER/SdTJ8?=
 =?us-ascii?Q?7b+GE/HPNc+4+zGClya5B8XFlQe+rD8VPqmWzxxPnGLj+jQdYiwVGkdShkNL?=
 =?us-ascii?Q?8p/Sh5L24VAsZPA8nAgizDzfBB2PJaxnmkyozSf6wciZXVz+osCLNlDa6zRo?=
 =?us-ascii?Q?ztJ4enDvxGXHpfKoHhjP4h1MXGynhF32k1VwAEg/ThWeWcEN2JiuSZIgpCno?=
 =?us-ascii?Q?yWEBE5uB7y5kHfNq0IjpOvIBdMm3wJqvZZoyeM1jG8Yjraq2NvEuv8cH5Z4v?=
 =?us-ascii?Q?Xe7R6He9M6mxKtCRNv727BaBpnhZPCE1hOmeiOakrfmX4n6Zoa0wIG+FOcj5?=
 =?us-ascii?Q?3v1+uLLU6k4AgGzSofh2PXXXBc5tlOi8ceIcktxKVtvVU0GbagDAhYHP5b0H?=
 =?us-ascii?Q?dUIZ46n15dWxlRHNrJxmpTZ0hYxKoUR9b5UzuuYTPCm+M8to9N2wDaidhxO/?=
 =?us-ascii?Q?bV+t3m3LTPkupl/oBeC6iVTOs8mJc5qHQ9PZv/geoHl7nW/A+j12i5+WEU1v?=
 =?us-ascii?Q?H8Ms22zxnpL0+T0qtCUaPLSyD4Klxg3AOh6zrllFX1frQ19Jz+rEnaqPrkSV?=
 =?us-ascii?Q?PVYgY8ZpR+RzsYlcYXzYXfsFDdXKJddilipQv8QpXnS++YPL3GKMxY34GDyW?=
 =?us-ascii?Q?5cOG+s6agF7849vY2czpIgFKn9WNQUrJHppm6TkibAS9cNGodlNGRkW1Fw7Q?=
 =?us-ascii?Q?HkAAbEKacGUgwa88BfqrbMpWoxDR0BUXa2lQZMK3MPziWOcQZTsYWbPcXfJz?=
 =?us-ascii?Q?1eUY6edJj+DxTu9vIWodaw2DtxEul5UzkjkKhdXDhlSgTtHocIWw7/1nn0Zg?=
 =?us-ascii?Q?3bmpUmXSkIfieyA8Od7ajfhnWhc/kU/gLamSdpMgTSu9u+fdjJxQfhPt9IJv?=
 =?us-ascii?Q?s+WrzfkZTllls/eBBQH2XjKf5cMc/PzZenSPEgVQcE4ZQAIMNXHiZ0R5HLIG?=
 =?us-ascii?Q?Qj21YmnOSfCNMEWyxyiQEavMn5OoV54Z2Nq+/eJUQFczIkz1tOZ7PxdSocaB?=
 =?us-ascii?Q?cpSYNl7h7M19qlcbElO1JzF2OaafbeH8K0Mci0DtWWi6l6sICBzPJrixkzi2?=
 =?us-ascii?Q?poOrHkDKWhnN67UWgw8QTpNqKJeev815W/U8Cox/qJNJn1X1T6dbRukDpm6f?=
 =?us-ascii?Q?l3DRh4u0jEe+JUTFwKhCLCa+ATYbf18ayST4qRqDSId9t0Do/G4Va+og04kr?=
 =?us-ascii?Q?4/9X+TvFKA/nE3DflfTDTsNbMbIZq5MGPsUvndkYGVD0cASWPe1UzldWdBPb?=
 =?us-ascii?Q?AkCFgkyrPuhD1wa1x4CeVbVtmow71hAn0STYsYKFofF4ipt2HXzoyE4iF7y7?=
 =?us-ascii?Q?oH8sVP9BbTcGjMNI+jYWnqlP+NGNH28eZPcKDgwzPwhUanSGYjJ0cQ1ScAOs?=
 =?us-ascii?Q?/9ebXbQoNvsh6S+bPyIZuQ0GRSUKIS/m62UL3QbXeq1G7kVyMuHa0gjgrIqj?=
 =?us-ascii?Q?ewugevMctmEkfSXncGzFsVKQ0pEUHgAbCqBRkF6aWDN7gIvAXbF7es4Lhoz2?=
 =?us-ascii?Q?4es2EqOsJRj+TzYr+pU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b6780f-b51c-4adb-b1b8-08ddc2ca027b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 11:31:43.7251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZ+g0IsKzYDqzToezsW5bKHb/y/9LW8N8c5ARoZyjY/2kP0B6XXewagkMpD4VYXpUQ/vn6iuuYzBon/BW+z/sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, July 11, 2025 3:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Use cached metrics data on SMUv13.0.6

Cached metrics data validity is 1ms on SMUv13.0.6 SOCs. It's not reasonable=
 for any client to query gpu_metrics at a faster rate and constantly interr=
upt PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 68624afe7d83..0fa8652b603a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2693,7 +2693,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
        bool per_inst;

        metrics_v0 =3D kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-       ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, true);
+       ret =3D smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
        if (ret) {
                kfree(metrics_v0);
                return ret;
--
2.49.0

