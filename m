Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46B1C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 03:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A1410E5DE;
	Fri, 24 Jul 2026 03:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/cz4HBt";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1409610E5DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 03:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNJ26Jv8TfESAGwiyLHZP65ClLD8tAPjNRDLmN8Aao/eJvMbdoDnKuinnewDeugSHI8fMqOdTWT0KOmilwWVllLui0tGOg8/mF7NeTq34ZDhe6CEeITaRQFD9RVZ/uikX8gnqw7Sg+6kjKlOOXPRJuuHcFIM3+7pqYAJFqPgGjQv4rpVJGSFmjjRQZTKYp55mIYRiiowQpMMxrV7a+jnFlR4xKqdkIJkygG0yXUhJSqs4Qp/yTW3e16SmdVRAFutACC4G3e8xFevo4Cae/yLKwJghu3XXCSXIoHEJ0nl44cEw6x7xXgMeKtrcwbS55HOtOEJHSTkQmeqjEs3Ie7ovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb4aIEV7fL7nUkm0c3VHgZKqLkdSqVAx0YMdkKMbaB8=;
 b=Qj7LMLwjEDZZXWoTLn9Qqm1oKSZAnpjrKMj9WDCSUlatyN30mCGKvWfmNxsX99c18rEXbkd/2ffe7ESlRHjg0WnM5E9t2WjzTLUzI/SQ8YmOAhAHxKDGK2tUmzVRTVBTQLCl9CeVdpmthU28vXcmO2/Mn4HlbmmoQXL1ryyI56CL8AlLGS1gNZh3geat9jWam5anMfanvVTGLgNzw3qN0ymzD4IHeM6COLeVQrnyqjoof58OI5Q+hp+O81gq+6rP6OmLZgCduhl624sRY8pbGbkFiUKstwcRcT46f24HqQwe9Y3Yy1jXMbkQfMd2RmkrrcZSqqmjfurx7sRJZoaBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb4aIEV7fL7nUkm0c3VHgZKqLkdSqVAx0YMdkKMbaB8=;
 b=2/cz4HBtS1mFMTi6yDYK9rLmwhNiM/dp6kOYYu7FTRZZoUM7HdTa6QjSGGB1HBB1/XVeCidUlDaLbpKa9Izwb9eoGjvIwh3JFko7gItWM0Y1tdE9cVCnI3X9on54FbSXtg8TUP1C9r4RItmOFqaBLmqPKDyGDcKpyPlTaS8lQAw=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:26:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:26:22 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Topic: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras
 ta runtime command path
Thread-Index: AQHdGv9SpedrW73kOECSnQZHcAms5rZ76V4AgAAI4ACAAA+ZoA==
Date: Fri, 24 Jul 2026 03:26:22 +0000
Message-ID: <SA0PR12MB7091B5F806F05D64530E9F6097CF2@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260723235918.1090518-1-cesun102@amd.com>
 <BN9PR12MB5306AEF4C5587B9B8F7FE989FCCF2@BN9PR12MB5306.namprd12.prod.outlook.com>
 <SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2@SJ0PR12MB6967.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB6967FFFCD9A358C51B5C33769DCF2@SJ0PR12MB6967.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Ce.Sun@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T02:28:31.5240000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|PH7PR12MB6907:EE_
