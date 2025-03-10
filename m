Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17B3C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 06:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C55B010E125;
	Mon, 10 Mar 2025 06:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0SO66OT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8D410E143
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 06:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvomd8CYM1VOok+7fS8Ydy1AbsdyDS9hm/EVofN3GS4PF8TBiDwdk6Zj5PqcbxsO7fC8DMfItIoOtnRdK9woiongmTykg40hid6+h537/PZhdkQBiVebU23vYOarN+Aj/ovFy+fRoPmP8siEeq1wlnYHmzSKenNcsWUgeDA+9d9hAUiA9Beq9yLV4S17IyXSkGHV/NGerVWQtDtNeHTN8IyStBqF6Lpzhsrqlqd72HiiwJS2h8o6Hg3Ixaqp1npROkBLmookVpMTbdCzhqES2nxhIYcnKgu54pGTCzbTQIeSBKxB8uQiHZuecbFpg+hNqg+NIK3SarwQ47PlFWRjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUq0jEhUIQ4gC7kDHIFxWOGzNO87XBWvDOUvI5DvdBU=;
 b=ar7uYjZqZEKOV3BqsSfelobGhfbQHcn4dpXLORaZkeWBjr3ZRLAk60/qvPwwTcHciZNPQNnB7QztEMOkt2rV32k2VR74zkDMRFrI+hqXMMhB63h7guRS46V2b5J4V6PZJvA7dOCPE/FjkyeaG4FBG/ZU/Q2GW9gHzeGiSO5+X7hE0tOwNfGG68TWQXeT93XOeaptMScXpMVGA73joJO12AVqCMqTvjTL+FcjpP2zuQx0tooQzejmOfIcVbV5s/YYjchDzHF6LyeqiouHxN2igldQcxpSyBye2Q4ggzno+8lNckLtY3KqfMBDA2xQiAjLaPm2EEmGeDaHBA0g3Ut/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUq0jEhUIQ4gC7kDHIFxWOGzNO87XBWvDOUvI5DvdBU=;
 b=O0SO66OTr+S4tHxUQa6ppcBmxBR834VB+oIhr1OwdAp5IicI+lliHWaPN9fSuiHizuXQwd4J0/Yds4j+5DzQj91OKqkozKdh05TocHZZa9WywDwbIfTk2xltASIholn/1wBcGutrjRTopM61ewj/w+WtLUwGAPb9qK1JWzMMGJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 06:24:45 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 06:24:44 +0000
