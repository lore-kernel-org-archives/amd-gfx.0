Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EC9C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA7810E1C5;
	Thu, 30 Mar 2023 13:56:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B9B10E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eh/zPoHBPzZARdHmuZaKSMvxcPwWwrqOQ0bcM6SQR4yhnAKkiAYQedqC25g59d90ybvNy2XAZkq/iQ/G2U93TZP9FybgPDoOeRd4+SeaLGEDTHPhKQ2qdEYhmetPOCoYtoPszWmyBwjbfE1FQ+1z6pd2ZJ0SOsOSEZIekSlOdnpr/swGzmf8pV6oCcevhsSziHhdaFiH+5JA2f2V64qPEgOW/GpZ8u7Q3JGltjVOIQWzv1r/s8lAsefSIoY8PLd12kSzklZUZOEtpmjuEssgbmITCeSsdtNiFsXihBrAYSLIlnStBEo3UdNpoc3EbxTCghxGEqKBLCb6LkXxd30ayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xic19oucAmLXiuw7eeFANugd/qC4hDZjNJ6ryANEnWc=;
 b=QrDJXSDQEFzy7fwNG2FXNA6pDqKF7RFAcpbjuDo4CgG8Rdz417PYHBossVAFa6dOm4fXz5SoxyptOl+9ukxVhSmz0Pf4+DTwwCTgwFg0kF3RkrE9ouJTENDjI7VOfa3DbgxGfr9iUYTxbQ0ZVi9VbHja9S1bbaXK5TetSvdU5wOk7SSXZDGx/mYaODvDnAfLBTLiGT0V7PiXTIhpRaP5W+cdXcWhIv1vY1NmUt5c9JRN7mHeRysQR88wjqr1/E2d5gneQ4e8fRbFfzQih3w0MpBycW5OhqC/0WNC2f5det9EB601ywHerOr7OHlUQs9fWgBkAicKYi3vT0Ljr5v14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xic19oucAmLXiuw7eeFANugd/qC4hDZjNJ6ryANEnWc=;
 b=w1PkFiq0M8N/rnmzAqBdTWclKlYOz8qXB9xl3Hk4Q2rCMBzHus8YzhbakznWNLjA9TdqlkHRuEX+sm2rJ3inIjQ+OcHb0iaP/nl57JXaWZzWyhEZNC8JEon5qR5QVqPmXYCgHfF95S/M05Zx0KIYKFFJ5ZFyhJPReLks6A5y88M=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 13:56:22 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 13:56:22 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/16] AMDGPU Doorbell manager
