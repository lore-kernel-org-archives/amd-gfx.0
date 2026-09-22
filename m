Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20AC982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C2510EC0E;
	Tue, 22 Sep 2026 09:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uEq8/2/O";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588A010EC12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GchghgOmNIX5CV4IXE+pTESj8eHfNwCDf2/yzFXQD4oWaJ5C3ITVJTdDJkTMHhf63kReHy+TBorroDQ/ib7VWwgTwh7VeRgGpxfps0SoUl51I1g3t8Tiy5WFW2iN1lzk9MR5tGVeAoGae8IeApkG0mD4v+nCLNklI2r3wiiwq843ncvgI+7qUgdS91hkCw3cBlS7UV8C+SROF59gl9zK2BsTvV1J9No1YjfiwOONagNCb8LdtSWKg3TLXBP4cNhjLPDnkzagLJ39A2zeCiAkI5eVo42gGGHDkDGb92Yn7pkpi5xsfDp21xS898qaUxBxWftivTtIFl548skHQIMYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5I0GYrr8RxVPTMI0KKsE20I6c/WXqcImHIFbJVgXOVA=;
 b=sD0DTJ6yyZW+LFADfUCPmWJheu2O8SMi9McrUU9CiT1V0FAt2tbDoO5YqAoBTitXLXkmhs4t7+6cYr6uXSIE0iUIkR//9jZsbzllm7NDnTW+eWMr3F+qNNUUVbnmWwmeEvPcdG4HaMDsRyX2sJ0UeU0O6N6ypfIZrqr7O9tc4upiQlyKza4bY2CgPfv4tGLtRZXwy+tvyswHmIKsMZX9BkJebw3Haa51j5Gh3NtLEH0p2PpKigbg7XmFEyXB8qENjpsdoOqCKsO37YQmGiive9ROcJbk9eCUI18/F+g/kVNZ/EtGfQCBrKMjzzt89Sjv8r8t4yz4w+nsDfCW3vwBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5I0GYrr8RxVPTMI0KKsE20I6c/WXqcImHIFbJVgXOVA=;
 b=uEq8/2/O5ylw/c0JXvXey5Suz+vN1f60t9HSwMaGw+6+BoJ02aHasGlgktGm4vBBYMLI7uAXsFSepq56gGXfJxlUiMobBW3dz67HzMX7NnM914bab8l+FqUWMvJGxZfcXiDTRO+Mr9GN4rwsYn1JwIRDilsQaiJ9k/QlYOJeSNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:00:11 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:00:11 +0000
Content-Type: multipart/alternative;
 boundary="------------AgA6RZk3jDyLLx7wNQzh0u6r"
Message-ID: <02168e96-1c44-4aaa-bde4-474c8264a3c7@amd.com>
Date: Tue, 22 Sep 2026 17:00:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com> <arI0hEYQbrsWVlV1@amd.com>
 <580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com>
 <cbf15177-c94a-4bee-9ba2-f14b7860c4c4@amd.com>
 <b277046c-a13b-4d47-a7fe-55e18a720e20@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <b277046c-a13b-4d47-a7fe-55e18a720e20@amd.com>
