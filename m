Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D47C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 15:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0995A60E97
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 15:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0995A60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD6189F06;
	Mon, 16 Aug 2021 15:13:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1865889F06
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 15:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZIEkJ3X6lTXCLpOaD8YEGt2GET2g0cSSzbuZxYqiDl0aA0m7xTUgvGtF3CGMwwxaeptz1KN7oCjjJKFWBFsVq3b4gTCQJOepGBT5eZBxWF9M+HADhkjBxRH4LiJVPXpo1DATSwcYhfAU7SsGoQhk7u8ZSOzTW3oavij5SmCDMW10BR+8eV+MEUDW3mNnHiHZZjFdegzXX3qOJSC08TaYolclUYz3b6E/JnYU9D8zfr2UmSuQx/e7MUZjYYY3rAtPdCf/uOdn6w0dJXL0ioikWxZdDBBB6zimGbPk80eQdre0qZuteZ5lgcWloCpn/X1O1xl4vyj6Iz5jJzHB9L+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4i6wPhVS/9Up7JSO9PsfvvcFDxBXIcbqsojLZuDsis=;
 b=GI7pj7rxkLAyzelqzomLxyd5C+EPASn7PSkcrZTmvwuzwPHnvIA1kMjlpkrs4Y908hd/ZSV0wFxHRCn0+Tx1XhdPXY6mw53ppYT2Vjn7Avrs/cUlJoYbEB509H0kW+wCbb3ywDPAMSXf/YGXjgdywWwc057O7jZw8oyKmUHEd2TByW/wb1g200sR0Sh1YaRNszn0yQk2HOppa8s2dVVBBd/Tz+aUPZxG+a/KRp/ztt5xEhQkej2yis7CIedYmxJqYwvHoZjaeYpjEmdoo+CaAD83n7pSNaLJqB0uhghIV7r0xKgfyXivvbjwO7uA50d2DI+Td2PifXy+94eEOkOgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4i6wPhVS/9Up7JSO9PsfvvcFDxBXIcbqsojLZuDsis=;
 b=jeXVFkiXt+Gsa4gcWwWSoJjIaBWIoXRnLU8eWfCl+E2940LPb6x3ZcjX966X76XW+fC6cRbuW0CkB8CIHW2UuGPKeljWFt0vA811ugJDUaj/MKDuLSomB7w5dPcfOaT944XesrqyCp7KM1VX0ky19whxqfFv+grS5rzjL/JBHaY=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Mon, 16 Aug 2021 15:13:42 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::5d37:b014:de9c:344a]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::5d37:b014:de9c:344a%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 15:13:41 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct MMSCH 1.0 version
