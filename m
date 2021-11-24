Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA865C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 14:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8E26E1B4;
	Wed, 24 Nov 2021 14:26:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99436E1B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 14:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOGD5ke+NgMdVeAmuJgQppxKsNZw2UbETKk8RpQCCImZBTn96jc/Fk2NxTvzaOt48uJ9usnj/qMbtGUL0/seqbjGhpW+whNu8pYBzU5jdODH6zy5ArpQQIxmD+uOH3vwcbiwzmU54QImfHieW9OMNWFoQYWl8aFUxr2LQ+3S4byY0NGW3aRfX+VQGThSYkiPSeiQF2gVbPz+rf26o1q81ucQO74/HO6k4v8IJhJIfYIry2QlWEGvs4HrqHWW/pYaHGCiPna+RuvYuz/zeG1sK7fcWLStAIUlGgCeXsUhLw3MrAJbPPA4mrE2LK7QsUGP7miIxB+YiHwMolhu+onuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j3lXdJ8swOFruZANlrPDtE3AowlqniaiwpU8WEFrbI=;
 b=lo9r3WRJfQD7/9G3Skuqndo337l19+dsiAk9ipYm/i+tFqAvMVhrA11JhCMrGwl0qRm0sNpKDWXYzoUMoHx/cuzVqFQEC28Jl0z4YK07cZYk2v1BtkUBwGHaPPt5LJrDLa+KeyiVpOpJlhjP+DafKKs8TeAMZCW+RTZjTP0b6bZqIES32cUJzEjuCGb8GGgmFTGG65/+zORlN64oP1W1dqjTNuZMnggEA57tInDubfnfnMgaR3eTclDdS6mnsD2DC7Cus1ObL/IcIgd4ZH0KqpW37VkPQBxMEPTJCDryaYc17LpCBwmdN9INYO23nd6+MOMZlaYssUjSxjhXmvEpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j3lXdJ8swOFruZANlrPDtE3AowlqniaiwpU8WEFrbI=;
 b=H+fY8h59ypGx14CRJ2dEXzM4TtJJWbcA6ylBhjx+n1dfd4xiBwdrzhkcrj86pqHCD/8bReGkmvtOQnAv5qyB569YViGDGnZ9i/HLzQ7ouUzjdJgyIPFFPXZy5g98CTe2+1PolrA/rYNLWk/B7EHm6AzUI2doEHIT3EFogu0ZsL4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 14:26:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%9]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 14:26:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: check atomic flag to differeniate with
 legacy path
Thread-Topic: [PATCH 3/3] drm/amdgpu: check atomic flag to differeniate with
 legacy path
Thread-Index: AQHX4N0MchiPDwNg0key0IBV7LjtvqwSvNgm
Date: Wed, 24 Nov 2021 14:26:55 +0000
Message-ID: <BL1PR12MB514456B0696209DF06C60768F7619@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211124024302.1493100-1-flora.cui@amd.com>
 <20211124024302.1493100-3-flora.cui@amd.com>
