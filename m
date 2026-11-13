Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481E606AB8C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IiabTrFO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C0131124B5;
	Fri, 13 Nov 2026 13:20:06 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE931124B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRaWyRsC7LTfsr3THvfHbWbLfqxbo07JyKvhw4K5YfZzu+hQIrkP30FWvMc1katWxuvbxy4LbyuctL3/Uj3lOYZ8hRO/txHBoLcBsjDus9NK72GkbpSJiy2XgT/OvIE8CeLV6w4q2J1S8++Sp7TZwaRt8oCX/Oi45up8KMU6aldfXlVkyOZWyO1kBZ0KIAdleqD0sOs6v5uWh2JE0cDLEufAfXio/wDcRvw4NzVz45HGXfdWURmQ40iJJvCAsOmkp14fLPnbL8bvL/5BPb1CGbRXR0lvyTTzlSDo2l/+v4Y3rFnv/4bky+vwGyJvjdGFHWSA1OOPYpQgOMD9kuPk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdof8LO8IIq8XpeIT4bmLDnt1XgyBpoCwq1MdaTfXaM=;
 b=RoNouLSPZwVAA97YVhHN2qguuvp/MrmrQuK2mo+43/Qvlv/OBb4f3UA+dGMzWDR95V/hNvM9oEmkUr68lnZiwoYt/tgIMBYpzmxHxzTQeU9N9NV0O24pq+KsBOw2qAHIz+L6/V6BONzXyq8Rhk/DUY9V5r/WAr8TmP+XrA2ei60O4FRbDhLonxi24Xu4+G7OwRb5SDY5pYbc1A/WGj6C9nOlCWXxbPJRSKycUJdyz9vVOrlX2bZxCE11Dq7gIt23G+PqHRdytNN/9gtY1+LtTlBIQX9DaXqvW82l83WKzleDf+2dNWylApWw1Vs1kymzgQMqUwXhlj5bnioF7bu1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdof8LO8IIq8XpeIT4bmLDnt1XgyBpoCwq1MdaTfXaM=;
 b=IiabTrFOavKzGNtgNYiADu3Citaka94n7v5RpqE1VeU6js5hisgR+2n44Jvc2ceMLru5MG9NBwI10e0zcUzcjnSkvWdEReXZr9Rx75dUVmNtYi3u5t+02WPhLfgv13lMEpdyMgVK+9Gcmn/LqFdD2ST/Baxzir6kjNj4t96qi7Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:19:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 13:19:54 +0000
