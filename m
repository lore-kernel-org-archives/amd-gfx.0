Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882C810E5D5;
	Thu, 10 Mar 2022 00:32:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7C110E5D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOKqnlfKQGCdIr3/Zf4qUufxfEyvlgftGRHjVxq1vov2RlYYNS6oBOJuES807eWnzQxJFhN7fWrwM1ntUW1MJzockz3FMEWUOHIgULIJaw9o9GFdMR9ZrlQpD1yhG9dgEXFbIw8O9p+jSYPrM2vZcqyZWf23JLoK7WSq+prpLSB5VjKhBLybedJ+SL2ZhTZloxDOuDLMLUxxI1Pzv76LuhuZy39kvLZE2Z6fUM1iTeU+qWt5MHkhtKRwUepfSg1Pu5xbPmkgBmwgkSsZcW31BqjX9XNz7B7FGZLe5mHFNfQL3Pur54URdJcDRfWmDxFVgSJvuVeb5zqmLV4kpZwjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aEZSPteAgU1IoQ6FkUXTmNlVv9q5rva6s4mgYLG2qc=;
 b=GHfsQ5aVKbTyvYBwaJmr3CbQumDqh7+B2ZX+EkyiBbDT8jPKt4CW1y4M9wZkVyQbAsb5Sz6QgQMfbz46wi1tO7FgGnJCesfKkYHwyicWvXA8fDhOrzRLiPQuhjfD8XsLHws462cX8Vyq9c8++C1UPqAE0AGS/91XVy3rqzogn3jsYpt9zTlgbseJavJdeL17+JLCKUw6hh/qREMXmZXGedgul2zfz7ETYaE0tcP7zw1TW2/Lgw81RefxXLYG21tX+iHuCZ2L1+WPlmlJgnIUNEnxuWboMmgywISLs1q9wsje/Swf0iw3FFoNMdYe2l8bErwV6Om3EsaT560yvCwcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aEZSPteAgU1IoQ6FkUXTmNlVv9q5rva6s4mgYLG2qc=;
 b=YfrWGi5E98fggxrKmCOx02DJQ3yHOLWUaQCqkDUqP5J0lxVLs3R56H9tcFg+Yq82O7ZqbiI163/g5/XmyrB9Z/8trUX9fhfZYZMQaRPglBEOFtTCrKtRY4ayzg6o2DhRXhRKJNMX+IsBHlUG1UDBFBEvXhyL0ov0WFBgDDpzs1M=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Thu, 10 Mar
 2022 00:32:19 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:32:19 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Thread-Topic: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Thread-Index: AQHYNANrHGpG0w9Fl0iCwbbHnmYNVqy3riOAgAAFX4CAAA+TgA==
Date: Thu, 10 Mar 2022 00:32:19 +0000
Message-ID: <CH0PR12MB5372CB12428104E240F5FA2DF40B9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220309221645.468184-1-jonathan.kim@amd.com>
 <99d17bed-06e1-45c2-7a70-449f1ae47eb0@amd.com>
 <DM6PR12MB3163413DD1FA0B1BFA460A7E850A9@DM6PR12MB3163.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3163413DD1FA0B1BFA460A7E850A9@DM6PR12MB3163.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-10T00:32:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7cbc8b4e-41b0-4f03-b7d8-fb39176d8b09;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e79f7b-d442-44ae-1203-08da022d6fbf
