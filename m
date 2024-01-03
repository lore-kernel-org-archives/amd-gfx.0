Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515DC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 02:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD83F10E159;
	Wed,  3 Jan 2024 02:04:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EBF10E159
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 02:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDB43y8jXicrQhiIeeaO4bbUfK4rjDKAV2eiT03F/YIzEOvHeKV513tA5SX1nN+FL1Xk2lKCDocaK2BQSLmmvDzK7NbHIA9VGtchV+laPRIoUdK6VU+K9opA0ig9MAYQ4UtscpKgLkN0rYZLe0yu4ny2dz4xrm0n3lW1w+y2SBPKfPK7xSlrJS/cUZi9uv6VlIr4YsmdYPiXiSJpOnvuyzMyqTtPq91HHhPNWEt5hkayMY9FOFHXz0gzplE9zM0DZupmc1dfWsVblPP7GCtlj80usofwKbFohJ5ZHexcMSpSJ7byutiPTLF9ndiQJlW55rEaWzim2jiF42f/F61SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkD7uMq8tqgOgqSHbK9uKdsZoxzahAzKiQOytjTtjx0=;
 b=UdqteQmh/uj0k3poKIm9vWAAO3MbqQ33wd21BjITULN3bL/6FKQSlp+n33m70eO+VjBOjDDntx6uCGUdezw5WDg0ovOLz2x3on4gGxWG+y5XEgzoipBZR0+hGCj52yMM+kzhiG0rWpXjwTHbpgSwzhFoanQavx1SVgYpIdeOSYlYxYE34V0qCtIwBR9iiEQl2hTFFrCjY2A2r2vzkBYa1HIYi+5s5fnsOxALdkMaEi9bHb603bhjchYnQ+4e3XSAsiLTQM2wOUkZh7oioumRtHHdeOuLDLlK6n1sPCYa75lR7OsBT3zQ2ntc9og7iFD0Y9PdHhxsswm3IswRcieoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkD7uMq8tqgOgqSHbK9uKdsZoxzahAzKiQOytjTtjx0=;
 b=gMq+yFHy0yPAez428Xggcj9RpHTSfPD+rKU7iFt7lumFRw4XXkq+zGGHsK7WbT7+aL8zfk6tmqL2GUD4aAammyJPjUXw6U+zOy9w7jQs4cDpU93D3hSDHpi5yiaBUP1YEgmE8PnfbWwDq1rR27wfn9MCOT1WHFmQqpcWA0KClwg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:04:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:04:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Topic: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Index: AQHaPS4ANf8ht14KgkKhZgp7E4+n2rDG7hMAgABp3hA=
Date: Wed, 3 Jan 2024 02:04:26 +0000
Message-ID: <BN9PR12MB525798DFB0BBD7F0CEFD34A2FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
 <20240102034341.16321-5-Hawking.Zhang@amd.com>
 <BL1PR12MB5144EF091E264ACF1A5F7232F761A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144EF091E264ACF1A5F7232F761A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T19:45:20.186Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5354:EE_
