Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063A0D5E147
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 07:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1E410E928;
	Fri,  8 Nov 2024 07:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fHodZwIx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CEF10E0C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 07:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIXhNfbtVp3EkyrGJ9vyYNZG7V1jbs2vFttL74jx/Oa8V+M1QscCQyiNko2IrBxDK2prRJdUMGwJq1qAjYdoDjuKztjjt1w8Tud9qWYTznEKgOHEqIPLKIB3qr1t3W+U9thUQIYxOpVa7ORk0eZp1zwNcaqkupNQkJGbAO1mtRbrv9rhvzNKaHDTJtdYMlS2ToaKlDqItM41Bn9+xuF2uEov8wZmBJ88FIVIwMOIINTBCCLFjhqvi7z7+y8WDTSzMXwQk/LlOVk/FPalqoj0mKAsvNQyvUlXCO8arosmD52QiZHekXk2X5qZbHvcWwTWTc4S7UCXxxYar/a71SVS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ohy76rsmMH209Ruez6d2w8q1WlnjOnUkBBzjwKcAhA=;
 b=b6aPI3US+6wguqW2JP5Glo+kaUi3tAaXqgC1MmTobyoz33DjcAePGkIhSPNSQKSruHyg1BQizFGYB5kcyZmVD8bLjU85AlcRgmM1voJMBhgbtm2SO2CW6ZfEKo9dM5hTCD6B3J/R/Y+9jdL8JFAaw4zANOOzthsBiUFYRWUOECLI38fLzCKW+giDoMs8yg0WBcodGVFdhF7By3sH7yn+EjPXOARAxRdMcPKHHin9sCOh3NLBiJP8INmET0FEMYQa0G7Z46/2szKjWnLN8igJpSPwI3ONtOvsy5Rzl6KnsUrlJHQqZHRrzGczjg2YryxE6qSr8Gj2O3dKc0Kqu/nnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ohy76rsmMH209Ruez6d2w8q1WlnjOnUkBBzjwKcAhA=;
 b=fHodZwIxrd0h3xh/6QSCRlG6PcprBVeCwebWam3nXqnnauBOfh17c5CVzVEpAoCh6UTqiBHKoFjLFVFfyAKzGpYto9RmbQ6vBE3qt3ujyIdFhUACNR3VkKb1HY8BQwOxXLR+KM6wrKcgVW9B+ANUdQ71kDvsjtcBPPsDq8ENYOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 07:51:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 07:51:09 +0000
