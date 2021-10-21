Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3FAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACAE60FD8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DACAE60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630926ECD4;
	Thu, 21 Oct 2021 16:49:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3417A6ECD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzTWi7YGQGiydxsdmluUn+5yu9cSVpfZtoXe4FQ1EU8UUsbDJCPvu7FksXOLrgFM98OQUg/v9IeGvlW0Lsd3epy6b0GqlUBlWOOYaSZKu9ljoXLauJHXPFiF9KcIa0rQtlwD2J0Z3m0B5/atKU0EXPLyg3UnOQPIkt+Ob83IrvluD2emB8f4S7PgJ0Os6kjie+Nqlbxj0HXSCyQaundGfzoBdGQJum3n/t7f0989riuTc3rIUTgfcMyi+U9P4derIRBuEDIHUJ+RKwhWww3B1df06YS+0m+QRZuacYmgkA339kFw+JUMrte27TnsW9qSENj8QmWTJCgaEWtqSW5C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y9HLu6CIsmg4ixikFpB2k2lcrCnUJBY4ST9gf/81l8=;
 b=bHVfu01vZvdluI0Gs7Yt9ahdSi4tXk7W6yJJ+UCgTdv8hIn0IEJj3HM0xvFt9UgZN21y3FW5kzqJhfcBQ/rOjzHqM7JaB1x7WW9J54NAKey6g4GbXhtkxKq5V5xY0+PTsUxVDdyRfA+NzulBEFxe2P7bDl5JobQNPwI3cpyykMO7vU9tf3HO+vS8Rz1/jrZ2kePfJ5WrspgSrTvAYjbEZ2Z36oPenDhQTcalOfqVXyiSx+IRshFuC2MxXN/88HbXtzeieMJwhhq9YJyppxLZYGO5IR+DPgWUhwjf1fe/+96uA38rwKrQss2u/qb8bj/Ngxyw7QQoQiIRs4xQBBQ26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Y9HLu6CIsmg4ixikFpB2k2lcrCnUJBY4ST9gf/81l8=;
 b=sTZmVnwueqd/T+O2tPkqHQpO+e7WSrqMqBS1g3pWO7yqaDgTi2Z1uQW0cUDAM1pSpH7CJjxxA+Yvr6m8yjz1kZT3HlE/IxFj1a7kxpTE91M0vUPe6VaHdIrEgliLPu+0IaQOIRqMMGP0cvGL4uAASGVFlvGGm5T6EJohMRTk1VM=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4747.namprd12.prod.outlook.com (2603:10b6:5:30::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 16:49:06 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:49:06 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring
 bad page threshold
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for
 ignoring bad page threshold
Thread-Index: AQHXxpTqXezHY5DBVkSA/VmHl8QW+6vdoisAgAAEY3CAAAK5AIAAAGaA
Date: Thu, 21 Oct 2021 16:49:06 +0000
Message-ID: <DM6PR12MB33243CD65F93A887F212569A85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <20211021155711.1191830-2-kent.russell@amd.com>
 <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
 <DM6PR12MB332402EACCE9F2EC589B2DF285BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <57a2fca7-0da8-55d6-d545-7c0dcf598628@amd.com>
In-Reply-To: <57a2fca7-0da8-55d6-d545-7c0dcf598628@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-21T16:49:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=db36c3d7-d0dc-4700-97f4-477cf071d310;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98db9f20-3a1b-42f5-7bce-08d994b2b238
x-ms-traffictypediagnostic: DM6PR12MB4747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB47470351F51B9D37EF545F4085BF9@DM6PR12MB4747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WRF1abbmkbIhxqG69EqHwJ1+VsyAG4vM6ZfTN2eLf1JvloWRR1NLCjBOALBnhVZe2CY7EIjEmdz++c3ve7c6ScyasWea+5RP5SD4wUUdu+tXojQsULmMIReQHG/o7ONTPZZF+kE44oDi6S6+X5iVQZr4YzxI7jrAkg2rHoa+m8CoO6g2Yl3rV3XRjsTIW6VGzxV3zehJDGNvDdHe6xFiMq1lnm/6vdxnEYwMopzo8zH+72U2bYACMcLR7ErQhEPJXlIt/vsvHycNaOTuySo5YQjeXmoFA/M5TJwvAluSH9QGK1OGPtBN4s9LyQAVQVjGBFAZn5kMwGoRcweiTYLuK00uNC9Ny3Q4j1urki9d8k2Gm2L5dea8ypvTvP/VDq+dGsJa0p9ZWk1jPxePKILPfwVO2pPeUYqQZ36NpQz6nXvImlSTmvaFJoUgsNZqX2g+CRqf3UyDjrE1loBjzOngRpHsr18G8F0ZkuyWFjGtgWdQMvvkZwoV7QsS6xz2ILbIWco2CwggG5CyUIZTaIr8icKZqfujEoJIR5UgRtxaonSlOFlLVIm1c/QbRrOhtnzBRGk4F9zKNhGk1tT3TtuF7/QOWRoIjmWZxVU7hsxY9+UN2pqCd6NIoK0nNnLz/tfqjy3O228tLaENa7yxbgNXFJVx2FipN4rUsp7oCDMIadIzPxGp84qPYOqSPAdC5YT/cANmnEb8McTXtD3O08/fAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(66446008)(66946007)(64756008)(86362001)(4001150100001)(83380400001)(6506007)(508600001)(9686003)(4326008)(33656002)(76116006)(8676002)(53546011)(316002)(8936002)(122000001)(71200400001)(38100700002)(52536014)(38070700005)(186003)(54906003)(110136005)(2906002)(55016002)(7696005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRTK0pDVVBzVG94dStoYU45eWlIcG9VLzVMSzdtem1oSE9VV2pDQ0tvZlM5?=
 =?utf-8?B?blFvUEJCVi9WdXBBdEdmYUVXOFllVEx6NmJsdXF6UFFtRm9weitEeUJoZmMv?=
 =?utf-8?B?ayt2UDc4MTVVN2VJUWcwZGMrY214Z0NpRjFpV2lvYVpuUENlUkZOQ1VWYkVt?=
 =?utf-8?B?NjZGSTk3dGZUeDZ0eU5hY0ZXenB6WEhzTTVaWEdzcmtLQmdPV0lDZzRCbFQ3?=
 =?utf-8?B?bko3dXBRQVBIUEc4RU4wbldsMVFLZ0prL3AvNWJsdnJpTjR1NGpvQ2lEZWRa?=
 =?utf-8?B?a2l0L1IxWjlLb2c5OG1HS0dtdkhCdEZSMk9zamVMc0ZQbVlhQ244U2RkRy8x?=
 =?utf-8?B?dk8ybCtiQ1BFbUZaSThZWTM3SUJBTGdZYlZZN3NwQ0YrYzNGUlhQb2tyakl6?=
 =?utf-8?B?a0xTMHpUeUF6R1lrRE5yYlFYZ0poWjYwY0IrUHcwa1orTDFib0dxQ2dkbzN1?=
 =?utf-8?B?QUlOa3RTTFFwMnliSjNsSlAyYnZiNVF6NUNrcTd1UVk3RVBBR3R5elR3T0Vi?=
 =?utf-8?B?Sm1DS2tJbTlNLy9yT29uSTR1bzhxeXQxeHUweExUaDRreGpHYVB0T0owNXFG?=
 =?utf-8?B?OHdraVM0SzZHWGloOGxwUWJEMDBEVmI5WHFMTExPajJlRkkyKy93bDlDSnNC?=
 =?utf-8?B?b200YURFZXdVbEYzK1ZZekVNV1Rua1JmdTQ1bVo3UTRraUNVOFpXemRDcHhH?=
 =?utf-8?B?cHllVU02L04yWVp6d1JHN1pVb0hMbjIvazBBZjllM1g2QWJhNVB4TTFlb3NL?=
 =?utf-8?B?S1pTQlNzZmFsMlZyN3FHSUNSQmUrRmNOTnNiMW9LVDlLL0dGSWRKT3dML09T?=
 =?utf-8?B?cU1MMmJvRTZCOXpCWDFORTY2bFlrMU5CdVFuMk1xa1d3Q0VTb1VqcFdhQTFF?=
 =?utf-8?B?c0FycDJ4bG4wVjBML09YcnNpeEsweHBYOVg2ZHg0ck9IUEVKemI4eUlDN2Jw?=
 =?utf-8?B?TmR3VUE1TVpaNlpqVXRXMXpPZE81VS8wanlHWTVlSVdIS05BcHdJYXVieEtZ?=
 =?utf-8?B?Z1FyYU9QR1RPL1JrVXJJRCthL3NaYndYS05aTmNWeXdxU3E4bzYwTHMvTVV0?=
 =?utf-8?B?K3RZZlFia1dVUEFYbkZsLzhYdFhiYnpSR2o5UnMwblg4K2doUXV4b1RVK0FN?=
 =?utf-8?B?RkxlMTk2c3JDUTg0ZXg0RTlqeXYrN3ZYVUxLNmtjZVBRSFpGN255OEdXdVBB?=
 =?utf-8?B?bmlrSlFQenZLWHR4aDZFOU8zNTZOWE9FdmxlK1UvWnB3ODI4LzdSbGJJRmtz?=
 =?utf-8?B?OFdRbE1wa3JYMDRlRzNlK2NjWVF0NzhzYUZXMEcyQlVhRVVuK2wvSGp3V3Fu?=
 =?utf-8?B?d09SajkxcnFEN3hiRGZsemxrMG9rMENXejBObW9Zd2s4NVVBem5LcVYydEI0?=
 =?utf-8?B?RFdFc1JBSGpWYmhYODJjMXdUakVuTS8yNE4yZHY4RjMzN2R0elN4NU9zNEdT?=
 =?utf-8?B?S1I2YUlDYUJ6a3QxN0dsR2k5dENTMUExV0E3MGpJTUFWL25QcTlNWWpBeDE2?=
 =?utf-8?B?cjBPL0FiRjNrcm5DVGdzaUpnbjlENkVGZlVndGxwdy9pN3gzM2xNQWh5d3FH?=
 =?utf-8?B?b3F4YTlnQ0tGeWdFQ0pkNHh4VjVnRy9sVWdHZE50RHVPVSsxeU14cWZlZXd0?=
 =?utf-8?B?Q3BaTkh1L25WSGdSQktFb0JNdWFOMWxTTW00bzNUWXFYY1VhR1kyNEt2bmdZ?=
 =?utf-8?B?QUkwcWQrb0Q5WEh0UWFTdEpKalJ4ajhzNUxxTUZwVDN5ZUJXRjVtSk52c0dT?=
 =?utf-8?B?T2NNSldJemRRQitrSXVFbG44TmJpbHhiNUoxdFhJREl4RzFKWWwvRHZ0Z0VB?=
 =?utf-8?B?dEJTd0VFVmRacFhmQ0ZDdnV5SlgwTTVmMndjdXNBNG5vblo2YU42SXFxNVg4?=
 =?utf-8?Q?GGe3xOL8ibVqV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db9f20-3a1b-42f5-7bce-08d994b2b238
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 16:49:06.4131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krussell@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4747
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogVHVpa292LCBMdWJlbiA8THViZW4uVHVpa292QGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDIxLCAyMDIxIDEyOjQ3IFBNDQo+IFRvOiBSdXNzZWxsLCBLZW50
IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0v
YW1kZ3B1OiBBZGQga2VybmVsIHBhcmFtZXRlciBzdXBwb3J0IGZvciBpZ25vcmluZyBiYWQgcGFn
ZQ0KPiB0aHJlc2hvbGQNCj4gDQo+IE9uIDIwMjEtMTAtMjEgMTI6NDIsIFJ1c3NlbGwsIEtlbnQg
d3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0KPiA+DQo+ID4NCj4gPj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVHVpa292LCBMdWJlbiA8THVi
ZW4uVHVpa292QGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDIxLCAyMDIx
IDEyOjIxIFBNDQo+ID4+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBKb3NoaSwgTXVrdWwgPE11
a3VsLkpvc2hpQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+Ow0KPiA+PiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IEFkZCBrZXJuZWwgcGFyYW1ldGVyIHN1
cHBvcnQgZm9yIGlnbm9yaW5nIGJhZA0KPiBwYWdlDQo+ID4+IHRocmVzaG9sZA0KPiA+Pg0KPiA+
PiBPbiAyMDIxLTEwLTIxIDExOjU3LCBLZW50IFJ1c3NlbGwgd3JvdGU6DQo+ID4+PiBXaGVuIGEg
R1BVIGhpdHMgdGhlIGJhZF9wYWdlX3RocmVzaG9sZCwgaXQgd2lsbCBub3QgYmUgaW5pdGlhbGl6
ZWQgYnkNCj4gPj4+IHRoZSBhbWRncHUgZHJpdmVyLiBUaGlzIG1lYW5zIHRoYXQgdGhlIHRhYmxl
IGNhbm5vdCBiZSBjbGVhcmVkLCBub3IgY2FuDQo+ID4+PiBpbmZvcm1hdGlvbiBnYXRoZXJpbmcg
YmUgcGVyZm9ybWVkIChnZXR0aW5nIHNlcmlhbCBudW1iZXIsIEJERiwgZXRjKS4NCj4gPj4+DQo+
ID4+PiBJZiB0aGUgYmFkX3BhZ2VfdGhyZXNob2xkIGtlcm5lbCBwYXJhbWV0ZXIgaXMgc2V0IHRv
IC0yLA0KPiA+Pj4gY29udGludWUgdG8gaW5pdGlhbGl6ZSB0aGUgR1BVLCB3aGlsZSBwcmludGlu
ZyBhIHdhcm5pbmcgdG8gZG1lc2cgdGhhdA0KPiA+Pj4gdGhpcyBhY3Rpb24gaGFzIGJlZW4gZG9u
ZQ0KPiA+Pj4NCj4gPj4+IENjOiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPg0K
PiA+Pj4gQ2M6IE11a3VsIEpvc2hpIDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiA+Pj4gU2lnbmVk
LW9mZi1ieTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPj4+IEFja2Vk
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gPj4+IFJldmll
d2VkLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+
ID4+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggICAgICAgICAgICB8ICAx
ICsNCj4gPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgICAg
IHwgIDIgKy0NCj4gPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2Vl
cHJvbS5jIHwgMTIgKysrKysrKystLS0tDQo+ID4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4+PiBpbmRleCBkNThlMzdmZDAxZjQuLmI4NWI2N2E4OGEz
ZCAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
DQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+Pj4g
QEAgLTIwNSw2ICsyMDUsNyBAQCBleHRlcm4gc3RydWN0IGFtZGdwdV9tZ3B1X2luZm8gbWdwdV9p
bmZvOw0KPiA+Pj4gIGV4dGVybiBpbnQgYW1kZ3B1X3Jhc19lbmFibGU7DQo+ID4+PiAgZXh0ZXJu
IHVpbnQgYW1kZ3B1X3Jhc19tYXNrOw0KPiA+Pj4gIGV4dGVybiBpbnQgYW1kZ3B1X2JhZF9wYWdl
X3RocmVzaG9sZDsNCj4gPj4+ICtleHRlcm4gYm9vbCBhbWRncHVfaWdub3JlX2JhZF9wYWdlX3Ro
cmVzaG9sZDsNCj4gPj4+ICBleHRlcm4gc3RydWN0IGFtZGdwdV93YXRjaGRvZ190aW1lciBhbWRn
cHVfd2F0Y2hkb2dfdGltZXI7DQo+ID4+PiAgZXh0ZXJuIGludCBhbWRncHVfYXN5bmNfZ2Z4X3Jp
bmc7DQo+ID4+PiAgZXh0ZXJuIGludCBhbWRncHVfbWNicDsNCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPj4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPj4+IGluZGV4IDk2YmQ2M2FlZWRkZC4u
ZWVlM2NmODc0ZTdhIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jDQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMNCj4gPj4+IEBAIC04NzcsNyArODc3LDcgQEAgbW9kdWxlX3BhcmFtX25hbWVk
KHJlc2V0X21ldGhvZCwNCj4gYW1kZ3B1X3Jlc2V0X21ldGhvZCwNCj4gPj4gaW50LCAwNDQ0KTsN
Cj4gPj4+ICAgKiByZXN1bHQgaW4gdGhlIEdQVSBlbnRlcmluZyBiYWQgc3RhdHVzIHdoZW4gdGhl
IG51bWJlciBvZiB0b3RhbA0KPiA+Pj4gICAqIGZhdWx0eSBwYWdlcyBieSBFQ0MgZXhjZWVkcyB0
aGUgdGhyZXNob2xkIHZhbHVlLg0KPiA+Pj4gICAqLw0KPiA+Pj4gLU1PRFVMRV9QQVJNX0RFU0Mo
YmFkX3BhZ2VfdGhyZXNob2xkLCAiQmFkIHBhZ2UgdGhyZXNob2xkKC0xID0gYXV0byhkZWZhdWx0
DQo+ID4+IHZhbHVlKSwgMCA9IGRpc2FibGUgYmFkIHBhZ2UgcmV0aXJlbWVudCkiKTsNCj4gPj4+
ICtNT0RVTEVfUEFSTV9ERVNDKGJhZF9wYWdlX3RocmVzaG9sZCwgIkJhZCBwYWdlIHRocmVzaG9s
ZCgtMSA9IGF1dG8oZGVmYXVsdA0KPiA+PiB2YWx1ZSksIDAgPSBkaXNhYmxlIGJhZCBwYWdlIHJl
dGlyZW1lbnQsIC0yID0gaWdub3JlIGJhZCBwYWdlIHRocmVzaG9sZCkiKTsNCj4gPj4+ICBtb2R1
bGVfcGFyYW1fbmFtZWQoYmFkX3BhZ2VfdGhyZXNob2xkLCBhbWRncHVfYmFkX3BhZ2VfdGhyZXNo
b2xkLCBpbnQsDQo+IDA0NDQpOw0KPiA+Pj4NCj4gPj4+ICBNT0RVTEVfUEFSTV9ERVNDKG51bV9r
Y3EsICJudW1iZXIgb2Yga2VybmVsIGNvbXB1dGUgcXVldWUgdXNlciB3YW50IHRvDQo+IHNldHVw
DQo+ID4+ICg4IGlmIHNldCB0byBncmVhdGVyIHRoYW4gOCBvciBsZXNzIHRoYW4gMCwgb25seSBh
ZmZlY3QgZ2Z4IDgrKSIpOw0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMNCj4gPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+ID4+PiBpbmRleCBjZTUwODkyMTY0NzQuLmJkNmVk
NDNiMGRmMiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXNfZWVwcm9tLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXNfZWVwcm9tLmMNCj4gPj4+IEBAIC0xMTA0LDExICsxMTA0LDE1IEBAIGludCBh
bWRncHVfcmFzX2VlcHJvbV9pbml0KHN0cnVjdA0KPiA+PiBhbWRncHVfcmFzX2VlcHJvbV9jb250
cm9sICpjb250cm9sLA0KPiA+Pj4gIAkJCXJlcyA9IGFtZGdwdV9yYXNfZWVwcm9tX2NvcnJlY3Rf
aGVhZGVyX3RhZyhjb250cm9sLA0KPiA+Pj4gIAkJCQkJCQkJICAgUkFTX1RBQkxFX0hEUl9WQUwp
Ow0KPiA+Pj4gIAkJfSBlbHNlIHsNCj4gPj4+IC0JCQkqZXhjZWVkX2Vycl9saW1pdCA9IHRydWU7
DQo+ID4+PiAtCQkJZGV2X2VycihhZGV2LT5kZXYsDQo+ID4+PiAtCQkJCSJSQVMgcmVjb3Jkczol
ZCBleGNlZWQgdGhyZXNob2xkOiVkLCAiDQo+ID4+PiAtCQkJCSJHUFUgd2lsbCBub3QgYmUgaW5p
dGlhbGl6ZWQuIFJlcGxhY2UgdGhpcyBHUFUgb3IgaW5jcmVhc2UgdGhlDQo+ID4+IHRocmVzaG9s
ZCIsDQo+ID4+PiArCQkJZGV2X2VycihhZGV2LT5kZXYsICJSQVMgcmVjb3JkczolZCBleGNlZWQg
dGhyZXNob2xkOiVkIiwNCj4gPj4+ICAJCQkJY29udHJvbC0+cmFzX251bV9yZWNzLCByYXMtPmJh
ZF9wYWdlX2NudF90aHJlc2hvbGQpOw0KPiA+PiBJIHRob3VnaHQgdGhpcyB3b3VsZCBhbGwgZ28g
aW4gYSBzaW5nbGUgc2V0IG9mIHBhdGNoZXMuIEkgd2Fzbid0IGF3YXJlIGEgc2luZ2xldG9uIHBh
dGNoDQo+IHdlbnQNCj4gPj4gaW4gYWxyZWFkeSB3aGljaCBjaGFuZ2VkIGp1c3QgdGhpcyBsaW5l
LS10aGlzIGNoYW5nZSB3YXMgYWx3YXlzIGEgcGFydCBvZiBhIHBhdGNoIHNldC4NCj4gPj4NCj4g
PiBBaCBzb3JyeS4gV2hlbiB5b3UgcmV2aWV3ZWQgdGhlIG9yaWdpbmFsIHBhdGNoMiBjbGFyaWZ5
aW5nIHRoZSBtZXNzYWdlLCBJIG1lcmdlZCBpdCBhbmQNCj4gdGhlbiByZS1zdWJtaXR0ZWQgdGhl
IHJlbWFpbmluZyAzICh3aGljaCBwYXJlZCBkb3duIHRvIDIpIGZvciByZXZpZXcuIFNvcnJ5IGZv
ciB0aGUNCj4gY29uZnVzaW9uLCBJIHdhcyB0cnlpbmcgdG8gbWluaW1pemUgdGhlIG51bWJlciBv
ZiBtb3ZpbmcgcGFydHMuDQo+IA0KPiBBZG1pdHRlZGx5LCBub3cgeW91IGhhdmUgMyBwYXRjaGVz
LCBvbmUgc2luZ2xldG9uIGFuZCB0d28gY29taW5nIGluLiBXb3VsZCd2ZSBwcm9iYWJseQ0KPiBi
ZSBiZXN0IHRvIHN1Ym1pdCBvbmx5IHRoZSBjdXJyZW50IHR3by4NCj4gDQo+IE5vIHdvcnJpZXMg
Zm9yIG5vdy0tZm9yIHRoZSBmdXR1cmUuDQoNClRoYW5rcy4gRm9yIHRoZSBtb3N0IHBhcnQsIGFs
bCBvZiBteSBwcmV2aW91cyBtdWx0aS1wYXRjaCBzZXRzIGhhdmUgYmVlbiBhbGwtb3Itbm90aGlu
Zy4gVGhpcyBpcyB0aGUgZmlyc3QgdGltZSB0aGF0IGEgcGF0Y2ggaW4gdGhlIG1pZGRsZSBnb3Qg
YW4gUkIgYmVmb3JlIHRoZSByZXN0LCBzbyBJIGRpZCB0aGUgd3JvbmcgdGhpbmcgYW5kIG1lcmdl
ZCBpdCB3aGlsZSB0aGUgcmVzdCB3YXMgc3RpbGwgbW92aW5nLiBUaGFua3MgZm9yIGJlYXJpbmcg
d2l0aCBtZSENCg0KIEtlbnQNCg0KPiANCj4gUmVnYXJkcywNCj4gTHViZW4NCj4gDQo+ID4NCj4g
PiAgS2VudA0KPiA+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IEx1YmVuDQo+ID4+DQo+ID4+PiArCQkJ
aWYgKGFtZGdwdV9iYWRfcGFnZV90aHJlc2hvbGQgPT0gLTIpIHsNCj4gPj4+ICsJCQkJZGV2X3dh
cm4oYWRldi0+ZGV2LCAiR1BVIHdpbGwgYmUgaW5pdGlhbGl6ZWQgZHVlIHRvDQo+ID4+IGJhZF9w
YWdlX3RocmVzaG9sZCA9IC0yLiIpOw0KPiA+Pj4gKwkJCQlyZXMgPSAwOw0KPiA+Pj4gKwkJCX0g
ZWxzZSB7DQo+ID4+PiArCQkJCSpleGNlZWRfZXJyX2xpbWl0ID0gdHJ1ZTsNCj4gPj4+ICsJCQkJ
ZGV2X2VycihhZGV2LT5kZXYsICJHUFUgd2lsbCBub3QgYmUgaW5pdGlhbGl6ZWQuIFJlcGxhY2Ug
dGhpcw0KPiA+PiBHUFUgb3IgaW5jcmVhc2UgdGhlIHRocmVzaG9sZC4iKTsNCj4gPj4+ICsJCQl9
DQo+ID4+PiAgCQl9DQo+ID4+PiAgCX0gZWxzZSB7DQo+ID4+PiAgCQlEUk1fSU5GTygiQ3JlYXRp
bmcgYSBuZXcgRUVQUk9NIHRhYmxlIik7DQo=
