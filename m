Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAC3E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3F910E0CF;
	Wed,  8 Jan 2025 16:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMIGhw3I";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15FB10E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0ubQD4pDnj70bDck6D0AonqEVRsVHCs/N/tfXmD4JXcS4t43uKjtRy8l3c5tDEHfAN12g115O3Qb3OInNhCIQ1Pru9pJ955zmIYO2cKvX6/lgMLMbijXt0FBRfFjKH+iNA941kLzJZX+09AMVDU83tmdihiV8WI87PZF4aRCR0aGzQK409l2icWkwg7VeXOx4yJFOFU/oGViJ6QLPOEPepRCJez+vOjnqIv0cw/dNktHvFgjQreBcDMt5fl8OucLgDNFLai7HJRdZDrDRwNhKcQfZ6qKC4D59FrHrE6vLvCMcILtMhvJO3IgAVqHg1k/SXX80mjHlBP0xGA2hcNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSbzG/3YwSvCi2JgsBgQvVGoluxSm3mpnjJeoZh85y4=;
 b=hAolKJA9h29BhlJngG60Xje2vQ86+e5x4dWnWmJP3ao08Ug/6/ctav2GUr1Y0HF6/2SeUxn/NQdh0oW4Ect0XIpxv7d9Zc1ZPKdfoOIzih3ixmCJU51ONgEyHiMyEQ2MlALvAWjRUwrTzIfgxwIkjbaNgDj56SdGJTCXnCY6eSqF9EwWnm3xVEOC4UUt3jwyARry5imW0zKi1ht6mBkfmtjxruYDgIg8lK3BLVnUP06UeuJZlxFCU/9A2HqzmoI/srSraQ/dvJKhuRYBdE30y886ANot8Dn4Sg01sJL46YScifbJGmXhl5sw+wZbUhGih4Cx3QrWh5K82vqq7scp9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSbzG/3YwSvCi2JgsBgQvVGoluxSm3mpnjJeoZh85y4=;
 b=EMIGhw3IyNI8qwkFhC7hQ5OnVpceM/J7oJU2wDL+NWY9C7Dga/yY1mlWa41ZO58cDaZVhbbQ9U6g8Dh1GV0BgY5etvjiXkJpSUDrzXCvPZxzJjOmpzOrJsAW8FbOhQlJQXd7Hil1H2MWZ/GID+u2ZswAl1VBGGw7O7MHiaK7GP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 16:08:22 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 16:08:22 +0000
