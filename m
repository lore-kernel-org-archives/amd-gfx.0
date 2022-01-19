Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FD3C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 12:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E8410E6AF;
	Wed, 19 Jan 2022 12:09:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C2D10E4C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 12:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlCEpK4r+djs2rWuDztK14CiSPC9j9poSmzcYmgxeFIwSE9iMUJm/SeOurcmDSdVJXJGJY2CsKfc4nHjILd7OV5dP8EAW290nfb9lCyxzOOeQ2Njtu+2RD5kE0WAtmpZYrJf+PBj2KdEFNOV2EYpyNqyo/yQeJCucWiqlWzs4fUHKiRlJCCfJbYF7WgnzcPGqgGAzx2cEaaZZqEETpEeagij7xsN8r3vrfaLN6ZQO57+qlpKHcnS2d5ObIK6IfIN+u/V0caILPgfbo8XGOJ17Cyb5BRaV79jdPqZcdZhdoK26+AehJdyFncyWzBwwGAOwZkAFKdPeqT8BOtIu4T0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6D8269Y0KwZLGvbLpm5hg0O2QHh6dENy8eGYXJL/lc=;
 b=FVkZtQ3D1wzZ+5yp/S7yIhgsqQI/zjNoCDDaPRzE1RvLboWmqUnKLOqzIZcx8Q8ADngJl5cjVEeh5BklH/Ud5VdIA5gokmSL2x/jv2OqqwW6co1hEfCJFvPPqr46a0LShy6ULtsrssKYJUbTSWpx+gnw6548Es9NgCTjuPpEPAuQ138yWkoAlc1kGCY4Fq29WDJS90srXHjUszdrj/VJ37Z91QOco8Cdoe5XxRDMz56r7jegUqYsva0+AlJ3v+w+pty8FU3BZ53cNjTl5XloDH0acd+ZCb7o3624838clJU0notmAZuX0nobpsXdkazN8G7ZQiDUQ0VpSSznIoyLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6D8269Y0KwZLGvbLpm5hg0O2QHh6dENy8eGYXJL/lc=;
 b=qqMPshOIB8s3aRjZx4QZcb4lraaPuRmyaqRLojQpfGoc3qk9RcFQEWKUziw3OPvxcTUEQPEU/DZa7Kg+/qk359Od1CDyyAt0GOsMBuwDxtb0pt9Dlp3bBdayRvV+iMY4yG36FQ1rqhtGHQ2VURcoMXr0rxrHwEu+DZHaa6aY68c=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 12:09:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 12:09:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning
