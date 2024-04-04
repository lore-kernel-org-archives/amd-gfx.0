Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E01CD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 10:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6578811B2D0;
	Thu,  4 Apr 2024 10:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lt3twPIs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1041811B2BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 10:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8IoE/PK8Rn7t0hVH5zT8eZU9QVaegPXkBQtBO80qCgSVhUTaHX9kv/9WGozK0mInuuDBEKdR4mVKDdRQKE0+z0uaEBcOfSoO8oY732Jkk6zpGB6NDIktB+WpRIwXvarwpy6iu5HRL0HQhUcSOYGWJ8gO1WEkefwVHIX8dBPXRuv6CiViKPKLo8QkpWSnoKQaFDguOCD8zc+K/dthkO44blCitJDOd54cNgCPSz/sfySaKSoxG/Xn7q60tB0hUba8sWV1Pix8mNVtnP4F8kyLAjWV7B+X3YLdYGNSTJX88zuR84y73YmnJMhUDBu9YVIQmeSmIp7RYLP1D1T0Kpz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaGgFw8keUvX4tHUd6Yo9IChUe00qnAlFmVQxF5CA+M=;
 b=cLKoXSsoRfTjP4u/t/BMXBocfpQdhW8CN0BeIYTEAvtfoT8tGHwGwvScTiZ1ucev4VnSdiNcAMqZHCqOKnkRaPVponUoNXMnqD5UzJLsHOccKWF0P/yBu/Rh/y4eXaE6XRehbQjy5+tlc6PBa+9AU384d6ShQu5qlGjISFY65aB5ZRA5JBLvpqOn1BPl09ED7y5qMsu/v0oaZDtrVBN1kDl6yMgCJjzQo0zErgL/W+VlHeWtc+FY78M4doeDzI58GN6JNn2d7fqwPie5LT4HCw3QPvgDnRrqz3pMbvx93KYQmxToAQSV8HajixUVuXssOY7a7e/AFvKFc6GXoUQtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaGgFw8keUvX4tHUd6Yo9IChUe00qnAlFmVQxF5CA+M=;
 b=Lt3twPIsOe+9LntfMvcUk9KAZktJiWguVMw3U7ItVDPfroniIv646Lx32Y4Plc63V3AO1HljPKP9ZgET6X4RgGMgSOgSewueD82V/tQ4q0McbenVmZeKJTUL/UT74cpuMFI7LKHvL4XBcVEW/mY7qGRkXov7pwUCoS2+FgTBpUw=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:02:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 10:02:11 +0000
