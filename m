Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1B8C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 21:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4FD11A2E4;
	Wed, 10 Aug 2022 21:51:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2152E9266C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 21:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+aDq7UA/WWWWLBtBmVz/26G+nsud3H4GPQaAVEMwJb8Anc20g78HqdWOZ4sXZvlZG9LKT6PyXQB27ns/umUq4oXC5Z/1mw2CilpG/+7kHz5H37Sg1HucsraHRuQj0B7Fo7B2SxOYoaS5h+o+YCzb7fz7q5sy25b30nEhlstcXA2DhnZAOXLFiO46Fjt44KqltxR4qw9wh75/9EjQALn2YtxZDbsjUXMYrHdd12Bhi+Y1A0HTHXZ20bl2ip4G8S+37kWHojWDP+7f2ufxMx5w9pzuneXJfXhkQvvXnezBUBbQT7U4qWl/1Q/kdOauvqwbxQnmyOLQeq4o0ny7EcM7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R7rdLHW49jBV2Ht5dVEjCfb4Esp6Y5+98W3lE9z8vw=;
 b=i+FBTd5nWSdUgJd+b5CjgtuUk1r57Y3yOAsl1SeeOGpgbzHRgtGz753/I0DwSxiE3GHIGmkhbGhntLGopybr/iZM/K11f1l/ve3XfhN//fnX1ZgIkoyTgZgEmiSYoaZtTAIp2LwABdVR09PRgDzrzxTPq5ZvD+WXYlp5QFI2v5hOWL8YyEF7PMjxCC5t+aKWcYQrBUvccuz0kp7RDrBrAgJAnAMUInf+Cxonz9Dn2vPS1zs+ZiuEx9qmxCzy3bAECZx5seaknpkdracSovbInRv8ccGhkcPj2r2K/c2DZH7cK0NsxiJxf6aJc8sMnzfgOTQ2qs7L3lE8V2+mgp1JbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R7rdLHW49jBV2Ht5dVEjCfb4Esp6Y5+98W3lE9z8vw=;
 b=w0cP2/aYaf1g+IMtiSr1es2e61GCbxsdSJic6tDgrvMJpHtglktVvurb+JexBNBzCfa/cv5zrHijVJfMd0ZjnqCAeWzEwO4nY8//c/CaNp9tBlYj1Z8Wn7OEA4WXIODiS811JdBHxoS49O7DarswSA4Qwt330Hpy9yVLfdUn2yo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Wed, 10 Aug 2022 21:50:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 21:50:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: add missing ->fini_xxxx interfaces for
 some SMU13 asics
Thread-Topic: [PATCH 3/3] drm/amd/pm: add missing ->fini_xxxx interfaces for
 some SMU13 asics
Thread-Index: AQHYrGhtl3qSYwHeSUqXqr+fQu17Va2orZ5G
Date: Wed, 10 Aug 2022 21:50:53 +0000
Message-ID: <BL1PR12MB51445967EF97BD75E59F9A49F7659@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220810032122.1774860-1-evan.quan@amd.com>
 <20220810032122.1774860-3-evan.quan@amd.com>
