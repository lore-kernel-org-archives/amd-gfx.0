Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D58C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 10:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9D510E431;
	Tue, 15 Feb 2022 10:17:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC72B10E431
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 10:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui68rWI6IavDjx3YeKPVnIlMpu7TLOfjP1IuHKidyb0Zsfh56GMYl7qKiVNjp0YCCn5wSrIsKTJr9Qho3F+jcyrIMa5sLcpdBxboqWS4M59ovqeM/l6jdzc8t4qpjtKKjyXpPFNSiC/bcijNTQjswtb/f4BOBY1n+PkD9AvHR6j7BP41HjRcDNACL0YEAew2U03Kk0cyFJqfcUTRntM2//JojPnlDCXAc2GH6YZl7/gg0wm/ZwNzWy0TI2o5KR0jD9HS5cdO6bixpz4Fp3hUgM1MIYtU3fpCUwO8KU+2tpdB5qfjPVJDA0NMTkjdY2omcH4wHOmA36OI2j+GzLv57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvLuOF/orkGMYYVjSz2eGv1+HwOwGxi20zxXTXP5CuA=;
 b=b9wUtUDjblX2E4rQHMA4nbMq+7r8rFEi/eoB4PS02iCVQfr0QmBb+5kEze+oqVwCD6avkPy7Gg36Vq35IVHtFYidxIIVsOXUB/E7dv8M1SDibMmzEUcQVQ4FLtZw+GFlOycQLunRPXT2ByuRgXfRbNHXFp/9PnY1v968eFp+2bAOG4/6Mg7O8iffxIqts86l8l7tNlf2uSkB1yT2yLpylJLA1xURcu0dfy7OWqVccLs438lhTKQNap46DnqYDGBpQeLPHfv+yctmWRsmwyJDflicNG/5BQucg5mXmbLcv/i/npemsPut3SN/7wClKFDuzGQnplQC1AosbMWenJ3lzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvLuOF/orkGMYYVjSz2eGv1+HwOwGxi20zxXTXP5CuA=;
 b=AemzYKNF2Er31lA6HhCDWpDOFB3NE6kjGmQIF3gEJL2X5vVSIl+kJdG1HwK3T8QWaaQo04PNfFxulcIvh1ephFnRu1cjkA9rtfXv9GrFZ90U6Ra8jRwGUMA7di0aUw3TX8Drcvo/yts4VZ2xcJKFPdHnaULmBX/Bpyoja1rB+Nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 10:16:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 10:16:59 +0000
