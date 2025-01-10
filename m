Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E80CE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 16:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE3810F129;
	Fri, 10 Jan 2025 16:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o2G4D53h";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D642910F129
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 16:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6zLvoLAouu8LPguL/CKgYA4ulOyjUHQFJ4hwqTMizHnezXV2CxYegcV1wZFLluixZqXQJ92yZdzckGSGN4YN6HMlpe7VyGY6wwiInOcbt64utri83BkBMHn+pQANG885kNn1X3/tqZa7/mDde0DO7vvihIjN4DvN2D4gqtVXNUWuEAAOPErYrCDNI6nNeyfaR3Dk9efByjhmjwEmsMs0/DV5IplmQ28bfWmAvBFjt/8ChryBSQrw4kGuGHnqO5xql49rKEn2cVydxmgQ/XbVhDjCbGtLKrc4tn8/427TG6kr8m8iofjFHGjX/8GGZBfaFQHb+3Lfz2jKEgJxZZ7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD5Yd1b2/xm02XDH9V2EQDZGmBvlDUAukYE7V/15Gf8=;
 b=HYNjxvLWgLlkpS3kv20UMSDB8UMX2Xb8WQWdvWsPKFCfLRaQKhw7tgH9xYW29uonLQ9MN6keCl/1Pp2+a3CqcWMEOLkaoHvL35Aar2FdPosRLyG/OBFdgx8ivagRX4Nl7cnTDAnpBTaYXRfVDLFzdZenbW3Rw5Tw4ayPPrffsOVk1sb/1lU+HQfL8BtFIt7dQtpcsgo2iEmLv8eMN6/eqyYIH5M4EjEakg32M8K4Ox1/0vcaKafgT9nnV88KAZTv9Urf99ldOCECrXyj1c73fnkcijJ89yY4ddaam+7ReFdgB2WpU2jQDooZd/VPgx8RZ35GUo1IAYMETkQWavWHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD5Yd1b2/xm02XDH9V2EQDZGmBvlDUAukYE7V/15Gf8=;
 b=o2G4D53hp8O4T1eC5pm+yPVsWf5qtJrmF/J2GuHWueUgyrkOPBAyqyfa4DVOLShFALusE8qcTRE5uQi9VGqWisTlr2aV4tRzsOl8cVUCdW6T4Z0STSW+xtX7xe5GNBFo20vOELivmySaSMK6eJkIXHj4bjKF9MbypNzSF5Nahsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 16:23:48 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 16:23:48 +0000
