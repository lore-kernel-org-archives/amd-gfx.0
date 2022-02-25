Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 18:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FD710E7C7;
	Fri, 25 Feb 2022 18:23:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250CE10E7C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 18:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diXrd4fcqV6iHAquvSAQvJNp7JqxTa8hbycPuXhOt32dBB6ySwVTYAq0ExEusGhTNx+41TgVP+Un9/Rns6RfXPCnK4AoHb0afxu0TQuVrupuPhrkJVQ1xh8DB5y2/yVDsjmMQMCv2CuaYbgetU1k0V1j2B16YG7rp3+W2+l11dpgx9knqNqkCcxqpDqOfevhCx8eCRHolocN091x/IqTCRV7hNij3Dqfy3KA0QFe3n9FJ5PlFYAVaPyWQgHzi8X40HwJpWHqoWyfmFWg/sLHpUF3b0m74jeMi300W69tnZSJPNkWhGYoBPEfhj8n8owioxHr0mIlgKRdWraciMzvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zQrNaMIRkbmkR0SRLx/tpuxHVYrH6mfTp8r6Ts10rg=;
 b=oA3PRnWICahILlcNRdJ7kQmNxj6MIdolAaNvwPiuCKWTpM82s2JUnSDxah2IhzY4bXcIefLxlRrhZIkGFp9N9mgE2D1PqHXifumV/IyZwhkAxXFxuQRXciFSI90fRiOLYCVOBM16APYctF4JcN+CjpUh3qaRGQbp1U82CyI2q00SGTeW1hBwrGkb/IQRiOS1KdeMkzMZETlZNC8laQtsBAGJwW0TX2kZRYlkPseL7NBvreiQjiyQYwwLeoyCxkY2yjUO9GhA+8rxG18Fu1tb4IMym2r/4KYtSpTk7LhM5cTMWeLYvFZtxyC8wwlDFCu1hYWmZVQrOaU688qnSsciJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zQrNaMIRkbmkR0SRLx/tpuxHVYrH6mfTp8r6Ts10rg=;
 b=jR+9oaS0WzKXwSecCYyVsa+4uqrMG6eVlz9SXfybDxucenVFEJAuoXjSPfHCZDHvV8Jtz8HULkKWTIFjfxsFgfREJvy8lzvHuSip6OLxH7MG/qGQpOGescttFE+asWX1YieEwVYoFaC39bK0F4egftV06/O+o1qat8rC7RKj53E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 18:23:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::410c:b456:62cb:e3f%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 18:23:32 +0000
