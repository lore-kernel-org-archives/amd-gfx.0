Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE1BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 13:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D050D10E360;
	Mon, 21 Feb 2022 13:40:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB1E10E317
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 13:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR1aAc87rS3vC3p337AmWjQwG+2f/NU1yit2GWjfCCGLDDonpDayTsIAQoeDEyHpFhvVDc07YL0o1z7er0P+IbsyUL3TMyAZfCbQxy1I18l4pNdqhzdymBdoq61DWM2wxBnAkYxrYxtUOkGu6L73PGK/2NkydKu4JPP1HRqf5kJdVXVmIHItO8w/sHA6BSGiMlg1U/7cjztYfnkhTUO1XygADDGznCnfO9zRlxy4cWLZ6uQcrJGXyByLDiBD6okS596J3zkJ+/m1kJh1c68L7Uq+km+MkTHThwJEVpvYbO/gweHpb8dwB7Km/+E7+RBNrisGS/2/YgpQ631PuAhLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTheMKoOGMeY3ESD6xfxZJDFteOiHzc3PXXs8K/JlYg=;
 b=d6NtKkeRbMVxb/aMrvc5FMCaXT6aGRD7cOhR6q1qEL8biA6ng0BW44LQxOWHtXyNwAX0A0dw6yO7fgkswjy97cwnsDc08+ACq5cAofxFhZmizMuP928ICydiUpd3PrFYVLVto6kL0vaokiJ409B8itkoQWBwhZ/DMaIgA6JbcFuyGLWUpy1IDsOdNog2r9zkjusvC9GfRfW6jJQgW8v0X9cVVi3RWrqS/trlfeO/U5pSVKzwj3b5E1CZD1UiBQ3UfRgNfoBZJgHn0H85nUHHxaJZR9qXkyShP/P7MOAnolxx+7iiCCEdeCWBjjL/Hc2kk95AF5s3MfHpRAuLdOApoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTheMKoOGMeY3ESD6xfxZJDFteOiHzc3PXXs8K/JlYg=;
 b=fbyTWd6JHJz7AN9d2HOJ5phZnpWKHjF0iYIsWt66ughTP/51u1+1xqs4D9AOqV6aI8gLmXsAtVByCWstlS1JDVXwumYmvbT5wNkuSv33Z9y/r2ebImY0EoO1cRoI9yXdoGdl19ufpCeELzSy5tNECq+b/7WbbcjeWvKtQqVYkFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1170.namprd12.prod.outlook.com (2603:10b6:404:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 13:39:57 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 13:39:57 +0000
Message-ID: <3a66af2c-edd2-cc0b-1caa-8fa989b94a02@amd.com>
Date: Mon, 21 Feb 2022 14:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220221133411.12544-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0009.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab9e4d9f-3ca7-4b4e-728e-08d9f53fa64c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1170:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB117069C739D4B1D1331133FE833A9@BN6PR12MB1170.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4j8v7UeJHBBIVbdfr5pM8rMRZ+QbHvuo1gC1cZqpDA5ECf1IWh0PRZ//0iD61N5aDKMQi8/9bE/F0PpfoizQWTlS1U3g/gcfVylZ+y615+q//O6hisobenmn+RKjDvBPd7exeQgP5MuUDFrgOAjadT+NfYNk+tk0GRABJsS/++UTPXtwnZFCumU2YFDsjdjHHI8r4p674Z8dYxQl2i0AbWDXnSOnj2yZi0UiaxuJZBQwhv/pmTfiw/QGIPppieNc2Aq1Ce3ChsxPw9/a9ve5H10Nf7fUbloczazLE3h1hpcdY72zdR9frHHOq2NIs5RhslVz0syt5EaolO6OV2CR4HkQMLCzYerofbmtUAF4b0tX0IXTC3IEbGNUGxYRBMqgQXcKBFOWP7LCQCVib0gSkfG/DI+FBYER9AEjK1dH2lUgrVX6tlpRQnQa/aC/0X5Br+U8t/BojCHoo1kGeZeQNk7cCZd1cUhlPRNraCNgRw7JDnB+3FrbUPzAqT+GSQCIfoa7Sex+FEkpDmBUmNe7zZa5VH0Pl7V/eNPwIgOtpIXn5GbwdyBvtNO0kFltR8wyJtd12GmKDnm/L37yX8f2cQKo7AmMiLG7u9ohnl6vp/0oZBABZaBG1WAUndR9JqXABjV6811CQiWsS51SrXnKewcROefEVfaXiXA5fWuSyjGApAIY4zibiaYVTKIs4GI3JOfgcsYjMlsNfmGMrG3TEAUOz4E8M2xZoC26NUqW5il3lBkFNZBzhVLioOHvc55s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66556008)(6486002)(66476007)(66946007)(316002)(508600001)(83380400001)(6512007)(8936002)(31696002)(5660300002)(2616005)(2906002)(6666004)(186003)(86362001)(26005)(6506007)(38100700002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9vbUViZ0JtRWVvSmwyVXFwUW10bGEvbjNsUHJSVHFRSks3Z1ZnSG1xRGV2?=
 =?utf-8?B?T3hjc1JiVE0rVG1hZWE1bW5rVjhBNE83RkZGZWtsMmlPWWZ1dVhUWEZDazNy?=
 =?utf-8?B?OWEvZmIydVY3dFkvY3owQXNrM29tSkRvS0FrV0VoUE1QRi92aGo5Yi9tQ0hR?=
 =?utf-8?B?Ty8wSnhnWWVHRkJleVdCeFc5dVdVTWFXUDljTzVrMjQ5UmRRakN3YTFQQnl0?=
 =?utf-8?B?dnV6WDF0MnpQSTF0M3hWdnlBL3E5RCs2cE1xNHcyd2s3ZjVuSFBaUnBsMWYy?=
 =?utf-8?B?U0czYkdJRXIrSExZcllmcElZWVlpTjBWSFRjK3h4by9kTUVVQlNLdFVzdXhx?=
 =?utf-8?B?Vm02d1RycjdpRU8wbW0xSnRrSnhQcDROYmlIcUY0aXlOc3RHbDJPSy9CRTc5?=
 =?utf-8?B?ek9CV244NzRiNG9HSGQxalFjLzk2dUVPZWhIaGtCcUN0SUF2aGx4QWlKSTNp?=
 =?utf-8?B?cU80cDEzcnl4UmpRK1VCVzZhNDlSSEZRTmJnS2hPeEp0ZXI0VzNDUTd4engz?=
 =?utf-8?B?Qk50clBCZVFkS3VVOEZCdldSUjNucGZTYmFQamZ3VjE1eTdOV2taUjRLbGpp?=
 =?utf-8?B?cUZKUmhNT3FCSjRCUGY4ZEx2ZFhkbXozWk5NTTV2N3Ztbi81ZTVWZXIwK3Z0?=
 =?utf-8?B?Q3VqK1NmWE04UUlZNC9VOE9RRWRacEFXbHVNZEIwSzVUOHVlRFh2SkZHSERj?=
 =?utf-8?B?d0w2ODF3VDZiVmZKcmZ4MFlHbmc3UE9adWlhOTFmM2NnVkVIaFpveWdsbVN4?=
 =?utf-8?B?cTdiUWdTV2RBeTVzYjZoRTJlUkEzNmhyUEplYUNxdGRpYjg5bnpnS0ROV0Qw?=
 =?utf-8?B?SWFjOXl5UzAwcGR1cm1FdDFwWEZ3OW5qZm5oSWJpM3Q1MGFDVUQ2ZWQ1SjAx?=
 =?utf-8?B?WFIzOGVvalE4SEdjQlYzNkhTKzc2SHRzdVF2ZytORVY0azYvQlRRZXBUaXI5?=
 =?utf-8?B?cllyL0pMS2xtZWxDaTBJNThCVlp4RGMxeFFiWDVUL2EyTDA0YmFKSVJES1pS?=
 =?utf-8?B?NFVud1NRZzVmckdRWmZ3Ylh6d25ZQlZPU3R0a2tSejQ2RThVcnk2ODQvYnNG?=
 =?utf-8?B?d1hveEk3MGlENnhqQTI3MktmZ3I1K1pWMm8rNVpORWswYW56VTh3YTVHc1ZT?=
 =?utf-8?B?bjBpRkZRZEU2WHI1WDBuYW9ZZXBUR1pwVnlpZHZOM2pnOTVVbjFqanJQdXpa?=
 =?utf-8?B?YjZzZ2JqMjRRZG9uUFFWbkRuWnZzbXU2aGZQR3JCYllyWFdUL04yMGR2U2xI?=
 =?utf-8?B?SUVGNisvZzExbjVObUNVNktQcnlxMlRLcDllaDRmSjZsMGo5T3dyM2x4VDcr?=
 =?utf-8?B?SG1NTGtVUVJzRjRER0R5TExWZWFqOUR6eVd0ZThlek1maDNaSHBUOHJyVWc4?=
 =?utf-8?B?b1UvaGFwTHJpcEQ4K2pnL0ZSMTFXMk4zeFkxc09tUjdxZjk3Qm43V3RnWFZv?=
 =?utf-8?B?N1V6bWMxUUZqRmQ4ODJPcEZ0YlczSFNFL3c1NnhTcEZ6cjNKem5hZ0ZzSnI4?=
 =?utf-8?B?RFN0S1haSG9kN3h3TVg1MHZEQkgyNTJBdktQWHFWNGEweWVqY1MzUi9Xb1I3?=
 =?utf-8?B?ZWlya3RPRGJvakdxQmFEL214QjkvdXcycTFGdklYalAvK1J1bklpY1g1aFNa?=
 =?utf-8?B?a1BsVnlRZ3E3UHhNTjBicE1vRHVseW5ZNXo3cGpBVjFFTGtpaE5acVczTHR5?=
 =?utf-8?B?UVhlYUFHNmcvTEJwWUQ5MGlvSFhDRGxJMTBEb1lXcnVJczJ1Nlh0Qzg1d2Ey?=
 =?utf-8?B?ekFVTGc4WlQ1blVEeTBNTHFxdDZLU1RnWnoxTFNkMmR3Q3JidHhHazExVGRs?=
 =?utf-8?B?MnVjbGJmWU1lbkxkdzF5OHR6ckxkNEh5a2I2aFBwWFVKYmpIcUYxS2p5Zm05?=
 =?utf-8?B?eWN5U1lhZVZ6ZElyN2tTbXpaNDF4bmc4TXdUV0N2a2FoN3VZc05YdTNxMlNv?=
 =?utf-8?B?VXkyMTdpejRCOTVmcFJ3ODlYZ0VLWGNldm9nQkhUY3pIM093US90U2dyNFh2?=
 =?utf-8?B?U2g4Y1dndGhteTdzUXNPMjlPT2dPZHE2S2xRSlhFY3BPRHN5WVhha2w5REph?=
 =?utf-8?B?SW01UnhnOUFyOGtMQlJ1S2RCV0E0UWp6MmFTWUx0WXllUWM4bkljZGJRMCt3?=
 =?utf-8?Q?m+Ls=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9e4d9f-3ca7-4b4e-728e-08d9f53fa64c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 13:39:57.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8DwyRiDpAyccLPKw6DSJDNZ8a7cHCM1fSpSgWmhhc6CJUMqSJVfV5CXl5PLiHPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1170
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 21.02.22 um 14:34 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 +++++++++++++++++++++
>   2 files changed, 100 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..6e35f2c4c869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             num_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..69c0a28deeac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,100 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	ret = down_read_killable(&adev->reset_sem);
> +
> +	if (ret)
> +		return ret;

We usually don't have an empty line between function call and checking 
the return code.

> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		down_read(&adev->reset_sem);

That here will just crash because we have already locked the semaphore 
before the loop.

> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +		up_read(&adev->reset_sem);
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +
> +		if (ret)
> +			goto error;
> +
> +		len += strlen(reg_offset);

And here the down_read_killable() is missing.

> +	}
> +
> +	up_read(&adev->reset_sem);
> +	ret = copy_to_user(buf + len, "\n", 1);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	len++;
> +	*pos += len;
> +
> +	return len;
> +error:
> +	up_read(&adev->reset_sem);
> +	return -EFAULT;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg, reg_temp[11];
> +	uint32_t *tmp;
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		reg_offset = reg_temp;

