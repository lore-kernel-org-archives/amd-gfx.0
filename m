Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E70D3E77D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 22:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D9B10E26F;
	Wed, 10 Dec 2025 22:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDsWV7Fz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5909F10E26F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 22:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuRVefgt61ztfxJzTDFHTTQfBGQ2Oa5vRHYn0QnQmxhPPD6exBXPqFpOc0ywS/yL2jA8g4KKBZtPFo41xNYUs0khB20KRg804gwbVnKaDJ20xX+L3EM+5pJ7VKY1hco2k7ZDr0eKhXS6MHXNbIuu0sUvkIjqmQk6ak8rV7jf1Fj5Bwt0d7HddEZIkI+oRzvKd9cSbeFDY59geMcruiz3N9gwGZASPTiS7Bh3foY4N8RAaDCepqoinMICLqvB8b6IZORA8HjkfaqcKM47u9BqiX8kxLlBNPgQ032+EaeTXLGXLf2qEr+d7p4ydrdgBO1lKD6SzhOtShyns5JAWIOm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV1I18MiCLDB8lcHKilPQE/nBCZ/ZF2prBnx6T96m3A=;
 b=l/azntgHGnLAt1/sRRp7uPaYVg/7o771C3e09wxNoQIO9kuBwzMYKikU74zaFZMWytv0h7UCJFA9eiDKDK8T2EXE6p7pHSHAptOHc59U+EpeNp0EKQ5QMT86tWBbYsGSch2lTN1Cdn7YUsquq7AxDFQfVuWsdMGhGPaQUk2+JmdeeG13AUDT8s77KIvuwiWqs8CkZhbCylGjsCFv/fMnhgYOQnWKyPoJcJY8HT+9oVZyOObbZ5/Gu3ELl4q4d/RWo4E2ff9AnxzCFFDsm0WieBZwK0Y9AATeCSOPQtUz2N6elpNGHviBXv4jJM08O0LCSVZpOEPJX/eVaqltu18M/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV1I18MiCLDB8lcHKilPQE/nBCZ/ZF2prBnx6T96m3A=;
 b=fDsWV7FzYuHGyxixriacgsLe3Txcl6C+G/UAlImlLODPGDnWNb09Jnec+t2+iC8UkeLEEAsbc+USJxAjMlb125h7qd9bCWAI2PktsSnMmYIqUssrm4PWIkaSPLdz8wCr3aOAauPNNsfHq+E5/x7cFOrJDd3YL4XLLlS3bIt5qSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 22:06:59 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 22:06:58 +0000
