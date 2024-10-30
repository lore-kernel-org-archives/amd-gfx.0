Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4580D74963
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 05:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4154D10E27B;
	Wed, 30 Oct 2024 05:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZQRVPpp";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A591010E27B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 05:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0ZKNOSk+enZdA5MYRFgbV6FzgalegG5oWHVP8GuSc8GdnY2c+MVvvuOt5saU5rKKG9TQFXrup7+dzgbIa8ipt/fGTpl8DtL4o2NexLFV9O5QdF4vKyjM3xtL4LiirscCRBHXy6GjcCMbivQET7YJQsjhjmBEgPNpBZCFONOEMOPXomO73StvuSkkdOYHpoeZu5MlGi3UVcuA+PiuY90BDa9s+bxxGMil7M8ohISvMyQk2MJeGakY1yQSTD1nTVqLJRfjkG7LFwtybcK8CmT/U/Ol4050/g8rRy3PyXerspeXt2VzNIY3puei23+fHxyi0xrTR/X0si4naPlXy8OJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m74LoZshRL7L+9Xir3fGAnhWmqTBbTEEXLFiXZ7lNQM=;
 b=Jwu8KVefteZvu2tfxfLbT40Z1tevx6bpv99MNMB8w+lDcGGGYaWh2S8VHKJSMtK0/+23HEDSDKpnrYByKi60Jl5NL+m0cs3UVPOlBWJwD8ADXMDz4fTIdiO2QKVuorq3oJMREBmB4UbhWF8nPjNYFDUMCvZF+p/V+hXbxPFXkHBxBy/UAC8pRiDxyM13yA9MueNoaX7xK6zWLBZpmhuqc4qu0xqRR5Oqt18Qtf2ouZmjJpT9Ou5JYNY3C2hox2E9sjeI9DJg7yO9zvLR3qJOSbKwOfFMmtXKrQ8vzV01tjysRLJtMUvOhrND2wWeHG+Nqamq0XcyWBgWlrWnjNqf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m74LoZshRL7L+9Xir3fGAnhWmqTBbTEEXLFiXZ7lNQM=;
 b=tZQRVPppqrufhcVoayu9XSnzC4RaVFzHKRxgUQ/kXrIxll8N13v69PD9gZYxa7F6pI424hsLYyF8MYcVP8mrVrJlg6VPcjC0GU7bLOzVSEUvJJEHjPOXvFM9KwtZ5QFbWw8W3N06+TbxLYFFhV7ls3Mo4n68Wh1c8u3vyENHIgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:43:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 05:43:14 +0000
