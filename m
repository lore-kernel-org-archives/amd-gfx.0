Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C2C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DBB60FDC
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 17:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DBB60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD79D89C9D;
	Mon,  7 Jun 2021 17:33:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D54589C9D
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 17:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igWhPOZt/yE1KeQWg0EfryiEcB9oigzvJvDKJXtJyeBJTiuQEESOitls3ovGTwwZiZ0hQH15OitxpH4tmfOlumEwA2mRPqLFqaS5XhzL6s+tqGWvfEjnkD4lhK4JhsgkWyMV4s6qK7SBsI4R2Vx9KggVDvOzHjJq+Ot+Yzsn+ICCdXnOmAXK8Oq28DcipNhPLz/QlpKtzD/v0sU36QDvDsNAQfv9oRwDfyCAzuQHYN+np8W5uWR1EFBmF4cQGKWFUl7xAMlFbNTieOJaR5xM8wCURLTtRVrgvd0bUAm1Qv5ysDi4HydcfB8PvoB4uE1qym0SHp/nRZd6Mg34s6WFYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N5utIFGgu2ReOiR/P5TVTtZebvMjfcpuJWkg/EMkY0=;
 b=h0+XIQqbaC2W7Hc/D9rc0R6RAZtSr+FCxBpLFEn8a1/wnw6A5M2x0eShHG+mso40EVqDyCSAf6PBia6bt1JZYrbWnUJNk68z55QRP02blJeswoWx9fi+Qtfg2Wnt/eH2e4WkGN+x9SMbn4DVH8wDLiUCiB2Bddcu3j2c8M0Xjoi7NOO+uPpHBlgmyLVbPJ4jYaf6MKyyEqt94UIjWOPKVD+tgS0zbYeNnHOBgqVYYBebUYPArqZJGmicnwE6qT+RG/T7RCw/5v7+IKYJdMEmiYQ4HFRLV3fBAk8EIWVs2UtORwoM/a6TlTyjl66wWwgghShAK/7GnBZe0tlDjzD1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N5utIFGgu2ReOiR/P5TVTtZebvMjfcpuJWkg/EMkY0=;
 b=AjPAHbL7nvnBAmQ0xWR5oWWH57OOrSoNfxVUpNEgjTkqdYq4SewVJfXofttj0FbwQ8Dg1ttdeST8NwCyul70LY0Xsz1j2X7p1OpELBowwhzhfg3A3SGUytom/SkkYnHsE+iX0u1Ze04G/PtZJa7tAzmo0lCGsTSjo9GN0PkhiFY=
Received: from BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 17:33:06 +0000
Received: from BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689]) by BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 17:33:06 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deng, 
 Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhou, Peng Ju"
 <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on
 SRIOV
Thread-Index: AQHXW6jBBOCm0Cq7+0e2cLfTYbZVMasInCcAgAANbpCAAArEAIAAAHBQgAAIjwCAAAG8AIAAAc4AgAAN+5A=
Date: Mon, 7 Jun 2021 17:33:06 +0000
Message-ID: <BL0PR12MB475518F3384F7E42EE7428D887389@BL0PR12MB4755.namprd12.prod.outlook.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
 <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <da0025b0-308f-6f2f-e4d8-b5a68117828c@amd.com>
 <BL0PR12MB47552C90D8667E1107279AD487389@BL0PR12MB4755.namprd12.prod.outlook.com>
 <bf87ed0d-d32d-5701-f9bf-c71f6a6b23b6@amd.com>
 <fddc3188-55b9-55e4-485c-4568a621c466@amd.com>
 <4d486c0b-8bd1-71aa-fdb4-3413e27beeb0@amd.com>
