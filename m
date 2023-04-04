Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7090C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3AF10E6F1;
	Tue,  4 Apr 2023 16:07:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B50110E6F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN9ld64Ozu/k5pqyHHEw+n2ZqGsXlk9BDDbjNqoRqBjl3yMEhwa0CHSI2jcEQT+PFD6XnQUIjtqRQGxdKLQ8MBRu+LTOJ4IZRN5gLC70rv48mDmgGHdrZ3eFHZJ1x2V7bpLRhf5XXZ2EIXxJMYRkw3U7+hQlp1q/LpOV1rezZVyO7yQPVNOiobG6QFUnkNP/uPQYZtIoOnAjQodxwLkxsRtWw+DAw3/jszo8M6ExxH03H/jeOlYgNVHmIvkLlih0e2eT7VtM+gqlWHuHm08PKK+92Z9cTMPtiPwWy7+K2GO7iMXyfzvuggedEElsMulIx9Hgl4Zhfa3bxxYcA8nI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZxvw00ZfXgfp8lPGob8vbed92DmqhAuovAwlm8LJmQ=;
 b=EXg6DFqBD0c9ZvO/y5JO7Iva/MAXZRtk4RvUIXICUpdB0Wxt28f/fs91CA/dIsPHWYrnjNB3j12B/WCVRntWiGwkaOULVhIi8sboWzgpTnHJEOa/cXk1baicLmiyp20aXG/kc0DnhguvMbBP1ePBjD+7uyzmGgAW7Pja563TOcDPlzTGfZ5ZfOEtBoQjN7x9sgLZkOPPNp82vwYbIs9LSU14EBz2Ej6w7FEhxgQfGtTANSJIIs6U8qY58QqPoIS/I+ZNgbLD9OO8WsTSESYBFCnz44CiTX8uG5IeoOTvZKk9Aqgo6G9cbO5YSPg32gI3EjYOdm02pjFX0qxA6tzO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZxvw00ZfXgfp8lPGob8vbed92DmqhAuovAwlm8LJmQ=;
 b=jNIMq2fXU6WKubiW9VWhge8DyY2Txm2X5ZGKWJwwVQpQzV2PTdfY6MxO2zgTL2ygM5R87mCgpvqrI/ecYakV9fqXv0IJbhkVyUIa45cmihpwRaQ4dM+dcEnsclEjOvb6HdPMCCf+s6zF43phnzTeyQTIk8VZwHg33TCAIOGjotE=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 16:07:34 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:07:34 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: add print for iommu translation mode
Thread-Topic: [PATCH v2] drm/amdgpu: add print for iommu translation mode
Thread-Index: AQHZWzWkHB1qeirBGkSM4W0C10hk568D2BwAgBeQFBA=
Date: Tue, 4 Apr 2023 16:07:34 +0000
Message-ID: <DM6PR12MB30677905CDEF6A98E760E7F98A939@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230320140858.1420216-1-Graham.Sider@amd.com>
 <a25a9826-9778-73f8-dcb7-1c15e64782a3@amd.com>
