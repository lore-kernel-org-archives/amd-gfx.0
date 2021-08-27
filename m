Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA5C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 14:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5A060E90
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C5A060E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5736E971;
	Fri, 27 Aug 2021 14:04:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504CA6E971
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 14:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK+q3oK67iaI6Eq81WODVzIrmi1UIWjSNgKIIpMuxKVqCyD9mDz4/x2N/ylwWZj319n0OS+tNtjmz3b5s+svwvTzaYzE23Pv4ISyDL6tfjyPnd7/YC65xE5mM2QEmrOPCUFfYsoOHu2mFRKDVfq8ruXk2mEQZC8zGsa9x4VIpwuYtbFVV709pt8cuoIfbb0NdwkkCDwXVTHF6LAawqxIURtoQD2VbSL+uIK0/O3N7dAgiNh11FNYdQuJhFY7aQLde8RTjUkNKBXX7mYtPFFlwp5rRPJvHtk4tzdlHmfqZX0fv7KAojZ50YMpEjZeWJHOZjGwlcW4M+5dNFauxFGvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skXTFoTPrAxM1phgltW+Jvb9oZjbfR4Iq9wFs+7YNAk=;
 b=azzB90Xo+YFJGJcrpxyDrMbX+/BRN2oGYCgp/Z4dCWztDrcyM4uyzcnGxaHxBedMx0fKvPcP7V6rRH7PM2LX759d5AwCylN9CqzzFffTruvbtE/IKfeqUrQ7KDg74iDNC/8/iE5QMd0Uj3694snpO3Qexm4q5np4O60oQhjdbfb8H7vUg5c3Ft30TIx/r+yLU52f4TTOJhoUWjPFMDeKC7ESkF/iA6o4P7G0muU6H+aQGtstiRe7N5480oWFj5B0o9YK86KX3PiuPVA6lAuT4qok5QvBrU62Tt/ojSPeRqm42+4FiNYOBkdCNDn2WyMOpY4bRnxGQ2ywVoOFW+BnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skXTFoTPrAxM1phgltW+Jvb9oZjbfR4Iq9wFs+7YNAk=;
 b=uKoNkCXLpSGETiixT6F1BJFNnR7fkBbczJb/TxKyWOf4/gW9uJAFSi7Dj0R8peGk4YphdCgwjv+wI+sZTkEOXMvjwVTiXHv+UVFjX5cWNPMhtmvV0gq1B7VA7LA6IK5UQFm6QYEmGJua1Z+Nyo9y4CUttNAuJGAAGzbizP3zNQM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 14:04:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%7]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 14:04:23 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
To: Simon Ser <contact@emersion.fr>
Cc: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Sean Paul <seanpaul@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
 <SrcUnUUGJquVgjp9P79uV8sv6s-kMHG4wp0S3b4Nh9ksi29EIOye5edofuXkDLRvGfvkkRpQZ9JM7MNqew2B3kFUhaxsonDRXprkAYXaQUo=@emersion.fr>
 <20210818131824.avczlw6ie3tfs76j@outlook.office365.com>
 <Hm33HvRokytajvNBSyeseBTVWScQu0mPJVLvRcABYsahB6j3DjJwvelk-WgnIA2AlG1AU0wnGV3gvAgzDf5nmWYRjIS58gMjtdrG0m_kjhA=@emersion.fr>
 <ffd29136-d0e3-17a9-f01f-e81c44ae0284@amd.com>
 <7a1d1909-cead-16ef-7b22-b2adc0cf3ee2@amd.com>
 <v7wPXeGl1gSs2otq7y-EJar0E_NLb4b6YxLZvzleaUPOy5jFuCOpuVFqTRWdGVJ7CP561cBXhfYy-TlQgIlX5vhxtqE64mBtt_cvtIyytXw=@emersion.fr>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <92c13bba-b86b-b943-5433-b2b822283774@amd.com>
