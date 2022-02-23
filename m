Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86C710E67E;
	Wed, 23 Feb 2022 15:06:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DFF710E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htZz9Keph7uXXBmKjbBJFopcUWVHh18Pll7EPqjsuO/7ST/1gZULlWx+pa/G1GYqLvlUe/npaEKpAZE7SebF/GMIEQ1AQXoBUvC4M/UK7wRVyi4Niogpeo50eoeohgKbCEPIUsCGspp+7pjL8RmnR+yWAfxAp3vDwO73fG3ER8NG8EnSrY+zbP5elhGJ157398A+UDxVAIc1ISzAQkn+Z9zwpcLcdJYG4TiDpf98YboF7OI6n4bq9fe+couF+a5VM1TcPjXXQuF5gXb/Kx1Q81IKUQoWU8eeCnjmzoezBWiyl80MNcc3rk6DclztSlNjj+vzT1S6tp8SVKfMH0vb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZIwWDBZwjnPXmGpycv+X/PSYBYm91ZQQPdjBVpMYqw=;
 b=ofttt5ozy5TpKPz4Gj3zCsN/fOlHLEinlE5LLKDzy/TRlT/v0P9oupxMkT6oHoehLnpOqSFwwwLOPu1+niIVeVNSa8/saDl9lSJz7iEVwF9C/fmYbXE/zodzy6mAxCa6Ja9Kr/NHbosRhxl4vp0Ce24l0IlEfA4l7wxQoCAHvJIpEfQqdx70+xiRrCdaQcfrfv7ipwWpICI7g1cofzNRWwQqxXmV9hX2QzBkeA+lCyKrI5fmaQ/mr0uMCFwVuSJHcT44MfZQ8FAWgXYi1lWMHq2HE0DYdkcZ5IkmfGDeaGTNLSW1H+Lnb/FewJ2oDY7BIR0z8KHfu8wohGjmcqbc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZIwWDBZwjnPXmGpycv+X/PSYBYm91ZQQPdjBVpMYqw=;
 b=zXzYjpnAo77Km0p/X7r7TyfspwBV2ZPdbet7EE/340Vlyvq5rac2CE0OJnV4PdIddbNGpPCys3X9B6eppnUwcIGakzZr9AhO13FopbKhYrXg+Cj8E36aEYHHOLRFwWN/vWRNnKC3J937sJEuZ75M3aq81yzejWL0UeCAC7bprkQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR12MB1604.namprd12.prod.outlook.com (2603:10b6:405:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Wed, 23 Feb
 2022 15:06:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%7]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 15:06:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Thread-Topic: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Thread-Index: AQHYKLqpbZzzLiO210WR6xCLh9n51ayhPFLL
