Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C3C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 12:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6D210E7AE;
	Wed,  7 May 2025 12:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CfPalOB+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AF610E7AE
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 12:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/CFYdZ0PT2T4ko4lbvmYpI0/El4LC3ejBsYB+FkPDEdxNH1vhVhxU/A5Bd51U3JCCD9Fe1zC2qT1HxtMkcGHaCutUN0/cZEJ7T09/A2TitOFp5oJPEz61qadKYJEpGz7BFNnkOBtZ34XZ3Je9v5HY3CTMtYRRLF/7qU4+NHDfLcuqchRavTbT6yf76UDeDp3iWcuf6/VejwKtiRFqu5/XMuoOOwi4qRaDK1DtTYAOI9DIx/dsPhDH6wC2EBu5rD+C/tIdEEHcnafDdCXFGMM6D0RNbRuUEO8Ya6oYs0AGFMH2++uT0p7sQfZX9khhwRe07IZG4wcWIOYTSMg1heRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rta7wx3H6o14Qn+6grCuiyO9rYF9jgLdJ3j5ZP6udo=;
 b=tUl+HE+8W5LrKaxNmbXCIkmpGV6Jl0PyNJH9DxtXxRJoTzQyekjR7KYnqWEFpbbg9MZNs+5LX3znO3XJ7aeyBWbCZ0zn7FpvYPQfLWDDxh3g9V7gZ1ftkUXFleTfj27TjqyNU8ceyx/C+LTYsbpGdddqvkFjDcXdauAG9ogU4a0x0Evtx077mZiECAz6F+0+Y28rn8nfpAhXncyUx5SKIcGGMBigW6x/8YfvGMjrjZdKkIaAaCspmg+bza4j3eL3mKJB8+k2wYKSoSsaIEgJ42FHhLNkHLCEo/lTaelvjzLceJwuRs7JL4osLTgLT7+YMI+h8+6UuS2wz9Q33Q4MvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rta7wx3H6o14Qn+6grCuiyO9rYF9jgLdJ3j5ZP6udo=;
 b=CfPalOB+16M0768MvNoG9I3JhJExYj8eM7ZaXYJiiFV9N1bcUb0e3nzNlglwaOr8z0dvm+3Q76MYh6mcYwRPGXWI0c1eSlyTBDu44xf1XULud734/yxUm50zT8w+pOL5dCkfFwB6cd/ivmBPPHT79nq2AdmEti9y3RUPMbvjy2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 12:56:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 7 May 2025
 12:56:44 +0000
