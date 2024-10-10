Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E27CFC5F7
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 19:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2B510E89F;
	Thu, 10 Oct 2024 19:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKKgqOKv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8D310E89F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 19:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoJ2pcOTRtgIm+molg5slKHu+XPtymQ5/eJHvd1F0QrUtLOtDmVkWw1b4OX/pmmKQOllOmnT87IfsRfVAbjbXXMGS8U0abr85YP5fbgEa2wJkWuo9DCA0FMcuByhYrgMNzf6CSMOZuH00JY1so14vp3a92NHLirtDI4986O25vN1wNfWpmyreeiq+e0sN9sq5MaFouGUMXBTBK1V0yN5oAIEkk7ssRV5dUvVyIF9qFA9zXuPzZPcEcBXpJ3qTqSyPVw+OSek+8olFHI5bmazXc70kLarRx8fdChazGBEAMaLNEe8813PM+c3SSqfkx0ySZgcVY+N7W26uzPFtmKeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vOoPHZxSraMWmeTqifT6Ypj2CbQ1Cwf6c03RfcTuOk=;
 b=UMaW4hT/JFlz0eQ7G9pEW8Li1l17JNM9aSc0cllNFUahdwwKh5wIaCfpZwE/jHVoFslNilFTPHtZ6kHC1zp8tMrJjH4Nf2TObBT8UEeYkMqkmM/tpqtS/FRzbcoWcIAjtUNqG+sJeVTaDd0rO1hg4ke/TNH1DSvN1HhkwKEZnlcOq2zbjaKqPoNnpkWlnzEV39cCyeyoKb2KQ/b4aelpfoV3enE4gymVXdFIa2S0417mIUXBRekqTkNuDzU+MvxQm3EWO3K96Gnt/0dqAorzfKC9RB7Vw9IZooQdObbY2JrAKzyiSJ76ucmFX+egl2euNU7FmqyvXdeKseq45RB0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vOoPHZxSraMWmeTqifT6Ypj2CbQ1Cwf6c03RfcTuOk=;
 b=uKKgqOKvoYWGhV5o2SaCKUKA+FsCV1k0plW9fkLXMpAnGXh6zwNlFRnzpXDkdOiFrAJoDWuT5KwTC+dNeQ1pRVZi9nWuJfKzWU1BO/kcNt54OHn9b31NQPbo+V/w/Jc/JgBb//Fi7FLVGnEOZ6FhaKRnHKA4XLd8HWytYq4n5fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 10 Oct
 2024 19:01:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 19:01:52 +0000
