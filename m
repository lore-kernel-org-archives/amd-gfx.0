Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED0EC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 10:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D3610E8F1;
	Thu,  8 May 2025 10:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="36RMBlCJ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14B310E8F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 10:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR5ty7OD0G0m1dWie59q6G9IOMIV/qq5LtLr43OE6GpMcGo7zngXms9/gvjhGjn3uTWXRQzgIVDvQy0jZg7Iz/LGkpzzaQzYKqRigLO8yD6iusJ3zxzoN7FMUpNmowzRSI6oIL12KADZGEmRMtfwVvyL8qzp5BwOk+X89jurmckR6VicMSIK7SfW5l+opduojppJ5Hp2IEpJVCAQyu27lBpZsQA68Ht/zUzS6bQyFR6lrMhUPsZS8Ro63HUW04S3hkoxzin784lYLegZAsvSvzA0fSmu/YpQvMgSoOOejkcY/+T/mvTp91glxc9HasEyXuQvv8K9WJ3cMSCuTPF2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBDg7g8D0ZaweLR7O0/r7gT4cPAO/mBu2/vs4Wk/v6Q=;
 b=m8zdcxBGieoOno4j+fkTTYlBq2/+gNPZKDHYdEM/F6uXw44WdeveT6Kor8Gi21z1t5jWARU5UUx/4CkO5+dcewedNyWYh12lb18OMuanqvfF2/odhiZhKKR2eTJ36JtoL8ZjzqwTWL+3YKrfayhftwHYQ5wgli1f2wJV0orngIkW00MP3Y01ko9SxitNGlEtvSVJUN9KGoOKAslS8SAemV+pHrV+xJpv7FubgLfKEbaV4CuEAh4a2FvN8ZxK6DzkLiqqvtOBPX462mT9oFweeTr/vn354Mq3OO/RMt96+3n1+XWd4lxmxI6zFKnw8f0n0S1MklFCHE04KJO2xhJj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBDg7g8D0ZaweLR7O0/r7gT4cPAO/mBu2/vs4Wk/v6Q=;
 b=36RMBlCJ66+W6osjvFuS/Xwqc8vu2AU4Jn244CXT0IKT04WwVnMzsN4C8qkZZGJ/oTdlDZjwKW5bH54lubLU0VZh+D5flGDeGiOCWXya6Yt2KrCdQ3hGNVr+sgk9KDoAUM1hvIw/ETdHO8q4OhY9tmSe8SKhwYs1E0MgXe17ALI=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 10:23:13 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 10:23:13 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, =?Windows-1252?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, 
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Topic: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
Thread-Index: AQHbrSrP5jEga9/xXECMUfv7z3IS+LOmU9uAgAKqkAWACTvUooAG3GMAgADwAwCADmhThYAAOz+F
Date: Thu, 8 May 2025 10:22:50 +0000
Message-ID: <DM4PR12MB59371699A6DE3465A28198F2E58BA@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
 <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
 <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
 <16cdac52-5e75-435d-9212-cabebbfc5e70@amd.com>
 <DM6PR12MB495886CC947DDACD0B3E1E4081802@DM6PR12MB4958.namprd12.prod.outlook.com>
 <DM4PR12MB59370965EFFD35AC5836D5BFE58BA@DM4PR12MB5937.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB59370965EFFD35AC5836D5BFE58BA@DM4PR12MB5937.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T02:42:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|PH0PR12MB7813:EE_
