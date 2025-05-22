Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193FBC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 07:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B7410F7A2;
	Thu, 22 May 2025 07:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJP8YFNU";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EA310F7A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6b99Gy9yk7bXU1+go6I/5K7I0Qj8kVMO5KhGYcw/i88d4CPpl193Yit5lvoI/3BxmlglTaR8gZouvdBPPwlDfnNOP0mZcpb+k4x8LuesIdPv1hzVnLwswUiyZ5CPzg9HJTkc+v+xQrPIVBoveCrop79/pyf0AHwLTtilRIPNNMm/XSW5zrqcncbnXDkRuq/2uUuqtMw6s/z6ullMDKNhpMjJdnTbDBNNffZ6dOducGDIplZGYAd37JEu4TlwyJvTUeUXVFPIj+TVqtNA3bUbkKH0FcpUi3v7/PgPLNHZXXzfgwG0FxGacQF6BJhTvF0F4C3hMc+W3TlPPFdx44pIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGjPr8XAItQMFa7yfk4QTuMDy0H+cQogJWJVs5JwwM4=;
 b=a5QIE7WyQhNm3M50DhvllAoYhk5VaJSjlKv6YQnhlKYDQT/Cp5HCe89JihKRStjSdoIa6k5FcOPkDugYaLa2vcBjWtMVPUxIyZYWR+kcXMvi8azPzuCEGRd9I4W3KZKB+0H1Sr82QCnecFaCpwU4+s/3/D2fEWk1w8JLdbzoTi3tHJoye8u0WvOAvTevZwJQ4PA1r8GnESgs4W0OfbQGDbvRONxSUUmjkCbVKDt5xweUDWfEfFGwJczNejGkVVMQGM+9GDMEZzqug3lbNXu1MdK1sMtUawXeOhZfWJ1sUHdWwxw/j0ceme6Dlr99GAwf27GqUmuWc2ZrjnLy4PQ7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGjPr8XAItQMFa7yfk4QTuMDy0H+cQogJWJVs5JwwM4=;
 b=kJP8YFNUOurjqh4ZhxBepLTKGiPhRS8JuQ5eZFvzSTWAVE4zs9GYc2TXXwu5dgVD1t+XxiwuaagL8hPQPFFW0AYHIUhEgGRbEaX3ZXhDhDk6vsWxmqx28BcNXTfk51LJxqekIQuMt7FGcyuVKdTTrbpgg1yoQ2gmfNhJphwOd6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Thu, 22 May 2025 07:46:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:46:35 +0000
