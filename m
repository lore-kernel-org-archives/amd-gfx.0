Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C99C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 15:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D9711346D;
	Tue, 23 Apr 2024 15:37:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGMGeXOS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD0810F18C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 15:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGafPszlmU4ZwpTLQDP28dRk2zJUZjB4VQ9SywTLzx5AHRle27uEeFEOHTW8sm+I6u/QYbJLBXgFY41PJVlqJUv81CB0EtDz8Va6vfYPdTB3tBDyjYnKN0NvnP2l6JYDSljdpci8a8/HB8SWpYRHtW9qhvw6PewAUEnyyld6py0dPIR/ITgy8+IRW6WGicazB/lOzu1oFykzhCDnKTUHcQTpeC3nA8iNBUUNcr7+esDum/UaB3q9v9NIdAvL39psNJcanIYW0Enu/4d1ghiG9z4F7av45Bvn5Ykww39RG8sXh4bvvXbMXVCxLtSc/7neI4PDQZyMtWt3dLC2nmXgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9/w/ZXoorDJMq09aXYlhqA9TF3BUAzya/kXrr2bTNM=;
 b=SpZgyi4/+0Rg7BoRgErbLlBVBGtr3pI+PbcEkGwIu11RdRtMiIR1i/wd91FbPRohxlS2VtImuWl1eDfI8Q1O5kGIm/TSeVUTn8nB+HjYx9qw3jZEmlkgmO8YtGUqYjKLvTsr1G5Mea9nA6C5mIXHJ8D9p7xSWOy2qaYqgoUdUEZBbXCvJrYz6CwE4y1hFcvE5//R0tU+gFH9JTVU++mWPRyAFh71YN6/tv4CM1GgVtnp8WdO86LFTpSSLj8dPx93ls/ttRj40I8K6uuZzHZWTo8Wi/x7dnEiTh7thMME/ilvXAu8L+O2SjvfY21JN8gIcx0j3ETyjRqDXPotBbExNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9/w/ZXoorDJMq09aXYlhqA9TF3BUAzya/kXrr2bTNM=;
 b=XGMGeXOSjT5aBbmoimX28Vo5aSxMioFZp4QcI58ThmmZ4c48mr73873igA5vG/O9ZfniI+xV7BjeS9K66iJ+sA24nkn/h8mZH+XxIdI5Viz5YQGMaTqWGapJqQRmiRwGklqN/SY8RZPQZZmBhKFJu9oPywC/gKxZSun1f+Jo3vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:37:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:37:44 +0000
