Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20ABC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 15:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208C66E544;
	Thu, 25 Nov 2021 15:12:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472256E532
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 15:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQAYJFbLsexgGn6Cu4VeDx8LvQk0rGOCLQH2AZj9LStJZcL2yn9yYwVXDocCzxdo2jxhX4OAN5aHjQw8f7r/0thl39Uf5BqHVa7x2gixezxIBp3uWB8PL7s3rwT8CzMSfNH7oStk8pXuD5IMNxDhzCewLseVS7TX1gTxJ/5rAKkpmfedMfk1LZ2nq9kXtuGpNr4iQiRXTUlkj2wNz40VGGpszn/MpJC6OAui32HX0BLnzhy6mltJGprlbzzqwZhvICK/GJ3Mk55y0JzLbx/l8SQ64UX9/4vF+3prff2WVUqZWGSbtsviBRwhE/qedgxBbaVk2/D03ajBEYgXwlzYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx+t7EPXLUAzXlcLd7Q/WEO2FoIT+fm7qNaQtu4kuVA=;
 b=hlir8AljJVS4STCjdz/90XsqEBQg80EiXt/n5G3HwGzZzCm02c56eCPSCiBtcZFYg/dmeUwMLEK7/D/pUBso5ha+6KJ349A18zaU5faOFJILQwxMa37Up1n3l89tc8SqVxNbCy7gb0pkvIssuOzwqDDTAszpE3o/cbyA67bmqx3p4tv8ZHOV/Xv1yMG05JCSqJJClb0/yEX7yIGrbL+/Tm6rvDyzZ+ALU3debOGhoGE1tPCM3BnZZuVzG0+9oolPVdkKeyt15uN4nfWeSmrpek58Wuq6tpJV17jC5CJtfCTkGKVl+ZtNIfil2vSDnkaUqJbwR0xlR+t5x69TEOcIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx+t7EPXLUAzXlcLd7Q/WEO2FoIT+fm7qNaQtu4kuVA=;
 b=f/1rDiyPJU4ro+MJw3St9HmVD7/bzct8UZS8hR4GkE8f9nH+QDol9t4ajqzLgC6wObOry3snynB4cGMMOWaN3NJUcSsz/2/UTiniRCEBXcgpJv/YOEw+QmYx/SPRGAdAQj1TPrbtX6I+wRLGNIsisG6fqK7jP6xS32Stk7VzGwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 15:12:47 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 15:12:47 +0000
Subject: Re: [PATCH v6] drm/amdgpu: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211124225827.26232-1-Philip.Yang@amd.com>
 <dfaad884-e185-6dcc-df00-1cb2da4a6e50@amd.com>
 <845473a5-7c90-06ec-fb24-5e8c640aab0f@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <ad204ec6-227f-0738-b2aa-9ff580e0d051@amd.com>
