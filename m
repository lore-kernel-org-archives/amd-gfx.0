Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E728CC072A2
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 19:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F81610E772;
	Fri, 17 Nov 2023 19:43:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E4210E76B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 19:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhHe5KeLDcTNRDc+5F1s1rZag2sO+MWQ1ATSrf/hmDy4cbc2fib3zFCziNkhIbsa/pzchvIfrRTMDx0yxJ5tL41SMm3yZ34bxn6yqwGxzoV1C4oK/+CeMODbfA1gA4nRitN3a3D9n+FUPWUkdB+d5kh9HB7XcQepdTJN22Q2KhkX2es17OcV/Grhe/5IY5FoGadBjX32Jq+7N77lhGVhQTuuJGbUrFpcLmnR8jQtdM16ttv0MVTFkOLBzUAfu5t2X1nFqkwxM0qcNwEvp4ldIkErKJ4ryREfZm2zTw/jDQMoix5nDuLjTCCUZr5UDa72vxMdfSNzo1uxVInINMSBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34Uft2xypgxMkJNT6UkreKkZAWd729+F5fVJQbfT+60=;
 b=dOwqqg+4TB12YCsKXhpEp4dAvUFIFgK2yEoZQr8FsC8cwA2TtJD4J9UHt9tI/sHC7ZDkc1mNliLseO8gmpizZnsMc9scaewHI3Op1gR9L4oNtk5RLVWivvU8T6XDlthNi43zp+SQzZmqPY6wRxSCrNnBE4qiNxpYSsUUG8dZ4NL+EAMGrIDyAHY1MfZpKFPUV/T0OurN3j17jo7l1Iq11VADnrX7ae9liv4kI40+78VQypv9oL1TmCGqlG74fM9hLLFOXuYvjy6Z1h0QvJ8YUXXqnd1SfIQ0bU7Vmqpa65bSMQdIepmSXRLeOVPCAiRLgkDNbkJlBNWBkKRLjKhKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34Uft2xypgxMkJNT6UkreKkZAWd729+F5fVJQbfT+60=;
 b=am5oQthhq/rs5BJTfbYov+Veh6IfeWcPxyJyp8WfdD1+M4QCwaiU3oSZgqvLZy8GLaRxA7zA1gwQBVadTrsqV3NApnv6/GDynT4pYle8NFxYCq3Rtz28pXWYdglgKKRax6RTBPPOsg+7c5aoRr+Nm0r9Zf8z5qM1WbD/+IAE9pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:43:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 19:43:11 +0000
