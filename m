Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF19F588C6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0589910E666;
	Mon, 20 Apr 2026 13:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pU4QFf4H";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B1C10E676
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 13:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtMFOUeMMtg6jXE1Rcbk4PN8W1Ng9GtxmL6CL/67T1hE0dgPJu4UjdGUFuSAg7m8rqUM3V6Pvy0txlmsw820oSjGufWy885VZB/uEe1OTGC7stdna+HjQNHwuond/idRrhmOCddQnBvDou1R9S3jBaokyePQQCf3g1fvfZJRGLFSmNxuuteUix+CYmiHdKNCKJM4zD9/x422Ho91Pqpz8nGuNgmOCOTBJuAc9OGLWZxxaJGcKaT1hvo2VOhDOrGNF4p+Uxh8F43bNFBsq9jbeRXPG4y7T55UQeOZI10ktUGJgEf2w37I8OGupioyqT/JyY+i7qXiRiPY9o3iq3f42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBGZ/QumieLtL6ZQ3gP6YcNCTkz+dHi+Zns9hvzm65M=;
 b=BR0SAYbhx4nPLQVC+VTWKkDklWHWLTYeh5RZMM9jRo7SWYv2x567faibwmFTJZf3JtFgmt0pJ65ljwX0Xd0WaDmcP5+SUM3oXPRDFPcoeeFtQHeTxbN9EjKgGwYf/hkwefSpJREhv6OZmJ4+SrxoAlOAbBMliZEUQK/qpFI8pXHVD+6rupNxZpk8Dve28dLNlclKXBUH7UVo8x3mvb/y+LmVruPWMhPery1g2eTWszLqbBkE/2xrE52uGS9LCI98TqdsTxBUi0tVViKb1XUOM8csuRtaYhrtlIGe0/nCwDEtQfxygpGw8eLhEeudWCw6wN5PC2v8jc0xK/o29UrsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBGZ/QumieLtL6ZQ3gP6YcNCTkz+dHi+Zns9hvzm65M=;
 b=pU4QFf4HesGj7vJomE56olwalUY9cuZnYnpPwZDUhYk4/W75sq4nRzAyRPreYK/wqbaBAeQv271ZQxT6TcTYIpcb0pMzFfAuanEpf5xIn13Ix8a7dqzLlTByZCCg4q3vAWOgJozpxPtNlIXVdQMISXIDxMNnySms36loCf79als=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:52:11 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 13:52:11 +0000
