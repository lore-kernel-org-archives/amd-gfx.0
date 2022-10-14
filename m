Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5D4C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 04:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8EC10E0D3;
	Fri, 14 Oct 2022 04:53:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13ADF10E0D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 04:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0FE5tJx1jMBXXgLaH5G3Zt5PLGI8imITvCC2jp1F+rR91PeCAPWzYrT/zD/B79Uk5fD1NNG6VcSou8U/vgt3gDxM7ywQXY5Hvik3PgSm+CengQAWk64gkgUIQqGuyPDhprGORcXe2p25pxV05/C/aF6p+a5VomXI+OhCcNJBBoXmldR+jjNtslkWjTm57HDU9PC9OPoP4LaZc82bLg6URbGSjc37Oa7IWTk9xQTqOGgOqXKTRlxAfmReJZ1riecu2mVxrJh6tNTvjmBGkYZjS/xjP5ekxLNuQbj0ZQzIuuudWFhOgd6b00zVXTjQlljZWfvqY/oevwDZkyR5CYA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UwuiFB+SXff++3XygcM7hX61u1/oDYpGrb+5b8PVWE=;
 b=RjFr66tdfVeVo46NOuFsB2rAUp7C4LCJwNgeLL3bPOTxdbKg7rYQAbA1zAT1RCsFheH3Rhhh89sO18+OR0O8I64StT/arQVaJweKsgEOiVWJDxgwbWLntyOFI3NmlMNC18y7UUEvbnQWM7sy/5hKDg2VudV5oEMcpMasSFFPic9bzSssSCmBES7GVts5lW8L5dr2lbZUxPbV7QqSortC/vO/UYoKmMWaW4DrJ4ccRsBpAYVFUFmFZF9+hVCANmDu9UFfxUs9Uaa5wREU7LoAsbQ/QksXve5ksB6CUIHDhwI67SKHvvgRHUgHcHVSemJ4Sij4ANY9/MvPkZVCnY+HvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UwuiFB+SXff++3XygcM7hX61u1/oDYpGrb+5b8PVWE=;
 b=OjX7WPfUxyFpPE5ho7w1tYSfoMPNNdLcQF+0QVHZAvg+uwos1RbR3cWTt6G8n+aHzL2OOgtTrn9SyBSjy9MGMf7crAqUpr1m+/QrESF8XPPQ0Am46R8xWNlN1hbQIrA4jqTkrTTYLSJcIjf/4WvnStiVBZJla5xqxJf+PW5kya4=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Fri, 14 Oct
 2022 04:53:45 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::ed67:d561:7e47:ed4e%7]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 04:53:45 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [1/2] drm/amd/pm: update SMU IP v13.0.4 driver interface version
Thread-Topic: [1/2] drm/amd/pm: update SMU IP v13.0.4 driver interface version
Thread-Index: AQHY30u5Cls86qS3YU2wUVn6TAbDCq4NTDfA
Date: Fri, 14 Oct 2022 04:53:44 +0000
Message-ID: <BY5PR12MB3873565FD8A3655765801F4BF6249@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20221013054619.3979464-1-tim.huang@amd.com>
 <51c3c0a8-6729-3841-d2a2-f3002ac6d515@amd.com>
