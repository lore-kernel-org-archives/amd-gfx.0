Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FCC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 07:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC5310E4E2;
	Fri,  8 Aug 2025 07:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cNqVbL+e";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7E10E4E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 07:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKQgoefnw+o+PLoDpHslBUE+8h6pTREUZQ5Oi599zdnQiYNRPtgjrcvNgBUjq9Usew4qF18650TMc6TSykQ8U67+59W1XEQxshJbnHwC/gjY+E35pCUQo/LcoEVDWFXsFO/PU6nFnIpz6gZ7Eu2/tyA691WtZy1dHbldkSUmqrkIw/7rgUgjCcjm8UDIsZlvv3+dyYhQHAA4VhPvJ7FIdBgvhNO8YHOZ6DIKjRy4b2qyiK2G3Zfd0/i2vLseJvMXyWOGiT6SYCmUhTf3VbTZ/mUFpdjGf3+M8kV71VrUHmejpaYymWtjRv5bLEPS5HVZjaPinSGd8FF0MgwM0+DkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjr5SGBjuZdPmjFiKZNfU/nNfem7zB8sbA28tR1EzK0=;
 b=xELJ6krjLHiEKiTeBFGeqEUZkpC/07nFA+FdIoFSthiRSMce+bY4QN3do4pNnE/QJBkveNTMBRo/Mgi0ti5d8zyDwR60LPjAuLSMGv0dxptJ3wukYNZWcDp1IzOm/MzjjhPu/p6mFQl0DA/0VfnPm4IJK+LICRNDSvDvV270sb1YsoLQAikEFJ8rQi3/jPvTclheMYQrencUalriES5PpdT7223UmWMR2OoID86Aib4FvStW4923yx+mPZmyJTfPkCp3hB/2enwVUZqJ5P0nuSAPBJlwzVle4TBxBZ8obYkbt67Nr67KXX+Ul+Smh9DDbdk+NeR8PTNnMdkj52yVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjr5SGBjuZdPmjFiKZNfU/nNfem7zB8sbA28tR1EzK0=;
 b=cNqVbL+eq24kV+OzT7D5QRMa7FBxiwaeWSDRujzk4EybdZ2EEPP+GnTsAs8XkU3U1ikRqyBeEoRaElEpWPRa9/dKtdPqkwBSqLVsi830YZFYcgX1/6alMSPEHWzosN5ESm2m/Qjs7S20d2MOBg9g6mRk/2qz8GIcUGRVhLdkNj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 07:45:38 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:45:38 +0000
Content-Type: multipart/alternative;
 boundary="------------J6P0Sued4RuzxKOXNTkoIKYI"
