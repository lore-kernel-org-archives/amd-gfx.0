Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DBFC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED9510E3BA;
	Fri,  6 Jun 2025 14:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCo0fT2k";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D3910EAAA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 13:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBwF8VP/BEZGWBLIJlHdmp+1W98FH7z2v9Kd2fstrFjwBJinXljSun2AxbImvJUBp/QoJzamb/tQfkhAAfqGWruGGxo+tEt+0RtWNEzN9tLJiBc6mHPJUvRRhpLEddUgpViFQ1edYNsPouu6Tc7eDMpsAI0yDywcOV34CfzPd1foeKxuh6H1JePl8BabJtSC2usVYJqkXcVOcPCuexVbM7pvaJUyG+mzX7wXCYKksIWSWdGsFXqz+0RoDHEN5bELkXm1H/4mnBDSIfT4ecI4p9iUBnr4vsvvi/0zPTFR/dcQo8i932JC+eUVM7e2foyo6Q2T2yiY02h84OW/hYnI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlXCtFLSkoTJQOvqZ+4GtwRx99/b25pe+JsIIXBtHGI=;
 b=OrKX9Ir5tEBYjZKI1z+XPmKavCnvG/vWYzIMfp8Z8bua0yITHdUV9nw8RuW4fD7LnRU2oC7JKkq4hKt5E/XQUKsVCyc6DuiwnCMgq3KVo6krKx/gslQl3qRi5ZqdJA+Chpatk+Tzsl4FSVnYm6tBt+lRsuBrVc9U4fN15zImFj9ngyE1BPcWOzdw63vzHoOkqem+2EGn4Q6IgQn0CA/NAtHqWI/iEryXOWzkYom55fpp+ouBKx39jPvh88OFZiFmVWbWFZr+rHiYPbngwRyMQ1bvcLhZSSnPQomvHbworsgNGBiL8hdqNZ/V1XgSSC68jmNcu1a0RnYHBSypdkxqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlXCtFLSkoTJQOvqZ+4GtwRx99/b25pe+JsIIXBtHGI=;
 b=gCo0fT2kpMot1obQ3YNmMJnaM5HrEkReSrc9p4tEZ6KV2Y0PWKj6TimaDie6YvbaaILn49fsqADcXVL2uoclkZZJe11Ei+xfN6Ql4R5ju8qErJrT3X9oBVYk+CiXKtkjBkWOe4tzHZTLw5yrT+qPArChWa6d98mX8B21qlSFW7o=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 6 Jun
 2025 13:47:43 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 13:47:43 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Gui, Jack"
 <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add kicker fws loading for gfx11/smu13/psp13
Thread-Topic: [PATCH 2/2] drm/amdgpu: add kicker fws loading for
 gfx11/smu13/psp13
Thread-Index: AQHb1umToBkSWNBvaUyyXwq1bfKuHA==
Date: Fri, 6 Jun 2025 13:47:43 +0000
Message-ID: <SN7PR12MB69324D3595BFC8C05BE48897E96EA@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20250606133229.411322-1-Frank.Min@amd.com>
 <20250606133229.411322-2-Frank.Min@amd.com>
