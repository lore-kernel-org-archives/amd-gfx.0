Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A27C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 16:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B0B20754
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 16:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B0B20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BCD6E037;
	Thu,  3 Dec 2020 16:47:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD5F6E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Dec 2020 16:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhoM5D9Fzvvv6wsMoGncmagRXs9afKt6rsjGLXRJHb4TkOJx6hzVtpfkeE/Z9PgPijuqGzEfx79lPM1jwoig0kx8ixcB/J79Op1N/gFvYz/LXkYbK4nvv0QQlRI79O1hqwyX2D6+j6zNQu0bULQ+7Z6cecDO3GlfB3VGHQ0CQX7WeaitYh3mm2igVRjTg0NcroIVHTAvgL5k/1remmPCdVrV+fIqs6OOXQuufZM6t6ejN53hoeOYUyECAFqVr+ChonbvAn08sn/GVwDnvABgbvWzTxOqeqC2gvLnN4MWJYAZ34G7cONSOw7xXh/O5fMUq9oT9O46faaihbPAb/q2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd30Ic1PSbUgb1He8LuvOqfjM+yZsEFKcVbSxBjVQBk=;
 b=FoRw1hWwq9L0NbQEJ0hxeNjDSyWDnRucyWwTYFJllM3r6P0vRRu9trSymJmcrIiGRzaW+AsU3rvESyQjmSHcPxO/U5WTW5TGlU4Ypm1l8aCh/ZybM0D3Y+RDnY95O5SlinDTC3PNtRicXC2Q+XQPYXr0HaHNpZldvX0JidAl8g8VmK23J3cAHvj9h0dMn14SXkBcFrTyOHoLirdMjyPiOgc9/LqxL/L5CqxY82+MI8S8mcqWOUy11S1MMSfJTiCqbRsmeHQF4iraM+HWV+rKuGhaVIlkbPV+7qylBAZzC44GF77ilKI4I0IZ1v6pmzv6IxOYu/3OPOxJF5pxhCzGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd30Ic1PSbUgb1He8LuvOqfjM+yZsEFKcVbSxBjVQBk=;
 b=WN4hxNCqFKFiTyJu5f6AW70klmRohgqZSqt7t4uMaT3RjWGRdbdJcKxfzIclwI1J100LvV0ZDYLkqC5aoqz8453o0gqcOPcgQGrZHKvdqF+nlqQoDy6caFEvlSkg7dIIyJ/JLHXcIi3fal5PkjL3Xyrm1I+sLgnZSv4i19BZlVc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB1193.namprd12.prod.outlook.com (2603:10b6:3:70::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Thu, 3 Dec 2020 16:47:23 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::9531:f23:7599:99ac]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::9531:f23:7599:99ac%7]) with mapi id 15.20.3632.021; Thu, 3 Dec 2020
 16:47:23 +0000
