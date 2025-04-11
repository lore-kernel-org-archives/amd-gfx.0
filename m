Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC28BC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492A810EC3B;
	Fri, 11 Apr 2025 17:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbbw9TPa";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567A710EC3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWOC/vAn/Nutb1merLGflO/qeKuVO4YpXvd0wbSTzy6ExsDu4UrNwDNEPfrtJvNoXYpcVl84m/8OtQzEBenAHEE/ecezIQJB/82S2xQgsRhUVXVZIexPAm8CYlBloTl4maFAwoeBIyoTJAG75LuJjmv/L2Fv37QuKUmBIr+j8DKVqOuG25V6odTTqEFOWISgIA0JGi5EtlEhZU0sQBA2+9Evha1OpYKgpO8bEdXdlH4qEsyz+Dhjcq0Epa4CfmcrKQ2mnW1Lvqwvl0U+FH1+oyvApMpX2KWNg4IV3ZiionHQVA0Q+9n6tuO1vPKDPUDev/u6fxTLn2NRb80coB/lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udV37i//GO2rzvMYNGctpCMpWM6iM0U4oh8u+TAuI7o=;
 b=pj2b87uIgwpaBHRnQlp8DzLPiEFxt6jubCpuYgGnk2R5ZF8Kt85sh3u2yBEbankI+yI21UQ84YjDzYHCYkIoBTsDWVaE/zyVD5HmNzW2DJCVKUS1pTwVkTwfcJbJyJknIIsTD3ZkTBBIshrhIJrJC0F5yBHCXCyZgjmNo/VPpuf7sZanOu2bxQcUnvGYbLAg5ZLgOvnS25j0rg/4eghDMg8zDkhhIPSwILy5v24VCtOvMazddq+B0mANFuuihHI/uQhxO29SGk29VrJkeW05NVx+ePVkXaSaIhGtYp//xyThmjuAPe9JF0JSBz/pS/rSpAbJPoS75dd7HYsK0VSiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udV37i//GO2rzvMYNGctpCMpWM6iM0U4oh8u+TAuI7o=;
 b=wbbw9TPaZx4yzUWihrw5Rxwy5j3TxSh42DlVBvH78Jke1IWUn2R8AknabfdKfZ3i8pFp238DgPCwqXHb4en1rBihOFTk30U1U13K7LQzUT+Hzwdzfx9UWUBrJmyaEUffoPB2cBrGtX1vIkTXydwmVrgfX8CGaTK3ipYj4VojXm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by SA5PPF5D41D38AD.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 17:13:42 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:13:42 +0000