Thread-Topic: [PATCH] drm/amdgpu: correct MMSCH 1.0 version
Thread-Index: AQHXkq/+sjv8fr6+nUCp0jZvm3taS6t2PLMw
Date: Mon, 16 Aug 2021 15:13:41 +0000
Message-ID: <DM6PR12MB5534D88533AA61BAFE5269D5F4FD9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210816150358.26105-1-zhigang.luo@amd.com>
In-Reply-To: <20210816150358.26105-1-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-16T15:13:39Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3dc0bd24-f878-4739-9c43-d87059c7a961;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6378e58e-1fcc-4605-5ea8-08d960c86ed1
x-ms-traffictypediagnostic: DM8PR12MB5461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB5461DA9DE2852904008F9DF1F4FD9@DM8PR12MB5461.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:154;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYAlia1HhFErtrfM5ljaodgmBx1YKw4YvbPcJEB48a4T+QFIC0Xn1E18AK662gEvMyjuE+yVW73Lym3Vt0ERePFdMxYS1NimUyQrBb1g6dPrlxU+Ghafo4h+S8PwC9on0/6uLJ+kVc/XJu33KTTyLpgClZNJHOtOb329+cl7lDtyRzc+VUUmHJC5YVWPhXnDra4risniMXc24eOi0shJ704X2yNpUDOkciVrOjE2jhqKK8kd8T8RoNMwfttepo8eKTvgN57zYZ/gMa+WHkkjetJm+kKNXuqc1etTR6aqHRQvvjMX94q3Lehb6my+gf8JnOLUCMyJmqRte8U+uZHk81iIhCvLtxko+VkFAmCa25QyC+ddZ6hg5gWEKFTek+Q5KyshBsgtvcbRHFD99OoyFqLUTS/jJ4euYFKOj/l4VMnJqrOn9lx38qfScYFBMH3zaCx0aRm2fh2egOzyHMFHYKcxzS/o/uz4i4KnMEfGqMa7ZbBkAWCFYvh5w+/KDUSnVsGF4X9Zi2loKrztQxiiNeiqcwYn6T9GrBAB5n6vm7KekiANZwah20LOL6xyXONFqlNwNn5lKOktxncBRSdgNKDw3w+2+6XGGHeuT6nk56Ltj2RTXdkap00DOxrJI8wTa1fioYA/xlftBKqyU6QwMVJYa1F8SVPb+2iSelBRRWMqrjZinmjmHRrmjI3Nv5NQ/ThOhkC3cBMwigGzcEhUrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(5660300002)(52536014)(38100700002)(66446008)(26005)(7696005)(4326008)(186003)(8936002)(76116006)(66946007)(122000001)(110136005)(71200400001)(64756008)(9686003)(38070700005)(508600001)(316002)(4744005)(66476007)(66556008)(86362001)(8676002)(6506007)(33656002)(53546011)(55016002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VAPLy3bVpAYyMB2SB5yh23DqynDDlUcFKIYZx5pSscUeBXWl2Z7QPSkhffRT?=
 =?us-ascii?Q?Je5lftlxo0H3s/1Vob5FpscgUyjnb9vNpDwe6Dgs6P3vTjSp5eGLlnk3xPnS?=
 =?us-ascii?Q?LAD3CHB8Lj5pmPYQIsKC0l5fCqnszi8cMFTfayE7hoTuS4d+p5WtQ8UJkF3M?=
 =?us-ascii?Q?wstXjXXCmm7xGz8iM6LYcV6hdhtnECOlzzWSE9cVoQfveUeDooHNIKjBKKk/?=
 =?us-ascii?Q?DYIfqqY7cCLWD+BIVDWkMk/nVs6IrPc3kDzF5qJ4S4j7ScVwbn6Bxd345b0r?=
 =?us-ascii?Q?l+Fwe7NWDy9mdusTcY9N2hfGdhLVdVSCRGZMVeJSZ1g4nXgCL8qz8uXDc99v?=
 =?us-ascii?Q?DOsV1q6KijhM6AVFPDqi0zlEtSsDoyoYoglY8eYQ8TZOEv4RMAPW4agCcweO?=
 =?us-ascii?Q?DCMbEyymvs2X52iMc1t+EC6yPxyl09y4dC2FVfVm+H4SuSEtdEfejJVM7NIS?=
 =?us-ascii?Q?ml/v9/38f1E1/yR/MKZtThvdUvolHZMejndyrKNrkXPX6ajOW3HxJH48+Jfl?=
 =?us-ascii?Q?UQE6Wfo5ZNGhQcSCmeNj/PL9ReWkTLLwDcL2xLKWpxS+c26KM1XTTU8K98S8?=
 =?us-ascii?Q?RCkRUtFA2KM8TQTvzwS42R9zRb382DvQsFalHmD++WwYlwaai2AO456tLOFe?=
 =?us-ascii?Q?ebnsKqHRWypHW1zOAbMICw4RlEjhb13a8i14KumvWR3loDTt9BAH8nbzOtO7?=
 =?us-ascii?Q?lGzNeb9x34uYOWUKydH37nZTryANtnljNS40CTW2v3g8qqJrc3fUs9JsCrVa?=
 =?us-ascii?Q?aHlwEDAhFKCAWjswtDS/STmKU8c0SKE64/mQ0kjRPLv2X5DXpHKl8/S3LoD+?=
 =?us-ascii?Q?o0k2t3qrUN6Nnlv9X7D+P7HeUr9pjeUKrlsVhkWYA2aqLzakzdomTBqljKxj?=
 =?us-ascii?Q?pjzvV2/dWbdwEThzBkxybJr+ZDRq4OlAm0VilgwU2n/iYAhFIuEEVh5wSNoJ?=
 =?us-ascii?Q?kjbcz1Uy5SXHdPfoyiZt0zpI5qDOHOomAFv9f4jbtzHjVrC/3YU9Lucxla7v?=
 =?us-ascii?Q?7jvf0SgEbv1JCjbOUtUGXsrdNGJ4veiHpynns9iwAnrYTcYHiK0srCtWbCy7?=
 =?us-ascii?Q?4YD/0x5220syegiyC9ds1go4fyVhvcySktuKdrkJ1xP5St7oxlC9RSK0nhDr?=
 =?us-ascii?Q?NtsV3+ebWRFRbPPjNbovumALTxqvJgfW1NOModZpmQJ+6OrWaNpTznv4/ue4?=
 =?us-ascii?Q?YWf8HDfyqj1N2/ciF7dCdtdJ5hxGvyPSsiSm7pVzTaYQIJbHnxvhlSuzenjB?=
 =?us-ascii?Q?nIZH+kjg5FMyVIGSpS3ckx7gvo8R1LMZJsxFJwi/QpPafHlFSJxwNY0kxaCC?=
 =?us-ascii?Q?Iy0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6378e58e-1fcc-4605-5ea8-08d960c86ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 15:13:41.7531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1V8jEUpWTOj5/TEmiHmyPXQukaoR8sgxTEf0QVG2ADhWQD2Dorq3vWxd0HaQiWQUf2zqSsi3ndB+tGDhJRQiXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

Looks ok to me .=20

Reviewed by Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang =
Luo
Sent: Monday, August 16, 2021 11:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH] drm/amdgpu: correct MMSCH 1.0 version

MMSCH 1.0 doesn't have major/minor version, only verison.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmsch_v1_0.h
index 20958639b601..2cdab8062c86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v1_0.h
@@ -24,9 +24,7 @@
 #ifndef __MMSCH_V1_0_H__
 #define __MMSCH_V1_0_H__
=20
-#define MMSCH_VERSION_MAJOR	1
-#define MMSCH_VERSION_MINOR	0
-#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+#define MMSCH_VERSION	0x1
=20
 enum mmsch_v1_0_command_type {
 	MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
--=20
2.17.1
