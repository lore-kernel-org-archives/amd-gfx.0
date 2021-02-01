Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 13:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E42564D9D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E42564D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EAA6E5A4;
	Mon,  1 Feb 2021 13:56:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4466E5A4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 13:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krdc10b5qGK9Qi31WcF4I06RC4NcB8e3jqgaA7TFeig90xpRfbe1suQqjP31bmkNLGiH58BtvqSdtq3IDSdYNfar79PxGf/FTwegX1Gltj3t7t91y/dd2ubYfFM6AlLHUChY4nF88qSTKdQ/fOEuSfAKksDdXjzTFgJHzBLddOdhdrxv8L4XjQFb9Lq7b9ge1EMTf7VVMRd+4uP299/kg3+9hZ6/UErVSdrVcghgKpOaVjMXuDpGagc6wYOYLF60NyoR9eqkX20hTlG/jQ54xn9wpxvPEa3lBHmlwzfKgIVosvzQKteUH3/KOtS+5qK6xt2OKhbLQWWY2NFfZZc8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKUx8KS5XSWh8Dh9oPe3HdDtgA2PzdXZwoM9bLKM0gM=;
 b=gInB3l17OLFwx4f0E7BmVPSm+Fb9KCDprv+WQNA3k8N4bu7t8pCcdJKSnlugO6sBNZ7YbXJ/tFRmUUZ4l3hyzisE/I1mTcZoQsO5TttqyYwBTJfzJ8i/mIBDpyjyhLAR+DsACVc32mltbDWn9akFOa3WBb4V+nqokelNR4P8b9jZj+8zhiOlay2+XI2C/35A0JFt/i1Q/hxZWVqeH+/vQDybsciWUO8s7mbcExyIbYFNcwUDsfUp2ZLerD/X79lkodh/wii/8fy5bqBGwvd+hvbdwq9GG2HiyEJK2SkJIzpI90qx9LDgrrlAejSFQJ3atVmOyaCQwKN1xjqOSSmjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKUx8KS5XSWh8Dh9oPe3HdDtgA2PzdXZwoM9bLKM0gM=;
 b=NWUX4yOTHIUqtL7O4Mfgtxh64gMoSt4QtIXbdDETHzIZtHLpCkHCauhvZv23CY5w0oKSmqqSilJ3g0CSpFybiY9cvzrO/zwUapju3wRuVy0pNvE4VMZ6v9EdVR02jetT81SdpjxMTtNAZb0SYVHxJW73/G+5Z0ypsUPjHTg10H8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 13:56:12 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 13:56:12 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210201120735.2970-1-nirmoy.das@amd.com>
 <20210201120735.2970-3-nirmoy.das@amd.com>
 <f2ed5848-5c26-3d60-0f57-2a918eff17e0@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <76da5ca4-8425-6beb-2284-0068b87a2db2@amd.com>
Date: Mon, 1 Feb 2021 14:56:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <f2ed5848-5c26-3d60-0f57-2a918eff17e0@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.32.223]
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.32.223) by
 FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8 via Frontend Transport; Mon, 1 Feb 2021 13:56:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcc67004-da3b-4df6-0c8e-08d8c6b92280