Message-ID: <a3df1093-598b-4d05-a403-4b5b3a4715ba@amd.com>
Date: Fri, 8 Nov 2024 08:51:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix warning when removing sysfs
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, vitaly.prosyak@amd.com, Tim.Huang@amd.com
References: <20241108022148.588761-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241108022148.588761-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: c41a2ec1-7a71-4d96-851e-08dcffca1bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlprZ3Z1aXBUOTJoL3Z5bUJqZVI4dTl6U2NwVzVGdmQ3MndWOGZaYWt0Ykd4?=
 =?utf-8?B?djNBS0tSZFNxcVh5VjZvU2pvQVhiVmw0Yk1kMThOajVQQnlEb3FvZml0L2Iv?=
 =?utf-8?B?VVJFdVdiWm5Gb1JzdzAvaEVXRTJqeVowUHdMY1RMWW5PU2xXSUMzVmhyZW5v?=
 =?utf-8?B?RjlzL0U3K0JQblVnM2ZJeWUxUkJNSVEwdUk0U01FdmxFMXdxVHg0bzJreURU?=
 =?utf-8?B?SjNZL1NYcnRyT1V3dWpwRGQvR00rVGxjQSt1Y0xtaVJVeUJYWUpzNlh0dDNq?=
 =?utf-8?B?NGdGZnU3cWVQbTd6Z3dBSC9vbzZMajRzSUUreFNPVVJ1bDNaVy9BUk9IR1NO?=
 =?utf-8?B?OGlWbTVDOFJ2WFFYckFlQVVhVXRoUGYxZE9Ec3E2SktGdE1JNURBZGZ0N0ZL?=
 =?utf-8?B?TEc1dDZvalk3bTB3Wk83WlZuUUxrU1hDMkx0Q3Q0WEswNVlpQ0FzZHA3Y0Mv?=
 =?utf-8?B?UGFKZEExTGdSU0pKVE5DaW5OY3p6Q2R6b1M0S0YzUUhFUzIrLzhQc3IxQUUy?=
 =?utf-8?B?UFo0YWdjMkROQnJvNUNrTnBJdWlhOGJFTSt0c1llODEvRmwvTVZwcVZJMVlU?=
 =?utf-8?B?eGliOVIySDliMTNQN0Z0WU9hcHBDaHNMY2pFUkZ1NGQwUzVtc3ZCZW1IS2E4?=
 =?utf-8?B?TTcxWXNtRVAyYzd3NnNPQ1FvSEpiN3dvTndPUFpYMys5Z1BhVHJYY0R5Wnhu?=
 =?utf-8?B?V1hyUmlYbWJkK2FPakhzeWNldkYyTGo5b0ZQRkVabWR6REI2azRoeXVFN1Zl?=
 =?utf-8?B?TTJnS245aVREZDZJQy9WQ01xUTlGWDdyUlNuemxDS0JmR09UTS93a2JQRWo2?=
 =?utf-8?B?TnB4UFd6dTQ4OWY2elY5d3Z6OTgvUUpZb3N4UCtVblY1bnBzd2FRWjAwUVFz?=
 =?utf-8?B?ejlhMG5OUU02dXZDQStEWlFQSks5VXZFZCsxUTVEMFhEVXpKbzFsYXIzWE1t?=
 =?utf-8?B?NytPenU2WlRxbGc4Z3VrQWR5TVhlbU9yQUNPTncvNm1vVEJmdHY4SGh4eDBK?=
 =?utf-8?B?THkvSWlxZGgvcEI4WEd2d0d1anRPczZDMkdTdHNVbXdxdG5hQmFaVVhNOFlY?=
 =?utf-8?B?b0kxT1oybStrUXIyRzBPa1duQmdBN05FbnlKalZBOFoxZHZkTll5cHBjd0ww?=
 =?utf-8?B?RFZzNSt3eSs1ckwwN3VmRUV3TzA4UlR5L2ttOGxEaVF6VGNsbVBIR0tGQnNB?=
 =?utf-8?B?dy9rcm5WRjdSUm9aSTVUSnBxbE1lRU04MTUxd3QyWVNWWm1ROGptL2xnUjA0?=
 =?utf-8?B?STZhaWZrcVB1WHVuL2tMQ3JZVE1kV3hPZHBnSWdyNEVScXBQcytOUEJjUCtn?=
 =?utf-8?B?SnRkUTNvWEkrcmlpVDV3Uk1PQi8rQjNYYkhiMGZtWVRwQmx6VlNDSnhuSEFk?=
 =?utf-8?B?VFgyakx3YWFXUTRIbVJ4UTZDSm5PTkpUYkVFYVhEUEpFZUxPZS9xYUtrSnkx?=
 =?utf-8?B?a0JjeXpBWnFOTWlUWW1tZXQzN3J2YkZtbVE0c2EzbmRTUFhXbHhUYzBvakVO?=
 =?utf-8?B?VVNwakRmVG51YnI3U2x0WmlGOWllUmJmUkVlSGFwajR3ekt4cnJ3WnV1NlBa?=
 =?utf-8?B?SkJSU3MzQzVaRkY0UE94RVZxcFhoRXNaYm8yUDRCZFZCc0tEUFJ6N09YRkVL?=
 =?utf-8?B?U1I2MXhENlBXMTd5dzl0VzYvOGpKVDRSbHVSSG1WSGJxYTdsTU8wY1F4Wkox?=
 =?utf-8?B?TEJ2dGdvY1Fja1pLR0c1MFhOVHlQWTEzVEYvQjVibHVQNmZtZTZrMEJvaEFq?=
 =?utf-8?Q?znb+ibepqMc3MAFrrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFg3dy9DbjBlMVRWTkJDSEVSbHFiYW9rNEY4ZTBQN0NjVnR5d0tSSml3U3N0?=
 =?utf-8?B?aWxLMm4ybjhBZC92L2QvL0VMeFFHQ2Q3RGxuLzVKT1U2UTN3WitMcGlqb1lK?=
 =?utf-8?B?ejV6SmN4U3VFa3ErWGtNRjE5OS8vQjg5UWZSd3VwcEZ0aTQxYU5ibW4zb1gx?=
 =?utf-8?B?YjhWNjBtNlVCTWRVZG9XQnN6Q2I5ank4THkzWTRPZlFVWTJ5eDl0RDgzS2JL?=
 =?utf-8?B?N1BJNWQ3bUh0QzVuMnlhOFVjVjlRWkFjbVBVZVVsd1kwZEllSld1SmhGOHZK?=
 =?utf-8?B?Y1dxQTZXQXphellkaUJZRGR2TmY2QURrcnY1bEFvc0YzQiswZm1DMzJjTWlZ?=
 =?utf-8?B?WXZCL2c5S1J5aURiWjdPR3hwTkxSSzhOaUJjTUh4cEF1a2JxQ2tSRlNmbUZx?=
 =?utf-8?B?WVNyUkhLbWZwaHM1djB5M2pZVHhTZWpRMStMV0pRbm9jdk9ybEdDZEQ1Y3Bm?=
 =?utf-8?B?UEdaenNMNDl6eXZaa0dPUlBZWitBRXBqL05WUDZnSVQxbG56NGZQYjlKSE81?=
 =?utf-8?B?WG1aVUtTb1FrWTFDTmdyejNwQTJ2Um84alNjTmwxVEFhaU9pUExkemNmNUlF?=
 =?utf-8?B?V0kyRGNlaGoxTFNRSU1PTW1TMk5ncll1SGJZWjFYTkJibjRSTzU4ZjFNdTZI?=
 =?utf-8?B?VFZOS1VuMUZwc3NMQyszN0NuL1Y1NE1QTnd4aGhyTXR2WFh1MCtXREMyV3Iv?=
 =?utf-8?B?aU9lYlZSWm5hcjBTN2NZMVBPRGs5elkwWnI2UlMra0xLMWdOLy83dzhKd0ZD?=
 =?utf-8?B?NW1kcWtqSmlIOGpSeURyTi9IVEJBN1pwVjd4eXo1TGo2cE51SmFBS0ovem1R?=
 =?utf-8?B?YlR4RDFsNE0rNEVrV3FZWlRjUHpKa0liMEFWUVp5RTJqMDRYVERWVlFHNlIv?=
 =?utf-8?B?WGdFeWY1azcyQ0NMcStTL29tNGlabE1OQWplS3RValhRZWN0M3NCTW96Zjh1?=
 =?utf-8?B?cU9YbkllQWRjNGFnUktBa3RoZ3dMUWc2SWRMVmJqMG9HSEJQYkhkSW5BcTgr?=
 =?utf-8?B?bjcwMmd4SjF6aWZmZVd2cUwrVjhzVnZNcDY1V1NTZ1dkTnpIbmduMG5EWUxT?=
 =?utf-8?B?cmxhSHdrK2lXRHZha1JGZXg5SlhwRHozN0dlcmVIeGNVNVVzUjcrZmJwc3Ir?=
 =?utf-8?B?UlVWTGFrbVRyYm03dUdpUVI5VzVEVUw3M3FleGsySy9ITjlrUWhDaTJHYUVS?=
 =?utf-8?B?ejZiL2dITDNrYmROUGw0Ujd1Z2dpQkVKUm53cUNUUlNYci9iRUlMSk05UHA1?=
 =?utf-8?B?Q1hJRjUvQml2ck83ZUlpODVGa2Z5ZWdkT3RZWmkyWUJBcndxTURmQ1A5N3F4?=
 =?utf-8?B?UFVaOWdMNTEzYjRlUjFJMnYvblUxemhrQkZlSmN1OGtqNXkwYzd5LzZJOU9p?=
 =?utf-8?B?dE5zMUJ6K2tBYlRIMVNqOXZSVkFkU3had24vTWttNXNOTzlHaXVtandpaFdu?=
 =?utf-8?B?eUNWUEU1M0Y0RDZPdXhtSUJJVFdlM1NFZFdBNVplK2dlazhqeFE2bzhYTlFa?=
 =?utf-8?B?TWZwVFFMNDBNMTBUc3NFSVZ1ZUhvY1BBUzRmNlRsOGg3UkdqVkUxT1lxSlo5?=
 =?utf-8?B?SWhIQ2o5bnd2RVVoeTZGUjNNTVhWSmkrZDhhTjNwSW5VOFJ3WGJ3NktWUVR6?=
 =?utf-8?B?RUJ4SjA2UDliendCNkE1WE1SRC83WjY1Y0tYTWRmS0JHQ3B1VGJHUG1ac2FV?=
 =?utf-8?B?ZzE3V3pBS2RlaGFTK2Q0V0hVWWtwMjREWnhNZXB3bkllcUFLOHlUa3MxWC8z?=
 =?utf-8?B?VmpEWWFCTWw2c3p0NmJXekRISEVVOTYzVUFpVk1LcVdpWDMyQVpVRXlNWGY2?=
 =?utf-8?B?WDhqZ1lKNDlmM2F6TVY0TEJXaXgxMHBmTlpRMUtXZTVqeVQ3ZlFYOFNCV2Qx?=
 =?utf-8?B?S1lBTnVtb0sveU9IN0JYbjRwNGRkMDlPaFRzVHd4NGtOQm5sUUNBcjhJZkMx?=
 =?utf-8?B?QURCVDUwUHgzeGtsOEFyeTErMmhMWEVWV2V3Sk5WQ0hnUjg4cGdoTWxOZTJU?=
 =?utf-8?B?dWdCb1pWZTdGU0k4aDNEa0NqTVVXbktSSm5iRlBOZWdNT2Y0OHlrQmZWN2pw?=
 =?utf-8?B?dURacm5vZ1lUZElqNmlTRVBWQ0Y0MUNtbDlhcThZMzJ1ajUzUWlnVjRSOUov?=
 =?utf-8?Q?tkw+i2rfdoGXP5qQTK97fsqwI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41a2ec1-7a71-4d96-851e-08dcffca1bb7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:51:09.4686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUsCSZgL/CvbadPKkLcBrXWixFAFKid3MZIif+Nw+v7LwQDfhlMnqrARJ6BfVdPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Am 08.11.24 um 03:21 schrieb Jesse.zhang@amd.com:
> Fix similar warning when running IGT:
>
> [  155.585721] kernfs: can not remove 'enforce_isolation', no directory
> [  155.592201] WARNING: CPU: 3 PID: 6960 at fs/kernfs/dir.c:1683 kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.601145] Modules linked in: xt_MASQUERADE xt_comment nft_compat veth bridge stp llc overlay nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr intel_rapl_msr amd_atl intel_rapl_common amd64_edac edac_mce_amd amdgpu kvm_amd kvm ipmi_ssif amdxcp rapl drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_ttm_helper ttm pcspkr drm_display_helper acpi_cpufreq drm_kms_helper video wmi k10temp i2c_piix4 acpi_ipmi ipmi_si drm zram ip_tables loop squashfs dm_multipath crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 sp5100_tco ixgbe rfkill ccp dca sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ipmi_devintf ipmi_msghandler fuse
> [  155.685224] systemd-journald[1354]: Compressed data object 957 -> 524 using ZSTD
> [  155.685687] CPU: 3 PID: 6960 Comm: amd_pci_unplug Not tainted 6.10.0-1148853.1.zuul.164395107d6642bdb451071313e9378d #1
> [  155.704149] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
> [  155.712383] RIP: 0010:kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.717805] Code: a0 00 48 89 ef e8 37 96 c7 ff 5b b8 fe ff ff ff 5d 41 5c 41 5d e9 f7 96 a0 00 0f 0b eb ab 48 c7 c7 48 ba 7e 8f e8 f7 66 bf ff <0f> 0b eb dc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [  155.736766] RSP: 0018:ffffb1685d7a3e20 EFLAGS: 00010296
> [  155.742108] RAX: 0000000000000038 RBX: ffff929e94c80000 RCX: 0000000000000000
> [  155.749363] RDX: ffff928e1efaf200 RSI: ffff928e1efa18c0 RDI: ffff928e1efa18c0
> [  155.756612] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000003
> [  155.763855] R10: ffffb1685d7a3cd8 R11: ffffffff8fb3e1c8 R12: ffffffffc1ef5341
> [  155.771104] R13: ffff929e94cc5530 R14: 0000000000000000 R15: 0000000000000000
> [  155.778357] FS:  00007fd9dd8d9c40(0000) GS:ffff928e1ef80000(0000) knlGS:0000000000000000
> [  155.786594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  155.792450] CR2: 0000561245ceee38 CR3: 0000000113018000 CR4: 00000000003506f0
> [  155.799702] Call Trace:
> [  155.802254]  <TASK>
> [  155.804460]  ? __warn+0x80/0x120
> [  155.807798]  ? kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.812617]  ? report_bug+0x164/0x190
> [  155.816393]  ? handle_bug+0x3c/0x80
> [  155.819994]  ? exc_invalid_op+0x17/0x70
> [  155.823939]  ? asm_exc_invalid_op+0x1a/0x20
> [  155.828235]  ? kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.833058]  amdgpu_gfx_sysfs_fini+0x59/0xd0 [amdgpu]
> [  155.838637]  gfx_v9_0_sw_fini+0x123/0x1c0 [amdgpu]
> [  155.843887]  amdgpu_device_fini_sw+0xbc/0x3e0 [amdgpu]
> [  155.849432]  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
> [  155.855235]  drm_dev_put.part.0+0x3c/0x60 [drm]
> [  155.859914]  drm_release+0x8b/0xc0 [drm]
> [  155.863978]  __fput+0xf1/0x2c0
> [  155.867141]  __x64_sys_close+0x3c/0x80
> [  155.870998]  do_syscall_64+0x64/0x170
>
> Check if the sysfs directory entry exists before deleting the sysfs file.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 3 +++
>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 2 ++
>   7 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f7bf5e43f16e..a9f40b28e030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1773,6 +1773,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>   
>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev || !adev->dev->kobj.sd)
> +		return
> +

