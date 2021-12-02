Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 02:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10276E8F2;
	Thu,  2 Dec 2021 02:21:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30E96E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 02:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmlSk1pelQsGvl4Vs+loAH7q1qa0yAk5kMFTzz3rZf+CjDIU8MvXsIUievNAYa2f9rUBToe9APSAu0j+vwwoh5J2+Z5uY+1nJvAhKNxntJ+OOu17g/7HyoXWH/ozF38aP8ohO3YkknNRbjEXUvlpPmkTysl06inBvnRm1d3hs+opMFVbiNEuESFMf5E8rcpMLmqvDmG26ik0FCYioVe/heScp6VmAs2psT3WP+NqlilnqBjEe1RnEx3EuAuTIg4+0Xp1UFBBNgi5W+M/Z6wQ1GF0Ip+i9eheshtiTt86kIJiiXbvutxJxuFI40/6NHdLwWBi0f5w6XNFcECrVyLKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/pyEVyHwxOCiFkyOLnj9fYdbsOGdFt30INl79p4ywg=;
 b=atMauD1m7D1wp1ejnaOII76Rh50T9A2tZfXMr1l+QG3M+Mur1Eo8yudGX9NKLEbfNxWSdaacpLShdn3mKG7WvQjQ+4sW/UK4WC0zWkbgEdYlIksi2Eq8HpUzJ8J6MZSjJi2abYdpFtwH5RRAuUl/D1Mmy1/BLEq2HyYH4slftNtxJezbOUcAHHv5VMT9a8iUxN1FRhTNAhBzzh1tgMmgLW11FjNkHXDzfxubiPc+6A/lDPfmnyiv9DAhPq+odlKtRhWSEBmFRMwp+st0HcaFlbaGqXSqDTvR1XRgU+A6qoUdsKPDPpeSsKFp5PBDYkJzgsf6EBLGM7tWylbGb1BJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/pyEVyHwxOCiFkyOLnj9fYdbsOGdFt30INl79p4ywg=;
 b=vKuL+Q34Kh80voVlGlKiJ1BVvN6hh9mnem5HJX8V+Nv2Rdumk3RUVnOSWW4rw1AowvWZIckEcxeAJCEMg4AgFahBxezQE4tGqE9FuXr4nnlIBFwaUuY/MhB4DV0MR6aFXQq7BwTHpyrKfRcENdH3U0rZmiciPru4vuqnN60yeJM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 02:21:09 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.029; Thu, 2 Dec 2021
 02:21:09 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: handle SRIOV VCN revision parsing
