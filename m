Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8828CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467196112D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 467196112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78D3B6ECAF;
	Thu, 18 Nov 2021 15:01:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618686ECAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 15:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU+2fhY9s42TS+SpBt2ouAcF1YNpzovOE5+G69LyjH0TQc66FuSi2oTMFVR6VkeC6ScyksVascLaZZahKthwzq8AIElFbHfbmlyOr80opBTV1c7KNDJxKEsX6lCrDtoa2VKNS9oWxDIQFPTFJfd8B3KEUr6g8vDjHFMZoVTXi6Ben8TAOHH14hGRLPcTAwOzn6ABHxgTty7WPZfwC5B5So1hAX/h8wbgUCGVui29Z/391TPg76fPvT4yG2k1r2COV+sYieN/AsOrNaBLnhMO3jhLBH0qrI2ceiQvDvguNc8/cTH/Adis9f72qZh1uQKTz2+ZvBfYMaW9apjNtmJSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ggZhlSLs/hru57JpeXRYZD/yXma9ozKMISdP15EE+0=;
 b=gcNqr3oxHd/1UtT/5331MN4pL83pnonJu7eGjrB3b4Ccs1uMZ8p9Mddo4p2rSJFA/8tZ8mZq2qbA/NLDaJFQsz6THzEX2Lz4eyMyLmTc4oQyM9IMHNRxe/WV4SWOoALAncFvRWwmWDqAVRti8Kf8Qov1jrP4euTXwRooHRwQjWtySZz88wYAZuQCVOb79eLf6Ry3vMHYMZxFVnCUglGCBXFIfZIf71e9q+jj+R7LNFmchPGejMOjgTviTzcYs/G9hZWdAifVS+ak7vcpYsV8LOCpZVF4T3Ce9ZyqwVCvdQjbYAyNGF+qesncbLTnv3tMTIdIxKkNWDBVBku4HqqEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ggZhlSLs/hru57JpeXRYZD/yXma9ozKMISdP15EE+0=;
 b=x+Kg/riXBOR4qzNisbhCEkW7pIwa5u+Qpv25r3cTixfEedqG179wK8FeC7hXuDmwCIyXKvTbreYNeYDLwhXTGv+0FibWlflX4CKfRqqachZxb5G1S6+xCFfviN1k3x7KHSzNfnZQV9z6b12LnDqFTYWpC24jL9VV2MJYQe0EfZU=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 15:01:13 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 15:01:12 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Topic: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Thread-Index: AQHX3Ep2ytL7W0AerEyKxjKe6BfViKwI7ECAgABWxQCAAA9eAIAAAPMAgAAAjwCAAADIAIAAAvYAgAAA3ACAAAe/eQ==
Date: Thu, 18 Nov 2021 15:01:12 +0000
Message-ID: <DM6PR12MB3930D33025C01706AE0F258F979B9@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
 <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
 <CADnq5_MGQ802Z-gdgfQXK_Eo2RXeE0qZ7AQUQLusez4Y3ysT5w@mail.gmail.com>
 <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
