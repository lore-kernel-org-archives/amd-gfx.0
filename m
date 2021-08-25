Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D4C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E15610C8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90E15610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397E189F97;
	Wed, 25 Aug 2021 15:56:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3765689F97
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 15:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwf8DJ7byNdg1Q0Qdec1deMBg09S51MjkLxXx45nfCrmKdY29sOMN2sSlsrFOmQ84C5wiL5FDxnQY3/shmqER4cAoJAlHwcu6cSCkWssxXrVc9NRc18b2AStoszZMVSkvPP3seUR3aT5cbRNSxG81i1MWVH1eJI2BjVZiDSzxBRSnWsBAbMlF/P7cGwPEdGRNxqLT7ku+tcjtPFqRGfxw2gc7+A0ZB5Eay+o/BtVse5kbmT4GTGOBzY9M8VX3R1IJLI1qKXmPHuBbzuhTsn/9mvdlxgr9yg1B73AiPL7wR/zNwF/Zf056WV6vVs0H4unHv8dLpdE/fz8KIPpqfiAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZehZg+2vy6fgWqkXlyM9GCIYQRPLu/z1dRp3OSc+vI=;
 b=jE8R88Ob+ZSR4kgaMcxwbGLGs2HmkHXtSYaxSOlXn5iaU1E33wsjPUG2YzN6hvLTnaKhuZlxHm0ge9HS6bhwEXPA31OlB8ZyMrZcjsH8RMddTohXbwzoHM1owzELQX9gcYs1DFXu21sC2JXVqt/tsfeZs60gH9FwcYrRwDVNT2qupsxeIWGLFSpTWXFFm1lOVmFCVL/nA+Yennw5WwWH5DrW6OyicJIBpbZ05BPbr1tzkmsGIbU6bZHy1B+klAFzkwXSp31Fds6Yiy7f/CqZXOCwolysk/8X9n2uuMWtR7u3Ea74RTCyecBZwJznA506F6FEBG+DD6hJSYahfl3BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZehZg+2vy6fgWqkXlyM9GCIYQRPLu/z1dRp3OSc+vI=;
 b=Ue6iKQ0ALXo6w7OQr8VsjBP/enAC2BdJBfXCmE0A0gqR/kfpVaawwapqYx+XVdshtcquBzh379v/8HQnyObksFnX2GhkQHPNoo86AGKzWYm3oBzfJf833tnjTQd9uytk+29Fhds+20fDMgw1Smai9KaXH8lI/Y/FQqGL4o2JZLQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 15:56:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 15:56:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: reenable BACO support for 699F:C7 polaris12
 SKU
Thread-Topic: [PATCH] drm/amdgpu: reenable BACO support for 699F:C7 polaris12
 SKU
