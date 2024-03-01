Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBDBC5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 15:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251AE10E96E;
	Fri,  1 Mar 2024 15:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="edV8rsfn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5674C10E96E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 15:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B52Tjt6AFLZPCC21kOSFzjzqZ/mctSw0DIEmOh9hzMAgrz6u//QzhwhIMWC/LNGaevgDfr0s6ORywXeB5S52kpR+BvF+vpZpSKPmp642F52DoRfnrWDFMCQi5N123L0ey4/GWaAxPNkl58hAovUmBZst0knITEt5Sz+rtlVY+HQU2qybd2MUAA2aQCEd3fAmJhVFrglwTPA8HoWS37R90Pb/FjfSHsvTfDyUAjYpQVuiOAHMickUk+czAIVNQy+XvXMcYn7LkAKsJCW+MSmBStjeqDBXNdhf5vPnmvAGYZVxpHg1PjVy+Cs4iQyD1NEhi+fKd/zgyziSX7JQp3icNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6k4IsDhavqVYZxXE5Bc7yUoTGxQlJevWSKze/XedJHc=;
 b=caT4W5UfMF8vj6Jimo1zNdBTkZS0bsnan9eUOktyErix/t6x/v0tO6DiFOd0GnsPsCQe1m/SkR6uHDNiLIdE1oheVNtUaOzbxuzbYQb4ANySd8rUtYyt4iIj1o7ySKFmVJpQvNuPO9tEoyt5P1mo8/gbCeAiqcxFNE2/HPZlXYi9/5NOkF74x6R9LL0CDzrjhBV9Rq0LVTJ6qFnxBsE5vsasTMr7kYavc7FQREiUnqDPxs4KgJ9smWH4pVN5qtXXJnRhWeKaq8U4HByjQS7HSiW2PL8ThPiqq8p7Ie/8Obzqdp1i1/GL//zZ+GVs2wtYgZnNSaiDfRd6htuIiA28bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6k4IsDhavqVYZxXE5Bc7yUoTGxQlJevWSKze/XedJHc=;
 b=edV8rsfnH+UJatapUsLtFO76tPI02YK9/qZ/F3nVkl4cuGMH5c9x+GUgX9zW0WImCU3TIXd2kPNPS3eOKB8d3iiFL7a7GrdLBwRswr1EZY/AUnfvtBSMUEWSg92kGEZKSt+BlHhL41FPFcMdrvYhfv/xvlq8BvsliqIRELukXbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:38:13 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::7309:cd67:8037:b9a9]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::7309:cd67:8037:b9a9%3]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:38:12 +0000
