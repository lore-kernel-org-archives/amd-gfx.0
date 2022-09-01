Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C4FECAAD1
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 13:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB6610E712;
	Thu,  1 Sep 2022 13:45:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B44510E712
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 13:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVlJicGONhv7TmJ3kt8jSINLYye2MS/7Mpq0+yJ9y/Y7iEKmEdR2nb7Vn5p44EmaQwIRKd06JFyzu9CkFBNvWqawNNu0NkKaKKteMktWUlyXAXVnFXinGC7W4NE+lsbez9T+xc0PjYCMtfADm3npQu88mkB4QnVCbZ4Ox/YNrSHNqzbqmcr8qNwD0Q7ythkIdn7c4Qu7LxMAGnF8tMuaBksU8tDayQSMGqn+qW7aWziJdQtYoPKQm1rkB+k1/WGE7HJZo6CoYBsCpoVQyRzw0sG185kmVJK80u6G3ySa6u9XAPnXMeLxb8gHvglcKygzt16Y2be23s+O3HV+J3t5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kocYI+VZm2nRwoetuNC3wz53X2v2yLLuBO3JrnQamO4=;
 b=oRvdCgv0wDtWlVoal5PLF8SuaPwvU9/PRLMxUhyqaUb3srsuL6OMnY7tyxGDbbG1j//dIsMG6m9md0CVKtQ2CHY9VDInkWBEdVNFwr9Qw7cdaGYG2qkBH6osztpvvYlWQCroKz1Clxixe3uWaevfdHfu/rTTFiColoW+DZAVliIqSbEmJW1ACa6BjNSce+Q/+p17SQd0rjzcF68aeJLYD4J9S+qhozv+LVT1r8I1ceWJLveg8UN8fNoqtLeNIJEBrEbYPI/qmTqJnqs+EstkXFoHnRjLwT08wLyB0XQJU7HnOW2eJyw4uBHx3ioYweGm95eyPKgUVE66Z7iXWr+RUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kocYI+VZm2nRwoetuNC3wz53X2v2yLLuBO3JrnQamO4=;
 b=GPxBaBQzQ+ipi7ETtaJv0QpsA+ZUIpfidJiSt6VeKMeJWTBczKdLr5xxsruJ+Pi/Lf1tpoKgeB732468KxiYHFO4unVcPGVnioP5F25x2Gvzka4oXa5BKvF8O5RVHmYcxPaWpWkv0cEoMDUFuMqpo5QoY/vYtkiQ81zPPehFc14=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 1 Sep
 2022 13:45:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 13:45:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Topic: [PATCH] drm/amdgpu:  disable the debugger on gfx1036
