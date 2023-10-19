Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA95BCDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 20:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAFE10E534;
	Thu, 19 Oct 2023 20:53:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F7310E534
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 20:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNLSv50gfi+xF4YdQNup4umcqoDkMvNu7x6RrRyc80wfsxN3m7vLL3S8DipTTpWkINQ8TyAyT61253Gse1kMq4DEmRtOFtsb33cmjZvXE2GPKwoisb7+E8vb4u2KhLWTeCvF3MCMr+8/Ko6QiXD9oVGX0iQ4dErvBh++PsOEd6WqIFZDWMnBsnU0FbSxbds16K2djdEx606j4Mvew2hPIgzPi81mwtcMxizny7rAM5ASSk/q6ySpozoec/Mv3qc4EmMW4+qlBrygyeze1pZbW6Jul9j4VSCeC53IGoSoqepRjnL4snQtJoVDaf+rMzBN+I6Kb876PgD5Bp+Ossa3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l84hPzXjRdcHROAgYPI33pfs3zfoNKY9XoyQdjrB3fQ=;
 b=bRayIpWcrthU1uDeUDP5B20nA7o7NkFoIscPYUT+AEin3SGjw1EWbBj8zBROOL5pKGa4MGLnhH70oFhHL6a/7bLSsgvG8/wiltY/lD8nK0EgkphtT7n/r33179r9J3sVdgE+PdnX7oYahFAYS3BFOMoaeZcRc34AWCTQLdi+/REiLMwKjof6fDnMbc/j78wnzUs4Pgm/g6GjOFZCmCwjp3oFW2EhjGbwAoRf0/zwb3u4K98kQuMyST1BO45bWc6Xdg9MIkdj2zuF949SA7G7Dlqtqtrly3ISeXBvHZfm0ueLm7MfYZjl8ufFVSd5bFkS9PSNDYim84u/VH2zgfLRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l84hPzXjRdcHROAgYPI33pfs3zfoNKY9XoyQdjrB3fQ=;
 b=5ZqSVK7MjV7/HuhRw22+fXpmSieDeHl9C3pKqZPMPn0tcpoSpdtFUKYjmF8VTs1msY/TKUyAehzAHZHC2JvU/53slnM09Xo5vo606029l6vGM8dr1bTEnDE3WYa4sGrUl3q69furhc9YMrDNm1ZFUo3WVFtWrP2xtBM8xLQZzfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 20:53:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 20:53:22 +0000
