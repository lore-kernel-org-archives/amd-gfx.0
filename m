Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BB8E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 12:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB6310E261;
	Fri, 13 Dec 2024 12:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7wWuO/Z";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF5A10E261
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 12:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUOae0zxH0cGFnaDhKdkPl0IC8PlJtgz6BV+Z9wpL+CIsLPbPFDlPK/6xq7bqemvTewQjkuegdkk+p7kEa7TB8Nwc96zmoZCW45GA6mw6mYXVtQ4NbEC/6SkHJPjcBL6Upg4VJOcKb3dU+1fsFygU7GJ1RNpQG0sn00b2WZLcq0uveDojHuZDXpWz4VdxnnTpF4vx+lTgFPgUmSftEmnAtCVld99rSqcyd5OnRk4lsSLeTYMARypn+lf6JLA4kS0ueTuPvZiGDygXGDHklUDvj6B/bfB+naAKHbm6IT5NgXXdLSsi7R5cujJ2vEYTMUBmAvgPD2JzSQl0vmxX3+yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iftqx1Qq8BFWQ12nR+1ISumqb/eatu9trUQ4ESS7+0s=;
 b=FMr/EcRQPIVyITfFKwmQTtQPj/QUV4tFaa5RiBeRrVWKHJKYZat5pDJ6gTy5n4cphS4KAZqz4b8HxSeYtbDxSte1ibBC/QUVkJKUjnEDiLiuj8jgCrpLLe1ZHv8tom3ym7ojQWU8/LXy0rIv8pzESuDau5mb0TqzHmxjAAIbmRY5otNmJmJU4jNlP1sBhciLD6yUAPPRC5iNt2L/yWkTeCT1fhC1Iiu5TxBS6Coupbhjj+km3/T5bfWm7rfy4YJUp0zApjTSzhSlCXAip7jASYaRwLslBGdqH05vJ9HP2xeei1sPePAK3GpQBwIqoA3Us2wc+hCDoUGrPDNkpyjbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iftqx1Qq8BFWQ12nR+1ISumqb/eatu9trUQ4ESS7+0s=;
 b=l7wWuO/Z60AClAKp0cnF0MnTDmzwSOUrMOi1R7A24tK2SWSNqhZwBs13/6ShwXT8bUe9FmuDxCHsRRtkgSFyDywVNE3yIxaG5C+Qj+YQ1Ab0Tt9w21P+0l6BNGRRGWq+vKirCI5V6hB6a9lFr9a00s9R96M0vaeZJh5gnmxUTQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 12:59:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 12:59:08 +0000