x-ms-office365-filtering-correlation-id: 356318a9-1228-49e8-2b8c-08dd8e1a56d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?5qCZW5zKndzADrYB3N31dvGaq68nC3/Xe3c+JGsH08YjTpR0M+INKKRu?=
 =?Windows-1252?Q?7ewzCcsnkIceBGB4N5r5UAuatqUIYUTsMQwD4GtKn4m2wYQmf5gqF1Pf?=
 =?Windows-1252?Q?IXk+pE5azF2rU6a9igFMGDRq6o3w5wYiMs7gDKPri9jTV+fVWyZmYPyC?=
 =?Windows-1252?Q?J45TdKVZpocITBI0PxKumX+rpzAmG0Rm48cD25FEUsK4o/lS6HdFQnRz?=
 =?Windows-1252?Q?NKhb6P4Nnr2YJwcKiao7sqUj30wt2irTnQfPjgbZ5BLbtLL++GHMW6Db?=
 =?Windows-1252?Q?KIpjuBy2ocqPY2rb2ZPNYKF3EogoH07KMrh9Uqwc7DkRYP+psUOIdPO/?=
 =?Windows-1252?Q?uLwWVQ4nFKkJWbGaWhiArNStHj7uVlgSx+Nj8vCKePh/DXHQaTs5+vmw?=
 =?Windows-1252?Q?xmd56rgkwhAQDyL969qaNvibKAu8dXjLJY5IQ2Z87E+EqP7KrH+UulVs?=
 =?Windows-1252?Q?M6ru2SLsspUKsOSVhg5L28THm9N/J+mG7K9B7ka4SAiCU6DtT0kC3wJJ?=
 =?Windows-1252?Q?B5Vs6xmMaxS7HbskzU/6GLqt+reRxrasYoaUKpfydsiiNQ9gnYXGgVF3?=
 =?Windows-1252?Q?PfSrv9osxU8Wf2Rc89SqgXzIo+4ZCgwRR2/f3SQpvoUJghNnIQEjowG7?=
 =?Windows-1252?Q?Fr/K4GGyCPwYlCH/4lHHX9Dk2xc+2DEA6gOQ0+h4Mi1MQbIvguJ/fIb1?=
 =?Windows-1252?Q?KSFts+HgmgOXsxp6ptNxGPOqAWgNrUDJoBnGsVtkXrwGFlUAPUDMmrdB?=
 =?Windows-1252?Q?PeQR+vvo6DF172N01A6KFBAZT1sE3PVEdE3bQ8AjMNi7qDqaPzzDIcFt?=
 =?Windows-1252?Q?DdTw6JZ9U2fqwei47sZsHN6zKucvQgkFvY3BGjIQDIbKIejNODPbKIPg?=
 =?Windows-1252?Q?CjpkejvT/PubKKwrzd8+XMKk/U1DN68GsDpQPQSepj6xaRMvfvCSslnb?=
 =?Windows-1252?Q?y7nIKxHaaY5KoWujfUbE/rIdwayPcaTUlggmG+O3X9uh1Speb0Akh7pm?=
 =?Windows-1252?Q?g9L2HDLWHEHolfKS4E6Hepqkse6d5Cl+Ft4WWak443wC2mcVKjurHgXF?=
 =?Windows-1252?Q?HCe3ci1wltZEiGG/eM7WRnVzxwO962H/LzhflNiQHXDos6orZsrMbEgn?=
 =?Windows-1252?Q?mXmlwXB6yHgbwo6EJuz51LQ70z/i82IKuNyg1oqzaDy331Zo2ZRd/0hE?=
 =?Windows-1252?Q?Bg3D+47+uXt5q54oWBbxg//gW/yb92ef6bERVk1hZFIAVjMEPSUdceN0?=
 =?Windows-1252?Q?6BaP0frpDlO97i1RnC3WkR7rU42T/bSxjnw0aEAG8KSDZLbiDtuixiwd?=
 =?Windows-1252?Q?CxotHIEcAGADm53/MCw1ey+L5ochwC+pZ3tsMKYiGvs6idEGIOXHgf7O?=
 =?Windows-1252?Q?1Q5IEw3wny332uGOWlb/Q0FwpXELZQg+CWhnePys0C+w1CIp2TityIRX?=
 =?Windows-1252?Q?CVMlKHxpSi0+LpDx2lCoQpwXFtc3ZnwwWl/7EU3fiNe+ZecakrClKtp7?=
 =?Windows-1252?Q?9VpwmZIxDRgRNO/aWZKKxn/53mBJs60z9ip73mVkIkvJumiei2LgsbWb?=
 =?Windows-1252?Q?bhTp5AX1Scl6U6yBrYyEB42rtvFGWUSeqZc47A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jHUZYOHKhFL1zh4A9IijqQt5VDjYePV3ZBI//beGroh6stffPgXFjnvo?=
 =?Windows-1252?Q?4qMRYezDtcBZZuIQHkU/2wtjF2z8NvRbUSQPrfLt4hX9QzJ/wFGigL3h?=
 =?Windows-1252?Q?/Sx55Z3oWIlyw9EFrLf8/d4IPOi80GdCLT7OJ6vagViQkTs8FDmow5nU?=
 =?Windows-1252?Q?c/F+T8YKN/98MdNUfjIjBiIhIGrv9ZWRmHfzNMc3viuJk+Rq4Y293Ox5?=
 =?Windows-1252?Q?zjK8mAoJSL8Oj5tdmZkENDlC9YBkEyIhqGJAeZbMytiSfwEIp3B6ckUo?=
 =?Windows-1252?Q?nKjbkDEryg3D4C+bRVdttkcbTOKQXw3sLdONaq/GoZ/r1K4rb07gtlrB?=
 =?Windows-1252?Q?ftukYlYKTCJYpDiQtwOD3asCn3EUmKhasUXFC4283Yc+rnNIZE6TQVpD?=
 =?Windows-1252?Q?7eTApUAqZdLNVWg+in+BheWQXTOCHL7+BnZ5pCF4Ikn4B1LI/cyyF7bO?=
 =?Windows-1252?Q?48RwlaAPiPIKlwp1a10EZ/WDmdqhVU95FarXRz4Wt7MkFMa7+KC294dR?=
 =?Windows-1252?Q?5rvocHA0x/QTiMH+wyaIOGmfrXAOBtSeK1Qa8OqBg0XAOBK0pT66UZMa?=
 =?Windows-1252?Q?hNiYdL4Qgfj7shmRVqswkZVa0pht1OQoUS1afnCqjCRCor1EHRrzAyS4?=
 =?Windows-1252?Q?P4LjGE1g4jPdsIsiQAWNtGuVlwku61i09xJbNOTLog2X7fH3QLZ3QWGH?=
 =?Windows-1252?Q?D//QTB2KvpdI06+76/ltW33b3qr/xHANS5Un/eWAJuwyoWO7dYGuyMmc?=
 =?Windows-1252?Q?Swq9BNgsMmhcX/WRjWx32ZMGwAWCDqvYLzl7HZZ4T2pEHq3VpROQDyoX?=
 =?Windows-1252?Q?d2ZcRSJeURvBohLZrEPvApsp0b98nNu0h/h5C3DdiSGqT+sG4FilWekW?=
 =?Windows-1252?Q?h5OM1fUjvOQQf6l6nWxaMKEJDZJbOieWmawwluqTQTmQkfbBGF7sJxCo?=
 =?Windows-1252?Q?clw0Co/cVQYxdJhc6VrO1JtTpfCZMD4MZHGilnHCff87uMYttoM72Ki3?=
 =?Windows-1252?Q?ST0FQvBnbaRuQMgndYzD1UPSgBmn4u1fUfWKy+YuZNwPWtqKL0Eoe5/9?=
 =?Windows-1252?Q?mL2ij+zArbIy1PNdlgE9S133Sgu8jIOvv5QJkmXCnUXRUYkR0ivTP5Tt?=
 =?Windows-1252?Q?pjKmSI1zIBnTA5Ba/4tOZj5hIGBQ2lco3bwC9PH1DHREUbGY3ZIspVej?=
 =?Windows-1252?Q?JYEMgVFUchgoHNPHYQStLCXO/COTVbn7sIIlsaznL367O5nSECYiPNyk?=
 =?Windows-1252?Q?re5zwbnlu5K8AjAMxdIkHtfxlly7LRLBpUoiEmt1Arzy2ZMZoE50F9ND?=
 =?Windows-1252?Q?31oubH8CLUOdSBHbff/3CBYgOiIqsPA0kLTcrYJiyy+Q6dekMuyWsJAn?=
 =?Windows-1252?Q?zkjOYTBhN0vhtqlNTkcA5aaeMMy/TXbvjaUDBSy7ytpNBNA++b4ovEcp?=
 =?Windows-1252?Q?FwEz02Iwbgy8N+4hEXITpuos3/rguH3+4jUI5lcyVXaFm7h+x8QGmn4d?=
 =?Windows-1252?Q?asRU71FIyd+tY56THwTjEUKKacB4Grec6brRunNuPwLykZ4DwTCRPHje?=
 =?Windows-1252?Q?OUE8hfvRTSCy1Q2tn1UPy8hr8fDLP9t0Wpe2a6XVcxrccs8z+s85ac+e?=
 =?Windows-1252?Q?kNL9B0VnmorwG+jeCoz26TAV8m5EhychGqPvjpV35y3jHQeTTATiipRy?=
 =?Windows-1252?Q?oaGGSY+3CaZy/sX2JOuXAGlbeJmiZdfP?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59371699A6DE3465A28198F2E58BADM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356318a9-1228-49e8-2b8c-08dd8e1a56d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 10:23:13.3072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WzBR6uLyrgUOFfdNe7cwdpOHWHTkeTORgBmwO6hGEEJT25rmoqKoOhBjGi+u994QLuWXYFX2MbrZZhZ/VVGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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

