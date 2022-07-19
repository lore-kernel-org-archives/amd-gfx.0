Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055A1C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 14:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B286A11AB53;
	Tue, 19 Jul 2022 14:41:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ED5114BA38
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 14:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnay7vSxOoNmTP2dV0300VNoT1ihgMYvLadl1dJZ6Ml2njoeYWSdG40Nd3jthNbbPs4+aakcqtort3T0oqMo+aJhp17Z6UC4V9EXCkCd2g4W6givkkphmAq5e87PXLd3+0SvscihSiwkvQ6aybI4RLaKWUuO3XNMwT+OyOZRi/AIxawnLroQGj1qmgxgVuqnnj1yURSHjdTLgdXI3KxLpX/1OQQFTQo2/Q7W/8g2EKb8zNI9Me76OCmtVQYaDlUA+qJi7yRP57CISzR7RrrgKUhbxkVyq0UMGRsHohVdH7K5kgakyhMTSgKqEMFB+Tsr+BFfy5e8ZvZ+gPYP6OiG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXLnzZ4dki94XsPJiSOgCOQ8euQFz/RxYfn6PTrY9pY=;
 b=Ojwub0yNuqUeGp2PGE4oATf/fq6lqGNh+5ZC13bVsJAWTwyRtUdfQ5ASc0+bT+6m+03Ci9V+hyuQP1LQIYgRPni/fIu1DoznFPPZ0u3eWUgXkeBUnll+XHwFgP3HvVVhRTgaiLI4WGVQYrFtxDPFHSDrBs2WN18356sxtPwoKLvZ3B2Dh/72R1vR2cBrbJe48cnoDUByeB5jGjt6gPxMZO55ZR6ABzLG1SfGoEfEt64egLVaCWITT44+KfPzMT0mnrpv/TpZL3XqRSbrlRwBrNA7XeaGcmj1zDRH9oBrockMqtTdeBSV4LTytadDUFtHnuGOhpP4meuxi/7PGP/93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXLnzZ4dki94XsPJiSOgCOQ8euQFz/RxYfn6PTrY9pY=;
 b=VwYzgQhZEZQIKNfhXgRxwti85RvIdul1CRKeCwdfUndBuHVdDXeAQ53RhUhuXgLb6b91zwPCwo8VyPnBp2FIHkIpvrUbtrqGQjTJHxLEKjPwkcJOHGMREjc6A4nTzBp4u8UyXS0fMl/kShTYpkKJmuXzqH3cv2OPzocCCU22o9M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 14:41:12 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::4929:3644:b9ee:8554]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::4929:3644:b9ee:8554%8]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 14:41:12 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7