In-Reply-To: <14cd6274-c967-ba7d-71d7-ccf332c30494@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-18T14:56:15.4205244Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d378424-914a-4921-91b5-08d9aaa44347
x-ms-traffictypediagnostic: DM6PR12MB2601:
x-microsoft-antispam-prvs: <DM6PR12MB2601E7C6D009668C9D161AD6979B9@DM6PR12MB2601.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFDR53Qohcwhu8LYfu2eGumOQN2aOGemiWuhiHfZyk2e/GzHIi0I/D/3UcfDPGq93GZKvnMokDQESaTOwEOi+zN90j9EWnSBOv8ghvphXa0sIfkfwIa7DzjUvAXmBAXp/7e0ZBXhbNV0iNPQWPMOwZTEcnSbHezCjuEmxq4PEx/UHB3aNuVMXjJjNn4FVy2JF5I2Q0jk1gkAUXcSQB+ZjHVSj+L4gNaPvR6k4LHL/ijphAL/OVQEtAtnounnluD8IoVPavFyIZOc9uOlRyPj1aSLiuJgSVqjP1L904bB250gOcyZS+hv973MZX93+zGKFIstthD46jyvMv6x+/KI+RFiRQ2oG44RiyH1UZlDTpJpqQkm/yqZO8NG8gV3dJuLg1K9IYOMCWfYlgj4ldmJlqsgAa24FDlqG0G35JGh4tspn1AWINiGmDnAYW4oPHZ5snfbZcguvvVLwWZWTpfzd6fZsvXATKsHYO5VQ4s5Cz2RnnRQ44z9PN7zt6mA6PUGgfq3uMBNMwJHqY2mo4phzR9/Lopxq+SnRk5/ChqgjxQN5A0hp2DWWThcGpUpSFeT50Gum7P/GrtId8z3YMBsywhyKj9V+Te7g4WX9OPbNsFHwsPT3f10U+VgzTAbj5qohmn2+xsHX1vO9VzICMoxdLMwdcwKgsd91L9Y/zWXzH7179+B3/YI/OYGgtUTs5KE/ftw8nj4TDzgetaT2FUscw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(64756008)(33656002)(6506007)(66446008)(8676002)(71200400001)(38100700002)(6916009)(186003)(54906003)(76116006)(83380400001)(316002)(8936002)(91956017)(66946007)(9686003)(7696005)(52536014)(55016002)(508600001)(2906002)(122000001)(38070700005)(5660300002)(86362001)(15650500001)(558084003)(4326008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7SCw3oCOu5kBuE+hRBATD1BvwVvZJT4OhC7lRd6hozqeCKxH35x9DwtdCs?=
 =?iso-8859-1?Q?4UI1OxQq21GiD/ZG25+8hThTdXiie31HDKzFhzLOC8Kent4LqhkA9xL547?=
 =?iso-8859-1?Q?5etD7t6e7l4k0a9vYhJJqkr/XMDRrhjh392diQFM8JQ/70776dw76m/XPd?=
 =?iso-8859-1?Q?9CgemyJEmXx/ifkzuNvk7j2wTM+/l9+TcgjEU38yd/wbpxM473sBg0l1Ly?=
 =?iso-8859-1?Q?rGyCZzlIfA+2tfiiZhz1QmJdBrSyEs7+7N/fFRlsua3ens5L5FE8hPShm6?=
 =?iso-8859-1?Q?BmHc15OfWhH1UlL8LLBdYhrPi3BzjoZj9nBrmsmzlwq8sh5Km+OeZXTSO2?=
 =?iso-8859-1?Q?ofzt9JoIIHWvwKZVGHj2bW2tDMz4eqwySqtgR1CLlB2/b8PDwWmYGsUOOl?=
 =?iso-8859-1?Q?FRYYEyPSD18FmeugJeWeU1EJqlG97e9gNkGCglLaYeSgYlTn7rPMOukfyr?=
 =?iso-8859-1?Q?AzrNP8ThjTdTc/IY+o+G89zVA6aTaIxVF9B8DJX2azaAhn1TDjAU3KA+7e?=
 =?iso-8859-1?Q?0qvFS9bYX7vqRhyZTC+yK+ubZmmAATo5HB59BxlSS4L78vfJAIg+4zRG3N?=
 =?iso-8859-1?Q?2U7ZYGWJcrel62a4Z1mDABuvNraton4qYRCymV+1odnyOHrYijK4LuY/2q?=
 =?iso-8859-1?Q?QIGjTvbD9LKIIKE+qT3uoXU9Sg+2CtQ4ZNgtsyM0df2klrlcxBPmnQN4Ho?=
 =?iso-8859-1?Q?rYWd7v6aqAmJ0LCEnlggCqDsEM0Hv4iTtmoRTLGzWxYFK2h3Kq+GuUnlYM?=
 =?iso-8859-1?Q?V1hGwVyn2drdNoKPGqZXn2xoZAtG2he01nkNFbvTPuuTzyq2W6lXAWdr77?=
 =?iso-8859-1?Q?TMpkC8a8QsYH+uw/ax2w/8PqLR8tSHLrTaQc7IlN3P1YqRMBBTPZLXXl3k?=
 =?iso-8859-1?Q?2g86zf83I/+Efew/hcow8TXj6ItV7tNALNHo71A5Jom2W/DiujsHhT5Rly?=
 =?iso-8859-1?Q?aGwc0x5L1Zqqu5Anpe0kzh00uJvdjMLHFeRJqwu5pV9tqcQ0der92ksYFe?=
 =?iso-8859-1?Q?Od0aExhXhRSsAVaXPIljbN1JQURvZvfPqcvhGx0/FlPALnjN3umcZRR9Y1?=
 =?iso-8859-1?Q?G4cKoXGlvhoFDdOBZxz5zp5Egg2cyrHHh1p80hrI8xtjWPFatnskSFvHq5?=
 =?iso-8859-1?Q?YeQi0JIGdlLiWStLJlhaGiIbEtWqPWnAMAu0+Mp4mS8CmZ6c94Yz5SGjxR?=
 =?iso-8859-1?Q?l++cpqWvpwteTMZbKSg2Zlf9vMR3fZ2NkdGGogXD5R2El8gfGALH4C8kYp?=
 =?iso-8859-1?Q?Qqc3PPuR+DXAHY34pDURki7PjY9JA+OVE8WURl2eC6dXfPSRMn3fwLSrHM?=
 =?iso-8859-1?Q?87fvXOInxB6L92c/hncMMfb+2kSc79ubabzPN0CrvRwQDrjeYsUo7eW0rz?=
 =?iso-8859-1?Q?hNtQtxdxoKtJIEAaxX1VeIxTrl2xwIfQJixbsgtCGgR7TX7vI4q2jhsWD2?=
 =?iso-8859-1?Q?DpkypSCAqfyyHb2s7qfgY2eiwNys/554/4Osk1s+R4ayid9Pp63hjS3KF7?=
 =?iso-8859-1?Q?yh1kccxi4ivfu++iqPGfhwa7TizAOFCUJ0FINCAYxZapofCOss1ETDljlx?=
 =?iso-8859-1?Q?ZJhuZTvBhGojYjVfUBnVriDH//d+Exx9IgjRDoXSwR1t4FOn7yIwCAI514?=
 =?iso-8859-1?Q?Pts/76mGwYdtg+UfgeWVAVEJG5TQqobvUY?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930D33025C01706AE0F258F979B9DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d378424-914a-4921-91b5-08d9aaa44347
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 15:01:12.9098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8IQ7IrSDvNr0lwzz6tmS1A8bHGujmUgom5mv2QB/x0V4lqzqc6I0nR7RRtJGoOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB3930D33025C01706AE0F258F979B9DM6PR12MB3930namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

BTW, I'm not sure if 'reset always' on resume is a good idea  for GPUs in a=
 hive (assuming those systems also get suspended and get hiccups). At this =
point the hive isn't reinitialized.

Thanks,
Lijo

--_000_DM6PR12MB3930D33025C01706AE0F258F979B9DM6PR12MB3930namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
BTW, I'm not sure if 'reset always' on resume&nbsp;<span style=3D"font-size=
: 12pt;">is a good idea&nbsp; for GPUs in a hive (assuming those systems al=
so get suspended and get hiccups). At this point the hive isn't reinitializ=
ed.</span></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_DM6PR12MB3930D33025C01706AE0F258F979B9DM6PR12MB3930namp_--
