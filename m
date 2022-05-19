Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F80C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 02:32:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374B111A287;
	Thu, 19 May 2022 02:32:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92B11A287
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 02:32:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmtdhr/+SmAgKRv8bu+z6Ms45YUqKEtcC/Xj52+zXdwbUIYuTa2dXkJbONIDrJX5WMK14N6WXbCzekq2xKppbSDORv7E56I8UDGImXXx5dO0LxoAHCJaaGS0alaZ+iSnVahNTJ5Z2+6Fj4FNWMeCHDgNSni0wsa8k1QzqYmEK7qy2bRurGzthRWvf6XLMoE5r1/ErlADBIHn7GcfANLUvyibJAwXjTUF0Cq3y2v+9uq27NTJ8Rb+96N/+WX6DRV1ybqdF3fdsKmKR2avGSbNN6O6pTLZxodao4n5ZsvGzEJQnjj4pJysaAlUK5qSAExU3PgQIW0mr4IO2FrxMAZOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGt2MZ4DXeZR2H4CLmZVHZDhYCdCvfoqOuyuIPkl/3w=;
 b=D3T93cNnFurXCVIC6z+Ep6aSjHEoTHIJW2YgPj1yGMAjtK1SgDR3vaG1Vb6q25FQTSPT6Bq0Ftn/nIRd9wF/2hCQTOF1jPHTDRcK/tqorzI30HGvVjMmYx3dWlhbmYBUuFCJITcjQm/QbGSTN+WBi2ymhnpvq8twYfdmPCrIzxY0J8OS9L4I0sdgnxxuuo0qXJ2vmiKVBKKKSCHqn3ZAVews68NhLwhQKA8zWJ4LLDnNT6H6z21Mehi5Fld2/fvePCbWz9hItu3+Nzep91XBSetwN6q2MZqn28/vTgnufawQKMQeRWCJyd52SjxprTWc+cTbiJdslMA3N8/jx2V0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGt2MZ4DXeZR2H4CLmZVHZDhYCdCvfoqOuyuIPkl/3w=;
 b=J2RhxyuJzspy+lseefEPbbiDy+Uv51mbmtjIszeOlff64TEuZMkc0xdBQZrmIY17cM+YRh6/KKGKWiv7Itq/w4hPuOmawRZq+k1CiPNeXyia3sAwbTFso2F13H/gcd8hYJ51ZWqlHj4R7P9xtjYH+dOnnJVXtkfRKkCzO6Tp3lY=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by CH2PR12MB3832.namprd12.prod.outlook.com (2603:10b6:610:24::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 02:32:45 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::d504:b18d:6b58:cf8d%7]) with mapi id 15.20.5273.013; Thu, 19 May 2022
 02:32:45 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFJldmlldyAxLzFdIGRybS9hbWRncHU6IHN1cHBvcnQg?=
 =?gb2312?Q?ras_on_SRIOV?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Thread-Index: AQHYas4sN4FihUU3VU+v9N/EeQPbMK0le0iAgAAAYuo=
Date: Thu, 19 May 2022 02:32:45 +0000
Message-ID: <BL1PR12MB53347A0762E22061EAAE8CEC9AD09@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220518154428.9069-1-Stanley.Yang@amd.com>
 <DM5PR12MB17704224A8610A8DE98FE790B0D09@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB17704224A8610A8DE98FE790B0D09@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-19T02:32:09.3786073Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fce70cf-9528-4d4e-a2b2-08da393fdb6e
