Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E070C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 08:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263CD10E75B;
	Tue, 30 Apr 2024 08:52:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C6d5uUdw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF2610E75B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqOkNEvIkplK/3HK0wii8eVRI9tTR1PgKJkZ4+525xdlx4mPRtnU/bpna2EAo+5IBwxAer0Xg2AnDzQBeMrKPkaA28LkYUTbD/kWDv7Tve0j102tT6chFpirMoqR+/qN+M9SYIkauaI60wJnYnGJwo7eOGETC1uFaFc50iJkuBystiGDzqW+AdafBChgV++ifWErdnS/dTsWSTM9XOywgnttosPvckNKMTRAqhU44lTGTzz5MXiNVPU9hp90R7JflK37Hcc0xSmusD8IBfhKgErsG7QJz3vqgKYaTC2fG0P4Fqpt6xw+Scs3kBqur0DZQKpbsHh0cRgHUC/uqm2Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmN2uuIf6e6XRxxAJf3iQuxStltle3Cy/QbvHhIkIUY=;
 b=eTUFiUq6wwxAmSylVStJHmvDk8Vcx51g/qslm31sGytR0PqOu6jhLpHWEWO1YVF6GT5GOzOIsYd5Mhcm3rfpvczbUl0L1Ksow/wM9rtprfRDN8Hu3QaxNi32b4lohkvB0c/2MTimS9Hq5t3ATLr6u7IleVA5qXgnftmajy3Dp+zwSihLNCsTXAiHrRxjdldzyt1vN5O5GZPV3g5lSA21ZtNNt26I4+4YyWvMwxigHwOuIHZyF4NRDxClXCneHRe2bSMK8QHWp8shKklRKRZavffTO1Z+zgjIkefa7syTB7fMKPgtYUFPIiBdfE66yyWuYWaawajjLcObtIfm01Ke1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmN2uuIf6e6XRxxAJf3iQuxStltle3Cy/QbvHhIkIUY=;
 b=C6d5uUdwooHMkSgS1pmECVdW58yY82Xthe5TC8LeZWm66mlK819mNaZ65tkHjI2TFE0joZuY074H4L+qJLNAVt+pZ+UFrIgYGAqyxw4quvbmfgOKxEbviaR9AKdZZsggyhF03qGOKI2twwFlBDqcU+FFw0IiUpsUX/0ZOWXlLu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:52:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:52:22 +0000
