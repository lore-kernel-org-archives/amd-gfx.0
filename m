Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333A0C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 18:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6E9112154;
	Fri, 10 Jun 2022 18:44:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E282112154
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 18:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOVuznyk+QI3yPwjrQSQ/3/3wlFwUSFrrqypaKuVrYpgtQtPVqSyrWMrl9B0S3qYFeBtsRjbsHh4b3lNTbdkPKN7EBuNDSzc0Nnpr4QVwZqKGZPT1fpQSf6EGWgpR4msMid1SAouXOeCMsm2SdYvmv3Z2jPF3Y/jV/a74t/qjqBKwaw+IwQp+kWv5Bck+ifCs8YQli0mYmBDjVDBqh2LejJeht6eXI2Wt6oq6OLdFf/r99lmZa3t12lKxYlWq+3gwnMH994SM0A454iggs7bkj9m+Rv5XMRhYbz8iuq/82z4PHDcVTtiCiriVyvdApQzEuiCa+pgzk2pt8zI/rwh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/meOLqpBFk1qmBw/nyBzXotXdtUYMg9RcZYHamcvXk=;
 b=a7QAazMSEsf9z8+X22LNxtcFhph8kM7fQEjJkHJCJcQ/ZOdTwxiFXwJApOzhRD+tgKesPqYxY22Rry3+29gS75xIsQbePslQ9aPnep3KES1BC5VWM+pDsEXnV1kRBbR9GshLBfkzxc442/GudPiY9v3KllNoXz4JhD3ThobfzDc6/a7us2pzeTq9lhgrZeH57oytak76+cismH6yw4gvrOqB9CbSVBOf8eGuzxffkcwqqmXdFczz/MxHcoX6t03v33Q5wa1taRzNsFxmlLqICAfuFE7kmBr93prSgqALsESbqtyz2t5+RGP7MlNpeeJZ30r2mgXmYiDBpBCzxtlpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/meOLqpBFk1qmBw/nyBzXotXdtUYMg9RcZYHamcvXk=;
 b=O7vM44u3xUxs86GjbCt8zXQakFTbtEQbm9Nm/E1fesISosLu1/Hox5OlxObKk9RcpLqQ3XiMJXQzaZpr0e9Ug9lfGFNheJaA+/myS5+c788iB9r2zgx0xRKFkGmEsn9DBZjX+QQJkP4TTz0D+3JSH9P5QnB7+BAlmlA7QaplSeM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 18:44:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 18:44:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: dml: move some variables to heap
