Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F6FECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 15:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B2B10E048;
	Fri,  9 Sep 2022 15:13:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DB310E048
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 15:13:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkDikD8/NwwcsPfNVqEUI/+Ava6FqxsA4fUg8fDhYZMPeqD1sSQVDOsjLBknEz+ddAO/1c1gCNsgf3N0uYoPXZb6+oNGyxm55awGqCs14OsLy7qwFt0+3fQ288V1ekdGmMtWJXa+5wVlEZIjEvC/jESzosVh28rMZR3NV4+9/s72UTcIn8tPeQf0TCaLl3GczGtm2a5iinYJrztwsKUto8R8LKuK6ewiqKAFIO1tG2sPEDLxCesK6ZQ1S9CCXuX5mSmbPap7T5501dr8ZF1hVIyd8xbbQH6J6ee3tIsKt7FHCiZHdxShZp+E6t3SY207e6Zh5ghz6fuybYOUwNVEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzJiKRAGyoD6xJyCN9BLIXS7WVUJXc/AlJWpJTvZYeE=;
 b=cRXDB67BLo8V4mpFIhsHW+xJoR1yw0MFgaKC31ydKxpdxdc64s3uMIAuYwr6ylVktwv7VU7uBX3BgaSW82Ey6SkJc6j0gcSZE4CcoulVXckZLDEL6ZC92KwQ56ll3yyAGNF5j6vS9C7sC8PP/xw3JYDA3HIG70l8kI005+kOVd6Fj05UqNlHprp94wpqNDy6yEdl1rsKTILIDftK/pNeCA44euUtvl4IlMjTCKNcup5vwNWPjgVYUTmQzFs9RD6JdP36sx50oj9/FmVOxGG0QV8UZSqBhSfI6NuRy3MKXV4vB6Qldq5gGDgrqb6OIFiJDFuIV2SvMbdYEJO8VTbWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzJiKRAGyoD6xJyCN9BLIXS7WVUJXc/AlJWpJTvZYeE=;
 b=ZEG7Ozw6D/nxEj7r9ASQAT9QoAqLS0+MSMZ/ftus8MxjHJFqmyp+eUThlTqNWSJqjvwJAmU7dV+81qpWeqcyX8uzy9okoi8KddyB2g+V7F5tzvxORdvUpimQ9Nteypqcj0zDkbVR1ij0zVvFegDmg4XlOP2HxRVkc93IEW+VtE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 15:13:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5612.021; Fri, 9 Sep 2022
 15:13:25 +0000
