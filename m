Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D6EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0700010E676;
	Mon, 28 Mar 2022 13:52:40 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A9510E66B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwhBic/htHUBC8AFAx5xBshsBJI3i0REf6hVFYvNgzMSWkij483pPYq3MdTVjZyQRE2skPlGDXff7EKxnnOATQMVGUI2GirgCnu51h13mPn1rkmycwjXlvw8kYrAet2FHx+1bcG7dBX+SJxbpc6ow00pQDXOPxOCny/rHpCe06abtKTw7xLD946N/1YgzC4jYWJg5L2sCaMLsau/i0sfqvdLQXkM9FA+Dln0gWbX0MQGR0ofnk1NibluCYtqVKf1pDtBRnUsQ0vm9XBWWUKrW1DrmoAOj1wc+U0JwLznSkwR1/NJMhPiJO99PmoLPfDvromMCEkY+K8mNAN1uh8wJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aRIrpZyzIXO4+OiepdO1ojJxhR4yDR1flaQRoGfEhg=;
 b=TTEv1SE8EiAH5YGZH5VSJRutAwa4EeTtEqCVd+MY+YGGXvym4BTAPhMwxDjt0Bt+JDCl57VfytEUZsoCjuMAXBuXAPH+yzWn68RQ4QEFzuiZ9Izd+Eygw6QbN3ZWQzMN9ioEjA0AJbN12E+V0X9XIAimVpLy/cjCxx5Hj4Cljc3NpP5vyc52v/Jy0LaJo4oTJiqB2CLRzCVlfZj2oZjFhLpK6dy1jf4+jDT/xDz0mGTSq/9La/3zcEsvO4kYLaHlNxC6KkkZtEM99tgRVmxS8Odah6acS5filDRogTJs2MclEJeHoIHSlDcoj5MXkiGfh5bSgiLzW48O+gEZrMiuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aRIrpZyzIXO4+OiepdO1ojJxhR4yDR1flaQRoGfEhg=;
 b=IhzbEz/UhlNpFILniM4FpsOxd3RISwKeHGzsKKRwOR1vvF7Qus+8RQ8gl7Xk9ki9rnWnKqgNuuhEuggdFvMcB7D+adg2aDS5tGUugDHmCn3FbHxAx9ea9kxSMkB1ZqtWrsZU3VrK96U8jDfWemcP/ddrZeTOnr0ItwhjmwPjpbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:52:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:52:36 +0000
