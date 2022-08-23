Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5570C32772
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 15:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AF510E743;
	Tue, 23 Aug 2022 15:31:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DB910E173
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 15:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3s1x93vwePuq9fKc7e4RYinSRCan6WOHkToMffAONtFRSQv3QEQi8uV//7gIzanGI2v/2tBlcGS56GDOHxaueKMQ7iTv5q5kamZzuF9Sgzkbwspyfp6+a709FVRpKlngtIepajc+Nt3hrgMgWWgdSEfm+pv06eNRV3Ndj9+48UqZsMq22+FD1DDwN5CX+guD4cWybC7Lg1M5hFeB/8g7v+GKbacHdSfEEzNJ3s9E4baSpwRQ2qWy2M0bv9nB8l6qEfFj/dQQ6MNGotveO2TalAXKSPfqs7T/LnBPiacriNla40eHdHcEEfgoN/+Z4rX5PiE3mUMxxG1DJN3L1xZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNHCMbUdQhyT3aK0/a4Sr/CRMGmjeSJp0rQK8angX4o=;
 b=kuQtGqHeOAH6NPQZSYGhNit4h1f9xP4erV3j9oAz/SsTvPlPwGANbpH6Kspsj7BC+xgl6kqe1Fzu/RgsTXL4udfKDDnQzsvbqgD1cxjLc7Qfve4MqBlfLtupM3gIQbhlj70JIOXdoYSC/Icys+SumKXeflcxKfSIO4LhHQY9u3sXNBcr4EqLBotVc6PqsvAAvrSvjNDqpG5grg46dMR8D4k+ZKe8dC+Qi3muzFI0MS+bOjN75dljgytSBmFAa3z9AZpgz/eb5SBJ86t6rQAu4bk7Hk0e23ZVAAOPFOInCoQwmTtB2NpSVeTRcLqhh7gxoBhoI2yiZXidHn0qJhUWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNHCMbUdQhyT3aK0/a4Sr/CRMGmjeSJp0rQK8angX4o=;
 b=WlAR8RVPRTxQAP3Cgs0r2MbO9XL4k5ZNupTz1h7aOUMzt+2Knkj5Bt0QvOUJucL8u0Tarqtiqt9RLf+qLaMHlT8Vgp0gPW/ZVYzRuKNF7oooQ9GFuXcQqSuIEA9g4CKZQ4MfQzAAMuJ6BHXb4WFwSbFZ08Je+VaMe+2CgRpL/tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 15:31:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 15:31:40 +0000