Message-ID: <33cb52f5-14b3-44a5-b075-db6cd3ce4547@amd.com>
Date: Mon, 20 Apr 2026 15:52:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu/vce: Align VCPU BO to nearest power of two
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-3-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: f5211f3d-010d-460a-0de8-08de9ee40533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 3McfPEn0W+9lL75j3+OJcSn12FDRm4ibWI9OsfLEUKh8yG62yQP3NFks4sk/2lBLaK/zOY8Y0KjKrKfrYphxZSjU1Rei27gmxsAfGYqZTZ18mnx/Mxcxex12uY/YOBC5mL7FoSdIBHKOVPNHTNuPFIwUtFGqiiP2VHoOtVvKSO3TLXtqYVpUsmsFidvAHwlvvmANZNnOMFE+geChh3BHnj9mSfffR0TlhtzHsohJNfnyus+NkrQgPjNcE6jOrg2NL+BhpSg0oPkYqAel1HYnDeRZK24SxFiqdukfPtnhO9SCvNd3AkwSqiEE7M1n53gnc1bUNU8dzVhM7bezBmdzSGcvJIAk5RYumxETA9TC6p4kwb2UjYTpmckkuVpJRqWdqjfc9CVclNNoI1HktxyeCd6nPzT35p1SiabjvjV9ODsX9lHaBXY3y17CItNUYmn+BUOGcdzIhpaL+Yxa+6AEBOLPLTHGOOQ9Qe9pCk2b6Xt5jypWN8qX29zFZhEm0t1CjYdzjTLwUKg1rOqisgbrXWAqqvJNcxN3pQF47I5P6sX0GX+2G+i7HIx1pvsJkev9Y7bup1cGyGUI9HtpViROFitn1U7VbD4rN/jpLCQ2N8zT3bUGVoVhTymp+R1ejjUeP+DnZUTCR1Rk6Ma4Bu1AymYG/6X0xrBAdxpbzvs8r9oUHmItFDGOrG9pEhh4GdIxrNEf2kNrCo5cvvDQdgYpl0XomixOntrBRs2kC9/egzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JGczJWWlZPUFZmM1FGd203U1NxQWZ5RlhHeHZsVzRVblVyWVRnZy9UQTJr?=
 =?utf-8?B?MmNCMjRMSjQyL0ZnZlZyQm1sWlpYejArbG1tdFJCd0piSmhyUy9BWWhwL3p6?=
 =?utf-8?B?ekpJZ0EzL2ZIRnVsU0E4VEcwY09oS1Q0bHNIMGFFRXJoOEZFNUlwQVJwRmk2?=
 =?utf-8?B?cHJjVmgrTnk1MlBhOEFzYmVnSTZvMXFKSDRnaE94TEtJVGVNZ04xMEs3anpK?=
 =?utf-8?B?ZGR4N1Z0aldlYW9JNlV5ZjZRT0ZGNkN6akNoc3dpbkIwTXFJVmp4K3N1cHFF?=
 =?utf-8?B?cDJnRnpDVFlzQ1JUS01TN3RFRVRTMFNiRWYxcHFLS0RtUkRNUUVBZUp6YXd5?=
 =?utf-8?B?V0VVTE95MFVtMm9Ha2tnOGdCOFVId0ZNSnlMbFhGTW0wdDBDc1NKcWxZWXZR?=
 =?utf-8?B?Z0RQYkdlcTBlOGFpaitNMU5LWUdTQ2lJTnF6RXhFL3VLSzNid3V2S2RjVUF4?=
 =?utf-8?B?dEdqckNzUjNsdVIzZkZtS2lYUDczVTZNTWtEWEhZUWkrZnBHc0tYaUEvWjAw?=
 =?utf-8?B?QmNMbFJJUDVXcHVFdGhZRmVSZy9KS2hkbGUvd2NtUTR3RU1XVStpUUVsWUZM?=
 =?utf-8?B?bys0Ky9xblRGaVNONTJveXhldHR5L2YwRTloTVFGNXdoWExEeVZSY3IvOGNt?=
 =?utf-8?B?YmpncXZGSktpd2l0OGlUK3FVSDVxN0NkcGtTRk1oNVA2SCsyYk40a0pubjhY?=
 =?utf-8?B?KzJHeE9CRHlIYlJDOE50RVdxWCthNEFtRDJZeDkzSGZ3QXdNbGdhSTU4dDAv?=
 =?utf-8?B?UWh3WXNURVo0WUkxTzZUc1NSRXREem03MlhlbW93N2thVkQweDVFOUIzK0w4?=
 =?utf-8?B?czJub045aXliSkx5ak8zazBlNE9oZEZNVE5qeXBHcGxNSHA0ZUFkVnE1c1VW?=
 =?utf-8?B?dG1aV0JRTGVuUVJqSjBOY0dGNDlNOXZhSTB4WFNTZDJzcnlqUU42am80WTl1?=
 =?utf-8?B?TnduRHQ3SWl2RGIyQjZ4TWg3N3A0QlVqVUZmbFNtZEtQQlNVaXU4UlBFaDZt?=
 =?utf-8?B?b2Y1OTBNTzFFdGQyajJ3bm1kUEJUanZUbWxvaC9sY20xUFF3UVY3cDYzeWdH?=
 =?utf-8?B?OVRwKzF3dG5KeEdrTlA1aVNKcmQ3NEhuQ0QyQ0pyai84NGhrK043MzJ1d0l0?=
 =?utf-8?B?S3Q0REpsWUNvZEx0OWY5NGxubEdqdXFJekpZbUcySVhjeC9aeEs2SWlKSlBJ?=
 =?utf-8?B?cEhYd09ndmFyMERpMFVHVmcvRWpiNHdRYnRDcFZHeElTWmRJWUt0MnVCckk3?=
 =?utf-8?B?NCtQOG05ME5GK2M1WTlsOUdYQ0pLKzdlbmFOWk9sYlEzSVdUbUxvN0w3QW5v?=
 =?utf-8?B?cHp5TVhwRFk0OXFuQzVLKzFEQTlSa0RvWUN0OWxJTjJtaFErY0NqclI3Sldl?=
 =?utf-8?B?djhIbUZ0NDJGU05uL1hlaUYrVStEd0lnRjB5NVlRNVNkVXdNaysxbk9MRzZ2?=
 =?utf-8?B?OWdleUxwN3hHaDRlZHJxdk01RXBNS3hYNWVNMjRES1F6QmFoZmJaQUhrZ0Vm?=
 =?utf-8?B?WnZGaUwraklVb1p2Q0RuRmY3SlFpVzdaaW04SGlVeVZJME1XN0lQSFZYSWxu?=
 =?utf-8?B?L0I2UXpuam1CUFpWVjlrVzFNV2RhWGhzY1FXQ2R4dkhwR2NaTHpNMkczZU5L?=
 =?utf-8?B?bXZ0UGRYZklVY3kvK0JHMzZ4OVRDWFl4Z1hLdXFCaHBGb2ZRWGZoVE5CeEx1?=
 =?utf-8?B?YzJ6Z0xMZC8rT2NoaTIrSis0VWZDM1hQUnNiZ2s1YkhVQjh3WndacEFrSDlT?=
 =?utf-8?B?WXozQ1BtRjE3eHhSRDAyMVkvTmVsVUZEd01aT1FXQmNXVVNQSVRBZ3I1SHpU?=
 =?utf-8?B?TnU0bUVRb203b3BEUXBUeERveGs5emZlTWJtSzFRWkZrclZmS3VFaDZUc3JX?=
 =?utf-8?B?bDI2dlEvMEcyM2ZWZkpmYVhnWWNmMXM5TWhubXEremZVT3Y1anQzRVpyWndE?=
 =?utf-8?B?b3lXb24xMFhMTWJPSEkvNTlBOUVEK1VwSjFQa09DQldqb0htTXVpc2tWM3I3?=
 =?utf-8?B?d3NDZVBFcEJwb05yT2gzOEJNamF4bkVjSDZ3cEtZQUxsR3NzWGtEQVdmRFkz?=
 =?utf-8?B?L3hQOGk4QVV6ZWhjRTdSOUlrcmMzaUlqdFlKYkpneGdFTlJPQnVYRTZoaXJi?=
 =?utf-8?B?SURIZjZrd3hDazJiaXkwenI5eWYxTEJyelNyc3lsUlBneENBbGR6NGhyV2VE?=
 =?utf-8?B?WjE1dmswbW5zTjZhWllPVGJkMnVRTmxWMmhDaWNLdWs2SFIxbC9Ib0tZY0J5?=
 =?utf-8?B?cXZYRi95NzNVV0ZxcWxINGZiRERMay8yWTc4Y3JlTm5RU3AvWFAvSmlOWDRz?=
 =?utf-8?Q?ZifM6rbVJA8gRuy7x7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5211f3d-010d-460a-0de8-08de9ee40533
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:52:11.2087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y8B0hlQaIWFtwG1j88SSHFlebGPe7bFdIK4KZ0ygKzrnLAd2wYdwkieeuysKagG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
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

On 4/20/26 14:10, Timur Kristóf wrote:
> VCE accesses memory, including its firmware, through a BAR.
> It works slightly differently on each generation.
> In case of VCE1, the start address of this BAR is zero
> and we can't change it due to the firmware validation mechanism.
> 
> Align the VCE VCPU BO to the nearest power of two after the
> byte size of the BO in order to prevent it from crossing the
> boundaries of its BAR.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index efdebd9c0a1f3..0658f13f0bdf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -218,7 +218,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
>  	if (!adev->vce.fw)
>  		return -ENOENT;
>  
> -	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +	r = amdgpu_bo_create_kernel(adev, size,
> +				    roundup_pow_of_two(size),
>  				    AMDGPU_GEM_DOMAIN_VRAM |
>  				    AMDGPU_GEM_DOMAIN_GTT,

I don't think that this is a good idea. The VRAM BO should never cross a BAR boundary.

What could be is that the GTT BO does that, but approach that is only available on VCE4 anyway.

I think we should rather restrict falling back to GTT to VCE4 only.

Regards,
Christian.

>  				    &adev->vce.vcpu_bo,