Thread-Topic: [PATCH] drm/amd/display: dml: move some variables to heap
Thread-Index: AQHYfO8yE/Eppr3HXkCVhsHqweCYiK1I+j3Y
Date: Fri, 10 Jun 2022 18:44:19 +0000
Message-ID: <BL1PR12MB51440F3E4EA2D40E9338BBA4F7A69@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220610172603.529561-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220610172603.529561-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-10T18:44:19.017Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8fcb4bd-d9e9-46f5-0121-08da4b113a93
x-ms-traffictypediagnostic: MWHPR12MB1549:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1549ABFE565078B88EE811E8F7A69@MWHPR12MB1549.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYaY86LZE928ltdJHz9ddzhQgK7hR33+zlaL9dOIPSLFG9jlYgUPsFZsZoCY4fejO2wcZuGnTtN7DEJto0EfF9YSStSrtrJ0eFRnct/kExzSnqwSOvmHGCd0pGisqarRpFFNvNkNaRfbPShkjHzuYRSZPsOCeXkL5p15zP6Prs0wMHXg8Sf+LVVJEYh6zQf0Rkkb9nRwich0S8cuZuOmO8tUCQqIh/KpzYGsNYejtKkLEvauq9ogo/xhFAtgcG1dW+ulbfVptJNzAwSji8a97SrcH36/mrGGLoYiyVyuoRp7dNXaBn6CVgX//alrmGjXuNG9mItukeAObIdO511CJcyVdUqQT9G2wTZm0O/theC64LtXJQZ9Atr7w4w+ZUriGQtKXFRciYSebiWb/24YvCY+25fccUYcWEzCSHbKMoeGKS5m0Bd0ZavYivEG/DI1gztLGeITc5L5EGMclaxR5T15YXkSkYKVeWKRJM7MONt3uhZ16J3PkFbvUK153g27RqqYa+r1dhjeRH1SYBKKhnJNgtfomj/qmptKL6l4A/GkcxxXeAN0ZEIcwYBbVwtYizRCjxKxwd5vhcmrLn8M71Y8m9jLV+uewj5gLf4pWBlQH7gQJ0QcQgF3/LlKkTfL/cImVjbm78KGh2NIv48r36YxwSB5RuGcTyF5mG7YZb6zIB27jpyPbRFeNBKjH2sLQWIq3Cgi9D8xuOozm+P9WQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230015)(4636009)(366004)(2906002)(55016003)(38070700005)(86362001)(26005)(19627405001)(38100700002)(122000001)(53546011)(9686003)(33656002)(316002)(83380400001)(19627235002)(7696005)(71200400001)(6506007)(8936002)(54906003)(64756008)(66446008)(110136005)(4326008)(76116006)(66476007)(8676002)(508600001)(66946007)(5660300002)(66556008)(52536014)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?30fhXkOF50kkZ5a5ueMFRJJaxVolPWZQpxmXCPES5iWwo9JatBhE3SANIM+R?=
 =?us-ascii?Q?XY7liKiJLavLclDKw9jYNHn3Wh3DVLoU2Qn16bk0pGQF3a9QP8yBJ1loPwpi?=
 =?us-ascii?Q?Gmiedt2U4CpR9B+cmAS04pY49sLVookRenOP3sYwmxGwpboTFHfLtG6eSM1z?=
 =?us-ascii?Q?2phFFzhyrx/JzH/dMTd6/obUDmx5yTOdQAXlZkanN9YgwAZltMUqscQlHomc?=
 =?us-ascii?Q?9tH3Duj/ku3rvs56kDB+seMW2g84ceTIlDtMljLXHR/MHQ563llK8gkuD1fK?=
 =?us-ascii?Q?iHjHSDR3iP3IVvJmhYqTVHcmsGE96VhTCOiesW1BG9bMi/41AwdK+gkx1EYC?=
 =?us-ascii?Q?ttZTpm1pLx7S2ddVrfdgAbAOkpZw9BdpHDRp33hVP4rRKchFVivELA++O3JW?=
 =?us-ascii?Q?Q+5j+clHWK153MuyNqV8yy4TsNU8Va4/o9+gO0bAZcwIkGLNCAGAyXpiVZMb?=
 =?us-ascii?Q?j/pBc27d51nyaMNsyTqNmpkdiJ3CQzBXiKMivhx7JXPyPtMQxIXVoFZmMQP2?=
 =?us-ascii?Q?HnjuxtPRXhEpnv9BxSiv+K726VoN7ZI05SOSSYwU0BdpUzzAJMADSV+j6fHX?=
 =?us-ascii?Q?CvpTiwAzgKF7ij6opqtmQ7zZnuD3AqSe8i7HupdesZpI5fbMIozE0QHkc/mM?=
 =?us-ascii?Q?QNdBn8uqB7GP5mS6hWGrplKt45DBPmLJOaEyCR2UszrYfZ0Vmdi5Wq1PYAXv?=
 =?us-ascii?Q?wQqxIDAEcFK6/EF/P+VuWnbXcrJMmDvncWMSCJ4IdjhJhAlpWAiCzIgxL3Xy?=
 =?us-ascii?Q?HxALIOsMWAygWZkGp+aA+rfHfZKEfwSJTwZ6EzoQbRAJKF13F+/dl9DYN+Lj?=
 =?us-ascii?Q?y4j5Ld+wxaYgIFp7fYefcSvygxh1ShN0pTqoS1applHNMXmT7ZApI4rK8rbo?=
 =?us-ascii?Q?7a5L4uVPMIEINwNuuw3lrdjLl9t4lnJ+ONcU/VySwqPwV9plhjnCdyAw7d/A?=
 =?us-ascii?Q?F/tNrFXwrDUOHc0s4gqQ1gCQvoHUN3OQNQY0R4Tj3cvLYRPYBDrQFs4pyPd1?=
 =?us-ascii?Q?uqw5wGapnfbF3c03xdjA0t92cHBqhNTqjdpBUB1WHoD7shFcyw9ZWCwuLaub?=
 =?us-ascii?Q?WXL4wLidVt0h1r+/x9Fnct/wjOc5c/f0gbPiuCKUjv3lSU0pr940AOVTPQlF?=
 =?us-ascii?Q?im/PXzY+ztr1I/xy77YFjP8aEBkOnVaVLPawiapnUE5FHOKBQsiGUCEZTclu?=
 =?us-ascii?Q?RrRtNlE0INSPepk2zuLRlUpGAL83hGLQpQqlMLquP9T3sRLaDuUehoAqPLXb?=
 =?us-ascii?Q?qAPsx3l0EwZOBr7hrW0j3LfrGB0DPsUULmd/8i567rGPqRiM6xendeJUIkeA?=
 =?us-ascii?Q?TBMzunY86/Jy5pYd79Lz4qW8VcswbXYqU4+6ZRjAace8E0eGjlZDzSMY701u?=
 =?us-ascii?Q?LYmbPlv1ViYIx+gRPkPV9K3hxRKAaBKwo/ypPkZBrSCvfKpMx90p8E2k6W2I?=
 =?us-ascii?Q?x/wm88UT56VF1bcLo+zOJngdsj07AmHHKPPdRqZiTLLQwqxoQ16oXCMJ+U3u?=
 =?us-ascii?Q?ihPaeZfS7hSVy59j+HJ3TVxEIZAJiu5YEccGthvJpJRv1RWeqN5GtUwVH9lv?=
 =?us-ascii?Q?ie7ZIsTixUI8D8vl5dUjcSybQaDKMQP6Imc+M92HXyM8UL9KG1R09l8zBmNs?=
 =?us-ascii?Q?L1U5d68MoOW+13TMs2mTJmRZ+CM5WVzq6xWJ0oFeyOte/KIZd+ksPiuFbnQD?=
 =?us-ascii?Q?lajkMDn2gV7F+LuF1/qPcf1Zv5dcsj6Wp8GfbTBwB2Is1OPYhtoHZB2NANBi?=
 =?us-ascii?Q?SECKwjXtpw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440F3E4EA2D40E9338BBA4F7A69BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fcb4bd-d9e9-46f5-0121-08da4b113a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 18:44:19.4961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZXmb3f8DvG0kxMjIxY/rY8ohhoM9jAAQZe5ge+PPRkTW92W9cDsr7sVXrYdPtmsJc59zKTb23eeqq/xiCrqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440F3E4EA2D40E9338BBA4F7A69BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: Friday, June 10, 2022 1:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Wentland, Harry <Harry.We=
