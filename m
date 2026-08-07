Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D907C5AC80
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 09:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57A010F417;
	Fri,  7 Aug 2026 09:06:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBu1ah6X";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7391310F403
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 09:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3Rews2goroVt+wUNXs5UfnXqY5h4Mh0PnlooDsK6LxHP8nI9qkOlnq95QrMroJvbVJfQ91mb7caWl/LZmMqP3O0cSiHhRuYIEQ5vuzUzP9W+JTIUbililGh3XZSzMyOwVwJ9Df02/TFZRTPs/FokSZUr6ylEvFNQ1dAEu7ATl1otgkU8E1qb8iag/SXq5Rh+HiurJappmSh4t3TX83/d7OQupPft4sbIZxkRvNjoqiRGv5GGwotaRiRIdIyl7bHP0Xibhcssmitne8ZyDtxBeXzkCy1UZheZKXgM0p1kE2EviUbiGkzLNATbg/sbIXsumwjwc/FthDBrsWCSK6uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q44gMe10r+iuH7sqcpQI5uURVcG8Xc5LjpVqlBN5S/E=;
 b=sDO8sR8HbW0tBaPUjlzHLY4DLOm1rT8CjCU8NXXz9TrnyRFS41GBEWjuBvbxS/3MRGG05s39TRQS0eO9G42A/HtuN8lbUIBi8lI+3LWNLkCo1NPMt+XktpnI1lxYvTtd5VKg4to4OXK7avHmsmpIYbtCcAaOFbNrrEX0JhVvb5ECZ+XCE+OMxODPxAdVsJwliF/eE0GKdpdhE27s5dteHaPtaIRzTy3VtBBx+A4taR9F71Yz3l6NTept7XnR0NpnsgyK8hhQVAxGOWwcsKAUPebxIPSTDZuu03ox74atvuW42oyo2aUoVXxDKzQ2Vm7kSbfUoHwc8OUv6antSnxgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q44gMe10r+iuH7sqcpQI5uURVcG8Xc5LjpVqlBN5S/E=;
 b=KBu1ah6XWSmphm2hr1JPf0tl4ce2Xd0bvF0Y3VLwaVD6LMmK/9UYvgZqWFCvSP+UeXu5WJ/gOTdjkp5ieVgdphQyhuFnw7e1Mrqo3uuiZvZ+vxbnMUQqNzjVjhG+zV4U2UwdefoogELf1jfzGxI+hX0ht5oxi8ba9G5TAKC1fHA=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 09:06:32 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%3]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 09:06:31 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by
 DPC
Thread-Topic: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused
 by DPC
Thread-Index: AQHdJjrG3F2AzDjQ2U2cuip2eiCKxLaSPrmAgAAMhjE=
Date: Fri, 7 Aug 2026 09:06:31 +0000
Message-ID: <SJ0PR12MB6967A75F954EC4BD09EA40A89DD12@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260807070237.1169684-1-cesun102@amd.com>
 <EAYPR12MB999158FE6597CE2D6AA590FEEFFCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
