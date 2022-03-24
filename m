Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F136C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 11:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0547F10E888;
	Thu, 24 Mar 2022 11:41:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA7C10E888
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 11:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LytotMs0ITHP4uoLaeErTQayrq0jLXSf71Ds/koD354QjlV3qyhsubwcxhYgw8oHKfUpiTBRoRRyZ9LZEYEetuTQD15xUqy874oBHHT1ifUSdXVSIjdfx49fm/Auj1vWpZDmr+ZaE7eBgcrT8ORvO7WtdTeFfMWNY7LczAg4ncG0g+M/jVCf+e5Ch4/VOVKHyUnipDNwhJM5wpJ0OMT7dXk/8w9Chn86BsR6ZoWAyiZApDszeoxcZPKsndv2CfesxmERW53PTHx2FAGtcD0KVz24mtpApsPcaz+3AIOL/cUnWRjGKXZ2eiNDCfRQadQHVduwk76/V/HVf2Uy9EpaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDc1qzwgsTFiE4PPlHtx7P3Ni1oy3lAb+KHhxT7ZU5g=;
 b=nX+Z79wpx9uoCg4RbUZVAiUmkEeZ0oYadVBiSxs2+vmIuCtma7vu5oSa0Me+oyPb83nhWk7IawT9/0yjqtj4u+ykwRrLplWC/ANSwW63WhWhTn0ZBBbSSB6b+qxBR0tF2g7xIJlZkBn89UiCZla7iqkYmuvepGnSpjXLoEL6YnhuWMI5QBhkSfZxD3D68pr6ZDFuVs9LXmErFdPRzsxdZ8fyx8gGj1e1xdwhBsI8AMnZaNFoR+YId7NL+SOxyr4MDU2gCVEK9DG7r1Qc0L2Gw9JaFkLIPBTcTW7vbgIYVL5vtx4cQXNm0u+E110R5z7HBQBnFWHgzoR9ZTxtR83oMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDc1qzwgsTFiE4PPlHtx7P3Ni1oy3lAb+KHhxT7ZU5g=;
 b=B97U+qsf60rLuHmP3lYEOIo3Sx1b4Uh99jIg5MhfDu0tEKhSVbT23XHvnQq9wsvvqUpa9yd+8Ci5Np31pOafbNZcACZCzQDmg96vvX4RoG+S/n7oCN6ziK6dOpCAFQH9IFUX3hvqi8HayHs1ZNPgaprt091QXuovvVAKH+He2Mg=
