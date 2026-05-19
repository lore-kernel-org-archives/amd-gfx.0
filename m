Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF0CD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610FF10EB6A;
	Tue, 19 May 2026 08:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CipY17/j";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3B110EB6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lR/KlkBRbPOzrzTrCDFicq1AWrTWk6LyRfo1bWtdCzhpGodAlTXzgqAuICAaAcRe3hOOYFHnmMj7jbNbADw39DoNpqvVnDr4NcJS2dnee0KDsmhGln4CP7sziDjhXJszX6arIZTuNHPaeyQG46lBmQJeyUnYf333X+adawyR0ZFXizHlp2pZFUi3le/q1B474nWmiYIZmQYKf+U/jV177cLxmafB3NvnAat3AGwARFoQ55Fnk8+N3AIdJWRu3nhBnQk4trN12E1f/iwsbxmZNY3qbbuUKvwbNf863WNIqnoHFp68kzlk93kY6ZvecTGa8UOSe61Q1b9+hKHHuq8ZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XZA1oSjxFDnpQndAVGhIVdQXAJuGZbNkZV9TbmOV6s=;
 b=OW9D2sOvpVVekltIG7TJj2tbtFAvQIl747ZQBR2u/psJcgkE6XYR42W80PZLgZOAnnXDzgjnPKZEK5GN5tPdK7/Nlkokzk+5DF7Y0zHzvVCLt0FrI0XOhmMeqYjsHa2y4fgjyGXVV1GlOFtodY+SIJJ5IuFkVl21uWVoyXokmlWYXiQE8M84N7NcNFEGT4iHP3tPHDXRUBxXMOG996/pjdbqARdlk4henIRftlM2YSb5o/g/ckJJdhlXEsjKwqip25np1kNPgk4BtjgxqNBsvYDMiRds6g1z2WLfEhHOsxWw0QGfJhCUxq8NjouTtEQp/DRSW/CEczatkGnX6O790w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XZA1oSjxFDnpQndAVGhIVdQXAJuGZbNkZV9TbmOV6s=;
 b=CipY17/jz72YHytZHgh3eSuLsLx/zY/9GOoVbHuMShlqi6iGA69SXux3caK8EtpMU5QR86WPswlF5Xp2JOl9LPdQU4xUKEDWmWcurSG3/TttO267iTKZ0VAkmISG4eFvf3KNjHlCzGwvccpxR5B2frOH4xkWXu4vl4+ta8CDV2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 08:56:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 08:56:14 +0000