Date: Fri, 27 Aug 2021 10:04:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <v7wPXeGl1gSs2otq7y-EJar0E_NLb4b6YxLZvzleaUPOy5jFuCOpuVFqTRWdGVJ7CP561cBXhfYy-TlQgIlX5vhxtqE64mBtt_cvtIyytXw=@emersion.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::47) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YQXPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 14:04:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7ec6efd-6a00-4cf6-6653-08d969639226
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54923529EBFBB3FC58FD7F738CC89@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+BSj+w9UPfSKbfoMmeoz4RePz4nM2YwrxmGYLWxLr+s5B5+zbw9lHCRFwZVcoRRJ6N1cUiTT2Di2yLHKct/pDCSdRO/Um2huuZokSIC9gEbm+czlgsfElJ5o3lQFwpUGLUoRFI1Dbe1yAdZkETV8CG1Iq1Wc0zOKZoDh2CUxU+J9386JZ8JvN+axSQHMIssf8gfKVcOrD348tnFzGP7c9pFonrIjIt4jIzir8BbfKgtThG/D8FjUgWY5rZiPvoFwiyqu3DW1gp5W56lYp9D3fKcVc2GI657KEC2l1blwFELBQNgoYOvUjl++PCk73hhxaFU+DSnW2ggTsHEEA3+Lf/vRSfnJWQgoEoUsFloQDSqhN7Q/H+BVsKvxsPJjgvmce8DiPro2qtfi0kbdZm6uw31hVGMqe8TttzVx87g3YiVleLZaIvtxVyszTyziMRanUUJzuAKfeQ4pCEGdXucpJTDE6KAj2roFTbHibiJSnrEChFKQyCY74LYT6F6aJyddodPiemi2+qOQcW+k5N0hcG/1nDvA8CMDsDP5l1gG1aWlQFDW1naAUTb3q9FYQLO3mOtiobNjBb5/r1GEoCJCpbLCkW5iWv7MGws9CftIPXC7Ub475v9nwZ79YBHOedNIDam0vfIY/+ifDaAPlobKHrrs7qwYYi0S6+YRFrlG6mvJ/pq+fbU29ajj2pCBhYh/Z0UP7174hxtkhNXS+IRTT4Vl0CporUM0CkNN5WQ5ZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6486002)(26005)(31686004)(8936002)(5660300002)(86362001)(956004)(2616005)(31696002)(54906003)(8676002)(16576012)(2906002)(38100700002)(66476007)(44832011)(66946007)(66556008)(6916009)(186003)(53546011)(508600001)(316002)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJlWDhxbWhtZHBNL1MyK09tOXV4SkJvaFJRS2JxT2FIRlIzY0c2RmlaSndj?=
 =?utf-8?B?SUtoOWw0M3gxZitqZkRkL3BCNG5HOUtnMFRHSjJDd0llU0JvTFJFdHlmYk5P?=
 =?utf-8?B?YzU1UnNKQUkvK1h5R0RCNmpjOXVjNENYUFdDbDFtVDdLbU1rdjR2cXJEWmhv?=
 =?utf-8?B?Yjg0L2p3NmlyL0FlMTlTWmxxWktyc3A0UjVUemFIbnZKbDlvV2E5cGIzT1hF?=
 =?utf-8?B?eEpZdjY5cVBzUTdzUktKc2s0L096ZVc3WFBuODZSM1lZQ3YydE1QYWFxYU40?=
 =?utf-8?B?SUNVVTJzM1pBYXN3NXA2QS81MVlJSURhWE5RZk14NHFHOUpTWjYxcko1VlhZ?=
 =?utf-8?B?ajNhZVgrYVg2UUJKU2lmak9NaHdYcXlvZFg0bUpUS2FzUkJiQ2pVWHJ3M09G?=
 =?utf-8?B?STdjZVZoN1Y0emVXbEtqcDh3MmJhcGpxRG8zNzlqc1drK1hVOHBrZGhyYURJ?=
 =?utf-8?B?cGx2ck9jalV0N3hFTXhkT3c5bGtoMGtLU3luekNkZHp5c2ZyYU9iTk1SVVJj?=
 =?utf-8?B?cEJuMGoyMTZITksxak5pOGVxZ0VhZmxyZTc4U0hKaHlxS1FlU2wweXNwanhH?=
 =?utf-8?B?czQ3Sm0zczl4VUtYc2xYb0N6SGpnOHZGK1EvN0FRV3lyTW5LUmQ1czJ3U2lv?=
 =?utf-8?B?N0U5Z3lkRDJWejkwMTQwb2NlKzJvbGtaYWRhUzlmNkJkaUJCRXEwVlA5UWVm?=
 =?utf-8?B?MjJaZWVudndwR2hFVS84a1lxYUhTZVhPMzNabkkwSkNIUjhNOTZMMysyaDl2?=
 =?utf-8?B?M3RHcUJHWUVlb2tMd3JQNEJsRmEyWEdiZFVLdWF2ZEJRdzZncXJpdERpVEYx?=
 =?utf-8?B?OGh0OXZtaEJCWVhySW1tZ3ZKcnVvRG5wOHZrRE0vV2k4SDhIRGg0MnNZYjVn?=
 =?utf-8?B?V29wTFJSMmZDMHZOT1V2K3VjcWFmemJQNGt3bzIyLzFKY200WXBkdlJNQUZ1?=
 =?utf-8?B?L1Npc1VpRDVoeXluQUZvR2JGUUNDUUlDZDNENVdtYSsvdGZDVFNtb1ZKVGtx?=
 =?utf-8?B?dGtvL0E4RUt4bVNPQnVGS3dGS3dsUzhCeGFlN1I0NGxtL2pERTZUanlXTDBs?=
 =?utf-8?B?clNGSjFQdVJlcDdMVkdRUWZpWERRVStUWmo3U2hOdmdUdTJFcjRhNTVwQnZI?=
 =?utf-8?B?NnVSYk5EaGFCdjVVcU1pVEJwaktTczJqTjBnbUFtTEdLc1loRDRtU1BCNXBY?=
 =?utf-8?B?cXZPRkZDM1NZeGcxMkdtR3MwR1hHRHBBVjBEWU5QTnl0NFR3WGhIc08vNG85?=
 =?utf-8?B?cjJTSitySW9tY2hheWpCRFhrbkw3d0h4ZjlaSk56TE9KOVNWK1gyM1ZnbVlz?=
 =?utf-8?B?R0p3SUJYdGpGYi9RMG1hb0dtWTErOVJXUnZqVTM2YWdrY0hrLytDSkxBNnlC?=
 =?utf-8?B?S0R2cFg1R2x1eXRJTUNsYmphWkZPNEVzaXUxQTdNKzJhMk1lOU5RL1grV2p5?=
 =?utf-8?B?Y05zSlJqc2ZFOEdoV29OZUNJSS9JdlJjbkhMUWlIdnhLTFR3V3lhVmljQ1Zk?=
 =?utf-8?B?cUpLZmc2OVZSNjFFSmV4SFN0YkMvcGtoQzNUK0Rjb0hmb1lacjk4RTZCZjkr?=
 =?utf-8?B?dEJMaWcxVmp0a1VVNHdZdUE4ekhRM2tSa2Q1VnJsVU5SZ1lKa3E0L01hWmJp?=
 =?utf-8?B?VkkvSTJxRnArenJVYit2ZUhrMnRYdTlvaGd5Z1JkV0JaY1BUQ3VZOExqakFX?=
 =?utf-8?B?cnJNa1UrZFlDak5uNG5sMSt1NDRZaC9Zd0hUSFFKK3drZmFqWUVZeit6YjMy?=
 =?utf-8?Q?i9meIoHr3XqP0l1jAoaWGPJt0U9vmcr70Uw6vxR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ec6efd-6a00-4cf6-6653-08d969639226
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 14:04:22.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGSzZrIrNb7+U3CyV+cued7GXYGBvltuHgig+r9CjJhya39KmF6yDwUBogg+ltVLm8FzH2p5udqP/vquPUeg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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



