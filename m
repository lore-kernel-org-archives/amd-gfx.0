Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7ABC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 10:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E044110E4C5;
	Tue, 22 Feb 2022 10:29:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC5B10E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 10:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEeX/M+EGpB4cvBE9dlQYTahwwnYc+7A1/yHIY6xq30kK251y1zH25Nf0G0uGRARDOgVXxYjzMQuRGzwN9CnUtccrR3/lrKOuLx5OP4qbEMlFIXSYfvMyY7XPq6Tnb1ckzMrnBQ+6rtiMLnjMxkdl2fS+9gFAgB6BGlWy5NlPdqPETDKDfgAw3jfm7lnViHPb01jRN/Tz9glYL+x5iCbWQxiNKzazhNFGmCYsWSMGw7E3Qw7mG+00cy8L42r2eyk2eNyYCz+AmRfxjel1PN/gEEMwC1E6ibwdEKDkrvMp/AHioptpcmZzwXcb9Vk3BtbrmyxwbMeGD3dU9+UncKdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8ZtRYjspCwiDSK+We8vIWwuqTlvYVu8fDb+a+joUKQ=;
 b=NN/7vCjHTKkB+hyWRKLdNjuNKfxnUm4L5JuSgEWnefiNKCAgzrbxv3ps+iMu7LasnARE+KJCLEgw8VCJG9qneXIHE1812fbGQtyXtH/1jOoVUGPWxItM58m7IHGperqhW9KlenEAEI/KCJhL02CBh/Z4qkRdkGzUTVl0sI2hnllaSJGRRN8ysTyMXjVvt/9e6ObitYukdGNvn2AtJ8n+0NZpYhV+W/jKrNWa2UbB2+KQRZKGPdeuIfB8jE4Q1118F96MG2La3jE1rL6LOgcRG9rmMYQwadUrXA0Adw+PPSVutRepEmMU1MkUZpZHQpb/7UsNXwyY6ZgcW5v5pNAbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8ZtRYjspCwiDSK+We8vIWwuqTlvYVu8fDb+a+joUKQ=;
 b=TL/+yDTGTudXD6m73V1E+w+wUGXPSMNeDAT1ZstBguVpTV1Nw/EwzHrCV9qUtZ9PzoOZEQW2hbphJTMbRNqpDYqmDMjpR56dmOmpnBedoczSeKmIrP0RP6JJ94fCwbyN5LLgdkXVf+BX2Tq/QsfoRWINHqWK0zQXZNx5/THxIDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 10:29:11 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::d56d:98df:8ef5:14f1%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 10:29:11 +0000
