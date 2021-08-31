Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B79CC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 07:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC8260200
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 07:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAC8260200
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F84089AC6;
	Tue, 31 Aug 2021 07:08:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E8489B06
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 07:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIV7NQozvlkPwF4FnDFLG/FpJTNnsjVs2nVvnhcRwERWZIe9+QlYy3eFXQvTwM9Udti0m7XF62FL0/5DttHSz5yOv6Iffq+k1sNixZMz2xzUtWgyk9a9AMEbUK5BefAECggoAZqBCoiVko2ZDtQaec4b11tfD4jMFyj9c8uWnq+FilQuHd9/P3dslgeq4+k5KBLt2a+T/bMp7ZDKdbve3VIsuU2XVP7UXEmCdj7uH6EnUCduHgbdB4YiD0tR7DbnQJOhq1vbYB3Ckgn1CboMdMHP95+jpItq8hvmTdhbjg5+bleDNm8wv+0IJENplDxPgtiUisnFK6KR79k2X8p+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=el8I3toS5LIHM36VtBBKnVmChxBRuJFqph5h7/83AIo=;
 b=fnGROo16XUJ7ya3C2/0oS2/IiLJ6I6KmbHNUu0RfzRak7WK6EzgqpSbUa7lHwyTOd1CmJ/GyBl2nYiXQwRBY/9VpfRkxEGb5M7ikvUSTYjVvYioZQ5YchEOTLyJSLA51XnDQVf3OUaqd1BBL8Ts6IatzDrZIi6AHMW4zpGYfn5P6DvbQGbIsWPKLvbq8AObihQ9VoC6/Hu9DkJGVrk4Wqhl7kVA0tKpRQNlYU7EMkko0Y4NGQr28Jddijfa6wgy1/ds+D9+lOzZC248TpcHVY5hN2Wft8yEzPGsJwOclU5o4XjlzykftQFJEQRa+O6fjKxpZmleaK8jz6+wiCpCrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=el8I3toS5LIHM36VtBBKnVmChxBRuJFqph5h7/83AIo=;
 b=Yk6OZZw8kYq/zhy1syCdvF+AKPuSEmNVugyoxCzh0RJYLC5jDPYT3xrF1QvjG5AQf72APLkHUiNCHikHUbwLlQbcSrQQVLeP6i2C+jhUuIVdj46lIzpgBxvN4TQWNI1RGAlytibOPq/QSW+WK0GT5HVdogfYWy0pbFo5c7Hatcg=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Tue, 31 Aug 2021 07:08:38 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 07:08:38 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails 