Date: Wed, 23 Feb 2022 15:06:26 +0000
Message-ID: <BL1PR12MB514438D37ADF99A28A0A8F5CF73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220223133829.21443-1-christian.koenig@amd.com>
In-Reply-To: <20220223133829.21443-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-23T15:06:26.436Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: b8eaadd1-891a-be39-bc59-bcc05e71e9a2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de40ce8c-0938-4332-991d-08d9f6de108c
x-ms-traffictypediagnostic: BN6PR12MB1604:EE_
x-microsoft-antispam-prvs: <BN6PR12MB16041F0915DF42028860412DF73C9@BN6PR12MB1604.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AcXvsrbuKNT4MFB1AvcWp0Eo+HkYUXUMo1xE4AirprFo+DlLK4Gvt+heuq0suzUH9IawZaXM3JGqyRvJpcPI29pbatZadSrJxQtV1Tx8FU3b4XlFVGMTPpEy4Rotnu7P0Ac+HW/isQhgqywWRPnKe15HEllGBjVeWsapwhnXULVgV7JmO8T/ft3yPySuLbYLXPol2mKGOWasevtZ7DuzjY5zZaqkdTrBBsr7rRjmQ+iuRRLZMY16UNhhSBYgLitUByVNi6+bRKAklv9j9jWpdQBHGKcrpOEF2VBQdxg4n2Xq3cafD8mK0mM6Ib7QqDtyWkT0KcOHgn6eiwVY8PwnHvYDBM5kwjascDlQ0O4rG+MXJPrfFfA8IypCo3L0Hp/mcJQzxjGDDsknj03QaobWO411+gU1iKUnl7zi6PPr9q8VkqcoIin15zLoleMQ8y7hv8jEKHDQQFOKTJJ1d/7iiMVpZNgN9+F/Yi26DGS9pe3eAmjcX9Dmm1wvrDYqQN61Cmi174NB8LVMvuSVb9CeDJTbxrEYrcNzowPWY702MP8X6gy6HCVownWFUtugD8pc+zPgQKZc+ZocxOXXWGjwEJj7Zikhq6jHi4ul9x3RuD3W/A9mybXIllGeSrFR9Fo3Ddaql3n1RPwsRyP3RaXZeQXgdwMUNFInQjUH7uWaE+J0wdXqCQrCYehFEmMRDM7rlzns5Zk3aY+3I5oTLiXlT6sosJL43c/MTbiqGo049DlW0c6HIwhCyi7MCzsd55lSGSz8Siaak/VSTZ0q3LkKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(19627405001)(316002)(38070700005)(71200400001)(26005)(122000001)(38100700002)(110136005)(66574015)(55016003)(54906003)(186003)(2906002)(33656002)(8676002)(6506007)(66556008)(66476007)(7696005)(66446008)(64756008)(9686003)(86362001)(4326008)(66946007)(508600001)(52536014)(83380400001)(76116006)(5660300002)(53546011)(8936002)(17423001)(156123004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DSsS4pCcy8GJQJloeBAUr+i6pdEuDLQ5EfKbuMS6xIVrPLuV5YKLeFl9MD?=
 =?iso-8859-1?Q?r88IVk31tCZe2+NCH/H7hJEK/9CRc3lunPZ3cyo3zdGQeMLGHpYgOuJ2g6?=
 =?iso-8859-1?Q?z1B0WncrjSAs8WSJE7T/pFBJYEaeqlTWRp9zFycDkR13WA75ct+iiXohzG?=
 =?iso-8859-1?Q?qpJEcoOtCg9gCUIb2jC8+9hi1JCWJYh1sJF8vSGIg2+WTYhMdQIXwn/IEK?=
 =?iso-8859-1?Q?3jyYki4OkeKws3klACXh+fdGFW5cQ8osBrmX76YK9UI6Hy7hguboeadfFe?=
 =?iso-8859-1?Q?LfB4MprVN1Eyb2X41bZsoWZE/pypo5U7MzFfuU6tjQaCUlfpjdKHuz9lNY?=
 =?iso-8859-1?Q?JC+8htNvhc/EpdG1r22QwHhsnWkKqdGsnPQcpfeDz1L4oeGnaSI0hUiNDF?=
 =?iso-8859-1?Q?sYdJXniE1/3TpRVbX+nHpJ2tPnXKjGuWcaVFO1OeXyjIAeus32XQVqq1En?=
 =?iso-8859-1?Q?ckQQeCPOqL22jcAAclmwhUG65jEmOnziZochvZNyd1kJJ5Bz5ATUtcxYpL?=
 =?iso-8859-1?Q?4YVPCPjXEd20/qravWwzb2PvpEiBLKRyVVb7xjdZdgfRd1DUF0E1nrlEPr?=
 =?iso-8859-1?Q?AgvmTKA6L81dNh7qJVjD7RYVI9kLGry+K2HHv308IJ9s+TQiTizS9BFDf7?=
 =?iso-8859-1?Q?9IKr1n7Jxo5hnDmzeCwd1rNflASrTTrofHavQyfAxSkTxEpZnFxg9iW0yM?=
 =?iso-8859-1?Q?FpM+n4XlF33j+VKS5Dxx49vCc9XrWL6LHx+ptdyujLoAzqDMnXDwx6zDVv?=
 =?iso-8859-1?Q?a1cyXMEw12+OZB5wKvrKEbfXJ8L6xWSK+hmZBuEWem7gdVUWjBiKL+HSSh?=
 =?iso-8859-1?Q?rev8AAZpDUM5KrHhzcXN0ssl14OMiF/9FA0EyXYDlm4v9m8dSik4bSAbKK?=
 =?iso-8859-1?Q?UOk8C/ZGYNEGlSWT9djh/+nAac2UJgtYbBnezFsLoSmQ5+vV+5x+UIyLES?=
 =?iso-8859-1?Q?vJb5EtSDTxyU3S1tMwiuZ77JEBCKhvan6IRiKkcvUwaJy0+lSLaeZCyBxY?=
 =?iso-8859-1?Q?81e/Ubu8Fh86zMQ2EO70mgm3m269hawermDmPzjRhItNZ4tMpwigI+HqQ8?=
 =?iso-8859-1?Q?uh6rZLD098vMOdvtnKvlzS38LLmHLR2uJSONb/cdHDQ4iMkkE/QK1RqNX+?=
 =?iso-8859-1?Q?xXfmAisz06z/sTZgemhh5I8nrt/Ib63Z9aU20LKmHmJrfehTzK3UQzMlOq?=
 =?iso-8859-1?Q?WlFisybh/C8vwrfMMv4a4HO1o4W+17z74naLqdj/3gMtT8Sz/cfYT+6hVy?=
 =?iso-8859-1?Q?OaLY1G3kzAjpxONF+EpCPS/YXlBocUSnoaj86ZHQuMdmdM57/50jp9Xr1D?=
 =?iso-8859-1?Q?5aEiIp2I0jNgibJKizdJuf8PlUc59Wf5758tolNE+Atar2xId6Tk5MNVhW?=
 =?iso-8859-1?Q?qsNEaZPZPhsaFLviIdL+yVTdQFYHBsMV7pNCDlGKLf6gHFG1Dbfh+9laaw?=
 =?iso-8859-1?Q?uT1oVow2YNWyCYVBR1GDasZDja/eCw5c7uep8eyoMM526V9/stw0/duVSE?=
 =?iso-8859-1?Q?ApoShnGZq/R0sTNfwThnn0tvzJCFAmuiheppNaXFFegB2B2B9OiCZiAhhG?=
 =?iso-8859-1?Q?0wbLJQa6v0UoricszxmeTaS+b5Vf1VgL/FQkvtUKk7KnBas7zOekhPOfI5?=
 =?iso-8859-1?Q?CCNbkaPRfN8cGqSGQQCHHkOQCsZj3lG+AAvSxIoKbNpERi2AgOz41ctSDc?=
 =?iso-8859-1?Q?xvOL76HyIGuXnund9aI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514438D37ADF99A28A0A8F5CF73C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de40ce8c-0938-4332-991d-08d9f6de108c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 15:06:26.9677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwwNY081tpnt3sM3GtWmt/n9HdBdb6wdNn2Az8GGm6ZikrM+u8ibQyNmJq24ivBPUM45cLWmHprAZbTozgbf4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1604
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Xue,
 Ken" <Ken.Xue@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514438D37ADF99A28A0A8F5CF73C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, February 23, 2022 8:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Xue, Ken <Ken.Xue@amd.com=
>
Subject: [PATCH] drm/amdgpu: install ctx entities with cmpxchg

Since we removed the context lock we need to make sure that not two threads
are trying to install an entity at the same time.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index f522b52725e4..16eb1ee600ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *c=
tx, u32 hw_ip,
         if (r)
                 goto error_free_entity;

-       ctx->entities[hw_ip][ring] =3D entity;
+       /* It's not an error if we fail to install the new entity */
+       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
+               goto cleanup_entity;
+
         return 0;

+cleanup_entity:
+       drm_sched_entity_fini(&entity->entity);
+
 error_free_entity:
         kfree(entity);

--
2.25.1


--_000_BL1PR12MB514438D37ADF99A28A0A8F5CF73C9BL1PR12MB5144namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, February 23, 2022 8:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Xue, Ken &lt=
;Ken.Xue@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: install ctx entities with cmpxchg</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since we removed the context lock we need to make =
sure that not two threads<br>
are trying to install an entity at the same time.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Fixes: e68efb27647f (&quot;drm/amdgpu: remove ctx-&gt;lock&quot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index f522b52725e4..16eb1ee600ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *c=
tx, u32 hw_ip,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free_entity;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;entities[hw_ip][ring] =3D ent=
ity;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It's not an error if we fail to in=
stall the new entity */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cmpxchg(&amp;ctx-&gt;entities[hw_=
ip][ring], NULL, entity))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto cleanup_entity;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+cleanup_entity:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_fini(&amp;entity-&gt=
;entity);<br>
+<br>
&nbsp;error_free_entity:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(entity);<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514438D37ADF99A28A0A8F5CF73C9BL1PR12MB5144namp_--
