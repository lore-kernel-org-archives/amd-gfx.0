Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167D2C4452D
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 21:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B088710EB77;
	Tue, 21 Jul 2026 21:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nHFqPYDz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AECA10EB77
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 21:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0BQs3K1Zen9JWyu/uS9Z6WayksWWbaJo/ns9CSF0B1mwOFkKUnMAsEr1daWi2pK6xlKh9EP/GiPU5doXrOfL7+KH/52dj7621sNtsaOQcJDJvT3MUIDYK+rli5TpZ1ORtDlvVK5igHP8mOGr/7UDHBEYKNu9w6Bhdosmwg8FeixtWZMMkCh3LGG6DfHbuZeMwFvs2w02a0uvJhzwm6fXhFRZPTCUzbqqSIOr7VAg8d5JkSDIqZdb+/lt8GJBGMQVStrA+0GVffSq2DGDuI0k+O8sTFT9ZPKtaJ9SCq9FCNlLCFJJwkkyc1fvceenJm6WEVTUBf4Dwbnp2DZLurE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrV4A2Leap7Twwu6BBxO2MjopU2fnjyhhZjtjC/GFxc=;
 b=TP5fNK/ZLM9zsp2CHphacNzFHkazCwT6vpnVNfcl2yxXpe0rlpo1+6iy6vZVux/dCJcUWmLVi1bJQ1KJRwnQmOKtUdfmqlCbaFVsbQcYpl1bY7zEyO3twZkrplzlJe2mnXl8u8axceEtdfcb0hizyuTn1ZbI6yA3Vrm5u3ZFf7IEeHH2bhea9To5V9vcT/3J+hF51RR8ZXkzpgtXTDTwzJtQEgB3HeNgcNsOpk3Us3SZt8X/J/ZWndswJLQjW4RxEFFBB9xnqsNMeXWXGqRxZakM13gGky1kYYmz7dD2Py7w9JqJqxApSTfMi2Va6HHLGkDJY58ebuLi4H2Wj5TuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrV4A2Leap7Twwu6BBxO2MjopU2fnjyhhZjtjC/GFxc=;
 b=nHFqPYDzEP4ln1se5Yop1ME0Ts4XqcKPf393xo0UC+rV7AC/OpKZspiQyOEtuybCohkfbCsv9CbNG6cm2XqJCRqQhFYfH9WkDGwnOEwQm2FlGEujMGsJjBqsrAsshRkaSIh54C9uHApQFLOD/TRQMQNTeStcEvpR/2H5ehSWSq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:21:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:21:33 +0000
Content-Type: multipart/alternative;
 boundary="------------syIJ9LhZbVgerdKBsuvE0Oia"
Message-ID: <5b457aea-892e-4df6-bd1d-5fae0f15c5ff@amd.com>
Date: Tue, 21 Jul 2026 16:21:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Fan, Shikang" <Shikang.Fan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
 <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
 <SA1PR12MB73439B22EB3FB6CFDCD16438EBC62@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343DCAFB25F4BA191AA3A6AEBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com>
 <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com>
