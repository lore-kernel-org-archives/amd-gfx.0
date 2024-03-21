Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7062C6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 16:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C09B10F094;
	Thu, 21 Mar 2024 16:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1dIQluMo";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E4A10F094
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 16:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9cwYxgdNsuH2LAcLdBGeyWt5bTlNmbJ79mMJOKmmjthNX0oY5G22xutRNuDZL6agmOxWMaA+ipgK7x5KfTcS8Kp98aAkrCFhvdpMWIkFlafAoEtmLuKHd6bRdXMywvQ337pCjnODyNk6v3rItohYPmViGbbyGAWFtkKNrpvljeF9pn/cLaFTduOII2FfYSjxMlRftsFjuZRqyJR9Awx69TFaJYEjH04Wi18QnPTKdEQ+ZqtxMAsZtG/Gb1nID9K/CYlItdAdfpgoa83JuHOfkemdvUnmm7ERsrxySQumxy/4YmQeHpo21S+GQF/0JFSUthWTQWni/9Sewgexn2kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sK3md4vwvNOFwGh55hQJwA5TfQnUechI8p+HzPRbCo=;
 b=Gk/BUOGqU/PHwB/ecaUHqWPed7nMUkyyqsIDBbe988Wc/8fJmfDaOzpL20ExRi4KCR5NhHHVnEBUp1JydYOUkieRNYSgTGZRTvWW3F5+LGzj5at5OlzL7uupVAf864IjBKjZ0RAsFc9Jw/Rw+tcphybyLdJH1rzCP1HbsztVnkREnvco3gNDGrK8s4qsw99StxUG75OdmhIaTFpf9U/gsCB7x1cFiWMhiTamNB7iQKuYT8k27CFIoRl/X+5DZye79orUBN5BIdfq3phQF/G99CP9U2xSQO6+TU5Q6HjDFGclW1sZgpGPyD1+6YdZO+SUKKoiRUM6j3edxo7gbeawxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sK3md4vwvNOFwGh55hQJwA5TfQnUechI8p+HzPRbCo=;
 b=1dIQluMo0xmU4LVAQbEGdtXXxsb/wAjKy9gHa6qvjMWtEhCop00JSaPUUQIWyYTsvnRgQnw/QbpJQbEreF3QEmELADDA+Zzmi1jIkeCjOh/T1XpA6ajzCqW6Eytr+paOYaM7+k6u0ICJdEVbRs5xIyC36gGjp87BMAUB4QGPEuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 16:45:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.023; Thu, 21 Mar 2024
 16:45:17 +0000
