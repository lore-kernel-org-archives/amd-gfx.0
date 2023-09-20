Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB9FC04FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 18:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696C310E526;
	Wed, 20 Sep 2023 18:44:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB04610E53C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 18:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCBVwZeO6MqxJLLb+b8PxFG5KJYiNdh8qctmSEoQHRsWJSQOxDceE1wtalUeO7J9nfxrSs+oXNv5CDmuMU5fifQ2x0aFBDmuHLVvCc2n4RKEKNLTes33J1HrQ0GjNIsfgEfrLToZey3NYHCZmQ6VMxxv9XgxpCvCcdyoaff9XnV0lHK+NK4tn/CcXo8vQ6zvgPuJnRQTT0rRkrBtAqEXKqKO/wZnvdxdkbgjMho34iZO1ifDhAnTnLPPqhogMQZYSAxxv+QU+0BUfYFTgUTGxrbzYKwv52PydeJvOdlPPAEDDTr8bKQnmAiYLPtSsCJaCanrm+ns4Rq0avnlHotg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uct+gveNGsLTZFo04NsrJmAkdgewBM4yubCedjiukI=;
 b=maJWbUW+CyL5dmK9zI/YZNCOioLS0+j4CLdjfHDLPlJv1b8pkkgkNiwOjCDhb4fWZmEA2fWXepyTuDuJrW9cin3CXQkL1py3sTL6j12l9Zg4RH1O/1alZeLz4PkqUwM6S/G8TV+Pp60rPSn3NOtKfiBqkIu8iGoMYSQo1cX28sdpU+YHWIJDb3rRvpXpHbRhB0nVYrWYkz8M5QnSS17Lon4f+JI5Czx94MyLHW199zmo+rl7HVipdgHpzxT5m9Q5d5LruQdHJ6iYdy6lDTdee98gJS6Q/rlVlG86MmvJEkTXuAdc9XzZTPkUTcCYCTpkSCWkXGZPhdARTCGVMHyJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uct+gveNGsLTZFo04NsrJmAkdgewBM4yubCedjiukI=;
 b=oGdRemjRajN/V8nzUH7VSdOrJVBLlU+3BbtOHsM5ExtONIMRJ9Mf/yrEXLjeRMPwClT5xlpLC+VcQ8uzwFx5Un4kmMC1YjVNWMl00qfA8Gd8ku0du471aC94E6GceIdhCxvE6gE3V3wyrz6Fx03YddhYLnHI0LuRfWWpjP+t+HI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 18:44:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 18:44:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: Add GC v9.4.3 thermal limits to hwmon
Thread-Topic: [PATCH 2/2] drm/amd/pm: Add GC v9.4.3 thermal limits to hwmon
Thread-Index: AQHZ667q1yS7UUXRZ0aEasUnmJtFtLAkDJ3a
Date: Wed, 20 Sep 2023 18:44:37 +0000
Message-ID: <BL1PR12MB514466EB873D01FF51AFAD3AF7F9A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230920104027.1295775-1-lijo.lazar@amd.com>
 <20230920104027.1295775-2-lijo.lazar@amd.com>