Message-ID: <c4af4333-c310-4557-b081-fc4e1d3a47d3@amd.com>
Date: Fri, 13 Dec 2024 13:59:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
 <7699531d-31eb-4716-bcde-3b0c41707ee4@amd.com>
 <e4766f68-a377-42f5-a166-50493bcccd83@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e4766f68-a377-42f5-a166-50493bcccd83@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a4947-6ac5-4788-b5a6-08dd1b75ee6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEI0S2I5MGQzVGNxUU9jREMwa3gzSHV0Q0xYSGc0TUVsQVJreDUybTNIa3lL?=
 =?utf-8?B?YkdzblNLSzBKMGIxS1A1OG9TWUxZM2s2Y2xQbVczakFFWW1oS3JYS3RnUXdy?=
 =?utf-8?B?UEdmMGwvanc2M1FQMWczWDlDRDkxTW5DQzRxVWMzdVJxSVRkS0tZRUYxbXZ4?=
 =?utf-8?B?eXhXelRxMGpmMlBRYSt1VmUzR0YzL2g2LzNmVDQwL254azA4TkNWVENZa0l5?=
 =?utf-8?B?NXFteHdDMU5lUDNOR05Bek1tbUZOamlOVlVTMkQyQ1hoU1V1cGRHRFBEbmpO?=
 =?utf-8?B?RGdRQkkyaHJzSlJRSWx6cUJnNjFza1BmbC9oZUJQMGRUUGVwUkhpTGQ4em90?=
 =?utf-8?B?MFdPQkV4VzQxR0R1N3RZbm9DTkN3WmN5anZ3dzdveEdOWUpQUXVzMkt2bWg3?=
 =?utf-8?B?Q0dzeFZDOGY5VDY3YzBXUXBEU0tmYVlRdU1wOGJDYTFLNzd1Tlk4SzNaL0d6?=
 =?utf-8?B?NHZnSnF0S3MvWVlUdUo1Ry94U1lWL3pPbVl1RE9sMDY5bWRWS0dqbi9pUG1F?=
 =?utf-8?B?OSt0bXdOSkpoK2RCRnovaTdmWVpQSmtkUjdrUDhVcW42aU5NWDEyV1RkL05H?=
 =?utf-8?B?dlN6QzNIL0labHMzOVVVOUVDczFoZlVHbk1ldkFtcC84eFZSTjl1cHY3Q1JQ?=
 =?utf-8?B?WXJBRk1xK3lpR28xeXRFdFhyVzZjUmwxbGFRMWgyZVB5V1NrazcwOFQzeVRn?=
 =?utf-8?B?THlLVE55RE1QNXU2TzRUc3ZYQjBERDVOa2k1ejNDVjFxUHdGRzkxMmNCd2xt?=
 =?utf-8?B?VERveW03MVEwanYrVDVJaStydmloL296cjZqVytYSzB0NmZOSFkwdXEzUzc1?=
 =?utf-8?B?ZHVtc0RvckpiRHlMT1RGYmxTeWlETm5CejB6aEJtSmFKTVVlQ3FzWHdueXF3?=
 =?utf-8?B?Z1I0ekoxUWdRUFE2MWlQcUFQbUR4NnZ0K3FGUFJuRmg1N0VJajRJZ1FDcXNL?=
 =?utf-8?B?c21NOWY4SXVrSS9EdllPaUQ1RnVNaU5iUTZaTlpKVkFwQjk2djhFOG1PeVN4?=
 =?utf-8?B?NnV4b3FkeWFSVXcxaXc0am0zbkFkMVpIMncxcmhQVWtRWTJBbnZNT2xzSGZY?=
 =?utf-8?B?bnV0OHpOVVFlSTJpZUhIditEdjRiSGVYSnRUSThPTUpXd25ldWpHSDFmVEZV?=
 =?utf-8?B?VGh1Z0p5eXRSUGsramc0bTM0bEpFelhtOThrcUJwYVhkRkRBSmo3VDJOUTJi?=
 =?utf-8?B?WEF3MWJ6dmpGaS9MaWxDRXJjekkyZ0JHS0xLMlg2MzhiK3AxMHE0TmhBZ2Qv?=
 =?utf-8?B?RmZtY29aeWROai9mcXptbEwzd3plT0F2WmkzT1phR3B1ZEthU2hjVmtGdzFG?=
 =?utf-8?B?NE1sTUovaklQbjZNenM3OFE1WGFXK0FPVzBkLytHUXY2Y01rSFgrSjJNV3Mw?=
 =?utf-8?B?TUZzbFNKZUMyZUFOTjh5cUlRTGpkTCtiZmZvUEdaOTROdXl4SnVyNUlDa1Np?=
 =?utf-8?B?TWhSTXVFaU5qYXZLT1ZmbVdTYUNRK0hUUmthcGtDVDllMDVtQUM2TThUODdY?=
 =?utf-8?B?akU4TTZTMmwzTnpodWtGc1QvWTBuSWxURGxrcmtFQ3pCSDZFR0dYaXJ2Z1hu?=
 =?utf-8?B?R0hNYkV1SmcxaTBER1hpK0R3NWxMdnVabGNOYjNvdXk0S1FoN2g0dGFKaWpI?=
 =?utf-8?B?UGtTRXdkUzB1TmlNOFd3b1hiYjhBaGppdkk5YTZ3V0RtejhsNkhsbHVIeldu?=
 =?utf-8?B?NmdqNk9Xa1pLSE8yODJqUGZjUkt6REZnRDE4emtxWkhML29vazJpbmllSFJk?=
 =?utf-8?B?eWMrNFdNM3B6eUx6Zk1mVm1zcWtRVklKNko0RzRkMWhpMEdwTmN3ZXFob1Rn?=
 =?utf-8?B?bFFwM0traXNQQlJzZnNhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9HanAvV2pSRWdwNDBLK3FqRXJ4Ym5EZDZYbVBhZEd4QnlualhoandWMXFX?=
 =?utf-8?B?aXI0UkJRWG5Dd0J3KzFsWkowN09oVFl6bmpQeEFrWUNzdS8vNHc0cDlNTjZN?=
 =?utf-8?B?eWFITzhwY0JHcXFWT1NhbEpuNUtaSXRjRCtZWTRpelo1d2s3b20rTTZpWm5m?=
 =?utf-8?B?Z1lZYjBhZkRBZ0V5N21BT0cwUWNBNkhtdFp4bTJpbnlkVHVHQ2hlMWs1U0da?=
 =?utf-8?B?VWpqSmU1OXUyL1VSS0xtMXd0UFFWVmdIWEl3R1ltaWY2ZVNmTC94ZU0va29T?=
 =?utf-8?B?TWtWcGk0SU1UV2U5d2xFTzlSVWpsYU9xckxObHNUM09NcjZoN1NUQ1BxbXov?=
 =?utf-8?B?cjQ2WEthQ0QzUmp3VFFWZlhHa1BVdDdQTHcwbTdoekY3QUNTd1hnNFdDQmhD?=
 =?utf-8?B?M3dUY1crTy83Zy9MTFB4WHdXUE9YRlVzRW81ejducTB2YnZEZHZwcVBCUys3?=
 =?utf-8?B?dlIvT2psVkFEd0pIUEd2T3BuVHRaNmRGL0ZoUlJBT0w1N0o0QTA0M0tnMlNj?=
 =?utf-8?B?TG5RcDhhNkhESjRibTIxMmd4c1hpa2dJZ0VPS0xGZ25jTy92Q1l3ekRoSzJv?=
 =?utf-8?B?ZElRa2ZaY2NkUFl0UEZLd0YrY3A3RWRjL05UWEJLVXdVeEsyZkcrYmw5Yi85?=
 =?utf-8?B?RmNsMFYzenloM3NFS3MvZUt5RVJCbFo0Mkk0OUlMbHN1RW9ySXNxOUpDTHBm?=
 =?utf-8?B?U3YwdTF0blp6TklrTkw4OGRrMFA3QVcwT0dYeGRUZlZIeXZOMmlmRnZFOW1l?=
 =?utf-8?B?c2VvTDg2cFNvdU8rbW9iMmJFbk90NFNFNG04L1pjQ1RwWFM2K2s1dlA1UFBP?=
 =?utf-8?B?VVU0OGpDSDRQWVMwQ2xMWlc1NGdZdkxVbzJrV0IvNnBGT2J4M3IzbnJlUnpL?=
 =?utf-8?B?ais3QUgxUUcxbVNVUFlMWGtjZFJOTHZGdXpoZlZNbUx2NmxQT09FT3JjWG0y?=
 =?utf-8?B?RUlUMlgxK0hnZlR3N2hJNUdrSVB0OXFmQ0RCQ2VzU20reEtwdXltN0RYWGRo?=
 =?utf-8?B?Wm83M0lHb0pvazNobTFtcjIrTkR5ZHZJemRJNmhiNFlNdWdnWXZpSXBQNmdZ?=
 =?utf-8?B?RlR4VFEyOUI2cUFBZjloRFVDR1Y1K0NKclkwbzlDcUtMZW9FTGx5ZlhFNzJY?=
 =?utf-8?B?eWl3MlFWMlpkSlFMczdHY0Z6U21XaHNSUlVZU2libzZsalliNlpJMFJwVjJn?=
 =?utf-8?B?U1VYQXhHOFNzaDV0b2MvNzBqY1JkTnF5VG90Z3lSZ0RLQVNBbFJkelhFSUZw?=
 =?utf-8?B?MXU0TkIxRm9SQzluZHNNd0VIaS9rdG5vcSsweCs2THl2THpxaFZscE9JMUt5?=
 =?utf-8?B?MHFWbVpuWlF3d1ZkQW95MEdwUVZNWTRjVHZFc3dpLytjUUxqNGpFZVp1YTkw?=
 =?utf-8?B?Z0QxamliYXBKQXcxU0xHKzBYR2pUR3A2REQ2cnJrb2ZweHlLNk9UcXh1U3pU?=
 =?utf-8?B?c0ZVL1NETHd3Nlh3WFd0T0hxNDVkejVMOUYyUHNsY2thQkRFbU56ZnlhRWYz?=
 =?utf-8?B?L3RBcXNSOGtualpocnVUY1BsTHhjSjFSUzROU2pQc1lmWjdkNlJaTVZUZ3N1?=
 =?utf-8?B?VlZoUEFmREZ0SU5tRWZEcFVka2t3bnFhL2J2eDJEVXpZaktldHA5aUNOWmhW?=
 =?utf-8?B?cVZUZFJHUEZJbFE3N1ZPYTNvYWRVeUxOOHpSaXVJZzJRZG1YeEgvUmJzdWFD?=
 =?utf-8?B?dFZDa3R3Ukh3MVhkT21od1ZTdDF5Mkloc2VmZjh5YXZ0Y3o1L3ZONEp1bDRp?=
 =?utf-8?B?OThtTDY2MmRuNmRGdlQvWFRjNE5QOXZ5enRIM2NDZWZoYzBtbWJ6VThHQ3Zo?=
 =?utf-8?B?bXF4R2J4K2J0MlkvcXhCMndMNVBJNmdrT1QyTWpVVTQ0T1RwUHdYNFJoTm9h?=
 =?utf-8?B?K0E5M215QWszMG5nMXNhZ3NuZWFxQ1NpeUNzWTMybzBqSGQvNy81VzJHRHVL?=
 =?utf-8?B?UzBKa0xYQUJ1MHc1QldPZjlLOXppZ2tzaFBsUzBpekM1SzBKSWF6RDNUdzcv?=
 =?utf-8?B?ZFFVRlNjYTNDVWpUL0pVSkJsMTFXS2ZDNktnUElyVFl3TkJDblVTblhIdWVv?=
 =?utf-8?B?TGlGYzBhRjZlcHFPNkZzSFpwaFowUWYwd244NUIwR1pZa2NNOUwvOUkrdjdU?=
 =?utf-8?Q?GiLz0PpNaPHcZApzHWOMOiLu9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a4947-6ac5-4788-b5a6-08dd1b75ee6e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:59:08.3841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMJEwy1R3VIjZz/aE38vQdkp4mr2awkOtOXCcLWhOmn+7wJyUX6zQD0q0cJFUWby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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