Thread-Topic: [PATCH v3] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails 
Thread-Index: AQHXnjcF+oH0+QrjLUWIoIiEuMjUqw==
Date: Tue, 31 Aug 2021 07:08:38 +0000
Message-ID: <8DA06109-D89E-406E-954A-27482501B3AC@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a13548ba-fa8b-4c9c-2343-08d96c4e27f2
x-ms-traffictypediagnostic: DM4PR12MB5278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB527842A543E87265B39222E487CC9@DM4PR12MB5278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyrugKuMH8W9CJWzyR4aT8/Pyf2fGxNtnfz5Wb4fgb+x2vmWQ4ADZXTW1fIqBzUTigaRF0f8KxWUH2SiL4sx/pWKRcyBN0gPFkOmjbLFYMWLFRbq3e6RSpy6S7Ji3xhgsK1EYOM5mxgxDsbT503/2KI0Bb/pQz8N7kxp5Qt0+Xuhgig1ZSjlIHaznnWwaS/qai0lvjxpUxrKalawxPdAASY6DBRmf3gfXuHV1LwGDnlOxfO3lEVOeVa/BKb3dv1LYXQo+USqChbG0XHcjif8yTYMi93X40HSu69yrgJRYjWXSFVz6wHknlHsy+kLNh54O/lZVBwuKdYQdSCSb0KsSRLnKS8xzZa+fnoZGa27Mej8IsxK0ZHEydK5mHcGwe+bNDZ58Z0Rhw17ne8fXx2ivUOyk5BHMuIJMxmnZgAM0afxraUAKD4/w3lupBCnDzstG/TvL3VR5Y0RaCIzY3TXwQAnhzU/gndJCNyTKGVeIot2FaHyg1gFG5emooW4mZSWjNMQNHwapmO22f+/u66NqdBP2TjI5r1BiGhTQWp3mZc2RV9GC5xq+xBvrCkiRFxNXPG3riXM0UWEF5VdASMd9JRA6RnQO/X5XIghm2MEYyCmxN2p1cZr+fiCv6X8CXCZYYWtarS5DYiOvYysDFrF30oZxo/e1pI46p4Vv1MRZekG4pA6FK8c0p/ahXBe4K0BBQ4ZR63+Y0055hUNlzSR3z+ZMm/8HRfWywMu2b3tubyV3sx/qQ4lGXJHrOSQki0F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(5660300002)(38100700002)(38070700005)(316002)(8936002)(36756003)(2906002)(54906003)(6486002)(8676002)(122000001)(71200400001)(6506007)(4326008)(91956017)(76116006)(66476007)(66556008)(64756008)(66946007)(4743002)(66446008)(6512007)(2616005)(478600001)(6916009)(26005)(33656002)(186003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHlWWDVhclQvZ1NWVmlxdGovZndVSy9WQ3ZYYXB6SXZZczF2Wm1OWktGZlU2?=
 =?utf-8?B?SE1YSWJSc0c0THVkYVdQSi9HWk5sMTl1bDlEQWZNbjlyd0dxamp6Y1k4bXIx?=
 =?utf-8?B?dXNVNU8vT2IrVHk3TThTZ081YUpXQUpBZVMxWWFuVVJVSUtUaEVnM0JTWmF4?=
 =?utf-8?B?c0wxUGdXTG5yYmx6cjVvVlhFdUJ5OHRSbG1ERWE3MzdZZXB3R1F6SFJ5RE56?=
 =?utf-8?B?TXIwMmhHV1FqajY2eklMU1JCZmxJUlVPQWNhQUhiTHhjMnVodElMUXFFRTl2?=
 =?utf-8?B?S2ZSRTQxS2NHZnd2bzBNbkFZNWpoV1VDSzJ1VzdVcytVdndzWTlmcE5wdklQ?=
 =?utf-8?B?UVN1cHhRWnRlcjhDVENPRGpXUVMxL2VDSE1kMEswOTFZaE1DQ0huU1AwWUdy?=
 =?utf-8?B?NWZWN3pXb3RQTlh0RHQ2VkdEWVhTUzk0VERmdFFBbFNkMlYySnU0dUVXRnlw?=
 =?utf-8?B?RldqM2lCOUhTRG9yOVVVWFNER09Tb0kwTVFHeUxVYk1zWGg2RmxYL2U2TTl5?=
 =?utf-8?B?d1VDM2tsZlpNbTI1L1RYNUVBTm1aQWtEQm0wQll6YlFZTmpnUkZjTUZtREI0?=
 =?utf-8?B?SzY2aEpQbWRON09iWURDUDJpWUs0TnFlZStWUjhuSk8wSUdGMUJ4MVVEQXNN?=
 =?utf-8?B?ejk2V2lBTURWQk9vS1hvMnFFam5rZ3MvMVA5K003dTkzbjNZcE45K0dFUDhC?=
 =?utf-8?B?eE13aVVwMldRcHV0UVZrbXhOa1JPRHc1ZXErZ3FlSlRVa3VsMkxHaW1MamR3?=
 =?utf-8?B?Ty9XR0RSN25ieHBNVmdxbE9najNRVmJzb1VrQU5pMjV0QlY3UWtaWTFBQVZr?=
 =?utf-8?B?QWkrczVGaVhOcVlRUm9GWDlYcFgwZmFYODNqNUdrdFVKbTJ2Yk53WWRiTmlO?=
 =?utf-8?B?bndQdFJQZ1dBdXFKK1dHQU5seFplWG9WdmpwSWZMdjVVWXFiajJDQ2dNVzdT?=
 =?utf-8?B?Q3hWNzAzS0Q2cHZjY0dNUlJiNUhxUzlrd01YWDB0K21FV0ZERWlYVVVpYld0?=
 =?utf-8?B?OHBlWktZSjl3bFB4cTYxakRzdEJGRVc1OGsrR3BUczZBdjJ6c2dnUzlvT2dy?=
 =?utf-8?B?MDZ6TVBQbS9CWmpoOXg2dzA2N1BNb1Q3L01TdWFod3BzajBnZElBQ3RJK3Ez?=
 =?utf-8?B?L0VXM1I3TmFabjZubGJzNUF4NmovbmlHVC9zRUY2cGdad0toT2NXOElhTXZX?=
 =?utf-8?B?cHNRc3lBb3hhMkp1RW1remtCSGZ5Q1VwYjRsLzBHb05KYjczSWIrN3NPK1l2?=
 =?utf-8?B?cEFUUCt4anNKdkd3RXBBWU9Wc0lTUzJTZkR3SlIyUTdBRmk0ZXZqN0tidHhH?=
 =?utf-8?B?TW1GNTZ5ck10bzB1dVZDNHZqR3BnT1JTdUg2T09yK2pIc1M5VmdTa2ZlUjRT?=
 =?utf-8?B?VXI4V2w0dXBaaGJDK3JUMmhsTGV1MUJ6WnB1QVBYSTZIcDkvN1ZaNGNNdHVa?=
 =?utf-8?B?TXVYd1dVOGUxK292TFNtSUppcURZUW93U0VVNU9qM0htaVh1Nmo5Rnk3b085?=
 =?utf-8?B?VkhBS1orYUsxd2NuSGUvNzBMYkFPRW9DUHZxMzQ1K2pscVBYQzVNVmp4Zm9B?=
 =?utf-8?B?NUViNWJZRUgyUDM4NGRrMmMySkxpMjZFL2hQMjBjeVZwdUFXMUNIeEJpSGpR?=
 =?utf-8?B?bjVyR0I0YU9kTTlXVkdzTE5MVW9MdE1NcEJmNnhkRDBySXptNFhDZXBUYytm?=
 =?utf-8?B?RHU0N29GeDJqc2lIbTFGUlBpMW9kTTIxWXB0ZnFCaVYvWlJ6YmtWbjhzMHQ3?=
 =?utf-8?B?ME95dWVaUXJJdTBvOWo5bEZ2ZytVMlVHLzIyTkNRMzhkdmZFQ05kdENsWmNo?=
 =?utf-8?B?SWVycWtjbjlOb2ZwQnp2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C49B3731B40B8147A870AC36DAFCBA20@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13548ba-fa8b-4c9c-2343-08d96c4e27f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 07:08:38.1481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKov1iDhgGnffj6AbbS8BC8uN+yxN7WWQow01pd7x3p7ba5egRw9Rg+ZX3uZnYaZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

RmFsbCB0aHJvdWdoIHRvIGhhbmRsZSB0aGUgZXJyb3IgaW5zdGVhZCBvZiByZXR1cm4uDQoNCkZp
eGVzOiBmOGFhYjYwNDIyYzM3ICgiZHJtL2FtZGdwdTogSW5pdGlhbGlzZSBkcm1fZ2VtX29iamVj
dF9mdW5jcyBmb3INCmltcG9ydGVkIEJPcyIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
U2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIHwgMjMgKysrKysrKysrKy0tLS0t
LS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCmluZGV4IDg1YjI5
MmVkNWM0My4uOWUyNTI1Yjk2ZDA0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMNCkBAIC0zNDEsMjEgKzM0MSwxOCBAQCBpbnQgYW1kZ3B1X2dlbV9jcmVhdGVfaW9j
dGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCiAJciA9IGFtZGdwdV9nZW1f
b2JqZWN0X2NyZWF0ZShhZGV2LCBzaXplLCBhcmdzLT5pbi5hbGlnbm1lbnQsDQogCQkJCSAgICAg
aW5pdGlhbF9kb21haW4sDQogCQkJCSAgICAgZmxhZ3MsIHR0bV9ib190eXBlX2RldmljZSwgcmVz
diwgJmdvYmopOw0KLQlpZiAocikgew0KLQkJaWYgKHIgIT0gLUVSRVNUQVJUU1lTKSB7DQotCQkJ
aWYgKGZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCkgew0KLQkJ
CQlmbGFncyAmPSB+QU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRDsNCi0JCQkJ
Z290byByZXRyeTsNCi0JCQl9DQorCWlmIChyICYmIHIgIT0gLUVSRVNUQVJUU1lTKSB7DQorCQlp
ZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEKSB7DQorCQkJ
ZmxhZ3MgJj0gfkFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7DQorCQkJZ290
byByZXRyeTsNCisJCX0NCiANCi0JCQlpZiAoaW5pdGlhbF9kb21haW4gPT0gQU1ER1BVX0dFTV9E
T01BSU5fVlJBTSkgew0KLQkJCQlpbml0aWFsX2RvbWFpbiB8PSBBTURHUFVfR0VNX0RPTUFJTl9H
VFQ7DQotCQkJCWdvdG8gcmV0cnk7DQotCQkJfQ0KLQkJCURSTV9ERUJVRygiRmFpbGVkIHRvIGFs
bG9jYXRlIEdFTSBvYmplY3QgKCVsbHUsICVkLCAlbGx1LCAlZClcbiIsDQotCQkJCSAgc2l6ZSwg
aW5pdGlhbF9kb21haW4sIGFyZ3MtPmluLmFsaWdubWVudCwgcik7DQorCQlpZiAoaW5pdGlhbF9k
b21haW4gPT0gQU1ER1BVX0dFTV9ET01BSU5fVlJBTSkgew0KKwkJCWluaXRpYWxfZG9tYWluIHw9
IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsNCisJCQlnb3RvIHJldHJ5Ow0KIAkJfQ0KLQkJcmV0dXJu
IHI7DQorCQlEUk1fREVCVUcoIkZhaWxlZCB0byBhbGxvY2F0ZSBHRU0gb2JqZWN0ICglbGx1LCAl
ZCwgJWxsdSwgJWQpXG4iLA0KKwkJCQlzaXplLCBpbml0aWFsX2RvbWFpbiwgYXJncy0+aW4uYWxp
Z25tZW50LCByKTsNCiAJfQ0KIA0KIAlpZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WTV9B
TFdBWVNfVkFMSUQpIHsNCi0tIA0KMi4yNS4xDQoNCg0K
