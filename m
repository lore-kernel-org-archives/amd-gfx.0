Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18985C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479F210E50E;
	Thu,  1 Dec 2022 00:08:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED5610E50E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWtr6UfSveWIV2I/U58i0UtuAuNbYO2A0MFSMD8JmmqpFdYLWTNagrSrM1qlOs9rR6ubpwNEmzqB2uPig0vcSwK6LKd5sn8rN7BstvMr7t3TdpQSfphuZiVRRTd5MBBbNZIx9q0bKgeWIWYZexfFEX6d7EWKaWRmvktRlxBjrIaBRYK7ivYuBGDu8lZWl3s2v3iZbg8ZDLITHkQvr1PUSup51wSdnlZWO5DqmUlDt8yL2P5/GizGnDere0xY3sk1zbCL/Es8QP8fBEkUfxM6nXRQ005a88geYaYWThVKKlM7RzxD2W64PdPm2Z+nshis9eI2dvfdR/ZCuVE+f0ZDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO2/8MPH8rxaxi9gonCt91Kr+6uybtkCj0Q/Ux5zqL8=;
 b=fadzAtMp5HZW4Oxh/BHvVmviVPRI0nkKd9XrkA2p3YsVCoZilqa2EkD1gEJ70Fs5zVc62QRwmo8A9DNCB8LkFQqW/2KkIXGLIeVlcI/ib96VFurcfn/LYaov1XCF6z/sV/AWnlLtEo6gZZUrCFdQQTac5I0W5Hpeus9MACcMRsr2sFL8S6eHKrdMwDIosWI9Dt6DBjOZwutgHnByfiCiiwg7wt6wK9IP51NnITwHEfmKEX7Qei2g9h9yMB9h1i4z+vukXWXxe1e3badhVR7WplykSGcRAbXbWTm5HiVloTPnnw5OMjW1kA+6mBIlOr/rY2vpIOs6nRaZ50gXUuzLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO2/8MPH8rxaxi9gonCt91Kr+6uybtkCj0Q/Ux5zqL8=;
 b=xcbHjXnOMmLkqJYGXq78bQ/d+rzbuoUhCPAu9NnlwGCb8kwYRI9TFUrZT4PRCIjwETxiUnGo7ve4OVcSC33iiG4oyjFHwiBQgoOjTGIXd4WVjkiNFGeGC0iokyW5YXfcfvnZOrSf3yTRMZBjzKkR5jPpC08Ro7ux0IAV2uKoPys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:08:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:08:42 +0000
