Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40723ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 13:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D4310E0D1;
	Tue,  1 Nov 2022 13:29:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228DE10E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 13:29:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahOwkOZtQTx3joUGfl9UAwDmIGnfvO809XM+RIl/TmPZWZs8PWAUvsRFtzmvqcmOAEnqzfGvyK7tmW+QyFnnhIymI32l3+5qxoE73M3VWU0oE+qQRA6kWoT1YgJeibRG+fAI59mBHNrmU0S7YpC4SddLqOoVNm5MRiGWWQwqgT3bk2GR5sYOWAbFDjIkRWY4SkjYdbTGm/6q/QDnTmBv/8ysP+5oVwczEmhNuZJJ43cxiDIgO8W4opwOiqYr9jjVNZ03QcDZNSKH2RIbWCZc4ZRI6Wa/E/I9pPa5AlW8jFWIVdhcXnxJKlCjNpEgiXv4D7Wj5db5Mx1GEQuSXpnmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2olgsRWWgnOGaiuySO5MYdm3KZ4q0PrC/bjn+9Xioo=;
 b=lthvYl+BarAmxwbpCGtj8ptQVyZn/dCCYbzoSBSM42Fie27oYtQkMcmKxN10EboEKdCnRpib9lRJ/bslPPOlqTp/QiLTAtly/1Df/VZ54oHYgmartR1dqTpsniuRdmQ0fbXRJN4yLixmNnI6JZ9ANTz24RklKhUQb8DuOZI3NXIsLY0v4+cmen6BK7zn6Fb8BAhO49RjqVEAim3Fn1wxs2XGOysT5OgZgjtCGfoTrxUGt+jqncje3bZLWefSdt47Ertv+BfDrq0OL9GduH6+/OL+BEAq5e2zjLFaaD09rlLmKj/zaYakmVJzxQ9yke4QaWIJyyv6H/GI8YfbGLBIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2olgsRWWgnOGaiuySO5MYdm3KZ4q0PrC/bjn+9Xioo=;
 b=nhDlzap7vjiZvnGUki7UBMNffNwhvgnILPGZZINu2ko1OYQOSDmsvB5JyZ/E7jsrnCwuM8gZyb39dvHHBwq70Lb7icUT1L9PKJ9rlPvxT6DKH1wIybB9dkXLiwlaNJ7KUFjjogKeyAGkJM5H9TnSncVRSKJdkZNAaCGOh+xctYw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 13:29:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 13:29:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Remove unnecessary register program in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Remove unnecessary register program in SRIOV
