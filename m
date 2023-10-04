Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1726EE936E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE2310E0F1;
	Wed,  4 Oct 2023 21:46:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D8810E0F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAWSP7SD55kA+iMeTNSgUcbONLEJEgd19YWlv5C/GSvAk/qZnwMWtqF/JDmdJLX0oSWcr2iP8YDg6EH1n3bdi8bpcDT9YDwJYkEU2JBFngb3kgU+4M/ZYut9pmta9QMR6iU3cJXyDh4LFxnQRuiQLPoTHeo2/5XB4VXHFCtA/uMyNMnjq+jKPGVb2PEjFKN0m+puW64//nXBaO1cJ7Lf+grkfiKx/Lzi/sk4PzOz9ymYf5myxP5A/F/jxy9SAg0KSf4qmxi5NssTqXlwHraHttGg5hgvafI7FBi1hKP9HvMc40YUNmocpTk+QO93uiT+qRUzsU+VOzp/mwVEXWncRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+2C7qDtXxgNluaVhkqgEXfHnJL2N3+1ahM9ZMWE7UE=;
 b=eu6nXhkvI6c0Wa4bbHmDOfQ7DUlS5xt2BrGZmk4EjayXijPeqK0jDQ0olHZdx1x5G8kSGx0k/l0Zsk7o4gjywfRQgf4gtIK2gffgIxSevoDC15iR8Lzr21GYFPv91aYl7mRhEAn22FqpuTWewBRSCXbq1IMCcaYMsREOSlD2y/Zhl9zs3ymNxh5hVOpPtHwJNLxcN0hrKTacBuFfV15Pimomfu0097bIhRKvB6poWBZH/RudB1XlpTai5zZGFevDcM40IwLyTXWDv+ijXJ7l4E6wgxtMmUYpNOzLvI03M/p88nTWAtlR8Qv2RKXOxe9TDTj35Q1wHYo6RSI8XwTWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+2C7qDtXxgNluaVhkqgEXfHnJL2N3+1ahM9ZMWE7UE=;
 b=gs/84yD/lkmTQ42MRlVPmSUvIesggyJguLx9fNTRXP7x5dnfyb96C6t4GU5ZmlH2mMVcr9xTT63Ov1YIg1laPri9W54RwJpFhhJvG5bLYoGdOnfKuuMl26nqRjFnGB6G1X8p7i1+LNYIS8dkB3hnw8NzoQ4qe7evCT4cpqBZSGg=
Received: from PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 21:46:04 +0000
Received: from PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3930:4a0e:f826:7228]) by PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3930:4a0e:f826:7228%3]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 21:46:03 +0000
From: "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 04/16] drm/amd/display: Move dml code under
 CONFIG_DRM_AMD_DC_FP guard
Thread-Topic: [PATCH v3 04/16] drm/amd/display: Move dml code under
 CONFIG_DRM_AMD_DC_FP guard
Thread-Index: AQHZ9wjHrswU6CScYUuoYhhWK7df97A6Kj3g
Date: Wed, 4 Oct 2023 21:46:00 +0000
Message-ID: <PH7PR12MB5831FEE80AB1A16F6DD5C96BFBCBA@PH7PR12MB5831.namprd12.prod.outlook.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
 <20231004212110.3753955-5-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231004212110.3753955-5-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fd5ee4ac-fe6c-4bba-984d-993525370c3f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-04T21:45:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_|SJ0PR12MB6901:EE_
