Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BC7C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D49761058
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D49761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC9916E7F1;
	Thu, 26 Aug 2021 11:47:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC146E7F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6V2ZEtxh3AxWteyNY9iTnJ9E6XYAjlhe6f/Bpoab5DByHJaEJf2s5Hazfse2a5PTMUnq1R8/84n9Bx+fgaUy031uFZV/yGMR8brC5lzsyQ9h8MuMtVHhjQTGbYUC/2hYr7rbK4S+QNkgTcIrhliy8voKXdM0WvW4QnJ8cxLD11q6NTJHi1XN2NC0Gy3tN+m0jHzi8tW97E3AGLDKesxe45rg110DD5W/Zdgt9yYe6yS4FHfUdR0xZjcyzg7x6BazCeX59nvnLj/8J/ckr/5Vudw4S7dUbuCguu8pAqFx28LSjKTwBao7CjoIJPqSGWWvSdmZZHbOMU6BUWwyr830g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDB/g9Yix/pPiSaY3uTrdVBnOpMplswXOxMijq5kTM=;
 b=g7AMgqlUmC6FjmEDPX94kv9sDnsthj4PT0QjGQYu1MjQsyLNVnJHnyYq5BKVPtZFP1wg3vXUC2T0xi7DJZ9sYVta1uh4BmJmmP1/tVTwgIU4NF5xvxmbYU6li/2fVSwm+5JfJD2Eq6RTtIDvd/Ln35MQapa7OKxK17OlZ6AezybzN+yPwOPWtgCotJlncBYnbi+oz1qh6yWUMb6lGQR3FKW/rxcVV1elKQh3aW7X3od/GAIO/Ho5srZAkNccnog/k8LAiEwhGkXe9TAr0VT3NxNzxBY4KqbsHFgKJvD6jDyiXFlkQMgzWKNLw1BTtx1iYwioNSZI0JwxrRihiJqnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDB/g9Yix/pPiSaY3uTrdVBnOpMplswXOxMijq5kTM=;
 b=31h+HTvGbPgQWX4y0aagHhJpzX4NJ2JCDSbz4SEZRdo/0eg2iOSjhz9rLiktB9Za3wzABZJ/LviLMxzQXF9GOznLc40sIgjTsOtEUEZ3KU477VsMFj29g8AWloJBkQgmd7hGH29XP+O7/vcbBN7DSnDxkvASkfsOvEfEnj6sFkI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:e0::24)
 by CH0PR12MB5219.namprd12.prod.outlook.com (2603:10b6:610:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 11:32:28 +0000
Received: from CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b]) by CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b%8]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 11:32:28 +0000
Subject: Re: [PATCH 2/5] drm/amdgpu/vcn:set vcn encode ring priority level
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-2-satyajit.sahu@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <2a818da4-dc8e-a9b6-c85e-9a6cfef8b537@amd.com>
Date: Thu, 26 Aug 2021 17:02:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826071307.136010-2-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::34) To CH0PR12MB5025.namprd12.prod.outlook.com
 (2603:10b6:610:e0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.19 via Frontend Transport; Thu, 26 Aug 2021 11:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 549a7036-ba03-4c63-b613-08d968852eac
X-MS-TrafficTypeDiagnostic: CH0PR12MB5219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52194371863A13A30B3AD362F2C79@CH0PR12MB5219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO5gyjAAbzu2Afy/dOI0rOat0aEou6ttKUr1XOjcHtiCVAdBEwhOLR+37LKWVgCXpzE/a2rIelbYI9pDwL9Y+yssSBsrluXdjCBf0WxrloVh6QVifWXG48UxfjhKSm3AQuFLsuaDJ9N+iNp0TIiEL+EKWiFK4LLL2UQNv5kvfcyh4J1j1YYO8SWAKoTS5AlVV3sxzjPY8wdTjC7abAAqUuKoDOTP+og04BI3LdpAmhX3F+UgPMka16mNbqzMNtdqzQDF3iT3PO6w3v1nGYRBL7f2OEZitsPedOjSFUrsQ/ThHrHVtzvkPzY9yPSPFGxCppbQybmippH4CKBHaUe8SUA3u2p9n3apHUIjM7/f8nV8rVSwDZU/jeNxyYECRZxjwIH//Z0Wrvaujj3rqhinDBT25J0T3Lu1nhE1ZvNnXcgU7fXmyDFLsiBWju4w02znAQSp8XcO7dxuwPc1zmSbtZvPW/JcfyUpdSc7CwxbWLHW8NOItmu2tK0J64+TI9jvQ7n8t7OlkLVWvyixOwCRzzHREW8iqQ0pvboqXXGSaKrnEBkXqMVDUmVVqRQD46r9dSs6E03G1ZvmRlSnJxTsixaW1jE4xdhXoi0+9W3MseQPncNlfMjoCyQIvYI9cZwL/VNq9yx/HvyZki1XG6XB2mfcMelFb+GJ7fGivHKXqfJ5aaO1Liue69o1f7J1lmfakz8wQqXPzMslJOImepkNLxNsyLJcSciHdjCg3v75jZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(26005)(186003)(956004)(86362001)(36756003)(66946007)(66476007)(2616005)(66556008)(8936002)(8676002)(316002)(31696002)(55236004)(53546011)(38100700002)(31686004)(6486002)(5660300002)(2906002)(478600001)(16576012)(4326008)(83380400001)(1006002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNDSVIvaWRTQmtjN3RyQ0JMclYyUlNnVUtJd1pCdE1LaGRGT2lzZzVIK2p0?=
 =?utf-8?B?TXZPN3BpbjIvUlZQbWFXdWdFNnFyZ1NlZkxESGh1NDI4YjlpSXZMTXBjYnNX?=
 =?utf-8?B?VEJEU1UyVm9iZjB4d1kvVS96SUhNcStiVFRTMXlRVUt2STI0Tk45M1lPSXZU?=
 =?utf-8?B?TGtCUjhpSzVFWThMaWtpSnNvUzAyM0VXMndsKzRTK0tHWTloUW1GYUN4RVls?=
 =?utf-8?B?M01ZQlQwcU8rRURvNlc3SkxBWUFZUk52dlVuRjJvVHA1emNEWkhRZ2QyTE9E?=
 =?utf-8?B?U0Zva0l5L2ZIL09FaEVSbmNnSXdORytWVFM0MjZTYVlSRFFaSEFkbUxMVUZF?=
 =?utf-8?B?U25yMjYyUHMyeCtNcGNGRTBvSjVITk0zeXoxVFladjJlNHp4L2J4SEI1K2I5?=
 =?utf-8?B?UW9TT1hBQXhRRWtwT1kyY1VTcG0vazVGbjNpQXY4MXZHajZIcU5OK0hMbzZ1?=
 =?utf-8?B?QTM4a1ZuMlRrdXc1ZEMxOENSTDdBS09tSkk0bklYQ25IbkF3WFA1RE85OWtX?=
 =?utf-8?B?YjNqMFlBd1JaOCtIcWRRaVdlMFRQYkFnMC8zQkpsRkwzRHJ6a0ZRaVBFSW5x?=
 =?utf-8?B?L0kwc3F4SkFvdG5lYm1WNEhUTlZQb2VaS3VRRjRvRFZiU09CcTJLVFFVUjV4?=
 =?utf-8?B?Q2JEWE9JUmFNVjRPaUF5bUJBUFJWY01laUxJUVBZM1FvdlphY3BNT1RrNzli?=
 =?utf-8?B?K01WZlJJd0FrK0tjUHJ1KzJqbkdVcTNJclgvdXBLYk8rR21lOU1RTmh4Q2My?=
 =?utf-8?B?SXNXSTF0OHEvM3RTeU1PTjloM1FIdmZRaFEvRkcya0Rxc3EydFZobDhsMVF5?=
 =?utf-8?B?bDZRWlNLV2htKzlTZFQwTFFveUtWQmlienlyVjExbWJoNng2aGdvTHhqaGpM?=
 =?utf-8?B?WlFISkxHandPY0FURi9EcGx2SnRReDhtNUE4TTM5SU44eXVsYlpvNnpVSFdu?=
 =?utf-8?B?SmRMNkQrYVU3aTdia0Q3UFZ6T3BLd3lZRVdWS21vK3VkZERrNVlUbjI1b2Zm?=
 =?utf-8?B?Q1Q2OTBTSFdxQ3dxWktyYnoxYzFMQUt4cUc1R2U2alNiV0ltS2E1ZHpLVmM1?=
 =?utf-8?B?K1Q3VnpjMUxNOUlMUmY4WVh2c2ZPTklJeFVTdnRDcmIyeHdqR2ZLeVphckpY?=
 =?utf-8?B?LzFObG9pQ0IyUllWZ1JUS3JQaE8yWTVSS3FjMmp6blI4TUovMlRsemVVaWMr?=
 =?utf-8?B?Z2lyekErL2o3NndjMU1GSFBwbEdLVjBKSHpRQzZjUEw0UzE5YmpTMnliRlZu?=
 =?utf-8?B?dUZKSXdmVFVxYjdrTHdmKzNiZXNpeDd0VjRDanIzdTI4c0tKYmZaU3ZVK2VG?=
 =?utf-8?B?WGNuTUttQ1FtcUduSk5ET0hOc2w4azB1SlVSQ3A5MzZFYlFGOVhpb1lkcUhp?=
 =?utf-8?B?bElQcXRDMTJ4NHhPY0xLNldZSXFnU2tyRWQ2T2RlQXQ2OVY5NlhUMERBUHB2?=
 =?utf-8?B?QzZZUjFBSjBBMGx0SnBOYXNTMUFiVGRxVDFyV0FQQXhkaDMyUE1JalcrT2t6?=
 =?utf-8?B?QXFOVzJreldmek9tbHZXL3drZlJreXlGTnZ6T21KcGlxSUZFOFVyaFhsMXpD?=
 =?utf-8?B?S2oyS3JSUEV2bUFRUFo2S3gxeGpsU1UyNnE5YXUwcXlnR0ZIZWFOY1l1d3VS?=
 =?utf-8?B?OGEyWWpQdVpLMTloT3BJZXlLS0tWWExGdVJRY0ZlZkxMRVJnQStKaGs1dGl4?=
 =?utf-8?B?ZitDRFpCRE80dEs1TUVIN0twUHNhTThIZWlGRVhKY0p4WTBsaDlKWitYdnQw?=
 =?utf-8?Q?WUfq2tfeKCZgQSYgPyeHFp90BMHObodbd24qdS7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549a7036-ba03-4c63-b613-08d968852eac
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:32:28.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MK12mZIoCvtc3kiPYLPt5OR+hMjPOKRlKUsgsXSSshbCpKDOp2bksc6WY9Ob091xz0l6o4BV5aV7BqV3yTwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5219
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

Hi Satyajit,

On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
> There are multiple rings available in VCN encode. Map each ring
> to different priority.
> 
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  9 +++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6780df0fb265..ce40e7a3ce05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   	return r;
>   }
> +
> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:

As discussed in the previous patches, its far better to have MACROS or 
enums instead of having 0/1/2 cases. As a matter of fact, we can always 
call it RING_0 RING_1 and so on.

If this is being done just for the traditional reasons, we can have a 
separate patch to replace it across the driver as well.

- Shashank


> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d74c62b49795..938ee73dfbfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> +enum vcn_enc_ring_priority {
> +	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCN_ENC_PRIO_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_MAX
> +};
> +
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -308,4 +315,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
> +enum vcn_enc_ring_priority amdgpu_vcn_get_enc_ring_prio(int index);
> +
>   #endif
> 
