Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321EC54736
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 20:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF27910E41D;
	Tue, 27 Aug 2024 20:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uglyzzre";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C598A10E41D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 20:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa9/UGYP9JsiH/1D+jgUoI5lkeS1Ib7gJIMEGMrtEi5I28/D2/sFDjqNNuYW+9+cWa5hVX89t29c7SjpUrxnVdJUGlK9aFf8FWRXJIz4PMqV5e4WotouwuMVQfFd/GLKfgFqaxOiyEzqu2nO307QyjR1MGHu/hUmg8Qk1WIPuRKK3t0MizDJU8PxCJ5eFOehE7U/vnWrjz7wmgvRRZAh08q1GMaIv4KSBM5+y0hczGrF12Q0bfLYPyZtqfJ3jZ05Kq2eySDwB/tmCI0K4OXcBQkCdOMT7hNuxxCDj0I/2Rxr8E3NS+D6p1oKJ0L3Ss7tZhHWz7w+6Jeb8XD/zov6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km5jvhG+iPgtxNTUMNJRTM04wGLaBmSp+c1vk++IQ4E=;
 b=V5r5fBs5iE6s8JhMWH8QmvQNFynW8NdojMeIQHRnFHsXxLZBtli+hYzzU5KF0sJMQnX8TZagSG/BkiEdFG09cM5QZIHcoiNBxJutgbGJh/7h7UqTKV8+LmFGqBYDDv36eDqIw3PSwjKY+W3QtHPAVVY+KzTuOIi+ZzelGj/EVCSfLKhl4qii3WNYRIQLND26h9JeATlJx4kbECygr2RC6bsC8cJbuc3NHpt0+ZndAiGwcAI/eXKAU9Z/NIGwOMPse6mhAieKT7yWCyXaR7DBRr58B0HirDvoRnmVg6EJhDFBa/g6E4wFpj6IZLqU9TvR50he0tDKYdKYthPfeEnniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km5jvhG+iPgtxNTUMNJRTM04wGLaBmSp+c1vk++IQ4E=;
 b=UglyzzreaLDfssmUarhbWDoLOo/eiX+pBLLuQUftoqDgjhk9xyWYHH13O8ACqVm5UsVFUDYJ7yZh/2oFmi+gtDZZd0jIsnUp2la7aXkayALVuh3Ywj72D5JQF42WgN7uyHWQg/GvRlKNfQrh1gAGQg1eJoHV9JZE16cyDKqHkog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 20:57:11 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:57:09 +0000
Content-Type: multipart/alternative;
 boundary="------------QzWRmABqCBvfo6GI07dwSEeW"
