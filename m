Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5020FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 14:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62E789E1B;
	Tue, 15 Mar 2022 14:44:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E78789E1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 14:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1w9GDHCkm4EVTPGMmSgNSmV0OqasLZZ693v4fXwds0zS2axMy3D+iVh0lJC1U/U0GTg5OCtfhAWPpc6il7ZdwaHZwceDjW7MGlOKITn0gnP5fY15Tny3rR5DB9FW3cZGk/3uyQbDQuKcoS9Fe3vwSxqnZRvI87UTWwErcMg428DkjKHqkSkSwIEBtiM8Ag+3w6E4/U6TETaAjS8C14yofxHEPPwv/1Hlpkn1oNNbfu3OjFto56lN/GLCT5IDUB9j9fHgj1SNM9176hccjKmtEktaZNucZQzr/2Wg73MS8kgKhZZQ2nZp74nMYZk9DVn7HOn1U0AimiU7kd2ALkn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GDnMaKOXTO3mlyqIsZT/1uZTiy067dL2ZfqQN4pUOE=;
 b=m0c4gpWg/fsoLxCuX1S6uhHI/8E9CfbfE/gtdNCpAyZW1so2AZ8xUpm6NXIfC/gIRGL9LUSb4r9/UZ5/tTXXvDSTPCixFMSyql8DYOWbSbXdF7/vj7dfEkkLfHYWZ8ybnZ7Q+IZArAvx5qw80YIk0CHgE2m+THeMN2tt/QKCwwskHI09zzifEeBKxaN11JG5X8BB7dk9ECridw5l9+QnpbNbnA6TFspcvmuDZxovMqm0NqoJFy636D9Cfv3vHwIJ1T6ducjjoxEwcrlK0jQxkVr2nX1OKUcFIMOjVXWE0hWn7gQJ8QKILzM4TPWY9yLJ6C16CK5+s7JZZHy34W90lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GDnMaKOXTO3mlyqIsZT/1uZTiy067dL2ZfqQN4pUOE=;
 b=1GhWQ+1k5KJiVku94hpc6yCNkL33XL1JobLhacbPmWDzgXmATbdXvuFWCEaGsJnOP9b0dz4srShM/8i1kf/Qzsp/kyiHkNvT8c5V4ENayx9tg51M35gl+jUYtWz8F50A9pFsAPHW/ipanUgs1o4SkWSMAsUn3M8qZlXew1Cj3AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 14:44:37 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::ecac:8946:43b0:c1ec%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 14:44:37 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: evict svm bo worker handle error
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314145020.9142-1-Philip.Yang@amd.com>
 <486b326f-8842-5de4-07ad-7ab1f209132e@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <919baf93-e7b2-166f-02a0-e341bcb4d214@amd.com>
