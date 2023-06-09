Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE75C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 17:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5399110E16C;
	Fri,  9 Jun 2023 17:53:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F2910E16C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 17:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD88BJpaslfPtMswS320JV1zT4pw/DKpfm73Q0mhuZSfAluV4fpcjRstrKWB6sZRQs4nJgEpBTDjFvYo7yba6nmsqpwjJ+NFAnhunCKVAbd0B5zRpLZA2ukM+YvYzoVvuoNrEiH6AL7X9J68llpXBszh4UkFC7yW9N4nbvwkXlcqhVhbq9yJRUaQDSUfzUiWS9OUTxSKjj2WFsdVBCDslg3QSl56Yysha4TzAYrbsrjN7LJR4lSG5nWLBhJSzUdaQh0HVVwyljnVlGfuKmlnEAvagskGy7Oc9Z4T7zsHYaae7T+1XfTnXKgCZEWdkiK5Ve8/onwfyQhByJxN2pIQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyT/ElSSJ0JtdwGCA6gQLlKvAx2S3/oTvuvcG8dAESo=;
 b=nttJbfx5ZNU2vNtcu+LBcU4jGpvsp9svU5ZjiSSUVJcPoi+PwJspcXDP9guHFMu9Q0OkoetUayYr3fNhI2/hX70KZVVCGRBt5KTAsc7lxiDZy6mKcO4AfiK3Qv23ANJsDCAbAE6L9PC59zP1DjnHVlPmJYsI3xmwrTFu3ze9aG+O07FAL5Yo/puTcW20d0U8GzLY0EmFHsnsqwqchDMwMGEEeNkvG4Re/ZZDo+MrPJUzjoNXbxiyl2iMyxFkWWRsjOUTTQGAe/wo/exoTyCV3MXqhMxNK4U5+n68QIUwApukEG3+EDPV4SECuLQzRpsWh9dBRg/UZgqOd8o4k3cw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyT/ElSSJ0JtdwGCA6gQLlKvAx2S3/oTvuvcG8dAESo=;
 b=yg81wsFEQWP8LSWp2z9Z0U87duy53SYPIwDEKd0Xb9DjH31gtaa9uR7ifL5z8P46j/z9M4dApkuUmiAg6EIkX8n9Wx2N+Pc5W/12irWqSJLaHUesRQDXku/GzwuJtSTGP/4Z6+IzWmESShegeTEve23i1bf67yozuUlk1nUVI6Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 17:53:28 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:53:28 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Print client id for the unregistered
 interrupt resource
Thread-Topic: [PATCH] drm/amdgpu: Print client id for the unregistered
 interrupt resource