Thread-Index: AQHXmWV8L/PNOS0N0UuSctMF3qAF1quEYLA+
Date: Wed, 25 Aug 2021 15:56:34 +0000
Message-ID: <BL1PR12MB5144384D331A48A8F6C53B23F7C69@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210825035814.1284833-1-evan.quan@amd.com>
In-Reply-To: <20210825035814.1284833-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-25T15:56:34.394Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4885c807-bf05-4c27-2528-08d967e0ea58
x-ms-traffictypediagnostic: BL1PR12MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5094D9B70FA68BD4ED8D2002F7C69@BL1PR12MB5094.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PGX7TX8nVNzf8m+WzK5Mg9OFkI7G/nzH4aWJTmAIcPKlmb0DM+nZ94UQdEuNu0ir15hU6RHZOvXu2zlqpwkutVoN/btoPr+JvDVOBnJYQ7edib480tXr2j3+QvLfiov9nO+BydK6Ryn1e0X1cOXKAItC7/51z8KXDbwvbs7NTG/iZ56O69cNkGWrw5gpKbYLPmFLRY2BQKMcBb3ORiMU4rsl41bxYi6cmmEZCQbdKPeXBfH+PEx2Kts57kSjhEZ0uYhTosBFru2S3liZaTG7hecSpdNAldxtAyIHm/X+ghkIye9AZ3lBbcN9l1wbWR3TNB7D4XW9T534JVSCjkvaBAj5PQ1y9zL4TRLlfCCd0lyKwoprut8Uoq7yhqetDdyewlyXIpC1xvRIlbuImTaejiq2dkdILgGgWSwc3E7Mh0HkjSIe1yPd7b9kil6Qt1ENOhdwONCDif7o9PQrBD2iwTkO4B3j+9spTPY4s7DxzZ30ZnlFft+P6yoia+sVDvLFMpCt27+QZR8ZtN5ZpqMUffiXZ1ELlb5gg3HKnkU3s5+iZgf8Pm+1BxszHyZBTMKNsEt5jogpi6jCbJbjZ3Ty2gyGnCaJGWccd+u34MFDZZw6afNmpmbu0noitnH2tzJySD97dD2uHl57Jz2ARA+I13h9xn25cqzkNHHzvuP6N0q9HOyZEK+l0We/U4JrndwZMI4xmbshDabtVT0sM4AEBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(186003)(5660300002)(19627405001)(33656002)(71200400001)(122000001)(4326008)(38070700005)(508600001)(9686003)(8676002)(110136005)(55016002)(316002)(52536014)(53546011)(66556008)(64756008)(66476007)(66446008)(6506007)(8936002)(83380400001)(76116006)(66946007)(2906002)(86362001)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B46PFcsccEK/ugG6Wd6lM259mHy2CLu6vqKGVfSdFbm8Tbeg5HyUtNPBY2Wj?=
 =?us-ascii?Q?2CmlR3/u3mbTq+AprJ/LsJuXdU3RWVLDmCqU2Q6a3q/cL/GpR5ySZnyiho44?=
 =?us-ascii?Q?AsEtw2QfAjcnZCfF/+QLTEujyLjmeAeD2uZGiYwyOrnOxJd4yewT/TJLpb29?=
 =?us-ascii?Q?n5TNNMvBCMpbiQC4UeAjDj6mrYaQTOHpajPrIvYBCLCjrHdMn9RWZHeoJDHx?=
 =?us-ascii?Q?2ZSFatbQv/0ePbql+OUQ8PV+yebd6lZ0hIIHv7mDRf5IeAjSWRMqy3bs/mjA?=
 =?us-ascii?Q?3tv6SLE7W7V1UTy/xeHNlfcf3H907WDxlpGvkDPAm3O+7Q/gxmeHv4XpWgbt?=
 =?us-ascii?Q?K7kLa5zNsK5vxSpu812fvFdmHmEG7bBe/2f/vKijihCMRkvG8u9rMxE0elud?=
 =?us-ascii?Q?hsssDToTYFT+hbYyrCqGOVhnJFY0MaG09ntunUvXGZ8X1vBiTHSQagFJCkdO?=
 =?us-ascii?Q?Rcy8sQoGGGMg01tNN0k5PL07bGPNmoraglSS92ynyQ1iI6BhjIRm+4JN97TX?=
 =?us-ascii?Q?8vOwetyWmpSlaIh4D4kkbyxkQss6G2PWnEhw1KMNVqqqYWodlZlEKZSZ+sRM?=
 =?us-ascii?Q?KUf6P1MbzYUk0PItYOIpBmrjxsnRzF3welUgElqE4VI3MzwlVFm3HRBD6LkH?=
 =?us-ascii?Q?NeeQc4pdpezBaNXpKEpXPa0K/3x/Ibe6PEZsZiv30N35LlqrSOQUMtnOwk2u?=
 =?us-ascii?Q?95dzmAkBA4e8SaT8KZTo1hbvcaHgk1+vxst4+xdJcxmX9Kl1koPxIBBaYbSD?=
 =?us-ascii?Q?Bsg8m9SoVv+lK20rNimPK6kaJY3gYdajZGX4k9lOIYGxPjl0Hu1XWtJJNtim?=
 =?us-ascii?Q?GzLrs86qOmYYBq3h7XtVL/lOcmAsqebSKoB0mNUGvUKJ0tD38W7xs+Dj/cBw?=
 =?us-ascii?Q?uCGQvck1YQuysbXseuth2t49GfFvUAtLx/Nj4euSSEs195OoKZ424G0fpWaD?=
 =?us-ascii?Q?fhEcxc6Eg/hLBECHZ21V9LZKB2vtyj/hHbB5e04KSk9ay57mDNAYIiyi3iwL?=
 =?us-ascii?Q?o4wAMRmq2It2GDOAhLx5MRk8UsKKrrm2kMXmynuKqKztX4bjmz0mM4Yqen/0?=
 =?us-ascii?Q?0Ym7pqSRGwy7Xy8xIEOiM0uGCp1XouEPAp16Ss7oT/ZpU2KJox8wRbWbz8nY?=
 =?us-ascii?Q?mXa8dUcIbOjQ34tuWgHKQf3EhyoD8fBL8mkIASQrCaQJtjQ2wcxsnLw8QV/9?=
 =?us-ascii?Q?QVeCTLTHjLdInUHHmg88wY55uUTAXvJ05WPjzuMMVuMQp7yRkkJ7gJ3S+YEJ?=
 =?us-ascii?Q?+XnqYHroJoF13CoGO/Zs1+GMhKDojxflvnpyurtzHjG6IlFEWNCPRXmAhDjQ?=
 =?us-ascii?Q?pwpDTqoI2E0yyj2AjUwzit6g?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144384D331A48A8F6C53B23F7C69BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4885c807-bf05-4c27-2528-08d967e0ea58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 15:56:34.9664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tI1zcnKd0DPJ9HGshdJxcC9dGTuAR/iPKHPPSnf/jAItKTFr7zcoTnB/Z9poyr+WZ57f4eZ2QLDmXXi97vpkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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

