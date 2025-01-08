Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7CCE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795B510E143;
	Wed,  8 Jan 2025 16:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGkyIw1K";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC62110E143
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEB6nhWjuB6zNLQYdkO2OvkA0yexAxNJLpQL6ANddN5r7XX3lCCpQth6tlYa3RqWlJICtLKWTTqZPzvrgM13xIMF7c0A1858XMXzBRIGppPy9YbAVPyNgT/1XmyqYMBevbqfMX0Czo2b6fqINm5zIzf8LfBpnJTbutMN+l4UJbz1wyWs7BYgTxoi+pM3LENMyuQpUBQSW17faXxsLQPymSrlqmcInDuLGWQHDdxvpwnBy3RH6H6E8GjXkeOGqkmSRnQ2mKhG9z6j4VYmFgsTriWSWkKSOT5Inf+COarPlEzXE25AA4hEXJeAm1kbboNOMUBJ4UA1isIiB8Y2dj9SSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+zsmhD6bgs3p4bsT6oqbBZNvHI9GmmDqvHYbr4bNf8=;
 b=R7VdnZZDDRI5ft5TCiHhJI5Cwp5uJCXwWZaCVb6KBwANl132K1pgpSZdtp0gDOlKc48MEgIaGRPmBjKxJ/vKyMx+beAHTmkzXYP4sa39KmtNG4dR2IwFUIpNW+JnMtDzrIY8kh8RUmHtH17UIFJ3aP2JxqTU0SAxqol21QiYe8yoEi35ea3pCPS97SFJ7KSMm9v95Oc1lucjmpzGOlgvllR2hh+82TUeukndJ3iNtSzG77JPevj+fA46V+qJuTt7KfRrO8G+U/RPuMhmwm23fuBJfvANwlaRFz2yICNBfCUumc67Q70ZDD44DkUFPjL6ETmj/yIcct1Ea4KtALSpkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+zsmhD6bgs3p4bsT6oqbBZNvHI9GmmDqvHYbr4bNf8=;
 b=EGkyIw1K57s9gbVFFplMyOSpIF5zgEY2kHUi8NmbrIq+yg6GCUiCHw+Et7ULvMUbEuZoiXoSmJfl23fPvaBEsmw2uBzr8aPPjwXrZPu87FIl2f85jRvA1B3OoWAE5xzgFBSTFKdHQwUMbzRtV3r2mZIS4o0YpbsjgijVPddv/FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 16:30:54 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 16:30:54 +0000
