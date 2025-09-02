Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A6CCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 07:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C28310E1A2;
	Tue,  2 Sep 2025 07:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1yBbasq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3263710E1A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 07:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGJwptNVSRVwr/SWQuZHwblatxPJuaCflhEfbIoII3+mZpNeyIxKzJPz2iQs6fc5+vsF6W7lg0YSymm/21BlWKnMktvsF9dsg3epQEINPhKUH3nAlavMviU9ne53Xon26G+ajzZT+qmJ0VL1z0e5vkgC9lRl2aogLZJ3QF/Pxf9SbT+TJf220PkhnauqUyXnxVjyQhNIunuBBQHs+RSoUgrmU+5q+9KXsTnS9Zi409ppQVjAFuRJMTSO6ZzFxm2TOlbWYKbKZLzH8EtIqd8NWTXZXsuzWxrkHGbjAkRxxZYd6zSdnNP5NYJMNWG+StlkjOTnPE6iaGVdCRHOD+rFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2DHR6z0x8i7RiRpGlu0UzfPJn+9Sk6q1Qq1L4nqHas=;
 b=xnvsCdaWDZFbLnUlWmkgf58HrHtaG8E+uJOpnI83bNgjJumYMQ4zU+USOLzUvT9NansqBtgslJEZ0/Xath9XXxHntFwrhun35Ev/rTv66hIkzh3xCRv0xqponeTkS4Ugu12dy+rrchBJ0xx24gXo9U1kc96442j14XkhUO/5PyWt1c3AU4eDpeDILGZkbAyxSgGLKBAUyB22MulUJZbgpVcW3Jmwt8QAWmOH9pjGMu4NoeRIhJY+znKYobq9ynYu+mVRFYQSA3a4vi35KGDfxW7urlJPnCyKsD7Mpp3EyY/aTguUKHj++22krNfGYjj3c75RMXiByns8SSYo2qIWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2DHR6z0x8i7RiRpGlu0UzfPJn+9Sk6q1Qq1L4nqHas=;
 b=E1yBbasqxR4SO6M/ywwstGjMSyKmr/XnhEH1BO3m6329+t8AvI3FPWH4nG6FkqZZDqa3Ue7YwTxoWgFMeiUsl0r6lWQaChiMLPLzkN8zFnLl7+bo1W2Gk70LUrnTFP89sD15dDx0IR0KvOQyZoHML6ORxhJINzj1U+5YAWBXxcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 07:21:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 07:21:50 +0000
