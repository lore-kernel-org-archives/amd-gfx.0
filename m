Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEACACA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 08:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B36E10E2DF;
	Thu, 21 Aug 2025 08:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4qd27Vcq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E82489B99
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 08:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhgVl/+FOrmuq0DQp3IJY8Hg1B2OQrR9AkCzeI/8MXTtFtciIzWeJHkMRCl8+QhYlLpTidNcm4TLQfoLuBcOaqkG8YZMBaKH97ZUwdnuLo8kU2vjc54i6dkN/UiDP89lm8CNuMEQumeymIE07v7ZK5hQZvmtQwyB3XZWfk1BfZJb2raDEF0cqKeJJONYDxepn45bNqwVRHzr6qUsFAO55rT1OvdfesPJ/awBSnKX0yaSX0MUcf0EDS3wIASQWeBBTykWMpwgO9Wxv80rzsvap5ATZJp76hUKz/VuzjhtsAgMnfhwVcalLWTY8Xh1SwZfNGSn94rvxU6paD4VGzygTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJHh0l7QqeTaYqrPf0K8M/IEN4Jr1AfFRBiw63lW/Jg=;
 b=UKWiu6sEuwf+6Dk6i/oXSF3kyeDOOQeCVzfNgcdFZvGsNyUDXJD13Fx1QOb8z7soivuoRZP8u9RJNj2R79Kk/6vesemhPOYIwLzGXdxeWf6GvEpzOVOg0N0GKobaT9kh8DNu9HyRvotwisPIpdnmWZ91x4Klhv+7+BweBkajI0j5+yUipUDmN8bgSnPDQByw8Cysc2GKU7i78+iyc73O9MOk0+lLmKzILS7Ewoojz5bP/9gFJuPEiHwJ7ZUJRz1tPVgprt8L90D231R9lso26U2j3My6jg7AtpW0dFDLEDpsl34kvUVebOUUJLpvtrCkFkg4Sf0PURVm3cMEWKr6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJHh0l7QqeTaYqrPf0K8M/IEN4Jr1AfFRBiw63lW/Jg=;
 b=4qd27VcqjjkULlcubRLcJOXvo5JKAyZdIWz7u6TGo+zkBOiNR65Rr1rEs/QFZw/qc/w0m37JU+q4Mg+YHLARBNtV055gTF3qcT3S68D1AzGfhbacexwVFudD6doSOTJmsOGmf+5N7ALPShpAIHQ4JcdZ12c/kGbSt+XUpgIlDzA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Thu, 21 Aug
 2025 08:33:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 08:33:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add support for dpc to the product
