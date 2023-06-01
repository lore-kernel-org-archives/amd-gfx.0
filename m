Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5286C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296A010E14C;
	Thu,  1 Jun 2023 20:58:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8829B10E14C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlBXBpCa6GLmUJ5JgkUOFLy+Dizk/ib5XUdCuoMyACXxIaM8CXDxmPwAwxRBDVzSD8E4K0rPfd1+GbgZM+B00ud3Dc91ucD3hLfBmXavOCwOZiivverZWNE2yujzScAEWxlK7DERXOzulO5bKxvL4PCx+Q6Dr8nh28bZgMG6cprMFcf7KSt4P9zSa1vQ8p4TuIdT8H52RUyE1BtGpVNPP7DfB8rZIcleQ+N/XfHoLpjVoUGi1DfZMlbhBd+eHES+SfhiGpMJDeFluDgjZBq6VE8hIjja53fvtsAOq9Ven6w2uyAgL6Uu6oOaJuzA2zfEaphO8rQvMZM7ylV8xc76rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax2SyKACaFDPYnfFQu2lvLiw1PR/uG58JfKO9xixFNI=;
 b=L1mxWtJ5GfupUHK8SzJ3uJsbjyD0HUEUDO/y3Y2DNcHekXb6eZpXuViiDJZGRLSfawqx0RnKcRFKyGmsBch/JJAiS0LdOku6NoBVXXje2Y+oQIqusSiXqkPcmERU15wFuUWroHbkz9cIrGsm0ZBpWYP7fcWbdd91KedQzv4p9/DXx6W/nzpaucRlnRn6gQo5eDT4UkAZXC6GSjU33f9cmM2QeH/3qXTZNSaM57mvZJfqg6bvtLtzoAZ1pL5QrGgi5NykMTqXoE5Ug+DT5PtFJBQrf+JjueMq2VTBEAZq9f0hE3gqPvygcUV964g3fBC2JHwWQlNQEzAEVUugqSm6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax2SyKACaFDPYnfFQu2lvLiw1PR/uG58JfKO9xixFNI=;
 b=N/8JZhbCR9S6VAXSoLhjRe4JqgSHU7bw5hbtKJfpUfRfmgbntZZcGtekhfFt84eIRjO6gIM9u/8Tn+damof0NX6k3bJMIVlbuBAiRjy22MOXpyQ+NFuTNOyuoYHXcS4shrYRgcTILnGKFgti7HB8IbHz8CY25b8jcl1LpMVwW9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 20:58:45 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6455.024; Thu, 1 Jun 2023
 20:58:45 +0000
