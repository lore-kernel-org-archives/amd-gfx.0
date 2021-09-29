Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 23:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E1F61507
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 23:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70E1F61507
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC5F6E296;
	Wed, 29 Sep 2021 23:32:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CBDE6E296
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 23:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBmo69ZtDeCuCQbbJpLDW4QMFONhH3jDX4DLtZ/dCCGVyQ1LBDxqMMlrkzidPqFUjBirTEXXMzSwyyHrQmFDyoJUbAsCJvb31+dFmuUjp6X9HQFUCGE9JgwYlXLkqO5ECla6SIlhvk3Xn9ORmmX7T0VhMgfyYDMumAb+OkNH84eUu/rCgGAhe/V25Z8lIOZ6ivLXzFSCTMugfq+sJfk/8MP9PKN+x0bSan9YjiaylL1uV/ICnf8E+9mI0UjYwCfMxl/dKqj8nRfu1CAcRxdBLscF5amvLXxHyAgkUKFGFCCKRUkB5DvH8C6Pidu5Xw3NQCi7PczE/KTiLvtJvbNPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=RNvG4+PtFofNr7nteqRIgmAN42jEj6Lm2tqvk59bNZc=;
 b=ef/oMASo6XJY1eBos6JEggV5EvQu2XGwK7ZNS/375uq/TXLPS3/i1Vk5wJ/6vi6jS7pCGiYrsRdsuaNPrH69LPjKS/Cvh6rMhdtY2ZuefDgrbgc5jEQ+6ro0cYaOKqXdjAbWvgRAG991a8kxNZ5ZmFSoRdpobgumtRwWqaHfPQyuHslRQRZfRB314oX4pcsHN5/jK4VDcJWkaWh5y+2YsGKgkNuQDvFs7bBlncxJKOWUMYKcPw7XFtGkLfOzBp4PjTUsZ857MnrZFk1FN5kiVUumIUDNTPj5EppiGYHIubaPGoSmFK56+ZlVX1Z9s/BmQ/oflaO+YkoU1ASZV9y8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNvG4+PtFofNr7nteqRIgmAN42jEj6Lm2tqvk59bNZc=;
 b=cvPx5Nn+ALVjUs623RU6yS2Y24R/nrkJJSHhGHswv23P+iHGfv/ev9WhhN/0ISMsdlR77NIuf/wkn+Mlb698RTRVB2IeqRV7DRmkgVhd2moj2VnTgfChe04K4dtoOzMR2iz90OD2ZhytOydrR+A9w0rNZ2SqazvL3NWh5iZ3mJs=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Wed, 29 Sep 2021 23:32:14 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 23:32:14 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Topic: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Index: AQHXtQsmKTKeWYk0oU2s3x4JTRfj6au7IiqAgACGfTA=
