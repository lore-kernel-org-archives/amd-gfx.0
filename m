Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADACF34C49
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 12:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC4A10E418;
	Mon, 13 Apr 2026 12:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxljZkGv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9EC10E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 12:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA1ntCaBW4Mh696BRtk2nUvrSxEZRIljmuHiEVRpTfiRovstqIXLfqXDQc8fWFytsH1SrcDXUZofRnPyPlKRC7P/LGc58i1Y+VNqrMtP1zLPlRpMwoCtOdstI9dymzb16rq1YUAZjTYMRj+dag0n4QpTOvCI0yQbeUKEmQ2Uz5wPkKF0/UtihG1Tt6/1nU56Uk3z0uw04pDPrfBHmsCFwZCo0yUDhWkVIGUoF6ytvTj0uF+HPUVL/AUrTvS+eW0RXnR7CE011zHdGstYLjHj8Qaa5dngyuUzKqvfgNJ93dILxVSr1iAi8zEPfAfiYiAQVAZJtiuz2LqiPOL5LdO5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcrqDCNkBPUXhnPinyE9aTXX83dzg9Jpto+hqv5y7C4=;
 b=WtCO/uTAOjG6PTSEBQLs0nYfgIkuTpvoQaPj3+iSbCDppW/W/Wt5TvSUUyXValyR/kxatoGlDCaMhg/KiCvSox/aP0AcKu+6gDUXHZb1oiuXsdyFApGaqCbFwOhKsJnoixs7syJRtnbC0/gKGkOftLFqtGnNwXxdDc68IfUjzXIRBzbHTJau3SDq6UbQrF9dBvDA6kxKUS6S0lZ3STG7Ksv7zwtFwyFdpUMy1GmEAmr952N37GA1MbdkSOVaOF26PkpdWrRz4vIcnhjILEMPI/He1bvQSauXgpM4paiC6sVJq1eqlJEwulnIr076vs4b3bguJgoC+DHqJlosa1GXAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcrqDCNkBPUXhnPinyE9aTXX83dzg9Jpto+hqv5y7C4=;
 b=xxljZkGvfZQByiHXVN0QYofu/HiW2oeYhStLjrFF818D6I6IRv8y0oAEqWdHtwxKycbCgLH4MrEFuzKweVThGQP3AOZvMM/Ac6E83lcyekZc2glPcNpvkOjdjSyuwOtbyOhAQhOrsp2BNaeX9T7dkRmSsJBKQyi9M1dUt0QJm4Q=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 12:11:18 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%7]) with mapi id 15.20.9791.032; Mon, 13 Apr 2026
 12:11:18 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH] drm/amd/ras: remove update ECC status during hw_fini
