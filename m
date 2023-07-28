Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FEDC001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 02:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2080610E1E9;
	Fri, 28 Jul 2023 02:21:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8224010E1E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 02:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpHsGPM+WZ1B/t2Kg+Z0ZpMY+pqK010HozIYmrTlQ7HC2/MCjjRpDwKFdfSkPpLnCNHRN6suKLdvsY3F1Dp5FObNaIVot3FttmhObG/YDYSOANm97r5NXxL/8mz7Kz0syIf8nE41a3KTp/InwO41aRVvjv/nsvKxPzhkzMK6mAiRzT/ii9ROPdTtOf2fBBI36cocVEyavCEa9x8lEbcRPmoFb2x87VCSw1l3sntbJ4iaZAaVX9Jwr37FTC+xvTN4Le4Bb8NO/DAFIdeSq1YIUXaHATEYvqLsO0r1d7mdiRzfDr1dAiaUJcEisMFofvx99LanyIMfIYwigpjTaTSCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6u3I1Jck3iYIEYfAbB11L2Sqt7eo8gqo7vDkNcLyJE=;
 b=YWfD6Xw1+uimBWMKwyN6FstwvPgJomVb0Sq/qi7VbDc+HLMFTLR4t0uR08ilJVibx/vZyI/LoxXuAeP8NakGFDK2pW7jzFBBQFlZqvw0zNbtZvJTnQk8pPkfqJ1TkbPzilM1mZHb3yNj5f19kwdDy7kVH+/hrmSr4QM6mbwQh0sBartYfz7VPz6dPEIKt8CEPQX/3H8kI4HMVJb+FInWxl0V2GAP04QKAgG8fe8f45mMAk6AfM+7RXS9zlmjx3dKpDcPfHcNNKotThNRVBEi1vaOSG7ScPvejnXdsBmS8X4qlGnVMFBvQ5xQo7YSRSIsQzWvGpuXTZnXMVfLxJ/Zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6u3I1Jck3iYIEYfAbB11L2Sqt7eo8gqo7vDkNcLyJE=;
 b=MIZAyqol90PijQB3/NXWDD//8x2Sg8vDR2CyaCaEQwZ7qhgBe4g7k4dTwIow4+ArBBahIAVTmOWfQDaYcXbelng9r81IIm2jcaPuLhwt7/MywxN8cd/gzVBwSKVLL/B7+0/95SIYDshgvF0AJVuu5wIfjkAbc/apUVbWTgTybMI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 02:21:34 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::133d:2795:5cb8:204b]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::133d:2795:5cb8:204b%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:21:34 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: only save and restore GPU device config at
 GPU error
Thread-Topic: [PATCH] drm/amdgpu: only save and restore GPU device config at
 GPU error
Thread-Index: AQHZwG/F0oMoK4xNIUiwu+CyBnbcg6/NbygAgAD7e+A=
Date: Fri, 28 Jul 2023 02:21:33 +0000
Message-ID: <DS7PR12MB60056FCE4D3AD88DE49C5FCDFB06A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20230727095003.1959679-1-Prike.Liang@amd.com>
 <395e95ff-a25b-1ebf-b809-983c71414171@amd.com>