Date: Tue, 15 Mar 2022 10:44:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <486b326f-8842-5de4-07ad-7ab1f209132e@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d843fd-6d4c-44d9-cd07-08da0692542e
X-MS-TrafficTypeDiagnostic: MW4PR12MB5665:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5665BB8B4818DE325D9265A0E6109@MW4PR12MB5665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYIe+v7F7evWUF03DlVFC/cady+Us8PjMzVDVio1CuDtCvtml+VUXbhckID6mEXyrywlV1qO3PXwXdy0YycNWAsRh2/f0jSrCuy92ArsL2N4neJ/1a3h/jEaymtK2Pd3NjkffnRlIcYvViUSyN4wiU1u3jz4k6MKv12WtF6ixA3GPXM7BfbUK4GHA+3OJJEZ5G0XmC5MT10QuDUncb/DDmxsBH1JR/O4Gjw141M8tMPcUkl/l7pwI4wMpxxOCKoxE1roxNzdVVMkDErf2P1NsLI3mfDQkiUMbThPBZW7Xm5bl2uIVJ3Iqv2R166jNM44SNcriaetkBOrt+2TtH4Atr+ZyHP1nnUcTjpwZ8EPCtOZPKIUMlvTiF121clzK95YBRl/M0QKGhm4UtoQAhmtH2lhmNf0EZjf7Xdxg1gi+fp4cyFZs6NnKIsMkBMENhWZYPVcJwK8FPESq5YxrYPm+ZPioQnvJdlMJtUVd+VHZSDph5zKir7jr49ewMvG3oU1bl8+6YQlI4YI+ctk+lqforYgm9pzl+lNOS4UzcXc4ZeGYsFicYGpJi+rzgFhNOvyA7eX0Sz/EmECYvm+I/xRqlPAVLmalYpCGlbupij6firJOkSme/FKAweBXto2al/MUC/lLY/2idPN+1VWdwB/SuZHw8R1Me5AmcCytpQgKngz9PxiHqN8JHOFcdT4vkNOFNUbpJt9WVxJiNfo+bpmJF5KMAwEH0D/YKLk/xUiJgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(83380400001)(6506007)(6512007)(2616005)(38100700002)(110136005)(8936002)(53546011)(186003)(26005)(508600001)(6486002)(316002)(31696002)(2906002)(36756003)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZBMS9EYlpuQlFVRWRESGpTbElNRlR6cHpFcUlFd1d2RkpZUkp2QXVNc3NH?=
 =?utf-8?B?bG5yVnNCc2dTYitXMUVJTE90Nm56Z2JRZjFsekc5cngxc1ZieUhrVW41Qm82?=
 =?utf-8?B?dlJTU3A4OXk1emRBdVJ5TThMS3ZaazJ5M0Jld3kyanFWYlBuYmM2aFg1WTVO?=
 =?utf-8?B?L0ZaSWliWTQzd1pFYmthaGF2VUNPL0JNdFpVeE9wU3NPV1cvQnJzcll1MnJB?=
 =?utf-8?B?WS85OG8vV3JZeE1VNHU2RHc4U1NEbTV2MXREcytkUXg1ajBLeTBkeUk5SjlR?=
 =?utf-8?B?azRxdzhRKzFMdlp0TWFiQUxiTG1kVzVGV1lHTjZ5cUY3MnQ3RVgxUXVZald5?=
 =?utf-8?B?MUhicU9DOGp4YWJtRnVUd0VZRTh5dDl5VWh0QnA4aEkvZHVqNi81VTFZVSt4?=
 =?utf-8?B?R21DQ1hydWZOd2NiVXBsTVZmdTQ0T2lwTmd1NmlrNmFZV1kxMVhrV2RiV3VM?=
 =?utf-8?B?SDFnV29FSWl1dHM2cGtXaUlCK0l5bTBXTEFQS2xmV3YzSmU3c1Naa09UeXZ0?=
 =?utf-8?B?ZEdSdjIrY3IrNFVOWlp3b2tRV2JCcVF6NS83ZVowVzNVanU0WUQ3LzIyVzZP?=
 =?utf-8?B?VExGOHF6NmtwNDYreWx3SFZVZldaWnlYOURCcDd6dWdwd1N4Zzl4T1UvY1I5?=
 =?utf-8?B?Z3dJVkg3Q1FJcVl5Q2l2aWNrMG1HOGNxSGR3b1gvbnZrTVRlb1h0SC9kcEVS?=
 =?utf-8?B?ak5sTGw2WEdjNUtkTSt4V2l2Z3RrdDdZRDJ3VFZ0eUUwMG5JVDRaS1FGS0Iy?=
 =?utf-8?B?WVpUUlhMbmpNNVBrWWx4ZVphNTcxY3hnTzJ2Sm5MQmJnUHlSbDNSNVBBTVBx?=
 =?utf-8?B?ZG5tMS90MUdWN2JkU1hiT2Y0ZGdJNTNzYkdCK25JS09CMC9UazM2Q2JNcW5h?=
 =?utf-8?B?ejhKLzY4anVuVUpaRWFkbmVRWitGS3FVQlAweGlDbmFGMkV2YmpsNEJ6d1Nv?=
 =?utf-8?B?SEFpQ3FQTlM4SXJkM0djZ3dLYWtzYXpiTWNNd05BQnlzd2ErNkNxNUdVSHk4?=
 =?utf-8?B?ais1M2hMSzZZaE1aVlNTb3ZoWC9ua1ZWMkNDMVI0TjUyU3NNK2pLT01HZEk5?=
 =?utf-8?B?R1BkMzN5WXhCd1N3OWM3cDNzOHh0UkVJRWlYcmNJK3l5amQrWVhBTC9GdWhL?=
 =?utf-8?B?Zy9WemNvTnJFOFNHSnpZSUQzZ1poRVBlTjZJaENOdytXT09jMTVxNmZJK0Nh?=
 =?utf-8?B?a2VCTm9pcHNRZnMraDE2VEd0RE45ZHR1aWErUmVUOXN4Z2JQQWpKY3pMVXBN?=
 =?utf-8?B?Z09UQU9wYk9NWWJkQ2c3enI2RDd5aW9rNUNNbDFoN0dnR2Z4RmMxQ0FWNnE4?=
 =?utf-8?B?Qm50MEhQUTNGbTRUeTVWalZQTnBEWnQycU9tTGhReXlUSStIeXFzN0NoYVA5?=
 =?utf-8?B?Y2JodlNOUU1rRXRxLy9QeXYrZVZmT1hDUmluSDNNNkg3OGg5ZldGb01pT21F?=
 =?utf-8?B?UWJId2ZTRlhCczNYQVRqYjNhaHB4ZHgvcW00L05hSXhqbERjNFYzZDJwYllh?=
 =?utf-8?B?eHQ4akRHSlF6TjB0QmwwY1hGOThVZDJIMUdscjRDOFRtUVgxUFdjODU4cjZC?=
 =?utf-8?B?SzVlWHUyaG5ZZGxLd2FNSWpCODdxSVBSMkFqYUhQc1BPLzBYWURTa0hJMlVB?=
 =?utf-8?B?Q0duU3BBbEJBeHo3emtCdCtBQmhKY2VVdHg2V2xIWGoyc2JnN2hqbWtuRW44?=
 =?utf-8?B?M01hWjU0MmMwZkNpTXkzcWtOdzJHK2gwdVlGT1ltMGRIWHd3bFp4YksrTEtK?=
 =?utf-8?B?dzRYWkFyd0ZDWVBKdGlNQk5QVXVxYWVtc3BlT091OEZhWWhoZFI2WVFXSmUz?=
 =?utf-8?B?eGhaR0RER3JBeTJSYmJaMEdGYXN0Tk5CNmpNSkxkeGJzRk45T211OENTSitj?=
 =?utf-8?B?djFoTldqRE1qUHRwZWdCWVFOM1RDOHpaMDVmMC90d0h6L3NzbmFOK0d5YWJE?=
 =?utf-8?Q?MaIiIHrzK20SNzrcF1DNEbq9zsItqh3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d843fd-6d4c-44d9-cd07-08da0692542e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 14:44:37.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zH3Z/yn26/RQ3BDkIQCP8/0P6qRiYRZhaXP0z6L6sFwwd2vjv5yyqdf2AW+/BGhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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
