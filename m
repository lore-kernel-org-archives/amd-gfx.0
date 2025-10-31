Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC03CCF9F0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 02:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E3210EAB2;
	Fri, 31 Oct 2025 02:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hsk457Nl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A2B10EAB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 02:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyJL8dERGyunbwbGdd6Fx4VMxgTu5wdyfnkdpVxpMl6HvbkcnPOP/h63m04faHuZ7iXdD81JI2uV+Sm+0rvd/6hK842WfW3nXgd06d8R+TMka8cxayvnlYthZodjeGMqScaiOvngwRBfsJJwdHBMjimOLnZQUQwtW33YWwHsNeAimB7po0vgMWFPuvNeZKYoSeNLi0dYxlePgUjwkx/REjxCP1Q9t+c4MsDqfuaYrbynsb381S4gTN4Q3CxaIAoTvJbPENNLzIaymfGbozcUaAJNyZ1mduSeGMYP95YXidHl6XzLhZO9bTeOs7Ayq2dg+gkjeHXibZyrunXyt+lwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlkH/E1R4Y+OQeeeupUbs1FM2E8hFAKt8gSRXQf+3JM=;
 b=bFaaTAHvzznzr6qez+jlE6ClxNh2KM1MAI47DMJePnsL6DFITSItsMUxA+aFdeqzEsjsJ2ojNpCsUAGdwAfynFE3m73HvvQNHMqBAtauWqFFMcvMDMweFOQtlP6nGUUQolFeywS4eIvD8HoA1MhLYqeZCuLc8w/UMaQaPHNoji0zrXiRGqxP0rjNgGxUxhyw4OEc1rzEgy7SUpioTsaSkEZS7pGmpFlQ2886oVX7MuOc35pxhUf1VH73Wo44CTH9jUvGtr/JfInbyxcha2JU/kFU39QqwsxxlzVrBiqqlvc4/OYnJNAPwkWt8QMaV81D5W+2M1g2KB1W7OZNRD4cug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlkH/E1R4Y+OQeeeupUbs1FM2E8hFAKt8gSRXQf+3JM=;
 b=hsk457NlzOAULHPo3pPtLc6H9+VsGKMsGcfIzZCjqZL83a/PqMX8Jopx/a0oqc1mLKGMNpJStV3bDEsFEG7KYntVU6CFrWiNRx+/46wMOd/giy674qW8PbdBG54M+GttZGcgBtXxad+mIXxuYLBDxSmK5KrEpRMXVCJqcv4urIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 02:53:47 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 02:53:47 +0000
Content-Type: multipart/alternative;
 boundary="------------HVPKoEBcyssNBvxIh5EVMVRb"
