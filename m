Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7F606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xTTbjVbK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC5310E5A1;
	Mon,  2 Nov 2026 20:21:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984A610F1EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuEz+7LQ7D9zLY1jN9UemL69h9QkXIeFIeL0ctTqk7M7j9LcSMjgbGVod1C2zHKZ1g3mWdlIkLAYKfnGOvhMZHWx74znROa8eyOVZ8pSt7SaDlVMAW7BHyGp4n0vLokXRPDHbsrhQvVuXcn88jaxKIp+I+P2Kx5+z5Eghe3ow9aKrxyFE6cObatdkUE6ARMWr2YPn35+nVrwRLZ7jpy4XqwE2BMXNoXXqQrnvtnGeyDTKuJM/WJ98jq3tCq0fkDqNMKacIWkSorb+avljFgLGmCb0FPl+utkhplLsdhVnl9ID1Cms3gaEFuO0v7g12LySHkktTG+o8Kh72lzcbl0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/vrFr0B97i6PgA+VApajnsUvQkcmYeDeOhIHHwBs/o=;
 b=C4weTSof9w16LqwOzREBFWWN2lcgoVKFi2Zk1+RRg1lUXzAenmdkARXVkQv2HegdMnQV5hwigs8Xqx1jOUx6D2NBC9mXS6GFQHNOaVWbio0rzJBCwMk1FaNDSO91IrcmiGwmWgw41AXN0ev61PEVlfeyTYR1rwnp/L4xkcZZ/pa/ZVWIaipXsTP+M4ATt0cvYZgHE8UlE2aqybEq24ec/hpAg9GVmY6YMp4XB7zYGXHANZp8e3JBFHhTAfhYbMNYfzZPTCqz8WdDQwFulC3xcoFeTtee+pYHQ0V3yGgF9R3SYalH4qx1+GuyxRdtm2LK64QIGSCs+ifDS/Uklkonkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/vrFr0B97i6PgA+VApajnsUvQkcmYeDeOhIHHwBs/o=;
 b=xTTbjVbK2th/qiJ1ug1eRgwoxcQecyAOmMbS1dMdpFvJa1zjRs0Dwa0wBZfTnglYcuCDYuJIt/+BO+Q4CuoRTPgpkmCpyuSbYoqsTynEZtC1jkrAbkPbnBgRdXsrax1CmbeGBM8cQ29Gf5BIi0WRV4oP5oEFbStqqDUuJpjlqT0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS4PR12MB9818.namprd12.prod.outlook.com
 (2603:10b6:8:2a9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:21:35 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:21:35 +0000
Message-ID: <a22fbb4c-d3ce-4b5d-b464-d2d0dd45f29f@amd.com>
Date: Mon, 2 Nov 2026 15:21:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: drop the dma-buf reference when a KFD
 import fails
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20261102082228.2149111-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102082228.2149111-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::15) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 614648a1-b084-47f7-9adf-08df391ee43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|261102123227099003|56012099006|11063799006|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: gnwy7U7YcQkuhQZpDYPh0X4tLgY1i7hZzIGWZSLN5EkiKgkuqeM6QuRx8Fj0RJT4i0I0CcmN7ZdU21ADih07rQDEEZm+WlKmEBqG+IQ2HD5M1TFjRp1a8Prm7toyHnkqQKlWDE9zTElIMdogeOdacwHWADS/tDseU9rJwgDtb4GCDKebYgmwcVQkY2Oqx07+EH2ep6Jhp1NJDjnlcf/2GdUn9bJ7YIRuJ5sDEY6GZqPFl7mFhWzS5WU9Tmk9K4hsnjgTTPe3GatTAn3AcyNuVDXvMN/SPNsQB9h+Ets2TvyyEZkEh2synZOEHpOtLqdm2gyQ25hK+8/JquegM9bHxFLP0dL2ef1CgTNu9FSq5bim2mpZsABeeWM8dpjD2/tgDNxn4KvwLed4/LRDr4lDoPCSgi15XgT3AW8tzCpKkpt+8A/KRDXUvjUkkhuLh6JGD5lYEwoc4C+o6X9gbH9amZUAdI1u+xBAfA4Zpf3HixgHRjm9SPisSOssyar9wRiwwCAZIjQ2+uEqje6qpcIH9Ogwe8EaattoqTu1WA3p1SmMhS7XdNG+RkptLFG3oLTMmLSeBC/hr4tNMB52HadDW5wgYIZKnHoJ9CBSZrtlt3Wtu9A0MUTo2+q5OxK/FwQMsVAkUcKS3jdxP6tGoEOvq5eAeiBkxkRimf3W+mviQtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2hBaCs5bk1YTXNzVGNFYWdNSDQ0Rk5KckMxV21DcjJmc2s2K1NBckhmUXBB?=
 =?utf-8?B?UU91QWc2Yk9qVVdKVDAzVnAzckxGTk1nT1hCRmpEbVp3NnUvTU55K2dOTU9O?=
 =?utf-8?B?NWlCbXZxZHRrWXNnSnFrY2JodWYxRnk4MTFVVWcrS2dQUDBBd1JES2ZaVWNY?=
 =?utf-8?B?TTFGTVArMCt2YTVjZVN1MWN1TEhWSlJnMFpkYnpEaXkralNGL1RadkkvRHlU?=
 =?utf-8?B?K0hyUDZ4YVd6d0FoWVhCZWhDUkxwMTlZZjIxS0xrSkJHOXl3bUpFNG5La1Nk?=
 =?utf-8?B?MThFL0RTQndGR0dDMU93YlEySTZqY29aN3JOYlhUVXQyWWRvYUJMVlcyODg1?=
 =?utf-8?B?ZWdRNEJUT0JWQStZc2pMWTlreFFmY0luaER3ZkUrYmF0Y2o2bERpVVh3WXI2?=
 =?utf-8?B?aDJ6WkNNMGFsMnBqcW1ON1NWc3RLZmNhK3VrUVdpdjYxYUJpVFg2TnAxQTk4?=
 =?utf-8?B?RjUzT0tFOFdibGRSNmYxUDE3SmUrNHhvbHpVamtCUzQyVHE5V3lteGR3WW5L?=
 =?utf-8?B?Y3N4NWdKUzNFTlRReldXZFpBZlFCZnBzaXJ1R3p4NDJNNlBvYVc5Z085MHM3?=
 =?utf-8?B?UDFnWU8xT09FeU5pMFgzS29idVAyYVYyZ3ZaN2huQ3RtUWRNK08vNGxuaFhK?=
 =?utf-8?B?VWVDYjVjVThlOTZJb1RlSmNGVko3bnFSamxJOGJSdWtNa1RCa3dNL1ZXbU5K?=
 =?utf-8?B?MWRJYU1Gb3dKZ29CYXFNOGppbml6b01UZGpkaE5MWFA1UmtEalJQcnNKVGpj?=
 =?utf-8?B?cGppRHdqdUszYkZuUVBVSnBGek5rY1ordkFsWFdKeW1VcGpMZW9Rby9oeUNH?=
 =?utf-8?B?aXBYekUycGxHMVhJSWFZQllmNHRIaXpLRDdONTdzRTAxYUJtaE5WOENEVktj?=
 =?utf-8?B?cEJQZURmeWY1M0ZqWDRPNWM3NCtOeWQxU21FeU1kN2RvT3FWQjhIWWdlRllm?=
 =?utf-8?B?TmtsSUFPOENrVWROdEVyL3BqRzh2Mkg3R21JTHZOSGFoY0MwT05HUTR3TUJ6?=
 =?utf-8?B?c1VQREdGT1ByVFNXZ1pSMjlINnY1dzVKQ3U4ZmtGdDVrdzRrY3hlcTRaWlJJ?=
 =?utf-8?B?dlpyVkpZQ2QrNkpuVUQ1WmNqTVJOL3BqdWFkZFlWcmdLYWkvV1RQQjdiVUtF?=
 =?utf-8?B?Z09hTFpXRlNhV2VVRHlEOWJqREl5QUxNQlpDbGlIeTZmLzBpL3BIYkl5aUFr?=
 =?utf-8?B?ckpQOXhpZTJNQ2lsOGNsaHVhNG5qeWtjYzYyMDhualBIRVUwWTdhbU5EVmZk?=
 =?utf-8?B?Qkt1VXgrZXJaNTJMT3h3bVBBaDhEOTFVdlNxclRRVk5xNENLSHNNTU5iMDNE?=
 =?utf-8?B?UGkxVnBYQmlxOGhhL0dpb1grQVF0VDJYclRJdUtCc1FjSElra3AvNGN2SFY4?=
 =?utf-8?B?NnVmY2I5RnJTbVNpeVZrWWxvUFpyRzVXWmxoMDRYMGgySVdWZlJvZXhIeFdC?=
 =?utf-8?B?d21LRlB2MW5GeDBxaVgyZXNGSTE1ZUp2b0FaS0g3ZzgrTlU4ZlN1TUlScC9J?=
 =?utf-8?B?VndjcXdUQklqdEg5N21GLzNDTjQrVmZ2aUJTOXhTeVk4TUl5bmN5RlI5Szky?=
 =?utf-8?B?ejFEQkFYSEdGWnhCd2N4cWFyK3Frb2xlODJVL2QxV2crdHBOK1pUOVp1a1Z6?=
 =?utf-8?B?Q0ZNSmY5bnFBK29zaDVYcGtIZ0RsRktJbzh6WDNPbkc0MW9vcWxBZ2F1QU1U?=
 =?utf-8?B?bm5tOXB2NWRoL20xSXorOUxkRGhWWnlPUVZEMGhmcy9RWW95WDA4dmZaNWdZ?=
 =?utf-8?B?K1F3Vk9QSkNYS2tLUUNhUmp1Mms5TWhINFdsNXJQMGFHeWxhVDk2cUNBRW5u?=
 =?utf-8?B?T1BPbDdDb0IxSmZ3VXc0NE1QVSt0VHh2ZHpXNHRVb1I5NURuUFlaYTgvVUIw?=
 =?utf-8?B?WFRSQ0hObSsrZHJCSmI5YjJaQlk1YzR2TzJoNmFxSk9tVlhqcnhPNXJIazBW?=
 =?utf-8?B?MlRHWGVSS3lFVHV1bVhvZkIrOU5OalM5NTUwenV0UURqalpuUzJudzVpNEMv?=
 =?utf-8?B?cU0wNkZYRVg4QStTdlpBdGt0cHB3T0lBc0dYaWV0L1B5cmU2dDhzY2FmSWVy?=
 =?utf-8?B?am1SSk1wKzZNVlJ2bXFZYldBU0Vxa2RxaHMwbVlQbWE0WWpFMEtOR0hIcmFa?=
 =?utf-8?B?NVEzSmhUNGFhc0lqMkJxVHRsekhGM0dIRDIwWFhDZ0F5Q2RvTDJJbFdzU295?=
 =?utf-8?B?Q0NSTklmRks5MXVSa3Z0djUxUGZKQk1WN28rZVVUdnJQblVaOVo5bzBBMFJE?=
 =?utf-8?B?SlB2UjJFWnZOT09wazA4SWNRdFNlK0ZnUHI3cWE4VHhLTzlXSExPSmw0Nlcz?=
 =?utf-8?B?ZUdxRXRKYzd2MHZ3TGJ5clVQQ3Nnd012bHF3QnhNemdVRWltVGtxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614648a1-b084-47f7-9adf-08df391ee43e
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 20:21:35.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caRgzxqNXAA019DQnNa8ebxpx7cgxkJ11DoZmODyAOjL//TM7Zuq/HO1im+4RpF8ExjJODzQSS3QKqtswP8RBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818
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