x-ms-office365-filtering-correlation-id: 90d852fb-c05b-42fd-827f-08dbc5234cbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ycb20m6MaA5bKr6wXrX+RzGZ8XI0ziwWvA3q3y7lA4jgKFKVQRWGA0YB6E3934jm4yPhKhGd1eMsyhOJ8LzImcmph9VVa00lfTs+uusO1mSZ7FtQPMYv7QJ215ILB0kI5X10/Kg2yZdsy08ftK9Fmufiv0LpVQSb5DkXNZEUILMcZY3zSFMEyhRKzBKKocMSUTT2iVWTFdbAU+XQmG6/TD6htUmopS3NIS11CL5NCCEvCy6gs5A3aRD8LTwwFqpNb4ENfLeGt5E4n12si00EldP/6pibeWIaNaI42bVkSnaA7IR4jcT4QOaFFkZlcnVia1vBWM2+xHlXNPyQEpTG6qsuyMWY+tiJW8bAe9vR9Klm7pgP+709jxgK2cR2h45jaQiA0NuDxImz2poD4HfDEMuY+kvt0fLc9iEv0U//dvGXNcAWAyaPfHTQ29O++Imq6WAT99kMzBSPcfoZ8w9PIsKSuO36bLQsdgWQ6n/GP7pADY11mHLZbPh9vJ46xentYUSttPb30fInEwMJCCcx0hp9UsOil4EYX/n0+ysZsq2D4iB2LO5g4fc4Glmildu+ZwyZt30spWNm1p8OqILqVDDT4psN1rLY+o/FaCdtIAc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5831.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(7696005)(53546011)(478600001)(71200400001)(83380400001)(9686003)(26005)(66556008)(2906002)(76116006)(5660300002)(41300700001)(66946007)(66446008)(316002)(4326008)(64756008)(110136005)(54906003)(66476007)(8936002)(8676002)(52536014)(33656002)(38070700005)(122000001)(86362001)(38100700002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vnxiwYHo6vgjjyJJAsnS1SGGLD1VXk3sZTEj+q1rtJNbW8MSDcJ7B5B+Qed3?=
 =?us-ascii?Q?8E9xKdh9gkB7fy0oRH/zhJJOLCngmYLrvX0O4ehZxjHs2FU9QZTpFe23jXuF?=
 =?us-ascii?Q?LtuO5abRN57zV6j665pWisUzEYzudBu4wUOIH+KT1S8c0SqBF9cOf7xIq9Qi?=
 =?us-ascii?Q?BMtrO96M7rtccgvtDGgn88kbFxQ5Qe5BRFqEZJZUEEiwF/2MFHU/BUnHnurX?=
 =?us-ascii?Q?s7nQKLb0VtUhd7kqIbKHoP/EfvLl59Q6DNUrlNh3Pd8iRwugKKF0eSLr6+TL?=
 =?us-ascii?Q?bzBq3a0PvUsh/D5kHrUDjerpe77uvh4U7CmG2n8lyecXBdege2KtCvFo1H/F?=
 =?us-ascii?Q?AkPmVJAVyltWeJGgQzj1DL24RuLYN/3EZGEYM5HShlaNh4u9/inAUVnst7WR?=
 =?us-ascii?Q?XBLwQEh5Q6S0EZ8dDOc2XJ+u8WlcuDe+SrWKnL+soOFwi7OV0mQmQWmhmOqn?=
 =?us-ascii?Q?pjSEYdshsae91/p6N0OCqYkOGHwoO2WnjKtWo65rBMsaEtot+HsVYLeEQ1sJ?=
 =?us-ascii?Q?YF+QBMxrIK1IZ6+PGS7tFTVdMpi2wpXCkXhSx2g5pbj3XX4LKsOqd2uyKoso?=
 =?us-ascii?Q?em051oClFY1aEbNk+Kgt4h/qar1y+hNRN4pHdbtc2GQacP9L8hAQHdNppdmQ?=
 =?us-ascii?Q?XrAuY6Pruj8+YL3zM5mN9pyLa9GCWzITPJRcXBdvrrydN0xHSbGKFXelr79K?=
 =?us-ascii?Q?mOS2z3WlPNXXHTJbaBCiOztRXaxuUJiEypIjrnQBWtpFQfWd84iqbf/jW42W?=
 =?us-ascii?Q?mEDUQM7qZhfaN+YSH7JnKLLwhnZMVX8x5AWvJ/PJ+ndQYXiSV31kFbaT3Be/?=
 =?us-ascii?Q?wo9ZGnBBMgGzYizfXnhKLrtSxNhimM+iza1d6qhvQgzc4teaERcngrrYMI/U?=
 =?us-ascii?Q?iReMIoHqvr34YdFGSha5nz8JCuV8Wwdb7HVAyOtQLAUdHS5PVucUONa9DNzn?=
 =?us-ascii?Q?Yh6V770pwOLdxUCGGqhVJ35NcOhfH2GAP0g2OFviFjAUuzglJH5cMp7gLVvS?=
 =?us-ascii?Q?Yj5VJovaAJ1/0HJx93N8UHm2RvA7gKIpsG4b6kr3eT03XSinKrXRKuNLRNA8?=
 =?us-ascii?Q?qO9zVuxj7dsr+DmPwUDxiRAkhdeffdTA/0zPkV/Zq0Xl7/TTCJrn1DnYW6vP?=
 =?us-ascii?Q?GHE6T7ShitwBh6IsecWHNDdVSleboPQfAsUNdlMjVIdFHXvCiZCnjHilaSYz?=
 =?us-ascii?Q?NMtsoNOoVo8D5Rw6UF7i/kGwn3oVsZ7lcy8MW+VERfRwQG7+OQmKwhFt1ig9?=
 =?us-ascii?Q?KtSLpZnxekth0Z9ORk6kQngK3YuLcR+vVrYnGLHub29CSSkfcZWKfpyQ8cTx?=
 =?us-ascii?Q?t1/esHsAbLBCKittK15ED1Zt36n7zOuWfs3Lm0hLvETEYyBnYWs82W50HZ8C?=
 =?us-ascii?Q?wPh2V+nERmV6cTY8hdMv2VW0lgW0L6o3deAPiu5SMqKKG1emFhZeiPPQmoq/?=
 =?us-ascii?Q?QjfW+7cwvZ+R0L9zFTvtCHqHkwTIaF1Kvw8zjU8gA2aDFjNy44/9HXPPp2KL?=
 =?us-ascii?Q?byb7t2o0OZbICYUM8HJZPSdf04OO9A428c/35dE9WUp1C9QBKVkl6Mw1zPH/?=
 =?us-ascii?Q?cqx13CJ9R75l/o7fOYQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d852fb-c05b-42fd-827f-08dbc5234cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:46:00.4825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jlgo/PQ0FMUVH7IWHkPuFk/onKxg4DNE7NJci0tsuLCenfgGm4ODCbwSQW+O3rP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Gong,
 Richard" <Richard.Gong@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, October 4, 2023 5:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Lillian <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin,=
 Wayne <Wayne.Lin@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mahfooz, Hamza =
<Hamza.Mahfooz@amd.com>; Gong, Richard <Richard.Gong@amd.com>
Subject: [PATCH v3 04/16] drm/amd/display: Move dml code under CONFIG_DRM_A=
MD_DC_FP guard

For some reason, the dml code is not guarded under CONFIG_DRM_AMD_DC_FP in =
the Makefile. This commit moves the dml code under the DC_FP guard.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/=
display/dc/Makefile
index 2f3d9602b7a0..dafa34bc2782 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.

-DC_LIBS =3D basics bios dml clk_mgr dce gpio irq link virtual dsc
+DC_LIBS =3D basics bios clk_mgr dce gpio irq link virtual dsc

 ifdef CONFIG_DRM_AMD_DC_FP

@@ -43,6 +43,7 @@ DC_LIBS +=3D dcn316
 DC_LIBS +=3D dcn32
 DC_LIBS +=3D dcn321
 DC_LIBS +=3D dcn35
+DC_LIBS +=3D dml
 endif

 DC_LIBS +=3D dce120
--
2.40.1

