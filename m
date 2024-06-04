Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79299C27C52
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 17:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62C510E59C;
	Tue,  4 Jun 2024 17:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFAVBQRO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA07210E59C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 17:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpQpCwZIHdvXO26dwBiKXsxF6hV5q2emRtaVvUOIN5AHjTlC1AXFyXMRuLWOPg+GwsL+icfI7hbBRVXa9FB5S+P1nxu+rie3kX/1vhxzyiJKLqDa8loOSXgoph11euL6lHUprBdryIhY37dm4EoFAQTcuwxhiB7/GSscVjyfqml+4dGH65YUncnUcKwg5Ba/vq3rE4+0j1QGNobFnlwTC22xuJ2sR7yE0hRkANDv02rkr4yfuVmreYZpF7QUy5wS6J+O4Iq7fCVeeGwVarCYsH5rp0BsAUvZN76val7cNZj3dZ+LDQDR6xA6c6Rm0t+9DfP/WRyF4che6z00HwwoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alDgKYRBEoAYq0Fx+nBtxTCvnaxwNMutsbtE+bm0nDE=;
 b=Jau3MspPEcDQjr4cHhXB4cXvyPeDKkN0owvWmOBw8pGqRuZJIsEEIttymMhPYCaJZXJUWMcSJLOqa922f+A+8nV9Q2iWJDtgqvdWRIwAeeypeVvLXv6mAgHEbJ/KH9qmpByjmGwgNbVSjbQ2mmZRhWWRhwG1NqaQlm4u5Rm6UW987KiN1iNquzvEsF0OQMQYuMKh3Nxqd0HxuKy38o7v3zsp8PGN/q74bav0G0vyv5zyjHNzf0eGlrZ0uU6MT9vQf2XP9I6aIh9qRe5K4pJaStV8gpqB9nnTBcoyPnJQ7F6Lji+/JPUcU3IKCkM1NrLDHwWOVlEDY5rodj/4YIUH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alDgKYRBEoAYq0Fx+nBtxTCvnaxwNMutsbtE+bm0nDE=;
 b=YFAVBQROWnAsWO0t9LDgbP3EURMs2H5oMMJPP9PdibSNdNSGbhKgGuufIOo/DSpHcVfZjOr8QP74A5XNu9mjFcCgMHO9uFhNSjL1EmKeRViF15GGcvqSoe77mbN+/fI7GzYEULHTPxtQqGP72Q28qELH7aTfag734JhbBnzRJLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 17:50:38 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:50:37 +0000
