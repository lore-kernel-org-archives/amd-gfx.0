Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D45CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 19:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC9710E065;
	Thu, 19 Oct 2023 19:40:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1A310E065
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 19:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRMkuuyuWpNkqFrTYdbdS1NuxyGLZHsDl1mp2qEADj2nNVnq8UtS+32ac53K6dxg80YwxQl0oxnK0RTOB4mIaiGl8CypKjJ3WiTzQQSsYoMaGWUzoOQJhGRgkPEta3B90zawR75l85MDnFlIaRuUG6vlqrqVoixOGg7f9pHLv4RBNqvWSPDGiZxvXioF/AbD2rYrSTiIkdIHd9Haj6M59JxLDVWuDIKhrVBHjEIVWnjfHAhwVlnIB8ZIvmhxZYJFpJPr4X97moTDpx3eeSEMiN/t2GnyR0l4l8+TP5sE62THmkg5tTLWAYssS1wAzhJRPUVNvLYVvoNYTc+EA2NUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9i0IAjpm47F5PehjdOe5uDzigosxfFcOEcNWETCFpg=;
 b=n3gc1lbrT+pGilWXQHZJuL46d8niHmMAL0JEwhw4l3YeVegbbcqk5/+Hg/05/3rxHsHjz5+Zh60DNs830k0wMs1sNuQasshp8FvaTXDklI90kC9cEPXOFDlQ/YqbQKcCe1AOWkR4vLoX9R/URWrddKMoqk05DQFP2+VzpVJTGRwI0xAkc5F3cN2rWU9Jpgmofp3XBwBCHRe5zj8+VIpMcCMh7Q/d4ufNFrVmdZka4Sb9709ZCZTPkWlH+0Fzt4BiH9rGWyqq8f59aEYnluk1HVZCZ+rJiaBqvaps2vflMvAWSn9hheI++/uA5lzToSgVIuDzo3yGQhbrSC2AdN/72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9i0IAjpm47F5PehjdOe5uDzigosxfFcOEcNWETCFpg=;
 b=GL5eQbKxh+YjxTUYM+7Db6JHDvMTP/UnlPGhAqjmvYJw2RBRnEgEvs46ilMwv29FjkWJ78W1xu7X/+QT1n01+xHYXBvfHRUtTUjTmPt3TyG+dSTeiqZga2CebSwrWI7GVv08jI7rtGQr94P1Mx+T1Ln8AGIOLb7OvIHIAgSg5sU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23; Thu, 19 Oct 2023 19:40:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 19:40:05 +0000
