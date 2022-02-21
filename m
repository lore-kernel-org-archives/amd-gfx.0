Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A94C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 09:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777441129CC;
	Mon, 21 Feb 2022 09:16:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE6B1129CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 09:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/jf7wSUI3r7QZsgMaP0R0LdnkdxhhS04KRe2XbvkU7EUDeLX5p5zvdEEevoVHauSkyPCtpcGaDNk1YiOgsqnuMLbMWi+ouYGdtxXIgqhmPldlyyVfoeG6Bc6FBFXoKuah7r0S2loklDEob8y4H25O+bhwrpCW01hgrInbm1EApiEAik6xxig3L9OoNwu6Jav/MZnXk4/oB67lx0Ag537NWqT/Ecu9O/p+Q8nCe4OiXkK4JcxlN3jb+DBdJH6bw5CBfhCZaupZnHhcCV3X2/B0eZVWe7d2kT7mtVikKbuOrnMAfkodz7SWa9iFE2V8mLdYasZuL1fy9rNBlOBKsZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzBVJ4Ezk3FR2zyzi2Z9NRbuf6UKxBm6rhszTKOwe50=;
 b=A1EZHvkrFV1Bc27DXF3YswoVskWhfIEmiSlz/AKqFGtcLFz21+9vXmlF147X5+U80UsnDzcYhg/fZPWbkSttTkl4zXvDzS8VeMm9rhMwjP+tNlFZRagQuqL03uSnbbamBAh13BsF6+TCdfeivR1xgg3u7IaeclAlNI8RBfyHdBXsceS3s1OSk33v6VLOrQE10mO6Pu52hliFuTm6St+4pXDOUSw8oijfdo/gH9ldM4q7FuoFntMHomYNg88GYe3AgwDEn3rZoD0ilwnDbzaW/q8r4zx6n/EcGNCWtooSnTxtd6gr2W2Z762/u0ODelkbAa8DnWj4SpMMvmew8rFAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzBVJ4Ezk3FR2zyzi2Z9NRbuf6UKxBm6rhszTKOwe50=;
 b=YFPHxUQXdgWGrYw38o59l6jGdRnyuRN+xmhokdmW1wQh8XwYbnbC1ZwjEwxe90IHPC25t9YfTN5xYTLtmPXxSYovlb1Z1W2L3sn3jyMFNyMSGj/4QIHE/B3OJjz+qbjxem+y18HhC+j5qXf9MZ8C9+s6vOiRS9ctJ7afVtfdqSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Mon, 21 Feb
 2022 09:15:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 09:15:57 +0000