x-ms-office365-filtering-correlation-id: 301b3630-9215-4ef6-2790-08dc0c005085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yI0D7HiDcoozpB+GfSTGanO+cxk1ZyaApTtEEPARNRUBhKUqrAkXdzrr4/bFofFmRmf7I4W1HkY0vXNiOtu5v5QYWLIVxkFsIoQMT1NPEM5LPOa+LVJHWrlOZjOvMf2G0Oez3arI3IQdRzds5sIuUmh2P6DyGN46u3yncB9e+cXydAJHQEBz6JSYYPgyQnxeboJSi9H6/mk4+NXsUJikLNPDAuYxLCJZdAOJxjFusr8aLD0sDHw8rjynSJ04bcv53snb4IoLvzK09ISlxNivSUHWB/Rgjub0eUCAKXQZ/VTD8crSAkwPgLKeC52NpHmezAE3C2b+JqMw5H7T9WvTy5KAjy4GlczIIi0rgYdcvUj6oHf2zJ/j0ZZ0j6bLQ7/DeeJfByTYMaEE1k09AbbPCEOeca6L4u0pBuW6XXezWvPrPZ+rXkp5B8VfsaF9scEbYDLOeEVEHpvc7qRsFBLYD6epNuRkU1Tpcq3mc/apSWCOpkKJDwNWdrq8XCkHgk3M+/SwQ5h59I9C+XUxTJbQPeCYzwFx6FWOWH3mKgOi8zuA11Z0h0xPVXXt/WlFUBXYaYxps/gEMspzAbZVD6IFLXhGgXoDASyrSmBG1Vh61ASTVCYvDy1rqtxdBNZu41KyZ4IIOyw5hhAXZ7hE4/co3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66446008)(76116006)(66946007)(64756008)(66556008)(4326008)(6636002)(110136005)(8676002)(8936002)(54906003)(316002)(26005)(83380400001)(71200400001)(478600001)(9686003)(53546011)(7696005)(52536014)(2906002)(5660300002)(41300700001)(6506007)(33656002)(38070700009)(921011)(122000001)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ui/xHMNlo5AT+cpE90UZAlqlBJw3Me6LwETeJi0AiPCJbARtfEXlu8tdq3kI?=
 =?us-ascii?Q?LxrPwgTdbeIv64KQrSZ5SXEwIHoKsEojOWoA1dIknm2f6xBJ3s1HKx8qy4B/?=
 =?us-ascii?Q?PuR/zCtYqBI0LkUlHM2wFNHMD3Z4/oy4Pgfb0ZdGdFj4MLleB4NeUnd5zr4W?=
 =?us-ascii?Q?6AyG3GpljgTnB27A600OyXW7FCaUfWSc2DFp1MBLfzwGLsSEpmZhts6JKnJG?=
 =?us-ascii?Q?oqbzgxtfXPohThVnLI9ZrkclaK5f9Qj6wHbsm2GwvF63THAaQNTxfIkFzCnU?=
 =?us-ascii?Q?ZPqGOyaws19MAEbjKaP674AE0GcWGZsA25uexeRyh29LQVo4XpsL+htZgCQA?=
 =?us-ascii?Q?8X7qlZs5A9hEHssD187i4DlAAMzMq5fZwr+kFI+khRQN39gXVg+NHxqIDAtW?=
 =?us-ascii?Q?JYgRKDdwt/86P5hUfLYZWba0eBu+AzfO6pyKkt/7iAOK4gSEaP+b/meFnbJs?=
 =?us-ascii?Q?WLNlPdV6r1EgVNg143wcCHCLSxE0LK1Euntu6FyF/pAYdtfMGBhVfIq5HVHs?=
 =?us-ascii?Q?UiEAvEzlD5tdXSl8jio9Muof7YsxD7UOu943Gbuq3k2SVCuYgPzUMceJ/fqs?=
 =?us-ascii?Q?lYwe8pGxY5n3dpha2YKqctY8zpCuPpW7oiQQKrEJbSNrfwuypukY05k1qdhM?=
 =?us-ascii?Q?pPt5/L6RyGfwuRj/W1bLXem48Bi58hTPu6gDW9AXzOQy5ZUlHebf932RR17h?=
 =?us-ascii?Q?Ykhg/gWxhXMzZ/Ylk6XFI57G1bRVoPbuy+f6y4Jsuh/H0dgO+arswPoLe7K2?=
 =?us-ascii?Q?URCn9FjKjLD64EkU74xCa+JFiHaSp6Bws5mLKQltat6rP4aY2F5ESq+P7gJy?=
 =?us-ascii?Q?ru7KC0YFcNeSvR0VK2SjqAECC3X68WQ0LQ0xEwwPNrRhHJcGjGdjZLv/tk0X?=
 =?us-ascii?Q?73Lhl7IL7WgaE4oIfOBHTKJSmjn3cObGtVyC67dweXE4Bo4civeHOYG2r8iQ?=
 =?us-ascii?Q?VLuH96b1UyM6IgeoYTKTxi4lpHgy/oTX/aTqD1bSyF+LUWu/Ht4GuAIJ7MBI?=
 =?us-ascii?Q?Akaal+h44L7w7b8S4i9Jreh5UogmfRoMiWnlyEEgz5nIM22fDEWAYSUdtBMU?=
 =?us-ascii?Q?LKYJydEcD510fZewfGH8QO6NRF3JAXxOH93BSLgMIoIsCVo6x1IB7g+ebenP?=
 =?us-ascii?Q?18HWllTEmDW2lHECWdvpYJOdh4X7weTTfwH3PSUlTBCDg3I3dQGVj14MgNhg?=
 =?us-ascii?Q?ze1XlA4tAg/53TaaYykb/pIbdfjLnKV0MUj2Owqy2yCKB/urIFl7ZQGa8TfJ?=
 =?us-ascii?Q?/MkbHxE50qUYSoWmgHaCEPDB7WtYukrjwpDOjxjNJ/Xno8T5e8iGD/wnseSX?=
 =?us-ascii?Q?IPQJ0UNmFNKD3XLCxQpHNfqhgROA+DyrmXLvibva42fneUMsIYwiLDT5O/OE?=
 =?us-ascii?Q?lPl0Yql5YPVzB6tlyXUypzAwkaNioopCGffe3MF6x3cGoXq200vUOfQBbZiZ?=
 =?us-ascii?Q?pIUIUI+bOrubFrF699Oe48iquUrwIM8G5jJnbCLcjrNZzSyeRjV1vKI1uOEm?=
 =?us-ascii?Q?6oDd4IKd0o46fNw1O4y8Mh4U2qTrTFBHaoCgkQB55sj5nq6J/7CvGvx++CbR?=
 =?us-ascii?Q?BEpBRYL2hWpNWLs8qgpYcFTcuzOQa5TAeg2aLhok?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525798DFB0BBD7F0CEFD34A2FC60ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b3630-9215-4ef6-2790-08dc0c005085
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 02:04:26.9684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClYOFtcEd+etphG24f3D83W9Dv8o+N2wRKWyNb0qMzwYkPLwnPkj2l72yoN6TVwzHEYz1+on+mVItIlzKvhmpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB525798DFB0BBD7F0CEFD34A2FC60ABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Yes, it is.

