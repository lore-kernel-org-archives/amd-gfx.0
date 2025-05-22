Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E43C54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 09:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ACC10EC01;
	Thu, 22 May 2025 09:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ucMfFjt8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE2310EC01
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 09:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/q3+jpCQDQav38ECqB+eWfwlUqQnZm4zvLBi33xGu1WDbOq+U08xGNzGv/EBTor+dBxBwwW2eY/CVVQbiVo6aM21iKwvwN/UpmZRaRYU6jrSRWiHRN3TqNLxERbtRi1qtGnC1WuwTmvcyoAlaZZ/38+86nlkkVa+KSy8n7cz3l4iake+XQtjsc15pLFaoFXMo0Mq4T9c5KASq06wBUKaadj/budW/e/GLrxEuu7VgyI24893ki5Yiz+9hFq3tno+zF2eIo/TFenvbQRidBMIBFk3DVUu3Hth+iZHPCwyIau3tdqXME2TfVmknpIO2jmAP3xvEHDoGfB8btpMnt0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HQPT1q5HjxlHtNROgeXbwxh3wSns/c15pqxDvCrPEo=;
 b=sDj1O2Q1nEE/3zDhRATdpHQqfkkJ7c5a/Ter6oRenb6afrMohI+C0Kdn5s8Gk0+TSLgnNe26JGtuhZHBc9AehwiRlrYIhfFke8iOO+bPqdkYvD9H4fFD4dqCdgadD6IIwMVWLksWO5byHYiMCsAA7b8oHYyvO2hX4EvRmCvpmYB2QFbRy/YxSkhyKnWWbDiyLSs7tUZ2TUoiRftS59JkMT2rtzJDBalmMsdCKJoFC+Iv1/DNE/o96ysyKJJ5og8SEEgqKMGLiLdsF5GJdzwsaAGutoc7Fm1YxcAbz0Ld9NCIjtCqdyKJd8YxlJmmqJ3NrCCu26nMS20hDMJsgE8zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HQPT1q5HjxlHtNROgeXbwxh3wSns/c15pqxDvCrPEo=;
 b=ucMfFjt80uWdfWtNCbWskPenyY0hqmkKDZSkaUSN6aveUd9QCTpejnwxvCIiGs2srMvJ8XSxqz+c4q6t7iROCebOq784MHInFHZ+mQlV3k2gxHuheTRYIAWW4lSr4GlZyBRLKt06RT9iLWnpwhkq4KhXcEuP93AIIctYKZl6JY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 09:27:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 09:27:33 +0000