Am 13.12.24 um 12:24 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
>
> On 12/13/2024 4:13 PM, Christian König wrote:
>> Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
>>> Fix out-of-bounds issue in userq fence create when
>>> accessing the userq xa structure. Added a lock to
>>> protect the race condition.
>>>
>>> BUG: KASAN: slab-out-of-bounds in 
>>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000006] Call Trace:
>>> [  +0.000005]  <TASK>
>>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>>> [  +0.000011]  print_report+0xc4/0x5e0
>>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000405]  kasan_report+0xdf/0x120
>>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>>> [  +0.000007]  do_syscall_64+0x4d/0x120
>>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 3a88f754a395..49dc78c2f0d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>           unsigned long index, count = 0;
>>>           int i = 0;
>>>   +        xa_lock(&userq->fence_drv_xa);
>>
>> Don't you allocate the userq->fence_drv_xa after counting the number 
>> of objects?
>>
>> If yes then you need to drop the lock again for that.
> We are allocating  memory for userq_fence->fence_drv_array using the 
> kvmalloc_array(),
> should we drop the lock for this memory allocation and again acquire 
> the lock for
> moving the fence_drv references from userq->fence_drv_xa to 
> userq_fence->fence_drv_array
> code block. Is this correct?

Yes, that should probably do it.

Regards,
Christian.

>>
>>> xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>>               count++;
>>>   @@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>           if (userq_fence->fence_drv_array) {
>>>               xa_for_each(&userq->fence_drv_xa, index, 
>>> stored_fence_drv) {
>>>                   userq_fence->fence_drv_array[i] = stored_fence_drv;
>>> -                xa_erase(&userq->fence_drv_xa, index);
>>> +                __xa_erase(&userq->fence_drv_xa, index);
>>
>> It's *much* more efficient to release all entries at once by calling 
>> xa_destroy() after the loop I think.
> sure, I will try with xa_destroy().
>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>>                   i++;
>>>               }
>>>           }
>>>             userq_fence->fence_drv_array_count = i;
>>> +        xa_unlock(&userq->fence_drv_xa);
>>>       } else {
>>>           userq_fence->fence_drv_array = NULL;
>>>           userq_fence->fence_drv_array_count = 0;
>>
>