In-Reply-To: <20211124024302.1493100-3-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-24T14:26:54.526Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: c7b89958-b49f-aa20-c66a-e323a5d85e6e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f391fa-c5fe-4f67-5dc0-08d9af567731
x-ms-traffictypediagnostic: BL1PR12MB5061:
x-microsoft-antispam-prvs: <BL1PR12MB50611651E36ECD3A5D5273F6F7619@BL1PR12MB5061.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKwearYW82v9xDZVydvjPa5ko5T++oRI2TRYEFJHsH8j8Dkt3Af14EHYKwlQTbx5/QGTu2YPhDu/UBfBxFVeFgJ0qgkN2hUlspRfYYS5SHvEvRCiCL09dQK4wDgBjD4KGU3GOYVLvNPgi9+lDi4KLQwTHYXStFNdj0DQwOhOJ14Aj84OVrOQLSc85UoD/PF7awZM7bV8UdF8a/cM21bexGuLGGR+EKG5cDipKSXTqz1mK8fTbAo3Sl8hIS01Sissh6NQYPW8cWeoAY37KuzCcAzl1AmUYdyAHcxLKsZIj6EkmoiV3MKt3AAl9D1xZdaWKKmIDsG4+WLysHudgKTp7blTb+M+tZD0eE8kUjJ86T3cL8NEy4hjBHceGp5za+96MDPXD9gTuHKPVrPK5c3aVzvG5yiXOjMYlh0CjZm5mvlSH5d8gFPskE3x79yVajorVCldQ6Pjah4/LkdL+NTkQ0IOmR3jvcCUwdhWvBoO/c+G1nmMWZYR2FUUWF4ZvbvPa8Bvx/CkoYjd7/ImMsmU7QJjNYKU9oAFzQ6qjG3dqkkAc/WyreH9YjO4HbAfeKb/5q+Nr/IL8kcH6Guijg2k3EhlLfzipch0IQghxySUYTzEzDoRGV5LLFREv/ERav8CU8ylC6/FxGZ4pyswMSDWo9pwv6u1s2b0LJlP7+1CtqLDd3AtXehVmCmUd7v4DyBxpZ3A/d1kEem7s0+/WHGmZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(2906002)(86362001)(6506007)(186003)(38100700002)(122000001)(64756008)(66946007)(66556008)(55016003)(19627405001)(7696005)(8676002)(66446008)(38070700005)(316002)(66476007)(76116006)(9686003)(52536014)(110136005)(71200400001)(8936002)(4326008)(26005)(5660300002)(508600001)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iXFcSbex7bGprWcwdxzdtejD5mhUvLW+O0x0bjxU5imH3ioxjmXTyXlOGfu1?=
 =?us-ascii?Q?jUJXU0lu82c7Tjg2unjzR9ifeDw+hDOz9Cgto3tvuZWg/038EVColbpi3haq?=
 =?us-ascii?Q?v1Iv+eJrDbYCN3iZvVKlzH/REvG/v00z81T1Fz37Lfx65rHZEDdqivYrHyLI?=
 =?us-ascii?Q?iXL3BrNIG9JMljlpwmmWysWXlpFvtb2J6wi5Cy+PpiSsiqFEO2CzqDoiHrtF?=
 =?us-ascii?Q?qg9b3Qr/T9N/3yoWTmJnE7vjDRvQt4qLh4cNRDStAhO+6N3WWqiPsOqtYd1f?=
 =?us-ascii?Q?AlgR41oWNzYiEpSxqkXJuNDszWK29l2hd/sT6FpLb/F8e2+IpYYexCewCwDR?=
 =?us-ascii?Q?dn7A8F3NBdxIORRNpy6Bj9CikemvC14B0A/3oRGY9iMT3wxCGSN6oQ7ctxpY?=
 =?us-ascii?Q?rvnStuX6q5Zg3+yC1Dw2AxRMiegJu9EX9kHUbZWfqOxvs9usw1iHjKiIewi8?=
 =?us-ascii?Q?EE3AraHYvHTpdyxU+RqHh3T3fCtHxrjk7Bil7iZBNFo7kulePMx3W2E34IBp?=
 =?us-ascii?Q?Hlss1FiHjr9/EbGFAaj/3mjNIETNfvve8Hj+PwYxwkmnVZH/D0/B/AnR4Wsk?=
 =?us-ascii?Q?0ItwgrkzjqNqKDtvPP3ENA26pLQoyPyMjXPm8JGNMe4d07/rjAq6+LhM84lY?=
 =?us-ascii?Q?FZIsD4KjBaQ+bjEVxLmbfwPMcdoJlR6+PHl4TiM6f2962AD7jPnbo4Th7eyT?=
 =?us-ascii?Q?jfWULgDPDhLkvNTmvyOYKmCdUs+LJSGlqI3Xq4YRaKUuo2AB+DukfALRPQ7C?=
 =?us-ascii?Q?idfqDGRTWnVXQVXJBfok+2K/hfNwTdy/Px5a5GqPciO9mIPwaPIAKiRQtkov?=
 =?us-ascii?Q?j+dXEmx0PlLwDjHD6lz/4MBAY3Ng8rUY4d1ZEhJJZR6arPfCdyhxMhxm2Uwe?=
 =?us-ascii?Q?9Aj99Lz4nVW9CHNmP4Zz0QvU5ljom+894hHPMb5WVT1ZYgj35FDcp7MhI1nC?=
 =?us-ascii?Q?ObpfgMgLmyv1lHrhdfqQpqLKDyQKJqPxtY+apmD7GiKRayEDUF8IxWfoHB50?=
 =?us-ascii?Q?VkcTjCX5xSRE+77VbO0lyp5Bo1h9HtwnkrXQ23AzTlxdq/wjFG/0cZ+FzBfG?=
 =?us-ascii?Q?s7NcUJ10bpqb/P8DVZYrK3/4KUPW+RvVyb7j+H1aqjCWjLpZpYT8rgAz4tho?=
 =?us-ascii?Q?kl+wrVTzIV7+000i66pfdo/6JEirvbWMKxTseurvmXDpGbbEhJAYz7mDo/nJ?=
 =?us-ascii?Q?+8mXwYYt0lteK1QzPD/VlprB3nRRf2ToiDzer89VyxAbTslsohf50quH/IDf?=
 =?us-ascii?Q?2MRwEPbafjJbaRIyODwejYB0EsHlf1vItgGV/VoL1DVx3G41T5oanJKperYR?=
 =?us-ascii?Q?cur7SVBD/7mGkWnCURCuUUSM7lRIeuyZEpY0+ucck4S1Q7R/n3fxz4bJ8NlR?=
 =?us-ascii?Q?pOj1OWr+fG9fcXYKBY42jjBxh4964tx6NVO6uemXmW5xWmAW2ZSdIFVAlQnr?=
 =?us-ascii?Q?WpZwa7fOnVCyG9cSeKe9dSNPk13ntfVTtJtsVAaaFlymbHfdCLT7NX1my/Jj?=
 =?us-ascii?Q?3ySSkwaIET/1p17oL9fKwzFODoiWcM/aiDu5bLn7RyMwOJP8bQCU2srYvjKv?=
 =?us-ascii?Q?JkQ1pfzpfVsI7AyOrqQdi97UDsjVdPXnTASy5uYG/yasll3JI8KVN1Iu5bHr?=
 =?us-ascii?Q?vt2WoY+4NnWQyJEZBTWwpCU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514456B0696209DF06C60768F7619BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f391fa-c5fe-4f67-5dc0-08d9af567731
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 14:26:55.0541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eu7YbmuKbE5Uy1K1gJCZLTSrYJxyUg1D8G8DxjDcp6aHmnCA5MKC/20GQSVy77iIEts+TpdFFL3WVhUHC9qx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
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
Cc: Alex Deucher <aleander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514456B0696209DF06C60768F7619BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Cui, Flora <Flora.Cui@amd.com>
Sent: Tuesday, November 23, 2021 9:43 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Cui, Flora <Flora.Cui@amd.com>; Alex Deucher <aleander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: check atomic flag to differeniate with leg=
acy path