Message-ID: <c2cc3d0a-ff24-4d39-64e6-78ea45c5726b@amd.com>
Date: Thu, 4 Apr 2024 12:02:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Content-Language: en-US
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240330140129.18824-1-alexander.deucher@amd.com>
 <CH0PR12MB53727F41E0D147A9EEAF23A2F43E2@CH0PR12MB5372.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CH0PR12MB53727F41E0D147A9EEAF23A2F43E2@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA1PR12MB8888:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnIN+NBJtNyfgRC90dCYoXbWpniF13bFyeU6hPEPNXcO1+ai7flxIrQpmDSV3q616WVii3sJa4YGSbegzjDvBnpHpXhIDUgxqu+x15gLsJcM1AdzRr7i7l+Culfmt4Nul+INi3Z6vBaO924qYeXE6u518ZZ2ZRALIXz1auPGOLR7Yt8rym5iqwPOdlng92MiOalXMsJzi5f60SJ4fmjIg10OoPN9Q2SLDk9emkPSj/+YO38X/GRqlW7+/q4AscPvQh3PDOir1QifgxEM2Do2bJc/cqCf4L5DoUv55UHPn7C9b9rLLDgJzaPxfsu9AZnIFQta/IoyaQjKwLh1LN8bnEwHGkZlWdWQbQXm8pOEnrI5DUkxppraYEtChBPW97YaZpx/EOJGXZ4E/bT2UmY5SSemlUtsh20YDy3d7r04A94o6uaNv1eRyksepYlGr6BtW8RSkL9M+jThIYeJEwOnT/Bz+y12dhj4Bx7z2m8fe25ljwNObQeqjPMgvgFqLLipAbErcESIMxno5C31rFldCva/2wiQGCcSg8VDXeGUeJ5TNzUOywo9mFlz5s3O4sw99KuO59K1zhpnfz/3o1lWIKcW8byCgRZ1ZzD2mhM/gS80RclkuJfyueEKfx0a3CMrGIq2MJKgD70ILIzjoqKBqpij9pRw6vBLTif2OOiHYAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RoMk9pUU0rSm5QYWdOcUpIVERDT1JtZnVqUHphRFFRekdSUUxiNkw3MTdF?=
 =?utf-8?B?ODlnLzFRS2lvOFpVK2pZY3ZiM3B6d1RjUzhkTjZKZ0VkVDFqbXlkZlRRSFRP?=
 =?utf-8?B?b0NhWVZ5YkNvU0lsVnVaZVF3ODlzK0M1YnNGN0F3SGtuT0U2ZVordFQ0SnFr?=
 =?utf-8?B?b0RoZkVtdG1meGQ2c1lUSW8wSFRMQVpaOGhFNDZwUkFvZkpIRWkwUUlKWVZi?=
 =?utf-8?B?WUd6V1g0TDkzRURLM2FtTTgwa3hMT1RMUno0dWFPNi9OVllnbXc4MVJBN2hB?=
 =?utf-8?B?RGN3ZXpybEVUQy9ndG1ycXRLaDRKWlNjMzN0TUVWREhQZ2ZxS0w4SVVsN1ZE?=
 =?utf-8?B?dGI5RGVBaEtidFAwa0M5eHFjZ29WMld1SXVBSXlGSmJIaTJ2T2U5YXg0UjIv?=
 =?utf-8?B?cjFoQm5WbEVTRzd6dVZHSHpiUzdUeXZ6K2paMHZrelBrQTVnWWh2cGsza3Qv?=
 =?utf-8?B?eWxmM3FSYm1VZ2RIbXlINGFEdTg1cnd5Z0JyNStCYm5YSzNWSFRNN20wb25T?=
 =?utf-8?B?aWplN2g1TFJwY2t4djc4TndjclZtYjN5OVFyeEliVHRFaDFmR05RVkg5aWlX?=
 =?utf-8?B?Rkdrdm84aHZZNlltdUlBNEJ3MEo2anVVVHZ0NThyRWE4eGl4aTFHSzNPM2RO?=
 =?utf-8?B?QjQxcG9scXlQWEpvYldldjI1VUNXcW1WUDU0R1QvdFNBeDhmcnJVYWpWbzEy?=
 =?utf-8?B?bTVzOW40NktUNGJUNDJvV3h5MEdseDdsa3JvaTJWMDF1ek85S1VoOGNodUkv?=
 =?utf-8?B?UXlrTmJ0a2JvQ0hONHdsTjdYaGtFOVhoZnZqSVFDTHJZYkd1NWNEVmVyT3dU?=
 =?utf-8?B?bDEycE55Ujl6UjZhRzIwUk1BQkZPeWs4eVNHN1lHa0FzMCtqcjdHYnBVVDBk?=
 =?utf-8?B?MVp1VHhqRGY1SzNuV25BNFpwa05NVG5vMnVDVmlrWHRqSlpLUHFBcmVsdTNq?=
 =?utf-8?B?SlBmdFNiZjc4eG9PaXo3ZWd4Y3NqVXZPVnFNc1A4ZTI0OVRvbWovVmFzNWU5?=
 =?utf-8?B?SEs1bEJERTdZN2J3eFMwakE0QmhjeHg1aXcvVFdiZzgzOElyYi9RaFBUVmxQ?=
 =?utf-8?B?NTRnOXgzQk5CaFJaeXhPbzVueVFJY2xsNnZpekFjNFZwNnFDckIyUDBTL3dF?=
 =?utf-8?B?cG8zenp0YlpLRllkYW9tck1Td3VYeW95Yzh6Z3lubjk0Q2puT3IrUFBZYks3?=
 =?utf-8?B?OThqS0VzMWtrSHJvQWdaSy9vOXhxbzQyclpiWmZSK0hrOUtFVVB0bkJRVTg4?=
 =?utf-8?B?Q2wxMFoyR2FTQTFMK0VTSnBmOEZMdkUrcml4azdVOFdEeStkV21sUWZ2NFVk?=
 =?utf-8?B?R0xyWEhpdFQxcWZrV2JaYnA0RjdBcUFRcHVUWnRGczJOeDNWNC9JbTgxaFd4?=
 =?utf-8?B?Y04vcG42N3pXOU1xQmVLUWpkcExWME5kYi8vU2hUV2VqZlQvd0dDWFpxUW1q?=
 =?utf-8?B?NnExbGZUSmRoTUtnemhvQW1ibmVHNWtCWVgybjZIVnYwUStvdDdMeXZVT1ZR?=
 =?utf-8?B?SEVSeEV6VWN0WEpRcWNPVUdCeUhSS3YySk5zdWVmbkNsYnVCSzhRSDhVYVZx?=
 =?utf-8?B?ZktjQ1k3cWE3NXo2YUFyOWxTOFVCTy9RSkw1Q1RlWVR1Q3UwWGNqVW8rcWJI?=
 =?utf-8?B?aTVNaUN2SlFpUUt2TlFxdllJSk0wU2k0S1NwUW1HZlFSZzdLcTFRRzRjNzZ1?=
 =?utf-8?B?aklOZ282M2orSm9GeGV0K2MzMWpBOTJaN3BXQ2tTSDVzRy9lNWFobDZ3NURM?=
 =?utf-8?B?UVgzdnlzR1RRSG0wQ3BwNlNJdmVJV0FtbmV0aVd4OWd5ZHYxL2tmbEVBYXJ3?=
 =?utf-8?B?VWp6ZW9tOTFJT2oxajRXcGdEOUZZZklzZHMzYkV6SU9KajFOelZwYmdMQ3pI?=
 =?utf-8?B?cjlweVdVZFRqL2hjK2QzZExJc1JVTktJNjNwdlBVOUgyVXpXWHVDb2NtMFY3?=
 =?utf-8?B?NlBrR0lCS3NXSjlOQTQvZWNpaTVWOGtBRUIxdmNSbEhRRlEzOHdGRW04eG9j?=
 =?utf-8?B?MnRGUmpjNHdVMFFUYk16Zys1aFFVODcwM2ZyclMxcE5EL1M1aEdlY0dmSFFw?=
 =?utf-8?B?L1MxblhIY3hPSmxydkM3UFdCZGtseGp1VjR4bE5DVnVYUTdGY0ZlenFCdXh6?=
 =?utf-8?Q?qboTLSBHjuwipHy7DLqxmKS2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e9f128-ce6d-4096-8c11-08dc548e4b60
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:02:10.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5J1FXIQWULBx0cdpaK09YkCLqcwMzxl2FExivqAfuCqGSS1k0O1cgORSFqMl7aiF9bIcrrd8GD/yw9k61P5bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
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