Thread-Topic: [PATCH 00/16] AMDGPU Doorbell manager
Thread-Index: AQHZYlXgToVfsNNOgk+WSh+VmfibYa8TWDyAgAABgIA=
Date: Thu, 30 Mar 2023 13:56:22 +0000
Message-ID: <MW4PR12MB56673709ADB4A7D266B226E1F28E9@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <6effdd2f-b73d-1b10-4eb6-1c8563d98fc2@amd.com>
In-Reply-To: <6effdd2f-b73d-1b10-4eb6-1c8563d98fc2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T13:56:20Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdeffdf9-4f35-409c-9339-804b0f1300bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|PH7PR12MB5831:EE_
x-ms-office365-filtering-correlation-id: cd9fa2eb-4ef6-45f3-6cf5-08db31268b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RThkijpA3lEx2KEE3wsPA4Io74s5XJuBrvdh42o9KRXz9XP/bNsH/37aQbsiILMcWLIiHRkzG3LIyf9kMOHT8i/qPwQJzeJBoQMA4ymvvQRaM1E5BM/HKi5Ng0rYAhp7TMZfLsiyGYIE8VQV4mhttnkhe8tZ0/YwWs09E5UL1IjkbMahPP5WAWu2mPc8c34sBrD/9C40XayesUAleiWhupQB4KRmxrRL/j0JFcie65Q6GQRMHlHRPrQAnGkxGEzaKiehFHXHEGFv1m6Iuf6RsnhR8JmGKO0GaBPuj0+nxx3eF/JDQJ2GVbDk8OasRKBwoM00/PSLV3a19SEMJpFktTaxO798qtLxNP8fCLJ/2pGXOiZj9+K3KmSWItG5ff1yBGtcKN1NsTQILwacTHdHUykPpU49oqRBHLtwqSeL61Q4GBuqzhpe9HjE4L8evOidGKD5lkGp9nqv5LQfJdxEjg4vF8qaRkhnopAZ7I050yhusc7qcbn8CvK+9nOR2BDlORaBTfFZL5gKVz3tWmNzQMK5yET6uYUiSBvoUFzgWgJEb26zUwM7tF9LV6EfGwg+zza7UM7rNdIQNtYJmktonYbvglx3o3BrIhq9NW3LaImm7lYKtPMsfbCRlOZ1Fq1+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(55016003)(66446008)(66476007)(66946007)(76116006)(64756008)(54906003)(4326008)(66556008)(8936002)(41300700001)(5660300002)(316002)(110136005)(52536014)(38100700002)(8676002)(122000001)(186003)(9686003)(6506007)(53546011)(7696005)(71200400001)(478600001)(26005)(83380400001)(86362001)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJvOHllZWV0dGtuZmZqSlNBL2pIVnoreFg2c2pvbWlQNHBBUkpUT3VKbXha?=
 =?utf-8?B?UkNFWUZ4OXV4TXozTHpnTHYrY0VWSVFRR0JFMlhiVFN4L3lkTDlXSllyYTls?=
 =?utf-8?B?TVBxY1htN0Z6MVR1VFNEemFUNEVsN1hyR3Z3Z1FyUWduKzV1YVU1Vm1UREVY?=
 =?utf-8?B?LzNCNGhFai9Nd3grNXR6L1hsdjEwYW84ckxuWGZYQXYvN3UydjBmaTdsMzFQ?=
 =?utf-8?B?M3RoNW9GRHdmU21GQXNIVHl0cDh5dE1LR0dVN0QrMVRlSFYwYlhKdGtjSnZn?=
 =?utf-8?B?K3N2L3NBOGVRZFFJS2NyNFlZL01rMUNFYSs1dWVNak5RMUdXbFN2cmIvcTNw?=
 =?utf-8?B?Q1dwTFh4Q3hDYUFOdUdJTXdTZHFDSkQ0WCtyUFZHZ2x2VDJ2b0krYUlVc1FG?=
 =?utf-8?B?cTB5dG5rRVo0QjVOYVZFOVA1dTdzemxnTmNUaXgvcm91VWQ3cGNLSFV6dGhG?=
 =?utf-8?B?a0NMWHJibG5KQ2dOK3RhM051aVhSeWU0VkRkRkJrcWJFeEhiM2RIcnltL1NE?=
 =?utf-8?B?WGlrcU1DK0hqY050MUxlZGY0OFIxR09FcUF4dEtEbEpER0l4R1A3TE9xaG0r?=
 =?utf-8?B?M3k2VVVxT2VJVVZHVUh6Z2lmdXEzUXVuOHFuWXB1cDB5V2RtU2FuZml6QWRO?=
 =?utf-8?B?L3I4YU0zckUzNytSYjRXNTlqZHdCVzFlRGJQL1c3am05THJwU3FHM2ZNc3pv?=
 =?utf-8?B?U2hGVXYzNENzM1I1Y3BUbURweHFhdzEySG9BT2tZSFhBQml4cWpCQURjMzN3?=
 =?utf-8?B?YTBmSzlZVE9qNTFQd3JXQmwzRTRuSlo2ZU9SS2sxWUtVN3hkanBYMERPMVhR?=
 =?utf-8?B?cWtyQzFjOFh6WERYQ2QrbDBING1BRmp3aU5lTUxRamNsb2pSS2tkYjRVTHZP?=
 =?utf-8?B?Qk9CSkhpczhBWUJVZXZxeG5qdGs4VmtFLyt4Y1Q4REwrYjVRRVVmYTcyQVhw?=
 =?utf-8?B?NklSSm53L3dieUNJaEg2TExvTVBtUmJaaXljeU9zRTdQWFNJWUVlM09lK1B2?=
 =?utf-8?B?MGozY005UVl6alpuQ1M3STFuUEw3WHc3ZHV5WTNuVDNMcTJiUkpzR2tQT0pG?=
 =?utf-8?B?UngwUHJtN1NXK3M0MHFvaUVFd2t4ZXdiQlRzQ1cza3hSNFJKMGhES0l1U08w?=
 =?utf-8?B?MXVCcnUvejNFTWJzNW5GbDdQSk5kbVcya3ZTSlhJQ1Z1L2NENHVNclZzR2Mr?=
 =?utf-8?B?TnR1eFFITlJ5bXZMU2RERWZJbGNpUGE5N3FPRkhvMHhtM3ZweEZKekpWVHcy?=
 =?utf-8?B?dU9nMTRtM2U0aXBRaW1razl6a082d0ExV3owTGVhWXZseTFNZnd3RzhwYVpG?=
 =?utf-8?B?dDBYYUFFM2NiK2ErbUdIZFROU2lIcEhOZXpQcXBoWXV4eHpRMy82K083b2Qr?=
 =?utf-8?B?Tk5CNzhDRGVjUk5kUUxZQjF4MHBQZjJlWEFvZUFZOUk4Ujc4ODNaYk0wTWRJ?=
 =?utf-8?B?MlQ4TTZDN0Q3aFNveTJMbkU2YXhBYk1ON0tmQnJHMngxRlBLbzBMeE9vSnFo?=
 =?utf-8?B?R3ErVmJhcCtHNXdEb1BXOFdnVTRXZmxZa3FQNUl1eERuYVgvejQ3b3E4Vm04?=
 =?utf-8?B?cWFnekNHY3h6OFFKSXJYcUpwSXNoYmFrVmZkck5takN5K0N3cmxmSHdxbW9x?=
 =?utf-8?B?MVZaWU84QVdMMm5sTlFDTHdBZ08vME5ITW4wYVhZYkdLL3JiZGtSL1Yxam5W?=
 =?utf-8?B?QkFTK3IwbXA2S0U1UzUyemgvOFdEcnl6b1d5ODBoRmlBd3hlQ1V2SmwyN2JE?=
 =?utf-8?B?SjdULzFTK0hrMUkvQWh5ZlIzaVUzVTFTNURzMmtEUnZLWE1ORDNTemttaStT?=
 =?utf-8?B?NGJ1SWFKRTZMS3B1WFZTYW5icHpmZjdBV0R6RzlOZm9HU081MG5kMGpxdFFF?=
 =?utf-8?B?YlRzK3YrR2l3NzN1cU9paXNSTllhUXN5L2h3bE04RnZaMFZTeUFsSHdnOFA5?=
 =?utf-8?B?aWJVWXZSNHhpeEkrcEVVWTFvSkJkMG9YYStCbnprdHRUeGJQNzg5bXRzcmFC?=
 =?utf-8?B?ZFVYcVovNldLY2xTSHBoNXgxS3F2MDVIV1NMVU5ZS0FMVlE2NmhuNXVLZUho?=
 =?utf-8?B?aWdzU0x3RWM3UkttNkxsT2ZEYmkrZmVLaHZ0RHhIUDdKUmVsSHVOR0hnNWlj?=
 =?utf-8?Q?wsH4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9fa2eb-4ef6-45f3-6cf5-08db31268b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 13:56:22.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AnZcgLBhHwuKCaEWijc7Gy9fGwKgE7msyq/vA5jt23Auu92jUkaaExWmwAbu8hETYHFiwhG/8sx10ehxbwWuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi,
 Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhleSBMdWJlbiwgDQoNCkFncmVl