--_000_DM4PR12MB59371699A6DE3465A28198F2E58BADM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Koenig, Christian<mailto:Christian.Koenig@amd.com>,

This issue only happens when switching to new GPU, namely detecting xmgi no=
de is changed.
Should I include the check in this case? If yes, use the new amdgpu_xmgi_is=
_node_changed() or just amdgpu_sriov_vf()?
Please advise. Thank you!

Regards
Sam

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, G=
uoQing (Sam) <GuoQing.Zhang@amd.com>
Date: Thursday, May 8, 2025 at 14:53
To: Chang, HaiJun <HaiJun.Chang@amd.com>, Koenig, Christian <Christian.Koen=
ig@amd.com>, Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, amd-gfx@=
lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Deucher, Alexander <=
Alexander.Deucher@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Deng, Emily <Emily.Deng@amd.com>, Z=
hang, Owen(SRDC) <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error

[AMD Official Use Only - AMD Internal Distribution Only]


[AMD Official Use Only - AMD Internal Distribution Only]

Hi @Chang, HaiJun<mailto:HaiJun.Chang@amd.com>

Thank you for the info.
You are right, GFXMSIX_VECT0_ADDR_LO and GFXMSIX_VECT0_CONTROL registers ar=
e not restored on resume with new VF.

source VF, normal value
0x42000: 0xFEE00138 // GFXMSIX_VECT0_ADDR_LO
0x4200C: 0x00000000 // GFXMSIX_VECT0_CONTROL

