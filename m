Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF9C2BB40
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 03:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313682246B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 03:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313682246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46C089815;
	Tue, 15 Dec 2020 03:04:58 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A07F89815
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 03:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUSiiIahHww8QChSFfD2oDikRbsad9c7yAXALO58ztzp7MvbZU8wNBeSkkjkEK/Wth5EpHnsrzOxgdigpuQIOHL3WJ4rDN2V+N/ti1ddzMdlHxeqN4RWILFAorj4yPP4o1EeKkkDAaQptOdMMrwQzWJ0DyPNBBs5zPGWuuRTnPKpZfjlpDl2ML7RddmmmCsC+lrZmBZdGGCpu/o2jEyNJSjH1ToiXRT4wYqu1IjQjG8TcUzHdK7SuR3ReudgqU313qAFwRx6mBShzEOvfK3YfExhv0WyOBFYWPY3Dtw5MNL6/GmCWbdlI6Ah4N1lZAJgj8FZto3p+3Erg69xoCmTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpoK0NIYsO0q3lo1RJQzIQsUUquAYc6NoqZftPq7cuo=;
 b=eOHIb+MQoE/3Ygno1RSR7CfE/vO6/OpFrxcJ/mFMGQ9JJcddc1OT+LQzfGFd/JQ1UTCPbEd7ZJ/JfDU9IGDuW0cPzPBc/NIp58a6D5QmEpUBK1hs2XNBrgireDPR0SU+zEDuPUHgOJ28USZ7YtwrZW18sJ9GkVuvYSiDIP4u7zIdlyI6h+4gppMrpImyGAwPy72IvwLNFg3CJ5gdCGHxNtsy9ySx4FqzEu3CDssccbtdDtCzjV5DjFypOpqmc5zCCXB5EC0Ku5qwobhj9H5YG/gXV5C6RmI6nBS/5vUy9W6G+OI/HreMCspsrpYqfC6aiWi7CsrHeCGEtsYrZ9TSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpoK0NIYsO0q3lo1RJQzIQsUUquAYc6NoqZftPq7cuo=;
 b=C4udpjiO8mz/loWRAAWOjCVQNQ9hm+jxJDvjaV9RvI+tZMS2CKRWZYefhYhl1ZyPQZDrcTXKeLUWB2nfbF4nUXl6TegQ9b+b5jiq+dYAX+if3DIAoOEy3k6k7kpXPIGJREu0DEGjDv1kR8IezuRQn1jv1WVR1PVMBjEYcewZ1FM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 03:04:55 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3654.024; Tue, 15 Dec 2020
 03:04:55 +0000
