Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F461090225
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 13:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE0D10E4E4;
	Thu, 19 Mar 2026 13:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gPk32AS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB610E4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 13:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbsXLWEzkx+4QUY3nUYSjSIlMc5dPT92ZdfauKVq5C1+OM1m9FksYGXLvWaXG6MVv6Ud1l74uumLud/vzFjP1X+3HuIIsR8QGnoo2pmNEe8GLNfrbtLGgq3E73Syb2IJlutsTF948nI69ePRMLDsMOgNzfhEcda1FGu0dq8xywYDjnCken1XvGbqBCjHEDIMHB8yiOPOZeLLv49BgEobi0s7GQ9vGo+lekbSdLvcLVAojPGRFhfqbmRH0kyEx/xlWyNiIJ+ipwW/+VCgicjsmKfZxT9U1YHNxT+utqJnTJagLrePPTnUYTfxSgqmJ7b8VJ0V794j/ILRxR7pjfvSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYJ3sIXmLWx4Z472wc1qbxyjudpgGcaZ/3TlGokEscg=;
 b=F8t0Dgy9MFNFV4r8T43XTfMDN6XWfhohIxlMFnFrnIPg1m/X8zGe/43s+xoZkprNPB3fFToE5UGIZJEVaV1LmtJyNLdfB+UYL+nX54qcwjI2MiRCDrAuENKXxvcLuZzN8D+uUk2629OEjrZrLdGcC1Ce1Va0PWkEqsDmIztGBowo+zfzfoZIqA8pNfYCWoH10zlYYHfeMWk5qaa4kA+X0dB0ggBfV3g8cHJ+6j9jp3NzWklPl9hQu7b3KcBmR5zff8BiVxynEnUgHVRz270ZL43Sx3NsSYWvMQeNhx6K0KCxEGnnxfAeKwL9QCDUcNs4cevd6PrtGtGQluXior19tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYJ3sIXmLWx4Z472wc1qbxyjudpgGcaZ/3TlGokEscg=;
 b=0gPk32ASlSDiim2M8zQzp4vy2kp9+w2kDqe1xGqPIoyZMkZ0go88roSKpvEzUAPrhSX13pzSfmBl0jgVAEU3EOitNETvxxns8pGf4J6Yh+Q4eM/K/G4Zwlx1KcaIga0kpa6gHCirrlmZ9a7dUXpIQlA4ZowGDyCQu3lyvLoufxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 13:30:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 13:30:53 +0000
