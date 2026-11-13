Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78D606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ba3Ih9So
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A022911223C;
	Fri, 13 Nov 2026 13:40:23 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6AC11223C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 13:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX8KxJbv9/e/SDWK9g0AYgd7aiuOcY4miHDzrfF3YSrCuFFSYB7TN2dhTba/LlFELdV52xbtXyZKD4rtoOyB9bG+pgoLPJTecdCYtRu/DgRQXoimMDQkdDSSeLhGIG1PemLroEwEFthrLVM+DbyeZdrQbWHYqv1wXa1snmdX/857HyFuq5jARthEfIA4SmbzSxQ7e2JnZVFB062C2XPKrU5xotU+OSRJSi2r5c/VAWOlHhMaVHUNjMbUfgMl8g+7SSa8G79Hj9jrjtaGRkE6XSKj+vBjIo+m5SbkWfzSLubs6BxXoPw6Oo8Uhwb9TRGqHK5WzohpGHT6wFuCq/gAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTRhYZN+bRGeHuPm+5YJLtcYCVjoqOLfvv+cYzmrpJE=;
 b=pSBXeH41Jv58k2fEjcvrgvrng6iy6g/+6E5Z3HLvpcbLAz9F+f57Q5KeYgEfjoSZ/DKtJxv3FXJ/mhDjzLqVoP7U2YvOWw5y4wEgt0gGQYksJ6/Cr/bOHq4Yke4PfH1ikBhuNvyJi8PUlGkrryj/1QnSv/1+b4ZYXqi/juqFgKcUAkZHTD7OPkCqkV3ygxXTerZGFY3eWuZWS1nhm7IzBkfGn1wu+/fBX+3h0dmqgMiRO5kuWiO6XJkNQpCqGYwmV89UvcsQ4Z2Ga6r6BtkXmoftwvbcHvar4Iq5GMSsiXKFzUC6ROKPBjV3DuIBu2E4blbUv8yTHvKmRmZhOjTpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTRhYZN+bRGeHuPm+5YJLtcYCVjoqOLfvv+cYzmrpJE=;
 b=Ba3Ih9SopW8Czy+D9E7ZqNvEqCiozrc0+goWnkF0TFFcH+6z61u0GZxPJrwdwWqfx5grPThETyl4LfvRP+/7qdCIyI/ePf8w9p7stmyJ9XDiZ0X28JoU5+Rtmvhn8G/sGfA6rHpQQwQS0iPVBZSryGLI2mezoxqR46ZexdbVjPA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 13:40:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:40:10 +0000
