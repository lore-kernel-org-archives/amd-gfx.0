Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E5C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 10:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED7110E3F2;
	Mon,  7 Apr 2025 10:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FROHmg8x";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4450A10E3F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 10:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRho4JdlFIt0BZndO03zvPDwbe9wOXcg5QRDzwGLhMM05TZ8UNepUPg8Av89AK9xx43mraE4fcXHhI1zXzEaJGcywp+eb6lQhSlWK9pdxIEWVG+MBGOJoA1abwfRI56t04hYgWHH/bw082M35S8bd1Hz+h5JJeY+/nt6M+okJXM0+66FDYw/S0Loj/65u8zyBlzRl+7kFJb/YbgK4Cp9qfwSUS1t1KAJnpTWC4h2zsW2D67vIbz8eNjOCLmax9QMbo7kUX6EqNe/cBHx59WOOxnYkRHVGAQcZhspVNvqF/nl6c0P5/LhlDx/86iI9+4+BXFfAnFJkr5sOMw5tpRg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfrr+LosvfWIp4sw7NG/bVhCjjbqZ4RLyzosW3tJvRU=;
 b=KUgGu1N8r+0YQra3cUkTADWrYutfszFCIhJA68edQoBp2bQKtMvvtPuCdO6VlrGCGLuPADnUgYRlFWEouwNuJoJLMnvZVse+UCfQsorH5xhnYbDsaI2vDCM7KZuA8AZz8Z8wbVYi/NlUJ/iPRHyEYd87t2dotSphbDM5juRp9Hl8se0kosK8B/8A/7nZct6/sZLJN6/M+DtuvhGfPHjHUQwCSGJ9rfxW/rgGU8s2ro9cxK8j4waUuzOXkB91hf53NjfWE67uFx3yU9RLMJ6s/0FtRngrya6yoYdMCPYh/e8K+E/Q9Owh5ND+ukTMA5oiy4dEvuj0JAYYIdl3kuXTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfrr+LosvfWIp4sw7NG/bVhCjjbqZ4RLyzosW3tJvRU=;
 b=FROHmg8x+mwbBEikTnO0vKDEdd/aWZkABR4aRs8SQfRWMGJUplIJgFzBdTc2XiUWwGpubArN506m6lVVtkuvmNwYqYaxjjJ+Vwn5D1e7mev0Ani8M03wdNERM0WwUUXTtnQKg+tkxshS2UAytlig/5CVi8otihoJfB91V6nChUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 10:30:34 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 10:30:34 +0000
Message-ID: <c7f1ffc6-5ede-4045-bb27-46e140ea5b62@amd.com>
Date: Mon, 7 Apr 2025 16:00:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: bump version for user queue IP support
 query
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: marek.olsak@amd.com, prike.liang@amd.com, sunil.khatri@amd.com,
 yogesh.mohanmarimuthu@amd.com
