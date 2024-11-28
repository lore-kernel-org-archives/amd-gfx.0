Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11AD70DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C1A10E1C1;
	Thu, 28 Nov 2024 16:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmjwFJlp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DE410E1C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWun+S6rbIGOczAt04hyo/yvoraeV/uT66+n0lWci/2WvumjAfgl3Tn/eBIYA7G0PEp7icxQTwSoesZ+nNLNyBLc4W42QKXgJ0epfZQD6Qy6Za4wJxandgnkWawJiTP67f5IFhOLlQvy1mq4sK3LZai2coD9z1ij+D+VjdbjLwC+NR6SSTQnBcA8OuEnGNvdzUormKRE2c0HiA7AgadxddsGpnQGK9XXChSt2Q9pE1mftZWhP4NjkbuJRfEJ4p5wvVMvZ/SFUeNrhg5tAmUHU3C0JoQXZR37yeTkbXp2YBQaOaUSS8oMZx0Ozl5qek0+qAyGE9u4j8WcmAaaxPnSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYrB6jNlkigcKnKhkEHvGiydl8RmtM8R8aEbel8smb0=;
 b=Z2OrMtuQuwoxDpZ655QnDTHFbyiozMEC2+QNFB0Rz13VsXvcFdPCmbXBWgYtRA6/hIN5/ebpQCp72DwmElqPGqW852aveAJGjm5oP+gAwu9hKKLgPV7b5ctJsDe4hnwwLuqKzMmn6xMSn8s9nz+MnI9/e9wEYO/JUI+98mRoGVRO8QgVBIrZZ2ZTyEz/g+qg1Ei+35BEyE1DjB9dIwQAQuIF6jHWOIeB5sdaGUvLic/95RxnTeuiYSSvxlSqJrDbvoVBrDE2BqNpKNAxASWB0BPBtPD3UgF6vjEIlEXXg06+CUITmf0p0nRnaEBtBn4civyXeFq4SMseNQrzGvEPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYrB6jNlkigcKnKhkEHvGiydl8RmtM8R8aEbel8smb0=;
 b=tmjwFJlpMOE0iH2zK5BELCnAlu+J0C3sMKoOhb4LfEACJHtCHuFCkn8+8ULUW0HoTzsI6rKHG7/3yNko03OwFUL50NOVYTiPvm7RS/7cFiiZUXimvXpaXxwb+NOoUJfqIBxdeBrG1wXhCOAgJN1FBVM8ZIexM6rhEB47sihNvqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 16:55:25 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 16:55:25 +0000
