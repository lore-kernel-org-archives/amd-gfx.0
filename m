Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C45C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 16:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984B410E52D;
	Tue, 17 May 2022 16:30:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83B310E52D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 16:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5Vs2857ckJ6NzzcxzJ0lDCdcgtRPR5IJK+Ax4wN9X6mXEAw5v5ro5pc4D6+KYQ3iSt43CInG1LhbIkp9fuBWT5SCI8QliT3+oos6C2qy/vELt+QnnbgN60IyPZxflqUW11NC/H2jNoV+5CSl2gyZwSE5h5GFxZwrwUq+PKR3tfYcO8OJ6jMIkp3Sl7GAxOD3AN9Ewbg/YDJiQCftymNVe0B++Xh35RvRA6CRDbyMdj9zvGek+Mu3CyF5h/mX1cV+gIGmB+eB5btsogDrfSl0hkRitDV9dSASbklgWeULF7si45LirC+QLjGoqjdYJ38fHUcSZdf9h38Td1S8adslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9rHWF1A6cSS51+qQakvCiJ1ZhXOEvTu/AIEsvhY/Z0=;
 b=Ejf/YQJ5VWypOAkLZVdvdS62SnnUsAjJe1eQAzk6xLh2e2DYHejxFuNFLqRzisgcwLExBFDsEW5EgHn9JjgBPs+D15Zn5vO0OrAdAsAuYSTPG3WAqLhU8w+7Q6zCYJgzngglksqx6WRKTKs39SJcXtKmJrFbuGjSJ4XV74Wez1slK0I9qvpc3Ms2LqrpQUloa/jgMewj2AjfFCGA6GtYDSSSfSrRVVVfnu7QnutQlqGtCJOkeLo1UePATyE9BNS5NsiiyIcT3VNDYexhpHRNofKJI94Wj4cLQzMbMgBtHqeErG5p4IiB5YAQzRcNpnS4Lzt3pkNl6SoNeRwJk0bkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9rHWF1A6cSS51+qQakvCiJ1ZhXOEvTu/AIEsvhY/Z0=;
 b=FPkRsKMJXc7e/nH0skmossSZGvILFFWoFX3T9xcuyIxj5WMbVW+W0IW7Gt6hiq91uvjkPujHflz6byRC07jhBVzU7K667xmOysh4cRdHcgkn81X8v2Y2IkRxHuDaGqwxltpmOdOhJJyKpzOVjGlY68yHbmGVeP/41chbMcXtHeY=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 16:30:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:30:16 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Topic: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Index: AQHYafOSaEN0/701nU+0Pi+gyRxwTq0jQW2AgAAAMSA=