Message-ID: <9871b5a1-8838-42a0-99c5-18bbb7f90c86@amd.com>
Date: Thu, 21 Mar 2024 12:45:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: range check cp bad op exception interrupts
Content-Language: en-US
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
Cc: JinHuiEric.Huang@amd.com, Jesse Zhang <jesse.zhang@amd.com>
References: <20240313142105.3028030-1-Jonathan.Kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240313142105.3028030-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b4bfea-1477-4d9c-aebc-08dc49c649f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTFL13ZRSJD2Y/63jegqR+/3+Pf2tyloVA+vL9ObSjXBkZ453CKuVi6Meas6T/IQh60PSh8y2H/3W3NcHM4sQqDJnI4O4zBdd/TONMBqZv7zbMXESJVuX3Oc3x8xY2wRMxoB/Rl5mdoEDs4VnHJfnMwitpYf/9eoa4GOo2hu8VJ913aje+Rca9/7cwW1JoGYc7GM625R3zlvegW/p/aCbksuODMkwSKqfp65/QiWmehlicT/mTv90Y9989EzxDCTxIdFiXhtmW7W7hZxoQ5mhX3P1D8/rL99lliWlLIpW2nq22fdPtAz1IKmgOdhWu5iQA8fwbYnV3hWL7wSbkD3p2qpveuz8L62t8NSK5xKjFR389T1yVqxUBABqOf+rr4H366700PM6znuAwLWgc5yD/9x69+0kzrz38u7ZwZvRl0sQB7hp9GKrlwdlIx39Msa+5OarWt3iciRm+FMC5KUqcDUgt7NPhqzr6IQ2tQw1KN+a0aUnXGb7RL3HAqUKe121W2OFUE5JWv9fI2ZwyPerOsjBpS6jJcRpR+X6QakAH1iDSi9JpBdG9xCpT/n1yGGoBIwHvarWG8MNwQjqLkPc2j/HVhbSvfkgmlD7hgzKtmDMqVXrUm5Iw+UMjihFtBfxJlcgE7jLbs8khTLChsV99ZI72a18cXQTnDRxZifmho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VHeWxDK3pYazdPNUR5cFlVdEc5b2FpemZiZ0p2VTNmRkYzVXF6OXRZSzVw?=
 =?utf-8?B?eFh4cUIwcWN2WXJtTWpkSmoyYXJxTkk4QThJUDg2d3VNSGU5ZXh6aXExWDhu?=
 =?utf-8?B?aC9ZQy9jU0EwbERKSWZWbytTQXVpTFE5RWJyamo4OS9abitqckhMaGs5aEp6?=
 =?utf-8?B?N0NQMjNWYU9mSjAxSmIrWDBUSlJ2RldscjFSb0pyTHhhalRBR2paaW4vT1I1?=
 =?utf-8?B?MDZ1dHl5bkhMY3RUc1ArMmdNd3lla20xNGZEYllkK2FqTlY2VS9BQlhRSkkx?=
 =?utf-8?B?S2RiRzJZOXB6ZVhGWkw4Tmx5K0dkRDBvc3BsT1RMcWI5M0hLY2xBSnp1N0Zy?=
 =?utf-8?B?M1hOWEp5TW5tSlN2SkRVblUyWUpOS2hOK3NCb0pGZFUyc29uaVlNbU5YYkY1?=
 =?utf-8?B?TWpLeExLZHRIN0ovMDlCMEs5ZVBSZEZFa3FxU3Z0Znp6YTRyZHhON0c0Q3Rh?=
 =?utf-8?B?R2FFMjUwNFNreUphQmZ0UC93M2dNNTBWMUNHVUlYK2l5R3BxSUVqVkJLbU00?=
 =?utf-8?B?NmJ5SCt1YmJvMTMxZVVSSGpmVE5MbVhRYkdxbHVWWEwzV2tWLzBwbWVDTDdS?=
 =?utf-8?B?dkRPMU9HcWZMeGFjc1hnN25SSFZhOFNjVk1ac3FQZlplcit1eVM1bjRZT2hV?=
 =?utf-8?B?amxCUitKcTBOMWFyUnNBRU1TaEN6a0R3cU1LVVNoSXZXSFJqaW1xTEZkMWZL?=
 =?utf-8?B?SE84NXlNYkUvWmVueHB5cjRrcHpxSjU4dTU2dldZUm83OHdjLzRQNThMRitu?=
 =?utf-8?B?S2loeHZ2Wm4zSDQxSFJqZllPeS9HUzdBekVVWXdEVlZ2K2IvMldkRGU0MmFU?=
 =?utf-8?B?VkFQYXFyR0FQVmdabS9rKy9HcUJPVUg0M1gzWTlYTFRadEQrQmlOcUo4dkZK?=
 =?utf-8?B?VFMxSFA3bUZOUEhRYVNTSENRRUFKR0tOVTI5aUNNWXdETVdpRUZvQjZnUjU2?=
 =?utf-8?B?NUlYSzNnbkZkZHVUa2FUN2tpWnlBc24yRktkanBXcWliQjE1Y2ZJQ1lkcFNw?=
 =?utf-8?B?WjRQOGpmdkVYY09uUnVELzFiUzI0NTJFQ3BCVmMwUURDSGJGTDNoUk1TcUQx?=
 =?utf-8?B?bzJCMlBxV0ppRit5YVlEM05EbUxLRFprK0RnNU1BWjFRQXFZUlNFSWdMUEV5?=
 =?utf-8?B?WWtkRjlzR0lrS0xPc2pnWmZ3Vnl1T3RCOTgwSkpkT0xLTjVrMDdOQXB1Rllw?=
 =?utf-8?B?THNLSGd4M0pRL00wNWdtbXkwd1ZaR1dMUnAwbDdWQkdtaDFKTi8wK0NHK3Fh?=
 =?utf-8?B?M2VCT1FkdFEwNVdjV0NSVWxMVThibTliZVZ0ZnlxbzRCL1RlR2FkZHpzNmU3?=
 =?utf-8?B?RGp0dVNqMWxwMENtazd1TjNKdmcxMW1yQ3lBelJNSjlxSTd5R2dwQ3hnQ3F3?=
 =?utf-8?B?ZVRrM1NHWnBxdUR4Rm5URjFmNlUyNXN0cEZaa3gySzNZVFphczVOTWI2aEIw?=
 =?utf-8?B?TG9jUWpreWJqSEQ1Y2l3SmhMVGMwSDhQdVJBTEozZkxNcHduUktyMXdPK1h5?=
 =?utf-8?B?akdZL09aek9sMFkwL2V5b2NRM0x5d3BoTlNhOVR0Z2lUcjJpTkRjWXNqd3Mw?=
 =?utf-8?B?N3NweEp1dHdPbWpIaTIvUWJ1S1VDK29FZ2dWRHFDUi9iNTI3ZzRKaVpXY3FZ?=
 =?utf-8?B?cmdqdW9kY3cwejlNM2xFaS9sUXhRRzlUenIyazdyMEE2ODFvYmt1SUtvN25x?=
 =?utf-8?B?eTRoakVpNWlwOXRVbFluckg2bUdpV1NNK1pvdTVnNlc4YUE4ZkM5NkxvYzJm?=
 =?utf-8?B?MVJwTm5JR1lEdkdaSEQ2dkJyUFN0OTgwQnBITUc2UEZrcG5EZlZEcGVFakRu?=
 =?utf-8?B?dUtNcDF0ODhmdmx0bnJPTmo4YzkyajZuNzY2WXM4bHNKaEpKWVJCNVN3TUxP?=
 =?utf-8?B?NEdPdnFGNkIxeHp3RDk3dXlYUEJKc2c4SHpTRnQyeG9RZDlSUlVrN2tOclds?=
 =?utf-8?B?M2NGN24xNFJiTktYVExpam8vRy9zU2VUMmw3cDN3MHg2TmFFY2xDQmNrMW1y?=
 =?utf-8?B?MGdhL21CQzZuODhSaFAyZ1h3R0RkeEZVeUF4WWF3R2hJNVA2N3FzeEYrTWRi?=
 =?utf-8?B?WHViNEM1STljbGY4Z2lxZGdBaUxYVU1WNUk5NHQwWldINkwyZ2FlOXVGWmYr?=
 =?utf-8?Q?kc584Gv+axD0mdCikAJnz5TkW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b4bfea-1477-4d9c-aebc-08dc49c649f6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:45:17.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwqxxwsex6e6qAUcAbEZSDGT415ed2w7DhnSlhvZo1P3gzmRmSnlf5x2xfY9CN96pFs56ECGQh11gXWGg8/nyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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


