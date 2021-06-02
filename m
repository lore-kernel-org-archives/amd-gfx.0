Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B6C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 05:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D947661361
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 05:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D947661361
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638036EA09;
	Wed,  2 Jun 2021 05:48:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6EE6EA09
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 05:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n503bmb9ir4HNuy+QjoCer5Nt8vfSzqsDWWt55mjM6FPYf5hNhrCq+zZISo7kFkfSn8nT0vHm1uNB1Iui1HIkIvAhz/O27fZ+EMDZxeK9yLTiCF2pyY5ZaejCf4z2kZIvBrAxzUYs2sk9hA+0mjH+2HkumrPy+8kaoCw6W7/1d/TjV/6Wb7lf/e/VFnovCNT5up+cBxwJIKo2csmdeogeB+qnQRZKzmRKW4aZiTukP+4dVnetCLmj8KGwRgnq7N9rv13QhOyo2LQm3AEzsuTq8QNEoEG7HOoMltU4yI1dnblhYbQ5TJrtSMdJEIoLHdFRiRUH9YB044FW7YePdRcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+4cJxeabsa0zb1e97TIAkKzeKDXljJN1zNlv04i+h4=;
 b=ibJ+GjVXhSMGomQcUhLQILzq93n/9dU/G4QCK9PKbpWJS7jYoZpGITAtlvNDjL41EigiIh0XMWdmihg4sNszv0fQxSGWMw0zm0AM9cac3TF7FCctgjaTyp2NpZjgrmqJk0LDowm5Rx+cQdg7/RYd5icXE4ZSc6ckia3c135KwdymDmIXm1tkNagVe6sKg8kNPn7jzq+3ClZbD1Oyz1bhpEsew2+e/1ueD4OJsDcPi+UAMfoj9E0PS5D+EKEa0TqDymw5VmZbYJrkGQxH8a1gSZCQ3Dd321iTYi9AJ96LRQiaQyUePAkwe+BjvW2U0ygzyuQOBGpQlBP2N+XkgenptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+4cJxeabsa0zb1e97TIAkKzeKDXljJN1zNlv04i+h4=;
 b=Ty5NQwQRZGyOUjgq7WLBIkwxb7RCsvKOKFxw9P1IRCaWwDhzO7tANyFnQ/h9ZhG+eeNblbTBkrCwG46sD8bk0KC2SEZAuZ/2daT9UOiWbY8r0fQEV4DZHpaLLUkIDUEHGHjzBj0gbvY0sxu/Dp3EaYz6GTxcv6/wSdR3M84w04g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Wed, 2 Jun 2021 05:48:06 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 05:48:06 +0000
