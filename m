Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4121C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 17:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EE810E0AB;
	Wed,  8 Mar 2023 17:12:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C198510E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 17:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMd0z//xVX6dwCqMUMMQBgXhCuIk1B4+2/2WvJ+9qsTH3RmpSBg7OsE4e8wixW96E1Xvnqjx3iHTUfriCDT5C73U799rvS7nc9EEw3aGNujC8lydhnSw+s0pF2IiyQfZJccxZhRTk6faek4IG8HG4+Q3po9AiF7wH4r2kSRYSQwZJNYb+kCg6bhbFgIF6jZDgKkyPO6GJGujDsRHaZmsZYHsxk/rS3NMhH0G8kqQ8ggb738NWDg2eZS4LMzQGp3VfAtl+bWyicL56CbqZyi0KnKYdb0//cK2+psNj7XovwRRO6t2Z5A1Ejvd+u1B+s9QpAMHiFfWKSKZ5cd1yg92Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGsQrbi+K4d7csNPb2Ge/d5EQ8IlACajPdPhZQz9WzE=;
 b=USjgqIYMTZLw0wemGZMmiF4Ud8gXJsMt4SoN4KqHNfVTKQgBU2PBuE43xH2X3jT2IncPbE8fdy1LtJKBiKxROhLKLk4jVSp2TbOLXiicd9Kql2dQhDD7AtPtBfh9hvYw59U/WC8lbnGZj/rM7FUyahXQkNDuNBvXQUufshJh/AqyqvxzADVxoB0RXhezqEZF6+hDRHDvIAslk7AZw0OM7BQMwSln9Ci2BM1EKXYzSrEO8k2Gew8/TfR4cp2MVIx4Y5yi7VzdzACZ8qozy26fbSn3i14xEhWoTIxzMOUJNUk5el+wr9CKrkxoJf03ann4s0VgbmI7/3ZXL2ClEEU4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGsQrbi+K4d7csNPb2Ge/d5EQ8IlACajPdPhZQz9WzE=;
 b=HkfyKXICayHZuzWN7jVguyPh1vJ8tdtizB2pwi48HjmcoP/4W8z9hvbyEDHGFocVvo2vHplN7C97+rngAtg5YXH/Vd2DtgGgvOjaY7QJS9oN2Zj/u6OMwYTCE2yfNPXNsdAIgtjf9zi1FogdVADiyyDTvX3myPvYAkL22h1VpB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 17:12:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 17:12:01 +0000
