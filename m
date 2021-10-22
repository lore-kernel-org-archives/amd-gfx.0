Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546FCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 08:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F8C61056
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 08:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10F8C61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5D96E8F7;
	Fri, 22 Oct 2021 08:14:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F321A6E8F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 08:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpJa4ybQn3JOEufldpzctppNAa1B6uDEiaVs2hkd76I1vqr9OK07DzC022pdtyGUIFZ4ErV+qruCGe0QRlWr40SeIFNmakDMt5R86kx2ho3DCBxtlqRa8YkW6toU2PBQrqlVrz/jtfF3NIkOlWVQ2iFDzCfVVLcpwUUgLXKMl5AtFft1/X8+UJoAp3bTlE7T+l4Ym7xP9GWYUBHfBpFWLQ4LlQvL8nEaD05GumyHncjLwKHSZpBgqAn9i0x2tphGtweThquEw5kPYcQZNMF980KD6mCeCZWsU/miNocECQknNtIaefWmngLs5gw3eeWTLqQXitYTcA8/5f22vWzsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmXd70EDCwodm85XOS2IMxoXoQ4c0PZdBBYqIO092T0=;
 b=cfaO7be2Vf27MyQmtR3IRogfIRwjvDsrnauPO6qGSmSiE1Ma6T+R26ZNYSfhqnKe0JDTjW0wllqeAkcIGxiO/4qFVnGF42GAPswu4LRWbC1RshmwR3xmzUZt4sV+NNdlnDgto8UlJpyfS8qFH1HwoLTpwbS8eFdWIvi6LLwYyS3gvBUoLW1IwAQxM6MZ6NprNFSBRsubEQqlzu425giphxJ1By+yfylc62okkKDaKzTllthE2igj/zQR85XByYVV4N7wGpNxcV5e2HA/NSSnWc1AL8Kl9foRcfWlqXLK0DUpBbP86yS6MZeYYpsJlS+Ip/TJpgcJANJiYKmfNPJI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmXd70EDCwodm85XOS2IMxoXoQ4c0PZdBBYqIO092T0=;
 b=DzKw4HmuEprapdM5pn5X/Dab63CIkBOVti7ZODreKVfxzAyPLXHAy2uGbN8hn8xeI+R44lnJtmrraE+e9o7uo+ez8O7i/JFx1rFxNWuRrzcE7+Z0Er6TpowNWIdaCNp2P4gtiJ8zhhEyniv13fIj4rZhVKkbxqDpIuAdWTt56mc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 08:14:49 +0000
