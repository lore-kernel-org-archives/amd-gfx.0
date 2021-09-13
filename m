Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA30060F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 06:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA30060F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A59B6E0DB;
	Mon, 13 Sep 2021 06:19:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75DC6E0DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 06:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OruCd0ixFZG/f6h5S0EWime0NsfxjSJ86UPPa15YhkOizE03vuuex8YDWnQceJjm7Eo8NgX19gfin1YU50Ha9XLcwuPqb4Qx9y+wuG+WZOCnPI7yh6uiGS3OxN4/T6eunskgiySMHJaomlOHiCJgUrFcs3YfbU+alard7z+hcg2NP9Umm6a5joYFCge2CBrzEHLDLaq0rAEiPBKKGucaljc8ZB1XUhdmRCyq3QCZQ6Of9H7MDWy40enjRH7pw1VL0owKi2b0XjPpmVhtQKgt1trEsCKhUoeRMChUh4YxXBAWKwbZlUdb2wfSXas8rQJ8lkOA6LkAY7C4JD+HonS0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=V7lAB7MDqRxzjS3PYcVw4V0cFN2IPDfdqNiONAGqlIk=;
 b=jj+sCVtJY9YqyE75Wjp5WABcBH2FlzejZZ9g7ExJXtH0606yMP9NWD1cpzl0AgBuFQ27GF2dVV13sFr+9UspH8rm/0cvamCLJ3u2r9gEJOOzXZtZwL2mBfGUOz99SEdC6ULBFE/HX3EwCksxffgbMZBaOWKrIoZZDWSf6TNeWM+Owr2RYeMKSnrAmGo/CC+4/v0bM4ddU47iMiAmGTd/1fiWVwiLt8NYkgTfimNM62drDUdZsJVC70vJYwVDzgEJvqtTsn3gX7xUQQVDvhTP5LU6Tg6nH1uxblmEW4OhSyiQiFDNn3PHWfOb30Lf6Yy1Ku18TZ9ZpNN31oZKIYrpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7lAB7MDqRxzjS3PYcVw4V0cFN2IPDfdqNiONAGqlIk=;
 b=XY1PlFlgr6fWfgpqQYJ5CPPV4eL1XYv9JOLOuYaXhotkMkY5Tdo9lU6pXOZ8Xpzs+kwUTFyipWQ1J2qLXvORQ6B4Xigp7BT7C53AmZ1oZN+zUuu6HGfd9PahbIwMBChKUpsE3ofaM7uvo/GhpNur2put8Od1jIXIcNcqTNoovII=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3677.namprd12.prod.outlook.com (2603:10b6:208:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 06:19:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 06:19:29 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggYSByYWNl?=
 =?UTF-8?Q?_of_IB_test?=
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210911015513.3822-1-xinhui.pan@amd.com>
 <d983949c-6386-cb32-d361-c70efc206e2c@gmail.com>
 <DM4PR12MB5165351AA7C45CCDBD15AAC187D79@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91fd7ad8-b4f0-b30e-9f3e-eab229b7375e@amd.com>
Date: Mon, 13 Sep 2021 08:19:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM4PR12MB5165351AA7C45CCDBD15AAC187D79@DM4PR12MB5165.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM8P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 06:19:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef50ad1-113a-4915-675e-08d9767e719d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB367777A077EF497FE2D9AD8483D99@MN2PR12MB3677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxZ+fLrRfzLX0sVz58tcVZ2CE5rrt588NB5nvP7t0z0+lsB6RiYJhW21/BTTruUMSLk6OeS9JsCfiQDGNGPooQLezTOMKHMPlCdggvApZGor5DiRY8Mzb4Eh5fdDN7zr3evJdJd2ohnK2WDVKDZstnG9CRNxJUeirzVZhKPf3I/iG01wd6o2KBv48ZB3td7h6tD2xAAUvd7tuJp/qHEkZuRnasojMVstrz+xvULf6enEMxbGMk/QTcanuLAAwCIZsy9kC966+ef/bKD1pXP4/Tq/2MNuxHgGlKZEFl2lWZW42aT1ny3G5LBjRV7fmn/kGJoCRSbOBtHJz0DdvxXBe15HH9NI/6KxTKSAtBpy7xsqC9AdsX41BOlvoZvCR0o3f15ae0DUU08YhfA/lGl/sXHvdOccSLmw/Avpozk+t2Kn6rI0qIy51npCggsrn324iNLK2lyoRU6EO/cACAkzGVHiF7ZZXhSCU9Hh0DI7Wi62KZvtwCSEuoyGIRlbRtFp5ubH1qsYSsvOtsVWQKtWY/8Pv75gwnZmnorh0NhWiow1N5SJrcgv3J852q2X7pU7z+/6gntCHOrZ0SX3nRnddgJX4n5VlydhmXARDzcsEzeSaztFRwZ6QcN0EVFZha8bPl9KKDlR0l7Mg2foXqB4RTcnD310GLEJAdhdatTNKa2TEo2KIDt7kr29jwXdDSKIxkrR9Aew0nBi4YHced4ZDU2KtCP9gfrgE/XHRzp0iWRx2S62arOK3JVDNcEOh4J+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(4326008)(6486002)(86362001)(956004)(66946007)(66556008)(66476007)(31696002)(66574015)(36756003)(478600001)(31686004)(83380400001)(6666004)(186003)(5660300002)(38100700002)(26005)(8936002)(110136005)(16576012)(316002)(2906002)(2616005)(224303003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3huNlR2ZHI1Y3ZIbnR4SERJb1NWMkZUVnpLVkRscjJJWUI2Y1g5WmgvMmcr?=
 =?utf-8?B?aDFPVG9IMkFseThjYW03dHFhYTdSMDVhRUJ6UHgydG1JUk5nYVozOXZMUVY1?=
 =?utf-8?B?cTNkWHVab3pJNUw1WXVSdjVTbkdhNjJLRk1WWnlhNXpsZ1FwUVB5dGtZT3gz?=
 =?utf-8?B?WnJNbnFlZWM4UGdhVTQ4c0Raa0grRklTckM4bEhEV3FJazhPWHJpc2Y5SkM3?=
 =?utf-8?B?ckJRSitWZ29rL3pDR1dyRjM2aUpkbm11L2FUV0xKbHBhMk8yM1FubHQvcWo1?=
 =?utf-8?B?WkJrSnNWZ1IrSEVVMjRtamcvdXJYbE8zWCtLYVNhMlRkS0tvVld4S0tkL0tq?=
 =?utf-8?B?UEpLdUdCZnZLS2QvUjkwMHE2MjVHSWwwc2pLdy9PcXQrOGZtSDM2am1BS1Vt?=
 =?utf-8?B?SDNycHBXdHV1aGp2TEQ0NlhEV1F6K0xvMEIvOWRXTFBqWlAra0tzNTdvbWp2?=
 =?utf-8?B?ZGZ6SElhRVRKZk94TFlMWjE0c0VlZ0hWSDRrMFMzODRKZUw1bENNWmVjeEM0?=
 =?utf-8?B?NnJ0T1gyWTZOak9RNm1oKys3K25hMGJpTzRMd3RVcm1aVXJYM1ZyRXZ5NHpa?=
 =?utf-8?B?dzNUZExLanp0ZTdRSmNMR0JHb3lDTnlBM0ZGbWp0d1ZTOE5WZ1pueU4vODBG?=
 =?utf-8?B?aEJSWmwrWU4xL2tJdEl2aC84SHNvV2VFL2lOWHdRQjUrdTRTL1p6dEtNYWZx?=
 =?utf-8?B?Sm8vKzBkRXZMWFF4MVpwYmtwZFgrVXRMWXQ2SEdPT0s4UjZjZm5KNURqS3pX?=
 =?utf-8?B?dS9WTGNMWGlqUmMzUXFudURhQitXNXB5cG9COENqVDZNV2w4ek5RNDhoVDc5?=
 =?utf-8?B?K1Q4Wk03cHdrVnBVcW1XdnpEUEE1YWsyY2FwL3NmRDF3RTdUTklieEUrZndY?=
 =?utf-8?B?OE9NWG1NRXkvNWtyaUxDMCttc283aXltSnJBZkF5VVh1ZmhDY1BMNmxVSTBv?=
 =?utf-8?B?bmxDazVTVGJKL055TDd6Z2hiUHZzeFpmRHhBZ0UrR1V2YzlTT1JSc3UzYng1?=
 =?utf-8?B?VDg3VklyRjhIaGtXOEpzMEpZc1NnNlV5SHQ5dGtqNkZxYXMwSkJoRjRCb0xF?=
 =?utf-8?B?YnBvT0FZMDVoWWQvSFpCN0c5eW9nQnA5bXl0Snd4cEQ5YWZYbUw3aDV3cTV6?=
 =?utf-8?B?dmUzOHd4TEFFaDlycjR6anpFMno3K3dDdnd5K3B2QkRpMzd3bkJHOTBnRlF4?=
 =?utf-8?B?WCtDYjBaS1JmaHNXYktqc1F3QmkreHExSDJGTUpNdGhubllwUENPMWt5OTNp?=
 =?utf-8?B?K0oyN1p2ZkZEVUMxalFEcUdhcVRuNEMxYkJiUUNVZk5FQ2FVZko5ekp6eUxk?=
 =?utf-8?B?MzFyaDF3aHpHMGlaNm9qM21jVWFKTGJPcXdmTFIza1FibDBLZHMvY0hkNG02?=
 =?utf-8?B?Y09iVU16Nkd4Z2F6Q0NYSXBoYVZ1aHNieHNydXVPa2N2cXVrUnZJWjV2blBv?=
 =?utf-8?B?VzE0UVZUSnZ1UXlmNXkvNktLM1gzWWRCK2RRRTZQbXNscnVaaWVMd3Rna1B4?=
 =?utf-8?B?YVp6b3BBdWRFTys5U2FJR0JhQzR1QkFPOEpQNCtSU2FLT004Z1owdVRoaFBs?=
 =?utf-8?B?ZElUcXRCb0ZjUGRtZlR6VTloc3hCdkFRSGh5bEx5V3hqTStobTZ2ZklSaXJL?=
 =?utf-8?B?bG9kVFVjZy9hZTlrVWxQYXduZmo1VVpwNVlWRVJDWXBWbndFa1hRc251TUNE?=
 =?utf-8?B?Z3Bqc09LRjU5UXk1N1Nyb1FSYm83cEYvMGFTMUpzQzZiczA3ZTdubkxZSXNt?=
 =?utf-8?Q?7kQ17Pzc8xcgxPtrkBAKF5TuR9sfjmsZKmiAgKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef50ad1-113a-4915-675e-08d9767e719d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 06:19:29.5202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvgfE6+pOeb2nAKMrTywhzVQtQdMCyDKwCxcHfrk8PBXIfNnywPHnGhw2OGWRA6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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

Well is the delayed init work using direct submission or submission 
through the scheduler?

If the later we have the down_write of the reset semaphore pulled in 
through the scheduler dependency.

Anyway just having the sync before taking the lock should work.

Christian.

Am 11.09.21 um 12:18 schrieb Pan, Xinhui:
> [AMD Official Use Only]
>
> For the possible deadlock, we can just move flush_delayed_work above down_write. not a big thing.
> But I am not aware why delayed init work would try to lock reset_sem.
>
> delayed init work is enqueued when device resume. It calls amdgpu_ib_ring_tests directly. We need one sync method.
> But I see device resume itself woud flush it. So there is no race between them as userspace is still freezed.
>
> I will drop this flush in V2.
> ________________________________________
> 发件人: Christian König <ckoenig.leichtzumerken@gmail.com>
> 发送时间: 2021年9月11日 15:45
> 收件人: Pan, Xinhui; amd-gfx@lists.freedesktop.org
> 抄送: Deucher, Alexander; Koenig, Christian
> 主题: Re: [PATCH] drm/amdgpu: Fix a race of IB test
>
>
>
> Am 11.09.21 um 03:55 schrieb xinhui pan:
>> Direct IB submission should be exclusive. So use write lock.
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++++--
>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 19323b4cce7b..acbe02928791 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1358,10 +1358,15 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>        }
>>
>>        /* Avoid accidently unparking the sched thread during GPU reset */
>> -     r = down_read_killable(&adev->reset_sem);
>> +     r = down_write_killable(&adev->reset_sem);
>>        if (r)
>>                return r;
>>
>> +     /* Avoid concurrently IB test but not cancel it as I don't know whether we
>> +      * would add more code in the delayed init work.
>> +      */
>> +     flush_delayed_work(&adev->delayed_init_work);
>> +
> That won't work. It's at least theoretical possible that the delayed
> init work waits for the reset_sem which we are holding here.
>
> Very unlikely to happen, but lockdep might be able to point that out
> with a nice backtrace in the logs.
>
> On the other hand delayed init work and direct IB test through this
> interface should work at the same time, so I would just drop it.
>
> Christian.
>
>>        /* hold on the scheduler */
>>        for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>                struct amdgpu_ring *ring = adev->rings[i];
>> @@ -1387,7 +1392,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>>                kthread_unpark(ring->sched.thread);
>>        }
>>
>> -     up_read(&adev->reset_sem);
>> +     up_write(&adev->reset_sem);
>>
>>        pm_runtime_mark_last_busy(dev->dev);
>>        pm_runtime_put_autosuspend(dev->dev);