X-MS-TrafficTypeDiagnostic: DM6PR12MB4201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42014A66E48BFDB87E234EFA8BB69@DM6PR12MB4201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30mzV90SC/RAxtMYZbvi2eEkmf8tmT9wUyF5BVckzlYaNV9Er7QPB0V7GmYJZ1oEbBdszPKiFZSeKjVAVBSoL9v31bZFRql4xnu+fWCMtKlT2x6P7sKp9//rBXzTdRnkYDJTaYGLxTqwMvpBzTrJNR8isWpuX1FVlvpmU1pmajfCsc9aJkbj3xjahB3Go4+jgrPlVXcj8HMXjp7Qaz3NyAAHPXKVBkCMW/mOA6pwuaQT88LnIzNkI2/3XGZQhl6eUe7javtDAxjnFqkBxYvSmYfgxQJomnMGFsYRDLztdEeQbc/GJgv+DRPnKaa9A9hNfu9tZZeWg8Bbk4N826U737ZlrcAkSUKzp3HsCjDlMzmCLfYbnsQPj+thS4vt+McHfZDZv1XVF+li/p/mSjMuGBw5FdA7d2H5Nav+gSaaS8rkMyXgmdegC2k0YeyONT9CsoqlBFIrW4CeCPlKb8Al0vnKms+4czgXOBt9U+U9llthLLoc/uDWrm13/8we9qaDAj1BLH9Z4DPJ8AGg9JPcrZtxsbliqlXKHGfwMofqV6xSTfsiGqtpIz519ZESBOmyOlaLbbPSAZfnV3GpxtLrxVgpkZSeNTaqPgt5bM1W2Wk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(478600001)(186003)(8676002)(31686004)(2906002)(16526019)(8936002)(66946007)(52116002)(26005)(53546011)(4326008)(6486002)(316002)(6666004)(31696002)(2616005)(83380400001)(956004)(16576012)(110136005)(36756003)(5660300002)(66574015)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NlRhRnRjYU5CcUJEZUxvWTQ1MzlUVE9lYWVrNEhPOUpiM0UvTHFFc0dvSS81?=
 =?utf-8?B?MG5xLzRGV2FweEdsdXFLb0htanNVZ3ZkTUs3d3dXMlQ2WGdvVHpVMk8xMWNl?=
 =?utf-8?B?OXpFVnQ2TGpuczZkUThoQURZZHVBeDJmUWxPSEM0RjkyWVNpbGRTWkNhRHI1?=
 =?utf-8?B?VitZcVVJdERQSnQrYk52eFBBclZlblpIQUozVFhLMWpvUDY1S1lHRkd0TC9n?=
 =?utf-8?B?OGpCUkxreGEzRk1zQUxXdDNoOHZTTkxXeW4zeTVQb3NRK0t3Zk1LV1dIaEZQ?=
 =?utf-8?B?OSt2dlBuNjNWMUhDZVF4cXlxd0NxajdOTzZrS216ODR3dWhUS3g2UGJ6a1Fv?=
 =?utf-8?B?VmxlS0xUN3lldjloZUFla2Q1TGJGL3Z0T2xhUEUzR09XWWZ4cEx0Tk5seG9u?=
 =?utf-8?B?NVJ3Y3d2bUZtWUhFS0ZpaXhVYkYvVUdjSGg2bXRDWnpEdE5wV0U2Y1dmQjZm?=
 =?utf-8?B?NnlsU1gyUHVtaCthTkErV29oNzRrMWlHRzQ4Q1hYTFNXM2NBR2NtRy9ad1dI?=
 =?utf-8?B?R0tiemNtL0NtRlJ6ZC85SFVQdkVPaGswK1crN3J5eVJqR1RFVDd5c3c0dklr?=
 =?utf-8?B?bTlrZkVFUGoxeWQwdzFBc1R2Y1BDREZKRWd2UXZTclFEWStiUUJ1a1c5T1Vn?=
 =?utf-8?B?ODZXbnNWaTBzK1NUNVVJZUR6R3BRaGQxRC9FRVA4Z2doVVdWaWp1T2E5YXVy?=
 =?utf-8?B?b1d0a0VrN3N5clNaVTUreUNOWDc0elNlYkd6eG1wb0V5NDAxRUkwMzBzNjBV?=
 =?utf-8?B?aWhYNzdpamQ1WFpOenZuY2tEb0lJZzJxbFRkdlJsOUhrL1Y2NHUwYWpsbDAy?=
 =?utf-8?B?bXJGMWMxbEo5NWs3dStWTXhLdWtpcDgzak1wYXZWQ0tVKzd0UE94OG5IdjF5?=
 =?utf-8?B?NC9senZPVXhqaHA3aXoxMWgxSWhTRG9XVHZXMkJpSmhyY0FENUpnMmJRM1ls?=
 =?utf-8?B?bHg3NjNoOFFSRFpXRWprOWJtSnJ3TFBvdzlpMkt2aWtZOCs5R3g3ZGwvZ2lk?=
 =?utf-8?B?cllzbko5NjB1TEVkNzlQaHBBbzNkWVhBSTIyU2pGemRSOGdVMTdRd2JEU0Vt?=
 =?utf-8?B?dWxIRnMvTWdqSVFyaWRZamhsdFJOS0lDUkhDSURsQ3dOVzNISzF5WkQwd3FK?=
 =?utf-8?B?NlNHRjdPL3lVN3ZNZzV6c1E0MVU1eGgrbzM0ZS9mYjZ4emc3MHV2T0JlYmdo?=
 =?utf-8?B?UUVPS1Z3QWw2L3gwb1dndUQ4UXVCVHl6L3ZUWDVlNnhkbFBSYndhVkowMk5S?=
 =?utf-8?B?eVpKRVJvRUpSSndJU1BKREpiMnFGL0VEU01Oa3ZVNXp2RExhbDY2Y3RJS2w4?=
 =?utf-8?B?UGpQZXkwQ0tRREhjd0haWUo4U2l3Q0xCZ0xxY0tYbUdUVnJMRk5UYXd2WlRh?=
 =?utf-8?B?RTlsNEh3emQ5MmZYQnBKdXdnRnJtZWRWcHlaRHF1NlNSTHRyUFVtWlBla1NF?=
 =?utf-8?Q?AN5fdoVc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc67004-da3b-4df6-0c8e-08d8c6b92280
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 13:56:12.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3GzNy38Yy1AT8gLu1UbWpEy5Evtk//6jZSiBnqYc/+0sXamRbnh8ArxVWwvfMopl/nd6p3+PDPLKKahE8Kf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

