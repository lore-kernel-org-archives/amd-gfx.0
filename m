Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B4C77B61
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 16:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F95E10E0B0;
	Mon,  1 May 2023 16:10:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9487C10E0B0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 16:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS0KApXOSsUBJUrF9xKEPb5c2kdas7HmjwXmbhoC8l91pLAXvIXRhj9ssrrH2x9a+71+LAzZtRqE0w6QmFjSZ6UNtSte01yRdZcTLysdIuY4xx+AuVkREowida3HakeWdRCYzuZMoVLdfJgN0EWMVBxbzkKiDdKXuZ2Z2vrIPfptXcLMA8ls+yHKUiUagecypDCHQWEg6gkq155cg0N5D+7WNCMuE4Uc0hVAlPLaGt3UoGU20G9Jc4WvugC/C5bqDMbFqUeu6Hnw+8v+JXOF3dYc6LRbpKKr41xeyMudlbYXSNXgkPAjRIYwpL4ARPpojhnakcCpAMKa4dsy8QC5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvO887ZpFrrL2ec8uAd+y4zKSUm/70kR2WUMza6ITSg=;
 b=QZPMlbF3dV1sirdrLKMCjii3/Lcw4CWOXUVXjWwarnxJRlgmO96Gnbi7hrtormlLajIkaRgZf7XnI3D+skyDEUIxEEwjy2qA7LOTalhNHhgtn/Xops0lyyr3c/6ZUUVgT7sLy+8DFTr6oWbwNUlmEOL4AWnywY1Ja3gMd4Td56nDU4xWbtViFsz/0jll1oj9GYGsUtyXSeiYf3cUES2U/LtqfWiR8kKaHzZAQYVmJsUDKEezEtPBXSTD+1dqernWoE0w5strSvyn+tBH8RfnKh+49U9/BkN355zsl1oc9nSVAPO0FbSxp/scspkepszJOgppu+pSQm1FAwmzRgQtwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvO887ZpFrrL2ec8uAd+y4zKSUm/70kR2WUMza6ITSg=;
 b=oa9+stbB0lxklTQpHCHsBILYZ/VHZgmYLS7LpEb+cUEvZPHyN/wvm21+0vwnEfdaxeZSuvyShTH3/6IPvFJHiov9oD/z/Mj3I/mApKYMCIKGUPaKBlxSjsrreVQFeH6OMAl0vkpX2NtBeaSC9ayicH58wAbMrCA6YJWlVn2QIy8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 16:10:15 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:10:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Thai, Thong" <Thong.Thai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution
Thread-Topic: drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution
Thread-Index: AQHZfESJFY0pDrS15ECdIDz4egfIpq9Flh7p
Date: Mon, 1 May 2023 16:10:15 +0000
Message-ID: <BL1PR12MB514476FEF33C69404E0E89EEF76E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <0503f2b2-08e6-df7e-fe79-2300634a605d@amd.com>
In-Reply-To: <0503f2b2-08e6-df7e-fe79-2300634a605d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-01T16:10:15.350Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB7647:EE_
x-ms-office365-filtering-correlation-id: e6c0f44e-e800-45bf-403f-08db4a5e8d10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kq+RlqVN4mDtlTwBL1rHpHpjp80FuUS7rrBOs4/LTksDE9lWlC5XEYWM+tkq+eDDD+u6mIo6cZiGuF8FUKnGR68W6GLnnO8b0R0Mwmo5jr9nwyBZU3yJWtngWml9ALz3HdHR5WpqivTdmeRAc9N5GbkANwrzTsLNcNAW3uUE63A4HzN7qt3Kcuqv8SrI0E1mIW9BN6fUwC1ly4D2bzUndMwbBTE6bWt8ob37e59Uwhl9pqNoiP1cA1fBQEQaT3rdcGqCi6sva5xtHe0jfpR/a6IbmljqxyerdnIIJWKvmB/uLLVlc9ygS5zmQSRvkZGd8BGgXgP4srb6LxCLuX0WcPXq7LCdlJMga+HX2wWPVKNpes5CaQCXMnT1ifc3A1JYB3sy5di/URPcEX0z84MVl+YF8uJSrBLM9YWcmrfEue7uoEA0GRgzHqG+r9CpwPLRUGmX/+uEbu0wnURsPxak8LTmET5c3Pm0HBIU/fLR5H+ERk+FfIDLNn7fOKfrMM8qviJXT2C48baKX+RXn/8ydjRx8tr1zqIb5O5/lXpesDnV/mhJif4hRdMwDe6JX2TJTeTD5IDBk3GrwLqdx2d+hp+hoy/cfn2ZWz1as1/V1r4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(15650500001)(4744005)(33656002)(52536014)(83380400001)(19627405001)(2906002)(5660300002)(41300700001)(8676002)(186003)(316002)(9686003)(26005)(8936002)(53546011)(6506007)(66946007)(64756008)(66476007)(66556008)(76116006)(66446008)(38070700005)(110136005)(86362001)(7696005)(71200400001)(122000001)(38100700002)(478600001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nV/P3VijUjBZv1L1rb2M048jtU9C/HjUtMVVQHGGC/md52A9DiVmeIDB5Aeu?=
 =?us-ascii?Q?c/DKIsADVVWsZvRicUQcfmb3DYiNp/0ll8WehmbposkBGz82+5MZ9PVqgBNx?=
 =?us-ascii?Q?84i52lr8ggPsYgzcYBv/u/L/WCwbg/1ibzELFeCm9zw0YI1HgCIYk0g6teX9?=
 =?us-ascii?Q?tAt+pjd+bD3LxF3tQEOquCrqcy3HNo1K2VvZTu23/I9puKM/UWwzgfP0kZkV?=
 =?us-ascii?Q?Jij0kQnhtsBspAXMiFkIra6iEIiQPKkKnEQ0tN0y44/d4jTQCxo4AA3sbcUW?=
 =?us-ascii?Q?gPCD3oEuqO+fJzC+lsyqugNVgYbFo8lh027Jg7jn0nGz4eZS7KpSybjOtoWN?=
 =?us-ascii?Q?vkg1pnSpRfdHneyMvLV/FiGwgYNWj4BscRW5VBzyoNM+uxxzibk1P1jdCA39?=
 =?us-ascii?Q?mSSTQHqjh8EXNrRSZppfgKgPqt+xa6EB0bMQ4fmwK6RDx2tDmLuFAzWyYnZ1?=
 =?us-ascii?Q?HJ5xkBn7979JEbBeXv9yASQ8qAcmAXaLX5z695dzcEJtt9KH/hLtqyLqJND3?=
 =?us-ascii?Q?hw9ZG2+/qbuCMLWGG7ufN7dURxM2GeFjKInQthViubiywgFog6gXJmi29Lsq?=
 =?us-ascii?Q?wjqnPV9OW5NkNCn8RVL0X6uhE4b06nYP0G3BENk36VgDRyzO/moLnLMFUhD3?=
 =?us-ascii?Q?nUPjkDFG3UA7P4yoEZeF02WPdmhKjq6Mh0BGYx/M7jBdvtgYxfDPI1Qp2+hq?=
 =?us-ascii?Q?bC6BuX2TAsa2rIGMQvQabW3nkJCuIGBB+yt1t+oZCN3sVdll6JBahe27NF++?=
 =?us-ascii?Q?vZ1j8X74rTl2XxDrBjCV+1xcBuA3LdUTiM9YFsNAzpPmZcMBI17UHppbL4ef?=
 =?us-ascii?Q?B/j8kVszg3OrXe8kRTbtHPx+FecDcMTSRIq5QUAtMwkmLm2iDKNEyOIIPZtT?=
 =?us-ascii?Q?USOdDJjgkqM1pPFLPo+EfrCDIxz/kuT26lADuwDB70pm0NJBnkL8x4Nbu365?=
 =?us-ascii?Q?k/8cWPs2dECLFLE4NK+Ka+gMsYujdPHb7vcz/g2DNgEobLSh+4byhMYJLIvb?=
 =?us-ascii?Q?1REMqD06odIVSMl70KxV7FdOez5+hUyuJzmD3IK42XZ1SuFaoQJiQChRYwm2?=
 =?us-ascii?Q?SRuzh8u3u6dtImL5FFY35NETjy/i9UDzV+lxkFVigJG8g+izLsmStThJjUxF?=
 =?us-ascii?Q?NpDRqSOkl9OI/ZTSUkQ5LBXc2CG+pkPNGTb2LOjCaQPbSf0iY0Ui4BAitaC3?=
 =?us-ascii?Q?mfYR3YDj0hwarA9Hd74BLYswuCOmvXX3xS/lFai3TS0Y2A5DBbdLx7PPg3Ht?=
 =?us-ascii?Q?u+vDCKyE0bojBPlhzTnrNBEOx8PdVzq5kYxt/X4f+ST5tyf3XQ+9+8eNHPGm?=
 =?us-ascii?Q?qZ5tpHEe8i1sXC3RouHhoOxbOLrcUCBWdL48p1f9r0ZyY3/XsTf9nstGYvtB?=
 =?us-ascii?Q?8qfZwAxkSCOSwrlvenspt8tUxZLP+eqE1/RJhWqxnPJ3zPjPf0vIUoeBDGaC?=
 =?us-ascii?Q?3TgZ85QkWFviSv3WP0+bGAj2fI/hEOOcZX2ikRfps/oJFzJ6XWoevwshGawr?=
 =?us-ascii?Q?1JNNLARLWJuzKUoRB3C5MNac+GaXZDoe2q2eWoWkUNVotlrqUX8ifRJZlUsd?=
 =?us-ascii?Q?0PeHJYmeFmy1YLZfJm8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514476FEF33C69404E0E89EEF76E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c0f44e-e800-45bf-403f-08db4a5e8d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 16:10:15.7086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XU/x6Advy10+7u+clYSLONhKuP97KxHWEUKVxLhe14eK9nVHSurCxeT/43mxk/RmQKSViksegLzWSgBZk5S9pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647
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

--_000_BL1PR12MB514476FEF33C69404E0E89EEF76E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Thong Th=
ai <thong.thai@amd.com>
Sent: Monday, May 1, 2023 11:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

    drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution

     Update the maximum resolution reported for HEVC encoding on VCN 3
     devices to reflect its 8K encoding capability.

     v2: Also update the max height for H.264 encoding to match spec.
     (Ruijing)

Attached for review.

Thanks,

Thong Thai

--_000_BL1PR12MB514476FEF33C69404E0E89EEF76E9BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Thong Thai &lt;thong.thai@amd=
.com&gt;<br>
<b>Sent:</b> Monday, May 1, 2023 11:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> drm/amdgpu/nv: update VCN 3 max HEVC encoding resolution</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&nbsp;&nbsp;&nbsp; drm/amdgpu/nv: update VCN 3 max=
 HEVC encoding resolution<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Update the maximum resolution reported for HEVC en=
coding on VCN 3<br>
&nbsp;&nbsp;&nbsp;&nbsp; devices to reflect its 8K encoding capability.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; v2: Also update the max height for H.264 encoding =
to match spec.<br>
&nbsp;&nbsp;&nbsp;&nbsp; (Ruijing)<br>
<br>
Attached for review.<br>
<br>
Thanks,<br>
<br>
Thong Thai<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514476FEF33C69404E0E89EEF76E9BL1PR12MB5144namp_--
