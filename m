Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B5C27C53
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 11:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1668D10E76E;
	Wed,  5 Jun 2024 11:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DSZDz594";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F82110E76E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 11:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faSC6BNbY2/CayNHgsqXPggGaV9a7Ro7/byP3Gs5+d3iLDU6DuI7rI2iGOUAUT8Is/bN8TT4jpp9gSNfHiFHDYRpNtPrAmzhchxWHuH1B6JXplEPQ/o49+QXhOh8i2Kde6IJqU5FICh4Uk/3uSkw4quzu11zbBJAYyMgX5UM3iELIUSIKobYsyE4sdzqQvca3EVcCxxIwqN5ZuFSbO7/hbT3FgCAEO/7y0+l7JtbjEoV9ZtatBJKMK4V9+Byx0Z75swadnGMhm9/i92MKsbPOSRLrG8eh3G2rFzTj/o87cRoYx73bOfidCONgJAFDByiWRh8PQxqc2eTpZrlkwSzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/qrrq1KNf++3TrOYdV0Hi2LiUio9nymQy5VLPQ96I=;
 b=ctqRF6SNaihus1cYi0eAZxXQbmVFWnqkOIQ8diCeryjX47bSCDYw9CBJzYH61ZhKucvBSYRRkXmz5RLuYBskiP/fz3x13hW1Ys4DnPwJ2ZKJMcc066NTxrjUg4YfHs+T7Iv9wBfVv+zTEzJSN4nSJAAkrFEV7tmjQ8ApeYwI9VaetvDIPqCqQvQb3liEv8kE5JOQxrbnl2mhHvY7MBhA0qBzxDnw6O9KLqydYLczDRcftU4PMrszJixrOYpmmfAoNZkL0KP3D2sgsNoNNHJ5RZjLVTrVyeT19Kb998/kHUW4TL4oBnUubFxCZvS0kl4DYUX77AMLA9CPTOC+RDaYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/qrrq1KNf++3TrOYdV0Hi2LiUio9nymQy5VLPQ96I=;
 b=DSZDz594Bi1H1iYwOe3+PSGDIhFaBEI6StaDuzP8mJ+rp8kxcFBFL5sqUhFxcBRqCPpGTbakC1r0cFOBSor8wbzbEykKDMsMHQBZ/C7AeDjZyZn6ePykGZ6ZG3tVxXKXqJJXQKdVPlcyCZWv/FRI8EHnA8KjPSxIy5fZYcIQ9v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 11:20:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 11:20:38 +0000
