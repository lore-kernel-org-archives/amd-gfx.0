Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2249C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 15:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B22B10E46B;
	Tue,  4 Jan 2022 15:29:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B0E10E46B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 15:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JplIafLuV+dArLV2pOUHTo0lBBDCgih6fLVqjLSlDy3WwdJbSyF40ZceRgexdcHPSEocVCGczXKdzMsCx3Ov7rM4eAtkRX1BvVFLYvg/gR0onvNNbGhBmEjjjstK+Ut/fgS/K3sT3LaVmDYbRYYOn0zRDRX+Daaje3fTu/INVkVja3DqDhfwPMyGUxftpt8px3lDuF2PeKOeGPFFmV6OMt2yPQ6x5xwrCzdQepqlK13LcOOSMO6y8juEdPHZc2+yq13IRs/D7LQMuOC47EhaEokLelppkepjoFQeBoQzx4FoFN5OZY0WRXua2id2dEp8eCOBp0CtnOvy6zts+ojGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh2PviJ+Ar4J2oBw6leAMsHy0vZfbaE789a9lIrxhxM=;
 b=GfVPyiXdmHhwnXKnH3mWlJOR+SwT78mCzlo8iccqOCEZXWVe7Nhr0ZKJfJNruOBEsOddVkbJXF7HXlyNZ+m+Fe4o81Sx6SM90z4pMCcTwzrMaETyekksT2imhAp50F1htgIrEWBvu/BusWjepqBLLp9Xz06SCijzbJWHmG1QlZFfs6+ZZ63cb55c8KrqBMoqmC+Lz/s7wb7xh3VNNma/p7jOGFxlE7YGg6yGBBgamYokSnrApLA/gBmtuzNw0UEuBetNwDu8P7IeAnpm19jF0+sPqhNxDy9L3B995HHLzuhZDnNIeeL9AdfH49FO8PdLSFN7+hPVlDldH55yIH8XYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh2PviJ+Ar4J2oBw6leAMsHy0vZfbaE789a9lIrxhxM=;
 b=24ZKQO3iZpJXGfS0m2ZApFKMzgcRJLjIY+qE6WiiM7gcm6MnZvQi1+zAyA2LGrIACNGRl3b6sBiTOVaUjKMfBcuLRJx0nSqtYb6uiZMtiJ9MEldK6TzWwcWp6zez2ZoHeG4Mz6VT8Sp4P3xWp9lxizYFxPbBfpNnMmNHAd6NiEk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 15:29:12 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%8]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 15:29:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] SWDEV-311259 - dc: move FPU associated DCN302 code to DML
Thread-Topic: [PATCH] SWDEV-311259 - dc: move FPU associated DCN302 code to DML
Thread-Index: AQHX+CwKqwfcy1LkUkSQS+VR2HijraxTDyRK
Date: Tue, 4 Jan 2022 15:29:11 +0000
Message-ID: <BL1PR12MB514475C66271F7B463003D57F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211223183622.76705-1-jdhillon@amd.com>
In-Reply-To: <20211223183622.76705-1-jdhillon@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T15:29:11.123Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 32babc61-9c4f-af43-14d2-641d8e0483b3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4859ca56-1462-4308-4421-08d9cf96f57b
x-ms-traffictypediagnostic: BL1PR12MB5272:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5272F93FEDB0ADF0F65BCF41F74A9@BL1PR12MB5272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: da4SaLYgjRG+Ip8KZNUUWFMrIbHC0iokUSRWpTOnjYPIPZ5LF4OxFxtfdsL0ynX6gu0t/Ud9B+Zi2uXfyzu/APxJmNwAh9uoCh7sCDRGU6PRUkhr1sme43p25jyKKrPpqPiIOrebeR1I3lGqc/ojBiYlcQfqhagy+/isgpBD2NMinDP5mOmfCaMVUjlTv/PxNyfP/L0VF0vdyELpeaVAxfbpg5YGymYmiMTENQ4YpkaV5mEGeOoUQwrxmLXHT5kM6yXm02b7xBpO3knhm0rTUXcAt9FgoNdBQhmp6m6uwCgFydC/rzi7CQduWRzuomcOIl3ccsvr2WHM3a7nzUsprcQnKJgXVjRONoESiI6lQ8R+5Yq6daol7YX8v5ohl2RB3Bxp/YWDoqST8KxmK55pbUHza6vP/TJaxccQVvcIM0x7iqGpGDMpPQ/b9bain+UW4YA1upgT68lQRa1Zc0WZLncIVYNwK899o03Zn8t6OxZCe1vqQVIzMvXWS38baSzAKzX8ltZmviVO6MJC0e0DmVdEP7gSSis09bqeNzSgYgTNYKKL4a7ZfIvSj4B8mEFNE4vVPfRelZPXCbi57hh5YJVisZCkyeMoX55a4NUiEHVUK34lfE5JuMdY1uRlqi3A/KWebFt7LIxdc2x8dkUrpGF70e99rV3sXYC1AY6JNrypMcr+VfgpEEmSqtzIPJ/Ggw1HrCBUO9QaVeRKEkM7qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(186003)(76116006)(19627405001)(66946007)(66446008)(4326008)(9686003)(166002)(33656002)(55016003)(508600001)(66476007)(86362001)(2906002)(30864003)(45080400002)(66556008)(8936002)(71200400001)(64756008)(110136005)(6506007)(83380400001)(26005)(966005)(7696005)(5660300002)(8676002)(316002)(52536014)(122000001)(38070700005)(40140700001)(38100700002)(53546011)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+uQxZzP5ThzdEPu5tMe3AnaDBO/HdwzKMeqrbuCcsXg85uEMQVIYL5foka4?=
 =?us-ascii?Q?HoXVZaI8jZT18vxy5vXpGD90HCBfCkdFtuUJ0FLmLVX6CxwW+Oj85FFaPXHM?=
 =?us-ascii?Q?lvf1thDIYcwWKtkWBgVlRbuWXdxAxAhCFZTn1z2OSQcX8z5x7DxDPjof2HgE?=
 =?us-ascii?Q?l+jBBk0qsF3a/J098Q9JJOIDa2l1+GqKCprvVvEvu3TVYWyuscrrKwGkdGLJ?=
 =?us-ascii?Q?HEYRhiJZXQg4Sj7GJ/rnwfpGqrHLSML8FZoOeLfSZofd0zNUY37v2U/SBYEM?=
 =?us-ascii?Q?3RpQk26GRJNm+ahwohGv3RcNS/jFSIQwsQVMgCYTkmWT70L5mXiUaq2F7q2j?=
 =?us-ascii?Q?SeS66Cd22g9aXImRNdFn2ToTMGwwP5Oev7dw61bGldrmdAsr8+dtsospEa8R?=
 =?us-ascii?Q?VLCaotN8V5Exy+58a+/b5GgaouEEiPsrQnCZD3T+DqCrtUOzRWjZVsow36e/?=
 =?us-ascii?Q?/MaNW1aF8rxd5untoVThoxoz5Iukv3QKLKeuyAfFouOiRAzAqWlRjSFoYO2H?=
 =?us-ascii?Q?M/JkuLq42hvAZ3dkriyDriW98bABvmtBr9TiJ2p7F5lhFW1/h5KSdwp/2vL6?=
 =?us-ascii?Q?JM1emQpAaFW1Kvvmg+TjMI+jcIcU1tsu4yZRLRMIeqSKfqri8qJANhgstpp+?=
 =?us-ascii?Q?VglcYNGmL11Y17vU3eHxNpX8r5hNpVIhy7xHjLp44nEmfGB67EBP3nngiLNS?=
 =?us-ascii?Q?ZvXfnPlrv/5Invf4sB9Uf/euLgeU7WETsBV2sQ2n7qATYYq3K+9U8ifv++oz?=
 =?us-ascii?Q?hKdAH7LOZ6lbhLnUeOyRUnbL8CopOeOuv8Ka4uTnO4stRsuApS1Duy4t8RXM?=
 =?us-ascii?Q?/vvbHwI7EQGTjliMlK1jyJL6M6O/wLoiTp+p2fkwaDBjiykKhYvpfWrMLd8v?=
 =?us-ascii?Q?uDN4RtHJmqbdcRGmqF2e3HTNrZxS6Oyd8jo5uemOsh/QUhNzUuS7SvnzmyT5?=
 =?us-ascii?Q?PBih0oosXl5xq4LWCBj/vn/Y0qPDgDJWfRS9yOrKkeVge6GxHZFeslsZeIbT?=
 =?us-ascii?Q?y+lqj6vRoWOxp5QxdVD5Ada5GApDKD/1a1IWbyDTpgI5ND8tOkXFIVnhk5qG?=
 =?us-ascii?Q?BMu2ogVs5/kLzGYGmOn+FlyYwpPdEUlLbyie/66lZzXnLaWyqQ4Lq02fDJeC?=
 =?us-ascii?Q?CHCiB07gEao1zfzBcYxXrb3JDGxJMgLo+qjS66Fa3QlpAtOiSbR1eGFx3sDZ?=
 =?us-ascii?Q?2b4lBsfkqUAZxo8vd/cFNlGVK0WMgSSFy7dnWEbBJvh0YANaSxaaiE5e0CiF?=
 =?us-ascii?Q?zmeJWUNnoRyFpy04bXsrqWu8OCtjG8D4eotUF9kGRnE+rx1t1xAv8+JBK3kY?=
 =?us-ascii?Q?ySuoql03Gt3bjynwpJcGwvZMXYiZf6jE4X9apJCWxvNP3Ms85ORcSyFy2CSp?=
 =?us-ascii?Q?mTT5T6gp/8Rf0z0sIrq1hfvHfDB6rH6N+t9L9DMSWZhmxURl2ekC60g+9mZX?=
 =?us-ascii?Q?E1dV3bZceJ8SBchmBLbAtKXrqr207Z7QLWO5F5/rj/SkSNS4IAxp+02jUXk8?=
 =?us-ascii?Q?0Y4HXrOycsUc8BlnEcImuZBZxqn7e8BjNx/lfB7+4RL/kiI9HXzjP+23sjxs?=
 =?us-ascii?Q?RHxiaf1Z8zLsbmgr3EPrjaJ1pOOJVUqvU1/vDsZaFjbBANlf+YyKaS7u0XFC?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514475C66271F7B463003D57F74A9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4859ca56-1462-4308-4421-08d9cf96f57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 15:29:11.8457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFgd2/Pxn9rW/GBX1RqkA9OfNbU7F8lRgZcoazKNsqZwp6RxWUnT+IOY8ckTwG7ymIeQfqMFU7W1gpaN/NXFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>,
 "Anson.Jacob@amd.com" <Anson.Jacob@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Dhillon,
 Jasdeep" <Jasdeep.Dhillon@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514475C66271F7B463003D57F74A9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please fix the patch title.  E.g.,
drm/amdgpu/display: move FPU associated DCN302 code to DML
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jasdeep =
Dhillon <jdhillon@amd.com>
Sent: Thursday, December 23, 2021 1:36 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Dhi=
llon, Jasdeep <Jasdeep.Dhillon@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueir=
a@amd.com>; Li, Roman <Roman.Li@amd.com>; Anson.Jacob@amd.com <Anson.Jacob@=
amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.L=
in@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bh=
awanpreet.Lakha@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Gut=
ierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@=
amd.com>
Subject: [PATCH] SWDEV-311259 - dc: move FPU associated DCN302 code to DML