Message-ID: <80f0139d-cf07-48e6-bb49-1a7ab561804a@amd.com>
Date: Tue, 23 Apr 2024 11:37:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary NULL check in
 dcn20_set_input_transfer_func
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wenjing Liu <wenjing.liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Roman Li <roman.li@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240423135953.1872483-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240423135953.1872483-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0375.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7c43e2-d77d-4f23-1503-08dc63ab519a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTZhRHN2QUsyUHc5Wms1YXdYaWEyU0NuYURDQ0xhRTM0azY4c1pONFlyd0hV?=
 =?utf-8?B?U05sQVpjcng5emJmSERRU2dha0tibUF4U0VhSFh5bFU5d3ZsbnhoYUtMb1FE?=
 =?utf-8?B?Tktvd3hYQThBZUdWMU0zY25sS0ovWGN3L1dvWEFGTEVjS0JDbVlDWmRjSnR1?=
 =?utf-8?B?dWpuTzlJM3IreVJVNjZFTGl0cjNTd2RmZ3ZpdUtGWWJlV2M0UFlWSDVmck8x?=
 =?utf-8?B?L2pNc0RWdVpzTXg4T20yYkIwbXJWMmoyd3IvOUtZZ2pFMVpVQTBqcm8xMFBF?=
 =?utf-8?B?cldzOTBmanhOWGJ3S2hGVGtLK1Y2VTVqNmNxc09rUWpaTGo3ejdrVjRTTERI?=
 =?utf-8?B?UVlUdmE2WTF0RTBza3MxMHM2R2cyWTR4VXpGM2FHQnl3MzNTTlFtRjB0YUl6?=
 =?utf-8?B?Yk5GeEZKZVhqQmtSVVlsNE11anRjVGdRSmt0ck9welVhV1RmOWhrSVB1VGZZ?=
 =?utf-8?B?NUVJRFJnY0FrSDh1VjNLckg3ZG1EYnJEbnN6aEZQWVl0ZWthTUJqS2NIUE51?=
 =?utf-8?B?K3BKV3ZJSG00WmdORkpoZUVNNGExT28vTnQ5d2NIcEJrOElWekowRU1QMEhQ?=
 =?utf-8?B?blBtU01GL1hHWGpsZVRhVG54d0VKdC9FekpFc29GeHhCTmh5cDBCTDgzbmtZ?=
 =?utf-8?B?YmNZeDRpVy9hSmRDUTlnWW0rMVlkV0kyYXk1eC9RVjVzamtaanVmM0hQZlpI?=
 =?utf-8?B?UHJPckh0VE1YL1lXTGNZRGhiM25WWGFKcXhKU2lKeGFqYnMxc3RIMFZVOUJB?=
 =?utf-8?B?ZS9BcklTRVVKN2lkczBLaDZhVXRpVmFtTDNzUkZOcnFOeWxURTlWakQ5bVNw?=
 =?utf-8?B?N253eHQ4cTFLSmMrZ2NLU0ZsUytiL2UydmtyVUhHRW90Z3Rjd3BQdlMybHNY?=
 =?utf-8?B?eFpVcUl3S2dWRmNBR3ZHQ1FLakdGd3pJd2tQNEdGT0szZ0FHZHFYeWNEZ3A0?=
 =?utf-8?B?aWRlZ3ZNSmJtenhHM1dUSXVRTHBGWG5QNXMrS2ZMM2NxWXo0WGQ5ajlDYXgx?=
 =?utf-8?B?emo3Z0dOZ1N0VUppWUR3VHhxL2hHUU4yMmo1NzZYRWhHVWllMmxiR09HcGRo?=
 =?utf-8?B?aWEySW1ScmJCWEpacGxvVTlUdzlaWTlHNGwrRFV0WkJtNmoyRVJuVktHc0Yr?=
 =?utf-8?B?TzJOVnBhV1Z1bW82S21NVVRmNjdzSzVYTVR4eG5EaEo5WTFTanJIcW1tYnhx?=
 =?utf-8?B?cmhKM1o1WE5udThDRlJXUVVoVUpmUHp3M3JPUjJrNE1jVmVPQk83RHNXZ3RT?=
 =?utf-8?B?YmZ4bWZvR1dJRW5ZVHFmbXNISUlIbkhla2dQZWJSeVo0Y0l5WHljSXlrK1o2?=
 =?utf-8?B?RDJCei9pMjNmOG1kVzVtUGtwOHJMUnpxend0dVFtS21IT3NzNXJMUm9VSnNE?=
 =?utf-8?B?dnVRM2ZCeFlXRURVTnMzSE9YRWdoUHBwN0F0MHJBNzRGc1N0Z3F3UG9WRW41?=
 =?utf-8?B?dHRLWnl1c0xmdFBybVlUbzErTjdpV21La3FIR2JCTmJONE9GQXNyMlFCRUZK?=
 =?utf-8?B?ZU5aYmZhUXJscE9ueWkrTW9PYjRZZ3B0bXJwMkJSV2dsRkQ0TmJvazdnMENC?=
 =?utf-8?B?QkJVVHZMY09TWnp6K0ViZ1JmK1dyaU96Z0xaWDBDTjBuTFY0U0kzWHZIeGo5?=
 =?utf-8?B?RWVXZTJnOWlGYkVEQzNuNUZiSklUT21tVHlNSm1venpwYlpJb0pQNHdFVWxU?=
 =?utf-8?B?Q09WVjZLWDRIZXJueXZyMWd4YStRN3RSbVVwU3JMSXlEcWo1bnpGQThBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCs2MUxNQ1VQSEFCUlIyVjBqK3VaWFpWTFZIMFhuZ1ZvWEhQa2RVc3ZaRDlx?=
 =?utf-8?B?UXQ3K2ZaRWFQc1FYd2IwZkN3Nk1sSHovQWxUS2RzMjBDL1VvalhsR3JuYW9E?=
 =?utf-8?B?REEvKzhhT3BiRU5sVURqSEk5c29aQXgybXJ1ekFiNDN4MkV3TUpybFBXSjZK?=
 =?utf-8?B?czJTczZnRENrd2hNanJQazRFVW1tVXdhT2FRKzhyRzU0NW1EUUhIYk9veVZn?=
 =?utf-8?B?aW95NU9nR0hUZjdiOS9kaThvdXo4anRvY2U0RWxCTk5ibzE3N3Z6YW4vckJi?=
 =?utf-8?B?Q05nc2E3aFdSTkdBWjFTc0FRdld6d3dFdUY5bXRidlFPUnE3cEQwaUxzUGtG?=
 =?utf-8?B?V2Q0UjdEdkw1ZHRtcTNHUDVwcHhWZWFvSXVUbklKaytiTW5uU2N0aWVDOFow?=
 =?utf-8?B?ZC9aczU0S0laZG10TnJ3dzFaVU8xZFM5OUFOVU0wczNqdGdQT2hMQnE2Z2tQ?=
 =?utf-8?B?UnExYVhtcFRLRHVkY3l4SnZvOUtsM0xmd0FRb1VyNlg2dExrYVk1NGQyVXk2?=
 =?utf-8?B?QkZ5ckkvbnQ3REpXdEswV1FSdm9UbkVibEdJeCt3Z2F3ZzNGcGJ1K2RhdjBR?=
 =?utf-8?B?eEN4Z0RsWk43SkN1bEVvL0c5Y2U5czVXZ2R5VnlvS2NVR3E1RW1sbUlsSmpX?=
 =?utf-8?B?cnNvenByTC9rOGFHdTljUW5uWUR0SVVEKytxYUY5ODZCS1MxK3RJWUVNWURu?=
 =?utf-8?B?bSs3QUlLZEFSNlJBVk5VZUpjOWhxL0NFZUZkd0ttb25WbWZ4aXpTWlFJQTZD?=
 =?utf-8?B?aGhJMW5qRGF2dDJNdkZaeStPZ3BmVk9NcVhWemUwQjlUU0JZQXhYdjUzeHVi?=
 =?utf-8?B?d2V3N3FkeUJmWUNUaC83MktnMUJ4Rlg3bkNNcmFwN3lYOUF4bmhmRjZMRElL?=
 =?utf-8?B?Z0hVdEcxVmVoWHJBMHVNTzVnWWEvRzIwd1JkKzNnRkgxRTBZT2x4T3Rud0Vr?=
 =?utf-8?B?UEtkc0ZOOGV1WWltNTF2dDg0TXR5cVZHYzl3SjcyMFRqMVF5Q2ZTNmxnRHZU?=
 =?utf-8?B?b1dxMHlSUzdPOUIvMGhHdjU5dDVWbEEzUzMvc25JWWdZRzg1V05RMnZtZXdu?=
 =?utf-8?B?d1FEZHA4UEdMcE9ZU0wwclRHSUdnNmtBUlgycTA3RVZTZjZGTGdQbS80Qmxi?=
 =?utf-8?B?bzljbktRejRHQUtvOGZ6VnBvMzhMdVB5TFRjZmZRMERJV2xxSU9Xb2RFUldP?=
 =?utf-8?B?V1lqYU5xbnNGcTN4Ly9ubG45N20zWE9YSkl6dVFVR21EaXNhV25NeE55a2tO?=
 =?utf-8?B?WmRQb0xMTFFZMGJzRHYzQzNCRlV3RDBNa0RDQWk1TUdJSVpYTHM2ZUVRazdq?=
 =?utf-8?B?VEl4ZmhOc0xFY0RFSGVwNC81TFpxTUZTMFcxbE5QZHdMQXBoRjlQYU5jbTh2?=
 =?utf-8?B?UE9kb2R1bnFzT0hXYlJsdnkvQjhUdWlnaHRzY3diK0FZM0FhcVQrM0xZdklr?=
 =?utf-8?B?a3MyLzhHQlcza1VZRlZTS2xsUFNFV08xbUNXSHFiRWRYZ1J6cmRBSzhjbU1N?=
 =?utf-8?B?emNKUC85eXFxRHd1aTlTb1BRNlFCb2o5dWtLTTNxRVBNdGdUWUZNa0VkbzUw?=
 =?utf-8?B?ZUx4ZVBTdFJOV1pONzI1RVNWSU40MDNXTnlPUld3R0h0aUF2ZzVEZ0s0Q09F?=
 =?utf-8?B?MTcyckJIelJ1RzhEZSswOG1mb0hJVUZiWkdsR2pUSDQ1NmdEdHJsc2JmSVQ3?=
 =?utf-8?B?Y2FTZEViVnNlSndRYmVsR1dPUjVna1hvOGdPRStMVkxWMmRiTGhPVGxDV05q?=
 =?utf-8?B?djZxc2JzTm5qM0QveFVPOWltV0YrQmxvSTBaUUFSdmFkUHJQUm1RZnpWcGVp?=
 =?utf-8?B?WXJZMHJDaVR5YS9xRFhLUHU0NjhkRW5KbDY5ajVPQ0EwZGhNblNVL2tqYjZk?=
 =?utf-8?B?NFhhNkNuTWlUWks4NHEzdTFUZTQ3bW42SEloTWxUazVwZkZ0U2tKb204TXUw?=
 =?utf-8?B?V1JMbmEvMHVDMDl1UDZVSkkramZZY1NweVJKdGczTDJKSEc1b3NURXZEVVly?=
 =?utf-8?B?eXlYakZWdzYzNW5vUGN4aHI0Y1JtVUl4OFlSRkFvcC9ZZlh0aHdtWTNLRDJO?=
 =?utf-8?B?b0w0QW1STmxqbVpvM1lDcEhTanZmcC8yOEVpaVVTNUFwcUo3dXpNSkJvTmF5?=
 =?utf-8?Q?xnxc1Pn0GUT/9V2vSFOo3QD2D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7c43e2-d77d-4f23-1503-08dc63ab519a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:37:44.1887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFLuTUMyFEzbQlqX83OH/CB72cilg8uS0Li3s0vG304SR770EEPrqhpIn+UxocRYiFqrR+iXpMp6hIQFuYRjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
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



