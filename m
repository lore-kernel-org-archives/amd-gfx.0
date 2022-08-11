Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C76C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 13:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABC89B14D;
	Thu, 11 Aug 2022 13:14:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA9C0B0CCF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDObAL3iyFBom2UsCIBrp6LkNos0bZrOhH5V6BjiMkkmP9DIs/FZrZ3fJ3D0IPsv+h09JXOF8Z845z3yOZ+7wUjpY3TjnnMez/OXbJ2KXNkR6uW9lA/f466RNqQhtu7AKLglUWhdYZ45uvBbojXjs5TopRGzzgU6KgFjTo/MU8JxaWx5DHVDlJUJS65PDK8pHzJkTIyJZ/IYoId5qnnzryDAupfDN4Hib/lymGJBfgISY9DBXx2rqXG4MXJXg5vNNlH/ymwYXMGroL88jIFc6RMgMUXFPFJu5VVu5QwDKp5nh7E2qbYdbbuUUA57WvpTPoMoRUM9ivJYvnL7VbM3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsq+uHr3CXz9+RQO04+dJa2mR1rmsz2SRcMXowtPDmU=;
 b=H8usdViO6el12rz6r3UHI/K22xl3a/1opbbdJ1bAvT6fct8f6N6mMe7CwDt3cU5lac6WqUccgNpvFC/OC4ft34lC1yhrcvnl9Kv0VgB7pvSxmJf0GURFFqCgE5+Dj2UH2CQ9frtIXT2Y046VJUBmhAyoQpv0cTdoS2V71WmTScPA6J/W2ZWOqJYYYLDYwR18CGe7KYDeCye0T1nUeOkx49D27CWdlDUIfZipIIz61ndbCiwOmucHkchX+96NuAsOpL9t+QMfblBWfk8OzAznPnvYFcOy8VOFClIhsPOUy40/hIkIoCYivVVUK7vcVq/zGaOBEfjAndSrG4uv7LIbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsq+uHr3CXz9+RQO04+dJa2mR1rmsz2SRcMXowtPDmU=;
 b=jk/QUo97JE4O1oIwhqU+broLVOBKhy3bjLw/xXxo2xRduKih0MJATKmTG0uOR2Q500h05uIH6/hNQQ8SWspzf8mupTIKAKDqpLHc9TDXCyk7bmU5TinhSAbX9frOCihxODbskqJdvB8zjGrkAUNk4YvZM9gl+zoSmf17EsKtlRE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 11 Aug
 2022 13:14:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 13:14:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 7/7] drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating
Thread-Topic: [PATCH 7/7] drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating
Thread-Index: AQHYrT8N8n102rf19katzJvJCs8L8K2pre5A
Date: Thu, 11 Aug 2022 13:14:16 +0000
Message-ID: <BL1PR12MB5144102BD01B4418C4A3659AF7649@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
 <20220811045804.3750344-7-tim.huang@amd.com>
