Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D07CFC504
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Nov 2025 03:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C58E10E043;
	Sat, 22 Nov 2025 03:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjP9RuMb";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3326910E043
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 03:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kimw0pEEuR4saq53sHqVKdwBWzYDwXkWI/XoUf+k6Qzlxof5Fvz7R/dJK2c+G2l3sFbNDcrQfbu5ld6hwNgQywmQAfmiMvlMVBJRaJOdl7qDpccps4KThlq2RbHJlbu/3+5Q52tCr9aW7fkuSUY3p50SKpilwWH4OxCF8b22PClLkstt8eRhKI8GLgsryVlsVnSg7F0q4ufj9qDrNCLU4V34pdv42/hd3jJfi+ZuN/j+izx1/omQlUkhAGoqpwKBdfMur/twmi+pD5D4rBSxNB+FTeYGwYo8b64klmvirGIiTLFWti2u/Du3szmYfhdEiU9k1eCoAArlmjDR2nLobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol9MBye6QkMNLz48MVcw1I//liacza9ycQ2rkq7p2lE=;
 b=Y/zp5aiI4LKWVbxxOF5Xzt4MK95K0IoRhqyU5S2uRw5qFhpcWCBChH4LmcNKiqGiWTJzDQtljKEGRs9T31fDbn7cXGlCSpa06VIwjZANXgbLIW1FNo4FuzZcqPorJ6MydH/wSJb5bdVMmfVgt5lKuQLYHRuHxTQ0EsAQIc8W0009HSVh+l6f5PINRI2LTPzh0vwqUWlZcitYhYb6GuAXUkAm78f//lZu41b4B4WlDbyz7iGcf2cksMHbILcc96Kdks+/AJeQ8VNoq6vP7WeIOlc579ZM8DkXmbREmarm4+/A8HNrC1AdGm1k/nvu+Tt/dHkjVfCPg8WzEXjcBJehgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol9MBye6QkMNLz48MVcw1I//liacza9ycQ2rkq7p2lE=;
 b=sjP9RuMbsTBj0BWj+N+b04A//tdmqc7c/4sZLaEIXfCqUHdnysVAsVhekpWbvaux+Hqa8IKZprjt9PpevLFd9WGObTdnNuGxiEDrybWqEH/jikhenoYLVHCNGGCFBjpMnuahsu0vUyoAIPvC9L8e5dLOmiDYUUHkAUdalECd02U=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Sat, 22 Nov
 2025 03:14:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 03:14:45 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 JinHuiEric" <JinHuiEric.Huang@amd.com>
