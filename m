Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00683C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 09:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B4810E1E8;
	Tue, 14 Nov 2023 09:24:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3705E10E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 09:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpG+q44hlHtPjzT99jN44OL8Mxs5noBGfnNnLKqPnBUnDLYtf6I0HuiLn00R67kBr1d4DPjXiSCTsf+nEuELB4lvfbxz7n1G2a6KQLfNxkwl9VBqKlR9PqbjHF4anpynxAdbaSWsPYYsMLxIVZIOiTRaYqUYQuCIa07S3pxrKSUKnvDMEmk+TAIIvLMHhcAtFzY8tzGXtRtrhOtJSjsCFJ/IYZxSSE66tf/Godo3xB85fJ6chUhWVXGdbB3z7wg0wOkYLxIOhl1eKT2ITip22w3nVGxHvstqajN2SFuSm7JgMUxRNe57GaKAlGHcsm2p3UF5ns1s1F9xelJSLySEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip7cb6VBcC2TLFSfICnFfM8hN6XiOFU4WuXK7TTUZxc=;
 b=ii95cAGNog8MtNiT1dujzMBxQoTHJMu9n11VcwDYnR0fg0/6r5/+7pc0rpVcL/0WYtf1q+MwpsmDgrlSmiGrz9Ud3BD+OjF13MwV5CkiEP2XaBo3jB9uR7TeDI71VVUiFMeL2QsS+8BeiUki5Sm54u5WF7qxtosPb+crOImwCIoHCw/xGbTlqz4SRGiZQjmOx3UWqcoG672zj5oBM+W7Q1NP5Gfe1w0kvzuPny5IatYk25O4GiUvpGxeopVS1OzjeJboxEDwodHCde0oMBg/o24NanNLTd0wlSQ2mKTBspwLDsMuts9fhyKfw3i31YhJOnEQQkBetjeJd7fLh9UOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip7cb6VBcC2TLFSfICnFfM8hN6XiOFU4WuXK7TTUZxc=;
 b=FKI6F5XEET1h0IgF1v3BMHcgembULTSyiRWGTreYLIWFqhd/+llyNH4/sCQVtWYd+q+HNaJGIx884bw2slZtoKCuIfIiGyUUIh0U1VR2ayl3aytphM9dnCle4gTdeD6/Taveli2ba0bZKfrsTvL39Cc926N9kwkepkNDyPMCYu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 09:23:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.032; Tue, 14 Nov 2023
 09:23:55 +0000