Regards,
Hawking

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, January 3, 2024 03:45
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed


[AMD Official Use Only - General]

Is mmIP_DISCOVERY_VERSION at the same offset across ASIC families?

Alex

________________________________
From: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Monday, January 1, 2024 10:43 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Zhou1, =
Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Stanley.Y=
ang@amd.com<mailto:Stanley.Yang@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wan=
g@amd.com<mailto:KevinYang.Wang@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.co=
m<mailto:YiPeng.Chai@amd.com>>; Li, Candice <Candice.Li@amd.com<mailto:Cand=
ice.Li@amd.com>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; D=
eucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.c=
om>>; Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Ma, Le <=
Le.Ma@amd.com<mailto:Le.Ma@amd.com>>
Subject: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed

Check and report boot status if discovery failed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@am=
d.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index b8fde08aec8e..302b71e9f1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -27,6 +27,7 @@
 #include "amdgpu_discovery.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
+#include "amdgpu_ras.h"

 #include "soc15.h"
 #include "gfx_v9_0.h"
@@ -98,6 +99,7 @@
 #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
 MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);

+#define mmIP_DISCOVERY_VERSION  0x16A00
 #define mmRCC_CONFIG_MEMSIZE    0xde3
 #define mmMP0_SMN_C2PMSG_33     0x16061
 #define mmMM_INDEX              0x0
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)
 out:
         kfree(adev->mman.discovery_bin);
         adev->mman.discovery_bin =3D NULL;
-
+       if ((amdgpu_discovery !=3D 2) &&
+           (RREG32(mmIP_DISCOVERY_VERSION) =3D=3D 4))
+               amdgpu_ras_query_boot_status(adev, 4);
         return r;
 }

--
2.17.1

--_000_BN9PR12MB525798DFB0BBD7F0CEFD34A2FC60ABN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.contentpasted0
	{mso-style-name:contentpasted0;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Yes, it is.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Wednesday, January 3, 2024 03:45<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanle=
y.Yang@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Chai,=
 Thomas &lt;YiPeng.Chai@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;=
<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Ma, Le &lt;Le.Ma@amd.com=
&gt;<br>
<b>Subject:</b> Re: [PATCH 4/5] drm/amdgpu: Query boot status if discovery =
failed<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black">Is&nbsp;</span><span class=3D"contentpast=
ed0"><span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:#2424=
24;background:white">mmIP_DISCOVERY_VERSION at the same offset across
 ASIC families?</span></span><span style=3D"font-size:12.0pt;font-family:&q=
uot;Aptos&quot;,sans-serif;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span class=3D"contentpasted0"><span style=3D"font-f=
amily:&quot;Segoe UI&quot;,sans-serif;color:#242424;background:white">Alex<=
/span></span><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,=
sans-serif;color:black"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ap=
tos&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@a=
md.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, January 1, 2024 10:43 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zh=
ou1@amd.com">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley
 &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;; =
Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.W=
ang@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com=
">YiPeng.Chai@amd.com</a>&gt;; Li, Candice &lt;<a href=3D"mailto:Candice.Li=
@amd.com">Candice.Li@amd.com</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexand=
er.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Lazar, Lijo &lt;<a h=
ref=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;;
 Ma, Le &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.Ma@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 4/5] drm/amdgpu: Query boot status if discovery fail=
ed</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Check and report boot=
 status if discovery failed.<br>
<br>
Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">H=
awking.Zhang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index b8fde08aec8e..302b71e9f1e2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -27,6 +27,7 @@<br>
&nbsp;#include &quot;amdgpu_discovery.h&quot;<br>
&nbsp;#include &quot;soc15_hw_ip.h&quot;<br>
&nbsp;#include &quot;discovery.h&quot;<br>
+#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;gfx_v9_0.h&quot;<br>
@@ -98,6 +99,7 @@<br>
&nbsp;#define FIRMWARE_IP_DISCOVERY &quot;amdgpu/ip_discovery.bin&quot;<br>
&nbsp;MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);<br>
&nbsp;<br>
+#define mmIP_DISCOVERY_VERSION&nbsp; 0x16A00<br>
&nbsp;#define mmRCC_CONFIG_MEMSIZE&nbsp;&nbsp;&nbsp; 0xde3<br>
&nbsp;#define mmMP0_SMN_C2PMSG_33&nbsp;&nbsp;&nbsp;&nbsp; 0x16061<br>
&nbsp;#define mmMM_INDEX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
@@ -518,7 +520,9 @@ static int amdgpu_discovery_init(struct amdgpu_device *=
adev)<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;mman.discov=
ery_bin);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mman.discovery_bi=
n =3D NULL;<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_discovery !=3D 2) &amp;&a=
mp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (RREG32(mmIP_=
DISCOVERY_VERSION) =3D=3D 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_query_boot_status(adev, 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525798DFB0BBD7F0CEFD34A2FC60ABN9PR12MB5257namp_--