Message-ID: <bc281335-e4a7-4c3d-aff8-5e7dea08627e@amd.com>
Date: Fri, 31 Oct 2025 10:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: implement per process/device pasid in sysfs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, felix.kuehling@amd.com,
 alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251030034536.11356-1-lingshan.zhu@amd.com>
 <050ba477-c7d5-4420-8f06-6fce0db48726@amd.com>
 <052b10b1-00ac-4a2e-99c1-3433f2ea4513@gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <052b10b1-00ac-4a2e-99c1-3433f2ea4513@gmail.com>
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6b8623-73ab-4612-3feb-08de1828b655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QSsrc1BpMGJuNWhnZ0N3ek5ybm85eGJUanJ4KzV1R25BZTllQkE4VzBSWmFq?=
 =?utf-8?B?UXlyQWVOUndoVitFZG1samxERXFwdkRDSTNlZE5SMFp4UTdESHZYaGZhVjZz?=
 =?utf-8?B?THpnQXVxaWhHWHJlc01ob0ttSVZrZC9hc1NWc3lmMDZBcXFCVTc2eUxnU2hY?=
 =?utf-8?B?NEt4eGpSaTliaTlBRWpiTHlBR05XeUltVDFOdVc4YU1Jc0l2UjZDb3p5OXpO?=
 =?utf-8?B?S2VtOW1uNC9JSUFlc0lyWU16aWJpZWt6L1ovY0RKeCsvS2Y3UG5Pa21uSjBC?=
 =?utf-8?B?SnJDbUVtcnE4UGxNNFJSTklXQTlSZUpvcEJ3b2s2Z1h0L3pyeHNxcHJHL0Ro?=
 =?utf-8?B?bUppeXhRcUF4Mi9GaTRxdkIwZDNuR2pDRm9CMWp0WnJHbjF1TklveW1tRzAy?=
 =?utf-8?B?ejdIbmlwWFMxNVI2QTVRdWltSkk5aDhIbFZnL0FhRm5sR0V3R0wyZ0hmSVBM?=
 =?utf-8?B?anZwWDRuRGlVeTg0Z24xWjd6MzFNZHgrSjBwcWhHODBrWUZtanovU2gzeCtD?=
 =?utf-8?B?SW1RZnhsMW1CZTU1ZEpObHBueFZ6TENjZjVEZzk4d25KK0pHaWplRHBvdXJZ?=
 =?utf-8?B?TFdObWVUMjByUDZtRDByRDJKUTRNS1Fmd21TRzVjZ1FiNGwyUUs5aWtDM0Ft?=
 =?utf-8?B?NUdPUnlsaW5rVGFmUjg2NWI4RGJEN0NOSVpoVGpwSkJmUjZNaTI1dHQyYzIy?=
 =?utf-8?B?cEUwZWkzQ2tYdzI5bGRFd1J4TWhNajZrb3hRdVQySEZTVWNrNkRJbE9zYVZr?=
 =?utf-8?B?M0hCZEFkSkhDMVU4U3ZrdmhLR1Jmd3VtK0ZReWRtNUxadW1mSHBYUXp4RE5z?=
 =?utf-8?B?clJDMlZuM002MTU2d0piYTF3Y0pxdmZCcC9Ld0p0a1F6Qkk3eVJJeG4zYmJw?=
 =?utf-8?B?OFlzZWEvRFJTb0xWUTIvRlo3TWZmS0RHS1RxSWVYYWZOZjZ0M1B5bjR1bzg2?=
 =?utf-8?B?aHBFNXI5dWg2THBYUWNWSzVvTmkvRmdVSkVxdXdOTXp2Vm1VZHJDQ28xcWJ1?=
 =?utf-8?B?dFdBTlJISGpubFoyK2tPY2FHY1k3SGhmNys1TTJNZ1hFYllBRFIweXJQL0dn?=
 =?utf-8?B?bVFCMXpEbVFFMXNWblkzaEovWFVsdEJMK0RnbldFQ3FMT3NybTN4cm1RNTRG?=
 =?utf-8?B?Z3VTYUJpZGYyTEV5SmV0Yi96WGtLd3NoSy9RamVHMTVEK2h3aytZZ1NhVy96?=
 =?utf-8?B?c0F1cm5aZVNPbFE5Ni9KRml3bHJLQk5nYWRrNWNaTjJkdVZDU1BuKzVBVXlP?=
 =?utf-8?B?NGVzM1FiWXByRjhjankxMy9lY00xbEEvM2RadkNaRllmMDJuTkhXRlAxSDJH?=
 =?utf-8?B?eDlVZTdnN1N1eEt0R0gzMThFZkVOYkJCUEFwcWhoeUpTekROL3NkZFNCK1d5?=
 =?utf-8?B?a2wrTUtGRGc0WkE4MWx1MFV6ZXY5cENOQWhERDJFdUNyUEwrSzBWRG91MnhT?=
 =?utf-8?B?QXYrOW1YWkkvUDBxdnpDRUR3S0o2UHgzc1NyKy9XemloaDB3TzlzVmdtNHZ3?=
 =?utf-8?B?bXZZRVZqSFNFODd1MGdWNjZIc2tGU2IrRUF1TlBkUGZ5ZGp0cDQ3Vy9OVjZP?=
 =?utf-8?B?NGwrRXROeDE2bE0xb1BWR2dVdEhMbFVpRDBhZ3g2Rm1zKzg1emFhcDBFOWxi?=
 =?utf-8?B?b2V3Yk5JNngrS0VQTmpETFBKUElDL1RqZ2k1Y0pkaHgvanBkQlJZb1VUVnVZ?=
 =?utf-8?B?L3F5RHVHYzk4SDZ4N1NnRUI0ZTZXTjh0WkNJQng0eFJ5Wk1rVEdYamxXaWtY?=
 =?utf-8?B?bzk4YTIzZGo0RFN0amdGTlQwbHhud3lyY1ZmMUM2Mkl0MGtjbW9jcURqTmM4?=
 =?utf-8?B?VzM0NlhsaWVTRTN4WHpHQzhFaXhkUVlXS2hlSGo0R2Z2RVVENml3c05xOUJN?=
 =?utf-8?B?Y084cDJsbWtLTFJSQ2UwMjVveVhQSlZtQ2pzUG5USFY4MHMvcStKa1pxUENw?=
 =?utf-8?Q?b5kgYIDzSDluICH6/gw7XhYUNpo17GR+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZnK1IzNmlicm0zSUZpZ1J0TkZmRElNZ0VhYUJrQU9kNDZ3V0ZVcE9jOExC?=
 =?utf-8?B?ejJ5S0ZYK1N0NSs1M2FwcXFKYW8rZjBFcEhtVUVMUU5SRnlxdnE2YjZjYmRR?=
 =?utf-8?B?M2JoTkc4VkFkYkhZVFA4cWJlWEhkcmhpT1BPd2RCL2NQWFNVYU05cCtsYm5s?=
 =?utf-8?B?QUc3TlFRanoxaEFvN1pEeEI3OTFnbU9NdFYzdCtBZ3ZoTGFtUFRrM0dlS2Vi?=
 =?utf-8?B?Mk53M0VUMU5PRzRGaENpYmErcGt0WHhWVmxnTmRTQ3dSQ0s5MSsrN1B3aUY4?=
 =?utf-8?B?ZXpHa3RUOUZzU3NZbUp6cUJRbk5sS3Vrdk5rU0FUdmVTS1ozcHk3akRPbVJI?=
 =?utf-8?B?SUJJV2Q4QmN5RUpFOGNCMnYzdGhYRjA0VFpnR0NGR3JHbHU1ei9kb2hqU1dw?=
 =?utf-8?B?QUoxeVQzYWRHSDdubW0xMmxSZVZXRUI2RFh4S2c2MWEvaDJ4YTNLM211Snl4?=
 =?utf-8?B?VmhVVUtBWGl0VUc1dHhDM0loMzMwRnFLMy9zYWdnSnBlbXBIVWp2VzRGbVhO?=
 =?utf-8?B?T1lncTRJWkswWXRieWlMTTFTU1U2SCs3djl6VW15S0wzRExsbmFSOUk0RXph?=
 =?utf-8?B?VW9HZlFIY2FnU25hT3dpLyt6S3RBck9qV3NNVnVxUXlqNFZwbmJsbzN1N1Ji?=
 =?utf-8?B?VmNqSkprNmN2RG9UQ2VaekFkVzdWMmttWWlPNzl0T2Ura0lsMjBzOWxrdUUz?=
 =?utf-8?B?bnkwMTR5S3NWczAwQUxNWm15KzVjeFM5cXIzS1haZmZDeWNPblpPcW9uYjIw?=
 =?utf-8?B?eld5TFMxTXlPUkdxeFdHQnhYMWczRUFKRTcwYUFYazUxUVpoRmNoSVVOQkRv?=
 =?utf-8?B?VHJ0Z2NVd3VzcjY2Rm43NE51WEYxeGpBWkN6ZWpZeTc0ckZVMEJnMElQa0g2?=
 =?utf-8?B?NHVJcm5JN0RkVk9SbkdVMHBDblpCUllzTmpNbmUxNmNrMjV1cE1hMTh1aGNw?=
 =?utf-8?B?b1JDcCtvc2p3cytZWkY3WWcrb0lWMEFkbS9VUkhFb2JXaXBucnBRVmVMdzJw?=
 =?utf-8?B?MVRIeWFQN2huaXZISjl3VmRDWTNiWGZwR0VieEF2WkQrNXE3S1RvZHRhQjJp?=
 =?utf-8?B?anpPWU9IUmwwejV0bGs1S1ZYS2FlWnRMek8yL1B5bjBDd055S2dFdVI3N2pY?=
 =?utf-8?B?TnZ2YXdCS3lJRnFFQ2ovaHhqYnc0RGdyL2k2UkZ4cjlVZXRZNWY2K2R2dSto?=
 =?utf-8?B?My8zS1dKNjJMUks4SUFpL2VEalpRRXFBRm81TlJEYnpnYUYveWpoNXVhTU9B?=
 =?utf-8?B?NzQ3Y3IrRTQ1VUE4NElOd0swZUZWZWZ5emlGaEwyOFZLUThhZFlSTDhreFhW?=
 =?utf-8?B?TFUyMmFsKy9SbVkwcTRKSVpHazJDZ1FVV3JpamppNkVFSXMxdzlaUXYzN0hl?=
 =?utf-8?B?KzJqYmZ6RWZCWVVnOHJXT1hmUzBnUkRHUnRCQXd3bzFGNVhOYTBhOC9OeXlL?=
 =?utf-8?B?SFFhVkYwUmw3dG9tVzJodlJ6SEQzQkdhV2EwaERPTFdRN2w5TWJhMEpaeGpN?=
 =?utf-8?B?dzRDOTlwTE9pcnQ4K3JUYzlZaSthT0RvYm9aQUMvWEhNNDJpOTJWSDhLQzlW?=
 =?utf-8?B?eWE0N1lIZG9KMm5rRDZJZkZrK1VRRXFhYkp1WGxxQlNKeExNVE9XQVV5THVk?=
 =?utf-8?B?K0xmSWRsZ1Y5Njg5MXNaaXZncmV0dzBvcWd1S2JINDJoVk40YVMwQjVZTDdm?=
 =?utf-8?B?NlJYVXRqdDRaOEJMeVIwdGNLampLSHY3UStJY0hVdzFTT3Rka3BTUFJCK0xM?=
 =?utf-8?B?VEFyaWkwVXl1ZVAyUENERXhxaEwzMm1oL2EzQWEyRlRpdGExT0o3WktVTlcv?=
 =?utf-8?B?WGZIdnZ1V2VmWjB3M3N0N3l6MmtqempFRHQvYVlvRXlDdTQ3TURjYjI5Q0hD?=
 =?utf-8?B?WUUyd0d4cmFSRVo5NEZmSHZDZ1laL2FSL1lkMGNOdDdybmgvZVlIckltcGsx?=
 =?utf-8?B?b2IrMU5JK3djempVZEI4QSsvaHJOY1AxTmo4QXA5c0tSTFhlRzJ4SHlBbmNo?=
 =?utf-8?B?VkdrNE5BNWdHdEhFVWRGZS9vWWFmYVpldG1tVWN2N1haUm9WTHJVT2NHZlJN?=
 =?utf-8?B?UVY1K1ZuSm1PaGZqUVVVbEp0TGVpUHgvbi9tVUhYOHVUNUtoRXdIczFoaWxH?=
 =?utf-8?Q?WPDZ6cP2sGH+myuWHr8eQ2uG6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b8623-73ab-4612-3feb-08de1828b655
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:53:47.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI70mhLOVTOExDqNJGVUkCs80e7tz4XYSdOAJeY6ohPY9xyMUXLZKKrSzcqF41v7zrOq6sIC6DlolealngAm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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

