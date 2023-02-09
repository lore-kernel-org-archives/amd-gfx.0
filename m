Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD2BC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 07:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58CFF10E929;
	Thu,  9 Feb 2023 07:16:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9611C10E928
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 07:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwnZchExZayCcIkwqBoSZ7Jf4gxp/VK2hmIWvNRk0Rslc89daVtG5q4l/TtePHRL7PXPy16QKv/pORzrXxJkbta6O0L9QXvVYRCq/GZkIXS/wDcrmGLqE6HBDYGz3t+aeYuiArD6lQJMZAmwLRJcqzAPGCZwzKXLtDuZMvp+hhwZ+mMKnGHGNIJzPTj/gQSzd2CE3y8VQyN0V0A9+ri2R9Fjyq1eNdwBOYR/Asdho43yzop7I9N3sP+wulJMxfl4s7cKzLswyjVl5U8C413bHrF5vkORj5GMC44+Qj9n7xYNwa7QL1OtCtZ/pnt3UfPaHyL6BFqVfHKIy9KhmzA3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYvq9BEKvaxtZbJqoB12mgvsUjIxzW7AEBVKgTt5tWA=;
 b=CnOtiw3QTrJ6woeKKOoMh9G63rEN/QiI3IcyuG5aVtK78WuUV+Jyfbw0LR4i7gLirSVGSCZXbKEsVa+8NSrjDJ61vYFV/+0eFbA3HJSebhT1q0rQs+12b86s7vK1CeJPkBCGtCAb5htZLTIOOZxlx0urT4paZoTBO4xks5uXwgnECdP8YihGt25jo0WPKBFKuLwZ5IJqlmNhtyH8qNIMjezwVuSz2UZ+VjBX2Cxp7/V3GHm2S4EU8hyGi9Xpw1VpiCNGXub7NDtmyoPIcV8hqLEL1dVquE0gYy94atKjWW89EXBfqX3PcYOppMlbLEJNAtUqgrKEHGwd1txLedDgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvq9BEKvaxtZbJqoB12mgvsUjIxzW7AEBVKgTt5tWA=;
 b=RD9wZM9d9EwNriTq8lilJl7h/2YuHLYxBuByebTFZp0zHl7GzB2l9Nwc4hqUmR9RSfxUoGRuNM2xT2G0iwETUoy6oML68k6DbxBWMsDp+bh7tH1uk6vetokyWJt5LaD33FMwm/ulHR7vngag32umrza1KtTUt4Qf7T7veUugqXM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 07:16:47 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 07:16:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Topic: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Index: AQHZPEGDYOeRDQ6vM023lPktTuRCpK7GMsjAgAAA3nCAAABWoA==
Date: Thu, 9 Feb 2023 07:16:47 +0000
Message-ID: <BN9PR12MB5257408260039F27566F4C5DFCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230209044616.560657-1-alexander.deucher@amd.com>
 <20230209044616.560657-2-alexander.deucher@amd.com>
 <BN9PR12MB52578D18FB80BD45372C85CDFCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB525768CF42F0D7EE964DD267FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525768CF42F0D7EE964DD267FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdd5f4d3-6137-43e8-bff8-11efe56428a7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T07:10:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7416:EE_
