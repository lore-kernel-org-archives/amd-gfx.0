Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049AA105F7AE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 14:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EA410E10B;
	Fri, 13 Mar 2026 14:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niCRpORj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BFF10E10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0Db3W9Rfl2YNLST5oeeIHRodEiR6mdsvnhiXg2mzANtbMDA39SxafM/WnASFsa1hCmpjaK1CZ5SgboSZ3oLAewUHV+TeF92tKkv9oaAQRkvDyO4MrQC68Q4RHVabS77cPkmEK2hlpcFtywvXVcjttDGzPsaxusOBQDqxj4npHc/LZlIamE3YpLfJrX+mTBNwywsmrYId4FrCkBMMN7STZslmpSciMJfq4kZ1HHy8OsdK4E0XecFYnijOka3T/1oSTN6Q+ye8jP1ExVUGlBoM5vDhQaKPIFjpPcGdk8VnJhWyozEGudJaUOPxSMcOm1We0SMYVjeNXcyu14R6wcNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZys63scYVtnWqZ/VS5ZGQI5pWlNExQnoi8oZCzwNNI=;
 b=B/V5D0uZUXLN3YQ9LSoJR4RzJjDGcH3rf5yryBpkh3g4CuDX6ZDeit1sCWRhlofXlzoSgg9tqVmSGh869IAW9xoHANLg5AJ0knrhMBWnxYH5bRMbfcEYkW5NhBO9nbUfmqSwEFf5RNGLmuPzCUeuPmC/Dk/UA0ZG0aiRjQJ48e5/Ue1b+nxWE/XASrKpv9DG8MLqVihSCgg0+nqvHQgErjyIfye1te6BC17Ek6cEr3GGc4fNQ7NNq/LHZ0K1e2EqJuKRVJ6ysnv5J8dBHezSVCILY4I8TF4DZDlSOm/SzmfBQKnQrTJrohQpLd78ToJdR3wJrqtLpDjeFM5jX/S6Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZys63scYVtnWqZ/VS5ZGQI5pWlNExQnoi8oZCzwNNI=;
 b=niCRpORjdl9Nn70aHlAGDAKNdGNTyyQWvj397RTqCGPFHDZ41gaJC2ZoOcMz5rpc+bQYhoh+UH0rX65ZnApkM3RnxPJjuDObEJzPlowdj5b/CDKQqHSIp61NenOLoNmFXEz0BMG2MmLUiljdR26A7XvDypjQCVrY36A2G0Vj7wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 14:46:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 14:46:45 +0000
