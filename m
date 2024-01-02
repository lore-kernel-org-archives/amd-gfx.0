Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C0C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 20:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063C710E12F;
	Tue,  2 Jan 2024 20:46:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA2010E12F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 20:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI0/H+yog3GMhunsZmuO1x4mK6TAKueqFjAou7qujw1rgyo1xf2nTRgSOZNcQFXPMez+2E0J6mOrafTQ7c+PR3whkqY8y6lg7k9naeJC8aswmxLLTy60WLfW864RoPOPQNuFjF9AGxBGx87Odq0oK+6I+X516CGEEN1XKI/EHQjI6TFN/tkdNu/1+qVIDeM3Gp3yN3UF+KdaHbjh50OdWTsX+R0KAnFWq9cvoh+GHEwYasqGhkBb3D4Yo1q14oY8cGanhAIGYyNDeoA2HhxdF+GiXdyvNzbI4cAKA0VVasnWObzJP9x/Bv6eafcxVu2aDuP0RIaHcxR6quJHdOG6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CcZ414DJ1RW78Lewd0XeO/9JTPdf1EXmNMAPj6a6w4=;
 b=CWq3/IazP5rhi3zpseLugb0HqRmS3QaoJLPRiMl2StHY9jp51KFYITapFHptE3ZHXUnY7YKQFG2WhDLKpA/DvcSGyMOB1iICdgz+ULsAMFTno1v9mGn6u6r1/AGzLLqn0jmpbUrE2vGo/wmHnSMvq23zBcUWPMhfx+C+aUl1MpkccKBZIdxSV6eeGaKdZYHHXt7ppGeMcVnCKYbzMKkLf0NaE3tDOEkgf/cjMH3/vSxSNHKlKkZj4n3q2V8mAw83Jdvbc9lV6Ahs1Ei5gOODnUeWQ1oBFQRWGV2crou38/BOpGWIQEC9pqYp1X61R5l2Iz8PImbqJty8lt5c1vUz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CcZ414DJ1RW78Lewd0XeO/9JTPdf1EXmNMAPj6a6w4=;
 b=5f0qxzWB8BU/MxB/pou7LO+9xRekKozFMHnJ+oobC5PxxqIgE3nsHYP1WDOf8/VTLOz2UMpXOoXdTs6OdBB54++blZHykR3ovyGybWdQiuB7dct9G1qH6pJWWbD9+qTut9z16iwx581xSjYo/3XqC7wen6Ubiv8uOAArwhsoWDM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Tue, 2 Jan
 2024 20:46:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:46:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Remove unreachable code in
 'atom_skip_src_int()'
Thread-Topic: [PATCH] drm/amdgpu: Remove unreachable code in
 'atom_skip_src_int()'
Thread-Index: AQHaOjuKdv+IK+LAmkGPr3mMVP+UU7DHBPLI
Date: Tue, 2 Jan 2024 20:46:25 +0000
Message-ID: <BL1PR12MB5144A04F22BB8E0B744F191BF761A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
 <20231229094326.44657-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231229094326.44657-3-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-02T20:46:24.247Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9165:EE_