In-Reply-To: <20220811045804.3750344-7-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-11T13:14:15.669Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f07d163-ebd8-403e-3d5c-08da7b9b646e
x-ms-traffictypediagnostic: DM6PR12MB3931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQBGSW2QtTQymjFDC/qqQDU0hbahLd3Cw44Swq9+5uTUMAYWzNqsQoz+0mPThl3D43fnaehOYmlHOM5I8egwKBvPYAEtn64vbVOeVQs7mHFvKWajurB2YE5GZbHwGzmKHFGoF9lpskwYusQxM/iyQgGkj+ddumIB4yxuha/aPbjHWEKGeHVwRl+DvOR2hiRAca894tlWYENwKz+gNDCGoV8sWVPaIWzvmHZtWt5AajdyFnkU0Pw1IV8yxf2UJZ5U01i3XT1yW45JURaMWSx/ieMXxWwwG5+EdH4wW8cntyCmAw9K/uwEuGOm7M5DFdvZ/OKuavFaPrdn3y4J4k+SL9m3mhIidkBdK6SAGvT1xTM41aH0BpyB6k1jfPK2FCz83XVl0be/oT8db3znPpJhOrS2FEeOymRQ1HO8yj5UePYlZrBh90RGXwo6HjhXwABWI+q/bdvWkSRtMByODuR8e73fiFc0omnnNTanVPEdHVCs84S53WaUMmyseLhYx0gCpKqFkV+hiUl+uj9fJ8At/BMBqQwvZ5U3xL9iyxKkpDs8SVW3y2uVUS3ai5PLI8uoyRygNOkBzkD0/uSyXLGJ1n88r+xdSk+acCpWts0UALeNJDX/+8M2bIlAdgZ2YYq+z/vBYWSNvoJ/RK8+Nb4YJDVlVpVtdg9pLEr14aSN+muq/qAI6HkatMlAoyU00WFYiRmM+wRsAc31Bm/wmxjlgQP3qa7LS0L0dGvw7d7LLN7jTk7NbmnL9kD4nrvWtci93A7dujGgb7saJAkreWCP7W+SW1p+eua1LYhf2nUwD61Y4a9g9iiLZOy7yMnOmVw1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(54906003)(110136005)(71200400001)(41300700001)(9686003)(26005)(186003)(19627405001)(2906002)(33656002)(66556008)(66476007)(8676002)(64756008)(66446008)(4326008)(66946007)(122000001)(38100700002)(316002)(86362001)(83380400001)(6506007)(53546011)(7696005)(478600001)(8936002)(5660300002)(55016003)(52536014)(38070700005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIMLNAiLFhqDAPQjrSsaNxrw0Atz0mAMs7EF3PXX81JQuwyk2i9iIEhhBeW2?=
 =?us-ascii?Q?nDCIQfO3tTNcnlQ1swhOl7Pkyoo18rtErJEvNo5ADcZ2es1ICcFbXVSKXw3I?=
 =?us-ascii?Q?f3VdX5I7vk3F9LQzs7yUFvClXEbNMev92QLjTuWyEgM4wv7ty2l/cTkz4+68?=
 =?us-ascii?Q?ZraOT19oQci7tmnHN3myxS2V/4G4oGg6Knrh83A8U3Yg8/zz0Lw3rpTBP28R?=
 =?us-ascii?Q?fP46cNmeWuEQoRovlhiwk7ggeD/JT+/RqIJ0RHzX2xAxNYEJdNzKNMS31gQM?=
 =?us-ascii?Q?MSzUapf3QLXVcQSiubGUxe4hZjustoHkZEeFnr8NAINApDjSllXBKnrPaTkF?=
 =?us-ascii?Q?gSMsMObPl0HtouqEIA66ai/SdSLggl7t0wwlkEx2QsOaT1O5e+xgMeSeJMYN?=
 =?us-ascii?Q?6tB6RlNIoYDQZ6gCPq/Ghm3IXh/+rOvrEp9jS1llouNnzMa1QAlLu+KdfuHq?=
 =?us-ascii?Q?BrHMJsgc0t5zUZuE862agDRIhz/pMSuDaWjWyJYksk04NEVMBhMihYRlV1uP?=
 =?us-ascii?Q?eRJt7b8Y8TnRevOCgwIXqOmmtblu3SulVKT2S4POfYEjRgZukhVUe77+z2J/?=
 =?us-ascii?Q?e60/2GYGddI1Fp/i4oThzqKWij7/vOKZnq7bdWF1LDaLqGO/qbvu5IUjc8LJ?=
 =?us-ascii?Q?COn10nf6gV9yX6/bmAIir+S9du6Q1XeJhlxu99KtaXICiChlq4zb9k5hAN6w?=
 =?us-ascii?Q?9eldkf8A5m72FZstC+vEI7MdJSTySivFB81IQeunmuwl35L5HuU5mw93K4Mt?=
 =?us-ascii?Q?TsIBNUz/Dk9NGumtp+27cGJTk5AX8sGy6ENLvK6MKSbqvQQI6CBToyrwPzGR?=
 =?us-ascii?Q?8KfAgUuIR5TI6yJJlZf3/e57+AgY3Bz2XchZlOlHYF5kJkOFLsVka2DVCGQo?=
 =?us-ascii?Q?GZA67LvrMyp/24/NZ8DJ4H09Nq3zpV6ylsxqa5ajcUYxVk7lsgKZXifA+oH+?=
 =?us-ascii?Q?FIYzn5TVzukjd7OCFiQ9Q6LP2eV0hj8pjVwXPUbGMLO0hnL97ucVdYt4M++u?=
 =?us-ascii?Q?pus7lxmGtSE2sxrddvWw/L/ErAs08XObg89MRQ8cghaNdI8qIUn7nrSVkpxJ?=
 =?us-ascii?Q?fLCJPAfEMTd5B2lPAv7l335yjI551OSkzQ6UgzN1oTVcH/F8ysAEkGnB7EsT?=
 =?us-ascii?Q?pBw7XoGmH8M9b03I81rqeMHCv0swz/2t4JZbY43OFiG1w+WK0HjhcV/pjnFc?=
 =?us-ascii?Q?+kwedyrZR87HFSo75pS6kx0ixU3x3dWvF01kMdxcnPnBo6oyoMwT3EBq2S4i?=
 =?us-ascii?Q?oBFDmCOMqQ7qUy8Mp0PTlppgGyXaWe8UutI6+6Vj4fZBT5Pj2lIFALYstK2l?=
 =?us-ascii?Q?O1YzZV9EfaErimS0nn9yQKRHipZ4eod4mpvZCu20YmCLdQcLMb7FMg98a1eF?=
 =?us-ascii?Q?z9rSDxfSW4vXrdYoPiOA/Ax0LjeVHCFuM282Z6ghXAjxW1kNNg7exJbRYAPE?=
 =?us-ascii?Q?sV9uZZFpZzBm8MSQfb9C7lw4e+f4lrNh4QhONlep0rP11WcRHKMkyf12vWVN?=
 =?us-ascii?Q?ttEKOiwrpsRvGG08e+0EWQSXcVRpNNqLMt9Lrj4MF5+ZzP4J7/0ZgN+SjIL+?=
 =?us-ascii?Q?DRiWx2dhEgdRcn0dOps=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144102BD01B4418C4A3659AF7649BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f07d163-ebd8-403e-3d5c-08da7b9b646e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 13:14:16.0971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yMxD3UM36fvMdiv9OWhx5JmUFTjzlrK75LFAIhwY3aIBQ7b4ltvXoiYYwoSuq/lPUDR31rIschuAKZQxquwiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144102BD01B4418C4A3659AF7649BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Thursday, August 11, 2022 12:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd=
.com>
Subject: [PATCH 7/7] drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating

Enable AMD_CG_SUPPORT_ATHUB_MGCG and AMD_CG_SUPPORT_ATHUB_LS support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index d9e5bae82e83..6c3440e7ed3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -600,6 +600,8 @@ static int soc21_common_early_init(void *handle)
                         AMD_CG_SUPPORT_MC_LS |
                         AMD_CG_SUPPORT_HDP_MGCG |
                         AMD_CG_SUPPORT_HDP_LS |
+                       AMD_CG_SUPPORT_ATHUB_MGCG |
+                       AMD_CG_SUPPORT_ATHUB_LS |
                         AMD_CG_SUPPORT_VCN_MGCG |
                         AMD_CG_SUPPORT_JPEG_MGCG;
                 adev->pg_flags =3D
--
2.25.1


--_000_BL1PR12MB5144102BD01B4418C4A3659AF7649BL1PR12MB5144namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 11, 2022 12:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt;; =
Huang, Tim &lt;Tim.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 7/7] drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable AMD_CG_SUPPORT_ATHUB_MGCG and AMD_CG_SUPPOR=
T_ATHUB_LS support.<br>
<br>
Signed-off-by: Tim Huang &lt;tim.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index d9e5bae82e83..6c3440e7ed3f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -600,6 +600,8 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_MC_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_HDP_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_HDP_LS |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_A=
THUB_MGCG |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_A=
THUB_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_VCN_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_JPEG_MGCG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags =3D<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144102BD01B4418C4A3659AF7649BL1PR12MB5144namp_--