Message-ID: <e5642a8d-28f6-49cc-a603-e0e6fdcd5265@amd.com>
Date: Thu, 22 May 2025 13:16:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522034350.433219-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a1533f-a5ee-4465-fae2-08dd9904c6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3crMmYxOFdpaWZwakJsbldlNFM1S2dkSEVXdUpldXh6aGw3VUw4bGN0Ujc4?=
 =?utf-8?B?VFNzSGdGVmdQRFFMWlBwWWpuaVhRTWQzVVRod0xOcUZ2OVN4OXMrYWVXbXpK?=
 =?utf-8?B?cDJsU1VvSEtITVczaXI3NW1wWUZsZ2pYUnkvY3FqOE9Mc3NzdmVDL1h4UWpi?=
 =?utf-8?B?djhTcUZjNUlESWxSVDVYYmdzeTR6WGIxdUl5aXhkeFNYMmhsZ0pyamxwSFZ4?=
 =?utf-8?B?dVpFd05TQnNKVWxXNDFDanV0Nkd4Tm5EdkVlazZSNEV6S1ptNHBNT1Z4Z0th?=
 =?utf-8?B?Wm4wRFJYTVFCcEE4YTc3WEY1Z2M5N3d5V3B0Qzk5bXNVRUlGSVNDcUE1dnVE?=
 =?utf-8?B?ZHZWVm93NjF2UDIyc09pM3FkeDNpTHJTZUlIT1dTTEJtSzUzbEl2eEtGckRD?=
 =?utf-8?B?T29HTDgxYlpnamZlWjNCMm9lMloxeUcyNzBLYmVCUFJlTVRZbms3QlZtenpq?=
 =?utf-8?B?NTZLZnNqOHRuTXlCQ0RDdVF2alh3aHZPZEJ6SkFNQ3dMRHp1RG1yRlVSNkRP?=
 =?utf-8?B?M2hXbGN1Z2xMdytxOTYwZVBWYi9oTWViZ2Q5MjIxaFQ0MjYvbU1UYll2OGFK?=
 =?utf-8?B?QjhiMm1GbnpPdFBLM1dqejAxMTdIT1p2b09taU14TFVjbnc2UVBSREhDTmVT?=
 =?utf-8?B?S1Jabyt3YmpycE5ISE80elkvUUpETVN5T0VaQjRwdVJlQXRuNUR5YWszRzVZ?=
 =?utf-8?B?NVVMNUthT3NHQWRPcDdON1VaNW9QQjl2S2gzMEpIbU81cnFjcEYxcCtnZDVL?=
 =?utf-8?B?dW1TUUIwL25UdTZseEUyU2o3SXlnbnRmTnVDdW9JU0dpcWpKemlGYmlFWmM4?=
 =?utf-8?B?d2Y3ZE9TVStEaEphM0pXb3ZTWStJN1NOWnp1VDlRemIvRGZpd3BjOElvMjdU?=
 =?utf-8?B?VmM4cDFlTHdJM0Q4emVDcmMvTWZQc2lnWFBXZS85cTBrNG9uVHovUWNWeHJh?=
 =?utf-8?B?Mm80NTM4eitiQ0xkTzd6aDBXd1dQVkt5d2NqWWFvS3FLdVFzdmRUOFpzdUxp?=
 =?utf-8?B?OFJtSHNxSHdIMXRzVlhCN1E0Yml2UjBvcjA4ZXB4WlNKa2R4bEUrNGN4WHVL?=
 =?utf-8?B?dlNPSUpJczN5Z3krRXNYQUhDNWNHTjk4NitnN2RzZ3BPZHdlc3ZVUlZSWndi?=
 =?utf-8?B?bnlPNmFDeis0NjRrNzBuNUtlOEpuT09LalZRMkROZWgyMlhhSURPb3F3Njlo?=
 =?utf-8?B?TFEzVTdZYXpUemJYbG16M2tCcGxDUllaakVMSytFM2E3Z1MxWkUrV1FwQkN5?=
 =?utf-8?B?RkZKcEZBd3JjV3ZoWEhrb1JZVHZwQnlOWmtWTmxFWi9IQ2JjNDA0aXBVNEJE?=
 =?utf-8?B?ZHRuWFFTUUJ5SG1TT1crZWdiZzlNcjZzb2oxWUZMWFYvY3FJMTRBNjZyY2lH?=
 =?utf-8?B?cTlSVUxTdUNCZ0xGbXZnRmxXZzNvakxaeDhMLzBHN3orbjYydzM5VkxRTkpY?=
 =?utf-8?B?ODhheCt1cVdLUHZzSi9HRVlYNWtySWpDMC9UenZSdzZvTy9wTW1uR21WNzFQ?=
 =?utf-8?B?dUg2MkFncHRnQzRRaHJkUkc3dEdrZlQ0RkI5RkxVR3orVWpXakltNmhpQ1JF?=
 =?utf-8?B?OHRDVURhdHdZVkhIVVBqY3pDRnUzME1wY1VUck00Q0g1YTlZZmdhZTV2L0U4?=
 =?utf-8?B?NzRKMUwrMmNCQUVpazlRcmxhbXdiTlJHbSt4WUtOeEp4dVo4RzNSSm9PdFhE?=
 =?utf-8?B?cklPTUNTMFhad3B6OHI5R0JoVkpMVFQ0cW9zak5OMGFrM0FHV2VuMlZiUjg5?=
 =?utf-8?B?NWpqbm1LQlEzcmJBRDFLLzBLNGdhSEVpYlJRSlIyZ0hXYVg5TFZxTjNYbnBy?=
 =?utf-8?B?REo3eG8wNGFsZ1JkQ2ZMeS9Ncjh3dXE0OEdoY0pIQjM4MDdEZzFOV2xRUk8r?=
 =?utf-8?B?SlNhbGg0cmtQYUtTRkduZ0tEbnFvUnZtKzhsSXRXNDRGczV4VkhlbTNDbXJu?=
 =?utf-8?Q?cPfkBIg6fmc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJuSkgvWmZtSFJYSEJRclFXZFVWWUg2L3pRRkVMZXl1K1hPS2JhQjJOQ1RO?=
 =?utf-8?B?M01vampWQlB5ZkNNRDZaU05reGZsTkN5MDN6a0xIOE9CdXIwQ3l6Yms5SVc1?=
 =?utf-8?B?OU5GZU5lRXlsajJ0aUliUUJ0amJVK2V3NHd2blRUeEY2Q2dJNUZpY2JENUtI?=
 =?utf-8?B?K3RWZlVrUFF6cDBKdk4zT2hCN0NGWVV6azRTNkZtZk5WQ3ZZaXU0WStoYS9a?=
 =?utf-8?B?cXd0eStRUlZ0azBMRFlLNnZ5ckcrZ2MxSXBDUXhiMlo3bkhrM0dOVjRzMGpu?=
 =?utf-8?B?WEFxd2lzT291YW5GbHhrMXNsb1ZQUFF3cVRta0RLbnB0dUw5QWRDQ3hocUdh?=
 =?utf-8?B?MDA1UjRNRDZSSEJmdEtsb1pycE80djlOOUxUMDBpVUt2VU8zQzBvSWovMUJZ?=
 =?utf-8?B?QWVhOHd2RGZYNUdYWkM0c1JZeTJrRzkvRkROTjN2cDlSYnZXbytncEY4ZG0r?=
 =?utf-8?B?bk9jcW92K0NETUJtSmlvWVphVkdzSFAwMFdDNkJVdmRrdnpYUzVydHdOckxw?=
 =?utf-8?B?T2ZNWVJPUFhzL3dYa2ozVFF2OUVRWk4yVERMUVZtc1NRS0VtRHhsOXl2aHIr?=
 =?utf-8?B?Mit5aktRV0tIaWc1K1NvTHBmcUNUYzVJNXF0VmpaUHRESXVwOUhxN2YvRXp0?=
 =?utf-8?B?WWNaMlRyaTR6WlhPNml3VjlUVk1yZmlQcDZ2SGgyamVzNkdZbGgzMHc1NHJi?=
 =?utf-8?B?TVIzMWR1Y25mdVoxa1dldW5hYVIvcWdMbVRZNmV3Yk1QNThybitMSkJKOEhn?=
 =?utf-8?B?ekN4aGNIWWZlNmwwOG0wdjdPUExjNlo1MFZpcE8vSm9iSzhHcXBETUVWcDli?=
 =?utf-8?B?MUYyUThHdmtKVUZNdHFUUmRQYnp2Zk4xdCtiNXFQQzV0alBqRzB1MUlXOXRT?=
 =?utf-8?B?MmRzekNPYk9LTmJRV3Ztbzh4dFJPdDIrK3RGYkxOK0l4U3F1OVdST3FtcWtI?=
 =?utf-8?B?dG9ieFJiMzBPcmNua2d2WnpVRmlmUzF6SU5UWFJIWCtEYWptQ2JQdnVlUDhU?=
 =?utf-8?B?WWptd2tMRmpQTkg4ZXEyb09pMkRqcHAvblM5RXVpUmNJb082R0NUZ2szRlV2?=
 =?utf-8?B?SHZRWFQ0c2pJQ21hQWRNMjdZUTQrOTJvNGd2NWE0ZC8xaHFacGU4N1lyTmVu?=
 =?utf-8?B?a04rYzNsdWlJL0E5eEhPdWNtYTltWlhtTC8vVlo1OUxKYTR6d1pPUlJWUGxy?=
 =?utf-8?B?QVBwM21VWkdYcm5ra25ZT05yQ2htS01VaEdRcUp4TW0xNVpMSmhmbXNwL2Ni?=
 =?utf-8?B?USt2czBxNVRrb25PdEgyQkRkSDJDNU9HRzNuYWlnc29xSTk5REpSQWFzQUpx?=
 =?utf-8?B?aUw3c2RXVVBQSnkxM1VvWUo0WUgwd0NBOXFUT2oxNUNQb2dyaDZ3WUJ6VUxD?=
 =?utf-8?B?Uk9rZ1BGWGY5NzlYL2ZhaGZxVXBtQ0p1VnlGbXoxQnNqV1ZOZmJCMlI5dEZJ?=
 =?utf-8?B?NVZrcjBQRm5tYndaK0h1N2JSVTV2d2ZYZnUzQXdSUDFVaFUxMnBBUEN4Kzh3?=
 =?utf-8?B?eU4veDNsWFlZUCs1OFZrTVBqdWRqUnVpdFR2dmZKOUFnbWdqUjBhQmZEb2tD?=
 =?utf-8?B?b0U5MmNSMFgvSkhtMlVRM3JPd3pPTW50VHBzZnNKTzhXdFgzWjVjL2VMdGUr?=
 =?utf-8?B?L0ZoZ3VYR3kyV01hTFdaK0ZyYjZUZDJKdWkzblVJUm8zNEtnY1dKcU1mVFpH?=
 =?utf-8?B?WUpkRlNmcjhYb1p4NFh0aDFUYldNOTlieEpxRTlKcTRLMHh4cEFlOXRYRlVP?=
 =?utf-8?B?TUg3RUF4eGVuSy9jQnA0Q3RmaE5FWnM0c2dCUXBYZHJQdkloT05ZT3RKVmZZ?=
 =?utf-8?B?Vk14T21UWW90OHNxcGlkYjdYYldUTVVMWmhDMEk1dHlpVDhqa1hDeWZZcFJl?=
 =?utf-8?B?WkJzbm1meHpkYlhLTEdYalkzNE9vYlIwQ1NkTEdKSDIxWk1JZDBqeFUyTzF2?=
 =?utf-8?B?Y29wSGZhYlREaHZzNGJDYTZOV3owck9tZ1l0Um9Lam4vRDZ5dm1KUkphOTJP?=
 =?utf-8?B?VnZuMkRWREtDR1JYdEl5bWV4RXE1WGx4cmZNTVVndzF5SGxEaW9vVkhUVHFh?=
 =?utf-8?B?MVpVdE1QSXpDTmw3WFBIanRkamlJYVd2L1YzRlJac2hVNzgzV295WEhtTnpa?=
 =?utf-8?Q?DwwTsuXCW54TzEoi+qGqmQzxT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a1533f-a5ee-4465-fae2-08dd9904c6c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:46:35.3332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gmz3falgtzW08R/JvFWYTqMP2KR6potHj51ERRS9XwjuBg66APOuuFXkcJK/7am
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
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