On 2021-08-27 9:53 a.m., Simon Ser wrote:
> On Tuesday, August 24th, 2021 at 18:48, Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> To elaborate on this a bit more, each HW plane's scanout engine
>> has the ability to scan out a cursor, in addition to the plane's
>> framebuffer. This cursor is drawn onto the plane at the scanout
>> phase. Any further scaling, color processing, or other operation
>> on the pipe will equally apply to the cursor as to the framebuffer
>> itself.
>>
>> Our driver will look at the cursor position and place the cursor
>> with the topmost HW plane at that position.
> 
> Ah. I may have missed something in my previous email then. With the
> scenario I've described:
> 
> ┌────────────────────────────┐
> │Primary                     │
> │                            │
> │                            │
> │        ┌───────┐           │
> │        │Cursor │           │
> │        │       │           │
> │        │   ┌───┼────────┐  │
> │        └───┼───┘        │  │
> │            │            │  │
> │            │            │  │
> │            │     Overlay│  │
> │            └────────────┘  │
> │                            │
> └────────────────────────────┘
> 

Nice diagram.

> Is it possible to draw the cursor only on the overlay pipe (not on the primary
> pipe), even though the overlay pipe doesn't cover the whole CRTC?
> 
> Or will the overlay pipe crop the cursor image?
> 

