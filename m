Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848EC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB3661139
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB3661139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642836EA12;
	Thu, 15 Apr 2021 09:12:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BBEB6EA12
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 09:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYKsVfO3RNbHbetf29b3KA9FDFGTZtikuLV71fdlg6Hizb8qnriDGMLpwYGMonNlLR61Bq9HDwn0FUeIzczkA5zZm2P2jcnJIKrqI/Gzu1es1kNZ2aSF6osCY6AEqnVMiN+EqNIpJ7pWvGBFBZhXb+cPPFUJPfG9trZadWnu/ctj+cSYNwHLEwIpBVjN+M/mo+wBN/yHrVfwjjektqke+m/9FU4wiD+h58UKI8dNhii1PBmgwPzIMySQJoIAREPOLSxYGfdiC/v1H5rCmp4ma832mrgGX5906vU+wWqMVvVfJPrybYTRLoS8Luma/dFS/WFM2tOniJEGv8JD0wWvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swc5ssrH/ccLEJPYBmm7MdVZxK7t5PP+PdEbfHuqx4I=;
 b=Eh2iPck0fQWdK818JSo+HNIqT+MTl6BwsWqc/qgpEFLLuDT7g2IIAj86HsNy1yebaqVdH8lo7OrEtoBk2J5RhMOFmfqulF+0uedlBo4iH4iASfidMC5jXt4YgEEUeyZx9q2DBIPKMsbGs7DJq/66j5JUwgNfneShk8OsHJsVrfny45a2TCt/AToW8wFfm9ujonZNlnEJ+KHXTW2iFk5ehFHnHwoO41GNN8mNFxbvzKf3zmzt5g5NvrBv+fuwv402mIwAE0aZnGLodiyY4hfFcY5SGWAPfN+MvmDrD5QaxX/LTfEDRnQqIPx3+g+ZJkbFBdezvJYQ2bD+wH/XhANJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Swc5ssrH/ccLEJPYBmm7MdVZxK7t5PP+PdEbfHuqx4I=;
 b=tlIq/kB5PydAe6CDlIZ8Ip77NisK4BxNqTHfLXB0KK/nb3cL6fGHOm7P5GOVrYa5bFVWeTnPjDTJHfgW860abHhw3mSp6fNFF5YIAPk3tqJzMzaMEAFGe/M8fvbGWo7LQWbGlZU+8rav8o4HEOQqqMBia+tFSlzQiC/HxO/CAM0=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0104.namprd12.prod.outlook.com
 (2603:10b6:910:1d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 09:12:25 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 09:12:25 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped
 loading MEC2
Thread-Topic: [PATCH] drm/amdgpu: Copy MEC FW version to MEC2 if we skipped
 loading MEC2
Thread-Index: AQHXMYd5eGlOSO+uH0iEO7ziySwqFqq0ricAgACZkCA=
Date: Thu, 15 Apr 2021 09:12:25 +0000
Message-ID: <CY4PR1201MB00722C570806A376A195CA63FB4D9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <20210414233933.266833-1-Joseph.Greathouse@amd.com>
 <2ac51104-b60c-0b7f-8cb8-74f6eda71e33@amd.com>
In-Reply-To: <2ac51104-b60c-0b7f-8cb8-74f6eda71e33@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-15T09:12:21Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b646b2f3-4639-47c9-88e4-3864bc1d0fd1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1ed618e-0ed3-4587-6b1f-08d8ffee95d8
x-ms-traffictypediagnostic: CY4PR1201MB0104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0104F87E73CA7433F47C66ECFB4D9@CY4PR1201MB0104.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7qCKqG6LS7bWwHG+32lnNDg4W6lUqNQ8o+7qzcQBxfh/0kO4CEZhkFXJAXsgOFllqTVHM1Gs7Uiv5BFqXdQ5WZ/hQZ3EhFtRA9YAaYGyUPeQTG/R0x32Fbbj3Bj0Kvzuz+mKbbmcd2Ba8fHlPkIml7dIz1tHCLXWux3a8Y0plB1MHYOw2oIGDLmtj9gqyA3c0NURYl1XVr/6dBKJx0Z15ZzAnXTlhl8SaHxTYxfjDyNbiM9/Ktsoh4BehHkAwTdLC+RzyCMB07cvAPU/wTaCJozvVYJHGIUgjwBr5+97MMDgwefw5oEnFH5HVeYbVsO38OUmYMVVqAb0CciCd6VCOClBRaNOrRdlMjeevPAouxV/alclmzLVc9ZiSeUdp8g+SBkStZkMoNVgIu4V1WPL17KG8LnIsf7XzVnPS7//MrCfTHgYUeOxZDCvgwjeqCVJWx19OWzvTxRNLtfOtEiTY54D641VjqtWaLR0djQ+KXI8XZL2wEOjCdv9KCfTCKPpNS1c1d5r/n7F01fawr3UJ+vMVp9g6kTM7oeS3cms7FrP432/y2rzcwXMTHIrDnPxgQjn34rnMr5g/cP88W507xCxbg7xzwuE6XmhYoFMxY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(478600001)(33656002)(5660300002)(53546011)(6506007)(110136005)(316002)(7696005)(186003)(66476007)(64756008)(55016002)(66556008)(8936002)(66446008)(38100700002)(76116006)(52536014)(2906002)(26005)(66946007)(122000001)(8676002)(86362001)(9686003)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RWlBMHJaY1B0UDVaUWZhYU5sQmIrcHd4VmlXYXUxdmJoN0g5RkhWdDhCbE9C?=
 =?utf-8?B?V3hiMkRtSHRscUFPVW9kWmsvcXlEWUlRUHhENzdMMStZUFp6ZThYek1kSHVW?=
 =?utf-8?B?bGRMUTJsbkVGOGxqY1U0MVpsdzNKejEzY0ludkZIcWJuK2o4cjEyWTZZek5V?=
 =?utf-8?B?SFp5UjErRDc4ZzAyK21hWDR5aFJFZzFRTTVBU1EvM01VT0hyNDU3VGVUYWRl?=
 =?utf-8?B?Vk9OcGZhK3FKczBDekdRdXBxZTk1L3ZGUE96bUNHd1ZvRU5sQ2NzYW5JOGt1?=
 =?utf-8?B?RzlGQzFJNS9NanpzZ2hEM3hXMGg2RGhNaURWTG1BQUFkS1RtSm1QT01WVlRm?=
 =?utf-8?B?a0RBdzVobmFRTUgvMXY5bmQwVFV2N3RzWUpIWkFSK0VwMkhrd2xNaGUxdENE?=
 =?utf-8?B?YTcybVJzVldNWFUvWTI5K3M3cjBIUDBqSGxIWGJQNXlJVXFQbVFkNUM1OG1Y?=
 =?utf-8?B?NkdiNGJlcHZPZVQxODBaSmZxUThlTnFoRHMyYmM3Sk56TnhqUUJOZHpha1Ay?=
 =?utf-8?B?ZXZsR2k3QUo5aGViSUZUd0FnS01DaXAwK29tV2ZsMUZVU21ndUF1Mm42YTg3?=
 =?utf-8?B?Zk0zT0VoWVUzRmRNYVNxNDVWazltK1g0RzFVR2NldFJHVDdoUWZLUk9pVmdw?=
 =?utf-8?B?cmUraktZTlY2SUhKT2tybllmNXByK0loOFVFbkprNlhRZzJyeUo2MURiRlVw?=
 =?utf-8?B?ajNZVGR0SlVVdmZzWTJ4WG84aWJHYnRzYTFyY2pQdjNmRjExbTBKek9ZaThz?=
 =?utf-8?B?bVRsQ0FrWi8vdjZHWE1MMjZ2bzcvV1FRb1ZlSld4UTJpakpIcEZ5M2NPclBs?=
 =?utf-8?B?MjJWZkZZOUFENS9iR0x4OGdyTGhqcXBVN1d1bmI5cUZhTFg4dW1uQ0hJYlBp?=
 =?utf-8?B?SWtZYmpLelJubmdDaDEwN2hCWlJXQmVNSE9MSjFvaVRQVzVqbUlkejJsWDNv?=
 =?utf-8?B?UGt0NXZlTVpzckpMaU1sOWFLNm5aRTRkWWprL0hoU2p3dDJ2cGpJSUFxRjZo?=
 =?utf-8?B?MGJvSmdhUWRNK3RiTENpbzFtUnMzNWVIY0ZQODhBdldUeU40a1UzejNTbG14?=
 =?utf-8?B?TCtneHI5Q3N5WXl4czUwd0dXOXh6RVNrTThUNCs0ZVZuUmVBK0RlQzBURTFS?=
 =?utf-8?B?a0RPVmhla2JwQjcvOTNCbVZPeDFvbVV1UmZVVmVyeFptREFtbWRSZXo2Q0VS?=
 =?utf-8?B?dThUeVZIeEFLWE81N2RuZ0R3Qlp6eGs1dXFURGIrQjE1WG5jbGMvZUZkRiti?=
 =?utf-8?B?Qnl1REJkMTI4Z1dGbndqRDQ2RHY2c3VjQnNYQ0F2WE5JNm90WDZmRWVja25C?=
 =?utf-8?B?TXFLa3p0TGgwcTNXZG55MkJMOUhpeWx1TnEzNzk1YjBBUkpSQ3JlL1RyR2Fn?=
 =?utf-8?B?TmhiQjRPNGdDeEJnS0RsbXo2NEdQSEFsanBVODZXdnAwMCtoZ0docGg0NDUz?=
 =?utf-8?B?Wnd6WmtSaVVpUVNtVE1VUC9HWGNrQVArY3AycFh4Y3YrMzlOOXVkcXFRQTYy?=
 =?utf-8?B?UjloKzFtWkZXT1F4czVMMG1lTXpGRlNXTXN1QTVqZS9CQjdwWVNqaUJUV1Vn?=
 =?utf-8?B?bnZJRnR6TE53STBDRDNpQmJSK015Wmd0TWVILzNpeUZrYkFJcnpnMVhUQUpC?=
 =?utf-8?B?dkpLZ2V5b2ZsS0FKNTc0amtwZDkreXhZNi9jL01EeXM1SVFtU0ZLTUhUMHFP?=
 =?utf-8?B?cTBQK2pJK3pEMExJUGdiblZjYXpOMERSczFNZ01ycVFJMXplbjcwMGdWQXJa?=
 =?utf-8?Q?cVoLNssuKDn1Dw9BNN8ll/DKvMoRDYIinHFVHJJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ed618e-0ed3-4587-6b1f-08d8ffee95d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 09:12:25.3203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bayQD80toDTYLtOtYPjt9pdULe1HN2nM2QqOVDExCPCtn75gQxrC1qMKEKfumzTHrEz3eHyI8Oef6LLl51Wk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0104
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGlzIGxvb2tzIGdvb2QgdG8gbWUsIEkgYXBvbG9naXplIGZvciBpbnRyb2R1Y2luZyB0aGlzIGlz
c3VlLg0KSSBzZWUgdGhlIHBhdGNoIGhhcyBhbHJlYWR5IGJlZW4gc3VibWl0dGVkIHRvIGFtZC1z
dGFnaW5nLWRybS1uZXh0Lg0KDQpNeSBvbmx5IGNvbmNlcm4gd291bGQgYmUgaXMgdGhhdCBNRUMy
IEZXIHZlcnNpb24gbWlnaHQgc3RpbGwgZmFpbCB0byByZXBvcnQgaW4gdGhlIGZpcm13YXJlX2lu
Zm8gZGVidWdmcy4NCkkgYmVsaWV2ZSB0aGUgY2hlY2sgZm9yIGFkZXYtPmdmeC5tZWMyX2Z3IHdp
bGwgZmFpbCBiZWZvcmUgcXVlcnlpbmcgZm9yIHRoZSB2ZXJzaW9uLg0KVGhlIElPQ1RMIEZXIHF1
ZXJ5IGludGVyZmFjZSBsb29rcyBsaWtlIGl0IHdpbGwgd29yayBpZiB0aGF04oCZcyB0aGUgbWVj
aGFuaXNtIHRoZSBhcHAgaXMgdXNpbmcuDQoNCk90aGVyIHRoZW4gdGhhdCwgSSBiZWxpZXZlIHRo
ZXJlIGlzIG5vIHBvdGVudGlhbCBzaWRlIGVmZmVjdHMgb2YgdGhpcyBjaGFuZ2UuDQoNClRoYW5r
IHlvdSwNCkpvaG4gQ2xlbWVudHMgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogVGh1cnNk
YXksIEFwcmlsIDE1LCAyMDIxIDc6NDggQU0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHU6IENvcHkgTUVDIEZXIHZlcnNpb24gdG8gTUVDMiBpZiB3ZSBz
a2lwcGVkIGxvYWRpbmcgTUVDMg0KDQpBbSAyMDIxLTA0LTE0IHVtIDc6MzkgcC5tLiBzY2hyaWVi
IEpvc2VwaCBHcmVhdGhvdXNlOg0KPiBJZiB3ZSBza2lwcGVkIGxvYWRpbmcgTUVDMiBmaXJtd2Fy
ZSBzZXBhcmF0ZWx5IGZyb20gTUVDLCB0aGVuDQo+IE1FQzIgd2lsbCBiZSBydW5uaW5nIHRoZSBz
YW1lIGZpcm13YXJlIGltYWdlLiBDb3B5IHRoZSBNRUMgdmVyc2lvbiBhbmQgDQo+IGZlYXR1cmUg
bnVtYmVycyBpbnRvIE1FQzIgdmVyc2lvbiBhbmQgZmVhdHVyZSBudW1iZXJzLiBUaGlzIGlzIG5l
ZWRlZCANCj4gZm9yIHRoaW5ncyBsaWtlIEdXUyBzdXBwb3J0LCB3aGVyZSB3ZSByZWx5IG9uIGtu
b3dpbmcgd2hhdCB2ZXJzaW9uIG9mIA0KPiBmaXJtd2FyZSBpcyBydW5uaW5nIG9uIE1FQzIuIExl
YXZpbmcgdGhlc2UgTUVDMiBlbnRyaWVzIGJsYW5rIGJyZWFrcyANCj4gb3VyIGFiaWxpdHkgdG8g
dmVyc2lvbi1jaGVjayBlbmFibGVzIGFuZCB3b3JrYXJvdW5kcy4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogSm9zZXBoIEdyZWF0aG91c2UgPEpvc2VwaC5HcmVhdGhvdXNlQGFtZC5jb20+DQo+IENoYW5n
ZS1JZDogSWQ2ZjY3MmZjNjk0NTJhYmQ2ZmY0MTgyMWE1ZjIyNDAwMzcwNDhhNmYNCg0KVGhlIHBh
dGNoIGxvb2tzIGdvb2QgdG8gbWUuIEknZCB3YWl0IGZvciBKb2huIHRvIGFwcHJvdmUgaXQgYXMg
d2VsbC4NCg0KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPg0KDQpKb2huLCBpZiB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byB5b3UsIHBsZWFzZSBmZWVs
IGZyZWUgdG8gYXBwbHkgaXQgdG8gYW1kLXN0YWdpbmctZHJtLW5leHQgaW4geW91ciB0aW1lIHpv
bmUuIFdlJ3JlIGluIGEgaHVycnkgYmVjYXVzZSB0aGlzIGZpeCBpcyBuZWVkZWQgaW4gdGhlIG5l
eHQgUk9DbSByZWxlYXNlLiBJZiB5b3UgYmVsaWV2ZSByZXBvcnRpbmcgYSBmYWtlDQpNRUMyIHZl
cnNpb24gd291bGQgY2F1c2UgcHJvYmxlbXMgZm9yIGdyYXBoaWNzLCBhbiBhbHRlcm5hdGl2ZSBm
aXggd291bGQgYmUgdG8gY2hhbmdlIGtmZF9nd3NfaW5pdCB0byBjaGVjayB0aGUgbWVjX2Z3X3Zl
cnNpb24gb24gQXJjdHVydXMuDQoNClJlZ2FyZHMsDQrCoCBGZWxpeA0KDQoNCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMyArKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYw0KPiBpbmRleCAwNjgxMWExZjQ2MjUuLmEwNzhhMzhjMmNlZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+IEBAIC0xNTg3LDYgKzE1ODcsOSBA
QCBzdGF0aWMgaW50IGdmeF92OV8wX2luaXRfY3BfY29tcHV0ZV9taWNyb2NvZGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAJCQllcnIgPSAwOw0KPiAgCQkJYWRldi0+Z2Z4Lm1lYzJf
ZncgPSBOVUxMOw0KPiAgCQl9DQo+ICsJfSBlbHNlIHsNCj4gKwkJYWRldi0+Z2Z4Lm1lYzJfZndf
dmVyc2lvbiA9IGFkZXYtPmdmeC5tZWNfZndfdmVyc2lvbjsNCj4gKwkJYWRldi0+Z2Z4Lm1lYzJf
ZmVhdHVyZV92ZXJzaW9uID0gYWRldi0+Z2Z4Lm1lY19mZWF0dXJlX3ZlcnNpb247DQo+ICAJfQ0K
PiAgDQo+ICAJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PSBBTURHUFVfRldfTE9BRF9Q
U1ApIHsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