Subject: Re: [PATCH 01/27] drm/amdgpu: add amdgpu_ih_regs structure
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8e25d892-2aba-6b24-105a-42a304f2f889@amd.com>
Date: Mon, 14 Dec 2020 22:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 03:04:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75b23227-4bca-459d-0761-08d8a0a63306
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4552212F744790EE185C92F792C60@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBWeH6cQqVyQmWAoWdc+dOW9FpXHsFSNX5w6Td1RvAUg6cdw/f7cqTxI+D1PFy+E7grGY52kZgRBcembkWiWGjGDd4f6Aq0u+fELG0tGxkdX2IPCMvjWNeNQNqOWbQk/WpWv0wiv4unNbz7BP5gF4wVsJjMgygZA/lDrlnCecA7elNXEzQW38ZRkVKaegV26gBXQkMLAQHpQeiZ13+mDbf14Ajof8qajKBqNw8kt8tDJpbKT2/VZR5KmIaUQScjORHO/O+SY6nlX642I57HC0t74O+eWDvedVEw18+efe6a5+62zZ45WUh2BKMQvpg9Om7ulqg3NwU28N/4YIJLI8cAr1HrU6oJWJrDgxl7bGx6N6cHj3myPzQTaW7r9y5dtL8yr4P5dn7Ec7hoe+CqNecQ6+5Ii74GtwQKguFsoc2ySg+tBdL190GLIlZ0EzTWv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(16576012)(36756003)(52116002)(2616005)(110136005)(2906002)(44832011)(186003)(16526019)(956004)(6636002)(26005)(508600001)(4001150100001)(31696002)(6486002)(34490700003)(83380400001)(66946007)(66556008)(5660300002)(8676002)(8936002)(66574015)(31686004)(86362001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TTVBMVRHQTRMZXFXN20xY2N4Z3MxY0k2eWlGVW8vY3lxa082T3F5SkRTTEIz?=
 =?utf-8?B?c1NzbG9yeG5TU3BDdUtVR1JHVUFxR2RtNjZOQnIyQ25YQXR6eDlGRDh5cG9y?=
 =?utf-8?B?aDA5ZE5pR0toM2hoOS8zUHBZeWVMSzl3aTdCMU45WE9DdTAvbUJLZWhheEtF?=
 =?utf-8?B?STAxaVRybmFLVzFhTXdnRlB6ZDQrOU1XNjl5aG1XWnRoRkhHK284VlliVmpm?=
 =?utf-8?B?ZEh2UzJ5cmhMNDNWdnIyVmxaWmFtY0tKajJidU4xTExCc2o2K1JJc0hXODJ6?=
 =?utf-8?B?Ty9PQXNTdnVjYTVEUUwrelVDZFc5d2JNbWxtOVFPYzRNc0RmNzNWc3lSRnNq?=
 =?utf-8?B?S1k0Nm95STMrNVptdUpNSHBCWHFmS3hOZVFRRDFUa0NPVDJFV2tmOUF0S0xu?=
 =?utf-8?B?RTlna0drc01jUUZLamVBQ3BCQ2tHZW0rYjZoYXhGNmRaS1Vpbkk5bklEVVZW?=
 =?utf-8?B?RE5HaDl0RHBhN1dNZUF1T3dPZHN6Mkl1ZkpiZVQvd3FqTE02WkVpQ1dSOGo4?=
 =?utf-8?B?aFl2SG5ZcWIxd0szdlFhVkxLalZPYVVjN2tTVisrUTU3K3NMOUVDR3hkaUJp?=
 =?utf-8?B?RTVNY0ZmTnNnbTFnbzl2dndpRVIxUmJqbGhucU9md05iei9tcmdoT2Vib3lt?=
 =?utf-8?B?bTZGWU8vRFcyN0Q2UUc1QVNGc2JrWkZoSzYwbk9xdXJ0SU5lRmpReDZUL1Vt?=
 =?utf-8?B?SzBwM1E1U2FQNG5aKzlQVVM5MWdmdW5oa2QwVHZZbE0wNHlHd0syT2tQcGJq?=
 =?utf-8?B?QmZJVUN4bG5MZEJxY2NLUDRnSVo1OVBDbXdmSlZhRjQ0c0F0c2IyN21ZOG4w?=
 =?utf-8?B?STMxOUVxSWZ5QjZJZUJ2YmhUQTFVUzJKWHNUZTZBb3RFNk5CcHkvbTNRT1Uz?=
 =?utf-8?B?aHJWOGNIUEd1YUJhNkM4bTUrWG5JTHFlRzZ2bnlWbHpnb2hLVVNBNW1HN0F5?=
 =?utf-8?B?ZzFzbUhTa3VxYjRmc0lvNzRlNGMxUnNyVlVLdThLMWFKUWkzbUo1eXp4ckxK?=
 =?utf-8?B?dU5GSENiaWZsUy9vMUc4MkdFOFRVaGMxRlBURkxVeG9vSXVzbmZoUWJBZWR4?=
 =?utf-8?B?TzJ3a3QvdmFCYk56SFhKMnczRFVvM0k4dVdzQU1GQ3hsMld3akZCVzcwMy9h?=
 =?utf-8?B?Q0N2Y1ZpQXVuZVlmZ0huSTBGS1AwRWJWd1NiRmFacW0rNlRtZHB2TlNlbE9K?=
 =?utf-8?B?SDFOTXYxVlVhU1plSngyOWlVTjRnME1vYVpvNlJ6aGQvT2I5cVZjMUtIbXND?=
 =?utf-8?B?Y3o2b01jbzViRm5GRGRONjlUZTBhWVcyM1JYN0ZXSlFMQStyRWVmRUdQZWR6?=
 =?utf-8?Q?A2yZgD2b4EwEUah2VQO7kasu7sq+y8atRr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 03:04:55.1992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b23227-4bca-459d-0761-08d8a0a63306
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfXhOYyVS0OhQgOHgT6/5LJNx0lkFdSroTQ0ZpyXvT3hAy0UJ3ZAsX6UPVEU791BT8VegDLQS17/c3z68KIhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIHNlcmllcyBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgoKQW0gMjAyMC0xMi0xMiB1bSAxMDo0NSBhLm0uIHNjaHJpZWIgSGF3a2luZyBa
aGFuZzoKPiBhbWRncHVfaWhfcmVncyBob2xkcyBhbGwgdGhlIHJlZ2lzdGVycyBmb3IKPiBhbiBp
aCByaW5nCj4KPiBTaWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KPiBBY2tlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5j
b20+Cj4gUmV2aWV3ZWQtYnk6IERlbm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+Cj4gUmV2aWV3
ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIHwgMTMgKysrKysrKysrKysrKwo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2loLmgKPiBpbmRleCAzYzljZmU3ZWVjZmYuLjk0YzU2NWI5ZWNhOCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4gQEAgLTMwLDYgKzMwLDE4IEBACj4gIHN0
cnVjdCBhbWRncHVfZGV2aWNlOwo+ICBzdHJ1Y3QgYW1kZ3B1X2l2X2VudHJ5Owo+ICAKPiArc3Ry
dWN0IGFtZGdwdV9paF9yZWdzIHsKPiArCXVpbnQzMl90IGloX3JiX2Jhc2U7Cj4gKwl1aW50MzJf
dCBpaF9yYl9iYXNlX2hpOwo+ICsJdWludDMyX3QgaWhfcmJfY250bDsKPiArCXVpbnQzMl90IGlo
X3JiX3dwdHI7Cj4gKwl1aW50MzJfdCBpaF9yYl9ycHRyOwo+ICsJdWludDMyX3QgaWhfZG9vcmJl
bGxfcnB0cjsKPiArCXVpbnQzMl90IGloX3JiX3dwdHJfYWRkcl9sbzsKPiArCXVpbnQzMl90IGlo
X3JiX3dwdHJfYWRkcl9oaTsKPiArCXVpbnQzMl90IHBzcF9yZWdfaWQ7Cj4gK307Cj4gKwo+ICAv
Kgo+ICAgKiBSNnh4KyBJSCByaW5nCj4gICAqLwo+IEBAIC01Myw2ICs2NSw3IEBAIHN0cnVjdCBh
bWRncHVfaWhfcmluZyB7Cj4gIAlib29sICAgICAgICAgICAgICAgICAgICBlbmFibGVkOwo+ICAJ
dW5zaWduZWQJCXJwdHI7Cj4gIAlhdG9taWNfdAkJbG9jazsKPiArCXN0cnVjdCBhbWRncHVfaWhf
cmVncwlpaF9yZWdzOwo+ICB9Owo+ICAKPiAgLyogcHJvdmlkZWQgYnkgdGhlIGloIGJsb2NrICov
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
