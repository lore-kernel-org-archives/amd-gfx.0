Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77045C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E246523B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E246523B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AA16E47E;
	Tue,  9 Mar 2021 06:03:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0405D6E47E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 06:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmzWE+n+aL9wHJR09VOT2tRa2m/At8bS1T9O1TIH2+2GcEwq/NcFcftAcZ7hmXnzvSzmENuFx8MeYek3Yu6SZB6WnNtxzdb+j2pCciET2QIR9elM/XUiZdi3cq+7puUR/dduuN9E7YVvpId7mKQkzblIx3GFwgngZx7w/AR3JSBD0Y1Heh5j4UQ2IoVHxJmpoIkZ7wOqNvUTjJWjmEBjOhPTiZddUkPHiFkZRGP2NDTG2EHK4hMfB1ZEdQR8hQmmTbnansrGI+B8RW2Ib73CxB54GswDeemByzcidVrUHhYStX49qB/C6zzGBgAb48N9lGEgGRo6IHZZqfcXdZ58Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua7HWctKKFZPH5Ma1zIHyjEeBLlYUHZ2A/aSGWoRvOk=;
 b=f+eeIZ/T7g2tdnK/asXjHvHMt7h+f8TMA7ikhteq5377vogMfLuHwhMBhFMtXUjCkCVxUfEM+hu6Zslspd0Qqkvstl1NXi6ICK5NmIY+LcwD0G2eH1ryh3muN5kw2G3Iw3YcC4j7X8kszSBQi7tWhjsoeL5hj+PMSdnwLnRer9tJnC/Bn6WSSeqEwuiNq5K/0MXMEAu70SHbCZo/nCsqJFl/CbShBr/kLqONi1yIoV438WLVUAKgrk3oqzavFjRSwgpAIFRb5qGHCRy88iQ+0tkzzulpSW9at3np1t//7Y6oA90rcUQJ1EOPXxkFV3aXN9XwjvwjPHV1BQ5PU5GZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua7HWctKKFZPH5Ma1zIHyjEeBLlYUHZ2A/aSGWoRvOk=;
 b=ozScDN6voLrdPkorMyod7pCRQSLze4705uO6BuSXggi7YRagbKDCGqXupWjx3CQTG6XAVxrmK+DbRa/St6C5QL7bkm8csGUXVa917A6AVIXIr6HTb3Gt2X0eKBAg3D8PPoRKznjXiWtOzUryYDAwWc3Sl3DpY7RDy1+QuaqvrFg=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Tue, 9 Mar
 2021 06:03:25 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 06:03:25 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9