Message-ID: <26da22e5-829b-4a27-9106-c9b3c89e42c1@amd.com>
Date: Wed, 5 Jun 2024 13:20:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve
 function flexibility
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
 <PH7PR12MB5997A438EEF49A7BA1D6C23682F92@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <PH7PR12MB5997A438EEF49A7BA1D6C23682F92@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 227c5c61-af8f-4695-43d4-08dc8551868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3Y3eGZxTWE0Ym0zOGxGa2NFZEJqZmhUaFV3Snl2dEpaYzQrSHl4K0RMYU1O?=
 =?utf-8?B?aXNIU2tGYzlORzNoekdtVFc4Q1Q1eTlORjhldFpTZnVOUUhpdy84ejVVbzdY?=
 =?utf-8?B?NkNUM3k2R2lhQXMyTWVyWXBkL1M0Z1FaWS9LUFJZZ01lQkVkVzZwQVZTSnYw?=
 =?utf-8?B?V1Z3Tzg5Wm9POG9LcGM1UjZZMGpSYVBwbENRUUdRYXNKblAzMS9hckdXZFRL?=
 =?utf-8?B?V2xIVnhlUWNaNnNham5aam5LRHF0MFhJdHB0MnR0Sm9HREVUdTk2d0wvaWQr?=
 =?utf-8?B?d2ZkNUMwOG1lVm51S2xpaUJkTVpHYVNXZVVNRU9vUDB2eGFDcHJJLzJRbzZo?=
 =?utf-8?B?Tk4ybzdCaXVtK3hoVDNRZkhMN1R1dlQ1SU11ZWdmeU10eEFVR29uWTVTakZt?=
 =?utf-8?B?VXZaeDBTblFXREx3QmRVbVhZcUZuQ0VwS0VhS2xabWVFcGdONStWczZzSmph?=
 =?utf-8?B?T01LWFh5K3IzMGFhNmZXaURoR3c1eDRNMkVUbE1WbzQ1ckZDbmkwWHFnTnlN?=
 =?utf-8?B?M1RlRXdFKy9OQmkzNXpVV01YU2VSdnVYeUZuNVAvK09GNzVsNmh3dEh1MDA3?=
 =?utf-8?B?K2Vxb0dkWTZlSG1iWUVSV2dVNzhQc3lHVnFMaUp4WEQxWUJGVGtwNURSMFdv?=
 =?utf-8?B?N0lGMmpHYTJGRzRDNUtzSFFoVkNqMVhXNnBkcTZ3UU5xWWFBLzdNWW5VVzUx?=
 =?utf-8?B?akZoV0p5TXZicXhmNk91U2pXZVoxTWJBTWxERVRIL05pU0c1VTdMMFJVaGxi?=
 =?utf-8?B?TTFrU1lobFdKTUF5ZTg0b09jeW5wN1JSRTdZU0MrTGhVbHNka2RWTGd1Ymlh?=
 =?utf-8?B?RjdTdS8vSnU5YkRKeERORi9pQUkySEsvMTlLbVBMcFJDbkJkUkdmYVZPYXZk?=
 =?utf-8?B?dkZScC8rVVJDT2trNHNlQmNzNXBVRVVINmZOU1dKVElmYVcvRHgwT2JlMXd2?=
 =?utf-8?B?VmJ1eE8vUXA2RmZZSVlOSXROVHVqWmFHZmNGb3BkRGhBVW81VFdyT1JFWndi?=
 =?utf-8?B?emhUb1ljSVR1cnc1NHo3WEx6QVVNbmswMXVGR3dzc0lkWWpHVTdZeCtiMng4?=
 =?utf-8?B?Tnh2SytsNkZUZEhhYXV0NWU3ZjcxK3J1Wi9hanFUNC9kWDJ6aytablNwWE9Q?=
 =?utf-8?B?TGRuM3pMRU9RbjVDYmNnMC9KNDBJRjJYb3A4L1RJTTFZdm5FVmZQdFZCamxt?=
 =?utf-8?B?dERCK2ZpalA2YTN6bjVOTU13V3hZczVGYWMwd2FvODRkeUhia0dvQ25aV1pj?=
 =?utf-8?B?Y3NaVWZIa3RMcUNlVWxoSGhsa21hQmR5cWpMb0tjekQrWlkrZDRFdy83R2VY?=
 =?utf-8?B?bE5PUWJkRFRsSjBaMENnaEwwV00raFhtWG0yU1hPOGhXVitKTHNzajZTN0tV?=
 =?utf-8?B?VG83K1FDM045TTFoNFN4M3BPaTFVa2N5b0VqOCtJK01nT2pYVzhldW0rQ2t4?=
 =?utf-8?B?NmRwM1JLS2xzZyt6akV2UVFsTHJIU2N2cVJNT3lJU0hzSTR5bWFkekx0Qm1a?=
 =?utf-8?B?cE9ucEFnV2E5MER0M1h3cW1idGRyQm5jRGQ3ZWRjY25KN1BnYUZzNTRhbUFo?=
 =?utf-8?B?YW8raVZxNFR3d25FVU9yYjJ1cG4yT3RPcHJ0VWZQTmdkV2tpZ0kxdDdvUFlM?=
 =?utf-8?B?MmJ6M2NqTDhxNi9BNTFaa0RyaC9rY0lMTng4cndDZ3R5SFhpTFFEWlBOWEJ2?=
 =?utf-8?B?MWNIaW91ZkFtbVNQUEU5Mm9mREpmYnl0WDhEZ0dtZjc3RDkzdGdSYlhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNsOTIwek5UcFlEcHdzdE0yazlPOTBqbDE0WFNWM0Zqa2h0R3pqNG5MOEZI?=
 =?utf-8?B?K0I5OHdkYkZ3dUNrRXVyRDZkN2U2WElyQzMwMHZIVU90S1hLNlNJcjBFV2VQ?=
 =?utf-8?B?ZjBEbnV0bHlsTjV4MjRiWW85aTNjbmNVRlM4UVdBVmlUR3NIRVYrZTNPYVdM?=
 =?utf-8?B?UkswcEo2VEdsNU5qODQ0ak01QnRvbWYyYXAwbTFSMmg5cHhNNmlWWnRzTEtk?=
 =?utf-8?B?eGJQSktZbitzQ2pqZWozWWUvd2IrbmJsRzFmcXIwTjMrV1hjK0dIa1VFclR6?=
 =?utf-8?B?N3V1SkI4U2wxaENPa3FkNUFMdG8vQyswODJPOXowVHcyTHBZem9KZmorK1l1?=
 =?utf-8?B?WmRGeDRoaWZqclczSk5RWGxzWmp5UXVhaEQ0QmFjOHNlRzc4TFM1Y1Zmc0gy?=
 =?utf-8?B?dFdQMWY0ZFN4YnB5MFhpZng3TktaUWI2U0JhUjRaY29vOE5LUHBFUmx3NWc0?=
 =?utf-8?B?aW1HOXFIcXpDekIvOWdPbG9nSTlCZWY3Qk1weWFpQndqZHVseUNYN1ZKOFl2?=
 =?utf-8?B?SGVXYlhpcTNBYllUd0ZYMjRpNzFxaUNPVnh4a3ltdHZlYmZYYXdDYzYzVnhW?=
 =?utf-8?B?bjdWbkx5U0Vvamo5V0pENFpRelp6UXFWTjYyR3ZYeFZVSGxkRWtBM3krWnIv?=
 =?utf-8?B?SFVocEVVakFXSVJ5cEh3ZFMvbS9ubjI3WVBQRnBydjZYOEhwMzdEdVc1dFdq?=
 =?utf-8?B?L0VEbUlUSzg1RVI2RExlc3Q5ekhRNHl5Z010dDk1Z1lKbzB1dFpuL05UVGdi?=
 =?utf-8?B?cUVSVFQ1UDU1V0JKRVBrNUNvaUJQNkF6cHBNbXJkSjNiZkc2VzhCOFVHUXJY?=
 =?utf-8?B?U004R2kvSXV5Ym9JVXpNS3p6S3BVNHpkcEhrdjJ3QlYya3lQdW85MC96K044?=
 =?utf-8?B?R0NpMDFvYWRWT01keUNyZ1FvaWYweUkwZDJPYmYwUGdBckdaemZ4UXd2VmQ3?=
 =?utf-8?B?eFNkNVZ0dktkRXVRaTMwcU5LTnJMYmZIU25EdENnbWtWMVR3UlhQazdmU3Zx?=
 =?utf-8?B?KzFKcUJycDZoVDc5cUl1TWdtMTY1Mnc2WGNKSUdVdTFNckpWZHdqTjl5dllh?=
 =?utf-8?B?NVg2K3BMZnhncHJYd2x0U0w5WnlVd2xOMysxOXVjVmNmNWdFNmw5VFFqOFV4?=
 =?utf-8?B?U1JUbm5LMlRkM1dEcmlDbTRUR0t2b3M4Wk0zSkRkYTRaYWh4ZXpGamszbm0w?=
 =?utf-8?B?NEc1TnVrc0x5L2R4L25lLzltQjM3ckhGQnhoUFJUZktyZDkrMEtGKzJ2UHBl?=
 =?utf-8?B?L0hwMXJPc3Byc0NySGZUOVc4UVhNVjVsQWlXVDRJcUNYZmxZbHdiZGZXbU5D?=
 =?utf-8?B?WXJzc2lkVXU2Q0dWYWFzVWxGVW9CbmRYSDdpMTh0YnMxZGF4cWRpMndDS3h4?=
 =?utf-8?B?VTFTSUdYMytGamszQUIrQXBhcjU1UXQrSFhPcTlzTHpCVzBkYVVBb2VkTjNY?=
 =?utf-8?B?RDcrS2JtUFBLVzR2TCt0SWNhTldxWm5vaGlHQkxXbnAwMnlVTXdOeXN0b1R2?=
 =?utf-8?B?bnAvbmI0VUhpSmtYV3kvR3JaSUF1OUJ1Z09VTFpzUXExdUoxMVJpa3pXZXdW?=
 =?utf-8?B?cmZHNUE1ajJzZHIzUnhibFF1KzhUTCs4WVoybzFJOHcxTmp4S0NhcGljMmhZ?=
 =?utf-8?B?OGlnaWVmS3hmSWRSSEMvTnBUT1NhamtIOW41YXBaN2g1OW9hMGE0VjJDKzJI?=
 =?utf-8?B?UDZxeDlUeUlKYzBjSThYcUZPenJVVWdiMVBiSGllMFRJa2ZjTXNqeVFWNGFt?=
 =?utf-8?B?cXRGMXNaYWd1LzNhYU9xWUV4emtEYTRTU3FuUHQ0NjVDTEVxRGJRZEZZTHJs?=
 =?utf-8?B?cXZVL0g4OUJkeWVSMUs3TVZWWHFraWRPbmJ6QTZrWE4wbmRBNnpxblZERFJ1?=
 =?utf-8?B?c3JXdVU2S1pkUldpZFpWNjFUQ1B1eURPRFlGdHBlenIxYlA0aS9lZFVYNytG?=
 =?utf-8?B?ajRpOEFYcDdlckNaWGc2ZjZFVEllMkowb2ZTQ015N0JDQlNtK2k1dlJGUHJY?=
 =?utf-8?B?T1ZTTjY1QnRKTVFEWkRKcEF3M2RuVGVxTld0c1ZXNDl2THIzZ1A4MFZDWWFH?=
 =?utf-8?B?RW1GYmZYeHByRVMwQVFyTEpsTGV2cHZxYVZzMnpTRUpaWkRGWkxYbUNSNTJV?=
 =?utf-8?Q?PqMyzIGKxckDavSIztlE4JLDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227c5c61-af8f-4695-43d4-08dc8551868c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 11:20:38.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9UJKN07kR09erHoqHxEasItbveidQCGCMuHlD4ReswhIHTtpcJFlYFqqIsRPnty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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