Hi Alex,

On 02/04/2024 02:42, Liu, Shaoyun wrote:
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> Comments inline
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Saturday, March 30, 2024 10:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
>
> Makes it easier to review the logs when there are MES errors.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 65 ++++++++++++++++++++++++--
>   1 file changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 072c478665ade..73a4bb0f5ba0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -100,19 +100,51 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
>          .insert_nop = amdgpu_ring_insert_nop,
>   };
>
> +static const char *mes_v11_0_opcodes[] = {
> +       "MES_SCH_API_SET_HW_RSRC",
> +       "MES_SCH_API_SET_SCHEDULING_CONFIG",
> +       "MES_SCH_API_ADD_QUEUE"
> +       "MES_SCH_API_REMOVE_QUEUE"
> +       "MES_SCH_API_PERFORM_YIELD"
> +       "MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
> +       "MES_SCH_API_SUSPEND"
> +       "MES_SCH_API_RESUME"
> +       "MES_SCH_API_RESET"
> +       "MES_SCH_API_SET_LOG_BUFFER"
> +       "MES_SCH_API_CHANGE_GANG_PRORITY"
> +       "MES_SCH_API_QUERY_SCHEDULER_STATUS"
> +       "MES_SCH_API_PROGRAM_GDS"
> +       "MES_SCH_API_SET_DEBUG_VMID"
> +       "MES_SCH_API_MISC"
> +       "MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
> +       "MES_SCH_API_AMD_LOG"
> +};
> +
> +static const char *mes_v11_0_misc_opcodes[] = {
> +       "MESAPI_MISC__WRITE_REG",
> +       "MESAPI_MISC__INV_GART",
> +       "MESAPI_MISC__QUERY_STATUS",
> +       "MESAPI_MISC__READ_REG",
> +       "MESAPI_MISC__WAIT_REG_MEM",
> +       "MESAPI_MISC__SET_SHADER_DEBUGGER",
> +};
> +
>   static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>                                                      void *pkt, int size,
>                                                      int api_status_off)
>   {
>          int ndw = size / 4;
>          signed long r;
> -       union MESAPI__ADD_QUEUE *x_pkt = pkt;
> +       union MESAPI__MISC *x_pkt = pkt;
>          struct MES_API_STATUS *api_status;
>          struct amdgpu_device *adev = mes->adev;
>          struct amdgpu_ring *ring = &mes->ring;
>          unsigned long flags;
>          signed long timeout = adev->usec_timeout;
>
> +       if (x_pkt->header.opcode >= MES_SCH_API_MAX)
> +               return -EINVAL;
> +
>          if (amdgpu_emu_mode) {
>                  timeout *= 100;
>          } else if (amdgpu_sriov_vf(adev)) {
> @@ -135,13 +167,38 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
>          amdgpu_ring_commit(ring);
>          spin_unlock_irqrestore(&mes->ring_lock, fl
> -       DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
> +       if (x_pkt->header.opcode == MES_SCH_API_MISC) {
> +               if (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes))
> +                       dev_err(adev->dev, "MES msg=%s (%s) was emitted\n",
>
> [shaoyunl]  Shouldn't  we  use DRM_DEBUG  for valid  condition ?
>
> Regards
> Shaoyun.liu
>
> +                               mes_v11_0_opcodes[x_pkt->header.opcode],
> +                               mes_v11_0_misc_opcodes[x_pkt->opcode]);
> +               else
> +                       dev_err(adev->dev, "MES msg=%s (%d) was emitted\n",
> +                               mes_v11_0_opcodes[x_pkt->header.opcode],
> +                               x_pkt->opcode);
> +       } else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
> +               dev_err(adev->dev, "MES msg=%s was emitted\n",
> +                       mes_v11_0_opcodes[x_pkt->header.opcode]);
> +       else
> +               dev_err(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
>
>          r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
>                        timeout);
>          if (r < 1) {
> -               DRM_ERROR("MES failed to response msg=%d\n",
> -                         x_pkt->header.opcode);
> +               if (x_pkt->header.opcode == MES_SCH_API_MISC) {
> +                       if (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes))
> +                               dev_err(adev->dev, "MES failed to response msg=%s (%s)\n",
> +                                       mes_v11_0_opcodes[x_pkt->header.opcode],
> +                                       mes_v11_0_misc_opcodes[x_pkt->opcode]);
> +                       else
> +                               dev_err(adev->dev, "MES failed to response msg=%s (%d)\n",
> +                                       mes_v11_0_opcodes[x_pkt->header.opcode], x_pkt->opcode);
> +               } else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
> +                       dev_err(adev->dev, "MES failed to response msg=%s\n",
> +                               mes_v11_0_opcodes[x_pkt->header.opcode]);
> +               else
> +                       dev_err(adev->dev, "MES failed to response msg=%d\n",
> +                               x_pkt->header.opcode);

Please consider this small reformatting here for better readability:

static const char *
amdgpu_mes_find_op_name(union MESAPI__MISC *x_pkt)
{
         const char *op_name = NULL;

         if (x_pkt->header.opcode == MES_SCH_API_MISC) {
                 if (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes))
                         op_name = mes_v11_0_misc_opcodes[x_pkt->opcode];
         } else {
                 if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
                         op_name = mes_v11_0_opcodes[x_pkt->header.opcode];
         }

         return op_name;
}

op_name = amdgpu_mes_find_op_name(x_pkt)
if (op_name)
         DRM_DEBUG_DRIVER("MES msg=%s was emitted\n", op_name);
else
         DRM_DEBUG_DRIVER("MES msg=%d was emitted\n", x_pkt->header.opcode);

r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq, timeout);
if (r < 1) {
         if (op_name)
                 dev_err("MES failed to response msg=%s \n", op_name);
         else
                 dev_err(adev->dev, "MES failed to response msg=%d\n",
                         x_pkt->header.opcode);
}

- Shashank

>                  while (halt_if_hws_hang)
>                          schedule();
> --
> 2.44.0
>
