Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C5FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 02:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE7D10E6D9;
	Fri, 18 Nov 2022 02:00:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5F210E6D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 02:00:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYhobxkgmTvR9gzlKMAwH9jNn1iq+YN+o0in571A5+A6Q7/NiTBiqSFLLEf9j9OvQdJwRUjkNoj22g8LFDBqqa0L+GH9AdeUtcxUMaawmE59N08pSRY27x8Or3VQwHuLz4uFS4mdZTLAcHHhKfKIdGWSWM3TkCaIUlgg/bK2i/nuwSKnP3dxPh2cUCnzEbB+I5W1LQoh7+qKRXLPLZT00ZUEcDrPsQi0sJbtphnXzIytIj5sQU8jVYNg59ET4YAP4Fjuv0KruuP+sZJuM7f+wtCyAq20Kp8Usv8+/kONJ181/YwcY0S8dM8pP57wZ4Sg3T0znFR4XVMZKilOPN0cYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmn1GZYuPHXBtjlB7CfweXqrYpCoole9SjoHpT/2wfU=;
 b=F0hfC0FFQgHdYfuC7M0Xh8a5dKRjO7SZDRuNP8s4L/C4GF9rOVN+WVUmu6laHPqUfcvFnY//E2Uf7gs8HABNbS3ugkl43JdiyFacaDyoaV6NS9pSHgSbxxrEjPLkHxhMEimf1E7QNKtWMySEGr1GM3RjuhJyHzwlJ3hEL8zuHIsHhey0flZ60foxC/XkuXg73Rq9EUQTiCh6nQuCwX3mSapvTJ7fmZnw10K2APrkKXrZIughyMkFwoGJ94teEWY4KqkR4t6LkSCP9qbmEffbGANSwgC63cLHzSWD6wrP16xYLwNgM4WqXLlJqNsfGT0kkuLFF3YPMYntMCm7BdNXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmn1GZYuPHXBtjlB7CfweXqrYpCoole9SjoHpT/2wfU=;
 b=NoClunpNRO8X8RLZPaFPsua2/ZphI4ZAR/DiNCb5wM2KxIh9N0Uebumdlpo+aImFrOC7EigdKkpQoqPdOWyi1FDFKCNcswlLmEhoeuu2ex2+2d9doSJNQyVZ7Jcs6pzmqAit+qPs2NFr+L/nXnGnJe22YJGhitE/jCbedjEUUYQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.19; Fri, 18 Nov 2022 02:00:06 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff%7]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 02:00:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix compilation issue with legacy gcc
