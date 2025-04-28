Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0505DC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 10:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EAB310E0A6;
	Mon, 28 Apr 2025 10:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U7KPC++j";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011B210E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUc2cwntI0YHlsCKzF4Wnbomj6cDjA3cyg2UTQAoCj5+ulKgA+PyQCtACy87bvkW5F/fUImIDFgUkQHkJcgK8NveRo5Crf/ndQd7umUTJ015cn6yCcP1YdBKmJJkz+EVFJn5WqEEEcAcaZRdY/3pacrToNI40SZfYThcwKmdW2Wwj7pRuYS7GaDoVw1DJ+HGquoTsAkl+9dt2Sdv+Fl6Qy2wb6bjYVM8jwhFaNTkEbM8vN9+gUkt9XLwJ10600Gn+hwMtqAdLEeLTMpnljI4EpkrdqbGqrEGG9Y5ySTnvcHNijj/EqlS2/SCfeFI4krmKPMFhy3hy3eWabaGiQHcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE3EJwMv08dUj2nPUrAhJsoJFHRLlJ1870vHBMK0f2k=;
 b=mdRCfCWBQWCtd5tD9uLl7mzzoEXQlYLVytJhW72COeUImm5HC+wXq3ckfBZgnUZaoqmhZRJyVplqzvOxLi51eEHl1b1OhkeZzXfESORLjVP9sy24wupIRlGm49qqFAqxz8hAa7J7kch+DXkjUnnjwsOZycaRMb0hbtfDG74xfP1OBa6WXK9hFfiCv2elFfjktKJU3HO+9cF2QPufxIf+xXI1kvIUHoQsaCjtqxLXON0C+sGSqzb6g0zRYZamgNkH8cX3aiAIc/rzoYOXOBLm4HML9f6DTokMkDFsDQ/uhgUY/J9jfLn07/sxjfOCRCianH1D99u/A4VEi+mFFMmR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE3EJwMv08dUj2nPUrAhJsoJFHRLlJ1870vHBMK0f2k=;
 b=U7KPC++jSbZcvhytNOL/6X9R1Aijh+99y7HZdMWdAMdE5S8DJmZAcbHHeU+j0IaHkmXaVUMEDBm/GntT3w0PgFhMGpf+aZTa+QfCRhrMyEWocsTdkAtU+7dMH/LEBgYhZQ+oMddTo3PAvtoKNOcpWryJg7l6BHuqFC1BGa6WXAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 10:02:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:02:59 +0000
