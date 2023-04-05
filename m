Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5D4C77B6C
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 21:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF9710E553;
	Wed,  5 Apr 2023 21:18:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526D110E553
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 21:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOQa5vpEb5WAbAoISMtEe/zXWAQx13p6ZOhVc8tFYo4WX9uWgjNk21C+Fq5Qsq6DnsMn+22MJmEZzJxX0YK/iuk2bVM405hLF5aatb7q36kZ77QirXAu7zkotqHm/5oAf27x6v6tnN33OvkgFtVsuoJNaPbCdfpPQrUBGqFxmxIHYTd1vcuKtQbd56lCOzAnpX9UoHn1zMqxw/XK7TzKUsh8+8vXzZ0ksT1L201747VPt25yJP3Yg8dGVC4dVUEnnTcKUHQKUG+mjsgN3xqUNn0NS2wtYXGu1eVa09RVJv+e/FLUhnx+ftDwTOHaSEB/o06RrM9XZq7bfOh+sAzUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WfGYfK8YTCB58j23UDpMxWrdo+2i9IZ4sojq7tGHeQ=;
 b=C0foX2NtrcF+5xb5QjwQrUdaa4aJsaxHINlOu0m+N2LGa4FT9bk9GzO5udvVzkBuLeAinGMc9XnR9/y64G/7pZDTB0DoxD2Lx+k1NFk6tyUHb+u+ZelgC9Mg3zdVuHtIT3PZx4OXDHgjOCAcRQE27/+Us3ZG9XdEGzXvwKkjz7bj/+llBVxbc6v1gtY6rQAUVxVNdXAEmkSt0M/Vsvsw4YEUyCJjC+I3QEetx+Ez4NzU5wPbqTEI5xJMBEgaJS/VB3Se8Edh0XlR5g8Ke+19aTntw1HBLxeFBOLSQaTTQ0qR/CTTQrnPnPFIzFPus7ZRRhZHTeeXYy+4keBZhTdthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WfGYfK8YTCB58j23UDpMxWrdo+2i9IZ4sojq7tGHeQ=;
 b=YmiQeVIbEpD+TKnUxwgOVkoaeGIWS9ecYBOi9nMTZmgd+yEnYEUHvvxh1bEIVonmd85xzava+YeR78HT8v4cSKGcUasJbqeRmJ/W0XY/Q08KrqWX1Y31OsBdK3I/Guhh/ePEZmkgv6q2ikK7jIKrNNEhPljcfVdVmxmH6fQWv5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 21:18:22 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 21:18:22 +0000
Message-ID: <bfbfab82-ca0b-d70a-86a6-6a72301beaa2@amd.com>
Date: Wed, 5 Apr 2023 17:18:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
 <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
 <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
