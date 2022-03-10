Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48995C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 11:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50A010EEBF;
	Thu, 10 Mar 2022 11:19:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D8010EEBA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 11:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV6Ro2f87zcsOwcX/XDWm1Iewh8+E8Tvn+SZ5ISBBwvS5msCr2b5gaWi3nZCxD4Q4ndTXRqay332+VKeFkCc8tV1iMcMa1myu1gVz/kEb4BKzTDRut0WyE40bIE0Hz7prWXxBGcx9JCJIbEPbJeKcSOoMrFyjFInjH5uq7ygjYbU80yqRr+ooyRANTlOxECjGyFQJ0TluqQDkWT/Q6ndrxcSYykaqsOgQonL8Di1puOP5vX8XW3ZSeYnmBeqbEe7ZsnlrRUcNQzbP1/0O+wYKyHfBG+qnAUnTsXRCv2m1JDHsyUxoercRP57Hvt5bGX6XSxY9i4pqP40Zml13o9OQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCT1HFsO2UdS9EQ235BzUyDk8BAKR2/21/1fBRZPMqM=;
 b=RFqlPQzVZns2a3fkXJrwk7ZW2jP75ZG8skMCsP80e1Sh67BRJD9GdjLsE+hBBIDtxZp0dB8wz4dSsK7SZsfz20oiwthJcYewgAQOXOGi9QOxJ0+HTZ/HMC6npwJfOwi9T5Zdqau191nV8TVYko2xVWmU92dgOj9hROLS1FM0/GsZ520Rf4gDovlrIgJXWBRXz63d1wyr+Lecabo21rodkauibbOUUmZFc9G3JLIxc/eYe73UYP1KxfpSGmp3UnsyZeF+TN6NXCZkNqJzYy7ioiCi7s2fecFu4zwgzB1N5HFEJNsOIiyyj5KE94W3nGaCEllXoS4nRanS9bOMgryXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCT1HFsO2UdS9EQ235BzUyDk8BAKR2/21/1fBRZPMqM=;
 b=z2e8mZVFNptc7uomvI5qC00c5kwkyNTmBgjWbEmLdnAO7AL2DPwDy/ylhfxgo+9RHGKuibyC/W1LEYR4xV1XKa2w+3RiyFeJEcga8jgZBkh4fojU6iRosNFR+yLAu3qngVoCJrNpH7yeI8hh4g3iw8GclsRyCGvjsjc6z+GR2zM=
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 11:19:26 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::98c1:8aaf:3e7a:c047]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::98c1:8aaf:3e7a:c047%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 11:19:25 +0000
From: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Topic: [PATCH] amdgpu/pm: Don't show `smartshift_*_power` files for APUs
Thread-Index: AQHYNAIz8gXcIFS5FkaCK/x4eZebDqy4F0IAgABbuTA=
Date: Thu, 10 Mar 2022 11:19:25 +0000
Message-ID: <CY4PR12MB19436AA4A2EDF04562418F309D0B9@CY4PR12MB1943.namprd12.prod.outlook.com>
References: <20220309220548.2541074-1-mario.limonciello@amd.com>
 <237ec5cb-44e3-0f94-c439-9b6742e7740b@amd.com>