Message-ID: <adb0467d-f7d3-48f9-b938-95879d46e841@amd.com>
Date: Thu, 22 May 2025 11:27:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Alexander.Deucher@amd.com,
 Owen.Zhang2@amd.com, Qing.Ma@amd.com, Lijo.Lazar@amd.com, Emily.Deng@amd.com
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250522034350.433219-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a05614-7db4-4a07-9f59-08dd9912e1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGUzcE0rbXJnTW1RK2dTZjRVbEd4TE12YXhmY1A1V2Y3c01LQ2ljQTdJSVRy?=
 =?utf-8?B?d0o0TXo1dXZpVit5Ukp5c2Rra1lMRVVSR3JsNFlEd2V3MGJaQlc1eTljdDVo?=
 =?utf-8?B?STE5VnZHMW5pMG9RM3U5eHJGZDdCbGhXSlpzOUs4VFBoVFpXRnJVMEJhZm5Z?=
 =?utf-8?B?NE9SOERiV0swR0lqeThXNkhmUWRoRjgyQWJXRndtSitlcE5TRE8wL0V4NGla?=
 =?utf-8?B?MHJqYzA4UFF1cER4RFg0TExEOGtmaVFnNWJPb003NmJoK2IraE9JdE4xaGJz?=
 =?utf-8?B?SUxWc1F2VUJCTFZKQnFSMVhoaUFHMWlTYTg5TmVOQU9wQWlqK3VVdlVEeVBK?=
 =?utf-8?B?UGxLMzJGYUFTSk5ZSGxaUUVsWGtCb25Jc3JnejRRb3R1bkFoVVdIZTlyYmo5?=
 =?utf-8?B?ckxsZXRJRUZzaHZBR2FlU3hEamtoOEZva2VwTlZyV2NOajR6ZGtwZE1ZUEMy?=
 =?utf-8?B?Y3VuVTVoQThDSHBUYlNuN0ozOWpmUHByb2RKcEpnRzJOaSsyUGdSeWpDTE9P?=
 =?utf-8?B?bGc5Z2szOENBd2pGWDJNTXpnRjM4TGQzeTlnY3RodllqditIZzI5TFA5MUEz?=
 =?utf-8?B?U29BYzlIcTBvK2FrVFBxSVZBWWUveW1hQTQ3RnNTdk9tVE1hUFFFSzI3dTVN?=
 =?utf-8?B?blJRUTk2ekVRdXJEcGQ3WnZOVHRERnJkUTZUSUtoQ2lUbC9iY0FYanIxQU9U?=
 =?utf-8?B?MktzblJLaUQyMnhhQzhOTHhBY3pKS2JxWDFWWVI4NHRMZUFqRDV6SjRXaU9z?=
 =?utf-8?B?WDZ0dkx0S0QvVS9lQ2ZTaTJKdlpZZWxOOFpJVVBUM29OSzA0ZHZnZkRCWUZI?=
 =?utf-8?B?TWgzMldtSlJXTkdLMWcrZXRYeC8xV1BZeUc1MXJ2REtIQmtwNDVDaEJBdTlM?=
 =?utf-8?B?TDVFVmZLU1c4dXoyT1JKcEpTTVpyNVVXRVpYZk5RVUNRNzhCK3lGYlZXNUJZ?=
 =?utf-8?B?RlV6WGtqeXNsUDNaUVpCSmoxdVVCdG9TQmdDM3IyemJOL3ZHcVJvUDd2dmRF?=
 =?utf-8?B?SGYvMkU1bHErM2Y1cnYyQjRnOHpnbFFkYkd5bGdZYlBQOXlFWlllY2IwLzV6?=
 =?utf-8?B?WUpQS3dSNC9kRmVRUDI1QkpQcklBVmxTSGltOHFOd2FVUXdOYmJIL2JkNmFl?=
 =?utf-8?B?bm9zZTc3SHRiV0Q5Z01DdW84My9DTndKbk5RTW82cFVjaWs1K1dzZk1iUC8y?=
 =?utf-8?B?QkJlT1R5amQ3UUwwdkloNnZWenF1ZUg0UmNPaWhXalZuRDZ1Z20zb2tmZHl1?=
 =?utf-8?B?SnBhdDdOb2hKdTJpNEh6bG5YR0w1UVVMc1pYM3ZjcVEwTnJDWDJLeUhOaEh0?=
 =?utf-8?B?bW81MEFxMVViNlBYUzh6Vkh0Qkh6UTV2YVozQXZHOFoxaERZTkt3eUwwZ1Nv?=
 =?utf-8?B?M0pVeER5eERGNHRpaTJzKzFyUzhkb1BUdXVoaXVjcy9Xc1pTU2lieFBTSlZF?=
 =?utf-8?B?bk1qampld1RpM2RoWmNBSkNVVmRwaVd4VTJEcDVRNmJBQ3Q0K1c3RzBidUIy?=
 =?utf-8?B?M3NoN2tTaDJjRWt3ckluMlo5eFdMbGVsdWNhdUpURUZJV2lvRGh3UWl5a1dr?=
 =?utf-8?B?QVNxeWE5VzA0aWVTSHZHampmMkc0ZlRHa2E0RTQ3TEpzRGJXb3VUamQ0Q2xn?=
 =?utf-8?B?d2VBTUU1MFdPYU5zNXA3RWVhMmFGeDZxQVpRMElFcWVQMGFHZnJ0MHZwNzhz?=
 =?utf-8?B?N2pjZjhpL1IxT2p3UWo0elkxUExJZ3RZN01GYzU5MlpxcnpNL2p0NllqOHQv?=
 =?utf-8?B?Z2ZiQ3dUV2VDdEhYMElLb2JjaElVd2l1Wk9YREVsSmlnSUtpemliZi9ka1FC?=
 =?utf-8?B?My9XaUZjNTlzRVBXZ0VhcjBYYkc2VDJ3VDFLNUtjalJCTWxFZnRWZEthYUM1?=
 =?utf-8?B?blNPN2RGRmpQWXB6WGt2aE9NZy8vNktYWHlRNEJpQkJkc3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRGK1IycUxOaXI5cFBBZ0NCM05MVk1UMUsvUVVDNEczc2laMW9lVFBjMTRR?=
 =?utf-8?B?bFBNaDg1b08ycXlCNlI0VVhRV2JQaFhPRTljMTVtN0cyYUkwVnE0ZlVqSGRU?=
 =?utf-8?B?VGdvTFdSVFo3MjgyU0FGSU0yM2Q5NEJTcjkwK3RjUEF4NVRQanZFZjRodlli?=
 =?utf-8?B?YUo2WGpicEFNWUJmS29YWlNBNmlURUo1emErOW9WWG91Mk43TjJBaGdnQ3c2?=
 =?utf-8?B?ek56N0tRbjJmVjY1YVEwM1lHTzJibzMvZkU5YmxkYThYR2kraFN2YjVLRVFV?=
 =?utf-8?B?Njc4eU9SZDBDZ29Gc0xsa1ZrTjVBQ0tLYVA4K2xxYXoyck9JZ2Q5K2w0RlVP?=
 =?utf-8?B?ZHN4WGdiVXB6dzFRSzgxanREMmc1QUV2czkyZHNTZUpGQkNKeTJkUmhzZTF1?=
 =?utf-8?B?YXlMa2tac2hjWUZlYUhXYmhXZlpJcnhPU1RxZ2J2RjRpYnlBcE4xTmFKQno0?=
 =?utf-8?B?U2VqQU5kcjErMFJoYWhINGd4RjY3SUJJOGdUSm50TXpuNXF2dTNEL2tpMUdu?=
 =?utf-8?B?ajlQQloyVjNmRnJ3d0lTOFkvYmszblc2eVJGTUhXeG1yNCtPK0xvajRuVXF0?=
 =?utf-8?B?akhnNFFnWnA5bWd5TDdEN0tYdSsyc2F5eHRYeklUR3ZNRDhPdW1TRGRNZFBl?=
 =?utf-8?B?eXRPclV6R0QzUzRWMGRYcjRHL3BvUW1hQ05LbGQxeW83NWdvdEZPY2ZGdFNW?=
 =?utf-8?B?MEtHaXliaFhPZjRNd2pQNVAvZENLckgzZDZRZTRPcWtPWXVoMWRCQWp2YlVz?=
 =?utf-8?B?emRIWnJidVNEem40bFlkdlVoZU15ekJYYzFTdCttZER5MjA5Tzl4dnFrM0ph?=
 =?utf-8?B?eDRYdVN5Y3RpZFB6aVdhYmRUQk4vSDJQSmVSdHJGL0hGNzBRQ3FPc0QzWkhP?=
 =?utf-8?B?WElRZ1YyeFdKR3grRzJhbjZzRW1wYUZ2Zm5MK3BZdE5ZU1VHSm1ZR3IzVUZr?=
 =?utf-8?B?NHJBZUZEMDl3RFNYOFZ6RFhKWHVjTXB2OWtkMzcvNFBIV3hPUVoyTDEzU3Ir?=
 =?utf-8?B?ZWNjOHpybVlXeGVLTUhIL1FsbUNpWCtPbjJxMm1qaWtqVnIrV1VRM2lKdFlD?=
 =?utf-8?B?SHR0L0F6Q2N5eHZsSHVGU2hHTEx3NkxqZloweTJRTk5qVWRzNmo5QzZkQUxn?=
 =?utf-8?B?dndvcTNGL2hFQU5rNUpCRnNBMGpibkJreFpQWUZGUlgrTit4Nk8zUW8zcFVP?=
 =?utf-8?B?c0xvQmJ1dlcwdDIyckFvclRyYitmODZrblJ4N2paamtPRy9Jc2ZoeE9NRWU4?=
 =?utf-8?B?T1QrbUNBa0lrMFNDWU80TTN2Ly9telFiZktaTzAvTFMyQ3d6WFVZbmd6eDJD?=
 =?utf-8?B?UkNPcVdyU0JROXdjVm4rWTNuR3N6TWtoa2ZjOUNWUzFUT0d0RkN1R0tCWmov?=
 =?utf-8?B?b1FnenFqbXhyT2JTUzJBb2VqOFdRRkNsa0tUUzM5eE5KbWV1RTl3QWRYdVFP?=
 =?utf-8?B?QVZ4TmFnVWlkUDdoZ3hmZE01MVEvMmNUQ0FCS09kOEV0THRnZGZXVGpHZmVI?=
 =?utf-8?B?S08wN2FpRVFIOGtHVzFKeEZkc2I1VktwZWNuYXY0Z01jeHRvWjVDVjV2MHRx?=
 =?utf-8?B?VUVmMkU4MEFLQ0pvd2NrZzZRTWxEYlBsNUZKZEZnczZ6WVpEYlpyRzVNNFFu?=
 =?utf-8?B?czRWYUVhWVlhaUg3cVZjWEdXSkc0ODhaYXlPUlNQTVFJYlRWT3BGa3QrS1Iv?=
 =?utf-8?B?Yk02MnlZdHhLKzFmV294N2pMaHFVRmN5UFRtZkdRTzdGSTZUNzNTZTAzc050?=
 =?utf-8?B?a2pnbkY2YWdFQjB3TE5OajNXM0hwUEtZN3l3ekFyV3RNYzBVT2x3WUtHOER5?=
 =?utf-8?B?b0JWRWRjbVVYN29qdHNlZEVzYlBVRVBVL1gvY1hpbVFEZFhCY3FEMnJmV0RT?=
 =?utf-8?B?VW5xcnhmSkhjWXIrUzJMczkyZzU4Q3doQzBtd2JqRmYvV1hwTlFRbjJjUFZG?=
 =?utf-8?B?ZWJnZmFqejE1bXliVjgyWnRRNldpdU9Ob1MxREgyd1ZPUFg1cmpUd29meHY2?=
 =?utf-8?B?UTcwVG9vSE81a3I5VGZwcGVZb0dkWFAxVTl5eVRWblRlTmx2OERGc2UrTjk5?=
 =?utf-8?B?SlhqYVU0T2Uycmc2UWd6RWdkNlNyelg2eUs0ZVlLTmxVY3l0UTR6RUpZOEYx?=
 =?utf-8?Q?zYWab1cjnPrXZ4aN3EHjeO/xG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a05614-7db4-4a07-9f59-08dd9912e1ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:27:33.7039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GMb3QKzZDUsFjR2vd/mBojviksGzzveA0IZ9INhUswGa8wjuNlAllryxtp7tX+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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

On 5/22/25 05:43, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
> 
> The msix table in virtual machine is faked. The real msix table will be
> programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> by nBIF protection if the VF isn't in exclusive access at that time.


That explanation need to be a code comment above the call, apart from that looks reasonable to me but I'm not an expert for that stuff.

Alex and/or Lijo should probably take a look as well.

Regards,
Christian.


> 
> call amdgpu_restore_msix on resume to restore msix table.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 97389168c90f..1f38ff1e42d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5051,6 +5051,9 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	int r;
>  	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_restore_msix(adev);
> +
>  	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>  	u16 ctrl;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>  
>  #endif