Message-ID: <917db7cc-d33f-95e6-74ad-8eaddd8623bf@amd.com>
Date: Tue, 22 Feb 2022 11:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220222093559.2829-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220222093559.2829-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::26) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1610217a-9fcd-4710-df82-08d9f5ee2a2c
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5456:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB545636F8A845FE7CE6AACBC2833B9@SJ0PR12MB5456.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNVfFhmFF3cf8AwnuW7fRUxUMxuRd0uVL/boaw9/BBlX0v+K79MpW8LLaMvRFcb8akO6B1qmys+IRthmudSAKqcbjIXhJdpFX9wMN/tbTIrqJtjBB9rJ/1Krr/uWbPdeb4itE5UxfzvKrciUiyHSwN2IQxEZw99Wkcl8PcAv+h3z80o0lUWp9oQVEdHzVd4dnmX40nMC1NRvecgJN8YUGsb6zd07EF2QYjNorcoCkWDhd8sIlo8uxtajNU7bNB014Y/ScdzVpw00DXhpWNBlLxIKQ96cEX0taZvg5KTlVhF2SRPHRS47MY56CahhWPaEFQtL/qc+CaYwYPDbfSsWuXk2ga59+gMIOp6DicJkxd755/sSa6XD4uWRd65OMBXQEAV5HyntTl6AxTmph3rARhVQyCrgYfQMlzm1JTGuweX2er7wPPS0k6PZPtlqwNp0jxQXawsZpNWKAfGISBMHAl9kG91w+MF9S2wkMSF3cwqmpI1fXKWpK6grKPO/FqxNign4Arvq3e1CX7/MsHL6fjlwH/E7H67lGHdU7/VOeRLr1VQLWkNEXYcDbWQbTmSxPk3hO+j3KbyAlqrWHcsFfvNvIpgR8OkTySBoLzz1wjI8DpbgO0z3T3azqlbT4Mpnds+qjhQT5fNi5ijYPbsCCv249PscTA9x+mHkJNuqqHU1hXMqcEt0U0hFxNhnaSvHarTMAPSeM3nxNMVcthi61HxA+qS+5doq9pVWo6WbDdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(66946007)(66476007)(66556008)(8676002)(4326008)(508600001)(6486002)(2616005)(5660300002)(6506007)(6512007)(186003)(83380400001)(38100700002)(31696002)(86362001)(6666004)(8936002)(36756003)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk1CQzU4QmZwZzJWSFRNR0Q3aXlmbUVobUxld1EvUlNSb1JrWXBYTStOVzVC?=
 =?utf-8?B?VWdtSDhGb3lBTFhhOW5kOHgrd1N1a3pJakxkMFVNbEZZRXJEN2NRaGpZNEkx?=
 =?utf-8?B?RHRaM09WYkJ2TVlweGhVZkZNbUpOOUhqdHAwQnNXUWFUcGNUTFUzQ1FSZHUv?=
 =?utf-8?B?b0paWkVtVkpmeU5CaTMzUm5QcXB0eHZLcGFqYWlmN1JFYW5FVjRuN0Uxdjhl?=
 =?utf-8?B?VnFuR0g3VS93Zm9tTTAzSExNSjhJSGllZXZoeVlaQXlITjVwM0xacnZ4M0FX?=
 =?utf-8?B?K1pDRHJUMXp6d3dZaG5CQ0xxVzRBK0dMTVM2NFh0YVdBZkdDUk15QjVPSFdV?=
 =?utf-8?B?RG5QYWp2TnNFUFBPSWpFQk1MaENlRWlhNEFCN3I0MDBsNVpFRHQyd2oweXlj?=
 =?utf-8?B?K2c0QThNQTZOSUY4RnU3U1FQZktseDNXT3BHcUtvemtXS1RPL0NCd0xjZVlu?=
 =?utf-8?B?UE9XdDJIcmVkN29uSXcvTXVtaURINFdvUldpN3VsSzZGZDlvR0UyMnJUR0lZ?=
 =?utf-8?B?Rk9FbHI1VWtNQmxSWHlWVFBXenprejN1VDUxeFByUlZ4MEZtd0ZhQVI0N0VR?=
 =?utf-8?B?b1JaR3hvVitLQ2dBUVEzczJXb1RhWGRtWnUrVFVGcFB0UUVzV09HWVprekNL?=
 =?utf-8?B?cXdlbjI0MWhhajJSM1ZheDRmdXFMV1RrNTdtdGxzQ3c2Y1JheU5jYU00ZzIr?=
 =?utf-8?B?Yi8wb0FmL01hQVJmVEQ0b2dDM0VaQU42b1BTbHc3TjZVWlREK0pGWUhxVSs3?=
 =?utf-8?B?R0ZIVldhY0NSRGhRcWI2bUNrYkY0eEduNUxnSlcweEFFYzAzZy96YVVZRDE3?=
 =?utf-8?B?R0d4YjZjVGlHUzdFaTNFOUNOc0tZUEtjcU0xcENZMWVabStnUzlFTDEwRDA2?=
 =?utf-8?B?RHlnckhaMnlzazJmSjBkZE1aMTRFaW42MDkxWWJUZzcza0J1L1pnUWxuWmky?=
 =?utf-8?B?SjFVZXJWUVM2cm1VSEZGZ1QrcE91dlJzWnFyeUdtbzh0YzR5dmE3c2hIaW9p?=
 =?utf-8?B?bE9RNkJ5L2N1dzlxU0hpQnJaVG1nMUtkWWRtRG5VZEJQaWUyMHQ2aDB5OHZs?=
 =?utf-8?B?QmpCQlFUQ3VCbzJTLytqNnZBQ0dHTE5TOElHYWVQaTdHN21BWXhHSlVCVGNv?=
 =?utf-8?B?ZUZxbHArMDVqcEIveG5NbkhHOS9uNC9mQTE0V2UxdExscnZQdDNDNnFRRGg4?=
 =?utf-8?B?eStKWWJTWUgxL0ZBSm5sMjFCa3FMbXAxMDNJYng4VE1vaWg2SjVnSHJhdC85?=
 =?utf-8?B?QlpwZEtrTjdiY3UvNVlYak1sdzRCcmZnOEV2aGZ4b1AyWllOQ3hXMmN6Sk1m?=
 =?utf-8?B?cXN6V2dDZGpKeng2ZnhTdG5wMzIwRnZVQnVLS3JBbW1Bb25mUjdOMmFXZkpD?=
 =?utf-8?B?aGxieWFTbFRUQjAxK3JEeVFIdmdvRGcvMG0wSjVkZjk2bHJoNEVPVlZMTkRZ?=
 =?utf-8?B?emtiRlcxQlF5WGkxUWNwWUtXdHFuNVVob1dBbEJLT0lYeWU5ekI5WWgwNEVN?=
 =?utf-8?B?S3haMG5LTXJGMmJDOEpsWEg2T1Zia2N5dEM1WE54MUVORU1IcXo2TDU0OTRD?=
 =?utf-8?B?SE5WMTU0SnBzYmRMM3V5ZHBralphbFQ4a04wV0FwWnZtSUk1cjh6QVp5SHQ4?=
 =?utf-8?B?U3NWZHcydlMxYng5Ylo0cnJIOWg2Rm5mUFhhbExIdW40R3UrcHl0MmpoaVNO?=
 =?utf-8?B?L0YraXN4UGhybGdsVkUwRVhKeDNaRWxtLy9yV2FpSVZqc2lONWgrdk1xdHdV?=
 =?utf-8?B?aTBraHZ2bEtieERkZzdHbVdqbG83WEs0bFdhcEROQUpyOGFOK0xTaWVOU0Nv?=
 =?utf-8?B?SG1hM0pQT2xuMzNIaEtrbEpHYmJKWi9UVDF4YWd6QmtWVTZMenJBVHhTRFNY?=
 =?utf-8?B?V1g2ZzFEOFFwbks5QlhtUlRiUGYzaVh4S0tmM2JGTnY5aWJJcHVmT0wxZy9E?=
 =?utf-8?B?MTlaRXNSc09reGRNd2NWNGwwYWxNUjdaOVBENWUxMXJsWnVhZkVIUStlY2NZ?=
 =?utf-8?B?b2ZqSlJ2VFA3R29XLzBsRGtmVEtsUHJuazc3Ti9iQkVlUFowUnU2a2ZVSm1l?=
 =?utf-8?B?cnpVNGZESDBiS3cweDhDUEJLWExsUm02Z2l5Y3NDNDlRb0xGTklyMUxmdGFY?=
 =?utf-8?B?YjIrY3J5Y0NwamR6K1kzZEorRUt6UGl4T0lBdnNSSGppTGZsdFk2dFJBQ1Bk?=
 =?utf-8?Q?luUcjDXwZqw8dEMO8KcpwRE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1610217a-9fcd-4710-df82-08d9f5ee2a2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 10:29:11.1053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2jX58tDuakegquMGSNC3ed24Y3e7BSjSGnvA15I/DoS93PjtQTIs7D60AYCHlbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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