In-Reply-To: <237ec5cb-44e3-0f94-c439-9b6742e7740b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T10:56:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7bee2aa0-f89b-457f-99da-f48f89ac040d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-10T11:19:23Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 114c7c70-a065-4e57-a74e-4e8392717d69
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f729ccdf-ea92-4fe9-c0ed-08da0287d5e0
x-ms-traffictypediagnostic: MN2PR12MB3551:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3551847FFEDA39E97DD0412E9D0B9@MN2PR12MB3551.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHoMVoH2PkBxW8OXwz1eVrWTnC18DtZUvaJf003NOJidgdMYaJbcfIjsBjWfAvOv9bA5J68Jd4uuSACcGfUf70u3R487a3GQoUVrt/PMcvCi3cemusWgXDEu5R11AATv9kZjMf3uEXw8YsWZ7W9/l31whjKnjoyCEPKqG2mg48jpEIPWXE7KnnBkrgV9m/aNVGYgXXHSq3H5oELssdNs/OD/S4fuIam+7/ZtBg1p+CfTaHAf8lNC3CMnpeexe+JCxiG5pI0VOHNX9IdVboMIndquqCOahN7nWV2HhmyjGmdMmIlBwHPIt+KlEkesO5VPduoRHRllqA5es3iAyL0dt7VVi8M/+C/aen9k9PwxNiFB+uIeIwEkVRN1r7ScjNO51vbVkbdN+sbgLCm0Z9nrQU88qTnHDlIo7M4Obtmzg+EjjBHy3MyVgYB0Amx7lpRMci0NKEJXluBcQSA80riBa5rVCCzU5zAivPQWV+pR/DlzYTosqqNa5xxigQeQJTAUCY2Z/SR0B0tjzg5N85rrFmdFS7VDDX0THQ1lARVCzv6gqPyuqQGAclvm/E19cx017TAX7cAr8TtiJJIREWvPv9Q9jIl/G9FPVPHH42WZgfEOnULaQGCgUOjMYOkjHpHfdpjuwqnXooRGH8zHyyGWaQqMcIchfZDIehrr32jVuMOeSjjPW7BnjXnIR/ZQljQ+0zr+hvbnZERvmwl1hOPEu9020Icd6fQ1VAO4Wy0iUNo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(38100700002)(122000001)(66556008)(64756008)(9686003)(83380400001)(66446008)(66476007)(8676002)(66946007)(86362001)(508600001)(38070700005)(316002)(76116006)(71200400001)(5660300002)(55016003)(52536014)(8936002)(26005)(186003)(2906002)(53546011)(6506007)(7696005)(33656002)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmlSNGZhOU81aUUvLzl3YVZOMjFvNnEwSVBSeVVFMDZ2S3J2K2xkZlE4UG1o?=
 =?utf-8?B?SHA0VGVaVHdUejRBSnZ0R0hnUG5HVWxTcEdOM0dhQmt2bzlyWWVkMFJQOCsw?=
 =?utf-8?B?djNWQksybTF2MTJMMEdyUlZRZmRpM1NkYzNpZWVQZzU2NDJ1K3BicFNLQ01w?=
 =?utf-8?B?enZ1ZDdmTjRWSW80U3N2eTZaNkVQampsNTVrODdkMjJNQjh1ZmZWR21tcnRw?=
 =?utf-8?B?L3I1TWZ3VTVkVXZmNStRcXpEbzFBeTUybTk3ZkpJKzREeE5TR3hkV3cyZkR0?=
 =?utf-8?B?Zk5yZzVQbEx1T0pzeEswRHVtL0tMc1UzTE1WYUM5SFVLUjUvelFmVXhmNmNF?=
 =?utf-8?B?MGlKNjU0ampXd2dWNWJrazBaRGppRGV5SGJ0WFhXMmNyVmR4Y0lBaFp2T1RT?=
 =?utf-8?B?REEwOFJCL3BKNVAvMHVHZUNZd2IwbFlCbFlDZmc3cDBRajVkM1NjSmRzOG9n?=
 =?utf-8?B?SnBHanZoQXR5ak05QUJUUStaci9JTUN5cHBtK3JRalV0bFkzNmFZelpmYW1H?=
 =?utf-8?B?T0J1NFBsYVhNYkpYS3JjMjQ0ci8yNzcxb1NGT2tSUmVZaXlWZlN6T0RNMk5r?=
 =?utf-8?B?RlppeXhBTURKa3R5OWpYSFR6YjZXSGEwVXArWkVtdWJ1S1hkei81ZXVQbnFt?=
 =?utf-8?B?SlZ6bjY1RmVMa1l4VlBPbGYra05hTnFnMnVWQkczL0NMNDV0MVQ2dUQ5eHkr?=
 =?utf-8?B?Y0p6UkVQQVFpTGdXWmNDTG9yTlFwWTQzUzFxd0VrcU9GR3c0NjliLzdhNVVD?=
 =?utf-8?B?S3BvY2pMbGppNWQvellrZzJpU0E4MFY4NUJ3NVVka0ovUEh1NVdIS1VUOEg3?=
 =?utf-8?B?Q0RRR2lqY1A3Tk96eEVONmxDSHVOS21neTBMTU1Kc1pmc05kL0VPTVJjcHFs?=
 =?utf-8?B?S3Y1MFJ5MDc3Q0pOMzhhcktsRlc0ZUMzVERhWTI5MU9aeXlNNzQ0cWNEekpV?=
 =?utf-8?B?TWdFT1BMblNzc2NMRCtXa2QxTFljR1U2VzVNVDE4TFV3bEZUaEVXdTJDSVNY?=
 =?utf-8?B?WDd3VGtsL2loMi9YZWtBek95Y1hXazZkSDZ2b251VGZpdUtHKzVkK1hPdlJG?=
 =?utf-8?B?NWpJRUZubTBkaTZnalFOcU5pZTd1YUVDNVJQMEMyTjJJbFBvZ3ZBN3UwTUdB?=
 =?utf-8?B?ZjcxSVMwa0Fvdmw4TG5EQStuTDlDWGRsMWFmTkFHUThZNSt5amdUUFhCaVJo?=
 =?utf-8?B?LzI1a1FPb2RtMjJkVzlZM2xRSklCOUpiMFBaTEk4MU9HejFzQm9GQmtMc09o?=
 =?utf-8?B?T1FETVYvQ3VSRmoydUluRENLSERiUG5jTmtDMWUvUE9DUjQxTU9mNnFPK2do?=
 =?utf-8?B?RUxTcXVmSDFFK2FGVTNIR2RGVk9OcEpna3JCWUthWWxhM2hqWUZ3UE1KZit5?=
 =?utf-8?B?Y0hraUwxTVl6clBkUHJrWmNxeFN1d0NPdUFIeEc4VzlTa0FpWkpuZXpFKzV3?=
 =?utf-8?B?WSt6UVBXVE9ZWm9iWCs1OEU3RU1OajUwNktmSzNXblV0Wk5zcjAxYTE4cmdr?=
 =?utf-8?B?TlVzZmRjVFR2dnFEWTQrSkdDVHRwRlU3WWRPZENPVmhsVWVyM3Q3d20zK3JW?=
 =?utf-8?B?aHpTNVpqWktBSUM2dnVTR3JhalVrQWF2Sm93UHFIdS9VR2hGczRZeGZMclRu?=
 =?utf-8?B?RTllaUFJemdqYkpaeURIUWd2bG9TSVFCKy9OWHA3K2t0QzhpVDBocWFYdzBE?=
 =?utf-8?B?U1NheHhRdFdIYVZHOHNUQUlncTJsamVyTTVhaDBZVmVQTnF5L2VTNjVDazdL?=
 =?utf-8?B?TEVoajR0bEM4ODgyb0tlNHV3MzhVZUpBRy9acllLMEl0N3JTdEhORTkyZktq?=
 =?utf-8?B?M0haOVBibWhVWnF6ZUlXbDQxNW51dXRPZmd1TlNDTzkrL1hGZXJqellnWHNP?=
 =?utf-8?B?SGdOVHltT05WSlk5c2xUY2RJN1Q5cUZka3o4NUlGSWdsR3ZIR0I4cEh3T0Y1?=
 =?utf-8?Q?+HE/QYol9hkfAEge/RnMhAnNibqwhWuD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f729ccdf-ea92-4fe9-c0ed-08da0287d5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 11:19:25.6901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYAfW0lZVIjCxPFq23pkEtj2BeHfvEHiPtSRzvF4ztnNCKKkIVaFPgUrSdhGr5wMp/40EibirptXpMY45Os0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhpcyB3aWxsIGZhaWwgdG8gY3JlYXRlIHRoZSBz
