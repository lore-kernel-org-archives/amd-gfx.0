Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0416FC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 10:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15CEC10E3A3;
	Mon, 11 Dec 2023 10:38:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD44C10E089
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 10:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VITTliqXSjLHQRg9GmdMRg/GiVXMENxqVQtNhrmtQ7blihiJDmPHPoFDUxFq7N45YLmwYgB1btzWHGYc9lkokP5OAvrSrHi4+FnADqM6B3qHVNi+VuVBoOi/eZg1YabOpp1Y0n7HJ9BOPT7BgZvsrtNm9xFow3yjfC5oZAKZOQyy6GubL6pES3DP0S5i7XZqP1XUaRVO894JIUVgWonjEPpeEJ721WjPox6UDrM8HBMnD5qeYVmvt8JzT82+nhDuKykGOIGOQKOY+f0c/vhXryoKLP/Z5p4PmZQInZHH6N000Go0zukmALxJwDzlBSmChdL9SuQDuuekUJUJHbJHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DHKEMSZwjM2sJO9dHZ++7b5M083VKfGYtVpxmPoiV8=;
 b=hRP1Dywk0n0kOHvwDAq2JriThDs4ZprNsbXjNVRaj4bhFfYTne7N/s+upt9sDosteUg1sQJQalDpb2gfm7GNKLfXMkLTS6u+7lqufJxIyXzS/cirDvUzixXOaLDAJgHVF4VZEzfvuyVr7E2k/JIpKJfJkM2Del6uhG2fQzdCMWuemcmCymvPTulRRbQ2DctwBnKxux8tR0eZbHRI1idx6/SMvyHGLKQFY5yp2G695tn6KkHMcnsf60Bjeqp7DEDPcqoPdLxOB6U0Z/FgsYPj9Y7fttrb4i941Ty6OkWkI/otT0KYTI/+L1YorVdur5Va5UP8RlGoVwmXditssSXw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DHKEMSZwjM2sJO9dHZ++7b5M083VKfGYtVpxmPoiV8=;
 b=mp6hkx1haQqJTlSMKc9bdxbuAzNnGjtWfo+Fadqj4IyEby7oQI16yFXNrJ8Amq7rnVAxalha2JN083KnsCfh4ZOA1U6qj/uq8NS+pNKNiYHeGFbwrH2YQlB5mJ/u0yhiy4ysboftapZrLHk9q5I0EqNT9n9u/oRLuu0LYPavbK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:38:37 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:38:36 +0000