Message-ID: <a8772fbf-98e3-456c-8fb8-f8aa4ea6a5dd@amd.com>
Date: Wed, 7 May 2025 14:56:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: Sam <guoqzhan@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
 <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
 <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
 <6b2ede19-a7be-48f0-8098-63e05dd62691@amd.com>
 <343bba9a-d21d-448b-925b-f7af8237250b@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <343bba9a-d21d-448b-925b-f7af8237250b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:208:530::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: a03e6611-889d-4415-4e65-08dd8d669e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWMyWVVUZXdyWE9WZldHcklHellXY1FuTUkrUTJZVmtSbXkzbUJua0VlZVJN?=
 =?utf-8?B?d0l6SHBOYXFraWtla2RmcnpvTHhXUjNmUnNEdmlXVVJKdjJyZnFtZ0RJa3lw?=
 =?utf-8?B?dVdtSXJLaGZXYlN5VXM4WnhOU2VZa1htTmRSa29XWmZzMUFYbjhHNGRIYVVh?=
 =?utf-8?B?ZHdYRU5UMk1rbUNnWEtSTTI4Nzg5TTZoclRPa3FhUWIyc3FQQXp4V2NsZjRX?=
 =?utf-8?B?ckZ6dnNaR3pQRUFkWWJJc3RqK0d2TUFlMWRxY09JbW43aTJXL0NjcUFLV091?=
 =?utf-8?B?MWZ3L1ZpZ1FEblJCNGxrbGNKYlFsU0dhV0JUWlhvWVZEVUhFLy9tYTh5RjRz?=
 =?utf-8?B?b29lbE9CT2NqYWJkVjlGWGVkcUU2ck5sUUtQbVdaTEJ3SFhjbmRaUlY1SGZm?=
 =?utf-8?B?SW45TlhyL0RMZ2YzMk5wb09wL0V4a0wrc20zVHM0bW14all0TERqeFFkVVVj?=
 =?utf-8?B?bmhDOE13aG0xNm9GQW1VWWtialdqVDRKbTNKaGdZemh4Ykk4N3BIVlIvTE1E?=
 =?utf-8?B?blFtMVFrejVRcU1lTkZoWkNhMDNvTGFLT0t4cVVHNmxkYUdYeUZSaDRhQWh6?=
 =?utf-8?B?NUhDeVAwY2VvTzNxR3JKeDZuN0FNN0RNcUJsVklxc2pLMHZVQ204YVpFa0FP?=
 =?utf-8?B?VUszR3htYzhGWlVlU0ZCR1hvclpaTWFZNkhGWC81R0VpeVpaTkpVQXFKeWp4?=
 =?utf-8?B?TENheHZqUmZiNjFoUjBHaDZMNlBURy90SVNpSmNNVGwvcjNkcUxLWnRxT05P?=
 =?utf-8?B?QXZFVGVRMnZ4Qjh4c2tqNW1GVlgzN0taeHBRb3R6dVdQcDkxK3NKUUVyOGpJ?=
 =?utf-8?B?SFJoVlZCR2hOemI2d2ZMZVlnZWpyMUJUc051NENWaWQrb0dqMzZhVDhrY0J6?=
 =?utf-8?B?Y3dQYTFJTnViMTk2SytOL2FoV3pHd1BORTJhY2JLSmNheGNaQnZyQUUzZ0h5?=
 =?utf-8?B?K3BjYU5MMTV2aHhlekh6NmlEMTROSXpWMXNFcCswVXVNWkpXc05HOUd2MStN?=
 =?utf-8?B?ZUFIVjZDV0RWQlY0bklMT1Ntc2tQOGxVNm5ncHhLQzBDOTFaazZyRW4xOWNN?=
 =?utf-8?B?U2tXa2x2QmNEVHNMWnh3a2VxNWlXTllzV0hhcFlvRkJTZTdUTlZPU3dERU5y?=
 =?utf-8?B?N1BpU24rT05FRk1tTWszb0NDRDZLNjBFRTNMOHpMemFNSld6OWJaUHZ2QUV2?=
 =?utf-8?B?ejZEWXB2U080aUpybDRsb3FaY2U1eGVSSFhuQ1lQNk9BcUhCbWNTcWRFbjNF?=
 =?utf-8?B?Smw5VElBWHdqa3d3SHlsWHdTZjh2d244VHkwL0J1Q2QySjlRV1k4N0plU3NJ?=
 =?utf-8?B?V1VtYmk2UkZVcnNWY0U0TmhpNnJaa3lmeWYzVUNqY0wxWG9KNkRtMTJYS3I5?=
 =?utf-8?B?WmFlV2sySkZPTlJUUEUvZnZVeW5IaytRTWdLNExzNitsZVV2VEU4aGVYbldC?=
 =?utf-8?B?ekdDWjdINHhOSmZ2M3R0ekdHQTIzajdmSG5hVCtBSWFTbTc1VjVCNWhBL1Bo?=
 =?utf-8?B?RHpTbGZueU4zNG9NbXhRN3FUOGhzNnprUFFUQWdHaWpwQlVpaU5LbXM5aEhv?=
 =?utf-8?B?UXdiT25WckJ0T0k1MU9VVkZuNFd1UjN6RCszcTdLcGhXUHY3KzMyRXBxSnQw?=
 =?utf-8?B?ZUQ3ZGJEVzU5eWN0NlFHeHhjRWlMZk4vSWoveUdCNVF1ekZXMWRJbmRkU0d4?=
 =?utf-8?B?NTk5TU1aSUJ4RVphRnhSNGdrcFdnWitZdFdqblVtS3BsZllBeUlTOXF1NWY2?=
 =?utf-8?B?aU9sVVhSK2ViTnFIOTVTYlVVcnBJVHduK1hpUS90NFFBUE1xZ0RsK2ltM1la?=
 =?utf-8?B?dWUybFJIWFhaeXJ0UExYT1ZPR05JSmM4aGJncDdPUW1WNnpuVE5wK2VKYXlG?=
 =?utf-8?B?bDRlNjQrVFF6eVdKRjI1SXpnTFYwR0V4NlpXeTRLWkoyNGdiWEZxc0gycEp5?=
 =?utf-8?Q?WdQ1YlPBFuk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdrbG1jQmlSQ0d4VS9HUlp5Mmd0T29wazVhQ1c1VEJuTU8vRjM3bkhpdFVl?=
 =?utf-8?B?cEM1bjhJcm9jNHdFZXR0OHVCVmpTeCs3dEJCZWIwbzF2S3U5bVhnQkVyYnFT?=
 =?utf-8?B?dFFoQ2txd09Nb3ZKQ0s0UWpSSGx5akh1UUQ0UTVIMDRzSTA3b1RNaW9XS21O?=
 =?utf-8?B?aTM4VThCOXNIQTFyOVZyOWpFd1RZWlhNdGtLK3oxRnFFWjd0cHhPdUxTaXFI?=
 =?utf-8?B?Ri9DOGs0ZnM2VWhEYWVqS21PV2tXRzFRcHR6Z0dpVDhKckQ4WXNPVVVEK0du?=
 =?utf-8?B?Nlh5Y0dYTWIyZVpYTVJWa0N3YS82NlBCcEdKcEZUd0tFTzU1Y2orQVB1Skhz?=
 =?utf-8?B?V1NqN21WMFoxRWlpWTVHdHpBTTRtTXF3V05sVFZBRmhLSVAwRmZMcXFmODQ2?=
 =?utf-8?B?R0hieElaVUN1Y0F6TW1sb3FiMjZmNXNVdllDYTFPVGo2bTV2a2FZZng2TW9W?=
 =?utf-8?B?Z2JwZVN6RzFUaHBBdEFhdnI5UUd2Q0JXSXhCbjhhdEtpdHhtWHdSdCt3R1p3?=
 =?utf-8?B?S2syV2FCSGxxb2ZMaFRQTWJMWUQzdklpbHVYNTEzQWR2M1g0b000aHgrNTVy?=
 =?utf-8?B?bUFEblpNenBsMDhaTTJDU3pYZlFpSFZjdS8xalVGSmpJSlVBKzVrcWMram9Q?=
 =?utf-8?B?d3ZlQVdRaGN6blh1aHhGaVd2VXhFamhJY2lwWm1jSEpCcHZxU3NUQ0ZFVUZj?=
 =?utf-8?B?M1R2YWpXTisxTTRtTlZlQXNjOVZGOXZDajg5VnhDVytsNzd2RFl1RkV1WUc0?=
 =?utf-8?B?K1ZrbnNtRExhQ3F0QUk3LzlVVTk1ZHZZdEhlR1B4N01jQWpaV0xzRGdPbElY?=
 =?utf-8?B?bnM0aEFVeklqSS9PenhMVVpYSTZDVEE5bkhmaHVrcGp4Uk02S2pjWjFBMERU?=
 =?utf-8?B?c0ZEbFk2NnYyamxNaU8zTldGMjR3Q3JwY3R4eXBsRUh1cCtya2VQdUFEMU9M?=
 =?utf-8?B?aVB3ZWwrSUU2d3pTR2lCSWhUMkFIWForMWg0bE55QjE4bjRhckdXbEtBQzc0?=
 =?utf-8?B?UUd0aXV1OGkzQkQ3QzRkejNkb0RHNjFSZUgyamhGM1Fka2JleVVQM1NVNkNP?=
 =?utf-8?B?YW84UHJ1QkRVSkJkVDB0WHBNVjhLZU1uZmRPTG5zVkZMWWZKUUxNaU1PTTBB?=
 =?utf-8?B?UEpaOXJ0dzh0N21ncXh6WUlUOHhCSE8yUENmRW1wSDJ5RzJGbU9vZXVuSFpq?=
 =?utf-8?B?ZEVvY2pkVElIYzR6Ryt1NERjUGMyRHc2RS9jZEVFNnAzaWV6bGczV1V0MEE4?=
 =?utf-8?B?dEc3UEd4OWZ5Yk1NbkN4Nm5NZVYyd3ZDK1BTOUZ0STFNRVZJczB5WXQ5V3dQ?=
 =?utf-8?B?M0lCWlhTdHNzdVpoeDkwd1hNSXFDVWs0NmdyaEJRNitUdVd3eVNHdnM0OTNj?=
 =?utf-8?B?bFUzMzE4dmVDZmw0LzRUaVB5RXJNN1RkTG50ZmVVZjVVb3ZLQjJaaW1pTmlI?=
 =?utf-8?B?YUtzQXZhZnFkL01jbVJvMERIUGV3d0UwYlVqeVNESWZNeFUrVmJvV25wbXVN?=
 =?utf-8?B?TVdnTThWRVZhKzJGTVJmK3hGQ0I0NHJTT3BOSE42WXpiakQ5b3U5WndNLzc0?=
 =?utf-8?B?amFxV2NSeldUNWJ3L00xd0dBSkptbGdacWVObTgrRmJHSzRKNG9PWHlvSG0z?=
 =?utf-8?B?eVBmYW1wK3NsR3hiNU85VVdzN09oekRnTkRYMFJac0NKNzNNTHVsS0I4c29m?=
 =?utf-8?B?emhXS1F6WkY2eHRzQUo5azlQbEhoNGsvaUtwKzVaRTJnSGlESk93aEN3U01B?=
 =?utf-8?B?SDJWR1FKWGJUMS9Dd0gyMHlKTzRkay9qOWF0ckJRWWJNVGc5M2NvTW5xRUhw?=
 =?utf-8?B?MFhXTCtVWGtOQVJJMUxsVUtNWkczSkk0MHBHSGRBc25ZbEVlaG5sRGgvVG1P?=
 =?utf-8?B?MFVzeGtqQzZTcDJkVXlTTnVFdjdDQzZ5NzIyY3k5V3NLcUY3R0taNTh3RUNR?=
 =?utf-8?B?YjJEd3lMWko0VHhQZkpWTnJOK0p1Y3hWUnNjMFB2QzlaSVUvNExmTThMM2Rp?=
 =?utf-8?B?UE1USkVOTFVLRlFDNnFqKzlVUjdnQ05RbHpKQno0K2xIVUx1SGtVdVIySjZX?=
 =?utf-8?B?UGxBQmlLekhMZ2M2aTFuZEUzOWFOYVRDZnJ1RmFvL2tydUFNc3ZCRTdYQWhG?=
 =?utf-8?Q?/wdpSDrbzXXMj8DI9Wi0i4b5w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03e6611-889d-4415-4e65-08dd8d669e4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:56:44.0297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuWrPxsALft3xxDLbzgWicqEp6FEQnyNR5vmRDDIe5bTSnteWVIFnwtwg+23aaQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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

