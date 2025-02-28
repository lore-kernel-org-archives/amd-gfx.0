Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB76C282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBED10E0A3;
	Fri, 28 Feb 2025 18:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rkm0lRqE";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE67E10E0A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKVp6LYZckcOKQjFIvQcmFQoVVzWvvjM1LbK5pgyBOuL3UcmTpoDWbYQ4MJOcvgLTbxgIR4TjiUwjLJPsNhPY6ncq1XWuMniJjkmOxKyGjc91sqTADmMwD83eQpRZgwujcbW2X3YQoAoeSJxJCtopJlXf63nUgokVccXnh1z/lLmNje4weFWiSu3TajuVu8K4OcKj4wDMXhzgPjIC4wdTzidSEi03xkzBVCHXDbzeygc9TZNRXctIrxzb4J2XHkjuiZtBEQM1HDe8Xud5Ge3qq6C0FAsYHzmr9N6Pt1QIingH99YkgXBylWjz6L/Z9RJkMonI0V+w5d4gZPCWDGSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq7/DA8TsldaWcVsx4rnkaBoHMeJxwyv0aE+jrW+b/w=;
 b=aLF2L7E5UzCMVvfFtyoaHfyv/8LH603VRrAFGHbNuIMqrtS6sg621BrFxujntNqfkZ/Eka0xaRBT42nWbzoWdNFprBuzMUARtwQ93E9mu6xK/NPr0ljRYdcHmWMjshRc6RO+y5GgFGEIrfRA1+DgL8JpnnyeayBWfgVBY0Qj0lCF2lpMzv7AGKsU7u1vNfj7Wo2fiM+m54zNou9pby05s9/NLcEKkUf5sIeqdxtvb5LJEw7hU4OBkztOL8TCT41e3NLh0GaJ0qAOCsE+zzVClWm2dNho40X7NY2kOnt93GcJFNHiTx1vVTkg/Eg+xIKSSowSkkAftF5DLHZMFMEDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq7/DA8TsldaWcVsx4rnkaBoHMeJxwyv0aE+jrW+b/w=;
 b=rkm0lRqEXqtgMmvsZSqbuyUlxn6/PM+S2NAMPhbnbPbEP/2vH5ZpQs931xVJ0oDrcPefoSTlj919cZJhxIsMXcHXJOQf+ne0r8+hbxF7HiFQ7O+w+CVI+jXBv/pc8Ya0SYem4kYN2IKFXnxU8dBpSOhnN8vr7Hva346/TBsTTnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 18:15:44 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::b2f3:4033:5aa0:dceb]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::b2f3:4033:5aa0:dceb%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 18:15:44 +0000