Message-ID: <0b9aeb7c-ecd5-db55-43be-9addf3e97a07@amd.com>
Date: Fri, 25 Feb 2022 13:23:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/9] drm/amdkfd: Add SMI add event helper
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220225180619.21732-1-Philip.Yang@amd.com>
 <20220225180619.21732-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220225180619.21732-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90c0cff5-9108-41ee-cca5-08d9f88bedc7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3589B60B3D748808D039E732923E9@BYAPR12MB3589.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnGs2IjBwWjtuRg5EhzknOhb/QseeeEZP1If4sMRMvtSA1wecQs/DBvyqQ5DzplX+jZj37s2G011GzKn2Jg0WWmtLXQWtT9gFcmNu6BJE02VRZ5xFQxiezsFKi7jLypA5a8ZU0gmHyPkkfwJSMYEo3HujdgyTCbXpeqxHBhb4ts3HBHjeuwUZyoc/nNlb2FCUzPoixKfF8At1TJhJGoGrGL+LrjocykGnm/LIGsBOFhf/Q1+J5LkitCkVncTv+Cs5s7q/Gmft2EuOOYhEFw+EUkMSQsrF5+tN7UFzsGEI6CvrNzWagRyN1Yjao9xxgPJI1EVHZxbWx/Y8PvEF97ZPM1qv0g0BwPv9LUOoZMiXgwaqwf9o2M148V9j9Czi6x6Z4n+ylvxsMVPvKZYnVskX0pInongEUlAQpxqYyzGz78TPOKe2FsnkcxXo+Zn04mUwt4K5saYgJ1sYkYJGmzGLijVj9G9jL83Jf2l/M5WociEH6SOc7p/y397Z0ahe8NgwDWqYwjlNHd+r8Krm1mtBVHwPaz+68NGL28v7wAQ6h24nGQPp7qPw1GcXj/GbOCBWcIPp9HNWA1zyAHs7SoWiFY+NNgny+k70w11g/g0sdmfPZiXALGMFT7bawzSLUJ7Y5kDPxed0O3FKPNu2F3A0lUqKELi/FgjrEGVX7fnOnnXKSeTmqlgjhBoeTktPAY6ntUv9nLNERIIMbA5Y18/BxVSahg5DcJ7xzrzCXquiFvKJmYptTHxlBbX+fQPIUgI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(2906002)(26005)(44832011)(86362001)(508600001)(316002)(6486002)(31686004)(66476007)(186003)(66556008)(66946007)(83380400001)(6506007)(8676002)(31696002)(6512007)(5660300002)(8936002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODB0VmJJb0pKVTAySnk0UmtTOFJwdDhtUFY5TFhiUy9ja3hJOXFsVHZEenUw?=
 =?utf-8?B?ZEpNUlBLWnh3TWhzMUxLbjlsUjFLN045amNVSE1lR1VOdHJxM3dVKy83K2FT?=
 =?utf-8?B?eFE5N05iYUl4b0puaHdxUWpBOGZ2ZUR5SUtvLzBTNys0TlVUZ1VSQTR0Ulcy?=
 =?utf-8?B?ODU3V21ucHBvQlovZWxmMEJFL2NSTEdUZzFOSHpYVjR5d1dPeXVsRGRDeHMz?=
 =?utf-8?B?SFpoUy9IeG16eTZrTlVPRGttNFNRdW9MMlJpMmZEQWxXY3c0Z0daTVQvQjQr?=
 =?utf-8?B?UHpwTHlqVXNsTVNoRWxZRlFCa0QrTFF0Z0Z5Y0I5T0hPUkNlZFVBZG9LdWtM?=
 =?utf-8?B?YnVyWTZUUUpkNHQ4aFZ1emE2d3dWYTlvQk9XT3g4RDJsOVMwbG9EM3JhZDBy?=
 =?utf-8?B?cjdicHYrZ3M1WThyYkVKVDJyR2tRZGNjUXRDWjNVdVA0L3hjSUJuaEZITXEz?=
 =?utf-8?B?S1FEZ3dQbFo0Wm50WHRLOHV1SmVmZXBTYTlweTBDd3E5MUdKR1lOT2ZQSWk5?=
 =?utf-8?B?WUVzUGtOZWt0K09pd2xZSTk5cllwek1Pc2poOWtUbXFiTXA5d1NLTU1lOGFB?=
 =?utf-8?B?WUlETkVYZzhUWmJJUytWaXlnUzlXRUxXbzY3Y2dMYUEvV1pQYTZGTXFYSHR1?=
 =?utf-8?B?dGcra1pCY1BjclRzbnR2bVZhd3FLZmZXbFkzUHpxTS9WZ0d1QXUxdGhTdjgx?=
 =?utf-8?B?TkZ0SCtnbzR1K3hiZ1FYSG1VVStjSUxjVnJsOXBaKzBMMzViYjJyTnhxVVBz?=
 =?utf-8?B?Rm1aVTNROE1JL0xRY0VZSmlOU0RSK3RuTXN1MVJENkk0YUFwckEyUzZtdmkr?=
 =?utf-8?B?U1VyVVJqZnlpUXQ3NmFWdjFkOWhGQXFBdjZ6T0o5Q3BKeXVjTzhrS1JLNW8r?=
 =?utf-8?B?b3VVRXBEWEhsODFnbE9VVXQ5ZDl6aDllZmhwQ2pkOHdlUmpoSndyL3gvVWlI?=
 =?utf-8?B?OUE4NHdDYWlBcElpSWt1YzlFVmhDTkJtS0RCdTNkQmZsbTRGRXIyR09zdG9i?=
 =?utf-8?B?cnJGM0wwLy9BSVQxam5FdkpGNFY5T2JaSVdLY3RwY0pYS1daREpXSTIrRUl5?=
 =?utf-8?B?ZHhVWmhNazQ4cXN0Sy9hQlBWeWkxZk5rMWZtYTdpb0Q1T0VwMzFXa3FlZVdK?=
 =?utf-8?B?TjJlUGptNldmY0JRejJ5ZXZacUtWR08ydXVjbG55MUZMd0hrdkFPU1RFeGt6?=
 =?utf-8?B?T2plRVJaMXdsbWJqVnBWak9jdnV1cW4zbHZVdDBPRkRnNi9vUzVpT1k2MVc4?=
 =?utf-8?B?aFc1L0wyS0h4bGF0OEpRZmorekU0Y3VxWnJFN0hOaDJkOHJRMWRmRlRaNUpr?=
 =?utf-8?B?eGMvODZsUVlZL2Z5UlpXamkvWVZFQ1V3dWlHMVRsRG80cHFTOVk4NGY3dzhP?=
 =?utf-8?B?ZXdSZm5Edjg3M2tWUjh5WU9iUmhKTkVscEV6cXZSL1pUOUkyaTNkeE9GTGpu?=
 =?utf-8?B?aVd3RGdhQk9QU2tVWml4MFd3OGlVYjhiMmsySWYvb1dOZ1FnV2VwWkg1b29v?=
 =?utf-8?B?STlhc0xXTW12QUg3QW01ajdZTEE0Mlk1WU9iYUlUbGpLdDI3bCtyZ000QlpG?=
 =?utf-8?B?Ti8waHZRUjV3Mk8yNThaRWNBdTZoRHFSaXpScXo0M3hPK291aDNacWhDMVVE?=
 =?utf-8?B?U1UyTzJnZ2hQZld2RjdPM2Z6bW9pWlI5bVdINDZpcGg3QmhlWkZKOXdGa3Zq?=
 =?utf-8?B?MHFIRzFFUGRWSjBiSWxLSUtudnRzZkErRGxnRjA3dTJzU1I5NVNpaVdReEo5?=
 =?utf-8?B?Zzg1OGpWbnRuRHkrTlp1cVAwR0c4dTZhZDNYR2VYcGZUTW5zT3JxWTVuSnhI?=
 =?utf-8?B?RnhnSjdjeFBqcWl0ZmN2WmRVNU9YSHZ3N3AzTGpRb3EvSWFOZnI0SVpWNTQ2?=
 =?utf-8?B?dERqSkc5MnVhR01XVjVDT2lOQlRweFZHNkJGWmpoOXJzdWNYUHBKK0gxUE5I?=
 =?utf-8?B?ZmpBQUdaRFpRT3c4WnJJOXJLWGxsbU1CMmVvWHBzb1I2NENabHp1SlUxVjd2?=
 =?utf-8?B?UjBxZU9NUnZiMG55ZWtteXBLYTJUb3VDY1M2cGVoVm9Na01UV2pNZ0pCWmg2?=
 =?utf-8?B?OFRRQmZFeDcwME42ZTk2RWNxanhKM1lHb1NJcFl1R00xV1E4RlR5OXI0WmRX?=
 =?utf-8?B?ZDFVcURTNFArdFVvNm9EVEtZTklpZ0d0VDVRQURUZi9wRWxCWFB1bm5CM3Ay?=
 =?utf-8?Q?xijyGtQhN6kAMb7kbCINV9Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c0cff5-9108-41ee-cca5-08d9f88bedc7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:23:32.4322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F5M3q4gaVG2h/vkQYJxKNzFVJbHuJWxjKMMgY4ELYzEHzVhsGfVphk8/VTvmTpkKSb2Yc584Q3xG7eOnEsbjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3589
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

Am 2022-02-25 um 13:06 schrieb Philip Yang:
> To remove duplicate code, unify event message format and simplify new
> event add in the following patches.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I think you can submit patch 1 and patch 3 independently of the rest of 
the series, since they are just a fix and a cleanup of the existing code 
and do not change the API.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 66 +++++++--------------
>   1 file changed, 21 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 6b743068057d..2e0a26159662 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -189,22 +189,28 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_dev *dev,
>   	rcu_read_unlock();
>   }
>   
> -void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
> +static void kfd_smi_event_add(pid_t pid, struct kfd_dev *dev,
> +			      unsigned int event, char *fmt, ...)
>   {
> -	/*
> -	 * GpuReset msg = Reset seq number (incremented for
> -	 * every reset message sent before GPU reset).
> -	 * 1 byte event + 1 byte space + 8 bytes seq num +
> -	 * 1 byte \n + 1 byte \0 = 12
> -	 */
>   	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
>   	int len;
> -	unsigned int event;
> +	va_list args;
>   
>   	if (list_empty(&dev->smi_clients))
>   		return;
>   
> -	memset(fifo_in, 0x0, sizeof(fifo_in));
> +	len = snprintf(fifo_in, sizeof(fifo_in), "%x ", event);
> +
> +	va_start(args, fmt);
> +	len += vsnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
> +	va_end(args);
> +
> +	add_event_to_kfifo(pid, dev, event, fifo_in, len);
> +}
> +
> +void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
> +{
> +	unsigned int event;
>   
>   	if (post_reset) {
>   		event = KFD_SMI_EVENT_GPU_POST_RESET;
> @@ -212,48 +218,20 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
>   		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>   		++(dev->reset_seq_num);
>   	}
> -
> -	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x\n", event,
> -						dev->reset_seq_num);
> -
> -	add_event_to_kfifo(0, dev, event, fifo_in, len);
> +	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
>   }
>   
>   void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   					     uint64_t throttle_bitmask)
>   {
> -	/*
> -	 * ThermalThrottle msg = throttle_bitmask(8):
> -	 * 			 thermal_interrupt_count(16):
> -	 * 1 byte event + 1 byte space + 16 byte throttle_bitmask +
> -	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
> -	 * 1 byte \0 = 37
> -	 */
> -	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
> -	int len;
> -
> -	if (list_empty(&dev->smi_clients))
> -		return;
> -
> -	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
> -		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
> -		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
> -
> -	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, fifo_in, len);
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, "%llx:%llx\n",
> +			  throttle_bitmask,
> +			  amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
>   }
>   
>   void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   {
>   	struct amdgpu_task_info task_info;
> -	/* VmFault msg = (hex)uint32_pid(8) + :(1) + task name(16) = 25 */
> -	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
> -	 * 1 byte \0 = 29
> -	 */
> -	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
> -	int len;
> -
> -	if (list_empty(&dev->smi_clients))
> -		return;
>   
>   	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>   	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
> @@ -261,10 +239,8 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
>   	if (!task_info.pid)
>   		return;
>   
> -	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%s\n", KFD_SMI_EVENT_VMFAULT,
> -		task_info.pid, task_info.task_name);
> -
> -	add_event_to_kfifo(0, dev, KFD_SMI_EVENT_VMFAULT, fifo_in, len);
> +	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
> +			  task_info.pid, task_info.task_name);
>   }
>   
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