Message-ID: <4cd8a28b-ecae-4fa0-a61a-77af8ef5cec1@amd.com>
Date: Tue, 19 May 2026 10:56:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD
 4.x and older
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519082204.60811-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: cb652d7d-ed42-4d88-a77e-08deb5847b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: N7943NxHMV2Kf/AlqNbxepp8S0vP+ZMw08RJOXPhEtALtkGjw2QtCndb1s7Msgq4MNE8USDscxJAmRKYBlqyqLGzbt0/owlt+YWNkGuLjBqXiQh3adgyZPjl1+4J5QEDGWk+mM5PRCG3f6HkJF0JV0qFwk5GN3gIRKQ1Pi/VUy6Kd+67Y7vD2hqz/D30XRkuXg8tBUiD/fsU4dLU4F7PyLKFMVpkvwss/FGFTqx+VYtpd2B+izT5kuWLg4D5jQtFYY2AewuqqrJfgs1/x0L6HwOSEN7O7g58EKEMlMuYyH7sWWpDeoVaWUPw9gDmH9iD8ZxaToDqDSSB7B8oRxCakbVWp74fJELiWFIBxwdKu09glYJcjw5LBS24A7p3OwAhe25ITmwVPu2MWAwAQ0pGyZu2WJ64I9MtEJpcHtkZ68XYomRO9b9ZfSDvxUfhz2QMDJ0NKiKwup2sLEt+wQZ1Nv+y3+MwJx1Tf+Hai8eDUhkAm9+4Eu7DvR05ojk8cBxYHsY2yETyGWR4uJaaUk5DpK/kJfjTrwOCF5EQ5c/ZlgxiwcIXQnranR2UuVvZMPO+JvLMIC1IUX/RE9vmZATU9CyPqOOy3CqizPXwe4823QmYn4i6MQMZOr8cXDOM0zOFZvHLr6xwYVXmzxqZyfpljhrpOpTIsPfjo5+FXcBaHmQ7+wupa8kw62Xuj2cBjHlB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXR1MUFBaGJaWC9lcFQ3QWhQMkxnSFBab3JERXRVYWZmUTNHalcxQkllY0lY?=
 =?utf-8?B?TDNmM0N0OFBwelU1ZUkyNkhYYWlISVJZRGliVjN2Q1g0STlIU1ZJVDRrNlZN?=
 =?utf-8?B?bHNhc2pabGhoWVRRSU5tR1BOUzVPU0VYcStDZnlHVDg2TzJVdmE3VlRyRDRO?=
 =?utf-8?B?SmJieVJ2Ymk3L0lnUFBiVU5NMTY2eUw4dDFkdGllQUg5QzhBYnBReHBnbFRy?=
 =?utf-8?B?b21BeGpSYUtpVXEyTGJOZ0xBeGhoNUgzMnVFL2JCMlEyTk5TbGR4NDVSVG9t?=
 =?utf-8?B?K1RVbjV6c3NVSm9OQk9BK2dTVlUrUDdzUXUyYlVDU29oNzFjeDlrMnU5Vk5I?=
 =?utf-8?B?NXRXQmdoYkJWTkJkQ1BDcmxYeW5SaWdtUVNKRDNWQzJ6eGRlSSt6MUlIR2NC?=
 =?utf-8?B?U1B0MlR4WGIwT3dDQUNPZWNEbFBmVDVvdXdmM200YWFNdktQOVFhcFQxdHp4?=
 =?utf-8?B?S296M2xCYmdaVXZrbytQeURvQjZxZSs5ckt6RGxMNWNhNEJnMkVvQzZXSmJW?=
 =?utf-8?B?aTN5cUoyZzVGM3dtSGxrekdHM1NCakRCakhaWVhISlNkQzlIeHA5VnlOcFBr?=
 =?utf-8?B?SE9tUndDNnFudDZnS2FJS2JUTU1zNkE0VGtrUG1zMG5XbWhUQldpRnZoZVhS?=
 =?utf-8?B?ZGVtUnd0bFJGZ3dickVtMXlGOFFGejVFekYvQTdFangxREZKSzFuVmNOelhr?=
 =?utf-8?B?b2tOMXY0eHRTR09jTUV5SFo4T1FFczAwMkVORkNqRjdTUWZRWVYrQ0pWTHVG?=
 =?utf-8?B?LzNiZnN1ZXkra1IzZTl5a3N4M1Q0YVBDbFArZ1JycnhWQmd2UzQ0emxCek9h?=
 =?utf-8?B?ckRVYzdGcUkvTElXckJ2NjNKWjJqZWRlSWF0KzhtNzZiNWVBUWg5SHdjZ1Bv?=
 =?utf-8?B?c1F0OTdEV3FRRG81cThoUHBLdGJ6WVRGYTN5MkNzcnpGbzlpN2hJUU5YeDZC?=
 =?utf-8?B?UDcrZm9zcHV4bmJIK0V1ZG9WZVJYeFZkY2cxRExUakk5alRKMnRBazR0aUxx?=
 =?utf-8?B?Um1CYkp2L0swMGZvQkIvNDBWMFR5eHJhNmgvMDZRNlovM1Y0ODBHaFRwNG8w?=
 =?utf-8?B?dHBualJNWDcrb1gxZllST2tpaEtqWUdvaU95WkllRFhCTGx4RHF2NUlzOU1y?=
 =?utf-8?B?c1JXa29mdFdiRXFOQ1o5T3hyak95a3JUYk51SnJCbENPMEw1VjdWLzNSeHFr?=
 =?utf-8?B?akxpb2t1bWg5V004L3RRQmJIeXJYS1Y5aGwvVThPdUdwOGpsZkcwSUNqWlBF?=
 =?utf-8?B?RHFCeWFjUEl0cWpmdUhIcGdaRWE2bU8yTmRnOXFOWkIwekJJV1o1UFhOOEdp?=
 =?utf-8?B?UUZhdXZ5V01NNm1nQ2FiZFpWZThsaUhYWlRUMmdZK0psRFE4c3F6eTJXWVM0?=
 =?utf-8?B?RDRZNW8xRWF5ZWFIQWttQ1ArRzlvVVRpTUswTk5TQlEyRThTY3RnaUNvdmg4?=
 =?utf-8?B?amV3WXlHS1VSWEJzOXJvaG91bWVMTEUzUlpPOE1ib3NhbHdxV2RBeGJ6MFZl?=
 =?utf-8?B?VXZXVEpGUFZXeUNTQ2lQdFg1OU9mb3pXS0pQSVdFY2txdGtHQVpnVVVoUUt5?=
 =?utf-8?B?aG0wbVFoWWxTNTJQd3lRVExyU1VQSkdjVDZ6VnFjSmFHQXBzY1FHV29xT0Vy?=
 =?utf-8?B?MDhVVkZiM1Z4bkp2dEt3ZTl1VUZFYTFpbkVRWFZvTGRSckpJVnpjSXlqUlFq?=
 =?utf-8?B?czlESHo5SmFZSlArUUFScUFSZmNJWHUrRGVyWDUwbzBIb3RZTU9XN2g5OTI4?=
 =?utf-8?B?cG9uTXhGa2hNdmdCMlRHRWMydkx1OGRvZUhONU53VStqcTJnV2tLSXpyd0VT?=
 =?utf-8?B?WGJrUWV6ZzZveU5oTEQ2WXRzWURFT0U5ajFuTHhoYWhvUFM3QWV4amZtdStq?=
 =?utf-8?B?NzJIQlcvV2x1bGt3SW1IMFVXZDJidVFLR1RHM0JHNEI1L2RCdGd0VlBmSmZk?=
 =?utf-8?B?cjJyT0ZJcDlnaXU0cGY3TkxCV2dmazhaK1ZNbU5pcVR2SmM5U2VnVEZDZ25H?=
 =?utf-8?B?SkVYTXpsMzhGQkpKVUw0WXZ6S1VQQjhPaVVPWU40M2gveWljOTBtZXZPN3Bi?=
 =?utf-8?B?TXhwcWlWeWJzY1RYMlB5Q0ZpQ0hnU1dxa0JTN3NLSENoNFJCMEI0VER2cnFu?=
 =?utf-8?B?OU1RNmxzcWpzVDdKdVMva0FNQ2JydkE2ZkEzcnd6MFg2TmlEaG82QmRtQlZa?=
 =?utf-8?B?L2tXOFNNNFprcmtrcTJYOUJhZEJDdXZ4SGVYMnZCK1N5Wm52QzRCTUtKdHYv?=
 =?utf-8?B?Zmd1d3Zuc1g4bFZtYmhNQUIyS1RuQ2tSRWZQZlc4eHBtTjZ3VFJTc2NjM1BJ?=
 =?utf-8?Q?HrDGk6VdFQjCeIgAOg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb652d7d-ed42-4d88-a77e-08deb5847b37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:56:14.2792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXC5Z6WFVfog86+Z9PKK/mS0+lTh824LLbQ/1H5jdKn2FHhy4hM4ZqITS5QcHccG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