[Why & How]
As part of the FPU isolation work documented in
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.freedesktop.org%2Fseries%2F93042%2F&amp;data=3D04%7C01%7Calexander.deuch=
er%40amd.com%7C94e344c52d824ae7be1108d9c6432a7a%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637758814062989362%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DXPE=
cMjZOJ4rGxJ9I3p1pQUChzYcNj86oMgyKFEHPXPA%3D&amp;reserved=3D0, isolate
code that uses FPU in DCN302 to DML, where all FPU code
should locate.

Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
---
 CMakeLists.txt              |   1 +
 dc/dcn302/Makefile          |  43 ++--
 dc/dcn302/dcn302_resource.c | 340 +-------------------------------
 dc/dcn302/dcn302_resource.h |   3 +
 dc/dml/Makefile             |   2 +
 dc/dml/dcn302/dcn302_fpu.c  | 381 ++++++++++++++++++++++++++++++++++++
 dc/dml/dcn302/dcn302_fpu.h  |  32 +++
 7 files changed, 448 insertions(+), 354 deletions(-)
 create mode 100644 dc/dml/dcn302/dcn302_fpu.c
 create mode 100644 dc/dml/dcn302/dcn302_fpu.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 01c6724df..dfee2cd38 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -243,6 +243,7 @@ list (APPEND srcs "dc/dcn301/dcn301_hubbub.c")
 list (APPEND srcs "dc/dcn302/dcn302_init.c")
 list (APPEND srcs "dc/dcn302/dcn302_hwseq.c")
 list (APPEND srcs "dc/dcn302/dcn302_resource.c")
+list (APPEND srcs "dc/dml/dcn302/dcn302_fpu.c")
 list (APPEND srcs "dc/dcn303/dcn303_init.c")
 list (APPEND srcs "dc/dcn303/dcn303_hwseq.c")
 list (APPEND srcs "dc/dcn303/dcn303_resource.c")
diff --git a/dc/dcn302/Makefile b/dc/dcn302/Makefile
index 101620a88..35a6ffbdd 100644
--- a/dc/dcn302/Makefile
+++ b/dc/dcn302/Makefile
@@ -1,42 +1,37 @@
 #
 # (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
 #
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
 #  Authors: AMD
 #
 # Makefile for dcn302.

 DCN3_02 =3D dcn302_init.o dcn302_hwseq.o dcn302_resource.o

-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -msse
-endif
+#ifdef CONFIG_X86
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -msse
+#endif

-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -maltiv=
ec
-endif
+#ifdef CONFIG_PPC64
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -malti=
vec
+#endif

-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC =3D 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mhard-float
-endif
+#ifdef CONFIG_CC_IS_GCC
+#ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+#IS_OLD_GCC =3D 1
+#endif
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mhard-float
+#endif

-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+#ifdef CONFIG_X86
+#ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-bound=
ary=3D3
 # (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-bo=
undary=3D4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2
-endif
-endif
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-b=
oundary=3D4
+#else
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2
+#endif
+#endif

 AMD_DAL_DCN3_02 =3D $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))

diff --git a/dc/dcn302/dcn302_resource.c b/dc/dcn302/dcn302_resource.c
index a0f02aa9c..8fa290164 100644
--- a/dc/dcn302/dcn302_resource.c
+++ b/dc/dcn302/dcn302_resource.c
@@ -65,6 +65,8 @@
 #include "resource.h"
 #include "vm_helper.h"

+#include "dml/dcn302/dcn302_fpu.h"
+
 #include "include_legacy/dcn3/sienna_cichlid_ip_offset.h"
 #include "include_legacy/dcn302/dcn_3_0_2_offset.h"
 #include "include_legacy/dcn302/dcn_3_0_2_sh_mask.h"
@@ -81,164 +83,6 @@
 #define DC_LOGGER_INIT(logger)
 #endif

-struct _vcs_dpi_ip_params_st dcn3_02_ip =3D {
-               .use_min_dcfclk =3D 0,
-               .clamp_min_dcfclk =3D 0,
-               .odm_capable =3D 1,
-               .gpuvm_enable =3D 1,
-               .hostvm_enable =3D 0,
-               .gpuvm_max_page_table_levels =3D 4,
-               .hostvm_max_page_table_levels =3D 4,
-               .hostvm_cached_page_table_levels =3D 0,
-               .pte_group_size_bytes =3D 2048,
-               .num_dsc =3D 5,
-               .rob_buffer_size_kbytes =3D 184,
-               .det_buffer_size_kbytes =3D 184,
-               .dpte_buffer_size_in_pte_reqs_luma =3D 64,
-               .dpte_buffer_size_in_pte_reqs_chroma =3D 34,
-               .pde_proc_buffer_size_64k_reqs =3D 48,
-               .dpp_output_buffer_pixels =3D 2560,
-               .opp_output_buffer_lines =3D 1,
-               .pixel_chunk_size_kbytes =3D 8,
-               .pte_enable =3D 1,
-               .max_page_table_levels =3D 2,
-               .pte_chunk_size_kbytes =3D 2,  // ?
-               .meta_chunk_size_kbytes =3D 2,
-               .writeback_chunk_size_kbytes =3D 8,
-               .line_buffer_size_bits =3D 789504,
-               .is_line_buffer_bpp_fixed =3D 0,  // ?
-               .line_buffer_fixed_bpp =3D 0,     // ?
-               .dcc_supported =3D true,
-               .writeback_interface_buffer_size_kbytes =3D 90,
-               .writeback_line_buffer_buffer_size =3D 0,
-               .max_line_buffer_lines =3D 12,
-               .writeback_luma_buffer_size_kbytes =3D 12,  // writeback_li=
ne_buffer_buffer_size =3D 656640
-               .writeback_chroma_buffer_size_kbytes =3D 8,
-               .writeback_chroma_line_buffer_width_pixels =3D 4,
-               .writeback_max_hscl_ratio =3D 1,
-               .writeback_max_vscl_ratio =3D 1,
-               .writeback_min_hscl_ratio =3D 1,
-               .writeback_min_vscl_ratio =3D 1,
-               .writeback_max_hscl_taps =3D 1,
-               .writeback_max_vscl_taps =3D 1,
-               .writeback_line_buffer_luma_buffer_size =3D 0,
-               .writeback_line_buffer_chroma_buffer_size =3D 14643,
-#ifdef CONFIG_DRM_AMD_DC_DCN3AG
-               .writeback_interleave_and_whole_buf =3D false,
-#endif
-               .cursor_buffer_size =3D 8,
-               .cursor_chunk_size =3D 2,
-               .max_num_otg =3D 5,
-               .max_num_dpp =3D 5,
-               .max_num_wb =3D 1,
-               .max_dchub_pscl_bw_pix_per_clk =3D 4,
-               .max_pscl_lb_bw_pix_per_clk =3D 2,
-               .max_lb_vscl_bw_pix_per_clk =3D 4,
-               .max_vscl_hscl_bw_pix_per_clk =3D 4,
-               .max_hscl_ratio =3D 6,
-               .max_vscl_ratio =3D 6,
-               .hscl_mults =3D 4,
-               .vscl_mults =3D 4,
-               .max_hscl_taps =3D 8,
-               .max_vscl_taps =3D 8,
-               .dispclk_ramp_margin_percent =3D 1,
-               .underscan_factor =3D 1.11,
-               .min_vblank_lines =3D 32,
-               .dppclk_delay_subtotal =3D 46,
-               .dynamic_metadata_vm_enabled =3D true,
-               .dppclk_delay_scl_lb_only =3D 16,
-               .dppclk_delay_scl =3D 50,
-               .dppclk_delay_cnvc_formatter =3D 27,
-               .dppclk_delay_cnvc_cursor =3D 6,
-               .dispclk_delay_subtotal =3D 119,
-               .dcfclk_cstate_latency =3D 5.2, // SRExitTime
-               .max_inter_dcn_tile_repeaters =3D 8,
-               .max_num_hdmi_frl_outputs =3D 1,
-               .odm_combine_4to1_supported =3D true,
-
-               .xfc_supported =3D false,
-               .xfc_fill_bw_overhead_percent =3D 10.0,
-               .xfc_fill_constant_bytes =3D 0,
-               .gfx7_compat_tiling_supported =3D 0,
-               .number_of_cursors =3D 1,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc =3D {
-               .clock_limits =3D {
-                               {
-                                               .state =3D 0,
-#ifdef CONFIG_DAL_PRODUCTION
-                                               .dcfclk_mhz =3D 1200.0,
-                                               .fabricclk_mhz =3D 1400.0,
-                                               .dispclk_mhz =3D 1217.0,
-                                               .dppclk_mhz =3D 1217.0,
-                                               .phyclk_mhz =3D 810.0,
-                                               .dram_speed_mts =3D 16000.0=
,
-#else
-                                               .dispclk_mhz =3D 562.0,
-                                               .dppclk_mhz =3D 300.0,
-                                               .phyclk_mhz =3D 300.0,
-#endif
-                                               .phyclk_d18_mhz =3D 667.0,
-#ifndef LINUX_DM
-                                               .socclk_mhz =3D 1200.0,
-#endif
-                                               .dscclk_mhz =3D 405.6,
-#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)
-                                               .dtbclk_mhz =3D 1217.0,
-#endif
-                               },
-               },
-
-               .min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFC=
LK */
-               .num_states =3D 1,
-               .sr_exit_time_us =3D 26.5,
-               .sr_enter_plus_exit_time_us =3D 31,
-               .urgent_latency_us =3D 4.0,
-               .urgent_latency_pixel_data_only_us =3D 4.0,
-               .urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
-               .urgent_latency_vm_data_only_us =3D 4.0,
-               .urgent_out_of_order_return_per_channel_pixel_only_bytes =
=3D 4096,
-               .urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =
=3D 4096,
-               .urgent_out_of_order_return_per_channel_vm_only_bytes =3D 4=
096,
-               .pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 80.0,
-               .pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 60.0,
-               .pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 40.0,
-               .max_avg_sdp_bw_use_normal_percent =3D 60.0,
-               .max_avg_dram_bw_use_normal_percent =3D 40.0,
-               .writeback_latency_us =3D 12.0,
-               .max_request_size_bytes =3D 256,
-#ifndef LINUX_DM
-               .dram_channel_width_bytes =3D 2,
-#endif
-               .fabric_datapath_to_dcn_data_return_bytes =3D 64,
-               .dcn_downspread_percent =3D 0.5,
-               .downspread_percent =3D 0.38,
-               .dram_page_open_time_ns =3D 50.0,
-               .dram_rw_turnaround_time_ns =3D 17.5,
-               .dram_return_buffer_per_channel_bytes =3D 8192,
-               .round_trip_ping_latency_dcfclk_cycles =3D 156,
-               .urgent_out_of_order_return_per_channel_bytes =3D 4096,
-               .channel_interleave_bytes =3D 256,
-               .num_banks =3D 8,
-#ifndef LINUX_DM
-               .num_chans =3D 8,
-#endif
-               .gpuvm_min_page_size_bytes =3D 4096,
-               .hostvm_min_page_size_bytes =3D 4096,
-               .dram_clock_change_latency_us =3D 404,
-               .dummy_pstate_latency_us =3D 5,
-               .writeback_dram_clock_change_latency_us =3D 23.0,
-               .return_bus_width_bytes =3D 64,
-               .dispclk_dppclk_vco_speed_mhz =3D 3650,
-               .xfc_bus_transport_time_us =3D 20,      // ?
-               .xfc_xbuf_latency_tolerance_us =3D 4,  // ?
-               .use_urgent_burst_bw =3D 1,            // ?
-               .do_urgent_latency_adjustment =3D true,
-               .urgent_latency_adjustment_fabric_clock_component_us =3D 1.=
0,
-               .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 1=
000,
-};
-
 static const struct dc_debug_options debug_defaults_drv =3D {
                 .disable_dmcu =3D true,
                 .force_abm_enable =3D false,
@@ -1271,7 +1115,9 @@ static bool init_soc_bounding_box(struct dc *dc,  str=
uct resource_pool *pool)
         loaded_ip->max_num_otg =3D pool->pipe_count;
         loaded_ip->max_num_dpp =3D pool->pipe_count;
         loaded_ip->clamp_min_dcfclk =3D dc->config.clamp_min_dcfclk;
+       DC_FP_START();
         dcn20_patch_bounding_box(dc, loaded_bb);
+       DC_FP_END();
 #ifdef CONFIG_DRM_AMD_DC_DCN3AG
         if (dc->config.host_vm_min_page_size !=3D 0)
                 loaded_bb->hostvm_min_page_size_bytes =3D dc->config.host_=
vm_min_page_size;
@@ -1285,17 +1131,10 @@ static bool init_soc_bounding_box(struct dc *dc,  s=
truct resource_pool *pool)

                 if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
                             dc->ctx->dc_bios, &bb_info) =3D=3D BP_RESULT_O=
K) {
-                       if (bb_info.dram_clock_change_latency_100ns > 0)
-                               dcn3_02_soc.dram_clock_change_latency_us =
=3D
-                                       bb_info.dram_clock_change_latency_1=
00ns * 10;

-                       if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-                               dcn3_02_soc.sr_enter_plus_exit_time_us =3D
-                                       bb_info.dram_sr_enter_exit_latency_=
100ns * 10;
-
-                       if (bb_info.dram_sr_exit_latency_100ns > 0)
-                               dcn3_02_soc.sr_exit_time_us =3D
-                                       bb_info.dram_sr_exit_latency_100ns =
* 10;
+                               DC_FP_START();
+                               dcn302_fpu_init_soc_bounding_box(bb_info);
+                               DC_FP_END();
                 }
         }

