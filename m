Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545E4C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D539210E0C6;
	Wed, 31 May 2023 14:46:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079CE10E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy2RmHhL43puScY/j7Do+fg9SFxZP6nP91sRVG3zEyrc4mrVeNKt+JxqNE4YXB6hhjOG/ADqD3Tek5ytqDL/7+GTssrvrfeUTYMugBjILgn+GLXq3lsu2tR3UKTJU8mPq6w6U9ZTKtfvYbEyGvy2BwIDnZYkCAVKrTYK71O/Icc11d286+dvT1v8xNKqAvHsWh03y41XfM5zudDgm24uyDqsS7nT1Uf/f3S6jWQdGmf7mQ2j5PAYzSbzgA/40zlDmudRlTfwHvYJ6fpLDPFxXMHXVdgVTfDvhc/MEatnyS1zOkKNoa9d4Zu94gQkuxD/sPgwCApxx7C2B6D9JGBlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbYNLJBkb90/2QScNKF3iCNdlR1YkFWt4ezNN5G3cec=;
 b=QPu2Nj9np2o31fwF1DvIgCcLibe6w/I8CBjsO7463u9fbZddznmbn6nDkgAOKk5WOAeH6Jx3mExCHeenszAkyehDdyYmnqEL+/nBT2K7dHoo3rJXtZJoCgAZBjj8dEZkcKA6DLYZrwq3MrPYBn1rmaCfG+5THlZWUFTsuC+RZj9CrVk0H2xCQWBrXm19gIljCagwBx2isY1HHSfM1f1RT78zyGztqQXcour/sBwezy8uJc9POoFihxDNTgl/k7wnaq560rpfBOpGYchpvWX48qreWi3APYRIWGQ03cuPQbimMxTmFBLj8zMCd2lXasxG2ujmFkZk/4JN/fM7zTRjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbYNLJBkb90/2QScNKF3iCNdlR1YkFWt4ezNN5G3cec=;
 b=qQKJcYxBBrmZN5bD156D6vj9kBW3GusjVljs0t7vvPYmttc0Ff8pXjMSQix3nMwRePrU4EQ2HO1lCp1IO097Tkc9rzgndzC9UcMGssDdFX+7I0gV+0Eixqy5T/Vo4Woml8olpu9voXjDqyWwIo5sX1nkmAuEHAE/HduNTfXe56M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 14:46:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 14:46:28 +0000
