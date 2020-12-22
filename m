Return-Path: <SRS0=THln=F2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBBC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 06:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D70423120
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Dec 2020 06:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D70423120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0A46E0D0;
	Tue, 22 Dec 2020 06:17:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E3C6E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Dec 2020 06:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLbdRNxqyL3DqoGylDTJrGEdGLInEL+SU/F5iZQTyDVlC51SIazljBWkNofHSOotY8asaCzbFWyZ+AeKbTozskd0ZqfPJTMH34Kzqf/dhziA/UeaYI+CMaeQqlRVgV5vDo9tAnpaagLXmTY+YinUyRko0cf7Wtg/klCelj0e1ZUo+izwaw4bV5kqmnpmIYMlfr7u8VFJSYMc12SogZS4cznWczfb6ZC+Mq1F8GtwtjRoF5Hlm2GrJV9yP3vuvBgZVdFCQh48V/0JCc6OPTSna8pcT1hxleRR+5jrUqNnyYmroTMHURAZUePiNVjSfFmLv3l9rmZVHtkDoujY717XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQxMarD5KiIvWzJzsFkePYTN0nAkhIffq41cGjhOuiQ=;
 b=hSxs1+YXauwDbZxqc05MZ9FGFow+4gL8Vga7Rc93eBo/dtUlvRyrQb8JfziyTtZ6JGiJwbdmLGuVGfH3sqKQYmpEz6FQDjWPyeS2ss+w+UO+ASewHfcqyth4PlnAbRTjppOvBm5zHW2GRl6hExk94fkUslQAJWgAJG9TjuYwI4pS+8zcfyMy83wTzU4mGg6FYSsGVZcgMsJqD3edeDWGeKH/XNFSDyYVvCP3l8DOqt1ojtMgDlo0KcrajucUQhKPy1VywRwNGzw5jyLzetpaBXSsCJD5ccrYjvhAyTYDsy6/NjphXOpZ2hsnImvgvvheIB+QbOEvlFhFU+IL5NhByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQxMarD5KiIvWzJzsFkePYTN0nAkhIffq41cGjhOuiQ=;
 b=TeVlNGG6s8z80v5qntC5xG2/zn/ee5GxBIVFplfh9fYulmmUD7Y0scbMoyph5/eGWGDTaTkh0TH2YsrBzlNyH4auxCwee0TYsuGjvoScvJmHtO1Gi0z0peqp1Tay5LyxCkByaVWH0/GFrUhE8oB/vrRx6M5sEXfwYxc39DKKp5o=
