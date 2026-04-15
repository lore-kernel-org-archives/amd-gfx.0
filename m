Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5F3ED7B97
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 02:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8156910E034;
	Wed, 15 Apr 2026 02:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dlRYQUmO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E34710E034
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 02:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVuAmouKTSNsaoCWv41ivOZ+mWuOy/0MaFTeoIprc/vRQeLC31MIVXUOU1rocMfvc333Mo++IsYN4idYS99NPemoSgb7IWhiR6K09ZxvjOW5HerUd2FbrqjUCV2HroaNIXXOsNpCq7/HyVv2Hn1AByS8Iqf+HCXF0COBSfJ9TnSaaVZND8oGBZ3T1bWoEjVRp8a7zvgbrjX4q1zdJB0M3gUwjPyrkaD42/KALMtYvUidJR5P1+gWHy+S6EXsE+JRFZt+ObUF1h7g/jj3FBfGi2niQjmU9YNU6HbNmRr8UYccZ5xxyaejEIfRNKiD0AyT14H9p9XU+4GIyS94BCTr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pe4R0OVukTJCx60mRC2aPB46X4fjGMVQ8VOjw9zBVE=;
 b=Y9/IcZBsxBc3XxYyNx4ws2reR377If8thcBIQkrS8Y+W9pWUiiAu6BwUBTCZEfJ3eslv+YCt2TB5AveqI3qmCl4TijfIZEiza+FDeg6psVEzKuRfiAlFaDpjb1DrYImYXNL3NhDt40wwx+dQ6zHA4V+zs7hUtl3vuEU0MLPgZuYtnwFQbmJ/S6b/HGr4PCI1wrlHYet0ZqGj35lSRTI0ywe+6+HNwUevxw28yxcta4CLllWXfPXaxL83fMbh94Bl8SEuT8rI9Pc7jJOzFs/u0nSUBaYvWVJ082vhr7kpwdD1nNIpwDaZe48+kL5UFWknoQ2NVPFkkkgJ5Jay/BNIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pe4R0OVukTJCx60mRC2aPB46X4fjGMVQ8VOjw9zBVE=;
 b=dlRYQUmOXDOXjCAIi8kRq335J99rm7Q0yCBRUjmXN67VuxWeAivq5llyB+Ml95I3wqpVCkp+/v8d5HHvISnBfCKX2htH0m01ncfck15iq2Eqt7iBtrW8obbwRONnAA14EwzfHOQwKlVTV2h8+y/m4/xBnvQq9IW0WbCsxBYscs0=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Wed, 15 Apr
 2026 02:29:40 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9791.032; Wed, 15 Apr 2026
 02:29:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Thread-Topic: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
Thread-Index: AQHcvUqXvu7th9+pq0OAgiSkWBt54rXNaioAgA/b3ACAAK4+cIAAubuAgADLLTA=
Date: Wed, 15 Apr 2026 02:29:40 +0000
Message-ID: <PH7PR12MB6000B3CB3B58749EBEB0D1AAFB222@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260326175140.52753-1-alexander.deucher@amd.com>
 <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
 <CADnq5_N4_0bC-y1FPBq4tP0PpbT8OgDi9Rx3j+m78RTmDoQR-A@mail.gmail.com>
 <PH7PR12MB600024A792B867BB964322D9FB252@PH7PR12MB6000.namprd12.prod.outlook.com>
 <CADnq5_MfEedhypkx-4jvsq_8spk8gCoH-KOkyJf1xO+DZouyVg@mail.gmail.com>