Message-ID: <395d4c0b-bac2-429b-a28f-b0650e878b4e@amd.com>
Date: Mon, 10 Mar 2025 11:54:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250307151605.946109-1-alexander.deucher@amd.com>
 <20250307151605.946109-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250307151605.946109-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 527ca240-2862-4426-65ce-08dd5f9c3fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUMzUUpwVEpURzQ4NmZEazRxbzVlNm4yREUxc3dkTTlpZ3NxamJRa1QwaWlL?=
 =?utf-8?B?L3M3MkFZZnYvUkNhdXY1YVVoZWRqWlE0N2xlK00zUzVqTy92ZUt4VHI3RGsy?=
 =?utf-8?B?ajZiSnlPZjNHaXlzOE5vK1hhVnpXNTRrbm9uclhxalZud0o2Qk5BN05zUnQr?=
 =?utf-8?B?Y0tVMGdDYmw2ZW03R21xdGZvUkRzcnNIN3ZmZlBBZDFFN2tFRzdPQ1hISTFN?=
 =?utf-8?B?VnZsS09NRGhzdmphTVdtQWloOHVBclh2aENBcHBQQXdrcWp1MWxYUm9zLzNy?=
 =?utf-8?B?TVdYQ0k1ckwyd0xCYjVST1V2cWFjOUlNM0V3RWkwUml4bm9hdzVrUmd0MTl4?=
 =?utf-8?B?REkrL2I2UFV6RzdnUmROb2duVzh6eFZscFIwbHZDTU1HZkdvQ3lBWWQ2N2x6?=
 =?utf-8?B?bGFudFpWOUxqK2xFc3M0eFJtQVpoOTNvQ1pMencyVVZOUmNIUG1lQU85K0tx?=
 =?utf-8?B?eTA5WEZWQUI4ckwxRDJhd3NvOFNGVHdlSUJPaVhRRURTVGJDOUU4M1kvUHBP?=
 =?utf-8?B?eFd4LzFBc0ZKcWVoaHAzYTd6USszWDRiWW93SlBvQTZOaS9BNm8vY1ZDRmNB?=
 =?utf-8?B?R2VIT2NPbG1KaWF4SGdLZ1BCcVRRdVBtVjBja1NoU2VkdHpPVkhFcVlhWXds?=
 =?utf-8?B?MmdHRGRtbUdoSkVRMVRBMHdYeXVUeW9GMWhLZ0czc1ovUzkxNTROVk1hYWFF?=
 =?utf-8?B?bEZOUy9oZHVtUDEvWGVCYUdtYmlhZ0JRSnVuRTJWOE94UWtMQkpVbmVqeVNZ?=
 =?utf-8?B?aElDNjgweHVCd0RTcFAwMVFwY2dHRWtZU3ZkallvUWp1cFNxTk9JYXc5OEJQ?=
 =?utf-8?B?TW54Tk1XODdpeXl5Zy96SkpQOURCTVBlS0ViSy9KUUV0NlhaZ0NuZGM3RzVo?=
 =?utf-8?B?T2hLZTlpc3QyUWovaGVhalBNN21IWUF4ZkhzcWFTSWp1eWVFd0V1ZXVxMzhQ?=
 =?utf-8?B?NXRrczk1U200M0R3SVJBbjgvVngrdGt4ZHFSNW5XaVk0R29EeDA4Ui94NW5q?=
 =?utf-8?B?NG5McVNiSkhyaTlXcnFMS0hkMWpTRmszaUgyUy9BREVVdXFCcDhVUEN6SVlr?=
 =?utf-8?B?WmNPTlFUanB5TDVjZ2hZTlExdFJJOUxnc3FhRmNwV2NLcm9CODFOQnU4VWZr?=
 =?utf-8?B?blZFeHVtclo5RXc4eXZJenE0SXQyeitRT05RMTlhZVlmNTZ1NTUyTzBHRVcw?=
 =?utf-8?B?aldqaG1IclBCa1RRdW80c0NoVWZXUnJPU2hjR3FZbno4Q0d5UWFsdVhrZFFC?=
 =?utf-8?B?bWp2bDlqRHF2eGNMc3RTUW14c3RNMWFmbU03NFpJQmhjWUJGQ1JUS0tOanJ4?=
 =?utf-8?B?VUFUQWlrYXhiZWlDQjJmYzM0dlZRU29jNGNvR0ZCZXMwK2g4cVNXZUREY0JF?=
 =?utf-8?B?VExldEVTbDhmbCs1NDdwZ2w0QjBadXRwMk9oVVhxTWo1UGk5NjJwS2p5QklX?=
 =?utf-8?B?RmdIaEQ1MWl1N3hlNjZSd1YwbGVHWDRmKzRjcjREVzQwSGJ4RlkwZGxXVklG?=
 =?utf-8?B?Y0x5ejhXTTF4RHByQnF1b3hIdVVEL0o4M3lkaXNBZitTcU9keEtmSU1PSk9Y?=
 =?utf-8?B?SHkySkxlTDJmbWpmc1k1Ymt0ajBycGluMUZZUXUvR1o2Skx2VXBGeVdCUGhr?=
 =?utf-8?B?N3FpS2NLbFRQUktpaGwzK1F2OWNzSC9KYjRNWFlVV0k3QW4zUDVjMkluY2NP?=
 =?utf-8?B?TGZGL0NWMDF0NWkyU3NodE92QWN1T2h3NXErVVhjRXBicFJRU2FEWDlyMi92?=
 =?utf-8?B?UXJmNGJuSEVkeDJOUGdDcHZSbGNhS283M08zQXBoSFl4R2FaeVVBRktDZEg5?=
 =?utf-8?B?R0JvcVdYL0l1dGhoaDZFU3crZ2VSakN0YW9uOTBYK3FNeWlMQmpUR2YvOTVY?=
 =?utf-8?Q?noQ2QG1y9pWst?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRnZWVyZU9ybDR1RnVSRkpualBOZGdKMkpoOGNYRm9NWHFHTkRqMkl3eHRk?=
 =?utf-8?B?SnVlbFB2UWUzS01IckVqaFVUOE9rMURZaThqWDRpMHdialFIQk15YzZMQS9m?=
 =?utf-8?B?ZE5hYUhWQVJobXd0NEswVE1OOWNrY1hmcVVZZVo3OFhjWCtNeGhLTHBqYU5v?=
 =?utf-8?B?TDIyTFRtbGVFRWhqeWt6S2JWNlo4cy9rOFBrc1FqbWY3STdLSnFRNzhTSnp1?=
 =?utf-8?B?cURLVFc3UGNoYmZzZ1VVTmxpaHdBWGpzUFBKMUVpczFYTXk2QUszMXlmVTQ1?=
 =?utf-8?B?bVdvOEtHUXIyWW5YMDRTN01obzVaMzBaZ0FCdEFhU21QUTFjOWp2UTUzektJ?=
 =?utf-8?B?cTFQMmRORWlvTUw5K1Z6Q21pQ0xSTWs5ZjNZNGVvTEJwRXlzeUdlQVpKYmZ6?=
 =?utf-8?B?Mm1yZ3BhQ0tvRkU5cFpVK3U3U3QyN093YlcvVU5aWk96cTMvcHJ6TFNrVFY0?=
 =?utf-8?B?QmNWM1JheWlpSURhbWFQS1ppN3ZscE1ZSTM5MVhRbVBXY3VuUDdNcTFBK09w?=
 =?utf-8?B?R2VXY0xEdlpFUGtuL1hQYzEwREV5ellwOUZXaEZYNXFPaldkSzdWM1BWUkxO?=
 =?utf-8?B?Y1pxeTA5N1NoYUpsakRrU3cxTlFaN1dxZWNYbXh6T1VrM0NZdXFWOGZxZWxU?=
 =?utf-8?B?YmdYSFNFaGFORXl6V2pqUU5MYXBSOTVYTVFFOWwxN3lhOUxJTlFKb3FjdlR5?=
 =?utf-8?B?Y0o1bjdlUDVxdlQ3V2hHM3FNTk1nT294VEFpMStWMDZKTHEzMmFBYmpMT3RL?=
 =?utf-8?B?LzBDZ3JxcEtQU3lHWUVDR2F6T3FBV1ZQYkJSbjVQWUgzandmTTQxSWNqMzRJ?=
 =?utf-8?B?S3JLMzhsWDNueUZJbDFIOFBXU2g5OEpJMSthNlpvMTY3Nmd3OGM5WDNzMVNN?=
 =?utf-8?B?eGV2L0FRZHRmVUI4QUZRSmhHcXU1RWFMc20zN3lrTk5ob2wwZDRWenBydzNZ?=
 =?utf-8?B?enpHb3F3UFVwaEluWmx6eWV0NklIYWticFBydjhPK0hQQ1g2VytJNFJYUXNa?=
 =?utf-8?B?dkliNXAvTTJ0Wkk2WmVMZmxLZkgxT291Y0NYY0FCVmpJa05aYnowZ2xMK1JZ?=
 =?utf-8?B?bWUrUHBUaWUzRkJPWFFleXpraDcvK3psbHVyUmg3UE5xYkRUS3RSbkNvNVB0?=
 =?utf-8?B?UWg4OUVwUmJBTnZwcDFXQjVBd2EwNVN4aE9zWWovY1pnTnV0Y01ZU0x1ZVI0?=
 =?utf-8?B?aUhKVWxxTFpXZXUwYS9KNHkzTm5sdGc0NisweEI3UWxSS05sMUR3bUFwV0N5?=
 =?utf-8?B?NnY0WUdUWjZ1Njhkc09hakpocjFGQ2IwT0QySjRDejhzRjBmNkFyNWdYZUhH?=
 =?utf-8?B?Vk9BVFE4YVFWdGwzSDB5ZjVQaTRTU1BlOWx4d1dFODB6Z3ZZYWZldTNBVkV6?=
 =?utf-8?B?cVg5bWkyKzQwdVVWQ0NGVXdIcTFRM3NpQWhRZmYzS2dJcjFaQnFhQnViV1FR?=
 =?utf-8?B?aldJb2ZXWGNtOTAwM0VoYXNyb3liNlVhbnBiOGpaSThuQ2dpQmFhdFo5dXVO?=
 =?utf-8?B?d0JuWERndmxqOXBhMXNIS0VMNFhSdWlaTzR6QWRHSmgwYVRhTVcvM1NPeUVK?=
 =?utf-8?B?V0ZYYndZeW1KTlpua3hKMEYxMUtiWGhCWnZJUVFFb05BU0pkRjVUZUdJV05N?=
 =?utf-8?B?d2k2VWNkNXpCNnJIZ2lyWFZFSWMrVHpIMEM3ZnFsY1RRYkRVUkZNaTlxQUJh?=
 =?utf-8?B?ajdiWDdmRzJ1UG1KYXo2SFhyVzA0ZlJ2NWZnaDUrckZLamRsNEMyS0dJbUlO?=
 =?utf-8?B?cytiS2ZZU3o2QllhOXFhNXY3d1R3TEtYaHo3NnUwZDJibjFFZGxNdzRoNWM5?=
 =?utf-8?B?NGVZNm1rQmZDU2ZRMVFaNEl2NmFWUkZDNDBIV1hMSVpMVXFLWGNKWHBsaG43?=
 =?utf-8?B?STdrRVBocXJlNk15N0t4eXhXaDFPaGtQeHlZRW9qOGpCdnlYUFRHQTJXY3RI?=
 =?utf-8?B?ZUh5ekhFTHVqQlVIWUtadlpLN09oQjFicWtycVZVbHdUMU9ldTJzZDg5Rkox?=
 =?utf-8?B?SmlpRWFRUmFrTjNlekVwYzFjTXZRSmtSU255UVhINGxLMW5XUjJiYUVTUFpw?=
 =?utf-8?B?VXY3UXltTEdRRU1COGExTHl6bDRPS2kyaTI3REV3SkRIdFl1K1FXajBIbUhM?=
 =?utf-8?Q?eWh+aL+qv19IfJsJ0Rzo/CcUS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ca240-2862-4426-65ce-08dd5f9c3fc1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 06:24:44.8695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWY44TQw7u+vE+wK9EtG3O1pFXgcXr+RDB0WN2kngQA0qSwrqqn9f/IVcwLJaPr9ACtMUWeVKKNzZ65K4GyLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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

Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>