CC: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>
Subject: Re: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode
Thread-Topic: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode
Thread-Index: AQHcWZlffrGRi6uHQEWGH6OsVdBg8LT+CMBR
Date: Sat, 22 Nov 2025 03:14:45 +0000
Message-ID: <SA0PR12MB7091A302BDDF9AFFCBE99AF697D2A@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20251119211307.195615-1-jinhuieric.huang@amd.com>
In-Reply-To: <20251119211307.195615-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-22T03:13:49.1737555Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|MN0PR12MB6271:EE_
x-ms-office365-filtering-correlation-id: 6f1ae697-62ae-4e79-e8fa-08de2975496c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?T/eR0ujKvpOYowthxFn00Ci5+mWK9fxfMyqfQIYd5eBmSZ/27c/03vUkiZbP?=
 =?us-ascii?Q?3JW469OsPJIPTFPl4swkkkUTYKJbnaZg0HP3cUkigyExkl/qe5+Bn8sz29+1?=
 =?us-ascii?Q?qjuZxbn5mtOegSLR+NCcF28NOlL9sLWxo5M+eUhgBhURkdJ3BHenVN2Fo7nz?=
 =?us-ascii?Q?47A8af+yEyn0j8C8dEzXGO5SSm7dFESl9IjxTJwd/X8WRyqAwTEysS+sjWCK?=
 =?us-ascii?Q?6FpM2OcGnTxRTdSMzGycYyydk7s9BggNWep//Qi/LF6ayuzCTs5kwazJ33wy?=
 =?us-ascii?Q?dGqHMYPfsJOb+6amIBKgbZXSvuceAqsNlIJyTxnPVLdMWXyFm6KKeLakZHc3?=
 =?us-ascii?Q?gxt3IYoUn8HAPIXa96MeBRt8pp8uk5wsdFjbyo4hNhPel8nf+pBN8W4lddbQ?=
 =?us-ascii?Q?fBUnP/ETTK5PPP3cyk+Lw4BNn52FDrrlYGwDMbhG2jAZ9AC4sR8GKnQTbmo5?=
 =?us-ascii?Q?fragquWRWglryps9Ibf4/pUTKORcdVX5ZpjaHcuFfsHR73A/SHp/GPD1Ql5v?=
 =?us-ascii?Q?cvygiowJxq5D3BPzoJRmoDnPxYgK8bBJ6e0AxLJ3gEA8U2Yk5Q5ACLCjfHU6?=
 =?us-ascii?Q?CVbc7c2Xq6T5ZK0uETOQFoIguAUawnb/XnfbkvTMMXadWDKWO5vSgKd4zrA9?=
 =?us-ascii?Q?u5XqI5TFEjedm+jnrz6LgVwg+PCKFVJLhDAnLwNcMO7Op0/ea53kC7x1vTEb?=
 =?us-ascii?Q?M5Uw5hYeWyM47wkGio15V/7cKotkJ7PYrP6CzNiag3OTuv6sK4ZVkeGPDiSf?=
 =?us-ascii?Q?7oM34/C+P0RrVbSAiYmgDFipPftzcgUX7e0Z1/oJOxMuOl0B5bv64oX6e/g3?=
 =?us-ascii?Q?C6Qmk5xkyh8UVix6waxkXkC1V6tNp9t3wuGCYghe8NUR0/r7kLhiX4iXjMlt?=
 =?us-ascii?Q?DAf8boxpHLyKOMUCiwQnjGqU+XxKIfdgN/slCzI4vBHIEfrcwD5cKLhbak3s?=
 =?us-ascii?Q?vw2rujT2Ft+rgGWh1mNFdfzIYYQC/EZ/AAUCzXw5M5uHfWmMP7DHmSf+JFyC?=
 =?us-ascii?Q?2ziDqxOTfA4+j/osqbdPsE7jxf/Mv8sVn8k7YLYwgipBCCl3pPoLw2z9qn6r?=
 =?us-ascii?Q?LjTH6a/EY9edhLWlEfP48dffoXPLI1c92kk6GgUSorZHkkN1C6koMow9Exe9?=
 =?us-ascii?Q?FZMa9NgHWd7trDmItpwJwqW66JteylO27/F962fGrW0RZOD2KsdRelGYejaE?=
 =?us-ascii?Q?SNfweveDMlIVuyYk9JPRPat1E1U31IE4lKPniStWGOb/vNxgdqnN7nVxnn2Y?=
 =?us-ascii?Q?3hyYPwvzM5EmI8e/acaV0BIkX3rU9j0HtYuRJKPg4Epbv4zbCFUlSzMu9xb3?=
 =?us-ascii?Q?p3g7e+L/GIy+TXxcTtIDRTV1zByIcKMKNHFV5z5WU6A8MnAq8DlDOOJ0b9DL?=
 =?us-ascii?Q?NK4gaazSJfKjHadHNOQVj/GYDDIJeCy0Fyc/tiedDGICf5J0l7DcvvJKXife?=
 =?us-ascii?Q?w3GpI+s2BEeJUJByYxP2PpdkOIDMF3rh7kHz1+aNX8x3xruGFxAexV00e7aY?=
 =?us-ascii?Q?N3Fe1KZ/xIueipyD9+81HXH3mOb9cG5d+X5P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f6bRMWiXAR0rPkoX5m/elhdwcEmD05fHNtLQfB5BHKQAgheJYSscH4Aqu6C7?=
 =?us-ascii?Q?KiDSsbMNNhO6kqfwCPKZhIu8h1M1AUwUI/PPyjx8LhLgRYuaIIzVFaFCzxAD?=
 =?us-ascii?Q?TU0Dz6OUM5k+nVjZP/KrY2imJ/E/TC+jSVXV71qY5ZG8rbbLjT8fD2pnTm7d?=
 =?us-ascii?Q?RF1j/pqmM2835g9NKtT5b3Mr9gNHZha4sTPYQYEMJsoYjQsfGYmTHhBVWJBt?=
 =?us-ascii?Q?ORoWoT9c2rRUMoXIrTt8Qk1PpfbEEXauEucfYffGEbouA2MEKEnUXkCVyQVc?=
 =?us-ascii?Q?gfp3rGc8ptqcBomMzSiRNHAeC0DSqL0/ZM+LQh7JMGJTFOoD3pveEgwDJfcK?=
 =?us-ascii?Q?tmC08pPqaLi74SOWH+f1aNEvbKbdI4epADUDB5Kq3tpo8IEPKNhSYD/DQGSA?=
 =?us-ascii?Q?4+l5UcypWjNjlW2fIj7w9OkX71NqMVndWn4/1P0i8UhBr4Z2WK+e6HDSkg6B?=
 =?us-ascii?Q?Gk3+p7nz91TgaeOcFEe2/uRyK9ZFRPsmbrbTW9woVKH2t78WVl9oa6ZO+ugi?=
 =?us-ascii?Q?40AYJHm7JvvTzj8S5TpsZMiKamKRdGeF8rBMy+Fc1mzTbFwx3iC4IS91BZ5A?=
 =?us-ascii?Q?oLFHZm2hliq89FYsdjLplT3lIjtRlCh+479rXQK5h39HjOnPTq0ifBglxByL?=
 =?us-ascii?Q?AFjfWevXflfUS5dYFuasomLJkvaPtWT1YtRK78Ju0S9HFVDQS2CK5QWaT0VB?=
 =?us-ascii?Q?qz0ekh2KLgG8/i1SJAFQzuhxhqwCm38tsR/DW1Pu2zmq+T2Oq0PmN0GC3o42?=
 =?us-ascii?Q?B3LHxBCCLnkjU6e4pCmjEMgp4FU8arkxZO/0WLNaKcK90XtK+wB8Kdbcj3Nz?=
 =?us-ascii?Q?qo/JscnpFcCC7+SapqTvT5pdL6ZhQM288nldLXGryEqsm21Zqn9DrvkbI1oN?=
 =?us-ascii?Q?3XwICjpXunkUBAE5e0axuisTGI57WW0C+CNO1HA+ixXQncTfjjTvRFkhedjp?=
 =?us-ascii?Q?OCFvNPHui8GbBRDtF4lPY1TEQfjrpUChlZ70MQw3DFmeLvGc+P3laTIlFcZs?=
 =?us-ascii?Q?/h+/JtmJYLHFSbwMuQ+y8PaEX+0tE9YnuRxh4IxB7QFEMSuRD/5P+wFybaBG?=
 =?us-ascii?Q?U/kv+2mNmKBaJH/c4JFZefJsvUAX6vEGt51iDE0Xu5nfCLtV/Au5M2Am0N2o?=
 =?us-ascii?Q?pVk7OkcUmVswg1RGfE3djDNLk5xjUqhk1cly7rNDrDp1w4uQilvos52AoSGU?=
 =?us-ascii?Q?xiFln3Q9nGggweOWnhiZM31NRWGzCCmRhsgE3q1/qbUwWT4B1vS5EvSbl2R1?=
 =?us-ascii?Q?22RyNlbxtbXF2NmU1I4gpJ0bRpv+L3pm/sytTIcO23OY08LqsUeIGIxYz5PH?=
 =?us-ascii?Q?/mN3q+swjWjFjEFdbbU942HVyRJAUVE08ejN4eX4uogcd3hfWV9UmylWdFp3?=
 =?us-ascii?Q?eFkmc+KLKtIQ0Q9qAo4TgRV0z8uz+PnFg8XdggoSrSyrMFWiK5Daao5s8kSw?=
 =?us-ascii?Q?vr0daQRLNE1LDDqEeiT+c1Hawb2byjgJFmSbM2FdwkBu4dTowXGXOKw5hypI?=
 =?us-ascii?Q?BKs8jeUk3Hsikuzpsyxs1X0fhfyjTPJdOz5jnJarsVGk+1AtWCGFLXWt9cQG?=
 =?us-ascii?Q?fQaD1v0xbUoxKoKH2DtTHML9D+2SQD2NT6upnFfu?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB7091A302BDDF9AFFCBE99AF697D2ASA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1ae697-62ae-4e79-e8fa-08de2975496c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2025 03:14:45.2796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJd0Nbro91AQP5Dku28Dy9Z1qodv1FWjkKLTns1z64US1GvYVPi3o3BApFDj2xwZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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

