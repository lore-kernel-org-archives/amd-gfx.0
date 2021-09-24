Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B218C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5A661100
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D5A661100
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F4C6EDE6;
	Fri, 24 Sep 2021 05:54:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4866EDE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDMmB1wWapyG7vBf0Lq31mDjbOwa9T7mUQyMuXMDtnP6xcyvTx86eG2XgNx9IDkQ6cCKLhPzmd+xXETy3VP5Uw3979rI4alG/gXiQcdKgn4WrpoDf+h4mQ4CsBRB9H/gRf7f+97eAy4pCmZctY2L99zl1S6QTMha0STFyL4CwQL7krXZ38IiRIvNoYMK/yGxYbkYvxDTSRh6uONTJt+K7oCRXPxH3f+2WlMu6Niyg/aAa5u9pIs2YanP7vh2KV/YjUzDWCIbwmub+sq5WLbz7AB+2rrrZ8M4nDEprr9ayJy1lqTB/nkDXpOS2mAWoxATwhD//6ZZr7z8WspKaD8WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6iVf3EDul69rIYQwL3NLYDhri8avf7ZM2ZrlAtxma5w=;
 b=GBOhFfOZL1/DToXqnKJ0Yv6H2ZLC3L6QPqcw2gO5zHMQbQgYfvXbWH3+wJbTy6Scy/vkMUUyGvyOIy8SOhtyJ3sg/iFFb6J+pDn2qykmOGSuyAm0AdHl1A/a78Dagre46sNYEA4pkPLjLhpsDVhEbYjzgB6uS2QJJbPrxqk3BB9nLJi+WTg3qCy9706oetIHN6CYD6wUAOsflaNpW4P8g/q7xqeonqZNJKYHcfznuQ2JvT+J91jf6eoxj54Ty8oOAfatzXAWmfjYTaJtp29NTZIiK3qt8i72pmrU1B2aw5pa1MFRj5QLXlZIufCxOLzMbOxqCobLdfVHowIUpo1Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iVf3EDul69rIYQwL3NLYDhri8avf7ZM2ZrlAtxma5w=;
 b=HYGSIwQTOh1D5ScIKfHUn+hcWS5iphX8zPEIUah0/uUDVbUMVjWm7ZpbnZG/PbZ9tbBGnLmXf9eWWMuT2VsQqiPgAAdrNMPQUzmVG622EF8nYtLKsgyrnAMvfX3lTz8llpiSO8nPc29VO+zHtW1L/hy75chkNxiLK74ykbYR3LI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 05:54:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:54:13 +0000
Subject: Re: [PATCH] drm/kfd: fix ttm_bo_release warning
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
 <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1ae03ed5-95ee-7e8a-b850-d0958aa974e6@amd.com>
