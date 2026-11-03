Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041A606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oTZutIkR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A147C10F90F;
	Tue,  3 Nov 2026 23:04:19 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E9110F90F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMOHIjCqaM2nehKrcD5Y0tbF/ZtGWGpdFXTeL0DMTo0mi23zAcfPQIJQC747/retyXMBsmlFTV1wBiZ3z/8EsmFkSB/RpzE/ygATAioz97anUhHsIfW/GOlKhzfEWsVE6wrXXF7tf99PnKpRIJBSE/Hp7pQvIXecGHObfaeySP1IjBwZAfjDVcFtyMGFKaKcPYYDC1mwP8TgxJ3bViTv2T2yxyPvfbvm+JSz68lahJPWR9HfPMFComGujCsUUZwxW2R97MgUSbktrt+oYl/ELQ1O30guNnBsdZl3tIzBkc4brLGO4T8PjFAtSedBVGnnxWeIj/wPQOPEesVly61vbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2xAXvrE1NRjmo0R1Ojpyt3BEvq32/ZlGqkCQ44lnXc=;
 b=f61c3+91Hn0eIORFZCsypUbsN31aELbI+JV5QvkJw1JKxFVHhwEOpj1xD5RYtuG/wGuVce9AJxZVmEzmngzQiaPePtALpIWc8x9dXFyXCEOS/LeS7HVlUD+OODV12WupqtiDJCM1TaQbK1FPCA4kAsZCo2OLxKE647XHD7LVeR++apjzwigB2kgqV1YzBLXq6QvV1poQfluaO5h8cYp0imOg208qW8h8tSaBgL8ah3Eqxy1s1thlgdhE46MtDsqNdEexm2x/7wyQAEAiXf3t5K8qOf6Rj5L8v4TUINm5YSQVNmTqxmykEpuGSbAKw/ODGk+zS7CVF9PIR6jT8Sxe7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2xAXvrE1NRjmo0R1Ojpyt3BEvq32/ZlGqkCQ44lnXc=;
 b=oTZutIkRVdpMonEEducG2VoQTTHIddHqtkiAWr2gn+xKSDvBn6vPCsme2fTees+1kYK3mWMJCfb1aLV05+ppMjHY6SNYmYmFV1PDA4pSE0KVzAqOsWRs8+baycyPMDG0fgsIVZACv6j1xJ77k4B+KSy3+4UjB2wQG5QiuAdo9Fs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by BN7PPF9507C739C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6da) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 23:04:09 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:04:08 +0000
