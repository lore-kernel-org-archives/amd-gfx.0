Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A354D743EB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 22:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73E210E1AA;
	Wed, 20 Nov 2024 22:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uENPCszr";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D00C10E1AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 22:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD4X4BhVqCuY3e6n9rriU+/eJe9j3ZN8Ldp0JycIjOVCATL6x+/ZJuVeOBXWNyeqKxverpRls/0rDti7lzOmy2qmR1BYR7JiCHE5vmgEs+K0NdHO3g1M/s+Q+bo0vl2ORM/HXuN8Rh9Duh4kF8qlmKUfeq29jD5ePrwOt7NzjK1Zt3r3Lkz8yZxAMIOoK5NPgTfyYly/ypKXIf1+Of4FCuhvvBZqlhaEOnwlh4Kf3zo/lj4EduKhNWhn7O0y9aQ4bQR3xUozYP7OdPSaYR12CpSXNzVwh7mshMNP2Kn2dS1mBINIGlcIdjOfi7EIO124KDn24DCFQ0ThVhI2w/NEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJbCRN6sScnbqk+oNSyae/6Of5fLI5RyGARu8TFCdrg=;
 b=JgjJr+W0OIZhFayN5vtBGNrK5dkLSpqp/YeQrDA1L8KJaEMq4aiJFEFZ/EPUMu40VSP2TmyEZDPwhaUD6OKkkX4eqHcx9he8AHh54+hHmlFffcj8ZFcWuzCrAwjie9WM6tPQ46RDa6DICiiV8mdTLylsXMDzFIkx3URbrUM7NGgtJjSR+APeVFd/kGabVuaeUYVSxFM9DaZSC4vMW1NbymERpGt1GYLF12MEiiSMYOt84qMufM4BC0dgPphnuxBQeT/IUz5vTOeW6xMDK3/K2RDuZ30NwO0TPz7PNeYPn4p13izgDkxXphhcgOTwS6PsMV5UXKCX8pUGHzFt3wdVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJbCRN6sScnbqk+oNSyae/6Of5fLI5RyGARu8TFCdrg=;
 b=uENPCszrJjPKGM8rC2cDBe9UIkcmdPHIE59w/RLkK8Ei9DmSPX4CNKZrb9sDscRQf4opH+5rR0TJOWJq+7JSjU7iQiw1jnesC0y30FGFCv6GRjjn8oA9/Pa8Ydb7KTlegHWA74UO8THXgCbp0uZQ8+sd+q84uNZ7jOtgKnTScmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 22:39:53 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.8182.014; Wed, 20 Nov 2024
 22:39:52 +0000