Message-ID: <7a28a207-b732-4640-b0c4-c19916637b8f@amd.com>
Date: Wed, 8 Jan 2025 10:08:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 4/6] drm/amdgpu: enhance error handling in function
 amdgpu_pci_probe()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <5ba140aee2b20fc7cf724293d96260bd10d3dbdc.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5ba140aee2b20fc7cf724293d96260bd10d3dbdc.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:f2::8) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: e450e00a-02d3-4925-70e6-08dd2ffeacbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE9QRm9LeVFsejUyQWc0dEpRSzJ2aUw0S3M0YnQzWTA3QVNhZm83RzFkRDBz?=
 =?utf-8?B?ZWpiNEdIYVVCQXA3QW5qc0NEY250T0F5L0hsT2ZsYnhMRzJLMWh4UEExVnU0?=
 =?utf-8?B?blFjN1FuMDNmeGljVDJEamcwZUNmcmhxSHRNTWNrSXV6Znk5N0Y1NmhEYzNk?=
 =?utf-8?B?WXpZaDBzeURpQXE5VGY0UjRBS3ZnSVRPZUlXUi9RbzMzeHBJY1VzckFKeDNI?=
 =?utf-8?B?bzd0ajl6b1llTXNKOFMzZEowS1ZRYmZaUWFoSmthdFltT05LRGNBYnF3SkJ3?=
 =?utf-8?B?V1BQUmplYWMvQ3RQS1A1N1MxUC9vNjNGTlp4ajZwRHFJb2YxT1QrYUxQUkQ5?=
 =?utf-8?B?WHpGMW52dVBVeUpQODZwRTlDK1FxUkJISFAyN3A3NS9ndno4SGFMUzdlQ0dv?=
 =?utf-8?B?Kys2Mzg3ZFdvS0tQeTlISXpNRnhFZmhTTUVrOVRtNjF0ODBHcFdxUVhmYTAv?=
 =?utf-8?B?dk93c1M0dHZOeFM3cEwrbzBSTk9jOVpNS1NMRC9EcWJ2K2VxbGlqb2ttU00w?=
 =?utf-8?B?S3d3a3lPTWtpQW94SGdwY3NjbEV2eVhSWVltTHhwbHpESzVvY0xZWnpLYW14?=
 =?utf-8?B?bXkvcDJNSmZpU1BOaVFBSTRVQmlDSGpQWEUzM3RKdVh1S3k3cWhEVWVtZG8y?=
 =?utf-8?B?SWJSOUhlNzhjcjlUclZmZ0UrNHlOTUxrcytiem4yMUtjTWxKMnRPaVlTMW1x?=
 =?utf-8?B?T09YSE8zVkdrb2tSRmJxWmtKTWZQb1BaVUJscUk0YXJUb3FvV1RPb3JmTTlv?=
 =?utf-8?B?MTFNWEd2WUxlODl1M1c5ZzZQbDljL1lnbzRXZ0tFOFFsWXNzMlkzWWE2TXNH?=
 =?utf-8?B?elNHblNkMVZLWUJSWGttQ2ZEU2NBUW04K1ZrMUdNN1RjbFU0MitETWFGNFRh?=
 =?utf-8?B?b0czMEtRb3FpVythc25jempWcGRpZWl2bEdqZU9ZcGZTZEpMWFh2T1FZaFR2?=
 =?utf-8?B?K3hjRDRHRm5NSmNtZmJ2MXRveElyV1pRY3FEUTh1NkovU2c5dDY4TDZPQ2hp?=
 =?utf-8?B?UzJoOU1SS1hvL2JuZXFyVFlRUWVpcDVpR282ZTQxTnFsSy91ZWNuQ0ZnOW5w?=
 =?utf-8?B?K3lpNThRYlVrazROTzMzTEJBeTlOUlIwb0twZUtIRm02SGtFbkFVemI1b0gy?=
 =?utf-8?B?cVllT2pRUWxQeG80ZEdrdTRVbUw0aktUUFo1MkFVRXUzT0YxVGt2T2c1OGpW?=
 =?utf-8?B?ZXQ4RW1LSDN4cjgweUplMVNGb05XdVlpRlFDQ0JTSUQ3V0hFSzViZHB1LzVh?=
 =?utf-8?B?UnJCaElpTjFGVGZZVmE1c3ducXJCTG1NMUwvL2RPUnIvQmMxRW9wd1ExM1Rv?=
 =?utf-8?B?clFMdmVVUTFiais1TzhYbE9XSTNrY0VKWEpCSnhYaW4xdU90RVNtVzV3L3pq?=
 =?utf-8?B?cFdsbkQ1YXpxbGJmL2Rmc0Jhc1dFbmxoZHA3S1Nwb3lZNWVsVUZjdE4zbWhz?=
 =?utf-8?B?cG9WMEpacERwTGNBVTNMdUNKdlRNcVNueUdZTmp4elgyRUMyb3ZuSEZHei9r?=
 =?utf-8?B?K0xYd3JQTWE1czZEMXRLNHpGUG9pTG1IWEFrT2lsNXpsRjVEWjAwM1hYSTM4?=
 =?utf-8?B?aUZzTkNOTUtzcW92VmVYblZlTXhxelJpenhOblJmT0pqV0w3dmJrS2Y2VVY0?=
 =?utf-8?B?MmxlQUd1L3NTWnQ1ZjBXSHRabnUvNzlGQ0RIdTcrYmFWWm1nbHJkWmw3c3hr?=
 =?utf-8?B?ajBQUHJWMVBzK1I0RTBrbVdBcldwQTBmc2cveVg4OSs1ZXluWTh0aWJydkZv?=
 =?utf-8?B?WklOVVc4ZEVBVWx1c1p4ZmxKdEJBNGw3czlXSVArQTB4UWNlR0FYZU5WRnR5?=
 =?utf-8?B?Ky9qY00ra2FKUWNzcHJrdnQ3UmZFWXJ3d1pJOFpoQmlDNHdRYnprcnNHUWoy?=
 =?utf-8?B?azYzM01hRXNvQm1DRWdCcXNXUGtkcUtZdnFRQ1RxVGlZVVJ4ZklyWkpBQlRq?=
 =?utf-8?Q?kzv79t5k7Lg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0MydVFnTk5wdUQwRU91aExTL1lOSk9jUnBTWVhjS3AzNlkxaG96ckxiSzEw?=
 =?utf-8?B?dURRd2FPeSsySFdkVnd3OTV4UlBULzBVZFBEOFpHZ095RW91T2pVY3FLZ05l?=
 =?utf-8?B?ejUxZUtPdmxxY2MzVWNjZXVOaldUTDJzM2xiVXgzRHBmMnBOdjFkMzI5WEN2?=
 =?utf-8?B?RzlONEx0K20waWpscjVTalV2ekJhM2VUZ3BIZ0ZDbDZBMFdFamVKWUpGa0x0?=
 =?utf-8?B?a3hsYnBmU0d5Z2hVUzZzcml6WGIyd0RjWFEyNUxoY3FkMW84L3lSTzQ4b3F4?=
 =?utf-8?B?SS9NUGU1M0hZL3o0WGYxN1NmMHlCYmF0d0JVRm5Za2p1Z1FGaFZrTlNHQVFR?=
 =?utf-8?B?K04yZjNnbkVIWTZGNWNaUFF3a3A3U2pxdWJwTUVPZVRyYkNlODdmaFd6d2VE?=
 =?utf-8?B?MDQxd2V6VVZoaDVUa0RvaWthNWVsZGhmaDlWL0xuN3RSMXg3MFBhMUhmNWsr?=
 =?utf-8?B?TVFmWkRmVUdTbXo1MTFYOUljRTVpT2F2VGx1cnllZG1yd2RJRlV2b1Y3SWl2?=
 =?utf-8?B?TXpITzU3T3grby9SZm0zNXN2V2xacVp3bjJQRW5lOTBuMTFDUVNJZ2VaSkt1?=
 =?utf-8?B?TU9vQVFWT2kyT3FsM2Ywei9DRm94NFpPZUdUNDRhK2ZQbkY1WTU5U1NYMHRO?=
 =?utf-8?B?WEVnVm9taEY4SEtWQ1k2R0RrdG1KdllnamJTNHk0K3h6bFZIckp1bGh1SWR4?=
 =?utf-8?B?SWFTZTBnenZvZzRrWWFDVzc2SlRNV2F1VHU4ZTJsdXBDcEVVcU5FUmRZMklD?=
 =?utf-8?B?NkRMODV2WVZBQzNSc3hPUmdHMFVRL0xDUFZwZU00Um9JWWhtODladUpGMm1p?=
 =?utf-8?B?bEplcWt5b3RIbURMNzl5UXhCdnhUMXZDWktPMlVZWkRoOHVEbG41Rkh1azFE?=
 =?utf-8?B?SWpZeXlpcjFlQXFKN1R4dUtiTHBGRDhHM2RUYWQ5M1p4TDVlZE5qdmdCcXlI?=
 =?utf-8?B?MWFjMk1Wd3kxallpcytoYi9kdHkvamx2c2tHa1Q5a0tKcVMyK01LNjBOSi9n?=
 =?utf-8?B?Z0xmcEFMbWMxYXk2THZ5Tmp6WkhTNG5TckxJbUdUbUxYemJyK2VVNkVPUEVX?=
 =?utf-8?B?U0VpTTJ2UDRMd1JqbWdBNlVTaHhsQjRHVWRSUHJ2MExNNThyMWVFTkFIOUlm?=
 =?utf-8?B?ZGdZVHMybEZiR2laWEM2eGsyVEVYcm10azM2Qkg5b1Jkd1EvTUpNRkRadkIz?=
 =?utf-8?B?SWxnWHlwMkVlOVY3Y3RYS3ZzZkRHaHhxeHhGNFFjdmJiaDk3dXpFNkdNVVdM?=
 =?utf-8?B?ejVZUTBVcmJDa3Era0pyZEF4R2lheGNuelVJNlJ5TlJlNjR5eTgrZ2MzbVBz?=
 =?utf-8?B?bEZOSllyeGg2L3ZHYzlGcFh0bHVmYmlkWWJZOHBoRks3c21UaDNSNjZrUDhi?=
 =?utf-8?B?Z1dmZmNVZ1RlVDhES0JWOThRL1NKRUlBWVJRTzl5czFsOVRzd3ZHUmxGY1lx?=
 =?utf-8?B?eER2WVBCZWlHMkFVUHhZT2ZkTDFIZnBRUUtUOUtVUUN2YjdEWG53dExjT2lE?=
 =?utf-8?B?VlhneW4wRDMwMExGV3VGUGJVOWJvcWpjWGdHNE1ta1J2SnBkVnc2MzBTdnJH?=
 =?utf-8?B?eWpzZXBQT0tNRlgyeDRvazNOYzBwUWdaaXpMUGg3RHJySU9UKzFzZjFlOVVJ?=
 =?utf-8?B?YkpmWEYvdGYwZlREZDVzbGk3VENLMkpMeStsckIvSytMY2VlM2R0SVVsRTYw?=
 =?utf-8?B?MUpQTnRsUlJjMWdITUpPVmkvcmJ1VkZZR2UzeENudWtGT2N1d0NZVWlxOUlj?=
 =?utf-8?B?TklnOFZrVUc0bUN4dnBBOWZkZzhKSUlKcHZEUXMxdlJwZWxRWDhLam5mbEox?=
 =?utf-8?B?TmZKNnAvb09mNnFKYXNPUERyV2piUUJxZWJWakUyQUpER0pXYS9MUFVtUmtt?=
 =?utf-8?B?U3E4ZnhycFcxTnZ1ZEpEUFNJR3pGTnUxNUIwQnQ1VURYRHM1T01kTDF6d2FY?=
 =?utf-8?B?cWt4emQwSXZJT2M1eTZTMTYrYllnb2ZmcjBRajczQmgvOFRjZHBGNzMzMVY3?=
 =?utf-8?B?NEcvNmZndDlQR20wZlc5OGRNL243d0lqaGhYeVZmL3pCQ0xONjVDcTBleWFX?=
 =?utf-8?B?MW1qTXpnOTY4dGhWOGdENTU3S0RBZ0tQVENYRnJVRWkyTytXK1p3V2NGdmZz?=
 =?utf-8?Q?H/k8cUugYn3miIArxRoneoqMm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e450e00a-02d3-4925-70e6-08dd2ffeacbf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:08:22.4334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry1BEbV4fDhJAsZ4nO+EzA2kMhp/QnQ9ydNgnxsbd7U2H2MGoU9wMcw6gNu2BL6SdviXGMvji7d/93vOBWjYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

