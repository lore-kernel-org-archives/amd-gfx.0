Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE57B103A999
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 02:28:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57CCC10E68C;
	Wed, 25 Mar 2026 02:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndt5/fhM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A5F10E68C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 02:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV57tyTxRCMiAMIpNsCTkwGbBGP2Ov2M7F7WBWCL7fR2NnuInKvA7jLgtZxzw3aq3SL6VMH6hPrDyoon4PSBn7MXJyyO0td9ANSA5KUyGuJ5LKrp5CMX2t4irKxDoUxhXZAdLTM4nvXwBjEty8loCZKLvUVAQzVlW4SYkLs8GvS4Ix1/lP+TndyPOmfRoWgjKw0N13kdTuRhu9GHg8LhLrvM2ApiY0AC/EPOf4DufDmBpIcjF/VBxM1sQzU6woXAWeGEdFC2+KrPzqP3NBdkWGa643U+WEPyPARp0t0RhpmkCwzLrfVNWHhVFpkVJXC46Reb+aN44G4xpDer4HSNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boVTDhMMQFx716pJ4HZ7xNdK6yX32iut4uDRXHLYqYo=;
 b=vgVD8RdB1c90yPt4O2pl9su+8a08kRRttnKW448/0mrgokQ6O9Ca9PvW0kVLQXECGBnzYmZCYJBp+Mxrf69zRxLgZjLJ084q3ZSKiH2euRxQ+zMdA/lpnc0y6ljgMgl9cNjVJgeG9drNAtdUwt5T9xhSRMPn4Bl9bwkpTLyiZy/L1maEMCdm/jo+aC5kHD9VETVqcc5QWMfu/ynD0+L2nvLw5cVE9SKF+aZo+hsyJr+04+8go7wuZX3fDq5o48in5xHYSWmmrJlRXiegPoYz1IkMCX/v/LUzSnUjqwRrhSt40I67p5KUzxFfeq7zckMyMz7GVYFP+rExWPGLodVw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boVTDhMMQFx716pJ4HZ7xNdK6yX32iut4uDRXHLYqYo=;
 b=ndt5/fhM3f9g/anJrtGVLgXqE9HgjDiQdbWQtdVMJg8coHwmW6lWVnr59uTQwB0vzZ0S7upcKn5mmp0LR2HFQ4VT1LAqGT1wVtX3bmdNqBHAuIVufk/gCQxw3mmESfYTwgQJJi4BG8HpBumGKqong4uM9smvgonuVgc48PE7Avw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:28:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:28:03 +0000