Received: from DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f]) by DM4PR12MB5232.namprd12.prod.outlook.com
 ([fe80::b488:8fd1:23c8:ed8f%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 08:14:49 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix potential bad job hw_fence underflow
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, horace.chen@amd.com, christian.koenig@amd.com,
 Andrey.Grodzovsky@amd.com
References: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <f8a0000f-453c-82c0-f197-9030640cd52f@amd.com>
Date: Fri, 22 Oct 2021 16:14:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022033354.1318362-1-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To DM4PR12MB5232.namprd12.prod.outlook.com
 (2603:10b6:5:39c::16)
MIME-Version: 1.0
Received: from [10.65.96.204] (165.204.134.244) by
 HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 08:14:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ad7e84-11e2-470c-5f2b-08d995340411
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:
X-Microsoft-Antispam-PRVS: <DM4PR12MB518428CE59D61629805321EAB7809@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo8RHR1/Yfwb9CJltnB7+yZp5Jyz2oKUCmJWJPkndHv6pRgOmi5/V4sk8dbvWlZtrX6ksX06TvNTfkGZ3SzVHExXNZS/QRrmH0Hr2boNZ6f+FuNTGxlKGzrF5Mrq3bFyaMgYYFKqzqJrAANNzJYnuYMMUlFSd3WQBMtOuMFvZYvmi982rdS9ILfL97rKFYTmbWhZBUwfbEYafr23bvybxnOVRs0QhY20li8IegGbT4XLsvqsPTBua72AgdhjwmXCXY3d19pU/DoIAz3fNnDoMgrev70wPXh8KaazdIY74pDg0IXljyimLdqnIvwrPxh0kV6pWzHHkB3ePghUyKqkYjkVoveH1ppyW01UwOb/263iHatE2UAbBmz/3BiIerFFhjgCMsMVpcVRd4/iZVdDcmFf6PNveqDt70U7NO3T8i0AdZ11aYXyXfflFZkZ6WIyLwFjbuzPnQKn0iMULdAH9tUzUDS59/2SLgXJMPeoxNaEl/jwYxFeYW42TSmrAOgIj2/tp1uSPpcW7WXHdYSywZ8s6PyD/YWlLFmkxsSuqIHv1pN1UHtZVbrAES3lf86Bh/VqDv6SR/7YRIy56VQicrOF3jMi0qSCMgSo0fBEFsiNvccu0S6aScMLPcQZMIDdCaI6QQJky3pRt3pVIz6m40ZuOZiXBFcr5SLIhnpWXNS8kbyWraYKF2JNEH2hL4fa5lLs+5szf0THd7eM92xM2A6aORa9HMdO/9YewVdLfcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5232.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(186003)(66476007)(66556008)(316002)(31696002)(6666004)(26005)(956004)(2616005)(8936002)(8676002)(38100700002)(66946007)(6486002)(508600001)(5660300002)(2906002)(16576012)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhvMzdmOHVVSEJnMzA0ME1qSDdqVkwwQVVjWFFBWm1tNzdLSmtxaEdCTnd0?=
 =?utf-8?B?RkVvb29mVjZLRk16VFBSVGJzRFFKZVBDSHQwSlYyVWk0UTVTSEJPazlPK2dl?=
 =?utf-8?B?NG5DZUlEaHlWTitBNFlLNVJybDlJd1ZLYVNnd3ZBY25RL28ybUxxSDVUdWlO?=
 =?utf-8?B?dFhJWktpQnlRSElSUDNVYU1qd3R0bi9SWXJvblhZVUt5dVZtUHhsUVhxMmpk?=
 =?utf-8?B?M2p1RnFKVDI2dldZdkF6ejlJWmJRRDdKOGR0TjdQVzMxQ0FLa3p3RWpteWZi?=
 =?utf-8?B?OGp1MnlMMm9rQUp2akdjS0N6WFNiYmg5WHozVjdOZ2RDaExMQ1N2SmdMbm9l?=
 =?utf-8?B?N3d6S3UvQ0NrVGUvSlFGajRxQldsNGdTdEdGVllxT1hYQWp5RmFINEo5MjRE?=
 =?utf-8?B?RGtvSU1uODZ0djBiKy9pTFc4dWdKRHhXcTZrQ3h2L2t5VUo5VzR4WWxqNjZz?=
 =?utf-8?B?RDVWYlkvcFNoZkx2TENxM0FqNDhhQnQxTnRaMXFJVm96WWlyb0dWR3pTR21x?=
 =?utf-8?B?M3BjcHNKUG1TZDBEQzJleGdXY1FmNzM1WXEvMFhIRzM1TGg5SHl2Yk5tSE8r?=
 =?utf-8?B?aXhjMis1S3VTbkdPRitOaVh0NW1RNFJLVjI2cHpDRm0vZ3gyMG85UzhLa2ll?=
 =?utf-8?B?S29GenpXWDhJSU5KWGdDLzhUNDdIamt3MXhWS0tMdjN2SmFvMjYwYW9pck55?=
 =?utf-8?B?RjZmejNKdG9qLzRHWEg5K2pBMFJsVUdWTnJQZDNjY2RZYTJXTXYrR1A4bDBv?=
 =?utf-8?B?dlZaUld4WnVkM1c3QzhEeitsbDIxQUVBNjdyQXM0RnhPNVh3VGVLSTJUQkJr?=
 =?utf-8?B?L3I2TzVvVG5LdjNXYUlGZGFMbGY2dDFiR0ZYdGxQRGlpUzUzOWlMUjRXdjh1?=
 =?utf-8?B?WW8xclRMOHNZbTV0U21kYUZJNWk4bkRGa2NQb0tvQ3dMSVJGenNkZGcwbGJx?=
 =?utf-8?B?R3NoclpEZzZkclJDYXpZSXlpUG8yWlZzUm9QZTRhWklXcHZrNERPanZDUmRL?=
 =?utf-8?B?MyszTkNUbzVpL1RzcGk5Uk1yRjhvRER5eHVxRkR5MDdVZHkyVHJsZlMrMkhv?=
 =?utf-8?B?bHB6U05OZndRZmpNWm91MW1KSGhSbW1BZy9DNGZuWndpTWVsVURJWmNIN1Vu?=
 =?utf-8?B?RVBzWG5zSUpBS2RLTi91S0l0NHdpNnp1V3ltWXp1TVFaQTNDZXNGY09lTDFF?=
 =?utf-8?B?cFhaVTcrQmtBbHFPeXoyc1pYZWhOYmlQSGZLczVhZFNLVkUrYWkzMVZFOGw5?=
 =?utf-8?B?WnAyRFkyVVNvVjJHVXZjb1MyRGpoNHlYU00xenowRFVuK2N4WFdPbWUxQUFD?=
 =?utf-8?B?ajYwLzBuY2RSaEpZdE1VQ0xTWkNrV1RKYjU3WGRzVjBiTnZHNVQyODFXdTlR?=
 =?utf-8?B?N29DVWdFTXU3RjBSVFhoOEpWQ2I2OUZxczl3Q2MyR3gwNm5GWWQ3d1ovaFNN?=
 =?utf-8?B?MnNKdHlNeDJqcDRwLzhtOXhWMWlYajRldGpQY0FCTThPMWFBRmsxZkIrd1Rs?=
 =?utf-8?B?RjBEei9YRUhZaUZtNFJuYy9FZzFlQXgyVXluRSt4Y0gxWFVKMytWb2hITnJP?=
 =?utf-8?B?eTJyR0o0MnYzU3h6MFJzZ2FGaDRZeCswblVIMVBsQjBhTDBLc04zK2ZwM3FQ?=
 =?utf-8?B?UTZvaktkVWllRkp5NVRFSFpSTkpaQ3VPRjRPYVd6M3l5ZzZVMm9hWGVBM1M0?=
 =?utf-8?B?UHdVZy9zVmdscU8wcWx6dXRiNXhLZlhKSkZWUWVZZUdDZjNVUlp3VW8ycUpF?=
 =?utf-8?B?TW9halVqc1Nmd1NHd2EzRUx6RFA1R0dTbEljNm5SK1Y5NDg3USs0RktKa2kx?=
 =?utf-8?B?N21tenNRdFJqMHBYcDNnYmRxbDI1bWxHd3hTcmRqci9teWhUZTI3bm50cVdu?=
 =?utf-8?B?TCtvcTdlYnR3RVdOeDdFbm9aMDhBWG93Z2h2SmJjMzIxNCtLWkxnTG84Y1dv?=
 =?utf-8?Q?MM9MpgvQZEg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ad7e84-11e2-470c-5f2b-08d995340411
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 08:14:49.1737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jingwech@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
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
Reply-To: jingwen.chen2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping

On 2021/10/22 AM11:33, Jingwen Chen wrote:
> [Why]
> In advance tdr mode, the real bad job will be resubmitted twice, while
> in drm_sched_resubmit_jobs_ext, there's a dma_fence_put, so the bad job
> is put one more time than other jobs.
>
> [How]
> Adding dma_fence_get before resbumit job in
> amdgpu_device_recheck_guilty_jobs and put the fence for normal jobs
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 41ce86244144..975f069f6fe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4841,6 +4841,9 @@ static void amdgpu_device_recheck_guilty_jobs(
>  
>  		/* clear job's guilty and depend the folowing step to decide the real one */
>  		drm_sched_reset_karma(s_job);
> +		/* for the real bad job, it will be resubmitted twice, adding a dma_fence_get
> +		 * to make sure fence is balanced */
> +		dma_fence_get(s_job->s_fence->parent);
>  		drm_sched_resubmit_jobs_ext(&ring->sched, 1);
>  
>  		ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
> @@ -4876,6 +4879,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>  
>  		/* got the hw fence, signal finished fence */
>  		atomic_dec(ring->sched.score);
> +		dma_fence_put(s_job->s_fence->parent);
>  		dma_fence_get(&s_job->s_fence->finished);
>  		dma_fence_signal(&s_job->s_fence->finished);
>  		dma_fence_put(&s_job->s_fence->finished);
