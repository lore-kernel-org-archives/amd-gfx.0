Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F51C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 15:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04F510F024;
	Fri, 17 Feb 2023 15:05:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED33F10F021
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 15:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fb3K+jRKEPFs8C2y/2Xdrhwnk3BFyFevavDyZV5Rn2hDJQk/mEB4Nl/SejGSh2shDbC0T4rQ95H4HFapl/PKaQ+/UW7/OrLFkKzB7eTkTbpLtj7/TJn/6Ummbg/bzz0bqQEr5gRyW0NbaOlWHZmtapfEMz4f48g0fgeDXiksz8EaxcsKQIz0zDuYl3a8jDW8QL9UQ7JZIWfVZS0e19akTNWOawX0DdkyBel3dQHo1H0paGbCUSu+B/Fu3BvhglWIBcBCp2N5p0xqjFZMA0J3DUYpI/RRTHNcWxhYaP6tL5CVsca3SKG+NH5JUFXiSKZmz4vRcxEm4PjaMqqL+XooSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQxlwzVAg01VqJLMb1xa6nLmDRjAprIB3wXqkJd0HxI=;
 b=QuZSCLcaN0kBFqX4RV0UgMlTT/1tVUGVBi4f/MsTj27khX3Ue3w4E8sSIPC6U7dr3hXwAu5R+3PgzkFj7OVKHs1tHG4Rta9xil7MvRdXxUIbEpqwEOvNwqcZRAFuJAyZn4jWnLslKk2uOgdLxDEZoI6Tt4JE7VXWKE7QnfOwh7zaXNdAsLaAiUSn5xuiVrWTZ0xZQZ3G43X4XN2fmrFQLzeNh+Ev7Xhbkz0XVoPZiAjBSg5txeXQUe0dDUUzhdaUXZ4+m59fThQpcOHq0Y6i1qEzX52MlfkKkwW600H4KwO8eyRucge4aqrYWthnyNG0yVWj1ceRVxg/3NhU0KWeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQxlwzVAg01VqJLMb1xa6nLmDRjAprIB3wXqkJd0HxI=;
 b=wdvCOxInlZJ/rVL8xNJyS8/PeF38M1d7pd/UAu9JcdUn8sI5ZCXUDkQqu1CEbLtZVYIH2MFxolIlXJH1lMrGg4nnd/xCeAt5ercxOMw4Qrl8UAftl5siewBw0N2TqVRAmxz+ylryv5sK5QARJnLeUh8z4wwqCNex0/1QmFm1IEQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 15:05:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%5]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 15:05:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH]: add tmz support for GC 10.3.6 