Message-ID: <2aeb046e-2b9b-2aa4-dc41-b6ac2ea8dd14@amd.com>
Date: Tue, 23 Aug 2022 11:31:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220822155217.911506-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220822155217.911506-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::47) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1326007-b413-49b1-f5b8-08da851c9380
X-MS-TrafficTypeDiagnostic: SA0PR12MB4558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhiE+E1WmiM2F16P3ED/kFmvrtibQnAb4ROwwoZRUrvDNM08cdDHuMnoXqKaQXTOAXYhfB8Cl9Q88HQrzMYEsBmsIRbUFxJzyt3Cs6YntoIfwpuqFog7aSgKUwNdBUwZJw3dqVFbp+ZkUZ2Ixz/YxCSWa5Blas58lSiAFpDyhaFusPpA6OAKp5Y4a8PQAdrxZ/w8czB1Am2Brs2hQQB3YQ4Zp0i/Hh91i9MIA1M+pmvdN7eM61OUxlkRMkiwYNUEItKIy/uNLuwO1/EcR0zt3FO6xRE4qtECNjrhQcJa33aZRyGpj7wJ7D2A0zJrWBH2d44RBYAfC8UMdD5DRc0AqYrn6CwUvjK30BV3litjFFiyEgylb5J7/UzOBR6QbXMnOS319qoRA4f9U5WWjJnUtsIwDBnrB9Z0Wpc0hvfRMP6f8MMBn4WcGmj5RAo1k0ppcSdJSSFIQQNKdinjr7tW0OtLfy2rlQ1xd8eX7PBzTvgxM+50Kuyeotam3b2juGsQtf/GtYCK0TW48iosZmcCY8Ct2uZS9MpgLjxRG3CH5tbgE4hSTGMXGM0mN8Q/J25ScaAZ8MXk1YBypktBr/7HHuwI6vZ3QHUG79+tuL+wDM3DLVig4vLc49mrfZjMXVBy+j+GnKzvqk54fZ7kkLFvDqEA60+qn+JvcnTlDS1okS85QDsJPq6eKWmYQUv8gGN1Fg2QTvlWNnpXiWyKEOBekb51l7XNiLfrldT0Iy660SLE0mHTRyxx5lDEqny+NWD4EoWw1s1xKvRU/q+AvBanHxn8wyqfw90kYhQMY9KTEtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(186003)(83380400001)(316002)(2616005)(41300700001)(86362001)(26005)(6512007)(6506007)(36756003)(44832011)(5660300002)(31686004)(38100700002)(478600001)(66476007)(66946007)(6486002)(66556008)(8676002)(31696002)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R053Z1J1QjNRbnk2MlZDVVA0M3l5VCt5RE1mS1dxZWJlQXNSbGRWRFFRQ2kr?=
 =?utf-8?B?RkZOc3o3dXRZb01KSFhJZE9vc203Nm9LdVZGRjRkalA4MXduc096Ylc1WUpu?=
 =?utf-8?B?UWpIN3B5WjdKMk1zTXJ5TVBtOVR1djY3cjF2eFNjeklReFJ1b3FYdzFzRzds?=
 =?utf-8?B?UXlWSW1uSmw1Q2wrZldpMllGOHpobmxXKzJtK1YwTXBGZkVkQ2ZnZTR2NHhB?=
 =?utf-8?B?cjAyK08wR2pkY0craVZTNHpQaFVweHkzeUNlZGcvSTA2UnFEb2s4OFN5d2w0?=
 =?utf-8?B?b25VbWtJT21ZRW0xNWNLSG83cEhGaFdwZlVGM1hTaEhjVkFBUE4va051dW4v?=
 =?utf-8?B?RGZQTVRGRzljY0tJOFJQeWFGV3VmMThvMlp5Y0swNlB6Z3c5dWdLVWwxZ0Y2?=
 =?utf-8?B?VTcyRHdJN2F5SmNwSW1ybWNzQ2NLK3VDSWFJSHZYWnVwQjNJWDhFRGlLTlBv?=
 =?utf-8?B?ejRXQ011L3RldDJtYTNQQ0JBREpsZU8vMktUdnJBQnZLM0dmY25HcjBFTTdN?=
 =?utf-8?B?OEl4cjNrVG53U2tOR094dzluV1dHUXZKUHgzNzg1Q1FkUWJyNkxjc3BOaTUw?=
 =?utf-8?B?c09STGQ1WnpHbmpaUGtLUUxqM2FyZFVPRFRPMXpsT2IwNC9KRFNxMkE3Kzl4?=
 =?utf-8?B?dG5Dams2QTZjWFVFM3JaSXBFR0EzU2hveFZuWWl2OVBXRVQ3UnVHNFRHQkR4?=
 =?utf-8?B?VlpDYzlTcHBHU1BUWTFlcGtGenFBUVNUQjQzOG1SRzZyUEdZVUFzWElHSXFm?=
 =?utf-8?B?TEpDbFdCYzBua21LaWJlMzhtQ0QxMFpXampQVGNzL2NrdlpjaXowNXBwcmRq?=
 =?utf-8?B?WlFCTEtUTlEwZ3piT3pwc2syZjQyU1RTdWQxRTk4YzlGd2R4SjBSR3hiaFI0?=
 =?utf-8?B?aXI4M050dEtuUHJrTVNSUzd5U2ZNRldFMzdxUkJSOXlzVGpobW1JaTN2TWY5?=
 =?utf-8?B?Y1grRHVFU1MvREhWODFZazhGeEtSRkNSTU1NV0YvWGpjT2xFbkZnWHVmcGRv?=
 =?utf-8?B?UzltT1dIQ2lBdmUrZmpOY0FSNjJIWmxOTFViNGd0Yjd6SGpMQjVOcXQ1Tklx?=
 =?utf-8?B?UVhNd2Jka0tIN0J6cGNhVFd4ZzZSZW50MVltWGdZNjEwMk1lL0hVSHJTV3hK?=
 =?utf-8?B?d1VtTCs4U0orZ0U0ZmFiVS9IUUd2VStyMENoT0kvbDhZeDgrRDV4UDBwdnht?=
 =?utf-8?B?RFdJdUlaMUNkemZNK1l2SjJSdlpUNG41RERhYisrTFo1a21JOVF4WEc0VDFa?=
 =?utf-8?B?Q3hTYjZtUzE5eXI3a05uUGZVMTNqbHlUMm9OUFFzNWkwR0FEY1AyMW90L3BP?=
 =?utf-8?B?Y0dPamtRUnBIbHcxNGpFaG0wMnZkTXZLZmNkUlRpSW93VFhuaXNEVXloWnR6?=
 =?utf-8?B?RWMxWEZGamkrMjFyS3RWd2hyL0VvamJ3Yjk5M0xYd25Zc0NXM3NOZ2NkdTlw?=
 =?utf-8?B?d05WSG1nWTlEMHlCN2hVU01PUXhyVVVKQS9MVERqZEYvNlJhRytjSnZGWVJz?=
 =?utf-8?B?WklKVjF3Y3h3UGdyeTlhRGc2MVNHRmF2RllyVFNmODE0UW1mV0UxWXY2QWdz?=
 =?utf-8?B?RGZ2cUhocXgxK29wUk5YSmg1OWFiQ1gzc2NZYTJTaUpRV3QxNyt6ZG9GTzBm?=
 =?utf-8?B?Rmc2ckdra01aZE9LTjZFOUxYQmRYYWN2WStWQ3d5VTI3c1NvbWNkUUYxQ3o4?=
 =?utf-8?B?NmQwTFM0enRaYzM3YmhPWng4djViV3VhMkUyMDQ4WlNPS3d6eTVWbWpDeW5y?=
 =?utf-8?B?dkZwbDEzMWRGYWlNT2ZIMkZueldGK3loQStiaUJTM2lDY2Y5cjZ2TjN4WFA2?=
 =?utf-8?B?SStqMndQNldScDV1QU9EME1oTDdtanJ5WlhpTmhkcnh1YkhkUU1LaDd4TUhi?=
 =?utf-8?B?Q3F2dlY2UEdveUlpY09wK0xBWGVValR4VkZNTE02cGlQWk9rWGRrVDllNFhn?=
 =?utf-8?B?a3J5dGtRRHZ3UU56eFEzYW85TUxHditoM2xBZEcxbXJEZ0VQNzBFV3hKVXlU?=
 =?utf-8?B?MGZ2cnd6VkNFWW1ZWTNBeFFyODkwdVI2cTR0bDFCSE5ocUxDdzZIWXV5OUx1?=
 =?utf-8?B?OFgzL29WQ0ZHMVFmeG1lc2dYbmdIWEw2N0Q1dnprdFNRN2YvbWpJeE03RDRS?=
 =?utf-8?Q?5PNjJBTx6Ee+0eIxpoBoVYjb6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1326007-b413-49b1-f5b8-08da851c9380
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 15:31:40.7720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZqCu6RnhuwqN/510UZOVRjHd+gEXhjtKoyYV4WNdjScAP4nJRumJJRDVmNeLqYC4tCEi2L8h2uyoKuYSjalnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
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

