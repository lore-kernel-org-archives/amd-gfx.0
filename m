Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EED5C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8956100C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8956100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA696EB9B;
	Tue, 18 May 2021 15:03:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511B6EB98;
 Tue, 18 May 2021 15:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdRQPQUgyxppC6Wko4p49GcD0Uwv/mWaQV/3WxUjJKTZSYfi9vr/2SbAKRTu2q74zwm/EffOMcjYZmSOBOaaQGHalAcexmhCZdoyhD1bzWYrby4XRny7M885aqnp4+XTZtVyhalt855DluF2ANHSBw26xHZoQdutDDyrDQ1A9OfO+gf39GQsdokINkHRzPECfDffbTwMipejaa/VpxUbLRhVmVXr72mR2CEXj36hOi/fvAO3qIi+LzrC2DR9tm6iuNDjZLJv1O21mcM4VSj6JcBE3y8IOTv19k1fXSLn9NyizlVURk3bGPFAAWUlnSExyr9SsO97D8jCqva68REGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djfm6oFjQkkPHJBrkae49tcmPEDos43Q1lA2uYE/d4Q=;
 b=jyB1wpKlmDY0fqMlohIjD0QPXcesOhnh57dQhxcJ9vMQM8Zx7Kx9QuSTRyEtqzaIdOJgBzfzkjVoAd7tzjsyqDaqxveZ6orwvfMDuyCSEC9+cv9uPYhvyIoWkLIpz8SSvL2fXwjLs0iu4MMlOyzkCjU6HdarBH0WbI/Mj0e6YVqV7TYRHSgJEtzm11h/LJbTrHUyFL/wZJkSsC07o8s1Fzd/KXUN+w6+YxT5UYEjaUKrouQHtvHHL+U5y8VB0D49U7iUYFeBRhhQlv42kCeak0YnyWQtjIC920TFJnCxq9pjdoAh/rrBSp1ZrP3DZh5NH3adrCJSP71X1S4AlrYQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djfm6oFjQkkPHJBrkae49tcmPEDos43Q1lA2uYE/d4Q=;
 b=joY1C5sH7WjswMQJgjlE8wvF5SZzpcWXOuoTWkJSq3FjaWMFthEht9e5pWEMzJGz7axtQIOYvsz4TDeVcJRlsKYPuesUPte6gESsbktQGnkqwrzZjgFiZF7C/oammuFH/dCfNuIGZj3hbsHxLXlUrVJXvhKgLNk7BVErtqd926c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Tue, 18 May
 2021 15:03:48 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 15:03:48 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
Date: Tue, 18 May 2021 11:03:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:19e2:b915:59c1:4860]
 (2607:fea8:3edf:49b0:19e2:b915:59c1:4860) by
 YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Tue, 18 May 2021 15:03:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ea3784-870e-4fd6-a91a-08d91a0e2399