Thread-Topic: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9
Thread-Index: AQHXEZ9pWfujdSH7Pk22Mz95QiV7Lap1WTQAgAXU4xA=
Date: Tue, 9 Mar 2021 06:03:24 +0000
Message-ID: <DM6PR12MB46033AF753790A00824166A1FE929@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210305091006.65628-1-Feifei.Xu@amd.com>
 <DM6PR12MB407548DAD45BDCB050FF2DEAFC969@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407548DAD45BDCB050FF2DEAFC969@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-09T06:03:20Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f7fa7741-d34d-4002-93b3-b75e7eb37330;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e666350-d2e2-4543-98ab-08d8e2c10d2e
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23586E5CA19EA4FA753C16D1FE929@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L50rnTfRJOPyyQ5HDvWyDV1J0mSm6W5DkgKKNqEBkKKPQuvUUMwl3o7lz8ED0qk6ZCx/ZVkWebmH9KB3rB5voQurdqAVUqCftW9/LW9885dBxDdD02DjyCoUvAQ0fJX3Fz7SXoDgxB0hR39cWK3HbN7lUkEg4v8Ns3576GvXgzzxR9RQXrURorPGuN2SqP1ujgOx7nWQT4jZe1T3swl7hV3hXUtJTEw53yU2fuIKt3FSCgiUu+nusQZpiEbqc2sQhoNZpK+EK0gP2G7B4yhnHcgVT6EQ82DCKfTfPvK/wUrXEW1ZYG168WmCWZ/mw8xPUD+1PLm4qBcs32HmEtU9Ug2RPd5rl7FTc6X5swiuf1nR+UDmaNjxoOATd4YXHFX2S9h/Xd1QXBvQKmRofJZgCKjeUgqYF1bUFaJ51CbffI6TwZoTujhegjgSlOfSZWSwHboyxpqiDTibZvJO4zoLHjSk6xUkDZXBH0JRv6vs0MgXTfZnh8UK6Xm/UdWEW9YFeAhbIBUSK5t2jMin0qowMQdt+aIZ6kn3o3NEpU9KskgqSkKqE8KIjlLI6/C8om+g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(186003)(8676002)(53546011)(110136005)(26005)(6506007)(8936002)(54906003)(66946007)(64756008)(66446008)(7696005)(66476007)(66556008)(5660300002)(83380400001)(76116006)(33656002)(478600001)(52536014)(2906002)(4326008)(86362001)(55016002)(316002)(9686003)(71200400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?dDVibVpHOXBDV2FXaFcwK25XNlllbUg0M1lXSmFKejFNYkJMcmlQeUJmUjVz?=
 =?gb2312?B?TDRXYk55OGlLWHp4cUJxRzRIejQ1TlFwT3BOMGxVeU81alVoZXMybHZEQUNC?=
 =?gb2312?B?UngwMlNURmt6QzIvTytFMWFVTlpOWjVDVTl1OC93ZzEvd3Nnd1VtTHo3MFJi?=
 =?gb2312?B?bXR2UHErSzFNTVg2Nm8rWjVDMjBDS1hZcVBXSTlvZXBybEhZUGZSYU1ZUEV1?=
 =?gb2312?B?aFllcnFUNEt1bWhUT3dBbHpnU2dtd1VlQ0NyWmFmKzBlZ2l2RTJBeXFMRDZW?=
 =?gb2312?B?MHlsQlJLY1BZQ2JseFlZZVlkQUVGRlphS1cwOFQ2UnBXNmNtdkZsbE9Ya3hN?=
 =?gb2312?B?MU8rMnd0WGhCNG9Nb3kwRmdIaVZLYWtndTJsRWRQZUN4NkRFUHFETk5Eck1U?=
 =?gb2312?B?YnVydmttaUhybnBnVXR2cW9rLzA0bjEveXFPaEdZSkZFV0N6NkErdjV6MmF4?=
 =?gb2312?B?cWpzRDNQWlZFV0hmSyt3citlOE9rV2p6Mi85M1FVNzJNMGNITzdzR1QvSXZF?=
 =?gb2312?B?ZVVZNHdNdkFtNDdrdXY2OCtjMEVzQlk4UU5xQU5laHFLb3NBOEhSTk5CYTVF?=
 =?gb2312?B?UFJmcGVlRmZHUEpsQ1hnbzRIZWF2ZUpZeERLZnlCZ1kybkxQL2haaG5VOC84?=
 =?gb2312?B?SlpFM1BPVUVYaUNhVWlNMzBtQmdMbjU5MGdLTlBvc1daekRhUEJvaGlQOTRE?=
 =?gb2312?B?Rmh5bUxoSU1jU3NWaG42Nlp2Vm9EenFOWkpEYmNIMHNTNTdQK09oZE92SlQ3?=
 =?gb2312?B?cDlsZ0wrbU9UMUNSRkhvZmlhOTg1R3ZkS0I5NDNyRXA2MmJUTWNRVENVWVVv?=
 =?gb2312?B?Q1lkME1TNEJlMHV5QmVoMWpySTJ5YkF3eWVHUU4yeTJsd044K0Z6U3hmTFVU?=
 =?gb2312?B?NVIzdHkvOWdyaXlINUpHUUhOL29PT2c2SzJSdUhQMU9PK2J2VmJVN0h6QjBL?=
 =?gb2312?B?T1UwYVNUZ1JYN2o2eHFHSkVFU29abXV6S3lpam5ldzVlSGNnbisyZ2pIUVlu?=
 =?gb2312?B?Zi9KV1UvT0FQTXRHK2daaWpZdEN1NElRTXNHcmdDMUg4WjhkVkRHR0VsUFdG?=
 =?gb2312?B?K2pJOXJkdHZtbHplenpTbW9aejI0MjBDRnE0SmsyQzlWakJ0bzg2S2VESHY0?=
 =?gb2312?B?MXRSZk92aDEvaUNQL3d4SW0vSE91MDE0Zk1WVUdUMnFnVStJOUVYcTdTSjBL?=
 =?gb2312?B?NDZvaDV6MVFLbkpIWTYwZ1ptQnYxN1gxR25wbE4vS1NhSTVYUWlScm5yVjVk?=
 =?gb2312?B?bGlwRWpEakIvWk9XSCt1UXR4bUZyc2dDVFNBclZIN2ozNzVFUjVDSHNLTVFq?=
 =?gb2312?B?ZXVMY083WGhvM0pOV0RyUm5Gc2RXYjFHMUFFRUtDRjBlMjNvaWVxNXc0a3dZ?=
 =?gb2312?B?N0tQVnRWT29FQlpxcC9SVUxWN01LZFhxZFArQkpodjh5TkFzbzcrbHNUSjNh?=
 =?gb2312?B?eFNOcUt2dGJYV3dYOXRNUXJUNVluck9qZ0F0cG5CSEpPZnowZjJJZENxRGJH?=
 =?gb2312?B?SVp0OFFrZytBUThZeTYxNHErMUZleWkralBkUXA1ZUNNM3ZNaFBRVU9ya2Iw?=
 =?gb2312?B?K3dtNmhRMGJPLzI1M0M0ekRBdGhiZHNvRFBnZkpXTi8raHJmVUkvZThHWSts?=
 =?gb2312?B?ci9LSEtoeUM0ZEx5VzNmdUwzY2pBNm9DemRqVnlnSzkrSE5OOTJETjRITEdX?=
 =?gb2312?B?UHQ0UlZxQ2RvTXdrdVVvUmR2eUJpQVJ6OTZOTmR5ZFV2ZitxdzUrRTJjVmhR?=
 =?gb2312?Q?DfK8RWNeIlDu4/t/O0YTJ1lW6DJhs2tUcxPgEIH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e666350-d2e2-4543-98ab-08d8e2c10d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 06:03:24.9728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6ovR9UqLNf5UyorkN6qOkAkxJP5cvlzT2fK+JLWbTzq50Q5IxMQVOZeTve4q3st
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Jin, Anna" <Anna.Jin@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpUaGFua3MgQW5uYS4gUmVzdWx0IGlzIGdvb2Qgb24gU1JJT1Yg
Z3Vlc3QgZHJpdmVyIGFzIHdlbGwuIFdpbGwgcHVzaCB3aXRoIA0KDQpSZXZpZXdlZC1ieTogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KVGVzdGVkLWJ5IEFubmEgSmluIDwg
QW5uYS5KaW5AYW1kLmNvbT4NCg0KVGhhbmtzLA0KRmVpZmVpDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPiAN
ClNlbnQ6IDIwMjHE6jPUwjXI1SDPws7nIDg6NTENClRvOiBYdSwgRmVpZmVpIDxGZWlmZWkuWHVA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogTGluLCBBbWJlciA8
QW1iZXIuTGluQGFtZC5jb20+OyBYdSwgRmVpZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IEppbiwg
QW5uYSA8QW5uYS5KaW5AYW1kLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6
IHJlbW92ZSBFQ09fQklUUyBwcm9ncmFtaW5nIG9uIGdtYzkNCg0KW0FNRCBQdWJsaWMgVXNlXQ0K
DQpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KDQpQ
ZXIgZGlzY3Vzc2lvbiwgcGxlYXNlIHdvcmsgd2l0aCBBbm5hIHRvIGlkZW50aWZ5IHRoZSBwb3Rl
bnRpYWwgcmlzayBpbiBTUklPViBndWVzdCBkcml2ZXIgKFZFR0ExMCkgYmVmb3JlIHB1c2hpbmcg
dGhlIHBhdGNoLiBUaGFua3MuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4gDQpTZW50OiBG
cmlkYXksIE1hcmNoIDUsIDIwMjEgMTc6MTANClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBMaW4sIEFt
YmVyIDxBbWJlci5MaW5AYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPg0K
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiByZW1vdmUgRUNPX0JJVFMgcHJvZ3JhbWluZyBv
biBnbWM5DQoNClJlbW92ZSB0aGUgRUNPX0JJVFMgcHJvZ3JhbWluZyBpbiBkcml2ZXIgb24gZ2Z4
aHViMS4wLCBtbWh1YjFfeCBhbmQgbW1odWJfOS40Lg0KDQpTaWduZWQtb2ZmLWJ5OiBGZWlmZWkg
WHUgPEZlaWZlaS5YdUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4aHViX3YxXzAuYyB8IDEgLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFf
MC5jICB8IDEgLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfNy5jICB8IDEg
LSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jICB8IDIgLS0NCiA0IGZp
bGVzIGNoYW5nZWQsIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4aHViX3YxXzAuYw0KaW5kZXggMGFiNDk4ZDkzZTQ4Li4wY2Y5OTM3OTdkZjggMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jDQpAQCAtMTg2LDcgKzE4Niw2IEBA
IHN0YXRpYyB2b2lkIGdmeGh1Yl92MV8wX2luaXRfdGxiX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQogCQkJICAgIEVOQUJMRV9BRFZBTkNFRF9EUklWRVJfTU9ERUwsIDEpOw0KIAl0
bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgTUNfVk1fTVhfTDFfVExCX0NOVEwsDQogCQkJICAgIFNZ
U1RFTV9BUEVSVFVSRV9VTk1BUFBFRF9BQ0NFU1MsIDApOw0KLQl0bXAgPSBSRUdfU0VUX0ZJRUxE
KHRtcCwgTUNfVk1fTVhfTDFfVExCX0NOVEwsIEVDT19CSVRTLCAwKTsNCiAJdG1wID0gUkVHX1NF
VF9GSUVMRCh0bXAsIE1DX1ZNX01YX0wxX1RMQl9DTlRMLA0KIAkJCSAgICBNVFlQRSwgTVRZUEVf
VUMpOy8qIFhYWCBmb3IgZW11bGF0aW9uLiAqLw0KIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwg
TUNfVk1fTVhfTDFfVExCX0NOVEwsIEFUQ19FTiwgMSk7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tbWh1Yl92MV8wLmMNCmluZGV4IDAxNDVkNGQyMDFjZi4uMzdiOTg1MzE3MDEyIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMNCkBAIC0xNjQsNyArMTY0LDYgQEAg
c3RhdGljIHZvaWQgbW1odWJfdjFfMF9pbml0X3RsYl9yZWdzKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KIAkJCSAgICBFTkFCTEVfQURWQU5DRURfRFJJVkVSX01PREVMLCAxKTsNCiAJdG1w
ID0gUkVHX1NFVF9GSUVMRCh0bXAsIE1DX1ZNX01YX0wxX1RMQl9DTlRMLA0KIAkJCSAgICBTWVNU
RU1fQVBFUlRVUkVfVU5NQVBQRURfQUNDRVNTLCAwKTsNCi0JdG1wID0gUkVHX1NFVF9GSUVMRCh0
bXAsIE1DX1ZNX01YX0wxX1RMQl9DTlRMLCBFQ09fQklUUywgMCk7DQogCXRtcCA9IFJFR19TRVRf
RklFTEQodG1wLCBNQ19WTV9NWF9MMV9UTEJfQ05UTCwNCiAJCQkgICAgTVRZUEUsIE1UWVBFX1VD
KTsvKiBYWFggZm9yIGVtdWxhdGlvbi4gKi8NCiAJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIE1D
X1ZNX01YX0wxX1RMQl9DTlRMLCBBVENfRU4sIDEpOyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfNy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjFfNy5jDQppbmRleCA4MTZmZjExMGEwNzQuLjkwOTkxNjI1NTNhNCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YxXzcuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfNy5jDQpAQCAtMTg5LDcgKzE4OSw2IEBAIHN0
YXRpYyB2b2lkIG1taHViX3YxXzdfaW5pdF90bGJfcmVncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikNCiAJCQkgICAgRU5BQkxFX0FEVkFOQ0VEX0RSSVZFUl9NT0RFTCwgMSk7DQogCXRtcCA9
IFJFR19TRVRfRklFTEQodG1wLCBNQ19WTV9NWF9MMV9UTEJfQ05UTCwNCiAJCQkgICAgU1lTVEVN
X0FQRVJUVVJFX1VOTUFQUEVEX0FDQ0VTUywgMCk7DQotCXRtcCA9IFJFR19TRVRfRklFTEQodG1w
LCBNQ19WTV9NWF9MMV9UTEJfQ05UTCwgRUNPX0JJVFMsIDApOw0KIAl0bXAgPSBSRUdfU0VUX0ZJ
RUxEKHRtcCwgTUNfVk1fTVhfTDFfVExCX0NOVEwsDQogCQkJICAgIE1UWVBFLCBNVFlQRV9VQyk7
LyogWFhYIGZvciBlbXVsYXRpb24uICovDQogCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBNQ19W
TV9NWF9MMV9UTEJfQ05UTCwgQVRDX0VOLCAxKTsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21t
aHViX3Y5XzQuYw0KaW5kZXggNjVmYjg4ZDM5MWQzLi5kNjhmM2NkMmQ0MGQgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMNCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KQEAgLTIxOSw4ICsyMTksNiBAQCBzdGF0
aWMgdm9pZCBtbWh1Yl92OV80X2luaXRfdGxiX3JlZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIGludCBodWJpZCkNCiAJCQkgICAgRU5BQkxFX0FEVkFOQ0VEX0RSSVZFUl9NT0RFTCwgMSk7
DQogCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTVNIQVJFRFZDMF9NQ19WTV9NWF9MMV9UTEJf
Q05UTCwNCiAJCQkgICAgU1lTVEVNX0FQRVJUVVJFX1VOTUFQUEVEX0FDQ0VTUywgMCk7DQotCXRt
cCA9IFJFR19TRVRfRklFTEQodG1wLCBWTVNIQVJFRFZDMF9NQ19WTV9NWF9MMV9UTEJfQ05UTCwN
Ci0JCQkgICAgRUNPX0JJVFMsIDApOw0KIAl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgVk1TSEFS
RURWQzBfTUNfVk1fTVhfTDFfVExCX0NOVEwsDQogCQkJICAgIE1UWVBFLCBNVFlQRV9VQyk7Lyog
WFhYIGZvciBlbXVsYXRpb24uICovDQogCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTVNIQVJF
RFZDMF9NQ19WTV9NWF9MMV9UTEJfQ05UTCwNCi0tDQoyLjI1LjENCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
