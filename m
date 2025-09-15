Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C9ECAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 19:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6560410E53E;
	Mon, 15 Sep 2025 19:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fG7woqZX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6749D10E53E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 19:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpuQh5H3vA2OmJBXpfITYBIXgFUrCBby2Yc7eA9kCJo0XESVCAQklbVsKpYgEWkup5bE9ievCs/gS+TlgTa6TC1d7S3tWJG2lzIJqAWX+nrB7lEITRNwKF8wmNTex4vfRFeHAO4wmsniaweNr/SeLgeIJTFCLKKMGprKPek9fsIO5rULdL/vQC0/3olh9NOydxp6RmYP/xbEd8TW68eJKmUgik7FiCGSkxTk9eujqubYqyAo61OUW2/ikQsoO+qplnsvAe9LAuQYS2U4CpDcw/1/TeVBRdqKOlIw5TQLlila3ygZZ6E2rNfK+hIxXtby0mYnPdHCVYB0eF9REFHERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1SQJHRu17y+n4VkplhWoRYH7A94eqzrKpOTZNvQCS8=;
 b=hlzyAzRRfIwFAhf3wybzTbWkvkhm7k45euu59CTc907dYxueHWFNbXhzYqZMw9pichtdjRr5hXrz7bq44fawLyRkWc5D0aDedo0zWitwx0WZ1PamRWQjUagk+TEjRIPpG54FT5oFTeesm3JMnv3QBnoN+95biJXeCX69LiUWb0edPy9E5LFLaGUHDOJyk1ehhohnYntENmiTawjeg6ICpsESxkSnO5zmA8xIoOp3jjUYrMeIUoVYsTK5H9j9ZsxRyhx6/di3oZoGPKe4gFPPI/j1XFjopj114mOVALF9RkvqtzJK6U3GPtNFsqHW97f4Phed2R7HpZn0/aqoYsI3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1SQJHRu17y+n4VkplhWoRYH7A94eqzrKpOTZNvQCS8=;
 b=fG7woqZXhz0bprYn0zvmkUtv37uOypdU1Bl/K5Zu2dWs/zk/5FpwWtosJn9TtTNmANKKG9yluuLH6Cbbx2beBjcx9Tu6fqRBXrm8I6O++PmmTkl1VhQ+3i49LE3zABMo7ZL3fY/CkD9p1oMKTKFXDip4fLmnC8v84nNdSGKcTus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 19:04:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.021; Mon, 15 Sep 2025
 19:04:37 +0000
