Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E42BC47080
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E7613B4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 02:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E7613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9B36E03A;
	Wed,  2 Jun 2021 02:54:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819D56E03A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 02:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOFGLAtvZ1DW+lrjmRgByzlT03fyNxeFNtGyxTdxyBhd+cCPGfFpBOI3BgFfJfPeatAIHaUjQKRMtZOD+3KRqjEuLIzUVc+KRv2PFRSodm5+uFb3xD0UdsMjOufGzYWxhgZpzCaapr8lgTPRwrc6J6sAG/vrac03s665FgQwTEWalhtFA5JIP8omRBpnmgiWKfskyK3vIBmtbYnHOAn3qUw1ACxRjrMxL8fnbvqut/EMOqCMd3PUsYia+GehEqEI1OP58m2qojsPTKAsBj46RYbgH0ZEwC5d/+s15vV//VD+IQAaJrk2GM4bibLoASKqNpD7wwrcgabyQeVZPyxLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFv9S2aylnEZOpbSu3AbFa3dnE3BkxQgsHn+lqguIxw=;
 b=eDIY2KiKhkpuOGNVDeME2OaKmt2QUE0+r+kK3xgXSMqOZrV3lVxstrsn8Sop0m3rBjaVHLBLxyztHUP9Uzmzr69Xn3FBB6ZFzjBiNb+5SfqsM9w608aThky0SL7IzZKI97DtzWT8YwpLkqZX7GMzw8QNdMp5FHZ4v5X8tGNz5cYYBb+OK31eyMSRPPW7rDqWKBJkqcMKeMxr+Sez20EaioUwbipJGEtQomsbp0YPp0CdIR3u+0iAgrDt1gL3qwth8lQFhr3DFSc+glC8oR+MHzZ9jy0/6lf5FqThewFyqA3zcwlSNf5SHAaDEAlf1MepFEuYdavlduC77WUoC9SJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFv9S2aylnEZOpbSu3AbFa3dnE3BkxQgsHn+lqguIxw=;
 b=bP/Q5HkuQShVREr755FqV2BNDRXCT26wkjawcdoJ7gO0NvEYn2n9bXlsb9UGEoqav35gW+xoPwREkSr3hdAxCgAhnHmA2CU8MenO+qKzKV3Y/SPDaFWqAnsTco2EaM9thDE1Qux0gmqfePlNnk6MZgSNt9/0763OIyay2dL44q4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 02:54:16 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:54:16 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: Add flush_tlb parameter to
 amdgpu_vm_bo_update
To: Eric Huang <jinhuieric.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
 <20210601225907.749049-3-jinhuieric.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2db33600-8504-db7e-7cbe-f16247da7f8e@amd.com>
Date: Tue, 1 Jun 2021 22:54:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210601225907.749049-3-jinhuieric.huang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::44) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27 via Frontend
 Transport; Wed, 2 Jun 2021 02:54:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24609350-4562-4eef-1a75-08d92571b594
