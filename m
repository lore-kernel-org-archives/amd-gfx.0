Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E848C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 02:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFAD10E642;
	Fri, 24 Jul 2026 02:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L624t2fN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9281310E642
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 02:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyM7iaO0T+yK6IWURDQQuQ9cTEedHQwW+e8LGeGbQPiuTP39qtZFnMJ2pd6fq6omJ3erN2nqh4f0XPdvmKHmsA92KhN138lumatkW9b9BBh6Ct+mxIyUhf9njKM2sfxse6YUlggAuj3v+kC6BSj1SRmvHNerAFnOdc4kiI9dtbPdNZuvvUPd4hepq56ZOD3i6r3iFsh3RB2AndiJi6OlPLclbmTKn2ILcyNCUO0aSigyq+isD/el3yNseJlTqiZGFh64ry9XWXs228MIIkZe6ORPlREIO+yMvkWdqzeeo6NnmAeJBACpccTv9i14RSW6Ar03tdmfnm4JwkV2umnVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id9l3Yf7lR0UOJupbuZOGUcr5MHccOKx4GaTSOCfDdM=;
 b=IYt4dFGdnoa7n9UuCcaBNOoko1061tpyyVvKkciSSK/Y97vaWHWipVmMbYgX5sYm0laqYKqhDjL8t2z9yS1xd7YmJngSNXVcWxyWCbgV4aQNF1uph/ky8GV4J8hV2sUHQdy/7/PhOo2w0PRs6oaUC7Ynk+HnTMfgmbyGI8PCKZ5x8vbzAExt3W2z1IOwgX8VAqvw7l1u5giWaGo7+0C3msfUOYYt92mtScAtp0fOiUXYiLK4f5gzvl3OjLtK8x7om01QAJhz70OyAS2/lr7sxkM67QY1IepHyfKK4VOJp8f0cJWQvtTEGqkxRwOBH2lnkZrKcUtEP17caZDbcN6brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id9l3Yf7lR0UOJupbuZOGUcr5MHccOKx4GaTSOCfDdM=;
 b=L624t2fNYDjQEHk7jhe9yXGe97Zjb9Qv1QKfyi7HJEq6i2esHZ3JdmdfL5mjcswi4xjPs7MS1urUcdkrLLSDfDWsf4atbMZR31K1+4Vyg+Hmvh0V0I58NeaU0ToYn6qwqMvkVB28egj0R3q1cUM07HbcEFqNo/HOs/GsJTGcCps=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:28:32 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:28:32 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Topic: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Index: AQHdGv9SXUnRiw40X0uohPZ6PN6l2rZ76V4AgAAH6PM=
Date: Fri, 24 Jul 2026 02:28:32 +0000
Message-ID: <SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260723235918.1090518-1-cesun102@amd.com>
 <BN9PR12MB5306AEF4C5587B9B8F7FE989FCCF2@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5306AEF4C5587B9B8F7FE989FCCF2@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T02:28:31.524Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SJ1PR12MB6361:EE_