Subject: Re: [PATCH v2] drm/amdgpu: VCN 3.0 multiple queue ring reset
To: amd-gfx@lists.freedesktop.org, "Jiang, Sonny" <Sonny.Jiang@amd.com>
References: <20201203145316.5140-1-sonny.jiang@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <84ba3d27-eb74-8000-a060-c186ffd977da@amd.com>
Date: Thu, 3 Dec 2020 11:47:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201203145316.5140-1-sonny.jiang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:610:4f::27) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 CH2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:610:4f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 16:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7856b96e-3d89-459a-18b9-08d897ab1ba0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11939A9C92744F5FEE70687AE4F20@DM5PR12MB1193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceuwZQ3HmnlMVIGrXBBhqBzpeHlneBM/0vzxO50UAptnnImexTShHHNDi96VQTzJNggKT8QJ9uDjgS+8dLM7xogVjqLdB42A9XCk+oiQrZCE4ntINZGBQ6OuhBhjkwId4iRD1mwJltDdrhD8Eqi5oul4IwRoPMvEMxHQiKk66sMwo8raycq3XDCG71RnZTTFco7Hk0beHUYzFkXg5PtfXbv7o07G+5WRYUC+dREMjPQ2HmjFhmT3Nghj8QPiXxiqV4T6WQplxiH1gAc1W5HIw7jovVV1R3xYVjCcMXVUnIIXsjGQpmfGb/jWV1TSDmmoY/euXvpPS70y+V2CwafJHt0D2JlPMId8aTYSZfVgyTRUO78OYgP1q1FNkvs1Adim6AikSGHtrK5oGjmzq9X3mHwcO72pwc5F+IDOgTFa4TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(186003)(31696002)(66476007)(66556008)(83380400001)(66946007)(36916002)(8676002)(36756003)(8936002)(37006003)(6636002)(53546011)(6862004)(2906002)(16526019)(52116002)(33964004)(31686004)(26005)(316002)(478600001)(2616005)(956004)(5660300002)(16576012)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SHZDbUdOZEZwcFlqRDR1TzdISWJES0k4TVJOM3FFZnFRTCtWT2pFWFdHN08x?=
 =?utf-8?B?aUVxd2wzeU01OEs4bEFjZU0zbXNmWlRRZWRGU0w2dDJOb25KL2Q2YkFjbU81?=
 =?utf-8?B?OEVEOHNlUXd0TjdPWGpRR0ZnR0N6Q3ZsVWo1cndYbk9yQ3FTT1BVNm5hbSt4?=
 =?utf-8?B?SVhhMHdBbHpKQm5Ga0dMZEJOelVzaERCaFZBNGs5VFZTV1RybDBldjc4WlRY?=
 =?utf-8?B?WElCR2hYNTZybzdpOFBtd21Mdi9PWEJMaGlzY2hIcjJEMFhSdE1uelhYMHFY?=
 =?utf-8?B?QXNPMUdnS3FPaWV6ZmhsM29FZTRVbnR5VGtQUk5uME1JNUdlWXJ5b1IzM1E0?=
 =?utf-8?B?d2QyN3dIQjlqSVJWdnNCNHBmRkNHZlVRdUN0RXRFNWZoZHQ3ZkY5UEpLeFJ4?=
 =?utf-8?B?L2hKd1EvRHJjMmxZa09mMzA2YTExMlhSZU1OMEYrQVI4ampCdWQ3ZHREdm55?=
 =?utf-8?B?Z1FtR1UwQmJEL0JwSHgyTHp4OVVJcEJONWZnQTB5ZlFFWGh0Y1hLL2NiT0oy?=
 =?utf-8?B?WTM1L3ZjendsSklnc0s2aVE3UnkveTRGV3JGRThtWlluRW1UK09IUUw5Umsz?=
 =?utf-8?B?azl0aHRlT296QzBLa2xxWEJYN2tYTzJlQ2N4K0dzNExtVU56amVDMlBscXY3?=
 =?utf-8?B?MFBlRk1JQkRKczhyVXhrTXZHNVhzaS84ZDR4MGFsbUQ1RHZpZThPNWhKOXgr?=
 =?utf-8?B?Y25GMnZERllibko0d2x1T0RHc1RDc0ExdVJWVE0wOXJUUFY1YytnaWs1b0RG?=
 =?utf-8?B?Y3BIUVY3dlN2Wko1NlFqNnpCTGk1OXAzMUo1Z2Y5TElMN254M2pOTVNUdmpp?=
 =?utf-8?B?NldCWEZhSFJjMUNCOVd2amZDcUQyOTY1UTZ4cHhwakRPZ1RtZmt3Y3o3Z25w?=
 =?utf-8?B?bVQ4TjVsenJUMlpOdmZYUUtmZGlKVzE2bHpNcE1EdzA5bWpNcFpNN21Famta?=
 =?utf-8?B?ZzZtYmY0cTEya0lrclFkYmdTU2k0Q01UT3dQYkJLWTBLMTBIUWFiaVQyaWtz?=
 =?utf-8?B?UWtwWmxpTHQ2QjdhaGNsdHMrc0xWMnNmTXhLbkZoRnRBZzZpVUhJSjVjcDBu?=
 =?utf-8?B?RTlua3ZDMkhNMXN4aCtEZVIycFk0QTMvancvQmsvOS9OUzBRNEZYMStZQ0Nk?=
 =?utf-8?B?SGdiRUx4Y25kemx3N3ZnRHVKMEF6MWhtYXpodzA2V3RwNlNpSDN0bjd2dW96?=
 =?utf-8?B?ZnFJSW92THlraEUvbHJuY1VnU05FVGRVeVlXYm5QWUZ0NTk2SU5jSUp3QUNG?=
 =?utf-8?B?QkdONkhSTFB4OWRUQlRVYzlPZmJRWkx2NEw2MC9uYWhLR1ZsY21CTnNURGp5?=
 =?utf-8?Q?MaFCuw91KSDgdL1gYypnNY9aDoM0RG+QuX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856b96e-3d89-459a-18b9-08d897ab1ba0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 16:47:23.4582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfuh2PE50eBFV0EkBwArGEoiiNSdx+JGnHgaJhCEZ9XRm93dbrpCpeLrL0pnuceA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1193
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
Content-Type: multipart/mixed; boundary="===============2052602460=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2052602460==
Content-Type: multipart/alternative;
 boundary="------------988A11EC92873BB730E97466"
