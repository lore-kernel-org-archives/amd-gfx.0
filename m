Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAD4D0D7AB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 14:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2A310EB10;
	Fri, 11 Oct 2024 14:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xbjPeem";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0E310EB08
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 14:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRR+27y15K49Gk73E6dun0WsBCvsjviFZi2qNFwuuWs94mQ1xDZixR+Ot4vGvlN3KQZHJPQAMBNtYEcIm5M6U+hyK2A0l97vzKXFyBxVdz2mJRkcpPns52itpW9icPLkFk75kBnRLT0pkkGFDnKA2qju2TaKECwcKiyWmq6cTVROC4RwtDPuQLxZBvItqBVwaKb0mpRyI+RhmTEZDsxg/xRxpbw8UKN6r/SQj7nKy3KMsiDw2DU5na+uuibUZNwlSjBDlFC9jS58dI3zqc7RB40/1ZZDhrCK5BPU8F3p/Y7MxllCjiVA1Au5AEpZ6DgMj7ubKo6tg7yl5oLSxTQtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55msggCxzHz9eVlthWXHErpCPaPPwg15ItagKiyWi+8=;
 b=Sn8Y77ZXZvW+gv6IuWYjdT+dhV3Lz1Srideu30tAobEaUxoAOmVPz5wwtDicvjchC3sQ6OhhatHxQH1uix/qnUKBxT1kO9nDZ8TWGo1YeM9qzBiJhOu37RHTwOSgRwAJbAiJ+S5XYX2EiyHK4JInLRgFXNsHKARx86VYaZ60P0xEzBkET4DuGJu0kqjwEnBA8LcyaUbrM2hEGG62xf0GMd8M0/3cNJoaEyVGkZ3oeFGpKM9cT5ckZ9LEeYMk4B3qDFrGKrjdTWTdzXI0DVm8i0ij5U8CKiWIV2/BT8t5AVB89A5FlIclP5ZGpj3KDM8gBxWTh7XdfUfUF0Ov+Rws2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55msggCxzHz9eVlthWXHErpCPaPPwg15ItagKiyWi+8=;
 b=2xbjPeemgzbm4M4CHnMAsT8czBI6axOV7486EihBjllUTjc2AXBg0xUXPJvNqVMJBi17w9k4weZfk9uYPt/FaWNHE5GzuGwiTnI/p/CV5SByGQcpqzFdwYprCxpaeUFBJDptsddcb6Dg0ffYWAQ3NsUjJ1Zbw8ZLUq4CQQyCE2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Fri, 11 Oct 2024 14:53:44 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 14:53:44 +0000