Message-ID: <ca6ba62a-1b6d-401d-be11-a895428a4e90@amd.com>
Date: Tue, 30 Apr 2024 10:52:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] drm/amdgpu: Enable userq fence interrupt support
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
 <20240429064351.626929-5-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240429064351.626929-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f144e6-831b-429e-832f-08dc68f2d977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emVuSy9xWHFkeitVaXZrMTZXeUVyY1FLbTVDMjd0WUVyRzlyQ0Z0dFVwM3Jw?=
 =?utf-8?B?bEhHMWpsNHdGTUxZd1JyVUpwS2Y5eTE0NzVHMmRjQlZYWFRKL3hGN3ZlV1BR?=
 =?utf-8?B?c1RMNzFQeFNYSUVwZW9YQlM0QzR0VlRDZHVSWWFQaVdlL1YreXJ5aHhHem8y?=
 =?utf-8?B?NHNCb0hWSjN6V3k2dE1aZnlPSTk5WG0vYXhRK3U1U3lBcjdqdFh6Ymg4SUU4?=
 =?utf-8?B?dTBRck43MFJ6VW1JQ2tuR3hTWWwyaC9qQ2l6QUtPTFhDZmVINTduUmJadXVE?=
 =?utf-8?B?bE05cHRiOU5EMTBSMnhXd1M2U1AzTVN3NmY3U3JWazFERFVtZm1TWk1Xd2dr?=
 =?utf-8?B?cHMwRUhKQklmL3k3SHF2bDF5UnU2Q2J3RzlEaHhvL2lubmFCcThVYi9yZC9W?=
 =?utf-8?B?bno2S0lFd1NsSlVZUys1a042OUlURDBZNHRCM1k2VHBlMWJlZ0FRSGdrdUFp?=
 =?utf-8?B?VjNkNy80a3lNZStNZ3pETHB5cmpIWmwxWi84OTRzbUZ6OEJqZUxBNzZ6T3I5?=
 =?utf-8?B?YVVqSU80MmZFbTRDWXhZdnp5aTZ3YklLWHR2bWtwMFRMK3VVeUsxWWdzaTVS?=
 =?utf-8?B?N1BQT1lPVW51TU9LTFBBVGNJWGJxckFWZkZTVVg4K3ZBbHF5N1JUZVhEbk4w?=
 =?utf-8?B?aXBaWHhJc2JWVHdXaUgvSktyd0h2SmI2Y3FKM29vNGx0OXVubUMvcVc2S1VX?=
 =?utf-8?B?WUhIcVlwUFFUZmNnK2FqMUJ2aDFlQ29FdmVrTlI3a2NPSURYUHVRbUlYQzFy?=
 =?utf-8?B?ejBKWmR1QmlOdU50eEVZNWxWdlM5ajVDMjlWRXV1Mit5dDA0d1BUV2hOM0Rn?=
 =?utf-8?B?UnJTbVBKd052WGVZbmNIWmpPQ1gvTkRGQmhBVGFUK0t0MWhxZ3locFJ3MTZ1?=
 =?utf-8?B?ZE1GbFhrM2Z2NGFFdWpTTlJGNC85eERsNE9JS2hRL3RVc0pDU25aR251SFNZ?=
 =?utf-8?B?aTdJZEpHNWV5NDZZMlFMekFDaXBGNG9LMFBoc2xla3ltZE9HWlg0R3RCNjFS?=
 =?utf-8?B?KytyOHUyU0lIbHJNcGdJYXBxRkkrdlh5QXBmY0M0cUZRcit4SEI1ZlhhR1d5?=
 =?utf-8?B?OGFmd2tGcjI0K3lGUUhqM3lHZ09ZZHZVMmswcG9lZGkyZzRvQkJ2dG13UEl3?=
 =?utf-8?B?VU9VSDUvQlIrTVhrZGdPb2YwK1ZXZHlzK0wvak5UN3hyMndLRy9WWW1UUlg4?=
 =?utf-8?B?TXhiakJ6dHZZRTRCWUEyTXllN2d5cWZFUEVFZlJPVDRESC9sZUxGWkpCWno2?=
 =?utf-8?B?UEJkK1FNOGxMYzRpNnlQQ1I3OGNBT3ZNaHI3VEZINUN5SDkwYTZOdmU3YTN1?=
 =?utf-8?B?RWlsSFI1cXEyRTlZWkVCeXZHU3hnL015QW5lNzUwUHVFQVh0TWQ3S2IwRVVa?=
 =?utf-8?B?bEpWK2o1bWZUdVkzdnRZTEw0czV4OS8rTG9PdjJ1bVY2MzF5NkI5TlFiZVk3?=
 =?utf-8?B?VVo3ajVUeXFTaEpwRnBic1lOc3lidmZ3NmRTc3JGajE4bEgvWWU0ZDByWER5?=
 =?utf-8?B?aUJnMWRlc01STVhHQmVUTFAwRFNXWVkyYmRueFMrYWdoait2MzFBaitvbzEw?=
 =?utf-8?B?ZTE5T2s1bldtSDBKeGdUdTU4S0E3VUJFUlFCSTVadVh1YUt0UUx5ejg5Z2lT?=
 =?utf-8?B?ZFN2RDZ0WUl3d0ZHUFN5dVpwTERsSU5zanpWTnVncUlET2x4Q0F1c0N6WG9U?=
 =?utf-8?B?Ulhqb29lanltVXBPYklubzh5TUtxb1VkR3IyZUVZbzNtMHdVUUQzbDVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdGVXhBYlg5RG1qTUJ0TTYvQndkZ3BkaTdSRDErZHRiYkR2bSt6MVNpSlhM?=
 =?utf-8?B?UXZZL1QxVmdmQUhubUEySEdyNFRvZjhZbE5oTGdMS2Qzb084ZmdhV3p1RVJk?=
 =?utf-8?B?UzJQTVdDcEJzZ09tZjBYd2Y4aW5OR2FqTmhCcmdtMHdLMjViOFN1bm9vQ2Qy?=
 =?utf-8?B?cStRcDV1QnhuVUg4cGMxWEF2UTBnTzZHWTlSY0FBa2lsUXNqeDlIaC9SZVFi?=
 =?utf-8?B?cDFVR1hWUm5Gc090dVRhcURjMVFuOHdXTTNZT2wyRXNUeURqSDhYZ2RXMzRU?=
 =?utf-8?B?TmJRRWJaVnNrdmZ0ZlNENGZWNXVXWFpWZi8yUkxFWWVJak5ZZzZiZDNsWDJz?=
 =?utf-8?B?M0hoUlIxVnpBSTM3SlR2ZFBrdnlGOE1OTk1SbXQvZDNFWnlyR01Cd3Bab09N?=
 =?utf-8?B?eFJvWG1WM1cxRFMzcExqUmZ1T3oyb1NMSmNrV3Z2dlh2bEhzUU5hazFsWFdD?=
 =?utf-8?B?WDlFSWlyTytDWGNnRyt6N2g1bWdKTHh5TGJBcmhPQ2c3dWtIMkNJNmlqR1Q4?=
 =?utf-8?B?STdQa09WK240ZmRlc1RPY1VHWjJEVmpLUUJiVjZJRFVqR1hNbW5zNVEvWG93?=
 =?utf-8?B?bDNKYjlMbEovRm9MNTFnaHpEc0R2c1MwakwvVXBlOTdYaFh4bklIWFpzYWJl?=
 =?utf-8?B?S1hNcWtVYXdYeHVNUkNUMHptOVZoT01sbzZjLyttTlhmbjJoVjV5cEs2M3BI?=
 =?utf-8?B?Vy9jQ0NFNDJrckNjdlVVOVJoV2xsc3JhbG5UcGc3U2t5M0kzRTVKUXBOdmxM?=
 =?utf-8?B?dXI4Q21GRHAwaWprWUZ4YjJ3WGFUdWx4b0tZTFVTZFZDdXpGNGRBY0xtdTVq?=
 =?utf-8?B?N0tlaURyUTE1T0NrM3JWMWI0UlNwM3NZZHpaNzA2MFZZa05rdUFPVnZtOGxn?=
 =?utf-8?B?NjhUWkcyREhzOXl1RkcrS3plMGRhQUlVTU5oOWpyV0hOMGFMd2k2Z0kxS25W?=
 =?utf-8?B?N2JZNjVvaE1XQUVkKzBPSVdnZXgvL2lXVmV4ejZXT3hMNFBUYzR3YW5yVU1J?=
 =?utf-8?B?SDZCbzJINVNzL3dqdk93STk2WnhTVEhHTmo2RXlVQWcxWGVKQ3VQb0dxY1l6?=
 =?utf-8?B?SDVQMno2cCtxNHdIZHhRem9DRUpyYlM4NzJkZE1BdUdlakxoR2J3OWpLL1VE?=
 =?utf-8?B?cU5YRUE3WllRaU80cGlXUldSWWtwVjNRbENyNmlkVkFtYjkyNzhZL0VqRjBw?=
 =?utf-8?B?OVBBVHVYS3NqSmlnSFdjZStVTzlaZHZMZVU1NlYzSG5pNFBWUDZUZzJKSjFR?=
 =?utf-8?B?RDRkS1VZZm90cXB5bDY2RzU0SGZSNy9BOENvQitYd01Wa1BKMWh5a1hHUUNu?=
 =?utf-8?B?a3Vnc3dMb3c4R2NKdzFZSC84dDBmWkRNcWtTUmlGRkIzY01qQ3NYUXNsRlUz?=
 =?utf-8?B?Ym1SZkYwK2hSTkg3eG9ZOUxMY1F4N1pEZWRjM0RVY3VUKzBPV3lqNU1NSHd0?=
 =?utf-8?B?QmRaVUlNK1huamdjWTBqVWJhQTdxMHFXK2hSd0F6eDIxenkwbjBhZmh4WkRx?=
 =?utf-8?B?Z1NKVWRpWXcvamRTRFRpN1lBN3FPTlQ1UDdwU0Zvam5YVVZZaE44anNMQ21W?=
 =?utf-8?B?M0NzdEpTNWV6SE9VNUJUT25HbFJqK1MvbCtvQldUMm1zajNTR3o5a01rVS9h?=
 =?utf-8?B?UUw0d05RczFwOWJyVW5saWVqRDY1STBKb0FXN3BBSWtYL0cybTNobnZUV2Jv?=
 =?utf-8?B?NWVaelJ1TGtzbTc1QVlnR3ZHY3RwQUdUL0hLN21vZXVmRmk5MWRZYmRRWndJ?=
 =?utf-8?B?K21HWVUvbVB0VGxpN1o3aTZsL2ZVUHN1dmt3VVlrTUZVRFY1anNmSlJPQjdr?=
 =?utf-8?B?Um9XTE9lUVBqR0tmaDF3dTd2WGZhdUhrOVVLMUJtbFN5OWt5bEpkQVdqazdD?=
 =?utf-8?B?cDZBZVh6T3YvbHJLakZUa1AyUlRFZ3puOEtCcDc0bkZwdjZxdlZ6dVE1M0Fa?=
 =?utf-8?B?UXVHYmVrNE9xeVFYUTBZbDAvRGdRc0FhdmtIdHcwSTY0NDV1YWx3aDB4Qjd3?=
 =?utf-8?B?V0NvNnF2UEg0RGJYMnBtbEVKOXlhRG5DK1NUbmxualcxZEJlamJiYjZTMGdm?=
 =?utf-8?B?YlVCaWllNzFJNEh2VEduZkswazFMYzZpWFo4TjY1T2pJZUdqdk9JUnR6LzJR?=
 =?utf-8?Q?A93wKpNJMxzDp8Ymnpa3qQoj+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f144e6-831b-429e-832f-08dc68f2d977
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:52:22.1835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLpb6dE4Z4qSJKWeVM8yheNkJtOlEztYTYjwczTmtfsxM9as/LdU+g3QlltEi9H/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
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