x-ms-traffictypediagnostic: DM6PR12MB4369:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4369FF838872BD2D21F933FBF40B9@DM6PR12MB4369.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43kp5lV+P/+M7coZ1IlrjpZlLuOAqujBvYUQpKwLbMmbMkiM1LkyOQ4KxvBER47dM4gFU3l2GtorcHo2ikoPQpSMYcAU5/boIfg8SoDAAZ4xBmS2m7/x0BlFwHGpdyKvVuQ9Ylt3li/bWpslsBelKBoS3vhgdEMR0fO8s9lOesz7pYIb2CzBP9yTMEm0UunElvWR+GSfuLCvIAiLZNzm+pMxTFlKxmibgqM6BMfSoHfImgkuBjEVwvJS3/iMS0a72zVuG3JIIwTvbFqKyRmUzPBf81wSW/YU1FSqNPCXK2rubgMRn3dmOirZk2iPkui4xavg9asHosAonujqS6OGvKPCtBE29mHaPlSwNmtmj4dqTn0vRloVh0OuQP3vIWJZDrsq6BWn45hurLNjhQMqiEwdj15vDrcmUW/QkvAr8PvWbNsn5rE4EuU1KhEk6SrXXmywQemtDo34WsH9YcQYERjUOXNXFWaoNVRHw77JHNvZDEuu/T5jFSsfk9NAO7hxj2EDo2+KP15z9er/aafAp8eFJzV9t+VzhLzyJQvMU8zR2GULwIIFV5xwHAUvrrtQOxECHj1fpM/hQ9PHLzLk3r4KRMtmtOaasq4ML1kZk1AsGged7M6EBGToyInzP3kLqDYQl6HYUJp0h94C2hCEKT82h7ioG2H0fpRi5PvVu0GxvtdmCWubJ5DOpyqyKYNGWA05kWAS3+KlLq88OLNM7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(71200400001)(38070700005)(316002)(66476007)(66556008)(66946007)(76116006)(6506007)(64756008)(110136005)(8676002)(52536014)(8936002)(66446008)(2906002)(83380400001)(5660300002)(508600001)(55016003)(86362001)(9686003)(7696005)(53546011)(33656002)(38100700002)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VytpdmNnUTlCZXFYK3oyL3YrY1UrQnRNKzZVMG5vbTlKRXFoSXdWbWRydDA3?=
 =?utf-8?B?TzdoVWF1aTlBOGdEZS9pcm1UMzN5UDlYL2VyNklZMkkxalA1dzdFdGEzNllF?=
 =?utf-8?B?RjE3VzZhYVFoOGgwL0g2bE92WlI5SDE1R1dlamlObGdxSGt4ZzlXaHhLQmxV?=
 =?utf-8?B?bjFjMVYrcGZuYnk0Zy9mUzhEN1FSeVUzRGlNUFpJMEQ1VUdzR0JFTWRmQ0pH?=
 =?utf-8?B?T0cvK2lMUWFleUVQUllhZjhhMEQ4M1ZWWjdibWRWRDdGUGNNOTRTRjBsNzZR?=
 =?utf-8?B?WHREWUc0bWVrR0p5UjRHN3VXOEJBL1ZGZWR6clJZRTFNVnhQQVRLNkhKVFN6?=
 =?utf-8?B?cEJ5VGRqY25FeVhtR0V3cnZIcjRrQzRSN2xvQ0xkRWp5TURtZEIvTHJrTVh1?=
 =?utf-8?B?RCt6OHRvVDVqZEpGNjBYS3NHelB5V0lLWk5vWHlqZWltZVpiaUxTekZIZjNB?=
 =?utf-8?B?bkk0VFU3dUlSaFRYSERYVTFvQWVydEFQMHVpRVVhNTZ6N3d6cVV2R2Erd1ND?=
 =?utf-8?B?ejdKWDU0R3ljZXUxQlNjMTdGOG8rUXI4WE5ZMTJwbmtZc2FHTU9OMnlIZHMw?=
 =?utf-8?B?TnVYazl2WDVHeWxtYytOVHBxMnJXU2FoMVNGazBYYVVpa3c5aWdLRUhuamIv?=
 =?utf-8?B?UDFNQkJ3MHFkWlVtZWRDOTlBTmkrRmdQdWd6dDdoVlV2cU5jeWlyRU81U3Qz?=
 =?utf-8?B?VlFiS010UXV1NEtyRnBJRTFYQW45YmhiSW1QaWR6anRjTGhIRkhDckN3bkVi?=
 =?utf-8?B?UmlSTE8vV3gxRXF5cWt4UDkydVZNMkVxS2t0K2lGTDlFV0lHbkJhcnV0Snd0?=
 =?utf-8?B?ZkxYOEFTSzR1am44cjJneEg5QjVHeFNrOWlPSHhlMXlmdi9lUXh3bUxQdkg4?=
 =?utf-8?B?bEVRUlpDN1AyTWdrVEFOK3AwT2luTWhmRm9aNTNDVlBDcFp2MEtOVE9HTXpx?=
 =?utf-8?B?U1hLMHlZNnVSdVcySlRxd3FNZDJ0ekg1ZmpxbXNxaFpxTUwwRDR1NzV6OC9y?=
 =?utf-8?B?Z05MRWppeVh2dFFpd0ovY1M5Tk1sY2lzdGhYc2dRb0VHRnBmd09MK25IcnRs?=
 =?utf-8?B?aDlKNEczOEhlMXJWY2pqaFUwUnMyN2xvOUJMdWN1TndlTHA1cU1MaFJGS281?=
 =?utf-8?B?SlZtbStiMzYwNTZpVTUwTGs5VnNCcTBWQnVRdUdqblE1RUdUZVVMK1BZY2dy?=
 =?utf-8?B?UE1UbXZOdlpPUFlvTnNoVUxnZi84Zis1QlV6RlZzeWFCdHk1TDlzaEluajhF?=
 =?utf-8?B?eXgyVXN3bG4yT3d4SWNJdEhTOGNQbEs2NGtrUnNhWnBHSmVoUnFyTE5xQ1M4?=
 =?utf-8?B?Y3poZERJb0ZsVmFCTHd2aW5tM3M5SzJYL0ZGN0xFd0tjYlNtc050MGJOaWp6?=
 =?utf-8?B?Wld0QlpRNXJBM2dhRkN3b0ZIVlQwWWc2SDNsQ1d6SWpmdy9oWUtFN0Zzb29a?=
 =?utf-8?B?T2xlVHFKT1E5Y2xXUkNuQnhVYzZ2VS82K01SSXRRaXhjK1BGdEJidlRqU0Nu?=
 =?utf-8?B?cmNXNnU0bFM4WDhWeVNUeURCOWNsQkRrMEdBaWlhZFlwZENuZzA2Y2xYWEdh?=
 =?utf-8?B?dktJdko5aHc5d3pJd2d2Ym9PWEdoN1ppK3kzL250cE84MW5RTHFJWUNaUjZ4?=
 =?utf-8?B?YkFUaDg1SXRMZUduRkhKcnluK21SNVJuSCtkT0RYeGFJbEdMVkE2Q2NYYy9n?=
 =?utf-8?B?emhyYUh1RW9SV1B6ZWxIaXV2YWk0RnJ5dnJPeWRidTBQVmpET1hJWUUrc2Nw?=
 =?utf-8?B?SGFmSmN2SDZKazZjb0hGZWdZQ3cyRTBScld2TlZTODVoMVBWMklpNnUwL0Fv?=
 =?utf-8?B?RU1sbXJydWJuVUE2TjhmT1FPR3RnekNIaFJUVllEZ2hGMDZFVnJKY1BxSC96?=
 =?utf-8?B?YWZIdW16Qm9razQ4MHRIRUMwYWF6TngxWnJ6UFo2U0NlanQwSWZhLzdkZHZm?=
 =?utf-8?B?RVY5TlRZeVpabm81a1h0cEUyRGZhU2tXSysybXRIRGVYSU9tNk44YVMzVHpR?=
 =?utf-8?B?b3lEU1dKdm94RUdCVDNtZDlMb3NHbE53c2h3NC9WSERlU0pSNXJYVkEzUjlk?=
 =?utf-8?B?dzNhR0RJNXlVVWEwV2oyaDRkclZBS3FYVVlUWmZFU2pOekJPMWM0RVliN3Nt?=
 =?utf-8?B?UEpHTVFkbm5OWkJYS21uQkhZSlJZYzhTc3FjRC9ERDE3SHFSR2FHbVZKZHR2?=
 =?utf-8?Q?AMev4jV9Pi3GCNTnfWuptzo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e79f7b-d442-44ae-1203-08da022d6fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 00:32:19.7142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5qna5xrrzAPiLhQxnwnoYau9Nce0XJE/1bg9VWF5qiqIVTJ1yYiex3iePJ4schbVUaAofZ1x3btQ0Xe/4GPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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