Message-ID: <f3c4b83d-0fd0-48cd-956a-2e766953fa03@amd.com>
Date: Fri, 11 Oct 2024 09:53:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
 <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
 <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
 <381a4701-1b3d-4bf9-a361-329fd090ba44@amd.com>
 <9445ae2f-9bd2-4bbf-9fbd-789a75a4e9e5@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <9445ae2f-9bd2-4bbf-9fbd-789a75a4e9e5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:d3::19) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 20067b96-2c7e-4da9-b0e0-08dcea04809d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktqQzdFU0tLellSZGtBRFRGb0RTR0xTMk9uSEdRd3BSTDNFNGRKZFhEVWJI?=
 =?utf-8?B?aFQzK2NyUFExVElnclg0ZGpzVU4xY2FwWm8wOE1YS0lTRURaOHp1bzRvRGpt?=
 =?utf-8?B?ODBYYjUwZUFEY0FOanRiUHh6QjNuaEhVYVNsVkphRFV5T3JYeTFyVTVTMWw5?=
 =?utf-8?B?S3R3a0QvVFAwVExPZEJoOGdvY05WTmdBSStBUXU3MHhnQzFGNEZTdVM5d2l1?=
 =?utf-8?B?QkZjUGNLdDhxVitiU2lyZGNzOG0yUlVnQTlVeGFid0ZoaUc1ZFQ1MWdYYmFi?=
 =?utf-8?B?WlRTRjRTS053K084Mmt5N1hnS2FWazFjRUkzOE9hV1Z5NzZEQUJuSnZYS0c3?=
 =?utf-8?B?Vnd2akpEYzY1MWhjbW9kR0xEVGRoMW5GakpwLytDOHZtZXlPMXpVY1EvNG03?=
 =?utf-8?B?N3d0dTdvY3NhZ29ON1c4dFMyNWthbk9KN2oyZ1BmUVc2NWJqWWNSM2lEL3Rt?=
 =?utf-8?B?eFZBdU04RVFBMVY2UVFhSTBvTm9OdjBaT1dGWm9pN2l6enV0NmRtVWc4bmcv?=
 =?utf-8?B?NnBDVFpEZmhuSU5FanFWc0NRN0VEYkFCdHJ2TGZ0VFpYdEhNU0x2RXVhMnlB?=
 =?utf-8?B?Y0tmM2R0M2JlNitOeU10YzdnZmxxcjNLQTl4dThHYnduZkdWNnArVmJUaHVR?=
 =?utf-8?B?RXU0TjNVN0FoTjJtcVhEWFNQaDA2V05ZOHBwbm9PWFAyeFg3ZU9wNnIwa1pQ?=
 =?utf-8?B?QXJJZVhaQ2JlUGQweGFYV2Y0MmtuOG1tSUVCazdFNVJqL1dlaDhjVklQMGJI?=
 =?utf-8?B?Wm9HMnp4OVlpTmxmd2hYOVY1Ly9BTmIvajQycUt5SUtjYXF1cDExM1hyL3Fk?=
 =?utf-8?B?TmxXRkQxbWhEdWIrK3NycDlhQ3V0SE40UzJ0SmZia0k4a1MxSmlEQ2lkeHcy?=
 =?utf-8?B?RGJ1Y0xMWG80bFdsS0IvUVo5RDVMMU13YkFGRkV6OG52bUYzek5UTnJHQWYz?=
 =?utf-8?B?ZjBYY25pVWU3YnpqSG9KMEtvcHZYN3pYM29CcmxUd1AxOFByOHhySW1VMWdz?=
 =?utf-8?B?RWNWS3NjMmZhbUVudnpoOHNoOGhIYWtob2pMQmYyMkNXY1pkQXJ3SzEyV1BU?=
 =?utf-8?B?MjhOalVhZFdtTkV0MnBSeTlmeDdnWVAvRTBsVkg0Tzg4YjFKaVNpQ2NDeVlM?=
 =?utf-8?B?d285OWFScVVGSVRoY0NOQTRpaGd1QjhUZzFKR1lrd0NqdWpXVFFSa245aVov?=
 =?utf-8?B?c25Sb1RsRFZvc0lreHlpUHdxMnovcnNhTlcvNXhqYTdoZlh6bkJ0MzBnQnU2?=
 =?utf-8?B?MEJuMkpYTTRUa01ZZXNOSSt2eFZ3TlBGSE1mb1ZwSVhzemxMbFI3Q0oveXJv?=
 =?utf-8?B?bWtTOVgvbXNXbUdlNXJ4U1BFbSttdGRPUkxBRkIwa1JldFVZRnZ1eW4rZ1Rr?=
 =?utf-8?B?UElSa2J4b2RDdnl0SGYxVWg1OTZQMkpYRVRsQzB3dEtvcG93VFlDSWpyemRn?=
 =?utf-8?B?bmcrcUpwbkZReExESTl6L0NmWmk3R2NaWmZGNDMvWmV6M0RuQndoekRrUU0y?=
 =?utf-8?B?MSs0OGVPbTlRVDJncmUyMHFSejV2NTgrT2FHcVhsK2FQSnd1U2xad2pDRURT?=
 =?utf-8?B?ZHNtcVdzODRFY04xSGlvSzhKNWxrZU5wV3hscGV5VEJ5Vmw2RW9DVjRaSVZz?=
 =?utf-8?B?bEdJNStZZ09vbWRCWlNXUytiUFkwUHJNL1gzS05TRVZaanlKbWNLVEJJSUlZ?=
 =?utf-8?B?SW51MkVlbmFPdm1sQ05Xd0J6SU9MRjNvZWJ1S3pnZ0YwUWh3bUFiUkh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzFqK2FSQThEWFhZaElsamZjcHdKK213ODVlL1FybnZsaHNiRmppaXVWaHZN?=
 =?utf-8?B?ekVhUXExckJBcU5TY1BpK2JKZkt2d2tmQVhtUzVLR1lodlhvbG1yUkQzSTVS?=
 =?utf-8?B?MjFHNnhmTzY1c1Y2Umsyb1FCT1M5cmdmajZ4R2VjdDVGaks1ZlZmNmFVWkoy?=
 =?utf-8?B?WHZCbk1pVS9lUlNDd3FGSU5BTlhncGhzTGJKcHJqYWdhYnJrUTZsZ2c3ZG9T?=
 =?utf-8?B?N1pNUVcwOU9nM0l2L2Y0bjZ4R29HOVdtZFM2SlV0cjBhNlZubWRZSWtHcUs5?=
 =?utf-8?B?cGxTOU13K1JPamJ6QUdYS2lZTmNrbkQzSjVJMmw0d09RTnlMZjFUbGhER0RV?=
 =?utf-8?B?U3NhVURZeVhNRStJUUR6RmdiKy9rRHcrTUwvMC9lUHRYMmlQNEJ1SURaYnFY?=
 =?utf-8?B?anpSajF5dGxrSWhLZHhPZlFZNHMyemxSdTZYbDNWM082dll0MEF0YXdMWjBt?=
 =?utf-8?B?UFNFZnQ1QUY5WmFWMVljNjdnMTEwVjl5aXIrd250TkdsRjZqbmI2bFRGOThZ?=
 =?utf-8?B?SlZ3d0NvRE5ESmVSU25tUndMQysyVkwzM2RSSUpvNy9vVG5NRHhPQTNUbmpk?=
 =?utf-8?B?aU13M1RtRFZBNTJQWXhKUnVGS3ZrTmVNMk1tTko2endUM3dscTVRSjRwSldk?=
 =?utf-8?B?amhBWWQ2ZzRXK3lINHhWZ0hsTy9iNjU3ZjFqNzlQY1orSUs5YXhkc3RqQm5D?=
 =?utf-8?B?OTlKYVZubXhxd1o1bDBINVVZVndDT1VBYWY4WHRGT1JQRXNyZllHcURaTjdQ?=
 =?utf-8?B?L0crOUQ2bUgzSG94Tk9KMXVpL2JIbU8wdVFMSHR2Nzg2L0hKRHlUaFpVNEw0?=
 =?utf-8?B?SERRdk5jMlVJT1NVS3p5WGczRFJIYjNKU2JXOHdPeXhHaUFTdmVhcGNicGRx?=
 =?utf-8?B?NHJQc204ZmVWQ2o4aEZuTS9kU3BQUGhyMHFZNHJVQVRWUS8zRFBwTk5sTmFD?=
 =?utf-8?B?M2crTnd2RUVpTlFVVWpNUGJKOUJaTEIrcG1JUXp3djVoUXZ2WlZVRXArZ3Ix?=
 =?utf-8?B?K2hnTmpqbExDOTZZaDVlTmRXWnVEUkczaE1uTVdEdFlTaWhkenRyOEVjb0Qv?=
 =?utf-8?B?ZDk5blAxRS9CYzJWbUV0NHp3Q2d4R1hJV0w5ZkhFSk1PYVcwZlNFVkxSaUt0?=
 =?utf-8?B?cFkyZHh0akNQcXhxR1licjhhR0FjNWVPSmN2L3NWa0J2UnJ5VWhzWDNVSjVB?=
 =?utf-8?B?ejdYRTcyVTRNZVBHNmsrRzhOVjRETXUzbEdrdFJoMHMwbkozNlUrMmtsbTBL?=
 =?utf-8?B?NElrWFdaVitDb0Q3Y24xMmt0M2xuTGFsbkFCSWt1Tjk4ZFo5R3A0QkROYmUw?=
 =?utf-8?B?MzRFdHhsMDlLM3lwQSs3cUFXbUVuU05jYXhDNFB2TmNPVlZXeEtvNGJIaXds?=
 =?utf-8?B?enlEZ1FTclVGcEkzQlo3emJiYXZCdjlmOW9JVnltL1c2SnphTnRQQ0k2c0VM?=
 =?utf-8?B?VHIvSXFBb2dUeEdLWVRFK2RtdU5PRDZlYVNJcXFiUVptU3d1bzFwdWJBanNH?=
 =?utf-8?B?VnJIMlo2MWU2QVpHZjJZc0RoTVFveSttUWpEWlY3RXBIdWoxaExESm40SWlw?=
 =?utf-8?B?eXR6QSs1L2k3TUxuQkpwQ2xiQnZRb2cxdHNBa2FJMXh3YlNPUWRDOWUrYUpQ?=
 =?utf-8?B?eTJHMWVMZmtLRTF2ZS9jODRsSTBkc2JjeFNKOFhOTkp4em9uYzB1NndzQ1dY?=
 =?utf-8?B?MWVYR2t0TGZHVWpBbGNCdXUyc0NadXB1N0svdTRDUUhhVlN2NzFuYlg0UEd4?=
 =?utf-8?B?T1BhQWc5b2dhZGIzVTlBUVR5V3VHOW5GVU5pME5kTzFFWFdBWURHYXY3QXBR?=
 =?utf-8?B?U0E5OXFqTmpzTStiVGF4QkZQcXg1RXVtS3FRNWgxdThUQjd5cFpSVG5qUHdy?=
 =?utf-8?B?QnYyZGtudnAxUDA5ZFZNWCsxTnVzV2dXampKYXdDdGdBV0tCZktIVU1rSE9W?=
 =?utf-8?B?L01lb1ZsaVZYTmRsWmxySDdCd2VGUXBMb0ZScWhaNTJyeUpkSW9HMlZxcmlO?=
 =?utf-8?B?MS94QXpVOGJ4NlpONFMzZ2NmU0hKb010WUVZMHhlbEg4WjREN05UVXNVWDFI?=
 =?utf-8?B?L1FHc3JCQ0hqcWo5eTVyem45V25jOGdLM1FQN1VkRjJzR3RIdUgrQTVzTCtK?=
 =?utf-8?Q?g+3s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20067b96-2c7e-4da9-b0e0-08dcea04809d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:53:43.9757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2M4bKrz88YeHFVOsBTfS6QGLkbxzQDsRMz3ZO0j48TRihEKg0qjt1Z60J58CUpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314
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