Am 2022-08-22 um 11:52 schrieb Mukul Joshi:
> When translate_further is enabled, page table depth needs to
> be updated. This was missing on Arcturus MMHUB init. This was
> causing address translations to fail for SDMA user-mode queues.
>
> Fixes: 2abf2573b1c69 ("drm/amdgpu: Enable translate_further to extend UTCL2 reach"
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> index 6e0145b2b408..445cb06b9d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> @@ -295,9 +295,17 @@ static void mmhub_v9_4_disable_identity_aperture(struct amdgpu_device *adev,
>   static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   {
>   	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
> +	unsigned int num_level, block_size;
>   	uint32_t tmp;
>   	int i;
>   
> +	num_level = adev->vm_manager.num_level;
> +	block_size = adev->vm_manager.block_size;
> +	if (adev->gmc.translate_further)
> +		num_level -= 1;
> +	else
> +		block_size -= 9;
> +
>   	for (i = 0; i <= 14; i++) {
>   		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
>   				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
> @@ -305,7 +313,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   				    ENABLE_CONTEXT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    PAGE_TABLE_DEPTH,
> -				    adev->vm_manager.num_level);
> +				    num_level);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
> @@ -323,7 +331,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
>   				    EXECUTE_PROTECTION_FAULT_ENABLE_DEFAULT, 1);
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    PAGE_TABLE_BLOCK_SIZE,
> -				    adev->vm_manager.block_size - 9);
> +				    block_size);
>   		/* Send no-retry XNACK on fault to suppress VM fault storm. */
>   		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
>   				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
