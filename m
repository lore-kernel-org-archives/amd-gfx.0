Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B19C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 14:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10436522D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10436522D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4435F6E064;
	Tue,  9 Mar 2021 14:33:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9235F6E064
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 14:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtYrA3l2phq0E6bD3mWCCX41BwV2av1BWIT2Y8kRptC1w/YouxOg/j1N+vdsG8Cot7C/WzGHXIWe+D5rPqVSPcZ+f71yMRoAv1JolFqIZzEPxKmVfocCN20NeXqINlJevDpimzzA2npd5wdQ5Awx5IRKe9tbj4p+rlUAr9UHi/MuQve0mrhIlyFGXutKYX5qWi/1lQleAd8UtqAias9bGJv7x3FwN11BDwR3So96IbaC73hoRlaw5Kz6K275hI55os8ZNoF2yBkStnzQXr7K9Z38eghyJI0Xv2QsNd8j0ORoGj7bBSePAnUapNa5F9Urq1PEe1l6gLV897L+MTvgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9zIk60rvaq7ylUc5fwxIhqRcwxuKUiwj8WSWswftOA=;
 b=k0S4E+oik9NCx5qtZjQlvFMNrZKMe0cVenOtBakHcgtgLRCfrRoDHloUX4oA5iYdJ+IwOxK3wZGmo41EJ0QfMYTTK/TuUCZXXz+q5xtl5lg5KgVutbRs88OCPphkb0ZxgMccbKOI+3lhHSDoyZtnONbWkP+L5QxauFTfjHqcCV7ap546U+Cegfwzw/ofcjVEeLNNz53GuHkDPnimou8aH8cRaRCF/3qrThRQ5K6LVH9T7OCbU4mu8nrTs72nGDN5kOeXbBmrv9ZZ1rRJiZaqlnIJY66bJeptoYu2SQozP8Hrr/26znjrNteotrCXTtd1XGYELsv2BM/3DdDOAwL24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9zIk60rvaq7ylUc5fwxIhqRcwxuKUiwj8WSWswftOA=;
 b=ztm2vKXREYEPOgQZ0wStVliJ6qRgkEBWF42skg/B2f/no/pmUoGlgO16Eu54ffq4KQp+uHImtTeI8XTFX5dCS8em8C06/TV5RDd5g+EF3t+zy66FJd8y+Rxkj225/4Rf41mItts8ufjM0u+Bg7qv+5ioU1wZb7/pKOL2H7M/qOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 14:33:50 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 14:33:50 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-3-nirmoy.das@amd.com>
 <03c65172-7b17-7b80-7b15-cc687fb45fa0@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <889d26bb-4281-f9be-6f72-a96f7359b572@amd.com>
Date: Tue, 9 Mar 2021 15:33:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <03c65172-7b17-7b80-7b15-cc687fb45fa0@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN7PR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:408:34::14) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.69] (165.204.84.11) by
 BN7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:408:34::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 14:33:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76534407-9f10-4f86-54ce-08d8e3085b57