Received: from DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25)
 by DM5PR12MB2392.namprd12.prod.outlook.com (2603:10b6:4:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Tue, 22 Dec
 2020 06:17:24 +0000
Received: from DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::4109:2abb:d4b0:b835]) by DM6PR12MB3097.namprd12.prod.outlook.com
 ([fe80::4109:2abb:d4b0:b835%6]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 06:17:24 +0000
From: "Bridgman, John" <John.Bridgman@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [amdkfd] where are AQL packets processed after writing the
 userspace doorbell
Thread-Topic: [amdkfd] where are AQL packets processed after writing the
 userspace doorbell
Thread-Index: AQHW2CEhqevTb/JsmECxx0Y1U8wPSqoCovoy
Date: Tue, 22 Dec 2020 06:17:23 +0000
Message-ID: <DM6PR12MB30970CC786EBCB9C721B9F2DE8DF0@DM6PR12MB3097.namprd12.prod.outlook.com>
References: <CAGztBWW964hgRAMsdJvY3WFFHeE7wKG5um0iFqDbuS2n=4Cd3g@mail.gmail.com>
In-Reply-To: <CAGztBWW964hgRAMsdJvY3WFFHeE7wKG5um0iFqDbuS2n=4Cd3g@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-22T06:17:23.119Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.139.202.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2d389a7-ba9e-495e-f285-08d8a6413f76
x-ms-traffictypediagnostic: DM5PR12MB2392:
x-microsoft-antispam-prvs: <DM5PR12MB2392ACB0806A74250E31114EE8DF0@DM5PR12MB2392.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+1K+NSlnzczazMUzOWnJqN30WLf/jpYT+PpQ5FSQ4A3Al6aLSk1Fwvilg7aUkJz/uISedkJ0AtV15A/gP4QUq6PfjGicJWU9QKoTaQNwGCMFqnOwH1im3ibAOhPjvzCUe6a2vBJ3AgBazQ/LKFm7mW2NZLroVFGNnf9niIVBsHqglvNPG2kWyGeptR6mde8q2dwBN75Pe0wHHXodHQ31Elxuz68Iho/fUqXF5EtLB7ABxc0+2Yyo9pQWSylNnLXygK5uMd2OLW5GKzca2BY0+uf19xeLgapgDpC7vG3loDymwFYaoratwb9Pbd0npGvfWFdKjiDeH29kMSg1+Pk8+RsjtuW7Qn2VYneM4zdZRMUjIu2WiQ4SoTj8HaPaFSl5CTBw13wz/UhEBzZU0UgRQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3097.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(7696005)(5660300002)(8936002)(6506007)(6916009)(8676002)(19627405001)(66556008)(66446008)(83380400001)(64756008)(66476007)(2906002)(9686003)(91956017)(55016002)(52536014)(76116006)(66946007)(26005)(4744005)(33656002)(478600001)(186003)(86362001)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?NhFSNfro2tY2gkkHmvJJqCZzB93Xfmm8pCKNP+1oezNVItTJ7gcWuyQPLU?=
 =?iso-8859-1?Q?j5kFzLhJ6+hEOWvH+fphi2YIk0ARET55nThG8HgMi7rTgF4YA7m8I+iVgD?=
 =?iso-8859-1?Q?S/g/fvhe+kTy1iMWLkAeTq7du70VDtIDZ7WhaS/cac8KlhrV2hmZ53iYoU?=
 =?iso-8859-1?Q?ri+rtTgKaUHy9XqGqHFIM+sFv5tCTJ7wG4HUYF9fmBrY7oaESl+0eNwC5l?=
 =?iso-8859-1?Q?0h7ywRPk//PrQSjmM7/ZEZzDbu1pkg7JklOj6WSy2chquboVKte+fqY3l1?=
 =?iso-8859-1?Q?Do4qb0as2GTeC07Wm2Tg/Dr3t9+9bOhOCk3dO1mM+qmTMU+bsCrZ4RZTwc?=
 =?iso-8859-1?Q?QTM2vDX0eHteySIDzA8pdI8PlGUm0m6sFvNSX8XXeaSUOBVRYs2HqPmHvB?=
 =?iso-8859-1?Q?Bjvu5hbfDYZ+P7ZfwSwc+DSGyojFzxi7NFB2buqjVzgLNHF8vx9AawuISe?=
 =?iso-8859-1?Q?kg2DUiBLDuhp4RW6GAkGbAXts5IiQ7gdIGlXbgpmS9suaMap6y+KC0Je9s?=
 =?iso-8859-1?Q?/AXAK/E7dRlpvMxfdvys8QiiVF1IqE3Ip4m8gw1V5rP9LCKwyv4i7NmQIg?=
 =?iso-8859-1?Q?OuJjaHFfm3aGpLU1m/gBpQr7WfGtpsHe9LkKLU+6c044NXiONAqr0ZhiG2?=
 =?iso-8859-1?Q?H6/gmMSGQlLnTZnm4vR/zOyavW239JPWnLwfmAkeg6+nWYq7+4M4ESGbPn?=
 =?iso-8859-1?Q?vtMGBCsIQTw3zkuLnQTmuKABEYIWkO8msx7MHjgpESQEK3dEeN0oR8gUlZ?=
 =?iso-8859-1?Q?xOLLP0KrTfXtnZGDQyTGKGPPQelf6QzsO+CxUV/yM3EgpR7+V+7EV7/AZz?=
 =?iso-8859-1?Q?JegsAaaR2/Te6n/yW9S3WhPCv55GSwql5tWB38QheMoWSKH5aMNwwx5Kae?=
 =?iso-8859-1?Q?tfR11Z3ERTj7QFOC54xOLXNP0pTaoJxLyDO+X7pIuOaIPC7oI4/vUx99Fk?=
 =?iso-8859-1?Q?PcMXGmsEaqcw+kvLjJKUVeBceHlOX4LmIkG0AUAP85Aj5rmZw8+d1XwsfA?=
 =?iso-8859-1?Q?McAAGCuEXKUj0bwHs=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3097.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d389a7-ba9e-495e-f285-08d8a6413f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 06:17:23.7711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KShHChkFhph0UXmCcuCxuXg5kSiTA/Vf7MSg7N++P0KtryZ+38JaK8OKtCeINDMoPnrp+5G7OdynCk1G4LHC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2392
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
Content-Type: multipart/mixed; boundary="===============0944008768=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0944008768==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB30970CC786EBCB9C721B9F2DE8DF0DM6PR12MB3097namp_"

--_000_DM6PR12MB30970CC786EBCB9C721B9F2DE8DF0DM6PR12MB3097namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

>Hi! I noticed that the AQL packets are more concise compared with PM4 pack=
ets. It seemed that AQL packets need more post-processing than PM4 packets.
>I was wondering where the AQL packets are processed, such like calculating=
 the code address using code_entry_offset, resetting packets' headers into =
INVALID, and writing values to the completion signal when finished.
>Are all these operations done by the firmware?

Yes, these operations are performed entirely by MEC firmware.

There were special cases (eg certain debug scenarios) where we used a "soft=
 AQL" layer in the ROC runtime which interpreted AQL packets and translated=
 them into a series of PM4 packets, but I don't believe that mechanism is u=
sed any more. It was never used during normal processing anyways.

--_000_DM6PR12MB30970CC786EBCB9C721B9F2DE8DF0DM6PR12MB3097namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div>
<div>
<div dir=3D"ltr">&gt;Hi! I noticed that the AQL packets are more concise co=
mpared with PM4 packets. It seemed that AQL packets need more post-processi=
ng than PM4 packets.&nbsp; &nbsp;
</div>
<div dir=3D"ltr">
<div>&gt;I was wondering where the AQL packets are processed, such like cal=
culating the code address using&nbsp;code_entry_offset, resetting packets' =
headers into INVALID, and writing values to the&nbsp;completion&nbsp;signal=
 when finished.&nbsp;</div>
<div>&gt;Are all these operations done by the firmware? <br>
</div>
<div><br>
</div>
<div>Yes, these operations are performed entirely by MEC firmware. <br>
</div>
<div><br>
</div>
<div>There were special cases (eg certain debug scenarios) where we used a =
&quot;soft AQL&quot; layer in the ROC runtime which interpreted AQL packets=
 and translated them into a series of PM4 packets, but I don't believe that=
 mechanism is used any more. It was never
 used during normal processing anyways.<br>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB30970CC786EBCB9C721B9F2DE8DF0DM6PR12MB3097namp_--

--===============0944008768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0944008768==--
