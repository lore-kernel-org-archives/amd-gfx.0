Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D0EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 18:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABD210E8CF;
	Thu, 10 Feb 2022 18:00:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C129210E8CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 18:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYDNX2IDuV7/lH+5pmQY4aQxY2E/HVYIumLjmF/8cHieCE+OunF9X6HvXKtNq8EKsbP1/ecksPIwihZ+sijMbXhcKCx1t607vpkG1BiRajYLkESyA+hQ9DHcF4W+OM50p0OyAn5IdszRLVsfRxDmkrKnBiaUzrhQFUmVlNeiO+OW+lgjix5I7kEEIepbXoYLz8HPSnr8RFDPKXZuixe/3rHKXLC/86hsRVDgqQvdhW3NsngshDNH8Z1qL9R2z1CzXu3IRnp9xIZ0SwyCGBysJCjG+8P7ZxHqLgJjsGZwVGkBZhJkMVn/CiWq7VnI5bOk2JqHeSxvGRUE3sn2hczRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHG8nJ3TfoM7V2GWlQK2TN8vXVRudCo999dGdNSB1xE=;
 b=LN/+8RqlWI9+B6K5F49wkvGltMcdfKpOG7fbvdyPHO2zmALI00I/cnGbr+xtFqrjDOzn0lYD4kqLvwXN7UJ+TZwQO9//QUvmqbTeWWz3oZh4KLFh6UlVMKyR0/d2PVMk7dC3zq3WJcaNt20jieiBhYZCP7Ups3kM9jbxd7RXmC7OTd+bKvOBFs+Ciqsn3sDcrXiFPbC1jTe5UAGVbxC7P/Abs6HJaZOeSHZdAlvf+tKLUewjUt91R6VVVjEtB1myYJeL72bld0mNQnOSeQ3h89ky1J6tsPcHagaatkSF+9N9nQfp5waZWTCFybLm42Jv9EpZu9Lr5ZymbEmr3LTsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHG8nJ3TfoM7V2GWlQK2TN8vXVRudCo999dGdNSB1xE=;
 b=tU7SWL0Haj1yj8mCZ2Q4Wq2N2GEtYnG6kr26HWfnRjhROximZUu+3IuihjnhBm/8z+dSOW7p93GYMYsHL7jWwYvLWU9GDcvG+rQl2+rQYghA4mRukXXP+j2x6YIwx9uI45EQT4I9g75GBxv9uPPgvKrr1voROc7ALcvUhAhrcgk=
Received: from BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 18:00:51 +0000
Received: from BY5PR12MB4052.namprd12.prod.outlook.com
 ([fe80::200f:69a4:fb20:633a]) by BY5PR12MB4052.namprd12.prod.outlook.com
 ([fe80::200f:69a4:fb20:633a%5]) with mapi id 15.20.4951.021; Thu, 10 Feb 2022
 18:00:51 +0000