In-Reply-To: <20250606133229.411322-2-Frank.Min@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=49794f50-ed04-43f8-809a-058fd8e91db6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-06T13:37:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 4a047540-b823-4607-b8fd-08dda500b66b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F2d+wRf0tpe9ffboh/qnIusqZACDPDOUhjtzkbdI8fjR9xAuShTCwOhcptcA?=
 =?us-ascii?Q?DmuG3kLt+ENLbxdllY87Fc7xE0R4u6UL7uHaFe8SzJNY9Z2txPqNTxg5TNmN?=
 =?us-ascii?Q?Az2xb1qvOXWaF6ChegFQvsmtHZjJuq311t/BKX6Ul576oesnIfvofgXWXCOq?=
 =?us-ascii?Q?wFLl/T3qZ+bCQzjMyDBkVLQSQ6CF2CXlQ0XJPhrwQF92WBzqgZiEZDeq8QUl?=
 =?us-ascii?Q?alNHVHm0JhEvWQmUzS/htoohWBFxfwkFWazW1KMdkqdJtNSIgZBqjVhId2KS?=
 =?us-ascii?Q?WvEnJWjSXoumggQ3HTx2C9gfZGu+maDTvfNKGY8rjwh8hKjBBIWBv5+WbUyY?=
 =?us-ascii?Q?aoQBJAXmi4EAXRb0qxfAWwGd39RxzHZ350njh9j+5gViEAublcgFv51W671b?=
 =?us-ascii?Q?wQAxtVFiNTO+KLZr8F/Bwpo2KKdGBeCfndlocwejLF1d8bMukeFGxXzUBadp?=
 =?us-ascii?Q?p3TQ4EoOx+iGjxB8HKbVtdubizjN2/FYqLK5BAsMejn48rlSHvr0gpyLDzxN?=
 =?us-ascii?Q?PhHx31qtmB7YK1zUi/2p2xzBU6xR65Kxl+DPmOO84o0C3QTQ7QFwHpS+o6WW?=
 =?us-ascii?Q?LPWV4NM4zaESfrSEE2BRsxe42VpejyR5EZqjhWf/TUPHtVeTU0255t6WW23f?=
 =?us-ascii?Q?3X1gbbdB62u7OD02ymxOHNw1JVsmlXqcbylhPhw5l35nOcs/NTIbyNELskYs?=
 =?us-ascii?Q?Qx5esBDG3b4eKN8bPA2RCXwaJ3x5kiuTtrsRaLJtofKySha8vvZ8UJsahrcq?=
 =?us-ascii?Q?2LMIk5CYcmZrd+Yk+g6a1I/jWzSVb02bn8oj93iTm3g7K7gU0RyUevnmy+Aq?=
 =?us-ascii?Q?WDRDVXRwqITo+HspKmYMx47sw421BLdeQxRi1t9eFSDqw0dL4BWAFisT8ZqD?=
 =?us-ascii?Q?NAusWqQGBv6+2vn+glh27+XF6Yn3YLVxBldjKfldTbsopjPoLPJv+6kxOa/g?=
 =?us-ascii?Q?+owyslXss85Gx3AnkcMjVl8lT75hiPMhJAMlJqMv2dFcSNPfY26wG0T5aeNj?=
 =?us-ascii?Q?2cxxmi4tMirVmVx01pbzY26yuN7raQGo3lJTy+Gt/wJM+4fov9/yF0+cHVta?=
 =?us-ascii?Q?yhYDD+vB8kSSSESgF+YyTvqWn40nDEN3okwW4mp8BnD2u3bLhMHzYEU10cpx?=
 =?us-ascii?Q?NDSlU1B+FPr/P1rlzK6Ml5KMyzTUcG8bvuyO288mWs3xbrgf4tEd5gEDdiTW?=
 =?us-ascii?Q?sQiMgLAWNiuoXLCOJaIqbNTfW0v13eEPqsuDgK8vzFxDsLBWYtcMbI0nzeFp?=
 =?us-ascii?Q?xGjZ3Tz5vGHfMCNaP8zlHIRQKP7Z7eHiVzeUY67GJC23dbk6WN3zkCakHnIL?=
 =?us-ascii?Q?e0N3HK5vnBBSgHF1zmvRbYnYGtMEruoPAwFsuP3cD81jhwjqkMVWz2gp0xwJ?=
 =?us-ascii?Q?9U9vBxzk1ExQiwp+pjKd1hWpHjyZOHEtDm7NnAjklsy3VDjvMVgLB2wCdqDM?=
 =?us-ascii?Q?DEoNL6HASIGCDMIYdnOqnwYW2KAC105bijVwgBotoH/4NFNGtk4mlWVfEj8g?=
 =?us-ascii?Q?xiFRJcybBYeiKORWc4uQGSu//Ky9IMyq0YdX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnpwXTc7jQT3YfbIaa5CvDuVpbv+XyCf4oFuNV1KSj6/7a/hTzpH1dca/+18?=
 =?us-ascii?Q?4Y6rFQ0plReBq0IBygdDpWvk5RR4XZN0odvj4ACLA430TillAIK224dv02k8?=
 =?us-ascii?Q?xX7k1OlpFmcmweztTmhRIcsylMYIOSp9QOwuWLFJV6toK2xDmbYdvUkzWhHx?=
 =?us-ascii?Q?J4NteeHhn3Rk2T6N31KiWy+0o+td9DiUifIa8NxZoiCiNK6JHm0WRvnhftkZ?=
 =?us-ascii?Q?E02wmqlJsSeRkkOd3wfXFfgz7bEbgRuel/LaOZEXxIHlALzh2rJ7J8FuXJkr?=
 =?us-ascii?Q?+KDiEu7HmlyilzgXGqhHpp2xu3sSUyA/MTS6KiPv1jrxDCaDO0FZbNuT3mH4?=
 =?us-ascii?Q?t2vK33LOH5+wtgj2RXA6m06RuC5TiuaYpTjRb0vHq2d/EOdnI/5iuSJ3BXOv?=
 =?us-ascii?Q?6mMAqEUiFuD8nE2WQ1KWTscGZSCfOHliNMLBlwy54GCTPBNVKCRi7taKvTIr?=
 =?us-ascii?Q?sOp807vk+95OtWa+ExOEvhQKiZ4rlAn9rlxMOe8dceA++l5xBEwFmJjzLTWG?=
 =?us-ascii?Q?VotCdNVnlOT3d1/RJgQ6P2ZZfHr0QMV5AAnrDf6GJ9PZZtJTVJfeI/kUA0jF?=
 =?us-ascii?Q?45ivl1DnuDDVSjSV1ADkhL9VN4G+Bs8ZVk5QxcS04VTEjRQT85zaPCeEZEjv?=
 =?us-ascii?Q?e+neg+ugVrDEOHCUp972oIPSqQEDU5k46ypS6BxJfc3GQQ+ODEIRvmsAALXC?=
 =?us-ascii?Q?82eRF4GSwO3S5bDp0mo+ERIUOOgQjcWzq06ZIDp4eEu1d/MYITPbEEhV4oAb?=
 =?us-ascii?Q?S90QiNCy78Ucmk3kP+af5gVg+9EfVMHZ+kgKJP4TJbgzX34wjTrjlBs3jANz?=
 =?us-ascii?Q?gDEINn6hA2D7Vhf6iRqZXDI+12TnmPRFs/FGUTQP45PQQioapo5VhuMYaUvg?=
 =?us-ascii?Q?smU7bXQ5A2nEmN3XOb+Daz9u+S+1aihWUHV5yqEkoJAFsjMbHIKpqovt8eLA?=
 =?us-ascii?Q?A7WPexkfzbjzKXw2+0W4GJLxvC6NLPlDpJ82UiNRkhgwxp1Lf9KFjQDxoZfk?=
 =?us-ascii?Q?etTZ7oFoJz0RWa5GogA2uUCdEAIDIHKZVpKOWWEFfR7bVdhj5uZ5Vg9unmNb?=
 =?us-ascii?Q?Cx74w9mU1yFH86Audn7c8S5/QoxcaDVj+k0oehZhvqG08K6BFfZK/KgJChFk?=
 =?us-ascii?Q?wyh3jdaNCG3v941xy/oFQQQCPYcFPsrfnAbtYtzpO17WqZ/Imv/TNHx/oGC7?=
 =?us-ascii?Q?oI8HkzLNFc7pb0gmVhOTqxt1L7oevcnZ5tt5VF8PWv3I3Na7HweLPS9yQ015?=
 =?us-ascii?Q?loxJniqO7+EQ1YDkigjFq4pgWNB3osgOs0MJnkaG+TreFGT/bRtlA01pVAcg?=
 =?us-ascii?Q?aRKdALBiJiJLUwCfcFrHIXwiFbSuLcU46KF0C34LXTf1qCCsO5UqI7N1vVC0?=
 =?us-ascii?Q?YBDrfwqs4gp/dvBvkmlbStrd8omzsk+bUgPSIY6akrKJHKOocevML1Lc2mFl?=
 =?us-ascii?Q?1CUPGqg+95p1ADEpL2wX9t65B3ajK8wBYQ71s2wEcmJeQwiND+6AKgKDqJJ0?=
 =?us-ascii?Q?c8qRx4BPS+j2rQYVOT2EuRJ0WeCbnCO8HthvJkQd+hloeiPN0E3eYOAOpJJb?=
 =?us-ascii?Q?dtn0zpUiUvt1FbbIqy0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a047540-b823-4607-b8fd-08dda500b66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 13:47:43.5195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COwVqOIpyciZOHt3EgAQ/NLDqsygqVG3ynPSBKEuuKzpgbVtEoJbAfTCKNwqbSmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Mailman-Approved-At: Fri, 06 Jun 2025 14:59:13 +0000
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