Message-ID: <08ad0b48-72a9-4f44-8f48-28a00e96286c@amd.com>
Date: Tue, 24 Mar 2026 22:28:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 2/6] drm/amdkfd: Align expected_queue_size
 to PAGE_SIZE
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1afca38f9d8b7d8ce16694f37edd006c15c9bd2c.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <1afca38f9d8b7d8ce16694f37edd006c15c9bd2c.1774239489.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e522699-f209-4a87-715c-08de8a162455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|7053199007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oWKaVFtYZxrgkB4X5/FMlqa8pYgE5c/b8DwPYEye0fFhoVEjsoILliMFsdjIrSyM//TiRRjtOzph1BBJ7R0UWIZ1fdqa3WB1VMhM3hKZhKNa618nhS0recyqrge8lSNYoP5k/To17KhK66MJq0FYrNFuUeuFtMAyta7EI+8+AwUGfipkGEN4lbyR3lIv7NKUsGg5bdVc6yFGvWI3TbJ5VOEQQwF1FczVt07xmwXOu6AqR9HRcsHJ8s5L5Yt3/y2OzgB6dpnvJgVaoBltva5DVU1rOM5sB8gnZSpHsSe+dJ5JiuBnqDHPWE2O5j1bwNxvvdl6dPYC+vrjbxmL9xeJ3cnYiQ6DOru94pPV3z9B/XMfC+NwWyU4HRT7sQB3BeIPyDnmu40moPCfHQVGdps58Wrqxk7zY7l/s2GUjtQ//lB2Wu64Qlq3XcU9CGCrdpxej/EHg1oY3i0aWiqbWMqjuafFFb2Ef3iJ7cnl988dj3VOYq9MEmc1uPAmN/S5KlBbGaLvAbpPBsmk3uDgrS/ymXsO3NUK9yoTEAFiPkpy6//7XzjWzmmjNFV+947BVElC7GWlHhulfVNUSvF1NKBtWnR91sIOeOaR96N1PolwfMNpe3zecqQt+E64LUtEoDq41FckS68plfW2noVciGAHN3zOqmq+rT96Yv1Jebc9W1UTc1JnMkZuSMpordgI0RUfEt17yoL9Og7c/CwnglFhjQjlk+BD2Pa/BBGws/jY+jw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(7053199007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNhUVVCUFVrQS9YbVNrNzhheE9PTTBXRDc2NkVGNVNjcE9SUExmQW9oZFA0?=
 =?utf-8?B?M2RkQlNza2hDSnpCSHZpNjVYeVBBNFBzUElqQ3Y5TDVHNlVGVldYRXMyV3E4?=
 =?utf-8?B?dHBGd3dZTTQ0NE5sb29ZS1hURWhiZGJrUDBwT0x1NW8wNUZPajFxL1FISGxk?=
 =?utf-8?B?bW00d1dnWDZPb1JueGNmRU5MYU16V0JnL3FqZmRaUlpIQnNOSEtYWlNaK25h?=
 =?utf-8?B?aERWRUluOWF2Q1NRZ0dTNUtWTkZUcm1xVklEVm1tODFhS1JycEtjTlMrWHZk?=
 =?utf-8?B?UGtlb3ZsbjJ0dU1UaWpnWTVXMnhIMWxMM3B5ejhweHFFV1F6R0tYL2V2bDlm?=
 =?utf-8?B?Y1psTjIzNUYwODlGcDY4dEZ2U0FibzFoZmQ2MzRnN014SUhKTGpwYVpCTS8z?=
 =?utf-8?B?cjJaRnBQNXZnV0NMeHl0aTY0VFN3MGFXVnV4dTYxOWhLRkJuZkd0U1dMQW5r?=
 =?utf-8?B?aXpwVDVSdWg4bHljR1dlMjNaSWl1L2RDbnJlM3RoRGhpa01rbEN1c2JCbEps?=
 =?utf-8?B?Nk9pdFFRZktLRUZORDVBRnlZeWQ1Z0cyUWt3anJpc3lYendJeVRXZkhOVWRP?=
 =?utf-8?B?c05OTEl6RWRFcTRaK2lTVHZiNElROElZbnd6dlkwVllFY2JlT3crcVNvbEhE?=
 =?utf-8?B?eEhpa1pqVTduS0NBWUFKZGJyb2J2bVdZeGtOcUF1U1BBQkxJVWI1VVh4Q25V?=
 =?utf-8?B?MmZZcGhyOTdqemhyTC83WHJKQm1ZL2JGOXNXWXplL3V2UnRBTHU4cFdLYkk2?=
 =?utf-8?B?dVZaUEt6NC9EVlRLK3p1Q1pCeTM4ei9hMWhUaW1hVXd3QWpXVENvOTBvZVFp?=
 =?utf-8?B?dUdOZlA5UzkyTTVONGZQeFVPVkhSYVZnellHT3VLTlZXc2RSbW94cVRmNkNO?=
 =?utf-8?B?Q0twUTcwR3ZxN1FGYjR5R3N5eHZxYU5yS3IxM2IzdVdtaWc5RnBtUEpRalY4?=
 =?utf-8?B?anR4amFzaTEreVBkSnkrTDd3VVZTNHBTZUhUZ25rYkpFRmxLaVNFdVAvMnd0?=
 =?utf-8?B?Q1A4cXo5QTJZc1BVUEt1RTlGYkx5UkE1V1Q1Y21NOXRxQjlpZ0pVMXg4cm00?=
 =?utf-8?B?ZERIK09ibldTWnN6Mi9XYkQ1d3lsOWo4YVAveTdiNDdOTkd1OTBobzUxWEV0?=
 =?utf-8?B?UytZMllPVk9IMGl3b2lQalMwODZFSDJ4THMwelh1WEZsY24yWWNFSzFVRWNi?=
 =?utf-8?B?S1hNMHhmRHF4ZUU4M1pXblZaMEVYeVVHN2lNTS8vNHdoaTBLNUtLZ1NkTnYw?=
 =?utf-8?B?YzAwWHNYajQxelpKQ1BGTnBXVXdLY3R0ajJ1MWY4d240VnpROUYzT3BoY3h4?=
 =?utf-8?B?K2VvWVR4M0h4OEJDajhyeXQwaUJJdkhzTjR4ZHlFUXErK1owYTQzOWhESzgx?=
 =?utf-8?B?NjQvTnJyTjhmc01HVW5LRVB0K3k2LzRVM1R3OWkvb3VHQUtpWGdNbVd4OXF5?=
 =?utf-8?B?cHdXWUp3SXZrRGV5aUFiaThlRGl6ZFNTdFNEUHhTZmMvSGE5SGlIWDVnR3dm?=
 =?utf-8?B?ekZySklVS2VDd2NwOW94WDlNQXpack9mWlgrdHErZEppajBITEVqTjhPT1Np?=
 =?utf-8?B?cnBMSW5EeTJmcHlwUUFwbGZGdXE5UnFNTzAyRmhwMW0wZHFjTlZTL0Q2K25Y?=
 =?utf-8?B?MGhyaTlrblRVRkRYQ1pSQnlnbmhLQzhLQmVxWlNPSDczMnVNNzV1bENUdy9N?=
 =?utf-8?B?ZlQ1UlowSVFTRmhRVWJSUjBqRjc5RGlnUTI0Yk5zZTlGU1M2SkFja0h1enNn?=
 =?utf-8?B?TE1NeXJDcjllb2lzRitLV2N5Mms5dFQrbHZ2NWE1K2hqN3pBSk9aa2xUS1dP?=
 =?utf-8?B?L1piMWVsTktKbXdqY0lha0xOSjlqMEJSNlc4ZzA0TC9raldRSUxZS1F2UUFa?=
 =?utf-8?B?TndzaGtaQW0zcWpBQ2lTWFlyd051bUF0TUpkL3FmUXI4MEFWdmdwSk9VYTZR?=
 =?utf-8?B?VlNacUtkMGVmVWdrK3pFVWR0NnNJSk1yVzN3KzU1blVxbGlhOFd0cC9pY2th?=
 =?utf-8?B?WENFMUNnR1hHUkJhYUc1SmxuaFhTanFjL3VZbjVHUk1nM2JLOW45akQ5dkNn?=
 =?utf-8?B?V2xlbDdXUHYvaDhTTmdXc2lLMVJMVS8vRHFjR3RYbGlhak9NOS9WM0NpWlRx?=
 =?utf-8?B?ZmFhbVV0c25VQU1GTXpKYnJTbkhRaEMxd1FEZ0s1RUp3bElId3ZxTU5DbnVO?=
 =?utf-8?B?Nk5IWnVaeCtONmNwaW5RVGNxV3BWTlZtV1NEVWlNc1hYdlRTelJmNExFcWxj?=
 =?utf-8?B?TzlTOTFJMWZtYVlnbE9MVHBsTi92OFI5V3F4dXhjUzlLbkhKYWx6WC9LZGRM?=
 =?utf-8?B?ODhtWWhFQkV4N2xSbk1RTlFuNHVGNjJxc0Zsa2N4REgwYXRQWjdKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e522699-f209-4a87-715c-08de8a162455
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:28:03.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlN7AByhbCzNJZnuOz7yZ91EOSqzkRfwdwg7eCYp9h2vmXg2m+SLv3azLlrbpN+PxrGMO8TuZTk1h55Vx2Znsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

On 2026-03-23 00:28, Donet Tom wrote:
> The AQL queue size can be 4K, but the minimum buffer object (BO)
> allocation size is PAGE_SIZE. On systems with a page size larger
> than 4K, the expected queue size does not match the allocated BO
> size, causing queue creation to fail.
>
> Align the expected queue size to PAGE_SIZE so that it matches the
> allocated BO size and allows queue creation to succeed.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index d1978e3f68be..572b21e39e83 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -249,10 +249,10 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	    topo_dev->node_props.gfx_target_version < 90000)
>   		/* metadata_queue_size not supported on GFX7/GFX8 */
>   		expected_queue_size =
> -			properties->queue_size / 2;
> +			PAGE_ALIGN(properties->queue_size / 2);
>   	else
>   		expected_queue_size =
> -			properties->queue_size + properties->metadata_queue_size;
> +			PAGE_ALIGN(properties->queue_size + properties->metadata_queue_size);
>   
>   	vm = drm_priv_to_vm(pdd->drm_priv);
>   	err = amdgpu_bo_reserve(vm->root.bo, false);
