Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7606C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 14:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4690510E272;
	Fri,  4 Feb 2022 14:28:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2986A10E272
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 14:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4aN5VlzCtOT+qfDbXf3ZoVhG2vy6tLPL/uznoZ2Iu4X6/OlPKvZ05CL7zisyO/Hv3/MNHhQ1wMurb70p+oBm/oi+8zHxCPLgCMKpcHWY0CMhu++nyKIShVHft9FyWzw+XypPW0TxGYCvyPO+nNCGpDDMw1xCZPxnG2/JgWmswF3ct+xH8PjSQAMTb7qb74tdZmODwT8VOYmlIZSbCpkmzxUm2EDCgNf61eq9x7HMjEPQSClFwvh6+U0S18iqpSOS1WFbKoU3SLu/1VrOv9+YOPUGdPK3BN9Bj96WTu9L63EVP3Zz+Kkl3QhATOMKvfhv1UJHRH9RaG/l70Aa7yp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1gEfX4ooogd6N/Fg6DJ++h+d3aAU4q6j9Vm1mPfLiI=;
 b=XoWnmVA0wfaJuZaB65/Qhpn4T8nDRK3ukCKyXkqxa1bIYbbLWVAcXv0qjXz2bnPk/rJFBsqB+2ALD77bvYZvSC7tV2nEX5BYROp0V7mSVAZU0x65hkhyjZaLhTdsAPQ+pK4GZriGBXsuLeHTR75xytbqbOx8LXFV9C3LV8oH532sszTX4gqeo4B3i63hHAqL92IqT6R3l0m3zDNF9ooFftSQishZ+R8Sw/HdkC2rYTgI9DkebfpWZaupa47LnVKIvokbMNLPht/lG3qVpmPHNROFOQKy4dVrqG0+caQJg9q1N1KcGsmN4FvXprx6C9bHX1tAFElTtIdmXnJl29IAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1gEfX4ooogd6N/Fg6DJ++h+d3aAU4q6j9Vm1mPfLiI=;
 b=x5LAmKVPOCoih99E0ZQxjp/mK2g8tzR4LeZNBRT8GbthPTcjHJcfC9CSrVKgDsQlcaVcqZ/7Q+9Wz7G4TpT3ixOXzaaqUpNeMXPYqv3SErBzLNkcc2nXIVM1yaEkNNSB4bQkq+qmc+8JPCUlO5+47wtUDeuiwRNGeCTtY+L4OOc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN8PR12MB3219.namprd12.prod.outlook.com (2603:10b6:408:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 14:28:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 14:28:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Thread-Topic: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Thread-Index: AQHYGaR+y+hT0TIJWkevMIj9rPb9u6yDc4cB
Date: Fri, 4 Feb 2022 14:28:15 +0000
Message-ID: <BL1PR12MB5144317330B14001DCAAD5E5F7299@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
In-Reply-To: <20220204085201.30615-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-04T14:28:15.286Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: e0fc2147-fba5-8520-6dfe-64da5b7b2aee
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ba7cbfa-be50-42b5-502f-08d9e7ea9511
x-ms-traffictypediagnostic: BN8PR12MB3219:EE_
x-microsoft-antispam-prvs: <BN8PR12MB321987CB8B62EBC849F8AA96F7299@BN8PR12MB3219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyWS8xM496Si4E0gs0yglus4xqG+sngGfJz6TfuwzWdvrEEdAA63o1zmFtSUrBNvWvfI3iCRstukD7S6gGm/YoCTwOD7Y5gspTUM9Xf1+B4ogmEHgtUlh8KfuG27/zLLlwiB76CHMpgn/866yIEtVENy8zNPGtqtnoZcA7dFBpbUlbeW3n085PRq+Y33uYrEFk6e6wiq3o0GJT4q85Tv+jQa8rbnQ8hppKoMWgUjJUebqtO32ypE9HqAFkUMQypzLenUIA6/t2/Rr4d6S/MDo9x2ATA+vQnvjnWcWJNbt7NzrluiPsmUktKKqOp7qJcuIu2Wy/g4Q7ORbfflWQL3ImrmWileFKVEQ8/ffRAiKtiDVPImBfD84K+Bt1DBR7YZJ5wSrxYAYYIhqlrqMIz4xf+3Hp4QFBJYp7uTz6e74prRCESjRa+juMTV/fScH9GXCSwQk7Al64Zra5JzTqW/7tQ88EpXzPs2FAWG+EosKpqXu0dq3ztM40xycTcULg3OPx9H3MZxwrliH6DrRzA/FSOMBDCVe80E4N3Qq6FhaF9NakZMK62GmesOjHNTLv4wYGjdRuJx2HmjPXIqQwmaFw1lOkNOCQspJTOjDPD1ac3Hri78wqfIVlYZ0SY+wdVCi7okwsZTfk73k48NczvD5VTunOAJ7t+meB54n6hnznipQ9f9fB+30Fia+cvdSQM/e9StgMCPqNzZIygoM+fKXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(316002)(38100700002)(38070700005)(122000001)(83380400001)(19627405001)(55016003)(508600001)(66574015)(66476007)(64756008)(52536014)(6506007)(7696005)(9686003)(66946007)(5660300002)(8936002)(33656002)(8676002)(110136005)(53546011)(66446008)(76116006)(2906002)(71200400001)(26005)(186003)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vw31ZhooHbO8OySx7K1F3ni31EW2pgHo3+prLerQVed3K9NTGSBjJr+FEZ?=
 =?iso-8859-1?Q?awG0udyMTGWf7j2IpNdGGTcNpApqJSunxujVn6FAb4gGQsMni4g/Yy1wqA?=
 =?iso-8859-1?Q?LOvTUwdBVtmonwxFBGLOBJ2wn6Ztf0cJZnj7NphHLuWIoklWPT/6q5Ex8X?=
 =?iso-8859-1?Q?GAQBh/r9tEU4cOXE7AbLTzSw5zqesyOJKdBgiwisXJcmXfnHU9TxY/dlW7?=
 =?iso-8859-1?Q?e4X7zcjfnMM9MiW7/kQRiIc4vPlmyFiz60LWpRyATRD2LdksOQ8dGr7Vce?=
 =?iso-8859-1?Q?7nMc7OlU6olM2lA8vWOcU2n8LrCy6FxWpi2+sMiVZTJIPAvknK3bQn0TXd?=
 =?iso-8859-1?Q?Tbs0M+/jQuVE3/RWe0dPFWqzchblireW4G2Rbo2aseKeqnJgFB8jMn9c1o?=
 =?iso-8859-1?Q?vqvG7mByvug5KQCEWszWZLB1Syj1GHzbmnPF/avuT3/7nCnQZh3jLIgGMs?=
 =?iso-8859-1?Q?rH91ue/G77UWDA8nWllqMoat5joA0OiaBWxC7mr6W9bf8uwTlQw83hT9Dd?=
 =?iso-8859-1?Q?NsTWpaE1LM6D6L6P3RhKEOHozRi7dsq9D7Xh0NzA3fO2adcAUopH9lo1pX?=
 =?iso-8859-1?Q?Nzn/CBvBagLURezI/tDc/ETeiTuGTLPvtr9C561Bc5ReFPdXv11K9MXxaS?=
 =?iso-8859-1?Q?L5Ir4KJ5pQx9/ZHx3u54NhVYkxpb2gibvIYcIMa/p/KMNe8rf8mzu8yvTE?=
 =?iso-8859-1?Q?TdiCxamPP2hsLubr3SfOQaTMvpauPbpHENmckUR2cvSkliRqbH9lr87U3B?=
 =?iso-8859-1?Q?6nyjmbse/CIUp/AIY/soGQJHqNIORCjoE3VKYaOXJR/dLtSCNbpz6zf0pk?=
 =?iso-8859-1?Q?0c+yKKI0fcP7cj+OPH3eQ3RQbdDSjGSgiZttsZvQqHWao9T9ume2RdDoH6?=
 =?iso-8859-1?Q?luwF41ztCk2qdz6HwXigKqssj6BnESxK3b7pNeTwJHjbAI3zxoSPTDHGQQ?=
 =?iso-8859-1?Q?DVmHp3lpdVP0EpC16SsHaNaUTrz0djPpi8QPgFO79W8CKHvp4H9Lsl+03d?=
 =?iso-8859-1?Q?SMapgE/REVo0BRbO7IeJJ9JbYnmWI9MQROz6SrkIc5gnkSJORGToYJYgOk?=
 =?iso-8859-1?Q?zfv+kiHZtWt0g4+QenIGi6TReMWBLBAQHJWE+uOAygTo9pNuNdRqYuMiIM?=
 =?iso-8859-1?Q?bmOyNrK8TrGE1Wd8EbbRae9MEbk0WdrbBY+EvRNCffRvrsfRSNCplyXWAj?=
 =?iso-8859-1?Q?b49FW8v6josFFRmSoaM/jWkd3KG70+UIxG/+FG5MJYSxJiNyoKgHtF+OPD?=
 =?iso-8859-1?Q?aaA9B0xTddgQXA/hYIJRqilHeYuW+ldc4CPDGellT2zS4HE5H2LWhsSzec?=
 =?iso-8859-1?Q?3jyE7vRBehYFS8SpgJhspPRhvbXtTttTxo2StRAdM3caPeKjQ63ghYxlyd?=
 =?iso-8859-1?Q?84vFRrr8SgEeN6Lg8vIHQLoZRbdBQ96AKHtBhRuVAkphPBpr++3HRwaeWg?=
 =?iso-8859-1?Q?8ZxJOeIO2O8UMjJajnulNDWj5EKG3tUJJSKbyudBp3+Hy7UMnNmLf1TZZj?=
 =?iso-8859-1?Q?lamHk7UebQZrjnAaruLLGufQVL6/EpHIYokivlywB9npPuJiTdeVkmYpI5?=
 =?iso-8859-1?Q?V7cHh+G7NT3h/ucIYqZg9l7sBP9rYuFg7Jthcop72+CGd6yyVJ8UjbhqFJ?=
 =?iso-8859-1?Q?hIEPjR4V/n3C91S+EYzQUyrYeg2mRWU4gGdiO0vsk4mdVxXy9bnuHZ3VSg?=
 =?iso-8859-1?Q?y5Lr4usHHp4qwJLXvjM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144317330B14001DCAAD5E5F7299BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba7cbfa-be50-42b5-502f-08d9e7ea9511
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 14:28:15.8626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIdLMESeDICLM1gD0zour/CV5yWKi0eKsDLMVVG8FgkyiQO/1G3/fIuJtR3/wS4HV+kjG4pMYBF0ZlWuXjbDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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

--_000_BL1PR12MB5144317330B14001DCAAD5E5F7299BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, February 4, 2022 3:52 AM
To: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move lockdep assert to the right place.

Since newly added BOs don't have any mappings it's ok to add them
without holding the VM lock. Only when we add per VM BOs the lock is
mandatory.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index fdc6a1fd74af..dcc80d6e099e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_=
base *base,
         if (bo->tbo.base.resv !=3D vm->root.bo->tbo.base.resv)
                 return;

+       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+
         vm->bulk_moveable =3D false;
         if (bo->tbo.type =3D=3D ttm_bo_type_kernel && bo->parent)
                 amdgpu_vm_bo_relocated(base);
@@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_d=
evice *adev,
 {
         struct amdgpu_bo_va *bo_va;

-       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
-
         bo_va =3D kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
         if (bo_va =3D=3D NULL) {
                 return NULL;
--
2.25.1


--_000_BL1PR12MB5144317330B14001DCAAD5E5F7299BL1PR12MB5144namp_
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
<b>Sent:</b> Friday, February 4, 2022 3:52 AM<br>
<b>To:</b> Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: move lockdep assert to the right place.=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since newly added BOs don't have any mappings it's=
 ok to add them<br>
without holding the VM lock. Only when we add per VM BOs the lock is<br>
mandatory.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Reported-by: Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index fdc6a1fd74af..dcc80d6e099e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_=
base *base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.base.resv !=
=3D vm-&gt;root.bo-&gt;tbo.base.resv)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_assert_held(vm-&gt;root.bo-&=
gt;tbo.base.resv);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;bulk_moveable =3D f=
alse;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.type =3D=3D=
 ttm_bo_type_kernel &amp;&amp; bo-&gt;parent)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_relocated(base);<br>
@@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_d=
evice *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_assert_held(vm-&gt;root.bo-&=
gt;tbo.base.resv);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va =3D kzalloc(sizeof(s=
truct amdgpu_bo_va), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_va =3D=3D NULL) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144317330B14001DCAAD5E5F7299BL1PR12MB5144namp_--