Message-ID: <841bd643-da52-44fe-86b0-ad629af47399@amd.com>
Date: Fri, 8 Aug 2025 15:45:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/13] amdkfd: remove DIQ support
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-12-lingshan.zhu@amd.com>
 <408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com>
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: fb00dafb-6ee2-47fd-7f4f-08ddd64f90dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTY5cFAyT3FRTDNaVVJvZy9ZL0pGZkgwaSsxL2k0N2JLUmhKdE5RTk9KOUxJ?=
 =?utf-8?B?SGFLUG5uVTZSZXlIcE42ZDRrNGhqOFU5ODZ4NHp6TDZ0TWY3dDlaL09VQ3o4?=
 =?utf-8?B?K0JkbVNDbWI2blB1bDN4ZUZzb1N0S1NHL2Y4VWxsQkNkcEVFeW5hWUJQTmt0?=
 =?utf-8?B?ay9wekwrKzgweVZkR1J4aFpPYklIaTUxcTJXM202R3h0d3ZDOWozTnJJUUhM?=
 =?utf-8?B?bk1vYzhoUXhlbjF3L0h5enIrY2tZcUZGUHE3V3lMQU1seGp1UEcxTDFiOXR3?=
 =?utf-8?B?UXBZeTRYN25STVJzby80VEdpSnZpZWVVb2J4L1g1ZStWQjBYZUw0RkZid0ZQ?=
 =?utf-8?B?bmtEay8ySjE1clhhNkhQNWVaMUFCbmJFbGxPemJFMGgvOGRZMjhRMUJqdWRw?=
 =?utf-8?B?QWc4dVpkOW9Md2E1SGw2MWIwcW92blBZUmptRWl1UEorelE0UjljTmhhdkw0?=
 =?utf-8?B?SUtaajBJRnR1Q0VBVFZYWWRva1FTLzhzK2dBVExXVmtaeFRreVl5M0N6NGJ6?=
 =?utf-8?B?ZGtNYmRGK1MyUXBXaHQ0N1BtNzJQK3A2eVNxekpiUWQrMzlFQ0pUcUNOd1BU?=
 =?utf-8?B?d0Y0U0F2cWx0b2dWZ1k2dDFJL2hCb0NEWVFZT2RhNVpFYkw1QnQ3WEJKd2RT?=
 =?utf-8?B?ZjQyV24waXU3ajB2dFprSHJicFovd2tFQzFIWnI2Mlo3WDAwbVpkYmJ3NDBo?=
 =?utf-8?B?SEJVNWI1cHFYYnV1V25idk5BTzFmSUdpR290V0t4dUFsdXA4cW9PZE1XRjhD?=
 =?utf-8?B?QVNreGRKM0FoQklmcFBmQVFGV0hTSVF3Z1pJcVZRZktWT0w0U0RDSDhOc3gz?=
 =?utf-8?B?ZllwMGpKZUQ2TTdxdkNCRUg1REZNQmNYdXpERzl6YndkOGN1N0tuOWNEdE9H?=
 =?utf-8?B?L0lHazQ2U01VeXF1TUVKU2ZlL0VRcTZNdUdaK2NjVVNCaGxWUGNpdW0rOXl0?=
 =?utf-8?B?UmFHL3JMdjFWdVV1VVR2Uy8vNVd3dGlUK3FYTkh1Sm04WGRza0RKNXM3QXpQ?=
 =?utf-8?B?WGFhT0FNTmY4WkVqMHFDb2FTYUdjTDE3MjFJVDhDVk1QaVlUV2RWSFhJazQ2?=
 =?utf-8?B?aWJxZzFmdkVwVzBqTTl2U1dER0FXTU1Lc1BJdnY5WVFETkhiU2xlRjg1QTZK?=
 =?utf-8?B?elhzWlVjTFgrR2RMOTl4NUxjRTRDTU55S2p2K3NNaWdpNjVjeWFWTW85N214?=
 =?utf-8?B?RVVMQ2xkQm5ZMkdPL0pMY2ppS3BudXQ2M0V3NmQ0NTZSS3d4dXZUWkR1Qmw3?=
 =?utf-8?B?RzBnTEVpNG9Vd01kSWU3SXV6TUt0SFZNQVh6b3gxb1dEb0RsV0E5dEZEZ0NH?=
 =?utf-8?B?MzFPZExSZWc1cGl4TEtkZ1FiQ21MclVrNDNobFVNSkxMMm9CZktZRWo1YUQy?=
 =?utf-8?B?RTVIQzBNMXVwdDJ2VGdOVDROUThFLzN2ajV4NWdIREh3YlZrMTVvQTBWNStr?=
 =?utf-8?B?UlRKcXM4RWhGTllOVm0vMGQ2OElvcmFhTVRiV1ZoUVhEUHgxY0Rmb2NMMHY1?=
 =?utf-8?B?WW1GZ00yL2x4bmlOUjk1dHVqQXdBaC94bzRxcUo1T1dxMXZaMHNNNU10NTk1?=
 =?utf-8?B?bk5ycWJnYmdiQk5YbERPcEFtUVFPc2FQVUtlRG8rUm43bzZJdS9Ya1pEcmtw?=
 =?utf-8?B?TnQ5d2RIelhwL25ScGVzMGdQL1IzaW9lNkVnMEdSTnhjLzByL1JadjhGWWt2?=
 =?utf-8?B?QkQ1MU5BNjJHTlZFOHhVQjd4ZVoyWmlFRjR3MFBrbVZFSC9pSVNHQ3FrRy9n?=
 =?utf-8?B?WUxIbmk3dnRUdzhwM1RSSFpDMGw2RSs3a0RQa2xudkVoQkdDZ0ZEWENGVjVS?=
 =?utf-8?B?c3F6aXBMNTVyMHI4YVdVcnpQUnlhWDVmTDNERjM0YUlsVUw1Yzc5WE9ack9E?=
 =?utf-8?B?L2JuTnR4THdvVEoydHJrL2FlTFFra0tHMjkxN0pQRTBHcTJYbDZSRXU3S1Yw?=
 =?utf-8?Q?on4gwp1Uyxk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW5GSU5pc1ZPT0s3YU8rUUZ1a0ZDRlAyNlNtMW1wR0RldkFNMTNialNsTzRa?=
 =?utf-8?B?UWYwMEJ5bTNNTDJDRm05UGZrU2hNUFJYZnd5RGVyb0h5Sm0yeFlGaktyWHgw?=
 =?utf-8?B?b0NHaGRlQTlodnY3bGxLVHBURnA5NzY4NzVYaUUrV3IzWndNODBOM1Q5MDRP?=
 =?utf-8?B?QUFlQWd2WGhTTE1mNGRzY1dQV09seC9jdGxTOS9QNEh1MW96Q1dHTmRPM1ds?=
 =?utf-8?B?QytUL0xmUWJvTUx1YUJYUUlmeXlZcWFxVkIveDgwa1ovdjFHU2ZwZDFjekxy?=
 =?utf-8?B?Nzk4MmhVSlVJL1JXTlRERFd4NHdmTWFaZEpXT3FFVndVYzdIT3NVNnpaMFRk?=
 =?utf-8?B?R0JHcndVY0lCMS9ueVh0T3BBaHRlT0xXWkx5bUJCRFdiMUJGL2U1OG1uY3BC?=
 =?utf-8?B?TkFUa3RxUS9UT3FCVko1SkR2NC9aa1RDOThiV24yVi9xd3dVUXNsckVSZ2RE?=
 =?utf-8?B?d3RJS0s4RWMrY25BNXY2YjZReEVjOGRPTlhBdkI3T2hEWGZEMWFKQjFNTVla?=
 =?utf-8?B?bkJkYXp6eUdCMEVwcU4xek5UOXc5cWNxU1FkbjM1L2RjcC9zUlZGZXFiUEZp?=
 =?utf-8?B?eEMrSGIxNVNmcC9LMDNDdTl4blpKWG83dW0vRU03MFdyUlBTTVBtb3pObjhj?=
 =?utf-8?B?K1V0TjlHc0I3cDZKMFY4TjQwanBKM2wwdXZCZGlvTnNwUSt0dVMzd2Ficzdr?=
 =?utf-8?B?ZDIvdGZhcnFhcmY1Y2hWbGNsT3VLUW84di9sclpKUy9Fa3RzMDZaTE9wdE9o?=
 =?utf-8?B?TjdkODFBQmhGOXEvVG5EZWlXQWwyNUduUGVOZ00yMUF5QytSZlFqU29ORzd0?=
 =?utf-8?B?N1k5eHFRWUtTeWdMZm5vV01yT3JhVEg0RzNNQ2hoL2Mrc2JZdTBQZzlMNTVJ?=
 =?utf-8?B?N3BEakZmeEcrTXRBWjA1ODlTSEhEcnB0YmNPbWErMnlFanB4SzVZdThTaVNK?=
 =?utf-8?B?anIraTZHTFNOeW9XWjMraUY2Ti9GV3VSckg5QUVVYzRxSzNYcDl6aXN0SXFl?=
 =?utf-8?B?YXYvanJ4QzJrRTJSekYwSkI3b3NxWnRIQWJuQUNFMXV6OWdRcm5lU25ETVpQ?=
 =?utf-8?B?NXA3a0FWNURQKzZnUFhRSjJ5WEtudHZxUG9vNXR6UXlxNm1XVkNBMUQ2SkM1?=
 =?utf-8?B?TWFCcEZ2bTd2a1ZNOXVIeTlCY1B2TkFYSG9qeXd0NFhvUFJsWmpqSHNjTXBM?=
 =?utf-8?B?aWIxZklhTjZhY2JpMDFpbW9lTzlneWQ4Z3V2QTdaWHFsWFJpQ0t1OUIxdno1?=
 =?utf-8?B?R2NRUkhFcnJGNExqREt5NmorRjB6MTFVc1R3ZlVNTWlnTy91Ym1EOWpZTHEy?=
 =?utf-8?B?Nmw5YTlYQlRDQnBISjlLME84Qzlrb0thQTc0YVNmdHp1R2t4ejArYVlwNEEy?=
 =?utf-8?B?WnM2WlE0dEd5SHdYd3kycjRxL1NyNm5nZk9Xc2lPTi9hbkZtVUpvTm5JVHc2?=
 =?utf-8?B?TllaODRET1lURDNSUGcyYVhIQW5NTk1CSE01elBRQzg0ZnY1UGlBSDA3c1Ru?=
 =?utf-8?B?clZ3eHRsMUMrZ0xTVFpzWlY0NitSVzczazJXWnNsa2luQXAwZGM4U3dkbGh2?=
 =?utf-8?B?NUduUDVJNlZJTzM0Szc2ZG1FMXh0eGV2bWM5UmNrRFgrVjE5L1ZWVm9TTVMr?=
 =?utf-8?B?cDRsSGV3SUFjaVBnVXZEbXNRQ1UwL2tQWm9WdS9JaEFXcXpsa1E5VCtUU1I2?=
 =?utf-8?B?WUpuK1E1RDQ1NVZZckNhMzZjTGl2Y1FpQVdiRE1qNWRHc1FMTmxPNmo5RkJQ?=
 =?utf-8?B?WVVNckVLZHRjb3RYMWExUHczdjdVRnc1cStlYk5XNDRSTUpUdmEzblYrNGVa?=
 =?utf-8?B?MGk3RzFQMWF4VXkrK1dnRVErMHNJL0tUUWwydy93RzJOWTV2SHV6VEE5bVda?=
 =?utf-8?B?WmpjY2YzNnNoSnZPVDdmNmh1dElIeHZJWjgramhRNFluUkFoUUwrOUo0aldZ?=
 =?utf-8?B?TVk0T1RLT2FoRjRSSjd3RW5OVytDTFZoQTBITGZ4eEpIdnBFLzV3cHJ0WHgr?=
 =?utf-8?B?a3FkTE1MeU5ndU8rdVhKdG8ybUEwTUpoQmVvYmVHWC9ranlaSGhndjhOZFI2?=
 =?utf-8?B?ZDF4ekxwV1I4MEUvdjlFMGd3RUNGSkpaZGZKU00rMitTSmhQS2hqSXp4UHNw?=
 =?utf-8?Q?g+ZeRrAJzS/TDOKAfygi5zr/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00dafb-6ee2-47fd-7f4f-08ddd64f90dc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:45:37.9916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hgOVPNXbyVABTVZ4KEC7972Ie5uYdKx4QsOmH2aPRvf2QC5+AVOn7i2iCs/cGGH5LZ/8JoTwqOeUgZk7iyhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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

