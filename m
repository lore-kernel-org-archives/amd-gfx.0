Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D410C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCE123A55
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCE123A55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97ED56E40F;
	Thu, 14 Jan 2021 14:48:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E554B6E40F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 14:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUNDbi1YzZOraqJ1Gab69rbpN7pafNxuwjdRD9qvNrh30+gm/0GQhlqV5F81zkdUD+jys9+/u4qeqIxDeyusR3fRj+tmhzPAysPILNBKo1uEOAXV5ZQXweldI0TUw2E3ZmZhSXpP/LBel0QPe9fVlIF1dnERiQUdS5iHOWjUXdzvInCFFS5reEopIMWX2V40QJqUV649f8LrltNLeMaCq0F5ecD/722KCZNxBlxZgZNhxG6bXKgEJIXN8OwW+SsZ552PKFpoMU6n/t488Qi2ZfYHm/xx4lId9IQ9veYkvXlJH/p1foWVX9GLUZiCfwdPQEvqFeQ+aHpWS9oW0wiymg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va4/oiIlfXXnhdbNmHmJAdgEczCjHWzSZhMpNSXuZEI=;
 b=I93cvANy1/yng8aoOuHa+bNdCIH1oiy05J3h6ugF+j5EwhWrKb5N56tTuT/ZQsRti7O3K4xcZJBfL0e4ugQgbmmpieJXKmjE5HUSR0MgQk7iwDLIlai8mNT+26ZjmnK0hgwIMCvaLtQzmEt8mDgzCO0TYOmWgPMz6tvlQBURyovxFHGS9rYtr7vkB8TOphHqRGSBqGW+M8epRV+62wBjm+g6I2fOimKdOC/UYhbiMWKhm+XKAxIhbAEVmg2flXE2imzMMAWY7a9j9IZQbzFVgG/j9C4OLVQT5sGLmOSlCptuZUEf+zM2TMgDQ8nwldBjSIzFZFf8dozHflBWfpXU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va4/oiIlfXXnhdbNmHmJAdgEczCjHWzSZhMpNSXuZEI=;
 b=RqRSBGq1XJU+z4K8EHxalLc/JUrjLkszONJxAxyOhDygSQ8IQMySun3TrT4KZl3bWiudGuDXF14Mb/3VqtiSZrrAsgWMbCF3HB/ibrwgS360EXrr6oNfoGUKw+7rhjPvqYVO8Tc7Ya34xQXOWjk+fcllhroFahMpVOg5QhutFgc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 14:48:44 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 14:48:44 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: set job guilty if reset skipped
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210114133729.24169-1-horace.chen@amd.com>
 <20210114133729.24169-2-horace.chen@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <c078b4be-c0ae-9baf-2565-ec6552611461@amd.com>