@@ -1450,170 +1289,11 @@ static void dcn302_destroy_resource_pool(struct re=
source_pool **pool)
         *pool =3D NULL;
 }

-static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-               unsigned int *optimal_dcfclk,
-               unsigned int *optimal_fclk)
-{
-       double bw_from_dram, bw_from_dram1, bw_from_dram2;
-
-       bw_from_dram1 =3D uclk_mts * dcn3_02_soc.num_chans *
-               dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg=
_dram_bw_use_normal_percent / 100);
-       bw_from_dram2 =3D uclk_mts * dcn3_02_soc.num_chans *
-               dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg=
_sdp_bw_use_normal_percent / 100);
-
-       bw_from_dram =3D (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : =
bw_from_dram2;
-
-       if (optimal_fclk)
-               *optimal_fclk =3D bw_from_dram /
-               (dcn3_02_soc.fabric_datapath_to_dcn_data_return_bytes * (dc=
n3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
-
-       if (optimal_dcfclk)
-               *optimal_dcfclk =3D  bw_from_dram /
-               (dcn3_02_soc.return_bus_width_bytes * (dcn3_02_soc.max_avg_=
sdp_bw_use_normal_percent / 100));
-}
-
 void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params)
 {
-       unsigned int i, j;
-       unsigned int num_states =3D 0;
-
-       unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] =3D {0};
-       unsigned int dram_speed_mts[DC__VOLTAGE_STATES] =3D {0};
-       unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES=
] =3D {0};
-       unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] =3D {0};
-
-       unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] =3D {694, 875, =
1000, 1200};
-       unsigned int num_dcfclk_sta_targets =3D 4;
-       unsigned int num_uclk_states;
-
-
-       if (dc->ctx->dc_bios->vram_info.num_chans)
-               dcn3_02_soc.num_chans =3D dc->ctx->dc_bios->vram_info.num_c=
hans;
-
-       if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-               dcn3_02_soc.dram_channel_width_bytes =3D dc->ctx->dc_bios->=
vram_info.dram_channel_width_bytes;
-
-       dcn3_02_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
-       dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
-
-       if (bw_params->clk_table.entries[0].memclk_mhz) {
-               int max_dcfclk_mhz =3D 0, max_dispclk_mhz =3D 0, max_dppclk=
_mhz =3D 0, max_phyclk_mhz =3D 0;
-
-               for (i =3D 0; i < MAX_NUM_DPM_LVL; i++) {
-                       if (bw_params->clk_table.entries[i].dcfclk_mhz > ma=
x_dcfclk_mhz)
-                               max_dcfclk_mhz =3D bw_params->clk_table.ent=
ries[i].dcfclk_mhz;
-                       if (bw_params->clk_table.entries[i].dispclk_mhz > m=
ax_dispclk_mhz)
-                               max_dispclk_mhz =3D bw_params->clk_table.en=
tries[i].dispclk_mhz;
-                       if (bw_params->clk_table.entries[i].dppclk_mhz > ma=
x_dppclk_mhz)
-                               max_dppclk_mhz =3D bw_params->clk_table.ent=
ries[i].dppclk_mhz;
-                       if (bw_params->clk_table.entries[i].phyclk_mhz > ma=
x_phyclk_mhz)
-                               max_phyclk_mhz =3D bw_params->clk_table.ent=
ries[i].phyclk_mhz;
-               }
-               if (!max_dcfclk_mhz)
-                       max_dcfclk_mhz =3D dcn3_02_soc.clock_limits[0].dcfc=
lk_mhz;
-               if (!max_dispclk_mhz)
-                       max_dispclk_mhz =3D dcn3_02_soc.clock_limits[0].dis=
pclk_mhz;
-               if (!max_dppclk_mhz)
-                       max_dppclk_mhz =3D dcn3_02_soc.clock_limits[0].dppc=
lk_mhz;
-               if (!max_phyclk_mhz)
-                       max_phyclk_mhz =3D dcn3_02_soc.clock_limits[0].phyc=
lk_mhz;
-
-               if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targ=
ets-1]) {
-                       /* If max DCFCLK is greater than the max DCFCLK STA=
 target, insert into the DCFCLK STA target array */
-                       dcfclk_sta_targets[num_dcfclk_sta_targets] =3D max_=
dcfclk_mhz;
-                       num_dcfclk_sta_targets++;
-               } else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_s=
ta_targets-1]) {
-                       /* If max DCFCLK is less than the max DCFCLK STA ta=
rget, cap values and remove duplicates */
-                       for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
-                               if (dcfclk_sta_targets[i] > max_dcfclk_mhz)=
 {
-                                       dcfclk_sta_targets[i] =3D max_dcfcl=
k_mhz;
-                                       break;
-                               }
-                       }
-                       /* Update size of array since we "removed" duplicat=
es */
-                       num_dcfclk_sta_targets =3D i + 1;
-               }
-
-               num_uclk_states =3D bw_params->clk_table.num_entries;
-
-               /* Calculate optimal dcfclk for each uclk */
-               for (i =3D 0; i < num_uclk_states; i++) {
-                       dcn302_get_optimal_dcfclk_fclk_for_uclk(bw_params->=
clk_table.entries[i].memclk_mhz * 16,
-                                       &optimal_dcfclk_for_uclk[i], NULL);
-                       if (optimal_dcfclk_for_uclk[i] < bw_params->clk_tab=
le.entries[0].dcfclk_mhz) {
-                               optimal_dcfclk_for_uclk[i] =3D bw_params->c=
lk_table.entries[0].dcfclk_mhz;
-                       }
-               }
-
-               /* Calculate optimal uclk for each dcfclk sta target */
-               for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
-                       for (j =3D 0; j < num_uclk_states; j++) {
-                               if (dcfclk_sta_targets[i] < optimal_dcfclk_=
for_uclk[j]) {
-                                       optimal_uclk_for_dcfclk_sta_targets=
[i] =3D
-                                                       bw_params->clk_tabl=
e.entries[j].memclk_mhz * 16;
-                                       break;
-                               }
-                       }
-               }
-
-               i =3D 0;
-               j =3D 0;
-               /* create the final dcfclk and uclk table */
-               while (i < num_dcfclk_sta_targets && j < num_uclk_states &&=
 num_states < DC__VOLTAGE_STATES) {
-                       if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk=
[j] && i < num_dcfclk_sta_targets) {
-                               dcfclk_mhz[num_states] =3D dcfclk_sta_targe=
ts[i];
-                               dram_speed_mts[num_states++] =3D optimal_uc=
lk_for_dcfclk_sta_targets[i++];
-                       } else {
-                               if (j < num_uclk_states && optimal_dcfclk_f=
or_uclk[j] <=3D max_dcfclk_mhz) {
-                                       dcfclk_mhz[num_states] =3D optimal_=
dcfclk_for_uclk[j];
-                                       dram_speed_mts[num_states++] =3D bw=
_params->clk_table.entries[j++].memclk_mhz * 16;
-                               } else {
-                                       j =3D num_uclk_states;
-                               }
-                       }
-               }
-
-               while (i < num_dcfclk_sta_targets && num_states < DC__VOLTA=
GE_STATES) {
-                       dcfclk_mhz[num_states] =3D dcfclk_sta_targets[i];
-                       dram_speed_mts[num_states++] =3D optimal_uclk_for_d=
cfclk_sta_targets[i++];
-               }
-
-               while (j < num_uclk_states && num_states < DC__VOLTAGE_STAT=
ES &&
-                               optimal_dcfclk_for_uclk[j] <=3D max_dcfclk_=
mhz) {
-                       dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[=
j];
-                       dram_speed_mts[num_states++] =3D bw_params->clk_tab=
le.entries[j++].memclk_mhz * 16;
-               }
-
-               dcn3_02_soc.num_states =3D num_states;
-               for (i =3D 0; i < dcn3_02_soc.num_states; i++) {
-                       dcn3_02_soc.clock_limits[i].state =3D i;
-                       dcn3_02_soc.clock_limits[i].dcfclk_mhz =3D dcfclk_m=
hz[i];
-                       dcn3_02_soc.clock_limits[i].fabricclk_mhz =3D dcfcl=
k_mhz[i];
-                       dcn3_02_soc.clock_limits[i].dram_speed_mts =3D dram=
_speed_mts[i];
-
-                       /* Fill all states with max values of all other clo=
cks */
-                       dcn3_02_soc.clock_limits[i].dispclk_mhz =3D max_dis=
pclk_mhz;
-                       dcn3_02_soc.clock_limits[i].dppclk_mhz  =3D max_dpp=
clk_mhz;
-                       dcn3_02_soc.clock_limits[i].phyclk_mhz  =3D max_phy=
clk_mhz;
-                       /* Populate from bw_params for DTBCLK, SOCCLK */
-                       if (!bw_params->clk_table.entries[i].dtbclk_mhz && =
i > 0)
-                               dcn3_02_soc.clock_limits[i].dtbclk_mhz  =3D=
 dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;
-                       else
-                               dcn3_02_soc.clock_limits[i].dtbclk_mhz  =3D=
 bw_params->clk_table.entries[i].dtbclk_mhz;
-                       if (!bw_params->clk_table.entries[i].socclk_mhz && =
i > 0)
-                               dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
dcn3_02_soc.clock_limits[i-1].socclk_mhz;
-                       else
-                               dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
bw_params->clk_table.entries[i].socclk_mhz;
-                       /* These clocks cannot come from bw_params, always =
fill from dcn3_02_soc[1] */
-                       /* FCLK, PHYCLK_D18, DSCCLK */
-                       dcn3_02_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3=
_02_soc.clock_limits[0].phyclk_d18_mhz;
-                       dcn3_02_soc.clock_limits[i].dscclk_mhz =3D dcn3_02_=
soc.clock_limits[0].dscclk_mhz;
-               }
-               /* re-init DML with updated bb */
-               dml_init_instance(&dc->dml, &dcn3_02_soc, &dcn3_02_ip, DML_=
PROJECT_DCN30);
-               if (dc->current_state)
-                       dml_init_instance(&dc->current_state->bw_ctx.dml, &=
dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
-       }
+       DC_FP_START();
+       dcn302_fpu_update_bw_bounding_box(dc, bw_params);
+       DC_FP_END();
 }

 static struct resource_funcs dcn302_res_pool_funcs =3D {
diff --git a/dc/dcn302/dcn302_resource.h b/dc/dcn302/dcn302_resource.h
index 42d2c73e3..9f24e73b9 100644
--- a/dc/dcn302/dcn302_resource.h
+++ b/dc/dcn302/dcn302_resource.h
@@ -28,6 +28,9 @@

 #include "core_types.h"

+extern struct _vcs_dpi_ip_params_st dcn3_02_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc;
+
 struct resource_pool *dcn302_create_resource_pool(const struct dc_init_dat=
a *init_data, struct dc *dc);

 void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw=
_params);
diff --git a/dc/dml/Makefile b/dc/dml/Makefile
index d8e03ca15..f55f28fe3 100644
--- a/dc/dml/Makefile
+++ b/dc/dml/Makefile
@@ -73,6 +73,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/frl_cap_chk_30.o :=3D $=
(dml_ccflags)
 #endif
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o :=3D $(dml_ccflags)
 ifdef CONFIG_DRM_AMD_DC_DCN3_1
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=3D $(dml_ccflags=
) -Wframe-larger-than=3D2048
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D $(dml_ccfl=
ags)
@@ -103,6 +104,7 @@ DML +=3D dcn30/frl_cap_chk_30.o
 #endif
 endif
 DML +=3D dcn301/dcn301_fpu.o