--------------J6P0Sued4RuzxKOXNTkoIKYI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/8/2025 5:03 AM, Felix Kuehling wrote:

> On 2025-08-04 7:05, Zhu Lingshan wrote:
>> This commit remove DIQ support because it has been
>> marked as DEPRECATED since 2022 in commit 5bdd3eb2
> I think you can also remove KFD_QUEUE_TYPE_DIQ from enum kfd_queue_type in kfd_priv.h.

I was thinking about whether there can be any customer maintained out-of-tree
modules rely on hard code offset in this enum. Maybe I am overthinking because
it is named priv.h, I will remove DIQ in the enmu in the next version. 

>
> See two more comments inline ...
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
>>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 26 ++-----------
>>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
>>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
>>  .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
>>  5 files changed, 7 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 2d91027e2a74..58e47e14cf07 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
>>  				  struct queue *q)
>>  {
>>  	dqm->active_queue_count++;
>> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
>> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>  		dqm->active_cp_queue_count++;
>>  
>>  	if (q->properties.is_gws) {
>> @@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>>  				  struct queue *q)
>>  {
>>  	dqm->active_queue_count--;
>> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
>> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>  		dqm->active_cp_queue_count--;
>>  
>>  	if (q->properties.is_gws) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> index ebee37937783..f676b7419984 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> @@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  	int retval;
>>  	union PM4_MES_TYPE_3_HEADER nop;
>>  
>> -	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
>> +	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
>>  		return false;
> You're returning early here for invalid queue types. That's fine, but see below ...
>
>
>>  
>>  	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
>> @@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  
>>  	kq->dev = dev;
>>  	kq->nop_packet = nop.u32all;
>> -	switch (type) {
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
>> -		break;
>> -	case KFD_QUEUE_TYPE_HIQ:
>> +	if (type == KFD_QUEUE_TYPE_HIQ)
>>  		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>> -		break;
>> -	default:
>> +	else {
>>  		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
>>  		return false;
> I think this code is unreachable because you returned above for any invalid queue type. You can just remove both the if and the else branch. Just assign the kq->mqd_mgr unconditionally.

Yes, will improve.

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>  	}
>> @@ -163,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
>>  				kq->queue->pipe, kq->queue->queue,
>>  				&kq->queue->properties, NULL);
>> -	} else {
>> -		/* allocate fence for DIQ */
>> -
>> -		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
>> -						&kq->fence_mem_obj);
>> -
>> -		if (retval != 0)
>> -			goto err_alloc_fence;
>> -
>> -		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
>> -		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
>>  	}
>>  
>>  	print_queue(kq->queue);
>>  
>>  	return true;
>> -err_alloc_fence:
>> -	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
>>  err_allocate_mqd:
>>  	uninit_queue(kq->queue);
>>  err_init_queue:
>> @@ -210,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
>>  					kq->queue->queue);
>>  		up_read(&kq->dev->adev->reset_domain->sem);
>>  	}
>> -	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
>> -		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>>  
>>  	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
>>  				kq->queue->mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 505036968a77..3d2375817c3e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>>  			packet->bitfields2.queue_type =
>>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		packet->bitfields2.queue_type =
>> -			queue_type__mes_map_queues__debug_interface_queue_vi;
>> -		break;
>>  	case KFD_QUEUE_TYPE_SDMA:
>>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>>  		if (q->properties.sdma_engine_id < 2 &&
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> index a1de5d7e173a..60086e7cc258 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> @@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>>  			packet->bitfields2.queue_type =
>>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		packet->bitfields2.queue_type =
>> -			queue_type__mes_map_queues__debug_interface_queue_vi;
>> -		break;
>>  	case KFD_QUEUE_TYPE_SDMA:
>>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>>  		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index c643e0ccec52..e36950e7e14f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>  	 * If we are just about to create DIQ, the is_debug flag is not set yet
>>  	 * Hence we also check the type as well
>>  	 */
>> -	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
>> +	if ((pdd->qpd.is_debug))
>>  		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
>>  
>>  	if (pdd->qpd.queue_count >= max_queues)
>> @@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>  						    restore_mqd, restore_ctl_stack);
>>  		print_queue(q);
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
>> -		if (!kq) {
>> -			retval = -ENOMEM;
>> -			goto err_create_queue;
>> -		}
>> -		kq->queue->properties.queue_id = *qid;
>> -		pqn->kq = kq;
>> -		pqn->q = NULL;
>> -		retval = kfd_process_drain_interrupts(pdd);
>> -		if (retval)
>> -			break;
>> -
>> -		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
>> -							kq, &pdd->qpd);
>> -		break;
>>  	default:
>>  		WARN(1, "Invalid queue type %d", type);
>>  		retval = -EINVAL;
>> @@ -1121,32 +1105,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
>>  				break;
>>  			default:
>>  				seq_printf(m,
>> -				"  Bad user queue type %d on device %x\n",
>> +				"  Qeueu node with bad user queue type %d on device %x\n",
>>  					   q->properties.type, q->device->id);
>>  				continue;
>>  			}
>>  			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
>>  			size = mqd_mgr->mqd_stride(mqd_mgr,
>>  							&q->properties);
>> -		} else if (pqn->kq) {
>> -			q = pqn->kq->queue;
>> -			mqd_mgr = pqn->kq->mqd_mgr;
>> -			switch (q->properties.type) {
>> -			case KFD_QUEUE_TYPE_DIQ:
>> -				seq_printf(m, "  DIQ on device %x\n",
>> -					   pqn->kq->dev->id);
>> -				break;
>> -			default:
>> -				seq_printf(m,
>> -				"  Bad kernel queue type %d on device %x\n",
>> -					   q->properties.type,
>> -					   pqn->kq->dev->id);
>> -				continue;
>> -			}
>> -		} else {
>> -			seq_printf(m,
>> -		"  Weird: Queue node with neither kernel nor user queue\n");
>> -			continue;
>>  		}
>>  
>>  		for (xcc = 0; xcc < num_xccs; xcc++) {
--------------J6P0Sued4RuzxKOXNTkoIKYI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/8/2025 5:03 AM, Felix Kuehling wrote:
</pre>
    <blockquote type="cite" cite="mid:408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 2025-08-04 7:05, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This commit remove DIQ support because it has been
marked as DEPRECATED since 2022 in commit 5bdd3eb2
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think you can also remove KFD_QUEUE_TYPE_DIQ from enum kfd_queue_type in kfd_priv.h.</pre>
    </blockquote>
    <pre>I was thinking about whether there can be any customer maintained out-of-tree
modules rely on hard code offset in this enum. Maybe I am overthinking because
it is named priv.h, I will remove DIQ in the enmu in the next version. </pre>
    <blockquote type="cite" cite="mid:408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com">
      <pre wrap="" class="moz-quote-pre">

See two more comments inline ...

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +--
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 26 ++-----------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 .../amd/amdkfd/kfd_process_queue_manager.c    | 39 +------------------
 5 files changed, 7 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2d91027e2a74..58e47e14cf07 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm-&gt;active_queue_count++;
-	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm-&gt;active_cp_queue_count++;
 
 	if (q-&gt;properties.is_gws) {
@@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm-&gt;active_queue_count--;
-	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm-&gt;active_cp_queue_count--;
 
 	if (q-&gt;properties.is_gws) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index ebee37937783..f676b7419984 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ &amp;&amp; type != KFD_QUEUE_TYPE_HIQ))