Message-ID: <c1e61d59-b8e7-485d-8e75-34bc306a430b@amd.com>
Date: Tue, 2 Sep 2025 09:21:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
 <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcd085c-27e9-4508-d5ae-08dde9f161f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkV4SGZLZ2kwdzRERHE1UTFWNTAzSWZjRHJMZVFpNDEvcEt1UjVNUHF4QXFB?=
 =?utf-8?B?YU1NbWNxNGhlRGMwb2tSbVNlcW01aDlDOTF4L2l1V1M0U0IzTG1BL2hudlhC?=
 =?utf-8?B?bXJzQnJFTkNTMWhROE1qdldVam50UWlmeUorRjlTU2RYUU5waExUMW5oa1RJ?=
 =?utf-8?B?Y29QMW1GYnVjald6SUxQSlNyZmptZjI5YjlKZy93K0pkSkI2ZnBVUUU0Q2NH?=
 =?utf-8?B?NVlnTndjcXhaaUtMUkRJcmJBNmJCMU03VWJNa2FZOUdiODhQTElETG1yQm0x?=
 =?utf-8?B?VWlFSFlwK1I1MEs5TTkxUng0TzVsRlZMRzJ2TXYrWUlVRUhsOUNhOHFsUlpv?=
 =?utf-8?B?enBYT3VTRTZMRGc3SGk3QkJEaE1TWHRwSXBTTEFLZXZkSzRkcFZKeXBnbU41?=
 =?utf-8?B?cFJTM0xwaUgxemNWVk8yMkJVMUNpYmtlSEhBQkVBS3R3L1M1eUVjdWo4ZG9z?=
 =?utf-8?B?eE1DYmRkcXBNMnJhMDR0ZktBa2I4MnpkbE1XL29QeWZEVGIvNlBkR3d1MmJz?=
 =?utf-8?B?clpJMWxGNmlSc2VTdVI5bEh5ZzRxQUtEcnIrNVFjUHIxZFA5cWIyNHpHUE1k?=
 =?utf-8?B?NUE0alZrNnFmRW9SZ1k0UWw2bmRMMGxGY2VockdFeGpNMU5qTloyako2TTN0?=
 =?utf-8?B?aHZEZURjbjI2VElTbkU3WFFiYmlLMllnOGJPSk10MmpOemplTVRyRDAwNS9T?=
 =?utf-8?B?bVJta1M3TjZWSnR5MzVzS1ZubWRtUElhaVMxNEhQaGsvM3BYWDBuVFNSUzRK?=
 =?utf-8?B?cVBvUFh2NGJ4Q2Z2Vnp0YXJVdEU0dlZGTWx4SjBvOThaaHByWkJ3N3lDUTFh?=
 =?utf-8?B?cE1WUGtJZ0RLNldlYis0NkZLMW5QVlRwTWVzNE44ZkdleHFSYUpiajJCWSsr?=
 =?utf-8?B?ZUN1RE13KzhMOVpQa0ROSHlBblVLUXlGakdEYzZMeU82dFdPOHpNejZRSStu?=
 =?utf-8?B?dXh3aFRqT2ZUWElxTmo4OExlYUlwUWp4ZXdsTE1CdFZVQnIxR3IyaFphVExu?=
 =?utf-8?B?NFMyUVdwTTJ5Z3liTnhPL1lYUS96UzV5QWkwdmw2UURZNWg2cDNrMkJMTWhN?=
 =?utf-8?B?NDdHZ1pjK1VUWmxZbFgyUmdiMCtha016cFZkcUJ3TDNxQlRWRzlRTGdiaTkv?=
 =?utf-8?B?bGFwdHpBNUh4MlVDSE1sMmQyUDRhUCtGMzR4cHBPTHg3Y3l2YS94bHlmc0hL?=
 =?utf-8?B?V1NpY0JjdldmOEtOaHVFSGtLL2xzdmRLY0FZTVNJVnU4OGU0Ukx6K3A4M2lw?=
 =?utf-8?B?QnYvRFhmRU1RbHd6M2tIY1d2UE9Rb2ltblA0ejhXclVYZ2huaTRWOWJFbndP?=
 =?utf-8?B?VFQ1T2pDYUVsNEZpSnYweWZ5Q0M4OFNML202amliMWViejJtMU9jcU1KSFhr?=
 =?utf-8?B?Q3hLSm9NNG53ZUlCVzZvbjlqM1BDVmxNU3gwMDJJalNQZDlKSVNWSVBCRTVz?=
 =?utf-8?B?azdMT283bjFwd3B5WnlEcUVDTEUzUGZGYkxsRjZOdGlveFE4NHc4MTY0QjJQ?=
 =?utf-8?B?MCtIWm5STW1weW0zZlFCSE1XNG9nTXowdEpNY3lZS2R5c0w4aDNZRzhnWFN3?=
 =?utf-8?B?MmtYTk9jNXdVNWlobUFYRjB2Z1VudTRkSnVnU3pBbmcydHFrSzFIL2J5ZFBT?=
 =?utf-8?B?Y3UxTGNQQUJwRENTTVFxaVZSL3ZyV2ZaNDB4MEJlWmprWm95WS90VjhFRW02?=
 =?utf-8?B?OU9xY3d3czlwSnd4RVU4aDZubUh2a0Ixenp3U3p5Y2pjUStOZENEbDEvWjZK?=
 =?utf-8?B?NXBEUEtxYkQ4bnJZN2YvMXQ1UEFVTG9SNWx3SWNFOXJ2VHl2ZVdqckVQVVRQ?=
 =?utf-8?B?RjI5K3FhT1AwK1NWcUxVUjlUTXVIUkdrYTNqeEs2eG45ZkV6NTdESUgxMnNn?=
 =?utf-8?B?VEk2ckRUeEl3U3hqMmYvc2VoWW9ucmg3U0RuNXFHQk5ZUlB4WXVhMEw2YnRR?=
 =?utf-8?Q?v+R3eoQYEcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS8zMGtEdlo1RUVBZUxGVXJOMDVaVEFOYU5jSStIT2VqdnpadUozMVE1K3h2?=
 =?utf-8?B?RisyYTMzaGJudnNYS3JCalZtMVNJdzcxVDRJTHFqVWJLWnozZkdGMjl0OUtB?=
 =?utf-8?B?RHpFbjNlQmlBWkVHcHZWZGNTYkZPck9GVEFRbldJLzZPanQ5M0tndFhaWWRv?=
 =?utf-8?B?bXdiYitIVTU1eXJFVjF4K2pjUndETU1iU3N6OU1yaTd6NWh2WnIxaG8wRXBl?=
 =?utf-8?B?dm9DbU16UzFPQkV4cjNjR2tyMU9zUlczNVdKeXk4djk3MTBjUk5XTzFWcWVo?=
 =?utf-8?B?SzdMOTZxWHc3RkxhcUNsOTJkOXdaeElMSmFzNWxaZlF0ZEQ1S080VTlEVHlj?=
 =?utf-8?B?ZWNmZG9VSUJTNEtuLzFGOFcyQ0tsSzZsMWcyU3RNa2dISXRxeXArNm1XbjUz?=
 =?utf-8?B?QUVjSFE5SU5aWDNZNTVBWGozUzkwZjlNWHNhT003R1dmdjNZV2tRSXVweUJt?=
 =?utf-8?B?OWVFc3BrWW5UNEhKZnpwVGU5clBrYVVNeHhTQ1FlVE9KbndNbWwxNUdyZ1Uz?=
 =?utf-8?B?VVhha3lIYkJ3Yll0TzNFUlFzenltcXBMR3lFd3I5M1NOeHlZU2hJWFZxRkZv?=
 =?utf-8?B?dmVQU21YdzRPUTRJZHRrOFFhZzVVcXJ5NHA2aklkSVBRVyt0ekwzRkJYcmJZ?=
 =?utf-8?B?TU5ReVVpRHBiUnMxMXFYYzhvTjRUaHFiZWhZSnBMOCtNdTNCUzZyRW16b3Q4?=
 =?utf-8?B?MlpRRWx0ZFc5RG9FNlZtZFJlbkpBYUFwVkJ6dThmYVhJVSsvWDRxUkY3czQx?=
 =?utf-8?B?dTR3NUVUa2pNRnNKQTVvcmFXN2lENlhEYi9Zbk9leG5QdkhDUmxKUXBSbk5U?=
 =?utf-8?B?azMyR1RTN0g0ZFU0U1JhQlFJek9oVkpMWWRLNG9aWVRxTnhZNnlObGUzVXUx?=
 =?utf-8?B?b3hIN1EzY2RPeHJvdXFNL3ovbGMwMGNJb0JwcGl4OTdhMVdJRGhnclpENGtU?=
 =?utf-8?B?QjlJYlQ3YXFPL3hiTmJybUt2Ynl5SkhVTWlYSnBhVWtTNGJnOGVGRkpSUkhw?=
 =?utf-8?B?cm1TTEEzTm1kUzVEYU1LY0pzbURzMytBejZ3MVNaaEpVRnZMZHU5T09Sc0Q4?=
 =?utf-8?B?ZDlvQ0ZKa2tXZGU4cUFlVGZuRW9kYVVWQ25BUWRiN0hUcDRMTDU0MTdSZlhG?=
 =?utf-8?B?TjV6TGpOMHhDRTNxaFZueHp0ZmNqanhjNmNnTk5ZdWpOQ1dVaFNTRkh4NHFs?=
 =?utf-8?B?d2pKc0VuRlBOWDN2eHhsSGEvTXcrMk1jbDJyckh1blR6cGxoZjNQa2dYeUcy?=
 =?utf-8?B?aVJTcmtKaDREeWRBQXJ6Q3pZbDRmcldndEF3enRRWmRLVTJ2QzlEYkkvOUM1?=
 =?utf-8?B?Nm9rNzZkbXlXK0Z5QWVQVzNMb3Z6em52WHJWWkpMNUV3ckpxb0U4Z0RCWEk5?=
 =?utf-8?B?L21QRXNueTRoNXBoRHdsTk8vMkdaNDZxMlBJUGE4SDlDQWRMZ013SUJ3Q3Fy?=
 =?utf-8?B?djMrMU9Nank2cFZsTDlCMTl2Rk1iSlo0UkU2cDJSeTVYWllveFBnK2szWUVK?=
 =?utf-8?B?MlJCL3EzOVZEc0p4RjRwWHBIK2xyeXZxTkc3Q0xhcHRIS2lqbXU0T2pRV1Fr?=
 =?utf-8?B?VmJhbHZBMWp4Z3RIcW1TdERFL1BHZEFVV2dKREdzVUppUnFKWTNYODZKaldC?=
 =?utf-8?B?bk5nUzZzNmlMQ1FTOXNPVk5uOTlxczhucVdJOXh1eHNpV3UyRXUyNWRyRXpp?=
 =?utf-8?B?cFNQcDJ1WkpHUmpFWEtvVnZ0TWh6QlZPOFAzc3FqNGNNUTIxbzlWRkxCcmRM?=
 =?utf-8?B?cVlTZG1zSU9HV2l3NDZ1KzRrQXRqTGNJd05GWXZqOTNua0huTmZTRUJJRjRM?=
 =?utf-8?B?LzhMUWR6QzBvaytQc09FaVJKVFJ4UUs2aytBNnVNMWNsUUg4Z1ZUVnpVdkgv?=
 =?utf-8?B?UmJyUEJycHRXYTNRSS9VMG0rWTRrODQ0b3NlMUs3eW5hY1VQRnJoRld1R3RO?=
 =?utf-8?B?UkFIZC90L1FvZzkzR3o2bUdpeUpVaVEybHgzbHFFVDM0eUJSUVE3Q1I4MElI?=
 =?utf-8?B?UkY0dGpUTUFUUFVBRVBndFNHdEVDV1pCMkFxNDFmWlJBMm9OZklDcGRWS0tn?=
 =?utf-8?B?alZWQnVweHhTTWZQOUlGSGFVL2R6bHFBV25oa082TkNSaEVLQmtUQ0d5cHpn?=
 =?utf-8?Q?4XZb/hqlIjWPmJ+Fs/P4wA804?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcd085c-27e9-4508-d5ae-08dde9f161f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:21:49.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RaKaIdLG7+uDFrxcvv+YPBc7VWXH+JBqt3wQbwpBhEKbFg5yziUXh7KofWvyqrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

