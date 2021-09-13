Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA304C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB9E60F6F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACB9E60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F96189F55;
	Mon, 13 Sep 2021 06:25:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D3E89F55
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBPOHBGaXc01jmGliISmaLpvKrjoOlFBsGzENR2VdS6RiACROoauRDeOa6fBU5RoOOUwCTh/iwZC/blfN0oHD1D67yJk7f69/MpaD8AX+WbbiqdEUils1BLe4VIfuOCDjQILbQM1zWnA1HoMLb6vzIgE3e7qmqzpUUiqEInx0W52bmTHv9alzH4UrGC996tmSiViqL8OFfeW236Hono9Lv5Qj9YIiNiFZAaVDb/4piqKh3Ywzt/M+YhqgB+Iq/vmSrnOFpFAiUZ2gm9L9NmPs0REk1NbVzCFPlCZcQ61mGqTnw+G36ExmMyFxFT24Ta6Jeen5bPjcMEolc1LHGdwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BpNZK5l3rl4xcevwiOWSn4gqRFOGj/n2rbODtU0tJm4=;
 b=EVgBUUrr/WKNkmN2GoFu723Ty/fI6ejPg+9RoVP9JM0t3GtrQkWurAmveZdWcHklcqj1Sn+iaH+1A6+/BqRKjviZWrq5pGVRfYh1WAzBVKhhm6C5tn5W1dG0oc+9RI2CmTyLP3K1RhHs5RB1OTTXW5uJyE4KsFDrUg9KEmHnqEFqBFLGtjqr0mTk0Lk9oGgsfu/kUX9v2gDqtgnKUZaCj4kLxUdyLVvVWkVgjcKJoal47O9OoLh1nR/1WoIJ/6hd+rX+2U4c3MkVJwB5vdtXtrlPKprPabWsfyZlcC1xX/d9B4Vcz5eWCJdiYz/tJuI/XC4R3oUhFDqwUz/7zl8bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpNZK5l3rl4xcevwiOWSn4gqRFOGj/n2rbODtU0tJm4=;
 b=RAF3A7Lwpauf4g88AzSaUZHhl5K2wp95uvsxOleJYvVjf/Ggz1/5nI33g/c50OJ0exytWn1HD6nnzTI/ApfY4Kc01rQWYAOgfJaes+JIQV+RzqxtlnIdJqtdmBifLSA4aZqH14wWfhVrLs0u0pKTvoemJu/o3AD4n074J2JdiIQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 06:25:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:25:21 +0000
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: Introduce ring lock
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com
References: <20210913055521.27341-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4f1c2322-3e3c-43cb-dcef-209191bcdcaa@amd.com>
Date: Mon, 13 Sep 2021 08:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210913055521.27341-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.9 via Frontend Transport; Mon, 13 Sep 2021 06:25:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d092e4d2-8b66-471a-9464-08d9767f4385
X-MS-TrafficTypeDiagnostic: BL0PR12MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49161B45133153A8F04FA2DE83D99@BL0PR12MB4916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJIDoF6UpOvfN4Gxrt8bmH6bTSBukmfqOWFRqd3m7C8DMMCV/8HO2SHKL/h0TL43sSIMm4ghVbtd3XzcKl5XazYGPrrJjojHghHRBGgbBe8S1BPdw7Meulg05MPDtgB04qAAFRjvrAzg9DhBAgCls+0BnDtU9WiyT1nTMPjj+EU///Rt35dsywiCc8xaP/RT+UeJE4iAPTUrGdi1pq8Yv+86BvEOdInvDyxZBJJWnQ+eCa0OXk2x/RRqiyRFcZ4OjJYOVXsvzgC6jWJEA+2RsFKjtseCttKzJUDiBGn7Z9eq3tHVQxTO5sBOcq1DvtGAGyzLAbCWxJqfLMkujoPbAwCvOUT7EG4bbOe7n/BOczERc2YYwnOz1f7k5aJOQriuAtIAjn5kS2Jov/uk3Dy0x7YBh9fSlBkL6zCkDxRbO7FOxssojq+3CJQT9CaA1i8N9bQfg7A+NraV+dSpwD5Np4A/R5loACWVti2sQK6Fq3FSgyMIRtB3Cq/z2qHvauv3ZE6Mi/Kgad6IaVH7dTXC6wW5oAd1PLHYO1RwHKMZTK2wCIf4Wj9bPHaoSTWPUm3xJyNkDZULCI4/EJzBPv1ZKoxJ4FmBr9eyo3Lpsi3D7pFpiRuoc3e6Ae4dUDUvkZM/XLL5/RCaIvdM3y2jeyhleMf6UuQLSoR78MpdIJlERPeKyTQJARYIwqdBBP22fQdrvq3f8jlOuv+vzUWdSuOa5sDARDVbAJmg+3OL8UmA7DtRsV/I8u3AtU2ZCebGUXtn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(6666004)(66946007)(66476007)(8936002)(956004)(66556008)(31686004)(2906002)(86362001)(38100700002)(186003)(316002)(6486002)(8676002)(2616005)(31696002)(478600001)(16576012)(26005)(4326008)(5660300002)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW44MUtjK2VrMWxsaE16aXRVVHhFVjJoMTFGbHZlaTRCbjhXU21IOG1YYXIv?=
 =?utf-8?B?TEhTa0dhM0ZnNFVzbWdhbTdpQVA3Y1dpMDcwQThOTUlsOHlvcEM4WDNxQzhY?=
 =?utf-8?B?OUxhaXY5L2tmQnN0Q3pjOGZLUE1yOVF0MTdmaFAzQUJ0eEdtUUFveDhLdVdI?=
 =?utf-8?B?bU1PUEsyMFgvUTJ2OFg5cGZkRlNhRG1MTUlzRklvU1czU044VS9jZHFvbkJ6?=
 =?utf-8?B?RmF6TlhTKzZtajc1T1FTd0ZHZzdMbnRQYUd4bmlQVkxSQmgrcjJrdmVlSTc4?=
 =?utf-8?B?T3hqeXVWYnorRHJoRGcxeW1nakg3V2RDenNqU2hnVjJBRlFiRnBBU2I5aXdw?=
 =?utf-8?B?dmhKMTQvNzV5Ly9YNUpOcDNzdlBHWksydExGVVhGUGs1U3JXRmxtMzdpR1I5?=
 =?utf-8?B?VkFYZkEyRkdLTWl1WlRaZGdyVEg0ZitHd3lYcTFjaGFKYkFXVkFkSkZ1Ny9E?=
 =?utf-8?B?cCtTSWdrTC8xU1pKT1BmU25oS0ZMZnhrV0k3ZmQxNXVFdHNWeVNEanVzQXRk?=
 =?utf-8?B?Q29QUlAxNE5RRWZFTHAwL3BUTHNaaTh4TnNwdkJSYWxoS1dZMXM3ODRTbTRD?=
 =?utf-8?B?cXZHZkQ2WEdxOXVEY253cDJod0hBRzJZS0o2ZnNIY29SdjZVSW1sUUtkV3pU?=
 =?utf-8?B?TmM4bHgyL1d1V2pjWFJWTjRsMXozRWZjQzZ3QWlwdmNzZ2d4cTA2NS94cHhm?=
 =?utf-8?B?cE9MWnM2Mk9ucGpYMWIzOEhlLytkNStSaHZJK0lRZmNSR0cwZ09WQ2RnZ0RT?=
 =?utf-8?B?akg1T0ZEeGZUTC9qVVY0UmtnVjE5b3RITy9mZU1OUVd1dlgxZGxIaDQ3L3By?=
 =?utf-8?B?TEdYbVJ0K2VWSGJQa3dsOTVsTkJ3dUJPVFM5Wk5mWXdhY2pUSnNadFNub3FC?=
 =?utf-8?B?NUQ2OVc2cVpQeCtibHEwK0xmUnVPcjRRSk9lMHJkTUJGaHRDUHJUWWFseFZI?=
 =?utf-8?B?RWhGTE5VSmppc0FXTnYxVU9tTTJlemRRRnVDUkdndmtQMlBmUFFET09EVXlW?=
 =?utf-8?B?bXUrTlhkMWRQT2tkNVJsb3Q2dWtpbk9VU0VXUkIreW5ONFVJeUc5MVFNQy9p?=
 =?utf-8?B?a3pnU3ZXOUFtQitYeGZkUThObkZsQ25YcVlDNjBwYTdiY0FTN2FqWDhZeVp5?=
 =?utf-8?B?bnNuNXNKNlpGL3RRWnZ1YTlPOFVHVGd4YVBjRWNIN08ySzFLaytvZHMrSnFZ?=
 =?utf-8?B?RWFYVjMyeVFNVGNiMWN1TXNvNXBOODd0Z3AvbXBxdEdNeDBsanhVYTBjYTJT?=
 =?utf-8?B?QlFMa0RwbUIyOTJxekJVbDhFSDc0bm45OHJxM2pZRms2dDk0emdpQ2QySHly?=
 =?utf-8?B?OEhMZHBGeEZZMyt0RVJRTTBwNHA2VTFCbTVnNUg1K2xtRFRLVHFMMUdFYjJW?=
 =?utf-8?B?WXRxNm42L2VYbGl5ekVaelBGbGQ1c2JHZ3JUQXhiNjZJemNTaDFkcW9lU3lL?=
 =?utf-8?B?MmhCSDFTejUzYUFqM3VyZ1FUaklNTUgxZWdzT0NPT3lzdHhGMnl4OE5ib3Bk?=
 =?utf-8?B?RmF0RlIyWG5mVEZpM0NkU1ZYSkpiNTJJY21DN3E1TGJjWWI5aVhKamZzbkpj?=
 =?utf-8?B?MFp0UkNJV1VQdTdBMVV4NXg0T3ZoNVVzbzNpc2tmd1cwVjc0b3p1VnlwaFN4?=
 =?utf-8?B?Ukp3UC9LTFBiU1lyeFNlbjY0RTZXOFI5V3JpZzZQS3RCREQvN0lsbm1pZTFt?=
 =?utf-8?B?OWh2bXc4dUE2RWo4a1VzRlMzcmdCTWlLOGtrWmtVR2dPbUxDaEFYL3FMYUVY?=
 =?utf-8?Q?LsK+Eh6vmhTArJH9oOYw13mvfgF2Hf9tI1q0z/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d092e4d2-8b66-471a-9464-08d9767f4385
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:25:21.6736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: My3iA8I13zjQHB5WTTwuBFqg+ra2WnstG9Y+eWn4VQTNjVc5wWYr4q8Da+VH2SXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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

NAK, that is exactly what we try to avoid here.

Christian.

Am 13.09.21 um 07:55 schrieb xinhui pan:
> This is used for direct IB submission to ring.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index ab2351ba9574..f97a28a49120 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -184,6 +184,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	else if (ring == &adev->sdma.instance[0].page)
>   		sched_hw_submission = 256;
>   
> +	mutex_init(&ring->lock);
> +
>   	if (ring->adev == NULL) {
>   		if (adev->num_rings >= AMDGPU_MAX_RINGS)
>   			return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 4d380e79752c..544766429b5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -215,6 +215,7 @@ struct amdgpu_ring {
>   	struct amdgpu_fence_driver	fence_drv;
>   	struct drm_gpu_scheduler	sched;
>   
> +	struct mutex		lock;
>   	struct amdgpu_bo	*ring_obj;
>   	volatile uint32_t	*ring;
>   	unsigned		rptr_offs;

