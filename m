Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57513C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 03:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D21207AE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 03:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D21207AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811776E122;
	Fri,  4 Dec 2020 03:55:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6566E122
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 03:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4cBt0RVTXOCoM/9eMse3SITlOJOZOBgvGXcX+tbsyRcuuL/0gj7lub+njw7mUObOvbiUTdXq5f8CyyBB55S2mhc5kIT6lB5xH7EXvvbUA7XnX0ZC9XQQMgaJSijUDwV0+F+yRk8QSpD81uDZxLHGcCt0CocITzFzmm+s7r9XNHzx1IcxPeyHMHe+RguZ/NDCYd7T8qIHJF7WMtkVju3JLJprvsLqcW7bgT2p7aiHlb3+GcT9+v1dXRLyjOJACKtflAiqAZrZzp9EOFN5NrICt3n1zpNatCdM+uxrO+Xv+rBrIYHGPHH8ls6aisHTuaYI3VIprvBpg2QBJeOHlf1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INPtw9NwiPZ2Tf+fEB8BwE2HJAmYsnaMQdufvLcrENM=;
 b=VzG9VtAFhkBm2VQbZyKzc+D84biWZsCl/LZsEiMBitDUDGj41eXON4xMTcJf0yZtBbcokQNoMuovy1jVyBSuCMePYJPo1WV9e9P5lQd5ykkHSkGNprfp78AV4AHOaB1fnjiQsSG13N4FZCPyHuARPKY5dgzMciwmP9Lqor2VZ4ItIu+u3KfRUAeE5AtCoP/SzZ+/mUM9Y39HuWK/belf+wOSav+vMsFbx5trcOCl7RJXcwpxome2jh1E1/ZgWYujbfu5+ta7HKNZK22mTPQB8b6VTwKaiUZftj7X0Zwo+9aRXBQAD8Znt4C/TA27Md4wEOQAn6OjPgvwUEXXg8z26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INPtw9NwiPZ2Tf+fEB8BwE2HJAmYsnaMQdufvLcrENM=;
 b=nYeCCPzbryjXm6EwMbD3WuNOiblIUZEsD9LB1H5j7+GU13DqxUyBF1l43QWZMfnnT0lPAmc7A0dlpT9DKfbd9hSEWQGt34N96MO/frSvHaRPlAqu3Zin8nNoKi9W/Fji70MJjZNfsYslsPRD+/yHCcG7kFtnACn5ZsG7bFEd0sA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.31; Fri, 4 Dec 2020 03:54:54 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::9531:f23:7599:99ac]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::9531:f23:7599:99ac%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 03:54:54 +0000