Message-ID: <36c75f1e-49f1-4e0f-b363-d5e09b21c16d@amd.com>
Date: Tue, 4 Jun 2024 13:50:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: avoid large on-stack structures"
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: arnd@arndb.de, alexander.deucher@amd.com, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, jerry.zuo@amd.com
References: <20240604174504.725893-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240604174504.725893-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::18) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d58980-f500-4281-b290-08dc84bed723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWNOMXE5anNtVkdtT3dSNWJ6dnBRWGcvVVdnQ0IyTytQeFJqdHd3WjZ1Zm9U?=
 =?utf-8?B?eEJzbjIweEkwRDR6WEdZUTIxNnR4RlU4bkk2ZnJIRzU1eGcrVDNrZHI0YmY1?=
 =?utf-8?B?TDVqYzd3R0x6b2xGdXdsVGZIdzVyZ3dCUXNTai8xK1hpN3YwcFhJUnVZSE5u?=
 =?utf-8?B?R3pHL3R2d2lUTzVZM3FlQlJVOGUrSjF2SGhQNnRONmNRUTZxMUV2aldKbUlB?=
 =?utf-8?B?alNCMUtKM0Q5UlVFdmJCMFA5eVM2MUZwcU9ISFh0ZzdPZ0VzKzgzK1FtR3pG?=
 =?utf-8?B?YVFWTnBYUERYWE9xT3BWYXo5U0t3K2JYTDhlV1A3Ky8yWkFHTkJMS3N1bG5X?=
 =?utf-8?B?eElWaVRVRGwvUWFLUmNDc3F1MTlBcFl1cDNNNGpXcm9YM1NCaSt0Y2FuRXp1?=
 =?utf-8?B?alZOOG9zV3dwTk11WlFsVWNvcnIvc0NoQVAzeElHMVljWjBla3IxQ2VLQ0ZO?=
 =?utf-8?B?YTNEbCtZQ0pkaXp4eVZQS1I0QVVtaVpsR1kvdHQ4Q2dvVm8rYmhQUlhtZUE3?=
 =?utf-8?B?c09QRmF0MVB5VGZNTnNlWStYN3ZxNzhWcFRRdndlMkJMSmpFRVNZZ1NESEhC?=
 =?utf-8?B?Z25WK3hoZGZhNEQ5S1BlV3ZQNU9XUlhqaHY3UmJRcHNTVVRVRlJVSG41RzFU?=
 =?utf-8?B?eHFLVTFVQUFWODQxVUpCVTMzZjBEMEEwZXI2SEZEV01vR1g3RzQzMkowaDdJ?=
 =?utf-8?B?Z0xTL1NtQUc4ZHJrZ0RIYmQyWmNtdW95THZJYzEzQndOM1VZWmg2RlhWL0pG?=
 =?utf-8?B?eXk5azUreXp5dTFiTk8yY3lOTW0xdHAycE1GUHV0MGV4Ym90dGJVb3p0SnhO?=
 =?utf-8?B?c01EVmR1S1J6ZmRiNCszOEFGc0U4VU1GdFA1bWlpYUJRS1lBZllnUU9qaVIx?=
 =?utf-8?B?emY3VGRyY0IwTlJlNFdWV0d3czk0Y2NQb1dCREsrdDhTTmI5Ykw1Mnlqcjdy?=
 =?utf-8?B?TjJyNUFQMWMwbnlSSzlOKzdnbEJ6WHROL3RPWndrV0JzendwN1JEV2REdzVO?=
 =?utf-8?B?bEdsVTBNNzlpYUNzQmN4MmRuTmNTbnd5M3BBeXRBT2dIRnViWWJnem1SOW1R?=
 =?utf-8?B?WlVmS3RpTTdNTGpxVkUweTJSTjRreVZjRmdlNWwrVS9sNFdqc1AzWEt3QnAv?=
 =?utf-8?B?N2l5MXFQazFRbGhkSlArVTVZUTdDYU50ekxibWFQZy9VaWdJVUtIWVFQem51?=
 =?utf-8?B?NGdGK2JpWlhQYVFrYnpvT2szd3BJUk9oL3l0Y25IakN6S3dNWExTRjJLVXMv?=
 =?utf-8?B?bStQb0YrQitNUGlQNG9iVklBMEIvSmFTNy9NYXJkeWYxYTYrM1RzY2RDN0NK?=
 =?utf-8?B?dFVrNG5GUURORlJuWVlWNVQycEh6ZDFaNnRKQnpKU1h2RTlKQlJiV3BEcVQ4?=
 =?utf-8?B?c2pmdktIUEZQVExNN1pxNkVLVm55VE8vamxJZkxwdmJsczRPdnFqaFZTVGYy?=
 =?utf-8?B?MjJmNXQrTlVIbkM1bUJuKzFEdW1aY1ZINWJLMzkvUTlISFpabzBqQVVyU3pU?=
 =?utf-8?B?VEYyYTd3V3czYUJnV0p1UUFvb0NlUGZhTTNQeG9WQm9FdWRkeDZOd1lZWUxY?=
 =?utf-8?B?VkRJcmswdEYyMlkwQWgzVHBuY0lTQ05GNVRaYk5odEdmN1k0Uk9Vc0JCdTc2?=
 =?utf-8?B?eDlWYi9JUkozNVBzRlF3TE5sZ0JXVWpQVE9HaEM5aVI5VGdyTnF0aGl4Y3dl?=
 =?utf-8?Q?+Uygg/ywkmtOmICCG9z8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RDKzc0V2ZnMVN0dnFmNEg4U3VDRTZPM3BZZjVaOWN0dGxZdDhKVHFSR0tu?=
 =?utf-8?B?V2ZwTmVodkdYTjhEN0Mwc1FodUV2Uk9BTnVKZndGTTNxQnNybGdNQ1lCdkFy?=
 =?utf-8?B?bzFFRFJMREpuMUkrRFNoZjZsNHR4R0hpa2pIY0Ntand5NFZiZHhHYVd4R2lV?=
 =?utf-8?B?MUIzM3ZEdDdHSWswSjNweVZDWGpwT2NoRDREdFREaTM0VGs1UnEyWHMwdjZW?=
 =?utf-8?B?d012SDlLM09jWGFVa2EyQnlkTFZUbFFIalBkOGJLcVBuY3NEblJQQVNTcm1L?=
 =?utf-8?B?K0NWRkE2ZGNlc2c4OWovYUtOemgyTU1BUE9mZVFNVGM5dlRKOW9rWndxOUNN?=
 =?utf-8?B?SEpGN3dUZGllOXdRTndkS1pJbVd1a3hFM2wwNzFIM20zamFjVGh0Y2p6WHBO?=
 =?utf-8?B?NEYyYVdtbWZ5NkR4VTJYNjRYb2lVU0R4ZDh5WkpnalE2TDVoUXh6LzNkbXJi?=
 =?utf-8?B?NDNScllMdkhFenp0ZkhTWGJmQ1NBMFltUTV1MWg5SUVya0lEYVFLUXpHWFFn?=
 =?utf-8?B?Q3hPazRxVGNiR2JBUXFLQjRiU3UrRE5Ed3EvUjR2UTVjUG0vM3hjbGRndERn?=
 =?utf-8?B?RjNkUGlDOElqK3BZanZzSlpxTzVMUHk1UFJKQWladkZDRk41R3FzM3pUeUlz?=
 =?utf-8?B?dzUwWWJtOUw0cVpCa3pKQmRWTjlQdUk5ZHZUa1FUb2x2K2xBa0hVUWFaVnVF?=
 =?utf-8?B?VTV6cXk0RjhhNUYwWGVUdDg1RUFDaFdncUVXS050SmhIQU9RVVQ4UGoydzEz?=
 =?utf-8?B?V0pQelZHcTZxS1N0NjFzZXJPYk5acy9NTlptZitPNkQ4Y0hid24zOExUc1FG?=
 =?utf-8?B?b3FzVXAzU05ubkJGNE1OcWFxRWlnbXVGak9YbHlwUEtManN4SzVkQzgrN1N4?=
 =?utf-8?B?VEpuTjJlUXczdk9aMjQ2OFlSd0VVakJNNko1RUErY2liNDBCU2JyUzVCNzQ5?=
 =?utf-8?B?KzJ1MzBkczlNWi9VRXBuUnBhQnBqK0xlMlpTSlRsL3VETWV2VCtxY1VkWCsy?=
 =?utf-8?B?VnJSejZrUkVmblZTaFlBaHhGUkVSRFV5cTVTaWlOYXhTVWxFcDIzMDVPVlRk?=
 =?utf-8?B?VEs5Rjk2VHBmSDRGNkMxQTBnTGFnRUZPdFV0TE1OREpRYnpNUUlhRm5pcDNu?=
 =?utf-8?B?MGtaSHpROVBLakltNTJnSDArWUh1ZzVMUEIweTJ4ckg2SHZwRXprdUpDRjVj?=
 =?utf-8?B?RjJZSGE5c05VU3h4RzFpMEJKazZFS0FZb3lUMytCNmMzQ2FPM3NrbmdpMXQy?=
 =?utf-8?B?U29YMTV1Q0xZV2JmOFMwYzNJMm0wV2ltcnhmL3dCSlM0RjVOd1Fad2xXc1JN?=
 =?utf-8?B?SGdWbDZnNXByL3luWm9rSk5XZzVqb25yU3lVdk04ZGJLbTFyU2NPMUI0MFpU?=
 =?utf-8?B?TFYxb3dKUnBQZ0ZZaEkyZVRMWG9EdVJoK0tkNDVoSStVTitrZ1BEekc0NzFH?=
 =?utf-8?B?WGVkYjJXNjJmU3RtRksyandXR24yc1kvL2pVZVRDSEo0VWpqNzU0cDliZXdl?=
 =?utf-8?B?L3ltSmpQOWtQQjVna0h6TFQrMzJVN3NNTEs1a2FrRnk3R2ZUTEpHdEIwVHpC?=
 =?utf-8?B?bTVQdTNTcUkxczNXYUJoZjI2ZDBJZU5Obm1ZUjhrUVZOZlZrZlprMm02eGZD?=
 =?utf-8?B?aTJpTzdZVDRQVEwrcFFYTzNHTWFXY2lpZGZCVFE1SkpRbVg3Y3RmdDUvSFda?=
 =?utf-8?B?MlAybTIrY0V4cm9TMGlDV2NSVGVYY3FsdzJLRzJrOWxPWC9oNmdwbDJ0Yk9J?=
 =?utf-8?B?aXFnU09MTy8vSHlQNGxabG9DUkZyTWNGVnpmaGMrelBGcXJBTnB2VkgzV2Ja?=
 =?utf-8?B?QmhUSVo1Y2J2Z04xR3N3b2k4b0NZZ0wvczAxUkZham5CQTIxSEZvOEZ4ZXRU?=
 =?utf-8?B?bE4welQ5U3VGMmRvNm5mZHRLWEtlM0tQbkUrckEzdVJ3ODN6aGpxMnNhNWxy?=
 =?utf-8?B?S0h5SGQ5TU1reTA0NVB0b1VZYjlNUWFKNWN6clNzTnN2UzMyM1l6V1cwdzYz?=
 =?utf-8?B?RW1mK25lNlQ3VVNoNFhNRTNqdnVQeU1FSFhxRXlJKzR6dE5wSDhZVEM2RDZ1?=
 =?utf-8?B?cFQ5UDgrNGFaQTIxNys3SUxid1h1S25OQ0Eva2Z0Vm51SmdjKytrckRad0tZ?=
 =?utf-8?Q?7oeCZHezwbq0MXrHsGg52DIHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d58980-f500-4281-b290-08dc84bed723
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:50:37.0104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTgzBhqXMnE/fN/1FVy6Zu+ukSccGFTjZbdtDK5k6SoNdtetlvlF9ST4of7F4GQ1paXEmkEJvScygsCgUOFDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

