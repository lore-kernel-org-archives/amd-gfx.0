Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C0CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 07:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30A010E9C4;
	Wed, 23 Feb 2022 07:39:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD1F10E391
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 07:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1osy30FFe3FZXj4TilB97J92Yu42p2W2Ee+RQEk4QIFegqLU4FHFG43nZEXp6fDg6Bs0BmX/rWggHcy6tVPAjrP9JYQVu1VQVs3J7gqXYBoOZrmz0XvUok4Q1HZIwahSqZqfhZtcgPrB90m1WTVGpTMDO3J0oBrOPnpYtpH3GuKiOrTp11jPOpwbfYfQp/hDSK4ritTP5Mhs2jSO5NIUgdcVz2Gx/V/3BoP+ggM0TlRDGkRAh21bBrNcNaw0jqV9LKyRyvwodtw/yFxF5RNvaRqVET35keAOXpWbneD/OnBgEA3AwPe/66yvvri9NbWTQWS87Mj+2RdJqS5nHNHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RVNNVpgAcbtmoo69xlmgBEh89gLZxYD1MgORB6OXfQ=;
 b=NynXkXiKd9LxDNRnOcH8xdddTXHcPOxuqHzUhb/Wz2nFkSjFC748otx6ON1PHtDDR1xGr9TovUv2xTFqDXiMg0YKjelFu1XtVruSYILGQlf1iXYl64nSOo/eOteHyTcIu+ga2HVp/P7CAhZYgFTTn+T5MxDHN38LFY3yJ/upseqGaw/yFeJGnBibzEGWPQqE6cDlb9RhlbHYBACqBRNtEfdNRQA2vLcUFBoIzPTj0MvmbG4lv3dwlLxI3hNYtV8dcw0OBhs/8x/Px77nc/LntwfnZiXs0KYzfePbZswE4qKgh3Wve51ITt3ZJSHzfMjOQzXqiI1lOd4nPUMlq3iLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RVNNVpgAcbtmoo69xlmgBEh89gLZxYD1MgORB6OXfQ=;
 b=qgyBwFgkSQttfAQ7sJeDdwVlfeTn84UK7F1lxgb8jqmlSw7HFX9CuVjpr5XW328UJJkuXl4tpQL/bzW7FOaOfC7JKI3UEcRbR95OD6ElYogIiZONhTo9Pe+dYhJFiu5bQMK5LHUB518E1327FH2WGFIJpKT1uT0LyCQMTBqse18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4648.namprd12.prod.outlook.com (2603:10b6:610:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 07:39:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 07:38:59 +0000
Message-ID: <831392d7-7068-03f1-b6a4-4988565ac156@amd.com>
Date: Wed, 23 Feb 2022 08:38:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220223071313.3757-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220223071313.3757-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c3e4c3-a687-40c7-b1c0-08d9f69f8de4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4648:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB464844471D9A220F382E1719833C9@CH2PR12MB4648.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buAFXU6ReIG0NuEI+jFZiJALcP8w7vX9D4MIMuDCcHo2eK6QQ9wwzfoESFBQanlN9J77NG8Ity/e31YQ4O26gT8u4zTmMGrhKxenuJAzVng1xR8xAeomnRVRLOxZ2pzt/IOPg8woKVTjkKHxK7Os3v1YlKkoWkFJTAt6YuIzul6p01RBWnuknGnvzhXB5PkGgYiLSbh7hR7Fw77wKIt3cTde6UcPjBGGp1CZKNTDI8J8rR6Ny9jr9jM2K/8VgetzRas1Wko0p83wbBqa73NJnfR5KmfiwdthwRyxpbPv7emmormO0nMdLmWcyircIfmKI86DJ9ijpvboYZDVntTSxo+Ff0dYKc8QDoR3Q2VonZUFHfSwbgp05Qi1bqoQcZkwpYF36tA4wlyu36KB1uiYGOYYkvxn+P2pw4x4HEkOBX09l9mgryfbzVMmjDFh+NNsHPph4IEU6ieU6ojajLT4Ef8SHMVgrcDR1OpgPw1hpfo3uHANZKaMTtybFniMOPrzGdckVOX81xqdrU/BkSb3KOYxYYZowSqnpqXO5Kj+6MK3fgKg6ElhjJHZmrN0ESsCQtXPwAYVkOriY6FZOFPRnpnK43J6hPKLK8A0oB/X+oVwDKHmu4Ecac5GrC3uzz8RBgIwaUpIHNO04t/xOvy9/VLEr0sEZFEZ5V83av6KUzyRSd/Kh95thHUkxwetA9IcyMXcwjlGzM909neBQLz8NagZ7zFEkoGpYF+3XI+gMq9ZlhHFNSQsE+Tf/TNinooj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(316002)(6486002)(31686004)(8936002)(36756003)(6506007)(2616005)(6512007)(508600001)(66556008)(38100700002)(86362001)(66476007)(66574015)(2906002)(31696002)(66946007)(26005)(186003)(83380400001)(4326008)(5660300002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtCSHFpNXdFdjRWbkQ2Rm9ZN0xNZ0RtZ1dIT2I2MzJOLzdQR2lTRy8xODF4?=
 =?utf-8?B?M25PWGswWVhpTktUdTUxek5GK3NvSVg1cWVGdGhSalphWUFoTlZ0S2c2TjFE?=
 =?utf-8?B?T0Fld1FwWkFDRUZCYmsvbGk3dWloNXU2a1o4dXdQbWxjL2pLYTNyRENKV3Y4?=
 =?utf-8?B?NS8rWWRLWnhYUitlVldzRUo4aVhJK1MrbnNWcVMvUkhVd0Q2ZHJxM1FrcU5S?=
 =?utf-8?B?TDhQeWxleU5OaW41R2E3MFBPMTVDK0JyKy94ZkpjeVhBdGtMcU10N2VXSldW?=
 =?utf-8?B?b3JtT1VxbnVDaklNSkVNQXB0ZnNoakhEYUxIWUxWOW5RZi9tVHpmOEo1ckFu?=
 =?utf-8?B?dkNUUEJheFlKdlMyZmZPTGNyak11Z3FOOE85NFQ3ckxPRlVVMzFUOUJua0lk?=
 =?utf-8?B?anNJNnBvQlF4N2Z5Tk04Nlp6ejlZU3EzUGQzUTdwMlIrTzRlYXJYUEh0Z3pF?=
 =?utf-8?B?WnBrTDVyKzlKU3V0V25RTk1rNHVKc3lyV0lXYXNCcUpYdlhhQkxUbE51NTln?=
 =?utf-8?B?Slo5NXpnM2tYaEs1RHBBK2dCR1NSeG8yUU42Y1F6bGNRS3pxQ0M1VFI4ZlAy?=
 =?utf-8?B?Vm0vQzRENFZBUkYycUVOeDF1dEdHUmFxR01malF6NUtGcEpkU2ZOY1p1K2xU?=
 =?utf-8?B?ZVFhMlNuY0taYno3ZDJnSzRSMEZ6OEh3aC9PUExUTlF4cytsY3RQSXhLaWNi?=
 =?utf-8?B?UFc3ZFZTdlQwT3V4bEJPTklnWlMzUXI4YjhoaThSYmU0andZM3QvM3RZVGM5?=
 =?utf-8?B?eUdMbDlHK0VjQjdJUmIwaVdVclNOVEZZVHRDa1JwWHRpZnNyVkpkMUt2M0Rv?=
 =?utf-8?B?WHc4R1ZUY28vK1MzL2NjR3BRTEpZcktsM3hZTTBkS0N1YXNOeFJ3TjAzWEpr?=
 =?utf-8?B?aDBpNVM5U25kVlBuMUNyekFnYklaRklrS0ZqMHlIaDZoUGd2T3RwYW9BbFA4?=
 =?utf-8?B?YzBuR1oySXM2aXNEcmtwcmtQc3kyRnVHM3RnTWI0UExpK1FNOG8xci9PR29q?=
 =?utf-8?B?Vm1oR2dFdHFwbk0wTDJIT2ZhVGhmQUwxTlZIcWI4ak8vZXYzRUlJOGlTZmZ6?=
 =?utf-8?B?MFRZVk4zRzc3OWxDdll3MXJ0YkI3KzVIMzhlZjRXaitNREZEcjFxclFFTzBL?=
 =?utf-8?B?TERlU3FPNmJ3M0VUTkU2WWZURUFvWE96NDhOOGo5NUNNTzBGZFZHbjl3R2VG?=
 =?utf-8?B?aituY0ttZ2NNWFpUd1Z5bUVUcEFtcmYxRTNGVGRDN0VYWjRkaVVaZ2Y2ek5H?=
 =?utf-8?B?cjJab0xRbWZmTDM1YzRXcE1YNDJ0K2tzOWUxNVdNeW1aSFBKaUdPTE9VTG80?=
 =?utf-8?B?dDdxckRlckc3Yk5oRWROdC96QjE3VkRQVlc3YW1xUDZ1YU5naVhESHkzWnhU?=
 =?utf-8?B?YUdQVG9EUTE3UkpmY0ZQYXQ2V0czL0tOb1ZJTExjVkh5S0ZaNGR1bGVmL3Jy?=
 =?utf-8?B?SDNQTUFZcEJaMUlKd2M4cGFrcjcyMlJpalMwS2ZHREl1cU94L3RMNWRmYXZP?=
 =?utf-8?B?S0NVb21ya1duR1pVdzA1cGpwdk5ld3RMK0JGNTdnMU93NU5wN1dzM3dQbUNn?=
 =?utf-8?B?K0dBeWhhakxDallKRG1Ca1V1ZUNjc2JoWVBCbGFtSlNSNmhPL1p3U2dseFAr?=
 =?utf-8?B?a0Vma3VLTDhGNDY5dWU5V241UU4rSWVFUUxVc3FtMWJxWnhPOG5vcUtsaitq?=
 =?utf-8?B?ZUpwdFZGWDB3VGxrSDJFUE5JSHhSSlZ6cE0xbzZxeVFxY3Fub2VHTVJYM2s2?=
 =?utf-8?B?UEFEZ3NkWVNFQzZ2UUVlVEQrUFF6MzdyeStiYm9rWVA0TWNjbGFmVlVMNzRw?=
 =?utf-8?B?cFN4Zysxc1FJVmlodE5yNDlHbzg4akt6S01VRDhPajRNODhGNWJqRGlxU1Fq?=
 =?utf-8?B?MU9RbUh4dWtOeVZacHFsVjJaWDZqdU4wSmV6UnhQQWJvVWY2QkdNRFZSSVEz?=
 =?utf-8?B?MFVkWXZ0MTNpU3U5NEVOZERybnJYQVVhd3NFbEhxUktuellCeWxPdlM1bHFS?=
 =?utf-8?B?bGg1VU5NU1BpRTdrSXY4TUVGNWVkY3Z5TFlJSG5CSlYvVEdIQVRMSTlMd2k5?=
 =?utf-8?B?MER3VlJnZ1FsVzJvV3NOK09McStqNWcyL0V5OVBOTU9CdUtad2hEWGxRUmVE?=
 =?utf-8?Q?7KC4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c3e4c3-a687-40c7-b1c0-08d9f69f8de4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:38:59.5599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY7AwUh++Izmq9SvGphoY5nNI1INBH8o7SKAYW6H/y5Ttpivh3TxGNGWfYzPpI/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4648
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



Am 23.02.22 um 08:13 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 82 +++++++++++++++++++++
>   2 files changed, 86 insertions(+)
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
> index 164d6a9e9fbb..b91f21cec269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,86 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[12];
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	memset(reg_offset, 0, 12);
> +	ret = down_read_killable(&adev->reset_sem);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		sprintf(reg_offset, "0x%x\n", adev->reset_dump_reg_list[i]);
> +		up_read(&adev->reset_sem);
> +		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
> +			return -EFAULT;
> +
> +		len += strlen(reg_offset);
> +		ret = down_read_killable(&adev->reset_sem);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	up_read(&adev->reset_sem);
> +	*pos += len;
> +
> +	return len;
> +}
> +
> +static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> +			const char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	uint32_t *tmp;
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		memset(reg_offset, 0, 11);
> +		if (copy_from_user(reg_offset, buf + len,
> +					min(10, ((int)size-len)))) {
> +			ret = -EFAULT;
> +			goto error_free;
> +		}
> +
> +		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> +		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
> +			return -EINVAL;
> +			goto error_free;

So close :(

The "return -EINVAL;" is erroneous here. That should probably be a "ret 
= -EINVAL;".

With that fixed the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

> +		}
> +
> +		len += ret;
> +		i++;
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
> @@ -1672,6 +1752,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