Message-ID: <a11d868a-a691-acd7-8de7-df01ce74733a@amd.com>
Date: Tue, 14 Nov 2023 14:53:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amd/pm: Update metric table for smu v13_0_6
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231114085535.151807-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231114085535.151807-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a9d23f-b649-473a-8b32-08dbe4f36b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N1EZLvZ+cK54j8Jr+FVMCXzL0mH1Qo2lOJlt2ICzVZqL12jF7ByaxZA4TCpkdf0A0UULNfcdVW/Cf1WpbUFLKheY0S78EkEE5D9uRK3eKXDR9YyZhBkqpXufoOliXBySvGyiP8rDvIvPQ/9HWhaZW2gIpOdVhZ6uVn1CieqTgZNic8ePUutdNwtqUqO/ZmXhGfK55sgIJLsoxyc5jpsqMqr4Kts4HjclUcGbm14tKa7Kv84+unuoxvVNIQAcaPjDiqV9O660tOBhAuRk1H5VHFZy+Hr1jNqgvF0eQgXLGOxeQZfhWP95DPZ9j4InT5kZXGRt2WAzP34Cz2eG8ObiWiOfhxZ+oiSt39CiJBnzYRkahlUuqynuAtzzRU6LdFXxn8AkrJ9X72KyXbhaJpdWcAXDhO/ucU7w24J84q5V0++w2fIR/T2EzYxCbkR6tdBIqH8p1c//J8f2RG19+rl16uUIyU7apnF9PLSpM2HKRDtQW2ELHnn5yX/+go8PLju5RzJPdW0oin5r3U2OfesQoF0GFExyGIbGrWIrInKaC/C+6g/EuzyI5q+YWRTj1jm4c0YGOdWImkv1YhnUWWcX/hah8/HIXT1UhyQbGjm6Ag9wMh/i11roXamUxTMVGqz6Y8IZ/IO5usZOkVNnEsMGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(31686004)(41300700001)(15650500001)(2906002)(38100700002)(316002)(5660300002)(4326008)(8676002)(8936002)(36756003)(66556008)(86362001)(6512007)(66476007)(2616005)(478600001)(66946007)(31696002)(6486002)(83380400001)(6666004)(26005)(6506007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FFblFqWDVObGYzT2lUcUVDNHJubTZScWx1VkZzSG5UaS9BTngxUERnN0Jo?=
 =?utf-8?B?ZGVUdTZLMG1XY0JFTGNoQjFGMDBtTlluakRUTzFMT1FiMmwzZkpmeHErbkRl?=
 =?utf-8?B?RWppdkd3M0RzZlFXQyt5aHRVTWlHbXZOQmpiUCs2K24vbnJOR3o3dHpPMDE2?=
 =?utf-8?B?NnA2YjZQd0xiZ1RlamZsZTErUnVUYTJmZ0N0b1k0RjN4djVDck9RZTFWNkR1?=
 =?utf-8?B?NFFZSU1iSC8yQ1VSS0N5bmVxQjY5S2xQZjFpejVMZEZzT1BwUzRwNktmbEMv?=
 =?utf-8?B?RUc4NkFrMm1WY3FkK25KcS9GWk9TVlV5ODQvL21Cdm9maU9weEFDYXliY0Jw?=
 =?utf-8?B?SEJXR0wzTXJvTVpSZStxcFVqSHBUVDliV0V6REVhNEZ4R1JFRVdVM0p2OTZy?=
 =?utf-8?B?MENwT240L1JJYld3ZDVkRHltcDBCVldaL24yUDFBL3JGMFIxNjNxQnd5a0Ux?=
 =?utf-8?B?M3l6dC9BTzREejdRQ05QSlZDOFVnVlUwK1dueDVYTEFKTGtjRVNOdVYwRUxK?=
 =?utf-8?B?VEpnWEYwMnFaQjJRYzVsZHRURlh3c2JqV21ZbjE3dk93ck5meEVaT1E1Ry8y?=
 =?utf-8?B?cCs3SlR2V3Vwc2JJNU1KT1VrM3hyRFFRb1pyem1kTzlVN3VVY29mb0xOSkFp?=
 =?utf-8?B?VEYwRm1acXpCT0E4VEtpTDVqNTR3SUtWZW1RYkJLYnhvWWV3Z2JvODhtY3VO?=
 =?utf-8?B?MnU5dHRTdmdBc2NvNG0zNUFSR00wWnc5bWhabytDRFM3emZnQ3h0RVlRbFRx?=
 =?utf-8?B?ZCtMaFNzNzVYK0xQbWNadU5wT0NtQ2VPYWZ6Y3V4TS9rbkxBeDBXK2V6Rll3?=
 =?utf-8?B?Y0JjOEJKamMxQzdSZzlrS1doZ1QzazdPQlR2VVI1S2k5N1hzSDFLV0NyY0Jx?=
 =?utf-8?B?VHNtWmQ3SlhUcXNET0sxd0tEa0hUbExBMHhYWXRPeVp3S05ibnp3MmtXVVlu?=
 =?utf-8?B?YTd0VGErcVdUb1lVSUFjVXlrRlQ5bDJoTG5iTi9aaHR5Mk4vQnVqQ2tQaHIv?=
 =?utf-8?B?N3dqU3RYVHkyZGpVY1Y2M3BONnZybTJnT0dIZ1VKczI4dG40bnhqem5KVVUy?=
 =?utf-8?B?aHphK0V3NEtaZWhQNGNBb1FXbDNYelR3RTZyV3AyMmxrSWxPZzd1T0ZYUW1Q?=
 =?utf-8?B?bkJFdm5XZVFMdXRxdXR0WEF0ZDI2MWpKN3premFVWFp1eThSd0tVQ0g4ZmNN?=
 =?utf-8?B?L1hnYktBc21BSVluMkpuTmR6YW1Uajl6cVNCOFd3SnhBa212ZG81QW5mYXR2?=
 =?utf-8?B?b00wNW9Jc1IxUG5uNFJOQU5zdENYOEM0U2cxRXNrTXlyN0IwUHlyZjdFVnht?=
 =?utf-8?B?SlRUWUYrYjk5Vms3QVp5cGhrblN6bGdNOWNFS0FtY01uZnFWMWxJVlhhZ3g0?=
 =?utf-8?B?VEJ4S2d5UGNETUVLdUEweVJxdjBQcXB3ZzhTZENLVS9iVG9VRWRidWtEajhC?=
 =?utf-8?B?bGhxNUsvTHFBcGxQTmdmSWU3cmRJeGRDWlRvejJHelFyY1c2Qm1oYmZpVXhr?=
 =?utf-8?B?c3ZSZDlaUmFaU1JFN2NJS1h5ckVyQWRNaTNmeDM2eTZaMkI2UytwdVk5ZjA3?=
 =?utf-8?B?L3lFTzI0eGQzMk1NckI4ZGxQUnlNdWUyUmtTR2w5bE5TRWI2Wk0yRk5lelhV?=
 =?utf-8?B?Sy9MNm1OR241Y21ER3NSaVp2Z3pidnJNRU5aSHc0a1RkK2RlTVJtVWVXN0Jv?=
 =?utf-8?B?eCtwLzVncFVMWW5haERKenZSdUZkWXI4U1JlSnJqSzJubFY1blZvNE83SkJj?=
 =?utf-8?B?VmtGUjhvUnk3TlRydUVoVW52TFZxdGp5NTlackdSNVY1WEowQU54bzl6RUpD?=
 =?utf-8?B?amNlN1A5b3R2L1Q0dmZlN1Bjc3RZSG1TdmkyN21qQk5VWEMwVVdDWWpMYmVL?=
 =?utf-8?B?N0dFZ0tFa01kMjVSM1ROVllWalJkRVEvbGc2LzBWWHYxY3NpbXdYTVAzeFhk?=
 =?utf-8?B?TnFHWCtDaVBnYlhKbmdodUZmcktuTloralEzT1JEVE9pbTJkOXQ5emxTR3VV?=
 =?utf-8?B?QVgzem1ORUxsbXRiandvZThzMVJoTXNQam9SRjFhQS9mL3ZFZU1vanc4TmVi?=
 =?utf-8?B?Um1VRE84VEFMWFVGbUsvejBkM0t6dkh5Y3BicXN2RXNFQ1orYmhGVGpiUFV4?=
 =?utf-8?Q?USnEiWV2JztYabG3oOpnwyc3w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a9d23f-b649-473a-8b32-08dbe4f36b80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 09:23:55.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apPPup+k+Lwao1i4zxs7j5XtZNiMvLZBDkJfnTrPZWiJLTK/RzgqejBflu8tUJ7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/14/2023 2:25 PM, Asad Kamal wrote:
> Update pmfw metric table to include pcie
> instantaneous bandwidth & pcie error counters
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Le Ma <le.ma@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> index dab35d878a90..fef2d290f3f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
> @@ -123,7 +123,7 @@ typedef enum {
>     VOLTAGE_GUARDBAND_COUNT
>   } GFX_GUARDBAND_e;
>   
> -#define SMU_METRICS_TABLE_VERSION 0x8
> +#define SMU_METRICS_TABLE_VERSION 0x9
>   
>   typedef struct __attribute__((packed, aligned(4))) {
>     uint32_t AccumulationCounter;
> @@ -211,6 +211,14 @@ typedef struct __attribute__((packed, aligned(4))) {
>     //XGMI Data tranfser size
>     uint64_t XgmiReadDataSizeAcc[8];//in KByte
>     uint64_t XgmiWriteDataSizeAcc[8];//in KByte
> +
> +  //PCIE BW Data and error count
> +  uint32_t PcieBandwidth[4];
> +  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is accumulated
> +  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is accumulated
> +  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
> +  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
> +  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
>   } MetricsTable_t;
>   
>   #define SMU_VF_METRICS_TABLE_VERSION 0x3