--------------HVPKoEBcyssNBvxIh5EVMVRb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/31/2025 12:15 AM, Christian König wrote:

> On 10/30/25 16:53, Chen, Xiaogang wrote:
>> On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
>>> The pasid is a per-process-per-device attribute,
>>> therefore this commit implements per
>>> struct kfd_process_device->pasid in sysfs
>> This per device pasid is used internally in kfd, not used at user space. So no need to exposing it.
> Agree completely, the PASID is a technical attribute we use internally in the kernel and should not expose to userspace at all.

current kfd sysfs reports pasid to user space, but buggy hard-coded zero, this patch tries fixing this issue.
Or we should remove sysfs/pasid if user space does not need it at all.

Thanks
Lingshan

>
> Maybe in debugfs to narrow down problems, but certainly not in sysfs. That would make the internal handling an uAPI and so not changeable any more.
>
> Regards,
> Christian.
>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  9 ++-------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
>>>   2 files changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 70ef051511bb..6a3cfeccacd8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -864,6 +864,8 @@ struct kfd_process_device {
>>>       bool has_reset_queue;
>>>         u32 pasid;
>>> +    char pasid_filename[MAX_SYSFS_FILENAME_LEN];
>>> +    struct attribute attr_pasid;
>>>   };
>>>     #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
>>> @@ -983,7 +985,6 @@ struct kfd_process {
>>>       /* Kobj for our procfs */
>>>       struct kobject *kobj;
>>>       struct kobject *kobj_queues;
>>> -    struct attribute attr_pasid;
>> We keep it to have use space tools(ex rocm-smi) work as the tools still read it before they change.
>>>         /* Keep track cwsr init */
>>>       bool has_cwsr;
>>> @@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>>>                       int handle);
>>>   struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
>>>   -/* PASIDs */
>>> -int kfd_pasid_init(void);
>>> -void kfd_pasid_exit(void);
>>> -u32 kfd_pasid_alloc(void);
>>> -void kfd_pasid_free(u32 pasid);
>> This part is right, these declarations were forgotten to remove.
>>> -
>>>   /* Doorbells */
>>>   size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
>>>   int kfd_doorbell_init(struct kfd_dev *kfd);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index ddfe30c13e9d..24cf3b250b37 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>>>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>>>                      char *buffer)
>>>   {
>>> -    if (strcmp(attr->name, "pasid") == 0)
>>> -        return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
>> Same as above we keep it to have compatibility with current tools.
>>
>>  Regards
>>
>> Xiaogang
>>
>>> -    else if (strncmp(attr->name, "vram_", 5) == 0) {
>>> +    if (strncmp(attr->name, "pasid_", 6) == 0) {
>>> +        struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>> +                                  attr_pasid);
>>> +        return snprintf(buffer, PAGE_SIZE, "%u\n", pdd->pasid);
>>> +    } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>>           struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>>                                     attr_vram);
>>>           return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>>> @@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>>>        * Create sysfs files for each GPU:
>>>        * - proc/<pid>/vram_<gpuid>
>>>        * - proc/<pid>/sdma_<gpuid>
>>> +     * - proc/<pid>/pasid_<gpuid>
>>>        */
>>>       for (i = 0; i < p->n_pdds; i++) {
>>>           struct kfd_process_device *pdd = p->pdds[i];
>>> @@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
>>>                pdd->dev->id);
>>>           kfd_sysfs_create_file(p->kobj, &pdd->attr_sdma,
>>>                           pdd->sdma_filename);
>>> +
>>> +        snprintf(pdd->pasid_filename, MAX_SYSFS_FILENAME_LEN, "pasid_%u",
>>> +             pdd->dev->id);
>>> +        kfd_sysfs_create_file(p->kobj, &pdd->attr_pasid, pdd->pasid_filename);
>>>       }
>>>   }
>>>   @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>               goto out;
>>>           }
>>>   -        kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
>>> -                      "pasid");
>>> -
>>>           process->kobj_queues = kobject_create_and_add("queues",
>>>                               process->kobj);
>>>           if (!process->kobj_queues)
>>> @@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>>       if (!p->kobj)
>>>           return;
>>>   -    sysfs_remove_file(p->kobj, &p->attr_pasid);
>>>       kobject_del(p->kobj_queues);
>>>       kobject_put(p->kobj_queues);
>>>       p->kobj_queues = NULL;
>>> @@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>>             sysfs_remove_file(p->kobj, &pdd->attr_vram);
>>>           sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>>> +        sysfs_remove_file(p->kobj, &pdd->attr_pasid);
>>>             sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
>>>           if (pdd->dev->kfd2kgd->get_cu_occupancy)
--------------HVPKoEBcyssNBvxIh5EVMVRb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 10/31/2025 12:15 AM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:052b10b1-00ac-4a2e-99c1-3433f2ea4513@gmail.com">
      <pre wrap="" class="moz-quote-pre">On 10/30/25 16:53, Chen, Xiaogang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