Message-ID: <969b5e0b-af22-7cfd-cfab-dbba402d1b01@amd.com>
Date: Thu, 19 Oct 2023 15:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Use partial mapping in GPU page fault recovery
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019142441.622430-1-xiaogang.chen@amd.com>
 <9e5addf0-9e91-d67d-af6e-e89479572478@amd.com>
 <56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da2dafa-0302-47d3-bc45-08dbd0db31da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RW0m7+rMjsZ7rRoiiysTz1ZAJgNNZqgdSwDNqC+rJmi64jzegfuKrt4ue2/0snQOebk8JYf+FEZYLgQU4GmOrHzVF1LEl1JJT9+uAhcRuCuMLg/v21tlKF8xpt3huET7agRIqMdy0dmFvnJ3D8lv8bZXZMsWli94f20ra8O7Ttpo5MxhRhvJ/KQeoKT5D/0uLYszLtO0LDJyYvxaD4QK25jDbRgAJKMO/z7WjbY4ITaxEf/VvpaLSMtM8Qp1/5Q1XcQy8P7hx2Igfc99Hlsbj5oshrNLP173J9JTKjwl0trW7JPq3TrBjGZ+KDTHhcMDt6Vp9rtm2Joq836Kf53It4ihuxvQCxsSGCBZM2RTAsTquD7lMqNdEGMWwCKBUFXgaOYJLud4qjxaIR6qS5aKUM3pH1CuchGkZ09wQym2YQ9PjL7UzvDH5myjLsZt6y9/2TT5oYA0n/a7RCiFB5PVh6pbP2hCVjiYQz+re56P3gmmwmCy91spH07Kl8nsfrsy5WGltu7g+qKm5u6R8JQuD+X6lJdC43XIAPryZ6ms4xcW3K4/7SGHjUD23QULIshZRwPGi3tePvvKkavO9Xkpas7r7nz8hrytuD0Vqcce4RMMFNyNlZwaEWv5xqDRS8RSviNu4Owwmt1vRsceZLVGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(26005)(2616005)(316002)(5660300002)(6512007)(53546011)(8676002)(6506007)(4001150100001)(478600001)(83380400001)(8936002)(6666004)(4326008)(2906002)(66946007)(66476007)(66556008)(6486002)(31686004)(38100700002)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3JSbElZdjJySXZ5TXRZc2JBcTdjTzlqRlB6QmtTTlZQbWx2RlNDVGw2TlVS?=
 =?utf-8?B?YUpmVVZEdG41YW1QRUQ5SW85VnR4VGxvTjIwdExRQmtFZFdDQW5ER216Y0dp?=
 =?utf-8?B?MHQ3dVFIMTc0V2lOcVRDMi90a1hqL1ZDeWI1dkFIcVI0OEZGTkhBejNUU2VZ?=
 =?utf-8?B?TmxQWDY4eFV6UVNjQmFrUU1SbTZsT2RBRDNZMnpJM2plaVV4U1pSaGhSeHB1?=
 =?utf-8?B?UW1LN2ZTaFlGdVk3RC9leXUwQlZBaElFUzU1QUkxbHhGSzhlanVhdG1TS21j?=
 =?utf-8?B?R1R1TmllZmZWc3U4RjBpV0k1YklQMTJERjExaGUzOXcrbU52QjByQzQ1M1ZU?=
 =?utf-8?B?RzFTVUdYenp6TnRENGxJRVJCRTEwenM3YXU3dHI2OXR4c2ErQUcyUTFpWWk2?=
 =?utf-8?B?cE00V1NpWWpVd3NVaW5YTGRvSmdscGxmb0gwOWxmR2sySVpNTS84U3FyYkIy?=
 =?utf-8?B?Wk54Ykk0MTFKNHk4N2FPV3FkY1hZRjNzN1RrYklEY3FZdG9GNzZSU1hUWUJU?=
 =?utf-8?B?OEpWZ05sTU1rb25ZUkw5TitJaWFtOXFYN1AyYmJtSk1zTzY0MCt1UEp0QzNZ?=
 =?utf-8?B?QmNxL28yakFZOTlvSGVONytaL0JabGpObEFJZS92dE4zTGVqVXRuQkUwaWZj?=
 =?utf-8?B?ZkJjemhWN2dMSUUxOE81bkY1NXlGZ0dDMURzNjR2ampnS1o3SloxL0dqeTkr?=
 =?utf-8?B?UjdJUkpuWkV4ajJFMVplOXFhSGMwS2tSTU9tVExLblRlb3AwbnY2cGNJV2h2?=
 =?utf-8?B?dmV2NHNsWHU1Q0tzZjZvNWMrK0U1M1pvYWt0NnAvVmhQcUVEdjlsemFxcDVm?=
 =?utf-8?B?ekpMc1AwV2dMa2I3ZDh4M0NBZlNmSnFaWG5uY0NqMGtBSTJtbUR2VkR0TzVC?=
 =?utf-8?B?eU9xNDEyaFRjdVZocjVMZ0k4WHByRG9yNkozcG5yWURwQ2ZwcVYxU1VKT0hP?=
 =?utf-8?B?Q0VIeXlwWkZLazVtRjFBT2xjNGExaWRzSXU3andTcTFLdnJSaFp4TE45eUxX?=
 =?utf-8?B?bmNDaWdlYlc4d1RaT1A4SHJaUUdWcVNkWnZHT0pzeStGUTc2U2syUStlWGhE?=
 =?utf-8?B?U3k2RDlMVnlJRHlRa3kzNVVOanJZVTVBcnVsZkNMS3ZkN0k1UUR1ZTJqcG5T?=
 =?utf-8?B?VUxCWEdFeklwR2NGTUJmV1RXVlJnU3pCTTNGTVhVbkNZZi9xYmNwUDFWdjhU?=
 =?utf-8?B?UVVvNUxkL1JZdVZZUGtzYXE2M0FrdFBsWTFKM20rOEFOVFBmc1ZiTXVPZGJD?=
 =?utf-8?B?dDRGK2pHaFB1MUp3SWZMUENyV29DWDRkZDlheXNXS1U0bDdUQVkxRi9FRXZK?=
 =?utf-8?B?L2tQVGxYenhqQ0syaVdKYngxWWczcDByc0FSSTR6QU1nanFWZklPaVNHc0xS?=
 =?utf-8?B?bldDbnRoWkY0cEg0azZpUzNpSW9icGJrN28xenZUZzNBOEJwQWFyME52WVZB?=
 =?utf-8?B?ZzdhUWNpa3poV1ZDNGFtV2Z1bi9IOGcrQ2Q3bDkrcWsrc1E1OC9iS01aNTlO?=
 =?utf-8?B?bHlVajBwQ0RiVkt0dnhmNjN2S2MwbHZPbWhKSjhwRGRmY0ducG5UNVNZOFla?=
 =?utf-8?B?TGlHZkJrV1RPNWNQVnk3V1RqVXJXU3BhNHBrMVllaVJhSUNzYStxZVJDZ1cz?=
 =?utf-8?B?R2VObzFrU1lYQlpGTFZFTklOYU5GTkQ0L3lFZ1AzazUvQm5XaHVwZ3BYelor?=
 =?utf-8?B?OGFNd2IwLzY0c29sbnl5NG1uaDM0dUtLRWNvL2xXTzY2R1ZqcXZsV3RGaExs?=
 =?utf-8?B?ZFByWURUOS9nSCttUEI3NFpmWFJ0UlhVc01takFRRU52TGRsS1FBaHJjWGxy?=
 =?utf-8?B?MG5qejFQcjFwV2Vyd1FpSlE5cVRYaEEvVFpxeU5WRHhnYUJHYkdKSW9lSlBK?=
 =?utf-8?B?RG5XT2pZamxXV3dIZmZtSjlKVHBhQUVMeUFRZ1lrTmpYSWNFbkd2UGRmZW1W?=
 =?utf-8?B?aEhPaWxQbkNicUFtTEVSL3B2cGl5Z3d0S2kzRkZOSFNLbzhueTlKbko5akZJ?=
 =?utf-8?B?amJWRnlSUUtvWHpxMmRlL2c0SVZOVnpia01CVllPMkpncU1CeXMwbkh0NVhT?=
 =?utf-8?B?VmtlZXNLL2JFRUFzdWFNbjRYQ0JpN2xJY1FKT21vb1BKcC9jVTVoaFNaUjBs?=
 =?utf-8?Q?3nxg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da2dafa-0302-47d3-bc45-08dbd0db31da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 19:40:05.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOwfM5CtDzMYh0Jw9OOaWACUC7mQaTDxzcYeiANsdd/fVFpFAxsB3m//SM5ou2WU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-19 12:20, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com">
      <br>
      On 10/19/2023 11:08 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2023-10-19 10:24, Xiaogang.Chen wrote:
        <br>
        <blockquote type="cite">From: Xiaogang
          Chen<a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
          <br>
          <br>
          After partial migration to recover GPU page fault this patch
          does GPU vm
          <br>
          space mapping for same page range that got migrated instead of
          mapping all
          <br>
          pages of svm range in which the page fault happened.
          <br>
          <br>
          Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 33
          +++++++++++++++++++++-------
          <br>
          &nbsp; 1 file changed, 25 insertions(+), 8 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          index 54af7a2b29f8..81dbcc8a4ccc 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          @@ -1619,6 +1619,7 @@ static void *kfd_svm_page_owner(struct
          kfd_process *p, int32_t gpuidx)
          <br>
          &nbsp;&nbsp; * 5. Release page table (and SVM BO) reservation
          <br>
          &nbsp;&nbsp; */
          <br>
          &nbsp; static int svm_range_validate_and_map(struct mm_struct *mm,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long map_start, unsigned long
          map_last,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange, int32_t
          gpuidx,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool intr, bool wait, bool flush_tlb)
          <br>
          &nbsp; {
          <br>
          @@ -1630,6 +1631,12 @@ static int
          svm_range_validate_and_map(struct mm_struct *mm,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t idx;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; if (map_start &lt; prange-&gt;start || map_last &gt;
          prange-&gt;last) {
          <br>
        </blockquote>
        This is not needed, as this case should never happen, and you
        also use max/min to limit map_start, map_last below.
        <br>
      </blockquote>
      This was just a sanity check, I can remove it.
      <br>
      <blockquote type="cite">
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;range [0x%lx 0x%lx]
          out prange [0x%lx 0x%lx]\n&quot;,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_start, map_last, prange-&gt;start,
          prange-&gt;last);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx = kzalloc(sizeof(struct svm_validate_context),
          GFP_KERNEL);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ctx)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
          <br>
          @@ -1747,9 +1754,16 @@ static int
          svm_range_validate_and_map(struct mm_struct *mm,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EAGAIN;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset, npages,
          readonly,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait, flush_tlb);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_start = max(map_start, prange-&gt;start +
          offset);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_last = min(map_last, prange-&gt;start +
          offset + npages);
          <br>
        </blockquote>
        <br>
        This should move forward to outside the for loop, otherwise
        amdgpu_hmm_range_get_pages and svm_range_dma_map still work on
        the entire prange, and then prange-&gt;vram_pages update logic
        should be changed accordingly.
        <br>
        <br>
      </blockquote>
      We need use hmm function to get all vram page number on whole
      range as we did not know how many vram pages after partial
      migration, then we know if can release vram bo.
      <br>
    </blockquote>
    <p>ok,migrate to vram and migrate to ram have the vram pages updated
      already, the is needed for the splite prange. We could update
      prange-&gt;vram_pages when splitting prange, this can be done in
      another patch.</p>
    <p>map_last is inclusive,<br>
    </p>
    <p>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_last = min(map_last, prange-&gt;start + offset +
      npages - 1); <br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:56bbfe3b-38ec-22c3-4f57-61c409bc7c6c@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (map_start &lt;=
          map_last) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset = map_start - prange-&gt;start;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages = map_last - map_start + 1;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange, offset,
          npages, readonly,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;bitmap, wait,
          flush_tlb);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; next == end)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
          <br>
          @@ -1855,8 +1869,8 @@ static void
          svm_range_restore_work(struct work_struct *work)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
          MAX_GPU_INSTANCE,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, true, false);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange-&gt;start,
          prange-&gt;last, prange,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAX_GPU_INSTANCE, false, true,
          false);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map 0x%lx to gpus\n&quot;, r,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start);
          <br>
          @@ -3069,6 +3083,8 @@ svm_range_restore_pages(struct
          amdgpu_device *adev, unsigned int pasid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_start(node,
          p-&gt;lead_thread-&gt;pid, addr,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fault, timestamp);
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; start = prange-&gt;start;
          <br>
          +&nbsp;&nbsp;&nbsp; last = prange-&gt;last;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;actual_loc != 0 || best_loc != 0) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration = true;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Align migration range start and size to
          granularity size */
          <br>
          @@ -3102,10 +3118,11 @@ svm_range_restore_pages(struct
          amdgpu_device *adev, unsigned int pasid,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange, gpuidx,
          false, false, false);
          <br>
          +&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, start, last, prange,
          gpuidx, false,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, false);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svms 0x%p [0x%lx 0x%lx]
          to gpus\n&quot;,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, prange-&gt;start, prange-&gt;last);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, start, last);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_end(node,
          p-&gt;lead_thread-&gt;pid, addr,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migration);
          <br>
          @@ -3650,7 +3667,7 @@ svm_range_set_attr(struct kfd_process
          *p, struct mm_struct *mm,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = !migrated &amp;&amp; update_mapping
          &amp;&amp; prange-&gt;mapped_to_gpu;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
          MAX_GPU_INSTANCE,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange-&gt;start,
          prange-&gt;last, prange, MAX_GPU_INSTANCE,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, true, flush_tlb);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svm range\n&quot;, r);
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