ntland@amd.com>
Subject: [PATCH] drm/amd/display: dml: move some variables to heap

[Why&How]
To reduce stack usage, move some variables into heap in the DML function
dml32_ModeSupportAndSystemConfigurationFull()

Fixes: d03037269bf2d ("drm/amd/display: DML changes for DCN32/321")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../display/dc/dml/dcn32/display_mode_vba_32.c  | 17 +++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h   |  3 +++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 5828e60f291d..b9f5bfa67791 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1675,9 +1675,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l
         bool FullFrameMALLPStateMethod;
         bool SubViewportMALLPStateMethod;
         bool PhantomPipeMALLPStateMethod;
-       double MaxTotalVActiveRDBandwidth;
-       double DSTYAfterScaler[DC__NUM_DPP__MAX];
-       double DSTXAfterScaler[DC__NUM_DPP__MAX];
         unsigned int MaximumMPCCombine;

 #ifdef __DML_VBA_DEBUG__
@@ -3095,10 +3092,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(st=
ruct display_mode_lib *mode_l
         }

         //Vertical Active BW support check
-       MaxTotalVActiveRDBandwidth =3D 0;
+       v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalV=
ActiveRDBandwidth =3D 0;

         for (k =3D 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
-               MaxTotalVActiveRDBandwidth =3D MaxTotalVActiveRDBandwidth +=
 mode_lib->vba.ReadBandwidthLuma[k]
+               v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.M=
axTotalVActiveRDBandwidth +=3D mode_lib->vba.ReadBandwidthLuma[k]
                                 + mode_lib->vba.ReadBandwidthChroma[k];
         }

