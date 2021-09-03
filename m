Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A86C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD81D60238
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD81D60238
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7A16E856;
	Fri,  3 Sep 2021 08:17:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C846E856
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 08:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXEXwJ+gmHTWsFvZuliyUvQj7B0s0RNR6d51BuEMmcdMcE8BR+n1h4kVce9t6w9a3/Hj369/77/0CgXD1AzNeR8crHoxnYVd8pgvRshVgb0oBXioKs/vhI7AnCX9U5U5mfLFYbNihHD9K7qu6+RM+U3cW7lbLkud+28uz6cv7mDb5S0s6uXmJjymM4jfPFOmRo1nMTrAmz46eGxttRzRgCRA+TrfsLea+LTEnqOQhvNHXOWOID1+CAaxtu6CKactANVijAj85dZvcJOEudwhG9EcKkwkYq7DbUxqOK4s2flDug+GbnZ0NP9uepyYf8J4qF45ZrQ4cHWyViskRJgQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3VnONh7Y/RX5hpBXEDapIdnhyT+HI5zD0/MO3Fi1k=;
 b=ls5rohaye2ALlNl+2Ybr4OS2gfMucYJdHo90y4gFb1cA9FWPzxEdWfirnY00B5Cm/P6p0N4MbALvXRVCzDQsGsMI5dXVAeOZ+/kZiYkCcewSnqpcr8k8WPbOLjw6c2+HuEtwciVKpbCXlyQD9JShxMQVSvCIokrDAtBs5nFogI2PpPb7MT84AQQmtp5laYTclp5gIFsgPO1/veZyOtml6Vv9bVK+nUfVrmDg7wRGvwNHWSq2RlOSDRagNr0YO+6tuvKb+SHmtyXjZgzRyxoCK5x2O7r8XaAysqi9webxRT3nLYb3WMlxJM0dyh41CV1D22U6/ryXAAFArqGY22p4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA3VnONh7Y/RX5hpBXEDapIdnhyT+HI5zD0/MO3Fi1k=;
 b=p67kGN8CiBAvofCe66RMJZ6QrIpvs4FJ6xf5nP1MXP32ZCAGcjefqdAkZZ7s93tPRycIf9cBUDFQlc6ZgluKWzncSuhLsh1+ivLf6zABEsuFl3qTwnxbQxRkPWhboLb63k80qZqCKyPqQRD2K7QSIhilPvzlkb/KRsF3R8TqUfg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 3 Sep
 2021 08:17:05 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 08:17:05 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use IS_ERR for debugfs APIs
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Sharma, Shashank" <shashank.sharma@amd.com>
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <5aeadf99-0864-1e45-63fa-a9f299d373f7@amd.com>
 <1fdd6081-b332-fdff-2190-5f8ead784b59@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5f6f85c8-5bb0-55d7-06e2-e14c230ed6ea@amd.com>