In-Reply-To: <CADnq5_MfEedhypkx-4jvsq_8spk8gCoH-KOkyJf1xO+DZouyVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-15T01:48:03.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|PH8PR12MB6964:EE_
x-ms-office365-filtering-correlation-id: c14cc3cc-8f70-4bd6-7039-08de9a96d8d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003|11006099003;
x-microsoft-antispam-message-info: jmDirxEIFGnCvKKqQf46tPDaUPC36c43qq4VwXl8/roQeNtTIGUW0PdsyssvltT99od/F+D1mvJiyiSMrIOkZ2bl2IoHJGcDd3WTtG+yB+j3b1XX0LFtM6JtazlxSMGQsfJMRQ0tNkJZ8qyZEB/ih9gklM+CMLeOglMDaS0z4OF5UOCpLILnt7g1iZNkQHqLrO1QbursGoE4SKPnwRSWei1TdIdtzXKiNzPHJmquHxW8eF1k33zEFTwKCi27LqDRGgZQyB2jDTE3QQLLdB9nBw4QzvhHdhadDf11GxMVCtn0e/ZtWze0lJMCa+sS3Kj5i0CaGaR+CXPX4DkKkqqK6jRmMs/FGWqqjuJuZBOnxso85X+ZcJ2px9yxKmB1cwurP/pIySBA4vnFXKa7gipKCBhOHvHRF7WquttczVUM43Uqg2VS4tIGpYha6hOAH5bTJilffHZ6qNmeXtVc+eB0b2GLkiRlYPz/4fUP9r832rjeDIzSFtvgJWNI1HUB+NmXBS5iuHGKSglVUpN2EgZi5POhXeH6fF0kXls7GF3+X9NjfAXKQus7O52m/5Dl2gnc7hZo+D+jcDN0FJmQ3rrs04GDll330S35t+YRNt50Yob5ziAgGAQQOb53+8sd3Tl3K6TsFjVEizhaw8w0tghlsAve/Estoxn728piZ5IvB93dXVFAFJ/qZx4Bk5IVoWCB/GMYhfBLG3nCaM17oJYnxpby01mdPd9zPXMEo4K/1dW5YVJu3zX8YHYc4MO/+lkrptpKOMPWVLXBoTXDZAjwTuacEu3lmvlV6d87DV6xCmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003)(11006099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhiSjh5a0t2bmZaNmI2QW1jZnBSWFlUSmJIOW5qREg5eHdmMGJHUFNYTjhz?=
 =?utf-8?B?dEFLZGk5TjgrNE5jSGNBa3Fzd2MxVFdrYlQ3NkE3VnlVQTlFbFJHZGZYdmdR?=
 =?utf-8?B?OHpHLzBsQ2hJa0V1ZFBCRGtOaURjUzJKaFN1RnVwcTA2YWR1bnE0cEk4akpp?=
 =?utf-8?B?dStPci8wUkpIaXJBU254Ymt4cXQ5YzhxZUhzTm90Z08xTWc5Q0FPOVBNWmVr?=
 =?utf-8?B?QjFFUVorWkgxa3UzeEZIU3Nud2l3Ui84aFVwSVBRb0o0WlZrZEhTUGV6bUtM?=
 =?utf-8?B?aXVWOUNQVHMzN2p1eGpRVDBZS1Z3OW1Jdzl5cmFzZzdudEIyTDNWaEszRTBT?=
 =?utf-8?B?TVFiWVBOZ21CbkppRUlwZXloM1c1VkdtWndrV2tieVNWSzBJbU1WME01bFZG?=
 =?utf-8?B?ZTBsMHNtT3VsTVl3WTd3eHJjOXYyQ0xrWWhranU1c0Jla1pxdjN6aVorSCtX?=
 =?utf-8?B?VkdwSUcrTS84US9jSEZpcVFVTGs3SUJSZTZPZnFXdzJ4b0JGcWRDYmI0cTVo?=
 =?utf-8?B?RWlsNHIwOUgvUDdxQW44S2srdjFNeXBzL01nSVd3TE1jTzUvdGpEeVhhL2pP?=
 =?utf-8?B?TFpBVHBabFRuV1l2OTZrZ2xCSVgzWUgycjZhQktOallHanVxc1RqeDRsenIr?=
 =?utf-8?B?WHgrNE1Bd1lNR2VLamlBbVMzWjd4THN6SzV5VTVEL25QcGUzMFROOHh3d2tG?=
 =?utf-8?B?ams1dTBYOVlmQ3ZlTnhXeHJ3NXVWUHRSRHFFbjZYMXhrYWJ3ZXRTbVNDV3p0?=
 =?utf-8?B?a2gwZW4raW5ZMDh3ZkZIY29lZnhYU1JTcndmS3hacmd3RWFxRTloK3ZXMm9l?=
 =?utf-8?B?VEJJSUREWTcyc3Y1SGZYSkFuNVdLdWZRZTlKOUhlQzFjNWpncXhGbk5BVE05?=
 =?utf-8?B?ZnV1Qmh5V2RBQnZZTFYzV0VKMHVWbC9aUXRLNXFQWXRaWEhXUEV6cnVOMmU5?=
 =?utf-8?B?SEpHRHRJUURRakJ6d2l5bmtINU1qaVRmMTdtN2ZCSDRVYnpyQ0xjM25mSmpJ?=
 =?utf-8?B?TU0ydENDMFNqTi9NdFhVRUhKU2I3VUlNanNHYjkvOEFDT1RBb1g1UGdFd0M3?=
 =?utf-8?B?bUxwZWZhSmZKUHJjSDAzTWhZRncxWi9SalRQWFdCMDN0UlY5NFFLdmhRV05J?=
 =?utf-8?B?dUlScG1qOE5SWXNpcnhoWDVVNStYUHF0TElLTWpDUEQ2U3JvZHBTWFVtYm9T?=
 =?utf-8?B?YlhVWlczdHRCTTFKNXpxVEpRaFRuYVhoUlRPb3RtSnY3N1ZSaFkzQXA5enFN?=
 =?utf-8?B?YzRZRkJQK1RtNjBTblVHNk1aQ2pvS09ndEtza0V0SFNQMmZRY2c4MVpLQ3Rt?=
 =?utf-8?B?djBWbnEzamhmVGhLS1dIRGdjQTc1ekFwR0JGLzBoTU9ZTTQ4emhOVHRjTVpv?=
 =?utf-8?B?Y1dkWW1nRFM1OWpoQkY4b2hjNVhrQUhuUlpxYVRxTk9XWTZZMjZYSDBjVlJI?=
 =?utf-8?B?TGtHUVdkMk5YYWxPa3JwdCt2VVBnalpNM0dzRXlTcGpoZWNudWhsTVVLRnpq?=
 =?utf-8?B?UlRUc3RlelZZbE5OVjdwd2I4RVpEUGI2YS9udkdFb21ReUFJNDlLeUkxWENF?=
 =?utf-8?B?dHhXckRlYWtVUVNhV1JkYnh6VDdOT3NOc3B6cDBVOHRLQUlpbmNrbi9Md3Yr?=
 =?utf-8?B?MklJcFYzajIwdkczazZCQ29LQWtyM1RDNnZZN05ReGZ0Q1dSbXQ4b2xrMVZ5?=
 =?utf-8?B?aGpTZDlFMFNqYWtzVGI5dDd6SDEwZVZoWTkrVVFMVXV1WEJjcnhkVG96UUFy?=
 =?utf-8?B?dW9nL3kvU2FOdU9CTFArWmV5RHo0Um9PUXVqK0RTZEhOb0Q0YmsvK1FnMkhF?=
 =?utf-8?B?VHVFTWhKVU01TUJ1U29oOTVhY041S3BRTkcvL1dYNFJ6N0hxNExzb1hQdjd3?=
 =?utf-8?B?K3dZK2VyQ3dqTzRTaTVmQjgxN3Z3L1R5bTBUdUVQWFo4MUtlRlc2R0Q1dW5R?=
 =?utf-8?B?NkhnMTJYK1RiV1NiQm95azlQaTNQV2dhRUpSdnV6SHJxV1dpQ2xNRnNrV2No?=
 =?utf-8?B?eTVJWmFiUitrNVNqcDJXNlVsaWlDT3gxY1UxcGUraGhEWk9kdGw5R29ETXA1?=
 =?utf-8?B?aFFjRGNtUmZxMmRtQ2h3RzM5Rm51Ukdsejlid0hCN0l4NWxsb2lMVnM3QUV2?=
 =?utf-8?B?QlRoQ1RZZlUrVVNINFBaQ2RGNmZMRzFvWWtIdlh3bk9JamtvMjA1ZnlqL2pL?=
 =?utf-8?B?UzhRQUFZeE5uZGZrNVd0Qy8yK1hBbm9aOG5zbEJDNHdIaXluQkxvRnNxTy93?=
 =?utf-8?B?R0tuU3JWSERTMjdZK2RwZnpQckJLUXZMRStrSE52WDhNS2hkQUJPUUY4a242?=
 =?utf-8?Q?jfWVvA7QFVwAq6AtFI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14cc3cc-8f70-4bd6-7039-08de9a96d8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 02:29:40.6739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gpv2SfqHu/3Sg84Mrqik0WSz2/zmsEGKz7wnZPMMM9NzHXxbzqfifEdMdnP8Et3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE0LCAyMDI2IDk6NDEgUE0NCj4gVG86IExpYW5nLCBQcmlr
ZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3NkbWE3LjE6IGFkZCBzdXBwb3J0IGZv
ciBkaXNhYmxlX2txDQo+DQo+IE9uIE1vbiwgQXByIDEzLCAyMDI2IGF0IDEwOjQ04oCvUE0gTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNd
DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAgIFByaWtlDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPiA+IEFsZXggRGV1Y2hlcg0K
PiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTQsIDIwMjYgMTI6MTIgQU0NCj4gPiA+IFRvOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRncHUvc2RtYTcuMTogYWRkIHN1cHBvcnQgZm9yIGRpc2FibGVfa3ENCj4gPiA+DQo+
ID4gPiBQaW5nPw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgQXByIDMsIDIwMjYgYXQgMTA6MDHigK9B
TSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IFBpbmc/DQo+ID4gPiA+DQo+ID4gPiA+IE9uIFRodSwgTWFyIDI2LCAyMDI2IGF0IDI6
MDnigK9QTSBBbGV4IERldWNoZXINCj4gPiA+ID4gPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBsdW1iIGluIHN1cHBvcnQgZm9y
IGRpc2FibGluZyBrZXJuZWwgcXVldWVzIGFuZCBtYWtlIGl0IHRoZQ0KPiA+ID4gPiA+IGRlZmF1
bHQuICBGb3IgdGVzdGluZywga2VybmVsIHF1ZXVlcyBjYW4gYmUgcmUtZW5hYmxlZCBieQ0KPiA+
ID4gPiA+IHNldHRpbmcgYW1kZ3B1LnVzZXJfcXVldWU9MC4gIEtlcm5lbCBxdWV1ZXMgYXJlIHN0
aWxsIGNyZWF0ZWQNCj4gPiA+ID4gPiBmb3IgdXNlIGJ5IHRoZSBrZXJuZWwgZHJpdmVyIGZvciBt
ZW1vcnkgbWFuYWdlbWVudCwgZXRjLiwganVzdA0KPiA+ID4gPiA+IG5vdCB1c2VyIHN1Ym1pc3Np
b25zLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzEuYyB8IDEyICsrKysrKysrKysrKw0KPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjdfMS5j
DQo+ID4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzEuYw0KPiA+
ID4gPiA+IGluZGV4IGYyMGUwZmMzZmM3NDMuLjA2MTkzNGEyZTkzYTMgMTAwNjQ0DQo+ID4gPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92N18xLmMNCj4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y3XzEuYw0KPiA+ID4gPiA+
IEBAIC0xMjY4LDYgKzEyNjgsMTggQEAgc3RhdGljIGludCBzZG1hX3Y3XzFfZWFybHlfaW5pdChz
dHJ1Y3QNCj4gPiA+IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ID4gPiA+ID4gICAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGlwX2Jsb2NrLT5hZGV2Ow0KPiA+ID4gPiA+
ICAgICAgICAgaW50IHI7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArICAgICAgIHN3aXRjaCAoYW1k
Z3B1X3VzZXJfcXVldWUpIHsNCj4gPiA+ID4gPiArICAgICAgIGNhc2UgLTE6DQo+ID4gPiA+ID4g
KyAgICAgICBkZWZhdWx0Og0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBhZGV2LT5zZG1hLm5v
X3VzZXJfc3VibWlzc2lvbiA9IHRydWU7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFkZXYt
PnNkbWEuZGlzYWJsZV91cSA9IHRydWU7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+IFdoYXQncyB0aGUgY2FzZSB3aGljaCByZXF1aXJlcyBkaXNhYmxpbmcgdGhlIFVRIGFu
ZCBkcm9wcGluZyB0aGUgdXNlcnNwYWNlDQo+IHN1Ym1pc3Npb24gdG8gdGhlIHJpbmcgYXQgdGhl
IHNhbWUgdGltZT8gSWYgc28sIHRoZW4gaG93IHRvIHNjaGVkdWxlIHRoZSBqb2IgdG8gdGhlDQo+
IFNETUEgZm9yIHRoaXMgY2FzZT8NCj4NCj4gQWxsIHN1Ym1pc3Npb25zIHdpbGwgZ28gdGhyb3Vn
aCBLRkQgdXNlciBxdWV1ZXMuICBUaGVyZSdzIG5vIG5lZWQgZm9yIHVzZXINCj4gc3VibWlzc2lv
biB2aWEga2VybmVsIHF1ZXVlcy4gIFRoZSBrZXJuZWwgcXVldWVzIGFyZSBzdGlsbCB1c2VkIGJ5
IHRoZSBrZXJuZWwgZHJpdmVyDQo+IGZvciBpbnRlcm5hbCBidWZmZXIgY2xlYXJzLCBtaWdyYXRp
b24uDQpHb3QgaXQuIEJlZm9yZSB1c2VycSBjYW4gYmUgdXNlZCBhcyBhIG1vbm9saXRoaWMgaW1w
bGVtZW50YXRpb24gZm9yIGJvdGggS0dEIGFuZCBLRkQsIHdlIG1heSBuZWVkIGEgZmxhZyB0byBp
ZGVudGlmeSB0aGlzIGNhc2UgYW5kIGtlZXAgdGhlIHVzZXJxIGVuYWJsZW1lbnQgbG9naWMgY29u
c2lzdGVudCB3aXRoIGhvdyB3ZSBjb25maWd1cmUgb3RoZXIgSVAgYmxvY2tzLg0KDQpCdXQgdGhp
cyBzZXR0aW5nIHNob3VsZCBhbHNvIGJlIGZpbmUsIHRoZSBwYXRjaCBpcw0KDQpSZXZpZXdlZC1i
eTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQoNCj4gQWxleA0KPg0KPiA+DQo+
ID4gPiA+ID4gKyAgICAgICBjYXNlIDA6DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGFkZXYt
PnNkbWEubm9fdXNlcl9zdWJtaXNzaW9uID0gZmFsc2U7DQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGFkZXYtPnNkbWEuZGlzYWJsZV91cSA9IHRydWU7DQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiA+ID4gPiA+ICsgICAgICAgfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAg
ICAgICAgIHIgPSBhbWRncHVfc2RtYV9pbml0X21pY3JvY29kZShhZGV2LCAwLCB0cnVlKTsNCj4g
PiA+ID4gPiAgICAgICAgIGlmIChyKSB7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIERSTV9F
UlJPUigiRmFpbGVkIHRvIGluaXQgc2RtYSBmaXJtd2FyZSFcbiIpOw0KPiA+ID4gPiA+IC0tDQo+
ID4gPiA+ID4gMi41My4wDQo+ID4gPiA+ID4NCg==