@@ -3115,7 +3112,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l
                                         * mode_lib->vba.DRAMChannelWidth
                                         * (i < 2 ? mode_lib->vba.MaxAverag=
ePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperationSTROBE : mode_lib-=
>vba.MaxAveragePercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation) / =
100);

-                       if (MaxTotalVActiveRDBandwidth
+                       if (v->dummy_vars.dml32_ModeSupportAndSystemConfigu=
rationFull.MaxTotalVActiveRDBandwidth
                                         <=3D mode_lib->vba.MaxTotalVertica=
lActiveAvailableBandwidth[i][j]) {
                                 mode_lib->vba.TotalVerticalActiveBandwidth=
Support[i][j] =3D true;
                         } else {
@@ -3281,8 +3278,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l
                                                         mode_lib->vba.Swat=
hHeightCThisState[k], mode_lib->vba.TWait,

                                                         /* Output */
-                                                       &DSTXAfterScaler[k]=
,
-                                                       &DSTYAfterScaler[k]=
,
+                                                       &v->dummy_vars.dml3=
2_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler[k],
+                                                       &v->dummy_vars.dml3=
2_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler[k],
                                                         &mode_lib->vba.Lin=
eTimesForPrefetch[k],
                                                         &mode_lib->vba.Pre=
fetchBW[k],
                                                         &mode_lib->vba.Lin=
esForMetaPTE[k],
@@ -3579,8 +3576,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l
                                                 mode_lib->vba.NoOfDPPThisS=
tate,
                                                 mode_lib->vba.BytePerPixel=
InDETY,
                                                 mode_lib->vba.BytePerPixel=
InDETC,
-                                               DSTXAfterScaler,
-                                               DSTYAfterScaler,
+                                               v->dummy_vars.dml32_ModeSup=
portAndSystemConfigurationFull.DSTXAfterScaler,
+                                               v->dummy_vars.dml32_ModeSup=
portAndSystemConfigurationFull.DSTYAfterScaler,
                                                 mode_lib->vba.WritebackEna=
ble,
                                                 mode_lib->vba.WritebackPix=
elFormat,
                                                 mode_lib->vba.WritebackDes=
tinationWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driver=
s/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 43e327080552..9ad49ad38814 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -204,6 +204,9 @@ struct dml32_ModeSupportAndSystemConfigurationFull {
         SOCParametersList mSOCParameters;
         unsigned int MaximumSwathWidthSupportLuma;
         unsigned int MaximumSwathWidthSupportChroma;
+       double DSTYAfterScaler[DC__NUM_DPP__MAX];
+       double DSTXAfterScaler[DC__NUM_DPP__MAX];
+       double MaxTotalVActiveRDBandwidth;
 };

 struct dummy_vars {
--
2.36.1


--_000_BL1PR12MB51440F3E4EA2D40E9338BBA4F7A69BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> Friday, June 10, 2022 1:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Wentland, Ha=
rry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: dml: move some variables to heap</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why&amp;How]<br>
To reduce stack usage, move some variables into heap in the DML function<br=
>
dml32_ModeSupportAndSystemConfigurationFull()<br>
<br>
Fixes: d03037269bf2d (&quot;drm/amd/display: DML changes for DCN32/321&quot=
;)<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;.../display/dc/dml/dcn32/display_mode_vba_32.c&nbsp; | 17 +++++++----=
------<br>
&nbsp;.../drm/amd/display/dc/dml/display_mode_vba.h&nbsp;&nbsp; |&nbsp; 3 +=
++<br>
&nbsp;2 files changed, 10 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c=
 b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c<br>
index 5828e60f291d..b9f5bfa67791 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c<br>
@@ -1675,9 +1675,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool FullFrameMALLPStateMe=
thod;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool SubViewportMALLPState=
Method;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool PhantomPipeMALLPState=
Method;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double MaxTotalVActiveRDBandwidth;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double DSTYAfterScaler[DC__NUM_DPP__M=
AX];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double DSTXAfterScaler[DC__NUM_DPP__M=
AX];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int MaximumMPCCom=
bine;<br>
&nbsp;<br>
&nbsp;#ifdef __DML_VBA_DEBUG__<br>
@@ -3095,10 +3092,10 @@ void dml32_ModeSupportAndSystemConfigurationFull(st=
ruct display_mode_lib *mode_l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Vertical Active BW suppo=
rt check<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MaxTotalVActiveRDBandwidth =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;dummy_vars.dml32_ModeSupportAnd=
SystemConfigurationFull.MaxTotalVActiveRDBandwidth =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (k =3D 0; k &lt; mode_=
lib-&gt;vba.NumberOfActiveSurfaces; ++k) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; MaxTotalVActiveRDBandwidth =3D MaxTotalVActiveRDBandwidth + mode=
_lib-&gt;vba.ReadBandwidthLuma[k]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; v-&gt;dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.Max=
TotalVActiveRDBandwidth +=3D mode_lib-&gt;vba.ReadBandwidthLuma[k]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; + mode_lib-&gt;vba.ReadBandwidth=
Chroma[k];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -3115,7 +3112,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * mode_lib-&gt;vba.DRAMChannelWidth<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; * (i &lt; 2 ? mode_lib-&gt;vba.MaxAveragePercentOfIdealDRAM=
BWDisplayCanUseInNormalSystemOperationSTROBE : mode_lib-&gt;vba.MaxAverageP=
ercentOfIdealDRAMBWDisplayCanUseInNormalSystemOperation) / 100);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (MaxTotalVAct=
iveRDBandwidth<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v-&gt;dummy_=
vars.dml32_ModeSupportAndSystemConfigurationFull.MaxTotalVActiveRDBandwidth=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &lt;=3D mode_lib-&gt;vba.MaxTotalVerticalActiveAvailableBan=
dwidth[i][j]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&gt;vba.TotalVerticalAc=
tiveBandwidthSupport[i][j] =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
@@ -3281,8 +3278,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&gt;vba.SwathHeightCThisState=
[k], mode_lib-&gt;vba.TWait,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Output */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;DSTXAfterScaler[k],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;DSTYAfterScaler[k],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;v-&gt;dummy_vars.dml32_ModeSupportAndSystemC=
onfigurationFull.DSTXAfterScaler[k],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;v-&gt;dummy_vars.dml32_ModeSupportAndSystemC=
onfigurationFull.DSTYAfterScaler[k],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mode_lib-&gt;vba.LineTimesForPref=
etch[k],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mode_lib-&gt;vba.PrefetchBW[k],<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mode_lib-&gt;vba.LinesForMetaPTE[=
k],<br>
@@ -3579,8 +3576,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(stru=
ct display_mode_lib *mode_l<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.NoOfDPPThisState,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.BytePerPixelInDETY,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.BytePerPixelInDETC,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DSTXAfterScaler,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DSTYAfterScaler,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;dummy_vars.dml32=
_ModeSupportAndSystemConfigurationFull.DSTXAfterScaler,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v-&gt;dummy_vars.dml32=
_ModeSupportAndSystemConfigurationFull.DSTYAfterScaler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.WritebackEnable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.WritebackPixelFormat,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mode_lib-&g=
t;vba.WritebackDestinationWidth,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driver=
s/gpu/drm/amd/display/dc/dml/display_mode_vba.h<br>
index 43e327080552..9ad49ad38814 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h<br>
@@ -204,6 +204,9 @@ struct dml32_ModeSupportAndSystemConfigurationFull {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOCParametersList mSOCPara=
meters;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int MaximumSwathW=
idthSupportLuma;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int MaximumSwathW=
idthSupportChroma;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double DSTYAfterScaler[DC__NUM_DPP__M=
AX];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double DSTXAfterScaler[DC__NUM_DPP__M=
AX];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double MaxTotalVActiveRDBandwidth;<br=
>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct dummy_vars {<br>
-- <br>
2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440F3E4EA2D40E9338BBA4F7A69BL1PR12MB5144namp_--