Message-ID: <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
Date: Wed, 20 Nov 2024 16:39:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20241111193323.278768-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241111193323.278768-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0175.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::21) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6324399b-a53a-4652-330b-08dd09b43fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUUvQTQ4RDIzdEcxVmR2NFpMRWRyQWxhVStpNFF0cm9tVjBEemYwVldEYnR1?=
 =?utf-8?B?ZlcwMHJ1UE1Tdmk2bDhhSEk3WVdIZ2tmSGNRVEV1OW9XTW1TZFhzQnBQTUpa?=
 =?utf-8?B?UHN3YjZuVVQ5aFNSSml4ZkNqZVdSMWo3aDZBTHRrS01Lc0pLTGw3VG9za3k2?=
 =?utf-8?B?V3NSNGJwNjBPNDVQQnduWmh5MFNwMlphUnAzN1ZKZjdLWUc1YzNKd2huWUN3?=
 =?utf-8?B?YWtWM2NmbG91ZndINFBGVkI0VlMveXZUb1FrcTlTWEtGcjk0aXJPeDlpNXBF?=
 =?utf-8?B?UWpzbWpRR3htc1pMcWRxSUVnc3RCY3gzVWJIRmNVSVJSRUNKc3I4SkpsdUxm?=
 =?utf-8?B?aTQwY1pXYU5hM0JTVTVMQkZYVS9pa3NQWFFISTNEZHhvZnAyUS9YYzR6UDFQ?=
 =?utf-8?B?bkYzaVUzL2JuQzhWUGtrRXplVWdTQmRkRGxGaTFkS0tXZTZZV3hNem85eUp5?=
 =?utf-8?B?VzJJTmVLWGZqYlhIYmNnU0xXT2c5dGpUZWM5Sk90VnJGWEF3MmFEbkVKVXA5?=
 =?utf-8?B?YklyZ0orM1I1dUJQcEVsSVdaN2lwSHdCMFZMUXFhbzgzdWJSV0o1R2lOc0Nj?=
 =?utf-8?B?emRrWXhUcnR2STVEMndscDNXNkVIYzQvem83NERPUm5OVExmN045Qk5wRUxM?=
 =?utf-8?B?Sld3aVdpMXBvSlhpZXZkWi9SSS9JYkFtT2JOZU42bFB2ci9ZZGxVL2oyV0pV?=
 =?utf-8?B?Q1VXZ3drK0gvOTJUUmZ4UE9Ea2dwNGhPc3FYdk9TTEd2WnpzVlZMVmlFYXVW?=
 =?utf-8?B?TXZWZmpGaTZzWk1mWGZueG5mNmYxQlhvWFI2VGt6R3pTSFpoNmNrWWNPLzd4?=
 =?utf-8?B?enpHY1hPMlJIU3Q0ckljYlprb3FCb04rYjQxbW4vc2lDdzZUUm4vSEZLVkp0?=
 =?utf-8?B?NGxrdmxmYnYrVnNOdUYrUTFGRW1UU0tYWWxSdUFkTzlKbEYvY0JlaG5lZ3Ax?=
 =?utf-8?B?SWxVYjR4UTM2ZlUreGdXalkxTUZhazZ4Y0dSUnFFWmN1QnhIZnl0OW5YNEhY?=
 =?utf-8?B?dXpja2ZQMzRUaDg4Smw0VHFwanJYY0UyRXM5RXZ2VWdFYzNLRXdEd1Y0TVZa?=
 =?utf-8?B?SHZPeGNJR2dVU0x5UmliK25rOE1pRVdzRXNsc0hES1J4SGQvdW1hdExtTGMw?=
 =?utf-8?B?cHpwdStjMXJZYkw4cExjU3RWUmtvbERJaWZscFByOW9yQmhQSWY2WHJUT1p0?=
 =?utf-8?B?cWxGN0svVXVpTzBEUy9XbFk2aGIycVdiYkFXYXpNaXBxSW5sdXhqQW0xVkkw?=
 =?utf-8?B?UmEySUNGdXhPN3NRZUExWUNjK3l4RXBhd0tFeXBjWWZ5S1grNmhMbVJQbmNT?=
 =?utf-8?B?blZFUi8xU2tuRzlSSUNDWHEwT1ZadnFYcFJIM1VPTFNZRjdXUUpPQjFYQTBO?=
 =?utf-8?B?YUtyUFJZOXB0Tm9Uc0VSYjJPMlRzQmVPSk94alY1b1BRRDBMRldqRDdYRlpu?=
 =?utf-8?B?cnVlNVAxTjhkQjBnZXJROUNOZzBvZktwWXQ5c0RFbk9OU21LS2NDYmhEdkVY?=
 =?utf-8?B?bkZZUXBBdDVWNGtzRVNoQU9nMFVhdUVVWStLa1ZhdlNhT01kNlZURks5ZWt4?=
 =?utf-8?B?QUpmcVBzQjk3dTJEUWdMQXpmVnd5Ykl6Mi9mM0xrNXNoSjRLaXA2USt3UVk5?=
 =?utf-8?B?UnF6clo1ZmpjQzM4R2dIN3N4cm1YMnUrNXJLL3Q4cWdNTnIrNEkrN3h3NHE5?=
 =?utf-8?B?SXFJK2pCNER4Z1FNamxWa1NmZndBYU83R0FTN3NTK01YK1IxWWlIVHhyZ1hO?=
 =?utf-8?Q?IJ4zqNPk6avqKiuTeUX2N/A4jYeq1nr+mBrcHEo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0RDNEtBK2FTUkF1czNJaUN2ZldZR05ydGZVMmYvUTllZ2FvSzlpb0FBb0U5?=
 =?utf-8?B?NVZ4SEVZQU9zaWtHWlZSbU1wNmdXUndQVW93bDJzbGRpSGJSbjBNK2F5M2pL?=
 =?utf-8?B?aHdSNG1SYWpaTXV0aXVtNVBRVWRUSzg2VlNyVW14MnV0UXhta2JjMWhDWVJ3?=
 =?utf-8?B?N29DZUtuOHQxakJnczhjNmdXM2lJR3BDaVZKdHVZY3pMNDZkVkxLdmpsYXRK?=
 =?utf-8?B?KzN4MHZPaktyeVpoRzRHWHE4WWVTUEM0bVIwVTZQM1g0UVdZN2QvYnR1b0tz?=
 =?utf-8?B?Q2hhTHkxQmhuQUdzZ2E2WnFUclJrMm5yQmRSUitZZzh0T3piRXZ1SDNMUWds?=
 =?utf-8?B?UnQ3Q21xNFRSaENRQzc0MFZZZW0wNnVIWVRIVnB6NUFocWwvcnA3UmU3UTZh?=
 =?utf-8?B?Q3VBY2lWNllXOWtRNlN1ZUVKQUZYZFVUY1hmYnZaZnJFdWtzRmt4L3pTSUVY?=
 =?utf-8?B?QVlIbC8rU2FKY1YxYWt2VElmaUsvRXF2VTIwV1VUVFlqNk5oVVY2a2M2QktJ?=
 =?utf-8?B?NDBRSUF3VlE4YzNEZWJlV2ZrRjJselE4S1IwbGlYVTNFdHc2b1BLc2d4K1pD?=
 =?utf-8?B?d0ptK3lSY1JhUVVJQjlkTDVMcWozY0RDRWFQVXh0VmE5OERBcFBia1kzWE1X?=
 =?utf-8?B?aXVZNkRZUEthak9BSkpxYmttQVVhYTBqMVpSUUVuTXFhSFVpL0J4VnVhaHdF?=
 =?utf-8?B?ZytLWnpZK0ZRQzBaYUxmbmYxSDVqWmFURDlBTFd5U0FnUVhtTWNyaXhqMHpw?=
 =?utf-8?B?L3AwbW4zeGJjVy9aVWFvdnVHeTJUSlNiaWlaUElpQlB2akx2YmhIS3ZrSSsx?=
 =?utf-8?B?bStNVWlwUFdlWVJndFhPQXJKRzNpaWduUGpjWHFMYTRGWjByYzhFTTRuWGdG?=
 =?utf-8?B?cE5zQU5MMElJWlJ6clVhd2tZbDNOYldHTHhkMzc3aU1wWlBCWS95L0pCbmtE?=
 =?utf-8?B?VHdBNVNSTmpoYzNDcHdwY2dKZUFwcXhpUUgydlhGUHlwQWU2RDRsVFFOdWFQ?=
 =?utf-8?B?OUgzK0R1U2JialozdjB3TlY0OXFtQzNmRU9uL3RqWm84NUVRRUdINVYzd1Bk?=
 =?utf-8?B?MFdaUklyTm9vS0tiQjRoV0JOZnRNUUI5OTNBL3JGN3lhMWptajdFMURGVTNQ?=
 =?utf-8?B?TXdFQlc5YWJNd29qZ2s3N0ErZFNadHU2VGpkaTIvZ0pqWFk5RGlsOC9yV0hx?=
 =?utf-8?B?UXF1SWs0aDhxMGVTRHFCOGVPeFRrV0xqalNuMGMxQldEOHIzYU9jckpTTFFR?=
 =?utf-8?B?Mk5rRVV3eGxjaVQ1TlRINXc2cmV1T1JmUW5uZlpQTnZTc3R3Y2FKcXJVUG5Z?=
 =?utf-8?B?TWxZZTFmYk1yZ1NsTzFSMjU5RWltNHJnYVFsQVArSXNKU2t6TmxERVRzSzhT?=
 =?utf-8?B?eXJFY1RUdnVnNUhwQXEzdVphdEVGOXlxQ2RTVHBNQUxPb2Z4VWJZbVN0VER3?=
 =?utf-8?B?OXRJMDN1OCtRT052S3AzRXVDeHVHaW9xZ0ltaE1Ea3Job2pDUUxtRVBxNTl0?=
 =?utf-8?B?U0k4WnlVQTVRV09hNGVpUmQvTmh4YldnR3hUZnFiaWtRQkxYc0hNaXJJNUR0?=
 =?utf-8?B?RXQ0S1IxTHVNeUhHaVZncmc0T3diYWFTK1kyZlJOWkRxMEpGb0RxMnhrVzRp?=
 =?utf-8?B?bUlOWm1LakpBRGVoY0FBMHNnazJhQmhzZWd0SEVjWXhVYkZHVEYyZCt4Y05W?=
 =?utf-8?B?Y0N6TzI3M05HZlJlbVhqQnJkcGw3T2NNNm1ndWlHdkk1MldlWmtTdW1lTzhJ?=
 =?utf-8?B?ZjBVMUtYRXB0Q1FmVXBHZG0zeWQ4cStPZWlnMkkxVGhXMVpjNE5iRWNTS090?=
 =?utf-8?B?RVgwbDZreWVYdnFxL3dXeURsNnNmSHExQ1lsdkJYQ0FHUHRmTHlQbDMySTBE?=
 =?utf-8?B?Vmg4K21XMjc4UDM0WHNTdk5keGZMT0d2N0U5ajR1SmwyaWwzYUN4Rkw2eW9T?=
 =?utf-8?B?aktCYUFsUmhLL1RYY2pSNTBmUFJScXVPUXFqSkEzQktNYXdjdVRscW9hL25P?=
 =?utf-8?B?MEl2Q3Z2MFQ3S2MyV3p2TndFZ1d1Y1FDNitSV2s1cjdnYS9mSTlvMjNsK2I1?=
 =?utf-8?B?ZjM1ZEVxbXpsL3pyc3QraVNCcUZ5S1Y1M3dia0pRN3dMUEJiZHE4blNlWWJO?=
 =?utf-8?Q?qPXozysQy6VzknzLzrmJaayjR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6324399b-a53a-4652-330b-08dd09b43fb7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 22:39:52.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFtkE3sBh5Ht12y+Sgb8MovjHm+7N2aJsTB/bDRl5j91ojnHysHU6LhuFTxlZfbFbeVikr0clLS/J8rFr5ofbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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



