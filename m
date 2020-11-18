Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759E6C6369E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCD720780
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T7IZlj/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCD720780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1836E448;
	Wed, 18 Nov 2020 16:47:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575636E448
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BspEfjt3RsblGxn6t87OrdgmDOxUjdUmqYon4rYvX99FlpWUlSWdSRUL8MnHRjmUtK+boinNoxwf/vpv3MHHjwxs01+LQektKYgV4tZV/ypjmQEyfQNSUDEOvrwyoN+HND8wyzJBgdEg/c4eZTdfC4sl7tm/uGDWmHIynTPEWNkY8kTUmqzu0VvKm/Iqxqu37SoRn0iaYvWCGlI1hwN13VCEGQEpjAKYcU2eIYpMle0J3BadRkDD/sOoa1OpypzEuUGwCq1d9uOidLkW0RFF0oIelcxXxT59H/gpmZtpFvsPGgZkeiwskCrPejuLUlmdgM9e2Aa+WbZCwYJbif8H5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9fp41VlFi3/8iM+T394VUeisIINBlwvrix+h83d7KM=;
 b=F8ouCEpp2aHY1QVl4xxe8UhboF95P1lEzq6z76xNHhye66GtReZTKbcZDdLtx844qSi+iCihmV5564yzbwoC0urv4pbHq0WouZ/2LYBn5aNPzF/7dLFPmt87mOajWIgQUWB8mBXPfRwh7x7YNS6ue0IYPH9UcJPzQ1St/pv56nJ6flLMYox/lciqbWpvNaTF54GOFjNNnvV2aiNqIxZuZDQ8oFbQSm6MoGr+tUeBa51frdpuobkoBXxZ5D37kG7vp3tnsHFRAI6Lw+U4sxa4g3BStzgSXkECg5z8dYR8WisGty6XHOlUZOBVT94sYeTe7/PY5HFQ+9NOBNih88U/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9fp41VlFi3/8iM+T394VUeisIINBlwvrix+h83d7KM=;
 b=T7IZlj/A6Ko06aP90rFDmewXjk1FU9qo09ZSlpmFOtBC2yP2mrXts5NMxSf9oaWTjjeCuwX1sh6QSKaSRFuJ+i0eaT7PTHrI6TuvMInUW9XNUgOKoPPeVW53dVUbo4zfbMqc7ZV3fnsFFvOaTgP/jWkJ7FKzpYzZsNvfdqygISg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Wed, 18 Nov
 2020 16:47:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56%6]) with mapi id 15.20.3564.032; Wed, 18 Nov 2020
 16:47:32 +0000
Subject: Re: [PATCH v3 2/5] drm/amdgpu/vcn: update header to support dec vcn
 software ring
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
 <1605716641-22176-3-git-send-email-James.Zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <630259ce-6a48-4f35-3f09-cf2a27703d74@amd.com>
