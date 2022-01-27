Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661EEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 19:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE64F10E221;
	Thu, 27 Jan 2022 19:31:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3C910E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 19:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKKyP0nWpQbxktcQmDG2JjEMh/5O1k7iGMb0XF4tz0+5UxJ9FLMDzTH9ef3MXOxKwktVsL/uoLNaf3LgnegZ7TdGq9G4DftBygP6IZEogmtJJn1jgR2zdS3Lu2tlCPDlxsD5eQkIP0tEfl19o8cer4Bscze4Y6zoEtZctIR9MnTzvz5OjWYcCxRvIwZI/uWj5EziyBkUG9pgkdp0S3GhAdunzy9GvZWAnfCiW5yllfi46UOVOoe6Ph6zBUFFbvuZvTSh5d0chUuLRQn2YiIH+p5ATl8jcMnqFV9HdiwigYui/r/iIDdWfC7sPBfLDYbRj6Ixi2F2/r6NNWg8dD2JcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vwf5YonK0vg9kWW9oFlYmKhfTrdzhCNkX9YdHrxlvI=;
 b=N6ym5Jn6VvDG83FiNutrS0mxgf/PdbUyPthFnGc7/hooJTwnDmFtwTua1PWnKuOJjJqDrylwEgZ7ITCaf3qKb/8e0D8g/g3pUVWTTKxFXdkiylNJ7K89xQbT7jMJRsUvAsUK9KTXGHRVD6f4xwkjJLwhCEz6szPH18gR9d5MF2BS61+9+dRwjC9fJeTGtLL/fepHSTwQxvPpq4coZMQWJnHpc3iperYqZlabr7IZA/Ft/vC9rIiJi89uB4O6IRWwSkcRHmwO6/RocELn4tEXvB+eWOPiORCAhtxQjMsZzECU627Tg9ZjHFlxeZZ6rulEDxD9TK7iEOG8sfHZq1TY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vwf5YonK0vg9kWW9oFlYmKhfTrdzhCNkX9YdHrxlvI=;
 b=TvN1mm+QtsybDjzC/e1tM4zDXbCzJf7cfIIcMLa593ZF0YE4QHRGuGkT2IICTNSG6eQA5GT4w+cxH3MhXJyPd9/89D0nLw/6kbPzApcqLuQfGVJHdtY4lb+TKT15bwXtnQeQglUxG5Bf9h1SpW0Jv7F/a9YL33OC+2gqQNta6sE=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 19:31:49 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 19:31:49 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is
 configured properly
Thread-Topic: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is
 configured properly
