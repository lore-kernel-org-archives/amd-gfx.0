Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5CFC32771
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 01:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2069A20715
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NmIOvcLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2069A20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84296E5BD;
	Tue,  7 Jan 2020 01:23:16 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E234D6E5BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 01:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5nBIvkLx63dopIA1EpnM9NJF4D2SY4ZP99Im/WpB76pUoi1rmXrXWb08Fpg5UGQfMEFt4xOhNgrJvJ3LrkhuIW9t8Pl+KqGEbSUFoiXL71JXfrb1OfVgaIoMN76JUEG72ib6RsZKoupyhMkVv3oQRO5Cx8/j0b4RhJPhuw73etCoeuFrMZaoeM9m315/YL6pN2vnNKnDcv9Bn+6xLJSm/WolhAN2VrSEPKmCjfVlhzQmx3kY3HMBXqG2nDIhjoD2cNha9Pqp2xGD0g1+0Wbs1ElGbsa3/tGZALtKWEJq9PZN3fOFSYZekOvw/XzuixRPl2GnNB6xFD2jso3FBsX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBHT7dmQEAT08s11D5i6qqMH8az4LjbzK3ltcumhCfY=;
 b=X2YTzbtVJLtr8b/mQTdLj93ETttpYQGgXmDegXPw0uS/e4K7X+Wb7By4d1VIRbw5QzlsdPCMLgJTo01Ycctm4E9KW23h8sDixmuLTTCfEr+qWId4OvwIhxIZkR+n0YoV3RsOJh9DGfTpJFy7hWAmO9+3OUrjM1NgnoBwisRkCPU7h4mKK3JCjL5ymL+2wmOUxB3+by+JBKUsFXLf3URZFK7gcb4EG59YDzOZgrKCewOIRqcyq83iVtojBeDzdSgC4PbGRvbr7udTdoVcCU3utZSfzMi34vDGmViNw87mAx1n65nmjDagHw9XsMptF67b8Iu2ps1e4KmE0SS+LTTJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBHT7dmQEAT08s11D5i6qqMH8az4LjbzK3ltcumhCfY=;
 b=NmIOvcLUXWXXbjPRWIDvK1r/VLgz15M7JajhbxzGUyhJDM+kdIokHi4Bm3opx/GKFbT2ypEjvRzVd8R0nE0A6KsONbSQX5pTOWYmuFWHLPS75ua/Gnn6PnJCIgpCZTjYIN+qmCZr1vwbrJK3jub4OgWZlFu0VfyqRJH/erbSTZw=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (10.174.246.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 01:23:13 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845%9]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 01:23:13 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: =?iso-8859-1?Q?Martin_B=E5ngens?= <marbangens@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: Problem whit Radeon rx 590 makes games crash on Linux
Thread-Topic: Problem whit Radeon rx 590 makes games crash on Linux
Thread-Index: AQHVxMv6UCeH9go5v06EtZGxtjEFIafeYVkw
Date: Tue, 7 Jan 2020 01:23:13 +0000
Message-ID: <DM5PR1201MB2554A1700F0A5D41CC659C949E3F0@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <b4065e11-fd22-21af-8638-b33ff344304c@gmail.com>
In-Reply-To: <b4065e11-fd22-21af-8638-b33ff344304c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3459a002-9d70-4d34-27e8-08d793102a31
x-ms-traffictypediagnostic: DM5PR1201MB0218:
x-microsoft-antispam-prvs: <DM5PR1201MB0218A2C10BC0A9381E796D1D9E3F0@DM5PR1201MB0218.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(13464003)(189003)(52536014)(966005)(64756008)(66476007)(66556008)(186003)(66574012)(66946007)(76116006)(5660300002)(66446008)(8676002)(2906002)(71200400001)(33656002)(81156014)(86362001)(81166006)(7696005)(110136005)(8936002)(26005)(53546011)(9686003)(6506007)(316002)(55016002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0218;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hgz/4673FdadlnWzCPqIaRAQQ/bWBEMqcE0D0iRGv/WN2PFxvaee/NauDu9uuSun6R6Qzhci1jgjMiqz1td9Y5KonzZ1JkWpIlY/FUGSL0OOmX/8VOxjnl85JUgNJRG/IsBJ5prwUE4WdsTQOQ4L/OmOVXwKkP4rBrM4Pmgxfn5q0W4jErQgcT3Sg5Vql1Yi1g8riecELoRDiWM1L2ySRQ7Mkr/NbQIyKfKdL44JJL9NzU1b/T+E1KoZMQlbPlknXvo9GF40oWdGWNJZkLxkcatnBJUVBezwPo7o8pnrJ1/Fh970riFu8Jvaw3nEgr+xQjs5kw3W20T0DnSk9pvjiMpqn9Xeot0c5aOHYzCk99WAmknb/+rCa2u4fG8fwXDiDyTm/LYcsbm35Ga8CeNY2hF8kJSDZ+lnlS08+pJJ+8aVX/mFq/YTcesBqUE5nmefrGXjG2VTx6T1bOFeF5NDZFlG+lVUQD2SERvzOVsLx73+C8QtubqUWnL0a3TTMgLbv2AE8DxEVp8tja0zNAaPOOt8zsvEabbZIuRiDufBSPA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459a002-9d70-4d34-27e8-08d793102a31
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 01:23:13.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Al2MnW0m+TTLn6aV9WgQcepoCg//ItqrjkRA0k7PxSPwxctBPXzT7z1PaVqCWiws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi there,

Thank you for raising this question. Here are my two cents that came from m=
y own experience:

From what you mentioned in the community thread, you tried multiple kernel =
versions on vanilla Manjaro. However, it seems like you didn't upgrade any =
user-mode driver, and I suspect that's why you encountered so many problems=
 when playing games. If that's the case, you can try install the official A=
MD RX590 Linux driver: https://www.amd.com/en/support/graphics/radeon-500-s=
eries/radeon-rx-500-series/radeon-rx-590. I would recommend you use the fol=
lowing installation command: ./amdgpu-pro-install

Another possibility is, your graphics card is experiencing heat throttling =
under heavy load, and that's also a common reason why graphics cards are st=
ruggling a lot on heavy duty games. If that's the case, you can try adding =
more fans to your desktop.

Also, are you using PCI-e x8 on your motherboard? If that's the case, pleas=
e switch to PCI-e x16 to solve the bottleneck.

You could also switch to another Linux distribution (e.g. Ubuntu) and give =
it a try, though I will be a bit surprised if the issue was caused by speci=
fic Linux distribution.

Hope that helps. Should you have more questions, please feel free to contac=
t us on the mailing list.

Thanks,
Zhan

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Martin B=E5ngens
> Sent: 2020/January/06, Monday 2:34 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Problem whit Radeon rx 590 makes games crash on Linux
> =

> Hi AMD graphic driver developer for Linux!
> =

> I have problems with playing games using Linux opensource driver
> =

> I have xfx radeon rx 590 fatboy and tested with proprietary driver games =
run
> fine but too slow for playing
> =

> here is bit more info about my experience
> =

> ask me anything
> =

> =

> https://community.amd.com/thread/246894 =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