X-ClientProxiedBy: SEWP216CA0013.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::14) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: b04315ce-cc76-4165-9531-08df1887e8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|4143699003|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MYoKMXzpSR5xJkQEM6UUqhMkaSKUTtbF4Z6Betv0481cnHzCgjXN6G+Q89J26PymDrOjOQ/AOvp7B/FZ/Z81byeUt3N2HgpNSmu67qDoljzUeSvytNLWmmV/KCssJz7EJtlP6VIRKjSpk3cyZ97W2I2yRKWf8Onu+1uihudJcKc2vcKSivnHV82bKkhfpJSOPMY6+Zlys0+OhpPl6IqAF4Goq8s4VCMuHj/FibcNW5iFJflsO6K1NbeitHkW+1O8qUeKkKX+j5jTfhvisHuh1iKLqBPYiFe80op3Mus9gwDer2ygzDTabqWsj5CS15AnMprdUJ+ThRZO698fphbNnQeVBv1It/Ya856ZGCQ3FHTtAHhhAHP414joLTArSnck0wRyzKHanaQPj5hS6/42THKgOaw/2kKyAC25srh3HI31waRmiSDN0eVbf/Gq+vUpiAPo0ku3BzrHZmXlRU56iiuXhcQgAQK06czlTCkrvkz3NNPWBfaE6Q8gin8jPaeQhwLg8oNuLheHE5cpqz6FTkbEV35md8VvdCtzW+ZHcGMFWiZ2UxEUwO28ek6dOlQhRBC1sKmbn3zvfyex14ThQAbIVb8F6pO/dTfQJTZqosT++nsyVzzNdlu38+FvT9lOkz7DKO9gxOn2P3UFhZI+RwiOAmNDLOVQ6K9ZMFzwBLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdiajZjNk9tUW5ucTA4RlE3OEdzblpwVEZJTXhyQU1FajlVOVhoSWJ5WXJ0?=
 =?utf-8?B?WGU1VDFmUndJbS9jRmRVNGRvSktyN0Y4eUt4MVhvOFpUWitiakl4UGswc2tm?=
 =?utf-8?B?ZnM2dGdrUnBOU3FQRkVwUTBDTkJjeWNlWTJVZHRTaTlMSEIvckFFV3FRRjNH?=
 =?utf-8?B?TFFLY3M1bTRPNHBBMkt0Z29YNXZBaHNkSnRIZkZ2a0VMOW1WOWZCeDJ4RDl2?=
 =?utf-8?B?aysxakIwbENJZ2lrVDFZeW0zWlhhc3BaK3REOWFINmNmT0tZZ0dwR2oyaC9W?=
 =?utf-8?B?ZXJQWjk4NERITEorOUUxRUQ3bEdVYW05aXIxUXhrdE8zS1FMdHp5UkxNcXNW?=
 =?utf-8?B?WHRTbWt4M3BXellOdmhPTVFSN3dldXpvOGxFN1dKbzNzMTA0M3FoZW1jMzhH?=
 =?utf-8?B?dHVUVjJaZTNOT2NRNmxid3B5dEhTTkR0dHVhNEZFbk9oRWpyUERzdFIwTEJ1?=
 =?utf-8?B?WHJHaDhTaFZZb0szZmVuSUZMOVFiY2tPYjNZTFJOSEduMVNOV0NzQkVxcll5?=
 =?utf-8?B?bjM1VGVqbVdXZVZEZHRpa0pZekJGLzVzcXFGbjhyTlREQmxvMGZCYXk5b0Zl?=
 =?utf-8?B?NTJnQ25Fb21hNDBWTDE5MTlYek0yM2RkV09yTmUvUldjY1J0ZEQ4R3JFeG5j?=
 =?utf-8?B?OWdRc1hidWtubmdNd21pczJ6NWUxQ2lZR3h1Qjl4MlhHYlRzVEJkUmkvVHhR?=
 =?utf-8?B?RWhYc2MvTnloWWdDWXN1dlZLM3M1RUlBTXRDZG5JZXA1eUxsRTVSVXlmejNM?=
 =?utf-8?B?c1BLZzVjLys1dXhLdlpwWFRiaU1DS2h1WmxGblZmM3hjNG04WUVmTjk2ODkr?=
 =?utf-8?B?ZTd5L2crOXBGWktJV25LaGY3dEFVRFBOWFBQb0FMbjkzS3R1Y0ZCSFZGRjJn?=
 =?utf-8?B?NVVmMVJnbXNFMUFESFRZS1Npbm5yN05raCtpYS9wajc2V25YM3Nhd2dpUjcv?=
 =?utf-8?B?ZDF2Q3duemlMeCtENnl5eW4wczhteTFPSWRnV1NwMkFmVHNnWVJQdmlqNFJ2?=
 =?utf-8?B?cnViYnNSVHB1VStPT3cwejBZTkpuU1FaNUp6T0pRc1hBT1dJdHp1YkpJQzQ2?=
 =?utf-8?B?MlBDQmVnRXFIdlZXQ0Y3VWtqbkF6RmhiRFFMSHBjQ3EyMko4a3JnREJIZys1?=
 =?utf-8?B?dlZLMDJTOWhDb3hxcEtWa0RBNFM1cHh3bFB2cEpiMlp0UjN6WFdFUmF5TEtL?=
 =?utf-8?B?d2EyU09uQ09YNldTb2c3R1ppZ3g4Q2FCZjhFcDRQbGpUbVZNRWtMeVQ2Qi9E?=
 =?utf-8?B?NGZkQUlUTkJHSFZXU054T0Z1bk96NmRyMHVjaTRKUk1kQkN6dnJmWXplS1Zo?=
 =?utf-8?B?dlJZOXZLaVhIbG04QTFzUlFOQUVPcVY1YXdSNzlxY1NvRHdZZkVtZUIvbGQ5?=
 =?utf-8?B?aElXbnI0NDJjVlZxeDgyZy9iZW9mNzdZVnZ2elBqL0hob0EzeEpoOFlTaUIw?=
 =?utf-8?B?b2xzR1pkT0hLUVR6d1A5am9nbFVRd3pOZ2I4ekozTUxtdTVORHo0U1FMRHhY?=
 =?utf-8?B?aks0N1BCL09tWUJTejVKV2M2RDBkMmg3aThWR0dQOFYxT1JxYWpYNGIzNXhQ?=
 =?utf-8?B?YkJtc28xeVp0YVJrUVFDL1UycEdyYVRySm5KdUVpUkxPd0JnWXE0bFpIbytv?=
 =?utf-8?B?RHpOZm1ZKzNqVkFDQUV2eDJDdGxGbmZPU3RBNmdtV0lDVXc4bGtFelc0TDdi?=
 =?utf-8?B?amNsc2lVZXQ2cUE3Zm1yYTFLWjRFM3hHRURQd2xoTkxHanIzTjhWcCt6YzZY?=
 =?utf-8?B?cTBRTE5hcmNaVlNsMDBIdEcwaFB1T3pjZTFhMk8wVGZTYjRueUZia2dYREtZ?=
 =?utf-8?B?VXVxMlFJUTYwMU1OcjFmWWVzcVZ1TzNCVFNDR29vYnpJaEFtMXZOMDU5K0Jl?=
 =?utf-8?B?RWJmSXVSVnc0cWJ5b3psdG5ZTXZicnJBM1YvdVFtb05YZzRub3orY09zTTJT?=
 =?utf-8?B?RTNrZkg4ZklJckhKalVZN2lxd1pKdXh2U3Q2NmVqN0ZjVHVPT1ZNQTFMazdI?=
 =?utf-8?B?UWJHbHc0bjhUcy9tbzBTMXNxZ2VpQWJhZmJrNk92VmVwVzVVZkV1ZjN1bGdx?=
 =?utf-8?B?L1U4d0kxeUZMZmhqMFJxRmZYMlVxTy9waS9WVG5HbGVYbEdaTTFFNU5WRGF0?=
 =?utf-8?B?M2xIS0lIeWlrQnA1ZEMyaE0xNTZyVHRKZDFIWGJOWkpwQVdHTGRLK09iUkNt?=
 =?utf-8?B?enN4TGlVSlh0eHh0b2VESkJrc1UxdVRMdWgyQ0JZYTlTWjZsU2REY3ZleEEz?=
 =?utf-8?B?ZG9sWWlYVnh1NXUyK1F4a2pyNDl3RktyYklUd0xzbnVvZEdvT1ZqVGVNbWV0?=
 =?utf-8?B?Zi95aHozYUdHRmZ1SEpQN3g4bk45bnZBb2JpV2prR1lPUkRhcDZKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04315ce-cc76-4165-9531-08df1887e8ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:00:11.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJk2iF5yC4N+IqiWdHtxYsVgB8ZfZPdNkicqfrxNOCRAjBkOA9S9IEjsVU/P2SH7y1OK816OsmCCCG6s5EIYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