Message-ID: <67f491ae-059a-49fd-99d3-bcd156085e89@amd.com>
Date: Thu, 28 Nov 2024 11:55:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Dereference null return value
To: Andrew Martin <Andrew.Martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241128162604.966580-1-Andrew.Martin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241128162604.966580-1-Andrew.Martin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 78471eae-0ea6-4218-63f5-08dd0fcd7459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2JWdG45SHpSSVZYU2tJTS85d05NZVJnVEl4aUUwelN1Q3BnbkNWZVo3Z3Vj?=
 =?utf-8?B?MlJnVmZ3OVVGUTZvdWR1YmNYdllWbFNPdC84b1lsNDRZaVUzSTNqbnhJZWlB?=
 =?utf-8?B?T2N2NVFRVXpKSEZ4N3pRWEEzR2VGbE8rbWRmVHN5aXJBSENpcDc5R2kxL2lP?=
 =?utf-8?B?SVZabVNqYzArVVNXQ1FUSWMvOEdLVzRDcm1rd0VocU1lZE1sU1kwMTFmc1VM?=
 =?utf-8?B?azg3WHA5U3dmb2ppTnJTL1ZEcXhDSkpvS3RpZXVzampHVlE5SFM4UHdBdGQ0?=
 =?utf-8?B?WGI5MVYrMk0zL3ViMVFUeFllaXUyR1k2VXdDRHppelpaNE5DSFdhMFdjcTRM?=
 =?utf-8?B?NUNvL0RvTlFXRiswdjdwU0oxL0dlTDBXOFFvdzlIK0Q2dGlNUVd4K2lhYlB1?=
 =?utf-8?B?citVeXNOYkhxaVNQMkFQK0dFNXdoUjhWRTFRdUx2b3R4Wk5JMDFyUk81UHAx?=
 =?utf-8?B?Wms5dUg2SGFQR2sxbnY2WnRqWFg3OVdkMkt4U21KYURhaUhReUlkbkc3VlQ3?=
 =?utf-8?B?UWRrSmIwT2gxWGlFUDhyL2NReHhIWWxDdVZwSzIwLzZVcG1tdjMyWHJ3RG9Z?=
 =?utf-8?B?eUE3Yy92QkVzQ1lwZ24yNEFrb0tjcEJFYUY0UEJHMG92RFQ5aGozK2RNVG8w?=
 =?utf-8?B?VjZJUmVYWWR4REtublhna0tsRm8vRkVHK1dPcUNDNmV5Ry9zVFczb2FFV2dv?=
 =?utf-8?B?YjM1TlJRanA0S3R6c01tWGN2VXU5ZkxVWHBqOXltV1I4Qk5HZGlmTVh2cmQ3?=
 =?utf-8?B?OE11akRMZ0hlWFRvOEpLYklyc0xuWFhISTRTdnluaVdlRHF4bFpTaU9CQTlo?=
 =?utf-8?B?OVJBaWNHTEFaV215RlVKdW9VYmxtc2wvQUhEek5iakRpbFFwWmtyNVowelZQ?=
 =?utf-8?B?SjhUbmlxZk51K0RBV0RzdTZqQlUyeko0T1hMTEcwQWtuYmVUTkhLSmtLNCtp?=
 =?utf-8?B?VGlqc1diaGhjckcyUWRGZ3phNWVWRWQxRkpVWEZyQk9scUVuZWdvTU1RS2Fm?=
 =?utf-8?B?WkJzSmxjR3ROTVNHREI1YkRGNTJTbkx6WTBkYnUzbS9VWHo3bnJtL1IyNkdV?=
 =?utf-8?B?eVgyRlRxRUc5N2x6Sm4yYnJSUHBjeUY5VmI4M2d1d1V3aXBWcDE1cVoyMjdP?=
 =?utf-8?B?ektuYTRuVW8wd0hIc29BajNhWlBjUEFzSkNwSmlGN1d6alpVZHdDTDMwTTBM?=
 =?utf-8?B?WHllV3ZMcUxzZHdQL2p1TUVlL0l6WmZKUzBNVXlKazcrZTFCZjk3cVoxNzdk?=
 =?utf-8?B?NG5vc0M5NnVOYlZLdUdSd214ZzVGSHUzckUwYXhtTEt3bktwMmEwdTY1S3Zr?=
 =?utf-8?B?RUhwaXhqTGVuZGNQZ0lOaEFraXRtSCtKa0pzVTBPOGZaRkU4L01BaldLSW1B?=
 =?utf-8?B?dDVmZi8vRFFTWFVpMFBnS3NNQTNEM2FjNmtYRjM5R3VhTFN4UVJqR3N5TmFB?=
 =?utf-8?B?K3grb0oxaFo3TVlUTDVhYlZzWWwxaWZJR29KS0FXOWEwYXd4OEJkdld1RnB3?=
 =?utf-8?B?OG9TK0xZcTVJbHV3SlY4TW0vN0MzUHMyNzc5eU1XTkhYUURZb1E3TmVjK2s5?=
 =?utf-8?B?QzcybUwxS1J5VDRuTDNRMWViU0RVRm5RWFQrY3NNcnZEVGwvZlFWVkM3N3hQ?=
 =?utf-8?B?RTlIN3NZWXppcVVZOFRNMkJXendoOVVFMFRyYSsvNGJWMnN1MnJRbENWZ0Rr?=
 =?utf-8?B?aXA0Ri9obWx1cmU2SHR4bHorYmRQMWIwY0g3Y3NUT1FOQ1VNNU1iRWZNSzN2?=
 =?utf-8?B?Sm5uSnMzcnJCT3RqVjdLN3RBaDZJQ1VvOWlvT1JES0t3c1dCWkFRT0Jua0x2?=
 =?utf-8?B?RktXK016K2dicFQrcVNOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2EyZmxsUjdDQ1RGSWZMQnhKTUlFY0dHKzF6dFFHekc2V1cyZXV0NitGWmVu?=
 =?utf-8?B?eFRJbEZlVjhlMFd1dzJCVHB2RitNOHZsWWlMRzc1aUtGWStWWkRycFNMWmht?=
 =?utf-8?B?VzZ1Q3V3S1dvaEFhTFBBbXkweVovUWFPZXVuSDI2QjY4UFBYVmh3b1NlWERu?=
 =?utf-8?B?bWs2YWxCNFhXblpLem1HSEx1V1pCZ1AzZFUvM2JabmVxMU1mQ2Z0L0pidlMz?=
 =?utf-8?B?SkVBNnlJTHNzT0NFYUhUdmZQQ3o1dU9zYUdtUmFnc3NEd2ZTWWNSMjczZkJq?=
 =?utf-8?B?aStaZ1RFT08xTTRwNzc1bzc0amdnYmZsVTdvWFNHejBMN1VyaE1oVGs5SHNW?=
 =?utf-8?B?NGl2TDQ3amU0TS90TEZyaUNtMFFuYnd5NUtqSGJXMk4wa05lZEdnc2FZTnI5?=
 =?utf-8?B?QVVsRERZL3F5azhJa3J5TlNyOHQ1TTM5b2UrRGdERmZudzlneU9INVVacWhO?=
 =?utf-8?B?clZjc20zdHMwajNkOUZFMDVIWlBzTVY5QXRzVFZJU2IyUDg5bDJlLzhzZ0E4?=
 =?utf-8?B?eHNEUlNEQUZuZHdwV3NXZ1R0R3dCdVQ1TWwrRklyd0ZWajI4OWhlbHBKeGtw?=
 =?utf-8?B?clB5b2t6UDdxWHpqMzM1TDlNZWp3bFo2VS9VSWNIR1FSSTRuWmN6VFkwRllG?=
 =?utf-8?B?eFNtNktMc3JUNUhaNkhPVlY3amN5Vm5yeDlPcENFOGFPUVQ4VFFtWkdpcDNx?=
 =?utf-8?B?dDE2OFplWFBNYlFuZndxVFdkT21aaHNCcEF6VUp5Q0VRbHJ6WkNnY2lna2Jp?=
 =?utf-8?B?eG5qV2FjSUw2aWtDMmNUN3htbExNYkFKU2Q2WmtVcEJYM3Z2TFZPU1pHaE5U?=
 =?utf-8?B?cHNLd0U2YkJHQWdYUGQ0Nlk1TDJSRG9WYnNqRUIwVGVNcDBkWnJDMXQ5WlRC?=
 =?utf-8?B?VjFvVjVHNmR5aVNPLzFrSEQ0YjZlcXVBVFNPRTlZNlFqT1d1ODE3a3p6aWNn?=
 =?utf-8?B?STlBLy9PaWZNaW0waFp5TDBJNmEzemMzV1lLQkpLTmU1ZHhRb2dPUk5BcGZM?=
 =?utf-8?B?WXJuc3hYU0tqVmg0TDNKTGI0Skkvc2VZNzNWZjVDSDVqcHdaSEFhSUN5Tkox?=
 =?utf-8?B?a3ZiQlhBWUFneldsNEZEWWpnWnp4OXpmWjZROXgrS2hqR21ZSk5qVjNiRTZY?=
 =?utf-8?B?WmlEYWI0OFJ6WndvUGRVQy84SXlxZHl5d0lWeGZad3hBdVVMcHJFZjN6UlZu?=
 =?utf-8?B?RkVjYldZMno3QVhjWjZsc1IvZ3VlNC9BRXNLYjVzQzNyRWZvZUorblF5NTNa?=
 =?utf-8?B?WFNMOGFjU0trczBPZkc5am41RjM5SHF4R1FTS2hBVnhhMUwwVlcrWUR1bDBp?=
 =?utf-8?B?WEUrNmZNa2dSRFF3RXN3TG5JU1diSjlMQWpYdjZicGVkUW9ldjdicnc5OTJ6?=
 =?utf-8?B?U25HbGw2aExLY3ZyNVFzWFJteDhVWS9tUFYvZm50NWwySTJrTmFQclNDQ05a?=
 =?utf-8?B?OGRZY284OXhacUtzbi9HUGhLVVBoY2p4SytUM3M1bDQzS01LZ2tFQ2U4Y1la?=
 =?utf-8?B?djVORUppTFNhMjN2UEZvaHpSaTJqZG9YWW5RWUZEZWphOFZvaWxwVnhXODRx?=
 =?utf-8?B?dzJtM2Z6RzdQR0M2WjJna3plQ29rcmEraEw4SFJSd2t4RmFKbGQ2VzdSdXph?=
 =?utf-8?B?RS9sc0hVbmN3dkJjSnpTbXdvcjBCUHh3OStVZmpBMzE2aUVKcXg2SUVwODRz?=
 =?utf-8?B?dDJoY2dGQ3RiWXZRZ211bTkwU0ZZdjdTY2dOWHkzNExPc1U5Y0VsV2tJYW9i?=
 =?utf-8?B?cDFYYk1WeTJCaU1aYkJZRXBxWGZtUUViRENLOWRoRlpKOEQ1RDdjUzVRQXV6?=
 =?utf-8?B?NlQ3NG9oY3MvN1lTY3NBSE9FcGxxQm1hSDVJZVRGbExzelJHbnQ4dk9iRmE1?=
 =?utf-8?B?WWE5bG9rWUtxQ0dHWnFyK3AwUXJwQnBKaHpxNlJwK0N6L0U2WXNLelZjM2tk?=
 =?utf-8?B?Syt2K2RlVDhJdkJHNHcyWHozdVlUS1J4eVcwN3ZqUGdCVUM5dE9EVXM3TUJE?=
 =?utf-8?B?Sm9ISmNrbitNczJJWFNLaGZxd3NEWlF0dHk1VVhTdHVoN1A2a3RENnpKU3Fj?=
 =?utf-8?B?M3pldEpLa0tGUThUTFUwV3BvN2hjK0V1RElwbnREbjRGeEJmTFdWSlViSzFp?=
 =?utf-8?Q?fD5WJi853Hmbxzj3QoE2Z6CKp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78471eae-0ea6-4218-63f5-08dd0fcd7459
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:55:25.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAzKkfx+JEYG9+JJy0PhkP+imO269R+LT1fY94jLJnzXxz3kZtun8piTUWarpWJUWUSoV2O3BrT15E6bYJSAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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