Message-ID: <73326a54-7466-4ba9-8512-d3eca7e3a1ad@amd.com>
Date: Wed, 30 Oct 2024 11:13:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/pm: correct the workload setting
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20241030052546.45020-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241030052546.45020-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e05eba-02ab-4d75-a342-08dcf8a5bf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amJvK0xwMHhDTTB2MWl5RklyUEgwTFZJOFJSbzhwRzgyeTlIWWgyUmszekhK?=
 =?utf-8?B?NFVGQVVHMzh2N3dWcHdTa1dqNWVUOHJmRzRMMUwzR1VIYXd5TmZmSzZHOGV1?=
 =?utf-8?B?R1U4akhaUTNPbUdJZXd0dVh6NkQwSTN4S0tTaEVqdG5hcEpwMTVRclZ4Qmdm?=
 =?utf-8?B?SHJyclFkZ01VbVVKZ295OFE5eExUenFPK3lOdXNsZGNZQW5qTlozeGVhb0Nu?=
 =?utf-8?B?OFVXZmtFSC9BQStQWjBwRU5YbG5QT2tZaC83VmprYjdsY3NxSVNQemZ1RDh0?=
 =?utf-8?B?dXh4ZnNaL0FwV0ZRVllJd0hKSHVyQU53OUxVaXFtckRQYU1oL1JaejFRT2xQ?=
 =?utf-8?B?SEFMV3Azc3ZaNXhsVE50cVd5WjAzS2p2dEtVVXlMZnVrMVk1NUhjamhzWmU4?=
 =?utf-8?B?WWFWeTB6QktINThPMFVORFYwZ0MwRnYwUEE2aWJjQTU3Umd1dnBhMmsvR3lw?=
 =?utf-8?B?dCtUTzZJbmpUOHE0SG9GeElwd3BMemF3SlhOQ056a2ZaSTMrQk5hQjVpZklU?=
 =?utf-8?B?VWo1M2NCV3ZUK0tUdHllOXRTTG9velhrbDRzYnpHTGFxbGt4T1k2LzBQbnEx?=
 =?utf-8?B?ZTNsdTdYb1dTVlZqS0tFWk8zRWpKemFEWE5UV1daWW9XaElxaXRSalB5VUtt?=
 =?utf-8?B?ZWc1TVoycHFWWmwvZ3hjM3hUWVRzaHR1OUVZNm5nUUJvUVB6aVFCKzErQkJE?=
 =?utf-8?B?NFdIQ1FQQUtFREdacnE3Q0NKaDhsRHd4SGg4VjJ4czJadFoyZmxmSk5qZ2JP?=
 =?utf-8?B?cThhanBNN0NiRnhPRTlqeWtXTlpzTll4RTNGa1dET2MvR1pKVlB3VncvMWJa?=
 =?utf-8?B?VDg4L1ZHQlVwRC9yZGFKbnJCbVVIS2lBSFlXaUZwS2RCQy9VeHo4RFRVcjN2?=
 =?utf-8?B?Z3ZLTmRtcmxlZlpGR3YxZXRubDE1NkdPMFFESkY2dlhXRDlOTVBidTczNjRL?=
 =?utf-8?B?Um5KNXVyelBDRXI2b1pOblRZbUZqMHN3Q1JwR3RVeS93OG5MZ1pqVVpkTVZz?=
 =?utf-8?B?ZWd2RU9TNjQ0ZjRqNGoyNGlQQk9ZVnFnek9IdVJ6c1Q3TncySkMwOExxZXVo?=
 =?utf-8?B?UUpjVGVxWlRmazFQd2xlQTJ5YjFmaXg4bUR3RVlvWXFsK3dDWUFZdGZSQlkv?=
 =?utf-8?B?MjdDRnBsa2gxQ3F5dlVHREw1blA4b0Rvb3A5N3lYYmVUaktaRFA0Zk5PajJs?=
 =?utf-8?B?MFViWFMvV3ZGVVNkK2RmVFpHTUpDTGdqUFQ4OWorV1BOWTFhOWtzdkc1c1pI?=
 =?utf-8?B?OXk0YnQxT0VhZkpqVnlDS2cvTTJwQ3EzUk1NWjZmUGo0c2s5Y2E3L1dGaTlL?=
 =?utf-8?B?RGkyQmtES3Noamc4VUNGRmZ6VzV0UWl3YWNuMjhzOFZydExOK0FlalVCUGVj?=
 =?utf-8?B?OEVkdG51QzV6L05MYlFaY2F4SEhsbVhwTGpnT2hlR25UdkQ1MUhDZkdobUFi?=
 =?utf-8?B?MldxU29BR280YWJwcHl6S2oyR245Q2dCYlYrclZON2pCeW1aY2Q2cWRPVWlr?=
 =?utf-8?B?czNubFowNVlXT0VmR1grdEp2MCt6aVZ4RisvUm1pZWpPL0htV2lYUnpuYVBi?=
 =?utf-8?B?eng1c0t2ellZVnUvWTltTjduR2l3Vy9HRXBQdVFzVVYvbDhBVG1ZdEUzL3FP?=
 =?utf-8?B?Q3FyZytQQ2RpamtMZGhGTkcxK01zSFFhbTV4TEtrb3BzdnNJYmJ5d3pVbkNN?=
 =?utf-8?B?WU9na0lkZ1NaWnlMS1Z0VHU5dld5SUFRaDRZT2JXemxvMDlZL055L2l6TEVZ?=
 =?utf-8?Q?2gBtX8mIMTu33ayBnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xTcnRncmcxb1czYjdBN0p4K2N2SDR2cFRTVElnMUNXVmNMcmZMYlVOUXAy?=
 =?utf-8?B?MXRqTlpheWNoRHViZ20yd3I0ZEFSZ3FoRDJ3R3hYbTRYbVRLVUhjei85UE8r?=
 =?utf-8?B?Q3duQ3psZU50Y1o1T0F0Z3hidE8yZjN4aTAxMWdONmJkWlM1TXNVRFFnN3ZJ?=
 =?utf-8?B?UzRpOVNlY1VzaU45ZURGdE9vMUhQTHkyZzdRSDdpNHJ3eGZXeEZjR0swK1Fu?=
 =?utf-8?B?Q0l1cS9QYjU5R3pCQSs1SlRSbTlyTzFSOExOV0Q5WnZBK0hrYy9pbWVuamQz?=
 =?utf-8?B?WWlOdFBWN3c4eFk5aDhSaW5ONnJudmh0dnU4RUw0UHkweFUvV1p0cnJPbWVa?=
 =?utf-8?B?TXRma0pmQmh0amlTN0dKUmNhL1FqMlBPbWxrcWorMWlHR0t5UDNpL2NvcVhZ?=
 =?utf-8?B?cXpYZ0xFUVZwVy9WNUVGd2pRbkhkYnk4YUFpSDEzTHhndFN4eUtKcm9Ud3JC?=
 =?utf-8?B?YS8zMUt5OHcySVhTMnhQZXJLSy92cTdjQThLeXkwM1phd01xL3l2ZjdOM0RM?=
 =?utf-8?B?N0Zva3ZDN2Y3aXVrNmhXdkQwZStKNGdnVjVObSt2bFhjYk45QlZndFBuRFEw?=
 =?utf-8?B?RUgrbmg0Z0hnZVUyN2d2ck1DVTZPNmtGMjl1SXFsQWh1WE1QWjFpekgyQ1Zw?=
 =?utf-8?B?WVlWOU5xSXd0YmdXelYyZC9PUmxTZDZxa2VLUFBudVBhNWpQWnA3c3VjZnpH?=
 =?utf-8?B?MGJWM1k3am9SQU1HeXFJc2cybCtyVnlyV0drZVY3azE1WEltZGkxL1JkMTAv?=
 =?utf-8?B?R2pTdHcwMWJ4YlBXeE5OWjV5M0Y1enZTMFk0YkxOcWhIOW9tS3ZadGFVdlUy?=
 =?utf-8?B?ejJQRGpBVmFjaERYb0tnK21DUThTT2c1S0s1eHZNY0tIRFdITFI2bkg4YVgy?=
 =?utf-8?B?eTQyeEpQaEZna21WQTR2ZEJ5Wm9SN1o0bDM4cUszRDFTZFJWN2xPMlB0YzRH?=
 =?utf-8?B?NDJ1NjVRWWt0UzZjZVVQUSthcmtBQmV2NmlnQXg1ZGxFcllzS3lWMzhBSDhn?=
 =?utf-8?B?LzRhNW5nUm1VZjVsTmdPa1VjdEY0dkU1bysyT3NUQXZOZ3N4RkVuMzF1N1BI?=
 =?utf-8?B?dW1mNlJ1U3BMdnVHMElxaFFPNXRpQVRQd2JYb3RVY0szKzhBM0lwZVoyRmtt?=
 =?utf-8?B?b2FNSDBhdndRRTdYTVhrbEVLVVNYbWhnMzIwNjVBZWNtK1RFa1BzRHRYaVZz?=
 =?utf-8?B?RnZ1ZkR0RGpiSDdjOXcyOWprbFhEY2tkOVlOdDVIM1JZeTZ3M24wdC9udmhH?=
 =?utf-8?B?UGRHRzlKTGxBcFhYYmdtTEhEOWtKMXBCc1o5NEpBR2hvN01tQ04zLys4SGtr?=
 =?utf-8?B?S1dBbjBWZ1Nzd1ZObUdaWi90eWx4a1dWNS9zcGRXb2o2VzNzendXaDRlS0hx?=
 =?utf-8?B?NXBuRnNjR1Y5Q1FBSW5zZ0t0QW9wMlFuTmMzRXpZQXRzcDM5WjZ0T05MeDc3?=
 =?utf-8?B?T3RGVEY2clQ1cFhMRWJmTWRsaUZDZ3E4YmhUYWFHbElXMW8wRVZjMVZHUzJy?=
 =?utf-8?B?NUtkcFNGQ1BtSnNHNE1waC8zT1MzSHZTbDJQejlxcmptVVVoY1dxRE1EV3NF?=
 =?utf-8?B?cHZrOHhnbEI3Y3hwRVk0S0NRTlZoZFFxMkY4VWlUTEdpS3dqRWVoTEtJRDFR?=
 =?utf-8?B?bHV1VFZsbnNIZ3UzTk1kUldhU1ZpU2d0YTJrQzhnWFNpaXNoM0s5NXNoK3hs?=
 =?utf-8?B?RmlTUUR5TXkxYis3bGJ4RVdXYkJlMFJ4REUydEllQzZOUUQzTWtSMVZUeEtL?=
 =?utf-8?B?NXBTVkdVWEZpL1UydHpDVnFzVW9DckxBR09sVXhUaElmWmVYMytubXpnaHp3?=
 =?utf-8?B?L3dRWlRmWnZBbm9MU3VXa1BTZk9Vc3dsVE9LdlhtY2VSSjlFRGprbDdNK2VD?=
 =?utf-8?B?OVV6cjQ2U2Vma3FxdHc5dHNvTnN3MW5CK2ZFK29mMFRvcXYwcFZoV3hGKy9u?=
 =?utf-8?B?S2t5RS9BblJJbXFSR0htTDNRYVZPZC9QQU1Xc1NUVU44eFJCRjUyQnBHR0o1?=
 =?utf-8?B?MWZNOEJrSklkVTFnM0FvelRsMUpQUEJjSUI5U0N2QnlNeFE3UjAxS1F0SUJo?=
 =?utf-8?B?dHpiV3dxc2pyeHdseWE3N1NCa3FLT0FSUEJFU3dLcDhGTVZ5QkZMeFR6TVAr?=
 =?utf-8?Q?gYtE2CpHa9E3d4W3oA65mZtbA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e05eba-02ab-4d75-a342-08dcf8a5bf17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:43:14.2946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM0RNb+gy3iZ425fCZQBmEaxksNrNa5Zgb4R1GQKU5aMWW/bpuNXWY7RVx2fpu5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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