Message-ID: <0ffe2692-7bfa-4821-856e-dd0f18e2c32b@amd.com>
Date: Mon, 15 Sep 2025 14:04:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD GPU not detected since 6.16.4 commit c97636cc83d4
To: =?UTF-8?B?SsOpcsO0bWUgTMOpY3V5ZXI=?= <jerome.4a4c@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <12e266b6-b708-43c0-8ff3-db0058c35742@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12e266b6-b708-43c0-8ff3-db0058c35742@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bac3dcf-2e8e-4fda-e3b7-08ddf48ab726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2pKd3JoY01hL3NyWWpmTG0wV0l6TlRUTFNkU1pQS0lqL1BJYVZNUDF2RFhS?=
 =?utf-8?B?dVczWnk2MndNTnoraEtLTjREMHFhSjNJWW1KbW9sMUZRaDlYVkVVRzVMZXYz?=
 =?utf-8?B?aEVtdnJ0aitQWWtIaDNiellhS3Vyd2pOWFNTMi9SSitrRUJYYWZqSlJDTlNw?=
 =?utf-8?B?YzhZK3N0MHZiTEtnN2Fma3JuUzYrWEVLc2pxUUJMRXBkV3ZjZngwaGgzN0FO?=
 =?utf-8?B?dVNxYndVMHpjTGkzVnFyUHJJMnlwbklEeHFMK0RmdFRsOUlXVzVUeXBDTStB?=
 =?utf-8?B?SEdOWUg4YWErYlVYMDMxZFBzYnlGTDIzY0pUNWg4WXdDM0h5Z0RMajB3Qit0?=
 =?utf-8?B?RHVsQ3BPUUZvYXMrKzVHckxRRSt6b0Fabi9CYlVpcDVrYTc4eHhuWURRTTZO?=
 =?utf-8?B?ZUlINHZoZC9IVkErZTRndWZFZjVnYWMxYmI2UGI5c0RIUmlJVDFPLzVJTTVm?=
 =?utf-8?B?SzdsYUJOcWVyUStLbVRCOHRPUVdCSzVERlFMeG40ZUwxM1A2eWZtaGRKSVEz?=
 =?utf-8?B?ZmpTT2t4UTl2UnNVYzFuSUxzSmxDNDFPdWoreWY5UEtyb2FBcG4zaC9ycGZq?=
 =?utf-8?B?dEtGclB4cHh0TmtuT25iL2ZqSWJpN21qcWNpY1BUa0hkdGZnNEIyZzIrY2dB?=
 =?utf-8?B?aC95czRIVVhJNXB5WGZDRStXbVZVd09sbXhGYmFKMW53MVhKeHZQMWVkQ1V4?=
 =?utf-8?B?aUx1YjA1Uks3cVJQanh5VUZUc05tM2VVL2N2Z1RZSWxoc05pRHBuaHNLVUhV?=
 =?utf-8?B?TDNRL0RWWFc2TVZlL3RsQW9hR1FuOEhoaFdKaWdudlB6eGhmb2t4T3ZFRXpN?=
 =?utf-8?B?bGlJWXdKTlNxRjRHVkljSk9vRm1zemd6REZpWkZPb25JS04vU3lVaXM2RzJn?=
 =?utf-8?B?UHNqKzc5b3lLeVh2clRaSzlwdW1VOWJYWDIyanF6S2ptcUVvaHgrZ3FXQndN?=
 =?utf-8?B?eWxTWE1CbUdOdE5vOTFIWERPMmdhR3F5SDdRODYwRlVHbzVCeWxqSituRDF0?=
 =?utf-8?B?MENmcEszMEFhR2ljQ0c3aXJrTUJPWUt4bUJLbUNXenJPVkhBWVRqUVRKZUNZ?=
 =?utf-8?B?UjgxRUo2cWFZcW11ZTR4dUg5STFWNUtoa3FBTkcyMzA2dGxZZkgrN0FBeUR0?=
 =?utf-8?B?d1ZsU3BzQnZJamIzNDJaV2pCbGVXYnBQekVBM2hCdmRYM21TdFRKcHFHSmV1?=
 =?utf-8?B?QVhMMXg0V3JIZW1nSTBmOWM3MHlydnpId3VZTE1UMSt2UGhUTkFCSGxJbkEz?=
 =?utf-8?B?endHbks4T0pRQWw0aitMUTdDSk5yNVpNMG5senl2L0k2V0x5UHlWTFJVSG55?=
 =?utf-8?B?VGxMclk3SDk4VnNMM0xVMnBybGRMZEpuS0NQQTNGa0I2a2N5Yzh3cUdUdXpl?=
 =?utf-8?B?V0RKVTh4eW9hZkRwOEhsRmo3clA4amVuOHFEbkpLc0tJUXdTcUtvYWFNdUJH?=
 =?utf-8?B?ZDQxVTRoMlFqQ2c0aC8yVXFnOWV3RGgzcUNaVkRnUHMwZjU4S2Y0dXJwVmQz?=
 =?utf-8?B?QVRQSjhDNWh6QlBkbzJxUE1OQlR1eWpYUEs2QWJ3Z0xPaURPemxlUGZ4R1E3?=
 =?utf-8?B?Q216YkpLUjk4V2Nxd1J5ckl2bk9UUFBYK3Y2QW1OK0RvVC9BVmdlNldSUkVR?=
 =?utf-8?B?MlYxanA2OVFIcklXc2c0YlI2N0RKdFRwdXk4VmUxUlQyNlF4NzRiUVV6Zmpi?=
 =?utf-8?B?YU02TGNVM2VlaFRNdUZHV0N4cTZPaVdSdlRVeDlDSTNqVXJnb1doQ21seFR4?=
 =?utf-8?B?Mm1zZXpOWWJQcWhybEJNck9lcXNzSDk4dzdvdGZOR3AzVVNmOHR4WmcwWVFU?=
 =?utf-8?B?cHg5MkhQM0ptOHVkeENqbHVjejZlUWYzZjdhaXprcjRKOVY3NzhycUhwejln?=
 =?utf-8?Q?E8Up/6Pu656y3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNrblZuSUtvRFNHdFBsTE5HTklJZzFIU29nV3E0U0xWYlZaVEd2UEtXVHRC?=
 =?utf-8?B?aFB2T05WOE1USkdQa0tQRWcwbzc3K0hXYWQyZzV2c0Y5VEI5RjJNdWdKZkly?=
 =?utf-8?B?YWs3NUVHZFhMcTR3bk5nV1BIaUxGM01VRS9rN1h4b3Y2ZGUyYUhrUXlLYThv?=
 =?utf-8?B?SHdDUWxwdVZySUJYWlVFUHEwZktPc1c5SkFUcWhDT0oweWNuNExSOFRabXly?=
 =?utf-8?B?L1o5T3BuMWdNWGdKN2dkTHluSFZTbnpyR2RlaXl4YitoNkdyanpJZTRQV3VE?=
 =?utf-8?B?SE8vMS91ZHIyZTJnd1FmVFJURldnVUtmbGZNQU9nbk9Oc3UyZ285eEdLRDU5?=
 =?utf-8?B?ODFvb0Z6Uk1aR0Z1UTlSL2V3Qms1RDc1dnQ2eHhEZEZsb3dvRnY0V0x2aTB6?=
 =?utf-8?B?b0dpQ1VZeVpGMDJaM2Jxc2Z1VjdWd0orejV4bjQrcThwNkthWEV2VDdKRnpV?=
 =?utf-8?B?RXp4aThpa3RGckZxZnlHdHdSUysxN1RGTEROR3kraENnbllqSVBEdDJQaGhv?=
 =?utf-8?B?eWs0S2pyM241cnZ4Q0V6aVVOKzU4RVR2U0kybFBIWkk3cjJNSTNza0lqSHda?=
 =?utf-8?B?eDMyZjhnUUtNaWp0VUNsajdCbGdrMS81SGV3UkZ0R1hYNFBFM2tVZjcrM3da?=
 =?utf-8?B?eGRKZGZIY0ZPVkh6WlUvczdTa3RlTkZUSXNkRHBJRXAydVFDME16Yk4zczRT?=
 =?utf-8?B?UVJ3QVh6blJKdHJxN3M3UDNjaTkxdXlTNDlkcS9NeDdwcmpGcUhCdG8waE0v?=
 =?utf-8?B?NEVIVU5neEJkYzZqY2ViTE1oZUdJRjRBT1RkRVA0OHFOblk5RTYvTFlQeWoy?=
 =?utf-8?B?QWZRL2E1SkJGVHcxOVNNK3JCbHRFUC9ucHpNeXhuZXVpNEZxUG9ybGpOejRS?=
 =?utf-8?B?dTRnNGhiOC9kcldTaE9vTXpQUGlHQ2UzRzQrY2FMbXo1VWRmQWhkYnRybG5Z?=
 =?utf-8?B?cVhoMmErMkMvWVRBbUE1TjloN05Nem1RaHdlUmxzdUU3NEVMRzZQSldoaGJV?=
 =?utf-8?B?TldnSWMvVDhhak5LQ2I3NTRtOVBBZG13dFF3U09BU2Z4aXBTNG9sN1JYZ2Zz?=
 =?utf-8?B?U1ZpVHB3a3JLUTJrUGdidGhNV0c3WUZDZStWS1U3STIydEFZQWVHajdoSStl?=
 =?utf-8?B?S2dzell5MWdsbGxZRStHTzhiYXdDTW1qOWpGZ3orQXFpeTkzV1B4dWttN3Ru?=
 =?utf-8?B?cWloZ09BekhoQmR5Y1BKZUN3L0RjRzV4ZG1aS0JObWc4TDJBUFYrblFvWHlF?=
 =?utf-8?B?Tnd6QVB6MGRtMHBpR2hoYjhzZmRqMld4Q1dOVmFsK2V2R3hrZENaa09Nalcw?=
 =?utf-8?B?d3JSakhKQW9hbmVycVNxbHlFMkFYNGNjRWhyTDdzWEdJd2dua1JlUTRVK1hj?=
 =?utf-8?B?QWJIZG9kY2NxdHd6WThhVU5kQ0Z1K1FhQ0JZWkpZcm5QeWJNaFRrdFVHcEtt?=
 =?utf-8?B?M2xGTGJLUndzQkRlWnN6RWFHR2drWEhWMWJSbjVJeVBVTWdZY1FpZWptcU9u?=
 =?utf-8?B?bCtiUVNhdTFHeXlSS085OFFtTjVjeGtBbndLVXBuWkUxZFVQNGxQTzJzRjJx?=
 =?utf-8?B?SmQrc21RWVhaMm9EOHAxZEx6Q3R1TUFqMTAvbFRtMTd1aTdjZHZEWEErb1Jp?=
 =?utf-8?B?ajVpNjRQUGtxUFZEVjZFbXdVUDhsdnF2Vy9HMjNTcnp2QjVqb1R2YkJ1NmdF?=
 =?utf-8?B?UW0zQlNJR2xFKzJ0cUZRQmdaL294aWNxKzdhY0Fnd1RhZFBKazVvK2ZJOCtE?=
 =?utf-8?B?ZGRMS2N2eHk2eGY5QWcxRWd4ZFJXcldxWkcyNHB0LzlFK3lteDJ4eDhEdGcx?=
 =?utf-8?B?MmcrczdFblhKYWluMFBYdnhFbkdLQ1cyc01oZjl2cUlXVHFncUpRRk9oR2Fl?=
 =?utf-8?B?VzNSL1BXUnVqWUxMdkdTWkwzYTdVeExyR0Q0L1BvZm5nczlWOEtBN3dXM0hF?=
 =?utf-8?B?TXF5KzZHbTBXMGNuQ2x0SDFLMTRIQUlFc1d0ZDQ2VThHaEQyUHVmRlU5T1Fi?=
 =?utf-8?B?VTJsTEhhYm9TclFqdjV5WVpuYWtpTWN0Q1BMczc3OWFzOE83SnplYUlIbDJo?=
 =?utf-8?B?eU9FSkRDWFd1VFlCQzRDOVhORkp0cERraUZmbFcxUG9YaXlIWTAzUDkxVGxK?=
 =?utf-8?Q?Qrsq44KcBKt8CAN522n04lJ7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bac3dcf-2e8e-4fda-e3b7-08ddf48ab726
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 19:04:37.5128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCUDLdjkzK2f4ftKesIpvOpA1RTZI/vTinqFmvTwLu1bNeAHnlgit+kBCK8g75jsMFfHTW3CeQw/EIohml+KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