Date: Wed, 29 Sep 2021 23:32:14 +0000
Message-ID: <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
In-Reply-To: <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-29T23:32:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c12c8fb7-f771-4981-8dea-39cedc72b339;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f261230a-f91b-4e2f-fc7a-08d983a15e75
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18810506FB2E0D9DD0B72E17FBA99@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIvZtmBoL0yOrhppyU9ELkaKUMiZFohV3tSVlc+CPpD2PvxVtJm+RsiJXVWTrXugL5/lpPDBBbxURrWbG8jMlG/Ibsi6aCNirf0zPmys134Tfj1QUsG9+l+OgTjrB7DiCbU1aupDhAiB+Hm6NL3dbBtFWj6YPXXlBkaISyCxtZ0ivYQ8Bx9973vR55jN6dcZvx8NasHPC4D5nZqxUZKer48JSbbxdV1EExijH4kXi7mxD2f78LCGF7GqOVMFZ6yXCKvL9SR1nV/wPsrFoLPQEnNEXb2l3atkZQ8v9iApUyxTrqTsj6SjOKsrnQIab492XDb6/6esX9o/bQgvixl9C1/F5NY3bcO2JAfPnzgsob7vo3b1FFvu7Yuebuel43yOfoTGonKJrCtC5glsPCGZ2CMtZP7GOOlXPUOyJ3hvRwh4beWtFc32vrS9QoV3AnLYYzBvi17tNFZSogSDNVysXRrlbHffTAV/BqXgelhNca9X7+6Aa7Dhp4hMkXisYpokU1CFEazUo2V4C65oPCSQSC0amqkqsrjgNVR43rYxfz9kX6pW3b1r2ZhywjCTEmcuc/K4xie7RkMlL/HtA0H+yZ6mSbRB2V5y1scziCds7EHm4pIZ3hfuLYQLfTlUftCi8qPM5AroqUIRimxn4qiEK+9XrSAIcuz8rF0kDn2AKvsdoRbO7TH8GECaDOGM7t6a8ehxQVrf2Z1ipve7AJNVbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(316002)(110136005)(83380400001)(86362001)(38070700005)(9686003)(55016002)(71200400001)(508600001)(5660300002)(66446008)(6506007)(66556008)(66476007)(64756008)(122000001)(38100700002)(2906002)(76116006)(54906003)(8936002)(33656002)(26005)(4326008)(66946007)(7696005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTgxQmFUd2ZldHlNUkFVSXJiVktNSDl5K2JGWkU5UWhxa2syQzZCVkhIT01a?=
 =?utf-8?B?M3dseGMwZ1hodTJBOHVhdnpNd1FvWUN1T3ErZXJyZklwYUxrUEF0NGpPTk5k?=
 =?utf-8?B?dVBaL1R4M2NLNWRvdHZwaEc4YXNPUDJHS2o3S0ttd0lLM09jd290dnY3K2JJ?=
 =?utf-8?B?d2pqeFQ1YlZhS05lT0MyOEJtSkQrNmdubE1oU2ZmL3hyU3pWbEFBcG9ld1R1?=
 =?utf-8?B?MVVVN1A3U1JpV1B3VktKV1dwMU11b3ltZ2RLbkgyK3RCbG80N2JPU0FkRVVa?=
 =?utf-8?B?U3Z4Z0g1NnpINXdGNlA3aE9nenBXcmVnZzZSUmk2SmIrQjcxcVRIaFhrMGlu?=
 =?utf-8?B?TjQ5V2J1alJ6Q3d0a3dENEluV3kwQmdUNFJBTlpQRFAyVm0rMHg2NVlnWVFi?=
 =?utf-8?B?cDVpRFdMcnpNTmZrb0treTlpeUxxSU9OdGVFemszazB4eVllY1BKQjRzYTJX?=
 =?utf-8?B?SWxacVlJVnB5N0lxVklKVk4vdUJ2VEw5ZzlPQzBBQ2l1S2NjSmc2ck16SU9U?=
 =?utf-8?B?SjlJKy84ZFBoZW80TDM4anI3M3RZM1JjYjhnS1h1ZXlheHdlcmhEUXgxTlZL?=
 =?utf-8?B?eCtwdW1EV0pKSDJxVGplUk5hR2s1cjZ1MEFoRW5MQzk0NFh5TkdGcWpyWW03?=
 =?utf-8?B?MmxzbFl1S1Q5WkFPUUM2NVdlZm54dDNCOHY0S1dwT2tYMjJIZkhsN0JmZDJl?=
 =?utf-8?B?djhKcExMd0ZwbmlXZ0Npb3VwNUFYbWhjQnA5T0RHOW5RZjNPR3BQcVF5NkFV?=
 =?utf-8?B?QlhjZXl6VFJEV0cxZGRpdk5abFN4aDhOc0UxbUhTaUtENnFEQW1VUkZKUUh5?=
 =?utf-8?B?Yk9kZk95ck5GNzZSOFF5bTk2WUZFTm9WY2l1Sy90bC9qTTZVdDV5ZFVZRFBK?=
 =?utf-8?B?bmlYS3l6RVhJOTE1alBvTmgrVS9FVzE2NzZSajZLQTh4UEs4czFjb3FBWmpT?=
 =?utf-8?B?NHFyM0JObE1FeldjN3JyaFFHSEZKYy9XNU5FWDJaOUQzVWppbjRtWFR3WkpR?=
 =?utf-8?B?MS9FQTg2SVViYnVUc2ZyZkNrKzJyYVVNcWxvanRONHllaUoyQnMwQncrREc2?=
 =?utf-8?B?WGRzS1JET1g5RUs5dis4NGxTV01yQlc3N3JJdHR4WHFoaG95RVQrek1BWk41?=
 =?utf-8?B?bCtNdmpBRU4wZTNScWFiVlM4bE9tM214clVoc3dqbUV5MDFVWWJkSTMyYWsr?=
 =?utf-8?B?UnNzclluNVlITmhZYUtsM1h3cmFhMUNyeWNIT2lYbDROSVYrWGZzdFBlcWo4?=
 =?utf-8?B?T0gwR20relRsbjdWd1puME0wekt6ZUsvd29hSk1GZnlQUnUwZnFzWVRtSGx6?=
 =?utf-8?B?ZXhKTmZoT2VIM1hxWDBaMGtGUHd3Q3p1b283eUdDWWlmTGFYL29JcklPZmtq?=
 =?utf-8?B?YzA0L0FydzE4SXJNMEQ4eEtyMW9xVnRnSlBIN2xqVWNybE5iRGdkWjFOTlds?=
 =?utf-8?B?WmRsMURjZFFKQzZlVHpTNHlhR1NtUE5YdUdvc2FwQ053Yk9MRUI4eEdpcjUw?=
 =?utf-8?B?T0I2Rmw4ZDh1MW0wb1BmcW9nVzM3Z1gvQkh1OXZxZDBtWURWcE1Lam5YZTJL?=
 =?utf-8?B?SzVTaUJDZDV4ZVd1dVF4b2VzSE1FSjY0d0QzVytKZDdTbWFZNzNCUTFkdUdO?=
 =?utf-8?B?aEdNRlpXNm5yeFdHdk96OWZkL3hRWGRYUCtybjdhNDVuTnNSbzQxTjlOcDFo?=
 =?utf-8?B?eDhiMWJxSk1oV2YvWFFiSW1KTElhMzNDcEkzQ3hIaWplUmtkcWU0QXRQby9m?=
 =?utf-8?Q?0JaftN/RDA0Gwk/T4rNlV8q8W8B+Xp0fhOUjJcB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f261230a-f91b-4e2f-fc7a-08d983a15e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 23:32:14.6304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G10Tu/4rMoCCtM72RHpZ8xF8YnmhmY6y97K25VwBRVgYnS5hN2Z/ydOdyUS/r+wwMfaZsW24B0Q0AhczNkERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50
OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyMSAxMToyNSBQTQ0KPlRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogRGV1
Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0K
PjxSYXkuSHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBm
aXggYSBwb3RlbnRpYWwgY3VfbWFzayBtZW1vcnkgbGVhaw0KPg0KPkFtIDIwMjEtMDktMjkgdW0g
NDoyMiBhLm0uIHNjaHJpZWIgTGFuZyBZdToNCj4+IElmIHVzZXIgZG9lc24ndCBleHBsaWNpdGx5
IGNhbGwga2ZkX2lvY3RsX2Rlc3Ryb3lfcXVldWUgdG8gZGVzdHJveSBhbGwNCj4+IGNyZWF0ZWQg
cXVldWVzLCB3aGVuIHRoZSBrZmQgcHJvY2VzcyBpcyBkZXN0cm95ZWQsIHNvbWUgcXVldWVzJw0K
Pj4gY3VfbWFzayBtZW1vcnkgYXJlIG5vdCBmcmVlZC4NCj4+DQo+PiBUbyBhdm9pZCBmb3JnZXR0
aW5nIHRvIGZyZWUgdGhlbSBpbiBzb21lIHBsYWNlcywgZnJlZSB0aGVtIGltbWVkaWF0ZWx5DQo+
PiBhZnRlciB1c2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55dUBhbWQu
Y29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYu
YyAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMgfCAxMA0KPj4gKysrKy0tLS0tLQ0KPj4g
IDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0K
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+PiBpbmRleCA0
ZGU5MDdmM2U2NmEuLjVjMGU2ZGNmNjkyYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4+IEBAIC00NTEsOCArNDUxLDggQEAgc3RhdGljIGludCBr
ZmRfaW9jdGxfc2V0X2N1X21hc2soc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdA0KPmtmZF9wcm9j
ZXNzICpwLA0KPj4gIAlyZXR2YWwgPSBjb3B5X2Zyb21fdXNlcihwcm9wZXJ0aWVzLmN1X21hc2ss
IGN1X21hc2tfcHRyLA0KPmN1X21hc2tfc2l6ZSk7DQo+PiAgCWlmIChyZXR2YWwpIHsNCj4+ICAJ
CXByX2RlYnVnKCJDb3VsZCBub3QgY29weSBDVSBtYXNrIGZyb20gdXNlcnNwYWNlIik7DQo+PiAt
CQlrZnJlZShwcm9wZXJ0aWVzLmN1X21hc2spOw0KPj4gLQkJcmV0dXJuIC1FRkFVTFQ7DQo+PiAr
CQlyZXR2YWwgPSAtRUZBVUxUOw0KPj4gKwkJZ290byBvdXQ7DQo+PiAgCX0NCj4+DQo+PiAgCW11
dGV4X2xvY2soJnAtPm11dGV4KTsNCj4+IEBAIC00NjEsOCArNDYxLDggQEAgc3RhdGljIGludCBr
ZmRfaW9jdGxfc2V0X2N1X21hc2soc3RydWN0IGZpbGUNCj4+ICpmaWxwLCBzdHJ1Y3Qga2ZkX3By
b2Nlc3MgKnAsDQo+Pg0KPj4gIAltdXRleF91bmxvY2soJnAtPm11dGV4KTsNCj4+DQo+PiAtCWlm
IChyZXR2YWwpDQo+PiAtCQlrZnJlZShwcm9wZXJ0aWVzLmN1X21hc2spOw0KPj4gK291dDoNCj4+
ICsJa2ZyZWUocHJvcGVydGllcy5jdV9tYXNrKTsNCj4+DQo+PiAgCXJldHVybiByZXR2YWw7DQo+
PiAgfQ0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9j
ZXNzX3F1ZXVlX21hbmFnZXIuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4+IGluZGV4IDI0M2RkMWVmY2RiZi4uNGM4MWQ2OTBm
MzFhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3NfcXVldWVfbWFuYWdlci5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4+IEBAIC0zOTQsOCArMzk0LDYgQEAgaW50IHBx
bV9kZXN0cm95X3F1ZXVlKHN0cnVjdA0KPnByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNp
Z25lZCBpbnQgcWlkKQ0KPj4gIAkJCXBkZC0+cXBkLm51bV9nd3MgPSAwOw0KPj4gIAkJfQ0KPj4N
Cj4+IC0JCWtmcmVlKHBxbi0+cS0+cHJvcGVydGllcy5jdV9tYXNrKTsNCj4+IC0JCXBxbi0+cS0+
cHJvcGVydGllcy5jdV9tYXNrID0gTlVMTDsNCj4+ICAJCXVuaW5pdF9xdWV1ZShwcW4tPnEpOw0K
Pj4gIAl9DQo+Pg0KPj4gQEAgLTQ0OCwxNiArNDQ2LDE2IEBAIGludCBwcW1fc2V0X2N1X21hc2so
c3RydWN0DQo+cHJvY2Vzc19xdWV1ZV9tYW5hZ2VyICpwcW0sIHVuc2lnbmVkIGludCBxaWQsDQo+
PiAgCQlyZXR1cm4gLUVGQVVMVDsNCj4+ICAJfQ0KPj4NCj4+IC0JLyogRnJlZSB0aGUgb2xkIENV
IG1hc2sgbWVtb3J5IGlmIGl0IGlzIGFscmVhZHkgYWxsb2NhdGVkLCB0aGVuDQo+PiAtCSAqIGFs
bG9jYXRlIG1lbW9yeSBmb3IgdGhlIG5ldyBDVSBtYXNrLg0KPj4gLQkgKi8NCj4+IC0Ja2ZyZWUo
cHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2spOw0KPj4gKwlXQVJOX09OX09OQ0UocHFuLT5xLT5w
cm9wZXJ0aWVzLmN1X21hc2spOw0KPj4NCj4+ICAJcHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2tf
Y291bnQgPSBwLT5jdV9tYXNrX2NvdW50Ow0KPj4gIAlwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFz
ayA9IHAtPmN1X21hc2s7DQo+Pg0KPj4gIAlyZXR2YWwgPSBwcW4tPnEtPmRldmljZS0+ZHFtLT5v
cHMudXBkYXRlX3F1ZXVlKHBxbi0+cS0+ZGV2aWNlLT5kcW0sDQo+PiAgCQkJCQkJCXBxbi0+cSk7
DQo+PiArDQo+PiArCXBxbi0+cS0+cHJvcGVydGllcy5jdV9tYXNrID0gTlVMTDsNCj4+ICsNCj4N
Cj5UaGlzIHdvbid0IHdvcmsgY29ycmVjdGx5LiBXZSBuZWVkIHRvIHNhdmUgdGhlIGN1X21hc2sg
Zm9yIGxhdGVyLg0KPk90aGVyd2lzZSB0aGUgbmV4dCB0aW1lIGRxbS0+b3BzLnVwZGF0ZV9xdWV1
ZSBpcyBjYWxsZWQsIGZvciBleGFtcGxlIGluDQo+cHFtX3VwZGF0ZV9xdWV1ZSBvciBwcW1fc2V0
X2d3cywgaXQgd2lsbCB3aXBlIG91dCB0aGUgQ1UgbWFzayBpbiB0aGUgTVFELg0KDQpMZXQncyBq
dXN0IHJldHVybiB3aGVuIG1lZXRpbmcgYSBudWxsIGN1X21hc2sgaW4gdXBkYXRlX2N1X21hc2so
KSB0byBhdm9pZCB0aGF0Lg0KTGlrZSBmb2xsb3dpbmcsDQoNCnN0YXRpYyB2b2lkIHVwZGF0ZV9j
dV9tYXNrKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwNCgkJCSAgIHN0cnVjdCBx
dWV1ZV9wcm9wZXJ0aWVzICpxKQ0Kew0KCXN0cnVjdCB2MTBfY29tcHV0ZV9tcWQgKm07DQoJdWlu
dDMyX3Qgc2VfbWFza1s0XSA9IHswfTsgLyogNCBpcyB0aGUgbWF4ICMgb2YgU0VzICovDQoNCglp
ZiAoIXEtPiBjdV9tYXNrIHx8IHEtPmN1X21hc2tfY291bnQgPT0gMCkNCgkJcmV0dXJuOw0KCS4u
Li4uLg0KfQ0KDQpJcyB0aGlzIGZpbmUgd2l0aCB5b3U/IFRoYW5rcyENCg0KUmVnYXJkcywNCkxh
bmcNCiANCj5SZWdhcmRzLA0KPsKgIEZlbGl4DQo+DQo+DQo+PiAgCWlmIChyZXR2YWwgIT0gMCkN
Cj4+ICAJCXJldHVybiByZXR2YWw7DQo+Pg0K
