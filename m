Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB27CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 12:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6191510E148;
	Mon, 18 Aug 2025 12:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MsKF4ouP";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0200010E148
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 12:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6UlwAvTX9pWasDVG2PZ1dPyaHAg+kzQHGE1cRzA/hrunRLSUb71K91xx5szG5SptMdSbpZafqLqIG/Ih9nHGBqSxwR3rRUsGicspW8pOB2U7t/3vaY3exJLUDVOAhm9A7zq+AwTNcJBAtJk/L8fmkdYk20neDUViDv3T5BmAxbmOEqd0SWKUeMl5Y6dl/9WW5YQuFgmon/Q01TbzKrpro82XPiEXOZcDu39VTp5FiolEb41/UW+M+BJMNg3myQu7YAPukMvcNXwDpuzpK5bwEMdWO7TyBGyaO+YCHw14vSAVoE9Ucg61TH0gtVQqbyPNxoiQeOHgvPt7fwuYmkhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol55R/DSMZYXEKd1ly0TKI7zLERXIkXlKNxI4kYV3X0=;
 b=MLf/egKyrt0lNR3hDQhpKrninCwPF31ZtAOtTt4Wr53r6S2C7rn1uYmf/Z/jxMxvpyyy+sfNYGFBlleLx5un1W50sGvB4RanKl/A+4vIh89dsO5MNrc8UStX0fBFYh6w1t/+wEx5fb7KHUeHqfhiA58/h5wik2fTYL1Yt/XLDz6WrdKAaV1lNX7EL4CxjKYFPpYMB8HStydtCt9r+8Pq67iZsJzSnCcnp99Ygm6NkKa25W/7TnReRX/SRBXv78tKBAq1qw4z17xfBaO06G+HqvIEYx5Ik2rebTqtJuNK0kq1NXCiYP12DH1zRwbjtO89ryfOoK+qJ0Do54FgOitQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol55R/DSMZYXEKd1ly0TKI7zLERXIkXlKNxI4kYV3X0=;
 b=MsKF4ouPmLHHQfvcgyQinq+SCMu03e8yY9OsFl28hOA0sluTAxd4WtySIq7M04gui8ByjvTc/VhjUIQ0kA3rea1lF4mICNlDWbX/2+9b5J4BzXyYiyNcEZktx0jH/7Ou/3sRpyH0D7hyBjLcPFIaq5YooBbkcZ89n906RHKrUOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 12:33:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:33:42 +0000