Message-ID: <2436d74e-1c27-4177-addf-5116b8c012c9@amd.com>
Date: Wed, 8 Jan 2025 10:30:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 5/6] drm/amdgpu: fix invalid memory access in
 amdgpu_fence_driver_sw_fini()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <ab8e42d18be2d9555ccd3b03762d9a4b76e33a60.1736325561.git.gerry@linux.alibaba.com>
 <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <6cbd8f75-1b8b-40a3-960a-b2cdd6c298b9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4a5337-d23e-4a45-af9a-08dd3001d258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW5Xa0ZMS0tJaWdqOTVDTlhUNENoaUx3eHBkbHJBVUNOblFvUGRCN01yaWtU?=
 =?utf-8?B?blRsUFB3VVBlUmJmQVpjdW9FQkJSVFZtdG5vdEIwSDlEaDRRVHpHL2pxZXRP?=
 =?utf-8?B?bHF1QmxFaFE5anVrVmVVOW5ZT0dOZ3VEUGllTGZLWWFhVjVkQUIySCtWVTV4?=
 =?utf-8?B?aXlLRU5JVkpwaWV1ZXZyMlROaENjUThhNXJTVHVKM2V3ZjQxVytxOWJhNmJW?=
 =?utf-8?B?TU9EckhqWENIbkFUTkZENGVmRWttdmtXTGFBK0ppRGxXWDZ5bGc3cWwwQlBo?=
 =?utf-8?B?dGFsTG5WTGtrdDlueFo0SjRFbzQ1SXV5RmNUeTJEQTZ4SGM3bTJuTW1VTUxj?=
 =?utf-8?B?bXI3TnVLa3M5MlRIcjRlVG1PU3hnVHhmUzBNZGxENy93R0kybWhVQnB3QkJl?=
 =?utf-8?B?WS94V3VMR3BrdEJ2YkovYzRUcEZWek5MN3d6WGpaSk9GZlZiU3BXR1lLTXk0?=
 =?utf-8?B?bDdSYitwOWw5RzJyMHdtYmFPUjZmTVFVWnQ5eE1NaU40UmMvekVobkF2UTRV?=
 =?utf-8?B?a1VjSUVxWi9NY3pmWndiVDNWc004WTJuWUN3UldOekk4eXEyVXJEMDNpc3Zi?=
 =?utf-8?B?bnRlN2RBdjhmMkpscGR1ZElZUEFkSXJvZGh4dG96cTF4NW9SOFhMamF3VnZM?=
 =?utf-8?B?dDM3d3d1amJrTUtmZG1ycm1CUURDUFFleStxUGt4cUNDaHFzSHNISnNETS94?=
 =?utf-8?B?Y20rMTJaY0JVRktSOUpLUWRVT1BwZmsvL2R5bE5rOVdKeTlieHI5ZFBHQmpB?=
 =?utf-8?B?YlJ3bUg2d3JTcy81NE5DWHpYWDBad3ZrR0paRE1xVFRDdUlTUjBQUWM2UTdp?=
 =?utf-8?B?TS9pbDZ5QVNGYnJQK2tSUDlYMXZ1czZJemZnNTdMQkxYTVduN0xUNE1iSUFN?=
 =?utf-8?B?ZXdGZjl1ZElhMEQvQy94VVpFRXIxY3NFM0ZEZnFraXZWOXVvTWRidUxiZ01I?=
 =?utf-8?B?WlBYYU1FQ2FVT3lIWi9zRTZIeDFSdHF2SVY5TkZyVmxYU2oxUEtBK0o0QUVs?=
 =?utf-8?B?ekxaYXg0TFlvcjlNdmFhd1RIYXk5Zmt4WGZsRjRxdG5XMjlMZjZHblRMRXU3?=
 =?utf-8?B?L3g0NDlrcUhvNVg4WnNzd3FQdUVEZmNvcUo0b1FZeTgzb2F1Ukt1Z2k4L2xQ?=
 =?utf-8?B?UnZpREVrTzBsRy9YVjAyU1hzSnEwM2xXQm1lMndtODBSZFlqU0d3RlF4RlAz?=
 =?utf-8?B?engwVm5TNVFQME41UksweHFKSkJVZXFEbjd1anM4Qno2ckp6Z09GRy9hNW1k?=
 =?utf-8?B?aG1QWEIxZWFOMUJ3VDRRZ0dQbHhaR2lJcStSQXRuWVlEY3JZdEJxaVduSGhi?=
 =?utf-8?B?K3I1cmZ0bFNpYzBZNDBVa2E4eXUralY0elRCcDcwQm9hR056VWpYZXRjWE5P?=
 =?utf-8?B?cVhidzhvU1ZLQnRMOGhycG1ZbEhEWE5kSWFCQlo0TnVKd05qc1FCSzJ3R3kw?=
 =?utf-8?B?U203bVlpVk9JMHFBNTJ2UG53L2Q3Yy9vTU1zSXNwZlhSamorWXFYSkVYckt1?=
 =?utf-8?B?b3VwMGMyUGlYYklDQUlpa3AwVzd3WHRHRWFSY3BOem5PVUhHZXYxNUxRNm84?=
 =?utf-8?B?MWdHR3VaMzFiVlVnSEF6dUR0OG5OWWVyamNSSkVqNVFEZzVBWmErT1lFMWR3?=
 =?utf-8?B?Tmd5Qy9mZERXbFY1endDdktIazhFaVVDUFg1M2paMXRWM0FtRnRNSy91NGx6?=
 =?utf-8?B?a0JnKzdPTlQzMFZjd1V0M1ZGS3podDM4cDlWN1VRZEhiQ2RLazZFeGVZbnNF?=
 =?utf-8?B?bDM3Q3RIRDYyNEp1dFdzejFtMDM1UGFFSmFxeDBxcVdsRmNnVTEwc29jV1ZS?=
 =?utf-8?B?emVSSDY1ZUw0SHFUQmIwdHRRTUdlcHRmOWhDOWdkQlUwK1JkTmlrKzNQN01G?=
 =?utf-8?B?eURrdk9uYkJMN3VlQXdld254ck03WkZuVTZ3MEJ3MFNBR1dTdUxlTEZ1ZThV?=
 =?utf-8?Q?8wikIEIbw5w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnl0TitmYlcwZzRyTlRZQU54M2RIV1dBNEVDK2JQeFFGMCs2VVJNUUZja3Ix?=
 =?utf-8?B?Y0JEbHFSOU9JcUNXTmtkZ1MxdUdyS0J2eWQrb25SbHJqeWY3Rnl5aGh0dWp1?=
 =?utf-8?B?NUloVVZSK2h1SXNZblE4eTNwN3o3TlFLT0RUdVNyRDgzWHdOZmM1MVF3STVk?=
 =?utf-8?B?ZUtnaG01a1laakN5ZEdPVjRYdzErTFZZUzNrVkpkQWpRdmtWN1krdnl4b1pv?=
 =?utf-8?B?Yk1uVncxMXhJQW1Ic0lQajBMWHV4OXI3UDN3SW11bFQxTkpiY3g4cEUxZlRB?=
 =?utf-8?B?cFZjeC9YZHJCMzlYMmVpMDBvNnRCOGhuL0RaWmZiaXFvMTh5UHpLQTFMYW8x?=
 =?utf-8?B?THpkTFBrU2JVT3VjeDdtdC9kZlJoZldiZ05Canp4NTZYKzFQOFNsQ1BFTFBU?=
 =?utf-8?B?RElwRnozbWp3WjRuci9hL2RhWnJBWW1zQTFUSjdnVzZzbmNQKzR0TThaZmVR?=
 =?utf-8?B?TnpZYzFwR1RoMXJzckZQQjBDenVON1dNYllQRm4xTDhNUWpseVlFUjNLUXhW?=
 =?utf-8?B?bEFibjlNbCs0YlpJekF2REFqOXZjTHRFSVZvZThzTnNsY28vejRmMkNMQUlU?=
 =?utf-8?B?ZWpsSitnL1BNblpJLzFkZDFPb2MvS3MwNVFOdEtFZXNUL2kva3ZPSjZIUXEw?=
 =?utf-8?B?NWw4UTVYR3JFdlhTVmFYTFk5WFVoQWZsdU1JUDhUUVozdHlQbm9TSTBxR2JC?=
 =?utf-8?B?bS8ydDFSS0VTang3TjVHcDlrcnRDZ3FseDJZT1B3TmZYekwzZVJTd3ZEM1Jr?=
 =?utf-8?B?bGFwdzlFRkxXUEdldjFqMVNtbi9GanprQUpxS0Q2QmQ1L0xFZnRFQlFGT29R?=
 =?utf-8?B?aDJjRkdoTWZTcktWWS9TNU0xaWcvMUkwV0xjZHh0K3gvNitqem05SjZsWGwz?=
 =?utf-8?B?ZzN3OVZyWTluSEZHSFhrd1EybWdlNFYzeWFnSXNHVWtUelZJQ2psQzVMdkFl?=
 =?utf-8?B?aFJpeCtmVW42MGxUbytWREQ1MWNiMldva2gzc0EyS2k1SW1GbFF5dW9FdDgw?=
 =?utf-8?B?c01XcUJGc2pWbm5Kem45RkMrOEVjdkF1cUVRTFlvT21XUjdQMDBtaHBPekwx?=
 =?utf-8?B?SzgrcWpvT0ZpQXp6MS9rMUhKVGdOM2FqcGY5UnpLeDVoZ1BuRWFtaVBWd01q?=
 =?utf-8?B?eFk5di80ZncySWtVRFdDeUJJb1hzZTlUSDFvbDJ3VkgxT1Z2SGVkdXNqYXVD?=
 =?utf-8?B?ckEzQmxRajJKWWVwaXl6ZUIxUllnUGtRRG5sYmE1R29ackl5MGdPRFlNMWh1?=
 =?utf-8?B?KytQMk4rcW9IV0ozSitrWmx4WUtEbHhFRi9wUld2dXVadGJ0emtJRk5hVThZ?=
 =?utf-8?B?VXVNSmR5dmlIUmprekE1amp5WXFTQkJEWVE4VDdlL2l6WmFuSW03ZjdYbGg2?=
 =?utf-8?B?V3c1ZENuNEgrdTh4cnJ3QkhmNko1bDBZMFJxRHFyZCthUlJQUjI2bEpoeXUw?=
 =?utf-8?B?VlhrTWJPY09mRE5JZnRrQldKSnhMa2dQOWFPa3FDRURObStMOFdQd2JPeFh5?=
 =?utf-8?B?UkY2bm1STW5obTJSZGlPNVIzY29zTjNHZ2F6ajE0ZjhNSERoVlZSZjYxc3lV?=
 =?utf-8?B?dmQ2cVlEVGRDaC9mdURVM2VrNHlpdng0bnRvNjkwa3JBVVBibkM0UjU5SmRr?=
 =?utf-8?B?azB0SXRtTTVtcEVWQzlkZDZtazJiQWVkd1lMaDlaUHorWXoybnNORmtJOE03?=
 =?utf-8?B?cFNuc3A4TUhmSERFNTR4ejIzeUJnTVgzeThsNjFhZEh2Zy9KSEpJQ0Y0TW5Z?=
 =?utf-8?B?QnhOYmtPNnJPbDRJSkZMbGV0bCsrakdubEpJSzRBRlprQTgwNEttbVRhTHE5?=
 =?utf-8?B?OURsMlNNaTRvYXExci9XZDhIM3YreGNKdHpPVDN2QnBrQzN6MGhHcW52cGFJ?=
 =?utf-8?B?L2RxZlAyZEY3NUwxRks2NmN5VU5QMVdLVEVxeDF2YTk4bGY3dTE4ZGkxMXNi?=
 =?utf-8?B?QXNEd2JtSjhzeWUwek9IWnBsTm1RRlV5OHByL0h2WEtOMW4ybUtRUnJ5WHFW?=
 =?utf-8?B?QXJEdXRIZlk5S3h0RU1CNlRlbTA3Nld1aENiRDRxOVo5YUJtYjI5dUdpTHdF?=
 =?utf-8?B?eW93RDcwakhzT214V2tiVVNCRGVNU0w0U1Nqbm9iVkNFY0xMcmdEaGdWWlg0?=
 =?utf-8?Q?jEgg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4a5337-d23e-4a45-af9a-08dd3001d258
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:30:54.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LawmR2sXBPeMtjMxlOV5AOBDSGpDhp3NRxMlWiNUZWIQWeliGcNXu1PMJ22+UiNA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353
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


