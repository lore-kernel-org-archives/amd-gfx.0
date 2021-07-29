Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2034C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 15:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811C8601FC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 15:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 811C8601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A96E6EDE0;
	Thu, 29 Jul 2021 15:51:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71056EDE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 15:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YldYq0sDh1ufldWQpKrpScNSsXqVahGmgNFlXmSwGV0ioXMuPdniqBTRzCuFglFmXQsO9tfgIl1r8VsUG+VKL2wC/pX0ioGuA7iRUH+ic9a1qpmrpfX0Wn/M24511NP73v1bCTIoWN8R5arRfcQrTst7oPmhbOX/LRU9bylVgK9jvty85KQUTuduedGV3R6xMzFQSCkY1hc970bS5VhiIobB/acNOp1j/fE9T9iUxhKPvsTZtRc2BL5zoP1ztByiF3tx7lBSDUDfSdLfzjO3buztXD/+UdoB+LBp0UegCc+KKtPSijAz+JOpH9VIS3wklZ76qHcSfPe+kfQ2nDJHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L9gikxFGYrTx5cyvU4r+wWswOePpVVqexD2RAUTgi8=;
 b=mfubnJojyGEKep3bPZ9m/rl4k65y1DKyQp5S7Afah3Pvcj7+jFo4iCSlTs7xIBdl8sb+etCc4DcUZawtprefTSiwJzSO6qfNgUDoaQVhVQa3KqlnSrWx2AUz4U7mIlEfSWhIaMu1/30S5wF2v67pqaiXc6WqKm2CfGXfnCYHvcB1EOZCOMBu+DqxrLbaeVmHL3IZR5Xhul5IX9XUqalal/Tk0PhEVds9HwZ5jWz/Avei6P4fnQtFl0UFzhrNQrAbUmFmgXzjuolA4ylcA7IRUPiukv23K4CmH6moakgRjwNi4G2nAHnp7bvH4ApdEJQNe7Q1Pw1D59EcF2jLkXKSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6L9gikxFGYrTx5cyvU4r+wWswOePpVVqexD2RAUTgi8=;
 b=c+olxwXYh8MtM15KaO5AZaQRpXxd7x9pzyEHfguYiiSLn+M29JXy3CoMW1zbMk5Wd0WnnaQvi/9oo4df3P3/V1ktketGL36QPcRPoMogqU5h7CAIZVoTkB5c9CC1nDaTco6irTALn1d0sNkwWAUIhYoKY+NXWI0/3sqH0r6RYak=