+DML +=3D dcn302/dcn302_fpu.o
 ifdef CONFIG_DRM_AMD_DC_DCN3_1
 DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 endif
diff --git a/dc/dml/dcn302/dcn302_fpu.c b/dc/dml/dcn302/dcn302_fpu.c
new file mode 100644
index 000000000..97d9dc80b
--- /dev/null
+++ b/dc/dml/dcn302/dcn302_fpu.c
@@ -0,0 +1,381 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "resource.h"
+#include "clk_mgr.h"
+#include "dcn20/dcn20_resource.h"
+#include "dcn302/dcn302_resource.h"
+
+#include "dml/dcn20/dcn20_fpu.h"
+#include "dcn302_fpu.h"
+
+struct _vcs_dpi_ip_params_st dcn3_02_ip =3D {
+               .use_min_dcfclk =3D 0,
+               .clamp_min_dcfclk =3D 0,
+               .odm_capable =3D 1,
+               .gpuvm_enable =3D 1,
+               .hostvm_enable =3D 0,
+               .gpuvm_max_page_table_levels =3D 4,
+               .hostvm_max_page_table_levels =3D 4,
+               .hostvm_cached_page_table_levels =3D 0,
+               .pte_group_size_bytes =3D 2048,
+               .num_dsc =3D 5,
+               .rob_buffer_size_kbytes =3D 184,
+               .det_buffer_size_kbytes =3D 184,
+               .dpte_buffer_size_in_pte_reqs_luma =3D 64,
+               .dpte_buffer_size_in_pte_reqs_chroma =3D 34,
+               .pde_proc_buffer_size_64k_reqs =3D 48,
+               .dpp_output_buffer_pixels =3D 2560,
+               .opp_output_buffer_lines =3D 1,
+               .pixel_chunk_size_kbytes =3D 8,
+               .pte_enable =3D 1,
+               .max_page_table_levels =3D 2,
+               .pte_chunk_size_kbytes =3D 2,  // ?
+               .meta_chunk_size_kbytes =3D 2,
+               .writeback_chunk_size_kbytes =3D 8,
+               .line_buffer_size_bits =3D 789504,
+               .is_line_buffer_bpp_fixed =3D 0,  // ?
+               .line_buffer_fixed_bpp =3D 0,     // ?
+               .dcc_supported =3D true,
+               .writeback_interface_buffer_size_kbytes =3D 90,
+               .writeback_line_buffer_buffer_size =3D 0,
+               .max_line_buffer_lines =3D 12,
+               .writeback_luma_buffer_size_kbytes =3D 12,  // writeback_li=
ne_buffer_buffer_size =3D 656640
+               .writeback_chroma_buffer_size_kbytes =3D 8,
+               .writeback_chroma_line_buffer_width_pixels =3D 4,
+               .writeback_max_hscl_ratio =3D 1,
+               .writeback_max_vscl_ratio =3D 1,
+               .writeback_min_hscl_ratio =3D 1,
+               .writeback_min_vscl_ratio =3D 1,
+               .writeback_max_hscl_taps =3D 1,
+               .writeback_max_vscl_taps =3D 1,
+               .writeback_line_buffer_luma_buffer_size =3D 0,
+               .writeback_line_buffer_chroma_buffer_size =3D 14643,
+#ifdef CONFIG_DRM_AMD_DC_DCN3AG
+               .writeback_interleave_and_whole_buf =3D false,
+#endif
+               .cursor_buffer_size =3D 8,
+               .cursor_chunk_size =3D 2,
+               .max_num_otg =3D 5,
+               .max_num_dpp =3D 5,
+               .max_num_wb =3D 1,
+               .max_dchub_pscl_bw_pix_per_clk =3D 4,
+               .max_pscl_lb_bw_pix_per_clk =3D 2,
+               .max_lb_vscl_bw_pix_per_clk =3D 4,
+               .max_vscl_hscl_bw_pix_per_clk =3D 4,
+               .max_hscl_ratio =3D 6,
+               .max_vscl_ratio =3D 6,
+               .hscl_mults =3D 4,
+               .vscl_mults =3D 4,
+               .max_hscl_taps =3D 8,
+               .max_vscl_taps =3D 8,
+               .dispclk_ramp_margin_percent =3D 1,
+               .underscan_factor =3D 1.11,
+               .min_vblank_lines =3D 32,
+               .dppclk_delay_subtotal =3D 46,
+               .dynamic_metadata_vm_enabled =3D true,
+               .dppclk_delay_scl_lb_only =3D 16,
+               .dppclk_delay_scl =3D 50,
+               .dppclk_delay_cnvc_formatter =3D 27,
+               .dppclk_delay_cnvc_cursor =3D 6,
+               .dispclk_delay_subtotal =3D 119,
+               .dcfclk_cstate_latency =3D 5.2, // SRExitTime
+               .max_inter_dcn_tile_repeaters =3D 8,
+               .max_num_hdmi_frl_outputs =3D 1,
+               .odm_combine_4to1_supported =3D true,
+
+               .xfc_supported =3D false,
+               .xfc_fill_bw_overhead_percent =3D 10.0,
+               .xfc_fill_constant_bytes =3D 0,
+               .gfx7_compat_tiling_supported =3D 0,
+               .number_of_cursors =3D 1,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc =3D {
+               .clock_limits =3D {
+                               {
+                                               .state =3D 0,
+#ifdef CONFIG_DAL_PRODUCTION
+                                               .dcfclk_mhz =3D 1200.0,
+                                               .fabricclk_mhz =3D 1400.0,
+                                               .dispclk_mhz =3D 1217.0,
+                                               .dppclk_mhz =3D 1217.0,
+                                               .phyclk_mhz =3D 810.0,
+                                               .dram_speed_mts =3D 16000.0=
,
+#else
+                                               .dispclk_mhz =3D 562.0,
+                                               .dppclk_mhz =3D 300.0,
+                                               .phyclk_mhz =3D 300.0,
+#endif
+                                               .phyclk_d18_mhz =3D 667.0,
+#ifndef LINUX_DM
+                                               .socclk_mhz =3D 1200.0,
+#endif
+                                               .dscclk_mhz =3D 405.6,
+#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)
+                                               .dtbclk_mhz =3D 1217.0,
+#endif
+                               },
+               },
+
+               .min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFC=
LK */
+               .num_states =3D 1,
+               .sr_exit_time_us =3D 26.5,
+               .sr_enter_plus_exit_time_us =3D 31,
+               .urgent_latency_us =3D 4.0,
+               .urgent_latency_pixel_data_only_us =3D 4.0,
+               .urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
+               .urgent_latency_vm_data_only_us =3D 4.0,
+               .urgent_out_of_order_return_per_channel_pixel_only_bytes =
=3D 4096,
+               .urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =
=3D 4096,
+               .urgent_out_of_order_return_per_channel_vm_only_bytes =3D 4=
096,
+               .pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 80.0,
+               .pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 60.0,
+               .pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 40.0,
+               .max_avg_sdp_bw_use_normal_percent =3D 60.0,
+               .max_avg_dram_bw_use_normal_percent =3D 40.0,
+               .writeback_latency_us =3D 12.0,
+               .max_request_size_bytes =3D 256,
+#ifndef LINUX_DM
+               .dram_channel_width_bytes =3D 2,
+#endif
+               .fabric_datapath_to_dcn_data_return_bytes =3D 64,
+               .dcn_downspread_percent =3D 0.5,
+               .downspread_percent =3D 0.38,
+               .dram_page_open_time_ns =3D 50.0,
+               .dram_rw_turnaround_time_ns =3D 17.5,
+               .dram_return_buffer_per_channel_bytes =3D 8192,
+               .round_trip_ping_latency_dcfclk_cycles =3D 156,
+               .urgent_out_of_order_return_per_channel_bytes =3D 4096,
+               .channel_interleave_bytes =3D 256,
+               .num_banks =3D 8,
+#ifndef LINUX_DM
+               .num_chans =3D 8,
+#endif
+               .gpuvm_min_page_size_bytes =3D 4096,
+               .hostvm_min_page_size_bytes =3D 4096,
+               .dram_clock_change_latency_us =3D 404,
+               .dummy_pstate_latency_us =3D 5,
+               .writeback_dram_clock_change_latency_us =3D 23.0,
+               .return_bus_width_bytes =3D 64,
+               .dispclk_dppclk_vco_speed_mhz =3D 3650,
+               .xfc_bus_transport_time_us =3D 20,      // ?
+               .xfc_xbuf_latency_tolerance_us =3D 4,  // ?
+               .use_urgent_burst_bw =3D 1,            // ?
+               .do_urgent_latency_adjustment =3D true,
+               .urgent_latency_adjustment_fabric_clock_component_us =3D 1.=
0,
+               .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 1=
000,
+};
+
+static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+       unsigned int *optimal_dcfclk,
+       unsigned int *optimal_fclk)
+{
+
+                       double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+                       bw_from_dram1 =3D uclk_mts * dcn3_02_soc.num_chans =
*
+                               dcn3_02_soc.dram_channel_width_bytes *
+                               (dcn3_02_soc.max_avg_dram_bw_use_normal_per=
cent / 100);
+                       bw_from_dram2 =3D uclk_mts * dcn3_02_soc.num_chans =
*
+                               dcn3_02_soc.dram_channel_width_bytes *
+                               (dcn3_02_soc.max_avg_sdp_bw_use_normal_perc=
ent / 100);
+
+                       bw_from_dram =3D (bw_from_dram1 < bw_from_dram2) ? =
bw_from_dram1 : bw_from_dram2;
+
+                       if (optimal_fclk)
+                               *optimal_fclk =3D bw_from_dram /
+                               (dcn3_02_soc.fabric_datapath_to_dcn_data_re=
turn_bytes *
+                                (dcn3_02_soc.max_avg_sdp_bw_use_normal_per=
cent / 100));
+
+                       if (optimal_dcfclk)
+                               *optimal_dcfclk =3D  bw_from_dram /
+                               (dcn3_02_soc.return_bus_width_bytes *
+                                (dcn3_02_soc.max_avg_sdp_bw_use_normal_per=
cent / 100));
+}
+
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params=
 *bw_params)
