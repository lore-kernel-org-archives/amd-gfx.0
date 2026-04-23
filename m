Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258C2F99378
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA07110EBF4;
	Thu, 23 Apr 2026 11:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1E03fvt";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B57F10EBF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWCzXhenF0GkIiat2syXtZ0zKF26+fb9BTkU+xyY1vI6ckYE1w3KX8EAdtX5FWeivMMVixWxHD9JzdPqxqngprpRuKszZQPFlm5PEAK4PHwGhwJGVFrNnTtQLwg7EgUVymRuf5jGSxIp/9w4H2yNAJEj8BtNNGpbcjjyY3yUw5Cqn6NzoFC8TKwcXCCz1D7txWHiRHbpizBRi1gWJntY9cb1Isaf6tmRIKzXQ0xv4poLwivMvRrooNfUNXL/kLVRiOBnSOE6Nm87fw6D2HduF/AFlIFXdUuHOHHWEb48I5wP1c3q9YKhDtLzGYt3c8o1sWcUDu0SGvo10PG/R82JBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilpIBveyGbXqWgaymLgX/sklskAWV4iLJa5Empc9kU0=;
 b=Qr/4skdZVjH7W078Y144H3EGba+rodDN1e8n4ItOi3p4EG8wHYbepDX/pQCTP6evHL6Jhfj3OLDnoi9VYEq32WaYIQDj0OwKyUji8O69iEqKhJkPtCckb0d9kh2aGL0pAmx7xYRYo+OGDKJ+8KDVhWAOex/we/fOh19uR/l+Q2jJ3Z/ijvi2LlMBbDDiD/31o/xfMvkLWYcvGcsxVFD7bYoxCmNT5LDZQlBQDnTV1h+YqbbIyOXcZ8679UW6N/Snun6TuKbEXzTJSI3FuyIWITrh78/eOIIy1Ee8nM4xzI0KtM6d3Y1u2n4YsuCSi/gM0V22w1JtS6EJF30kGLuyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpIBveyGbXqWgaymLgX/sklskAWV4iLJa5Empc9kU0=;
 b=d1E03fvtKciIREYhUEMDFs+1OBQy/XrDA9iOsCMIekvvj/cfLGRmbFzUQ4tfn9ZdHgUxZl7JGt0FGtgOz6BO0npgHouQeWFEXi3gj1X7X403Ui8RjDvxpSXgogPXF3KInwBVzCD4GwWYOX8CapJe6w+D9rrv/EMmU5oDPsRm+I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:29:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:29:01 +0000