From: "Logush, Oliver" <Oliver.Logush@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: extend dcn201 support
Thread-Topic: [PATCH] drm/amd/display: extend dcn201 support
Thread-Index: AdgeqA6ezpT0ig/ORqOQB4yFwSb+4w==
Date: Thu, 10 Feb 2022 18:00:51 +0000
Message-ID: <BY5PR12MB4052E928B8B190EB6E7B30C3F22F9@BY5PR12MB4052.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=87aac091-4e96-4a4c-a50e-d476ab838dad;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T17:58:33Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38c29a4d-f3c4-4e93-fc3d-08d9ecbf4665
x-ms-traffictypediagnostic: MWHPR12MB1519:EE_
x-microsoft-antispam-prvs: <MWHPR12MB151999E82A0B94F655BC4971F22F9@MWHPR12MB1519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9ODOLsmV28pA+YBi8KlpmPUrFRsxslyRfhDo5M7YBZb2EF3FKV66rrdVRBCDrWMoz1R14bPlHpMvUpSsenI/RPeEErqqHpM/o0SXYijxdPEALAWZvPwN6dK8VBmMKyOR4XR4D1YJuHqEuLmABtdFqzp/gbunMDWQagmm/MGVlLXwuPi7DcO3IQg2GCK+o8bNlixbJbzsJRNd6bPRqaugXpnHu1mW7gJXrKp46J/wvh29zDi7BOXGHrRFCGOKwvLBSPxJASayL3r3ZogdbEL3NOLfS+aNiqCo2cYSI7FamEN3HW3iv31Vf/q0qUY7e+EFfu8XqZDwCElyDkDBbm8WBb3Bj+efVMRxC/jPlxg8S6nPAzoYQx7Te8kWQZfqz9/8z5x77OyzduNyay6Rhu8B2it6fhnq7EGXNz/dyclpBVBp16eRV/wEk9pKmRjCpMMSrrUVk0u0umYNlGqZ8TxcT8LyHMVdREcqkksDVBPYcJEPFA09+HjUxNB2MN1TPm+0k2chav0q2pyUnDPvVbF3I6+Y72PbYlFF+H3Csw9bCCg5vwMV42rwZEx8tilr8PvdKvInRSz0IjRy+J5Hn6SUqpYuuy1Vv4TRPZ2PQFdizcpRwca9+pOgPzYwnxfBQVdVHZLCy5lOBP66CJuIqG4Y2k41wQQYAdzp+Km6sBuw9MramISY/UwPQ2P6IF/muOGRScUWyT44kK0ehmaWIGiOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(6916009)(316002)(6506007)(33656002)(83380400001)(54906003)(38070700005)(53546011)(86362001)(7696005)(9686003)(508600001)(122000001)(26005)(186003)(8676002)(71200400001)(38100700002)(2906002)(66446008)(55016003)(66946007)(76116006)(8936002)(4326008)(66476007)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fRrfi3ntVauNySHqg3Vs+svL+NUZ7XCBVXJrwB9ONaCOLwDvHNv6DKEhV3iq?=
 =?us-ascii?Q?t68NwlBX+hBBEQPOJugdlhO7lpwR+0bCVH6IHKQtx5dPZugQyIE7BJRXj7aN?=
 =?us-ascii?Q?xfKW/kN6iOqrbW3SA5z5aBEWA81UX289BwA8rllkCYzJr/3nYjm+qs/hX6R7?=
 =?us-ascii?Q?b25nHYhQOkV4QCiJ/X8kt3RJJL+wb6uEQYPqWZ5/0C7wKCuZongvi6tS7Ppj?=
 =?us-ascii?Q?SITV7UuAr2DtUQpgWzgjz/qv/0azP10eH4g1/GyrFaQGaC0cVmFzykEFeeU5?=
 =?us-ascii?Q?MWe8C/sdX0BhKz6WtdGqWe1VB8ncJFEGj5Wdsd1izU1Qy2GoH5E97QtPK55w?=
 =?us-ascii?Q?7W7Y15yhhihiORU98XQBt76SNHyLjK0IlW7vgWTSEXpu66gndFqGc0bs8Abq?=
 =?us-ascii?Q?mCBPRG3V/tBD423wym5z+jXiChKudnE4nmDOA+NSJCDYD11rBParDsluKENd?=
 =?us-ascii?Q?fOc640o7k6pVYVTearAF/EdrfTUdSFro0JCRZQzoXkTVnAC777fXrj6X5Xg/?=
 =?us-ascii?Q?4lMGsweUA9rRH8oYyE8gfSniHy9PGHZx/hekH2tXZKiyhv+6hhGUEZkhb1wT?=
 =?us-ascii?Q?sdfIBFUas+gTfFM2jQ+8reic1W3uchYncig7T/M5yKoodE497EbkUAKWQ7fW?=
 =?us-ascii?Q?VJ7bYBMkvqoA2/kL+ZGpeLAapVxA0sQXFLfuUtYe/AsmuWWnyzseHKiGMvSP?=
 =?us-ascii?Q?6fnVa6OYBvIQHLReOJZ60YibtvF8zFpDq/b0e/ChNKmNRTxnmKxsXokfLqxD?=
 =?us-ascii?Q?DuEx1W0dc+tpqyJRPMUdNDIiURrJP9+39tHnmqFssu8U+mC5ic1ZmJ0oq99n?=
 =?us-ascii?Q?gne02VvRvK8REgO7sPlMgDTJ4FLMOS81SxdNbFyudKmMQcNbY8j4MPcbs/Vj?=
 =?us-ascii?Q?gOteCZ9NG+kntbkXBVCKnTbbRn76RmFfkbYUAb7+X1EycaT6Mv6n8Ah/Yvfl?=
 =?us-ascii?Q?FaGUd26klsYNENIY4PE2bOQk9dS+3aE6UggtkTU5LhBDYsnz+njhNymWT+qS?=
 =?us-ascii?Q?dgSFwg6T2t7Kkdpr9qBwgyvcjVfQlSVNwzlS1SU1Vyv47vA8ji9LJsLVTbG3?=
 =?us-ascii?Q?a2pDV+eMFC2TyGLZqu8wwdyMHp3DNsAh5gG6p8n2HP3Ui4rRXjWkeu+j5Z4v?=
 =?us-ascii?Q?BQTee8OqG3TgvPMmhuM5BptUIYMDIL9NAGyfgaXRCFpuYUe58mkOinisfEhB?=
 =?us-ascii?Q?rnli6hr0jh8OIeCuUiOIOV9c/ZeEjYx3nZ5TeYJrVoGk4Eil3GEizombYcEc?=
 =?us-ascii?Q?D3G9Fjj/O35Ng67w4fwkm/vUM6rONhpwnYRArVbkPL2GSuekGiAsWAYklGla?=
 =?us-ascii?Q?UOEpBQUeZCqh8ik/iwFFEXhvwsldVJCDS7MjbFvn2nmT33WsbquXnIzs3X7p?=
 =?us-ascii?Q?v56lVwWlAW00d/aPUQbSfS6GVP2V/RhA1pyVylcdtFy85KTweVD3Xl7MlYaP?=
 =?us-ascii?Q?OVV/LQDPENEFMZtxyGlNjiZ7HoVtNaPLkg8XkagnSYhkGSjpyVb8MMITZU++?=
 =?us-ascii?Q?cG0aqpXVCUK2U1xh0txFg5G6jOsOcr++krAdiDUq8L9919+2qi6rU0DyyAiw?=
 =?us-ascii?Q?w1YO56sqsSmlmO1DVCuSORBq6MKfxoDZnropMwVMeiJW901a91Ls2wfeyOZF?=
 =?us-ascii?Q?E+3/SYY67qWoyTqzt9A945s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB4052E928B8B190EB6E7B30C3F22F9BY5PR12MB4052namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c29a4d-f3c4-4e93-fc3d-08d9ecbf4665
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 18:00:51.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBTkRJrN5GJwGpG4VACCq8SycvEREoEU28I1yXSqHl8KpqHlI0DQOkmF6rmFPF6o3LMYedmymyMJY/WNDbgs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "Cornij, Nikola" <Nikola.Cornij@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB4052E928B8B190EB6E7B30C3F22F9BY5PR12MB4052namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From 488cc792021a60300df3659de204ebef954ba2bb Mon Sep 17 00:00:00 2001
From: Oliver Logush ollogush@amd.com<mailto:ollogush@amd.com>
Date: Wed, 9 Feb 2022 14:25:13 -0500
Subject: [PATCH] drm/amd/display: extend dcn201 support

