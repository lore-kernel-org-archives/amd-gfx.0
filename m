Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3092EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7020C89CAA;
	Tue,  8 Feb 2022 08:18:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0659A10E36A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q46GLgDvmznEzj5FxGdZ6y+EE4wGmk28S+MlkvVC+P+4jet51b0U1+Fp7jW8/jOZBNFVu+Sybpobwlc57ruadzCA+Vwvr6caELeak3lL6Jd82GVC4GWmddbn0qwtcLbVWSTHzzh1ylJa4k9lamw5V+ceed5vbiHFJ8ATO4uRmivOmYi0E6/XePz7I3oYnADlvhRCLUqwlK3YWtBx3hXqfdcylxy0VbYjobEcqyvUD3IW0aeqGQVZJI/u2/TfXEGFl7KiLzeQrYpDdDEpDw0vAJntVO2gxl8WIctO9gVl+HMBtBMx3lZi55fKX9Bx9BLsouH1yqAaM0tbvw5pPW0Xvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEd4qoRKDJjoCwH2qgqGh7yuhYahjlCvxOndk4q0tJs=;
 b=fWUWEPdhVTfyYz/6DHzDoiSOOpOjpnkEGj967G2jBeVKd7hIVAJou9MxevvOUoBUCKxLlUjsgG9MBWkz4DnO/QZtr8gSX+7vjKicRGlwlJO8TG64McYCAqc3fmA7+rZaEpmteUwk4iWs/002BA5RtN0ZndGHCUVmCUr/5PsltBmx1kb9yj7WgIOe2unCnyOpo57A4dpv2obW59A3nX0pNdZXE53DW8RiS7lfcFVwFFj5YBcipntqZkmPLqd6g1DBGHGykEv3vX0h1RY7tDgVibGKBizoANtvrtrz9T8cAtn1U4vEvswnfZrcE2Szl8RYN/W1F5IAJgEQB9ogIVB7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEd4qoRKDJjoCwH2qgqGh7yuhYahjlCvxOndk4q0tJs=;
 b=EbugobXrukkjsRYslbsuBuJS228Vyql0r24KYipyIB8V4Y7qQXLd66DQbVt00WsamziFDYEfeRMrtwzj/CKoM+JkmixO+2/lCM9KY/KNeindmQ7qoQdvbPmtD9o08xG9twASPYuhvkoywussggspSmX2SbBoJ4a8GJtO+jIknYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:18:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:18:52 +0000