Cc: alex.sierra@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-14 3:58 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:486b326f-8842-5de4-07ad-7ab1f209132e@amd.com">Am
      2022-03-14 um 10:50 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Migrate vram to ram may fail to find the
        vma if process is exiting
        <br>
        and vma is removed, evict svm bo worker sets prange-&gt;svm_bo
        to NULL
        <br>
        and warn svm_bo ref count != 1 only if migrating vram to ram
        <br>
        successfully.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 27
        +++++++++++++++++++-----
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 20
        ++++++++++--------
        <br>
        &nbsp; 2 files changed, 33 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index 7f689094be5a..c8aef2fe459b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -638,6 +638,22 @@ svm_migrate_copy_to_ram(struct
        amdgpu_device *adev, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/**
        <br>
        + * svm_migrate_vma_to_ram - migrate range inside one vma from
        device to system
        <br>
        + *
        <br>
        + * @adev: amdgpu device to migrate from
        <br>
        + * @prange: svm range structure
        <br>
        + * @vma: vm_area_struct that range [start, end] belongs to
        <br>
        + * @start: range start virtual address in pages
        <br>
        + * @end: range end virtual address in pages
        <br>
        + *
        <br>
        + * Context: Process context, caller hold mmap read lock, svms
        lock, prange lock
        <br>
        + *
        <br>
        + * Return:
        <br>
        + *&nbsp;&nbsp; 0 - success with all pages migrated
        <br>
        + *&nbsp;&nbsp; negative values - indicate error
        <br>
        + *&nbsp;&nbsp; positive values - partial migration, number of pages not
        migrated
        <br>
        + */
        <br>
        &nbsp; static long
        <br>
        &nbsp; svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct
        svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma, uint64_t start,
        uint64_t end)
        <br>
        @@ -709,8 +725,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device
        *adev, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = svm_range_get_pdd_by_adev(prange, adev);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(pdd-&gt;page_out, pdd-&gt;page_out +
        cpages);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return upages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r ? r : upages;
        <br>
        &nbsp; }
        <br>
        @@ -759,13 +773,16 @@ int svm_migrate_vram_to_ram(struct
        svm_range *prange, struct mm_struct *mm)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long next;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma = find_vma(mm, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vma || addr &lt; vma-&gt;vm_start)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vma || addr &lt; vma-&gt;vm_start) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find vma for prange %p\n&quot;,
        prange);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = min(vma-&gt;vm_end, end);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vma_to_ram(adev, prange, vma, addr,
        next);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %ld to migrate\n&quot;, r);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %ld to migrate prange %p\n&quot;, r,
        prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upages += r;
        <br>
        @@ -773,7 +790,7 @@ int svm_migrate_vram_to_ram(struct svm_range
        *prange, struct mm_struct *mm)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!upages) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (r &gt;= 0 &amp;&amp; !upages) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 509d915cbe69..215943424c06 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -3155,6 +3155,7 @@ static void
        svm_range_evict_svm_bo_worker(struct work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_bo *svm_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm;
        <br>
        +&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_bo = container_of(work, struct svm_range_bo,
        eviction_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_bo_ref_unless_zero(svm_bo))
        <br>
        @@ -3170,7 +3171,7 @@ static void
        svm_range_evict_svm_bo_worker(struct work_struct *work)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svm_bo-&gt;list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; while (!list_empty(&amp;svm_bo-&gt;range_list)) {
        <br>
        +&nbsp;&nbsp;&nbsp; while (!list_empty(&amp;svm_bo-&gt;range_list) &amp;&amp;
        !r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange =
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_first_entry(&amp;svm_bo-&gt;range_list,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range, svm_bo_list);
        <br>
        @@ -3184,15 +3185,15 @@ static void
        svm_range_evict_svm_bo_worker(struct work_struct *work)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_vram_to_ram(prange,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_vram_to_ram(prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_bo-&gt;eviction_fence-&gt;mm);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (prange-&gt;actual_loc &amp;&amp; --retries);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN(prange-&gt;actual_loc, &quot;Migration failed during
        eviction&quot;);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svm_bo = NULL;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (!r &amp;&amp; prange-&gt;actual_loc &amp;&amp;
        --retries);
        <br>
      </blockquote>
      <br>
      I think it would still be good to have a WARN here for other cases
      than process termination. Is there a way to distinguish the
      process termination case from the error code? Maybe we could even
      avoid the retry in this case.
      <br>
      <br>
    </blockquote>
    <p>It was bug that prange-&gt;actual_loc set to 0 even if vma not
      found, that's why this WARN never trigger. With this fix, the WARN
      is kind of duplicate with below WARN_ONCE. Change this to
      pr_info_once to help debug, as below WARN_ONCE is real critical
      issue to notify TTM to alloc VRAM from BO while svm_bo ref count
      is not 1.</p>
    <p>retry is avoided if r return error code.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:486b326f-8842-5de4-07ad-7ab1f209132e@amd.com">Other than
      that, this patch is a good improvement on the error handling.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange-&gt;actual_loc) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;svm_bo = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svm_bo-&gt;list_lock);
        <br>
        @@ -3201,10 +3202,11 @@ static void
        svm_range_evict_svm_bo_worker(struct work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        dma_fence_signal(&amp;svm_bo-&gt;eviction_fence-&gt;base);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is the last reference to svm_bo, after
        svm_range_vram_node_free
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * has been called in svm_migrate_vram_to_ram
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; WARN_ONCE(kref_read(&amp;svm_bo-&gt;kref) != 1, &quot;This was
        not the last reference\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp; WARN_ONCE(!r &amp;&amp; kref_read(&amp;svm_bo-&gt;kref) !=
        1, &quot;This was not the last reference\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_bo_unref(svm_bo);
        <br>
        &nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
