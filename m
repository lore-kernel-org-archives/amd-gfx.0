Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CFBC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 10:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7B6206F1
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 10:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7B6206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB146E1AA;
	Tue, 12 Jan 2021 10:28:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB4C6E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 10:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C98zicoGDhUnmCmjWrmHNP4z6hAtda0bRvMsTE9ph5btZ2aQA8wpGdKH12uqcodGXt4QfPbmrVyb9nw3K983zDo1UFPw8ZnXd/sLENDacGahiRyA9NeFghAseZcrMJ7TMIVgchqwb4VxGgeLCFJUddUjGose4525KME+v4sBuJl7qbPSHNBLjEQmJ3+TIbyjIjhY/Z1hn5vzvwfGfzb2JfAXmm/PJmPUs08Uu9KQmIrCyEJ7SfGRERpZKNGeJ+InPXVERriHsT6xpmtneO+W2WIRhYF8+O9xCGaxcIiku2adqgXbe0xd9s0sgKtBG+Ef6r73BUYAf1MNoxs60Nf+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuAPRkVX2SmtPlBJZoJ/H0CzLzhE62qWD+U5S9RsSDM=;
 b=GgY40dCBmUL0rA7LSzaXxu4CvNVG14KsgVWB9lmW9GrQtMe4haKRQXVwBKKHhfTqD+QFahqcRgIZzpyIPYikMu7NfSyMESkBPoTS7+UxEtiSZmKjIlNTuVfR/yQa1Kjw64AotFnMuSD3algqLmDZd1zDQCrboFX8BbFYvmF0c+/FW7EvfLRxTXHN1BQno2FTKjYEq2DBEZT//l15uFCbhqqU0uN+w/V6fqtaNOdwLhb+JhVde9BSTphp5pb02oB5wJn0pXDbFZHdNWCkyOcC9jGMXkacCNbdAiVMxh6Em9ld+ycdlsTFe5Vx9H2OmtK17ALztrcx78Sw/C6kMHZFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuAPRkVX2SmtPlBJZoJ/H0CzLzhE62qWD+U5S9RsSDM=;
 b=OUbZ49DgPGHJF7AQH61cm8beLG5KpoaPtIDNso4Ymh/AVstWn66In9RGl+X318V1yr3rQ4JtNkaXKjqbTPaQU821cWNlIHa0R6Pu8FrEB4f1ZOyuZP3DZz236zJuErnt95BZPBqbE/y/P7DBBRnTsx/6rlZxwSl8PIt+jvsr11M=
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1649.namprd12.prod.outlook.com (2603:10b6:405:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 10:28:39 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 10:28:39 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix the return value of pm message
Thread-Topic: [PATCH] drm/amd/pm: fix the return value of pm message
Thread-Index: AQHW6M0/vJr7MoZ2BE6fqZV38QrVhqojyT+Q
Date: Tue, 12 Jan 2021 10:28:39 +0000
Message-ID: <BN6PR12MB112468B7F5DE8B2662111972F1AA0@BN6PR12MB1124.namprd12.prod.outlook.com>
References: <20210112102508.82417-1-ray.huang@amd.com>
In-Reply-To: <20210112102508.82417-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4bf395be-acc4-4526-83ad-00007392a8e3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T10:26:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fb71b87-5cb6-43bb-dc7e-08d8b6e4d3d4
x-ms-traffictypediagnostic: BN6PR12MB1649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB164936D80A781E6F9F8F02A0F1AA0@BN6PR12MB1649.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fl/gxA5tgFchOqc9+MgfIvPaOwKX95H7hWWq79j95yjZMi91jW8e7LWq/bR/wdqtFZhfIjjhGAlTluduT/xFcc/HwXXJV4XmaGcB1nNAkgNcPO7LKCHBh6tE3rSeaWk1IZUV8LhgwY4D3YOERm9y0+/byXVx7C6LFW+FX0i7KMRTq8p/Hw+JDsJEet377SsFz6phagFCkrz52Wk9A42QuSutYODGdQAs8x88ULKs9z1x7hz4PwtT9lSgiaPpBVwwQackmCo6RLzKIIomaSflNVug+rZsr8HSHevnM8O2CsyLdFxGaJjnmr6oO6WswHsvDkwwAMKwM5LOgbZygiDq9mlJXRszTLci+6EcYOzCdJSpNJXhRpv3epcZ90cLYJHuXPgAlPV5eUBC1SN0gvhOnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(110136005)(8676002)(54906003)(316002)(26005)(86362001)(186003)(71200400001)(5660300002)(478600001)(2906002)(15650500001)(55016002)(52536014)(33656002)(76116006)(66476007)(64756008)(53546011)(66556008)(66946007)(4326008)(7696005)(66446008)(8936002)(83380400001)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?aXFTY3QvYzZNWXRRODR3L0VjRW9MMkcrbGNod3hhSzN2RnJ0cEthWHdaTXZo?=
 =?gb2312?B?TWlNbkZFa1ZZZXJNNDh5eSsyNHlqbnJWYWtTVXp2VU4zVWZnUjQ5UjZoYXgr?=
 =?gb2312?B?dFJuampXLzdJY2hLM3VDUzRSa0RaUm5WZ1hpMUttYU1iOWVIc1hWZGJEMXY0?=
 =?gb2312?B?OXEvWmEzM2NkQ1QvT0pjeFlKLzRVQTFSUktHa2xaK2tDbFdLZU5kMDh2RTA4?=
 =?gb2312?B?TjIyUWx6VDlzTyt2bFdZUjNNaVltWUk4RzJtN0FXQkdKMHBYS2RBam5mSGND?=
 =?gb2312?B?bXFWRjR6LzZkUEs3SHBLTzNMa2ZqQklBT01tR3lhVDE1TXFvNmJGaGM4TDBp?=
 =?gb2312?B?SXlVTVRHc1RzaHlsVmQ0aG51cVk1SFNZSXBVYUVyZ3ZOMDF6ZSs1RnpXZkJR?=
 =?gb2312?B?UmNKUkZzcFNpamxxLzRheVlwYzVMSzZMYlN3RWJqa2RBVmlCSEpqQlBHYXNL?=
 =?gb2312?B?WWdVZW1kOFd0NlRTc0ZtdGtTdlZOOXlXdUdOazFCTlZ3aWRXQk1NYms5VGYz?=
 =?gb2312?B?K1ZBNGRmSm5rT25DQnZKYjRacE11eVdoak1PTmwwbWE3b09KMDh4QzZJTFNG?=
 =?gb2312?B?SFE5UisxRUp0TnlQd0xmZkdTUVlDQk83RzkzUWlySE15b2hKM1ZGUmh1eE1q?=
 =?gb2312?B?QVVxQ2loOUlJclJFOGgzVzFmM0hCM2RCUXUvWVhOUlY2Skc3dW83QU5tN041?=
 =?gb2312?B?NmNiUHFFUVpIY3dJaElncmdnMFlCVHNkSm1mMDlmdjhBdWRROWQ5L0xZcG81?=
 =?gb2312?B?K0p4eG5kQ3hGcld2azZOeWRyamRqQ3RCK0orUWtaa3NYQmRUbFVrZkNvVjc2?=
 =?gb2312?B?endNalZYelFKWURHTU9PZWFTSDk5ajNJMTRLN3FVaHcrU21rWWliMENvNWJj?=
 =?gb2312?B?OXFaTDdhUUYrbktmMHdCTEcxc2NRaVVIVkM3MVFNVTkzOFZIYkVjMFFUUFNY?=
 =?gb2312?B?eG5CeFAwRU5tNEd5Z24yQWlDZ1dUamJYdlFQMU94RTMxNUpibTdiNXhpM291?=
 =?gb2312?B?aGh3V2RLWHZ5VW9uQlJLZmJOWEZ4Z0MvREE3TzJpNnUxTm5wTloyL1Awb1Zs?=
 =?gb2312?B?RnQ2TlVzSUZ4S3ZuaVFvbkJlNzNmVUY2M3NHRWtKK1M4U0xOSGlvSitaMkE2?=
 =?gb2312?B?VFF1dXhpaEd1NmhIR2RmbjVINDVzUDlCK0IwY0lrdUlHTkRORHExZE02Uklq?=
 =?gb2312?B?N3pta3JZVVlOWFJzUjlGczBSNFpicDRIUUxwV0RYZ3lhYlZVWTFQQ2hucWJk?=
 =?gb2312?B?bHZCaFo1WHdFYXJIeUJCT1VoZUl4S09ZOXBqQXV5SGZ1dnBtWDRicjZua2hN?=
 =?gb2312?Q?EVrDizNAQDhsk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb71b87-5cb6-43bb-dc7e-08d8b6e4d3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 10:28:39.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnkIYDBbNwFAtZC+NzUc8XJYJcCGfgwKWxNSHrMwMx06P/akD45YeM0pTsaVac3OvKNAsN/+n+Cl3ic382nnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1649
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogWGlhb2ppYW4gRHUgPHhpYW9qaWFuLmR1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4N
ClNlbnQ6IDIwMjHE6jHUwjEyyNUgMTg6MjUNClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5E
dUBhbWQuY29tPjsgSG91LCBYaWFvbWVuZyAoTWF0dGhldykgPFhpYW9tZW5nLkhvdUBhbWQuY29t
PjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdA
YW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9wbTogZml4IHRoZSByZXR1cm4gdmFs
dWUgb2YgcG0gbWVzc2FnZQ0KDQowIHNob3VsZCBiZSByaWdodCBkcml2ZXIgcmV0dXJuIHZhbHVl
LCAweDEgaXMgdGhlIHJpZ2h0IGZpcm13YXJlIHJldHVybiB2YWx1ZS4gU28gc3dpdGNoIHRvIDAg
YXQgbGFzdC4NCg0KU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jIHwgMSArDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211X2Ntbi5jDQppbmRleCBkN2Q4NmZkNzllMWYuLjQxZDVjNjVhMmYyMSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KQEAgLTE0OSw2ICsxNDksNyBAQCBpbnQgc211
X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCiBp
ZiAocmVhZF9hcmcpDQogc211X2Ntbl9yZWFkX2FyZyhzbXUsIHJlYWRfYXJnKTsNCg0KK3JldCA9
IDA7IC8qIDAgYXMgZHJpdmVyIHJldHVybiB2YWx1ZSAqLw0KIG91dDoNCiBtdXRleF91bmxvY2so
JnNtdS0+bWVzc2FnZV9sb2NrKTsNCiByZXR1cm4gcmV0Ow0KLS0NCjIuMjUuMQ0KDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