You haven't addressed any of my comments on patch #1.

Regards,
Christian.

Am 05.06.24 um 11:33 schrieb Wang, Yang(Kevin):
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping...
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wang
> Sent: Monday, June 3, 2024 9:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve function flexibility
>
> Adding variable parameter support to function amdgpu_firmware_request() to improve function flexibility.
>
> Yang Wang (18):
>    drm/amdgpu: enhance amdgpu_ucode_request() function flexibility
>    drm/amdgpu: refine gpu_info firmware loading
>    drm/amdgpu: refine isp firmware loading
>    drm/amdgpu: refine mes firmware loading
>    drm/amdgpu: refine psp firmware loading
>    drm/amdgpu: refine sdma firmware loading
>    drm/amdgpu: refine imu firmware loading
>    drm/amdgpu: refine pmfw/smu firmware loading
>    drm/amdgpu: refine gmc firmware loading
>    drm/amdgpu: refine vcn firmware loading
>    drm/amdgpu: refine vpe firmware loading
>    drm/amdgpu: refine gfx6 firmware loading
>    drm/amdgpu: refine gfx7 firmware loading
>    drm/amdgpu: refine gfx8 firmware loading
>    drm/amdgpu: refine gfx9 firmware loading
>    drm/amdgpu: refine gfx10 firmware loading
>    drm/amdgpu: refine gfx11 firmware loading
>    drm/amdgpu: refine gfx12 firmware loading
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 26 ++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 30 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  6 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 11 +--
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 25 ++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 26 ++++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 22 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 19 +++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 27 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 69 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 45 ++++++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 11 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 14 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  7 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        | 10 ++-
>   drivers/gpu/drm/amd/amdgpu/imu_v12_0.c        | 10 ++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 11 +--
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 11 +--
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  8 +--
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  6 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +-
>   .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  6 +-
>   30 files changed, 205 insertions(+), 257 deletions(-)
>
> --
> 2.34.1
>