Message-ID: <51b0f1cc-c10d-4359-948f-5049128869a8@amd.com>
Date: Thu, 19 Mar 2026 19:00:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review V2 1/1] drm/amdgpu: Add amdgpu_regs_pcie64 debugfs
 node
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260319061530.114010-1-Stanley.Yang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260319061530.114010-1-Stanley.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3dfbaa-e3e1-4012-f15e-08de85bbbe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: vwBUpyfIvD2RCLbliNArLccM6/SSIJtN3SnpQ7FqNrM/bn1B08AB1z0aJbrSn3VjAJQtH5DwdYWpOJZzahK0l0R6a4QeEvLsg5Q2lj2tiD5Nfks7NSlfL755IMlAbFnVtnSqJqgVVCzZitMS6X5jalGnAwAt/ZtzU5a7FFb+vmfXq2hTTJ59KOJe3wq84EW4qPRkBQ8F/500g82JWe2IipHNvOdPBoZcEtlUQKGSWqWMMRnpR8TDYrCAWvlg8O4UUiFhWu5s2l+LaCG7s99OO/mhksLCHxHYy/RJOhXfYz8hXOvySapCbmU8MwD3p2xpfTJeXKKTGd+v0j2EgXnKNgwHB5b6cuKHgwEORnl2VhKLJjPDYCdkfOmiJqHHAaFKOvJdb8VLbxwzNWmEudO/OxgPH6M/In1DzfJtdT9kebUuubtXBCNIY6k9lM9uF+/Mp/s+C/2Gc8Dn+/x6XRLneTSdwmwPlMaAkBZI1czHDDdamnLD+mdl6UsCXTaIVPovsfcJx8+N6sqrc+APgZTatukVHgbXcnWC4rnwaD5yEZ0qxseG4XQ3mPRxirjvnYq7xEB9hjlVvymUyEXea2iko3I04GIvUFRXSKmzbPUzgEX93SBT9XERR1Z+hSfSoTh8oH8FI0NPsh4oKztwmBxXabNqdug/kvMU2AF+VRQzUWUwVbA1pXsCyRQEMwhuKjO18CpSPmP0lUW3QZ9RqhKeYjFrxZm9HgUKgExptswgiGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnM4OHdwZHBjc2YvV3UxTnZiU3ZzcHd2YVA1STdTNTlGTVpwMFNzNmZ4Y3Qv?=
 =?utf-8?B?MHVxZkJjcmRhRU83K3dVdytlbmtRNExYVTNINStDZERiZk41bHE5cDZEOWt1?=
 =?utf-8?B?V3hhbE1MVFFzbGdMSlVSUU01OCthWXczVGowUUJQaG83ZkF1WHo1SUNpbWlu?=
 =?utf-8?B?NFA4RFd1WXEzL3pzMzlGWHdvdEhGUmFtTEpFSFhha2NJWU1nSWhndWRhY0ZO?=
 =?utf-8?B?ODNWanpHUkNGcHRPVkIvcVdnUko3TFVYc3pUTlBvektCNUVvRFRmNktZL3Js?=
 =?utf-8?B?VFdQa09jbkk3K2pLdStPdUgrNzBnMEk1NnM5Q0dPVUFOWGkvRUJPb1FVRTFI?=
 =?utf-8?B?ME1ZY0V2UnpRYk5qN1BFRlc5M3R3aTZ0VjZPMExSQTlZNStpOHVkMDFJZXdG?=
 =?utf-8?B?MWxkaVNPazhmNG1XN1d1OXRYenRDcHFGTFpFV3J6TTdTalNLaFRCSkhGTVJB?=
 =?utf-8?B?V2plU1Y3T0wvUGF0OUlIbWdXc0ZRaWluamloTnp0bWR5cnJMR3lTcU43clQy?=
 =?utf-8?B?dEFidWlOS1JiN3NKL3d3bm1jWXBzTXR5WFBXc3RJbHRmNDJUR2RNczl0YXhr?=
 =?utf-8?B?R1VLS0s0Q3NvYjc3UER1M254UFdkMUVwQzY5eUg3cXBIV0hrMk9MTTNjaVJK?=
 =?utf-8?B?WVhSeGVEdEk0UDNXcWUxZzNFeVdXSUw0QmFteWhtNWQwRHNIRHVSajIyQ2tn?=
 =?utf-8?B?V2RxWC8rNXU1RDkyUDRHSVlyRlZTeGhMTzduWVhiMDZaRDZrOHpxTHBkbXdS?=
 =?utf-8?B?ZlFTRWR1aVFNNlRDU2RYa2VkRGE2cmVWRzkxU1c1bUtGd1hUMHFobTJtWUsy?=
 =?utf-8?B?NmVRRkliWlBtbnpaclBGNzhpdnE5UUxKa05TUTMySFFoVENIbG9TbTMwZ1Z4?=
 =?utf-8?B?QWpLUjJyZHIva3BwZWxBRFFsS2Qzb0ZOTGI3aVljcDQvL0hoQ0NSL09NUEVT?=
 =?utf-8?B?Ri9kdVkzNjQyTEswaWhHNk9kWEZ2MGh2UnRXbm1sY2ZGak5tUXk3QXZHU1hG?=
 =?utf-8?B?Z01xZjRKSXJUdDVEdjYvVTkvMWpaZUZZTGp2VVAyTTFUbEk1VGtzSURONldh?=
 =?utf-8?B?Mk9zc3I5NW85N0tQSGllVm1zRHVpeHk3MkFTclVqNjU5aFVZNGJUYmNlK2Jq?=
 =?utf-8?B?VUs4UFR4dVZOa0dveWs3dWlienZGTGZRVU9zNkM1V0ZGM1RCZ2lMaVBGeTFh?=
 =?utf-8?B?dHh2d0tmb3RDbHkvWm1heGcrMHBXdUMrb2N2U1J0aDRHd0thY1FWbFlYOUhx?=
 =?utf-8?B?ZGRRK2dZU0l1YWQ1ZzBtT3hRVU9NLzA4R3MwQXBIcHFBTkJSWkxjUXNIWGFB?=
 =?utf-8?B?S05Uamg0WmloRXMvWk03RWtBNk1ISlNsTmc2elRQM2dFSmpPcnBRbVpQbGYz?=
 =?utf-8?B?YVRiRDVjSHkvdzUvaEZncjdpVFQvRjBMb1pVOC9qZjR5RkRUZUV1Zm9JaEh6?=
 =?utf-8?B?bEVOc3NoYVFLem9iTU9vVVFuQ3ZZSmNFR2x1RGVSN2FibDBGWWc0eldWSGJm?=
 =?utf-8?B?SjRsRUVwRDFwMmZ3d09WVEYvNm42dkVIdGdPOVgxd1hnVkRUYVQ5RWNvbDBW?=
 =?utf-8?B?MmhmK2xWMW9KOUR0SXUrNTQ5Mm5BNktuYUQ1WkNlQXlLSlppdFNsM0VEWHIx?=
 =?utf-8?B?YjR6RndyNFhwQktLbXJ3NFBhT1plZzVBa3g1SGZRY3B0OWs3WnpEanZKK2Fm?=
 =?utf-8?B?WmNrVHk3QTcyRFBFNEZ2UmEzYTJBSWVhSWVyNWh3czNrMjV4b01tYUJZZGpp?=
 =?utf-8?B?alFjOXpSeWMwWXZUZXp5NzhjSDl6bk5peHZCa3M3RkI5NTJFOFNoRDU2SU1w?=
 =?utf-8?B?bEFZT1o5MjBSZjNLVUJrZDBhV3ljUnJhMVNUNHAvWm9LcjF3N1Z3MGMzMStI?=
 =?utf-8?B?dktsYWZOdU92ZlJiWjBheTlBM0dtN2xDVk1BdVZIMDJZM3AzUENCYUxJNE1k?=
 =?utf-8?B?YkpIcGU0dEMvSko4WE43dXhNdjRvV1JCcU9XRnFjNitBSHJxK0FWR1Ivd01S?=
 =?utf-8?B?b0FiTlUwa1d3SEVkY3VVNmdnNEZpU3JtK21lWDBjWTI4L0pCQXJJWTZXZnNl?=
 =?utf-8?B?TGw4Y1VqMm4wSnA0ZjdEM3ZId0lZSEtDREZrcXI3ZjIyaVZrVzlEd3Fja3Zj?=
 =?utf-8?B?N3haTjFpUkpCWW5WZmpNQzE4c2VJcU1iVnZSMExxTmUwaGNIQnUwL1c0VEZD?=
 =?utf-8?B?YWt5KzV6U0F2dnc4Q1dSMUpkNUc2U1hIK3FIeTFIQmovWnUxZC83NWxVemFx?=
 =?utf-8?B?eEhjVXh5Q2hLRUFCaVhkSG15OEJ5djdlTHpyOW9TeXBiU3Awb2RlQ2EweTc4?=
 =?utf-8?Q?9Uk2ZewPmgoNsyZeBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3dfbaa-e3e1-4012-f15e-08de85bbbe2c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:30:53.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjHRCckMf9/Y+W9E57D/KtutU6OA7gCfZNWnl3TXSzPvzobYubJX6kn2po0TCBZf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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



