Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59721073CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36610E4FC;
	Wed,  8 Apr 2026 13:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O+499pQz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC1710E4FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbtYek2Taw9qIuf56cNNBlYIZZZ3tqgsOBa+6clvyquP9gqlUWuBGrISVFm/CR9cxC48Wf0c8oc8Spm48MQAVVMqSjJvw2Clp8ii5P+fdA21i5cvn3+Ia7UOtR0Ufcn9gxEzyIrbSXm6oTm3YydU4p1KvwN+FiKuJn446qQfCFZJqPXV/b4VE0pgsnZM5sSAV//83z2FaRFtPqqdgFFmPeRdb4Si2mwqP/q5/27TthUkuNtspM2RUNOaZEAUrya8gZuKVIRUypCdHGY+FY+uOXz7jSN6iHdY7p2D+U/EHC22uN5O8Ralm70Reiwg4Eh6iC0ofjYhDgleg0cHcD1FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw78FL7qKj9mmK1Zv14u49yqoCpvemHka8e8dKfkW10=;
 b=mcg/g/ddG0F3oz4l+xGKewNRyM16tOgSqC7N2Qe9CEID4lHQnduVHleZnSnoh8FOXfUw5Luu6TwJ3s5JCdKGvF0rS8j/nbjWLfyKvplOtWE6pX86w/t36KTYGFMjQeH2wr+C2LK1pc4NWwNlS/CFZtPY2dLoicOn9vIgwQ/Af7kf0L8Dh9zzOhaVd0xaaEYmwS/B7OVq4oqkTn3l08MxuFxsDPWKccBYdn/9Oyo14fWxtF4Ae4ezn9wBasbhK8Fc7o8kmEJFIaz56GWZhbbkKnLUJtAIKigddd3SoNhZNnrFWBqVmhgIh9vyN5BT5RgFhorsRNG2qiqDiIRDzaXQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw78FL7qKj9mmK1Zv14u49yqoCpvemHka8e8dKfkW10=;
 b=O+499pQzc6rLtcXcmi8HakNwPzuayb+bmlFlD9m6ioVnn6Xr+0UwJomvGDiOjuxnXfX5JxlYKghTs84Z+lZ/GReAQQ9zf8w1eMF5yrxvW+qw6Gf0SccETffT87dAvb5RkIoUYMNbBSzch+7RAQGIt2G8+aNoDuBm1bUuaVmRIwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:45:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:45:41 +0000
Message-ID: <48935599-2ce8-4686-9e9f-8c47e1425e9e@amd.com>
Date: Wed, 8 Apr 2026 15:45:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v7]] drm/amdgpu: gate VM CPU HDP flush on reset lock
To: Chenglei Xie <Chenglei.Xie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Felix.Kuehling@amd.com, Alexander.Deucher@amd.com,
 jeffrey.chan@amd.com, zhigang.luo@amd.com, Harish.Kasiviswanathan@amd.com,
 Victor.Zhao@amd.com, David.YatSin@amd.com, Lokesh.Dhinakararam@amd.com