X-MS-TrafficTypeDiagnostic: BN9PR12MB5082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50822898E05E2A99002C1F0A923D9@BN9PR12MB5082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzB130Zvu0rbYQPWTCt+8RFRBzNv2N4dyIuNKIOZzZIwUaa6wFZIN8+9MckqF7mJj29Ak9zpSxtj1g+rDoPDsw6kT8DRFCmhOdYslK+1MJWEknr/HRoPcJMsJxeQaL9ZMCfiAl4mG7N8sooowV1M+eTSVH030z7hW/Xop0ZcNr4RgOW0S2dSWw0Htuc5cgs8rh/qY/HdwkFOUkysz9cNRqHJLHRq3dZclDf/Bh4jKsuDteP0HX/YliQTOmeVRuXPWsZtgSelU1utyvH2Lp1C72p4NnozuNjFs2fKpbn1UFR7I7k9mJFKAmY7h8axe3quqiKDt9fhAUY3jWDHAUU61eI7cXxY2BNilaBZusJJjr2UIdlAsP4+I3w8HmpdVbGSAba5HvVRAV+ghgdkjYWcGMJ1D1WBchQ/x1s1prqRtJATs3eSxm5dYaDnBad7r+7LYL5FWXGG/4jiAvrAiXQGwHyT59nYX5MS8Aaln/lRU1I5wApnuATaeNDs1NfB0XSrOx/iZ7j9fP1dC2PpHBHTxPSIIWzoGRLW7igtH94wQOUjvAuaUMc2Hv8KIcJtMLh0pCQnd7KVQ8FaUt6uh11T8L7/E5Ypdoss1vigg/44N/dB/LyYt1BoQN86Z8ETdeOEH2kILu4gQSkTZDXIGbSuynTqUADP+RoyL6cAByc7R5MqHF/QrGdmVYa5CP5nCeEt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(16576012)(478600001)(2906002)(31686004)(6486002)(110136005)(186003)(31696002)(44832011)(38100700002)(36756003)(316002)(8936002)(16526019)(66476007)(83380400001)(26005)(5660300002)(66946007)(86362001)(8676002)(66556008)(956004)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cXRRcUZMUkdYSHp0YVhCd1lYM3U5VzBvZjd0WVRTbjFWNkZGSUE0czhrZjkx?=
 =?utf-8?B?em1QdGtlak1Za2RQNUExcG91RWcvN2M5ZGFRcGpUdXBhc2EyK2d4ZXdGZ0h5?=
 =?utf-8?B?bC81S2c4Ym1vbmlWek1qVUZjYnlMalpoTHZUNzBKOHZ6UlBFc0RIN2c2N3pT?=
 =?utf-8?B?ZzNDSXo0YjhWUjhBUEgzM0w0SkI5Wi9CMWJEUG1KUzA3ck9sZzZFQTZzYXlJ?=
 =?utf-8?B?KzRIRUlVUy9CK0k2NjNpMTJrd05qdWZIa3NxYWNiekxqcVdDcS9zVHFFaVVO?=
 =?utf-8?B?Z0pDQm5LZlU3TWM3aEw5WFJjMEtnQ0dFb1RMWjh0OUZwSE9ncUlFY2NBR3Vi?=
 =?utf-8?B?L1pFOURWMlh0cW1LQm9ROFJLbm9ZTHpkK3hIb3NhbEhNaTAyTWE3akY3citp?=
 =?utf-8?B?TEdsNmN5OHIxaUNqMTRDQTVSajViaWhnK3JYcHhHOHVPYVB3ZzJOSGE1K0Rr?=
 =?utf-8?B?YS93SWd4T0JQRm53aVk2VGh3bHJXOGMyT09ZT0J0QmdZZnpsbnFWSlRxMDZ0?=
 =?utf-8?B?eW1QZXNTNVFpRWQ3M2NIazFpZzMxTHNGVEwyY1dvM2FVSXhEbktqMnl5VTZS?=
 =?utf-8?B?dkpyTmk3MnpOdzlGTnFuc09iRHhqd0VCSU5DQWVEQWhxZlU1M2ozWnltMnBF?=
 =?utf-8?B?YnFwaC9oVVJ0NXhJRWpMTEVPanpqcFM0UTh3OVFraUtoYytlTWNrYnN3Uzhw?=
 =?utf-8?B?S0ZkUG9zUjAvM0lkbXVMbGxRQmNJTS9UV3ZrTlJGRFYva3FCZDlmQXVydmwz?=
 =?utf-8?B?UkZqN3NyY1p0UzdmbWtDL0RQZ1F2Y1BDR0xBTW14blpXZmNLdEtHRkl3QTg3?=
 =?utf-8?B?L3lnQW1HNVBwYjRha09EMUhGbTYyTzZZNHFaSFUxVkhpQUo5ZHJnc3pXL3lL?=
 =?utf-8?B?eHNCMkRZK0tDd3pNZTFzSnV5NzY2Q1JDMEZ3TFFPVUJHWXZNMUZlT0wvYVFj?=
 =?utf-8?B?bmtqS1RwVmtrcG16c2JsUmJ4RURHQ2oxVVNpWDBWVHJXdXpFblBXUW9qN2gr?=
 =?utf-8?B?VlNUTnpWaWtoSXRNYzF5bjZLd1BRMU4wTXl5bk5KMnByUnZndWIzblIzcERl?=
 =?utf-8?B?MjhKcWF1bitVUGY3NmpoYVdwTTB2VFhvZC9uK01wSG0vVS9ML1RtMjRlWGlF?=
 =?utf-8?B?aWI2K25YR2FpRlVQa0RtbkRkdDhUcW51WlZ1SWRwOHArWTc1dk45ZE9NeFVi?=
 =?utf-8?B?ekpUTGxnRkNZL3RSWmN5ZE1FYkFrNDByanZkbDhhanI5eTBySTh0eGNRQW9t?=
 =?utf-8?B?RmYvbDIrTnpSN29YWExQL29FaXNkY0paZnRGa0dLOTlOb0swRjAvcGY5TUMx?=
 =?utf-8?B?cUpSU1Q0ajBaNlplL3BkTXhzQmJsVEp1WkNwaUcySWJKdE1qYWJ5bEpIdlJ4?=
 =?utf-8?B?QTdYQ0VIWTdhaFhNU1FvYnpXU21tdG95OU9vMDNiM2RTS1ZNTnNqamU2TXJU?=
 =?utf-8?B?R1R3eHdhT2dmTEloRjBneWVXSEtqbjh2Qkh2Yk5WSVk4TVYwd0ZKOGljOXpN?=
 =?utf-8?B?cmpKZHcvKzE1QWpiZ1p6YkZiU0Rpd05sbDJBT3oyd0M4NlR2b0JkV29xdGFm?=
 =?utf-8?B?eXVFWEFock9Oa3BqZHl3MURQSjNNY1lRemhCQzJUUExjdzlvV3UwRHVTcHg2?=
 =?utf-8?B?UkJUZkk3a3BjcjVLTUpQN2xjejhlZGFycHIrZWZYc0Y1UlRGYi9PMEpnb2x1?=
 =?utf-8?B?VmRld0pUWHR5aFREc3JkdU01S3YwUEdnZWZWWUFmQWZMZkNyRHo4VHY4Y1dy?=
 =?utf-8?Q?s2cZFqDsBFDdglVs9+aVe0vsqAa+uhw6qXz0mJT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24609350-4562-4eef-1a75-08d92571b594
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:54:15.9551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR4Q0s8HwGp1+Zzcdvot6HfQ6WsJpsQVWHOPudStsF45mp/H2HxwH254LQGpqL2MpsDK2CyNNryufavRZPdDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

