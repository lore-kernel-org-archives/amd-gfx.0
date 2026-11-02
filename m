Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE7606A327
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pI8ixnU/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D8910ED27;
	Mon,  2 Nov 2026 11:34:52 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2846B10ED27
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 11:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTAeU7q9uPqR5wIpA+B4hWgpJ+HgeRlP95znDwtYnZmIiTxIl9WZyKhRzyRQa8Fn6Ms6o/RcDMQAR/VkUbTtsU2AZQs9lUHhocEpclDwRAWfdFYDBSX6cU8KqDuywtVVDnr1RCEL6mjt8/lJGHW8SdoDgEpfbBfLbaNHVx3PfPfGf26QpdYEiZr8Firu945ZdboFRSbA7EpOpEcbW7K4olTNIfpWhXiaEpQiZtdtqxjDobr1ysgy8+L3ACSU+xJyIp9FXGpd+C3OkmWAf7k6/22kx638t+b9ZRTFBVrkWfA+HycE44cODASSGQHfqZSNf0nOIDbIDe2JrD+kS63QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6CW5l9RFhRiY0TbGaRsa/kb4jGe3Spxis1WKJkkNXk=;
 b=OJiN1znIO6hRuQqmflVsb6HnR9xrjjb6Lop4BsKxH4bCqzJQeB/A47+6C0uV9HW9eX04N4jaG0EXpqK+D+oOQK1o+Gby1SBZewZrlHGrWuFJwi7pP9ywOxqhsesoooUjMRHT9wWbFUdJrFR3S+ZTfdDsom7MeKobpAVpUYxb7wROY0J3aRz1kchgibfjuGCNZSlk2q7sCebpbcFl9q+czjBHd/G9UqJodSsrAVCsVnzjYCC+2hvrVatWwqAY0VarQ3TfTfMKxtsztKGsVVPn57ElisQq8geQTRO1t4k3b7cxyEzKEChyEQVkNIbO0S3S5U3/xjAmbSUAXU4N3ph/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6CW5l9RFhRiY0TbGaRsa/kb4jGe3Spxis1WKJkkNXk=;
 b=pI8ixnU/t/cOSGQibdReVInruyp9IZ8KOJVtht2FnajV96Py3cMimJsnd5s1zViIjcCoeqHL+yYoRszHH0ILDWwuQCxIP/OeQGBjirbtu1bmg2ArK1xbnrzbzL9E/FLmrfrLWeQbW3jif2ao3mCevd3+uyoJ/bjxVg8MG97pf00=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:34:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:34:41 +0000
