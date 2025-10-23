Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE6FCCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 19:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFB610E12E;
	Thu, 23 Oct 2025 19:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzc02S8m";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D0B10E12E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 19:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDlx0QtymjC4ePywtLdSs+Owjy0c+UNU3LsKANojBAE/RAPgXffHScRQwpSnFCejg9Xw/HSDVMhf7M2ZhOgl7KaPcznfyAIS1Qhn4AqWII4GzhwUNJNGQDpoX4KI8t4kGmlk0H9uOucJo0uiALi8iTR9Mp/sPG8W92ndIl+6aPGjnk4Zu1SjR8kD2/JrsTbjpS+LcIryAcWNHHq0+E0QS7+gIhpxPGhe+eXr/QTiZb5JfB/uPcneXPtWIuuQx/m8EMXsDXjjsgOnV7suMNqFvMLJEisE1nWbzDAUzNo8fBnxaUT9gndSjbsTQuxlgsUXXj054RbW4gLtOIWW/xdKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOH67I3/OOxi3JvwtQFZraxNqnESbCZq3uRhZ4rBog0=;
 b=SdwADAaoJORMJA+3RZzoI7++ff9ijqd0yebWbuD1nkEDAcS+dsDZ+8qH2oGSa//bWm+A4eQoNxvUSOUHf3EIX1qj9Yok/96XDXy61kNvAwc9JwNYik0jCX19t9J+t29GxXRMBM9LN81tv5gre3NY5NLl0W/mceTZtEaKbyiSyd6VqBtbM4ZEO7GUiLxdCiiJFYzSc198y9NGcap87kpG0S5rbSHiJhvWkMhENfrKeVG3Da98/oUQ2W4ebAr80PCQkz+5e4kvriDtY67Aec36Xs7twv9VXKG8bvoqZY3ventjCBcn5D3eTmte0Pvr4nJbudFAwG3aB+u02A33fAapGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOH67I3/OOxi3JvwtQFZraxNqnESbCZq3uRhZ4rBog0=;
 b=vzc02S8m3k0zTMZ7Av7eId+6qJQu3XRlEnJICxOzRMHqvBJ6eSG5l9OieG5W7YGSnhY6rFOTjXEQ6X/Sc0AaY4qei8RM284fGq7aUMqI+FajvtimJMa1oVUjOzgwyBQzP8vIoqgGTe/bhLDGOkYwtSYg9Gt4Vt8DqvMbsrxAUPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PPFACF832414.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 19:53:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 19:53:34 +0000
