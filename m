Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895D9C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 11:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10DAC10E32D;
	Tue,  6 Jun 2023 11:43:13 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC21410E32D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 11:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvedT8RsqSmRyWggdG2YNKg11ZoFyw/aHkrckTJDajVKCAK8EiA2Qco60RIHxRSX3rTanAAynb9dUf4e2PIm9bAM4c3Q/Sknwd245y7z9ZK31IC4o3yoOKBcADY9vXzft2UXh6Yjll5R+x8ufEwT8IE4GY9MQpT3uEbS/h0/xVyRxW+xdzWqZyJNACpSWp1HbgvHygeWqnBS1hAWIHQVfy7dcI4C8CwBk+6bs9S+jsxILCTEylmql0Uua5zbkTxu7xuQrgP4YCo1m8WguLHcr9ocMk3nnOp/6pE5bwbPXA5S9VER7fm2pz94KsNpNt2c5RND+YekoZDDC2q9QImC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVXQLhvi9Tp6/3UGD7Q7lQ+VDGMNpJj+dHTVSIVWQ3E=;
 b=fAPuvYMcZf3qcptcYcwnWISLGTMTcJ9rEkDGlgRzg9YSDNaeUvUCjwHY/6iccamvmI4f57hlSqiS1nLKNS+vg6i7CVml93jRVSYd9ZjizLehKCavHhwNb2D8Fcb2592jr7hYotLTaJNl7cKQlTnZnMuJb+kr+eiQTc4nKxKtCBNiwdhzBT00M1NjGgcFEsWrKcUrsx1ZXwa1y7r4peEbZstdGV+DQmotT26v4P/zS+L9wf+O4NZtaF3vDT4uG7YeZSOkhFEeeUkpxaF/F0dcicMTOZPn8qAi3Jy+5zCN9fkTRTXWBskELynv9RqIfPIoVK1ngzq8c5BqBuXmnj/yZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVXQLhvi9Tp6/3UGD7Q7lQ+VDGMNpJj+dHTVSIVWQ3E=;
 b=LzPuKaQ9SO+taYKKTb99TCaPLHQcy3aa98U5BrVNFbtj2nuKpYoZU0CNsOePxko4K4k5LHXiKSGsY+TkiGZpb5Nj5sraDUB9TwDcGQf8UkbWbYJeaogMLKAOY2Arx5lJcTw2lOocYu7r99ymApr+Sep+hwIXVDv+1Fqy3p4qSrs=
Received: from DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) by
 IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 11:43:06 +0000