Message-ID: <cbb46a59-75c7-d3fe-d200-fbf4ea402870@amd.com>
Date: Fri, 9 Sep 2022 11:13:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Migrate in CPU page fault use current mm
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220909131219.23677-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220909131219.23677-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f57ce9-0342-49bc-db57-08da9275d797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeQLT9WGlQw9WReoJVfV9SySIbu575NG0jNZy1toXhIQTRAn/snp6dTarpF0N9PiSERY7VN1PiQ78iSGcHUKGLwzctiFXFUBbCBZimBqH5Tkrnp4uJq+ESvKNEH46PgCz6MuifeiSwJ6yixGSc2GusnBEKLYxh82MMzlOUqvtBSkWtsJ3P94/lwcCCzP6mJKN8pxAFD0YkS632w1+DnGDJgl9g8PKpINyUofQKeqPT/psqSsUYlN7pwe+ajWW6yTAmW9H0Y/Aq/6Q3NL1YnOYG6Sw/T48Vl9xDnYKpGy1H0ja74EJbJJqwTjK3pabLLzxUXRTavF4J4O1hdz6Bqom8b+uO3krJXqlok2BpaSjOaoI2kY76ih6aemBTotj63C/R7IsR19IPF/m+V79W5CiN6tgNbFLtSSd0Jfg0j7j6Jcs6UIcZCk07rsWmPigApnSNM/eusWjdMcsavXElm7bz9arUVa7GX/W+wnPPtIWcqoOzHo8fYF6LI0Df5F2coluQtRfTBEePLYJ5vNZP1ShmGBT9gluaoWO/5WOAV63rHYqptwHYUmj+bDC6zlQaxAtFGnQ2yorazdXyIDXIOaPH1IoSJ4E0/YxRI9E51mqsS4P/IsG2Q+4VGNZ00F6TPEn26cR5x0F5iCNJrq7yAPeN1mQEIkU/1BmR9BbHYs7Gpb+K32IVmSiK1W7zOOaa6OE0HXunFnAmXrPgjZKHjOqIv2fzSBm9mfVeN5O1H0twBU4luj7QtB1SPXd1YrAua+FRPLkNy426APfs/b/dDnWVLz0zlD7Dq3GsnhDhguM5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(66946007)(66476007)(6486002)(66556008)(31686004)(31696002)(86362001)(2616005)(8936002)(5660300002)(316002)(8676002)(2906002)(36756003)(44832011)(41300700001)(6512007)(26005)(478600001)(6506007)(186003)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTc3WDBBN3BOVy9vdFBhbzFjbDBPb21aakp3ZjdEejYyUzNqVjl5RW9mdWNa?=
 =?utf-8?B?MWV6VFB4N21vMU1pMVBGeDc3VER2VnkrZDdZdlpYUFNORUxwT2RmSFFIU2tU?=
 =?utf-8?B?YUROREh5bXg3Tm1XVVJTNk1Ic0N1bllYU3dPTzNxUGc5eEkyMWxnZGlWNExt?=
 =?utf-8?B?Z2dwVzhoZUkyMUdFdERmSW9weFNGWGFUMHpKbjRSZnRsL3FBRG15UVczb29O?=
 =?utf-8?B?aDc3ZDhHNTdWNnU3dEJ1YjViZlpDcHJkRUUxaGFna0tJMEh3ZTRHU1B5WkVr?=
 =?utf-8?B?dlpsSWw4TGFOeGtPY01PcnlCT25lTUpKY243NnB1TTNVSjE0U2p6TGNOTjdL?=
 =?utf-8?B?MWxNK0Yxa2xLc1FYMEp2N0U4MVZNelVjZ3V2TURoQmdDblViNExNN0w1TC9L?=
 =?utf-8?B?MWZzQVdEalh0SG1qd1U1am1BcTdHczYyOVoveFZiYkk0T25PeDdxb1ZRcDVq?=
 =?utf-8?B?cVE1UFJDYXZmd2hmYW1VTDcvb2tWMUhCU0NTdElRUE1CWFdsZW9TajIrMzRB?=
 =?utf-8?B?MDFnZjNrRnFUTklDNFFBUlA2YmlQbmFHZWNUc0pNNnJNMXpFdTJ0S2tCQTZS?=
 =?utf-8?B?U2hNQW1QeE96am9zMWk4UU1WKzgxaHZuRjdBUkNHNFJHNGdzUGREMURtcXRz?=
 =?utf-8?B?a1pCcFg2UVBYRWRienFLSmFTcmJPWTgwRjYyT1RFc0drMU1kT0l3VWFWK0ww?=
 =?utf-8?B?SmxpV0lYcHJxZHNwTVE3a2xOMEhJZWVUQUVWUnB2a3oxY0ZiOVM5YVhOYktn?=
 =?utf-8?B?SHZTTmRUcHEzM2pIWmxSd0x2YU5welF4OXl1SSsrK3hCbFdUT2ZVSTdLWW00?=
 =?utf-8?B?Qm5BVWRXQ3hIZ24yNGNMK1Y3VlFEVUNBZEEvZUIvUExUbHBteWJydERWeVYx?=
 =?utf-8?B?R2hsbUV2U3BWVmxLWGpKZVdYUmhiMDdKV0UydnhOTFFLdWxFZjgwVXRBdlJN?=
 =?utf-8?B?VWFEVFFKd1UycXRYMG9ya0I2V0t5cFlGdmFEbDhzQjByZ1lidk9VOTRqZ3Zn?=
 =?utf-8?B?S3JIZU1Ec29FM1d2MjlqMDFmT3BiZmc3KzgvQ0FqblNSeFRqZlZjc01BY1VR?=
 =?utf-8?B?UDN0dHFmd3RuSUR5ZlZPMllKQ243NUphKzVuTFZvdG40dW5UNkJDUGtRdTlL?=
 =?utf-8?B?R1JiLzc1WS9IUVBUVlo0VGZxTXErbUp0RGp1aTZwNkVPZkMwa1JjV1NxdUZN?=
 =?utf-8?B?RWNscngvQ3dZWHhrL2ZTU3pZV3ZiZlhBb3grSldkMG1RbGNzeWpHamc0NzUz?=
 =?utf-8?B?V2NFQ25FdktZdXVjbVFWVWNDaGZzdTlhWU4rcXlHZG1GWTlaNjJ6M05ackNs?=
 =?utf-8?B?MWFSVnR2WkdvOUFoZHp5Q05IWllVVGJjZWN1ZWZzcDVNSVl0SWp4MnpNNUZS?=
 =?utf-8?B?T21jMXF2bUtmR2FZTkNtSU5VMlg0bHdqMkpVbHlrK3JMODBzTTZjWk94Y3Ni?=
 =?utf-8?B?QUpOMzVhdW9WTWN1VExvazc5S2FsY3NZVU40dW1WcU5ENGpJMFE1TWQ0WTYy?=
 =?utf-8?B?RFNXOWtCV05HZFFEcURybFhrTUhBZjl5SVpNVUl4emxQQTd3djY5VmJvS0xh?=
 =?utf-8?B?MnU1TXF3MDFzbDFGaENxdzhOazFxVGE4dmlYMkQzVkEzM1locWE3QlZmTWVT?=
 =?utf-8?B?Q0g1UWx2UERzWjFsMVBkU1JoU1dWZ01iOFZHcng3bjFuRDdTNFZiWFlvRmp5?=
 =?utf-8?B?MTFMOGdiUkpSVW1CeDR0N2hnaFhKTG1WWnZMR3lNNlZLRlZSZ1ZnWlNYT0sy?=
 =?utf-8?B?MUE2VmZBQmJVaE95QzFEN0diZ0ttN2RHYjhFSHB5ampnYjBTU1BZcGxpSlg2?=
 =?utf-8?B?cXdsdGZlSHZLUURFS2F5eC8yejBhN3BGM0pXVFI0bWNNbXk3bGdPaGZPNVN2?=
 =?utf-8?B?V2FuNms2Q0o3T2dJM2srUERvY2lKV2F4dGh0QklSZkZRUGNvOGNMTVJRUVBZ?=
 =?utf-8?B?VFVDSll4Y0RZZWpiRUpDZCt6eG5PMlQwRjg2WTdSbmxwdGVycHQ2Y3puNVVV?=
 =?utf-8?B?Q3dDQkRxUVdtVmpkemtMOGh3K2x0NzVmZ1NSWnVnNU1mVEFaVzd6Yll5Vjll?=
 =?utf-8?B?YWRacVo4MUpSMkV4cHhPNVhkUDRpVSsweFF5bXBUdi9pTDJST05BQ3JJY2Qw?=
 =?utf-8?Q?+s+uwoU3i2NJ6DT8Uwff0ubaB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f57ce9-0342-49bc-db57-08da9275d797
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:13:25.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULUEWqBU6eL8IntOR+G4RT3C1WTzIBPMkW54iZALxE0ZVAiLJka/2zcahoBdk3y9KklBwoC98BJgnXiGQAhrng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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