In-Reply-To: <4d486c0b-8bd1-71aa-fdb4-3413e27beeb0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-07T17:33:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ec468e15-fe60-4877-a743-a47b0bd7b6d2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d379d2-f7b7-456b-374d-08d929da4f9e
x-ms-traffictypediagnostic: BL0PR12MB4947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4947B2BFDA636EB68BE8461D87389@BL0PR12MB4947.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHETUeDuDx878iDNA/JmQqe+RDNfxItNHLWKBoc6plQYNKE8aYc3ReNtY7/6hKuucWAKPTVgoL9K+rG5hjaBegdWXVl9y5i8fI1r/x+nDwXiOx0wkzo1Q8o/75q+O03EumfbA1Wls5MTt4EK6fJV2OYZM9puwp9OJCEtaGKgBj6d+FgPn9UtyiV9mfj+o+HbT+SXhiuRuZA4MiHJuc6ZqTWCijnq9Cf+VFBpPZl1Z9qq7hrHLMSvxSlBiLH/yRcKGbWg6zja9PLiXU8inc0vOShGjDeIowXsfzjRbwaFhiffyIgyXqkzVEmIOdRgqmnoOryNjiRnRAx5vsgbWdq4cpaGfBMIuK6g/0WCqxZTwI55lnYzGKWO8LTPPiqb1J8O//U8E86+mAWLQw7pScNWvSYeublo/J1jVDZI22kTxDPwcvcbnMHpNnvE3dpw770FmFS/AzVn7ocsP5rmBnISSD/2DhcqlC0qicKVE9Q0/ieM2moEL4Vjsl4YBNH5RJE3VW9VkPnRnQz/Fah5wme1XkA8GNwpP9mtBFf54M1rqKC0jgSWvZOk4ApSc/4+DrQWjFXMdc4NfdloGC9AovF/fGuwHunOJcphvfvyALyIHyorWfsZDV//qT3iuDvUGxTc6g/8y5bQFJLVcNzdfM0RIw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4755.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(478600001)(71200400001)(122000001)(921005)(4326008)(6636002)(5660300002)(7696005)(66574015)(53546011)(33656002)(6506007)(86362001)(110136005)(55016002)(316002)(52536014)(76116006)(64756008)(9686003)(66476007)(66446008)(66946007)(8936002)(83380400001)(66556008)(186003)(8676002)(2906002)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?R1ozT0QwZTd5ZXQ1ZE9RMHBQTzZxRUJCTjZLZExseTlLVTlLUHB6QUx4dVUw?=
 =?utf-8?B?ZW5CalEzLzJQNUQvVHJUNEZKejhNWDUzUnUrcmZabUl1MlJwckdVWnYzNlhO?=
 =?utf-8?B?RmdDTmk0NWVSMWZxb3JZbVE3OVVVS1U4UTBYempXWTQvbnVBcCtTcU9rdDdu?=
 =?utf-8?B?VzBiODJVdjZWT2MyWENaWGlJN3Y4emVvbjNMVk02eVJrd1hwR016YmdxTEM3?=
 =?utf-8?B?bVlXUVNWb1V5SUFaQkw1aHA0VUQvTzg1QUdVMzJuSHhWaERKZi93OC8vUTJ2?=
 =?utf-8?B?YisveEQ1Y2dxdisyNThsL2tidmRxWWlWT3QycHhJbGptUEF6a1d5OFZGOEYy?=
 =?utf-8?B?VHRZc1hOdG9ENDFMMysyRWRXTXZtQlVnY1IyWGJ3S0k4dlh6WU9LaDlSSGhJ?=
 =?utf-8?B?N2syR2hGYzZsRzB5cFVYSVlIN1dUQzI1NUVqREJVNTF3dWc3UUJNQkFiZ1Ry?=
 =?utf-8?B?ZVg5eDVQdGtWSGd1NmRtSkFZU1ZTeFAxcDVKbnFmMEhQaVNjQkJhTnJ2dmVM?=
 =?utf-8?B?T0NpeElSSE9zYmd2RmVlRmh4N1gxeHp4SHA0SWJUNXFLelAzOWIrUERhSHlB?=
 =?utf-8?B?TDBzZ0pMVlJQUnoyQ2ZGZFFUYmROaUpPeXJtQmlvWDhMdlJsSjY4MWtzeWNC?=
 =?utf-8?B?Z3cyU1o5MW43WHN5Z1VITk9kdTVTYU9TRTUxU3ZVU2Nqa2V3K2ZWQkxEZC9K?=
 =?utf-8?B?SHFVa3dnZlMxMkk4Qm9IUUp3ckhxZkVxWG9HRk5rSy9aMlF4S0lhajlVYllT?=
 =?utf-8?B?c0svT29ZZ21kaGRvbEdrbXA0ckNya0l3cS9zKzZlbEUvK0NwU09OQVBkM2Vv?=
 =?utf-8?B?OFVGVTF4QjM2NzVPVi9NVkU1ZEdvbWZDWHB1dTQxUzlGNkVDOXZ2ZkRUU0Z6?=
 =?utf-8?B?eWpsZFJVcW1YTHRzNnRHV2puQ09mbG1SUXJiVkRISU5jZnhRZXFnNjhHVmgz?=
 =?utf-8?B?dDV3cG0zVUwwZEIyZ2FDUk9UWnR2YUxnLzY4ZmxrTFp4aHFOZTl5cmRMeFBB?=
 =?utf-8?B?Wjk3TUNxcXhRS1N1S2dHZEtjM0gwUkNmYlYwWHFVTVdpeTBRdVpQeTE3Sk10?=
 =?utf-8?B?eWx1dmhFaUdiOEQxYU5DZVBSdGNUR0MrQWJMdU5JNXluK2N0TDhyT2duVHVj?=
 =?utf-8?B?Tkg5cUduZjllUHJjNEZ0eURvR29YelFhVHRFUlQ1Y3lDYXdMcjJMUDJFMmV3?=
 =?utf-8?B?R01ROHZuSE4wVDcrcXdqQS9tQU45WUZkdGFFTGFUSmRFRjg5TlFOeG1mM3pw?=
 =?utf-8?B?N2pCWXhRRXROWndqWWhvZzdwd0dJZmdCM2VpL3cxNGdjbzlPTTBiOXR0NCt3?=
 =?utf-8?B?VGxEN2FoZHROdFlUZHNMTGprOXRTcE1OZ2txUmgyUktyL0drWWxac2dLdCtH?=
 =?utf-8?B?dHR0SmpYbTFwT0dyNURNd1ZyT3htakhEaVNhZVhOc2hLYnFES0FpcE5sNm5U?=
 =?utf-8?B?Zzhya1RVM05RaTZaVFNIZW9IMVpyVG14M3RNemppTmpNV0xRYXB4VHZuWFpw?=
 =?utf-8?B?OGFBWTdvc1l2TFpsUnovekpLbWRSOTE4K1RiUUxaUm1HQkhRVFVnM1RHenhE?=
 =?utf-8?B?a2hIYmJ0K3k1eDNkMFdsRUxoNnFnQjk4cmx0S1puOWRiSW5NaFllUnVYZFdN?=
 =?utf-8?B?QkY3T0EvZlRDdDhLb3BibEYvbGJkRHUydTFzRWlIK29Xa2hDTVJJYytjMDg1?=
 =?utf-8?B?UktVeitCdlZNQ21CczN3bDN5ZjYvRTBGZUtZR1FjaWtON2tXUjNZRlZDaXdr?=
 =?utf-8?Q?KcX8K5gbLy3AABoz+bbkRyjbkDrzEHJc/Jftg7t?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d379d2-f7b7-456b-374d-08d929da4f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 17:33:06.3305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OzoN+JuTKChXir1oWEI4Bl0e4O7rnPXV64RqaBIUwjrnLFUA/gj5WF7xbCgBNylb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpPSy4NCg0KSSB3aWxsIGp1c3Qgc2tpcCB0aGUgZnVuY3Rpb24g
