Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86B8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD8310E412;
	Mon, 17 Jan 2022 10:09:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D65010E323
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVlet6POfpFeOawNF0ujgZC3wXlg8d9khUZRypGGQnDl1CLnjxgGZDJ3SQtZNw6U+ENbu4J8VcJZPH8c1nUt5E/rWay31qADrdSti2khML5TgojmVb/DW+DKSbUYy30jmnkukMuBQQ4OLycq7S5k8iD4sgKM1isKZSh7cWS+GYOufWMInlZkQIdLJKj+Vlz1VMgYQeRIEbglNCCrfm7DRrNjoLKmJQdRSJZCR7wK8mLYdY5r9wohVZjExWgBlQ7wuq6NKcyksqiNJF+nUxjpczBQ/o0+swz5y20gOp5S9aVVh+AnTrTzdJ3j4JIFBKcr09+/PVw/ndK8PkMQd9hYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jub4ccnWvexS4MLM2QNdBrwET9T+RXa/BL55dMFnr6o=;
 b=bV3+/3Y58wBgVQfEr6DMt2jRcSpAztoD5UKkxtxo1QtVhC2jB1gKYu7CJDEr/ZN/tp1ppeBlV0Kj2hcYr4mw6cGL3odKiN3ps8WmcYafcCp6UoF7FSIkK+9jxULswlu4YyIKZnlsMLhmTW82oUvOmZQzDh4FnTQorPODly2pnwESvxRbyCBmGdY/QqVeSRCZjxkPhBz0lXyCGCOfr/GLEiBfssqAPeNOv4rg6+xywdB08ouA/LbH3ypB4/UKRZeV9uRZOhvSwxtXfg5ggSFj8jUf/qHgOd/wEIzAuAFrugLaaLmkCmJ9FcdJ7RJKaqcEuTFlIa/v2LHFFngxjYrazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jub4ccnWvexS4MLM2QNdBrwET9T+RXa/BL55dMFnr6o=;
 b=p+bM0Gm1JBL03970r0lXdgZkbOJRwx/Ht0MhbaUpmPNzZGNz1oKjr0gXXjJhSfu60ztECHyrojagBtEipVGHYZOnc/vrYK6h0LDtuYM5nglaK9pesxPJLlNaM8fXnvfKGzc86mcJ8IFFPG/nfMWfwOGSmTo7G8K9KX7ngnPhl24=
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 10:09:07 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::e8ac:d90:95b4:f70a%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 10:09:07 +0000
From: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Thread-Topic: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Thread-Index: AQHYC2w+rfMcQPxVFkGtUB910RQ1vqxm0HAAgAAqRGCAAAFHAIAAAGNg
Date: Mon, 17 Jan 2022 10:09:06 +0000
Message-ID: <DM6PR12MB3897D33226DBA88264B5BBF8F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
 <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