In-Reply-To: <51c3c0a8-6729-3841-d2a2-f3002ac6d515@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8c30a68d-8ef1-46bc-9cc6-4d1531647b4a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-14T04:28:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: f0238c90-1fdf-4843-c7ba-08daada012ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UuilzgB/pi2XQtq60PuJyCmAvzUSNWmV7XEcKxIusTrvPYgWKCNPFNmXWw4/u72ll7Lg2ov0BDbIWFzSP+cxvKVuMeC8PJgpfxdSndHNoRGlCgi6cXGxJe5peAyVm5PxSVPKUp/X/nOHWFnma0MdJOSJsmZzT3XavCMt/9H+KxAx6ucdp5Y3Uu0ohMMx/YWIzz0IwC490aWzB5qnD5PKa4Hi3CN+6IKgp8Q9BUr1jklAxbF61gY3vDcUSbbUlJCnLupZILQXOAmoDpRIoktGjYjsIikGm5017YOjNtmoG9Y0pMx+rEnpPVxCuH13QnAZ0p/GtWa3AOu2pTgonXNbnR8ovzmsT7vND2HW1iGm+KdIh3qbvpC4BDABNLQ5IHeLRMdNp13JaeWav1WSrNguD6moVe7HOR03IEWEhCBKb6ESvNyvIaHUFgNprY3eLXkyNwU5177KG0U9oJyJFT7MFCF+y+qXTemU5iF1dS1ARSqlOAMrcz/O7GO/y5Qdm1j8FWxZBc/oSivbH36YP4oWJzVOwCO3Cop/ZlQ0SwAaOozxeWgzfVg9Nqhsu9fuL1Rlx5aCIpnG/3yvwC+gOySRkpLT/69CyGmkcmKqq0ABs5JzkdSG9mQRiaH9PClubtfHL4J3MMW1veVUE3vD5HztszKpd4MiA0SxKd+cBwZx37sNbWI7VOD5fxbdGQ7KUbxB0sNrR3xfHlCXN/0Aw13IjKeTq5rqIUYlA2HWD9GUcYXUsZZdhhD64c1zrpZYPM/5rtRV/lZbCuqyHcXiQIOzpQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(6862004)(76116006)(33656002)(316002)(86362001)(54906003)(8676002)(6506007)(7696005)(66476007)(41300700001)(5660300002)(64756008)(26005)(186003)(8936002)(66556008)(53546011)(9686003)(66946007)(478600001)(66446008)(122000001)(15650500001)(71200400001)(52536014)(6636002)(4326008)(38100700002)(83380400001)(55016003)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckh2dnVncUhlYmRzNTZCQW9MVW9EeUUvUXAvMXRNd2FQajBQMStzcjJrY0Fn?=
 =?utf-8?B?ZGlqK3EwS3BVVnNiM042Q1ZUMzhPZ01FZE9WMVBTSTNvaWtrMlFsbG9PVEFZ?=
 =?utf-8?B?V1AvMGxmWFQrRFFUcno2ODdza1hoaHczL3A2WUNFS05RWnYxN1pxc24zejdC?=
 =?utf-8?B?Mng5cmcxUHRMZ3lOOTh5MktwZEtUK2hBTVlUbHlRektVM2ZmZnEzYWVlc09T?=
 =?utf-8?B?WGkzTkdibm10SlNKOFJ0b1pnaE5UaDFNWFR5T3BmK3VvTytoaUcwMVVnT09G?=
 =?utf-8?B?UXNrTkdkR0NxbDZtdnZiQStRZzg1MXN5REIzMEJnVkFpZ0wrN0FSSktNSE8v?=
 =?utf-8?B?UFpmcVZlZzZUK0U3dUpVbnMyaFk5NFVnWDNFRWcwRit1U0N6dHVqSlpTaVZV?=
 =?utf-8?B?MG10VTMwMVppc0tNUFdMZ3RPazVNSldyVDRtbVRnejI2bFNFemI3eFJHZ3Rs?=
 =?utf-8?B?T2E3Q2VwbkJKZ2lkQkNRUE43bmN6ODg3d2ZIK0NUOEJvbzRUNUJrSXgxQkZu?=
 =?utf-8?B?cWdJZDRJVkxQaDloSjdLUGloQktGdmdVQTMzNGRJaldxWHVtRFNxV0xyQ1Ji?=
 =?utf-8?B?N1BGUEFZZU12YXMyOFZxamwzMlJQNkM5K0c4U3RhS05pUUNIeXRmSDJXT1Nz?=
 =?utf-8?B?OWo4TC9QY0pNeWhkaDB5a3ltU0dYaTdzVzZmSXg2Y0w1WEFBZkMzdEpRN3dR?=
 =?utf-8?B?TjFNcDZ4YS8rQVQvNHEvMFkrRGE4b2NkYXUwbndMUGt4MGpnNUFqV0c4ZUxL?=
 =?utf-8?B?NjNkclhMelIzS0hXOEdHYnBEMGhNckc1YktKd1BiN2NDWTY1U3VxWWlJUnNU?=
 =?utf-8?B?MHcxSnBJb1RzU3hBaUVJaWFVbGNkVUp3VlZwWGJEbjZPeW9JbENoRWpWYURO?=
 =?utf-8?B?MXVVMEErOVZtamNIZmVJUktqajRSaysxWkgybUJxSXNtYk05Q2JpWk5EeC9R?=
 =?utf-8?B?dnlucUVsN0tRKytnek1QQmJHaUdocU5FbzZyaWFGb1EyYndwa0FMazdCcjRv?=
 =?utf-8?B?cmxHdnR1RmFzVUJXNUI4bmtiQkpyZnFYNFpPK05JcW1oNFkrMzh0a0xKUGZq?=
 =?utf-8?B?M0NUMFRqcnQxRjlJcmcwRE53SE9YL253N0hCMEJRZ1BCck1rOG1PYkNobUdm?=
 =?utf-8?B?aUtQVFA4eDg5ekJ3OWtyODk2L2RyYkROM3JwcytoVHg1TXAvZDRneVdvM055?=
 =?utf-8?B?VnFEMnAvM3V0Q1BaOFVTYWF1bXJ5cmJibmdFNGNNQ2ExQXVqYitqaVhtSFF0?=
 =?utf-8?B?ZXFsNGRMUUhRMWkvVG5UU25GQW1EZWo4OWJGa05GMHhBenpJRDFsWlBORzdZ?=
 =?utf-8?B?QmJtTDRQcENlVlJIUE92eDY4RXRIaTEwWUxQd1BzUHFqcmxmdGhvV2JZb2Y3?=
 =?utf-8?B?cUlkWlJnTldlMllWdVpyb1N3czBiRm5DQWcxM2xJVGdNNWk1alVNYU1hbTdo?=
 =?utf-8?B?UkV6bWgvQ1ZGeGpaZ1QzYVVydklDQjNDNmY5M3JTYTdYaElHdTB6c0hTQlpM?=
 =?utf-8?B?TUhtd1pwQmZibTIwQTliNEZ1MlhNNFMwaVFCR1MrNWRGQUpiTDJOaWZJdVdO?=
 =?utf-8?B?d3NUcGFEWXZDYWJ5SWpWc2IrNGRicjZKTXFkSU9vdDJUbnZJTzVraTBaRDNs?=
 =?utf-8?B?VTVtWFlLR1ZCeDl4ODc3bUhwR1BnWmpta1hFS0FqUVRxbjROZysxczkyS016?=
 =?utf-8?B?VG40ZXBna1dXT1hVbFhid280N1loYXB5MVpyYmZ1MnFMR1ZVZTdGUEZTK1Vl?=
 =?utf-8?B?dFRRSnVnNTBSenhVcUcwZlpRcTV3K0hzRjNiME5OblF3VzRLOFhRc1QyWmQz?=
 =?utf-8?B?Q0RkR3JmcXhTaHpDalZDWXIzaDRsSFNxSG9rZ2l3NDdpaldCZ3daWVEzbGx4?=
 =?utf-8?B?dCtPcnBpbUJkUG9aNmMrTGFiNG44NlJtUmYyUDJGclQ4Q3U3U0FZcXFLQ1Az?=
 =?utf-8?B?S3YxeEV1RHVUdjlMQW1QZWN1N0V6WTNmMldtSEZpbGVQREluSm94WXdURFE2?=
 =?utf-8?B?OStYQ3o3WHY4S0xYaGdOeVZPcmpLTzRIRlVxUjhmdno5UkhJRi8rWTNPSDdO?=
 =?utf-8?B?VlRjVWlZUDJwY3JsMkVCTWYrS2NGallHb3pLb1VtelR5cUNscVFZVXIrbmdV?=
 =?utf-8?Q?sCyznpWkD379diYF9L/SYUYE0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0238c90-1fdf-4843-c7ba-08daada012ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 04:53:44.9888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROt9EEYTqeKKHb/c4IZNWpHe0cv7uwUfS3l9tGHmZmTEQoUDZqXVQauPu9zc6H0J5H02V/wZmh5wI0KtW7itIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSGkgTWFyaW8sDQoNCkNvbW1lbnRzIGlubGluZS4gVGhhbmtzLg0KDQpCZXN0
