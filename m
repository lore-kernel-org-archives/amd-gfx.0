Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7A9C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 02:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6509B10E81F;
	Thu, 16 Mar 2023 02:15:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF1A10E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 02:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR0AER8dujBJmpTsaJRxQfjXPgAUyB9A05cPJu0JkP6AVnX7EJQMchwuVte7KjWcDWbdzxszvtHjYAtUESnIGm+PGU8l2aLKTfELs3zlAf+nMPJqa91Y2MG44lKECoJsB81R0tX2Kc0OwRGLmfbzqAuZyR/tYurgeyswwwDKSEs/+GILnie7pHpw7GD9JiPIHePbJTSgULDPVECy2+a6hGmWsGLhYr90IE+hqZve+VJePDX2Our0vcQA9ANfJnI8B9C1HtFw1Om9w7xNQKtw5AY7hOyOsn+teU3Y0zeNVJ9y2YWZnZhLUJojxXbQj2ZDpLsIliiVvCu2Xfgvsm5xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwZwVvE9UOjx3RMJdWnWKi1Va0PqqeNfujcDDAMYis4=;
 b=StpxOaArcSoMhnw2weckCfyTUY0eku8CdbNUu7PXhLb9RIUNSWxhcKRb93NbHsq0/zCz132I8gxpwsIN6R8Mzo7w7FmNCey8PLwmAkDIby9ya139djQRSCJ360ZXCiJwiSf4AFoV//yMmbAuEwwOzDgE1G+aZrMZ49s3AbUMnXL8n37mhfyK3Ux/9doSAshTIZBgSDsq+wY20UtiU2epRF5sYy0aRFmVl7um16rUXdZqVhiN6AToD6pTrN/T6uFoZvA1YeYw1vHSss9Ld22HO31aieWpTkZhAh/h2EPi7MR+WaTNLf2nfTy7pb0ICRPRHgz0tN3ui3YlbMGGOxuH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZwVvE9UOjx3RMJdWnWKi1Va0PqqeNfujcDDAMYis4=;
 b=HNDS0Ged+shhQPrJ8S1dXh3hP1I3KYwuRVZx0OjGghAi2rcQEJHLfCY2IEISY4WoF6Q7VLhhhEbLXA0uYLkH8AIQhK+13sJRXUu0+k1GJZt871rpHQKIFn9WB3zJYYulZKqzE85kMMq2pgVfgjaONrQxLLUuSjFFO1EJTZvU19A=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 02:15:46 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2bd0:2a4:c590:40f2%6]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 02:15:46 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: reposition the gpu reset checking for
 reuse
Thread-Topic: [PATCH 1/2] drm/amdgpu: reposition the gpu reset checking for
 reuse
Thread-Index: AQHZVy36jL54WNa28ku6FUZS9kec46776IsAgADCd9A=
Date: Thu, 16 Mar 2023 02:15:45 +0000
Message-ID: <BY5PR12MB3873CC7282574C96556A5AE5F6BC9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230315110341.248166-1-tim.huang@amd.com>
 <CADnq5_N30puWJBtw+_yLxu_Eyifvoti-C8G+exWaLG_8-S5pcQ@mail.gmail.com>