Message-ID: <b82116ff-6354-44bf-9a20-e56265eefcda@amd.com>
Date: Fri, 13 Mar 2026 20:16:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep struct
 size 1KB
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Monk" <Monk.Liu@amd.com>
References: <20260312125121.1838642-1-srinivasan.shanmugam@amd.com>
 <DS0PR12MB8813F2DF9593AD35A2D7F03FF445A@DS0PR12MB8813.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS0PR12MB8813F2DF9593AD35A2D7F03FF445A@DS0PR12MB8813.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e93fada-f0cc-4374-1427-08de810f58c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: 7okPjFFgWTxGBhqh0Yfqre84hNF/IC+9iJABXDwBynGNwprmt2vM7tffNG7qs52hSySpNTKvrRPNEYaaR8CjKVIqltUXtY06aHtduw3uuVAQU+5LnJzmuqLD9K/8hr+WdkZhtVDJ51NY8Fl51qodT8HP3Gxi94A3kyaoHYXasvSCMEpSBjRunc3Asca6KHR7f4IVoHXi0u0TNFT+mjdXqyw93yOQKz6m2blEn1VjRbcLPdJbYP8iUe1tSABe7GHpuXdiNmx8tclhEBCH6LBJ1EYzUV3Ib+BYjj6KO+m4S0p5a7E2wQT3oS1cad0adfgpxUIEZbIKyZmP3RFrvBarR+Ihq6CaAj276wlR01TYR2O6UyUa6bN9fdAkJaFeq0X2gbPQ5sgvcrcEvmhome8dukb+eUE6AfwozKR397RsrIKJO1AiLb6h991haciwerxYtQO4NhcKOjenaXMj61ODX2AlyAUef5FS9cOhY+c9IO+PkdvWzvUHEbfA9P48Y1LHhqRP6pafgtxT/pnPtOONHdRvEtYcRavmmRby5+EniCnNurM6gAEyoIZRXM7T6ZJAadKWvZSaPFf397lYrtaCriQET30YOzEgnpBV3maGRNzPaDiKEnVbJYmVIrh7sgrLbdAxLQoK+H82/mXacvOhqjiBafeD0W/9+dwKRR644SpbLREjxV6WzTemg/MrGRqC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFcvdm9Oc202V3dWRDRlWEZsd1pPeXliYTRMNldSYitFanlsL2hFQXd5aEtZ?=
 =?utf-8?B?VlV3UmtYM0ovSkJGTk1nNTZDaXljQ1NnNUFLTHFCUC81SmxVMlZxd3dJM05j?=
 =?utf-8?B?ajlDNENwT0o3ZVpJSlNEeklFaHNiNE9oL3NtUjd6ZTVmVzJWM2UwaGx6dzU3?=
 =?utf-8?B?L2FMSGE1SXJIalY3Skk2TFNoaXdPa0kwTWJjZ0xPZXl5bFh3Wm5JLzJkbWRT?=
 =?utf-8?B?OEY5c2lOVXpEQk8xa1lqZ3haVGV4UjRiV2xPdGdzUVd2NjQ4TktKRFRCSVdZ?=
 =?utf-8?B?THpQTTlrSWlEZ1hHMW1PUHRCQ0FUbURMdDFPWWNTQ3lIL3B0TjllcmxzZExO?=
 =?utf-8?B?VVBpbldhR3dwMUMzTlNkbHZuVXZ1b1NOekdscFFMemJSZ3R5YjlORnFCRW5C?=
 =?utf-8?B?ZVAxQUlCc0ZGcEs3eDlDQW1GVGdpWWdTUVFiYWY1aEd2Z3lpNldOV3VRdEJq?=
 =?utf-8?B?YTIyQzdWSjJKcy9lZllHbEI1RXdUWkp4WDJnTCs4V1V0R2c5TmdyRFNpMUdH?=
 =?utf-8?B?eDFRL1RGN0NwQkdRVVV2NVlheUZsVitJMXJadGhucUxQSXcyWlBRZzlQaWxM?=
 =?utf-8?B?ZmVkb3pMQzB0YzFqK1k3YmJDcEE0R3lHWUUxcnFVQW5WMWFPNkh2WXhkRXZu?=
 =?utf-8?B?OFdhZ2gvMW9oY01wWkNNMk5keUhUNmhvL3Bmd093d1Q4cGJKNmo5QkpTcXRi?=
 =?utf-8?B?ZFkyRTJPYVdOTjg3T2UvbGJOMDMxMGo0eXhITlNpd0tWaXlWTm1vZSt0ZDhv?=
 =?utf-8?B?LzYrMWkzRW5GZS94QUtFaGlzVEUwNy9TUkVLdnZRUGk0Qk9ZcUcyN09rWTlH?=
 =?utf-8?B?TkdXSzVrdCtNM2I3RzFkT1pMcVByM1FrS29LbEJURFFBSnlnbTQ2OFhEVjZ2?=
 =?utf-8?B?WE5lZSs4ZDFISWpyRjY2d1IzYUI3Mk9lVHFiNnczbXNKZEpLaFErTzZYZXdo?=
 =?utf-8?B?bU96SUJKNXZ3dmdaNG85SlJjZDBob2JXZEVzS2p6d05ac1RMNFZDbEhSb2o1?=
 =?utf-8?B?RjZONnRSS1FHUk8zQkFld1MvK3poZDBhMlJKMUtpSk4xV2xDaXJBSFNJcHRX?=
 =?utf-8?B?L3RmYm5pNGFPU3F0MmV6TWJpbTF2TVZjM01yNGlJZms2eTVOTGtDVkN6NFds?=
 =?utf-8?B?cjFYRVkxZjhsU0pYRzcxb2VmYVpWalZ6c3lHMENvMFEzYmtZYmZlank1N1ZC?=
 =?utf-8?B?WDNMYXZoS2ZreU8wQldkZzBmaVB6RjkxYm5FbHNwU2V1c2FDd3hVTjFXQmFV?=
 =?utf-8?B?aFRJd2xWb0k2aFdPV2ZGdGVuWm1ZOU1YMzNGdEtreDdrdzBDdjVySUpYc0U4?=
 =?utf-8?B?TFpVMGRHb28zQTNZY2g4ZzhHaW5uWUpTbXVUK3hnc0srVU5ldWMxMTBuV0d2?=
 =?utf-8?B?QXBGUHZlbExpdytRdVZITnQ5NTdNSUNlV3VleVJCLzg3Nk1OMTB3R3FFYStZ?=
 =?utf-8?B?WWtKZGo4VzNBL3pJRXBxRWhhTjNBZ29kZ3pUNWpWR0xyK1pHeHVOTjlsaFEz?=
 =?utf-8?B?YzZxL2FlR0VBMGloa0Qrcm5GTXFLMU9XamFsNnFYNWh3MXlPVDVmd3BtbDNN?=
 =?utf-8?B?Vm9kaEFLSlMvV0QweFBsb0tHNk0zRkNHcUpObkRXRUh2RFdZZ2p1WSttcGRa?=
 =?utf-8?B?VnZ6Um84OWVpSFE1ZzdzME8zVzlSOVVBZ1hyUy85ZjBCV1JMR0pxREZrRXF5?=
 =?utf-8?B?RmppVG9UeHpTalpHeVF4dDQxSEpGT29MUk50amkyY1czb3ZtK1I4bGNwNWZt?=
 =?utf-8?B?Q0pWM25qZVJOc0NaYlBNRTdPVHFlTUxGTFdXR3l3R2NYQmg1dGNlSERzb2Fs?=
 =?utf-8?B?NklCckUyM2kwY1MvenlvVkREQ2IvclVsS29qdXBQWFd3a3crYm9PTk9LcWJo?=
 =?utf-8?B?alpzcHF0bzk4ZHBYYzdtSDRlZ0o0Y0NnZ2NxWXRJaU5oTG5rbkx0cm9KTzhR?=
 =?utf-8?B?RlN4SnBtcXg0TUNMYmxiTjNaaTV6VkhqRDZOTUJCQ0FadXBvMklxa1RreEFS?=
 =?utf-8?B?dEtDeU9oT2tSTUlMWk9HSWpRU21QY1ZxSGNSbVJERjdHa3IyY2V4b0EvaEJm?=
 =?utf-8?B?S0Y0TUJaRFBFSElPRlpUSWllMTJRTDQ3MS93cEl4SEhhMy9vcUphRmFIMHNl?=
 =?utf-8?B?anZzWnFPRHM3cDQwbG9zdUsxdFlGRlhsdkplTHQ1d1Zia3locEg2K0FEQWRv?=
 =?utf-8?B?b3pXeWdrNDdMdWFDK3F3V0hXWkhLeWYzQmNZYks1WTlxUkc5QTdjTThKZndw?=
 =?utf-8?B?R3g1bURrcHpjSkZQeDhUa3RXdHBiRTRudGk3b05XbDdCZzgxcmx3ZCtCOStH?=
 =?utf-8?B?WEhmRjhnS25nRGNVMDgyNkpKME9hc09zNGszdjV6Wm8xUStud0E2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e93fada-f0cc-4374-1427-08de810f58c7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:46:45.0685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPYg8Q7DiTxxkpj8I4n/vARKS5ciIuz7vr40uyGSjWqZg9VU+9xgecGfvm0jm+iB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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



