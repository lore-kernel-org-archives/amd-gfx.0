Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F34AEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F83610E091;
	Thu,  6 Jul 2023 13:50:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5920710E091
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzRxPu2oBpKLJaih2ZmRTT99RCcrsJ2F42q9iqQVq3UD8subqwM/ooT3lxLTBY+19xhutKyjAmDR5nFPQ3uinV8GT0kXBxEu48f1ULQzY4xRL5HKSYsCaQpFroNiOEwCTNfPfMG5EWqYI7mXSf4sNIKQMvRIikS9iSxDlxo+qsZIR9tknG1iTam0BA+74oZKPmtKWrvf7uRo1aPgQOQLma9jO9gWuMz4/d+nfGl0/M3BeUdKmaqsznOblW2IA8YRCR0vf1Kbsmfhagx5h1eOeA23rzv+glV413SrvtiMjx7ASYZfsrY/38UT1dVw1IUhv6jf/ih6RG7ZXTGqE1p3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok0kwGjH+Ohv3kgA8rOVEZFGj++9GXsyApkHAF2EuBc=;
 b=cQwbee3RDv/yOkr8UUxUYC0lYr7BRac0VsK41V88WQScibN9wZFSUB5uZcPrH54kI+hkDkKgTdovTg8d5xCsoUlyMxBSLt72gvQ8nvSx+DU9kLJHggN1WqG8JuSAjmnTvi0YDhitMdj9GoaOeljs+DBq7agGL/MuzI81KKePq8lPXXluCJu03/7xTGsf1ODPH8xU2QIzignKVDMTXyus66F/5CpuDsX8TDNP6WYha3hdbmuTfop5/hoeQBzKd09bK8giTSw0YspCRHVzUmi5fvDy0zHaj28cgqtSxvERT1E55WwMDt7DKbgQdmCSGb05ZfxDNKfbplO+/h/GUU+ibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok0kwGjH+Ohv3kgA8rOVEZFGj++9GXsyApkHAF2EuBc=;
 b=UGY0w5q5mUYtWp+UoHUVJFnWoVMC2IoNL1WupTDB5BJW+P9AFQ4sLXWjsxXU9tr52Qx0nHdtmBFh++KyloyTI9IYm6U2h1+claLYuz2YegHsHT/m7vH7ynCAnNp3UWcrh9dX+BFQCZDyWfvDb8t4wdtw8bMn3xe2MsySsVNthfI=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:50:46 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:50:46 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add dcdebugmask option to enable DPIA trace