x-ms-office365-filtering-correlation-id: 0afb8091-eb35-4fba-394a-08dee92b4173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|18002099003|22082099003|56012099006|6133799003|8096899003|10067099003|38070700021;
x-microsoft-antispam-message-info: BKzs9vBuA5iC65kCtd+60qSvBwSeDfnbUzGsCHhVfrHdp5jFtkwhJg9XpZuWHOgAdTDj5WvYJfS5XzPDXU5+d0IVkaVqIxt1oecKRAzuKp8AI54H6Pix0Eb8mHrVX2/YHbB6bbRN1GcvOX5Q70OtUrTn3TVr/fvfgh0E7/gcpt4mijWvYLiozctO41TJrZaNbjHBQV5eWisbRDKuQG0qChtEbX+XKCDlM1qyR6l2Hj6RxTIruAaqlgr6p9El7+7ICx17Ywc+OXoY1yy9pdCAdDWzoGsc7tauAWBUHzENrC/BBfZdZgqOnW9gNj7ME62Xcna2l76LmAd5YowZQ0am2XgAe98hdUdLi7aS3HT+NM8Dn0DQDbM0P3MTHFepb43BGxvKeyssbTwuMb9eHWcNfbLaKt0RPgc/EJ0hZvHmb+gMJz18jqHVv47ZLyUy1YH9SKo6UfZgD+XwWjb3Rdx43cjEACexoYjr28rwmiUmo3/9ZbosRXqwQmiljMzDvs8UmAeqX4UcqP1p0+CKdXqXvBSfAa3Q+GLDgeylHNzk+KLQ11XQ8L45kM4RnlAZ1EbKTawoLehrAP1n0X9LZsOrf0SPeZ3ajTNMLQaFSFlAbO043nsrP1WE8l9a22l/87x49icCZyEE3eXJfsjXb/5pUZB+BLlWiywBXrjQioIdySqR8H1Z9v0T//DgPT8sS8B7/Rpg6Dn5cKcmXVQUPryqy8OUD1ihOH+oXqK9mhbrfd8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(6133799003)(8096899003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jsxY1sXW1b1Ne3Ur/fdqen8xVS/O8kIZNX8dIEc5yByBz6+2WYl0/sKy?=
 =?Windows-1252?Q?8Fydhkb0nWsu93UMmTk53ucT7iDrSrZwOGtiRt0TzpjuFYYEryaaNhqN?=
 =?Windows-1252?Q?20o7r5wZv7k+tP0mzZsfuy0AfudSewY0sxWdNTEoKaOp9BsV/G7krvOd?=
 =?Windows-1252?Q?Vb3FdJaG96rm/5pcDhdSOqC2yv1Zr6LR55p+ykay9UjKq/0K5wHzhEgm?=
 =?Windows-1252?Q?wyZmTkrTk6O4LIrUUIHYOJKhMsDEQulb8bucK7mZykx1j/Kh/EYF25GD?=
 =?Windows-1252?Q?JHiQ1S/M0Td/fgsikuqIswjQHEylxub+FlBjwuOd5t70jEP0rIzdhCaG?=
 =?Windows-1252?Q?vzCp5btJJi4V4+y0a0wD+W3w9OemM5/h0YKF9ZEyGsjcJcK4o5aXoGI7?=
 =?Windows-1252?Q?vFlSzWWrUFo3a0hJgjGNzH+Y3v5Jxv6hZYKeshkIOH+BBI96jpvrz2m6?=
 =?Windows-1252?Q?Uvx0+thHuVhkU4kM0J/1m8mpfzgj2+f1Ppy36td0kEVv++C2+BdOqWOU?=
 =?Windows-1252?Q?Vt6sZdxnX31gvUviOfbCjJiIKsHaE6VcJ0z8LqfLlK3fnnbjUWXnieZq?=
 =?Windows-1252?Q?Ax6+U/eLaQ0L6FBhTqoNZhrTWRNZOfKwQWuueQRxuZxDnA/5fAmBH6ZP?=
 =?Windows-1252?Q?Zwji7lKCPOsWMYTp3q4gyFfuDQDQWA2Q09/woryBwDSOkqQoUNQqhx/y?=
 =?Windows-1252?Q?jbHOUNw3Lp3IEdCFhWHDSD2FTETuk8agzvTi3ybN0qGE9x5dKwZAqMNL?=
 =?Windows-1252?Q?F2U82aR/An8fUgpIQdSVYulJsQRH1ao96t2QLD77oGHIfwi9UWiYl7i4?=
 =?Windows-1252?Q?upfN4K+w+xCMgKDvxtg6/0i/eLCkAxQX8zZhDuE7XiLiQ+AXiawpVBVK?=
 =?Windows-1252?Q?XGOwr4l8dXGJ/RWVJmF5g3SGpKrlumlEUPLesBS1FA+42rvKZDyZKDXp?=
 =?Windows-1252?Q?tIr/N4ystjg6Ve9tuak2lgtQma6J5T6Nuzek1fNH9PL3c0M4619oJun4?=
 =?Windows-1252?Q?rne3dcv25oLePjEY3+7og7+ykPsnQmCfq2T1UOpySeNMh4V2wrmhtOnh?=
 =?Windows-1252?Q?AZZRV4flH3daIoqgLm7pl6bFmPN//9LWFaLW+fpNSm4DRttr6+z9k0lx?=
 =?Windows-1252?Q?1BSMGMNqNPQJ2+0yyCmJUov7Sn1+5xmUTm5XeL0d/lvzUrfHBs9IZKsa?=
 =?Windows-1252?Q?SkxRErgMcVSOgXHwEj0k+t/iyElMUVauZ6/M4fwCJ3uCqnfWojtsNEJw?=
 =?Windows-1252?Q?3AmCOVlQr/80YFbLGFaqqWo1Vuvh1OWsTO9TJU1qd4dWi08mOboyOqkx?=
 =?Windows-1252?Q?lr5UVLMwDE1eGXhSNXDjUBfj8eHhC1+Cd3MTsjqPV5yyfZzEJSkGN7qD?=
 =?Windows-1252?Q?Fkpd+LP3CDn7P5imyVdGGhE+fPj+VvQ5HOcrpWeH8vf8KIaQiWPro0uh?=
 =?Windows-1252?Q?0SHz6VXfwjJpaVvvUruJYKNFns0SCilEQ8NRPreqZg99I+BH5FfcsAi9?=
 =?Windows-1252?Q?7DHrbRtenbMoNVFwYdFdZFne48EXEm+wbuCa+AZXsAvxvGHXr583uTbj?=
 =?Windows-1252?Q?SfA5faso61vdE6k8b4cSoZ/+nYXN+f/NBcLycSTk7U2EAka3A/BIcLxf?=
 =?Windows-1252?Q?yzQ7DXiBMN1Qh2xn6YxJLFY/5FEum5aq7MdCM+wD5+EXRQ1i407fRUY+?=
 =?Windows-1252?Q?ds6fgowRkZl/uic4hut7W3iRsWlfWW2W0Axty5ugBgJASdit8yRKS9aN?=
 =?Windows-1252?Q?Je3if1PwnsyDhh9tl33Q7NRHYNJHUriIJWTIGq6RbUhfacwkWRrOmOc7?=
 =?Windows-1252?Q?Tg8IIngC73vRBvjWPPb2PA8Sf7IeQb3SxprUwMFO4a3CojXy?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afb8091-eb35-4fba-394a-08dee92b4173
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 02:28:32.3996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+iiJohfqBGpJTVYTW4k3q57KrTidN7qfVd752SzvEJSBvJEiMJt+z2a/qRmcRiY8UttbCCULFMMOKXPPAo8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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