W1B1YmxpY10NCg0KWWVzLCAgd2UgIG5lZWQgdGhlIGNvcnJlY3Qgc2V0dGluZyAgaW4gYm90aCBi
YXJlLW1ldGFsIGFuZCBzcmlvdiB0byBwb3B1bGF0ZSB0aGUgY29ycmVjdCB4Z21pICBsaW5rIGlu
Zm8uICBNb3ZlIHRoZSBzZXR0aW5nIHRvIGEgY29tbW9uIHBsYWNlIHRoYXQgbm90IGJlIGFmZmVj
dCBieSBTUklPViBvciBub3QgbWFrZSBzZW5zZSB0byBtZS4gIA0KDQpUaGUgY2hhbmdlIGlzIHJl
dmlld2VkIGJ5IDogU2hhb3l1bi5saXUgPFNoYW95dW4ubGl1QGFtZC5jb20+DQoNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBh
bWQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggOSwgMjAyMiA2OjMxIFBNDQpUbzogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQpTdWJq
ZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kZ3B1OiBmaXggYWxkZWJhcmFuIHhnbWkgdG9wb2xvZ3kg
Zm9yIHZmDQoNCltQdWJsaWNdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBNYXJj
aCA5LCAyMDIyIDY6MTIgUE0NCj4gVG86IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQu
Y29tPjsgDQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBMaXUsIFNoYW95
dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IGZpeCBhbGRlYmFyYW4geGdtaSB0b3BvbG9neSBmb3IgdmYNCj4NCj4gT24gMjAyMi0wMy0w
OSAxNzoxNiwgSm9uYXRoYW4gS2ltIHdyb3RlOg0KPiA+IFZGcyBtdXN0IGFsc28gZGlzdGluZ3Vp
c2ggd2hldGhlciBvciBub3QgdGhlIFRBIHN1cHBvcnRzIGZ1bGwgZHVwbGV4IA0KPiA+IG9yIGhh
bGYgZHVwbGV4IGxpbmsgcmVjb3JkcyBpbiBvcmRlciB0byByZXBvcnQgdGhlIGNvcnJlY3QgeEdN
SSB0b3BvbG9neS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRo
YW4ua2ltQGFtZC5jb20+DQo+IEkgdGhpbmsgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuIFlv
dXIgY29uZGl0aW9uIGZvciBzZXR0aW5nIA0KPiBzdXBwb3J0c19leHRlbmRlZF9kYXRhIGlzIGV4
YWN0bHkgdGhlIHNhbWUsIGJ1dCB5b3UncmUgaW5pdGlhbGl6aW5nIGl0IA0KPiBpbiBhIGRpZmZl
cmVudCBmdW5jdGlvbi4gQ2FuIHlvdSBleHBsYWluIGhvdyB0aGF0IGNoYW5nZSByZWxhdGVzIHRv
IFNSSU9WPw0KDQpJIHByb2JhYmx5IHNob3VsZCBoYXZlIGluY2x1ZGVkIG1vcmUgY29udGV4dCB3
aGVuIHNlbmRpbmcgdGhpcyBvdXQuDQpUaGUgcHJvcG9zZWQgc3VwcG9ydCBhc3NpZ25tZW50IGhh
cHBlbnMgYWZ0ZXIgdGhpczoNCg0KICAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0K
ICAgICAgICAgICAgICAgIHJldCA9IHBzcF9pbml0X3NyaW92X21pY3JvY29kZShwc3ApOw0KICAg
ICAgICBlbHNlDQogICAgICAgICAgICAgICAgcmV0ID0gcHNwX2luaXRfbWljcm9jb2RlKHBzcCk7
DQogICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAgICAgICBEUk1fRVJST1IoIkZhaWxlZCB0
byBsb2FkIHBzcCBmaXJtd2FyZSFcbiIpOw0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQog
ICAgICAgIH0NCg0KYW5kIHBzcF9pbml0X3NyaW92X21pY3JvZGUgZG9lc24ndCBzZXQgc2VjdXJl
IE9TIG1pY3JvIGNvZGUgaW5mbyAodGhpcyBpcyB3aGVyZSB0aGUgc3VwcG9ydCBhc3NpZ25tZW50
IGN1cnJlbnRseSBpcykuDQoNClRoYW5rcywNCg0KSm9uDQoNCj4NCj4gVGhhbmtzLA0KPiAgICBG
ZWxpeA0KPg0KPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jIHwgNiArKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMNCj4gPiBpbmRleCAzY2UxZDM4YTc4MjIuLmE2YWNlYzFhNjE1NSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiBAQCAt
MzEwLDYgKzMxMCwxMCBAQCBzdGF0aWMgaW50IHBzcF9zd19pbml0KHZvaWQgKmhhbmRsZSkNCj4g
PiAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgYWRldi0+
cHNwLnhnbWlfY29udGV4dC5zdXBwb3J0c19leHRlbmRlZF9kYXRhID0NCj4gPiArICAgICAgICAg
ICAhYWRldi0+Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSAmJg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgYWRldi0+aXBfdmVyc2lvbnNbTVAwX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMTMsDQo+
IDAsIDIpOw0KPiA+ICsNCj4gPiAgICAgbWVtc2V0KCZib290X2NmZ19lbnRyeSwgMCwgc2l6ZW9m
KGJvb3RfY2ZnX2VudHJ5KSk7DQo+ID4gICAgIGlmIChwc3BfZ2V0X3J1bnRpbWVfZGJfZW50cnko
YWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFNQX1JVTlRJTUVfRU5UUllf
VFlQRV9CT09UX0NPTkZJRywNCj4gPiBAQCAtMzAwOCw3ICszMDEyLDYgQEAgc3RhdGljIGludCBw
c3BfaW5pdF9zb3NfYmFzZV9mdyhzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAg
ICAgICAgICAgICBhZGV2LT5wc3Auc29zLnNpemVfYnl0ZXMgPSBsZTMyX3RvX2NwdShzb3NfaGRy
LSANCj4gPnNvcy5zaXplX2J5dGVzKTsNCj4gPiAgICAgICAgICAgICBhZGV2LT5wc3Auc29zLnN0
YXJ0X2FkZHIgPSB1Y29kZV9hcnJheV9zdGFydF9hZGRyICsNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbGUzMl90b19jcHUoc29zX2hkci0+c29zLm9mZnNldF9ieXRlcyk7DQo+ID4g
LSAgICAgICAgICAgYWRldi0+cHNwLnhnbWlfY29udGV4dC5zdXBwb3J0c19leHRlbmRlZF9kYXRh
ID0gZmFsc2U7DQo+ID4gICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgLyogTG9hZCBhbHRl
cm5hdGUgUFNQIFNPUyBGVyAqLw0KPiA+ICAgICAgICAgICAgIHNvc19oZHJfdjFfMyA9IChjb25z
dCBzdHJ1Y3QgcHNwX2Zpcm13YXJlX2hlYWRlcl92MV8zICANCj4gPiopYWRldi0+cHNwLnNvc19m
dy0+ZGF0YTsgQEAgLTMwMjMsNyArMzAyNiw2IEBAIHN0YXRpYyBpbnQNCj4gcHNwX2luaXRfc29z
X2Jhc2VfZncoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgICAgICAgICAgYWRl
di0+cHNwLnNvcy5zaXplX2J5dGVzID0gbGUzMl90b19jcHUoc29zX2hkcl92MV8zLSANCj4gPnNv
c19hdXguc2l6ZV9ieXRlcyk7DQo+ID4gICAgICAgICAgICAgYWRldi0+cHNwLnNvcy5zdGFydF9h
ZGRyID0gdWNvZGVfYXJyYXlfc3RhcnRfYWRkciArDQo+ID4gICAgICAgICAgICAgICAgICAgICBs
ZTMyX3RvX2NwdShzb3NfaGRyX3YxXzMtPnNvc19hdXgub2Zmc2V0X2J5dGVzKTsNCj4gPiAtICAg
ICAgICAgICBhZGV2LT5wc3AueGdtaV9jb250ZXh0LnN1cHBvcnRzX2V4dGVuZGVkX2RhdGEgPSB0
cnVlOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgaWYgKChhZGV2LT5wc3Auc3lzLnNpemVfYnl0
ZXMgPT0gMCkgfHwgKGFkZXYtPnBzcC5zb3Muc2l6ZV9ieXRlcyANCj4gPiA9PQ0KPiA+IDApKSB7
DQo=
