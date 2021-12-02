Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BA9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 14:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0641E6EB3C;
	Thu,  2 Dec 2021 14:46:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AD96EB3C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 14:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3SgpF5vw4+r+nI+FY96VKzHp1rvqhiF+MNF6WyV6137r3z+fGdhRGzQuBV1WEf7KdjK0rDRJvPPyTJB8UG3SicWwGOEcS1JVV7mgRYRS58mBTtQ0JbxO1iHBF4j/c30aYOqHEf/pA0A+q18s4Iv6Szy2vi43EoGtDwwpJ9W1AsGqUh4500bpVro7EKaneF5Il2iweCySSxLVPE8LHK5/kc4NN4IWL668eVOgMMuNfoqmY95yHSt0sdw4aVqVQM0h6UiBppgzUDndqArqMbX8ImiXiA256oK19bDPwB5kc+xS7Kb3zmFVrFNodCIuuIX30VOhyYOIMYboH0xJT6jDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qxe2JQuRguWGoietZeGseLPLOR65YLwjUygI40NDmU=;
 b=hiZPvaPzV25SJ4Klr4WBAORSqSAgZEdJAdYiEL2UNqrhc7irTJFKwXO5ukMpQfgRkz1InwhEfdwWAFH5Hdkrz6bqvnaV6T8l4DNSE9Cr0zWZJZmJLsN0sOEJ2DchCAjAM8pIO64Re+PO3Wpzz7MlxdJonLCh4Bhe+1id6hMZcgchZ6u0+SxoeUUxPO3zS6zQ/sUri5nnFRTu/68OMfMisox5z+8XTXkcTXZsikRhm5Yv6hoZptvaxAw8xJiB7ZVVhuR7PbO++VxFPUmgNyqtAGHTfabZTYqc7iAnBxcfXA7oImytl3+/Uo+uFngynYD32sqwoI95mmZ2sP5pwz1T4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qxe2JQuRguWGoietZeGseLPLOR65YLwjUygI40NDmU=;
 b=QR4V1nWRVwFHKLwnCVUHh+4itttwi7m3hmyBvAhiEmxQjUT6ey/9v1DSs3TIsLS0PQgJFKIfPFszEo4DUnr7/znvu7yfjY8s14Aw7SL6PYb/qMuufUBrVaZwbLZdirJXFD56t8ABP8cFXgUijStu69u/yiCsd+c9A97XJbpH6xU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 14:13:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4755.011; Thu, 2 Dec 2021
 14:13:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Correct the value of the no_atomic_fw_version
 variable
Thread-Topic: [PATCH] drm/amdkfd: Correct the value of the
 no_atomic_fw_version variable
