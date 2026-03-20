Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0E7108B8E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 09:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7427F10EA85;
	Fri, 20 Mar 2026 09:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="na2qGPrn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2DF10EA85
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 09:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai/h4KWMOrJcG0zPpwwv562c+7KWreUD1yeubDz6xOPkMxe7YaDX83MObJhAhzztMeMrTbRzTFCMOK5HafkyNxxe/wMx0elJTcQV60OZsBazd09nyub9ZnwFuJJguSA8D9F7tmdq9z4zYiwGzGZjcmNpR2fKF0gyXpLNP4/CgwXAvrHi2MgCu/QrA9yYmrxZji8OXCwcQMWtfXj50aFc94D4WsQ6mF4jMXndmNj/3L7l0cY32xkJyIbq8Ht7Rbyc2qGhfYxTRANDgWbO4GZUSQtGNXmxo3rXCtwMtXCmnsyXUqIlwX9qlkDejJwl0879lGbTDMHNoZPui+PWNwSgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQCruLJQ3Aj/sUTOcMxvROl9D3P893fQ6NOSL6PgqCQ=;
 b=IEVFAQQyH9KdAgfq1a23oLy/jhcJWbXiDlk00m7l3qT9iFRgyyXsl8JlPOlsgC3iAEMjHzfCyqPWACBN9zhi7eBasegSPIglg2o936e/eWOxXilfdLecdHr44f/wYIM8kGnaKSgCh35SVBwdLig0I9OVc5Ki/0FXqegQJwTr+beZ0dzISlBD0VQi2LIeuXj3sSycUN9sPC9X1+fD4hFd/EFTP8O1V18Hl3Mk16GES0wZR8UcPOJJBLph0ajzCWob1a6MRnR29/pTInXmWHj+69iPa5XgLGhX3t91r5mFHL44qnI4WG56F4B8o9yRdz+Vp6LxnrKTsvyGQTmAo37psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQCruLJQ3Aj/sUTOcMxvROl9D3P893fQ6NOSL6PgqCQ=;
 b=na2qGPrn1oe1w4mNmgEdgkk+ZVy/MiEeZd3Zlp1c5Swf/an7jRlS1LjEw4I2BXmsQmGlbYvEmfknG2hSxAlUpPhX5G8Ovc6QMbI+VGFPyNZ8+jodJcjJuBj1Jq2eqGyYJOQslkOOuQ/bUBon2gwkMay8UiEC0p19nvZ0aqVb/28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF89A593F05.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Fri, 20 Mar
 2026 09:44:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 09:44:41 +0000