destination VF, abnormal value
0x42000: 0x00000000 // GFXMSIX_VECT0_ADDR_LO
0x4200C: 0x00000001 // GFXMSIX_VECT0_CONTROL

Calling amdgpu_restore_msix() on resume can fix this issue. I will upload a=
 new patch for this.

static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
{
+       struct amdgpu_device *adev =3D ip_block->adev;
+
+       if (amdgpu_xmgi_is_node_changed(adev))
+               amdgpu_restore_msix(adev);
        return vega20_ih_hw_init(ip_block);
}

Thanks
Sam

From: Chang, HaiJun <HaiJun.Chang@amd.com>
Date: Tuesday, April 29, 2025 at 10:43
To: Koenig, Christian <Christian.Koenig@amd.com>, Zhang, GuoQing (Sam) <Guo=
Qing.Zhang@amd.com>, Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, =
amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Deucher, Ale=
xander <Alexander.Deucher@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>, Deng, Emily <Emily.Deng@amd.com>, Z=
hang, Owen(SRDC) <Owen.Zhang2@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

The interrupt issue loss issue might be VF msix table isn't restored proper=
ly on resume.

The msix table in virtual machine is faked.  The real msix table will be pr=
ogrammed by QEMU when guest enable/disable msix interrupt.  But QEMU access=
ing VF msix table (GFXMSIX_* registers) could be blocked by nBIF protection=
 if that time VF isn't in exclusive access.
We had a w/a in amdgpu driver to handle msix table loss case in amdgpu_rest=
ore_msix function.

Can you check the values of these GFXMSIX_* registers?  I think we should c=
all amdgpu_restore_msix on resume to restore msix table.

Thanks,
HaiJun

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Monday, April 28, 2025 8:24 PM
To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>; Christian K=F6nig <ckoeni=
g.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexan=
der <Alexander.Deucher@amd.com>
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Deng, Emily <Emily.Deng@amd.com>; Zhang, Owen(SRDC) <Owen.Zhang2@amd.com=
>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error