In-Reply-To: <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-17T10:09:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=83a8e398-4b55-4a28-a845-44ea0b45bc0f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-17T10:09:02Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d32bdcb0-fab9-4eba-9dd0-10fe6eb0f480
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ad00c79-0f2a-4ab4-8dcf-08d9d9a165f4
x-ms-traffictypediagnostic: BY5PR12MB4083:EE_
x-microsoft-antispam-prvs: <BY5PR12MB40832E17218DBFFC8FAFBB61F8579@BY5PR12MB4083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAzaZAGmAqWgfZlQH8BidOsjl253LEW9F2Di4+ZKpDbx2CwWsj+Cx64oFL4c9EWgj7fL4kDkUxDcr4Si63SK3F4NyLD3Ku/2z26WmKY320pLNsge0UttcEx81TXR+Zg4bYE+ynwYYVt+tnyV/lD3iXQthy3FvTk59rEGRN4ZEE9CqjEGLW1GfeQUZjm+Lc++HfN+57czmBhdhX0GcfmGwgEb9ejT44I1O+aV9qjwv2lIz0YD1mO5InqYPZ9pQh627O4VwezYW4Mtu+EhOZErRh9LaSVyhJ+WORH5czlZcQmyvO7zUjp+X1qrP2remMFmfoDW24XzaRA1UZdJNZJ6IQlKczDvIBcsdVXbiS6M45i3oZrel82b8O+VTsY0WeJWpPbuPD4jaLt+QjrodbN9rhy4NPTuYGqjPBk/yev3nBl5S4gnqBZjMw8qFftCbf22HskO5bg9DyeaHQx8dHu95yGC/vUxiCOXynKz1tH7wiIebxwm3inss9AQzNIN59X5bMV/K26PtNd3bR/5gEixPFYLYUU4vZEafZOHasw4df7YYmIg8NmJEUQ0EA7ZVl2xIyYFYfSccbYT3jTKASSLmw50NAS1YiKaAIO1Vt2VjHBf39vNfDJFNeQ55OSYHQDRaOzaGHd+LsNlskqaCD54vxClxhHSnJw5z0WpMzMWEKAJHZ12EOwCw1W7V/Pfz4O/068SvccIi1ZMpskbt2s5SQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(33656002)(186003)(26005)(9686003)(54906003)(7696005)(38070700005)(76116006)(55016003)(53546011)(6506007)(66476007)(66556008)(8676002)(64756008)(66946007)(52536014)(110136005)(4326008)(71200400001)(86362001)(8936002)(66446008)(508600001)(316002)(122000001)(5660300002)(2906002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUYxQWViYWR4Z3poN004VEZMMnE2U2JLaFVMZnJ3MHhHQXNNalV3bUYzOGsx?=
 =?utf-8?B?SkN6MU9YQ2RLYWlxSHkyZGVlWmZOcjhBQjEzYWt1M01zWTRORHp4N3lHYTZI?=
 =?utf-8?B?RjA0cS9MT2p3bndUS0ZjMU9JKy9YY09wdWpZSkEzbEZtWGt6dlJyR0lJWG93?=
 =?utf-8?B?bkE4c0ljK1RUMFU5dVpzRXVvQjFMR2tXdklNV25RVDRHbGdseVhLRGQ1WnBJ?=
 =?utf-8?B?MDJNbUZzNDhiMWlPM0NJVE8yL2VScWJBRmg4VStSdHNMNzVGMlJEUFBya1Jp?=
 =?utf-8?B?djdlT3oxYi9EUzRhcVJmUjNna1o3RE92NUErRkZ1S3ZEZHh1aEZ1dlhwRU5R?=
 =?utf-8?B?Z1NYN2tGelZYamVwN0RLMGMxcXFDU2dlUHdUY0lLTnRRTi9SbFoxd3dLWlZZ?=
 =?utf-8?B?QmltTmkvSU8yMXlYSHl3VTdtZ1FjUTZIcDVTTFhxSGhyS2M5dFhHYUJhVDlm?=
 =?utf-8?B?NG83QnA0L1ZVWDZTa3AxTGRMekdVZXRCRUZZNEFoQTBxTDMzajhmdjRlUTlW?=
 =?utf-8?B?dGdRVnVrRU00Ni82V25CV3VlanNDM3JUV3kzYjljNERpNHV0T1RmZDhOMkpX?=
 =?utf-8?B?cUQ2WkVXZVlsQUVEbVVRc0M2NnZxSEN4TzhJRUJEdmRRSWdsWXdwTG43Q3ls?=
 =?utf-8?B?SndDa0g5MFVrT0ExV0x4eDZ4WTVwaEY0Uk05MDhLRmtPa3ZROWI3UllIRVRL?=
 =?utf-8?B?eWxIUDIyRWhrQTdIMU56amhpWnp5TzFpN0x5Y1drWDNHRFFGN3gyOS9FaS9R?=
 =?utf-8?B?V3hSM1kxOW1DOHdCTlIzVFNsZTB2SVNPTUZodlhSZXpVWW5YZ0xTWkh0bENy?=
 =?utf-8?B?L29OTndyc2ROdHdDdkNlZmp4SEpwZGVES25wOFpFMFIzaDFIV2xmLzhuNktT?=
 =?utf-8?B?VUpCM1Y5VVBBOXY0Q0J1MFRmb0FhbjByWjVuTHhZSVdEMU1YMmJiZnhmT2Jr?=
 =?utf-8?B?NmJSR1JXSTVkRE1oUXM0R242TDh4S1NHdDh0MXppTVJmUDBnRWYxZGVaS0tl?=
 =?utf-8?B?N3VnVkZYTW9sOEFoeU9FcWtuZ2xqMjVMcjNPTVU3dGhGZW9Oa0I4dU5JME84?=
 =?utf-8?B?c0hhM1lqbDBDZHJoVlhiYnV6T2U5ZmlyenFOQnpkTmJxWDYzVmJFNGZlN3ZW?=
 =?utf-8?B?SzUvTSt4UWxaYS9PN05EbTh1b3dxSHhQSUhRVXRpeW1pTVJGci8vWEFCc2hE?=
 =?utf-8?B?Z3NhRjFZeUU2bmFDYmQvNnd6YzFWY042blBFWVBjazZ1anNveENRTlRROWVp?=
 =?utf-8?B?RFF1a0tRaXhqSEpwUkQrVGFkOFJRK2IvZ01uZUJPNmxOQVY4U1dXajF5ZFlC?=
 =?utf-8?B?RTFnOGI3SmdTSitSaXNpRSt1S2Z0MTVyQk9QbzVPNStEd3V1eitUT0M2aVdU?=
 =?utf-8?B?WDFSdkxoZTJOWU5ac1h1bFQvd0pPREphT2kvbTFhbGhVdWtrWXVxdmRRVnJ6?=
 =?utf-8?B?QW5nQmVjSGpLeTdjc0tEZ1dVQ3h2NXFTUEYxUHp6OGRlelBSOUk2Rk84RjhS?=
 =?utf-8?B?M0d5Ung2ZzdBNDRZUTlxc0xKQmlNYUpaRXd0WHhBNHNXaHFOenU4aVJWNVpD?=
 =?utf-8?B?OTY3VjljM3psdmFBVVQwOE9HZ1Q1QktzOE9DQ0NUamxHVEZ1RDJEUEo5QnNp?=
 =?utf-8?B?aHVwc3lPTHhOVHBMeUxZNDhuaGVzUVljSmJldEI0dFBNTmducU15R05uM3ly?=
 =?utf-8?B?VndaQ2plQkZFSS9Vd3BnOHB2ZzZsNW53bS8rV1MvUXdxZXljb3JlTjNud3Nz?=
 =?utf-8?B?eWVQQ0V6NXJ4aHU3RlBuT1grYW1aNk9yTmlxTlZEakJaZjdwREM0enNxTk90?=
 =?utf-8?B?MzRETFZNWnZOeEJJT0lYN01FRmM0eWlaaDEvbk9MT29UcGk1VllNZi9LU3ZP?=
 =?utf-8?B?Q1FSNXJ2ekxFaVBHUVZack5Vd3V6SnZ4a3hNcmF3cEwvU1p5T1hzZ2RaL01L?=
 =?utf-8?B?TGd1aHI3STdWbU1QbVhieUxyMG5KRTZqQUZ1QWxsVmc1UzMrOFpqYkE2MG03?=
 =?utf-8?B?QkEzT0FlVkYxVExhVVpKNnRRMzFJWUw5eTZ3QUxqblkwZWhiU0k3Q3VmU2hm?=
 =?utf-8?B?bHd5bFowSzVJdFRUTHMxT20vT0ZxUG1CbWJNVmdJZFZwOXlKc1NNVG1qeDc5?=
 =?utf-8?B?NERyYW5sZitkUlA2TEtCL20wa3FkWEp1RWdTbTdZajBESk83cFBYNUJiNzNR?=
 =?utf-8?Q?IyMlN1/9KaV10l2/F/qgKU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad00c79-0f2a-4ab4-8dcf-08d9d9a165f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 10:09:06.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSYFuAWYF1XPSrAwx6jGqmeKL+pdm+7TkWc/ev+wJqhjiv/lD23id3AwQRVMs2eIN8M43+u28CUDS7S/WipYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNl
bnQ6IE1vbmRheSwgSmFudWFyeSAxNywgMjAyMiAzOjMzIFBNDQpUbzogU29tYWxhcHVyYW0sIEFt
YXJhbmF0aCA8QW1hcmFuYXRoLlNvbWFsYXB1cmFtQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IFNoYXJtYSwgU2hhc2hhbmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGFkZCBBTURHUFVSRVNFVCB1ZXZlbnQg
b24gQU1EIEdQVSByZXNldA0KDQpBbSAxNy4wMS4yMiB1bSAxMTowMSBzY2hyaWViIFNvbWFsYXB1
cmFtLCBBbWFyYW5hdGg6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+DQo+DQo+DQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxNywgMjAyMiAx
Mjo1NyBQTQ0KPiBUbzogU29tYWxhcHVyYW0sIEFtYXJhbmF0aCA8QW1hcmFuYXRoLlNvbWFsYXB1
cmFtQGFtZC5jb20+OyANCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFNoYXJtYSwgU2hh
c2hhbmsgDQo+IDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAyLzJdIGRybS9hbWRncHU6IGFkZCBBTURHUFVSRVNFVCB1ZXZlbnQgb24gQU1EIEdQVSANCj4g
cmVzZXQNCj4NCj4gQW0gMTcuMDEuMjIgdW0gMDc6MzMgc2NocmllYiBTb21hbGFwdXJhbSBBbWFy
YW5hdGg6DQo+PiBBTURHUFVSRVNFVCB1ZXZlbnQgYWRkZWQgdG8gbm90aWZ5IHVzZXJzcGFjZSwg
Y29sbGVjdCBkdW1wX3N0YWNrIGFuZCANCj4+IHRyYWNlDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
U29tYWxhcHVyYW0gQW1hcmFuYXRoIDxBbWFyYW5hdGguU29tYWxhcHVyYW1AYW1kLmNvbT4NCj4+
IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyB8IDQ1ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bnYuYyANCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBpbmRleCAyZWMxZmZi
MzZiMWYuLmI3MzE0N2FlNDFmYg0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9udi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5j
DQo+PiBAQCAtNTI5LDEwICs1MjksNTUgQEAgbnZfYXNpY19yZXNldF9tZXRob2Qoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpDQo+PiAgICAJfQ0KPj4gICAgfQ0KPj4gICAgDQo+PiArLyoqDQo+
PiArICogZHJtX3N5c2ZzX3Jlc2V0X2V2ZW50IC0gZ2VuZXJhdGUgYSBEUk0gdWV2ZW50DQo+PiAr
ICogQGRldjogRFJNIGRldmljZQ0KPj4gKyAqDQo+PiArICogU2VuZCBhIHVldmVudCBmb3IgdGhl
IERSTSBkZXZpY2Ugc3BlY2lmaWVkIGJ5IEBkZXYuICBDdXJyZW50bHkgd2UgDQo+PiArb25seQ0K
Pj4gKyAqIHNldCBBTURHUFVSRVNFVD0xIGluIHRoZSB1ZXZlbnQgZW52aXJvbm1lbnQsIGJ1dCB0
aGlzIGNvdWxkIGJlIA0KPj4gK2V4cGFuZGVkIHRvDQo+PiArICogZGVhbCB3aXRoIG90aGVyIHR5
cGVzIG9mIGV2ZW50cy4NCj4+ICsgKg0KPj4gKyAqIEFueSBuZXcgdWFwaSBzaG91bGQgYmUgdXNp
bmcgdGhlDQo+PiArZHJtX3N5c2ZzX2Nvbm5lY3Rvcl9zdGF0dXNfZXZlbnQoKQ0KPj4gKyAqIGZv
ciB1ZXZlbnRzIG9uIGNvbm5lY3RvciBzdGF0dXMgY2hhbmdlLg0KPj4gKyAqLw0KPj4gK3ZvaWQg
ZHJtX3N5c2ZzX3Jlc2V0X2V2ZW50KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpDQo+IFRoaXMgc2hv
dWxkIHByb2JhYmx5IGdvIGRpcmVjdGx5IGludG8gdGhlIERSTSBzdWJzeXN0ZW0uDQo+DQo+PiAr
ew0KPj4gKwljaGFyICpldmVudF9zdHJpbmcgPSAiQU1ER1BVUkVTRVQ9MSI7DQo+PiArCWNoYXIg
KmVudnBbMl0gPSB7IGV2ZW50X3N0cmluZywgTlVMTCB9Ow0KPj4gKw0KPj4gKwlrb2JqZWN0X3Vl
dmVudF9lbnYoJmRldi0+cHJpbWFyeS0+a2Rldi0+a29iaiwgS09CSl9DSEFOR0UsIGVudnApOw0K
PiBBcyBJIHNhaWQgdGhpcyBhcHByb2FjaCBpcyBhIGNsZWFyIE5BSy4gV2UgY2FuJ3QgYWxsb2Nh
dGUgYW55IG1lbW9yeSB3aGVuIHdlIGRvIGEgcmVzZXQuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gQ2FuIEkgZG8gc29tZXRoaW5nIGxpa2UgdGhpczoNCj4NCj4gdm9pZCBkcm1f
c3lzZnNfcmVzZXRfZXZlbnQoc3RydWN0IGRybV9kZXZpY2UgKmRldikNCj4gICB7DQo+IC0gICAg
ICAgY2hhciAqZXZlbnRfc3RyaW5nID0gIkFNREdQVVJFU0VUPTEiOw0KPiAtICAgICAgIGNoYXIg
KmVudnBbMl0gPSB7IGV2ZW50X3N0cmluZywgTlVMTCB9Ow0KPiArICAgICAgIGNoYXIgKiplbnZw
Ow0KPiArDQo+ICsgICAgICAgZW52cCA9IGtjYWxsb2MoMixzaXplb2YoY2hhciAqKSwgR0ZQX0FU
T01JQyk7DQo+ICsgICAgICAgZW52cFswXSA9IGtjYWxsb2MoMzAsIHNpemVvZihjaGFyKSwgR0ZQ
X0FUT01JQyk7DQo+ICsgICAgICAgZW52cFsxXSA9IGtjYWxsb2MoMzAsIHNpemVvZihjaGFyKSwg
R0ZQX0FUT01JQyk7DQoNCk5vLCBub3QgcmVhbGx5LiBrb2JqZWN0X3VldmVudF9lbnYoKSB3aWxs
IHN0aWxsIGFsbG9jYXRlIG1lbW9yeSB3aXRob3V0IEdGUF9BVE9NSUMuDQoNCkkgdGhpbmsgdGhl
IHdob2xlIGFwcHJvYWNoIG9mIHVzaW5nIHVkZXYgd29uJ3Qgd29yayBmb3IgdGhpcy4NCg0KUmVn
YXJkcywNCkNocmlzdGlhbi4NCg0KSSBoYXZlIHRlc3RlZCBpdCB3aXRoIHNhbXBsZSBhcHBsaWNh
dGlvbnM6IA0KR3B1IHJlc2V0Og0Kc3VkbyBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1k
Z3B1X2dwdV9yZWNvdmVyDQoNCkFuZCBJIG5ldmVyIG1pc3NlZCB0aGUgQU1ER1BVUkVTRVQ9MSBl
dmVudCBpbiB1c2VyIHNwYWNlLCANCmV2ZW4gd2l0aCBjb250aW51ZXMgcmVzZXRzIHdpdGggc3Vk
byBjYXQgL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvYW1kZ3B1X2dwdV9yZWNvdmVyIC4NCg0KUmVn
YXJkcywNClMuQW1hcm5hdGgNCj4gKw0KPiArICAgICAgIHN0cmNweShlbnZwWzBdLCAiQU1ER1BV
UkVTRVQ9MSIpOw0KPiArICAgICAgIHN0cmNweShlbnZwWzFdLCAiIik7DQo+ICsNCj4NCj4gICAg
ICAgICAga29iamVjdF91ZXZlbnRfZW52KCZkZXYtPnByaW1hcnktPmtkZXYtPmtvYmosIEtPQkpf
Q0hBTkdFLCANCj4gZW52cCk7DQo+ICsNCj4gKyAgICAgICBrZnJlZShlbnZwWzBdKTsNCj4gKyAg
ICAgICBrZnJlZShlbnZwWzFdKTsNCj4gKyAgICAgICBrZnJlZShlbnZwKTsNCj4gICB9DQo+DQo+
IFJlZ2FyZHMsDQo+IFMuQW1hcm5hdGgNCj4NCj4+ICt9DQo+PiArDQo+PiArdm9pZCBhbWRncHVf
cmVzZXRfZHVtcHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4+ICsJc3RydWN0IGRy
bV9kZXZpY2UgKmRkZXYgPSBhZGV2X3RvX2RybShhZGV2KTsNCj4+ICsJaW50IHIgPSAwLCBpOw0K
Pj4gKw0KPj4gKwkvKiBvcmlnaW5hbCByYXZlbiBkb2Vzbid0IGhhdmUgZnVsbCBhc2ljIHJlc2V0
ICovDQo+PiArCWlmICgoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTikgJiYNCj4+
ICsJCSEoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9JU19SQVZFTjIpKQ0KPj4gKwkJcmV0dXJu
Ow0KPj4gKwlmb3IgKGkgPSAwOyBpIDwgYWRldi0+bnVtX2lwX2Jsb2NrczsgaSsrKSB7DQo+PiAr
CQlpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMudmFsaWQpDQo+PiArCQkJY29udGludWU7
DQo+PiArCQlpZiAoIWFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+cmVzZXRfcmVn
X2R1bXBzKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKwkJciA9IGFkZXYtPmlwX2Jsb2Nrc1tpXS52
ZXJzaW9uLT5mdW5jcy0+cmVzZXRfcmVnX2R1bXBzKGFkZXYpOw0KPj4gKw0KPj4gKwkJaWYgKHIp
DQo+PiArCQkJRFJNX0VSUk9SKCJyZXNldF9yZWdfZHVtcHMgb2YgSVAgYmxvY2sgPCVzPiBmYWls
ZWQgJWRcbiIsDQo+PiArCQkJCQlhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPm5h
bWUsIHIpOw0KPj4gKwl9DQo+PiArDQo+PiArCWRybV9zeXNmc19yZXNldF9ldmVudChkZGV2KTsN
Cj4+ICsJZHVtcF9zdGFjaygpOw0KPj4gK30NCj4+ICsNCj4+ICAgIHN0YXRpYyBpbnQgbnZfYXNp
Y19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgIHsNCj4+ICAgIAlpbnQg
cmV0ID0gMDsNCj4+ICAgIA0KPj4gKwlhbWRncHVfcmVzZXRfZHVtcHMoYWRldik7DQo+PiAgICAJ
c3dpdGNoIChudl9hc2ljX3Jlc2V0X21ldGhvZChhZGV2KSkgew0KPj4gICAgCWNhc2UgQU1EX1JF
U0VUX01FVEhPRF9QQ0k6DQo+PiAgICAJCWRldl9pbmZvKGFkZXYtPmRldiwgIlBDSSByZXNldFxu
Iik7DQo=
