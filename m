Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789ABC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D2A64F29
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 10:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D2A64F29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1896F562;
	Fri, 12 Mar 2021 10:40:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC936F562
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 10:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPL0MfECyUNOf3sUBfQCwq2m1bgl6hUlpBGgkYnxMk6Vun/I/RzafKz4cZ0m5Ps7A46i2YJaBoyGubso35O6Il6I7nGD5mcCZm3XX6ZvOtO9NEyswLjyVREfl/1ZtFuhkSAvy7OUERNm0eURyt0zEDQ8pTwzMIfM3EljmqE1/3Virf1+rHrU1dZCeJUdyAvdmjYXNjz2Lnnb/Gq2HGKIJ5w+m0bURwskzvIMsK7jY/3sz//R0DPgTxDBMSC+OZqfk6YSESDMIqePAsFMId9Ab2sTJcd/uP+fa8Y7rN/guvZrTPEvl7N+1E1Wj/E23IK64Wtf0hnn4cvDQM71bZABJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmgHUcP6d63VoTpLpvh8fKC6OdIqymd2ZJUlSsFZqV0=;
 b=OUGeHZx7NZZf/IV/SP/Ft6zFZ07DIRnPEQqVjomop0xcQl0DPzGITFte2NxBUnyCBPqPj5rOv/kY03B2BdMd0HXWw4qewlNOsP8u2TfNqiPbuyjgRF+sjhJMRfO9oL5Wypa3xJ32lsoVgJKAzAI/ftTwmr3tMTskj8mXTgbUb4Ct25cpPuEkPWqoxrPKpMPKD9YJveQ0090+l1Oaxh7+X8ENmhrrBcvQmb6FDYZts3fcKDKuA75Fu7phQFYhgWTUtkNBPhSGsWitUiLe88EGWxnA0CjnV8XHHjhBdpzCRCKmj3pVlgS0HGf2RXvLoevyUzrQbu0FEtza1a1MQvZOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmgHUcP6d63VoTpLpvh8fKC6OdIqymd2ZJUlSsFZqV0=;
 b=GlECVl+9u/4Z44EJ3tPykqdlFEQjdTq26DV5R+X4Nq1MDczQ5yZXg4mMvUoUIO7LWW+Aqwk8g34JXGu+p5ShRXf+GKMOn9GQWTQQHB3t6Tr4QdtSyRxaw50/qFcM1GS5nKXvF4AAgcADMfNQApEj9mWT+KjUURu9j9TRIg5bOY8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4814.namprd12.prod.outlook.com (2603:10b6:208:1b6::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 10:40:31 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Fri, 12 Mar 2021
 10:40:30 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20210312094901.20245-1-nirmoy.das@amd.com>
 <8410721d-666b-567d-c2c3-2641fd8217a3@amd.com>
 <312aff09-85ca-9599-0bd5-751f86aed5c6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f9520ef3-9a0b-9758-bc47-6299a76f79ec@amd.com>
Date: Fri, 12 Mar 2021 11:40:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <312aff09-85ca-9599-0bd5-751f86aed5c6@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4899:2887:b509:9393]
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4899:2887:b509:9393]
 (2a02:908:1252:fb60:4899:2887:b509:9393) by
 AM4PR0302CA0016.eurprd03.prod.outlook.com (2603:10a6:205:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 12 Mar 2021 10:40:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08e3845b-9624-4dd4-f8cb-08d8e54341d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4814A69D30B144F48DC0543C836F9@MN2PR12MB4814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwdeDkocFpV+lMylgzhbenvy6zGugmafYsOEUa5bo23FIYMwenY0yIPNN8SPYKsdnatzlriV8A222NTzY4SB42Pdy4jJo80UmTDSucq91NlposqCCMsEqU7TRG15vWdTOyEXSooB0ZozioZk6sMl5NUwq7t0GWgK1v0qRVjZjcMwAWl3CBcUAsAYk/SmML7jp7fdupnkfSzWZPNEf3EBk1AKN81TSPSZiPFLKLaDcefDmMA/0DMW7nGn/6uy2JtMDZAWbF4kw/JCd6cyzTvf4dwAEGHUG2q7zgfALtEFYOKwI6mIPgjuai45kU180CNNTT52rf0cNGbeW4ViagDK65eCXTc7nY4XaRL6tBIXdCVPBD6U6xj/oUU/+6GnISokpvr0+r7CkXnZaeCmA/spqVs+LfP6T201ByVpn2a+AbWDzrecTg+4D3CynM3zeadGoxTp1Anwcb4QebBm3fihUMsI6aKHKMohZCc+oVBBGDsrXciADojXFD7+jnZSWLQB817CcmH78e8aiOJvMoHst6lLk2qaMEwlvBryzWEPuA40r+edMniLUMRBTvf5sPe8Fb9/zCVg2HOneVSVKM8XO8kN6XZaZ1kjnthWzVpiDNGU7oNj7+HRBTadqnO5OEJZ0vkgd3juQ+LOmbnmEceB8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(6636002)(36756003)(66476007)(110136005)(66556008)(316002)(66946007)(478600001)(8676002)(8936002)(6486002)(4326008)(2616005)(5660300002)(186003)(16526019)(6666004)(83380400001)(53546011)(52116002)(86362001)(2906002)(66574015)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V090Ti9lbmQrQ3g5TUtkOGswendYOVlhbmJCakkzcjRaY1k3cHM1d3JGMVFL?=
 =?utf-8?B?NmRQdmpLS1o5eWgvK01ObGxEYnMxR0xSL00wZVlVMEl4TUdKY1BsZ01vR1pK?=
 =?utf-8?B?VlFvVjM4dE44c1NHMlBRSXM4cG01dFVCTngrdkV4MWFWUU55Nm1IWTJwSmVy?=
 =?utf-8?B?TWwrNTJtUGRSd2hpSjFWRncvQlJPMGRtbGh0RGRicXVpZ2s1a2Mvd0tFa2tR?=
 =?utf-8?B?WHZCZ1dXYkM5ckxpeEt4VnV1eFJFQ3UvcFJCdFVQK3BvNDV1WFg3SC9sTUpH?=
 =?utf-8?B?TXlYV1N3T0RjT0U5bERza3VROU9GK09tUThFQ1krZWpHUU9TNkh6OC9hWDBE?=
 =?utf-8?B?cHNlSVVBK2RvdjBlbjZGZDZLdjE3b29kYkRZekJzeVhJQ2thZEVpMjRkSmVt?=
 =?utf-8?B?QTl2c2ExNlhLTGM2UnVTNlpwMWlQNXFvQW9IMk5jdWJYSU9IclpPZkN4UXBL?=
 =?utf-8?B?Y3FrRXI2eC9JcVJtMVFBem1YWGt3aTU4WWl6ekRjazZOWmsweFNrVEMyZ0Jq?=
 =?utf-8?B?MlkwaVNsRUdCSVprc08zVGNEaTZJUTFYeWV3Q1FMSFp2L1JZVU5QRFVqQXRS?=
 =?utf-8?B?RGpYRExzUDZJTm1VUlA1SnZuWnlxU3BUeUlUS1hCR3E2U244L0p5dDM1Vnlz?=
 =?utf-8?B?WWsyc05jejhjejh4UDNHQmM2Qzh5S2ZUR0kxaWhyRzR1eTZxSXp3MkR4ZWQv?=
 =?utf-8?B?eTFHQ2R3STRKeTFQQm52K1ByQmg2encxVjQxNDNxSVN3Uit5N05Jd2VkSTRC?=
 =?utf-8?B?VVM4ZklPQWdGMHQ2VG5ad202bkJXQVhOMGc4MzVOcEhrQS9CWk1pVC9FQXJr?=
 =?utf-8?B?NW41a0NSRThzVGJVVFIvZGtLOVRPaTJqMFFFN0RrUkptYXJhZnp6dlpCMWp3?=
 =?utf-8?B?WEhtQ2lYN1VPWGIwWTBHeDBCVmVKZ01JWXlLbzRlTU9LZ1k3WmNHQU9va1dU?=
 =?utf-8?B?OVNQMmtqSmZSd2R2NElQOGhSNS9qTW5Oa2hzSzFrVFdFTEZXMTJwdU5qVFky?=
 =?utf-8?B?MVdySjZhaUlDSEYyWDRwckNGRWlQUzdYaUdTL3hlbWZKWnJndXZlUUg1ZmpG?=
 =?utf-8?B?Y3cyazZ0bFRRY1RJVEhCUU9XZGZGUFNEcmNrcjBtVy9RekRzdzEvNWlSMHZa?=
 =?utf-8?B?cmc2c3B6UytsQzV4QzVJeXhucjBFMjhJcHAyZGFwNFRNemI0ZEdkRTVpYU8z?=
 =?utf-8?B?N3RWWG9RQjdkbkpWQkkzb0FoY0hlMnFxa0k5SGdIbGd3ZEdOVmVLVXRuMVU4?=
 =?utf-8?B?cll4OWRPb2xlb3V3SWpYODRFYm0wc3NjdWxRa1YrWVhITGZKVmh2SjVWa25Q?=
 =?utf-8?B?cTQvaTBIV3hYWGFlK1JkeDJncWJrLzlMU1hXMFF3OWRwSGhrdHdQVUdHRFZj?=
 =?utf-8?B?SkMzTVpaakl0U2FidmVCMDc1WHpZR3hQbVZuM2dCVUVxd3BqZmZRZTVJL2N5?=
 =?utf-8?B?Q1JTNmJuRXQvSDZHdjVud0tWQWNIYXZpS2d0QlcrOUUxSXVuQkdHWG5oTzB6?=
 =?utf-8?B?YUpienlQRDlXNWRtcDByS0FWRTN6Y1hNUWxuRU5XYWVlOFRFUElBeG1BWGFw?=
 =?utf-8?B?b1h2THNTMjgxM0hGeEdYN3NucTlyaEN0b25QRWJwVGV3dWEwL3NKcER6V045?=
 =?utf-8?B?NS80czQzSEpYVzlhbzhXUzdFckh6czdHM1h5cVgrWFJ4Y3VHak1WTi90Y2VL?=
 =?utf-8?B?bW1FL0p5ZkJDTFoyRzFZSURWZE9jaExoQjZsMFAxbjVHNFV0am5lcVBKWHkx?=
 =?utf-8?B?Nm5MQ3BHY05wQ3hxSUZWSHBHZUtrbDg1Wkd2eVRMTnQ1Vzk2eEpjZ2JPdWFJ?=
 =?utf-8?B?ckNrR3VXVXlVMWUvSU5zRlpaWjZLbE8vMEM2eHBrOTVaTmwwc05EZExnVk1R?=
 =?utf-8?Q?uq/dqD84pemlB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e3845b-9624-4dd4-f8cb-08d8e54341d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 10:40:30.5760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjS9eWVmtMWf8sB0dtf41h8GapgkWKz+3LQwqBOUre8MdqqWB4gbSZi8P4I9+3J2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4814
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

CgpBbSAxMi4wMy4yMSB1bSAxMToyNCBzY2hyaWViIE5pcm1veToKPgo+IE9uIDMvMTIvMjEgMTA6
NTIgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDEyLjAzLjIxIHVtIDEwOjQ5IHNj
aHJpZWIgTmlybW95IERhczoKPj4+IEtJUSByaW5nIGlzIGJlaW5nIG9wZXJhdGVkIGJ5IGtmZCBh
cyB3ZWxsIGFzIGFtZGdwdS4KPj4+IEtGRCBpcyB1c2luZyBraXEgbG9jaywgd2Ugc2hvdWxkIHRo
ZSBzYW1lIGZyb20gYW1kZ3B1IHNpZGUKPj4+IGFzIHdlbGwuCj4+Cj4+IEFoLCBub3cgSSBrbmV3
IHdoaWNoIGZ1bmN0aW9ucyB5b3UgbWVhbi4gVGhpcyBpcyBub3Qgc3RyaWN0bHkgCj4+IG5lY2Vz
c2FyeSBiZWNhdXNlIHRoYXQgc3R1ZmYgaXMgb25seSBjYWxsZWQgZHVyaW5nIGJvb3R1cCBhbmQg
bm90IAo+PiBsYXRlciBvbi4KPgo+Cj4gT0ssIG5vdCBzbyBzZXJpb3VzIGlzc3VlIGFzIEkgd2Fz
IHRoaW5raW5nIHRoZW4uCj4KPgo+Pgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMg
PG5pcm1veS5kYXNAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dmeC5jIHwgMTAgKysrKysrKystLQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMKPj4+IGluZGV4IDE5MTViOWI5NTEwNi4uOGZlMzcw
ZTUzNThkIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dmeC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMK
Pj4+IEBAIC00NjcsMTMgKzQ2NywxNyBAQCBpbnQgYW1kZ3B1X2dmeF9kaXNhYmxlX2tjcShzdHJ1
Y3QgCj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4gwqDCoMKgwqDCoCBpZiAoIWtpcS0+cG1m
IHx8ICFraXEtPnBtZi0+a2lxX3VubWFwX3F1ZXVlcykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVJTlZBTDsKPj4+IMKgICvCoMKgwqAgc3Bpbl9sb2NrKCZhZGV2LT5nZngua2lxLnJp
bmdfbG9jayk7Cj4+PiDCoMKgwqDCoMKgIGlmIChhbWRncHVfcmluZ19hbGxvYyhraXFfcmluZywg
a2lxLT5wbWYtPnVubWFwX3F1ZXVlc19zaXplICoKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmluZ3MpKQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZXYtPmdmeC5udW1fY29tcHV0ZV9y
aW5ncykpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmYWRldi0+Z2Z4LmtpcS5y
aW5nX2xvY2spOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4gK8Kg
wqDCoCB9Cj4+PiDCoCDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2Nv
bXB1dGVfcmluZ3M7IGkrKykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBraXEtPnBtZi0+a2lxX3Vu
bWFwX3F1ZXVlcyhraXFfcmluZywgCj4+PiAmYWRldi0+Z2Z4LmNvbXB1dGVfcmluZ1tpXSwKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSRVNFVF9R
VUVVRVMsIDAsIDApOwo+Pj4gK8KgwqDCoCBzcGluX3VubG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5n
X2xvY2spOwo+Pj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIo
a2lxX3JpbmcpOwo+Pgo+PiBUaGUgcmluZyB0ZXN0IGFjY2Vzc2VzIHRoZSByaW5nIGJ1ZmZlciBh
cyB3ZWxsLgo+Cj4KPiBTaGFsbCBJIHNlbmQgYSB2MiA/CgpJJ20gbm90IDEwMCUgc3VyZS4gUGxl
YXNlIHRlc3QgdGhpcyB3aXRoIGxvY2tkZXAgZW5hYmxlZCwgaWYgdGhhdCAKZG9lc24ndCByYWlz
ZSBhbnl0aGluZyB3ZSBjYW4gcHJvYmFibHkgY29tbWl0IGl0IGp1c3QgdG8gYmUgb24gdGhlIGNs
ZWFuIApzaWRlLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gVGhhbmtzLAo+Cj4gTmlybW95
Cj4KPgo+Pgo+Pgo+PiBSZWdhcmRzLAo+PiBDaHJpc3RpYW4uCj4+Cj4+PiDCoCB9Cj4+PiBAQCAt
NTE4LDE4ICs1MjIsMjAgQEAgaW50IGFtZGdwdV9nZnhfZW5hYmxlX2tjcShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAKPj4+ICphZGV2KQo+Pj4gwqAgwqDCoMKgwqDCoCBEUk1fSU5GTygia2lxIHJpbmcg
bWVjICVkIHBpcGUgJWQgcSAlZFxuIiwga2lxX3JpbmctPm1lLCAKPj4+IGtpcV9yaW5nLT5waXBl
LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBraXFfcmluZy0+cXVldWUpOwo+Pj4gLQo+Pj4gK8KgwqDCoCBzcGluX2xvY2soJmFk
ZXYtPmdmeC5raXEucmluZ19sb2NrKTsKPj4+IMKgwqDCoMKgwqAgciA9IGFtZGdwdV9yaW5nX2Fs
bG9jKGtpcV9yaW5nLCBraXEtPnBtZi0+bWFwX3F1ZXVlc19zaXplICoKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngubnVtX2NvbXB1dGVfcmlu
Z3MgKwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtpcS0+
cG1mLT5zZXRfcmVzb3VyY2VzX3NpemUpOwo+Pj4gwqDCoMKgwqDCoCBpZiAocikgewo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIERSTV9FUlJPUigiRmFpbGVkIHRvIGxvY2sgS0lRICglZCkuXG4iLCBy
KTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xv
Y2spOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+
PiDCoCDCoMKgwqDCoMKgIGtpcS0+cG1mLT5raXFfc2V0X3Jlc291cmNlcyhraXFfcmluZywgcXVl
dWVfbWFzayk7Cj4+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5nZngubnVtX2Nv
bXB1dGVfcmluZ3M7IGkrKykKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBraXEtPnBtZi0+a2lxX21h
cF9xdWV1ZXMoa2lxX3JpbmcsIAo+Pj4gJmFkZXYtPmdmeC5jb21wdXRlX3JpbmdbaV0pOwo+Pj4g
K8KgwqDCoCBzcGluX3VubG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2spOwo+Pj4gwqAgwqDC
oMKgwqDCoCByID0gYW1kZ3B1X3JpbmdfdGVzdF9oZWxwZXIoa2lxX3JpbmcpOwo+Pj4gwqDCoMKg
wqDCoCBpZiAocikKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
