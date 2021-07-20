Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308AC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 09:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC05610F7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 09:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC05610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9F96E174;
	Tue, 20 Jul 2021 09:14:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCF096E174
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 09:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjgld7wKBAnFOAh+/VrmxgqCXIUKg6DPgirFHVy4rl7bq3TWZLynV1Bnjg0uspPUtfX5lzxWKrNvPR8+ymyaTo4ivbE/U+O1gg7CUODBdOIZpOlv1i8ExIgxJXfYPTmVGqsQFLhqywBEt8BizzyCtXeaFenyzQrawTJ/9AAzPDzKGvVKqQ0SwiU+R36tZzJupMpOHfihbYUxK7bsbG85Ygkj11yhR1yEYjWqDSKDeO37XK3Ib3enp/hiTadJ0EGmPGTXomu9d6cpVnaAGs8lMX8IlVPeLUg7p9S3TYDeA/HsMf17ZVa3jGxBoAAczU+hWAnaKVLl4fAXh7uax29OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTBGrTQUAXsBaYnjp/cTiE+JMYg0VaYnT+zQxSwteow=;
 b=SX8H3orEs2SXsgyxkkVFed5qVHFEBCgswVzb+WWYdrNdTt/lgpYKzKh3njse9/FW7oq0bj6mKoqzXNrZlQSoWoPoGc0EFBy9ZXXSStzbesyJOeAT5X3IauYq6IpHQ3WOYe1FQoi9jTJt6Xu7GF/FT5dHtClVVEEh33EXVuCoNaqL3ufhAlcIcQReHPXxfWDygBGNAkjeHkfqUYtBNpARg9XXD/4vbgDOQ/HBKKTVVAT54YQ3Xdikk20mnxV4f4nqbUomlLtIr3pJWkk8EY4R+ntpMCbAsSJyAY4B6Ex9aJGFYKtPrv/9HV5Sc9szDid667R/KYo84YCo8xwAdPsBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTBGrTQUAXsBaYnjp/cTiE+JMYg0VaYnT+zQxSwteow=;
 b=VjhibiIieZqbNGXSTUzc7Usas0J1JEV+uYvkE2Fo9v+xlr7uM8JwH7OtQM4bIGUUbTu6mKBycXD888+zW5n0wEyjYATks9cFLtv/xAKbdCsEjslDrhRQf3qAGSMFSzhmA5Tbyeq1bNTD5ZprxG7teA7ZwFVjMvRFfsDtcYFZKh4=
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 09:14:47 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::9977:1325:c275:327a%8]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 09:14:47 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Topic: [PATCH] drm/amd/amdgpu: vm entities should have kernel priority
Thread-Index: AQHXfGMXOH6nqLqskUGCx+NsyuS83atJ9lKAgAAU/wCAAADSAIAAGFEAgAFYOHCAAA0lgIAACkRw
Date: Tue, 20 Jul 2021 09:14:47 +0000
Message-ID: <DM4PR12MB523279F8B3035773D9737B05B7E29@DM4PR12MB5232.namprd12.prod.outlook.com>
References: <20210719055754.244832-1-Jingwen.Chen2@amd.com>
 <a56009a5-4793-7301-2a80-b4b051db6c0c@gmail.com>
 <BL1PR12MB5269EC6B2D9822EAAC4A292A84E19@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB526951A39795137AA03FA19984E19@BL1PR12MB5269.namprd12.prod.outlook.com>
 <73d76ebe-9850-9429-25cd-c723a40b99dc@gmail.com>
 <DM4PR12MB52322BAD9B4EBC3B8AE38F24B7E29@DM4PR12MB5232.namprd12.prod.outlook.com>
 <597b7492-13d3-0d95-22dc-5e95e91b937f@gmail.com>