Message-ID: <c0b209e0-e439-445c-b81a-53d3c0f5d7b2@amd.com>
Date: Fri, 17 Nov 2023 14:43:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Copy HW exception data to user event
Content-Language: en-US
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231117052010.3166816-1-David.YatSin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231117052010.3166816-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1d4c3c-3fa8-4bed-2321-08dbe7a56e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTKfjtSvTlx6q1V5pCD9C4hAT14bUbqk8lcpPmJNhc0NqrC5/K6VdW0N9CcbU3xQRDv6nxnPKtbruvFRnunI7UN1dYZnKFWMsrcm87YjdjOyP+rH+1HdEJ+I1UifR7FkGCiZjgU9Ia6OIV0sohpJu4CL9mCjlHWJo0+KItLiAdsxTYWI3pk62ZyndAF6FHIvRc7cvrljCawh0K4qHEjjhQn3if8sn+fh6ge5JQ2Hm2WHhfPlYUlCgdCyoM7lQrKGSyqYgnqzzelUUi+EQV8Lr3NRTDG3pqK/fPRK3UMaTO3XYlXYpDzbr8i1p98T1UjbQg7npapJiY0KYE5bNfonSSCJoRKImZl6W7uu8kQ1ArWdD2WVvMAYuSw9o2vjXvbf4zb4Kjc/Q5sp9cPbMOoRh9mUnMlq5d5Ta4QKBBBbymERvssSD3Pk08Hcvs0dxW6fde5Qs0mTbjHaaTDpnM7zLXj6KZt0mDIkLsqwdmJwQsH0j48cFs2NzR4OM7JMEOrHXoIKDeaJafA8BTg6oUqgTkS8gC02QpLJusEkQ6XGdh/azAgthk8V1oE/8teMXaj6FN9EG6WKnxOSldmxx6pSbeXUykEJWD5hJWiw6oI2XxXh6Co6V61PCKJM/6HbO0Iv9+e4dR13t4IvN4EOt+852w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4001150100001)(31686004)(2906002)(38100700002)(31696002)(86362001)(5660300002)(44832011)(4326008)(8676002)(8936002)(41300700001)(2616005)(36756003)(316002)(66556008)(6512007)(26005)(66946007)(66476007)(53546011)(6506007)(36916002)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm53N2JGQXN0S2pobzFoQWxzZllDY2kzU09QU1ViV1RtMTQzSzg2Q09BTlhi?=
 =?utf-8?B?YVpXQkRYa002L25tamFzZVdZc0hqTHU5cWxaWTlRam1WOHM3UEhEdjRTMEdR?=
 =?utf-8?B?M2JaL015R1RjUXZ2dmpRZWlFcDNZMVVWYWhBK3FEUFp1V3lFN1pqQ3JjZG1u?=
 =?utf-8?B?VVRMaWpLWHdJa2xvU2k5ZSt6WGp5cXhwYW41MHJ1eUpkVktZZVVtUXFIWjlW?=
 =?utf-8?B?T1VtTVE1SVRyc1JUL1hDWkRoZGZhTXZNenVmMlBVdG5FU093YnJpa0pLbHJ4?=
 =?utf-8?B?SHNaOGJ3MjBRaTVvN0o1QUtJYlUyTmxxMW5MWXgyN28zUnl3dk9NajF4akJX?=
 =?utf-8?B?Sk9jRDZVVGRxdmN0bVBySGZKTmw1QlJNaFNqL1lwanBxUE5adDZvYmpvdjQ2?=
 =?utf-8?B?Sll5THVmTmRZaC9NdHQxWjBtbzNPNmtXVEtKSEF2czIvN3FZRFhFeE5PS2dy?=
 =?utf-8?B?d2FiSmpiOGU2ZTVJQUV0QllwV3VIYnphV0dFclVTWHRyQm9Fb0pvTFZQQ3ZH?=
 =?utf-8?B?ZitLWFlQMmhWUUttTnFPWElEWDlZc2VmM1hhYkErZ0pidFBIQ2wwZ2tObHUy?=
 =?utf-8?B?MFErU1c0YzQyRFcxQ1ZLWEhQT3V2R1hvNklaNlhyMnBXbk9pc2xVOWN2M2dM?=
 =?utf-8?B?U29GYmRuZ1ZxbkpFeHRKVGVTWFQ2bFl6eFVVK1ZuazloRDJaSDdGK2RubnQr?=
 =?utf-8?B?VGJlL09nSnJ2Q2laSzAwNHpFdmdtbURwOTB3UWZHaDNhSXIwTnVZdkh5TEZH?=
 =?utf-8?B?cEl6ZklMdEJMSGVFaHA5SDFoQWxKTDZBMUNwTi9FbDY5emMySlVWaFZEM1JE?=
 =?utf-8?B?NEdkTzVrOFo0R2NkTWRXR01QVDlBU3NLcDd3UWV6OW9taGJaQ0hrelZDUVNo?=
 =?utf-8?B?ZGJ4V0NYNnhZaVA4cjQwSFNYVnRab2l0SVNTN0UrMkVrODQ2R1k1YUtsTzJP?=
 =?utf-8?B?VjNCdDhDM05lL0RKY2lMWkdlWGFzalhTa3hhZk9RZ3dUSTlrdGx0b0M4blRH?=
 =?utf-8?B?dGNFM1VXclV0bk14a1JuNXZhVytRZnFrQW1hcVpMbFpuZ1AwRWpWdm5mQSsy?=
 =?utf-8?B?ejNjL0I2L3hFOEFPdVNyZ2NiZVZVMERleFQrWGpvNG45L0p1cFpWZDlNanRE?=
 =?utf-8?B?c2k0b2huODBnZHcrRThCanRRbFc2YjNVZ2JVZWFVUUFRK0orSGRmRzhObWpS?=
 =?utf-8?B?WG5oazlpOUlJZXU3M1BsUDAwYXhEV2RSMzN1TGFXTngvT3RYZVJVOUNHVGVi?=
 =?utf-8?B?QzVGcEZ0YWlSYkN6T040UTFadEd1TVprQ2Q5TmpFR243WFVaL28xSEN5OVBu?=
 =?utf-8?B?YVJEeG8rMTNKek9vSDQ1Q09NdmhDVDU1dXo1U08vNC9VYlZJang0QnNFOEFB?=
 =?utf-8?B?Snd0eE9xZTkwUFBudEdMUmJSbWNERENHbXpHdnRFQmZNTzZkTkFBenBEcFNv?=
 =?utf-8?B?SUVNeTVkU3Q2bDhLVUtDZUlpUm85RWx5VWlXM0k2am83N0NCSXNMR053M05k?=
 =?utf-8?B?Qkc3Wk1XNzd5dU9FcjZsd0xDV0dZTXdnNWRCY0hma2xTUUVaaTRHay84VXRI?=
 =?utf-8?B?TUZJMUFrZU5pY2ZxOEJIRnNDZERJVEdYVWswenM0UzlFNTJvVzNNSFJnY285?=
 =?utf-8?B?Y0hZMGlHSFRCL2lGRU04RlFoZnd6dVBXa0swaysyWmpPMFFCNVdsYndTMXVG?=
 =?utf-8?B?VFViOHBmS0RySGw1Q05sMHV0K2ljd1pPTElwU1h0RzZPV01nSmlqRW9CNllu?=
 =?utf-8?B?Z2RGYkZ4NmZRcnBtcnRmaWhOWVp6NGdGeTNJZU5aKzlrSG5CMVc4R2Eyb3R1?=
 =?utf-8?B?YkZPejgyRm9jYVZoREJLTXdwQlB2QzBBcmRvaHdKaXpYc1VHRmtOWDFVMmZn?=
 =?utf-8?B?N0Nwdnl0UWhtRDU3RCswbTNraXI2V04rMDlBcTIxa04rYkVrMlRaWnp4TnFI?=
 =?utf-8?B?Z2prM0VMZ2piTERuTmJaOGJneUJHcjkxUXUzZHQ5Rk5GMFF0enY0akRvT0VT?=
 =?utf-8?B?b0lWb29YcGpsT1hseS85T252cE5JTFNWUUtqS3Y0VitEMnZkUHpSQ2tENXBD?=
 =?utf-8?B?NlcrekxkandhSHBLNlFRdjlqOEp5dWlyZlVFVXZ0ZXYybHlQYXZId2tyVDQ4?=
 =?utf-8?Q?J7/wjd8uRxi3mBFOb385yK1Ak?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d4c3c-3fa8-4bed-2321-08dbe7a56e6c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:43:11.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12eRngGbZfxHCBgPgDmKJZCLoHolrT/InzpwYgeR7RlB2RkJWp0e5qA7yJYZLOwz19azkHFFs+HLLMv4NwukpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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
Cc: Lijo.Lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-17 00:20, David Yat Sin wrote:
> Fixes issue where user events of type KFD_EVENT_TYPE_HW_EXCEPTION do not
> have valid data
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Looks good to me. Do you need a KFD API version bump so ROCr can decide 
whether the information is valid?

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 0f58be65132f..7d3db017f8d7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -880,6 +880,10 @@ static int copy_signaled_event_data(uint32_t num_events,
>   				dst = &data[i].memory_exception_data;
>   				src = &event->memory_exception_data;
>   				size = sizeof(struct kfd_hsa_memory_exception_data);
> +                        } else if (event->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +                                dst = &data[i].hw_exception_data;
> +                                src = &event->hw_exception_data;
> +                                size = sizeof(struct kfd_hsa_hw_exception_data);
>   			} else if (event->type == KFD_EVENT_TYPE_SIGNAL &&
>   				waiter->event_age_enabled) {
>   				dst = &data[i].signal_event_data.last_event_age;