In-Reply-To: <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbaa10a-2dad-4e90-0027-08db361b48ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duK4Z+ijwVYzAjv+PirPjqDGF1lFpXK09QuKhtyXfYaphjC9Pzs4eUMkg2cC2dCTZF2/5jcxViHGMKEKO5207rM4QpDg50ukBLbqhYIjA+N+aRWiY+vod7lOQl1cmPMuQkceo6uNKALmOnr6K/h5BtaUl6ZwF2pSEVYGtlBkmnnKZcb19z7nvVFL7d9/aGawAEAuHLLZr/110WIU+GPMpCMATqJzXsrZaZWgEyAclY8q/crPSN3G4xXiwF40Wf6GSCE/NpYKKTEShwQ+rdGaOhFdaQFHMedAp1vx1l1TzwcMUgygpfsq45rf+R4g+/Oup3mnCmvo/b9ORYufjyTcTv+z5q6WShFxzH24yXEPZDbwVIZevTcIUErQxV8+A7CadNFqh4MBVO8yJHhv3hBY9krRauJbWjF8swMO41dfIzVTEUUU/5JCiqd4xHi5nQca5CwH7ttZ/Ir3pbnBBQwaIEX/MgMNY13XAsggmWHG8fw5zCksx0H8Fj0bRZEmEq9rO/ejvZRZVlaG22iqj5aUL7uRt7jf+mq8aCxq3rJzCcocjKKcNKFxoRwVt+Aw4xoTnwvBXuNsMi1pfHqYzmR5614k6oqAJhVeDH2Julr9C/3KdoUw8inJQAjGV6uRpeX0lt3bRbT49R1S4ATdp7bArVoEtKnHhBeOzkF4SvzH0IPefkWAPxs+po8XQT+CSLTB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(38100700002)(36756003)(5660300002)(30864003)(2906002)(44832011)(31696002)(66946007)(66556008)(41300700001)(66476007)(8676002)(8936002)(86362001)(4326008)(6486002)(83380400001)(66574015)(2616005)(966005)(6506007)(6512007)(54906003)(26005)(186003)(53546011)(6666004)(478600001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzNhR3ZoRFlCb1FSREtVZmpQN1dQcDJEemNaaE43ZUFKdkRHZW1ndmFQaFMw?=
 =?utf-8?B?YzV3UmFLYlp4Y1pkaHZ5ellrZ1lrT3hKRjJQK052bnVyeHZCelFGMStvOU5h?=
 =?utf-8?B?UUR0VWpMRkwvNjhZWW9tcjFTaDRMb28yN1F6c3d3MnlqZnliMjZmRVRndWpi?=
 =?utf-8?B?TXA3Q085OUQxbzh6eHFVb1d2bDdybk5NZGs2VkFTdmN5TUlCZER0aytIbWpo?=
 =?utf-8?B?L2s1a3hhT094azZUaVJRZFhVNDU2cG1nUk4zL1hoeGxhYVdjTUVhQlZDazJh?=
 =?utf-8?B?c3R4VSt4bzBTazYva3VwK0lyZW1rQkl5TFIyQ3pQcjZ3amFIY3I2K05OZXFM?=
 =?utf-8?B?SC9LRkxrR3llSXVxRS9HMHgyNnFmb1l2UnE1Ymw1ZGhpMDlnS0kzVTFscXZC?=
 =?utf-8?B?TFJ0ayt0TzU3anlhY21IRkZFZGE2SllXYlZaZWt5dStSTnMzV211TzVvSW1v?=
 =?utf-8?B?TEV5TWVpT0EvNDUwRmxnQTNuMjRNa1B6RzA5UzlJb3BVbUJSdXRRRENxTEFI?=
 =?utf-8?B?TUFRb0M2L2FxZmdrTlBxajZzKzNUUVF3ZFRHVWh3eWZkeUR1amhzWXVhMDg2?=
 =?utf-8?B?blhTZEFIMC9RWXZtSmVYbWpST0wvSnY4Nk5TVklCNXkvUTJPeXhhdktscnpt?=
 =?utf-8?B?RmlTNTZLRnNJdFJMUWwrMmZFb0MrVVpaU3ZzTkZMSDJBOGdpMmlqVmptUnJV?=
 =?utf-8?B?UGp1SFRqcE9VbG90eEFHRWd0NXJQSlg4S0pLRG1ISU5OOFpvbndlYXFqUllT?=
 =?utf-8?B?Zjk2N29qaWdlTUtkK0ZBRThjWjVPUFlUSVJ3YUU0a3ZNWWJqZHlWNDRrWnc0?=
 =?utf-8?B?VkRGcnlpQUZOZ3dyZVY5QW85cVNWdGZBSmVaY3o0L2ptcEhWb09OMFBsbkRw?=
 =?utf-8?B?TDl6aG1YYTNuRFVxNmtXZERZY3NOU0tJbHpFbUFjTWZpbnBsZ0RxY1hKVFZ1?=
 =?utf-8?B?TXgxbSt1dnpyY1JXeEkvWFM1NDQ4azJTVWRKd0xkWU9ZblhXdTArc3g2RGpK?=
 =?utf-8?B?V0cvTlR6UlRsTWhTanZzT2xSWHFXUUJxM1FsYXFObkFHOWhDT0QzL1M2cUVH?=
 =?utf-8?B?bmRNZm9WS01ZWEkyTG01WGgyK2JVWkpJNDJ4ay9EVThlSGo3blFORHZ0eDAv?=
 =?utf-8?B?aDBES3pyb3k1TVRDMk9lL3hjNkkwUmxwUGl2elhmaTQ0cUp3b24zN2tFRTNT?=
 =?utf-8?B?ZmdYRVI5cTZTSGFNLzFZSkdpZFBzYU5sS1poRTdLNStMTEtsWDJxdHhmbW5D?=
 =?utf-8?B?Uzkxam5mcE8xaFFyYmQ5bUtJWTUzSXA1NWR0akVBUW5NQm9UOEMxejBYSVky?=
 =?utf-8?B?Z2xTMXpvTFFIdGFQdWtvOUJPOWxuQU9DRlZSVW45b0I2ejBqbGpuMzBNZ2Y4?=
 =?utf-8?B?Z3FsR3lLYXhML1RwT2JSeDh4N1Nnd1BrendDb29UNW90TW9KM1diWFF2bytP?=
 =?utf-8?B?UUZqaTFIZ0tIR3c1ZHMwN0hHei9zcllIL2xXZ0pMVy9mcGpxUTE0bUJBd1lG?=
 =?utf-8?B?Rm12NG5xWjFkaXh0eWIzUzdDLzhkUWFIcEh4WC90amU3TnZvL094UTdJUzFJ?=
 =?utf-8?B?dDNMMUgrU08ycWJnZUR4cEcrZGZJWkdFbVB4TXgwWnlVa1hoYVA3ZWM2Kzhn?=
 =?utf-8?B?L1JrdUdnWis3bkZEVHFXSUVOV2lFUVU4a21SZkE1STFIQ2FsbEVQV2U2ZlhB?=
 =?utf-8?B?SXZmYXplVytBYktrU3FCOXdGSktQUmNOdTFqWkppNXltbmhoRjd3UjlEWTVF?=
 =?utf-8?B?Wk83RUVQSjQ0S1BNOWZHb29VeU5JUFlUTitxdUUrQUdjRDFxNzBkTnRsT2Rh?=
 =?utf-8?B?SUlUM0dCdGIzOFpIbDE2VW5sNVA3dUIvUmM3eUViRUhGdzVRN1E5WnBVWE9Y?=
 =?utf-8?B?NjA1MjNhenF2ZldNZWhaZDYxa05FQmxSV2hndS9XN2hLZVlmTWZsZThhRGxQ?=
 =?utf-8?B?MUQvWS9LNEZMZk0rOTFvRms3YnVCZDMwTWptMkkyWUZDdjlyazdNeGhNOWd5?=
 =?utf-8?B?WDFYTzJpdy9iWldGYk10eGhhVlo2OXlGWjY1OHhlQUZ4V0ZhQ2YxSWdUUWt1?=
 =?utf-8?B?VUd0c2xZZkJEMlM2MExWdUp1K2dUVk1ENWlVWCt4di9JeURyUGR3M3VaRnZ2?=
 =?utf-8?Q?XVT/LevxqxyeRLyCLIjoimM9i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbaa10a-2dad-4e90-0027-08db361b48ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 21:18:22.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyVJAF5/m78LFEPbCyq594vmCqR4yE8RO3OM/Ru+ybEcDbMmRLBhBm83+MPMXfe1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
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

On 2023-04-05 06:06, Shashank Sharma wrote:
> 
> On 04/04/2023 22:58, Luben Tuikov wrote:
>> On 2023-04-04 12:36, Shashank Sharma wrote:
>>> On 04/04/2023 18:30, Luben Tuikov wrote:
>>>> On 2023-03-29 12:04, Shashank Sharma wrote:
>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>
>>>>> This patch adds new functions to map/unmap a usermode queue into
>>>>> the FW, using the MES ring. As soon as this mapping is done, the
>>>>> queue would  be considered ready to accept the workload.
>>>>>
>>>>> V1: Addressed review comments from Alex on the RFC patch series
>>>>>       - Map/Unmap should be IP specific.
>>>>> V2:
>>>>>       Addressed review comments from Christian:
>>>>>       - Fix the wptr_mc_addr calculation (moved into another patch)
>>>>>       Addressed review comments from Alex:
>>>>>       - Do not add fptrs for map/unmap
>>>>>
>>>>> V3: Integration with doorbell manager
>>>>>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>> ---
>>>> Just add all your Cc right here, and let git-send-email figure it out.
>>>> Between the Cc tags and the SMTP CC list, Felix is the only one missing.
>>> No, that's not how it is.
>>>
>>> You keep people cc'ed in the cover letter so that they get informed
>>> every time this patch is pushed/used on any opensource branch.
>> The cover letter is optional, and you can add Cc tags
>> into the cover letter and then git-send-email would extract those
>> (any and all) tags from the cover letter too.
>>
>> When you pick and choose whom to add in the Cc tags, and whom to
>> add to the SMTP CC list, it creates division.
> 
> 
> Exactly my point, there is no guideline on whom to add in Cc 
> cover-letter and whom to add manually, its all preference.
> 
> Now different people can have different preference, and a review comment 
> on what is your preference of what to
> 
> keep on cover letter does seem like a nitpick.

I am describing consensus. Take a look at DRM commits to see what
people do. It'd be nice if you followed that

> 
>>
>>> People who are added manually in cc are required for this code review
>>> session.
>> No such rule exists. It is best to add all the Cc into the commit message,
>> so that it is preserved in Git history.
> I believe this is also not a rule, we are discussing preferences only. 
> It is my preference that I want to keep only Alex and Christian in Cc.
>>
>> For instance, I just randomly did "git log drivers/gpu/drm/*.[hc]" in
>> amd-staging-drm-next, and this is the first commit which came up,
>>
>> commit 097ee58f3ddf7d
>> Author: Harry Wentland <harry.wentland@amd.com>
>> Date:   Fri Jan 13 11:24:09 2023 -0500
>>
>>      drm/connector: print max_requested_bpc in state debugfs
>>      
>>      This is useful to understand the bpc defaults and
>>      support of a driver.
>>      
>>      Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>      Cc: Pekka Paalanen <ppaalanen@gmail.com>
>>      Cc: Sebastian Wick <sebastian.wick@redhat.com>
>>      Cc: Vitaly.Prosyak@amd.com
>>      Cc: Uma Shankar <uma.shankar@intel.com>
>>      Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>      Cc: Joshua Ashton <joshua@froggi.es>
>>      Cc: Jani Nikula <jani.nikula@linux.intel.com>
>>      Cc: dri-devel@lists.freedesktop.org
>>      Cc: amd-gfx@lists.freedesktop.org
>>      Reviewed-By: Joshua Ashton <joshua@froggi.es>
>>      Link: https://patchwork.freedesktop.org/patch/msgid/20230113162428.33874-3-harry.wentland@amd.com
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> As you can see the whole Cc list and the MLs are part of the Cc tags.
>> And the rest of the commits are also good examples of how to do it.
>> (Don't worry about the Link tag--it is automatically added by tools
>> maintainers use, although some use Lore.)
>> This preserves things in Git history, and it's a good thing if we need
>> to data mine and brainstorm later on on patches, design, and so on.
> 
> No, this is not random, this is actually well planned. All of these 

I never said it is "random"--it is not, it is well planned because
everyone submitting to DRM does this--it's common practice.

> people here in Cc are either the maintainers or respective domain experts or
> 
> contributors of color management feature and keeping them in CC is about 
> how this color management feature is being carried forward, so this is
> 
> exactly aligned with my point. Do note that this is a DRM level change 
> (not AMDGPU level).

So, then why isn't Felix in the Cc tags? Doorbell changes touch that area too.
He's actually the only one you left out, other than the MLs emails.
Either add everyone to the Cc tags in the commit message, or only add
your Sob line and leave everyone to a --cc= on the command line. Both are
common practice and acceptable.

> Also, I would like to express that in my opinion we are spending way too 
> much time in discussing the 'preferences' around cover letter,

I agree. But those aren't "preferences," they are common practices,
like for instance not separating the Cc tags and the Sob tags with
an empty line, or shifting struct member names to the same column
for readability, and so on. Use "git log -- drivers/gpu/drm".

Regards,
Luben

> 
> words, comments and variable names. No cover letter is perfect, no 
> commit message is good enough to explain what is happening in code,
> 
> no variable name is flawless and no comment explains what is going on in 
> code which is clear to everyone. These are very subjective to the
> 
> author and the reader. The only deciding factor is if there is a 
> community rule/guideline on that.
> 
> 
> I appreciate your time and suggestions but I also certainly do not want 
> to spend this much time to discuss how should we add people in Cc.
> 
> Let's keep preferences separate from code review process.
> 
> - Shashank
> 
>>
>> A good tool to use is "scripts/get_maintainer.pl" which works
>> on a file, directory and even patch files.
>>
>> I usually include everyone get_maintainer.pl prints, and on subsequent patch
>> revisions, also people who have previously commented on the patchset, as they
>> might be interested to follow up. It's a good thing to do.
>>
>> Here are a couple of resources, in addition to DRM commits in the tree,
>> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs
>> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format
>> (The second link includes links to more resources on good patch writing.)
>>
>> Hope this helps.
>>
>> Regards,
>> Luben
>>
>>
>>> - Shashank
>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>>    .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 +++++++++++++++++++
>>>>>    1 file changed, 70 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>> index 39e90ea32fcb..1627641a4a4e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>> @@ -23,12 +23,73 @@
>>>>>    #include "amdgpu.h"
>>>>>    #include "amdgpu_userqueue.h"
>>>>>    #include "v11_structs.h"
>>>>> +#include "amdgpu_mes.h"
>>>>>    
>>>>>    #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>>>    #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>>>    #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>>    #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>>>    
>>>>> +static int
>>>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>>>> +                         struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    struct mes_add_queue_input queue_input;
>>>>> +    int r;
>>>>> +
>>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>>> +
>>>>> +    queue_input.process_va_start = 0;
>>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
>>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>>> +    queue_input.paging = false;
>>>>> +
>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>>> +    queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>> +    queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>> +
>>>>> +    queue_input.process_id = queue->vm->pasid;
>>>>> +    queue_input.queue_type = queue->queue_type;
>>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>>> +    queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>>> +
>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", queue->queue_id);
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static void
>>>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>>> +                           struct amdgpu_usermode_queue *queue)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>> +    struct mes_remove_queue_input queue_input;
>>>>> +    int r;
>>>>> +
>>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>>>> +    queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>> +
>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>> +    if (r)
>>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>>> +}
>>>>> +
>>>>>    static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>>                                                     struct amdgpu_usermode_queue *queue)
>>>>>    {
>>>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>>>    
>>>>>        amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>>>        amdgpu_bo_unreserve(mqd->obj);
>>>>> +
>>>>> +    /* Map the queue in HW using MES ring */
>>>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>>>> +    if (r) {
>>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>>> +        goto free_ctx;
>>>>> +    }
>>>>> +
>>>>>        DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>>>>        return 0;
>>>>>    
>>>>> @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>>    {
>>>>>        struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>>    
>>>>> +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>>>        amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>>>        amdgpu_bo_free_kernel(&mqd->obj,
>>>>>    			   &mqd->gpu_addr,