Message-ID: <d0ed1f66-57dc-99f9-221a-59fc3cce3850@amd.com>
Date: Fri, 1 Mar 2024 09:38:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
References: <20240229084513.86529-1-jesse.zhang@amd.com>
 <CY8PR12MB7435E75B6866EDFAA8B2B7CA855F2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DM4PR12MB51525B4157A21971D747743DE35E2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CY8PR12MB7435DFBB213C5B3284F59227855E2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <CY8PR12MB7435DFBB213C5B3284F59227855E2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 18800938-0568-4797-0941-08dc3a059ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB+Jym9Lw3oAfpqT3sHsFnqbPkKUNmGC7D4bZ6/VtLNqzj+hjoPkSJ7YYVXTurQTB2CeruPOBIQTXjz4qpwPjPPcNah+AaPxi3t6SmVhbM3TMeMbbsY5RxF0+X+7l4OJr/ZgmbpsJFsXwXPMl6RwtKnNEtOXqgTe5St2Kl/MmQyCRWRBkUyAN9eX0pZJ6ASLyzIxyoHscozuBEwe2Y85l9hIwh6X18WtY/YgI+JZWaCJPGlqe40TQmzfPQqpbN336X4xU9iSYlUytGh8P+AeIHbdB4AetPj8MyLBFfjdv76/2NnbcTGOmG4QkA70j5PrFxJAYKvg0oH+veNpVfbc/CrfIBReVQ+lVE2JaFbCKJQTME/RBTL64MogCfrQyy1L2F7gP6W95/GT8EcYuJFCJZ+QA50ttqi1VBi4XGmbx0ZSYgBmh94sTXB7KvN5JBHMilTz/TRA/WIXski0y4lZspVnXn2cNURO2OZ7G59jfW5GTSzFVLwGozAgEZx5xZ9DO0EFuWfOyaNd3Ks/J18ANxv6MpviladPPaVL0VWjvxpaEjIdUnuSsTVT6An9iKT+CVu4FJNtbkIrkgOkhhZFjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhlYmFFeTk5VHQvck9iUkV2ZTZhK0JHY1RmV3ZMM0RXMnB4N2VRS2djSjZD?=
 =?utf-8?B?dVdCNjg0dHI1N3JIb0JIVEIrR0hGYjNSUFdscFJibnRzcUlnZVlEUzVTVlYx?=
 =?utf-8?B?WFMwOGpuTytITEpDb0xBdGVIT2VydFYramdrUnJHWFVEQUpQRXpWOHJib29O?=
 =?utf-8?B?OUdRaUtENVAyeVZnUm9KSlJmbWoyRnZ1Q0RISGZFN1JtZXQwWVRHSGpTeWVK?=
 =?utf-8?B?YkdIb3grWHVQMDFpdW94NDNScm9HMWlKcXlIYm5WZTcvU2FwdFNyU1orMXNP?=
 =?utf-8?B?V1Ixb0FYenFZS1dqNisyZU1wSit3bVNFOFpOUXliRnZxS2JjQlJIanJZRlZv?=
 =?utf-8?B?RXFteE9GVFREdzgrMko5R3lOdmFUaU9NQzFnRUJoOFRvMVU1bi8xRndqbjlr?=
 =?utf-8?B?dzYvQXIwV2N2aVhXZmg4cDV0amdWbEovUWpNWXRYa0Jwaldwa2ppcE9uaWhB?=
 =?utf-8?B?TythTGtsTSt2aytVZjdVY2dyT1FiOXgvUzFtTVEvOUI3ck11R1hma3Y3QVdU?=
 =?utf-8?B?bTRnTXdBdHVCNGdCRk5nYXdaOE1ueU9NR1NxUTcyVGhTdzZ0Tko5RHRHMitM?=
 =?utf-8?B?Z0k5bVdkNXk0cWRTUkxlN0MrYWJNOE9aTjZkeGoxb3llUWhnNUlsZ0x0S0dK?=
 =?utf-8?B?YWFIT2xYb2szYkZvc05Ha2xOSHNVdW5BaG8xakVBSW1NdlpzZjk0dExhRVBy?=
 =?utf-8?B?MERweE5zNUVuS0k3NndDazJOYkVDQ2dXcGYxdjhRN21pbWUza3lyZi9hMVJT?=
 =?utf-8?B?ODU2ekhxcm1uaXc4U2ZOYWo2UCtKNzdWSDQyRXVqR0xBN2Y1Z3c4MEpleUha?=
 =?utf-8?B?dUpzYmxKL0thMlFieXBNN1E0ZnlMN3k2Z3RYWHh6L1ZKOEk1WXQzaWNwbkZK?=
 =?utf-8?B?bjh3RjNNMmtyY3RsNUxVRHdtNnBEQ1JyV08rZlEwMmdhaUtiWnhuOERJUGw3?=
 =?utf-8?B?K1RWNlUyZFFhM2ZKK0huWUQ5VUlmWWwrUm92MjhuMERDNnNkZ2lBMUovZzZD?=
 =?utf-8?B?TkJUSXpseWRaRVFmbEIxVWxHVm5wRThRZlltQ0F6eVJpc0hsQURvRTlnNXlD?=
 =?utf-8?B?R0JYOFVhQ1diUHRvcDhKZnZtUFZ5VTNmVVFJN0k4RHJtcG1tTkpBai9PWG5q?=
 =?utf-8?B?YzkyYVl1SnBaMG9sNDkxcFlSMFhzVHQ4aHNIMUgxUUVhVlIxTVhqRmNGWVdB?=
 =?utf-8?B?MjNwVGN5WFY4bFNTQU16ek44cS9VNUxycGZ2SzA2L1hjYnZyK0VDa0RqUmJS?=
 =?utf-8?B?L3JteEExRDFITy9KMU5GQUpmY0JRbmM3b3B1YmdSbXNXT3BFdzhoWlJndjBT?=
 =?utf-8?B?ZEVnRzk4VnYwZGZSWHc4Q0JGeHJia3FOK0ZCLzFjcUxLc255V1N2aUFhTS9w?=
 =?utf-8?B?SjJQWjU4aDIrV0ZVS3pSTm8waWMwc2dLb0w4U3ZtM3lLdGtWdE8vTEg3RVJX?=
 =?utf-8?B?NjZ4d0FkRVRuODR4SzY0NENHM3pNeDhNeUx2NFF3cFFrdHJlRGFDZ0ZaVkRY?=
 =?utf-8?B?ZVZzMlZZVjBWKzFuTUNYWVNDRkkxLy96SnN4ZG5HdHJhV09KK3plcVRYWkZw?=
 =?utf-8?B?UjFTRmo1VDFOS0dESGgxU2FXelJhSVE0OTFDY3NaMTFoZExScDNPc0krUXdi?=
 =?utf-8?B?UUZDN2VlRXhkQlBvcmhoZGV2bjVYT1Y4V2gyc1ZoaGo3OS9KK054MXlxVXRq?=
 =?utf-8?B?NzVxRU51MXFjcWFKZWxVN2hWeXpHRjh0S3Z3OStFZUhGRkp3QWQxdzBIcE1N?=
 =?utf-8?B?ZVdHc000dW80VDZFMXRVWkJyYUhJVHpBbW5MaHh0aFdUWEN6S1lMMUdINVUw?=
 =?utf-8?B?ekhiZFNvWERnVU5TcTZEam1oakFGWTlzd1hTbWZseWgyS1BnVlpEVFVhejZC?=
 =?utf-8?B?c05uQ2xyM01nNXN3c0lERUtuUTFQTjk0K1MyZ2grU28rSkFRZUZjdkEzSmxu?=
 =?utf-8?B?d2VBTmtrUUVtc0NMblVXMnl0a01pMkszdkpBdEZ6cVEzRnV4c3NGcGlKUkRq?=
 =?utf-8?B?N3p2QzBnOGNtSWIyRUwxSGhETnBoMWdkQXF2UVlleGVtVTk1R3lkNEYreERK?=
 =?utf-8?B?ZEtFWjhPVmtjSFduNS9QcEloTnBUeFA2TkJJOEliTTRrUEU5YlFBcWpsdVQ3?=
 =?utf-8?Q?BSrg+7EHTqihJoCDH+zcEgvyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18800938-0568-4797-0941-08dc3a059ad4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:38:12.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtVVVG6a+dZA3d7Pzl0JU/ksJOYn+xjfIiFcgrr4orFXTgJzuZZjMGn4j9xqMRcPxyDvEcLoG5T8qvBw1Z+Tbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

On 3/1/2024 00:35, Kim, Jonathan wrote:

> The range check should probably flag any exception prefixed as EC_QUEUE_PACKET_* as valid defined in kfd_dbg_trap_exception_code:
> https://github.com/torvalds/linux/blob/master/include/uapi/linux/kfd_ioctl.h#L857
> + Jay to confirm this is the correct exception range for CP_BAD_OPCODE

Yes, that covers the full range of possible values.