X-ClientProxiedBy: SN7PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:806:f2::23) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: adf8e4be-05bb-4f40-9814-08dee76e09d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|5023799004|11063799006|10067099003|8096899003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n8HHDBKhSLoHIOVM4B8e/D+9enWSvjbxDA6CKHbdctTsYITHivVm3o89rWYWNnlmpdVpmMxWjhGjE+o82u9HdneJIbIdZ7VP5uQ3yEd96CtR6RanpzwUqn87XVSxL9bwHGIJVgLWVQFULpxBDQvJP24xP121uXefUbuR8ifs0ORRNKINZpj5gtgnvgralnNnDs7UPNN1dCSc6sMKDz4B9/M8xWX3IPzAedHSLA+57GHHSvhd1Vxk8JriCwordc1lqWopYmqvPok+4Kg9TEJ3sjD0AcdkAHPv48bHgYbvshuteAKIk2vnCQ1CV2BH014y1LaAR8DVo5LwHFRKHgpAQRteV25Mzb+uiSca9/rDnLe33PoubdjeDBHXHXoSAhOb12DTCda9+QN0ehe7J1fTycP8uZQcPFL/wIG/Os7iLSYPmEY35bH9xMGy2dJNpPbm5VjvwWIAxiTaJ595Mq9lvjJyyU5wQxDPyi/jKg660UDL43pIXDQR+FmwdIPA2wYTLbpHr3uuUfkZUGz7kxKSOSmgqIkwDGupy2LXY9KBKxWCjycQ4L7HmcOB/eIA9xYJvs3Q4qt/sVnBzJhi73HEPPHiaYX0YSIv7CyE33XiS/B/SjKAZTXF38uxwuJ1M/vhJI1TxmJZCrfktVdtkGaiBpxR+tb3a4nekZ36vVVZWzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(8096899003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5xUVgrRnRPcml6V1U4OHRLNW1jV3lEL2UxaytjbmZYaEJteU9zZlErSVJW?=
 =?utf-8?B?dm5uZnkyU2wzRmdlNE05ekxqVGtoR2ZWZXB1V2VURlpTYnl1WkgyK2t0NTcr?=
 =?utf-8?B?aFlBOTBjUldORzFMRStOSUJQQWZ5dSt5WjlUczZDdVhuaUxDQlhkQk1EN2hR?=
 =?utf-8?B?UkcvTHNnQlNocXdlbzVDUldiUGNIMUs4RjluY0prTE5tU1hSNjJUcjd0QXZT?=
 =?utf-8?B?NFpWSm9xYnhSR1dKNlY0OTJvUmZmV010RlhwVFB1d1h0c0xlY3VoMmhHWDV6?=
 =?utf-8?B?UU9UOHc2czY5NzAzOTVPMnpuVm0ydkFrcDVpYkxpQVdENTZSRkRjWFNFbk1z?=
 =?utf-8?B?M3gyL2hjV0hwQ1pVQ1BFbjdxMVY1TzFpSURaM3FQYkNROW9RK05EV3F0MzZP?=
 =?utf-8?B?MUhpS3M5NnJRY1IvUXlzU2Z4cm96cDJCWjZZVEJjOEpudlhWLy9GTy9GQ2xm?=
 =?utf-8?B?V1pjZU1TKzVCR1lTczREZkk2NHoxeVUvaVBJdWxhN1F3K0FRTmlLZkw3UUNU?=
 =?utf-8?B?QjRtdjlRZEtobENvWENLNlcyaldmcy9MNVorZFVsTmRiYk5jeVptR2pSWjZJ?=
 =?utf-8?B?RDI2QUh2OVdnL0k1cndqVUJSaTNwdUF3WUlVVmdtdG1UOWMyWDdFS0MvL1VU?=
 =?utf-8?B?Y0hXeEFqVm5lMEZpbzF5T0ttZGpDSlB3OThoQURNMkhDSGFlYzYrZC95ajQr?=
 =?utf-8?B?bU8vWHhqZHFxaXhLZG5VLzdvcVQycDFNWjlnVmNNVXdLZi9VZjFWSWhOZmZU?=
 =?utf-8?B?dndQcHJCdlB4Vk8rYmZFSnk0OFdrd3B1R3Zqa0Y4M0tLcGNLa2xmYTdFa05I?=
 =?utf-8?B?ZEc4TU16SkV4SkpmaE1Ea3B6ZjEybHYwODJVdmwvM2ViT290YlZGS1lsc1k4?=
 =?utf-8?B?VVhaMWk1bkxBczg0SkxzWkZkbUZhdEh0bUZtL0xPMmJyT1J1eGY2eWtSVnNR?=
 =?utf-8?B?STBDU1haWjlLTXRZckhHOUxDbmFvVkFTRFJTSnhLd1lhRDI0RHNQMXNLUjkr?=
 =?utf-8?B?YVkvY0JiZjNLWDZzalJpODNWblNkcXBINVFwZjFTUmEyWDFsL3FZeU1JQVhP?=
 =?utf-8?B?Z05KMHU5SVFrbjZnditic0lXclBTVklwd2xUbzUzL091Yng3TWorVTdOTHJD?=
 =?utf-8?B?cmZzK2xQdlVsQjZTaFNlL1drTWdXZEhFU0htdk1uOGZFRlNzeGx0V1Q5dGh6?=
 =?utf-8?B?bzRBMHB0Q09oK2xxRXVQdVNtNkJpSlhrZjkrekcyYzlsUHJvNHQ4NXhXODU3?=
 =?utf-8?B?dys1QWlrR21Pbjc2SXNsTDFaOFFOVGlTUFoyMEo0Vkd5TVVYYTRURlBXUFlO?=
 =?utf-8?B?WUVyaDBGaWQyNmZzcnBlVzNZWXZUaTB3ZW80Q1N1L3owcWQ3Q0VVdURadm9G?=
 =?utf-8?B?SlpOcGVhOVJzOHpiUnlPazRIdnBjK1V5Wm95bDFjM1VwazdzR3BUb0QybkZZ?=
 =?utf-8?B?OU1kTnBIbGMwUXhuWjNBbERLVVQxN3BmT0xDYnBDZzNhdVhOblJ0RklhN1Jp?=
 =?utf-8?B?TVRiR3BHcmV1TFNzSDQxT0pyMXBhVUtBSytKN2w3WWRYUldZL3ZSRldQMlNW?=
 =?utf-8?B?NVl5N083NkcrLy92UEViOWxBdnV0VGVFQndxc1AwL1VvRGg1UVZsSHVaeEtV?=
 =?utf-8?B?VEtJeWl1ejNyVk5USXVralZKcHVzMTdUSHArMjQ2Mmk4aXZucEZQeDdoMkNj?=
 =?utf-8?B?WU53ZytFd2lPc0NJMkUxZHkwTU9HVWVIY0hKUHpTMUk3WXd2OGdONlRkR2Fj?=
 =?utf-8?B?cXRhNCtrb3p6VEJtaURaaWNMaVlLOWdyMEtrUHE0aU9kVWRQZEswR00zQVh3?=
 =?utf-8?B?d09IRFYzOGxJNUFZTDc3QlJvNmFsaUhQS09iemRQTmFtM3BTOVBSdjY1NWtp?=
 =?utf-8?B?dmk1STBoMXcvWFgrV25kMGh0N245UmRBRVEyNXkxdW5lLzc2YStreW5LeGJ6?=
 =?utf-8?B?OE9ieVJ3L1dyYjZlWHd1R0FUWHlWeWQwZ0t5aDZjM0UyTGZCQmNlcFlDTnpL?=
 =?utf-8?B?eTNVQzVJUlRkTjBIbDlTZUMvaTFGRnZwRkJtRTVRT3ZZTVZacVlvb3RuZHFr?=
 =?utf-8?B?KzY0THpQZFRnYTZwa21yQklDUjFWcXJ6VDlyRVJDWEJsaGY2TitUNjQrYjFv?=
 =?utf-8?B?NWlQaGFWYk1McTlLNnZ1SnduQnhBRjBzdG5sdWg5dlJMNHpXRkYreXNuUnEx?=
 =?utf-8?B?REFZWEU0bm96eUJ0Zit5bjNuRE9zV0V3OFc2VnlYMk5meHpiQXFzNXU0dWNT?=
 =?utf-8?B?TWpXdXhyNks4Z0p0WG55aXl3bzFZbFJYODczOFptbjAyQ24yWUhUelNIdEU5?=
 =?utf-8?B?a1RQUkZnZGlHL0ZsZlVEU1p5alJERm5GWUFrSCtKdDdNUktpaG1udz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf8e4be-05bb-4f40-9814-08dee76e09d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:21:33.2037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9oAkXRZArNXsBbV05IgHRsh7LX/PNzvyx5jXwGCoonLYy9E36ytDLjljwHyeX0yGXjCsRMKYRYdWd0GmFkbeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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

--------------syIJ9LhZbVgerdKBsuvE0Oia
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

IIUC you need to go through these flows as part of guest migration 
(which system goes into S4 to accomplish).


On 7/21/26 16:20, Felix Kuehling wrote:
>
> These are all server GPUs. Is system suspend really a requirement 
> here? Or is this for runtime suspend? But runtime suspend shouldn't 
> kick in while user mode queues exist.
>
>
> Regards,
>   Felix
>
>
> On 2026-07-21 03:20, Fan, Shikang wrote:
>> AMD General
>>
>> +@Zhao, Victor <mailto:Victor.Zhao@amd.com>, @Zhang, Tiantian 
>> (Celine) <mailto:Tiantian.Zhang@amd.com>.  And also @Limonciello, 
>> Mario <mailto:Mario.Limonciello@amd.com> to help with the review.
>>
>> Regards,
>> Shikang
>>
>> ------------------------------------------------------------------------
>> *From:* Fan, Shikang <Shikang.Fan@amd.com>
>> *Sent:* Tuesday, July 21, 2026 11:25 AM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
>> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com>
>> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>
>> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
>> hibernation when MQD is in VRAM
>>
>> AMD General
>>
>> +@SHANMUGAM, SRINIVASAN <mailto:SRINIVASAN.SHANMUGAM@amd.com> and 
>> @Kuehling, Felix <mailto:Felix.Kuehling@amd.com> to the review 
>> discussion as Christian is currently OOO.
>>
>> Regards,
>> Shikang
>>
>> ------------------------------------------------------------------------
>> *From:* Fan, Shikang <Shikang.Fan@amd.com>
>> *Sent:* Friday, July 17, 2026 6:25 PM
>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
>> hibernation when MQD is in VRAM
>>
>> AMD General
>>
>>
>> I do have a few thoughts on the unpin-repin approach and re-building 
>> the MQD from housekeeping information.
>>
>> For unpin-repin: the MQD's GPU address may change after it's moved 
>> back from GTT, and several places hold the original address, so we'd 
>> need to update all of them and be careful not to miss any — but 
>> overall it's doable.
>>
>> For re-build: the one thing we can't reconstruct is the control 
>> stack. It resides in the same BO as the MQD, and the driver doesn't 
>> preserve its contents.
>>
>> Separately, I'd like to raise a potential pre-existing issue I 
>> noticed while writing the patch. mqd_on_vram() covers gfx942, gfx943, 
>> gfx944 and gfx950. gfx943/944/950 are all registered with the _v9_4_3 
>> implementations, which call flush_hdp() in init_mqd, update_mqd and 
>> restore_mqd. gfx942, however, uses the base MQD functions, which lack 
>> the flush_hdp() call.
>>
>> Regards,
>> Shikang
>>
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>> *Sent:* Friday, July 17, 2026 4:59 PM
>> *To:* Fan, Shikang <Shikang.Fan@amd.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Yang, Philip <Philip.Yang@amd.com>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> *Subject:* Re: [PATCH v2] drm/amdkfd: save/restore MQD across 
>> hibernation when MQD is in VRAM
>>
>> On 7/17/26 10:53, Shikang Fan wrote:
>> > On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned 
>> VRAM
>> > BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not 
>> saved
>> > across S4 hibernation, so the MQD is garbage on resume and the first
>> > submission faults. Save it to a system-RAM shadow at suspend and 
>> restore
>> > it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
>> >
>> > v2:
>> >  - Also snapshot the MQD when a process is already runtime-evicted at
>> >    hibernation start. The qpd->evicted refcount early-return previously
>> >    skipped the save loop, losing the MQD across the VRAM wipe (both the
>> >    cpsch and nocpsch evict paths).
>> >
>> > Signed-off-by: Shikang Fan <shikang.fan@amd.com>
>> > ---
>> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
>> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>> >  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>> >  3 files changed, 129 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> > index 51ee9c39104b..d168686ee324 100644
>> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> > @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct 
>> device_queue_manager *dqm);
>> >  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>> >                                struct queue *q);
>> >
>> > +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, 
>> struct queue *q);
>> > +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, 
>> struct queue *q);
>> > +
>> >  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>> >                                struct queue *q);
>> >  static int allocate_hqd(struct device_queue_manager *dqm, struct 
>> queue *q);
>> > @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct 
>> device_queue_manager *dqm,
>> >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>> > &q->gart_mqd_addr, &q->properties);
>> >
>> > +     retval = dqm_alloc_mqd_backup(dqm, q);
>> > +     if (retval)
>> > +             goto out_free_mqd;
>> > +
>> >        if (q->properties.is_active) {
>> >                if (!dqm->sched_running) {
>> >                        WARN_ONCE(1, "Load non-HWS mqd while 
>> stopped\n");
>> > @@ -1263,8 +1270,16 @@ static int 
>> evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>> >        int retval, ret = 0;
>> >
>> >        dqm_lock(dqm);
>> > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
>> > +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
>> > +             /* A process already runtime-evicted when hibernation 
>> starts
>> > +              * skips the save loop below, so snapshot its VRAM 
>> MQDs here
>> > +              * before the S4 image is taken. 
>> dqm_save_mqd_backup() is a
>> > +              * no-op outside S4.
>> > +              */
>> > +             list_for_each_entry(q, &qpd->queues_list, list)
>> > +                     dqm_save_mqd_backup(dqm, q);
>> >                goto out;
>> > +     }
>> >
>> >        pdd = qpd_to_pdd(qpd);
>> >        pr_debug_ratelimited("Evicting process pid %d queues\n",
>> > @@ -1297,6 +1312,8 @@ static int 
>> evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>> >                         * maintain a consistent eviction state
>> >                         */
>> >                        ret = retval;
>> > +
>> > +             dqm_save_mqd_backup(dqm, q);
>> >        }
>> >
>> >  out:
>> > @@ -1304,6 +1321,88 @@ static int 
>> evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>> >        return ret;
>> >  }
>> >
>> > +/* MQD software-shadow save/restore across S4 hibernation, reusing 
>> the CRIU
>> > + * checkpoint_mqd/restore_mqd primitives.
>> > + */
>> > +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, 
>> struct queue *q)
>> > +{
>> > +     struct mqd_manager *mqd_mgr;
>> > +     uint32_t mqd_size, ctl_stack_size = 0;
>> > +
>> > +     if (!mqd_on_vram(dqm->dev->adev))
>> > +             return 0;
>> > +     if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
>> > +             return 0;
>> > +     if (!q->mqd)
>> > +             return 0;
>> > +
>> > +     mqd_mgr = 
>> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>> > +     if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
>> > +             return 0;
>> > +
>> > +     mqd_size = AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
>> > +                NUM_XCC(dqm->dev->xcc_mask);
>> > +     if (mqd_mgr->get_checkpoint_info)
>> > +             mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, 
>> &ctl_stack_size);
>> > +
>> > +     if (!q->mqd_backup) {
>> > +             q->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
>>
>> Please note that you need to be super careful when allocating memory 
>> during suspend. The amount available is really limited because both 
>> swap and OOM killer are already stopped.
>>
>> Instead you should probably consider unpinning on suspend and 
>> repinning on resume, for this we have memory put asside.
>>
>> Additional to that it could be that backing up the MQD is overkill, 
>> we should be able to re-create the MQD after resume from the 
>> housekeeping information we still have around.
>>
>> Regards,
>> Christian.
>>
>>
>> > +             if (!q->mqd_backup)
>> > +                     return -ENOMEM;
>> > +             q->mqd_backup_size = mqd_size;
>> > +     }
>> > +     if (ctl_stack_size && !q->ctl_stack_backup) {
>> > +             q->ctl_stack_backup = kzalloc(ctl_stack_size, 
>> GFP_KERNEL);
>> > +             if (!q->ctl_stack_backup) {
>> > +                     kfree(q->mqd_backup);
>> > +                     q->mqd_backup = NULL;
>> > +                     q->mqd_backup_size = 0;
>> > +                     return -ENOMEM;
>> > +             }
>> > +             q->ctl_stack_backup_size = ctl_stack_size;
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, 
>> struct queue *q)
>> > +{
>> > +     struct mqd_manager *mqd_mgr;
>> > +
>> > +     /* in_s4 is reliably set at evict/suspend time; skip normal 
>> runtime eviction
>> > +      * (pinned VRAM MQD stays intact then).
>> > +      */
>> > +     if (!dqm->dev->adev->in_s4)
>> > +             return;
>> > +     if (!q->mqd_backup)
>> > +             return;
>> > +     if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
>> > +             return;
>> > +
>> > +     mqd_mgr = 
>> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>> > +     mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, 
>> q->ctl_stack_backup);
>> > +     q->mqd_backup_valid = true;
>> > +}
>> > +
>> > +static void dqm_restore_mqd_backup(struct device_queue_manager 
>> *dqm, struct queue *q)
>> > +{
>> > +     struct mqd_manager *mqd_mgr;
>> > +
>> > +     if (!q->mqd_backup_valid || !q->mqd_backup)
>> > +             return;
>> > +     if (!q->mqd_mem_obj)
>> > +             return;
>> > +
>> > +     mqd_mgr = 
>> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
>> > +     if (!mqd_mgr->restore_mqd)
>> > +             return;
>> > +
>> > +     mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, 
>> &q->gart_mqd_addr,
>> > +                          &q->properties, q->mqd_backup, 
>> q->ctl_stack_backup,
>> > +                          q->ctl_stack_backup_size);
>> > +     q->mqd_backup_valid = false;
>> > +}
>> > +
>> >  static int evict_process_queues_cpsch(struct device_queue_manager 
>> *dqm,
>> >                                      struct qcm_process_device *qpd)
>> >  {
>> > @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct 
>> device_queue_manager *dqm,
>> >        int retval = 0;
>> >
>> >        dqm_lock(dqm);
>> > -     if (qpd->evicted++ > 0) /* already evicted, do nothing */
>> > +     if (qpd->evicted++ > 0) { /* already evicted, do nothing */
>> > +             /* A process already runtime-evicted when hibernation 
>> starts
>> > +              * skips the save loop below, so snapshot its VRAM 
>> MQDs here
>> > +              * before the S4 image is taken. 
>> dqm_save_mqd_backup() is a
>> > +              * no-op outside S4.
>> > +              */
>> > +             list_for_each_entry(q, &qpd->queues_list, list)
>> > +                     dqm_save_mqd_backup(dqm, q);
>> >                goto out;
>> > +     }
>> >
>> >        pdd = qpd_to_pdd(qpd);
>> >
>> > @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct 
>> device_queue_manager *dqm,
>> >                                goto out;
>> >                        }
>> >                }
>> > +
>> > +             dqm_save_mqd_backup(dqm, q);
>> >        }
>> >
>> >        if (!dqm->dev->kfd->shared_resources.enable_mes) {
>> > @@ -1423,6 +1532,7 @@ static int 
>> restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>> >
>> >                mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>> >                                q->properties.type)];
>> > +             dqm_restore_mqd_backup(dqm, q);
>> >                q->properties.is_active = true;
>> >                increment_queue_count(dqm, qpd, q);
>> >
>> > @@ -1486,6 +1596,7 @@ static int 
>> restore_process_queues_cpsch(struct device_queue_manager *dqm,
>> >                if (!QUEUE_IS_ACTIVE(q->properties))
>> >                        continue;
>> >
>> > +             dqm_restore_mqd_backup(dqm, q);
>>
>> Those are the wrong point to call those functions if I'm not 
>> completely mistaken.
>>
>> Regards,
>> Christian.
>>
>> >                q->properties.is_active = true;
>> >                increment_queue_count(dqm, &pdd->qpd, q);
>> >
>> > @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct 
>> device_queue_manager *dqm, struct queue *q,
>> >                mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>> > &q->gart_mqd_addr, &q->properties);
>> >
>> > +     retval = dqm_alloc_mqd_backup(dqm, q);
>> > +     if (retval)
>> > +             goto out_free_mqd;
>> > +
>> >        list_add(&q->list, &qpd->queues_list);
>> >        qpd->queue_count++;
>> >
>> > @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct 
>> device_queue_manager *dqm, struct queue *q,
>> >        list_del(&q->list);
>> >        if (q->properties.is_active)
>> >                decrement_queue_count(dqm, qpd, q);
>> > +out_free_mqd:
>> >        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>> >        dqm_unlock(dqm);
>> >  out_deallocate_doorbell:
>> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> > index 88191a4c1657..1f728f13813e 100644
>> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> > @@ -637,6 +637,15 @@ struct queue {
>> >        void *gang_ctx_cpu_ptr;
>> >
>> >        struct amdgpu_bo *wptr_bo_gart;
>> > +
>> > +     /* system-RAM shadow of a VRAM-resident MQD (+ control stack)
>> > +      * for hibernation snapshot/restore
>> > +      */
>> > +     void *mqd_backup;
>> > +     void *ctl_stack_backup;
>> > +     uint32_t mqd_backup_size;
>> > +     uint32_t ctl_stack_backup_size;
>> > +     bool mqd_backup_valid;
>> >  };
>> >
>> >  enum KFD_MQD_TYPE {
>> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> > index 98a5512b701b..cbc90bf87792 100644
>> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> > @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct 
>> queue_properties *properties)
>> >
>> >  void uninit_queue(struct queue *q)
>> >  {
>> > +     kfree(q->mqd_backup);
>> > +     kfree(q->ctl_stack_backup);
>> >        kfree(q);
>> >  }
>> >
>>
--------------syIJ9LhZbVgerdKBsuvE0Oia
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>IIUC you need to go through these flows as part of guest
      migration (which system goes into S4 to accomplish).</p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/21/26 16:20, Felix Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1b4941e0-b2dc-4506-a40c-937c3de37084@amd.com">
      
      <p>These are all server GPUs. Is system suspend really a
        requirement here? Or is this for runtime suspend? But runtime
        suspend shouldn't kick in while user mode queues exist.</p>
      <p><br>
      </p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2026-07-21 03:20, Fan, Shikang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:SA1PR12MB7343FE954902BF06C7996A90EBC22@SA1PR12MB7343.namprd12.prod.outlook.com">
        <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
        <div>
          <div style="font-family: Calibri; text-align: left; color: rgb(0, 0, 255); margin-left: 5pt; font-size: 10pt;">
            AMD General</div>
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          +<a href="mailto:Victor.Zhao@amd.com" id="OWAAM420325" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Zhao, Victor</a>, <a href="mailto:Tiantian.Zhang@amd.com" id="OWAAM394558" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true"> @Zhang, Tiantian (Celine)</a>. &nbsp;And
          also&nbsp;<a href="mailto:Mario.Limonciello@amd.com" id="OWAAM671300" class="tWKOu mention ms-bgc-nlr ms-fcl-b" moz-do-not-send="true">@Limonciello, Mario</a>&nbsp;to help with
          the review.</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Regards,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <div><span style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
          </span></div>
        <hr style="display: inline-block; width: 98%;">
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <b>From:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
          <b>Sent:</b> Tuesday, July 21, 2026 11:25 AM<br>
          <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
          SHANMUGAM, SRINIVASAN <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com" moz-do-not-send="true">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>;
          Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><br>
          <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;
          Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
          across hibernation when MQD is in VRAM </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
          AMD General</div>
        <div style="direction: ltr;"><br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          +<a href="mailto:SRINIVASAN.SHANMUGAM@amd.com" id="OWAAM517752" class="x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b" moz-do-not-send="true">@SHANMUGAM, SRINIVASAN</a>&nbsp;and <a href="mailto:Felix.Kuehling@amd.com" id="OWAAM431627" class="x_tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b" moz-do-not-send="true"> @Kuehling, Felix</a>&nbsp;to the review
          discussion as Christian is currently OOO.</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Regards,</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="direction: ltr; display: inline-block; width: 98%;">
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <b>From:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a><br>
          <b>Sent:</b> Friday, July 17, 2026 6:25 PM<br>
          <b>To:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;
          Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
          Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
          across hibernation when MQD is in VRAM</div>
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; text-align: left; margin-left: 5pt; font-family: Calibri; font-size: 10pt; color: rgb(0, 0, 255);">
          AMD General</div>
        <div style="direction: ltr;"><br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          I do have a few thoughts on the unpin-repin approach and
          re-building the MQD from housekeeping information.</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          For unpin-repin: the MQD's GPU address may change after it's
          moved back from GTT, and several places hold the original
          address, so we'd need to update all of them and be careful not
          to miss any — but overall it's doable.</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          For re-build: the one thing we can't reconstruct is the
          control stack. It resides in the same BO as the MQD, and the
          driver doesn't preserve its contents.</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Separately, I'd like to raise a potential pre-existing issue I
          noticed while writing the patch. mqd_on_vram() covers gfx942,
          gfx943, gfx944 and gfx950. gfx943/944/950 are all registered
          with the _v9_4_3 implementations, which call flush_hdp() in
          init_mqd, update_mqd and restore_mqd. gfx942, however, uses
          the base MQD functions, which lack the flush_hdp() call.</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Regards,</div>
        <div style="direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shikang</div>
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="direction: ltr; display: inline-block; width: 98%;">
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <b>From:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
          <b>Sent:</b> Friday, July 17, 2026 4:59 PM<br>
          <b>To:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com" moz-do-not-send="true">&lt;Shikang.Fan@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Cc:</b> Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;
          Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
          Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a><br>
          <b>Subject:</b> Re: [PATCH v2] drm/amdkfd: save/restore MQD
          across hibernation when MQD is in VRAM</div>
        <div style="direction: ltr; font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="direction: ltr; font-size: 11pt;">On 7/17/26 10:53,
          Shikang Fan wrote:<br>
          &gt; On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live
          in a pinned VRAM<br>
          &gt; BO (mqd_on_vram()). Pinned VRAM is skipped by TTM
          eviction and not saved<br>
          &gt; across S4 hibernation, so the MQD is garbage on resume
          and the first<br>
          &gt; submission faults. Save it to a system-RAM shadow at
          suspend and restore<br>
          &gt; it on resume, reusing the CRIU checkpoint_mqd/restore_mqd
          primitives.<br>
          &gt;<br>
          &gt; v2:<br>
          &gt;&nbsp; - Also snapshot the MQD when a process is already
          runtime-evicted at<br>
          &gt;&nbsp;&nbsp;&nbsp; hibernation start. The qpd-&gt;evicted refcount
          early-return previously<br>
          &gt;&nbsp;&nbsp;&nbsp; skipped the save loop, losing the MQD across the VRAM
          wipe (both the<br>
          &gt;&nbsp;&nbsp;&nbsp; cpsch and nocpsch evict paths).<br>
          &gt;<br>
          &gt; Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com" moz-do-not-send="true">&lt;shikang.fan@amd.com&gt;</a><br>
          &gt; ---<br>
          &gt;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120
          +++++++++++++++++-<br>
          &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 ++<br>
          &gt;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_queue.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
          &gt;&nbsp; 3 files changed, 129 insertions(+), 2 deletions(-)<br>
          &gt;<br>
          &gt; diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
          &gt; index 51ee9c39104b..d168686ee324 100644<br>
          &gt; ---
          a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
          &gt; +++
          b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
          &gt; @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct
          device_queue_manager *dqm);<br>
          &gt;&nbsp; static void deallocate_sdma_queue(struct
          device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
          &gt;&nbsp;<br>
          &gt; +static int dqm_alloc_mqd_backup(struct
          device_queue_manager *dqm, struct queue *q);<br>
          &gt; +static void dqm_save_mqd_backup(struct
          device_queue_manager *dqm, struct queue *q);<br>
          &gt; +<br>
          &gt;&nbsp; static inline void deallocate_hqd(struct
          device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q);<br>
          &gt;&nbsp; static int allocate_hqd(struct device_queue_manager
          *dqm, struct queue *q);<br>
          &gt; @@ -802,6 +805,10 @@ static int
          create_queue_nocpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
          &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
          &gt;&nbsp;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
          &gt; +<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active) {<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;sched_running) {<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1, &quot;Load non-HWS mqd
          while stopped\n&quot;);<br>
          &gt; @@ -1263,8 +1270,16 @@ static int
          evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval, ret = 0;<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
          &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted,
          do nothing */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already evicted,
          do nothing */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
          hibernation starts<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot
          its VRAM MQDs here<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
          dqm_save_mqd_backup() is a<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
          &amp;qpd-&gt;queues_list, list)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;Evicting process pid %d
          queues\n&quot;,<br>
          &gt; @@ -1297,6 +1312,8 @@ static int
          evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * maintain a consistent eviction
          state<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = retval;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt;&nbsp;<br>
          &gt;&nbsp; out:<br>
          &gt; @@ -1304,6 +1321,88 @@ static int
          evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
          &gt;&nbsp; }<br>
          &gt;&nbsp;<br>
          &gt; +/* MQD software-shadow save/restore across S4
          hibernation, reusing the CRIU<br>
          &gt; + * checkpoint_mqd/restore_mqd primitives.<br>
          &gt; + */<br>
          &gt; +static int dqm_alloc_mqd_backup(struct
          device_queue_manager *dqm, struct queue *q)<br>
          &gt; +{<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_size, ctl_stack_size = 0;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type !=
          KFD_QUEUE_TYPE_COMPUTE)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
          dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;checkpoint_mqd ||
          !mqd_mgr-&gt;restore_mqd)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_size =
          AMDGPU_MQD_SIZE_ALIGN(mqd_mgr-&gt;mqd_size) *<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NUM_XCC(dqm-&gt;dev-&gt;xcc_mask);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;get_checkpoint_info)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;get_checkpoint_info(mqd_mgr,
          q-&gt;mqd, &amp;ctl_stack_size);<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup) {<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = kzalloc(mqd_size,
          GFP_KERNEL);<br>
          <br>
          Please note that you need to be super careful when allocating
          memory during suspend. The amount available is really limited
          because both swap and OOM killer are already stopped.<br>
          <br>
          Instead you should probably consider unpinning on suspend and
          repinning on resume, for this we have memory put asside.<br>
          <br>
          Additional to that it could be that backing up the MQD is
          overkill, we should be able to re-create the MQD after resume
          from the housekeeping information we still have around.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = mqd_size;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ctl_stack_size &amp;&amp;
          !q-&gt;ctl_stack_backup) {<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup =
          kzalloc(ctl_stack_size, GFP_KERNEL);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;ctl_stack_backup) {<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup = NULL;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_size = 0;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size =
          ctl_stack_size;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static void dqm_save_mqd_backup(struct
          device_queue_manager *dqm, struct queue *q)<br>
          &gt; +{<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in_s4 is reliably set at evict/suspend time;
          skip normal runtime eviction<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (pinned VRAM MQD stays intact then).<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd || !q-&gt;mqd_mem_obj ||
          !q-&gt;mqd_mem_obj-&gt;cpu_ptr)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
          dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;checkpoint_mqd(mqd_mgr, q-&gt;mqd,
          q-&gt;mqd_backup, q-&gt;ctl_stack_backup);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = true;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static void dqm_restore_mqd_backup(struct
          device_queue_manager *dqm, struct queue *q)<br>
          &gt; +{<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_backup_valid || !q-&gt;mqd_backup)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
          dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;restore_mqd)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;restore_mqd(mqd_mgr, &amp;q-&gt;mqd,
          q-&gt;mqd_mem_obj, &amp;q-&gt;gart_mqd_addr,<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;q-&gt;properties,
          q-&gt;mqd_backup, q-&gt;ctl_stack_backup,<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;ctl_stack_backup_size);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_backup_valid = false;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt;&nbsp; static int evict_process_queues_cpsch(struct
          device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
          qcm_process_device *qpd)<br>
          &gt;&nbsp; {<br>
          &gt; @@ -1313,8 +1412,16 @@ static int
          evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval = 0;<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
          &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) /* already evicted,
          do nothing */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0) { /* already evicted,
          do nothing */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A process already runtime-evicted when
          hibernation starts<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skips the save loop below, so snapshot
          its VRAM MQDs here<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before the S4 image is taken.
          dqm_save_mqd_backup() is a<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no-op outside S4.<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(q,
          &amp;qpd-&gt;queues_list, list)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = qpd_to_pdd(qpd);<br>
          &gt;&nbsp;<br>
          &gt; @@ -1350,6 +1457,8 @@ static int
          evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_save_mqd_backup(dqm, q);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
          (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {<br>
          &gt; @@ -1423,6 +1532,7 @@ static int
          restore_process_queues_nocpsch(struct device_queue_manager
          *dqm,<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
          dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, qpd, q);<br>
          &gt;&nbsp;<br>
          &gt; @@ -1486,6 +1596,7 @@ static int
          restore_process_queues_cpsch(struct device_queue_manager *dqm,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!QUEUE_IS_ACTIVE(q-&gt;properties))<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
          &gt;&nbsp;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_restore_mqd_backup(dqm, q);<br>
          <br>
          Those are the wrong point to call those functions if I'm not
          completely mistaken.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm,
          &amp;pdd-&gt;qpd, q);<br>
          &gt;&nbsp;<br>
          &gt; @@ -2161,6 +2272,10 @@ static int
          create_queue_cpsch(struct device_queue_manager *dqm, struct
          queue *q,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;init_mqd(mqd_mgr,
          &amp;q-&gt;mqd, q-&gt;mqd_mem_obj,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &amp;q-&gt;gart_mqd_addr, &amp;q-&gt;properties);<br>
          &gt;&nbsp;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_alloc_mqd_backup(dqm, q);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_mqd;<br>
          &gt; +<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;q-&gt;list,
          &amp;qpd-&gt;queues_list);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count++;<br>
          &gt;&nbsp;<br>
          &gt; @@ -2193,6 +2308,7 @@ static int
          create_queue_cpsch(struct device_queue_manager *dqm, struct
          queue *q,<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.is_active)<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
          &gt; +out_free_mqd:<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd,
          q-&gt;mqd_mem_obj);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
          &gt;&nbsp; out_deallocate_doorbell:<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
          &gt; index 88191a4c1657..1f728f13813e 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
          &gt; @@ -637,6 +637,15 @@ struct queue {<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
          &gt;&nbsp;<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_gart;<br>
          &gt; +<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* system-RAM shadow of a VRAM-resident MQD (+
          control stack)<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for hibernation snapshot/restore<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *mqd_backup;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *ctl_stack_backup;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mqd_backup_size;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ctl_stack_backup_size;<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool mqd_backup_valid;<br>
          &gt;&nbsp; };<br>
          &gt;&nbsp;<br>
          &gt;&nbsp; enum KFD_MQD_TYPE {<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
          &gt; index 98a5512b701b..cbc90bf87792 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c<br>
          &gt; @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const
          struct queue_properties *properties)<br>
          &gt;&nbsp;<br>
          &gt;&nbsp; void uninit_queue(struct queue *q)<br>
          &gt;&nbsp; {<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;mqd_backup);<br>
          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(q-&gt;ctl_stack_backup);<br>
          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(q);<br>
          &gt;&nbsp; }<br>
          &gt;&nbsp;<br>
          <br>
        </div>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------syIJ9LhZbVgerdKBsuvE0Oia--