Message-ID: <a588e193-3509-73b3-b0d6-962c2b72dc4c@amd.com>
Date: Mon, 21 Feb 2022 10:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220221071540.2485-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d46e24-d6cf-41bc-7b4b-08d9f51ac533
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0191EEE9074226ECF1CAF02D833A9@MWHPR1201MB0191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lc417WgUXd1zg1dqE2KsJKd1eWkTi0/UjK/rIiQEU/b/UY2D7hf4lF2sYeYKiv+11eCajyrW16MDKLkK+mYT48T3Fcpi2q2mLbzpLxUvSQM51TSnmD6TTkMJj4TfJeEqiIjNfyayUG+/fnspwa8D8SSfqRtRTgwbWRhl24QsHa4bNUd+P+Wxadyw+VSQsroINVp4XLkFTc7CGtr5UPb7xKtARketjIWdRh4Tk+G1F3SY3OAel4w1MtSPaswCOI2Pc+xdOYVJOYXeNRD3a+4lDoS2fiu71YS0nVSvuwopV/ZgWtnvJZK8et3HP4az8eQG2u0UEM6KnG1jklOQ5rF8amvsBchF1pYUu4zO1GtyY5/qBT5BIGpDzeIjbaKKdD/i5UrBFD0qi+9Og71U3Bkl05XBUMfTZm6krUUY+ZHD5AZPrF6NroxSMBuukl5nCCocMPSXPUYvB1AVYYB14xep14ww0PItzP/adgLXHlc4TpQAGpFg8glhulVBLlI0VIy6vycb1lQ4rRn4XLq56QOhojLJp2SbsBLWvCHhCm9t9Bp2np6XzZQbrzKHr147uSCYyC2iSlv/OlocUaAAnbNFHj6Xg+3BDPMplaD92CMvxO1druq0yxG9mDS+63Tx7XPM471nRIg+DNw54INkSIRkPhJsqdNekCWpx/OJ4yw1S25/oDLwln9SfLOn/hiy0RcWHJhuVE/27Aq/LXJhCnepjbAKLqetaAiU9zKBTwmTowWF/0vXEmtKoPvzkBvyzQoe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(8676002)(186003)(66476007)(66556008)(508600001)(26005)(2616005)(6486002)(316002)(6512007)(38100700002)(86362001)(31696002)(6506007)(6666004)(2906002)(83380400001)(8936002)(31686004)(5660300002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1wOUdvMU0rU1N4aUFqRGhkeEpSTVBhVXFXZytmVmppMDhGT3VsZzJqUlU3?=
 =?utf-8?B?SkgvbUFkVXNFRmVQbE84dkczR1FxSHQrTjQ3enFXZjlJQ2VhMnVqNlRQeUgz?=
 =?utf-8?B?Vi9BSFYwOUxTSHBIc05JeUdORldQSFVUNSt2M3V0L0VmdGQreUJWL0dmTFQ5?=
 =?utf-8?B?LzIyRy9yclR3U2ZlSEFMV2RWNVlCejBSUlQzSnMxYlJ2WDFoN3A3cFpzYzdZ?=
 =?utf-8?B?MlFhUnBYdmRJcU9tSmdDV2ptVklTUzI1dFEvVjdsSDBnL25CektaZEh2bktI?=
 =?utf-8?B?cjZ3c3Zid1hOQ1hrR1hrNjZvMklwbVR5WnNOSHJaTERTVjRiN3ZjVTJUNG51?=
 =?utf-8?B?NGVzMS9Ra2lnbVRNVThTN3Z3YktaOTlWaEtPVkllRXBWUG5HMitwWEVKRUdn?=
 =?utf-8?B?TURGYWUxTENXVW1QKzkrWUtRU0oxVkZLVTJTSlVjcXcxVzk1L0ZBcW5qUVVw?=
 =?utf-8?B?UURtQk5pVklyNDdaY0lVdnlVY2poYmY0Sk8rNHN0b1VMYlZHdFBleHFaMmlv?=
 =?utf-8?B?aHpLT0VJKy9XZkhsYlpaWEhTR3F0VFN2VnliaXFDLzJ4ZXdnQlM4TlJ6NGpY?=
 =?utf-8?B?VTQxdWtFL05Db1JFcG10QTg0OTlVT21iMFFTTTBTK0hVYWsycGl4dGJUb0ky?=
 =?utf-8?B?Uithc1g2eitFUXlmcENWZVRKTWR5eE1XODdwVDFSMVU2TTJ1TVEvWnJ6Q2tr?=
 =?utf-8?B?QndxTlNSWXV1Tzl6aUNldW5nK0FPaTZvaFNsUDVST0RsWEZYZFJGZ0sraVBN?=
 =?utf-8?B?Q0xCUDRHUmFsRTJyZWx2Sk5iTjQ1YXgvMjV5WENUblQ5K2tkZDFqL1pWR1hN?=
 =?utf-8?B?YXpRV1RzT1gyZG45bjNDY2hNWnIwM3JzbDE3UHpiTHg0aXBCYXNRekltV3RM?=
 =?utf-8?B?SUtJOU1wZjVZWjkzWHRReXFrb0VPS3huTVNvckswTHlNZWYydU93VDJCdVpY?=
 =?utf-8?B?dmxTemlJbXlqYUxkbWp1dTRCYXIzM0x5WVliZEZUZ2kydUtJcE9TYnl5d3cv?=
 =?utf-8?B?VUFaYjA2TE04OUJQVnMvQlNsSXZKcHVVMG9xSXdxOTM3Z1Z5R3J1TS96WXVk?=
 =?utf-8?B?LzJreXFhWEFHWlk3WmljZzMwcjJyTVE5M2I3dS9wNmNMNExtOHZjdFF2VGll?=
 =?utf-8?B?Z2ZNOVJRa0ZFdG5GS2F3NENHcFVVd0JOOGxhM2NNUmpoTTZlWXBhYlJkcHRy?=
 =?utf-8?B?akNiVDNOVjJaSzRGM1pzRzJPbGRwczB5cXFkV1QwWnQwUFVaVlN3RmM4RDBR?=
 =?utf-8?B?Y3NqcC9odjdRVEo4OTFKY3dKUkplU3FpcnJ6S1hOVVVjanlKQXVGRkxWN1Av?=
 =?utf-8?B?YVdydzlMYXMvZDZ1Y0krdnhxNituNmdhRjFVSGswUm5WaFlvSittZWIwOEgx?=
 =?utf-8?B?eFpzcjY5QUIvOGpGMFRjTHpBdjFvMjI2MFNrZHpKeWNrRVFhWVRoNTlxZWxo?=
 =?utf-8?B?RTBCQkNUdDcxM2VlTjhXU1VtbnZZNm5LSXZFU3pLT1JnM04wMDZIMTNKby9q?=
 =?utf-8?B?WURJZGh3dXFYM3JCQ2JxN3dBZXFqbjBMWFBlemF0dGFDZEt2UEhqZkhiMGU4?=
 =?utf-8?B?b3Z4L2k0TzczaE9ITFpSR3hmbDIwM241amVUT0RKMHBhb0MxNmxwbTdqeDlP?=
 =?utf-8?B?SkMzd1dwbzF5Q2FaaE03Q0xncDBDSTg5MXNtRUNEMks1aGQvdzNCZFRDdlRP?=
 =?utf-8?B?R1ZMdUtXWktFVmdDbTZpazVnZmZlREcxemhwajBmTDVBNitCbkxCQnE4Tk9H?=
 =?utf-8?B?WjFGSk9rSElLZGpvRjlpanJXbEgramcyNkM0TkdhMExIZlBpeG9CZnhwZmMz?=
 =?utf-8?B?U21pc2lYZGkxc1Z0bTlTRVZhbEVQQ1VMK1JOcU5BYm1oQkNseTlvNXozcHVM?=
 =?utf-8?B?YXFoQ2hVN0cwdkw1ZWJDOVo0VlF1Z0ZUcHEwbE0ySERrcHR2MllOMTFlQkxC?=
 =?utf-8?B?T2taTm93WmNmMGt5aU5LVDdpU1I3WG9rWVptWmlQdVZkMDd0NmtiUHlIcWlM?=
 =?utf-8?B?aUp0TlFLUnB5UTdRS2tCczdBSktsWjJwYWI4Y2lnbHo1YWk4UjVZSHpFRmth?=
 =?utf-8?B?RXhYZ3FMRDhXL001bW9YZXVkVnpTSysvdkc5M0dFOWg3TjR3WWxvZTVOZnVa?=
 =?utf-8?Q?3At0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d46e24-d6cf-41bc-7b4b-08d9f51ac533
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:15:57.9357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygUSvgrx57j56k3IMEcS6viqsK6XvUrdhE7/1c65fxm14icFrcftxrGF0X8dQbzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
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



Am 21.02.22 um 08:15 schrieb Somalapuram Amaranath:
> List of register populated for dump collection during the GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 114 ++++++++++++++++++++
>   2 files changed, 118 insertions(+)
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
> index 164d6a9e9fbb..14ad9610f805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1609,6 +1609,118 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> +				char __user *buf, size_t size, loff_t *pos)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> +	char reg_offset[11];
> +	uint32_t num_regs;
> +	int i, ret, len = 0;
> +
> +	if (*pos)
> +		return 0;
> +
> +	ret = down_read_killable(&adev->reset_sem);
> +
> +	if (ret)
> +		return ret;
> +
> +	num_regs = adev->num_regs;
> +
> +	up_read(&adev->reset_sem);
> +
> +	if (num_regs == 0)
> +		return 0;