I think you can just drop the reg_offset variable;

> +		memset(reg_offset, 0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +
> +		if (ret)
> +			goto error_free;
> +
> +		reg = strsep(&reg_offset, " ");
> +		tmp = krealloc_array(tmp, 1, sizeof(uint32_t), GFP_KERNEL);

That must be krealloc_array(tmp, i, ... not krealloc_array(tmp, 1, ... !

Regards,
Christian.

> +		ret = kstrtouint(reg, 16, &tmp[i]);
> +
> +		if (ret)
> +			goto error_free;
> +
> +		len += strlen(reg) + 1;
> +		i++;
> +
> +	} while (len < size);
> +
> +	ret = down_write_killable(&adev->reset_sem);
> +
> +	if (ret)
> +		goto error_free;
> +
> +	swap(adev->reset_dump_reg_list, tmp);
> +	adev->num_regs = i;
> +	up_write(&adev->reset_sem);
> +	ret = size;
> +
> +error_free:
> +	kfree(tmp);
> +	return ret;
> +}
> +
> +
> +
> +static const struct file_operations amdgpu_reset_dump_register_list = {
> +	.owner = THIS_MODULE,
> +	.read = amdgpu_reset_dump_register_list_read,
> +	.write = amdgpu_reset_dump_register_list_write,
> +	.llseek = default_llseek
> +};
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1672,6 +1766,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

