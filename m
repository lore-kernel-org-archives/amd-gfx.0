Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA0FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196CB112375;
	Tue, 17 May 2022 16:25:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A335110EA86
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpKDqfA9NY4WafEAQ5MFOe3rklKkrynMV++WtEVdLAtnk0J3W4mXtyiE0LukLL2x2eMnlM+FnMLJj8YKnx3QQ51algtjfGE4tdJK/Ruf1Rfv4yKMRCFgFVX2EWwysRHD/u2r+gx9kgXPsrjeW3vE/oP92w4lMmIO8elEVmlX3zPKOb33GZgwQjolYRqmFEQ2KZ6TawJKoE/Jy2NR2RDJMveh0tGty62fdpqUPzCVCepaShIUjPWgYSbt/jI8yrm9zbqoEM+tC08xUZ0OstcwJ4R1lPSwnyYGSVSQaocZ+bNgf2UHtApHIBjadRfY/yu20GYifxFK1z8E/e8Dq7hWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N08MeUDPJyjf8ZhLwQdjcPbC7oBV3ADZzCkAobyLPUw=;
 b=hh9HcoAFupVTkGp7WdZyvfO7P5vOBiyG+1fxwDpPTRHJtfWx0C0Meh9qFwhsFpb4wKNrrd/coWHMTwSy32NKdeq7CAMoxTGcJIsssDslbUFsH5xoNMw+6GjOjmE2S7jEbjGfHwvB7774EKa0J/t/FvRYQsp/wk41f6ZMMtB4TY8K4wROZMygGMWjCIQQ1adTgjwrQXcdW09USt2yZfwKYJY464BKK/HAhokKE8fuspnyrtcVVKuHw88nJy6XLrS6t6vAIDSaT4KQ1uxbFHoRDbhh2uLdK6eccOYLo9pY8wMidqxlPRvXOvg5CdqKlyFBJUFq4a2nOSAHSjnvnB2Gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N08MeUDPJyjf8ZhLwQdjcPbC7oBV3ADZzCkAobyLPUw=;
 b=x48fQxRwVV/fvKWXMQOcAJItlzOmphoZwERdc0vhUJ0IalpQncBchmSdT+e5OieOvRnO5nBkdEbhfQkWT3WqLOz5FgkkVQHcCu17FKOlO2O37A9UWnD/tmauw9NkdUFPFBdyZLc2J+jqMwCoGmLdT8N3K70jdJbe7Td3NR5upMk=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2745.namprd12.prod.outlook.com (2603:10b6:5:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 16:25:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:25:05 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Topic: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Index: AQHYafOabcB0THH+VEiSkjObHdhCGq0jQKcW
Date: Tue, 17 May 2022 16:25:05 +0000
Message-ID: <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220517133944.25612-1-mario.limonciello@amd.com>
In-Reply-To: <20220517133944.25612-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-17T16:22:28.7666430Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd235e62-fa17-4eb2-1575-08da3821cd0d
x-ms-traffictypediagnostic: DM6PR12MB2745:EE_
x-microsoft-antispam-prvs: <DM6PR12MB27452F825A62DD3841647F4B97CE9@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5VXPTmQA6BGbah8vL3XV11NeHM4p++z9eUD6uw5x/cPGCJ3iU4InkEaPeFOkJSSXgtFTlx/Tlm6m4/ojE6oc99wWPRBQFUcniQaewNyPGtTwiaJP9ahmOD831/6yWBt4+0kzbN0BZNlmND+qP6bGugABx+rdN2aAyCuHVWic01/pIpN/JhEEtioD6wwKGBYxMTV0HPFfTgseqEkq3IEIqLR32XsHS+MEFmQtg2b37jMcWC/W2ts1kwSa3YR7ijGyLmu6y4tbmkS+Ke9W5vhLFw1h1tmoEv9H06IweCd7eBkHa1ixdfwcj0gVccit20DKk0Han09JKqO3JoidjOWJG5skcJiQFyh/Rw44cOi7ScmwusTbHFYxpkBqL5ExLPne1rzU8b5Kl6/B/6kM5TZpa69KS4pXSFkwxbw+IPtEcpr4eFo95mbmtTcjp8leioe2Jy8Ai3YxG40BosifuSNMyjVlwC1DveGfiQQ/9dpurtsmkpG7EtYGNgSkQQNKX9/r2uPNp65OawyDbGwcvVNv6uAODbocXBEV2BD73RuiPvYzbx98ZsYThXLqmVQPhN5YxyDAvNnlhQxDZeoR6sZFNhSvXwTi5PtH4xGqOxeBhr+YAw2374HXRQoV6X7dMwbHeJ44K9ETR6Fk3TpRkxtx3sRhwiIGoxFre+yoBn2ndisoaPhUnnA7bQSBBETw2sot/CqS9zhAjK3N5jt69fpeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(83380400001)(52536014)(71200400001)(33656002)(2906002)(7696005)(6506007)(110136005)(26005)(9686003)(66446008)(91956017)(38070700005)(66476007)(76116006)(5660300002)(86362001)(66946007)(66556008)(122000001)(4326008)(38100700002)(8676002)(64756008)(508600001)(186003)(55016003)(8936002)(558084003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ex7BKywHRzWqMBMC20S/FL/Sih8YVGKisxtYReOMuhBVhaD2n7kFrWuPG4SY?=
 =?us-ascii?Q?vZQuivetYWI4qCX1zJ8CZ8x8YVHUybfu4Z2EeQvvIaav+IioOMM9YKSm/IlD?=
 =?us-ascii?Q?PSsk6G//x2gKLNlZkSxiUzYwutbBoLAYTuMj+w+YKId44+C2HOFXHcKarngs?=
 =?us-ascii?Q?Fp2oIXOkBf4SpqL3o7MmtonRcu6VibfY5cVzBRICgJdjS0NCBztfbM5x6Pcr?=
 =?us-ascii?Q?aikEiS1eGz4dU+8dck5y0ms5yB5runeADCMa7PuDkQpQ6o96M9aFPxf5YaJ7?=
 =?us-ascii?Q?Q30n67lTnk9B2/4Xtjxb9UMN2oTFbFiojp49baHs++1t3x4yFJB5k/GPTk4j?=
 =?us-ascii?Q?GTd7TM7SEhju59HYqgEEdnpl6mDQN4/pkOGVjAPEt3EjglT8bVn3MjZ4Jbqk?=
 =?us-ascii?Q?A3CS8rX6MbugkX63JRf4PhaYADwPKu9DTezD4IaZQAj44UB8MRXsqLN3i2ap?=
 =?us-ascii?Q?uVdyH82Mbbw0zJNgo1jM2CNGTbTp8NAausjamFaRfLy+B4CrXp41to2Kg+wX?=
 =?us-ascii?Q?bCU56VK5zxxXmj/OEnEVY6aD/QefUUVPA2TjlC0tBqVRgeeYqDz4EoHdgRLS?=
 =?us-ascii?Q?4tdg1nX+er/wqUaMELQZ5jvKAnm1xmW4GLIPgrrrnZGGxsYNwlelAT3vNelK?=
 =?us-ascii?Q?YltwXznV0Gr9BrrE2vzZ6SW6Cw5ejZG7rdtOD7e4nobzgIdDaJTU9tfreXro?=
 =?us-ascii?Q?Hn4zqQWydvEI1jffHwWpS77mNmVWiF32YoeFrqmyIut9fz2LNxfz/xTIW5Ao?=
 =?us-ascii?Q?BH/omhMPDiZ4a/3eK42BOyErRm+xmJ01PXJkSsmeW9qoj3TYfuLYrGiLlEsP?=
 =?us-ascii?Q?44katRtL0+mSJrxD8MIZ4iRA37cXrHTDdGPU3De8YJ9h8Pub53YleJMSS2BZ?=
 =?us-ascii?Q?9Q5kaU+RSo6Xs3P8LGkiSDunH0KqeK9jrDIx/iY5xCksfWGvOVadx3+HTMjx?=
 =?us-ascii?Q?O2SoqUpMsRaO5IUkJPVMM8PrEIKtiOHXQhz7FF+pgrfUsxPxCEOltsZEtnZe?=
 =?us-ascii?Q?YVtelpmQn9CXcON8ywy8HIEIr6Ye/9DuV98glHJ56iVhJLzTRbYTNV2QMdUU?=
 =?us-ascii?Q?rZLCkWX0WuOXgogoFMFQfUCy/ZoifCiQhZfCxyv+xhQJ3QUO5kGeJ+eyTDW3?=
 =?us-ascii?Q?8PIsH6PFpJYlXyiMvvF362+cPc2Hg18BG6EMk9nL3Qx/NQWFOZitGl/ufoMA?=
 =?us-ascii?Q?TXbnb6gdC0dKHbhXi1UoB3vTZ6WT0ps0BbVWmiJ9XJzq5D9S6N0cKAPZOYkN?=
 =?us-ascii?Q?VZXGAw4e8glYHjzTZiJgMIgVuRCg5aEAqkTyTQFYN7AszX2bsXJ7GKvTwEW7?=
 =?us-ascii?Q?86tMD9V2goTStwdr8EUFA8/KlYCnxTAoroHqC1x/v/uJahVYSMDbvfWjT3ff?=
 =?us-ascii?Q?kJoxdoR9oKppJ3v7pemDmdYsRyOHuZnj1H54T1sAdCd6vQvtEdC7WTTJv+b2?=
 =?us-ascii?Q?7ssMREG6mlUVtuE4G+zwAnbG4nrELFVxxinlhU58tyka/KUwfRahCRyC7fTQ?=
 =?us-ascii?Q?gqcgi6bVosqdjaV65lwkQ4G9nTB1prKA/OSYlC5w7CrilbLgz9SZ+VT1oBiX?=
 =?us-ascii?Q?CtkcB7+OUoa6VK0/QJW74emNJeW+neWYCBttgEZ9kgl5OhMIGKZgDg+V8R99?=
 =?us-ascii?Q?7h0spWt8Eyq55pEpfsKcoqBR+ho9m97ODuIHgfXHTiyBKMQfDV39tIj0a1Vt?=
 =?us-ascii?Q?CiCcHNMqrfAymbNIgwkBVU09aGHRs7U0DzjbpJ+fEX1q2PXKRbWGI5OxiWTC?=
 =?us-ascii?Q?ZWSnTeHyyQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461409FFEB1FE826259EAC9097CE9BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd235e62-fa17-4eb2-1575-08da3821cd0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 16:25:05.1296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvu07jvRVVjkl0wrEKbPZp3+Ge4nLjeBW086Scf+iuZI3wquZ7JBuSbXTMMaH2+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461409FFEB1FE826259EAC9097CE9BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

A couple of things -

PM_SUSPEND_TO_IDLE should be under a compile guard

It makes sense to rename to something like amdgpu_need_reset_on_suspend() a=
s it decides on reset only for a suspend situation.

Thanks,
Lijo

--_000_BYAPR12MB461409FFEB1FE826259EAC9097CE9BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
A couple of things -</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
PM_SUSPEND_TO_IDLE should be under a compile guard</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
It makes sense to rename to something like amdgpu_need_reset_on_suspend() a=
s it decides on reset only for a suspend situation.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_BYAPR12MB461409FFEB1FE826259EAC9097CE9BYAPR12MB4614namp_--