On 5/19/26 10:22, Timur Kristóf wrote:
> These UVD versions don't fully support GPUVM and are only
> validated to work when their VCPU BO is placed in VRAM.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 3a3bc0d370fa..1e59ca924abe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -188,6 +188,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  	const struct common_firmware_header *hdr;
>  	unsigned int family_id;
>  	int i, j, r;
> +	u32 vcpu_bo_domain;
>  
>  	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
>  
> @@ -319,12 +320,20 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
>  		bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>  
> +	/* UVD 5.0 and newer HW can use 64 bit addressing. */
> +	adev->uvd.address_64_bit =
> +		!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0);
> +
> +	vcpu_bo_domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	if (adev->uvd.address_64_bit)
> +		vcpu_bo_domain |= AMDGPU_GEM_DOMAIN_GTT;
> +
>  	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
>  		if (adev->uvd.harvest_config & (1 << j))
>  			continue;
> +
>  		r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> -					    AMDGPU_GEM_DOMAIN_VRAM |
> -					    AMDGPU_GEM_DOMAIN_GTT,
> +					    vcpu_bo_domain,
>  					    &adev->uvd.inst[j].vcpu_bo,
>  					    &adev->uvd.inst[j].gpu_addr,
>  					    &adev->uvd.inst[j].cpu_addr);
> @@ -339,10 +348,6 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>  		adev->uvd.filp[i] = NULL;
>  	}
>  
> -	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
> -	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
> -		adev->uvd.address_64_bit = true;
> -
>  	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
>  	if (r)
>  		return r;

