Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 10:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E7710E84C;
	Wed, 16 Feb 2022 10:11:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E621F10E7C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 10:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSlJVe5NQHZw73zVmHhxnJkgURNlFwWA9Xhk8rNPqAaUMPq2G5qcbP1R+CdyY+JyCWU7jKx2+Sujdl1fjdxGTfgxYgCNqz9yVKC4APnT5WIAKvSITeHX1ARe1khJZlAkvvQx3q2FI9vlYC6dHXPC/7jZvDpacPwyPuhM/pweP8GM6haNIFNhXCn/8w2qYvx2AHpbJHt9BwQzMwAjQUVSVoQTRCtgivZFksZlkZbaMKg5p7+FEH661c4OiXxJmDvMkDwjx9kX6/lRiqb4RVkquqkUvCU0VUNljVUeAIof2PCgXijqb/QplYqnP/KnHg6lQ1VCODZk0g2N399AIS59ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqaKXg7QEBjdIn2hCylbYA6TYacuXfaYLNrRB64xUM0=;
 b=fa+yljXy28QGcxnOPYaVd21eMP2JfJDhI/ui1DylsJpITQQJFxrmAApwoHZCnXwDNIZxmfdBW4WkZwg12G6cRSb7gxBVSk2+MXZsvyVvkUrEMGY0wXtxU4V1yWpDotDD4/WyJPSP/5B1eJRdIaT+1UH1DX0cxr4meDIzejp1ci/uf8IIlgHP26gnfg0Enj/4Vz5aBQ3kjHhs/7ZHI3h8WR7o5G4svDdVQKU2ELtnq/MbbvZyy4F2exbEQUQeXiOGf/LXZf+DDZGU0JsTfIBZBFNtAHQaogiYXOipYH1t4nuijFmViVrLHtyVeuagNrq5GkH9MRdJyE6qQk4X/cPyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqaKXg7QEBjdIn2hCylbYA6TYacuXfaYLNrRB64xUM0=;
 b=CKsKcuAJ2w8X3LucEI5QCuKMRYj5RaNGH/KHJJ5v6/7xmfvqlKQI1HTMX/Z4zRPIAWel/Hy56X13rzFKw5OMPv8E3DZ9CgyrvqeqiT7L3hDqcpQGqTwbrTM0zfNjlDTg23S2LJtPlxLzDZz6+dJDxanpmfxdvfuCJvtsc2B9B/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 10:11:44 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 10:11:44 +0000
