Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B50E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 22:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488F210E7B9;
	Tue,  7 Jan 2025 22:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lTUHrOV4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E153810E7B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 22:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPPfVvUKn0R/W035G1M4ucg/8YBwrdguF2jt8XEOhMMo0vdI3AzXgAiCNQFEhG2AgKfJGmd30jMJ/Fx5LkX7na4wRhSj9XSzfW8dfTMyuTS7oY0QDv8pNzvcRvCQxZVjfXVGU7atLMPcBpOcVkQC5zHUo7+DQJpUzMopPR3AUg8wQyMKcUpAKp7Hd5SMAFzEo1Q2LQNPLqeB+yjNkXxWp1Vk5fa1lnFkNJF94xdeZE3ANj+q1jk63BTaumRzkkO5ArQRx3VN8gUkao26rVbSLsg0sbhRp4v7CzmStvSTiAnp4RuMpG2PXzevNqoInhJ5eS1fudOppZnEKC8bQlGRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJgFYLLdWR/51fSyGrFAglHjOYh9nI5CMw6qSfoUsQ8=;
 b=qO32t1qHb8xYlg/E97yBRFQhLSMueXUTS2lB5vCV8m1gVibxVl9rFk/YkwHABwc0Naq3RdR8GnM46OpAJ3GBHmkeoYAPjCFdOu7o5xwlsA2ca34WjZ4EPlLuRGFHT0+aW/4ELpA+MJuPjjvq5+k2MaLq5sEWz3O2qQwJxAgCPSkPx+O+bKzypUz4fKei3eP+jQSmn7qjA94LVYdfOw8VIKFMRI8r4CBfEBFPt6gNzuJ8ct+VYrkk/mDbb2KNBmbyCK0Ufo+L2gijtjtZZYNRaj1vPi5dkypHEECnaAYF1xxoV2HDIB4q3AXt6I1I2eRD9YzImh2j+99AyM6YxZxkKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJgFYLLdWR/51fSyGrFAglHjOYh9nI5CMw6qSfoUsQ8=;
 b=lTUHrOV4Qj1jBBnezcoUPgpgByenX7+ikhb40ivJO5VJ8MU53FJ8pNhMDext3D9jmlHCtRReQ0wQfhlsO5oRBqKnxrHk9eRP8oC4YPl4u8IWvbarIb2x1CVM1Z8RQaaB2xyUNE1+um5Tl97zbLXDPGnNzeHiPjBG2XwPmGId2FE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 22:55:12 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 22:55:11 +0000
Content-Type: multipart/alternative;
 boundary="------------b7Q9wvkVxQT0OUZb0q2hLtot"
