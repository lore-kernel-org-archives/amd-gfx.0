Return-Path: <SRS0=vakm=IA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A384C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0186964F0D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Mar 2021 13:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0186964F0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8879C6E949;
	Tue,  2 Mar 2021 13:06:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C0A6E949
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Mar 2021 13:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKAVDBDuFkIQwuo5ECODgD5e+IVD5hThVuvwn9aXyO5dDr23rG0yP3tcwwvNQ/pLGd1Xr0h8EKmJ571jFeg3gBlQZ1dGLzp4k6hqJ0CSHCphYqGZs29hoYRiSMpTaJ+s+nFGB/QapEK1CQkQIY1gKTqRFszKxVIKuzH0+GoJN3dI+8pG4t4NSq1gTjE03EhfsEuYwpnP2HiKCzBPurqlyQH0eu0/GYiY5KP/S/Mfjd7Mc3eJyx8m1Wl2Izc3ZUZFOvr3tRo7diUJeZXs22JxA4e6a1Yx7F0aVbfcX6b4OSw4ZaD7AqkP79+96j6dE1rMwJx97MABbPzrcM2GA1EQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBc7ildGp/TIEy6UdKXnbrZZyUio7X8PAf0aD/xWCPw=;
 b=LAKCtiRZJtu3wq2Y8QHSKxHvdcjiYZinHbvYyuLAFP2WehNsh6ebSTnjdGCpIPG42Gw5iLNy8d314yJNyfPz5unKWUxuymTASu5Fw7VnxOUzTkyzrz1gOvMq0ZZmblk/ARU4vZMha0PtEWFe4Snd6SjGBq6Zx1ZxL7ld+w6xGWPMtafYKcsDg8k2yabHG3XLG7HQoaJr5RUXh5VEZTxql7WXStY4wE8X1nsEa0QVfZeZNwzziLpHqauErybWteBY4MM6zEfIgzM9GLx/F3VI3AoVa+Zn4UFAk10CY25yW/Als+nrgqsW6BDYOCqu9H+f9E1sztARwOZVlkZmpGnD8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBc7ildGp/TIEy6UdKXnbrZZyUio7X8PAf0aD/xWCPw=;
 b=bjGIVmaDxvWpjSQwA+0ucDTAoSMljEf/yzqlOE5f7cIL//HppMP0Vv6B5xXWNJxeHbOuIfL7CRiQ4qo1zW1CeoCXg+l09zEIPjWBivG6rNSVqtsePJZ7Ks9qvoXx6g0TvYavPFx8h0yDY77S+qOvG/YMlmaM/8AdU+x/7qBt7nI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4813.namprd12.prod.outlook.com (2603:10b6:208:1bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 2 Mar
 2021 13:06:10 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 13:06:10 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: introduce kfd user flag for amdgpu_bo
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 Felix.Kuehling@amd.com
References: <20210302113341.74813-1-nirmoy.das@amd.com>
 <20210302113341.74813-2-nirmoy.das@amd.com>
 <2a73e3af-92a1-a356-0206-935c661c978a@amd.com>
 <dd5ac16c-c5ca-c5f7-226c-3f226e1b3589@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <81315296-f0a3-b196-fdc0-179e608c2535@amd.com>