Message-ID: <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
Date: Wed, 16 Feb 2022 11:11:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0096.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::37) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1c95ef-a553-4990-ce11-08d9f134bc04
X-MS-TrafficTypeDiagnostic: MN2PR12MB3967:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB396782596925D0238D09790A83359@MN2PR12MB3967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPv7E737mwe1F57kxDsT9KrA1DWo6DTbr5ogvrBoBFAvez8ls6DBQ6ICeB/qcmpkB4UQW5nQNiUG8Xxu9UO7W5bqEhpm+rCW1zI5aoMc0zIG3r7G5nD27ySzbgvJadaK8klMZWHWAKySAz/9dxnNB7lvi1hG2v/AAyCA+Oemcn+RQ3WGiS6fvx5dbaxWw5G+cGe70B0n8JglHlM/RDJPby/RKFRXN2tjDV9b3PpnVkSmGP7ZT5RcQdeMDhWKYejU+fkL6xY8MzGF3KG/jV2Bkf1f4TIxLAVBqRtbJycEK8njhlLZQtS1WC3lfnGEE+urDGiyE/ytWgSmSxCbRoZLNQX/XWDhTRvqFWpkj3BaOMp5u/pded8b4stzJHlVZSkd7ovX6/CbmW2e5HPGW2f3vONhySpCazXYlgOfHD05cZbQp9qOFxVPqtVUqVs98a/mtPY5Ri82pUks4D+t5PI9b78fCtLSFu+UQymocCmZJtwvxVhU6/+SGB9BB/bg1OdCJMwyQ0r6WmQaBvB+r+iuDjShMPUrab5bJzSoJNaNuQ/M7vjeM48YIh5em1H9ypToCHU0i1dn9nrWT0ER+TQhImSsM3EreoGnxLkWtrlFZt9LSZPUFzC0u7S68OSp/9B9QkgMVUce0LLwndUpd9nHraXzuqlMaOUTyXq1/t/MDuPwKwtWilDsEGcVuw6R9P5sWxbetk2JLf+vTMYx26oaPg2HSsiPKR7xkDFr7a0VLxGjQo4rrZ2NsDiP5LFSL42q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(6486002)(31686004)(2906002)(4326008)(26005)(6506007)(66946007)(6512007)(6666004)(66476007)(508600001)(2616005)(8676002)(186003)(83380400001)(66556008)(36756003)(38100700002)(5660300002)(8936002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K28rbVh4NC9haGR5RHgzZS9GNTl3L3F0V2p3cURha09wRVRqc0cycFBmV3p6?=
 =?utf-8?B?Q0E4VGwxRnNGTVFhaHJEaFhKYWoxekIzbWFoTTE0eW15aUNhU1pvZkFReU5n?=
 =?utf-8?B?RjcyZ1U3cXdUN3BsamZGTmpseWlkdFhLL2RJRHBQcUN2TmVkMDhPT2h2ak5x?=
 =?utf-8?B?Z2wzV0tJQWUxYk9ZK2I4NlNVL2pjc0RlSHErSWc2blBLWVlJcHd6NDBob3hs?=
 =?utf-8?B?NUo5dHI5RTVWcTR4a0RYYkt2aW1ISm1Rbi9aTXpmZjl2b2Y1VDJ3S1JWaWdC?=
 =?utf-8?B?NXFJbkZNZWE2ZHhIR0hhUkF1bjExbGNBWEh6cHRSL0Z2TW9nL2J2SFVsZDF4?=
 =?utf-8?B?c2FrUmljTjZaT1VXVDVPUzh0R1dEcThKQVhCN0MyYWFRbDFhL2F0ZWFNNElG?=
 =?utf-8?B?MHdBMGRJQkY1RDBFdDNwdkVKV3hzOXJZc0l4WHlxZStVdVZ0czJPQXdZcWZC?=
 =?utf-8?B?OXVvbmd6SUpkcHFBUytIdXZYSEMvQUN1NnJab2JhajdWVlpMRjdJSzNSeVN2?=
 =?utf-8?B?RVNEbjF5NG5ISFArSTFEUjFaWXdzUXF6bzRsRXppOWJVMEJBYWxWNU9wK0ky?=
 =?utf-8?B?R3RxM2d2M3dpS290YlZMUDVWbFJ2UEFkQVFpejVnekJRVHFtd2pSVzNTU1hD?=
 =?utf-8?B?cXdnTzVQa1lpUktyUTV3L0VYWmpiV2RwQXNYWkJvdEdjbEVzSTZORHNZU0xT?=
 =?utf-8?B?b1ljcWxPNFJZV2ZhYngxZElPSW4xTjhhb1B4b3lpRG1USGN4aUVWWE1nakJC?=
 =?utf-8?B?aG1ndGpNaWx4OURQenNYbTA0RU9la0k5MzJCTHEyMGFyaUJqamNZaCt4b2p6?=
 =?utf-8?B?NkdUdFdMSmhYLzN4Y0svTjg2MHJYRnJicG9saW42T21XdTlLTVhRanRic0E0?=
 =?utf-8?B?T2l1bi9PUVI0VmVwcm1zN1dRMWU1OFQ2UGhqdGhHWUZ1VW9wd1RzZzN1c3FZ?=
 =?utf-8?B?OXNISWxhZHRXd3RqZTZZd0Q2R2hqSDgvaXpyNlkwM0xrTFZja1NHQ05nZ2Fk?=
 =?utf-8?B?c2xkQitMaXkzZXdHYnFlVjhDNlNkM2I3NWN4aDc5WURCQ1BYRkNPMUtXcTQx?=
 =?utf-8?B?cGZLY3BxTi84dU44VDA2VXhySHVteW94RWcrSkNFcFEyY2RwclVwOHBkUlRM?=
 =?utf-8?B?Q1BKbllLejV3cFV5SktQU3FJL2VLeEVYa1BlWDBxR0p4ZE55QjRPTFZteVU3?=
 =?utf-8?B?VW5lL212V2tlWjFNUGdQYnNZd2hhVGozZVpoRUFRaWRpM0xCK2I3MDNrVE94?=
 =?utf-8?B?STBmOGRQUDBiSHJXa09OaUlLdm5LbEtBTmUreXJ4TlpKNjFMU3R0R2xHQ3po?=
 =?utf-8?B?WHBGN0EvZlQ2ems2b0FBY0hweWdpTzNQSDd5UVpEbGw2Z3FTbnpuNmhxZTc3?=
 =?utf-8?B?RDZOdVFKckswNVpIZDdVc1B5VnZXMnFZTnlsVVZMcWF4U1lkb1dqVlE5M0dL?=
 =?utf-8?B?eHZTRDFYWVpSMDUxYmxUQVV2b0ZZNCtndzgrakNuV2ZKVGxUVnoyZ1A3RmZ5?=
 =?utf-8?B?TEVxZnB4Q2FnNDRuRXZlUENLaDhxSXl4OU9pUXNYZmx4K1A5V1M1cTdwU2NJ?=
 =?utf-8?B?ZDBmWkNOTElxenZDTWluUkR4cDNKZTZZVzNOc2VVMy9Mbis1eFFBd1dQWGdZ?=
 =?utf-8?B?VDdiZFhDeGVIZ294TGJOZm82ODFySjRHdlNMZkdPUWhlWStUclVTYnhPZElX?=
 =?utf-8?B?bmxRZWQrMHEzY29FUHo3UE55bVRtTDJqV2UrSE1VNkR0RCs2L1pzRUZsUVFX?=
 =?utf-8?B?ZDZXZjdDTjZUejIvL20xSmZ5Z3FVSVJjdk9BMys3RlZCTktZYjNzOG56QUVF?=
 =?utf-8?B?MWpJMmRoTDkvdzBWTGxIMUxsYlMrcE0vcDFSWVhoR2pLMnZJbVdYVERCOUd6?=
 =?utf-8?B?K2lXa3B0WHRMZlkzK3dvdUs0ZTd2QlBiZ0NmR0VVaDFJQzBSc09Wa1N1YVpH?=
 =?utf-8?B?RlBmWCtvV29BUWtLN1BQd0lUNmFhYlZObVNUM1BoVHhRVWd0L3IveHdoQUF4?=
 =?utf-8?B?QlJMK1lzS3pOd2lxVGJyK0xqeXUrSEs0L0w5ampGRFBWYjJ6ME9DbFN1Mlds?=
 =?utf-8?B?MUY0RWlETjlPUDF4WFo1TkNuaTAwVEJzN01KbE5aemtFUEY5SjNaNTJidGdS?=
 =?utf-8?Q?wpY0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c95ef-a553-4990-ce11-08d9f134bc04
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:11:44.7004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEyHEkX+362rc4+Kc1XHgDIDJPZpJ/Q5lrby5dqav07IWu/VMxKRM/60ZOnNkJQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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

Am 16.02.22 um 10:49 schrieb Somalapuram Amaranath:
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

I think we should rather use the reset lock for this instead of 
introducing just another mutex.

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

You need to hold the lock protecting adev->reset_dump_reg_list and 
adev->n_regs while accessing those.

(BTW: num_regs instead of n_regs would match more what we use elsewhere, 
but is not a must have).

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

This here is modifying adev->reset_dump_reg_list as well and so must be 
protected by a lock as well.

The tricky part is that we can't allocate memory while holding this lock 
(because we need it during reset as well).

One solution for this is to read the register list into a local array 
first and when that's done swap the local array with the one in 
adev->reset_dump_reg_list while holding the lock.

Regards,
Christian.

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