In-Reply-To: <a25a9826-9778-73f8-dcb7-1c15e64782a3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T16:07:33Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ade7382-d258-4202-8a8f-11dac3bfd9e3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-04T16:07:33Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3327fbf7-00b4-4cb3-8b45-74951b1e8e0d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|SA0PR12MB4496:EE_
x-ms-office365-filtering-correlation-id: 65f91206-3d53-4dab-22a3-08db3526b40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ikp8EHW6gck/41wsNvZ4eUeoxo6dpWo+7hJPKwWckJU5gonsQoEDa2OADu5eZZD6GkwH7bfcOVVJpu0AQeaYjKOSAfwpwVFjxLNxsmPwaOnBfzNPwwaYLqxGvUTcITFu4o8E80koYW/ZnZWS7GSmM7/qfK+jysntym3bc1cHu20F4AIXuyaSgWjTvJNmYqhwQmNCjb2jjIbyyCLMgj2zZaMyPquq/uU+9W47qtro+Ba+/q1t9UJY7vubxZ4RSfv4idJC81KoN/V4BkSEUqRp5wEuh+kea6h/5eApEEINUFFbPXDOgKeBS4QBaR9RtBT0d4DGeZC3CIeTcAok6m0kRGUf/yWHT2U4fgbyXLUVzxxSsJV8yyQcogkCQN77yEiQ+b5vG3fN8H1/zi/XWXRG8HeB2inHvxlvG6PK+weNa713Kc0f2RycMjvB5Ma7sMF3yyHOouYnfSWc+jRBY6/yg6ZR1faduJ5ZGVS5EeVpWTcZeb2I94CV5FkCXAzVelaZD8XHVUXFXX3gjmp/tiN9Yo3BanGlEWBOOjqodD0jhhCC3Vx+NL9Z9dWhQGRYPk3BxVDmjpgskRZIbVDOW9MPf5JMJH2e/NDT0g8J6SGU+Ou74vD+L6H5x1p7Q/nw7Fof
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(66476007)(186003)(66446008)(64756008)(38100700002)(122000001)(41300700001)(71200400001)(7696005)(26005)(53546011)(6506007)(83380400001)(9686003)(66556008)(478600001)(316002)(2906002)(33656002)(86362001)(66946007)(76116006)(6916009)(55016003)(4326008)(8676002)(5660300002)(38070700005)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlcyODBmWFJmeVJFbngwYkcyREpCZ0x6SWFOengzOFZZVUdPM1ppS3AycDBI?=
 =?utf-8?B?eFNVNVpWcStXTGxmK3BsZVJoMzhkNys1WjNWU3A3Q0xYQ01aRjlRTWpLU2xB?=
 =?utf-8?B?RjlTT2R3NHBVU1k3dWRtdWtycDlOakRKZTFFS2QzR2o2LzdtWFQ2cm44WTAy?=
 =?utf-8?B?Z1paL0xjOFNaUzIwQW5WWnp3WkJkcjVSc0QrK0FSVWhveHBNMmpOaERSTVNC?=
 =?utf-8?B?Ty8zNFI5TkRQbWxHYzViM0VmekhYYTF4VEpFcTREbGVrYU5jUS9JNkZaZTJ0?=
 =?utf-8?B?bmQ0N3YvMGhjczQzNzlLRTRZcHdxcGNybFMvdEtQOElMK1NGWGFxT0g0T0hx?=
 =?utf-8?B?TkQ0RjVZdHhBdlNPeE5HbTRUNVF6WDJRRjVNS21zS2JmMWE3QzB4S2NhQlF1?=
 =?utf-8?B?QTdRMkRxNVc1UlJVSzJpTEUyYU5mQ0wvcG1SVDVxZUhpZXhWdWtpTUYwaS9u?=
 =?utf-8?B?MXl5bVNIMEpyU2s3c1dKbW9YWm16VkRUZElTTVR2bkpXVngwbnhoWUVsWDNL?=
 =?utf-8?B?b01lYUtVWC9xSVhsU0dzb29Ra1gvNExFL05Oa0o4VVJWbFNZU0ZHR0xib0Nh?=
 =?utf-8?B?a3BSQm5KR3NQRWFYOEIxc1hldTZqWTd6SjUrcnI1enRYSGg3Q3JPQzJUT2Ri?=
 =?utf-8?B?QURkalVwZFBiZCtiMnUrRkFFbkQxdFRTN0RHU1pTM3E1K003a1JjTGZ3M1dH?=
 =?utf-8?B?WC9IV0Q4MmFaUnc3QWFDS3F6WHNiR29LTlZySTQ1WnREcjFUT2RSR24vUmYz?=
 =?utf-8?B?L0U0NkhPcmVRSmtLNlpuNEpYNFZIbE9xcFBZQ3JsLy9KWkNDZGd4ampYZjZj?=
 =?utf-8?B?Vk1nbklNcTBpRjZ2NlRqcmFMLzlXTVZrWGlYNTI5Ti9wODkzaW9GNFVGNDA3?=
 =?utf-8?B?U00yMVA4TUdnY2Q5ZGdMRmlweU5nS3RlUlQvb2JrRjVzeUJwKzBBd1FjaUxj?=
 =?utf-8?B?aDVNalBUVUpQYjhRSStQeEhkMi8rVjJtUWhvTkdBSHBPM2xGdlNrV1MzODRH?=
 =?utf-8?B?NThQaEhCVGtMZ2R3UG1oYUp5d3FEYkVKNUllYm9JblhBbURtbTFNK1kzZytz?=
 =?utf-8?B?SFpZYlNuZmtyR2N3ZGJzZHBOYkNxZ1FWYnNpVkViclQxRXFBdTZSbXpDTUp3?=
 =?utf-8?B?K2FPOVJ3VDVUVmJrMXdYSjN6ZjkrUmJhVEJkN1djSG04cnFlUkpHSnUySE51?=
 =?utf-8?B?ZmxDMm5SdWFGWnNRWGptdEVKT2hGRS80RmR4V0ZOMkZzL3BUUWREOGJyVmlt?=
 =?utf-8?B?R29ZK2toem1uV1ltRTIyaGdmeEF0RlRMU2xyN2hmSms3YmJYK0ZjcTZucGJz?=
 =?utf-8?B?QjFubVdFWE1CMkRXSm0yL3dkZVZGeXB6clZnRHFCbzhkSHZSK3JQd25TdklE?=
 =?utf-8?B?WnlVYkgvRXI5MzEyQzQxd2tkcDlhVzNMZGtiNWJDM1h6bWZXeUhNYU5UY3dk?=
 =?utf-8?B?dnBLT3IvUlo4anlTMzZGQkV3TzRDdlRrTzdZMDZ6dVV4eUkzOENsUU4rSWVa?=
 =?utf-8?B?VmpsSy9iMmxBTWFXa2xCUnlDRVp5Y044KzRYUkdVaUxmVzA2Q25CSUlmQnJ1?=
 =?utf-8?B?UXBZMUhwVE9hTVllOFBaQ2pnYU9zTVZNbW9mTTdWaFdQT2lEdGtwV1ZPS2Ry?=
 =?utf-8?B?YUJtT3F5SHlNUWlqd01BM0V4dFR1Mm9LcHg3SXJpek8rQVkrUGZnUVg1aXNl?=
 =?utf-8?B?TlhlalNxUGI4NkVLZjZqN1Q2Z3lCSTFycnVCQzNQSWtUVi9uRGRqVjA5eDN5?=
 =?utf-8?B?L1ZSbEErMkVQSk1GVnAyaDdWbzNtS0VkdlFaRmMxQmtLbUhUNFpHVDB2L0ll?=
 =?utf-8?B?eFZPR3p2RnNSSHJTRkswOHZ2bmxzYWdkczRuK0R6TGN3K1ZOeTN3bjc2WTN5?=
 =?utf-8?B?em1OalMvTEJYWTJkQVlwOVZGRmlBVnkyckgzUGJOa0dNSUVlYTdtVHZLZUl3?=
 =?utf-8?B?YUpjNktvRlhaamxMUktVeTA0VDd1WnorNHFBQWZxakxncExTZEowZTc4NlJ5?=
 =?utf-8?B?aTJVaElFSWxsREdKa2pucTRFUlVXNDZvRWdMcGEvT2FJU1R0YU1oNDRhL2w5?=
 =?utf-8?B?eW9mVDBaMzhjUUdlakpTWXBxTXZSWDJPcE8yeGx5b0N5YjNteG1KSHRXL3dF?=
 =?utf-8?Q?Fbn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f91206-3d53-4dab-22a3-08db3526b40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 16:07:34.8430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oSubet6Qla0VdPt5eChdtjQw+jFYX8ppA5nWsCvIXbYEq2CuSjcSBWUJ6ZLtE62/jKVbt2FOVchlOQzCyeG7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClBpbmcgOikNCg0KQmVzdCwNCkdy
YWhhbQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBG
ZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAyMCwg
MjAyMyAxMjoxNiBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8R3JhaGFtLlNpZGVyQGFtZC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2Ml0gZHJtL2FtZGdwdTogYWRkIHByaW50IGZvciBpb21tdSB0cmFuc2xhdGlvbiBtb2RlDQo+
IA0KPiBPbiAyMDIzLTAzLTIwIDEwOjA4LCBHcmFoYW0gU2lkZXIgd3JvdGU6DQo+ID4gQWRkIGxv
ZyB0byBkaXNwbGF5IHdoZXRoZXIgUkFNIGlzIGRpcmVjdCB2cyBETUEgbWFwcGVkLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1kLmNvbT4NCj4g
DQo+IEFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4g
DQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jIHwgNiArKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCAzYmQ2YzVhZWY3OTYuLjgzNzc0ODI0Njk0YiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4g
PiBAQCAtMzUyOCw4ICszNTI4LDEyIEBAIHN0YXRpYyB2b2lkDQo+IGFtZGdwdV9kZXZpY2VfY2hl
Y2tfaW9tbXVfZGlyZWN0X21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIAlz
dHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47DQo+ID4NCj4gPiAgIAlkb21haW4gPSBpb21tdV9n
ZXRfZG9tYWluX2Zvcl9kZXYoYWRldi0+ZGV2KTsNCj4gPiAtCWlmICghZG9tYWluIHx8IGRvbWFp
bi0+dHlwZSA9PSBJT01NVV9ET01BSU5fSURFTlRJVFkpDQo+ID4gKwlpZiAoIWRvbWFpbiB8fCBk
b21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlOX0lERU5USVRZKSB7DQo+ID4gKwkJZGV2X2luZm8o
YWRldi0+ZGV2LCAiUkFNIGlzIGRpcmVjdCBtYXBwZWQgdG8gR1BVIChub3QNCj4gdHJhbnNsYXRl
ZCBieSBJT01NVSlcbiIpOw0KPiA+ICAgCQlhZGV2LT5yYW1faXNfZGlyZWN0X21hcHBlZCA9IHRy
dWU7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWRldl9pbmZvKGFkZXYtPmRldiwgIlJBTSBpcyBE
TUEgbWFwcGVkIHRvIEdQVQ0KPiAodHJhbnNsYXRlZCBieSBJT01NVSlcbiIpOw0KPiA+ICsJfQ0K
PiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqYW1kZ3B1
X2Rldl9hdHRyaWJ1dGVzW10gPSB7DQo=
