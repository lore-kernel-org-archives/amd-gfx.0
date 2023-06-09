Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4D4C7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 19:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBE810E0C9;
	Fri,  9 Jun 2023 19:33:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BC010E0C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 19:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kinCgMDdek2Ad3alzdgzBOXmtCjQySBr+RB6H8SOCueGo4CMmDbpmmUfYeFxK6J4V1v0/7o83beJNVl8CCpxVaf6c340f5/TyjfQpR6Jh+Fcb+V4zZ8puSGfvlztM/cq6SxDQxDrqUEVZP+UkrUboMxHMlgwzbtvD0jDt6h1uTPu5w0lJzgkmQh2/B8ZD+QZHeH7mou2srsGJ+IrY+HoLsaQKOmJCn7CbxDxx86OqtrHTA6a6dbfeSkiDSIHX+EUAuK8l7/cydy+OeNbDHIBF3I/EkYfMvHmWyqCZqWOMG5cn0dBzN8t/QhkI9tTO7qMUBlAuTQHeTUu15z+EA79YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4yUqW6xvGfwK5MvzKZbV5mS5WIGqtgVcewj6QcLJfU=;
 b=MfihxIAcnXhoB0MlBuieitXzJa/hhylJOJ/ddsBOcuLfm+uCFe8IiF+VGU9hLNo8WH9LXC3wv71u2rzymyeWLOdad+Hx9YtLdcTjf6MXIR5KwA0alCnGk7+TVBvYFcJs4ofW4p7l8sk1mNfH3cQF9iTUQJa2Px6/apjJJZuxFL8aQ9t4onGSu49pS2Oge+wky5WrbyRgDRZEWGoJbgTBkPG1ZJtRVJ6TW3Fwr2w+vvqLvbIZVxz5h5yZ/xp65JMSUn01j25ieZwxu6ZlPgNUP5JZtbtSPsxXksSJls80i40OVI7yxkTb5Nh1YL5suBTqKc5/lGBeg1bEaEOicPwGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4yUqW6xvGfwK5MvzKZbV5mS5WIGqtgVcewj6QcLJfU=;
 b=1+I3gDqODNtqWc6Jg9NvPaznq0xABIf+yEXoSpgHQM2WcQPnTpFEVPfpiEkBtDDTXk70/lT0iEPJvr1PgF7v9k3MP8eQCK+8XlHAmGZdRmBn89S0BShxnxuI2a6+FDDRBGYUXhNaTPElAP2WHws4pIoAQWBjeLa3EYa18MM+Sd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 19:33:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:33:19 +0000