Received: from DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20)
 by MWHPR1201MB0141.namprd12.prod.outlook.com (2603:10b6:301:56::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19; Thu, 24 Mar
 2022 11:41:41 +0000
Received: from DM5PR1201MB0186.namprd12.prod.outlook.com
 ([fe80::40dc:7c38:6473:74d]) by DM5PR1201MB0186.namprd12.prod.outlook.com
 ([fe80::40dc:7c38:6473:74d%8]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 11:41:41 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Chauhan, Ikshwaku" <Ikshwaku.Chauhan@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Program color range and encoding
 correctly for DCN2+
Thread-Topic: [PATCH] drm/amd/display: Program color range and encoding
 correctly for DCN2+
Thread-Index: AQHYPvo2rljFBymXVUaowAHTNuDOLqzOHwqAgABK+PA=
Date: Thu, 24 Mar 2022 11:41:40 +0000
Message-ID: <DM5PR1201MB01865C2A704385B7E8C84D0DFD199@DM5PR1201MB0186.namprd12.prod.outlook.com>
References: <20220323210845.182507-1-harry.wentland@amd.com>
 <BL1PR12MB5176D4F2B0390A8E87BE2F239A199@BL1PR12MB5176.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5176D4F2B0390A8E87BE2F239A199@BL1PR12MB5176.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-24T06:42:50Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3312a951-2a4d-4dd0-8d83-7c56e5545710;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a403fb5b-34d7-442e-fd84-08da0d8b4380
x-ms-traffictypediagnostic: MWHPR1201MB0141:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0141BF04128FEAFC0717F353FD199@MWHPR1201MB0141.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIKkHD3ZIX+tUMH3oUZUig8FPuR1VD5Du4Fi34l/V+8gJIFUuKg01gTp4E4pTR8gVGHmWKyfwwsjsSWdqQ3boOAvma7DuXFB950q/Q2hSKPM6eUIhN6p6XMx8pvOE59OLWCQds+5egqU125qCoo/bUHVG4yNlMHj3b7BDTMQVG0YC9l+s9IzZ21ywMdha9jUHkmhYeIngOdiUDIQ627h+VrrRZ8zv25IX3ktpOQ91osJZ7BVY1v1LpTDxqSUNSLSHaOuHkh9MwXPpdtfghOhy08n0ZM8VtyXtiucdL8XYwYiKI6nfHZSuvGmevIen6b+LZTPS+s8C+ZKA3IqRJC6BTF7peM8/uUtvdAoJ7t7a2LGLYfO1GQ2WXzJwSSwAr90cJp/rgccPUwQ9/dOfnoUq/hHliPSTj2kpRPV1E8nSDFnu9p3VKWBMk6i614N5FhVMGS0xgPqBEMe75vYB8XEJDedogUMLl/k/clVBm4GkCcJPT6EqO9SXmjUV1jfjFZq5cnYq5B3BaxrRS2oRkncAe9nVIBgiaIhDs34A3XoDgzLoCQ3OpLCJSE7Xa2FOU8OK/ZnFvUqsGFCMRjJt6z0Q7X658qbgNd6wmHEEcvMhSp2j+9D5quLPeUUxgeIqeKWf1Kw933LUANatiOp60SjfCdztjz5Z/ZXtOUTSj6m6yi2bkCT5OWvory3MYHaWkYL2ofdppWPP5YGSd/9wYzPAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0186.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(83380400001)(66446008)(64756008)(110136005)(316002)(54906003)(76116006)(66476007)(66556008)(38070700005)(66946007)(4326008)(71200400001)(8676002)(9686003)(508600001)(52536014)(86362001)(33656002)(5660300002)(8936002)(122000001)(55016003)(38100700002)(7696005)(6506007)(53546011)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FWUeY3T0Gvu9gda/h7jR1avl4nZ1BuwduMwdDVUq3+CgbcWxU/2jx4jivUYO?=
 =?us-ascii?Q?4eXHeOFxVRd2E8jN+tnpS5alFRDTigfBqCnfnAuhJHJYuTGXxwoKQvG2r6E7?=
 =?us-ascii?Q?3GkSg8uO44EVRuTZr0hWB6xXu9D/vGO6guBtWybfKjr1kK7+5skezHokuDrC?=
 =?us-ascii?Q?4MItfAh8J8qkdQEAO1jELCruiGWDshuTaCaa6Rk++o32Ys5bREm3bfzgb6CB?=
 =?us-ascii?Q?ua+WG3mTe9Sk3JTvaKFBI5qcIw6TgQg/XndP4bErAwJV/t9cPzApdVR6UL0X?=
 =?us-ascii?Q?rchPa8nBcptzzW4vp9raVzuC0M0S2BKFVtQd8XgnIjs2msfyz01Vahc14AVy?=
 =?us-ascii?Q?WKct50GTOUJyu6jkta9Ea/SP7njTcJ8vTY387M7eSMm3XG4xK29wZf8eM9Z+?=
 =?us-ascii?Q?yMZG+p6VDWR09P85aQt/KifLkii9et8BLGcem7epKzNbI/8sXzLbE/DydkZw?=
 =?us-ascii?Q?ajqSzNS++Ml4cCv8zKxeiDNH05pDJs0x7P/tpVn7SIotIUlHFkj0SFmgmF2Q?=
 =?us-ascii?Q?9jjd73YbYNN1daaUKvX/xW2uW5l4m1iEJzk2YFTYlY0wXtOffg/6N9iZZ1u1?=
 =?us-ascii?Q?fGvBFEypLqMCP4dguzyjqSC6YABX0H1amTrvXDJ9PAO1c6Xnt85KqyFxlPU7?=
 =?us-ascii?Q?vrJ+qWaRs8sfrGTvC/iCkljDi/y5gKCoa6wLy+TSx1Jb8skkrBCjbOFz1MTQ?=
 =?us-ascii?Q?SYDAq1lFa2/Qeo3zswgHs7uivQsD6E5/v8i9GKXeg4evzsxWKSvAOgbhkCqd?=
 =?us-ascii?Q?J+P/RzzjmNL80b3l3w7mNNz3QmqjnZoIufubi3oBOnqK7GGEHb7mVnAXoJj3?=
 =?us-ascii?Q?gKTUOolYFmxP2EvV9fXAyi3iwMwQ5jlmLw1efB9t+sS8zoeeoc6msA5GhYLT?=
 =?us-ascii?Q?1KAT5uH8j8Av7Su5G5QtOxDisZ/4wLG5t2dkXi1k1fH/RTejB33gbGPh0t7v?=
 =?us-ascii?Q?2zBHu07taOluLjA7VgAApw6vOf2hK01u0S3P7hobYoJ183P/jw+R8DDem5KZ?=
 =?us-ascii?Q?tEOwbOkbRzZF9s+VZF9TTTHFq41tQonyoufUcsMM5gQW79wv2vumQX4miyUm?=
 =?us-ascii?Q?7X1YXhXj1ceNyqzv4PUmzko+xw3DMNFCV1JzCYv0mAjUSEEEHK7km5K5BRQz?=
 =?us-ascii?Q?qV/z3sNopR2/TStL4rVkyQG6xuQvzvUj35R/BPRWK1MZ0LYDwPbqFWzLaNvq?=
 =?us-ascii?Q?8HAX4tCp2frEons8nHtQXe18shWl2uFGfrlpiwKa1l2un3ALpjAlJi3EMmij?=
 =?us-ascii?Q?1Y1x7m5sCRPtVx+aJ3dC+WHLtqFwBfl+f3WB3Cp+lBXcZEkQ+AWZJLQzCJ+1?=
 =?us-ascii?Q?by/ilADzqeM5elW8FPC8jbEueVCugi0qNV8qPOJ5wwU+VGNsL/S3IKduA06P?=
 =?us-ascii?Q?j921dWOODGxAiQ819zrgS3kLHGW5NM6PrpfJOSiF9i4+U6xH9MbLgg+UDfHk?=
 =?us-ascii?Q?e+ebt6VMDMYNeQZ4ohiFLB68W1imgDAr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a403fb5b-34d7-442e-fd84-08da0d8b4380
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 11:41:40.9238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7+8VXh5wwueKbO5J2l/H0kLjUmYp3EPR6ATnRoAYXQPA5iY6TZC7wruKVPDmi2dHjs3GP9YDQC4mCj6HzWrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0141
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
Cc: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hersen Wu <Hersenxs.Wu@amd.com>


-----Original Message-----
From: Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>=20
Sent: Thursday, March 24, 2022 3:12 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; stable@vger.kernel.org; Wu, H=
ersen <hersenxs.wu@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.=
com>; VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: RE: [PATCH] drm/amd/display: Program color range and encoding corr=
ectly for DCN2+

[AMD Official Use Only]


Tested-by: Ikshwaku.chauhan@amd.com


Thanks,=20
Ikshwaku Chauhan


-----Original Message-----
From: Harry Wentland <harry.wentland@amd.com>=20
Sent: Thursday, March 24, 2022 2:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; stable@vger.kernel.org; Wu, H=
ersen <hersenxs.wu@amd.com>; Chauhan, Ikshwaku <Ikshwaku.Chauhan@amd.com>; =
Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; VURDIGERENATARAJ, CHAND=
AN <CHANDAN.VURDIGERENATARAJ@amd.com>
Subject: [PATCH] drm/amd/display: Program color range and encoding correctl=
y for DCN2+

[Why]
DCN2 CNVC programming did not respect the input_color_space and was therefo=
re programming the wrong CSC matrix for YUV to RGB conversion, leading to a=
 wrong image. In particular blacks for limited range videos would show as d=
ark grey.

[How]
Do what DCN1 does and use the input_color_space info in dpp_setup if it's a=
vailable.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: stable@vger.kernel.org
Cc: hersenxs.wu@amd.com
Cc: Ikshwaku.Chauhan@amd.com
Cc: Nicholas.Kazlauskas@amd.com
Cc: CHANDAN.VURDIGERENATARAJ@amd.com
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/gpu=
/drm/amd/display/dc/dcn20/dcn20_dpp.c
index 970b65efeac1..eaa7032f0f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
@@ -212,6 +212,9 @@ static void dpp2_cnv_setup (
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1); diff =
--git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c b/drivers/gpu/dr=
m/amd/display/dc/dcn201/dcn201_dpp.c
index 8b6505b7dca8..f50ab961bc17 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_dpp.c
@@ -153,6 +153,9 @@ static void dpp201_cnv_setup(
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1); diff =
--git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/=
amd/display/dc/dcn30/dcn30_dpp.c
index ab3918c0a15b..0dcc07531643 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -294,6 +294,9 @@ static void dpp3_cnv_setup (
 		break;
 	}
=20
+	/* Set default color space based on format if none is given. */
+	color_space =3D input_color_space ? input_color_space : color_space;
+
 	if (is_2bit =3D=3D 1 && alpha_2bit_lut !=3D NULL) {
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT0, alpha_2bit_lut->lut0);
 		REG_UPDATE(ALPHA_2BIT_LUT, ALPHA_2BIT_LUT1, alpha_2bit_lut->lut1);
--
2.35.1