Thread-Topic: [PATCH]: add tmz support for GC 10.3.6 
Thread-Index: AdlCbv0PHa8imUi5TB2aZmqtcXRTNAAcg1Uw
Date: Fri, 17 Feb 2023 15:05:38 +0000
Message-ID: <BL1PR12MB51441BC27F87BAC2B7BA0733F7A19@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <DM4PR12MB5152565187819FAA3A7D1AD9E3A19@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152565187819FAA3A7D1AD9E3A19@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-17T15:05:35Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f84417e9-ff38-4f37-87f3-eaf5b8f0f5a7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-17T15:05:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4d7e684e-3dab-4a37-a1ef-7ff100a7ea19
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ1PR12MB6025:EE_
x-ms-office365-filtering-correlation-id: 240b4d36-f91c-4070-a0e2-08db10f86de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3O+79R71UGpMMutzvbZENbgIiY1sXHbAuiFJAb5q8Au6b8OWPUoppgJlxqDFi9ZtSUyBspf55cqqFAisIvmqqd/tUWQH7q54LYGiyUCOs/VpqD0FVacgOwzYhX8ewRZ4DjNIzlakRlewEK1w67xykTSvAsALurFomoFBByQaKN1depI0clm7x30ZfoRypUH4s908yrUzZuJWvz5CyMcvMgj79GN3i8xsSPPQmQUvjQKtYKZjeow1LtUke+lM+q+3dS+zZfClcEMpZ9xuXAijyol7Oo5RsIkIxwUOlI2WDgSBSkgSuTmBt2TgeY7jeTWygyqQeA02OD6t9+6O58okyJ+95OY6BU2sBfbHGkV3IxM/8NQ5ZLuctn5ahRoFC6lvUeiRVHFkVN0H3Ra6ezsKK4x/uU79wpD2NFX1JVoDTzbR3O7xqpCLrPZBb+DWvXbcuQzPKTH/GxLB2KaTxE4nHBt09l1XIrgicBUimvKZNAa5lltJlfHMdKo7nXrlXM3aFjk3XK3uxTxAiId9T0shg4YnvW8q8IK0vU7Al76bronxgH9leuDE1lIZHuzdyy7FqtJkc/uhT+D7HZ2LOzIXlDtXsslMct93xRQrnWMLvoX6/7+SqTFw+BT0FqmFG+TIN+8iN2Crb24iLAN8/NNP7tWVSLchPQk4Cjgr5mDxwJHSpj5Hhhske4/XQGS+9ntLeVJlRTxsl7Qy80ZxGdqpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(76116006)(9686003)(83380400001)(66946007)(64756008)(66446008)(66476007)(8676002)(66556008)(316002)(8936002)(52536014)(4326008)(5660300002)(41300700001)(53546011)(478600001)(186003)(26005)(6636002)(6506007)(71200400001)(110136005)(4743002)(7696005)(33656002)(55016003)(38070700005)(86362001)(2906002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vy43bzvX6ZhQfl4AqzwmFyiFTRzI6u205bHOFgJy5bmgSN/BRcOkichS9YeI?=
 =?us-ascii?Q?dJhV0uikRP2v1dTVoG4g1ycO74G6UhNVYzwqDN9H3qrBxlk4ZsyYUIVJfVur?=
 =?us-ascii?Q?3Gm8UGiOEN4CSRGdG3Xt9vuIlqs9f1tozux6FXK2JKmvXTzNG9Rv/sm34z/+?=
 =?us-ascii?Q?I2MzL8G6vRpaBYiQsEeOXX8joAKHvVIoMqWW+/EE0WGZJzoULRM/mWnFIXyG?=
 =?us-ascii?Q?hw4enskFrA4mLKJd08mUu3ljRqYv2MKOIHZdfpQS9BmSD/1lHBXpG0CHp8Fa?=
 =?us-ascii?Q?LF4CIMTMtM0Qhn5K40cKfC1WimWmHfEKgSHPYUGYDbc9skylC+uWerlgn1/V?=
 =?us-ascii?Q?DNnKuurbaiVL+CMr8rLVkpJVmRCW94IT9N3SWnBWFGdpr1H8JA17Q4TTQpsU?=
 =?us-ascii?Q?GnpEXYUVN5scwO6on5NIaSytvGgKuYJBx8AXpVuaTWxzzygOYAcvPXmwVRLj?=
 =?us-ascii?Q?sunpFnMwBrCTsGq5P7W9h/mDVulh+isxxDCouHMKZKi6gIV74XBX8KGj7Rl0?=
 =?us-ascii?Q?Xy0p66H90XgiKE9TyyNAz8FRk3ZFVESz0eXiIaimiwo5q1RbtCFVT9SFvm71?=
 =?us-ascii?Q?LyEKT5BxZrXcm62x6+0O6O1SJ9+0q2PmyxJEQl8hbdPhXRAsaYBCi49WVu8o?=
 =?us-ascii?Q?kpWtuTqI0m1j5ovHr8+hlHuiNbJwC6IeTJlXf+gfR5RCrdgQA0N7hdnHoRVr?=
 =?us-ascii?Q?F3+4EP3EyEbw0tWAz1OMzLhVe2gkrMPKBk22sGw1suBZUZ15czAB+Qv2IdTs?=
 =?us-ascii?Q?w0R3YvVw5wFk67N6OmGiqlOqDZZFWIoP346pmvHpOHePbjTfRNpWKe5Y8N2A?=
 =?us-ascii?Q?qmr3j3cqvDBiCamKynANIoH/WTF7+kO6ZLXrIfeQW8aSyXcS/ZXAOeFtH2nN?=
 =?us-ascii?Q?wDdTrzaAgbl7P4Xso9+lddbYPnCuobCAP8v7nd1Fz9mu2dMsjQkqnT3iO2D8?=
 =?us-ascii?Q?ch5va/485ZqsbQrV1OgWw9Fbj4ntm3K8yeio8ZWpeZkY1HEHv9iCVDo/FFQn?=
 =?us-ascii?Q?mImfvLXYb6zvbbEuU2dbn/qP5OkmAGsbCcjmsNQ2JXVs7Z0uJ5gV++Ts1+t0?=
 =?us-ascii?Q?V661EkQNh4meV+i4Q5O2PerHWY9uy9TZa04IJeX2L9MmSOAZVPONd+iGj79+?=
 =?us-ascii?Q?7Ga76DsEl9qY1BVMTVlYOIfiFVk6kwiN/4O7B353ePLsyNjdBBcl8W8c3jri?=
 =?us-ascii?Q?zJwPH26qTU5zdP9H7iQ8X8LJ7QEP9ga7J2yK22p6HbxCxrYlc24/4aqy9G9D?=
 =?us-ascii?Q?iJRoX1SJOtNM244cOACCgUEUN78lFsEqM1loNV4/Y2JVEC7NPTd8LU3j6yWH?=
 =?us-ascii?Q?eaVsTE9G5eWABmd1PgKlnXKRw0VZp97fvvv6RNsY2SRXpMM9TRKFvumfsfkQ?=
 =?us-ascii?Q?E+qFLIkMQ1I/23quh4mgVzSh7wlXtzcJ8VT8UoD673HEgcobF2ycokQp4JFx?=
 =?us-ascii?Q?GBuV6OeIF/xNyb/Bw44amagsOTWYZK6kRY2E24naSEJu81mQHUT0DZzZwvnt?=
 =?us-ascii?Q?Eoy1oUhZ4oZG/yk1jmaP9iv8+djmOLhHEdOOx/2cXGnNocITPjGqIksNV0+L?=
 =?us-ascii?Q?oiv4wm9Fzg0G5YIVYrw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441BC27F87BAC2B7BA0733F7A19BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240b4d36-f91c-4070-a0e2-08db10f86de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 15:05:38.4469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kpehwawe7tXSOK16VeRnBiiDZflPqTo37bdc5aZddgVxaaD0UQNE/w90P9OKIl0SPxmi6vb8+0aSyRVlTu5aiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51441BC27F87BAC2B7BA0733F7A19BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Jesse,

Your mail client seems to be mangling your patches.  I'd suggest seeing up =
git-send-email for sending patches if you haven't already.  Patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Thursday, February 16, 2023 8:28 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH]: add tmz support for GC 10.3.6


[AMD Official Use Only - General]


    drm/amdgpu: add tmz support for GC 10.3.6



    this patch to add tmz support for GC 10.3.6

    Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com<mailto:Jesse.Zhang@amd.c=
om>



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c

index adfc7512c61b..6830f671cde7 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c

@@ -551,6 +551,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)

        case IP_VERSION(10, 3, 2):

        case IP_VERSION(10, 3, 4):

        case IP_VERSION(10, 3, 5):