On 4/24/25 05:38, Zhang, GuoQing (Sam) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Ping=85 @Koenig, Christian <mailto:Christian.Koenig@amd.com>
>
> Thanks
>
> Sam
>
> *From: *amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
> *Date: *Wednesday, April 23, 2025 at 14:59
> *To: *Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>, amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun
> <HaiJun.Chang@amd.com>, Deng, Emily <Emily.Deng@amd.com>, Zhang,
> Owen(SRDC) <Owen.Zhang2@amd.com>
> *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer
> expired error
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi @Christian K=F6nig <mailto:ckoenig.leichtzumerken@gmail.com>,
>
> On QEMU VM environment, when request_irq() is called in guest KMD,
> QEMU will enable interrupt for the device on the host.
>
> When hibernate and resume with a new vGPU without calling
> request_irq() on the new vGPU, the interrupt of the new vGPU is not
> enabled. The IH handler in guest KMD will not be called in this case.
>
> This change is to ensure request_irq() is called on resume for the new vG=
PUs.

That doesn't make sense.

The MSI state is saved and restored by the core OS on suspend and resume, d=
rivers should never mess with that.

If this doesn't work with the new vGPU for some reason then that is not som=
ething we can work around inside the driver.

Which state exactly isn't restored here?

Regards,
Christian.


>
> Regards
>
> Sam
>
> *From: *Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> *Date: *Wednesday, April 16, 2025 at 21:54
> *To: *Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun
> <HaiJun.Chang@amd.com>, Deng, Emily <Emily.Deng@amd.com>
> *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer
> expired error
>
> Am 14.04.25 um 12:46 schrieb Samuel Zhang:
>  > IH is not working after switching a new gpu index for the first time.
>  > IH handler function need to be re-registered with kernel after
> switching  > to new gpu index.
>
> Why?
>
> Christian.
>
>  >
>  > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>  > Change-Id:
> Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
>  > ---
>  >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--  >
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +  >
> drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--  >  3
> files changed, 22 insertions(+), 4 deletions(-)  >  > diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/
> amdgpu/amdgpu_irq.c  > index 19ce4da285e8..2292245a0c5d 100644  > ---
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>  > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>  > @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  >        return r;
>  >  }
>  >
>  > -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)  > +void
> amdgpu_irq_uninstall(struct amdgpu_device *adev)  >  {
>  >        if (adev->irq.installed) {
>  >                free_irq(adev->irq.irq, adev_to_drm(adev));
>  > @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *ade=
v)
>  >                if (adev->irq.msi_enabled)
>  >                        pci_free_irq_vectors(adev->pdev);
>  >        }
>  > -
>  > +}
>  > +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)  > +{
>  > +     amdgpu_irq_uninstall(adev);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>  > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> b/drivers/gpu/drm/amd/ amdgpu/amdgpu_irq.h  > index
> 04c0b4fa17a4..c6e6681b4f71 100644  > ---
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>  > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>  > @@ -123,6 +123,7 @@ extern const int
> node_id_to_phys_map[NODEID_MAX];  >  void
> amdgpu_irq_disable_all(struct amdgpu_device *adev);  >  >  int
> amdgpu_irq_init(struct amdgpu_device *adev);  > +void
> amdgpu_irq_uninstall(struct amdgpu_device *adev);  >  void
> amdgpu_irq_fini_sw(struct amdgpu_device *adev);  >  void
> amdgpu_irq_fini_hw(struct amdgpu_device *adev);  >  int
> amdgpu_irq_add_id(struct amdgpu_device *adev,  > diff --git
> a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/
> amdgpu/vega20_ih.c  > index faa0dd75dd6d..ef996505e4dc 100644  > ---
> a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>  > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>  > @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct
> amdgpu_ip_block
> *ip_block)
>  >
>  >  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)  >
> {
>  > -     return vega20_ih_hw_fini(ip_block);
>  > +     struct amdgpu_device *adev =3D ip_block->adev;
>  > +     int r =3D 0;
>  > +
>  > +     r =3D vega20_ih_hw_fini(ip_block);
>  > +     amdgpu_irq_uninstall(adev);
>  > +     return r;
>  >  }
>  >
>  >  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)  >
> {
>  > -     return vega20_ih_hw_init(ip_block);
>  > +     struct amdgpu_device *adev =3D ip_block->adev;
>  > +     int r =3D 0;
>  > +
>  > +     r =3D amdgpu_irq_init(adev);
>  > +     if (r) {
>  > +             dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n",
> __func__, r);
>  > +             return r;
>  > +     }
>  > +     r =3D vega20_ih_hw_init(ip_block);
>  > +     return r;
>  >  }
>  >
>  >  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)
>