On 2026-11-02 03:21, Jesse Zhang wrote:
> import_obj_create() takes a reference on the dma-buf for the new kgd_mem,
> but the error path after validating the BO doesn't drop it. Since the
> validation reserves the BO interruptibly, an import failing with
> -ERESTARTSYS leaks the exported BO with its memory, and keeps the module
> in use.
>
> Importing a 64 MiB VRAM BO in a loop while getting SIGUSR1
> every 20 us and another thread changes the BO's mappings:
>
>    INFO: 171821 imports, VRAM used before 65 MiB, after 129 MiB
>    modprobe: FATAL: Module amdgpu is in use.
>
> Drop the reference, and free the sync object and the mutex of the kgd_mem
> as well. With that VRAM usage returns to 65 MiB after the same test.
>
> Fixes: 0e2e7c5b3d71 ("drm/amdgpu: Attach eviction fence on alloc")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c399b85731b4..2f8a5e7d3f78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2475,6 +2475,9 @@ static int import_obj_create(struct amdgpu_device *adev,
>   
>   err_remove_mem:
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +	amdgpu_sync_free(&(*mem)->sync);
> +	mutex_destroy(&(*mem)->lock);
> +	dma_buf_put(dma_buf);
>   	drm_vma_node_revoke(&obj->vma_node, drm_priv);
>   err_free_mem:
>   	kfree(*mem);