Thread-Index: AQHZmpahp+FMs7n56UqO5gNo0e0sDa+CwVVf
Date: Fri, 9 Jun 2023 17:53:27 +0000
Message-ID: <BL1PR12MB5144912444296729BA98D530F751A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230609055225.3531614-1-Jun.Ma2@amd.com>
In-Reply-To: <20230609055225.3531614-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-09T17:53:26.874Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: 13f4f41e-1e1e-456c-becb-08db69126e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khg9YrChBELidgZfEQJU//7keIexVb/eOGicwpprkFGl2bZv7p+uk5JIXdzisjPcmpXlJDjhMpcnE22TIpaJ9I5hfHwUp0b8EC4eQFpKYmFloGbOxDGO0MGKHtrFTOpwZLs9GVO//oatYJnuJjouHAd7KDdAN06LYrv9g1rCA/ZEmADvWh/MLhHifau2qiBiSPgWetgmUoTYbHaewJuw2pyVwQMWFyHsPTlN0uYEV5hRJDGalUOoNrU/hzT/utHGRZ/gYOtRnZWhIUG3KascSUgdCWUeQqJeuNGM3SNRSBBKcF+1Mj36rdtM5HtGdnzoY5Cxz7+O32Ql6D04iBCCXkvvuTeQlcIHVu/H4FM9uZSsCdfB6CT0AHtGxaQOdcqffR+1VGGBpVafnswJa3/2L2zhviVMcweSJwlJtFNmC1ITIbGfKOEyO+qoCcTx6c2lD3kdADzVF3jFKaPrSeZxNVr1DeyGBvYYbIRUfoB3QTyfFnAru/CwIVzTLq+MtZjhyFZ+7Hv+Gr6AzH8ysn9yM1qcW6Sc5MnNL4ipC1lHA1rg7YFlLp1/mgC9JGdJVcY3WDS9fVMI9hdOsyHHQ8MDpXHLXrGeWpNN5pdqtaLUHL9hERegW5mxKuhZUZCCNo1B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(33656002)(38100700002)(186003)(122000001)(478600001)(38070700005)(9686003)(53546011)(6506007)(83380400001)(26005)(52536014)(6636002)(86362001)(5660300002)(8676002)(7696005)(110136005)(41300700001)(55016003)(8936002)(71200400001)(316002)(66946007)(66446008)(66476007)(76116006)(66556008)(19627405001)(64756008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8p2mOh57z/mBlqQf7rRuddsbEG8uISK3Od9R6nQQ5Mp9623TOU4+I/bRBpWK?=
 =?us-ascii?Q?0JxMPg6TbiqCh4suMzi1YDvyQhzGzhJorTmIQBd91/xmnPRzZRXZe75vLZOS?=
 =?us-ascii?Q?qX7+ZlxzKSAKe+JOOATh6tycTDUnWFqB+ym94QHgSQnih5XNnjAQdD3CBbnv?=
 =?us-ascii?Q?ROt+RpgwNl2LN2YmA+b90OrjJJ9jUC73S/6v7vRelU6suOQM+h7roW8Xyj8M?=
 =?us-ascii?Q?5Arqy54R1BVmyPPs/TCagPCubx4emXp9l4h6g5u9BVw6Z8xxQ/hRFSYo4YZ9?=
 =?us-ascii?Q?zTZgXAKwdQP9iQpobTYN41PRokAXW+GH6EYXY9//Kkc4zPo3W0y4QXnVu6C5?=
 =?us-ascii?Q?MMxDsiDqDhatDO6xV/NDCHLu9c1zRNCj3ThFbdWwoqpSAOxZklK35tZQncID?=
 =?us-ascii?Q?aRFZClK791r80Z1q4G1a7YbIUEriSNT3LFjP4hIZtQbz+6Jfn/uAk4oXOQae?=
 =?us-ascii?Q?p+sMug/ayDLF/8gnXuOzdh6wREfmqT4ff0EPiLmNlh0/yJkanvV5QmHEHcU1?=
 =?us-ascii?Q?ryv0Cl1ejnP2Rz34Kn4fwY+NVJVgww8CtYoPlX3ocnfVvcdRaKDGCqr5TZbv?=
 =?us-ascii?Q?0O+NWD9kYjxinXYvud0t/Ns2oWEqixTgxMJzq8WToeNRAYVdlbOsN1Xk/kXR?=
 =?us-ascii?Q?esLFhJZCKMk6xh3tzKcDCzpng48cZKBPPVEQqWPszOXLM134tZGyaStI9CvI?=
 =?us-ascii?Q?/oT49zHm6Etinf0OGm8rkEaqcbvrqxo25FTa8IA0avnzggsO4zx8NFua+lxc?=
 =?us-ascii?Q?XGtnMX49QJyI/i8FRoVXRLJkb/ox8krWN0XBmTvJQjuhLHbubM8Ugd9o2rCP?=
 =?us-ascii?Q?uHdKanUoeQd8KGMcjahrkO/ja3knucx8ngiean/RghLjneKe8NPZmhANMBPt?=
 =?us-ascii?Q?/1i1Boz7dCETfgSM76NuGP7VroCy9ywy+O1/RvkLXifo7TqdHRbPPU7VHvcx?=
 =?us-ascii?Q?AqDo9xsb/yboXYSAxPICkBzxMzkViZu6dw1nTuQwSA8aedBAl8WFH8ctMrxb?=
 =?us-ascii?Q?KkdWNr0akX7NXvG5dL97344pMPLIj6y4j9SC9oJIV1hqCmcPQ5/f57cobzSQ?=
 =?us-ascii?Q?kROfTYRElsr3JOj3Q/cr2+HWp82s35zyl28VUvSd22yjtl2+juHzwRJiDnMs?=
 =?us-ascii?Q?smncSFRvC2Et97LSiW4UfZMXEP4zPtraEIffgm4/W89Q67X9RD2SxQGJLXEJ?=
 =?us-ascii?Q?tmOd7Fzmj76iWM/tY8Z3pnommY024HxVnr8DqD97+Ev0Xh8qUa6Z9lewvS3X?=
 =?us-ascii?Q?hfreVav6ZDbXJb/zyROWbmZLInctMaAsq+UMcQOOF4NP5YBoAhKY+27YUybM?=
 =?us-ascii?Q?MLoPRwQK5+JV8wTfeQo7BErS6HnITh0RgWI/QoTeyORmsimSGPuvkc+LPMkA?=
 =?us-ascii?Q?6EAXdUsU6zTjL/ITYWq966DOeseJ28hSLE/fmQV+Faw1jGvv8pG7dkt1OrI/?=
 =?us-ascii?Q?jfzvNzNNO9QTzjB7JEYEkcwcz26DzotuLZo/sq1RQeZ8CMvGgZmMXBnELu8Z?=
 =?us-ascii?Q?jxzRZxhEgEMPww9iQ+lZq6tPASmzJGwhb42yyP1+IWrzKZW3gE/6xjmHJt3O?=
 =?us-ascii?Q?uKW/C0VBqLISTV0ozhg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144912444296729BA98D530F751ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f4f41e-1e1e-456c-becb-08db69126e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:53:27.9520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35qrik60gZRZslcNjSkF+BQ5Zrmp55e7PMAGxS9uLWxDeCSXs5klotAju9RsowmDQ/k14vtj48eQt7Cq0DgU8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

