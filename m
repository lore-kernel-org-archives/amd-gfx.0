Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95C7CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 06:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1476F10E064;
	Mon, 17 Nov 2025 06:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qdYQbEqn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19BF10E064
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Nov 2025 06:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AouLYfhjl+i9f8zVv5QJUDIAaTZkJFw/hjDuyAFPnpW1wc12MpJ+H7Cln5SuhChcNSebsh4PJQ6bT/wPBmbRBfc5Y4+hrkJXGkH1+OtUOCsos8qfdu1sulLOTy99tiPUU5TOMKzVUmtC7WlgNHnp6DCXJVzYKVHZkqMT0ryale7jD5+be4f3g5slYNBlo8QZvaoNjgQl/arX9coBPZAvQqviFo4GxCgez1i98hXoF8dXk0bwQlXRkoWYhTuGisUNxEgKBwtEYAVcmmF8neQCvuRE2ygRHKU+liqT5X2ELuC7CmVHleDqWvAaRS5CNKedFV+UcZIezK0I4LJXLjuYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPxb3LcGRLNjdilcZfUZA230QLiWL+WukdNjsK6CxvE=;
 b=vXdRuIQB9G1Piqpeo9gnE3SDNfxI7oTJdGpY98EgLHFAprbGkI1NXGkE8wYTp3LZvBUd8yZvk5Me2dzzHTFPP+7Ezu2RrsJyhYjg9LqFCf+xJ4LTI7AAELe4AihGo0BTR7cIhi+AmgRYV34AslBb//XvwOzqlfPB+eUO9rr+S4TRpO8fTDpAdiDl56tPROpWCCCxZ7OV3waG1+VyxOrI9S/L8r6l8zvYqVkZDY3uiBvmiIqS3HaGvI3Uw6jTxH421OVWgSrTx4i2aXkB8cPWFpB92kmLX2CVecqzL5zsPCSkUBBkPz5m/pBKWzOyG51wV8W6g3fluCOnC02uyACTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPxb3LcGRLNjdilcZfUZA230QLiWL+WukdNjsK6CxvE=;
 b=qdYQbEqnZRoMdBX36Ze/8qrYiscL9V7d085UL4rgyHAOS0QN/OYpMHEhinWMtn4PWlKEco9ISsci+o2Ni3tdzPvItWxcEDAjJAd4DACCLPpVsmE7eE/+lGudG/5r6HMEYbIHdz3osyRjGoKnsvuwqchBOaQ7n9J6Df4V6+TpCDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.19; Mon, 17 Nov 2025 06:10:34 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 06:10:33 +0000
Content-Type: multipart/alternative;
 boundary="------------0W7mO5H8NvSdruIE00cjNBqa"
Message-ID: <3dc8ccb7-a461-4505-8620-2040ae8e9551@amd.com>
Date: Mon, 17 Nov 2025 00:10:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: An adaptive data migration scheme for page
 fault recovery at svm
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251020212414.1890907-1-xiaogang.chen@amd.com>
 <e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com>
X-ClientProxiedBy: DS7PR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::17) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f367c97-da7c-4a46-3239-08de25a00486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alVXdkc4cXp4bDdIc1RUWW9OTWt0NTBleHExWGxJSTk4U21xS0MzeFdSVkkr?=
 =?utf-8?B?bXM2YnY0cG92OUNtTEN6czdIaHlNbjJyVmp1Wjh2ZlZGejh0TDQvT2NDUU5Z?=
 =?utf-8?B?Mzk4ZkNiMllraXlJNkN0QTB2a1V0YjhJbHpVcFRSaWRqekNlNThnamFSZVY1?=
 =?utf-8?B?Mk1TVXp5TFdGVFhvK3hTYnJLWkN1RjRrRmNzTVVEMU8vak9YMFlHSWNYSXoz?=
 =?utf-8?B?LzNsUTIraTVvSko3TjlsYklYbU1xeHViQmp3WUlGN2lTMVNaTkJyU0ZvUyt4?=
 =?utf-8?B?YXRWeUttbm1reGFlWVdPTmhXUUJHVmZvTHhrVlNkS2FwdE1pU1F1Rnc5djNt?=
 =?utf-8?B?ekg2bHhjZ0pqMS9WKzlRYjh0Wkl6dUUvSzhFb3ZSN1laRWI1MWxiYUNjc2Jz?=
 =?utf-8?B?TG1RbDMwbUpUdG1wVS9sSndJUWtkbVRLVE9PRC9RS040a3VudEg2ZWVLVnVP?=
 =?utf-8?B?T1FVQktpYkNhelpQU1k5MEdGb0cvdnJoVjhZYnJ3bW9mNVEwYU5oWVd5bFBz?=
 =?utf-8?B?RkRNaTFTTWNuUGxoM3FDL3B4bmUrYmhsTWxleHo0cjdWL3lpczhrejVoUGJT?=
 =?utf-8?B?Y1hBL0hIbXROV0ZNUllxZkpUL1llMHg2cGlWL0c4aDV5S3FqZ2l4K2R5NThD?=
 =?utf-8?B?TmpxcXRwNFIvQ1g1dmIwMkhmQVhzUFRPaEJKbUNIOU5pSmxySG04bit3bEdE?=
 =?utf-8?B?aitaSTF2VUsyb3hCKzd3WGNvT0FsUHJqRytCSDBsMFl5VUlnZUZ5eFlxWXhR?=
 =?utf-8?B?cHJyZUkzdVkrUGpGMmNiZmtkRjNXUGlremhKb1JORFFacmM2WWl5U01ldi82?=
 =?utf-8?B?YmEvc3hwUE5HV1dTVVo2eTY4dHhLSHdTZkdtQld4c3dVSFFWNjRGa3JQOVBG?=
 =?utf-8?B?QllXeEZobFcrZ21DTWprK3dTNzBxcHVxVWtCNTVjWXNzN1NrV21zYzBiQkRG?=
 =?utf-8?B?UVBjRGxmOWVtTk1iY0lJNTE1MEtwcTN4TGxucFNOWlg2MEM5MmVzWllSTERO?=
 =?utf-8?B?NlhVMTBPSm9jNjF5dFJ2dmZNL252WnhmTklOdEd6bXppbE9KNUREUEdxYTFi?=
 =?utf-8?B?NVJpdDNiZU5NZkhObGlqS1pnT1hKd2JXRTliL1k5UGFEbWVKcUlQSHJ4VkhP?=
 =?utf-8?B?Uy84UG5paUVyZDV2K25pQUlkMDVKbHBvZm5QdXdNNjVhck14RkwrR1F6Q05Z?=
 =?utf-8?B?NW50MUY0RUpBd0ZGODJqRDFVS2grOHBubVA3ODRQTExCY29FOTNva3ZLc1pR?=
 =?utf-8?B?RDREdTVyRTNUWFJyUHJKREQzYnZSMEN6QlZXd0x1eUtBSGZ5RU9GeHM0SWM2?=
 =?utf-8?B?dXZkczFMbHdmb3NBTkx5SFFtSFJkaDFoamZPOWhYbFNFbUtJcnVLTFF5SUxQ?=
 =?utf-8?B?cHU3aTREVDZzZFY1a0o4bTdtNmFNd3gyWS9zTlpBQ2R6ektyYkloNXFrWHdG?=
 =?utf-8?B?WHBTSEhwby80ejcxUXJmT2hYc3hydnQ4V2l3YzJDekNNT1hWMnJIMWJQazIx?=
 =?utf-8?B?R0N3VUNBaGhXSnZlb25sZXlVT1VxL3ExYW5oTVQ1eXRqdGRzVFNPR28wYWRo?=
 =?utf-8?B?dnZzVEw4YTVWVmhHVEdvNDlVQW1rbXZJOHdCU0N6YmZFTGFuZGVNK3o2eTF3?=
 =?utf-8?B?NU5xRlBGSFQrdEhYdDdNTk1BTmhjZGtUTE9ZdUxMTTJ0UlVjZ0xESVp5T3Av?=
 =?utf-8?B?TnBndTBpVFp2TVZ2RVlGUUh3NmhPV3dyTm5MVkc2MFNFOGQwVUJnTHF3WUpl?=
 =?utf-8?B?bGhqSW4yWVUzNmR2eFlNc3lhc3VTZ3RzVzZwd1MrWS9MRmZpclpTcCtuNXlX?=
 =?utf-8?B?dDh6SVhUeUYrdTRKYURQcFBtV3RnWllueENkSlVQSkNNdTFURjJVOHpSQlUz?=
 =?utf-8?B?Umd6S214d0JrbENkT01jRnhyTExVa095UTJLNlZTT25aV1dhZE1kdjlWL1hS?=
 =?utf-8?Q?3KjjUf4xNdKyLDUWXPmBmUXgwtOAmiJx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxMYVBrVGtjUll6bzNNMzRYMTJTaFM1M2VhYVE3OTBUdjBQN082K1ZpekpS?=
 =?utf-8?B?bFlZQTVQSzErZHl6emJhd2RQYnIzVzh6UmVzUmNkNGlVSXowWS9jOFNhWmRX?=
 =?utf-8?B?d3hxUWMvYVZiVjdxajNDMG1vZ2twSXcxSlAybzMwcGZsQ0tzeG5JNnUzL2ZU?=
 =?utf-8?B?ZHhCYUNSd3Axa2F4bC9UaEJsVXppb3ZzYklreVJtU3p4V1BHNlJtVmZUZkVR?=
 =?utf-8?B?UzBlOUFSOFErT0pWNi9SUTdTL1BJTXlJbUZEdWJjZDYrdjU1VXJDMHVxQms2?=
 =?utf-8?B?WTZqdisvRmNscG4yM1F3aGQ1aDc5V3BjbFo3THZHWGNFeS9ZbG5ETGpHSjhq?=
 =?utf-8?B?ZTFYaDZ5UlBVdUI2dEszTy9Pa3ppWW9PK0Jza09PL2xxMjMxYWF2SFkxZERk?=
 =?utf-8?B?clI0MEZmMkVmZ3p0SVpNbE4va0c4anM1dFh2dHhqNi9YVjJLa09OcDFhNWFF?=
 =?utf-8?B?SHFWaFZrOVRDOW1YUkFYUW00bXhYWEdUOHY2b01uUU9RcU1xSkZiUXI3aWtq?=
 =?utf-8?B?clNEZEVweDFSbTkvMzdrRWVkTTdVSk5SRDNuUjRiaXQwZ3Y4S2tEd2pTTnY0?=
 =?utf-8?B?SXRrdnF4MkVHMWdONHJmRUdKdFA5RUJmZkFydnRNTzJiWDVnVW5XcTFLTWxz?=
 =?utf-8?B?R3ZQYmhvUFAzRTJPd3BWZGowcTJjSWRQeE1sNTJFaU81YlF4VmE4R0dlZlhT?=
 =?utf-8?B?b3ROd2J5UHE5cU9MYXplendIR2NvOG9jblNTUlJieENESE9JZFhNYzVFemRQ?=
 =?utf-8?B?NU1RYnpla3hJK0xPbnNHSjNMSWdJMHFaKzc1YkVhSkhmUjArL1BoZCszQTRl?=
 =?utf-8?B?RVJyN3R4VlI4K1VBK0VnYXYway9HMmdNQ0pGdmVkYzlLYUZwd3RoaDB3QmZl?=
 =?utf-8?B?WU0yRnl5cms1cU5SSWtmVUo2cUhzUFNlZnUrMnM0cTl4THgrSDl5UU9kMzV0?=
 =?utf-8?B?OVdzaE1UVkRqZEMycjgwb244cjYxamtTRkkvbWk4RjR5OTFoQm9sbnlJZExw?=
 =?utf-8?B?RWsvZ2RmRENmbWdsb0NZdGVhcDYrWkRPeGFwNUdFR2crYTFHS2lQaFlweDc2?=
 =?utf-8?B?cW1qd0VjeEVDa0tvcTFZNmNHTGdLS09vNjVZN1V3aFlaRjlzTmhQOXE1MmJa?=
 =?utf-8?B?dlJKRVpNUnY4bnR1SThpQkdoVnV1RnVRb3dZUXpQelRLMlBBNndsZVZWT3Ni?=
 =?utf-8?B?UCtjSFpaQkV5VkpsRnJNelJ5cjBkNWVGUHhMSGJHRkpsK1BLUnFvVlFwQ1Fu?=
 =?utf-8?B?bjF2UlRZaVQrMFhBbWF3TXd1a1p0cEpBVTZlL3J0bmNEbjhyM212THZsamhY?=
 =?utf-8?B?YUxFd240VGZJcFBqK3lTYjRwZXlEOFk1eWIxT0RTamMyWTZzNkNYT3U0ZWs0?=
 =?utf-8?B?dWU4YWtDWHFKYlJjUS9uNDVIVUtXV0NCZEd3WlprS0IrNVpBeS8rMTZUcWdP?=
 =?utf-8?B?c1cvK3VUdXl2aWlzblVUOWpsT1Zrb2VsdTlpNml3MytycE9JY3duVWtyaVA2?=
 =?utf-8?B?WW9JMjRQeUl2d2VYVkVkL0NNc1YxdDZaQlQ3bnNvMzhRVzg4MmlBaDZhd3Jx?=
 =?utf-8?B?d3diKzllUU1OVG53SVp5MFc2M1MwZENKN2ZoZG9uMGJRUWZ2VmczdVJCYzdU?=
 =?utf-8?B?bEFoalVpOUtLVE9UQVN5Z0pNWkd2YVNMZFREeThEV1JrLzBVMTFXUDBVQjVO?=
 =?utf-8?B?V3JPdU01dHMra1NSQVpmcFZQWWNOYkNKRVFveG1SMlMvaGlGM2MydlR3cHZw?=
 =?utf-8?B?NEFpS3AyRWNCckRTSVJiaWlwRlBVL2FrTnppLzMvRlRhMGxVVjBubndibG5J?=
 =?utf-8?B?WFFSRmJueVFpb2pqNS9IcG1MTGNkclAyOGttVHk4WEU3c1JBdHU2blB0VnRj?=
 =?utf-8?B?U3BpQzMxUHpLWWVoQUphNHF2WlJORi94VkVpUDNCSDJRT1RJR3VOK21JL0Zm?=
 =?utf-8?B?S2duaHBKVWtDWE5yU2cwRDJpcUFjdmtzODZHb1lmbHBBbGpwLzhmbEpZcWxl?=
 =?utf-8?B?Vjg2NnZQbEdWYjlYdFM1bnpiUFhYWWxWdHhDTTdRbC91UTgwV3pBSXJoMng5?=
 =?utf-8?B?WGRoVVp3dGpJTHhnN2dqekIzNEYrUnpERWErb0VCYS90WnlDMXRra1MxS3RL?=
 =?utf-8?Q?klq0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f367c97-da7c-4a46-3239-08de25a00486
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:10:33.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jmklgVfB/yGpY5NMHisXhYGiOtFsw02o/eL4VD1JfhwjsP2C4T2uCOhYh6ucKkW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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