--_000_DM4PR12MB59371699A6DE3465A28198F2E58BADM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">Hi</span><span style=3D"font-family:&quot;Aptos&quot;,sans-serif">
<span lang=3D"EN-US"><a id=3D"OWAAM0FD1BE15665BBE48BD078E2B92117D44" href=
=3D"mailto:Christian.Koenig@amd.com"><span style=3D"font-family:&quot;Aptos=
&quot;,sans-serif;text-decoration:none">@Koenig, Christian</span></a>,<o:p>=
</o:p></span></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">This issue only happens when switching to new GPU, name=
ly detecting xmgi node is changed.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Should I include the check in this case? If yes, use th=
e new amdgpu_xmgi_is_node_changed() or just amdgpu_sriov_vf()?<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Please advise. Thank you!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;=
 on behalf of Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
<b>Date: </b>Thursday, May 8, 2025 at 14:53<br>
<b>To: </b>Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;, Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;, Christian K=F6nig &lt;ckoenig.leichtzumerke=
n@gmail.com&gt;, amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskto=
p.org&gt;, Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Deng, Emily &lt;Emily.=
Deng@amd.com&gt;, Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject: </b>Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error<o:p></o:p></span></p>
</div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;color:blue">[AMD =
Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Hi
<a id=3D"OWAAMA95337AF4FF1064F84FD15F1EAAF1561" href=3D"mailto:HaiJun.Chang=
@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Chang, HaiJun</span></a></span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thank you for the info.
</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">You are right, GFXMSIX_VECT0_ADDR_LO and GFXMSIX_VECT0_=
CONTROL registers are not restored on resume with new VF.
<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-family:Consolas">source VF, norma=
l value</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
0x42000: 0xFEE00138 // GFXMSIX_VECT0_ADDR_LO</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
0x4200C: 0x00000000 // GFXMSIX_VECT0_CONTROL</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
destination VF, abnormal value</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
0x42000: 0x00000000 // GFXMSIX_VECT0_ADDR_LO</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
0x4200C: 0x00000001 // GFXMSIX_VECT0_CONTROL</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Calling amdgpu_restore_msix() on resume can fix this is=
sue. I will upload a new patch for this.<br>
<br>
</span><span lang=3D"EN-US" style=3D"font-family:Consolas">static int vega2=
0_ih_resume(struct amdgpu_ip_block *ip_block)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
{</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
+</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_xmgi_is_node_changed(adev)=
)</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_restore_msix(adev);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_bloc=
k);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:Consolas">=
}</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Thanks</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">Sam</span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&nbsp;</span><o:p></o:p></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif;color:black">From:
</span></b><span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;color:black">Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;<br>
<b>Date: </b>Tuesday, April 29, 2025 at 10:43<br>
<b>To: </b>Koenig, Christian &lt;Christian.Koenig@amd.com&gt;, Zhang, GuoQi=
ng (Sam) &lt;GuoQing.Zhang@amd.com&gt;, Christian K=F6nig &lt;ckoenig.leich=
tzumerken@gmail.com&gt;, amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;, Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc: </b>Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Deng, Emily &lt;Emily.=
Deng@amd.com&gt;, Zhang, Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expire=
d error</span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><a name=3D"BM_BEGIN">=
</a><span style=3D"font-family:&quot;Times New Roman&quot;,serif">[AMD Offi=
cial Use Only - AMD Internal Distribution Only]<br>
<br>
Hi,<br>
<br>
The interrupt issue loss issue might be VF msix table isn't restored proper=
ly on resume.<br>
<br>
The msix table in virtual machine is faked.&nbsp; The real msix table will =
be programmed by QEMU when guest enable/disable msix interrupt.&nbsp; But Q=
EMU accessing VF msix table (GFXMSIX_* registers) could be blocked by nBIF =
protection if that time VF isn't in exclusive
 access.<br>