Y2FsbCBmb3IgU1JJT1YgYW5kIHJlc2VuZC4NCg0KUm9oaXQNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+IA0KU2VudDogSnVuZSA3LCAyMDIxIDEyOjQyIFBNDQpUbzogS3VlaGxpbmcsIEZlbGl4IDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgS2hhaXJlLCBSb2hpdCA8Um9oaXQuS2hhaXJlQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT47IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1v
bmsuTGl1QGFtZC5jb20+OyBaaG91LCBQZW5nIEp1IDxQZW5nSnUuWmhvdUBhbWQuY29tPjsgQ2hl
biwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPg0KQ2M6IE1pbmcsIERhdmlzIDxEYXZpcy5N
aW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBVc2UgUFNQIHRv
IHByb2dyYW0gSUhfUkJfQ05UTF9SSU5HMS8yIG9uIFNSSU9WDQoNCkFoLCBnb29kIHBvaW50LiBJ
biB0aGlzIGNhc2Ugd2Ugc2hvdWxkIHByb2JhYmx5IHJhdGhlciBzYXZlIHRoYW4gc29ycnkuDQoN
ClRoZW4gSSBzdWdnZXN0IHRvIGNsZWFuIHVwIHRoaXMgcGF0Y2gsIHJlcGVhdGluZyB0aGUgcHNw
X3JlZ19wcm9ncmFtKCkgYW5kIGVycm9yIG1lc3NhZ2UgaXMgcHJldHR5IGhvcnJpYmxlIGNvZGlu
ZyBzdHlsZS4NCg0KQ2hyaXN0aWFuLg0KDQpBbSAwNy4wNi4yMSB1bSAxODozNiBzY2hyaWViIEZl
bGl4IEt1ZWhsaW5nOg0KPiBXaXRoIFNSSU9WLCB0aGUgaW50ZXJydXB0IHJvdXRpbmcgaXMgc2V0
dXAgYnkgdGhlIGh5cGVydmlzb3IgZHJpdmVyLiANCj4gV2UgbmVlZCB0aGUgc2Vjb25kYXJ5IElI
IHJpbmdzIGluIGNhc2UgdGhlIGh5cGVydmlzb3IgZW5hYmxlZCANCj4gcmVyb3V0aW5nIG9mIHBh
Z2UgZmF1bHQgaW50ZXJydXB0cy4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIGh5cGVydmlzb3IgZHJp
dmVyIGRvZXMgdG9kYXkuDQo+DQo+IFJlZ2FyZHMsDQo+ICDCoCBGZWxpeA0KPg0KPg0KPiBBbSAy
MDIxLTA2LTA3IHVtIDEyOjI5IHAubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOg0KPj4gVGhh
dCdzIGEgd29ya2Fyb3VuZCBmb3IgYmFyZSBtZXRhbCBhbmQgYXMgZmFyIGFzIEkga25vdyBkb2Vz
bid0IGFwcGx5IA0KPj4gdG8gU1JJT1YuDQo+Pg0KPj4gV2Ugb25seSBuZWVkIHRoZSBhZGRpdGlv
bmFsIElIIHJpbmdzIGZvciBwYWdlIGZhdWx0IGhhbmRsaW5nIG9yIGxvZyANCj4+IGhhbmRsaW5n
IGFuZCBhcyBmYXIgYXMgSSBrbm93IHRoYXQgaXMgaW5jb21wYXRpYmxlIHdpdGggU1JJT1YgZm9y
IHRoZSANCj4+IG1vbWVudC4gQnV0IEZlbGl4IG1pZ2h0IGhhdmUgc29tZSBtb3JlIHVwZGF0ZXMg
b24gdGhpcy4NCj4+DQo+PiBTbyBhcyBsb25nIGFzIHdlIGRvbid0IHN1cHBvcnQgdGhhdCB1bmRl
ciBTUklPViB3ZSBkb24ndCBuZWVkIHRoaXMgDQo+PiBwYXRjaCBlaXRoZXIuDQo+Pg0KPj4gQ2hy
aXN0aWFuLg0KPj4NCj4+IEFtIDA3LjA2LjIxIHVtIDE3OjU5IHNjaHJpZWIgS2hhaXJlLCBSb2hp
dDoNCj4+PiBbQU1EIFB1YmxpYyBVc2VdDQo+Pj4NCj4+PiBUaGUgaGFzaCBpcyA1ZWE2ZjljDQo+
Pj4NCj4+PiBSb2hpdA0KPj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBG
cm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPj4+IFNl
bnQ6IEp1bmUgNywgMjAyMSAxMTo1OCBBTQ0KPj4+IFRvOiBLaGFpcmUsIFJvaGl0IDxSb2hpdC5L
aGFpcmVAYW1kLmNvbT47IA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVj
aGVyLCBBbGV4YW5kZXIgDQo+Pj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgDQo+Pj4gRGVuZywgRW1pbHkgPEVtaWx5
LkRlbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IA0KPj4+IFpob3Us
IFBlbmcgSnUgPFBlbmdKdS5aaG91QGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgDQo+Pj4gPEhvcmFj
ZS5DaGVuQGFtZC5jb20+DQo+Pj4gQ2M6IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5jb20+
DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogVXNlIFBTUCB0byBwcm9ncmFt
DQo+Pj4gSUhfUkJfQ05UTF9SSU5HMS8yIG9uIFNSSU9WDQo+Pj4NCj4+PiBEbyB5b3UgaGF2ZSB0
aGUgaGFzaCBmb3IgdGhpcyBjb21taXQ/DQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gQ2hyaXN0aWFu
Lg0KPj4+DQo+Pj4gQW0gMDcuMDYuMjEgdW0gMTc6MzAgc2NocmllYiBLaGFpcmUsIFJvaGl0Og0K
Pj4+PiBbQU1EIFB1YmxpYyBVc2VdDQo+Pj4+DQo+Pj4+IFdlIGRvbid0IG5lZWQgUklORzEgYW5k
IFJJTkcyIGZ1bmN0aW9uYWxpdHkgZm9yIFNSSU9WIGFmYWlrLg0KPj4+Pg0KPj4+PiBCdXQgbG9v
a2luZyBhdCB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlIGl0
IA0KPj4+PiBhZmZlY3RzIFJJTkcwIHRvbz8NCj4+Pj4NCj4+Pj4gIiBkcm0vYW1kZ3B1OiBhZGQg
dGltZW91dCBmbHVzaCBtZWNoYW5pc20gdG8gdXBkYXRlIHdwdHIgZm9yIHNlbGYgDQo+Pj4+IGlu
dGVycnVwdCAodjIpDQo+Pj4+DQo+Pj4+IG91dHN0YW5kaW5nIGxvZyByZWFjaGVzIHRocmVzaG9s
ZCB3aWxsIHRyaWdnZXIgSUggcmluZzEvMidzIHdwdHIgDQo+Pj4+IHJlcG9ydGVkLCB0aGF0IHdp
bGwgYXZvaWQgZ2VuZXJhdGluZyBpbnRlcnJ1cHRzIHRvIHJpbmcwIHRvbyBmcmVxdWVudC4NCj4+
Pj4gQnV0IGlmIHJpbmcxLzIncyB3cHRyIGhhc24ndCBiZWVuIGluY3JlYXNlZCBmb3IgYSBsb25n
IHRpbWUsIHRoZSANCj4+Pj4gb3V0c3RhbmRpbmcgbG9nIGNhbid0IHJlYWNoIHRocmVzaG9sZCBz
byB0aGF0IGRyaXZlciBjYW4ndCBnZXQgDQo+Pj4+IGxhdGVzdCB3cHRyIGluZm8gYW5kIG1pc3Mg
c29tZSBpbnRlcnJ1cHRzLiINCj4+Pj4NCj4+Pj4gUm9oaXQNCj4+Pj4NCj4+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4NCj4+Pj4gU2VudDogSnVuZSA3LCAyMDIxIDEwOjMxIEFNDQo+Pj4+
IFRvOiBLaGFpcmUsIFJvaGl0IDxSb2hpdC5LaGFpcmVAYW1kLmNvbT47IA0KPj4+PiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyIA0KPj4+PiA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIA0KPj4+PiA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPjsgRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IExpdSwgDQo+Pj4+
IE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBaaG91LCBQZW5nIEp1IDxQZW5nSnUuWmhvdUBhbWQu
Y29tPjsgQ2hlbiwgDQo+Pj4+IEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT4NCj4+Pj4gQ2M6
IE1pbmcsIERhdmlzIDxEYXZpcy5NaW5nQGFtZC5jb20+DQo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IFVzZSBQU1AgdG8gcHJvZ3JhbSANCj4+Pj4gSUhfUkJfQ05UTF9SSU5H
MS8yIG9uIFNSSU9WDQo+Pj4+DQo+Pj4+IFdoeSBhcmUgdGhlIHJpbmcgMSYyIGVuYWJsZWQgb24g
U1JJT1YgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPj4+Pg0KPj4+PiBDaHJpc3RpYW4uDQo+Pj4+DQo+
Pj4+IEFtIDA3LjA2LjIxIHVtIDE2OjIzIHNjaHJpZWIgUm9oaXQgS2hhaXJlOg0KPj4+Pj4gVGhp
cyBpcyBzaW1pbGFyIHRvIElIX1JCX0NOVEwgcHJvZ3JhbW1pbmcgaW4gDQo+Pj4+PiBuYXZpMTBf
aWhfdG9nZ2xlX3JpbmdfaW50ZXJydXB0cw0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFJv
aGl0IEtoYWlyZSA8cm9oaXQua2hhaXJlQGFtZC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICDCoMKg
wqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgfCAyMCANCj4+Pj4+ICsr
KysrKysrKysrKysrKysrKy0tDQo+Pj4+PiAgwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYw0KPj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYw0KPj4+Pj4gaW5kZXggZWFjNTY0ZThkZDUyLi5lNDEx
ODhjMDQ4NDYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9u
YXZpMTBfaWguYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEw
X2loLmMNCj4+Pj4+IEBAIC0xMjAsMTEgKzEyMCwyNyBAQCBmb3JjZV91cGRhdGVfd3B0cl9mb3Jf
c2VsZl9pbnQoc3RydWN0DQo+Pj4+PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPj4+Pj4gIMKgwqDC
oMKgwqDCoMKgIGloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2NudGwsIElIX1JCX0NO
VExfUklORzEsDQo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUkJfVVNFRF9JTlRfVEhSRVNIT0xELCB0aHJlc2hvbGQpOw0KPj4+Pj4gIMKgwqDCoCAt
wqDCoMKgIFdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSwgaWhfcmJf
Y250bCk7DQo+Pj4+PiArwqDCoMKgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYNCj4+Pj4+
IGFtZGdwdV9zcmlvdl9yZWdfaW5kaXJlY3RfaWgoYWRldikpIHsNCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAocHNwX3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdfSUhfUkJfQ05UTF9S
SU5HMSwNCj4+Pj4+IGloX3JiX2NudGwpKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBEUk1fRVJST1IoIlBTUCBwcm9ncmFtIElIX1JCX0NOVExfUklORzEgZmFpbGVkIVxuIik7DQo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgfQ0KPj4+Pj4gK8KgwqDCoCB9IGVsc2Ugew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSwgaWhfcmJfY250bCk7DQo+Pj4+
PiArwqDCoMKgIH0NCj4+Pj4+ICsNCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCBpaF9yYl9jbnRsID0g
UlJFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyKTsNCj4+Pj4+ICDCoMKg
wqDCoMKgwqDCoCBpaF9yYl9jbnRsID0gUkVHX1NFVF9GSUVMRChpaF9yYl9jbnRsLCBJSF9SQl9D
TlRMX1JJTkcyLA0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFJCX1VTRURfSU5UX1RIUkVTSE9MRCwgdGhyZXNob2xkKTsNCj4+Pj4+IC3CoMKgwqAg
V1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyLCBpaF9yYl9jbnRsKTsN
Cj4+Pj4+ICvCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJg0KPj4+Pj4gYW1kZ3B1
X3NyaW92X3JlZ19pbmRpcmVjdF9paChhZGV2KSkgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgUFNQX1JFR19JSF9SQl9DTlRMX1JJTkcyLA0K
Pj4+Pj4gaWhfcmJfY250bCkpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERSTV9F
UlJPUigiUFNQIHByb2dyYW0gSUhfUkJfQ05UTF9SSU5HMiBmYWlsZWQhXG4iKTsNCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9DQo+
Pj4+PiArwqDCoMKgIH0gZWxzZSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1
KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyLCBpaF9yYl9jbnRsKTsNCj4+Pj4+ICvCoMKg
wqAgfQ0KPj4+Pj4gKw0KPj4+Pj4gIMKgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShPU1NTWVMs
IDAsIG1tSUhfQ05UTDIsIGloX2NudGwpOw0KPj4+Pj4gIMKgwqDCoCB9DQo+Pj4+PiAgICAgIA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