On 2024-03-13 10:21, Jonathan Kim wrote:
> Due to a CP interrupt bug, bad packet garbage exception codes are raised.
> Do a range check so that the debugger and runtime do not receive garbage
> codes.
> Update the user api to guard exception code type checking as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Tested-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c    |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c    |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  3 ++-
>   include/uapi/linux/kfd_ioctl.h                  | 17 ++++++++++++++---
>   4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index a8e76287dde0..013d0a073b9b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -339,7 +339,8 @@ static void event_interrupt_wq_v10(struct kfd_node *dev,
>   				break;
>   			}
>   			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
> -		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
> +		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
> +			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
>   			kfd_set_dbg_ev_from_interrupt(dev, pasid,
>   				KFD_DEBUG_DOORBELL_ID(context_id0),
>   				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index 7e2859736a55..fe2ad0c0de95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -328,7 +328,8 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
>   		/* CP */
>   		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
>   			kfd_signal_event_interrupt(pasid, context_id0, 32);
> -		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
> +		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
> +			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)))
>   			kfd_set_dbg_ev_from_interrupt(dev, pasid,
>   				KFD_CTXID0_DOORBELL_ID(context_id0),
>   				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index ff7392336795..5483211c5d3d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -388,7 +388,8 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
>   				break;
>   			}
>   			kfd_signal_event_interrupt(pasid, sq_int_data, 24);
> -		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
> +		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
> +			   KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0))) {
>   			kfd_set_dbg_ev_from_interrupt(dev, pasid,
>   				KFD_DEBUG_DOORBELL_ID(context_id0),
>   				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 9ce46edc62a5..2040a470ddb4 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -913,14 +913,25 @@ enum kfd_dbg_trap_exception_code {
>   				 KFD_EC_MASK(EC_DEVICE_NEW))
>   #define KFD_EC_MASK_PROCESS	(KFD_EC_MASK(EC_PROCESS_RUNTIME) |	\
>   				 KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
> +#define KFD_EC_MASK_PACKET	(KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_RESERVED) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED))
>   
>   /* Checks for exception code types for KFD search */
> +#define KFD_DBG_EC_IS_VALID(ecode) (ecode > EC_NONE && ecode < EC_MAX)
>   #define KFD_DBG_EC_TYPE_IS_QUEUE(ecode)					\
> -			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
> +			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
>   #define KFD_DBG_EC_TYPE_IS_DEVICE(ecode)				\
> -			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
> +			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
>   #define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)				\
> -			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
> +			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
> +#define KFD_DBG_EC_TYPE_IS_PACKET(ecode)				\
> +			(KFD_DBG_EC_IS_VALID(ecode) && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PACKET))
>   
>   
>   /* Runtime enable states */
