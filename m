Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB28C43217
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 02:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4853410E787;
	Fri,  4 Nov 2022 02:23:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D1110E787
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 02:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIL/ib8xwN2zx5BiN3a551LFzY9xKojzoXH89Ag0Jh8fPPugFD3yEe/nHu3mX3Prf1XGlVI6YZeoCFIHjMwwSkHDDYgu4iyeY89HPIM6hx4K8/Q2+3d3JA4welIVmUQLf8+A8LsQzYzmzHbbow8Cs9Mj1PkLjte2HbooaIkbQjHoOIrNNslbUx3yW59uDiHFWViPATsDBw5DFAtGsRvPGhLAN202PoRvRWrblRa0jx1yNnK5HUpA3L7L4fOl2t78o/jJ6xbM7SjYW/7gOxbfzwGrQq3dBakNe1hf7+bbB8EVgQ8ikibU9Uhiv+P0o0sNjXKq4Z7v1rI3tG+ZkNFwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTfzorfkSQgrjfRVAuQv3IopihOM8lrPV36pwG7/VXM=;
 b=Zf9Xq4OBjDyDYxy9KMGdQFLSX0elRwsQ9ZFiAA8IdSfByMl4WiiO2HHXCtqwPovRIkRQFHXqH+RIETCy4BmWmdKYn54LJ1MjNUtifAPxU428vERFiob14bycvc/0Juo/mUwiTB16cTc1lRt5eXpx504Ihv6VZ/DxgOpi7o0/jgscwjHLO8iDL03eQLBEYnULn4BImvfZIlII1E6Mo9SIFMLjxzS5X3qD3voweDJ6/cMeKoQABlaDNJLMf3fPWGG3jloYHLI119o29QfHHa1TO+4n9BjpoEESC4rNYMO0R/XnMitXpJcPPW5Tg7uFi7kqBMkPQFnMMEN4n75LTVeSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTfzorfkSQgrjfRVAuQv3IopihOM8lrPV36pwG7/VXM=;
 b=ap8M1oD0orMTYK5F8276k4TLDiindrIQGTpIUVJ4JcarkqZ4n9sfiOCZMO4atWBruRQvD37swkC3BuujZXdCzGx5Il2nCbOjxoYlMeOnje2rSAui4QcFuhSNLf8O0qDq0LbkfcP6VPs163KKnYanAEMLvXvyMEOQdLrJUP1NhFs=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 02:23:07 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::863a:8b00:6eae:5276%3]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:23:07 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update SMU IP v13.0.4 msg interface header
