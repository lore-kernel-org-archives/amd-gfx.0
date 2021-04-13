Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D39C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1C5610CE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 09:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1C5610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 247E96E250;
	Tue, 13 Apr 2021 09:15:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD496E250
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 09:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkcm3C52dIvMu7j9Lvy3ooQ1aG2/oVSxqq/TcAssyez6Vp6PR0mcZK5LAfStK3ljBYAltDqey2GpQeFKqQpP6UBxQ5/RK7UNjyPMm+YnD3vC7qIYEbGvfBFb00rlmqAYytX6PgpBzxCsihSs/5yA8U7GYPmKSXrmk4IojWD3eCgNnJRE6sWlbVplJIaYwqh7j83CCohJuLeoxcWQ9/PLya9bAsVW5kdYAbjTkgsj/ADzHeCXC4c5q1p+LAFm7cbvUPFaC/YgsiXWbCf/214JLJHR40O8lSBrthftyR5YX9sfRN/EpSUVYiOjrY2WfRq3duFcQmiuR+7NOh9FrK7XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdgvdaUaLB36ZkObCQ78Ziw02+RAV42Ap9EZD8zGggM=;
 b=NJ5/jpR1ZGD75xuH5P5UcZ9RCmN+8TyO5zTd53ziW0fyZpaCk8SoPB4Wge2GEgxdGnuMl9zlDkNjA9Wur92iZCP4ZLDyBgrsYc/Ie3uko4jd9Y/h/LFCHhzkiCDWNdpQcyazkDKAChj2QunVt5Jjp4QzEtTDWFYSkQKP5BMDvAns/fwObbOLqB5Sc77R1dyvwDAitqtg3TPgtrS1+CGkxGaZODUaxLZRfzsIfjSLZ7QMkLI1MJoL5i2eBIq0+LqE0AMqb2AyGjZxJBK0R+dFfk0Q6HNLLxLwtkKThIo76IYY4EnFjprzBi3f1P6yijvyrF28s4qkKOC0MySoQe94cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdgvdaUaLB36ZkObCQ78Ziw02+RAV42Ap9EZD8zGggM=;
 b=Hks2PjF1eF6KmE+wfEeEsim/Vn/J6sWs9SyBPspgfFrs3/w1W8fLpKc+AgshFvmwfmQRB0VnGBiWIBibNFPmvwAiLFiuiFvjEKP1FeoNitBjSfYqNSvDZIWpZST3DQDeiTa6pBZBlf55fbdwmC9VXzN2/+95ycSpAbbpZDJasDk=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 09:15:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 09:15:01 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: "Li, Dennis" <Dennis.Li@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <DM5PR12MB25334B94CB060BD4C3EA4223ED4F9@DM5PR12MB2533.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <147f7eda-d3c7-9fbd-5cbd-73feda782b2b@amd.com>
Date: Tue, 13 Apr 2021 11:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DM5PR12MB25334B94CB060BD4C3EA4223ED4F9@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acbc:5f44:93b6:4587]
X-ClientProxiedBy: PR3PR09CA0020.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587]
 (2a02:908:1252:fb60:acbc:5f44:93b6:4587) by
 PR3PR09CA0020.eurprd09.prod.outlook.com (2603:10a6:102:b7::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 09:15:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37be031a-d949-4983-ff3f-08d8fe5c9e20
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2449FFEABEDA49E4E958852C834F9@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIQUf1WnuEtUQDmnILgi/4EE0Z2eLMWqJQjmNZQeKH4/LE11HbQO32HTBA0hMUlJKzl+YrxVxlj8MavZUZHl1muYd+/RMnepwsuQSLTinHlO5ymHROBAK8T8jxx/uioTPmWHieYahSvGrval506uhQQfi1sitUmj1ahOJ0wBqej3TxxACJvkkX2qc+ZkR+vcDm9XcOdtO01Ji7fmO5lQ+Zz8ojoT/TtL8BLGUYHWnTPD3bpgEjh6fRGP0ShsD9Ne+vtOIM2rpqyUHlSNbCBu3drA4+Rb4+JQ1ay19Lv0Ol7iNsQn1MTuhWDU22Briah0jok0WYvTmiUQ9HDX/k5SdMlKaUeVknJt4whR6BSCri/Vm6Uxd/50mRI7mvVxsl8YVWmdg1ECFk1cgJHaXQAEMyUO7iTAjvei1DxShIfezcJ5p4AjHaR/lO46OlZrygKx83EEJaFIrHfySJFplSPvyYJRgDIsiw9CdgNDZugY40T608LwoLTv1lqcF3O1QQK2jW2vkRyE9EHcYI6dOzRoi1fne9SWQ7pPrBd1bwXtmUsg1uI8nRLl2jucrFSgVTmeBKs9dee8erB7iztyHu6IUOsvlyubt0Pt9Sior2wfBHtCcckAOONts8vEsOzHwuiyMkZ7MG1Q1fKz8KLTCFYTWQzhrsjteQcnhSzF19blbWqu6bYSKFLegvNQwAMhRsXYebFizv7hJ5Tdf/LmmTCIQqKD61z9m2GLWunttwh77FmxoFeh68cv5PqN9araSfq/NLrqC8wxn/SnHDnVJi5MfdWWiesSjX2EcnWwJyps6FuA96paDwYwgG5x9zrMhNE6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(6666004)(36756003)(52116002)(966005)(478600001)(45080400002)(8676002)(38100700002)(921005)(16526019)(66946007)(316002)(186003)(83380400001)(86362001)(31696002)(53546011)(66574015)(2616005)(2906002)(66556008)(66476007)(31686004)(8936002)(110136005)(5660300002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEJ0RWl2WTdtRHNWWHp1U3BvZlpkMnhBclZZOXJGTFA0MHlKRk5sUHBIL2li?=
 =?utf-8?B?RXcxMGNyZTczYkRxMWRybklzNzcwUmg4WGNXYnJVR29ZVTZiODZURE9mc3Zn?=
 =?utf-8?B?RkhmcnZPV1pCNWpNcVJLc2s5VUxhalhvMjhycUluZ3pLK2l5Zm9keDNrVFIy?=
 =?utf-8?B?cFVOQmNkWlJKRUE4RWlsY1pCL0NtMTBkQW8xSnR5dE04R3RtUlVLWDZ2U3Bz?=
 =?utf-8?B?dGRpeVJTSTY1bXpPUGw0MnVRNncvc243MWg0bDF5TE5OR0J6RjVMaWV6NFdS?=
 =?utf-8?B?Wmc1dXNFQTByV0o2N0s3TEtDWXVXdit6eGoxbWorTlpaSm1RMmV1dHAzRHZm?=
 =?utf-8?B?bTFLb3JwV0FRVVcyZEJjMVlDWHVLaXdHT3p5VTdrNmYzNFB2QnYvSzJJTXZh?=
 =?utf-8?B?eDJzK1o5aTRCS0tLc2h4czhXR3RUY2twbHF6MTFDc1hKb0VUeXVCRlpnUzY3?=
 =?utf-8?B?L3loZGQ2TWFIcjVDTlNPWHluM0NVUC9tejh0am9MTUFhcndhY21heWRuY0Iz?=
 =?utf-8?B?QXQ5MzZFZFpxQlA3a0swdXJRWDNhZXFjcGZNcGFyU2lFMTVPUUQwNEhQKzU1?=
 =?utf-8?B?aVMvRzdoN3NCak5VMkZvd1Q3U01yZUVJVk00Qms0MnRTMmdzdm8xQWZOS2VD?=
 =?utf-8?B?dVJpNmF4QktscSt5ZkdZWnRnUWhIaDZJZ2pkSkJmZUlobmRUeVFYQi9xUFgr?=
 =?utf-8?B?RFVxVkNZYkZpb2lVWldOckVnWGt0SG5FU05RZEtpODMwNjAvWjlJOEgvYlU0?=
 =?utf-8?B?TjROd29sRUwwN0pJWk9WdmNUY2dTWEZ3MmRrV2U1MXRKVGlOd2E3M044clBx?=
 =?utf-8?B?OWc5OUZPcDcrVUhMc1FNQTVkdm9HMTBvengvbGR3VHNZZE4xZVJtOGovcCtp?=
 =?utf-8?B?T2FXbEZwSDFxem05U3dKUG1hWFpzdDUyd1F3Ti9oYnJWZDFQTkl4Z1Q2Tkhz?=
 =?utf-8?B?bi9aNG1LcHNtWFFCdENFb1FmMXRnY0licjdzYXgzZTVNUnNCNDJqd3E1RFlU?=
 =?utf-8?B?VkdhY04xZ1h5WEpKSEFqYnhBLzFyMmlMZ1dRYmI1bDNhNUwxM3ozRUN4bjJa?=
 =?utf-8?B?L1JlMUdRQldRYkNiSHlNMWpvMENqSnZ5K21WT3B0VWFmdkxBVlpaQ1c3SlF1?=
 =?utf-8?B?TlZHRENkcCtvRXZZSUl4M05jYVlKL2doQmRFbjcvLzd2ZFlZVnM0VXpEOGk3?=
 =?utf-8?B?ZlZmblRxcFFFa2Nyd3dzR3NMeUcwejh6aFRKRFhRR0dFcWJid3FDdHVjRjFj?=
 =?utf-8?B?QUx6UkRKTm8vSlU3dmhKS0xuLzdsTU42WmVCZVZMaURtQWpGQVQzRFR6NldZ?=
 =?utf-8?B?WXJ1NmF0LzVLYWxVcEZxYTZzS01oeDZYd0JPTEcvVFJQZU9hb2w3czQzM3JJ?=
 =?utf-8?B?M1kyRkk2SnZnbFNnWUxESDd2MUk5Z0k3T0h6S3JYY0NTR3RvaUtqQzg1dmh2?=
 =?utf-8?B?UFJ2ZmhtUFZMa1plOEpsU2dldzFXOUJYQ2ErREovNm91dHA4QWx2RFVZMWx6?=
 =?utf-8?B?QVIzUnR1VVlGVXNRaHR2U1ozQ3U2QW5ROXNEUU52THowSWJWOXFCR2NaOHla?=
 =?utf-8?B?SGF0TlJQdFlIc1JNMDRQcGZHMFY5bHRsSlRHRWFsZDc3WUJPWnZxRzlsQzF6?=
 =?utf-8?B?QkJKOE5EbW5DaXQ0TVhsMVF0bUVJWVA5cXBuWlJYVnJJN2s4aElGSGFEa2Mz?=
 =?utf-8?B?U21lc0V6YlFWN2U2Ulh0Rk1pdmZvKzFRTCtmQjJ6eWFQMWNEUm5SSkx4VjJr?=
 =?utf-8?B?Q3RORjdDVUZhVjl4RS84YWJHSzNEWllBQS9pUXl6UnJtTjlnVGx5RjE2SzU1?=
 =?utf-8?B?TjFTcDdkU3B0U2ZHTkVzbmwzN1A2dS9oaXRQVFhXUlh2TUtLRWtiOVQxaHR3?=
 =?utf-8?Q?jToN7QLEDSDjO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37be031a-d949-4983-ff3f-08d8fe5c9e20
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 09:15:01.8622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhq8C2B9PtAVbPSD0vKsqwh8lmIhNpA1vpZodh7g9sssZfG3KH8l7PjyS4Io2v9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgRGVubmlzLAoKeWVhaCwgdGhhdCBqdXN0IGhhcyB0aGUgc2FtZSBkb3duIHNpZGUgb2YgYSBs
b3Qgb2YgYWRkaXRpb25hbCBvdmVyaGVhZCAKYXMgdGhlIGlzX3NpZ25hbGVkIGNhbGxiYWNrLgoK
Qm91bmNpbmcgY2FjaGUgbGluZXMgb24gdGhlIENQVSBpc24ndCBmdW5ueSBhdCBhbGwuCgpDaHJp
c3RpYW4uCgpBbSAxMy4wNC4yMSB1bSAxMToxMyBzY2hyaWViIExpLCBEZW5uaXM6Cj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4gSGksIENo
cmlzdGlhbiBhbmQgQW5kcmV5LAo+ICAgICAgICBXZSBtYXliZSB0cnkgdG8gaW1wbGVtZW50ICJ3
YWl0IiBjYWxsYmFjayBmdW5jdGlvbiBvZiBkbWFfZmVuY2Vfb3BzLCB3aGVuIEdQVSByZXNldCBv
ciB1bnBsdWcgaGFwcGVuLCBtYWtlIHRoaXMgY2FsbGJhY2sgcmV0dXJuIC0gRU5PREVWLCB0byBu
b3RpZnkgdGhlIGNhbGxlciBkZXZpY2UgbG9zdC4KPgo+IAkgKiBNdXN0IHJldHVybiAtRVJFU1RB
UlRTWVMgaWYgdGhlIHdhaXQgaXMgaW50ciA9IHRydWUgYW5kIHRoZSB3YWl0IHdhcwo+IAkgKiBp
bnRlcnJ1cHRlZCwgYW5kIHJlbWFpbmluZyBqaWZmaWVzIGlmIGZlbmNlIGhhcyBzaWduYWxlZCwg
b3IgMCBpZiB3YWl0Cj4gCSAqIHRpbWVkIG91dC4gQ2FuIGFsc28gcmV0dXJuIG90aGVyIGVycm9y
IHZhbHVlcyBvbiBjdXN0b20gaW1wbGVtZW50YXRpb25zLAo+IAkgKiB3aGljaCBzaG91bGQgYmUg
dHJlYXRlZCBhcyBpZiB0aGUgZmVuY2UgaXMgc2lnbmFsZWQuIEZvciBleGFtcGxlIGEgaGFyZHdh
cmUKPiAJICogbG9ja3VwIGNvdWxkIGJlIHJlcG9ydGVkIGxpa2UgdGhhdC4KPiAJICoKPiAJICog
VGhpcyBjYWxsYmFjayBpcyBvcHRpb25hbC4KPiAJICovCj4gCXNpZ25lZCBsb25nICgqd2FpdCko
c3RydWN0IGRtYV9mZW5jZSAqZmVuY2UsCj4gCQkJICAgIGJvb2wgaW50ciwgc2lnbmVkIGxvbmcg
dGltZW91dCk7Cj4KPiBCZXN0IFJlZ2FyZHMKPiBEZW5uaXMgTGkKPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJr
ZW5AZ21haWwuY29tPgo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDEzLCAyMDIxIDM6MTAgUE0KPiBU
bzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPjsgS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5p
cy5MaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+OyBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gU3ViamVjdDogUmU6IFtQQVRD
SCAwLzRdIFJlZmluZSBHUFUgcmVjb3Zlcnkgc2VxdWVuY2UgdG8gZW5oYW5jZSBpdHMgc3RhYmls
aXR5Cj4KPiBBbSAxMi4wNC4yMSB1bSAyMjowMSBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+
PiBPbiAyMDIxLTA0LTEyIDM6MTggcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFt
IDEyLjA0LjIxIHVtIDIxOjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4gW1NOSVBd
Cj4+Pj4+PiBTbyB3aGF0J3MgdGhlIHJpZ2h0IGFwcHJvYWNoID8gSG93IHdlIGd1YXJhbnRlZSB0
aGF0IHdoZW4gcnVubmluZwo+Pj4+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0
aW9uIHdlIHdpbGwgc2lnbmFsIGFsbCB0aGUgSFcKPj4+Pj4+IGZlbmNlcyBhbmQgbm90IHJhY2lu
ZyBhZ2FpbnN0IHNvbWUgbW9yZSBmZW5jZXMgaW5zZXJ0aW9uIGludG8gdGhhdAo+Pj4+Pj4gYXJy
YXkgPwo+Pj4+Pj4KPj4+Pj4gV2VsbCBJIHdvdWxkIHN0aWxsIHNheSB0aGUgYmVzdCBhcHByb2Fj
aCB3b3VsZCBiZSB0byBpbnNlcnQgdGhpcwo+Pj4+PiBiZXR3ZWVuIHRoZSBmcm9udCBlbmQgYW5k
IHRoZSBiYWNrZW5kIGFuZCBub3QgcmVseSBvbiBzaWduYWxpbmcKPj4+Pj4gZmVuY2VzIHdoaWxl
IGhvbGRpbmcgdGhlIGRldmljZSBzcmN1Lgo+Pj4+Cj4+Pj4gTXkgcXVlc3Rpb24gaXMsIGV2ZW4g
bm93LCB3aGVuIHdlIHJ1bgo+Pj4+IGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1
X2ZlbmNlX3dhaXRfZW1wdHkgb3IKPj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFt
ZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbiwKPj4+PiB3aGF0IHRoZXJlIHByZXZl
bnRzIGEgcmFjZSB3aXRoIGFub3RoZXIgZmVuY2UgYmVpbmcgYXQgdGhlIHNhbWUgdGltZQo+Pj4+
IGVtaXR0ZWQgYW5kIGluc2VydGVkIGludG8gdGhlIGZlbmNlIGFycmF5ID8gTG9va3MgbGlrZSBu
b3RoaW5nLgo+Pj4+Cj4+PiBFYWNoIHJpbmcgY2FuIG9ubHkgYmUgdXNlZCBieSBvbmUgdGhyZWFk
IGF0IHRoZSBzYW1lIHRpbWUsIHRoaXMKPj4+IGluY2x1ZGVzIGVtaXR0aW5nIGZlbmNlcyBhcyB3
ZWxsIGFzIG90aGVyIHN0dWZmLgo+Pj4KPj4+IER1cmluZyBHUFUgcmVzZXQgd2UgbWFrZSBzdXJl
IG5vYm9keSB3cml0ZXMgdG8gdGhlIHJpbmdzIGJ5IHN0b3BwaW5nCj4+PiB0aGUgc2NoZWR1bGVy
IGFuZCB0YWtpbmcgdGhlIEdQVSByZXNldCBsb2NrIChzbyB0aGF0IG5vYm9keSBlbHNlIGNhbgo+
Pj4gc3RhcnQgdGhlIHNjaGVkdWxlciBhZ2FpbikuCj4+Cj4+IFdoYXQgYWJvdXQgZGlyZWN0IHN1
Ym1pc3Npb25zIG5vdCB0aHJvdWdoIHNjaGVkdWxlciAtCj4+IGFtZGdwdV9qb2Jfc3VibWl0X2Rp
cmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgcHJvdGVjdGVkLgo+IFRob3NlIG9ubHkgaGFw
cGVuIGR1cmluZyBzdGFydHVwIGFuZCBHUFUgcmVzZXQuCj4KPj4+Pj4gQlRXOiBDb3VsZCBpdCBi
ZSB0aGF0IHRoZSBkZXZpY2UgU1JDVSBwcm90ZWN0cyBtb3JlIHRoYW4gb25lIGRldmljZQo+Pj4+
PiBhbmQgd2UgZGVhZGxvY2sgYmVjYXVzZSBvZiB0aGlzPwo+Pj4+Cj4+Pj4gSSBoYXZlbid0IGFj
dHVhbGx5IGV4cGVyaWVuY2VkIGFueSBkZWFkbG9jayB1bnRpbCBub3cgYnV0LCB5ZXMsCj4+Pj4g
ZHJtX3VucGx1Z19zcmN1IGlzIGRlZmluZWQgYXMgc3RhdGljIGluIGRybV9kcnYuYyBhbmQgc28g
aW4gdGhlCj4+Pj4gcHJlc2VuY2XCoCBvZiBtdWx0aXBsZSBkZXZpY2VzIGZyb20gc2FtZSBvciBk
aWZmZXJlbnQgZHJpdmVycyB3ZSBpbgo+Pj4+IGZhY3QgYXJlIGRlcGVuZGVudCBvbiBhbGwgdGhl
aXIgY3JpdGljYWwgc2VjdGlvbnMgaSBndWVzcy4KPj4+Pgo+Pj4gU2hpdCwgeWVhaCB0aGUgZGV2
aWwgaXMgYSBzcXVpcnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIGFjdHVhbGx5Cj4+PiBuZWVk
IHRvIHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgdGhlIGk5MTUgZ3V5
cy4KPj4+Cj4+PiBJSVJDIHdlIGNvdWxkIGFjdHVhbGx5IGhhdmUgYW4gYW1kZ3B1IGRldmljZSBp
biBhIGRvY2tpbmcgc3RhdGlvbgo+Pj4gd2hpY2ggbmVlZHMgaG90cGx1ZyBhbmQgdGhlIGRyaXZl
ciBtaWdodCBkZXBlbmQgb24gd2FpdGluZyBmb3IgdGhlCj4+PiBpOTE1IGRyaXZlciBhcyB3ZWxs
Lgo+Pgo+PiBDYW4ndCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5wbHVnX3NyY3Ug
cGVyIGRybV9kZXZpY2UgPyBJCj4+IGRvbid0IHNlZSB3aHkgaXQgaGFzIHRvIGJlIGdsb2JhbCBh
bmQgbm90IHBlciBkZXZpY2UgdGhpbmcuCj4gSSdtIHJlYWxseSB3b25kZXJpbmcgdGhlIHNhbWUg
dGhpbmcgZm9yIHF1aXRlIGEgd2hpbGUgbm93Lgo+Cj4gQWRkaW5nIERhbmllbCBhcyB3ZWxsLCBt
YXliZSBoZSBrbm93cyB3aHkgdGhlIGRybV91bnBsdWdfc3JjdSBpcyBnbG9iYWwuCj4KPiBSZWdh
cmRzLAo+IENocmlzdGlhbi4KPgo+PiBBbmRyZXkKPj4KPj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+
Pj4gQW5kcmV5Cj4+Pj4KPj4+Pgo+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Cj4+Pj4+PiBBbmRyZXkK
Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4+
IENocmlzdGlhbi4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gIMKgwqDCoCAvKiBQYXN0IHRoaXMgcG9p
bnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIEhXIHJpbmcKPj4+Pj4+Pj4+PiBhbmQg
aGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNpZ25hbCBvbiBhbGwgdGhhdCBhcmUKPj4+
Pj4+Pj4+PiBjdXJyZW50bHkgdGhlcmUuCj4+Pj4+Pj4+Pj4gIMKgwqDCoMKgICogQW55IHN1YnNl
cXVlbnRseSBjcmVhdGVkwqAgSFcgZmVuY2VzIHdpbGwgYmUgcmV0dXJuZWQKPj4+Pj4+Pj4+PiBz
aWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUgcmlnaHQgYXdheQo+Pj4+Pj4+Pj4+ICDCoMKgwqDC
oCAqLwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gIMKgwqDCoCBmb3JfZWFjaF9yaW5nKGFkZXYpCj4+
Pj4+Pj4+Pj4gIMKgwqDCoCDCoMKgwqAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MocmluZykKPj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+ICDCoMKgwqAgZHJtX2Rldl91bnBsdWcoZGV2KTsKPj4+Pj4+Pj4+PiAg
wqDCoMKgIFN0b3Agc2NoZWR1bGVycwo+Pj4+Pj4+Pj4+ICDCoMKgwqAgY2FuY2VsX3N5bmMoYWxs
IHRpbWVycyBhbmQgcXVldWVkIHdvcmtzKTsKPj4+Pj4+Pj4+PiAgwqDCoMKgIGh3X2ZpbmkKPj4+
Pj4+Pj4+PiAgwqDCoMKgIHVubWFwX21taW8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IH0KPj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQWx0ZXJuYXRpdmVseSBncmFiYmluZyB0aGUgcmVz
ZXQgd3JpdGUgc2lkZSBhbmQgc3RvcHBpbmcKPj4+Pj4+Pj4+Pj4+Pj4+IGFuZCB0aGVuIHJlc3Rh
cnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCB3b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBJ
IGRpZG4ndCBnZXQgdGhlIGFib3ZlIGFuZCBJIGRvbid0IHNlZSB3aHkgSSBuZWVkIHRvIHJldXNl
Cj4+Pj4+Pj4+Pj4+Pj4+IHRoZSBHUFUgcmVzZXQgcndfbG9jay4gSSByZWx5IG9uIHRoZSBTUkNV
IHVucGx1ZyBmbGFnIGZvcgo+Pj4+Pj4+Pj4+Pj4+PiB1bnBsdWcuIEFsc28sIG5vdCBjbGVhciB0
byBtZSB3aHkgYXJlIHdlIGZvY3VzaW5nIG9uIHRoZQo+Pj4+Pj4+Pj4+Pj4+PiBzY2hlZHVsZXIg
dGhyZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUgSFcgZmVuY2VzCj4+Pj4+Pj4+Pj4+
Pj4+IHNob3VsZCBiZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSBsZWFkaW5nIHRvCj4+Pj4+Pj4+Pj4+
Pj4+IGFtZGdwdV9mZW5jZV9lbWl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8gYWNjb3VudCBzdWNo
IGFzLAo+Pj4+Pj4+Pj4+Pj4+PiBkaXJlY3QgSUIgc3VibWlzc2lvbnMsIFZNIGZsdXNoZXMgZS50
LmMKPj4+Pj4+Pj4+Pj4+PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0
IGxvY2sgYW55d2F5LCBjYXVzZQo+Pj4+Pj4+Pj4+Pj4+IGEgaG90cGx1ZyBjb3VsZCBydW4gYXQg
dGhlIHNhbWUgdGltZSBhcyBhIHJlc2V0Lgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IEZvciBn
b2luZyBteSB3YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZQo+Pj4+
Pj4+Pj4+Pj4gcmVzZXQgd3JpdGUgc2lkZSBsb2NrIGR1cmluZyBIVyBmZW5jZXMgc2lnbmFsbGlu
ZyBpbiBvcmRlcgo+Pj4+Pj4+Pj4+Pj4gdG8gcHJvdGVjdCBhZ2FpbnN0IHNjaGVkdWxlci9IVyBm
ZW5jZXMgZGV0YWNobWVudCBhbmQKPj4+Pj4+Pj4+Pj4+IHJlYXR0YWNobWVudCBkdXJpbmcgc2No
ZWR1bGVycyBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBnbwo+Pj4+Pj4+Pj4+Pj4gd2l0aCB5b3Vy
IGFwcHJvYWNowqAgdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIGFuZCBzY29waW5nCj4+Pj4+
Pj4+Pj4+PiBhbWRncHVfam9iX3RpbWVvdXQgd2l0aCBkcm1fZGV2X2VudGVyL2V4aXQgc2hvdWxk
IGJlIGVub3VnaAo+Pj4+Pj4+Pj4+Pj4gdG8gcHJldmVudCBhbnkgY29uY3VycmVudCBHUFUgcmVz
ZXRzIGR1cmluZyB1bnBsdWcuIEluIGZhY3QKPj4+Pj4+Pj4+Pj4+IEkgYWxyZWFkeSBkbyBpdCBh
bnl3YXkgLQo+Pj4+Pj4+Pj4+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzOiUyCj4+Pj4+Pj4+Pj4+PiBGJTJGY2dpdC5mcmVlZGVza3Rv
cC5vcmclMkZ+YWdyb2R6b3YlMkZsaW51eCUyRmNvbW1pdCUyRiUzRmgKPj4+Pj4+Pj4+Pj4+ICUz
RGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFj
Ywo+Pj4+Pj4+Pj4+Pj4gMzZiMSZhbXA7ZGF0YT0wNCU3QzAxJTdDRGVubmlzLkxpJTQwYW1kLmNv
bSU3Q2M3ZmM2Y2I1MDVjMzRhCj4+Pj4+Pj4+Pj4+PiBlZGZlNmQwOGQ4ZmU0YjM5NDclN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MKPj4+Pj4+Pj4+Pj4+IDAlN0M2Mzc1
Mzg5NDYzMjMxOTQxNTElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TAo+Pj4+
Pj4+Pj4+Pj4gakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlN0MxMDAwCj4+Pj4+Pj4+Pj4+PiAmYW1wO3NkYXRhPSUyRmUlMkJxSk5sY3VVakxIc0x2
ZkhDS3FlckslMkZmOGx6dWpxT0Jobk1CSVJQOEUKPj4+Pj4+Pj4+Pj4+ICUzRCZhbXA7cmVzZXJ2
ZWQ9MAo+Pj4+Pj4+Pj4+PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlh
bi4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
