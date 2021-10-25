Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A44C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E2960EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90E2960EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BAA6E1B5;
	Mon, 25 Oct 2021 17:59:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6C86E1B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3rWlLd6pLKysSEC4oEY5birWQfNlczIUmsVfe/sq7yqAIyDQy2/m0z9v18cyx6KqZx80CAGmkZqtJcSxEivD/bM4Ys/U8LG1eQWKyHzGcR0L+GKq0unU/rTPP/Ktq9A2uSnR6DkuuTYVdT62QPW8p8tO3JZqM0L2J/BgsV0QvcJfD8/QCI9zxc5L1sP9Easu0xhc3GALxJg5gin6edBaRwjKg9/DLsWgrrx4nsto0gqSiBVeQfrJe+8czNFavt/MRjNgG5pMhMGpfa5HM1DeaXffRd8IQ+Q8b1112/FLkxZPAEbATvdYBkLMeQffpKGoxpZZARIoqK1fnVsv1VSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkaNnRWbet9DPzELJqcT4uhUEVoitFTaL/FwqF7hNVg=;
 b=FgJhiHzoLjY71l0eHUTapBoTc+eoo1uruE5uCYq+Brh3IN2ReSBNMiujTubNr0dKDIK5mqpa8k0clhEMWB6743nZIs6yyhRIsAbZ1+PqX+WiaBdOoCllQSAJ2Kj14DOrTNc6+b1ZjM/FcktZW1arDKm1aGfd36nFNuj2onUymZGADJo6Z/l+dJwRUqwlSPbCCBuElNQevqsNZii4t2juWxH1kXTOkA/AKEzuh2YhhRF3wX6arR9gNko11tZppP9/hIFOSW5RlOM4uzAQ1GDOzuJzm+xLcYjKeJX2QD/caH5Nq1ysK6SFvTv1CRIaIEg+YDLrXWsE7uWGw/X3TRbDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkaNnRWbet9DPzELJqcT4uhUEVoitFTaL/FwqF7hNVg=;
 b=a2DJfFlf9Alxqg84O7Pc0EgLiJLnBlv2wAFV5U8HBATtmujmKZTUhV1ysPa3x9MmLvALIC1ftMDmW65snYiCBN2YNAJ2nqJD6lRL57YgwoAllQOBH6Y8lfzHU4nEbRNLw/6gtD8knRF2SEYmCM/TLKJ6EHDkfwKKoEZqTIMMK8Y=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4764.namprd12.prod.outlook.com (2603:10b6:5:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:59:35 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::40cf:e859:88c4:9b5e%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:59:35 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Topic: [PATCH] drm/amdgpu: Restore information reporting in RAS
Thread-Index: AQHXybm6w0FUBYuh0EeMCA5cnaCIdKvj+IyAgAAHCsA=
Date: Mon, 25 Oct 2021 17:59:35 +0000
Message-ID: <DM6PR12MB33249A26804B84CEE045F2C385839@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20211025160220.51401-1-luben.tuikov@amd.com>
 <879b6aec-1dd0-116b-9822-7fdf5bf568ef@amd.com>
In-Reply-To: <879b6aec-1dd0-116b-9822-7fdf5bf568ef@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-25T17:59:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=77b3e448-4cef-4a9c-8977-ea25de2eb066;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 503719dd-6182-442e-ed2e-08d997e1348e
x-ms-traffictypediagnostic: DM6PR12MB4764:
x-microsoft-antispam-prvs: <DM6PR12MB476445DDCD393B42E8EA8D6285839@DM6PR12MB4764.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cTN7cfMy7cbb4qMIrlZLSDJzOmayvaWn7fydg6pObsYYC6HSByDAgvGCDElNys6FyzuINdlVu8y6KKz0h/6r1RmiPqoAnbm/DTfd4cwbnOF+4CsdTYxKfEQZlo2NovuQ/kI2fDCVUmS8rerXVP8dQ3T00bJI9ZtMFOmqAAy+y9OiGnTmLW62XPh4LPNsK58NMqma+yRiiL7UCgC3yX3P2p5IXGogwldNQfxGxSK+Hmr4fxrp5sYm+17+xQp8dIjMvcc12uO5G+K02PgGG/rzMZ2Z0LKY/kv0uggAjyToS6t6kuYJACAumyQ4HlIGVMz3HY2Y/bvq0UwdUkcPO5xqbWtw4qC8Pa2I34LgT2UqOgDD9amAan/s2Tir2FNBBc75cHgOcXzw+vBh6ebcuZag+q9Rb7eAT1k7a3GmHG68hV8LJ7XuI1VkPIB8VQYurdvj1VnM+0E+QxG9WWWmir6BWkKO9Eu4e3EdUwLL59F1blSZVqsvmQezG4rXfVQWXH4MHMGQneOtuVAnF4StEN86fT+i6LsxMcoyVuMPMBnMBZnQgNYwOEWGP3/nvrlMUHUIAexjtlhZcti5F+Ry9GSf8ggk2CdwOpzYihQt9wkXJBVrc/eQd+jUYg5Fr39zgaiyYEKyYM0r+7Y+/GEzmXrbyD0Ah/Ao/MPWHZNxqCQmmG22fT9QG3AepjXdL8KYhWdd5tOds1O4AKPkbB3InW/IKa+pvmgjjKEZr9LqUVJGSpHH0s+zYrE3r7Jia8cM86OUCh+oIIGU3hR1vVQtfH170GM9lx+p0yWzZafaZhD7rk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(6506007)(53546011)(66556008)(66476007)(316002)(7696005)(2906002)(71200400001)(4326008)(33656002)(55016002)(83380400001)(9686003)(8676002)(110136005)(4001150100001)(38100700002)(66446008)(186003)(8936002)(38070700005)(86362001)(508600001)(5660300002)(966005)(122000001)(52536014)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clhsNXFOdUpyUGpZZXJzRFM3RjNqK1NRb1d6WE9TZlZQdVFvVmJQeWYyU1Bh?=
 =?utf-8?B?cnFlVkI2RWZ6WFRSaE90K0J0SkZqbGRXbnpGNHYrbFJEd1kyYXg2aWNPR1RK?=
 =?utf-8?B?anlEeG1nTnE4OW5vMnNOYS8yQ2pNOHJQQWdzR3pSdE02ajI1SnNDanN6QzZt?=
 =?utf-8?B?VFFYWmw0ZG02WlNFVlJVRUZCNnRGS3JOL0tqNVFTU2xmQk5zcDdycUN6Sk9G?=
 =?utf-8?B?WnFBSTdjTjZUSmZBaDJaUjF2SWdxZEdCVmx0YkZZNGNFcnFhQUh5REZzYjRO?=
 =?utf-8?B?Qjg1VXlJOWhUNDJWSlRlc1dxelp1STJNWTZjNnk5RUlTcnR4MnBuMWtoTko0?=
 =?utf-8?B?TGg1NjlsOVdqZ3Zlc2VQbkt2M1pCR2l1Q1hkVEhxTWtFblJWL0tTak5tVHRK?=
 =?utf-8?B?TTE0WFY4VDFSY0drZHRXMmNtcGZpRWlaSTJNNUQ1ejk3aDdLQnR2ZFhPTVE1?=
 =?utf-8?B?bk9seEJMc1JJbE1Zd1VFcURhMDYwODdiRGhYV0RzMk8vUEFqRGVvRzZoWlZr?=
 =?utf-8?B?Mnpidm56T2Q4TjNnSjAxdGZ6NjN2L09ERWxQZllSL0lRc0hzK1pUT3ZtQk9h?=
 =?utf-8?B?TnJIOXpSektHSUJpSmQ2NVZOd3k2QXF6WkhWWlZJQXpJN1duU2VFQ3ZmMmtM?=
 =?utf-8?B?a24rTjhEcXhJU1M3bVRjTGVZc1psdGxjaDdla1dNaGhtLzFuYUdQaEJvL29w?=
 =?utf-8?B?ZVNxZFAxZmk2MXNSMTltbmRTNjdtSFUvUnNRcnhOREUyenB6WTlWNUFWMlVD?=
 =?utf-8?B?OG5oSDQ1VWduT0VHL1gyM2d5YU51TXRId3QxYUxuSWI4dzhudnFidU51TmF4?=
 =?utf-8?B?VFFKWXdnNHRsdHR0SVdUT1NrUmlrWWk5dE1VaDh6N0tGZm1QMkE0Z1MxV3JP?=
 =?utf-8?B?VDc0bm9FeG5yYUhmc0NtYzlFRVV5SjhFTFJCcXdEcjlzaFY2VUZ6VnV1Z2Z4?=
 =?utf-8?B?QzkxN0N4NTR3clJsa1c1eksyUy8zamhFQkk4dThvY2ljcytoVWgzRnM0VVJ4?=
 =?utf-8?B?SUhiS2NpMWVCdVNSZGV4aExYZFVmSVFIZXF2U2IyckUzVHo3empQV2R3SFNz?=
 =?utf-8?B?MFZiUWFkQVVtTDVLdjh0UGIzajF5T3JIYjcyZHNJa3E0c0pkZzk3UWV2VnJL?=
 =?utf-8?B?ZmJ4VktMVjJVMDh1TWp6aXVuRFpjTkRMaVRUMmhRQ3EvaUhUdnJXTjJvaDVv?=
 =?utf-8?B?YzBkT1dMVmRWQTJvZ2VYN1B4dVpCVVJJTTRBZDlKa1pYUGNIdFc0bUZBV3VD?=
 =?utf-8?B?YTdma0IxQTQ2NmFqd08wdTRnU00zVERPQjFPWU13UlUyKzRwOXVBT2pHc3ZO?=
 =?utf-8?B?OHhidlBmZjBIamlQQ3Q3dS9aUkdlc3J3QjR2RnI3c0hCdlFUU3dEMlR6MzFl?=
 =?utf-8?B?RFFsS2ZKaytaVnE2dlB1RXNsdFJUL1J0SnBFZHl2ZnZtSG1TV2x1TGhJT1R0?=
 =?utf-8?B?YVZoT1FLUkE2T2N4cUE3OG8zVlRLb0xneGwwcXNKQnJNUEhlenJQY3lvUC9M?=
 =?utf-8?B?RGc2UFR1VVpFcUV3a1ovUUVKa3FId1ZXaFRUQjlzcWxMNUdkYU1xNmFpTTh6?=
 =?utf-8?B?YkJ5WTNzd0JrTGNkeXk3bkxzekhmaW1RcC9WMURMV2E4UUFQTWs5SEw5Y3h4?=
 =?utf-8?B?UUpvbnVBeU40SmoyNkxIYlkvb0ZlUzdId3FpdDdMY0ZwdG5HdjAwWU1OTXZa?=
 =?utf-8?B?UDd1K25mTThiU1l6Z0g2aXRXZ2NteXIwT09JS3dvZGRFTDUwVlpZVXNpUnJI?=
 =?utf-8?B?VFNDSzF3eUVRbFkrVEpWV0RGVVFWUlVsWDJpWEV0aXA2Qi9RSVNRdEhtRUVR?=
 =?utf-8?B?NE41TXJEUXEzMW1TZTlZWUQveVg3ZENaMXQyRUd0TVJrSEl6czduU3hFTmd4?=
 =?utf-8?B?TEhad0lJOTFvZTRUaHNLQWpDQko2SE1tbDd5cFJVYzRwTStlYk54Z0FFZjFD?=
 =?utf-8?B?enRWYjlQd3VxYmdmbUxXbnhweWtwV1MwbW85VitiYlNFZ0lnd1N5ZDNHSkl6?=
 =?utf-8?B?NFpWQzFMcEEyUVBUbG02UmpFZ0hrT1FJd2J6dlV2cWhFWmtmTnpXVjJNNy96?=
 =?utf-8?B?MXp6YTJSTkdVMFI2ZHA5dFFTdWIyY3pXb2grcGFBWmJOWG5TUkVMVWtsQlZ4?=
 =?utf-8?B?dWhVOXUwb0llaklhRm5uY0pMeitxRVF5bE5BVlBHUS9PQkRvcXpiOVdydnN0?=
 =?utf-8?B?ZU1ubnJRdE1oTEpJVkhwUnRFOUJzQU5ONkREZjFWWjVadEJCU05WaENuTVh2?=
 =?utf-8?Q?9UQXxvId9Pai/IsQRaHYBosSVhTMvtVzVE4F2yzBSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503719dd-6182-442e-ed2e-08d997e1348e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 17:59:35.3074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvyknOyGgB6MlNeDVaOz7/M/rAtNLwBGLXnNdgiIQzZEGanFRm8RjxF672kMNInQpHrK+h51H3L+8t/qMiCGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4764
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
ZW50OiBNb25kYXksIE9jdG9iZXIgMjUsIDIwMjEgMTozMCBQTQ0KPiBUbzogVHVpa292LCBMdWJl
biA8THViZW4uVHVpa292QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IFJlc3RvcmUgaW5mb3JtYXRpb24gcmVwb3J0aW5nIGluIFJBUw0KPiAN
Cj4gQW0gMjAyMS0xMC0yNSB1bSAxMjowMiBwLm0uIHNjaHJpZWIgTHViZW4gVHVpa292Og0KPiA+
IEEgcmVjZW50IHBhdGNoIHRvb2sgYXdheSB0aGUgcmVwb3J0aW5nIG9mIG51bWJlciBvZiBSQVMg
cmVjb3JkcyBhbmQNCj4gPiB0aGUgdGhyZXNob2xkIGR1ZSB0byB0aGUgd2F5IGl0IHdhcyBlZGl0
ZWQvc3BsaWNlZCBvbiB0b3Agb2YgdGhlIGNvZGUuDQo+ID4gVGhpcyBwYXRjaCByZXN0b3JlcyB0
aGlzIHJlcG9ydGluZy4NCj4gPg0KPiA+IENjOiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBh
bWQuY29tPg0KPiA+IENjOiBBbGV4IERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
DQo+ID4gRml4ZXM6IDA3ZGYyZmIwOTJkMDllICgiZHJtL2FtZGdwdTogQWRkIGtlcm5lbCBwYXJh
bWV0ZXIgc3VwcG9ydCBmb3IgaWdub3JpbmcgYmFkDQo+IHBhZ2UgdGhyZXNob2xkIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIHwg
NSArKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhc19lZXByb20uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXNfZWVwcm9tLmMNCj4gPiBpbmRleCBhZTY0Y2EwMmNjYzRmOC4uMDUxMTdlZGExMDViNTUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXBy
b20uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVw
cm9tLmMNCj4gPiBAQCAtMTExMiw3ICsxMTEyLDEwIEBAIGludCBhbWRncHVfcmFzX2VlcHJvbV9p
bml0KHN0cnVjdA0KPiBhbWRncHVfcmFzX2VlcHJvbV9jb250cm9sICpjb250cm9sLA0KPiA+ICAJ
CQkJcmVzID0gMDsNCj4gPiAgCQkJfSBlbHNlIHsNCj4gPiAgCQkJCSpleGNlZWRfZXJyX2xpbWl0
ID0gdHJ1ZTsNCj4gPiAtCQkJCWRldl9lcnIoYWRldi0+ZGV2LCAiR1BVIHdpbGwgbm90IGJlIGlu
aXRpYWxpemVkLiBSZXBsYWNlIHRoaXMNCj4gR1BVIG9yIGluY3JlYXNlIHRoZSB0aHJlc2hvbGQu
Iik7DQo+ID4gKwkJCQlkZXZfZXJyKGFkZXYtPmRldiwNCj4gPiArCQkJCQkiUkFTIHJlY29yZHM6
JWQgZXhjZWVkIHRocmVzaG9sZDolZCwgIg0KPiA+ICsJCQkJCSJHUFUgd2lsbCBub3QgYmUgaW5p
dGlhbGl6ZWQuIFJlcGxhY2UgdGhpcyBHUFUgb3INCj4gaW5jcmVhc2UgdGhlIHRocmVzaG9sZCIs
DQo+IA0KPiBTcGxpdHRpbmcgbWVzc2FnZXMgYWNyb3NzIG11bHRpcGxlIGxpbmVzIGlzIHVzdWFs
bHkgZGlzY291cmFnZWQNCj4gKHByZXN1bWFibHkgYmVjYXVzZSBpdCBtYWtlcyB0aGVtIGhhcmQg
dG8gZ3JlcCkuIEkgdGhpbmsgY2hlY2twYXRjaCB3aWxsDQo+IHRyZWF0IHRoaXMgYXMgYW4gZXJy
b3IsIHdoaWxlIGEgbG9uZyBsaW5lIGlzIGp1c3QgYSB3YXJuaW5nLiBUaGVyZWZvcmUNCj4gaXQg
c2VlbXMgdGhhdCBsb25nIGxpbmVzIGFyZSBsZXNzIGJhZCB0aGFuIHNwbGl0IG1lc3NhZ2VzLg0K
DQpUaGVyZSBhcmUgYSBmZXcgc3BvdHMgaW4gdGhlIGVlcHJvbSBmaWxlIHdoZXJlIGl0IGdldHMg
ZG9uZSBsaWtlIHRoaXM7IEkgZG9uJ3QgcmVhbGx5IGxpa2UgaXQgZWl0aGVyLiBVbmRlciBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1LjEzL3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0
bWwgLCBJIHNlZSBpdCBzdXBwb3J0aW5nIHNwbGl0dGluZyBmb3IgQVNNIChwb2ludCAyMCkgYnV0
IG5vdCBmb3IgcmVndWxhciBzdHJpbmcgKHBvaW50IDIpLiANCg0KSW4gdGhpcyBvbmUgaGUncyBq
dXN0IHJlc3RvcmluZyBzb21ldGhpbmcgSSBkcm9wcGVkLCB2ZXJiYXRpbSwgc28gSSBoYXZlIG5v
IGlzc3VlIGdpdmluZyBpdCBteSBSQi4NCg0KIEtlbnQNCg0KPiANCj4gUmVnYXJkcywNCj4gwqAg
RmVsaXgNCj4gDQo+IA0KPiA+ICsJCQkJCWNvbnRyb2wtPnJhc19udW1fcmVjcywgcmFzLQ0KPiA+
YmFkX3BhZ2VfY250X3RocmVzaG9sZCk7DQo+ID4gIAkJCX0NCj4gPiAgCQl9DQo+ID4gIAl9IGVs
c2Ugew0KPiA+DQo+ID4gYmFzZS1jb21taXQ6IGI2MGJjY2I0MDhjODMxYzY4NWIyYTI1N2VmZjU3
NWJjZGEyY2JlOWQNCg==