We had a w/a in amdgpu driver to handle msix table loss case in amdgpu_rest=
ore_msix function.<br>
<br>
Can you check the values of these GFXMSIX_* registers?&nbsp; I think we sho=
uld call amdgpu_restore_msix on resume to restore msix table.<br>
<br>
Thanks,<br>
HaiJun<br>
<br>
-----Original Message-----<br>
From: Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
Sent: Monday, April 28, 2025 8:24 PM<br>
To: Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;; Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-gfx@lists.freedesktop.org; Deu=
cher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: Zhao, Victor &lt;Victor.Zhao@amd.com&gt;; Chang, HaiJun &lt;HaiJun.Chan=
g@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Zhang, Owen(SRDC) &l=
t;Owen.Zhang2@amd.com&gt;<br>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error=
<br>
<br>
On 4/24/25 05:38, Zhang, GuoQing (Sam) wrote:<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt;<br>
&gt; Ping=85 @Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.=
com">mailto:Christian.Koenig@amd.com</a>&gt;<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Sam<br>
&gt;<br>
&gt; *From: *amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behal=
f of<br>
&gt; Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;<br>
&gt; *Date: *Wednesday, April 23, 2025 at 14:59<br>
&gt; *To: *Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;, amd-=
<br>
&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc: *Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun<br>
&gt; &lt;HaiJun.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;, =
Zhang,<br>
&gt; Owen(SRDC) &lt;Owen.Zhang2@amd.com&gt;<br>
&gt; *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer<br>
&gt; expired error<br>
&gt;<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt; [AMD Official Use Only - AMD Internal Distribution Only]<br>
&gt;<br>
&gt; Hi @Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gma=
il.com">mailto:ckoenig.leichtzumerken@gmail.com</a>&gt;,<br>
&gt;<br>
&gt; On QEMU VM environment, when request_irq() is called in guest KMD,<br>
&gt; QEMU will enable interrupt for the device on the host.<br>
&gt;<br>
&gt; When hibernate and resume with a new vGPU without calling<br>
&gt; request_irq() on the new vGPU, the interrupt of the new vGPU is not<br=
>
&gt; enabled. The IH handler in guest KMD will not be called in this case.<=
br>
&gt;<br>
&gt; This change is to ensure request_irq() is called on resume for the new=
 vGPUs.<br>