IFJlZ2FyZHMsDQpUaW0gSHVhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NClNlbnQ6IEZy
aWRheSwgT2N0b2JlciAxNCwgMjAyMiA1OjM1IEFNDQpUbzogSHVhbmcsIFRpbSA8VGltLkh1YW5n
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiA8WWlmYW4x
LlpoYW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBHb25n
LCBSaWNoYXJkIDxSaWNoYXJkLkdvbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbMS8yXSBkcm0v
YW1kL3BtOiB1cGRhdGUgU01VIElQIHYxMy4wLjQgZHJpdmVyIGludGVyZmFjZSB2ZXJzaW9uDQoN
Ck9uIDEwLzEzLzIwMjIgMDA6NDYsIFRpbSBIdWFuZyB3cm90ZToNCj4gVXBkYXRlIHRoZSBTTVUg
ZHJpdmVyIGludGVyZmFjZSB2ZXJzaW9uIHRvIFY3Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaW0g
SHVhbmcgPHRpbS5odWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICAuLi4vc3dzbXUvaW5jL3BtZndf
aWYvc211MTNfZHJpdmVyX2lmX3YxM18wXzQuaCB8IDE3ICsrKysrKysrKysrKysrKy0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQNCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3Nt
dTEzX2RyaXZlcl9pZl92MTNfMF80LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZlcl9pZl92MTNfMF80LmgNCj4gaW5kZXggYWUyZDMzNzE1
OGYzLi5mNzc0MDE3MDlkODMgMTAwNjQ0DQo+IC0tLQ0KPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vc3dzbXUvaW5jL3BtZndfaWYvc211MTNfZHJpdmVyX2lmX3YxM18wXzQuaA0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZlcl9pZl92
MTNfMF80DQo+ICsrKyAuaA0KPiBAQCAtMjcsNyArMjcsNyBAQA0KPiAgIC8vICoqKiBJTVBPUlRB
TlQgKioqDQo+ICAgLy8gU01VIFRFQU06IEFsd2F5cyBpbmNyZW1lbnQgdGhlIGludGVyZmFjZSB2
ZXJzaW9uIGlmDQo+ICAgLy8gYW55IHN0cnVjdHVyZSBpcyBjaGFuZ2VkIGluIHRoaXMgZmlsZSAt
I2RlZmluZQ0KPiBQTUZXX0RSSVZFUl9JRl9WRVJTSU9OIDUNCj4gKyNkZWZpbmUgUE1GV19EUklW
RVJfSUZfVkVSU0lPTiA3DQo+DQo+ICAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgICAgaW50MzJfdCB2
YWx1ZTsNCj4gQEAgLTE2Myw4ICsxNjMsOCBAQCB0eXBlZGVmIHN0cnVjdCB7DQo+ICAgICB1aW50
MTZfdCBEY2xrRnJlcXVlbmN5OyAgICAgICAgICAgICAgIC8vW01Iel0NCj4gICAgIHVpbnQxNl90
IE1lbWNsa0ZyZXF1ZW5jeTsgICAgICAgICAgICAgLy9bTUh6XQ0KPiAgICAgdWludDE2X3Qgc3Bh
cmU7ICAgICAgICAgICAgICAgICAgICAgICAvL1tjZW50aV0NCj4gLSAgdWludDE2X3QgVXZkQWN0
aXZpdHk7ICAgICAgICAgICAgICAgICAvL1tjZW50aV0NCj4gICAgIHVpbnQxNl90IEdmeEFjdGl2
aXR5OyAgICAgICAgICAgICAgICAgLy9bY2VudGldDQo+ICsgIHVpbnQxNl90IFV2ZEFjdGl2aXR5
OyAgICAgICAgICAgICAgICAgLy9bY2VudGldDQoNClRoaXMgaXMgdW5mb3J0dW5hdGUsIGl0IG1l
YW5zIHRoYXQgdGhlc2UgdHdvIGZsaXBwZWQgYmFzZWQgb24gUE1GVyBkcml2ZXIgaW50ZXJmYWNl
IHZlcnNpb24hDQoNCldpdGggMTMuMC40IGluIDYuMCwgdGhpcyBzaG91bGQgcHJvYmFibHkgY29t
ZSBiYWNrLg0KDQo+PiBUaGlzIGZsaXBwaW5nIGFscmVhZHkgaGFwcGVuZWQgaW4gdGhlIFBNRlcg
ZHJpdmVyIGludGVyZmFjZSB2ZXJzaW9uIFY2LiBTbywgc2hvdWxkIG5vdGljZSB0aGlzIGNvbXBh
dGlibGUgaXNzdWUgZnJvbSBWNi4NCg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIzYuMA0K
UmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29t
Pg0KDQo+DQo+ICAgICB1aW50MTZfdCBWb2x0YWdlWzJdOyAgICAgICAgICAgICAgICAgIC8vW21W
XSBpbmRpY2VzOiBWRERDUl9WREQsIFZERENSX1NPQw0KPiAgICAgdWludDE2X3QgQ3VycmVudFsy
XTsgICAgICAgICAgICAgICAgICAvL1ttQV0gaW5kaWNlczogVkREQ1JfVkRELCBWRERDUl9TT0MN
Cj4gQEAgLTE5OSw2ICsxOTksMTkgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgICAgdWludDE2X3Qg
RGV2aWNlU3RhdGU7DQo+ICAgICB1aW50MTZfdCBDdXJUZW1wOyAgICAgICAgICAgICAgICAgICAg
IC8vW2NlbnRpLUNlbHNpdXNdDQo+ICAgICB1aW50MTZfdCBzcGFyZTI7DQo+ICsNCj4gKyAgdWlu
dDE2X3QgQXZlcmFnZUdmeGNsa0ZyZXF1ZW5jeTsNCj4gKyAgdWludDE2X3QgQXZlcmFnZUZjbGtG
cmVxdWVuY3k7DQo+ICsgIHVpbnQxNl90IEF2ZXJhZ2VHZnhBY3Rpdml0eTsNCj4gKyAgdWludDE2
X3QgQXZlcmFnZVNvY2Nsa0ZyZXF1ZW5jeTsNCj4gKyAgdWludDE2X3QgQXZlcmFnZVZjbGtGcmVx
dWVuY3k7DQo+ICsgIHVpbnQxNl90IEF2ZXJhZ2VWY25BY3Rpdml0eTsNCj4gKyAgdWludDE2X3Qg
QXZlcmFnZURSQU1SZWFkczsgICAgICAgICAgLy9GaWx0ZXJlZCBERiBCYW5kd2lkdGg6OkRSQU0g
UmVhZHMNCj4gKyAgdWludDE2X3QgQXZlcmFnZURSQU1Xcml0ZXM7ICAgICAgICAgLy9GaWx0ZXJl
ZCBERiBCYW5kd2lkdGg6OkRSQU0gV3JpdGVzDQo+ICsgIHVpbnQxNl90IEF2ZXJhZ2VTb2NrZXRQ
b3dlcjsgICAgICAgIC8vRmlsdGVyZWQgdmFsdWUgb2YgQ3VycmVudFNvY2tldFBvd2VyDQo+ICsg
IHVpbnQxNl90IEF2ZXJhZ2VDb3JlUG93ZXI7ICAgICAgICAgIC8vRmlsdGVyZWQgb2YgW3N1bSBv
ZiBDb3JlUG93ZXJbOF1dKQ0KPiArICB1aW50MTZfdCBBdmVyYWdlQ29yZUMwUmVzaWRlbmN5Wzhd
OyAvL0ZpbHRlcmVkIG9mIFthdmVyYWdlIEMwIHJlc2lkZW5jeSAlICBwZXIgY29yZV0NCj4gKyAg
dWludDMyX3QgTWV0cmljc0NvdW50ZXI7ICAgICAgICAgICAgLy9Db3VudHMgdGhlICMgb2YgbWV0
cmljcyB0YWJsZSBwYXJhbWV0ZXIgcmVhZHMgcGVyIHVwZGF0ZSB0byB0aGUgbWV0cmljcyB0YWJs
ZSwgaS5lLiBpZiB0aGUgbWV0cmljcyB0YWJsZSB1cGRhdGUgaGFwcGVucyBldmVyeSAxIHNlY29u
ZCwgdGhpcyB2YWx1ZSBjb3VsZCBiZSB1cCB0byAxMDAwIGlmIHRoZSBzbXUgY29sbGVjdGVkIG1l
dHJpY3MgZGF0YSBldmVyeSBjeWNsZSwgb3IgYXMgbG93IGFzIDAgaWYgdGhlIHNtdSB3YXMgYXNs
ZWVwIHRoZSB3aG9sZSB0aW1lLiBSZXNldCB0byAwIGFmdGVyIHdyaXRpbmcuDQo+ICAgfSBTbXVN
ZXRyaWNzX3Q7DQo+DQo+ICAgdHlwZWRlZiBzdHJ1Y3Qgew0KDQo=
