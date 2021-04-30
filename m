Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206A2C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D7D6145D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 18:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D7D6145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11FDD6E508;
	Fri, 30 Apr 2021 18:55:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DE36E508
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 18:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE+e6MleCQxPJkzQ/mSjM0HC4sOyx8lgAd8Pd4z8+VE1qGeSWPOdIKw2/i/tuaQJRLCCCJssnZJz7h2E4PLGSyFTbXbj9KU/RWtnO1xZF947fYrhFS2t2PNnm4/WcfTvuZjJNAXZKUA01LXuxddUdbRgrQebayRqB1rnAipdBMS7jPOUAJyoA5Daj5JMrJQ3CS2JjwRziKfCd5V7wAO24Iz2lNy6zzLiCHsgjtOTf/Tm+1dQ7nYEqVuv6PiFKb4nFl0Q9R+K6M3AN9NOZRookHXBDNLjCY+B5d2DHQfGeSFayQLNgH5+ORI/sC9NWe2iw7eURnEwocZQO3s+6Ta77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiuZ7doHmU799J8xn1d0wmzNkIX7Nhf9YhnaWp3EINY=;
 b=YQk6c5Z9NixOW8AkAG5106ddWBAv4grUv4vOKahmOuhq9to7azWSyiEnQ1l9AT9O6G2syXM1XY2Pw+NrqKxu6vrejYbioe+D13XvwGwRFAKUKtJYWVMXNkTqKfCmcFPwoCwjXH3rtbxAePI4MnJVD08aBTaXtdITTNIzkb8l1nc1E3TNC2ZmnCxtADMRNGUUYPwL8dZtU4njdc08FoxEmhaf7+pT2u+DTfVZ/pk3PndHBmq5SGUMcKdqKq1l637ZWkIcdr/SKyVmwIEAlq+kzyhuOdvoXaHhIWtfGQkFzLyltQFi/o+9j3K+sCF/q7PCUjWFhobGkyyo8xgrjcEGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiuZ7doHmU799J8xn1d0wmzNkIX7Nhf9YhnaWp3EINY=;
 b=NgweUZG9matsVHaIBymCjOP+zTz2Zk3x6zXW8hRsGJswHvIen/PFnA5wY2SvItQYLJlC062H8hr+il9ViRYM/4qbAVHCzMRaOqn0Bbmt8QAJHa1qyTMD3i+TARGpmdLO79MofQcHiqaXe43Q6sXXCzniA3ZLXHJLDmr2PtOI+dI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4816.namprd12.prod.outlook.com (2603:10b6:208:1b5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 30 Apr
 2021 18:55:30 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 18:55:30 +0000
Subject: Re: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Cornwall, Jay" <Jay.Cornwall@amd.com>
References: <20210429093609.71616-1-jonathan.kim@amd.com>
 <73D22904-489B-4F5F-ABDF-EC534F21D9F5@amd.com>
 <199d4259-0968-863a-d321-ef5c04643b9e@amd.com>
 <45E8FB48-CA0D-4209-8CFC-F9CCDF9336B6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7a575eb2-28c4-0da4-aa95-54fe4f532fbc@amd.com>
Date: Fri, 30 Apr 2021 14:55:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <45E8FB48-CA0D-4209-8CFC-F9CCDF9336B6@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 18:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6a6793e-539c-4fe2-97de-08d90c0986bc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4816D1B5E031CBFBE1C56E65925E9@MN2PR12MB4816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWChuxQcPw55kDS1hMVqqkiP/ppVLQSeb2qXuQGW/oYz4TEYl+U/DRZK6qujqF6m+fsFoqbfdyRg3Y2I0B8itMLhUWIbw8lh9JhBs32jttxYgnN9zn5Zb/O/nmVz0PEAfSxHsZPLV97atYzz368cc0+lkHU6p26IhFRYdFU9HmncouEyVLL24stPhRB7s77pVGEpOA18m7jgF7RgE6N1f3XMfvHzwqcvMQYPkIEXA5FiH8GHhwDxefBDJcSmm9OMQh2iCKcQpt/reSaf7fDjtUHk2q9PMT6Hy6gjnkA0bAWhehU4pUOFXTyVDTwIQU5pKFa0yDN/W0/CQ+gUzbXRHZpSwUpfYb65UyaNBGus1u1YZhfYj/vxAZo2BVx3QjRneFHwdca7f1WsRz3sVu8CPIJNyOMulEzRFl+08AustzYU3NbJSxq8f1YhUQ4STw6SlyH1gIZXzLkS0h/tSwFWQ9siJTyIuvxpusdGB9qmWXtO0cF8L+gxc500lSIkkOm5dXEr2KqmYhHuyqB8Az+uVa1zfuCNi7hmJQeIT8cJcWdyZetpzr6Dzg0FfukxrECbMeuwoAnisX6IciasgPZb9+0ZmpG9TVPd9v+A1wgs4e8pEL2QMni0sDfe2tvahKMS+H5WZgJ4f7dwH+b64s0BDzwaZRbjgU4f17DVGaHTaloYLOB/2KJW7ENqe4Ecctv0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(66946007)(316002)(31686004)(478600001)(66476007)(6636002)(36756003)(16576012)(8676002)(956004)(8936002)(86362001)(66556008)(6486002)(5660300002)(44832011)(83380400001)(2616005)(110136005)(31696002)(38100700002)(16526019)(186003)(53546011)(2906002)(26005)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aCs2MXliaWpQWGUxM2FFMElRVlFUdk5UWmtWb1k2VzBYdGxKSTNQQzVJM21R?=
 =?utf-8?B?UmR2bHZPWDJDZldOM0tkTVN6ekJ1YllYMXZKYSs1MnpaNlFQcG54TTI4OVNm?=
 =?utf-8?B?ZWlxR1RjSWVBay9SWWV2eVZ3clRWSG9EQmlSdUU3ZlFiMWl3K1U5bHF6d3JP?=
 =?utf-8?B?U2hkRisxQ0tmTHZpR1N4WUc1eHd6ZHk5ZVdndm1uZ3ZzYzJtVkhlcWdrcmk3?=
 =?utf-8?B?dUttdmRKVEhDNlllaFQ5bGlHYW9laldIaVN0VDVPY0FkcS9TM1FxM0ZkeU5E?=
 =?utf-8?B?ckNGcGRGdytRYlFwdHVqYjVidENPWENrTE5vQnhqMDZZUCtJc0ZWV2VkTW9h?=
 =?utf-8?B?d3V4U2dnRFNiNVJ1TFErR1FjM05XVjJqYlQ1cFFaQ296K0NKYmlpZGZqdW5i?=
 =?utf-8?B?WlVocWRTR3dpblgxSXF1dTV5QTlpeHZhVEZWdE4yTXU1WTNZR1g3dVZ6Yk9y?=
 =?utf-8?B?d2VNMzBXQytidm1OcmFKNGNpMXlqejFrMW5GWTlOVlJkckZuZGpJVzlTam5z?=
 =?utf-8?B?VlRUZHZ5R092ZlpneE5XUVgwVzA0d01qdTAzM0xrSjVNVTRVTFhFTjd1OGhp?=
 =?utf-8?B?YzlXSVhWakdpWDJCWCttRm5EYnhJUFY3S0JIQk1IWlg5L2lOOWZsQkZUazBT?=
 =?utf-8?B?TVVxd25hdUlqRDZHcWhOaGpyRXA4clUwUU1OSGdHaGhtUXdlMVRobWxYQkxn?=
 =?utf-8?B?blhrUHRlK0t3ZFJwRGZ5NUxJa3dXbWljaTRacUFxZmdzdWxsNW1Jdk1Sd1Rw?=
 =?utf-8?B?clpZUmdvdnJ5R2Y5b3dpZ1ZJaGZKUmJkazFIOUNCdUZoNWRUNThxUjhpOCs1?=
 =?utf-8?B?WkxZNXNHcGdzOHl0U05jNnVPSXZVZXFZbE1CNGdzMDgrWjk5Mkx0aE01aURV?=
 =?utf-8?B?a1g2UUNRUDVCNUZ5L0FjUVZFQ1VpUTVZbnk2cUcrbWtIdlM5ZWU1bG9Xajk1?=
 =?utf-8?B?ZkRrMkV1KzdBQUtBeU9OYVBRN3hIM1pSZWRCWE0yM09Ea3JUYVpJc1lUUzFx?=
 =?utf-8?B?a1lNbW56K2VXaWFONm9IeXowMDdhTzR6VTV0c2V5UnhtMGZNUjc2T0lqQWln?=
 =?utf-8?B?UC9tN0RqbCs4YzFFSzFqMVl2MHdneTByTjVKMVFuMENqZzA1QUVqRVQ2eG1P?=
 =?utf-8?B?WWt1bkM4cGxic1JpQk9zeitmcnZud20wdFhOczg1bktDWVR5STlWT1BCenhz?=
 =?utf-8?B?SkJWb1pSYVJyWUVaK3lOa2RXSCthMUdZRldFcXBqVVhHVUFFU0pNOXZ3WE5Q?=
 =?utf-8?B?a0RMSmc0alIrSmZDWUlsWUhZT1ZCNW1VRS9ReHd6VkZqcGYrcEFqTzMrbzgx?=
 =?utf-8?B?V3dNSzRlWEtiMzF1WHhhK3dKVytEekcwQzAyb1RNUEFMaWhOVkdpclhmQWFr?=
 =?utf-8?B?QUljaVN0aWdDZXgxM3N2T1dTZi84cjlkZVVVUzJFbFg4K2xCOGkvY2MxNDBY?=
 =?utf-8?B?RHFrNmhMVWovYTZEY0VhUWhoN0kzV3FvQ1VMc0tEQlNmVWJPWjBMTUJKd1o0?=
 =?utf-8?B?bzVERUhoZDEzRVh1MlRBZDB0S3dkaVFUdkxtZVBucHF6OGttcjA2ZjlwNUVw?=
 =?utf-8?B?OGJ2Z0h4K3VsRzYwSkpoRHJLYnY2MnNTcnlxZm5NWnBxNVJIbUdxdThEMG5j?=
 =?utf-8?B?YmpvK0dGMUN5Z1lqUm9KTWJ0YlA0V2pmN3NXMk1iRVBldGJCd1lQdVBMVFBp?=
 =?utf-8?B?VjRaQXVEQWtTbkxJdXJZeVVVQ0NvQ3hWR2trZWNsLzR5YUw1bnYzOEgwRjZS?=
 =?utf-8?Q?+ka98pDT9ONBtYUz2/KXiHg2KWJa4ApOkTqzrxH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a6793e-539c-4fe2-97de-08d90c0986bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 18:55:30.6820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ehKxjjddpTY4Y1NPYS5SKNa16ktwTg5BGD+UVJydw9IoMznK1QfDJNVQwzlX8ZjhLwEvrRMMwK9lqcIh3xA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4816
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0zMCB1bSAyOjE2IHAubS4gc2NocmllYiBaZW5nLCBPYWs6Cj4gU29ycnkgSSBz
aG91bGQgYmUgY2xlYXJlci4gCj4KPiBkZXYtPmdwdS0+cGNpX2F0b21pY19yZXF1ZXN0ZWQgaXMg
c2V0IHRvIHRoZSB2YWx1ZSBvZiBhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCAtIHNlZSBmdW5j
dGlvbiBhbWRncHVfYW1ka2ZkX2hhdmVfYXRvbWljc19zdXBwb3J0LiBhZGV2LT5oYXZlX2F0b21p
Y3Nfc3VwcG9ydCBpcyBzZXQgdGhyb3VnaCBmdW5jdGlvbiBwY2lfZW5hYmxlX2F0b21pY19vcHNf
dG9fcm9vdCBjdXJyZW50bHkgaW4gYW1kZ3B1X2RldmljZV9pbml0IC0gSSBkb24ndCB0aGluayB0
aGlzIGxvZ2ljIGlzIGNvcnJlY3QgZm9yIHhnbWkgY29ubmVjdGVkIGRldmljZXMuIEZvciB4Z21p
IGNvbm5lY3RlZCBkZXZpY2VzLCBhZGV2LT5oYXZlX2F0b21pY3Nfc3VwcG9ydCBzaG91bGQgYWx3
YXlzIHNldCB0byB0cnVlLiArQENvcm53YWxsLCBKYXkgdG8gY29tbWVudCBhcyB0aGUgb3JpZ2lu
YWwgYXV0aG9yIG9mIHRoaXMgY29kZXMuCj4KPiBUaGUgY29kZXMgSm9uIHB1dCBiZWxvdyByZWZl
cnMgZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVzdGVkIHRvIHNldCB0aGUgaW8gbGluayBwcm9w
ZXJ0aWVzLiBJIHRoaW5rIHdlIHNob3VsZCBmaXggYWRldi0+aGF2ZV9hdG9taWNzX3N1cHBvcnQg
d2hpY2ggaXMgdGhlIHNvdXJjZSBvZiBkZXYtPmdwdS0+cGNpX2F0b21pY19yZXF1ZXN0ZWQuIE9u
Y2UgYWRldi0+aGF2ZV9hdG9taWNzX3N1cHBvcnQgaXMgZml4ZWQsIHBhcnQgb2YgdGhlIGNvZGUg
aW4ga2ZkX3RvcG9sb2d5LmMgZG9lc24ndCBuZWVkIHRvIGJlIGNoYW5nZWQuCgpJIGRpc2FncmVl
LiBZb3UncmUgYmFzaWNhbGx5IGp1c3QgY2hhbmdpbmcgdGhlIG5hbWUgb2YgYSB2YXJpYWJsZS4g
VGhhdApkb2Vzbid0IGNoYW5nZSBhbnkgb2YgdGhlIGxvZ2ljLgoKCj4gIEN1cnJlbnRseSBrZmRf
dG9wb2xvZ3kuYyBpcyB0aGUgb25seSBjb25zdW1lciBvZiBhZGV2LT5oYXZlX2F0b21pY3Nfc3Vw
cG9ydCBhbmQgc2VlbXMgd2Ugb25seSB1c2Ugc3VjaCBpbmZvcm1hdGlvbiBmb3IgZ3B1LWdwdSBp
by1saW5rIG5vdCBmb3IgZ3B1LWNwdSBpb2xpbmsgcHJvcGVydGllcy4gQnV0IEkgc3RpbGwgdGhp
bmsgd2UgZml4IGl0IGZyb20gdGhlIHNvdXJjZSBpcyBiZXR0ZXIgYmVjYXVzZSBpbiB0aGUgZnV0
dXJlIHRoZXJlIG1pZ2h0IGJlIGNvZGUgcmVmZXJzIHRvIGFkZXYtPmhhdmVfYXRvbWljc19zdXBw
b3J0LiBUaGUgY29kZSBJIHB1dCBiZWxvdyBpcyB3cm9uZyB0aG91Z2gsIGl0IHNob3VsZCBiZTog
Cj4gSWYgKCFhZGV2LT5nbWMueGdtaS5udW1fcGh5c2ljYWxfbm9kZXMpCj4gCXIgPSBwY2lfZW5h
YmxlX2F0b21pY19vcHNfdG9fcm9vdChhZGV2LT5wZGV2LAo+IAkJCQkJICBQQ0lfRVhQX0RFVkNB
UDJfQVRPTUlDX0NPTVAzMiB8Cj4gCQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0
KTsKCk5vLiBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9fcm9vdCBlbmFibGVzIHRoZSBHUFUgdG8g
cGVyZm9ybSBhdG9taWMgb3BzCm9uIHN5c3RlbSBtZW1vcnkgb3ZlciBQQ0llLiBUaGUgbnVtYmVy
IG9mIG5vZGVzIGluIGFuIFhHTUkgaGl2ZSBoYXMgbm8KaW5mbHVlbmNlIG9uIHRoaXMuIFRoZSBv
bmx5IHNpdHVhdGlvbiB3aGVyZSB3ZSBkb24ndCBuZWVkIHRoaXMgaXMgb24KR1BVcyB0aGF0IGNv
bm5lY3QgdG8gdGhlIGhvc3QgdmlhIFhHTUkuIFNvIHRoZSBjb25kaXRpb24gaWYKKCFhZGV2LT5n
bWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSBpcyBjb3JyZWN0LgoKUmVnYXJkcywKwqAgRmVsaXgK
Cgo+Cj4gUmVnYXJkcywKPiBPYWsgCj4KPiAgCj4KPiDvu79PbiAyMDIxLTA0LTI5LCAxMDo0NSBQ
TSwgIkt1ZWhsaW5nLCBGZWxpeCIgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IHdyb3RlOgo+Cj4K
PiAgICAgQW0gMjAyMS0wNC0yOSB1bSA5OjEyIHAubS4gc2NocmllYiBaZW5nLCBPYWs6Cj4gICAg
ID4gSSB0aGluayBwYXJ0IG9mIHRoaXMgY2FuIGJlIGRvbmUgbW9yZSBjbGVhbiBpbiBhbWRncHVf
ZGV2aWNlX2luaXQ6Cj4gICAgID4KPiAgICAgPiAJciA9IDA7Cj4gICAgID4gCUlmICghYWRldi0+
Z21jLnhnbWkuY29ubmVjdGVkX3RvX2NwdSkKPiAgICAgPiAJCS8qIGVuYWJsZSBQQ0lFIGF0b21p
YyBvcHMgKi8KPiAgICAgPiAJCXIgPSBwY2lfZW5hYmxlX2F0b21pY19vcHNfdG9fcm9vdChhZGV2
LT5wZGV2LAo+ICAgICA+IAkJCQkJICBQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8Cj4g
ICAgID4gCQkJCQkgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KTsKPiAgICAgPiAJaWYg
KHIpIHsKPiAgICAgPiAJCWFkZXYtPmhhdmVfYXRvbWljc19zdXBwb3J0ID0gZmFsc2U7Cj4gICAg
ID4gCQlEUk1fSU5GTygiUENJRSBhdG9taWMgb3BzIGlzIG5vdCBzdXBwb3J0ZWRcbiIpOwo+ICAg
ICA+IAl9IGVsc2Ugewo+ICAgICA+IAkJYWRldi0+aGF2ZV9hdG9taWNzX3N1cHBvcnQgPSB0cnVl
Owo+ICAgICA+IAl9Cj4KPiAgICAgVGhpcyBjb2RlIGlzIGFscmVhZHkgaW4gYW1kZ3B1X2Rldmlj
ZV9pbml0LiBJJ20gbm90IHN1cmUgd2hhdCdzIHlvdXIKPiAgICAgcG9pbnQuIEFyZSB5b3Ugc3Vn
Z2VzdGluZyB0aGF0IHRoZSB0b3BvbG9neSBmbGFncyBzaG91bGQgYmUgdXBkYXRlZCBpbgo+ICAg
ICBhbWRncHVfZGV2aWNlX2luaXQ/IFRoYXQncyBub3QgcmVhbGx5IHBvc3NpYmxlIGJlY2F1c2Ug
dGhlIEtGRCB0b3BvbG9neQo+ICAgICBkYXRhIHN0cnVjdHVyZXMgZG9uJ3QgZXhpc3QgYXQgdGhh
dCB0aW1lICh0aGV5IGRvIG9ubHkgYWZ0ZXIgdGhlIGNhbGwgdG8KPiAgICAgYW1kZ3B1X2Rldmlj
ZV9pcF9pbml0KSBhbmQgdGhlIGRhdGEgc3RydWN0dXJlcyBhcmUgbm90IGtub3duIGluCj4gICAg
IGFtZGdwdV9kZXZpY2UuYy4gSXQncyBjbGVhbmVyIHRvIGtlZXAgdGhpcyBjb21wYXJ0bWVudGFs
aXplZCBpbgo+ICAgICBrZmRfdG9wb2xvZ3kuYy4KPgo+ICAgICBSZWdhcmRzLAo+ICAgICAgIEZl
bGl4Cj4KPgo+ICAgICA+IFJlZ2FyZHMsCj4gICAgID4gT2FrIAo+ICAgICA+Cj4gICAgID4gIAo+
ICAgICA+Cj4gICAgID4gT24gMjAyMS0wNC0yOSwgNTozNiBBTSwgIktpbSwgSm9uYXRoYW4iIDxK
b25hdGhhbi5LaW1AYW1kLmNvbT4gd3JvdGU6Cj4gICAgID4KPiAgICAgPiAgICAgTGluayBhdG9t
aWNzIHN1cHBvcnQgb3ZlciB4R01JIHNob3VsZCBiZSByZXBvcnRlZCBpbmRlcGVuZGVudGx5IG9m
IFBDSWUuCj4gICAgID4KPiAgICAgPiAgICAgU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxq
b25hdGhhbi5raW1AYW1kLmNvbT4KPiAgICAgPiAgICAgVGVzdGVkLWJ5OiBSYW1lc2ggRXJyYWJv
bHUgPHJhbWVzaC5lcnJhYm9sdUBhbWQuY29tPgo+ICAgICA+ICAgICAtLS0KPiAgICAgPiAgICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIHwgMjkgKysrKysrKysr
KysrKystLS0tLS0tLS0KPiAgICAgPiAgICAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCAxMSBkZWxldGlvbnMoLSkKPiAgICAgPgo+ICAgICA+ICAgICBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+ICAgICA+ICAgICBpbmRleCAwODNhYzliYWJmYTgu
LjMwNDMwYWVmY2ZjNyAxMDA2NDQKPiAgICAgPiAgICAgLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiAgICAgPiAgICAgKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiAgICAgPiAgICAgQEAgLTExOTYsNiArMTE5Niw3
IEBAIHN0YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlua19ub25fY3JhdF9pbmZvKHN0cnVjdCBrZmRf
dG9wb2xvZ3lfZGV2aWNlICpkZXYpCj4gICAgID4gICAgICB7Cj4gICAgID4gICAgICAJc3RydWN0
IGtmZF9pb2xpbmtfcHJvcGVydGllcyAqbGluaywgKmNwdV9saW5rOwo+ICAgICA+ICAgICAgCXN0
cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpjcHVfZGV2Owo+ICAgICA+ICAgICArCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2Owo+ICAgICA+ICAgICAgCXVpbnQzMl90IGNhcDsKPiAgICAgPiAg
ICAgIAl1aW50MzJfdCBjcHVfZmxhZyA9IENSQVRfSU9MSU5LX0ZMQUdTX0VOQUJMRUQ7Cj4gICAg
ID4gICAgICAJdWludDMyX3QgZmxhZyA9IENSQVRfSU9MSU5LX0ZMQUdTX0VOQUJMRUQ7Cj4gICAg
ID4gICAgIEBAIC0xMjAzLDE4ICsxMjA0LDI0IEBAIHN0YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlu
a19ub25fY3JhdF9pbmZvKHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpkZXYpCj4gICAgID4g
ICAgICAJaWYgKCFkZXYgfHwgIWRldi0+Z3B1KQo+ICAgICA+ICAgICAgCQlyZXR1cm47Cj4gICAg
ID4KPiAgICAgPiAgICAgLQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZChkZXYtPmdwdS0+cGRl
diwKPiAgICAgPiAgICAgLQkJCVBDSV9FWFBfREVWQ0FQMiwgJmNhcCk7Cj4gICAgID4gICAgIC0K
PiAgICAgPiAgICAgLQlpZiAoIShjYXAgJiAoUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QMzIg
fAo+ICAgICA+ICAgICAtCQkgICAgIFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09NUDY0KSkpCj4g
ICAgID4gICAgIC0JCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJf
QklUIHwKPiAgICAgPiAgICAgLQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklU
Owo+ICAgICA+ICAgICArCWFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKikoZGV2LT5ncHUt
PmtnZCk7Cj4gICAgID4gICAgICsJaWYgKCFhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1
KSB7Cj4gICAgID4gICAgICsJCXBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGRldi0+Z3B1LT5w
ZGV2LAo+ICAgICA+ICAgICArCQkJCVBDSV9FWFBfREVWQ0FQMiwgJmNhcCk7Cj4gICAgID4gICAg
ICsKPiAgICAgPiAgICAgKwkJaWYgKCEoY2FwICYgKFBDSV9FWFBfREVWQ0FQMl9BVE9NSUNfQ09N
UDMyIHwKPiAgICAgPiAgICAgKwkJCSAgICAgUENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QNjQp
KSkKPiAgICAgPiAgICAgKwkJCWNwdV9mbGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01J
Q1NfMzJfQklUIHwKPiAgICAgPiAgICAgKwkJCQlDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNT
XzY0X0JJVDsKPiAgICAgPiAgICAgKwl9Cj4gICAgID4KPiAgICAgPiAgICAgLQlpZiAoIWRldi0+
Z3B1LT5wY2lfYXRvbWljX3JlcXVlc3RlZCB8fAo+ICAgICA+ICAgICAtCSAgICBkZXYtPmdwdS0+
ZGV2aWNlX2luZm8tPmFzaWNfZmFtaWx5ID09IENISVBfSEFXQUlJKQo+ICAgICA+ICAgICAtCQlm
bGFnIHw9IENSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwKPiAgICAgPiAgICAg
LQkJCUNSQVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfNjRfQklUOwo+ICAgICA+ICAgICArCWlm
ICghYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25vZGVzKSB7Cj4gICAgID4gICAgICsJCWlm
ICghZGV2LT5ncHUtPnBjaV9hdG9taWNfcmVxdWVzdGVkIHx8Cj4gICAgID4gICAgICsJCQkJZGV2
LT5ncHUtPmRldmljZV9pbmZvLT5hc2ljX2ZhbWlseSA9PQo+ICAgICA+ICAgICArCQkJCQkJCUNI
SVBfSEFXQUlJKQo+ICAgICA+ICAgICArCQkJZmxhZyB8PSBDUkFUX0lPTElOS19GTEFHU19OT19B
VE9NSUNTXzMyX0JJVCB8Cj4gICAgID4gICAgICsJCQkJQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRP
TUlDU182NF9CSVQ7Cj4gICAgID4gICAgICsJfQo+ICAgICA+Cj4gICAgID4gICAgICAJLyogR1BV
IG9ubHkgY3JlYXRlcyBkaXJlY3QgbGlua3Mgc28gYXBwbHkgZmxhZ3Mgc2V0dGluZyB0byBhbGwg
Ki8KPiAgICAgPiAgICAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGxpbmssICZkZXYtPmlvX2xpbmtf
cHJvcHMsIGxpc3QpIHsKPiAgICAgPiAgICAgLS0gCj4gICAgID4gICAgIDIuMTcuMQo+ICAgICA+
Cj4gICAgID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