Message-ID: <17389962-dd68-fbc5-c523-0b47d9381a8b@amd.com>
Date: Thu, 1 Jun 2023 16:58:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add event age tracking
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230601204740.1501616-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230601204740.1501616-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0162.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::35) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5dd173-e380-4b80-3882-08db62e2fd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY4ljtDn8IuaAcVyN53mx9rAO5CBbEqli+d4kdsDwzMfQoTG5mTJ698bYbU/mK0jHsLUigaVTWd/EzwaJWFTTgj5f9k8Lf0GIFEW3ONb9P27TXjHNbFJGFosBROS2AKfqsLOx5JHi7IdA7XFUheLHWClZI+L8kGInNEthCilfaqTII4YprqhRTSagDaCIUWS1m7Ge+E38muUUMmiODtkI0m9c1PB+2ORoKoak9tFRU1pCpm5HFB7kU7Sn8kFqSw31svyjWD53ozM0bsImDMwn2OUWUQr475d2oWhlgHNhyMdxKRV3btjGii1kpITWgT/hc3y7JFjysXR18gt/N6o3jfSv0rOJJqVkp48fAneJRgqgX72KTUrM2zENGNBHTrVNxz0Zv+HkmtPSAvSKLdD2q/Ar2T5A4PO4oW1WdMX2pvhiJtRSQtrDaR2Ro/7sSKw90GBQKEOAWxYy8i17UxmsLsUNq5VABiDfeKjH7Zczq8tpQe+pBzizDsSzNX11T+dp3Ij8zKXh3M7mwz3fVM8/X1HmLj1xb30cDTa7TV9p8c/aMO4IFNmOOx2MmIwL1UwdxRGYpQV9sUxghcAqex3vLsiHYnCtLr2keubDo/ivASCG/waJl1hiuB4/zw+wZfdAYEUFnOIhKfnQflr+NK53g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(478600001)(66556008)(8936002)(8676002)(4326008)(66476007)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(36916002)(6486002)(6506007)(53546011)(26005)(6512007)(86362001)(31696002)(44832011)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JaZWhiMkFpWStnU09OREZpOXJJZUJCZy9EQ2JkZGVPcStkdVpnSnBuQVh0?=
 =?utf-8?B?K3lycmxLYUR6TFU1V2xDNnN3MlpLV1hGeHJIMWVPUmJPWno1Tzc1UzBJVXI1?=
 =?utf-8?B?dmhlajg5ZWVoZGRjNlBIU250cDdlWlg0TEV4RzREWXRJcjR3U0pXS2RPd211?=
 =?utf-8?B?U2hkQmFTZVJudm9aMXFOLzgxWFBXNW43MXJMSE5KNzZuamE4cWp0M0pjRXZG?=
 =?utf-8?B?N0M5eG5UY1BMR3A3U0dKc2tlMFpIWm1JWFV2dnBZN09tVDhORnJ6RFVEWXlP?=
 =?utf-8?B?UzdiMzkySC9TamNIclBXeWpDME5lbnhZNWI1enNGVHJNWU40cnpqaGNaZkJM?=
 =?utf-8?B?T21wblg1OTFPRlVpNHhSYVhrTlBjVG5hanZkSmNNZGxIUWJhcU5QY2FiUFhE?=
 =?utf-8?B?MW1FVWdNdDBKa3ZBcGdSb2t6eUR1NjdsenQ1QTNFdEJyM3NHbzVQTWY3SkJY?=
 =?utf-8?B?RkVldmF5cTZsTzFQKzh6dTFsQnIrWGhCU2xXNFpTM3NtZERMSU5iaXcrdWQ5?=
 =?utf-8?B?dTJGTkxmM09NT0tzN2kzRm5yT1J5T2tUOVdvRGkwd0laOWJNTlJWV0lSRVlX?=
 =?utf-8?B?aDBIV3JYVXNkTTIvMWRpTkdHeGJsa3lBTE9GakFiQ1YvQ3lqRjZSZFNxY29m?=
 =?utf-8?B?VUdzSUh0T1d2UFVvYTN4ZVNUMFR1WVF3RnJiMlhRTUZobDlQZVBIbklJQVd6?=
 =?utf-8?B?V1R1anBybEVkcTJIbTBvaVFXMFBmdGtNbmR0WnBNQmZxRk15MHZ0N2RwOGFX?=
 =?utf-8?B?dXBTS1UyVHFVeU5zcGlyaTQ4aCtqazhYU3MxSTExMzVyMkc5aDdyMW1qaVhY?=
 =?utf-8?B?KzdVN3Q1SFhnRjBRN2FaUG5DNVplY2MzbUdJRU9tc3RPSWU2VW9OTjRaSysw?=
 =?utf-8?B?WW9nbTFJeGdUWHF2bUJpU1NhR3I2cDBhWDYzek1XNkF0ZTM5dGJMM0xVek9o?=
 =?utf-8?B?bWovY2U2L2J2Nit6QzVMd0pLNk8yNWdqbzBPYlQvT3I3MHBTMWM3MnpGb2RY?=
 =?utf-8?B?eU5DSStNZmFUNVk1YmVVaXUrVjBrQU5tWFRVVGpPbmxCcVRoSzFEMEpQMmpT?=
 =?utf-8?B?SGViSEI5MXhpS2M3aVpuZWRnY3hVaWZyZ2xZQ3BYSXBDVS9ncW8xNFFNWlk1?=
 =?utf-8?B?TzVXYVhCSU5Pd3JpdVpxTTdXUE1SZng5TlZKTXJNa1ZnaGsyL3dTWS9ma2FQ?=
 =?utf-8?B?WDZpclpkRy91UnJZVnYyRG5HemZiQ0F2UExyVEI1VkR4WXFsTEJOSUhhOC9q?=
 =?utf-8?B?VjJET3FNanFWaWRzRkt6c3VyRW91YjZwNzJnK011bkxscEdCREN1Rno1UTZj?=
 =?utf-8?B?Tk5udUs2TjFWOUJRSlI2d2tVbG15VVJqYmlPMFFXTG5NemRrS3oxSzVPSGg5?=
 =?utf-8?B?WkoxYW5LY0V6ZkNwUjJ1RWxCYWVuWXg2VTlrcFNXVUJORmZBamtNVVNMVTgr?=
 =?utf-8?B?MVhJYmlUdXJjbmpOL1JGOTAydkVLdHFzKzJuMTNpejc4TkNGbnRiV0xRU2tQ?=
 =?utf-8?B?S1JaOGJPdXJwT3dPazllU1JqZnlmSWpndk1WMGk0U2RzUVRSOTRmaW0zb0p4?=
 =?utf-8?B?Q2Q3NDBoN044NDNiUWdyUnVnYmxyaE80QnhOVytPZ2lTcnMybjRiL2VMN2VW?=
 =?utf-8?B?NGlIQU01enl3VVZtZHppTVhiRk9SSUdmVUpGeTNaUE1IR3J0bTJQNVhNY1lk?=
 =?utf-8?B?V1U2dUxaYXEvaCs4V2dEaHI5V3ZibEpQanZmL1NXVUM3eFBibDZhcWFoUStx?=
 =?utf-8?B?MWNUMVhrMlFmTkxEOEJwMlZzUjR6ejMxYmcvVGVkcTNoTVpxbzZ1TjhUZHIz?=
 =?utf-8?B?NkVxdXkrL25RRzJrVUtsZ0xhdmxGNUVLSzN0Mjh1VGpac0gzbG5ObHBDaU1v?=
 =?utf-8?B?Y2p6dGpPbnVtQVV5MTBwdU1DbnJvdWFZRTg5UjdMamQxN0M4Z2Y1enBsaWNL?=
 =?utf-8?B?Sk5KL2RoK0N6UWt2eWxqYVNTSDkvVVNGWVFDeE54aXVzcUJoNUo2M1U0UDZ5?=
 =?utf-8?B?NzVFSmZjakEvK2JqZytId1NtS21TSFZ5ejNYbFNEaXVIdVlaVnAzWFZPYkw1?=
 =?utf-8?B?WkdVT1RYV25GVkN0YVArV3B2cHFlMm5acVhmWENCTis2ckdobmxOWGRVeUFX?=
 =?utf-8?Q?0Uk4o1tgoPhXiSlCBQ4XFSx3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5dd173-e380-4b80-3882-08db62e2fd3b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:58:45.5131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZPQxyO0uBilgCMbeca3i49eyz8RCLqChr6gGCAN2QYPPotHPxMaMmkjYQSzP4T3MGo3W+c3uJO19Orf99YhxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-01 16:47, James Zhu wrote:
> Add event age tracking
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   include/uapi/linux/kfd_ioctl.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 7e19a2d1e907..bfbe0006370e 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -38,9 +38,10 @@
>    * - 1.10 - Add SMI profiler event log
>    * - 1.11 - Add unified memory for ctx save/restore area
>    * - 1.12 - Add DMA buf export ioctl
> + * - 1.13 - Update kfd_event_data
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 12
> +#define KFD_IOCTL_MINOR_VERSION 13

I think minor version 13 is used for the debugger changes that are 
making their way into the upstream branch right now. You'll probably 
have to rebase this and use minor version 14 for this.


>   
>   /*
>    * Debug revision change log
> @@ -693,6 +694,7 @@ struct kfd_event_data {
>   	union {
>   		struct kfd_hsa_memory_exception_data memory_exception_data;
>   		struct kfd_hsa_hw_exception_data hw_exception_data;
> +		__u64 last_event_age;	/* to and from KFD */

It would be better to create a new struct kfd_hsa_signal_event_data for 
this to make it obvious what type of event it applies to. And to keep 
the union more uniform.

Regards,
   Felix


>   	};				/* From KFD */
>   	__u64 kfd_event_data_ext;	/* pointer to an extension structure
>   					   for future exception types */