Date: Fri, 3 Sep 2021 10:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1fdd6081-b332-fdff-2190-5f8ead784b59@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::6) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 PR3P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 08:17:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08fe5a50-8533-414b-0adb-08d96eb3372f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4342289DD0B8C22F01780A9083CF9@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3oeMVjp9MlcEbLXHUlaHkm7702WVP9vDCvw1xmmUjw7e9jYuvcL3iMBSB+2gCLjhMMT+va+ZVR/sK38iog5fg+0Bb4XHgmcy9SQG1tdahO6XaKq32JKtB1IpUrudrDLDAbAbmy2aKBd2dw6tybj/JEuWvKIZ4qsblpZdIHu5l+6n1m8SsDuzB9sRsjZAGa4HBR9ATRkx269qqjt5Vq517fiq+wyweE7IOJeDjDgKa2YuYeliGdNo0WiCwVYuIzgN5/sojPVV0zNBbA5Rk6U0NzTqVwGnY6AFjQjW6yM5aQ0nkNgVDdCgfn5sksw9s9D9+CYkZKJg93L1BQPfSxjnJ4V1Vwk7MrxmYbf/Txzb9sO8nohFUYL9OcGYcSMKDRNe7JbmtmA4bdfobmC+oyXl3BliBdYrp9GL05aFfQDbkunor76Q3BlW8OLi85+Yi21L1Vnqj+cTXKmca7U2Ukf9ISvYwVJ8iWo0LsiOHnRElSKvKsnxNy7aRnf55X9Xa8YEltqRFazbpyzlvFSL5ZG4mhKTwuXA0oGRfJeIxhCwXUEDMzWO8ChDiU4pRyFeqzT57QkZLJw28YD4LunYaChA+kWgqz100JJtHe6f9VvW0gCxDk5abWnr/JGexBitObUh6F5KkZ2eroE7hZ8NzrwxcUK3oxKP9dwGafWGSKpFb8o5amYoFUpOVIuUX55OvpK0REVm1YrrEwdtfaBpvQ/m1j7jILZSMYwYO8XcGoxbjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(31686004)(2616005)(4326008)(6486002)(83380400001)(6666004)(66556008)(8676002)(2906002)(66946007)(16576012)(31696002)(86362001)(38100700002)(5660300002)(53546011)(186003)(66476007)(966005)(316002)(478600001)(956004)(8936002)(26005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZwR083dFIwTkZzWTJwN3ZxSW5PUEVDckdpejV0cG9IeXJJeDBaNEYzcllC?=
 =?utf-8?B?bFZpU2g0aVZFWUJ4K05sTlQ3QklNTXAwdnBqaWZHM244dDJFTUZCWTBDcldG?=
 =?utf-8?B?UUdIRmx2OVM1SURRZHdwS2c4SmRyWVpBZnJHazdlMHBES0dQZkppWVpnaHlL?=
 =?utf-8?B?ZkxicFliQUp0aExvS0JHM2JlejdlVnRaQ1JIeDd6Zmx0cHNwK1lVTkk3OEgw?=
 =?utf-8?B?L0tnUTRMOUE5bmFjNUNoNzkvcnllZHNFd1Q0TDJOcGxDeVZXMkRpWXZNWmhS?=
 =?utf-8?B?UnV1VC9KVVZYOXRJOURUN2VSdWJ2UEFSM1Y3cVlhN01CdVk3YTZOZlh6a0gw?=
 =?utf-8?B?aWdJWVhLeWErWDZDOUNkQ2t6b0lWcVMydTd2aEZtUWVwRmRIZTRFS2lyTGU2?=
 =?utf-8?B?YmdDTlgrRWp6S0tYVlZkenVvZmtCNG0zSllnSDZSRCsyakxMenBSRWV1ZUQ5?=
 =?utf-8?B?L2Z1ODc4clEvZ3NJdkt4c3laMXBOV2cxekdhK2hmRDBtazBYOXJueUNkRHFL?=
 =?utf-8?B?b3oyREMvcC9PUDJFemhqNFhaQUJocEpNa2FWS1ZTcVZwaVBaRkx2cllzM25q?=
 =?utf-8?B?TlRQMmJJWHVhRVdKQ2JpZytTL0YrVFRhNFJaVTdtS3M4VDRBVTQwZkJlMnkv?=
 =?utf-8?B?Rm1QQitmUVQzSWdqK3RjTkxpWnFRMElFc1pyUk1OQldZQ2JHeXlwRXZSRjhF?=
 =?utf-8?B?SURtRmt1dC9lVXhGbXZqY2IwVVhFYkxpcnhjVklZT1dUQStQcmQ3WlFubmZw?=
 =?utf-8?B?YSt4VHNGeGxLcldLMDlXdUR2czFuNVo1NVc2cXBRMmYzbWVmVE85YTlHRm1j?=
 =?utf-8?B?dVBXamNQOUNNVnFndXMyZHJhUVZyMmxJVis1MGxKaXZsbDVlRGVuZVRvckNJ?=
 =?utf-8?B?SHR5RUIxZmxtMFc1elhZc2NYWnlxNzZ1YTgyWE05cGQyR3ZCcDhxZnQrRG00?=
 =?utf-8?B?ci92YzhQS08rRkg0UG5YNlJrdy80Vy9pV3l4UTgvQXQ5NnVqaWVoazM3dnVv?=
 =?utf-8?B?VGFJNDQ0ck1jVUNQSzY5aFRGYUVhWGJ3TVpuS29JRmFmdjN4eVkwTjVGaUZa?=
 =?utf-8?B?ZFdNa0R2QTl6UW9oclRMVXF5SkMzSUxSU3paUHcxZzhKcWsySUMvNG9yOGNO?=
 =?utf-8?B?SGFWdHFWcUY1cDZlODdtNkpxOFFtZ0VPd0hpVVkyVm5DaEY2U3VPem5QVDdj?=
 =?utf-8?B?U1VKY3haRU5sZHRyQVVnUTgvZmt5ZkNTSDFyMjZubXVZT0taUVJtYlU2OEVV?=
 =?utf-8?B?cjdKYkIrQTFkVWJkcG5WWXpPMTNzRWhiaEI3RDg3b1VISXcxdWo3eDhybDI3?=
 =?utf-8?B?ekxWV0QyeVo5a1k2cFd4ZER0Mm1WQzArT3lwRGkvcGpzSndEZS9kb3JNclZW?=
 =?utf-8?B?dmhCRlcwSnpvaXpiVmcrQ1ZRRXAzNHNBMEh4Z2hNSkFNSU9ncW9HZWoydCtK?=
 =?utf-8?B?YWhpTENWYmVkV3lCSDFDSm4yM2RpNXEvQlRrekdVYnEwb1Y2bGZyUlYrOTB2?=
 =?utf-8?B?eUphVnlRWE1IbmpCZjRkWHJkaGhTR2RrVFpheUVJOXJ3YUxMSmI4UlA0Y0lE?=
 =?utf-8?B?WUVUV3h1V3hnd1llUjg3T1l5TEdZbGdQNkdCdXBFL0wwUTczVy9za0lPaHFQ?=
 =?utf-8?B?U2R2amZZNUhrRDJhdXlBaHJFWTM1dktzQ0orS3l0Q1FnbWFrTG1kQXBzZ0Jz?=
 =?utf-8?B?c01rS09VOGc4RXRPelpRWFRQc3plMk5kNWR2SnpYQk1YdG5RMHlLT2t4YWp1?=
 =?utf-8?Q?rYH0hQHt0/OjUMe/elWUeBGmJz6ZTqtQ7rEW+LD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fe5a50-8533-414b-0adb-08d96eb3372f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 08:17:05.5356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0O59kUQParI0kTOla+yh3kffaIm7nqorXgFMl1wQM+UfFEp6ohtuitFO/koyUBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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

Yeah, sounds logical to me as well. Feel free to stick my rb on that as 
well.

Christian.

Am 03.09.21 um 10:13 schrieb Das, Nirmoy:
> Hi Christian and Shashank,
>
>
> Please review the v2 : https://patchwork.freedesktop.org/patch/452175/
>
> In v2, I am returning "PTR_ERR(ent)" instead of -EIO which I think 
> makes more sense.
>
> Regards,
> Nirmoy
>
> On 9/3/2021 9:53 AM, Christian König wrote:
>> Am 02.09.21 um 13:44 schrieb Nirmoy Das:
>>> debugfs APIs returns encoded error so use
>>> IS_ERR for checking return value.
>>>
>>> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
>>>   2 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index d256215ab2c7..077f9baf74fe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>       struct dentry *ent;
>>>       int r, i;
>>>   -
>>> -
>>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>                     &fops_ib_preempt);
>>> -    if (!ent) {
>>> +    if (IS_ERR(ent)) {
>>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>>> file\n");
>>>           return -EIO;
>>>       }
>>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, 
>>> adev,
>>>                     &fops_sclk_set);
>>> -    if (!ent) {
>>> +    if (IS_ERR(ent)) {
>>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs 
>>> file\n");
>>>           return -EIO;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 7b634a1517f9..f40753e1a60d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct 
>>> amdgpu_device *adev,
>>>       ent = debugfs_create_file(name,
>>>                     S_IFREG | S_IRUGO, root,
>>>                     ring, &amdgpu_debugfs_ring_fops);
>>> -    if (!ent)
>>> +    if (IS_ERR(ent))
>>>           return -ENOMEM;
>>>         i_size_write(ent->d_inode, ring->ring_size + 12);
>>

