Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF248CEE352
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 21:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8129210E817;
	Wed,  9 Oct 2024 21:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="keUo6KHe";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E7E10E817
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 21:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYqhcEI/vRwZFawuuvUgqThtB8CzGtL+hPJJLDA7ztFQ9E2KIVZKKQL1IC/0WQNDP+ZmI8uLLOxuigBIkPn+a9ysVz44Uj7oYXOFYjWv89fQGbGgqoQYHO1cng5pjSi3XmI5lJPxdFjcflZnsnbEzT1JZS5DkegJE+krnKuyOtoOFkwq0wfk2cfmgRnyZzneRc//hLwZEFCaxt2FUzpAQ+kgYC2Xw3m/xawGXN2U6yhg3FHgy9ByOHaW0cGwBcCSO7MRC4swttwmo2FlZkjyk1ewh0DSBe5G3RL9nIGf6lwadVPlOQtSFv4NjF7C3KlqpWWxdCoLxFcE/JDFR9HwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usumfK9Fo/eGdoMxqqFGleLkCnIlhqWHo1pcBcc8zH8=;
 b=O5mbji9iV8zciQEkQJQs8pcqC+004QefICy6bqz0PhRmAEKWV9SVOyoJKziUAlI/KipEE/nzLW+P6fFAL8ihCmLXNBX2o0woP+7DCnr7jwryYbb50IhkmO7LVl3Qjimk8xBVBBXn8O7zJd6mKlTRrXlXv/QoaoUQtIJH1XSsF1blHEgc98Zk9rUDcq5b09mwpk8AH2gq2ZX/4Ro+AFcIUuk8qgqTHordefui5zxFaFN7pgIIxcdOdzIjY+VCTctsPC72Pcs+U42gYC/NeIq7HL7x8KqqYcloo7wkrq0gsHR0UtuaGk7j8AD6VTmJaOLaIfdfBC2EuOqoAsW9Ngm9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usumfK9Fo/eGdoMxqqFGleLkCnIlhqWHo1pcBcc8zH8=;
 b=keUo6KHe+SM48xm/uQgd8FuJANImo3ORnnHq7tsyOR4Flo+jlJeMTsOXxu6GjhbZxdVqF4tukmGqBMmQs1AqLFgBjrQaY3kMBsVQD7wFKtfSX7zsFx5Jk9oqfwJcE07UqOrvKZmBNB2bTHJ61Sn9MWzvx4Ynw6rJJMivSZXPw5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Wed, 9 Oct
 2024 21:45:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 21:45:58 +0000