Date: Tue, 2 Mar 2021 14:06:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <dd5ac16c-c5ca-c5f7-226c-3f226e1b3589@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9804:8dfd:7f6e:acec]
X-ClientProxiedBy: AM4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9804:8dfd:7f6e:acec]
 (2a02:908:1252:fb60:9804:8dfd:7f6e:acec) by
 AM4P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 13:06:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea3bb7c6-29d9-4ede-0623-08d8dd7bf30e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4813:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB48138BC270AEE19A33B4BA2483999@MN2PR12MB4813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhoWr5XZJLQBid2AIBGkVCoAwe4gSHbWjB7WEuS3BrctzveCZ2/lwNjrVeGyxo9x/YGDPv3uGBkx5SemFMVTtyE/PApDglsVEOcTZKsUjHMDSPgwQZj4GhJ9pLo9nH9YnBOfqeLmnjhxuvxDIng/xgRo1aA6md/oYnMswZ3TPLyaELY+nwZIL0UQsEXZucb8HlIaaM5yjZJANiCOEuG32Iy5plQYJa/rlM7mwAg5p4COXKUsTKvFoLBxaxvl/Urb8aF+wgk+2OYUoOXxzZ7uqewKUoGmJtDXyTs8gJELeI4E7rWpVDafyw9IPQYM295hCwdmkjgCC5crMHICXjweDdIT4BXdH0CHr6goI1WJo5JV4CviUBOsW+RjVVdx1p6whSPub/8E1mYW7eF5Yz5eJXLHCxc+5z9Osa/MjbuQXY5jrGIscq7ElyLYrE7wHQo8g4A9iT/I90MYgSJmhXP8SIoa7x6ITtssXXnEOlZkug3mbz7rICW6mXTaFrnzm6tBJXlM6y0QJwhR2cToMHU1uOjOqXILsuvgqpFf99gmT/xkC+GSLQIvH6jpbSJf1cp6yJ8GDGdz0zYLG+MqhhxpX7uS1xlVEu/oD8Wn86fWx+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(86362001)(8676002)(6666004)(53546011)(110136005)(31686004)(316002)(8936002)(52116002)(36756003)(31696002)(83380400001)(66946007)(66556008)(66476007)(5660300002)(2906002)(6486002)(16526019)(186003)(6636002)(478600001)(2616005)(66574015)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmFJTUpzVzUyb1BlN3BlVHdUSFEzcFRQVER1MGJLREZPeko1OFBxcE1sTUtG?=
 =?utf-8?B?MStCU1RrQkhvNkttUVJ0cEpuU3VraVJvWWFxWkVEeUNXK04rdEFhUHRIaDBh?=
 =?utf-8?B?ME9kZi94VzUrcW9iVmJuaDNVNVB3UzBxSk5UeW9rTDBiWng1TU9pSEZ0OUlm?=
 =?utf-8?B?QlNha3FaM3FCVmxTc09XTGZCZXFLVkh0RmxRWktyR01wZUtWM1pPMjByY2tT?=
 =?utf-8?B?cmFDK3ZUcjlHcjBQU2VPeGk1aHFrQUJCNHV3WGtndWJHT3dCcEgrVzhOTjYw?=
 =?utf-8?B?d3NSMFE3bFV4LzdRWmt2d2hzYjQwVW1CN253VUxTMnczYmVQanE4cUg4K3g4?=
 =?utf-8?B?N2MvUEMxN3dhbU9HZm5MYzNwaXZQdzY4QzV2eWRHNElHak9IOXJwdHJsejJN?=
 =?utf-8?B?NEJuY1hvdzF0TGxwWFczMVhDeG1ZNWxrSU0vNXlReHVYYzNGTHpuTENMYnZ3?=
 =?utf-8?B?R1FST1VEdjFXcCtZWFlVZWdmN0xoSEhRRVErZnBaYW5mWG5yTFJVY3FGZUNp?=
 =?utf-8?B?bTJRVXVyTmZwTU5keGNxTGxDZUdOVUo4VjB6RmxneW81KzVQaEZPOFZkYUZ1?=
 =?utf-8?B?c2J4SkdWRUhLNFBmRzZmeDluT2ZGNklMRUFDd2lnbi9ZSVJhNEx3MmdyNlVM?=
 =?utf-8?B?SXRneUpkeXF6dysxdEptaXp6d2FOV2Q5V0ZrSElOSmZ5WHVVU0drd3V1TjBt?=
 =?utf-8?B?RC9LbndNck9pbytNNWhVbmRzZUNVZEpyWUdFVkRjRkg1cmtaekNTdmV3aEpT?=
 =?utf-8?B?c1dUV3h6M2EwT1l6Z3IyZ2pmNWRXZGNqRE9BTjJucFRJZmFQakNxY0R4RGd3?=
 =?utf-8?B?OFNyRGFpM0JnWVFUa0FuZzlXT3Y3bE9kZnR4MUR2c2dIRTMwWStqbU8ra0Fy?=
 =?utf-8?B?V3MvaGNiZ3p4ODBCL3UwUkUvYUZCbWI2QW44Ym00UkErWVlrR2pNZ25keVJ6?=
 =?utf-8?B?UVFHanliRlFkOFBRTWZsZmZkNjYzUDFvZk1DWWlUM3BoWThrdTdxbStyZ1VT?=
 =?utf-8?B?dnUybHFwK3UzYWQ3Q2wyZFQwNERWU1l6d0xVOUEzM2NOQU1NaXB0MTVkMWJZ?=
 =?utf-8?B?Y2tYWGJrOTZtYlpxSDREY3pUSVhsalhCWkYySUxpMjRsNU5zSlkzU09FUWF2?=
 =?utf-8?B?WWFHVGlDalM4VmU0cjc2MG5Ga1dqYVRCdmFBRDU2R1FFR1RiUnNZZWFFYisx?=
 =?utf-8?B?M1BCbGxGd2ZrQ1JpMDhlSVRlaVhUYVRWVVpQYkxIYjRBVGp1VkVRTy9NbTRt?=
 =?utf-8?B?c1VKMU91U1lzLzhyVWtEeTZCQ1A3VVVyQ0plclA5VGFOTEU4em5DaGtZWW91?=
 =?utf-8?B?aVlrajZKOVJnWlVSTHBYOWU4TDY5NG1aTENQc3lkNm1QQlhJUmtFSVhXSEhY?=
 =?utf-8?B?eEJ0QTBiSU5ZUys3L1dkVEhGZmNtdFQ1aVR0OG5DSzRORDNzcnZpVlJXa3M2?=
 =?utf-8?B?SjFyTzllMjd4VUxZaVYvcnRxUTZtSVpGcVZ5cXZYbDVpNmEzS2srZXhUdmp3?=
 =?utf-8?B?SjZKc1dpakJrdjAxdC94QVhXelRYVTk5cjlrWloyYzJrb2FpUGZ2bnVYWnNw?=
 =?utf-8?B?cVFlY25vMC9GTnAva0k2WmZCcldsd3hMQ1VkdFRSTnpNUXFNMGYwQTRMS3ov?=
 =?utf-8?B?Q0hiM2g2YUtCektvNjA2aENQakV2R0RvUlNNV0tjaVo3UjU1L0NKKzFkT05G?=
 =?utf-8?B?K2lrdEU5RHR2a0VsenFITDV6OEJIbkViMFZZWEVKdEd4YTFVUFpzSVAwSERQ?=
 =?utf-8?B?L3FYZksvcC9aaUNZSnNIN0tUV2VzbDltWXFITGFkQlFxcVE0MDliSWM0d080?=
 =?utf-8?B?NU1ReDNNSTJXa2ZrRlZvQ2x5cmhzVmVxdUV1OSs5UmphRVlWSGdwN28rTGZx?=
 =?utf-8?Q?d8CV2vNihkj6C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3bb7c6-29d9-4ede-0623-08d8dd7bf30e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 13:06:10.3562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCwdc9uDjwLqMH7qIF1P2RIRy0KiehJzHk4UB8xtBml21N4Y/FBmyZE5PlSg7PEC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4813
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