Message-ID: <6f164478-43de-4365-95b8-0e164f972958@amd.com>
Date: Mon, 18 Aug 2025 14:33:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: dump PD address instead of GPU address of
 VM root
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Tom.StDenis@amd.com
References: <20250818095145.1897303-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250818095145.1897303-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c32b3d-2f4e-4696-b204-08ddde537791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXhIMnlIZmpEa0pDNmpHTXdGVnEyVlhqa08yTzZhSHU1Z1JKQXhhTEtpRW5p?=
 =?utf-8?B?cGlodll3ZW85djhEck1Scm42bGlGREdoSkFZWHc2SFRBU3BJOVhZdXpVUldE?=
 =?utf-8?B?bDlFMTFKbUJlUE9GOWZzWDBFbkFiRWJvNkVWTGZGb254Vk0zMlZpNDh2TG1V?=
 =?utf-8?B?Tyt0K3VUTXhNamZsRllrbE11bDEvbENoYXh4UjBJT3RoNlI4ZG1RM3V1Y2Vm?=
 =?utf-8?B?TDcxRFNFK3phL3gwWE9NYW9ZbnRIbko1NThCOVZmOFFPOW5yRk1VQlRPZUw3?=
 =?utf-8?B?cFUzWWtQRjNtemVoV1R2aEhLNEk4dlZjOHl6YzN3azA2Q1BmZkF0ekZHa3hF?=
 =?utf-8?B?dkozRE5iNmE0TkdBOWRKbCtFUGhwa0hTbldBRTlNNlRmbndUSHBzOUxTUVNh?=
 =?utf-8?B?dGtadkV1cXNNSWl0UjhMNGdibG9QZHEwSzhVcDVIQzFEb3BxTkZlaVNsUERI?=
 =?utf-8?B?VjYwVnFORUVZbXNXM3ZHUGh1ZHV4a21nWFBkMTVtaUsvbjJrOXVmUnFDMXdS?=
 =?utf-8?B?MDFiRHFhMHp3dTNaV0kyUnc2YVFQY0FHcW9oZ2VUUDRkRVNsalFXaHBnTVFB?=
 =?utf-8?B?ek45a1RlZE52ZFFlY04xU2tLaG11TUlSTVBVS0lFRG9UZTloKzVMNG85WmZy?=
 =?utf-8?B?bWtrTCthOEJZeUdFTWJONXhuZWwwT1NOYmJCdEsrTUJNbEorMUNEV2dibUlM?=
 =?utf-8?B?UW5qREViaHBUNGRoa1VGWjJ1RkxNOCtaZHJTbFlHYWZKZ201ZWduR0FvWnRK?=
 =?utf-8?B?MmpoZ0R3dkZIMSs0Rjc4b2ZMQmZkSFYxaWlCVHdUMlJBVmJJazdtdk9rZHlX?=
 =?utf-8?B?bTdwNFhPZjNKZXFtUm9aMlNOZ3c0d3gzNzNkYzBRMWdtUFgxUnZoZDJFRFRW?=
 =?utf-8?B?U2E4NHBwRW9aMnBpbnQzbjJSQnVTRGlxRWVrM2wvbSt1YjJYQmRHY2RkSU1u?=
 =?utf-8?B?aXBZcm81NjJTRjBIWnQ5QUNLam9UaTdpY1Jyd2tBY0tiSnBwSEVpdnUyQUFH?=
 =?utf-8?B?U1llRDZtM3hqV3lqcVNkdFJKVDFVMjAxcVNsNkk3OXZhaHJDK0ljMURmUWsz?=
 =?utf-8?B?YTVkQkp5RlY0bUtjTGxkS3VhSCtYZzVzYTFSaEdUdXJ0SS9zZG1mNVRTM0Q2?=
 =?utf-8?B?bC9qUTEvVUpDY2UwZi9pWWJibitWY0JhaitWS0d4cGR1QWsvQlhVVnhHU3dr?=
 =?utf-8?B?SS9NbXRMVFltbUEwR1FpSnNabU9rMW0zRGR3SUZSSWJXbitMQit6NnZPNkJ3?=
 =?utf-8?B?V3RrTlIycGxCTERMdXBvbmxEaVhJbFc3UkxYRUlaMEZpbFltVC9DT1RzWE9X?=
 =?utf-8?B?ZnFEejBrWkpFdlR3Qi8xWmhMNEhlTjc3dTlEK3g4NlVpUTcwY1dKOVFRTCth?=
 =?utf-8?B?QXZ0eHJ6UFVOVmJkNSsvUENtbHV2dWpyVng2Q25lTXorV1JtZWYrWUM1cVhU?=
 =?utf-8?B?OFF4WWo2dzBJVzRKSGdSU2V2WW4zVDI2RFlQNDc1K1hBZlVPT2FROGV0bml3?=
 =?utf-8?B?KzVKQVVVcVhyNGhWTGIwSElGZnpLZlkwMkUyOUlCcHVrZHBYNGxHR04rR1JI?=
 =?utf-8?B?alRLVUQybjRsMUVqWE9jaWxBMFFZUW85WXNxS1ZWL2Q0UjJTQ29rb3hLU1E5?=
 =?utf-8?B?azM4RHRjZXNVL1VkUmlPYms0SDVQSGYwQzc2RUNqdHhOM0ZBcnV6SUgwMks1?=
 =?utf-8?B?TlJ0ZHYzdVhjMDBvY2JJcjFGeUdwZEY5YVVvTkFuemFrbVduN0prZXNucTZG?=
 =?utf-8?B?NmI3dHo5blJJU2ZXTkwwYkJEZnd5clZNT3ZFYTlMeGJTd3pWRHpOM0JYZC9B?=
 =?utf-8?B?WUhLNEcrNkdJWGVlTy9keGx1aDBhbzRmMThjMFp3aFNGTGtjZVZZdTQrRFF3?=
 =?utf-8?B?K0Fuemd6QTRwSUNMNjM5Z0lxdkZTMlJoUk8ycGE2cDNEK2VUVExsK1VITStt?=
 =?utf-8?Q?IJi8XwTe79o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVVkQS9QT3FYSFNXcld0L3FSeXc5bzg5OXowOEtJNEovQ1RZR0o4MVFZQWRJ?=
 =?utf-8?B?d3dYUGVCNG1VTE5nVmRXU3VNT1VtSzBDNk0xbWxWZjl4QWQrbnRrYWpwZkoz?=
 =?utf-8?B?YlQ4dThuZTc4eUhsY2dXYzl3MFh4MDZwYmZtV0EyTWxZZE5Gb0dMWndGMTZv?=
 =?utf-8?B?NGs1eXQ5Mkd2KzhUWWk2elBCRHN6K1ZZQW4xdkJLNC9WRzUzakJCTjd3QURK?=
 =?utf-8?B?YzhHNkdqMGRBVmlaM2J0TjdramJiQVpnRjdMWlJTM0tuZnNuRUtvQmhrNmEx?=
 =?utf-8?B?VEJ1UEZ4TTJyMDRYZ0pnZE5TRVdqaTNFaXBYYUlEOFkyaDlyNTNoZmx0aXdY?=
 =?utf-8?B?RGtQWThwUjhRVkprSERTR3dIOEU0REFSU2MzUUM2SmJ1SFo1N3laakdvQzZH?=
 =?utf-8?B?SHRjVTI5WjNpTzlHU3JVYWpZbkYvdFVFMmsxbElVTUk5eERZS3ZKVk5XSzh4?=
 =?utf-8?B?NW5nNWJmeEhDTEFCZUt0cE1lb2ZxRHRFTFJuZEN3dG5PWldwMm9tNXZkSTN4?=
 =?utf-8?B?ODNLcDlyam1PZXNVZXhLZkpmdzl2UmdSYVpteUpPUTNnY0RPZnppNHVpekV6?=
 =?utf-8?B?alBpSWhib2FndzdJZ244RjBSSHB4VldFVDFnMzV5aXg1dHpzS3BvSVlSYmJI?=
 =?utf-8?B?T0ppSFJvaFRIV1VZcnV0RHk5dmUzeDEzUEh6RU9zSjNPNUNHN0w4aFNsa1Fh?=
 =?utf-8?B?bVNSdm1iZHlONzYxSFU3T2tNRGtGb1A3SWlLUFhtcEJMSEtLa0JIZTNYSUFH?=
 =?utf-8?B?cnJPQTNpWUM4Zk8vQjJNT1ZMcy9vWG1DWkJIMzBrYVZ3WTBETzBMMEtwTDk1?=
 =?utf-8?B?RzFoTzE3UFBXSDBtUjZMRUM3T2Jiem5jNDVJL0VzdjZCTXk0K3A3TkpLWlJv?=
 =?utf-8?B?TUwvQXhVZXhneEtlbld0VzJjRldBMUdYMU4yeGdLS0gvZEkxeG40RjVVdm5n?=
 =?utf-8?B?OEtObjRoRU9QZkVTbVhPMUJMQ0xEMDV2R0xFK2JUWlQ3UzRzN3N4WjIyYW4w?=
 =?utf-8?B?WGltc3M2cVkwWGVnLzhuQ1VXK1A2MGw5QlRORys4WmVqRUVPSFJLNFNPT2FG?=
 =?utf-8?B?eWJ5R0pCck4zaGt4cE5XdWRWV3N6WXlROHJTMFExbEt4SFY1enU3T3k3Q09F?=
 =?utf-8?B?TWpvRkVGT2d0ZHBaWjF3NXpmejFYa3BMS0diTUZkWGJhTndQUXcxaTBVc0ds?=
 =?utf-8?B?QUIrNW5hZjErRUh0aTF2cTdBS2Y3WGM5bnJ0WUpNL0pnZ2UxUjNWQkdlb0Zp?=
 =?utf-8?B?MGFjeDBRMVIwblJoMGwvZktjdnBmWm1QQ3JjV3N6eXQ2ZFk5by82TFZ0ZlNo?=
 =?utf-8?B?SC90WlpGZFBHaGVRRXRpeWdxR0NrTTBPRGVINHBXNjBOdVlTL3FBeW1MUlY3?=
 =?utf-8?B?VlplQmJQRzc3MjEyRkgxdkxsMzl5KzdSQlUvZmoyWkRmRlZFS1p4Y3VLZzdH?=
 =?utf-8?B?K3BhWFlQcVJPTzhnVVhjTVV0OGpMSDdXa2RydFFmbjdZYk9WRFBhV0I3Wm4r?=
 =?utf-8?B?UkllTVk5MTF6RjcvcGorRzR6VldTVS9xNXdXWFZpVVRvYUNSMVY2bjhDUC9q?=
 =?utf-8?B?bkoxSGlJcmpkOVJKcGh5Uk5EVkNvWEJCTVlWcWdtOVk0UUFaRlNuMytBK1Ny?=
 =?utf-8?B?Qmp4WG9kQ3BKV05NTjhtRCtBMXY4Q2R0M0dldlJreE1QYk5zSUVLR3AvRVJ4?=
 =?utf-8?B?NXlCQk1QV1drVFFpRFpGaENRMkduMmlTTDVrNlZ1bU11Zk12RXdWTktINkJm?=
 =?utf-8?B?UkRGa2JZYnNuTFc3czEzTEVldHovNDZuSUFsU0trSjZFbDdzcTBaMUxCcTFK?=
 =?utf-8?B?MVk3UTI2d2lVUW54N09ma0FVWWZSM3JCbUYvSDMrWU9rM29yVWVCTGlxUHhu?=
 =?utf-8?B?cUc4S3htK1lHS0svTXFtbEFMZ1hGWE1SUkhRSnpvWndFRStucGYwMmowQXZh?=
 =?utf-8?B?amZlVTJadzRXbEhHZWhBbXluZnErRy8yV2s0SjQyYUpMRGVWdkpmMzRVS0p2?=
 =?utf-8?B?NGo2bnU3MDVDZHVkU0NFS28yWjFibU1NbjVmSFhiWHhNVEpiMGIrM20zSFZt?=
 =?utf-8?B?aDFSMm9XMEZHZWpremgvMGdhZHNnb1dxM0d0WC81ZlVvamlEVllSU3J0OVZx?=
 =?utf-8?Q?CP1hoDCH4g7fY0H1Xf/MVVUxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c32b3d-2f4e-4696-b204-08ddde537791
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:33:42.8790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZGbsa+UdYBSSqVx6bMf5X2jL8tBl1w+dQYqupR7RBNe5oRtcMdDPqCcQH0fBqBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

On 18.08.25 11:51, Sunil Khatri wrote:
> Print PD address of VM root instead of GPU address in the debugfs

Better write:

Print root PD address in PDE format instead of..."
On modern GPUs this is what UMR expects in the registers as well.

This way UMR can handle page tables both in VRAM as well as system memory.

Regards,
Christian.

> so UMR tool need not workaround to get the right information of an
> entry flags and other bits and not just an GPU address which hides
> these bits.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 127091de0f34..a70651050acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2155,7 +2155,7 @@ static int amdgpu_pt_info_read(struct seq_file *m, void *unused)
>  		return -EINVAL;
>  	}
>  
> -	seq_printf(m, "gpu_address: 0x%llx\n", amdgpu_bo_gpu_offset(fpriv->vm.root.bo));
> +	seq_printf(m, "pd_address: 0x%llx\n", amdgpu_gmc_pd_addr(fpriv->vm.root.bo));
>  	seq_printf(m, "max_pfn: 0x%llx\n", adev->vm_manager.max_pfn);
>  	seq_printf(m, "num_level: 0x%x\n", adev->vm_manager.num_level);
>  	seq_printf(m, "block_size: 0x%x\n", adev->vm_manager.block_size);