Message-ID: <091c7fe0-b6ae-4d6d-af0c-8da9e4e84e08@amd.com>
Date: Mon, 28 Apr 2025 15:32:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: add UAPI to create user queue gangs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250425184125.166270-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f60428e-8af5-4891-65a6-08dd863bdad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTBUWHJ0S0ZmcG1pVjI5ZWZyYUFCZStNWXc2WDBRNjlQdHdGVjJGcW82L0Zm?=
 =?utf-8?B?UEZrR1pIYWdWbXVtRE90ZWhWNTEvdUw4Uk1rZXlWTzJ0MmhMeTZLUDc1R0E1?=
 =?utf-8?B?VTdhZkNuV1VGeHFPTjFrbXJCYjJPS2IveEhBRVA1Y083NTlJM0E3Nk1JU0Rv?=
 =?utf-8?B?eVV1clpVbmhLR1VpYytFandhVE5yWjNnY0crbDJveGRzcktPbWxNbmZKOWxi?=
 =?utf-8?B?N2dMK0dMQXRxSHoyVlZsckNkc1A4eVFwZjdQRUljYW9wbzdXVEtVaFJDZk44?=
 =?utf-8?B?b0hsWTJuV3paY3V4K1B6alpEb2IrRkpHZmpaRzA2eWlKa2IybExQOGhlTkR6?=
 =?utf-8?B?OXZrMVdkNUd0MitkTDBZcnR0QTJyK3p3emJNVWlnMFY4SjBpKzhMeEtYdmNu?=
 =?utf-8?B?L0VIcWRyL1daSEorV2NEa2V0ekQ3NUhZMDQyMmJZcG9DemNaSmc1QjRPWUND?=
 =?utf-8?B?a2pNdzBoeU4vL2lyWlFNemVkR3VYMXNmemtiWU9Pc2lBd3hSYkhQSzFQUGdJ?=
 =?utf-8?B?eWtMQmRTZEFLTktSYUFZYmZSalY0bGFSOVVPZHg4RE9WZ0w2NHcxb1U3dFVS?=
 =?utf-8?B?S01yc2ZJSDFYTjRYRW5YTmdXU3BGQmNkMFZqUDd4YVlEa2hYTk5NalFoZE02?=
 =?utf-8?B?Vy9EUHlKRUt5QzJ2eGlnZEQ2SlZaQWtrQmdBb3ZSdW9QL2dhU05YRDljemtt?=
 =?utf-8?B?TGRqeEE4VE1PNWs1cVlsRUEvTzNaaXFQRW9vRmczRVdDaW81cGdCZ0kyTXZk?=
 =?utf-8?B?TGZUS2dzNnMySjJkQmlJcTk4OURrUVBTY0hRV2syeUI2SWZzdnhLWkk2SFln?=
 =?utf-8?B?a2oyN1FCSEsxVHNhSGxlci9SdDdMemtwMEs3OGZKUm9pWmhVSVdwVGJzaUdC?=
 =?utf-8?B?WWlUd1R5ZmVJaW85VGVkRHlhMzFNZ0R4eGE5d1pZSFVrVWg3SzVuVUVSbUo4?=
 =?utf-8?B?R2dlTkhlaUttTG0zK2d4SEQrWmxUNEM5dnd1N0FhMUpyRXh1WGx2SVEzdjd4?=
 =?utf-8?B?UzBEb1pmVmpwd1Y1NzJFY0Voc2xsSk5RUGsxRE1hcXM0ZTMzelQwak9oTkFs?=
 =?utf-8?B?OUNqZFJSTE8raWw0Rm1ISzh3TmdMbHhWb1l4aHhqdVdaQmNWaGpuQXlYUith?=
 =?utf-8?B?UTN3NXdKTU1BcnZvM2xvSkNneTJRSzMxTG11VEs2MDA5dnZGRVd2N3ZacUta?=
 =?utf-8?B?OFp0ekgyOTlMVG44U0dacGJoRGJpNUJNY0IwR1JqSW5CU1IyT2RzZVdnaklX?=
 =?utf-8?B?ZUs2TXJFVW9MWTltbWhMZThtYkpaUU9CeDlZdkpMV05lOUUzcml2STFGVU8r?=
 =?utf-8?B?Yy9OUEZQOW1jNm9WOC90UnFEa0YwTWRzMVJFWktidEdaYzNHdkdsUklqMmRM?=
 =?utf-8?B?M0VEU0RnR1dkbGpxYnBpK3ErVmpITytVUHdQU1V5dWphMXk3aUVjZkZnd29F?=
 =?utf-8?B?Um5QbTdDQXV4TWdDTW5kWjZ3ZzJMWHNmRnBMem9DOTZoY2J4L1IwZm1vTW1a?=
 =?utf-8?B?dUNtbFM0bG93TjN5R3lZaGtDQW9wR3VYeXhzU2kwZHl2eFZHb1B3N0t5Yzll?=
 =?utf-8?B?N003UE5naHVwbkFkY2FsTHczYVdxY2FiUFE4Vk5pWnNCYjZhWktvTzNKWld6?=
 =?utf-8?B?d3JPdlYxS29iaVA2Nnl3S0lUc3M4dUpSOHJRYnFkbmE2dHhPdVhQbEVNbmlk?=
 =?utf-8?B?YWR0cmtaYUd6YnRYaDdCLzZYQ0J3aHErZjA4dWdIK1ROMUdHckF5dzdWaVNZ?=
 =?utf-8?B?cWVaYnhGQ3RMY2x4ait4VklxSlIrOVd4VEtjWGxVak5jeTZCd3pKNUhQOTRB?=
 =?utf-8?B?MFArQkI0Sm5yS2xZMHFlT1hSTHdmMUNjV0tQbTdHVXBnY012MGNIMnIwMVF2?=
 =?utf-8?B?VXJUWkcrV2tKZWF0SndVRHpzbnRiY0N2OXozc0g5ZDRFaGNHUDZhM3h5eFdF?=
 =?utf-8?Q?HlDojcq/z4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZLTXRGdHc4YzFjbi8yeVhhOUFkTTRLQ1FYQ0ptMjB2R256bFlkSVNQeXlT?=
 =?utf-8?B?M29aQ2gwVTMxM01ZUmN6UURpa2lVMEQ0RlhlTmhMYkszcThZbmtSZUI1Zitj?=
 =?utf-8?B?QkJyb2VkU0JQVmN3d1JCSVh1VmgyczNxa2R3Vkd3aVE5N1BxVm54aWZ3SmNu?=
 =?utf-8?B?R25ZYzh2eTEyK09kN0czZURMUlBTRHltQkVJNlo5bGxJdCtpdWNhZ3pwWVBY?=
 =?utf-8?B?bEkrUWt6L1J6MDFiZGQ4N2lUQnJMU09jU1h3N0hhYlNnRFozdFRBY0dZS0Vn?=
 =?utf-8?B?bEF6azI0L2pXeDE5U21Ta0lBekN6ZlcyU1podTg4dUxoK2VoSXp1SGdLQUtD?=
 =?utf-8?B?NXd4M1ZCSU95L0czeVBHRjRJSmROV0xKMTdiUlVUZFFOWWtUTjQ1U294UU5z?=
 =?utf-8?B?N1BUeXJsSWNNWlN5bW5LWUZMYkliT2hTUXZSMTZ1cDJnUUF2WlVWcEJNQUZi?=
 =?utf-8?B?MU40TFdsQWpTWE02cjNYeThqaENLbVFPcnhhWkJrOFpieW0wVTRoTk1PcVB1?=
 =?utf-8?B?M2RVTkN6KzArVURrdGF0NWNoNUsyMmUyTWloYkxhMG04ZlNsa1RKdzVibGRP?=
 =?utf-8?B?SnkyTm9ITXlKQjhxNVRJSk0wN3MrREpRYVdxUkt5S21mdU56TmtHVCthczdB?=
 =?utf-8?B?cFMzNElEVWNOV3V6NVByYXFTQVo3SjNkNk9ZT09OZ3RhcTNGdEZ0RHJrUkdU?=
 =?utf-8?B?SDN3d0hHMGVjdHBTSHBXdm9LNTNCdlN0OFVzR2FJbzBPVVJIaXJBZ2RBS2lX?=
 =?utf-8?B?V1c3djdQVUE0QnNvNnM3OTMycTNxclZZdi9qUUE3QXpoU1Iva1BpVmtSanFk?=
 =?utf-8?B?MkoybnRWVDR3UnJISHlRdnlKRUJWSGpMVDlsRW1TL2tNQmtwZWNESHVwK0ww?=
 =?utf-8?B?emNBTzIrNUFPMWV3RW1Wa2tLSjVLQklGYTREclRmejZOZ3UvWU1GVGZIYnFz?=
 =?utf-8?B?a0MyeVVheHFSUkJPcUtNYmVYUitpN3lUZVFZQ2hSenhib0JaOHRTVmp6Q1Bk?=
 =?utf-8?B?bHRKeGtSemNMQ3FrWEdoMkVUcy9acFpjZVYyOGFYY24vZXhsN2RKNFFkMDFG?=
 =?utf-8?B?RGQyNHRxVjMzRVhWbXdBRjFSWUlvOVljWlkxU3J6cVlPdm44b052RThkVlNl?=
 =?utf-8?B?NmM5bmVramtvOUVUMHhocXZTUHpBeXIvVDNQQWtsMWlBNFNVNDlyVzBkSWRp?=
 =?utf-8?B?UTdyMlQvSlVSdHd2aG96dVE0T0tBYWNrYy8xU1JGNzdlUElEWUZoRGs5b1VP?=
 =?utf-8?B?bHl6aWdUaXArMGJ6MXBLdGJUWTU3MW5CODl3bWdUaGRCZUZUcTVoei9ZSTVL?=
 =?utf-8?B?N3hZcTJSdVY5NmFxQlJLMENzaGRta2xuRVIzVXphTVIrVFZPQ2p3aWxKQUpj?=
 =?utf-8?B?eFIxclVaQUZLTk40NVdxSGxtVTI0OEcvbmtsdXFPUTB6WlQ3RkppaVQ5Nm05?=
 =?utf-8?B?Z2RnN0NGM3RNSk96ZmNWY1lzZHU4MEVxeEoyR0t5MXloT3p5QVE0R2ZMbjZQ?=
 =?utf-8?B?UkhRQno0VTNQUXNPbG02Um1ZUTl0TFY1MnVXNVNDaFJ4akJXWStiLzF6UUJs?=
 =?utf-8?B?VFRhY0grcy95dVhTQ0hhVnNMUUVIZUFQWlhHNXBCV0h4ZllyRDkrREJSNnhn?=
 =?utf-8?B?ZHRkRDBhOGFZQWJVWXFQYUdFK05qcEZnSnNhVWlBZEh6VVFvZDMrMU9kUTdP?=
 =?utf-8?B?N2l0ZjFEU2xkc1FlRW50MEZCM0xUWnJ2Qy9WNmlUZDR4SHppb2FDbVh2d2Vk?=
 =?utf-8?B?TDIwdUk3NENMY3ZRRjhJQ3JydGEvTGdaQktmS2Q5UTNtODJWRUY3enFHMDVX?=
 =?utf-8?B?bDNrMlFUMkpEQ0xsWVZNQXQ0d1RubDNpWnZWNHRkaUtNckN6LzkxNHJPTmlq?=
 =?utf-8?B?MGo5ZmJQVE9SbEJwb0tpYWk5OTZaYnMvTFpvRWE4WVNxZXY4TllLZUFlQXlh?=
 =?utf-8?B?bmtaM3V3THpyNEdEMG5wV3kzVTQ0YklGYWRwRE5YTEVVdkNxaGVCNU1EcGUy?=
 =?utf-8?B?TnVnWktOMmhjTVE1R1VCNEw2ajFFT1pUdGRqQWlJUUhpRWpzcXRETjQrd0xT?=
 =?utf-8?B?b1JYMFoyakQ1d05oTSthN2lRRVdqb3FJTFRUS01PYlloMlJ4eDUvbTNqMVB2?=
 =?utf-8?Q?cAPYnLZb4HN0ER18KqdGuhArh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f60428e-8af5-4891-65a6-08dd863bdad1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:02:59.2337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF/lhkqM/gxqE9HWi1ANwFAyrEg7YnuZSSaTLKuF5U17M97KvaprKASneCs7R9lY7E+6Ad6Zrx3Ke/nfG6hRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
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

