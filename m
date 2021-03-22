Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71CC433E5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 14:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3215861990
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 14:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3215861990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44C26E4A7;
	Mon, 22 Mar 2021 14:03:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CFB6E4A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 14:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjGM9Z++RAMXxAP/z2ZdIqUhGeFvVgSo84BiKwhij1VrOlCLDYn0faaCl+YpfCgKZvnlJVCbDfCr4DdQ4Z/IQq4OPErltmHJgEI+56UjAS+CIZ+0DKQoWtXn37GjKhGztrPzLvvw+dcQYjIMKgHTOMXcGBkoAuPcAuNvk5DUYd8BpBgeKbXqagix5KWbU4OpuER2qGOr8MUb4lukYPjsvQXPXzz2wTH/KiGQgAe04AZ/Xy1QaryYbYnZv9NnT0iaDTzPGg5yHcHK036aQOuCem6BhVCSS7Sd1VM/7TC3ExjC0mVNwZkUsANRGMm6oWDqsQD+VV4rmAoIYDteHaSCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iYhL/YMjzcUouppBxAKoqFnpvTSZiyPptRFJzsDAq8=;
 b=nbWvOnpSNVhlpPMjzF/VIw0Li9lNoxAkNkHP2kn4jNeClbtEgYoif56Fx8do5jCwulo32uDFhycu4OpgiSxEj6b/RxdoN1u6gufiFdTAOUjZoewZoZlwACSxxPGbeTPM5loKV5vf/hNeToEE/CijAPhkRI/Pk01SIRcvlUj9Inx4DDz+EH/3iK+7ixZhEVpnXI5PL1rylZ1B2FHQO4UGEBPXb1AtEAUnehiqtpsWctNDTuU5llZpkIPlvVwVUX9Nu3ORMS8OCgnbTPpTrpYi7h4cRVADCAhuyQz/IDUW+I6597Ob3o5eEz6PIkybrQDzp8mVBN6t8lWN9FnHjOUIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iYhL/YMjzcUouppBxAKoqFnpvTSZiyPptRFJzsDAq8=;
 b=Ufu4K8wgvVOrRl9jQOM4WbmGeYznQAM605e03RpvK6xefEHCejZJ4BJVQeYy4osiWrmVohIWZmnBGFFm+FvRTBacTHdLWRCBZiU08nlZceLNvjnJJOm7ZPyMvPBg1MmF2kA8b0TjZDL0nvxCFjyBbmcXCaQMBrUMfOZ/tTFINTg=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Mon, 22 Mar 2021 14:03:11 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 14:03:11 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Introduce new SETUP_TMR interface