+{
+       unsigned int i, j;
+       unsigned int num_states =3D 0;
+
+       unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] =3D {0};
+       unsigned int dram_speed_mts[DC__VOLTAGE_STATES] =3D {0};
+       unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES=
] =3D {0};
+       unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] =3D {0};
+
+       unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] =3D {694, 875, =
1000, 1200};
+       unsigned int num_dcfclk_sta_targets =3D 4;
+       unsigned int num_uclk_states;
+
+       dc_assert_fp_enabled();
+
+       if (dc->ctx->dc_bios->vram_info.num_chans)
+               dcn3_02_soc.num_chans =3D dc->ctx->dc_bios->vram_info.num_c=
hans;
+
+       if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+               dcn3_02_soc.dram_channel_width_bytes =3D dc->ctx->dc_bios->=
vram_info.dram_channel_width_bytes;
+
+       dcn3_02_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
+       dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
+
+       if (bw_params->clk_table.entries[0].memclk_mhz) {
+               int max_dcfclk_mhz =3D 0, max_dispclk_mhz =3D 0, max_dppclk=
_mhz =3D 0, max_phyclk_mhz =3D 0;
+
+               for (i =3D 0; i < MAX_NUM_DPM_LVL; i++) {
+                       if (bw_params->clk_table.entries[i].dcfclk_mhz > ma=
x_dcfclk_mhz)
+                               max_dcfclk_mhz =3D bw_params->clk_table.ent=
ries[i].dcfclk_mhz;
+                       if (bw_params->clk_table.entries[i].dispclk_mhz > m=
ax_dispclk_mhz)
+                               max_dispclk_mhz =3D bw_params->clk_table.en=
tries[i].dispclk_mhz;
+                       if (bw_params->clk_table.entries[i].dppclk_mhz > ma=
x_dppclk_mhz)
+                               max_dppclk_mhz =3D bw_params->clk_table.ent=
ries[i].dppclk_mhz;
+                       if (bw_params->clk_table.entries[i].phyclk_mhz > ma=
x_phyclk_mhz)
+                               max_phyclk_mhz =3D bw_params->clk_table.ent=
ries[i].phyclk_mhz;
+               }
+               if (!max_dcfclk_mhz)
+                       max_dcfclk_mhz =3D dcn3_02_soc.clock_limits[0].dcfc=
lk_mhz;
+               if (!max_dispclk_mhz)
+                       max_dispclk_mhz =3D dcn3_02_soc.clock_limits[0].dis=
pclk_mhz;
+               if (!max_dppclk_mhz)
+                       max_dppclk_mhz =3D dcn3_02_soc.clock_limits[0].dppc=
lk_mhz;
+               if (!max_phyclk_mhz)
+                       max_phyclk_mhz =3D dcn3_02_soc.clock_limits[0].phyc=
lk_mhz;
+
+               if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targ=
ets-1]) {
+                       /* If max DCFCLK is greater than the max DCFCLK STA=
 target, insert into the DCFCLK STA target array */
+                       dcfclk_sta_targets[num_dcfclk_sta_targets] =3D max_=
dcfclk_mhz;
+                       num_dcfclk_sta_targets++;
+               } else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_s=
ta_targets-1]) {
+                       /* If max DCFCLK is less than the max DCFCLK STA ta=
rget, cap values and remove duplicates */
+                       for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
+                               if (dcfclk_sta_targets[i] > max_dcfclk_mhz)=
 {
+                                       dcfclk_sta_targets[i] =3D max_dcfcl=
k_mhz;
+                                       break;
+                               }
+                       }
+                       /* Update size of array since we "removed" duplicat=
es */
+                       num_dcfclk_sta_targets =3D i + 1;
+               }
+
+               num_uclk_states =3D bw_params->clk_table.num_entries;
+
+               /* Calculate optimal dcfclk for each uclk */
+               for (i =3D 0; i < num_uclk_states; i++) {
+                       dcn302_get_optimal_dcfclk_fclk_for_uclk(bw_params->=
clk_table.entries[i].memclk_mhz * 16,
+                                       &optimal_dcfclk_for_uclk[i], NULL);
+                       if (optimal_dcfclk_for_uclk[i] < bw_params->clk_tab=
le.entries[0].dcfclk_mhz)
+                               optimal_dcfclk_for_uclk[i] =3D bw_params->c=
lk_table.entries[0].dcfclk_mhz;
+               }
+
+               /* Calculate optimal uclk for each dcfclk sta target */
+               for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
+                       for (j =3D 0; j < num_uclk_states; j++) {
+                               if (dcfclk_sta_targets[i] < optimal_dcfclk_=
for_uclk[j]) {
+                                       optimal_uclk_for_dcfclk_sta_targets=
[i] =3D
+                                                       bw_params->clk_tabl=
e.entries[j].memclk_mhz * 16;
+                                       break;
+                               }
+                       }
+               }
+
+               i =3D 0;
+               j =3D 0;
+               /* create the final dcfclk and uclk table */
+               while (i < num_dcfclk_sta_targets && j < num_uclk_states &&=
 num_states < DC__VOLTAGE_STATES) {
+                       if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk=
[j] && i < num_dcfclk_sta_targets) {
+                               dcfclk_mhz[num_states] =3D dcfclk_sta_targe=
ts[i];
+                               dram_speed_mts[num_states++] =3D optimal_uc=
lk_for_dcfclk_sta_targets[i++];
+                       } else {
+                               if (j < num_uclk_states && optimal_dcfclk_f=
or_uclk[j] <=3D max_dcfclk_mhz) {
+                                       dcfclk_mhz[num_states] =3D optimal_=
dcfclk_for_uclk[j];
+                                       dram_speed_mts[num_states++] =3D bw=
_params->clk_table.entries[j++].memclk_mhz * 16;
+                               } else {
+                                       j =3D num_uclk_states;
+                               }
+                       }
+               }
+
+               while (i < num_dcfclk_sta_targets && num_states < DC__VOLTA=
GE_STATES) {
+                       dcfclk_mhz[num_states] =3D dcfclk_sta_targets[i];
+                       dram_speed_mts[num_states++] =3D optimal_uclk_for_d=
cfclk_sta_targets[i++];
+               }
+
+               while (j < num_uclk_states && num_states < DC__VOLTAGE_STAT=
ES &&
+                               optimal_dcfclk_for_uclk[j] <=3D max_dcfclk_=
mhz) {
+                       dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[=
j];
+                       dram_speed_mts[num_states++] =3D bw_params->clk_tab=
le.entries[j++].memclk_mhz * 16;
+               }
+
+               dcn3_02_soc.num_states =3D num_states;
+               for (i =3D 0; i < dcn3_02_soc.num_states; i++) {
+                       dcn3_02_soc.clock_limits[i].state =3D i;
+                       dcn3_02_soc.clock_limits[i].dcfclk_mhz =3D dcfclk_m=
hz[i];
+                       dcn3_02_soc.clock_limits[i].fabricclk_mhz =3D dcfcl=
k_mhz[i];
+                       dcn3_02_soc.clock_limits[i].dram_speed_mts =3D dram=
_speed_mts[i];
+
+                       /* Fill all states with max values of all other clo=
cks */
+                       dcn3_02_soc.clock_limits[i].dispclk_mhz =3D max_dis=
pclk_mhz;
+                       dcn3_02_soc.clock_limits[i].dppclk_mhz  =3D max_dpp=
clk_mhz;
+                       dcn3_02_soc.clock_limits[i].phyclk_mhz  =3D max_phy=
clk_mhz;
+                       /* Populate from bw_params for DTBCLK, SOCCLK */
+                       if (!bw_params->clk_table.entries[i].dtbclk_mhz && =
i > 0)
+                               dcn3_02_soc.clock_limits[i].dtbclk_mhz  =3D=
 dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;
+                       else
+                               dcn3_02_soc.clock_limits[i].dtbclk_mhz  =3D=
 bw_params->clk_table.entries[i].dtbclk_mhz;
+                       if (!bw_params->clk_table.entries[i].socclk_mhz && =
i > 0)
+                               dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
dcn3_02_soc.clock_limits[i-1].socclk_mhz;
+                       else
+                               dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
bw_params->clk_table.entries[i].socclk_mhz;
+                       /* These clocks cannot come from bw_params, always =
fill from dcn3_02_soc[1] */
+                       /* FCLK, PHYCLK_D18, DSCCLK */
+                       dcn3_02_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3=
_02_soc.clock_limits[0].phyclk_d18_mhz;
+                       dcn3_02_soc.clock_limits[i].dscclk_mhz =3D dcn3_02_=
soc.clock_limits[0].dscclk_mhz;
+               }
+               /* re-init DML with updated bb */
+               dml_init_instance(&dc->dml, &dcn3_02_soc, &dcn3_02_ip, DML_=
PROJECT_DCN30);
+               if (dc->current_state)
+                       dml_init_instance(&dc->current_state->bw_ctx.dml, &=
dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
+       }
+}
+
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
+{
+
+                       dc_assert_fp_enabled();
+
+                       if (bb_info.dram_clock_change_latency_100ns > 0)
+                               dcn3_02_soc.dram_clock_change_latency_us =
=3D
+                                       bb_info.dram_clock_change_latency_1=
00ns * 10;
+
+                       if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+                               dcn3_02_soc.sr_enter_plus_exit_time_us =3D
+                                       bb_info.dram_sr_enter_exit_latency_=
100ns * 10;
+
+                       if (bb_info.dram_sr_exit_latency_100ns > 0)
+                               dcn3_02_soc.sr_exit_time_us =3D
+                                       bb_info.dram_sr_exit_latency_100ns =
* 10;
+}
+
+
diff --git a/dc/dml/dcn302/dcn302_fpu.h b/dc/dml/dcn302/dcn302_fpu.h
new file mode 100644
index 000000000..548305d96
--- /dev/null
+++ b/dc/dml/dcn302/dcn302_fpu.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2019-2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DCN302_FPU_H__
+#define __DCN302_FPU_H__
+
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params=
 *bw_params);
+
+#endif /* __DCN302_FPU_H__*/
--
2.25.1


--_000_BL1PR12MB514475C66271F7B463003D57F74A9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
: 12pt; color: rgb(0, 0, 0);">
Please fix the patch title.&nbsp; E.g.,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span class=3D"_15gqBTUta5ZVWkGNTkvx90">drm/amdgpu/display: move FPU associ=
ated DCN302 code to DML</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jasdeep Dhillon &lt;jdhillon@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, December 23, 2021 1:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Chiu, Solom=
on &lt;Solomon.Chiu@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&=
gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing (Lillia=
n) &lt;Qingqing.Zhuo@amd.com&gt;; Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.=
com&gt;;
 Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;Roman.Li=
@amd.com&gt;; Anson.Jacob@amd.com &lt;Anson.Jacob@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt=
;; Lipski, Mikita &lt;Mikita.Lipski@amd.com&gt;; Lakha, Bhawanpreet
 &lt;Bhawanpreet.Lakha@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@=
amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac,=
 Pavle &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> [PATCH] SWDEV-311259 - dc: move FPU associated DCN302 code =
to DML</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why &amp; How]<br>
As part of the FPU isolation work documented in<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C01%7C=
alexander.deucher%40amd.com%7C94e344c52d824ae7be1108d9c6432a7a%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637758814062989362%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&=
amp;amp;sdata=3DXPEcMjZOJ4rGxJ9I3p1pQUChzYcNj86oMgyKFEHPXPA%3D&amp;amp;rese=
rved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fpatchwork.freedesktop.org%2Fseries%2F93042%2F&amp;amp;data=3D04%7C01%7Ca=
lexander.deucher%40amd.com%7C94e344c52d824ae7be1108d9c6432a7a%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637758814062989362%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a=
mp;amp;sdata=3DXPEcMjZOJ4rGxJ9I3p1pQUChzYcNj86oMgyKFEHPXPA%3D&amp;amp;reser=
ved=3D0</a>,
 isolate<br>
code that uses FPU in DCN302 to DML, where all FPU code<br>
should locate.<br>
<br>
Signed-off-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
---<br>
&nbsp;CMakeLists.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;dc/dcn302/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 43 ++--<br>
&nbsp;dc/dcn302/dcn302_resource.c | 340 +-------------------------------<br=
>
&nbsp;dc/dcn302/dcn302_resource.h |&nbsp;&nbsp; 3 +<br>
&nbsp;dc/dml/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;dc/dml/dcn302/dcn302_fpu.c&nbsp; | 381 ++++++++++++++++++++++++++++++=
++++++<br>
&nbsp;dc/dml/dcn302/dcn302_fpu.h&nbsp; |&nbsp; 32 +++<br>
&nbsp;7 files changed, 448 insertions(+), 354 deletions(-)<br>
&nbsp;create mode 100644 dc/dml/dcn302/dcn302_fpu.c<br>
&nbsp;create mode 100644 dc/dml/dcn302/dcn302_fpu.h<br>
<br>
diff --git a/CMakeLists.txt b/CMakeLists.txt<br>
index 01c6724df..dfee2cd38 100644<br>
--- a/CMakeLists.txt<br>
+++ b/CMakeLists.txt<br>
@@ -243,6 +243,7 @@ list (APPEND srcs &quot;dc/dcn301/dcn301_hubbub.c&quot;=
)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn302/dcn302_init.c&quot;)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn302/dcn302_hwseq.c&quot;)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn302/dcn302_resource.c&quot;)<br>
+list (APPEND srcs &quot;dc/dml/dcn302/dcn302_fpu.c&quot;)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn303/dcn303_init.c&quot;)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn303/dcn303_hwseq.c&quot;)<br>
&nbsp;list (APPEND srcs &quot;dc/dcn303/dcn303_resource.c&quot;)<br>
diff --git a/dc/dcn302/Makefile b/dc/dcn302/Makefile<br>
index 101620a88..35a6ffbdd 100644<br>
--- a/dc/dcn302/Makefile<br>
+++ b/dc/dcn302/Makefile<br>
@@ -1,42 +1,37 @@<br>
&nbsp;#<br>
&nbsp;# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights rese=
rved<br>
&nbsp;#<br>
-#&nbsp; All rights reserved.&nbsp; This notice is intended as a precaution=
 against<br>