Received: from DM4PR12MB5962.namprd12.prod.outlook.com
 ([fe80::75a:ac80:f289:b987]) by DM4PR12MB5962.namprd12.prod.outlook.com
 ([fe80::75a:ac80:f289:b987%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:43:06 +0000
From: "Haehnle, Nicolai" <Nicolai.Haehnle@amd.com>
To: "StDenis, Tom" <Tom.StDenis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves
Thread-Topic: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves
Thread-Index: AQHZmFfEN5O7uAPDYkaWDMv9UD7WCq99pPyAgAACMCI=
Date: Tue, 6 Jun 2023 11:43:05 +0000
Message-ID: <DM4PR12MB596299B2072C2CBAECCA4DBFFF52A@DM4PR12MB5962.namprd12.prod.outlook.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
 <20230606091725.20080-3-nicolai.haehnle@amd.com>
 <DM6PR12MB3547B7F9185933940A358A92F752A@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547B7F9185933940A358A92F752A@DM6PR12MB3547.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-06T11:43:04.327Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5962:EE_|IA0PR12MB7775:EE_
x-ms-office365-filtering-correlation-id: d1047643-0f29-4622-c2b6-08db66833169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYqbBvYiZvQq9XCp+jK6lprhk83xvfOBT0aU9L0MNutifz3c8/fzl38kuZlfH9LpkiLNF5tjG2fxRf4lIE+5EJ97TX8vhnf0osXh4PkI/hIRtJgH0ayXVYdBe96Y3qXcaEspIelSmvvdOB+M7fb8j67DGidiYWTm/+GpCWbhp+eSSyf8wEj4iGba9Bya7xebfqwWTZVM5TRYu2mZyQByHYS6rbOB0OZ57KvYLkraMP7z8zFVS/dCCvmcID8ORWj4uI0yjlKBNeN3n7havsIgNYoBcV5DOzy0eL5/S3DUjds9NZbvA0zfA9xVzI+eMGv3K1VcdMwortqyX3293jNhCK6PDdt1iS8mKKAbT+UEP0UZa4WtuXge0i7CopzixQgb4gOWG0hDZXzdoQpZOYQQCdMbIpHa1PjBaInScsxdicssoVLsoLxJtBS+Y6qkhhcweQlQbEVW8vynOMmTSEXRhYz8d6VPIzqAV92+YZfMlOv5An213Q1WunscsvK7K+izfLueuWDMTVy2wnEL0yg/2+61Gd/PBp1/uDY47Twv/XPCCYpeOQvKtcmpvfGOs2Efc/Eak5jnzE/bEFrxmTbEQ7/znlQAgeDCokR5o8qJCUAf23rlRbwWdYMuVWEU24JC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(110136005)(2906002)(38070700005)(71200400001)(33656002)(478600001)(86362001)(52536014)(38100700002)(41300700001)(8676002)(5660300002)(8936002)(55016003)(316002)(64756008)(66556008)(66476007)(91956017)(66946007)(122000001)(76116006)(83380400001)(19627405001)(66574015)(66446008)(6506007)(9686003)(53546011)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bBnewk96sSN0n3VzOs+6q6HhOiREy+1gn4ECQFvaNzTokLYN9PrY6gbiEX?=
 =?iso-8859-1?Q?ioh5IvfO4/8jcKVhYUwOyWzggjv9gGjo1occSYc1qHsiwwkjXMFiyYxknx?=
 =?iso-8859-1?Q?yAI61vZBU95lyp1BFI8O/Xko9yrbsPO7l1maWSLTk701iUB+8uGWMa/E4E?=
 =?iso-8859-1?Q?/q25YGMQMpUX5OZKSf+hFaJSZpV6dxEjNMPxushsvoFpF8k677LIrhYn0q?=
 =?iso-8859-1?Q?3GF+oaYopVPXlA3t9pMo/N5a7AcNomo4gKNvS1mKPkIYo4yFOKLAZaYwoV?=
 =?iso-8859-1?Q?CZdUTzD7k4g+PUdVekbTj+8MEhFVqh6FgdpcazcOHNEubg5abY+a69jij8?=
 =?iso-8859-1?Q?IM0kQ/eAXZMor1E8u0/AMBNrqZzO4Ghux5ZD674zmXbmKhtiYB9RYhfd52?=
 =?iso-8859-1?Q?RkbdStoiCXjA1jcGi//dRTKr3EOovUR73TrR0YssqxZlOnmOke3VG6/CxW?=
 =?iso-8859-1?Q?R4aE3EeGTy9GPh6xc/ISA03bwLI1F+5crvA+i+8mM3/xQIlXWr7Sf1XAWt?=
 =?iso-8859-1?Q?yU7WUlBk3Ghk7fFh70j2a7Pa3+TaFVAF3eHk0pBz8aXbPYYfoUFnJsLY72?=
 =?iso-8859-1?Q?Z7bpZiWCqWT42axv7Wba9SpmRuxQuQ01gBgG3rx6QdAQyrA0YopoJ69oHY?=
 =?iso-8859-1?Q?I1gZZL3GC6OK1T3hpRmxsA2SQaNZi+YH7TjIHahCBvtg8EiL2ZidZ5IyTn?=
 =?iso-8859-1?Q?6UCdgPT6Wp4DOjuXsjI0NLLEzMsiM35AJhVftWxvJ0CAUmgn9qEDf5Q3tx?=
 =?iso-8859-1?Q?0LP87ksanqug8ouAjpp/5ziZ2ig0ubOXEqd2MgpDs2R3/IyM80PI6fnnb1?=
 =?iso-8859-1?Q?cS29xCoRs5jgqLoIXwqihoyJwIqBRtdjEqleI3jFCJlUG2YaIfB4xPxXub?=
 =?iso-8859-1?Q?0ZIacIq/XOzQGjiNJCheyrtpuVinSUKS7eIuHXa+3FdSHtuk9n7P1wKYuO?=
 =?iso-8859-1?Q?uKp6LfdftO2ABQIjqsrwPXDoJO/zHoMaOkF4WRP23ZjFxcTxuzEvwcV+3h?=
 =?iso-8859-1?Q?QXR9Wm+5Vo6BdE6HJ1wLO2HbJ/k9QEVsq0HNfFk9w6jXIilWXBD1zfHxnp?=
 =?iso-8859-1?Q?NFrBY/NfO9wjVt+YHmsxAXrOZCfXYxpmIrhml68n9txsi6LPhKOIMStMeq?=
 =?iso-8859-1?Q?jlLgK3ExxgYKoXJWhkHbE78V4nteV5V/nFTKICVLy8Lh4KAmOj/CNG01nI?=
 =?iso-8859-1?Q?5kVMVfQt8unjYayyMhEW6aMiSww0K5558LrPnJsIoMLH9ZfvTilCWKXBCi?=
 =?iso-8859-1?Q?pWoeCf7osDlTeESHYTY5syoHsNlRH/z/BHdNclynVm4MAdntFZ6KlNzPkx?=
 =?iso-8859-1?Q?NZ2s+StMHFJalgwadytE61G9rZH3bBrkNQrbferKWvYGzgwT4L8lhj5ulo?=
 =?iso-8859-1?Q?CG/3ciOoEbvLwnbudKyE7Phelf7uLFAkqNSHytIFVZ67oj4WThYGTleN2f?=
 =?iso-8859-1?Q?z7hzTgUvgDyqcuSF+P5pzkNL1dubJzwE2pOtIqSVAChpwDnjPSWxFOC5l5?=
 =?iso-8859-1?Q?VNI+mOy9Pjk8zMmKNCjRq/W77AaL8XYGu65ncAKktoWF6zzcMixcGO1cCX?=
 =?iso-8859-1?Q?N+0+DUTw0jC4Itv+0W+MjX9I7HHsivfC6l00+mckPdzDDqYoYcMmizMq4E?=
 =?iso-8859-1?Q?J58ad+n0VC8MQXpXkvxShp8K4oM2LLDYvK17TWJ2ZoZerhQCmFkcvDdKaN?=
 =?iso-8859-1?Q?zE+TjgrCQdJNWYRgRA8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB596299B2072C2CBAECCA4DBFFF52ADM4PR12MB5962namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1047643-0f29-4622-c2b6-08db66833169
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:43:05.8500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jj6IaWPumdW3yzSJxaSvT+OW/X7rdjN8zlZppWIQZWSH6cy1d3qrwbqgY51ZiH7FNF5RhOibrZBFItFsKfRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

--_000_DM4PR12MB596299B2072C2CBAECCA4DBFFF52ADM4PR12MB5962namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]


This shouldn't be necessary as it tries both mm and then reg...

Yeah I know, but it just seemed cleaner that way...
________________________________
From: StDenis, Tom <Tom.StDenis@amd.com>
Sent: Tuesday, June 6, 2023 13:34
To: Haehnle, Nicolai <Nicolai.Haehnle@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_wav=
es

[Public]

This shouldn't be necessary as it tries both mm and then reg...


________________________________________
From: Haehnle, Nicolai <Nicolai.Haehnle@amd.com>
Sent: Tuesday, June 6, 2023 05:17
To: amd-gfx@lists.freedesktop.org; StDenis, Tom
Cc: Haehnle, Nicolai
Subject: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves

Signed-off-by: Nicolai H=E4hnle <nicolai.haehnle@amd.com>
---
 src/lib/sq_cmd_halt_waves.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/lib/sq_cmd_halt_waves.c b/src/lib/sq_cmd_halt_waves.c
index 368e701..841b1d3 100644
--- a/src/lib/sq_cmd_halt_waves.c
+++ b/src/lib/sq_cmd_halt_waves.c
@@ -36,21 +36,22 @@ int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum u=
mr_sq_cmd_halt_resume mod
        uint32_t value;
        uint64_t addr;
        struct {
                uint32_t se, sh, instance, use_grbm;
        } grbm;

        // SQ_CMD is not present on SI
        if (asic->family =3D=3D FAMILY_SI)
                return 0;

-       reg =3D umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->opti=
ons.vm_partition, "mmSQ_CMD");
+       reg =3D umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->opti=
ons.vm_partition,
+                                                 asic->family >=3D FAMILY_=
GFX11 ? "regSQ_CMD" : "mmSQ_CMD");
        if (!reg) {
                asic->err_msg("[BUG]: Cannot find SQ_CMD register in umr_sq=
_cmd_halt_waves()\n");
                return -1;
        }

        // compose value
        if (asic->family =3D=3D FAMILY_CIK) {
                value =3D umr_bitslice_compose_value(asic, reg, "CMD", mode=
 =3D=3D UMR_SQ_CMD_HALT ? 1 : 2); // SETHALT
        } else {
                value =3D umr_bitslice_compose_value(asic, reg, "CMD", 1); =
// SETHALT
--
2.40.0


--_000_DM4PR12MB596299B2072C2CBAECCA4DBFFF52ADM4PR12MB5962namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div>
<blockquote class=3D"userQuote" style=3D"border-left: 3px solid rgb(200, 20=
0, 200); padding-left: 1ex; margin-left: 0.8ex; color: rgb(102, 102, 102);"=
 itemscope=3D"" itemtype=3D"https://schemas.microsoft.com/QuotedText">
This shouldn't be necessary as it tries both mm and then reg...</blockquote=
>
<br>
</div>
</div>
Yeah I know, but it just seemed cleaner that way...<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> StDenis, Tom &lt;Tom.=
StDenis@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 6, 2023 13:34<br>
<b>To:</b> Haehnle, Nicolai &lt;Nicolai.Haehnle@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH umr 02/17] Use the correct prefix for Navi3 in h=
alt_waves</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
This shouldn't be necessary as it tries both mm and then reg...<br>
<br>
<br>
________________________________________<br>
From: Haehnle, Nicolai &lt;Nicolai.Haehnle@amd.com&gt;<br>
Sent: Tuesday, June 6, 2023 05:17<br>
To: amd-gfx@lists.freedesktop.org; StDenis, Tom<br>
Cc: Haehnle, Nicolai<br>
Subject: [PATCH umr 02/17] Use the correct prefix for Navi3 in halt_waves<b=
r>
<br>
Signed-off-by: Nicolai H=E4hnle &lt;nicolai.haehnle@amd.com&gt;<br>
---<br>
&nbsp;src/lib/sq_cmd_halt_waves.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/lib/sq_cmd_halt_waves.c b/src/lib/sq_cmd_halt_waves.c<br>
index 368e701..841b1d3 100644<br>
--- a/src/lib/sq_cmd_halt_waves.c<br>
+++ b/src/lib/sq_cmd_halt_waves.c<br>
@@ -36,21 +36,22 @@ int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum u=
mr_sq_cmd_halt_resume mod<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t se, sh, instance, use_grbm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } grbm;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // SQ_CMD is not present on SI<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic-&gt;family =3D=3D FAMIL=
Y_SI)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D umr_find_reg_data_by_ip_by_in=
stance(asic, &quot;gfx&quot;, asic-&gt;options.vm_partition, &quot;mmSQ_CMD=
&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D umr_find_reg_data_by_ip_by_in=
stance(asic, &quot;gfx&quot;, asic-&gt;options.vm_partition,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asic-&gt;f=
amily &gt;=3D FAMILY_GFX11 ? &quot;regSQ_CMD&quot; : &quot;mmSQ_CMD&quot;);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!reg) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; asic-&gt;err_msg(&quot;[BUG]: Cannot find SQ_CMD register i=
n umr_sq_cmd_halt_waves()\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // compose value<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (asic-&gt;family =3D=3D FAMIL=
Y_CIK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; value =3D umr_bitslice_compose_value(asic, reg, &quot;CMD&q=
uot;, mode =3D=3D UMR_SQ_CMD_HALT ? 1 : 2); // SETHALT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; value =3D umr_bitslice_compose_value(asic, reg, &quot;CMD&q=
uot;, 1); // SETHALT<br>
--<br>
2.40.0<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB596299B2072C2CBAECCA4DBFFF52ADM4PR12MB5962namp_--
