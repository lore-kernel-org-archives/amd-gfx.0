Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F88C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 10:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D1410E33E;
	Wed,  5 Apr 2023 10:06:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749F410E33E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 10:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Ieh+yQAKg72EiUdIMq1X8gRGBQMqCN7u3dlWQ6oA7u5WME71kMsp6THSzLpEslhsrgX6pR+3O6yGA0Rj2AZnMbzpNnrv/uVzabdFBVpDeIp4XDN1E/PMoja0/wmUWlzV1aBGgSJSCu3HSCbGbFfbT1JB6KX0TykypFJOx5ktGFQOtnakUJXS6oC3k4q+YQf68lLbt0tN8k726A/hOaQ7fenUHuR0KrHG5ECe06jPykdbnWkyqXOAX4R0QOuDCvgJwAY11nCHgGlL9aXSy3/5ApGbOdaXiBiHbDs/69E47O6imAOe2qq89c3ZRtGInPM/uPIcQ7Dwuuzim0iu2g/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5xo46qypOgmDXzaacs8FOmtNsIuLv1MmfA3LNIFJco=;
 b=kvDPzTne0NWy5rF/WgJksbWUd02OSsgDvyUDcHxSpmAXSzaEbIvDhJ6HHUAjhP4sdKQQxVaPnjLD/z8kZRHUURtow87DIGa4Qucj+IrR22gSSfHadD2i23u2KpCAmFiMXGUpS7l6DiNFER5NjvyXO/g9tSonQrb7OQzdTc79/F1oMblMQD5VMJ98nW9wNpTwRzatcP2hqiytOgpMXb8+mfG+4Rp6qIUe4KrDsOQKESQ3jF/L9xn0QSn0vcS40Um4csgp1ywtBCKDbSARsJwsj/Efi+fnSd8y91Ub4uJUWQRTV3/Zc+JsDtUp0DrVEIvFfiBIObQ0lVdwaEJBze2O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5xo46qypOgmDXzaacs8FOmtNsIuLv1MmfA3LNIFJco=;
 b=blGgAu1WF7M7G1cM//RZRzhOE+xsgxIaVFADalskx6V8a7QZmWvqKRVjS62u5RDkat4TAgQk8OVKlesShVgL6Qc6EWFPFRNnKSYsfKy1Bk7EzphMTikqT+K0n8Ehl9VVGu3GNJZSi0MsbUCj30Bt84v73DVFujNX/kicE1JUrxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 10:06:16 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 10:06:15 +0000