Message-ID: <9e73447e-520f-4caf-bedf-a8be36105bad@amd.com>
Date: Tue, 7 Jan 2025 16:55:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 lijo.lazar@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com>
X-ClientProxiedBy: SA1PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::10) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9253f331-9abc-455b-5728-08dd2f6e5785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWplUWZYUk9NQ2NHZWdZK2s1ODBXM1B4dksrd3dFT0RPNVNVZHFBQmFVc0ph?=
 =?utf-8?B?NTVVNWxMaG52QldKd1p1RGxGWDdzOTNNcUlrL2ZvUUpVRVc0bm9oTGx0RU93?=
 =?utf-8?B?TExzT25MM0tHYVpqUDMyakMrc2JxMHpCRFVCTnhYcjBidmJQYWlOTnFvZ1Jk?=
 =?utf-8?B?bDFiZjNMcTQ3VTArY2NWY0VZSVMyeGxtYllYVGpEVTlkUW44aThlQXpNUmZv?=
 =?utf-8?B?NWRBQksyWXZYQ2JDcHZSMlV4NklhOGs0NEJ1WmZyMHpBOVcrVVU3QkVKSFg4?=
 =?utf-8?B?cVhZaEp6OXh0YmZib0VBdmRPYm1RbWJzWExnNGJ2a2FTdkZDOGVGRlp5Tm9s?=
 =?utf-8?B?RUhFSGk5MXUyTit5WkRKNE1KK25EU29wSk5DYlpwSmJwRmg3cFNsYitud2NG?=
 =?utf-8?B?dTJzbDdNK3h3WDBpUFBOWFMwRnVVWGV1Z2tYN0dIbkRzVGVsWndIRGZYTVlj?=
 =?utf-8?B?aVVsWUhJc3d0d1VjRGlLbUNxM29MNXNoSm5xSWRyNVh4eEVoWmVxbmVYT3FR?=
 =?utf-8?B?WVFpVnVEMDhqSm14dVBwSE56NXh2OTAzWFBZZkVDYlNlMXlsSnkxVjZSVzFi?=
 =?utf-8?B?U3Qva2pmM25jWjkyRm82UmtkQ2tHblBtQlJXaHhjVjhrdDcvbVlFVWw3c3Z5?=
 =?utf-8?B?eGw2ZW83dDRnZkZNVmQ4eGFMNUR0anJVUGRzLzREOUJ1QXpkVjkwSUtLVm9o?=
 =?utf-8?B?WGtkUVNGMnBXUmlrQ3JxRUZCb1BpRWFCSE1kWEh5WlJZTjBUZUs2UHJWYVhT?=
 =?utf-8?B?eUNwZGZnQmo1UzZIdnhXRlV4SE5QQzJLK0R1a0MySVlUM2FSU2l1NzRLSTVG?=
 =?utf-8?B?aEdCQ3haVGFSVXNwS0djcGZtVGJVbzJsZENLZC9RVTVFRTcvUUF5YTFXZmxs?=
 =?utf-8?B?Q0EwcW55YjVYeUZ2YzB1WnRST1d2TUM2dWtMNndFOWZUY3k3eUVUdE9qUFBM?=
 =?utf-8?B?aDhyZFhHYmNoRVJzd0RPVldMM1FWUU9rWG1YVWR1TjYrWFJvUldTWXk0ZjUr?=
 =?utf-8?B?djJNWDlsZ3M5S2JNbTRHT1A5dVByZUp2OGV4WFdiczU0ei80ZUUycnUva3pv?=
 =?utf-8?B?NERmVlowd1N2bUxLYS9XYkNYMStWb29Vb0tDUGo5by9BK0lwREJLOGFHSUFT?=
 =?utf-8?B?Mit2UVlXRjFtU3I4czFmWWkvNDE4NWEvVjRzR0FJekJPZHd6V05keHpXZTl1?=
 =?utf-8?B?UDZkeldIYXQ0S3BjMlpLYW5oNDJnRE13cDhPNkJnd3RNa2tFeGRPdDFnWVlS?=
 =?utf-8?B?SE4xc2hoaW1vSHdLeXRwT2ZVb2VWTnNGNmtBK3RtMWtzVDVsNUh0cXplMXgx?=
 =?utf-8?B?bXdrZk1ocDZ2UVR5aHdjTi80VWJLZlRzTEY1VzZkTDB2YmZKczZDSGxBNVBZ?=
 =?utf-8?B?QlNmZW9hTUx0OE5KcEpsZkNVLzgxOUpUSHVWUnNsNnVRenhUYS9vdXY3VTJ5?=
 =?utf-8?B?d2hyY3c2dzNKUytValllclpEaEExVHNuNnZQR1JhR2c3TzQ3OTEzdE5RSm9m?=
 =?utf-8?B?dlM2MjVydSswZGQrSE9qcWVMalZuMkttMkJiYTl1aHFBRnZzTUxKQlZhTVhG?=
 =?utf-8?B?MkZsdnlVcW90Mm9LSThUTkNNb2F1WFJnNTJwd09QM1BOV0tvanFSaXEwWFhx?=
 =?utf-8?B?MW02MWs3ME5CU0xLakVsTGhYRTd2dUR4Zm5mbGVuK0FDS2xYUmtaMGtrZE0y?=
 =?utf-8?B?Zi9hRmJBYkIrbGYvS2txVlBMcGJGbUNQazJWbVBSaStYMjhoNXVkeDNLbStm?=
 =?utf-8?B?V3RjdlRJWUtxdFdaWWFqVFdGVFRCbS9jZUF6NzNsb1Zqd0dGOHRhM2dmNHdz?=
 =?utf-8?B?K2dXSkpjeUxHWm9lNmEwQi9rY1RPdTkzS1RuNlFWaVgvR3l2Q1c2NUw1bmdl?=
 =?utf-8?Q?L0IHCw8w2mv55?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllZdWtmdTNrTEVaNnpxVFBseTB4WDFZVlJRdSszQlg4UmZDaXM0UUpHeDZk?=
 =?utf-8?B?R1dGS09kS3hNeUZQRG9TKys3anhHSUlhQVJkUjl2WFEvWEZMTlpEUlBFdStz?=
 =?utf-8?B?ejhXNmF4OUxYMlJBMHlvOUpjM3Q3eUxtMjcyWXdlK2J5OU5mRzBVcDV1ZzRr?=
 =?utf-8?B?L1lJT3l6SmlMQU9GYVRaYTQxdUtnTTNmS3lxYlJRa29NaGoyMW5QVWFhN3gv?=
 =?utf-8?B?MDVDTmplbURrWStuTy9SQm52SDVOQjV2cm1ISHJ1QVZSdlNSem41MXI3RDJl?=
 =?utf-8?B?d2tWazB6bG1sUVN0UElUNVJFUFJlM09CbWoxZmFKSVJ4bWIzNWR5dVEwdzEx?=
 =?utf-8?B?bmd0bk9tZi8zVW10RXlwNVdiMTE3dURjUnkrdDFWQ3Z2aG9kcnJPN2NodFk3?=
 =?utf-8?B?R05uY1NuRk9MNElOalhzMnF1c09qZFFhQ2o4WWtDaE1lQ3VBaWtUaStvNEli?=
 =?utf-8?B?MkEvRDhsNFBONDB2NWp3TTNFaXJGR2ZVcHU5dzZTcDI4dGxZNUc1Vk9BRmZW?=
 =?utf-8?B?Z3NEaW9SQlBCY3dIbU1SQW16bnJLcXMvSysxcUMwenY3OWhnaWFKdWx0M3BU?=
 =?utf-8?B?RENkVDdMYlFKbVdwbktQN1V3MTdXa3dxdTAyd1pscHpJR2V5WUROVjZXRGNC?=
 =?utf-8?B?V3FkRERaVy90N3VodkoyRUZmZjR2a0YxRVltbDFNSUxHajBqSTVvU0YvOHQv?=
 =?utf-8?B?M3IzVkhEYkF4K0lRNlBFTU1zMHV6SDNRa0JYcjZEY1pkSjUzdVBCMkJ3OWo3?=
 =?utf-8?B?MEZ5R1hCenRxcUhzVVcyQmo5U1hmRll2S3FsUm9lWi9GY29jNzdiNnVIRGpK?=
 =?utf-8?B?T25hZXVBWE9yNDVKazVyQXAyRjNVVENXazdvTzRIcm9sTTZtMGpuMTlZcm9X?=
 =?utf-8?B?WkVYbEwxemJjZzJjQUN3VGpZb2M1am05TVlOYzJZSmNQb2hGUVRIclpVU3d5?=
 =?utf-8?B?eXA4b3pwYVQwNy9CSllEemIvYTdMSW4vbmxnS2tJTWpNL1RtZTBFMUNTV3JB?=
 =?utf-8?B?eS9VQVJ4bW5xbVZnbEovVSs5Z2dJMFI5dlZqdk5JOG9uK0dZREg1T3JqVTc5?=
 =?utf-8?B?NkZBcXUrRDhhOVZvWnY0TDErRWVyWFNyNHU4WEp2cUZoWnJ5QVRqYndDeWlv?=
 =?utf-8?B?WE45dkpwMk9hZlYxckdDdUF3anBJSmR5OHEyT3RGcFlyVm9ERWREemZsdHly?=
 =?utf-8?B?bUZHL0FMTmdYb0J4c2FBWTNwVnFqSldiQ2lPTDN3N0tOcnlSTHUvb2JtbVkw?=
 =?utf-8?B?bDY5OE1uVDdXOVdVSkdjcDFFNkR1dzV5OUtTb05XUWdYV2lVUUlyUFRoZkdL?=
 =?utf-8?B?S2xYSXhpN0VsYXFwQ2hRL1ZnTTY4c2x5YW80N2srUDlUL2NGYlgyWjlsZ0RS?=
 =?utf-8?B?SjNMMXBmKy83R01wNTA4bElnY3VTWmJYdnpybWs3RDZEdlNMcElJQkR2MlE0?=
 =?utf-8?B?VmxHb2JqQjd2dGREYnZvMVFFTFhmZDN1Vk5Bd0xTS3Z1U2VsS2djaWM4ZE8r?=
 =?utf-8?B?V09rZytSdjhlNXdnK0tPSHRFMnNycmFOOWNERmJBY2dMZDc4eHZsYXRqanN5?=
 =?utf-8?B?Y0NLYmNoeXF4MHZHNldGK2hRWHZ2NjZsZDl5SEhyRGdqRXZnUE9WT013TFRr?=
 =?utf-8?B?ZTE1QWg0RkVNdndIVlc4cUhCSy9VWk90WjVWeStKZjNwdE1nRTRQOUdGLys5?=
 =?utf-8?B?VmZCRzRSa2gwOTFSSXRDTTYxbE1Td08vekVuL0dPbWY1VVBMcjRYNWo1blUr?=
 =?utf-8?B?djRheURsOUl6cXJ4aklHcU5lRFRSam5xZlhNa1RIbFNhMDdjOFNEQmlxeGxm?=
 =?utf-8?B?d2M4dXYrbTRhT2gvQ0NDdjNFTFJ1MFZITVZhVy9WQ1BPR3I1d0NLQ0RIS1JR?=
 =?utf-8?B?UTFNencrTVlDOWxQOGNhUEJZUmdXc3JLYTB0VnBCQ3JCRWR3UTFpaGlsT2JC?=
 =?utf-8?B?dkZPYjNzek51QzF2NlNGRkVzcXB2aGJaTFNxWVlVNGRNNXFmaWYrdW5LZnM2?=
 =?utf-8?B?eUxUaFZXeGFPbDVwRXJUNGJVU3gzcThhMlJlTjRQRzlXUTNCamJxdkRGMXh0?=
 =?utf-8?B?UjhtR1ZmQ0NUQzZTblZ3MkFDKzB3dWFtTWN6MXRFQW14SmRqOENJV1dUb1Nq?=
 =?utf-8?Q?LOrw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9253f331-9abc-455b-5728-08dd2f6e5785
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:55:11.8969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyDn3M9WdWOefe3PQzPX0HK64tdVlrH5oGZMlcfUp4UanoExBYyhD6AMuEVY2G5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

