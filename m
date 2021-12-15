Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D394C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 23:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE8810E2A8;
	Wed, 15 Dec 2021 23:58:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E13110E2A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 23:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADlOJbW7mrPXfQvillYiPDhnh6l7lb1eIg6aSXojrrqZO9PsHTuN1dVX704M/BYsawVo9v83eyxzZPxrjuWBsvoheyzxxN/1utsB+w1FtKJ07YI2SysQg2ZNQVeN/obtNgtEUiGhKpFFjcEybrrM0Ndx+GMUEBtDC+5gbFunH5QTMd0wxrH46iw/KQUUi73mwGOGW771Ti/6fKfRtFrsrT/oZLGTWmMAyQv86dBYjidmYX5pbfVqGmUhI2kJJd42UutDQ/LrRDI2GSaAEKQ+Ug393DRIzmWdwMcaYYqUjh7B0wTH/mhizHgragjcuBAwBAudrzQnus0t+YX2ENZusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E22tVFr7iUHlVkuyaozzGHSnvkdIbmH2irDzjpcwyFM=;
 b=kjACRX+c00bB87VNXdoj+CW8F50Y9RwdQtOX0lr2IK45rTUdSUEqMVfRK+U56OIwpnvPnRYXn63amulzm5l9APOKISqZSTW9PHkiMaIHsTJegqb3ib3dt6x/E54Tba8EG0KmfnISJg26n35X1N5gnUhUUf/5JkC32q0At0Qj1UzsAYCkJb6AEJ2rVQFnNXNI9Orkg/dX11OnVM3bwhDBFjJkbVpQLDCaiadvUjDc2E/Xc1GXr/t9chAoI532a+OjcN/0HjgsTNloY8U84XQ88fMpQFJoqXL02QEOTuOvwmY+9eKaFw+kGfRObwoMiQaC0w7G5cD+d6YARNfGUeW1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E22tVFr7iUHlVkuyaozzGHSnvkdIbmH2irDzjpcwyFM=;
 b=ewazBYY/BGZDQ5AC9SxrbUmjXjbdTYXYi8dfyHdET10YjXDZGYDvqulesX9J+kkjlodfld3vXEgSEMaXy0fg30YSeuAimZiHTotdCoPcEpM09igaBK9rjl32kOppGwSfwfm5oRXMnv7B+WaDY+JIJOtGFpvrhlxvo0IR46+Knb4=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Wed, 15 Dec
 2021 23:58:16 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::a10e:e3e6:7760:fd5a%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 23:58:16 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function pointers
Thread-Topic: [PATCH 4/5] drm/amdgpu: Initialize Aldebaran RLC function
 pointers
Thread-Index: AQHX8eVYbZ3Q68gxa0q6k5L3Aqw5iaw0FEcAgAAnJBA=
Date: Wed, 15 Dec 2021 23:58:16 +0000
Message-ID: <BN9PR12MB5324A5B0B87F3E80B2BCA2728B769@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
 <20211215185510.15134-5-victor.skvortsov@amd.com>
 <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
