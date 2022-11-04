Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 04:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E31C10E028;
	Fri,  4 Nov 2022 04:06:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870D910E028
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 04:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St1KZ4uDrNG4xUJ9WcRu8xXvzy+EOXvqtMJen00a2hiGdPzHnWkPZcppXN/a2gm0G783xEMYcyHeolO/LzTZdg7jxZ2aQdLf6v0pCbpsRdANhyMN+qGGMHNx2BE4a1FfHASOXowDEZLvLi0VqG4pg9Ns1CEbBtLXKZaQO/1JT8S/lRJlJGgWYy0NnVl1guhiQjr+y5AC4EOunNzDdbZeV6VndfMnbk/PBy2eox9qRK4HKazRLmyI/QI1Rtma/Ncex/SHiEb1+EBuUkbiR4CQ/mW5F+KGCcRKp2EeLetSloSZxYhmnjYCvSIp4dBFOXpDYzxMQo32rZzT/Ks5xGCjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx57Dk5F5PFjTS1C8iN+OEMLLBcMP46eSgWcTELEFqs=;
 b=LNkLrTug9g8fJ333Ki4HG3R3FMZKqaVFmGN+LNj+RpdZKfJPARV/v9gTxuoLcmeI/bQemSiUi30yy+PHY8VIoiu7o92OwwYQPE9Vy73+KjAvIPJLUHDc4z95MYkm0eaZkpuqVkTPG8nH0EqoZKxqNPgHBPFbfsxiFVxQdXO0EwQbP5tBR5x+tfQkq0l3YQZ5TwFRVOifeFWgBTJPQJ76dHic60P8+cv51xqLA7dXkoNruNnj6Jfi04Qbl7sdXYrtvkszCWDC7EPdzdjF7/ma710ftElVH3nVkihR0AOkaBnIkBJ/ZUKJFsD1PsgKUDOA6SqlNPJEEiEdjr2+ndM0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx57Dk5F5PFjTS1C8iN+OEMLLBcMP46eSgWcTELEFqs=;
 b=rSVIFJK/ZkECizQE+fvqGp+aF+nOeden6ixI5iIHqouDM58QuUFwv73tiW7Q0s8ntA5pg9JWAu+1bDI8oNgY5LZ1N34fHfXNr/e7lpN9nTxXI9fF0bj4Tk+ksVpA7KjtzVDoArvCAdixr5raKvDwzXE0Nf46JoPGWopt/7M4OlQ=
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Fri, 4 Nov 2022 04:06:06 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00%3]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 04:06:06 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix error handling in kfd_criu_restore_events
Thread-Topic: [PATCH] drm/amdkfd: Fix error handling in kfd_criu_restore_events
Thread-Index: AQHY79nwYkCioXW+jUO3zCTM4Tv14q4uJQMH
Date: Fri, 4 Nov 2022 04:06:06 +0000
Message-ID: <DS7PR12MB59331D5A886F9496BF69AC81FE3B9@DS7PR12MB5933.namprd12.prod.outlook.com>
References: <20221103231309.916480-1-Felix.Kuehling@amd.com>
In-Reply-To: <20221103231309.916480-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-04T04:03:12.6563118Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5933:EE_|MW4PR12MB7263:EE_
x-ms-office365-filtering-correlation-id: c241e4c5-271d-40a3-7faf-08dabe19e5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVrPPmZ1H9IvcRp/GrVLba3st90FVol39yq2MHd1U4HZYY4MF6UlktwTpsE5yjGTtlPUrH4AknW9u9wgaIkh5B+7dUP549uI4NDh2t5lLLQM8726P29aQ2ODXVmYp/LBWQo9RM6Hzu/g3BnxE+4rIrjOMZc8vDbdM9evTpJ5CyaovhrQYeK6G1OM741ypyBYZswsYSjaz9fFrT63DYL2EiMoHJR6NojTjh5ld0K/irhP5i91AfA9ii2j+2Ej6wEel68Zfp28VqwypVisDUDA/Mcx07llCKK5dHTi2NGsLvHgcQ/K+nBr8emqzF4JrfNLGe+/eMKL2fCMOSITY6GICNKrxf/3gRJGkBCj3Ojs3edFPjj2ttInB7u3d6pQ1FeXLTWUdo2QijGk8JAtYyA0iEMTN41Wn2YzbuxIEeuLhCHFyhibV6bLFmWq7bk2s5pU2oWtM6vrfXWzBdVagsGNmshBfSkkxtj7ogMmZmuOaIcVZP/JyVLBuU5ESdDyx6ZwNIfGuWc9cRyNQEPPEV3gBlAm13emlAz09zt3JkPnSIc+eMT6qvpJTzOR5iV3kKUt6ZUngu1cDp/6uDWgOeZkjxHqJ+8peEV3Gqj2Dm0RU8bzfm8OgPgw5g6vz6t8C6ChV0a8PiewF72zUl8GeEYs58MTfHUIoErSLHoWQzaw1NITWrERdi0gphadcxhuOeInAsAKHjmupy5Qs3neU3Acz02ZA3HSDLlds1Ln2Wf6GsebLk+Aeo/azEkY5I57jcFBNIs/CCFtklRYqp0C5LtGUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(478600001)(110136005)(9686003)(6506007)(83380400001)(186003)(7696005)(53546011)(55016003)(2906002)(6636002)(5660300002)(66946007)(91956017)(8676002)(64756008)(52536014)(76116006)(71200400001)(8936002)(316002)(66476007)(41300700001)(66556008)(86362001)(66446008)(38100700002)(122000001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdCq2S3bI1clVb8K2jMtxKvZCeox7RCC4XkUHHaGaa/qurCST383GTJgq6Ej?=
 =?us-ascii?Q?IC4CC4eqlqfYZBVG8+uBVbTOOdq6jVldd7DjNrLDsduEcmPcPJjbonmVH980?=
 =?us-ascii?Q?ZO2mkyU8J6K79421eiVQkD3bBMH5eJGaVnzwRzBWo0G2f0g0pnce7fvWEswT?=
 =?us-ascii?Q?7u7/eiNfl1VuiZoqoNumdrWfggLedCf+j0ttJxxg/fG91tGm0L7Pr5pF0yr3?=
 =?us-ascii?Q?IQsaoFefAAVvyUpHwYzVWkk9eQgjt5berLwkyektu00YxJURX80jAj+bgap6?=
 =?us-ascii?Q?U9CDhLhP5tLfb/tlgeZuO/10R8bTnfvzdUC0BxOOO3sjyzpVOxeEqo8+EWF7?=
 =?us-ascii?Q?gg/xGSGo3TijBeahN0KL558qlRMF555pgLouQVSrwvvDJzMSfRQ3i78kPVCk?=
 =?us-ascii?Q?5IZj7rRCGwfr3YqwyUF75nA15WoKmz8S3lJnC6C10n8dZ82JX1NZvdhspdMA?=
 =?us-ascii?Q?7Weq2gmhpDlQXDm/SPtbRxthBFJfVyF7P49znqrScAp9KkvUOTFxBLTxOWv9?=
 =?us-ascii?Q?KSMaABmzhwwLKzCkWrw7s4JCY7gEuz+LRkO5OaHTOMgo0bQVpXgA0P2x2Kbq?=
 =?us-ascii?Q?GBDpmv/nRjrexwqn5EjIjRCTCWbfwfC0dS625I3BhoaaBEXyBZmx5jnUP3lT?=
 =?us-ascii?Q?MPfZKsdqO8ziTM8kS3kfZ7GsP1Ft/oFkJxCb3t2KOgI6v/3Bl7swpptSboxb?=
 =?us-ascii?Q?ybejFqX7Kv+b0OE0/h/5py2U5t3K4GWyqLcsuDIxlWSLvjcoeuUGjkMtnAUK?=
 =?us-ascii?Q?QqCJkjd4QTz81lc+JlGpmicNg9aLQjv+NyMlHfbUfvy9ioVUG0OYyUSRG3SC?=
 =?us-ascii?Q?Z4G7yWjpoSOuElegi5FG2QhQ9MJElPwaB5DXEvyPC5UB3Xa55yz/Qvvpd6Hg?=
 =?us-ascii?Q?mWXrTah4Ta0nQIaq9myNrXzKQwRmT9Hasc3Y5xjlhxlGkJ3b1uELQJpSn/OG?=
 =?us-ascii?Q?Dk9gBEgZ31y3yZv0GK/nyu5pGtKQco7dZsQFoyFtXzBrUsKBFO+elola4M3e?=
 =?us-ascii?Q?lWZfKFK91YQHNR1bsKEigT8BybpYvUt8XIjBn1s4nQrXux01j1WVsGMZQU6T?=
 =?us-ascii?Q?RMepjtRPSza3sWasjoCWZX5bFKyhOICrrv80antE3l0IGh2vmdonSPgBxXUd?=
 =?us-ascii?Q?VP6Sf0tK7aG0fTsG9Nu7NPk0kP/X03NOJfT0MivzVTPNnoykE1paWX5hnXDF?=
 =?us-ascii?Q?J4WiYXq2wEP7eOWToghy5FCShNN7kzDakvKoXxC+lO+BMiU/UFatAny1dTwr?=
 =?us-ascii?Q?mb1+gobaL12ihbF93jlUb2PD7OQ4gPTpjuFn2rqgt3kV5FS1hdTFZq3rhPn7?=
 =?us-ascii?Q?1jR5MdTeIphVW3rWs3K4xzNstnG8De+VOAjJGt9QkM9q3VyYPGF4QqerlV9w?=
 =?us-ascii?Q?la/1wXsQXYTKhZXReDg6B2kNDIIsM8V0hVt/p8BPus47FFrzsuXZEFwZrEul?=
 =?us-ascii?Q?5K2QwVxTbmudrM250qql1CqNh6XJxfbIEg4Hu2eo0YpLdm3Z+kyZAvQaDpmc?=
 =?us-ascii?Q?/cr714ZhyyM1GVqhs+Kf7EXtYNDTsI1WMnWGTmUgGl9EjslG9v82yowUMzVE?=
 =?us-ascii?Q?vLcyvgNMjGVs9cQDiDL560C6sM5lOjadF9lVzM6lvJ16/r35ZHTjG/Kc7vee?=
 =?us-ascii?Q?2miOk3uXWGF+Q4sTcXjdGZ8H77ih/67ZGm83b+MFPDaRP6BzgXy58yc1jrnn?=
 =?us-ascii?Q?r2XSyQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS7PR12MB59331D5A886F9496BF69AC81FE3B9DS7PR12MB5933namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c241e4c5-271d-40a3-7faf-08dabe19e5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 04:06:06.1812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYHO7+HNO2tj1NZVNeZYKXeRjx/fVWr3hbNOX+ZhkT5vC0a7dekquq+L0vF2Wu4sXKMbs4RAtFt5dxZKQ6L5ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

--_000_DS7PR12MB59331D5A886F9496BF69AC81FE3B9DS7PR12MB5933namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Yes it helps avoid the unbalanced lock messages seen during criu restore fa=
ilures for events. Looks good to me.

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Regards,
Rajneesh
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <Felix.Kuehling@amd.com>
Sent: Thursday, November 3, 2022 7:13:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix error handling in kfd_criu_restore_events

mutex_unlock before the exit label because all the error code paths that
jump there didn't take that lock. This fixes unbalanced locking errors
in case of restore errors.

Fixes: 40e8a766a761 ("drm/amdkfd: CRIU checkpoint and restore events")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 83e3ce9f6049..729d26d648af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -506,6 +506,7 @@ int kfd_criu_restore_event(struct file *devkfd,
                 ret =3D create_other_event(p, ev, &ev_priv->event_id);
                 break;
         }
+       mutex_unlock(&p->event_mutex);

 exit:
         if (ret)
@@ -513,8 +514,6 @@ int kfd_criu_restore_event(struct file *devkfd,

         kfree(ev_priv);

-       mutex_unlock(&p->event_mutex);
-
         return ret;
 }

--
2.32.0


--_000_DS7PR12MB59331D5A886F9496BF69AC81FE3B9DS7PR12MB5933namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div>
<div>
<div dir=3D"ltr">
<div dir=3D"ltr">Yes it helps avoid the unbalanced lock messages seen durin=
g criu restore failures for events. Looks good to me.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Reviewed-by: Rajneesh Bhardwaj &lt;rajneesh.bhardwaj@amd.c=
om&gt;</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Regards,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Rajneesh</div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 3, 2022 7:13:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Fix error handling in kfd_criu_restore_=
events</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">mutex_unlock before the exit label because all the=
 error code paths that<br>
jump there didn't take that lock. This fixes unbalanced locking errors<br>
in case of restore errors.<br>
<br>
Fixes: 40e8a766a761 (&quot;drm/amdkfd: CRIU checkpoint and restore events&q=
uot;)<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 83e3ce9f6049..729d26d648af 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -506,6 +506,7 @@ int kfd_criu_restore_event(struct file *devkfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D create_other_event(p, ev, &amp;ev_priv-&gt;ev=
ent_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;event_mutex);=
<br>
&nbsp;<br>
&nbsp;exit:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -513,8 +514,6 @@ int kfd_criu_restore_event(struct file *devkfd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(ev_priv);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;event_mutex);=
<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.32.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS7PR12MB59331D5A886F9496BF69AC81FE3B9DS7PR12MB5933namp_--