On 2024-04-23 09:59, Srinivasan Shanmugam wrote:
> This commit removes an unnecessary NULL check in the
> `dcn20_set_input_transfer_func` function in the `dcn20_hwseq.c` file.
> The variable `tf` is assigned the address of
> `plane_state->in_transfer_func` unconditionally, so it can never be
> `NULL`. Therefore, the check `if (tf == NULL)` is unnecessary and has
> been removed.
> 
> The plane_state->in_transfer_func itself cannot be NULL because it's a
> structure, not a pointer. When we do tf =
> &plane_state->in_transfer_func;, we're getting the address of that
> structure, which will always be valid as long as plane_state itself is
> not NULL.
> 
> we've already checked if plane_state is NULL with the line if (dpp_base
> == NULL || plane_state == NULL) return false;. So, if the code execution
> gets to the point where tf = &plane_state->in_transfer_func; is called,
> plane_state is guaranteed to be not NULL, and therefore tf will also not
> be NULL.
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c
>     1094 bool dcn20_set_input_transfer_func(struct dc *dc,
>     1095                                 struct pipe_ctx *pipe_ctx,
>     1096                                 const struct dc_plane_state *plane_state)
>     1097 {
>     1098         struct dce_hwseq *hws = dc->hwseq;
>     1099         struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
>     1100         const struct dc_transfer_func *tf = NULL;
>                                                 ^^^^^^^^^ This assignment is not necessary now.
> 
>     1101         bool result = true;
>     1102         bool use_degamma_ram = false;
>     1103 
>     1104         if (dpp_base == NULL || plane_state == NULL)
>     1105                 return false;
>     1106 
>     1107         hws->funcs.set_shaper_3dlut(pipe_ctx, plane_state);
>     1108         hws->funcs.set_blend_lut(pipe_ctx, plane_state);
>     1109 
>     1110         tf = &plane_state->in_transfer_func;
>                  ^^^^^
> Before there was an if statement but now tf is assigned unconditionally
> 
>     1111 
> --> 1112         if (tf == NULL) {
>                  ^^^^^^^^^^^^^^^^^
> so these conditions are impossible.
> 
>     1113                 dpp_base->funcs->dpp_set_degamma(dpp_base,
>     1114                                 IPP_DEGAMMA_MODE_BYPASS);
>     1115                 return true;
>     1116         }
>     1117 
>     1118         if (tf->type == TF_TYPE_HWPWL || tf->type == TF_TYPE_DISTRIBUTED_POINTS)
>     1119                 use_degamma_ram = true;
>     1120 
>     1121         if (use_degamma_ram == true) {
>     1122                 if (tf->type == TF_TYPE_HWPWL)
>     1123                         dpp_base->funcs->dpp_program_degamma_pwl(dpp_base,
> 
> Fixes the below Smatch static checker warning:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1112 dcn20_set_input_transfer_func() warn: address of 'plane_state->in_transfer_func' is non-NULL
> 
> Fixes: 285a7054bf81 ("drm/amd/display: Remove plane and stream pointers from dc scratch")
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Previously plane_state->in_transfer_func was a pointer but that was
changed recently. Looks like this place was missed.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index b60ba2a110f7..58fbdd535068 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -1109,12 +1109,6 @@ bool dcn20_set_input_transfer_func(struct dc *dc,
>  
>  	tf = &plane_state->in_transfer_func;
>  
> -	if (tf == NULL) {
> -		dpp_base->funcs->dpp_set_degamma(dpp_base,
> -				IPP_DEGAMMA_MODE_BYPASS);
> -		return true;
> -	}
> -
>  	if (tf->type == TF_TYPE_HWPWL || tf->type == TF_TYPE_DISTRIBUTED_POINTS)
>  		use_degamma_ram = true;
>  

