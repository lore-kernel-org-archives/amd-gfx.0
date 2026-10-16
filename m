Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D9CCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 08:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3071126B0;
	Fri, 16 Oct 2026 08:43:12 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16E0112697
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 08:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW+PTCKmEUv0gTlv901b2SB2SWn5K1uZ9CA3dIQYKIXDcouEfj+AcNS5ZvKk8gQGSp+Us3l9lSRVAemV/QD7yYmwWN34wJLCjZLpFyt7+E8lbjOURXxhLNtWWxCzSjerOBULh+dJEL3FJID24u26KpIqutFCFOkCGBSjoSdgpJ1iysTOAirEwOaf2knnGKjLRtdthkW0k10UV8zrDCGfUiUY9xlJPCKsMbvNe+3iu14zoKzj+Z70T/xfPzFhkNO8CCw3QeQ+qzWivQ216V4MsWThW1088KrgcnRUK9W0PlgsUByFLw4EfyD/vpYSH3mUsoRBH2vW7cFTyDnjEJ0A5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLPMo8fx0l+j3bdJ/m4qSImMdSEzxVoKfHCuqE0i1Is=;
 b=oBvilNv6MSvV8XStkqW+vcHT9rgq7Joca///EkXw+vWYD5jgS/9cmVNthXsmJHfDKz8tcVZhuXOxPNiKfPvIQ5EBgAsMS/kmozvgc98WwLGeUWn9aGK1TEjdmykfgr0uw7cBbVrZ5uvGuUNQvrkxzkAaW97jhXrRIoeLGaMvxOzTNNRhYkD7Sbf3/GXN/jEzfMJIyzB9mVBL9FDtlGTVYQS093967dHFJF8ZR6sivRkCHsbXi2Hu7oX3HgC9gel7KHQlrYG+QXYP6kfLV2K0cccM+8ZB2LKg4MffjwS4JBviboTPKzCfWxTshUgYYk2Id5UILwWlF1BvgwiN3ymY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLPMo8fx0l+j3bdJ/m4qSImMdSEzxVoKfHCuqE0i1Is=;
 b=yPhxKx6I3kFg3bXDM3Le1oAVHpUWlQpaHburQO1wj3hOmmo6UCBnEd1/ZnrkSvW7p4hpk6FXSY4dhhd/nGjzAdrwGjNhMnizTJaxnkLbiEZducILRv7AoCeBQOSAu+Y1em01+wEaFyuZ+mmmSgodWl6mSYRUFSPE2NMnvIywLRA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 08:42:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 08:42:59 +0000