In-Reply-To: <597b7492-13d3-0d95-22dc-5e95e91b937f@gmail.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9540db81-7b08-4049-b660-209a2448f3c8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-20T09:05:47Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c15803-dffe-4161-ef8f-08d94b5ed1f9
x-ms-traffictypediagnostic: DM8PR12MB5462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB54629121F6CDF6E14DE87528B7E29@DM8PR12MB5462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sD8SraD2I2WFoweU20NZ/i8Ol5khnZ71gytUyoX8ry3ahGroBHvsSYZBdHmviTo2pmJsM0fpMeHu1H77p6MPvHFBdgEIJ7aNvY4UBRtpMy9VXtnDS37drCZVxPS30+x2Z891Zitb3RoFwfkIQRN7ITQtauvzoda2CttiUUypKfol+JAfhcm9YJ+cusWTbCjphSVzBYbf1UI+zI7spUR/jhiSo+HTx6bC/iFzAesTU6rXzplY0B4B+JfxsxMoYsVcR0TnO2i5O1cg2+Gw6vzkQt0LM72kJLqAXNLctyafFRuSPOBAvyTQ/bN9baiQRinAM1ie1J92dYvfuDrNozgfyBix8WZ7EszHAi14/eC8wujWvbx+HECO5I8qT3kBHJZaUjSGIhUxfvmLCO9NcIkk69oJl31eyGKOcPSFJr5h7TX9wzZr+T23i+mv92rcsOBsyKRvv7a9Ge3gGdmY7neR76aAqVGaAH+oZQErwAks8gWopQFGLBK0jEPexTkdcJ2VEEe2EcJINOOI4J3Ld756Fu0rV3M30vJZpshr30NcvO9KRZo253vpXPMQi+wM7W4ReFW8iXBusQEGBrL0M3IF2+8u2rpXnUJ2Z0P4io7cr7EBo7SDmumHThAa0SNn/ZkFR1cpfY8YCeyzO7eTJaHx6ZJzqs5mE4OBLP6Didr8fxzWMJwRrvAOs1Vl3VfofwS/BCemIfne9Xk+GlNcpGM3+x54WCXnFimvOr7YjbvDatE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(52536014)(71200400001)(83380400001)(66946007)(66476007)(38100700002)(6506007)(86362001)(53546011)(9686003)(66446008)(64756008)(316002)(66556008)(76116006)(110136005)(8936002)(4326008)(2906002)(8676002)(66574015)(26005)(122000001)(186003)(55016002)(33656002)(7696005)(5660300002)(478600001)(3714002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTlkUk9iNUVmbjc3WlZSUGlJUTg4QlNMMnpTQU1wME41MjBremkzWnpEbmgv?=
 =?utf-8?B?cjkyM2RsblIrajdadE1IMGZJcnRNb21BSDdJTXhDN0VNckRHYTBrMU15QTZh?=
 =?utf-8?B?NEhQYnAweFp4SU5XV2o5NS9pWXhDZTZhSkg2SHdCQ2EzbkdkQVBXVGpjeVdE?=
 =?utf-8?B?NW9wRXNVK2N5OEU5cWxseWd2VlFYdzNYYU1FQnJqOG1WRHBxd1ZudEI4NFNy?=
 =?utf-8?B?dEdteDdTd1llRkExQ2FBV0duY2NObGFDdWVaYTNzZC85MnBvVTFKUE43YjVk?=
 =?utf-8?B?N2xncitobkNVdVBCYTJSUmRQRzJqSGZMQ2U3VlNod0QwQWcvNmhVZ0todTdK?=
 =?utf-8?B?WkVtOTYrOHFVT05FN1BrdDhiRWpJSVo4TFRIcUd1bitpOXVBYVB6M0Y2NE9s?=
 =?utf-8?B?UGd0alRYejRlRW1CYVpCT1ZEdi92emtIUTlhSG1uc2hIWlVMQXoyR21qZlhQ?=
 =?utf-8?B?Z0h6Y2dwaXFYQXlra1htbU9LaG9hQlJRWEF5eUFSUXZJTnRnMmVtSFdqRk0y?=
 =?utf-8?B?SFVBKzBNN2kvR1Q4VFdsNFZxdlVFNmdWTXNVNkN4VUgrRHN5eUlpOUxDVGxi?=
 =?utf-8?B?MWdxZ0hGZWZUT0FHWnN2UG9BTkJIS2JvS3I4ampxT2dyb3NqbFVvUVljMzNY?=
 =?utf-8?B?UzEyR0pJREhwb215VWFvQmtxNjF4cUZJaEYvbkdUUmdMVFEyUUJDL2FqVGky?=
 =?utf-8?B?MFRteXA2N0VSVE9WNlRtVGVGeDFsNmd3eEFuRlAvYzFiOHhNbWtCQm5HaFNk?=
 =?utf-8?B?OU55TkZQRXZBVzFtUmE3N29RNFNETEdJMFQ3T3VlRDZWNWhYMXpZMUdUK0Vk?=
 =?utf-8?B?TlprMjh1VXJRZWQ4YUNzSjVZZjBxaHpmUk05SEVLNlo3WjZTcVFzQXhEb0Z0?=
 =?utf-8?B?V1ZyNGtxOStVL0ZqTW85OHUxSmR0d29OT0RZK2JENS9CeHNOaEJzM2p3Q2xB?=
 =?utf-8?B?RjBwVm9SdXNTdWliYzlDTCtPSkZaRldwVjUwOVNiZ1hlQTZGRHNQVW4rS2xT?=
 =?utf-8?B?NzZZQXNOSS82ZGZ4Y1g4bkpZNG41dGg4a1U0S2pTV0FvVXNJNFhBMzNRanhP?=
 =?utf-8?B?SXRTd0dycXNja1NXOGY5ZnNMck1Kbk9lbGd3aEQ5Y092Q3U4OHhnYnZldkJG?=
 =?utf-8?B?L1Rha3hyNFFPanZIM1pmS0YwWkZTZkNDTzZaY0F5aklkaFkvOFkxWTJiNHF3?=
 =?utf-8?B?eXFlR2J2czhLdXpGRWN2TkdiRHNqRmxhQzBsMktYQnBvazlQSFQveEtibFVn?=
 =?utf-8?B?cnNSTWpncC9FeTcwSlpPMGRMZmYyRlJEM0hPQmhjNEhQemJxaDM4NTFUSXpH?=
 =?utf-8?B?SzZRNjhqMFpDSkNmN0c4SFZQTjJUV1RNZ3d5aVA1bGRkY1lFRFZUVkQ5em5O?=
 =?utf-8?B?UnY3R3VUV21rQTJiNkVCYytoNzdlL2xGaFF2MjY4VDJHeWpqbGw4bmYvdHNU?=
 =?utf-8?B?RjNGVmVLRjdtOS9tcXd3akVHcWVuK21NbmpsMHRra3M0UzlFclY3blkzZ2w2?=
 =?utf-8?B?Y0JtWnBMd0VrNDdSeWRHeUcwSzFiMURvS3RsbjZTWCt2WUlUclIyc2xVeDgw?=
 =?utf-8?B?c01sZSsyMXMyZlhneTF1ZDFOQWxNQzNBVWV3OUR0VStxM1gzOVJHWmJOaERD?=
 =?utf-8?B?a29ETU1lT0NjZ0NzQWZJZUlJSDRuS08wSitQWTg5N1ViTktYNXhwSE8xOFdC?=
 =?utf-8?B?SlplaDNCaXo2SGl1ZTd5ZkxKTm50RXcyWTk4dm5yQXd3bHR5S0wzdWFIVXVG?=
 =?utf-8?Q?V8ijXYiAYEzJxGURVk80VXuOhiM0gnaN+puOXQu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c15803-dffe-4161-ef8f-08d94b5ed1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 09:14:47.0277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFdqLXq4lSfHBTtzOw9/WBO8QZFYkobGMED6gaT8X0+9D1kpVWz/wnlSDWPjBLxqTW5aWaJi74OL5FG0h76q8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgQ2hyaXN0aWFuLA0KDQpJIGFncmVlIHRoYXQg
Y2hhbmdpbmcgdGhlIHByaW9yaXR5IGlzIG5vdCB0aGUgcmlnaHQgd2F5Lg0KU28gdG8gbm90IGNv
bnNpZGVyIHBhZ2luZyBqb2IgZ3VpbHR5LCBkbyB5b3UgdGhpbmsgaXQncyBPSyB0byBub3QgaW5j
cmVhc2Vfa2FybWEgZm9yIGl0KGlmIChqb2ItPnZtaWQgPT0gMCkpPw0KDQpCZXN0IFJlZ2FyZHMs
DQpKaW5nV2VuIENoZW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENocmlz
dGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2VudDogVHVl
c2RheSwgSnVseSAyMCwgMjAyMSA0OjI5IFBNDQpUbzogQ2hlbiwgSmluZ1dlbiA8SmluZ1dlbi5D
aGVuMkBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogdm0gZW50aXRpZXMgc2hvdWxk
IGhhdmUga2VybmVsIHByaW9yaXR5DQoNCkhpIEppbmdXZW4sDQoNCnlvdSBjYW4gbG9vayBhdCB0
aGUgam9iLT52bSBwb2ludGVyIHRvIGRpc3RpbmN0IGFuIHVzZXJzcGFjZSBzdWJtaXNzaW9uDQpm
cm9tIGEga2VybmVsIHN1Ym1pc3Npb24uDQoNClRoZSBwcmlvcml0eSBpcyBub3QgcmVhbGx5IHJl
bGF0ZWQgdG8gdGhlIHN1Ym1pc3Npb24gdHlwZSwgd2UganVzdA0KaGFwcGVuIHRvIHRyZWF0IHBh
Z2luZyBqb2JzIHdpdGggdGhlIGhpZ2hlc3QgcHJpb3JpdHkgc2luY2UgdGhleSBhcmUNCmltcG9y
dGFudCBmb3IgdGhlIHN5c3RlbSBhcyBhIHdob2xlLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0K
DQpBbSAyMC4wNy4yMSB1bSAwOTo0OSBzY2hyaWViIENoZW4sIEppbmdXZW46DQo+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHldDQo+DQo+IEhpIENocmlzdGlhbiwNCj4NCj4gRXZlbiBpZiB0aGlzIGlz
IGEgdXNlcnNwYWNlIG1hcHBpbmcsIGl0J3Mgc3RpbGwgcGFja2FnZWQgYnkgdGhlIGtlcm5lbCwg
c28gaXQncyBhbHdheXMgYXNzdW1lZCB0byBiZSBjb3JyZWN0LiBJbiB3aGljaCBjYXNlIG1vZGlm
eWluZyB0aGUgcHJpb3JpdHkgc2hvdWxkIGhhdmUgbm8gc2lkZSBlZmZlY3RzLiBNYXkgSSBrbm93
IHRoZSBkZXRhaWxlZCByZWFzb24gZm9yIHlvdXIgY29uY2Vybj8NCj4NCj4gQW5kIGlmIHdlIGV2
ZW50dWFsbHkgZGVjaWRlIG5vdCB0byBjaGFuZ2UgdGhlIHByaW9yaXR5LCBkbyB5b3UgaGF2ZSBh
bnkgc3VnZ2VzdGlvbnMgYWJvdXQgaG93IHRvIG1ha2Ugc3VyZSB0aGUgcGFnaW5nIGpvYnMgYXJl
IG5vdCBjb25zaWRlcmVkIGd1aWx0eT8NCj4NCj4gQmVzdCBSZWdhcmRzLA0KPiBKaW5nV2VuIENo
ZW4NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwg
SnVseSAxOSwgMjAyMSA3OjEwIFBNDQo+IFRvOiBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+
OyBDaGVuLCBKaW5nV2VuIDxKaW5nV2VuLkNoZW4yQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogQ2hlbiwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTogdm0gZW50aXRpZXMgc2hvdWxk
IGhhdmUga2VybmVsIHByaW9yaXR5DQo+DQo+IEFtIDE5LjA3LjIxIHVtIDExOjQyIHNjaHJpZWIg
TGl1LCBNb25rOg0KPj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4+DQo+PiBCZXNpZGVzLCBJ
IHRoaW5rIG91ciBjdXJyZW50IEtNRCBoYXZlIHRocmVlIHR5cGVzIG9mIGtlcm5lbCBzZG1hIGpv
YnM6DQo+PiAxKSBhZGV2LT5tbWFuLmVudGl0eSwgaXQgaXMgYWxyZWFkeSBhIEtFUk5FTCBwcmlv
cml0eSBlbnRpdHkNCj4+IDIpIHZtLT5pbW1lZGlhdGUNCj4+IDMpIHZtLT5kZWxheQ0KPj4NCj4+
IERvIHlvdSBtZWFuIG5vdyB2bS0+aW1tZWRpYXRlIG9yIGRlbGF5IGFyZSB1c2VkIGFzIG1vdmlu
ZyBqb2JzIGluc3RlYWQgb2YgbW1hbi5lbnRpdHkgPw0KPiBObywgZXhhY3RseSB0aGF0J3MgdGhl
IHBvaW50LiB2bS0+aW1tZWRpYXRlIGFuZCB2bS0+ZGVsYXllZCBhcmUgbm90IGZvciBrZXJuZWwg
cGFnaW5nIGpvYnMuDQo+DQo+IFRob3NlIGFyZSB1c2VkIGZvciB1c2Vyc3BhY2UgcGFnZSB0YWJs
ZSB1cGRhdGVzLg0KPg0KPiBJIGFncmVlIHRoYXQgdGhvc2Ugc2hvdWxkIHByb2JhYmx5IG5vdCBj
b25zaWRlcmVkIGd1aWx0eSwgYnV0IG1vZGlmeWluZyB0aGUgcHJpb3JpdHkgb2YgdGhlbSBpcyBu
b3QgdGhlIHJpZ2h0IHdheSBvZiBkb2luZyB0aGF0Lg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3Rp
YW4uDQo+DQo+PiBUaGFua3MNCj4+DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+IE1vbmsgTGl1IHwgQ2xvdWQtR1BVIENvcmUgdGVhbQ0KPj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pg0KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IExpdSwgTW9uaw0KPj4gU2VudDogTW9uZGF5LCBKdWx5
IDE5LCAyMDIxIDU6NDAgUE0NCj4+IFRvOiAnQ2hyaXN0aWFuIEvDtm5pZycgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPjsgQ2hlbiwNCj4+IEppbmdXZW4gPEppbmdXZW4uQ2hlbjJA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBDYzogQ2hlbiwgSG9y
YWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPg0KPj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2Ft
ZC9hbWRncHU6IHZtIGVudGl0aWVzIHNob3VsZCBoYXZlIGtlcm5lbA0KPj4gcHJpb3JpdHkNCj4+
DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4NCj4+IElmIHRoZXJlIGlzIG1vdmUgam9i
cyBjbGFzaGluZyB0aGVyZSB3ZSBwcm9iYWJseSBuZWVkIHRvIGZpeCB0aGUgYnVncw0KPj4gb2Yg
dGhvc2UgbW92ZSBqb2JzDQo+Pg0KPj4gUHJldmlvdXNseSBJIGJlbGlldmUgeW91IGFsc28gcmVt
ZW1iZXIgdGhhdCB3ZSBhZ3JlZWQgdG8gYWx3YXlzIHRydXN0DQo+PiBrZXJuZWwgam9icyBlc3Bl
Y2lhbGx5IHBhZ2luZyBqb2JzLA0KPj4NCj4+IFdpdGhvdXQgc2V0IHBhZ2luZyBqb2JzJyBwcmlv
cml0eSB0byBLRVJORUwgbGV2ZWwgaG93IGNhbiB3ZSBrZWVwIHRoYXQgcHJvdG9jb2wgPyBkbyB5
b3UgaGF2ZSBhIGJldHRlciBpZGVhPw0KPj4NCj4+IFRoYW5rcw0KPj4NCj4+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gTW9uayBMaXUgfCBDbG91ZC1HUFUg
Q29yZSB0ZWFtDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+PiBTZW50OiBNb25kYXks
IEp1bHkgMTksIDIwMjEgNDoyNSBQTQ0KPj4gVG86IENoZW4sIEppbmdXZW4gPEppbmdXZW4uQ2hl
bjJAYW1kLmNvbT47DQo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPj4gQ2M6IENo
ZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1k
LmNvbT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiB2bSBlbnRpdGll
cyBzaG91bGQgaGF2ZSBrZXJuZWwNCj4+IHByaW9yaXR5DQo+Pg0KPj4gQW0gMTkuMDcuMjEgdW0g
MDc6NTcgc2NocmllYiBKaW5nd2VuIENoZW46DQo+Pj4gW1doeV0NCj4+PiBDdXJyZW50IHZtX3B0
ZSBlbnRpdGllcyBoYXZlIE5PUk1BTCBwcmlvcml0eSwgaW4gU1JJT1YgbXVsdGktdmYgdXNlDQo+
Pj4gY2FzZSwgdGhlIHZmIGZsciBoYXBwZW5zIGZpcnN0IGFuZCB0aGVuIGpvYiB0aW1lIG91dCBp
cyBmb3VuZC4NCj4+PiBUaGVyZSBjYW4gYmUgc2V2ZXJhbCBqb2JzIHRpbWVvdXQgZHVyaW5nIGEg
dmVyeSBzbWFsbCB0aW1lIHNsaWNlLg0KPj4+IEFuZCBpZiB0aGUgaW5ub2NlbnQgc2RtYSBqb2Ig
dGltZSBvdXQgaXMgZm91bmQgYmVmb3JlIHRoZSByZWFsIGJhZA0KPj4+IGpvYiwgdGhlbiB0aGUg
aW5ub2NlbnQgc2RtYSBqb2Igd2lsbCBiZSBzZXQgdG8gZ3VpbHR5IGFzIGl0IG9ubHkgaGFzDQo+
Pj4gTk9STUFMIHByaW9yaXR5LiBUaGlzIHdpbGwgbGVhZCB0byBhIHBhZ2UgZmF1bHQgYWZ0ZXIg
cmVzdWJtaXR0aW5nDQo+Pj4gam9iLg0KPj4+DQo+Pj4gW0hvd10NCj4+PiBzZG1hIHNob3VsZCBh
bHdheXMgaGF2ZSBLRVJORUwgcHJpb3JpdHkuIFRoZSBrZXJuZWwgam9iIHdpbGwgYWx3YXlzDQo+
Pj4gYmUgcmVzdWJtaXR0ZWQuDQo+PiBJJ20gbm90IHN1cmUgaWYgdGhhdCBpcyBhIGdvb2QgaWRl
YS4gV2UgaW50ZW50aW9uYWxseSBkaWRuJ3QgZ2F2ZSB0aGUgcGFnZSB0YWJsZSB1cGRhdGVzIGtl
cm5lbCBwcmlvcml0eSB0byBhdm9pZCBjbGFzaGluZyB3aXRoIHRoZSBtb3ZlIGpvYnMuDQo+Pg0K
Pj4gQ2hyaXN0aWFuLg0KPj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKaW5nd2VuIENoZW4gPEppbmd3
ZW4uQ2hlbjJAYW1kLmNvbT4NCj4+PiAtLS0NCj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgfCA0ICsrLS0NCj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4+PiBpbmRleCAzNTgzMTZkNmEzOGMuLmY3NTI2YjY3Y2M1
ZCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+Pj4g
QEAgLTI5MjMsMTMgKzI5MjMsMTMgQEAgaW50IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkNCj4+PiAgICAgICBJTklUX0xJU1Rf
SEVBRCgmdm0tPmRvbmUpOw0KPj4+DQo+Pj4gICAgICAgLyogY3JlYXRlIHNjaGVkdWxlciBlbnRp
dGllcyBmb3IgcGFnZSB0YWJsZSB1cGRhdGVzICovDQo+Pj4gLSAgICByID0gZHJtX3NjaGVkX2Vu
dGl0eV9pbml0KCZ2bS0+aW1tZWRpYXRlLCBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMLA0KPj4+
ICsgICAgciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmdm0tPmltbWVkaWF0ZSwNCj4+PiArRFJN
X1NDSEVEX1BSSU9SSVRZX0tFUk5FTCwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZXYtPnZtX21hbmFnZXIudm1fcHRlX3NjaGVkcywNCj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZXYtPnZtX21hbmFnZXIudm1fcHRlX251bV9zY2hlZHMsIE5VTEwp
Ow0KPj4+ICAgICAgIGlmIChyKQ0KPj4+ICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+Pj4NCj4+
PiAtICAgIHIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5kZWxheWVkLCBEUk1fU0NIRURf
UFJJT1JJVFlfTk9STUFMLA0KPj4+ICsgICAgciA9IGRybV9zY2hlZF9lbnRpdHlfaW5pdCgmdm0t
PmRlbGF5ZWQsIERSTV9TQ0hFRF9QUklPUklUWV9LRVJORUwsDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9zY2hlZHMsDQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLnZtX3B0ZV9udW1f
c2NoZWRzLCBOVUxMKTsNCj4+PiAgICAgICBpZiAocikNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