On 10/10/2024 3:37 PM, Felix Kuehling wrote:
> On 2024-10-10 16:19, Chen, Xiaogang wrote:
>>
>> On 10/10/2024 2:01 PM, Felix Kuehling wrote:
>>>
>>> On 2024-10-09 18:16, Chen, Xiaogang wrote:
>>>>
>>>> On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>>>>>
>>>>> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>>>>>
>>>>>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>>>>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>>>
>>>>>>>> kfd process kref count(process->ref) is initialized to 1 by 
>>>>>>>> kref_init. After
>>>>>>>> it is created not need to increaes its kref. Instad add kfd 
>>>>>>>> process kref at kfd
>>>>>>>> process mmu notifier allocation since we decrease the ref at 
>>>>>>>> free_notifier of
>>>>>>>> mmu_notifier_ops, so pair them.
>>>>>>>
>>>>>>> That's not correct. kfd_create_process returns a struct 
>>>>>>> kfd_process * reference. That gets stored by the caller in 
>>>>>>> filep->private_data. That requires incrementing the reference 
>>>>>>> count. You can have multiple references to the same struct 
>>>>>>> kfd_process if user mode opens /dev/kfd multiple times. The 
>>>>>>> reference is released in kfd_release. Your change breaks that 
>>>>>>> use case.
>>>>>>>
>>>>>> ok, if user mode open and close /dev/kfd multiple times(current 
>>>>>> Thunk only allows user process open the kfd node once)  the 
>>>>>> change will break this use case.
>>>>>>> The reference released in kfd_process_free_notifier is only one 
>>>>>>> per process and it's the reference created by kref_init.
>>>>>>
>>>>>> I think we can increase kref if find_process return true(the user 
>>>>>> process already created kfd process). If find_process return 
>>>>>> false do not increase kref since kref_init has been set to 1.
>>>>>>
>>>>>> Or change find_process(thread, false) to find_process(thread, 
>>>>>> true) that will increase kref if it finds kfd process has been 
>>>>>> created.
>>>>>>
>>>>>> The idea is to pair kref update between alloc_notifier and 
>>>>>> free_notifier of mmu_notifier_ops for same process(mm). That 
>>>>>> would seem natural.
>>>>>
>>>>> What's the problem you're trying to solve? Is it just a cosmetic 
>>>>> issue? The MMU notifier is registered in create_process (not 
>>>>> kfd_create_process). If you add a kref_get in 
>>>>> kfd_process_alloc_notifier you need to kfd_unref_process somewhere 
>>>>> in create_process. I don't think it's worth the trouble and only 
>>>>> risks introducing more reference counting bugs.
>>>>
>>>> It is for making code cleaner or natural to read. mmu_notifier_get 
>>>> is the last call at create_process. If mmu_notifier_get fail the 
>>>> process is freed: kfree(process). If create_process success 
>>>> kfd_create_process return that process anyway(after create_process 
>>>> kfd_create_process creates sys entries that not affect return 
>>>> created kfd process). The finally result is same that kref is 2: 
>>>> one for kfd process creation, one for mmu notifier allocation.
>>>
>>> Currently, when you call kfd_create_process for the first time, it 
>>> returns with kref=2. One reference for the MMU notifier, and one for 
>>> file->private_data.
>>>
>>> Subsequent invocations of kfd_create_process when the process 
>>> already exists should increment the kref by one to track the 
>>> additional reference put into the new file->private_data.
>> one ways is changing find_process(thread, false) to 
>> find_process(thread, true) at kfd_create_process. When kfd process 
>> already exist find_process will call kref_get(&p->ref);
>>>
>>>
>>> If you can come up with a patch that preserves this logic _and makes 
>>> the code simpler and more readable_, I will consider approving it. 
>>> Also keep in mind that your patch would need to be ported to the 
>>> DKMS branch, where there are two different code paths to support 
>>> older kernels that don't have mmu_notifier_get/put.
>>>
>> At DKMS branch alloc_notifier and free_notifer either exist together 
>> or both not exist. So when HAVE_MMU_NOTIFIER_PUT is defined(new 
>> kernel) it is ok.
>>
>> #ifdef HAVE_MMU_NOTIFIER_PUT
>>         .alloc_notifier = kfd_process_alloc_notifier,
>>         .free_notifier = kfd_process_free_notifier,
>> #endif
>>
>> but when HAVE_MMU_NOTIFIER_PUT is not defined we need change 
>> kfd_process_destroy_delayed since since it call kfd_unref_process(p);
>>
>> static void kfd_process_destroy_delayed(struct rcu_head *rcu)
>> {
>>         struct kfd_process *p = container_of(rcu, struc 
>> mmu_notifier_registert kfd_process, rcu);
>>
>>         kfd_unref_process(p);
>> }
>>
>> That means if port this patch to dkms branch when 
>> HAVE_MMU_NOTIFIER_PUT is not defined(old kernel) we do not need call 
>> kfd_process_destroy_delayed or remove mmu_notifier_call_srcu(&p->rcu, 
>> &kfd_process_destroy_delayed)  at 
>> kfd_process_notifier_release_internal. I think that make thing 
>> simpler for old kernel.
>
> No, we still need to destroy the kref that belongs to the process when 
> the mm_struct is destroyed. We can't do that in 
> kfd_process_notifier_release_internal because it leads to LOCKDEP 
> issues. So we still need kfd_process_destroy_delayed.