+	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
 		return false;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You're returning early here for invalid queue types. That's fine, but see below ...


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	pr_debug(&quot;Initializing queue type %d size %d\n&quot;, KFD_QUEUE_TYPE_HIQ,
@@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq-&gt;dev = dev;
 	kq-&gt;nop_packet = nop.u32all;
-	switch (type) {
-	case KFD_QUEUE_TYPE_DIQ:
-		kq-&gt;mqd_mgr = dev-&gt;dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_DIQ];
-		break;
-	case KFD_QUEUE_TYPE_HIQ:
+	if (type == KFD_QUEUE_TYPE_HIQ)
 		kq-&gt;mqd_mgr = dev-&gt;dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_HIQ];
-		break;
-	default:
+	else {
 		dev_err(dev-&gt;adev-&gt;dev, &quot;Invalid queue type %d\n&quot;, type);
 		return false;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think this code is unreachable because you returned above for any invalid queue type. You can just remove both the if and the else branch. Just assign the kq-&gt;mqd_mgr unconditionally.</pre>
    </blockquote>
    <pre>Yes, will improve.</pre>
    <pre>Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
&nbsp; Felix


</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:408aa37e-82f7-4bc1-ac4e-391e4554febd@amd.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	}
@@ -163,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq-&gt;mqd_mgr-&gt;load_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd,
 				kq-&gt;queue-&gt;pipe, kq-&gt;queue-&gt;queue,
 				&amp;kq-&gt;queue-&gt;properties, NULL);
