Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7161BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC7161075
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AC7161075
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD006E4A1;
	Wed,  6 Oct 2021 13:33:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF916E4A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 13:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc/H3q7vb2A2pRX1zfqBdvOwM225y/oncV6g1PQ31Px7MF3gt1V+CZbomkXcPcQzci2Jta1eCD/wvc7mVxyPTde5XQgDmFSvFwuFsfVHYzX4N+6kKarZkcKDNgdRA1ZTfHC+L+qwx5f42hk5NuW2xTd+v6RjD7RUvDATbcCGyBhj9gWOKi5zxnfSrJazBXj8d3PhgJmXcGLUmcGEahI3U5qLwCV9rLS6agVqlMe79/nkBDN8Roegp7Z8hf7dtopA36uhUG3vTPMfOK6jMpLxtjmW3bfeGuQmcw1NowZ/tcUu1+X2LHIN9M8C9k45HB0U5RyTCnqKtVVp8foW1j7/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySNEhRlD887Qex4G0sTz/R16ySL3dPVr0xriwjGdVLU=;
 b=WIQjI2LZ/FOUQbumJSUSUw8f/2+0ExwMJE1Gtk4LhHsV1FFfyMnSa/IvOLUpPvUeiWVI9O6O93KUWqcVW7a/eQIwLOlpXEo3eulNhGfLEJT9iCBuYgJDyMRRxPNHrVirmohHMrX00p1I1zkVTrFMrMaXcvWZbgardkTpj5ICd4OMAm6UpOThVRLgQfL5Q16N7OJA5kC0gErSeG4I72A2SH9Qb+qHPWBxsV61BvpGcSIvcxdAxC0045xxLB4eeZNcotC3J9MV2TOufzZZLeTviTTUAYzStSjni4vyDJXo9rB6NIvWnOIYKnpyBy8ZcFZDcPdijytF1NAp0KdSSX9fBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySNEhRlD887Qex4G0sTz/R16ySL3dPVr0xriwjGdVLU=;
 b=TGmDPcNEB21y/PEqHIYOgyxgNPT2Qof/qsZ3iSewziX4ttFz9bEQYlrE1pr9nGqHh2veRIQ1doUGAuPY4DGotRKEMX4MBcoIYQc8wiSnRA61CEZmVjN55c3ZibQY3RhEXJ4pLy80+byzNbt2BdyUicMdkRyvsDraPFTTzbcxgpE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 13:33:28 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 13:33:28 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: return early if debugfs is not initialized
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211006095116.6221-1-nirmoy.das@amd.com>
 <b4fd745e-dbfd-70c2-5d80-6b00dc268601@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <2b9a8542-9740-cc57-89ff-50df6bcf00dc@amd.com>