x-ms-office365-filtering-correlation-id: 4642f9b8-6509-4550-4c3c-08dee93355f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|8096899003|10067099003|38070700021|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info: wNForuFDlaoTJR+yZm/Xe4xvmirVen6QU2xTHXFEninUWg+nrOLIS4pOJB+kcBQLXKnhPLFsL7oGr7YkimKTz0U+mM6YQ2aT+wZgAtPUnXEqLU2VB+VDZFT4oE0WRp1oFa77+ANQ1mJY8G9VFMzojxnQODfk/7Brj0UDRm+GmjCEGOhGLyCmS3exRi7/tgdIEKypeyOKarldXpUioLWfzhKK1qAcppoGDstdTQNoRzYXRfD401zkl7SvP5KQl6pwn4CiD7wVQaq4yxVmOfB5MjLmQaBNRRKmaHXpuVMxcFaOte5OgYbrIq28N/fV7gkoyW15N9QWsK/RFuCVwYyHWTNWKF0GEHo1wAwCjDKNzPzDJZmsV/Q2lJ5+oWeHv+B8gfqRzGkfPCbfVZMiaGp6jZhmT9ilBziq7UqiWtEp7FQNOJSsUvb4mTTm0HOLNqQJsS1qr3GqE5DMHy+GrvaTF05M+AzCRmw6gxDLcWbw+P/wrIGrRqjPtn4FTSKDTz2aqKqPTcMysoCk3rCbZFP+vNppm34wLRpiXn+poomYo2pqGLuA8JH5DiALh8ksQE5G0pI/hvIDwIU8P07mvMbQ/t9KG8lb3KhKLLmVivs4orndm9fiGDImMhtx38/9fKt+NNsoKlGMWn3r7P8/8V8YKw61fCe7oV8Xh532GIq6cIXBKQElwXdA2B1pnB24U5Jh6NmlkgJCVyG3MTN/qmc9njjeTbn8DZWRB5veIjqymu8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(8096899003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8GHAU849eGioxRMOfUSENy84tQtU8RJUDqWPQfkSFUrQL601VTf/OgBg6fgL?=
 =?us-ascii?Q?yPfdd3MIYUmuz4jVUHugjru/hq4+RXkopxG1uUnvtZKngw/gz9ag2PAjdPAe?=
 =?us-ascii?Q?9TctXfRdR+v7sMGKFQscyeHDmwUyVBwU2r0A/XqmbsOdQn/c0tZQ/XUuO6UR?=
 =?us-ascii?Q?HR4+j/B4863Blr3IVXXJ7xmqzzjLVNLYQOudELVJ8HaT0HtYJQBOLrInGtSr?=
 =?us-ascii?Q?zhb2+tYhSrFlXHTiLNe5yS7xZfhrxDvZqscamwwlNcqhJfmDtKWY6A5ssvz1?=
 =?us-ascii?Q?7ay91zXt716tmpQeLZ6kLdwL3qoUFapWw2txvKIRX1DaaM8qtH2Fwiyqn8IH?=
 =?us-ascii?Q?OV10+CVYuI7P2pf3teFxPDqBJnPLRVMSO8Pn0OQm/gtFSNS1MW0tJnQC9idF?=
 =?us-ascii?Q?mWrHWcho96OY3zrjwo6QCHGmc/B91tDkTFOYR+a0ua9KnDJfBCC7ADQKitkv?=
 =?us-ascii?Q?1bgIYV0l3XqjR+EbwBD0gMPrNzeFrWq+VjGj6iePo8sXizIVVrSbzgPxr1OO?=
 =?us-ascii?Q?pFzZciJ7f4W8RdbGMsnpxDH2tFcxLuhAk1hd2zgnjkjs9pZRBgPka5y3ObXM?=
 =?us-ascii?Q?WnEsJNlEN3dKrP9jy2clOSxA/iA/bB9OhKTVZmx56mEteIIay0gM6uh+9OtB?=
 =?us-ascii?Q?12G8TSrfRI9aTkuihCCSGRymphaa9jJRsBXQmYNEQ8I1G67qFJPRBREZBvNQ?=
 =?us-ascii?Q?DuVlwaUW7YdnyhFFKC2jBS5mphTbWxEsTQngUyn9eO3L5pmZEstStf9CA6C2?=
 =?us-ascii?Q?dFpAzPNS4WUbKZK23cRig8WVv6/d51bCmAOsQ94OgmHlXxydp4/C1DdtqI4w?=
 =?us-ascii?Q?os1ndvPct9dRsE4qe8CnCPH1zi1jyxyKW38qic1CqNebZFDxpNYaktyDI2eL?=
 =?us-ascii?Q?lEuOL6key3ofVMJKEHl4Y+yw3WM7oWnLAA0SMrBG7/slmRg8ulggvguaOt2u?=
 =?us-ascii?Q?cePCgwCz/lLuBPo4PR/XHRcR3vM85fFkDo3BDGKVBClGijC+PWatwUgJpnTY?=
 =?us-ascii?Q?b/nKcDDgWPtaAHxTs4BYgBx2Oum5iqSpqi6iYTL3Y0d1b/2jeymNVIkRs2H9?=
 =?us-ascii?Q?fs9YvcrcToIU6nRQVi7ajKlVMKOYxEsymW57DAULVQQhnXItGFE9pmYd0fej?=
 =?us-ascii?Q?fskF/IWJCHeQIxaC6IpPGyG8MZBbO9Ytw18t8GYnkRrpIsFVHgkHZMxcDF9i?=
 =?us-ascii?Q?Z8jn0yWoP/47F4oHUCQWKwrmsGilwFWHfF8KreFHWOFK8fa1E+InZjF09Hkg?=
 =?us-ascii?Q?66NDWwV0rrQumqtYCkMC37oPd64A7cJyaN1YySToaSZIXBtUpyY3JPneYApW?=
 =?us-ascii?Q?U5vxrFpV2GhWG7fCRd6kBmJSg0T9maHMSoajHr6/F+jeEzlxkGuMkKzWfmQK?=
 =?us-ascii?Q?X3k4bm426uUzkTH8XuIfxaR79biKmUeJneHNaCU4HIrx7qC2Oa79cLrUm31/?=
 =?us-ascii?Q?pzj/IpV2i8yMIsTOFcvKxQrv82jr/YsSGTvQprjCJueqqAzgxDkvuG8xRu6T?=
 =?us-ascii?Q?gKhdvlQhHD0+ls22iz9CNMmep0S8+JHEo11YAbuRyVAqIA/fM/i4upzbM81V?=
 =?us-ascii?Q?XMbUkkO8X5NGFzz1HyOptfbKHbtJyrTmP4h9EOMWfC+fPVGkVQ3RYQLq/s+E?=
 =?us-ascii?Q?iPAWhkGynqpkQlHpClfQ/QWvvdnsURkKdcT9lWB/cfcDQWurwr/MZg1TZufa?=
 =?us-ascii?Q?5s9gCq4nv53Q1CICdNmdDmUWXEMlNw/EM1qjWzi0q5hLfKil?=
Content-Type: multipart/alternative;
 boundary="_000_SA0PR12MB7091B5F806F05D64530E9F6097CF2SA0PR12MB7091namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4642f9b8-6509-4550-4c3c-08dee93355f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 03:26:22.7185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2j8hNL8wCvyz+MR5CAnjnOFMqVlrovcSHqgBkBnGtjlThpePc5T702w1eop9G70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

--_000_SA0PR12MB7091B5F806F05D64530E9F6097CF2SA0PR12MB7091namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi, @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>,

Could you add a device lost check to exit early from ras psp command wait a=
nd see if that helps?

        while (*((uint64_t *)psp_fence_buf->mem_cpu_addr) !=3D
                   psp_ctx->in_fence_value) {
                if (--timeout =3D=3D 0)
                        break;
                /*
                 * Shouldn't wait for timeout when err_event_athub occurs,
                 * because gpu reset thread triggered and lock resource sho=
uld
                 * be released for psp resume sequence.
                 */
                if (ras_core_ras_interrupt_detected(ras_core))
                        break;

Thanks,
Lijo
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, July 24, 2026 7:59 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for r=
as ta runtime command path

AMD General

Hi Thomas,

Thanks for your comments.We cannot predict when the DPC interrupt will be t=
riggered, so it is impossible to prevent the driver from sending messages t=
o PMFW during DPC interrupt processing - this is exactly the issue we are e=
ncountering, which delays DPC recovery and causes functional anomalies. Aft=
er cross-checking the legacy RAS implementation, GPU reset lock is not requ=
ired in this code path.
________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
Sent: Friday, July 24, 2026 9:56 AM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>; amd-gfx@list=
s.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.free=
desktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Z=
hou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Sta=
nley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Lazar, Lijo <Lijo.Lazar@am=
d.com<mailto:Lijo.Lazar@amd.com>>
Subject: RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for r=
as ta runtime command path

AMD General

Cannot send command during GPU reset, which may cause a system exception.

Best Regards,
Thomas
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd.com>>
Sent: Friday, July 24, 2026 7:59 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; C=
hai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Zhou1, Tao <=
Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Yang, Stanley <Stanley.Yang@a=
md.com<mailto:Stanley.Yang@amd.com>>; Lazar, Lijo <Lijo.Lazar@amd.com<mailt=
o:Lijo.Lazar@amd.com>>; Sun, Ce(Overlord) <Ce.Sun@amd.com<mailto:Ce.Sun@amd=
.com>>
Subject: [PATCH] drm/amd/ras: eliminate gpu reset lock protection for ras t=
a runtime command path

When PMFW enters mode-1 state, it will not respond to incoming messages.
Holding gpu reset lock before dispatching messages to PMFW would defer GPU =
recovery processing, cause undesirable timing skew.

Remove the gpu reset lock acquire and release logic inside send_ras_ta_runt=
ime_cmd, prioritize GPU recovery execution over PMFW message delivery to fi=
x timing dependency problems.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
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

--_000_SA0PR12MB7091B5F806F05D64530E9F6097CF2SA0PR12MB7091namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Hi,
<a id=3D"OWAAMB5DD1412D6674FEAAB39D21500D95D84" href=3D"mailto:Ce.Sun@amd.c=
om"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decorati=
on:none">@Sun, Ce(Overlord)</span></a>,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Could you add a device lost check to exit early fro=
m ras psp command wait and see if that helps?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (*=
((uint64_t *)psp_fence_buf-&gt;mem_cpu_addr) !=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ctx-&gt;in_fe=
nce_value) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (--timeout =3D=3D 0)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Shouldn't wait for timeout =
when err_event_athub occurs,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because gpu reset thread tr=
iggered and lock resource should<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * be released for psp resume =
sequence.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras_core_ras_interrupt_detected=
(ras_core))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Thanks,</span><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"><o:p></o:p><=
/span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Lijo</span><span style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif"><o:p></o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Sun, Ce(Overlord) &lt;Ce.Sun@a=
md.com&gt;
<br>
<b>Sent:</b> Friday, July 24, 2026 7:59 AM<br>
<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Lazar, Lijo=
 &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/ras: eliminate gpu reset lock protectio=
n for ras ta runtime command path<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">AMD General<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Thomas,<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Thanks for your comments=
.We cannot predict when the DPC interrupt will be triggered, so it is impos=
sible to prevent the driver from sending messages to PMFW during DPC interr=
upt processing &#8212; this is exactly the
 issue we are encountering, which delays DPC recovery and causes functional=
 anomalies. After cross-checking the legacy RAS implementation, GPU reset l=
ock is not required in this code path.<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Chai, =
Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&g=
t;<br>
<b>Sent:</b> Friday, July 24, 2026 9:56 AM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@a=
md.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.c=
om">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.=
Yang@amd.com">Stanley.Yang@amd.com</a>&gt;; Lazar, Lijo
 &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/ras: eliminate gpu reset lock protectio=
n for ras ta runtime command path</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&quot;=
,serif">AMD General<br>
<br>
Cannot send command during GPU reset, which may cause a system exception.<b=
r>
<br>
Best Regards,<br>
Thomas<br>
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.co=
m</a>&gt;<br>
Sent: Friday, July 24, 2026 7:59 AM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"=
>YiPeng.Chai@amd.com</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@am=
d.com">Tao.Zhou1@amd.com</a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanl=
ey.Yang@amd.com">Stanley.Yang@amd.com</a>&gt;;
 Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</=
a>&gt;; Sun, Ce(Overlord) &lt;<a href=3D"mailto:Ce.Sun@amd.com">Ce.Sun@amd.=
com</a>&gt;<br>
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
Signed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.=
com</a>&gt;<br>
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
2.34.1</span><span style=3D"font-family:&quot;Times New Roman&quot;,serif">=
<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR12MB7091B5F806F05D64530E9F6097CF2SA0PR12MB7091namp_--