From: Frank Min <Frank.Min@amd.com>

1. Add kicker firmwares loading for gfx11/smu13/psp13
2. Register additional MODULE_FIRMWARE entries for kicker fws
   - gc_11_0_0_rlc_kicker.bin
   - gc_11_0_0_imu_kicker.bin
   - psp_13_0_0_sos_kicker.bin
   - psp_13_0_0_ta_kicker.bin
   - smu_13_0_0_kicker.bin

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 16 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  5 +++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c         |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 +++++++++---
 5 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 9588278083cf..6068b95dabff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3522,8 +3522,12 @@ int psp_init_sos_microcode(struct psp_context *psp, =
const char *chip_name)
        uint8_t *ucode_array_start_addr;
        int err =3D 0;

-       err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_sos.bin", chip_name);
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_sos_kicker.bin", chip=
_name);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_sos.bin", chip_name);
        if (err)
                goto out;

@@ -3799,8 +3803,12 @@ int psp_init_ta_microcode(struct psp_context *psp, c=
onst char *chip_name)
        struct amdgpu_device *adev =3D psp->adev;
        int err;

-       err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE_R=
EQUIRED,
-                                  "amdgpu/%s_ta.bin", chip_name);
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU=
_UCODE_REQUIRED,
+                                          "amdgpu/%s_ta_kicker.bin", chip_=
name);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU=
_UCODE_REQUIRED,
+                                          "amdgpu/%s_ta.bin", chip_name);
        if (err)
                return err;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 86309c990455..d7b62048cd0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -85,6 +85,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_pfp.bin");
