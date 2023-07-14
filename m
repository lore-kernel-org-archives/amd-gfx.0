Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B899C001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jul 2023 04:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B94910E184;
	Fri, 14 Jul 2023 04:12:21 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71B210E1AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jul 2023 04:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhpvkBIj++gR6JVyH37pwTZ7pEr/KWAWT8b6AsVxTZImVXJqLbrZUFK0VC67XCxEDd7FnDfea/eU6+LtM66krl1CMVZFEW4VnEkP1qxgtBMfKnx6gez+KZXFw1ApolPq1eaF/Ijr8t6t3FmmhBr72X08ORCmbeBdPGEb3p0kZRKTSQSa6QPt+zQN/aGeVoOg7aTUlsP+1CFlRrOoqXLlJQTmYprG6fAWuojDT5K+gSe2fBXgVdA/gD+UW+fzD5tUVRIvaUJrExCSt6isGGF3KiFKQQn4Q+uluFXsAk4yPKy4PUDF3gl0wBXh0xLsH1nvzrIWCDj4QSRNif/1zhm0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w85Q88+W8E8muZqkB7Gg8t8zRSlQe+6OZhaLemvQZng=;
 b=YTRWA8VER0WIfJMpKMZpyz83kan2VWfI+BomEJR8rdcZm/qcdT5dwkA/Y9PJOcgSwwD1wZxhczRry2yEBEhqGRe8ie/Sr6zJZYl7Zeb8shkZ16EJ0s3VL/3WKRLO+fRpvRR1n2lOzt0Iuey6xhIjolwSqhmIWQvTkb7KI6QEWccCBtJYNhXcfFFtsJPS+2wiN8ie3a9nMlIFOu68RvO93fAAeZM9jwVwYbKV2W2K/Q5O7IkSuZFRO1dEKJ/8kqRSsDhrqpCpXxjNOolHIpOwjg3GKfPdQYBL7BIIE6mU90W4XWrtfXznfwZtme52X7eAK806ZzZmMaTYusfA5pkKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w85Q88+W8E8muZqkB7Gg8t8zRSlQe+6OZhaLemvQZng=;
 b=nna8Mb320JaEORDqEWqWPJ4frNGARcv7kQ2nmotC1ezhdWIfPyHH4lzU83seqa3EVrD8WAySCf24zNBrJNyyoFALmwV8iyEflbtlryZkpjk4bRQm/RJRTiCh+q2gkQdmxc83nVRAFOycKNWCRkH9ZGNMEOwuUS4xs39OFdYUKto=
Received: from DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) by
 PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 14 Jul
 2023 04:12:17 +0000
Received: from DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::37d9:b40b:b698:f41b]) by DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::37d9:b40b:b698:f41b%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 04:12:16 +0000
From: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] Revert "drm/amdgpu: update kernel vcn ring test"
Thread-Topic: [PATCH 1/2] Revert "drm/amdgpu: update kernel vcn ring test"
Thread-Index: AQHZtUm4yMMIGabSREGAouU6Hbi3JK+36h0AgAC8n6A=
Date: Fri, 14 Jul 2023 04:12:16 +0000
Message-ID: <DM5PR12MB256538941275198A3D01B35D9C34A@DM5PR12MB2565.namprd12.prod.outlook.com>
References: <20230713051948.3952921-1-saleemkhan.jamadar@amd.com>
 <CADnq5_OHhOzXz2y2V9zvQgRDoJdMnxPDf95iPQ7RjujYHFMnOw@mail.gmail.com>