Message-ID: <ac065ae1-f74f-02c1-3fef-b46ea416afd2@amd.com>
Date: Wed, 31 May 2023 10:46:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd: SVM flag error added at svm_range flags
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230529200946.11492-1-alex.sierra@amd.com>
 <BL1PR12MB5144D0EDD13421B5AC70F327F7489@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL1PR12MB5144D0EDD13421B5AC70F327F7489@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0089.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: d874eaf5-fe11-4976-e1ad-08db61e5d07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3gzFGNYit4CLOOUyZ9po32r8E1DNQj+cO60wD+DAcp5SUFxfa898UJAJaSMBiW6RD/6ZOS2uQCr4iXgeyU4xGI0xEXA4lWgfbYM2mfIf2Q0m8lNnd9XRcN0lLFwIEYq8qYjGj0fOq/Lgpmjbdtg0/PnX4y2OPaQvvaM6JIdYEnsZmiSmFo9fGjoNWfq/RH+0cJzAkL4Jz+1cdWhHovHnq1TdnHa+NMyoPKlPxvr+ebmTdK33QVJryC22g7sr6YAUzah1TvB/yLq4PWqGclGKu0QF3GxbxfFLC6C85DnIOT9f6rEunf850fdg4zIDQMr6V50ZM2qAV4d5OFJOKlKFYGePXjyrNEDYbVKbWIl3ZFvyKbvB7nN7jpS/RCBZ7fxK3fQuGYbYA4zh3Bkp/8puSrFTydLCLxqSjjbbPBGZHkTZnGd6eEzanFuqGsRNPM1vKZAwjjRgV+fdJZbC3PhMgGvsoBMAx9xsxfrGmYN2gziiM4WfKLDY7QGqYpAhbHRhjwKYLOvjqVdd0LIz0rn5GZgH2qnfkwc0dGFqghXYqn4957Eoevd6/aUDjk/1muMtu+tw99GHwamFhlTijUdEQiCD4EJAlfstYVJM1d6SehZWrps/s5Uz6mJ1T6DjUIrXYADOOCerhsMS6IswxG8gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(31696002)(6486002)(86362001)(41300700001)(478600001)(4326008)(6666004)(316002)(66476007)(66556008)(36756003)(44832011)(66946007)(5660300002)(186003)(2906002)(31686004)(6506007)(6512007)(83380400001)(2616005)(26005)(8676002)(8936002)(38100700002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZWelRNWWVKTXMvR2xSME9tYjRRZU16TVlSbUQ0c2Evb0dtN2cwS2dOVkE1?=
 =?utf-8?B?cDhYbUd1Tm1xaTFvZHN5UnlMc0N1NlpGQ09BTkdnb2Y1SGJQNk55eFgrV29z?=
 =?utf-8?B?MGNvRUcvSmNBUGtGbUQyL0REZDBxTDhPL0ZnQXF0T2FZQitJTHpiU3orYlJB?=
 =?utf-8?B?YzV1OVRKRExFRjJJZEw2VG9KTXJZdlRaWlMwUm1XNlYwNFZueFhnMXhQd1F5?=
 =?utf-8?B?bVM4T2h1Q08yQnJ3Rkd0K0hRRjhtYTRHRWRqM1NOeWROazB0R0RENXFrZG95?=
 =?utf-8?B?YWg2MEVQZWNPMkowcTZqNDF1SlZJV1pOWVNOV0Q4cjdhTUVEaHptZ3ZEdnJY?=
 =?utf-8?B?WDZETUNoYXF6L1NweGJyekdQK1owUzdzKzZFa2lvY2k2TmI1U3JhQXdabEJO?=
 =?utf-8?B?dmMxVTFJTUI1RXdkSzBYOGxYMXptdDF1LytOV3hCT0FadFg2SkRTZW4yNnQ2?=
 =?utf-8?B?UzhqUEtJZ3kwYjN1KzJrUW53RzNaQjdob2luTVN1clJjbHpyTnJuamZsTmRO?=
 =?utf-8?B?TGlSM3ZDa2dFMUVWU3ZKa3c1dXNORlJ6b3N1U1MvNTFZa00wRjAvQktwZFk4?=
 =?utf-8?B?S1V1Q3FtUTJUTTJrSi9kMktLamtSdHpYTVkzZHVQZzdvSE9iL1pnVnpwclJx?=
 =?utf-8?B?OTRpc2NtbWxiczhaRkcrL0ZGQWRVNERvYUVWejhxMFlSektETDJvZ2Y3WHRZ?=
 =?utf-8?B?cWJyWDZEWk0zRjF0NnU3bzhWY1prYVZMWmYzVGwvV2RUdmlUVE5pMm55WmVH?=
 =?utf-8?B?bXN2NWxFSHhzR2pKQTA5Zng4K0U0NHBWeFpjUzl2TDNZUFlxZW45aG9vZlV0?=
 =?utf-8?B?Vmw4KzhOVEhoRXF4ak5XMHhtQS9nbWRlclNaVjg2QjR6YVhwODBsbGUzVXpI?=
 =?utf-8?B?VGVwUWt3dTFYakFuRTBmL3RMWld5UTVpYWpSTm5DNlJieDMyU0xUVzAwQWtX?=
 =?utf-8?B?MDB4TjVNdVo0ZGpjT3hFSTIydWlNRXBmOEx5bmlZNUgyWVFVYURIYndsSXM5?=
 =?utf-8?B?bVBxMzN1a2JjMmhLUGdUU29Oa3NHMnk2OFpKY0RsYUN5S1BPZklwdkZMazJ2?=
 =?utf-8?B?NnpWVndFTDVrNFYvZWw5aUFHdVdmT09DWkQzT2JjZEI0L0pCZWYwYVhEYzR2?=
 =?utf-8?B?cUFlUTdhWHdhWFNCWDF6ek81UW11TzgvT1psSVdhNzNIV2VySXd6QStFUGhZ?=
 =?utf-8?B?THlqZGZROFNjSkJvV0NuRlk0SkQ5YlREREd3ZTJCK2x3bEh1Y0VzeEYzeGRU?=
 =?utf-8?B?Z2w3VDJvdmxUcU1NbUYyM0N1eEZ2YS8xMzE2a0hLanhTc1BwbUUzNUV5UGRM?=
 =?utf-8?B?YmRMWjBFTTFubThFdnhUaWcvYTJISU1BZU5CR3o1OVFDRGpFbEZLejZqOERV?=
 =?utf-8?B?ZG9zVzBUVnpOTE81MFIxYnpHS0hrL2Z6U1ozZWVFK3pRR0JTN1hDUXpPZTM1?=
 =?utf-8?B?RnYzTWV0NkZkR0NNaXowK0w5WDlCLzZvRDRIUFNvWmJVdTE3UE9rbEJCdVFN?=
 =?utf-8?B?UVZMU0NCQy9JZWNSWFNKaks0N0dvcnhnV1kyV3AwUmdibzVnODRIU0Vjd3Ev?=
 =?utf-8?B?RFRiaVVEa0pRUzlKOEhaZkVPUWM0RVBJa2o1bXRqblBGRDg3K2dVdnFWK3hP?=
 =?utf-8?B?TWFVVkZrTHgvK0Y2amFWM0w5ZGF5NFJubm1qdTVDNUFlNWpyaVRFTXBFLzhh?=
 =?utf-8?B?WDFSbzhUK0NsYWcwQ0FSTzZ0R29LVWllZFhwTTdxcFhsN1g2QTF4OCs5ZVBq?=
 =?utf-8?B?ellROXhvTzc3aVI0YVd5clFJRWdaeklIaUpmazFVSTlEaG4yN2x3citHRDll?=
 =?utf-8?B?dDFEdTNhZm4rcXExT1ZMVGpmTjlsaFFjdzFybDE4SWV6QUlya1I2OEY0azZD?=
 =?utf-8?B?bDkxZmNWV3VMS3F4NW9Ub0JqeWRTbkpNK043OFVRVFNPN2cra1JObHhrdDdT?=
 =?utf-8?B?YnNqckkwK1o5eWxCMjJsRy9EMExWVGpNWjBlT1lETDdjU09wbVhvWUtLOHdv?=
 =?utf-8?B?QU9tOEIyT1ZGdzRzSmVKT3d2aThlY3kvRGJJeFErSTVUMHpXNmR5c2RmbEM4?=
 =?utf-8?B?TVFZUVcyZndtMXVsT1B6QW91MGVxc293OFV0cU03aVlvRnptTUlXbS90Z2xL?=
 =?utf-8?Q?1oxWIvjer8sSYLaxZk7lhgHtl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d874eaf5-fe11-4976-e1ad-08db61e5d07c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:46:28.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Htdp2wJCl7AMhpTzDdiPw1LgI7A2xSq0RRo4EELyz4ymeAxy4VGCkw7agESH1UlTZtPtvTtkrJzmv8Hx4+oaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This flag was never meant for user mode. Alex ended up implementing it 
differently in a way that doesn't need to change the flags exposed to 
user mode. See his patch "drm/amdkfd: flag added to handle errors from 
svm validate and map". This patch is no longer needed.


Regards,
   Felix


Am 2023-05-31 um 10:09 schrieb Deucher, Alexander:
>
> [Public]
>
>
> Where is the userspace code which uses this new interface? Can you add 
> a link to the relevant branch to the commit message?
>
> Alex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Alex Sierra <alex.sierra@amd.com>
> *Sent:* Monday, May 29, 2023 4:09 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Kuehling, Felix <Felix.Kuehling@amd.com>
> *Cc:* Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Yang, 
> Philip <Philip.Yang@amd.com>
> *Subject:* [PATCH] drm/amd: SVM flag error added at svm_range flags
> If a return error is raised during validation and mapping of a
> prange, this flag is set. It is a rare occurrence, but it could happen
> when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,
> the caller should retry. However, it is important to ensure that the
> prange is updated correctly during the retry.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 12 +++++++++++-
>  include/uapi/linux/kfd_ioctl.h       |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fcfde9140bce..96abae515bcf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -756,10 +756,12 @@ svm_range_apply_attrs(struct kfd_process *p, 
> struct svm_range *prange,
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
>                          *update_mapping = true;
> +                       attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
>                          prange->flags |= attrs[i].value;
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
>                          *update_mapping = true;
> +                       attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
>                          prange->flags &= ~attrs[i].value;
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_GRANULARITY:
> @@ -778,6 +780,9 @@ svm_range_is_same_attrs(struct kfd_process *p, 
> struct svm_range *prange,
>          uint32_t i;
>          int gpuidx;
>
> +       if (prange->flags & KFD_IOCTL_SVM_FLAG_ERROR)
> +               return false;
> +
>          for (i = 0; i < nattr; i++) {
>                  switch (attrs[i].type) {
>                  case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
> @@ -1657,8 +1662,11 @@ static int svm_range_validate_and_map(struct 
> mm_struct *mm,
>  unreserve_out:
>          svm_range_unreserve_bos(&ctx);
>
> -       if (!r)
> +       prange->flags |= KFD_IOCTL_SVM_FLAG_ERROR;
> +       if (!r) {
> +               prange->flags &= ~KFD_IOCTL_SVM_FLAG_ERROR;
>                  prange->validate_timestamp = ktime_get_boottime();
> +       }
>
>          return r;
>  }
> @@ -3674,9 +3682,11 @@ svm_range_get_attr(struct kfd_process *p, 
> struct mm_struct *mm,
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
>                          attrs[i].value = flags_and;
> +                       attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_CLR_FLAGS:
>                          attrs[i].value = ~flags_or;
> +                       attrs[i].value &= ~KFD_IOCTL_SVM_FLAG_ERROR;
>                          break;
>                  case KFD_IOCTL_SVM_ATTR_GRANULARITY:
>                          attrs[i].value = (uint32_t)granularity;
> diff --git a/include/uapi/linux/kfd_ioctl.h 
> b/include/uapi/linux/kfd_ioctl.h
> index 7e19a2d1e907..2b6f68bd06da 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1125,6 +1125,8 @@ struct kfd_ioctl_cross_memory_copy_deprecated_args {
>  #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY 0x00000020
>  /* Keep GPU memory mapping always valid as if XNACK is disable */
>  #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED 0x00000040
> +/* Set during svm validation and map error */
> +#define KFD_IOCTL_SVM_FLAG_ERROR       0x80000000
>
>  /**
>   * kfd_ioctl_svm_op - SVM ioctl operations
> -- 
> 2.32.0
>