--_000_BL1PR12MB5144384D331A48A8F6C53B23F7C69BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 24, 2021 11:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: reenable BACO support for 699F:C7 polaris12 SK=
U

This reverts the commit below:
"drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU temporarily".
As the S3 hang issue has been fixed by another commit:
"drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".

Change-Id: I5ea08a75eedd7fe32c7fa0b448f5bae1f390abe6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c
index 42a35d9520f9..fe9a7cc8d9eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,14 +904,7 @@ static bool vi_asic_supports_baco(struct amdgpu_device=
 *adev)
         case CHIP_POLARIS11:
         case CHIP_POLARIS12:
         case CHIP_TOPAZ:
-               /* Disable BACO support for the specific polaris12 SKU temp=
orarily */
-               if ((adev->pdev->device =3D=3D 0x699F) &&
-                    (adev->pdev->revision =3D=3D 0xC7) &&
-                    (adev->pdev->subsystem_vendor =3D=3D 0x1028) &&
-                    (adev->pdev->subsystem_device =3D=3D 0x0039))
-                       return false;
-               else
-                       return amdgpu_dpm_is_baco_supported(adev);
+               return amdgpu_dpm_is_baco_supported(adev);
         default:
                 return false;
         }
--
2.29.0


--_000_BL1PR12MB5144384D331A48A8F6C53B23F7C69BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 24, 2021 11:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guch=
un &lt;Guchun.Chen@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reenable BACO support for 699F:C7 polar=
is12 SKU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts the commit below:<br>
&quot;drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU temporaril=
y&quot;.<br>
As the S3 hang issue has been fixed by another commit:<br>
&quot;drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend&quo=
t;.<br>
<br>
Change-Id: I5ea08a75eedd7fe32c7fa0b448f5bae1f390abe6<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c | 9 +--------<br>
&nbsp;1 file changed, 1 insertion(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c<br>
index 42a35d9520f9..fe9a7cc8d9eb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -904,14 +904,7 @@ static bool vi_asic_supports_baco(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS12:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TOPAZ:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Disable BACO support for the specific polaris12 SKU temporari=
ly */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D 0x699F) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;revision =3D=3D=
 0xC7) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;subsystem_vendo=
r =3D=3D 0x1028) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pdev-&gt;subsystem_devic=
e =3D=3D 0x0039))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dp=
m_is_baco_supported(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_dpm_is_baco_supported(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144384D331A48A8F6C53B23F7C69BL1PR12MB5144namp_--