For old kernel we use mmu_notifier_register that does not update kfd 
process kref. It register process->mmu_notifier to mmu. The release 
function of process->mmu_notifier got called when mm structure got 
destroyed.

The new kernel uses get/put flow. At kfd process creation we use 
mmu_notifier_get that calls alloc_notifier. So this patch increases kfd 
process kref at alloc_notifier since mmu refers kfd process and we 
already decrease the kref at free_notifier.

For old kernel, when port this patch to dkms branch we either do not 
decrease kfd process kref during mm destruction since we did not 
increase kfd process kref during creation, or  manually increase this 
kref after  mmu_notifier_register, then keep kfd_process_destroy_delayed.

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>>
>> So it needs additional handling for old kernel on dkms branch. I do 
>> not know who port patch to dkms branch, or I should change that on 
>> dkms branch.
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Regards
>>>>>>
>>>>>> Xiaogang
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>   Felix
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>>>>> ---
>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>> @@ -899,8 +899,6 @@ struct kfd_process 
>>>>>>>> *kfd_create_process(struct task_struct *thread)
>>>>>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>>>>>       }
>>>>>>>>   out:
>>>>>>>> -    if (!IS_ERR(process))
>>>>>>>> -        kref_get(&process->ref);
>>>>>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>>>>>       mmput(thread->mm);
>>>>>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>>>>>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>>>>> +    if (p) {
>>>>>>>> +        kref_get(&p->ref);
>>>>>>>> +        return &p->mmu_notifier;
>>>>>>>> +    }
>>>>>>>> +    return ERR_PTR(-ESRCH);
>>>>>>>>   }
>>>>>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