On 2024-11-28 11:26, Andrew Martin wrote:
> In the function pqm_uninit there is a call-assignment of "pdd =
> kfd_get_process_device_data" which could be null, and this value was
> later dereferenced without checking.
> 
> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>

This seems to fix a bug introduced by a previous patch. Please add a Fixes tag for that:

Fixes: fb91065851cd ("drm/amdkfd: Refactor queue wptr_bo GART mapping")

> ---
>  .../drm/amd/amdkfd/kfd_process_queue_manager.c   | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..808c447879c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -212,13 +212,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>  void pqm_uninit(struct process_queue_manager *pqm)
>  {
>  	struct process_queue_node *pqn, *next;
> -	struct kfd_process_device *pdd;
>  
>  	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
>  		if (pqn->q) {
> -			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
> -			kfd_queue_unref_bo_vas(pdd, &pqn->q->properties);
> -			kfd_queue_release_buffers(pdd, &pqn->q->properties);
> +			struct kfd_process_device *pdd =
> +				kfd_get_process_device_data(
> +					pqn->q->device,
> +					pqm->process);
> +			if (pdd) {

checkpatch.pl will complain without an empty line after the variable declaration.

> +				kfd_queue_unref_bo_vas(
> +					pdd,
> +					&pqn->q->properties);
> +				kfd_queue_release_buffers(
> +					pdd,
> +					&pqn->q->properties);
> +			}

I think it should be impossible for pdd to be NULL here. Without a PDD, the queue could not have been created in the first place. If we want to add a NULL check here, we should make that a WARN or WARN_ON because it would indicate some serious bug somewhere. The result would be a memory leak here, so we need to warn about that.

Regards,
  Felix

>  			pqm_clean_queue_resource(pqm, pqn);
>  		}
>  