Message-ID: <007c4e54-bfea-4129-9776-cc29fa541cc2@amd.com>
Date: Fri, 13 Nov 2026 19:10:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Abort guest trn during ras reset
To: will.aitken@amd.com, amd-gfx@lists.freedesktop.org
References: <20261111141115.29283-1-will.aitken@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261111141115.29283-1-will.aitken@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 362272f8-92f8-4e91-e8fe-08df418ba2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7zPvbdMMEwTat/a+hWRsTkuue/BPU+knMybc/vnX3oFsHHfskgmh0C3zMkXYr5QD89X4lwcJnscNYxo3F6dwEFqr54ADRUjVtyUmSndVF7n2GyN7i54w4XEOLZIg93S9w78+Liw1S8F9ylqQGnGmlqY4MEqnMmO+SBUVM17s6AgfFWfiYRe1u5LnqphybSMuara82loqXNxRRBHH9WwLaIoIv/omh8TzY7tPEer4YR2349RRvTL0pAILtnvkWltgkLwXXd/zdwdPw5Yv60+OJFiE7zARj2iuqeqh86akUh+pP9CGAna+kQN5QzDm0hrAL8zfzJxVu+WelvxhYEHTcuuwxhkrn8BrMpQ0n/grbZlsf7T+iTvtmYpIuIHNrkK0pC9Y4szFSSaaTG/YZIUYMgWDcbj2lBMAvgYTUpxj1KAymHT830p9QB5Co8yXbPFwBlr6JxHumAnG9KVp+Z3+e7otGkFCCxwCayD/DJYxEvS8XC3lDA4HuFsFaaQ5ZAY72GxWpo5TzOKfVa5uBmNLSSyGeAS2tEL1M+9obgS1ywGV8av9hMPoTMSFRTEvWBt3grMj98BRB1K5N5+MZazIGB5s6bdTHUmLaaBFmJbP3YiiYC+ljkSWthYp6dWkVmd21ZCa+Q+YoSw0e4zpFnubTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFLd3EwK2tYOVJ0QnFEREM1ZE93cXJWR1p2V2RDSmpKRDVFQmhwYTRhVWtG?=
 =?utf-8?B?MlppUXhFQ2x3VGJ4bjFNMmRIYXZXbWJHVUlFTFR1dTNJQ2tKV1FRM3c0MzJT?=
 =?utf-8?B?cVc0Qjd2NTE2REFKUkg1VkVVdDAyWUY5TW4wV2FaUGQ1RVg5SmJ5NHBGYWJZ?=
 =?utf-8?B?SWZCUGF5N3F5ZVpaaGJ0M2xObHpZZDlHRmo2TnFkZGhUUDlKOG5XUkpud3pU?=
 =?utf-8?B?S3RRbmRDNzMwV1Y3UVgvTlNvSTM1S3lSTUY0KzNLVURjWE1UYXhYeWJvVkEz?=
 =?utf-8?B?amRQMTR6U3QwbkZhcGQ1dEpCL3h4TmY2VXorRFl6Q3NvdllYb2VMbTNMNnlv?=
 =?utf-8?B?OHpFTlc1L202WUhrU3p2ZmVDREUwQW5DZzltZlpweHF3S2dobUtvc1AweGZJ?=
 =?utf-8?B?THFCaFRVMHNLZWxlbmtjRWZrYjd5THNiNFN4ODg5ZURrNHFjb1hHTnVIR1FU?=
 =?utf-8?B?aGtrMkJ5ZFdIRlA3OXFxcU5MdVQxYkNkVWk2NEdhNStScCtqNG5NM2NsNStl?=
 =?utf-8?B?RXU2czFXMnRCR3ZVenlnS0JIOWhva0lNeEtIVUtpN1JNSEhZbnpiZVJFMFhq?=
 =?utf-8?B?dkNZTVhwWWtGQkRSWHhKQS81bm5uTk5ORCtYTE5ONUtpUnZvVmZubnhkdnpV?=
 =?utf-8?B?M2k2Q2RvcVVjSTZXbDl0K01LODNSM2RGSXF0OHJQNGliNUxFRTNFQVhUMG1a?=
 =?utf-8?B?cXZHOE5ET1NYTGxnVGxxRE1PeVhLcFdIQXpsai9vYS9za2hVYUNXV1VPS1Zv?=
 =?utf-8?B?TlYyL3haaWczZzJvN0hWeURUV3ZjQ0VESEE1bnRPNEFSeWlYQm9wM1ZRM1lB?=
 =?utf-8?B?bzVwczUvZXlGT1UyOG5yRHlQUjJSbWZHV29vWmRoaVFGUUFiMmRvSHc3Rm41?=
 =?utf-8?B?cEJKQUY2UXBUYjZncU0xSWVRejlGVFF6dUxWVVo3anM5bHRQWk5rODMyTURG?=
 =?utf-8?B?TURNTmhLaWhobVFjT3ltS0xQVWtMZDhpQytpbWpjOXFzVHBSb3puaXpNYXVq?=
 =?utf-8?B?cVcvVmNYOXBhNGgvcWhEc2JmYnkzaWtld0xlWlhnejc2T1M2ekFrRlJzTDZp?=
 =?utf-8?B?RFlyd281bHNSNmJERzhFcG1JRnFGU0Q1eHErZ3VuUTZyOEhhOVZiTjZnOGlC?=
 =?utf-8?B?ejRRWEdVU3EzV2tSNDEzSUZYWUFSQm5hbUZWRzRYdWZ1cGdNM3dkQ2h5cHk1?=
 =?utf-8?B?UjUwRWFrL2JFZi9NdXFGaUo0OVhlc2RINlhnYWxoUCs1dG4rOW1UK1hVMEdh?=
 =?utf-8?B?aUJNMFZRYm5nNXEzRnRRWTcxZDJBZFNlUGxsU1hXbHZoeitaRjJiWHpzUXJI?=
 =?utf-8?B?WkszQnFtYmVScDV2SGFYM3AzdEluQkw4ZDh5OFBub3RyaEJSa250eXlxSUhU?=
 =?utf-8?B?KzBXUU5HcUtZVGtWcmxQZmFPL0VlZllVU1Y2WWVQb2JsVldLc2dzT1kvM3pH?=
 =?utf-8?B?dUJtZGxjbGZLTUFrR2ZLTEU3NS95SlFmbmtwVHJ4U0RqbUZDM2N6dWJWTk53?=
 =?utf-8?B?TTVKVTdDMDRhSHF5T3lhcFNZUy8rTzFVblRSdUJSN1NBOFJBZThZSm1WTHpP?=
 =?utf-8?B?Q1p1R05kSkVEcUFkbmFjd3JFQlZHUGpSZ1U0V1NuTU1LN2dGUTZxUzFuSjJQ?=
 =?utf-8?B?bUUyQ0JPNWdaUTgxR09qVXBxSUc0emRpa2tuTnJJNEMrVzU1end0ekVvd1lo?=
 =?utf-8?B?VEJvWHF0YjdYc244b0N0d2YvbUVkUmM3UFpQMjNRbERnVndHcHFjcVF6Q2lV?=
 =?utf-8?B?VnFUODVyU3RxR3NMWkZPa2c3WFN0c1N3RzBudHNqR0sxMU1BRndEd1EwcFZ4?=
 =?utf-8?B?MGV5eVlyRzU5RVY3SG03U1diblRxejkzY2NLMG5DeHorbE45dGpDUUMrTExC?=
 =?utf-8?B?NzMzZFBNQU55M0hYLzgrVGFzUGFIN0Q5N29aNEd6WVRuaDNqcFkwMEQxTm1j?=
 =?utf-8?B?OThnRnZUOVhmYzVHZ3RzVTdQYWk3RnJZaWlWTWc0L3gxREFxZWFMZ2RjZXlx?=
 =?utf-8?B?TWdVcXBQejdWNEhTelArMUVQL3kyNmtzeWQ5bU5CY2JXQUtPbngvK2M0aFFI?=
 =?utf-8?B?SThYd0t5Sm42OEttQzdKN1NrQzczMEcvRktGeWY4UVVSejFUL2pTU3Z5K0RS?=
 =?utf-8?B?NktLenBKMzBNcGE1NHFTSFFUYVhpQ1F0K2RndVVGMHZmZVpFbVdnY3VlOWds?=
 =?utf-8?B?QmtVS1Vsa3RuSkk1VTdPRmhRRzVkdXBYSTZXOGRDeFIvMFg1RDdnNFRTUTYr?=
 =?utf-8?B?bTlsZkxUSWRBbzI3UlNRWXhVc29NcEg0MmVYaWs3VVpKYUZER0JEK095YWly?=
 =?utf-8?Q?/oe22tkPMOGAKpQ+a+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362272f8-92f8-4e91-e8fe-08df418ba2f2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:40:10.1540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hlw5URgdwx+PfnQ+IgXfbZNfsJLFl5QLUu46KXe3sQw0zhXVEdpYkU81kUZ3tLXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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