Am 22.02.22 um 10:35 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 92 +++++++++++++++++++++
>   2 files changed, 96 insertions(+)
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
> index 164d6a9e9fbb..733ee54efa34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,96 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
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
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +		up_read(&adev->reset_sem);
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +		if (ret)
> +			goto error;

There is nothing to cleanup here any more, just return -EFAULT.

> +
> +		len += strlen(reg_offset);
> +		ret = down_read_killable(&adev->reset_sem);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	up_read(&adev->reset_sem);
> +	ret = copy_to_user(buf + len, "\n", 1);
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

That's actually wrong. The code now drops the lock before calling 
copy_to_user().

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
> +		memset(reg_offset, 0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +		if (ret)
> +			goto error_free;
> +
> +		reg = strsep(&reg_offset, " ");

As I said before using strsep() is a rather bad idea here. The function 
doesn't takes a count argument and there is no guarantee that there is a 
space or zero terminator inside the string.

What should do instead is to use memchr() or alternatively using 
sscanf() should work as well and does both things in just one call. E.g. 
something like this

if (sscanf(reg, "%Lx %n", &tmp[i], &ret) != 1)
     goto error_free;

len += ret;
i++

And BTW: I would use a newline instead of a space as separator. This way 
read and write interface matches.

Regards,
Christian.

> +		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> +		ret = kstrtouint(reg, 16, &tmp[i]);
> +		if (ret)
> +			goto error_free;
> +
> +		len += strlen(reg) + 1;
> +		i++;
> +
> +	} while (len < size);
> +
> +	ret = down_write_killable(&adev->reset_sem);
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
> @@ -1672,6 +1762,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

