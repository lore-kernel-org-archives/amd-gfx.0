Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C23C432BE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32E060EE8
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 13:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A32E060EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BE96E12A;
	Tue,  3 Aug 2021 13:49:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7646B6E12A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 13:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPd1mzpiK30WVjXXfY6SvUpCTLWHTK2moPJ7Li1LkqCgy0hmmhM1o8jZB5DFCndwXRXFJpXdzcOrL3ZcD49mVBJvOtO5ZjjcCR3T1JZbNzeUcD+NF3K3plEKQwSYbvHUWnNjCv3mQk8SW6DcAVCpYZrDSYj0+JxmRyplUqtwxkA2vIktmiv3l75geoYlBnOK6r7R+V1xkC59n6yJftzqvta4WBL+lUQmt1By7hG0ezE3YKZqHWpefp1EbbqOzfKt7xElOFmmoYn4w9jRRrJmH2xK2R8tJ04ffGeqHN8OR+BKzlJLOGUITi7w2oTSxZo3MR+Iv3pd5HkMHIlNj0bGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mK8nLIAUgE/AtiowBopeMt8e/o62XJQiTM04JPpI34=;
 b=PVAOEIsnW2oODRfx2jPmh9ugE9VhWLqqqXkZPdhjZps+nCT/6pmY/8JCewkU1JIk33l4MnFYN9rnWYtpGDniQu8dk6r2odiZeE9ZlyCr4EUTZUNcMaYrRxFKp7+LifZLOt6KaulKxTEiYH58pThFy7Rf9BnVITH183KzaVbbB89WOFmlZkxQvVr+9J9twaXfZdD8knO4mIBzpMKnF/P+TmjYWK262a00NteGJGo3jGwVDID3a71Ow+a9OiO1zxUi+4NlNowtAGd9yRUhyNOeMzQwuQ1q/OPwLG/fqnpx5BhHtMEnoOfjxAkPQNDzOPxKw3i0FGfZQkaRQXFSfDJ4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mK8nLIAUgE/AtiowBopeMt8e/o62XJQiTM04JPpI34=;
 b=Icfqz+lkjPdQ7hnalvIgqTaDXH5R+rh4XZOCCJMVhsN4X0p8mdBiQ3rrEsjRMfFG87Z1p2xnGfbtGrgUXW9UbiqSRGPO+J9Z4dU6yv7VkxUSAUuXuwssFjSjMY2Q3fZyevbe5DhltRDzhFS3LaF7pLwBdGXw36KWAd0p1Momj+U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 13:49:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 13:49:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Clements, John" <John.Clements@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: update PSP BL cmd IDs