On 6/4/24 13:45, Aurabindo Pillai wrote:
> This reverts commit 44069f0f9b1fe577c5d4f05fa9eb02db8c618adc since
> the code path is called from FPU context, and triggers error like:
> 
> [   26.924055] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [   26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1022, name: modprobe
> [   26.924063] preempt_count: 2, expected: 0
> [   26.924064] RCU nest depth: 0, expected: 0
> [   26.924066] Preemption disabled at:
> [   26.924067] [<ffffffffc089e5e0>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6.8.0+ #20
> [   26.924325] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
> [   26.924326] Call Trace:
> [   26.924327]  <TASK>
> [   26.924329]  dump_stack_lvl+0x37/0x50
> [   26.924333]  ? dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924589]  dump_stack+0x10/0x20
> [   26.924592]  __might_resched+0x16a/0x1c0
> [   26.924596]  __might_sleep+0x42/0x70
> [   26.924598]  __kmalloc_node_track_caller+0x2ad/0x4b0
> [   26.924601]  ? dm_helpers_allocate_gpu_mem+0x12/0x20 [amdgpu]
> [   26.924855]  ? dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925122]  kmemdup+0x20/0x50
> [   26.925124]  ? kernel_fpu_begin_mask+0x6b/0xe0
> [   26.925127]  ? kmemdup+0x20/0x50
> [   26.925129]  dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925393]  dc_create+0x311/0x670 [amdgpu]
> [   26.925649]  amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]
> [   26.925903]  ? irq_work_queue+0x38/0x50
> [   26.925907]  ? vprintk_emit+0x1e7/0x270
> [   26.925910]  ? dev_printk_emit+0x83/0xb0
> [   26.925914]  ? amdgpu_device_rreg+0x17/0x20 [amdgpu]
> [   26.926133]  dm_hw_init+0x14/0x30 [amdgpu]
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_state.c   | 16 +++++-----------
>   .../display/dc/resource/dcn401/dcn401_resource.c | 16 +++++-----------
>   2 files changed, 10 insertions(+), 22 deletions(-)

