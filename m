Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B0606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FyRgKlq7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B6D10F7E6;
	Tue, 27 Oct 2026 20:21:36 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA0B10E491
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrGugStIumtWr0sz3Fkn3vFS0bgDXaD1NI6bUPQfXMw0nV4jx6X7rmsVcYEhYrpsjPU2JHSGIpzklfz2LTvzmXCW4iFKKTc0/AKFIeAFxFelmVZ9jsccayPliI2ZoWnWeNiDbm8zHlefr57nLesENDGEXGai3Zxb0hMdShkTsiq4QAzF0zj36wps0urNV5Aslw86g+UdQnCmMCIFkkVe8S8yHSk7/J3hRAu6OKahOyfaPR7vGMC8Irt7Pbuh7/KONW0C291MefGsYDyCIRNYTpegIZY8d781EnZ0jUXf708P9YsvXWARE3OehyVqDOqgJqzg0MziIvf3KamROdwBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uBuMhRjzctX2l0cS53WoOK2SFlpKBXKpR0+suFFcxc=;
 b=OTvXD2UZUfzRTq8xKqs+TJ0X9LTn4NYQZfiRIINMCy8z4t9tqbT3XoHVSu2LJ9nXxYEXNsMdDE2DLYBFs3HN7JvUhahxk7NAtPOIMhyoNTVy4x5RX44j/roZTQVURjiDpA4FwoF1YJwbBQqiv9PRXrUD+rIKbWeA/YV9TaTSQFnoUdDhtY8NLrrcvx1BvQeo7QZRAybbAKAfWwybX9IkDeRZedYhCeztghVCHE9GwA8owq/B4IOgKRpeDK2HLRp/XKv7NAnp5PMCUoGCC4dxKVS81DT0SDjsmbLPJF9JB4PFfuX/NIz0osjJSY7GLMPy3fwL1r/ZI0UpdtRVz/nr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uBuMhRjzctX2l0cS53WoOK2SFlpKBXKpR0+suFFcxc=;
 b=FyRgKlq7Nn+LqteLjfzNkqg2bAltXGGohaGCbhdWIofLaarBKQiWImrS3+P7fmCwZNdBdFTSshvAsBSGt96/KgOM/cU7MZ43C3paiAJc60gqbcW4eQpSnMqjxa6s30HelxSKnWIN7EHxOCVHg41EipGy+q4Hqvk268wSczz0QZg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:21:26 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:21:26 +0000
Content-Type: multipart/alternative;
 boundary="------------iaznIMpEksIYE5nsDbb7vIB0"
Message-ID: <a59eb8f6-c346-488c-abeb-3e37ec68f4c8@amd.com>
Date: Tue, 27 Oct 2026 16:21:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu/gmc11: don't access the fault registers
 during GPU reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Lijo.Lazar@amd.com,
 Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-8-Prike.Liang@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261023083422.3049246-8-Prike.Liang@amd.com>
