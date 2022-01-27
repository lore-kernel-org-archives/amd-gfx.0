Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD66FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 14:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075610E18E;
	Thu, 27 Jan 2022 14:50:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF1310E18E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 14:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFXnJfFwckQXFeTwATyU7gPYKb20U1nsEi1rncfGbZlUTEvG8OF9wSkkCkXubviqyhJtkeZH0nlL7DiXsjx5XpV9JHWgIIOHQNCPfgR4+8n52lmaswtvcxtl2YdSZ9ElOW15GEFrBUbJzE8+3bm5ax3xnF5kCVlC9Y3yRqozusQ5ZtpnjMLfci5vpJsQmQ5Cj0D01GKOSRDEHBGTCoa0h7tLCHfZLfW8aOZ/AimawJcFUxojg4DaTEYLGYZuWyY9hMO8tXnhuXTnssqsvFznq3/f9EGunWMA1pJdOFbRFe3UXIj4vs0WZ0+3dp+pwke8EVZSxmTe5Ppg6xQnDX881A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwQDmu1lMfx0s7mucJGU93NaWDzqBT53gi01aZMehA0=;
 b=GUM5/9y09pJW/p7ktYjbgDoHpJ5QAu1a44aD64IBsNWoxbSMnw+BvW7NaQ0Q6coSVRf5QIA3tf0qqpmdL46PpSCNXv9ovWtYO28n25Iw9ON+XzfAw+lB7GAO0i3wXdlWvGT2IwsGGE8WQfllMDpt1+wC22md+/QxERjjZtcDItG/aLm5smPG/6+KC0JflUkzhhu+ZFnX8r1aTpotOrgBDGSqZlkqr9eHf+mWAnEnkAmmVAYxvImy1299hwHnukm0zepg8QRb2Vsb5EzwKGcNYST2pEswMeIIjTdlZZT+RkTppr6O2lB28JNQCiw9H9XQJ2vWfKhLol1x/LhGnWoNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwQDmu1lMfx0s7mucJGU93NaWDzqBT53gi01aZMehA0=;
 b=gN6d8/nh/FcVC/wl+8GJxAXuyD7axkcWm4d7CG8IY3EatduIaORJNlw1i9xqKNKpYXQ3rcy+AJLhJj9qtIXqOJTxVLdGPn2+sN1xQThq3dOseZz61t491/je6CdFg7ZaGAzOWIIHdvaQEcQD4bOxWEIbsxxpvTEJKG1ng6cw3Jw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 27 Jan
 2022 14:50:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 14:50:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is
 configured properly