In-Reply-To: <CADnq5_OP0=TCPcMprrqFo4HxkXWsZamXkLHa25ZWPEMezM1c_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-15T23:58:13Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f7a4d5dd-24cf-4f44-9d04-24a08a63301d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-15T23:58:13Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7439e72a-b64c-437a-a9df-3b3045f5e41f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 505e8681-5461-4d78-91c8-08d9c026c30f
x-ms-traffictypediagnostic: BN9PR12MB5180:EE_
x-microsoft-antispam-prvs: <BN9PR12MB51809A1765A67CF446C27FD18B769@BN9PR12MB5180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNpY+Ujn+r7wLIQRPgcQuQ/MHWyIA/yoLGLGl7hZIQOJ3vHKx6SGghhUyjhBKOtkUqwtm4jgmt0umgB6NTuu7wfOkoLW8Mj4a6kabuQcHlbmkJtu1sTdNBbYOkIeaJK2XZBNLjwbmqQaIFzfwvKbk+SWPW2oEAkeaiHUCkrOiR0yxdZMvumf75+1AJcMSdD6IQxm+mHEbXhvTzHUXQYLByTQmMX1H9WLBVlmEbkmIH0TKUX7yWc7X3z7BJYsnmaY7Qnks81gcxzhz3t+dnIW3pj28djKj4lVXBl7+PCNB5VrFeXb1nM+GL0aAsIsb7jGi2goscQE/7GnSco72blY+ZkDGVKWjmOcgnKvg9rSN/P9aLxkGSsXwLs1jhkTZp6fJx1jvQuYPOI7CAh4su+ONpty/SPCQB/kIyvhnb81PirtlnpSLD5aW3lJQOxgQOSOwpTQDXfLLB1wearYBnhtH4Pg75hqQyCxyTMGZHUy9Dm6aIMRpQ7wZhbGw5p30XtobEoIwZTy9BLQRfy2QRVsWI41F0v7N9ixGpwbERBKzch0DpHQWsY96K/p+G0/cIqMvqd0ciwsMkg4EYCeFFGYBVn2joh1N5WOL6qYa9MByNEAvkh9AljHPjHHZ5b0++3mY5lIkt9GivDwSeLYnkQAa5IxHwv0HUyJO+e23iXTUsegYR7sNBi8Yq5g6OAPUr+F3IkqphwFHH0NpqDKG92BOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(9686003)(83380400001)(52536014)(508600001)(6506007)(53546011)(26005)(6916009)(186003)(7696005)(122000001)(5660300002)(38070700005)(71200400001)(8936002)(2906002)(33656002)(4326008)(316002)(64756008)(54906003)(66556008)(76116006)(66446008)(8676002)(66946007)(38100700002)(86362001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JER3ZJeGRWSlRYS2IyZkdQazNGNWhWTXRHR1R4TnlzLysrVjR2K1BWM05M?=
 =?utf-8?B?Mks5ZDlsWlhHbGlMMlhjeU42QlBpN1l2SjJZazd4Ylo5dmg3RVBIZ1g2MnlZ?=
 =?utf-8?B?S2hsMEUyR2dJSkxFa2NBdUVSZUthRmJJSXgzQlE1WDlISHEvYjlJeHB2NnEv?=
 =?utf-8?B?ZlRPUXBpdlo2WHFOWjgxbEROWFh4Y3RXam5Na2pIOFR5NmRXNk1RMUtFZVNj?=
 =?utf-8?B?VnFjRW5CS0lkTnFocVM2d1J2Vjg5VjFKYkNML2kreFdVdEdqRzJ2b2dneGgx?=
 =?utf-8?B?S0M1TFczT2hHaWhjQXpWSzNDcTVld09udSs3MjNvZmVDbmZWTEh5c1Jyd0o3?=
 =?utf-8?B?L1cwMGJETGMyV2E2YTJ2M214S1d1Y2xlWVFqWGRmNHIxdHQwNFN2YnhaSGZx?=
 =?utf-8?B?eWxwZVd3TWJsNG9EVXNXNEtDMDZ6Skh6QWg2UU9kSHRBb0MvYlpwSmtMYytJ?=
 =?utf-8?B?L0FGWlllenQ5RUp1Q0FTQ0tOR0VTYmkwaEI3eDNBWVhScFJGc1VVSGhFY2lI?=
 =?utf-8?B?aWZUQ05RZ1RqWFRFeC9lcmtNWnpheTMrTWVscUNBUU1FYVovOHdvbS9jQ3la?=
 =?utf-8?B?S1ZCZDJMT2RTemNSQnN2TWM3ZFA3eGYwZWpQS0lmVGxONmc1MyszSmFBR0Zu?=
 =?utf-8?B?WXNuMU11VHJQeXZBNFd4SEhZUnA3QjhwNE4vajdUSm9rNE9TSnRwRWNvbDNa?=
 =?utf-8?B?eFh5NzBTSS94ektjUTB0U3FyVEZoMDRqZmVTb084elAyRkhKZlZIQXhwY3l3?=
 =?utf-8?B?Z09ld1Byd3NOUnpkaUlSR3VJMWR3U2VxdEdMa3hnajlpK29sOFNOWWNtSStx?=
 =?utf-8?B?SGI1TEppQnJqRDRpOGh1eEFlN1A2clZkOVdBOU90eDJRR3FlMkppN01VR2J4?=
 =?utf-8?B?YTRQclRldHh5eW9zaDJSRjdVRE5ZdzJuUXZ3N3lXclhMTHN5cEFXKzVhRFZq?=
 =?utf-8?B?S0JEWTA3MW1lWTB2cTVlRlZaQ1ZLUDNsRWRUaStRK211Y0hYWVFoZDdSOXdB?=
 =?utf-8?B?TzJDeHVGeHgvL1hpV3lML1BwaVdRTjM4NFFJaHRwZlJ1cHAyRHZ1RytvTnM4?=
 =?utf-8?B?bEF0RXlMNXZYSmplekIwYUlOR2V6QjZwTmlrS3BLam80cVVvSGI2R0FISGs5?=
 =?utf-8?B?ZTI4b01Xd2lhWXVHVERna3k2UUNUUXplYzM1TEsvMWRLK3YzTk1MdXZQbklI?=
 =?utf-8?B?UTRWOWlvY3BOaEhFd3RqemRYRHBOU042bTlMdDJLbndzdHU0bmFmb1RJc1hw?=
 =?utf-8?B?aVplNVJTam5xRExrdlhwR2Y4bC9ERDZIK3dnUElETFFRZXE3M2lENXY4STJx?=
 =?utf-8?B?TzJnWXowMG1RdDdTWlhkM1lCVmhyZ01EMnh4QzZSVm9ZbnVJM0ZZVDQ2YUxV?=
 =?utf-8?B?bzZQSjgyQmp0M2NrUnZMWkRPaURQTnF3eVp4Yk1iM3BSN1dNT3dQc3U1bzcy?=
 =?utf-8?B?NkxPbW40VkJFb3ZLQnVrQkZ0ZTA2ZVNUaTEwYW4vRDRrdG5IRWpWMHJ2bnVU?=
 =?utf-8?B?UlIzR0NIK0o2ZFM4ZHBEZ1ZYMklpaGl0TkFuUFlvNzgzVHdUS0xrYWhyREln?=
 =?utf-8?B?czJQKzlZMUZ2VkFFdThtUDFGVUVzWVIwTWJYVVZuQWFKMWFtQUZ6M0JqNjZI?=
 =?utf-8?B?bGhGTTQzT2VkOVhORHRnc0lKRko4Z0JGdDZ5TFl4RWRQeTFpN1p3NGpoQUU4?=
 =?utf-8?B?R0pkRVBoSjdiTUhESTNWOE9RakEyWTBBaU8wY1didEpLeWRJeGhTSUZ0azhx?=
 =?utf-8?B?ZXpZcWNUZlU4WDFRUmhpWG9rTUNoN1d6RGhMeHVSb2F0VUlaUGVqaWtwTVlF?=
 =?utf-8?B?aXVUMlE1QzUyVmVEc3cyeFcxdno2MEh2M1dhTlV6NHd3czltL2l5QWgrV1ZC?=
 =?utf-8?B?NllISHh4S2dvVlppaTRJZkUzWEViT1hCdmdPS1JzSklrb0tRa1hXNGRZWVZw?=
 =?utf-8?B?bXhGT3B1dFhnRlVKbmRDRHJvci9UV1NpbTF6WVFqMXRBSUFEZ2VTUU43T3kr?=
 =?utf-8?B?S0I0aDNvZG5rSjJ2dHJENnozUm9NN3FWVDBLOS9SS3VXb0ExQVNxSmw0Uncr?=
 =?utf-8?B?Z0lJcjFGM3RFcS9qRW5aclNxai9xTTVFMWxCcFZ6eUV6L3hUTDJyNDVyQ3Nz?=
 =?utf-8?B?bHc1UTRXTXJPZFUxYWVqMUkwT1ltVkxveG1rNEw2amdyYWNWQmNiUWNhOU8w?=
 =?utf-8?Q?4wHoRP2TOMHsj0DWnZnIoZ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505e8681-5461-4d78-91c8-08d9c026c30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 23:58:16.0847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGpPx1lJ+2CXd9w0a/Ji6MWH/wjTkqg6WlPt4ga16XtS0AauBCpWe24AUzJph5LqAO/Vapu/HdpabDT6/kYVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Nieto, David M" <David.Nieto@amd.com>, "Chen, 
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGV5IEFsZXgsDQoNClRoaXMgY2hhbmdlIHdhcyBi
YXNlZCBvbiB0aGUgZmFjdCB0aGF0IGFtZC1tYWlubGluZS1ka21zLTUuMTMgY2FsbHMgZ2V0X3hn
bWlfaW5mbygpIGluIGdtY192OV8wX2Vhcmx5X2luaXQoKS4gQnV0IEkgY2FuIHNlZSB0aGF0IGRy
bS1uZXh0IGl0J3MgaW5zdGVhZCBjYWxsZWQgaW4gZ21jX3Y5XzBfc3dfaW5pdCgpLiBTbywgSSdt
IG5vdCBzdXJlIHdoYXRzIHRoZSBjb3JyZWN0IGJlaGF2aW9yLiBCdXQgSSBkbyBhZ3JlZSB0aGF0
IHRoZSBjaGFuZ2UgaXMga2luZCBvZiB1Z2x5LiBJIGRvbid0IGtub3cgd2hlcmUgZWxzZSB0byBw
dXQgaXQgaWYgd2UgZG8gbmVlZCB0byBjYWxsIGdldF94Z21pX2luZm8oKSBpbiBlYXJseV9pbml0
Lg0KDQpUaGFua3MsDQpWaWN0b3INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwg
RGVjZW1iZXIgMTUsIDIwMjEgNDozOCBQTQ0KVG86IFNrdm9ydHNvdiwgVmljdG9yIDxWaWN0b3Iu
U2t2b3J0c292QGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz47IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBMaXUsIE1vbmsg
PE1vbmsuTGl1QGFtZC5jb20+OyBNaW5nLCBEYXZpcyA8RGF2aXMuTWluZ0BhbWQuY29tPjsgTGl1
LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgWmhvdSwgUGVuZyBKdSA8UGVuZ0p1Llpo
b3VAYW1kLmNvbT47IENoZW4sIEppbmdXZW4gPEppbmdXZW4uQ2hlbjJAYW1kLmNvbT47IENoZW4s
IEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IE5pZXRvLCBEYXZpZCBNIDxEYXZpZC5OaWV0
b0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCA0LzVdIGRybS9hbWRncHU6IEluaXRpYWxp
emUgQWxkZWJhcmFuIFJMQyBmdW5jdGlvbiBwb2ludGVycw0KDQpbQ0FVVElPTjogRXh0ZXJuYWwg
RW1haWxdDQoNCk9uIFdlZCwgRGVjIDE1LCAyMDIxIGF0IDE6NTYgUE0gVmljdG9yIFNrdm9ydHNv
diA8dmljdG9yLnNrdm9ydHNvdkBhbWQuY29tPiB3cm90ZToNCj4NCj4gSW4gU1JJT1YsIFJMQyBm
dW5jdGlvbiBwb2ludGVycyBtdXN0IGJlIGluaXRpYWxpemVkIGVhcmx5IGFzIHdlIHJlbHkgDQo+
IG9uIHRoZSBSTENHIGludGVyZmFjZSBmb3IgYWxsIEdDIHJlZ2lzdGVyIGFjY2Vzcy4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogVmljdG9yIFNrdm9ydHNvdiA8dmljdG9yLnNrdm9ydHNvdkBhbWQuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3Zlcnku
YyB8IDIgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICAgICAg
ICB8IDMgKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5oICAgICAg
ICAgfCAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kaXNjb3ZlcnkuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlz
Y292ZXJ5LmMNCj4gaW5kZXggNjVlMWY2Y2M1OWRkLi4xYmM5MmEzOGQxMjQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gQEAgLTg0
NCw2ICs4NDQsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9kaXNjb3Zlcnlfc2V0X2djX2lwX2Jsb2Nr
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04o
OSwgNCwgMSk6DQo+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDIpOg0KPiAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2RldmljZV9pcF9ibG9ja19hZGQoYWRldiwgJmdmeF92OV8wX2lwX2Js
b2NrKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRl
di0+aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0gPT0gSVBfVkVSU0lPTig5LCA0LCAyKSkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZ2Z4X3Y5XzBfc2V0X3JsY19mdW5jcyhhZGV2KTsNCg0KYW1k
Z3B1X2Rpc2NvdmVyeS5jIGlzIElQIGluZGVwZW5kZW50LiAgSSdkIHJhdGhlciBub3QgYWRkIHJh
bmRvbSBJUCBzcGVjaWZpYyBmdW5jdGlvbiBjYWxscy4gIGdmeF92OV8wX3NldF9ybGNfZnVuY3Mo
KSBhbHJlYWR5IGdldHMgY2FsbGVkIGluIGdmeF92OV8wX2Vhcmx5X2luaXQoKS4gIElzIHRoYXQg
bm90IGVhcmx5IGVub3VnaD8gIEluIGdlbmVyYWwgd2Ugc2hvdWxkbid0IGJlIHRvdWNoaW5nIHRo
ZSBoYXJkd2FyZSBtdWNoIGlmIGF0IGFsbCBpbiBlYXJseV9pbml0Lg0KDQpBbGV4DQoNCj4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMSwgMTAp
Og0KPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMSwgMik6DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gaW5kZXggZWRiM2UzYjA4ZWVkLi5kMjUyYjA2ZWZh
NDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiBAQCAtODE2
LDcgKzgxNiw2IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NyaW92X3dyZWcoc3RydWN0IA0KPiBh
bWRncHVfZGV2aWNlICphZGV2LCB1MzIgb2Zmc2V0LCAgc3RhdGljIHZvaWQgDQo+IGdmeF92OV8w
X3NldF9yaW5nX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsgIHN0YXRpYyB2b2lk
IA0KPiBnZnhfdjlfMF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsg
IHN0YXRpYyB2b2lkIA0KPiBnZnhfdjlfMF9zZXRfZ2RzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpOyAtc3RhdGljIHZvaWQgDQo+IGdmeF92OV8wX3NldF9ybGNfZnVuY3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOyAgc3RhdGljIGludCBnZnhfdjlfMF9nZXRfY3VfaW5mbyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2N1X2luZm8gKmN1X2luZm8pOyAgDQo+IHN0YXRpYyB1aW50NjRf
dCBnZnhfdjlfMF9nZXRfZ3B1X2Nsb2NrX2NvdW50ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgDQo+
ICphZGV2KTsgQEAgLTcwNjYsNyArNzA2NSw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8wX3NldF9p
cnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAgYWRldi0+Z2Z4
LmNwX2VjY19lcnJvcl9pcnEuZnVuY3MgPSANCj4gJmdmeF92OV8wX2NwX2VjY19lcnJvcl9pcnFf
ZnVuY3M7ICB9DQo+DQo+IC1zdGF0aWMgdm9pZCBnZnhfdjlfMF9zZXRfcmxjX2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiArdm9pZCBnZnhfdjlfMF9zZXRfcmxjX2Z1bmNzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgew0KPiAgICAgICAgIHN3aXRjaCAoYWRldi0+
aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0pIHsNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oOSwg
MCwgMSk6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5oIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmgNCj4gaW5kZXgg
ZGZlOGQ0ODQxZjU4Li4xODE3ZTI1MjM1NGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuaA0KPiBAQCAtMjksNCArMjksNiBAQCBleHRlcm4gY29uc3Qgc3RydWN0IGFt
ZGdwdV9pcF9ibG9ja192ZXJzaW9uIA0KPiBnZnhfdjlfMF9pcF9ibG9jazsgIHZvaWQgZ2Z4X3Y5
XzBfc2VsZWN0X3NlX3NoKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1MzIgc2VfbnVtLCB1
MzIgc2hfbnVtLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgaW5zdGFuY2UpOw0K
Pg0KPiArdm9pZCBnZnhfdjlfMF9zZXRfcmxjX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KTsNCj4gKw0KPiAgI2VuZGlmDQo+IC0tDQo+IDIuMjUuMQ0KPg0K