Thread-Index: AQHYm3Hyi78/N/cIaUi/Mq4iBMVBZa2FxDCV
Date: Tue, 19 Jul 2022 14:41:12 +0000
Message-ID: <PH7PR12MB5997681E18E1DCD731F0E240828F9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20220719131736.133958-1-kenneth.feng@amd.com>
In-Reply-To: <20220719131736.133958-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-19T14:41:13.245Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c1b7f65-b5e2-465e-5376-08da6994ba25
x-ms-traffictypediagnostic: BL0PR12MB4914:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXZSorZfn3NpwjFc2WFCZ7KbNzGz+Xs1a9e0CU5v8vv90BvWm0Um7zionCJZe3nbAf6sAW/qTMlUrDAXlqdph+UgPqwpVAPyNzLf8yykhLFXZSDeMy7tHep0LvBZdKKWq71Wawsl9JK/lVCsE20cjtBFJSowJ7ZdmZNhQoH/upj6RzF1k1CUxujPznV4IUVmgSF3eTCTec/Vwj7/Mjw/LnKywsX55x9EoMxrQdRsfj+dapPz+D6hoIa/uOENinZYd52YQGOX91mld2gsfTD4JP0W1OnoUz+NvWiI30OUWfjroZ8KeBAeFack1kVKoEAgk5mkHNh8TykG2MPAMQJ94vOyXVuiD0aNv6EvMt5NaWJbnKUEnapDkI5J0p/VaRzhDbV+3mDy8E4ZXSColLHcunf/oK47rS2vMXWiaP31wAvffePKnbcriIzo6kPxjbeRab/jWW8EwhL2NmGC2C1WY7gCdqTaL6+PwUrgeznzUyV4Fc8D5kbnZJvFC3yVgPy5rkqO/VD7EBU/njWhq3zZvjV+NqtqggSPxs3H2KOLrePoaGpY8M3E2T+akz/fV7oi+U2a6YLrwEhj9fr1F99HVou/sQ0woV9u3veNr0qeHVmWxm+fsbiWSmjsc1iRAZjfbxwwSg0zr9vOG4d13oFQj48zO95mYhV9cosiyrylLooRYws0wxbfMsCV8Fm/q4xshmSzN6+NYdcdiPm0HVuVEQ+vEY4rPKdz0to5UJuiVlUutklpq3uTWcgz+n6Jy+ehbdapa3pMZZsUFO274evFaLrEn/42KX5rc5DE9Yxa1pBdmfntCBGvKnFG7hlZZFjY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(53546011)(66446008)(55016003)(91956017)(8676002)(64756008)(66476007)(66946007)(52536014)(86362001)(38100700002)(186003)(5660300002)(66556008)(76116006)(8936002)(478600001)(33656002)(110136005)(41300700001)(7696005)(122000001)(316002)(9686003)(71200400001)(26005)(2906002)(38070700005)(19627405001)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NmXLJYqxBaf5YUP2qDLH3EImcxdeYv4g6OFHpqMJEvtxv1HcKuaOVAa9aH3/?=
 =?us-ascii?Q?H3bKIHL6JsXJ2pHH0qaBDyrNzWEcR/EuPP8pTZQtur4d8b/iCWOFt6rgHlj/?=
 =?us-ascii?Q?0Stv0X1RlUCpwU802vrixB6xwvSybRcPTudtXBtVRmxXKAclahKHlMZzN+nj?=
 =?us-ascii?Q?E4GuTdWwiLvY350KJEWGTfztPiTK1hrkv+wjoJflu9OahIzbueIn9+g5pUz2?=
 =?us-ascii?Q?iQRP/3YJLEtjq75aMq0H4CtxkPf9fzzzYxc4zmVrR4TxOmYrazx4IKz9l3Bz?=
 =?us-ascii?Q?otqWxACsdFYv+hHQr+R0Faeut9G1lxUuO3Fe0Wxlkqcql7GCXlKvAXCVPhFb?=
 =?us-ascii?Q?9uip6sqDqHLVDmlAgE9lsRFNrzUi3tMo4vA9DTYRCG3ab8UlPQ7OKFXmP2Y6?=
 =?us-ascii?Q?oILm/i7vB8izeZZSOhnqVA71lfNs/CZkfPpHDhWFFn7UQbVaquq3i0E5uvYK?=
 =?us-ascii?Q?MnaKtRiv/zrkFLySxPRxLr3q+7EQFZ8ZJTspLBNUxGw/Gek6N7OMiT5fiz5C?=
 =?us-ascii?Q?D+vh0JdUByeA51iEIovOFxGs0dEyP4x9kQfQGNsRzKDj0fFtonEqw+dGGhCE?=
 =?us-ascii?Q?BjQ+EVgfIRv/Bo5C3akLQXHmA0n5aJTcwMwE9v5koEbsvFX8QXq+jbqAv293?=
 =?us-ascii?Q?lgLEjsKl572yX0APsHoyptlM8AZdYWlqKx+XbVOSCQXXtVooabC5Bglifxqn?=
 =?us-ascii?Q?GSW1TYpS2pmfwvq/b9DiQsAvlTyEQXWEDK+bwdSelORv7Uj29/CHPy8fiFaD?=
 =?us-ascii?Q?gNzKJm5fcoprKjtYodZ4fOM4Auc4Fj3AMithDnDD7Sg94/OJriSit5jGJf44?=
 =?us-ascii?Q?UhNUNgnYb4gR6BPT70k0+RW/1z7s4qyiTrshZwnnDDdhWLzgpNeauDGJPm/l?=
 =?us-ascii?Q?tHjPqGm6GG0jlJ4iuKGL4SAgyrX5ouQqWMNOMVpq1kUFNM+ClUWgEknx7Hvv?=
 =?us-ascii?Q?ltwa++ISQE+McQy8YBa9G1oTpPAkbu+8LnBZUtzvIHh9Exgkbz0iA8YzBwmV?=
 =?us-ascii?Q?SZOHVi0O5rLhVp+aIJqZ0r/71HCGuBTPzIUCEhTmbUu5/VjvnLEGV8DaaI9n?=
 =?us-ascii?Q?BthCNa9t9qiFrNM6itXTueNYUVKnzH57/OnqWsAkwGPkesx6stLs/lqhicH0?=
 =?us-ascii?Q?hL/6hdY+9wxaynmzalAJ5Xir3q/b0E2DctmSop1U6DbXRlYvZsAg9NgMNqP7?=
 =?us-ascii?Q?7VykqRs9M70jEKAiIhEqZiPWfLFP8O9V+wBSnFYYHu6a+HK5JRmDAe5eE1Gx?=
 =?us-ascii?Q?ppaNjJlnujslxw2D8VMZA0VnJCu03JrA2HGWq5YDL5vEBAvrdw5ysSf+21xg?=
 =?us-ascii?Q?Pl9diMfnPU90Mof2XIZ8mN+O78rRFdQVFFrRSR6mfnOvA8LoMymq0LOPCldu?=
 =?us-ascii?Q?254d4kTsbeYS4RgRin6h+15X7t1IRyYZLlOoTx7zizprJgZeZTKBEqbkZd2o?=
 =?us-ascii?Q?x0t2lQWyifw6BqvCLVs9HaIksaF/L7pgglPO6f79nGQzetBNVL4HBDTeagRs?=
 =?us-ascii?Q?veE2DWmf9M8PHe8yCyKzq9Q4VgS7prbolwW0Td4si4dTDvD/RakH8WBjJgK4?=
 =?us-ascii?Q?FJAXdtKFp6AxUIL/hOU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB5997681E18E1DCD731F0E240828F9PH7PR12MB5997namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1b7f65-b5e2-465e-5376-08da6994ba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 14:41:12.4962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ndFjxQ5KavNuaDnatAnZDX6zIOIBsd4A0+pnfQZ3TES236+DRsVn7JFLOsR7kXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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