Message-ID: <e678e107-530e-260d-b14e-f742a651859e@amd.com>
Date: Tue, 15 Feb 2022 11:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5552c41-ed8f-49ec-56c9-08d9f06c4d30
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB25235729974137B9056E328C83349@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZ/xh9/ui+HZSGJDL/gTOrF8tMgloDZiEdnjiCh7r/1yjC/QtKqRQCCmJNxwthC/j99JKclcX7nRYTrB7mfvpIV8JzxYy9LXcVw1adamnhOihrfSW4krPp4lvuBpbtSMAsNNkaH0IzoTa70+LcAKwd0HpG46CU6zpUPVIrKYpP4yl+nVRKFdnM84N3WRjg6Ru66WnlYQVEHFnrlWeSnYeVJMfHuXSLOOzRdTc2GtC6zbxgXlflp7XBM6spKiw5ykqfJ3cYBC8TlmP6LVDFo7aMFUc6E7ppT3DSsrMob4TCG9Um4g6vZmc6PsaEF5ifMzMB88c08uXjHqgruVlAmLmjo8HHZKXwzjLMam5RBC0HXWQkZUexCcv+lTeumCgOjWHHZRuYUhSEmjVPV5YXeT17B2FNDfoeGpV8/R7ScIogodnIdY/EuUFJWOjEMdirBPyWv2Hv6EmKBDMyVg2d0T4BnHkX2lBglHYXGniuHw+wMnqVUt7TjdTnwK97SqK7TW7TWcJAc1hfs3Z5rt/kK8l+vUVj/JGlsA9uLDepQQ0jZBo18a5fQDKSyc//MRgpupP16Kzsr5x3HmrvgpIAvdOaR3oGX3+kzc4/SUdPQPWcDxOarysOKjWh/x+rhX5br6XM3DXnRIP8J1oSmb8UozA2CK2kITdHCXp0oa2aPm26NdMnqi1Arb2TFfq2lajvyju2K+El0SnDgbYejj3eyAwJuKGPInSjtg+5wzil/NkArpU2SWEB65csXPZ4FjCXGw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(5660300002)(4326008)(6512007)(66556008)(66476007)(66946007)(8676002)(36756003)(31686004)(86362001)(186003)(31696002)(2616005)(6506007)(8936002)(6666004)(6486002)(508600001)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkYzUUdNT1p3KzRjeHkzSUJlTU1qcnFMQi9ac1R4L21oVThvWXVqZzVlSTM0?=
 =?utf-8?B?NnZVRjd1dUQ0N2ZpaGVrWnF1a1NMMGxTcjBKeFRzY1ZRSElsSXhGajBHM0ti?=
 =?utf-8?B?c0o1Um9hcVJ0emRiRkVLOUFnUXY2cHJOYjI1TnFxa3plRTh6VlArMnNhbTVX?=
 =?utf-8?B?L1k2VDVBb3hSenVRajFmK1k5b2NodVBvZnFyZThwK1RJUTRTekMrS0hpbzkv?=
 =?utf-8?B?RkJPZjB4cGVxK1pWV2FFaDZzS2N1d255NHY0MFVFWFZ0VTJsOGJOL2J0bGND?=
 =?utf-8?B?VnY4Sk9GeDBSU2dqQVUwVHRBeTlHdkExamw5Qk9ZcFlNNEhjclJmd05IVXRj?=
 =?utf-8?B?alYrVVZZSG1SbnpQcUhBS2luZllmOHNkMHhITm1mSzJERGdDVkhlVERSMjNW?=
 =?utf-8?B?SkZLS0Z4dkoyREt5eW44QWlxNjV5Q3Bub051YkZma3loa2NXTGs3ZUtucFN6?=
 =?utf-8?B?OTJsWlFOditMUERlZk9adTk3VkRDSHhaRlBLMlhOL1pTc2lwdnhFZzZzbXBL?=
 =?utf-8?B?Ukdsc3dnQzYvcnJKRks2VnJCTmszSzBvcDNUT2RDMVJYOGNYWWRnWnByUnh1?=
 =?utf-8?B?d3AzQmtPaTVCak9aZmJSMGFHSEY2U1FjTnFEZEk3YjhNeUxlcWtvelNWczdN?=
 =?utf-8?B?TE02eGpLL2FWTWRta1VyMjRXc0xINEF5aXVNeTBlYUw4VGFOQmplSkk5c2Uw?=
 =?utf-8?B?QXRDVktGWUhkSUdidFl0bjhrOU9JcWNTZUxBVXR2SFVHazFkSEUzOXZBMytn?=
 =?utf-8?B?T1E5WnpxRkRlVDZzay85WVBRa09lTUNkbkZVZkhBVnhUOVE3SlJ2TmNLelkv?=
 =?utf-8?B?SEpSRDZncVVoVkVoeTFKdVM0U1FwV21VZDF2bGw5cndEL2ZFUXRqL3gxcXI3?=
 =?utf-8?B?UHJRU2lIbjN5S053bWFkbCtrQlFDUjE0RCtTaFVnaEQyTll1YXNPTVUwdGtF?=
 =?utf-8?B?djNxOXNqeG1mUURsRmQ4UUYzRGZKZjZaTEM1aUVWWEZnK2xhRno0ZTR1TkIz?=
 =?utf-8?B?d3FEV011MDRZcjJZSWlCRlNRWWN5UnY3WXJkWnJmOWYxelpiRDZaM2xYbGdK?=
 =?utf-8?B?cTE1TGRtZzFIVFNCVzdZeFp2Uk5OZjhxU0V4T1hSbG54MFNzOGFJNHlqRzMr?=
 =?utf-8?B?Q1pMVERwK3lMZStJdHZOMWlWOWdaZkU3MExidEV1bWJZaEgwUXZ5eXV5NFlD?=
 =?utf-8?B?b00wbUMrMStIZHMzV0lKaHJrVGthVnI4a1dUcytydmhGSFZaQmwrVCtlcnlk?=
 =?utf-8?B?WmNwMXJGZlVJMTVTc2JKV0Y1RGszaXoxNW5hci9nL1kwRVY4MEkraS9DRmhD?=
 =?utf-8?B?MUFKK2tWaUtrQTltNWFFQ3l5ak1Ec2tpU3BWZFo1V1grT2JEOE1oZC9CbHNJ?=
 =?utf-8?B?VU9CNVNPNVBXYTdEdXc2SFQwT0NZQ0Z1UjY1Wkl6c05MQjI3VUwwaXMwUFQw?=
 =?utf-8?B?Y2pqUW80QStGRXpvNU50SVZQY1NWYVJLb0FJcWFkTnJnSTluQkQyLy9Qa282?=
 =?utf-8?B?ekk2WGpyd2k4QUdudjkzdk83WTJqWngwYkR3bi9WamhDR29WbVRJM3JFbHRQ?=
 =?utf-8?B?M2Jramx4Ukl3UHY4dHlUazNONHRzWnd5MlhDbkNYU1EvVzVyeitQbG1ITzlL?=
 =?utf-8?B?S1U1djhNNnI0eEVEUHcvN0tidVRZYXRjaVZNRzFydUlYNU5OclByUUFKMks1?=
 =?utf-8?B?QmE4bWk2dkpIa2hobkVxWEdRN3NtMVVheTVNN0Q1eE9SeWFNY3BwVWhiUTZF?=
 =?utf-8?B?RXIrcVJZTU9USjd6UjRNREtJa2dKSFdkcjloZ0FpKzZWUThHY2RRdVNvN01S?=
 =?utf-8?B?bzJlNy9ZUkFteWZUTFRXQ3NrNSt4VDl3dTdJSGZ1aUw0enNTeXZHbW1RNm41?=
 =?utf-8?B?QXlTdGMxS1hqOWpLdjY2MmZzWW9jdlU0ekViTzdVd3JOeUp4VEVZZXZLUEJa?=
 =?utf-8?B?YnlPaUtHdnd1R2tOclU5bkN2YUNwekd1TW1icldMYWFRODJWMEsxRlI3WExR?=
 =?utf-8?B?eDdLWnk0L3AwYzZ0RmFqbk9BVG9GNHF6R01DdmQyMERWR1hCRE11S0pHYmY5?=
 =?utf-8?B?RnBEZGQwYTFURU9QTXJlODlCRS83SDJRMHVCM212UlBwTUY0c1pGdVZ4Ykpl?=
 =?utf-8?B?cFAwMjRnQUhxeERJeDByYnEwRmxlQ3dEekxqRmt1cFUrdTcxVTAvd1F6cm9y?=
 =?utf-8?Q?dUSPxSovsLaNDu/48p/ZewI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5552c41-ed8f-49ec-56c9-08d9f06c4d30
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 10:16:59.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hmmmpKGAlybrmKyuNtQ/VgnKW3K4yyiLiyokHXaj8gkKCTdskWIyxAYUIAvC706
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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