On 9/14/25 12:25 PM, Jérôme Lécuyer wrote:
> Since 6.16.4, I am no longer able to use my dGPU.
> 
> It is visible in nvtop for a brief moment after the system boots,
> but once it is D3cold, it can't wake up (not in nvtop anymore).
> 
> Specifications:
> Laptop with
> AMD Ryzen 5 4600H (iGPU)
> AMD Radeon RX 5500M (dGPU), not overclocked (at least manually), goes to 
> D3cold often
> ~Arch Linux, KDE, Wayland, tried multiple kernels before and after 6.16.4.
> 
> Kernel versions:
> dGPU works fine in 6.16.3 and before.
> The issue started appearing in 6.16.4 and persists with 6.16.7 and 6.17- 
> rc5.
> Bisect using aur/linux-git remote torvalds/linux found: https:// 
> git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/? 
> id=c97636cc83d4591c0c91b6f80eaca3434d7d3e3a
> 
> dmesg after starting nvtop:
> 
> [   32.931442] [drm] PCIE GART of 512M enabled (table at 
> 0x0000008000000000).
> [   32.931460] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
> [   33.086921] amdgpu 0000:03:00.0: amdgpu: reserve 0x900000 from 
> 0x80fd000000 for PSP TMR
> [   33.130797] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode 
> is not available
> [   33.136900] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode 
> is not available
> [   33.136903] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: optional 
> securedisplay ta ucode is not available
> [   33.136907] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> [   33.167904] amdgpu 0000:03:00.0: amdgpu: OverDrive is not enabled!
> [   33.167909] amdgpu 0000:03:00.0: amdgpu: resume of IP block <smu> 
> failed -22
> [   33.167912] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume 
> failed (-22).
> 
> OverDrive is a warning. The two last logs are errors.
> 
> 
> Building with this change on top of commit 22f20375f5b7 fixed the issue.
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/ 
> +/22f20375f5b71f30c0d6896583b93b6e4bba7279
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/ 
> drm/amd/pm/swsmu/amdgpu_smu.c
> index b47cb4a5f488..408f05dfab90 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2236,7 +2236,7 @@ static int smu_resume(struct amdgpu_ip_block 
> *ip_block)
>                          return ret;
>          }
> 
> -       if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
> +       if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && 
> smu->od_enabled) {
>                  ret = smu_od_edit_dpm_table(smu, 
> PP_OD_COMMIT_DPM_TABLE, NULL, 0);
>                  if (ret)
>                          return ret;
> 
> 
> dGPU behaves normally now.
> 
> ...
> [  275.490129] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> [  275.521159] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
> [  275.522179] amdgpu 0000:03:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
> [  275.525009] amdgpu 0000:03:00.0: [drm] Cannot find any crtc or sizes
> [  275.525023] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv 
> eng 0 on hub 0
> ...
> 
> 
> Thanks,
> Jérôme
> 

It makes sense.  Can you send out a properly formatted patch to the M/L 
with all the tags (Fixes/Closes/S-o-b)?  Or if you want me to use yours 
to write one and send one out (and give you a Suggested-by) I can do 
that too.

