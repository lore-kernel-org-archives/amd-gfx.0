Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E84CC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BD661042
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34BD661042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACB9899DB;
	Wed, 25 Aug 2021 08:11:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C2F899DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 08:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5bN+QYil+51f14oAz88BXC9/MZZu6RKgIxhgmih4e7jG6gg4CQ81RQGD73Uisw14zA+Ct4l5TdsZVOoK1tOuA7X9Mnwv1ntPjBt/xtGHXm5ZXjbHbRqS/YycoD0yJrkPfX73d2y+FqUleB3EPNV6urwf3q39xPrzaOlP4d6/keW4gAs3l360YuTrV4p1apWyElognjAgqfXgNrG6taudroyNFIsCr8IpCafAswesZ30fYJ54KLRTWp9zFijd1AC4foR+xouLgh0KMSFMhtwL3Xzi7SnWYhN+UgYJDtm4NF9qP8OLsNog7SLINBCa5HFHiVomd7kPPO9BmRqeIb4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlA3C1NMv196l4WiK6B1Ocu9AKMxZWRSkD2/sragw2k=;
 b=iG2Ndt4N9V5kuOwT2hJ+jpX+edWWa/j8TdmzmOsI+c/hR2vUQcSFETT/XtIT43XzLOa/8kKW8LeXIvgwWJVKghASzPQQIMOIrwc0Nkn5IXPoKAh4EiYl2cQdZHKe13agg7xZOXtFDtGoqBo6CSC8SMVQWjoRLvBM521Rlyp7vwzXD/a/BrRDqPdEeVU/K84dsdABdwiS9EhGF3Szg2QYA1vaBULuMPa2xs9+U1SRTL91yHr8Yjo59PBOplr2caRYpanxCTYDfHJsUrxNbKaL9bKmQZjZmI7l+TSPPFa5YYT/RzeSFcKvcfgV/YImwyIXEHhMWOhwiG9aIyewiXi5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlA3C1NMv196l4WiK6B1Ocu9AKMxZWRSkD2/sragw2k=;
 b=CYCNs4X/H+dQCxF7qqJ1mdzTeDdM3nOq54Kn/tsDSZura298H9tXrllAvyQuGq6oZLv7dHwXDV7/azQ+BvWRYxn6DJrVcFgdSduuagRxv2bNQlNsa9lKJ3kIEUloZGvvmI2/X5Y15JEyhoWfW/i6LDumg9cOBjTrWuQSi+YjP98=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 08:11:10 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 08:11:10 +0000
Subject: Re: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210825074424.170859-1-yifan1.zhang@amd.com>
 <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
 <BYAPR12MB3416E666FED01B9C65A6CFBDC1C69@BYAPR12MB3416.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <adb470c7-1bee-8a12-cd86-597d927862ec@amd.com>