Received: from BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 15:50:57 +0000
Received: from BL1PR12MB5224.namprd12.prod.outlook.com
 ([fe80::520:88a0:83ef:8a41]) by BL1PR12MB5224.namprd12.prod.outlook.com
 ([fe80::520:88a0:83ef:8a41%9]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 15:50:57 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran
Thread-Index: AQHXhI/F/kZ1sfv6KkmOhmGfS9P7aataGcbx
Date: Thu, 29 Jul 2021 15:50:57 +0000
Message-ID: <BL1PR12MB52247728007EA5D768476491FBEB9@BL1PR12MB5224.namprd12.prod.outlook.com>
References: <20210729153758.13662-1-mukul.joshi@amd.com>
In-Reply-To: <20210729153758.13662-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-29T15:50:55.154Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b733a44-bacc-45bb-cc99-08d952a8a7d7
x-ms-traffictypediagnostic: BL1PR12MB5319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB531972AA7196ECAABFE1213AFBEB9@BL1PR12MB5319.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3y2OHplbgxgKErj6X2ctLXzNrdI2GLNKw/BVhPyKDMJBI35uZ+2dPvNY9O/kP59DJLRGFxnbKIGUUyUgw1Fh5UCAbkBnTLsHWozt/5Q53ESE3ZWIN9WWBBiFJtf1Fq232TqZ0nMSOTgYmZjcG9vLzLEycxxv2Zl68rQtWdp30Up4u7FTJIYCmhJ0KUOb2jXIcCeMeO2xy7fWB4HVEWRoW8jZxVeIIi6Lc1BNMKZF++NsRTF/2abXpNXpgq8dfYWZL0n+OqJVk9fMecI5x9zOR40Wqv/JYNxNl4g5XwDxlI5VlBruErB4MLGL5T2HNBDy4ChYefuQqZuBPwCWYGc525GXjkn98AdA6OBJrO3dfYiYHMz/f9+tl+YtetVa0fnLiNsMccPVl2SbpjE44ddiYh31tFYA8iNYi4pYBt3+UDsqGWPMqfaPxjjwv2PaHZ0L75hGN1+tBgnqdmlMwZymbNLI8GnkI1FT8kz5/+Q1givvqfJnYkxCKRZRQQZ9uuHkianDUw6sZ/rN1DvoEku5Q6wy8qSPAxs6FZA1vmlRBVTYFtY9dAcsjSetJuQpBlRIFWZtaabX/I5WOwuGiNDZ+kQeQEoVVJnHgCNxhO6rzra6GAVpW8WN0W3pNXPeu+rciywyE7ta9dEBsUuBPuFdNDA8OzzakZD15O9RPMQ4lzuK/DgZZkmvy2nsFQRphRcIL0rSKyT7tAnTMJKuGTZEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5224.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(8936002)(9686003)(122000001)(110136005)(53546011)(6506007)(316002)(38070700005)(52536014)(7696005)(8676002)(4326008)(33656002)(186003)(91956017)(86362001)(76116006)(66556008)(71200400001)(66476007)(64756008)(66946007)(2906002)(19627405001)(5660300002)(38100700002)(66446008)(478600001)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xU2AIrN52zJzYR8yovMOHgTcg9FfHB6dObbIPLsXUVy1/GH3sPaC/NKbSS?=
 =?iso-8859-1?Q?rC4hpvEqvje6ZW3HOBVP8qHgVmNzuH5TjEKcoz66vMoQSXhaoq3LM2jgLr?=
 =?iso-8859-1?Q?HA/OcQXYcNCY0jLlXvBd+5sDq9/lHLjo34C0WJEVCTEpHUTtPRyJgwKdvG?=
 =?iso-8859-1?Q?OIl86M8u+1+qhtY3DJYTPuWxzTzSuyajj3psHEwu84tMz1n4EFR0FhGw66?=
 =?iso-8859-1?Q?IO4z83a4SDMDXTuJo+aK/6miTsy2KQ/Akyz0pPAVqtehsIn6aJj8RY/rU9?=
 =?iso-8859-1?Q?bNV+G/dB6OCGX/ceyTgxVgN09pBnKq+dspdATpZzIGdts1BqmKipNOGAtH?=
 =?iso-8859-1?Q?V8nlhJTSgUVRyZHhwhXkO8MmUom3IH4qhXNipDoozJC6QGuLWUhwyXBbw0?=
 =?iso-8859-1?Q?DgfF+xYomPp6cIrapRomsa6vjUUIzAahzlRuIcjTuuKn7Ka36B7k8DSQh7?=
 =?iso-8859-1?Q?z8oeCwf+Lc40CjCJBu9V9QIu6Q7+P0Si89qS1ipYmXN4EiexOStVc/WFFz?=
 =?iso-8859-1?Q?/QKA2qsbU/dM+Zs/UYBWIDTbL8USyBnYgfAlrT4V2r3Scd1cVo7nF4NyIO?=
 =?iso-8859-1?Q?dOClrH6eTgNE3cCSwRZgIt1BHW4ImqY+SZcQr+5uvADm7qutctvGNKjlRC?=
 =?iso-8859-1?Q?8Bn3ceTS011SV+8QSPRE1XkbGFpumsNSE/6IH1QO9n9M89I8SR4NErJ93G?=
 =?iso-8859-1?Q?e8H1kJWrIjZmHmtNYZa1uYhlZHDu67jGR7we3bBU09Yq2upH8RlnwbHXNy?=
 =?iso-8859-1?Q?VLrH+7mQ8MAxvedxAoAyQMI75fzHiZDwcwDis31dk99spkD1mG04I99HI2?=
 =?iso-8859-1?Q?RGuKHPVXFWzOuvz3qvHh07WHE83hWmZAp35vvofUSYVlTUITq7R0RL8R+i?=
 =?iso-8859-1?Q?UAzjBOyChDSqhc3kckXL98FLnDuaJwHCs6lzGlI3ntTi/Y9sj1jaLM7/RA?=
 =?iso-8859-1?Q?2dreWmmPh5UCsy0B+lIprXM/46GccKENGQDbnLNg9nNyA3piahNElEQytl?=
 =?iso-8859-1?Q?jrPCOqRhsjKY9K9D0c7uVqRqja37t2vMDqeUlpSWD0UrJoR/HYuG+bC+Jj?=
 =?iso-8859-1?Q?y09GIkzgST6xfUsNO/CdyWQhucupmCvPngBhcP14jw74aw5LrSAb513W/z?=
 =?iso-8859-1?Q?nBAa2UUni9e/LaUxwtGzRsScp0agsde2oJPjQ+VobPFQIBFUWpVOte/dmw?=
 =?iso-8859-1?Q?SPZ3y9IptuUDeelMH7oJ1Sax2tkPicYAWlJyZ4ft7Wb0CzMZckqNMYHZ0u?=
 =?iso-8859-1?Q?7Mi34Dqtn/+R4cNUwz8uK7B+UHyJiNwdL2P6bwyEyQ58OxJpK7gG8H6xZW?=
 =?iso-8859-1?Q?JwpRhgmVs4ploh8PP6a5xv5B1v+jBlNh99C8SdUdaVNkxzcWs4H7Qx4m6j?=
 =?iso-8859-1?Q?Gf7wmUXJkg6EqD5oRb7HFWiNOj/bQMJYwV6WEB2UMAvvaMRN9Ba3rwb2jM?=
 =?iso-8859-1?Q?cr6F/oWM5JKdB85q?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5224.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b733a44-bacc-45bb-cc99-08d952a8a7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 15:50:57.3168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xl0ussgBzTwcjM/XWeRSrBSeycHTBwisopWeTvdYUnZrMpXSSPyf4LC9NP1usOl/OmnWC0jhPgBP+9NjF71pwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0884656507=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0884656507==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB52247728007EA5D768476491FBEB9BL1PR12MB5224namp_"

--_000_BL1PR12MB52247728007EA5D768476491FBEB9BL1PR12MB5224namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-By: John Clements <john.clements@amd.com>

________________________________
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Thursday, July 29, 2021 11:37 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran

Fix the channel_index table layout to fetch the correct
channel_index when calculating physical address from
normalized address during page retirement.
Also, fix the number of UMC instances and number of channels
within each UMC instance for Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 7cf653f9e9a7..097230b5e946 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1171,8 +1171,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
                 break;
         case CHIP_ALDEBARAN:
                 adev->umc.max_ras_err_cnt_per_query =3D UMC_V6_7_TOTAL_CHA=
NNEL_NUM;
-               adev->umc.channel_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;
-               adev->umc.umc_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NUM;
+               adev->umc.channel_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NU=
M;
+               adev->umc.umc_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;
                 adev->umc.channel_offs =3D UMC_V6_7_PER_CHANNEL_OFFSET;
                 if (!adev->gmc.xgmi.connected_to_cpu)
                         adev->umc.ras_funcs =3D &umc_v6_7_ras_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 7da12110425c..bb30336b1e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -30,17 +30,17 @@

 const uint32_t
         umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_=
7_CHANNEL_INSTANCE_NUM] =3D {
-               {28, 12, 6, 22},        {19, 3, 9, 25},
-               {20, 4, 30, 14},        {11, 27, 1, 17},
-               {24, 8, 2, 18},         {15, 31, 5, 21},
-               {16, 0, 26, 10},        {7, 23, 29, 13}
+               {28, 20, 24, 16, 12, 4, 8, 0},
+               {6, 30, 2, 26, 22, 14, 18, 10},
+               {19, 11, 15, 7, 3, 27, 31, 23},
+               {9, 1, 5, 29, 25, 17, 21, 13}
 };
 const uint32_t
         umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7=