Date: Thu, 14 Jan 2021 09:48:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20210114133729.24169-2-horace.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0::799c]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0::799c] (2607:fea8:3edf:49b0::799c) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 14:48:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 092721d4-542a-4e90-6cda-08d8b89b7dbd
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447F0B37E426D29DF299C7CEAA80@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNI+6v4SoblHV5e+EqZ7oLqLVEkwIr7AKDNuLI15GvqH3wd0zW1cEym3uHcFf74lGDFxIvmhQT9N70aIfKF18AszVBTLxHFf6JOrub8s0q+4NiKFEv2cHFZSiHPwS/RjpmFWbnliKPByLYC4ndbMU1t7W7PG+PvP1GuaLYaYkDsMifswMiyButSvBcIi3+Ajf2hd7BpaA8/HvgLnqLFqiTtFcIE+7blfrzb01TIuG2fluzdT1eayL9r3izphpwIt3XaHFX6At1yun/4K++7sBiGLJuX1ZBjVR00plAjHHfPfbDXwr08fawUQbKmrUj6gsNkfRwoSwwIHpczKhHMh5f71Dgq0lRp3POFiqG6fhkryIiyUBuzGhiUTw+/fGUQOlOOXIEkcyrtgOliVWHYbNmK0I9v/yhwOpO/z5YURNQff/K+d/pT042eo8ykFQs8p5NlVOqLsVbadUYMyCp3VVpcUoyiGbCoNWqVMZWfcxXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(6486002)(31686004)(66946007)(66476007)(8936002)(66556008)(53546011)(52116002)(316002)(478600001)(16526019)(86362001)(186003)(8676002)(2616005)(31696002)(2906002)(36756003)(5660300002)(54906003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RVBqZXo3NS9KR3dyU0l5bGlCaDRRQXVYWS9BLzNJRWZBZ2xSdzdNTjdmeTJk?=
 =?utf-8?B?aU9jV1lkRnlqQW45alRCOUtNdUpIem1PbjNaZVlVaEdjM3AvRWxzNm1Lbnp6?=
 =?utf-8?B?OXdtZDhjU1B5b3pGZTVzVmJibjVaYnNqU2piY1luRlRWa09lbnF4OWNGZVNp?=
 =?utf-8?B?dGtzQXRFVTBHZXBTWTd0ZzN2ZEhUbXczMjl3Y0RObk5iRUJtRnNiSGlmblVX?=
 =?utf-8?B?ZW1kUEVUK01YRkphVHpsQzl0OGEwRGVPYjFCL1RObDNZaU9kOWoxOExjRTFG?=
 =?utf-8?B?bHIyL2RKTWt2WTNvN0hlQ2Y3MHduVCtOV1R5OTVCRGs0Y3dFcVlGWGdnMzlW?=
 =?utf-8?B?ZUtkbWFvaU5EMHlpKzMxeGpDWGRpN3N3bSswUHYwMmN2K1pTVUo1ZkdzbU9k?=
 =?utf-8?B?dUlnaHVmc3VTdFFsMUJGcnBubDBXbUlxcmUvWWpEWW5TbWVLaW1GMTZKU2xS?=
 =?utf-8?B?KytXaG1RZkNiVXdyeitnUUkyVlFuQm9zcjFnZFpIYzBTVjl4Mzd5YUR5aUcr?=
 =?utf-8?B?U2RTakIxSDduQVE4dWorZlBJelNlZWFOZFZrbnR4Y0dFZmlxL0g5dzJESm9u?=
 =?utf-8?B?NCttbnBGdmtwQjBXckpzREZHQmF6VFVVSXRpdWsyYTBQN3plVlNRakhrNFVE?=
 =?utf-8?B?b0syMjNBN01hLzR1RzhwY0pGSlpZd0NJc1RsRTZzdVM4TXpKOXlEZWpyVVlv?=
 =?utf-8?B?TDF4NUtMV0cvZjlNd0pxZDhoSVJpd1UwREpOK3Z2bzFRaERhYnNOTWFJSFBl?=
 =?utf-8?B?N3RxNHErdno2c3B2Rk85WW5PSXEzRjRJUnNMTHg3Z2VGWmFEdXhxVXdTNEFN?=
 =?utf-8?B?SlJDdkNDa1J5SStxTGxYRVNzSStETWF6alhQL1FNUXlKWVFqaHJIUUd3Zjht?=
 =?utf-8?B?VU00aU5nUFBLbllTV01xU0dnOWoyMU9TYitBL0RrVTZEcFk5eGdSVGFmWEhh?=
 =?utf-8?B?cnFnbjE0Ni90aGY0dkpKUW5VUkJ5WGNSTm96Ryt0ME9zTVFGaElGNHNGWlkv?=
 =?utf-8?B?VWxEek8vN0J6dDhFZ1RLSVdwZ3pTYTBVL0xoRG1MRElYYmtBb1ZXVXJyMHZY?=
 =?utf-8?B?aDduRXRESVlqNjZSZllYWnoyMk1jZ2dLQkdZV002TVBsVGdZelFrWU95cEI2?=
 =?utf-8?B?TUxMRHVKcGdPY3hFcHM1MFExcktGQVJoZjA0SUtTaHRqSERjalhHOXAxM25Y?=
 =?utf-8?B?dFFaVW0rUDV6clg0MWFKdVpXRm5wNlZiTDBOY1hrdWVKaVUyWWtFNG9Uczg3?=
 =?utf-8?B?Z2F0Z1lRdC9RbnE0LzNVWnhSL1FnVHpWMWZGNGY3VHlVcHFBVFdTR2gvMTZl?=
 =?utf-8?B?OTBvUWVQRUQyRmUwUlJwSkUwNzVxcUxJZzhYSXZaM2VITTNrcHY4MlZJK0VS?=
 =?utf-8?B?U1dVeGhFZ3RpdGc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 14:48:44.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 092721d4-542a-4e90-6cda-08d8b89b7dbd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiTQSogK7kbZOrE3lAE30Yxhxqm+ZIV9LVriWs/3p6ngjAvcf5npsRiRRkI8k1E9mORrk10E4kj7algBqDb8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 1/14/21 8:37 AM, Horace Chen wrote:
> If 2 jobs on 2 different ring timed out the at a very
> short period, the reset for second job will be skipped
> because the reset is already in progress.
>
> But it doesn't mean the second job is not guilty since it also
> timed out and can be a bad job. So before skipped out from the
> reset, we need to increase karma for this job too.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a28e138ac72c..d1112e29c8b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4572,6 +4572,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
>   			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
>   				job ? job->base.id : -1, hive->hive_id);
> +			if(job)
> +				drm_sched_increase_karma(&job->base);
>   			amdgpu_put_xgmi_hive(hive);
>   			return 0;
>   		}
> @@ -4596,6 +4598,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
>   					job ? job->base.id : -1);
>   			r = 0;
> +			if(job)
> +				drm_sched_increase_karma(&job->base);
>   			goto skip_recovery;
>   		}
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