Message-ID: <ed3c4e3e-47c6-692d-0bc8-5fab42cbf85d@amd.com>
Date: Fri, 28 Feb 2025 13:15:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix NULL Pointer Dereference in KFD queue
Content-Language: en-US
To: Andrew Martin <Andrew.Martin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20250228163949.1079532-1-Andrew.Martin@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250228163949.1079532-1-Andrew.Martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::8) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1d6ebc-5986-41fe-1684-08dd5823eaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkFOOW9QbmNCRzhmRldNTVFkRnlDUldoYUFONksrZzNEdk9nN3VaQnBBbWxR?=
 =?utf-8?B?NE9kTFl1ZEIxNEh4U0dSd3ZUNFA3ZlNhaW5kdmFZcHB0TStyeE1aeVdRVUdo?=
 =?utf-8?B?S09zTWdqUTBKTkZ5L29PWW1OZGF5TEc4K0tEc2JXQVB6OVI5Q2k3QjJETXdh?=
 =?utf-8?B?blZmb1NFeFM1amlISU1pSnY0MWs1SnljbTBaS2ZYQXZsRDJiNHZra1JLUXQv?=
 =?utf-8?B?QnpVUHMyNTdFbzlvN3BhdklxOVFXK2JDaTdzbUNOMGZHeTdqQ3VVbytBRzE4?=
 =?utf-8?B?YksySGtMak5yMmtUWHpRMkF3bmc5R2haL2psZlU1N01tRXE2dnpjVXVzQzJa?=
 =?utf-8?B?ZlB6Y2pKMDllZW1aKzNpQzRYTmMrWHUrTS9lUG1mMkp4bm5DRFhBeWxoVE4r?=
 =?utf-8?B?UGg5N2N6aFd3cjh4Q0d1ejNXQ0dCWkthbGNGbHNPMVpPYTJUNktGZTYyRmVO?=
 =?utf-8?B?WitvdjFiKzQyKy9TV3k1bEtJMzBORXZpWUluOE5yZ0JWUE5OOFhzcFM0cmtO?=
 =?utf-8?B?QXRVZzg2NWVLSVBPUzErQnZzNy9LV2IrZC83bGluaERjUi9FVVdCd3dsNkRp?=
 =?utf-8?B?V09icVpEMmNDcWFLVTQrUE1nWXlKMUFVcXZGNXNRTERlaFpGUk5SblZhbG5q?=
 =?utf-8?B?VDN2d3dJYzVnbFY3d1BpRnpyYi9tK1lEQWZHaVBhUzV6b0x0MmpQSExXcy9P?=
 =?utf-8?B?bVJhVENpWTZIZXpNMk05VFN2SU1vQW5tQWlIeEtseVFGcnpWdVVaM1J5cnFa?=
 =?utf-8?B?ajJKR2x1RGpHc09pVWwzWUl2eUtwSURvUzZJcXRHaG9za09PNU1WT0sxWW1E?=
 =?utf-8?B?OVdIMFNLcktMMmxpMmU5MktYbWZzOXpLVzNFWHpNS0V5MWFFTWZuWU1NcGRu?=
 =?utf-8?B?RE5oa1ZHS242VUVIQ0ZJZ0pzczU4UzNzSmxIRWhOMDBCOVMyc25SMnJnYUlT?=
 =?utf-8?B?Z1FEOGwwSlR0WnQzajBxd1FQV2NCcnZYMS9pUTZ2MXlCU1hGdlR3TmQ1VXNa?=
 =?utf-8?B?MXFsRG92OWExSDF1ZEUyWnd6cHlWMy80WjJvMnVhWUYvdmUrVmlVdyt3TUtx?=
 =?utf-8?B?SUhzZng5MjduUTVzV0dDUTNab2thYkJRc0l2TnZvZkx3c3JvYWhZcy9zTS9q?=
 =?utf-8?B?Y1FISlpiZE9vYkVvbmNOaUNxMGdHTmJDOXBNcUhpZFhOeTB5WjlrbUxUTnVX?=
 =?utf-8?B?ZEk3OUNESnJibVVlODBlYm5PMHcrU2dlemEvd3ZKd0JrYko5cUhEODlVSk56?=
 =?utf-8?B?THJWWmsrNlQwWGpuY201UG5wUlJlY3RkRUlyTjlldEJDRHQ4cHdCcHVMTXY2?=
 =?utf-8?B?SVc3bHVIT2x2cGxWQXBFK2FEa3diMExvbi9FU3h4bHQ4YUp1N1A3ZFJNd3lI?=
 =?utf-8?B?d05YOHl2QzlrWjg2a2dXUXhGV0NTWFVaRG16RDZWQTRFM1NkQ1g5ek9CYzBZ?=
 =?utf-8?B?a3Z1VEhoNWVtcHU2aXA3djBCZVhVY0J6VmZyZWJIU2lVdzkxTmJUT294ZEov?=
 =?utf-8?B?SGRaWlJTZ0dGVVR6STA0bFBGT2VGc3g4UlBLMmFNRWFwUVY4ZHlPa0w2Yk8z?=
 =?utf-8?B?a1lDYUFNaWRLVDUzQnhTeS9wQkEwZ0ZLd0oyVDYwK0NwalMxOEdvVXhYRENa?=
 =?utf-8?B?TVEyalM5R3FoaTVvS2Jqdmc2dFc4K3pQWCtuQU1LSkpwMlV2Skh2bUxVRHV2?=
 =?utf-8?B?R293eFc2VHpRbHpMRHVmSmo1dHQxZEZlR2RDbk1LZjYwZGZCblRRTnBpY3lN?=
 =?utf-8?B?bG1BYkM4VmVUMHBqUGF2SktzS29BMWRIdlNxZGZUa2lYdUNROFExbVNKRVZC?=
 =?utf-8?B?ZUhKbE9CYjMzUGZIaDVPZVZiVWprS1FDSkdYQ1ovODhjZ0NBd2w1WEc5MktQ?=
 =?utf-8?Q?Ea6vyvg9LDJbd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBPOElPMUw3OTIzbXdaZUZqZ1pnZ3dDN3hwTjVqN1I4Zm83NkI0YzVjN0xG?=
 =?utf-8?B?cVZUbW1iSHY3dkxjUWFRY0FjUmxCZVcyMFk0QTBFWnYvc3NGVXJNYXZCSTRX?=
 =?utf-8?B?U29KV3ZXVGdFSG1lQTZJZFF2d2FOSTRRWFlKaHJOMXNWYTAyb21yeUZwdm1y?=
 =?utf-8?B?UktUM0RmakczY0YvUUxMOVUweEVoNjBPUEtEa2p3YlZROUNQYncxOVV6NVdY?=
 =?utf-8?B?M0dVSjAyeTh0cTIvWFZRbTR2TUgvdzZ4UEZ3Vkk5a3M0VThlTFlqZzQvM0NC?=
 =?utf-8?B?MWdzYmNkZ1lMU2JPdHpuTlN3Z3FOYVBFTlhOK2ZWVkJOWWZqb3B0MUhUaWY3?=
 =?utf-8?B?U2F5TzBOYm0zNWRoajRPMk5xNmgxamZKYVhWTFkrSldsUmdaSEtIQ0NkTGhu?=
 =?utf-8?B?T09vSko2N0FvVnZwUFg0QzVlV0RibVVkMmxONk1UcWp0YjlIV0Fka3UwWUlQ?=
 =?utf-8?B?S0lWbTRNZk1jREcreXprWnhsbWNORHAxeWlCbDFwSldkZUxwcVJWeHhWN2dq?=
 =?utf-8?B?cm5sSlNWRTNGRzlLeEJwWHhLWDJ4a2d3OUFZSlBCT1lGekMyQVJCTEU0Q1B4?=
 =?utf-8?B?V3BqRTZZMTVPV3dMczBKMzZpaE5CbmNyYUFXQmpDdGpZTnc3RkxxR3pGbTN0?=
 =?utf-8?B?eVI0dnQ0YzJURld1ZndJUUo4NzhjK1dLWVRIdkpDWDZJYnA3QllJb1VsUmJr?=
 =?utf-8?B?OW4vb3B3ZUZXcXJmQ0VVdFF0RWljOC92U2pNbzV0TXZSSThTWnd6eCsrbk9G?=
 =?utf-8?B?bnhZQStRYkE1VzhvSS9USHpmYWF1QWlsaE5HdUNwMnJWcjhDTnBkWXpYakVS?=
 =?utf-8?B?a2VDcVRzRHlsYVBnUTlGV0t2NUhhTngyOVFoQ2JuT3I3amxpWUFFS2NGSmMx?=
 =?utf-8?B?MmZnWUF2UjZBY0QxUjM4bTJGa1FnTzhjWjZpRkVUSGZOendZU2hEMEFQMmcw?=
 =?utf-8?B?T3BiR01PL0RQNUs0QnZ6L1p4ZmR4ckJKYU1ZWVlzOFNaNy9jbkJValpvV2l6?=
 =?utf-8?B?OVgzUlZlbXR5Yllra0Q4WG1VdE5iQWxBWm53YU9PTDdMREEwMW42UnZxOWM1?=
 =?utf-8?B?RUZnemx3V2hlZXNETGRlUWtoWGtpOHZSbFJOZWcyT2NwT28rSXhPdllXN0dO?=
 =?utf-8?B?RzBHQ09CbWxLcWlhZnE1N0tqRlROMVE1TGdBbjNMNStucFE0UnFLWVlsRmhO?=
 =?utf-8?B?QjNZL21xcjlORFVORkxyQlpuNlNhdnVWbDdPQy9VemtaSVloUGtvUWRXZXFC?=
 =?utf-8?B?STgzRzJSK2YyZEtVdlBGKzJXNWVOdGh5Qk1HQ05qWWFHMFJEREpNU3IyVFpp?=
 =?utf-8?B?VldjOGhwQTBIeGRKWGM1SHpMQ1BkS2VoTWlhOUxZMER3ZmhjeGlXZTFsWEcy?=
 =?utf-8?B?OGxPNUpTTm92YnMvcWp0S2NQVFFlOE0xTHRJQ0pTQStqK1ZhYlpzYjJxUklX?=
 =?utf-8?B?cFI3a1NVdExLQ3Z6WW5EZTdtMEw5RFQ4bXFWNWZObm8waW5pV0daZFpvL2ph?=
 =?utf-8?B?WXl2T3MvUFdZY0xhQU5YelJGS0xoQUptb1lCSkRZc2hWaEpsODZMbGJneGlh?=
 =?utf-8?B?UFRpQ3k5WGJrd0hRSThEU3oyUFJ3WjExN0F2Wk5HelZaTE9sVnRnRE9jN1ZL?=
 =?utf-8?B?c1lWMmpVU3FkVHF3VEprWE9vZlNaMmVYV1prSmdHVGxlMHdidjNZMEo5SWls?=
 =?utf-8?B?Vmw1RGRyMUgveXpMVGRabWltcHJaS1lJUHJvUkg4WjBrTVI5MjdKRGZJTUpo?=
 =?utf-8?B?RFUyZEFJSTBxTDMyTzNGYisxaHpqWkU1NGJtTEh3RCtYSmhWdjlYd2xlWUpt?=
 =?utf-8?B?cHl4a01oeEZoYi9ad3RvSDlxVHFHZUVJYnRjMUs0QlExcnF3UnRKTkZmcWQw?=
 =?utf-8?B?d3Fxb1JEdDdpZmhEdlRyb01VQm94UDF2eDlmUEthREk3SW9CSENmRHpURTV5?=
 =?utf-8?B?TUFkNUgrdTMrZmpFQzY3bVdEUThibWpaUWNNU2xMdDJRbkhtNGN1bUhPbTdz?=
 =?utf-8?B?Y0VUTEdoR2Z1UTBybndCTXNFTTFNbW85YmZpQVE2VTVRV0RUYzFtUEhkN0Q2?=
 =?utf-8?B?VXpoRVMxeTFNNEl2eis2NGRHLzlJU0w4WU1MQkFmNUMxSFNiV1UyOUVOMms2?=
 =?utf-8?Q?vXxRG+hTuGh203IxUhwuYwG6x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1d6ebc-5986-41fe-1684-08dd5823eaa7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:15:44.3345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFuajdIvxj9ItviwiOEEFYYf55pZwMpGyDSXcmcV0z2gX6eYOcHmLE72ygJZaMxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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


On 2025-02-28 11:39, Andrew Martin wrote:
>      Through KFD IOCTL Fuzzing we encountered a NULL pointer derefrence
>      when calling kfd_queue_acquire_buffers.

Please remove the extra leading space character in subject and comment, 
and add tag

Fixes: 629568d25fea ("drm/amdkfd: Validate queue cwsr area and eop 
buffer size")

This patch is

Reviewed-by: Philip Yang <Philip.Yang@amd.com>

> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 62c635e9d1aa..dc2cdc48e28d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -277,7 +277,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	if (properties->eop_ring_buffer_address) {
>   		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
>   			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
> -				properties->eop_buf_bo->tbo.base.size,
> +				properties->eop_ring_buffer_size,
>   				topo_dev->node_props.eop_buffer_size);
>   			err = -EINVAL;
>   			goto out_err_unreserve;