Message-ID: <3e30547c-cad8-406c-8f47-707b91856090@amd.com>
Date: Thu, 23 Oct 2025 15:53:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Dequeue user queues when process mm
 released
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251022181601.10142-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251022181601.10142-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PPFACF832414:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7199b9-cd90-4584-6da2-08de126dd9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXZWNlJFTlRXN0g5ejZlQk1HcTlEbUVqckpDN240ZU50Y0NqbFVBTTRtbUlx?=
 =?utf-8?B?TUF2SjRQS1Jxa1NqWWpZcVNjT3hBL243YTd0OUZYVjBXOGJ0QTR5TkRNZ0NK?=
 =?utf-8?B?dWdpUTRNRHlPZzYwQWlReXhBYWR5RFBTWjdoOVVHL3Zva1hFOTRWM1ROSDF1?=
 =?utf-8?B?T25KS1BhYTJNSnV2U0hYL1R5c1dhakpFekJXdGFzT04rS21IOFErNjVmcFFC?=
 =?utf-8?B?eHNqK1BacFJNanZQWjFBWjBXTDFDZXVGM0Fwa000dTd0RUc5Z1NINkk5UVRI?=
 =?utf-8?B?aEJ6YXNlU0tkQlFMK2ZPUzFsSWt4eVN0SWtkdUNiTGk1RWFVQldYdENFVENY?=
 =?utf-8?B?Y3plTTdsQnkyUHlKdUt4TzBjY3ZaQXVRS3I2VGVYMDNIZzRRRGF2VmRqNUEx?=
 =?utf-8?B?Y0dzOFltK242ME5aaGFROERqaStKRFcyekVGTzZmbU5kVmxlZ2RhU1FyMDhw?=
 =?utf-8?B?VlBTTHQ5N0QxNkg0ZERvTnNHU3VjbWlxNkJqU29oaWtwNjFDbXNPU3dEQzN5?=
 =?utf-8?B?NTh2V3I2M1ZQU1RZZHg2bkVQR2hQUTQ4Y1BzTWtIT1A1QzZUTzUrZ0Q0NTd4?=
 =?utf-8?B?Y3BVTFdTMzI5dmNWcTFZVktWYUVSWnNnbnV2YkE2LzIzMHZEdWpDcVpXWkNB?=
 =?utf-8?B?VEFoSVVlNFpBY096MWJ0SW44SG9haFpLUWhSM0VWQ2hFZnRGemVSYWcyL2xj?=
 =?utf-8?B?clVTOXRrTlp1VEdCYU5XMHo2NEhTZDF2RlhMTTk4Zm1YR2w3S05HMi91SnMw?=
 =?utf-8?B?dDY0aXJORkFGVm00bVN6OTBBWnFLSUlsWkE3WFZYN0YyVmdvZDAxdWxqRzIx?=
 =?utf-8?B?ZkMzbnZxSm5uR2Y0WnZsRjVZL1pURmdRdjBpb21UNVRnTXk5QVpnMUJYbmhM?=
 =?utf-8?B?N0xuSzNGd2Q1SUFaWEJXTTgwS3owcUlQUTJXZXgrUzBxME9GMS9LK2lTVm5T?=
 =?utf-8?B?bmMwZTlpQzd5UzZLZGVGaURsOFRCR0tDNnA4YjlwaXZ5K3ZxRE1LanljL0FU?=
 =?utf-8?B?djl6YnQwYkVsS05ERXZ0aHkvaW1OejF3Yjk4cTlVeE1PdmpHRnB4ckUyUS9n?=
 =?utf-8?B?Z3IwMGFvMUNrRytXOVpPVzBHTE9VaDVTL2tRS245WmdGSkYzbFRmOE96aFpU?=
 =?utf-8?B?NzEvc3V5L05MaTB1L0ZEMXcxK3pjYnpQb3dCVjIrQi9VaDFhWjBzNFA1UitI?=
 =?utf-8?B?bmpGTDVCSlVmOXZlQ0ZGZU1WVkZvRnU1TUcyTE80YnpTRERZc1kxVlhmemtq?=
 =?utf-8?B?OWhxck5oQ1JMTW9UUkxPRDZRZ3VOYWJEdE8wT1lidlQyeTlsenBRVlU5Y3Uw?=
 =?utf-8?B?T0JUdTBienV4cC8vZjdIWnFsMUYyME9VT3c3MldNRXg0NUxlVnZSL3RabHlv?=
 =?utf-8?B?bDY0cFhCQTFmR3F0MVlZeWtlYzhxbjBiZGpOYUFGcmR0M2JLNk9oTENSWVVa?=
 =?utf-8?B?TFA5ZC93bUdHbVphN0dkZVBGZEhxUy9GanJCMmdQR05Hb3dDOE44WmZ0eTFW?=
 =?utf-8?B?WGVvbThuZm1YQmgxdlRxYno2Q21HMjdONHZjdU5pQ2lZcTlTbnFISkIzcVpu?=
 =?utf-8?B?NFc5NWJyaTlPM0JTL0dpNC8zNCtQaTAvZWF2TmYraEo5UU1mZEJ2QjYxOENi?=
 =?utf-8?B?cU5ib3J3NnNpQXRGeEpBRUQ2ek5JTkRZc0IzTEhlL1ZuSTlUd2FGZUMxeVdV?=
 =?utf-8?B?TStUV2F3a01sTFdQek54b0hnQnR4a0FQWFNFS0YwdzRGOExVanRzTzRlOW9R?=
 =?utf-8?B?SWplYlZnSk9teWlFWjBEd3hzaFhlVHFsSEgrVlVXZi9xWnIvL3pJWGk4SkZZ?=
 =?utf-8?B?R2xoUGgyYTkwVzdiTFlwY2JXMzU4QVpYUzAvRC9CWUpLYXFwSURvYS82cER1?=
 =?utf-8?B?bTV3ejIyZFZHZ1RlaDhwdDlmL1Ayei9RaHZBTjBhemRqa0dzS2ZRVk9jZEd5?=
 =?utf-8?Q?4OT9ciYZrMrhVxgEstTQyaJx2Nr2jhIo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGtTZENvclFWYktHSWF2d1YrK1kxOUtaVE9zbHNHbklxdmEwc2lvMXFiQ3NI?=
 =?utf-8?B?UnA1TTlrQXdzNHc3S0JyR2xxakMxbjVETDhYR2NOSHp1bzUxZGtWekVrdW9C?=
 =?utf-8?B?c3FTS3BrcURjK0YybmF0RkQ1MndKdUlsS1czbTJLSEQ5MEhPZDIwdVZrZkw3?=
 =?utf-8?B?TnhkTkRPNUR2RDhLQVFjTHh0S1BZNC9zNlljdlhFSm1tMVZIaFRzRkNjdUNH?=
 =?utf-8?B?UkZERExUczl5VERwL2FrQmNqNTdLQUt5T2lGS2Ryc29taWJGRG1uc3AxTU5C?=
 =?utf-8?B?ZGtHbG1GZmxyOHpVQk9qV3Y2T2JqSWJwaU1Rb2cyM3pXTS9JNUJubjdmaEl1?=
 =?utf-8?B?V0RCOEp1VkZzYnB6ZFlsWXE4dkhuS2pmQmlqbVVyeEo0bUZnZ0Y4Ri81MTh1?=
 =?utf-8?B?dFNVQ0VnWU5tczJtc3NmRkdwa2I4ZExoanBQMGpXTUlhOE9QTGQyZkVPQVh3?=
 =?utf-8?B?ZitOM1JJWVZNRUdLMEJTcnZPbFoxY0JkSUVLKzY2K0lXZVNLazZqWmRESEl0?=
 =?utf-8?B?MUxmV1NMMzZZaDhGTkNEVk15M1RFZkJlcThBMmJmQUk0VE5zbFR5bjZnYlNE?=
 =?utf-8?B?a2oraWpLVTdqWm9HcHkxb1FqZlJuTGRzVE1FL2gwYXpHQzBkUnpzVkhIc0VH?=
 =?utf-8?B?dUFsQjhNQ2lENlVveDlmZkcybEVFQW5iTk50RkU2MEFaOUJuTHlHZGVSQnQz?=
 =?utf-8?B?MmJYbitSUmZFRk5IZG04R09TdGhVYWhFaVg0WVhMWC9IU2ozQnR5QXdxTjFN?=
 =?utf-8?B?YVlDY0VTQTE5c3AzczdQWkorUmhUOGp1YVptS01HV3k5dGtsSTVyalR2am5L?=
 =?utf-8?B?YzJTNmVrZUdkTk9ZeFR4VVpYYS9objdmVWVDY2ZlZXF5UlZPMndFaW1SVGhR?=
 =?utf-8?B?V1QwRFdQcnJIR3BTSWZmdnQyNElpLzZwWHRFcnN4NnExaFhKd3R5L243RkxB?=
 =?utf-8?B?bE8zVERSOUIrVUlySGJ2bW1yMm52cmRGS1FOTENWb1JkVWZYZHdJRCtiTXpw?=
 =?utf-8?B?S0crV3h5NGhSRmNsWFhSODBPdGhoSlhvdWVLNDhvQ0FlRVhtTnVrc255RWJI?=
 =?utf-8?B?aTAxc3ViQjFQS1FWdGhLcGdYRStFWDZiZklvQ3Z0SEtNWkZVL093dWxLMHY1?=
 =?utf-8?B?MTFFc1M2R2o2UldITHdCS2VyenlVYTdsa21uTi9UQ1B3OTQ3SWpwaGVNMmpz?=
 =?utf-8?B?U0JUQ2VhQlNRdmhTdi80NE96VHgxb01CUjdoeUtKcjJHaFBablFFUVdKOHZv?=
 =?utf-8?B?ci9oTDU2ZkNQc3AwUlNYeUo5ckdmRW5BbldDNGViNWdqRHdkSWRyMDZvZXh4?=
 =?utf-8?B?aXlMUkVQcm9aMlhVVGVIbjJBSlRoaGdzQlVBclVaWUVNMFc5VUFLUGsvVlBW?=
 =?utf-8?B?RzBJazhkcUtjUGVNVmlVTy9NaWpQbTRtRWt1VUlOMVQyeUpCT1JpcU1yRy9w?=
 =?utf-8?B?cXM3UUVlMzljSmlKbmhUWldwckJhdW5NWEczcy9aVlNHSGU0ZUVjRUVreWxt?=
 =?utf-8?B?VG5jbGJlN1ZFakFjS09EdGczaE9laHVEMFNBOGFGb1dNcDB1enZGMi9JTldw?=
 =?utf-8?B?cjcrMlE0Tng1VjNsK3B3VmE5TmlQaFliejQ4MkZBZ21DY0plWk9Vbmh4cDZa?=
 =?utf-8?B?Q0dyQ0l1WUIzNWpEekpIRnpVK0FyV0VxQU9tQ3RLSmR4K3JtSjNVajFuYXBP?=
 =?utf-8?B?Z2djUlE3QzNDbmp5ZmdoVjZxNjhSWXNyZlVBTG13ZTZpSWhDRWhCT2NueGhl?=
 =?utf-8?B?UTBNSDVOL0Fmd1k2ajdhN0poOXBxMlFHQ0wzL0lHb21oT3QzNWVKMnk3bFl6?=
 =?utf-8?B?TUMraW5nZzdiTEl2UHBFZ2hhRmhhY2ZIZStnYjJxM3BvNkkxVHZlcFRoVlhu?=
 =?utf-8?B?ejNBOGdvK1hUWjZVckxBdWhkRVBrNCswOEhsZGhrM211b3F5RzlkWi9haGpB?=
 =?utf-8?B?Q2tUMHRJVU4zdWFaK1E1YWpSM2lzaXZLTlhEa3YzMi9vU2JjWnB0WW1kaVRW?=
 =?utf-8?B?TVJlL0xBUzVmY1M5eWdoeWg2enZudVh6cFc2VEVhMXpqMmluazViOUQ3bjdB?=
 =?utf-8?B?Y25oUE1lWGNUVnVVNDZMZXNBcEE5R28vbEo2a3NXLysvYTVQUGp1YnNhdXg0?=
 =?utf-8?Q?IZwnEF561EHNIiIxr7kUKkeTf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7199b9-cd90-4584-6da2-08de126dd9a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 19:53:34.7382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew/3d5BT2A9oEubbdZh+NiyocZ3IgWLLXn34EYgiM2ED1E0VHG5OsKp1b9jAmGrev5VLOCalj5sk++EgpPanOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFACF832414
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