+       case IP_VERSION(10, 3, 6):

        /* VANGOGH */

        case IP_VERSION(10, 3, 1):


--_000_BL1PR12MB51441BC27F87BAC2B7BA0733F7A19BL1PR12MB5144namp_
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
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<p class=3D"MsoNormal">Jesse,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Your mail client seems to be mangling your patches.&=
nbsp; I&#8217;d suggest seeing up git-send-email for sending patches if you=
 haven&#8217;t already.&nbsp; Patch is:<o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.=
com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.c=
om&gt; <br>
<b>Sent:</b> Thursday, February 16, 2023 8:28 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> [PATCH]: add tmz support for GC 10.3.6 <o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; drm/amdgpu: add tmz support for =
GC 10.3.6<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; this patch to add tmz support fo=
r GC 10.3.6<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Jesse Zhang <a hr=
ef=3D"mailto:Jesse.Zhang@amd.com">
Jesse.Zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p></o:p></p>
<p class=3D"xmsonormal">index adfc7512c61b..6830f671cde7 100644<o:p></o:p><=
/p>
<p class=3D"xmsonormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p><=
/o:p></p>
<p class=3D"xmsonormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p><=
/o:p></p>
<p class=3D"xmsonormal">@@ -551,6 +551,7 @@ void amdgpu_gmc_tmz_set(struct =
amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 2):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 4):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 5):<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSI=
ON(10, 3, 6):<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VANGO=
GH */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_=
VERSION(10, 3, 1):<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51441BC27F87BAC2B7BA0733F7A19BL1PR12MB5144namp_--