Thread-Index: Adi9n5u4QBhFsURoQ4+Un9d1uHtasAAaUEbO
Date: Thu, 1 Sep 2022 13:45:43 +0000
Message-ID: <BL1PR12MB514432E58FD45F048A29BEE3F77B9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <DM4PR12MB51525C1D8C1E070C54C78301E37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51525C1D8C1E070C54C78301E37B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-01T13:45:42.857Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f5031bd-5712-4469-676e-08da8c2043f3
x-ms-traffictypediagnostic: MN2PR12MB4191:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oEvYqu5ZMETkz1e/XD2urmWvMBLqe2RZj14QwH0SrNHXXdt0eGCWJpLG6BIEv872J5Js5rGjKoUdepih9jdLzZa7VpqLKpY21OzWMEKon8IQ9IBnRiI4o+QxjFPfc06MrGdrIuj74plSG4sIt1rK2mqt7lE5iRRr7WSLZU+Akd7l28JJlEdyaHhQv6kFCfp9MLkPye9N5Yr6HfudJU8lbV4SVP5a7hrqNWw4xUIyZx91Aq8NWzjlrqyKPgYlbKwOf57/K4d0007GFQ+L/cVvCe1YYC9oT+F5Qr8j/O3KFaf7qjctSwvbBGKIEh83zmEj66gwlp03NefgQj2m4YoDiYgQysMu7+df33lr4AU60/yeABsmFc6IlG+RZmP8xiAANMt5nylXAbfo07XG01QvOLIBZ0m0HyI5vkmztGXpyWt0MjbxQ9zz+WW86VJoKwej9vm3Hb78iKT1hcqKTxtmiR6pbIcthTAO49h89/limNi3J4XVsz313DIEhOd0YTf+7kJ+3hcwMNskTniUWUcbXXexyplcGN7WmqsgRp4ALbe58EDxgyvDIZ0FVkijcF7oW2EzqWCk/BV6iXAEpnKtg8YYoZAJzwJLNfb8ipoIDKOlOEidM9Anyndjpe7P10fAnVSsbCzqrEOJBuyqWtDG6f9XC45iOmVHx9XQhUClFD+JB3O+NPgSx878d4XaRqXb7qXCDiSPOrusSiAbuwNEoaVzEaveTFEZCOlCBZC60DFVhHY5StXIwFzJ9q843VO4GWeAdW+ht/h+Nk3jLt7mXyY7fAmY+DSaWrl0vO3UsUn/nyI6Vbz7Yfli5/osUPJm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(86362001)(38070700005)(33656002)(7696005)(186003)(6506007)(26005)(53546011)(9686003)(41300700001)(19627405001)(54906003)(110136005)(71200400001)(55016003)(316002)(64756008)(66446008)(8676002)(4326008)(66946007)(66556008)(478600001)(66476007)(76116006)(5660300002)(2906002)(122000001)(38100700002)(52536014)(8936002)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CzH6/htIPfvWVTmhpCmHO9qDPsunEIb5oqazCPAxqSDkpTwlsSszCQZmLOCi?=
 =?us-ascii?Q?QqbFs5MyP1pNR3/sUWz9QkLkCGGBvp2yAQEjtQkIde9ujfGEymJZLtmateL3?=
 =?us-ascii?Q?CXwh2Z/Xxw7/7kJW8VLJ4FmWPRognNCiqG1lLHApycZ0uaZbvUj3DOzWno38?=
 =?us-ascii?Q?6ceX106+wvxAIXNuu0X4T/utU27yhqhJK5QGXB4Xf39mZPW+JopBMp0QGwRd?=
 =?us-ascii?Q?CD3JiZyarCpXsFGBYyRvbgID5YIYoNT7fPNcGP6WKnZm2pqagftjfJ/bBofn?=
 =?us-ascii?Q?GCg1byKItAqL1pSauHdyh0DjknNewYoAxNeO5qjjzXH+xqO9MNXumCzhwOc9?=
 =?us-ascii?Q?LLOGDAEuB9NJiAxuCLWPlXWX8sOMD3yM97ocL6Pe6/x/hsCpnU9vZ9iHdAB8?=
 =?us-ascii?Q?IPSA6HGl45dZBsiN4vqzIxwfosoazudiNj0OjN5nWixtiqH7IkUjcgdzDPot?=
 =?us-ascii?Q?4vNKiG7cjCuYjAxnLL71dpGv8N2TXtVYx003yFkfVjjoaWF19rpkjGUjsgKN?=
 =?us-ascii?Q?GhvhEDV9d5n11fV3POPHzmF94tZJdKppVzuQ+/+shcD1EGLt+N9z56ewbJrz?=
 =?us-ascii?Q?wIA323siyVT6JzKOODfvu8dvSAooOvLIF9VXd5mkAZDpiMVI+Cmz7/FVJj1z?=
 =?us-ascii?Q?RDNKh4YzMhyVhwbYZKueB3ICm0xlX3hXkJg/l+cw7oeoZ8mLFzdkqIFqt8YA?=
 =?us-ascii?Q?71UOxRcBth9f3BDitD0KLI+gPtha0D72W+In/xP2H8vGP8p22JEM1FNRbcVs?=
 =?us-ascii?Q?vhbC7AjU5teB8+f4FBkNHumQCRpi/19QZqf4bx7hwqzQbnNKcoxfzt4CCP//?=
 =?us-ascii?Q?c6ykT5ZwRry/wHzbJeJpFEw1tTi5Ase/Z+IPbmW+v/mq+a/peRKR5vN/GYU+?=
 =?us-ascii?Q?vcG/DXOnllsQrWBsWo8J2XEOxHjfh71yEzmvXNfMaGf5/I29EGxK3sp29iaL?=
 =?us-ascii?Q?Ba4Tlb+vZDbSMaoMunCdbvHoAxAVZujfgYpFT0b4uaQvCv+c1VZJiiIjk88J?=
 =?us-ascii?Q?+4dSPbUW6NKge2Y0sLY1pSDh7qcU97Ve0PaQ6cY+0/8elLgTn2UYkREaPqRO?=
 =?us-ascii?Q?BXfqkdG1aua/+jkK7EL4zN2GIYGmXjLmtWM0NGDbmfuiOUI7VCc+2hkCF5vy?=
 =?us-ascii?Q?yDdr1dOz0fvHAEcBcKd8/e5+pFGQHYnnZsq6d4oBce3d6JCQ6cGNuSz6L8L5?=
 =?us-ascii?Q?ksQADtTE4Zxkvy6xxuY858woWED3Pfh2ps4iatG7CZ8fN7eXFq6gUV7i0LVs?=
 =?us-ascii?Q?SfvQBh4Ze7n74E/mS3akbixRo/L7EUhA/DkpqB38Nrr4mRxR0rRbaBlfQgGy?=
 =?us-ascii?Q?jEVTsWLebIH/+E2uqAuAE9mxhUkA5XH+4T8KDBPoR/XGqQKNp0LjrmYZMJze?=
 =?us-ascii?Q?iWQicypHvqAUuX50Vj6/xyrwzihBseM+oZ4DJT9YI0OeQJooyx6fArRj26iY?=
 =?us-ascii?Q?WcdBFqrEttEGTfR4n8m4G7jYDcqLaDre3kLb88Mej0EtZ8AV3nbcZGlQ+gMt?=
 =?us-ascii?Q?pNzUDoGJYfjaI5sVTAB2eNHoLWulyyfrybIoxoYJ0qLxR2SBGszRUM2u+RTH?=
 =?us-ascii?Q?QYD5gL9LgZl7uZCHEaA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514432E58FD45F048A29BEE3F77B9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5031bd-5712-4469-676e-08da8c2043f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 13:45:43.3057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HG5RhZAL6wHX/7cg+ZrAwZCFsXPIfFpn1DHt9QP+NvWKNG1m9YxxXUSJPRcbWLnmcEJRgBfxuTXr1AeDgztFgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514432E58FD45F048A29BEE3F77B9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, J=