_CHANNEL_INSTANCE_NUM] =3D {
-               {19, 3, 9, 25},         {28, 12, 6, 22},
-               {11, 27, 1, 17},        {20, 4, 30, 14},
-               {15, 31, 5, 21},        {24, 8, 2, 18},
-               {7, 23, 29, 13},        {16, 0, 26, 10}
+               {19, 11, 15, 7, 3, 27, 31, 23},
+               {9, 1, 5, 29, 25, 17, 21, 13},
+               {28, 20, 24, 16, 12, 4, 8, 0},
+               {6, 30, 2, 26, 22, 14, 18, 10},
 };

 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.h
index 81b8f1844091..57f2557e7aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -36,9 +36,9 @@
 #define UMC_V6_7_INST_DIST      0x40000

 /* number of umc channel instance with memory map register access */
-#define UMC_V6_7_CHANNEL_INSTANCE_NUM          4
+#define UMC_V6_7_UMC_INSTANCE_NUM              4
 /* number of umc instance with memory map register access */
-#define UMC_V6_7_UMC_INSTANCE_NUM              8
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM          8
 /* total channel instances in one umc block */
 #define UMC_V6_7_TOTAL_CHANNEL_NUM      (UMC_V6_7_CHANNEL_INSTANCE_NUM * U=