Message-ID: <385688f4-2165-ba58-8928-5774a44044e7@amd.com>
Date: Tue, 8 Feb 2022 09:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0088.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::29) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 195ec4ae-48a8-4b5c-4ab8-08d9eadba422
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5052ADE0F13120EB51BEB6F4832D9@BN9PR12MB5052.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNwoWeHiQuNmmaHatviYtGifwh1TUM+mPSsZlbQyok6uU7I+ylMO/D9YIT5iH61btkB9jWVfFbbHQ/0JjM3SF5GewEIXOQL4DohW2gOdXdNzbiR5+Au6/gsfbmiPqmeD8Sabj295k7wLjtju4eB5VIWZ6jsj53Qu+f9UFtda8MWsBT9ytwrNIHmUgguPCjNAOWiXcrZxP0fSCgGl8P4t/EnPvK70dybBN1Z9WeaSYoGc+/i08u2Ms/GtWqz1CExeoG4sDhcfU2R8yC2UE9JqYHeu0ZE7McZm6y3d237Lfa38XrbTM18lkxdVbX+s05QfP/MZv9W8WoxgRz11w1zKpzzhWUhrr2fPrSH4pYoqSiouqTunVFFBeGSzveG1vAh6hHGwWZlKcw9FpG6Emid/rZPIgfkto0AEbCEe6ed68UE1AapNZFj9BjokKUIpQnnqoLdxnX90H0RwETw0RqxeTQiZLi7VcmFq6mG9cVmwmYqZOXr4iZ009WV/Mxm7Y2IhDDj2ntWe1tCIgyWnJG3g+tgcKqUovHzKajtwDs86fcvyh6qb1QbWmW/zSGnaNCiGApiXZPfr8aPlzXnRBYQdTXkO8+bTZyhGVm2BhUGeKgW7v5rUi5pAuoxdFLmfZBgXHS7PvsJb+FGx/MTV9nGcU/bbpzYz8LwTVUC3b9GC9FpKM9jNuJtRHX6vkCzsCCby1KWSbI1oS0TNSx3FG/U5TkUhUgibkGrNmPZAHg/uuUzVWLcZFuByWMOJQ5HvC57w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(6512007)(2616005)(36756003)(66556008)(31686004)(316002)(66946007)(38100700002)(508600001)(86362001)(6486002)(4326008)(8676002)(6506007)(8936002)(66476007)(5660300002)(31696002)(2906002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajN0L0crVFZsbFJDT1p0TFNFMDVLb3I3WmJoRUNRelRtblViNGhzbDBTOHQy?=
 =?utf-8?B?YkdlUE5GSVUxNXcxNSs2WU4rc2s5UUpLZ29Tb3RVRGY0RTZhTnFKTkVqT1pK?=
 =?utf-8?B?bXlxNCs2c2NNaDEzOC9tdit0a04xUkVRR0xlSU9PZTZJOEt5dlQyWExFcTFM?=
 =?utf-8?B?VHpic0o4VktRZ0EzTnZobjlwQldPMTRlRkdzMUFYSUROa0JBMXlLbWhtMlFJ?=
 =?utf-8?B?WFdxMnFMV3dIVjNuZkVwV3ExT1o5cG5UZU9naFRGL21jS2t0UFo2d0xlb2pI?=
 =?utf-8?B?NldvRE1BZmViQnZvbVhMbkpmYUJyaWlDcDlJRTcwT3VHNHhiVHdMUXZLaU5o?=
 =?utf-8?B?VThtWFgwWU5kZHlBcGk5a29hWXJtWlFtUmxNWnZSanJTdkVodjVyaFhxcUdu?=
 =?utf-8?B?enVmS3grOXVNZXdGN2tqeFd4WHdLUzE4bTRBQjY1aDJrV3dBeUZxbGtrY09I?=
 =?utf-8?B?RmlsZTV6clpReUs5TnVIV0UrWVZ6UFltbzFTL2ZGM1hvbitzN0dzWkRSdVNS?=
 =?utf-8?B?L1FOVnVId3pSQzVrQkgraXJPcXloVnF5VmVZbHd0ZGNhWHlvaytPWkM2Uzd6?=
 =?utf-8?B?cm5YVTEvcjdBVy9od1hqUlpBQXZQeHhMSXZrQ2hYM0hVUlhCR2RJOW1JZ1RY?=
 =?utf-8?B?bHJUci9Gck9MSngza204Q3N6bE1ubHVOdEYzQVNQVE1HbmxrNlcvaFBGbVF0?=
 =?utf-8?B?TW91bmFDVTlJdmUzK1VnenZ5MENXVlhScGJ5NC9wcFkwMFFBdlU3d3I1a2Jk?=
 =?utf-8?B?VW1DdFlvb3F6WTMyRHBVelR1NkdHR2l2OW1lZzRSN3kxM2dISVdCYjQzbjMr?=
 =?utf-8?B?RVZramxERmJ1RDZKM2pmSlFQQkloSXFrdGJOVXQvYzVSNGZEVHplR1hOZTQ3?=
 =?utf-8?B?V3Y3WUFUVDVCaGVaVDVTV280aEVPM1E3UTJYVlQ4NGF3d2tHcGdTVzgraFg4?=
 =?utf-8?B?SytqMUZ1cWlSYlViYVRVZzdsZ1EzMW9aZk14TjVVMllRc25XNHoxRTVCMWFi?=
 =?utf-8?B?TzJ3Mk5RTEd3RDhQRDhQbkxJVld0MVBBMjhqb3JETzdOU1lCNGRTcVNBRWJ1?=
 =?utf-8?B?UGx5M2FxUFlONGFPcWdZQ3ZQMHcwZXhaTkF6Z3AzdXNTZFhGODlLclNYL3B1?=
 =?utf-8?B?Y08rTy9YcGZYaTArVE42eHdkelFCUXV2N3hSbUszSC91QmtvUmZRL2lDdE5B?=
 =?utf-8?B?VGpCd2VFekF2b3ROd1owL1Z0em4wVnlHeUI4dktXMmxQT0g4YTJJbVc2aWRL?=
 =?utf-8?B?a2ZxQlhYeXZpMERjUHpPRDRhNXgrd3FDWk5Eb29ja1l4QjFVZFdxb0JKZzN4?=
 =?utf-8?B?cnFYa2Rsdk9zUnI5akVla1JaYmhjREtPWUt6YWhJMkUzaXhyc3FpeTV0UUNo?=
 =?utf-8?B?cjBrc21vVnhjQjVVdWhac2lLYmVJampBTjVPak5sRFBZNWhVTFV0ZjJpMHRi?=
 =?utf-8?B?UWxUb0xiUTZIRXZ4YjhqWkZ3SVZ5cGtCd1VSRXJvU0ZRUzJYNk92V1pneDNO?=
 =?utf-8?B?VEh1Z2ZsSEIySWc3R28xdVVEU2EwWVNsRlpkNUpwbHFGMk84S05jQmNYWm1P?=
 =?utf-8?B?TFF2L2cxdzJ6UXV0b0xCMERHUG1vL2hVbStTK28vZ3Y1Uy9aaFZsVlozbjZx?=
 =?utf-8?B?WlVLVWYxRE40Q0RxODhTeHFuTVIvZEMxK0Y1ZDVuYVI3Y3JJMmtrdk1XOGhY?=
 =?utf-8?B?aVlqWm9wSWJocUQwdkl4Ny82MEwyNW5zMExzOGFGTmRWc2xmUXNuM1RXa0dx?=
 =?utf-8?B?NFVHcUlQWDUrWlJ3dGQ2dUxOai9zZnpldnh4WjFFQXRuaWVzODV3TmZHNExs?=
 =?utf-8?B?TkVoZFZUZUxuakFZb0ZkK2M5MUl3R2c3UnZRTVNUYURFSHRFd2lQSTBZKzdp?=
 =?utf-8?B?UTF3ZjczSlNaZm5aYVd4NEhnWEQ0SG1vL2RYTmdDR2ozdHpyVDlkK2M2QlFs?=
 =?utf-8?B?QkUvYk13Q0l3aVRtUTFWbEZDRHRreEc2VHRYL2xhZ1kwejF6RjhyYW5SL1RN?=
 =?utf-8?B?dDBtUVdZMWd1Z01aREVpcVFJZUlhNmRGTm9CT3prT0VFbzZtQ2ZhcDVtTjJQ?=
 =?utf-8?B?MmZTTW5McmNhcG1lYUtpWWhqdXRndUh2bEZNSko1QXQwOThKdjdUbzhRVWVX?=
 =?utf-8?B?ZTRZNHhCRWduMFVqVDRMcFFJcXY3aHpQckJkRnd1alo2M2xmWUJWdkJlL240?=
 =?utf-8?Q?k/7pfMDDNODkH9N3nuV+TWk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195ec4ae-48a8-4b5c-4ab8-08d9eadba422
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:18:52.4583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i71DWFXaQ2bRDojVo8FRfnW203BY0jo5dXVjvHVs5OIMqJJ3TjEByQsy5S/vNKEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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

Am 08.02.22 um 09:16 schrieb Somalapuram Amaranath:
> List of register to be populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 60 +++++++++++++++++++++
>   2 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..78fa46f959c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1097,6 +1097,9 @@ struct amdgpu_device {
>   
>   	struct amdgpu_reset_control     *reset_cntl;
>   	uint32_t                        ip_versions[HW_ID_MAX][HWIP_MAX_INSTANCE];
> +
> +	/* reset dump register */
> +	long			reset_dump_reg_list[128];

I don't have time for a full review, but using long here certainly makes 
no sense.

long is either 32bit or 64bit depending on the CPU architecture.

Regards,
Christian.

>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..dad268e8a81a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,64 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset;
> +	int i, r, len;
> +
> +	reg_offset = kmalloc(2048, GFP_KERNEL);
> +	memset(reg_offset,  0, 2048);
> +	for (i = 0; adev->reset_dump_reg_list[i] != 0; i++)
> +		sprintf(reg_offset + strlen(reg_offset), "0x%lx ", adev->reset_dump_reg_list[i]);
> +
> +	sprintf(reg_offset + strlen(reg_offset), "\n");
> +	len = strlen(reg_offset);
> +
> +	if (*pos >=  len)
> +		return 0;
> +
> +	r = copy_to_user(buf, reg_offset, len);
> +	*pos += len - r;
> +	kfree(reg_offset);
> +
> +	return len - r;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f, const char __user *buf,
> +		size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char *reg_offset, *reg;
> +	int ret, i = 0;
> +
> +	reg_offset = kmalloc(size, GFP_KERNEL);
> +	memset(reg_offset,  0, size);
> +	ret = copy_from_user(reg_offset, buf, size);
> +
> +	if (ret)
> +		return -EFAULT;
> +
> +	while ((reg = strsep(&reg_offset, " ")) != NULL) {
> +		ret  = kstrtol(reg, 16, &adev->reset_dump_reg_list[i]);
> +		if (ret)
> +			return -EINVAL;
> +		i++;
> +	}
> +
> +	kfree(reg_offset);
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
> @@ -1672,6 +1730,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