Am 29.04.24 um 08:43 schrieb Arunpravin Paneer Selvam:
> Add support to handle the userqueue protected fence signal hardware
> interrupt.
>
> Create a xarray which maps the doorbell index to the fence driver address.
> This would help to retrieve the fence driver information when an userq fence
> interrupt is triggered. Firmware sends the doorbell offset value and
> this info is compared with the queue's mqd doorbell offset value.
> If they are same, we process the userq fence interrupt.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 ++--
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 25 ++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  5 ----
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  7 ------
>   6 files changed, 23 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4ca14b02668b..2d5ef2e74c71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1043,6 +1043,8 @@ struct amdgpu_device {
>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>   	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>   
> +	struct xarray			userq_xa;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7753a2e64d41..fd919105a181 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3982,6 +3982,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	spin_lock_init(&adev->audio_endpt_idx_lock);
>   	spin_lock_init(&adev->mm_stats.lock);
>   
> +	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> +
>   	INIT_LIST_HEAD(&adev->shadow_list);
>   	mutex_init(&adev->shadow_list_lock);
>   
> @@ -4719,9 +4721,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	adev->in_suspend = false;
>   
> -	if (adev->enable_mes)
> -		amdgpu_mes_self_test(adev);
> -

Since this patch here breaks the in kernel MES self test you should 
probably create a follow up patch to completely remove it.

(Or even better remove it before applying this patch).

>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
>   		DRM_WARN("smart shift update failed\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 6fb75cc1d20c..614953b0fc19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -70,6 +70,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   				    struct amdgpu_usermode_queue *userq)
>   {
>   	struct amdgpu_userq_fence_driver *fence_drv;
> +	unsigned long flags;
>   	int r;
>   
>   	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
> @@ -96,6 +97,11 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>   	fence_drv->context = dma_fence_context_alloc(1);
>   	get_task_comm(fence_drv->timeline_name, current);
>   
> +	xa_lock_irqsave(&adev->userq_xa, flags);
> +	__xa_store(&adev->userq_xa, userq->doorbell_index,
> +		   fence_drv, GFP_KERNEL);
> +	xa_unlock_irqrestore(&adev->userq_xa, flags);
> +
>   	userq->fence_drv = fence_drv;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index a786e25432ae..d6cdca0a652f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -49,6 +49,7 @@
>   #include "gfx_v11_0_3.h"
>   #include "nbio_v4_3.h"
>   #include "mes_v11_0.h"
> +#include "amdgpu_userq_fence.h"
>   
>   #define GFX11_NUM_GFX_RINGS		1
>   #define GFX11_MEC_HPD_SIZE	2048
> @@ -5939,25 +5940,25 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
>   			     struct amdgpu_irq_src *source,
>   			     struct amdgpu_iv_entry *entry)
>   {
> -	int i;
> +	u32 doorbell_offset = entry->src_data[0];
>   	u8 me_id, pipe_id, queue_id;
>   	struct amdgpu_ring *ring;
> -	uint32_t mes_queue_id = entry->src_data[0];
> +	int i;
>   
>   	DRM_DEBUG("IH: CP EOP\n");
>   
> -	if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FLAG)) {
> -		struct amdgpu_mes_queue *queue;
> +	if (adev->enable_mes && doorbell_offset) {
> +		struct amdgpu_userq_fence_driver *fence_drv = NULL;
> +		struct xarray *xa = &adev->userq_xa;
> +		unsigned long index, flags;
>   
> -		mes_queue_id &= AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> +		xa_lock_irqsave(xa, flags);
> +		xa_for_each(xa, index, fence_drv)
> +			if (doorbell_offset == index)
> +				break;

The array is indexed by the doorbell offset, so instead of going over 
all the entries you can just use xa_load().

> +		xa_unlock_irqrestore(xa, flags);
>   
> -		spin_lock(&adev->mes.queue_id_lock);
> -		queue = idr_find(&adev->mes.queue_id_idr, mes_queue_id);
> -		if (queue) {
> -			DRM_DEBUG("process mes queue id = %d\n", mes_queue_id);
> -			amdgpu_fence_process(queue->ring);
> -		}
> -		spin_unlock(&adev->mes.queue_id_lock);
> +		amdgpu_userq_fence_driver_process(fence_drv);

You need to make sure that the fence_drv isn't freed until this completes.

The easiest way would be to keep the xa lock until that is done.

>   	} else {
>   		me_id = (entry->ring_id & 0x0c) >> 2;
>   		pipe_id = (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 4d1121d1a1e7..faa489c75fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -1163,11 +1163,6 @@ static int mes_v10_0_early_init(void *handle)
>   
>   static int mes_v10_0_late_init(void *handle)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	if (!amdgpu_in_reset(adev))
> -		amdgpu_mes_self_test(adev);
> -
>   	return 0;
>   }

You can completely drop the function. The callback is ignored when NULL.

>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index feb7fa2c304c..0051e2d6af86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1276,13 +1276,6 @@ static int mes_v11_0_early_init(void *handle)
>   
>   static int mes_v11_0_late_init(void *handle)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
> -	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
> -	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
> -		amdgpu_mes_self_test(adev);
> -
>   	return 0;
>   }

Same here.

Regards,
Christian.

>   