x-ms-office365-filtering-correlation-id: 10d1eb2f-7194-40f3-7316-08db0a6d9b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+iUyuEADJqHfuhP0O7SU8d6PK+LCUuWSLjmqCG8Kmj/EwGiMqjolIb6Rtl8xuJPVDM6j7l0VDElvXu2q6wR/oFw6JGEXKGu6OmQLpG8bAKa+4dM66ymu5HAI7Z8EUoFqEGkpCgvsXFixYZEWTqJ1Lt1qdFuIxrzPRITg3M4g3lvKF9nwYdHxItC8nwnmZtkK/yYcs0Y1Wz6fXJSoOZK4aDx1rg/6YSTRx0FXqTii2UYD0NP4SM5JV6Ne90kJkMxWguvrGlzbEZsK0ovfX7YhWmfsjenQpf+zZQYTKY6w7apzCiCkQeoP2HtxmedG6uZZY3iQoMU3+Q+5sapg1y46khMSoN7GUghIt8gDGNGM6z2XmXkrG+jUE0r2AsAe7JSEb3eIch/MHg2tGUa5hKG6FnSu5gGVQEXsx5nWLvAz/SXOIL/UIPrlWvq7K2GvaPcNeSNb9HqL3qY0Qfbw43J4jci1uo0x8jxorgnD8ZR+umgNo0WzRImS3OUQgDSoJJW1HM7zrV1HFuW/Cfof5FJdd0gvRpm3ry0xDStQclBJbPi+Dy65ZrAKYN4c+JjtYKs1RyADiExZKFhQBtDIq9/y+fr6SQniy4Ln9AQyIluvhNdeSAm6KYTy0mfgvnKI+4B7FizSioX0zxf977/uyX1uvn0pvBWUezn6W9sVHQtkkRvtjLzIBXATAWoU1BR7vyulSQtAsXY0vBwLosLt3V/2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38070700005)(6506007)(26005)(186003)(86362001)(53546011)(9686003)(478600001)(2940100002)(83380400001)(122000001)(52536014)(5660300002)(8936002)(4326008)(41300700001)(2906002)(8676002)(110136005)(71200400001)(7696005)(55016003)(66946007)(33656002)(64756008)(66446008)(66476007)(66556008)(316002)(38100700002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/znoZmtJJhChiDeVQLFfbcQDk9h6r5Tnj2BYPBDx4qvSJornYmh2ITDQ9zbm?=
 =?us-ascii?Q?uwmtppcc1hb4HDQiT+DhKR3fItrVxHCSDDB5uoZ6ybK80bZ+9h/aeu+J4w72?=
 =?us-ascii?Q?1eBoUSyoW5CxA/DJ/BDArCeCxT5HS6bjejQPl2Bj1NVaIo0gJALZUY1D+7eV?=
 =?us-ascii?Q?cEnTb11gOUwH4NIH/cctoKmI8eZzI0rgHtb25crWvcKBh5WfneF1wVe6qVVd?=
 =?us-ascii?Q?cYZVhwAC5dxOEIUJiYz40IxyoKemBA6xABuhIR6KzePJXuCV/CUjk38Mnb+e?=
 =?us-ascii?Q?IQGAscOaVrIXDv0qTPIiDe16D7hjVVSaWh+1uvbc+qBduMT6iZ0uwdsBhlzj?=
 =?us-ascii?Q?5pHO9Fw2KzPa8T9vNJdAVz0lhMKcaGZOFw26jRsDMdCIfRs03OPOblUTbeTK?=
 =?us-ascii?Q?WxSFWwZqUihHZVuRFfW7vNXmEHthe7cBiCaGqatZ5Uo2kXtJ9zVYnw9aVvh0?=
 =?us-ascii?Q?PqDsdMPRLxlEmBksat43reQf+R7D2P7a3rXjuEytojBsVBQAE572PuhmjVAw?=
 =?us-ascii?Q?W0v/ifZtRDRhYfIBPIQxce6/RBiMVH7YJbAjwqO7y2S1R6U5Szue81YLFdMm?=
 =?us-ascii?Q?8ommhJAUSje+tkZty0ZRq6BF8DCqDsiVTyVFPddbjwSY5RouYK57HcYxHNVO?=
 =?us-ascii?Q?HbPjraRxYIryKluVYFL2+IR1dZHKhF/9GNnHhHuCefMsT1Lgd+CgW92dnFC9?=
 =?us-ascii?Q?qhaERuCB73of9n5nndcU1yDBQq0Kj1oWKbzrw/eeABHoupuLdNqtjiNUGUhq?=
 =?us-ascii?Q?osydK2ami04DQTv7c1ca5C2s07oxIirJA9zqdyZvJKShjvydzfQH1ltBZtr5?=
 =?us-ascii?Q?AqTyIrvhwovqzEX5YbUnAdi34JHK+3K6eJvDD9gNJ77zStFolXRb/VGopO7T?=
 =?us-ascii?Q?1a/9TrVFl8be8W2EzfXvgrGEsHo7X9VPLf6UDNL4j/ziIUCodtXdAjZLlLnO?=
 =?us-ascii?Q?0PmoVKrjK9Ae//SftjG9NtoKPEyzi6HylNalFnB/DWLsgktrdU3/r7+BfiqM?=
 =?us-ascii?Q?kIvqCsCIITy1UHgwjDaa2rWMyUKQpEz+A95aXuL0ReuOPPIiRXJe4CYTpqXh?=
 =?us-ascii?Q?eAFYkk9WJah4uGwpcvT5y+9hzsn9/vIL3rFFcwHUsCGdtKEMy23LVF5Fut+L?=
 =?us-ascii?Q?xnvWvadsNQZlDNuUJKOl3XiBXsDUctUvKfCCALzjTpRzJetjPiUJdYNkA6Ej?=
 =?us-ascii?Q?W+ulKcXOsmxZ0iu819Gr8MPw49s/r7FJ+N1IhbtGixu/EWL7GSMtu9Jhd9cu?=
 =?us-ascii?Q?B4ZLvlFfw1MoIPtGAgCoKWyT2HMVdOWoS4xT4+Zh4O0KiLz5JfrVMWl2Sne4?=
 =?us-ascii?Q?Lf2PZ0zAb2vmzl7hMW+0MqZKifKlfQ+cPeMjTTMK2Zl/OPVemYUpazFn/SLS?=
 =?us-ascii?Q?2ND2WKG81JdBKxmIZlz9X3LrhKbDK+8RmRC3nUWyifYgEDRValVg6rHSFMlr?=
 =?us-ascii?Q?7L07BZFUb6TY7DMWTc7gotxkw50G8K5Hj389AEllrBEjIIIY07NZ9lIXI/lj?=
 =?us-ascii?Q?K2CL2hVnZ/cnIqmp/WqzTpw3sGke0qdhyGyOS++/i0/PTcT4eohwIsWWj5bF?=
 =?us-ascii?Q?iGM0r4WNx8QjYFUsfi5+8NSrmuk7hwJ40VzE7yk/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d1eb2f-7194-40f3-7316-08db0a6d9b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 07:16:47.4535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fik/OkWBhPY/qbHddyA7pwb6E08wm/rBUUX1ka/bALxvCwGXuVjsL+k7frAdyvCIYEuM79qA3/hlFtu9tEHhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Sorry, I made a mistake. There is no mmhub_v3_0_3. Only gfxhub_v3_0_3 need =
the same fix

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, February 9, 2023 15:15
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

[AMD Official Use Only - General]

BTW, @Deucher, Alexander gfxhub_v3_0_3/mmhub_v3_0_3 also need similar fixes

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, February 9, 2023 15:13
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 9, 2023 12:46
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

Use fb_start/end for consistency with gmc code for non- XGMI systems, they =
are equivalent to vram_start/end.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ba4a57d8e6f..bf06875e6a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_d=
evice *adev, struct dc_phy_

        /* AGP aperture is disabled */
        if (agp_bot =3D=3D agp_top) {
-               logical_addr_low  =3D adev->gmc.vram_start >> 18;
+               logical_addr_low =3D adev->gmc.fb_start >> 18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which @@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(s=
truct amdgpu_device *adev, struct dc_phy_
                         */
                        logical_addr_high =3D (adev->gmc.fb_end >> 18) + 0x=
1;
                else
-                       logical_addr_high =3D adev->gmc.vram_end >> 18;
+                       logical_addr_high =3D adev->gmc.fb_end >> 18;
        } else {
-               logical_addr_low  =3D min(adev->gmc.fb_start, adev->gmc.agp=
_start) >> 18;
+               logical_addr_low =3D min(adev->gmc.fb_start,
+adev->gmc.agp_start) >> 18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which
--
2.39.1