In-Reply-To: <CADnq5_N30puWJBtw+_yLxu_Eyifvoti-C8G+exWaLG_8-S5pcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9baeff9c-e9fd-4f86-89d4-fba86856a073;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-16T02:14:32Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: 9a653155-efbb-45d4-3a44-08db25c45a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vol702hlRKlXFWAKCvYR6XXR63CduQ4w5L75pr1V1lcPZT/t2Kbeuh2tjYwL1ePyfR8YkLNe+JDNzCLEzNemIUQF+C6htK8ZY/+pU0vCTTiW8/ZiEi4P7Fo9O+vfmhnrwyWym0hMjPKpYu1lcE2VZ9J/UJrECBBhsdqGR96lSk/vpiMZT1MsFcvBjrRkIVWknt4IoOY08ZqPNmzxarGGTGx/T3RQmataNiI9EYkuJR/F1Tpr50XO5gQymmfVPHNgXaCWxR0NN5/Bx54ZAlltvpRADn0XhcnKpJEFKsbaRnNwJ8TJy7Uqv+T7E5RwBUqIZvMZ2S7eVc+4wZ7iFXsHCuk7jb27cc7+g170LMB9z/AXvF/02XCdn7p8DRlB3T8U7Duwy5bjZwI4rpylKEiPrruGLW30H0udKnFGtjEbIwQ14kdQvmy3el0J/J0W9UX0xJv8DES8lx9tFXAu+JdVYPeFwnntHR2hd1IWnrHveen8S7akPXV/N7l55ie/EtWg7m5N64FmKh7XJ14IT2BPrpI5F1doaY9tDnJlbSirkWKm/stcDjO5mb0n0Q11N4NFRQrcREHddXGrVYouq/WZSEml0UoOx+uRAY4JvFNO87tG08xHxYdORrJlra2O3O0uZ4iIPGwPmbzg1gv/j53Dehd1uR1cKGMiV6gY0drJ/g5SPNsjbJccUc6KDK0klY8Sxczt2yGoS+LwwAd8NsQg4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(186003)(478600001)(83380400001)(7696005)(66556008)(66476007)(76116006)(66946007)(316002)(66446008)(8676002)(64756008)(54906003)(53546011)(6506007)(71200400001)(9686003)(26005)(4326008)(6916009)(41300700001)(52536014)(8936002)(5660300002)(122000001)(38100700002)(2906002)(55016003)(38070700005)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU85SXJRTmVCOE5OR2xpTjNXMUVVNmlkcFoyK2FLZUZQWGVIN1FYbUx4am9l?=
 =?utf-8?B?akFEWFlHNFBWUE9PeGlSRzlkeUdSVUgwYnVINCs3dGNQeWJTa21YaFZHa1FC?=
 =?utf-8?B?NmpQWnplZGhRYXYra1AxZEJmS2o3MHF2MkRMd3UrWnFTODU4dW9mL2dyVnJq?=
 =?utf-8?B?Sk01SW4xUkFrV1o3UWZ4L3hOTWJzMmRKUCtlZmxmZjE0YjJ2UkNvdHNUdkxL?=
 =?utf-8?B?Rk1Da1N3ajNxUnNTS1V2TkRtNzZPZk9nd29sWkRnbFRqSWxGR2dzWEdOMElI?=
 =?utf-8?B?Njl2bHFJM2F0cmV0cVJ2TzVpUUp4L0FqdGwzQlhHWWdBYUl3N0QvaktNY1Z6?=
 =?utf-8?B?VUtiK1JVandhOWdiTGFySFR6a1A1YXVJVEQxODQzRzl1UHhKNzM2RnVBMUdR?=
 =?utf-8?B?Vklvb0JxSGtTY0dRd1ZZeTJsQUQ2RkdTT2RzUytRTEJCdGphNllPMnRDbS9E?=
 =?utf-8?B?WkRFQUMzdmpGZUoyZjE2OCs3RGNBa3dxRU4zRnZPNnFOb2RvR3ovTncvUEpp?=
 =?utf-8?B?U3lIN3UxMHA0UjhhY3kzRHlZK2tDbFBBT0R5TFhxckNHTkVPalFmdFF5R2wy?=
 =?utf-8?B?QjhlUG1jMU4yZng1UFh3WTU4LzhBUWFKNXVRSC9rdUtSbnAvSnJsc2NUTTlD?=
 =?utf-8?B?aUlMQjkyKzk5Q0xUQ05ubXlBOVoxL2JuVFE4Slh3MjhwcVpocU55dVlSKzNG?=
 =?utf-8?B?MTNxSVRjQ1hQWTg1alFLa3pWS1hJMFFzcytIZE01dFB3bmNMTW1ITDZ5MndO?=
 =?utf-8?B?cGR5cEYzWnpKdzlyRnZHbXR4Um1PL2RsQWtRRDBFOURYcEUzVnU3NWRmQVEx?=
 =?utf-8?B?WXFEZUpLL0luOVZ6OWtHS00yUXBCempmYi9DcGVaemZLV2tBaytkMk0xSnZE?=
 =?utf-8?B?emh3OFljSVR4UDlUTUFTSGQ4OHBTa204ZjVDeTBoZWRtLzFrdDBNVUNucm9J?=
 =?utf-8?B?OHBIQkdPTHJOeURmc0h2RWJpTHVQSEpRbVA3OEUrT0k2V2h6bCtjVFA2QUd2?=
 =?utf-8?B?WklrdU4xNCtaUDJNUC96UENKclo1Rm9ZMVVXTUNrelJIM2p2Q2ZDOUFwSmtV?=
 =?utf-8?B?OFNMSkRranNOSGcwS2tGbG9PeWd5THZrNE0yb1Vsblo1VU4xQkVwYStoNkZL?=
 =?utf-8?B?dUpwOWFaUTF2VkdyRVVKVXgzaWRzQTlCL01PNVc3VW1uZ040eXVSRjNrNXlq?=
 =?utf-8?B?UWJwVmZ3SmJaQjFNejQ3SXczaU1WN3hVNWRzOTljNk1pM2hlMXRhNCtNR083?=
 =?utf-8?B?cExXdDV5bUZRbFI0Z3NKRWMyRndlVEZ1NXNtbEp1ek5Ud2dXUllLTXRXTWFH?=
 =?utf-8?B?VE8xMTdBdEZpdWNkbHZ6a3NIQndyUDc5a2hyVFd6blc1a05Pb1h4Z0NMYTAy?=
 =?utf-8?B?bW9hUHdYUTFJdFp0YVdJT3BuVjFhcmxLWGpEK3NHZk1sZzE3cTFOSmZRalM4?=
 =?utf-8?B?MzUxM05CT0JKN0cralJkdmtaU3RZa0ZGU1VqNUlWeWlFaFQ4eXFMTmZGNTlK?=
 =?utf-8?B?ZWJTUVBzcGlzdWpYQnVteEhWL3BBemd2dVlUamcvQmNDb2pYUEhZblZSK2pE?=
 =?utf-8?B?WDVPSzdOM04xdU1yaFlOa1drREtudlBwOGsyMUVLT1ltSDR5aWVkNVVRd0hl?=
 =?utf-8?B?dWdnQllxSlVvZ3l4UGZuUGtNL1AwVWk2ekhZVnB0NzdPYU4rcEZFSURZOWtl?=
 =?utf-8?B?d3ordW1STGkyZU9NZUtsZ0RuVDN4ektYK3Z0azg0bDlSaUhDcGNCaFNuUGlB?=
 =?utf-8?B?akhTdWxPTDRlZXRTS3RNTzdCS0RpUkF2dXNSa0QzS2NneVl6cFM4M1ErYTNM?=
 =?utf-8?B?M2Z5NStlaU44SENqazRONUtJTXE5NTNPbXdOd1JLQmJuQURVbXZJODNzaFJs?=
 =?utf-8?B?cm54VEJUd2pWczlxRkp5dlpjaTdOLzh1THBpSXRNUkhVM0w2ZXJOcVBoaGhL?=
 =?utf-8?B?dkxaVWFNa3lJZUtUWnEzMGFhRVlSZFNvK2NWaEI2NzF1cVZyNnRkYmV6RjVX?=
 =?utf-8?B?Smducm9Gb0xXeFAwMDdFUWlOcTRhQjgrODZvKzd4Mi90TXJkamZXUG1PMFBL?=
 =?utf-8?B?L0ZkTmxqcExRS292Q3pXaFZCM1R2VTNBK2hFOG45RkFzRWIxZWppV2xDR3Er?=
 =?utf-8?Q?V7jTFc+HyliuLTI8B50HVIvAI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a653155-efbb-45d4-3a44-08db25c45a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 02:15:45.8704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13W7kv4tOwDXXDxuCuHDDMSbTOWnmuLBz11CrZj0i6q5IGAXftQwqUT8tN6YGcZrVp0/PqskUiKa45mPNj3JVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxNSwgMjAy
MyAxMDozNiBQTQ0KVG86IEh1YW5nLCBUaW0gPFRpbS5IdWFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgTGlt
b25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHJlcG9zaXRpb24gdGhlIGdwdSByZXNldCBjaGVja2lu
ZyBmb3IgcmV1c2UNCg0KT24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgNzowNeKAr0FNIFRpbSBIdWFu
ZyA8dGltLmh1YW5nQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBNb3ZlIHRoZSBhbWRncHVfYWNwaV9z
aG91bGRfZ3B1X3Jlc2V0IG91dCBvZiBDT05GSUdfU1VTUEVORCB0byBzaGFyZQ0KPiBpdCB3aXRo
IGhpYmVybmF0ZSBjYXNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaW0gSHVhbmcgPHRpbS5odWFu
Z0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
ICAgICAgfCAgNCArLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3Bp
LmMgfCA0MA0KPiArKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
MjQgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oDQo+IGluZGV4IDVjNjEzMjUwMmYzNS4uNWJkZGMwMzMzMmIzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiBAQCAtMTM5MiwxMCArMTM5Miwx
MiBAQCBpbnQgYW1kZ3B1X2FjcGlfc21hcnRfc2hpZnRfdXBkYXRlKHN0cnVjdA0KPiBkcm1fZGV2
aWNlICpkZXYsIGVudW0gYW1kZ3B1X3NzIHNzX3N0YSAgaW50DQo+IGFtZGdwdV9hY3BpX3BjaWVf
bm90aWZ5X2RldmljZV9yZWFkeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+DQo+ICB2
b2lkIGFtZGdwdV9hY3BpX2dldF9iYWNrbGlnaHRfY2FwcyhzdHJ1Y3QgYW1kZ3B1X2RtX2JhY2ts
aWdodF9jYXBzDQo+ICpjYXBzKTsNCj4gK2Jvb2wgYW1kZ3B1X2FjcGlfc2hvdWxkX2dwdV9yZXNl
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+ICB2b2lkIGFtZGdwdV9hY3BpX2RldGVj
dCh2b2lkKTsNCj4gICNlbHNlDQo+ICBzdGF0aWMgaW5saW5lIGludCBhbWRncHVfYWNwaV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+IHJldHVybiAwOyB9ICBzdGF0aWMgaW5s
aW5lIHZvaWQgYW1kZ3B1X2FjcGlfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldikg
eyB9DQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2FjcGlfc2hvdWxkX2dwdV9yZXNldChz
dHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiArKmFkZXYpIHsgcmV0dXJuIGZhbHNlOyB9DQo+ICBzdGF0
aWMgaW5saW5lIHZvaWQgYW1kZ3B1X2FjcGlfZGV0ZWN0KHZvaWQpIHsgfSAgc3RhdGljIGlubGlu
ZSBib29sDQo+IGFtZGdwdV9hY3BpX2lzX3Bvd2VyX3NoaWZ0X2NvbnRyb2xfc3VwcG9ydGVkKHZv
aWQpIHsgcmV0dXJuIGZhbHNlOyB9DQo+IHN0YXRpYyBpbmxpbmUgaW50IGFtZGdwdV9hY3BpX3Bv
d2VyX3NoaWZ0X2NvbnRyb2woc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIEBAIC0xNDA2
LDExICsxNDA4LDkgQEAgc3RhdGljIGlubGluZSBpbnQNCj4gYW1kZ3B1X2FjcGlfc21hcnRfc2hp
ZnRfdXBkYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQo+DQo+ICAjaWYgZGVmaW5lZChDT05G
SUdfQUNQSSkgJiYgZGVmaW5lZChDT05GSUdfU1VTUEVORCkgIGJvb2wNCj4gYW1kZ3B1X2FjcGlf
aXNfczNfYWN0aXZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsgLWJvb2wNCj4gYW1kZ3B1
X2FjcGlfc2hvdWxkX2dwdV9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7ICBib29s
DQo+IGFtZGdwdV9hY3BpX2lzX3MwaXhfYWN0aXZlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KTsgICNlbHNlICBzdGF0aWMNCj4gaW5saW5lIGJvb2wgYW1kZ3B1X2FjcGlfaXNfczBpeF9hY3Rp
dmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4gcmV0dXJuIGZhbHNlOyB9IC1zdGF0
aWMgaW5saW5lIGJvb2wNCj4gYW1kZ3B1X2FjcGlfc2hvdWxkX2dwdV9yZXNldChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikgeyByZXR1cm4NCj4gZmFsc2U7IH0gIHN0YXRpYyBpbmxpbmUgYm9v
bCBhbWRncHVfYWNwaV9pc19zM19hY3RpdmUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYp
IHsgcmV0dXJuIGZhbHNlOyB9ICAjZW5kaWYNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYWNwaS5jDQo+IGluZGV4IDI1ZTkwMjA3N2NhZi4uMDY1OTQ0YmRlZWU0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gQEAgLTk3
MSw2ICs5NzEsMjggQEAgc3RhdGljIGJvb2wgYW1kZ3B1X2F0Y3NfcGNpX3Byb2JlX2hhbmRsZShz
dHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gIH0NCj4NCj4g
Kw0KPiArLyoqDQo+ICsgKiBhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0DQo+ICsgKg0KPiAr
ICogQGFkZXY6IGFtZGdwdV9kZXZpY2VfcG9pbnRlcg0KPiArICoNCj4gKyAqIHJldHVybnMgdHJ1
ZSBpZiBzaG91bGQgcmVzZXQgR1BVLCBmYWxzZSBpZiBub3QgICovIGJvb2wNCj4gK2FtZGdwdV9h
Y3BpX3Nob3VsZF9ncHVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpIHsNCj4gKyAg
ICAgICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiArDQo+ICsgICAgICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKw0KPiArI2lmIElTX0VOQUJMRUQoQ09O
RklHX1NVU1BFTkQpDQo+ICsgICAgICAgcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlICE9
IFBNX1NVU1BFTkRfVE9fSURMRTsgI2VuZGlmDQo+ICsvKiBDT05GSUdfU1VTUEVORCAqLw0KPiAr
ICAgICAgIHJldHVybiB0cnVlOw0KDQoNClNob3VsZCBwcm9iYWJseSBiZToNCiNpZiBJU19FTkFC
TEVEKENPTkZJR19TVVNQRU5EKQ0KICAgIHJldHVybiBwbV9zdXNwZW5kX3RhcmdldF9zdGF0ZSAh
PSBQTV9TVVNQRU5EX1RPX0lETEU7ICNlbHNlDQogICAgcmV0dXJuIHRydWU7DQojZW5kaWYNCg0K
WWVzLCB3aWxsIGZpeCBpdC4gVGhhbmtzIEFsZXguDQoNCldpdGggdGhhdCBmaXhlZCwgc2VyaWVz
IGlzOg0KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4NCg0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogYW1kZ3B1X2FjcGlfZGV0ZWN0IC0gZGV0ZWN0
IEFDUEkgQVRJRi9BVENTIG1ldGhvZHMNCj4gICAqDQo+IEBAIC0xMDQyLDI0ICsxMDY0LDYgQEAg
Ym9vbCBhbWRncHVfYWNwaV9pc19zM19hY3RpdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+ICAgICAgICAgICAgICAgICAocG1fc3VzcGVuZF90YXJnZXRfc3RhdGUgPT0gUE1fU1VTUEVO
RF9NRU0pOyAgfQ0KPg0KPiAtLyoqDQo+IC0gKiBhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0
DQo+IC0gKg0KPiAtICogQGFkZXY6IGFtZGdwdV9kZXZpY2VfcG9pbnRlcg0KPiAtICoNCj4gLSAq
IHJldHVybnMgdHJ1ZSBpZiBzaG91bGQgcmVzZXQgR1BVLCBmYWxzZSBpZiBub3QNCj4gLSAqLw0K
PiAtYm9vbCBhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KSAtew0KPiAtICAgICAgIGlmIChhZGV2LT5mbGFncyAmIEFNRF9JU19BUFUpDQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0NCj4gLSAgICAgICBpZiAoYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAtDQo+IC0g
ICAgICAgcmV0dXJuIHBtX3N1c3BlbmRfdGFyZ2V0X3N0YXRlICE9IFBNX1NVU1BFTkRfVE9fSURM
RTsNCj4gLX0NCj4gLQ0KPiAgLyoqDQo+ICAgKiBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZQ0K
PiAgICoNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