Thread-Topic: [PATCH] drm/amd/ras: remove update ECC status during hw_fini
Thread-Index: AQHcyz2V38kjSte7okG189M8B8gb5rXc5nMy
Date: Mon, 13 Apr 2026 12:11:18 +0000
Message-ID: <SJ0PR12MB6967CFB8595B782B4E14E1699D242@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260413120322.2233542-1-cesun102@amd.com>
In-Reply-To: <20260413120322.2233542-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-13T12:11:17.919Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SJ0PR12MB6904:EE_
x-ms-office365-filtering-correlation-id: a72901f2-878c-490c-8b26-08de9955c4c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: e4m35IER16ss/MyGuUTcUPjRHUCPJKTEtnCoyZNLccrgEkqLMbVpkCHwjFw5z0hSTJnaNjpeRLJQQ5FRhcBR/tMPMkfG9GXRqM7f2+Py+XrNoI4GPwdPkMS9EDtKTHjhZt8R5LAAE7Q76Sw9VLaAHT+na4mb3+pSQAsmun8uoXmCdwbFZfwkEm5V8dEQNJP4Q/5LB58gRvkVbzYKWz5nQknyVPQ/m04j2zHqJ84mVB0V7Pn1dzgwz0cfD39zDl3gm6AzlpmdjCUvL1KEIxOSlhP1iEQwDspB0EYpGAweg69nC2lV8vyA2YgpB1mob7Xwxz3whNBKL6sESfNHg6UIfUpSCs33ybiW2XqiMIA+dR2dexUArHL2EHk5BhZ5whUIhqXEcaoOpv6B9JJjpdlPDFNBaJd42WLa/lcoIIGSrdOHW93AcKmVjlcwa/yHCvVIDFEnI61xJrpZ+NEXs4VTb37GYVVkydMnWNgAYRh1cRZNSpxoW2ILIp5Cn5PnxUnDiCGj/ti+8M1iPE/Gj/gh4UmrdRvUb6funEbh9gYs1E//Rs2wxXnZZ3FbA83RARUp5ZghiKUn7+yq+TpLJIbicP5uvOASb3KvXco+xYXUUGbAt3Mk29NfQoqne5GERun/C4WbVXAL0LAUsP/N4azIOO0B7fFnmtBpvxCIQFBYOfgIPjgcLtbsDvJ3Nu4/nFHl3v75P3FSFjOUy+O2tv2JD4WnJ92u8uuJV0/4W0c67DGCZZTZAJ2fB2NfVKfHL9mNJIDdSj+1p+KW68x6WmZFKCVdoH4aGt286yvZW16uacM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TL1Bo5XIaqblSt4UeiReT2vPsvwlPeHj7+ludg1INS7sOJleqCHnrnL/6wGx?=
 =?us-ascii?Q?DddKhj5uGUyT/by7vTu6jIKGP8dreCaFjBnwOikgMdQrQLSK1k1rznOe6xjP?=
 =?us-ascii?Q?+vfKiVOyZ6NQgiyVJ9z8DcWVwj3iiN199NvaqDrscEWaeqix0XoYek8mTJj7?=
 =?us-ascii?Q?/wQjuMfi3f7YkAwmUaO2N+bZQhnqh+niU+vjN4fUjIBNLDewhEbDOSwAM97Z?=
 =?us-ascii?Q?5Mg3/85mOIoisaucCtks6gjqEQN1taBdmUKWGXzVuFcrrXqDpLj5no4OCxfw?=
 =?us-ascii?Q?vmX9XLURJKoFZh7KkkLLnqJOWakJXXFO3FmaVvSerKfwNIYSHvZtn9jDKSG/?=
 =?us-ascii?Q?ahcIaLElDLnTzRxNOkiqwb7jqkO3CPer5amgOHFcyH92F40kxhUFsJPraXnZ?=
 =?us-ascii?Q?T2EteWZxszUVQHnh3vulA80gecXBsRNfPf1TOgMqZa0u7a0BIirnvpaYwQUJ?=
 =?us-ascii?Q?d7tPcGTC3bS9Gha94i2THIBrK7AOrIM/fLlK5gUSMe8bNv/CWbKlLtspA87h?=
 =?us-ascii?Q?N6H0CcLVpTP8Qo1Bn3HqYh+1u0Mdz9dVICjxTSrib0WL7POkDWkvTffq/I19?=
 =?us-ascii?Q?CWUXdvR0YpurRCI2SnX+fG3EAoBTlmTkHpSF8alXZdQoroCv2aMfLiZ7hWr6?=
 =?us-ascii?Q?D1VumOwmtSdQRT25kUApftYDWM0hMbRDdri1+v+xfKCcgLv4EoBm/l9DwZ8Y?=
 =?us-ascii?Q?POW7N9qNWK4KVt7dOk203e6TVrIG+IB5PIo+TH2IQv2cb7oHUJo8HgHWNd7s?=
 =?us-ascii?Q?lPwRzrvX9woTeLbnvX8NlwDRypmgeEaM+1pJD7aw++jEzuJIkm+3t5cuJKLn?=
 =?us-ascii?Q?N88xExY1PHyhI3Eh3eB7/soilHcy0aedS8+36foOXgodkBNIi0xBE4cbpJGq?=
 =?us-ascii?Q?zA7LIkI6KpMpT9ibF2iyze91uR8donqb1A8djAPXNLyWb7y5414oBxRtUgbw?=
 =?us-ascii?Q?t48s8z0HhYsYOgW03wjrvFlerhIuMmuKIT9RqP+VHEG9im2DPVN8bpE9oOpP?=
 =?us-ascii?Q?ERlXf6aYS9LIAdE+nQOGTo+wmRoQKdaxS23TwRvuOffuqR3H+3Wae7+FB01A?=
 =?us-ascii?Q?NTScnRHVAXgVqC+BepmMBfcj1LLrzZmNR0oyGC0G6LNNWjVpK+J87hZKbCXa?=
 =?us-ascii?Q?m7IISI0+XuA4VKLKz76rWGBeyoEbccS4sR5ITTpvEMW+cBmu4xJ3KpCkqisA?=
 =?us-ascii?Q?KcR9hdEQfV7UELjQQUJLtIxiA4HVrl66ZUnI4DKZgOekPQZ9aDsziiUymu0y?=
 =?us-ascii?Q?xExAg28dG4NGCW/xlU6MKtqCacmI73ekg2ob5CIL6dGBnpRdGkkhVx7gggKI?=
 =?us-ascii?Q?5KyeUwpNKhlwq65heIJmBMm6tbin4hTGdAyaHrNxQ60mgQxAuW7VtHCalLw2?=
 =?us-ascii?Q?+kQ6otV8S9Hw/Dv+R8pTcjB+E+hOiXWXSmJupAWiVZD35BSgcuHaLdCPFGUZ?=
 =?us-ascii?Q?YwMVPKLlj7lf9pPvzxNwfbM2uSwyn5uGet8Oh2VyuRu6slepX+97piXGDMLH?=
 =?us-ascii?Q?vjNSoMVPTS3TNaIKECCDlUXb68lyUmGNP/FPeoT+K9Ub134OGvAR82BjRiBE?=
 =?us-ascii?Q?FpraDP/zIc7k1PgZ5tbvzuKq6smkA84Gdg/gcfjygy45MIABv31qRMdB59el?=
 =?us-ascii?Q?jQzeYiHwtDxeqA5UAkXyghP383mTb6pf40xYUENDHvhuqF6wvnhn18/OvjxC?=
 =?us-ascii?Q?vSjCeu0fL3ICmnIw++JK3f6VtumPcNf4ToPrXF2E8bCgtp0a?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6967CFB8595B782B4E14E1699D242SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72901f2-878c-490c-8b26-08de9955c4c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 12:11:18.5015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mk+dATzwAlAAdcK5awqyAtVjTpC6v+0/8ugC3QChdJRIo6kKl2Y2X98+o+/EvfEQr02LM4exX/O3DJJUbsZHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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