Message-ID: <9ad054c5-3540-4c8e-81db-b29989790b71@amd.com>
Date: Tue, 3 Nov 2026 18:04:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-5-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-5-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0427.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::18) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: a512467d-b755-4fc5-4226-08df39fec421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261021121427099003|261026121527099003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: fN2SzC7UjS4vCask+YjlRIDOppE1fGnggJOEzSZjIwOi4BbKD9V614FVKcFXW2DkKnxXgMUhnlYjm9fRi3Nu82rHtp/CFlm6CQZN9rnQhgL8QjfTe/Q8bSBYT1jGz48Ona2t6yUPc3hS1tnmZOR73361BWU1VBAxMHfZs4h0KEB7pmyZfO9CajvQ86CPHOdASamIvpaXq6cbXZhTzjD6yTHJk9dFsB9IfQMgnUnW+Psn3No4ob1145NxLOcUDfd2DQIoj4/Ut6jdSr3BUkTrUjLsfAQG0ZiDfl9VYae6YAA/dC7U8htKJeiRt7P9EUgEZ/bJrV788L4eWXkYWv3s//G4jH9YSDzguGklKie7/UKHlmx2GXv69ictbJUSIIFoPj1ltByz2S81Rli2WTxUVcu9qbHt4tSUgzfGMlFyAptaI2k7JJYg+u3by7A3zQ7I759PseJr1CKmJiDajdcv3J/Ua5ijHxrhgjP86jSx/ghKm8H9onslEatj7wLomzCwU174wnA6cB8D6G3MFrnok8/No3QZK1CVzCdHugvVWMBlGSBNXuewHvyHj7vecg6fEpmj3NRy4WMbd5H+qhj5Txfms/zihtglaPnXnjRkP80UCGqE82cqs8WlJyFy++CXR+9E8BUMGOMsNous0m7jDDPUKn2QKietRqILl8zOHZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNnOEY2L09BZ3RvVlhqdUo1dCtOWWFoM0JUMzR2TnV2ZFpOV0lqbTdDajV2?=
 =?utf-8?B?a1lKcDN1RXljRlRxcTRCMWRnWk9TdkRpdmJTZXNucWRITVZON3Y1cFZnTHV3?=
 =?utf-8?B?WDdoNU1OMWZZbVh1MXJ0V05XTTBnWHE1NUJlR1JUd0hpazdDd0hScUpPWHZ3?=
 =?utf-8?B?cjF1SVBvQ0tDNDh6UytzVmtMMmUva0JOTEdnelVvNUYvSnpVa3FVQVBkNlBH?=
 =?utf-8?B?ZDY4clFHQlBHa05VSXZNemZOL1N2SmtSWGFDTEtiMFU3aUJyL2g4bVZYdWNo?=
 =?utf-8?B?T2ZLME5XT3d6cGVQbXoweVdVbXhvVkh5aWg3SW5sTmtKVFZaM3paczh5UG1I?=
 =?utf-8?B?QVlYWUMvUWFnRmVmMEtEZUFFTm5VWDFQZ2xTdDl3em9TZXZIaUVhaVRCbllF?=
 =?utf-8?B?Y1lveEI3THJ1RnM0NnBxL2hacmwwQmpLejhZKzFIS3NjWEJXUEViMHZPMG9Y?=
 =?utf-8?B?alI3WStGNWk5NldDMitiVTVpQ2R0c3RTek0zMDZGWHhBMExRdDRiUWVRWDY1?=
 =?utf-8?B?TkR5Y3RvV014d21DZ3MrSlRXOGVDWFJZVXVVMlRselFnTjBObG1NRXRwUDJh?=
 =?utf-8?B?K2VLUGdybktoV3Ircnh1VWFFU1VMd3FkQjBaVDh1VTNOejJ5Y2gyS0pQelR6?=
 =?utf-8?B?RzFqb3liNGpraWcwamROeU9CbmlvUWVuOGZuUFByajZSRUtFK01XWlRSY0ND?=
 =?utf-8?B?aEZsRnh2NFdvNkFEc0dZZGxkNmw0V3hLdGhCREtEVFhaZ0ltaFZYaHRURTlU?=
 =?utf-8?B?Ym5kQ0czQTNYRTZPV2VuT3IzdHZiT0R4WjNSUkhQdUVlVjcwbVI0b1RWVVND?=
 =?utf-8?B?RVdSOHVEOXE5MDA2Si9MSnJQSkpnVzc4K2NjQnVCTEdhbVRSMU1FN2pyRmFQ?=
 =?utf-8?B?NHoybGRxUlN2VVNKOTYrMFZmWHY4NDJCLzV2UFdHbFU5aVdxemtBRVd0YXQv?=
 =?utf-8?B?cUgrYVFqUmVqQWNudjRXRlU0aXdiZW45R0xCMWtXcW53M3lSOVZIUnF4TU00?=
 =?utf-8?B?MjY5bDZpeXdTVjhmekNabUVZUWw0aFYxdVJUVWlIVWpKcmt2V3lLcjNlN3Zw?=
 =?utf-8?B?eTl1RTJVVzFtVVdGYk90c0gwbG9YWktjbFQya0FBZGdYWWc5USt3OGNOTWt2?=
 =?utf-8?B?ZERkaVYrOVJlNkVHeGQ3WUthcitybXl0YWVQU0M0WjdwRjdHRFc2cCtwbDRx?=
 =?utf-8?B?R2R3T29QY1picVBBTjBSQjZtMWd3WVVCY0tFUy9Ud2NDNmd3M0YwbS95Z2Qw?=
 =?utf-8?B?Z2RXUjZObml6MWp4eDF2T2loVWtwNjJ3bXV6TU5tek1GemlMUTNlVUlzL2ZB?=
 =?utf-8?B?REZDa1JSY1JqWXhaa1VMMUNpcnFJTStXZzE0MVNLWitPeUNQKzJXUnRTZ0dN?=
 =?utf-8?B?MTFwSklYUS9USXFEVGluQnJVYUdETE1GN3M4ejRhNzY1amtLdjcrWVlxcmw4?=
 =?utf-8?B?OHFzUXVpbnJQczVaWG5LUnNJWk1YTTEvNUFHWG9SRUk4aXk3RDUyRDVLb3RR?=
 =?utf-8?B?K1VIY3ovQ1RENGxsamQxeHZTK1c1RFJEVHBzM1c5SmlJMm5nQ0gzSEhQNDZz?=
 =?utf-8?B?R0RVL04xNFB4elFMZDArbWpEbXhHbnVkMTBhUy9nRDdURm1RbmdrUDFBUnhC?=
 =?utf-8?B?NlpoVXdTZ2FhWFEyZFAzOVo5ejJqeVZGeCs4ZC9JaEhuRlluTEIwTDRJQVlT?=
 =?utf-8?B?WVNrYXFtK3AwL1F1WE1POU9BbjhlMTYwZmZjODVKS3JmbUZrQzhyRzQranJU?=
 =?utf-8?B?ampuajdmUGZPQVlmaGJNR0NuY0QrTzIvZDUrK0xLU3BQQSt5T216WWtpUmpx?=
 =?utf-8?B?RVVhV3F2bVdyMG52cWRITkp5MlhjN3V0RnpyU2FPQ0ZxbktPdi94b052TnlE?=
 =?utf-8?B?UWovTVBMNGR6bU9QRHF1d3hBc09hT1hYRll0MFN2a0pXaFdsa2oxczlqRkZ1?=
 =?utf-8?B?SDdSUW5DS2svRnBTeThHUUsvODhjbnJ0QTg1OHZDNmZaSWdLbFBGWnphYnlp?=
 =?utf-8?B?ZmhrV2p5Zi9rSE5RTmV6dW9DTFdBQ3VDMjU2L2FGQVUyZjR6dVlENksrQ1VE?=
 =?utf-8?B?UHlHS09qMzZkWTZ3ZmFiNFRpUXpHRDJOakxsblA3OTBTOTdPM3ozbjhZb1JF?=
 =?utf-8?B?Y2pwTHJaenY4M1NHb0x0NmJHU1VRTlZ4eWpzNXptdENlT0hUYXEzR2VrckdR?=
 =?utf-8?B?bG9RbjRiK3F6dm4vSW9OUG5MTU40SE9SeTNJSGJBWmZhblNwd2d5TWNWN0F2?=
 =?utf-8?B?UDUzbVRyQ05MVm1MbG0xQ0V6VVFpQ25idk5vcDBJMmdYWlA0MUNJcmdOT3BW?=
 =?utf-8?B?Q3pZdC81bEtvUFNyaFZLVjZNUDE3YmtlZnBiVnlaSm1kUWViSHU3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a512467d-b755-4fc5-4226-08df39fec421
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:04:08.5950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpePU1kqejgSUHCCvNtXmW+2Pj6uGKS7HBqyohucYfeyjGN+td7D7oA8y691IfNbbTdQCpCtOXRUnA5FaN1Bvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer, so the sender accel ID of a message depends on its direction.
>
> - Send HELLO as the opposite role of the destination: a message to the
>    exporter is sent as the importer and vice versa. Outside loopback
>    this is still the GPU's own accel ID.
>
> - The MP nHT stamps the IH cookie of every HW-delivered message with
>    the GPU ID of the single physical station, the exporter. The only HW
>    path is importer -> exporter, so attribute these messages to the
>    importer. SW-emulated exporter -> importer messages carry no IH ring
>    and already name the exporter as the sender.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ef133c60bb9a..8558dc1a9e84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1091,6 +1091,23 @@ static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>   	return adev->ualink.info->ppod.accel_id;
>   }
>   
> +/*
> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an outgoing message
> + *
> + * Normally a GPU sends messages as its own (single) accelerator. In loopback
> + * mode the same GPU plays both roles, so the sender identity depends on the
> + * destination: a message to the exporter is sent as the importer and vice
> + * versa. Outside loopback both roles collapse to the GPU's own accel_id.
> + */
> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device *adev,
> +					       u32 remote_acc_id)
> +{
> +	if (remote_acc_id == ualink_exp_accel_id(adev))
> +		return ualink_imp_accel_id(adev);
> +
> +	return ualink_exp_accel_id(adev);
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -2249,7 +2266,10 @@ static int amdgpu_ualink_send_hello_msg(struct amdgpu_device *adev,
>   
>   	dw0 = AMDGPU_UALINK_HELLO_MSG;
>   	dw0 |= (remote_acc_id << AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
> -	dw0 |= (adev->ualink.info->ppod.accel_id <<
> +	/* In loopback the sender is the opposite role of the destination, so
> +	 * the exporter side tracks the connection under the importer accel_id.
> +	 */
> +	dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>   		AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>   
>   	dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote AccId:%u\n",
> @@ -6567,6 +6587,16 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
>   		return handled;
>   	}
>   
> +	/* UALink loopback: the MP nHT stamps every HW-delivered message with
> +	 * the GPU ID of the single physical station, the exporter. The only
> +	 * HW path is importer -> exporter, so the real sender is the importer.
> +	 * SW-emulated exporter -> importer messages carry no IH ring and
> +	 * already name the exporter as sender.
> +	 */
> +	if (adev->ualink.loopback.enabled && entry->ih &&
> +	    src_acc_id == ualink_exp_accel_id(adev))
> +		src_acc_id = ualink_imp_accel_id(adev);

Small nit-pick: The last part of the condition is redundant. If the 
src_acc_id is not the exporter ID then it's the importer ID. So in the 
worst case you overwrite it with the same value. So I'd drop that part 
of the condition. Still

Reviewed-by: Felix Kuehling <feilx.kuehling@amd.com>


> +
>   	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>   	local_acc_id = adev->ualink.info->ppod.accel_id;
>   	dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