Thread-Index: AQHX51p7r4ZazbXAcUSKHFWJnPHtvKwfPub3
Date: Thu, 2 Dec 2021 14:13:55 +0000
Message-ID: <BL1PR12MB5144E0276BE14F5AB48968F1F7699@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1638435371-30851-1-git-send-email-curry.gong@amd.com>
In-Reply-To: <1638435371-30851-1-git-send-email-curry.gong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-02T14:13:54.720Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 4a11c599-b176-a6b1-94ad-9208585da9b6
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 948c2503-0f9c-40a1-f491-08d9b59df9d9
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-microsoft-antispam-prvs: <BL1PR12MB522390BFB79ED1800CCC0FFDF7699@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ0g2R+paeh9x05IgDepbtnvrwvFBRXosl6bl1NNN3An+k4ij9QmzKU8njwvnuxLtywnTQpr896lsIqpf90gjsFI957emOcoN8i4ngy/6guDPk29q0NwFro0LSASExmkM6Y7POlYCnXmWXp7LmUD491CWRxRXNSjNVv8OOk4VvsEDfVX09XsKpnRq6eF03pkbyzrYwfRbHXgBb+CCRIeHFivDINUqr+TC1c5I6hVP//1QYBFeMpimp0ESB4fe19cDBJ9gy1Idib9n+1T1fVgpsNiQBOTum6wwf2VDFVK8fPEfY2flU4/u8i/2IgIJQIIL6fLQaoTBwuVp4KMZ8rF412BSxbew8ju6SBLmShJmVPb93hfBlLD1jXAW9KA64BqpdR+OZExmucClD0r/mcvPaSZz9YE71g6EAkCX5zjrx5LDyQfvOgmgZdtnWiljbEHxVMSnU0MrXknEyPedtiRwHhXHz6oJGk/eGiNTWw/cKi8Xyi8vuzevYbW2pgvxd8NCsHj0HUtlx3Q+H93AaCtyILcSZvvKJuggdU3d7r8E/KlJuaJBUk4J65lxNa6b0L0EEUy5z1sgEms8GOg7w9Kuis2etlze+ydK/woL9MP+I1TPFvUg2Ogtp2dYG71kSIPi7di3SrN+ls5OGzjl8/8lJ2fWi0cadyp0vl5ENWzKOCvmB53Hqij8UmdVPFGB/XpTan/H4WjqseDe0w79Yt9hA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(8676002)(9686003)(2906002)(66556008)(33656002)(66446008)(186003)(4326008)(52536014)(76116006)(38070700005)(5660300002)(66946007)(8936002)(19627405001)(110136005)(38100700002)(53546011)(6506007)(66476007)(71200400001)(508600001)(86362001)(55016003)(83380400001)(316002)(122000001)(64756008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UzaMcznvqft5Gm8LIguY4mZN4yR4LEKL1sajdhhpHBczrve4c0sAhtmDwDZe?=
 =?us-ascii?Q?LnZcG+M1UeMnQIaOuC14cEYrzp9h45Jpd16IjRrXeFbUhD1UT6XFVFdDxWpT?=
 =?us-ascii?Q?iZx6FQ8LfZ8azDKN5cT0nGX6zU2+nb5snTmNbkP2NeeBH2fBs1Vm1GHChHGm?=
 =?us-ascii?Q?wjR1RcsENp8cYGHDBaE77g21useY97R3L8o3RPDAbYcC/grLxOJfEhp6BkNX?=
 =?us-ascii?Q?q6bBv//KiSlSTDduMB9nPZxa4/KEUigoWX4Ufu/WpEmfOV8KXMCzbUH5cRWs?=
 =?us-ascii?Q?DGiEEyvtAul4GWHSTkdkuljbkzhcB8CDZWNK13yLI0YL1w80RbyxYykBj7oy?=
 =?us-ascii?Q?eqO8jdrqw2kKYkeGCRcdFbv/ZSHJa9Rydu2+t5Gz+/uCOXUJLZeY/LgYmV3H?=
 =?us-ascii?Q?JrKmSRjSn0ftI/muC6eF3nq43UkCyQKX5NhVUEgJWFdJXPb4vjVyWdbMR3Pw?=
 =?us-ascii?Q?z6UafHfKwqkmALplwD6guYXSaBzTMwZi9E5HtrvOvukZHHCVEZl4pSU2kf3a?=
 =?us-ascii?Q?3VIozFN/1Kbjq8ROKrILMw6VY6fwSVRWliUfumTRh4FYvnqSIHMY9vvm4kGw?=
 =?us-ascii?Q?dovGyDFGv5PfKHOs5zdTp1EwitXryoU1Rk0gJfNZLt1sg3TC/heCwBKWAtpg?=
 =?us-ascii?Q?FfXbHQ/ePZbDA+gGho3XNDGo2sp7wTvKa2NgZOoIQ4Zw+kLGRlZ2BEvTo8al?=
 =?us-ascii?Q?eK2qkWOaCG5+8KZjI72vgNqCyzkdH2oiuW+kPNQUKWX2DjR3/i/X7HQx4Fir?=
 =?us-ascii?Q?9Fhp7WfFiSM0pM9KY2Lzsmvtfke1zljfht3mQgAfTFsAs45oOBHW0OVitIg4?=
 =?us-ascii?Q?0/rh9Z5E0V/ZpzvpI/M/fCzhJNuMzjB32KaxIE1bQdV1tUfpc8gPWC9zUXrH?=
 =?us-ascii?Q?TgmJ6l5JI49mOOn6wPQkKXvZ+PSjhXHgEkyB3zqN70FrnKlXdmIFrAiF7Dvp?=
 =?us-ascii?Q?obHE+iKhTMgWunuLWWBRnxqhWT6udRNfF77U2zIM37cqg0wC/9qs4K3kU/hQ?=
 =?us-ascii?Q?JhmI95jD81S4SvGjty9gDxvbtgTx/PK2VbivKd1o6jtPuWmtVfgXAcZGRXxX?=
 =?us-ascii?Q?/hp57R9uYiX2my+4FqDWaFGM7R9lgKLKWJ4/2lptNzjznom/uxRuNzNPkDtP?=
 =?us-ascii?Q?qi0CWCG8MnJ5w3Qm2c87V7gBzypiF7/aTuf/42iLHBECFhIBkUcC1tWxaSzR?=
 =?us-ascii?Q?MZ9V8jezeGCLgKxBJhdSttfxIP+q3rb2+O3RkbkL8Eg77+t4xiwmgTKGcqMN?=
 =?us-ascii?Q?+yhZdxS8wNqRXGA/YwiqQlWbii3kD2uw/vywFHDruK7fXE9MnnAdAjTGOWho?=
 =?us-ascii?Q?wmBwvCk9SRmIAfW9H8QtpHIx0JwyKKgXWlHZvjod4QvuxqyOzdjCXXrcCpWx?=
 =?us-ascii?Q?P0SMPnksB7TxG5XTZJoeRkM+fecwVzrcsxxCnafOk6np0J3pxsoAxAzEx3or?=
 =?us-ascii?Q?7eSqUuYJtBgFx2FLFXqdM+pqeTnJ8sjGMX6j+DeFRr+CkDfFvKIAFTrsHvjb?=
 =?us-ascii?Q?CaKALqbWEiur+hC2tXJas39u302Jj/F4rWKdTlFs/duiRCUOn4xKRZmRwOhR?=
 =?us-ascii?Q?Fr6ym24xdM8q3w375w4QDII/5SNvfCgIE+teGYxVirzi1KHF/FCIwwo3hidm?=
 =?us-ascii?Q?CVpVi9BUhzQj7cs0qdzYMtk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E0276BE14F5AB48968F1F7699BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948c2503-0f9c-40a1-f491-08d9b59df9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 14:13:55.4256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RILgyOuhgKDXOSyX2O2w/jgwCY9/hzPp2DpAKrBmHc+7Cv+0MS4P4Ay2sLq5jf1mglXmVyPtMYfk9SLHiOJCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: "Sider, Graham" <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144E0276BE14F5AB48968F1F7699BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of chen gon=