Am 2022-09-09 um 09:12 schrieb Philip Yang:
> migrate_vma_setup shows below warning because we don't hold another
> process mm mmap_lock. We should use current vmf->vma->vm_mm instead, the
> caller already hold current mmap lock inside CPU page fault handler.
>
>   WARNING: CPU: 10 PID: 3054 at include/linux/mmap_lock.h:155 find_vma
>   Call Trace:
>    walk_page_range+0x76/0x150
>    migrate_vma_setup+0x18a/0x640
>    svm_migrate_vram_to_ram+0x245/0xa10 [amdgpu]
>    svm_migrate_to_ram+0x36f/0x470 [amdgpu]
>    do_swap_page+0xcfe/0xec0
>    __handle_mm_fault+0x96b/0x15e0
>    handle_mm_fault+0x13f/0x3e0
>    do_user_addr_fault+0x1e7/0x690
>
> Fixes: 5e5bbf36a2c0 ("drm/amdkfd: handle CPU fault on COW mapping")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

For a quick fix, this looks OK.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

For a better fix, I notice that svm_migrate_vram_to_ram only uses the mm 
to look up the vma. But you already know the vma here, so that look up 
is completely unnecessary. So could you just call svm_migrate_vma_to_ram 
directly? Then you don't need the mm at all and you save yourself an 
unnecessary vma lookup from the virtual address.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f62c4561f0f4..1cfa4fcd28b3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -947,7 +947,8 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   		goto out_unlock_prange;
>   	}
>   
> -	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
> +	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm,
> +				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
>   	if (r)
>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
>   			 r, prange->svms, prange, prange->start, prange->last);
