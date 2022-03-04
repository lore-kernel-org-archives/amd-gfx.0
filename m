Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C618BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 10:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FFD10EE16;
	Fri,  4 Mar 2022 10:18:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C5F10EE09
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 10:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM7D0/3KXnj/0HsUKz0sIfPKrY96LpPWOrkOpckeXVpzJlBoRx20xdB0dPTaNhlWagmMGsYSrrqCOLqgFNU3ETvhTwItU6kz6Sgc/n021USHBrOZypD5a71LMp3K+Zp9yJ0qNLPe+d1ESPjvnDihjTSy9iwD9SbxiQNSKidCdPkjkg9lMPm5DdZON0X4Tb0Yc2xzMjwZMAE23YE6/9tDdxGNwEL2nzsUMJ/oD69Uy+9HsgK7/Vbjdw9/EQFoe6axqtQ0YPKjrevTgAZqtqYvY2kAhQ9W9Xtv67Df0ffzUUU3Ry71oO+0ueh21QlNBH2CrjCKXqQXk/njd5Qt4L0NmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReMHoYW1Czq/BP5Ez8qfhm52Dn8OJcP9IYHLfqLQ8dM=;
 b=XA0/Vrk6rJsTtjHgM0PaTaSsZJ3uifg9C/OacV+Rq6DP0agT5oNDr3EzzRnp6q3V+fWUG11F8jOp0CaunM5nkaIUorhEOPISAWvyfXKmHyACbzp/yB9+vj5H5XEmVuC9Lpjwnp3oFbdzAZq5R6XOods/zjEYdcf+M2g7JkpnoH+C8Mzq8GtxCRWoUIyrXV217Ewx0GPV3PSfn8+kxqbeS7prmVA4YTrHEJPpwomWVtUp/26a/DCksNYMLqXJmEwBvHHXcl+rPXBOaR6rujptIpoLl30xT47sSySZR2CdSPvpCe099LUOJRz1+p+F1qCV6moRLKnqjZ4DTIdoszSSDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReMHoYW1Czq/BP5Ez8qfhm52Dn8OJcP9IYHLfqLQ8dM=;
 b=jnLjxX1396fiRD0AzzJ4tKBwYcjh2fRBcqRsB3vMzkPQq57fNK0whyRgCjBJpLRGWfGxr4Vffb0RCtXvVahm/w52M8QQ47lQ/xYdSEtsTpVLX9WOEtzkHDMlDRfhzOlztrZorJpwmIaO+ojofdjlTbD2Hrdp9Qxv2S/e7dPnwOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY4PR1201MB0117.namprd12.prod.outlook.com (2603:10b6:910:22::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 10:18:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 10:18:24 +0000
Message-ID: <9439a65b-ee30-bb85-81f8-44419e2318eb@amd.com>
Date: Fri, 4 Mar 2022 11:18:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Content-Language: en-US
To: JingWen Chen <jingwech@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0253.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e7b4213-47a2-45fd-12d1-08d9fdc85082
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0117:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB011701223FEAF0CBEC0837AB83059@CY4PR1201MB0117.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxjBAkcltbG2znUsy64tLBHsC8P+PqYq16moXJ6hIt/ycNi1cHam9/R7YZkGBvQPpVcc1bDUXTuyiTvf0cRVTX7CzorVQDowz08ZdTgKk+rtY8j1vIQn1dHskVXfSmA9w+uMrxI2QTohjuj5HWv9jpOulHyG0X8QBf5HcBoggPydumXigovUGMTzbLHlgc/UoX/GppnJBDivODmfXmPop7bHsrA+KI3IDc4RxRflvhPvhW60jPkB0Mo2+vQfSRZU1+W8bcpnZ8NEhXovxCqcb6ru8Ku+4f+nj3G9r9mAhG1xNRfywToX2wuuB/xZhw1Iy1BlSfsz5Me/NLxr+J/Cskoj0X/PPBkRxpiNMuKw4jBE5bmjvyY/jqTL43gIKm/g5oytKu6rtnZFA4u9lA8Iob1RMPg/a99PTmFfXjwassmAjuT0xJcX+uNUH0Hpru9GUQ3/nCgDOfLGFR7cNdBow/4kRWEwtBKY831RDwyBrh0LtrxLTxFikT13t1gTe5orHmK3V3zJ7PqlBqHsYqMvNKtAHk34VFGvMxDJHE3WZx1q6KeYwUMQFeybW5RdcScOBf6iKtBhAJzZXK1dWl6OZiC6HXlucdxkL3azQlQpFN/6ND3xJDLybMBr9Oay5U2Vve3BSER7FpLQg5ZZzmOlK0t6cCEr/TxZNuw+hHaWO2h2I2TCQ6XWYXeTRuQNU4xfNuX01ceimS6MXXow6UETIRyIuWPT9TbJdg8KfAjVnUV2oovpHwb3+OWvZy5tRIXZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(86362001)(2906002)(8676002)(508600001)(36756003)(186003)(38100700002)(26005)(2616005)(66574015)(110136005)(54906003)(53546011)(83380400001)(6512007)(6666004)(6506007)(31686004)(6486002)(5660300002)(66556008)(66476007)(4326008)(66946007)(8936002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhhUTJ6M0xsTnIvSVVoaTE3UUh1WTJYYXJhUVVUdnB5a0Z3VU9XbUFpWXFr?=
 =?utf-8?B?TnpMbjFnZ1FseEh3YUlBZkJ3YlVtczNCdENyaEtNL3R0ZlBDZ3VoOGUzcm1n?=
 =?utf-8?B?WnBseDE1U01QMy9wTGxZRytHUUlzUU9VRllZTzdxT2R2Y3VxU2Raa1BtendD?=
 =?utf-8?B?TXNBWUhOK1ZDVnkwRTJsQjM4c1BqT2V1UzNGT2RQblBVajVrd3hXbXA0bmsy?=
 =?utf-8?B?dFFPR08yY0N4WDRNZGx4Skp0N3Nnb0dBZnlEZ2V6QWpZdFF3UU1WQ3U3T0po?=
 =?utf-8?B?Ry9zaEJYR0srMHNHUTdTeEZLZ2Y3S0NydmVqRG9CcEVnYkdOWFNtWlFPcWVW?=
 =?utf-8?B?TUJyTHRLT3RLQ2lHMFJNWWtZSHRZVmVVTzNPZFk2Q0NHZmZUclRwVER0U012?=
 =?utf-8?B?dmhZbDZqVU1LYUFxcmdIMlg4LzJGeDVQbHpiRWgvaFJUdGNTbnlnRTFGTnNX?=
 =?utf-8?B?bFQyRDF2bzRMekZSWXFYbjdMOEV6TlZQa0laek5FSXVQWTNFNUZXRTQwcTNH?=
 =?utf-8?B?N1RBVnVTcGQ2K0RITHNCZm1rQkdrUk43b0pMWm1tVVlaRGowZm9Ody8vS3k3?=
 =?utf-8?B?dWFEQ0FxSEZSUWc3eGprSU5FME80ZFRzZFdnL1JGV3h4d0hvNmVHZTdVSkhi?=
 =?utf-8?B?S25POXZZWkFHU0JQdjlxamdPeVl0NEtFd1I3SmpWVm5LaFlLcDlBYjVlblUr?=
 =?utf-8?B?ZGxOU2Y0emVzMnFmbXNRbE1RdktyM2JmS0h4amJueC8zTGIwcDlUbDNUaHhL?=
 =?utf-8?B?Q1JzNDZWNTh3bWIyMkM0VkR4TGo1R1UxTjhCMVJNVEZtd0JOSytOeWl6Nitw?=
 =?utf-8?B?MG9Qc2RCeFFEZTI5OUlIb0NtNlJ0YmExdVZzdkZyVmZkcEkvZWRPaHA4YWUx?=
 =?utf-8?B?VEdUUWhxVlJVTFBNTWNQdVhEbmo0V2FtQm1SK1lPMy9uMlk0Zml4NFljeU1o?=
 =?utf-8?B?VEtJVnRUVTl6SHNXRG1EbTFIeHgwNXgzUGVmZDByWFphcFYxVTdEY25QbmdT?=
 =?utf-8?B?Wm95LzBydmtZTUF5eXJlVW4vaGl0VzZEZDdnWE01dlE2dmhySURFOSt0SHRH?=
 =?utf-8?B?VU1BZEhhSlhGMjZNWlNTSVU5MDkyMy9GWGJjQU0zdDJJVzVmSDgyZ0hTZno5?=
 =?utf-8?B?L04xdTBFTW8xZXhBcGN1SWoyNVhIUERwNTkyTnc4QUdiTVZYL2lsVHArQ21T?=
 =?utf-8?B?RkpXZkVFM1dNcEhjK1hqRGRmUHdGaUJ5WWZ6TDBIQlVMckhmZWhtdmdyWU4z?=
 =?utf-8?B?bE16Nm1IblpxMDl2bW03V2dnZDBPNmlJVGtBb0NEeFZ0WHYvNG10cjM2b2Q0?=
 =?utf-8?B?S1k2STVMTldXR21GUE41TnQwb0RIVFZ3RVVqUGE3YU5NRWJwbFJGcjJVck1r?=
 =?utf-8?B?ZUhtcDZhZEJZZE83TFRKWWlTSlllUWRSM3VCVWtQVzBxbWZESjlvU1VIYmZL?=
 =?utf-8?B?OXQ1aGN1bGplTXdzSDlRbnp6Nzh5V2ZEbEJGb2xqOG1lSzJwWWI1YlNzdlEv?=
 =?utf-8?B?RVdZb0lndkRUTUNKeVU2VU5PZ3o2akVOY3pscER5Y2Jyb3Ztc1NsQVovTHVQ?=
 =?utf-8?B?eEwzTG5FNFlkK0VZV3NwRHhFZzNLOEZXQjBFcEhjMWRVb3BxbWdSVUVUUUtU?=
 =?utf-8?B?QUFnTDVVWWpJMGJodG1yc0NTcjU0WVF4Y3BrQzRIcDhzSnZ5TFpkcHBrT0dy?=
 =?utf-8?B?SFR1ZFBaZC9PZVZlRmdlNFFjaTRvOWZqNjJ0ZFJreUlvemJ0SXd0Z0E0Zlpj?=
 =?utf-8?B?S1dHeUV2eVlnVVQranZYcGJBL1pIcVZsOTc0VDFIS25LZ2xGMi9zZC9CeHBB?=
 =?utf-8?B?cXhjdlhzY21MU0dMVW1zN1FmSDJsVEk4WGV6RDIzWkVsMlJqNnhEVC83RjIx?=
 =?utf-8?B?bW1uT2crWWJxc3lueGlrMlFLaEVrS0FSN1JtRkQySkJWSkRZdnAyLzlsUDIx?=
 =?utf-8?B?NVdnTVdOLzZsZlBod0R3YVl3b2hMOHBOTW1oV1dTTkxvM3VKc1JXa0FQRytC?=
 =?utf-8?B?VjdaQzFBSG1pTVlpMHRGZVNFMGpmbnZic1EwSy9JVDhSZXJoYXJibStmZXZp?=
 =?utf-8?B?aDVuMy9TV2ZJbVdYVDhKK0lrVk1EYkU2cU5xVnA5UUVOaFdxZUdWUFdxUzRt?=
 =?utf-8?Q?WvVE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7b4213-47a2-45fd-12d1-08d9fdc85082
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:18:24.0780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVjyfJ92uMSeuE3kwDeMYEm8JDdQk3qEMKNqx+sRPiiLANRFoXRE5xU1rWg8mU88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0117
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Jingwen,

can you please always send patches using "git send-email" and not as 
attachment? This one for example went under my radar because of this.

Regarding the patch itself can you please also remove the code which 
touches "ring->sched.ready"?

That variable is internal to the scheduler and should never ever be 
touched by any hardware specific code.

Thanks,
Christian.

Am 02.03.22 um 10:51 schrieb JingWen Chen:
> Hi Andrey,
>
> Most part of the patches are OK, but the code will introduce a ib test fail on the disabled vcn of sienna_cichlid.
>
> In SRIOV use case we will disable one vcn on sienna_cichlid, I have attached a patch to fix this issue, please check the attachment.
>
> Best Regards,
>
> Jingwen Chen
>
>
> On 2/26/22 5:22 AM, Andrey Grodzovsky wrote:
>> Hey, patches attached - i applied the patches and resolved merge conflicts but weren't able to test as my on board's network card doesn't work with 5.16 kernel (it does with 5.17, maybe it's Kconfig issue and i need to check more).
>> The patches are on top of 'cababde192b2 Yifan Zhang         2 days ago     drm/amd/pm: fix mode2 reset fail for smu 13.0.5 ' commit.
>>
>> Please test and let me know. Maybe by Monday I will be able to resolve the connectivity issue on 5.16.
>>
>> Andrey
>>
>> On 2022-02-24 22:13, JingWen Chen wrote:
>>> Hi Andrey,
>>>
>>> Sorry for the misleading, I mean the whole patch series. We are depending on this patch series to fix the concurrency issue within SRIOV TDR sequence.
>>>
>>>
>>>
>>> On 2/25/22 1:26 AM, Andrey Grodzovsky wrote:
>>>> No problem if so but before I do,
>>>>
>>>>
>>>> JingWen - why you think this patch is needed as a standalone now ? It has no use without the
>>>> entire feature together with it. Is it some changes you want to do on top of that code ?
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>> On 2022-02-24 12:12, Deucher, Alexander wrote:
>>>>> [Public]
>>>>>
>>>>>
>>>>> If it applies cleanly, feel free to drop it in.  I'll drop those patches for drm-next since they are already in drm-misc.
>>>>>
>>>>> Alex
>>>>>
>>>>> ------------------------------------------------------------------------
>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> *Sent:* Thursday, February 24, 2022 11:24 AM
>>>>> *To:* Chen, JingWen <JingWen.Chen2@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>> *Cc:* Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch <daniel@ffwll.ch>
>>>>> *Subject:* Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is ready
>>>>> No because all the patch-set including this patch was landed into
>>>>> drm-misc-next and will reach amd-staging-drm-next on the next upstream
>>>>> rebase i guess.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-02-24 01:47, JingWen Chen wrote:
>>>>>> Hi Andrey,
>>>>>>
>>>>>> Will you port this patch into amd-staging-drm-next?
>>>>>>
>>>>>> on 2/10/22 2:06 AM, Andrey Grodzovsky wrote:
>>>>>>> All comments are fixed and code pushed. Thanks for everyone
>>>>>>> who helped reviewing.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2022-02-09 02:53, Christian König wrote:
>>>>>>>> Am 09.02.22 um 01:23 schrieb Andrey Grodzovsky:
>>>>>>>>> Before we initialize schedulers we must know which reset
>>>>>>>>> domain are we in - for single device there iis a single
>>>>>>>>> domain per device and so single wq per device. For XGMI
>>>>>>>>> the reset domain spans the entire XGMI hive and so the
>>>>>>>>> reset wq is per hive.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>> One more comment below, with that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 34 ++--------------
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 +
>>>>>>>>>       3 files changed, 51 insertions(+), 30 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 9704b0e1fd82..00123b0013d3 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -2287,6 +2287,47 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>>>>>>           return r;
>>>>>>>>>       }
>>>>>>>>>       +static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +    long timeout;
>>>>>>>>> +    int r, i;
>>>>>>>>> +
>>>>>>>>> +    for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>>>>>>>>> +        struct amdgpu_ring *ring = adev->rings[i];
>>>>>>>>> +
>>>>>>>>> +        /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>> +        if (!ring || ring->no_scheduler)
>>>>>>>>> +            continue;
>>>>>>>>> +
>>>>>>>>> +        switch (ring->funcs->type) {
>>>>>>>>> +        case AMDGPU_RING_TYPE_GFX:
>>>>>>>>> +            timeout = adev->gfx_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>> +            timeout = adev->compute_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>> +            timeout = adev->sdma_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        default:
>>>>>>>>> +            timeout = adev->video_timeout;
>>>>>>>>> +            break;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>> + ring->num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>> +                   timeout, adev->reset_domain.wq, ring->sched_score, ring->name);
>>>>>>>>> +        if (r) {
>>>>>>>>> +            DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>> +                  ring->name);
>>>>>>>>> +            return r;
>>>>>>>>> +        }
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>>       /**
>>>>>>>>>        * amdgpu_device_ip_init - run init for hardware IPs
>>>>>>>>>        *
>>>>>>>>> @@ -2419,6 +2460,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>>>>>>>>               }
>>>>>>>>>           }
>>>>>>>>>       +    r = amdgpu_device_init_schedulers(adev);
>>>>>>>>> +    if (r)
>>>>>>>>> +        goto init_failed;
>>>>>>>>> +
>>>>>>>>>           /* Don't init kfd if whole hive need to be reset during init */
>>>>>>>>>           if (!adev->gmc.xgmi.pending_reset)
>>>>>>>>> amdgpu_amdkfd_device_init(adev);
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> index 45977a72b5dd..fa302540c69a 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>>>>>> @@ -457,8 +457,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>>                         atomic_t *sched_score)
>>>>>>>>>       {
>>>>>>>>>           struct amdgpu_device *adev = ring->adev;
>>>>>>>>> -    long timeout;
>>>>>>>>> -    int r;
>>>>>>>>>             if (!adev)
>>>>>>>>>               return -EINVAL;
>>>>>>>>> @@ -478,36 +476,12 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>>>>>>>> spin_lock_init(&ring->fence_drv.lock);
>>>>>>>>>           ring->fence_drv.fences = kcalloc(num_hw_submission * 2, sizeof(void *),
>>>>>>>>>                            GFP_KERNEL);
>>>>>>>>> -    if (!ring->fence_drv.fences)
>>>>>>>>> -        return -ENOMEM;
>>>>>>>>>       -    /* No need to setup the GPU scheduler for rings that don't need it */
>>>>>>>>> -    if (ring->no_scheduler)
>>>>>>>>> -        return 0;
>>>>>>>>> +    ring->num_hw_submission = num_hw_submission;
>>>>>>>>> +    ring->sched_score = sched_score;
>>>>>>>> Let's move this into the caller and then use ring->num_hw_submission in the fence code as well.
>>>>>>>>
>>>>>>>> The maximum number of jobs on the ring is not really fence specific.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>       -    switch (ring->funcs->type) {
>>>>>>>>> -    case AMDGPU_RING_TYPE_GFX:
>>>>>>>>> -        timeout = adev->gfx_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    case AMDGPU_RING_TYPE_COMPUTE:
>>>>>>>>> -        timeout = adev->compute_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    case AMDGPU_RING_TYPE_SDMA:
>>>>>>>>> -        timeout = adev->sdma_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    default:
>>>>>>>>> -        timeout = adev->video_timeout;
>>>>>>>>> -        break;
>>>>>>>>> -    }
>>>>>>>>> -
>>>>>>>>> -    r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
>>>>>>>>> -               num_hw_submission, amdgpu_job_hang_limit,
>>>>>>>>> -               timeout, NULL, sched_score, ring->name);
>>>>>>>>> -    if (r) {
>>>>>>>>> -        DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>>>>>>>> -              ring->name);
>>>>>>>>> -        return r;
>>>>>>>>> -    }
>>>>>>>>> +    if (!ring->fence_drv.fences)
>>>>>>>>> +        return -ENOMEM;
>>>>>>>>>             return 0;
>>>>>>>>>       }
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> index fae7d185ad0d..7f20ce73a243 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>>> @@ -251,6 +251,8 @@ struct amdgpu_ring {
>>>>>>>>>           bool has_compute_vm_bug;
>>>>>>>>>           bool            no_scheduler;
>>>>>>>>>           int            hw_prio;
>>>>>>>>> +    unsigned num_hw_submission;
>>>>>>>>> +    atomic_t        *sched_score;
>>>>>>>>>       };
>>>>>>>>>         #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), (ib)))