Date: Wed, 18 Nov 2020 11:47:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <1605716641-22176-3-git-send-email-James.Zhu@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: CH0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:610:76::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.18.65] (165.204.54.211) by
 CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.15 via Frontend Transport; Wed, 18 Nov 2020 16:47:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab73805e-7e48-4bec-4fed-08d88be1a4b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17718B29747BB00DCC004B6599E10@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tR+KmBUacG3IXHCq+d98GapCs7ZytNhwBeEItp4CzI+4KV2bj56Gk7v6tTnrDC7EkQccazA173OOBKbWvihHN07KJtYyXzwXb37cjiySI1rKlGhJhkaycuHiV3KS0N4XEQzff57y5K88vyaIqyEQbWrEmqLiyd+T1F4SRGLD5+71MtEG73SyNVmC5QtVtUBxLl3NFaBt0zu1hq9lclZO7QPUTAg5dKhhi67AyM5HUWLIFpKICOofBc6mp21lqQR6PncTFjeqxoKBrd6dPRqcZ0/plUXJWoVI1iI6Mf46jzZvKONyq7D6/h8B5uAdfcM0Tfs0m7AKebNu5Qj4DCZ/ktLN/5wOSl19Hq65Kn9fobP8UmFcGfcbb7yVmgEAaZvu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(2616005)(8676002)(52116002)(36756003)(186003)(8936002)(26005)(5660300002)(44832011)(316002)(16576012)(86362001)(53546011)(6666004)(66946007)(6486002)(66556008)(66476007)(4326008)(478600001)(83380400001)(16526019)(4001150100001)(31686004)(956004)(31696002)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uy70jcG9P+0AbvSrWvJastgtifN5g7VJJYTjG6yJSyv6n0Fe0l7AqO6baW4SV+I5aN8ikTwSTCVAbumGtiFDsDZHc5q7zD8nuTMLaFvtRpN6YEDGu0jvxrFww9ODVD2DFgyE6v1g3j8jGOKGoy5mQxw7nfRs+AzBuZGd2zCPN8xdWlZpjkSo4OHkP+yES8D8VcbxJZlDHtlbyJtz4WYLvplR9ENRCs4ujgeFsrRXnur7uxQ8Pz0MQmK3+Fehu8VYbdxb1fzLvHXMxReKa1fExk5v+uFhQ+9SiVGo3QzNoZrHaXIU39GTalqzjP87uYot6Dka/akU6SGTZ/xuOEKpCOllbYMpqEI4O/p7gn6/oN/z26oj16ZZMfMMC9QGjPCvRzGI5a/AWVlzXqi1hU+U/zEah4ai6+Bl9WlFlkf/IT7Ace4yTFPe9zBialJAzOHgdMAfqbLVmGUxyey2f+KkocnjPNcc8elzjlNucp97JvS9gTuPZJ+bEaOk22ur4rofK/ulc0BF7dLuhjIVlvjfsHg7hfllq1VDwIgrfbQ3x8Na/kmtBR9KidyPfz4ITNDM0jP53ywSPC9YkfHvU1sJWQflsuSZLkh+PrQMP3hLvpw4SJr58CwSDSvZw7Kdng74XkmLyvrVrTh/NquNzt4QaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab73805e-7e48-4bec-4fed-08d88be1a4b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:47:32.1116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zjb5CJehJIafum0F4WFxOL1Wnh+pzjFQGhcZeaeHaVskpbsoNCl7bw7rMjcGfyCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-18 11:23, James Zhu wrote:
> Add macro, structure and function prototype to
> support dec vcn software ring.
> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 1769115..13aa417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -44,6 +44,17 @@
>  #define VCN_DEC_CMD_PACKET_START	0x0000000a
>  #define VCN_DEC_CMD_PACKET_END		0x0000000b
>  
> +#define VCN_DEC_SW_CMD_NO_OP		0x00000000
> +#define VCN_DEC_SW_CMD_END		0x00000001
> +#define VCN_DEC_SW_CMD_IB		0x00000002
> +#define VCN_DEC_SW_CMD_FENCE		0x00000003
> +#define VCN_DEC_SW_CMD_TRAP		0x00000004
> +#define VCN_DEC_SW_CMD_IB_AUTO		0x00000005
> +#define VCN_DEC_SW_CMD_SEMAPHORE	0x00000006
> +#define VCN_DEC_SW_CMD_PREEMPT_FENCE	0x00000009
> +#define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
> +#define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
> +
>  #define VCN_ENC_CMD_NO_OP		0x00000000
>  #define VCN_ENC_CMD_END 		0x00000001
>  #define VCN_ENC_CMD_IB			0x00000002

Alignment is off for the above macros... perhaps TAB char
was inserted to align the columns instead of just using
a space char?

> @@ -145,6 +156,10 @@
>  	} while (0)
>  
>  #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
> +#define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
> +
> +#define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
> +#define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001

Here too.

Regards,
Luben

>  
>  enum fw_queue_mode {
>  	FW_QUEUE_RING_RESET = 1,
> @@ -236,12 +251,25 @@ struct amdgpu_fw_shared_multi_queue {
>  	uint8_t padding[4];
>  };
>  
> +struct amdgpu_fw_shared_sw_ring {
> +	uint8_t is_enabled;
> +	uint8_t padding[3];
> +};
> +
>  struct amdgpu_fw_shared {
>  	uint32_t present_flag_0;
>  	uint8_t pad[53];
>  	struct amdgpu_fw_shared_multi_queue multi_queue;
> +	struct amdgpu_fw_shared_sw_ring sw_ring;
>  } __attribute__((__packed__));
>  
> +struct amdgpu_vcn_decode_buffer {
> +	uint32_t valid_buf_flag;
> +	uint32_t msg_buffer_address_hi;
> +	uint32_t msg_buffer_address_lo;
> +	uint32_t pad[30];
> +};
> +
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -251,6 +279,8 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
>  
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
>  int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
> +int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
> +int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>  
>  int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>  int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