References: <20260408134414.459833-1-Chenglei.Xie@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408134414.459833-1-Chenglei.Xie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: a307a588-51f8-435f-806e-08de95751f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ELtPzw2bQ6QPFEKl/8KQl82WP9Sg66YrqQT5oZ71LAAU+TpQiJcPB+kP0BhilmqPtErwKpbwRl3rhOHuTAsVGz9r/QeSOIP2kcgP8cc9hJ1eWfoWtBmFfhkh6KUqdkFBXI6/PKIEshMWpsW1bK+VfYMKJR3YnLKLSw0+ikJH0UAj7pRv17IcwA3WhBPQ/KxDeY7uThQ8rrLogScqADAV4BBAtrAB/zpnSKB5EhanNt8oeuxi0PP+PelsBoLSwEqCbiHkGfO35JMqiLiWwzb6BQI5qVNF1twzDgaIRGQ+IOYeWC5vEfmmsYu8cMK/DX9/FQAZLzJFz77yXJf4BiF8Z2x5IcDAVDVAgjpfNTLbPK+ynrk0jQqRRfxILnG5V2mZ3k2up8La9wCEnDyXDn95iQ9hLnA6QBQLoS3LEjfoTfA+l4nu8RufvG5tEWEHnY9urJMWrAgAfce9VzexDHDmEJdDJ3iwkAavNl1FG5WtRcSywCy95TXGkhDACKcS2kGZt6JZIkPH/Bt6b/oLlHsy3n/1bRvv6GmhbarbUUmFvcXQKfM6nIDsu/GbWmMWTydvA8Y0igT8Z2jjRGMGV+7ACWdYmb2+e6M/86c7i7ZrYta4u2nChsZnEpZlRTl5QRcPPhFzcpuSpE05jyVEGpt2i4bSpLE1lwETOI8oha+dfEMNmC9Hib8j+NjE1kaQphIxg9HApkBGyjao4RD8S3Tj28A1g7PUoZaLZLa/7TUaXR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndKQ3l6UGI1dmFuRVQ2MURWamtTc3RyQmlnaWlaS3VuZ3NMT213WmN5bDlU?=
 =?utf-8?B?Y2RyMmo0NDg1MHVWQmdqYUhTdFdSandpSmx2NWJEZVhpakNkREhSSW14TUNx?=
 =?utf-8?B?V01kUWt6ampEZVgvaHZqaXkyQjJDREdlK1pQUmpQc0pCUk8wODlwQ1Fhb2dk?=
 =?utf-8?B?T1BpcEJ6MlkxVUtzZlFaTzAxSElicVJuZ3M4Z2ZlenQ1elNFV3RDendIUStK?=
 =?utf-8?B?NjArRUpydGwxVUl2dHdoSTRtbENqcitFR0xpR0JEVVYwSjNKNy8yQ0l6TWl2?=
 =?utf-8?B?TnVnMHZiS3ZsYXN3UkdpTGhWbmZaYWZDUGFlUDN4TlVLRk1TaVl1Z3VjVTdB?=
 =?utf-8?B?NU92WWs2bG81NkVDTWpuL25HdSs5bzFubWhzU0NYZUdXV2lhMG1wZUM1ai9q?=
 =?utf-8?B?SnRzN0RlQ1hSK1BUMHYxNEk5WVc4YjlVNmpVeXpwTzlSZ1locmNvQUZCV3RP?=
 =?utf-8?B?ZHpBblhkZzlvL2hOL1RsNFRPemY4UElhOE9PeFZwaXI0QitGc0E3c1FYMGkz?=
 =?utf-8?B?dkh1TVI0NTNlYk92VlY0MkFYMlNqSjhsb2laRW5tV2hWdURwMXYxYUhzaE1q?=
 =?utf-8?B?aFhrbkRmTUtwU2JMUkk0SlZFMmNjSXZ4aXdnbnBPb3NBYnJ5NU1ydWVHbGox?=
 =?utf-8?B?bFNRcUdWU2xJK1V2RUtUQlozZkVEdVRtZ3lKOEQ3TTYxUUdjejZWUnloWWtS?=
 =?utf-8?B?WEQ0bklDQ09ySEs0RExFMTVTb3BwdUI0ZWVzUHRBK2NFeU1Fb3V2Y1ZVRWk4?=
 =?utf-8?B?WUpyelVwaDJMa1huYmVyTnVPWU9XMFArR0tLL3hFbEFQYWhPZXVISmdmQTMw?=
 =?utf-8?B?ZGI3SVB3a0d2L1dPbnRicXFPUlFLTGVqM0p3bExYU21DSU5PU1AwN21LM1NQ?=
 =?utf-8?B?bE94N3p3UGcwZ2lWOXNkQmcrSndsRE1HRURnUlI0RmxNdmZIU0xjNHJ0RkpS?=
 =?utf-8?B?TWVLRXFkeW5DeE9WRksrM2ZxZDBMM0Z0U3R0cGQyWVB4SUxZZjZabEJuZHJJ?=
 =?utf-8?B?RzFRWVZzVFViaTNmalIvRkV4SldLMUpRVERsbWZhSDRiOVcrTWZ6dFpLYUEr?=
 =?utf-8?B?WENVaExWaDlEMGVTakxGemJqc3VoQWU5U2pEc09ZMmZQV0JyTmRHOHRuNC8w?=
 =?utf-8?B?aEFIbHRjK1R4NGUzS0FKbG9LZytabk8wUlhGdVMvMVJ4T1lFZUtJSkhiOUJ6?=
 =?utf-8?B?Q3RIc05vNnBFMDJ1eUdqckZ5aGxtQVc4UFdVNlhSRjhTeHVkSjBDemgvUS9a?=
 =?utf-8?B?b0hpNUo2UUZkV0VRNEhicjd2cE5sV2owNDIxc3M2N3RON0srZEZING4reURj?=
 =?utf-8?B?Y3ZPMHhrMnM1YTRuQ0NmNWVxMm5uRHZqek1Td0VXQkNleTM4aUJDbW0wK1pl?=
 =?utf-8?B?SU8vVG1WWW05REFqenhNcnNGREFqVVk2Y1cxL1NibFZtazRCR3dnZ1QyendT?=
 =?utf-8?B?RlhmV1VPQ0NGYmd3ZXhjSkJid3hRYjhlQmlKSmhsNUNaNVIzMllZUlZJWGhF?=
 =?utf-8?B?Q1hkbWRITUlSYjNlRkJad09WM1RGeERqNzAwYVR5dXZqWjUxTDBLM2xRV2ds?=
 =?utf-8?B?UkNiUEdPL3JTMC9qTzRCektzWjVFMGxKaEh3L0tONmxGLzUwQVE2MFRCK2ow?=
 =?utf-8?B?UjJWZjF2QU1wVkNBNEx2TGE3N1BENGVzQk1NbUd0dzFXKzZ6dTJaVHJldExt?=
 =?utf-8?B?Z28zN2JVQi9pV1JrKzJJOGxPNUcwVEozT0VobTUwNE9Xd3BMMkpwMWJLd2hS?=
 =?utf-8?B?V2dQMmcxWnZKR2RIRnRiNzkzR3ZyWFA2NTFwUExhSFoyRDZWSTVrS1o5b0M0?=
 =?utf-8?B?Y3BudVY3U3FRb2FvQ2FiMWI1OXZSZWRQU2lkRU1NWmxkWGdtbjJ0czQ2UDlw?=
 =?utf-8?B?bHpHdHNUMDVrR2Q1ZmswbG1nQ3FaaU1FL0VPa1FjUWZ6QlBtTDNPWHpIQ1ZE?=
 =?utf-8?B?NlBwZWVNd3hUWDU5QkR5V09QVFFlUlk3QkFhUmJhWDM3QmZoUHhjQWtWS0pB?=
 =?utf-8?B?TURyTldTbktFUkVmZ3gwSmwrRElDQU02ZEFFdjRURGN6RFgwVVZtUmpmV2Nz?=
 =?utf-8?B?SElWNURXb1pCcEZUS0wrdEVLcmZhQTljdThKb3p6YXRyTkJHMmdOL2ZiQThV?=
 =?utf-8?B?bi9IZFBxM3IrV0NDLzNqSlFxTnNobW9QajVvTFRWZmdER2VIbWhiTUFZRTlN?=
 =?utf-8?B?ZU5yL2VQSmppYzBUOE9UQzYvUFppS3p2RUc4WDVZTEx0cG5CbnlvaFJrRmRN?=
 =?utf-8?B?d2JrVXkxdmZtZkV1ZkRIY2tOS1Frcm1tU3FKK3ZQSHJzTWI1cExGc2RQdDh6?=
 =?utf-8?Q?XLs8uMuWUpzCWcr5k5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a307a588-51f8-435f-806e-08de95751f8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:45:40.9285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhq5PcOLmZJbWt1v9ftaYxFOhuf4nCXO+3t65fXED9DYTgV16Q9wdvilngz13VX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