On 5/7/25 14:49, Sam wrote:
> 
> On 2025/5/7 20:21, Christian König wrote:
>> On 5/7/25 13:03, Sam wrote:
>>> On 2025/5/7 18:03, Lazar, Lijo wrote:
>>>> On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
>>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>>
>>>>>
>>>>>  
>>>>>> Please keep in mind that this is not the only scenario addressed by the
>>>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>>>> This patch itself introduces unwanted sequences for other commonly used
>>>>>> usecases. Please rework on the series without breaking existing usecases.
>>>>>> Thanks,
>>>>>> Lijo
>>>>>   Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.
>>>>>
>>>>>   I also think the new code should be inside a check so that new code is
>>>>> executed only on resume with different VF and do not break existing
>>>>> usecases. Following is the implementation of this approach I can think of.
>>>>>
>>>>> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `.
>>>>> update the fields on resume.
>>>>>
>>>>> - put new code inside code block `if (prev_physical_node_id  !=
>>>>> physical_node_id )`
>>>>>
>>>>>
>>>> Can this happen only with XGMI under this condition? Any other method
>>>> possible like preparing a 'unique signature' and matching it to identify
>>>> if it resumed on an identically configured system?
>>> Yes, this hibernate-resume with different VF feature is only for devices with XGMI. Detecting XGMI node id change is the only way I can think of to identify the case. It's also a very simple way.
>>>
>>> @Koenig, Christian <mailto:Christian.Koenig@amd.com> Are you OK with this approach, adding a check for the new code sequence?
>>
>> Well you still need to avoid calling gmc_v9_0_mc_init() since that is most likely incorrect.
> Yes, I will change it to
> 
>     if (amdgpu_xmgi_is_node_changed(adev))
>         gmc_v9_0_vram_gtt_location(adev, &adev->gmc);


Even that is incorrect. The VRAM and GTT location can't change on resume.

What changes are the XGMI node ID and with it where inside the FB aperture our VRAM PDB0 should point to.

Regards,
Christian.

> 
> And remove the change of `refresh`.
> 
> Regards
> Sam
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>> Regardless, instead of having a direct check, better to wrap it inside
>>>> something like
>>>>      if (amdgpu_virt_need_migration()) or something more appropriate.
>>> Yes, I will do that. Thank you!
>>>
>>> Regards
>>> Sam
>>>
>>>>    Thanks,
>>>> Lijo
>>>>
>>>>> Is this approach acceptable? If not, can you suggest a better approach?
>>>>> @Lazar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian
>>>>> <mailto:Christian.Koenig@amd.com> Thank you!
>>>>>
>>>>>   Regards
>>>>>
>>>>> Sam
>>>>>
>>>>>   *From: *Lazar, Lijo<Lijo.Lazar@amd.com>
>>>>> *Date: *Tuesday, May 6, 2025 at 19:55
>>>>> *To: *Zhang, GuoQing (Sam)<GuoQing.Zhang@amd.com>, amd-
>>>>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>> *Cc: *Zhao, Victor<Victor.Zhao@amd.com>, Chang, HaiJun
>>>>> <HaiJun.Chang@amd.com>, Koenig, Christian<Christian.Koenig@amd.com>,
>>>>> Deucher, Alexander<Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
>>>>> <Owen.Zhang2@amd.com>, Ma, Qing (Mark)<Qing.Ma@amd.com>, Jiang Liu
>>>>> <gerry@linux.alibaba.com>
>>>>> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id
>>>>> and GMC configs on resume
>>>>>
>>>>>
>>>>>
>>>>> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>>>>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>>>>> is enabled, XGMI physical node ids may change when waking up from
>>>>>> hiberation with different vGPU devices. So update XGMI physical node
>>>>>> ids on resume.
>>>>>>
>>>>> Please keep in mind that this is not the only scenario addressed by the
>>>>> driver - for ex: a resume sequence is executed after a device reset.
>>>>> This patch itself introduces unwanted sequences for other commonly used
>>>>> usecases. Please rework on the series without breaking existing usecases.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Update GPU memory controller configuration on resume if XGMI physical
>>>>>> node ids are changed.
>>>>>>
>>>>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>>>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>>>>>     drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>>>>>     3 files changed, 29 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_device.c
>>>>>> index d477a901af84..e795af5067e5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
>>>>> *dev, bool notify_clients)
>>>>>>           return 0;
>>>>>>     }
>>>>>>    +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +     int r;
>>>>>> +     unsigned int prev_physical_node_id;
>>>>>> +
>>>>>> +     /* Get xgmi info again for sriov to detect device changes */
>>>>>> +     if (amdgpu_sriov_vf(adev) &&
>>>>>> +         !(adev->flags & AMD_IS_APU) &&
>>>>>> +         adev->gmc.xgmi.supported &&
>>>>>> +         !adev->gmc.xgmi.connected_to_cpu) {
>>>>>> +             prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>>>>>> +             r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>>>>> +             if (r)
>>>>>> +                     return r;
>>>>>> +
>>>>>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>>>>> +                     prev_physical_node_id, adev-
>>>>>> gmc.xgmi.physical_node_id);
>>>>>> +     }
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>>     /**
>>>>>>      * amdgpu_device_resume - initiate device resume
>>>>>>      *
>>>>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,
>>>>> bool notify_clients)
>>>>>>                   r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>                   if (r)
>>>>>>                           return r;
>>>>>> +             r = amdgpu_device_update_xgmi_info(adev);
>>>>>> +             if (r)
>>>>>> +                     return r;
>>>>>>           }
>>>>>>             if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
>>>>> drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> index d1fa5e8e3937..a2abddf3c110 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
>>>>> amdgpu_device *adev,
>>>>>>           if (!mem_ranges || !exp_ranges)
>>>>>>                   return -EINVAL;
>>>>>>    -     refresh = (adev->init_lvl->level !=
>>>>> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>>>>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>>>>>> +     refresh = true;
>>>>>>           ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>>>>>>                                               &range_cnt, refresh);
>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
>>>>> amd/amdgpu/gmc_v9_0.c
>>>>>> index 59385da80185..1eb451a3743b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
>>>>> amdgpu_ip_block *ip_block)
>>>>>>           struct amdgpu_device *adev = ip_block->adev;
>>>>>>           int r;
>>>>>>    +     r = gmc_v9_0_mc_init(adev);
>>>>>> +     if (r)
>>>>>> +             return r;
>>>>>> +
>>>>>>           /* If a reset is done for NPS mode switch, read the memory range
>>>>>>            * information again.
>>>>>>            */