On 19-Mar-26 11:45 AM, Stanley.Yang wrote:
> Add amdgpu_regs_pcie64 debugfs node to
> read/write 64bit PCIE registers.
> 
> Changed from V1:
> 	Remove pm_runtime_mark_last_busy
> 
> Change-Id: I0deb7a33eb8625f37e6f2435c14338e53b809849

<misc> I think this is no longer used.

> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 112 ++++++++++++++++++++
>   1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 63b702ec972b..3ae37eb98ef9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -617,6 +617,110 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>   	return r;
>   }
>   
> +/**
> + * amdgpu_debugfs_regs_pcie64_read - Read from a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to store read data in
> + * @size: Number of bytes to read
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_read(struct file *f, char __user *buf,
> +                    size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result = 0;
> +	int r;
> +
> +	if (size & 0x7 || *pos & 0x7)
> +		return -EINVAL;
> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	while (size) {
> +		uint64_t value;
> +
> +		value = RREG64_PCIE_EXT(*pos);
> +
> +		r = put_user(value, (uint64_t *)buf);
> +		if (r)
> +			goto out;
> +
> +		result += 8;
> +		buf += 8;
> +		*pos += 8;
> +		size -= 8;
> +	}
> +
> +	r = result;
> +out:
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_debugfs_regs_pcie64_write - Write to a 64-bit PCIE register
> + *
> + * @f: open file handle
> + * @buf: User buffer to write data from
> + * @size: Number of bytes to write
> + * @pos:  Offset to seek to
> + */
> +static ssize_t amdgpu_debugfs_regs_pcie64_write(struct file *f, const char __user *buf,
> +                     size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = file_inode(f)->i_private;
> +	ssize_t result = 0;
> +	int r;
> +
> +	if (size & 0x7 || *pos & 0x7)
> +		return -EINVAL;
> +
> +	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	r = amdgpu_virt_enable_access_debugfs(adev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		return r;
> +	}
> +
> +	while (size) {
> +		uint64_t value;
> +
> +		r = get_user(value, (uint64_t *)buf);
> +		if (r)
> +			goto out;
> +
> +		WREG64_PCIE_EXT(*pos, value);
> +
> +		result += 8;
> +		buf += 8;
> +		*pos += 8;
> +		size -= 8;
> +	}
> +
> +	r = result;
> +out:
> +	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +	amdgpu_virt_disable_access_debugfs(adev);
> +	return r;
> +}
> +
>   /**
>    * amdgpu_debugfs_regs_didt_read - Read from a DIDT register
>    *
> @@ -1525,6 +1629,12 @@ static const struct file_operations amdgpu_debugfs_regs_pcie_fops = {
>   	.write = amdgpu_debugfs_regs_pcie_write,
>   	.llseek = default_llseek
>   };
> +static const struct file_operations amdgpu_debugfs_regs_pcie64_fops = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_debugfs_regs_pcie64_read,
> +	.write = amdgpu_debugfs_regs_pcie64_write,
> +	.llseek = default_llseek
> +};
>   static const struct file_operations amdgpu_debugfs_regs_smc_fops = {
>   	.owner = THIS_MODULE,
>   	.read = amdgpu_debugfs_regs_smc_read,
> @@ -1587,6 +1697,7 @@ static const struct file_operations *debugfs_regs[] = {
>   	&amdgpu_debugfs_gprwave_fops,
>   	&amdgpu_debugfs_regs_didt_fops,
>   	&amdgpu_debugfs_regs_pcie_fops,
> +	&amdgpu_debugfs_regs_pcie64_fops,
>   	&amdgpu_debugfs_regs_smc_fops,
>   	&amdgpu_debugfs_gca_config_fops,
>   	&amdgpu_debugfs_sensors_fops,
> @@ -1604,6 +1715,7 @@ static const char * const debugfs_regs_names[] = {
>   	"amdgpu_gprwave",
>   	"amdgpu_regs_didt",
>   	"amdgpu_regs_pcie",
> +	"amdgpu_regs_pcie64",
>   	"amdgpu_regs_smc",
>   	"amdgpu_gca_config",
>   	"amdgpu_sensors",