Thread-Topic: [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is
 configured properly
Thread-Index: AQHYEwg+QEvA65Z+XUi8LphyyGRjCax29Cxs
Date: Thu, 27 Jan 2022 14:50:10 +0000
Message-ID: <BL1PR12MB514433E3F8179EA8B8A69A4DF7219@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220126225831.16732-1-mario.limonciello@amd.com>
 <20220126225831.16732-4-mario.limonciello@amd.com>
In-Reply-To: <20220126225831.16732-4-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-27T14:50:10.112Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 6c8d78d1-57ad-c828-6c51-89441c25edeb
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80fcc60d-c709-4a2f-1072-08d9e1a45181
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_
x-microsoft-antispam-prvs: <CH0PR12MB528407FB33976F94A0CB2D6DF7219@CH0PR12MB5284.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P29o1nJN/ZCKL2bYB0/RUVA3/dDLbj5iNEz/pX7C4ItXXphbTEhmdM/1Lblhos1SxhueWmnW1SRDrPjo6bameUw3vub1bYW2e+BHr/qaArB/ijkOB7nM7Ero7LNowQoed4Frz4CoFuC55Gd2Hl6viZnwrQHrKPjgNBZkFxD1UD1U/t8igYXDkF6tlk3lkoVPcDBqhYGuOOOi3nIIRDpBxoDw7iOXPbIqpoRm/viJmJN7DWOCVTBqFs8F2TrTO5+Uh11I9Othd53U5nEihvx6RZ3nEk9HOULNVKkENJjMZmH47c1UB3a/B3FFkAyxx2zH1Js6+AAlk9kFOm0L+nci0j+vX5K3Fzp3jNGZxd+HInmG56v7MgA3K2k99xN9uis/DdfY4Cuc7K6zTY+sFEXUbYwIK2ILwPqXQVZXgrixVa+r7aRfAFVJ7etdQs0Gw/L0AykDw9xsZ94x37wpaDuI/Sa+LHzZ/hdHTs47+EapxYMRBgKXVe4w3sGFjQV1Wc3U7fMPztMgiaIN7VkwHhA1uu+BWoRg7bbgOBNemaSG5qTDLYv6b0grMU7+u0oL5u6L6WeJ4FjSMA7kzlz3+bHA/SrCnMMILPHgsZ48/v3Ql8DKsn2sFgml1YU7si/eJ2owpG0+d98fLlR778JYWi5xACJpmZto03YMI5Vcw5DDyqifkqlj3Nn5VLXCJFOHNxP0hrfOsz+h1qdwB/IuwjajB7DnqSzcN8Poc/eYWPel+6o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(122000001)(38100700002)(55016003)(33656002)(66476007)(8936002)(6506007)(7696005)(4326008)(508600001)(66446008)(53546011)(66946007)(64756008)(9686003)(5660300002)(26005)(86362001)(76116006)(2906002)(8676002)(316002)(19627405001)(52536014)(186003)(71200400001)(83380400001)(38070700005)(66556008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMSyHCOoI3dgblgkC7iIpgxHKI/MkN6j/fJQ57dU6MhBSeFniIXCM4oJKL6k?=
 =?us-ascii?Q?QzsAyPUO+YNtXf1RIX1LjADSLLJBBPJXu6Gngnge2ichS3udwnP7L1ipYJ3v?=
 =?us-ascii?Q?HxtNSM4W3pcXtcD+jGPD3CdLR1fuE7TVvY7KtFccjefrVGLAQH3fLLxPNJ0N?=
 =?us-ascii?Q?u+XZNjCx+5EGJUZlJ6oLUNyHkOrbJOO0AHaTyUwP/hdvNwdGQhqWi9feG0yQ?=
 =?us-ascii?Q?KBhddEu7WD55n9CrjB2aOzBcVS+Rhpq1zCt7lQWBtY2Uf6f2cYu2anV6ZCCt?=
 =?us-ascii?Q?7Jgr6WmADgYQ0eDfufzafBa6OsVsaqKeiBWNhIjTr7C5MiakLpDdjU/PsPq0?=
 =?us-ascii?Q?cFHpTBBt9SPjRlqmhp3Azc458BBwuL+nWVHtKAadTQdQUKYw+BPL7wQhdIcW?=
 =?us-ascii?Q?VrJHXwyzyrDsRdQz8Nrsl/n/oXvaa50PHWW7c5+rzeo9qR8/tu0idsXM1gMf?=
 =?us-ascii?Q?7K7PMFZ7zBzlkJ3dk4n88QsBrUeosMpIhSOvG2QE5WwdyuwrnWb7z6p6wNwV?=
 =?us-ascii?Q?m4vIPt8f8AykM4B/yCJ3ioz+w+TONhrFOKWWTfa3YQs9m8PrUBKs7lO03yO9?=
 =?us-ascii?Q?ZKcsGnXVRjclYqMUaNxedsg9qTF3jQnwUGFrlubdMky50FaL+81TfDVfxtTE?=
 =?us-ascii?Q?aZ13tOdVltIqMyLqRL0bTzDry6Vn/2pzgShMeJWFKSzsnfjkHaZRNcLvcscv?=
 =?us-ascii?Q?nRyYNpw9NfUmXOEQZ9u/PWCqHF32F1uRGxqoFRXWrQv5Tl+BXIeM7hkr5Lgq?=
 =?us-ascii?Q?I3XwzNn463LmFeVH4P7MYeaz9A1NwvbBr8JYK0T3v4JUI3caoZU2jhQClWWD?=
 =?us-ascii?Q?6o6mhCZu2vZVsXABooef8FKiKLEU57HZ0mnXepUYEefzuaNq4eXmq487NTdM?=
 =?us-ascii?Q?bnVg87C143Sxmv7OaZKUvaDMzJKWtJgPF65a8ZHi7MHKL7h/gGp7aUEgzjye?=
 =?us-ascii?Q?0SizXf0aeiP4XqxxnbYBDUP+YPLsUMDQdUjVF0v2RAfDeZmyfBZV7MUcVCxM?=
 =?us-ascii?Q?c1nOYekHk7IyPQjIICpHYkHbve5qtRQuOXGY1WnbUOO33qBAIBZE2VFyro7M?=
 =?us-ascii?Q?mxbQa4H7E5QACoKMmW3uU1V4gV7uAC1rjT5PqsfiyFigD71kOtjjF2rT4CoU?=
 =?us-ascii?Q?S7aPKzH8WhWDRG9yM6e8eHRXBxZWBLL5yEoSBT0sEDOYqoRIXn5au06xBWOe?=
 =?us-ascii?Q?cmZE+cye5uyplzfHoM1+gOpxzA0LUNuuHzfw86ls4lETarcwGe8+++ofhU+Q?=
 =?us-ascii?Q?79AnAUK17DaGiVsJkWTiVNA+YXtQM81SQev3rxB6WnzRUb9br9Qwt3z+ZVGR?=
 =?us-ascii?Q?1BELP1QW3IuqvEZWF6vLdm4q1Yz4n4oZON4p5LZ6KOGKTE34liKeUK3G8B8l?=
 =?us-ascii?Q?1Oo4fcDj6trZPP1TGK80YQsiKlXq2H4NLQ529O4KMcu8XbmOyvLt2qmMOn/8?=
 =?us-ascii?Q?fSEKw/1PBUfQHedkmw1604/23Jf1sXmHS6eliMLxpo23IWb9Fkoz9trQGAs0?=
 =?us-ascii?Q?RmPddf9605j3thkby+LHJnZijsdD22oDYwXOP/LsNhtUi/E1+WttNzvo8QIv?=
 =?us-ascii?Q?FGYz68b9dNkr1Jafad3eViYXI5tDcz1GA72d6jKgs2IuRCB4mkWY0kbStprz?=
 =?us-ascii?Q?3kieAL/ipGaZ98dmyD5zNCI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514433E3F8179EA8B8A69A4DF7219BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fcc60d-c709-4a2f-1072-08d9e1a45181
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 14:50:10.6684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnD5PXlO8RinzcfwWLlBib31aqBW+a50OGQHmy5qAA65IBqifR+v18XtOVnCtXWekpM2reizis5r84NppjBYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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

--_000_BL1PR12MB514433E3F8179EA8B8A69A4DF7219BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Wednesday, January 26, 2022 5:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Liang, Prike <Prike.Liang@amd.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>
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

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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


--_000_BL1PR12MB514433E3F8179EA8B8A69A4DF7219BL1PR12MB5144namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 5:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;; Limonciello, Mario &lt=
;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH v6 4/4] drm/amd: Only run s3 or s0ix if system is co=
nfigured properly</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This will cause misconfigured systems to not run t=
he GPU suspend<br>
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
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
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
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514433E3F8179EA8B8A69A4DF7219BL1PR12MB5144namp_--