--------------0W7mO5H8NvSdruIE00cjNBqa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Felix:

This patch uses "data migration rate(per second, DMR)" to decide if data 
migration is too intense already(higher than data_migrate_rate_threshold 
defined at kfd_migrate.c). The data migration amount and time are 
recorded for each page fault that already happened. These data are used 
to calculate DMR(at update_pf_migration_data)

Stopping migration is decided by DMR. When DMR is too high migration 
will be stopped(at processing_pf_migration_data) : all data accessing 
from no-current devices to that range will be remote. If it is cpu page 
fault we need move data to system ram, then all following data 
accessing(from all GPUs) will be remote.

The hot device is decided/*after*/ when DMR is higher than a 
threshold(data_migrate_rate_threshold). The condition is: the data 
migration amount is mostly caused by this device(more than 1/2).

If DMR is lower than data_migrate_rate_threshold the drive still uses 
current migration scheme.

Let's use thrash happening case to see what will happen with this patch: 
When data keep migrated among devices eventually the DMR will be higher 
than data_migrate_rate_threshold(it can be adjusted through debugfs). 
Then will not migrate data for following page faults. Any following page 
fault will access data remotely. If also find there is a device accessed 
data mostly(again it is after DMR is too high) will have data park at 
this device, all other devices need access the data remotely. Then the 
data will not be moved around.

 From your comments below I think you may miss this part of this new 
data migration operation above. So clarify that first.

The patch also make this scheme dynamic. The DMR is calculated with time 
evolving: the page fault can happen intensively during some time, then 
become relative quietly, then become intensively again. Also, the hot 
device can also be switched to another device. This patch keeps checking 
DMR and hot device dynamically to decide when to stop/resume data 
migration and if there is device that driver should give favor to.

The code changes may seem more. I think we can first check if the 
scheme's ideas above are ok.

On 11/14/2025 7:51 PM, Felix Kuehling wrote:
> I have lots of detailed comments inline, most of which were just made 
> as I was reading through the patch. But I want to put my conclusions 
> about the overall scheme up top:
>
> I think with your logic, you're replacing thrashing with "sloshing". 
> Maybe you could call that an improvement, but it's far from ideal.
>
> I also think that your logic cannot reliably detect thrashing between 
> two devices because one of those devices will always have slightly 
> more than 1/2 of the page faults. So one of the devices will always be 
> allowed to migrate data, although it would be better to leave it in 
> one place that's good for both devices.
As said above the DMR decides if stop data migration. If DMR is higher 
than threshold there will be no migration. If also find hot device 
exists driver gives favor to the device, all other device will access 
the data remotely. There will not data migration when thrashing 
happened. The data is either parked at current location or hot device.
>
> Your logic in svm_range_restore_pages is also not helping. If you had 
> a case of true thrashing and detected it correctly by not designating 
> a hot device, things would continue to migrate unchanged. So I'm 
> really doubtful that this scheme, as is, would meaningfully improve 
> the migration logic in the most problematic cases.
hot device does not decide stopping migration. hot device is decided 
after find DMR is too high(hot device can either exists or not) . DMR 
decides stop/resume data migration.
>
> On the other hand, I could see regressions on real workloads. Imagine 
> a range that's bigger than num_pf_samples*migration_granularity. The 
> range is created on the GPU first by e.g. hipMallocManaged. Then the 
> CPU is used to initialize it, that migrates it to the CPU and makes 
> the CPU the hot device. Now the GPU starts the computation, but 
> because the CPU is hot, the first few page faults won't migrate the 
> data to the GPU. That will cause performance regressions.

Hot device is not decided by a few page 
faults. data_migrate_rate_threshold is the threshold that can also be 
changed by debugfs. DMR uses data_migrate_rate_threshold to decide if 
migration rate is too high. Before driver "think" DMR is too high driver 
still uses current migration scheme that migrates data to gpu who 
accesses the data. Hot device may exists only after driver detects DMR 
is too high.

As talked above DMR and hot device are decided dynamically with time 
evolving. In this case driver think cpu is the hot device after multiple 
cpu page faults handling the first few gpu page faults will use remote 
accessing from gpus to cpu. With time evolving the patch calculates new 
DMR and decide new hot device during each new page fault. When data 
accessing from gpus is more the DMR will be more than the threshold and 
hot device will not be cpu, but a gpu and data will be moved to the gpu.

This scheme looks at "trend" of data accessing with time evolving. If 
devices access data remotely for a few page faults it would not affect 
performance too much overall. We cannot predict accurately which device 
will access data in future. This patch predicts data accessing pattern 
based on previous data accessing samples.

>
> Unless I see some data showing an improvement in some realistic or 
> contrived scenarios, and negligible performance regressions in real 
> workloads, I'm not going to approve this patch.

I did not find real app that demonstrate bad data accessing between 
cpu<->gpu or gpu<->gpu. I made test cases through kdtest:

1: trigger data  keep moving between cpu and a gpu:  the driver 
calculates DMR and decide hot device. Then stop migration after DMR is 
too high, then has all following page faults access data remotely.

2: trigger data keep moving between 2 gpus: same as above,  have 
intensive data migrations rate, that stop migration/use remote access. 
Then let test sleep some time, so no page fault happen during. Then 
trigger page faults again. Now DMR is smaller because time interval is 
more but data migration amount is not changed. Now data migration happen 
again and devices access data locally. With time evolving DMR becomes 
high again, then data migration got stopped, devices access data 
remotely again.

     The test repeats the procedure above to simulate page fault 
happening(device access data) frequency became high->low->high ...., 
then date migration got stop->resume->stop... That demonstrates how 
driver handles data accessing locally or remotely based on run time 
scenario. The driver does not have data migration too much that can hang 
app, and have data access locally when there is no much data got 
migrated. data_migration_rate_threshold is used to adjust this new data 
migration behavior.

Regards

Xiaogang