eXNmcyBhdHRyaWJ1dGVzIGZvciBTUzEuMC4NCg0KUmVnYXJkcywNClNhdGhpc2gNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMYXphciwgTGlqbw0KU2VudDogVGh1cnNk
YXksIE1hcmNoIDEwLCAyMDIyIDEwOjU4IEFNDQpUbzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJp
by5MaW1vbmNpZWxsb0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGFtZGdwdS9wbTogRG9uJ3Qgc2hvdyBgc21hcnRzaGlmdF8qX3Bv
d2VyYCBmaWxlcyBmb3IgQVBVcw0KDQoNCg0KT24gMy8xMC8yMDIyIDM6MzUgQU0sIE1hcmlvIExp
bW9uY2llbGxvIHdyb3RlOg0KPiBgc21hcnRzaGlmdF8qX3Bvd2VyYCBmaWxlcyBhcmUgc2hvd2lu
ZyB1cCBvbiBzb21lIE9FTSBwcm9ncmFtcyBvbiB0aGUgDQo+IEFQVSBpbnN0ZWFkIG9mIHRoZSBk
R1BVLg0KPiANCj4gQWRqdXN0IHRoZSBsb2dpYyB0byB0aGUgZnVuY3Rpb24gYHNzX3Bvd2VyX2F0
dHJfdXBkYXRlYCB0byBkZXRlY3QgDQo+IHdoZXRoZXIgb3Igbm90IHRoZSBhdHRyaWJ1dGVzIHNo
b3VsZCBiZSBleHBvcnRlZC4NCj4gDQo+IFRoZSBleGlzdGluZyBjaGVja3MgdGhhdCBhcmUgZHJv
cHBlZCBhcmUgYWxyZWFkeSBpbmNsdWRlZCBpbiANCj4gYGFtZGdwdV9kZXZpY2Vfc3VwcG9ydF9z
bWFydF9zaGlmdGAsIHNvIHRoaXMgY2FuIGJlIHNpbXBsaWZpZWQuDQo+IFRoaXMgY2F1c2VzIGF0
dHJpYnV0ZXMgdG8gbm90IGJlIHNob3duIG9uIEFQVXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyB8IDUgKy0tLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyANCj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+IGluZGV4IGNiYmJkNDA3OTI0OS4uY2NkMDY0OGM2Nzg5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gQEAgLTE4ODQsMTAgKzE4
ODQsNyBAQCBzdGF0aWMgaW50IHNzX3Bvd2VyX2F0dHJfdXBkYXRlKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAgIHsNCj4gICAJdWludDMyX3Qgc3Nf
cG93ZXIsIHNpemU7DQo+ICAgDQo+IC0JaWYgKCFhbWRncHVfYWNwaV9pc19wb3dlcl9zaGlmdF9j
b250cm9sX3N1cHBvcnRlZCgpKQ0KPiAtCQkqc3RhdGVzID0gQVRUUl9TVEFURV9VTlNVUFBPUlRF
RDsNCj4gLQllbHNlIGlmICgoYWRldi0+ZmxhZ3MgJiBBTURfSVNfUFgpICYmDQo+IC0JCSAhYW1k
Z3B1X2RldmljZV9zdXBwb3J0c19zbWFydF9zaGlmdChhZGV2X3RvX2RybShhZGV2KSkpDQo+ICsJ
aWYgKCFhbWRncHVfZGV2aWNlX3N1cHBvcnRzX3NtYXJ0X3NoaWZ0KGFkZXZfdG9fZHJtKGFkZXYp
KSkNCj4gICAJCSpzdGF0ZXMgPSBBVFRSX1NUQVRFX1VOU1VQUE9SVEVEOw0KDQpTUyAxLjAgYXR0
cmlidXRlcyBhcmUgc3VwcG9ydGVkIG9uIEFQVSBkZXZpY2VzLiBXaWxsIHRoaXMgd29yayBvbiB0
aG9zZT8NCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICAgCWVsc2UgaWYgKGFtZGdwdV9kcG1fcmVhZF9z
ZW5zb3IoYWRldiwgQU1ER1BVX1BQX1NFTlNPUl9TU19BUFVfU0hBUkUsDQo+ICAgCQkgKHZvaWQg
Kikmc3NfcG93ZXIsICZzaXplKSkNCj4gDQo=
