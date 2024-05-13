Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC68C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 17:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2E410E8C8;
	Mon, 13 May 2024 17:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GMyMbAZz";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D2510E8C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 17:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjMuguHER+IQAv/db69OLjrhx1sJLIh4nnD016MlwMDkoi/FU1Eo+SmcHiMyNkYWf1fhHD5p/DK7cTrJ/X8IpJqNxAd3B3huGr+r3kCNvH+d4TaSaf9lwYPrEkZnSLocK9hcukmAnyfikmHwTZ0PVlPTps+qM6XUQX2nfQjLQRe0MjA705FRjjimhAjhwdp2pimGC0IKqT8XeVj4j5SOtUhW6NXjKzm9DC7EG26UZ4TwikXtH/yRmDOynXD4KluKIn8oudpGY0mVXu7sbdBWlA4jXKYj16aNHaa+U5glVdbbqm/THujxKX+iTl85AlWO4oZ7FcTKL0EtJNQPoSSrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lsO5w/mNdYzIjOJwnV6P2aVPRiuYhtR0XuNsFwUJn4=;
 b=VtL+srso0nr1a2FcxYMu1W+GMdrlDQOM5NCG30uiremnHhWxSxo/R3Nd0zqBLDSmRcSNeAOVpnYzFMcsI325aEgXYus5f/4DvZEoim207uczgKk6zyX0Tio3iA2KF72pz0vYbKXM3SLsD1pTbVrKnk5Sc9DtwBLW1htxi1VN9QgVWir9rkuPidDle0QoaF9n7cPB2hr2U3Fk7Yl6TdJ0t4LvWKSctikmwZ/7uTJWwNbKow9ybM3xK4a1sOkAIPIcrIdxiPaVBnhJ6fox+TAYHEFHHMmWkuk3Rm2wNt3MauQfs5Hzpf0B03Lg0b8vFOoCoVGuY8oqxEXc6bnjJhHqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lsO5w/mNdYzIjOJwnV6P2aVPRiuYhtR0XuNsFwUJn4=;
 b=GMyMbAZzQz006MS7PAAgTbdOHMKc/NT2b0amM7RM+eG2R5++oZ7PAJA1rTrtGgDH+IfN7HWZiP/kHkmf3m7W9aKfgqn3uMhp6BTiAlGt9zc+BF6VEs2E7ZQARzN+x0afEBUMEZoojmFYJ/1Cc/ThuBbfWYgpUC7ujD9cjRB56Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:50:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:50:24 +0000