Date: Tue, 17 May 2022 16:30:16 +0000
Message-ID: <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-17T16:30:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-17T16:30:14Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 13de82c1-6b97-4ee7-b968-ac79a9a5f2f1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b2c1f30-991e-474a-7cdb-08da3822866b
x-ms-traffictypediagnostic: BL1PR12MB5732:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5732F5FA4A76E4A88BF88D04E2CE9@BL1PR12MB5732.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U6xi5kvdiQ+SCdMEZaCoqb9TgZyNbcVgIwIUe+vvvts8Hk5JaPbyvkOdV1s8kPbN2ns7J2RFTUYBbXQ8gmNSFg6tE0QgwLMJHIeOduX3RA5iloYcLLB3KYSvTo8WRnLgnESM2PmwKoOMd/N4nuAxcCsKVItRzXdi80sG7lLnwk+rDhnnWFoB6Rz5N91KBpZw6jpx/+MJ6xr+fmvmwqqNkbW9YQaLmLANneqRhLCMdVEAwmAiX8IPg+uSve7GA2lWo4vgE0f6plzvEPPWR9VLeweJLz0/nDBi7uhin5q+yyzIE7OlepzGneDZv/z0y9b3XnHfl3Mq7KaVTRO74rDeWjKSNZ145JPTfwAJt6w1BV3yhuvUBuy1ts+n3n6VyuVZCTbEt2fNoXQaxGQqMtDhgggszCp7HEpaVitFlgMfEqJt5h5Ugx6hxBO9VMAA+vTuwK783YehQ/Qu47tDhh2jQ3z4ZzKTSF8fVzL6FbpsNtkR81SIQ2rmdaipMxpZ0BdWF8mANgfsdv4P0xJ4mPB/+ZrotzS2v+hZPkco/vYCtalBybojHv9IzdShPRpJAjV/2H7IdkTx5iKkXQTESsM/SFoCzXeFLUz/eCaXE9q3ipDoa1/8lQEq2pUm9tuIkIPO+AZcbSJ6uxnrEJsicZKvG+5a2HPnLX6fXk0zWfR74SRlCTlMOz3CdbFE6VRndQz+uV2D4W++rWnCCsQUJsfekA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(9686003)(33656002)(508600001)(86362001)(8676002)(4744005)(66446008)(64756008)(316002)(6506007)(110136005)(2906002)(53546011)(55016003)(7696005)(71200400001)(8936002)(122000001)(83380400001)(76116006)(66946007)(38100700002)(38070700005)(5660300002)(66476007)(66556008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/dMFq/VPYLD175IojxME2vMERElQSnYjU7B3cejrUHoD0zjXsNsvvR1VF56?=
 =?us-ascii?Q?KFdP81N7ML10Ms0i34Pl1QxIxVgz/ql/CnLcVXdJS5yONB6vmjvDfN47JKrj?=
 =?us-ascii?Q?3jXFIgZXfdcnT70wOiTzcuNjQ/oga8RHbfaxoXNm6frAfxlJ/EnF6ycfFjjz?=
 =?us-ascii?Q?fxr3MEG+N1ojQQyVhxS4iRCkIoGYPaASVOyYlBK52Z1c+0+sM6RvlWwRujY8?=
 =?us-ascii?Q?rtIuiod+ScxAryJif7qwHyberkaGq/ORRKhYY0BcrwlXj/rm7fYnecDjGURQ?=
 =?us-ascii?Q?60hN0ABh8+xOc4+lFFOj078/1o/MYjOvCjXLlJyvEkwL2I5rNo4xVF38zbVE?=
 =?us-ascii?Q?u5qRk46/K/GQ53UC3py27q6u6WF1/oZ7XLNYxmKUZtfvo75ukLpCN5xqvWZ9?=
 =?us-ascii?Q?EOtBVo0Pe5/XgRlrKEj7hGjS5HRv9fWtuWs7IwDXbKM8k/pGeDS+KmUqOAY5?=
 =?us-ascii?Q?7QcW2ZUeag7aBQmcZbm6ozrQIT8WQEwOdLyiM5uLRZzd9z/Wtp0ghw7qNwEx?=
 =?us-ascii?Q?Dji3D+LVpQynJWWqQx/CUvEUoNuz7JmExbfQJZwy7e9+4E6wAzewzrskgeIj?=
 =?us-ascii?Q?kuXsQ5z9GDu53hVJGsoxaLcnwKxt8BQP5ev0EY7qJxFtch1vS9AFNtq/hMcz?=
 =?us-ascii?Q?sNt67u1LApcCtjXlIcupitAKk78hBvR4wVb7NwredgIl0xv3zp7HIs9pFGSM?=
 =?us-ascii?Q?UMW6iSLPlIwSQ8I4CQh9TZk1msAXOkhsiVAng2vHP3EUMmAtwFzK5Piv2KHe?=
 =?us-ascii?Q?1ObAXbQNLLAx28Zr11/rzkxDAEzEz0bPo+YcHGKOzFxOTkatpIE2696slGn1?=
 =?us-ascii?Q?xaAXbFuBYIC8ZfQaL4oXbW3leh4irZiKaHr6bdh0aZJe9zW+Igd0t3kLS6GN?=
 =?us-ascii?Q?HNnKuP0aD7dFyrVPrFSswp7iy/aPsSX0ay+4Cbi6T/GtYB4JY6jidQ4dttkt?=
 =?us-ascii?Q?jLxtqTO5ajQRO+LId3jrW3dsuQQ6Be6K+PWyzITAHwoi3bTxYloD7j/ZUCvz?=
 =?us-ascii?Q?VmSgOlW9NUQ0Kw037xVHmye5iNOEr636xnLtzZtxte05SryDk4KMp0tjf4pR?=
 =?us-ascii?Q?iN/1MazSMSeha8YMvJR5zAXXRmoU64PQXrGjHFMmYmSFEgwCmRxXVdWwJJE/?=
 =?us-ascii?Q?Bj3iVa4yGGL3ktKJpkXokUSR+lA49Q9X7qJRq4gyTa9LSoeVoHK+bz3VWap/?=
 =?us-ascii?Q?I3oFWZeE77mLA+KplYWlHX3haM8vkqf1beleBcXHZPNjlKU5OprkXViZinuy?=
 =?us-ascii?Q?kBIF/63itA1Lbe01pZI/FWfwatOyItNFnMaBYeU/Hb5MGWig1K79Prq+5MKA?=
 =?us-ascii?Q?pfSC1AWtPX/NjtY+pY4413+JCnm6PTYLgmgbdwIwTyHlAD6NuP4W/Lb1tgEg?=
 =?us-ascii?Q?83bCDaVtaXdXk8SnGlbJ+dv3QpmmkQEc/BDZF/NoL29KJYKJzvKShRBYwSO3?=
 =?us-ascii?Q?ZNNCfgD07M2R5eJV3FiZK4GMAnfhbiFjzF+0vSxX8WJeV5YjqjR8aTtJnTbi?=
 =?us-ascii?Q?V7eVCbQcx+82u4JSB6ar4oGq+pMe1R28XbGEvwf4XYJkfMDX/OJVfwoZZvAL?=
 =?us-ascii?Q?LQm1jTJtcdhIFQGT0H4Ap6cMj4Ft5tkkcqnN3otSZKj9AY9rMIbmzRmOBPa3?=
 =?us-ascii?Q?k6xU+/Vrp0aZsCkNlvCkr2og6GFikOT+pSH5yM0FzxhmGSBPy06toTCwG3fg?=
 =?us-ascii?Q?ipz26P2M7fYbJMtcjsYcbtBkseydQfV7MkWjgyCs4dwTKrgJFJyGwGXoa9d7?=
 =?us-ascii?Q?fvF/ofvXgNkMXp04nV/Y//x7ZkyZb8Uzh3JpTKuEA+qai6Hj3V71UbJL5lIT?=
x-ms-exchange-antispam-messagedata-1: D8MV8EnVBjAPjQ==
Content-Type: multipart/alternative;
 boundary="_000_MN0PR12MB6101B804A6C68D3ED85262C7E2CE9MN0PR12MB6101namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c1f30-991e-474a-7cdb-08da3822866b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 16:30:16.1112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IwLm1u4eAUCuW4D70M3v029eJ/3d05vhiL2NSBCDBV2W7tfTlrOpFyTtC7Il+3e6/QUhXfSMeAhm3n2CCoGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

--_000_MN0PR12MB6101B804A6C68D3ED85262C7E2CE9MN0PR12MB6101namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

> PM_SUSPEND_TO_IDLE should be under a compile guard

It is actually.  All of the amdgpu_acpi_* are.  It's not obvious though loo=
king at the patch, you need to apply it to notice it.

> It makes sense to rename to something like amdgpu_need_reset_on_suspend()=
 as it decides on reset only for a suspend situation.

Remember it's in amdgpu_acpi.c.  So it would be amdgpu_acpi_need_reset_on_s=
uspend()?  It's a bit lengthy.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 17, 2022 11:25
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle


[Public]

A couple of things -

PM_SUSPEND_TO_IDLE should be under a compile guard

It makes sense to rename to something like amdgpu_need_reset_on_suspend() a=
s it decides on reset only for a suspend situation.

Thanks,
Lijo

--_000_MN0PR12MB6101B804A6C68D3ED85262C7E2CE9MN0PR12MB6101namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&gt;</span><span style=3D"color:#212121"> PM_SUSPEND_TO_IDLE should be u=
nder a compile guard<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It is actually.&nbsp; All of the amdgpu_acpi_* are.&=
nbsp; It&#8217;s not obvious though looking at the patch, you need to apply=
 it to notice it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">&gt;</span><span style=3D"color:#212121"> It makes sense to rename to so=
mething like amdgpu_need_reset_on_suspend() as it decides on reset only for=
 a suspend situation.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Remember it&#8217;s in amdgpu_acpi.c.&nbsp; So it wo=
uld be amdgpu_acpi_need_reset_on_suspend()?&nbsp; It&#8217;s a bit lengthy.=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Tuesday, May 17, 2022 11:25<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">A couple of things -<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">PM_SUSPEND_TO_IDLE should be under a compile guard<o:p></o:p></span></=
p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">It makes sense to rename to something like amdgpu_need_reset_on_suspen=
d() as it decides on reset only for a suspend situation.<o:p></o:p></span><=
/p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN0PR12MB6101B804A6C68D3ED85262C7E2CE9MN0PR12MB6101namp_--