Message-ID: <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
Date: Wed, 5 Apr 2023 12:06:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
 <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5d1452-0f6f-4f29-5d64-08db35bd6458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWxhnAQ4TBBxf9+ulutn6+G/fGPScPU9oVpdFQQlg7uljboHb2wldyPKoSpFBRS495iYzYX4zGZjPOyY0R3DX4De0cq0ZXYq3KhizAjOkMD8T9sm1dq1JSaWmESdKMfHJOjl/EfuXrkiEw196mXTtH+gXKcObv7fEtIrJJY1AlrOyPoV1BMK6/UaylnGb5nZaD3r0BR4yF2wSccIgHbuOdJkshY4uYrSrKJFhf0OBkJk3Hnupu5KR0VnluyQDLETj6/bXTfgiCpe6H16NenBXmkO8SQ4jKRJODEnt937d+Lpwi/PtkoaO1omuRF05xm18krnoOukdwNFO/QOMAF21qFqmIFjVInDZrQ/CYhD73ZqtGScGJDAY2vANBMgL4ry4yHYa/lP9wVWh8RS2YtPLCC42v0Hv6hHqCsIT6bx1yIDnM60tSSPzEqZhkC5EO0wRNQG9AV1atvhAfXpU+6vR1T3TzQ3PekUwer6DauENj/f6tqmTeUKLfQ+g2u+teGXplRfhRx5gK7urCureRtW8Bi+Q00AikHsjClu1R6qEEZ2iygMAKW174KD1DRqcPSlqiQ36Ba8ePYqDO6VjKySaI1QdU67g8S7bxvV3fbYsGgAyzSvrESQ3/gQqJvWLP8CisLaRE4mVfKwQSpJ7FNtNPKcByJKWbR9v0XZ0miiczjzEAJNw9e8R3gJr1yNuVka
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(2616005)(83380400001)(66574015)(6486002)(966005)(478600001)(316002)(54906003)(26005)(6666004)(6506007)(186003)(6512007)(53546011)(2906002)(44832011)(36756003)(4326008)(5660300002)(38100700002)(66556008)(41300700001)(66476007)(8676002)(86362001)(31696002)(8936002)(66946007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpzWlVEMlFDMFFxVUhaL2QzK0wwaXQ3RWx2QzM5SE5ranRISld3N0d3Ui9M?=
 =?utf-8?B?ZkhqNTlxSzNYYU5ZWUNGQ3BCbzREdmtKZ3hKQ0Q2V0xFWDMxS1duM3VQcDU3?=
 =?utf-8?B?bXhFUUg4RjFUbEdZT0ZPWVdjYUF2Qll6eDZERHlGM2hLWGgwbU04N2hJWGpk?=
 =?utf-8?B?dlZPYmE3cnNEeTN2ay9VS3NTQ1VGU3JiUitZa2hnZlhUQWhuQ25naGUyZkZN?=
 =?utf-8?B?bklJVlRBd3NkaGxXWEUxdUtRekRNcExVL1FBOVNaeGNDZEszU1JhdlE4Y1BK?=
 =?utf-8?B?T1Z4cE0xMmNHS24yRkt1cnpYajZ3Qmc0N291M3pIa1FRRStCSDNTVWgxTG9C?=
 =?utf-8?B?NW4yNnZKSGFTblN3U0dLVDdpcW1XZytCQWdYaWhKWDFVTkFpTDE5b0tMc3Br?=
 =?utf-8?B?ZW1DREtUWUpQalU5cTN4SGN0Z3g1V3NqSjNqNCt6aVNOM0JKZGdKb0t5M3d0?=
 =?utf-8?B?VmFBQnkrcnZYclZwZCtMUGNBQ2M1ZERuTm1OVXF5dExLZitiRXpLMUZDZnYz?=
 =?utf-8?B?RmpJNlZWVnNIZHgxR2RvUWV0TUdJYzJra0g2aW1vV3BHbm00Rjh4UzZLWkhJ?=
 =?utf-8?B?a0lvQk1rc2NCUkd5ODRORWpLUGNYaUdsSkhFWk5vc0xJVFJtVFZ2SnlpSGkv?=
 =?utf-8?B?TmJIVmV3SFNmN2ZsWElld2tMb0JmT0xLMTFTajNkcGh3cVROWHpxZjFvVEpX?=
 =?utf-8?B?cDcvMzJaVXg1aUduSk9KRnFpZnRSV29NQmNWcXJUVmxpUWw4ZjNtV0RwS2dF?=
 =?utf-8?B?ZWxodUVGaitjSkV3SEFmZ2ExbU5MVzFVdFBPTVdpSDBXU1hMZHhXVm5MSk5p?=
 =?utf-8?B?dndvR1lWclJBNnlQNHhreXdDVm80NmtYWVpJbDFyZzVjaFVpYTNpNkJ3dFZj?=
 =?utf-8?B?Q3QxcTh2cVVsU1c0SnV1WWpNVWI5d2ZNdktlM3ZkSVZDbDFxVCsyT3B0VlBQ?=
 =?utf-8?B?d2hueEhPWEtxb2FsT0pBZzg5VG83azk5UGE2V2dnbHpnVU03SURkWVE1SnRY?=
 =?utf-8?B?c2ozWGRmcXAzWXBPMTF0aVBHR2lvSThrS0lNQ1FkM2pqVkZpUzRqRmhtQnRN?=
 =?utf-8?B?YzJISFpEYmlRclo1U3hMYkZDTFNidVZqVXc5YzhCSGJBWTFTalJ3RW1UMXpS?=
 =?utf-8?B?UVkwSGliQzZOZERJK1NJNmJkZEZ6aENpZkJXVzM4MlkxMkN3TmRrckEweG14?=
 =?utf-8?B?dy93UGpZMVFDUjlWWUxpcjMrSXNSTit3QUlEa05NQWVrU1FwbVNkNklrd2Zy?=
 =?utf-8?B?MkhIZVcxUGdRWVBCQU9Qb2NBdm1qUzlkSHJneWdqTGlJUjE2K09pd0RyVE0y?=
 =?utf-8?B?MWdwR0szYktBci95TEdhb2xQTXRiWXBHeXh0dStReXFaNXlDYURoR0ZvbzNm?=
 =?utf-8?B?dXhmaW9iTjR2RVp5VmN4Z2xBbjNzWnhUWnhuMjNDck5pMDJhVkJ6K01sK0FU?=
 =?utf-8?B?dkZFTFpka1FTSS8rbStmbUtFdytBbEt4S1hzcy9uQjJpM05SazdWNm9SbzVQ?=
 =?utf-8?B?a3o0Y0E5cjc2a01WblprL0hyZm9yem9vTThpUjVEc1pHTVQzTkNuTU95ZjFu?=
 =?utf-8?B?bUF1SzcxQjBxdXVOOXVlT096YVMwV0VCdGZSZVVZcjRnUW1sd0lDeHp0anRB?=
 =?utf-8?B?cDFvd2lTOEtpSlQ1RkZEd2VGbnBWZy9xRUJienluUHBkK3MwSW5TZWVUME1O?=
 =?utf-8?B?eHRGVDM1TUZvR3psbVhFUzN0ekU3ZllyM3JPeTRkR01pd2FZS0VvcXhUdEZj?=
 =?utf-8?B?S3dsWHBNaGorYloyWmp0TWhlcjk0ZXp2ZXpIbVhMLzFzMDlFYTFrN1BXeldz?=
 =?utf-8?B?K2tJS3hBMjY3T1dEM1dPbUdHRVdOVGZvUmNpR1dVc0NWdzB0SW5YcDQ3L0d6?=
 =?utf-8?B?QytkemVZUGhrWWxJcERORG1ZaUUxUExNVUMwUjhVWStmVEFPcEx2SENkRW83?=
 =?utf-8?B?M2NHNWNlRTdpaE96TGkwUVhnU09pM1BBZlFsY3RJeWxTZWpEYWpUNkxRM0kz?=
 =?utf-8?B?cDFnS3d5UXJiMnZuOGYvejVlK0l1RXJkWWMzdFhES2ZiSlBWSmNOdWlOZW5r?=
 =?utf-8?B?ME5ENENpL3lPY3pmSEFCOGxQSEZFUWFOdWhua2oySm5tUjhhNGxxeWNuSDVZ?=
 =?utf-8?Q?2y/PNXzb7QKeEa00CJw72pItm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d1452-0f6f-4f29-5d64-08db35bd6458
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:06:15.4942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8YCO9emkEqdFeDOOHHatxlkhuEsASg46CO4ZOV3+ybI3wtjSurQBjiV/5PRV+NagBkfV9226uTRGQomBNKaFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/04/2023 22:58, Luben Tuikov wrote:
> On 2023-04-04 12:36, Shashank Sharma wrote:
>> On 04/04/2023 18:30, Luben Tuikov wrote:
>>> On 2023-03-29 12:04, Shashank Sharma wrote:
>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>
>>>> This patch adds new functions to map/unmap a usermode queue into
>>>> the FW, using the MES ring. As soon as this mapping is done, the
>>>> queue would  be considered ready to accept the workload.
>>>>
>>>> V1: Addressed review comments from Alex on the RFC patch series
>>>>       - Map/Unmap should be IP specific.
>>>> V2:
>>>>       Addressed review comments from Christian:
>>>>       - Fix the wptr_mc_addr calculation (moved into another patch)
>>>>       Addressed review comments from Alex:
>>>>       - Do not add fptrs for map/unmap
>>>>
>>>> V3: Integration with doorbell manager
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>> Just add all your Cc right here, and let git-send-email figure it out.
>>> Between the Cc tags and the SMTP CC list, Felix is the only one missing.
>> No, that's not how it is.
>>
>> You keep people cc'ed in the cover letter so that they get informed
>> every time this patch is pushed/used on any opensource branch.
> The cover letter is optional, and you can add Cc tags
> into the cover letter and then git-send-email would extract those
> (any and all) tags from the cover letter too.
>
> When you pick and choose whom to add in the Cc tags, and whom to
> add to the SMTP CC list, it creates division.


Exactly my point, there is no guideline on whom to add in Cc 
cover-letter and whom to add manually, its all preference.

Now different people can have different preference, and a review comment 
on what is your preference of what to

keep on cover letter does seem like a nitpick.

>
>> People who are added manually in cc are required for this code review
>> session.
> No such rule exists. It is best to add all the Cc into the commit message,
> so that it is preserved in Git history.
I believe this is also not a rule, we are discussing preferences only. 
It is my preference that I want to keep only Alex and Christian in Cc.
>
> For instance, I just randomly did "git log drivers/gpu/drm/*.[hc]" in
> amd-staging-drm-next, and this is the first commit which came up,
>
> commit 097ee58f3ddf7d
> Author: Harry Wentland <harry.wentland@amd.com>
> Date:   Fri Jan 13 11:24:09 2023 -0500
>
>      drm/connector: print max_requested_bpc in state debugfs
>      
>      This is useful to understand the bpc defaults and
>      support of a driver.
>      
>      Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>      Cc: Pekka Paalanen <ppaalanen@gmail.com>
>      Cc: Sebastian Wick <sebastian.wick@redhat.com>
>      Cc: Vitaly.Prosyak@amd.com
>      Cc: Uma Shankar <uma.shankar@intel.com>
>      Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>      Cc: Joshua Ashton <joshua@froggi.es>
>      Cc: Jani Nikula <jani.nikula@linux.intel.com>
>      Cc: dri-devel@lists.freedesktop.org
>      Cc: amd-gfx@lists.freedesktop.org
>      Reviewed-By: Joshua Ashton <joshua@froggi.es>
>      Link: https://patchwork.freedesktop.org/patch/msgid/20230113162428.33874-3-harry.wentland@amd.com
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> As you can see the whole Cc list and the MLs are part of the Cc tags.
> And the rest of the commits are also good examples of how to do it.
> (Don't worry about the Link tag--it is automatically added by tools
> maintainers use, although some use Lore.)
> This preserves things in Git history, and it's a good thing if we need
> to data mine and brainstorm later on on patches, design, and so on.

No, this is not random, this is actually well planned. All of these 
people here in Cc are either the maintainers or respective domain experts or

contributors of color management feature and keeping them in CC is about 
how this color management feature is being carried forward, so this is

exactly aligned with my point. Do note that this is a DRM level change 
(not AMDGPU level).


Also, I would like to express that in my opinion we are spending way too 
much time in discussing the 'preferences' around cover letter,

words, comments and variable names. No cover letter is perfect, no 
commit message is good enough to explain what is happening in code,

no variable name is flawless and no comment explains what is going on in 
code which is clear to everyone. These are very subjective to the

author and the reader. The only deciding factor is if there is a 
community rule/guideline on that.


I appreciate your time and suggestions but I also certainly do not want 
to spend this much time to discuss how should we add people in Cc.

Let's keep preferences separate from code review process.

- Shashank

>
> A good tool to use is "scripts/get_maintainer.pl" which works
> on a file, directory and even patch files.
>
> I usually include everyone get_maintainer.pl prints, and on subsequent patch
> revisions, also people who have previously commented on the patchset, as they
> might be interested to follow up. It's a good thing to do.
>
> Here are a couple of resources, in addition to DRM commits in the tree,
> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format
> (The second link includes links to more resources on good patch writing.)
>
> Hope this helps.
>
> Regards,
> Luben
>
>
>> - Shashank
>>
>>> Regards,
>>> Luben
>>>
>>>>    .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>>>>    1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>> index 39e90ea32fcb..1627641a4a4e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>> @@ -23,12 +23,73 @@
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_userqueue.h"
>>>>    #include "v11_structs.h"
>>>> +#include "amdgpu_mes.h"
>>>>    
>>>>    #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>>    #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>>    #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>    #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>>    
>>>> +static int
>>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                         struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct mes_add_queue_input queue_input;
>>>> +    int r;
>>>> +
>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>> +
>>>> +    queue_input.process_va_start = 0;
>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>> +    queue_input.paging = false;
>>>> +
>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>> +
>>>> +    queue_input.process_id = queue->vm->pasid;
>>>> +    queue_input.queue_type = queue->queue_type;
>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>> +
>>>> +    amdgpu_mes_lock(&adev->mes);
>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>> +        return r;
>>>> +    }
>>>> +
>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void
>>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>> +                           struct amdgpu_usermode_queue *queue)
>>>> +{
>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>> +    struct mes_remove_queue_input queue_input;
>>>> +    int r;
>>>> +
>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>> +
>>>> +    amdgpu_mes_lock(&adev->mes);
>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>> +    if (r)
>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>> +}
>>>> +
>>>>    static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>                                                     struct amdgpu_usermode_queue *queue)
>>>>    {
>>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>>    
>>>>        amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>>        amdgpu_bo_unreserve(mqd->obj);
>>>> +
>>>> +    /* Map the queue in HW using MES ring */
>>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>>> +    if (r) {
>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>> +        goto free_ctx;
>>>> +    }
>>>> +
>>>>        DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>>        return 0;
>>>>    
>>>> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>    {
>>>>        struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>    
>>>> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>>        amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>>        amdgpu_bo_free_kernel(&mqd->obj,
>>>>    			   &mqd->gpu_addr,