--------------AgA6RZk3jDyLLx7wNQzh0u6r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/22/2026 4:45 PM, Christian König wrote:
> On 9/22/26 10:39, Zhu, Lingshan wrote:
>> On 9/22/2026 4:04 PM, Christian König wrote:
>>
>>> On 9/22/26 09:55, Huang Rui wrote:
>>> ...
>>>>> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.
>>>>>
>>>> Assuming every kref_get() has a matching kref_put(), and the queue object
>>>> itself does not participate in a circular ownership chain, I don't
>>>> immediately see how taking a temporary queue reference would cause
>>>> correctness issues.
>>> The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.
>> why only IOCTL???? Since the kref has been embedded in the struct user queue, it should keep the queue alive during ANY OPERATIONS, Not only IOCTL.
>> Or it will race with the destruction callback in kref_put, and causing UAF problems.
>>
>> Do you see any kernel documents says that kref should only be used in ioctl contexts? 
>> We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.
> We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.
>
> I tried to explain the rational behind that design decision multiple times now but it obviously doesn't seem to be understood.
>
> So to stop wasting my time I'm stopping to reply to this any further.
>
> This patch set is rejected.

This design is wrong, see kernel documents core-api/kref.rst:

krefs allow you to add reference counters to your objects.  If you
have objects that are used in multiple places and passed around, and
you don't have refcounts, your code is almost certainly broken.  If
you want refcounts, krefs are the way to go.