Content-Language: en-US

--------------988A11EC92873BB730E97466
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020-12-03 9:53 a.m., Sonny Jiang wrote:
> Add firmware write/read point reset sync through shared memory, port from vcn2.5.

[JZ] I didn't see flag enabled for this feature.

static int vcn_vXXX_sw_init(void *handle)
....
         fw_shared->present_flag_0 |= 
cpu_to_le32(*AMDGPU_VCN_MULTI_QUEUE_FLAG*);

static int vcn_vXXX_start_dpg_mode(struct amdgpu_device *adev, int 
inst_idx, bool indirect)
......

     fw_shared->multi_queue.decode_queue_mode ......;

need retest after that

> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 4f718ee803d0..3eaabcfca94a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1080,6 +1080,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   
>   static int vcn_v3_0_start(struct amdgpu_device *adev)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
>   	int i, j, k, r;
> @@ -1222,6 +1223,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>   		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> +		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
> +		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +
>   		/* programm the RB_BASE for ring buffer */
>   		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>   			lower_32_bits(ring->gpu_addr));
> @@ -1234,19 +1238,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
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
> @@ -1595,6 +1605,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   		   int inst_idx, struct dpg_pause_state *new_state)
>   {
> +	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
>   	int ret_code;
> @@ -1626,6 +1637,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
>   
>   				/* Restore */
> +				fw_shared = adev->vcn.inst[inst_idx].fw_shared_cpu_addr;
> +				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   				ring->wptr = 0;
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
> @@ -1633,7 +1646,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
> +				fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
>   				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
>   				ring->wptr = 0;
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> @@ -1641,6 +1656,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>   				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>   
>   				/* Unstall DPG */
>   				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),

--------------988A11EC92873BB730E97466
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2020-12-03 9:53 a.m., Sonny Jiang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20201203145316.5140-1-sonny.jiang@amd.com">
      <pre class="moz-quote-pre" wrap="">Add firmware write/read point reset sync through shared memory, port from vcn2.5.</pre>
    </blockquote>
    <p>[JZ] I didn't see flag enabled for this feature. <br>
    </p>
    <p>static int vcn_vXXX_sw_init(void *handle)
<br>
      ....<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fw_shared-&gt;present_flag_0 |= cpu_to_le32(<b>AMDGPU_VCN_MULTI_QUEUE_FLAG</b>);</p>
    <p>static int vcn_vXXX_start_dpg_mode(struct amdgpu_device *adev,
      int inst_idx, bool indirect)
<br>
      ......</p>
    <p>&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.decode_queue_mode ......;
<br>
    </p>
    <p>need retest after that<br>
    </p>
    <blockquote type="cite" cite="mid:20201203145316.5140-1-sonny.jiang@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonny.jiang@amd.com">&lt;sonny.jiang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 4f718ee803d0..3eaabcfca94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1080,6 +1080,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
@@ -1222,6 +1223,9 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
+		fw_shared = adev-&gt;vcn.inst[i].fw_shared_cpu_addr;
+		fw_shared-&gt;multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
+
 		/* programm the RB_BASE for ring buffer */
 		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring-&gt;gpu_addr));
@@ -1234,19 +1238,25 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
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
@@ -1595,6 +1605,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 		   int inst_idx, struct dpg_pause_state *new_state)
 {
+	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
@@ -1626,6 +1637,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 					~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 				/* Restore */
+				fw_shared = adev-&gt;vcn.inst[inst_idx].fw_shared_cpu_addr;
+				fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &amp;adev-&gt;vcn.inst[inst_idx].ring_enc[0];
 				ring-&gt;wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
@@ -1633,7 +1646,9 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
+				fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= ~FW_QUEUE_RING_RESET;
 
+				fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &amp;adev-&gt;vcn.inst[inst_idx].ring_enc[1];
 				ring-&gt;wptr = 0;
 				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
@@ -1641,6 +1656,7 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
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

--------------988A11EC92873BB730E97466--

--===============2052602460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2052602460==--