<br>
That doesn't make sense.<br>
<br>
The MSI state is saved and restored by the core OS on suspend and resume, d=
rivers should never mess with that.<br>
<br>
If this doesn't work with the new vGPU for some reason then that is not som=
ething we can work around inside the driver.<br>
<br>
Which state exactly isn't restored here?<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Sam<br>
&gt;<br>
&gt; *From: *Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt; *Date: *Wednesday, April 16, 2025 at 21:54<br>
&gt; *To: *Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-<br>
&gt; gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; *Cc: *Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun<br>
&gt; &lt;HaiJun.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<b=
r>
&gt; *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer<br>
&gt; expired error<br>
&gt;<br>
&gt; Am 14.04.25 um 12:46 schrieb Samuel Zhang:<br>
&gt;&nbsp; &gt; IH is not working after switching a new gpu index for the f=
irst time.<br>
&gt;&nbsp; &gt; IH handler function need to be re-registered with kernel af=
ter<br>
&gt; switching&nbsp; &gt; to new gpu index.<br>
&gt;<br>
&gt; Why?<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;&n=
bsp; &gt; Change-Id:<br>
&gt; Idece1c8fce24032fd08f5a8b6ac23793c51e56dd<br>
&gt;&nbsp; &gt; ---<br>
&gt;&nbsp; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 7 +++=
++--&nbsp; &gt;<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |&nbsp; 1 +&nbsp; &gt;<br>
&gt; drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp; | 18 ++++++++++++++++--&n=
bsp; &gt;&nbsp; 3<br>
&gt; files changed, 22 insertions(+), 4 deletions(-)&nbsp; &gt;&nbsp; &gt; =
diff --git<br>
&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/<br>
&gt; amdgpu/amdgpu_irq.c&nbsp; &gt; index 19ce4da285e8..2292245a0c5d 100644=
&nbsp; &gt; ---<br>
&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&nbsp; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
&gt;&nbsp; &gt; @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_devic=
e *adev)<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; &gt;&nbsp; }<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt; -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)&nbsp; =
&gt; +void<br>
&gt; amdgpu_irq_uninstall(struct amdgpu_device *adev)&nbsp; &gt;&nbsp; {<br=
>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.=
installed) {<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_irq(adev-&gt;irq.irq, adev_to_drm(adev)=
);<br>
&gt;&nbsp; &gt; @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_=
device *adev)<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.msi_enabled)<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pci_free_irq_vectors(adev-&gt;pdev);<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &gt; -<br>
&gt;&nbsp; &gt; +}<br>
&gt;&nbsp; &gt; +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)&nbsp; =
&gt; +{<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fi=
ni(adev, &amp;adev-&gt;irq.ih_soft);<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fi=
ni(adev, &amp;adev-&gt;irq.ih);<br>
&gt;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fi=
ni(adev, &amp;adev-&gt;irq.ih1);<br>
&gt;&nbsp; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt; b/drivers/gpu/drm/amd/ amdgpu/amdgpu_irq.h&nbsp; &gt; index<br>
&gt; 04c0b4fa17a4..c6e6681b4f71 100644&nbsp; &gt; ---<br>
&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt;&nbsp; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
&gt;&nbsp; &gt; @@ -123,6 +123,7 @@ extern const int<br>
&gt; node_id_to_phys_map[NODEID_MAX];&nbsp; &gt;&nbsp; void<br>
&gt; amdgpu_irq_disable_all(struct amdgpu_device *adev);&nbsp; &gt;&nbsp; &=
gt;&nbsp; int<br>
&gt; amdgpu_irq_init(struct amdgpu_device *adev);&nbsp; &gt; +void<br>
&gt; amdgpu_irq_uninstall(struct amdgpu_device *adev);&nbsp; &gt;&nbsp; voi=
d<br>
&gt; amdgpu_irq_fini_sw(struct amdgpu_device *adev);&nbsp; &gt;&nbsp; void<=
br>
&gt; amdgpu_irq_fini_hw(struct amdgpu_device *adev);&nbsp; &gt;&nbsp; int<b=
r>
&gt; amdgpu_irq_add_id(struct amdgpu_device *adev,&nbsp; &gt; diff --git<br=
>
&gt; a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/<br>
&gt; amdgpu/vega20_ih.c&nbsp; &gt; index faa0dd75dd6d..ef996505e4dc 100644&=
nbsp; &gt; ---<br>
&gt; a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt;&nbsp; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
&gt;&nbsp; &gt; @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct<b=
r>
&gt; amdgpu_ip_block<br>
&gt; *ip_block)<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;&nbsp; static int vega20_ih_suspend(struct amdgpu_ip_block *=
ip_block)&nbsp; &gt;<br>
&gt; {<br>
&gt;&nbsp; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_fini(ip_block=
);<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip=
_block-&gt;adev;<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt;&nbsp; &gt; +<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_fini(ip_block)=
;<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_uninstall(adev);<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; &gt;&nbsp; }<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;&nbsp; static int vega20_ih_resume(struct amdgpu_ip_block *i=
p_block)&nbsp; &gt;<br>
&gt; {<br>
&gt;&nbsp; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; return vega20_ih_hw_init(ip_block=
);<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip=
_block-&gt;adev;<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt;&nbsp; &gt; +<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev);<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_irq_init failed in %s, %d=
\n&quot;,<br>
&gt; __func__, r);<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega20_ih_hw_init(ip_block)=
;<br>
&gt;&nbsp; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; &gt;&nbsp; }<br>
&gt;&nbsp; &gt;<br>
&gt;&nbsp; &gt;&nbsp; static bool vega20_ih_is_idle(struct amdgpu_ip_block =
*ip_block)<br>
&gt;</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59371699A6DE3465A28198F2E58BADM4PR12MB5937namp_--