Thread-Topic: [PATCH] drm/amdgpu: Add support for dpc to the product
Thread-Index: AQHcEnYjRV/ES/aEFEu3azuHqL7VvbRsx4+Q
Date: Thu, 21 Aug 2025 08:33:33 +0000
Message-ID: <BN9PR12MB5257D26EB8B29FF4AEC6643EFC32A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250821083219.337900-1-cesun102@amd.com>
In-Reply-To: <20250821083219.337900-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T08:33:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6835:EE_
x-ms-office365-filtering-correlation-id: c988c43d-9cde-4201-f0b8-08dde08d6a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0pBkTwOY0018QZwXnk1B7JQLMV2Qc2i9IqvtHeBQKiD41X5Wc+tXPzZuUIX8?=
 =?us-ascii?Q?5if+HCu4FTDiB3953Zp5PIwpc0shnzzZW7tTt360TY3BacgoV9PqYLz8liOD?=
 =?us-ascii?Q?OMX6Jb//Ws1Bru9Ympt6o8YSjBBguduQGeLHzDLsAajuRFESduS7mdPXTUFd?=
 =?us-ascii?Q?MbxyqwpDQwqJKCf8rMqlQjWHC36n6K2CPHZ87N327FpxpLom5/cQ3tBykqrE?=
 =?us-ascii?Q?WXK8pmh/FJLoj14knqefBUjSwRIXpdu4igBSMPuYyTIQweS9YTEOEiwGHyy/?=
 =?us-ascii?Q?FhPbpO7k9QlJQfhEVxlN4ILpQuykrU4dk0+QeccKyxCUAWd6FYFqP+uEREVm?=
 =?us-ascii?Q?9O+QGqcERSLBcnRWN8VqGB9dpt/2VJUwTdv/bCYBNr4QxczWaKprh0fqYEUJ?=
 =?us-ascii?Q?Ka4EzFbaHaT58JiP6H4b4kbzMfyqNOEE1h2bwc6HXE3mW2ZxlZ+vCLUGVCot?=
 =?us-ascii?Q?4mWwsDFS1HAxqVJijFhahapd7+tiSY2uRgLO7dqmVNmzFaGHlB05J82TQQ2t?=
 =?us-ascii?Q?3P3V2hl8L860sBPGLraggE+u8BGnHWu5Vi8DRqEKzFapeuWu5Hk3TqF4LN4C?=
 =?us-ascii?Q?QOrM58QAV7lhil2UanZxcACFSbSNZOryG8qN2tcyQG2Y6GuFLsyKZ6RteofR?=
 =?us-ascii?Q?a/IiSpmiYJyMa9u/VBxPwFu/Xfey8hRBDTXDQLW1zH89cwS0NDBWKlJtB846?=
 =?us-ascii?Q?0agJEp88IVSCUIFyVs4EIxElqz8EVwRZA5CyXCujPAr17d1oCwpw98LFZPEY?=
 =?us-ascii?Q?TV+N9QR7/0sKvRaWbyg/xdcucvsllDssPQWKGXy33aOZvjVW0iH6FrFpsoOW?=
 =?us-ascii?Q?eJlTbHE+4icIOPaRFb59TqeEVs4p5+V50zr5LMEwV17xyzfCCvMQisQgVT6Y?=
 =?us-ascii?Q?3uZ5+3VnUaXKYI+qYuwQon1lP4LNjbE0AFe3wyr1paTLpOYEBOHZE5Y8P5AV?=
 =?us-ascii?Q?6FdVGOrvs6XT24ZMDorCjiKpi8lAWCxVkGT/q1fgIyxSojuTFemuIEXstYsp?=
 =?us-ascii?Q?gDLWTgiHw+VhBspToD1PxKk+toxlnjEXM8JR+7KZQTTLTmNDreQb+THQSAwC?=
 =?us-ascii?Q?BslMNnrc1CbRma5UgiCN4XVY0a7yeNpqhu1pdYzFQnhj1YjS1YMWqgYR/fHM?=
 =?us-ascii?Q?M0522QpNRjm1+pamxEwW1BhnO72jraT2Sl850ghcthfk5VrQFqFzPYuxHooT?=
 =?us-ascii?Q?2rbNvr1wUssaYvPH65V9pNMkiTjARoOA1z/iSsUo4+Kn/omaj8e/iZfwD8ry?=
 =?us-ascii?Q?St6A88w4w4ishbOCDy17P1xLE656q9N+VSGLmL5J8gIXbA3N8i3LmiyS5XzT?=
 =?us-ascii?Q?XilFQbJ0x3Sm5eQuE3A6trNtBDu7Rg2gyeNbZQXiev8erKlC7vs0X8AWmqjH?=
 =?us-ascii?Q?Pt2pQZWJJ3YzjoDeH3zDPVCxinfKVmE+YAqZPeLUkiwU+qOJrzZfL0HOjoyn?=
 =?us-ascii?Q?dd5RrnicMWWzkJfkEMxZmq2Ksa7+sjXsecZXXcEE7xCVbnS49q3zQES8+YdK?=
 =?us-ascii?Q?pusIRkVX8ZXvf3I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5efB3A+GWNOUSeiYJHFrjy8RVWui9lp7zZTM0U3BsYf7B+EFDK+fiDYqa/SI?=
 =?us-ascii?Q?8fC4bm6x73B2pDfwMfjSf3HHTEoHeRhZRvpLgMrRKsVUN6REfFMWGpbKkgbW?=
 =?us-ascii?Q?e9Ihhb/aEch8ZOkMrbpgN4CHkI/yOmoqu+cDfkkkuFUtC7QDN2n68Xi6Oazd?=
 =?us-ascii?Q?47+kk/D1SRMe7nSknkDur6emAC0mxS2jJSd8TY3KhKEPEWiBJMO3A2OyM43k?=
 =?us-ascii?Q?ZtldT01AskH0hDbbr8iBI8rJuuD7kAu8E7r657zenl1BnhPeOBrkpSRf1Yxq?=
 =?us-ascii?Q?mWHXoFAW6s1icohhCtXf4bOyu/vTm9w2H72af6c31XRhc+NxPav9w5MXj2eQ?=
 =?us-ascii?Q?EjIlA2Ykn/YhgSLmYBlHzbUXGzPSBnVuIdfaMxsfVy9YcO7zS2bI3cCN+OCY?=
 =?us-ascii?Q?lhbHeZdlBw3rxqJCvjCe3J8l8lP80cAVBJCpiV6zwSA5fpMDKvLTuStr87zp?=
 =?us-ascii?Q?AozxspDbE/5kXvHOJG0NEmL4uUSTaqXn6Xqapju52ZRrdN6qTH54/ka36102?=
 =?us-ascii?Q?AMwJwpHCfWe6HDUqV3WPUtDZasinS74BFilxpb8QlgVJb8gBsrzyvpbxF0R2?=
 =?us-ascii?Q?0rn6W+fTEZ+kLxzuObfJce3oDPsyJ0DtXOCZ75cSAA3WkDDxI4kJVBMi9YUc?=
 =?us-ascii?Q?W/9mkCjoYeG71avLg236aZxvs7u/pObK1uxk7hy+davPpQbDDhaXwd0T1YjN?=
 =?us-ascii?Q?sPKkxls5+cSVCkf45hCKu2c7CHHFHHgHMDXo3jGEH/BCDfqZoSMnW4QKhC3C?=
 =?us-ascii?Q?CIAUBEKR3UAjCrQMFGnhLaSYOLXDWlH5JuKjTnWvXdFL4WC9otbwo3ZRMX/o?=
 =?us-ascii?Q?HQ1MNY+M/oxVIFUsP3qg4eXkQxVpdvqV02bVNlRlxAulVjQ6xxwcnAPhedGu?=
 =?us-ascii?Q?+6XVX3WIrKVps2EIyr7qg6bCWzsyPWus7WYOp1fol8FZmfUHXaYxS7OTmD+L?=
 =?us-ascii?Q?Yx0QnuLoO/S5OJifE5caL783AsKADvHKl0NtRRq8pRdRK86gwab92QmnlRm5?=
 =?us-ascii?Q?n3EecnmXNxxIjiuwN/rQye8VAxAUeqB96ojS3GaTx+/YM6350oaEYJDXnw6s?=
 =?us-ascii?Q?/sFUkoNIss6kiRuq8NMO/bG+91DyADlLVeTOpJvZnWGAFyuOEcTQntFj/zK7?=
 =?us-ascii?Q?0KVqXdPTUaB/oHpbWHWxjstSsx9xqL/fn3g0pJSySQyRS6dd/9V0PyzxVMuJ?=
 =?us-ascii?Q?KfNlAIU4GuQU163ixwF2ZPuSN5NU5SpeD8ixKQ9nTWzFwHFFz5LZcmGpFNBE?=
 =?us-ascii?Q?gxCrlFlFs3KnHO3Uq28CkIhFFDJmLuhD3R/ODUCufjEnCaFz5JH+baWVD46a?=
 =?us-ascii?Q?NfGkRCf7TlvbN+nYxW/4x/RNXZcffC1ATW5S0anFLG65EwUHVyQZfo0S04Py?=
 =?us-ascii?Q?w+YKQVeg5pohPRRsv2lFUv1hx9OUMn6i9bcQ5DQJ8duOP/BDG9XbgvzmD1b3?=
 =?us-ascii?Q?qe/617qHOCx2t0sD8ejCrR8d36BD3SNW3MM44hUaeWTbVMP785PXX+F3DS9S?=
 =?us-ascii?Q?KYCCevrmvRvROFvw9OFpMlEfnhj1AguwNU4ee+lJpUKaeTOSB2OTF3XldHPl?=
 =?us-ascii?Q?ZlWrBtJGJGi8/JbjX/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c988c43d-9cde-4201-f0b8-08dde08d6a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:33:33.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g259i10DCYTwa7dSOs90BecK9JXMSzZRdCLzrTewntsQldg985pW/ZUDyklkIozWFtH4KbTEAY/ILRBYzGJ7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, August 21, 2025 16:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH] drm/amdgpu: Add support for dpc to the product

Add support for dpc to the product

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a4be035fff30..d65c912d2408 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3135,7 +3135,7 @@ static inline bool smu_v13_0_6_is_link_reset_supporte=
d(struct smu_context *smu)
        struct amdgpu_device *adev =3D smu->adev;
        int var =3D (adev->pdev->device & 0xF);

-       if (var =3D=3D 0x1 || var =3D=3D 0x0)
+       if (var =3D=3D 0x0 || var =3D=3D 0x1 || var =3D=3D 0x3)
                return true;

        return false;
--
2.34.1