Message-ID: <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
Date: Thu, 10 Oct 2024 15:01:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
 <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: fea1b443-9a26-49f2-f9bb-08dce95e00b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnNoN09JVU5hWTEyM3I1TkMvc0x6M2hpYU5senczV3pXRlBYUm9ockZoREtS?=
 =?utf-8?B?QkZ4bGJBNVJKNFZCNW1PNnI2S3NoSFh6bk51aFM0akNHVUpCTFAzRnhra1lh?=
 =?utf-8?B?dUYxTGxVaFpxSWM1bXl1RlU0c3FGcUEySWFxUERFQlN0TkYxeGtvR0lkZ3RL?=
 =?utf-8?B?MnE1Q0Y5bVN0VFJHdjVCRFJhQ24rZTZjNmlVRWJzY21IUXc0YXlZZ2tlN0F4?=
 =?utf-8?B?bGM2V2dxeHFuY1JySURaaVFnMTlIRWFDMGMzbVVxYXZXUmpXd1c1S0JhUnE4?=
 =?utf-8?B?bW1RdGVrN0oxSVdGQ29sRGxnZzg5L2dQdTZ3dXA3Q1FMMlpRbk1Za1ZYWHlK?=
 =?utf-8?B?cHEzbGpTTHN4dFdPL1JGc2g3QzhyTmthWE5IMWhJc1ljbGxteUF3Sm9nTFJ5?=
 =?utf-8?B?cktaSU5wU2VCVWNMTmFrVW9hZ3ZnNmxLVTVENy9ud1lQeWhPYzNjci95NFVw?=
 =?utf-8?B?UkV3bktpY3VPRC93TUs1cUZpWStRNS9SQVA1VWZDeWd3SkhHRUZsUmhWSFdy?=
 =?utf-8?B?TDJXeTA1L0NaZDVVTFBFZnphN2E2UEY0TjFIMEZUeE9NaWM0MUpQcEhxOUpp?=
 =?utf-8?B?ZkYxcysreTlXa243YVMrRTRsNE92TFBjc21jSjMxNDJ4bzJlMEVjdWxCVFRi?=
 =?utf-8?B?VUpoa3BpQmNkZlQrcUFIRGNkUmdPMi9xZGN3QTJZMEhlNDRYaVhKOXNCL284?=
 =?utf-8?B?bXlFNzRNZDcrSzR2R2EyYkNvcDlVcUpDWFV5MU1YOGVlMWN3Y25wa1YyK0I2?=
 =?utf-8?B?OGdaczlqY3JWdjNzN0FtYWVwSHNBMDN5SWtxZG9NL0tmZTVwWWhMTHNuY0NQ?=
 =?utf-8?B?KzFWYjBwclc0QTJzUEdRb0lqZnU4eVZkMk1JcDlYcVhtZ0FXUmY1OXVra1N4?=
 =?utf-8?B?S2xRai8xMSt6ei9GUmZZZ2VtOGMzK2p6MGhxRkNGdTJ3NjVlV2dhdmJlNUFk?=
 =?utf-8?B?Nis3U2J6ejFxb2VYVUxHQW5yUFExeW5PRXJ5Y1NRL2c3VUJ2U290T0JoLzIr?=
 =?utf-8?B?eUhhTzA2NkMyRE4rc3RFZUtqbDFxREVSQVRoZ0FocTlEd1hEbmx5UXJJVkM4?=
 =?utf-8?B?M3cyV3JQYnBVZ0VOcXRvTHBIWjhEZnptRmxDK2Rlb2J2NGZYZkNGbzd5RVd0?=
 =?utf-8?B?ei9LS1RpcTljOTZhYUhsa1ZBdWlOeWlWWjZOcnF3MnBsWnZJclpQU25nVW41?=
 =?utf-8?B?OWphc1duS1IzdGQ0STlJV3ZtcTNRdWpQdGdLREZWZ0tRQW8xUitPK2VoMUpr?=
 =?utf-8?B?TllLN0VPcXl1d2pwWlpNQ1I3clltNjlRYWRpY1QxdGVBNXVRaitmSlBoZUJL?=
 =?utf-8?B?RkpmMUN2bTIwTHpSUlNyV3ZpTWIvZmI4OWZKOVlvQnRqMUU3Y3EzUkRXazMr?=
 =?utf-8?B?U1ZGVU5DQm5pb2taMXZIZnZUYkdBeFU5RWZCUHJGT3JXUG9LU3NXaWpEZDFP?=
 =?utf-8?B?WGNWenlSTXozdmc2YWE4K3ZZMDFMaVJLYzQzTFlQd0I5SHczMHlxQmUrb2dV?=
 =?utf-8?B?NU1sa3lyMVpsSy9hT2ZrRGxyZXVuWWxFNFFYbEtiMTZUTDNkelhXTEdWd3lp?=
 =?utf-8?B?dFdqOHV0Q0ZsYlY4aS9JdldUN09yYi9GdkpBOFRxd0dVcEF1SDFvQnNjV2Rs?=
 =?utf-8?B?QnRSQUk1b05FVXVMKy9FUDRLWkI3WlBkQUtMZmZBeW9DNTJnWmZWa1lSL1Ew?=
 =?utf-8?B?eW0vejJTdVlBTjdpZ2xzbGJ6VmY3SVpqTDlQR1VyU054ZFJwdzkxa0NRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REV4b1dZekRSdlc0d2xoUUU2b1VBZzQ5eGNQVERzckZUSS9rb1FsWnVoT09M?=
 =?utf-8?B?KzcxTDFucFFYaUdzRzFYcFlzNkttZjBiVzZRYXJhamlxdzFBclBkdWxva05k?=
 =?utf-8?B?bnU0KzVzTXcrd2xsNC96RStwbHJCeDRzWGo2cmVFTkJQZ3lCVmFpZlV1TFFw?=
 =?utf-8?B?UW5tZzRaY2swb2t5RUkyT3lhZmVYVWJVOWljNFk0UnNBUEQwVy9PbHNkTlVS?=
 =?utf-8?B?UWNtblFOUXB2SHJUNFZLc1hjK0xrVU9FLzZrOXlOT09RVWozRjNIejF1VGxx?=
 =?utf-8?B?VkEwRlNzend4VTg5RllnZEVWVXphdGdRVVVadC9WaEJualQ1dFUxNDNZTHVT?=
 =?utf-8?B?Zi81ODlZcU5OdVN4bWFnaHZsM0NnTFBuVUZiSmwrajJERVFiczB6WklDbnh2?=
 =?utf-8?B?VWdVZWF5aDc2cGpqcFpTR2hkVlBCa1RaNzR4Mi9hOHMrU0RJc2FRaThhb3I1?=
 =?utf-8?B?c3l3enR3bDNJcXRhUC9zNEpMMXl3SmdiWm92UjY4b2hoS0JPWWhrbmpwNGZE?=
 =?utf-8?B?SUxLWlZzeUY2N05hWUhCTWFMZWFKQXVYWHVsYUMwL2JicmdNYUdVRU15a0FW?=
 =?utf-8?B?MDNuWUdJNHU1VnJIbWNlSFZ4b2l2MzVxVzk0WmswbXZrQklVUXl1MnE3Q2FO?=
 =?utf-8?B?Y1Z0QzlkRTRVdVQ5THpwSlM5RkNIT0p0SWRiR2ZCVWM5UGtEeVhHc0NPa3Nj?=
 =?utf-8?B?Zmt1alA1QmErWStjSEx5VmZNNE1aTnRweGM5NWVmd0tEa1UrOHg1WTVzMXpQ?=
 =?utf-8?B?ZTE0WlJyV1ZKNjVKTmJsUlBhRkdaWTNsRDc5R3F2TlRJRnJNQnFyUmxHdUFm?=
 =?utf-8?B?c2dTNXpsRTVpMmNqc0JFYUZDRzEwb3VzMENzQlNEN1p5WEM5SEF5cnpLbE40?=
 =?utf-8?B?Tm5RcE4wK3RFQmhBdmZLNkJzNkNOOGdVLzZ3U3krcGhmTFR4dzRwWkw3cWpx?=
 =?utf-8?B?cWFDSENrLzk2eWxFMEhsdDBmL0dmMlpTU1o1ZWRIU1hSVkVyOXpuTUcrTGd0?=
 =?utf-8?B?eW1HM3QyeVk1KzBIRHVGUytlLzIyVWdsTjFNWUprcXM1UEtrYVNkUFoyOFUz?=
 =?utf-8?B?cXpBVzg5RjIwT1BoS1VieG8rMkIrcFE2Vk93d1E0Z2dOMDJNSy9GOU1RWjVn?=
 =?utf-8?B?UUkyVUR1ZjVXemVrYmVlZjRVVG1DNUY4b2FnSnhZYlVBVFJreXRIQTBOT2p6?=
 =?utf-8?B?U2tmekI3L0t0SHpmdm1Va1Y3aWRpRGR5OTZQdzNRc0ptaXpWOHZ4Z2tBQzk0?=
 =?utf-8?B?NHluVjFuRHFxUkE3dEQxbXZTUUQyMXlaMUFTUjBEa2JNYlNOWXZsdGN2VzI0?=
 =?utf-8?B?ZzM1djFJejZGTm12eERJd0RqOGg3S3VWbnhpNUMzMVNrWFJwemxCemdsU1o3?=
 =?utf-8?B?MUJmK0U4bmdYS1ZmZlVKT2w2eUJleng5QXVPZElyMWFISlVyRTMyK0ZqOUN3?=
 =?utf-8?B?RjlLRXhVakYvcWdBdU1jaFd5L2JZZXJBV0xXVjI2YmgxRUMxaWlhY2dKdkk1?=
 =?utf-8?B?a204Yk82ZDl4aGxvd0piNjZ3TUpkQWdCc0lwM0lTZjNlMTNBSkVGZzJIWXh5?=
 =?utf-8?B?Y3dZdUluZlI4ajN1WFRtVHlSUWJvaStaUStOM3Fhdy9ONEFRaE1QdTAzdkJT?=
 =?utf-8?B?Z0R5L3N5MW5vNTFMZjZrODZLSldJVjZtRzNOcVZGd1pRSVd2eFFqejBkT3ky?=
 =?utf-8?B?ZEhxMGx5eFhHcFJJRmxsR3FrUUdKUWZRaUF5b2Urb0xtNzl0bDZ6bTFlOUZy?=
 =?utf-8?B?QmtHcTJ2V0VMUURLYzVHM3VEOEVYL1BKV0pNbDhtR0o0anllVFJjWHNvYUpF?=
 =?utf-8?B?WVYyYzNaeHYvSVlzZlFvTWtqQ3dHOG80ZEhQMm9jWktuSGhOaWI4dnBuNDFo?=
 =?utf-8?B?MFJ5dHkyOFhmdFF4VnFlN041MFVDWit4V21JZGRySzVYc0tiaUpMRURCc3dl?=
 =?utf-8?B?OVRIOFJLMHNFc1ZLQkx4dllMczIyRVpvaTlZdTV6QWYwVzR2VVBjMWdIS3VF?=
 =?utf-8?B?VUplMENyNDVsZTRqcUpiNzRYaE55a0FyaTlrTG4yMXEyUlp3U2lrQ2EvSEVa?=
 =?utf-8?B?VEV1Z3VTMmlZRTJ5UXJBSGsxL0NoRDhIQ3Q5aXBiSkpOTnpRUlk3aFZwYTFV?=
 =?utf-8?Q?kyQ0I073nkK7MkEQOf2/+CtJD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea1b443-9a26-49f2-f9bb-08dce95e00b6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 19:01:52.9212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbzqSibZ/+2wccXoEDNKFeuxdleUyFyCAY/LH8BWLMLmFpcp8ka5VG8J2/hK40ZfUcKB782Zz4qgHDmo68lrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953
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