Subject: Re: [PATCH 1/4] drm/amdkfd: Create node in kfd sysfs for memory only
 numa node
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4f8c5cae-d7c4-7bba-b9df-807fb6a47346@amd.com>
Date: Wed, 2 Jun 2021 01:48:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1622574457-4447-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26 via Frontend
 Transport; Wed, 2 Jun 2021 05:48:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bd8ee6-00d0-4933-4e8b-08d92589fe99
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296A44E78AE6627947486CC923D9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9oJPRe4ICnyJoMoQ08EFl3nZmgeqTrpXu65E1qnFan5tlWT82rhtWbU80kO88E8t/wPvDpuu+IlyN0e5EmwThbUxkDU0qryxxyhpBeEtXyAvsrjwW0ho8hu9TtIY1OaBbeAxnNvNj+tdZb4cD3AnNwITLYUNRKnBVa5v9qtUwN6wa2CUYBCpraLGBW3jqqMM95MU9xJDt5396pzg7DWqy+SuJpAwF+BkEtK5RuKecHz7o4DB9Xk6wnahlqs4EdjOUS2+XazW22BayDoUti2+MeMZ5RqFg23aQBHvzl8wvh5MOKjlYGDNkGB8Q9dxnspbC16bLHjlDSlw2DCXY80YiOMpDVBCJbqBXnTv+DBoM0O6g9b1zpQt6VeeN2sxXu3i2UqbVvj4cabn+F5CcIpM8Ek8URutrPTte9OwV6J5Htm2V+quni38tlBIuVVonDegPqA1Lo+kYBfY48Xrjh/962GW5ZYLluI8qChxi9fnhazcLPbhYbrGJBoKbUmgRNj0wRiiYVkOw8CEzlxRRYMccSnhEin4q3jtrPYvOJo8O3/C2yYQE8FPoMN2p9NE9z+8yEuCDI2kyw1OSXU915OJUSQpgBsNkt90D2UwzP7TKeGxLAX955XfpYDA1n7TOA3PZSEjo2vwDy20tpQJaDToQ7mnz4gapo2/WY7dQ1pTh7jcGPaBezLSjyxJWU88X/s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(8936002)(8676002)(478600001)(66556008)(66476007)(2906002)(86362001)(316002)(4326008)(16576012)(66946007)(6486002)(2616005)(31686004)(44832011)(26005)(83380400001)(956004)(186003)(16526019)(31696002)(5660300002)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bFQ2VGVKdkVud2tJSzB1TnZSS1A2bUdtV1NCdnBvdDZpamNRSGs5S3ZnM3Fi?=
 =?utf-8?B?WENKSXNQSys2d09CUW0wSUx5S1VrbzNQa1BWVGovMStWRmJVN0pBQmxxdHRx?=
 =?utf-8?B?WTB2S1ZyaWZxU0dELzZqUkt4b2paMDJDNW4zb2lHR1NHZHEwNVZmQ3hMVUJ0?=
 =?utf-8?B?c0xxVmJOelE5Qk9CRFErUzJ6VGhCMnArUCtReXpXUHFmRm1BK0QxblpQQzlh?=
 =?utf-8?B?Z0QxUFYxYnd2QXRSQmZaYVJCN0dHU1B1cmhRVGZ0b21RekhxUjE5QW5HN25w?=
 =?utf-8?B?QktNSi9kcjdBMGI1cDdHOEpMMHp2MWFoRVdMWEt4RDJXSkFMU0xBeEhkVlp6?=
 =?utf-8?B?YzR0NTJqNUFTME1HcEtrdkoyZitTa0NLOXZrY0hOZ1FqeU9hN0NCQ05jRkNK?=
 =?utf-8?B?Ylp3ZVAxUWE1WDdiQ3dkU2xWQW1oc2FwdExndlI2SGVwNjFLU0tReVhtcWdn?=
 =?utf-8?B?a0dYcmNiOVVUNktQWVJQZVNZVmhHaXBzcHVMWTZzMXM2Z0JyWVJaL0REb1lw?=
 =?utf-8?B?MnJLYXhrTHpTekUvNEZ2VWJ3Q1gzaWZBUXdYb0hzb0hXWGt0UUJkSmRrb01Y?=
 =?utf-8?B?aHYrSEwwNlBGWlVoS3JqS1NTQTZ2ZTNYTEJGNitZOTJ5aTM5Y1l3UjZsSWg3?=
 =?utf-8?B?Q0ZCU0UzZ3BLT0xVcDlJV3ZxWldJWnZMUVljREZTYnFiSTF4N1IxYTI3RC9m?=
 =?utf-8?B?UkR0UzNxNk0rZk1BSlRoWWRhZmF1NE92b1hiNzNJcm85d05wM1hUNDJzWjFy?=
 =?utf-8?B?Y0VNK1NDeVFaVDJMUENJQ3hJdmxZMURIbkdhbW9HS3RWMmZIcElNZ1grbWMz?=
 =?utf-8?B?REdHQzZmZnI4OFhZUEcvSDJsMDRRWGwzZUtyZVBqL2tHVDRMK1NYdGtYSklq?=
 =?utf-8?B?aFMxa0hSV2czdGhCR2lKQTZpaEl1SDFiYlhKTVFIMU1SMHZuNHhiYUF2bFJa?=
 =?utf-8?B?QXU3U1lMdWFmVWQrT3RvLzNXdU1wMkJZaWtJWHdhUFJPbVllbkJNUXZWNG1a?=
 =?utf-8?B?dHpwaXRZNTRpMlR0bUIzZ1NLS21rM0JzUjA0blpDWkdVd1hLTXZBa0JBWjlW?=
 =?utf-8?B?QTN2NWxIeFBkbkRKeVBkV1ZZRFVwRURiZTJEa0Q4dWd0bzliVHNIdTdvY2x4?=
 =?utf-8?B?c0tURS9TM1NZWmJQUDN2Z2xseHA2TG1obUEyQVlyWHR6SUhDUHc2citNZVJr?=
 =?utf-8?B?VnNEV2xrWGg1RFNJNE9Fb0ZxOXV1YUNLd2poei9IeHBLdFh1MWFQd1ZPU0xU?=
 =?utf-8?B?bHVhUVp5THlEM0JJQjFGRmtnbzRJSENTQmZPdWwyV1FvL1ZjaFFCbUF3NGpt?=
 =?utf-8?B?ZlBrUVBUdWtKL2MvWXkzR2I1TUQvQlgwRmxzWHA4Y0xtQTJKcVBZVlE0ZHND?=
 =?utf-8?B?NGRseGJ2YXNwQVlldGVhQ2xHV2xrb2x0YnlBOFB1V0NKRllNM0hOMndQTWNi?=
 =?utf-8?B?cTQ3d3lVSnRLcm14cU5aT2UvcWpjN2JxK3dmRTVwV3hleTdQazNSa1lYUmpW?=
 =?utf-8?B?SkpMYkZjZnBvaTJ0TVFGVGpuVk1jWEk4WVdYUFBObTY4NThrdmd1SXVXRGZI?=
 =?utf-8?B?WGhjY0FLdCs3VUFjOVh6UXpucjVzUHhxUHY4a2lOMmZBRVVFRjg2Zmo3V1Yz?=
 =?utf-8?B?RFkrUWx4SUNhaHVUWlBGaS8vTnNjWG5tK2VIckhwQ2N6MDJBV2dzN0tGclQz?=
 =?utf-8?B?TjRyM3FWQkdpcTJ3eTRwZGpNM3NuVHgvN0l0YjVwZ0RudmxsOGJXaXYxdy9w?=
 =?utf-8?B?RWxOOWQvRnQ5eFZxK2VDQldjUUhFdzlOTitTQ0ZWV2svYjgwQ1lSY2pGZkh2?=
 =?utf-8?B?NGdBcytvRmM1Z1BxOFZEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bd8ee6-00d0-4933-4e8b-08d92589fe99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 05:48:06.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BPEHOlrNHNLM//gQcr8YmmykvkVQE2aWEGKIEXifx27ohqo9KDT1ptIbuPFMwzuVNXRMqqtNl929Uy9T0nbfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