--_000_PH7PR12MB5997681E18E1DCD731F0E240828F9PH7PR12MB5997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kenneth =
Feng <kenneth.feng@amd.com>
Sent: Tuesday, July 19, 2022 9:17 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7

enable gfx ulv and gpo on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 6f0548714566..16eea2de8a2d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -251,6 +251,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context=
 *smu,
         if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_GF=
XCLK_BIT);
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_GFX_IM=
U_BIT);
+               *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_GFX=
_POWER_OPTIMIZER_BIT);
         }

         if (adev->pm.pp_feature & PP_GFXOFF_MASK)
@@ -271,6 +272,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context=
 *smu,
         if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DS_GFX=
CLK_BIT);

+       if (adev->pm.pp_feature & PP_ULV_MASK)
+               *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_GFX_ULV=
_BIT);
+
         *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DS_LCLK_BIT);
         *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT=
);
         *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_MM_DPM_BIT);
--
2.25.1


--_000_PH7PR12MB5997681E18E1DCD731F0E240828F9PH7PR12MB5997namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Yang Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kenneth Feng &lt;kenneth.feng=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, July 19, 2022 9:17 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: enable gfx ulv and gpo on smu_v13_0_7</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">enable gfx ulv and gpo on smu_v13_0_7<br>
<br>
Signed-off-by: Kenneth Feng &lt;kenneth.feng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 6f0548714566..16eea2de8a2d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -251,6 +251,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature=
 &amp; PP_SCLK_DPM_MASK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_D=
PM_GFXCLK_BIT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_G=
FX_IMU_BIT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_GFX_POWE=
R_OPTIMIZER_BIT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature=
 &amp; PP_GFXOFF_MASK)<br>
@@ -271,6 +272,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature=
 &amp; PP_SCLK_DEEP_SLEEP_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_D=
S_GFXCLK_BIT);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature &amp; PP_U=
LV_MASK)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_GFX_ULV_BIT)=
;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask =
|=3D FEATURE_MASK(FEATURE_DS_LCLK_BIT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask =
|=3D FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask =
|=3D FEATURE_MASK(FEATURE_MM_DPM_BIT);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB5997681E18E1DCD731F0E240828F9PH7PR12MB5997namp_--