Thread-Topic: [PATCH] drm/amd/display: fix compilation issue with legacy gcc
Thread-Index: AQHY+uoEwBw2Ro1Cv0iyYqxuCV3JYq5D7NPg
Date: Fri, 18 Nov 2022 02:00:06 +0000
Message-ID: <DM5PR12MB2469F61A44D3F34C19922757F1099@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221118010604.34711-1-bobzhou2@amd.com>
In-Reply-To: <20221118010604.34711-1-bobzhou2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4139:EE_
x-ms-office365-filtering-correlation-id: ef2ee04e-de2d-4660-3042-08dac9089d3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/eqkeNihfjUyWV4ZU+KbFDFx16ozWP4n8Z3i1Y40ty6meLrO0ebDuta4EIgnUyWBQn4X7cqCmzJfA/8MpQh8tzdgpj79tWvj9s4trqX+jzlYBwCIed5YQGeXBYk4hoYMepqfNX21CupyrvyoKWEnrvaCHpUR1lvkyGrlpawCyNr9QsrtFt6wRjPpnDHErKbDTPaid5hWnj6GGCBjqgg9A1FU8gxlR8ypCq2v9mveVqIqeJpNDc+22abAIl7+qVUyyOxiYG42X79uOatxklNOMbZoc8eA5ZguTC41grF4IAjdBGnVKhavaFg85jd4fgZIEKM68XICSDImdE58oHbbnghCGxYo8KOAlCCAbfrvmB4qU5W+wJ+mFIzYaB+MMqL51KqbuYAoWMnSMhEjE4JSmGgA0WOZdVuslwWi7s+CEMg1PwnYnsfP+8y/wrZ6EcbDpbr70nkbCncIehFh+4UOCjYMCOIwd7uwAnYKXmIuDYfed4N2riSok2/JlW0iSOtAYXY/5lVYCIDKCWFGiiYbjCzvB8MEAa1+xcWm/uxq00WvTS4mZnE4VCn0d8kw2Rn/5A5haRnw5A0FgylGdVrNRZqqlHodgJsxbdc6cDj91sXu0B61wzvO0Obuosx9YfVP9RZvAhxcmF+G7niY4yfjhtotdY15V86GbzRuOg6M46pc3wRNUpLFrEtQi5IF6lXD42t5Nat0UPD9yqQQAD2OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(83380400001)(2906002)(5660300002)(8936002)(478600001)(186003)(122000001)(52536014)(38100700002)(53546011)(316002)(55016003)(38070700005)(71200400001)(66476007)(64756008)(4326008)(8676002)(66556008)(86362001)(26005)(41300700001)(76116006)(66946007)(6506007)(9686003)(66446008)(33656002)(7696005)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUx5L2NGSGVkL3JNb3JEYzNpQ1ZTSkpWT2NWQytubWJsbGZKeC82U2M4L2NR?=
 =?utf-8?B?OUtvaG1OaDVmOWtrSDhFNnFCYjFpOWgwZ0FiSngxOFVuc21TRll3d3R2NlNP?=
 =?utf-8?B?czB1TG56K2huVzFvT1ZQeWhGbDV6VmJHQ3JFVjEzVDhPVTJ2YkpvSGFHdE5D?=
 =?utf-8?B?LzYxV3dvT3dLVGwwYWJnMnV6ODd6QXd2Zy94WHVQY2VuTDNHRGVBV3RNajNt?=
 =?utf-8?B?TUt3K2FnRHl2dnRCRU5uME9kUXMvZ1J6WFUvRjhOK3JCNUJ3cm9zTGpEMFVW?=
 =?utf-8?B?S2ZNWkRUK0M2M2YrbVlaVEJ2bmpMdlBhNWdxQ3ZpMS9yenJobVNYcThZMThO?=
 =?utf-8?B?OWNMVkMrdm90bEVSeXVPM1RsMGdDSVp4bW5CaDhNRGFrR1dDTkg4ZzlkU2NR?=
 =?utf-8?B?N3pPckNQQkk5L2h6QzFTU05iVGpMcmk5eEh5dnYvdVUydWR0UUNFdS91WUhn?=
 =?utf-8?B?eEQ2UG1ETVFqWWErQVVQYkx5bGZQMkEwWllPaWlKTENnSXVLNW1yZEt6QzV2?=
 =?utf-8?B?OTc4V0U1cXhsZ2Rqck02Q2NYNkNMYytsd3ZzTy9YSFNwZGtyU1dkUXUxZmN0?=
 =?utf-8?B?a3Q4VkZ6aUpid0luajZGNTZISHZKZjhSeVNXRE9DOWUzM0lpaCt4c2k2ZHM4?=
 =?utf-8?B?MUtBMStLTTBranhFMVJzU29IL0kxUWFvVDRYVVZnRklsWStHTGRwMWQzYWVP?=
 =?utf-8?B?cWJoUWpDa0V0WHpwQXYyTUJsenlyRXlOb2c5Q2YzVnVWQUttbHpmQ1ErNHlN?=
 =?utf-8?B?Ri9ydFRhZXl3ZFVXNUNmYXBOQjFER3IycG9JVWZwV1NXYmxlOVgzQ1d6SDUz?=
 =?utf-8?B?WFExemZ0dTBNRWF1aWdtVzFUK3B5Z0w0OFJMLzcxUzZzYzNwRHFydEY4ODZY?=
 =?utf-8?B?eDhxT0tyQnFoS3VvdElGNlRnS2ZTcG5rYnFGOEFDVWNxZHVnT0x6TGkyTVVq?=
 =?utf-8?B?QjRlUWVPWnFMNThYRmYrOFZRWXk4MmpsdENsNGxYeHBHd1V6eFJVd0E3RDFC?=
 =?utf-8?B?aU1Zc01SM2IrME9haEVicE1Qd0pQSWUxeDZscFNSb3lsZmE1aHZsdi9CUDNB?=
 =?utf-8?B?NXRMYmh3NjJzRmlNdExIWmtzMm4rYThXVW1OTHlqL1U5WVhESUNMVjRrRnNF?=
 =?utf-8?B?QzUyYmg5WGxsS0FZT2lZWXR1cUtPYXJpNGE2MHhUWTZQckIvUi81RHh0Ri9L?=
 =?utf-8?B?cjZsNVB5K2V3anU2MHJkVnUwTkR6TDllQXFqTU9JTk5JNHBtbThHWWhFUGJB?=
 =?utf-8?B?VTJrQnZmQnN4c29Xb050TW93VWF6WDBKMXQrakJLcnB4WWVNdE5lcThlUXlE?=
 =?utf-8?B?MzRYRlAxekhLeUFPMS9HYW00S05BVDFUdVo3VlpIQ29BSTRHNkFvVmtyZDhw?=
 =?utf-8?B?QWkwZXAzWVVpTzlQL3RjRGpMbWxsRHliVTBoeXhkWjlZYmc4K3V5cDRnOXEw?=
 =?utf-8?B?OXFGUWdhNXd4RGFGaWdtK011MHBJcDRab09YeXQrcXlOR2Y3VkJKV2FVajRo?=
 =?utf-8?B?ZTZ4WW4xdTJPS0ZjQkVmN2IrZTB6NndDbTJSeGlzeTVSRWVnNVYxQjJtYk92?=
 =?utf-8?B?L0prdkdWM3V3bDFkdnRGZUhRd2R0ZW9udjBSV1BwUDF0QVl0c0xZNkQwbWpM?=
 =?utf-8?B?UlVGbWE5cy9ndHdaUDM1MXl5cUg1T2U0OStObjAyS1pXRSt1c0pKUUFJN0t5?=
 =?utf-8?B?UUwrVWo0U3B3RS9kcW1BTjJNb3RjU0drdTVkVE1lS2VnaWtndUsvT1BYVmFD?=
 =?utf-8?B?UzNzWk1rcWdHNHpQcHZ3NERFdXI0VEV2Qi9HTk9ZMWdCaVg3TkQ5WHFCUEdi?=
 =?utf-8?B?eVc1SzVvQnM5aGpuVEFRQ1VnT2hUZU04MlNlZUw2NHVxOC9Sd0dCeGg2Q0Ni?=
 =?utf-8?B?RW9iMmlqRG9hellxbG9aMnRaMExmS2N3N3RwUkY1Wmd6WUIzVFJkVXpCUDdD?=
 =?utf-8?B?MXlJNlFIRHVoM0RGVEFYOW1SdmErdHg0UEQ3bUU3Z2h2ZmpVTG9STVN1WDV2?=
 =?utf-8?B?bnFmNllxQXdLTVpKSTUrdDRkMGZwTHVySUc2YlZmTU9qNHN2TGpYQzlPWTR5?=
 =?utf-8?B?TEF4QWY4NHNDbFVaaFVDZVNOd0pITVprUU1WYXd6L0xpekVEVEc0eVovSzVJ?=
 =?utf-8?Q?uyj78hnJparbNUYZ8XsmOuYI6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2ee04e-de2d-4660-3042-08dac9089d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 02:00:06.0701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XN9cjNhZqzxrwDGdi1Iz+sZHK5NMQoIH3n+4JVisUlJy+GxFE7D7e/egAf8+1hA1GBSioiKATogCXpJws5C3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBib2J6aG91IDxi