In-Reply-To: <395e95ff-a25b-1ebf-b809-983c71414171@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=beba2631-4f55-43e7-a8f9-ccac427062fd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-28T01:50:43Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ1PR12MB6075:EE_
x-ms-office365-filtering-correlation-id: 5eee7674-b643-4f02-9f7e-08db8f115cf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvGZbymrs5opVf+wLaBIRb4vP/kowpM+usu/LcOS6xP9mT62H2BtT3ekBWMIddy+OuanBPzqObLxzTTkHG/0z6t3Hd9d7uULD02MVhkLrjCh/bWLOEtw7lHcDwCb46paS5WLHxVqEvDXPS8xXnXIO0D0uqU5W+xgwIGyMJ1GJLhD2i0Fi5k4XbgNOVmTC7dEyTRHA2nvuN/Oa6+FjdWeDsuUnDkxdDnpcZYZpVPuq39JdFQdrx+dQHjGENmJBPd++8NNWDkHUfiVFlAjq22jWxsX/wzji5hJ95lnILL6emdT/33B5cCLXyn2iXkO8kYa/iKF0SFrujwyCI1R1f2v1yWg0HHQkNUY/WhenZlzk7ZhLHBugXZNUfS2lOVF6IOTuM4iGtsrtzwhWmjQ57+bugmqTWeS92E7ldXX++FWYqSKixs+HlkwB752p3NHInSRCLGlzyaA5CTKT5AhSnKv9lnlviOc/R7FT/jJgYiplA5uBf7l5kzWnVM2QY40oQH6DrzBEDiX0kNlwhkYpXMI0Yv9Kq/EfCdL4rpMTnzv/HdzYubWnJmnp/ljY/a+qQPNCWk2hW8lZrwLGFRGbPJzZJjo1/06MU+Pl+/C+fS4UOCLqIx23yyDrxSFoG6kidgw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(8676002)(8936002)(86362001)(41300700001)(33656002)(2906002)(83380400001)(6506007)(53546011)(26005)(186003)(55016003)(5660300002)(52536014)(7696005)(478600001)(76116006)(4326008)(66946007)(64756008)(66476007)(66446008)(66556008)(38070700005)(71200400001)(122000001)(38100700002)(110136005)(316002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRuYTFTYkYxY0g5R3RrMG1IelJ5TVhBQ0ZraWpFTEhhNll5UWRnR1FUeTdv?=
 =?utf-8?B?TklPck4vdDl4V1RieEtSdzI2eXZRYU81UGRhakw2cGxTeGQyTkpmbFZLNHZ4?=
 =?utf-8?B?L1QvZ0lYWFhQNnpQZlMrcVRIbXVkS215TzEvTlRIYjNwelNTV0FKU0dYQXJT?=
 =?utf-8?B?enFta3pDWGtZQnc4MmRNUlYwS2RIN3ZBMVdHS0x0VDR4aTJLQUdFdVhOdUhl?=
 =?utf-8?B?NXZyRVJxM0k2WkxyNE1nbDJFTjAzTExDaWdIQU5FZGNrcThtRENBK3JmQ3Rl?=
 =?utf-8?B?MEU0c0FZcmRMOEpFY3k3Q3FWWC9ZZnpKcEw0VVE1QjV3enJhQmVZaTUvbmV5?=
 =?utf-8?B?QWp5azg5RUZBMlV6cEpjS2pieGZOQlAvcmlTMTRVTGc3dDBmL3U1dElndWRq?=
 =?utf-8?B?citGME5XRUhTSXRRWE9NVlVDSUo4RTRqMElreUZ0akRsRlgranFWdFN3UTF1?=
 =?utf-8?B?NEJ3NXZjbUZjdjZXU0RLQys4eHR6RUpaQkdqOEZyL2plV2VLVzVHVFVyVVdD?=
 =?utf-8?B?QkNxS2hPOS9MckkvMEZDL3VKbGt4b0NKUmhtT1dURzhnNHpVRytINlhER1pZ?=
 =?utf-8?B?L3BUN1I0clRncnJMcFdPMDA2eVk1d0FMYUlDUi9YSlR5VXVhMXdpUnNxZ05H?=
 =?utf-8?B?ZHRRTTJhVDNYS2YyY2JwbXVHSmZHQlZQYnpmdnlVbmlNYzk0Wm8zMFI3eVF1?=
 =?utf-8?B?SGdVWmhQdW9aRDdiNmZ4Nk9WcXJkdmU3VUc3YXprWWF2dVlUTGh1VnJtZGNj?=
 =?utf-8?B?SDhpSndObzNmcnBvdDZKdHp6cmh6V0VvcUNjcDVwL3RzT3hVSHhJTWN3aVli?=
 =?utf-8?B?Mlc0UVk2WGx5WFpjU2tiTlBTajVyNmY0QkJPbks3RENBUEJrUHJ0cW1zOXNH?=
 =?utf-8?B?T0NXdVVFVUNoRjJVZHVabStyV1hlUkN1czg2WFhMeDNsVSs3V0lUM0dWdTda?=
 =?utf-8?B?YXdRNC83OWwvblpCaE9Bb25mUU1na3QwQ1l3c0tOeCtzWlMzd2VmNjBnV2NU?=
 =?utf-8?B?MSs5aWFNMURYd1JhNFMvRU5aVXNuQVp6dHFacGZrbFV1NktGRkxZbEFjQTJ5?=
 =?utf-8?B?YnFQRzNHRTVvNjZSZEl1bVo3SU4xQkpwT04wSVNRMGdGcFN2NVZzZHE1NGtp?=
 =?utf-8?B?NjZjRmpsTG1MNHZubTU3OHB1NDZ4b1NWVHo2Zys1Y084L0ZoRXBvQTA2Wm82?=
 =?utf-8?B?QjU5RWNSTndySFFTUitXN2xFMkdDYlhpZmQ4YUY1YXh0UjBaajdsUG5GZDUw?=
 =?utf-8?B?M0hma0o1L0RlOVg1UDJMUExBVTQ5allvSWNjWFpRZ1ozNk1XeGoxNTUxY0l3?=
 =?utf-8?B?S0VXSWhUbitSbTArU283YjllYmZ4RThraEw2aTNlN1hQTUJTYTJLK2xIVzFB?=
 =?utf-8?B?SnM3WEx0L2VEUU8yMWxJenIzU0pUNGR0VjhRMi9ZV3huSm9FazFRWDI0WE1O?=
 =?utf-8?B?SmZXLzlEZ1hQRTlHVDJZdnNlWVM1MmpBYVIrUlp3SFY1YTV5M2NZSnBvY3NZ?=
 =?utf-8?B?WVdacWtTMzRBQ21BeUFOOTA4RmRRUFByVXEvaFJEeFRoSnNoelZacVJTdkhF?=
 =?utf-8?B?S1prcStlbkd1L1duSXA1V3FoWEtvaDJoUk5MOENuN0VUYW9mY3NZVkN6ZmVS?=
 =?utf-8?B?ZXVjZC9ZekNVY29weVMrWTI2ZzFvdlQwUXlnQlJlNkRZZVUwSFNjelFNZG54?=
 =?utf-8?B?azQ2WFFRZWZweHMzOTJ1cS8vRVN5Z1dwZThtc3Y0aFlRZmJpdWdldGFGSWU4?=
 =?utf-8?B?UjJoMG1WVkpZSmk5NlJUT1dJV3B4NHdkejhweDBycTY0eXRuMlM4RDNFUUpO?=
 =?utf-8?B?SUhuM1BnclpPVHM4YWFwTWpDb0hPVlZTendpNWpJZGtCNTE5bkIrbm1Ganp2?=
 =?utf-8?B?MVBKR0c1Vy9CazV4TDJ4eW12bzIxYkRDbXZ2NUFWeCtuRndpMFRPblB6NFVx?=
 =?utf-8?B?UVdjenZQVHJEaU1qN1dKZHhxUUkvdFlWMjJTKzMvLzdlVnRpNzJic2hxc2k0?=
 =?utf-8?B?NHo1SXNZYkoyMnZOUUtHL3loNVB1U2NEaWM4NG5vbUl0Q2VVV2w3RlBqM2M4?=
 =?utf-8?B?MGJpdzdDT25pamFvWFRMVDQwNzYzOWx0U01DaThlZXJkZVB3Y1JCclFkSFBq?=
 =?utf-8?Q?QsLI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eee7674-b643-4f02-9f7e-08db8f115cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:21:33.9467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTiQDpfihpBWZiRsTOp8m1x33LKRtUdtRZT1kDkXBBsTsX8gzKhBcbfPKpMgIC0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGksIExpam8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAyNywgMjAyMyA2OjQ5IFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBvbmx5IHNhdmUgYW5kIHJlc3RvcmUgR1BVIGRldmljZSBjb25maWcNCj4g
YXQgR1BVIGVycm9yDQo+DQo+DQo+DQo+IE9uIDcvMjcvMjAyMyAzOjIwIFBNLCBQcmlrZSBMaWFu
ZyB3cm90ZToNCj4gPiBUaGVyZSdzIG5lZWQgYSBjaGVjayBvbiB0aGUgR1BVIGVycm9yIHN0YXRl
IGJlZm9yZSBzYXZlIGFuZCByZXN0b3JlDQo+ID4gR1BVIGRldmljZSBjb25maWcgc3BhY2UuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDMgKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMNCj4gPiBpbmRleCAzNThkY2MxMDcwYzUuLjVlZjNjNWM0OWJlZSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAt
Mzk0Niw3ICszOTQ2LDggQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgImFtZGdw
dV9wbXVfaW5pdCBmYWlsZWRcbiIpOw0KPiA+DQo+ID4gICAgIC8qIEhhdmUgc3RvcmVkIHBjaSBj
b25mc3BhY2UgYXQgaGFuZCBmb3IgcmVzdG9yZSBpbiBzdWRkZW4gUENJIGVycm9yDQo+ICovDQo+
ID4gLSAgIGlmIChhbWRncHVfZGV2aWNlX2NhY2hlX3BjaV9zdGF0ZShhZGV2LT5wZGV2KSkNCj4g
PiArICAgaWYgKGFkZXYtPnBkZXYtPmVycm9yX3N0YXRlICE9IHBjaV9jaGFubmVsX2lvX25vcm1h
bCAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9jYWNoZV9wY2lfc3Rh
dGUoYWRldi0+cGRldikpDQo+DQo+IFdlIG5lZWQgdGhlIGNsZWFuIHN0YXRlIHRvIGJlIGNhY2hl
ZCwgbm90IHRoZSBzdGF0ZSB3aGVuIHRoZXJlIGlzIGFuIGVycm9yLg0KPiBUaGlzIHN0YXRlIGlz
IGxhdGVyIHVzZWQgdG8gcmVzdG9yZSBsYXRlciwgc2F5IHdoZW4gYSBtb2RlLTIgcmVzZXQgaGFw
cGVucy4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQpCdXQgdGhlIG9yaWdpbmFsIGNvZGUgaW4g
dGhlIGFtZGdwdV9kZXZpY2VfaW5pdCAoKSBpcyB0cnlpbmcgdG8gcmVzdG9yZSB0aGUgR1BVIGNv
bmZpZyBzcGFjZSBpbW1lZGlhdGVseSBhZnRlciB0aGUgR1BVIGNvbmZpZyBzcGFjZSBzYXZlZCwg
c28NCnRoYXQgbG9va3MgdGhpcyBHUFUgc2F2ZSBzdGF0ZSByZXN0b3JlZCB1bmNvbmRpdGlvbmFs
bHkgYW5kIHRoYXQncyBub3Qgb25seSBmb3IgdGhlIEdQVSBlcnJvciBjYXNlPyBNZWFud2hpbGUs
IGFzIHRvIHRoZSBtb2RlLTIgb3Igc29tZSBvdGhlciByZXNldCBjYXNlIHRoZSByZXNldA0KZnVu
Y3Rpb24gd2lsbCBkbyB0aGUgc2F2ZSBhbmQgcmVzdG9yZSBHUFUgc3RhdGUgc2VwYXJhdGVseSBh
bmQgbm90IHVzZSB0aGUgR1BVIHN0YXRlIHNhdmVkIGluIGFtZGdwdV9kZXZpY2VfaW5pdCgpIHBy
b2Nlc3MuIEluIHRoZSBhbWRncHVfZGV2aWNlX2luaXQoKSwgaG93DQphYm91dCByZXN0b3JlIHRo
ZSBHUFUgc3RhdGUgb25seSBmb3IgdGhlIEdQVSBlcnJvciBjYXNlPw0KDQo+ID4gICAgICAgICAg
ICAgcGNpX3Jlc3RvcmVfc3RhdGUocGRldik7DQo+ID4NCj4gPiAgICAgLyogaWYgd2UgaGF2ZSA+
IDEgVkdBIGNhcmRzLCB0aGVuIGRpc2FibGUgdGhlIGFtZGdwdSBWR0EgcmVzb3VyY2VzDQo+ID4g
Ki8NCg==