-	} else {
-		/* allocate fence for DIQ */
-
-		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
-						&amp;kq-&gt;fence_mem_obj);
-
-		if (retval != 0)
-			goto err_alloc_fence;
-
-		kq-&gt;fence_kernel_address = kq-&gt;fence_mem_obj-&gt;cpu_ptr;
-		kq-&gt;fence_gpu_addr = kq-&gt;fence_mem_obj-&gt;gpu_addr;
 	}
 
 	print_queue(kq-&gt;queue);
 
 	return true;
-err_alloc_fence:
-	kq-&gt;mqd_mgr-&gt;free_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd, kq-&gt;queue-&gt;mqd_mem_obj);
 err_allocate_mqd:
 	uninit_queue(kq-&gt;queue);
 err_init_queue:
@@ -210,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
 					kq-&gt;queue-&gt;queue);
 		up_read(&amp;kq-&gt;dev-&gt;adev-&gt;reset_domain-&gt;sem);
 	}
-	else if (kq-&gt;queue-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
-		kfd_gtt_sa_free(kq-&gt;dev, kq-&gt;fence_mem_obj);
 
 	kq-&gt;mqd_mgr-&gt;free_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd,
 				kq-&gt;queue-&gt;mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 505036968a77..3d2375817c3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			packet-&gt;bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet-&gt;bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		if (q-&gt;properties.sdma_engine_id &lt; 2 &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a1de5d7e173a..60086e7cc258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			packet-&gt;bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet-&gt;bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet-&gt;bitfields2.engine_sel = q-&gt;properties.sdma_engine_id +
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..e36950e7e14f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * If we are just about to create DIQ, the is_debug flag is not set yet
 	 * Hence we also check the type as well
 	 */
-	if ((pdd-&gt;qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
+	if ((pdd-&gt;qpd.is_debug))
 		max_queues = dev-&gt;kfd-&gt;device_info.max_no_of_hqd/2;
 
 	if (pdd-&gt;qpd.queue_count &gt;= max_queues)
@@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
-		if (!kq) {
-			retval = -ENOMEM;
-			goto err_create_queue;
-		}
-		kq-&gt;queue-&gt;properties.queue_id = *qid;
-		pqn-&gt;kq = kq;
-		pqn-&gt;q = NULL;
-		retval = kfd_process_drain_interrupts(pdd);
-		if (retval)
-			break;
-
-		retval = dev-&gt;dqm-&gt;ops.create_kernel_queue(dev-&gt;dqm,
-							kq, &amp;pdd-&gt;qpd);
-		break;
 	default:
 		WARN(1, &quot;Invalid queue type %d&quot;, type);
 		retval = -EINVAL;
@@ -1121,32 +1105,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				break;
 			default:
 				seq_printf(m,
-				&quot;  Bad user queue type %d on device %x\n&quot;,
+				&quot;  Qeueu node with bad user queue type %d on device %x\n&quot;,
 					   q-&gt;properties.type, q-&gt;device-&gt;id);
 				continue;
 			}
 			mqd_mgr = q-&gt;device-&gt;dqm-&gt;mqd_mgrs[mqd_type];
 			size = mqd_mgr-&gt;mqd_stride(mqd_mgr,
 							&amp;q-&gt;properties);
-		} else if (pqn-&gt;kq) {
-			q = pqn-&gt;kq-&gt;queue;
-			mqd_mgr = pqn-&gt;kq-&gt;mqd_mgr;
-			switch (q-&gt;properties.type) {
-			case KFD_QUEUE_TYPE_DIQ:
-				seq_printf(m, &quot;  DIQ on device %x\n&quot;,
-					   pqn-&gt;kq-&gt;dev-&gt;id);
-				break;
-			default:
-				seq_printf(m,
-				&quot;  Bad kernel queue type %d on device %x\n&quot;,
-					   q-&gt;properties.type,
-					   pqn-&gt;kq-&gt;dev-&gt;id);
-				continue;
-			}
-		} else {
-			seq_printf(m,
-		&quot;  Weird: Queue node with neither kernel nor user queue\n&quot;);
-			continue;
 		}
 
 		for (xcc = 0; xcc &lt; num_xccs; xcc++) {
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------J6P0Sued4RuzxKOXNTkoIKYI--
