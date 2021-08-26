Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457ADC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF53A61037
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF53A61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6695A6E529;
	Thu, 26 Aug 2021 07:10:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14D96E529
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQKz33iyqmSD7mp3XuGzQ/cr8rMeVVAGJkytO0X+RI0hLnmD8SKqwysYbEumjaA7bnjX5e3w2dxgEFB0Kw8SEpX6nD6633c3ffpBq586TjJn6GHxKfto+9hlwlb5WriI8uYoSIS8rG34MnZPIyrOVsa/bdACemb7jazVK9pu9sIptwjjcc9yPhVQKkZoHgS9M6HxXTMta8O5ImSBr0yaA9Tnokh72e2kjIjh7qsMoZQTd1SLaG7X1wwUvBLaBK+vKuJ/eCfyGAYz3gvrAJahySgpcUr0G91p85hH7xk4fUpf2OYL5Szenx/tddqFGDw2A/DkwnD1UO8duGcvQvPY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKNhwVTYlim4p585FerHO5OsohGhhV3z94vPWcoHy1U=;
 b=JnEByb4NelqzbC9PViGjDpQHSGlHNM4Ayanryjhu2UK6DCtGf7pDRPXnlIGTxwKE/K8MqiJRZ8+erYVzZjW49cCX395Al4UrJl9aXTTEatd476Q1354HGVYOqbZP4BJpN4tf2xD6Jo5/Cs0JpSXRUMo5Ntnjl/hfDrGGTFT1n77ZzWFR1LTSP9Bj2PU8PYCE2P+d4vYcJueK6Wf9okMVvCk6JVvczcf+Uv+UoFT/cNRqyMmHGtigPu1r1LUEpMuV4AAQFonOe1UdloSZIlxdCUiEnI1vm1cUVOcZhypeViQuD2BA+KtkI0mAwgOlCQVCpZS9ScM7pXSMQZM5PrhMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKNhwVTYlim4p585FerHO5OsohGhhV3z94vPWcoHy1U=;
 b=hWmjMWFAwbvMqHL6PpgrIj+Q7Vyj2hoO0SO+aQqB+4q14HgMZDtRfO/IPIRDndk0xZXCYEeXD/usQb60NuZBlNYF1diWR19QH2g68sjpVioSuCbGgdaAUW9uUQo8tSxnO+LSgS/ceChezCiK1UhBBNERipQvA4vFyQaWMm6zxLo=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 07:10:00 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 07:10:00 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable GFX CGCG in aldebaran