You probably want something like
https://patchwork.freedesktop.org/patch/597044/ instead.

> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index 8ea9391c60b7..70928223b642 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -193,11 +193,7 @@ static void init_state(struct dc *dc, struct dc_state *state)
>   struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params)
>   {
>   #ifdef CONFIG_DRM_AMD_DC_FP
> -	struct dml2_configuration_options *dml2_opt;
> -
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return NULL;
> +	struct dml2_configuration_options dml2_opt = dc->dml2_options;
>   #endif
>   	struct dc_state *state = kvzalloc(sizeof(struct dc_state),
>   			GFP_KERNEL);
> @@ -211,14 +207,12 @@ struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *p
>   
>   #ifdef CONFIG_DRM_AMD_DC_FP
>   	if (dc->debug.using_dml2) {
> -		dml2_opt->use_clock_dc_limits = false;
> -		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
> +		dml2_opt.use_clock_dc_limits = false;
> +		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
>   
> -		dml2_opt->use_clock_dc_limits = true;
> -		dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_source);
> +		dml2_opt.use_clock_dc_limits = true;
> +		dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_source);
>   	}
> -
> -	kfree(dml2_opt);
>   #endif
>   
>   	kref_init(&state->refcount);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index 8dfb0a3d21cb..247bac177d1b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs = {
>   
>   static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>   {
> -	struct dml2_configuration_options *dml2_opt;
> -
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	struct dml2_configuration_options dml2_opt = dc->dml2_options;
>   
>   	DC_FP_START();
>   
>   	dcn401_update_bw_bounding_box_fpu(dc, bw_params);
>   
> -	dml2_opt->use_clock_dc_limits = false;
> +	dml2_opt.use_clock_dc_limits = false;
>   	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2)
> -		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
> +		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2);
>   
> -	dml2_opt->use_clock_dc_limits = true;
> +	dml2_opt.use_clock_dc_limits = true;
>   	if (dc->debug.using_dml2 && dc->current_state && dc->current_state->bw_ctx.dml2_dc_power_source)
> -		dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
> +		dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_dc_power_source);
>   
>   	DC_FP_END();
> -
> -	kfree(dml2_opt);
>   }
>   
>   enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *plane_state)
-- 
Hamza