QW0gMjAyMS0wNi0wMSB1bSA2OjU5IHAubS4gc2NocmllYiBFcmljIEh1YW5nOgo+IEl0IGlzIHRv
IHBhc3MgdGhlIGZsYWcgdG8gS0ZELCBhbmQgb3B0aW1pemUgdGFibGVfZnJlZWQgaW4KPiBhbWRn
cHVfdm1fYm9fdXBkYXRlX21hcHBpbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxq
aW5odWllcmljLmh1YW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jcy5jICB8ICA2ICsrKy0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMgfCAgMiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyAgfCAxMCArKysrKy0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5oICB8ICAyICstCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+
IGluZGV4IGU5ZjlmNDYyYTY1Mi4uZTNkZjEzMmU1M2E1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBAQCAtOTE2LDcgKzkxNiw3IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X2NzX3ZtX2hhbmRsaW5nKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwKQo+ICAJaWYgKHIp
Cj4gIAkJcmV0dXJuIHI7Cj4gIAo+IC0JciA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgZnBy
aXYtPnBydF92YSwgZmFsc2UpOwo+ICsJciA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgZnBy
aXYtPnBydF92YSwgZmFsc2UsIE5VTEwpOwo+ICAJaWYgKHIpCj4gIAkJcmV0dXJuIHI7Cj4gIAo+
IEBAIC05MjcsNyArOTI3LDcgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfdm1faGFuZGxpbmcoc3Ry
dWN0IGFtZGdwdV9jc19wYXJzZXIgKnApCj4gIAlpZiAoYW1kZ3B1X21jYnAgfHwgYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpKSB7Cj4gIAkJYm9fdmEgPSBmcHJpdi0+Y3NhX3ZhOwo+ICAJCUJVR19PTigh
Ym9fdmEpOwo+IC0JCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBmYWxzZSk7
Cj4gKwkJciA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgYm9fdmEsIGZhbHNlLCBOVUxMKTsK
PiAgCQlpZiAocikKPiAgCQkJcmV0dXJuIHI7Cj4gIAo+IEBAIC05NDYsNyArOTQ2LDcgQEAgc3Rh
dGljIGludCBhbWRncHVfY3Nfdm1faGFuZGxpbmcoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAp
Cj4gIAkJaWYgKGJvX3ZhID09IE5VTEwpCj4gIAkJCWNvbnRpbnVlOwo+ICAKPiAtCQlyID0gYW1k
Z3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBib192YSwgZmFsc2UpOwo+ICsJCXIgPSBhbWRncHVfdm1f
Ym9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBmYWxzZSwgTlVMTCk7Cj4gIAkJaWYgKHIpCj4gIAkJCXJl
dHVybiByOwo+ICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gaW5k
ZXggMjEyMGE4N2E5NDlmLi5lYWMyZmQwMDQ4Y2MgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jCj4gQEAgLTY5Niw3ICs2OTYsNyBAQCBzdGF0aWMgdm9pZCBhbWRn
cHVfZ2VtX3ZhX3VwZGF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCj4gIAlp
ZiAob3BlcmF0aW9uID09IEFNREdQVV9WQV9PUF9NQVAgfHwKPiAgCSAgICBvcGVyYXRpb24gPT0g
QU1ER1BVX1ZBX09QX1JFUExBQ0UpIHsKPiAtCQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2
LCBib192YSwgZmFsc2UpOwo+ICsJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3Zh
LCBmYWxzZSwgTlVMTCk7Cj4gIAkJaWYgKHIpCj4gIAkJCWdvdG8gZXJyb3I7Cj4gIAl9Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCAyYzIwYmJhN2RjMWEuLmZl
ZDNkNDRiNWRlZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
QEAgLTE3MjksNyArMTcyOSw3IEBAIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0
KCZwYXJhbXMsIGZlbmNlKTsKPiAgCj4gIAlpZiAodGFibGVfZnJlZWQpCj4gLQkJKnRhYmxlX2Zy
ZWVkID0gcGFyYW1zLnRhYmxlX2ZyZWVkOwo+ICsJCSp0YWJsZV9mcmVlZCA9ICp0YWJsZV9mcmVl
ZCB8fCBwYXJhbXMudGFibGVfZnJlZWQ7Cj4gIAo+ICBlcnJvcl91bmxvY2s6Cj4gIAlhbWRncHVf
dm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsKPiBAQCAtMTc5Myw3ICsxNzkzLDcgQEAgdm9pZCBhbWRn
cHVfdm1fZ2V0X21lbW9yeShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgdWludDY0X3QgKnZyYW1fbWVt
LAo+ICAgKiAwIGZvciBzdWNjZXNzLCAtRUlOVkFMIGZvciBmYWlsdXJlLgo+ICAgKi8KPiAgaW50
IGFtZGdwdV92bV9ib191cGRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBh
bWRncHVfYm9fdmEgKmJvX3ZhLAo+IC0JCQlib29sIGNsZWFyKQo+ICsJCQlib29sIGNsZWFyLCBi
b29sICpmbHVzaF90bGIpCgpUbyBiZSBjb25zaXN0ZW50IHdpdGggYW1kZ3B1X3ZtX2JvX3VwZGF0
ZV9tYXBwaW5nIEknZCBuYW1lIHRoaXMKcGFyYW1ldGVyIHRhYmxlX2ZyZWVkLgoKCj4gIHsKPiAg
CXN0cnVjdCBhbWRncHVfYm8gKmJvID0gYm9fdmEtPmJhc2UuYm87Cj4gIAlzdHJ1Y3QgYW1kZ3B1
X3ZtICp2bSA9IGJvX3ZhLT5iYXNlLnZtOwo+IEBAIC0xODg3LDcgKzE4ODcsNyBAQCBpbnQgYW1k
Z3B1X3ZtX2JvX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdw
dV9ib192YSAqYm9fdmEsCj4gIAkJCQkJCXJlc3YsIG1hcHBpbmctPnN0YXJ0LAo+ICAJCQkJCQlt
YXBwaW5nLT5sYXN0LCB1cGRhdGVfZmxhZ3MsCj4gIAkJCQkJCW1hcHBpbmctPm9mZnNldCwgbWVt
LAo+IC0JCQkJCQlwYWdlc19hZGRyLCBsYXN0X3VwZGF0ZSwgTlVMTCwKPiArCQkJCQkJcGFnZXNf
YWRkciwgbGFzdF91cGRhdGUsIGZsdXNoX3RsYiwKPiAgCQkJCQkJdnJhbV9iYXNlX29mZnNldCk7
Cj4gIAkJaWYgKHIpCj4gIAkJCXJldHVybiByOwo+IEBAIC0yMTQxLDcgKzIxNDEsNyBAQCBpbnQg
YW1kZ3B1X3ZtX2hhbmRsZV9tb3ZlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCj4g
IAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoYm9fdmEsIHRtcCwgJnZtLT5tb3ZlZCwgYmFzZS52
bV9zdGF0dXMpIHsKPiAgCQkvKiBQZXIgVk0gQk9zIG5ldmVyIG5lZWQgdG8gYm8gY2xlYXJlZCBp
biB0aGUgcGFnZSB0YWJsZXMgKi8KPiAtCQlyID0gYW1kZ3B1X3ZtX2JvX3VwZGF0ZShhZGV2LCBi
b192YSwgZmFsc2UpOwo+ICsJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLCBm
YWxzZSwgTlVMTCk7Cj4gIAkJaWYgKHIpCj4gIAkJCXJldHVybiByOwo+ICAJfQo+IEBAIC0yMTYw
LDcgKzIxNjAsNyBAQCBpbnQgYW1kZ3B1X3ZtX2hhbmRsZV9tb3ZlZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPiAgCQllbHNlCj4gIAkJCWNsZWFyID0gdHJ1ZTsKPiAgCj4gLQkJciA9IGFt
ZGdwdV92bV9ib191cGRhdGUoYWRldiwgYm9fdmEsIGNsZWFyKTsKPiArCQlyID0gYW1kZ3B1X3Zt
X2JvX3VwZGF0ZShhZGV2LCBib192YSwgY2xlYXIsIE5VTEwpOwo+ICAJCWlmIChyKQo+ICAJCQly
ZXR1cm4gcjsKPiAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiBpbmRl
eCA2N2JiYTg0NjJlN2QuLjI0YTYzZTI4NGE2OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5oCj4gQEAgLTQxOSw3ICs0MTksNyBAQCBpbnQgYW1kZ3B1X3ZtX2JvX3Vw
ZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAKPiAgaW50IGFtZGdw
dV92bV9ib191cGRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gIAkJCXN0cnVjdCBh
bWRncHVfYm9fdmEgKmJvX3ZhLAo+IC0JCQlib29sIGNsZWFyKTsKPiArCQkJYm9vbCBjbGVhciwg
Ym9vbCAqZmx1c2hfdGxiKTsKClNhbWUgYXMgYWJvdmUuIFdpdGggdGhhdCBmaXhlZCwgdGhlIHBh
dGNoIGFuZCB0aGUgc2VyaWVzIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgpQbGVhc2UgYWxzbyBnaXZlIENocmlzdGlhbiBhIGNoYW5jZSB0
byByZXZpZXcgdGhpcyBwYXRjaCBpbiBwYXJ0aWN1bGFyCmJlZm9yZSB5b3Ugc3VibWl0LgoKVGhh
bmtzLArCoCBGZWxpeAoKCj4gIGJvb2wgYW1kZ3B1X3ZtX2V2aWN0YWJsZShzdHJ1Y3QgYW1kZ3B1
X2JvICpibyk7Cj4gIHZvaWQgYW1kZ3B1X3ZtX2JvX2ludmFsaWRhdGUoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsCj4gIAkJCSAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8sIGJvb2wgZXZpY3Rl
ZCk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