Thread-Index: AQHXF4YfqrtedAgVh0mkPqVrRWPevqqP1hWA
Date: Mon, 22 Mar 2021 14:03:11 +0000
Message-ID: <0FD452A0-140A-40CF-A6F6-93F775FBADB2@amd.com>
References: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
 <1615584275-16432-2-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1615584275-16432-2-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=33799fc3-d6f8-484e-930f-ec1563e0a85a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-22T13:51:48Z; 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [70.51.69.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d581822e-5251-4849-4dc0-08d8ed3b3acb
x-ms-traffictypediagnostic: DM5PR12MB1130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11309399D4B93AD53D69B91780659@DM5PR12MB1130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nY8B6Mi16p6do/g2qzHBD/ezYQThF6iamATqKxmLZ3fewLSj1V2NCMG8CEkbPLRAKqS2HbGh7D7cA/q00hxiPW/1L30P9unNhVfvjekqnu0jZIDX6k4kTG7JC+lfTCA+8SZ4QKypdlnYTU20Z428LLEOaEns7YYNyKzJIHjDCoSxQhYu+xgeu3IxWZqM7IzUOlM3OWjmNX1mz3QnrSsygaqDgLpuLzXW0hl3GGnUIysbKqAVIvM7X1NJ4N3whtmCgxZTN0FdcEY7Yy89XApmK+CtwfciC6Q6wrU+0LDdiGWIV5qXLjHDtuYbccFozeGo9NNbJXpRxSZ1CEUxKXqSKEnVm3Al2Uid/6419mAynESjg7K1c7q0vBQOjpAT7C2iHrBL1t+CgK2exUocY0M7QOiV6WOAC1uHTLw5LK8Y2WXXqplL1j8IH+AVZpbbp10hItHOW0QTI6BbkOnQ85ECw7ajDdZtk2CgfVbQRvZwUqaAaGa73wWIpEud9Z5HeYMLQ7gBvx1qknaVuLHQ57RWkwDcd9rccgSQ51cwwqylakEkqd1ugJ+mCyBDS0KBf0aGrjZLe2R+YHXKIhvIjD1ZExMrPSzgPzS0tKCKvX6Bro4/dg1+ntVfvFgRyDPGPEuvljuiAKk/cS7MK1x1/LKf2NDtsCE22miVjP5ehhxmZR/qa+uFoPdIhXqCvDwTI+4W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(86362001)(316002)(8676002)(71200400001)(2906002)(36756003)(38100700001)(6486002)(4326008)(91956017)(5660300002)(2616005)(6916009)(83380400001)(186003)(6506007)(33656002)(478600001)(54906003)(76116006)(8936002)(26005)(6512007)(66556008)(66946007)(66446008)(66476007)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?QWwzVUc5Nk8wKzdacVZaUjJVaGFhYkpwQnAzby9keVRzZ0FLMm02c3JWamZt?=
 =?utf-8?B?TkVZdWJRWW14SmlMT0lJcnExTHBGcHF2QXdBUW16UG5uenNWd3FVVk5yU0ZV?=
 =?utf-8?B?RlJDRnFDcVZxbUlkVXVvZmVCZUdSbDBEYTh6bEdCTmhoR3F2UndJMHAxbmF6?=
 =?utf-8?B?RisrdXBLQTQ3cjRuVzZYT1VLMGpaRzdXS1d4ajdCWFhGMHdMSHdoOENYdWhq?=
 =?utf-8?B?YW1scFBHRHB4TXR0bVQ1VkNZRGpyNjd3VGl2VGdaQ3VVNXpVRWtpNCsrL2V5?=
 =?utf-8?B?b0VQcEsxRFdRSDlZMXhIeGVWT3dHdFdPb3J3Uk9jUWVyenNRa1RadjZCSnlC?=
 =?utf-8?B?MGtnSkNEYVJSb2tCeG9oRksxR0QvT0d5WmRRZlVIL0MvS2tHZjE2Z3BzdHln?=
 =?utf-8?B?K01jM0pKZldlWDZSa0JZeGMzNHlONWVZM0k1SWxrRUwxY0gvTHAxMXQ0WHFw?=
 =?utf-8?B?SmIxL0NhZzE4cm5KTEFOTGp3Q25wMXlMdWJPQ0hlSjJSdVVRc3R6cnFpbW40?=
 =?utf-8?B?NjE4bnFrbkJndk5EWFRkdkJwRG5aZi9VWE10aktrK0M1STZRNlNlS1FQeUdZ?=
 =?utf-8?B?M1QzS0svanN4ajRpYmkzSmp2VHBrTkFUWkcwL0RRYWVKWStTQW5wNlJ3MGRN?=
 =?utf-8?B?cFMwZ1ZEZG0zajJLREdVbm1LUE9PaHo5Z3JzNGV2SEpvUWZHU1BEakN6bmZE?=
 =?utf-8?B?QXhmNXZuN2dsbG02bFlIQS8rNGxMcVBqc3JUblppc1lLUFhBSG9zemxiN0c5?=
 =?utf-8?B?bE5iMTRHUTJLRTBYMmNiRDlpVnIxZWF4NERwQitjaTB6b0p6UFFHRm5UZnJE?=
 =?utf-8?B?bDB4L2Vwd29RM2hURjVydHZMQWNjZm9iTS8vVDJkMWQ4WFpTdGtyZmc1NnNZ?=
 =?utf-8?B?MHVEMTRoMmNhd2VKeFp0RnBnQk1DOVdkMHN2L1BYVTdvZW1LaUMxaFFLL1ox?=
 =?utf-8?B?SDlDQklwK281dGNPem1Sc2dabk0zSVNQNVFadUdZd3NWejR5ZktuUEw4bEZ3?=
 =?utf-8?B?ZE9mVXpDdnZqMkR0bTN2TUFHT2dodkZIYktpRHQxVGZmWC9nSytrODFGaUZH?=
 =?utf-8?B?bnlmblErR3hiZ1FDNlEyQUNXc0FFTTNSUUphQnl0ZC85NWlNNjNpNmd1UXRa?=
 =?utf-8?B?cmZQcGVHcHNnL1gvQnljY2NVZDhVVnFKc0wrTVB1TDRnNU5rM2NLUk9FTmNy?=
 =?utf-8?B?RVlIZCtOSmcydWNJazkxR05SdlBvWUpKMFRwZnBkWHRPNXBIb3psVkpoUlQr?=
 =?utf-8?B?QkNLaDExbjVNUEZYT1YrZ1pZR0ZpZnd4T1hmUmdjblMwb1pIWEVwWXkzMXV5?=
 =?utf-8?B?N2d0TkZmanVhRWtleDV0M2JoeHViVHRrZUJ2czhvcWdrYkxvckJOaWQyajF5?=
 =?utf-8?B?enFGZFpSR3k1RFpDUmFtNmdxc0JVbkZkUjBRNERGbXRPRFEyeG1OWkhuaExi?=
 =?utf-8?B?UWpyTnFCdXZkc2EwdjFOUTRBcW9rSEpjT2xyTGY3UW9UOW1BSlZpSmd6TmRQ?=
 =?utf-8?B?U2pCZGRCZ0czUE0yRVAzdysyRDhUdkM2N250M1hsbkI2dXRuZldqaGw5djhx?=
 =?utf-8?B?MENTN1FCZ3FSb1Uremo2RS92cDNwcDJQaUl5ZkFEYVcvZFp5RWlJRmNVYjRW?=
 =?utf-8?B?TVJVTXhXWDN2Nm9nVFhjWGhiNmJLdWMzSlg1ZG80VFpYTXpnZ21GMGpvelp3?=
 =?utf-8?B?MlUvZ2NFdVNERWpiQkdLL3NtQ2F3Z01jOE85WXFLMVRDNHVWclBjdW5rUGIx?=
 =?utf-8?Q?pUrs00tF7xyVUAeg+8u4qYqzxFvQ+yvZQynLm/+?=
Content-ID: <F5A8E0C74829664DB23563E719C52F03@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d581822e-5251-4849-4dc0-08d8ed3b3acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 14:03:11.7351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBsKcHzATN7OmIsKXDsKnpiWoe3jVLfSI+wygMLg0jonGPw3zewEoCBTXo8mrMui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpI
ZWxsbyBhbGwsDQoNCkNhbiBzb21lb25lIGhlbHAgdG8gcmV2aWV3IGJlbG93IHBhdGNoZXM/IFdl
IHZlcmlmaWVkIHdpdGggZmlybXdhcmUgdGVhbSBhbmQgd2FudCB0byBjaGVjay1pbiB0b2dldGhl
ciB3aXRoIHBzcCBmaXJtd2FyZQ0KDQpSZWdhcmRzLA0KT2FrDQoNCg0KDQrvu79PbiAyMDIxLTAz
LTEyLCA0OjI0IFBNLCAiWmVuZywgT2FrIiA8T2FrLlplbmdAYW1kLmNvbT4gd3JvdGU6DQoNCiAg
ICBUaGlzIG5ldyBpbnRlcmZhY2UgcGFzc2VzIGJvdGggdmlydHVhbCBhbmQgcGh5c2ljYWwgYWRk
cmVzcw0KICAgIHRvIFBTUC4gSXQgaXMgYmFja3dvcmQgY29tcGF0aWJsZSB3aXRoIG9sZCBpbnRl
cmZhY2UuDQoNCiAgICBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4N
CiAgICAtLS0NCiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIHwg
MTMgKysrKysrKysrKy0tLQ0KICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfZ2Z4
X2lmLmggfCAxMSArKysrKysrKysrLQ0KICAgICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3BzcC5jDQogICAgaW5kZXggY2QzZWRhOS4uOTllMWEzZSAxMDA2NDQNCiAgICAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCiAgICArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCiAgICBAQCAtMzI4LDggKzMyOCwxMyBA
QCBwc3BfY21kX3N1Ym1pdF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsDQoNCiAgICAgc3Rh
dGljIHZvaWQgcHNwX3ByZXBfdG1yX2NtZF9idWYoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsDQog
ICAgICBzdHJ1Y3QgcHNwX2dmeF9jbWRfcmVzcCAqY21kLA0KICAgIC0gdWludDY0X3QgdG1yX21j
LCB1aW50MzJfdCBzaXplKQ0KICAgICsgdWludDY0X3QgdG1yX21jLCBzdHJ1Y3QgYW1kZ3B1X2Jv
ICp0bXJfYm8pDQogICAgIHsNCiAgICArc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3At
PmFkZXY7DQogICAgK3VpbnQzMl90IHNpemUgPSBhbWRncHVfYm9fc2l6ZSh0bXJfYm8pOw0KICAg
ICt1aW50NjRfdCB0bXJfcGEgPSBhbWRncHVfYm9fZ3B1X29mZnNldCh0bXJfYm8pICsNCiAgICAr
YWRldi0+dm1fbWFuYWdlci52cmFtX2Jhc2Vfb2Zmc2V0IC0gYWRldi0+Z21jLnZyYW1fc3RhcnQ7
DQogICAgKw0KICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpDQogICAgIGNtZC0+
Y21kX2lkID0gR0ZYX0NNRF9JRF9TRVRVUF9WTVI7DQogICAgIGVsc2UNCiAgICBAQCAtMzM3LDYg
KzM0Miw5IEBAIHN0YXRpYyB2b2lkIHBzcF9wcmVwX3Rtcl9jbWRfYnVmKHN0cnVjdCBwc3BfY29u
dGV4dCAqcHNwLA0KICAgICBjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLmJ1Zl9waHlfYWRkcl9sbyA9
IGxvd2VyXzMyX2JpdHModG1yX21jKTsNCiAgICAgY21kLT5jbWQuY21kX3NldHVwX3Rtci5idWZf
cGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHRtcl9tYyk7DQogICAgIGNtZC0+Y21kLmNtZF9z
ZXR1cF90bXIuYnVmX3NpemUgPSBzaXplOw0KICAgICtjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLmJp
dGZpZWxkLnZpcnRfcGh5X2FkZHIgPSAxOw0KICAgICtjbWQtPmNtZC5jbWRfc2V0dXBfdG1yLnN5
c3RlbV9waHlfYWRkcl9sbyA9IGxvd2VyXzMyX2JpdHModG1yX3BhKTsNCiAgICArY21kLT5jbWQu
Y21kX3NldHVwX3Rtci5zeXN0ZW1fcGh5X2FkZHJfaGkgPSB1cHBlcl8zMl9iaXRzKHRtcl9wYSk7
DQogICAgIH0NCg0KICAgICBzdGF0aWMgdm9pZCBwc3BfcHJlcF9sb2FkX3RvY19jbWRfYnVmKHN0
cnVjdCBwc3BfZ2Z4X2NtZF9yZXNwICpjbWQsDQogICAgQEAgLTQ1Niw4ICs0NjQsNyBAQCBzdGF0
aWMgaW50IHBzcF90bXJfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkNCiAgICAgaWYgKCFj
bWQpDQogICAgIHJldHVybiAtRU5PTUVNOw0KDQogICAgLXBzcF9wcmVwX3Rtcl9jbWRfYnVmKHBz
cCwgY21kLCBwc3AtPnRtcl9tY19hZGRyLA0KICAgIC0gICAgIGFtZGdwdV9ib19zaXplKHBzcC0+
dG1yX2JvKSk7DQogICAgK3BzcF9wcmVwX3Rtcl9jbWRfYnVmKHBzcCwgY21kLCBwc3AtPnRtcl9t
Y19hZGRyLCBwc3AtPnRtcl9ibyk7DQogICAgIERSTV9JTkZPKCJyZXNlcnZlIDB4JWx4IGZyb20g
MHglbGx4IGZvciBQU1AgVE1SXG4iLA0KICAgICAgYW1kZ3B1X2JvX3NpemUocHNwLT50bXJfYm8p
LCBwc3AtPnRtcl9tY19hZGRyKTsNCg0KICAgIGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9wc3BfZ2Z4X2lmLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3Bf
Z2Z4X2lmLmgNCiAgICBpbmRleCBhNDFiMDU0Li42MDRhMWMxIDEwMDY0NA0KICAgIC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhfaWYuaA0KICAgICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3BzcF9nZnhfaWYuaA0KICAgIEBAIC0xNzAsMTAgKzE3MCwxOSBA
QCBzdHJ1Y3QgcHNwX2dmeF9jbWRfc2V0dXBfdG1yDQogICAgICAgICB1aW50MzJfdCAgICAgICAg
YnVmX3BoeV9hZGRyX2xvOyAgICAgICAvKiBiaXRzIFszMTowXSBvZiBHUFUgVmlydHVhbCBhZGRy
ZXNzIG9mIFRNUiBidWZmZXIgKG11c3QgYmUgNCBLQiBhbGlnbmVkKSAqLw0KICAgICAgICAgdWlu
dDMyX3QgICAgICAgIGJ1Zl9waHlfYWRkcl9oaTsgICAgICAgLyogYml0cyBbNjM6MzJdIG9mIEdQ
VSBWaXJ0dWFsIGFkZHJlc3Mgb2YgVE1SIGJ1ZmZlciAqLw0KICAgICAgICAgdWludDMyX3QgICAg
ICAgIGJ1Zl9zaXplOyAgICAgICAgICAgICAgLyogYnVmZmVyIHNpemUgaW4gYnl0ZXMgKG11c3Qg
YmUgbXVsdGlwbGUgb2YgNCBLQikgKi8NCiAgICArICAgIHVuaW9uIHsNCiAgICArc3RydWN0IHsN
CiAgICArdWludDMyX3Rzcmlvdl9lbmFibGVkOjE7IC8qIHdoZXRoZXIgdGhlIGRldmljZSBydW5z
IHVuZGVyIFNSLUlPViovDQogICAgK3VpbnQzMl90dmlydF9waHlfYWRkcjoxOyAvKiBkcml2ZXIg
cGFzc2VzIGJvdGggdmlydHVhbCBhbmQgcGh5c2ljYWwgYWRkcmVzcyB0byBQU1AqLw0KICAgICt1
aW50MzJfdHJlc2VydmVkOjMwOw0KICAgICt9IGJpdGZpZWxkOw0KICAgICt1aW50MzJfdCAgICAg
ICAgdG1yX2ZsYWdzOw0KICAgICsgICAgfTsNCiAgICArICAgIHVpbnQzMl90ICAgICAgICBzeXN0
ZW1fcGh5X2FkZHJfbG87ICAgICAgICAvKiBiaXRzIFszMTowXSBvZiBzeXN0ZW0gcGh5c2ljYWwg
YWRkcmVzcyBvZiBUTVIgYnVmZmVyIChtdXN0IGJlIDQgS0IgYWxpZ25lZCkgKi8NCiAgICArICAg
IHVpbnQzMl90ICAgICAgICBzeXN0ZW1fcGh5X2FkZHJfaGk7ICAgICAgICAvKiBiaXRzIFs2Mzoz
Ml0gb2Ygc3lzdGVtIHBoeXNpY2FsIGFkZHJlc3Mgb2YgVE1SIGJ1ZmZlciAqLw0KDQogICAgIH07
DQoNCiAgICAtDQogICAgIC8qIEZXIHR5cGVzIGZvciBHRlhfQ01EX0lEX0xPQURfSVBfRlcgY29t
bWFuZC4gTGltaXQgMzEuICovDQogICAgIGVudW0gcHNwX2dmeF9md190eXBlIHsNCiAgICAgR0ZY
X0ZXX1RZUEVfTk9ORSAgICAgICAgPSAwLCAgICAvKiAqLw0KICAgIC0tDQogICAgMi43LjQNCg0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