Message-ID: <e61e24a3-57ff-64e1-a5db-4b38a682ba0f@amd.com>
Date: Mon, 28 Mar 2022 15:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Correct unlocked update fence handling
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328130700.29642-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::28) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54e7fa8b-1ed2-4773-3339-08da10c23714
X-MS-TrafficTypeDiagnostic: BL1PR12MB5924:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59245142909DDFC280CC03C6831D9@BL1PR12MB5924.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Tq/DueoCZkSxjDCxfUrGcRlL6V+7rz1Id1ANOcjodKMr7f6JKgr9YcVoSzIuY+WQwAfv7e2Hg8pUgFyauUpQbUr7MEvOQayXyO1RpsawiCekusUdTR7GNhvfAM25I6RduqY9el9HhN/fjRL92D4zR0iSYfxeJmQOT8JB4LyJWmfXxvXxUIXzK8aQyFI66L/Dqn9zuzin0b8p1Bn0hbdVVfAQmeq770Vi3XflSu1mkGpxXfphjbgyn7L1bS37MW1OKKhcmoKF4wqnNNJN58TaPEpCbX7NSbqlwzIkZl3Oxc9Od3tSaVkwN/z8v4r4O8KsJJrrFZqnbcOixAmFo7EtS3gtHcHImOwHGH6tZXjvizDGebny+Ir/JClzPf9P0kV6gKhLJIZ7r1fjSt8wG2wKky1rCJsG5XChWmkHYEotBhIwCIYDcV9We7p266w1rrJiTpJ6HO8jgRj7PriipqRM3aXJPSxMHGrqrJRDTvk/mGaaLFXF2fOa5v41+roK5cfM7LvXrZJM3hvEY0czmNYDESCyjjXE82SwTREGR2yPbqlhzZ7Bknls4ftsOEDRhxzioEOtKhflWPq3U0tVLm01rUWB6Y0ClN9a8AW0ftNvgU8mfWHngoeUUx2bl75SXEZ8TbBjhUMyF8ITJSTpa+cCWrj4fIllTIP2/pnfyS9WFw+6IG6aXO1jr1xBcJzAOvEAXKS2P49YAoSiE2uwTMg6DEVTAbm8ho6aXzmBGSw19pQOOnx6KJEr2j9qUKYVgjg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(66556008)(6486002)(5660300002)(15650500001)(4326008)(66476007)(8676002)(36756003)(66946007)(8936002)(508600001)(2906002)(316002)(83380400001)(6512007)(6506007)(86362001)(38100700002)(186003)(66574015)(2616005)(6666004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURWWHdiaW01VGZhSm9aMkxpeWxPYVM1UXJxeTZoWnh1eTF3UnJjUjkxcytx?=
 =?utf-8?B?RWhXVUF1NlQvYmI1Y29lR2FWblJOdUJoZlZPWjBvVlVWTVhwWHh4ckpDbTNi?=
 =?utf-8?B?aXA2aDU5VGZMNWdkTm1PV3hTTG8xaUNhZkRLMFg0S21VOTd6ZU5wVnpaZ2Jp?=
 =?utf-8?B?MW9pNVdYbHV5SHJudkxpam9Ebm5sYmI0OVFJZFczYi9EQVI1ZFhPWW1EcU53?=
 =?utf-8?B?MzF2cENKWjJmVkZuWlBUM2lkd3h1aW9wemwyWXRzMklWaEc0N1Ztc1ZnbzZp?=
 =?utf-8?B?eXBDZmk4ZnlReXpLcEFTc0dPQmErcmV1YllRbEpOZ3czQ0paWFZiZTlqN2to?=
 =?utf-8?B?RGRkMnE5T0VERDhaK3ZlN0pnOS9EOG9xc1pEMnVRMTJNcmR6Q2h0UnBHOHlh?=
 =?utf-8?B?QytTdEg2c1QxUjFUcVpGSlI5RytqWXJ4QXF0QVdYOVNKZkgxK3U3eDY3OElC?=
 =?utf-8?B?a2UvWXJvOHpDZjBhUnZ1SWdZT09IWkZJSzM2Y3JJUUpBWVI0dEJyeFNCaS9n?=
 =?utf-8?B?MmJwaFplMFR4TUVuTkV6MDBMYW4vc2RWcXRnSExZbVhmV0REaFRqSFZTQ3di?=
 =?utf-8?B?OXZuVE9GWGpyZ2R1a3d5M1VsNGVWeE1JWVNaMnRHbHptMmp0QmhIbklEd2Fl?=
 =?utf-8?B?VmZFaW9RQ2pOVkUrdHFJTzlpUmplVlphdjMxWVJCSzhvWlV3WlBvaXBKNE1q?=
 =?utf-8?B?K0xueDRkUWRJUXU5M3AwU1VScElJUXJNR3p4NlppLzRIL2hGb2o5N2VEMWRw?=
 =?utf-8?B?LzA0M2RTR3o3aUlEVldXc2ovUWlBQnZWZlZSTy9kb25lTE42VTQ3RnA5VEQ5?=
 =?utf-8?B?OXJMMW9MZkhnMVNMSk9Yb2plcTlJR3lmMjM4Rkx1YzF1VzljYkpuT252Rmd1?=
 =?utf-8?B?QWZwSW03QlVtYUNmZmJWM3JQSWg3Y2x4QXFaaWFwU3hrbTdWcmxHOXhzYVND?=
 =?utf-8?B?eGc3aFdwM1VIME82VEx3QWNYcXpTcGZsMkpVeW9aQjdyL0kxV0xQNGY0dWxQ?=
 =?utf-8?B?Y1FQcXZONmVIamhwdmZsY1VHS3RsOVh3YjdkWFBmWWVDMS9ndGJVeXI2Mmgr?=
 =?utf-8?B?N2dGZlVmT2RSbkRZN0V4TU1JaGppc2doYUZCS2JMQzEvNTlKNUJ0QmF5WE9q?=
 =?utf-8?B?Y1ArTzRxajloNTBXS0dxOFhlUFRKZGVQaUpHM2dOTVp0YzZqSWtUNWliOVpy?=
 =?utf-8?B?bCtoakpLZHpWbjB0RVh0OURhZ1M0dUJWL1VpOWtpS1UzZW16cHNtbEkzT3Uv?=
 =?utf-8?B?Wkk0Mjc4ZGZzM3Raa2tZTjJlbEk4YmdPOU5jeDlzcFE5MWRIVm0zNnVsbElj?=
 =?utf-8?B?UmVqTDRRdDQ2RlppbkpubzVNaEVmRUZreEIzck4xaG0xUUdyKzVHYmJoMVVy?=
 =?utf-8?B?VFFRMkFKemJVTWxyQVhQeEM1YU5acjdvckNXUVUwbkJTay9rRU9XSXJEUGI2?=
 =?utf-8?B?VVVGbDZ0NVVUem13ZkZmS3ZpSnYxSytaVkk0a1FDYlpCYll3S0lUVTRoMTRF?=
 =?utf-8?B?WDkyRkxjSHZ2ZzNjTktqNkhKcHd2c0VlVFpqdWV6emUxcDhKQnJiWUdYS0ZS?=
 =?utf-8?B?bmVpemgwZWdGRXBLcGd1S3FickhhczNWREVjdUNpejBjQlphZmpoMWRHNSt3?=
 =?utf-8?B?OEpGbndFZC9FUStlaWdwZUxNelZESWR2YVIwTlVtd0xPY0Q0RXFGOC9LVHVD?=
 =?utf-8?B?b2tGRnJMMEVxTG5JNjI2cXl2clcvTWk2NkdzY0tCanJLR3ZXYmdMVVYzakpE?=
 =?utf-8?B?b2Fod0pTbmlkUVNXYXJSRURiSEJZdklRenVVdjEyYzZFdmtPMWNhdEpsVmEx?=
 =?utf-8?B?SDhWVDJWVXlSaEx3MklLcGFuSFhjY1I2dUJNZHJkSm5VVXk5andFM1ZmZDdZ?=
 =?utf-8?B?VnlYOTc0eE8zek1uRnludjNEZ24raWNaQWVBMlIvaXI5SGVGeWJHdzU2SUg2?=
 =?utf-8?B?S2VwUVdSd1Q1WGZOdm9DM2pDd0tBR2ZMdHQwN2R0djhBM1NwOWg4R3hKWUJ0?=
 =?utf-8?B?WXRTajBScDlaS3ZVSmVaQko4UWhER0Y4UlZRWmZFUzEwZWRicE9rRXZhOFhw?=
 =?utf-8?B?RkcyZHlpOU9BUHVxclovWHQ0Q3JsT0FxRFJwci9lcEx3SDNxcEFLNTRFdGRM?=
 =?utf-8?B?Uk52cW9KUk9mRHRrTU82ZmdqSC91OHlEbHZZTnZ5bU9hK2FQK01ZWkIrTVVB?=
 =?utf-8?B?L0JVNmxROFBnMVQzTWRvZzZVNmZ0eGRYTWpyZjRPd2JKbDdqRXdKalBjaUtK?=
 =?utf-8?B?eno5Yk9Hd1Q1UURZMllDU3NjbHAvV2xCYU1kWE5QOVd2cHd3eXZrNWtmNndJ?=
 =?utf-8?B?M2FRUXFBclFscmxLYWNvb0dHOU1ITjh3NzhDQjQ2TW13ckcrd0dXS2VFV1lG?=
 =?utf-8?Q?GE56ujLBSVDY0//d9TvR7hk0MOJj1b6610023gM5WdFW/?=
X-MS-Exchange-AntiSpam-MessageData-1: QBPOEWnofM3PHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7fa8b-1ed2-4773-3339-08da10c23714
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:52:36.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxzRDEkANWQjUh3jqQUrfH8X9yzFi+aDMxDNxPRdMX/FQaMeW3XuW1dON0/HUayn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 15:06 schrieb Philip Yang:
> To fix two issues with unlocked update fence:
>
> 1. vm->last_unlocked store the latest fence without taking refcount.
> 2. amdgpu_vm_bo_update_mapping returns old fence, not the latest fence.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Now I see what you mean. Patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index dbb551762805..69fba68ff88e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -109,7 +109,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   	if (p->unlocked) {
>   		struct dma_fence *tmp = dma_fence_get(f);
>   
> -		swap(p->vm->last_unlocked, f);
> +		swap(p->vm->last_unlocked, tmp);
>   		dma_fence_put(tmp);
>   	} else {
>   		amdgpu_bo_fence(p->vm->root.bo, f, true);