In-Reply-To: <EAYPR12MB999158FE6597CE2D6AA590FEEFFCD12@EAYPR12MB999158.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T09:06:31.018Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: deee0e4d-212f-4ba4-f9a3-08def4632c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007|8096899003|38070700021|10067099003;
x-microsoft-antispam-message-info: S9ZvXNJGgi70+1dyYD9/xNgu5siIFYUXTs7eg7GLnbMeF2UhZgGYJerwzGvByJ72zcYT1e7qS/lmSHeOUktxvM9HIzBNSkKzWWvS5V5+b1rjLOWKkieVWB6xidVUpEVYPxGmOBA2u/ySnzZ+YbdpkCQjTU15C8mTHzafZShWselactpgqqLUbgajkzZrN9sE3fKW6Tiq8VGUTyoQeIa4cwNuvraBGnKOcTNch+WaPTW5FHYBy0RIZtwiDtN7GTAZYN5mwb91hMrnqqfg3bpv2K9pvjzjN+MP1VO9o7Z27/pHQPUGs+pIIXbTwNZ9Za88ScKJ0VGZPZ+ywROOq1BgsvR/LuVc5m/VhxyBlz9Rg2mu8YOz6H0xWoOjNm5CnqH5uUSfCFEIdb5OTtfe7iQ0Is9N6/zYLTJyG1jBrC8q3h8oT18ti904MbGZvYIqYxcL6/aLiI/gu6l+M5xRJMYdoQUagRez+zNfdHeSsqfSZ2Kcq3efdg0zD51SMxWpR0x1749vd++eZiovJnoSYXmkr5AmXhyB7D/pzpCfIeXml1aFsR4h4kdt+dg8FZ9t6YyTX+KvAxIsieEULMfqCae/UIoeIAAyvivl4ar9D6tiCxPPi+2sW/LhnvHnjygvwBtQKmMZQ4h7WQc+fkl/EIsabYPGq8yqcNVn6qSf6MtNta5imArOJwC/cxPg6LdDd3ikzhIX7oQcOrIc6zXcIilgIc+dUm+yUZTextg50+tw8qI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007)(8096899003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2EHrgEpkS4lkWUJHmc0qdaCb4RMU+6TvD9/9yO+C7xuqk4vmSuH+WLWHFFE?=
 =?us-ascii?Q?3MdoZjNKMVaHl9vx6v5wxxq33BQP/lutbMp9NRXcVBauZRd/cnL1/t/H2b1w?=
 =?us-ascii?Q?vzNyyj34ch+tbuWDkD3Cvd42pzCrneWT6BjgXj1PQWCKsgHHt0prGgkarrPk?=
 =?us-ascii?Q?yLGryO/ptclH1EcG6BUWxEo3LcneHbtirICLT2l5p7mXma75TwH7FnMc3cpa?=
 =?us-ascii?Q?JT6RtyLhNXhXr//XE3Gq6NY2GrxRTb8OQkHPhBJhtIVoe4hc9QhE/drZHZxV?=
 =?us-ascii?Q?CfbNdLO158BjlValdRbNytrs1DePRBoj2MfzjoYbzMx05wz8QQcXo0kclLNw?=
 =?us-ascii?Q?cnTKh8g+8spd6gT0U/DfraqmpOSv1Nmwp+E3LdS1r5DGYQjXQ902ToYpwHzN?=
 =?us-ascii?Q?MQ+RWdI71bybzDKMrSi+ERM3+BMJWayuWL3J9f8eoOKljCEO9esiJUhsd8nm?=
 =?us-ascii?Q?7woFwsf8FQd0BWjlImPwfQMxuGje50gxCMKgzFLH4TLpOX1nWToJshkbyyJp?=
 =?us-ascii?Q?NkV+X4Koc2ET3hbYcvIFXOPwsv9sOuAobBqQkAQCan8wFgXRQZtVATL69LQv?=
 =?us-ascii?Q?pgvh1yQ2XOkW+QAvfS0I7q+GCJHAnnMoyHwvQCuxGQoln4DYn/zopoZxvFDt?=
 =?us-ascii?Q?I1LT7siN60xsRFvNdwEAIOJPAiiJw9gYsw6Kt4w4Dmdb6fElL8R9Fan/uM7n?=
 =?us-ascii?Q?uYDkSqpiJOfvl5+p64T2cXxI1bPz0Zk4kYrw4ZC0tTrNHIlLudwMPi65kwIK?=
 =?us-ascii?Q?rl4qwKnhhgB7T16mnB0fJjABcL9nykLLyqgVnfftdKTWtvl3NDdwh5NkvBCJ?=
 =?us-ascii?Q?+fQgMFFoM3yU39UnoJb7lC6titgWkHDeJias2QJHmZJUacIes/6wFJahB7FF?=
 =?us-ascii?Q?F7lpgKhg5sJMWKjRz/llc3sB/Jp0POQEBtaxuDjhT8Q+RC4bGJgEaFLl1NQc?=
 =?us-ascii?Q?mxHmcqlDCM087gzxpJNhiUy/2cTXSHJE+OXJIVfOCC/bsa7ju6+eKTXhsyRq?=
 =?us-ascii?Q?Dv2SzIXZK3XYjtFZhZCAwoXFyOTgOsAlWqaV8m6lTJljYHTKL/JZAUr2PJhE?=
 =?us-ascii?Q?W40obLmJYZT4I3AGGlxBCMwgk+5vHl1SFxoAsiZgxCfdoAaQTcXWsakLJzaU?=
 =?us-ascii?Q?XBW2pnMJXckItqnP46BaOx0E/hPpIg2qB89H/S7D+1zd2u2G8VtgN4FsjP5y?=
 =?us-ascii?Q?wXrWRwmt36Jv5utUFvsxDo1QzLkkUFai6KXPq98yAB0pYjV0aquGfIDTAIBJ?=
 =?us-ascii?Q?PFlEFrG53zKITzS3sH/LjyNENDDlYfgOKpKOnQfDSFqlwIK3UOuz6GFcz9MJ?=
 =?us-ascii?Q?NpXR94jDbZp0XgqLvhnMhO17RlthXeD/n1bK2ZKdaKJQhmqs4n7m/tcK1i34?=
 =?us-ascii?Q?tuSQw+ENJscqlQTEa7qQdrPWNqEqvC3b53T4FneDlGNMyqqwaSGsBIH/kMES?=
 =?us-ascii?Q?86hwCX/oxtDFVQlq3TtmBRWmBiL1f7ukPeDiqqgqY88SZ+rMzalKUeeM5wGG?=
 =?us-ascii?Q?aRyTRVMHV8Ja4oCkXgyAPTquOuehSiX3hP3u28PCICoEroyvOl5QR2yMcFVP?=
 =?us-ascii?Q?u9kXkzyQe4AQq8FOpaXSDUTqJas2JPigP5N04GRwS9ajj0f8CPyUZg/um9cM?=
 =?us-ascii?Q?iHs3ixlCiyTGRt6wVlJp89WAxUCntu7gjAhrFym9wim63v4vzTGumKlcTjyO?=
 =?us-ascii?Q?svUYgRB5anX2HjrsaA870Foa3QvJOUsoe2WgrM/r8fyw9ILN?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967A75F954EC4BD09EA40A89DD12SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deee0e4d-212f-4ba4-f9a3-08def4632c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 09:06:31.6936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJWrkGgWDZrm1mRNBOl1JBP2Op9zzZHEZioVEsTpNF/Pu39r2NzFNwh/wp6mnidb67RsOKiFApHAE5IyQt0b/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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

--_000_SJ0PR12MB6967A75F954EC4BD09EA40A89DD12SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Thanks Hawking for your review. I will check if this issue can be resolved =
from the user-space tool side.



Regards,
Ce,Sun
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, August 7, 2026 4:20 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yan=
g, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused=
 by DPC

AMD General

Would it make more sense to set the RAS query ready flag for the DPC event =
as well?

We should keep ras_query_ready as the single flag for all RAS sysfs and deb=
ugfs nodes. This would help simplify the implementation in the RAS block. I=
f the device is not available, then ras_query_ready should be set to false.

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Friday, August 7, 2026 3:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by =
DPC

When DPC events occur, the GPU bus becomes unavailable and all user-space o=
perations should be blocked. There is a timing race where rastool may still=
 send RAS error injection commands to the driver after bus loss, which lead=
s unexpected failures.

Extend the readiness check in ras debugfs write handler by adding
amdgpu_device_bus_status_check() to detect bus lost state. Print warning an=
d reject injection requests to notify user-space the function is inaccessib=
le.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 35eb87591740..4943be034c80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -564,7 +564,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fil=
e *f,
        struct ras_debug_if data;
        int ret =3D 0;

-       if (!amdgpu_ras_get_error_query_ready(adev)) {
+       if (!amdgpu_ras_get_error_query_ready(adev) ||
+amdgpu_device_bus_status_check(adev)) {
                dev_warn(adev->dev, "RAS WARN: error injection "
                                "currently inaccessible\n");
                return size;
--
2.34.1


--_000_SJ0PR12MB6967A75F954EC4BD09EA40A89DD12SJ0PR12MB6967namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks Hawking for your review. I will check if this issue can be resolved =
from the user-space tool side.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Ce,Sun</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, August 7, 2026 4:20 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zho=
u1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;; Lazar, Lijo &lt=
;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus=
 caused by DPC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
Would it make more sense to set the RAS query ready flag for the DPC event =
as well?<br>
<br>
We should keep ras_query_ready as the single flag for all RAS sysfs and deb=
ugfs nodes. This would help simplify the implementation in the RAS block. I=
f the device is not available, then ras_query_ready should be set to false.=
<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Sent: Friday, August 7, 2026 3:03 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;St=
anley.Yang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Sun, Ce(Ove=
rlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Prevent RAS injection with lost bus caused by =
DPC<br>
<br>
When DPC events occur, the GPU bus becomes unavailable and all user-space o=
perations should be blocked. There is a timing race where rastool may still=
 send RAS error injection commands to the driver after bus loss, which lead=
s unexpected failures.<br>
<br>
Extend the readiness check in ras debugfs write handler by adding<br>
amdgpu_device_bus_status_check() to detect bus lost state. Print warning an=
d reject injection requests to notify user-space the function is inaccessib=
le.<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 35eb87591740..4943be034c80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -564,7 +564,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fil=
e *f,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_debug_if data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_get_error_query_ready=
(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_get_error_query_ready=
(adev) ||<br>
+amdgpu_device_bus_status_check(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;RAS WARN: error injection &quo=
t;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;currently inaccessible\n&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return size;<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB6967A75F954EC4BD09EA40A89DD12SJ0PR12MB6967namp_--