On 4/8/26 15:44, Chenglei Xie wrote:
> During GPU reset, the application could still run CPU page table updates. Each commit called
> amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
> That can advance sync_seq while the GPU is being reset,
> leaving fence writeback out of sync and causing amdgpu_fence_emit_polling()
> to time out on later KIQ use.
> 
> Fix:
> amdgpu_vm_cpu_commit():
>   Reset will flush HDP anyway, the HDP flush in amdgpu_vm_cpu_commit() can be skipped
>   when a reset is ongoging.
>   Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
>   If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
>   access (including KIQ) runs during reset; state is re-established after reset.
> 
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
> Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 22e2e5b473415..f078db3fef79e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -21,6 +21,8 @@
>   */
>  
>  #include "amdgpu_vm.h"
> +#include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_object.h"
>  #include "amdgpu_trace.h"
>  
> @@ -108,11 +110,19 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
>  static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>  				struct dma_fence **fence)
>  {
> +	struct amdgpu_device *adev = p->adev;
> +
>  	if (p->needs_flush)
>  		atomic64_inc(&p->vm->tlb_seq);
>  
>  	mb();
> -	amdgpu_device_flush_hdp(p->adev, NULL);
> +	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return 0;
> +
> +	amdgpu_device_flush_hdp(adev, NULL);
> +	up_read(&adev->reset_domain->sem);
> +
>  	return 0;
>  }
>  