Message-ID: <ceb41ddb-f66b-40ec-9d83-c0ec3ce3de55@amd.com>
Date: Mon, 13 May 2024 19:50:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add Ring Hang Events
To: Ori Messinger <Ori.Messinger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240509204153.55885-1-Ori.Messinger@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240509204153.55885-1-Ori.Messinger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 839098c3-237c-4c98-9999-08dc73752a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUZIL2pTYzBjeFQyWm9PMy9rZzZqakNVbnlkK3pvbjBKM1JSLzVPM2tGckc2?=
 =?utf-8?B?ajgxMXM1K3ZEdkhmcjE2TFF0ZnJlbU5zaEhyejA2VEhjNU5MTjJKTHk5aHo0?=
 =?utf-8?B?aTc4WHVRN0g3V0ZqSFdEOVJ5VjNCUmlBQUd5NE1says3d2N4NXlXVVViQU4x?=
 =?utf-8?B?YmZqQ0s4ZjhObGlEK1F1bEh5UmlMbmY2OXRHbU5vS0lzOUhqQkVpcHM2ektW?=
 =?utf-8?B?UVBIRUE5R2JBNUQ0T2NOWk5id1hJcEtEUlFRbnJMemNvUTkzMWozTTYrUFpx?=
 =?utf-8?B?OFcwS2FDVXI1eCtkTXhJSWc1Qjl5SnJud2tadk9qYlpOaVpIZmptL1BFaEVv?=
 =?utf-8?B?Tkt1cVp1OTVlTXQ1alhtSm1NUGtvbGZ0WkliUzVERWpUK3laR1FIa1VPbEdV?=
 =?utf-8?B?OTgxbVNoMHVId1JpQ1dCVERzdndwRGpVQjROWlh2SXNXWm5iMnN0aVNTSWRU?=
 =?utf-8?B?eXF6VGY0ZW0rRUF3MzJybEExSWxaQXZPejJvd2FnUS81cFR0dlZjS0VWUzVw?=
 =?utf-8?B?VE52UU1EWnIzMnZnTlc1Y3o1UTZPak1QRmFwdm9xSjdaYmVWcTY0ZnhtTXRV?=
 =?utf-8?B?dDNndEQ5SkFlZ1FvRjZxWW0rZWtnSVU2c0ZhejlZYXJ5bFJYVHBhQmZBbkJi?=
 =?utf-8?B?MXVxZkxHZlNPUGY1bjdrZkRPaTNKVjh1Ukc2OGo0anhLQ3JJc2JSMU02NytZ?=
 =?utf-8?B?TFlBc2ltUW1xYkJlR1FCSEdiMWRYTU9rZWNVRS9qbENmK003R3dXSnJCOHBp?=
 =?utf-8?B?dG5NMWx2QjlPSW5PYTJJOXFNK010YUptdmtNc0ozNGNRM1A3Z1pPSUpiK0hH?=
 =?utf-8?B?bWZibDdad3N1OHJSSlg4UkdWcFZ5TzVQakh4S0JDa0lMd0puSWhINitoTEZt?=
 =?utf-8?B?RlJBdU9PSVgvN21reFhld2RzZTUxOStKTEJtNHBDOUpMU1Mwd0xhZE5MaTJl?=
 =?utf-8?B?VDNSVlc3TzZPL2piSFhTRlRWL0NjaXBCQ3piL05Bck93MUN6OVdpZVhHWGxQ?=
 =?utf-8?B?aGtsQWVCdWRFbUx4c0g3RHVMTnNtL21mQ1hRU1hTZkwxcXBoeW9zUTRoVXFG?=
 =?utf-8?B?elM0S0RKMW1nOFYzYk85bUtDTXVtY0lKdlBHQk85bnZFdkZ4T2RRSWN3Wmcr?=
 =?utf-8?B?dFZwTExZOVFvQWNkUm9uWkZVTm5NVTFwZlFQaUZlRHltY1h4MElva3VTMXFL?=
 =?utf-8?B?N0t6ZEFCc1oxK0pKeFp5RFRudHlKUmlaMGYwWlZnWUVpZnNuZVlOdWF0V245?=
 =?utf-8?B?Ui9Rayt4VXBDc29mNXdKc3VUYjR2d1lvb2VUU1BMbDh2RHlqb0U1emhHRENV?=
 =?utf-8?B?Mjh0WFA1Y0xISXR5VC9la0xycVllbnkzekVwMWllcXJ6UnVOTE9VTXBSeXZi?=
 =?utf-8?B?cUYvRnRPb2VWMzJ6OHdQc0NZQzlvQ1FVTit0aDRmREpwQlN3SHhrWENURFJm?=
 =?utf-8?B?d0xOMUZKa09sWGh2SWxqOHBaSXVHS1JYNEp0S09IOFhJd0RPcS9ONDg0TWV4?=
 =?utf-8?B?b1RsTWJSaEhlNmNYYXo1LzZHTmQ4cFAzaU1teDZxZ1BJd3NTeDlaV0NuS2M4?=
 =?utf-8?B?RnJYYjJmMUFUbzA4dnJtSFZ3eGpRbTl6dUNDcnM0Sm9oLy8vbmNBYlE2QXRD?=
 =?utf-8?B?WjM3cm1kemF6ckhiNUFpcVlONWF1R3JpakU0QXpINFlzMFVWUHVmRkEyREpv?=
 =?utf-8?B?RkVxMXdjc1lKMmgwZkVpNUlEYTJJREloUWtIb21JWXdvR25vTWJwQm5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFRmNyswZHhzZmZ4RERXU2c3bkFnMjQybjFJanV0S2dya0ZIdWx6QklSNWlQ?=
 =?utf-8?B?aXVaODNDaDYxejVBUDN5VE9WTGJtZE5QVGh6WmJtZjRmU0VMaUpHTms5UG1B?=
 =?utf-8?B?aEdsQWVzMVNmVktPNjhEeHNhdUZQclNFMEZZTFpuUDhrTEp3OTFSTk5WdWhO?=
 =?utf-8?B?aDVOMkh2TDRrYVVuU2xCakY4RTU3eFJ1T0pVN3lvS1p0UFNhODVyamxObGdm?=
 =?utf-8?B?emRwTmJvRTQ0UjhYSVgxYlVTUlhTZXF2eU5CdHJwbWswOElKcm5ldCs5dXhP?=
 =?utf-8?B?TEN4NjNXdmNoTFZoN1owNEJNdVl6TndMRU9sR1dSZTRRU3AzQ0lsTWNwTFFM?=
 =?utf-8?B?K3FlZXVEVlNERmhuK1VrL013NVlTQmc4NkJBY0RHU3ZqVW9lbkxvWktOS1hp?=
 =?utf-8?B?eUZjWUJqSWI1ZUdUeFRKbHRySnJ2QnVSRHBsZWROTjBNMFY2Z2E0NXJXRGt2?=
 =?utf-8?B?c2RmYmphS2xpUnNhZTNOeUxSWFEwcG94WWZJZ1ZHOGJoakxGQjJiOFlkYk1T?=
 =?utf-8?B?dHlqZE16SUkzM20vemtxbFYrWkpKa0UxSkZzK3g2S3dLY3R2YW1tSU5mTFlr?=
 =?utf-8?B?ei9vOFhaRFBsUjFJUnJDc0J3c2NiTjI4MGxITlhqQ0s3elJhTkVuNzdTT3JP?=
 =?utf-8?B?LzFBZ3BkcVZmdWhXU0hZR2c4Q3NQaXl6QTFlWHBhRDIxbStldGJPYk56N3V1?=
 =?utf-8?B?SkFnZjY1Z2l4dUhqay93dVJoUEFmS2lkaG5veEZXQjQzS0dSVHNpdnBNdmZt?=
 =?utf-8?B?aU5RRFdCakFnZUxjeTkvQTJENzZGREhrcmRldGltbTV3UC8yMGFaeVVrdjBZ?=
 =?utf-8?B?UUFSRC90VFJRYzdzdk5VaEFKcXVvWUxXU0EwWWVETEVYWi9pZlNOY051aExK?=
 =?utf-8?B?amszUDhtSmc1K05IaUdjS3M1QXhxY0gyQ2xXSG5DeFlPVHBNVTd5SHowYWsy?=
 =?utf-8?B?L0QvQVFUYXV1Ny9HRGc4MGdGWFZWMkZ2RWZ6TjlLbVoyQk9mSzFQYXU0M2V4?=
 =?utf-8?B?R09KSHhjV29URnFsdFZvTXlxNS9uWklZZzh2QllOemU0UmNIaDNsZy8vbnVk?=
 =?utf-8?B?MjZGaWdVZU4zTUQ3U1ZQRW9oc0l4dDUyakZEWFpxNklMaTYvY3NTL0hJcWZF?=
 =?utf-8?B?dG9KRFJWMndLUmdyRjNVc3JhMGM2ZnJWYks5d2pJdDJpWFVqeGxqTzhYVUFU?=
 =?utf-8?B?Q1gzTDdSQXB2TXFHYzNQdkNWaURTRVVHeWFkbGR6UDZVTTU0N0h4bThSeDJJ?=
 =?utf-8?B?OFdNRVdNdEs3akFLaTM5U1VKNzBxOVlLYnFnakJsV2d4UUpqS2RtUlNtUXUr?=
 =?utf-8?B?RlpiNnowcHYyKzcvNUdqZTAwOTkzK0NlY2d4QWZ6WXhpZXliODMwVVhXeWRs?=
 =?utf-8?B?VXRKTkVPREdDUHJ2WHFidTJ2Y0oyOVFSQ0oxT0NQMFlOejZJM01NUndsSE1O?=
 =?utf-8?B?MFlHb2FRT1JmMkRzMHFRRkdLVnNyd1FOREY4VW5BN25YbFRXZjNvUWwxZnVl?=
 =?utf-8?B?T2VOejZnQ1BvMGV6Zzc1QytNYXBvZ3pPc2VQcU02ZEtueENkejNVOE54ZHlJ?=
 =?utf-8?B?TWp1MStsRERwYUF5VFoxcjlYUTJpNzFzZElON1FIbmE2Y3NvRmlBVHJKTFBY?=
 =?utf-8?B?SmNUaVJRancyYVd1b3lVWGppY21TSlByN3M3S0xEd1VUODN3ZHZ0VDBxVHBm?=
 =?utf-8?B?Ulp3eU9HQ2ZrMmVZSXY4MEg5ZGIwOFE0cjJ6ajJCem1IL0tqMXNiOWVGaW0v?=
 =?utf-8?B?UkNEWXd0Rk9iaVJMZ053ekE3ek8zU0pWa1RjYkFTVHY3Y1daQ2ZMZkFRS0g5?=
 =?utf-8?B?U2VpcGhNSmhQRHlVbFIrRUZoNXdBbFRtbE5pTHYxRklHQTJxeFJIUzdsTTNM?=
 =?utf-8?B?ZHY4TmNGcXMrSlQrWkNhS1lla0paQkEwMWFBTzRtRUhaSDA2bGtEaUlwSUJQ?=
 =?utf-8?B?MW9hRWxMbUk0TGxrcmswc3l6SHNDeHNkT3pjckZuUUdDVEtLRGo5RkRBMWVJ?=
 =?utf-8?B?eTkycURCQUFvVFlLQmhMN3Y0WGtXVlN6Zk1QeFRmLytxS2lxUElTZ0FrWUN6?=
 =?utf-8?B?ZzRYS3BTR2hKSW1OdzlUR3dGSzBGc0ZtM1FOUjV0dUhJUFlBamFWSEtrODNH?=
 =?utf-8?Q?DSdawHbGgGmo5BScVYd5FW3Nc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839098c3-237c-4c98-9999-08dc73752a49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:50:24.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAQQGWN/VQGAMuE1a4BAPvi1vEsMlXnqTlj+qd0uDJSdYS8cmyzdmI1lc3xicxxI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