Message-ID: <35f07147-85a0-a204-b0b1-394459e2c728@amd.com>
Date: Wed, 8 Mar 2023 12:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdkfd: Get prange->offset after
 svm_range_vram_node_new
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230308074509.264478-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230308074509.264478-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::42) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0369a484-e545-472d-6fbe-08db1ff83b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sayXuubQTrxXBpDD//4leKvyMRK9dC5WFPmqNda97t3jN/wLy+UGjRc4d0RsfSawz4Mjl7/psRg9aW4RQqnfL7bOMg8pDpvBXUEiud4pyxL+DDywYkjRAg8YV3e3aCGOP2tthaW0Mg8JGdMr/K7L+976e/kDGsPqZ90BUBtLf42gRqjg7/hqspURErz+BBTaN9eg9SZPMaY3FjpSsQ/meHGdrTti6oEnxijbKS7HRff5lqv8S8/fpzIPSolB6iSVUvDxpem/WyRYzt63ZZbqz6hLC13+Ayx7iAfMuFGdHMFjgln/XbjPXMN4j0u9iYbWU+EfK7HJ4x/ccglzEK2YR8dEcuAQqfshDxSXFnjiQdNlVV3ucGmFgb8ne8fQFa5XlOsqUBqg9fg5TKzocbYK5R/yVkirz+BCsxrp6YZR3r9NWJgcDrLg35h0A20vEiGpNRk+ojifYAxZInCdUiSlFNfMpatpE7h/MajKl2lpaBE6UzWy8Rf7DLd2PQqx9BM6Z1Y2zE0fF1W2Dsnvu8019cjHgwpqhb16Lwc8P1++RW9kYohhtItGSKt970oAdYRQyBFFUjs6Ocu38OYe9+FMO/ffII9CHkj2Sa/paUOrpE43YSPYIBh1QnxjsJnehWI+0tSY2p4B/ubePFQcOQuAnvytEw/FU6ynMH5IfpUtRuS20o6rJ5/+r13ENuV/Hd4b8DnEAyXwmVWzGAi2p7jM47CTLerpaXY7sZJ8sdLnlxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199018)(478600001)(86362001)(5660300002)(6486002)(26005)(36756003)(53546011)(2616005)(2906002)(6506007)(36916002)(31696002)(186003)(6512007)(44832011)(31686004)(66556008)(66946007)(66476007)(38100700002)(8676002)(6666004)(83380400001)(8936002)(316002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWMvRG9sWkY4a01JKy9zS2hDRmdzdEhKczdCSVpRTjZlZW5qelNrNGhmeGdV?=
 =?utf-8?B?THhFYjUrK1B0OFR6TU5CZ0RkYXh1U1lBOWJuSkxpV2JJbjlTSkZlYUFKUWpM?=
 =?utf-8?B?OVVUTVNWemZYbjlRVTY5VDdGUzdZcW5lZUhBMTRQZGEzNHBIV29XM0FYYWEz?=
 =?utf-8?B?b3gvU3FDSVJraTlLcmsxL3VZWE1LN0ppY2t6aU0zWHRQcjBjV1IzdWdzNm15?=
 =?utf-8?B?citWb3dkU29Cd0RHdk5lYkx1Vk1UY1NiQks4TDJPOUZBSk14ekdDWWdCRTcx?=
 =?utf-8?B?NVZDZGRTUWFyVkVHOXhqRkljSHdzRWh4QThYZzNlMHBaalArYmJmOTNVSFJD?=
 =?utf-8?B?enBTbUR6UWpRTWxyak4zMVRVUjRjV2FsSi9LUFlyek44Tzlrbk53aU9SbGhW?=
 =?utf-8?B?TVdjRzBCTUJCNi9CcnJVQWJOUzR5YXVVYXNqeDloTStTM2R4aXk5V3N2M3NT?=
 =?utf-8?B?MTNLU1dKbTRQK1l2M2Y5VGlmSlJXcGpTejVpSFVPdTRyRkFPNnEvUE1rWGVS?=
 =?utf-8?B?VE5JUmxVMXplTE93emQ0blZZUjlxVDNqekU3WG55dUZycTNlL0NGU2l4L0xL?=
 =?utf-8?B?WDdtWEdiWkRjYncyRUdlVm5jZS96YWhIaUZIM2ZGUFBoaVpLTjdJRXBwNndN?=
 =?utf-8?B?d1pWdkluNEMyWUs3VlJ1NkJmS1hldGYzNStzWXJzUjZocVhUR0NMMENraDZK?=
 =?utf-8?B?bUZuRENvV1FZTTY1S3JPQzhQb1hvaUZzalRSMjcyNmt5dFdWQ2Y4Mk1TVEd2?=
 =?utf-8?B?OVozcjhSTTFlNFJjcDFOSHJvSUVtNmFEbFR6VmNsd2I0U3AxNCtLcmtONHJZ?=
 =?utf-8?B?TEM2SkpOYTRHWFRLRkJhVjFhUkNHOC9pZ3FSNENlU3k1dDlTTzVVYlhJNlNH?=
 =?utf-8?B?bHVZNXJRSG5XcmpCZzVyL1BNVVY4dGhacnBTT3ZFcEp6NHVSVDVScGl6NDA1?=
 =?utf-8?B?QXgvQS9yNzNJZytqSUxiZkI0ajUzL051SjhsWVhkbStkRmQ3Tmt0M1FQb2Vn?=
 =?utf-8?B?MzlwdExGUFdpdHowUW9CZEJ5ZkNtMk1WRUZhaUF1K1JVVStLazROZXNsMWR3?=
 =?utf-8?B?eWdGUnIrMHRtOTBlc015OXNkQXRSVnUwdTk4WkYxSWhUaU02d1hsdmZ2WUJ1?=
 =?utf-8?B?Y05NUnFiVzM5UkVQWnZKMGt0S3Bldmo5ZkhYUG0vMTdDbkxUUjlkK3ZyNHNh?=
 =?utf-8?B?WnUyMElzcGxMT3QxWkwyb1BGVEYvY2VhaSsxM2xKMGN5M0xsY2IwQ3RwQlY1?=
 =?utf-8?B?MmdySnVGNFQ3QzR5a20weDJ5eGF0eEZ2VkFaSDhoYjdyVmhvQk5oQ1Bkakx3?=
 =?utf-8?B?R21tUnhGTXVVZWxGekozbzJwb1hlTDdKYThURTYyajV0OFpwTkZZcURYRlN3?=
 =?utf-8?B?WEdYNVM0cllwWjJMSXE5ZVdUVmRRZlZxemVZZTJtMWZnT2RQNzVFMXVqZDIx?=
 =?utf-8?B?a2djTm4ySkc2Z0JCcUVQcklzVFlzeU1lY25YTFJiN1ZzMGJiSUZEYjJoR2Nu?=
 =?utf-8?B?bm1OZ3JlbkV1VExTaG1sSVh3QnkrMTNxNGN4Nlg4bUpaWnVIcUlseENmcGl1?=
 =?utf-8?B?eDFrNVVsZDR0MVV6eGZJMFpzblJ4NjdlbUFBTVBhcWZGcG1ZR0pRbTJ5bHlu?=
 =?utf-8?B?VkVhc2pXU2xKbkdTZEtLRDU3eFlpOFNiak1pZzBaZ3U5Q25NcytxYzJzRkFB?=
 =?utf-8?B?OE5ubWo1Z1ozS1Z4QVo3aWpJcU96MnpmT29YeUM5Snp6OG1QTmNDV0pjcktV?=
 =?utf-8?B?bCtFQ1J3Y1MwcjU2b3lGNzMvSGdTTC9LZDRiMXJUZHVicFQvd3JPTHVSTzhJ?=
 =?utf-8?B?bno4STZYZk5pK1VMMyt4RnBQR0ZnY2U0R0tzOVlPa1NXSG5FSUYyTFg3aGYy?=
 =?utf-8?B?QnNINGFuMVVYYld0VHhyN3VTbll3dHpQcG5UUis5anhSc1owaUlnb3p3MXlp?=
 =?utf-8?B?blVQVHdQWVZCakNPem5ZRFVEMWpGVlBxcW9Obm43ZjBoY0xrdlYwUlZJdFFp?=
 =?utf-8?B?M0grdlFrWnJHWmkxMGozcnZoc013WUorSk9Ecnh2L0RhSDBONkZDZTBSdGdI?=
 =?utf-8?B?K1gzUm5IY28xQXJnVkI2Ky8xWkIzdzVTcVlJWTNXV3lJbzFFWUNCcVFYRFFH?=
 =?utf-8?Q?XzgpeaSuFUyKBQPI9q/bITeOi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0369a484-e545-472d-6fbe-08db1ff83b2b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 17:12:00.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GFlsd0xb4v2eHbCtSbXWp52OvfvWHpLpssWxoXV2zavuIBPWVATNde/h4gXdIqAQoGPw/JKNwFE9JPmUMo4Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
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

