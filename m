Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BDEC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0631064DF4
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0631064DF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE666E19A;
	Mon, 15 Feb 2021 11:21:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3EA89DFA
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 11:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2as+uZDBhMNdtqLcwq5dZoL3MUPouQ3fELToHpfyU9x9aWSim3/LiHdOAZmob65RkXvRuF0KCLmoEquiO1TfrhnJJvwDXiFPZS0qc/eisoRFHYByxqThRAMBRrqI2Tyb73GXLnfjBKolAjIRcSGEcBo6GCpdgjO6NHLdnei8AHJDpRBtTZi/KbKJ2L2NO46dRBhSDLXO1RTe7BGFCy4jozJA8xWK+AJhnmVEvaHJfeN+ydYfYJ4aEqhF6be64cbRwcPLw0ZNYKywvL6qTFqzJYiNVHPFVWTPixb3EgU7flD550JyP8zNDzz0gQWs9xUeN8PQd8XTgC4pvj1d3SP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFkF/nayMxLoW3Px2kLuBVXKw26VzFS/6BmZzS5agds=;
 b=Yj+qn6EVpuVzO6xRJachr/Cmj00U+dPrOkWJKcB0BDUOSg3kBchEjUSA7obOAcVLfndusTfJfTgYU1iFGqEiDIU4/bF9UeBGjMMr7U5BMOFAYQKBcdo6/QigpF+X94BDWf5ZFwLBhnePWqiCRCZ5MCHkxFhEk4AtsTz/ThkjtrpgpxwHsb3ysM4WrsZU3BDIvn+iu+jyDGWeJhblGq6S/gBtYLB4klDFYx6QAYnBclsGMWjIGt02Sayf7jJmbFRQRQ3vC2o1zaHOWbthFZylF5sTG4iICnnK4b1QrohRJZJnCTO731iEMvySJuSd3X6pSMMfJd1KZcK6UJguenQYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFkF/nayMxLoW3Px2kLuBVXKw26VzFS/6BmZzS5agds=;
 b=Q8eEHfUKC3PC4agrY+Xrj0kvZbxZxzT7j8ZK3j/dD4HtaXZ5haMi2QDRJClYG8odyJHQ4mkio/6y5Mud5f43xEPbMFbM65eG0Ung6t7BNRp4HJgVjqVp2sm7WG6bpbG5gxqTbiNvC52ntDvI/zycTYrB0Ifj0TQSnNXy/GNg8lU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Mon, 15 Feb
 2021 11:20:59 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 11:20:59 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: do not use drm middle layer for debugfs
From: Nirmoy <nirmodas@amd.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210215101653.35694-1-nirmoy.das@amd.com>
 <20210215101653.35694-3-nirmoy.das@amd.com>
 <57585256-9f83-499a-f9e0-13c50de0d24d@amd.com>
 <5e4b9c01-41f8-2d51-1acb-10fb980759c6@amd.com>