On 13-Mar-26 7:46 PM, Zhang, Bokun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hey there,
>      Thank you for the change, but this header is already packed.
> *#pragma pack(push, 1) *// PF2VF / VF2PF data areas are byte packed
> ...
> *#pragma pack(pop) *// Restore previous packing option
>      Please check these 2 macros.
>      The header mush also match across platforms, so we prefer do not 
> change it.
> 

A related discussion - 
https://lists.freedesktop.org/archives/amd-gfx/2023-June/094818.html

<quoted from related discussion>

https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/

Thanks,
Lijo

> Thanks!
> 
> ------------------------------------------------------------------------
> *From:* Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> *Sent:* Thursday, March 12, 2026 8:51 AM
> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhang, Bokun 
> <Bokun.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>
> *Subject:* [PATCH] drm/amdgpu: Pack VF2PF ucode_info entries to keep 
> struct size 1KB
> 
> The VF2PF mailbox structure must be exactly 1KB, which is enforced by
> a compile-time static assertion.
> 
> The ucode_info array currently uses a small struct containing:
> 
>    uint8_t id
>    uint32_t version
> 
> Without explicit packing, the compiler may insert padding after the
> uint8_t field so that the uint32_t field starts at a 4-byte aligned
> address. For example, the layout may become:
> 
>    id (1 byte) + 3 bytes padding + version (4 bytes)
> 
> which makes the struct 8 bytes instead of the expected 5 bytes.
> 
> Since the structure contains multiple ucode_info entries, this padding
> can increase the total structure size beyond 1024 bytes and cause the
> 1KB size check to fail.
> 
> Define the ucode_info entry as a packed struct to ensure each entry
> remains 5 bytes and the VF2PF mailbox structure stays exactly 1KB.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:510:49: error: static 
> assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
> 
> Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
> Cc: Bokun Zhang <Bokun.Zhang@amd.com>
> Cc: Monk Liu <monk.liu@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/ 
> drm/amd/amdgpu/amdgv_sriovmsg.h
> index 847cfd1fd004..31fc54111519 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -328,6 +328,11 @@ struct amd_sriov_msg_vf2pf_info_header {
>           uint32_t reserved[2];
>   };
> 
> +struct amd_sriov_msg_ucode_info {
> +       u8 id;
> +       u32 version;
> +} __packed;
> +
>   #define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (73)
>   struct amd_sriov_msg_vf2pf_info {
>           /* header contains size and version */
> @@ -367,10 +372,7 @@ struct amd_sriov_msg_vf2pf_info {
>           uint32_t fb_vis_size;
>           uint32_t fb_size;
>           /* guest ucode data, each one is 1.25 Dword */
> -       struct {
> -               uint8_t id;
> -               uint32_t version;
> -       } ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
> +       struct amd_sriov_msg_ucode_info 
> ucode_info[AMD_SRIOV_MSG_RESERVE_UCODE];
>           uint64_t dummy_page_addr;
>           /* FB allocated for guest MES to record UQ info */
>           uint64_t mes_info_addr;
> --
> 2.34.1
> 

