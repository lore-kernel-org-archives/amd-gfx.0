Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E670C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 02:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC2810E4F3;
	Wed,  1 Jun 2022 02:20:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D2E10E4F3
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 02:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwVD7u8ji+h40OEHQYOs1arlBWSP+Purt6SkOOfN/00KSo4VDewbBzLsPMKRchmMFqLuSIUlUA5bpZodJvEGgME7UoWQwJBxtCfsFASs52dt/0d960i1imJn6+L+v+9FBMU/KrsjhPsdUA3Bn4VfT+WJfp/xdOaYE0jo34j5aaTcwPsduZTWxyVvsaUSRMBdcXfx//3QWrZqGf5fXNOe4KhfYyazZ5VWtIy81VpcTl3pAVReMbgAwA7stSmHZJ4GLiTSm/AXgn0kMR2K8XtAcH+b3X1p0GOyeszbOsF59iARVkpvh0luHcaw4voaj1iQpkpbNhWUiZsFr9F5z1DyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9vBRd6D/QEbqe/RcAiK88UwT/ddu5ZTtd2yzUdRiSI=;
 b=I2VoMr4mhiD8WT19CT6q7qJs+BYXhVBup61XH1xzsO8HcBqlNkt5GnvKcY9M3yGJbucr5c9nWtm2TzOvONfdgfyChKdWM/RfZyfPZjwfYZqM7fOP267HXVHZwoiNS0rjDQ1nhDnb4XhFIK41/cakxPc10aoaN3FwFy1hfQJBwluzHVNRVUGDfb4wwN+td1N0K6WMeEa4Ty1nTQM1+AGumSbc9EjZSAMqqOgaR23/S4bVePlIkXhmbngQS4LDD0VRY9j46LgTnzA3Zq1ktwqeHA7jkVVuwR+I1YFp4uJefDPDpIVvXiCxJrHMYdB0Iq+oJfkPzPntkki2u3NWOoZF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9vBRd6D/QEbqe/RcAiK88UwT/ddu5ZTtd2yzUdRiSI=;
 b=s68X7OS0xH3VpgBk3aBluoNYYpO6tnmaVMKajkTJdYJd1h8yfPHh4v1Hv2gaMfvxS2uDwOlHSPxzDjIfzcFZRZiY/914YwVIxqM120NvVOrHMkISnsHORpC18ShqZE5HZx0TveUx4MGOinaCrZArxzGCAerXNKj71YVjbyemUlo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 02:20:45 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 02:20:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: convert nbio_v2_3_clear_doorbell_interrupt()
 to IP version
Thread-Topic: [PATCH] drm/amdgpu: convert nbio_v2_3_clear_doorbell_interrupt()
 to IP version
Thread-Index: AQHYb9yGbZM9TaMYXEa662hjEEysVa05htsAgABVlNA=
Date: Wed, 1 Jun 2022 02:20:45 +0000
Message-ID: <DM5PR12MB24691CFB4F4A3838C4B5BBABF1DF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-7-alexander.deucher@amd.com>
 <CADnq5_OpVCU+KMmVwOC9+ZoEpmA6eAEWrAR75JD6UPDSwB=aCw@mail.gmail.com>