In-Reply-To: <20230920104027.1295775-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-20T18:44:36.426Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5208:EE_
x-ms-office365-filtering-correlation-id: 62173f74-d467-4ada-6678-08dbba09a3f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 07o7+BStL0qhNDE8njKiFhGAi10WZfC6BOf030XGJG9RMcpq4M3qKK91tJ1POJFMEF9eG692M4gcu6scBNRPXydSNPJx0g/Wo2B7zgk/+jP2rNwGiozSSYXj8zhpEx1xgn12319KZNFp/G+7Rj57sfVRLYu38TIJEf9hyjbuZwYbTvy1gdFQ9XBS3PhJ1++h2H/zXOg5ogz32qgpbLxn0BsZH2lLfbr5SaLLtH1ZH53q64EuVZuYycMzSAY8ZXIPCC7diLMwayX4TUIP0o8AupHjeQL4PEXyPkzb2pqB6nOHTsyUsi74hXUaLEmLFeNm+6sanHcMeFRQldZgP6MdDeB4uTIMwzNuInpX5sGGSVGThsW1OjBWphth4q0LYVZA1y5pxFnth6rbD5pGHUNSthYnRcJjJbr4M807ylYeZdD92rU4yy6X3B9IixkVSVw4H/SrbUZEYR2tQWbY9EEqcYaC1P/LY240meEAT6mRGdB6u1piYui3MrBL9weLwDkWQIMz18++/+bz9K4iVRmmWBJYrlaoOwS8TViEwhauUSP73H5y8oS3RcmYK2rVPz/O/dw5Q4VAIsD9bPgIx9fJHy8cepJ6vpG41ogn08PYpS1DPhtiRspXX/mfsnbR+HFB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(186009)(451199024)(1800799009)(55016003)(5660300002)(41300700001)(26005)(2906002)(122000001)(38100700002)(33656002)(38070700005)(86362001)(4326008)(52536014)(8936002)(8676002)(83380400001)(7696005)(6506007)(9686003)(478600001)(19627405001)(53546011)(316002)(110136005)(66556008)(66446008)(64756008)(66946007)(66476007)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BRAuD5KJ5+/ZZ/LLRMIOXm3H2AFpqVPdjSes53t4/qP4r3h0GvvU5WsywyPT?=
 =?us-ascii?Q?c6WE85qq858Nc1UljyCEVfY0pu0n4qkv/6ovDz1U6mVJ92ztgt8d39ywmOu9?=
 =?us-ascii?Q?WLHrHAlophLA1k8zKFKBZE0PQqU2RB+TWTzhy+u5EKaZ6C/bZMjDoZUpygom?=
 =?us-ascii?Q?nRsdLGJBiK7dAi0nQ8Qgg1BziRcaJmjsjCFEsb4tf5W6u0AKN1Hvh8qO8gT7?=
 =?us-ascii?Q?AQ9ZttDpiYj9QGwVxlrPjnaTXKo8j4zDdcY5+TxSAh060j6rBd3U42H7nRDC?=
 =?us-ascii?Q?DTa/bOPDm89+/17jTqecGYabYx6CWDlDGRUWdNNRxCNrYXMuxf5dDYCwqy/z?=
 =?us-ascii?Q?RIxghzm8JgyLuw0uLKDvOMZ4XSFZCIwjJi0HX4XVb0YjFU5Wse6GjV90tpK1?=
 =?us-ascii?Q?hHIBj+vRykcP1tq7uivfsjzG2+Ld3NPErxicWtzOxn4sGlc217TK6LjcxIH+?=
 =?us-ascii?Q?58nUHvKfEbdKiatR1/0JQ0/pzU7wlpJDt1G8G09VRV5KEOj7ZRiRpAWlGixT?=
 =?us-ascii?Q?3bicchS3F8w/IRPx+VxKlt273wgwB9kD6xpYJ07jO8DUH8IS6tzJFzgEPQIh?=
 =?us-ascii?Q?UhKqwv5RCXIX0kWxizv3GzXZZlGhM/OazqnPduYui7hA8olydqIqZsv7t6HT?=
 =?us-ascii?Q?YyMqV+0/ayY0vNR3yB/Y5cz+zNlkPTftx9U1p/neky6kDhB2ZfH9pT5K7Ebt?=
 =?us-ascii?Q?uarqpRRrFyAuwln3VOKxpiS3Z2Nq+xZgs8PQRQzK7lPDoSvEb4QslOqs+u2e?=
 =?us-ascii?Q?lUQEUH6eSLOhkgOoyxDS2LOMbU7XFjakfrVDFQ8UW7P3P1daCKNb0GP0HEfg?=
 =?us-ascii?Q?6hb96VgmYjn0ONWji/XxBhUHqeqjN4yXw1kGdX+HYhJI4VVGNGVI0goUBBTw?=
 =?us-ascii?Q?6RVvPrO7+UKDRZczBz0iDBURGP39wmpjr2Ww5tNypEuJ5PcMAe7ChNqLIQXG?=
 =?us-ascii?Q?Dvh2iiBo1C03aYX2Hki93ZbBQd51Wj898LUFDHKk3GS9bwzbsM+UnPaIn4bW?=
 =?us-ascii?Q?c7Dk520jAGIC2IO5bIDcISNfRmamV8gdtoBVc+XKSUZ+f/gU5AKGPjj5TMUO?=
 =?us-ascii?Q?sJT5v+R3orB14imndV5CEiPiqgvYMwTWTOHihKXbTKxEECoVkUrEESABcUti?=
 =?us-ascii?Q?gXCc2cylqJsMLMmt0pYKLUguLfvK16DnkNTO0LLJi/ZK5V+F0CafyX+KHrql?=
 =?us-ascii?Q?QGU/yOMQk3yVTYPUDs69xOA+LAsXVaiwWeraQxn8hG4umLXix+TLWV8EX1d+?=
 =?us-ascii?Q?dMn9cFbkXmR9Dn8f03lzH989p2pMxke0IjK/vC5h4oK62I2QGEQXch7YRe3C?=
 =?us-ascii?Q?G5shifxDJBps1q8VSY5w3JnhGW0ZPgFueqZgyu4Qf8IzH0NSNEXb3JIlwgFj?=
 =?us-ascii?Q?AC2vCIvlXahcVjAPRGvacxRV1Wl1mXXvCQ0mKAYV9008cbV2x1bfpFdJ1LKZ?=
 =?us-ascii?Q?XWvJmvm4oFfAOLdoa/41SDY2KE8zWVW3lSbgTN0aWpCcsW4ZPAP/nMcEEUIy?=
 =?us-ascii?Q?E7SoM58GpUOFbBivP9u6R6g+4qKaSgUDPq4vokX57CAS0CZXKU48c3+quxq3?=
 =?us-ascii?Q?82KttEkOhqLKimFVSe4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514466EB873D01FF51AFAD3AF7F9ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62173f74-d467-4ada-6678-08dbba09a3f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 18:44:37.0656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrwWusHHssuJbQJwf2MUpES+cCEiHC24s2t6pd8Z3GQodhzKo3lOI7frHkuQilVSSq2dYXcNI85LHB8CIVSesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514466EB873D01FF51AFAD3AF7F9ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On a somewhat related note, we should fix the hysteresis  values.  They are=
 currently set to the min and max temperatures which IIRC was not the inten=