Message-ID: <f593869d-4a4e-6f39-be5b-7371deeaa074@amd.com>
Date: Mon, 15 Feb 2021 12:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <5e4b9c01-41f8-2d51-1acb-10fb980759c6@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: AM9P193CA0024.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.46.81) by
 AM9P193CA0024.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Mon, 15 Feb 2021 11:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c645c580-d835-4f6a-5097-08d8d1a3c54f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4203794DBE7219E292DCBF858B889@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+kbpLqCDJ4YugC/28f9o6bb9EvB7/EOSvzXNS/snJLOPQ44ai76Ssbvhu/l2r8IU1NyjiTiFfuYVNpTAtPFtCasaougtNqHf3kdqtWb9cP3dG0qyxPoUA7klXMZYFYz1Fk82ymd//ZDuxR83KiWKmr5gW7z9tAVan9FmgTAnqYMikAHsUEp+UzumOpoPG3u3dHA8shroKOsAMsnPM5OrAjtN3BEqVQb++U1728DlnnaMLIwsCzpDi7XS8af+yEvwCtNSS8AVtJcxw/wVcSztXIAg9zLG3uubQ7OnDqMaTYNzHp012AVFM+sUXN7Sui3IS5S1uiYyHCvFVNPN2+sMdKfhU4wHoFCmNTadvsvbA9w02HWA7a/zOdc6db120N/0KQ74jhMCpseDsKWyI/PtbXqtOmAnpDetbawnBN06KhSuG+T9UW00RYz5J6cMyjzre6ytDsMpRUTAWWdWOfXi4++j3D14NNUzGziKKscFpkFfhI31glvcf+Q0WJ98o5PALCtRLJLKUXwd7RacKbpJ9Kk79PVZyjQD6udzcd0rJvBDq8LBxLrQeUGBKOt8R1y5vO1uEPr57WtbPqnqmN7SNw+CEeNWqqMsZJIqp7T3/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(6486002)(2906002)(26005)(316002)(16526019)(478600001)(52116002)(66946007)(66556008)(36756003)(956004)(2616005)(8676002)(8936002)(53546011)(66476007)(31696002)(110136005)(16576012)(5660300002)(83380400001)(6636002)(31686004)(6666004)(186003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bit2YlN2RXl2d0xPRndNNGxYN1dmMWtlT2J5c2M5ZjZEc2dyeHJlUWFtYXFa?=
 =?utf-8?B?K2oyYTgyWkhaZVd2MThkMWprWlB2eDhEblRKV3I4V0pRWkEweWRlMHROaTdL?=
 =?utf-8?B?MjVWTmJnVFM0TXNmK0NTNk5RUytZbExVREV6VFRnb3VrQk1EdGRGcGJKK1lV?=
 =?utf-8?B?VEM3ZStlZWdzUFZPV1B0YTFuVnJ6eXRuRlRZMG1IRGwyQjU1SmZNRG51N1lx?=
 =?utf-8?B?cW5jVDlOc3Z6L1U5cEI3K1dUNzNZVzJkUmFQakVCUEI0bCswQjFnRmRzN2Zz?=
 =?utf-8?B?M2hkZURNRlAybmtUdDVJOVBZbEo4N0g3eXRaalc1ZWJaanhyZk4yZ2c1Qlky?=
 =?utf-8?B?T1BNT2ZGN3pmelkrazRhTUZLYlFBN1puUmZpWTJOOGMxTXVPdFBvZGk1NUdw?=
 =?utf-8?B?Ulh1ZmlwZUZmeU54dk1ha3NDMGhtRkVhUUZIeHVJQnZJSngwbU1LMWVWb0xj?=
 =?utf-8?B?OGtlWmk3MGZuQmwzN1VKbk1QRTI3cC9qeEJsNzZQYnhLaS9LZmxHMEo2ek83?=
 =?utf-8?B?RDhuL0RHREpKL0dmWnZhUWdCZnlXeEF6T28vR1RTUGlrYUdRUmVRVklGc1lM?=
 =?utf-8?B?d1NReWdSNkFCYStnaDljaEgxSnZSQnV2Q1J0TGlWbjFsUCsvNFhDUVI1cThI?=
 =?utf-8?B?VTdMdTIrVFdscmhhMy8yNXJBNXk5MkZEbTQrV09VQjl1TWZKSVh0TTJXUitE?=
 =?utf-8?B?a2FtZEl1RGpjRHJ0T05qUE5iVzB2THFkOUxtM3VLWm1sMFQ4VkoyVWxpQVYv?=
 =?utf-8?B?SHRnL0VTQVVwdWN2eXpaaFRUd0JkNFM5MDZyY0ZKOEZDc1BxbmFrYXEwY1Vq?=
 =?utf-8?B?d1ZuTDYyQnE2aVBsQjFBZHVtVGlFMVo2b1Z5b2hnb1FTUkZ0ajlOSkhjeWhT?=
 =?utf-8?B?bzdTZU9sMkVQejZjblROcUllaVF1dHNBdEdTbFBvZFd1cWpGNFZXR2xPZ1Qz?=
 =?utf-8?B?ejJmbHNwa29ZRWpyeGlUa3ZGSm9NK3M2N1JYb2FZenc1TFdQNk1HTzNGZ1hP?=
 =?utf-8?B?R0JKRG9SR1JvU3R4bGM5VjEybWI1WHZMM3dVVjlFSVprU0Y0M2lINnYxR09B?=
 =?utf-8?B?bTBadVZqcStVelduVmhNY04ySStDdVd1cDNJRGJ6WWFQWldiWTAyM2s0dUFh?=
 =?utf-8?B?NStkNklWcUEwNUZVN05OSlZxUDkvN3dZR0hQRHZ6V1d5QVNoSzRreVRXWmJz?=
 =?utf-8?B?eXVUSDNPdlBHd0ZpeUZYT0p6cmhHd3h4WUlDZkdGYVpUd3lUQWJTOUd1bGwx?=
 =?utf-8?B?Wk1EQnk1d2lXSVY0YldNUGIwUnhNN2tZTnBQUndlU2tZcE85dzBFc2ZlTWhF?=
 =?utf-8?B?bTllaWNVNzV6SkFBdjg4dDVWZEU1TXNCN1hJaTZnNVdLTk9Zekx0VmpNUjVl?=
 =?utf-8?B?SVk1dmJJRTVlK1NsM3hHck1aUlh4YTJ4M3ZYdHAvTzJvdkNZQmdlVklha0lP?=
 =?utf-8?B?K09LR08rcEFDdkpqTG8rai8wcFJoVDZWbElRWmVTcTFhR2Q4dWppbmFGNFFE?=
 =?utf-8?B?aVpqWHBQVEJpeWxqR1NoNWRiRzRQTmYyK0hiZTdtbjlLZ1dPVysrOXhOUHBV?=
 =?utf-8?B?RmFaemxDNGkxRE9kYy9FRE8rMnk3WnJMQ0U3MGhxRisrVnlRUVBzanQ3SzJQ?=
 =?utf-8?B?WHMxclpkL09URFdxNU55OUNDQ0tlMGlPalMwcWlVQ3Z3aTdIM21nMklTejhj?=
 =?utf-8?B?ZzB5cTQzME41dDZ4TmVYQzZiUGhYU2dUcGZHVCtNWXU3SStndDhoQzR6Rllp?=
 =?utf-8?Q?1V18v5iy2Xe7FftsqCGoA9zoqyWXSW0XGHOt2Gj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c645c580-d835-4f6a-5097-08d8d1a3c54f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 11:20:59.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Upc8poCDzNE9JUplHB6EJ5aq9ArVXJ0ShiU+eEtsWYXUuqQA/PJayM2whnXugg8luYMBOAXo5hAKVR6MxEzHZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