On 5/22/2025 9:13 AM, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 23 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 13 ++++++++----
>  4 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e5bb46effb6c..97389168c90f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5065,6 +5065,10 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	adev->vm_manager.vram_base_offset +=
>  		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
>  
> +	/* fb_start/fb_end may be reset in get_fb_location(), set it again on resume */
> +	adev->gmc.fb_start = 0;
> +	adev->gmc.fb_end = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes - 1;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..35df4be6ef2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -251,7 +253,17 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;
> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
> +		if (mc->real_vram_size < mc->visible_vram_size)
> +			mc->visible_vram_size = mc->real_vram_size;
> +	}
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	mc->fb_start = hive_vram_start;
>  	mc->fb_end = hive_vram_end;
> @@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1068,6 +1079,14 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* always start from current device so that the GART address can keep
> +		 * consistent when hibernate-resume with different GPUs.
> +		 */
> +		vram_addr = adev->vm_manager.vram_base_offset;
> +		vram_end = vram_addr + vram_size;
> +	}
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..e6165f6d0763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && !amdgpu_virt_xgmi_migrate_enabled(adev)) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..23d02965ad65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
>  	(0x001d43e0 + 0x00001800),
>  };
>  
> +static inline bool gmc_v9_0_is_pdb0_enabled(struct amdgpu_device *adev)

This may be kept generic -> amdgpu_gmc_is_pdb0_enabled(adev)

Thanks,
Lijo

> +{
> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> +}
> +
>  static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
>  {
>  	return !!adev->aid_mask;
> @@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (gmc_v9_0_is_pdb0_enabled(adev)) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (gmc_v9_0_is_pdb0_enabled(adev)) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (gmc_v9_0_is_pdb0_enabled(adev))
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (gmc_v9_0_is_pdb0_enabled(adev))
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {

