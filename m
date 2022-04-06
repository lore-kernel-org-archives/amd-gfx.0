Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10EFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 14:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F2B10E17F;
	Wed,  6 Apr 2022 14:13:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D9B89C13
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 14:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VksZvH7bJGfijuOSQj3VyXNA2HR2txMmno7L1Dqdsq3BKGDCPtROVKCwDQzickp2Lv/3C7vRSyq/JLnKr2ymILZFlM+v4aI0rRdhbi79MrvHRd5b6txIowiNIELEyE0gk97aPBObTeOq9SsGjwm+W4T40TVum1agz2PILYGG+wFGdCKILnJEBs02KQlFCk9Eu98vielcLZqrZiZZK5yxlhfHglT05RlTmZ0Kd7w0xmi8bLlHFEvfMJx38qxmeL0C/wa31IZ9HsJLwlsW/ZvdIxs2e0mxQWurjajuhOX6ecjon4J1t+egMz4m/hoqBSwAsoj5PSHmw2WkMfWzfclepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86M1qoK6y0u+aMIEcW/Eg8MBgt5TmXFkgWLbOqn/h+g=;
 b=FqqflxCNWFTgCcfECFSE+trAc1oSWBerM/FM6sO5Xz17OtzaNwJ39lf1QoDSYRJSchVpiy6kU+MfiiPRXZnTm70oB1swUB1w8H4Z84EeiMVNARiExYq8WJUPkgZLnpoeCCwh7CV5aLG0t72+VtgjRwsYzhDH3rzevx1eUzVjnhVoNjz54uqU6ummAKBFfW3BR51F8WMh7c0b6Q1xL4e4BU/ZdOUjygVN3CoA7KFnrTbwYbkRocc5ERqIUMecf3JNOxdluatwvORWKtGZ6XWVK8r+oZHW4BWyW/tYy+z1iVJv4eRGj7HnJioephrkGsXX3f3UAFv4xOxSvtMpuUUbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86M1qoK6y0u+aMIEcW/Eg8MBgt5TmXFkgWLbOqn/h+g=;
 b=0X8o4gMBxjFaYPc8QXp5fxJG3CQbjbVA6A1WISn9dQmKnudPULCp55Jrv3EcxIKNl4DpoxULI+GBCvZaX3JPzzrB9i+KUQU+vmi4b45yjiA4EAjygJCmJLyX68aDYG0BsiFP75H/RLGE/h+MxQcPrjRQS0qJKbpSYNTgf3JHdhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 14:13:14 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 14:13:14 +0000
Message-ID: <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
Date: Wed, 6 Apr 2022 10:13:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Code Review Request for AMDGPU Hotplug Support
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cdb4494-671f-4bb9-fc4f-08da17d796f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3277DE357C9545654C047112EAE79@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2VXCDZi0uYUFMm07lxd78hXgSddh0G3VJVJL6Hh9CBI2bxWIBisyqC1ijmWgL9p89HxFk45Fy9MUfNdZS/kIfz+kXN8+7rmDUwkgkuFst0AuCduXFPCV3pU1D0GIVKD4lKoKeA8xTJTUBaLCuX0HgItF/cQU0G7fC55n67qhnCSw4NjpnBQ3UtS1Mw9sP32WtAvvzRlVSm7UbajvrO3flE9XVUEttjrr2Nzt5+bWzB0c3LFSoPWge8E1jM4YuzQ5684wjbtSkTz2XA8wYqn9eysncESqPTXP6FfZVNfkO+kDxakCY0qaod1ZMeV0QU6LG5I7wCA0TspPRj8d1k+gnihRwGc3rZB3w6vPoS6fnE2VlSblfrov3vPAmE9/XCwq3BaRa9pDG2S4hjkLoT2Yuy83vr2XI3rjNSnqEN6L97Fc6/V+Qz5TA+3o5v5J7Z3n/C/aogTdvvYjj4mUXuFj2m9yku+TaQF0x0y4OW0xFbTziAnvylwskZPbvZmV8LxHpr7rtAdPFcCO7FTAvZZscZ4A8vLAaFwpoDAcMgC6YiHfvIgQZpcl+V7//ZovtO7A3wQejMFnrUHkuQmplK97NoyO2oqzXMx4sf48hN3BY6cAfTyciqUSFAp1EJP/HmGl7CQdx9gkGOK7hIJvMCGaAZlNDyVJ2+gBT9LGrf5B+EsgU8mfY8T9Y8whKT5/4Wst1TC1RMLBl/Df/qD36SO8bLPpAX/jZVkORDNNWAwHcDPG/Hmn6FXHu/hYyXJb30epsTSgrAJg3Td5OZNrgu29jfDmwTciSk2WSaDjXfA4sW6ZXpBH3WrFkM8Xpm7tHxzJOdiyzBbo3jWsBewjpWjrdONyV1fJnAKnxTnxqqFS14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6486002)(6512007)(83380400001)(2616005)(966005)(186003)(86362001)(110136005)(45080400002)(508600001)(6506007)(53546011)(4326008)(66556008)(16799955002)(2906002)(5660300002)(38100700002)(36756003)(31686004)(31696002)(8936002)(44832011)(66476007)(316002)(8676002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZHdWUxWkRGUnRJM3FsZzNQZFlET29VOUxxNExMOWpVWVcxaGlxZVl1YjMw?=
 =?utf-8?B?bXNWQXBqRHc0RHc1NWJTTkMwWEtHYzM0M290NEdPNGJCanFmWVdFUXN1N1FD?=
 =?utf-8?B?L2Q3VnM5d09pVUFJMm9RVnQwLzd2WjBmaCtvVVVFenFZcmkrQngwa0VUOG9H?=
 =?utf-8?B?UjM0azY0VmREM210bFBkZ1FPZ2V0TVJUTnFXMnAxWHhZYk9VL1R5Znd2dGxz?=
 =?utf-8?B?cE9HQk9wOVJkZStLekt2a3VDTnZUbGJVcEdqTnVaSXBRLzJhQnlPQnRReTZh?=
 =?utf-8?B?Z0pCakZpZ0tSVWZtUFZjTHJTSHE2cHdiOGNDem9vWXpLR0NHUWpWZ20yUTB4?=
 =?utf-8?B?ak0xWHcrWk9WL1BoZDdISzdRM3NRUmE2TFlZeFdMZSs5MHp5RGdQd2d3SnRL?=
 =?utf-8?B?U2p5NlRFVDljaDg0ZlUrVlZOTnEyeUlsV2E1SlNlbGFaelQwa0NwNytqUkdl?=
 =?utf-8?B?RHpISWp3T2ZlK0NSdytQT2xqYVhaRk53UkJkbGJtakF0d1pJeXpHaFlJbnlZ?=
 =?utf-8?B?RHlBalQrMU1ncDZTcVVTMGo2SkFhelBPWXVMWTZMZmlMNmZPT093T3gzcVdv?=
 =?utf-8?B?UXB3SkpzUnd2MERjZHkxY3dtYWR3YXJVSjFZVWJyVWsrM041V3NDSjlOdWNX?=
 =?utf-8?B?Rzd0aUFZVlhzbFcyVkkzSHVoQ0hsWXBwSUxqcmdhNlJBcTlJakkrQjQ1eDhn?=
 =?utf-8?B?ZmZZbFdBNmlpZm4wMndEOG1hQkpkTUhteUFMemduT2k5MW1qVTJHR3p0SzFi?=
 =?utf-8?B?TWp4WlNFb2NyUUd3RTlnZlBES0dlVGU5Ty9EdlJqc1JWMEhSUU41V3JxZDV5?=
 =?utf-8?B?a2VvVHhpV3lzWnJKVnBxVmo2cUUwWXd5aXdldThlcEVncDRzVWY3aHlnYkVV?=
 =?utf-8?B?YmVpdldqdWwrUkxyNnRJWE9Nck9xcVBzOFg2b1BSYndFcmh0RTlmdnRWV1Az?=
 =?utf-8?B?cFM3cjZqNUFXOG9wQzFVc0tzbGZ3Z3VXam9UVDJUOWNDQi9Qd3pLRGdQT3pn?=
 =?utf-8?B?K2VMaFFWNU4xS0xvb09EaHFsd25iWFIzMndjWHhFaXhrYW1RK1F4cnRKS3Q5?=
 =?utf-8?B?SERwKy9SQ1doVm05Zk1DQ0VmaHpJdGdST3FEbVJHV3pUS0pkdlJLYlcwRjBU?=
 =?utf-8?B?TmJQbW5RKzZISFp5WUhZWVJmd2FmU2dxVzRlRnJMTUNma1pjVno2TzNwZ2lO?=
 =?utf-8?B?bHlmMHlCVXdWdjlVZkdwQlNNaHhEaVJTMUFDT2dYa1JndEhVbE0zZGpHNlpK?=
 =?utf-8?B?cDkzeWd5bjFCbC96MFJURHkvZXpWRTNISFBnVSs5ZS84b0FnQUFUbXdzSllF?=
 =?utf-8?B?RUxwaFR6Sk1CdUdxV0FTczFZTUFRZHZjbEp5cEdCazlLSTZDNXZscld2Qk5h?=
 =?utf-8?B?Y1RIN2hQREMydVpLRkczNTM5SFRDbENXKysxaUVMREFPUXp5OEpzQ0MxUkl5?=
 =?utf-8?B?YUhFVFhkWnBoeUtOcmhPN0U1bFRpWk84UFgwdVNqNGdRakZrKzM0TUR2R0k1?=
 =?utf-8?B?K2l0ckdjbjFLV0VNb0FqbjZwUVZYWVBnNDRVZzcvUVN1QlpwUkczQXdaVUl6?=
 =?utf-8?B?SzU5OE9zWXdVd0FKR3BYVXVrVXlPN3hNZGk4eE52N0tkNVZkSzhYbHlxc0JR?=
 =?utf-8?B?S1dpUW82NlJZMCtRWVZZZG9iSTJFWDlxRW02S05Manc4YTBKanl4T0tYRzZY?=
 =?utf-8?B?NG90UitYUzY5b09vbSsyNUZkOWc0OXpPejM4NUpSVVhjN2docXVTS1dPMXFs?=
 =?utf-8?B?TFdjV1pDdW1Zd1NyVkxQNGJxandxYUp6TlBGTUdTeGFQWDBXNklPR2ZzWmhP?=
 =?utf-8?B?ZWJTdUFma09kQ0NSTE9rM2xubGdsZ2lCVlRiWkgyRnBUTzJJWElTeGprU1hp?=
 =?utf-8?B?Ulh6a1JvYjR0M1cwWFQ2dHNpbTRFWlFTdlUxeTl5U3A0YUlJQjM3VUF6elR2?=
 =?utf-8?B?OE9XUmVMSklrSWxKK2Y2RG9kZEUwWjRnSVdSK2RTM3ZaNzBGUUlsMUNFMkxh?=
 =?utf-8?B?UHM0U0tXY0grTysyZE9KdEh2cE5QYllWMElZbHBFeTc1NG5QcGMxM3N6NVBU?=
 =?utf-8?B?VUZWL1VnR1lZY2pWK3JqaTJnMnNVODQyWGJPTXBEWW1sUnFZczNzZm5GMk5C?=
 =?utf-8?B?a2dmdm5PU2pUM21WVXZveDl3YmpmRWFidm1KK3kwUGZYUDQvejlZSVJjU3Fn?=
 =?utf-8?B?QUN5bUI5S2IyR05FS1dOeE8wdHFhWUIzV25laU81d2UvaGJoZU1hc1hEeFE0?=
 =?utf-8?B?Nkt5dUxNUlZUdHAxM1FBR2lMNHBjTCtoZWtWK3k5N2M3OC9wcmNQNy8wRDBv?=
 =?utf-8?B?STB1V1JvNEh4cFlwMGhqc1d0d0ZEYUMzK2tLd1gvNFJFSEo1bjB3bHlHaVRM?=
 =?utf-8?Q?OMPhUUw5stFnBmpGfz7vqPOvZcrDlD4v3RQO+3OZTp1An?=
X-MS-Exchange-AntiSpam-MessageData-1: TbhboUa9i1ArDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdb4494-671f-4bb9-fc4f-08da17d796f5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 14:13:14.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVXnQcqTvzgZSsNn9K7qv0u9dwaPfSB0oynDKgtntAeqFBoboF8EZFWJCjs4sNtacjdYRsmOAENPXzSVBUm4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like you are using 5.13 kernel for this work, FYI we added
hot plug support for the graphic stack in 5.14 kernel (see 
https://www.phoronix.com/scan.php?page=news_item&px=Linux-5.14-AMDGPU-Hot-Unplug) 


I am not sure about the code part since it all touches KFD driver (KFD 
team can comment on that) - but I was just wondering if you try 5.14 
kernel would things just work for you out of the box ?

Andrey

On 2022-04-05 22:45, Shuotao Xu wrote:
> Dear AMD Colleagues,
> 
> We are from Microsoft Research, and are working on GPU disaggregation 
> technology.
> 
> We have created a new pull requestAdd PCIe hotplug support for amdgpu by 
> xushuotao · Pull Request #131 · RadeonOpenCompute/ROCK-Kernel-Driver 
> (github.com) 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C4e8dc7d4feb84b19edf208da17a54fac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848296133682200%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=GE4XHNeLaWfbuoJbM4a1ecH8KKJbKbd2mRCnFinn7eI%3D&reserved=0>in 
> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
> 
> We believe the support of hot-plug of GPU devices can open doors for 
> many advanced applications in data center in the next few years, and we 
> would like to have some reviewers on this PR so we can continue further 
> technical discussions around this feature.
> 
> Would you please help review this PR?
> 
> Thank you very much!
> 
> Best regards,
> 
> Shuotao Xu
> 