Cc: jinhuieric.huang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0wMSB1bSAzOjA3IHAubS4gc2NocmllYiBPYWsgWmVuZzoKPiBQcmV2aW91c2x5
IGtmZCBkcml2ZXIgYXNzdW1lcyBhbGwgQ1BVIG51bWEgbm9kZXMgYXJlIGFzc29jaWF0ZWQKPiB3
aXRoIHN5c3RlbSBtZW1vcnkKClRoaXMgaXMgbm90IHRydWUuIFN5c3RlbXMgd2hlcmUgdGhlcmUg
aXMgbm8gbWVtb3J5IGluc3RhbGxlZCBpbiBvbmUgb3IKbW9yZSBDUFUgc29ja2V0cyBoYXZlIGJl
ZW4gc3VwcG9ydGVkLiBUaGUgb25seSB0aGluZyB0aGF0IHdhcyBub3QKc3VwcG9ydGVkIGlzIE5V
TUEgZG9tYWlucyB3aXRoIG1lbW9yeSBidXQgbm8gQ1BVIChvciBHUFUpLgoKCj4gIGFuZCB0aGVy
ZSBpcyBubyBtZW1vcnkgb25seSBudW1hIG5vZGUuIFRoaXMKPiBpcyBub3QgdHJ1ZSBhbnltb3Jl
IGZvciBBTERFQkFSQU4gQStBIHNldCB1cC4gVGhpcyBwYXRjaCBjcmVhdGVzCj4gbWVtb3J5IG9u
bHkgbm9kZSBpbiBrZmQgc3lzZnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlpl
bmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQu
YyB8IDczICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0MiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYwo+IGluZGV4IDMyNTFmZTIuLjU2ZTZkZmYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiBAQCAtODI3LDggKzgyNywxMSBAQCBzdGF0
aWMgaW50IGtmZF9wYXJzZV9zdWJ0eXBlX21lbShzdHJ1Y3QgY3JhdF9zdWJ0eXBlX21lbW9yeSAq
bWVtLAo+ICAJdWludDMyX3QgZmxhZ3MgPSAwOwo+ICAJdWludDMyX3Qgd2lkdGg7Cj4gIAo+IC0J
cHJfZGVidWcoIkZvdW5kIG1lbW9yeSBlbnRyeSBpbiBDUkFUIHRhYmxlIHdpdGggcHJveGltaXR5
X2RvbWFpbj0lZFxuIiwKPiAtCQkJbWVtLT5wcm94aW1pdHlfZG9tYWluKTsKPiArCXNpemVfaW5f
Ynl0ZXMgPQo+ICsJCSgodWludDY0X3QpbWVtLT5sZW5ndGhfaGlnaCA8PCAzMikgKwo+ICsJCW1l
bS0+bGVuZ3RoX2xvdzsKPiArCXByX2RlYnVnKCJGb3VuZCBtZW1vcnkgZW50cnkgaW4gQ1JBVCB0
YWJsZSB3aXRoIHByb3hpbWl0eV9kb21haW49JWQsIHNpemUgJWxsZFxuIiwKPiArCQkJbWVtLT5w
cm94aW1pdHlfZG9tYWluLCBzaXplX2luX2J5dGVzKTsKPiAgCWxpc3RfZm9yX2VhY2hfZW50cnko
ZGV2LCBkZXZpY2VfbGlzdCwgbGlzdCkgewo+ICAJCWlmIChtZW0tPnByb3hpbWl0eV9kb21haW4g
PT0gZGV2LT5wcm94aW1pdHlfZG9tYWluKSB7Cj4gIAkJCS8qIFdlJ3JlIG9uIEdQVSBub2RlICov
Cj4gQEAgLTg0OCw5ICs4NTEsNiBAQCBzdGF0aWMgaW50IGtmZF9wYXJzZV9zdWJ0eXBlX21lbShz
dHJ1Y3QgY3JhdF9zdWJ0eXBlX21lbW9yeSAqbWVtLAo+ICAJCQlpZiAobWVtLT5mbGFncyAmIENS
QVRfTUVNX0ZMQUdTX05PTl9WT0xBVElMRSkKPiAgCQkJCWZsYWdzIHw9IEhTQV9NRU1fRkxBR1Nf
Tk9OX1ZPTEFUSUxFOwo+ICAKPiAtCQkJc2l6ZV9pbl9ieXRlcyA9Cj4gLQkJCQkoKHVpbnQ2NF90
KW1lbS0+bGVuZ3RoX2hpZ2ggPDwgMzIpICsKPiAtCQkJCQkJCW1lbS0+bGVuZ3RoX2xvdzsKPiAg
CQkJd2lkdGggPSBtZW0tPndpZHRoOwo+ICAKPiAgCQkJLyogTXVsdGlwbGUgYmFua3Mgb2YgdGhl
IHNhbWUgdHlwZSBhcmUgYWdncmVnYXRlZCBpbnRvCj4gQEAgLTE3MTgsNTEgKzE3MTgsNjIgQEAg
c3RhdGljIGludCBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2NwdSh2b2lkICpwY3JhdF9pbWFnZSwg
c2l6ZV90ICpzaXplKQo+ICAJc3ViX3R5cGVfaGRyID0gKHN0cnVjdCBjcmF0X3N1YnR5cGVfZ2Vu
ZXJpYyAqKShjcmF0X3RhYmxlKzEpOwo+ICAKPiAgCWZvcl9lYWNoX29ubGluZV9ub2RlKG51bWFf
bm9kZV9pZCkgewo+ICsJCXByX2RlYnVnKCJudW1hIG5vZGUgaWQgJWRcbiIsIG51bWFfbm9kZV9p
ZCk7Cj4gIAkJaWYgKGtmZF9udW1hX25vZGVfdG9fYXBpY19pZChudW1hX25vZGVfaWQpID09IC0x
KQo+IC0JCQljb250aW51ZTsKPiAtCj4gLQkJLyogRmlsbCBpbiBTdWJ0eXBlOiBDb21wdXRlIFVu
aXQgKi8KPiAtCQlyZXQgPSBrZmRfZmlsbF9jdV9mb3JfY3B1KG51bWFfbm9kZV9pZCwgJmF2YWls
X3NpemUsCj4gLQkJCWNyYXRfdGFibGUtPm51bV9kb21haW5zLAo+IC0JCQkoc3RydWN0IGNyYXRf
c3VidHlwZV9jb21wdXRldW5pdCAqKXN1Yl90eXBlX2hkcik7Cj4gLQkJaWYgKHJldCA8IDApCj4g
LQkJCXJldHVybiByZXQ7Cj4gLQkJY3JhdF90YWJsZS0+bGVuZ3RoICs9IHN1Yl90eXBlX2hkci0+
bGVuZ3RoOwo+IC0JCWNyYXRfdGFibGUtPnRvdGFsX2VudHJpZXMrKzsKPiArCQkJcHJfZGVidWco
Ik51bWEgbm9kZSAlZCBpcyBhIG1lbW9yeSBvbmx5IG51bWEgbm9kZVxuIiwgbnVtYV9ub2RlX2lk
KTsKPiArCj4gKwkJaWYgKGtmZF9udW1hX25vZGVfdG9fYXBpY19pZChudW1hX25vZGVfaWQpICE9
IC0xKSB7CgpUaGlzIHNob3VsZCBiZSBhbiBlbHNlLWJyYW5jaCBvZiB0aGUgcHJldmlvdXMgImlm
Ii4KCgo+ICsJCQkvKiBGaWxsIGluIFN1YnR5cGU6IENvbXB1dGUgVW5pdCAqLwo+ICsJCQlyZXQg
PSBrZmRfZmlsbF9jdV9mb3JfY3B1KG51bWFfbm9kZV9pZCwgJmF2YWlsX3NpemUsCj4gKwkJCQkJ
Y3JhdF90YWJsZS0+bnVtX2RvbWFpbnMsCj4gKwkJCQkJKHN0cnVjdCBjcmF0X3N1YnR5cGVfY29t
cHV0ZXVuaXQgKilzdWJfdHlwZV9oZHIpOwo+ICsJCQlpZiAocmV0IDwgMCkgewo+ICsJCQkJcHJf
ZXJyKCJmaWxsIGN1IGZvciBjcHUgZmFpbGVkXG4iKTsKPiArCQkJCXJldHVybiByZXQ7Cj4gKwkJ
CX0KPiArCQkJY3JhdF90YWJsZS0+bGVuZ3RoICs9IHN1Yl90eXBlX2hkci0+bGVuZ3RoOwo+ICsJ
CQljcmF0X3RhYmxlLT50b3RhbF9lbnRyaWVzKys7Cj4gIAo+IC0JCXN1Yl90eXBlX2hkciA9ICh0
eXBlb2Yoc3ViX3R5cGVfaGRyKSkoKGNoYXIgKilzdWJfdHlwZV9oZHIgKwo+IC0JCQlzdWJfdHlw
ZV9oZHItPmxlbmd0aCk7Cj4gKwkJCXN1Yl90eXBlX2hkciA9ICh0eXBlb2Yoc3ViX3R5cGVfaGRy
KSkoKGNoYXIgKilzdWJfdHlwZV9oZHIgKwo+ICsJCQkJCXN1Yl90eXBlX2hkci0+bGVuZ3RoKTsK
PiArCQl9Cj4gIAo+ICAJCS8qIEZpbGwgaW4gU3VidHlwZTogTWVtb3J5ICovCj4gIAkJcmV0ID0g
a2ZkX2ZpbGxfbWVtX2luZm9fZm9yX2NwdShudW1hX25vZGVfaWQsICZhdmFpbF9zaXplLAo+ICAJ
CQljcmF0X3RhYmxlLT5udW1fZG9tYWlucywKClNvIHlvdSdyZSBjcmVhdGluZyBhIGRhbmdsaW5n
IG1lbW9yeSBvYmplY3QgdGhhdCdzIG5vdCBhc3NvY2lhdGVkIHdpdGgKYW55IG5vZGUgYW5kIHRo
ZXJlZm9yZSBoYXMgbm8gSU8gbGlua3M/IEknbSBub3Qgc3VyZSBob3cgdGhhdCB3aWxsIHdvcmsu
Ckkgd2FzIGV4cGVjdGluZyB0aGF0IHRoZXJlIHdvdWxkIGJlIGF0IGxlYXN0IGEgZHVtbXkgQ1BV
IG5vZGUgd2l0aCAwCmNvcmVzIGJ1dCB3aXRoIElPIGxpbmtzIHRvIGV4cHJlc3MgdGhlIE5VTUEg
ZGlzdGFuY2VzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICAJCQkoc3RydWN0IGNyYXRfc3VidHlw
ZV9tZW1vcnkgKilzdWJfdHlwZV9oZHIpOwo+IC0JCWlmIChyZXQgPCAwKQo+ICsJCWlmIChyZXQg
PCAwKSB7Cj4gKwkJCXByX2VycigiZmlsbCBtZW0gZm9yIGNwdSBmYWlsZWRcbiIpOwo+ICAJCQly
ZXR1cm4gcmV0Owo+ICsJCX0KPiAgCQljcmF0X3RhYmxlLT5sZW5ndGggKz0gc3ViX3R5cGVfaGRy
LT5sZW5ndGg7Cj4gIAkJY3JhdF90YWJsZS0+dG90YWxfZW50cmllcysrOwo+ICAKPiAgCQlzdWJf
dHlwZV9oZHIgPSAodHlwZW9mKHN1Yl90eXBlX2hkcikpKChjaGFyICopc3ViX3R5cGVfaGRyICsK
PiAgCQkJc3ViX3R5cGVfaGRyLT5sZW5ndGgpOwo+ICAKPiAtCQkvKiBGaWxsIGluIFN1YnR5cGU6
IElPIExpbmsgKi8KPiArCQlpZiAoa2ZkX251bWFfbm9kZV90b19hcGljX2lkKG51bWFfbm9kZV9p
ZCkgIT0gLTEpIHsKPiArCQkJLyogRmlsbCBpbiBTdWJ0eXBlOiBJTyBMaW5rICovCj4gICNpZmRl
ZiBDT05GSUdfWDg2XzY0Cj4gLQkJcmV0ID0ga2ZkX2ZpbGxfaW9saW5rX2luZm9fZm9yX2NwdShu
dW1hX25vZGVfaWQsICZhdmFpbF9zaXplLAo+IC0JCQkJJmVudHJpZXMsCj4gLQkJCQkoc3RydWN0
IGNyYXRfc3VidHlwZV9pb2xpbmsgKilzdWJfdHlwZV9oZHIpOwo+IC0JCWlmIChyZXQgPCAwKQo+
IC0JCQlyZXR1cm4gcmV0Owo+ICsJCQlyZXQgPSBrZmRfZmlsbF9pb2xpbmtfaW5mb19mb3JfY3B1
KG51bWFfbm9kZV9pZCwgJmF2YWlsX3NpemUsCj4gKwkJCQkJJmVudHJpZXMsCj4gKwkJCQkJKHN0
cnVjdCBjcmF0X3N1YnR5cGVfaW9saW5rICopc3ViX3R5cGVfaGRyKTsKPiArCQkJaWYgKHJldCA8
IDApIHsKPiArCQkJCXByX2VycigiZmlsbCBpb2xpbmsgZm9yIGNwdSBmYWlsZWRcbiIpOwo+ICsJ
CQkJcmV0dXJuIHJldDsKPiArCQkJfQo+ICAKPiAtCQlpZiAoZW50cmllcykgewo+IC0JCQljcmF0
X3RhYmxlLT5sZW5ndGggKz0gKHN1Yl90eXBlX2hkci0+bGVuZ3RoICogZW50cmllcyk7Cj4gLQkJ
CWNyYXRfdGFibGUtPnRvdGFsX2VudHJpZXMgKz0gZW50cmllczsKPiArCQkJaWYgKGVudHJpZXMp
IHsKPiArCQkJCWNyYXRfdGFibGUtPmxlbmd0aCArPSAoc3ViX3R5cGVfaGRyLT5sZW5ndGggKiBl
bnRyaWVzKTsKPiArCQkJCWNyYXRfdGFibGUtPnRvdGFsX2VudHJpZXMgKz0gZW50cmllczsKPiAg
Cj4gLQkJCXN1Yl90eXBlX2hkciA9ICh0eXBlb2Yoc3ViX3R5cGVfaGRyKSkoKGNoYXIgKilzdWJf
dHlwZV9oZHIgKwo+IC0JCQkJCXN1Yl90eXBlX2hkci0+bGVuZ3RoICogZW50cmllcyk7Cj4gLQkJ
fQo+ICsJCQkJc3ViX3R5cGVfaGRyID0gKHR5cGVvZihzdWJfdHlwZV9oZHIpKSgoY2hhciAqKXN1
Yl90eXBlX2hkciArCj4gKwkJCQkJCXN1Yl90eXBlX2hkci0+bGVuZ3RoICogZW50cmllcyk7Cj4g
KwkJCX0KPiAgI2Vsc2UKPiAtCQlwcl9pbmZvKCJJTyBsaW5rIG5vdCBhdmFpbGFibGUgZm9yIG5v
biB4ODYgcGxhdGZvcm1zXG4iKTsKPiArCQkJcHJfaW5mbygiSU8gbGluayBub3QgYXZhaWxhYmxl
IGZvciBub24geDg2IHBsYXRmb3Jtc1xuIik7Cj4gICNlbmRpZgo+ICsJCX0KPiAgCj4gIAkJY3Jh
dF90YWJsZS0+bnVtX2RvbWFpbnMrKzsKPiAgCX0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
