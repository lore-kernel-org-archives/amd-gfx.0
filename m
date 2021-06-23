Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE7C2B9F4
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A388F6135A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A388F6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413896E057;
	Wed, 23 Jun 2021 02:04:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3138B6E057
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 02:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcdGE2fxxxOOfDOXAuOlQ4W74U/9hkXVZ4O2Udg14YTtke4ZWZLUvXTVtH7NooN/nvudzgMqvdqsfNsFdeRZOVjPJ/uqHXldfRBtCKzBBz9l+pcy7KmTf70jNNLwZIoAwWZOh1jyKnmxgXeOInMbJ4nMIVLBGzA9hMk8CeueuVtdxhaZKMT0kpP4sBk4Zc+IgEOzNlNKIwcAkargsQKairiPRNcH6IXMuuRgtpHHl/CBDmBC1La4T/juLUJFQBAI67vO4WrBMkCyivokoeJdtF7gtg23wj5xp8YUGSh61AT+7qQ1FjpDB9cUs/ljhsZkWzhcuI2WP6IhuRf2+pKKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR4DH27k6KXso3C6ByzjgLoP1ZUoqKSCn85fQ7zNYRE=;
 b=dvJ2SaD6xRqT9gjAHQOkd2+xfZeULGCd1MLnpZiB4R0koVrcxj3aNTKjIahWa92HjokteZUvTwgKWQI7pneAwEHgLhVVVV/bFTN/w/7QmOrlWU1eraFbTuoPjlezK8xtvssZjN0JCZ3gJXKYqtuAjj730V2rp37AiQVzFbcvbLKJtMPTIBbWo5YKkIwJB5lxMhYTeGLmpqCMf72jbt8IOLIla19Gfqu3CewoZ4+uNIUG9oJi6WQoBeYkx6ZqVthIS0YIKYvAXHDkAtwlXkg6mjk8YUb3FaLd4j/23iyt9x+H1cmUnBbXk/iN4/YMeSTz5PARXPlameLo8Aujwbhaig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR4DH27k6KXso3C6ByzjgLoP1ZUoqKSCn85fQ7zNYRE=;
 b=THRdfSxpC8NpwtonbglqVLY729SJmnhqTFEtoFaRImw4woEWQG6JnSuoSMKMe6pc6VBhjg+hCOHBYfvdNKyrMxH+KLzdncaKCmmkVEx+/3x3wCLWD0UVwjH2ZbiIu+97S04tpmcgAhzVYB0Lc4MUJrXXRZga9IFtF0VskT16awY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Wed, 23 Jun 2021 02:04:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 02:04:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?=
 <michel@daenzer.net>
Subject: RE: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Topic: [PATCH V3 1/7] drm/amdgpu: correct tcp harvest setting
Thread-Index: AQHXZmsxFWAKnvzZrUWX2vJXFPYJwKseX0oAgADsgxCAAEFRgIAANVuAgAAWuoCAAQFbcA==
Date: Wed, 23 Jun 2021 02:04:08 +0000
Message-ID: <DM6PR12MB26192A83217AEE18ABC0902EE4089@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210621070040.494336-1-evan.quan@amd.com>
 <c4550aab-23b3-fcf9-5fc1-7c129743adb3@amd.com>
 <DM6PR12MB2619DA78289C9BC237FF772AE4099@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CH0PR12MB5348A92078FAAEB0F132A78D97099@CH0PR12MB5348.namprd12.prod.outlook.com>
 <7486e471-4ff9-bfe1-947a-d726b2eadc2d@daenzer.net>
 <71eeee2c-fae7-17b9-f33d-5bb3191fed28@amd.com>