--_000_SA0PR12MB7091A302BDDF9AFFCBE99AF697D2ASA0PR12MB7091namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]


I think the workaround needs to be in partition manager.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eric Hua=
ng <jinhuieric.huang@amd.com>
Sent: Thursday, November 20, 2025 2:43:07 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
Subject: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode

XCD id is assigned to uuid, which causes some performance
drop in SPX mode, assigning AID back will resolve the
issue.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 5c98746eb72d..525e70e45353 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct a=
ttribute *attr,
                 sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
                                       dev->gpu->kfd->sdma_fw_version);
                 sysfs_show_64bit_prop(buffer, offs, "unique_id",
-                                     dev->gpu->xcp ?
+                                     dev->gpu->xcp && dev->gpu->xcp->xcp_m=
gr->mode ?
                                       dev->gpu->xcp->unique_id :
                                       dev->gpu->adev->unique_id);
                 sysfs_show_32bit_prop(buffer, offs, "num_xcc",
--
2.34.1


--_000_SA0PR12MB7091A302BDDF9AFFCBE99AF697D2ASA0PR12MB7091namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
I think the workaround needs to be in partition manager.</div>
<div id=3D"ms-outlook-mobile-body-separator-line" data-applydefaultfontstyl=
es=3D"true" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system=
, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt;" id=3D"ms-outlook-mobile-=
signature" dir=3D"auto">
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Lijo</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Eric Huang &lt;jinhuieric.hua=
ng@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 20, 2025 2:43:07 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, JinHuiEric &lt;JinHuiEric.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX =
mode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">XCD id is assigned to uuid, which causes some perf=
ormance<br>
drop in SPX mode, assigning AID back will resolve the<br>
issue.<br>
<br>
Signed-off-by: Eric Huang &lt;jinhuieric.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 5c98746eb72d..525e70e45353 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct a=
ttribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sysfs_show_32bit_prop(buffer, offs, &quot;sdma_fw_ver=
sion&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev-&gt;gpu-&gt;kfd-&gt;sdma_fw_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sysfs_show_64bit_prop(buffer, offs, &quot;unique_id&q=
uot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt=
;gpu-&gt;xcp ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt=
;gpu-&gt;xcp &amp;&amp; dev-&gt;gpu-&gt;xcp-&gt;xcp_mgr-&gt;mode ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev-&gt;gpu-&gt;xcp-&gt;unique_id :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev-&gt;gpu-&gt;adev-&gt;unique_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sysfs_show_32bit_prop(buffer, offs, &quot;num_xcc&quo=
t;,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA0PR12MB7091A302BDDF9AFFCBE99AF697D2ASA0PR12MB7091namp_--