Subject: Re: [PATCH v3] drm/amdgpu: VCN 3.0 multiple queue ring reset
To: amd-gfx@lists.freedesktop.org
References: <20201203231011.3165-1-sonny.jiang@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <ad2185e9-44d5-0f25-49a6-b660450c4005@amd.com>
Date: Thu, 3 Dec 2020 22:54:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201203231011.3165-1-sonny.jiang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:610:b1::12) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.9 via Frontend Transport; Fri, 4 Dec 2020 03:54:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 465f73a6-fb26-4b31-50e6-08d898085ba9
X-MS-TrafficTypeDiagnostic: DM5PR12MB2375:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23758AF8B0556B0CA13966FAE4F10@DM5PR12MB2375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLoztsgHkiaOThskav5AGrlbjlawvY8yUGyZxw/xQum+dwAI2v4GyvrRp0t4mb2EeAx9YuMqInYznaFSnwlhiOz+/TS2Cnj6Mr7lFkABVPrOCHwnQP21DbGbtC3ddiYMT9qMHlKPEcNfNegxrUe/v7uXi6mIGEtyUQ5KYpcgKtWZaJbLCk9OybowxT5DaH/z4++Pmp0IwRYu1DckQAJpFTQupuYvvaKfdRywrlIlOj9bhfUJ/GEQh7+5a/z1lnGESpd7g+7JRGVpCw8tQnaS05LD075MlHYuRIrKldWe6R2VyrFXURUQN76uIM1RxrIMX95qREasxg7VKnjjCEuSAL0m52wxOcTtW9pqQC0QWgKi5lLEcNFO20AksfI7LbP3pMhCd3bNHow2ntFWJDDyj8hEAX5y7ay3cBphBWYXDTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(53546011)(5660300002)(52116002)(36916002)(31686004)(33964004)(30864003)(186003)(6486002)(16526019)(66556008)(66476007)(26005)(66946007)(36756003)(956004)(2616005)(31696002)(6916009)(316002)(16576012)(478600001)(83380400001)(2906002)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1l5T2twSThKaGVGUm1mU05EVkN4V1MvdW5FVk9uOWZoeEdDVkowSG9GUTUz?=
 =?utf-8?B?MUk3TmMxRVZwazhDTU5oR3RTT0xFMkZSN2x6djZKZGFlQ2dOL09BNmxwUVNP?=
 =?utf-8?B?QWtIcmFYTnVGdFBoMHFqd2VPRlB1cFZKNS9lZ3ZVR09mQ2F4bmFBMklXeER3?=
 =?utf-8?B?L1prZjB2eDIwUVZWVFZUeTZUZWgwdVpEc2RXK1R6N0VTc1lwNVdVaG1vVlJ4?=
 =?utf-8?B?T2JoTUxhQldmSlBqWlN6QzVkbkJQSFRLWEZ4UTB3dUVVbjkxY08wV0kxQ2Z6?=
 =?utf-8?B?MENXQ0FyaytNNmN4K3YyR1l4cWdHVVhIdGpqMDRpQ0x4N2pscEE3QmEvcUJQ?=
 =?utf-8?B?YXRYd1hoVEUwVFdpK0EzdGp0bTUyVHlMWnJpRGV5UFRlNzdQc2xESXhUMUN6?=
 =?utf-8?B?K1NhOG1HV3ZVSXZkcWtaWWhjejJwano1N3hkRzh1T1VhSWlFVXA5cHIwSlp0?=
 =?utf-8?B?MGF2Z2VLM2hXc0xKSEdxdlZhZXY2Q2VZVlVWNkgrQzJVVkZ0MG5QQnF4eStu?=
 =?utf-8?B?aXptMExvMlg3VXkrYlA3eGpGczJBcmF3NXhSWWdoYXBuTG9mVDRKZVZmMmFE?=
 =?utf-8?B?R0d6bVRRNjZMM0tCcnpRejZKYXFBRmFaQWtDTGZ6dnZwTFlRYXJtaEZRUHcy?=
 =?utf-8?B?SHk0NUJ3QWhIUDlOQ0pwWEk3Y3FiTWxzbEM3dnZJRFYvRUZxeGRVS1lZeFNl?=
 =?utf-8?B?OTZwQWh3cEx1dXYwWlZjUVVmVVUwZnRMMU5LcE95R2M4WVhyb29xVXYzWVB6?=
 =?utf-8?B?ZzhTcURiTkhKYVM3RldudllkTTRUZjZrTzFweTE1ak5aSmE4QXFTUldxclF5?=
 =?utf-8?B?NWp5SlhPMHZXbkMzUnlRbUV3N3NhNFVYY3J5QjlzQ0tzRk9ia0tZYy8vTHRJ?=
 =?utf-8?B?ZHg1RmxCMWFDdmpvN3FmYXE4OU9lSHYxcW1zV3BVbG5LQnBaTm05TURTSmdx?=
 =?utf-8?B?TWE5Wm1OaGxNeStPRmNKdmdpUEZIdEk5WVV2T1MrM0RTUHJtOWE1eGhNUmdH?=
 =?utf-8?B?QUNTWmprUW5jUG1MSHVueG1YMkRKblJPK1EvSXdiUWRpQlVMSFplVEtQUXVR?=
 =?utf-8?B?RzdnTm8wWkM3eWErN2JDaXhBYzVCTnJpYU9MUitQYklmMjAyQ1RpTDFsLzNz?=
 =?utf-8?B?aHBSNFpvQTFaNitXMkJ4bVZTN2pvNjZCMFBNS0ZlTS9sSk4zWE5ZRDFkb3Rt?=
 =?utf-8?B?b0VzaEQ0anRBY1AwdVNUbVk1VWJQTGRhY282dmhBYmxFMEtpT095SnZIdURW?=
 =?utf-8?B?S1lzd3RkR3FBeUZEMEZYdG83YjVWZUhNWnUyVUZ2SjNqMkxmMVYrMUpROXZ1?=
 =?utf-8?Q?O5FwPPRqe0Cx+O7krNIe3XcZbATV7IgXNA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465f73a6-fb26-4b31-50e6-08d898085ba9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 03:54:54.0167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4ib7KJJ8R/zeakNznBC1VJJIPiXZCsQ2JHQ2tzOHnonyBpraq3fInnwkTmzIzdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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
Content-Type: multipart/mixed; boundary="===============0212698171=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0212698171==
Content-Type: multipart/alternative;
 boundary="------------F2809051D28DFDB7054C6D18"
Content-Language: en-US

--------------F2809051D28DFDB7054C6D18
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sonny,

Just realized that it has a bug since vcn2.5.

You need add cpu_to_le32 for all fw_shared's value. like.

fw_shared->multi_queue.decode_queue_mode |= 
cpu_to_le32(~_FW_QUEUE_RING_RESET); _With this fix, This patch is 
Reviewed-by: James Zhu <James.Zhu@amd.com> Best Regards! James__