--_000_SJ0PR12MB6967CFB8595B782B4E14E1699D242SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ignore this patch,will send next one



Thanks,
Sun,Ce
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Ce Sun <=
cesun102@amd.com>
Sent: Monday, April 13, 2026 8:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/ras: remove update ECC status during hw_fini

VF has sent IDH_REQ_GPU_FINI_ACCESS to PF before hw_fini, PF stops
handling requests. Remove ECC status update to prevent mailbox
timeout and VF error.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 28f94b92716a..838eb91aef39 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -517,14 +517,9 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev=
)
                         (struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cm=
d;
         struct vram_blocks_ecc *blks_ecc =3D &virt_ras->blocks_ecc;

-       if (blks_ecc->shared_mem.cpu_addr) {
-               __set_cmd_auto_update(adev,
-                       RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-                       blks_ecc->shared_mem.gpa,
-                       blks_ecc->shared_mem.size, false);
-
+       if (blks_ecc->shared_mem.cpu_addr)
                 memset(blks_ecc->shared_mem.cpu_addr, 0, blks_ecc->shared_=
mem.size);
-       }
+
         memset(blks_ecc, 0, sizeof(*blks_ecc));

         return 0;
--
2.34.1


--_000_SJ0PR12MB6967CFB8595B782B4E14E1699D242SJ0PR12MB6967namp_
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
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Ignore this patch,will send next one</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sun,Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Ce Sun &lt;cesun102@amd.com&g=
t;<br>
<b>Sent:</b> Monday, April 13, 2026 8:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Sun, Ce(Overl=
ord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/ras: remove update ECC status during hw_fin=
i</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">VF has sent IDH_REQ_GPU_FINI_ACCESS to PF before h=
w_fini, PF stops<br>
handling requests. Remove ECC status update to prevent mailbox<br>
timeout and VF error.<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++-------<b=
r>
&nbsp;1 file changed, 2 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
index 28f94b92716a..838eb91aef39 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
@@ -517,14 +517,9 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (stru=
ct amdgpu_virt_ras_cmd *)ras_mgr-&gt;virt_ras_cmd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vram_blocks_ecc *bl=
ks_ecc =3D &amp;virt_ras-&gt;blocks_ecc;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (blks_ecc-&gt;shared_mem.cpu_addr)=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __set_cmd_auto_update(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_CMD__GET_ALL=
_BLOCK_ECC_STATUS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blks_ecc-&gt;sha=
red_mem.gpa,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blks_ecc-&gt;sha=
red_mem.size, false);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (blks_ecc-&gt;shared_mem.cpu_addr)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(blks_ecc-&gt;shared_mem.cpu_addr, 0, blks_ecc-=
&gt;shared_mem.size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(blks_ecc, 0, sizeof=
(*blks_ecc));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB6967CFB8595B782B4E14E1699D242SJ0PR12MB6967namp_--