Message-ID: <d988944f-a515-c0a1-a823-2d7b3e9c37cc@amd.com>
Date: Thu, 19 Oct 2023 16:53:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: remap unaligned svm ranges that have split
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231018222607.9872-1-alex.sierra@amd.com>
 <0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::41) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 63109184-dabc-44f6-405d-08dbd0e56e48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoXfMPfM0BrCrepy9Xn5YyOlrJle2TKUMSy7N1mort22t/bsNhcAASxWIVqmI3YHKN1S1OkOTqsmpJNRXbnRvA/U2udsKt8VXLwCSOfrAEX+N08Q6pkvIXchszSxcs1u66Uf1Xv4oIV8TK0zdU4Fo9M1SUi/RbLH3tyxC36QcxWeWYNx3IkdGsNJX7R8+7kcZpow9Yw9OPJOxcWLrutuVRj48OH+6GLovLGVaq4bnise6qZQ0VDlvOZtfnYdt4ZI8T4VDUtY9s/G7XAC7DbrM39kaCz5ZNLCUFTP3EyWWOsHkU2xO+sjMYyNmLykqCJUbDdzt20mXkw0EdEjbz5ZgUpey58u5Lz+KFTErLAFMURfjAuiaX27gkaRKGMYHbrincacmYxgjdvtjlWqYwurGAQRIyueiRWTJRKV0N83rg283UFRyq6QhM9NLNFcUkR/zgAsPhpP/kZ4f8xYw5FJMCmTjsHzQigdFYZKyE6uSZ8Zqj4n6bL2hNjLZkFwojEXIam1t5vowMUqQhfsutjV0wB9ZRB3IrR5yyryp+swI7dFBldg1uA0z6NyuyAPVj2s1VUHFtfBNydoid8E1YCkN3Wpt5rVPqZnywyGPalQERd4cNWoCMDCtwA361hUoXu2j1dteUrkbyFpuh3p61E4Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(478600001)(4001150100001)(6486002)(6506007)(6512007)(53546011)(110136005)(66476007)(66946007)(316002)(66556008)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2906002)(83380400001)(2616005)(26005)(36756003)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGlzb2xqcXhzVW5BN1FjaDRMWDNlVnhYdEtEOFdpVUxtZjVsUXJwSm5XNkVE?=
 =?utf-8?B?V3FzUSs4K0NWTkF2UUIwNmZ2Q2Q3WENvRkxKU1l0TkFFYUJxc3dpS09lb0dI?=
 =?utf-8?B?NjFjR1p1Y2hGeCtvZ1ppaVJWN2NWcm5td3EzdVJSUFlRQTh0OERGMGxNdWR6?=
 =?utf-8?B?dWVnaGliNUJEcHZaczhyWUlaQTJZSW1ZbE1DYk55emVGSXVZVXlkaXRSYjU1?=
 =?utf-8?B?UkVBRUFQc0hFY2g4ZVN0TmFuNU9GNUgrMXYwMzZiVi9oa05LcThMdGJCN3J6?=
 =?utf-8?B?ejczNmVzcDdGWjNiektNWTBDN3VSdFg4aitKVE9DMUNxRDI3MU9GNUlDZzFH?=
 =?utf-8?B?L2RnUXhuaXdXdzlvS2JEREZpVEFZa2hpSGpsS0hJMW5BWXdzUGxSSHVFMlhh?=
 =?utf-8?B?dHFoVkUvTE9lMjd5WTB2ZGE0blI0WHRRNkFqZm9ORm5iaXdrM0hDWWErRlNh?=
 =?utf-8?B?UUdPUzNIZ1d5U08rbTRGaFdCYm44Z00zMVZnbFVmT2djdjArMUUvVEkxS0p6?=
 =?utf-8?B?TkdzanF3THE4Uy96RkhjcU5KMkNORkVwZm9HR3Z3TW90R0xCUXg2WGVhblR5?=
 =?utf-8?B?bkhvNlM5N2JFNWtEYloyWHJJR0YwdGdEcHN3YTJScWcyRUFWWERzWnpIV1da?=
 =?utf-8?B?Y1k4cm1Bb3NIWEp0WlBVRWdUeitVaHB4d2RvTDFsQ2w5anZHb3p4NVozTkcx?=
 =?utf-8?B?WVo1MjU5cmthdVdOeFJ3MVdFYWJhQWt5Ty9wSUQ0MFVVSkp6VGM2dmRBQlNL?=
 =?utf-8?B?SlhPb3FqS0hKYkFnMmlhQUE2eTVKMkt5RWwxNjJpbVBOZWlGSEg1eUt4THlG?=
 =?utf-8?B?TEFJaENrMGI0Tk52aWYzY1lmYk10NFFPMHp6bllzeHdHcjlrWE9VZ2xpMnRH?=
 =?utf-8?B?aWxvUG9LS3F6UUpld2RHd0d2QndJbitnNG42S1VzNjlRVTVNSll0eVBqSW9m?=
 =?utf-8?B?cklNYkp0Mmo1TGZJYzZ5QlovQmdlK1JHeExPaGV3dlFPenYxdGxrV3RJVCsz?=
 =?utf-8?B?M0tZQU1PV3RmeWMvak1RRTBFRE96a2RLTE1NL2xrN0dlSnM2Z05PSExSUjhJ?=
 =?utf-8?B?S1JWUXA5OUtycXJIZnhEemhXRVpuVEt1R3BUZGdKM0I0bXkzMW9Ya21rV1ZC?=
 =?utf-8?B?dU9aZDk5VWtEdFJuOFNhYUZIVHRUWFFDekRqMitJRXhzdS8wVFhwV05kQ1pu?=
 =?utf-8?B?bGNTOGVLRS9SdURqTXVlZjA3b3dkMUd6MGR5cTh0N3dPMkxreVYwRW5XSzU0?=
 =?utf-8?B?Tks5bndZZWZsdUJDMnEwTjcxaHdPR3BHZFlyRzBMSUNDT2R6cHJ6MmU2cjhG?=
 =?utf-8?B?YlVXNDMzbm81L3NrY1MrVUcvWDQydWxCajdteVlhaWE0TVptVThNSElIYTM4?=
 =?utf-8?B?OE5GalJkMEdWR05lWERuUEhwV01nTWw0THFqN05oSU1kMytzY2pZL01mTzNm?=
 =?utf-8?B?ZHM5dXBYb2IyUzZFTjdiYm1seGRTd05jTXpxeGVkSzZsc2M4MXlkcXd5SExs?=
 =?utf-8?B?SVVlNndoWGVkcURwNVZadWJtSU1yMEw4U1A4RGVYRXA4UzlLcHo2cCt5R3Yz?=
 =?utf-8?B?a1FIVm1YTWVZa211S2JpWFQ3ZldEN3ZXbDRLVk11Q0ZNT0VrWmVoSWZGUU5J?=
 =?utf-8?B?MkJVeS9oZ2hTNmN4QzlwdWwxb2xpd3RyQXpWM2JEOG1VS00rWU02OW12VldZ?=
 =?utf-8?B?ZDJVcmc1VDJQNCsvbWd1Y0F4SUxUWjg5Z3dBNnhCeE1kdEQ3VXE3d2pmTEox?=
 =?utf-8?B?L1UzUXVDQ2R0MFZvdW1qc0xjakk3blV4RC8rRzNta2F4OHovVFFFOHJEeDla?=
 =?utf-8?B?RDRhbHBZak94OE0xQ1lkVTloQ3BudXJnOU55QzlVZmo2R20xaEtZTHBtQlBN?=
 =?utf-8?B?MWhwa3pPK3ZkQ0tLZUVGbTFiZkhJNWxaTUxWOGVjOGxWeS9jV09mZzFXcDJR?=
 =?utf-8?B?L1Y5V2M4NXBEanpjVXdVMEZiY09NZTJmNktwT3I0WERHZFNLbnN3REM5cTB3?=
 =?utf-8?B?L2V1YzROb0N2bTZQdHpIT3NDVEM4cnY4ZUxaSjFvYnQrZmdTc1VjUS9aeVFm?=
 =?utf-8?B?Y1VSNWhqNzlVTzNpTkxLYmJHQkpvZGZmcHlaUnlwTXBJNWd3dXgrRFlZc3E2?=
 =?utf-8?Q?LhcQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63109184-dabc-44f6-405d-08dbd0e56e48
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:53:22.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ytl6KUYp7+Lanv/bzhBuzzmVtnVTj8MPQ6zEnTQKajGucQGYNQ4NuopfArQ+Oq4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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
Cc: xiaogang.chen@amd.com, philip.yang@amd.com, james.zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-19 16:05, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com">
      <br>
      On 2023-10-18 18:26, Alex Sierra wrote:
      <br>
      <blockquote type="cite">Split SVM ranges that have been mapped
        into 2MB page table entries,
        <br>
        require to be remap in case the split has happened in a
        non-aligned
        <br>
        VA.
        <br>
        [WHY]:
        <br>
        This condition causes the 2MB page table entries be split into
        4KB
        <br>
        PTEs.
        <br>
        <br>
        Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 45
        +++++++++++++++++++++-------
        <br>
        &nbsp; 1 file changed, 34 insertions(+), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 7b81233bc9ae..1dd9a1cf2358 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1104,26 +1104,34 @@ svm_range_split(struct svm_range
        *prange, uint64_t start, uint64_t last,
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int
        <br>
        -svm_range_split_tail(struct svm_range *prange,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t new_last, struct list_head *insert_list)
        <br>
        +svm_range_split_tail(struct svm_range *prange, uint64_t
        new_last,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *insert_list, struct list_head
        *remap_list)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *tail;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = svm_range_split(prange, prange-&gt;start,
        new_last, &amp;tail);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        +&nbsp;&nbsp;&nbsp; if (!r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;tail-&gt;list, insert_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(tail-&gt;last + 1 - tail-&gt;start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1UL &lt;&lt; tail-&gt;granularity))
        <br>
      </blockquote>
      <br>
      I'm not sure about this condition. I thought this condition should
      be about the point where the range is split, not the size of it.
      So my understanding is that this should be
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(new_last+1, 1UL &lt;&lt;
      prange-&gt;granularity))
      <br>
    </blockquote>
    <p>I think prange-&gt;granularity is not always 9, 512 pages, we
      should check the original prange size is larger than 512.<br>
    </p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(new_last + 1, 512) &amp;&amp;
      tail-&gt;last - prange-&gt;start &gt;= 512)<br>
    </p>
    <blockquote type="cite" cite="mid:0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com">
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        list_add(&amp;tail-&gt;update_list, remap_list);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int
        <br>
        -svm_range_split_head(struct svm_range *prange,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t new_start, struct list_head *insert_list)
        <br>
        +svm_range_split_head(struct svm_range *prange, uint64_t
        new_start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *insert_list, struct list_head
        *remap_list)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *head;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = svm_range_split(prange, new_start,
        prange-&gt;last, &amp;head);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        +&nbsp;&nbsp;&nbsp; if (!r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;head-&gt;list, insert_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(head-&gt;last + 1 - head-&gt;start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1UL &lt;&lt; head-&gt;granularity))
        <br>
      </blockquote>
      <br>
      Similar as above.
      <br>
      <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(new_start, 1UL &lt;&lt;
      prange-&gt;granularity))
      <br>
    </blockquote>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ALIGNED(new_start, 512) &amp;&amp;
      prange-&gt;last - head-&gt;start &gt;= 512)</p>
    <blockquote type="cite" cite="mid:0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        list_add(&amp;head-&gt;update_list, remap_list);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -2113,7 +2121,7 @@ static int
        <br>
        &nbsp; svm_range_add(struct kfd_process *p, uint64_t start, uint64_t
        size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t nattr, struct kfd_ioctl_svm_attribute
        *attrs,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *update_list, struct list_head
        *insert_list,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *remove_list)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head *remove_list, struct list_head
        *remap_list)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last = start + size - 1UL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms = &amp;p-&gt;svms;
        <br>
        @@ -2129,6 +2137,7 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(insert_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(remove_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;new_list);
        <br>
        +&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(remap_list);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node = interval_tree_iter_first(&amp;svms-&gt;objects,
        start, last);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (node) {
        <br>
        @@ -2153,6 +2162,7 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *old = prange;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_clone(old);
        <br>
        +
        <br>
      </blockquote>
    </blockquote>
    <p>unnecessary change.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:0f8c20d2-65bb-4b03-901d-804c80f9300e@amd.com">
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ENOMEM;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        @@ -2161,18 +2171,17 @@ svm_range_add(struct kfd_process *p,
        uint64_t start, uint64_t size,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;old-&gt;update_list, remove_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;prange-&gt;list, insert_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;prange-&gt;update_list,
        update_list);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node-&gt;start &lt; start) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;change old range start\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_split_head(prange, start,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insert_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insert_list, remap_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (node-&gt;last &gt; last) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;change old range last\n&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_split_tail(prange, last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insert_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insert_list, remap_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        @@ -3565,6 +3574,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head update_list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head insert_list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head remove_list;
        <br>
        +&nbsp;&nbsp;&nbsp; struct list_head remap_list;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *next;
        <br>
        @@ -3596,7 +3606,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add new range and split existing ranges as needed */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_add(p, start, size, nattr, attrs,
        &amp;update_list,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;insert_list, &amp;remove_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;insert_list, &amp;remove_list,
        &amp;remap_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        @@ -3661,6 +3671,19 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; list_for_each_entry(prange, &amp;remap_list, update_list)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Remapping prange 0x%p [0x%lx 0x%lx]\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, prange-&gt;start, prange-&gt;last);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
        MAX_GPU_INSTANCE,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, true,
        prange-&gt;mapped_to_gpu);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = r;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dynamic_svm_range_dump(svms);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