On 10/30/2024 10:55 AM, Kenneth Feng wrote:
> Correct the workload setting in order not to mix the setting
> with the end user. Update the workload mask accordingly.
> 
> v2: changes as below:
> 1. the end user can not erase the workload from driver except default workload.
> 2. always shows the real highest priority workoad to the end user.
> 3. the real workload mask is combined with driver workload mask and end user workload mask.
> 
> v3: apply this to the other ASICs as well.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 43 +++++++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 ++-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 19 +++++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 23 +++++++++-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 23 +++++++++-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++-
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 ++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 31 +++++++++++--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 25 +++++++++--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 28 +++++++++---
>  10 files changed, 202 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8d4aee4e2287..7d7bf44c4496 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1261,26 +1261,31 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	smu->watermarks_bitmap = 0;
>  	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	smu->user_dpm_profile.user_workload_mask = 0;
> +	smu->user_dpm_profile.prev_user_workload_mask = 0;
>  
>  	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_prority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> +	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
>  
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	else
> -		smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> +		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> +	} else {
> +		smu->workload_mask = 1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> +		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	}
>  
> +	smu->driver_workload_mask = smu->workload_mask;
>  	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>  	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>  	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> @@ -2354,12 +2359,14 @@ static int smu_switch_power_profile(void *handle,
>  		return -EINVAL;
>  
>  	if (!en) {
> -		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
> +		smu->workload_mask &= ~(1 << smu->workload_priority[type]);
> +		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
>  		index = fls(smu->workload_mask);
>  		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
>  	} else {
> -		smu->workload_mask |= (1 << smu->workload_prority[type]);
> +		smu->workload_mask |= (1 << smu->workload_priority[type]);
> +		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
>  		index = fls(smu->workload_mask);
>  		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
>  		workload[0] = smu->workload_setting[index];
> @@ -3054,12 +3061,20 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> +	int ret;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	return smu_bump_power_profile_mode(smu, param, param_size);
> +	smu->user_dpm_profile.prev_user_workload_mask =
> +			smu->user_dpm_profile.user_workload_mask;

This prev_user_workload_mask is not required to be saved. The check for
current mask to be same as that of new mode can be done in this call itself.

current mode may then be saved to a local variable and then
smu_bump_power_profile_mode be called to change to new profile. If that
fails, revert back to the current mode.

Basically keep
smu->workload_mask = (smu->user_dpm_profile.user_workload_mask |
smu->driver_workload_mask).

Or, drop smu->workload_mask and always pass
(smu->user_dpm_profile.user_workload_mask | smu->driver_workload_mask)
to firmware.

That will simplify the code.

Thanks,
Lijo

> +	smu->user_dpm_profile.user_workload_mask = (1 << smu->workload_priority[param[param_size]]);
> +	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +	smu->user_dpm_profile.prev_user_workload_mask =
> +			smu->user_dpm_profile.user_workload_mask;
> +
> +	return ret;
>  }
>  
>  static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 8bb32b3f0d9c..88294d986b36 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,6 +240,8 @@ struct smu_user_dpm_profile {
>  	/* user clock state information */
>  	uint32_t clk_mask[SMU_CLK_COUNT];
>  	uint32_t clk_dependency;
> +	uint32_t user_workload_mask;
> +	uint32_t prev_user_workload_mask;
>  };
>  
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
> @@ -557,7 +559,8 @@ struct smu_context {
>  	bool disable_uclk_switch;
>  
>  	uint32_t workload_mask;
> -	uint32_t workload_prority[WORKLOAD_POLICY_MAX];
> +	uint32_t driver_workload_mask;
> +	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
>  	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
>  	uint32_t power_profile_mode;
>  	uint32_t default_power_profile_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 5ad09323a29d..c0ae36e7c896 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1449,12 +1449,24 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  	int workload_type = 0;
>  	uint32_t profile_mode = input[size];
>  	int ret = 0;
> +	uint32_t index;
>  
>  	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
>  
>  	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
>  	     (smu->smc_fw_version >= 0x360d00)) {
> @@ -1521,16 +1533,19 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					  SMU_MSG_SetWorkloadMask,
> -					  1 << workload_type,
> +					  smu->workload_mask,
>  					  NULL);
>  	if (ret) {
>  		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 9fa305ba6422..e929b882ce60 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2008,9 +2008,22 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -2081,11 +2094,19 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>  
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 77e58eb46328..9f6548039948 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1713,9 +1713,22 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -1786,11 +1799,19 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
>  
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 6c43724c01dd..ba8bf369d6d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1058,12 +1058,25 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> +	uint32_t index;
>  
>  	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>  			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
> @@ -1078,8 +1091,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  		return -EINVAL;
>  	}
>  
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> +				    smu->workload_mask,
>  				    NULL);
>  	if (ret) {
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
> @@ -1087,7 +1101,9 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 0b210b1f2628..6a18cb9b6e59 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -866,12 +866,25 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> +	uint32_t index;
>  
>  	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>  			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
> @@ -889,15 +902,18 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  		return -EINVAL;
>  	}
>  
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
> -				    1 << workload_type,
> +				    smu->workload_mask,
>  				    NULL);
>  	if (ret) {
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>  		return ret;
>  	}
>  
> -	smu->power_profile_mode = profile_mode;
> +	index = fls(smu->workload_mask);
> +	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +	smu->power_profile_mode = smu->workload_setting[index];
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 8d25cc1f218f..8c26cac6cf18 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2474,9 +2474,22 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
>  	u32 workload_mask, selected_workload_mask;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -2555,12 +2568,24 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  			workload_mask |= 1 << workload_type;
>  	}
>  
> +	smu->workload_mask |= workload_mask;
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
> -					       workload_mask,
> +					       smu->workload_mask,
>  					       NULL);
> -	if (!ret)
> -		smu->workload_mask = selected_workload_mask;
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> +			workload_type = smu_cmn_to_asic_specific_index(smu,
> +							       CMN2ASIC_MAPPING_WORKLOAD,
> +							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> +			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> +										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> +										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +		}
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 23f13388455f..2323c74ee50b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2429,9 +2429,22 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -2487,13 +2500,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  						       smu->power_profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
> +
> +	smu->workload_mask |= (1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -				    1 << workload_type, NULL);
> +				    smu->workload_mask, NULL);
>  
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu->workload_mask = (1 << workload_type);
> +
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index cefe10b95d8e..c2fd47f04e2d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1787,9 +1787,22 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
>  	int workload_type, ret = 0;
> +	uint32_t index;
>  	uint32_t current_profile_mode = smu->power_profile_mode;
>  	smu->power_profile_mode = input[size];
>  
> +	if (smu->user_dpm_profile.prev_user_workload_mask !=
> +		smu->user_dpm_profile.user_workload_mask) {
> +		if (smu->workload_mask & smu->user_dpm_profile.prev_user_workload_mask &&
> +			!(smu->driver_workload_mask & smu->user_dpm_profile.prev_user_workload_mask))
> +			smu->workload_mask &= ~smu->user_dpm_profile.prev_user_workload_mask;
> +
> +		if (input[size] != smu->default_power_profile_mode) {
> +			smu->workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +			smu->driver_workload_mask &= ~(1 << smu->workload_priority[smu->default_power_profile_mode]);
> +		}
> +	}
> +
>  	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
>  		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
>  		return -EINVAL;
> @@ -1857,12 +1870,15 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_SetWorkloadMask,
> -					       1 << workload_type,
> -					       NULL);
> -	if (!ret)
> -		smu->workload_mask = 1 << workload_type;
> +	smu->workload_mask |= (1 << workload_type);
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> +										  smu->workload_mask, NULL);
> +
> +	if (!ret) {
> +		index = fls(smu->workload_mask);
> +		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> +		smu->power_profile_mode = smu->workload_setting[index];
> +	}
>  
>  	return ret;
>  }