Thread-Topic: [PATCH] drm/amd/pm: update SMU IP v13.0.4 msg interface header
Thread-Index: AQHY72FeZmXytvySCEmDIjpomfEGG64uCb8g
Date: Fri, 4 Nov 2022 02:23:07 +0000
Message-ID: <CY5PR12MB6369EADD929D4E3103499522C13B9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20221103085013.527767-1-tim.huang@amd.com>
In-Reply-To: <20221103085013.527767-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-04T02:22:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b6987201-d6ce-4ebe-ad45-77285303d9a4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-04T02:23:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 78ec3ada-c339-456f-9b6e-a06c0ef520c8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|IA1PR12MB6386:EE_
x-ms-office365-filtering-correlation-id: 51ed1f80-ca0b-40b5-e6d0-08dabe0b82ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3hCtImfcipyB7MMcKtQgN/54dZxsjRZ6ZLPiNQmw9ySESrUhUjXnj3M8t9gDdoI/k9b4s99J+vre2Khvotxq+O74zluBomohjowodRznbRopcFjCUTWgmOqQ27hXskFja9hb77gII0I3RVO++2vMOcRQXw/AwNOoWCVo85NDHAfpmoZ/4A4hoTtc6dSxmzfwGI1TxIGNRbiKzrRLzoS8lTHUio1MLwm6KwiVOLhvL6NAxUMliK0AOJt40ugqgpHOWHJYy+SbF9UCMXSsfTKLuicL7wAGGrX4x8doMnvy4LDLnl5DjZmJ7qTYmpPK6IWbc1J8cKqRVctP6aNu7Xguy28pmX7YjPUndPto/3BFfkqcz+zZ1GYlswPyCNejGy9fHUO8g30G8bH3oNlX72IkkI83UtVrmag0YhFwZxgkRxOOn5Q7l52GGwAUJu0SoFcFmsK/SWiDLdSLTJ6I1ERsCGtjHsC9Ho21Yx1eqnlk8ThITok13u/NIZ+DZuH9Q8QyGW4w/KzYOXX7uVEzoDgTbl40B4B7LKO2SlxNn3VainrZ7aZRn0l4tnvM7odBEFoBx19Ham965XLCHfGR+YK8H4INwoC2rGAFrJ+PnNfAVuPNXqS/dMEhUGLazWaB6xfJFPfnHdRmUpdGRrJGzd+y4qg+iQ9zau4O6lIjNFLNEhltQvQ7Ru/JAw6vd5a63Ee7wh8Y1n4XshLjBJ9uPGaKNdXwVwxJxlOnbF6k0FAY5zikN/Vg64FfPKsUfAqIme+OJX6t3ixcgWS4Pvln6rsyVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(86362001)(38070700005)(33656002)(55016003)(41300700001)(9686003)(66446008)(66946007)(8676002)(64756008)(66476007)(76116006)(66556008)(26005)(4326008)(186003)(8936002)(52536014)(5660300002)(53546011)(478600001)(71200400001)(7696005)(54906003)(6506007)(316002)(110136005)(15650500001)(19627235002)(122000001)(38100700002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G/ubRgE0nRkisFmBsXV5/mNiibLHuA1IEf1XGMOixMo8fOSwzVQwqzEwuj0V?=
 =?us-ascii?Q?mLnLy1maCp1BggjAMp4gcG7aHa5OBc8BKZhxvxRBVVRTBtjZXrdbXzXDJL52?=
 =?us-ascii?Q?13IPqYhsCNO2wr2MtON/gENE4Nb/7PwR7fpc03sTZUWlK5Ryg4aFdAfU7ktW?=
 =?us-ascii?Q?D59hloJp5THEIOSCEcQncELbHfqJFBUauBeNUC3vcOKkncxXU8WqP9bESYiw?=
 =?us-ascii?Q?IP84yRMjKw2+YuIoNfNTx3CC4P6j/vrjXT/psNAlCPfbFFSL9YL76lEts6S1?=
 =?us-ascii?Q?tFwzslgJag45J4bUqhUIec7FO42APwyvNRRyxi4QlA5YOm2hR3L+DbpO7PlD?=
 =?us-ascii?Q?cHNmOa92trQc8L6DeL7EGwdlsg4GqSIo/egLQiZukMk+EBQSrv4wMtjCQ8vq?=
 =?us-ascii?Q?YxxxT+GrEDNo4fVR9ykHzwdC21k0i54gr8WbHSPmltRNxjS1iXPeEfiUKtWB?=
 =?us-ascii?Q?eCfDYsbkDFcgtMUbf+W3UM4PdO2aNnxPxr4XDMkLFUrbtz+b2rU1NzXGZ+eK?=
 =?us-ascii?Q?TlJuEptw+AQga9Mmz9lrtTgzFUmdPCBPzICyX2lmo6HyeYfss7nTMCqRlxGK?=
 =?us-ascii?Q?aT/4CJadoJeOeXCl4/uSOuahERLsGhGe9eay8xBDrRweRZwXpuy2iqtQekhW?=
 =?us-ascii?Q?fH7WEb/5dcMeZc8zko5DDYK5p5gI4WWd8zLADWUVtwjz6q/y3a7Kkx9gbLYK?=
 =?us-ascii?Q?gCP4xwsgkRJNOVBZqt5an6aY1dr3ByCrgL6NucXXEuYcJueIPuhTjo/tr0vY?=
 =?us-ascii?Q?+ph096yw2Ul7whpsBVXYBCBRNozbrMomwTSkA3v1ErIhvGTroQnsov49gMFU?=
 =?us-ascii?Q?bjlSBKs02NVMpXRpWmoIrKp7WqKxXt6FpyqJTkTfjmVUPfkod1DXonb/e+rh?=
 =?us-ascii?Q?qRqPbpwLHLQwBe+z/Xo5IxpJm82ojHd5cp+diIJ8bn/AmDeaULjOz1pFH87M?=
 =?us-ascii?Q?5oNqdva+aZa80XiU7/5griP5KPgv9ztlN922RmoKGQyaJf0bEaMwXghKmKdr?=
 =?us-ascii?Q?IR5weHDAt04HX0rWPOcrs+LygmZA/Nu+vyWFNGrFlO30UL2WIusSSx2FMIaO?=
 =?us-ascii?Q?E773x5W6Y60vg5Ooxsqa8EeNQ+I4ItT6Ro9wu+ttHvzsJVyERpvHqQdDKTez?=
 =?us-ascii?Q?KIGPySG47AJyleO0y6Riw+w4IZUxD/fURfIY/BmgiuCVfCf/yuF1yymCH6gz?=
 =?us-ascii?Q?/xEmiPMlN6PwQ5EtfYypJZO+/wUKU+VxsDjc/mVy6qOKRInHlQqUS/ZmON/k?=
 =?us-ascii?Q?SB0N4oopbDx0722ygY0aFArSdiG5IYAfEwrZ6oWkCCyoFf1QDAEWNDypYCKZ?=
 =?us-ascii?Q?cZqP9V/WW3VYYeXCeR8JKRyCncAdzoxa7cDWSVX96zEuPejX9v+Eut1TKkgY?=
 =?us-ascii?Q?hrFx9mz2ORJPYOiotNEiRYqTCZTRDukw/PRTVFmmetunEuN0ZXWPBcyuHkJ2?=
 =?us-ascii?Q?5r+hIeXcUPFvvf2sO6W9fXC1pqSZayF7brzoeuVdsdphSTtqlwGx0K27NzOR?=
 =?us-ascii?Q?Q/ca1hweMkfc/vfphMI5ruotJ0zk07xZpzCYt5j5GIOz0jEw+WP2rFXFmFO5?=
 =?us-ascii?Q?0UAmZjAvsSDWrjZ+1no=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ed1f80-ca0b-40b5-e6d0-08dabe0b82ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:23:07.4393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWK9Otrtpt1uRmFZ+Ap7tFG3ptAlA2PUBvVaPUqRqq6W6dC8PNZ/aSRZVVUC44OJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Thursday, November 3, 2022 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd=
.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd/pm: update SMU IP v13.0.4 msg interface header

Some of the unused messages that were used earlier in development have been=
 freed up as spare messages, no intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h  | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
index d9b0cd752200..f4d6c07b56ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_4_ppsmc.h
@@ -54,14 +54,14 @@
 #define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW=
 is alive and responding. Requirement specified by PMFW team
 #define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
 #define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_=
IF version
-#define PPSMC_MSG_EnableGfxOff                  0x04 ///< Enable GFXOFF
-#define PPSMC_MSG_DisableGfxOff                 0x05 ///< Disable GFXOFF
+#define PPSMC_MSG_SPARE0                        0x04 ///< SPARE
+#define PPSMC_MSG_SPARE1                        0x05 ///< SPARE
 #define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
 #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VC=
N is power gated by default
 #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless dis=
play
 #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for =
GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Needs update
-#define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down=
 GFX, i.e. enter GFXOFF
+#define PPSMC_MSG_SPARE2                        0x0A ///< SPARE
+#define PPSMC_MSG_SPARE3                        0x0B ///< SPARE
 #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for=
 GFX driver unload
 #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits=
 of DRAM address for Driver table transfer
 #define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits =
of DRAM address for Driver table transfer
@@ -73,8 +73,7 @@
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for=
 FCLK
 #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for=
 VCN clocks (VCLK and DCLK)
=20
-
-#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Needs update
+#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
=20
 #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock fr=
equency
 #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequen=
cy
@@ -102,8 +101,8 @@
 #define PPSMC_MSG_SetHardMinIspxclkByFreq       0x2C ///< Set HardMin by f=
requency for ISPXCLK
 #define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN.U=
MSCH (aka VSCH) scheduler
 #define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN.UMS=
CH (aka VSCH) scheduler
-#define PPSMC_Message_IspStutterOn_MmhubPgDis   0x2F ///< ISP StutterOn mm=
Hub PgDis
-#define PPSMC_Message_IspStutterOff_MmhubPgEn   0x30 ///< ISP StufferOff m=
mHub PgEn
+#define PPSMC_MSG_IspStutterOn_MmhubPgDis       0x2F ///< ISP StutterOn mm=
Hub PgDis
+#define PPSMC_MSG_IspStutterOff_MmhubPgEn       0x30 ///< ISP StufferOff m=
mHub PgEn
=20
 #define PPSMC_Message_Count                     0x31 ///< Total number of =
PPSMC messages
 /** @}*/
--
2.25.1