QW0gMDIuMDMuMjEgdW0gMTQ6MDEgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAzLzIvMjEgMTo0MCBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4KPj4KPj4gQW0gMDIuMDMuMjEgdW0gMTI6MzMg
c2NocmllYiBOaXJtb3kgRGFzOgo+Pj4gSW50cm9kdWNlIGEgbmV3IGZsYWcgZm9yIGFtZGdwdV9i
by0+ZmxhZ3MgdG8gaWRlbnRpZnkgaWYKPj4+IGEgQk8gaXMgY3JlYXRlZCBieSBLRkQuCj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+Pj4gLS0t
Cj4+PiDCoCAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uY8KgIHzC
oCAyICstCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmPCoMKg
wqDCoMKgwqAgfMKgIDMgKy0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuY8KgwqDCoCB8IDQ4IAo+Pj4gKysrKysrKysrKysrKysrKysrLQo+Pj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5owqDCoMKgIHzCoCAzICsrCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmPCoMKgwqDCoMKgwqAg
fMKgIDIgKy0KPj4+IMKgIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5owqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysKPj4+IMKgIDYgZmlsZXMgY2hhbmdlZCwgNTkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIAo+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4+IGluZGV4IDg5ZDBl
NGY3YzZhOC4uNTc3OTg3MDdjZDVmIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPj4+IEBAIC0xMjI3LDcgKzEyMjcsNyBA
QCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KAo+Pj4gwqDCoMKg
wqDCoCBicC5mbGFncyA9IGFsbG9jX2ZsYWdzOwo+Pj4gwqDCoMKgwqDCoCBicC50eXBlID0gYm9f
dHlwZTsKPj4+IMKgwqDCoMKgwqAgYnAucmVzdiA9IE5VTEw7Cj4+PiAtwqDCoMKgIHJldCA9IGFt
ZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmYm8pOwo+Pj4gK8KgwqDCoCByZXQgPSBhbWRncHVf
a2ZkX2JvX2NyZWF0ZShhZGV2LCAmYnAsICZibyk7Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpIHsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiRmFpbGVkIHRvIGNyZWF0ZSBCTyBvbiBk
b21haW4gJXMuIHJldCAlZFxuIiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZG9tYWluX3N0cmluZyhhbGxvY19kb21haW4pLCByZXQpOwo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAKPj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+PiBpbmRleCA4ZTliOGE2ZTZlZjAuLjk3ZDE5
ZjZiNTcyZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZW0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5j
Cj4+PiBAQCAtMjM0LDcgKzIzNCw4IEBAIGludCBhbWRncHVfZ2VtX2NyZWF0ZV9pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAKPj4+ICpkZXYsIHZvaWQgKmRhdGEsCj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DTEVBUkVEIHwKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURHUFVfR0VNX0NSRUFURV9WTV9BTFdBWVNfVkFM
SUQgfAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9HRU1fQ1JFQVRF
X0VYUExJQ0lUX1NZTkMgfAo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNREdQVV9H
RU1fQ1JFQVRFX0VOQ1JZUFRFRCkpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQU1E
R1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEIHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBBTURHUFVfR0VNX1VTRVJfS0ZEKSkKPj4KPj4gUGxlYXNlIHN0aWNrIHdpdGggdGhlIG5hbWlu
ZyBoZXJlLiBBbmQgd2h5IF9VU0VSX0tGRCBhbmQgbm90IGp1c3QgX0tGRD8KPgo+IE9rLCBJIHdp
bGwgcmVuYW1lIGl0IHRvIEFNREdQVV9HRU1fS0ZEIHdoaWNoIHNvdW5kcyBtdWNoIGJldHRlci4K
Ck5vLiBXaGVuIHlvdSB3YW50IHRvIHVzZSB0aG9zZSBmbGFncyB5b3Ugc2hvdWxkIHByb2JhYmx5
IGNhbGwgdGhpcyAKQU1ER1BVX0dFTV9DUkVBVEVfS0ZELgoKQ2hyaXN0aWFuLgoKPgo+Cj4gVGhh
bmtzLAo+Cj4gTmlybW95Cj4KPj4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gwqAgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+PiBpbmRleCAwYmQyMmVkMWRhY2YuLjVlYmNlNmQ2
Nzg0YSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jCj4+PiBAQCAtNjk3LDYgKzY5Nyw1MiBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+PiDCoCB9Cj4+
PiDCoCArLyoqCj4+PiArICogYW1kZ3B1X2tmZF9ib19jcmVhdGUgLSBjcmVhdGUgYW4gJmFtZGdw
dV9ibyBidWZmZXIgb2JqZWN0IHdpdGggCj4+PiBrZmQgdXNlciBmbGFnCj4+PiArICogQGFkZXY6
IGFtZGdwdSBkZXZpY2Ugb2JqZWN0Cj4+PiArICogQGJwOiBwYXJhbWV0ZXJzIHRvIGJlIHVzZWQg
Zm9yIHRoZSBidWZmZXIgb2JqZWN0Cj4+PiArICogQGJvX3B0cjogcG9pbnRlciB0byB0aGUgYnVm
ZmVyIG9iamVjdCBwb2ludGVyCj4+PiArICoKPj4+ICsgKiBDcmVhdGVzIGFuICZhbWRncHVfYm8g
YnVmZmVyIG9iamVjdDsgYW5kIGlmIHJlcXVlc3RlZCwgYWxzbyAKPj4+IGNyZWF0ZXMgYQo+Pj4g
KyAqIHNoYWRvdyBvYmplY3QuCj4+PiArICogU2hhZG93IG9iamVjdCBpcyB1c2VkIHRvIGJhY2t1
cCB0aGUgb3JpZ2luYWwgYnVmZmVyIG9iamVjdCwgYW5kIAo+Pj4gaXMgYWx3YXlzCj4+PiArICog
aW4gR1RULgo+Pj4gKyAqCj4+PiArICogUmV0dXJuczoKPj4+ICsgKiAwIGZvciBzdWNjZXNzIG9y
IGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLgo+Pj4gKyAqLwo+Pj4gKwo+Pj4gK2lu
dCBhbWRncHVfa2ZkX2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKipib19wdHIpCj4+PiAr
ewo+Pj4gK8KgwqDCoCB1NjQgZmxhZ3MgPSBicC0+ZmxhZ3M7Cj4+PiArwqDCoMKgIGludCByOwo+
Pj4gKwo+Pj4gK8KgwqDCoCBicC0+ZmxhZ3MgPSBicC0+ZmxhZ3MgJiB+QU1ER1BVX0dFTV9DUkVB
VEVfU0hBRE9XOwo+Pj4gK8KgwqDCoCBicC0+ZmxhZ3MgPSBicC0+ZmxhZ3MgfCBBTURHUFVfR0VN
X1VTRVJfS0ZEOwo+Pj4gK8KgwqDCoCByID0gYW1kZ3B1X2JvX2RvX2NyZWF0ZShhZGV2LCBicCwg
Ym9fcHRyKTsKPj4+ICvCoMKgwqAgaWYgKHIpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7
Cj4+PiArCj4+PiArwqDCoMKgIGlmICgoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9TSEFET1cp
ICYmICEoYWRldi0+ZmxhZ3MgJiAKPj4+IEFNRF9JU19BUFUpKSB7Cj4+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCFicC0+cmVzdikKPj4+ICsgV0FSTl9PTihkbWFfcmVzdl9sb2NrKCgqYm9fcHRyKS0+
dGJvLmJhc2UucmVzdiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgTlVMTCkpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIHIgPSBh
bWRncHVfYm9fY3JlYXRlX3NoYWRvdyhhZGV2LCBicC0+c2l6ZSwgKmJvX3B0cik7Cj4+PiArCj4+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFicC0+cmVzdikKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRtYV9yZXN2X3VubG9jaygoKmJvX3B0ciktPnRiby5iYXNlLnJlc3YpOwo+Pj4gKwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIGlmIChyKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1
X2JvX3VucmVmKGJvX3B0cik7Cj4+PiArwqDCoMKgIH0KPj4+ICsKPj4+ICvCoMKgwqAgcmV0dXJu
IHI7Cj4+PiArfQo+Pj4gKwo+Pj4gKwo+Pj4gwqAgLyoqCj4+PiDCoMKgICogYW1kZ3B1X2JvX3Zh
bGlkYXRlIC0gdmFsaWRhdGUgYW4gJmFtZGdwdV9ibyBidWZmZXIgb2JqZWN0Cj4+PiDCoMKgICog
QGJvOiBwb2ludGVyIHRvIHRoZSBidWZmZXIgb2JqZWN0Cj4+PiBAQCAtMTMwOSw3ICsxMzU1LDcg
QEAgdm9pZCBhbWRncHVfYm9fcmVsZWFzZV9ub3RpZnkoc3RydWN0IAo+Pj4gdHRtX2J1ZmZlcl9v
YmplY3QgKmJvKQo+Pj4gwqAgwqDCoMKgwqDCoCBhYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKGJvKTsK
Pj4+IMKgIC3CoMKgwqAgaWYgKGFiby0+a2ZkX2JvKQo+Pj4gK8KgwqDCoCBpZiAoYWJvLT5mbGFn
cyAmIEFNREdQVV9HRU1fVVNFUl9LRkQpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2Ft
ZGtmZF91bnJlc2VydmVfbWVtb3J5X2xpbWl0KGFibyk7Cj4+PiDCoCDCoMKgwqDCoMKgIC8qIFdl
IG9ubHkgcmVtb3ZlIHRoZSBmZW5jZSBpZiB0aGUgcmVzdiBoYXMgaW5kaXZpZHVhbGl6ZWQuICov
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5oIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4+
IGluZGV4IDhjZDk2YzkzMzBkZC4uNjY1ZWUwMDE1ZjA2IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4+IEBAIC0yNDUsNiArMjQ1LDkgQEAg
dm9pZCBhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKHN0cnVjdCAKPj4+IGFtZGdwdV9i
byAqYWJvLCB1MzIgZG9tYWluKTsKPj4+IMKgIGludCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGFtZGdwdV9ibyAqKmJvX3B0cik7Cj4+PiAraW50IGFtZGdwdV9rZmRfYm9fY3JlYXRl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGFtZGdwdV9ibyAqKmJvX3B0cik7Cj4+PiDCoCBpbnQgYW1kZ3B1X2JvX2NyZWF0
ZV9yZXNlcnZlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgc2l6ZSwgaW50IGFsaWduLAo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGRvbWFpbiwgc3Ry
dWN0IGFtZGdwdV9ibyAqKmJvX3B0ciwKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYwo+Pj4gaW5kZXggN2IyZGI3NzlmMzEzLi5kMzZiMTkzMmRiNzggMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+Pj4gQEAgLTE2NCw3
ICsxNjQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92ZXJpZnlfYWNjZXNzKHN0cnVjdCAKPj4+IHR0
bV9idWZmZXJfb2JqZWN0ICpibywgc3RydWN0IGZpbGUgKmZpbHApCj4+PiDCoMKgwqDCoMKgwqAg
KiBEb24ndCB2ZXJpZnkgYWNjZXNzIGZvciBLRkQgQk9zLiBUaGV5IGRvbid0IGhhdmUgYSBHRU0K
Pj4+IMKgwqDCoMKgwqDCoCAqIG9iamVjdCBhc3NvY2lhdGVkIHdpdGggdGhlbS4KPj4+IMKgwqDC
oMKgwqDCoCAqLwo+Pj4gLcKgwqDCoCBpZiAoYWJvLT5rZmRfYm8pCj4+PiArwqDCoMKgIGlmIChh
Ym8tPmZsYWdzICYgQU1ER1BVX0dFTV9VU0VSX0tGRCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbShi
by0+dHRtKSkKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCAK
Pj4+IGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPj4+IGluZGV4IDhiODMyZjc0NThm
Mi4uZjcxNTdiZDhhMWYwIDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmgKPj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4+PiBAQCAtMTQy
LDYgKzE0MiwxMSBAQCBleHRlcm4gIkMiIHsKPj4+IMKgwqAgKi8KPj4+IMKgICNkZWZpbmUgQU1E
R1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEwqDCoMKgwqDCoMKgwqAgKDEgPDwgMTApCj4+PiDCoCAr
LyogRmxhZyB0aGF0IHRoZSBhbGxvY2F0aW5nIEJPJ3MgdXNlciBpcyBLRkQuIEl0IHNob3VsZCBu
ZXZlciBiZSAKPj4+IHVzZWQgYnkKPj4+ICsgKiB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucwo+Pj4g
KyAqLwo+Pj4gKyNkZWZpbmUgQU1ER1BVX0dFTV9VU0VSX0tGRMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKDEgPDwgMjApCj4+PiArCj4+PiDCoCBzdHJ1Y3QgZHJtX2FtZGdwdV9nZW1fY3JlYXRlX2lu
wqAgewo+Pj4gwqDCoMKgwqDCoCAvKiogdGhlIHJlcXVlc3RlZCBtZW1vcnkgc2l6ZSAqLwo+Pj4g
wqDCoMKgwqDCoCBfX3U2NCBib19zaXplOwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