x-ms-traffictypediagnostic: CH2PR12MB3832:EE_
x-microsoft-antispam-prvs: <CH2PR12MB383215EF1E97ACFA371B48BD9AD09@CH2PR12MB3832.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yz0cxtBmRSGIeh+LJF4+hI+uw3LG6r6trfuziPj3yI6IM/ncP4Lbux3Q0T9MZgqNJ0pPh6a8Aoba48xIJJCu3jl42SIlVlX1RLCytXq0zpeoZWIf3dWEPG21SXS6BtEzYr0wpcwzTVYeJnxLf4jB4sdsAkajisqgS/euHeZjV+uA++Y8Q8NTrxrc8Ij/q4bUK19UEGOgialt4GdIqZsAo5dt6XQ9hSqUXxFPoSdY9kkl8ndvCFVySfwGqv6sXcaOtWOpLiZHtutp/xDxnuivqGX1YW5jwTL4pDAgxcI9aTYfarIP25BklvejZhAtYTf+tbjBFIXqHgVvvo2nregr9WpV0wIMW8wi6HZFFfk4gdcbBmDpRjek3A4CKGZcoQIB5GRcGPV9qkjI2bYUyLvTrMtDl62HQ+mecEnt/AcTWvD3JLuHr0rvC4jQRSmSECNRzD4yEoGlwXvj4cVcz4lsJb28DQdu34Jzu6vJY8nhw51nSg6VakyBJLFdVseishFB1cXZe9bJhL02+QUMzvUQPtYAz4/487FhONZMl8FqrZC41u1A2esPpUVutz53yEm9sBXhSlAEebeBtOAIE3CxfqeEoHcGB3M047x1Ko/zLXKgePwR2Boa+pWaWXa3dn98p+d/HYMZ2iKnFwL+YaD0+hyCPFX+YY3qGXLskaLE8c0P6VDm8FV1kjX2xE1gm4u67A4tMMDdvVZTnlCYwq8Jjw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(2906002)(38100700002)(33656002)(26005)(9686003)(83380400001)(8936002)(52536014)(122000001)(86362001)(5660300002)(6506007)(7696005)(53546011)(66476007)(38070700005)(110136005)(508600001)(66446008)(316002)(55016003)(6636002)(224303003)(66946007)(76116006)(91956017)(66556008)(64756008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TE9aWDIzd0R4SkpBU1FnTkNXRXgvc2dxbUQwa2J3L3hHRmkvYTl6WCtkUm50?=
 =?gb2312?B?dVFvUzNBbVFrb01wZzdaM2RiTUwwU2JDb2pUbEhoWHVYcFZ0TnNxWURWVXpr?=
 =?gb2312?B?NDI1YmM5bTBuVDF1MjFxMVZvNTJiaFM5VDlicndKb3NUcmZlTEZGTGMxQjVF?=
 =?gb2312?B?WnVFMTk2ZnRmNkczT1NUek5mY0JTRStmME94YzRiVjl0YWI5RHMzWGNFZlda?=
 =?gb2312?B?U1ozQm8yOGF1WVpzd3RUMHlBcWcvbUhydVp2enB1Z0NiZnJXeUsxQ0F2N3FT?=
 =?gb2312?B?R3B2aXY0S1NmZnZVZlJCWGljYkdrUEtRVGhpU3lCOFliUlU2OXByM09RUmJh?=
 =?gb2312?B?YVVMU1hPYTFTUll6YW9udENhckRCcGxGRVpmWHh5dC9MeWhaeWJ6VHBrNzdG?=
 =?gb2312?B?RTdIblJQV0k3ZHVkZnhqa1JoaEdkYUV1MEZjSEs3eUJ5ZEZPcUxwMFMxQ2lN?=
 =?gb2312?B?VGZPSlhXeDQ5NEUxK2JKYTJCbE52NmEvV01XdUZRZUhnTS9rUFovQkVacmpV?=
 =?gb2312?B?V3RnbVhlckdWU0JMcW1KRWxoNkFiYVY0NEZoUTFGWEQ5TWRtbkpZcjArekov?=
 =?gb2312?B?bDFlUWJkWDN6UjgyWjNmUFB0cmtSbEZnUlVpTVNPYlZlTWk1TzBvaGswcGI4?=
 =?gb2312?B?aWlBWmZJR3V2emFFT3FPcmFxMDJSSWhXQklxc3NwY2RrVjVYZUI2VmpHYkJI?=
 =?gb2312?B?YWdEaDhkRURqTVNlVzVSTkN1SkxKWmpUMHdrZWVuMnJFZEVENHBXdWJGVThV?=
 =?gb2312?B?QUR4UmlZNHorL1hCVUpiMFU4QjFEZzM3eXdGQ1V3ZTdlV0szRjUrVWU5amRq?=
 =?gb2312?B?eWp5TUV1M003MUxjWDEzNUpaQ0w2VGtCSnBydis1OGhlSW1Jb20wRGZsOVBZ?=
 =?gb2312?B?S1ljT1FwMDl5TDJ2VDE1SlZFRUsyQWYxV3dxWGM1YXQzVHpEaE00cU93S01t?=
 =?gb2312?B?OW8ydXVpYXpKdjN3Z0VHTlJNdTZvc3hTRVRqaUxJcWtUN29DY1MxbTZOVXlT?=
 =?gb2312?B?Zm5uQUNsNjFJUW5LM2ZqcjgvR3ZaMStGU3BaaVh4V0ZOVW9EQ0I4SlJSWW5O?=
 =?gb2312?B?MjJqLzVaTlNsZ3pFeWt0eU5SVnVrL0ZnZElMVWxtUlo4NVVLb0pzdWY5Y09x?=
 =?gb2312?B?MDhuNENMTEdzMFVmV2RGSG5OdE5JaTZDbHljTDIrYXRBUVYwK2V0eXpUa2JF?=
 =?gb2312?B?NDRKdEsrZzdWOEtGYVk3Rkl3RGpLS2FoTFZyS1diaER5MUJ3OFM4VlpkUm5y?=
 =?gb2312?B?b2NCQWRQWG9RaGFvd3lBeHU3T1J5VWRzZHR5dDZmVC9pdFNjTU53QmYyMHVZ?=
 =?gb2312?B?Q1A0VmhndE9Va0pGcVFOK2pYVUJzTkJPVkhCTFRlWktNenpPd0MxY3NNU2g4?=
 =?gb2312?B?eC8vSUR1dGlCMFlyRnZOR0ZnRzk0dFhtQkNxdElLbVlLTjNWK2JIbnJheDl4?=
 =?gb2312?B?UFo4dVVQbURSWFF3d0lXZHBid2tvMHVld2VFWXRnYzNXc1o2Q1lSN0hlMzFV?=
 =?gb2312?B?OFVRa0dGNzhDV1VjYXdSOXdxY1NJM28zT1VCWFY3dGphbmV2MEM1Mlh3N3Jq?=
 =?gb2312?B?RUpTdTJZdGJLK01sdDFZYkl4UndkZnBtSWpxNWVKV0R5L1czcktsTW4zZzVG?=
 =?gb2312?B?bk9HTXFGRlM4eVRFU0lMOUlKZlF3SytDUjllSlAybWJyeUdRWWdwakdLVmV5?=
 =?gb2312?B?cXJSaEErNHN0Vkg1M1VBVVY0K3VPTnNRYUJHWndtb0VkU1Y2RFRUSkpJbUtn?=
 =?gb2312?B?MHJiYzdyODk5Vit4VVkvTDNPMkFzaFhGZkUxd2U4ZHlzTFR6OVNiamhUekRM?=
 =?gb2312?B?QXNhVGlCUlFuRUJSM3R6cHBBNUczNWw4eEpNT2lBZGZmS3VES3lGRHhQK2Fp?=
 =?gb2312?B?MjF0MnVibE42QlJuUStFRU1rUkIwNUZhTzREZFJZSHllWVA1U0NwY09vcUlB?=
 =?gb2312?B?TkpwTVE4SUdPOW9YZlRNZGxTdVJSUUxBV3ZLZGZUS0thb0xld1AxRENqN25V?=
 =?gb2312?B?d25BNXRwVG5RK3djMlZnUDEyY0RTdWRKcC9HQWdjRWgrSTJtd1FycU56alFI?=
 =?gb2312?B?Nko5SmtqZkVjMW9BMVhGV2QxR1FyNUhVcFpVRGlqbUtLZFVCQ25DVWdoZ2Ji?=
 =?gb2312?B?dXNJNDBtRzBMY1M0WTlGeHpFQWd6Q05iRGpEQklLNGp1SWRhTE5yUXRUcnE2?=
 =?gb2312?B?UkhCVXk2WlR2Q21ROUZxSGVJV3BsSStRVWJFVnplTTlES1IwQWR5dzlyckQx?=
 =?gb2312?B?ODBCNWtudHhzVmZ1RE40Yld5OHJJdFhjeXoxdjIzTWFuMjA4a2tkcXpxK0R1?=
 =?gb2312?B?UzlzYjVnZVdNZ1liQld6UGo1d3RCam93bXRBeTVkcGtvdkZ4aG9nOEFYS3Uy?=
 =?gb2312?Q?W/CE52E7gYJh/cCs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB53347A0762E22061EAAE8CEC9AD09BL1PR12MB5334namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce70cf-9528-4d4e-a2b2-08da393fdb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 02:32:45.3374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fn8b3uKl0rBQ0e8AbhWUbb+VO9W/rNg1hQUZ6oxtqsezNQfGI2dNVAv2PKpSTHL0M9OuJnTnMQaVUqdgQ3SBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3832
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

--_000_BL1PR12MB53347A0762E22061EAAE8CEC9AD09BL1PR12MB5334namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEdlbmVyYWxdDQpUaGFua3MgdGFvLCB3aWxsIHVwZGF0ZSBiZWZvcmUgc3VibWl0Lg0K
DQpSZWdhcmRzLA0KU3RhbmxleQ0Kt6K8/sjLOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNv
bT4NCsjVxto6INDHxtrLxCwgMjAyMsTqNdTCMTnI1SDJz87nMTA6MzANCsrVvP7IyzogWWFuZywg
U3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+LCBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZyA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+LCBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPg0Ks63LzTogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFt
ZC5jb20+DQrW98ziOiBSRTogW1BBVENIIFJldmlldyAxLzFdIGRybS9hbWRncHU6IHN1cHBvcnQg
cmFzIG9uIFNSSU9WDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
dGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1h
eSAxOCwgMjAyMiAxMTo0NCBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvIDxU
YW8uWmhvdTFAYW1kLmNvbT4NCj4gQ2M6IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogc3VwcG9ydCBy
YXMgb24gU1JJT1YNCj4NCj4gc3VwcG9ydCB1bWMvZ2Z4L3NkbWEgcmFzIG9uIGd1ZXN0IHNpZGUN
Cj4NCj4gQ2hhbmdlZCBmcm9tIFYxOg0KPiAgICAgbW92ZSBzcmlvdiBqdWRnbWVudCBpbiBhbWRn
cHVfcmFzX2ludGVycnVwdF9mYXRhbF9lcnJvcl9oYW5kbGVyDQo+DQo+IENoYW5nZS1JZDogSWM3
ZGRhNDVkOGY4Y2YyZDVmMWFiYzc3MDVhYmMxNTNkNTU4ZGE4YTENCj4gU2lnbmVkLW9mZi1ieTog
U3RhbmxleS5ZYW5nIDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAgNCArKysNCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyAgICB8IDQyICsrKysrKysrKysrKysrKystLS0t
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMgICB8ICA0ICsr
Kw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMgICAgIHwgIDkgKysr
LS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4g
aW5kZXggYjU4MzAyNmRjODkzLi5iYTc5OTBkMGRjMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gQEAgLTUyMTgsNiArNTIxOCwxMCBAQCBp
bnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3Zlcl9pbXAoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ICAgICAgICAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX3Jlc2V0X3NyaW92KGFk
ZXYsIGpvYiA/IGZhbHNlIDogdHJ1ZSk7DQo+ICAgICAgICAgICAgICAgIGlmIChyKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgIGFkZXYtPmFzaWNfcmVzZXRfcmVzID0gcjsNCj4gKw0KPiArICAg
ICAgICAgICAgIC8qIEFsZGViYXJhbiBzdXBwb3J0cyByYXMgaW4gU1JJT1YsIHNvIG5lZWQgcmVz
dW1lIHJhcyBkdXJpbmcNCj4gcmVzZXQgKi8NCj4gKyAgICAgICAgICAgICBpZiAoYWRldi0+aXBf
dmVyc2lvbnNbR0NfSFdJUF1bMF0gPT0gSVBfVkVSU0lPTig5LCA0LCAyKSkNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGFtZGdwdV9yYXNfcmVzdW1lKGFkZXYpOw0KPiAgICAgICAgfSBlbHNlIHsN
Cj4gICAgICAgICAgICAgICAgciA9IGFtZGdwdV9kb19hc2ljX3Jlc2V0KGRldmljZV9saXN0X2hh
bmRsZSwgJnJlc2V0X2NvbnRleHQpOw0KPiAgICAgICAgICAgICAgICBpZiAociAmJiByID09IC1F
QUdBSU4pDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmFzLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gaW5k
ZXggYTY1M2NmM2IzZDEzLi4yYjI4MjEwYzQ5OTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gQEAgLTcyNiw3ICs3MjYsOSBAQCBpbnQgYW1kZ3B1X3Jh
c19mZWF0dXJlX2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gICAgICAg
IC8qIERvIG5vdCBlbmFibGUgaWYgaXQgaXMgbm90IGFsbG93ZWQuICovDQo+ICAgICAgICBXQVJO
X09OKGVuYWJsZSAmJiAhYW1kZ3B1X3Jhc19pc19mZWF0dXJlX2FsbG93ZWQoYWRldiwgaGVhZCkp
Ow0KPg0KPiAtICAgICBpZiAoIWFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkgew0KPiArICAg
ICAvKiBPbmx5IGVuYWJsZSByYXMgZmVhdHVyZSBvcGVyYXRpb24gaGFuZGxlIG9uIGhvc3Qgc2lk
ZSAqLw0KPiArICAgICBpZiAoIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJg0KPiArICAgICAgICAg
ICAgICFhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpIHsNCj4gICAgICAgICAgICAgICAgcmV0
ID0gcHNwX3Jhc19lbmFibGVfZmVhdHVyZXMoJmFkZXYtPnBzcCwgaW5mbywgZW5hYmxlKTsNCj4g
ICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgIGRldl9l
cnIoYWRldi0+ZGV2LCAicmFzICVzICVzIGZhaWxlZCBwb2lzb246JWQNCj4gcmV0OiVkXG4iLCBA
QCAtMTUyMyw2ICsxNTI1LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19mc19maW5pKHN0cnVj
dA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgICovDQo+ICB2b2lkIGFtZGdwdV9yYXNfaW50
ZXJydXB0X2ZhdGFsX2Vycm9yX2hhbmRsZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7
DQo+ICsgICAgIC8qIEZhdGFsIGVycm9yIGV2ZW50cyBhcmUgaGFuZGxlZCBvbiBob3N0IHNpZGUg
Ki8NCj4gKyAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gKyAgICAgICAgICAgICBy
ZXR1cm47DQo+ICsNCj4gICAgICAgIGlmICghYW1kZ3B1X3Jhc19pc19zdXBwb3J0ZWQoYWRldiwg
QU1ER1BVX1JBU19CTE9DS19fUENJRV9CSUYpKQ0KPiAgICAgICAgICAgICAgICByZXR1cm47DQoN
CltUYW9dIFRoZSB0d28gY29uZGl0aW9ucyBhYm92ZSBjYW4gYmUgbWVyZ2VkLCBvdGhlciB0aGFu
IHRoYXQgdGhlIHBhdGNoIGlzOg0KDQpSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBh
bWQuY29tPg0KDQo+DQo+IEBAIC0yMjcwLDEwICsyMjc2LDE0IEBAIHN0YXRpYyB2b2lkIGFtZGdw
dV9yYXNfY2hlY2tfc3VwcG9ydGVkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KSAgew0K
PiAgICAgICAgYWRldi0+cmFzX2h3X2VuYWJsZWQgPSBhZGV2LT5yYXNfZW5hYmxlZCA9IDA7DQo+
DQo+IC0gICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgfHwgIWFkZXYtPmlzX2F0b21fZncg
fHwNCj4gKyAgICAgaWYgKCFhZGV2LT5pc19hdG9tX2Z3IHx8DQo+ICAgICAgICAgICAgIWFtZGdw
dV9yYXNfYXNpY19zdXBwb3J0ZWQoYWRldikpDQo+ICAgICAgICAgICAgICAgIHJldHVybjsNCj4N
Cj4gKyAgICAgaWYgKCEoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmDQo+ICsgICAgICAgICAgICAg
KGFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQXVswXSA9PSBJUF9WRVJTSU9OKDEzLCAwLCAyKSkp
KQ0KPiArICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiAgICAgICAgaWYgKCFhZGV2LT5nbWMu
eGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7DQo+ICAgICAgICAgICAgICAgIGlmIChhbWRncHVfYXRv
bWZpcm13YXJlX21lbV9lY2Nfc3VwcG9ydGVkKGFkZXYpKSB7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiTUVNIEVDQyBpcyBhY3RpdmUuXG4iKTsgQEAgLQ0K
PiAyMjg1LDE1ICsyMjk1LDIxIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfY2hlY2tfc3VwcG9y
dGVkKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPg0KPiAgICAgICAgICAgICAgICBp
ZiAoYW1kZ3B1X2F0b21maXJtd2FyZV9zcmFtX2VjY19zdXBwb3J0ZWQoYWRldikpIHsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJTUkFNIEVDQyBpcyBhY3Rp
dmUuXG4iKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIGFkZXYtPnJhc19od19lbmFibGVkIHw9
IH4oMSA8PA0KPiBBTURHUFVfUkFTX0JMT0NLX19VTUMgfA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwNCj4gQU1ER1BVX1JBU19CTE9DS19f
REYpOw0KPiAtDQo+IC0gICAgICAgICAgICAgICAgICAgICBpZiAoYWRldi0+aXBfdmVyc2lvbnNb
VkNOX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMiwNCj4gNiwgMCkpDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZXYtPnJhc19od19lbmFibGVkIHw9ICgxIDw8DQo+IEFNREdQVV9S
QVNfQkxPQ0tfX1ZDTiB8DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAxIDw8DQo+IEFNREdQVV9SQVNfQkxPQ0tfX0pQRUcpOw0KPiAtICAgICAgICAgICAg
ICAgICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5yYXNf
aHdfZW5hYmxlZCAmPSB+KDEgPDwNCj4gQU1ER1BVX1JBU19CTE9DS19fVkNOIHwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwNCj4gQU1ER1BVX1JB
U19CTE9DS19fSlBFRyk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoIWFtZGdwdV9zcmlv
dl92ZihhZGV2KSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5yYXNf
aHdfZW5hYmxlZCB8PSB+KDEgPDwNCj4gQU1ER1BVX1JBU19CTE9DS19fVU1DIHwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwN
Cj4gQU1ER1BVX1JBU19CTE9DS19fREYpOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tWQ05fSFdJUF1bMF0gPT0NCj4gSVBfVkVSU0lP
TigyLCA2LCAwKSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2
LT5yYXNfaHdfZW5hYmxlZCB8PSAoMSA8PA0KPiBBTURHUFVfUkFTX0JMT0NLX19WQ04gfA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxIDw8
DQo+IEFNREdQVV9SQVNfQkxPQ0tfX0pQRUcpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+
cmFzX2h3X2VuYWJsZWQgJj0gfigxIDw8DQo+IEFNREdQVV9SQVNfQkxPQ0tfX1ZDTiB8DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgPDwN
Cj4gQU1ER1BVX1JBU19CTE9DS19fSlBFRyk7DQo+ICsgICAgICAgICAgICAgICAgICAgICB9IGVs
c2Ugew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5yYXNfaHdfZW5hYmxl
ZCB8PSAoMSA8PA0KPiBBTURHUFVfUkFTX0JMT0NLX19QQ0lFX0JJRiB8DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSA8PA0K
PiBBTURHUFVfUkFTX0JMT0NLX19TRE1BIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxIDw8DQo+IEFNREdQVV9SQVNfQkxP
Q0tfX0dGWCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgIH0g
ZWxzZSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oYWRldi0+ZGV2LCAiU1JB
TSBFQ0MgaXMgbm90IHByZXNlbnRlZC5cbiIpOw0KPiAgICAgICAgICAgICAgICB9DQo+IEBAIC0y
NjM3LDYgKzI2NTMsMTAgQEAgaW50IGFtZGdwdV9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlDQo+ICphZGV2KQ0KPiAgICAgICAgc3RydWN0IGFtZGdwdV9yYXNfYmxvY2tfb2JqZWN0
ICpvYmo7DQo+ICAgICAgICBpbnQgcjsNCj4NCj4gKyAgICAgLyogR3Vlc3Qgc2lkZSBkb2Vzbid0
IG5lZWQgaW5pdCByYXMgZmVhdHVyZSAqLw0KPiArICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFk
ZXYpKQ0KPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+ICAgICAgICBsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUobm9kZSwgdG1wLCAmYWRldi0+cmFzX2xpc3QsIG5vZGUpIHsNCj4gICAg
ICAgICAgICAgICAgaWYgKCFub2RlLT5yYXNfb2JqKSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAiV2FybmluZzogYWJub3JtYWwgcmFzIGxpc3QNCj4gbm9k
ZS5cbiIpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Nk
bWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMNCj4gaW5k
ZXggOGUyMjFhMWJhOTM3Li40MmMxZjA1MDU0MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZG1hLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3NkbWEuYw0KPiBAQCAtMTI0LDYgKzEyNCwxMCBAQCBpbnQgYW1kZ3B1
X3NkbWFfcHJvY2Vzc19yYXNfZGF0YV9jYihzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwN
Cj4gICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9pdl9lbnRyeSAqZW50cnkpDQo+ICB7DQo+
ICAgICAgICBrZ2Qya2ZkX3NldF9zcmFtX2VjY19mbGFnKGFkZXYtPmtmZC5kZXYpOw0KPiArDQo+
ICsgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+ICsgICAgICAgICAgICAgcmV0dXJu
IEFNREdQVV9SQVNfU1VDQ0VTUzsNCj4gKw0KPiAgICAgICAgYW1kZ3B1X3Jhc19yZXNldF9ncHUo
YWRldik7DQo+DQo+ICAgICAgICByZXR1cm4gQU1ER1BVX1JBU19TVUNDRVNTOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEzXzAuYw0KPiBpbmRleCBkNmQ3OWU5N2RlZjkuLjE4
MDE0ZWQwZTg1MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNw
X3YxM18wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YxM18wLmMN
Cj4gQEAgLTg1LDkgKzg1LDEyIEBAIHN0YXRpYyBpbnQgcHNwX3YxM18wX2luaXRfbWljcm9jb2Rl
KHN0cnVjdCBwc3BfY29udGV4dA0KPiAqcHNwKQ0KPiAgICAgICAgICAgICAgICBlcnIgPSBwc3Bf
aW5pdF9zb3NfbWljcm9jb2RlKHBzcCwgY2hpcF9uYW1lKTsNCj4gICAgICAgICAgICAgICAgaWYg
KGVycikNCj4gICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiAtICAgICAgICAg
ICAgIGVyciA9IHBzcF9pbml0X3RhX21pY3JvY29kZSgmYWRldi0+cHNwLCBjaGlwX25hbWUpOw0K
PiAtICAgICAgICAgICAgIGlmIChlcnIpDQo+IC0gICAgICAgICAgICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiArICAgICAgICAgICAgIC8qIEl0J3Mgbm90IG5lY2Vzc2FyeSB0byBsb2FkIHJhcyB0
YSBvbiBHdWVzdCBzaWRlICovDQo+ICsgICAgICAgICAgICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGVyciA9IHBzcF9pbml0X3RhX21pY3Jv
Y29kZSgmYWRldi0+cHNwLCBjaGlwX25hbWUpOw0KPiArICAgICAgICAgICAgICAgICAgICAgaWYg
KGVycikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gKyAg
ICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgY2FzZSBJUF9W
RVJTSU9OKDEzLCAwLCAxKToNCj4gICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMywgMCwgMyk6DQo+
IC0tDQo+IDIuMTcuMQ0K

--_000_BL1PR12MB53347A0762E22061EAAE8CEC9AD09BL1PR12MB5334namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;" a=
lign=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Thanks tao, will update before submit.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:DengXian">Stanley<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"col=
or:black">=B7=A2=BC=FE=C8=CB</span></b><b><span lang=3D"EN-US" style=3D"fon=
t-family:&quot;Calibri&quot;,sans-serif;color:black">:</span></b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
> Zhou1,
 Tao &lt;Tao.Zhou1@amd.com&gt;<br>
</span><b><span style=3D"color:black">=C8=D5=C6=DA</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black">
</span><span style=3D"color:black">=D0=C7=C6=DA=CB=C4</span><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">, 20=
22</span><span style=3D"color:black">=C4=EA</span><span lang=3D"EN-US" styl=
e=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">5</span><span =
style=3D"color:black">=D4=C2</span><span lang=3D"EN-US" style=3D"font-famil=
y:&quot;Calibri&quot;,sans-serif;color:black">19</span><span style=3D"color=
:black">=C8=D5</span><span style=3D"font-family:&quot;Calibri&quot;,sans-se=
rif;color:black">
</span><span style=3D"color:black">=C9=CF=CE=E7</span><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">10:30<br>
</span><b><span style=3D"color:black">=CA=D5=BC=FE=C8=CB</span></b><b><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&q=
uot;,sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;, a=
md-gfx@lists.freedesktop.org
 &lt;amd-gfx@lists.freedesktop.org&gt;, Zhang, Hawking &lt;Hawking.Zhang@am=
d.com&gt;<br>
</span><b><span style=3D"color:black">=B3=AD=CB=CD</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
</span><b><span style=3D"color:black">=D6=F7=CC=E2</span></b><b><span lang=
=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"=
>:</span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,=
sans-serif;color:black"> RE: [PATCH Review 1/1] drm/amdgpu: support ras on
 SRIOV<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-size:11.0pt"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; Sent: Wednesday, May 18, 2022 11:44 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org; Zhang, Hawking<br>
&gt; &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br=
>
&gt; Cc: Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
&gt; Subject: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV<br>
&gt; <br>
&gt; support umc/gfx/sdma ras on guest side<br>
&gt; <br>
&gt; Changed from V1:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; move sriov judgment in amdgpu_ras_interrupt_fa=
tal_error_handler<br>
&gt; <br>
&gt; Change-Id: Ic7dda45d8f8cf2d5f1abc7705abc153d558da8a1<br>
&gt; Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 4 +++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp; | 42 +=
+++++++++++++++------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c&nbsp;&nbsp; |&nbsp; 4 +=
++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/psp_v13_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 9 +++--<br>
&gt;&nbsp; 4 files changed, 45 insertions(+), 14 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index b583026dc893..ba7990d0dc0e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -5218,6 +5218,10 @@ int amdgpu_device_gpu_recover_imp(struct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_reset_sriov(adev, job ? false : tru=
e);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;asic_reset_res =3D r;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Aldebaran supports ras in SRIOV, so need resume ras during<br>
&gt; reset */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_resume(adev)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_do_asic_reset(device_list_handle, &amp;res=
et_context);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; index a653cf3b3d13..2b28210c4994 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; @@ -726,7 +726,9 @@ int amdgpu_ras_feature_enable(struct amdgpu_device=
<br>
&gt; *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Do not enable if it is no=
t allowed. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(enable &amp;&amp; !a=
mdgpu_ras_is_feature_allowed(adev, head));<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_intr_triggered()) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Only enable ras feature operation handle =
on host side */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !amdgpu_ras_intr_triggered()) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_enable_features(&amp;adev-&gt;psp, info=
, enable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err=
(adev-&gt;dev, &quot;ras %s %s failed poison:%d<br>
&gt; ret:%d\n&quot;, @@ -1523,6 +1525,10 @@ static int amdgpu_ras_fs_fini(s=
truct<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_devi=
ce *adev)&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Fatal error events are handled on host si=
de */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported=
(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
<br>
[Tao] The two conditions above can be merged, other than that the patch is:=
<br>
<br>
Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
<br>
&gt; <br>
&gt; @@ -2270,10 +2276,14 @@ static void amdgpu_ras_check_supported(struct<=
br>
&gt; amdgpu_device *adev)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled =3D =
adev-&gt;ras_enabled =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || !adev-&gt;is_at=
om_fw ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;is_atom_fw ||<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amd=
gpu_ras_asic_supported(adev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_sriov_vf(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2))))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.conne=
cted_to_cpu) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o(adev-&gt;dev, &quot;MEM ECC is active.\n&quot;); @@ -<br>
&gt; 2285,15 +2295,21 @@ static void amdgpu_ras_check_supported(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o(adev-&gt;dev, &quot;SRAM ECC is active.\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled=
 |=3D ~(1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__UMC |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt=
;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__DF);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_version=
s[VCN_HWIP][0] =3D=3D IP_VERSION(2,<br>
&gt; 6, 0))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled |=3D (1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__VCN |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__JPEG);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled &amp;=3D ~(1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__VCN |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__JPEG);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(ad=
ev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled |=3D ~(1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__UMC |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__DF);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[VCN_HWIP][0] =3D=3D<br>
&gt; IP_VERSION(2, 6, 0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;ras_hw_enabled |=3D (1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__VCN |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__JPEG);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;ras_hw_enabled &amp;=3D ~(1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__VCN |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__JPEG);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled |=3D (1 &lt;&lt;<br>
&gt; AMDGPU_RAS_BLOCK__PCIE_BIF |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&l=
t;<br>
&gt; AMDGPU_RAS_BLOCK__SDMA |<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&l=
t;<br>
&gt; AMDGPU_RAS_BLOCK__GFX);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_inf=
o(adev-&gt;dev, &quot;SRAM ECC is not presented.\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -2637,6 +2653,10 @@ int amdgpu_ras_late_init(struct amdgpu_device<b=
r>
&gt; *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_block_obje=
ct *obj;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Guest side doesn't need init ras feature =
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(nod=
e, tmp, &amp;adev-&gt;ras_list, node) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!node-&gt;ras_obj) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;Warning: abnormal ras list<br>
&gt; node.\n&quot;); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<=
br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; index 8e221a1ba937..42c1f050542f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; @@ -124,6 +124,10 @@ int amdgpu_sdma_process_ras_data_cb(struct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(ad=
ev-&gt;kfd.dev);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return AMDGPU_RAS_SUCCESS;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<=
br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_RAS_SUCCESS;<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
&gt; index d6d79e97def9..18014ed0e853 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
&gt; @@ -85,9 +85,12 @@ static int psp_v13_0_init_microcode(struct psp_cont=
ext<br>
&gt; *psp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; err =3D psp_init_sos_microcode(psp, chip_name);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
err;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; err =3D psp_init_ta_microcode(&amp;adev-&gt;psp, chip_name);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (err)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* It's not necessary to load ras ta on Guest side */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!amdgpu_sriov_vf(adev)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D psp_init_ta_mic=
rocode(&amp;adev-&gt;psp, chip_name);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):<b=
r>
&gt; --<br>
&gt; 2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB53347A0762E22061EAAE8CEC9AD09BL1PR12MB5334namp_--