In-Reply-To: <CADnq5_OHhOzXz2y2V9zvQgRDoJdMnxPDf95iPQ7RjujYHFMnOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c82d50cd-1759-480e-a6d3-d47a55633f95;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-14T04:07:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2565:EE_|PH7PR12MB5951:EE_
x-ms-office365-filtering-correlation-id: 2dfcfe79-1793-4b6e-37ca-08db84208234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gvm5WYCI4PkIaN8egiw5KyC0DdUrNS8Dmo6VBn56A4pD0BBmwHeN2ghkxcaIKwW9R0mr4WtJXWjcPCrXIrwm7cWWQ+eoVOhLcsps0as66v6BhhHi/jJXRxGop4OsdkYEKbq7Wd9SRBFypSF+XO6p1/B2PfXp/FCqnCFXqN/E+hotqfJDUVqK0Zy6mho2z9o4Y1IxE4R4gGA88xF/VeqZx/NguI4x8vni9GdjKKamPbE3CV/WS7enD3wn3dMLKpobUqQVUtcBeg7k6aV2EYpaov1BGs6idDnwfI1un0ad9b/d65n9Ch0Kn3jnZDPIFLX36PxDTs8Q9vS7NxxrnqxpzT8illHaU85oBQ6qcdeCNcovMCzkZSV1E4s+ssVpX/WbiVcxINsO5ltuGYJz0pVTwrx45eTj26AuQpPITdinY0k+zC8/6SgCON5Nc+VUPXdETXnsf5wiSwt+zTUo1NiEHl2q8xV3Cey63tbBRO7i958YUezYZmHjrdCTT/05KdC+V8E8UQcWp6yodm5ytZAL6CpSbF+itjjktq0BbEsbV6Go/VN/FwG07JESa1FDR2oKTInBuEajXFDfLGfBntp61EomLJPo2BzhS7MKAZ3mu93K1f6EVm5BdsZMxLsU2mVU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(5660300002)(54906003)(122000001)(71200400001)(7696005)(478600001)(52536014)(8936002)(33656002)(2906002)(15650500001)(8676002)(38070700005)(38100700002)(66556008)(316002)(4326008)(6916009)(64756008)(66476007)(66946007)(55016003)(76116006)(66446008)(53546011)(41300700001)(26005)(186003)(6506007)(86362001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlVzR09mOGdoWFQxR0RRZzRUYUVCaGN4aEZhZDlzZzRVZGZ3d3hMVlhPaVZZ?=
 =?utf-8?B?ck5yQWJsQnQrSVhpQ0M5elVQalJKRmFpRFJGemxtblM1cjFEZjRVUG9ZTVlK?=
 =?utf-8?B?VDlneUgwL3MvRHV5TUZ3ZGxQWVU5V2dnRnlVMTFsQXB0aDFIcFRJbXp0cUls?=
 =?utf-8?B?Mk1FWlBIaDlFcFdjRGFpbGg3WTJBekdNZFhsSkZabk11ZHdGMFBsU1FNUXRM?=
 =?utf-8?B?YkE0NWJWZnFGSExoYVljcVI2VlliMUNHTFdBelZwWC9tN2tkdUVsU0hXT2gy?=
 =?utf-8?B?cG5sR1REMWFEb2hBY1JvZ0hMZy84eHBnRzVsN2VxcXZUYWhrRU5ydVo1bDVj?=
 =?utf-8?B?d0lZRm54L1pMVU9xY0NsZ1dSMUFKMW16eURwbHUrSzJCTGZVQXVKMGVXQkFR?=
 =?utf-8?B?QXp6dTZnKzAzc2puNmVRQ0Y4Y3RkZHBFMlVNWUNaczdzaDFUMXlrMWM3N1hW?=
 =?utf-8?B?c3N1bTlocGFzdGYvS01rbWR5ekp5MWRUUnFiTkR6ckNGbGRPNWJyN2F2L1Q1?=
 =?utf-8?B?TktTNTlXSHkyYjVzQVRjYjJtbUxWMjlqQUhYWGcvRWNNQU5yakhQTTNtTVFz?=
 =?utf-8?B?amZUZ0hzTEc3K1NqN1VOM3FDVERIVi9YWHYxdnRJQ1g1dktKaTA2d1g3K0ho?=
 =?utf-8?B?SHBOT1NoRTZocldGdEVhZzNJc1NHaThOc3pINDdFbG1CUkp5Z2tFMFRKOEQ2?=
 =?utf-8?B?MmtXYU9QRkJISk03QktlRHBYeWU1RDVXRjdTNmZQUU9OdS9LN3Vxb0NiaXF2?=
 =?utf-8?B?NUx1eDdObXpwSHpHRWoyRWRiczkweG1MNjJNak83OHRJZTVlamtjajVLb25H?=
 =?utf-8?B?alZOaFJoak9IdS8xeXRSeEVVQlRTUUhPa0Z4MHZVUFBrUVpEazNibjFQQk03?=
 =?utf-8?B?S2xjQVBZN0RUMHo0L242QlJSQXg2UkVSeVFkdHZuZkxoU0I0c092aFNnam1N?=
 =?utf-8?B?WTkxeVplWDRHMU9lVWI5eXh4dzdhVTNaRW9EdjlGVFgraU1Mem92cS9lbE5N?=
 =?utf-8?B?cTdIRHBQQ2w1bkNzZzBML1VnTElEQU5RRUkvazdnOUgwVmlmbXc3ZnBRcEg0?=
 =?utf-8?B?RHYzTFM0ajk2MHhaaG12aCs4dk8zNHdNRlJ5TkFqbUN5NW03L2FmekJjMWxa?=
 =?utf-8?B?dUd6SyszRTQvTE1UUUpIWWZPb1RXODRzaGdrdUxnTjdiUzZjd3F2YmRubkQ3?=
 =?utf-8?B?NTNwN21XZmVyMGZHb09TRk5aaFgyQUpKMUUwN09KN1p2dTV0Z0tPcUUzS0hU?=
 =?utf-8?B?MUQ2ZUlTS2JuaEZLVERpWEpteFpubXFlVjJ4Umw2VFVocGZvMWh4b0hEb3BC?=
 =?utf-8?B?OHMxOVJ1UXljbWVHZ1dkakNYRXpRUVRyRFZFZEVxQXRyUVJ0YldjUXRSUmox?=
 =?utf-8?B?dzFUQ0dDVDhJQWROZ0lxYVFyRTZRMi9oVm5wN2t4UUNyTkhjRTFqTzhjd2s2?=
 =?utf-8?B?NmJjZ3BvVjgyT0xiZDRrTjRzYVFqQk80UTl2YStrZTNDUUt6cTJMdnFLVXlZ?=
 =?utf-8?B?Z3gwZ3AyN1V0WnVpbmxMc21WbmRNSko2bFpjZS84OFNaMktWMnRHY1MzL1dM?=
 =?utf-8?B?a3BWMkZOMGY0QWhqR1dkVWRtN2lqQ0hPTnQyQkErRzJ5RWdUUlpmRG52TTRz?=
 =?utf-8?B?U0taTFBLNGc0UDk2Z3NmdmN1R2h0OEZxT2hZZkFCbTJqcitBd1RJOTE3UHF0?=
 =?utf-8?B?Nm5rS3k4YlBzZzBJcXZTeTN2TnpRUUdtbFZSU2NyWUcvdXVjd0VxaFQ5Y1M4?=
 =?utf-8?B?SE9hQ3l1bWpsNFVwMTYyZEo3MjRjc2N3d1dha3ZQUUU5WlhDN3hxUlJPS1Z4?=
 =?utf-8?B?bWlEUXVLYkFScFNxY1M3WmlqOGdIdCtXQW0xcnB2WGlGTzVEcHE1VUNwaUd0?=
 =?utf-8?B?WERuOGFoeERDbm9jZlRiZWJkMlJyaDZEYm9XVG1MbzFLZUF1eHFKUlVLWHA2?=
 =?utf-8?B?bDF6QlpGc24wV3pSbGp1eUlrSzlPZjNTeHovWFJNQUNtUWlxSmNiK3YrVVVL?=
 =?utf-8?B?NHRudVRLTkNkL3RUdnhXckRjVWwvVXFzejJyc1dER1lLVU15QTRlOXlEQUF0?=
 =?utf-8?B?UUpQZTNHQnZJeEplSnRpY1ZSOXZQMkNFbzhkN3ZLeTdCdnJ2ancyQnJPNXJa?=
 =?utf-8?Q?7K24=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfcfe79-1793-4b6e-37ca-08db84208234
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 04:12:16.0896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVAukQDcUcb135viEIJQB9jweH87TKX5r+CCjsFMgcGXtjOeSOXWDq9YLEcCDvf13GTp1KFn/r0PiYBFC6ImMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "Gopalakrishnan, Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXggLA0KDQpSZXZlcnQg
Y2hhbmdlcyBhcmUgbWVyZ2VkLCB3aWxsIHJld29yayBvbiBjaGFuZ2VzIGFuZCBzdWJtaXQuDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVj
aGVyQGdtYWlsLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBKdWx5IDEzLCAyMDIzIDEwOjIyIFBNDQpU
bzogSmFtYWRhciwgU2FsZWVta2hhbiA8U2FsZWVta2hhbi5KYW1hZGFyQGFtZC5jb20+DQpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IE9sc2FrLCBNYXJlayA8TWFyZWsuT2xzYWtA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBM
aXUsIExlbyA8TGVvLkxpdUBhbWQuY29tPjsgR29wYWxha3Jpc2huYW4sIFZlZXJhYmFkaHJhbiAo
VmVlcmEpIDxWZWVyYWJhZGhyYW4uR29wYWxha3Jpc2huYW5AYW1kLmNvbT47IFN1bmRhcmFyYWp1
LCBTYXRoaXNoa3VtYXIgPFNhdGhpc2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIFJldmVydCAiZHJtL2FtZGdwdTogdXBkYXRlIGtlcm5lbCB2Y24g
cmluZyB0ZXN0Ig0KDQpPbiBUaHUsIEp1bCAxMywgMjAyMyBhdCAxOjIw4oCvQU0gU2FsZWVta2hh
biBKYW1hZGFyIDxzYWxlZW1raGFuLmphbWFkYXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFZDTiBG
VyBkZXBuY2VuY2llcyByZXZlcnQgaXQgdG8gdW5ibG9jayBvdGhlcnMNCg0KQWx0ZXJuYXRpdmVs
eSwgeW91IGNvdWxkIGZpeCBpdCBieSBhZGRpbmcgdGhlIGFwcHJvcHJpYXRlIGZpcm13YXJlIHZl
cnNpb24gY2hlY2tzIGlmIHRoYXQgaXMgdGhlIHVuZGVybHlpbmcgaXNzdWUuDQoNCkFsZXgNCg0K
DQo+DQo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZDBlZGZiZThiYzJkMThlZGU4ZjgwNWM2ZWI3MWM2
M2UwYjQwYzFkYS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2FsZWVta2hhbiBKYW1hZGFyIDxzYWxl
ZW1raGFuLmphbWFkYXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMgfCAyNQ0KPiArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPiBpbmRleCA1YzJhYTkyNWRk
NzkuLjg5NjZmZmIyZjRhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uYw0KPiBAQCAtNTM5LDcgKzUzOSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNf
c2VuZF9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkgIHsNCj4gICAgICAgICB1
NjQgYWRkciA9IEFNREdQVV9HUFVfUEFHRV9BTElHTihpYl9tc2ctPmdwdV9hZGRyKTsNCj4gLSAg
ICAgICB1aW50NjRfdCBzZXNzaW9uX2N0eF9idWZfZ2FkZHIgPSBBTURHUFVfR1BVX1BBR0VfQUxJ
R04oaWJfbXNnLT5ncHVfYWRkciArIDgxOTIpOw0KPiAgICAgICAgIHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gcmluZy0+YWRldjsNCj4gICAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICpmID0g
TlVMTDsNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOw0KPiBAQCAtNTUzLDIzICs1
NTIsMTMgQEAgc3RhdGljIGludCBhbWRncHVfdmNuX2RlY19zZW5kX21zZyhzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcsDQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4NCj4gICAgICAgICBp
YiA9ICZqb2ItPmlic1swXTsNCj4gLSAgICAgICBpYi0+bGVuZ3RoX2R3ID0gMDsNCj4gLSAgICAg
ICBpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBQQUNLRVQwKGFkZXYtPnZjbi5pbnRlcm5hbC5k
YXRhMCwgMCk7DQo+IC0gICAgICAgaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gbG93ZXJfMzJf
Yml0cyhzZXNzaW9uX2N0eF9idWZfZ2FkZHIpOw0KPiAtICAgICAgIGliLT5wdHJbaWItPmxlbmd0
aF9kdysrXSA9IFBBQ0tFVDAoYWRldi0+dmNuLmludGVybmFsLmRhdGExLCAwKTsNCj4gLSAgICAg
ICBpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSB1cHBlcl8zMl9iaXRzKHNlc3Npb25fY3R4X2J1
Zl9nYWRkcik7DQo+IC0gICAgICAgLyogc2Vzc2lvbiBjdHggYnVmZmVyIGNtZCAqLw0KPiAtICAg
ICAgIGliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IFBBQ0tFVDAoYWRldi0+dmNuLmludGVybmFs
LmNtZCwgMCk7DQo+IC0gICAgICAgaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMHhhOw0KPiAt
DQo+IC0gICAgICAgaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gUEFDS0VUMChhZGV2LT52Y24u
aW50ZXJuYWwuZGF0YTAsIDApOw0KPiAtICAgICAgIGliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9
IGxvd2VyXzMyX2JpdHMoYWRkcik7DQo+IC0gICAgICAgaWItPnB0cltpYi0+bGVuZ3RoX2R3Kytd
ID0gUEFDS0VUMChhZGV2LT52Y24uaW50ZXJuYWwuZGF0YTEsIDApOw0KPiAtICAgICAgIGliLT5w
dHJbaWItPmxlbmd0aF9kdysrXSA9IHVwcGVyXzMyX2JpdHMoYWRkcik7DQo+IC0gICAgICAgaWIt
PnB0cltpYi0+bGVuZ3RoX2R3KytdID0gUEFDS0VUMChhZGV2LT52Y24uaW50ZXJuYWwuY21kLCAw
KTsNCj4gLSAgICAgICBpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSAwOw0KPiAtDQo+IC0gICAg
ICAgZm9yIChpID0gaWItPmxlbmd0aF9kdzsgaSA8IDE2OyBpICs9IDIpIHsNCj4gKyAgICAgICBp
Yi0+cHRyWzBdID0gUEFDS0VUMChhZGV2LT52Y24uaW50ZXJuYWwuZGF0YTAsIDApOw0KPiArICAg
ICAgIGliLT5wdHJbMV0gPSBhZGRyOw0KPiArICAgICAgIGliLT5wdHJbMl0gPSBQQUNLRVQwKGFk
ZXYtPnZjbi5pbnRlcm5hbC5kYXRhMSwgMCk7DQo+ICsgICAgICAgaWItPnB0clszXSA9IGFkZHIg
Pj4gMzI7DQo+ICsgICAgICAgaWItPnB0cls0XSA9IFBBQ0tFVDAoYWRldi0+dmNuLmludGVybmFs
LmNtZCwgMCk7DQo+ICsgICAgICAgaWItPnB0cls1XSA9IDA7DQo+ICsgICAgICAgZm9yIChpID0g
NjsgaSA8IDE2OyBpICs9IDIpIHsNCj4gICAgICAgICAgICAgICAgIGliLT5wdHJbaV0gPSBQQUNL
RVQwKGFkZXYtPnZjbi5pbnRlcm5hbC5ub3AsIDApOw0KPiAgICAgICAgICAgICAgICAgaWItPnB0
cltpKzFdID0gMDsNCj4gICAgICAgICB9DQo+IC0tDQo+IDIuMjUuMQ0KPg0K