In-Reply-To: <71eeee2c-fae7-17b9-f33d-5bb3191fed28@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-23T02:04:05Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4846a9d2-aea1-4d56-b3eb-d341fb0a86a1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a5861d-de25-42db-593a-08d935eb3013
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31795AD6678B2F538EF0C807E4089@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrOyFY+8oZEZzJeNPz2TWeq9b4SwP0hXsqnFmI9I5IXCy9hhMfJQczcDrCmrC8aKNEmh59ZtI+Ofnz0JVTvGl0DsqtoXoob9hiKk9WtTYsOs5lJOaWL4NhsYXbY+1Vz3Ks4AEt8SHXCJdhSXRUEiYhDWcDu/bcNiug8A9hI0E+SYOEs61ajhJIVhzzeYf2d4dQWsK2RcFh399pqATfZSugiqeFThM8HuFoz2h85q45W01WbQoyjTIkXnssHJiZ+sWrAbMu1Oqo92W/+Ybo5UDjEOcromlVcxbGxYVykGLD3r1yNTts/sVFH3axDDFYhEI15FYnuFCItG7pM2tUbUqled4O+r9asQ1Nrb+8teKyvgtpuy29jbf1PIoSxF01am9kfx0XSirt1bueCWeARYweTMw0F5K3zUXX+3UflgH2KFB3ENEx3jlM43eXn/uw17DAInrAPCx1NllKB9LmfmRBILNib3fCJ/9Jz+wGGXwJiOD6hPdSubIjT2goiffqPtrfxfLxXtbljQ14FumwOLmR4YP6tU0Z12azHzGIQPrLGhF9/V48z3RRx6Ae3Yz35ARAvSGo9n+BvKjSCKbcEGu5ZIcfY3DNmLR4pcChxZiD8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(66446008)(86362001)(76116006)(9686003)(66574015)(66946007)(64756008)(33656002)(52536014)(55016002)(5660300002)(71200400001)(66476007)(83380400001)(66556008)(4326008)(186003)(38100700002)(122000001)(110136005)(316002)(8936002)(8676002)(7696005)(2906002)(478600001)(54906003)(6506007)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHlpRlE4U2RHdnF4VXJOVC9uaWlkd0JYVGNnZzFpQUJFZXZBRXRJcUhFMHkz?=
 =?utf-8?B?SFZiaWFhTEtKOVdtZjdkYmZMUC9nOE1Pa0xKVUtKbGJjNkZ4TklMYXB4QjYx?=
 =?utf-8?B?QUdQYm5tY2t4WFFLVVRrYzFrUGljSDZ0ZmdvdThveGtCTUd3K2gxa3VwRFZY?=
 =?utf-8?B?c1dxdWZkb3NSQlZwN1I1Q09NV0syL1dBWWppQUdRTE5iZzhtSStmSVVnRlJO?=
 =?utf-8?B?V2MzUzV3dHFUcThITklycWdtWG4valVXOWRyV0V4WmR5WnBBWjlwVmNxbDc4?=
 =?utf-8?B?dmdHWEVJaHZ4NUVkdElMYUZRamNqRDRMN0Fack1BYnY3Qzg5RUt1YURBZ1pM?=
 =?utf-8?B?Rm5QV3o2K05ZM0hZV0Z6bzRSbDdEbUtvMjQvZkUzQ0xXRlB4QVF4YnA1akYv?=
 =?utf-8?B?T3pZWVNndjRUS1VsMjQ0eUZ3ZDRJTUcxSENRSTdVdUl0N091bGUzWGFnSnV4?=
 =?utf-8?B?Tm1CcWZ5M1BVNWZpU2xaeGo1SjNVWkV2cXF6a2phTGlGZ0Jmckp2QzRjb3Rn?=
 =?utf-8?B?VUY4eWdIT2RBS0t0TE8ySzVoZVhFdDVSczBIZlVzb25leUVBb01Bc1lWRW45?=
 =?utf-8?B?UGw1U2NQZFNaZzRQNHVkUUF3NDNZUXFmVVdVV0Q3SUVTV3VDY3Q1cmJSbkFj?=
 =?utf-8?B?V3IvdTRZQzhnRHpnUEhtY3pHdG9ldnVZbFVSczhGaHhMTkxFSDJZMkh2d3Bl?=
 =?utf-8?B?K016QlhDTGc3UzdoUHZ3K3RrYzZ0ZzJUWktSb0ZBNHA1cXo1WXlKSy92Smkw?=
 =?utf-8?B?WEhBWFJoRWcvcmtidlhLajBObzhJdzJONVVrNWxOOS93TVVuVk9VcnZXelJN?=
 =?utf-8?B?OHlLWEJMa3dqd3lBRElXMlhHazI4dEROM3VESno3dHNkeHdJbEh5UlAybURE?=
 =?utf-8?B?WUdDOEd5bEowMnpWeUZmOU1FWkcvRmNCZHA0Yzk2UWJNbGM4L1JXQUNralox?=
 =?utf-8?B?Q2Q0V2prZUNRZUp5KzkvK3dmMi85ZUtEaU90R2JmNE9IL0Jta1dOaWlzem4v?=
 =?utf-8?B?WjhwVzRTemVBZGdUNlU3SkNWQjUvOHVXUTgzUzU4YktoaDRXdGsrWExQNzFm?=
 =?utf-8?B?YkZ6emxuTUxLMXUxT3EzeENkV1d2QUNxelJsb240QjBOTzZPVUFkSTA1NVR1?=
 =?utf-8?B?aGk0OU43Q2FSV1lHcCtTalZWTEZ2TXhDNWN3Q0s5ZlByNHFvVGZCSm9QRHhr?=
 =?utf-8?B?OXpsYmNLS0ZLcjR4K1ltTlZyOWxBa0pZU0RBOW1KNWY1RFIvMkIvcFVrUjVm?=
 =?utf-8?B?dGp6R3pOVVR4T3JKc2VrWCtGQWNUTUlvYldya2NleUF5UVFXYVNMcEtML2Zj?=
 =?utf-8?B?TUxjdHZmSUlnM0s4OTgwL09maUtkdGhxMUlTdDltUUIwWFkrc05tV1ZNQXdW?=
 =?utf-8?B?aTZ3bGhnY1krME5MaHVFeDc5OURhMjh0SGljTTY1QmpSbDYvTjB0T1RzaTJn?=
 =?utf-8?B?akdvRnBWdHFkRitkd2U5bUZwRWhuN3VyaUg1YzJMRVZnL09rejJFZUl6Z1NW?=
 =?utf-8?B?aU5Ga3Bvd2ZodGI5bVg5TDNMUVowTnliUlFMYVpQWS9vbVlPdE5vcHpGQm5E?=
 =?utf-8?B?ZmlMQjdqS1hoNWpLRXNOdFQwdFd0cUNIZGJKaDJsQlpMRXdkUnRNZkZRSEpE?=
 =?utf-8?B?R2MwQVRyV2xGNVVFcTQvOGErUnFPaWVBWGZrVXdmbWJqTlVQVTR3QXlUaXhy?=
 =?utf-8?B?YkhSTTdJOEJnNGNCQ2R6eHQyQVViVFFjTjJRQ3pVQUVQTzFLMm5qdEp6YUYx?=
 =?utf-8?Q?Jlf8q2Sgj+krRoPKyG74Hm8+2oddXJbrdFrBbOM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a5861d-de25-42db-593a-08d935eb3013
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 02:04:08.8997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oXlu/Q0mK1684eKGjevDpXpw8RrU5kLbTXrgHmLRmzk33XZ2oLHWzyVrDuraKmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRpb24uIEkg
d2lsbCB1c2UgMHhmZmZmZmZmZnUgdGhlbi4NCg0KQlINCkV2YW4NCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4g
U2VudDogVHVlc2RheSwgSnVuZSAyMiwgMjAyMSA2OjQwIFBNDQo+IFRvOiBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PjsgUXVhbiwgRXZhbg0KPiA8RXZhbi5RdWFuQGFtZC5jb20+
DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBh
bWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
MyAxLzddIGRybS9hbWRncHU6IGNvcnJlY3QgdGNwIGhhcnZlc3Qgc2V0dGluZw0KPiANCj4gDQo+
IA0KPiBPbiA2LzIyLzIwMjEgMjo0OSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6DQo+ID4gT24g
MjAyMS0wNi0yMiA4OjA4IGEubS4sIExhemFyLCBMaWpvIHdyb3RlOg0KPiA+PiBbUHVibGljXQ0K
PiA+Pg0KPiA+PiBBRkFJSywgdGhhdCBleHByZXNzaW9uIGlzIGxlZ2FsIChzb21lIGNvZGUgYW5h
bHl6ZXIgbWF5IHdhcm4gb24gdmFsdWUgb2YNCj4gNCptYXhfd2dwX3Blcl9zaCk7IHNpbWlsYXIg
a2luZCBpcyB1c2VkIGluIHJvdGF0ZSBzaGlmdCBvcGVyYXRpb25zLg0KPiA+DQo+ID4gVGhlIGRl
ZmF1bHQgdHlwZSBmb3IgY29uc3RhbnRzIGluIEMgaXMgaW50LCBzbyAweGZmZmZmZmZmIGlzIGEg
MzItYml0IHNpZ25lZA0KPiBpbnRlZ2VyLg0KPiANCj4gUHJvYmFibHkgbm90IGFzIHBlciBzZWN0
aW9uIDYuNC40Lg0KPiANCj4gIlRoZSB0eXBlIG9mIGFuIGludGVnZXIgY29uc3RhbnQgaXMgdGhl
IGZpcnN0IG9mIHRoZSBjb3JyZXNwb25kaW5nIGxpc3QgaW4gd2hpY2gNCj4gaXRzIHZhbHVlIGNh
biBiZSByZXByZXNlbnRlZC4iDQo+IA0KPiBJdCBpcyBhIGhleGFkZWNpbWFsIGNvbnN0YW50IGFu
ZCB0aGUgZmlyc3QgdG8gZml0IHRoaXMgdmFsdWUgaXMgdW5zaWduZWQgaW50Lg0KPiBSZWdhcmRs
ZXNzLCBhZGRpbmcgdSBzdWZmaXggd2lsbCBhdm9pZCBhbnkgYW1iaWd1aXR5Lg0KPiANCj4gVGhh
bmtzLA0KPiBMaWpvDQo+IA0KPiA+DQo+ID4gVGhlIEM5OSBzcGVjaWZpY2F0aW9uIGxpc3RzIHRo
aXMgdW5kZXIgSi4yIFVuZGVmaW5lZCBiZWhhdmlvcjoNCj4gPg0KPiA+IOKAlCBBbiBleHByZXNz
aW9uIGhhdmluZyBzaWduZWQgcHJvbW90ZWQgdHlwZSBpcyBsZWZ0LXNoaWZ0ZWQgYW5kIGVpdGhl
cg0KPiB0aGUgdmFsdWUgb2YgdGhlDQo+ID4gICBleHByZXNzaW9uIGlzIG5lZ2F0aXZlIG9yIHRo
ZSByZXN1bHQgb2Ygc2hpZnRpbmcgd291bGQgYmUgbm90IGJlDQo+IHJlcHJlc2VudGFibGUgaW4g
dGhlDQo+ID4gICBwcm9tb3RlZCB0eXBlICg2LjUuNykuDQo+ID4NCj4gPiBTbyBpdCB3b3VsZCBi
ZSBzYWZlciB0byBtYWtlIGl0IHVuc2lnbmVkOiAweGZmZmZmZmZmdSAob3IganVzdCB+MHUpLg0K
PiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUXVh
biwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjIs
IDIwMjEgNzo1NiBBTQ0KPiA+PiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
VjMgMS83XSBkcm0vYW1kZ3B1OiBjb3JyZWN0IHRjcCBoYXJ2ZXN0IHNldHRpbmcNCj4gPj4NCj4g
Pj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPj4NCj4gPj4gVGhhbmtzIExpam8uDQo+ID4+
IEhvd2V2ZXIsIEknbSBub3QgcXVpdGUgc3VyZSB3aGV0aGVyICIgMHhmZmZmZmZmZiA8PCAoNCAq
DQo+IG1heF93Z3BfcGVyX3NoKTsiIGlzIGEgdmFsaWQgZXhwcmVzc2lvbiBzaW5jZSBpdCBraW5k
IG9mIHRyaWdnZXJzIHNvbWUNCj4gb3ZlcmZsb3cuDQo+ID4+IENhbiB0aGF0IHdvcmsgZm9yIG5v
bi14ODYgcGxhdGZvcm0gb3IgZXZlbiB3b3JrIHJlbGlhYmx5IGZvciB4ODYgcGxhdGZvcm0/DQo+
ID4NCj4gPg0KPiA+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