Message-ID: <bc736154-f727-a1f6-d83e-826122cd702e@amd.com>
Date: Fri, 9 Jun 2023 15:33:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/12] drm/amdgpu: use doorbell manager for kfd kernel
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-9-shashank.sharma@amd.com>
 <2808cded-f913-58fa-a026-6887445ef37f@amd.com>
 <0c0fb5c0-1183-c4b3-272d-fe153faefa28@amd.com>
 <4980a1b8-cccd-6d08-a95f-0d7af7b15878@amd.com>
 <659d9452-7828-5b14-edf6-a3b307d4319e@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <659d9452-7828-5b14-edf6-a3b307d4319e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc0651b-f719-48db-8dbc-08db69206136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIdtTGzA3GFV/ydj8zNk9WRRa2MUFT5rFnzfIazur4s8ZfBLi8yqA4oBoaPDJp5sT80ORPFwoDhxMFFmwrMuh3JAxoBBEjEoNWzV8/OMtBmgcXz+hZ/TSG0gdmxQQQJ7LKV0GfJoIf+EtoLvWstovYQtwXhMn3tCtelVMbrgSSDM0vjCme7cV/XGdXHuWyaMLP45sZBqn/H0IH/KXxGqRXLvIT9uQ6THZbWxbZbpRBZp04xO8EtNiOCO7nJEV5zN6FEdrsrvnE/NjAVnvjau1eoDPiHLJ1L+KSAYeKBQNL5o+TmOCRfjsY2ChwNy3uAT6NnIMxQ1eqFj3Wuz31bjwouPIoYofxkyGGsYUFGGvkkWaytk585fMahUSrNp7VcvC1J31kyA0rVt/vBs8olo9xJo/jS2+zTtht7oAhI01KfHA2RXEhElus7JjsvrjU2BWKqrSeN+zwEw54Hv1PWKmiv5ZSxsr3uy6RzZ0sayWyzelOFV2X8Kc/W7oLkW3cigARCJNT6WmTX4dj4HJGKJeTiftdJBo7VnUKUJtKd+ShrRXmVMX0fb4bhpJ9M8sFfrJ9atDZwy08DE6iIha1n2ePmJV7bRvLeGViSYiE214Vbop/1jfUk8IdK0o1XmX4h+HRUXa5ntdCFUv+ydwjYB6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(66476007)(31686004)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(478600001)(54906003)(36916002)(41300700001)(6486002)(316002)(38100700002)(53546011)(26005)(44832011)(6512007)(6506007)(186003)(2906002)(2616005)(83380400001)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm1SUjIvYjFBdFdJeGh4aStBMGxzNVB4dU8yajV2STVjNmhJbCtkMUF6UnJD?=
 =?utf-8?B?VWJMNjl4Vml0SjZIbHNOUllvQ3VrdGd5alBkdnVXcHRoeWxJNGR3ODFRNVRx?=
 =?utf-8?B?SUpmRnAyVllraGxma0R3UW1sTE0zV1hRbnJOMTdLKzJnQk1YL3EzdnlFUXUy?=
 =?utf-8?B?TUd5V0swVElON1Rnb3NUQzRqZnlFNDZWdTlxRTI4Uy9wWnJGNXRib0xub2d3?=
 =?utf-8?B?TW9CYnpjMHBjb3NmTWtjTlZpc21peVplUzdzTFR3d2h6T2JIUEtxbk42bGRD?=
 =?utf-8?B?QnpoN3JGS1A0SlRncG5hTGJlNmtkSFl3ZGNmNlcwd0hLNHFWU2ZOazdjQStR?=
 =?utf-8?B?NmRqQkh6YUhXYTA4d2haZmxyUDhPQi9ueGU5UGt2ci9jbmdSRmN4UGNEY1pQ?=
 =?utf-8?B?aCtCNW9ncXAzUGdjKzJxdk9SQWlvVy85M25TcEFGTTZ6Q2FJQkJUWklNWktX?=
 =?utf-8?B?Ujc1NW9lZ290SXoveVlJelU5dlB4aWp3WHpidkpmMUtscUtFMDlqS2o2bUZn?=
 =?utf-8?B?SjJWcFJBREM4WjdZZUpSSHl5a1hidnpSZTJjSHdadjBoaHdYS1Jjb25xSWJF?=
 =?utf-8?B?Qm5UdnZjWGVGa2JtZG9mMDJ6RDhBL0kxNFhjT3FsY0R2UEJBZDJJYkw0UmRJ?=
 =?utf-8?B?QkRNUVBBNm11WjJBeEJTd3A2ZVdKTGJrV0dnQ3VuL3FMc1BIa3V1YWFkMy9Z?=
 =?utf-8?B?K1B3MHFTOGR5ODhDOUFmSHptOWEydlMwRkhVaUZsd2dEblArL2R2QXorK01E?=
 =?utf-8?B?K1JtZEJvTVYxcnUyS25yclMrVG02OTlDM0FzZmpLT0VweWpuMXd2ZVNxUlRn?=
 =?utf-8?B?T1ZmSWtnQWlwejM3TWRLNC9ZM29KRXRKaVVBT0I5QW9lcDVXTkEyS2txV0NR?=
 =?utf-8?B?OUNBM2M4VkhUQzZ6K0VBOGdIWVU2dExlTTlFajFMdFFucUJuRlNkSU1FSExX?=
 =?utf-8?B?YnBtUXJjN1I2KytFTURxTS9XVFFlZklGVE5FTVExR2tpcGxrTStXbFpOUkNk?=
 =?utf-8?B?cWM5eE5nd2ppcFAxblExRXNvbnBTK3RYTHB3OXZtOUg4cUFHVkpPWTI0YU5O?=
 =?utf-8?B?b1RrcW5sZFJRdHFOTG5xenFqUUhBSE91azNXaEhOcjZtL3RUYTVlUUphS2xk?=
 =?utf-8?B?Q2pWdlYxQlBmVzZFaHFtRjZnZmVYWlo5aGpsVG1uWnpkMEh4dXJES0gvOXRv?=
 =?utf-8?B?R1NUSFgvbTVwNFVSS0xVelFjd1JuaXNhUXNPWEx4VmhvbzM0dW1TRnVvd0do?=
 =?utf-8?B?bHZwQXprUzNDQ2pkcnpDZnhld1FNT1NROVVlTkZheTh0L0diOWtsTnFsbWEv?=
 =?utf-8?B?VVNWOEd1TDJybW02dEZMMFlIanJueWU2eDE3THFDM3JabWV4YWJRNk40ek5w?=
 =?utf-8?B?TXpMWWVxeUl6c3dlTGpwNU1DZGpOL09EdXJCRm1jazBacEVzZUhjZ0MybzMr?=
 =?utf-8?B?ZzBZM0pkNGVBZWdORXJLV1JDanFTd1VRZkN2RWtIbEN4L1lCVFYyRFdtWEkr?=
 =?utf-8?B?TFR3ZnJpQnVTT2JCaUkveTdVWkxhWjlUOEo4N1g2Sm5RRlNyQnVOeXA3eG41?=
 =?utf-8?B?SkNYQTdrNEUwMUJtMjltUy9UR2VUSytZdFhnRkYxNGRoK1ZBcXNxbjllTWF1?=
 =?utf-8?B?L2NIWXNURFNKY1BTNERzc2tCbVZvSEYwbnp5QUZUbnNicTd4bmtOcXBZRjdz?=
 =?utf-8?B?RzFrT1RuQlk3WllZdTIxOG50NGhtNjZYRXNPaUFuYlZSYkFmSXh4UERsb2Er?=
 =?utf-8?B?LzZIcUtLK2srS1dwVlpVejV3U3FTZElkVTJFMmhGbXVXdjhhY3FqYTI3bTNx?=
 =?utf-8?B?UUxwa1J2bDBOMmU5QXQ3eHI0QlFKUEIxcmxEVll6OFJWallaeHQxRE5yWnlz?=
 =?utf-8?B?ZFNxZVBySloxR3hsbCs0MWJwS0hhSnRhQ0RQeVNkZWo3c2xvaXZvVDZ1blZ1?=
 =?utf-8?B?TU5YTWdlVHZqQkJuZThORHhhYmJYeUF2dENQKzFqUTcySGFCUHdLTURlSFor?=
 =?utf-8?B?TmI3NXpFdnBWSlY4RnFEOGowa3JuUTNCb2dxR0lEWWhRMk8xblRiNXNGcCty?=
 =?utf-8?B?aU5Ld3EvR3JSNUZ5czFqYmFXVHJHcW91ZFc5WUp4SWFiMHRhSTBybkJWd1Rq?=
 =?utf-8?Q?blCzbDdMAIbFVbzCQzE3bm6Hw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc0651b-f719-48db-8dbc-08db69206136
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:33:19.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq4Ib2odOfar8Vm715hgc4lNLblwo6i8P3P1Hk9Pm2quNsca/PcEKPkF6TdNpakpzlvllzUsgNUlS7NsjVJgjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-04-25 15:59, Shashank Sharma wrote:
>
> On 24/04/2023 21:56, Felix Kuehling wrote:
>> On 2023-04-22 2:39, Shashank Sharma wrote:
>>> - KFD process level doorbells: doorbell pages which are allocated by 
>>> kernel but mapped and written by userspace processes, saved in 
>>> struct pdd->qpd->doorbells
>>>
>>> size = kfd_doorbell_process_slice.
>>>
>>> We realized that we only need 1-2 doorbells for KFD kernel level 
>>> stuff (so kept it one page), but need 2-page of doorbells for KFD 
>>> process, so they are sized accordingly.
>>>
>>> We have also run kfd_test_suit and verified the changes for any 
>>> regression. Hope this helps in explaining the design.
>>
>> Right, I missed that this was only for kernel doorbells. I wonder 
>> whether KFD really needs its own page here. I think we only need a 
>> doorbell for HWS. And when we use MES, I think even that isn't needed 
>> because MES packet submissions go through amdgpu. So maybe KFD 
>> doesn't need its own kernel-mode doorbell page any more on systems 
>> with user graphics mode queues.
>
> Yeah, for any IP with MES enabled, KFD doesn't need kernel level 
> doorbells. But I still allocated a page just to make sure we do not 
> break any non-MES platforms or use cases where MES is deliberately 
> disabled from kernel command line. Hope that works for you.

Even without MES, we still only need one doorbell for HWS. Allocating a 
whole page for that is wasteful. Anyway, I'm OK with cleaning that up later.

Regards,
   Felix


>
> - Shashank
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> - Shashank 