Date: Wed, 25 Aug 2021 10:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <BYAPR12MB3416E666FED01B9C65A6CFBDC1C69@BYAPR12MB3416.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 PR3P191CA0031.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.22 via Frontend Transport; Wed, 25 Aug 2021 08:11:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64ed454-52dc-458e-9b0d-08d9679fe5d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4374AB7FEEABB9961439441783C69@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdgnZjeNKNNwtZdqg5go3LJ8ZqxPOnyQPzfdj0zUxuuW+VRkrG7kl5P3r2e+ABtuHdPizIXf/JBmc18ovXxoC0XpNnOdE/le/LsLFRWd26Xwx+Z8hFYLg648asRmZN3NVqWCL0ldB+oz9yOY4Ob6p9kurUj4kMbR6TdWTmAUml5Typ/28a5xcBwCJaEWWXBXJlrGTbemKZRyoyLNA8VsjSyjDg4NBuOY3NdmoMKrSxyTUwOC86kHkZRmfDKhPO6qxPIdNO70QYIm9y+O0zMgPR065uNTaFD/unCMK8bwUkqsL9qfRXD/H/ekifhwH+mEG2/LZhgMO0d+9PGxAX2CwpnjnF10qAz+rlErrcWzFk7Cmdyj8t9GPZeExcuaQcndlRp86fsa67TFcGiRaKloPzAw6XrAs3GhzANFrUx8j2GlJpg5cv2OgG4RKThBIchLmMON1F5Cqy9AQGnV8qtmoxt+2HnWirFhSCish+X+x243xp9PufqAaJqfGE6jzyOIq9lx3e33CO048On6sU/Gu7zPEQdLIVBPwauNS060uAAcbjt88dqGFh/s4ltkxR8+ZZ+B9hNUOaj0bV8+2Zf0LM0BoaMHsmNuJSyS+bwEbhxoRBICd8skIuuvKJTVpMvrnqE+PiRxFqDhY1PY9TcVMXamnrGb82Kvb9CURddsYC4jcYuCSnexdGAp7rv3emuhLLTD7iFkARw6NUx7DclhFVzlkG+C6gmIkyjnUj6Y40k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(5660300002)(83380400001)(53546011)(6636002)(2616005)(86362001)(8676002)(26005)(31696002)(38100700002)(6486002)(8936002)(956004)(2906002)(6666004)(36756003)(16576012)(31686004)(316002)(478600001)(66946007)(110136005)(66556008)(186003)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNwR0t4dnk0UDVBUWUzMDU2ZHo4WDJnZTRqMXRIR2pDeW5OK2dlcjhGWExj?=
 =?utf-8?B?RThEL0Q4bUhibzMyS2UvTFR4SVpaSDluZHdZSlFjVkp6NHo2Uzd3MmhOQzE2?=
 =?utf-8?B?SHNWM3VHRFMwYVlnNGExNU1lOTZsRjVPNUpOTzFkb2lnWE56M0FpZTllODZY?=
 =?utf-8?B?RnJBaVI3SUtWQk9KVWo4OTlZWTNMQXZGTi9EOCtCaXdCNWtDYjFpclB0UzRI?=
 =?utf-8?B?ZjFlNXVkbjlmbzNZUFRvV2hFbEs4dmhaT3ZoYkFYOXJZNHpIZ0FndStqTEJr?=
 =?utf-8?B?UmN6dGtMOXlJTlJnNytwUkh3Rk5LQ2FXRFhENDI3UnNtckQ2MmFRMnFrazFV?=
 =?utf-8?B?Tld6WW5YQ3BEVVhuKzVOOEIxMld1akg3dU1UM21uYzYrdUZXbVdNeHliT1Rz?=
 =?utf-8?B?alFOMzJFODRkbjFFQm9BYmhIRFFDUy9qZ2RUd21mVXQ0U1lFcC9EYis3TGxN?=
 =?utf-8?B?WGZmZksxaUdFWjF6dzR6ZDJ6cVNPZVZwWGhFcHJSYXBxNmU3S3Ywc0FOZ0VT?=
 =?utf-8?B?eGVaMlBxNHE0WFR0SXZsUEM0ZkZBbFJsTlo0NHNZNjkxNTJ0SUdRLzlQbHJp?=
 =?utf-8?B?ZmwxbXY1ZHR4REZKcm1vdEFWZkVIUm84VEUwaW12cFFkNkFVMUJ4Wkx2ZFhG?=
 =?utf-8?B?OFpHZkRkc0FWcWpmZ2puSU8xS0FZako1dmtrbUlyT2FIeDJiT3dUZjVZN1ZL?=
 =?utf-8?B?SmxuWkhuTGwrWHNYdkhhUE42elBERW8yT1lKTm9WQVBiU3ovUDRFd0pNbGxu?=
 =?utf-8?B?ei9Da1JoUGhkVEFRSGlZazBOa1V4RGJlVDVvZkRtekpPVHljVFROckh1S3A4?=
 =?utf-8?B?bTlPTlhEaHNFTTFNYVBEQVZvRi9hWmFBejB6bmtSZEpaWWRkeDcvTFhGYjUx?=
 =?utf-8?B?dWpvYkZUallmY0tjODBicFM0dFh0WE1qM2xIempJaHgydG4xSHplNU4wVFhx?=
 =?utf-8?B?YS9SbjFuL0lQQ3U5bHRvdzRRT2RCWXBmOTc3T04xdnBCa1BiYVhybkNNcnBO?=
 =?utf-8?B?NlhWd1BvT2YzNlo4dUhva2czYXd4NUlNR1dCNjlQUG1VUUtTNWNtRW12Znd1?=
 =?utf-8?B?OVNWSjk5VURUZm44aGZQa2hsemxqT1dPeGZtZkdScUFVYW9MdVNpWi9ncHNw?=
 =?utf-8?B?T2RvMjJWdGJYOTByeVhDNGdIdXllZzZnRUNEejJtQUtoS3VVN0R1WXVqa0lB?=
 =?utf-8?B?NGRCQlJJMGo5Uklva2o3WWxZSk9IdUJHTHpnZXA3UEU3SU94N3krdWZVYWpG?=
 =?utf-8?B?bHp2Q29oREJPMEMxcG5TTXQrOW5YbFp0Vmd5U2xXN0tHZVJUOEcrTmlRVUE0?=
 =?utf-8?B?VkFIdE1RbHZTM2paeHo4UWR1L252YkNqNndFRkxWZFZZOENsMWxidXBqb2x3?=
 =?utf-8?B?MVRkU1podUdLc3E1ZnQ3SjNmV2ljbGtnakJSRElEa1c0a3kwN2t1bWJWcTVt?=
 =?utf-8?B?M2JnMjNzekJ0NndRelg5TFNubGRSK2dkZTdDejN6aWxFRjUreXdaaXJST3px?=
 =?utf-8?B?THJ5dkJ4TDJKVlY0T3A3RTBGdURpODd5QTZXR0dGR2QvR1o5VUs0TlhTdWdH?=
 =?utf-8?B?b0NLVWQvSGNGdlFzRHZhZEsrZjhDREVnY2s4U2drb0pQbEg3eitOTlR4UWxI?=
 =?utf-8?B?RFFlV0s2TXZvbkV5SmQ3YmlCQnJFOFVqTlJtM1BtVTNabHpCUkkyL0c2Qm5l?=
 =?utf-8?B?eUM3bUlYSWRnMDFzV0xpdytobXVIdVJDa3cyS3pxdmQ4UXhUZjBiVFR3S1Vx?=
 =?utf-8?Q?ALGf3Dl/yC8kQvZNculPz7xz8VkwCm3OHOC6Ys9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ed454-52dc-458e-9b0d-08d9679fe5d2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 08:11:10.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHrXAN4HkQ7iPISDgqCo5QAsqDYchjt7UnSLobZHa2QC+9RcQzReGLGS1yFq96i7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