x-ms-office365-filtering-correlation-id: c70766b8-97d2-4db3-f878-08dc0bd3e2d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhjQdSGVh2Dv8NGBqhv8+X/qDbOjDFvseYyn5Rlu9P1shTB1RvBcXfRmCewCae2D1GM3mnRgW82rKKeOcZkC5/dxE2DkLZynWJDJtP0zVW2GKR9PBF7iOx13BtveIHJIvlIzVxVgRlELI+tVTVLGJQwNc6X7GEw/iD1YpjeOfb/VROTZSbAqhJFu+En7beEznJy5O6dRPIMOIn0WUqsqZMGqwIA4InoWU+aw23gWi9iecM+qCFxhE7vJir7lHOLQU1F6RkHFveVz9TF6iqidn+L/fi5fP3keUGjzctxZc+qr7fVhlVkHItkw4sqY2Jg3kz17oOae0qKXIAohcPjujwGZ1qF+tf/SGnCVGQ+enBy4MjPl8a2hPjKFOEtgudTpGRpvSefjYer7QBTw6eK15GFzSrq/UN6FQokRes8uoWcj73pCwEjSyiVsIEKOlqi/QUpfvnPDSRR17bs8JBHplNV7kJKF3MIMSzg56hGMEW6kfaojZXgMEtjZzGT/OcSllzLTiz/4iE8tGNc61rp0L+sjh7YTxIU7kXz8XPidNZPoPtqOKHrAWmJQljcks7oOVMa4FsVaptiuD2Zejw/G6qYpeEE/mvkjYDLklS/2WCA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(83380400001)(6636002)(316002)(66946007)(66446008)(76116006)(64756008)(66476007)(66556008)(110136005)(122000001)(55016003)(86362001)(33656002)(19627405001)(38070700009)(71200400001)(52536014)(66574015)(53546011)(8676002)(8936002)(2906002)(5660300002)(9686003)(7696005)(6506007)(478600001)(26005)(41300700001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gnyBLSWSGCpRkZLmsyzql3me4eab9Nyixw35H5ZjlBNyN+Awvegfh1GpOk?=
 =?iso-8859-1?Q?bkrSmdvOGde6dfSdysjcDLwUzwJpEUMR2c4d2C0MWE1CNkfPpwtQyFpViq?=
 =?iso-8859-1?Q?G3f84APpG2x4vg/YNL6Kj/0W4P4BzWOI97zs/2qHlBKUGDoflaUvuCgnWw?=
 =?iso-8859-1?Q?tT3UESI0DuD2FeSSiw4z6F8I92Gnq8fCOypbgWVw7HTdGnJHrRZKuKCrhq?=
 =?iso-8859-1?Q?jJm+qeCB8HWxW/HD32hocg2J5ROn6VGaI/7/Q6RCzVCoPDJwAnoGI4mt1U?=
 =?iso-8859-1?Q?FRPyRqzznfSeyLIxEJ04qoyg3AFJnW9OAzU+PQy9JQ2v0Ix/AMXQ+4ag/D?=
 =?iso-8859-1?Q?+YbNtuCUb9nHsJRU4nFB/VGMtVOcyK1zr2zrE5StwfagGp/EnJu6p+6daQ?=
 =?iso-8859-1?Q?XPSEGUwVxKgDgUSeU7a7UkjSNUx87b3daRogfgiES8lHB4ER/sIbgGz9r7?=
 =?iso-8859-1?Q?CicKQApQtNcH+g56jbqzsdjEyK2KCh5WmaRlUoOcFbl87MrH1uNtNMT9nW?=
 =?iso-8859-1?Q?LbtoxG6/n2oFmiwtCCvYLDUe/o7qWIvvA6xl4epGHJWeMJt5puQlbaY4H+?=
 =?iso-8859-1?Q?VriyuqkM1lSmqSJGlEhSkkgYalJZcp/JWqzKvzyh7s9863JF+vtm6lCxG3?=
 =?iso-8859-1?Q?xD2/edVAkHUVrG3b+8EnHQyEhkSwJfm6ns1woIWg854rqqHLsmdXv0jNEh?=
 =?iso-8859-1?Q?LqwHHLXMB769q+drQ7WLkQ6lcwBWLl90ALRzsVQU/nnZ+72/OSeoGzD1X2?=
 =?iso-8859-1?Q?CqNsgKhY9RMkOXxwHxR69L3oB9qs8h5PCrlqlBxNk/qMYQjJARJPZ1M5Zq?=
 =?iso-8859-1?Q?VKvbNiS91PEUUGIPSWr3UqnJvvOqqVBsA4lVbgXJSk6BANFgEArxvp+Cz9?=
 =?iso-8859-1?Q?jaPbMbTIeyd6dw1sQMA7okP1bXDHLdOoRq2RiAG77imEWvvn30D4M3frY3?=
 =?iso-8859-1?Q?y5HceXHRTasrfi0A9f3L7Sfj9+g8uf1hfl1fwAScMhRkDH9Lt7AMlkB8yI?=
 =?iso-8859-1?Q?BORzcShuKcgyHrjFdwyvEbMCH70u6B4lWBa3rE8SJFC0h1TGCFvRks2ai8?=
 =?iso-8859-1?Q?u5+ZIB+k+Ihv1nV7FzEbIlNIMDDrNUblYdkxgjTrZ9m/EM9dlPTxxMj3Z2?=
 =?iso-8859-1?Q?lDCXAlFpBgE6eIK08kqg40KAyvi/e0sIQhQwUxpmHun4NK71BPVakQ4WBW?=
 =?iso-8859-1?Q?fPHxyeZA6VgBeyFCE97Vlf6Jt7hto4B9I1uZudSD92OfWBci7EI3++Xa1a?=
 =?iso-8859-1?Q?iSGtcR4vJxgM+GcUMxBcRw8FH+N+Bx0h0u+PEgoYGZlIV5bKX1BzciTXWL?=
 =?iso-8859-1?Q?ZurKa4AK5AYqjUvG3KhVi/o/5j611hSnP6WvJCyimKFBx9Ksk3bsiZwmLL?=
 =?iso-8859-1?Q?WjzD7RxRgw3hgJww57m3meTp1U7AwQ5nv7ZtjqIIc40Ismh4iS1VFH1lPy?=
 =?iso-8859-1?Q?W2jctiSyk2FJcOOrDAo/D61jmjefTE1T0McF6751KrbLMh0L/52jFAvjdY?=
 =?iso-8859-1?Q?n6VTk3kbqbt03WBXKO3dvebnuRxGajIhAx2UsFPHtbfnj1Mzso5T2mx85q?=
 =?iso-8859-1?Q?r3RFLcZ9Q0Ll+FwWE0y3zeGGKaIWdbLBK8ogGm8uom9LB/APPtanAGgPvU?=
 =?iso-8859-1?Q?lw0thIGmBwSpg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A04F22BB8E0B744F191BF761ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70766b8-97d2-4db3-f878-08dc0bd3e2d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 20:46:25.0905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woB1b2hOlggy40uiNPB67B+0s0mDH3rrA+8NmOeFCZ9V0rWzsGAcxqPTMcIjq3LstKf32inUWF9nX9XTkGOtag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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

--_000_BL1PR12MB5144A04F22BB8E0B744F191BF761ABL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Friday, December 29, 2023 4:43 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unreachable code in 'atom_skip_src_int(=
)'

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring un=
reachable code.

Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index 2c221000782c..a33e890c70d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -395,7 +395,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, u=
int8_t attr, int *ptr)
                         (*ptr)++;
                         return;
                 }
-               return;
         }
 }

--
2.34.1


--_000_BL1PR12MB5144A04F22BB8E0B744F191BF761ABL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Friday, December 29, 2023 4:43 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Kuehling, Felix &lt;Felix.Kuehlin=
g@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Remove unreachable code in 'atom_skip_s=
rc_int()'</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring un=
reachable code.<br>
<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/atom.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c<br>
index 2c221000782c..a33e890c70d9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
@@ -395,7 +395,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, u=
int8_t attr, int *ptr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ptr=
)++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A04F22BB8E0B744F191BF761ABL1PR12MB5144namp_--