Message-ID: <7fba9b16-4bb7-44c2-bc7e-d455024ce2b7@amd.com>
Date: Fri, 10 Jan 2025 10:23:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
To: Philip Yang <yangp@amd.com>, Emily Deng <Emily.Deng@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
 <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:805:ca::48) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af6bf04-60c5-4624-f3e5-08dd31932947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUExM2IzTkQ4YlVERjZZdVVEYk9uSU15SVN0bTk4V24xbHdKckwwRE1kdXVo?=
 =?utf-8?B?emJ4ZFZIdlZJQ2RUd2Frck9udGhPd3JwcmNMdDFYbi9yRU56SlJyb1dRbU9Q?=
 =?utf-8?B?cmtHeEVpRldydVJKU3RKaFJ6Kysra3lSUVhWV1JVU1FEZkF5VEZFREs2NHYz?=
 =?utf-8?B?ejgya2tVdHd0YVBvSU9EMTlhNWZFQWhqZ2tSMmtYTGJYSjgzUnQzKzN2bUY1?=
 =?utf-8?B?ZU5TdFVpd1dlN2lxM3k4YW5kQmp3ZW04ZTZzY0taVit2Smo3b0l0Tk1QeWpP?=
 =?utf-8?B?bGo0UW5Lb2JzWG13a1gxdG9TRGFOMm5SV1BvS3dwSjFRUmlodUZKZUhqWVhN?=
 =?utf-8?B?b2VpSkt4d2hhRm5WeXJjV01oSlQ3TG53elhCZVNEUVd3L1F1TFYwenV6bzlp?=
 =?utf-8?B?OVJrend0czIyTENZdDVEVWR6NHBtSHg1aW1ScnhqWDMvQmhXakNEMVJIVjZN?=
 =?utf-8?B?MGI5aFBVZUtrTko1MnpiYURnb0dRL3dSVHM0OUUraGlmb0JpUElNVnE5a3ZH?=
 =?utf-8?B?UnVjV25HRGlxV3N4ckJwcEtDUVRMVDlQWGRRQklMeFU4UlphWUlBdFI1MnRh?=
 =?utf-8?B?WXRmNHpFMUVnZ1FSNm9qT3NveVNOLzdsM0pUUmRBd0xVYjhiak5pTitvdkpB?=
 =?utf-8?B?cW5jVU9pbE4wZzFNYlhMT05DVjVTbkEzSEpKOVNZNGxpeFZqaFQzakUrYlhm?=
 =?utf-8?B?SThOK3BYNlcwbVBDZUFsN1pWUC9FU2V5YTRobTdLWld5SDE2Y1RVTjZsUGla?=
 =?utf-8?B?emZPUyt3TDgxcmpvSTlTOGVjNUhwUC91eFR5Mk5qUll2T3VxS1l2Y0dUQjhV?=
 =?utf-8?B?a2d4dzZPNndMc3VtaDVDa2NINEdRYk94QjVwSitqejNqbDBOS3M4ZS82WDVN?=
 =?utf-8?B?aVdndTdZMzRWMnZRZ05qM05zdkU3T2dXeS9NU2R6a2w0eGdZbFpVWUlLdXVm?=
 =?utf-8?B?cUtFN1oxK1IyY05KOFV6aDlTbFZNTVdFQ2FjeUEwVUR0aTd2Y0FwOXBieEll?=
 =?utf-8?B?NG03U21HSm1MOXloaWR4Z0tWQVprWUtyL24vWTFPei80bVFpRE1YQW1kb3Vk?=
 =?utf-8?B?bzFTdkVycU9KWldFbW9JSmF2aXhwd01Nbi83Yk9nRWpPMkN5Yng5cEVyZ3BH?=
 =?utf-8?B?ZndVTkRyQXdjK1BFSnAwTnRSOWdQZVV0WVQ3MFhKQjlhMkVIMTRRczFLQ2RB?=
 =?utf-8?B?MzYzaEpXd3MzUlpFSzB0THB0bnVYTk8yZGxoc2kwTDdsb2ovNm5SRXlnbGdk?=
 =?utf-8?B?WFh4cEdBS3U5VTRQd1VReTQxVmE0Q3NkNnpGczhSVGFJTzl2b0JHNThmMExj?=
 =?utf-8?B?UW9Dck9ZdFBicUNmTG1JMjZKWE1oaU5mSzRIbzd2Vk1kUWsrcGhsNVZmT0RX?=
 =?utf-8?B?d3NVcGNrK2dRQldDanQwVHhKRWVzN3ZTU0IzVHJMY2lxQnJ6WVE1bC9EWVYz?=
 =?utf-8?B?YzBXWHVFb0dkc3ZJdHI1SDIzWHc0a0VMNnFFeEU5L2tNNklJeW9XRkN4YVdv?=
 =?utf-8?B?Q3YrZ3JJVjNhWmdHSkhheUhuN3NlUW5jWHhMZ2lvZVVkMnc0eitRYzFLQmNa?=
 =?utf-8?B?MVlaZ2tnU3R0ZElZTnRkRC9JYlYwMVFBb3JORGdJR29jNzlyakg1blVGeDYx?=
 =?utf-8?B?U2lqaE52aVliaFFEQjdCaDBMbXhVUmt1RUczSVdkejd2QkNJRTN5NzhFeVht?=
 =?utf-8?B?NWg2YmY4d1pESW55RUJZS3hQNGtOQjdLR242V1BqRjV2NU5hZGs5cTQyR0w2?=
 =?utf-8?B?RjRzTmpkaURWUW5TVlZKWmNtQ3hIMDhBQlZ5T0NjMXJscXpiaXYxbGNTNUs1?=
 =?utf-8?B?cklyYWVuOEdnc1ZSR01iYVAzb0FrL1ErZVViSTZUeENsQjUxaU1WMDNFTklW?=
 =?utf-8?Q?lEedjoZrqGiRp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWkxYnVTeEZUVW5VWC9TTlVjcXFFdnVwSzNpckpMS3BsK2JVaTYyR245NkhQ?=
 =?utf-8?B?RUIybzEyaUpXMHpLM3MxMHc2T0tGMno5eEY5bml0WWpBVHdnY2pkWkd3Und3?=
 =?utf-8?B?ckNZbFF2YkNhOGZ2RW4veXFOY1BLd0w5Y1d1YUt6MXRsdUl6d092SCtiZDZS?=
 =?utf-8?B?QXlPakZjd1hPdTNZVklKZHdkcUtPeGQ1MkY3V0VEZDFQK2lMWHM5UmwxVjhj?=
 =?utf-8?B?Y204MTVva2hhc0FjYUM3MHUrQk4yMVZJQUFLUEh6NFNQbWlSQkNhR25YQUpw?=
 =?utf-8?B?UHFoUjVpNW1tSUZ2dmxDcEFRQTgvYWJ5a1UrMzJ1Q05TUG40OEpCdXFzbk9R?=
 =?utf-8?B?cVBIdkkzemhLTVIvL2pVUk9QM0I1UjZkRWllMkhKbFF3ZGxtbld2QmwwQzlS?=
 =?utf-8?B?QTk3KzlXQ2tGNE1YMW95NWlBOW1CYUVmeFVGSUtoQXNJa0R6RE9Ucm9odjlE?=
 =?utf-8?B?Z3ZGWGdaK3RrTW5OeUU3MXQwaGxSL0dqaDlOeDgzSFVsWkhpR09PbEtHVVc3?=
 =?utf-8?B?YlhveXZwc3ZRU1AycU8wdk1VakNMVlZ5SmpjUENTZEZyVWFQQUdma1lYS3Zv?=
 =?utf-8?B?UG15eksrK0w0a2FkSCtra3FWSFpicWhnb09CaTdOU1NCQW5YdDZCaWFBdGw4?=
 =?utf-8?B?MEl5cWM5RXdEQUw2LzdDaDAzR01BN0crNUJiU2E4OElsczlKeHdkTGtwYnQ5?=
 =?utf-8?B?RFJXWkdyZmZZdmhFbjl3Q0pPdXJOQXlkcnlvOWgwbWtHV2lTanlJdXd5bXhB?=
 =?utf-8?B?MEY3UmUxOXNkekREbnRCNjFpYU9WOUVRNjZlNkxIdnVGc0hYRjV0c2RJSDF2?=
 =?utf-8?B?TmJWTzZORzNYSXVLemhYandOVTFBRDJoV01kUDAyQWJEMStzUWdsVUFjZlVq?=
 =?utf-8?B?YksxZVdxTUl1bVMrTUtZMGdQNTRWM3RvMjZKZHU1enJEMVlVd2g3RU5XTEh4?=
 =?utf-8?B?cW4zWEVyR3hYMXNNZ01IOERudkZoaWFydSt0cWdvNlVTS0NlSFFIWmt0bUx2?=
 =?utf-8?B?RVpjOG8xT2FEcmJhYWczNHZWZUNSTnF4QTNtZVU2RVBxU0xjTFRicnlEdTlW?=
 =?utf-8?B?YThWNWxsQW1mRWxvMnpDcXJlQlltUGlhLzdlVHZ0SlFQZmNwc2d2L2E2WHhF?=
 =?utf-8?B?V3V5Q09ndWVQcVlMWTdWNXlzZ0xRaVZYOXF6T0ZRK21DSzBCbFE0VVc5THNE?=
 =?utf-8?B?V2NkZEtvUlRGR1Y3SmR6K1ZoTzVTS2I0THF4My8vT1dtOWxPNkw2MmFaa09v?=
 =?utf-8?B?dmZaZDJBSXhEdHU4cVBHVFdiZ014UG1GZmtzd1lZV0ZzYnR5UlNlSTRjTGNR?=
 =?utf-8?B?bWxmR0JWUVBibk9wTWdVc3h3elgzUTJ3SFZDUDdDakhVcVhVRng4Y3l6L05Q?=
 =?utf-8?B?V1FuT2NhaEJFTkZaTTdndEZNMHZDSGo1S0VoZGFOa0p0aWtzR3BPcWpMT2NQ?=
 =?utf-8?B?VW9MV05KR3AyVlVGMkR1WVJXZDMvaVZZa09IWXRDazN2V1l1ZFcxZzJhSWFR?=
 =?utf-8?B?cXhBc0NheXNYZUNwbGQ2TGtRa1JYeGR3R1pVQUVkeXFpWTFVZjhqMEYxamhW?=
 =?utf-8?B?Uks2T0FzVmlzTnFpOFA0M3FibG5CZlJKNW1Fc1RhVE5ycDhCQ2dNcEptZ1Nq?=
 =?utf-8?B?THZQdTVFdnNGWjcyQTUzUHZCUE5iTkw1eGpOWXBPWWNaQmNqVUFwZkx0QVRv?=
 =?utf-8?B?QmdSZEcrTm5XNjA1bXU1SHRxQnB3T0R2WjVWMTRKZ2UvaG44SzhkOW5kWm9E?=
 =?utf-8?B?anRQRGw5N21OKzluUFVsQlVGaUVmV1NzZUNMSkpnRjRxZ2pXUWczZUJuekov?=
 =?utf-8?B?Rkx4ZmtoRC8ySUtRckx5cnU3cXZGN05YbEFYZGdBYXQvcW5kNzY2Uzd5NCti?=
 =?utf-8?B?RzBBMnJtS1poSkM2UnprSCtOVStCa1NzQ3JVVXRndlpNZnp4MTRKZjVSMmVr?=
 =?utf-8?B?U21oMGxDd0xSWEN0NS9yWW40ZzY5WjR6Z1ZYTGtwM3lMMFFMaUVwLzhDQitJ?=
 =?utf-8?B?MmJ6d3Y3QmVRSDB1Y1dSSEpUMFIrWVR2elJueFpHaVNFbGJib1NpWGNKY3lr?=
 =?utf-8?B?eDU2bFhTay96d2xPN1JWNlRlZCtROWlZa3hLdTFmMzNNalZvTmN0SWlveGVy?=
 =?utf-8?Q?6CEY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af6bf04-60c5-4624-f3e5-08dd31932947
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:23:48.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTKlwdL5OUtXPuKgQJ498lzJ5TcNkCYYVuqTMAhrzDFi2uj7cqLRfmGMMLO6sYdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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