In-Reply-To: <20220810032122.1774860-3-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-10T21:50:53.306Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5a2a095-e181-4887-6ed7-08da7b1a6607
x-ms-traffictypediagnostic: DS7PR12MB6022:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLvVzDL5CRBnNtYjfKG86HcxdfX7WvlI+O6Ijum5h1l8Ro1C0miFgOez6btS4nBvcqc8sOzeWBkWkVw4zjs06eXmZb1JjA5tQGtuzeT+0bVcqb7uhMAbn9LoD07F5HqJiknycwRUSPRqoBV8IGVkyIkUksOZSGm1avVtBTSTViXLDQDlpBfMgFZxIfDOb8BQJN4ESJhPEP8s90nvoQF9VK+ysUVgNWtTHgpNHtG9QGCYZhsrxcUxAOcoACERxqt2ZupEin9PeZ899FgijFrIbNzDjPTimmFn/E4x7c37AXXHyGUKxEXuT1LN1RIfda49NkGo2+Ew67U9Ctpi3HHaHUBVtFZGAY4YJCN6fN05IHnLATdvXcQvD10RG1JG1dFm7bHzoWmmd4rAZgP3WHI1MSjnYj0/gM95D9JYjNmSExmTIyn+aKP55kT/Ds8U7ajAplAY6Tsid89sgbQVTwxVPEqYdE6HfwlHq4N6L0QCxNccByIPyQmroos8dUBBeNweBa1mtrXFEuBOIMnyzL209vbI8s521oe7dzxVBbel/aA6tTqRDET3mC7qSFim9YOTUXRjrXnmectHLzcI/raUh0yyEHH+i0jmJGmTWAPpaLfz+qroY8wJX8ebto6trp8GRqTPzCM5v9lbiawqSVV2TPks/h5dBw+d1ukc+pdTElCQBLzxvuDeEWxVfTt3sZ1pbPMXbEmUcyWtFhgrZ57yUgs/qGIFvPN4VnFrEHbk4RCJjN0G7PlF0lQxKTSzPlEtgidMO5RGop+0Y3LVGawGM6ZYayK0nkuxgxDS0WxnTUJrpmS/cPw1frgPj7yM7QV7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(71200400001)(316002)(478600001)(41300700001)(110136005)(2906002)(66476007)(4326008)(52536014)(55016003)(76116006)(64756008)(66556008)(66446008)(8676002)(5660300002)(66946007)(8936002)(38100700002)(19627405001)(86362001)(33656002)(122000001)(9686003)(38070700005)(186003)(6506007)(53546011)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FWYJfA8/L/glfWZOs3IZ8aqQtWpd2GKS8DBZZ8Q6oQFMLaZ6qu1zF5BspVdM?=
 =?us-ascii?Q?PrcK8uuGT0Nq6ShlWRPkem4vxuIvQkhd1zH0z962zx8T5rL7ID6W90W2vx0u?=
 =?us-ascii?Q?GytSK31RSnEcMJPC4NAiE0pcT8eRD+KX9pSv9rr3ab4TrUpkigVxpS6/MB+r?=
 =?us-ascii?Q?tmDktI98/ROPz38UOoa6hAiF1aqJRvN7Boj3vTfOmzcjOHkBPnp2A4BZI7dA?=
 =?us-ascii?Q?dy/0vhw/Y+GP+C3o+Ji2oL9aYHgxpqBYqVBi3ML2Yi9IXqPVOH+o07MXJbkb?=
 =?us-ascii?Q?hfquE/bzvJwvSTAbNu46DDfKqScjoMaBSAs1ScVU6O88QYg6ZoIW83w+TG4a?=
 =?us-ascii?Q?IeOuZ2GF0326nN/O3PR0olaJZZRBFRftNJuZtbV/mkAyEh2BBAN8NqkL2wiN?=
 =?us-ascii?Q?Kbcui2muS/Fv1y10vhqAQqxclZaBAAjx604R4s2Q2ZnCzjY9yhhDs7auxDe6?=
 =?us-ascii?Q?JsVtwGBdGc2BarncS9NX6QMuXCRJohh/Xcop2VJhhK+eUSCZMua34uSLxpVq?=
 =?us-ascii?Q?UqoV+aPoDgCUoWD0au8b+H4zxeeiVSm2FDd9XupkQOK6PpN8+Gxb0fxtTkBP?=
 =?us-ascii?Q?MdQnHp9UXhGSrkIBSGXmdTVQZIT3inua8EUiaK0/pqnF4RqICO8fuQBGoi1U?=
 =?us-ascii?Q?l5incciqTaG0BEUoHjnZuZqVOZb/qGLlyT+gvPo5qYewfyVOp+UQ/HSFirf7?=
 =?us-ascii?Q?1gtsESqzY/sffURO5r5Na8WVeXxYRBMRIqSDjvIjnMtC2Gv9S0sasRd95gd8?=
 =?us-ascii?Q?nGsT/wzgRknDUfF7XDiRP1Zk32xSwayyWPkKNfaBpmAE6xCV0dkl92odusf/?=
 =?us-ascii?Q?TzNpmfAkfH4TpZ++0id7P/0RY9EvOaWYktOlJyNjiloGQeVHJUrYMuDSFdnT?=
 =?us-ascii?Q?hDFVFx6zZXkLneghuo4rnFvnxqTPNLT58gxf/E/Bhq6SJhTES27U1DxZAjyc?=
 =?us-ascii?Q?4h5Lu+x2tSLNG+7ju/16NwRwqN5rtHTINk8wkbcIK1IPcYjWZpgwJOp/Dmqj?=
 =?us-ascii?Q?I74BJKe7a/gFPmfrASmHAdmgzns1TTf+DBK6hpxfZgA8ktbbNsl0MFuT1uPL?=
 =?us-ascii?Q?aLt0KzAVK8/7S2GE3IsFgDohB5VIww7+amydl/oOHp71lG83ek11MZzTZcp+?=
 =?us-ascii?Q?0EZ1pvRwaG67Kl12/ExMlSXaj/2PtrpBDtyrkcvdlkvgO6i+Kn1aUdopZT1g?=
 =?us-ascii?Q?U260VYiXDplYSki6wg5Qw0LKh77vqUIKNqPCdhyhdPliXjnEdsvUiVm+m/VQ?=
 =?us-ascii?Q?OL5Blv+J9kH2J7lCq3w4diNWWP4QkEvP2Rvk7ZESkTNaqt++XxAbUmKXSJfp?=
 =?us-ascii?Q?1ZzSGXJAvkiqHgMbl5RgcWZ65xfRF7XnaRt5bsvDblnHZ82siPFrDWq3I0wk?=
 =?us-ascii?Q?6R4JxVqWAbS2Sgtwb4zbRGqW1WCQJNK6Y7ubuTV78pM9yK8Y6F9ts8yjhgC8?=
 =?us-ascii?Q?jJrIOJAH/JhyYXOQh4V1wxGbqbIhk7b/XI+MpUPutgMBD680dJnwDFd8pkfz?=
 =?us-ascii?Q?RDnxYKsIa56iCLRdcKFmwget84lNx6psZhCjHAATXJUwVQ9HJqPEi/CBGnUY?=
 =?us-ascii?Q?2lPO3QFxmr6E6ZP6gJs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445967EF97BD75E59F9A49F7659BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a2a095-e181-4887-6ed7-08da7b1a6607
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 21:50:53.7319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehiWER/QPJENT1I8M2b9evnSNa1glRYt0FYMhOpWZhTUST6So/DsJ1hEzKdtXApL4ftuBtR6VJkbsVSJejXFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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