g <curry.gong@amd.com>
Sent: Thursday, December 2, 2021 3:56 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sider, Graham <Graham.Sider@amd.com>; Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH] drm/amdkfd: Correct the value of the no_atomic_fw_version =
variable

145:
navi10            IP_VERSION(10, 1, 10)
navi12            IP_VERSION(10, 1, 2)
navi14            IP_VERSION(10, 1, 1)

92:
sienna_cichlid    IP_VERSION(10, 3, 0)
navy_flounder     IP_VERSION(10, 3, 2)
vangogh           IP_VERSION(10, 3, 1)
dimgrey_cavefish  IP_VERSION(10, 3, 4)
beige_goby        IP_VERSION(10, 3, 5)
yellow_carp       IP_VERSION(10, 3, 3)

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e6fded7..267668b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -94,9 +94,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
                 if (gc_version < IP_VERSION(11, 0, 0)) {
                         /* Navi2x+, Navi1x+ */
                         if (gc_version >=3D IP_VERSION(10, 3, 0))
-                               kfd->device_info.no_atomic_fw_version =3D 1=
45;
-                       else if (gc_version >=3D IP_VERSION(10, 1, 1))
                                 kfd->device_info.no_atomic_fw_version =3D =
92;
+                       else if (gc_version >=3D IP_VERSION(10, 1, 1))
+                               kfd->device_info.no_atomic_fw_version =3D 1=
45;

                         /* Navi1x+ */
                         if (gc_version >=3D IP_VERSION(10, 1, 1))
--
2.7.4


--_000_BL1PR12MB5144E0276BE14F5AB48968F1F7699BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of chen gong &lt;curry.gong@amd.=
com&gt;<br>
<b>Sent:</b> Thursday, December 2, 2021 3:56 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sider, Graham &lt;Graham.Sider@amd.com&gt;; Gong, Curry &lt;Curr=
y.Gong@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Correct the value of the no_atomic_fw_v=
ersion variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">145:<br>
navi10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP=
_VERSION(10, 1, 10)<br>
navi12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP=
_VERSION(10, 1, 2)<br>
navi14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP=
_VERSION(10, 1, 1)<br>
<br>
92:<br>
sienna_cichlid&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 0)<br>
navy_flounder&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 2)<br>
vangogh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERS=
ION(10, 3, 1)<br>
dimgrey_cavefish&nbsp; IP_VERSION(10, 3, 4)<br>
beige_goby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 5)<b=
r>
yellow_carp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 3)<br>
<br>
Signed-off-by: chen gong &lt;curry.gong@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e6fded7..267668b 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -94,9 +94,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (gc_version &lt; IP_VERSION(11, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Na=
vi2x+, Navi1x+ */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (g=
c_version &gt;=3D IP_VERSION(10, 3, 0))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_info.no_atomic_fw_version =
=3D 145;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (gc_vers=
ion &gt;=3D IP_VERSION(10, 1, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_info.no_atomic_fw=
_version =3D 92;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (gc_vers=
ion &gt;=3D IP_VERSION(10, 1, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_info.no_atomic_fw_version =
=3D 145;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Na=
vi1x+ */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (g=
c_version &gt;=3D IP_VERSION(10, 1, 1))<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E0276BE14F5AB48968F1F7699BL1PR12MB5144namp_--