Message-ID: <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
Date: Wed, 9 Oct 2024 17:45:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 660853cc-0687-463f-adf1-08dce8abc267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmdBTDhGMHdibkFCRHM2VktlbnV4cUFZaytJUVVzdTkzamo2dEFlcEpvTXJk?=
 =?utf-8?B?bXMzZWNBRWtIWWQ4SFR2QnF6WW9qZkJqNUkxeWlVUzVuUnErSTFkYitPN29l?=
 =?utf-8?B?dXlPektwMVM5K2hCSDdmQk52aXFPY1BaL3RIeklCRFNrMHBPZXpNalorMC9G?=
 =?utf-8?B?bUZhZFVIU25PRXJxQ1hYMCtzWU9NTENRUTBMUzU3eXVuVmRpajQ5VFYzY09k?=
 =?utf-8?B?Vy9RQ1FNcTNabGJHYUpjNE9qdGtOMEdiVXFjV0txdzl0RnFoenE2Q3NWbEhB?=
 =?utf-8?B?VExnZXAvTW11ZytZUHEwVllpbWY2RHNQWVhYMFFPd2RDMGh1MHExOGZFcktx?=
 =?utf-8?B?K0x1REdTY2d1V3RieThXL3hEOWtsd2xQSmxmclZDamhFbVBIUDA1RjY3Y0d2?=
 =?utf-8?B?TEN2NEswRitGZDQ5M21qR2ljbTc0RGNrNWo5SjRIam5SY0I3bDcxWG1yeXYv?=
 =?utf-8?B?OGVFeXh2UjVOekFiWDNZbDBVTDRmZVBsNVJkUG42QkhDTmlBVE1HL2lqWjVM?=
 =?utf-8?B?YXljVXMyZTJacCt1bThOZnllZjZZTkgrS3ZZWFYzSDYxM1pYWENpcStFeEZZ?=
 =?utf-8?B?aTdTRzlDSmRlbG94ay9FOWUyL0VUWis0TllSNzBqOWltZzdPc2MxaFZDNDh3?=
 =?utf-8?B?enJrdG5CQkNnYWIrZStLWE5xWFN4K2J5eXZiL3hnd2FleHcybHNDVm1GVzla?=
 =?utf-8?B?Nm5zTHdrbTJ3bzFnOGN3VzR4bkhwTnBNLzMyN2hndUxmdGpuTGZrSHh6Vm1B?=
 =?utf-8?B?VUxaREExWENpK1F1WHVkbzQrSWNvY1ZhdjltbStVNFhqR1JVNEc0MjNBT2hQ?=
 =?utf-8?B?RHkvU1NUYksvODhLYlpnSURvcGh3RTlvL2lSd1NqMUF0K2xQdmdmV2NweW5V?=
 =?utf-8?B?YXc5cFZ4NGUxN3ZTRFEvSUhxMWxBOUxvSnNSZTBuZGp2b1plRXp5eDBTWkpZ?=
 =?utf-8?B?Zlp4VDlNd1ZGbVd6YVIrb2I0UXJEOWc2ZUFpQUVsTFpTZHFjRjRibExzYXBU?=
 =?utf-8?B?VUx3RzA4bURXTndNOXlYcTMxbjNsRkt6WW01eTRKbkVndVNTZnlQNFdvYzV3?=
 =?utf-8?B?L3JyZmdFOFFEQm85dk1BeUl6KzN2SkY0VFJlVjk4L1JNd3NITENxdzFsSHFv?=
 =?utf-8?B?NWk3YXlXdlRqUi84OC9aMkkzTHNSL0srbkJOc3Y2ejNHbHhMbFZtekh6Mk9E?=
 =?utf-8?B?RE1TOVNzTkZ0cDNlcUQ5QkloQ2FOeEppSDZtMDRoaXRHeEFlVERoTnBIZDd5?=
 =?utf-8?B?NzJSSzBOamxINFE1cVppUWZZU1I0WXFWWU5aeWYvMU1zWjNoaEwrdFVzVi9L?=
 =?utf-8?B?NXF0U1lZQ29vdmRmYUhqMlExWFNkS1RvQ2RXME9BUXRRZlRkdDFocS9jckVa?=
 =?utf-8?B?T0RoMUVCYUhVNjhXNUwvYWRMTFlheER4OWN0MkphZmprdThIYlIxc2dHUC9j?=
 =?utf-8?B?TDVDQzYrWFFKTXE5WDQ5QjlQeVlTMTU2c256V1U5N2twOHVRNTJUVnpIMFgw?=
 =?utf-8?B?eHVmMW9PWFJ0eWNFdTJQakU0RzkrblAyRWhqbHZxVnlHbUF6U0ZObjZOYlBS?=
 =?utf-8?B?VEtNenZlbHExWTN5ME5SYkNKVXNYeDB5Y3dLOW54VWYwN0xGRkVXUlZGRVQ4?=
 =?utf-8?B?Ylp5Q1J6YWRtejJQTmZhYjRlWDVlU1ZRZnpZNkI5OEE1eUJTR25jdjZMbWJW?=
 =?utf-8?B?MkJkNkl0dU93OVVyTExlMXhtVFhqQzZDbEtBdzBDMGNTTWdLTGxtdG5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdqY3lPRloxSVh3YnNvQjM0VUtrUFZpdE4zcmZVdmZHRHlPSllRTnRXYzJl?=
 =?utf-8?B?WnNZa1ZacWU1cnJ6RnN6aDQwSkx5aUxWUW1xSVBqQTBXY3YzR1dMd0pNRVZu?=
 =?utf-8?B?cGorRTFnVVhOdGlHOGVDWHJubHJpa3RpTmthYzNPelVac245TzdzMVVQN0I3?=
 =?utf-8?B?TEZkNHBmZjRNeGFTT0dHRVB1MEgrQ2xnZFd4VmN6Q3Y0VlFkRFYwQUk1dU9M?=
 =?utf-8?B?OGV1ZEZNNEVaR0s4UlpvUmFjZFI3OUY2SXpGcjNMbmFKYXRRNUxuWVQrWGlP?=
 =?utf-8?B?eXV1azhxRDcyQXR0WHB6VFlKMEFkWEQ2ZWgvOFVTSWJpdUVXQmpQNkl5b1hj?=
 =?utf-8?B?ZTJOY2ZRaDROd2xqaU40RjBBNWp1aTI2Slp3U3ZmWlVXYTRWaFhnMms0SFMz?=
 =?utf-8?B?d1VoK1BaZXJ4anU2RlFxVWxrcXkrMmJtVzVmay90YnlsTGtLS28vS2FrRWIx?=
 =?utf-8?B?Tm1hSG43ZTZpcmRUWEpXVmdod0RWa3JST3FxOU9pamk2dFJTWkJMWFZWcnk4?=
 =?utf-8?B?MytwenFEMDhlUEIvUVR2OFBBbVdaVEtXUnVRRTN4NnRjRlFrZmZXanc3ZlNn?=
 =?utf-8?B?VG9pWU5GdERmOVdlNmt5V2Uyd0tqTE40czRiSGFGMlRSYXBJeFdsYlp0Zk9D?=
 =?utf-8?B?MExWTzFXaFlMaXQwdkYxTW84dGsxeVVKV2JROGZvQTc2M0JpRU9SMEVEc0x0?=
 =?utf-8?B?QlVwQTJpZ0lycnlBRFY1SDJpY1RsVWF6d3JDVUk4M1FRbDJmdUtHdFdzSHRo?=
 =?utf-8?B?NWYwU2Z2a3JwNkRaaUI3QytGZm0wMHBvSkJRMEdrZlBGNUhrME1TbjNHSHRQ?=
 =?utf-8?B?TFRmeWxYQzlkVFkwL3BlbHl3UzhrT29RaUhrajBORW1xWFdLdHVRei9kY3RX?=
 =?utf-8?B?Nkp6MjlVejI4Zkw3REJ1WFJKWEU5YnhRTVI5UFcxVU9QbmpoYUhoalNuT3lw?=
 =?utf-8?B?UnhyOFA1dWNCOEVGeThnVUpRbHFmUUEwaGxWalFnd1pKMjFZZmdRN3UzTXlX?=
 =?utf-8?B?WHRqUmlFeStaMlhPRFBpaE5mWmNMWlNaYXhSS2haSDFVSGxGUjFUL2hpaTBU?=
 =?utf-8?B?NjYrVGtsQ0NHcW5LVkl5aU9zZXpNL1lqalNnVWtaL3l3M21sR0lpcWRMeFBv?=
 =?utf-8?B?OThCK2svZ0twTEpKT2FJQmxnWjBIQStkeFBwZWxIT3BIMnBrbHRjSEhNaytj?=
 =?utf-8?B?VTFBNU5HOVAwT01mL21vWXhyZ3ZrQnNjN1ptM1NWamRXUW5XaFRjTXdMMDY2?=
 =?utf-8?B?YTBDNjgrL0lpcmt5SnBRTVNteHdqWVJUQ1FFb21kTUwxaTUrQzRKV0J3Tmt2?=
 =?utf-8?B?cnRQbjQ2OEw3UmZlNVZXcWMyR0RpYWFCYjdtVjFSeDM5K212bFlEby9jbUc3?=
 =?utf-8?B?MkY1VGRjcHdkRWRJWXhNQnNFdDdmeHQ5YXBWQlZsd0N6MFl6OHcvNnRxaUdQ?=
 =?utf-8?B?QitUQVMwTkFFMXVTWXVrR20xcnJsNUNIUW94SEtRUWxRbG1EQXpqSW1xbFVZ?=
 =?utf-8?B?Y2tNRkhra2MvRTBjVWtIQ2tWL1pWdkg4Vy9nZTFna0UzRjBTb3VBdE9TMEU3?=
 =?utf-8?B?UzVaa1R5UDJtZkZyMjRFYUoycFdPNmpUMTBQdmJJblpMby83OHhUaU5KdlZy?=
 =?utf-8?B?cnFTdEdjSTVOc3JKY3BIWis2ZGVnTzJEQmVNMjVWKy8ybkRHSVlSR1IxL2dZ?=
 =?utf-8?B?blRBM2dNbHVpWnFZU0FEZG1iZFRpdDQ5UjkrRW1kWjBob0IxR2dYUWdIR0Jy?=
 =?utf-8?B?T25CSVg3LzRJWS9SSjhvYTlVZkZGR1V1cjdnSmFHUkNWbXA5VmpnaFcrdGlp?=
 =?utf-8?B?NDMzWU42Y0ZZdUZ5OFFqdEhtTm5TR2wyejkyMFl3eUhGeVBQQlZHZytsQWl5?=
 =?utf-8?B?U2VIVlZpSEtXb0k4VXBQWXkwL2U2Ym1HWGdrZzM3dGJNMkxIZjBUbzMzMmU3?=
 =?utf-8?B?UXlFdVEvYXlsSXpuenNrUGdCdmV2bWRpeWMycndFT1pLOFl4NmQ1VEI2NzQ0?=
 =?utf-8?B?dWpVY2pzTCtONkRxQ2xZTFdBU1ZhMnVPVGRQTklLRGdCODZBTjIydDNWTDJ2?=
 =?utf-8?B?NGRST0RJZWUxYk1HUWNUdWhIWFZxS0xtUnlFNXN4QWR4RW5YbE1Fc3hBbnc4?=
 =?utf-8?Q?H9IxWFp/YAMN0U/79+HF7n+Ym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660853cc-0687-463f-adf1-08dce8abc267
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:45:58.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sqm9HEQHsxS+8lTIk10ieOdfHUcGkC6TUxnj67J4AvCPO5/4gGu9Ty4oC0igzms0Yt8uBCJA2M5DuYssjephA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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


