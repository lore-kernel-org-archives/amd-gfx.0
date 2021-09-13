Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6527CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 04:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1673060FE3
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 04:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1673060FE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3677C89DB2;
	Mon, 13 Sep 2021 04:00:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF9289DB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 04:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJiIiK+RfOGBBRQ1BqdYCeLHwHJSiIxg22tkRfyNRJOmvDGXGarpvkutgzuvjmLnZtcijMzlcZtAJ1+BByf4DDuul57btqLJqBLNAZkTSSjEfow27qRMk7gvuk3wTjTuhfqf76QUmwCfz+U/+umNpBugrwePotp4lLD8EtYYowa5r6IkiRW/gXgGp4ybTw1UnFxYgVJ8iz1nC3HT6EJvsHUiqmlp4MPD0+1yNWIL1CGynLQRTyPJN33xqWpMaF2xQ8rI8V/h2k9HrhP6TmQa4DnYdigDpuYgFN7eKN3ABo1sYEqIwYZxvjhcGvNJNQXRXUDqmmzcmpkRX1pbaOyCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=9EW/snLt52g0jcmj4oWcJslHHbbRzVeNTXzt4Dh7jPA=;
 b=auuZXN5Wf3lqe4+m2rlGm2WPsI8oGOmSCUqJ/P2ii9wqDo8hcLmo98xVQIenH0y+VdEYBI/aXh/KYFDEfoj7vd+oQgP30/2wWuYm48W+Ukam5wnb3dYO/n7UlOWznxbdrkOox2aY7zxkECn2xXTkpdBat/eU6DmsTRMe6YFFBpr4OpvxjTpeqYI93H3Dpdo7X0tTCXUIvg0aA5tEH7DAemB/X/oFozFVNUzsc3dPYeYoAg1/pN+UJ+BfDSTgBO4DBnqlGTmFE9ql035jV+57e9PPChZkpaD+8Ad8mCZqC8/DD2/LcAE2dXz+UlpDMRXR4KnWT4yFC5OadrgGTQy0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EW/snLt52g0jcmj4oWcJslHHbbRzVeNTXzt4Dh7jPA=;
 b=tlFro1qN4jg3ftDeZPs6NPVTmjLST9r6FtiQeoHQ/nsE/ou++30G/KUkJzk+fGCWpcPsCExL4Eu5IYoCwlqP1aKfpXupkAe0R4TQJdv79Ff6Ho+bEQI+LqY0AoNzHJ9MBFAQWaMz93tURpM6VZ8xp6yLLxlz3faM1aOX8tzU6xs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 04:00:56 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%8]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:00:56 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Fix a race of IB test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
