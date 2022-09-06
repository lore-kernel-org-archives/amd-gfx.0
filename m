Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0181EECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 15:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB5F10E6C5;
	Tue,  6 Sep 2022 15:04:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B88C10E5B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 15:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuacr7v3vD3W2l5E8JaYaGQpMKeiBjBmJMyujIIBBvLUnfUACDivCjdlEBJRxJl/JaQMbfg4PJNtlwLPgJoUawddkXSCUu2N2hTOzPOBQSkEaaXuGyCTBXXsSZeA/IPnzd0JG4pwWDqYa5GbPN3JPexFMDmZRfj0zjrQ8/2zr7fIRABixpxKwpNOU4MWvVWgh9t/7JJm3ymGQbJcPWKoiR2m7y4pNFeM5FH7SudcYwZtaYm3F1D0oVjIFflJc1fCV+wAsonS111RjVXufBhwtR0r+rnVTMRnp2eYYDstQVKjxN3DJ96Ke/hmoJO23hS/3zEfMOOIGvshAOBNl9TVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUzILMqjNgrq7eBNvwdXfHDiF4TfjZoWiygyy6/7O7E=;
 b=SkXbQG8xI2znSFmK6kOrLWS0rYugMmGkrhfSQ5wHTEj5/n6OBbx3iXjDpq96r9kLPOyLHh+oeNfrLmyzJRwl/ebca8o0Xz6i2Rw6ZnynMSEE86deygOEmyrvuqo18b888T4B43Di5xSPKhGkzWvFQOj8/qN68ET4eHbTkuJKKjcJfPplk7HHbvqmU5GaYW6NO1cUYJpBYgesrWMTqPzuzlnCRXbkUF5aidOq9usHE/MzArjHwSg/0SoK4epTDzna7Y/1fPQwnx6kRRRoHUGNXfsQQkkQUMVE4WJVT4guE+16isEvcxOt88QoAd5uto60c1Zf2kWidCp48zSbzcKWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUzILMqjNgrq7eBNvwdXfHDiF4TfjZoWiygyy6/7O7E=;
 b=UtqnT91tI0QcoJ2iBZb6o/3fDmrDm3FuzbDsWMCg/O9OdXyCc9hcowGjFgjs7pVXlea49wUnXZDrSVxoEhWsQCteBIB+6QBlvTFxJg9JxsYR9O1b48aZ+3vjAx6HzPsNjgRQj+TMbuPSOxRLyUIL2NzUT2hPMfa0FUrpiPvVsOY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 15:04:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%7]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 15:04:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Yury Zhuravlev <stalkerg@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Topic: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Index: AQHYvvGHorBO3qLjoEGQTSBvmQyq9q3SheaK