Thread-Index: AQHY7ZOufcaXrEwfBUeMnMKBaJ2RUq4qEJLz
Date: Tue, 1 Nov 2022 13:29:00 +0000
Message-ID: <BL1PR12MB5144D7DD702655EFAAE38079F7369@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221101014529.8842-1-PengJu.Zhou@amd.com>
In-Reply-To: <20221101014529.8842-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-01T13:28:59.696Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5341:EE_
x-ms-office365-filtering-correlation-id: 0eb41cf8-1604-4fe8-c156-08dabc0d097c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bpQP7WfMV0ugsivPSghSMQzn5Z1C+KppMbLvCJDEl7vJNJiZjkPu4ANE/f/wjwrR4Cx2V1iy/nvATk/KEGB/buzhkIHTM7SGur30qCxEaKCH/+NAn1Fs1SYupDl9/9BbslTm4HBt/cZeetQkvfNO386FoHPLXrRETkC63GSO1JcYYbgxE2loTymtVyLZ/knmSYe6Z3YAibI75fPPVFhgnT+2ygD5kXw7BcqAy/2H26MVA/10MJO/ZcuB+WQ07QXKsBJnUqWVEIyA5JH/Um/fAyopkh3PLOYfOMnNCsWV/rU9YaBftrV7tauXe/4TXtVskRReY0ZHNAgzAQ3OAM8pucoPfkaFA1P0aaesiYq2DfDQP1xOZF/MNNmSvr7ldtiKTyk3h9gY9pRNEIV+tbRZbaUtDuNwLdOrFpV916vtHGEf2a/fNpd2x1KbBc0wfVWBI69y16YsU2rK88TbMHB4outNw95r5nFqi1sokdtlnEK8GZsql+aLtlyon1ir1KGqdUxQmX8EWJcL/LVmIShOexJQFHo4vbjzbHPTsn1wgS23H+q2PKWTSKXT87rIqC8ntRn063MpmhEkMJZ9R6X6uqNz3q23g6ukynQGGA7CKuhBlqnB2XUxhaVaCB6ClpOItB1XiXD3CMsLD2fs/cTmEbFPZcvPlOS3dOYpwL4qct5vSil7qlQi2N4qO4dotdyzmsFOqVY30TbSTg6vRy4b9VgAqQ0J6iQj2Qmd+sQxDePgQTuy5Brv5AQJC/utkq7RHgU25rtnLQFPSNGTdInI4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(186003)(9686003)(53546011)(7696005)(66556008)(6506007)(26005)(478600001)(2906002)(55016003)(64756008)(316002)(66446008)(8936002)(66476007)(8676002)(71200400001)(52536014)(110136005)(5660300002)(66946007)(76116006)(41300700001)(33656002)(86362001)(38100700002)(122000001)(38070700005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PGyTcJvkZaVjDQo8O6RLgWZSem9MAelOlbkk7m1voBdBE47kWC5kpVbgK33t?=
 =?us-ascii?Q?ZFtPm1IMCwx4uOMZly9LTRkkDVFSqKDDcBoCT0MrlrYgzO9oZKWzRvEpZliV?=
 =?us-ascii?Q?qdCqOnQtQrAzqvYKkyj+bU6pchnwJf3svItnuoXb1OSwW2gvxgmIWWxn5viD?=
 =?us-ascii?Q?hoddf/TakZdjA+ZjFuYnjYsrvHFlFX2qB5RE5jIGsMHqCD4vkdrvDPRk0L8M?=
 =?us-ascii?Q?nOFsypTP1gzYyFFOM8GWZp5Fu8dFDS81IVl3F7nWzFbbpUic19THXMT4zVQg?=
 =?us-ascii?Q?wHRg1aXJehmXylnOtvX80PBLI/t0wCGcdCzbPrXBmstXjiOh6cAQnrlNqwF8?=
 =?us-ascii?Q?iREAtpT3jDOefUBV2973vWWsLQ91hSN3jqgp2Xi9wDccs4/vGj1hCqCHHyOo?=
 =?us-ascii?Q?SO/V1+0bAog5xRmIgHrwS3qq/d14jznB46MTqP3z5bn29vOUwY1e1SQakGPo?=
 =?us-ascii?Q?GBFE1Zi0gDkyes/3gHpk2y4nB5+e+K0RZ9GpGhk0DL6DbrRl8vXhk7a2jgKg?=
 =?us-ascii?Q?MdDlkmnHJU0H0VWohrvLXftGD93ng+I6qTCn7z0mvZG9I1njgtofeHC3sHN2?=
 =?us-ascii?Q?dodX/1Bve8Blgu3rv7JhsUo3CweVSM93lGXUaDaOEr8Zes3oj0MBZpPNKFzd?=
 =?us-ascii?Q?Ua/ALzS2OeltJG/cZr/6HGl7OA2xuOyhH9lZ7x1fIisCSGUvc4ZZiANSV+EW?=
 =?us-ascii?Q?FRa9zsxy9pSW5eLpy4ACzVp8RmvWWhwP+JqpjCIU2kINQMEqGIlV3wVDuhaR?=
 =?us-ascii?Q?jpUfU8WCjrbeW99P7UBuD5lFTM+M7JveZV+mtAw2IlkA4P5qDV65YxSvGGfu?=
 =?us-ascii?Q?n4OxohLcsjPysU3PfEhQ38UXb/FnEzEgqnDqaxiD6+3NbSpXoL+TEMjcpcZG?=
 =?us-ascii?Q?FBUSiemYO6aJ6jeWm7SRWLUfk2qHyCVAb89Lb6rJpBOXjtI7PeFrW6EvmBEf?=
 =?us-ascii?Q?zprvGimYx5BR0xCYxlvHANSSRrtJqEr9ePBhpGigYtimp9InaCdskd54FnS3?=
 =?us-ascii?Q?0dkaGxxE/0aOtxgXbG2LuW/AXSHFeauQ1HDccTpiYQNk0sXEn3XPF+swMhqs?=
 =?us-ascii?Q?4lBkB8LzoRrbICubIGj7i1OcxitRrJvxIy0pMix5eKjeGIWbtOLmMl+wVxl2?=
 =?us-ascii?Q?isRPkPmIgCXZOj6Q0Hzw2dYM+1NCRaMNlLvx/2jclUs/lYd3OZgV6OR7gLU7?=
 =?us-ascii?Q?ffgoGhQqCZIrsIBK0xUg8ReqcB3C7NTdc0l8ZsfRt91sbxX55iSl1nQrRZBs?=
 =?us-ascii?Q?5B4ytPO5jk0Mmflf2Ba0ZZMjb0I8Wx5RbzEY6IMmYBP54Oi7qdezt4uexOTx?=
 =?us-ascii?Q?tztQLNZZHsN3czuiLQZ+3N7hE44N4SDHCrRn6YkLMy1bXPd6P7tmA9mkrZag?=
 =?us-ascii?Q?X5I5v8Ul5SgcKyYmhIXQon6Z+FvUOwRSmooUjrnXlVv5SkuJGifxI8z3V51E?=
 =?us-ascii?Q?xxfZmZ2UAbpTdgndLZRxpgW1gljA/enrt7stei5F4t33WCJWPFarxUONI1R/?=
 =?us-ascii?Q?F20iqoeJE5JKR/ETefU3w75OtJgZa3kTUDpadtSYjRKfw5kOjnqNvhvi4cgY?=
 =?us-ascii?Q?SNvple/vLQVP83UnLW0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D7DD702655EFAAE38079F7369BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb41cf8-1604-4fe8-c156-08dabc0d097c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 13:29:00.5645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DDJ103wLoQQAi4Ld0WeN/RxQAFxJCGvldwUa8x5R9U7A1pwtYZIQhYxnvg5Tnd50ZC1pzahAXZ5raE8gUHdeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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

--_000_BL1PR12MB5144D7DD702655EFAAE38079F7369BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Peng Ju =
Zhou <PengJu.Zhou@amd.com>
Sent: Monday, October 31, 2022 9:45 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove unnecessary register program in SRIOV

Remove unnecessary register program in SRIOV

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c
index ff738e9725ee..6aa02d835ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -395,6 +395,9 @@ static void gfxhub_v2_1_gart_disable(struct amdgpu_devi=
ce *adev)
                             ENABLE_ADVANCED_DRIVER_MODEL, 0);
         WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, tmp);

+       if (amdgpu_sriov_vf(adev))
+               return;
+
         /* Setup L2 cache */
         WREG32_FIELD15(GC, 0, GCVM_L2_CNTL, ENABLE_L2_CACHE, 0);
         WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL3, 0);
--
2.33.1


--_000_BL1PR12MB5144D7DD702655EFAAE38079F7369BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Peng Ju Zhou &lt;PengJu.Zhou@=
amd.com&gt;<br>
<b>Sent:</b> Monday, October 31, 2022 9:45 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Remove unnecessary register program in =
SRIOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove unnecessary register program in SRIOV<br>
<br>
Signed-off-by: Peng Ju Zhou &lt;PengJu.Zhou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c<br>
index ff738e9725ee..6aa02d835ecb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
@@ -395,6 +395,9 @@ static void gfxhub_v2_1_gart_disable(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ENABLE_ADVANCED_DRIVER_MODEL, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCMC=
_VM_MX_L1_TLB_CNTL, tmp);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup L2 cache */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(GC, 0, GCVM=
_L2_CNTL, ENABLE_L2_CACHE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGCVM=
_L2_CNTL3, 0);<br>
-- <br>
2.33.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D7DD702655EFAAE38079F7369BL1PR12MB5144namp_--