On 1/8/2025 02:56, Jiang Liu wrote:
> Enhance error handling in function amdgpu_pci_probe() to avoid
> possible resource leakage.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 41d1b06be600..f8deca2f2696 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2346,16 +2346,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		msleep(5000);
>   		goto retry_init;
>   	} else if (ret) {
> -		goto err_pci;
> +		goto unload_kms;

This label change looks wrong to me.  If you fail to 
amdgpu_driver_load_kms(), why would you amdgpu_driver_unload_kms()?

amdgpu_driver_load_kms() has cleanup handling already to call 
amdgpu_driver_unload_kms()

>   	}
>   
>   	ret = amdgpu_xcp_dev_register(adev, ent);
>   	if (ret)
> -		goto err_pci;
> +		goto unplug_drm;
>   
>   	ret = amdgpu_amdkfd_drm_client_create(adev);
>   	if (ret)
> -		goto err_pci;
> +		goto deregister_xcp;
>   
>   	/*
>   	 * 1. don't init fbdev on hw without DCE
> @@ -2424,6 +2424,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   	return 0;
>   
> +deregister_xcp:
> +	amdgpu_xcp_dev_deregister(adev);
> +unplug_drm:
> +	drm_dev_unplug(ddev);
> +unload_kms:
> +	amdgpu_driver_unload_kms(ddev);
>   err_pci:
>   	pci_disable_device(pdev);
>   	return ret;