LGTM functionally,
Acked-by: Sunil Khatri <sunil.khatri@amd.com>

But i would like @christian to look once as he is one of the original 
author of gang submission.

Regards,
Sunil khatri

On 4/26/2025 12:11 AM, Alex Deucher wrote:
> Queues in a gang will schedule together.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 56f052a10ff38..83414563779fb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -329,6 +329,7 @@ union drm_amdgpu_ctx {
>   #define AMDGPU_USERQ_OP_CREATE	1
>   #define AMDGPU_USERQ_OP_FREE	2
>   #define AMDGPU_USERQ_OP_QUERY_STATUS	3
> +#define AMDGPU_USERQ_OP_CREATE_GANG	4
>   
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -417,6 +418,15 @@ struct drm_amdgpu_userq_in {
>   	__u64 mqd_size;
>   };
>   
> +struct drm_amdgpu_userq_in_create_gang {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	__u32	pad;
> +	/** Queue ids passed for operation USERQ_OP_CREATE_GANG */
> +	__u32	primary_queue_id;
> +	__u32	secondary_queue_id;
> +};
> +
>   /* The structure to carry output of userqueue ops */
>   struct drm_amdgpu_userq_out {
>   	/**
> @@ -436,6 +446,7 @@ struct drm_amdgpu_userq_out_query_state {
>   
>   union drm_amdgpu_userq {
>   	struct drm_amdgpu_userq_in in;
> +	struct drm_amdgpu_userq_in_create_gang in_cg;
>   	struct drm_amdgpu_userq_out out;
>   	struct drm_amdgpu_userq_out_query_state out_qs;
>   };