Date: Wed, 6 Oct 2021 15:33:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b4fd745e-dbfd-70c2-5d80-6b00dc268601@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0205.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::30) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f21:1d00:e941:1883:217e:383f]
 (2003:c5:8f21:1d00:e941:1883:217e:383f) by
 AS8PR04CA0205.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 13:33:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9433c5ff-9ddc-4caf-5c86-08d988cde18f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5342630AF50FAEE922C7B27C8BB09@DM4PR12MB5342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khExWzd5MwbpgUySn2teAwRx2oLXMyul6BaWUiH8uz3Cbfgqx4fKGHexfoIPG+ZaHmVZi/JV3to2969gxHNQo1i8hDlrp7IpLTvrrj9ldLLMACkwXVvVB5s4xBw7CLm0SYtspmlMYJApYD+LUuhiXHpr5IeUCj7aKOU+zH021xQZWfDgSfKhkNgJ6Pbcwj+6gJn3RFpkiZ7N99CkP9CviB5qg1Oa8EzBoZfUD7QOC9m3UZMqWy72nOLFQI3KfI9KrivJPxGz3bQFXJmeLFEYBPE2M1LtMzZjgTJZE0IrRpfUGdeZDAErwNpPfkQs+lhls4eR2UWWYCmbUi5P/RsyNepBwzDrlqcM6AH6WaHOpsD4S/8gYvdZWc+LW2PN2nkUtS8Wh0xtjaUOzHl3xQYpHalhQ/G2kc2iNOygGWwaOeOsaNUFEonx6ZW3CxkzgEz79aO96cqYg01AiFm3sEoavQjSHSq87k+jwHIYu7/yX1r6YslezzNTDU3rSNFkfM0FLhQNNgRJotSCET7Ux5CH88x7oei37Np8GxUYgTWNaBasmvMcuNW+vchDancWmKcB7W6QFAu5Pe0i4/5QgNiaoEbYWKvw2DRYSfSxEufDxNDCNVdzS3lU7f8O6P9sNP3hc/kGQBhZHPP9y3/DEid+zHIKC2FgyPoe/nx74Z2HBj+8y1Ypp3X/qAR9z0rC1W8GRpZIqqBiF0WLeJFYrj/CeQe6DaXFmFlj6J8SXVqnFI6g5SwIEwgPR44fhsU6LjhgBHT9F0MEEo0MAhYJHLE4DN+lptKuIwC5ZTIe4ATM0ESRaNZKh4y501nGy11k1whm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(316002)(4326008)(38100700002)(508600001)(5660300002)(8936002)(966005)(186003)(86362001)(8676002)(36756003)(6666004)(66476007)(52116002)(2616005)(53546011)(31686004)(66556008)(66946007)(2906002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNoeDNrQkw1RFhJTWFxUHpsS1BZdVp5NUp2NnN1d3N1YktoVmR4NCtvRi9r?=
 =?utf-8?B?VWMxY2Q0cW51UWljS2JhWmNGTDgydW9zTU9YUERTVXFKaEpoZmdBNmpkMGZO?=
 =?utf-8?B?QWZlWU50SWttcTlXSjhScEsrUlV2U1BaZ0dhc29rbzYzeTBtTkdJNWZ2blZE?=
 =?utf-8?B?VHl4bVFCTURIY2VyWEZxNU1wWUVYeXp3cHdDZVhzUDhoWFptbmtNbDhGOGRF?=
 =?utf-8?B?M1NuS1F3eWFDQUZDbU85YW9XZ1RVMUpUQ3FqQWVYNFd1Q0VSZmx1ZG5lbWRI?=
 =?utf-8?B?RlZmY2lTRjNvRVZjcTE0RDFCcXBGKys1ZURKSEhQUXJSWFRjekVjU0dpSkJD?=
 =?utf-8?B?TkdBZlBNczY5US9VcXk2RXFQNllsNHJ5KzI1UlU0N0drV1QwNGJrSlFzQkJF?=
 =?utf-8?B?M2NHM2ducityT1N4MkR5blNXL2JGakNHVjhHcFZ0L1dCNUlva2dZb21PNnRp?=
 =?utf-8?B?aUlwbUtjTURuUGVoSFFDNnFxbC9zczF5NE8xdkR2cDg0TnVld1pMVVlvdlYr?=
 =?utf-8?B?V3VOUjI4UTUzYXB3bFNGdTNqYXI5VDYwdkRQa1hBTEhCWmtuSGc5bDhlMHBv?=
 =?utf-8?B?eVFObldYRlFEUkc0M251czhlY2dwM3FFYkxxWnJyd3MxSWZFalppY0tmQ0lW?=
 =?utf-8?B?ZEpXSloyTXRuUlh4Q2twSVhSUzcyT3kwU2tKZG9GK0RRMEpwNWVZK0JyMDFH?=
 =?utf-8?B?YzUzY3prUnNIU3JUYTBzVi9DYkNVMjdGTm90eWdJbjdtMFltVG9seDdEZGd6?=
 =?utf-8?B?WFAwVzI4QmttQ0Q2NnpVR1IwaVB0VE41Rk8vaEU5WXVNL1ZCdDNzWmtqSzI5?=
 =?utf-8?B?Tjgvdld3TjFobXhPb1JyREdPNU1ZWEZ5YW1qa1RDSU5DK2dHZnAyTk5aMXhU?=
 =?utf-8?B?eWgyRUtlRnJBVGxLYjdPTTU0RlpvZG4weC9xK0VVM2ozazBxNXRKZ1hIU2N5?=
 =?utf-8?B?OWJ6dWZrNUQyQU5MR2pIWkRDTFgzRi93SGZPdWRWUzNScUMwYitPRUpOZEN2?=
 =?utf-8?B?VU1WMCtzL0JBbXBjYzhDdjBZc3FNMkpxNXhoWEkvWlkzVXFybWZjeUZkSFNH?=
 =?utf-8?B?cnpQSFhxdlkvbWh2VVh3S3FCeVB2eDRUb2x4NGdYMlRIQXF5blRxQ1YrNFl6?=
 =?utf-8?B?c2IxaHBXZHVjTUZTNm1jV3FObEJjVHFFblFRaUlZWUg4WWl2SFNiclRhcEhF?=
 =?utf-8?B?dVRQbEE4ZjhNd1Z3bE1WNkkyRk1wRWxqcC90TUsvYmpTK2JvNUtwcTU0ak5Y?=
 =?utf-8?B?bmZHZDdIWVJ6ZzhVZnNwazRaV0pDd2M2ZW9VWjlxN0preGIwZTlYRWVDbmtH?=
 =?utf-8?B?cXE2YVJrczdNY1VjbWpnY2RLQkl3RUxzOURpMStwZVBURkEvMnRiai95ZGth?=
 =?utf-8?B?MjdEejRpYnFjVUsvakR3ckRKNkdTQVpsalovUUNRUmhzeCsrSklpVUVGVVZK?=
 =?utf-8?B?TUd6MWpKZWRZRGc5TDl3YkN4VnBHVmUxaFNzbWR5UGFsOWdJVFgxWGNrWXhn?=
 =?utf-8?B?aHd6d0JrZ3dacTJmSHhHODhPdVlRa1FWRTQ0TWVjWHhxak40bWRmTkNFUWxE?=
 =?utf-8?B?N285Ymx4aitKZk9VMDJNUnhEeUpJSGh6aStmaHlEdURhRUVhQS9KQjJmd1Z0?=
 =?utf-8?B?Qm5YbE9RaGNIRTVBR2x3Sm1vOFRxa09tYjJ5ZUdJMEtGVWRHc1MyNTROTDlJ?=
 =?utf-8?B?S3hoOWdkZ21qVktlbGRRZStVZENSTVFaZG5IY09YOGZFZjQ5c3BKaDR0ZUR4?=
 =?utf-8?B?NGYrYUFnVjY2bkxzWHhHWEhRY2NTeUtJYWM5bzlEYkpycytqTy9PRVNNbE43?=
 =?utf-8?B?NXFxMit2bUI0RzNGQmRTLzladkQxaTZyTEFKWWl3dnVVMjJzbEhaTncvL3Jq?=
 =?utf-8?Q?WbUkWcO+hAyzW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9433c5ff-9ddc-4caf-5c86-08d988cde18f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 13:33:28.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yX95S9ujT+EylKs0RgiHqA83wU7X+d/M10kbVNu/z4RecdwuXylP3hwtBhm8fijUCavMVYRoVb0DRMRu/54cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
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


On 10/6/2021 1:55 PM, Lazar, Lijo wrote:
>
>
> On 10/6/2021 3:21 PM, Nirmoy Das wrote:
>> Check first if debugfs is initialized before creating
>> amdgpu debugfs files.
>>
>> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>
> Sorry about another miss. There is one other option added in the patch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a24c6f7bc923d5e2f3139855eb09b0d480d6b410 
>
>
> "
> config DEBUG_FS_DISALLOW_MOUNT
>     bool "Do not register debugfs as filesystem"
>     help
>       The API is open but filesystem is not loaded. Clients can still 
> do their work and read with debug tools that do not need debugfs 
> filesystem.
> "
>
> This doesn't work under this mode. Guess, we are not worried about this.


It does work with DEBUG_FS_DISALLOW_MOUNT. I tested it with that option.

>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


Thanks,

Nimroy

>
> Thanks,
> Lijo
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 6611b3c7c149..5497e2d31d1a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1617,6 +1617,9 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       struct dentry *ent;
>>       int r, i;
>>   +    if (!debugfs_initialized())
>> +        return 0;
>> +
>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>>