On 1/10/2025 8:37 AM, Philip Yang wrote:
>
>
> On 2025-01-10 02:49, Emily Deng wrote:
>> For partial migrate from ram to vram, the migrate->cpages is not
>> equal to migrate->npages, should use migrate->npages to check all needed
>> migrate pages which could be copied or not.
>>
>> And only need to set those pages could be migrated to migrate->dst[i], or
>> the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>>
>> v2:
>> Add mpages to break the loop earlier.
>>
>> v3:
>> Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.
>
> The error handling need below change, with that fixed, this patch is
>
> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>
>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 4b275937d05e..bfaccabeb3a0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
>>   {
>> -	uint64_t npages = migrate->cpages;
>> +	uint64_t npages = migrate->npages;
>>   	struct amdgpu_device *adev = node->adev;
>>   	struct device *dev = adev->dev;
>>   	struct amdgpu_res_cursor cursor;
>> +	uint64_t mpages = 0;
>>   	dma_addr_t *src;
>>   	uint64_t *dst;
>>   	uint64_t i, j;
>> @@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   
>>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>>   			 npages << PAGE_SHIFT, &cursor);
>> -	for (i = j = 0; i < npages; i++) {
>> +	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>>   		struct page *spage;
>>   
>> -		dst[i] = cursor.start + (j << PAGE_SHIFT);
>> -		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> -		svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> -		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>> -
>> +		if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>> +			dst[i] = cursor.start + (j << PAGE_SHIFT);
>> +			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> +			svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> +			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>> +			mpages++;
>> +		}
>>   		spage = migrate_pfn_to_page(migrate->src[i]);
>>   		if (spage && !is_zone_device_page(spage)) {
>>   			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
>  out_free_vram_pages:
>         if (r) {
>                 pr_debug("failed %d to copy memory to vram\n", r);
> -               while (i--) {
> +
> +               for (i = 0; i < npages && mpages; i++) {
> +                       if (!dst[i])
> +                               continue;
>                         svm_migrate_put_vram_page(adev, dst[i]);
>                         migrate->dst[i] = 0;
> +                       mpages--;
>                 }
>         }

This error handing not need recover all vram pages as error happened at 
middle. Can use se do {....} while(i--);

Regards

Xiaogang