>
> Regards,
> Christian.
>
>>> It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.
>>>
>>> This is just standard refcounting rules to keep objects alive during an IOCTL.
>> Where do you see such standard? It is just a atomic number, not a lock. 
>>>> Could you please point us to the historical issue or the corresponding
>>>> commits that led to removing this approach previously?
>>> See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.
>>>
>>> I don't remember if it was actually committed or if we only discussed that on the mailing list.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Thanks,
>>>> Ray
--------------AgA6RZk3jDyLLx7wNQzh0u6r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/22/2026 4:45 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b277046c-a13b-4d47-a7fe-55e18a720e20@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/22/26 10:39, Zhu, Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 9/22/2026 4:04 PM, Christian König wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On 9/22/26 09:55, Huang Rui wrote:
...
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.

</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Assuming every kref_get() has a matching kref_put(), and the queue object
itself does not participate in a circular ownership chain, I don't
immediately see how taking a temporary queue reference would cause
correctness issues.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
why only IOCTL???? Since the kref has been embedded in the struct user queue, it should keep the queue alive during ANY OPERATIONS, Not only IOCTL.
Or it will race with the destruction callback in kref_put, and causing UAF problems.

Do you see any kernel documents says that kref should only be used in ioctl contexts? 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.

I tried to explain the rational behind that design decision multiple times now but it obviously doesn't seem to be understood.

So to stop wasting my time I'm stopping to reply to this any further.

This patch set is rejected.</pre>
    </blockquote>
    <pre>This design is wrong, see kernel documents core-api/kref.rst:

krefs allow you to add reference counters to your objects.  If you
have objects that are used in multiple places and passed around, and
you don't have refcounts, your code is almost certainly broken.  If
you want refcounts, krefs are the way to go.


</pre>
    <blockquote type="cite" cite="mid:b277046c-a13b-4d47-a7fe-55e18a720e20@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.

This is just standard refcounting rules to keep objects alive during an IOCTL.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">Where do you see such standard? It is just a atomic number, not a lock.&nbsp;
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Could you please point us to the historical issue or the corresponding
commits that led to removing this approach previously?
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.

I don't remember if it was actually committed or if we only discussed that on the mailing list.

Regards,
Christian.

</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">Thanks,
Ray
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------AgA6RZk3jDyLLx7wNQzh0u6r--