Message-ID: <0e4ebdd3-e3e6-48f0-8463-6de5d13301d2@amd.com>
Date: Tue, 27 Aug 2024 16:55:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Improve SVM migrate event report
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240827171027.12910-1-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240827171027.12910-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 44efc2d4-c3f5-42e0-e326-08dcc6dad113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGw1YXAyMGk4a0dUSEIxNS8wZnU4QzZwVFd2WVNRbkM4RStHb0ZnSzJLRHhL?=
 =?utf-8?B?aXhwQ05IczVPNmNreVVzTTg2T3ZkVzkyUDBIeTd0UU9BdDVlZFg5Z2E2STVs?=
 =?utf-8?B?TUdCUUwvcmlXTWV5NlhHVmdzMk1ZTHBEUXdpbC83SFlyeHpyeTU2U3g0T2VC?=
 =?utf-8?B?Z0ZMT0NJT0M4Q2lIOWxPRmFGSVg2RTVHSjlZek9wcU5lbFMrUGlRU2txejE2?=
 =?utf-8?B?KzAwNjNEQytnYnFRbERlWmZ3RFIrZmRoQjlWeXh0VHhyZVQyVGxBQTJFcU5t?=
 =?utf-8?B?NmtabTlzZEtNNnA0OGV6bEtTNDJOTWNkQTg4dGNLNU1zMDZoZUppQWdSVkdm?=
 =?utf-8?B?Z2FzTVRnbVRZd2pRV3BMdW1ZRkpoNkNjZWp1ZkVydlM4MXg1N2p2NENxbHQ3?=
 =?utf-8?B?QTkySXJLTFNIZzFUR1hCR3QrSzhlbjRPZHpJUWRraGpkNVNKdzhhakdUQlNO?=
 =?utf-8?B?Wm5hYVAvM0FERmF2cTdRTUxCOWw3NC9DdStXSVJiMVl4cEZ0QndVZ1Zzblkw?=
 =?utf-8?B?WVlTbEtsMTc2ajFiMy9YeWVKOWx3ZDd0Mng0ZzZ2NURQQ0ZQVDRkdThaRFo5?=
 =?utf-8?B?Q3dVRzg4WUoyMFVodnR5aWFZdzZyZFhkK2w0ek9EZGNRMjh3Zzl1ZWREN1Fz?=
 =?utf-8?B?cWtFWWlPdWJHOXhhNysrZFpBcS9mbytqL2NCTVFlMEJHaGVwUUJ1Z1M3eDJu?=
 =?utf-8?B?Si9FQnRDbzZKOHVTVlBBUm1DalM3akFPYkFDaFdJVXVSOThoeDRnQi9VRDV4?=
 =?utf-8?B?SWxIS3QyY3N6VnZmWWo3YWVOREFxaHl3M0tsVUZMOUpheGVVT0VIdll5RmQ5?=
 =?utf-8?B?bUxEUWpzUFh4WnVncE5wVnlJVlk2WXUxblFLSkRGTjNPb0crMldEZEprOTdk?=
 =?utf-8?B?dDRaZ2lUVDdYOHV2Umw5cXI1VFgwdkVuSkg2MlRNQ3FjZUZqUzJQUFkwRFhY?=
 =?utf-8?B?YllrMFZmcmNPcmh2aXFMRzJhT2VmeXhTbmdPMk1vOTB1NzMyM0lwcXRFKzFj?=
 =?utf-8?B?YXkwWndtL1BOdGxPNUhBOWNXQkFaWkpUK0Rua0ZsSzBqMnJRcmdCZ0EvOTJs?=
 =?utf-8?B?allNZmVscXc4bGpOVFpUM0hORGtBSTdoem43SC9aY1VnNFoxNlFGZTZrQk1s?=
 =?utf-8?B?VWt2SWwxbG9mWVFWbzFjbHVpajJLT1N1c3JOQWUwZzRZcUNNZmlCK0twUmpy?=
 =?utf-8?B?L2pmbmlhbC9RYk1rZzNIVHFhUHh1ZlZkdU1zWnVaUHVnYWRkdmxseGZmaUp2?=
 =?utf-8?B?eXl4bHY3M2FIc2Zockd1bEdlcnJYQmEwVEpqaE1HZDJGWHM1bXVrWSt0NC9w?=
 =?utf-8?B?dW93RTNrT3RaeGNqTXNINnA5NElHZVcxamNaZStCODJtQnBQZTVLOEFvYUV4?=
 =?utf-8?B?Q0JzbW05bE1ldis5ak5PUy8wRys3c1pWa210cENycjJHQXhOVzJ1NkV5MXB2?=
 =?utf-8?B?cmtuRURDN3V3Zllmd3JtYlJkRGNCeEI0dzVWaFZRcFVnMzVmTGFiUWR4SElt?=
 =?utf-8?B?amtJUzlwRFg0M1V5TUVUazRRVUpZR1d2M1FNNlJsK1hFd014SUJjWE12VGtq?=
 =?utf-8?B?a2RsemNXQVVKd25xakNwYmNLY0tYYUVjQllvQnRGYVg5cVdpdi81c3JZSXlm?=
 =?utf-8?B?b3AzWGZqU09RckNNT053dDU0d2E1b05lMUsrUzRtaHVtT01oWUFTYTR2d3VM?=
 =?utf-8?B?aWlYNW90N1FpK3NJNDZSMGUxRGh1bERPaCthRmk2dWxNZk5BbU1uVHFiekgz?=
 =?utf-8?B?SFpvdmtadFVhanRBNFhWV3E3blN5a28xTU42R1E5clpPL2ZxWmlSNzBheFdu?=
 =?utf-8?B?U2w3WWl2aWZEbnJaZWxkZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNTaDdNUHZVWXdLdlZBeS92M0pWSDJGdHhxcE9CRC9KQVV4eXVoK0tndVdW?=
 =?utf-8?B?MlZocE01OG1FTUhEOXRMS0ZpVmhJbk1uekZoVW8wdE04QnJ4cmZVWlR5WEI4?=
 =?utf-8?B?dGFBV0xiejl1TnQvOEJQVWRRVTJZR3RPeGFXSWVjQmoveGw1VU5LUnBUbmth?=
 =?utf-8?B?WjFadnpQQ3JGcm5sMC8vSEV5SDZsY3RZbDFuS1FDU0swOEg5M0FQUFpsckxF?=
 =?utf-8?B?eWtYZy92UUN6eGFZcDhkNkJMVHZtdjUrWjdESTFDNS9rK240R25YVmVIa1Bm?=
 =?utf-8?B?c1hISHYrZjF3SHFTTjlQNzkrcXdDNGNnUDE2bVJUU1M2eVRyMk85MTBrMnc5?=
 =?utf-8?B?ZE1obUVFL3V0aFFPNHIzMHNLTEg1L2tVSXhTZGJ1ajBKN1hNZzNBZHBCZFFz?=
 =?utf-8?B?Z0plVXBSMkNjcEhweU9HcDQ3ajhHWGJSbzVRcGJjSEpPUmIzZkJyZ3AreGZl?=
 =?utf-8?B?Z2pqRmZGYmU1aVBLQTFVaDB1OExCR3k2dHMva25mWWVHRlVNWUcwRnhlVStt?=
 =?utf-8?B?cWRDT0huN2psZzdEbTE0Tkp6TUUveTJIWlVJV1ExQVBFaW1TeXZxcHNWTWtw?=
 =?utf-8?B?NW5tc3pzYUhJbkNNOCtkcndONTNFbkp0V1h2VzF6Z2xIZGd3NmxXTVMxNGov?=
 =?utf-8?B?ZDEvUndSU0ZFSnFUSHQ0QmdIekJ4WlVXTTJDUVhIeEtZcWdCZThrbjZWYXNp?=
 =?utf-8?B?N3lKV05oTXpvQ1NhUHk1bjUvaGtEVUVsL2EwSTk3SkRjamNHSUZVT0pibk5q?=
 =?utf-8?B?SVVNa1Vkd09CTnRkOUlxMUs2L1R3SWN0Sk1DVURWR3ptWmtlQ3BHeHRzYVpF?=
 =?utf-8?B?NHNURzRENFppUytmOXJlMHE5NEd3U3FiMUo1S25kYlJkQnp6c0NtRXFMNkRO?=
 =?utf-8?B?bkFWbjVZMWgycE0rcEp0T1dtcUhUdW1GOGF0QWxibG1mT0w4OWEyZC9ySVY4?=
 =?utf-8?B?dCtseGl0dk1WV2ZOVXVXSDk2S1dMUlI1Qi84NjRBQXRvY1U1ajNmeXNnR0Y5?=
 =?utf-8?B?bjNRUktJWkcwMnFFUzJyMUV0MC81aUxleGJXeDB4S28yQjV4dzJiS3lUL0hJ?=
 =?utf-8?B?WWFYc3NWR0owOVhMOVAwL3RtMmRzVUN3dEtSMDBFN0xlOEFadWxIanhDSDlj?=
 =?utf-8?B?NU9udFFxTU5WdzJ3dzBlRmtkOXdvenNScGFKMy9MdHd1QWwyWWVLS0E0aTE5?=
 =?utf-8?B?bmlac2VKbTdMMFcxTEVhM0VoYk5hb09nMzhXUkZRalJySUlxN283NFp4RFVa?=
 =?utf-8?B?Y2VCNXJCOW1uZmwxMFhTL01WMmY5RG9iUUxVTTdWVEtKa2lrOXN5dnhxMzMv?=
 =?utf-8?B?dTQyWCs0NXc4ekp3VW84Wk5SYnBjZDd1bUViTnBYVzVNaUhNMDYwSXJRejNt?=
 =?utf-8?B?aWhIeDBNS0tURG5JM3p2SnJmNWt4NG9qeW85c1dQSTVZbEdRamxwazM3YURy?=
 =?utf-8?B?djRnZzMrS2czRXBvM3JVOEE1OXRMYjZjR3MwVlk4Q0NJSUpMQTk0WStPUnc5?=
 =?utf-8?B?NWVhcDU2dXc5VHpvWXdUeXZvUVk2bjZGV0NJSXp4V1p2ekovNG44cDE5enR4?=
 =?utf-8?B?MmpoZHZKWmx2VklpNkVvckt5K0I1aWx5Kzc3NGsyblB4Q0gwajQzc1NhdjBa?=
 =?utf-8?B?VkY2WHROT29ybGwydUh3ODNidVc0Sjd2THBGbTFlbGFtN2c2STg0TnZydU1N?=
 =?utf-8?B?dGYvN2l6TmtHZGNpRmxxdmx4VmlSYkpLbXBQZXpGbHhIUG1FSEF3MlhIR2ht?=
 =?utf-8?B?blNza2ZGVUdRNnowSFlvT3pnZnNndE91ampYVnB1cGhEWUZEUGtoMVQxbmFs?=
 =?utf-8?B?Zzd4ZGs0V0s3OHQ4K3BUVTQxVS92dytTQ1crQU1ydVc5aGlnTWpZeTk2YU8z?=
 =?utf-8?B?SWxNQ0xIU040am85TnFvWTQ5Q3RoVDhtdjlldDFudElzb20rMW4ydGZvR2dl?=
 =?utf-8?B?V2k4OFpLeG9RZnRiZUxjb21jZ1gva0h5ZzNndFhReDFGSWxjNmhuUDd4bWlq?=
 =?utf-8?B?T0ExZ2ZlUC9VRnlTRWNGakJYQTNuVEFyeEVkTHBpbG85L2Y4d1hWQTBaTlJT?=
 =?utf-8?B?Z1F5ZWlTcUZxYzJDZXlsRmI1L2FiTmFFQUFzTi8ra3pvTlFXdEZXbXJkZE1E?=
 =?utf-8?Q?Bdyk/dRYLX/x8xqygw8NE6pbY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44efc2d4-c3f5-42e0-e326-08dcc6dad113
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 20:57:09.4465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zx9k5lp2ytoBeBjWN9uzIiXd+jISXYNHyzM9r5VZfxTsvfs0QobQ6TaIFBsb6N9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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

