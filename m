Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7E4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 20:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F05210EB42;
	Fri, 11 Feb 2022 20:07:00 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D18C10EB42
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 20:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7FAMIwL8t5zyBgdsyE+zHkLGC2soWW5CyIKLd73lChdb5A+z3yWGwPwlFLrl83s4z+7w75Ir+9JzxgoBh4S/XmYb2oR/Dhft+WY5NhZZgptNMZ0UrEgMlJwVTmWNvueUAQdFKppPtUJve3z85HSvCyevU3sdtWTxqfw2icHrlr43k/O6vcRBjASBAuv8dJ3vFTLkNgVIT3eYCO9aAWOWeL9FUAWnlO31N9I7lTQtbVNugHXTV0gDnrRTHR8vW88X6htqLkeAnyEbsqhxwZO9naPclY9KC3+fISIR0QmBhNZ95I1kzDj2PO/826Vw0FSLU22ur9YjIy67AcW0fmIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKVKmo6skdrsDkJDHIzDNUFj+OLho2A3yAIyWNMmKUk=;
 b=ZFY/o6Wtj0paA1VM59pSvGEbOQ+Oo7ZB0GrLf73FN/4gLBsaNY5OXzwV2sdvzbKQh0+MhFKu+hFPNYNkhctn7yIWoIJmxwdTUKY6t61Tkp9eRQXlgnk/DObOik0myMMgYUBhIue2Y33n2si2Z0OxZpPKIs1RX8mqdK2E/bEthzqXR7kgmVaDqVtwEz3BfL2Ztpx7hTpBGREWGNIHfzw67kFfakYd0lbMZJUS6CxWQ3M2vMk54hnnXTBNE0Kb7s3esLe7JYiqj8TEDeWmuOtxkmYRCHCa4lMDDDwkz4OPwCIHZ7IEIU19d9csRsOporKI2OHkjMeEWKmpd1NK/AvpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKVKmo6skdrsDkJDHIzDNUFj+OLho2A3yAIyWNMmKUk=;
 b=liQFRFjgU94StDmPkKQ6DwOa6sfL62+2P9ZKzz2Sxi8BmiS67f7K9pHJHafU4p0GZrzVvOiRM7m5Rz/EFYMofBxmrSVV8pWfAipLBnb0FAZ4EC1B0r1wjW4iYEZCvKh5ftxVznNl4eto52mcDu8oYTLyGCU7U21AZ/vyAxlxBoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3214.namprd12.prod.outlook.com (2603:10b6:208:106::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 20:06:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 20:06:56 +0000
Message-ID: <edcc4ab9-5876-d882-e6bb-edd52bb0bf38@amd.com>
Date: Fri, 11 Feb 2022 15:06:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] General cleanup and SPDX update
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5727f07-3a60-43af-a9a8-08d9ed9a0dd9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3214:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB321432418E6C2B1FB171500492309@MN2PR12MB3214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP/ZENnxsy5fJsk8KYvin+auCdeyntJBnW7QYki786T4uN2EKIwQtY0SGxaub4FOi+VkouWX2WIHOpA8Mh00h+NNZFGMLMwuPZvF4Wk14bax8KGOJLJW07v2xojgNBy/mA+sByrRIQKYPi4GnoF+oIipuu5kqsuZNxTPgxtNXrouEONzKSFsy8kAU6z0h135ukRq1o1QVNfk75Qo9EOVCq44nDy1Vjgcgy2wF9kT02vIPRwLTgeBcBi7VY6qR/xH/e+eHc416ZQ2dSH5xoWD1z1j0V77fv64TLlG04M76LfctUdu7Iz3kr9zOq3Yhez6P1fw3CvucPSCy01ICMaTWzxNX9yyWtEPPqVwi9F6omrHeuaGU0Tnjp8Nch8MO7WjxmSXMOgS87uQIKb9reiAe8uGB7yjhMN5v3RMElBCOkqZT4yFGrPEy23ahbNZARQzeAgHXqeS10S/sRQ0SSuuc/ZPZP8wmyKfQAtofgi9MDcgdAVWq3zG2YsY8a5siShmZA1cC7VklIvKKbvdWT8Sst9LnoAqeZv1F1Xth56NzPZAQAjYQtdiNDvcKxStRZAbZESKkrp8YI7anTL4MTFrM/qs3OQATfzhokpC+LiLKJ7WcjSD1LJIHYR98qqd1Zza7t3+6DzpQMPNoZu8u14Zd9uHMNz2CugJfNuTSBuaSYFfD3b6LdHY/WWgkhHX36p9Xr2/Gjp3TW3xM1su+YjN/EWYUNXCJZI7tC9dv9NWhqfBsW2Yp1Xtz2qGyGkEfN30
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(8676002)(6506007)(26005)(186003)(66556008)(66476007)(6486002)(6512007)(31696002)(2616005)(86362001)(2906002)(316002)(8936002)(38100700002)(508600001)(36756003)(31686004)(44832011)(83380400001)(15650500001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVJUUlvZUIyQm4xRlhwYVhXM1BxU2NJVHh0Mk5aTTBWRXNNcUtreWFsTXBJ?=
 =?utf-8?B?TThKcmhxSm1XSTl5dXVENnp1dlp2RGpLM0dXQm5kVzNWRm8xNmRPWjc3M0Vk?=
 =?utf-8?B?aHpuWE5jYXl5MnlWZTFzeHl3dVVTUkloK3VTVVNpbWlua01Nb1RGcWU2VTlR?=
 =?utf-8?B?T0MvaHd5SXc5YVBXL2hrbWE1YllMVFBDeHdod3k2OWc5cUN5LzFQNGVXNGZr?=
 =?utf-8?B?UWE1RU9yZzVaTDh0akhFVmhtdG1YRCtLZFBiYkx0eVIxUWQ4UHBicVFtcUFR?=
 =?utf-8?B?TFVkZ1I1SEJTWUUrZzV3YTF0UVVXd3p4czNSajVETWlhWTNvcHdqSm5QcVI4?=
 =?utf-8?B?K3RZa2ZmaDhsdTYxTGhFemtFUGVvanphbjI4ZTAreStiSTBMQW5ya2RMUVF3?=
 =?utf-8?B?UGE2MGhyblErOGJzSVNyYXRvTFhmUGlWL0RXZWFnTjJvUVhQWXdpbStVbDlH?=
 =?utf-8?B?d2cxYzdFcWZwa2IxZFB2UnBBdkRJVDdQQ0ZWUXRrOVF2S0xmR3F0YTQ4MnpW?=
 =?utf-8?B?Wm5mYVlGWGJGK2N6TW5QcllsUDBtN1BNbWhWNWV1MC9OaEdLMURmMHlGNjVx?=
 =?utf-8?B?NWNnQ0JXZStxNmxFcHloS1ZkZnE2V2t0TE1VQVE5NW1GRW1KczlORmNiTHN1?=
 =?utf-8?B?amkwek43VUNibXVPUEZpbkd4QzFPZ2VyOGlUZ3cxMlRkNnBrRERHUGozV01i?=
 =?utf-8?B?L3ZsQ3J5Sis2VWlXcGdRMXNISXBxRG40LzkxRHpTVVZsYWxRRkJOZndiSHV4?=
 =?utf-8?B?RkNvTXhJNEhkNVQzK0M2T3M2Sys3bmgyVUF1c2tJY1dtaWYxRjNWQktUTHdQ?=
 =?utf-8?B?OUMwYjVWRTlRUzVCSkZDQkwzb0MxNEc3d25uRThWSGpmRUFMKzJpOGtFb3V3?=
 =?utf-8?B?NUZxZEFPRDFqWmhXVGYyWWYwT1lCQ2VJaWFkbFhGenNHS3c3NTUwZTFXZU13?=
 =?utf-8?B?NkJNTWJzT0VaV3ROdFlTeTRPVXJFYlFVd0U0ejBYbzdObDZnMWs1aklFZlIz?=
 =?utf-8?B?K2RRbXRSZnA4ZUhWb3BHV3dtcHFkQ0htVytJT2ExRUtsdUp5aUh2ZlJDTGtY?=
 =?utf-8?B?RkJzSzNMNzM3NGpWNFNsOTV6Sm05NXJORXJDNk5yU0VSNk1EUHFYcC9XKzg4?=
 =?utf-8?B?K1AzenhsendqaEZRZEFJN0VsREhHY1NCczRWTmI4SDlHRDAwYkwwYi9yZGE0?=
 =?utf-8?B?ZUJYcmxNd3R2SkU3TWs5cUFHaWVYK0RyOFlPODJ0a1gvUDRyLzlINmVJSHlI?=
 =?utf-8?B?cUNncmhjYUk2RTVkMHE0K2tDbmtxLytLc2JiMmRYdERqTDlNdng2WXBDTDMz?=
 =?utf-8?B?M0RxblMxM2ZUQ0E0S2VwTXJqWWF6NVY1QlhxQTFDc1hNU1A2MGtPc2RnakVL?=
 =?utf-8?B?SnRBelZnaExMZ05rYXpobUxJaHJrZ3EwTFVKZHZqQUtZQnFVZzN3Q0taK1hS?=
 =?utf-8?B?VUFiRkRHQ1hNZk1EakV5NCtseCs4OTlSKzdGNDdHckU2SzExZmZwSlRMU2tj?=
 =?utf-8?B?VWdQdGxyeHNvaWE5QVJsdXRpdXE5ZE00Mm5BYkVnT0tTNmpIZjF4MGJ0d3J3?=
 =?utf-8?B?dks0TW8xV3FiVGkvaXFUZ3dzeWhnWTR3V0ZINkxBSjdXRHNhTStPUnptR1Zm?=
 =?utf-8?B?cEZIVU9MYjdKYkgzM2NYNkgvSmd3TGZzMDV2WEYxSEFOWDZSTzZuMjdMRE11?=
 =?utf-8?B?SUEzcmxBK1pjcjhnQjBlc3l6bFFIRWdJQlpuVW9vUUJFaWlHb0ZmNVVwb01H?=
 =?utf-8?B?b3JQNEdPLytBWXE4S3Y1Mjk3NS9uRXNiTy82OVdUK2JiclhDQXlvbE1zOGhy?=
 =?utf-8?B?WUNER2NPK2o0cDNVQ2VKSU5FQW5SWHV0TmUxQ0V3YU1qOVFNMmlmdElpZm9P?=
 =?utf-8?B?eTZqejdFaWo1dk8rczVmZm1wZlpnTjdrbTVOVUttYit4enE4Z3VOK0tIZ3FI?=
 =?utf-8?B?MVNhUmFpc2FjNUU5d1J5Q2Q2NmVHVlFrbWsrOE9CbWh0MlFZWjFSNWg2V3ky?=
 =?utf-8?B?VlViNFIyNWM3elZZbERZbllRUERPMkNVSjFOdHovMkl2TWJzRU9LUW9MOUhn?=
 =?utf-8?B?eHFoQ21lbUNIOHBTcXNsZ1gzRHZKZEJ0aWppb1V4amVOQ1g5d21WMFlsVmlt?=
 =?utf-8?B?TzRhZjc4UVBRWWEzOTFpNjJET1ppeFB0b0NjQWwzZnAwSjZSOUxKWU96aE9O?=
 =?utf-8?Q?ZbffUjBoeP0w1Rog0ZBWhDQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5727f07-3a60-43af-a9a8-08d9ed9a0dd9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:06:56.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfJ/KqaaN7U3YzaboEu6rmyIyt6XRpLdPOfxhGX9o2lfeNJyiMI8OaZSeH7vmf+jdwEd7JVSQ9m1GtJQMDB4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3214
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


Am 2022-02-11 um 13:59 schrieb Rajneesh Bhardwaj:
> There are a bunch of warnings from checkpatch and kerneldoc style issues
> that this cleanup series tries to address and also update the SPDX
> License header for all the KFD files within amdgpu driver.

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
>
> Rajneesh Bhardwaj (4):
>    drm/amdgpu: Fix some kerneldoc warnings
>    drm/amdkfd: updade SPDX license header
>    drm/amdkfd: Fix leftover errors and warnings
>    drm/amdgpu: Fix a kerneldoc warning
>
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 ++--
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 14 +++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h         |  5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  5 +++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  8 +++++---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++----------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h | 11 +++++-----
>   .../amd/amdkfd/kfd_device_queue_manager_cik.c |  3 ++-
>   .../amd/amdkfd/kfd_device_queue_manager_v10.c | 12 ++---------
>   .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  3 ++-
>   .../amd/amdkfd/kfd_device_queue_manager_vi.c  |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_events.h       |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  5 +++--
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  6 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c    |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.h        |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_module.c       |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  4 +++-
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 +++--
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  4 +++-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 ++-
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  3 ++-
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_pasid.c        |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h  |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |  3 ++-
>   .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h  |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h   |  7 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h  |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  3 ++-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h   |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  9 +++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |  3 ++-
>   50 files changed, 137 insertions(+), 94 deletions(-)
>