since vkms support atomic KMS interface

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
Acked-by: Alex Deucher <aleander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7d4115d52523..8e9e50aa4a95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
         /* disable all interrupts */
         amdgpu_irq_disable_all(adev);
         if (adev->mode_info.mode_config_initialized){
-               if (!amdgpu_device_has_dc_support(adev))
+               if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
                         drm_helper_force_disable_all(adev_to_drm(adev));
                 else
                         drm_atomic_helper_shutdown(adev_to_drm(adev));
@@ -5124,7 +5124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                         drm_sched_start(&ring->sched, !tmp_adev->asic_rese=
t_res);
                 }

-               if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signale=
d) {
+               if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && =
!job_signaled) {
                         drm_helper_resume_force_mode(adev_to_drm(tmp_adev)=
);
                 }

--
2.25.1


--_000_BL1PR12MB514456B0696209DF06C60768F7619BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Cui, Flora &lt;Flora.=
Cui@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 23, 2021 9:43 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher@amd.com&gt;<br>
<b>Cc:</b> Cui, Flora &lt;Flora.Cui@amd.com&gt;; Alex Deucher &lt;aleander.=
deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: check atomic flag to differeniate w=
ith legacy path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">since vkms support atomic KMS interface<br>
<br>
Signed-off-by: Flora Cui &lt;flora.cui@amd.com&gt;<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
Acked-by: Alex Deucher &lt;aleander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 7d4115d52523..8e9e50aa4a95 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable all interrupts =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_disable_all(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mode_info.mod=
e_config_initialized){<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_device_has_dc_support(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_h=
elper_force_disable_all(adev_to_drm(adev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_a=
tomic_helper_shutdown(adev_to_drm(adev));<br>
@@ -5124,7 +5124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_start(&amp;ring-&gt;sched, !tmp_adev-&gt;asic_reset_res);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_device_has_dc_support(tmp_adev) &amp;&amp; !job_sign=
aled) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) &amp;&am=
p; !job_signaled) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_h=
elper_resume_force_mode(adev_to_drm(tmp_adev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514456B0696209DF06C60768F7619BL1PR12MB5144namp_--