--------------QzWRmABqCBvfo6GI07dwSEeW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by:JamesZhu<James.Zhu@amd.com>fortheseries.

On 2024-08-27 13:10, Philip Yang wrote:
> 1. Document how to use SMI system management interface to receive SVM
> events, define string format macro for user mode.
> 2. Increase the event kfifo size, so less chance to drop event.
> 3. Output migrate end event with error code if migration failed.
> 4. Report dropped event count if fifo is full.
>
> v3:
>    Simplify event drop count handling (James Zhu)
>
> Philip Yang (4):
>    drm/amdkfd: Document and define SVM events message macro
>    drm/amdkfd: Output migrate end event if migrate failed
>    drm/amdkfd: Increase SMI event fifo size
>    drm/amdkfd: SMI report dropped event count
>
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  14 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  79 +++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |   3 +-
>   include/uapi/linux/kfd_ioctl.h              | 107 +++++++++++++++++---
>   4 files changed, 150 insertions(+), 53 deletions(-)
>
--------------QzWRmABqCBvfo6GI07dwSEeW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> </span>the<span style=" color:#c0c0c0;"> </span>series.

</pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2024-08-27 13:10, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240827171027.12910-1-Philip.Yang@amd.com">
      <pre class="moz-quote-pre" wrap="">1. Document how to use SMI system management interface to receive SVM
events, define string format macro for user mode.
2. Increase the event kfifo size, so less chance to drop event.
3. Output migrate end event with error code if migration failed.
4. Report dropped event count if fifo is full.

v3:
  Simplify event drop count handling (James Zhu) 

Philip Yang (4):
  drm/amdkfd: Document and define SVM events message macro
  drm/amdkfd: Output migrate end event if migrate failed
  drm/amdkfd: Increase SMI event fifo size
  drm/amdkfd: SMI report dropped event count

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  14 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  79 +++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |   3 +-
 include/uapi/linux/kfd_ioctl.h              | 107 +++++++++++++++++---
 4 files changed, 150 insertions(+), 53 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

--------------QzWRmABqCBvfo6GI07dwSEeW--