@@ -759,6 +760,10 @@ static int gfx_v11_0_init_microcode(struct amdgpu_devi=
ce *adev)
                        err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
                                                   AMDGPU_UCODE_REQUIRED,
                                                   "amdgpu/gc_11_0_0_rlc_1.=
bin");
+               else if (amdgpu_is_kicker_fw(adev))
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
+                                                  AMDGPU_UCODE_REQUIRED,
+                                                  "amdgpu/%s_rlc_kicker.bi=
n", ucode_prefix);
                else
                        err =3D amdgpu_ucode_request(adev, &adev->gfx.rlc_f=
w,
                                                   AMDGPU_UCODE_REQUIRED,
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v11_0.c
index cfa91d709d49..cc626036ed9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -32,6 +32,7 @@
 #include "gc/gc_11_0_0_sh_mask.h"

 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
@@ -51,8 +52,12 @@ static int imu_v11_0_init_microcode(struct amdgpu_device=
 *adev)
        DRM_DEBUG("\n");

        amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(=
ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_=
REQUIRED,
-                                  "amdgpu/%s_imu.bin", ucode_prefix);
+       if (amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu_kicker.bin", ucod=
e_prefix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGP=
U_UCODE_REQUIRED,
+                                          "amdgpu/%s_imu.bin", ucode_prefi=
x);
        if (err)
                goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index df612fd9cc50..ead616c11705 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -42,7 +42,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3b7a011b4691..58ec53597c18 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -58,6 +58,7 @@

 MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_0_kicker.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");

@@ -92,7 +93,7 @@ const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, =
12, 16};  int smu_v13_0_init_microcode(struct smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       char ucode_prefix[15];
+       char ucode_prefix[30];
        int err =3D 0;
        const struct smc_firmware_header_v1_0 *hdr;
        const struct common_firmware_header *header; @@ -103,8 +104,13 @@ i=
nt smu_v13_0_init_microcode(struct smu_context *smu)
                return 0;

        amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof=
(ucode_prefix));
-       err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUI=
RED,
-                                  "amdgpu/%s.bin", ucode_prefix);
+
+       if(amdgpu_is_kicker_fw(adev))
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s_kicker.bin", ucode_pr=
efix);
+       else
+               err =3D amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCO=
DE_REQUIRED,
+                                          "amdgpu/%s.bin", ucode_prefix);
        if (err)
                goto out;

--
2.43.0