On 02.09.25 05:29, Srinivasan Shanmugam wrote:
> Add mmio_remap bookkeeping to amdgpu_device and introduce
> amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
> one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.
> 
> Bookkeeping:
>   - adev->rmmio_remap.bo : kernel-owned singleton BO
> 
> The BO is allocated during TTM init when a remap bus address is available
> (adev->rmmio_remap.bus_addr) and PAGE_SIZE <= AMDGPU_GPU_PAGE_SIZE (4K),
> and freed during TTM fini.
> 
> v2:
>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
>    rmmio_base. (Alex)
>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
>    (no warn). (Alex)
>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
>    is stored in adev->mmio_remap.bo and will later be exposed to
>    userspace via a GEM handle. (Christian)
> 
> v3:
>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
>    (Alex)
> 
> v4:
>  - Squash bookkeeping into this patch
>  - Place longer declaration first; clear bp via memset
>  - Reserve + pin + kmap(+kunmap) the BO at init; unpin in fini
>    (Christian)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 87 +++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..24501d3fbefe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
>  struct amdgpu_mmio_remap {
>  	u32 reg_offset;
>  	resource_size_t bus_addr;
> +	struct amdgpu_bo *bo;
>  };
>  
>  /* Define the HW IP blocks will be used in driver , add more if necessary */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 1a68ba17a62d..0d03e3a6f92d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1854,6 +1854,87 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
>  	adev->mman.ttm_pools = NULL;
>  }
>  
> +/**
> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
> + * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
> + * GEM object (amdgpu_bo_create).
> + *
> + * Return:
> + *  * 0 on success or intentional skip (feature not present/unsupported)
> + *  * negative errno on allocation failure
> + */
> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_bo_param bp;
> +	int r;

