Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920C606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NGIBvgsx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C0410E474;
	Tue, 27 Oct 2026 21:23:52 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A42A10E474
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 21:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3FOQKAX+aYc7D7Rl2EYr+mI+rRPBkdy68U9IcEZidQ3mBNzLITEBf8VIrh3Zf1LwQNhmIRN6xxMRNvJ2sP6ST0rCeVhb9zduA8nIcJR2HntalJoRIUQ+iU47WU+oTYkIkumHp6/HvI01vdbLTofLcdvq8ED8C/3ng1xVA9ZxSiDVw4q6J61sHjwSbQhDrSnU88p2umHMA9mr481V26On6zjEfUOG9CWfwUPHA9UI3jBFT897awcP+z/za2qgqGrx4vGs6kqucXszXs00ObKX3OUXebYfYQIYcdAzynVVO/zLeOk+MEkNwIi9bBYbLwSjNgzkEJB6L4V5lleXjTzxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vvNU9L3n25+Ya2Z2wduLFB4bXaiAbiGQGsZoJMUoSA=;
 b=SQF4igICMWPWlQtcwNKWh3BKjdGgycAzYkezU0/SNxZi4jXo6yXf+HpH/hQlZhpFeCjMz4Sp1KwSjxah8wF033H0jn0EZ22S7WM4nWfVdHCcfp/T8vxOC9qp7N8QlOsenLS6BUgROacwNKhthDmSqYw9OUfhHPqdJTwb8UPjGLpOThAB8QQ4gdi0j3GCdUv82G83Fd/blhLya2WNLhHgQezVqhTPsLkWdw12bIvfCwxVVVxLjZtUCCWvteuAHX70/hjCDMy5pp3PmGmUHnRwFMXkbifVda6CTbgUEt2JLmRIssK5ME08oXZQwoaA6oAuUGS62wY0InHC3d20NdBrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vvNU9L3n25+Ya2Z2wduLFB4bXaiAbiGQGsZoJMUoSA=;
 b=NGIBvgsxGK9M/abx+APQhBhytujx5Ro7PSJ/orT8YecZksVoXt26BUYPCnmVB3/P9OKXNOl00IEZlHsaYsftdw19C3h1WQrTtxhNtfn0CfyRTvZw9Kjoq90oBPIgNaJKDJlr2z0qIVBCxDBAYL7SlxauG3qfb1TMqw4tL8E5U4U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS7PR12MB6287.namprd12.prod.outlook.com
 (2603:10b6:8:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:23:42 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:23:42 +0000
Message-ID: <903e67ef-be21-4131-a5be-7b7ed433b48e@amd.com>
Date: Tue, 27 Oct 2026 17:23:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/8] drm/amdgpu: Support VMID 0 GPUVA completion WB
 address for UALink
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-3-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261027195913.1794477-3-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::13) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a9870e-35ef-4667-e850-08df34709325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|4143699003|261021123027099003|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003|6133799003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info: PJenSkipDP5eUGkbph7rvp6IzeFJ0ytnhYAgp7bEVY1RTlbW6sddJuqTfuMAK89hK+CxgmEqV+50XyUctWRGwZqXneL16a2Euqtl3EZ8XbYT10F+9uMsAzYtfn2eSKrChDo5C4fCXJ5V/xJGXp65hPYCDPx0yra+HC4tZK2emY4gX04t5WLXi0CDcKH/NYT3qATYxOQN/STM0FfoVfTTpodTp7+XmS8dITypTlRVKPHifjwAb9t3eiHwiND2rqT1AMey6DnajN3K/KEoKC/FWS+6fLD4S4OdX/Ed3uWwQHzGnVzi5EyMb83tGZa4ZXu9HdLRwWx4hgLlZI5lJLrweK7mrNvQJ7ARlZOzvFIJOq/KxfeFVC5EOAFjDYTaxxk5q5OErBg9hQuIB+klLNVOyISgSNRUULTEy6Fj5bbEVdCFnzKa7TIdlcMfn6JjHHIA9IVy3RmlDWKgW83X2vNgqr9WBHpXfwP+UdOENCbkbuzkMpFLcTKd6A1omC9l7IXLgWucz+ndYuoMCctWbicTmXuBl8O0fcqO2Ie+oVifWdo+FJkFOGCjz1/5GN2dxs+HkTGjwd/qEY54au8uKSWUa15xeW6gIbMsSFTEpME+PKlVD4X+xmIprhVIileSr8T0GHKxlJF9wd+1uRP9cDI/6l6w28iyJmHjhW5FOmSzylM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(4143699003)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003)(6133799003)(3023799007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZOa3RrK2x6RDVaRGkybzJMamw1SUxVa3l6U0dqZlFldGRwb1hacEJoRVNw?=
 =?utf-8?B?OStBUW5xdUc3c1VOc2hTNWhWRzlCV3NYL25KMDJEM3AvbVlheGpxUCtsK3pB?=
 =?utf-8?B?YXdneTRYTk1tc1JTSWNTdEd6aGJUWnYvTDZlcm1DVWJtbVNHNFdiazhIUXgy?=
 =?utf-8?B?d0dxZUo2cnNGbG5na3lsREZnYzVhenpUR0JWZ1ZWN1I0dVRYeEQzT2FJdC9T?=
 =?utf-8?B?YjQ4dzVwQk83eDVqK2p3SndZSFRsWUtENzI5RXIvbGxVNzFWdFhyd0psMmJm?=
 =?utf-8?B?V2NYeW1IcVZiZjB1WXdsbDRJWkhUNE1jdGpXZDVDRVJNNFV0cFgySDRLR1Ro?=
 =?utf-8?B?YTlwM2V2enQ1WVFOelFNMEZkdzFGZDlzbUJzQUN0VTNucnhieXFCYzBwdEtL?=
 =?utf-8?B?MTRsdjIwN3VDTllPV2xFT0FlUzZRcFR6N3gzTkVFTmVnTVFzWlpzSHVGTlRL?=
 =?utf-8?B?M2hHUktlQmNKSVU0U3BUSk53S0p0UFhGNk5CUHU5RGtNRGYrUUFKY0xEMFhp?=
 =?utf-8?B?M3M1WUhFYk5ZeVllWlF4Q0RtOXRGUURKa0JiQnhteUxzZnNxa2s2ODl4eXJK?=
 =?utf-8?B?TWxDaHUzNDBjY3dyZG0za0hSWGpZRXpaNmdudUZ6MWY5SURLRk9Pa0VYMXpw?=
 =?utf-8?B?VjQyb2VIUDhSc1gvWW9xRktWT24rTWFiODJHRzhyQXh6UlhjNm5iQ21oM2V6?=
 =?utf-8?B?TGxNTjBCcVJRZC9MMVl1TEpxZnpQTGJna0p6M2RibEgrOEVHOVljRlExNzdp?=
 =?utf-8?B?LytkbXV2WlFmVENDQWFtWGNsdVhkcno3RDJFZ250ZXFic2FSREFwS0NTVDRE?=
 =?utf-8?B?UlVZT2duU3dqVlZZQTRzVHdyaitNT0VmZTBxWTBXKzBDS0ovSThQbGNYQ3E2?=
 =?utf-8?B?dytqNDg3UGd3OXBDSHRPNzhXcE9WaVBtUW5CemtDVVptTFMyUW0xRnpuWXRQ?=
 =?utf-8?B?WlFSbllEK1NVb2hTS1R3d01hU1FKdEwwanJXVzJBUVI0SVYwTzhoRktxR1d2?=
 =?utf-8?B?L0p3OEphNE9VbVVka0VxaXZQeWdnSEgwSkdjWk5OdTRkb3RkUjUreDloYmwx?=
 =?utf-8?B?RXRBdTQrRjJHUktCdnJ1aHcxalV3dFdHQ21pKzJzZTNjN3RWN2FjQ1ZVKzAr?=
 =?utf-8?B?NUpIYUZYMW5GK2w3Q2lXOVNPSkd6L3E2RzI3S3ZlK1lUUExqNUdjbVlqVHFC?=
 =?utf-8?B?Y2tpTmtnbkQ4MWNYT0QzTm0xdDg0a1cyUGZrWDFpRkpqYnc2eGQ4eHdxSi9B?=
 =?utf-8?B?QnhjTndKQWdhQlRpTHdEQXhlQ3cybTc4ZmxUTXpSVDNxc2pucWtVelZUSmFD?=
 =?utf-8?B?YnhTR1FtUjdDT2J6cG5hSmlkVW1FL0JCMCs1czRFaG9DWmt6SVdHZjhHV3pO?=
 =?utf-8?B?MW9FYWoveGE3NDF3MFNvWTd0K2l3cHZBN1djc2VYNDByL1RjS1owMXFYR1FK?=
 =?utf-8?B?MTlYY3VyV1d6MzZ2aXhNaUtqMmVnZnVSdi9aRlhJRUJhZ052VVl6WCtyS0Rk?=
 =?utf-8?B?VnhTNWJXRmtvL0RibEZYaDRRTUhWMWJ6aVlrUkREbml2bHBLTFhRSVc3aUM4?=
 =?utf-8?B?RENMTG9IZUF2WmI4NDVxWXh4OXFpZjhxZ08vbExkZWpocU5heGZmaEJzTHhw?=
 =?utf-8?B?UkM5Tll3SjM1ZXZSbFdxUCsza0RlRzA4di9sMUcxTDU3VlZJL0VFQ2RFcmxH?=
 =?utf-8?B?WmdoUDRsZXdKcERnK25HWXZkeGdzdThFVkZ4RkZpdytCVm44SytwU1RiSDRT?=
 =?utf-8?B?OG1wWHZ6ODZ3Y01lTzBaNlFGbmZIVWI5SlBHVVZ2a0RiMy9MRG9ESXhDUWZn?=
 =?utf-8?B?TlJabHVOUXhWM25ZT045NWtHTlRsQ1lpUGR2Ny8ySlE5d05ZWmg2T0NOb1R3?=
 =?utf-8?B?NU8wWHlqY2hWZGhpUG1LMFQzdmw5UnBIUVkxV25zczFqaGNPd05yY3lqdmJH?=
 =?utf-8?B?TGxhQnNRYWFLb3ZaeDZZRTRISWVvcWlYdFFFK1EyT2J4bFRZUWFIdXhmd0h6?=
 =?utf-8?B?NWdaeGJBLzB4TUdLbTJyTjVIdGI1VVZXemJkY0M1bE9UeWhYMjFoWGpsR1NL?=
 =?utf-8?B?WTJYVXBYQzJVVHZBZHNHaCt2YXR4UmtXNkJJc0RldTYzanRmSi91d1h6bmFo?=
 =?utf-8?B?eU41Um9zaHl0cVh4ZHBTNDg3aEJucjVHK0R3czJKamh2Zy84RURSMm1tVDUz?=
 =?utf-8?B?a1RaY2FHUzVIM2FBL3YvWFZBQ2I1QjBDT3kxVlErbTdPVG8wUE82cUZsdGZG?=
 =?utf-8?B?ZERjc3VFeTVOMlFyRmxxTXk4WGJXTkY2K200TlBWNFByRG8xa0ptdXdIMGh5?=
 =?utf-8?B?QUJ2UWQzN29ieU9Lc29CMXpVZ0VwcnIvRTVmcVhSa1BDYjM3WHhZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a9870e-35ef-4667-e850-08df34709325
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 21:23:42.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TK3JpglRi0jX+JK8ezA0uzR8pwNmu4YbjQIqt0EfGugK0K27yFyyrYdgSs60vvApJoGm8CU5wxOr4dDNOXc0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 15:54, Mukul Joshi wrote:
> The UPDATE_WB_ADDR remote command hands the MP nHT FW the address it
> writes command completions back to. So far that has always been an NPA.
>
> The FW can also take a VMID 0 GPUVA, selected by setting DW4 of the
> command to 1. Return the VMID 0 GPUVA of the writeback slot from
> amdgpu_ualink_get_wb_addr() alongside the NPA, and use it in
> UALink loopback mode. There the HW only carries importer -> exporter
> traffic, so the FW cannot write the completion back over NPA.
>
> Outside loopback the NPA is still used and DW4 stays 0.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 48 +++++++++++++++-------
>   1 file changed, 34 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 2cd6dc71ab9f..a186859dee3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -5641,9 +5641,9 @@ static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
>   
>   	*cpu_addr++ = cmd;
>   	*cpu_addr++ = wb_data;
> -	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb_npa */
> -	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb_npa */
> -	*cpu_addr++ = 0;
> +	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb address */
> +	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb address */
> +	*cpu_addr++ = dw2;		/* 1: wb address is VMID 0 GPUVA, 0: NPA */
>   	*cpu_addr++ = 0;
>   	*cpu_addr++ = 0; /* metadata */
>   	*cpu_addr++ = 0; /* metadata */
> @@ -5857,7 +5857,7 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
>   static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   				      u32 remote_accel_id,
>   				      struct amdgpu_ualink_wb **wb_cpu,
> -				      u64 *wb_npa, u32 type)
> +				      u64 *wb_npa, u64 *wb_gpu, u32 type)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	/* The GPUID encoded in the write-back NPA address is the routing target
> @@ -5870,15 +5870,17 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   	u32 accel_id = ualink_exp_accel_id(adev);
>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>   	uintptr_t wb;
> -	u64 npa;
> +	u64 gpu, npa;
>   	u32 offset = 0;
>   
>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
>   		wb = (uintptr_t)remote->rb_cpu_addr + rb_size * remote->num_accel;
> +		gpu = remote->rb_gpu_addr + rb_size * remote->num_accel;
>   		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
>   					     remote_accel_id, accel_id);
>   	} else {
>   		wb = (uintptr_t)remote->rptr_cpu_addr;
> +		gpu = remote->rptr_gpu_addr;
>   		npa = remote->rptr_npa;
>   		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
>   	}
> @@ -5891,9 +5893,11 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
>   	if (wb_npa)
>   		*wb_npa = npa + offset;
> +	if (wb_gpu)
> +		*wb_gpu = gpu + offset;
>   
> -	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx\n", accel_id,
> -		remote_accel_id, npa + offset);
> +	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx gpu 0x%llx\n", accel_id,
> +		remote_accel_id, npa + offset, gpu + offset);
>   }
>   
>   struct amdgpu_ualink_wptr_fence_cb {
> @@ -6057,9 +6061,9 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>   		remote_accel_id, int_wptr, tlb_wptr);
>   
> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL, NULL,
>   				  RB_TYPE_REMOTE_INTERRUPT);
> -	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL,
> +	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &tlb_wb, NULL, NULL,
>   				  RB_TYPE_TLB_INV);
>   
>   	peer->interrupt.wptr = int_wptr;
> @@ -6093,7 +6097,8 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
>   	struct amdgpu_ualink_wb *wb_cpu;
> -	u64 wb_npa;
> +	u64 wb_npa, wb_gpu, wb_addr;
> +	u32 wb_vmid0;
>   	int r;
>   
>   	peer = &remote->peer[remote_accel_id];
> @@ -6105,13 +6110,28 @@ static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
>   		return -EINVAL;
>   
>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
> -				  ring_type);
> +				  &wb_gpu, ring_type);
> +
> +	/* UALink loopback: HW only carries importer -> exporter traffic, so the
> +	 * MPNHT FW cannot write the completion back over NPA. Hand it the VMID 0
> +	 * GPUVA of the writeback instead and flag it in DW4 of the command.
> +	 */
> +	if (adev->ualink.loopback.enabled) {
> +		wb_addr = wb_gpu;
> +		wb_vmid0 = 1;
> +	} else {
> +		wb_addr = wb_npa;
> +		wb_vmid0 = 0;
> +	}
> +
> +	dev_dbg(adev->dev, "remote %u ring type %u wb %s 0x%llx\n",
> +		remote_accel_id, ring_type, wb_vmid0 ? "gpuva" : "npa", wb_addr);
>   
>   	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
>   				       amdgpu_ualink_emit_update_wb_addr,
> -				       upper_32_bits(wb_npa),
> -				       lower_32_bits(wb_npa),
> -				       0, 0);
> +				       upper_32_bits(wb_addr),
> +				       lower_32_bits(wb_addr),
> +				       wb_vmid0, 0);
>   	if (!r) {
>   		ring->wb_cpu = wb_cpu;
>   		ring->ready = true;