Date: Tue, 6 Sep 2022 15:04:41 +0000
Message-ID: <BL1PR12MB514410A67CE80EC9C55C74C7F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CANiD2e857Jm-gFzr4jRxvw3AuDHJPfATRzmtZ3PipDwQOpYwvQ@mail.gmail.com>
In-Reply-To: <CANiD2e857Jm-gFzr4jRxvw3AuDHJPfATRzmtZ3PipDwQOpYwvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Evan.Quan@amd.com,Kenneth.Feng@amd.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-06T15:04:40.590Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43f91285-b6ad-403c-40d2-08da9019201a
x-ms-traffictypediagnostic: SA1PR12MB6704:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eRUZcirBJGH+7Z8IYQ+lXohOgnc1FaCH35Be1P/sHttB5Z9hk6114QIOWShpxE1QiPJVJtjmoKWJlh4IBbwkcwRv1WXyQLr3yR/90OwurIW80tkSuvL7NRWsFczAKptKrO7gHgBJJTLE3Z/iiD4w1+NTgfmZWc4DoVy3jyVEqGMSGYlpxE+24v9Y7Vum9Wp7QS8zNasJD+lCeUt9F34/6YBgPYQhy/Pl5/9wkqebe9XYOAF0LIvnzZXqifhKuD+6nBvQjR57OWiMX3/ED+aVXc+9Y4u1nbUxJf8FyZZWjkMpmfyFzEBqUHuIFgcXUT0shCUXX/KTwG+uD5mTpbRYbem4iDjXBXbFxW4v+T4ib22xMdgoyfJ52Tnnyuly0sJBX8M2PQnWsIOR3TxiBd5bL+GVaLfS+eUfLxssAZkZ7W9GxGO2T9dbNJS4q3nkph9bMB/KtMs4802k5lS2EFpcbc5VAZXNvh7QYW1GnBxmNQwbSdK69Vs77xqLOxDsI7yrthvlavH/HGWEzcOtn9Zd4kiqjPaAvw5SY2vLSTn3r6ggeWgnBRiufcr+/p9qihgrPbCsLnMPUeE68WeIi5IfE+/dR1i0HOtgCwVUif38tpW3JnOBWaat3H3qTAf0e8XfuAZabgfT/1PBKCS6ZzbWK/iMLeYmqeb5g+HFI3uEJ5DT0n+wo9B4ATQU9PBj5FgOuBMiz9vwfCcNgEXS5jk8BNm08rAlVIkQ1uJyI+EXpnd5eiI1UBIUV8WTeA/i0myNnWptSs085GlZFUsEU1qxxL2yC6Ap9BHQDLkva5iusSI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(7696005)(41300700001)(6506007)(71200400001)(26005)(53546011)(9686003)(83380400001)(55016003)(52536014)(8936002)(8676002)(64756008)(186003)(5660300002)(478600001)(2906002)(966005)(66476007)(66946007)(66446008)(6636002)(66556008)(110136005)(316002)(86362001)(76116006)(166002)(38100700002)(99936003)(38070700005)(19627405001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9lJjrgSkvBj+lyO1LRsGfKUMoZ8zojF33CqMiDAuX5DiL8fBoN+nCCgF2J3W?=
 =?us-ascii?Q?/xXqsbVSLVrpeSxxKr4mQeas+l3PqGqokEg6tua1bUpLxN7s89aQrCL5U8aP?=
 =?us-ascii?Q?tGdGJfrjwRjaHiZdgtax8grXjiSa5fk40H8/DM9InoJ23u71ILYD/w+oZXb/?=
 =?us-ascii?Q?08Xm9hdIcHJZ2jGBN4aiKq5uNmhpOW4fchOO2PwtvTrr4U7AhJneC2sQJEIr?=
 =?us-ascii?Q?ACPxPbQQvJFTROmgxSRl4CNtqm1fn1AvK+G+8feySDbg99bUtra7UmHz5+kG?=
 =?us-ascii?Q?mC0MdKIA5C/HpUDdxvGL0JqlTFP6JladjWeXxx8/t8knE3GEltyZ6BGgv38Y?=
 =?us-ascii?Q?FfxfPkUvtIrzZVKXHydIu3RfJ/P+VEnPQWaNBanGOcNIY5oN0OQgXp/owr0M?=
 =?us-ascii?Q?ChSXoU7GNZnmWtIRdIiGSUPwgNMCpeNT97pKW/Vlut11Zyg9y4mLVemQZHzE?=
 =?us-ascii?Q?IsCTOpjCokgSquatMjK3EV1aTAntQEP7XyYqBQ+cNl7CXA84doHbCzhGwCrq?=
 =?us-ascii?Q?SjrIWs7TX7Qz3AU+85U79LnSB0ff9cZeDwIDo3axjhVa+sLSHcCXhMZ7s3y0?=
 =?us-ascii?Q?qzxCscNAU57IiRZAt3PyJbHy9b8QJ/kLwvjjpbUyBsry/SrBLTIdDzxMOcps?=
 =?us-ascii?Q?GT1BwkplXXOFQ2LKypuCg0w/r0CoTkt1oCSBnLPjuSNV5MEZXcYzEcxJjtED?=
 =?us-ascii?Q?XxL/H9DBOATdWxzWw1ZGCwQpEvM9S8w1SlzNWLvwM1KuUfOIjFRro0qRN4j4?=
 =?us-ascii?Q?CZCSim4bpEQ1aYSP/ALPFjhCUViBQR0PrWa3CKfCY55H/iFrTkrXGgrbIuWy?=
 =?us-ascii?Q?cQd4HmwMm0uI/CNI7qkH+XLSLfItYOtvJnqOQFarqQgMmxzf5ZmUi3n1NEF6?=
 =?us-ascii?Q?jzRVcoo/Af9KhkrzHnpv0icPHgPudivlTFI+gjnOUetOX3sap+iLZgxTBqRN?=
 =?us-ascii?Q?kkWe1iz7H6r7OSpeWQBHShasA/mdNQH/TiVssBV8062EXyKN80svx+SUPYKb?=
 =?us-ascii?Q?+MU4v61JnkhyQ3dyKk7MhlScVIVQCiQ+/Dh/1wwc6P0t9/EyOUL1oXRNzvri?=
 =?us-ascii?Q?io8mVmI/ml+EHXpcPrA3hAPMLCQ2zCYGVTdyMTXXjeWP9kIm+CM9/ubFG8pK?=
 =?us-ascii?Q?L4qphWfjstS/w6WJImXgZstQO5D1pcHgFCpi45yNc+5GgJ61y9sCr6Zc1P/W?=
 =?us-ascii?Q?aM+X4flc9nl9chcRwfSyGABt8xHBzWOPcgfXpBMY5QOXcHVY5CgW4o/MxTwO?=
 =?us-ascii?Q?/6RmjgVLg0ynVmnZHRP1AYMPvLjEyTFNRPM/pwvy+f28lNsJfjJM2ifBUhiH?=
 =?us-ascii?Q?M9+ZEAnSsVGoit6aHal+HaUL4chlGzdmyvldFZ/+B5COjQ/fBR+/YoQdHO1O?=
 =?us-ascii?Q?ZpCtIklWW8ypH6szwOcfeCUBXYz1JCNE20Jh5PwbPNZ4BNcv6N1QT1h+89Gm?=
 =?us-ascii?Q?kErpLh2pfxb1zxc4bh/fX3DYGY2vdPi2bT/eB2lp3fGkFCyCWrmAW2p2soz7?=
 =?us-ascii?Q?CfZTdK81c5W8OAlHYE639xEvIo9lj+xOz1Z67ac40Z1G+KbuIYkwaaGRgdLO?=
 =?us-ascii?Q?cj1S5js0YuzGuFibVIg=3D?=
Content-Type: multipart/mixed;
 boundary="_004_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f91285-b6ad-403c-40d2-08da9019201a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:04:41.2881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAEbI/ixJ/z+Fq/agy4FpLlmJ75nNmpTzSmAoTCPEMQ32csE/OWC6Je2+x/g55owvDf9iDYNtn5JbwhYyJ53Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

--_004_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_"

--_000_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

@Quan, Evan<mailto:Evan.Quan@amd.com>, @Feng, Kenneth<mailto:Kenneth.Feng@a=
md.com> can you take a look?

Thanks,

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yury Zhu=
ravlev <stalkerg@gmail.com>
Sent: Friday, September 2, 2022 1:24 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly

Hello,

During the setup, the fan manager https://github.com/markusressel/fan2go<ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.co=
m%2Fmarkusressel%2Ffan2go&data=3D05%7C01%7Calexander.deucher%40amd.com%7C09=
03d6788f924045996108da8d086ecb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637977365572428876%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DIOJR10xHaW9cUZ%=
2Fv0Q%2BZDFFQJ1pbv2dUKP0zpxK4s8M%3D&reserved=3D0> I found that my Vega56 wa=
s not working correctly. This fan manager expects what read PWM value shoul=
d be the same as you wrote before, but it's not the case. PWM value was vol=
atile, and what is more critical, if I wrote 200, after reading I saw ~70-1=
00, which is very confusing.
After that, I started reading the amdgpu driver, and how fan speed works, a=
nd I found what PWM value was calculated from RPM speed and not correct for=
 my case (different BIOS or fan configuration?).
Because it looked wrong, I started looking into different implementations a=
nd found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers =
to calculate the PWM value.
I also checked how we set PWM for Vega10 and found the same registers. Afte=
r that, I copy-pasted the function from Vega20 to Vega10, and it started wo=
rking much better. It still has some fluctuation, but as I understand, this=
 behavior is expected.

I have no in-depth information about amdgpu, and the original function may =
have been for some reason (maybe for some broken BIOS?), but I suppose some=
body forgot to backport this code after prototype implementation.

It would be my first patch here. Sorry if I skipped some procedures, will b=
e appreciated it if you help me.
Also, sorry for the patch in the attachment, I have not been using any mail=
 programs for the last six years, only web clients, and it's strange to do =
it nowadays (PRs much more common...).

Regards,

--_000_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<a id=3D"OWAAM804280" class=3D"t0qjo mention ms-bgc-nlr ms-fcl-b" href=3D"m=
ailto:Evan.Quan@amd.com">@Quan, Evan</a>,
<a id=3D"OWAAM423795" class=3D"t0qjo mention ms-bgc-nlr ms-fcl-b" href=3D"m=
ailto:Kenneth.Feng@amd.com">
@Feng, Kenneth</a> can you take a look?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yury Zhuravlev &lt;stalkerg@g=
mail.com&gt;<br>
<b>Sent:</b> Friday, September 2, 2022 1:24 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: getting fan speed pwm for vega10 proper=
ly</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Hello,<br>
<br>
During the setup, the fan manager <a href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Fmarkusressel%2Ffan2go&am=
p;data=3D05%7C01%7Calexander.deucher%40amd.com%7C0903d6788f924045996108da8d=
086ecb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637977365572428876%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIOJR10xHaW9cUZ%2Fv0Q%2BZDFFQJ1pbv2d=
UKP0zpxK4s8M%3D&amp;reserved=3D0" originalsrc=3D"https://github.com/markusr=
essel/fan2go" shash=3D"UjSl9Nnw5e3IQITVnEKtRKBWLZuRuMSOK63mD9eh5u+EVNo4m8QP=
TbngnPy8szVbIfqZeoxD5PqxHGtaZqTZu2taydhWBSXwI5lJzE9YKZQPnYmnT+v/A20MSwcPABa=
HfP6q4k1WJGuVd7LMUWyY3isUlxY6SdhKzU574e8MADY=3D" target=3D"_blank">
https://github.com/markusressel/fan2go</a> I found that my Vega56 was not w=
orking correctly. This fan manager expects what read PWM value should be th=
e same as you wrote before, but it's not the case. PWM value was volatile, =
and what is more critical, if I
 wrote 200, after reading I saw ~70-100, which is very confusing. <br>
After that, I started reading the amdgpu driver, and how fan speed works, a=
nd I found what PWM value was calculated from RPM speed and not correct for=
 my case (different BIOS or fan configuration?).<br>
Because it looked wrong, I started looking into different implementations a=
nd found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers =
to calculate the PWM value.<br>
I also checked how we set PWM for Vega10 and found the same registers. Afte=
r that, I copy-pasted the function from Vega20 to Vega10, and it started wo=
rking much better. It still has some fluctuation, but as I understand, this=
 behavior is expected.
<br>
<br>
I have no in-depth information about amdgpu, and the original function may =
have been for some reason (maybe for some broken BIOS?), but I suppose some=
body forgot to backport this code after prototype implementation.
<br>
<br>
It would be my first patch here. Sorry if I skipped some procedures, will b=
e appreciated it if you help me.
<br>
</div>
Also, sorry for the patch in the attachment, I have not been using any mail=
 programs for the last six years, only web clients, and it's strange to do =
it nowadays (PRs much more common...).
<br>
<div><br>
Regards,</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_--

--_004_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_
Content-Type: text/x-patch;
	name="0001-getting-fan-speed-pwm-for-vega10-properly.patch"
Content-Description: 0001-getting-fan-speed-pwm-for-vega10-properly.patch
Content-Disposition: attachment;
	filename="0001-getting-fan-speed-pwm-for-vega10-properly.patch"; size=1303;
	creation-date="Fri, 02 Sep 2022 17:29:17 GMT";
	modification-date="Tue, 06 Sep 2022 15:04:29 GMT"
Content-ID: <f_l7kqt3vq0>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2Ex
MF90aGVybWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdh
MTBfdGhlcm1hbC5jCmluZGV4IGRhZDNlMzc0MWE0ZS4uMTkwYWY3OWYzMjM2IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfdGhlcm1hbC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF90aGVy
bWFsLmMKQEAgLTY3LDIyICs2NywyMSBAQCBpbnQgdmVnYTEwX2Zhbl9jdHJsX2dldF9mYW5fc3Bl
ZWRfaW5mbyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogaW50IHZlZ2ExMF9mYW5fY3RybF9nZXRf
ZmFuX3NwZWVkX3B3bShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLAogCQl1aW50MzJfdCAqc3BlZWQp
CiB7Ci0JdWludDMyX3QgY3VycmVudF9ycG07Ci0JdWludDMyX3QgcGVyY2VudCA9IDA7Ci0KLQlp
ZiAoaHdtZ3ItPnRoZXJtYWxfY29udHJvbGxlci5mYW5JbmZvLmJOb0ZhbikKLQkJcmV0dXJuIDA7
CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBod21nci0+YWRldjsKKwl1aW50MzJfdCBk
dXR5MTAwLCBkdXR5OworCXVpbnQ2NF90IHRtcDY0OwogCi0JaWYgKHZlZ2ExMF9nZXRfY3VycmVu
dF9ycG0oaHdtZ3IsICZjdXJyZW50X3JwbSkpCi0JCXJldHVybiAtMTsKKwlkdXR5MTAwID0gUkVH
X0dFVF9GSUVMRChSUkVHMzJfU09DMTUoVEhNLCAwLCBtbUNHX0ZET19DVFJMMSksCisJCQkJQ0df
RkRPX0NUUkwxLCBGTUFYX0RVVFkxMDApOworCWR1dHkgPSBSRUdfR0VUX0ZJRUxEKFJSRUczMl9T
T0MxNShUSE0sIDAsIG1tQ0dfVEhFUk1BTF9TVEFUVVMpLAorCQkJCUNHX1RIRVJNQUxfU1RBVFVT
LCBGRE9fUFdNX0RVVFkpOwogCi0JaWYgKGh3bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuCi0JCQlh
ZHZhbmNlRmFuQ29udHJvbFBhcmFtZXRlcnMudXNNYXhGYW5SUE0gIT0gMCkKLQkJcGVyY2VudCA9
IGN1cnJlbnRfcnBtICogMjU1IC8KLQkJCWh3bWdyLT50aGVybWFsX2NvbnRyb2xsZXIuCi0JCQlh
ZHZhbmNlRmFuQ29udHJvbFBhcmFtZXRlcnMudXNNYXhGYW5SUE07CisJaWYgKCFkdXR5MTAwKQor
CQlyZXR1cm4gLUVJTlZBTDsKIAotCSpzcGVlZCA9IE1JTihwZXJjZW50LCAyNTUpOworCXRtcDY0
ID0gKHVpbnQ2NF90KWR1dHkgKiAyNTU7CisJZG9fZGl2KHRtcDY0LCBkdXR5MTAwKTsKKwkqc3Bl
ZWQgPSBNSU4oKHVpbnQzMl90KXRtcDY0LCAyNTUpOwogCiAJcmV0dXJuIDA7CiB9Cg==

--_004_BL1PR12MB514410A67CE80EC9C55C74C7F77E9BL1PR12MB5144namp_--