References: <20250324203328.4174703-1-alexander.deucher@amd.com>
 <20250324203328.4174703-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250324203328.4174703-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad83ac4-2e3c-431b-e34e-08dd75bf3ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS9hUXAyS1JsR3h2cDlIZ3NBL1ZsUVQvUllocDlxbFUvUU1vWkwyS3R0eXB3?=
 =?utf-8?B?TDVwR3M3K1FwMWIxanVqbUxjd1owN1N5UkRIM0NzaHAxZ1J5ejBvVE9oRVNH?=
 =?utf-8?B?a2s3UUxLY3RqQk4yM29DaS9GOEdsVEdtSWkzcmd0OVVtU3JqMGw2MUpoWE5i?=
 =?utf-8?B?ckt4dTk1aUhIMnpkR3NIcFZoTUdCNVdkZ0lwSVA2KzkzbTRCc3ExWld3ZTYy?=
 =?utf-8?B?eFRjc1hMK2U0ZHVCZldDVUV3L3hHWXF0bldoRlJkS3VOWGswcENuUDNOUlF3?=
 =?utf-8?B?bDBIUEFST0p6SWVYazNPYUEyNmUreDlRczhTUGh5V3kxM2c1VktNQnJBdVM2?=
 =?utf-8?B?S21CRUtJT1kwVjhLUDZ2K0gwcDBhcHkxTXVHRlArcW9wSGswNmNmdlpFU1hG?=
 =?utf-8?B?bjZpV0lBRFo5aXo4TThNU1ZSVitTQTRsSGVPQjByQnpCblFxWnJNUGJNTDhQ?=
 =?utf-8?B?bmg1S3RYTWJBZzhvOEtaRndMNHdLN3ptbTlsWVpJdVlMNFFxOHZNOWtXUlpu?=
 =?utf-8?B?TDBabjc4U1Y4djV4S2labmZBVFNOM0EwdHF2S3pVYndBV2tZYVY1WXVBTjd2?=
 =?utf-8?B?T2t2NjZ1U090Q0R2TGZnVi9sMVpnZHpHVnR4c2F2L0ptYVBaMUNBZDlEbGtF?=
 =?utf-8?B?TEZoY2pINENGd0Fpc2ZQcUVwVllweld6Wk1kWDJhc1p3V2ljRXpHait1WXVL?=
 =?utf-8?B?NnROTjFCRlI3dzBIUTZrdnE3UTlXZnRrblhDMktpWjREa0lWUUl4VmF5UHpl?=
 =?utf-8?B?U0s5QU9hV0dtSkIxS3g3T3ZEcW5FRExPNTRIQ1lXRlVFYkpPN3RjNktVL0Uz?=
 =?utf-8?B?R2VsaWRsR1ZQbkIrT2c2dG1GMlQ3SGFuZFN2V1FzZ3hZUEY2Z2tFNlgyZzhH?=
 =?utf-8?B?TG8wV29uN21UQmF2NmVMeFFJVzFDQTJnMFhxcTBReFdNdEd5VkNkdEMrd0xm?=
 =?utf-8?B?YXI1WFlrRXhLWHZHa29XdDVvQmJPU29TM2JzKzZIMUQyTUUza2RpcEtRSU9J?=
 =?utf-8?B?TnlVQ1E1OHpPRVBUTHo1Z0FJckN1c2J2aGhvcmxSSkIvZlNJRVJxUEpzaXd5?=
 =?utf-8?B?VlkvaTdPZlhKbm5UNkljVG5uL3FrdnQ1WXg0S2dWNVZweEJ1bytSK1lHeXl5?=
 =?utf-8?B?TnZ3RkhSazlHZ25zdjZOd0tBTXRqZ1Y0eS9MVFA1R1FiWFZVT3UrZ2Z1NGNG?=
 =?utf-8?B?MFNxOGpHcG85NVdIUEFMdEV2VHNNL3lNS2ZiZG9MV3NUWklOYWltdTlPNm5F?=
 =?utf-8?B?QXpHSmNoaVEweTRJUHF4aCtwOUpGZGlFM091dDZjNVJRbmhBQjdpeUV0SCt5?=
 =?utf-8?B?dzArRU9vWXd1VXBNY3hJTjkzUHVBUktpWDNWakc5WTRoZFdJOXYxNUt0MnJ4?=
 =?utf-8?B?WEJpMUhYNlg5RHVjZFc1aXAzZzNOb1lIZ2piM3ZScm9xNnM5SEt0dW43bDd0?=
 =?utf-8?B?UHBlc25BOXlPbFA3SFcrV2xONHhKT2VwVC9qZzN6SUFmN0tHZEljL0FpS3Bu?=
 =?utf-8?B?V3dnR1J5OGppWjBZejI0YWVIVVk5YU12UmJBUFFhRTlsWncvUFVCdGRYZWN0?=
 =?utf-8?B?L0x2d1FOT0xWQVE2ZnYrRitKbC9QVGNKTzRZYWYxVWJqL1dhRjNTNXBuai9B?=
 =?utf-8?B?TytxYXVRSWFjdDZKb0dOaUhMcUJLT0VhVHYvZVorSmpTLzhtNkxEd01NODVZ?=
 =?utf-8?B?c1o5b0wxcnJFc202cGU5Y3UyVS81ZHFSV0wvQktzbmMvditCdUhMS2MvbUwr?=
 =?utf-8?B?Z0p0SitTcFA4WUgxaEJkWDFlVjArR2VPR1k2VHp2UnptNDhDREZ1L3h4TnNK?=
 =?utf-8?B?Q3NhZTNCZVNFaytKVHVqSmxqRDJQcGFHbW1laFk2NDQwcG9kSVZKa1FJMXFp?=
 =?utf-8?Q?dpx8qJzjVbIcv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9uOXNqcjhyTjYzd1J6SWR4S2g3U1VvSDJrd1ROVGtxcjQ2ZmptSWxmTnAv?=
 =?utf-8?B?NDZ5aTFLNndxQmdzMGM0TlhUeWY4WE5Pb2RZRWdGNHBLdDh6TlFUK3hBYmtO?=
 =?utf-8?B?M2JJcGwvTXB4cG5aS0JNaHNVZnV2WVlnNStvWFZIZWt1TXVQTE8rZ2dKb3FH?=
 =?utf-8?B?YkhYTVBjNVZsSmIvSEpNaHN5T2pGS1U0c1hmMSs0akFJbUI0aDJiYWI4aDY5?=
 =?utf-8?B?NzkvOE1ZOVhmS2hJUjBIWkE5MjB5Vk1xVXVBcHIwa0RvdlhOZTFmKzNKeHJC?=
 =?utf-8?B?YmlCSkZ5ZWxBZ0FFTWpTUUs1SU1MRGtBWmI2QmoyQ2xBeUZDdXBhVGd4VUhp?=
 =?utf-8?B?bkZRaXNhcnBXak9OMG1BWGJFcjhWVVBNRkQzN1R0WlhjTzZuMDVMMHBNRXYr?=
 =?utf-8?B?cStCOHQ2WjhXWTRUVGUwRTZhNVZCYXJnYUJKdkw0K0IxWmZ0aUZsT0dtbHJN?=
 =?utf-8?B?bWprWFZ4VTh3c01WVWtDbmY3TU5OQkVSSmhWcHY2YzFzYk9HRlU5RytLSm50?=
 =?utf-8?B?d1dMR210UC9OSkFkNTR2NW9Bbyt4UlZlaUNDLzhnQ0dCSURzalhqR0VZYkE2?=
 =?utf-8?B?OWcyTGtrYkFpVTN3R1RlY3ZtYXFQczVHdkZWZS81MWRJUlZEVWRxZkdhTlU5?=
 =?utf-8?B?ajVwL05heG4wREgzWURYWmRNcDhKbjBBZzJCQ2l5L0dvTE9oT2RpSTNkNXVG?=
 =?utf-8?B?Z0tUM0lON3V1b2cvdW9ZNG5UZzRRUHpDc3cvblJWWDUzTGEyc291ZzZRWTll?=
 =?utf-8?B?cCtRNkxZZE51UWdtV3FMMVpmUUxUSGdmUVVJWWtFREVKM0NyMzZKV29uMHpn?=
 =?utf-8?B?WTBta2gzdjVhWDFCM2lWbmhiR1hyMFlCWEhBZ056T3M3cWRDSFBQSDJZZ2Vo?=
 =?utf-8?B?dVh4TStERjNTeUpyenhRcjJVS3NpU1QzTGRvb3d4N2hXVmhkdVBJV0hnN051?=
 =?utf-8?B?TW1EcEdUV2trQ1NMZlVPU3dSdGNqcVpRdlZqRDUxR3gzUWlaK0M2R1BlZXEw?=
 =?utf-8?B?S3ZOV0d2VmhHQnNGYjNVaU5JRDEvMGxCYlh3VjRLY2c4a2VNaGVtQjlXTUtk?=
 =?utf-8?B?S2UxMDJoZndSaldUN1k4a2d4ZVlwT29WSXpQMFNKWUFJMnVCazFqaC9RazBX?=
 =?utf-8?B?WjdMNUpqVzgrUlFRMEJycHFYWE45eDJTcTlOSDZwQ1JUV3FKbUlQZW43a3Az?=
 =?utf-8?B?ZE9rTlQyWDdEZ0dyL2ViMUdJcUszV0pKUXd3b3BpdTFNNUdhQWhxM3dhQTk2?=
 =?utf-8?B?S01hT09IS25PZCtHWDRoSzZwYVMvUHBKWkRaeXdTSkI1OHdRakp4QzJUT3Fv?=
 =?utf-8?B?YUVQbWkzdy9lY0lqdGJhYmJnZ25LWWVoQXhYM25oWFl4dmM3NlE0aTJLN2hw?=
 =?utf-8?B?NDRhQXUzRlpxUlg5dDRKbXJjRkVDWExmVHoyVExFRmlvanJvU3hjQTFHc29a?=
 =?utf-8?B?VG1Yb0xCZHBIMytkL1pxWEhJa3MvREtnMnZXWkpnc3hiODgyRndqeWZjTlVF?=
 =?utf-8?B?eG9iMlRRd0ZHd0p6SHd6TFpiOWVxeU9XdzRQQk1oeStWSlpHY3laOGRZYnVO?=
 =?utf-8?B?c2poRlptVm5DSFpxRTlYMkJNeUtHSjNzaEFnWU81dEhIVkdQZkYxc3Q1NzNs?=
 =?utf-8?B?cm5PY2d1SGN3MFNDT3pGOUJQZ0x3UCtOMGFEZ21WalllUmpDQnlSOUxFQUxz?=
 =?utf-8?B?YWF2UVBtT1MzSzZpRUhqQWVKMXZ5cjVrNW9SaU9UZytLQ3FhMTBlRXpvKzFs?=
 =?utf-8?B?Y2EzMFE2Q2lSRmRSYlQzUG4wVjRtVjN0Vmw5VEFFRi92dWoyRjA1MEVWdE9V?=
 =?utf-8?B?UUJocndXKzQyL3ZqYTBpcnIvRjZBY1ZwVERCRlJPSENkODJHTHRQVVNrYmZo?=
 =?utf-8?B?TS9FZW1RU2c1Y202MXZyTUxmc0dnZUZCWUJncjJJOUlYY3M4UTBUNDU0YTQ1?=
 =?utf-8?B?cy9SV0x4M29xVm1uV0VaUXJTVGJ5WVppdXdCdE5IdUJiYThBYURNcFh5aXRa?=
 =?utf-8?B?Z2NoODBxc2xaODZpRXBncCtrRTk3Qy9RYnpTOFZpMW5sRzlJa05hK01BdWRq?=
 =?utf-8?B?aEY3L1RnVmFOb3FBZnRJekRiSXZrUGVmQ0VkYWJIK05EQm04TVJEM2hKRndR?=
 =?utf-8?Q?7tYN7d58ayxIEDPIWrQXRXjY0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad83ac4-2e3c-431b-e34e-08dd75bf3ab1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 10:30:34.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paBma7pqpnnRQQxkeZTQX2P6jTCVWKzRoGNEKN94On9mqhdwRfY70c9OpWCFakEw1re71RBAsmYfrRs30+XOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

On 3/25/2025 2:03 AM, Alex Deucher wrote:
> Add the user queue IP support query to the drm_amdgpu_info_device
> query.
>
> Cc: marek.olsak@amd.com
> Cc: prike.liang@amd.com
> Cc: sunil.khatri@amd.com
> Cc: yogesh.mohanmarimuthu@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b96d8c45312e6..4df11afe91252 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -125,9 +125,10 @@
>    * - 3.61.0 - Contains fix for RV/PCO compute queues
>    * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AMDGPU_IDS_FLAGS_MODE_PT
>    * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
> + * - 3.64.0 - Userq IP support query
>    */
>   #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	63
> +#define KMS_DRIVER_MINOR	64
>   #define KMS_DRIVER_PATCHLEVEL	0
>   
>   /*