On 2024-11-11 13:33, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
> 
> Current kfd driver has its own PASID value for a kfd process and uses it to
> locate vm at interrupt handler or mapping between kfd process and vm. That
> design is not working when a physical gpu device has multiple spatial
> partitions, ex: adev in CPX mode. This patch has kfd driver use same pasid
> values that graphic driver generated which is per vm per pasid.
> 
> These pasid values are passed to fw/hardware. We do not need change interrupt
> handler though more pasid values are used. Also, pasid values at log are
> replaced by user process pid, or pasid values are not exposed to user, user
> will see their process pids that have meaning in user space.
> 
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 +++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 25 +++----
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  8 +--
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 52 +++++++-------
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       | 17 ++---
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 +-
>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 71 ++++++++-----------
>  .../amd/amdkfd/kfd_process_queue_manager.c    | 10 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 17 +++--
>  12 files changed, 127 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4b80ad860639..e576f65979a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>  };
>  
>  struct amdgpu_device;
> +struct kfd_process_device;
>  struct amdgpu_reset_context;
>  
>  enum kfd_mem_attachment_type {
> @@ -300,7 +301,8 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
>  		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>  
>  int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid);
> +				     struct kfd_process_device *pdd,
> +				     struct amdgpu_vm *avm);
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					struct amdgpu_vm *avm,
>  					void **process_info,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f30548f4c3b3..f63c6b185bbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1530,24 +1530,30 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>  }
>  
>  int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid)
> +				     struct kfd_process_device *pdd,
> +				     struct amdgpu_vm *avm)