Message-ID: <acfa3233-6aa0-4fe5-9fc6-d17d821a1593@amd.com>
Date: Thu, 23 Apr 2026 13:28:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-10-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-10-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f59b67c-38c1-4f7c-06e3-08dea12b84a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 3wWPrge+Vt8eqpYDfzjBmrVGs8b5bHaThiLSX6w2ElUXo7ZMLcEctU76T4+KY1IbB2bBAks+hT8edd9soysJ0wIjoxnGiiusyqsjg088WQ5ne8xEH0i0u6Uwcuttqb3+8DBjSfFw1QWsaL9jQcr+UE2CoT6MK4qigzA8nMdyeTKwO7EQr94WkkNl1PetRQHV/1Xr/9IehX5/uNZ+erQTVSFISmnWCjCEjkVY+gkKJPE7fJsdirg8Ecm4iqsCfit/68dgbRUErXH+hRjmTKhPeLvRHY8iR4mdAT38XdCZh36oe6oHPzWdXve7yKslTD15XDHkrkYUc0Oj7UfrTQyKveakee1T0CkWhW8yc1+HaKRvFznEnowSLyRlOgZb2VJGOlFU7fAH2axO+u1gX2eN7/no34Iw1vSYIpdOs1YeKzjgk8jhTHeMfhDxcUsPWyxnUfSXpKo/AP7zRfLIsfNt8yY8sybe1FuaYAPe+vpOLcPQv3Eti5S9u1Nz6PGEW/bATbqnMsUIQwpkxBLqD1UYFdQCJyj/kZcuEWAs5OAATHNlybqHpuXKi3LJ1N11gOWT/SHZR9CZ8jovbSg7B9pqi6Q91mY74Ukr7Fga4CmuOpjC5T2N6NvV0m+Mjua+/3UoxmlkHw9kq9bz1lZZs6/+BX+7N5MkWgELaPANDZtpB+gBahDzeutdERCDjl/icmmL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFN5M0xKaHpsNkNhUlVubzZIb0xkcS9aOVlYeTBTYmRMOXFPL1R4KzFaN3py?=
 =?utf-8?B?T1hTRXZWY0UzZ2l3bmV3NTlEQmFQTjJUL1dnZE84TzVVNE9pTjZvaThxZlp3?=
 =?utf-8?B?RWtOdVYzemIvcnVPbS9RajRWUG5GZ0hFbmFFY1g4L2xyM2pUUzNjeHRjeWhq?=
 =?utf-8?B?NzZJbjNJWnhuaGVPRXJzTjdCR1g4dTVjQnNNQUsvV3NQeDJKakxxa3dxenEy?=
 =?utf-8?B?MDA2Mk9JcFc4SXd4aHRoeUhWT2xTQzQ2Ymt4REVzMktXQm9FcVpGSDR4UkFY?=
 =?utf-8?B?MXhvL05zMURaOUZ3SnFKQ083V3NFUFlub2lqRWJBSWFNZ05QMzB2U0lJcTdh?=
 =?utf-8?B?ZnBKSUtPQSsybWdEWGVKSG1BMm5qWWRCZHB1VFdhUlBSU2UxQTVyMXVvTTVF?=
 =?utf-8?B?Um1QSjFiQ0pyT3EydEtxTkNzVVhnbFlVcGFVOW43NzFKRUl2aG9uZmFNcURz?=
 =?utf-8?B?cWl1VDhPTlQ2NTdUUTFiY3BwTXlPeXhHZEUxV3ZoR2VlbzRUQW5tejZhd0d5?=
 =?utf-8?B?SW1LVW15Z2FlMG9aWWlnaVdtTVRRUC9GTXIveklIalpTSXN0cFR5MlRFZ1M3?=
 =?utf-8?B?QXNPSU1KcFR2WURtQ3hEd1VRbXZqWTExUEpiaVoydFhaNm9kWVFjODdwMnRI?=
 =?utf-8?B?Y3MzNUFVcnVFY3RMUUF1ZFdGYTN6VjhaeU1FclhadWhvaXhjWTcvUWx0ZUJN?=
 =?utf-8?B?TlAzTVIydS9kcnhSS3lPU2trcjBUTEYzNG9VWklYQnkyWi9sZU9qZmd0U2lF?=
 =?utf-8?B?dGNqMHo0Si95K3dERDczVGhkZmtib1A1OGpHV0VXYTZZMFZSWEZ4T0h4dXYw?=
 =?utf-8?B?RTdRYSs2ZnpCT2ZOQUdhVWxDVlhnWlVNTDZyLzdaQ2tkVXZJT25jeU5XdFNj?=
 =?utf-8?B?K2JyVnREckZXUkF2ZzJSMnJnbE5tMzgwYXo0ZVlYWmZKT2hLblNCSzZJbDRG?=
 =?utf-8?B?VXJ6cGx2S29CUHNTTzdueDUvOE9ZdW1sTHQzUjQ1eEo2ZFh0SDEwa0l0RURa?=
 =?utf-8?B?MVFhalZjU3NZYWIvRlNXaDlFUUdrbGRMcVR3Q3dDZ2RwTVJhektkL0J3RWFN?=
 =?utf-8?B?NDNabjJjbU1FSnplanNxeDBpT1BKOVZRV3NvR1NNU3E0aElHeHRzWS9rVHlL?=
 =?utf-8?B?Yk5IRWNNZU1pTWE0WWZZV3JlSXRKdjJ1dTZqN3lZbFdCc0tYWCt2aEtvQXNI?=
 =?utf-8?B?N00xVitSRk9qYmpVd2xGb2RqaGZxT2dBdEFiZDBCZFMvUlkvUE9PWDJFOUFx?=
 =?utf-8?B?L3FTeitEcTd4WXd6Q0Fsblh0QlpybGZRTmxsaC9NRnowOEt2VWoxclY2bnJa?=
 =?utf-8?B?Y052SVFPQXY3dDNkNzMweWsxb0FCK0l1OWxFQlcxRjQ0ZVVsemxHb1FmTTVi?=
 =?utf-8?B?K2FkMC9jMVYvc255WG8rdFBVQit4SEJkejBKK3lObjhDRloyZGFxYitGYUNa?=
 =?utf-8?B?UzR4Rld1bk1iemhoaDQzNlVOOGgxeFB5bTNrUE84QldoTDZjNzcvaEttR1R5?=
 =?utf-8?B?TTlFK3g2akdMaXFPZnU0UFlTKzAvM3NHcjFtSUduN2VFZkFlK09OMVhWaWFl?=
 =?utf-8?B?Q0E2bFdMR0RtZmtBcnBOR1NCcGFKRy9JMk5SbGw1RDFlQVBML2ZCcVEwc1Fl?=
 =?utf-8?B?T0F4bmx6T1diTXZUMHNPNlFOSHhXdVlEVHF4NVdhSS93S0wzbHc4aG1pS2Ni?=
 =?utf-8?B?RU9DbHkyT0JCU3RaNW5wYmk0K0lINDJCRzNzTHQ1N2JwMXlvQUhROWtvMkU2?=
 =?utf-8?B?YnpkeGlNbytoOW9Jb3h0SDhacHBTdHF2QzFSS1dUVjFMdXpsajZlM2FaWFhz?=
 =?utf-8?B?WExFMDhkYjkwZFhlK1RKbjFNME9tQzcrOWdobGlqa0NjN3NYZ2NBK3ZrNUd0?=
 =?utf-8?B?b2V5MTNkUWZhcGU0NzhyMENtMWRJM3QzV2YyS1NCMUVRTVluYzhUTUJ3YWdp?=
 =?utf-8?B?eDBUVEtyNjdUcU9tR1ltbkFNTXphZDd6SVh5ZjJ6QThCQ1Z0Z1JVbDREM08y?=
 =?utf-8?B?OFpUWUVmTzVMbVVIMDRuQVhBcDFzT0Y4cXFGUXJQOStSU2MrK0ovY2RFdWdX?=
 =?utf-8?B?VjhyM241Y3ZaRld4K0lKWitnaXVQWXRvVHJxbi81R1FpaGpzQnhzeGFVNThQ?=
 =?utf-8?B?MXIvL3JlZVB1UHlnUjhidS9vMUhtYU9zeDVGdldNaWdWb081N3IyaS8zdnh2?=
 =?utf-8?B?WHhFWjYrdFA0cVFXRVlkWjZENkc4SHQ2b2UxZHdBeEdXQ1U0OVkyaDFEaUMw?=
 =?utf-8?B?ZEFua1crZ2EzdWpyQ1JJcXYwcWozNjNOcytIVzQ0ZHdUT3RnaTE4MnVEb1Ey?=
 =?utf-8?Q?d6oho7Ev+JMLBBYunL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f59b67c-38c1-4f7c-06e3-08dea12b84a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:29:01.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /w5mS9/pAOwIZUPpZ6r6ZIxHLOVdzcUwmU5RDGrTSgxR/f7pWebrKUqSh1NkKUgk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

On 4/23/26 03:16, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> This may fix VM faults when using VCE 2.
> 
> Cc: John Olender <john.olender@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4802
> Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 00b4037d4bc89..3b493a2e94dd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -183,7 +183,7 @@ static void vce_v2_0_mc_resume(struct amdgpu_device *adev)
>  	WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
>  
>  	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
> -	size = VCE_V2_0_FW_SIZE;
> +	size = VCE_V2_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  