Message-ID: <a2b9e67d-fd7c-44fe-ad48-ce11a8bae4f9@amd.com>
Date: Fri, 16 Oct 2026 10:42:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] drm/amdkfd: bound SVM migration fence wait and
 guard with drm_dev_enter
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <62280d57-3f63-4979-9e4c-f0eca7208b19@amd.com>
 <20261015193018.86178-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015193018.86178-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e7e407-da82-409c-4c15-08df2b617b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|18002099003|22082099003|5023799004|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4t2t+b2rv2uaGRsqN0MztK9AVDUere87idPGoy16KQmPsYnXnANyROeKa0stu3N/FFGGeNAGfnNmobxV6NKRyvpCVQV7wkmWq43HRxFPcp0XVm+YePgfIGseTeSmL8lmMBIYOJCvgqjFD93VSbSjhrJrmrmkScgr/kyWPNv15ec5+ATp0wNvrNlVF+Ns/XC2ooIOhp3cOxpEcS3cvce6yZvWQMRcmRY70mA495Z4XxK4evOGo2nIwqgiArF4Cy/GQnSGSCQ9ezXhbTeZlneHHi8wj9Ea8cFvS4IAdfZBzc679x+YjddxahF0Sv6AjR8Mha3ixo4pTXJbdOQO4t7XJeOTGtR8C2N2C1MAEHkojyfj4k4dLqrMYU5TRKITiJRt/NR7VgERZxZRIfWMrTRImeRwnVcPnX/VVc15/YA0brUMksl5UJII56Z0HUeqhJzBEMzPkQvLE5lq3K1Y7+Uvqdqoyc3ZnNk6Cx75X9h1mzlj8PZApOOtMVY7MLrjOvInlNhngR2Jy9rPxNVmKBpvftcit02jQQncnrm+6USy6bAmlZJpglBT5SpsnK9zxyXbzCDpBt/0vxg+cLOIZd2Jyu8bKIdAfsvgZIn4bUQsQNnmBNuKOSYCc7pq+lipuwgo7IqaKzYq/5POl9sWfxgKKQDAEdVCsvC3QtmxDABm5jA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdkSHVZWGF3eVcwQksycHVyOTFxYjlpUEtBU0E3SHZkeEVUOG1kR3FmblVD?=
 =?utf-8?B?b1BjcVNOVk03NndNbDZVcHRnN0RWMXlvVDVsMERTZ0x5UlZQdzVUZ2ZVZ1Bq?=
 =?utf-8?B?NTVtTk9lOHdWMHZta0Z4N0pSOFp1NTY5dmUzVGE5S2kxZXNZQ0NGZTlIZFdE?=
 =?utf-8?B?UTljNnBaTlhnVVZ3am5xaHJFZ2FYaVFRT1BGTVFiU3lrdmJKeTBuTWxUZkw4?=
 =?utf-8?B?SUx1cDJ1eGJlMFJPV1d6b0ZHTGFockk2RW4wbUlpOXVMeGhrMis2Rlp6UU8z?=
 =?utf-8?B?YnN2UkhqcjIwa1FVeWtnSTlLNkUvc2VUa0t0bXRHaU9XNjloSjFxNW02N1BC?=
 =?utf-8?B?STg5K3NGK0lXWGF5RjlpYTY3QlhjV0kyM1dYSThlbFV2TTk0U0xCdXR0cmtG?=
 =?utf-8?B?dkdEOTd1bG9leGd3RzQyQk85cndmbCtMZ3JTdFVRUmFVYkV5TjZFVHRxSG1q?=
 =?utf-8?B?VW9KK3dqOU9nV0Q5SG5FaTNUZUpxd3VBTlVFWmJSM0VibjhQMHNXSHlPNkhB?=
 =?utf-8?B?UjFhTmYzZHl5WTc5MzBKUWUxZ080SHdhWUpHOHJKbWl6ZFByc0FOYThpZVlo?=
 =?utf-8?B?ZkNiVHRUUU9oN1NvRGVzWEpyV3FIbmdsRVk0QS9IMlZRZ2lxbytnRUVmS2Er?=
 =?utf-8?B?RmVLWVpjRVprMndrR1A1K1Y1eCtMZGt2ZTFoRzB0TmVtSmprVlZ2VVBwQnBp?=
 =?utf-8?B?VXp2M3VxYWcyNGhsaDR2THpaeE5hc1lzN3E5c2dyN0Jpc2JFUVorWFdKenhO?=
 =?utf-8?B?NHp6YnIyelZuSFlqQnY4ZmdiMlBqUXNLZnZBUTUyQ1dQd0p3M0JZQllDUFBZ?=
 =?utf-8?B?ZzZjTXRUcUZqRmNJVlVNYmoxZEFKWVh4dVhBZDdmUnI4bUdzT2cyM3JlYklt?=
 =?utf-8?B?TjROYXpPc05DUkhEOG1RWFg0bjFQVEp6OHhLV3BpR0s0TXB2QzZ4dmRNYWxS?=
 =?utf-8?B?YVE3MmlCdHdqcUpVTXJpLzZyQzFwb0g0dGIvVFhKNVNrMEVqdXRGb1JwdlZF?=
 =?utf-8?B?Y0Njd3NJZUw5ZnY1dnFXdDAzZGNka3NTemg4enVFcFRZYTd4MTEzZmNORjVi?=
 =?utf-8?B?WmptK3ZyeVJ2MGx4N0JGd24rbTd5TXQ1MHNBbm1yc1pKZGFuQkNzRXpIMjZS?=
 =?utf-8?B?cFVOdEcyMVh4MFdNMzRhUXNrM1FSM3ZtRCs3VURnUSsyaXEvQnJhaUp3ejFj?=
 =?utf-8?B?L1dzelRhamtocGxsUGhITjVaczE0Y05ONldFWjdSdzlsblBWb292dG16d1dN?=
 =?utf-8?B?SHMvdDNvMWhpaWpRUS9JNWx3Q0JkMXl2NHFPbVF4aEZibm1CUTN6N0hLcnF0?=
 =?utf-8?B?eERJWGl0ZlpUVWwzWnNXbE1HVm1oak9aK3NRRTRaVzNrLytVU1QyZGxmdW5O?=
 =?utf-8?B?UE9OZlBlUVFDaStaZkZtVi9lVTc1RWJtcGt2SldSQ2hlTWlwYWZESW1SUkMy?=
 =?utf-8?B?cGMwbXYzS0t1eitrbHdJeW12SFJWTHFHbGtRVTBiM3pQSzNSaXFTZjhnZm9u?=
 =?utf-8?B?Z1JJQlc1dFJsQWxxMjJOY1hOZExDa3R0eUJyQnVlaXZQZGNXUzc0dVJCN2FZ?=
 =?utf-8?B?RWkvZ2JVTi9saVhteTUrM1cwRFR0NGpnUmZrYnZKSkZva2FYeFhwZ1AwTWZO?=
 =?utf-8?B?SUxaR1hMTEFITXN0V2dlRjFKZi9nVkFQZ2pSdlNUK1o0VWpGZ2hWVE5TbTc4?=
 =?utf-8?B?aE9UcnRQNTRHUGpOVTBESERqdm9Jb0dKMitjZVdKeTN2VUZFMTFQb1MxQVE4?=
 =?utf-8?B?R2V5cVg4clBYbEVnNy8raFp6QmtQV0h2QWovQUdIdGlIYnBNQ0RUdW9MU1Yz?=
 =?utf-8?B?YUxBelVqR2tic29tYlNTc3dPbGx6VjA0MStYSTZQZkFYcnZmWDJYWjc4aVN0?=
 =?utf-8?B?M2d0WDlBeHQ5UFZSZmR1ektyWlU2MWI2TU1OTlVIQjduVXBLbTB0WDZSblhL?=
 =?utf-8?B?b1JQU0pvNzBScTNzelQydkw1OHBiVFJrTFBYMDF0bVM3YXVveVE4Q25SZFJn?=
 =?utf-8?B?dzVydTNtTVVyRUluVmhoa3Q5WndEMEJWbUx1ZlE1U0RLc0dRS0NSWGM2RHhv?=
 =?utf-8?B?QUQzWGVBdjJoWEk4NG1pT1RJcXlDdkw5REt2QkU2enJVQVE0UkZ5NTVHYXJr?=
 =?utf-8?B?d0lHMmhCYUZiVkxLY0xEZ2FGeXJGb0lqUENnYitDQ3FYQkpidlhqOFdRRUM0?=
 =?utf-8?B?QXl1d1NFVTR6Q05mVGpPaUFBODU1RFloOVRUMWovZFVTNzNRWWNHcC9UbkVw?=
 =?utf-8?B?YmlzR1Z2bTJ2emlaVjNwRm5OT2xpS1pLVldBRmlSVlB5Ylg4SzJ3czNzM29L?=
 =?utf-8?Q?CnVXA2M7NN1DmQdOks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e7e407-da82-409c-4c15-08df2b617b72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:42:59.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uslgoiCmkE86mYXoisLS44e58v34ob8f25NQzUF6dlr4Kh0zePm3jG+ycbCGMsVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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