Am 15.02.22 um 11:12 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 89 +++++++++++++++++++++
>   2 files changed, 93 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..2e8c2318276d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,10 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             n_regs;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..edcb032bc1f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,93 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	int i, r, len = 0;
> +
> +	if (adev->n_regs == 0)
> +		return 0;
> +
> +	for (i = 0; i < adev->n_regs; i++) {
> +		memset(reg_offset,  0, 11);
> +		sprintf(reg_offset + strlen(reg_offset),

That here looks odd, probably just a leftover from the older code.

Without it you can also drop the memset().

> +				"0x%x ", adev->reset_dump_reg_list[i]);
> +		r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));

Whenever copy_to_user() returns a nonzero value the best practice is to 
return -EFAULT.

> +		len += strlen(reg_offset);
> +	}
> +
> +	r = copy_to_user(buf + len, "\n", 1);

Same here.

> +	len++;
> +
> +	if (*pos >= len)
> +		return 0;

What is that good for?

Regards,
Christian.

> +
> +	*pos += len - r;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg, reg_temp[11];
> +	int ret, i = 0, len = 0;
> +
> +	reg_offset = reg_temp;
> +	memset(reg_offset,  0, 11);
> +	ret = copy_from_user(reg_offset, buf, 11);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	if (adev->n_regs > 0) {
> +		adev->n_regs = 0;
> +		kfree(adev->reset_dump_reg_list);
> +		adev->reset_dump_reg_list = NULL;
> +	}
> +
> +	while (((reg = strsep(&reg_offset, " ")) != NULL) && len < size) {
> +		adev->reset_dump_reg_list =  krealloc_array(
> +						adev->reset_dump_reg_list, 1,
> +						sizeof(uint32_t), GFP_KERNEL);
> +		ret  = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
> +
> +		if (ret) {
> +			kfree(adev->reset_dump_reg_list);
> +			adev->reset_dump_reg_list = NULL;
> +			return -EINVAL;
> +		}
> +
> +		len += strlen(reg) + 1;
> +		reg_offset = reg_temp;
> +		memset(reg_offset,  0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, 11);
> +
> +		if (ret) {
> +			kfree(adev->reset_dump_reg_list);
> +			adev->reset_dump_reg_list = NULL;
> +			return -EFAULT;
> +		}
> +
> +		i++;
> +	}
> +
> +	adev->n_regs = i;
> +
> +	return size;
> +}
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
> @@ -1672,6 +1759,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