Ck9uIDIvMS8yMSAxOjE5IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAxLjAyLjIx
IHVtIDEzOjA3IHNjaHJpZWIgTmlybW95IERhczoKPj4gRW5hYmxlIGdmeCB3YXZlIGxpbWl0aW5n
IGZvciBnZnggam9icyBiZWZvcmUgcHVzaGluZyBoaWdoIHByaW9yaXR5Cj4+IGNvbXB1dGUgam9i
cyBzbyB0aGF0IGhpZ2ggcHJpb3JpdHkgY29tcHV0ZSBqb2JzIGdldHMgbW9yZSByZXNvdXJjZXMK
Pj4gdG8gZmluaXNoIGVhcmx5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWIuYyB8IDkgKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pYi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCj4+IGlu
ZGV4IDAyNGQwYTU2M2E2NS4uZWU0ODk4OWRmYjRjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaWIuYwo+PiBAQCAtMTk1LDYgKzE5NSwxMCBAQCBpbnQgYW1kZ3B1X2li
X3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgCj4+IHVuc2lnbmVkIG51bV9pYnMs
Cj4+IMKgwqDCoMKgwqAgaWYgKChpYi0+ZmxhZ3MgJiBBTURHUFVfSUJfRkxBR19FTUlUX01FTV9T
WU5DKSAmJiAKPj4gcmluZy0+ZnVuY3MtPmVtaXRfbWVtX3N5bmMpCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByaW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYyhyaW5nKTsKPj4gwqAgK8KgwqDCoCBpZiAo
cmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdCAmJiBqb2IgJiYKPj4gK8KgwqDCoMKgwqDCoMKg
IGpvYi0+YmFzZS5zX3ByaW9yaXR5ID49IERSTV9TQ0hFRF9QUklPUklUWV9ISUdIKQo+PiArwqDC
oMKgwqDCoMKgwqAgcmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdChyaW5nLCB0cnVlKTsKPgo+
IFNpbmNlIHdlIGNhbiBvbmx5IGRvIHRoaXMgZm9yIG9uZSByaW5nIGFueXdheSB3ZSBzaG91bGQg
cHJvYmFibHkgY2hlY2sgCj4gdGhlIHJpbmcgcHJpb3JpdHkgaW5zdGVhZCBvZiB0aGUgam9iIHBy
aW9yaXR5LgoKCgo+Cj4gQWx0ZXJuYXRpdmVseSB5b3UgY291bGQgcHV0IHRoaXMgaW50byBiZWdp
bl91c2UgYW5kIGVuZF91c2UgY2FsbGJhY2tzIAo+IG9mIHRoZSByaW5nIGluc3RlYWQgb2YgYWRk
aW5nIGFuIGV4dHJhIGNhbGxiYWNrIGZvciB0aGlzLgoKCkkgZGlkbid0IGtub3cgYWJvdXQgYmVn
aW5fdXNlIGNhbGxiYWNrcy4gSSB3aWxsIHJlc2VuZCB3aXRoIGFib3ZlIApzdWdnZXN0ZWQgY2hh
bmdlcy4KCgpUaGFua3MsCgpOaXJtb3kKCgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+ICsKPj4gwqDCoMKg
wqDCoCBpZiAocmluZy0+ZnVuY3MtPmluc2VydF9zdGFydCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHJpbmctPmZ1bmNzLT5pbnNlcnRfc3RhcnQocmluZyk7Cj4+IMKgIEBAIC0yOTUsNiArMjk5LDEx
IEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nIAo+PiAqcmluZywg
dW5zaWduZWQgbnVtX2licywKPj4gwqDCoMKgwqDCoCByaW5nLT5jdXJyZW50X2N0eCA9IGZlbmNl
X2N0eDsKPj4gwqDCoMKgwqDCoCBpZiAodm0gJiYgcmluZy0+ZnVuY3MtPmVtaXRfc3dpdGNoX2J1
ZmZlcikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9yaW5nX2VtaXRfc3dpdGNoX2J1ZmZl
cihyaW5nKTsKPj4gKwo+PiArwqDCoMKgIGlmIChyaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xpbWl0
ICYmIGpvYiAmJgo+PiArwqDCoMKgwqDCoMKgwqAgam9iLT5iYXNlLnNfcHJpb3JpdHkgPj0gRFJN
X1NDSEVEX1BSSU9SSVRZX0hJR0gpCj4+ICvCoMKgwqDCoMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1p
dF93YXZlX2xpbWl0KHJpbmcsIGZhbHNlKTsKPj4gKwo+PiDCoMKgwqDCoMKgIGFtZGdwdV9yaW5n
X2NvbW1pdChyaW5nKTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