Yes, good point. And we should probably also rename the functions since 
page tables are not pinned at all.

Christian.

Am 25.08.21 um 10:04 schrieb Zhang, Yifan:
> [Public]
>
> Hi Christian,
>
> OK. Then I think we should modify the document  for amdgpu_bo_get_preferred_pin_domain since it is not only for display scanout, right ?
>
> /**
>    * amdgpu_bo_get_preferred_pin_domain - get preferred domain for scanout
>    * @adev: amdgpu device object
>    * @domain: allowed :ref:`memory domains <amdgpu_memory_domains>`
>    *
>    * Returns:
>    * Which of the allowed domains is preferred for pinning the BO for scanout.
>    */
>   uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
>                           uint32_t domain)
>   {
>       if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
>           domain = AMDGPU_GEM_DOMAIN_VRAM;
>           if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>               domain = AMDGPU_GEM_DOMAIN_GTT;
>       }
>       return domain;
>   }
>
> BRs,
> Yifan
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, August 25, 2021 3:47 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd creation
>
> Am 25.08.21 um 09:44 schrieb Yifan Zhang:
>> amdgpu_bo_get_preferred_pin_domain was added to handle system memory
>> page tables. Since system memory pt/pd is disabled now, remove
>> preferred domain judgement to avoid confusion.
> Well I would rather keep that and enable system memory page tables again.
>
> We should probably add IOMMU checks to
> amdgpu_bo_get_preferred_pin_domain() anyway. My last status is that this has been causing problems with DC as well.
>
> Alex, what do you think?
>
> Regards,
> Christian.
>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
>>    1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0b893aa21ffe..764822edba18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -926,7 +926,6 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>>    	bp.size = amdgpu_vm_bo_size(adev, level);
>>    	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>>    	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
>> -	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
>>    	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>    		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>    