Thread-Topic: [PATCH] drm/amdgpu: disable GFX CGCG in aldebaran
Thread-Index: AQHXmkiWtdD+rwWs1kqig4o5/X2qyKuFXhow
Date: Thu, 26 Aug 2021 07:10:00 +0000
Message-ID: <BN9PR12MB52260B60613F2E37D71CBD5DFBC79@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <1629961445-2951-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1629961445-2951-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-26T07:09:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=41f906f3-7305-4e02-a5b5-6894fdb343da;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a568f67-ca35-4f2d-10b5-08d9686084de
x-ms-traffictypediagnostic: BN9PR12MB5035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5035BBAB23A944511B010EB5FBC79@BN9PR12MB5035.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUqqED/802+VjLp+hV9UHtmyRCxeQYORISR70GzCWrnAsVQqwdQE1rAQBRBxp+mR7jhpwJdlHFT+hrLk6J5aPMP62xYNOhjiO8WR2pf4uv3yOMLRsFFbiq5ok6gJ5Qzwww1sycrqL6jg4XlCUkdYY0EZdwTK4zr/Af6FCI3FUCBqojmbCAOInXkAnR40XFTdwdnV9F+yhQ02LUw3BE/ZKW8+FyU+d5hQRjB7rWMJbPOhE/NCsV9xAkHI64iva/kgNapEVr5i90VpBxEAB+fD5CbUZ6V3G4Q3gdQABbSrc1laQlf+/vSwFu2gnsMS2GVrnCtlZvHYBn6XFftdKBRmDjYx6ldVebeOF+hc60mB0tS4TOQmU1+Lv0PEu46y9Xl3m2+90juG688+9POQUie9Udh5+HP9Kuqk2JKWw6KBYU96vStOaUtyYB5iUJgnA5+rx6H7xh8+rRxG29VfqyUuXZXM2QyW+2zYAtaApJ/TMFhxOJEPVJ1L9bVEjpMyO1ODUVgHQDrpt+83QUilPm3IQmfw/ld7gDY7FvmfN4/APDcC9vHs1QARwfUwPmegEZ2Lt2h6415GFt4a7INqX7ZOtcXozqSmkw4SzSUa3wqDX6QwbYlJHVQLHtN9zdtq+vyPopTjkDIfq4TJOlfXEyO/TK58baPx4mx2UVF3d6iebKZmzcxUFq1FikDuPM8orYfsfcJnqEILHX7Pgn2HbdPvQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(83380400001)(122000001)(86362001)(5660300002)(38070700005)(8676002)(4744005)(38100700002)(2906002)(66946007)(71200400001)(66556008)(66476007)(4326008)(478600001)(64756008)(33656002)(76116006)(8936002)(52536014)(26005)(66446008)(9686003)(7696005)(186003)(110136005)(316002)(53546011)(6506007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rngk+fRDE99MS0neIMet1JM6mIbEkwY1QGfIuj9ezWMPwtzL4T6dYBJ7VZrI?=
 =?us-ascii?Q?U/AwSZpiqHjWf4pLbY9bgiCIqSrhZcDyCj72W6V9z5z4zVABIkMGtd2vtBTK?=
 =?us-ascii?Q?5K0iFBCayIwjKeADwWY1uXdrsZTZiioy3pIKXbJ85SzjQgucBF1+HihxM4MP?=
 =?us-ascii?Q?PdBTydeDbtud5qVLR+Vrr5ewre8Jp75NkT/M/GO5AgSjI6DS1HovoMk9IStv?=
 =?us-ascii?Q?NTAdGh/C1kq8DL7tO6KOccl0tLyj8CxJhGodwSBNwAk6fTBHhxIInVdRuAot?=
 =?us-ascii?Q?XCE5R9ZW8eiarHVMthSLCIGmfSgPT9MWHYnIQ1mNlnsWdDxB1kvU3OsqgZ14?=
 =?us-ascii?Q?3MB8hfiARfVWBUHlLiad9aNVS1Yy1m2EbMUrOxJZVJYWkojdzDP9m06pstO/?=
 =?us-ascii?Q?5Jgs3ut+iXeILbJ9IYQzhD5LaCmuOn2xCcCMdzP3vTR4U8djSoO/8qOEaAaD?=
 =?us-ascii?Q?H8KqmtEpgSn7z5GnJ+xv0t1oOxj8ymvnN8PTZH+tDdbxltnC6M/Zcm4M/6LI?=
 =?us-ascii?Q?e01QimNceXIAuYX8m+4J+93L0xRKGtRGIUAWN9pV25yrfj0ynKNU8lacrze/?=
 =?us-ascii?Q?z5JWQx2bTxbIRUsrhUYiPlPfYMGb307myB35PlEWA8ZcscITVq8ZayG8ZY9b?=
 =?us-ascii?Q?AuDDwVmH0nhA7TZ84YQM1r6R5Zq+N2K/PQ+9Z2F0LAbbGyjW6I0oms6y2Kjj?=
 =?us-ascii?Q?civ9GWh9Du3o9R81TUIBMglsyw6++YJMI9gUSmKVpQv9GYh0pWhXpCCHFzd6?=
 =?us-ascii?Q?90mhtSl79nxpMXGU7+eHws1EOKJOnJldvlPeLZjT7hOsVhtkeudh4MRPYVFj?=
 =?us-ascii?Q?cqk5aBud6oy9zcUqjBogj3YyQnc5C1MXjon96kFokC9dvg0OUwpwUlLPxTyb?=
 =?us-ascii?Q?aU3In29J1UeP1vb7Ia2BgRKK7zRHfH0y06Pvo/pxkx+2xhql4Kt4T1bdyaU1?=
 =?us-ascii?Q?oEHH2ofOoEOWwXH83PIDHCGh8t/o2mKei96nH0l+3IDoHxkP7yUMUStMOigJ?=
 =?us-ascii?Q?ul2CaRsZY18ML2ayx5xdsJMlrf72TzOpkpZmHmbqDmIeOF4POx/lYxd+2mW0?=
 =?us-ascii?Q?bu4AS0FZL1ecjldZPmgoJw2fsX8iapaHq4ZL1otDcE3zWQn00bFvfop0r8ic?=
 =?us-ascii?Q?cZ2Jhs3fVlEJ5Yjrz0qeJs3ary9TdZyq8a/IqdI8OsJ7O8rQ5h5JukHAfwf0?=
 =?us-ascii?Q?n0IgTE2VZVfOX8ktO3lxWHcI6LAUgBfquKC/eqRBIXIt60KaHW12C6/Dz1NV?=
 =?us-ascii?Q?bm4lJCBMbnEOXjaqEHZj/6OFCl0188qg5meFOWK+UP0PLgMDhyyBSZ6T1zgg?=
 =?us-ascii?Q?RvbA8fkfMBWA0rZu0dcZ9cUe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a568f67-ca35-4f2d-10b5-08d9686084de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 07:10:00.4243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2C8YsoNXbEeFlcy/3OBM+EdW3jyszaQqknACVH9M9QrWJkocbJvOCsFELc/yXnDC0GRXi+3KiYrH92dNeJSY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
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

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>=20
Sent: Thursday, August 26, 2021 3:04 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable GFX CGCG in aldebaran

disable GFX CGCG and CGLS to workaround
a hardware issue found in aldebaran.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index f7b56a7..0fc97c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1353,8 +1353,6 @@ static int soc15_common_early_init(void *handle)
 		adev->asic_funcs =3D &vega20_asic_funcs;
 		adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_SDMA_MGCG |
--=20
2.7.4