Message-ID: <a7821e98-8066-4870-b41d-a57e7f04a2f5@amd.com>
Date: Mon, 11 Dec 2023 11:38:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: make an improvement on
 amdgpu_hmm_range_get_pages
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
 <20231208230105.733781-2-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231208230105.733781-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 035b41c1-af04-4c81-e447-08dbfa3554d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju2RWXytw5/vlb66hyaR5Kw887wOUwZ6pOX6TOw2KfTp2Gntnn/zIHWUqw3zvTVtIRa7QR5weo37QaQc82NKSP1MgZppZYL3ZpbCP0hFwtPX7c3ArJawPszGLvtt6BC6AfCZkbVAPnydkqKsefObqOWPJ4tetaPqseAyp0af8TjTBJgFE0UHEMBZeapsXILzhKLQAyaDHEeeky6kRzF6gqglvPsAxPHi3fAAIIYA5qDNiARnl5EkdIRwYtMWLDHUr+D+cri2BUVJ9g4OUZ/Br27X7WwXGLmw9Qgl5uf/706DyQlwEp8ZjzBxB2EMplcmeGfqCkKnbK8ZTCM+ze4d1H6ZUZ0bMcpzIpiyKeme7g095NneX+V4DYqit1Jvd+9PWhlk29hhTMYyIZnnymY9A17YEA1jYkU/hos+2Cj45YbQNrubYrb2wdPoZp7BJAj/ElFG31T/YIvH54aX279wA0/eZFpW6RF10m++0wzhn7x0LJHjsFCY01Z6X9hjuH9sT6JvjbuFA1fnD4GBV7XHAsctOYM4qYP3TgpHiutm2tZrg5R1B9dluC+LoxKvMEEX6EFFa4+ek+93R/mr4N4vssetI1iMudozgN+5rHiMmb9x4xneRuF2gGNl4l0SQ5NOTEVmyme3rQ//Ix5UsYRjmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(2616005)(26005)(6486002)(478600001)(6506007)(6666004)(83380400001)(5660300002)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(4326008)(8676002)(8936002)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukh5NThlSmZUQ1FSUjBVOXpKcXFTVVNuNHcwNVUyR0NsWG91S2FqVzc2T3lo?=
 =?utf-8?B?bDlDRFBYcFNvUHBqb2VaSStoSG5WNlE0NFluaHBZeDNVcHVENFVpU2RVcmtR?=
 =?utf-8?B?bk9sWFJBMVMzcXROS1lveUUrd2M3ek5qdG8rVE45WWJVdzRubDRWdGg3am1K?=
 =?utf-8?B?SHJ3SWpuVElvY1ZGZ2V0NHE0M2hlNW5Jc3VtdnpidXAyejMxTkxDbVhDRVJh?=
 =?utf-8?B?MEpjL04reGgyTEg0UXZaL3d1aFRwYmg1VkRiVHNWVUtMb0tEYnJVM0xZUUs2?=
 =?utf-8?B?aEF6SnpTRXhmaGIvT2Q0aW96Wkt5Y0t5SHJVM1c3N3ZMVStFS3ZKS3pNYm5i?=
 =?utf-8?B?WWlDQnNqUWo4a09uZWwySjI0aWIyUTVRcmNCUTVwSHMzWUsrNW5ndDVRTXF4?=
 =?utf-8?B?bE0wcGZoUDVtR3phbXlLY0FkbVV2azRod3YzbDZBYjJLNlRsaHpreDR2MHMy?=
 =?utf-8?B?ZktOU3ptQjdoZ2YwYTZUNWdKemRaL3FBdnJZaWNtQzVzSDV5Q1VhRkpPL1No?=
 =?utf-8?B?Q21NVDdnZTNWNEZUSC90dDgyTjJ0SE5PZGgwajYvUmxqUWxia2pFa0FPVVR6?=
 =?utf-8?B?ZHowWk1EQlZ5S003U2ZtTVVyNnduZ0cycUJzUDFnNEl1VnBDand2NmFZZWtm?=
 =?utf-8?B?Q3VtbVgwV1drVW92QkZuNEd3b1FWMTVBSXYwd0V0QXZXbERaVXM1NHhzSFM0?=
 =?utf-8?B?Nno1TUxSVTI4aEN0VmhteVVDeUk1bzNXMlhJWEZoWVFwMlF1enozOWlTQzZR?=
 =?utf-8?B?Z0xlM2h2MWlIN2NJOWZ3WE43TjdBTStyb0pUbUpGeS9WeWZLd2lCZ1lXeFVY?=
 =?utf-8?B?TTQyWHJNK2oyT3RQSTNRbWFkRFN4ZFVyMzJuSXhIZncyaWxkNThLa0tKTXJF?=
 =?utf-8?B?c2U2REVsS2dhR01JcVp0YXJ6OHR1UWxIaWVSRXFTM0RtQmFubXhNWUppTkY3?=
 =?utf-8?B?aEhnQ3NuOW01L0VKNHhIeDJPdjZyanNCRzJuV3lscTFHL2NsQ3ptQmgwVENE?=
 =?utf-8?B?LzEvYmtNUGo1UU5EZGJDRklVaEM1Z0pyWXJDeVVKNzRlTVBycWJzOVZjVzVp?=
 =?utf-8?B?TUJjZkY1clg2dGNIWUpQcXpRRjg1YU0wQ3lJdXpMbG1jc0xaUmcrb2pJblpn?=
 =?utf-8?B?b2d0VU0vMnFhMytmK2FQaFEzWnJlcmt6THV5Tzd6bHFkVCtRYjh0Smk5WXdB?=
 =?utf-8?B?QUdxWjZIcFl5QUJPSi9SV3dLQVA5T2NYOXNld24rNUg4SVcvWkl5WEVpZzEy?=
 =?utf-8?B?ajV0Ymx5ZHVqcTJUSjk3MGkzT1JmT2c3NmtqWXdnbFI3c044K0sxNjNDSWpy?=
 =?utf-8?B?VHNRb1kvZzdQbDBwSUt4NW1qRGhGeWQ4YXpvcVVPWVZjQ0wxSUxrazc3dVpV?=
 =?utf-8?B?R2dUYjkzNzdiaFFoMXQzbVQ3bGlRaVl6OTR2OWtGb1ZpZ0dYemFEZFFmMlVa?=
 =?utf-8?B?dk96UVFydkpDOFhmcHB0YXBldDFjcHJBNmVrd3FOWXZjUHg3OTdRS3gxWGFW?=
 =?utf-8?B?bE5ZRVltZGhQQ0VGdHRuQWoxMFBCcHI4NHZtVjZPTFpEMWtCOVlyQmVlenVl?=
 =?utf-8?B?K20zeWVMR3JkVlEwaVR5SWpmUjF1WlZaeUdLWWxuY1pzbFAxeXJKcVU4NmFz?=
 =?utf-8?B?d0JrbW85N2VsYzBRSHBtTWRXZkFvajVHYWFwK2ZXUmhQdEV0MWI3SlFpMzFP?=
 =?utf-8?B?ZXdYbmt0VjBpcFJOVmhVeVhiZDU5MTJQMElBNkk1SnIxSVZrQjFOMnNMVVVh?=
 =?utf-8?B?U0p0Uk1tUjNBYlhPOEo1ZEdnSlRxRjV2UVpPbkhhcXNubmZVWGk2eEUzZVA3?=
 =?utf-8?B?aThTU0NKL1FkR04yQmZSTWQ4bUhWMndTNWJLWWJpS3I3SmFZNm5rUUR5UkZE?=
 =?utf-8?B?WjdQR2FwdGsrN0JNcWZ4Z09XTTFXYWs3RThic2xWM1VxbUMzSHhIUnoyZ05B?=
 =?utf-8?B?V1h0aDUyMERpVE8vQmpFMU5lTStRdDU5Y0FzL3NXVTVqTGtiYmJ0VVp5QVVJ?=
 =?utf-8?B?OHM1M3Q5ZXBkVlRKeUZocGc5MTVyaHJLMEpZbmhqRmpidk9JMXpzQlFTN096?=
 =?utf-8?B?WUcvNktocHVlNkw1OS9wZVd4L3NSUlhkeDJlNFhTT2RmYnAwL1d6eTY0YWd3?=
 =?utf-8?Q?wZ7cOsYBqT4CGfgi+PKuIQWlw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035b41c1-af04-4c81-e447-08dbfa3554d8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:38:36.8980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2ehbWCQ3sZ+Apq1uuVODkLrBLCZtCdt6klLrhOUQpA810BJdDmKEhT+cq9/IYrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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
Cc: Philip.Yang@amd.com, Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.12.23 um 00:01 schrieb James Zhu:
> Needn't do schedule for each hmm_range_fault, and use cond_resched
> to replace schedule.

cond_resched() is usually NAKed upstream since it is a NO-OP in most 
situations.

IIRC there was even a patch set to completely remove it.

Christian.

>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index b24eb5821fd1..c77c4eceea46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -199,6 +199,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>   		r = hmm_range_fault(hmm_range);
>   		if (unlikely(r)) {
> +			cond_resched();
>   			/*
>   			 * FIXME: This timeout should encompass the retry from
>   			 * mmu_interval_read_retry() as well.
> @@ -212,7 +213,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			break;
>   		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
>   		hmm_range->start = hmm_range->end;
> -		schedule();
>   	} while (hmm_range->end < end);
>   
>   	hmm_range->start = start;