On 2024-10-09 18:16, Chen, Xiaogang wrote:
>
> On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>>
>> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>>
>>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>
>>>>> kfd process kref count(process->ref) is initialized to 1 by 
>>>>> kref_init. After
>>>>> it is created not need to increaes its kref. Instad add kfd 
>>>>> process kref at kfd
>>>>> process mmu notifier allocation since we decrease the ref at 
>>>>> free_notifier of
>>>>> mmu_notifier_ops, so pair them.
>>>>
>>>> That's not correct. kfd_create_process returns a struct kfd_process 
>>>> * reference. That gets stored by the caller in filep->private_data. 
>>>> That requires incrementing the reference count. You can have 
>>>> multiple references to the same struct kfd_process if user mode 
>>>> opens /dev/kfd multiple times. The reference is released in 
>>>> kfd_release. Your change breaks that use case.
>>>>
>>> ok, if user mode open and close /dev/kfd multiple times(current 
>>> Thunk only allows user process open the kfd node once)  the change 
>>> will break this use case.
>>>> The reference released in kfd_process_free_notifier is only one per 
>>>> process and it's the reference created by kref_init.
>>>
>>> I think we can increase kref if find_process return true(the user 
>>> process already created kfd process). If find_process return false 
>>> do not increase kref since kref_init has been set to 1.
>>>
>>> Or change find_process(thread, false) to find_process(thread, true) 
>>> that will increase kref if it finds kfd process has been created.
>>>
>>> The idea is to pair kref update between alloc_notifier and 
>>> free_notifier of mmu_notifier_ops for same process(mm). That would 
>>> seem natural.
>>
>> What's the problem you're trying to solve? Is it just a cosmetic 
>> issue? The MMU notifier is registered in create_process (not 
>> kfd_create_process). If you add a kref_get in 
>> kfd_process_alloc_notifier you need to kfd_unref_process somewhere in 
>> create_process. I don't think it's worth the trouble and only risks 
>> introducing more reference counting bugs.
>
> It is for making code cleaner or natural to read. mmu_notifier_get is 
> the last call at create_process. If mmu_notifier_get fail the process 
> is freed: kfree(process).  If create_process success 
> kfd_create_process return that process anyway(after create_process 
> kfd_create_process creates sys entries that not affect return created 
> kfd process). The finally result is same that kref is 2: one for kfd 
> process creation, one for mmu notifier allocation.

Currently, when you call kfd_create_process for the first time, it 
returns with kref=2. One reference for the MMU notifier, and one for 
file->private_data.

Subsequent invocations of kfd_create_process when the process already 
exists should increment the kref by one to track the additional 
reference put into the new file->private_data.

If you can come up with a patch that preserves this logic _and makes the 
code simpler and more readable_, I will consider approving it. Also keep 
in mind that your patch would need to be ported to the DKMS branch, 
where there are two different code paths to support older kernels that 
don't have mmu_notifier_get/put.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct 
>>>>> task_struct *thread)
>>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>>       }
>>>>>   out:
>>>>> -    if (!IS_ERR(process))
>>>>> -        kref_get(&process->ref);
>>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>>       mmput(thread->mm);
>>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>> +    if (p) {
>>>>> +        kref_get(&p->ref);
>>>>> +        return &p->mmu_notifier;
>>>>> +    }
>>>>> +    return ERR_PTR(-ESRCH);
>>>>>   }
>>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