Message-ID: <48d34407-88bd-a836-ca69-4bbaab4d0537@amd.com>
Date: Wed, 30 Nov 2022 19:08:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 04/29] drm/amdgpu: add kgd hw debug mode setting interface
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-4-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-4-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b3c21e-5703-4a2d-ea04-08dad330348e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5Q8+CTXumjZDgLmuqLOUMT0k6Q9lioEhupMxu+dDdkKpSVs2h2xVEh0xdYwOixAnBC2LvnlxQUaCWKqnoDIXngX/Q8o7megdYUDCNMsc6XzTD3eKoeiNdzWA7ljboOhE9dc2rVP0JbuwUOxQhAfZNI2TIfcoId5tPSUAqHE5MHwBJb7wnPCYGuSREbfuTND8fFLfyzP7hYqVPcvRPLkaJxnKnBXNXjVnHTvkB66eLollnltlPPkCxdaR6ZtGthON4/3jG3dtAQNApEMlSX+6fWGI6E+qFLR3eXrHEFKltZZPcobYeCySizAxuB2W7Mv4IylDdjr2yrsbpIZjnH7LmvJHKvo5/0ArCVj7J51egV3/lT49efX9tlDZ47v3+TKYRaYAicj4cQZQ2Ml0H+Lr+HI2bYYsjp9zm/FVfJpVrAaGBLcjlJxFUC8AE7dbXChLHZ++Bci3FJMNinje9AbCIZ+xh+gu6i92VrV6x93A1dE/725TAHKmzwNbGKoaWAV3z601iltVfC1w4H7zJCy+06DweuLFmiketb99bpbK7xwgzaWP6raQAWpRGTWTcLXBv7FtQpyqNbmmSxlYYETeHmvjxa1SKO5lb/mHiyWdCcIA8inXLgaId7EweDHSyPRwSs2XAzTPwfNNjw7O6fBgG0pbm/zk483VHYFbIRFOZc56xhOLyvfKL+JR8zPEvjjd0Z4hUxfUv+jlJcRsHH3Kb3kU+YXmD/Dxi1LiKBpEGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199015)(66556008)(31686004)(2906002)(38100700002)(66946007)(26005)(66476007)(5660300002)(316002)(2616005)(44832011)(6512007)(83380400001)(41300700001)(6506007)(8936002)(53546011)(4001150100001)(186003)(86362001)(31696002)(8676002)(478600001)(36916002)(6486002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5Yb0M1eDFZZWE4OHVTODlkNEFHWW1zU1E1L2RCYlp1UE9CMWNSQkpvRWF4?=
 =?utf-8?B?ZlI3bEE1Z0U2MEhVVkZNclByYXlWYXJiaE5NOTFhdjllbnZuT1BuUXlKS0Nj?=
 =?utf-8?B?M1Q4RXREaUV0OVQrM2xxU1IxMnlqWXJ6bFo5ZGdKMS8yRmkwekxyUnRTanJR?=
 =?utf-8?B?VkxBV0dxbVR5aEwvcE5icnFJT09GVys2WU5pUkRONktHcXczNkplbWNMZElv?=
 =?utf-8?B?WXpCbldTdGNPWW9sVXVTNVBKWEZnckxZbHhZU3hIVUdWRWFENThCTXJHajN1?=
 =?utf-8?B?K20vQjErYVdkUytJbGpiOXZURzYxRHg2a1FRdlNCemdtV2s3cVdabTQ4ZWlX?=
 =?utf-8?B?R3RJT0RXM2kzSzJLd1VoSEFYNitGMzE4SmMyZjJpVEF1VUZuYTdaZy9Jd1NG?=
 =?utf-8?B?a2d6WGZoV0hqdUhTRUJWejA3K3Y1NUh5ZkRJU253MWk1MlZOYTBzNllQWjgw?=
 =?utf-8?B?cnREMGlnVFhldnhyaFhVcSt1ZFpoNlNiTThGTlZBREtaSVk5T0lnNjllYVRp?=
 =?utf-8?B?Z3pEYWtCQisxeVlWemhNVTBCSmVVZUZOdldYOU5GRmd5WmhNdEpVQjV0dHpP?=
 =?utf-8?B?cHptRjU2U21xaW9jT3pnenlIaFJXeS85WmZ5c3pjN1UvTURUczQ3QkVSeHVN?=
 =?utf-8?B?b1RWNDdQa2RSTGFBeExHSS84TERaWUdNZ1JNSlhDVlFlRFBtd1AxSEdNUmhV?=
 =?utf-8?B?ZkdsaFVTbGRyUldZTzNWT1dTZlJDbHB4UXRLUUtrZWtTUWlocmlnMGtHU21E?=
 =?utf-8?B?TGwwYytvR1M1WXQzNC81QzBTZjNMNGhKM0xqTjcrRi9HSkd3WlVYRXVuSW9L?=
 =?utf-8?B?aUx5aWVBUlhCWGpORVRwMnB0YTd5UmFFdENYOW9qaURBUlcvenJVT2NIS3FD?=
 =?utf-8?B?YlkvSzYzNWxoY3libWJON1A2ajJsZlo4MGVDRWxiSVRHVWFsVFdmSlpzUzFt?=
 =?utf-8?B?cDZ1a0V6dTVGc0JMTEhSTWE0d1hORHNRampJTVBBVDNhNU5oYUpEN1lJU1pv?=
 =?utf-8?B?Q3VGSEJYdVJGNy9kcUFjMXlEbHdLNEVESVYvT2QzQWMrZ1VEYzAzNW9aaTly?=
 =?utf-8?B?b0pVeGNCdkV6ZW1aOXBCTDZrM3lxY2RhUEc0NU8wN1U1cmtVbm9MR0orK3BG?=
 =?utf-8?B?VkNYSzB5VGxnRC94VFRPVzYyMC9OSGJON2RlRmx0WU84S3FlZGtJNm1MOVYz?=
 =?utf-8?B?ZzFLNEwyTWdQZ2lZN3FNY1gzcVJqTkNKaENadG5YMHR2VzNOLzJpc2o0dmZn?=
 =?utf-8?B?ajJrNTg4SWZiK2ZNQjJjM2owd2V1WVBYeUJTTjBEcDNDWGFNaW1SKy8vVW1W?=
 =?utf-8?B?aDVZa1cxZWRQMlBIV3RmSVRnMTZ4TGhDbWNjNHpVSUVZemRzbXR3WXZaR2lP?=
 =?utf-8?B?bUhxTkhGcDJITGJXU0dTdGoyY1VjZXpVN3VtN0IxR1E3YjFNelZGZGt5aDlE?=
 =?utf-8?B?Wkp2OHgzZVhTMEZON09ZMDJER0NOeUZESmFrRWJJak9HdURKQTVrSVJmbmVH?=
 =?utf-8?B?NHplZlhCKy93R2JieHJCek1TWVlGTWZlQ2M2Ky9IazA4MDY0ZWx6UHZadUJL?=
 =?utf-8?B?MElwdERSdVA2d09telFvYmozR283cWZET3BKNU5MNWNvTHZ2L29mdEs5aUky?=
 =?utf-8?B?Q3ZnZmZoS1NEa2d6NWgxYXVjZVhDcXIyZStaVERCb0NhRHgrQnBkODZxMlJI?=
 =?utf-8?B?eWhKUGZKKzJLdE1HQWx0b3RkSkpqUXJmdUtIOUtNVDJGUmw2V05iaEg0RlF0?=
 =?utf-8?B?QUJZdkE4QThWUkZWQnUvRnpMVXJLZEY5NnNBK0dscmIxWmJCckM0UG1BbHZr?=
 =?utf-8?B?RHR3ZVBXbmkyRUlRTFlLUWdJVzMrMEpaVUI3TlhwZEJjUU02c3JQWlFZQi9G?=
 =?utf-8?B?YzBZQWw4cGE0N2w4UGtlYlhpSFRUcGR4ZFNBd0oxWk4vQzI4c1VUaStJdHlJ?=
 =?utf-8?B?ZDJmbkhTaC9nd0dnc3lPd0tUZE9pbGROVFlNbGJoRlBvai9MazlEOXYwcXpq?=
 =?utf-8?B?eU1lbXA2bllFNnBTMlRDMVp3NGJGMmdmL2d5VVZaMTNQSTBMMGV2TlErQ3E2?=
 =?utf-8?B?VDJNSERmMkZjSktCMUxIVWhEUHYrUkpTd05KSU5YZWJ4eDliL0hTTXNPQlBB?=
 =?utf-8?Q?wXYGH9krBTvwRIzC5xg4c4omP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b3c21e-5703-4a2d-ea04-08dad330348e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:08:42.1424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6fP4BSTFzAoqM3/NBT7IpPYlXhokvN6F6LRlrdqUx9WJiIIU9kB4lOWRh0uebEJZQsVX4PU96IeSGuqbl2/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886
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

On 2022-10-31 12:23, Jonathan Kim wrote:
> Introduce the require KGD debug calls that will execute hardware debug
> mode setting.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 34 +++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 5cb3e8634739..15e7a5c920a0 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -289,6 +289,40 @@ struct kfd2kgd_calls {
>   			uint32_t vmid, uint64_t page_table_base);
>   	uint32_t (*read_vmid_from_vmfault_reg)(struct amdgpu_device *adev);
>   
> +	uint32_t (*enable_debug_trap)(struct amdgpu_device *adev,
> +					bool restore_dbg_registers,
> +					uint32_t vmid);
> +	uint32_t (*disable_debug_trap)(struct amdgpu_device *adev,
> +					bool keep_trap_enabled,
> +					uint32_t vmid);
> +	int (*validate_trap_override_request)(struct amdgpu_device *adev,
> +					uint32_t trap_override,
> +					uint32_t *trap_mask_supported);
> +	uint32_t (*set_wave_launch_trap_override)(struct amdgpu_device *adev,
> +					     uint32_t vmid,
> +					     uint32_t trap_override,
> +					     uint32_t trap_mask_bits,
> +					     uint32_t trap_mask_request,
> +					     uint32_t *trap_mask_prev,
> +					     uint32_t kfd_dbg_trap_cntl_prev);
> +	uint32_t (*set_wave_launch_mode)(struct amdgpu_device *adev,
> +					uint8_t wave_launch_mode,
> +					uint32_t vmid);
> +	uint32_t (*set_address_watch)(struct amdgpu_device *adev,
> +					uint64_t watch_address,
> +					uint32_t watch_address_mask,
> +					uint32_t watch_id,
> +					uint32_t watch_mode,
> +					uint32_t debug_vmid);
> +	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
> +			uint32_t watch_id);
> +	void (*get_iq_wait_times)(struct amdgpu_device *adev,
> +			uint32_t *wait_times);
> +	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
> +			uint32_t wait_times,
> +			uint32_t grace_period,
> +			uint32_t *reg_offset,
> +			uint32_t *reg_data);
>   	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
>   			int *wave_cnt, int *max_waves_per_cu);
>   	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