-#&nbsp; inadvertent publication and does not imply publication or any waiv=
er<br>
-#&nbsp; of confidentiality.&nbsp; The year included in the foregoing notic=
e is the<br>
-#&nbsp; year of creation of the work.<br>
-#<br>
&nbsp;#&nbsp; Authors: AMD<br>
&nbsp;#<br>
&nbsp;# Makefile for dcn302.<br>
&nbsp;<br>
&nbsp;DCN3_02 =3D dcn302_init.o dcn302_hwseq.o dcn302_resource.o<br>
&nbsp;<br>
-ifdef CONFIG_X86<br>
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -msse<br>
-endif<br>
+#ifdef CONFIG_X86<br>
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -msse<br>
+#endif<br>
&nbsp;<br>
-ifdef CONFIG_PPC64<br>
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -maltiv=
ec<br>
-endif<br>
+#ifdef CONFIG_PPC64<br>
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o :=3D -mhard-float -malti=
vec<br>
+#endif<br>
&nbsp;<br>
-ifdef CONFIG_CC_IS_GCC<br>
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
-IS_OLD_GCC =3D 1<br>
-endif<br>
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mhard-float<br>
-endif<br>
+#ifdef CONFIG_CC_IS_GCC<br>
+#ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
+#IS_OLD_GCC =3D 1<br>
+#endif<br>
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mhard-float<br>
+#endif<br>
&nbsp;<br>
-ifdef CONFIG_X86<br>
-ifdef IS_OLD_GCC<br>
+#ifdef CONFIG_X86<br>
+#ifdef IS_OLD_GCC<br>
&nbsp;# Stack alignment mismatch, proceed with caution.<br>
&nbsp;# GCC &lt; 7.1 cannot compile code using `double` and -mpreferred-sta=
ck-boundary=3D3<br>
&nbsp;# (8B stack alignment).<br>
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-bo=
undary=3D4<br>
-else<br>
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2<br>
-endif<br>
-endif<br>
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -mpreferred-stack-b=
oundary=3D4<br>
+#else<br>
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o +=3D -msse2<br>
+#endif<br>
+#endif<br>
&nbsp;<br>
&nbsp;AMD_DAL_DCN3_02 =3D $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))<=
br>
&nbsp;<br>
diff --git a/dc/dcn302/dcn302_resource.c b/dc/dcn302/dcn302_resource.c<br>
index a0f02aa9c..8fa290164 100644<br>
--- a/dc/dcn302/dcn302_resource.c<br>
+++ b/dc/dcn302/dcn302_resource.c<br>
@@ -65,6 +65,8 @@<br>
&nbsp;#include &quot;resource.h&quot;<br>
&nbsp;#include &quot;vm_helper.h&quot;<br>
&nbsp;<br>
+#include &quot;dml/dcn302/dcn302_fpu.h&quot;<br>
+<br>
&nbsp;#include &quot;include_legacy/dcn3/sienna_cichlid_ip_offset.h&quot;<b=
r>
&nbsp;#include &quot;include_legacy/dcn302/dcn_3_0_2_offset.h&quot;<br>
&nbsp;#include &quot;include_legacy/dcn302/dcn_3_0_2_sh_mask.h&quot;<br>
@@ -81,164 +83,6 @@<br>
&nbsp;#define DC_LOGGER_INIT(logger)<br>
&nbsp;#endif<br>
&nbsp;<br>
-struct _vcs_dpi_ip_params_st dcn3_02_ip =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_min_dcfclk =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .clamp_min_dcfclk =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .odm_capable =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_enable =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_enable =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_max_page_table_levels =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_max_page_table_levels =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_cached_page_table_levels =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_group_size_bytes =3D 2048,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_dsc =3D 5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .rob_buffer_size_kbytes =3D 184,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .det_buffer_size_kbytes =3D 184,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpte_buffer_size_in_pte_reqs_luma =3D 64,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpte_buffer_size_in_pte_reqs_chroma =3D 34,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pde_proc_buffer_size_64k_reqs =3D 48,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpp_output_buffer_pixels =3D 2560,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .opp_output_buffer_lines =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pixel_chunk_size_kbytes =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_enable =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_page_table_levels =3D 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_chunk_size_kbytes =3D 2,&nbsp; // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .meta_chunk_size_kbytes =3D 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chunk_size_kbytes =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .line_buffer_size_bits =3D 789504,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .is_line_buffer_bpp_fixed =3D 0,&nbsp; // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .line_buffer_fixed_bpp =3D 0,&nbsp;&nbsp;&nbsp;&nbsp; // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcc_supported =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_interface_buffer_size_kbytes =3D 90,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_buffer_size =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_line_buffer_lines =3D 12,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_luma_buffer_size_kbytes =3D 12,&nbsp; // writeback_li=
ne_buffer_buffer_size =3D 656640<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chroma_buffer_size_kbytes =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chroma_line_buffer_width_pixels =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_hscl_ratio =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_vscl_ratio =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_min_hscl_ratio =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_min_vscl_ratio =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_hscl_taps =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_vscl_taps =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_luma_buffer_size =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_chroma_buffer_size =3D 14643,<br>
-#ifdef CONFIG_DRM_AMD_DC_DCN3AG<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_interleave_and_whole_buf =3D false,<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .cursor_buffer_size =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .cursor_chunk_size =3D 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_otg =3D 5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_dpp =3D 5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_wb =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_dchub_pscl_bw_pix_per_clk =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pscl_lb_bw_pix_per_clk =3D 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_lb_vscl_bw_pix_per_clk =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_hscl_bw_pix_per_clk =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_hscl_ratio =3D 6,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_ratio =3D 6,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hscl_mults =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .vscl_mults =3D 4,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_hscl_taps =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_taps =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_ramp_margin_percent =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .underscan_factor =3D 1.11,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .min_vblank_lines =3D 32,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_subtotal =3D 46,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dynamic_metadata_vm_enabled =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_scl_lb_only =3D 16,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_scl =3D 50,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_cnvc_formatter =3D 27,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_cnvc_cursor =3D 6,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_delay_subtotal =3D 119,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcfclk_cstate_latency =3D 5.2, // SRExitTime<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_inter_dcn_tile_repeaters =3D 8,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_hdmi_frl_outputs =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .odm_combine_4to1_supported =3D true,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_supported =3D false,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_fill_bw_overhead_percent =3D 10.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_fill_constant_bytes =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gfx7_compat_tiling_supported =3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .number_of_cursors =3D 1,<br>
-};<br>
-<br>
-struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .clock_limits =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 0,<br>
-#ifdef CONFIG_DAL_PRODUCTION<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1200.0=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 140=
0.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1217.=
0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1217.0=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 16=
000.0,<br>
-#else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 562.0=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 300.0,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 300.0,=
<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_d18_mhz =3D 66=
7.0,<br>
-#ifndef LINUX_DM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1200.0=
,<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 405.6,=
<br>
-#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dtbclk_mhz =3D 1217.0=
,<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFCLK */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_states =3D 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sr_exit_time_us =3D 26.5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sr_enter_plus_exit_time_us =3D 31,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_us =3D 4.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_pixel_data_only_us =3D 4.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_vm_data_only_us =3D 4.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_pixel_only_bytes =3D 409=
6,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =3D 4=
096,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_vm_only_bytes =3D 4096,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 80.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 60.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 40.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_avg_sdp_bw_use_normal_percent =3D 60.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_avg_dram_bw_use_normal_percent =3D 40.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_latency_us =3D 12.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_request_size_bytes =3D 256,<br>
-#ifndef LINUX_DM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_channel_width_bytes =3D 2,<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .fabric_datapath_to_dcn_data_return_bytes =3D 64,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcn_downspread_percent =3D 0.5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .downspread_percent =3D 0.38,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_page_open_time_ns =3D 50.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_rw_turnaround_time_ns =3D 17.5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_return_buffer_per_channel_bytes =3D 8192,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .round_trip_ping_latency_dcfclk_cycles =3D 156,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_bytes =3D 4096,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .channel_interleave_bytes =3D 256,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_banks =3D 8,<br>
-#ifndef LINUX_DM<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_chans =3D 8,<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_min_page_size_bytes =3D 4096,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_min_page_size_bytes =3D 4096,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_clock_change_latency_us =3D 404,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dummy_pstate_latency_us =3D 5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_dram_clock_change_latency_us =3D 23.0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .return_bus_width_bytes =3D 64,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_dppclk_vco_speed_mhz =3D 3650,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_bus_transport_time_us =3D 20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_xbuf_latency_tolerance_us =3D 4,&nbsp; // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_urgent_burst_bw =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .do_urgent_latency_adjustment =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_adjustment_fabric_clock_component_us =3D 1.0,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 1000,<=
br>
-};<br>
-<br>
&nbsp;static const struct dc_debug_options debug_defaults_drv =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_dmcu =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .force_abm_enable =3D false,<br>
@@ -1271,7 +1115,9 @@ static bool init_soc_bounding_box(struct dc *dc,&nbsp=
; struct resource_pool *pool)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loaded_ip-&gt;max_num_otg =
=3D pool-&gt;pipe_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loaded_ip-&gt;max_num_dpp =
=3D pool-&gt;pipe_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loaded_ip-&gt;clamp_min_dc=
fclk =3D dc-&gt;config.clamp_min_dcfclk;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_patch_bounding_box(d=
c, loaded_bb);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
&nbsp;#ifdef CONFIG_DRM_AMD_DC_DCN3AG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;config.host_vm_=
min_page_size !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; loaded_bb-&gt;hostvm_min_page_size_bytes =3D dc-&gt;c=
onfig.host_vm_min_page_size;<br>
@@ -1285,17 +1131,10 @@ static bool init_soc_bounding_box(struct dc *dc,&nb=
sp; struct resource_pool *pool)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;funcs-&gt;get_soc_bb_i=
nfo(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dc-&gt;ctx-&gt;dc_bios, &amp;bb_info) =3D=3D BP_RESULT_O=
K) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_clock_change_latency_100ns &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dram_clock_change_latency_us =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_clock_change_latency_100ns * 10;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_enter_exit_latency_100ns &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_enter_plus_exit_time_us =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_enter_exit_latency_100ns * 10;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_exit_latency_100ns &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_exit_time_us =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_exit_latency_100ns * 10;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn302_fpu_init_soc_bounding_box(bb_info);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1450,170 +1289,11 @@ static void dcn302_destroy_resource_pool(struct re=
source_pool **pool)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pool =3D NULL;<br>
&nbsp;}<br>
&nbsp;<br>
-static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int *optimal_dcfclk,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int *optimal_fclk)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double bw_from_dram, bw_from_dram1, b=
w_from_dram2;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram1 =3D uclk_mts * dcn3_02_=
soc.num_chans *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_dram=
_bw_use_normal_percent / 100);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram2 =3D uclk_mts * dcn3_02_=
soc.num_chans *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_sdp_=
bw_use_normal_percent / 100);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram =3D (bw_from_dram1 &lt; =
bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_fclk)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *optimal_fclk =3D bw_from_dram /<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (dcn3_02_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_02=
_soc.max_avg_sdp_bw_use_normal_percent / 100));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_dcfclk)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *optimal_dcfclk =3D&nbsp; bw_from_dram /<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (dcn3_02_soc.return_bus_width_bytes * (dcn3_02_soc.max_avg_sdp_b=
w_use_normal_percent / 100));<br>
-}<br>
-<br>
&nbsp;void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_param=
s *bw_params)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, j;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_states =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_mhz[DC__VOLTAGE_S=
TATES] =3D {0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dram_speed_mts[DC__VOLTA=
GE_STATES] =3D {0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_uclk_for_dcfclk_=
sta_targets[DC__VOLTAGE_STATES] =3D {0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_dcfclk_for_uclk[=
DC__VOLTAGE_STATES] =3D {0};<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_sta_targets[DC__V=
OLTAGE_STATES] =3D {694, 875, 1000, 1200};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dcfclk_sta_targets =
=3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_uclk_states;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vram_i=
nfo.num_chans)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.num_chans =3D dc-&gt;ctx-&gt;dc_bios-&gt;vram_info.n=
um_chans;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vram_i=
nfo.dram_channel_width_bytes)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes =3D dc-&gt;ctx-&gt;dc_bios-=
&gt;vram_info.dram_channel_width_bytes;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dispclk_dppclk_vco_speed_=
mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dppclk_vco_spe=
ed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&gt;clk_table.entries[0=
].memclk_mhz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int max_dcfclk_mhz =3D 0, max_dispclk_mhz =3D 0, max_dppclk_mhz =
=3D 0, max_phyclk_mhz =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM_DPM_LVL; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dcfclk_mhz &gt; max_dcfclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dcfclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dispclk_mhz &gt; max_dispclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dispclk_mhz =3D bw_params-&gt;clk_table=
.entries[i].dispclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dppclk_mhz &gt; max_dppclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dppclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].dppclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].phyclk_mhz &gt; max_phyclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_phyclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].phyclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dcfclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dcfclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dispclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dispclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dispclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dppclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dppclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dppclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_phyclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_phyclk_mhz =
=3D dcn3_02_soc.clock_limits[0].phyclk_mhz;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (max_dcfclk_mhz &gt; dcfclk_sta_targets[num_dcfclk_sta_target=
s-1]) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If max DCFCLK=
 is greater than the max DCFCLK STA target, insert into the DCFCLK STA targ=
