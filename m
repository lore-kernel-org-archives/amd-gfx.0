Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DFDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 09:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A44760EBD
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 09:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A44760EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6EFE89BCD;
	Mon, 25 Oct 2021 09:29:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A567D89BCD
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 09:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMxavPeb7ulICUNTf4+pNOl00hxPUUk5jjyPP9WrSyBsSr6f9tYKNcBHNVBMuN0DlzcNMo6BGWXgD4c2qsuxuanZjb0fWPdELmoAsV+Gen37KrFF2Dl2tyqsu233srCcF4/frgPQNrfQuA4IArt/utjTyJVGNmRDLWicGddHkX7pi6W3XqZpcur6jLEOgIxKtE34cHPQKgKUSYKva0cNfh5FMmpSyB2MSW10jN02vOgSvF4PmFTppu3A0ZLXtOsGoMRCL+pO5xOnDyutHNxcgxoiW7j7S2QOMxtYFicCp2MTzIV3ge63nglbjTg8vl5PNktzgnI00B61NnCjboEw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbTDllxBsDy11Zj9c1JXVwcINyI2MeKdbv16FgPB5r4=;
 b=O0dSJfK2MvPCD3+8QkLWJMPtKpQSVLLg1xqMyBKCsxPls76gne+FkO9ItsBBnCTyNyYC5UOYWkAfHTTdgxzFgw2hIlui/TeM9+8AB916KHMhd0GoR0eEhw22lsgHcPCJiafjqvbZ1Vg4ycgBBdffbes6GeLhue2O5xk7Y4Dt4UJPON28B2tylM0l8Coq5xjq96mwnOXa5+O1FgxtEQ3GILq8f2NMG1/bhaVvRsMCw1P0bmbV2IH56q1V0ZsTC1i5EIIv3xDlJBJtggzp0BJx9afQKqkgE0bjWXyVEnkUPfNZD8Ad8bAd/rsXl9KXG1JqxSl+0BXqu8pu8ZLLSUjjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbTDllxBsDy11Zj9c1JXVwcINyI2MeKdbv16FgPB5r4=;
 b=cSM0fVOa97kI23RQoN0vxfmPyFxW7EJLelBiGgiJExKw7yqweOReex6aviclZTzL/qILdzHpwBxvJUhKaHQ7nZwOThZkLaoX20IOiEyjOZNNklbNwXy5F589bXnOhWeINhfdbIB6b8Ps/HShSvufAEgwwuj8Q4b/3OCaRIJLzT0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 09:29:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 09:29:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on
 ALDEBARAN
Thread-Topic: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on
 ALDEBARAN