On 2023-03-08 02:45, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> During miration to vram prange->offset is valid after vram buffer is located,
> either use old one or allocate a new one. Move svm_range_vram_node_new before migrate
> for each vma to get valid prange->offset.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

I'd  prefer to keep svm_range_vram_node_new in svm_migrate_copy_to_vram. 
Logically the memory allocation should be after migrate_vma_setup. If 
migrate_vma_setup finds that there is nothing to migrate, we should not 
allocate any memory.

Does this fix a real issue, or is this a theoretical fix? I think it 
should probably work correctly without this patch. 
svm_range_vram_node_new sets prange->offset to 0. If no VRAM was 
previously allocated, it should already be 0, so nothing changes. Maybe 
we just need a fix to set prange->offset = 0 in svm_range_vram_node_free.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fd54a00e7229..15791490c23e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -310,12 +310,6 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	src = scratch;
>   	dst = (uint64_t *)(scratch + npages);
>   
> -	r = svm_range_vram_node_new(adev, prange, true);
> -	if (r) {
> -		dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
> -		goto out;
> -	}
> -
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
>   	for (i = j = 0; i < npages; i++) {
> @@ -525,6 +519,12 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> +
> +	r = svm_range_vram_node_new(adev, prange, true);
> +	if (r) {
> +		dev_dbg(adev->dev, "fail %d to alloc vram\n", r);
> +		return r;
> +	}
>   	ttm_res_offset = prange->offset << PAGE_SHIFT;
>   
>   	for (addr = start; addr < end;) {