You should probably drop the !adev check and IIRC there was a macro to 
check if a kobj is valid or not.

I'm fine with the patch otherwise, but in general such checks are more 
or less frowned upon because it mean that a driver has messed things up 
and tries to remove sysfs twice.

Christian.

>   	amdgpu_gfx_sysfs_xcp_fini(adev);
>   	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>   	amdgpu_gfx_sysfs_reset_mask_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 642b8c848141..257f4b712f00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,9 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev || !adev->dev->kobj.sd)
> +		return;
> +
>   	if (adev->jpeg.num_jpeg_inst)
>   		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>   	if (ret)
>   		return;
>   
> -	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +	if (adev->dev->kobj.sd)
> +		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>   
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..5a595baebb50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,9 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   	if (!amdgpu_gpu_recovery)
>   		return;
>   
> +	if (!adev || !adev->dev->kobj.sd)
> +		return;
> +
>   	if (adev->sdma.num_instances)
>   		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 67264f0be491..2b21b4e5c19c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1320,6 +1320,9 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev || !adev->dev->kobj.sd)
> +		return;
> +
>   	if (adev->vcn.num_vcn_inst)
>   		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..2cd642761a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,6 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev || !adev->dev->kobj.sd)
> +		return;
> +
>   	if (adev->vpe.num_instances)
>   		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..bc7d380f4b0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,6 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
>   
>   static void df_v3_6_sw_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev || !adev->dev->kobj.sd)
> +		return;
>   
>   	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>   