I'd prefer if this function got renamed to amdgpu_amdkfd_gpuvm_get_pasid and it returns the pasid.

>  
>  {
> -	int ret;
> -
> -	/* Free the original amdgpu allocated pasid,
> -	 * will be replaced with kfd allocated pasid.
> -	 */
> -	if (avm->pasid) {
> -		amdgpu_pasid_free(avm->pasid);
> -		amdgpu_vm_set_pasid(adev, avm, 0);
> +	int ret = 0;
> +	int pasid;
> +
> +	/* if avm has pasid assigned use it */
> +	if (avm->pasid)
> +		pdd->pasid = avm->pasid;
> +	else {
> +		/* otherwise generate a new pasid and assign to avm */

Does this ever happen? I think any avm that was acquired properly should already have a PASID. If it doesn't, maybe we can just return an error.

> +		pasid = amdgpu_pasid_alloc(16);
> +		if (pasid < 0) {
> +			dev_warn(adev->dev, "No more PASIDs available!");
> +			ret = -ENOMEM;
> +		} else
> +			ret = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, avm,
> +						  GFP_KERNEL));
> +		if (ret >= 0)
> +			avm->pasid = pasid;
>  	}
>  
> -	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..8b1fd8e7452b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -155,8 +155,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
>  	/* filep now owns the reference returned by kfd_create_process */
>  	filep->private_data = process;
>  
> -	dev_dbg(kfd_device, "process %d opened, compat mode (32 bit) - %d\n",
> -		process->pasid, process->is_32bit_user_mode);
> +	dev_dbg(kfd_device, "process pid %d opened kfd node, compat mode (32 bit) - %d\n",
> +		(int)process->lead_thread->pid, process->is_32bit_user_mode);
>  
>  	return 0;
>  }
> @@ -361,8 +361,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>  		goto err_acquire_queue_buf;
>  	}
>  
> -	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
> -			p->pasid,
> +	pr_debug("Creating queue for process pid 0x%x on gpu 0x%x\n",
> +			(int)p->lead_thread->pid,
>  			dev->id);
>  
>  	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
> @@ -415,9 +415,9 @@ static int kfd_ioctl_destroy_queue(struct file *filp, struct kfd_process *p,
>  	int retval;
>  	struct kfd_ioctl_destroy_queue_args *args = data;
>  
> -	pr_debug("Destroying queue id %d for pasid 0x%x\n",
> +	pr_debug("Destroying queue id %d for process pid 0x%x\n",
>  				args->queue_id,
> -				p->pasid);
> +				(int)p->lead_thread->pid);
>  
>  	mutex_lock(&p->mutex);
>  
> @@ -468,8 +468,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>  	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
>  	properties.priority = args->queue_priority;
>  
> -	pr_debug("Updating queue id %d for pasid 0x%x\n",
> -			args->queue_id, p->pasid);
> +	pr_debug("Updating queue id %d for process pid 0x%x\n",
> +			args->queue_id, (int)p->lead_thread->pid);
>  
>  	mutex_lock(&p->mutex);
>  
> @@ -695,7 +695,7 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
>  	struct kfd_process_device_apertures *pAperture;
>  	int i;
>  
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x", (int)p->lead_thread->pid);
>  
>  	args->num_of_nodes = 0;
>  
> @@ -747,7 +747,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
>  	int ret;
>  	int i;
>  
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x",
> +			(int)p->lead_thread->pid);
>  
>  	if (args->num_of_nodes == 0) {
>  		/* Return number of nodes, so that user space can alloacate
> @@ -3365,12 +3366,12 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>  
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
> -	pr_debug("pasid 0x%x mapping mmio page\n"
> +	pr_debug("process pid 0x%x mapping mmio page\n"
>  		 "     target user address == 0x%08llX\n"
>  		 "     physical address    == 0x%08llX\n"
>  		 "     vm_flags            == 0x%04lX\n"
>  		 "     size                == 0x%04lX\n",
> -		 process->pasid, (unsigned long long) vma->vm_start,
> +		 (int)process->lead_thread->pid, (unsigned long long) vma->vm_start,
>  		 address, vma->vm_flags, PAGE_SIZE);
>  
>  	return io_remap_pfn_range(vma,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 312dfa84f29f..93ba497042b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -238,8 +238,8 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>  
>  			mutex_unlock(&p->mutex);
>  		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
> -			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
> -			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
> +			kfd_signal_vm_fault_event(dev, pasid, NULL,
>  							exception_data);
>  
>  			signaled_to_debugger_or_runtime = true;
> @@ -276,8 +276,8 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>  		data = (struct kfd_hsa_memory_exception_data *)
>  						pdd->vm_fault_exc_data;
>  
> -		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
> -		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
> +		kfd_dqm_evict_pasid(pdd->dev->dqm, pdd->pasid);

kfd_dqm_evict_pasid just goes and looks up the pdd from the pasid again. Maybe this could be streamlined with a kfd_dqm_evict_pdd that avoids the unnecessary lookup. Could be a follow-up patch.


> +		kfd_signal_vm_fault_event(pdd->dev, pdd->pasid, NULL, data);

Similarly, this function looks up the process from the PASID. Maybe this could be refactored to avoid the redundant lookup.

>  		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 38c19dc8311d..ca8db5e3a7b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -206,7 +206,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  		return -EIO;
>  
>  	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> -	queue_input.process_id = qpd->pqm->process->pasid;
> +	queue_input.process_id = pdd->pasid;
>  	queue_input.page_table_base_addr =  qpd->page_table_base;
>  	queue_input.process_va_start = 0;
>  	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
> @@ -496,6 +496,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>  			struct qcm_process_device *qpd,
>  			struct queue *q)
>  {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>  	struct device *dev = dqm->dev->adev->dev;
>  	int allocated_vmid = -1, i;
>  
> @@ -514,9 +515,9 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>  
>  	pr_debug("vmid allocated: %d\n", allocated_vmid);
>  
> -	dqm->vmid_pasid[allocated_vmid] = q->process->pasid;
> +	dqm->vmid_pasid[allocated_vmid] = pdd->pasid;
>  
> -	set_pasid_vmid_mapping(dqm, q->process->pasid, allocated_vmid);
> +	set_pasid_vmid_mapping(dqm, pdd->pasid, allocated_vmid);
>  
>  	qpd->vmid = allocated_vmid;
>  	q->properties.vmid = allocated_vmid;
> @@ -768,6 +769,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* taking the VMID for that process on the safe way using PDD */
> +	pdd = kfd_get_process_device_data(dev, p);
> +	if (!pdd)
> +		return -EFAULT;
> +
>  	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>  	 * ATC_VMID15_PASID_MAPPING
>  	 * to check which VMID the current process is mapped to.
> @@ -777,23 +783,19 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>  		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
>  				(dev->adev, vmid, &queried_pasid);
>  
> -		if (status && queried_pasid == p->pasid) {
> -			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> -					vmid, p->pasid);
> +		if (status && queried_pasid == pdd->pasid) {
> +			pr_debug("Killing wave fronts of vmid %d and process pid 0x%x\n",
> +				 vmid, p->lead_thread->pid);
>  			break;
>  		}
>  	}
>  
>  	if (vmid > last_vmid_to_scan) {
> -		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
> +		dev_err(dev->adev->dev, "Didn't find vmid for process pid 0x%x\n",
> +			p->lead_thread->pid);
>  		return -EFAULT;
>  	}
>  
> -	/* taking the VMID for that process on the safe way using PDD */
> -	pdd = kfd_get_process_device_data(dev, p);
> -	if (!pdd)
> -		return -EFAULT;
> -
>  	reg_gfx_index.bits.sh_broadcast_writes = 1;
>  	reg_gfx_index.bits.se_broadcast_writes = 1;
>  	reg_gfx_index.bits.instance_broadcast_writes = 1;
> @@ -1029,8 +1031,8 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>  	if (q->properties.is_suspended)
>  		return 0;
>  
> -	pr_debug("Suspending PASID %u queue [%i]\n",
> -			pdd->process->pasid,
> +	pr_debug("Suspending process pid %u queue [%i]\n",
> +			pdd->process->lead_thread->pid,
>  			q->properties.queue_id);
>  
>  	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
> @@ -1077,8 +1079,8 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>  
>  	pdd = qpd_to_pdd(qpd);
>  
> -	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
> -			    pdd->process->pasid,
> +	pr_debug("Restoring from suspend process pid %u queue [%i]\n",
> +			    pdd->process->lead_thread->pid,
>  			    q->properties.queue_id);
>  
>  	q->properties.is_suspended = false;
> @@ -1111,8 +1113,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
>  
>  	pdd = qpd_to_pdd(qpd);
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>  
>  	pdd->last_evict_timestamp = get_jiffies_64();
>  	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -1169,8 +1171,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  	if (!pdd->drm_priv)
>  		goto out;
>  
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>  
>  	/* Mark all queues as evicted. Deactivate all active queues on
>  	 * the qpd.
> @@ -1228,8 +1230,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
>  	}
>  
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>  
>  	/* Update PD Base in QPD */
>  	qpd->page_table_base = pd_base;
> @@ -1312,8 +1314,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>  	if (!pdd->drm_priv)
>  		goto vm_not_acquired;
>  
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			     pdd->process->lead_thread->pid);
>  
>  	/* Update PD Base in QPD */
>  	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
> @@ -2102,7 +2104,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>  	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>  
>  	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid 0x%0x is reset\n",
> -		q->properties.queue_id, q->process->pasid);
> +		q->properties.queue_id, pdd->process->lead_thread->pid);
>  
>  	pdd->has_reset_queue = true;
>  	if (q->properties.is_active) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ea3792249209..a38c0b3b88fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1128,8 +1128,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>  
>  	if (type == KFD_EVENT_TYPE_MEMORY) {
>  		dev_warn(kfd_device,
> -			"Sending SIGSEGV to process %d (pasid 0x%x)",
> -				p->lead_thread->pid, p->pasid);
> +			"Sending SIGSEGV to process pid %d",
> +				p->lead_thread->pid);
>  		send_sig(SIGSEGV, p->lead_thread, 0);
>  	}
>  
> @@ -1137,13 +1137,13 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>  	if (send_signal) {
>  		if (send_sigterm) {
>  			dev_warn(kfd_device,
> -				"Sending SIGTERM to process %d (pasid 0x%x)",
> -					p->lead_thread->pid, p->pasid);
> +				"Sending SIGTERM to process pid %d",
> +					p->lead_thread->pid);
>  			send_sig(SIGTERM, p->lead_thread, 0);
>  		} else {
>  			dev_err(kfd_device,
> -				"Process %d (pasid 0x%x) got unhandled exception",
> -				p->lead_thread->pid, p->pasid);
> +				"Process pid %d got unhandled exception",
> +				p->lead_thread->pid);
>  		}
>  	}
>  
> @@ -1253,7 +1253,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>  		}
>  
>  		if (unlikely(!pdd)) {
> -			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
> +			WARN_ONCE(1, "Could not get device data from process pid:0x%x\n",
> +				  p->lead_thread->pid);
>  			continue;
>  		}
>  
> @@ -1263,7 +1264,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>  		if (dev->dqm->detect_hang_count) {
>  			struct amdgpu_task_info *ti;
>  
> -			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			ti = amdgpu_vm_get_task_info_pasid(dev->adev, pdd->pasid);

Can we use amdgpu_vm_get_task_info_vm here to avoid a redundant lookup of the VM from the pasid? You'd need a helper to get the vm from pdd->drm_priv (drm_priv_to_vm in amdgpu_amdkfd.h).

>  			if (ti) {
>  				dev_err(dev->adev->dev,
>  					"Queues reset on process %s tid %d thread %s pid %d\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 1f9f5bfeaf86..d56525201155 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -47,7 +47,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>  		packet->bitfields2.exec_cleaner_shader = 1;
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>  	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>  	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>  	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>  	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> @@ -106,7 +106,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>  		packet->bitfields2.exec_cleaner_shader = 1;
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>  	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>  	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>  	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>  	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index c1199d06d131..347c86e1c378 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -42,6 +42,7 @@ unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
>  static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>  				struct qcm_process_device *qpd)
>  {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>  	struct pm4_mes_map_process *packet;
>  
>  	packet = (struct pm4_mes_map_process *)buffer;
> @@ -52,7 +53,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>  					sizeof(struct pm4_mes_map_process));
>  	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>  	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>  	packet->bitfields3.page_table_base = qpd->page_table_base;
>  	packet->bitfields10.gds_size = qpd->gds_size;
>  	packet->bitfields10.num_gws = qpd->num_gws;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9e5ca0b93b2a..08bcbc45197c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -849,6 +849,8 @@ struct kfd_process_device {
>  
>  	/* Tracks queue reset status */
>  	bool has_reset_queue;
> +
> +	u32 pasid;
>  };
>  
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -908,8 +910,6 @@ struct kfd_process {
>  	/* We want to receive a notification when the mm_struct is destroyed */
>  	struct mmu_notifier mmu_notifier;
>  
> -	u32 pasid;
> -
>  	/*
>  	 * Array of kfd_process_device pointers,
>  	 * one for each device the process is using.
> @@ -970,7 +970,6 @@ struct kfd_process {
>  	/* Kobj for our procfs */
>  	struct kobject *kobj;
>  	struct kobject *kobj_queues;
> -	struct attribute attr_pasid;
>  
>  	/* Keep track cwsr init */
>  	bool has_cwsr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 6bab6fc6a35d..edc4f47061f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -282,8 +282,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>  	cu_cnt = 0;
>  	proc = pdd->process;
>  	if (pdd->qpd.queue_count == 0) {
> -		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
> -			 dev->id, proc->pasid);
> +		pr_debug("Gpu-Id: %d has no active queues for process pid %d\n",
> +			 dev->id, (int)proc->lead_thread->pid);
>  		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
>  	}
>  
> @@ -327,12 +327,7 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>  static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>  			       char *buffer)
>  {
> -	if (strcmp(attr->name, "pasid") == 0) {
> -		struct kfd_process *p = container_of(attr, struct kfd_process,
> -						     attr_pasid);
> -
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
> -	} else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strncmp(attr->name, "vram_", 5) == 0) {
>  		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>  							      attr_vram);
>  		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -887,9 +882,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>  			goto out;
>  		}
>  
> -		kfd_sysfs_create_file(process->kobj, &process->attr_pasid,
> -				      "pasid");
> -
>  		process->kobj_queues = kobject_create_and_add("queues",
>  							process->kobj);
>  		if (!process->kobj_queues)
> @@ -1055,8 +1047,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>  	for (i = 0; i < p->n_pdds; i++) {
>  		struct kfd_process_device *pdd = p->pdds[i];
>  
> -		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
> -				pdd->dev->id, p->pasid);
> +		pr_debug("Releasing pdd (topology id %d, for pid 0x%0x)\n",
> +			 pdd->dev->id, (int)p->lead_thread->pid);
>  
>  		kfd_process_device_destroy_cwsr_dgpu(pdd);
>  		kfd_process_device_destroy_ib_mem(pdd);
> @@ -1102,7 +1094,6 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>  	if (!p->kobj)
>  		return;
>  
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
>  	kobject_del(p->kobj_queues);
>  	kobject_put(p->kobj_queues);
>  	p->kobj_queues = NULL;
> @@ -1171,7 +1162,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>  
>  	kfd_event_free_process(p);
>  
> -	kfd_pasid_free(p->pasid);
>  	mutex_destroy(&p->mutex);
>  
>  	put_task_struct(p->lead_thread);
> @@ -1524,12 +1514,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>  	atomic_set(&process->debugged_process_count, 0);
>  	sema_init(&process->runtime_enable_sema, 0);
>  
> -	process->pasid = kfd_pasid_alloc();
> -	if (process->pasid == 0) {
> -		err = -ENOSPC;
> -		goto err_alloc_pasid;
> -	}
> -
>  	err = pqm_init(&process->pqm, process);
>  	if (err != 0)
>  		goto err_process_pqm_init;
> @@ -1583,8 +1567,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>  err_init_apertures:
>  	pqm_uninit(&process->pqm);
>  err_process_pqm_init:
> -	kfd_pasid_free(process->pasid);
> -err_alloc_pasid:
>  	kfd_event_free_process(process);
>  err_event_init:
>  	mutex_destroy(&process->mutex);
> @@ -1723,7 +1705,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>  	if (ret)
>  		goto err_init_cwsr;
>  
> -	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
> +	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, pdd, avm);
>  	if (ret)
>  		goto err_set_pasid;
>  
> @@ -1822,15 +1804,20 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>  {
>  	struct kfd_process *p, *ret_p = NULL;
>  	unsigned int temp;
> +	int i;
>  
>  	int idx = srcu_read_lock(&kfd_processes_srcu);
>  
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		if (p->pasid == pasid) {
> -			kref_get(&p->ref);
> -			ret_p = p;
> -			break;
> +		for (i = 0; i < p->n_pdds; i++) {
> +			if (p->pdds[i]->pasid == pasid) {
> +				kref_get(&p->ref);
> +				ret_p = p;
> +				break;
> +			}

I think this won't work correctly. The same PASID can be used for different processes on different GPUs because each adev manages its own PASID->amdgpu_vm lookup table. So kfd_lookup_process_by_pasid needs a new parameter that identifies the GPU adev, and you should only compare pasids, if the adev matches.

Regards,
  Felix

>  		}
> +		if (ret_p)
> +			break;
>  	}
>  
>  	srcu_read_unlock(&kfd_processes_srcu, idx);
> @@ -1991,7 +1978,7 @@ static void evict_process_worker(struct work_struct *work)
>  	 */
>  	p = container_of(dwork, struct kfd_process, eviction_work);
>  
> -	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> +	pr_debug("Started evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>  	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>  	if (!ret) {
>  		/* If another thread already signaled the eviction fence,
> @@ -2003,9 +1990,9 @@ static void evict_process_worker(struct work_struct *work)
>  				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>  			kfd_process_restore_queues(p);
>  
> -		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>  	} else
> -		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to evict queues of process pid 0x%x\n", (int)p->lead_thread->pid);
>  }
>  
>  static int restore_process_helper(struct kfd_process *p)
> @@ -2022,9 +2009,11 @@ static int restore_process_helper(struct kfd_process *p)
>  
>  	ret = kfd_process_restore_queues(p);
>  	if (!ret)
> -		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished restoring process pid 0x%x\n",
> +			 (int)p->lead_thread->pid);
>  	else
> -		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to restore queues of process pid 0x%x\n",
> +			(int)p->lead_thread->pid);
>  
>  	return ret;
>  }
> @@ -2041,7 +2030,7 @@ static void restore_process_worker(struct work_struct *work)
>  	 * lifetime of this thread, kfd_process p will be valid
>  	 */
>  	p = container_of(dwork, struct kfd_process, restore_work);
> -	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
> +	pr_debug("Started restoring process pasid 0x%x\n", (int)p->lead_thread->pid);
>  
>  	/* Setting last_restore_timestamp before successful restoration.
>  	 * Otherwise this would have to be set by KGD (restore_process_bos)
> @@ -2057,8 +2046,8 @@ static void restore_process_worker(struct work_struct *work)
>  
>  	ret = restore_process_helper(p);
>  	if (ret) {
> -		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
> -			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
> +		pr_debug("Failed to restore BOs of process pid 0x%x, retry after %d ms\n",
> +			 (int)p->lead_thread->pid, PROCESS_BACK_OFF_TIME_MS);
>  		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
>  				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>  			kfd_process_restore_queues(p);
> @@ -2074,7 +2063,7 @@ void kfd_suspend_all_processes(void)
>  	WARN(debug_evictions, "Evicting all processes");
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>  		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
> -			pr_err("Failed to suspend process 0x%x\n", p->pasid);
> +			pr_err("Failed to suspend process pid 0x%x\n", (int)p->lead_thread->pid);
>  		signal_eviction_fence(p);
>  	}
>  	srcu_read_unlock(&kfd_processes_srcu, idx);
> @@ -2088,8 +2077,8 @@ int kfd_resume_all_processes(void)
>  
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>  		if (restore_process_helper(p)) {
> -			pr_err("Restore process %d failed during resume\n",
> -			       p->pasid);
> +			pr_err("Restore process pid %d failed during resume\n",
> +			       (int)p->lead_thread->pid);
>  			ret = -EFAULT;
>  		}
>  	}
> @@ -2144,7 +2133,7 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>  	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>  	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
>  							KFD_IRQ_FENCE_CLIENTID;
> -	irq_drain_fence[3] = pdd->process->pasid;
> +	irq_drain_fence[3] = pdd->pasid;
>  
>  	/*
>  	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
> @@ -2296,7 +2285,7 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
>  
>  	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>  		seq_printf(m, "Process %d PASID 0x%x:\n",
> -			   p->lead_thread->tgid, p->pasid);
> +			   p->lead_thread->tgid, (int)p->lead_thread->pid);
>  
>  		mutex_lock(&p->mutex);
>  		r = pqm_debugfs_mqds(m, &p->pqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..1f98c16e0fe9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -69,8 +69,8 @@ static int find_available_queue_slot(struct process_queue_manager *pqm,
>  	pr_debug("The new slot id %lu\n", found);
>  
>  	if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
> -		pr_info("Cannot open more queues for process with pasid 0x%x\n",
> -				pqm->process->pasid);
> +		pr_info("Cannot open more queues for process with pid 0x%x\n",
> +			pqm->process->lead_thread->pid);
>  		return -ENOMEM;
>  	}
>  
> @@ -425,8 +425,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	}
>  
>  	if (retval != 0) {
> -		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
> -			pqm->process->pasid, type, retval);
> +		pr_err("process pid 0x%x DQM create queue type %d failed. ret %d\n",
> +			pqm->process->lead_thread->pid, type, retval);
>  		goto err_create_queue;
>  	}
>  
> @@ -520,7 +520,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>  		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>  		if (retval) {
>  			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
> -				pqm->process->pasid,
> +				pdd->pasid,
>  				pqn->q->properties.queue_id, retval);
>  			if (retval != -ETIME)
>  				goto err_destroy_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3e2911895c74..4910cfcaff36 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -563,7 +563,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>  	int r;
>  
>  	p = container_of(prange->svms, struct kfd_process, svms);
> -	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
> +	pr_debug("process pid: %x svms 0x%p [0x%lx 0x%lx]\n",
> +		 (int)p->lead_thread->pid, prange->svms,
>  		 prange->start, prange->last);
>  
>  	if (svm_range_validate_svm_bo(node, prange))
> @@ -3232,7 +3233,8 @@ void svm_range_list_fini(struct kfd_process *p)
>  	struct svm_range *prange;
>  	struct svm_range *next;
>  
> -	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p\n", (int)p->lead_thread->pid,
> +		 &p->svms);
>  
>  	cancel_delayed_work_sync(&p->svms.restore_work);
>  
> @@ -3255,7 +3257,8 @@ void svm_range_list_fini(struct kfd_process *p)
>  
>  	mutex_destroy(&p->svms.lock);
>  
> -	pr_debug("pasid 0x%x svms 0x%p done\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p done\n",
> +		(int)p->lead_thread->pid, &p->svms);
>  }
>  
>  int svm_range_list_init(struct kfd_process *p)
> @@ -3618,8 +3621,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  	bool flush_tlb;
>  	int r, ret = 0;
>  
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> -		 p->pasid, &p->svms, start, start + size - 1, size);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, size);
>  
>  	r = svm_range_check_attr(p, nattr, attrs);
>  	if (r)
> @@ -3727,8 +3730,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>  out:
>  	mutex_unlock(&process_info->lock);
>  
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
> -		 &p->svms, start, start + size - 1, r);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n",
> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, r);
>  
>  	return ret ? ret : r;
>  }
