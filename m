Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19FCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F4310FA1F;
	Tue, 10 May 2022 15:18:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4201B10FA1F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGb53Vyf10usH5KWAjNhBnrzBVJ/cCm2rpywEq1CPP8pO7S11ugbbHxQJt3aAdijN+wOlhmXWfWetYnSvFbBw4mtwHCQiUTBMK5tiu+sTLcohRHYxQ3iQFo24afyn3k8rX+AOtZEVyK8GM6CC8uL8iDRXSTkQVfhoFfi5LMQb7husXTfJXBBeZxRvxSNPWYwjzV8AqEu48nDpkDZKe98kZQdmKKlXYIforAFLHWgCTQT09LdaW59ykLtei6Pu3IqwZa2oa/vyJfEGSygqlp4cVHbBzphcNXnY4GEETuTdo8rbVtyMjsQEo9LWJTuGu6z2B+zpgPkLikOVzoGQxkBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AacLkfkG4Q0Aixlxj5dbv3xVTrDgNCWhz6lOglyU968=;
 b=CfQ1kzc0evyac9K0/0BYCKt1nLrTWVOfea4Xq41qfpRBMsNVq0/BW8vAfIzpOYhwVx3yxGHsZHKXtXvTJTtsZ0X7Vqnqtb7MFtm3czCpZI259/PVj2uM4ThdrEtAUAddJy19FfZMsDTiXRXVYd+xi3ZU7VfNPAbY041//JcsdOJdnjdhUIilDOYBkFOnjllIsR7qCCRngHi3lUuXM7ovcaDBsLGyUzZGg0R9dQH61MLjH+1dpLgiIEotT6Wx/hsM0pN8oAw3NtNQWjQd+s9eXu5cGloplSPf+bFGkIwP6cN3T1Nvtlmz4dYZeBQoMtYi1E2PKa8vjfhWi/2HXOZAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AacLkfkG4Q0Aixlxj5dbv3xVTrDgNCWhz6lOglyU968=;
 b=Ay4dOJMva+sz1ANTscwH3v/Flw8wsm7r0Ai7kmjCC2ThV+cS+jXH7UpO+G32Mk2Ko96tlgL+0GO3qIiCmVK49W1pxB+LNl7XT2s/T+fMGDa5t6BavtewxZp53ivKYd8kCe+JCxRpg35gdiDmdsSyuG+mGw9r9Si5wJM/JBGJNnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB2883.namprd12.prod.outlook.com (2603:10b6:408:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 15:18:21 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:18:21 +0000
Message-ID: <3eca2928-1e32-aec6-ae94-58ebabb9f338@amd.com>
Date: Tue, 10 May 2022 11:18:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu/psp: use proper vmalloc API
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510145842.659401-1-alexander.deucher@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220510145842.659401-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::7) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbef9d39-18c1-4a35-ecf6-08da32985159
X-MS-TrafficTypeDiagnostic: BN8PR12MB2883:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB28834D04154F8681F7C240ABEAC99@BN8PR12MB2883.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvFDj1xYnONc6COlrjn58GpPEQhxNdASR35UcaKpO98mneJ+yucW9182cwO/taxAngij4/z9Jav0hy50MOIBNt82/HvoG/rQDOSZsvJKM4y/3IyxTayBphTj6smEPCHEQzYNNeJzprLM+R6BdIne6J+/FX0iJ94lao6WtK1LtzQ37fP38J9KhQTrIO+RMaP/H2bm31bZdiX4X2N1wylkUcbNLnLOH25Iwctnk6/8tBdgwp17PjeR07l+PpKVS/X0Mzynneb7RFvcoXAbbjQusXjnMLGz09GiFAzIws4wcnQSFOqnD5uPlYLrV6ctTdjkSFBsL8yS5mRmPoD1mbeSnp3aA+uUSFWZeTQ3LgDyAi/EUp1JVlbGYk7l032tkDV8Cm46IZSxvfXI4D8cxVRwnfIWkojOQ1RMxRbqGREmrOx52LUMw+6gKaCtBHxKT9liSCk9Z9Am2nvk6o9lz8MBh74j5NqD5tSxnOo0vcdZ2nYuKfx71ja0i0k4gUHhX5R22CrgxQIED2tzv30AAYwiYDSRh3mWQj1UrnAToHN1Y2K3pf9ACvr3RlbejEidOMaodyouCaZ1+uz9ySusPkt6NCzgdQElf4gH3ellTWn9Da0eHCYxqyiB66dYfYrHyR6rQnsRwcmEMwgy5KoyEGxcq2NIyv8XFj6EMAKUrAnklbgjZQKBItXQDQA3L2q1C3F39Iw1NEaaTf77qWUNKe75JFVc8zipAz8n2jas8yedJTCsfAcrvlWDuDSB9Ww7rMAo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(38100700002)(6486002)(31696002)(8936002)(508600001)(316002)(6506007)(53546011)(66476007)(66556008)(66946007)(4326008)(8676002)(31686004)(83380400001)(186003)(36756003)(2616005)(44832011)(2906002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl4c2p6T1RlTnZlZFhEdTlnMDhzazNIcjZwY3d2M3NPNld0SjN1VFFhc01J?=
 =?utf-8?B?THdVdzVVOVlTNDdVbStmRTdMWFpTZkxjWnBXa2U4cHBYMksrQWVPdWR5emNx?=
 =?utf-8?B?TW9GaEQyM3UxRlRibE5OdDI3MnZvODNDbWhpaFlrWHAyK1lxbVFCeFJldFp2?=
 =?utf-8?B?Y1hUZnNzc0VRQTY3SWl5WWQ0QjBGZ1dtRzFXZUlobVZaMzJEcWllTmpvak1B?=
 =?utf-8?B?WUltVzliY0VzZW51TUNGUnZlYkluak1tMm1qa013RFhqb3MrZ3lYOUFrTXk4?=
 =?utf-8?B?Y05QVXJCSlZTazdhOVhEeExhOVZPUXp0SmdsYmtFY2V1WXV1U2dCR25zMklt?=
 =?utf-8?B?TlZESzB0WVB3Rjd1L2I5ajcrek9Qeld1VFdoM0FjaHVCY2hST3ZiYkhPenFZ?=
 =?utf-8?B?OTJYUllQWkwydzJsV0twR04xQlVBTE5yN2JvdXlObDBTL3F0NnZuLzZsVkNF?=
 =?utf-8?B?VXIrVTh2QkdLVGQ5NG9xS2MrOElIMTlYM2NpdGZxbkxJVVlXM0Y5KzZ4Qito?=
 =?utf-8?B?SDZmZnU2UFFFRjVxR1dIMWdtWlBKNnpiMWZveitDbzVtQ01MTCtrRHFmNWw2?=
 =?utf-8?B?d1Q4Sis1eWtBTGhjeUR2Yzl4SFlEbFY2NkJzOXJtVjBoVUt1Y2xJUlhvREUy?=
 =?utf-8?B?MmVUZVAybGJxL09kMTRGWlNuV1RXY0xGcjFDdllxTFBHU1RPVkQ0R2wvYnV0?=
 =?utf-8?B?VUFhQklESVhKNlY0QW04QjdtYlBOay9JWkJoRmdDNzNRRGgrenowSFpUL3Z6?=
 =?utf-8?B?MG4wNnZ4Q0Q5TGtIQzhnYmNHMmVpQVIrd2FoKzdQYStjYzdVMDBiTlQ3bENB?=
 =?utf-8?B?NHJRenUyTDRUNXJ3b2xTZDNwRFIyTkZMNS9MTXRyczZ2c1pGUkM0K3g2cURQ?=
 =?utf-8?B?N3lPVFVMdFd1K0lMTW9aS2tPVkE1T2Y1Wkl2YXZ4WS9EcVZBeFFkbUhBYUdx?=
 =?utf-8?B?c1U4d1o2TmREMFREcnd6N3RhMEF4c2lNOXk2Z2t0ZThLNS82TjNNQVVtVkgy?=
 =?utf-8?B?WVZhWExlQUNKOWFobWJvem1SckprWnhSZFlEVm8wWm9LWDNZNnA2T2xyNndu?=
 =?utf-8?B?RC8rY0s5Sk95T0JINUxZaHlZZDM4R0Q4T0dOU2U2Slh4WnRXbjRObUNwWXdL?=
 =?utf-8?B?dmpaSUhLbk4wOXRBTU05eERBb1piTHpIWXo1cU5OODB5NWlxcDVGMy8wWERN?=
 =?utf-8?B?dHNCaHhCd2FFRGZmWDluOXFPZFU2SnpscXc2Sm5sSUpqQkJSRTZIbSthc291?=
 =?utf-8?B?VW1YL3pmRmd6a1Z1UzRuQUoyVkpDRityMGhjSUlHTFNyZWl0UzA5WXRZaVd0?=
 =?utf-8?B?QkZ3alRKK2p2WlZ1T1VvbTFSQ2puYjljM3E2Qm9ra3RuQ0ZjbEIrR054TGVC?=
 =?utf-8?B?SlJEL0xBWjFlLzZObTNnUm5SakZWcTl2eXhiS3ZBY0ZveTFkM05WZ2lJdXBl?=
 =?utf-8?B?Q2VPYkxmbWttU0ZNSWpsbHdTem8wRFloMVpsLzZPdjJCaVZuUHdLYkV0dTB0?=
 =?utf-8?B?Wkw0a3YwMzdpcVoxVk5SS0h0NVA2OXNLVmQzRm5MM3ZHYUxhd2lJV0MrRi9N?=
 =?utf-8?B?RHhtZnNKSjNPcEFOaUVSckFEOGlOcG50Z29rL1A1Z0x5UnpGZFFKbngwYXNs?=
 =?utf-8?B?VlFzajE0b0Vua21Ma3JzUzZjdEw3ZlgvUXhtRS9QZ2c4MnZGbVZMMjBKQlhn?=
 =?utf-8?B?a2c1eFcvWTlNWjJqbk1jcEhUbFgwdkdwajJ1Rjl1ZXpyaFVIQlVPRGFOVDJv?=
 =?utf-8?B?RVRlVWZHa2xCMDU0TjhRWXZzcmNPdGRjUFFweGZaUUdyeTVaVVlFZ3I3eVla?=
 =?utf-8?B?aVk2U3ZoL1YxY01pcDZUcW85MzRNQzFpUUpBVWhjcjlDQXE1YnNaUGt6cHE2?=
 =?utf-8?B?L0pvYkdzU1llV05HTTBhVFNxVlJhS04wNy9FbFA1N1ErWFpTZGtsRVh4ajhH?=
 =?utf-8?B?Ly83dW9XbUg2M0tRZFY4RXE3dmNoT3M1QU1sUlRKODNKQ05vekJkTUZ5bmRR?=
 =?utf-8?B?RUNaMjdadEQzSnFweEM3UzNWaW5xL0pwbThmRFh2NndPZzlEbnV2RUI5bU9z?=
 =?utf-8?B?VFoxY1lpeDB0N0MyMEhvQmZrRFpvK3NNbERERjhWR0kvR2cxVjBQaHJCRFRF?=
 =?utf-8?B?MWx2UjNOMnpLQVhOcFdoSVNJL01vdldHOTBNVjRicmdnc3d1alF4MHRtK3dE?=
 =?utf-8?B?YmdZMTJJUVVrNjlwc0Y5TUl2QllUaU1nZnhENjE4a2M0aGwzWEpZYVloblc4?=
 =?utf-8?B?ZTNTZlZ0c0ZwS0FLcTFTeW9IdklwOUdjKzNlK29uV1FpVUZoaksxQURuY3gv?=
 =?utf-8?B?ckh2blhvNFIxamoyWWxETzRPa2FyT3N4d2QvbUJTdEt5WG5CdzRHRnlpRlRN?=
 =?utf-8?Q?hGoJUbNNwaTpGrfivHWu8YsDFuAvniciU/taPseGv3nOa?=
X-MS-Exchange-AntiSpam-MessageData-1: zH5vq+ujLz0X1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbef9d39-18c1-4a35-ecf6-08da32985159
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:18:20.9330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlNG3U6Tvse97BrKnICFqlmYROOjekVXIo6A7/L2AuqzgrSxc5B4JlSgxysau7DKz/LFgg9xAQ1jKh8zgoafcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2883
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-05-10 10:58, Alex Deucher wrote:
> Use kvmalloc and kvfree.
>
> Fixes: 31aad22e2b3c ("drm/amdgpu/psp: Add vbflash sysfs interface support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index bbc232697069..214e4e89a028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3459,7 +3459,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
>   	/* Safeguard against memory drain */
>   	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
>   		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
> -		vfree(adev->psp.vbflash_tmp_buf);
> +		kvfree(adev->psp.vbflash_tmp_buf);
>   		adev->psp.vbflash_tmp_buf = NULL;
>   		adev->psp.vbflash_image_size = 0;
>   		return -ENOMEM;
> @@ -3467,7 +3467,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
>   
>   	/* TODO Just allocate max for now and optimize to realloc later if needed */
>   	if (!adev->psp.vbflash_tmp_buf) {
> -		adev->psp.vbflash_tmp_buf = vmalloc(AMD_VBIOS_FILE_MAX_SIZE_B);
> +		adev->psp.vbflash_tmp_buf = kvmalloc(AMD_VBIOS_FILE_MAX_SIZE_B, GFP_KERNEL);
>   		if (!adev->psp.vbflash_tmp_buf)
>   			return -ENOMEM;
>   	}
> @@ -3514,7 +3514,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>   	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
>   
>   rel_buf:
> -	vfree(adev->psp.vbflash_tmp_buf);
> +	kvfree(adev->psp.vbflash_tmp_buf);
>   	adev->psp.vbflash_tmp_buf = NULL;
>   	adev->psp.vbflash_image_size = 0;
>   