--_000_SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2SJ0PR12MB6967namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Thomas,

Thanks for your comments.We cannot predict when the DPC interrupt will be t=
riggered, so it is impossible to prevent the driver from sending messages t=
o PMFW during DPC interrupt processing =97 this is exactly the issue we are=
 encountering, which delays DPC recovery and causes functional anomalies. A=
fter cross-checking the legacy RAS implementation, GPU reset lock is not re=
quired in this code path.
________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, July 24, 2026 9:56 AM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for r=
as ta runtime command path

AMD General

Cannot send command during GPU reset, which may cause a system exception.

Best Regards,
Thomas
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, July 24, 2026 7:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras t=
a runtime command path

When PMFW enters mode-1 state, it will not respond to incoming messages.
Holding gpu reset lock before dispatching messages to PMFW would defer GPU =
recovery processing, cause undesirable timing skew.

Remove the gpu reset lock acquire and release logic inside send_ras_ta_runt=
ime_cmd, prioritize GPU recovery execution over PMFW message delivery to fi=
x timing dependency problems.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_psp.c
index 358f602b167d..fbe91eb67c0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -374,11 +374,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_con=
text *ras_core,
        if (!cmd_mem)
                return -ENOMEM;

-       if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
-               ret =3D -EACCES;
-               goto out;
-       }
-
        ras_cmd =3D (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;

        mutex_lock(&ta_ctx->ta_mutex);
@@ -422,7 +417,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_cont=
ext *ras_core,

 unlock:
        mutex_unlock(&ta_ctx->ta_mutex);
-       ras_core_up_gpu_reset_lock(ras_core);
 out:
        ras_psp_put_gpu_mem(ras_core, cmd_mem);
        return ret;
--
2.34.1


--_000_SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2SJ0PR12MB6967namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Thomas,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for your comments.We cannot predict when the DPC interrupt will be t=
riggered, so it is impossible to prevent the driver from sending messages t=
o PMFW during DPC interrupt processing =97 this is exactly the issue we are=
 encountering, which delays DPC recovery
 and causes functional anomalies. After cross-checking the legacy RAS imple=
mentation, GPU reset lock is not required in this code path.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chai, Thomas &lt;YiPe=
ng.Chai@amd.com&gt;<br>
<b>Sent:</b> Friday, July 24, 2026 9:56 AM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Lazar, Lijo=
 &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protectio=
n for ras ta runtime command path</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
Cannot send command during GPU reset, which may cause a system exception.<b=
r>
<br>
Best Regards,<br>
Thomas<br>
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Sent: Friday, July 24, 2026 7:59 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Sun, Ce(Ove=
rlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras t=
a runtime command path<br>
<br>
When PMFW enters mode-1 state, it will not respond to incoming messages.<br=
>
Holding gpu reset lock before dispatching messages to PMFW would defer GPU =
recovery processing, cause undesirable timing skew.<br>
<br>
Remove the gpu reset lock acquire and release logic inside send_ras_ta_runt=
ime_cmd, prioritize GPU recovery execution over PMFW message delivery to fi=
x timing dependency problems.<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/ras/rascore/ras_psp.c | 6 ------<br>
&nbsp;1 file changed, 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_psp.c<br>
index 358f602b167d..fbe91eb67c0e 100644<br>
--- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c<br>
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c<br>
@@ -374,11 +374,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_con=
text *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd_mem)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -ENOMEM;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ras_core_down_trylock_gpu_reset_=
lock(ras_core)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EACCES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_cmd =3D (struct ras_ta_cmd *=
)cmd_mem-&gt;mem_cpu_addr;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;ta_ctx-&gt;ta_mu=
tex);<br>
@@ -422,7 +417,6 @@ static int send_ras_ta_runtime_cmd(struct ras_core_cont=
ext *ras_core,<br>
<br>
&nbsp;unlock:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ta_ctx-&gt;ta_=
mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_core_up_gpu_reset_lock(ras_core);=
<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_psp_put_gpu_mem(ras_core, cm=
d_mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2SJ0PR12MB6967namp_--