Message-ID: <a4e7335b-1488-4d06-b1c9-329e5bbdd889@amd.com>
Date: Fri, 20 Mar 2026 10:44:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix the old userq fence dereference
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260320084140.3329888-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260320084140.3329888-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF89A593F05:EE_
X-MS-Office365-Filtering-Correlation-Id: d600eae7-1bac-4044-e017-08de86654f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: eKZyLuiY9RFj+qPHNFmcyw/7fOOTwWrA485uGLKipQP6SDgrpbpZaaukPOoC3190KxmIaHb9iCfVp/Ccrwm0QdJOwNS7IairQYtqJCGFSB3x9q1/yS+skvoeaS3fcx56WK0o1aFznX6LIFW4uUii4Ew3vReMFzvrohJRjYC5M3UIeIEE6iITQI1gGwXm74kztbGYCTI5FfuAd2c43cyeScYXNffzHAPF0buZ2d58aOlhhsfjt8S5Shazka8PNqRvByzJJPnVoNKpM6XxueUnX/8P3JLbEOCppGv6/4ed1btH1dXitvBiaNl+WqpyoAIQBwS4ydumNz9le0tVHm29EePAFzqYjfds30i0xlc6fHhJU1N9mBGJh+gEbNruBfVClGVT6ldYaik3dRPCFzN7JfGnL8fBq/oFJXRFphRFkEiqFrGoHtTIRNEPGcPAsqNV0GVCfGOVdWOZbaHFF3xx+NbvD4ytHnF672Sb6xdfsCq3w5rXSTkgB+g6rp1gRiCTloQNY+MGj7p6YMzuYL+TQ/z0ADrt99rC/nuB9qvx7SybiL9/kiXKGUq/IeIVraxJq32bsafhDgMY9QmS9v6jhHYS/q73WcgelYQ+E8PWLNM8p/PFnXDtx2ZXXXHWRHRbKL8PG1nQSQatEZDE7gjghoa1dgoBCmV8o3gMmVrGX+SqIpi5I4yfcm94LRWlmmYPGyQ5FAhdyjdk8oCsQlv9Vn4pPhjCYu+t5lh2qylK/60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?allRTW9iM3VYcnk0eFZjczVLN093ZUEySjNHdWJueGFFR3I3V1dSdXhrNE1L?=
 =?utf-8?B?eE13NmRLc0VBdThhcjRVUTE4T043T0JZbkdLakUwSHhyNGhFeHJqbkxuZ0VK?=
 =?utf-8?B?MjlJU3lNMFBkcUdBdkdZRW9xOEtydVA4STJoY2xzZ3lNR3YvYm1mbVo3UmRX?=
 =?utf-8?B?QnFtbE5SSDBNM2RkTVNtRW9jTDVzaXBLelJ2WkhsSWhJOWhnRVI5eW81SERk?=
 =?utf-8?B?Yk0yWVUzMVhLYitROTAwN2lua2RTQnhtc0ZrYkczQmJ5Um9KbGh1Y2pHalVw?=
 =?utf-8?B?ZS9FK1VwL2I1OUN4SzI1a3Y1OFdNa2J5WFlySXNFeXZxd0F0MEFydVpRNEZO?=
 =?utf-8?B?TWdMWlFPc0VEMDhCMDNBeWVScDhGQWxxdTlzTmtPdHU2c2JjTVlISEppVmFC?=
 =?utf-8?B?b1Y3eG5kM2tnR2gwUUFaOHFXVmk4SWdiOFREc3hWVXhUellkeVkvM0JMVWdq?=
 =?utf-8?B?U3MxWWtVd2NxcmY3U3o3SU9QaC81ZzJaUjRQVTUzbDFuYWVOcU9KbkdYRkZD?=
 =?utf-8?B?MkF4dit1emJlYVdYTDhmNHMxYXFOdnlwV3hEcE1hZTlPRmpoZUFVMytZT1oz?=
 =?utf-8?B?NFdkQ2JzV2UrbjVjR2gvZzIyUlRFc1phdTZ1bUxNejBEc3h2TllPaVRRT1pH?=
 =?utf-8?B?YUFPSTBqRWlCREVSV28yMDVQSlcxTDRHUjdzdXFMdzh1VXMzNTZRTUYzdVhL?=
 =?utf-8?B?VGVHbzlPWnk1dFovR0Z4SjZMRmxXWlFpTi92bE5YYkd4MVd6UzRSaWhFSCtk?=
 =?utf-8?B?bnBnRU5xSUhQSzBiRitBR2RQc3lZNHdMUm15aGRNRUMycGZCWEFrMkNhd25s?=
 =?utf-8?B?Y3hXcThPNHhaelhwa2pHeUk1eURCN3dUVi9wZWhsQ3NyWTlYTkU4SXg2ZDMy?=
 =?utf-8?B?bTlOMzh6cU80bzlxSWh1MkdLQ2ZwNkl1d1kzL082cE11RlBYWmdFQ0kzVFlU?=
 =?utf-8?B?aldyUkN1TnR3UHpTQ09vckpjV0hEeTJabWk1ZmdiTWdjU3ExY1R3RWlKT3hM?=
 =?utf-8?B?UW4zZ1FWb3JhUWg0L0tIZGxQbUlUNHV6L1VZUkhGTkU2T2ZxbmcxWFpyeEJF?=
 =?utf-8?B?OUJaTjAxc0M0a05rUmNrQnFXV3FvYi9WMHBua3VQZmR5VlpLbVBoc3BqQURj?=
 =?utf-8?B?T0pEZU9WcUhDanFNWjh0Y1lEcU9uM0VPcTlXVS82MUl2NzdDVlFUWnNzRERI?=
 =?utf-8?B?cy9JbXh0SEdQUHk3YmFZZlNPVzdSeFppOWo0bVpiYkRDTXd6bHl0Z0s5QVN3?=
 =?utf-8?B?S2d1ZWRYbW42bUJ2U2F3YWVzYkxka1dQK01BcStNaXl4eW52YzZzZnhoMWhl?=
 =?utf-8?B?azdUOHQvSUI2cEVIZnphdEFhY0V0QVJrelA1NGJteFUwVVV5WjhlUVJrR1Ro?=
 =?utf-8?B?bDcxWlZvTDdodnlLTE9VajJxejEwNDdSZmFMZXFOYXpiSVNWWmRhN2dhcmtV?=
 =?utf-8?B?VyttcWx6N2RiYmpyZURycDk2NnNPS1JoSmdyQmNPL3pHUWFIOFhQZXdJanBR?=
 =?utf-8?B?bFZXK3hkT1pESkJLeUtaREhBRlMwSE81bEw0YUFVakpDQTlCdnpBdkYxQ3JE?=
 =?utf-8?B?dVNObkJzTm9HeEhwamdxTUdRT1lBa3UraG9SVlZFZHVVa0JJN3BWSitIZHFq?=
 =?utf-8?B?Q3lwcmNKQ1hYL2FIYjlVcEVONjBuWkkyMlUvWHdidHNyK3FJK3pxcnJLTHJR?=
 =?utf-8?B?dVRMS0x3UzE4ZGEyMjVGLzkzTUcxMTYrMEhhd2E3Y2hHdjNkZjRqdG5YenE2?=
 =?utf-8?B?ME9PVmd4N2h0Y3EwMnc3NU1xM0JKdENseTc2V0l3UDF4YmFsSXZYMklnYmdh?=
 =?utf-8?B?NWlFaUhtTkFkYWtiZFFKYlpSdzc1R3d1ZUdRUmVIMFJ5K3VnNFF1VTVwMXBI?=
 =?utf-8?B?VU1ZQVRMYzFyYmZEcENoVmpwV0RpeXhyMVMxbTl3SFVOeDhuYlRpdUliSW5K?=
 =?utf-8?B?M0lYeUtTMStubEx0QUY0NjNVWHEzenlXUDZ4b01hYkxpYzFWdVhwSWJyREpO?=
 =?utf-8?B?dFNqaFBYNHYyc0RNOGtiejFEbDRSbERpVzY5ekFqUHU0L2JZbEROVlljYXZZ?=
 =?utf-8?B?a0h6N1RGSXpGTUZaWXd0Tkk5VlY0Wko5VmlTek1XNGJpbFhOak5USXdBcHhw?=
 =?utf-8?B?dzZMTmEwNWZRSStRalE0YXNuNEdnanl5c3R5TkxndDRpUHo5RTFXSThKQkFW?=
 =?utf-8?B?WEVNeWg5cG5rZXpRMnE5bUtqV1gxRnRCdjk1NGRFZDBxUm9DRUluamFuZDZ3?=
 =?utf-8?B?TmtRZGdKckY1K1pBNG11dlpXSkZYMlAwNXo0THFPeURERnhqT00vUnJweWFM?=
 =?utf-8?Q?yqAnTkKz+xvwO0seiR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d600eae7-1bac-4044-e017-08de86654f2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:44:41.2342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2D2KrJOjGf1EWhiXmFOComaJPXO8Lrj10MH5qr+pJ40l+9NyWXogjgQfRcv+dzb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF89A593F05
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



On 3/20/26 09:41, Prike Liang wrote:
> It needs to drop the old userq fence dereference, otherwise
> it can't be walked during freeing the queue.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 9df62f71f27c..f1acd785c27d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -105,9 +105,21 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>  	get_task_comm(fence_drv->timeline_name, current);
>  
>  	xa_lock_irqsave(&adev->userq_xa, flags);
> -	r = xa_err(__xa_store(&adev->userq_xa, userq->doorbell_index,
> -			      fence_drv, GFP_KERNEL));
> +	struct amdgpu_userq_fence_driver *old;
> +
> +	old = __xa_store(&adev->userq_xa, userq->doorbell_index,
> +			      fence_drv, GFP_KERNEL);
>  	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +
> +	if (xa_is_err(old)) {
> +		r = xa_err(old);
> +	} else if (old) {
> +		/* Doorbell index was reused: drop the replaced driver's ref */
> +		amdgpu_userq_fence_driver_put(old);

What? Why is a doorbell index re-used while there is still an userq fence driver for it around?

That doesn't make to much sense.

Regards,
Christian.

> +		r = 0;
> +	} else {
> +		r = 0;
> +	}
>  	if (r)
>  		goto free_seq64;
>  