--------------b7Q9wvkVxQT0OUZb0q2hLtot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/4/2025 8:45 PM, Jiang Liu wrote:
> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
> after free bug related to amdgpu_driver_release_kms() as:
> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> e024se+0x3c/0x90 [amdxcp]
> 2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
> 2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>
> Fix it by unplugging xcp drm devices when failed to probe GPU devices.
>
> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
> Tested-by: Shuo Liu<shuox.liu@linux.alibaba.com>
> Reviewed-by: Lijo Lazar<lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2a046736edd..9ebc0d47d1cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -165,8 +165,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   		DRM_WARN("smart shift update failed\n");
>   
>   out:
> -	if (r)
> +	if (r) {
> +		amdgpu_xcp_dev_unplug(adev);

You have made amdgpu_xcp_drm_dev_free, why still use 
amdgpu_xcp_dev_unplug here? I think you want undo 
amdgpu_xcp_drm_dev_alloc in error path. Why involve adev device unplug? 
It is a different scenario.

Regards

Xiaogang

>   		amdgpu_driver_unload_kms(dev);
> +	}
>   
>   	return r;
>   }
--------------b7Q9wvkVxQT0OUZb0q2hLtot
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/4/2025 8:45 PM, Jiang Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
after free bug related to amdgpu_driver_release_kms() as:
2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
43 28 4d 63 ec &lt;4a&gt; 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
e024se+0x3c/0x90 [amdxcp]
2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26

Fix it by unplugging xcp drm devices when failed to probe GPU devices.

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
Tested-by: Shuo Liu <a class="moz-txt-link-rfc2396E" href="mailto:shuox.liu@linux.alibaba.com">&lt;shuox.liu@linux.alibaba.com&gt;</a>
Reviewed-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2a046736edd..9ebc0d47d1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -165,8 +165,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		DRM_WARN(&quot;smart shift update failed\n&quot;);
 
 out:
-	if (r)
+	if (r) {
+		amdgpu_xcp_dev_unplug(adev);</pre>
    </blockquote>
    <p>You have made <span style="white-space: pre-wrap">amdgpu_xcp_drm_dev_free, why still use </span><span style="white-space: pre-wrap">amdgpu_xcp_dev_unplug</span> here? I
      think you want undo <span style="white-space: pre-wrap">amdgpu_xcp_drm_dev_alloc in error path. Why involve adev device unplug? It is a different scenario.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">
 		amdgpu_driver_unload_kms(dev);
+	}
 
 	return r;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------b7Q9wvkVxQT0OUZb0q2hLtot--