Thread-Topic: [PATCH] drm/amdgpu: Add dcdebugmask option to enable DPIA trace
Thread-Index: AQHZr9ea0a9K09GbYEK4xAowFiXgMK+swdbr
Date: Thu, 6 Jul 2023 13:50:46 +0000
Message-ID: <CH0PR12MB528400C320FF35C2054F2EE88B2CA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230706070030.3970121-1-stylon.wang@amd.com>
In-Reply-To: <20230706070030.3970121-1-stylon.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-06T13:50:45.444Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SA1PR12MB8142:EE_
x-ms-office365-filtering-correlation-id: 692809ce-3452-499a-cb3c-08db7e27ffc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izSRIEq7BlFq2YG50Dh7Yb4/itrFh/cY3WimGtNieR60DW9+yb6Hv3Ff2lYJ94TQxNn6TwfEmKMwnNZFUTdTp5jzAeEIfp4iMsLMEHFwkAotXNoW/W2T3znyrh8XargKVjlrv+650Cq1IDqJpXfKLopEaRkieYmwhFu9KrhPs9wQEvPwZ4bssSo+cyOh2CfoNKWII0scaVwBjvZC6oDdPpQtQycK6yDHPLeuP4tQLadUiRyxsHyQ9Zc1efsxzxEdToi89hdkZoumEfLVUiHlpY+APQn338/aPmsr9DuzMLW1eNFGC0S8tYenIKqORRQxbirZn23kXQjPHyZ6Ap84qUW/+EyE75w17Lo4GCKuYK7XKvIS7SVayakRtFUbFhpIW7zaLXEnYU1CpoBVoOp6TpToIab1eeJ3ZGid4ykmXzCwvfz9BpJ/aPtpaqg+rnLb7c22EYGbZXfFFgwriE2WDx/hCUY/rEQuwsh1JV5FdhUGtQsHcqiO9N+M0sYb+bfbBn4uuIBuxz4k5vMTBeqpdb9667fJLdpg7Zu7rRBTGSrz30kc5Bc10CjPYuiC9EYc9GzV6PxDtQ5CYSR8lXtDskbrgeiar991LpOJzvbYGwqRfwM5d4xSRQyHIigGMWYM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(4326008)(186003)(478600001)(53546011)(19627405001)(26005)(9686003)(6506007)(86362001)(71200400001)(66476007)(110136005)(316002)(38100700002)(54906003)(7696005)(66556008)(76116006)(91956017)(64756008)(122000001)(66446008)(66946007)(52536014)(5660300002)(55016003)(8676002)(8936002)(38070700005)(41300700001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nq9kRqLhcn1pB2bSaAWchNcGeSg28MyuiPa2FPjTBv0PNbUa+dByLEUz5bGg?=
 =?us-ascii?Q?9UbV8QaVW5lBQxY9Oz/bAngsKQRe9PpxC/+o+Eo4bYIntnvdSICbV6o0/6Jl?=
 =?us-ascii?Q?eFBBFTOAyXEHZQcSdN0T6qFMheX+iumfyq90dHXQqK1pfEK6S3iyW4Gshsmy?=
 =?us-ascii?Q?8FmbNQjv3M56C40ayhB3P7ZTfDATfCED/srCT2EI0Rrv5VxjhOGSG5CJycW8?=
 =?us-ascii?Q?02S4uA69wILu0aZjrASPO26AKyWdOLACjnsRoXr108ZZVz5PWVrkTWkS8+Mj?=
 =?us-ascii?Q?IdIp0Uo3H4DIH1r60IaZb45rJs8WiS1YmCUg4iv49I+FOEluOebpFO1EFyjK?=
 =?us-ascii?Q?RKtNUGG2HlogYDn+RFE40TKorLSGurPHyZ24RiO62AtUfcTxAmYeNTJgdrz/?=
 =?us-ascii?Q?54zq53BnUYJZ0+SsfGaG5WI18vXTRkTYqIOMC7xbeQJmBTGkga1IOZdS/FGS?=
 =?us-ascii?Q?OLvrNwV/THeUapdjTWMd86GzEglA+ld5C85qDyISBjEYkCzBtPvUCMXfe77Z?=
 =?us-ascii?Q?XdVlL49qWcZGD3E4Uqtnn0D4qnHp5iWKLtIqzc9Uvtr6YwH0VQjbLmFHGbn2?=
 =?us-ascii?Q?aWzSMz4/RT8F3cqm2X+iPwVp72sKrMrJM2UqUwBQ8bh2YsoiVC6uLfmis0P3?=
 =?us-ascii?Q?tQHRGOOWxJLmw5PQn+FNTgrOPmMOEmTrY6veQXgGhGIXD+HCWjrIl80zn4Q+?=
 =?us-ascii?Q?atrKNZMLJ+Cmj8+ukPyT+3OR4MRLfiE1km37r1QX4Yy0TYgUIY1lgiWwfX/V?=
 =?us-ascii?Q?3EFcw9yYk5F1YeAUKVNV8kUFsdszqxZSILPH5o9MBjBAGVaPWdvTe0V8kJyP?=
 =?us-ascii?Q?s1IMFihGziuizK/woP97P40swneUbB4FxRAdiQSGrqsgN7kNt4a3SXSqmbhZ?=
 =?us-ascii?Q?tgMYgrejtMuT4rDQCX8+NyChicVD445hE35AHlNCubPTQIoOOeJROR+hDy5D?=
 =?us-ascii?Q?Gd8d/kt6egio+gypQeEChDnDWmLcIGYY8J1OgyK8NbU1xeQnq2sMz73VUZ75?=
 =?us-ascii?Q?Ym416/jadOk8/WXN3kzieZEwl5TDOWL2OFfEpkVJNeWUryIQ5Lp89HQpTAsD?=
 =?us-ascii?Q?dT9yV9zzGqUWd5RCth1Z3i0nFCxPeCWkyxLn1ngTQtS6B5rQ7ezDSK/r/U8R?=
 =?us-ascii?Q?fsQgq4VfIfK7EfvMl+TXdrzX7FeXqjALwZM/FI0JvduMSnrp9cDSSXZ3DyCY?=
 =?us-ascii?Q?ucZ7UGC4cKoyXgdPE1xO2FAQhosBIq1HEPD4KXg7xPILPH696yv4+Or5mf0L?=
 =?us-ascii?Q?X2baz1llmLrkWH7RqlEPuxHSS5JgT75qP9pjSqXn4YUAYEiQEfrWSqVIfFi1?=
 =?us-ascii?Q?tgBSujMvHCS9rWftko1oFEgr7rVd9MpEzL+H9f4iCraVZ9X4jdrQIAU4hwE2?=
 =?us-ascii?Q?LTsMJZMEOTCQKkLzDiYi0zpOtDAc1d/SOthkdQbpo55eQhpQjDPbbXzPx4t6?=
 =?us-ascii?Q?6QDd25b7rVmqa1ZSdzA1ilMbfhQoGilx9EIBsZJkBJwe80CDyxEiWQy6GqNp?=
 =?us-ascii?Q?s5w9Ao5HuESlBsa+ovblMAg/YxppA4GWhTxjOVOuukPtNXNt2B2g15TGI8FA?=
 =?us-ascii?Q?FO5CYcMHBEaaSY4TlHU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528400C320FF35C2054F2EE88B2CACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692809ce-3452-499a-cb3c-08db7e27ffc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 13:50:46.2327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47J2Zl0Iyrixu6Vfkj8kcfXrRacz98fsJ7Bk5ckCyT09ayYNyv+q/iPgU/rqChSHv7ZsvcUFL4kU/b1UkaTLTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB528400C320FF35C2054F2EE88B2CACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>
Sent: Thursday, July 6, 2023 3:00 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>
Subject: [PATCH] drm/amdgpu: Add dcdebugmask option to enable DPIA trace

[Why & How]
It's useful to be able to enable DPIA trace with dcdebugmask
option, especially to debug DPIA issues involved in transition
of system power states.

This patch adds an option to amdgpu.dcdebugmask to be picked up
by amdgpu DM to enable DPIA trace.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index f175e65b853a..abe829bbd54a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -250,6 +250,7 @@ enum DC_DEBUG_MASK {
         DC_DISABLE_PSR =3D 0x10,
         DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
         DC_DISABLE_MPO =3D 0x40,
+       DC_ENABLE_DPIA_TRACE =3D 0x80,
 };

 enum amd_dpm_forced_level;
--
2.40.1


--_000_CH0PR12MB528400C320FF35C2054F2EE88B2CACH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Chao-kai (Stylo=
n) &lt;Stylon.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 6, 2023 3:00 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wa=
yne &lt;Wayne.Lin@amd.com&gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.=
com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Kotarac, Pavle &lt;Pav=
le.Kotarac@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add dcdebugmask option to enable DPIA t=
race</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why &amp; How]<br>
It's useful to be able to enable DPIA trace with dcdebugmask<br>
option, especially to debug DPIA issues involved in transition<br>
of system power states.<br>
<br>
This patch adds an option to amdgpu.dcdebugmask to be picked up<br>
by amdgpu DM to enable DPIA trace.<br>
<br>
Signed-off-by: Stylon Wang &lt;stylon.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index f175e65b853a..abe829bbd54a 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -250,6 +250,7 @@ enum DC_DEBUG_MASK {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_PSR =3D 0x10,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SUBVP_MCLK_SWITCH=
 =3D 0x20,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_MPO =3D 0x40,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_DPIA_TRACE =3D 0x80,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum amd_dpm_forced_level;<br>
-- <br>
2.40.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528400C320FF35C2054F2EE88B2CACH0PR12MB5284namp_--