X-MS-TrafficTypeDiagnostic: CY4PR12MB1640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1640F7B596DC71268D051F8A8B929@CY4PR12MB1640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpmLSO1Es6mM8RtNUvENfbzWJ3uSvWrHcq+paZSBgz6ikZs/La+Iloe9bIX1bIB3FhOmAjJT/SHKHlkjFgZCKyP3dWBSpqDviExefR02cAbYB9qn0PvtuFIuZxM6oW6aHE2558asQ6wGOMbB46q977/3MtG9awm/17sED37oOq7oJsCuqCwi70Ps+UFxo/BHNoOdh3a1omqsQnBVgPtPR25ytuOoTIYU5PEKyoNqb5hhO4TzMrxhKnKzgvcwksVBE+fl8NcDf6tgXnjZYF3G93+onB8JSbZk5A9hp5RPzpduKDGDStJtn1hG+LQN+gzaw/FGUtfYwPKprxk/423N/OeJe6p+Xh3SsZi5iZBUnojq9S1oiDVw9nd0Bq13E2cjF8hXIKv9pQXQnptwwvv7Y0sBeVOnjJYv0w9wMqz7gUR1VAl5JTfwViog182iRD8HYKHcAvk8D5KqdZC3943dVOQSRfMwQQrlze2pRQ8SbrhoparAzmHYh1HxOBjEfy9BAWaz5sAMFACgu7ZeSOgY26ljAaozaOmOmRA917ZX7v7M229ykB42Ed4QJN1w8NP6tgr2Ou0yN/O4suTJkjIGZH0yXD5MqhPaplVYZMLOOfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4326008)(26005)(6636002)(31696002)(2616005)(5660300002)(83380400001)(66574015)(66556008)(66946007)(8676002)(478600001)(36756003)(66476007)(316002)(8936002)(31686004)(52116002)(16576012)(110136005)(53546011)(186003)(16526019)(6486002)(956004)(2906002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUJ1YWxURlVpM3JZOWdmU0lvVXRsVTd0UG9zQjY5eDc5WXI1TVhJT0V3V2VF?=
 =?utf-8?B?T0pjcktlalpJcGd5SStpOU5vRWJBbUg2RTB0OTZwdlRvUWtjbGhVWG04WCty?=
 =?utf-8?B?UWxrNnpXMlAzRDJBanNDVWdtRzFtRnhVWUI5VVhkYlpkMVhyZURjT0RUVEdP?=
 =?utf-8?B?RmVRcWNUVkwvRktoa2NaeXFUa1VxU01GZm1mSGsweW5vNXgvRVJGR3UrcEJ6?=
 =?utf-8?B?aDZOUWJ5MXlLanJoWXZsUDUrckdpblhXSGVaVkI1UVZXT211Ukx0SUNMb0RH?=
 =?utf-8?B?YnVNdWN1SXFOcXRPdnJ0TzRYQ3lxaUtkTnU5TW9KT3AxWHVWMFZ3bUNTc0pX?=
 =?utf-8?B?N0ZiR2NhWkhpN05POStKSU4wajg4NFdWZFlNUG9WVWNmM2p0Y2VqQmwzK1Vt?=
 =?utf-8?B?eWIrZkhneG9SSjNZRlRtVmovNGhiaHJOQ3dCK2pYbk14TVRzaE90cExML0ZX?=
 =?utf-8?B?TmFyaTd2eW5SNlUwdUtuOG9rUlBCdDliTEJSWXl0QzdiNnZNTENiUnhwZ1pn?=
 =?utf-8?B?V0JOWjV4UkVvLytBczRnVnh2NVpCd01iVnN0STZBczh0SXhCMEc3SnQvdEhw?=
 =?utf-8?B?ejNyc0wzM01wTGxMaVJkNXRFOGk3SDhteElBOGl1MGFzOXVONDFFcDZjdVQ2?=
 =?utf-8?B?OGdjdHJNbnJMUnc5ZTltbTNBZzlMQy95TWJUUlg4RlE4NUhqUVRqRVl2bDhO?=
 =?utf-8?B?cTdhQjZyQUxOb0h2Z2ZDZ0tMeEE5bE14SmdqcHEzWG0xcHZrWTRaM1F4UDlM?=
 =?utf-8?B?aDgrYVhCZko4ckswZ2pMZ3d3UDNrTXNSeTlnWlQ5eXZ1TmhPMkNSS25DalN2?=
 =?utf-8?B?WGkzeVNUYUFRb0JPZkpoNWd1Z2t3d0xKQkZpTUlHWERwZ253QTgrK29BQjM3?=
 =?utf-8?B?aEw1Z0pnaFJCSEN0d2Z2TkFwU0ZVaDZENVFHbFhNekMxbjZrNm5UR0RMOVZz?=
 =?utf-8?B?SlNFNlBGZHp5N2Z4M1IrRlR0NEhnOFcvNHpyR2RBbkRzWmZsbUVRMmpxUWhE?=
 =?utf-8?B?d25pMUVOaWNlZm9mN0RibTZhbmhWYWpMdmRmRTllWWxsTkVZcnhGbkxZVzl6?=
 =?utf-8?B?Q3UwZ1JPSVcrQjJ0QTZGbzZSY3hpakZEUUlrYWc0WC9TZjRYZXo1clRCUDBw?=
 =?utf-8?B?Rk13NC9jdERLMG1ZQ0doOFIxUGxxalZvQm80MWtlRjQ3UWVzT0gwMDJIMCtE?=
 =?utf-8?B?VFBSVnBSYm9lQWxXZVlCbmplZEErS01KLzNFM2psa0wwUFRQQ0pwNlp6Wnd4?=
 =?utf-8?B?bGtBeGZOZGZOTGZnQzE3SVM5a3gvQUQzMmpDK2RNUjJpSUJOKzhjeS9BU1lU?=
 =?utf-8?B?cHgrUWRxUlR2RUdYTUhOUjUwUVBBN2ZDODlFTG40TElQbTNTd052Vk1xa2py?=
 =?utf-8?B?R1NvZ2ZHVnFhODdOMGN2bjN4MFZrUFAvUDlwSFV5bU5DWnRGN0hGRjlCaFlU?=
 =?utf-8?B?QXVCNnhFN2U3U0xpbyt1TjNRUEVVZXhyQTlmYUVVRlNFZmljL3FWU1d6ZEdC?=
 =?utf-8?B?QlBYRGNoVVY1QnlKMkg3cm5EV2pMV3R6cEduMklTSjFTNWlMRVR4Z0RUTUZl?=
 =?utf-8?B?dVU2UTNBQXltb3hXWnJ2bnl0Q05tRkkvMnBxRzBPRFRRRUtQWkRGVkJua3FP?=
 =?utf-8?B?cklocDl0Mm9TZ3Y0R3VJTlRIWnE1MHlUWXovZnprWE5yOGpJN0FIYWZBdHNz?=
 =?utf-8?B?M1hLNFMzTSt1aE5EZHV5ZytkYm80aXl0cUJXVFRla3ExN0FockJaY2tUN1Rv?=
 =?utf-8?Q?m27qr0857aEg9v2C8DBCV5gynnyXpOQu3a2839b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76534407-9f10-4f86-54ce-08d8e3085b57
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 14:33:50.7257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3G/MG8/kk6BNA9IayKMCCjPQNapBjcrff2A/UwYif97u88g6q60SB0Jmb/E/yvUkxHINulVHm1zdPyl1xAuxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvOS8yMSAxOjM5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDA5LjAzLjIx
IHVtIDA5OjQ2IHNjaHJpZWIgTmlybW95IERhczoKPj4gRkIgQk8gc2hvdWxkIG5vdCBiZSB0dG1f
Ym9fdHlwZV9rZXJuZWwgdHlwZSBhbmQKPj4gYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3Qo
KSBwaW5zIHRoZSBGQiBCTyBhbnl3YXkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMg
PG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mYi5jIHwgMiArLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mYi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9mYi5jCj4+IGluZGV4IDUxY2Q0OWM2ZjM4Zi4uMjQwMTBjYWNmN2QwIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwo+PiBAQCAtMTQ2LDcgKzE0Niw3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3Qoc3RydWN0IAo+PiBhbWRncHVf
ZmJkZXYgKnJmYmRldiwKPj4gwqDCoMKgwqDCoCBzaXplID0gbW9kZV9jbWQtPnBpdGNoZXNbMF0g
KiBoZWlnaHQ7Cj4+IMKgwqDCoMKgwqAgYWxpZ25lZF9zaXplID0gQUxJR04oc2l6ZSwgUEFHRV9T
SVpFKTsKPj4gwqDCoMKgwqDCoCByZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwg
YWxpZ25lZF9zaXplLCAwLCBkb21haW4sIAo+PiBmbGFncywKPj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR0bV9ib190eXBlX2tlcm5lbCwgTlVMTCwgJmdv
YmopOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHRt
X2JvX3R5cGVfZGV2aWNlLCBOVUxMLCAmZ29iaik7Cj4KPiBDYW4geW91IGRvdWJsZSBjaGVjayBp
ZiB3ZSBzdGlsbCBuZWVkIHRoZSB0dG1fYm9fdHlwZV8qIHBhcmFtZXRlciB0byAKPiBhbWRncHVf
Z2VtX29iamVjdF9jcmVhdGUoKSBhZnRlciBhbGlnbmluZyB0aGlzPwoKCldlIG5lZWQgdGhhdCBp
biBvbmx5IG9uZSBwbGFjZToKCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFf
YnVmLmMgLS0+IGFtZGdwdV9kbWFfYnVmX2NyZWF0ZV9vYmooKQoKNDQ1OiByZXQgPSBhbWRncHVf
Z2VtX29iamVjdF9jcmVhdGUoYWRldiwgZG1hX2J1Zi0+c2l6ZSwgUEFHRV9TSVpFLAoKNDQ2LSDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIEFN
REdQVV9HRU1fRE9NQUlOX0NQVSwgZmxhZ3MsCgo0NDctIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgdHRtX2JvX3R5cGVfc2csIHJlc3YsICZn
b2JqKTsKCgoKTmlybW95Cgo+Cj4gVGhhbmtzLAo+IENocmlzdGlhbi4KPgo+PiDCoMKgwqDCoMKg
IGlmIChyZXQpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByX2VycigiZmFpbGVkIHRvIGFsbG9j
YXRlIGZyYW1lYnVmZmVyICglZClcbiIsIGFsaWduZWRfc2l6ZSk7Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOT01FTTsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