et array */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_sta_targe=
ts[num_dcfclk_sta_targets] =3D max_dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_sta_t=
argets++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (max_dcfclk_mhz &lt; dcfclk_sta_targets[num_dcfclk_sta=
_targets-1]) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If max DCFCLK=
 is less than the max DCFCLK STA target, cap values and remove duplicates *=
/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; num_dcfclk_sta_targets; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &gt; max_dcfclk_m=
hz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dcfclk_sta_targets[i] =3D max_dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update size o=
f array since we &quot;removed&quot; duplicates */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_sta_t=
argets =3D i + 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; num_uclk_states =3D bw_params-&gt;clk_table.num_entries;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Calculate optimal dcfclk for each uclk */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_uclk_states; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn302_get_optim=
al_dcfclk_fclk_for_uclk(bw_params-&gt;clk_table.entries[i].memclk_mhz * 16,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;optimal_dcfclk_for_uclk[i], NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_dcfc=
lk_for_uclk[i] &lt; bw_params-&gt;clk_table.entries[0].dcfclk_mhz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[i] =3D bw_params-&g=
t;clk_table.entries[0].dcfclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Calculate optimal uclk for each dcfclk sta target */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_dcfclk_sta_targets; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; num_uclk_states; j++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &lt; optimal_dcfc=
lk_for_uclk[j]) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; optimal_uclk_for_dcfclk_sta_targets[i] =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; bw_params-&gt;clk_table.entries[j].memclk_mhz * 1=
6;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* create the final dcfclk and uclk table */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; j &lt; num_uclk_=
states &amp;&amp; num_states &lt; DC__VOLTAGE_STATES) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_t=
argets[i] &lt; optimal_dcfclk_for_uclk[j] &amp;&amp; i &lt; num_dcfclk_sta_=
targets) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_states] =3D dcfclk_sta_targe=
ts[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[num_states++] =3D optimal_uc=
lk_for_dcfclk_sta_targets[i++];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &lt; num_uclk_states &amp;&amp; optim=
al_dcfclk_for_uclk[j] &lt;=3D max_dcfclk_mhz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dram_speed_mts[num_states++] =3D bw_params-&gt;clk_table.entries[j++].=
memclk_mhz * 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; j =3D num_uclk_states;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; num_states &lt; =
DC__VOLTAGE_STATES) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_s=
tates] =3D dcfclk_sta_targets[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[n=
um_states++] =3D optimal_uclk_for_dcfclk_sta_targets[i++];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (j &lt; num_uclk_states &amp;&amp; num_states &lt; DC__VOL=
TAGE_STATES &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[j] &lt;=3D max_dcfc=
lk_mhz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_s=
tates] =3D optimal_dcfclk_for_uclk[j];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[n=
um_states++] =3D bw_params-&gt;clk_table.entries[j++].memclk_mhz * 16;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.num_states =3D num_states;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; dcn3_02_soc.num_states; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].state =3D i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dcfclk_mhz =3D dcfclk_mhz[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].fabricclk_mhz =3D dcfclk_mhz[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dram_speed_mts =3D dram_speed_mts[i];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill all stat=
es with max values of all other clocks */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dispclk_mhz =3D max_dispclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dppclk_mhz&nbsp; =3D max_dppclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].phyclk_mhz&nbsp; =3D max_phyclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Populate from=
 bw_params for DTBCLK, SOCCLK */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bw_params-&=