t of these values in hwmon.

Alex

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 20, 2023 6:40 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Add GC v9.4.3 thermal limits to hwmon

Publish max operating temperature of SOC and memory as temp*_emergency
nodes in hwmon. temp*_crit will show the throttle temperature limits.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 2807f3bd9ebe..5d84cdcd7c0e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3353,15 +3353,20 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,
                 return 0;

         /* hotspot temperature for gc 9,4,3*/
-       if ((gc_ver =3D=3D IP_VERSION(9, 4, 3)) &&
-           (attr =3D=3D &sensor_dev_attr_temp1_input.dev_attr.attr ||
-            attr =3D=3D &sensor_dev_attr_temp1_label.dev_attr.attr))
-               return 0;
+       if (gc_ver =3D=3D IP_VERSION(9, 4, 3)) {
+               if (attr =3D=3D &sensor_dev_attr_temp1_input.dev_attr.attr =
||
+                   attr =3D=3D &sensor_dev_attr_temp1_emergency.dev_attr.a=
ttr ||
+                   attr =3D=3D &sensor_dev_attr_temp1_label.dev_attr.attr)
+                       return 0;
+
+               if (attr =3D=3D &sensor_dev_attr_temp2_emergency.dev_attr.a=
ttr ||
+                   attr =3D=3D &sensor_dev_attr_temp3_emergency.dev_attr.a=
ttr)
+                       return attr->mode;
+       }

         /* only SOC15 dGPUs support hotspot and mem temperatures */
-       if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0) ||
-           (gc_ver =3D=3D IP_VERSION(9, 4, 3))) &&
-            (attr =3D=3D &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
+       if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
+           (attr =3D=3D &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
              attr =3D=3D &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
--
2.25.1


--_000_BL1PR12MB514466EB873D01FF51AFAD3AF7F9ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
On a somewhat related note, we should fix the hysteresis&nbsp; values.&nbsp=
; They are currently set to the min and max temperatures which IIRC was not=
 the intent of these values in hwmon.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 20, 2023 6:40 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: Add GC v9.4.3 thermal limits to hwm=
on</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Publish max operating temperature of SOC and memor=
y as temp*_emergency<br>
nodes in hwmon. temp*_crit will show the throttle temperature limits.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c | 19 ++++++++++++-------<br>
&nbsp;1 file changed, 12 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 2807f3bd9ebe..5d84cdcd7c0e 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -3353,15 +3353,20 @@ static umode_t hwmon_attributes_visible(struct kobj=
ect *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* hotspot temperature for=
 gc 9,4,3*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((gc_ver =3D=3D IP_VERSION(9, 4, 3=
)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =3D=3D =
&amp;sensor_dev_attr_temp1_input.dev_attr.attr ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =
=3D=3D &amp;sensor_dev_attr_temp1_label.dev_attr.attr))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver =3D=3D IP_VERSION(9, 4, 3)=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (attr =3D=3D &amp;sensor_dev_attr_temp1_input.dev_attr.attr |=
|<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_temp1_e=
mergency.dev_attr.attr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_temp1_l=
abel.dev_attr.attr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (attr =3D=3D &amp;sensor_dev_attr_temp2_emergency.dev_attr.at=
tr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr =3D=3D &amp;sensor_dev_attr_temp3_e=
mergency.dev_attr.attr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return attr-&gt;=
mode;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only SOC15 dGPUs suppor=
t hotspot and mem temperatures */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;flags &amp; AMD_IS_APU=
) || gc_ver &lt; IP_VERSION(9, 0, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (gc_ver =3D=
=3D IP_VERSION(9, 4, 3))) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =
=3D=3D &amp;sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;flags &amp; AMD_IS_APU=
) || gc_ver &lt; IP_VERSION(9, 0, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (attr =3D=3D =
&amp;sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp1_emergency.dev_attr.attr ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; attr =3D=3D &amp;sensor_dev_attr_temp2_emergency.dev_attr.attr ||<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514466EB873D01FF51AFAD3AF7F9ABL1PR12MB5144namp_--