On 3/7/2025 8:45 PM, Alex Deucher wrote:
> This would be set by IPs which only accept submissions
> from the kernel, not userspace, such as when kernel
> queues are disabled. Don't expose the rings to userspace
> and reject any submissions in the CS IOCTL.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>   3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5df21529b3b13..5cc18034b75df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	ring = amdgpu_job_ring(job);
>   	ib = &job->ibs[job->num_ibs++];
>   
> +	/* submissions to kernel queus are disabled */
> +	if (ring->no_user_submission)
> +		return -EINVAL;
> +
>   	/* MM engine doesn't support user fences */
>   	if (p->uf_bo && ring->funcs->no_user_fence)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_GFX:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
>   		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -			if (adev->gfx.gfx_ring[i].sched.ready)
> +			if (adev->gfx.gfx_ring[i].sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
> @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_COMPUTE:
>   		type = AMD_IP_BLOCK_TYPE_GFX;
>   		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -			if (adev->gfx.compute_ring[i].sched.ready)
> +			if (adev->gfx.compute_ring[i].sched.ready &&
> +			    !adev->gfx.compute_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 32;
>   		ib_size_alignment = 32;
> @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_DMA:
>   		type = AMD_IP_BLOCK_TYPE_SDMA;
>   		for (i = 0; i < adev->sdma.num_instances; i++)
> -			if (adev->sdma.instance[i].ring.sched.ready)
> +			if (adev->sdma.instance[i].ring.sched.ready &&
> +			    !adev->gfx.gfx_ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->uvd.harvest_config & (1 << i))
>   				continue;
>   
> -			if (adev->uvd.inst[i].ring.sched.ready)
> +			if (adev->uvd.inst[i].ring.sched.ready &&
> +			    !adev->uvd.inst[i].ring.no_user_submission)
>   				++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	case AMDGPU_HW_IP_VCE:
>   		type = AMD_IP_BLOCK_TYPE_VCE;
>   		for (i = 0; i < adev->vce.num_rings; i++)
> -			if (adev->vce.ring[i].sched.ready)
> +			if (adev->vce.ring[i].sched.ready &&
> +			    !adev->vce.ring[i].no_user_submission)
>   				++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->uvd.num_enc_rings; j++)
> -				if (adev->uvd.inst[i].ring_enc[j].sched.ready)
> +				if (adev->uvd.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->uvd.inst[i].ring_enc[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->vcn.harvest_config & (1 << i))
>   				continue;
>   
> -			if (adev->vcn.inst[i].ring_dec.sched.ready)
> +			if (adev->vcn.inst[i].ring_dec.sched.ready &&
> +			    !adev->vcn.inst[i].ring_dec.no_user_submission)
>   				++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->vcn.inst[i].num_enc_rings; j++)
> -				if (adev->vcn.inst[i].ring_enc[j].sched.ready)
> +				if (adev->vcn.inst[i].ring_enc[j].sched.ready &&
> +				    !adev->vcn.inst[i].ring_enc[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   				continue;
>   
>   			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
> -				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
> +				if (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
> +				    !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
>   					++num_rings;
>   		}
>   		ib_start_alignment = 256;
> @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		break;
>   	case AMDGPU_HW_IP_VPE:
>   		type = AMD_IP_BLOCK_TYPE_VPE;
> -		if (adev->vpe.ring.sched.ready)
> +		if (adev->vpe.ring.sched.ready &&
> +		    !adev->vpe.ring.no_user_submission)
>   			++num_rings;
>   		ib_start_alignment = 256;
>   		ib_size_alignment = 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b4fd1e17205e9..4a97afcb38b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -297,6 +297,7 @@ struct amdgpu_ring {
>   	struct dma_fence	*vmid_wait;
>   	bool			has_compute_vm_bug;
>   	bool			no_scheduler;
> +	bool			no_user_submission;
>   	int			hw_prio;
>   	unsigned 		num_hw_submission;
>   	atomic_t		*sched_score;
> @@ -310,7 +311,6 @@ struct amdgpu_ring {
>   	unsigned int    entry_index;
>   	/* store the cached rptr to restore after reset */
>   	uint64_t cached_rptr;
> -
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
