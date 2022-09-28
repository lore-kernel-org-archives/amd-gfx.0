Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0B2C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 08:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D385E10E35D;
	Wed, 28 Sep 2022 08:38:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1CC10E35B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 08:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4XAoGMGzOBlKG3Yki2yPViz4jsw48UbLWXEgWyrTi/pgReD8WJJhiHNJWiemssvA0K7ATSyjlh9gxW4xdZR3IzAP9E13ZfRl1kryplLQv0Ra4EvhyarjbWsEAHJ27eMrGFmkYrLgnEbJsWgIXDmohyfpgfioDasDXDRfNHJA0KNfQg9i4qPl0UkeZ3KoebYO+w12H0rMqYVesREcvhWH4OGIP7n5fyY59RrXrvfn8Z3b0HgcT7OIa9PiPuC/ULbbmnhSQlvk+a4/1w8wSipnBpxYS6ce00EyzjPCt+2QWB+SbQIDrHLoOyHPbvGtk1Wk6cfJHRYrt9haQbyOp/K0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwcj/D4Y8pAE9aozKONUeU4TqDIau/Dm7bhqV1rjJCo=;
 b=YsloRWEmQJvrgHxsZbqG+hUrNbCQD7v2mfee4QJh35L1N0iKAmHE1kOW/FgIgkUsQ9yHhd78hXTd3jweDHuZgCTQKF8nRVqrn4TI3zrm5TrlsgDOBLZhpKlBEau5+k4fM+CYnA1RNeWl72Rm6nfvNDds+ofogFzfh+w17mLPzFuSctOVH1v0as8Rq9SK9+9XIUKHwlZf6FRqeJv1lsN7pacwXPhtGrnvzpEXO5mHhmB4M/DPYaJH1PqGNrfNjsVPQjAPuQ/v8HsYCFzDOmhPZPbyN6EPJ8aFapVLdjCXspA55bzRZv58RWg5fMAxR0vKUeij21I81WxopRQojqY0Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwcj/D4Y8pAE9aozKONUeU4TqDIau/Dm7bhqV1rjJCo=;
 b=Y/I8OQ5Ce8Xg2mdF5Cy1LCplONStyxdM9SO5mItxWOcUwvlcvbrmQezSJPzgoo+enZiG6VM+xVfHImBwySJ+yrTGagTVD9jCUATnGi8uDJHrrnjSV70IOqAFsagtMunkaS2Yrcd0TdGfTjlPfZxbM1ENjdq9/Hcu1FB/YgrKLns=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 08:38:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%6]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 08:38:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix sdma v4 init microcode error
Thread-Topic: [PATCH] drm/amdgpu: fix sdma v4 init microcode error
Thread-Index: AQHY0xAijztccy3swU+aZy8+2toSm630ejuQgAAK9xA=
Date: Wed, 28 Sep 2022 08:38:48 +0000
Message-ID: <BN9PR12MB52571B754A3214A0081FF790FC549@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220928075821.3410625-1-likun.gao@amd.com>
 <DM4PR12MB518193F098D86AE418A1C9ECEF549@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB518193F098D86AE418A1C9ECEF549@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T08:38:37Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e7b74402-0293-4f3d-9943-cb097d14a011;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB5927:EE_