Am 09.05.24 um 22:41 schrieb Ori Messinger:
> This patch adds 'ring hang' events to the driver.
> This is done by adding a 'reset_ring_hang' bool variable to the
> struct 'amdgpu_reset_context' in the amdgpu_reset.h file.
> The purpose for this 'reset_ring_hang' variable is whenever a GPU
> reset is initiated due to a ring hang, the reset_ring_hang should
> be set to 'true'.
>
> This 'amdgpu_reset_context' struct is now also passed
> through across all relevant functions, and another event type
> "KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.

To repeat myself on the newest version on the patch, this whole approach 
is a clear NAK.

Driver hangs including the cause of it are exposed through udev.

And in general exposing driver telemetry through the SMI interface in 
KFD is a pretty clear no-go.

Regards,
Christian.

>
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
> Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  7 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
>   include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
>   9 files changed, 38 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e3738d417245..ac0ee4322555 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -133,6 +133,8 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>   
>   	reset_context.method = AMD_RESET_METHOD_NONE;
>   	reset_context.reset_req_dev = adev;
> +	reset_context.reset_ring_hang = true;
> +	strscpy(reset_context.reset_cause, "scheduler_hang", sizeof(reset_context.reset_cause));
>   	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> @@ -261,12 +263,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>   	return r;
>   }
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
>   {
>   	int r = 0;
>   
>   	if (adev->kfd.dev)
> -		r = kgd2kfd_pre_reset(adev->kfd.dev);
> +		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..c9030d8b8308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>   };
>   
>   struct amdgpu_device;
> +struct amdgpu_reset_context;
>   
>   enum kfd_mem_attachment_type {
>   	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
> @@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +			    struct amdgpu_reset_context *reset_context);
>   
>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>   
> @@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +		      struct amdgpu_reset_context *reset_context);
>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> @@ -459,7 +462,7 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>   	return 0;
>   }
>   
> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>   {
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 77f6fd50002a..f9fa784f36f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5772,7 +5772,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>   
>   		/*
>   		 * Mark these ASICs to be reseted as untracked first
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..abcae2e7ed0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -77,6 +77,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   		reset_context.method = AMD_RESET_METHOD_NONE;
>   		reset_context.reset_req_dev = adev;
> +		reset_context.reset_ring_hang = true;
> +		strscpy(reset_context.reset_cause, "SDMA_hang", sizeof(reset_context.reset_cause));
> +		DRM_ERROR("Reset cause: SDMA ring hang\n");
>   		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 5a9cc043b858..757284ab36e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ struct amdgpu_reset_context {
>   	struct amdgpu_hive_info *hive;
>   	struct list_head *reset_device_list;
>   	unsigned long flags;
> +	bool reset_ring_hang;
> +	char reset_cause[64];
>   };
>   
>   struct amdgpu_reset_handler {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 6b15e55811b6..88171f24496b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -35,6 +35,7 @@
>   #include "kfd_migrate.h"
>   #include "amdgpu.h"
>   #include "amdgpu_xcp.h"
> +#include "amdgpu_reset.h"
>   
>   #define MQD_SIZE_ALIGNED 768
>   
> @@ -931,7 +932,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   	kfree(kfd);
>   }
>   
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>   {
>   	struct kfd_node *node;
>   	int i;
> @@ -941,7 +942,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>   
>   	for (i = 0; i < kfd->num_nodes; i++) {
>   		node = kfd->nodes[i];
> -		kfd_smi_event_update_gpu_reset(node, false);
> +		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>   		node->dqm->ops.pre_reset(node->dqm);
>   	}
>   
> @@ -981,7 +982,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>   	for (i = 0; i < kfd->num_nodes; i++) {
>   		node = kfd->nodes[i];
>   		atomic_set(&node->sram_ecc_flag, 0);
> -		kfd_smi_event_update_gpu_reset(node, true);
> +		kfd_smi_event_update_gpu_reset(node, true, NULL);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 06ac835190f9..3ffe4b61fe4f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu_vm.h"
>   #include "kfd_priv.h"
>   #include "kfd_smi_events.h"
> +#include "amdgpu_reset.h"
>   
>   struct kfd_smi_client {
>   	struct list_head list;
> @@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>   	add_event_to_kfifo(pid, dev, event, fifo_in, len);
>   }
>   
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context)
>   {
>   	unsigned int event;
>   
> @@ -224,6 +226,9 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>   	} else {
>   		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>   		++(dev->reset_seq_num);
> +		if (reset_context && reset_context->reset_ring_hang)
> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "%s\n",
> +					  reset_context->reset_cause);
>   	}
>   	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index fa95c2dfd587..85010b8307f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -24,11 +24,14 @@
>   #ifndef KFD_SMI_EVENTS_H_INCLUDED
>   #define KFD_SMI_EVENTS_H_INCLUDED
>   
> +struct amdgpu_reset_context;
> +
>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>   					     uint64_t throttle_bitmask);
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context);
>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>   				    unsigned long address, bool write_fault,
>   				    ktime_t ts);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..7c94d2c7da13 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -519,13 +519,14 @@ enum kfd_smi_event {
>   	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>   	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>   	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> -	KFD_SMI_EVENT_MIGRATE_START = 5,
> -	KFD_SMI_EVENT_MIGRATE_END = 6,
> -	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
> -	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
> -	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
> -	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> -	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_RING_HANG = 5,
> +	KFD_SMI_EVENT_MIGRATE_START = 6,
> +	KFD_SMI_EVENT_MIGRATE_END = 7,
> +	KFD_SMI_EVENT_PAGE_FAULT_START = 8,
> +	KFD_SMI_EVENT_PAGE_FAULT_END = 9,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 10,
> +	KFD_SMI_EVENT_QUEUE_RESTORE = 11,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
>   
>   	/*
>   	 * max event number, as a flag bit to get events from all processes,