>
> More comments inline ...
>
>
> On 2025-10-20 17:24, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> Data migration between cpu and gpu or between gpus is a common 
>> operation at
>> kfd/svm during page fault recovery. Certainly, it adds overhead and 
>> consumes
>> bus bandwidth. So, becomes crucial for compute performance.
>>
>> There are two objectives that are considered mostly during data 
>> accessing:
>>
>> 1: Locality:  move data to compute devices local memory which is fast.
>> 2: Zero copy: not have data moved, compute devices access data remotely.
>>
>> They are usually conflict: local accessing would require data copy; 
>> avoiding
>> data copy would have device access data remotely.
>>
>> The new scheme balances the two accessing patterns by using 
>> statistical samples
>> that driver records from previous page fault data to predict what 
>> data accessing
>> pattern would be for future page faults, then use the prediction to 
>> handle new
>> page fault.
>>
>> The scheme behavior is also dynamically adjusted by following 
>> application data
>> accessing pattern overtime. The new decision is based on most recent 
>> page fault
>> handling data that are saved at a ring buffer.
>>
>> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 102 ++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 212 ++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |  12 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 151 +++++++++++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  30 ++++
>>   5 files changed, 473 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> index 9bde2c64540f..d495af31fa3c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
>> @@ -38,6 +38,9 @@ struct debugfs_proc_entry {
>>     #define MAX_DEBUGFS_FILENAME_LEN 32
>>   +extern uint32_t num_pf_sample;
>> +extern uint32_t data_migrate_rate_threshold;
>> +
>>   static int kfd_debugfs_open(struct inode *inode, struct file *file)
>>   {
>>       int (*show)(struct seq_file *, void *) = inode->i_private;
>> @@ -50,6 +53,80 @@ static int kfd_debugfs_hang_hws_read(struct 
>> seq_file *m, void *data)
>>       return 0;
>>   }
>>   +static int kfd_debugfs_num_pf_samples_read(struct seq_file *m, 
>> void *data)
>> +{
>> +    seq_printf(m, "number of page fault samples per svm range: %d\n",
>> +               num_pf_sample);
>> +    seq_puts(m, "echo 'num' > num_pf_sample to change it\n");
>> +    return 0;
>> +}
>> +
>> +static int kfd_debugfs_data_migration_rate_threshold(struct seq_file 
>> *m,
>> +                              void *data)
>> +{
>> +    seq_printf(m, "data migration rate threshold in 2MB unit: %d\n",
>> +               data_migrate_rate_threshold);
>> +    seq_puts(m, "echo 'num' > data_migrate_rate_threshold to change 
>> it\n");
>> +    return 0;
>> +}
>> +
>> +static ssize_t kfd_debugfs_num_pf_samples_write(struct file *file,
>> +    const char __user *user_buf, size_t size, loff_t *ppos)
>> +{
>> +    char tmp[16];
>> +    int ret = -EINVAL;
>> +
>> +    memset(tmp, 0, 16);
>> +    if (size >= 16) {
>> +        pr_err("Invalid input for num of page fault samples\n");
>> +        goto out;
>> +    }
>> +
>> +    if (copy_from_user(tmp, user_buf, size)) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    if (kstrtoint(tmp, 10, &num_pf_sample)) {
>> +        pr_err("Invalid input for num of page fault samples.\n");
>> +        goto out;
>> +    }
>> +
>> +    ret = size;
>> +
>> +out:
>> +    return ret;
>> +}
>> +
>> +static ssize_t kfd_debugfs_dmrt_write(struct file *file,
>> +    const char __user *user_buf, size_t size, loff_t *ppos)
>> +{
>> +    char tmp[16];
>> +    int ret = -EINVAL;
>> +
>> +    memset(tmp, 0, 16);
>> +    if (size >= 16) {
>> +        pr_err("Invalid input for num of page fault samples\n");
>> +        goto out;
>> +    }
>> +
>> +    if (copy_from_user(tmp, user_buf, size)) {
>> +        ret = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    if (kstrtoint(tmp, 10, &data_migrate_rate_threshold)) {
>> +        pr_err("Invalid input for num of page fault samples.\n");
>> +        goto out;
>> +    }
>> +
>> +    ret = size;
>> +
>> +out:
>> +    return ret;
>> +}
>> +
>> +
>>   static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
>>       const char __user *user_buf, size_t size, loff_t *ppos)
>>   {
>> @@ -99,6 +176,24 @@ static const struct file_operations 
>> kfd_debugfs_hang_hws_fops = {
>>       .release = single_release,
>>   };
>>   +static const struct file_operations 
>> kfd_debugfs_num_pf_samples_fops = {
>> +    .owner = THIS_MODULE,
>> +    .open = kfd_debugfs_open,
>> +    .read = seq_read,
>> +    .write = kfd_debugfs_num_pf_samples_write,
>> +    .llseek = seq_lseek,
>> +    .release = single_release,
>> +};
>> +
>> +static const struct file_operations kfd_debugfs_dmrt_fops = {
>> +    .owner = THIS_MODULE,
>> +    .open = kfd_debugfs_open,
>> +    .read = seq_read,
>> +    .write = kfd_debugfs_dmrt_write,
>> +    .llseek = seq_lseek,
>> +    .release = single_release,
>> +};
>> +
>>   void kfd_debugfs_init(void)
>>   {
>>       debugfs_root = debugfs_create_dir("kfd", NULL);
>> @@ -111,10 +206,15 @@ void kfd_debugfs_init(void)
>>                   kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
>>       debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
>>                   kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
>> -    debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
>> +    debugfs_create_file("hang_hws", S_IFREG | 0600, debugfs_root,
>>                   kfd_debugfs_hang_hws_read, 
>> &kfd_debugfs_hang_hws_fops);
>>       debugfs_create_file("mem_limit", S_IFREG | 0200, debugfs_root,
>>                   kfd_debugfs_kfd_mem_limits, &kfd_debugfs_fops);
>> +    debugfs_create_file("num_pf_samples", S_IFREG | 0644, debugfs_root,
>> +             kfd_debugfs_num_pf_samples_read, 
>> &kfd_debugfs_num_pf_samples_fops);
>> +    debugfs_create_file("data_migration_rate_threshold", S_IFREG | 
>> 0644,
>> +             debugfs_root, kfd_debugfs_data_migration_rate_threshold,
>> +             &kfd_debugfs_dmrt_fops);
>>   }
>>     void kfd_debugfs_fini(void)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 5d7eb0234002..8c9ffb258062 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -39,6 +39,16 @@
>>   #endif
>>   #define dev_fmt(fmt) "kfd_migrate: " fmt
>>   +/* threshold of data migration rate(per second, DMR) per svm range
>> + * in 2MB unit, so 512 is 1GB */
>> +uint32_t data_migrate_rate_threshold = 512;
>
> These global variables should have a proper prefix. svm_... to match 
> the conventions in this file.
>
>
>> +
>> +/* nubmer of most recent page fault related data driver keeps per 
>> svm range
>> + * driver uses them to check how data got accessed after page fault 
>> recovery
>> + * then decide migration scheme for new page fault recoveries.
>> + */
>> +uint32_t num_pf_sample = 20;
>> +
>>   static uint64_t
>>   svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, 
>> uint64_t addr)
>>   {
>> @@ -476,7 +486,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>   static int
>>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>               unsigned long start_mgr, unsigned long last_mgr,
>> -            struct mm_struct *mm, uint32_t trigger)
>> +            struct mm_struct *mm, uint32_t trigger,
>> +            unsigned long* migration_amount)
>>   {
>>       unsigned long addr, start, end;
>>       struct vm_area_struct *vma;
>> @@ -554,6 +565,10 @@ svm_migrate_ram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>                       prange->npages * PAGE_SIZE,
>>                       KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
>>                       node->xcp ? node->xcp->id : 0);
>> +
>> +    if (migration_amount)
>> +        *migration_amount += mpages;
>> +
>>       return r < 0 ? r : 0;
>>   }
>>   @@ -778,6 +793,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>    * @last_mgr: last page need be migrated to sys ram
>>    * @trigger: reason of migration
>>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is 
>> CPU page fault callback
>> + * @migration_amount: return number of pages got migrated after call
>> + *
>
> Extra blank line.
>
>
>>    *
>>    * Context: Process context, caller hold mmap read lock, 
>> prange->migrate_mutex
>>    *
>> @@ -786,7 +803,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>    */
>>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>> mm_struct *mm,
>>                   unsigned long start_mgr, unsigned long last_mgr,
>> -                uint32_t trigger, struct page *fault_page)
>> +                uint32_t trigger, struct page *fault_page,
>> +                unsigned long* migration_amount)
>>   {
>>       struct kfd_node *node;
>>       struct vm_area_struct *vma;
>> @@ -856,6 +874,9 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>               prange->actual_loc = 0;
>>               svm_range_vram_node_free(prange);
>>           }
>> +
>> +        if (migration_amount)
>> +            *migration_amount += mpages;
>>       }
>>         return r < 0 ? r : 0;
>> @@ -881,7 +902,8 @@ int svm_migrate_vram_to_ram(struct svm_range 
>> *prange, struct mm_struct *mm,
>>   static int
>>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>>               unsigned long start, unsigned long last,
>> -            struct mm_struct *mm, uint32_t trigger)
>> +            struct mm_struct *mm, uint32_t trigger,
>> +            unsigned long* migration_amount)
>>   {
>>       int r, retries = 3;
>>   @@ -893,8 +915,11 @@ svm_migrate_vram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, 
>> best_loc);
>>         do {
>> +        if (migration_amount)
>> +            *migration_amount = 0;
>> +
>>           r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>> prange->last,
>> -                        trigger, NULL);
>> +                        trigger, NULL, migration_amount);
>>           if (r)
>>               return r;
>>       } while (prange->actual_loc && --retries);
>> @@ -902,22 +927,179 @@ svm_migrate_vram_to_vram(struct svm_range 
>> *prange, uint32_t best_loc,
>>       if (prange->actual_loc)
>>           return -EDEADLK;
>>   -    return svm_migrate_ram_to_vram(prange, best_loc, start, last, 
>> mm, trigger);
>> +    return svm_migrate_ram_to_vram(prange, best_loc, start, last, 
>> mm, trigger,
>> +                       migration_amount);
>>   }
>>     int
>>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>>               unsigned long start, unsigned long last,
>> -            struct mm_struct *mm, uint32_t trigger)
>> +            struct mm_struct *mm, uint32_t trigger,
>> +            unsigned long* migration_amount)
>>   {
>> +    if (migration_amount)
>> +        *migration_amount = 0;
>> +
>>       if  (!prange->actual_loc || prange->actual_loc == best_loc)
>>           return svm_migrate_ram_to_vram(prange, best_loc, start, last,
>> -                           mm, trigger);
>> +                           mm, trigger, migration_amount);
>>         else
>>           return svm_migrate_vram_to_vram(prange, best_loc, start, last,
>> -                        mm, trigger);
>> +                        mm, trigger, migration_amount);
>> +
>
> Extra blank line.
>
>
>> +}
>> +
>> +/**
>> + * @prange: range structure
>> + * @start: start addr in page of page fault triggred migration
>> + * @migration_amount:  migration data amount in 2MB unit
>> + * @src:   from which page fault happened
>> + * @migration_or_remote: migrate data or remote access
>> + *
>> + * update svm_range->page_fault_data after some pages got
>> + * migrated
>> + *
>> + * need be under svm_range->migrate_mutex protection
>> + */
>> +
>> +void update_pf_migration_data(struct svm_range* prange, int32_t pf_src,
>> +                bool migration_or_remote, unsigned long 
>> migration_amount)
>
> Missing name prefix.
>
>
>> +{
>> +    uint8_t pf_data_index = prange->pf_data_index & 0x7f;
>> +
>> +    lockdep_assert_held(&prange->migrate_mutex);
>> +
>> +    prange->page_fault_data[pf_data_index].ktime = ktime_get();
>> +    prange->page_fault_data[pf_data_index].migration_info =
>> +            MIGRATIOM_INFO(migration_or_remote, pf_src, 
>> migration_amount);
>
> MIGRATION_INFO can only store 16 bits of migration_amount (up to 64K * 
> 2MB = 128GB), but you're passing in an unsigned long that can be 
> bigger than that. If that ever happens, you'll overwrite the "device" 
> field. You need a range check here.
>
>
>> +
>> +    /* check if page_fault_data buf is full */
>> +    if (!(prange->pf_data_index & 0x80) &&
>> +        (prange->pf_data_index + 1 >= num_pf_sample))
>> +            prange->pf_data_index |= 0x80;
>> +
>> +    prange->pf_data_index = (prange->pf_data_index & 0x80) |
>> +                (((prange->pf_data_index & 0x7f) + 1) % num_pf_sample);
>
> Num_pf_samples can be changed through debugfs after the 
> page_fault_data of a range was allocated. That can lead to 
> out-of-bounds accesses. You probably need to store the allocated 
> page_fault_data size in the prange or some other place that can't be 
> changed at runtime to be safe.
>
>
>> +}
>> +
>> +/**
>> + * @prange: range structure
>> + * @hot_device: device who accesses data(by migration or remote)
>> + *            mostly
>
> This is an output parameter and should be documented as such.
>
>
>> + *
>> + * Return:
>> + *
>> + * false: data migration rate is not higher than
>> + * DATA_MIGRATE_RATE_THRESHOLD
>> + *
>> + * true: data migration rate is higher than
>> + * DATA_MIGRATE_RATE_THRESHOLD
>> + *
>> + * return value will be used to decide migration scheme in
>> + * following operations.
>> + */
>> +bool processing_pf_migration_data(struct svm_range* prange,
>> +                   uint32_t* hot_device)
>
> Missing name prefix.
>
>
>> +{
>> +    uint8_t start_index, last_index, next_index, device_idx;
>> +    bool ret = false;
>> +    uint32_t i;
>>   +    /* in nanosecond */
>> +    ktime_t time_last, time_first;
>> +    s64 time_interval;
>> +
>> +    /* in 2MB unit */
>> +    /* data for cpu is saved at MAX_GPU_INSTANCE-th entry */
>> +    uint32_t migration_amount_device[MAX_GPU_INSTANCE + 1] = {0};
>> +    uint32_t remote_amount_device[MAX_GPU_INSTANCE + 1] = {0};
>> +
>> +    uint64_t total_migration_amount = 0;
>> +    uint64_t total_remote_amount = 0;
>> +
>> +    /* page fault data buf is not full */
>> +    if (!(prange->pf_data_index & 0x80))
>> +        return false;
>
> You probably don't need this check. If your buffer was not filled, the 
> time_first will be 0 and your time interval will be very long. So 
> you'll be below the migration rate threshold. Not treating the 
> high-bit special could simplify your handling of the pf_data_index 
> everywhere.
>
>
>> +
>> +    for (i = 0; i < num_pf_sample; i++) {
>> +
>> +        bool is_migrartion =
>> + MIGRATIOM_OR_MAP(prange->page_fault_data[i].migration_info);
>> +
>> +        uint16_t migration_or_map_amount =
>> + MIGRATIOM_AMOUNT(prange->page_fault_data[i].migration_info);
>> +
>> +        device_idx =
>> + PF_DEVICE(prange->page_fault_data[i].migration_info);
>> +        /* convert to array index */
>> +        device_idx = (device_idx != CPU_DEVICE) ? device_idx : 
>> MAX_GPU_INSTANCE;
>> +
>> +        if (is_migrartion) {
>> +            migration_amount_device[device_idx] += 
>> migration_or_map_amount;
>> +            total_migration_amount += migration_or_map_amount;
>> +        } else {
>> +            remote_amount_device[device_idx] += 
>> migration_or_map_amount;
>> +            total_remote_amount += migration_or_map_amount;
>> +        }
>> +
>> +    }
>> +
>> +    *hot_device = INVALID_COMPUTE_DEVICE;
>> +
>> +    /* prange->page_fault_data's next index is prange->pf_data_index
>> +     * it is cycular buff. get start and last entries to cal time(in 
>> nanosec)
>> +     * during which these page faults happened
>> +     */
>> +    next_index = prange->pf_data_index & 0x7f;
>> +    last_index  = (next_index == 0) ? (num_pf_sample - 1) : 
>> (next_index - 1);
>> +    start_index = (next_index == 0) ? 0 : next_index;
>
> This is just next_index.
>
>
>> +
>> +    time_last  = prange->page_fault_data[last_index].ktime;
>> +    time_first = prange->page_fault_data[start_index].ktime;
>> +
>> +    time_interval = ktime_to_ns(ktime_sub(time_last, time_first));
>> +
>> +    /* should not happend as ktime_get is monotonically increasing */
>> +    if (time_interval < 0) {
>> +        pr_warn("Negative time difference detected\n");
>> +        return  0;
>> +    }
>> +
>> +    /* page fault is very intensive, had NUM_PF_SAMPLE page faults
>> +     * in less 1 nanosecond, treat that as 1 nanosecond
>> +     */
>> +    if (time_interval == 0)
>> +        time_interval = 1;
>> +
>> +    /* check migration data rate first*/
>> +    if (total_migration_amount * NSEC_PER_SEC >
>> +        data_migrate_rate_threshold * time_interval) {
>> +
>> +        /* check if there is a significant device */
>> +        for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
>> +            if (migration_amount_device[i] > total_migration_amount 
>> / 2) {
>> +                *hot_device = i;
>> +                break;
>> +            }
>> +        }
>> +
>> +        ret = true;
>> +
>> +    } else if (total_remote_amount * NSEC_PER_SEC >
>> +        data_migrate_rate_threshold * time_interval) {
>> +
>> +        for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
>> +            if (migration_amount_device[i] > total_migration_amount 
>> / 2) {
>
> Did you mean to check remote_amount_device and total_remote_amount here?
>
> I'm not sure why you're treating those separately anyway. I'm trying 
> to imagine what will happen. E.g. device 1 has a lot of page faults, 
> migrates data and becomes the hot_device. Now device 2 has starts 
> having lots of page faults. Because it's not hot and below the 
> threshold at first, it is not migrating and is counted in 
> remote_amount. As long as device 1 keeps faulting enough that it stays 
> above the threshold, device 2 will keep accessing data remotely, even 
> if its rate of page faults is much higher than device 1. Eventually it 
> becomes hot and starts migrating. Now device 1 experiences lots of 
> page faults and so the cycle repeats.
>
> I think with this logic, you're replacing thrashing with "sloshing". 
> Maybe you could call that an improvement, but it's far from ideal.
>
>
>> +                *hot_device = i;
>> +                break;
>> +            }
>> +        }
>> +
>> +        ret = true;
>> +    }
>> +
>> +    return ret;
>>   }
>>     /**
>> @@ -932,6 +1114,7 @@ svm_migrate_to_vram(struct svm_range *prange, 
>> uint32_t best_loc,
>>    */
>>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>>   {
>> +    unsigned long migration_amount_pages = 0;
>>       unsigned long start, last, size;
>>       unsigned long addr = vmf->address;
>>       struct svm_range_bo *svm_bo;
>> @@ -989,10 +1172,21 @@ static vm_fault_t svm_migrate_to_ram(struct 
>> vm_fault *vmf)
>>       last = min(ALIGN(addr + 1, size) - 1, prange->last);
>>         r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, 
>> last,
>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
>> +                    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page,
>> +                    &migration_amount_pages);
>> +
>>       if (r)
>>           pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 
>> 0x%lx]\n",
>>               r, prange->svms, prange, start, last);
>> +    else {
>
> The braces are not needed here.
>
>
>> +        /* When cpu page fault happen always migrate data to sys ram
>> +         * cpu cannot access device ram remotely, record page fault 
>> data
>> +         * migration amount is in 2MB unit, migration_amount_pages is
>> +         * in page. If it is smaller than 2MB, choose 2MB
>> +         */
>> +        update_pf_migration_data(prange, CPU_DEVICE, true,
>> +                    ALIGN(migration_amount_pages, 1UL << 9) >> 9);
>> +    }
>>     out_unlock_prange:
>>       mutex_unlock(&prange->migrate_mutex);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> index 2eebf67f9c2c..160d4c1bd07f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
>> @@ -42,15 +42,23 @@ enum MIGRATION_COPY_DIR {
>>     int svm_migrate_to_vram(struct svm_range *prange,  uint32_t 
>> best_loc,
>>               unsigned long start, unsigned long last,
>> -            struct mm_struct *mm, uint32_t trigger);
>> +            struct mm_struct *mm, uint32_t trigger,
>> +            unsigned long *migration_amount);
>>     int svm_migrate_vram_to_ram(struct svm_range *prange, struct 
>> mm_struct *mm,
>>                   unsigned long start, unsigned long last,
>> -                uint32_t trigger, struct page *fault_page);
>> +                uint32_t trigger, struct page *fault_page,
>> +                unsigned long *migration_amount);
>>     unsigned long
>>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long 
>> addr);
>>   +void update_pf_migration_data(struct svm_range *prange, int32_t 
>> pf_src,
>> +                   bool migration_or_remote, unsigned long 
>> migration_amount);
>> +
>> +bool processing_pf_migration_data(struct svm_range *prange,
>> +                   uint32_t *hot_device);
>> +
>>   #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
>>     #endif /* KFD_MIGRATE_H_ */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 521c14c7a789..c2843836661e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -63,6 +63,8 @@
>>    */
>>   static uint64_t max_svm_range_pages;
>>   +extern uint32_t num_pf_sample;
>> +
>>   struct criu_svm_metadata {
>>       struct list_head list;
>>       struct kfd_criu_svm_range_priv_data data;
>> @@ -303,6 +305,9 @@ static void svm_range_free(struct svm_range 
>> *prange, bool do_unmap)
>>           }
>>       }
>>   +    kvfree(prange->page_fault_data);
>> +    prange->page_fault_data = NULL;
>> +
>>       mutex_destroy(&prange->lock);
>>       mutex_destroy(&prange->migrate_mutex);
>>       kfree(prange);
>> @@ -355,6 +360,14 @@ svm_range *svm_range_new(struct svm_range_list 
>> *svms, uint64_t start,
>>       mutex_init(&prange->migrate_mutex);
>>       mutex_init(&prange->lock);
>>   +    prange->pf_data_index = 0;
>> +    prange->page_fault_data = kvmalloc_array(num_pf_sample,
>> +                         sizeof(struct svm_pf_info), GFP_KERNEL);
>> +    for (int i = 0; i < num_pf_sample; i++) {
>> +        prange->page_fault_data[i].ktime = 0;
>> +        prange->page_fault_data[i].migration_info = 0 | 
>> INVALID_COMPUTE_DEVICE;
>
> This is just INVALID_COMPUTE_DEVICE.
>
>
>> +    }
>> +
>>       if (p->xnack_enabled)
>>           bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>>                   MAX_GPU_INSTANCE);
>> @@ -1068,9 +1081,27 @@ svm_range_split_adjust(struct svm_range *new, 
>> struct svm_range *old,
>>               return r;
>>       }
>>   +    for (int i = 0; i < num_pf_sample; i++) {
>> +        uint16_t old_amount =
>> + MIGRATIOM_AMOUNT(old->page_fault_data[i].migration_info);
>> +        unsigned long temp = (new->last - new->start + 1) * old_amount;
>> +        uint16_t new_amount = temp / (old->last - old->start + 1);
>> +
>> +        /* proportionally devide data amount betwee new and old 
>> pranges */
>> +        new->page_fault_data[i].migration_info =
>> +            (new->page_fault_data[i].migration_info & (~0xffff)) | 
>> new_amount;
>> +
>> +        old->page_fault_data[i].migration_info =
>> +            (old->page_fault_data[i].migration_info & (~0xffff)) |
>> +            (old_amount - new_amount);
>> +
>> +        new->page_fault_data[i].ktime = old->page_fault_data[i].ktime;
>> +    }
>> +
>>       old->npages = last - start + 1;
>>       old->start = start;
>>       old->last = last;
>> +    new->pf_data_index = old->pf_data_index;
>>       new->flags = old->flags;
>>       new->preferred_loc = old->preferred_loc;
>>       new->prefetch_loc = old->prefetch_loc;
>> @@ -2973,6 +3004,8 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>               uint32_t vmid, uint32_t node_id,
>>               uint64_t addr, uint64_t ts, bool write_fault)
>>   {
>> +    unsigned long migration_amount_pages;
>> +    bool migration_or_remote_high;
>>       unsigned long start, last, size;
>>       struct mm_struct *mm = NULL;
>>       struct svm_range_list *svms;
>> @@ -2985,6 +3018,7 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       bool write_locked = false;
>>       struct vm_area_struct *vma;
>>       bool migration = false;
>> +    uint32_t hot_device;
>>       int r = 0;
>>         if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
>> @@ -3135,33 +3169,103 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       size = 1UL << prange->granularity;
>>       start = max_t(unsigned long, ALIGN_DOWN(addr, size), 
>> prange->start);
>>       last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, 
>> prange->last);
>> -    if (prange->actual_loc != 0 || best_loc != 0) {
>> -        if (best_loc) {
>> -            r = svm_migrate_to_vram(prange, best_loc, start, last,
>> -                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>> +
>> +    /* check previous page fault data to decide how to migrate data */
>> +    hot_device = INVALID_COMPUTE_DEVICE;
>> +    migration_or_remote_high =
>> +            processing_pf_migration_data(prange, &hot_device);
>> +
>> +    /* migrated or remote accessing data rate is not high
>> +     * use automatic migration scheme
>> +     */
>> +    if (!migration_or_remote_high) {
>> +        migration_amount_pages = 0;
>> +
>> +        if (prange->actual_loc != 0 || best_loc != 0) {
>> +
>> +            if (best_loc) {
>> +                r = svm_migrate_to_vram(prange, best_loc, start, last,
>> +                        mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> +                        &migration_amount_pages);
>> +                if (r) {
>> +                    pr_debug("svm_migrate_to_vram failed (%d) at %llx,"
>> +                        " falling back to system memory\n",
>> +                         r, addr);
>> +                    /* Fallback to system memory if migration to
>> +                     * VRAM failed
>> +                     */
>> +                    if (prange->actual_loc && prange->actual_loc != 
>> best_loc)
>> +                        r = svm_migrate_vram_to_ram(prange, mm, 
>> start, last,
>> +                            KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, 
>> NULL);
>> +                    else
>> +                        r = 0;
>> +                }
>> +
>> +            } else {
>> +                r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> +                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL,
>> +                        &migration_amount_pages);
>> +            }
>>               if (r) {
>> -                pr_debug("svm_migrate_to_vram failed (%d) at %llx, 
>> falling back to system memory\n",
>> -                     r, addr);
>> -                /* Fallback to system memory if migration to
>> -                 * VRAM failed
>> +                pr_debug("failed %d to migrate svms %p [0x%lx 
>> 0x%lx]\n",
>> +                     r, svms, start, last);
>> +                goto out_migrate_fail;
>> +            } else {
>> +                migration = true;
>> +                /* migration amount is in 2MB unit.
>> +                 * if it is smaller than 2MB, use 2MB.
>>                    */
>> -                if (prange->actual_loc && prange->actual_loc != 
>> best_loc)
>> -                    r = svm_migrate_vram_to_ram(prange, mm, start, 
>> last,
>> -                        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>> -                else
>> -                    r = 0;
>> +                update_pf_migration_data(prange, gpuidx, true,
>> +                            ALIGN(migration_amount_pages, 1UL << 9) 
>> >> 9);
>>               }
>> -        } else {
>> -            r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> -                    KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>>           }
>> +    } else if (hot_device == INVALID_COMPUTE_DEVICE) {
>> +        migration = false;
>> +        /* there is no significant device, use AIP */
>> +        /* no data migration for page recovery
>> +         * the gpu(gpuidx) will access data remotely after map
>> +         * count data amount that this gpu remotely access
>> +         */
>> +        update_pf_migration_data(prange, gpuidx, false,
>> +                     ALIGN((last - start + 1), 1UL << 9) >> 9);
>> +
>> +    } else if (gpuidx == hot_device) {
>> +        /* gpuidx(where page fault happened) is same as hot_device
>> +         * move data to gpuidx gpu by svm_migrate_to_vram
>> +         * it either moves prange to system ram, then 2MB to gpuidx
>> +         * or move 2MB from sys ram to gpuidx vram
>> +         */
>> +        r = svm_migrate_to_vram(prange, gpuid, start, last,
>> +                    mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
>> +                    &migration_amount_pages);
>> +        if (r) {
>> +            pr_debug("svm_migrate_to_vram failed (%d) at %llx, "
>> +                "falling back to system memory\n",
>> +                    r, addr);
>> +            /* Fallback to system memory if migration to
>> +             * VRAM failed
>> +             */
>> +            if (prange->actual_loc && prange->actual_loc != gpuidx)
>> +                r = svm_migrate_vram_to_ram(prange, mm, start, last,
>> + KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
>> +                else
>> +                    r = 0;
>> +        } else
>> +            update_pf_migration_data(prange, gpuidx, true,
>> +                ALIGN(migration_amount_pages, 1UL << 9) >> 9);
>
> This looks like you duplicated a lot of migration and error handling 
> code for different cases. It would be cleaner if you took the 
> hot_device into account in svm_range_best_restore_location. Then the 
> code that does the actual migration wouldn't need to change at all 
> (other than adding calls to update_pf_migration_data).
>
> You're also currently not considering whether the faulting GPU can 
> remotely access the memory in question. 
> svm_range_best_restore_location does consider this in its choice of 
> the best location. Therefore I believe svm_range_best_restore_location 
> is the right place for your policy logic for changing migration 
> decisions based on the migration rates.
>
>
>> +
>>           if (r) {
>>               pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
>> -                 r, svms, start, last);
>> +                         r, svms, start, last);
>>               goto out_migrate_fail;
>> -        } else {
>> +        } else
>>               migration = true;
>> -        }
>> +
>> +    } else {
>> +        /* gpu gpuidx is not hot device, have it access data 
>> remotely */
>> +        update_pf_migration_data(prange, gpuidx, false,
>> +                     ALIGN((last - start + 1), 1UL << 9) >> 9);
>> +        migration = false;
>>       }
>>         r = svm_range_validate_and_map(mm, start, last, prange, 
>> gpuidx, false,
>> @@ -3535,14 +3639,16 @@ svm_range_trigger_migration(struct mm_struct 
>> *mm, struct svm_range *prange,
>>           return 0;
>>         if (!best_loc) {
>> +        /* not count migration amount for prefetch */
>>           r = svm_migrate_vram_to_ram(prange, mm, prange->start, 
>> prange->last,
>> -                    KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>> +                    KFD_MIGRATE_TRIGGER_PREFETCH, NULL, NULL);
>>           *migrated = !r;
>>           return r;
>>       }
>>   +    /* not count migration amount for prefetch */
>>       r = svm_migrate_to_vram(prange, best_loc, prange->start, 
>> prange->last,
>> -                mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>> +                mm, KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>>       *migrated = !r;
>>         return 0;
>> @@ -3599,9 +3705,10 @@ static void 
>> svm_range_evict_svm_bo_worker(struct work_struct *work)
>>               /* migrate all vram pages in this prange to sys ram
>>                * after that prange->actual_loc should be zero
>>                */
>> +            /* not count migration amount for eviction now */
>>               r = svm_migrate_vram_to_ram(prange, mm,
>>                       prange->start, prange->last,
>> -                    KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
>> +                    KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL, NULL);
>>           } while (!r && prange->actual_loc && --retries);
>>             if (!r && prange->actual_loc)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 01c7a4877904..5e6f07eba0c6 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -39,6 +39,31 @@
>>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>>               ((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>>   +/* indicator for cpu device */
>> +#define CPU_DEVICE 0xFF
>> +
>> +/* indicator for invalid device */
>> +#define INVALID_COMPUTE_DEVICE (1 << 30)
>> +
>> +#define GETMASK32(h, l) ((((uint32_t)(~0)) << (l)) & ((uint32_t)(~0) 
>> >> (32 - 1 - (h))))
>> +
>> +#define MIGRATIOM_OR_MAP(migration_info) (((migration_info) & 
>> GETMASK32(31, 31)) >> 31)
>> +#define PF_DEVICE(migration_info) (((migration_info) & GETMASK32(23, 
>> 16)) >> 16)
>> +#define MIGRATIOM_AMOUNT(migration_info) ((migration_info) & 
>> GETMASK32(15, 0))
>
> This use of GET_MASK is not helping readability. It took me two 
> minutes to figure out what this was doing. It's much more obvious and 
> readable to just spell out your masks in hexadecimal. If you do the 
> shift before the AND mask, it's even easier:
>
> #define MIGRATION_OR_MAP(migration_info) (((migration_info) >> 31) & 0x1)
> #define PF_DEVICE(migration_info) (((migration_info) >> 16) & 0xff)
> #define MIGRATION_AMOUNT(migration_info) ((migration_info) & 0xffff)
>
> Also, some typos: MIGRATIOM->MIGRATION.
>
>
>> +
>> +#define MIGRATIOM_INFO(flag, device, amount) (((flag) << 31) | 
>> ((device) << 16) | (amount))
>> +
>> +struct svm_pf_info {
>> +    /* kernel time when page fault happen */
>> +    ktime_t ktime;
>> +    /* enclosing info:
>> +     * 1: data manipulation for page fault recovery: local or remote 
>> access
>> +     * 2: device where page fault happened, use 0xff for cpu
>> +     * 3: data amount involved
>> +     */
>> +    uint32_t migration_info;
>
> Since ktime is 64-bit, the structure size will get aligned to 64-bit 
> anyway. So you may as well make the migration info 64-bit and give 
> yourself more space. To simplify access to the fields, you could also 
> define the elements as separate fields in the struct.
>
>
>> +};
>> +
>>   struct svm_range_bo {
>>       struct amdgpu_bo        *bo;
>>       struct kref            kref;
>> @@ -138,6 +163,11 @@ struct svm_range {
>>       DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>>       bool                mapped_to_gpu;
>>       atomic_t            queue_refcount;
>> +    struct svm_pf_info *page_fault_data;
>> +    /* most significant bit indicates if page_fault_data is full
>> +     * so the max size of page_fault_data is 127
>> +     */
>> +    uint8_t pf_data_index;
>>   };
>>     static inline void svm_range_lock(struct svm_range *prange)
--------------0W7mO5H8NvSdruIE00cjNBqa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Felix:</p>
    <p>This patch uses &quot;data migration rate(per second, DMR)&quot; to decide
      if data migration is too intense already(higher than
      data_migrate_rate_threshold defined at kfd_migrate.c). The data
      migration amount and time are recorded for each page fault that
      already happened. These data are used to calculate DMR(at
      update_pf_migration_data)</p>
    <p>Stopping migration is decided by DMR. When DMR is too high
      migration will be stopped(at processing_pf_migration_data) : all
      data accessing from no-current devices to that range will be
      remote. If it is cpu page fault we need move data to system ram,
      then all following data accessing(from all GPUs) will be remote.</p>
    <p>The hot device is decided<i><b> after</b></i> when DMR is higher
      than a threshold(data_migrate_rate_threshold). The condition is:
      the data migration amount is mostly caused by this device(more
      than 1/2).</p>
    <p>If DMR is lower than&nbsp;data_migrate_rate_threshold the drive still
      uses current migration scheme.</p>
    <p>Let's use thrash happening case to see what will happen with this
      patch: When data keep migrated among devices eventually the DMR
      will be higher than data_migrate_rate_threshold(it can be adjusted
      through debugfs). Then will not migrate data for following page
      faults. Any following page fault will access data remotely. If
      also find there is a device accessed data mostly(again it is after
      DMR is too high) will have data park at this device, all other
      devices need access the data remotely. Then the data will not be
      moved around.&nbsp;</p>
    <p>From your comments below I think you may miss this part of this
      new data migration operation above. So clarify that first.</p>
    <p>The patch also make this scheme dynamic. The DMR is calculated
      with time evolving: the page fault can happen intensively during
      some time, then become relative quietly, then become intensively
      again. Also, the hot device can also be switched to another
      device. This patch keeps checking DMR and hot device dynamically
      to decide when to stop/resume data migration and if there is
      device that driver should give favor to.</p>
    <p>The code changes may seem more. I think we can first check if the
      scheme's ideas above are ok.&nbsp;</p>
    <div class="moz-cite-prefix">On 11/14/2025 7:51 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com">I have
      lots of detailed comments inline, most of which were just made as
      I was reading through the patch. But I want to put my conclusions
      about the overall scheme up top:
      <br>
      <br>
      I think with your logic, you're replacing thrashing with
      &quot;sloshing&quot;. Maybe you could call that an improvement, but it's far
      from ideal.
      <br>
      <br>
      I also think that your logic cannot reliably detect thrashing
      between two devices because one of those devices will always have
      slightly more than 1/2 of the page faults. So one of the devices
      will always be allowed to migrate data, although it would be
      better to leave it in one place that's good for both devices.&nbsp;<br>
    </blockquote>
    As said above the DMR decides if stop data migration. If DMR is
    higher than threshold there will be no migration. If also find hot
    device exists driver gives favor to the device, all other device
    will access the data remotely. There will not data migration when
    thrashing happened. The data is either parked at current location or
    hot device.&nbsp;
    <blockquote type="cite" cite="mid:e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com"><br>
      Your logic in svm_range_restore_pages is also not helping. If you
      had a case of true thrashing and detected it correctly by not
      designating a hot device, things would continue to migrate
      unchanged. So I'm really doubtful that this scheme, as is, would
      meaningfully improve the migration logic in the most problematic
      cases.&nbsp;<br>
    </blockquote>
    hot device does not decide stopping migration. hot device is decided
    after find DMR is too high(hot device can either exists or not) .
    DMR decides stop/resume data migration.&nbsp;
    <blockquote type="cite" cite="mid:e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com"><br>
      On the other hand, I could see regressions on real workloads.
      Imagine a range that's bigger than
      num_pf_samples*migration_granularity. The range is created on the
      GPU first by e.g. hipMallocManaged. Then the CPU is used to
      initialize it, that migrates it to the CPU and makes the CPU the
      hot device. Now the GPU starts the computation, but because the
      CPU is hot, the first few page faults won't migrate the data to
      the GPU. That will cause performance regressions.&nbsp;<br>
    </blockquote>
    <p>Hot device is not decided by a few page
      faults.&nbsp;data_migrate_rate_threshold is the threshold that can also
      be changed by debugfs. DMR uses&nbsp;data_migrate_rate_threshold to
      decide if migration rate is too high. Before driver &quot;think&quot; DMR is
      too high driver still uses current migration scheme that migrates
      data to gpu who accesses the data. Hot device may exists only
      after driver detects DMR is too high.</p>
    <p>As talked above DMR and hot device are decided dynamically with
      time evolving. In this case driver think cpu is the hot device
      after multiple cpu page faults handling the first few gpu page
      faults will use remote accessing from gpus to cpu. With time
      evolving the patch calculates new DMR and decide new hot device
      during each new page fault. When data accessing from gpus is more
      the DMR will be more than the threshold and hot device will not be
      cpu, but a gpu and data will be moved to the gpu.</p>
    <p>This scheme looks at &quot;trend&quot; of data accessing with time
      evolving. If devices access data remotely for a few page faults it
      would not affect performance too much overall. We cannot predict
      accurately which device will access data in future. This patch
      predicts data accessing pattern based on previous data accessing
      samples.</p>
    <blockquote type="cite" cite="mid:e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com"><br>
      Unless I see some data showing an improvement in some realistic or
      contrived scenarios, and negligible performance regressions in
      real workloads, I'm not going to approve this patch.&nbsp;<br>
    </blockquote>
    <p>I did not find real app that demonstrate bad data accessing
      between cpu&lt;-&gt;gpu or gpu&lt;-&gt;gpu. I made test cases
      through kdtest:</p>
    <p>1: trigger data&nbsp; keep moving between cpu and a gpu:&nbsp; the driver
      calculates DMR and decide hot device. Then stop migration after
      DMR is too high, then has all following page faults access data
      remotely.&nbsp;</p>
    <p>2: trigger data keep moving between 2 gpus: same as above,&nbsp; have
      intensive data migrations rate, that stop migration/use remote
      access. Then let test sleep some time, so no page fault happen
      during. Then trigger page faults again. Now DMR is smaller because
      time interval is more but data migration amount is not changed.
      Now data migration happen again and devices access data locally.
      With time evolving DMR becomes high again, then data migration got
      stopped, devices access data remotely again.&nbsp;</p>
    <p>&nbsp; &nbsp; The test repeats the procedure above to simulate page fault
      happening(device access data) frequency became
      high-&gt;low-&gt;high ...., then date migration got
      stop-&gt;resume-&gt;stop... That demonstrates how driver handles
      data accessing locally or remotely based on run time scenario. The
      driver does not have data migration too much that can hang app,
      and have data access locally when there is no much data got
      migrated.&nbsp;data_migration_rate_threshold is used to adjust this new
      data migration behavior.&nbsp;</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com"><br>
      More comments inline ...
      <br>
      <br>
      <br>
      On 2025-10-20 17:24, Xiaogang.Chen wrote:
      <br>
      <blockquote type="cite">From: Xiaogang Chen
        <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
        <br>
        <br>
        Data migration between cpu and gpu or between gpus is a common
        operation at
        <br>
        kfd/svm during page fault recovery. Certainly, it adds overhead
        and consumes
        <br>
        bus bandwidth. So, becomes crucial for compute performance.
        <br>
        <br>
        There are two objectives that are considered mostly during data
        accessing:
        <br>
        <br>
        1: Locality:&nbsp; move data to compute devices local memory which is
        fast.
        <br>
        2: Zero copy: not have data moved, compute devices access data
        remotely.
        <br>
        <br>
        They are usually conflict: local accessing would require data
        copy; avoiding
        <br>
        data copy would have device access data remotely.
        <br>
        <br>
        The new scheme balances the two accessing patterns by using
        statistical samples
        <br>
        that driver records from previous page fault data to predict
        what data accessing
        <br>
        pattern would be for future page faults, then use the prediction
        to handle new
        <br>
        page fault.
        <br>
        <br>
        The scheme behavior is also dynamically adjusted by following
        application data
        <br>
        accessing pattern overtime. The new decision is based on most
        recent page fault
        <br>
        handling data that are saved at a ring buffer.
        <br>
        <br>
        Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 102 ++++++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 212
        ++++++++++++++++++++++-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |&nbsp; 12 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 151
        +++++++++++++---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 30 ++++
        <br>
        &nbsp; 5 files changed, 473 insertions(+), 34 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
        <br>
        index 9bde2c64540f..d495af31fa3c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
        <br>
        @@ -38,6 +38,9 @@ struct debugfs_proc_entry {
        <br>
        &nbsp; &nbsp; #define MAX_DEBUGFS_FILENAME_LEN 32
        <br>
        &nbsp; +extern uint32_t num_pf_sample;
        <br>
        +extern uint32_t data_migrate_rate_threshold;
        <br>
        +
        <br>
        &nbsp; static int kfd_debugfs_open(struct inode *inode, struct file
        *file)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*show)(struct seq_file *, void *) =
        inode-&gt;i_private;
        <br>
        @@ -50,6 +53,80 @@ static int kfd_debugfs_hang_hws_read(struct
        seq_file *m, void *data)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static int kfd_debugfs_num_pf_samples_read(struct seq_file
        *m, void *data)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;number of page fault samples per svm range:
        %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_pf_sample);
        <br>
        +&nbsp;&nbsp;&nbsp; seq_puts(m, &quot;echo 'num' &gt; num_pf_sample to change
        it\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static int kfd_debugfs_data_migration_rate_threshold(struct
        seq_file *m,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; seq_printf(m, &quot;data migration rate threshold in 2MB unit:
        %d\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_migrate_rate_threshold);
        <br>
        +&nbsp;&nbsp;&nbsp; seq_puts(m, &quot;echo 'num' &gt; data_migrate_rate_threshold to
        change it\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t kfd_debugfs_num_pf_samples_write(struct file
        *file,
        <br>
        +&nbsp;&nbsp;&nbsp; const char __user *user_buf, size_t size, loff_t *ppos)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; char tmp[16];
        <br>
        +&nbsp;&nbsp;&nbsp; int ret = -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; memset(tmp, 0, 16);
        <br>
        +&nbsp;&nbsp;&nbsp; if (size &gt;= 16) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Invalid input for num of page fault
        samples\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (copy_from_user(tmp, user_buf, size)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EFAULT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (kstrtoint(tmp, 10, &amp;num_pf_sample)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Invalid input for num of page fault
        samples.\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ret = size;
        <br>
        +
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        +}
        <br>
        +
        <br>
        +static ssize_t kfd_debugfs_dmrt_write(struct file *file,
        <br>
        +&nbsp;&nbsp;&nbsp; const char __user *user_buf, size_t size, loff_t *ppos)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; char tmp[16];
        <br>
        +&nbsp;&nbsp;&nbsp; int ret = -EINVAL;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; memset(tmp, 0, 16);
        <br>
        +&nbsp;&nbsp;&nbsp; if (size &gt;= 16) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Invalid input for num of page fault
        samples\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (copy_from_user(tmp, user_buf, size)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EFAULT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (kstrtoint(tmp, 10, &amp;data_migrate_rate_threshold)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Invalid input for num of page fault
        samples.\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ret = size;
        <br>
        +
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        +}
        <br>
        +
        <br>
        +
        <br>
        &nbsp; static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char __user *user_buf, size_t size, loff_t *ppos)
        <br>
        &nbsp; {
        <br>
        @@ -99,6 +176,24 @@ static const struct file_operations
        kfd_debugfs_hang_hws_fops = {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release = single_release,
        <br>
        &nbsp; };
        <br>
        &nbsp; +static const struct file_operations
        kfd_debugfs_num_pf_samples_fops = {
        <br>
        +&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,
        <br>
        +&nbsp;&nbsp;&nbsp; .open = kfd_debugfs_open,
        <br>
        +&nbsp;&nbsp;&nbsp; .read = seq_read,
        <br>
        +&nbsp;&nbsp;&nbsp; .write = kfd_debugfs_num_pf_samples_write,
        <br>
        +&nbsp;&nbsp;&nbsp; .llseek = seq_lseek,
        <br>
        +&nbsp;&nbsp;&nbsp; .release = single_release,
        <br>
        +};
        <br>
        +
        <br>
        +static const struct file_operations kfd_debugfs_dmrt_fops = {
        <br>
        +&nbsp;&nbsp;&nbsp; .owner = THIS_MODULE,
        <br>
        +&nbsp;&nbsp;&nbsp; .open = kfd_debugfs_open,
        <br>
        +&nbsp;&nbsp;&nbsp; .read = seq_read,
        <br>
        +&nbsp;&nbsp;&nbsp; .write = kfd_debugfs_dmrt_write,
        <br>
        +&nbsp;&nbsp;&nbsp; .llseek = seq_lseek,
        <br>
        +&nbsp;&nbsp;&nbsp; .release = single_release,
        <br>
        +};
        <br>
        +
        <br>
        &nbsp; void kfd_debugfs_init(void)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_root = debugfs_create_dir(&quot;kfd&quot;, NULL);
        <br>
        @@ -111,10 +206,15 @@ void kfd_debugfs_init(void)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_hqds_by_device,
        &amp;kfd_debugfs_fops);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;rls&quot;, S_IFREG | 0444, debugfs_root,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_rls_by_device,
        &amp;kfd_debugfs_fops);
        <br>
        -&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;hang_hws&quot;, S_IFREG | 0200,
        debugfs_root,
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;hang_hws&quot;, S_IFREG | 0600,
        debugfs_root,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_hang_hws_read,
        &amp;kfd_debugfs_hang_hws_fops);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;mem_limit&quot;, S_IFREG | 0200,
        debugfs_root,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_kfd_mem_limits,
        &amp;kfd_debugfs_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;num_pf_samples&quot;, S_IFREG | 0644,
        debugfs_root,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_num_pf_samples_read,
        &amp;kfd_debugfs_num_pf_samples_fops);
        <br>
        +&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;data_migration_rate_threshold&quot;,
        S_IFREG | 0644,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_root,
        kfd_debugfs_data_migration_rate_threshold,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;kfd_debugfs_dmrt_fops);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_debugfs_fini(void)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index 5d7eb0234002..8c9ffb258062 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -39,6 +39,16 @@
        <br>
        &nbsp; #endif
        <br>
        &nbsp; #define dev_fmt(fmt) &quot;kfd_migrate: &quot; fmt
        <br>
        &nbsp; +/* threshold of data migration rate(per second, DMR) per svm
        range
        <br>
        + * in 2MB unit, so 512 is 1GB */
        <br>
        +uint32_t data_migrate_rate_threshold = 512;
        <br>
      </blockquote>
      <br>
      These global variables should have a proper prefix. svm_... to
      match the conventions in this file.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +/* nubmer of most recent page fault related data driver keeps
        per svm range
        <br>
        + * driver uses them to check how data got accessed after page
        fault recovery
        <br>
        + * then decide migration scheme for new page fault recoveries.
        <br>
        + */
        <br>
        +uint32_t num_pf_sample = 20;
        <br>
        +
        <br>
        &nbsp; static uint64_t
        <br>
        &nbsp; svm_migrate_direct_mapping_addr(struct amdgpu_device *adev,
        uint64_t addr)
        <br>
        &nbsp; {
        <br>
        @@ -476,7 +486,8 @@ svm_migrate_vma_to_vram(struct kfd_node
        *node, struct svm_range *prange,
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t
        best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start_mgr, unsigned long last_mgr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long* migration_amount)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addr, start, end;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        @@ -554,6 +565,10 @@ svm_migrate_ram_to_vram(struct svm_range
        *prange, uint32_t best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;npages * PAGE_SIZE,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt;xcp ? node-&gt;xcp-&gt;id : 0);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (migration_amount)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migration_amount += mpages;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r &lt; 0 ? r : 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -778,6 +793,8 @@ svm_migrate_vma_to_ram(struct kfd_node
        *node, struct svm_range *prange,
        <br>
        &nbsp;&nbsp; * @last_mgr: last page need be migrated to sys ram
        <br>
        &nbsp;&nbsp; * @trigger: reason of migration
        <br>
        &nbsp;&nbsp; * @fault_page: is from vmf-&gt;page, svm_migrate_to_ram(),
        this is CPU page fault callback
        <br>
        + * @migration_amount: return number of pages got migrated after
        call
        <br>
        + *
        <br>
      </blockquote>
      <br>
      Extra blank line.
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp; *
        <br>
        &nbsp;&nbsp; * Context: Process context, caller hold mmap read lock,
        prange-&gt;migrate_mutex
        <br>
        &nbsp;&nbsp; *
        <br>
        @@ -786,7 +803,8 @@ svm_migrate_vma_to_ram(struct kfd_node
        *node, struct svm_range *prange,
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; int svm_migrate_vram_to_ram(struct svm_range *prange, struct
        mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start_mgr, unsigned long
        last_mgr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger, struct page *fault_page)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger, struct page *fault_page,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long* migration_amount)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *node;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        @@ -856,6 +874,9 @@ int svm_migrate_vram_to_ram(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migration_amount)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migration_amount += mpages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r &lt; 0 ? r : 0;
        <br>
        @@ -881,7 +902,8 @@ int svm_migrate_vram_to_ram(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t
        best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long* migration_amount)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, retries = 3;
        <br>
        &nbsp; @@ -893,8 +915,11 @@ svm_migrate_vram_to_vram(struct svm_range
        *prange, uint32_t best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;from gpu 0x%x to gpu 0x%x\n&quot;,
        prange-&gt;actual_loc, best_loc);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migration_amount)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migration_amount = 0;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm,
        prange-&gt;start, prange-&gt;last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger, NULL, migration_amount);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (prange-&gt;actual_loc &amp;&amp; --retries);
        <br>
        @@ -902,22 +927,179 @@ svm_migrate_vram_to_vram(struct svm_range
        *prange, uint32_t best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EDEADLK;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; return svm_migrate_ram_to_vram(prange, best_loc, start,
        last, mm, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp; return svm_migrate_ram_to_vram(prange, best_loc, start,
        last, mm, trigger,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration_amount);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; int
        <br>
        &nbsp; svm_migrate_to_vram(struct svm_range *prange, uint32_t
        best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long* migration_amount)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; if (migration_amount)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migration_amount = 0;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; (!prange-&gt;actual_loc || prange-&gt;actual_loc ==
        best_loc)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return svm_migrate_ram_to_vram(prange, best_loc,
        start, last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, trigger, migration_amount);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return svm_migrate_vram_to_vram(prange, best_loc,
        start, last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, trigger, migration_amount);
        <br>
        +
        <br>
      </blockquote>
      <br>
      Extra blank line.
      <br>
      <br>
      <br>
      <blockquote type="cite">+}
        <br>
        +
        <br>
        +/**
        <br>
        + * @prange: range structure
        <br>
        + * @start: start addr in page of page fault triggred migration
        <br>
        + * @migration_amount:&nbsp; migration data amount in 2MB unit
        <br>
        + * @src:&nbsp;&nbsp; from which page fault happened
        <br>
        + * @migration_or_remote: migrate data or remote access
        <br>
        + *
        <br>
        + * update svm_range-&gt;page_fault_data after some pages got
        <br>
        + * migrated
        <br>
        + *
        <br>
        + * need be under svm_range-&gt;migrate_mutex protection
        <br>
        + */
        <br>
        +
        <br>
        +void update_pf_migration_data(struct svm_range* prange, int32_t
        pf_src,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool migration_or_remote, unsigned long
        migration_amount)
        <br>
      </blockquote>
      <br>
      Missing name prefix.
      <br>
      <br>
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; uint8_t pf_data_index = prange-&gt;pf_data_index &amp;
        0x7f;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; lockdep_assert_held(&amp;prange-&gt;migrate_mutex);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data[pf_data_index].ktime =
        ktime_get();
        <br>
        +&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data[pf_data_index].migration_info =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MIGRATIOM_INFO(migration_or_remote, pf_src,
        migration_amount);
        <br>
      </blockquote>
      <br>
      MIGRATION_INFO can only store 16 bits of migration_amount (up to
      64K * 2MB = 128GB), but you're passing in an unsigned long that
      can be bigger than that. If that ever happens, you'll overwrite
      the &quot;device&quot; field. You need a range check here.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; /* check if page_fault_data buf is full */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!(prange-&gt;pf_data_index &amp; 0x80) &amp;&amp;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (prange-&gt;pf_data_index + 1 &gt;= num_pf_sample))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;pf_data_index |= 0x80;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; prange-&gt;pf_data_index = (prange-&gt;pf_data_index &amp;
        0x80) |
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((prange-&gt;pf_data_index &amp; 0x7f) + 1) %
        num_pf_sample);
        <br>
      </blockquote>
      <br>
      Num_pf_samples can be changed through debugfs after the
      page_fault_data of a range was allocated. That can lead to
      out-of-bounds accesses. You probably need to store the allocated
      page_fault_data size in the prange or some other place that can't
      be changed at runtime to be safe.
      <br>
      <br>
      <br>
      <blockquote type="cite">+}
        <br>
        +
        <br>
        +/**
        <br>
        + * @prange: range structure
        <br>
        + * @hot_device: device who accesses data(by migration or
        remote)
        <br>
        + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mostly
        <br>
      </blockquote>
      <br>
      This is an output parameter and should be documented as such.
      <br>
      <br>
      <br>
      <blockquote type="cite">+ *
        <br>
        + * Return:
        <br>
        + *
        <br>
        + * false: data migration rate is not higher than
        <br>
        + * DATA_MIGRATE_RATE_THRESHOLD
        <br>
        + *
        <br>
        + * true: data migration rate is higher than
        <br>
        + * DATA_MIGRATE_RATE_THRESHOLD
        <br>
        + *
        <br>
        + * return value will be used to decide migration scheme in
        <br>
        + * following operations.
        <br>
        + */
        <br>
        +bool processing_pf_migration_data(struct svm_range* prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t* hot_device)
        <br>
      </blockquote>
      <br>
      Missing name prefix.
      <br>
      <br>
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; uint8_t start_index, last_index, next_index, device_idx;
        <br>
        +&nbsp;&nbsp;&nbsp; bool ret = false;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t i;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* in nanosecond */
        <br>
        +&nbsp;&nbsp;&nbsp; ktime_t time_last, time_first;
        <br>
        +&nbsp;&nbsp;&nbsp; s64 time_interval;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* in 2MB unit */
        <br>
        +&nbsp;&nbsp;&nbsp; /* data for cpu is saved at MAX_GPU_INSTANCE-th entry */
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t migration_amount_device[MAX_GPU_INSTANCE + 1] =
        {0};
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t remote_amount_device[MAX_GPU_INSTANCE + 1] = {0};
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t total_migration_amount = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t total_remote_amount = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* page fault data buf is not full */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!(prange-&gt;pf_data_index &amp; 0x80))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
        <br>
      </blockquote>
      <br>
      You probably don't need this check. If your buffer was not filled,
      the time_first will be 0 and your time interval will be very long.
      So you'll be below the migration rate threshold. Not treating the
      high-bit special could simplify your handling of the pf_data_index
      everywhere.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; num_pf_sample; i++) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_migrartion =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        MIGRATIOM_OR_MAP(prange-&gt;page_fault_data[i].migration_info);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t migration_or_map_amount =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        MIGRATIOM_AMOUNT(prange-&gt;page_fault_data[i].migration_info);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_idx =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        PF_DEVICE(prange-&gt;page_fault_data[i].migration_info);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* convert to array index */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_idx = (device_idx != CPU_DEVICE) ? device_idx :
        MAX_GPU_INSTANCE;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_migrartion) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration_amount_device[device_idx] +=
        migration_or_map_amount;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_migration_amount += migration_or_map_amount;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remote_amount_device[device_idx] +=
        migration_or_map_amount;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_remote_amount += migration_or_map_amount;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; *hot_device = INVALID_COMPUTE_DEVICE;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* prange-&gt;page_fault_data's next index is
        prange-&gt;pf_data_index
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * it is cycular buff. get start and last entries to cal
        time(in nanosec)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * during which these page faults happened
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; next_index = prange-&gt;pf_data_index &amp; 0x7f;
        <br>
        +&nbsp;&nbsp;&nbsp; last_index&nbsp; = (next_index == 0) ? (num_pf_sample - 1) :
        (next_index - 1);
        <br>
        +&nbsp;&nbsp;&nbsp; start_index = (next_index == 0) ? 0 : next_index;
        <br>
      </blockquote>
      <br>
      This is just next_index.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; time_last&nbsp; = prange-&gt;page_fault_data[last_index].ktime;
        <br>
        +&nbsp;&nbsp;&nbsp; time_first = prange-&gt;page_fault_data[start_index].ktime;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; time_interval = ktime_to_ns(ktime_sub(time_last,
        time_first));
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* should not happend as ktime_get is monotonically
        increasing */
        <br>
        +&nbsp;&nbsp;&nbsp; if (time_interval &lt; 0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Negative time difference detected\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* page fault is very intensive, had NUM_PF_SAMPLE page
        faults
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * in less 1 nanosecond, treat that as 1 nanosecond
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (time_interval == 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; time_interval = 1;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* check migration data rate first*/
        <br>
        +&nbsp;&nbsp;&nbsp; if (total_migration_amount * NSEC_PER_SEC &gt;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_migrate_rate_threshold * time_interval) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if there is a significant device */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;= MAX_GPU_INSTANCE; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migration_amount_device[i] &gt;
        total_migration_amount / 2) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hot_device = i;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = true;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (total_remote_amount * NSEC_PER_SEC &gt;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data_migrate_rate_threshold * time_interval) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;= MAX_GPU_INSTANCE; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (migration_amount_device[i] &gt;
        total_migration_amount / 2) {
        <br>
      </blockquote>
      <br>
      Did you mean to check remote_amount_device and total_remote_amount
      here?
      <br>
      <br>
      I'm not sure why you're treating those separately anyway. I'm
      trying to imagine what will happen. E.g. device 1 has a lot of
      page faults, migrates data and becomes the hot_device. Now device
      2 has starts having lots of page faults. Because it's not hot and
      below the threshold at first, it is not migrating and is counted
      in remote_amount. As long as device 1 keeps faulting enough that
      it stays above the threshold, device 2 will keep accessing data
      remotely, even if its rate of page faults is much higher than
      device 1. Eventually it becomes hot and starts migrating. Now
      device 1 experiences lots of page faults and so the cycle repeats.
      <br>
      <br>
      I think with this logic, you're replacing thrashing with
      &quot;sloshing&quot;. Maybe you could call that an improvement, but it's far
      from ideal.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hot_device = i;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = true;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; /**
        <br>
        @@ -932,6 +1114,7 @@ svm_migrate_to_vram(struct svm_range
        *prange, uint32_t best_loc,
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; unsigned long migration_amount_pages = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, last, size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addr = vmf-&gt;address;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_bo *svm_bo;
        <br>
        @@ -989,10 +1172,21 @@ static vm_fault_t
        svm_migrate_to_ram(struct vm_fault *vmf)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last = min(ALIGN(addr + 1, size) - 1, prange-&gt;last);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange,
        vmf-&gt;vma-&gt;vm_mm, start, last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
        vmf-&gt;page);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU,
        vmf-&gt;page,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;migration_amount_pages);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d migrate svms 0x%p range 0x%p
        [0x%lx 0x%lx]\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, prange-&gt;svms, prange, start, last);
        <br>
        +&nbsp;&nbsp;&nbsp; else {
        <br>
      </blockquote>
      <br>
      The braces are not needed here.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* When cpu page fault happen
        always migrate data to sys ram
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * cpu cannot access device ram remotely, record page
        fault data
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * migration amount is in 2MB unit,
        migration_amount_pages is
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in page. If it is smaller than 2MB, choose 2MB
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_pf_migration_data(prange, CPU_DEVICE, true,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(migration_amount_pages, 1UL &lt;&lt;
        9) &gt;&gt; 9);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp; out_unlock_prange:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
        <br>
        index 2eebf67f9c2c..160d4c1bd07f 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
        <br>
        @@ -42,15 +42,23 @@ enum MIGRATION_COPY_DIR {
        <br>
        &nbsp; &nbsp; int svm_migrate_to_vram(struct svm_range *prange,&nbsp; uint32_t
        best_loc,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm, uint32_t trigger,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *migration_amount);
        <br>
        &nbsp; &nbsp; int svm_migrate_vram_to_ram(struct svm_range *prange, struct
        mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger, struct page *fault_page);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger, struct page *fault_page,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *migration_amount);
        <br>
        &nbsp; &nbsp; unsigned long
        <br>
        &nbsp; svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned
        long addr);
        <br>
        &nbsp; +void update_pf_migration_data(struct svm_range *prange,
        int32_t pf_src,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool migration_or_remote, unsigned long
        migration_amount);
        <br>
        +
        <br>
        +bool processing_pf_migration_data(struct svm_range *prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *hot_device);
        <br>
        +
        <br>
        &nbsp; #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
        <br>
        &nbsp; &nbsp; #endif /* KFD_MIGRATE_H_ */
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 521c14c7a789..c2843836661e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -63,6 +63,8 @@
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; static uint64_t max_svm_range_pages;
        <br>
        &nbsp; +extern uint32_t num_pf_sample;
        <br>
        +
        <br>
        &nbsp; struct criu_svm_metadata {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_criu_svm_range_priv_data data;
        <br>
        @@ -303,6 +305,9 @@ static void svm_range_free(struct svm_range
        *prange, bool do_unmap)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; kvfree(prange-&gt;page_fault_data);
        <br>
        +&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data = NULL;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;prange-&gt;lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(prange);
        <br>
        @@ -355,6 +360,14 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; prange-&gt;pf_data_index = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data = kvmalloc_array(num_pf_sample,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct svm_pf_info),
        GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; num_pf_sample; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data[i].ktime = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;page_fault_data[i].migration_info = 0 |
        INVALID_COMPUTE_DEVICE;
        <br>
      </blockquote>
      <br>
      This is just INVALID_COMPUTE_DEVICE.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;xnack_enabled)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(prange-&gt;bitmap_access,
        svms-&gt;bitmap_supported,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE);
        <br>
        @@ -1068,9 +1081,27 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; for (int i = 0; i &lt; num_pf_sample; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t old_amount =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        MIGRATIOM_AMOUNT(old-&gt;page_fault_data[i].migration_info);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long temp = (new-&gt;last - new-&gt;start + 1)
        * old_amount;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t new_amount = temp / (old-&gt;last -
        old-&gt;start + 1);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* proportionally devide data amount betwee new and old
        pranges */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;page_fault_data[i].migration_info =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (new-&gt;page_fault_data[i].migration_info &amp;
        (~0xffff)) | new_amount;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;page_fault_data[i].migration_info =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (old-&gt;page_fault_data[i].migration_info &amp;
        (~0xffff)) |
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (old_amount - new_amount);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;page_fault_data[i].ktime =
        old-&gt;page_fault_data[i].ktime;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;npages = last - start + 1;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;start = start;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;last = last;
        <br>
        +&nbsp;&nbsp;&nbsp; new-&gt;pf_data_index = old-&gt;pf_data_index;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        @@ -2973,6 +3004,8 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vmid, uint32_t node_id,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr, uint64_t ts, bool write_fault)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; unsigned long migration_amount_pages;
        <br>
        +&nbsp;&nbsp;&nbsp; bool migration_or_remote_high;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, last, size;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        @@ -2985,6 +3018,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool write_locked = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool migration = false;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t hot_device;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
        <br>
        @@ -3135,33 +3169,103 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = 1UL &lt;&lt; prange-&gt;granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start = max_t(unsigned long, ALIGN_DOWN(addr, size),
        prange-&gt;start);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last = min_t(unsigned long, ALIGN(addr + 1, size) - 1,
        prange-&gt;last);
        <br>
        -&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc != 0 || best_loc != 0) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (best_loc) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_to_vram(prange, best_loc, start,
        last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* check previous page fault data to decide how to migrate
        data */
        <br>
        +&nbsp;&nbsp;&nbsp; hot_device = INVALID_COMPUTE_DEVICE;
        <br>
        +&nbsp;&nbsp;&nbsp; migration_or_remote_high =
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; processing_pf_migration_data(prange,
        &amp;hot_device);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* migrated or remote accessing data rate is not high
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * use automatic migration scheme
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!migration_or_remote_high) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration_amount_pages = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc != 0 || best_loc != 0) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (best_loc) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_to_vram(prange, best_loc,
        start, last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;migration_amount_pages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svm_migrate_to_vram failed (%d)
        at %llx,&quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; falling back to system memory\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fallback to system memory if migration
        to
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VRAM failed
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc &amp;&amp;
        prange-&gt;actual_loc != best_loc)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm,
        start, last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
        NULL, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm, start,
        last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
        NULL,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;migration_amount_pages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svm_migrate_to_vram failed (%d) at
        %llx, falling back to system memory\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fallback to system memory if migration to
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VRAM failed
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to migrate svms %p [0x%lx
        0x%lx]\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, start, last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_migrate_fail;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = true;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* migration amount is in 2MB unit.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if it is smaller than 2MB, use 2MB.
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc &amp;&amp;
        prange-&gt;actual_loc != best_loc)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm,
        start, last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
        NULL);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_pf_migration_data(prange, gpuidx, true,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(migration_amount_pages, 1UL
        &lt;&lt; 9) &gt;&gt; 9);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm, start,
        last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (hot_device == INVALID_COMPUTE_DEVICE) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = false;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* there is no significant device, use AIP */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* no data migration for page recovery
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the gpu(gpuidx) will access data remotely after map
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * count data amount that this gpu remotely access
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_pf_migration_data(prange, gpuidx, false,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN((last - start + 1), 1UL &lt;&lt; 9)
        &gt;&gt; 9);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (gpuidx == hot_device) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpuidx(where page fault happened) is same as
        hot_device
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * move data to gpuidx gpu by svm_migrate_to_vram
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * it either moves prange to system ram, then 2MB to
        gpuidx
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * or move 2MB from sys ram to gpuidx vram
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_to_vram(prange, gpuid, start, last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;migration_amount_pages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svm_migrate_to_vram failed (%d) at %llx,
        &quot;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;falling back to system memory\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fallback to system memory if migration to
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VRAM failed
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc &amp;&amp;
        prange-&gt;actual_loc != gpuidx)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm, start,
        last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_pf_migration_data(prange, gpuidx, true,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(migration_amount_pages, 1UL &lt;&lt; 9)
        &gt;&gt; 9);
        <br>
      </blockquote>
      <br>
      This looks like you duplicated a lot of migration and error
      handling code for different cases. It would be cleaner if you took
      the hot_device into account in svm_range_best_restore_location.
      Then the code that does the actual migration wouldn't need to
      change at all (other than adding calls to
      update_pf_migration_data).
      <br>
      <br>
      You're also currently not considering whether the faulting GPU can
      remotely access the memory in question.
      svm_range_best_restore_location does consider this in its choice
      of the best location. Therefore I
      believe&nbsp;svm_range_best_restore_location is the right place for
      your policy logic for changing migration decisions based on the
      migration rates.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to migrate svms %p [0x%lx
        0x%lx]\n&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, start, last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, start, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_migrate_fail;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = true;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gpu gpuidx is not hot device, have it access data
        remotely */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_pf_migration_data(prange, gpuidx, false,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN((last - start + 1), 1UL &lt;&lt; 9)
        &gt;&gt; 9);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, start, last, prange,
        gpuidx, false,
        <br>
        @@ -3535,14 +3639,16 @@ svm_range_trigger_migration(struct
        mm_struct *mm, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!best_loc) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not count migration amount for prefetch */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm,
        prange-&gt;start, prange-&gt;last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_PREFETCH, NULL, NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migrated = !r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* not count migration amount for prefetch */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_to_vram(prange, best_loc,
        prange-&gt;start, prange-&gt;last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, KFD_MIGRATE_TRIGGER_PREFETCH);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm, KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *migrated = !r;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        @@ -3599,9 +3705,10 @@ static void
        svm_range_evict_svm_bo_worker(struct work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* migrate all vram pages in this prange to sys
        ram
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * after that prange-&gt;actual_loc should be zero
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* not count migration amount for eviction now */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange, mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start, prange-&gt;last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL,
        NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (!r &amp;&amp; prange-&gt;actual_loc
        &amp;&amp; --retries);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; prange-&gt;actual_loc)
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 01c7a4877904..5e6f07eba0c6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -39,6 +39,31 @@
        <br>
        &nbsp; #define SVM_ADEV_PGMAP_OWNER(adev)\
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;hive ? (void *)(adev)-&gt;hive : (void
        *)(adev))
        <br>
        &nbsp; +/* indicator for cpu device */
        <br>
        +#define CPU_DEVICE 0xFF
        <br>
        +
        <br>
        +/* indicator for invalid device */
        <br>
        +#define INVALID_COMPUTE_DEVICE (1 &lt;&lt; 30)
        <br>
        +
        <br>
        +#define GETMASK32(h, l) ((((uint32_t)(~0)) &lt;&lt; (l)) &amp;
        ((uint32_t)(~0) &gt;&gt; (32 - 1 - (h))))
        <br>
        +
        <br>
        +#define MIGRATIOM_OR_MAP(migration_info) (((migration_info)
        &amp; GETMASK32(31, 31)) &gt;&gt; 31)
        <br>
        +#define PF_DEVICE(migration_info) (((migration_info) &amp;
        GETMASK32(23, 16)) &gt;&gt; 16)
        <br>
        +#define MIGRATIOM_AMOUNT(migration_info) ((migration_info)
        &amp; GETMASK32(15, 0))
        <br>
      </blockquote>
      <br>
      This use of GET_MASK is not helping readability. It took me two
      minutes to figure out what this was doing. It's much more obvious
      and readable to just spell out your masks in hexadecimal. If you
      do the shift before the AND mask, it's even easier:
      <br>
      <br>
      #define MIGRATION_OR_MAP(migration_info) (((migration_info)
      &gt;&gt; 31) &amp; 0x1)
      <br>
      #define PF_DEVICE(migration_info) (((migration_info) &gt;&gt; 16)
      &amp; 0xff)
      <br>
      #define MIGRATION_AMOUNT(migration_info) ((migration_info) &amp;
      0xffff)
      <br>
      <br>
      Also, some typos: MIGRATIOM-&gt;MIGRATION.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +#define MIGRATIOM_INFO(flag, device, amount) (((flag) &lt;&lt;
        31) | ((device) &lt;&lt; 16) | (amount))
        <br>
        +
        <br>
        +struct svm_pf_info {
        <br>
        +&nbsp;&nbsp;&nbsp; /* kernel time when page fault happen */
        <br>
        +&nbsp;&nbsp;&nbsp; ktime_t ktime;
        <br>
        +&nbsp;&nbsp;&nbsp; /* enclosing info:
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * 1: data manipulation for page fault recovery: local or
        remote access
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * 2: device where page fault happened, use 0xff for cpu
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * 3: data amount involved
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t migration_info;
        <br>
      </blockquote>
      <br>
      Since ktime is 64-bit, the structure size will get aligned to
      64-bit anyway. So you may as well make the migration info 64-bit
      and give yourself more space. To simplify access to the fields,
      you could also define the elements as separate fields in the
      struct.
      <br>
      <br>
      <br>
      <blockquote type="cite">+};
        <br>
        +
        <br>
        &nbsp; struct svm_range_bo {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kref&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref;
        <br>
        @@ -138,6 +163,11 @@ struct svm_range {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_refcount;
        <br>
        +&nbsp;&nbsp;&nbsp; struct svm_pf_info *page_fault_data;
        <br>
        +&nbsp;&nbsp;&nbsp; /* most significant bit indicates if page_fault_data is
        full
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * so the max size of page_fault_data is 127
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; uint8_t pf_data_index;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; static inline void svm_range_lock(struct svm_range *prange)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------0W7mO5H8NvSdruIE00cjNBqa--