gt;clk_table.entries[i].dtbclk_mhz &amp;&amp; i &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].dtbclk_mhz&nbsp=
; =3D dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].dtbclk_mhz&nbsp=
; =3D bw_params-&gt;clk_table.entries[i].dtbclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bw_params-&=
gt;clk_table.entries[i].socclk_mhz &amp;&amp; i &gt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
dcn3_02_soc.clock_limits[i-1].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
bw_params-&gt;clk_table.entries[i].socclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* These clocks =
cannot come from bw_params, always fill from dcn3_02_soc[1] */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FCLK, PHYCLK_=
D18, DSCCLK */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].phyclk_d18_mhz =3D dcn3_02_soc.clock_limits[0].phyclk_d18_mhz;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dscclk_mhz =3D dcn3_02_soc.clock_limits[0].dscclk_mhz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* re-init DML with updated bb */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_init_instance(&amp;dc-&gt;dml, &amp;dcn3_02_soc, &amp;dcn3_0=
2_ip, DML_PROJECT_DCN30);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dc-&gt;current_state)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_init_instanc=
e(&amp;dc-&gt;current_state-&gt;bw_ctx.dml, &amp;dcn3_02_soc, &amp;dcn3_02_=
ip, DML_PROJECT_DCN30);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn302_fpu_update_bw_bounding_box(dc,=
 bw_params);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static struct resource_funcs dcn302_res_pool_funcs =3D {<br>
diff --git a/dc/dcn302/dcn302_resource.h b/dc/dcn302/dcn302_resource.h<br>
index 42d2c73e3..9f24e73b9 100644<br>
--- a/dc/dcn302/dcn302_resource.h<br>
+++ b/dc/dcn302/dcn302_resource.h<br>
@@ -28,6 +28,9 @@<br>
&nbsp;<br>
&nbsp;#include &quot;core_types.h&quot;<br>
&nbsp;<br>
+extern struct _vcs_dpi_ip_params_st dcn3_02_ip;<br>
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc;<br>
+<br>
&nbsp;struct resource_pool *dcn302_create_resource_pool(const struct dc_ini=
t_data *init_data, struct dc *dc);<br>
&nbsp;<br>
&nbsp;void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_param=
s *bw_params);<br>
diff --git a/dc/dml/Makefile b/dc/dml/Makefile<br>
index d8e03ca15..f55f28fe3 100644<br>
--- a/dc/dml/Makefile<br>
+++ b/dc/dml/Makefile<br>
@@ -73,6 +73,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/frl_cap_chk_30.o :=3D $=
(dml_ccflags)<br>
&nbsp;#endif<br>
&nbsp;endif<br>
&nbsp;CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o :=3D $(dml_ccflags)<b=
r>
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o :=3D $(dml_ccflags)<br>
&nbsp;ifdef CONFIG_DRM_AMD_DC_DCN3_1<br>
&nbsp;CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=3D $(dml_cc=
flags) -Wframe-larger-than=3D2048<br>
&nbsp;CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D $(dml=
_ccflags)<br>
@@ -103,6 +104,7 @@ DML +=3D dcn30/frl_cap_chk_30.o<br>
&nbsp;#endif<br>
&nbsp;endif<br>
&nbsp;DML +=3D dcn301/dcn301_fpu.o<br>
+DML +=3D dcn302/dcn302_fpu.o<br>
&nbsp;ifdef CONFIG_DRM_AMD_DC_DCN3_1<br>
&nbsp;DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o<b=
r>
&nbsp;endif<br>
diff --git a/dc/dml/dcn302/dcn302_fpu.c b/dc/dml/dcn302/dcn302_fpu.c<br>
new file mode 100644<br>
index 000000000..97d9dc80b<br>
--- /dev/null<br>
+++ b/dc/dml/dcn302/dcn302_fpu.c<br>
@@ -0,0 +1,381 @@<br>
+/*<br>
+ * Copyright 2020 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ * Authors: AMD<br>
+ *<br>
+ */<br>
+<br>
+#include &quot;resource.h&quot;<br>
+#include &quot;clk_mgr.h&quot;<br>
+#include &quot;dcn20/dcn20_resource.h&quot;<br>
+#include &quot;dcn302/dcn302_resource.h&quot;<br>
+<br>
+#include &quot;dml/dcn20/dcn20_fpu.h&quot;<br>
+#include &quot;dcn302_fpu.h&quot;<br>
+<br>
+struct _vcs_dpi_ip_params_st dcn3_02_ip =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_min_dcfclk =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .clamp_min_dcfclk =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .odm_capable =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_enable =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_enable =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_max_page_table_levels =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_max_page_table_levels =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_cached_page_table_levels =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_group_size_bytes =3D 2048,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_dsc =3D 5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .rob_buffer_size_kbytes =3D 184,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .det_buffer_size_kbytes =3D 184,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpte_buffer_size_in_pte_reqs_luma =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpte_buffer_size_in_pte_reqs_chroma =3D 34,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pde_proc_buffer_size_64k_reqs =3D 48,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dpp_output_buffer_pixels =3D 2560,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .opp_output_buffer_lines =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pixel_chunk_size_kbytes =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_enable =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_page_table_levels =3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pte_chunk_size_kbytes =3D 2,&nbsp; // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .meta_chunk_size_kbytes =3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chunk_size_kbytes =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .line_buffer_size_bits =3D 789504,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .is_line_buffer_bpp_fixed =3D 0,&nbsp; // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .line_buffer_fixed_bpp =3D 0,&nbsp;&nbsp;&nbsp;&nbsp; // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcc_supported =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_interface_buffer_size_kbytes =3D 90,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_buffer_size =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_line_buffer_lines =3D 12,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_luma_buffer_size_kbytes =3D 12,&nbsp; // writeback_li=
ne_buffer_buffer_size =3D 656640<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chroma_buffer_size_kbytes =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_chroma_line_buffer_width_pixels =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_hscl_ratio =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_vscl_ratio =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_min_hscl_ratio =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_min_vscl_ratio =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_hscl_taps =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_max_vscl_taps =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_luma_buffer_size =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_line_buffer_chroma_buffer_size =3D 14643,<br>
+#ifdef CONFIG_DRM_AMD_DC_DCN3AG<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_interleave_and_whole_buf =3D false,<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .cursor_buffer_size =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .cursor_chunk_size =3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_otg =3D 5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_dpp =3D 5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_wb =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_dchub_pscl_bw_pix_per_clk =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_pscl_lb_bw_pix_per_clk =3D 2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_lb_vscl_bw_pix_per_clk =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_hscl_bw_pix_per_clk =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_hscl_ratio =3D 6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_ratio =3D 6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hscl_mults =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .vscl_mults =3D 4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_hscl_taps =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_vscl_taps =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_ramp_margin_percent =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .underscan_factor =3D 1.11,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .min_vblank_lines =3D 32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_subtotal =3D 46,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dynamic_metadata_vm_enabled =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_scl_lb_only =3D 16,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_scl =3D 50,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_cnvc_formatter =3D 27,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dppclk_delay_cnvc_cursor =3D 6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_delay_subtotal =3D 119,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcfclk_cstate_latency =3D 5.2, // SRExitTime<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_inter_dcn_tile_repeaters =3D 8,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_num_hdmi_frl_outputs =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .odm_combine_4to1_supported =3D true,<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_supported =3D false,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_fill_bw_overhead_percent =3D 10.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_fill_constant_bytes =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gfx7_compat_tiling_supported =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .number_of_cursors =3D 1,<br>
+};<br>
+<br>
+struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .clock_limits =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .state =3D 0,<br>
+#ifdef CONFIG_DAL_PRODUCTION<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcfclk_mhz =3D 1200.0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabricclk_mhz =3D 140=
0.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 1217.=
0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 1217.0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 810.0,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_speed_mts =3D 16=
000.0,<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dispclk_mhz =3D 562.0=
,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dppclk_mhz =3D 300.0,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_mhz =3D 300.0,=
<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .phyclk_d18_mhz =3D 66=
7.0,<br>
+#ifndef LINUX_DM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .socclk_mhz =3D 1200.0=
,<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dscclk_mhz =3D 405.6,=
<br>
+#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dtbclk_mhz =3D 1217.0=
,<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFCLK */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_states =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sr_exit_time_us =3D 26.5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .sr_enter_plus_exit_time_us =3D 31,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_us =3D 4.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_pixel_data_only_us =3D 4.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_vm_data_only_us =3D 4.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_pixel_only_bytes =3D 409=
6,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_pixel_and_vm_bytes =3D 4=
096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_vm_only_bytes =3D 4096,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_pixel_only =3D 80.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm =3D 60.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .pct_ideal_dram_sdp_bw_after_urgent_vm_only =3D 40.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_avg_sdp_bw_use_normal_percent =3D 60.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_avg_dram_bw_use_normal_percent =3D 40.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_latency_us =3D 12.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .max_request_size_bytes =3D 256,<br>
+#ifndef LINUX_DM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_channel_width_bytes =3D 2,<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .fabric_datapath_to_dcn_data_return_bytes =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dcn_downspread_percent =3D 0.5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .downspread_percent =3D 0.38,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_page_open_time_ns =3D 50.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_rw_turnaround_time_ns =3D 17.5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_return_buffer_per_channel_bytes =3D 8192,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .round_trip_ping_latency_dcfclk_cycles =3D 156,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_out_of_order_return_per_channel_bytes =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .channel_interleave_bytes =3D 256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_banks =3D 8,<br>
+#ifndef LINUX_DM<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .num_chans =3D 8,<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .gpuvm_min_page_size_bytes =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .hostvm_min_page_size_bytes =3D 4096,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dram_clock_change_latency_us =3D 404,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dummy_pstate_latency_us =3D 5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .writeback_dram_clock_change_latency_us =3D 23.0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .return_bus_width_bytes =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .dispclk_dppclk_vco_speed_mhz =3D 3650,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_bus_transport_time_us =3D 20,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .xfc_xbuf_latency_tolerance_us =3D 4,&nbsp; // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_urgent_burst_bw =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .do_urgent_latency_adjustment =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_adjustment_fabric_clock_component_us =3D 1.0,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .urgent_latency_adjustment_fabric_clock_reference_mhz =3D 1000,<=
br>
+};<br>
+<br>
+static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *optimal_dcfclk,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *optimal_fclk)<br>
+{<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double bw_from_d=
ram, bw_from_dram1, bw_from_dram2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram1 =
=3D uclk_mts * dcn3_02_soc.num_chans *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.max_avg_dram_bw_use_normal_per=
cent / 100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram2 =
=3D uclk_mts * dcn3_02_soc.num_chans *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.max_avg_sdp_bw_use_normal_perc=
ent / 100);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram =3D=
 (bw_from_dram1 &lt; bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_fclk=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optimal_fclk =3D bw_from_dram /<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.fabric_datapath_to_dcn_data_re=
turn_bytes *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.max_avg_sdp_bw_use_norma=
l_percent / 100));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_dcfc=
lk)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *optimal_dcfclk =3D&nbsp; bw_from_dram /<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.return_bus_width_bytes *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dcn3_02_soc.max_avg_sdp_bw_use_norma=
l_percent / 100));<br>
+}<br>
+<br>
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params=
 *bw_params)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, j;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_states =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_mhz[DC__VOLTAGE_S=
TATES] =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dram_speed_mts[DC__VOLTA=
GE_STATES] =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_uclk_for_dcfclk_=
sta_targets[DC__VOLTAGE_STATES] =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_dcfclk_for_uclk[=
DC__VOLTAGE_STATES] =3D {0};<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_sta_targets[DC__V=
OLTAGE_STATES] =3D {694, 875, 1000, 1200};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dcfclk_sta_targets =
=3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_uclk_states;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vram_i=
nfo.num_chans)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.num_chans =3D dc-&gt;ctx-&gt;dc_bios-&gt;vram_info.n=
um_chans;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vram_i=
nfo.dram_channel_width_bytes)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.dram_channel_width_bytes =3D dc-&gt;ctx-&gt;dc_bios-=
&gt;vram_info.dram_channel_width_bytes;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dispclk_dppclk_vco_speed_=
mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dppclk_vco_spe=
ed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&gt;clk_table.entries[0=
].memclk_mhz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int max_dcfclk_mhz =3D 0, max_dispclk_mhz =3D 0, max_dppclk_mhz =
=3D 0, max_phyclk_mhz =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; MAX_NUM_DPM_LVL; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dcfclk_mhz &gt; max_dcfclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dcfclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dispclk_mhz &gt; max_dispclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dispclk_mhz =3D bw_params-&gt;clk_table=
.entries[i].dispclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].dppclk_mhz &gt; max_dppclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dppclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].dppclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&g=
t;clk_table.entries[i].phyclk_mhz &gt; max_phyclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_phyclk_mhz =3D bw_params-&gt;clk_table.=
entries[i].phyclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dcfclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dcfclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dispclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dispclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dispclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_dppclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_dppclk_mhz =
=3D dcn3_02_soc.clock_limits[0].dppclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!max_phyclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_phyclk_mhz =
=3D dcn3_02_soc.clock_limits[0].phyclk_mhz;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (max_dcfclk_mhz &gt; dcfclk_sta_targets[num_dcfclk_sta_target=
s-1]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If max DCFCLK=
 is greater than the max DCFCLK STA target, insert into the DCFCLK STA targ=
et array */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_sta_targe=
ts[num_dcfclk_sta_targets] =3D max_dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_sta_t=
argets++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (max_dcfclk_mhz &lt; dcfclk_sta_targets[num_dcfclk_sta=
_targets-1]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If max DCFCLK=
 is less than the max DCFCLK STA target, cap values and remove duplicates *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; num_dcfclk_sta_targets; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &gt; max_dcfclk_m=
hz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dcfclk_sta_targets[i] =3D max_dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update size o=
f array since we &quot;removed&quot; duplicates */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_sta_t=
argets =3D i + 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; num_uclk_states =3D bw_params-&gt;clk_table.num_entries;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Calculate optimal dcfclk for each uclk */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_uclk_states; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn302_get_optim=
al_dcfclk_fclk_for_uclk(bw_params-&gt;clk_table.entries[i].memclk_mhz * 16,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;optimal_dcfclk_for_uclk[i], NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_dcfc=
lk_for_uclk[i] &lt; bw_params-&gt;clk_table.entries[0].dcfclk_mhz)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[i] =3D bw_params-&g=
t;clk_table.entries[0].dcfclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Calculate optimal uclk for each dcfclk sta target */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; num_dcfclk_sta_targets; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j =
&lt; num_uclk_states; j++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &lt; optimal_dcfc=
lk_for_uclk[j]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; optimal_uclk_for_dcfclk_sta_targets[i] =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; bw_params-&gt;clk_table.entries[j].memclk_mhz * 1=
6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; j =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* create the final dcfclk and uclk table */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; j &lt; num_uclk_=
states &amp;&amp; num_states &lt; DC__VOLTAGE_STATES) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_t=
argets[i] &lt; optimal_dcfclk_for_uclk[j] &amp;&amp; i &lt; num_dcfclk_sta_=
targets) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_states] =3D dcfclk_sta_targe=
ts[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[num_states++] =3D optimal_uc=
lk_for_dcfclk_sta_targets[i++];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &lt; num_uclk_states &amp;&amp; optim=
al_dcfclk_for_uclk[j] &lt;=3D max_dcfclk_mhz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[j];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dram_speed_mts[num_states++] =3D bw_params-&gt;clk_table.entries[j++].=
memclk_mhz * 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; j =3D num_uclk_states;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; num_states &lt; =
DC__VOLTAGE_STATES) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_s=
tates] =3D dcfclk_sta_targets[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[n=
um_states++] =3D optimal_uclk_for_dcfclk_sta_targets[i++];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (j &lt; num_uclk_states &amp;&amp; num_states &lt; DC__VOL=
TAGE_STATES &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[j] &lt;=3D max_dcfc=
lk_mhz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_s=
tates] =3D optimal_dcfclk_for_uclk[j];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[n=
um_states++] =3D bw_params-&gt;clk_table.entries[j++].memclk_mhz * 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_02_soc.num_states =3D num_states;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; dcn3_02_soc.num_states; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].state =3D i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dcfclk_mhz =3D dcfclk_mhz[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].fabricclk_mhz =3D dcfclk_mhz[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dram_speed_mts =3D dram_speed_mts[i];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill all stat=
es with max values of all other clocks */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dispclk_mhz =3D max_dispclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dppclk_mhz&nbsp; =3D max_dppclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].phyclk_mhz&nbsp; =3D max_phyclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Populate from=
 bw_params for DTBCLK, SOCCLK */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bw_params-&=
gt;clk_table.entries[i].dtbclk_mhz &amp;&amp; i &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].dtbclk_mhz&nbsp=
; =3D dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].dtbclk_mhz&nbsp=
; =3D bw_params-&gt;clk_table.entries[i].dtbclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bw_params-&=
gt;clk_table.entries[i].socclk_mhz &amp;&amp; i &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
dcn3_02_soc.clock_limits[i-1].socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.clock_limits[i].socclk_mhz =3D =
bw_params-&gt;clk_table.entries[i].socclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* These clocks =
cannot come from bw_params, always fill from dcn3_02_soc[1] */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FCLK, PHYCLK_=
D18, DSCCLK */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].phyclk_d18_mhz =3D dcn3_02_soc.clock_limits[0].phyclk_d18_mhz;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.cloc=
k_limits[i].dscclk_mhz =3D dcn3_02_soc.clock_limits[0].dscclk_mhz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* re-init DML with updated bb */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dml_init_instance(&amp;dc-&gt;dml, &amp;dcn3_02_soc, &amp;dcn3_0=
2_ip, DML_PROJECT_DCN30);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dc-&gt;current_state)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dml_init_instanc=
e(&amp;dc-&gt;current_state-&gt;bw_ctx.dml, &amp;dcn3_02_soc, &amp;dcn3_02_=
ip, DML_PROJECT_DCN30);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)<br>
+{<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_ena=
bled();<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_clock_change_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.dram_clock_change_latency_us =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_clock_change_latency_100ns * 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_enter_exit_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_enter_plus_exit_time_us =3D<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_enter_exit_latency_100ns * 10;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bb_info.dram=
_sr_exit_latency_100ns &gt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_02_soc.sr_exit_time_us =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bb_info.dram_sr_exit_latency_100ns * 10;<br>
+}<br>
+<br>
+<br>
diff --git a/dc/dml/dcn302/dcn302_fpu.h b/dc/dml/dcn302/dcn302_fpu.h<br>
new file mode 100644<br>
index 000000000..548305d96<br>
--- /dev/null<br>
+++ b/dc/dml/dcn302/dcn302_fpu.h<br>
@@ -0,0 +1,32 @@<br>
+/*<br>
+ * Copyright 2019-2021 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ * Authors: AMD<br>
+ *<br>
+ */<br>
+<br>
+#ifndef __DCN302_FPU_H__<br>
+#define __DCN302_FPU_H__<br>
+<br>
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);<br>
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params=
 *bw_params);<br>
+<br>
+#endif /* __DCN302_FPU_H__*/<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514475C66271F7B463003D57F74A9BL1PR12MB5144namp_--