Thread-Index: AQHYEwg4XTRxvEBuOU+Qv0Neyh0mKqx29EwAgABOTRA=
Date: Thu, 27 Jan 2022 19:31:48 +0000
Message-ID: <BL1PR12MB515786437F18028692248EE6E2219@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220126225831.16732-1-mario.limonciello@amd.com>
 <20220126225831.16732-4-mario.limonciello@amd.com>
 <BL1PR12MB514433E3F8179EA8B8A69A4DF7219@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514433E3F8179EA8B8A69A4DF7219@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-27T19:31:47Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-27T19:31:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 991ea47b-3a00-4d0d-8cf4-fab8594d9902
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c147a0b-24d2-4a3a-1090-08d9e1cba9a5
x-ms-traffictypediagnostic: SJ0PR12MB5663:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB5663072FDE13C2C215B155F7E2219@SJ0PR12MB5663.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSKZbrI7agrpU3ZMT005e9p87l2jhxQB2aNw5TYbftSbQG5B3pFcM+1ADeg6tpDSnQ+SNcAgMXhr2VeQ5MTqBxFIiQXfKEYjxRTKJeoqpvraCI77kh0nQ5zmz1m2t6uw1P0fXD6guztsFkTV5nt7U4V+cg8D+xLENHI/SSbvbhxvzrsV+Vw4Lwrnxt1yzHd+YxHynkco5uhq6rVSrgKJglon5iAt4OxaB6QF5IKnMzlK317SZHx32x19umTWET93BnGDI8OuCmSIvrIZcWUF33GDWJ7qE6qF86mtrHBNBmpFcGeMaBJQHFC/tv062Vt0sr/ObbrwO+CCRNXm8VlPmiC+xrFad0HbSYs5Z8NmWpuq4COYvqkDMTgDJ+iHH+cSZM0mmNCI8tDoZEs2C+wXdLoIotpPuYP+4yL4xjz553evBwZQZOAo02oSxjd5geheM4yXPXWSAEi6b8DAhASF+gOl5Ixhot+Chh8FqQgQ1gR5R+PZZhA/tVAn1jvgV1vgfHqOVAjSt6zaj1JroJq4zMotQpCI93lNJz50YbiKLvf6R7zJH+H90FsLB9SO4mKrfAAeUqhPv5/KxoB5ia8aNqbV52WXwwgCMg8QhQc/II/TiKNjW5jXD1bAAc8l60X9DJ9U86jx/omwPk2mHmIYLnqTndE4iTGBsq4wnmD0MEZzP2D+MrfS6hswHEFH4Ka3vGXhrKWruCEnDkpdhrw4SmZZeQT5HKbxos5er7wI60k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(52536014)(316002)(8936002)(8676002)(110136005)(9686003)(7696005)(38070700005)(6506007)(53546011)(71200400001)(186003)(26005)(4326008)(5660300002)(508600001)(55016003)(38100700002)(64756008)(83380400001)(66556008)(76116006)(66476007)(33656002)(122000001)(66946007)(66446008)(32563001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qy2WY4YG+n3ZShEAo9nZDedYM/hLildeTnk9/N5YdGWVdrRV8bLAC+SMwym9?=
 =?us-ascii?Q?m5m/BvbeeGeikQBLL4nuQmeQ+zvLlyQj22dAURys6ZEheneS15wSCEvyUQkb?=
 =?us-ascii?Q?qZIFKeB2bCJ5L04rTsN5srLToqWARMhi3lCApFg5UvfTWnnOSiQb8VGRq/5R?=
 =?us-ascii?Q?4JMTomrZ2OqRRI2MALPFEvnnKTl/b1UrVjsDqfEoxarF6JWxswLamhiqRWx3?=
 =?us-ascii?Q?Pp8HadJbeql7LSSL+jZWTrx7hJL+QOQegt8qfF9bZCp//rjGT8wQso7oWirY?=
 =?us-ascii?Q?NODcwIH5MjPHARRu2ID/KukLwbNdQwEJmR2uF66abxy6gb/kAri476IYvP2V?=
 =?us-ascii?Q?EU7eL6+tXtuOBcXljdi0apIRXH14hvwCU8kC76sthTQKomZbronbFXHgsetK?=
 =?us-ascii?Q?TZLA+y9cUpKfU7iQZLHHCHyRlL+6l+VlYxgDxuEgVN8lF9j8G5P8WAGHi8/L?=
 =?us-ascii?Q?/1E4cwOj1mPAcJgHignhsznTYkijslMBvoIGl3lMSWxPvOHiWBsXLZXy/4An?=
 =?us-ascii?Q?+apu7l5YLilZ86s2NTzCpUWuTF0AzOMM3CSVyllUjIFGNztSrgHAIShZoosa?=
 =?us-ascii?Q?ByFOZ+E+CqNFYvjjPH5OfbRiuBT9R12t3yykW8mCBhLKqbAu2mcpFQtHktl7?=
 =?us-ascii?Q?eTaC2g0Jn1C04KYmjdorG+yqaBu5+RjrCzRbjllb/d7TyEQOH9VG21+XSisj?=
 =?us-ascii?Q?Jpuuozlzqzt9Rf60oqRhUlM5Zky+at46TYAtnDE26tmQwpzspy8XOGnTzgUD?=
 =?us-ascii?Q?xgkMCTv2wBPaEU6jA7dx2Iz9unMH1CFroucPjqy8+jrpoCmsMlGo2+lxMpSa?=
 =?us-ascii?Q?D94jGvuzmw4jaS1TmsqtrIR6sD9GPBUUcJgEy2PPsXVRvw34AHkAD/dLnFA/?=
 =?us-ascii?Q?NkaNephLvIhwbZ7Jfju7J4LnUgchQo5KlA0TLoW9SLCVBrk7o/LvRje5UKY9?=
 =?us-ascii?Q?dlppCt4Ik3OBHi3L8TQI07cPe7I88YDi9xRhJxGCLXXtRIK7Iyww5sd1xC4e?=
 =?us-ascii?Q?bxNjvYgXpmtzVGNuGUsiRWATv/URol1K2nf+U7bdFERGnW7rciBvqK5KobW4?=
 =?us-ascii?Q?tQNWeFAc2KnpEsj9vn1vIPPIhmiUvWywMKSJhQCZtG6bMlOsW5ULlFh3htL8?=
 =?us-ascii?Q?AK4Yo03bksH1rFBdpq1bXA14gt4FshITNR7fRZhPY979fdVA7dEIvu3uzMuk?=
 =?us-ascii?Q?5W14Z/6tobO6C9J3zykKxVSDuLZ1xtThqCRjUfyQ7Dsa3Lticq6W9IEKtVlu?=
 =?us-ascii?Q?ny5FYnpGu28lcIMOtFilMibQinnPCeLXpHsYzmAfqF21OJPVy6E2e+8zSVHd?=
 =?us-ascii?Q?Xdanp7vu+/6lBy/1D7vA4tDqvhBlhZ/12zpC0PZu5Z2Djk+iga1Ir9SUbFIw?=
 =?us-ascii?Q?GWrmTJvU2HpruDq14VggcLJxMufcNrl/GZG9cEhc/nqeRJZWSohgHOUTqyYM?=
 =?us-ascii?Q?+Ui98o7pYY4lWEmzya4PY393nTCHk3J5jJrWN4tRgj5nHZ7zWpRCXB9qORZ6?=
 =?us-ascii?Q?PavIIJsf4VOpLQLY3XVrwCZUh9E4nF2vPjjXio6cVc04zQ7ouoxOfbhdJXRm?=
 =?us-ascii?Q?xr9oVIVg+SaIiEUBq7ERoRa6RMQbgKo3GUN0kzhxjsY+nsWm556CmaoJBzNx?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB515786437F18028692248EE6E2219BL1PR12MB5157namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c147a0b-24d2-4a3a-1090-08d9e1cba9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 19:31:48.8851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NJHKlAyQhub+VG+Sy7L+mm4X9l7qrFUUiFB7J+FDaSr3+dNols4q32KiVVxIMeHrgDKNLkQL36LtuFpy1azkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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
Cc: "Liang, Prike" <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB515786437F18028692248EE6E2219BL1PR12MB5157namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks for the review.  I'm only going to merge 2-4 initially though.
The reporter on 1 has some questionable results, and I have a follow up pat=
ch for them to try.
If that combined with 1 looks good I'll bring that patch for review.

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, January 27, 2022 08:50
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: Re: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is confi=
gured properly


[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deuch=
er@amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Mario Limonciello <mario.limonciello@=
amd.com<mailto:mario.limonciello@amd.com>>
Sent: Wednesday, January 26, 2022 5:58 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liang, Prike <Prike.Liang@amd.com<mailto:Prike.Liang@amd.com>>; Limonci=
ello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@amd.com>>
Subject: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is configure=
d properly

This will cause misconfigured systems to not run the GPU suspend
routines.

* In APUs that are properly configured system will go into s2idle.
* In APUs that are intended to be S3 but user selects
  s2idle the GPU will stay fully powered for the suspend.
* In APUs that are intended to be s2idle and system misconfigured
  the GPU will stay fully powered for the suspend.
* In systems that are intended to be s2idle, but AMD dGPU is also
  present, the dGPU will go through S3

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.li=
monciello@amd.com>>
---
v5->v6:
 * Move code into prepare vfunc and use DPM_FLAG_SMART_SUSPEND to skip
   suspend code in incorrectly configured systems.
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 922accdd4246..3e581f35f19d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2289,6 +2289,7 @@ static void amdgpu_drv_delayed_reset_work_handler(str=
uct work_struct *work)
 static int amdgpu_pmops_prepare(struct device *dev)
 {
         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);

         /* Return a positive number here so
          * DPM_FLAG_SMART_SUSPEND works properly
@@ -2296,6 +2297,13 @@ static int amdgpu_pmops_prepare(struct device *dev)
         if (amdgpu_device_supports_boco(drm_dev))
                 return pm_runtime_suspended(dev);

+       /* if we will not support s3 or s2i for the device
+        *  then skip suspend
+        */
+       if (!amdgpu_acpi_is_s0ix_active(adev) &&
+           !amdgpu_acpi_is_s3_active(adev))
+               return 1;
+
         return 0;
 }

--
2.25.1

--_000_BL1PR12MB515786437F18028692248EE6E2219BL1PR12MB5157namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for the review.&nbsp; I&#8217;m only going to=
 merge 2-4 initially though.<o:p></o:p></p>
<p class=3D"MsoNormal">The reporter on 1 has some questionable results, and=
 I have a follow up patch for them to try.<o:p></o:p></p>
<p class=3D"MsoNormal">If that combined with 1 looks good I&#8217;ll bring =
that patch for review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, January 27, 2022 08:50<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system i=
s configured properly<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Series =
is:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Reviewe=
d-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexand=
er.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@amd.com">mario.=
limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 5:58 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Li=
ang@amd.com</a>&gt;; Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonci=
ello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is co=
nfigured properly</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">This will cause misco=
nfigured systems to not run the GPU suspend<br>
routines.<br>
<br>
* In APUs that are properly configured system will go into s2idle.<br>
* In APUs that are intended to be S3 but user selects<br>
&nbsp; s2idle the GPU will stay fully powered for the suspend.<br>
* In APUs that are intended to be s2idle and system misconfigured<br>
&nbsp; the GPU will stay fully powered for the suspend.<br>
* In systems that are intended to be s2idle, but AMD dGPU is also<br>
&nbsp; present, the dGPU will go through S3<br>
<br>
Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciello@am=
d.com">mario.limonciello@amd.com</a>&gt;<br>
---<br>
v5-&gt;v6:<br>
&nbsp;* Move code into prepare vfunc and use DPM_FLAG_SMART_SUSPEND to skip=
<br>
&nbsp;&nbsp; suspend code in incorrectly configured systems.<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++<br>
&nbsp;1 file changed, 8 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 922accdd4246..3e581f35f19d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2289,6 +2289,7 @@ static void amdgpu_drv_delayed_reset_work_handler(str=
uct work_struct *work)<br>
&nbsp;static int amdgpu_pmops_prepare(struct device *dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *drm_dev=
 =3D dev_get_drvdata(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to=
_adev(drm_dev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return a positive numbe=
r here so<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DPM_FLAG_SMART_SUS=
PEND works properly<br>
@@ -2296,6 +2297,13 @@ static int amdgpu_pmops_prepare(struct device *dev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_supports=
_boco(drm_dev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return pm_runtime_suspended(dev);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if we will not support s3 or s2i f=
or the device<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; then skip suspend<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_acpi_is_s0ix_active(adev)=
 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_acpi_=
is_s3_active(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 1;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB515786437F18028692248EE6E2219BL1PR12MB5157namp_--