Ck9uIDIvMTUvMjEgMTI6MDMgUE0sIE5pcm1veSB3cm90ZToKPHNuaXA+Cj4KPj4+IGFtZGdwdV9k
ZWJ1Z2ZzX2F1dG9kdW1wX2luaXQoYWRldik7Cj4+PiAtCj4+PiDCoMKgwqDCoMKgIGFtZGdwdV9y
YXBfZGVidWdmc19pbml0KGFkZXYpOwo+Pj4gLQo+Pj4gwqDCoMKgwqDCoCBhbWRncHVfc2VjdXJl
ZGlzcGxheV9kZWJ1Z2ZzX2luaXQoYWRldik7Cj4+PiAtCj4+PiDCoMKgwqDCoMKgIGFtZGdwdV9m
d19hdHRlc3RhdGlvbl9kZWJ1Z2ZzX2luaXQoYWRldik7Cj4+PiDCoCAtwqDCoMKgIHJldHVybiBh
bWRncHVfZGVidWdmc19hZGRfZmlsZXMoYWRldiwgYW1kZ3B1X2RlYnVnZnNfbGlzdCwKPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUlJBWV9TSVpFKGFtZGdwdV9k
ZWJ1Z2ZzX2xpc3QpKTsKPj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X2V2
aWN0X3ZyYW0iLCBTX0lGUkVHIHwgU19JUlVHTywgCj4+PiByb290LCBhZGV2LAo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmYW1kZ3B1X2V2aWN0X3ZyYW1fZm9wcyk7Cj4+PiAr
wqDCoMKgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoImFtZGdwdV9ldmljdF9ndHQiLCBTX0lGUkVHIHwg
U19JUlVHTywgCj4+PiByb290LCBhZGV2LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAmYW1kZ3B1X2V2aWN0X2d0dF9mb3BzKTsKPj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVf
ZmlsZSgiYW1kZ3B1X3Rlc3RfaWIiLCBTX0lGUkVHIHwgU19JUlVHTywgcm9vdCwgCj4+PiBhZGV2
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmYW1kZ3B1X2RlYnVnZnNfdGVz
dF9pYl9mb3BzKTsKPj4+ICvCoMKgwqAgZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X3ZtX2lu
Zm8iLCBTX0lGUkVHIHwgU19JUlVHTywgcm9vdCwgCj4+PiBhZGV2LAo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAmYW1kZ3B1X2RlYnVnZnNfdm1faW5mb19mb3BzKTsKPj4+ICsK
Pj4+ICvCoMKgwqAgdmJpb3MgPSBkZXZtX2t6YWxsb2MoYWRldl90b19kcm0oYWRldiktPmRldiwg
c2l6ZW9mKCp2YmlvcyksIAo+Pj4gR0ZQX0tFUk5FTCk7Cj4+PiArwqDCoMKgIGlmICghdmJpb3Mp
Cj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+PiArCj4+PiArwqDCoMKgIHZi
aW9zLT5kYXRhID0gYWRldi0+YmlvczsKPj4+ICvCoMKgwqAgdmJpb3MtPnNpemUgPSBhZGV2LT5i
aW9zX3NpemU7Cj4+PiArwqDCoMKgIGRlYnVnZnNfY3JlYXRlX2Jsb2IoImFtZGdwdV92YmlvcyIs
IFNfSUZSRUcgfCBTX0lSVUdPLCByb290LCAKPj4+IHZiaW9zKTsKPj4KPj4gSXMgdGhhdCB2Ymlv
cyBhbGxvY2F0aW9uIGV2ZXIgZnJlZWQ/IE1heWJlIGp1c3QgY2hhbmdlIGFkZXYtPmJpb3MgYW5k
IAo+PiBhZGV2LT5iaW9zX2RpemUgaW50byBhIGRlYnVnZnNfYmxvYl93cmFwcGVyIHN0cnVjdHVy
ZS4KPgo+Cj4gZGV2bV9remFsbG9jIHdpbGwgZ2V0IGZyZWVkIG9uIGRyaXZlciByZW1vdmFsLgoK
ClNvcnJ5LCB0aGlzIHJlcXVpcmVzIGEgZGV2bV9rZnJlZSgpIGNhbGwgYXQgdGhlIGVuZC4KCgo+
Cj4+Cj4+IE9yIGF0IGxlYXN0IGtlZXAgdGhlIGRlYnVnZnNfYmxvYl93cmFwcGVyIHN0cnVjdHVy
ZSBpbnNpZGUgYWRldi4KCgpJIHdpbGwgdXBkYXRlIHdpdGggYWJvdmUgc3VnZ2VzdGlvbi4KCgpS
ZWdhcmRzLAoKTmlybW95CgoKPj4KPj4+ICsKPj4+ICvCoMKgwqAgcmV0dXJuIDA7Cj4+PiDCoCB9
Cj4+PiDCoCDCoCAjZWxzZQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZWJ1Z2ZzLmggCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZWJ1Z2ZzLmgKPj4+IGluZGV4IDI4MDM4ODRkMzM4ZC4uMGVkODY2ZGE4NjVlIDEwMDY0
NCAKPHNuaXA+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
