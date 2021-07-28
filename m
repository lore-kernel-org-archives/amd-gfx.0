Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88481C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 14:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A9860F02
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 14:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52A9860F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1BA6E413;
	Wed, 28 Jul 2021 14:21:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12F46E072
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 14:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kauH8MUcjTzWc4kNrGxGOgpp7zqNi20BEL694EzgENg2bD6Ba/XxEWwUnYTtfNz4fsCPgv4sR/y9HN0OvG9XV/Guax+7ykw4uunQde3DQEouPofFdHGEQCCCZPEpAGcHEEzJ96F+difaAiHZcuLWBL31fYzC1xwnXJe5/Xg7fTVqJ5BGrj4cXNvDUuZ9zKsmnh+eso04+3NaM/VrbPkc8D+vReyB/x0Fcw7iaMooucIxUgI6qVUdCd/ZQJgybdasmqVG3i1nJLJEhdrQe39cVU/N8wzdahOALJJNehBrOyFnv3Z1DsDsSzyhShyKDzXMutUlYcf/RcwAMnnNKE9KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfDcNN/a8rw/Cc4kUjsiCmZ4lcohnR8AHYykJBN9Sq0=;
 b=bosg87VmGpSWE5nxmnJYKQkCsgGhPw7bn/sKMn5PUedmqqRW7VrETVALGMh9xsy2txioJGooQ5BeOtJEpEkeQCEVh3qApLMr2OyYOdOylbfwNT6I8rGV/qdzRf5IaTg69Asi98RzW4AReY+vVKnx0nqETf3ynHVRRtkA0kiXlu6LP3Ztc+sVnVPeSak2wB9fGFdpX74WEK+PWtOWLP5LKzEFQv5rnjbBLiGW4EBGgkP8I+xjDrz9ygBPaawnrjHpmChznsT2US0GPyRW92LYQhmqZIzL51T/2Bscn9qmhxRbzi03W9pbBqyT7LupbslEq+Prx97MvkizVD7l+7wkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfDcNN/a8rw/Cc4kUjsiCmZ4lcohnR8AHYykJBN9Sq0=;
 b=2AZglLNnCYi8acaJWYkzpEbEkjomaYwHwJeeEAPXz6roh96sruJYvL5j8rbgfREUHKl9MbpjQEHHvl+U6ihg232qKSPQT6OFG2VhQEMP2pInEmn2E1cuTGitn7ja8tiL1dYWpyc+ebcs1DyktMuDJ9IZCMeqh+OiL2r0u9oXk2I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 14:21:33 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 14:21:33 +0000
Subject: Re: [PATCH] drm/amdgpu: set default noretry=1 to fix kfd SVM issues
 for raven
To: Changfeng <Changfeng.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray.Huang@amd.com, Yifan1.Zhang@amd.com
References: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7d68484f-b293-31c9-15a8-6ed700777dc9@amd.com>
Date: Wed, 28 Jul 2021 10:21:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728063613.3334-1-Changfeng.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 14:21:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b2874ab-706f-4768-e178-08d951d30004
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5177E91245EA0B8B5E70ABBF92EA9@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oPyJhBYlusl07NEQVW5Y+Npvo8S93uuZmXhQc/uhtr5Hqhl157SxLC3XKPV0d+Iy/4LEIqhRDOEiB8oB2u8b+Xodjt9x3AMek28B1PVWnXCsycwtjr1T6u8IT3uWSk9JJVaVjsw2RkYYcf4ika7ug8XkJG5Qb1mvUma+ML+1+OfCpKBZMGyyLNdF/es6PC7OH87Ixn/ViSsqRwSCNN2+fDB5A3fwrxpTnQEEq0A4eFR5d/MYpl7vjLTCgRQgY67u80htpGUxDZ51vNi1rnn2CfPZ5WnKL72Q6l62I95eC1O4NHL6+wJsljz5mfR4kmVILHdaJeH5WUSddS45nUaf8jsZlPMJLQ6c2FtdAXjcaz7nn0WUzgLyckAcVW0rEIG62GaXkdYKI6WJKhNr6cPY7EKw0O9Q1Glq0eEcVGWJCyyW3lkueWEDkcY2TNa4Lb0KcyeuxCdwhBHoh31AA8MIPvLjrsz8UaNWkcGlML91pHWyTfd1igc5foO+vXeLOVZsnkFuE3/XPAjjrd+fKmBnyw6b+aMwYrfb0vqKvwcROjHh7nSM1EvfTXi8C/0IRzinNqYKKRLfLHskAYfz6kSRKkgl9DXGpasRlwtzA3IYtmSdp8t7aMXsxYHRvtTOHSLhayKIyWMufYUuf3gZ3mNdQYveSDwc4RavaBq0oGcmtOidp0NE1OMTKFgmGA/BbwRJ8J0TQ1tVjXGAy2nKvrYRLsPU4ZVoVlzqbx2bkzX1rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(83380400001)(66476007)(66556008)(186003)(66946007)(26005)(8676002)(44832011)(6486002)(6636002)(956004)(5660300002)(16576012)(2616005)(316002)(8936002)(31696002)(36756003)(478600001)(31686004)(2906002)(38100700002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNYOU1oeCt4MmZwaEUxWVZuaWJJTmcwbmlHbG9SakFqeFhoVi9xWmpEcmlx?=
 =?utf-8?B?TlFJZVg4RnAwZVFzVnFVSnQwbFlubEtTUnZoVlRlUlFoTkFqbkFRbW9uZENK?=
 =?utf-8?B?eFd0eGd3ajN5TlVVOG0wMXI0VVJLNmVLclVlbVRVVzdDSVdZOG1CVnBaU0JT?=
 =?utf-8?B?VzhpVlRNN3h3ME5nQ3dyZ052UHVuNXpRdDQrL01oSjZDRmZKcm1UWlVuYkNS?=
 =?utf-8?B?Sy80Z3NRckRSUWJVcXBRd1VSTG5iWklLbXE3QmZHTXBNS2dRRmw5cXpVWk1J?=
 =?utf-8?B?d1ozMjZLdkFHemt4NTRNSGtWNlpvNkJHc2ZxWkRXYTJmdERPSkVEc3RsUENa?=
 =?utf-8?B?VWNZV1czenUxdlRHSXl3cDVuckpCY3RydzNnTFNheXladTFuZVRFUS81ZnF3?=
 =?utf-8?B?Q0lLZGVLYXZ3dzNTbG41bklrekNxYmtZUkxOSjlPQ0Z2amcxQU9jSkNuOE1v?=
 =?utf-8?B?VndBcGZwcnozWUcvN1lOOG5POUxUU3JxOFlHNCtkdUdDUDQ0aDBVZmdFblJv?=
 =?utf-8?B?OGFzSDRFbzNWL1U5UHdNcHNPbFQzZGd1MWEybUtQdDFHMnZXeVpPSjUyYkdp?=
 =?utf-8?B?T2lKRXUxZXRVN0xENHVudUhDSWUrN3c4RnZHSGlManFiRGw5REh1SVk3UTJ6?=
 =?utf-8?B?ZGhxQ0R6TGtYSkErdFQyTThZWHZnMlFaY0FkVE9LVnNhbERQNHA0SGZTUnRj?=
 =?utf-8?B?LzNIY3hySFFCbkRLM1lhTzUvYVQ1bGN4VkZXMDRpVVpVdzVPb1ozUkhvcUdn?=
 =?utf-8?B?ZTI3RGpuWjFFTzRxb1BZb2FoNjNVT2Yyc0pZOUx4Y0pVNGtlek9PeWc5S1Zh?=
 =?utf-8?B?N2t0T1FnU1kwQzdMVlZ6ZmtYa3pVc3RGU3pucUp4blhCWnppTkQ5YU9HU0Ix?=
 =?utf-8?B?bUIzb1pYSXpiSWVod0grVzJOZTArM1BrQUkvUC9ZNmdYZ1FPUk80Wnp1ckxB?=
 =?utf-8?B?R1VuckVodng3YmEvOGFkWm1TMy9sZHVaem9GRFg0WlJNdFA5aEZJdG1Kck5m?=
 =?utf-8?B?dC9weTg4aG1WcGluUW9hdk5BUjdhTWlmamQ2NzBFTE1mbk5sT25QdkFEeFIw?=
 =?utf-8?B?TDJJc2cxL25XaUM3R1VjSVJQa0h3OHJ1TGRJWFFRN2lVcjM3bkdRa3ZORnFa?=
 =?utf-8?B?a0loZkk4WGRhaklEYktLZHI2TEk1cDMwZUNzZGV6Y1B6YjZNNkZFNmNPcDg3?=
 =?utf-8?B?TjN2RnpqZXpDZklERWo1dHc1Ylorcm1raFhaR01LRnZRNWpKdWVCeHpDcldL?=
 =?utf-8?B?K3liNXRodWpoSUhoNG8xRlM3aG02NHo1dTN4dkNzYVBKZ0YyNEpWQUh1U2tl?=
 =?utf-8?B?amE2UFFpL1BLbkZOSnltS3lPRDQ1UHNjNFRVZVUyRjFRVzNON0JmbzlOSEpK?=
 =?utf-8?B?b0lqZzdMaUNNWEhXVUlIV3hCTTFyeGpWSGlsQzRpQ1BEZEpMemZrc2lCTk1H?=
 =?utf-8?B?dUQ0RkFjQjFPc0RGUVZEMitJdDZHaGQ2czJSbEtYalhWM2xWRE12TmJGRXVW?=
 =?utf-8?B?bHh1aFJYeEVkcStBaGd0UTQ1dGtGbjc1NVFydEVVMUdsdnBHTnJmdXB4SmhE?=
 =?utf-8?B?VWhmYzFkZGRTNDdQaUZvcXVkMEN3QW1YOVRPMHhIdFJqQ0krK29UYWFwMklp?=
 =?utf-8?B?dDNnaWlSYnlFNU83N1RieVJPS0VaWk9zaTNGdjd1ek5LTDN2TVNTdjlCTW1S?=
 =?utf-8?B?RUx2bmFLR0Z5REhKZ29pWHREZXJvZXhJenkzMjNNS05RZHBGV3Z3clhJcllI?=
 =?utf-8?Q?Rly3LdM+npGVgd092YwKYejy3PsrR6ynOf3MaUx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2874ab-706f-4768-e178-08d951d30004
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:21:33.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMz5KE7aGYEQ8NCtfnf07Beqox4ftv1ATWo9V5xz7d8NtJfGBSrM9CDw84XCwm8l0PRxbnqGva8aB5RMcx27/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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

RG9lc24ndCB0aGlzIGJyZWFrIElPTU1VdjI/IEFwcGxpY2F0aW9ucyB0aGF0IHJ1biB1c2luZyBJ
T01NVXYyIGZvcgpzeXN0ZW0gbWVtb3J5IGFjY2VzcyBkZXBlbmQgb24gY29ycmVjdCByZXRyeSBo
YW5kbGluZyBpbiB0aGUgU1EuClRoZXJlZm9yZSBub3JldHJ5IG11c3QgYmUgMCBvbiBSYXZlbi4K
CkkgYmVsaWV2ZSB0aGUgcmVhc29uIHRoYXQgU1ZNIGhhcyB0cm91YmxlIHdpdGggcmV0cnkgZW5h
YmxlZCBpcywgdGhhdApJT01NVXYyIGlzIGNhdGNoaW5nIHRoZSBwYWdlIGZhdWx0cywgc28gdGhl
IGRyaXZlciBuZXZlciBnZXRzIHRvIGhhbmRsZQp0aGUgcGFnZSBmYXVsdCBpbnRlcnJ1cHRzLiBU
aGF0IGJyZWFrcyBwYWdlLWZhdWx0IGJhc2VkIG1pZ3JhdGlvbiBpbiB0aGUKU1ZNIGNvZGUuIEkg
dGhpbmsgdGhlIGJldHRlciBzb2x1dGlvbiBpcyB0byBkaXNhYmxlIFNWTSBvbiBBUFVzIHdoZXJl
CklPTU1VdjIgaXMgZW5hYmxlZC4KCkFsdGVybmF0aXZlbHksIHdlIGNvdWxkIGdpdmUgdXAgb24g
SU9NTVV2MiBlbnRpcmVseSBhbmQgYWx3YXlzIHJlbHkgb24KU1ZNIHRvIHByb3ZpZGUgdGhhdCBm
dW5jdGlvbmFsaXR5LiBCdXQgdGhhdCByZXF1aXJlcyBtb3JlIGNoYW5nZXMgaW4gdGhlCmFtZGdw
dV92bSBjb2RlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgpBbSAyMDIxLTA3LTI4IHVtIDI6MzYgYS5t
LiBzY2hyaWViIENoYW5nZmVuZzoKPiBGcm9tOiBjaGFuZ3podSA8Q2hhbmdmZW5nLlpodUBhbWQu
Y29tPgo+Cj4gRnJvbTogQ2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4KPiBJdCBj
YW4ndCBmaW5kIGFueSBpc3N1ZXMgd2l0aCBub3JldHJ5PTEgZXhjZXB0IHR3byBTVk0gbWlncmF0
ZSBpc3N1ZXMuCj4gT3Bwb3NpdGVseSwgaXQgd2lsbCBjYXVzZSBtb3N0IFNWTSBjYXNlcyBmYWls
IHdpdGggbm9yZXRyeT0wLgo+IFRoZSB0d28gU1ZNIG1pZ3JhdGUgaXNzdWVzIGFsc28gaGFwcGVu
IHdpdGggbm9yZXRyeT0wLiBTbyBpdCBjYW4gc2V0Cj4gZGVmYXVsdCBub3JldHJ5PTEgZm9yIHJh
dmVuIGZpcnN0bHkgdG8gZml4IG1vc3QgU1ZNIGZhaWxzLgo+Cj4gQ2hhbmdlLUlkOiBJZGI1Y2Iz
YzFhMDQxMDQwMTNlNGFiOGFlZDJhZDQ3NTFhYWVjNGJiYwo+IFNpZ25lZC1vZmYtYnk6IENoYW5n
ZmVuZyA8Q2hhbmdmZW5nLlpodUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMgfCAxNSArKysrKysrKy0tLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMKPiBpbmRleCAwOWVkZmI2NGNjZTAuLmQ3ZjY5ZGJkNDhlNiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBAQCAtNjA2LDE5
ICs2MDYsMjAgQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0cnlfc2V0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQo+ICAJCSAqIG5vcmV0cnkgPSAwIHdpbGwgY2F1c2Uga2ZkIHBhZ2UgZmF1bHQg
dGVzdHMgZmFpbAo+ICAJCSAqIGZvciBzb21lIEFTSUNzLCBzbyBzZXQgZGVmYXVsdCB0byAxIGZv
ciB0aGVzZSBBU0lDcy4KPiAgCQkgKi8KPiArCWNhc2UgQ0hJUF9SQVZFTjoKPiArCQkvKgo+ICsJ
CSAqIFRPRE86IFJhdmVuIGN1cnJlbnRseSBjYW4gZml4IG1vc3QgU1ZNIGlzc3VlcyB3aXRoCj4g
KwkJICogbm9yZXRyeSA9MS4gSG93ZXZlciBpdCBoYXMgdHdvIGlzc3VlcyB3aXRoIG5vcmV0cnkg
PSAxCj4gKwkJICogb24ga2ZkIG1pZ3JhdGUgdGVzdHMuIEl0IHN0aWxsIG5lZWRzIHRvIHJvb3Qg
Y2F1c2VzCj4gKwkJICogd2l0aCB0aGVzZSB0d28gbWlncmF0ZSBmYWlscyBvbiByYXZlbiB3aXRo
IG5vcmV0cnkgPSAxLgo+ICsJCSAqLwo+ICAJCWlmIChhbWRncHVfbm9yZXRyeSA9PSAtMSkKPiAg
CQkJZ21jLT5ub3JldHJ5ID0gMTsKPiAgCQllbHNlCj4gIAkJCWdtYy0+bm9yZXRyeSA9IGFtZGdw
dV9ub3JldHJ5Owo+ICAJCWJyZWFrOwo+IC0JY2FzZSBDSElQX1JBVkVOOgo+ICAJZGVmYXVsdDoK
PiAtCQkvKiBSYXZlbiBjdXJyZW50bHkgaGFzIGlzc3VlcyB3aXRoIG5vcmV0cnkKPiAtCQkgKiBy
ZWdhcmRsZXNzIG9mIHdoYXQgd2UgZGVjaWRlIGZvciBvdGhlcgo+IC0JCSAqIGFzaWNzLCB3ZSBz
aG91bGQgbGVhdmUgcmF2ZW4gd2l0aAo+IC0JCSAqIG5vcmV0cnkgPSAwIHVudGlsIHdlIHJvb3Qg
Y2F1c2UgdGhlCj4gLQkJICogaXNzdWVzLgo+IC0JCSAqCj4gKwkJLyoKPiAgCQkgKiBkZWZhdWx0
IHRoaXMgdG8gMCBmb3Igbm93LCBidXQgd2UgbWF5IHdhbnQKPiAgCQkgKiB0byBjaGFuZ2UgdGhp
cyBpbiB0aGUgZnV0dXJlIGZvciBjZXJ0YWluCj4gIAkJICogR1BVcyBhcyBpdCBjYW4gaW5jcmVh
c2UgcGVyZm9ybWFuY2UgaW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