Thread-Topic: [PATCH] drm/amdgpu: handle SRIOV VCN revision parsing
Thread-Index: AQHX5vt5NFqEKhq4QkCMKiF/gixK+awecNWg
Date: Thu, 2 Dec 2021 02:21:09 +0000
Message-ID: <DM5PR12MB24692CBA2C4E9AFA22D3FCDFF1699@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211201213546.1090031-1-alexander.deucher@amd.com>
In-Reply-To: <20211201213546.1090031-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-02T01:53:30Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fd9e3ef7-9a77-4683-aa64-3df9f53b846d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-02T02:21:06Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a990a237-b30e-4048-bc99-62e3ce1c5e33
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c159225-da78-4c41-fd8e-08d9b53a6767
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-microsoft-antispam-prvs: <DM5PR12MB2504AD7BB296C19AA53F3D6CF1699@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sga3A5BGDiFlY7poMyYopeFhg95N1/WrOBpgqyb53hMDD4jsdPNa4yBn+KD54DxbgD8tigSHOlwUvWqF4FpOrUZwv3PgGPh7lh1tVLaYvPHfVWjigo/QhiSUGErwJcd+RONAByqUlGhPHqMxNGCO277dI1BwZhE3Wx/BV9d/4LTXHkpH3V/JBzSP2FrQRw1XKCmmaDmJFjQGGAEnnQo3wdYctwAaob1il/P9FB9mpHF65V4uFf9cwxd0/F/kc5UHUVVQ76bVlNB0WVakoLqzQ07juoXbhYMFFm7brEMpDUgxcuwpkWQOwsh8ZoySN9NsDecRg/KjvjaUWYNhF22vjR906cFmBiB5bmLAtSjT1yvleTTJ1JFCwJ0WghVTw3JrKFlvke6KGzz2IHxUo7Ugi/tfzPDanNj+D76RxWYktApv5XCG12xkoiTml2/2cf12g37+023m84STzpFzUPhewWahOW93JUpZkZeEJYsmi0bduPomwHvt9UySUAbOXNmjdz8JgbA8GRzSaXOHK4E/WB/LS1cIMA4ALaaRMNrss4NOezsxMHQyk2WSgykU6J0N8psSbuqTdm4rcK9Yg401+Y8FLwOPeox3c712xzpyAmxlbPLKeyFkLW9MkDjx2zx1ZpPdssrilxxgUrab8fgiwhrwjvXsthF6fX6ljOMBRJl8iTWrQAx8UU92YR5BPaDhp5msOMvERYdpFtpnn3hMnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66946007)(66556008)(66476007)(53546011)(71200400001)(186003)(64756008)(316002)(66446008)(38100700002)(6506007)(8676002)(83380400001)(86362001)(76116006)(8936002)(33656002)(26005)(2906002)(55016003)(508600001)(9686003)(38070700005)(5660300002)(122000001)(4326008)(52536014)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFBSWUdWcXltbWdUTC8wUnp6blkxaFZpcURaVDZPbmhJOUZCZ00wc0JWZGQx?=
 =?utf-8?B?THZaUEVOM1E2R1lZc29CTmZzbkovN3ZKT0oxVlFOVmZhQTRubGY5QldobzdB?=
 =?utf-8?B?bDVialpqY3NYK1dacDZYM0FOUmtEblhRVGo1VUJqMmJGYXJ2ZTFwNkIwZHo0?=
 =?utf-8?B?Kzk1aW0xS2NlRVEvOFpsdUkxQjkrcDZyZC8yZHZHS2FyZDB6K2V0OWRPMmpx?=
 =?utf-8?B?YXlON3FFWlRGQ1d5WVJtYXFkS0JXZ3E1R01zQjRrelVDc0FPUVVxTHJsdWxI?=
 =?utf-8?B?WG8rYUxIQTkyQ0c3bE83QmhXOHdsUHNJY01IUng1STM1NmZhYTZVMzNtWDJP?=
 =?utf-8?B?NXRUQUxUL01pNVdaWVFtanNjQk1WSjhBVG03SXNGdlFLYTN3d2hTeVBFM0pr?=
 =?utf-8?B?cFJqbWZWVmVLODVURlhabEk5cmZLSXkrYlgrclBJTnREU0xDL1VDbVErMnkw?=
 =?utf-8?B?SDM2V004NTRldGNoOERZaFBMVStmSWlkanBaeFJMUU9yUFMwemtDQlhYNTdO?=
 =?utf-8?B?QzEwclRyV3FRU2JoQ1hXY21BbjdVSXBvNDYrREdMUTZpelRTWTc4RGdwS0pz?=
 =?utf-8?B?UUl2NjQ4RDFqYmZhSlNHOTBvNUhFR1lHTGorRytyNkxnNVlLMExwdVg5eEFL?=
 =?utf-8?B?TWZzVHNEVklncjhKalcxTHYxV3ozTHVFQWxuVmxpUjEwMWpEakE1MVUxcy83?=
 =?utf-8?B?SlRBK1ZaU0Uzc2ZGeHA0WmZYTmM1R3BFUi9HSmRpV21BTU5VWkErOHhNSGxY?=
 =?utf-8?B?TFdQUkFDeDRQZnhNTkk0NGRWaHlFUzIyYkNzL3loZnY2ZjZXS1F0ckpqV0pv?=
 =?utf-8?B?WU9QOXU0dlBzQytZK0VrRFVBdjV6SG42Nzh2QWhkNU9uYXNWNFJYMHdOYlhh?=
 =?utf-8?B?WnhWYlBTb1FLbENzd3hzeStyeWRLY2R2NHpvV0RCalM1bnRmQzVLa2xFb2Zn?=
 =?utf-8?B?dVYrUUVnUnhUWjJCNis1ekpEQmhvRnVzaWpzSTlLZ0Z4ZTFxajhONkVxeFlB?=
 =?utf-8?B?TEZhb2dQMC8rMWRYL1BvUVpsVTRRNkIwNGVNVmdIc3M4QXRTaFNlcGZ2MmFm?=
 =?utf-8?B?REFHdkwwbStQYWNFd1loMXdoUUppT2lZQmhQT3cvUlphdk5YVmw0MThud1dw?=
 =?utf-8?B?TEJvK29aL05XcldBbnhYT05HdzRTZjNGMGRjMklkZk1kT0dBaktaTUJaRUJS?=
 =?utf-8?B?ZHN6VDBjczNybUxLNzNSTW1Xb1Z1TXJVQmtNcVBvVDRGakpFQ3U4NHF3WkF4?=
 =?utf-8?B?em8wdWtKbUNSeUk1REFGQStad2xMRSt2YUFxRndaWTI1d3JCRFdoWGlDN1B4?=
 =?utf-8?B?VytTaW4wSmhOTnh2ZDA5SUl2UjUyYVFXT1g4akRPQlVaYlJZSDBtUlJBRDJ6?=
 =?utf-8?B?VXhHUGZCZCtvbFdJNlBHa1BuU0VrS0dSRzd4aXZNSG9ySktISiszQ2lVSTk5?=
 =?utf-8?B?UHhRTGpUQThpSUxKOEg0Z3pjWUYwbDFhWlg2cHgrcEFXdDY5RXhWU2JPUDVu?=
 =?utf-8?B?VGg2bExmU3pPcG5weGVVTjdDSVZXTVdhREZUTjQ3anljc0d2bk5ZaFdhMEZp?=
 =?utf-8?B?S05vZWhwNWYvSnpneW1CcGlNcmlURnhsZEZQdXJpczJ2YnZ3TEEvbEdSTU9Z?=
 =?utf-8?B?Q29lNmlVQVBIWXNLTkNTSWhtQnhLMFFGbklDcDVHa0tRZ3hocklCWk0wNTdI?=
 =?utf-8?B?a3Fydi93cnhCZGdmY2hrMWR1S1A0eVU5TDdCYmVVYWZGN0xtbDROVm42Vmcx?=
 =?utf-8?B?bDJUcXRZZWs0Q0diMlBLT1FrNXQ1bzNzREoyT2hZVnBrOUpFeHR6bUpNaGlh?=
 =?utf-8?B?czdZNjZqNEdMS0dqc3hQUGJ0Skg0V2hUbjhVVVpOWUc1YlBRd3ZIWisxZGtk?=
 =?utf-8?B?ZVZmeXhkYkoyMGUxLzE5L2Jod3lqSS90QzB6S1NPYWx2M3pFWWRFTFV5bjhm?=
 =?utf-8?B?M216anRhTGVleVk2b2JDT2ZxdEZwY2EwSVFGVTJ5RHJPcnVJK21TTzhoOFNi?=
 =?utf-8?B?WEZEV3VkYW8yZGpkbDZGcC8yaHcwRTJ0MnZ0ekV1L0NsQnVKUXQwZW1ZMytU?=
 =?utf-8?B?cWl0cUNEU2dlZWpjQUNLOG5zK1lteG12WktwNkpRZlAxcWhjanBCeVNXZ2E2?=
 =?utf-8?B?M0dKUjQwb2lDcnJRL09TQmN2Tnl0RFM5MS84RXhuVVFsSHVQYWhPTnNFT2k2?=
 =?utf-8?Q?8cuPfkGr0By0ndoDnHAUCaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c159225-da78-4c41-fd8e-08d9b53a6767
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 02:21:09.5685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OUxyhFZMfpkWErqmkWpNlTi9JgTjDjTx94NEY9fzzYL6ggvsP+EdYD9OrbYH8fpQLNelgOPYMIxgezRjARP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhh
bGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMiwgMjAyMSA1OjM2
IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IGhhbmRsZSBTUklPViBWQ04gcmV2aXNpb24gcGFyc2luZw0KDQpGb3IgU1ItSU9WLCB0
aGUgSVAgZGlzY292ZXJ5IHJldmlzaW9uIG51bWJlciBlbmNvZGVzIGFkZGl0aW9uYWwgaW5mb3Jt
YXRpb24uICBIYW5kbGUgdGhhdCBjYXNlIGhlcmUuDQoNCnYyOiBkcm9wIGFkZGl0aW9uYWwgSVAg
dmVyc2lvbnMNCg0KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2Nv
dmVyeS5jIHwgMTcgKysrKysrKysrKysrKystLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMgICAgICAgfCAgMiAtLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92Y24uaCAgICAgICB8ICAxICsNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
di5jICAgICAgICAgICAgICAgfCAgMiAtLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNjb3ZlcnkuYw0KaW5kZXggZWEwMDA5MGIzZmIzLi41NTIwMzE5NTA1MTggMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KQEAgLTM3
OSw4ICszNzksMjEgQEAgaW50IGFtZGdwdV9kaXNjb3ZlcnlfcmVnX2Jhc2VfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikNCiAJCQkJICBpcC0+bWFqb3IsIGlwLT5taW5vciwNCiAJCQkJ
ICBpcC0+cmV2aXNpb24pOw0KIA0KLQkJCWlmIChsZTE2X3RvX2NwdShpcC0+aHdfaWQpID09IFZD
Tl9IV0lEKQ0KKwkJCWlmIChsZTE2X3RvX2NwdShpcC0+aHdfaWQpID09IFZDTl9IV0lEKSB7DQor
CQkJCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCisJCQkJCS8qIFNSLUlPViBtb2RpZmll
cyBlYWNoIFZDTuKAmXMgcmV2aXNpb24gKHVpbnQ4KQ0KKwkJCQkJICogQml0IFs1OjBdOiBvcmln
aW5hbCByZXZpc2lvbiB2YWx1ZQ0KKwkJCQkJICogQml0IFs3OjZdOiBlbi9kZWNvZGUgY2FwYWJp
bGl0eToNCisJCQkJCSAqICAgICAwYjAwIDogVkNOIGZ1bmN0aW9uIG5vcm1hbGx5DQorCQkJCQkg
KiAgICAgMGIxMCA6IGVuY29kZSBpcyBkaXNhYmxlZA0KKwkJCQkJICogICAgIDBiMDEgOiBkZWNv
ZGUgaXMgZGlzYWJsZWQNCisJCQkJCSAqLw0KKwkJCQkJYWRldi0+dmNuLnNyaW92X2NvbmZpZ1th
ZGV2LT52Y24ubnVtX3Zjbl9pbnN0XSA9DQorCQkJCQkJKGlwLT5yZXZpc2lvbiAmIDB4YzApID4+
IDY7DQorCQkJCQlpcC0+cmV2aXNpb24gJj0gfjB4YzA7DQorCQkJCX0NCiAJCQkJYWRldi0+dmNu
Lm51bV92Y25faW5zdCsrOw0KKwkJCX0NCiAJCQlpZiAobGUxNl90b19jcHUoaXAtPmh3X2lkKSA9
PSBTRE1BMF9IV0lEIHx8DQogCQkJICAgIGxlMTZfdG9fY3B1KGlwLT5od19pZCkgPT0gU0RNQTFf
SFdJRCB8fA0KIAkJCSAgICBsZTE2X3RvX2NwdShpcC0+aHdfaWQpID09IFNETUEyX0hXSUQgfHwg
QEAgLTkxNywxMCArOTMwLDggQEAgc3RhdGljIGludCBhbWRncHVfZGlzY292ZXJ5X3NldF9tbV9p
cF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogCQkJYnJlYWs7DQogCQljYXNl
IElQX1ZFUlNJT04oMywgMCwgMCk6DQogCQljYXNlIElQX1ZFUlNJT04oMywgMCwgMTYpOg0KLQkJ
Y2FzZSBJUF9WRVJTSU9OKDMsIDAsIDY0KToNCiAJCWNhc2UgSVBfVkVSU0lPTigzLCAxLCAxKToN
CiAJCWNhc2UgSVBfVkVSU0lPTigzLCAwLCAyKToNCi0JCWNhc2UgSVBfVkVSU0lPTigzLCAwLCAx
OTIpOg0KIAkJCWFtZGdwdV9kZXZpY2VfaXBfYmxvY2tfYWRkKGFkZXYsICZ2Y25fdjNfMF9pcF9i
bG9jayk7DQogCQkJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQogCQkJCWFtZGdwdV9kZXZp
Y2VfaXBfYmxvY2tfYWRkKGFkZXYsICZqcGVnX3YzXzBfaXBfYmxvY2spOyBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQppbmRleCA1ODU5NjFjMmY1ZjIuLjI2NTg0MTRjNTAz
ZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0K
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQpAQCAtMTM0LDgg
KzEzNCw2IEBAIGludCBhbWRncHVfdmNuX3N3X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpDQogCQkJYWRldi0+dmNuLmluZGlyZWN0X3NyYW0gPSB0cnVlOw0KIAkJYnJlYWs7DQogCWNh
c2UgSVBfVkVSU0lPTigzLCAwLCAwKToNCi0JY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDY0KToNCi0J
Y2FzZSBJUF9WRVJTSU9OKDMsIDAsIDE5Mik6DQogCQlpZiAoYWRldi0+aXBfdmVyc2lvbnNbR0Nf
SFdJUF1bMF0gPT0gSVBfVkVSU0lPTigxMCwgMywgMCkpDQogCQkJZndfbmFtZSA9IEZJUk1XQVJF
X1NJRU5OQV9DSUNITElEOw0KIAkJZWxzZQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaA0KaW5kZXggYmZhMjdlYTk0ODA0Li45MzhhNWVhZDNmMjAgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaA0KQEAgLTIzNSw2ICsyMzUsNyBAQCBzdHJ1Y3Qg
YW1kZ3B1X3ZjbiB7DQogDQogCXVpbnQ4X3QJbnVtX3Zjbl9pbnN0Ow0KIAlzdHJ1Y3QgYW1kZ3B1
X3Zjbl9pbnN0CSBpbnN0W0FNREdQVV9NQVhfVkNOX0lOU1RBTkNFU107DQorCXVpbnQ4X3QJCQkg
c3Jpb3ZfY29uZmlnW0FNREdQVV9NQVhfVkNOX0lOU1RBTkNFU107DQogCXN0cnVjdCBhbWRncHVf
dmNuX3JlZwkgaW50ZXJuYWw7DQogCXN0cnVjdCBtdXRleAkJIHZjbl9wZ19sb2NrOw0KIAlzdHJ1
Y3QgbXV0ZXgJCXZjbjFfanBlZzFfd29ya2Fyb3VuZDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9udi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBp
bmRleCAyZWMxZmZiMzZiMWYuLjcwODg1MjgwNzljNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L252LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252
LmMNCkBAIC0xODIsOCArMTgyLDYgQEAgc3RhdGljIGludCBudl9xdWVyeV92aWRlb19jb2RlY3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5jb2RlLCAgew0KIAlzd2l0Y2ggKGFk
ZXYtPmlwX3ZlcnNpb25zW1VWRF9IV0lQXVswXSkgew0KIAljYXNlIElQX1ZFUlNJT04oMywgMCwg
MCk6DQotCWNhc2UgSVBfVkVSU0lPTigzLCAwLCA2NCk6DQotCWNhc2UgSVBfVkVSU0lPTigzLCAw
LCAxOTIpOg0KIAkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KIAkJCWlmIChlbmNvZGUp
DQogCQkJCSpjb2RlY3MgPSAmc3Jpb3Zfc2NfdmlkZW9fY29kZWNzX2VuY29kZTsNCi0tDQoyLjMx
LjENCg==