Message-ID: <6fc3ba7c-96d4-4492-9989-dfefa2380c67@amd.com>
Date: Fri, 13 Nov 2026 14:19:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UserQ fence iterator cleanup
To: Erhan Bilgili <erhan.bilgili@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261112233722.172499-1-erhan.bilgili@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261112233722.172499-1-erhan.bilgili@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: fe12d8e7-1e00-44cb-ae85-08df4188ce10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|261102123227099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|56012099006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 20wOpr7PpskmPweu5/fE4gSf3S0kthNmXaDFL5YGy0qDLrU7R7B4x6bSnUpwYXBPxc7k7YtuhLDY+wiDCwFCclC8B0uw4VJvgLOeOOUtzjVsc5B0i324Xd7wuRlam1Ohmzn8FPqIwk2Jt5gy/ry8nQf0ekPUxb6j415dmyNgyV4Wm4UkqTRaLqHiTRS0m05XCes0Ne0bcQwA1bPeK0eZ66kwQC4slUFfAye05L1Ry7D+Vm0bIVsHDe6g0migKiczCw08soyPhF1otQFuKhCeBsM0RyinUnY7BDuqeYL4hGADTRU22hC0QKlyazZCyGVq8QvaDF2QagYVu0smJZdtgItTv1BUO0U7wZ6Op60FvUSnwIJRz+3AG15YFdDQDACGsR+5zEPT46ya9ZbMEeAcqT+QPe8ak+gTzO7gI5unOJLSl+M+UbMfOn2OdKq1Pk4VAS9SOHIAoI09KyOtGp2nwswlzgTsHaYZuC5qXvBWqZwUkDHOIIiBp5V/oSA7IUtbHyWf8kj0RhNsVQNO4eTjzj3iwJt5Lum1UCVebc8n8dsZZSXrM94TOdl8qIaRz/hGqVsoAfJPeeiLQdkM850aMAA5GweCsMIlTeVeHUpC8kgQp+Kb7zlGEVIeXpTji5/4jig65ktEDCo0hKumQJS2B81C5DJhjHSg8Tv4CArmzZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFdsYnA4ODE1N0hrenM4dmw0VkgxTWpMWFFTd1pLalhjdzBjbi94TXEycGtM?=
 =?utf-8?B?NmNQS1ZpUVVsK01JVVZHR3BwQ1RRdzMvME1jTVh2M2VKZnp5M2gwTUhjVHdq?=
 =?utf-8?B?ZzZQaThUS3Y2MkduaGdXbkVnSnRIKzhhNmRSMGNMbisvbXovU20wNTA3cEJz?=
 =?utf-8?B?U0RNaVliTWUzdTMrVm1mb2pCWGlCZkZ1N0RFdkdSMENuMGtpankydU1OOE0y?=
 =?utf-8?B?aHJZMlFSdWV4WlZBU0N3bmNGb2RMbENSY281aCthamswR0swSmxUV2dUYWxj?=
 =?utf-8?B?RXZZbGd3aVBpNDVVa3Y2dU05MlYwNlgwRFZwNjJCNS9ZbjdGcXJlM1RsSFNl?=
 =?utf-8?B?U0NORVplVCtkd2U1MGFJY3k1QU0wTjhvVGlpOXZ5WjMzWG5KTDdvT1JtUjVP?=
 =?utf-8?B?QVE1NTBkeXB3ei9aeVlNQ3FEUzMxazFCM3lkeVN6aC9rSjBSVW1RU2s2cHlJ?=
 =?utf-8?B?STRLM0o5S1N0RzRoNERyM3FOVVdJdjNpaE9zbEtrZEp1d01DcjhoMlFESHdG?=
 =?utf-8?B?T0Z0UGFHYVp3Rjk0QTlGTDJQNjUrQkRNNXRMNjgveXVlZ2ZkQnc2eERZMGl5?=
 =?utf-8?B?SEdwMmdSRWhmRTE3RFZqbitnM1NRMTAxc1Y5ZldVaVlXd2g5TFBrZnR5dUJB?=
 =?utf-8?B?QW1vZ0tsb1RrK1pyTGYwaUtreFp2OGtybWJtYWNNeWVxbkx1Mm9SdXk1MGg3?=
 =?utf-8?B?VnIzTHBUSm1XeVBlRlRueEJGRVN5b25XcVVKTDk2V2VJYkZESmNyOFBLVHVp?=
 =?utf-8?B?R2g1RkVYbGFwczRzWDk5ZTFCdENHZlY5ZXpGYUwzc2hIRGkyU0drdHRDNEZu?=
 =?utf-8?B?NTlpVHFYQk5CYWNJQ2lnZk95b0FScm5rb3k1T3VYSzdXQzFNdDdXci9FSUFm?=
 =?utf-8?B?ajlxSnpVeGZzeGpVUnNHSG1vNlVmdXJNdXp6eDlmWVFHbzdsSXppU3Zndkdm?=
 =?utf-8?B?OXNDejZRaEw5dmJ5alNUYlZoVFJMMFJ0VUxpVjRidWV4em9heXJIWXl2aDZ1?=
 =?utf-8?B?VFZvTmhOZEZiV1FvVXU4UTBDckNhMWFQbjFXRmtQZ3VWSEIzdGE2M1hkVVRp?=
 =?utf-8?B?VWFEN0duZ20yOHFrRG5RRFdUcXlNbHREelVodWJOelo5SW81YkYwSml5UWgx?=
 =?utf-8?B?QTRwNERRRjNxZWtwcFNTOFloRUhjY291ZnUyTGtUeUxQRmZjeHdxc0l4UWM2?=
 =?utf-8?B?bStkK2FXTTBxNjh1T2pmMEhBeUdXQmFzeTdWVCtzYkNOOFcySXFQREc3dGd0?=
 =?utf-8?B?TkNad0Q4QkdBa1BOTEdiYm5nRWZ0R3Mya09kdUR5MmJYMUE3Ym9iWDRHYzhr?=
 =?utf-8?B?emtKeDVTbCtFSXo3bjI5OG1rTHkwdEFsUEpCOTRQN3pMcDd5ZFBLVTVCVWQ4?=
 =?utf-8?B?VnRoU0FST1ZQVnNDRitRZGwwa0RZVTBYclg4MGIvQWhDV2gvc09uZ1FveWE3?=
 =?utf-8?B?cGhVQVFRZzF1Nll0ZW1xa1lrc2czL01aU2ZBWUNMd3ZMbWF6WGR5Tld3MWt4?=
 =?utf-8?B?VEYxKzg0eXFVSFpKR1ZIeFl0dVQ4cTgvMXAzN1ZPOGg1djJrVlZQKzMwRFVM?=
 =?utf-8?B?S25mMFNLOHdYMUdUL0xCZGhRVG40RVM2L2QrdGNJUWFqVU12Zi93TjdKT2dK?=
 =?utf-8?B?QTBmWHRDTFpWNTNRVWFWaVRYaWJpZ0Vya05iZVFpekdRbExJUEVybElnQlRV?=
 =?utf-8?B?d3o2S2FDQ0ZtTkVsVEEzdmlwQUxxT3E1azh2bVZVdmxmalpUeTc0MVh4ZWpl?=
 =?utf-8?B?N1hwRUtUMTA1N2VZdXBjQzNWUnZvcEpiM3JQVEpuVUhka2xDU2Z2RklGa0tk?=
 =?utf-8?B?OGZXekxVWkdxbk9xVjIzYUhOZmp6WFJvQitaemdQa0l1WkozK1B1Z3A5RGNo?=
 =?utf-8?B?YURQbGE4d29ackpVQ2VJRExVejBwMG0xelpxVWUvMDNKRW5JSk5iRHVrZldw?=
 =?utf-8?B?T0FRS0d6YVZ2Rkd5bTdIRHlNMFlJc2hnRFErTmMwbDNVUHRaa2cyT3QvUXli?=
 =?utf-8?B?V3ora0Vad05odFFJa1RSTVhNVjlHNlZweWNCaHdSQkdtS1Zaby96c1BmR0Ex?=
 =?utf-8?B?VnRXMTZRbXZCeVV3NElYWmpLeU4zM1JFekJQMjNsK1UzRGYxTm03MklUNDJC?=
 =?utf-8?B?eXhEUldGa092Umc1Uldnbk1OeDA0aVU4SWVENS9FS0gzTmhxOWFvR2FqdEk1?=
 =?utf-8?B?d0lWTGFZdk9WMzBwVlFtaVVQcFBqcnFrUFVrbmdFYi9QS0xncEtEK2xrYUdv?=
 =?utf-8?B?NHVDaXRqVStscm1TQjUwREMwM2Y5a0JpNS94Uk1ieE05bSt1ek5VRlowaFhD?=
 =?utf-8?Q?s8uKD8tYIsIWtm3HqE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe12d8e7-1e00-44cb-ae85-08df4188ce10
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:19:53.9945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eUX0CCOQHpUGqn0GEyFOaGSHgSxCk8lWtO2CYr+yL3OFjx+u5LGcVyj8vmdvLBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

On 11/13/26 00:37, Erhan Bilgili wrote:
> If a fallback wait is interrupted, USERQ_WAIT leaves the unwrap loop
> without releasing the reference taken by dma_fence_unwrap_first().
> That reference is normally dropped by dma_fence_chain_walk().
> 
> Drop iter.chain before returning the error.
> 
> Fixes: 15e30a6e4792 ("drm/amdgpu: Add wait IOCTL timeline syncobj support")
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>

Good catch, but we should probably fix dma_fence_unwrap() instead and add a cleanup.

I will take care of that.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index dd976a50e053..e7b63c227421 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -796,6 +796,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
>  			r = amdgpu_userq_wait_add_fence(wait_info, fences,
>  							&num_fences, f);
>  			if (r) {
> +				dma_fence_put(iter.chain);
>  				dma_fence_put(fence);
>  				goto free_fences;
>  			}

