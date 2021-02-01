Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084EFC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BE664E2B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BE664E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6006E6E82C;
	Mon,  1 Feb 2021 16:13:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BF56E82C
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 16:13:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTCibLCcy0XeBa+qjPlZmOU6wHxTqUcMmxMx4gUc33NF1ffQlL+lrCCcxf8g+TVmAnjHpWEWRQmRckxFa+Zx/sX4BAZ3QlXM4sH2MRJqhYBN+eX+M4n6x1RE48Y560XJDYCsRq9zBGGqzmv4ke0yZBGNoonNV/cAwtu+H+YvURLdz+6oAtw2x+IaObEmCYSlUQR5V1B8UpNkOS4g9VTauNwcNHQoFrE7gikaYZa0FYVI0GsFGCOjVDeEeRSs4aYBdi5371wtcU1SmtSChGWBqcocojXUyM8ju/FlkXSikkOb05Qi3vozKklXJdy2PAEBBXYlA7CMbqT7Qck/2LV3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoumY2x/WdmAiT5I8zXAo9hzND+WdfsQU1AXeFstmI=;
 b=V3Fw2UcWTZ0LE8QZDHQbyZQvRMIaHvkt8RTyz3qULkdhZSw3uOwQV0pThYC9BgJcn+3uLbAv7TmvyxllapJrG4d16rz5OdYk8Lo4gRfds1lLicYGig+8UU7CMsJGV3jjSs71Qe12NHkPPqIh9bk1ZoFxdEu/pq6zW/vgUJUwTUY+FihFh7LIOSAUbXwdp1DKAmmSslCrA9yyn66Qet1T2u1176uPHZjMTUX2W+uuYSFTZk4sGDHcgp4s66p2TohrM9gpCcGT6LgeB6tZynKpxT973DFpGcYzlMAtOXOIYPV4r9T3ZaAGK5Mh08ZTBcvxVlYkxXMdV5kGKYVpd++3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoumY2x/WdmAiT5I8zXAo9hzND+WdfsQU1AXeFstmI=;
 b=RaXNv0MTudv0B0uQo0HGxTYWn5krybFVI+hpRIDDAHa6Bq/ebey3y4WJ20IZQZAkFm7kXDh7fclp6vzToN8ryBpG4ag+u5UHX3ZZrbOCFHgwzIijLeRuPbycx4LnmkFtNfyXfnBAPd1F3bHyMcAicYZ/BAGDqrOY1LVNw9S1WEU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 16:13:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 16:13:44 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: cleanup struct amdgpu_ring
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201155155.103360-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ececcadc-6be5-124c-74b7-7addae2abf76@amd.com>
Date: Mon, 1 Feb 2021 17:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210201155155.103360-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0902CA0004.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0902CA0004.eurprd09.prod.outlook.com (2603:10a6:200:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 16:13:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f001745-e75e-491d-3fb1-08d8c6cc5943
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4223283661B683BED53A1E9483B69@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmOSZr776ROQBOtlyaWW0CpcgQLg8jHVbw7Srso3xHN4qkDtuB+BGvtBQt1JLMI/e8EIJnaCZEZTmywTsd/jz2j3Fg9S8RWEoH9g/zNFIASLT24chf9Vqm+l6OUjnKtmpUTP5/FEjg3fitGV4Wv7h3w8GBxHYEWiepdlYvLHMz3CQTH8qBLtxpJ6y9wvVBXXQQs3nC7ePm7MQA+3jS4aGioLZ2sIHi4F8T5wVxDUmMxQDzrhRdgwuxhAksoa+me41KAptkKeC/GOm9pyquTbNhpy68sqt+3zrUqquH6T5XfjPGt9HZfE1IjE9Z06qt8T0uwTDhGTUQ37IBdQO+GJwudILUQTaBb6BS9iPa12ARJH5kSpFZW3yVtSQp8AkLnYaSnXMcVPMHeIN2B0e0wCr1nZDu4ZrNS9FGNHsx7MO5gZwgxZ60EDeePv2+nUZMcSDIrvYX9dsE4qOeED6DxTFlhSPKBevFGf9VJLz5rsUFZeSIK06QwteGguhGZsYcMdoVWLogaz5J6cxcqN3mDzRWj+MtvXQ2pTZa2WItyTAf0BLD+JzzgbBV+5IypP0a1kqDdOU6T5S0e7ybcyi+m9H7s+qiPLtgNsXk1e8PIdafU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(36756003)(5660300002)(2616005)(316002)(6666004)(83380400001)(31696002)(66556008)(66476007)(86362001)(66946007)(6486002)(52116002)(186003)(8936002)(16526019)(8676002)(478600001)(4326008)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnEzL1JsdndhcjJISTQ3ZTk1azhmTno2b24rNVhrRUhRSTRxNWI5RWFLWHB3?=
 =?utf-8?B?VWpQaU5ZUkhNbW5hRk4zbWgycmxSSVlXZ3RaZlhGdThSWGFPQ29lSlNrQlZI?=
 =?utf-8?B?VWNTQXFqbnBRYjZoQk4xaURweW00bi9KdU9rLzFJZnRqQUU1eC93c2dKNFlt?=
 =?utf-8?B?SUZzMEZrSm5LN1I5NFQzK1puaVhHV2NVTzZoMVowcm1TeEpVU1Q1dzJBTDdz?=
 =?utf-8?B?YnRvSHBtYlZCd2xSZU8zWG9QMW9qYnFVb2RjSHI2a2QzMFlGWkRCT3ZHazB2?=
 =?utf-8?B?WGRtRzl3MzZBclhaYi9BMllJWkQ3OWJlS3ZQd1pDa0xSUWRIQzlWS1BHcDZV?=
 =?utf-8?B?MDk5dlFMdldWNVJRbU5FR01YYVE4RkFLTGdDRVErRmFoeU1RSFJnRG1wSjYv?=
 =?utf-8?B?NXRicGU2T1h4OEFWbkUySTFEOHd2RmpnTW1zeDB3MHJRU2ZxTjI5M3Z2ZVNu?=
 =?utf-8?B?aHcrVzllRVd1WTVaNzRaYUdJMmRRc21BUUQyUGJqbVJ2cGVjaUdEYlhCTVVk?=
 =?utf-8?B?eUxwejFQSkVjRk5EWmJQNWs5UlBRcVpuQ2R2SG5kNUlxTTRyUlIyNHRtMThR?=
 =?utf-8?B?TG41cUlBL0pMYnZaVDh1QlZoN0Z0elAxWGJnUTZUWkhzc3dRczF6UnpSNStT?=
 =?utf-8?B?bkF0WFNZQWxoUEVpOTdhT0lzMmg2TVRwbUQ1MEtBanNZdlFrZEZJbWlwcytT?=
 =?utf-8?B?RG5BUGFoYUhHY0VoQlQvTEhyOGYxVzBZcHFPMmtnZkNmUEpTZEhrNWR1VlRt?=
 =?utf-8?B?aGdPQWc5RXI1ZzFRYTBtU1RPWUdPbjJhNG1PVmVTVEJ1S1dvRTM1Z0gwaGEz?=
 =?utf-8?B?djlTcDNOVlpjMkdMQTB6L1ljc1QxRGNEMGxGdGcrWTZkMXBXdTcvUnlJYzZ5?=
 =?utf-8?B?TURxKy9nOGVjaHdOcENraDRMZXNKNWhNYzYwVlN0TXVGWUxvR0NxQ2FqV0Jt?=
 =?utf-8?B?THp5R0c5Wk4ycGpLS1E5cGQ0SXVUWURNdHIrZ09xTm1TZHc2b2h4Z3c0MHpZ?=
 =?utf-8?B?VmJNTW9xNTJIVG9mZGJQdjV1SFJuRUN5emI1M0JMWmhjY2lxQzQ2bVd3c2Fk?=
 =?utf-8?B?VHI4RENYVDJUaldxeXl2MXJxdWVFbDZMRWFWMGdnUUF6WG9UZmZJNTNLT1Vl?=
 =?utf-8?B?MEREek5DaWdIcHlRWlMrZlNpd0lGLzlFRG1zbzRFUUg5U0x1VnEzM09HU2l1?=
 =?utf-8?B?T3NCcW1oK0NlWGExU2J5QXMvOElXV2c4UWNoakllSTZMcWMxOHRXTngrRTVt?=
 =?utf-8?B?T1JjU2ZkTEZybUZ1elNoMFJlOSt2Z25LejZBN25kZDYveWpiTDAwZWRlcGZ0?=
 =?utf-8?B?TExzYTJPMWJNRjVHU2NlcTNpNGZwekRDSFp1RDU2OU9pZnloZkJMMlpXeW1J?=
 =?utf-8?B?TkFpWnd2bm05RWsyZDRTYWhyanN6Zi9tcHppWm5lMTMzeHo3NzhJSno4emxO?=
 =?utf-8?B?RTB2SE9PUXd3TUJCUGRpRm4xVEdMM0FvSkdmUzNSeUlyQkVSd0RGVGk5N0pN?=
 =?utf-8?B?a3pZRTFSbHdPZlMzVkZzWE81cXdRWldHK2FITGtYMnA1WURkU1VkTjNtejdt?=
 =?utf-8?B?cko4QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f001745-e75e-491d-3fb1-08d8c6cc5943
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 16:13:44.7881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIe0ntd6UredW6POdzo5Igzsj82RC5YMDyidy/4E+y0xaNiHV9DZgzWxdAhoXbv1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDEuMDIuMjEgdW0gMTY6NTEgc2NocmllYiBOaXJtb3kgRGFzOgo+IFRoaXMgcGF0Y2ggY29u
c2lzdCBvZiBiZWxvdyByZWxhdGVkIGNoYW5nZXM6Cj4KPiAxIFJlbmFtZSByaW5nLT5wcmlvcml0
eSB0byByaW5nLT5od19wcmlvLgo+IDIgQXNzaWduIGNvcnJlY3QgaGFyZHdhcmUgcmluZyBwcmlv
cml0eS4KPiAzIFJlbW92ZSByaW5nLT5wcmlvcml0eV9tdXRleCBhcyByaW5nIHByaW9yaXR5IHJl
bWFpbnMgdW5jaGFuZ2VkCj4gICAgYWZ0ZXIgaW5pdGlhbGl6YXRpb24uCj4gNCBSZW1vdmUgdW51
c2VkIHJpbmctPm51bV9qb2JzLgo+Cj4gdjM6IHJlbW92ZSByaW5nLT5udW1fam9icy4KPiB2Mjog
cmVtb3ZlIHJpbmctPnByaW9yaXR5X211dGV4Lgo+Cj4gRml4ZXM6IDMzYWJjYjFmNWExNyAoImRy
bS9hbWRncHU6IHNldCBjb21wdXRlIHF1ZXVlIHByaW9yaXR5IGF0IG1xZF9pbml0IikKPiBTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgcGF0Y2ggIzEs
ICMzIAphbmQgIzQuCgpNYXliZSBwaW5nIEFsZXggZm9yIGFuIHJiIG9uIHBhdGNoICMyLgoKQ2hy
aXN0aWFuLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5n
LmMgfCA4ICsrLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Zy5oIHwgNiArLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+
IGluZGV4IDFhNjEyZjUxZWNkOS4uYjY0NGM3ODQ3NWZkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCj4gQEAgLTE2Niw3ICsxNjYsNyBAQCBpbnQgYW1kZ3B1
X3JpbmdfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLAo+ICAgCQkgICAgIHVuc2lnbmVkIGludCBtYXhfZHcsIHN0cnVjdCBhbWRncHVfaXJx
X3NyYyAqaXJxX3NyYywKPiAgIAkJICAgICB1bnNpZ25lZCBpbnQgaXJxX3R5cGUsIHVuc2lnbmVk
IGludCBod19wcmlvKQo+ICAgewo+IC0JaW50IHIsIGk7Cj4gKwlpbnQgcjsKPiAgIAlpbnQgc2No
ZWRfaHdfc3VibWlzc2lvbiA9IGFtZGdwdV9zY2hlZF9od19zdWJtaXNzaW9uOwo+ICAgCXUzMiAq
bnVtX3NjaGVkOwo+ICAgCXUzMiBod19pcDsKPiBAQCAtMjU4LDggKzI1OCw3IEBAIGludCBhbWRn
cHVfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmcsCj4gICAJfQo+ICAgCj4gICAJcmluZy0+bWF4X2R3ID0gbWF4X2R3Owo+IC0Jcmlu
Zy0+cHJpb3JpdHkgPSBEUk1fU0NIRURfUFJJT1JJVFlfTk9STUFMOwo+IC0JbXV0ZXhfaW5pdCgm
cmluZy0+cHJpb3JpdHlfbXV0ZXgpOwo+ICsJcmluZy0+aHdfcHJpbyA9IGh3X3ByaW87Cj4gICAK
PiAgIAlpZiAoIXJpbmctPm5vX3NjaGVkdWxlcikgewo+ICAgCQlod19pcCA9IHJpbmctPmZ1bmNz
LT50eXBlOwo+IEBAIC0yNjgsOSArMjY3LDYgQEAgaW50IGFtZGdwdV9yaW5nX2luaXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAkJCSZy
aW5nLT5zY2hlZDsKPiAgIAl9Cj4gICAKPiAtCWZvciAoaSA9IERSTV9TQ0hFRF9QUklPUklUWV9N
SU47IGkgPCBEUk1fU0NIRURfUFJJT1JJVFlfQ09VTlQ7ICsraSkKPiAtCQlhdG9taWNfc2V0KCZy
aW5nLT5udW1fam9ic1tpXSwgMCk7Cj4gLQo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4gaW5kZXggNzExMjEzNzY4OWRi
Li4yYWRhODBjZTQyZjUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmgKPiBAQCAtMjQyLDExICsyNDIsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3Jpbmcgewo+ICAgCXN0
cnVjdCBkbWFfZmVuY2UJKnZtaWRfd2FpdDsKPiAgIAlib29sCQkJaGFzX2NvbXB1dGVfdm1fYnVn
Owo+ICAgCWJvb2wJCQlub19zY2hlZHVsZXI7Cj4gLQo+IC0JYXRvbWljX3QJCW51bV9qb2JzW0RS
TV9TQ0hFRF9QUklPUklUWV9DT1VOVF07Cj4gLQlzdHJ1Y3QgbXV0ZXgJCXByaW9yaXR5X211dGV4
Owo+IC0JLyogcHJvdGVjdGVkIGJ5IHByaW9yaXR5X211dGV4ICovCj4gLQlpbnQJCQlwcmlvcml0
eTsKPiArCWludAkJCWh3X3ByaW87Cj4gICAKPiAgICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19G
UykKPiAgIAlzdHJ1Y3QgZGVudHJ5ICplbnQ7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