On 10/29/2025 10:45 PM, Zhu Lingshan wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The pasid is a per-process-per-device attribute,
therefore this commit implements per
struct kfd_process_device-&gt;pasid in sysfs
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">This per device pasid is used internally in kfd, not used at user space. So no need to exposing it.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Agree completely, the PASID is a technical attribute we use internally in the kernel and should not expose to userspace at all.</pre>
    </blockquote>
    <pre>current kfd sysfs reports pasid to user space, but buggy hard-coded zero, this patch tries fixing this issue.
Or we should remove sysfs/pasid if user space does not need it at all.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:052b10b1-00ac-4a2e-99c1-3433f2ea4513@gmail.com">
      <pre wrap="" class="moz-quote-pre">

Maybe in debugfs to narrow down problems, but certainly not in sysfs. That would make the internal handling an uAPI and so not changeable any more.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 9 ++-------
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 18 +++++++++++-------
&nbsp; 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..6a3cfeccacd8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -864,6 +864,8 @@ struct kfd_process_device {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_reset_queue;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pasid;
+&nbsp;&nbsp;&nbsp; char pasid_filename[MAX_SYSFS_FILENAME_LEN];
+&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
&nbsp; };
&nbsp; &nbsp; #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -983,7 +985,6 @@ struct kfd_process {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Kobj for our procfs */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queues;
-&nbsp;&nbsp;&nbsp; struct attribute attr_pasid;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">We keep it to have use space tools(ex rocm-smi) work as the tools still read it before they change.
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Keep track cwsr init */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_cwsr;
@@ -1100,12 +1101,6 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int handle);
&nbsp; struct kfd_process *kfd_lookup_process_by_pid(struct pid *pid);
&nbsp; -/* PASIDs */
-int kfd_pasid_init(void);
-void kfd_pasid_exit(void);
-u32 kfd_pasid_alloc(void);
-void kfd_pasid_free(u32 pasid);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">This part is right, these declarations were forgotten to remove.
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">-
&nbsp; /* Doorbells */
&nbsp; size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
&nbsp; int kfd_doorbell_init(struct kfd_dev *kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..24cf3b250b37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -328,9 +328,11 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
&nbsp; static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buffer)
&nbsp; {
-&nbsp;&nbsp;&nbsp; if (strcmp(attr-&gt;name, &quot;pasid&quot;) == 0)
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%d\n&quot;, 0);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Same as above we keep it to have compatibility with current tools.