esse(Jie) <Jesse.Zhang@amd.com>
Sent: Wednesday, August 31, 2022 9:11 PM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: disable the debugger on gfx1036

[Public]


Disable the debugger on gfx1036.

Signed-off-by: jie1zhan jesse.zhang@amd.com
    Change-Id: If1d9608d508d1eb29e6c1de7ac7d1db93d1000b0

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c
index 5ab20f6dc291..89ebb3ee9ccc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1097,6 +1097,7 @@ bool kfd_dbg_has_supported_firmware(struct kfd_dev *d=
ev)
                break;
        case IP_VERSION(10, 1, 3): /* Cyan Skillfish */
        case IP_VERSION(10, 3, 3): /* Yellow Carp*/
+      case IP_VERSION(10, 3, 6): /* gfx1036*/
                firmware_supported =3D false;
                break;
        default:

--_000_BL1PR12MB514432E58FD45F048A29BEE3F77B9BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Zhang, Jesse(Jie) &lt;Jesse.Z=
hang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 31, 2022 9:11 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Huang, Ray &lt;Ray.Hu=
ang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable the debugger on gfx1036</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
<br>
Disable the debugger on gfx1036.<br>
&nbsp;<br>
Signed-off-by: jie1zhan jesse.zhang@amd.com<br>
&nbsp;&nbsp;&nbsp; Change-Id: If1d9608d508d1eb29e6c1de7ac7d1db93d1000b0<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c<br>
index 5ab20f6dc291..89ebb3ee9ccc 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c<br>
@@ -1097,6 +1097,7 @@ bool kfd_dbg_has_supported_firmware(struct kfd_dev *d=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3): /* Cy=
an Skillfish */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3): /* Ye=
llow Carp*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6): /* gfx1036*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; firmware_supported =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514432E58FD45F048A29BEE3F77B9BL1PR12MB5144namp_--