MC_V6_7_UMC_INSTANCE_NUM)
 /* UMC regiser per channel offset */
--
2.17.1


--_000_BL1PR12MB52247728007EA5D768476491FBEB9BL1PR12MB5224namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Reviewed-By: John Clements &lt;john.clements@amd.com&gt;<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Joshi, Mukul &lt;Mu=
kul.Joshi@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 29, 2021 11:37 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Zhang, Hawking &lt=
;Hawking.Zhang@amd.com&gt;; Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix channel_index table layout for Alde=
baran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Fix the channel_index table layout to fetch the co=
rrect<br>
channel_index when calculating physical address from<br>
normalized address during page retirement.<br>
Also, fix the number of UMC instances and number of channels<br>
within each UMC instance for Aldebaran.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |&nbsp; 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 16 ++++++++--------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |&nbsp; 4 ++--<br>
&nbsp;3 files changed, 12 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 7cf653f9e9a7..097230b5e946 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -1171,8 +1171,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.max_ras_err_cnt_per_query =3D UMC_V6_7_T=
OTAL_CHANNEL_NUM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;umc.channel_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;umc.umc_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NUM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;umc.channel_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NUM;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;umc.umc_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_offs =3D UMC_V6_7_PER_CHANNEL_OF=
FSET;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;umc.ras_funcs =3D &amp;umc_v6_7_ras_funcs;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c<br>
index 7da12110425c..bb30336b1e8d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
@@ -30,17 +30,17 @@<br>
&nbsp;<br>
&nbsp;const uint32_t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_channel_idx_tbl_s=
econd[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {28, 12, 6, 22},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {19, =
3, 9, 25},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {20, 4, 30, 14},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {11, =
27, 1, 17},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {24, 8, 2, 18},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{15, 31, 5, 21},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {16, 0, 26, 10},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {7, 2=
3, 29, 13}<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {28, 20, 24, 16, 12, 4, 8, 0},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {6, 30, 2, 26, 22, 14, 18, 10},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {19, 11, 15, 7, 3, 27, 31, 23},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {9, 1, 5, 29, 25, 17, 21, 13}<br>
&nbsp;};<br>
&nbsp;const uint32_t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_7_channel_idx_tbl_f=
irst[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {19, 3, 9, 25},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{28, 12, 6, 22},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {11, 27, 1, 17},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {20, =
4, 30, 14},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {15, 31, 5, 21},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {24, =
8, 2, 18},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {7, 23, 29, 13},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {16, =
0, 26, 10}<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {19, 11, 15, 7, 3, 27, 31, 23},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {9, 1, 5, 29, 25, 17, 21, 13},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {28, 20, 24, 16, 12, 4, 8, 0},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {6, 30, 2, 26, 22, 14, 18, 10},<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *=
adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.h<br>
index 81b8f1844091..57f2557e7aca 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h<br>
@@ -36,9 +36,9 @@<br>
&nbsp;#define UMC_V6_7_INST_DIST&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40000<br>
&nbsp;<br>
&nbsp;/* number of umc channel instance with memory map register access */<=
br>
-#define UMC_V6_7_CHANNEL_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 4<br>
+#define UMC_V6_7_UMC_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;/* number of umc instance with memory map register access */<br>
-#define UMC_V6_7_UMC_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 8<br>
&nbsp;/* total channel instances in one umc block */<br>
&nbsp;#define UMC_V6_7_TOTAL_CHANNEL_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (UMC=
_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)<br>
&nbsp;/* UMC regiser per channel offset */<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB52247728007EA5D768476491FBEB9BL1PR12MB5224namp_--

--===============0884656507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0884656507==--
