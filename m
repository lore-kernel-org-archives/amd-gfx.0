Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4068AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 10:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A9610EA44;
	Wed, 16 Feb 2022 10:15:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2187510EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 10:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXD+d/RwqeTa6J0Qhe46VXvxbz/GWzKO/4tVXKcgMrkKSgyfZVeY2g4xt0PWQQ3Ur0xZdBxNYwgXvUghHKr30SH3SVTo68wgsUviciWHVWnuAyune25CMgn3KqT+YbDnMtXqmdxSHceUpyI6VdexkHmRY06clFyahrMuIz+U9kxh33VBSR4bL8FuenSrVT+mKiTgBT+dBqaARiK7x/U0SUlmnPyEC1b835U6ZnTD0B0+SGIxerKYMly5bh+bVvJdL2EyuH91Lm5qVDdVMGbhJCvIqEp0691Ti4z6/mHZwdYaj7/RWvOq4xdBmPVlzBGzAIRtERKGHx0NEn1fUJpckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1/E1n8QvRsVaXnTvqWfrWArjVRD7wALApL3RLcvbUU=;
 b=iZDj1ltnkBK7fQtVtWwAHyEBp2Kq1We5PrK5Yf1kbWGenjkGXln6eXv0ZG37gU6GFpZjottYDDOV2y+pZf2lYc9/T/l1LqijPD/YLjQig+xJzA8VMP3WQYtK9zP0afqjH8Fbt60RJiFMtjxbzZdaoWQxYnN65l5vZqEzDd4nFJPvkEIfBYBCSkhr7im967juf15onTSE7zpkpHep1nhM9MD0eLu+9T6rkYzt3klb3qV5ho81W5QrX9W9qzqn+DsjMeX9Ku2jFw5/MPomNiLoaHPesOorr74Y9jwEYaQthWfq67oUe2l0DOt+yRAx22Xa/xA99KJbgVgClAiLmRfzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1/E1n8QvRsVaXnTvqWfrWArjVRD7wALApL3RLcvbUU=;
 b=DsU2BKddk4yMVetsGw4FuqYx20v7WeE0si8CSUgzIbsjoG5oG+bL84CYYqAjh0YkGUFlfwMMn7RgDXqE+whzMmXST70oTHqyJVfUct23cRvVk/z8gOTpkFqBwSdQXJYoXNWszzhy8TMvU95xw8axIeFYlrIc3VJSGVHQVb/YQws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1560.namprd12.prod.outlook.com (2603:10b6:910:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 10:15:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 10:15:14 +0000
Message-ID: <fa563eb7-a0df-cbda-004c-23b10e882a6b@amd.com>
Date: Wed, 16 Feb 2022 15:45:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c40c99a7-3460-488e-bfc0-08d9f13538f4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1560:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB15600A84F667A874FC553A5897359@CY4PR12MB1560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0pALQInwrBKpofmUCWi/zgf7hGJuDIFZZWzejiOKgTY42Koo/JMJ8nihPDkem4RXQnj90ah5HTZ8PbGYy3fCmyAqTqjY9x2NYE9PUk/TQQhQsXzmGOHAqdOUUINDY/Jf010bB4Vi6xeZ5x0QbGf4uQY/bZ/++wLd+bq+9G5w6B+boWNjMc3WyIXucCMCtRs248kZPfzlSpkJLnQkEjP9fzhdGlj8DnNdTWWLrz1Dbp+/er9TTYku2jWU1ucZm2odrHBVXn39vK4AzrBx6uqXuCtMDlFsGv/skw/6NT1rjfjz4DcbOsiI8B+TXJ88uDHLppIM2KXpDSHOhpr/Qf0C5QV88f3+38Mym5Yi0FJjTO/3BFnHJwRZevLX98l2r7zbFp2/6bdSJhPOysNNz77rgRMHs35Nt5V2T61cgTqqPuzOlbAgD6DgOGEKXrSv2VD//niyJaDMLzgUf9oxDGyQh75UjO+WaaQRAv5Dzd9FGy/OscXFRsZis/tGpsuX1Ogj5CCqRzIohY4TJ8Ut7U6aXVxEtlWY3DeRItbsHRK+o9ZIjH3Y/qVqypPM0PGpghSxCw+r/jwmYIK9gvb2S5wHAFKLxpuyWEkUmAbTvs6jNn7XSMLpby5VNljzkmhp45zKqdefLXlpmLOfoDTiFOHRzqZjzRNfBGxpW7WmycGDO7WA6fWT9VgAcfKOebWpbfcd2oLtrlTKPQAyqtFLyA2yMnjvbWjtKRJCiJs30/la6Mcwf3KoVZGz/dpoXKT+TCY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(316002)(38100700002)(86362001)(6506007)(31686004)(6486002)(6512007)(6666004)(2906002)(83380400001)(31696002)(2616005)(36756003)(8676002)(66476007)(8936002)(4326008)(66556008)(53546011)(66946007)(26005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGplSzlwWVFqQzlBbVFyNW1UZGFhQnV3eFJMaHBxUU8yeHU2dlNhL3ZQVm94?=
 =?utf-8?B?YUZzTTBrSlBnUVdFZ2lRd05qQWdkZ0k4aEtSSEYvc3VhT0N2Q3R6dkNqZDFl?=
 =?utf-8?B?eHF6cDM0MHhTdjhnTFVkN1BGc3VzM3BrZXRCTTVpaExmWStGTEFHZ3RkZk9m?=
 =?utf-8?B?MHB5RWhsd1JOMHllcGU0TG9SeVJteXpZMlNzTm5uKyt2QWdjbXFJaXhxeGpl?=
 =?utf-8?B?Y0xFSS9HSTBNTjJiZXdHTlB1cTVxTTduTDJXM1RhUTErQVNNbTZUSzVZdXJl?=
 =?utf-8?B?U3EyVTVadTZ0TmZnSnQvYjVNUHJxRXZLNEFLYnlaOWxpSXAxbWFSeHlOUUl5?=
 =?utf-8?B?OHNWN3BVQWYxbEFBdDFrUE1nQTRnbjFqUkJMcUo5S3V2MnZQOU9vRkdjQ2ZE?=
 =?utf-8?B?UVJPYVJ6SmxwZThBb05TMEdBeEd3YkdYU3lja3BWMWd1WEc4cjBudWx4Rys3?=
 =?utf-8?B?SGE5RVR5YjByTkIwaFJ3K3V0NXRKZG9lMGNuT0NSZnJFR0drdGtObkU5azJY?=
 =?utf-8?B?M05NcVRRanlzUklvUm51SlBTeXVsbGtrSERyTWhoTXcyRkdHalY3b0JQS09Y?=
 =?utf-8?B?YjI5TmluZzlmVXdjWXRpdC9sU0l3WHBlU0VCWVhUeFhSZUt3T1FCQlNHOEV1?=
 =?utf-8?B?MVBKbzZRV0RuRTh3SGJ0OWhqRU81Wlk0MnRTb3Q0Z3RWRTlsRG9uaUt5djQ4?=
 =?utf-8?B?QzgzTjRpNkRVOXFrOG9lY3MwQUZxbHBwaEIzRDgyYjZWUEZxbVVrRVFPWDd3?=
 =?utf-8?B?N3N2TE1HMld2bXl6VitnNDd1NTFISVduclpQMDQrS1ViUytRWnlsQ05yOWZM?=
 =?utf-8?B?ekR6UFh5Ly9iSlIvOEV6NmU1Y1pFeGh1UEVsc2d0R3REVHpieUtOMDczckdJ?=
 =?utf-8?B?b0VXVjhzcmFCNFJlVldJZy9UU1FsaGtHZVNyN3RLdno4cHR0VURocEQ0VnlM?=
 =?utf-8?B?OE53UmhQMEFVV0tLbmVacldFL295aGFhUzhuNkVtWGg3Sm9lek5pamlSdHN1?=
 =?utf-8?B?WWh0blBhTjFUMm1vSlp6enNPQ3B6UHhaRjY3Q29ZR3NvM2d0c0hrNlpuekhD?=
 =?utf-8?B?VUxmZ2pMZTdYL1R4K29NR2V4Nzd0QVdBOFV5Tk5iTHdNS1pVWE94NnV4bjZx?=
 =?utf-8?B?aCtDZW42UHRoRnFSUUxQMmZoTXpDT2tkcDdGOWRBcy96VkxtUTU4UGR0VnNL?=
 =?utf-8?B?SVdac1ROcDFxUy8rNWFmaEpNMis0enBNb3FuMWZPWXlKZXRZZlRjdFdFMG50?=
 =?utf-8?B?bVZQWHFlbDd4WTIxeE1aU3NGNDB1MTdYcG1qaEhZRTBDT0lVRGRNVUdKdnlo?=
 =?utf-8?B?V2xBSTZ5K3NkZnZjWFVMaU1VdFFZUG5oVWZMN2lhanlGQlpuQTF5QmVnaEtl?=
 =?utf-8?B?S3E5YjBrSUttSldNSC9HRmZSdDdHZ0NUdWdXQXU4S3pERlcyWDArK0l4ajhD?=
 =?utf-8?B?SXF1b1ZGL3ZteUNTUDhrNFB0S3FCWVVUelhBTVdJdTZFcitiRTV4VThNOVZQ?=
 =?utf-8?B?ekcva3ZqYWRPWjF5NWZpU2tiWTREQXV1ZWh5Vk1abktRU3gySFhVQlIvNFI0?=
 =?utf-8?B?cFdEdUlDOTl3ckVIaU9PbWNHMjhYcWx1R1hTV051MUdSVjV2S0tHejdBc0gy?=
 =?utf-8?B?UGdVVmhEaUVabGxnVklEK05HekwrV1JjbGNEcDgvVWd3clF1MG0rcnllQ2xG?=
 =?utf-8?B?YmorcHRDdWdzR0dhdEE3R1duK3IvbEhOc2d2VFIxYmtKdEIwSTVNK3RiMGZv?=
 =?utf-8?B?VnF1Yk93SGp3MExuRmdoN3AwWVkreXRNY3YxaEljNGd6MVR4UG9INTU0QTBs?=
 =?utf-8?B?anJVMDl0WCtaSDFFWHpRTEF4WGRQRmNUK3JKSmJQQS9USW9Wc05GeU5wNHZn?=
 =?utf-8?B?RFUrTkRldDNjajdKMnVLeURiUERGVU9VZnpuMjhpNW1BSVI5a3ZkS0Z2Vk1r?=
 =?utf-8?B?Ri96cW9ubkpPUG1WZTl0clkxWjlWS3oxRVh4WTVWZXFaRU41dzhyRktHK0xi?=
 =?utf-8?B?cXd1Zkx6Y2tjS0tFYkNENnhxb0RsSlMzMTRQczRCL2x5ODVnYU9Zc1MzRmFR?=
 =?utf-8?B?QkFSbno1QlA3YWFYNjdwYzNkNGtjdXUrNlcvYkhTaXRKUGZIYlhhNGZiTkJX?=
 =?utf-8?Q?IO+U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40c99a7-3460-488e-bfc0-08d9f13538f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:15:14.6072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWcJun0gSxEX5U69NtoHXjmqfANJT1MXzAsS1trji2tW1U2UqgKr/zsYzj9Rwr7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1560
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/16/2022 3:19 PM, Somalapuram Amaranath wrote:
> List of register populated for dump collection during the GPU reset.
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 95 +++++++++++++++++++++
>   2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..57965316873b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,11 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	uint32_t			*reset_dump_reg_list;
> +	int                             n_regs;
> +	struct mutex			reset_dump_mutex;
>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..faf985c7cb93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,98 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
> +	if (*pos)
> +		return 0;
> +
> +	if (adev->n_regs == 0)
> +		return 0;
> +
> +	for (i = 0; i < adev->n_regs; i++) {
> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +		r = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +
> +		if (r)
> +			return -EFAULT;
> +
> +		len += strlen(reg_offset);
> +	}
> +
> +	r = copy_to_user(buf + len, "\n", 1);
> +
> +	if (r)
> +		return -EFAULT;
> +
> +	len++;
> +	*pos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg, reg_temp[11];
> +	static int alloc_count;

This being static what happens when it is called on a second device?

Thanks,
Lijo

> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		reg_offset = reg_temp;
> +		memset(reg_offset,  0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +
> +		if (ret)
> +			goto failed;
> +
> +		reg = strsep(&reg_offset, " ");
> +
> +		if (alloc_count <= i) {
> +			adev->reset_dump_reg_list =  krealloc_array(
> +							adev->reset_dump_reg_list, 1,
> +							sizeof(uint32_t), GFP_KERNEL);
> +			alloc_count++;
> +		}
> +
> +		ret = kstrtouint(reg, 16, &adev->reset_dump_reg_list[i]);
> +
> +		if (ret)
> +			goto failed;
> +
> +		len += strlen(reg) + 1;
> +		i++;
> +
> +	} while (len < size);
> +
> +	adev->n_regs = i;
> +
> +	return size;
> +
> +failed:
> +	mutex_lock(&adev->reset_dump_mutex);
> +	kfree(adev->reset_dump_reg_list);
> +	adev->reset_dump_reg_list = NULL;
> +	alloc_count = 0;
> +	adev->n_regs = 0;
> +	mutex_unlock(&adev->reset_dump_mutex);
> +	return -EFAULT;
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
> @@ -1618,6 +1710,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	if (!debugfs_initialized())
>   		return 0;
>   
> +	mutex_init(&adev->reset_dump_mutex);
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
>   	if (IS_ERR(ent)) {
> @@ -1672,6 +1765,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;
> 