Message-ID: <1add560c-4755-4134-a657-6afc88429ae7@amd.com>
Date: Fri, 11 Apr 2025 22:43:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] drm/amdgpu/userq: add UAPI for setting up secure
 queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|SA5PPF5D41D38AD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2fa0f1-4c90-4ec4-d55e-08dd791c3563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVVrUHlzWVF1TmtUVzFabnN3Y0xYOHk4WkhHMTdzcFRseW45ZjBPZ1UyMGJ5?=
 =?utf-8?B?K2RBMEFjckZJVXA5aUZZbG4wRWZReFBWcDVIMTN4SlY2dHpkUlMzdGNGQTVH?=
 =?utf-8?B?VG1ONk1hZk43MC9RQXpoeXkwZVR2NlVWSW5QSHBXM3ovUCtpMnJKT3V6VEp6?=
 =?utf-8?B?S2xFV0V3UlM4eDFmKzRiL0VzNGxkVXVjUkFmMDFDQ0V6cHVEN3g1U0RZYXJh?=
 =?utf-8?B?NUt5VWlDMTN4VHJSRkJrenVXK09rMVFKNXU3eU1JbXJwc0hadEI1Z0JQQWVN?=
 =?utf-8?B?TXhkczBDakNtSjZEaTU4eWc5ZGgzbkUxMEdCejFKQTFvbStFTzhDUlAxODY2?=
 =?utf-8?B?bmlianovdFZWODVTeWZRcFdYNmtCOHk4U0ZPUFY3NjZ3MGRKY2RmZUpiQXox?=
 =?utf-8?B?di9NWVFDR0hJZzV1ejQ0U3JDb01NckkvcGpuZHFYQi9pNWdMbktZSG95cW9I?=
 =?utf-8?B?S1Njd2NUb0l0WDgzdDU5RDQ2Q3pjdTBWMHNNbjZkclJMODBueDJRQ1l2WTFw?=
 =?utf-8?B?RFBUVGtRSWdCUjFTNGJCVE00ZzZ2WGRzQk8rZ3lNWFo3RGtPM1p3cEUyWndj?=
 =?utf-8?B?bERZeVc1V25IQWZWOGtpNTFKQUFZTW83b3JzYUNqY3hwS1JUNktrWlRqYUs0?=
 =?utf-8?B?bHpvcG9RRjlKYWpidXpuU1pLWTNSRlVBNjdEL2dxTTNJQi8zTU1GMkdmMDY5?=
 =?utf-8?B?NTQ2ZTNrcjd6bTd2THV0eXI0ZVFqUVZMZmRNajdjZXliNXJmR0FBYVhidFNr?=
 =?utf-8?B?V2JVendJZE9RRXZjbWh6MlQ0VXM1YXlCZUJpa0dGQXIwdEc1MkFicSt4Z3ZJ?=
 =?utf-8?B?WVY4U0J0MTVGVzVZNFNtYWduWGlBSnJaWlRaMU1STC9iZzVUYUs5ekpJakZl?=
 =?utf-8?B?WTRpR0xhVEZrWlFIMU5CUGlzWG5jT0RCZkJsT0VXa252ZzVaYWFIcEtXWmVq?=
 =?utf-8?B?S3dFSnB0TUhaeUtOaDVGQW52L0FMSlJMWG9EbitRT2N6aVFXeE0rbmtyd3Bp?=
 =?utf-8?B?WWNoSUNtUTNTWjY2YVo2ZmZaNkVzSFFQQ3NUZjNIdjFrbUc1N3hDeWJkUk1H?=
 =?utf-8?B?NitGdldISmNVL2QxelJOSkFYMDJYdVJFSDIvYThYSEQyWGV0eVZXeWFocjJ2?=
 =?utf-8?B?R0xqN1ZacFZZTTdHK3hMQkhxZGxxcm9kUEpFZnZlN2Uvc3NGSERUbmQrSDRO?=
 =?utf-8?B?UEx5TEpUYnBDR1RBMW9aNzA5VUNVWDVJdWpDU01CcWJtVEhHcDZ0QitGeEcw?=
 =?utf-8?B?V1ZLa2pRVllwSVRKVjRqYm0xZnQxZVN4a2lmdnE5NW5ZakkxTldOZy9haVgv?=
 =?utf-8?B?a3Yyc2Exc2FPK3ppZlN2Y1hvWUJCblYwL3lRSGtIbHJJUlJWTUkwSXprOG0y?=
 =?utf-8?B?ejVwSEQ5NFJOQ2RlUlFXZE1oZjU4NWhZWUJGS1lOdTh0N3ltd2VlVmR6NUVP?=
 =?utf-8?B?WnU2WFF0ZHpqc1A5SllMV2w5SytaNzA0eVlkemlzSjF3WEJRc0lPQTBPN1BH?=
 =?utf-8?B?cm5TNWc4Ylg0WXZxYUxXYjJSSTFjM1VqR1JJRzhZdEw2UEdCcFp0K29BaTZZ?=
 =?utf-8?B?MGRmakszdmNWUkFkWUhsaHZPSStGUUdqY0pNdWl6WExvWW1wN2lzUU8yRU5j?=
 =?utf-8?B?TnkxMnVscXZoa0p3Sk1sc0JhMlI5QzRuejc4NEEwVk9LbG9SbHFMVCtHazFh?=
 =?utf-8?B?c2JYcFJIRVNFV202cVkyZ2lmVG5qMWVPMUp0QTJXbDdBRVJ1VWJGN0R6aG5Y?=
 =?utf-8?B?dGN6YmlLSFNqR05ETDFpdkxscklzWk9xZDRmNzkrdzYwYldQN29uNHVvWEVF?=
 =?utf-8?B?T2Z1S1Z0ZjRVamlpZjF3NDQ2LzI3dzNqZmxNSi9pMWFIbUtOOGsyc2VlTGQ5?=
 =?utf-8?B?Y3I1K3U0VEhsVXpUOS84cGFLRG1zbXVjYnVaK2JCVHlCOTZQNXlGU3BpZ3BJ?=
 =?utf-8?Q?FrQJq3/EWbE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxLY1pHejdOWXpndUdFMW9kSG1aUFEweGd0VGZhWEZPSXR3clNta3hwQU1V?=
 =?utf-8?B?UjRUUGhRa1NiWnBrVnFySHNVQ2src0ExZE5XeHZJdVBXR3NPOHNJSXpzdTl2?=
 =?utf-8?B?d0loeDFGVFJ4ZzZETjV6aXhPcnBBNkdGNW9RWVgzVGlBNElEc0Nnbkdiemxo?=
 =?utf-8?B?c00wR2xIbm9Fb2ZBQm4zRFJ3NEVYVXhsYmw4aHdwK2hlZThJZzIyeGx4NE8x?=
 =?utf-8?B?OWQzdmVJMEQ1Sks4ak4ycmxFK3lqeTNEdDQwMkZsQ1A1ZzRMcWd4aWx3OUFi?=
 =?utf-8?B?NlNNeEpPalBNTzRRbm12dHdqekVSUUFWVXN5cjJnZER1Rldyd3BDQzcwL0Vu?=
 =?utf-8?B?NXd0c3Y2a2FSVVRjZVNXRzhrQktFWDFITjAwTWRSQll4bGRRQ2I4dVFPeFo3?=
 =?utf-8?B?dEhzZ0xwcjJxRXliQjZRNUgvOE1naUdkWG9EWlFpb3cvRnNBbnZ4blZhMHh4?=
 =?utf-8?B?eFkxdCt6dUFwZTAvNXBUR3dNd1A5V0tNRG5uL3lBMzZEQ0k5WE1QTDZXSk4r?=
 =?utf-8?B?M2F4Q3Exb3gxMHNtNnNpNWRmNjI3NTVMcFdLRitQR2IvQmNDcC9SdUhVSis0?=
 =?utf-8?B?OXhwWjJqa3ppNjhGN3BCS01jWC9adnl6eWNNLzhRam93RzlYTWpqRDEyYkZn?=
 =?utf-8?B?TlM5R2NJRHpudlA2ZjYvSDRwbnFmRmNGQW1HYitITVdmaUtzZ1lvTWlPcmhE?=
 =?utf-8?B?ZnYxQmw2SkRiU1dCeEZ1WmNHczJ1bHByd1dqTU4wZENDRVRRV1doSDludUFW?=
 =?utf-8?B?Qll3MkVVVU5qU1ZYZklDcU1ORnpqYlNUbHNtSGdaQjR4dWRUT2d6cVFYbmRr?=
 =?utf-8?B?bjVSMkM5NE10Y1EyYk1yL29hUXBTdUM5aC9PSmFXUFk0TUw2ZGN6Tlh5eGVy?=
 =?utf-8?B?Z3A5bzJxMlcxU010dFhBRHEyQlh1WUtJYkJGNEVqL21aZjJ5bzBSL2xycFpx?=
 =?utf-8?B?aTJ0UXBiMXJBUkVWS0YrdVNuMFlMYlhaU041Ukl0bFd2c0RYZWQwOE95dkU5?=
 =?utf-8?B?RnVBQXBFTmI3MUMrQks4VkpCdERQandaZmRSbnNVZzhjZFgzUmhHMDR1RlN6?=
 =?utf-8?B?emI1aEFaOWxuWUg5SEgwNUV6OWJnU1FqMTlPdGxWWnltM3pQN1JLT1R4MGFB?=
 =?utf-8?B?QjBvUU5seWVWczNuRUwzVEh4U25xMWU1ZktKd2p1TDhsdGRuZUoyKzRxaGRl?=
 =?utf-8?B?VHBMYmdBUlRyRGs2WGorcEZsdlR5TWxJa0FHOU56aCtJYjFYQXRmSDJxN0xa?=
 =?utf-8?B?aHhqbHR1d1ZZTmJwRW9NUDVwUWlWdi85ZmFkYlllN0psU1owaHBNWnVWVVNC?=
 =?utf-8?B?ZmdpNVJzZEdRNEJlUlIxeXBqV3ZsNTVFS202ekY4OUc3bDZ4UjNWOXZydmhT?=
 =?utf-8?B?VnIyUGw4empBK0ZWcldqdkJIV3k4cXloOStjZ0xGYTRhYlRjWUNDcldEcTFC?=
 =?utf-8?B?VUJCeWRrMjdFT0Fzb3VnZlJWNXVGdHJYSFRFTTJaR3VPazRBVUtqVmpsdklG?=
 =?utf-8?B?STZ0aFcvdjBBRGxCTDJxNVpYL1VjVEZyaXFtQWIxdWh1aEE2d1Z6ck50eThU?=
 =?utf-8?B?cmdoakhBSU13Zk53ZUszMGZDWFhpbVY4MEVrSXJPNlNOYThqS0c2dzh4T1Vo?=
 =?utf-8?B?UDNLdWhsRjM0M2dtZ3RacjlVOTRkNzlCKzB3d0RQSDBNSkhEQUJkbDNoT0Mv?=
 =?utf-8?B?a2x3VkJaYW41eEVDbWRnblBKVzJqUXFpczJLZklYOHQyNXJKRHlGOGdLTVBG?=
 =?utf-8?B?TG0rc1VHVUg1Mmo1WFlkSjJMVjl6ZlJQQnBKTGpGQXZKY0VDQ0lWb0Y5Snox?=
 =?utf-8?B?K2F2cnIzMWEwWHBzMVlZaU5BSEtZdFdobUhtUnJkTEZ0MUlTUk94WEhtQTFL?=
 =?utf-8?B?LzBTM0JMZEllTDhGRU1icjBDV0Q5U3FYcDA4SFNmdGlRRlp4b3pQdU1OUUoz?=
 =?utf-8?B?M1pRYytnaVZZUGQ3RlFBVGgyVTR6dTY0d2p1dTQ2Sk9RTEc3VmhZNG9sUEVL?=
 =?utf-8?B?UmJOb1d4MlhBVVYySncxaWJITHlCQVJBd0wzWUZjbXRzb0lIRlhHNFpRUytu?=
 =?utf-8?B?WmhUMnJhYXZhVlBTd042djU5aHE5OGJoVlpVSmNIa2s1cTJMQTBFeC80R0JK?=
 =?utf-8?Q?QQ0NRq7+izTkkRF/bhWJJCcuk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2fa0f1-4c90-4ec4-d55e-08dd791c3563
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:13:42.1387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbz13Qms6zbSeekeEBwIuzqRsHyx7dUW2XQhGgIoVMt3f6CQYgH+RxFdqFEkbrckeK99VI1XCpqPKj6fH//HtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5D41D38AD
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> If the queues needs to access TMZ surfaces, it must
> be set up as secure.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 8719754c777b4..0ca4b3b961eb3 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -336,6 +336,8 @@ union drm_amdgpu_ctx {
>   #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_LOW 1
>   #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_NORMAL_HIGH 2
>   #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
> +/* for queues that need access to protected content */
> +#define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
>   
>   /*
>    * This structure is a container to pass input configuration