Hi Olivier,

looks like my mail from yesterday wasn't send out, so re-sending that again.

Don't be surprised if you receive two messages.

On 10/15/26 21:30, Olivier Kaloudoff wrote:
> Hi Christian,
> 
>> Fences *must* always signal especially when the device is hot removed.
> 
> Agreed in principle — but the observed failure is precisely the
> counter-case. During teardown the dying process's fault path submits
> an SDMA job to an already-killed drm_sched entity:
> 
>   drm_sched_rq_add_entity: Trying to push to a killed entity

Yeah and that needs to be prevented.

That is incorrect teardown order in the KFD. When the entity is killed no further submissions to it are possible.

> The job never reaches a ring, nothing is left to signal its fence,
> and the uninterruptible wait in svm_migrate_copy_done() never
> returns. That orphaned fence is what kept the task in D state for
> good in the repro.
> 
>> a non interruptible wait with AMDGPU_FENCE_JIFFIES_TIMEOUT can
>> never fail.
> 
> The ret < 0 branch is indeed dead code — dropped it in v6, thanks.
> 
> The bound itself is needed for a subtler reason: the wait now runs
> inside a drm_dev_enter() critical section, and drm_dev_unplug()
> blocks until all such sections exit. An unbounded wait inside the
> section would deadlock the unplug path against any fence that fails
> to signal, for whatever reason. This is also the shape Felix asked
> for — guard HW access with dev_enter/exit and keep no unbounded
> fence waits inside those sections.

Yeah and that is perfectly correct. drm_dev_unplug() *must* be blocked until all fences are signaled.

> If you'd rather guarantee the invariant at the source — i.e. error
> out fences orphaned by jobs pushed to an already-killed entity in
> drm_sched — happy to look at that too, but it is a much wider change
> than the KFD-side guard.

No, what we need to avoid killing the entity while KFD is still using it!

That is basically an use after free what you have here, only that the drm_sched can point that out with a warning instead of crashing immediately.

Regards,
Christian.

> 
> Regards,
> Olivier