--_000_BL1PR12MB5144912444296729BA98D530F751ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Friday, June 9, 2023 1:52 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, =
Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: Print client id for the unregistered interrupt=
 resource

Modify the debug information and print the clien id for these
interrupts as well.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c
index b0808c1be013..e6edc67ef010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -486,7 +486,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
                         handled =3D true;

         } else {
-               DRM_DEBUG("Unhandled interrupt src_id: %d\n", src_id);
+               DRM_DEBUG("Unregistered interrupt src_id: %d of client_id:%=
d\n",
+                       src_id, client_id);
         }

         /* Send it to amdkfd as well if it isn't already handled */
--
2.34.1


--_000_BL1PR12MB5144912444296729BA98D530F751ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Ma, Jun &lt;Jun.Ma2@a=
md.com&gt;<br>
<b>Sent:</b> Friday, June 9, 2023 1:52 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Ma, Jun &lt;Jun.Ma2@amd.com&gt;; Ma, Jun &lt;Jun.Ma2@amd.com&gt;=
<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Print client id for the unregistered in=
terrupt resource</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify the debug information and print the clien i=
d for these<br>
interrupts as well.<br>
<br>
Signed-off-by: Ma Jun &lt;Jun.Ma2@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c<br>
index b0808c1be013..e6edc67ef010 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
@@ -486,7 +486,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handl=
ed =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG(&quot;Unhandled interrupt src_id: %d\n&quot;, src_id);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_DEBUG(&quot;Unregistered interrupt src_id: %d of client_id:%=
d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_id, client_i=
d);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Send it to amdkfd as we=
ll if it isn't already handled */<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144912444296729BA98D530F751ABL1PR12MB5144namp_--