IGFuZCBub3RlZC4NCkkgaGF2ZSBjb25maWd1cmVkIG15IGVkaXRvciB0byB3cml0ZSB0aGUgY29k
ZSBhY2NvcmRpbmcgdG8gdGhlIGFsaWdubWVudCBjb252ZW50aW9ucywgYnV0IHByb2JhYmx5IHNv
bWV0aGluZyBtaXNzZWQgdGhlIG1hcmsuIA0KDQotIFNoYXNoYW5rDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4g
DQpTZW50OiAzMCBNYXJjaCAyMDIzIDE1OjUwDQpUbzogU2hhcm1hLCBTaGFzaGFuayA8U2hhc2hh
bmsuU2hhcm1hQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEpvc2hpLCBNdWt1
bCA8TXVrdWwuSm9zaGlAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBBTURHUFUgRG9vcmJlbGwgbWFuYWdlcg0KDQpBcyBJ
J20gcmV2aWV3aW5nIHRoaXMsIGl0IGlzIG9idmlvdXMgdGhhdCB0aGlzIHBhdGNoc2V0IGhhc24n
dCBnb25lIHRob3VnaCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwuDQoNCkl0J3MgZ29vZCBwcmFjdGlj
ZSB0byBydW4gb25lJ3MgcGF0Y2hlcyB0aHJvdWdoIHNjcmlwdHMvY2hlY2twYXRjaC5wbCwgdG8g
c2VlIGRldmlhdGlvbnMgb24gY29tbW9uIExpbnV4IHByYWN0aWNlcywgYW5kIGNvcnJlY3QgdGhl
bS4NCg0KUmVnYXJkcywNCkx1YmVuDQoNCk9uIDIwMjMtMDMtMjkgMTE6NDcsIFNoYXNoYW5rIFNo
YXJtYSB3cm90ZToNCj4gVGhlIGRvb3JiZWxscyBpbiBBTURHUFUgZHJpdmVycyBhcmUgY3VycmVu
dGx5IG1hbmFnZWQgYnkgZGlmZmVyZW50IA0KPiB1c2VycyBpbiBhIHNjYXR0ZXJlZCB3YXksIGFj
cm9zcyB0aGUgZHJpdmVyLiBUaGUgZXhpc3RpbmcgY2xpZW50cyBhcmU6DQo+IC0gQU1ER1BVIGdy
YXBoaWNzIGRyaXZlciBmb3Iga2VybmVsIGxldmVsIGRvb3JiZWxsIHdyaXRlcy4NCj4gLSBBTURH
UFUgTUVTIG1vZHVsZSBmb3Iga2VybmVsIGxldmVsIGRvb3JiZWxsIHdyaXRlIChNRVMgcmluZyB0
ZXN0KS4NCj4gLSBBTURHUFUgTUVTIG1vZHVsZXMgZm9yIGtlcm5lbCBsZXZlbCBhZ2dyZWdhdGVk
IGRvb3JiZWxsIHdyaXRlcy4NCj4gLSBBTURHUFUgTUVTIG1vZHVsZSBmb3IgTUVTIHByb2Nlc3Mg
ZG9vcmJlbGwgd3JpdGVzLg0KPiAtIEFNREtGRCBtb2R1bGUgZm9yIEtGRC9LSVEga2VybmVsIGRv
b3JiZWxsIHdyaXRlcy4NCj4gLSBBTURLRkQgbW9kdWxlIGZvciBLRkQgcHJvY2VzcyBkb29yYmVs
bCB3cml0ZXMuDQo+IC0gQU1ER1BVIHVzZXJtb2RlIHF1ZXVlcyBmb3IgdXNlcm1vZGUgZG9vcmJl
bGwgd3JpdGVzICh1cGNvbWluZykuDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2Vz
IERvb3JiZWxsLW1hbmFnZXIgdG8ga2VlcCB0aGUgZG9vcmJlbGwgDQo+IGhhbmRsaW5nIGF0IGEg
Y2VudHJhbCBwbGFjZS4gVGhlIGZ1bmRhbWVudGFsIGNoYW5nZXMgYXJlOg0KPiANCj4gLSBJbnRy
b2R1Y2UgYW5kIGFjY29tbW9kYXRlIGEgbmV3IEdFTSBkb21haW4gZm9yIGRvb3JiZWxscy4NCj4g
LSBQcmVwYXJlIHRoZSBBTURHUFUgdHRtIGJhY2tlbmQgZm9yIGhhbmRsaW5nIGRvb3JiZWxsIGFs
bG9jYXRpb24uDQo+IC0gSW50cm9kdWNlIGRvb3JiZWxsLW1hbmFnZXIgZnVuY3Rpb25zIHRvIGFs
bG9jYXRlLCBmcmVlIGFuZCBpbmRleA0KPiAgIGRvb3JiZWxscyBpbiBvbmUgdW5pcXVlIHdheS4N
Cj4gLSBDcmVhdGUgZG9vcmJlbGwgQk9zIGZvciBrZXJuZWwtbGV2ZWwgYW5kIHByb2Nlc3MgbGV2
ZWwgZG9vcmJlbGwNCj4gICBvcGVydGF0aW9ucywgYW5kIHBsYWNlIGl0IGluIGV4aXN0aW5nIHN0
cnVjdHVyZXMuDQo+IC0gTW9kaWZ5IHRoZSBleGlzdGluZyBncmFwaGljcywgS0ZEIGFuZCBNRVMg
Y29kZSB0byB1c2UgdGhlDQo+ICAgZG9vcmJlbGwtbWFuYWdlciBmdW5jdGlvbnMuDQo+IC0gUmVt
b3ZlIHRoZSBleGlzdGluZyBkb29yYmVsbCBtYW5hZ2VtZW50IGNvZGUgaW4gS0ZEL01FUy4NCj4g
DQo+IFBTOiBUaGlzIHNlcmllcyBoYXMgYmVlbiBzYW5pdHkgdGVzdGVkIHdpdGgga2ZkX3Rlc3Rf
c3VpdCB0byBlbnN1cmUNCj4gICAgIGl0IGlzIG5vdCBpbnRyb2R1Y2luZyBhbnkgcmVncmVzc2lv
bnMgZHVlIHRvIGtmZCBkb29yYmVsbCBjaGFuZ2VzLg0KPiANCj4gVGhlIGlkZWEgaXMgdGhhdDoN
Cj4gLSBhIGtlcm5lbCBjbGllbnQgY2FuIGNhbGwgZG9vcmJlbGwgbWFuYWdlciBmdW5jdGlvbnMg
dG8gYWxsb2NhdGUvZnJlZQ0KPiAgIGRvb3JiZWxsIHBhZ2VzLg0KPiAtIGEgdXNlcm1vZGUgYXBw
IGNhbiBkaXJlY3RseSBhbGxvY2F0ZSBhIHBhZ2UgZnJvbSB0aGUgZG9vcmJlbGwgYmFyIGp1c3QN
Cj4gICBsaWtlIGEgR0VNIG9iamVjdCBhbmQgdXNlIGl0IGZvciBkaWZmZXJlbnQgdXNlcm1vZGUg
cXVldWVzLg0KPiANCj4gQWxleCBEZXVjaGVyICgyKToNCj4gICBkcm0vYW1kZ3B1OiBhZGQgVUFQ
SSBmb3IgYWxsb2NhdGluZyBkb29yYmVsbCBtZW1vcnkNCj4gICBkcm0vYW1kZ3B1OiBhY2NvbW1v
ZGF0ZSBET01BSU4vUExfRE9PUkJFTEwNCj4gDQo+IFNoYXNoYW5rIFNoYXJtYSAoMTQpOg0KPiAg
IGRybS9hbWRncHU6IHJlbmFtZSBudW1fZG9vcmJlbGxzDQo+ICAgZHJtL2FtZGdwdTogaW5jbHVk
ZSBwcm90ZWN0aW9uIGZvciBkb29iZWxsLmgNCj4gICBkcm0vYW1kZ3B1OiBjcmVhdGUgYSBuZXcg
ZmlsZSBmb3IgZG9vcmJlbGwgbWFuYWdlcg0KPiAgIGRybS9hbWRncHU6IGRvbid0IG1vZGlmeSBu
dW1fZG9vcmJlbGxzIGZvciBtZXMNCj4gICBkcm0vYW1kZ3B1OiBhZGQgaGVscGVyIHRvIGNyZWF0
ZSBkb29yYmVsbCBwYWdlcw0KPiAgIGRybS9hbWRncHU6IGluaXRpYWxpemUgdHRtIGZvciBkb29y
YmVsbHMNCj4gICBkcm0vYW1kZ3B1OiBjcmVhdGUga2VybmVsIGRvb3JiZWxsIHBhZ2UNCj4gICBk
cm0vYW1kZ3B1OiB2YWxpZGF0ZSBkb29yYmVsbCByZWFkL3dyaXRlDQo+ICAgZHJtL2FtZGdwdTog
Z2V0IGFic29sdXRlIG9mZnNldCBmcm9tIGRvb3JiZWxsIGluZGV4DQo+ICAgZHJtL2FtZGdwdTog
dXNlIGRvb3JiZWxsIG1hbmFnZXIgZm9yIGtmZCBrZXJuZWwgZG9vcmJlbGxzDQo+ICAgZHJtL2Ft
ZGdwdTogdXNlIGRvb3JiZWxsIG1hbmFnZXIgZm9yIGtmZCBwcm9jZXNzIGRvb3JiZWxscw0KPiAg
IGRybS9hbWRncHU6IHJlbW92ZSB1bnVuc2VkIGZ1bmN0aW9ucyBhbmQgdmFyaWFibGVzDQo+ICAg
ZHJtL2FtZGdwdTogdXNlIGRvb3JiZWxsIG1nciBmb3IgTUVTIGtlcm5lbCBkb29yYmVsbHMNCj4g
ICBkcm0vYW1kZ3B1OiB1c2VyIGRvb3JiZWxsIG1nciBmb3IgTUVTIHByb2Nlc3MgZG9vcmJlbGxz
DQo+IA0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUgICAgICAgICAgIHwg
ICAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgICAg
fCAgIDYgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAg
ICB8IDE2NCAtLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZG9vcmJlbGwuaCAgfCAxMDIgKysrKystICANCj4gLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZG9vcmJlbGxfbWdyLmMgIHwgMzA0ICsrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jICAgICAgIHwgMTY1ICsrKysrLS0tLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaCAgICAgICB8ICAxNyArLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jICAgIHwgIDExICst
DQo+ICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmggICAgfCAgIDIg
Kw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jICAgICAgIHwgIDMx
ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmggICAgICAgfCAg
IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyAgICAgIHwg
IDEzIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyAgICAgICB8
ICAgNCArLQ0KPiAgLi4uL2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
IHwgIDE2ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZG9vcmJlbGwuYyAg
ICAgfCAxOTggKysrKy0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJpdi5oICAgICAgICAgfCAgMjMgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMgICAgICB8ICAyNiArLQ0KPiAgLi4uL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Nf
cXVldWVfbWFuYWdlci5jICAgIHwgIDE2ICstDQo+ICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaCAgICAgICAgICAgICAgICAgfCAgIDcgKy0NCj4gIDE5IGZpbGVzIGNoYW5nZWQsIDYzNiBp
bnNlcnRpb25zKCspLCA0NzIgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSANCj4gMTAwNjQ0IGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kb29yYmVsbF9tZ3IuYw0KPiANCg==