X-ClientProxiedBy: YT4P288CA0076.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::13) To DSVPR12MB449095.namprd12.prod.outlook.com
 (2603:10b6:8:4fe::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB449095:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9c19d8-bab0-41f9-c04c-08df3467e074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|261026121527099003|18002099003|8096899003|11063799006|56012099006|261022075727099003|4143699003|10067099003|261021121427099003|261009223027099003|261022105027099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: polu+dUSr0ZMN0flsK5WFKOKIpIH49pjSr0/8ErJHfvOKosoFft9l5Pxh79tkw2lD1TCg1yNz9kHsCiU8eCRMnNDFjx33WKwhR0Ds7Eg/tV3nJd8dscPByyyQ7zHesvVqMvgAAQHHCi8SQckfMCyHME+R4G6bSDCR6rjHwY5bDvtzqYOhlC+F8BqAZPNvcXNwqXwdVldQK6nhREMn87eH/aY9y6JZnr3LihI8rlfdA9B33dHepAIPI2GiWWKkhk/u4IK+wlqHKbsROKYK0J3eX7O5lCCAAVzx0LE15a0iEov8+/36xyDVp9gu5O8Zf1Jixl9bDDTRsDu3eysVEHxkVYFU1qgS4XOtE31v6saG6B2Vke36h/TuHILVU6SfcpJJnNnermfpq5yXNdlg3LAlPf6izjoh5Z3NLzFzOVK2FoQ/PDcF2GQHWZW9UvMp6ji1ofCsQ9zJ4HZ0Fnxw2STL8HslpdonCwSWe5wjz1Oysb9QjpBS5VgbX+PNyV5BMXsKTp3EMNraLt1qdCfx7GcTKn3cPwOnmexKN4BTadNLD+jm3N0WKP7OptkpXN3ji8I2IubgnpnJ7T2nrxhuAchNr8+cZ+N/2uBC8lVELJWR2pTnH41l6IbhyxMl1D0HOHB//gX7E8zqhCa3Kgcb08/s7jhXwVK4YXgzQvHF44/GXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(261026121527099003)(18002099003)(8096899003)(11063799006)(56012099006)(261022075727099003)(4143699003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026140227099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGYyVXdKU0RxeFlGUzBJMjRDZi83amJMbkJkcHFEb1gwVU1JcWhRSC9OeTN0?=
 =?utf-8?B?c0xKaldMK2Z5UCszWkJORzNndGk0d3BrSEFZVUk1S0c0UlplQTBrdFNNdGtp?=
 =?utf-8?B?S29FVDE0MDY5VHNyMlJhL2NpM2h4aHhqUDFKNVdvS3I2SzFubWVaV2svUUM5?=
 =?utf-8?B?QXU0S3FvZlNlWjZ3d1VGdk1VS3ZWTnBsQlJDZDRFOXFUTEt0Zm10cTZlcXd1?=
 =?utf-8?B?aWpISTloT2oybFRsaXA4SW54OGpEQ3J1R1hRZjZ5RkE3M1YxKy9maFEvbE5k?=
 =?utf-8?B?QkJBZzNpTHJtSmNubVc3SjJZZzdwL095R1BjRjVzcmxTeGdlWmtFNEF5ZHFU?=
 =?utf-8?B?bmJXc3Jkek81b0crVHA2eUJwc1ZNN3ljWG8vdFdvUU9UanVoK2pMc244VnNS?=
 =?utf-8?B?Tlk3aGo4aHM5U3BpZEQ1eDYzY2xjbmtxQ3lPUDhVQXBQMlZBL05jSlpaZHhQ?=
 =?utf-8?B?ekc4TFIzUmVEeC9ya0g4NWl0YW15ZDRQYmVRQU8vOWpUZXRCV3BKYTFCWkVM?=
 =?utf-8?B?bU9YaUphYVpOSTVRSkxnTXZ2QUIzOE5TcDk3M2RpblRvM2g1aVN5RytCdkI1?=
 =?utf-8?B?amZvU1d2aC94MktGemRWZ2dFSnRBTCsxaFFyZEZTMk5sUkJvLzZnUWFMOWRD?=
 =?utf-8?B?Smt3cmJxK1RkejNvdllib2FCVGdhWWtmaXU1UVFhR3AwNkFvVGZDQ3RwUTBw?=
 =?utf-8?B?Y3l5R0w3Y3JBWHVHTlh2azZ1TGovSnhFSHlWSm1yS3NBVnYxTmwveS91K3Qy?=
 =?utf-8?B?RHJLZ2Ntb1hQT3FTQlgxWEVVTTlqdU4yWVlDMFh0MjMxSEd1V3F1ZEhUaUxx?=
 =?utf-8?B?eEQvRWkranUvOGhaYVE1Y0FBenBmYzkwZCtRanNFNlkxUlBBdHpDU3ZqUnBS?=
 =?utf-8?B?a2h6YWgrU2ZCN0VaWlJONFBEVnorVzVWQWxkRk5NeWVlWmRFVERGcEF5NW1r?=
 =?utf-8?B?RElYYjJEZWJCYkV1OUx0M2hJdS9VS3BYTTh0UWdNRFB2L2VMRUlWOUs3Vzd2?=
 =?utf-8?B?UmgxNzF4ZVR2b1VIck9rdmRmUzZJcnJ3bFpHUnRkbm9uZ1lyck5KMnRJOXVX?=
 =?utf-8?B?WjI3ZGpxcytQY0J1NkJZbFZkd3ZUTThHOXJTRDRsdXJacEF1NzhLMWpYRDYz?=
 =?utf-8?B?cWRKL3NQcGdpL2U1cHN3SHpIYVZMZFdTTHBtNXpkeDY2dXBtY1gyeWpCMjcz?=
 =?utf-8?B?UFZTenAveWZUOUFuL0phczlvUSs1VnZnYkNkTzV5NzBGTG9RUWRkTGFiZTU2?=
 =?utf-8?B?UEVPNDU5am0wUjl6SnZMdjd3MjNiTkpBYUhsMFUxUkZURVRZdC9mR3I4V2hZ?=
 =?utf-8?B?UldZbzBSOTJSa2JiZDExblVtWDZzcjJKcjc1b1pvQWJ4dUJHVTUvRXBIc3RJ?=
 =?utf-8?B?MW4xZ3JoQWdzaDlqODBWcFAvb3R0d3Q0NU5rMmQ1b0xoVU9rYm5OR2UvSGwv?=
 =?utf-8?B?bFl3QTErc1E2NmYxNytEclE3bVB3MHZFMWgrRkxsUFZzZ0hOR0YzMWJiOTRR?=
 =?utf-8?B?WWtRcFcrNlNEMy9yT0NLT3ltUDZMUmRKRFF5MjM5S2FXU1greVZjaVJLTUR5?=
 =?utf-8?B?NDEvWUtHRFExaU44Y3pqUzE2UkZFK1VpNDhvT20rcFZkeWtyNEFnMG4vT1Zs?=
 =?utf-8?B?RmJnQVgwWklzQlZWeHFrSTlwSndxREdpOWZSN0tUUFVQWU80OWcwaXJVTCtl?=
 =?utf-8?B?N29xb2RHQjZkeFVhdFVNQWwwb0dxdWZVdGoxK1pjbkZuV0ZHSGdnTzZ2WFA3?=
 =?utf-8?B?S3JENmVOMjBtaFVEMjdBK3ZONnJQMWF5ekFmazhMeDNkZGcwdmxUWVRjUUdN?=
 =?utf-8?B?UmMwNFJpOEU0WERHVEROYmUxQ1RWNUNIVjhSK2N1cUp6SDJWbXVKalVFMGxZ?=
 =?utf-8?B?Z3VuWjEveXBUTkR2eTZsZG5ETXlYZThDWXA1TnFZUXRFWXZUVWwwZFB4Tmwy?=
 =?utf-8?B?UXRFck9VbnNMVUZYM213cFc5cmg1UjFIMklRMVBKZlBLdWxWWXgvVDFjM2VD?=
 =?utf-8?B?dVFCdy9TQ1pmbllqdDZqRVdrOUhieUhHOFVXbFc1M3FsdU9EUHJyRjhFTDR4?=
 =?utf-8?B?VGVDRWhXQUxRMXBrRU54VWhBT2hKdENVRDdnbkZPYlhnbW1IZ2hCanQ0QVNt?=
 =?utf-8?B?WTVVaTZvd2RXbXN3QmIrNnVvZHhHM0lVdEZwNzB5cEZSdlBPejZWbFRLazJS?=
 =?utf-8?B?UythMlJPTUgzeHR1bittTE9IeW0yUnE1TjhkYW5VTGE1eW5XUlRDU3ZtaHdi?=
 =?utf-8?B?MW41Q2ozTmtQVXRVdlIyYnJuaFJQQ1BzVnRBaVVISWFlNGFZZlZ5NXJwUWhJ?=
 =?utf-8?B?Wkc5WGNKRFVMSHVXVSs4ZE04OCtnWDA4NGUzZEFOTWxaeHFqN2VJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c19d8-bab0-41f9-c04c-08df3467e074
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:21:26.2810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHpo8mOIDKX6hoKDjJX6460ka4OHLNEOCvEq/OVJu6JiU8wILFkNaH6E40rZOg5CsDixW5AE22DVNBEMH6e6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------iaznIMpEksIYE5nsDbb7vIB0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Preventing register access during a GPU reset via |down_read_trylock()| within the |in_task()| is a  clean  way to avoid the hardware access warnings.

Reviewed-by: vitaly.prosyak@amd.com

On 2026-10-23 04:34, Prike Liang wrote:
> IH1 and IH2 are processed from a work item, so a VM fault delivered
> there can read and write the VM L2 fault registers while a GPU reset is
> running:
>
>   WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>   Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
>   Call Trace:
>    amdgpu_device_rreg+0x21/0x50 [amdgpu]
>    gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
>    amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
>    amdgpu_ih_process+0x70/0x190 [amdgpu]
>    amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]
>
> Trylock reset_domain->sem around the register access when running in
> task context instead, and only print the fault when that fails. The
> semaphore is held just for the register access, so the reset never
> waits for the fault handling. The hard IRQ path for IH0 is unchanged,
> the IH is disabled before the ASIC reset.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 709c3d1b9998..bc3b1ffb5488 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
>  	bool write_fault = !!(entry->src_data[1] &
>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
> +	bool read_status = !amdgpu_sriov_vf(adev);
>  	uint32_t status = 0;
>  	uint32_t cam_index;
>  	u64 addr;
> @@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  			return 1;
>  	}
>  
> -	if (!amdgpu_sriov_vf(adev)) {
> +	/*
> +	 * IH1/IH2 are processed from a work item, don't touch the registers
> +	 * while a GPU reset is running there.
> +	 */
> +	if (read_status && in_task() &&
> +	    !down_read_trylock(&adev->reset_domain->sem))
> +		read_status = false;
> +
> +	if (read_status) {
>  		/*
>  		 * Issue a dummy read to wait for the status register to
>  		 * be updated to avoid reading an incorrect value due to
> @@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  		status = RREG32(hub->vm_l2_pro_fault_status);
>  		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>  
> +		if (in_task())
> +			up_read(&adev->reset_domain->sem);
> +
>  		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>  					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
>  	}
--------------iaznIMpEksIYE5nsDbb7vIB0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Preventing register access during a GPU reset via <code dir="ltr" class="KDcb0c" data-sfc-root="c" data-complete="true" style="font-family: monospace; font-size: 14px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0.716667px solid rgb(240, 242, 245);" data-sae="">down_read_trylock()</code> within the&nbsp;<code dir="ltr" class="KDcb0c" data-sfc-root="c" data-complete="true" style="font-family: monospace; font-size: 14px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0.716667px solid rgb(240, 242, 245);" data-sae="">in_task()</code> is a&nbsp; clean&nbsp; way to avoid the
      hardware access warnings.</p>
    <p>Reviewed-by: <a class="moz-txt-link-abbreviated" href="mailto:vitaly.prosyak@amd.com">vitaly.prosyak@amd.com</a></p>
    <div class="moz-cite-prefix">On 2026-10-23 04:34, Prike Liang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261023083422.3049246-8-Prike.Liang@amd.com">
      <pre wrap="" class="moz-quote-pre">IH1 and IH2 are processed from a work item, so a VM fault delivered
there can read and write the VM L2 fault registers while a GPU reset is
running:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
  Call Trace:
   amdgpu_device_rreg+0x21/0x50 [amdgpu]
   gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
   amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
   amdgpu_ih_process+0x70/0x190 [amdgpu]
   amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]

Trylock reset_domain-&gt;sem around the register access when running in
task context instead, and only print the fault when that fails. The
semaphore is held just for the register access, so the reset never
waits for the fault handling. The hard IRQ path for IH0 is unchanged,
the IH is disabled before the ASIC reset.

Signed-off-by: Prike Liang <a class="moz-txt-link-rfc2396E" href="mailto:Prike.Liang@amd.com">&lt;Prike.Liang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 709c3d1b9998..bc3b1ffb5488 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
 	bool write_fault = !!(entry-&gt;src_data[1] &amp;
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
+	bool read_status = !amdgpu_sriov_vf(adev);
 	uint32_t status = 0;
 	uint32_t cam_index;
 	u64 addr;
@@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 			return 1;
 	}
 
-	if (!amdgpu_sriov_vf(adev)) {
+	/*
+	 * IH1/IH2 are processed from a work item, don't touch the registers
+	 * while a GPU reset is running there.
+	 */
+	if (read_status &amp;&amp; in_task() &amp;&amp;
+	    !down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
+		read_status = false;
+
+	if (read_status) {
 		/*
 		 * Issue a dummy read to wait for the status register to
 		 * be updated to avoid reading an incorrect value due to
@@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		status = RREG32(hub-&gt;vm_l2_pro_fault_status);
 		WREG32_P(hub-&gt;vm_l2_pro_fault_cntl, 1, ~1);
 
+		if (in_task())
+			up_read(&amp;adev-&gt;reset_domain-&gt;sem);
+
 		amdgpu_vm_update_fault_cache(adev, entry-&gt;pasid, addr, status,
 					     entry-&gt;vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
 	}
</pre>
    </blockquote>
  </body>
</html>

--------------iaznIMpEksIYE5nsDbb7vIB0--