It will be cropped to the overlay rectangle.

If you can allocate your overlay such that its destination rectangle
always spans the entire CRTC you'd have no cursor issues. Unfortunately
that means that you would use more memory bandwidth since you're
scanning out an overlay that's larger than you really need.

Harry

>> If I understood Simon right the primary plane (bottom-most,
>> game plane) might not cover the entire screen, which is fine.
> 
> Yes.
> 
>> Is the Steam overlay always the size of the crtc, or does it
>> match the size of the game plane, or is it unrelated to either?
> 
> The overlay may not cover the whole CRTC. The usual case is some kind of
> notification bubble showing in a corner. See the drawing above.
> 
>>>>>>> Basically, we cannot draw the cursor at the same size and position on
>>>>>>> two separated pipes since it uses extra bandwidth and DML only run
>>>>>>> with one cursor.
>>>>>>
>>>>>> I don't understand this limitation. Why would it be necessary to draw the
>>>>>> cursor on two separate pipes? Isn't it only necessary to draw it once on
>>>>>> the overlay pipe, and not draw it on the primary pipe?
>>>>>
>>>>> I will try to provide some background. Harry and Nick, feel free to
>>>>> correct me or add extra information.
>>>>>
>>>>> In the amdgpu driver and from the DRM perspective, we expose cursors as
>>>>> a plane, but we don't have a real plane dedicated to cursors from the
>>>>> hardware perspective. We have part of our HUPB handling cursors (see
>>>>> commit "drm/amd/display: Add DCN3.1 DCHHUB" for a hardware block
>>>>> overview), which requires a different way to deal with the cursor plane
>>>>> since they are not planes in the hardware.
>>>>
>>>> What are DCHUBBUB and MMHUBBUB responsible for? Is one handling the primary
>>>> plane and the other handling the overlay plane? Or something else entirely?
>>
>> MMHUBBUB > DCHUBBUB > HUBP (for each pipe)
>>
>> MMHUBBUB is irrelevant if DWB (display writeback) is not used. DWB is not
>> enabled in the driver.
>>
>> DCHUBBUB is the overall scanout engine for all DC pipes and includes a
>> HUBP per pipe.
>>
>> HUBP will have requestors for the primary framebuffer, DCC meta, dynamic
>> metadata (for things like Dolby HDR, though it's not fully implemented),
>> and cursor data.
> 
> I see. Thanks!
> 