--_000_BL1PR12MB51445967EF97BD75E59F9A49F7659BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 9, 2022 11:21 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: add missing ->fini_xxxx interfaces for som=
e SMU13 asics

Without these, potential memory leak may be induced.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ied7cd204d44d739dece11774c9d29e7a192fd341
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1bbeceeb9e3c..df4a47acd724 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1792,7 +1792,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
         .dump_pptable =3D smu_v13_0_0_dump_pptable,
         .init_microcode =3D smu_v13_0_init_microcode,
         .load_microcode =3D smu_v13_0_load_microcode,
+       .fini_microcode =3D smu_v13_0_fini_microcode,
         .init_smc_tables =3D smu_v13_0_0_init_smc_tables,
+       .fini_smc_tables =3D smu_v13_0_fini_smc_tables,
         .init_power =3D smu_v13_0_init_power,
         .fini_power =3D smu_v13_0_fini_power,
         .check_fw_status =3D smu_v13_0_check_fw_status,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 9dd56e73218b..d78375d9a141 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1574,7 +1574,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
         .dump_pptable =3D smu_v13_0_7_dump_pptable,
         .init_microcode =3D smu_v13_0_init_microcode,
         .load_microcode =3D smu_v13_0_load_microcode,
+       .fini_microcode =3D smu_v13_0_fini_microcode,
         .init_smc_tables =3D smu_v13_0_7_init_smc_tables,
+       .fini_smc_tables =3D smu_v13_0_fini_smc_tables,
         .init_power =3D smu_v13_0_init_power,
         .fini_power =3D smu_v13_0_fini_power,
         .check_fw_status =3D smu_v13_0_7_check_fw_status,
--
2.29.0


--_000_BL1PR12MB51445967EF97BD75E59F9A49F7659BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 9, 2022 11:21 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br=
>
<b>Subject:</b> [PATCH 3/3] drm/amd/pm: add missing -&gt;fini_xxxx interfac=
es for some SMU13 asics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Without these, potential memory leak may be induce=
d.<br>
<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
Change-Id: Ied7cd204d44d739dece11774c9d29e7a192fd341<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 ++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++<br>
&nbsp;2 files changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 1bbeceeb9e3c..df4a47acd724 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -1792,7 +1792,9 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_pptable =3D smu_v13_=
0_0_dump_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D smu_v1=
3_0_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_microcode =3D smu_v1=
3_0_load_microcode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_microcode =3D smu_v13_0_fini_mi=
crocode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_smc_tables =3D smu_v=
13_0_0_init_smc_tables,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D smu_v13_0_fini_s=
mc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_power =3D smu_v13_0_=
init_power,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_power =3D smu_v13_0_=
fini_power,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v=
13_0_check_fw_status,<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 9dd56e73218b..d78375d9a141 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1574,7 +1574,9 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dump_pptable =3D smu_v13_=
0_7_dump_pptable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D smu_v1=
3_0_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_microcode =3D smu_v1=
3_0_load_microcode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_microcode =3D smu_v13_0_fini_mi=
crocode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_smc_tables =3D smu_v=
13_0_7_init_smc_tables,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D smu_v13_0_fini_s=
mc_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_power =3D smu_v13_0_=
init_power,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_power =3D smu_v13_0_=
fini_power,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v=
13_0_7_check_fw_status,<br>
-- <br>
2.29.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445967EF97BD75E59F9A49F7659BL1PR12MB5144namp_--