Thread-Index: AQHYDSg3X7UUE1kP6E+zzL9VRhsc4qxqQCoQ
Date: Wed, 19 Jan 2022 12:09:46 +0000
Message-ID: <BN9PR12MB5257CAD4D5BF0E84A5D85891FC599@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220119113048.3432-1-Stanley.Yang@amd.com>
In-Reply-To: <20220119113048.3432-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T12:09:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d5ee3245-b8ac-4617-a8c3-3c5177730724;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2814880-4d09-4184-c4de-08d9db44958b
x-ms-traffictypediagnostic: BYAPR12MB2728:EE_
x-microsoft-antispam-prvs: <BYAPR12MB2728B8874B2F8AFA3C75864FFC599@BYAPR12MB2728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oo9nlKc2LjXN9VJ5xYL8ECpueFVmuOHp3IAamIM75EH1GZJSF4VFAP8sj2w7MiL9tIAotR9AiRWvrEuDO/XC1aBnfc/c0LjDn4Q5v1Q694wmSoK6CQY9Ceon5iA5lzaCCnrF2glAJKqKS0oEedkZazvoyiOXHzda1QcFQQjGfX5vSU5Uo+aiBpM2a1vZf5cu/DBPstIGqjhZj92cPvsXwgFVkCw3qSjG0/g9PtAZKG/wfUrqG/AsLORpvDuuOgWVlZYr+7fzCx+5kKnGJfCGukHdUnepsfgSEtcxp/C1RY8Jhu/8aVI4KtsmsL9dBMcSOm92PxL37EKIaaSXLWEAqtMHnzFH12hEDthCx1lTaiUF2roFyY15+m9Nt4tHGRF4KCz21omsg9k1j9j0A1fzZ7bNoz9C6TlYNq3BC0UptUgxbk3oGw/FX8lt4oAGoCOybD1QarrU4V1BgwYAMxRcpre4HIL7NgGQU6acukCFS/tmFK4f0XNDzzJsH99WNkaXsl4XH3B8tqBU0lByJynzh6ps5eQ/LWck6g1934NJgEtFxwzCfu8xSn9flfT3ZTdP+I473OijmIS/iUJG9nQOF4GrDPQCL4Xx01TjnqLpBaO5fzuekjn6eCjL8SXmKDqmJhQD94Ozk4sHqx41MGduwdr30qC48Ch+IGwY68UbtdWk3j2SLRJi5UWXWKjiBiFLxAPzklbVk1dTY8/67Cmdqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(76116006)(6506007)(110136005)(186003)(26005)(52536014)(8676002)(122000001)(2906002)(7696005)(64756008)(66946007)(38100700002)(508600001)(4326008)(9686003)(6636002)(316002)(55016003)(5660300002)(8936002)(66446008)(71200400001)(38070700005)(33656002)(86362001)(83380400001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHY1Fzs/2ah3e11+qZ00vIaThJDIPTgOhIiWEGAVLJPDBs2jJOZ3jBuoONPa?=
 =?us-ascii?Q?pYXwaaDodir0xjmPzgjJ5iGnIz8F51XNKohrzdFTbvV/CbQJEmXxSURLohnG?=
 =?us-ascii?Q?iyxhKkWoqQ2FxgCABDbZRGqdC3zXcfdocUUZm5wRQOod37qHkUW+r9m+njwp?=
 =?us-ascii?Q?5FRAGnJvmGKuhOE9jMGtvfmG1BI1xw9sh/v7mcBtWWuK1lb3+i+ZbP15orC6?=
 =?us-ascii?Q?ucvbufj343Cy56YxFKRuB9eU/CotfH+rpGIjHpuipYlPTVdnqKZJ3Hi187zE?=
 =?us-ascii?Q?a5/FQ4gGawDSjgwQ3sU5gobyfRfYyj3vl3KtaynAWnTklWCCfvSLJXwcZNnv?=
 =?us-ascii?Q?4KvFcIMcDd/S1AhGUjW4XPh4vmTFG4RN0rySCXuyN2xn96zrJtv7AQTOSMcg?=
 =?us-ascii?Q?kZoJQjicVVrdQjMtt+trI/j/n4yk0RlK+ALkqgyPoObQ9gHpXhq7f3/zeHDY?=
 =?us-ascii?Q?39WL3+TQRjtPBggm5+26o0w0JkcecAO91+BpcWSYr9ShlRHxvZj6DAuvhCF5?=
 =?us-ascii?Q?RnZ4qwJwxFaOu+WpZXclG3iydPHDN8If7h8qYUH4Lrgkc/VwqPM3UlPBVHn7?=
 =?us-ascii?Q?dMiSUwC45vOJaAMgYf27qXBAVBUpfP3j+8YSibZ4FGQA2/xcKWaIYiwdEGfl?=
 =?us-ascii?Q?XXj6l3Hm/whrBcpkFHwGmKCpfhzQIE0+27pnd3eO1jSzSL/lJZxnZHf46Vh8?=
 =?us-ascii?Q?pvYbu136oFRyc2gyRawlOBs241BYYy/FcYGJCgEyuY95obVSIZW0wQmImYCJ?=
 =?us-ascii?Q?7bveSZqt7ufBDVSdEKPROVPwlRPg0ZoUgfQOWZN7bfIucS8xAj2GDaqRK7DK?=
 =?us-ascii?Q?RwgAAVrX6dTFHODzpDhxFYYmFQNxNlhDTgbLydRjKMhZUa1HyiZ6f80GUxdE?=
 =?us-ascii?Q?Fm0z+ymko+eykXvmA/qeaj3EZuaZzT6JNhEXA7mstYfNWOyps0ev/j7U7xDi?=
 =?us-ascii?Q?jLpCCWRZwktEynByUSRu/qCJVyXVBVpqMeY96Vdj5D7Yd6iQCF2mj5uib5NR?=
 =?us-ascii?Q?02ryhqtrizfqDX00kyc1rqnGHW3+ciwL9GOwmEM9EJL+De1blFz5VTJIBF1q?=
 =?us-ascii?Q?/b3TKyhrd0sMkxEixNDv/QBVF5JbSdv+oQDJ/uXuRuJz7kGnxg4zaKD8u8Ts?=
 =?us-ascii?Q?dv6/g8aHp6M+fUiH0oYo0m74U105j4xCDRwsUZycHqaB+x8lPoYeY0Yz8Ygw?=
 =?us-ascii?Q?M7PUbSzu16zrJ7joaG2AOztYfHf6qIAPGXD7dwcf0TntpVbZ5bTPsyv+ne75?=
 =?us-ascii?Q?KN1Z6pFfHNBDafyGTKqAMCN/RMmsS+z16/dINcVnXHB/QWG10qoE2RTvzSuA?=
 =?us-ascii?Q?06nDSN9sCsac2Gm3K7XNld/YtH8ZMzN3faEt8GrODDJpqYg3zLjwcBtDDhJM?=
 =?us-ascii?Q?fgX+WsYZrxuc9bKe/MKDAUbtbvLDdNOdw2dvG+V6zGyG0RLoGpHgOTO5F+iX?=
 =?us-ascii?Q?LfELf8hTDbDWrMVdG7Q6u1SeBfKg74qm7cPe+sCDk19FVyHvg9ncBIr9sROY?=
 =?us-ascii?Q?xf7iu6Fp/1bxUkRQgAbHR316JgAWUWz6742ZNGsFqfer2jSO9HyIGtQfKgBH?=
 =?us-ascii?Q?5SCPVExvj9JoaobXS1cXiqR27EqoxY6aE20aHB+Irc6D4E5Q1tfFUA71NR7X?=
 =?us-ascii?Q?WaBmaGv49n0cA6VhctAfc1E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2814880-4d09-4184-c4de-08d9db44958b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 12:09:46.1297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfvXoHL9FUQFB2G0oaWVXEQjRgrRzuoc2N9Gg3Pjfg9LVf1Dcm4cWnoyA78yBu8vLfjkKN4IruulNoef+5uKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The change made in drivers/gpu/drm/amd/amdgpu/umc_v8_7.c looks already cove=
red by Zafar's change. Other than that, the patch looks good to me.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Wednesday, January 19, 2022 19:31
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>; Clements, John <John.Cle=
ments@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning

Change-Id: Ic2a488ee253a913d806bd33ee9c90e31a71af320
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 23 -----------------------  driver=
s/gpu/drm/amd/amdgpu/umc_v8_7.c |  6 ------
 2 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 6953426f0bed..526de1ca9b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -61,22 +61,9 @@ static void umc_v6_7_ecc_info_query_correctable_error_co=
unt(struct amdgpu_device
 						   uint32_t channel_index,
 						   unsigned long *error_count)
 {
-	uint32_t ecc_err_cnt;
 	uint64_t mc_umc_status;
 	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
=20
-	/*
-	 * select the lower chip and check the error count
-	 * skip add error count, calc error counter only from mca_umc_status
-	 */
-	ecc_err_cnt =3D ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
-
-	/*
-	 * select the higher chip and check the err counter
-	 * skip add error count, calc error counter only from mca_umc_status
-	 */
-	ecc_err_cnt =3D ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
-
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
 	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
@@ -110,15 +97,11 @@ static void umc_v6_7_ecc_info_query_ras_error_count(st=
ruct amdgpu_device *adev,
=20
 	uint32_t umc_inst        =3D 0;
 	uint32_t ch_inst         =3D 0;
-	uint32_t umc_reg_offset  =3D 0;
 	uint32_t channel_index	 =3D 0;
=20
 	/*TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC registers. Will add the protection */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
 		channel_index =3D get_umc_v6_7_channel_index(adev,
 							 umc_inst,
 							 ch_inst);
@@ -133,7 +116,6 @@ static void umc_v6_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,
=20
 static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *ad=
ev,
 					 struct ras_err_data *err_data,
-					 uint32_t umc_reg_offset,
 					 uint32_t ch_inst,
 					 uint32_t umc_inst)
 {
@@ -192,18 +174,13 @@ static void umc_v6_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev
=20
 	uint32_t umc_inst        =3D 0;
 	uint32_t ch_inst         =3D 0;
-	uint32_t umc_reg_offset  =3D 0;
=20
 	/*TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC resgisters. Will add the protection
 	 * when firmware interface is ready */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
 		umc_v6_7_ecc_info_query_error_address(adev,
 					     err_data,
-					     umc_reg_offset,
 					     ch_inst,
 					     umc_inst);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v8_7.c
index 05f79eea307c..cd57f39df7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -114,7 +114,6 @@ static void umc_v8_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,
=20
 static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *ad=
ev,
 					struct ras_err_data *err_data,
-					uint32_t umc_reg_offset,
 					uint32_t ch_inst,
 					uint32_t umc_inst)
 {
@@ -173,19 +172,14 @@ static void umc_v8_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev
=20
 	uint32_t umc_inst        =3D 0;
 	uint32_t ch_inst         =3D 0;
-	uint32_t umc_reg_offset  =3D 0;
=20
 	/* TODO: driver needs to toggle DF Cstate to ensure
 	 * safe access of UMC resgisters. Will add the protection
 	 * when firmware interface is ready
 	 */
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset =3D get_umc_v8_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
 		umc_v8_7_ecc_info_query_error_address(adev,
 						err_data,
-						umc_reg_offset,
 						ch_inst,
 						umc_inst);
 	}
--
2.17.1
