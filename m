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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE322C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B296610F8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 08:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B296610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF758989E;
	Wed, 25 Aug 2021 08:01:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (unknown
 [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154C389895
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 08:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTBeluYcEphea3+KhuskpirXbhRK685w35QaYmi/K+R7tymY6wwS7exkAkaChKRoCzVaAKydM2HAXMTB3kWfB8CUKnl8Ujhp+uh2oxzoGi4MOU5L245qhgJt3Gr2krvnX09uF6qFLsRRHGTMZHPQxe5EKpDS+jQa1QECqi91P3yDdRJTRss3d4/j6ZNJK0kPGoSGQoAUJztwJdN+Ut/RsC8MTgPU0lO78Nvjzg4oKvjyEwhw5+A1jvvp/lWNKT9h9dTzDJzTKtPtWjjC54FN5Rf1Ye9E6+5RfRdU7JFaDx5R+ylCLpoedQJ4NXk/IvjI4PybqBoFigic1NjwuNkHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO+ZyjQdo+3i24hID6qpkMvWEt3iSGVVmFozP7OoSoM=;
 b=LD/Q2Mq9G/2vyTwF9eirKv/P+88pDVJwrbeLQrR/qAHVHL55PDBjRC7D9JPMyj3Yj461294ZW4QOCRJIFv/ic2GR1v84d0DQPCGQK8EvqXlbiAf7q0pAZpwzcgVQ1+PnqRXSnHnnxYmeq+nQmqvWYc/gGoAoy41AxdBL2cLt5dkFSMpq74b2MlI2SWo8BCv3zdvDR5J/OOz+/WUqas/63UkzQHTO9qrohvg+1gbjqQAXRvSAE7U+z5FfsugV/i83RbPXYpMlHXBgPomhOUlxt+xq2BbypW5RRnC5SoIZrCCX7oH6tpICw9MlAZaIBXC1E22uUISzErwfJ+dqnFTZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO+ZyjQdo+3i24hID6qpkMvWEt3iSGVVmFozP7OoSoM=;
 b=29wDxJW6qVrji5lrUtgjPbpGnjUz2/K7rqoCNJ5V4YYosDBe3ZV1o6pULDQX+ieaZ/I9jL1pR+bOxCxTk0eN2FbxjnunkmR8r/zh6ZObhYsWKelQMsZmFa7fVYKOD4C0PJwDDF3lvqNaicFSaWvos6bLUhoQX9+qCvxZO1PYlUQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 07:46:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 07:46:38 +0000
Subject: Re: [PATCH] drm/amdgpu: remove preferred domain judgement in pt/pd
 creation
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20210825074424.170859-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <408fe6fd-bf6b-0c5b-3b02-46c7b5c716e0@amd.com>
Date: Wed, 25 Aug 2021 09:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210825074424.170859-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.6 via Frontend Transport; Wed, 25 Aug 2021 07:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e671a907-388e-4359-440d-08d9679c7823
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40616BDA0D62C97C83026B8983C69@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chv0b2ChAgC0Tx8AZqVBC8gqlw50DbjHarpa6cuu5EjHfiliqi3aTI4mPhz9JnDw/zmd0WkMWtfHngLW5rPg5DO326AXl8q74bCwpBLYZg9dKP9xGfwyMIxbzKHp94kPLMf9IdNu8W1lKlYEWv+p8AuGuPihi7V1wRu9vKUKehWQHwS0TTqptA7xKCPu+CaFkteOzOsjVkczGZtaOj307Y1t4859BnNimuDexHoWYnr36DA9lzRlC11lgeWdlCwtnGbix4P0l+zVJGLRnC2YVE2OXE9W+9YeoEkAyTjlXtsTqJZx74LD7a2WUc/xjyOj9BPoyneMe+ADhWz2kaJHE3XHF4JpoFba3piTZdskh0rM8kcWYsWPzSiLFiape/cxGBWM39aHYHeq0HyGraT/B02MJbDRHH3una+18PhwoodzVXUzYigLgQrlaNa9WBLgZ0h5CnBx9nZM85SXzxcsJYDrHWqQoLRVkktZ0CFnmQFTTH/IdhuXhooGDjalvyuQXWCIGtB4JhkmyRvluDAA34cmvDb2VELJX+4g9JSgNrWAwOqJk4FYJoVTYZEjZu5SdGbjJaczvbvGC/hbhUQik//TgpyrYr/OcKXrikjYIoqej4t7N1q71lllpquaS4J1CJ//PZlpv19a+Ujv6v+I2KPr3ycBTH3VkBh1zni+ClgW+LA528BMLEBtMhXF5IeKLxnnpS7O97mjVOmZeO3uPa7/5MFn43D0IjGsu9Da3iI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(8676002)(956004)(36756003)(31696002)(6636002)(38100700002)(2616005)(86362001)(83380400001)(478600001)(26005)(8936002)(110136005)(31686004)(6666004)(66556008)(66476007)(316002)(5660300002)(16576012)(186003)(6486002)(66946007)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BhbkVLV3JZYTMxL21NdXBBaFNzLzNmU2tEQnBGQkRaeURqcE9senNteUZR?=
 =?utf-8?B?b2gzYjlSeE1RK1dGc0dpR2NYOGxPRmNycnpIVmhLMnpIakZVNVJPTEhYOVRk?=
 =?utf-8?B?d0pUQi9oUitwVXM1ZVAxYVh1eC8xbHZMS3lLN09DVDVFSTZpUUJRc2xSMVFD?=
 =?utf-8?B?VkhvKytkVmFtU3ZHZmV3Rk5JTURzVVRYYkV1Um00R3M0ZFdadzlOZ1RIYzNr?=
 =?utf-8?B?d2R4OUg0YXphT0xoZjVKWEVOTGpUSm4vQldzUW9ZWXFMSkxTN0RBbzE2Zk16?=
 =?utf-8?B?R0ZOOEhBY3BaajRLTFpGNTk2TWd3eEhGT2V6Qmt3Vm10amRLQU9sV3U3QklM?=
 =?utf-8?B?NHBTd0x0QlYrYjMxRzJ0azBjOThybG1YTVZsQmFEZGhWNGkrTGVtYWJIUTVK?=
 =?utf-8?B?d1E3SDcxUFF0dzBnQTd0SGRZYzJzRm56L1N3bkV3SjEybTdZUVJTZ2JDRWx2?=
 =?utf-8?B?b1JhRjZVelU5TDlQc1lTVDY5czFHUXg2NlJEc2J2VE4wZXJiUnBhMXlHMlVv?=
 =?utf-8?B?NlVwTzZhZHRtMU1yUFFLYndyb2h1TUw5VVN6MTZUckFSVGd0dUZOcUF2dEN6?=
 =?utf-8?B?ZHF4ZkNnSUx2a2RJZXF4bWpJc28zSHFham9FTVY5VWlMd1NXT29ieWhPL0cr?=
 =?utf-8?B?R0hITjUvQTI3TXlic1l4NHJNWDFDQ3l3bUlTRzk3R1FJQWpmYmJ3OExEcVBn?=
 =?utf-8?B?bGhPVWRYeDdCZ3pWZzBIeEpwZXYzR3h5M1NqNGNmblFPM1V4UXQ2cWZNSjQ3?=
 =?utf-8?B?OXErTFZaVm5RZWRoTUk4aFJUeHJqb3dnY0ZtRW9UVm5URXBibXhFcDMrNU15?=
 =?utf-8?B?MUc1L1NSQUlCY3NsbWk5RUsrMmpCeEhDUkNZWEMwL2NTQ245VWlxMUZ4bTFF?=
 =?utf-8?B?YWFCM25lMUpiMmJhYmcvT0I4WTZiRGEyemVlU1RzYUdxQkhVTjFVNHIwTnpT?=
 =?utf-8?B?cFB4cEdzTTFYYU5DYlFQM09rZ09EV054azVsMkE0REFvbllHR2Zud0pzQjFk?=
 =?utf-8?B?MC9HYW0zUlE5Z0xKUXFIZC9xMDlHZ0RkcjhtNkQzS2dqTWZaamlUUWpIaVRD?=
 =?utf-8?B?TEROaUFsZ3daeWZUbzNWcDFybW1KOWhuN1c3d1RVc2w1ektPV1EydS93WjhM?=
 =?utf-8?B?L1BxZnRpeE1LYW9sU1RNb05vUVN6MnF5MVFyeDZmK0lKbi9TbGdTY2VjalQ0?=
 =?utf-8?B?Vm9WQmFkZWZlVWM5U2xvVitTUjBEcGhLM21KMm5xZkt1L290dm9pTENqM3Fs?=
 =?utf-8?B?RWljZFg3TkJPQXBQQ2swK0dmbGxZalpEblgwODRGYWlyUXRJUUJoMTFXVTJn?=
 =?utf-8?B?elNrV0drNkoyOXJUMnlQUEZIYzRhaHFHTmFjd2UvWEtudDMzU2lSVllsNjJp?=
 =?utf-8?B?c1hOdGhBcWxBd0dsMDU0cWJ0YUw3bjRNNHBTbXVtZjhMRHRaZEEyTDI1RmJx?=
 =?utf-8?B?VnNlMnkwVXV4c1JMVjdCTHdyY0pYWmpLVW5FUWZGTld1Z213R0orRHlyVGN0?=
 =?utf-8?B?VXdWSFFiQUFhQlFpditqcTFNdjZ2YTl0Q0R1dHNhaGJrTE5rN0k0d2M4OW0v?=
 =?utf-8?B?L2orV3pTb3pueGVsU0tEV3g4L2psRDQyYStFMGN2YjM1eS9kN1RLVERNNzdn?=
 =?utf-8?B?SmhGVnVEUnM1ZDJjQWhKWDE0QzFuSUE0YUVkMU9oZ2h5TXhxbGxKaWNrTjRK?=
 =?utf-8?B?ZUV0SDF3L1hiNGRiR08ySnR4K1VadWp2LzFLYm0zMlFZUWZzc0d1VThpNWZM?=
 =?utf-8?Q?WC6UpNjN+28fRqYXF4oSHdZGseln200cPcm3mt2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e671a907-388e-4359-440d-08d9679c7823
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 07:46:37.9571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh49TkkIpS9uP/g9Ut9gvqyHZwprD1oFXqf/4PWz9bdYfz5pd0DYK4FQ6CyT0zrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

Am 25.08.21 um 09:44 schrieb Yifan Zhang:
> amdgpu_bo_get_preferred_pin_domain was added to handle system memory
> page tables. Since system memory pt/pd is disabled now, remove preferred
> domain judgement to avoid confusion.

Well I would rather keep that and enable system memory page tables again.

We should probably add IOMMU checks to 
amdgpu_bo_get_preferred_pin_domain() anyway. My last status is that this 
has been causing problems with DC as well.

Alex, what do you think?

Regards,
Christian.

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0b893aa21ffe..764822edba18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -926,7 +926,6 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
>   	bp.size = amdgpu_vm_bo_size(adev, level);
>   	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
>   	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
>   	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   