Signed-off-by: Oliver Logush ollogush@amd.com<mailto:ollogush@amd.com>
Reviewed By: Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>
           Charlene.Liu@amd.com<mailto:Charlene.Liu@amd.com>
---
drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index b36bae4b5bc9..71b393194c55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_=
id asic_id)

                case FAMILY_NV:
                               dc_version =3D DCN_VERSION_2_0;
-                              if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE=
) {
+                             if (asic_id.chip_id =3D=3D DEVICE_ID_NV_13FE =
|| asic_id.chip_id =3D=3D DEVICE_ID_NV_143F) {
                                               dc_version =3D DCN_VERSION_2=
_01;
                                               break;
                               }
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gp=
u/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..e672be6327cb 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -212,6 +212,7 @@ enum {
#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >=3D GREEN_SARDINE_A0=
) && (eChipRev < 0xFF))
#endif
#define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
+#define DEVICE_ID_NV_143F 0x143F
#define FAMILY_VGH 144
#define DEVICE_ID_VGH_163F 0x163F
#define VANGOGH_A0 0x01
--
2.25.1


--_000_BY5PR12MB4052E928B8B190EB6E7B30C3F22F9BY5PR12MB4052namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From 488cc792021a60300df3659de204ebef954ba2bb Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Oliver Logush <a href=3D"mailto:ollogush@amd.c=
om"><span style=3D"color:#0563C1">ollogush@amd.com</span></a><o:p></o:p></p=
>
<p class=3D"MsoNormal">Date: Wed, 9 Feb 2022 14:25:13 -0500<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: [PATCH] drm/amd/display: extend dcn201 supp=
ort<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Oliver Logush <a href=3D"mailto:ollog=
ush@amd.com">
<span style=3D"color:#0563C1">ollogush@amd.com</span></a><o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed By: <a href=3D"mailto:Alexander.Deucher@amd=
.com"><span style=3D"color:#0563C1">Alexander.Deucher@amd.com</span></a><o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"mailto:Charlene.Liu@amd.com"=
>
<span style=3D"color:#0563C1">Charlene.Liu@amd.com</span></a><o:p></o:p></p=
>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/display/dc/core/dc_resource.c | =
2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/display/include/dal_asic_id.h | =
1 +<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 2 insertions(+), 1 deletion(-)<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_=
resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<o:p></o:p></=
p>
<p class=3D"MsoNormal">index b36bae4b5bc9..71b393194c55 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/display/dc/core/dc_resourc=
e.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resourc=
e.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -135,7 +135,7 @@ enum dce_version resource_parse_=
asic_id(struct hw_asic_id asic_id)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case FAMILY_NV:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_version =3D DCN_VE=
RSION_2_0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D=
 DEVICE_ID_NV_13FE) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic_id.chip_id =3D=3D DEVIC=