On 11-Nov-26 7:41 PM, will.aitken@amd.com wrote:
> From: Will Aitken <will.aitken@amd.com>
> 
> In sriov, if the guest tries to send a message just before the host
> begins a ras wgr recovery attempt, the host will never see that message
> since it is busy with the recovery. The host then completes the reset
> and is waiting for the guest to recover.  Meanwhile, the guest spins
> waiting for a response to its original message until it eventually times
> out and proceeds with reset recovery.  This patch prevents the guest
> from sending the message in the first place by peeking the rcv mailbox
> before sending. If the bar is down it means a reset is underway and the
> transmission should be dropped. Doing so prevents about one minute of
> idling in this scenario.
> 
> Signed-off-by: Will Aitken <will.aitken@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 30 +++++++++++++++++-------
>   4 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4b1b42fee6b4..d0c08c7bbc92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -102,7 +102,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
>   
>   	if (virt->ops && virt->ops->req_full_gpu) {
>   		r = virt->ops->req_full_gpu(adev, init);
> -		if (r) {
> +		if (r && r != -EBUSY) {
>   			adev->no_hw_access = true;
>   			return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index a2c1aa838737..19594e761094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -106,7 +106,7 @@ struct amdgpu_virt_ops {
>   	int (*reset_gpu)(struct amdgpu_device *adev);
>   	void (*ready_to_reset)(struct amdgpu_device *adev);
>   	int (*wait_reset)(struct amdgpu_device *adev);
> -	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
> +	int (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
>   			  u32 data1, u32 data2, u32 data3);
>   	void (*ras_poison_handler)(struct amdgpu_device *adev,
>   					enum amdgpu_ras_block block);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index fec08f235b92..32398eb884da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -116,7 +116,7 @@ static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event event)
>   	return -ETIME;
>   }
>   
> -static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
> +static int xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
>   	      enum idh_request req, u32 data1, u32 data2, u32 data3) {
>   	u32 reg;
>   	int r;
> @@ -158,6 +158,8 @@ static void xgpu_ai_mailbox_trans_msg (struct amdgpu_device *adev,
>   		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
>   
>   	xgpu_ai_mailbox_set_valid(adev, false);
> +
> +	return r;
>   }
>   
>   static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index eb537b2ae685..5c984653df58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -82,12 +82,22 @@ static uint8_t xgpu_nv_peek_ack(struct amdgpu_device *adev)
>   	return RREG8(NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE) & 2;
>   }
>   
> +static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
> +{
> +	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
> +
> +	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
> +}
> +
>   static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
>   {
>   	int timeout  = NV_MAILBOX_POLL_ACK_TIMEDOUT;
>   	u8 reg;
>   
>   	do {
> +		if (xgpu_nv_rcvd_ras_intr(adev))
> +			return -EBUSY;
> +
>   		reg = RREG8(NV_MAIBOX_CONTROL_TRN_OFFSET_BYTE);
>   		if (reg & 2)
>   			return 0;
> @@ -136,7 +146,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
>   	return -ETIME;
>   }
>   
> -static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
> +static int xgpu_nv_mailbox_trans_msg(struct amdgpu_device *adev,
>   	      enum idh_request req, u32 data1, u32 data2, u32 data3)
>   {
>   	int r;
> @@ -149,6 +159,9 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
>   	 * will return immediatly
>   	 */
>   	do {
> +		if (xgpu_nv_rcvd_ras_intr(adev))
> +			return -EBUSY;
> +
>   		xgpu_nv_mailbox_set_valid(adev, false);
>   		trn = xgpu_nv_peek_ack(adev);
>   		if (trn) {
> @@ -170,6 +183,8 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_device *adev,
>   		dev_err(adev->dev, "Doesn't get ack from pf, continue\n");
>   
>   	xgpu_nv_mailbox_set_valid(adev, false);
> +
> +	return r;
>   }
>   
>   static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
> @@ -187,7 +202,11 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>   		goto out;
>   	}
>   
> -	xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
> +	r = xgpu_nv_mailbox_trans_msg(adev, req, data1, data2, data3);
> +	if (r == -EBUSY) {
> +		dev_warn(adev->dev, "Ras interrupt detected, dropping request 0x%x\n", req);
> +		goto out;
> +	}
>   
>   	switch (req) {
>   	case IDH_REQ_GPU_INIT_ACCESS:
> @@ -573,13 +592,6 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
> -{
> -	enum idh_event msg = xgpu_nv_mailbox_peek_msg(adev);
> -
> -	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
> -}
> -
>   static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)
>   {
>   	return xgpu_nv_send_access_requests(adev, IDH_REQ_RAS_ERROR_COUNT);