Message-ID: <b4beffc1-c773-434e-92c9-97550bd0f8b7@amd.com>
Date: Mon, 2 Nov 2026 12:34:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: unmap mappings before locking reset domain
To: vitaly.prosyak@amd.com, Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261031000246.106812-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261031000246.106812-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0890.namprd03.prod.outlook.com
 (2603:10b6:408:13c::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: c7016c92-590b-4319-63e4-08df38d54911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UfqXPaSFsjjMVJinW+B7sULXLM9GHQT3Y7d+fSgivB17iGr4xDY6cbJCPZztu0LIgMrAXKQuXnZPvJIRSeEVPcIYxhFeqB5RlZYD5CoEN6uR7iPeZUPBvAffwaXzGu9IO2uaqG4qM6SwMJggZPGbXrN+TPWedLGYDqXglhy7o9FlvBomI85GE2/3Jo2PKQgwrtPWw1SYWY7NDH4e956AWTtBRe6gdIqh/PcEo8USfszuesi4SxAmPk9aenKekLkSEMq/XvsEG21q52JhHecPK0yiO54ttW+9FPQS4lzMgi8+Aj89a/pUIGyPJCl1kPSphV1rJLcYGmTpb/0T2DsevUv1YXnCL1TH7VQghamKFedtYnL5Sl6Ty/q6/3w2OOlscW6Cs1Bf2szIpp+yCcUB05eNQc+rfiz3YILuNAEVcBQQDZwf7E45wxBiz+ZfdV92PysYtaTRhcoA79tPZV2un5VZRtGFN2T6Y93enrJQ9jZZVWitRL1mK5ONg/oqUCDWwsrgo749uEdUJug1SnpSc/bNE7EpKRQyfy/ZKLzZxluNxGt1CD/915F9USsHOVDnqpxe+NpCACDJXiRXTPGpLG3wgpjQgR6oMzCbGo0nIyF8nYOUclkXpUF5MlNyugtRjpVNSKD/1TGHcafZcvI6z4EgyOWyZZAuph3Us0f0vbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZRNk43dVJIYU54Zi9FdHBTci9BN0hhTm9qcmVkQ3FJejZHeE1XcUhUTXcv?=
 =?utf-8?B?eFI3V2hmOGo0M1VqRDJydW50OXBvZGQyMjFOYU9udmxKUlVzc2dvYUFnR2JB?=
 =?utf-8?B?NUlDWDd4SkNUNFV5bFN0WE5ldStaQ2huTWZHRVowbG5Dc2VyenZiamtiRWxy?=
 =?utf-8?B?d3pGR3doRjUrU1AyZlQxNVZHaUNHSkpacE1STHdXMldUTmtTMS9RZnVVTlhT?=
 =?utf-8?B?dmNzZnh6N3dqYytjUEJyQ1JwMW8wOENkcFE4d1FDL3RvbllFUEc2Snd5dktP?=
 =?utf-8?B?bmtmRUtha0UvdlVYZktybk55UmtUTlFreTI5SkVWN1liWEhaMUxtbWt5NS8v?=
 =?utf-8?B?dFdoUUN0eDd2MHJSYms3T3BvdkgwaVFoKzhDb3NFbDFpWjdpL1FSdVRzaHJP?=
 =?utf-8?B?UGVrY0ZsK2Vrei9MS1BCNUpMeGxTZUxRNDhmR0NsUmp0aEdaVlJ6bkJOUmNk?=
 =?utf-8?B?ZEhaUXRYekxwRHFlbU9qRHU0VTNYSUhyODk3b2lZS0lVd2hHTit6eXk5QUlq?=
 =?utf-8?B?Q0JZa2hkamdGd3VlcXNDaWtwNzQrU3FXSVFLVkdHYit2MnhnU1NvSmdTbHhH?=
 =?utf-8?B?bldZd0JyUlNGM3BleDF5aWRjWmFRREZlWGtIL3BjQ045NUV0Rmt3OHFiY2xC?=
 =?utf-8?B?anR2b1I5QXFQL0tyc2ppNnkwS2tHaHJqSDNEaHFLN203N3BXSTlnTWQxeHdy?=
 =?utf-8?B?NkxFRGgzcTJucmVENjAweitrSVQ1SzhSN01uNUI0WEpWbTgyTGdOUGZrTHU2?=
 =?utf-8?B?dWRPY0F5UnVIM2JhRGhRYUN5WTZJMW9QczRqZ1lFRXlmeWNTNTdNUHA5WEl4?=
 =?utf-8?B?TC9qaEU5TlA2aVFhSFlzZTRPU3FubmpBN1dFNEtMMm9EUmtZNlIvMUVyNlRi?=
 =?utf-8?B?Rk5ua1lXZXhPRlhDYm1xeGRabkRuN3R1RFdkYkUzZzQyTFlJa3BwMExUVk1M?=
 =?utf-8?B?NVJSdEFtTnRXTTYwSGtpSGw5VnFNdWw3OFBvN3pHVFBVNlJVMXZhNi8vdUpB?=
 =?utf-8?B?bXN3bUQ4OXZMaXpqcmQwTmJpQ2VtRlVRQm14blpwb1Jib1dEdWE2NmxDYitx?=
 =?utf-8?B?bEN1ejNBWW44bDh5RTdhditmamRQWi84QTB5NVFYVjdicjBwQ2Q1QWc5d1Ey?=
 =?utf-8?B?S3BlRExBWmF1NGxUUmV6czFGaXMyT0xXQXFELzJMNjdnWHdUeWNvTkIzNzR2?=
 =?utf-8?B?UThZUk1LS2lJblE3cEE1SGNyV3pLdUo2djBLYlN4Y1ZPSVpYS0lqaUVrWW1q?=
 =?utf-8?B?bi8zQkVCQVQ5YmVIbzNnaUltS2lNVzR2Q3RFcVA0UjAzbTYvMjB3ZENqaTQ3?=
 =?utf-8?B?UlBrYndack00M3hCVmVENFZ4QWdKbHUvcEFvcExRS2RpeURjUlZJdElGNEtL?=
 =?utf-8?B?T2pOOHRoUklISkIrQUlJcnJVTkVnazlTL2JUU1JJMHRCMnNNcnREMkcyYkxw?=
 =?utf-8?B?dklkK3Z0RzhXYnlaVENYSS85Vzd3eHdmQXFDRFFYTVRuWExGTlpISzA5TVBR?=
 =?utf-8?B?R00rdUJwQlRlNlJmTUlCck9wTlpUaVJOWTF5OUcrNGp0YkM0cG5FcmRKYzVD?=
 =?utf-8?B?OEFheFh3WVJuUHFndW1NNnpkeVNCZU9UaHk4a2crWCtzM2VOMkNkaklRcjlr?=
 =?utf-8?B?SmkxTU1hQmYrMzhxS3ZKVXZuSnFFcUt0M1R0bk5sUE5jeFpLeFo4UURYYlc4?=
 =?utf-8?B?dkpMRnRLOU9zb054a3pZUldvbE1FNExaZ0dKQmwvK0dVRWl6QkxwTWF1aDlX?=
 =?utf-8?B?SnlTRFkxSldIVkJVazJnbDRQdm95WjhPc0tqUHhRMC9IQ2V5bEswcE9Pcmxp?=
 =?utf-8?B?RUl5TGFtaCtrZkdXemhNWEJDZkRnSHllVTNsVmdmQ3FTdkdoWlFZbGNEMW1K?=
 =?utf-8?B?cThUN2IzVEYwUlVuaTNNR0F5VG4wYy9ieG9KMzV3S2RpMGFsTTdibXBBaHg5?=
 =?utf-8?B?MVg2S0xOMWZJYXhJNmVoeU90cUlJK2JxTWxRVEhGUmFaOEJIeGVabTdQaWs4?=
 =?utf-8?B?NW1YSmgxdUpiWGlyZjF0TE5INHVGTkUyWUF0ZXYwUlhKV2grbWNiNXJwRXpO?=
 =?utf-8?B?WjVZZEV2YVl1R284SDduSzY4Rll4NTk4b0lZNmRidjNXdUlNY3FSOENOR1JE?=
 =?utf-8?B?SVQ4ZjhqSHRmcXoydUxjRHpiSFZlZmRaRFdVM3FXa09hMjZYcTQrWkJVaXQ0?=
 =?utf-8?B?N3MxVUJzMXdPVnE3UkxQRlZpb2ZvdWcxam14bzdVdDJWYVJ0aVVqaFpiQlBM?=
 =?utf-8?B?QzErb0tCSlU5L2pKM2w3QVh5bzRjUGtMNmVHQWFEcENDNm8xMzBQRmlCclZN?=
 =?utf-8?Q?epGlM/RWoGB38WrFBc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7016c92-590b-4319-63e4-08df38d54911
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:34:41.6599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO01noVKVMGqR7HTi0bX5lV8NIkWaRaLvbjDx19VwBjudx8FSHtiR03CxUrLOQrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487
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

Hi Vitaly,

On 10/31/26 01:02, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> GPU recovery held reset_domain->sem while invalidating DRM and KFD mappings.
> unmap_mapping_range() takes mapping->i_mmap_rwsem, creating the reported
> lockdep dependency cycle through MMU notifier and dma_fence_map locking.

That is unfortunately not correct either, it just makes the lockdep complain go away but doesn't fix the underlying issue.

One of the main purposes of the reset handler is to unlock HW operations and guarantee that dma_fence objects signal.

So when the MMU notifier is called with mapping->i_mmap_rwsem held and it must be able to wait for a dma_fence we *CAN'T* call unmap_mapping_range() from the reset handler at all.

There has been some discussion to handle the requirement to not access the VRAM BAR during a reset in the BIF instead of doing the unmap here. MI* HW already seems to do exactly that.

So my suggestion is to completely remove unmap_mapping_range() and amdgpu_amdkfd_clear_kfd_mapping() here and push for this HW handling inside the BIF. That seems to be the only way out of this problem.

Regards,
Christian.

> 
> Invalidate both mapping sets before taking reset_domain->sem. Keep the
> semaphore held around the recovery operations that require reset
> serialization.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ef01d280cd0d..407bf3ff9b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5789,15 +5789,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* Cannot be called after locking reset domain */
>  	amdgpu_ras_pre_reset(adev, &device_list);
>  
> -	/* We need to lock reset domain only once both for XGMI and single device */
> -	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> -
>  	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
>  	 * accessing them
>  	 */
>  	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>  	amdgpu_amdkfd_clear_kfd_mapping(adev);
>  
> +	/* We need to lock reset domain only once both for XGMI and single device */
> +	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
> +
>  	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
>  				      hive, need_emergency_restart);
>  	if (need_emergency_restart) {