E_ID_NV_13FE || asic_id.chip_id =3D=3D DEVICE_ID_NV_143F) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dc_version =3D DCN_VERSION_2_01;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/display/include/dal=
_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h<o:p></o:p></=
p>
<p class=3D"MsoNormal">index e4a2dfacab4c..e672be6327cb 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/display/include/dal_asic_i=
d.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/display/include/dal_asic_i=
d.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -212,6 +212,7 @@ enum {<o:p></o:p></p>
<p class=3D"MsoNormal">#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRe=
v &gt;=3D GREEN_SARDINE_A0) &amp;&amp; (eChipRev &lt; 0xFF))<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">#define DEVICE_ID_NV_13FE 0x13FE&nbsp; // CYAN_SKILL=
FISH<o:p></o:p></p>
<p class=3D"MsoNormal">+#define DEVICE_ID_NV_143F 0x143F<o:p></o:p></p>
<p class=3D"MsoNormal">#define FAMILY_VGH 144<o:p></o:p></p>
<p class=3D"MsoNormal">#define DEVICE_ID_VGH_163F 0x163F<o:p></o:p></p>
<p class=3D"MsoNormal">#define VANGOGH_A0 0x01<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB4052E928B8B190EB6E7B30C3F22F9BY5PR12MB4052namp_--