On 2025-10-22 14:16, Philip Yang wrote:
> Move dequeue user queues and destroy user queues from
> kfd_process_wq_release to mmu notifier release callback, to ensure no
> system memory access from GPU because the process memory is going to
> free from CPU after mmu release notifier callback returns.
>
> Destroy queue releases the svm prange queue_refcount, this also removes
> fake flase positive warning message "Freeing queue vital buffer" message
> if application crash or killed.
>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 849456ac498b..b429ee4c4ed7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1162,9 +1162,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>   					     release_work);
>   	struct dma_fence *ef;
>   
> -	kfd_process_dequeue_from_all_devices(p);
> -	pqm_uninit(&p->pqm);
> -
>   	/*
>   	 * If GPU in reset, user queues may still running, wait for reset complete.
>   	 */
> @@ -1226,6 +1223,14 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
>   	cancel_delayed_work_sync(&p->eviction_work);
>   	cancel_delayed_work_sync(&p->restore_work);
>   
> +	/*
> +	 * Dequeue and remove user queues because exit_mmap free process memory,
> +	 * it is not safe for GPU to access system memory after mmu release
> +	 * notifier callback returns.
> +	 */
> +	kfd_process_dequeue_from_all_devices(p);
> +	pqm_uninit(&p->pqm);
> +
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