X-MS-TrafficTypeDiagnostic: SA0PR12MB4400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4400CCCEACAECE5108A20E2AEA2C9@SA0PR12MB4400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl2F9RN5eQp8L/diwfId0M85jSyyuC+8Y4hqqPwE6qyZYOWNxhE+s/JOlk4ReqKuFxljusHUuz7sldckPPQ6lkFzGTFVbWfMI896XS/PI2qhFrQUho48g5FRGrhBlPmhOYgVVbrBZ8UtJT8wjnPyRApur0B/oINqA+tPUxGXSA9mn1YfVUUw4TuYr3+YCyFi741vFjvsrkv3kimCJCE848AwHFr1u4gYecTQT9MLNzumU29VqY7WAtCKzYPh5Ee4PFmsZLWx1KhUKaXyabLkVoIoDDtOsbCzP3YqlF9HEkzGUMSKoUW8Qd8be1gHpK7dPbRyPWN8Z65sqnn13G7HxsS1NmyohkzOFefJFkhuxrKNZpup8cHp+bwmUkk2VShv2GAiXocON91OPObPhkkUjdADFwYFcazTy20qhcEKG3VYM3cfSzdI/3b73MhTWxPD8K55imiLsj6izcKTWQDlOGinScY6Kg+bhbM5y2s/pfXkGI6LGn4EuinWkcVZbL+ddHRwkfd0d9w3xKHqL6fENxmQVMahN3aZzpySnSlE2BiSpKPypq+pP/VE4d71vMlMp6ABtajfFR5xPVctPloS9Egk2q5UI/B85ZXesjAKWbOre9aDPSS3CzoukaauCd+Sw56w6QQl/PeoBz6TA6cKaYClN4y4v/OItDSqlcMjBsa+Dp9EMaG5tLBXcj6pQVh3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(6486002)(2906002)(2616005)(316002)(36756003)(38100700002)(478600001)(16526019)(6636002)(31686004)(8936002)(66946007)(44832011)(66476007)(8676002)(86362001)(186003)(52116002)(5660300002)(53546011)(66556008)(4326008)(31696002)(66574015)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UzBUcVRmeU1sV0YranREZytVaGlxWWROTU9jdXpoUnhMZ2tpQUEyNEkrL2kz?=
 =?utf-8?B?TTNlbU1ZaXpJNS9sRms1dmxES2dibk1LWDNYdVQzVGlhNmZCTnpZeTZrdi9a?=
 =?utf-8?B?MXNnQUdJME1IaitwRlU5ZUxzdUUxNDVvd3h1V080djBkeHhNOWdOMnk0QmNr?=
 =?utf-8?B?RTNacnorNmxHSklZSzdGNmh2dC9ybnkzOVp5VUZhNzkvVDRNMWU1N1ZtWTE2?=
 =?utf-8?B?eSs2bStTL3Bvcmg3bjdZbytEakJhTHBlTHJxQjZaa2c2NWt3b2h3L0ZOMFk2?=
 =?utf-8?B?blRFWnpKYklETHNKZnlRVXB5WjVPc1Qwb0gzOStEZWxUeGVDYTUwQ1NzMVZh?=
 =?utf-8?B?Y2g4MHVCRmJFSUdvc05pMHhyVk01WEY4T2w4dVMwd01Udm85U0d4Vi9FeUlP?=
 =?utf-8?B?c1JzQzBGdFdNekQwa2tsYVoxTmRtZGJROXZUTkx0UXJicUJrd05IVDdMOGdv?=
 =?utf-8?B?VktvQ3VuY2JvYWNuZEcreEpVK3hpREEyd1dUTkpkMEg3enBIYXpOWHp1Z3FF?=
 =?utf-8?B?SGNVSjM2aVR5eUhXbVE1OGhkQzNZRUNQajV6Z004VXMrWUcxRmRhbUFpTHF1?=
 =?utf-8?B?eHo5SkZpSnBJeXZwM00yYnNiZ2hPT3FFZG5lRmxjTUgyZE5zcDFORzhLZmFx?=
 =?utf-8?B?QVFSK0pteFkwVHpkUkJEOTRYQkJNQTlZNjE1OVZMcDRIbGU3aVowTzYxakli?=
 =?utf-8?B?ZlRheXFWUmhhelBqYjB6Y2tBOHFKVFMvT0EyRnNSYmJEQzUwRWozcThyRWdX?=
 =?utf-8?B?UlRCMjFJZUllVlBnMkpFeXdma0ViNUQ2aGlhbjVKSUUxRHhCUzlKRE0rYUFB?=
 =?utf-8?B?QldmUWcySU5ESWU1YjlPMXoyUGRHaDNNU0FQVGtPQitKTG1YamhscGxIeTFI?=
 =?utf-8?B?RGg0Zk5aWWR3dlNWREtLRjI2d1B1YUxSY1lreFhWV3NOOXRhZHoxMFB2NVVX?=
 =?utf-8?B?V3pxcHN0dyt5WndGYWZJcEljR1ZycjZhbE1OTU9wM2IyZXYxcHpoYXluTkxW?=
 =?utf-8?B?M2xxMGtpZE5GNlJRQXduY29KUmYxdGQvU2dVenhtZHdDMkNvb3JVWUYzcC9j?=
 =?utf-8?B?VzNSS3ZjdzFVQU41cC9DbkFHREFhV2RUdVpSUHZlaE9sN2pFa2Z2eHZzRVdR?=
 =?utf-8?B?Uyt5ci8xczVkWDUzTkdQR1JuOUVNVjQrMEZTT1EvM0RiUE50SFh0Nkk3QWQw?=
 =?utf-8?B?bDNudENKbW44MEsyYXFvb0FrbWxaWE1uZkpLUmROK0xvNTUwTC8zenlUc0N0?=
 =?utf-8?B?ZFptR0Z4OVVtVzVlWUVrSTEvZmFlQnhoZE4wWWFtQ05uS2F2SlZuRFBDcjMw?=
 =?utf-8?B?Q3pxMDJLcEsvanczZGlhZndhOWJreWJ3dUwySUJ2UndCQUNSVHJxY3hyczFN?=
 =?utf-8?B?YVE4VjNQdTVrbHk5VTJ5RWFSRGhQZFRnandJSFZUZE95NTlCcGE1SExFUjl5?=
 =?utf-8?B?SVgxenhiQkY2WjRQL1hYYkV6T1A5dHhML0hWakFuNHNWOWV6dDA0NDVybUh1?=
 =?utf-8?B?OGREU2ZVM0ppVnFlS2RFOHhWMHFUUGQwRW1VaUo4WVlLeW5uWndVMVpESkIv?=
 =?utf-8?B?YXNkbmFuN0ZNa2Zoc0E5Vm1UUnoyWUhtNXlvWlI4WTRCZk14Qzl3UGR2N1FT?=
 =?utf-8?B?UGVEalFDaFRVMlhBcmQ3OVV2NlIydWpOY0hWU29Yc0g3QkNmSy8wNXRpbjdL?=
 =?utf-8?B?OC9MYTdRMEVJRUVnYk1JQy8wQTBoU1JVbFZwOHJXazJGVjd4UHF6bWFUdTVN?=
 =?utf-8?B?OFBWWmwrN3hZYWR4TW84cFV5UFZ2L3MwOTI1UGdZNE8wUkI5NmUwRmhhZUZD?=
 =?utf-8?B?c1hPTm43bTZtOW1IR3lDczZRelVZeTlhZnFwL1JIVWJ4d3JlRUUxM2k4NzUy?=
 =?utf-8?Q?ya22n447rTjfa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ea3784-870e-4fd6-a91a-08d91a0e2399
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 15:03:48.0202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji/Mbg0eM239kDzzg+kRuJn7mNWNnB3SmhdBcWIEDieOXpKfbiUwDtQQ6rcKd1S86nSFU+3Ic64jjFIQjZ9pFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDUtMTggMTA6MDcgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBJbiBh
IHNlcGFyYXRlIGRpc2N1c3Npb24gd2l0aCBEYW5pZWwgd2Ugb25jZSBtb3JlIGl0ZXJhdGVkIG92
ZXIgdGhlIAo+IGRtYV9yZXN2IHJlcXVpcmVtZW50cyBhbmQgSSBjYW1lIHRvIHRoZSBjb25jbHVz
aW9uIHRoYXQgdGhpcyBhcHByb2FjaCAKPiBoZXJlIHdvbid0IHdvcmsgcmVsaWFibGUuCj4gCj4g
VGhlIHByb2JsZW0gaXMgYXMgZm9sbG93aW5nOgo+IDEuIGRldmljZSBBIHNjaGVkdWxlcyBzb21l
IHJlbmRlcmluZyB3aXRoIGludG8gYSBidWZmZXIgYW5kIGV4cG9ydHMgaXQgCj4gYXMgRE1BLWJ1
Zi4KPiAyLiBkZXZpY2UgQiBpbXBvcnRzIHRoZSBETUEtYnVmIGFuZCB3YW50cyB0byBjb25zdW1l
IHRoZSByZW5kZXJpbmcsIGZvciAKPiB0aGUgdGhlIGZlbmNlIG9mIGRldmljZSBBIGlzIHJlcGxh
Y2VkIHdpdGggYSBuZXcgb3BlcmF0aW9uLgo+IDMuIGRldmljZSBCIGlzIGhvdCBwbHVnZ2VkIGFu
ZCB0aGUgbmV3IG9wZXJhdGlvbiBjYW5jZWxlZC9uZXdlciBzY2hlZHVsZWQuCj4gCj4gVGhlIHBy
b2JsZW0gaXMgbm93IHRoYXQgd2UgY2FuJ3QgZG8gdGhpcyBzaW5jZSB0aGUgb3BlcmF0aW9uIG9m
IGRldmljZSBBIAo+IGlzIHN0aWxsIHJ1bm5pbmcgYW5kIGJ5IHNpZ25hbGluZyBvdXIgZmVuY2Vz
IHdlIHJ1biBpbnRvIHRoZSBwcm9ibGVtIG9mIAo+IHBvdGVudGlhbCBtZW1vcnkgY29ycnVwdGlv
bi4KCgpJIGFtIG5vdCBzdXJlIHRoaXMgcHJvYmxlbSB5b3UgZGVzY3JpYmUgYWJvdmUgaXMgcmVs
YXRlZCB0byB0aGlzIHBhdGNoLgpIZXJlIHdlIHB1cmVseSBleHBhbmQgdGhlIGNyaXRlcmlhIGZv
ciB3aGVuIHNjaGVkX2VudGl0eSBpcwpjb25zaWRlcmVkIGlkbGUgaW4gb3JkZXIgdG8gcHJldmVu
dCBhIGhhbmcgb24gZGV2aWNlIHJlbW92ZS4KV2VyZSB5b3UgYWRkcmVzc2luZyB0aGUgcGF0Y2gg
ZnJvbSB5ZXN0ZXJkYXkgaW4gd2hpY2ggeW91IGNvbW1lbnRlZAp0aGF0IHlvdSBmb3VuZCBhIHBy
b2JsZW0gd2l0aCBob3cgd2UgZmluaXNoIGZlbmNlcyA/IEl0IHdhcwonW1BBVENIIHY3IDEyLzE2
XSBkcm0vYW1kZ3B1OiBGaXggaGFuZyBvbiBkZXZpY2UgcmVtb3ZhbC4nCgpBbHNvLCBpbiB0aGUg
cGF0Y2ggc2VyaWVzIGFzIGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25hbCBIVyBmZW5jZXMgZm9yIHRo
ZQpleHRyYWN0ZWQgZGV2aWNlIEIsIHdlIGFyZSBub3QgdG91Y2hpbmcgYW55IG90aGVyIGZlbmNl
cy4gSW4gZmFjdCBhcyB5b3UKbWF5IHJlbWVtYmVyLCBJIGRyb3BwZWQgYWxsIG5ldyBsb2dpYyB0
byBmb3JjaW5nIGZlbmNlIGNvbXBsZXRpb24gaW4KdGhpcyBwYXRjaCBzZXJpZXMgYW5kIG9ubHkg
Y2FsbCBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24KZm9yIHRoZSBIVyBmZW5j
ZXMgb2YgdGhlIGV4dHJhY3RlZCBkZXZpY2UgYXMgaXQncyBkb25lIHRvZGF5IGFueXdheS4KCkFu
ZHJleQoKPiAKPiBOb3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoYXQgY2FzZS4gT25lIHBvc3NpYmls
aXR5IHdvdWxkIGJlIHRvIHdhaXQgZm9yIAo+IGFsbCBkZXBlbmRlbmNpZXMgb2YgdW5zY2hlZHVs
ZWQgam9icyBiZWZvcmUgc2lnbmFsaW5nIHRoZWlyIGZlbmNlcyBhcyAKPiBjYW5jZWxlZC4KPiAK
PiBDaHJpc3RpYW4uCj4gCj4gQW0gMTIuMDUuMjEgdW0gMTY6MjYgc2NocmllYiBBbmRyZXkgR3Jv
ZHpvdnNreToKPj4gUHJvYmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0
aGUgdGltZSBzY2hlZF9lbnRpdHkKPj4gaXMgcmVsZWFzZWQgYW5kIGVudGl0eSdzIGpvYl9xdWV1
ZSBub3QgZW1wdHkgSSBlbmNvdW50cmVkCj4+IGEgaGFuZyBpbiBkcm1fc2NoZWRfZW50aXR5X2Zs
dXNoLiBUaGlzIGlzIGJlY2F1c2UgCj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+PiBuZXZl
ciBiZWNvbWVzIGZhbHNlLgo+Pgo+PiBGaXg6IEluIGRybV9zY2hlZF9maW5pIGRldGFjaCBhbGwg
c2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPj4gc2NoZWR1bGVyJ3MgcnVuIHF1ZXVlcy4gVGhpcyB3
aWxsIHNhdGlzZnkgZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlLgo+PiBBbHNvIHdha2V1cCBhbGwg
dGhvc2UgcHJvY2Vzc2VzIHN0dWNrIGluIHNjaGVkX2VudGl0eSBmbHVzaGluZwo+PiBhcyB0aGUg
c2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNoIHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBieSBu
b3cuCj4+Cj4+IHYyOgo+PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50
aXR5IGFuZCBtYXJraW5nCj4+IHNfZW50aXR5IGFzIHN0b3BwZWQgdG8gcHJldmVudCByZWluc2Vy
aW9uIGJhY2sgdG8gcnEgZHVlCj4+IHRvIHJhY2UuCj4+Cj4+IHYzOgo+PiBEcm9wIGRybV9zY2hl
ZF9ycV9yZW1vdmVfZW50aXR5LCBvbmx5IG1vZGlmeSBlbnRpdHktPnN0b3BwZWQKPj4gYW5kIGNo
ZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUKPj4KPj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+IFJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IC0t
LQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIHzCoCAzICsr
LQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uY8KgwqAgfCAyNCAr
KysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfZW50aXR5LmMKPj4gaW5kZXggMDI0OWM3NDUwMTg4Li4yZTkzZTg4MWI2NWYgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiBAQCAtMTE2LDcg
KzExNiw4IEBAIHN0YXRpYyBib29sIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZShzdHJ1Y3QgCj4+
IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4gwqDCoMKgwqDCoCBybWIoKTsgLyogZm9yIGxp
c3RfZW1wdHkgdG8gd29yayB3aXRob3V0IGxvY2sgKi8KPj4gwqDCoMKgwqDCoCBpZiAobGlzdF9l
bXB0eSgmZW50aXR5LT5saXN0KSB8fAo+PiAtwqDCoMKgwqDCoMKgwqAgc3BzY19xdWV1ZV9jb3Vu
dCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCj4+ICvCoMKgwqDCoMKgwqDCoCBzcHNjX3F1ZXVl
X2NvdW50KCZlbnRpdHktPmpvYl9xdWV1ZSkgPT0gMCB8fAo+PiArwqDCoMKgwqDCoMKgwqAgZW50
aXR5LT5zdG9wcGVkKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7Cj4+IMKgwqDC
oMKgwqAgcmV0dXJuIGZhbHNlOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMKPj4gaW5kZXggOGQxMjExZTg3MTAxLi5hMmE5NTM2OTNiNDUgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+IEBAIC04OTgsOSArODk4LDMzIEBAIEVY
UE9SVF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+PiDCoMKgICovCj4+IMKgIHZvaWQgZHJtX3Nj
aGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4gwqAgewo+PiArwqDC
oMKgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICpzX2VudGl0eTsKPj4gK8KgwqDCoCBpbnQgaTsK
Pj4gKwo+PiDCoMKgwqDCoMKgIGlmIChzY2hlZC0+dGhyZWFkKQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAga3RocmVhZF9zdG9wKHNjaGVkLT50aHJlYWQpOwo+PiArwqDCoMKgIGZvciAoaSA9IERSTV9T
Q0hFRF9QUklPUklUWV9DT1VOVCAtIDE7IGkgPj0gCj4+IERSTV9TQ0hFRF9QUklPUklUWV9NSU47
IGktLSkgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnEgPSAmc2No
ZWQtPnNjaGVkX3JxW2ldOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJxKQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgc3Bp
bl9sb2NrKCZycS0+bG9jayk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5
KHNfZW50aXR5LCAmcnEtPmVudGl0aWVzLCBsaXN0KQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogUHJldmVudHMgcmVpbnNlcnRpb24g
YW5kIG1hcmtzIGpvYl9xdWV1ZSBhcyBpZGxlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogaXQgd2lsbCByZW1vdmVkIGZyb20gcnEgaW4gZHJtX3NjaGVkX2VudGl0eV9maW5pCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBldmVudHVhbGx5Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc19lbnRpdHktPnN0b3BwZWQg
PSB0cnVlOwo+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnJxLT5sb2NrKTsKPj4gKwo+
PiArwqDCoMKgIH0KPj4gKwo+PiArwqDCoMKgIC8qIFdha2V1cCBldmVyeW9uZSBzdHVjayBpbiBk
cm1fc2NoZWRfZW50aXR5X2ZsdXNoIGZvciB0aGlzIAo+PiBzY2hlZHVsZXIgKi8KPj4gK8KgwqDC
oCB3YWtlX3VwX2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQpOwo+PiArCj4+IMKgwqDCoMKgwqAg
LyogQ29uZmlybSBubyB3b3JrIGxlZnQgYmVoaW5kIGFjY2Vzc2luZyBkZXZpY2Ugc3RydWN0dXJl
cyAqLwo+PiDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmc2NoZWQtPndvcmtf
dGRyKTsKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