Message-ID: <be901b82-54fa-43cc-8a69-16388afc1cc9@amd.com>
Date: Wed, 10 Dec 2025 17:06:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: add AMDGPU_GEM_OP_OPEN_GLOBAL
To: amd-gfx@lists.freedesktop.org
References: <20251202151241.2212-1-christian.koenig@amd.com>
 <20251202151241.2212-2-christian.koenig@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <20251202151241.2212-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::18) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cee197-010d-4b09-17f2-08de38387024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGUrTHVhbi9leVBNbEl2dWw1aDIwUFdiZ0JveElWSnlEeUs3ekpxUDdPTFl0?=
 =?utf-8?B?anJlQ0hCK1A4Zyt3WjlmaXNwd2h1NjY3KzgxTEkzSzVhQ00rclladFZtaVZ1?=
 =?utf-8?B?aUMyRDhQSTFJOHNMOWRoVU8wS0N2YWhBVFdEMXNPV3JuQ0VhZVI4QTVRV2FF?=
 =?utf-8?B?NnkwVCtRNFlZb2VxSUErTjVYZ0xFS09NSW5BOVROWTUyN1JzTVgxT2tzWmVC?=
 =?utf-8?B?bktaNWtOOUtpV0ZxU3BrVldOZjJRalRCNldNWndhbWRBSHhONVBNeTU5MlNT?=
 =?utf-8?B?a252MEhpNERiMmFFeEsxZEpxS3NSaWd5VWJGL0lVQ0lVdmpmRlFxOWNZSURo?=
 =?utf-8?B?ZEFmREFQd2ZjODVaLzZvaHE2Mi9aNzRLQnhjNk9IdXlxT252WjNkemNma2Yx?=
 =?utf-8?B?dXdxT0dyeStvYVpTK29iUU1ramRLS0g1U0VldVh4M3d1MlI4NVgxUVBnZGE1?=
 =?utf-8?B?ZDg1UTFiZG1pZFRHdGZIOE52NlpIUVN5S3VMT1FTREJUY0VXTXhKUkd3Z3pp?=
 =?utf-8?B?QzUvK0ZwRjJoWENTZHB0UnYwVy9iS09SQ3ljUzM2aFdKUnpxVXg4dXRmQURN?=
 =?utf-8?B?L1JoOTNyOENCRllMZTlUTzlpSlJXQ2tmaFc3SkplVTFqRk03Tm1aQWVoWTJF?=
 =?utf-8?B?SDd4TitEYy9QUHlkMDVvd2F0WXpORUxab3k0WVNucnViV1BrR3FLUkRZK3Ru?=
 =?utf-8?B?RTgwZXBDSEcyU1ZiL2VuUEg5S2FGeHJlblNGYVBkbFp5TVJmMEpsYTgrdHhB?=
 =?utf-8?B?WkVicE80YW9DYjArb1lIaHA4c3JpdXRLcldweUsvcG0xOERXNGJBSzFGN1Fp?=
 =?utf-8?B?UVpzQll1Sll3cHVQV3hBT0ZMdlVUaFRub2RtZzlYSjE3eWFEdDlyNFU4anZ6?=
 =?utf-8?B?K1ByYkNZOURoQ2h4eDBpd21uSWhJV0FVcmZXOTZsbk51Y2VhVnNkV3E0T2lx?=
 =?utf-8?B?RTVoZElYWFpXT2hSNU81NGI3SnZpc2RCRXNpVzc2dFVtZFBKd3FXbGdudTMv?=
 =?utf-8?B?SU5kUXluM2xTd0IwdmFOTkRkOVNsRU1RaHpoK1dma3c2T0wzZC9kQXo1MnYw?=
 =?utf-8?B?K1NOL0g3U1ZRU1JFdnZlbFY0cTRHMko5N0xDMWttNnNPZFRZYzVhM0F1OUtM?=
 =?utf-8?B?akxtdnNKQlo1Q20wWlNCRlNoVGtnRHpFK1FLWmVEbVNBSk16bUNSNjZvSkZj?=
 =?utf-8?B?SGs4WkFWUThiYVY1QzRJcmEzaW1qOC9zK21aTDgwZWlFYVlOM0NJZnlOaDRB?=
 =?utf-8?B?L1NsVE9pQUozQlBGZ2MrREl1aEkvMmlVN050aWhvMWRwUzllU0RiZnNVRlJC?=
 =?utf-8?B?Uk9DKzZ3cE9IL0U0YkQ0UjJBN1RkMmFUc0hKOUs2M2c4cXZ2VkRvTU03RDh3?=
 =?utf-8?B?U3h2Z1hZTEQ3emxiVE9aYmxXZ01nVzVmSlFsTDdWbmQzKzBYZEd2VVdNQ2E4?=
 =?utf-8?B?UTNNLzlxc25MenlWQ3pqWDJ5Y0h2eXorNEFCNERwcFo5M0dDd1g2eHhoa3g5?=
 =?utf-8?B?V01GNlVxRVowOWFCcGw1eFFONUdGMkFza3FCMmUxMXJRekdpK3VTSU1oRXVE?=
 =?utf-8?B?V3dDbXYwZFBqZTFqU3N0M0l4TzYvU1FUY0tDb0JhV3JYTlJDend2Mnp4dXFR?=
 =?utf-8?B?bDZ3a1lCQ09vWmlScEJuSmFVZ2NsUmQwZ1RXci9DZmF0VjhZZnhjZEJKdFBa?=
 =?utf-8?B?R29ILzBzSm9zU3k3UktDci9Xdk42S3NDUGt2WGhnT0M3SXZUODBRVzRTV2Iv?=
 =?utf-8?B?V1FyZk80K3FSRWhydW5RRjNhZlRQOW91am84TjJGQ0xMOHdOMmZObEVKTllZ?=
 =?utf-8?B?UUJqdmYrWlBTZldjQXZmS1orcWx0K2ZJMDdiOUFxb1dtVlBMUTU0WDlyOFFO?=
 =?utf-8?B?Rk0ybDFFS0I3NU1wNWdaejFsQXdtUXQxd3ljM29pOE5CTHRaM2lRUjV0TUVU?=
 =?utf-8?Q?7dYjFiDaAaGhVaiM3K8d1XYnMQ4Vx0kD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3MyTWRHUnhJYXc4dnNuNytNR2w3cWlVZm8xbmtpOThLV2NUdWUzUDl4amls?=
 =?utf-8?B?dVNDbjI2cnlkN1QwWGFtTllkWFErREdqWjc3bXltZ3ZMZkN2SzhRRXhXQ0xS?=
 =?utf-8?B?YlJjS2oxb09PNXl1cTBzVW5aWGIwT2hQTHdZYkcvYkk3VW1JTWJrdWxHU0lL?=
 =?utf-8?B?Q2E2STZCeFVUeTdpS1pWaUZra3Q5NGpGaGY3L1N3M3JMQ2pBdFROemFOZlFz?=
 =?utf-8?B?VDZSYnBYejNUWUp2M3J3emxEVkZxNFI0WDVyZEJuWURkT2cwY0Z6cXdwdWdk?=
 =?utf-8?B?Qkx0aXAwbFQ3c2M5VnpYZzlsci90TE5QOG5EbVJqOU04R256M0JxUExDN2Nu?=
 =?utf-8?B?bkU0S1NVd1VHL3JNbWpWQ2pwTXhpemQ4Qmw3Nk9LU25pRzNZWkxFeUlFM2Q1?=
 =?utf-8?B?a0g1U1VyWnkrKzZzWW9HcmRPMFVJaHNad1VNQzlmNDlqOFN2dmJKR1ZnUk5H?=
 =?utf-8?B?VVRQYXVmbFR4TEoxdyt1bCs2eTVtbC9zZlF2bjlROFRPK2h6aEtjNGw1Ynkv?=
 =?utf-8?B?Mk01NjF3MzRVRFdLU1RDbWxWVGlCK29aRHNMMFpSN1MvK005WlMxLzRTMlkr?=
 =?utf-8?B?ak1nVHlDVmhMa0J0Z1ZuRlB5N2Q3SjZHWXlCQ0dKbTRqQ1JNNWhic3JpQXBv?=
 =?utf-8?B?Y2o0RkFwMCtnYW5yS2Y0VDMyL3E1UUYxd2N4THkyT0c5S1Y3cTRFSCtGQklk?=
 =?utf-8?B?RTkwU0YrcTg2NXR2akl5bTZDQWZFSXpwcXo3S1E2U0V4WWVzNFZiaVlCUnky?=
 =?utf-8?B?V1VIbkVGYTdYM3IvODl3ZVpiemJDeTZrZUVPUzU3MXFKOEsxWFc2ZkJUNnJZ?=
 =?utf-8?B?UmlVeWpsY2paSUZOd2l1TFlhc0srNitYQlhrSUlrL3IweFN4VGZ6WVZuVWow?=
 =?utf-8?B?QlVzZm0wYkppdGV6VEdQTGMrcHVqb1RGdFJwNUYreFBrQ1pUOWowUjFjOEN1?=
 =?utf-8?B?VE1kNHJ3d2RrbEdubVI0TS9zbjk0VTIxTU1LbVhlNjdFUHZWWGhqM2ozMHRk?=
 =?utf-8?B?YTdGYTFUNDlJTWRiSzZidFBnNTdZS2szWlRqQXJPcDlLREZzU0xwakU4S1Jv?=
 =?utf-8?B?Z1dwVDJXN1VsQzBrd2pLNTdQbFpRbm1jaDdzSW1tdHBCRWh5V09aZlh6ZEJE?=
 =?utf-8?B?dVIvdjh1cGwwMmg5U0RRMXVublhBd3FKNVQrVEZIUEFQaG9aRzJ2NlRMVUMz?=
 =?utf-8?B?NGZXakxaODhzVi8zQkZId1d6bVhtSHl3OVpUTVR6MzdKRHhmTHcySDVLcWI5?=
 =?utf-8?B?bzNRdTFna0JQdnpXdndyTjR6Q08yQXE4MFVUcGphaVF3cVl2bkh2TG1oZTZH?=
 =?utf-8?B?bjJSZVcwVjNCdy9TakZlUFBMQ0JkdFhpeXJFUmhjbENBSnJCL1hZMG5FZTk0?=
 =?utf-8?B?NFNHcWNFR1RhZXM4TE00NUlBTFVwcTEyK0xRVld5TUhjMm5uSTkyd3MzTzZQ?=
 =?utf-8?B?emFNcWNUT2Q0TGdYTjJSUTdkSkFwUUZ0Ni9jbXBjL05FU2lWK3BjbURIamFV?=
 =?utf-8?B?MlBqTm5GSllnWGhmcWFUanZ2bk9aVkQ0ckRJOUFlRFp5d2NqcXVWUWRhWWNT?=
 =?utf-8?B?YU1jUHMxTkRmdDhiUk52ME96VWIyTkVuVmVwenc2TENNSVE3bitoaWxyZ1Fu?=
 =?utf-8?B?akFJcUNvMjV3bnFINUdYWHNqVU1oZk1ndERraGlreFFKQ0VxMlM2ZGxBODls?=
 =?utf-8?B?elFWVnYrQ0QzNEdJVnJib0diS1JVQzF1VkczaXA3RTZRSlhmZ3hxbVYvNEVU?=
 =?utf-8?B?RFNtaTl3RGg3QUdRWDZJdVZvUkI3aDg4NEJzUndMZTltYTNZSmFtWlMyYlFz?=
 =?utf-8?B?VW1iUGkxWlRiaGc2ekhDTExGKzBsUk1ldnJjZkh5WU56VXl2SWw5YzY3a0Jl?=
 =?utf-8?B?amQzTkIvc3VaS2JKM1R6OHJQRlpZekFmZkZOa01GV1pycjZsUjlGRldmU0Mw?=
 =?utf-8?B?eFZCdzRtMkhjTHZ5ZmpOaWNXVytkODJvTkJYcmNwSzZyYXlCZzRINERtWGw4?=
 =?utf-8?B?V1E1aWZuSjgvakdDZHN0Qk1NNStJTDBPMTBpUEJ0ZllBWjZEc1F4WDl5YmJt?=
 =?utf-8?B?VXRrTEpzcTQvYk1TUi9Qbm9ncy9idU91QTRuOU01RWJrMks1ZzVKSE94QkJK?=
 =?utf-8?Q?d6Hqg1NU0CPOI5B+BEMFtyV0j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cee197-010d-4b09-17f2-08de38387024
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 22:06:58.6938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjSgFu4vjqLPdOhAhZ8/9K1fVHR3XE8TWdFWzvBFwjlQPehKZpeoeaiaR+WfrJU1HtEWX5XMOFBicacOnZfnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/2/2025 10:12 AM, Christian König wrote:
> Instead of abusing the create IOCTL to open global BO add a new
> AMDGPU_GEM_OP_OPEN_GLOBAL functionality.
>
> The new AMDGPU_GEM_OP_OPEN_GLOBAL functionality expects an enum which tells
> it which global BO to open and copies the information about the BO to
> userspace similar to the AMDGPU_GEM_OP_GET_GEM_CREATE_INFO operation.
>
> The advantage is that we don't start overloading the create IOCTL with
> tons of special cases and opening the global BOs doesn't requires knowing
> the exact size and parameters of it in userspace any more.
>
> Heavily WIP and only compile tested.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 26 ++++++++++++++++++++-----
>   include/uapi/drm/amdgpu_drm.h           |  5 ++++-
>   2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 9b81a6677f90..9e9b94dcb699 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -968,22 +968,34 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   			struct drm_file *filp)
>   {
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct drm_amdgpu_gem_op *args = data;
>   	struct drm_gem_object *gobj;
>   	struct amdgpu_vm_bo_base *base;
>   	struct amdgpu_bo *robj;
>   	struct drm_exec exec;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	int r;
>   
>   	if (args->padding)
>   		return -EINVAL;
>   
> -	gobj = drm_gem_object_lookup(filp, args->handle);
> -	if (!gobj)
> -		return -ENOENT;
> +	if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL) {
> +		switch (args->handle) {
> +		case AMDGPU_GEM_GLOBAL_MMIO_REMAP:
> +			robj = drm_to_adev(dev)->rmmio_remap.bo;

rmmio_remap.bo could be null - so robj should be checked and return error instead.

David

> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		gobj = &robj->tbo.base;
> +		drm_gem_object_get(gobj);
> +	} else {
> +		gobj = drm_gem_object_lookup(filp, args->handle);
> +		if (!gobj)
> +			return -ENOENT;
>   
> -	robj = gem_to_amdgpu_bo(gobj);
> +		robj = gem_to_amdgpu_bo(gobj);
> +	}
>   
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
>   			  DRM_EXEC_IGNORE_DUPLICATES, 0);
> @@ -1002,6 +1014,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	switch (args->op) {
> +	case AMDGPU_GEM_OP_OPEN_GLOBAL:
>   	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
>   		struct drm_amdgpu_gem_create_in info;
>   		void __user *out = u64_to_user_ptr(args->value);
> @@ -1096,6 +1109,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   		r = -EINVAL;
>   	}
>   
> +	if (!r && args->op == AMDGPU_GEM_OP_OPEN_GLOBAL)
> +		r = drm_gem_handle_create(filp, gobj, &args->handle);
> +
>   	drm_gem_object_put(gobj);
>   	return r;
>   out_exec:
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c1336ed4ff75..6927c864a6d1 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -807,6 +807,9 @@ union drm_amdgpu_wait_fences {
>   #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
>   #define AMDGPU_GEM_OP_SET_PLACEMENT		1
>   #define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
> +#define AMDGPU_GEM_OP_OPEN_GLOBAL		3
> +
> +#define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
>   
>   struct drm_amdgpu_gem_vm_entry {
>   	/* Start of mapping (in bytes) */
> @@ -824,7 +827,7 @@ struct drm_amdgpu_gem_vm_entry {
>   
>   /* Sets or returns a value associated with a buffer. */
>   struct drm_amdgpu_gem_op {
> -	/** GEM object handle */
> +	/** GEM object handle or AMDGPU_GEM_GLOBAL_* */
>   	__u32	handle;
>   	/** AMDGPU_GEM_OP_* */
>   	__u32	op;