> +	void *kptr;

kptr should potentially be saved in amdgpu_mmio_remap.

> +
> +	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
> +	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
> +		return 0;
> +
> +	memset(&bp, 0, sizeof(bp));
> +
> +	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
> +	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
> +	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> +	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
> +	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +	bp.flags       = 0;
> +	bp.resv        = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, false);

The last parameter should probably be true here.

> +	if (r)
> +		goto err_unref;
> +
> +	r = amdgpu_bo_pin(adev->rmmio_remap.bo, AMDGPU_GEM_DOMAIN_MMIO_REMAP);
> +	if (r)
> +		goto err_unres;
> +
> +	r = amdgpu_bo_kmap(adev->rmmio_remap.bo, &kptr);
> +	if (r)
> +		goto err_unpin;
> +
> +	amdgpu_bo_kunmap(adev->rmmio_remap.bo);
> +	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> +	return 0;
> +
> +err_unpin:
> +	amdgpu_bo_unpin(adev->rmmio_remap.bo);
> +err_unres:
> +	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> +err_unref:
> +	amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +	adev->rmmio_remap.bo = NULL;
> +	return r;
> +}
> +
> +/**
> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
> + * @adev: amdgpu device
> + *
> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> + * amdgpu_ttm_mmio_remap_bo_init().
> + */
> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, false)) {

Same here.

Apart from that looks good to me, feel free to add my rb.

Regards,
Christian.

> +		amdgpu_bo_unpin(adev->rmmio_remap.bo);
> +		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> +	}
> +	amdgpu_bo_unref(&adev->rmmio_remap.bo);
> +	adev->rmmio_remap.bo = NULL;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2028,6 +2109,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> +	r = amdgpu_ttm_mmio_remap_bo_init(adev);
> +	if (r)
> +		return r;
> +
>  	/* Initialize preemptible memory pool */
>  	r = amdgpu_preempt_mgr_init(adev);
>  	if (r) {
> @@ -2091,6 +2177,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>  					&adev->mman.sdma_access_ptr);
>  
> +	amdgpu_ttm_mmio_remap_bo_fini(adev);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
>  