&nbsp;Regards

Xiaogang

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">-&nbsp;&nbsp;&nbsp; else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
+&nbsp;&nbsp;&nbsp; if (strncmp(attr-&gt;name, &quot;pasid_&quot;, 6) == 0) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_pasid);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%u\n&quot;, pdd-&gt;pasid);
+&nbsp;&nbsp;&nbsp; } else if (strncmp(attr-&gt;name, &quot;vram_&quot;, 5) == 0) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attr_vram);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buffer, PAGE_SIZE, &quot;%llu\n&quot;, atomic64_read(&amp;pdd-&gt;vram_usage));
@@ -662,6 +664,7 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create sysfs files for each GPU:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/vram_&lt;gpuid&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/sdma_&lt;gpuid&gt;
+&nbsp;&nbsp;&nbsp;&nbsp; * - proc/&lt;pid&gt;/pasid_&lt;gpuid&gt;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = p-&gt;pdds[i];
@@ -675,6 +678,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj, &amp;pdd-&gt;attr_sdma,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;sdma_filename);
+
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(pdd-&gt;pasid_filename, MAX_SYSFS_FILENAME_LEN, &quot;pasid_%u&quot;,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(p-&gt;kobj, &amp;pdd-&gt;attr_pasid, pdd-&gt;pasid_filename);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; }
&nbsp; @@ -888,9 +895,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_sysfs_create_file(process-&gt;kobj, &amp;process-&gt;attr_pasid,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pasid&quot;);
-
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj_queues = kobject_create_and_add(&quot;queues&quot;,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;kobj);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process-&gt;kobj_queues)
@@ -1104,7 +1108,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;kobj)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
&nbsp; -&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;p-&gt;attr_pasid);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_del(p-&gt;kobj_queues);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(p-&gt;kobj_queues);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;kobj_queues = NULL;
@@ -1114,6 +1117,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_vram);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_sdma);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(p-&gt;kobj, &amp;pdd-&gt;attr_pasid);
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysfs_remove_file(pdd-&gt;kobj_stats, &amp;pdd-&gt;attr_evict);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;kfd2kgd-&gt;get_cu_occupancy)
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------HVPKoEBcyssNBvxIh5EVMVRb--