Date: Fri, 24 Sep 2021 07:54:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:5264:89d9:5fe9:27b8]
 (2a02:908:1252:fb60:5264:89d9:5fe9:27b8) by
 FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.7 via Frontend Transport; Fri, 24 Sep 2021 05:54:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a11f9f-4d52-4908-b081-08d97f1fbc56
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302BE27F6E65B8705689C5583A49@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nz9AQLbi3zy96yi5X6uk9DeBmug5xOChAudTMIVKvrdKW8Qj0h1zalA+yN1VzDSPZwIPmUHwdApUCHI+WFfQedc086P87X+GIs1M4gnWNggCZBfzYpM6vMtyMgax8QYlgTgWsioYASMLTDM89rItMDZkmeVxLcgXEIWcJjDfXQCwQFXsgnQyhSEWXTDhZrXnf7sAyi0lPjU0yn7DFnCrZATBWUtEaxhmGaEQz/ZuLfDtbdbs2PpIrL9z/uvf1gmgWHnzBIqnfECEgO6rISWSTxZmhqYK1nALtJIkBhA59A+BPitnLDYKKqF+V9X15/DgWFObkicPImxoHQ5iF+EADuFChbrBrw0QEJSjRjhO7kwkFoi6fRkIcw7hT2Vuaw/31Cf1JuXc7XzHQicjKqxQ4W0vl0/bSDJvVEtmCaxFiEqh6xGxxBW2cQ8+gpTqwlaesVtA/8EtX4FFMFXSA1RYgo7PuuyRKdcrevHRmq9M3ztVUHaL8/wMs9BfM8n6KdJa9xiuU7FVwCUVX4MXpp0KK62QJ5n/TUDzX6tuqTesJK5rKmTPJdg+QiIX7kZDAE0ZpqzfjpmbAOxdyqAOm7M/EFU1zL3NH/3X9iNn2xGePZKVH10JgikVuI0JG1pdk8OzQI8gDkDt9SZER1Np2X+Fg78SW/VYDH1N8QG8k6qHoQ+0IK6KpvzH1jWbniB4/ttIkBfBUy7oWbJYdox4vGjU1mpClwxSuVXbVdDiwSL1+QiBv7BHERPe/EE8MBbN/zV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(5660300002)(110136005)(4326008)(66476007)(31686004)(6666004)(2906002)(8936002)(66556008)(8676002)(6486002)(316002)(66946007)(38100700002)(86362001)(186003)(36756003)(2616005)(508600001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlCS0pDRDRjTThzQ0x5eHNvR3paeFFJWjVxWVlyRC9NZTN2cGIrYk91NE8x?=
 =?utf-8?B?S3Y4a0diR2dmNk4vdzZHQjNoRDlXcjBWOFp0S1hiYzgrMi9xUy9qVThSc3Z4?=
 =?utf-8?B?Vm44Q2s5cHlia0RHR0tLWjBnTDBua1BNdHdDNFQ2RXcxQVNlQUdHb1FQdm9p?=
 =?utf-8?B?YkJtNVVscWxoeXpiOUVUajBFQmNqamo0cHIrdUQrOHpzaGN4YVA0RU03MDIr?=
 =?utf-8?B?b2grd1dkNlVyMVIwM3ltREduck8zT0hXb0t4RWpyREsrRG04TXowak9CMjZN?=
 =?utf-8?B?NkRKN1hzS1RYUWlZM0JvalhqdzZINDV4SytCbnF4NTYyR1JmcGhRTk9acFlQ?=
 =?utf-8?B?bVhPZXViVVRCK1RZU2FpWWxIcm1yeWh5RGwwQWMxNjRwM09nTXExdWNxVXAr?=
 =?utf-8?B?bDQza0VBSlVKVHFIRi9STzd6c2pyTlUrZVJKa09Od1ZwaWFvMVNmcjlVUWFy?=
 =?utf-8?B?ZW5nWkRRK0w2M0tZY1lySGorcWJ1aTduMlp6NDlJbGxvZG5HTDhxaUhQK1hO?=
 =?utf-8?B?TEVKK1B2U3lBWWY3aGhOc1EvZ09NOWVMSTNYZjRkbTFlUHVVN3hQdHV4T3dV?=
 =?utf-8?B?U0txelNPMDNsQnBacXpqODJkNzJKQ2tSN0tqU3ZKNXY0UEJIM0Z4RUpvTWlQ?=
 =?utf-8?B?T050bjZsdng5OWFNUjJ6NzNHc0FtNGFhMUlFc3YxRUhmYnJ5ZEVQbitVKzdt?=
 =?utf-8?B?ZHkwa0l0MjNRY2JxTDB1TGJicVVyeXN6QWhVakhNWHpvNms2aEtQdUkxOFNC?=
 =?utf-8?B?SWhYbU1MN1djaW1RdXRMMWpLT05tUVVsQkl4MzJVSVBUV2t6SzVCeGJHeGdX?=
 =?utf-8?B?TlduanFMWXYxeW5aQ0RiMksrenRtR2FnaTNVN2dkRlJnRzdNQTlWYVlYeDVL?=
 =?utf-8?B?TGEyTWU2YVNFcnlYNlc2TUFhYjI3WW9PMXhYZ2dqRSt2RVBseTBFd09FaGx4?=
 =?utf-8?B?WWNaZTNFYUFZR3BRVjRtSThhK2lHQUYwcHkyekd4MFh2L3d6K1MzLyttcU1q?=
 =?utf-8?B?VjZITnBrd2w0Z0Zxelg4V3JQS1FwWXE5U3pRQkRaWElGUTI3dXRPVm5pZ21u?=
 =?utf-8?B?bStNb1dwZERtcDdzZjZ2eXE2RXZwZXk3NGtKdkZmMnBtZnJUNTBMa1hTdnRu?=
 =?utf-8?B?NFhWeEh1NXN2aUh0RjJWcWFXcXpoeTZnS3dXVW9jYlhRMUxwVnB5VmYyVTR6?=
 =?utf-8?B?ZzFwQ0ZxcUsxRkxzdXl5WURMc29qTzRnZ2tjd1NzQ3ZsN3c5UjFyTnlOYmEv?=
 =?utf-8?B?SHYzeWlWNU9mZHJ6ZE13KythQ01xZ0NPdmx5bXpZWEl2enRSdHVoU2V2Tm1J?=
 =?utf-8?B?Z2tWQncvYTgxbnFxK3h3aUhlS3lnT0ZDL05RSXlKK0lGUk5TUCtQWnJXM0cy?=
 =?utf-8?B?Z1pQZUNQNURoajduUi9UclNSOVBjN2MwWHZtT1MyUGh5eWlyY1FvZEZOVHUv?=
 =?utf-8?B?ZjY5VElXMzlyMmUvSzFHbzRSZjlqOXpzdHdiL2xyTkxZQ1FyRVZKa0p2dk0y?=
 =?utf-8?B?Y0RBNjJnMnl6QUJHdjVLdHNMT25QbElQM1lUcVJ5ODVVS0J3emJ2cUFVRnhG?=
 =?utf-8?B?aklnR3F4cmVlZVMzNTh2RzI5L2ZhWlc0T3laZzRnZ1orOTJNQ1dteWZEZ2Jk?=
 =?utf-8?B?WUt2aGNqOGt0SEFxQjUxeUNQNGhQVlNLN0R3RVVrNmlXUUFtUzFMeDBFZFZB?=
 =?utf-8?B?SmlvekdhVE1WMzJ5Nmx0TFdKTDUreGRESFRtVmU2RFVCYnV5ZUphcmJORzJD?=
 =?utf-8?B?Z05tNGVkdkpIdExCejVWL3dIaURZdXYxZFltTm9qNHl5WFFPZzB4NmhqN1Zi?=
 =?utf-8?B?RFRLejQzL2lnZ0dESzBJdW1aZ3JXa1JjK0VOZ2xpT2xSSkdPLzMxcHVmemJv?=
 =?utf-8?Q?KM6Jybi41gkQe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a11f9f-4d52-4908-b081-08d97f1fbc56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:54:13.2855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G87IdSn0eppgEnrjsAUDczW0ixUpH5HuAf3beanPzR/2wrmJdP3N42JMtoJFxfdC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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


Am 24.09.21 um 07:50 schrieb Yu, Lang:
> [AMD Official Use Only]
>> [SNIP]
>>>>> Hi Christian,
>>>>>
>>>>> Thanks for your explanation and advice. I got your point.
>>>>> Actually, these BOs are allocated and pinned during a kfd process lifecycle.
>>>>> I will try to add a flag into struct kgd_mem to indicate which BO is
>>>>> pined and should be unpinned. Which will make
>>>>> amdgpu_bo_pin/amdgpu_bo_unpin calls balanced. Thanks!
>>>> That isn't to much better. The real solution would be to unpin them
>>>> when the kfd process is destroyed.
>>> Yes, will unpin them when the kfd process is destroyed.
>>> But we should indicate which BO is pinned and should be unpinned. Right?
>> Well not with a flag or something like that.
>>
>> The knowledge which BO is pinned and needs to be unpinned should come from
>> the control logic and not be papered over by some general handling.
>> That's the background why we have removed the general handling for this from
>> TTM in the first place.
>>
>> In other words when you need to pin a BO because it is kmapped it should be
>> unpinned when it is kunmapped and if you don't kunmap at all then there is
>> something wrong with the code structure from a higher level point of view.
> Yes, this function "amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel" did a kmap,
> but without a kunmap when the kfd process is destroyed. The flag actually indicates kmap/kunmap.

Well that's the wrong approach then. I mean you need to have the BO 
reference and the mapped pointer somewhere, don't you?

How do you clean those up?

Regards,
Christian.