Date: Thu, 25 Nov 2021 10:12:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <845473a5-7c90-06ec-fb24-5e8c640aab0f@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 15:12:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d883827f-b1d8-415a-8140-08d9b02609fd
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52480878D09308DDAC2BD585E6629@DM4PR12MB5248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUhYrENmM/80Cb3qdYPnivO9BGdd9IIHjLUXmxKxieLl85SSYcJX9uqmzFxSJvn14g3MQ2zFoXM5fZDLKtc33PpvImYFHyZW1or3OVTl03ZhQKw+pd1jzoRsxjrowDTDjgBZNBKZZh69ii6UGZLFN99Bl1J4zFarbtvcT1keuPlbjc9339HTim/lwC4AuXfl7cvY2NtnFJjnCe52UIh3ZfcC/7WTLhco0dfUjDXE5w9ttZOp0mxYkVGydzARZ9h3fvrFUEICilt8eYfIGssaZCMfrD5nNUw8QsFEA2CwHWl+onssH7lWeSW7xr+chHJmjCkjcn5TQ5PX/Oqqj9NZNHSb4xCnrY6Rx8uY2nlZUUHKe0yN7dt7QMYL7GLenqK7s8Df5bRFkkfav2pmw6/br/gBLS4NpLkKOOo5HgDS3TapPq5mCLEP2F/QOrYIrn9WiR3SIjG9oDCR88CWR7AHl77dxylFokpBXEUmToB8CJh+iIOGADi/yWscMF5Bpou4n97WYxp2E9ZsO26nvwvzbaFMLaI2WJIE5w135WkS/vNdHXWsgqTE5RjaB6SmaLGlwk+fVSLMYbINdm+Iw8C+Xe9s8eINYI6g5YcqRxUFS2xJeTMukCjGdWuDaJjmjSfgheXptClbmLBoLyFEn2ZYEoW4ylj0LFOAEJQHQVMgl1/r5/nkpAMoPMFkxExvHWViov84E76cOWzfohaPv+y/KdUJHXnRUzwbzaFALogU0uE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(956004)(2906002)(8936002)(31696002)(2616005)(66476007)(508600001)(110136005)(53546011)(5660300002)(16576012)(38100700002)(8676002)(66946007)(36756003)(6486002)(66556008)(4001150100001)(26005)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHh2L0ZjZE9TZVNRZ1hkUGcxUGpmY2s5WUpOUTFqQW9pY1NWTG9ZTU1PMmJE?=
 =?utf-8?B?aHMrbmovazZ1cjVYaGczd1Q5aUo0QUNDRUtGYXdIZU9EYzl6ZU9ZTHhsck9D?=
 =?utf-8?B?cHpkamR2QjVBbkdQeVJGY1RkWDg2aDV3MWZzdUZqekJxU1I4d0JzdG80MStl?=
 =?utf-8?B?cVlNL3NhVzgvS3QyU0VhcEVzUzVtamNwK0sxOGNMdkxSRmFIbnVRRTVZUzB3?=
 =?utf-8?B?VXBRRTJLaFI2c1I1OVphbmZVUGVvWWdPQmJVbmtpelFRZjk4d0wvK0p6YU82?=
 =?utf-8?B?YmFLSm9MYUdhT0YydTFydHhsdDU0a3hrRHNtVS9CbU40N2R5N1hxYzhJYlRW?=
 =?utf-8?B?TjREU2JERHczSlU3TmtUaWV6a1dHV3ladXpwQkV4SkRRSVhhcW02cjFTVkdi?=
 =?utf-8?B?SVc0U25nOVRvTENCUmRqamVFSmNEL0FLZFl5eXFZNlFWdkdWZHJpWW1aTHFS?=
 =?utf-8?B?bVpaVnZDWDg0cFZoeVBJc2d1Q3hYMVJmVFh6YmZMVkxuUzZaaFhBZ3ZtMHl2?=
 =?utf-8?B?TmlpTU51T293Q0tDekN4V3Z2TWdLemtyZytWSTBpVnk1OWZUeTZOS01ENmZU?=
 =?utf-8?B?NGhYNVlZMEVoamFkWjB5anRJVlNRc2NobFVRbStZemMyWnV5aG9qQ2ZhRFBk?=
 =?utf-8?B?VEVqUmhxellNbHF2eVlGNjM5cnZsNURTeVBkcXFkWmF4ZUpGVkF4Yk1sOGk2?=
 =?utf-8?B?SHFsdVJlWVBKQWNvRHEzV255M2ZJYXFqUHV2UHQzaFVNcitZVzdYMExLS3ZW?=
 =?utf-8?B?YkFrVG44aGg1WG1pSWZ3QjNjMFkwYzJyeWFEc2hKMUg4dkhiQ2dhK0Q0aC9C?=
 =?utf-8?B?Wjk3R0N2blNFTjVKMWtLNWVnSXZ2eHc2MlpRVFQrbHFEUDBKTXg3UC96VHJK?=
 =?utf-8?B?bDJpVFBtMWpVbDRyTmp4UzJZNE9mbVdpbEJaTlBoMSs2VnpiQWJkSnZDc1po?=
 =?utf-8?B?aDlvaEN3ZmZsN25jLzJFOHZOcUFuN0hSMVNOZjUyRzFOYUd1eWRLbjR3Y01M?=
 =?utf-8?B?MHJaOTJpejMrNW9kSnY1aXJrZk1pemdOWFFaU1BrTHMrbmEvY2wvZ0l2am93?=
 =?utf-8?B?ZFFTblREWEQ4VGxSUmJvMVppY3MxZ1FXU083ZDQ1dldsRUprV0RlZ2Uwdk5q?=
 =?utf-8?B?ekZXS0d4VHFIUCt1SnNTa2FCN09NNjZOdUsrbW1qM0N5VWFzU2tBc3pwNUhh?=
 =?utf-8?B?cHNHWjhLTVh0dExIcURGS2liTW1uNlBxWkVHUmxFRi82OVpnclBWT2lsVFBE?=
 =?utf-8?B?T0VuWitKS0J2akltZm1uajl1SmttQTNvWmUrNFptSzU1WXN6U3ZLZUhFc3RO?=
 =?utf-8?B?YTAxZi9JeFBpeDQzQzk2Z2Jldk1ZWVdaZ0MzdUVGek1oTlFlWjllVVBkVGZU?=
 =?utf-8?B?ekp4QWhoRWpNOXhVZEgwaERUWGVQZnA1KzV4b3JacVZHdVd4d3JqWG1CdnBF?=
 =?utf-8?B?RzdXMVpuQkt0K0xHM3dvNUdsd2xZMGJiOWxzSXU3dm8wVWlzOEhjSHlYVWw4?=
 =?utf-8?B?eG0xUUswOWVsNkZOaVc3cWEzT00rMC95YWZ0VFRqZm96VkgrbnQ2U0prYWEv?=
 =?utf-8?B?TTJTQ05GRkc1YkxBUzJIK0pxSEJVaXNIeVdFTUNBUWhob1I0NHZCamdWUE92?=
 =?utf-8?B?SzNQN1crd2ZaSVBIN3dWdHVJSG5YNk9MbXg1VEZKRlYydkJlQlZPOVYzT0Nu?=
 =?utf-8?B?YVdudjN2N0xUaWZxejRRYTFQQnhKVHUycGd5N3BjNkJ6WjhNbzh3dlZERVpS?=
 =?utf-8?B?K3dubFBBN3JYT2ZZUUlCNG5NT2pycjNMa1hGRFgxbC81WW9DN2JIeHBNdENJ?=
 =?utf-8?B?citiU0VZQSthMk5zNkpxaEJVTDdhTFZQWEltenlrdDgwUWxPUFVQanhHa0J4?=
 =?utf-8?B?dXlkSmp4MnRjN1l5cU56Q0tFd1l0ejI3V2NwbW5Rb3FlektCNFJIbFM5WFBu?=
 =?utf-8?B?RUNXbkRiVlg5aE5GMUxUY08yNVRKY1YrMTdJQ0tpOUJKSnVhMHpwRU5JRW9G?=
 =?utf-8?B?WGJSLzNQRGZqaVNlMW51QVZGdGtYV0Q2TG9JQlpTQmoybGNuK00wVy9rSG4y?=
 =?utf-8?B?WHN0VWdxWVN2STJvSW4vMUpQcjFFVXkyd1ZxOHVZYzNRY013b3Q1bUpzd0tD?=
 =?utf-8?Q?flaM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d883827f-b1d8-415a-8140-08d9b02609fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 15:12:47.3545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU81rW5h2vXk4OVa+/xwaPquCoZ79lJnm9yMshILhhf9pXyWeifO7wwVBdmVG+mL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-25 2:11 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:845473a5-7c90-06ec-fb24-5e8c640aab0f@amd.com">Am
      25.11.21 um 02:56 schrieb Felix Kuehling:
      <br>
      <blockquote type="cite">Am 2021-11-24 um 5:58 p.m. schrieb Philip
        Yang:
        <br>
        [SNIP]
        <br>
        <blockquote type="cite">&nbsp; #define amdgpu_ih_get_wptr(adev, ih)
          (adev)-&gt;irq.ih_funcs-&gt;get_wptr((adev), (ih))
          <br>
          &nbsp; #define amdgpu_ih_decode_iv(adev, iv) \
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;irq.ih_funcs-&gt;decode_iv((adev), (ih),
          (iv))
          <br>
          +#define amdgpu_ih_decode_iv_ts(adev, ih, rptr, offset) \
          <br>
          +&nbsp;&nbsp;&nbsp; (WARN_ON_ONCE(!(adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts)
          ? 0 : \
          <br>
          +&nbsp;&nbsp;&nbsp; (adev)-&gt;irq.ih_funcs-&gt;decode_iv_ts((ih), (rptr),
          (offset)))
          <br>
          &nbsp; #define amdgpu_ih_set_rptr(adev, ih)
          (adev)-&gt;irq.ih_funcs-&gt;set_rptr((adev), (ih))
          <br>
          &nbsp; &nbsp; int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct
          amdgpu_ih_ring *ih,
          <br>
          @@ -89,10 +99,12 @@ int amdgpu_ih_ring_init(struct
          amdgpu_device *adev, struct amdgpu_ih_ring *ih,
          <br>
          &nbsp; void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct
          amdgpu_ih_ring *ih);
          <br>
          &nbsp; void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const
          uint32_t *iv,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw);
          <br>
          -int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device
          *adev,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
          <br>
          +int amdgpu_ih_wait_on_checkpoint_process_ts(struct
          amdgpu_device *adev,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
          <br>
          &nbsp; int amdgpu_ih_process(struct amdgpu_device *adev, struct
          amdgpu_ih_ring *ih);
          <br>
          &nbsp; void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry);
          <br>
          +uint64_t amdgpu_ih_decode_iv_ts_helper(struct amdgpu_ih_ring
          *ih, u32 rptr,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed int offset);
          <br>
          &nbsp; #endif
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          <br>
          index 3ec5ff5a6dbe..b129898db433 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
          <br>
          @@ -119,6 +119,11 @@ static int
          gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Stale retry fault if timestamp goes backward */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry-&gt;ih == &amp;adev-&gt;irq.ih1 &amp;&amp;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ts_after(entry-&gt;timestamp,
          entry-&gt;ih-&gt;processed_timestamp))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;
          <br>
          +
          <br>
        </blockquote>
        This check should go before amdgpu_gmc_filter_faults. Otherwise
        <br>
        amdgpu_gmc_filter_faults may later drop a real fault because it
        added a
        <br>
        stale fault in its hash table.
        <br>
      </blockquote>
      <br>
      I was already wondering if we shouldn't move all of this
      completely into amdgpu_gmc_filter_faults().
      <br>
      <br>
      I mean essentially we are filtering faults here once more, just
      based on a different criteria.
      <br>
    </blockquote>
    <p>It is good idea, it also removes duplicate code in different
      interrupt handler. And retry fault timestamp check for both ring0
      and ring1.<br>
    </p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:845473a5-7c90-06ec-fb24-5e8c640aab0f@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
    </blockquote>
  </body>
</html>