b2J6aG91MkBhbWQuY29tPiANClNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTgsIDIwMjIgOTowNiBB
TQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogQ2hlbiwgR3VjaHVuIDxH
dWNodW4uQ2hlbkBhbWQuY29tPjsgWmhvdSwgQm9iIDxCb2IuWmhvdUBhbWQuY29tPg0KU3ViamVj
dDogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IGZpeCBjb21waWxhdGlvbiBpc3N1ZSB3aXRoIGxl
Z2FjeSBnY2MNCg0KRnJvbTogQm9iIHpob3UgPGJvYnpob3UyQGFtZC5jb20+DQoNCiAgICBUaGlz
IHBhdGNoIGlzIHVzZWQgdG8gZml4IGZvbGxvd2luZyBjb21waWxhdGlvbiBpc3N1ZSB3aXRoIGxl
Z2FjeSBnY2MNCg0KICAgIGVycm9yOiDigJhmb3LigJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9u
cyBhcmUgb25seSBhbGxvd2VkIGluIEM5OSBtb2RlDQoJZm9yIChpbnQgaSA9IGZsYWdfdmxldmVs
OyBpIDwgY29udGV4dC0+YndfY3R4LmRtbC5zb2MubnVtX3N0YXRlczsgaSsrKSB7DQoNClNpZ25l
ZC1vZmYtYnk6IEJvYiB6aG91IDxib2J6aG91MkBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYyB8IDMgKystDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMzIvZGNuMzJfZnB1LmMNCmluZGV4
IDdlNjRlYTZhMDk3My4uOTdjMTVjNGQyODA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYw0KQEAgLTE3NjEsNiArMTc2
MSw3IEBAIGJvb2wgZGNuMzJfaW50ZXJuYWxfdmFsaWRhdGVfYncoc3RydWN0IGRjICpkYywNCiAJ
aWYgKHJlcG9wdWxhdGVfcGlwZXMpIHsNCiAJCWludCBmbGFnX21heF9tcGNfY29tYiA9IHZiYS0+
bWF4TXBjQ29tYjsNCiAJCWludCBmbGFnX3ZsZXZlbCA9IHZsZXZlbDsNCisJCWludCBpOw0KIA0K
IAkJcGlwZV9jbnQgPSBkYy0+cmVzX3Bvb2wtPmZ1bmNzLT5wb3B1bGF0ZV9kbWxfcGlwZXMoZGMs
IGNvbnRleHQsIHBpcGVzLCBmYXN0X3ZhbGlkYXRlKTsNCiANCkBAIC0xNzc5LDcgKzE3ODAsNyBA
QCBib29sIGRjbjMyX2ludGVybmFsX3ZhbGlkYXRlX2J3KHN0cnVjdCBkYyAqZGMsDQogCQkJCWZs
YWdfbWF4X21wY19jb21iICE9IGNvbnRleHQtPmJ3X2N0eC5kbWwudmJhLm1heE1wY0NvbWIpIHsN
CiAJCQkvKiBjaGVjayB0aGUgY29udGV4dCBjb25zdHJ1Y3RlZCB3aXRoIHBpcGUgc3BsaXQgZmxh
Z3MgaXMgc3RpbGwgdmFsaWQqLw0KIAkJCWJvb2wgZmxhZ3NfdmFsaWQgPSBmYWxzZTsNCi0JCQlm
b3IgKGludCBpID0gZmxhZ192bGV2ZWw7IGkgPCBjb250ZXh0LT5id19jdHguZG1sLnNvYy5udW1f
c3RhdGVzOyBpKyspIHsNCisJCQlmb3IgKGkgPSBmbGFnX3ZsZXZlbDsgaSA8IGNvbnRleHQtPmJ3
X2N0eC5kbWwuc29jLm51bV9zdGF0ZXM7IGkrKykgew0KIAkJCQlpZiAodmJhLT5Nb2RlU3VwcG9y
dFtpXVtmbGFnX21heF9tcGNfY29tYl0pIHsNCiAJCQkJCXZiYS0+bWF4TXBjQ29tYiA9IGZsYWdf
bWF4X21wY19jb21iOw0KIAkJCQkJdmJhLT5Wb2x0YWdlTGV2ZWwgPSBpOw0KLS0gDQoyLjI1LjEN
Cg0K