References: <20210912234817.13051-1-xinhui.pan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <886e89f7-3ba0-fb5c-4a13-d802e0c5b5dc@amd.com>
Date: Mon, 13 Sep 2021 09:30:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210912234817.13051-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::28) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 BM1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 04:00:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a903d038-695f-4e71-1060-08d9766b169b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52510DC7D096E0409A07480497D99@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QHD7OTFAhbaqfJaarNU0ezwqGkWbVSLD5yEztY3u1cJ0+JLL8XHnn4Q3vQyLi/tUPabUALVsslciqYeVysp11wA8cwUsowDccQt5VJuUVG1EDkZ1c4U/OHLb5WqLuVkcLqppYsyXx+BPXJB47odaCimyH6lGxeywLYtDj8T0vfsPZOEy505dwWwNv/QWCiuPPLz1eY1HhtBNXTuodlfAS7lmWw1wQkQGV4lWcX/kkVyhlVznmN40+l6IB/xJ8FiM1OUAlt48rYXIIwqxxLjSy0ehtrgfZ21ukwUiLkOs6F/CujyZ8I15aQ5wv3K+JreiewJ5tm94zGAe6AxEN1CQEIYf7jRdXUK9jVkFTKs0gTcsHWoTYGJUXe5fukYpX8F3ZYrXlhW3WJg9WOc1G96mIv9sW4Tgl4aL3nyXkq/mRSSenbNDTgU4sYzJVBHhZ8Vdr6C0prien72LCJ4JccRsPe0TdOF5UEPmQfbEV0fYvy++sOyD2FNo0z2TvST6sGAtr8dsXg9M3baRPL7aDDb+Eh+XLDPT0G+tbwiCWmgx+rCdepqsOlgTMgWq+xXU5Jj0mIB7A13ABULYzstyq5TzfAxD7sUo1XrBMngVbxdPctMH+0w/PfvGx7opnB3AORAzqqn13chkyBScCcbh0kmTLUEzY8frQtAyrqSbEvN97rR403oTlh64r3T13ggBwsDoNKuADVCh8oJpbFACmdKTTuruLzV1KXNBB56/YI9ZK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(186003)(36756003)(6666004)(956004)(8936002)(83380400001)(31696002)(8676002)(4326008)(66556008)(478600001)(66946007)(2616005)(53546011)(6486002)(86362001)(5660300002)(66476007)(26005)(38100700002)(2906002)(16576012)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhhbSsxZjZ6cWVOMXBscTJSNnhLMXBtbHFrYnJuMzJNcDlpNjFUOHVlL1I4?=
 =?utf-8?B?akNBejFjQ1Ura1BKY2tlZXVJQWhncnM1QUl3Vm4zSDBjS0xwS3ZMZUlWY2hr?=
 =?utf-8?B?TXlybnVSZ010OHRjdGhTVWtSbS9ZUm53UXFBVjhpRzR4RHRDamZLNjU1TzBV?=
 =?utf-8?B?c3BvQkthc1Z3aEViYzk4eHQxbUFVM2lNWmxLQSthK2dLNnVwTkRSUUlDVDdJ?=
 =?utf-8?B?eVB4bnBJeGxydUdYQ3ZKMyszam5CdGx1Rm9SdDNrUkNST2d2SVoxcStpcUZ6?=
 =?utf-8?B?VjNacW9wU3ppbDhlaXBDM0NXdk8xVUNBUTdsM1pITERzZ2k0bjlIQTlMb05k?=
 =?utf-8?B?bzZQcnVCdWN6MlgyYVNybU9BNS9LQUhTT3FIcnJSanJZZzByQUJXSHoreWZm?=
 =?utf-8?B?ZjNyTGJKdXpqdmFLZ2ZDcm1Tc3JLbVdWeG1kS2dVU1FMWXJzSGtYLzUzWEFT?=
 =?utf-8?B?UUhvNFBIZDEwTVl1WW1sWDBEYXJyNlF1WXVOd1hEQzFZYnhMUU5YZVJXcGFT?=
 =?utf-8?B?QVo4Z2ZFbEMvWXg4bitYaHEveURWMVd2LzBiNStIVytGenRoMitURlF0emlM?=
 =?utf-8?B?NjZnLzZFN2RZZHNEc1lOS1RyU2gwN01ub3FzbndRMk9oY2Ftd2srbXNyaFg2?=
 =?utf-8?B?dzJIOXMxa1c4dU1nNXFkQzYyRzQ1V2tGem1uZnJoS1h4dTl2b0o3a0YwNFR2?=
 =?utf-8?B?S2lBRWlYYWJqRHJqWmwrTlVRaUNtNktKZUY2c0piR3hQV2NlZEl4ZmlsQjNX?=
 =?utf-8?B?MkdGU09reWVhRFlORWcrQjErNkpnekxEcWZoemk5RFd0T3BrYU5YTmlycWNR?=
 =?utf-8?B?ejN1TGRRV2hkTFlpMElZeFhwekVMK3ExdWkvVjRRbDVxRERyTlBGYkV5ckVs?=
 =?utf-8?B?bDVRMEk5UUREbnhsVmY3d0pTREhHbEZQRVA0S00wUnNkQzBGREtoTWtJQmww?=
 =?utf-8?B?SlRyUmpBOXFhUWhPT2YyL2RBNXpBUHVHY29NdWdiUTU3Yjd2RDhYaDBDU2dY?=
 =?utf-8?B?NjlKUXZyT00wbWFPQ1lmSEM0MS8yWkN3aTY3MVloSkNDNnlMenhsdmp2Vk5i?=
 =?utf-8?B?YUVhM01JMlZLY2ROZmozK1ZYaTUwNjhsd1A3Y1p0NXUvNU1zZytLcHhTZEtw?=
 =?utf-8?B?SGtlSzFHYVZBd2lmRDRPWktkS1ZoL1FlTzJKcWg5VGYxcDArQTNGT3ZaLzRq?=
 =?utf-8?B?UVdob2RRNDUwTHdJSjNJc3lRMG5McTBEMDI3d2xMbUZlbkxXdmx3ZkpTemFu?=
 =?utf-8?B?YkZJeEJYVVJQRUZjMURDMm15eG13U21FVi9GWVRSam91RXQyZFVsNDZUQ0s2?=
 =?utf-8?B?aVRtejhJem5RTStvMW05OUhkUzFmQjJsaHFJbnJ4Y1RtZTllNmQzQktMc0Nu?=
 =?utf-8?B?QnNTSG9WYzVQTUFnUEJ3bXpGdDVtZlB5QlNzbG9PZ2pob1pHVndBekdEMDBB?=
 =?utf-8?B?eTBUYVg5VHo3alZlZHlqaTJCRnM0cHg4dDZxbGI1ZWR6bkRYTUVWa2gvU1di?=
 =?utf-8?B?WTV4U2VKcW1rc2VuamFCQTdlbklWb1FXR01HUk52cy9UWWpaaGZDTk5Qb3Bu?=
 =?utf-8?B?dmF4R2VNV0hGRi9GcGxJRzM4dlozWTFjQW5aS0dnOTUxOS92K3M0TkZQUm9q?=
 =?utf-8?B?MVdSMEIzWFpRaytlaFAvUHM1K3BpWFZqeHdnVkMwK0J3Rmxnd1I5UGlYamJM?=
 =?utf-8?B?T0dWY2ZwaW5CYldTandaYmRZc25jTEIwaUgyMHFLd3M2VGR1WDNOYmlxWjZ0?=
 =?utf-8?Q?Om40QtNvuurhskrrb6HsueTyZpinm8vrtUfYEMO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a903d038-695f-4e71-1060-08d9766b169b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 04:00:56.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hUcRTK6WoM5/NIMLEvGxCcvDbq8/7sts4vQII/DDR2L2SAuAPWD00W+jFc7qErX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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



On 9/13/2021 5:18 AM, xinhui pan wrote:
> Direct IB submission should be exclusive. So use write lock.
> 
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 19323b4cce7b..be5d12ed3db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1358,7 +1358,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   	}
>   
>   	/* Avoid accidently unparking the sched thread during GPU reset */
> -	r = down_read_killable(&adev->reset_sem);
> +	r = down_write_killable(&adev->reset_sem);

There are many ioctls and debugfs calls which takes this lock and as you 
know the purpose is to avoid them while there is a reset. The purpose is 
*not to* fix any concurrency issues those calls themselves have 
otherwise and fixing those concurrency issues this way is just lazy and 
not acceptable.

This will take away any fairness given to the writer in this rw lock and 
that is supposed to be the reset thread.

Thanks,
Lijo

>   	if (r)
>   		return r;
>   
> @@ -1387,7 +1387,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   		kthread_unpark(ring->sched.thread);
>   	}
>   
> -	up_read(&adev->reset_sem);
> +	up_write(&adev->reset_sem);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> 