On 2020-12-03 6:10 p.m., Sonny Jiang wrote:
> Add firmware write/read point reset sync through shared memory, port from vcn2.5.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 4f718ee803d0..aa1c92de7a80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -237,7 +237,8 @@ static int vcn_v3_0_sw_init(void *handle)
>   		}
>   
>   		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> -		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG);
> +		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
> +					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>   		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
>   	}
>   
> @@ -935,6 +936,7 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
>   
>   static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
>   
> @@ -1048,6 +1050,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
>   		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
>   		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
> +	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>   
>   	/* set the write pointer delay */
>   	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
> @@ -1071,6 +1074,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
>   		lower_32_bits(ring->wptr));
>   
> +	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>   	/* Unstall DPG */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
>   		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
> @@ -1080,6 +1084,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   
>   static int vcn_v3_0_start(struct amdgpu_device *adev)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
>   	int i, j, k, r;
> @@ -1222,6 +1227,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>   		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> +		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> +		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +
>   		/* programm the RB_BASE for ring buffer */
>   		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>   			lower_32_bits(ring->gpu_addr));
> @@ -1234,19 +1242,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>   		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>   			lower_32_bits(ring->wptr));
> +		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>   		ring = &adev->vcn.inst[i].ring_enc[0];
>   		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>   		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>   		ring = &adev->vcn.inst[i].ring_enc[1];
>   		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>   		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
>   		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>   	}
>   
>   	return 0;
> @@ -1595,6 +1609,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   		   int inst_idx, struct dpg_pause_state *new_state)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
>   	int ret_code;
> @@ -1626,6 +1641,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
>   
>   				/* Restore */
> +				fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
> +				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   				ring->wptr = 0;
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
> @@ -1633,7 +1650,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
> +				fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
>   				ring->wptr = 0;
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> @@ -1641,6 +1660,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
>   				/* Unstall DPG */
>   				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),

--------------F2809051D28DFDB7054C6D18
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="Times New Roman, Times, serif">Hi Sonny,</font></p>
    <p><font face="Times New Roman, Times, serif">Just realized that it
        has a bug since vcn2.5.</font></p>
    <p><font face="Times New Roman, Times, serif">You need add
        cpu_to_le32 for all fw_shared's value. like.<br>
      </font></p>
    <pre class="moz-quote-pre" wrap=""><font face="Times New Roman, Times, serif">fw_shared-&gt;multi_queue.decode_queue_mode |= cpu_to_le32(~<font color="#cb7979"><u>FW_QUEUE_RING_RESET);

</u></font>With this fix, This patch is Reviewed-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>

Best Regards!

James<font color="#cb7979"><u>
</u></font></font></pre>
    <font face="Times New Roman, Times, serif">
    </font>
    <div class="moz-cite-prefix">On 2020-12-03 6:10 p.m., Sonny Jiang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20201203231011.3165-1-sonny.jiang@amd.com">
      <pre class="moz-quote-pre" wrap="">Add firmware write/read point reset sync through shared memory, port from vcn2.5.

Signed-off-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonny.jiang@amd.com">&lt;sonny.jiang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4f718ee803d0..aa1c92de7a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -237,7 +237,8 @@ static int vcn_v3_0_sw_init(void *handle)
 		}
 
 		fw_shared = adev-&gt;vcn.inst[i].fw_shared_cpu_addr;
-		fw_shared-&gt;present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG);
+		fw_shared-&gt;present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
+					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 		fw_shared-&gt;sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
 	}
 
@@ -935,6 +936,7 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 
 static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
+	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared_cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 
@@ -1048,6 +1050,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+	fw_shared-&gt;multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
 
 	/* set the write pointer delay */
 	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
@@ -1071,6 +1074,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring-&gt;wptr));
 
+	fw_shared-&gt;multi_queue.decode_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1080,6 +1084,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
@@ -1222,6 +1227,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		fw_shared = adev-&gt;vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared-&gt;multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring-&gt;gpu_addr));
@@ -1234,19 +1242,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		ring-&gt;wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
 			lower_32_bits(ring-&gt;wptr));
+		fw_shared-&gt;multi_queue.decode_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
+
+		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
 		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
+		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
+		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[1];
 		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
 		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring-&gt;gpu_addr));
 		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
+		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 	}
 
 	return 0;
@@ -1595,6 +1609,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 		   int inst_idx, struct dpg_pause_state *new_state)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
@@ -1626,6 +1641,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				/* Restore */
+				fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared_cpu_addr;
+				fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &amp;adev-&gt;vcn.inst[inst_idx].ring_enc[0];
 				ring-&gt;wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
@@ -1633,7 +1650,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
+				fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
+				fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &amp;adev-&gt;vcn.inst[inst_idx].ring_enc[1];
 				ring-&gt;wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
@@ -1641,6 +1660,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
+				fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
</pre>
    </blockquote>
  </body>
</html>

--------------F2809051D28DFDB7054C6D18--

--===============0212698171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0212698171==--