On 1/8/2025 3:16 AM, Christian König wrote:
> Am 08.01.25 um 09:56 schrieb Jiang Liu:
>> Function detects initialization status by checking sched->ops,
>
> Where is that done? Inside the scheduler or inside amdgpu?
Inside amdgpu set ring->sched.ops to null if ring's scheduler init fail 
since we use ring->sched.ops to decide uninit it by drm_sched_fini.
>
> Regards,
> Christian.
>
>>   so set
>> sched->ops to non-NULL just before return in function
>> amdgpu_fence_driver_sw_fini() and amdgpu_device_init_schedulers()
>> to avoid possible invalid memory access on error recover path.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 4 +++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 510074a9074e..741807a1fd2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2857,6 +2857,7 @@ static int amdgpu_device_init_schedulers(struct 
>> amdgpu_device *adev)
>>           if (r) {
>>               DRM_ERROR("Failed to create scheduler on ring %s.\n",
>>                     ring->name);
>> +            ring->sched.ops = NULL;
>>               return r;
>>           }
>>           r = amdgpu_uvd_entity_init(adev, ring);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2f24a6aa13bf..b5e87b515139 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -656,8 +656,10 @@ void amdgpu_fence_driver_sw_fini(struct 
>> amdgpu_device *adev)
>>            * The natural check would be sched.ready, which is
>>            * set as drm_sched_init() finishes...
>>            */
>> -        if (ring->sched.ops)
>> +        if (ring->sched.ops) {
>>               drm_sched_fini(&ring->sched);
>> +            ring->sched.ops = NULL;
>> +        }
>>             for (j = 0; j <= ring->fence_drv.num_fences_mask; ++j)
>>               dma_fence_put(ring->fence_drv.fences[j]);
>