Thread-Index: AQHXyX4l9mrN3JgD+kmtAl2wZ4aaaqvjcigw
Date: Mon, 25 Oct 2021 09:29:06 +0000
Message-ID: <BN9PR12MB52571EED4049DD92756E2BF6FC839@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211025085550.5846-1-tao.zhou1@amd.com>
In-Reply-To: <20211025085550.5846-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T09:29:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=589f2eff-55a4-46f1-9ec8-d5a93f018dc4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b74785c-8e46-4fed-bdd5-08d99799e47a
x-ms-traffictypediagnostic: BN9PR12MB5036:
x-microsoft-antispam-prvs: <BN9PR12MB5036786357E9C3FE197CD0DDFC839@BN9PR12MB5036.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4ZBlOhEm3Wr+vOy4KOMwPKXKBL4BCPw9RXZi4SHKjL2FIooN4wGBLdOfJ1qxDHdhTsbj0etu7ZWf4/TXkYTgjtfm6pgLstuYqJKmJRiJFTz0MeruoFsLpSbZNt3z89JGUEX3rW8YUPEP5B7P/yCnm7Bh84vjzrTPXY5NdxF6ghZkMex+66Z7GwFqTd/Jt/RzgJxPLwDXpC+r1DDyOVJkOcdmezHTxIGAI3LiabPq7lvZsZHMdj4jJdK5Ke0Xl8Pt3O2N+MBaA0tKhvQj8x2WagDhiHVn41M1z8bAvOr03cGySKUerEr4s0d3tyWkWxdMyLXphZcSyuX0jID/wIcM5oRWQVNbTfcYVwQH7SwVSLeOnoZMbKCvfu5SBhDetdzXn65X9u9IaaKXhaVGRj2FfznFpe8SZweHfzfev1Vsguw5eKyaa2Sg+wI02pRdI1RAIz9h0Excbl+5CxQPeY3XbpBao2LhIfv2rxvacYqsJS7oSr+gL0GkDyPfLLAWURSqnuT4cgi0ybegBZf8HVyvqNzuRomkg+cH7PZNHpWN6vn0iavJYxofF0j31zIqd2rhn7A24Sb064ARmL6zRiC1/0+1xrLDueJUuDwk8I+iTu2AVYod4sfF2Vicr4Lu0wLTX6PGO5HsyR6dXDeSi1zzIGsA/Sf0YUFwH2hdNurSo1h905qfazbQ5JyBYVHai/bDxrtkZRiSQ+ML7eGZghfiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(316002)(26005)(8936002)(9686003)(83380400001)(38100700002)(2906002)(66946007)(38070700005)(66446008)(76116006)(64756008)(66556008)(66476007)(53546011)(122000001)(33656002)(52536014)(110136005)(8676002)(5660300002)(186003)(86362001)(508600001)(55016002)(71200400001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+C/ps+szQZIQHIm8F53uy7vw1GdoI6yNCvyU252LVqJO2p1uTfgp2UgmJ4Lc?=
 =?us-ascii?Q?92BxfGM7ecYZBecUsb+67qOHUp+rhXwlD56yO45Y4S8nSVC/Z3L5sqassRr8?=
 =?us-ascii?Q?nPWCjyhKXUokJNlMF6h9/sJL5OMtOI0cH71s3xJUiD0hdYtc6u1cEygV880J?=
 =?us-ascii?Q?uehVCX5Zg+nes8SLONocpQ4uSDxqzlqBtOo22xmRqIlILKpFM7bytmtcDuBR?=
 =?us-ascii?Q?BdrW/stx6shhaLE2gQkoj0mgVHN5ExUVHdQ6iNXR2/EyFT92ye8hqZuP1gin?=
 =?us-ascii?Q?jeOLVIOHZBxYllJO3hgu5u7DV3FpnkbWuj1v9n3ot+XnRYYAaUhyckAvKS1n?=
 =?us-ascii?Q?R9EoSI7iwC08hCTdvnSYFOO+vc6hq08zaKH8xB6Ro8H++wMoeg/BDquXLeHz?=
 =?us-ascii?Q?rln2N8SfhsRqAqKUmT+LLyMu3xke19c62xlSZehthv9yj7xu3Ql7riQiFZlz?=
 =?us-ascii?Q?XK7qbxjI3JQGijxdsJqu4+Y9uN9vt8UNWnbF3fO5x8/5DtyR4iZmxjsalTcm?=
 =?us-ascii?Q?eIls852cvW8etOCkN1uXadUzvJWWSUjXA+9H8Rlb9ToOEuTERVKkVIsX8wsn?=
 =?us-ascii?Q?H3XILBOG/8U5sf+jOYDyYDXaK/7NUjlZl38zRvbPtMZOKTS8IX/S9XARnHt+?=
 =?us-ascii?Q?yz1TINUQmQI7fTp+tvIDTCcc4pWG4yKHgmxYa7lQBPlygDRIirLqRWBkAH+j?=
 =?us-ascii?Q?T4EnIsVAiI2ATm2yZPh/HqJSZVhcyeqqyjRB72xeLGu7QXCsuNUabrSABnZf?=
 =?us-ascii?Q?FqehCvida2rNHRCoOJmRjt0ccNqT9luke4LKTRhq/8IPMPndB6PhRHNPcRUT?=
 =?us-ascii?Q?4blb5g57MrupccpupPoA95Wr2Nd3GSWGj+RmnarY+hYX2h81LXiUOnxaY2h2?=
 =?us-ascii?Q?9m2A2ePtYhz6wXS9T+w+W9ZX+K2NKyCx69e9quE4lr7VoyVahzqhMewBPOlJ?=
 =?us-ascii?Q?BMZao+1PF2+A1j+Mq98L8Dg/msfEiVx648NYC3xK2FB2n7Putyi/Aj4XI5+W?=
 =?us-ascii?Q?spldwO4Eb7zS3fxsaewJXCc/FrxBS/lZzGdRtXSYmcMddcajBTekZLYLfchl?=
 =?us-ascii?Q?eLLHv8tbHR8IbX5dZegv3ahWJakA4XnNKcbccyHgsmiUH5f8ZUE7wKMTc1mX?=
 =?us-ascii?Q?btyeacFXME+jjtgnJVJs2mHXZ6heZubZvOReI02VIi0Hcnwhe1SxqYPqa3Er?=
 =?us-ascii?Q?lR3V0azM1+oDtexsngfWPbQvE+hB3dhc/+z0b++hbDKjCzkkKa5iHd8jN/6O?=
 =?us-ascii?Q?k44XRfmE2u0E9ZWRuuzhjPJF7yvE/qKd1mcGPiZcCYkaQwIk0w6UAYncEmr/?=
 =?us-ascii?Q?PiUM7z2jtuurINuTDxSWj9+H85Sz6YTh4QwhyErHXSTcMZ/qQqDx6vMTYkQn?=
 =?us-ascii?Q?uZ74zdI0KEG0CbQcoYXrIpKyoM7UCBhM87v5lWhTPc8m6n91GjEgIfhI0lds?=
 =?us-ascii?Q?OjuQg1WzCIyXZghEm0xzb1Ay2NlK08rRJS6f5UUCQwKkfa/KMBtTRMAoaJTf?=
 =?us-ascii?Q?Wab+cVdUsgnlWxVukrOeLoNEigKgrQcYp8z8YsU93b87NoIiJaRHtYD/DDsr?=
 =?us-ascii?Q?mDattM/jUI3pc+pVrsA1L5UGVcjazQCcYfwRg8wPL4GALLi0Y8bgJSfZIaKB?=
 =?us-ascii?Q?bEeijck+cbzg1x/v+pgTAAI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b74785c-8e46-4fed-bdd5-08d99799e47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 09:29:06.7032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKfNxwph2vxiX9Q8nYuUSWnwfS0yZe2PD24O9yWdc7rx+H4fwwfXYk9WlY3BAEZsLni51VKH9vt8IVXSHL8Naw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
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

Please add inline comment to remind us remove this workaround later. Other =
than the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, October 25, 2021 16:56
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: skip GPRs init for some CU settings on ALDEBAR=
AN

Skip GPRs init in specific condition since current GPRs init algorithm only=
 works for some CU settings.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 00a2b36a24b3..a1f424e2ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,6 +706,10 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_de=
vice *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
=20
+	/* workaround for some CU settings, skip GPRs init */
+	if (adev->gfx.cu_info.bitmap[1][1] =3D=3D 0x3f7f)
+		return 0;
+
 	gfx_v9_4_2_do_sgprs_init(adev);
=20
 	gfx_v9_4_2_do_vgprs_init(adev);
--=20
2.17.1