On 2024-10-09 17:02, Chen, Xiaogang wrote:
>
> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>
>>> kfd process kref count(process->ref) is initialized to 1 by 
>>> kref_init. After
>>> it is created not need to increaes its kref. Instad add kfd process 
>>> kref at kfd
>>> process mmu notifier allocation since we decrease the ref at 
>>> free_notifier of
>>> mmu_notifier_ops, so pair them.
>>
>> That's not correct. kfd_create_process returns a struct kfd_process * 
>> reference. That gets stored by the caller in filep->private_data. 
>> That requires incrementing the reference count. You can have multiple 
>> references to the same struct kfd_process if user mode opens /dev/kfd 
>> multiple times. The reference is released in kfd_release. Your change 
>> breaks that use case.
>>
> ok, if user mode open and close /dev/kfd multiple times(current Thunk 
> only allows user process open the kfd node once)  the change will 
> break this use case.
>> The reference released in kfd_process_free_notifier is only one per 
>> process and it's the reference created by kref_init.
>
> I think we can increase kref if find_process return true(the user 
> process already created kfd process). If find_process return false do 
> not increase kref since kref_init has been set to 1.
>
> Or change find_process(thread, false) to find_process(thread, true) 
> that will increase kref if it finds kfd process has been created.
>
> The idea is to pair kref update between alloc_notifier and 
> free_notifier of mmu_notifier_ops for same process(mm). That would 
> seem natural.

What's the problem you're trying to solve? Is it just a cosmetic issue? 
The MMU notifier is registered in create_process (not 
kfd_create_process). If you add a kref_get in kfd_process_alloc_notifier 
you need to kfd_unref_process somewhere in create_process. I don't think 
it's worth the trouble and only risks introducing more reference 
counting bugs.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index d07acf1b2f93..7c5471d7d743 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread)
>>> init_waitqueue_head(&process->wait_irq_drain);
>>>       }
>>>   out:
>>> -    if (!IS_ERR(process))
>>> -        kref_get(&process->ref);
>>>       mutex_unlock(&kfd_processes_mutex);
>>>       mmput(thread->mm);
>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>> +    if (p) {
>>> +        kref_get(&p->ref);
>>> +        return &p->mmu_notifier;
>>> +    }
>>> +    return ERR_PTR(-ESRCH);
>>>   }
>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