x-ms-office365-filtering-correlation-id: 1a950fe8-8abe-4c80-131b-08daa12cdd12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gPu2GCN/hZ2OusyBX5a4ktzr7LmGsr/t+LwqJuWkP3xKcmlLKMc+T7FM2CZgyMtrPnqKjxuFIC8R7FIJhTKzh+KZBGsMOw5bxJOgQ/zmk7G9dL9UCRLeMHaqZ4XyHzFGh0O4Og7OCgSlbFMCmylYduCPKoxupf5i7Cxa1elg4EtHRa2BenuWvC3F0ua23SSSbiSltL42dnU1leJj2hrJl3J/M9ASR2XpJyHo+OkTnY7tjrjxRG2BgAYtudqzm/wdEik6T6Oqz5B6q9SCy9cdhtOflF8/ABuS/9Kiw+nhKRRdycYB8/8A/mdDTizTSG84+TJ18z2m7iZCrgud7FxiOdAz/iW5f8P9VU6skqPT2sYHD2e689HWO2gty64gFGehDBIJbp34LYwnL/v+qfxvYh7rg18Q2su8/N8wV0txowqsS++PzSy+gWHK4Ty2k/WFgSHJYg1TwdW3rXexwmbemlo/7LtT7GJSfYi/hzBIR5nsf7qXwfdu/Dhd4Q8+MvDTwgnL12b4VdJAFjwLdolbNbqWkndMtJoDJBAC4gp2kLqcmEjeNVzri8d+H4TXFZ5hLooJEWJOCIJ0VztDR+bLnHL9C+Y9iwSUSeBzshazMEqa9m3P7Qult0f9GzYv5bs5qfH4beAHnAe70p5nPBUYIGYD1It0+Ii26Xop/JeYWfbBoffIVh8xugb9uoHJmF8JNf4P/O2k8BR/ZA8fXDI88uZExgor3SB3ig0G4tEsewjSU0UleTNhu6asTejyEIQ+R36aO9YXsMHq+3pw4iK8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(478600001)(5660300002)(8936002)(86362001)(316002)(53546011)(6506007)(7696005)(110136005)(186003)(26005)(52536014)(55016003)(66476007)(66946007)(76116006)(66446008)(38100700002)(64756008)(66556008)(41300700001)(9686003)(2906002)(8676002)(122000001)(71200400001)(83380400001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?36vbo4+35eIJRdssyybpA5MeFoPkXn2Bzlhhkely2mcW1eSx3EqDYKs9XHef?=
 =?us-ascii?Q?2h3v7mZpm0LUGibI67Jj1G50dcRtItEwfO3rRqAbQlF3szegL386TWgxtXIq?=
 =?us-ascii?Q?vUmR+7b+1thkw7vff4YCdcewu4fn4f+fKcshRs4jWaH+jVdJNdpZwrm2tyeJ?=
 =?us-ascii?Q?kWn8Ni7zhRldCFfX2Rod7e19Aud5KQgg5Ay45fduSYUGlvGJDQjkQNeo0tEE?=
 =?us-ascii?Q?rf9k2EWGiZUEH1Ru5aZGxAvpnLXhqBArHr6JekdSvobNtNSJHHXk/3qdZ+OI?=
 =?us-ascii?Q?82tjkQ1yz5SyV1yD6M77WXg21NHPHLwpVfV4KS3zBc9ZEEMQ8tWdscgs23jJ?=
 =?us-ascii?Q?tdckGjpAT7iFIk97vIcSP8FcgENqPPgRrZBzRiLsEt7ay5NyTCbG4s83SQFd?=
 =?us-ascii?Q?iYwDrEmLiDnm8rhtif8N+AK6l2WLthShMfZZXz/kDXt1Xyj9KWVsX48O/stG?=
 =?us-ascii?Q?cTVlLXXA43Sx1rPADdD+h6yH2b6BVnizya7u4+hiJKoPWfEDXmYVEdTnFlwx?=
 =?us-ascii?Q?W1ZF5emDJ8kzAHK/3MuFG6F+1RIq/KZ9OC4syQGQFI6wCAFYnEWrYHlLZvLh?=
 =?us-ascii?Q?4+jI1bXMjwHgEoGHpaejxjL4dTo0PgNJLWzKCIOpX9sbaAEw84nAD+4oKWap?=
 =?us-ascii?Q?OhAJTYUiE+wxBeNnz36LKaeKzobYPA6V8i2uxKGIEEZtmTmtqTBidgBy6YsN?=
 =?us-ascii?Q?V1FcbrJbfvlMUPCa0pxBamAOdgeR+7PPdqhbKk1wEBkC5+yQQNw4BZ3nay4t?=
 =?us-ascii?Q?sJ2NOLRx12WOAIRc4cmvhM5A+gbeEggF5xHnN4EFddLdWC3WrSjeeMeEbQ8l?=
 =?us-ascii?Q?w+KS2MQe8COJheIR8siS036xqqQJDGIwt6P4ejZPFJ5JTdemmqNn+7QIjCyp?=
 =?us-ascii?Q?/VjXuZKQFdqzBg6Vud696bu/jvZq8nfyjH2qM2EvkRXgIrKgMq5m6FVFvl8Y?=
 =?us-ascii?Q?DkuVEpxreEYby4JcpXF9YQtI8qiVO4CUk3i1EQ0/4VcmKtL3mwmf0Cu/23qM?=
 =?us-ascii?Q?t51FZIigkcG1KBKWtiOOzfYeqqyKIujiNEOlr9teqrgzJbeRcgILrPm49yqc?=
 =?us-ascii?Q?dSHlK9biYmaweks2cX6XZCXq7lmjc44yexxZ5eT/CuyTNj1mRe3bpFl3EDKS?=
 =?us-ascii?Q?uRnZc7uPml4mTEhNjU0A4aXeL5RgG2iSg45Gi//Qy8WAl+w86M01D9aDN5O9?=
 =?us-ascii?Q?I0GwO1DWe031lIniKe9ge2ek+f6x6yJwFeczdfXYPhd3GycDtBoBtWCb/If+?=
 =?us-ascii?Q?tjlZQpW1ZSi1b/i0w8g5co8QvuBVen5ThGqYfuhkHqYhmg1TJVcFF4brd0/p?=
 =?us-ascii?Q?IQJh2P68TNeQS4oQxPGCRvRSnrck9YfeXpKuS4cTkehLbcln+ByGhwhdSy6r?=
 =?us-ascii?Q?GFrcD+Vu9/vEki9nxeLySNEpE8zrwJXPEFZnr46f+/5l/sHQ/DTJBqc2/05f?=
 =?us-ascii?Q?8spYWMcFgffkeXRm9atzZUYlTic4MYsw355JMANntDYn6L5xql8pf9qGwnWj?=
 =?us-ascii?Q?BsOauy/FOrGw1oqtjEkLDNggojkBx2q23VuoVekSL377RkCUlf3YoWLut6H0?=
 =?us-ascii?Q?h+GMdhOoA74dxzVQc0eoPgAfuxHOfDyYamGyfw7l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a950fe8-8abe-4c80-131b-08daa12cdd12
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 08:38:48.5616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifYsHM5Wvpq8Pk38MtYmQ95JW0LEEXdWejxp5mNEIdhFRW4keIOT9oLzyqidzZC95P7stiMypGy7mIt4PA+ZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>=20
Sent: Wednesday, September 28, 2022 16:01
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix sdma v4 init microcode error

[AMD Official Use Only - General]

Fix init SDMA microcode error for sdma v4, which caused by mistake when rea=
rch sdma init microcode function (coding 4.2.2 to 4.2.0).

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 631a5b5828d8..7241a9fb0121 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -621,7 +621,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i=
);
-		if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 0) ||
+		if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) ||
                     adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, =
4, 0)) {
 			/* Acturus & Aldebaran will leverage the same FW memory
 			   for every SDMA instance */
--
2.25.1