In-Reply-To: <CADnq5_OpVCU+KMmVwOC9+ZoEpmA6eAEWrAR75JD6UPDSwB=aCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 869e9376-1342-4642-1c0b-08da437555b1
x-ms-traffictypediagnostic: MW5PR12MB5621:EE_
x-microsoft-antispam-prvs: <MW5PR12MB562133C312577C130D1FEAB4F1DF9@MW5PR12MB5621.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWXj2Hdiw2tY6gvhUHXVPyEG4BNchwUoqXN3q3Tw24XllxdP11MgkBjNtrGqX8fsR3TwYxgzAj5YqFFO6DMzuF/cnEF48o1uyFGvFCxffPPHdZQiFg8JNCQ2icgPMQ8u4tMuotztSandjizimZPgreirKFL/0bJLCGBp0OiRkFn6DtV7AWMsCR0FXGJMVfmq8By+EL8Io5nqj4fFGAr0q5xkPKrycVVQms2Z3IVVoKSXkV0Sm4KdAH7EIZ3Dpwl02HqvIY6LcvdTenPVBdmLwhLWjo32PToduJsF7njYykzmKHkIXfKdkBrczodla9bGImxLK0k+SYTHbB7XBwoXa7D1l5uAJz436l2IKcLWAgq8wNAMFNeMBut8CeA/mibiNmTha6Byt0DROaowG/q8e1XxLdZX4irUEaAsAsMHM6jEKh3WpMZ2bCf+U3mpW1wgIv/RqAgw8kgHf5+hAR5f7johiYnmkZamFRwS5IfL5llO6uIhDDAsH/N7RWcFxBXlaH4B3q4XrBqjtG0wt7PUVQMLkVRz+JSGXHGtLyS90bQphm4TdhrGoU6lqn8K6inZTvtmDf1Uzv0XCrOPaub9zQWuznM3WLzEcxGqoYTgSSa2plIlcPBcZ1H19sJuP7aejjgscLkpcKfXAxgCQX/vXY/zpW1tWrgXh71g7PCqvlLU06uVytIpR/uddotkcbhm4ycEwLD/UoSC02pbiuPluA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8936002)(5660300002)(52536014)(86362001)(26005)(9686003)(6506007)(7696005)(53546011)(83380400001)(33656002)(71200400001)(110136005)(38100700002)(122000001)(38070700005)(6636002)(316002)(4326008)(66446008)(8676002)(66946007)(76116006)(64756008)(66556008)(66476007)(508600001)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9lZEgwQUFNWm1KYXRyQkFKUEpUbWp2UHZQK1B4c1FnRm1FU3dPM0xjeE1o?=
 =?utf-8?B?YVVHdUNYRXZSTmpSOWE5VmNMZWV6UHNZZXY5bWhJbUpWdnpSOVQvTGVWVVht?=
 =?utf-8?B?blZIeUZzRnhOdm1rdXdqZHpMSHRsK2p0cGpCeE1YbFBabnhYVmluQXpyUmI4?=
 =?utf-8?B?MzZlZkVWTWhiN3VCT2wxN2J1RkRaaElpdm1UazhjaXViZUpxaTlvNytqc1pt?=
 =?utf-8?B?akFieXZZNDVzdjk0cmZVLzhtUGNvUFpST0FlSXl5eVZsdDA2YnQveEVGZWlo?=
 =?utf-8?B?SUFHSFFYMEhBTXhrSXdxNHlSOE9HRHFnZXIxS2hobExqT3ZCYzMwcXV6cVZH?=
 =?utf-8?B?ZWlERU5zL3p1UnMxMjJuMHdDUUtUaVVTMmVmMy83UnlOMk5sRXRLNmpIc3pS?=
 =?utf-8?B?VlcrY1Y2TnFuUzkvRVNhRm1kTjlrTGpQN01LR01Ga2JXUE1FTWxrNExpVnJS?=
 =?utf-8?B?YWRvUTZBZWNabkxQL3ZOZmhFeUZ3T2N5SmJlUnlSYVd2Ni9rbDFTQ3V4b1cw?=
 =?utf-8?B?bEJIMlZNcjlyTHRnNytjRUFxd0E5bHlSZGtNWURSQ05rYkw4WVB5d1Z4dVM2?=
 =?utf-8?B?MGhoQ2ZuaEV6WmZsbDMwNnNKMU9MekV5NHdweWN1dEQ5L0ZDS01rZFB1c2NN?=
 =?utf-8?B?TVFGZC9xekRRWHhQWm50R1dXSUJlWDU1dFFaN0I3bXhhV0RyYUM2YS9zMk01?=
 =?utf-8?B?b0dzMDV3UjVqT0JKRzIwU0t2VmJDZnB1a0RZWXVNZ3hiM1RGUTBCTGR5endx?=
 =?utf-8?B?WXF6TFZlNVNtcS9EM25xcUhBSnZrU1pYaUFnNGJ0cHJQRUp2ZGZoSEZEMmlx?=
 =?utf-8?B?TnljN2VJa0lkQTJHSEtxVitpaStYTDNlR1VRZEdad3hPMWpTSGU5MmVFclN4?=
 =?utf-8?B?ZWxibDMyVlg4L2dBY3J2aUFyZkNPNGY1aTBzY2hIZ3h2RjFxQmp2RGxBcUpo?=
 =?utf-8?B?MHpwOG9FcEdOL3kxVStNeGg5ZjF1L3IzQkJPbVQ1QmFEay9MaUhMWGF4b3lM?=
 =?utf-8?B?eHlwR3NOczJhN2trRW1FRmkwUEVqRVFEK1NWNDV5T0NreVY0VUJMRmg5VUZ5?=
 =?utf-8?B?eDlpa0FZRmxDUnRkMkw0QWRPTGxGV0ZpWjdkQlBGaC9YcmV5UFJNWG5Eanox?=
 =?utf-8?B?OEpERGUxenNnaXp6NVdUS1VYRkVaTkhJUytwVzVEZ1ZDdVBkYTYybGVZRmtk?=
 =?utf-8?B?UWhEdFZ4R1lOemNiUU15L01zSUpvclRvUW51UWQ5TEpVRnZkZzRvbnQzdjJo?=
 =?utf-8?B?UDY5WWdKYVVueTExTDNMaktkZ2VGcTdXdlhPaXYzUnkvUDNtSGM0aERZU0oz?=
 =?utf-8?B?T0JPY1k1aDdYUVl2M2lITjRZMjVMbERsRHl3bHhETDFxUjZXL1ZneE1vZFVj?=
 =?utf-8?B?OWwzUENrRHZYcnNaNE0wc3lZMm1RNFBKdVI0RXZaRVdKbkZQSFcvVnlDZCtz?=
 =?utf-8?B?a0d0bi9HQXgwNTRIMDQ2R2ZMTStEcGdRd01XUVJkUHU1UTZieXovallrS0Fz?=
 =?utf-8?B?RU84bFJFUXRhR3BaWm0zRHlQYmllaGJVdjhQSlVHNkljYWxMd1ZyTmFhSFNK?=
 =?utf-8?B?UFF2bmxQL3BlYUdzVlQ3NHdESklFY1hobmREZHdIZUh5cWJTU0JzbGxQd29K?=
 =?utf-8?B?Umt4aWVMK2hURk9jS1l3c244ang0SXpEc0labm9xNXRzVytvMHpmN29yOWdx?=
 =?utf-8?B?Q3RocHpSZUJaYSs4ZE1vYlJIdHI2VXpOWXFvbmQ2RVVTU1V4T1N5YnZwSU5X?=
 =?utf-8?B?NG1DL0hJVlRlSXJvNWMybHlZZTkrWXprZnQycElYYjY3OUlaYkJIQVZmWlg4?=
 =?utf-8?B?N3MvbXZWWUFoVysra0djZ3o3MERBanZCUHN3V1lLeVkyaWhRODI1bjBXRGR1?=
 =?utf-8?B?MmowMjlkVHhsYS93bVB3ZjdYNUliOUp5K0ZqZnFBNUx4bFZxV0NHQ3NhUG1a?=
 =?utf-8?B?VE1NWlprcTZ4bC83bUdYdjVGc2c3RWc1SjdhYzFpVGhkN3hMZzl3VGEzZTky?=
 =?utf-8?B?dkMrYUFsQVZaOE1QZWpMZlc5K2FwTnVucjVYK3c3MmRscEhVdjVvMFVNcDIy?=
 =?utf-8?B?RVBqNmN6Sld1WWZuZVM3eUJ6WENxNm96RGduS005OE5TOTdKQTFVT3FKdXVU?=
 =?utf-8?B?UUEwMVlHYi9BS2VFWmpqajV6ZWxHek00SjZnU1BqcFRQVWd1VGdLZ2kwUTRZ?=
 =?utf-8?B?UUNGbjVVN3haVVpWY0d6THR5Mm14OVluOGlDUHhacWM2KzE0SDB1Q0E1VlNl?=
 =?utf-8?B?bG5MM2U1NkhVZWZiY2xPdzhCRHhJWkFZaWE3alpwdC9oS0J6aXovd1VIR2xj?=
 =?utf-8?B?QWlhQkc2UEpLdTRmenhyQXRTUHB3b09hV2dCc3M0cGVMdzE2ejFKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869e9376-1342-4642-1c0b-08da437555b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 02:20:45.3782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMaUAbkHu3IJIaQQJS4wLkH5CirMO60Fzltbddynj6wixq5AU94tsELK+IK4HnIwyhYncaR37nynNrGOnOkQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBE
ZXVjaGVyDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMSwgMjAyMiA1OjE0IEFNDQpUbzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlz
dCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBjb252ZXJ0IG5iaW9fdjJfM19jbGVhcl9kb29yYmVsbF9pbnRlcnJ1cHQoKSB0
byBJUCB2ZXJzaW9uDQoNClBpbmc/DQoNCk9uIFR1ZSwgTWF5IDI0LCAyMDIyIGF0IDEwOjA5IFBN
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IENo
ZWNrIElQIHZlcnNpb24gcmF0aGVyIHRoYW4gYXNpYyB0eXBlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192Ml8zLmMgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjJfMy5jIA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L25iaW9fdjJfMy5jDQo+IGluZGV4IDZjZDFmYjJlYjkxMy4uMzRjNjEwYjkx
NTdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3YyXzMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3YyXzMuYw0KPiBAQCAt
NTQ3LDcgKzU0Nyw3IEBAIHN0YXRpYyB2b2lkIA0KPiBuYmlvX3YyXzNfY2xlYXJfZG9vcmJlbGxf
aW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiAgICAgICAgIHVpbnQz
Ml90IHJlZywgcmVnX2RhdGE7DQo+DQo+IC0gICAgICAgaWYgKGFkZXYtPmFzaWNfdHlwZSAhPSBD
SElQX1NJRU5OQV9DSUNITElEKQ0KPiArICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tOQklP
X0hXSVBdWzBdICE9IElQX1ZFUlNJT04oMywgMywgMCkpDQo+ICAgICAgICAgICAgICAgICByZXR1
cm47DQo+DQo+ICAgICAgICAgcmVnID0gUlJFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX1JCX0NO
VEwpOw0KPiAtLQ0KPiAyLjM1LjMNCj4NCg==