Thread-Topic: [PATCH] drm/amdgpu: update PSP BL cmd IDs
Thread-Index: AdeIQFfkuoNhZf2nTNObQvoGaKA3DAALfSwl
Date: Tue, 3 Aug 2021 13:49:15 +0000
Message-ID: <BL1PR12MB5144668A386AC841E314EFA1F7F09@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52264F3DFF23968C6C8D6DA8FBF09@BN9PR12MB5226.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-03T13:49:14.563Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08adcfae-acec-4e64-8663-08d956857c05
x-ms-traffictypediagnostic: BL1PR12MB5143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB51431C354436DB8AE4A85CD7F7F09@BL1PR12MB5143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IrYuvafVHxrJ8uPCqA6IX0fU+/hFv3N8Syz14Vzt9kcyhsXKs6LFgqGKoZdJMrF4mGRs5Rhkp14bAkA2EBurXi+F3EbgdVuIK1pIcf4vV3dqph51qk73StquT3OCzJ3ViCEVo0EfP/7ZmBwQGCPTK7xeZPX6kBzeMUg84istaoM5sZW+DqBo7Tns5pYW2+b8kvojN7Kzi39Vv7dP52sgzD4Y7+Ps0wgH1MTvFzbmKzG7G2HSW0yVkdpMisa8GZXXJ+hvZowOOKNq7xZ/Nsq80qG80Z3ARO3vDkIVlRizZi4u22gDjK/NJDHzD2hFiBL7slzxgqpTO1m0WkCW0X5Sc602FV3tJpMH/3BTfH9Q38kH0YBozRS3P5uQ6N8rWn/7x+9nmFGWNbFgObq5uEvxNNn3vP3UMjD6pwKjKgggs6eR1VxgJtbp2z3gXSLuLKRnyrfA+YIp0AbEvSkon2HBlQICe0q/jcmVIosgb6FfQRyHXHMiaLNOBqKnrsAySd8h/RO38uvm9VWVqc35hJOI744vyKpSOkW2MP38jWYjx+kLgDDS4SMCNUfJVPQrLx0gYv9CjtgeErItx38kSgVr8sZ621n1T+f4iJfDI1UP0tX1hruq4v1Jo+4OCwAb4M+C0xm1fi9IC+7U98JOYZwxw/dxtrb1qrRxlUvEHMIlYrGYHJ0Zx6RJK9QfJGLv0/eF3hZymK1KiofwSHMI2Gsrzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(55016002)(122000001)(52536014)(64756008)(6506007)(4326008)(33656002)(66446008)(86362001)(26005)(71200400001)(19627405001)(53546011)(38070700005)(8676002)(478600001)(8936002)(5660300002)(7696005)(9686003)(4744005)(38100700002)(83380400001)(19627235002)(15650500001)(2906002)(316002)(66946007)(66556008)(66476007)(110136005)(76116006)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eLZ7MEp/VkWsqpAvCgkDu7/KS0sVmdiPB4bG2DNxMkE33yN7vfI0hNuZQIGP?=
 =?us-ascii?Q?gUVc684Pl9vurC02ZSUsfpQ4qMuyRIEV4upK25fCKJdRyKIa5qhT7r+I76Aw?=
 =?us-ascii?Q?hnagiFpL3yra7GczYVbIJfjWVzBZyXvkjn9KsVkuxpTnW3GTMj05wg8HTIY9?=
 =?us-ascii?Q?zBx2EIbOKARaEfsWtKsYTWNsnTBzmYO9tDvYrlUSR6rJLu0hWaGQ91rmmaMP?=
 =?us-ascii?Q?ec1hAj7pel1MLmQvE5Bblh2h/QwDBqwtFBFK6+eaqlB11kny9tt51Sit8F4J?=
 =?us-ascii?Q?DtBX8nqf2IFYcEG3m6Pd6aHHq/1/pUA1YXir3GO+B4fXUSPe6RuJKoIj42Rd?=
 =?us-ascii?Q?AUmyn2BAIO/qHvq2cz8kwOUN5HU1xnZHUlJAwYgoSloM9aN2PvxYEYEWxIXv?=
 =?us-ascii?Q?dYr8ZJhwSRzGvTTwvraZHGLAnruhdIaUeYYbuCZjZ1YbDSLUQLRnkxl1JsQ7?=
 =?us-ascii?Q?y9icLSMlynfznp7t5Y4MNTxXAxuipN69ykgMTMZQwDfiT0XdN7/DOGt7UyEJ?=
 =?us-ascii?Q?YgLEwHbyS3p3xiKCEIpW6iLT3FlPlVZ79SBBg7NB2AzUYlWnKJJg/Ir38WCG?=
 =?us-ascii?Q?w5oKpyWgxoWM39GXm6V4XlvRXOgi15YlYdufy9BYbAnTUQj84aQGwTeaYNrH?=
 =?us-ascii?Q?t4DWeFv7cUlqFZ4G2MpwnhAQex/IQJgZZi2Le3MJXFojqLU7Zfc6hYYjEIWl?=
 =?us-ascii?Q?8vRqZ+CNn7+07hNHkKzE5+gIOsh+jWnqRYlW98rZEHGVwVEt5JLVN6sYxxDt?=
 =?us-ascii?Q?UfE0pzHg8G7L8WArdLRvAHouLDeBYNa03V8oDaCmuek+UcC+y4f0Cotii4pi?=
 =?us-ascii?Q?yf5d4fA0ibGPcrWpl5Nb+7d2tcUhk+aazgfyK4HFvflNVikv0os7ytraMkdN?=
 =?us-ascii?Q?J3NNQ7gekaLf/z0W4jWP+biU549oN7sQP2/kRarIJOnyulutd2M2tUX3ezQS?=
 =?us-ascii?Q?WhQRakDBNw64yldZTl2b47LfPCmW/UZ3w9ZGx+qC1EIUzzKKp080R8V0FHla?=
 =?us-ascii?Q?5bFVYAadcSlRkExNnP4IBPo25v/Mv50c9Ah5EM1V0JN0XQW2JOBs7ciPYHdr?=
 =?us-ascii?Q?kN2fDJFivb4h0TPlX/MlPKHFtSe2hXQX4WWYztt9QF+WKY/UTSj2FC2fSKPg?=
 =?us-ascii?Q?L4OhlyI33JWBZpReJgM9YuYjz1Xsb9Xra/8CrNGuZmamndLrxNKfIx7cN2n8?=
 =?us-ascii?Q?BPfoKgKKrGzexuGJE4x3mRehWBdqUvpbTvHwPyaVevSo4UbCzsCglLmOR1xh?=
 =?us-ascii?Q?09qLLiWGj1zdwmlCtAiugPMjcQQ5EBkwYFKTINfdD6Zq/aZG4Gx78So0qTNU?=
 =?us-ascii?Q?eGMIM8P+jUr5HIC73oI3jEaR?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144668A386AC841E314EFA1F7F09BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08adcfae-acec-4e64-8663-08d956857c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 13:49:15.9140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc/n8lXGDVN7tn0cWe4wQbt3z81D1fKP0ohm2UAmcITVpzn9nRcxBalfdDuUzfktC/9U/W079sYo8Yfb56wUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
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

--_000_BL1PR12MB5144668A386AC841E314EFA1F7F09BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Clements=
, John <John.Clements@amd.com>
Sent: Tuesday, August 3, 2021 4:20 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update PSP BL cmd IDs


[AMD Official Use Only]


Submitting patch to resolve issue with incorrect PSP BL cmd IDs

--_000_BL1PR12MB5144668A386AC841E314EFA1F7F09BL1PR12MB5144namp_
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
ounces@lists.freedesktop.org&gt; on behalf of Clements, John &lt;John.Cleme=
nts@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 3, 2021 4:20 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: update PSP BL cmd IDs</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<p class=3D"x_msipheadera4477989" align=3D"Left" style=3D"margin:0"><span s=
tyle=3D"font-size:10.0pt; font-family:Arial; color:#0000FF">[AMD Official U=
se Only]</span></p>
<br>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Submitting patch to resolve issue with incorrect P=
SP BL cmd IDs</p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB5144668A386AC841E314EFA1F7F09BL1PR12MB5144namp_--
