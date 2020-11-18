Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4243DC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 17:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E332486E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A7R4KgCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E332486E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A54889893;
	Wed, 18 Nov 2020 17:08:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9A16E479
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 17:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhgbEfveajF8eiKGuCT7txoFMF2K86E8jS8T3NtLii5hU6XGxlmkLGY+vcHwT/SHMoT8wA45IParOqFIsXZybCjIxy4uq+iooEhKBCoo7Ub+tRBA/5eq83XB4/rVvLfV/D0ZMxeoDJvWdWxYx423bcbpz3jMebqvYwPTupiqj8Acp0xPuDOeFHYqA2Le78fy0r7uHto2ogZSYnbf0+qMz8o+wLt3tVmwMTko0trUwsI5CN/8SfSRueoLXaS3hCpvDgSufJrQXx1pSNk0O7swbSA+bHEwdbTkWi3245PmfD21M21XZsKpgaE5M6uj7fs2JTi9Y0dd4Xx6mjoa2z40JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgHjI89zRUvgSqH2fD4ZPvdvhOyNT3GOE7mH/1tHX0E=;
 b=SREJOeSZDiCrz6qsjULPzTytZ5cRpVtuCONJWPOr4+pQT36WoWn+d4TZkNK0yasWiwTXGutJN8pnzm7nIAcQtjBgrilKrhJR91oqQh5vIRcvG0OBEYQKEGPu8jsosvPVooom9yqrPJOrRQxvYRhHT97sSNDuFB6uIX/N2NB4pvp2jLpKtic0H4taYyytKBeDhCq6PeTaP2H+fNn6b3nO9gmWIWqSPLNMOBq3FV//8yWdFCMb16BtsOg2GzFmYk0I0bae1RIPCgqsNP9YzCjFGgKRSWqhF8VHU87HBHkY7Fu10NYCF9wxTyXawEBmddRCJ+tJirf5fhKwUd0Jb3FLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgHjI89zRUvgSqH2fD4ZPvdvhOyNT3GOE7mH/1tHX0E=;
 b=A7R4KgCGpby9HDBV1oKaSujo9XhO3WdS6+El1OfWbUNLmNMoDDcYRQbWVOX+m5l4C/lgE64xOXJd+fXuyjseDQ8KnWxzuWgon7AOqjHiEp9GMzJYdP3QA18Ool6HjvVw2L+EDBbyykUfJzSGEbEr/05UprmlqE/nUC82hsWgu+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2373.namprd12.prod.outlook.com (2603:10b6:4:b1::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.26; Wed, 18 Nov 2020 17:08:08 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 17:08:08 +0000
Subject: Re: [PATCH v3 2/5] drm/amdgpu/vcn: update header to support dec vcn
 software ring
To: Luben Tuikov <luben.tuikov@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
 <1605716641-22176-3-git-send-email-James.Zhu@amd.com>
 <630259ce-6a48-4f35-3f09-cf2a27703d74@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <62a6bf59-8817-1960-86f4-78581bfccc90@amd.com>
Date: Wed, 18 Nov 2020 12:08:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <630259ce-6a48-4f35-3f09-cf2a27703d74@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:610:57::20) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 CH2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:610:57::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 17:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aef184c3-8d56-4b2f-1028-08d88be485a0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2373F321829B507136ABCBE1E4E10@DM5PR12MB2373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnKthmZtlwbpxjsOWFgv8ZbCG0CN1ffCZcHxwYMQL1Q3yZif5EW+FAPVnUaMrcttHhcluncilgUibEVCTD6jNm/xsatuSuWc7ylKpyLDt/zkHT9F87q2dvA8rb9Sj7U70A6uxd5DFrFuwtLxQxzPiwG8UFf25MLbFIRweyDUDobTIi9uz0iYa83u1hwZB+tiDISORGWiKVzb1ctzLQPJvDedBD47DUyPlTfvqaYDycaoVfjteO4FN/MQj+pkvm3IFKoXPtOemBgE9+wp/obM+vu/dJRkpMI9RnF7XudaPOFslOWOftl+sa9mmWP8HWq+sMp9Z6dW6fPK1+ApZhSe+UUR0SM6x9pmVyXPjCMc/b/O/fU1x7uPjTeo2877NEw/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(478600001)(31686004)(956004)(66476007)(186003)(4001150100001)(36756003)(6486002)(66556008)(316002)(26005)(16526019)(8936002)(31696002)(83380400001)(8676002)(66946007)(2616005)(110136005)(2906002)(16576012)(52116002)(5660300002)(36916002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1Iypq2v4K2B2h6eWr++MBLLYwQRtts+sm1f6rcui43Gd0Z03P99oXxwE+GVR0DSBMdUL+nGDwo17iX8SJLopvMlq6ymYRm4kc2zh2l1N8QRMPsAdJP5oR9ozoX63/ZoKM2kCZPwrtE0ibnZwI/nhaTdtq7JaubjMgVj6tgTR1dq4UgUq0AvEvTv8RlfxEY0PyCYyJilomOMW8dDDfgacyIBzHkqxDojfDdeejMEMTvjyfePN2TNa2uBWbvl03kx+pdhTITuxNZYFzYFLDCsqK89xWGzAP9LS3vjubVzHHQcjbksu39sMSQFALxLWNe+RAJo+DQeABI8O02AFyR1ewlCSuZzjyC0NZhEdJXdGHRcLNBZfqpO4vSLfw3tIK3lHiFw/jQfJquBsZUvz9y3/d5snLBMf/ITXDPFYZgcCUJnKQkYFl1qVq88YQZu/xYp7FWgVL1wVXuh1u9ShENBUnlCqzJmmv34NB0Q0JDZ/GIkrLZTIXrIlUeke30pTLOdaZE54XnIFmb/WgQ/Ol4FYAx0xsmW1gDGhllU4bEKwXZsHTnuIa+9dUKgytLePsZ5RnJmooZgnwHJRc/WzSNhoJZS2HvCGSYzWVkU4vl6yQtP5UI8C/xUzfquhRX99r7Kh8Y/RcaeN8VFPKLZZC7ftTs8SH9DUbCkTMLvRisTgq/JFSV2DFPsAfPEk5WFruwKCkH0MilCrRyWNRMGMYZlKnB0sYBoNbAYOQWHp1J/seO6uhCGBzHWsItlhw+llPUx5rJp8smh3kVNNwFHjlLSJk2YEBMpbKzXp85PRACt97LBU6sAFjWmY+8fNFr1EWcZDyFWJoj8mf4Ma6b8t0dG8UE78yojC40lShpO/CLTWtmrvG15BcqTFOPr2YWJk13kFgBfWgV3ldOAUXOpAJlWrnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef184c3-8d56-4b2f-1028-08d88be485a0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 17:08:08.4888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co8wkbFxNLrvB/WMMPM3olrkj/+YssbSgiooPs3IDuOQcT9KRoPtaXZRHuXxPLE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2373
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-11-18 11:47 a.m., Luben Tuikov wrote:
> On 2020-11-18 11:23, James Zhu wrote:
>> Add macro, structure and function prototype to
>> support dec vcn software ring.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 1769115..13aa417 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -44,6 +44,17 @@
>>   #define VCN_DEC_CMD_PACKET_START	0x0000000a
>>   #define VCN_DEC_CMD_PACKET_END		0x0000000b
>>   
>> +#define VCN_DEC_SW_CMD_NO_OP		0x00000000
>> +#define VCN_DEC_SW_CMD_END		0x00000001
>> +#define VCN_DEC_SW_CMD_IB		0x00000002
>> +#define VCN_DEC_SW_CMD_FENCE		0x00000003
>> +#define VCN_DEC_SW_CMD_TRAP		0x00000004
>> +#define VCN_DEC_SW_CMD_IB_AUTO		0x00000005
>> +#define VCN_DEC_SW_CMD_SEMAPHORE	0x00000006
>> +#define VCN_DEC_SW_CMD_PREEMPT_FENCE	0x00000009
>> +#define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
>> +#define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
>> +
>>   #define VCN_ENC_CMD_NO_OP		0x00000000
>>   #define VCN_ENC_CMD_END 		0x00000001
>>   #define VCN_ENC_CMD_IB			0x00000002
> Alignment is off for the above macros... perhaps TAB char
> was inserted to align the columns instead of just using
> a space char?
> [JZ] all TAB is used here, no space.
>> @@ -145,6 +156,10 @@
>>   	} while (0)
>>   
>>   #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
>> +#define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
>> +
>> +#define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>> +#define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> Here too.
>
> Regards,
> Luben
>
>>   
>>   enum fw_queue_mode {
>>   	FW_QUEUE_RING_RESET = 1,
>> @@ -236,12 +251,25 @@ struct amdgpu_fw_shared_multi_queue {
>>   	uint8_t padding[4];
>>   };
>>   
>> +struct amdgpu_fw_shared_sw_ring {
>> +	uint8_t is_enabled;
>> +	uint8_t padding[3];
>> +};
>> +
>>   struct amdgpu_fw_shared {
>>   	uint32_t present_flag_0;
>>   	uint8_t pad[53];
>>   	struct amdgpu_fw_shared_multi_queue multi_queue;
>> +	struct amdgpu_fw_shared_sw_ring sw_ring;
>>   } __attribute__((__packed__));
>>   
>> +struct amdgpu_vcn_decode_buffer {
>> +	uint32_t valid_buf_flag;
>> +	uint32_t msg_buffer_address_hi;
>> +	uint32_t msg_buffer_address_lo;
>> +	uint32_t pad[30];
>> +};
>> +
>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>> @@ -251,6 +279,8 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>>   
>>   int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
>>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>> +int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
>> +int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>>   
>>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