I think we should drop that cause it just avoids the final \n.

> +
> +	for (i = 0; i < num_regs; i++) {

That's pretty close, but one problem is still that it is possible that 
the number of register becomes much smaller while this loop runs.

Try it like this instead:

down_read_killable(...)
for (i = 0; i < adev->num_regs; ++i) {
     sprintf(...)
     up_read(...);

     copy_to_user(

     down_read_killable(...)
}
up_read().

> +
> +		ret = down_read_killable(&adev->reset_sem);
> +
> +		if (ret)
> +			return ret;
> +
> +		sprintf(reg_offset, "0x%x ", adev->reset_dump_reg_list[i]);
> +
> +		up_read(&adev->reset_sem);
> +
> +		ret = copy_to_user(buf + len, reg_offset, strlen(reg_offset));
> +
> +		if (ret)
> +			return -EFAULT;
> +
> +		len += strlen(reg_offset);
> +	}
> +
> +	ret = copy_to_user(buf + len, "\n", 1);
> +
> +	if (ret)
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
> +	uint32_t *tmp_list;
> +	int ret, i = 0, len = 0;
> +
> +	do {
> +		reg_offset = reg_temp;
> +		memset(reg_offset, 0, 11);
> +		ret = copy_from_user(reg_offset, buf + len, min(11, ((int)size-len)));
> +
> +		if (ret) {
> +			kfree(tmp_list);
> +			return -EFAULT;
> +		}
> +
> +		reg = strsep(&reg_offset, " ");
> +		tmp_list = krealloc_array(tmp_list,
> +					1, sizeof(uint32_t), GFP_KERNEL);
> +		ret = kstrtouint(reg, 16, &tmp_list[i]);
> +
> +		if (ret) {
> +			kfree(tmp_list);
> +			return -EFAULT;
> +		}
> +
> +		len += strlen(reg) + 1;
> +		i++;
> +
> +	} while (len < size);
> +
> +	ret = down_read_killable(&adev->reset_sem);
> +
> +	if (ret) {
> +		kfree(tmp_list);
> +		return ret;
> +	}
> +
> +	kfree(adev->reset_dump_reg_list);
> +
> +	swap(adev->reset_dump_reg_list, tmp_list);

Just an assignment is sufficient here if you do the kfree before since 
tmp_list isn't used after that.

> +	adev->num_regs = i;
> +
> +	up_read(&adev->reset_sem);

This should be a down_write_killable() and up_write() to avoid 
concurrent reads.

Apart from that the write function now looks clean.

Regards,
Christian.

> +
> +	return size;
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
> @@ -1672,6 +1784,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_test_ib_fops);
>   	debugfs_create_file("amdgpu_vm_info", 0444, root, adev,
>   			    &amdgpu_debugfs_vm_info_fops);
> +	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> +			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

