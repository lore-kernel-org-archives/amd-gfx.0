Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA034C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 19:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2BB10E948;
	Thu, 18 Jul 2024 19:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f2LmOpY0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B1E10E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 19:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaoVVHNI0LtH3+nf0NGyJ0EhzY4ENcqC3etjVmmqUPisWjTtSyN76PM9uXxNo/mQn+VBOQTy8aeAUhUYow+g0hLoAM4IxDZtTU2ftvC+0ven66ii6Vx6MhacL1BGZD+27oAvs0no42WhqEgQaZ+JgQ/CbmIb0OQ3YikrzF+a91Gx5J8hEudxl81QdNSp7i0ESVL4srAI3C2ffrandV0d4X4IqyWvwBugueaZhO2YLv9CVIyV6QSNywn71KH4jCLDc8E/dpgxSq9aEY97d8CBft/+nSrKcFgKV7Uavrya3y7Mp83IdafQzU2qyRqtIEFQySRew5nrB0LmDr5qZ/xI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngu7SQHpRa+fy1hVBe1GTJls+LomDfvc8vCH1pEt+Go=;
 b=Z4+UASrePXKA3Cmee6RF2QhbRpKevRC6Vobe6z9SeN4SLhUeZFYsRF6BWyrwXl4rEC2SDfGer1DcpSZUo0fIuovaS/7K3N87f9IXYBb9trTLS66GLvJd0F4mS/WUwecG5CZxJ2Z/eFBo40b7A96t2t7UzAp3IE3Ow0I6Wi7Rw9wxEUc/xYZ2wJBOFwEfgs+RgfsZ+vkuYUW1jZF89YTHtVertS+F+ZrmMSG+aLo6nUBSickIX5dlqFz53ysjKeLg8m5FgORxoOBftR3SjqVuSr8dhDfQ6+q0iT2/cyrtWui8UIC8mQ4X0MBYlQDdjqeaix4LiQ74qyUpUcRkDs2VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngu7SQHpRa+fy1hVBe1GTJls+LomDfvc8vCH1pEt+Go=;
 b=f2LmOpY0F+HlQe+6fFvcEqtQl3pHS1/lp/kzQiixS0IdEmFPlECJJHfU2JkaDwsbJDsQjyd1hv9k35pus/xBcDGU//pDJmp8kbyuGlUJA03b/jgz1Rd/PqvMBzlSQdcsU4niu5STOtOT/jKFrMaVjhb7f7G2dubAkIG/zlPJZN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 19:32:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 19:32:51 +0000
Message-ID: <c5c60b8a-cfde-8f79-9522-ed5bc18f5e75@amd.com>
Date: Thu, 18 Jul 2024 15:32:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-4-Philip.Yang@amd.com>
 <2239cfa0-6f41-4d8a-9915-0ec1829e248d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <2239cfa0-6f41-4d8a-9915-0ec1829e248d@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0b05e6-f95c-4f4d-e7d7-08dca76069b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlZYQjVJSHFJdzlkT0pRQ2FDOVpDMXg3THdqcnpaVE5LOFZJOFk0b05JYnQw?=
 =?utf-8?B?UXliS2hUbVRnbGEyU3dCa2xtNmVkSkRmeWFJY2wwRUg5a3A1NHdkeE94OGlU?=
 =?utf-8?B?QmF1amxvR2FHaG5YbUpSY1ZtdzNIQmpZWE5IdVFod05DQ2VYakgvTzM4VEVh?=
 =?utf-8?B?V2wzMFdYRVBiUE9kc0hXbmFYaEY5bEYzbHpOQndkdjU1Mnduckc4NHd2dldX?=
 =?utf-8?B?N3Q1VzVPcVd1TDB2cFd4WTNoTlhZRUJWYVVET0FpNG05QXgwRWJ3QXl6Y3NS?=
 =?utf-8?B?OFJmM1Q2czhKaXdzMTBMSHhDRGxnTmVLUFh5S0R1WW5JUVJGVnF6ZUltZktW?=
 =?utf-8?B?bCtLT0x0Z0dtRUhWeWxZeUprNnJxa0hwTTFsYkViM0c2M3ZUaDRHNEtHR0J3?=
 =?utf-8?B?cG53ZDNxa0dYclZiWG42UWp1RGRUa2taNlBnanIybW5tZkVyMG10d1ZxRzRi?=
 =?utf-8?B?T2RISzhGN1dIbnFWWHBGWHFxa1JiOThNSHFQSTRGb0VVUnhmT0x4cnpEaFN3?=
 =?utf-8?B?dDgyVGtqcDQyazFJK3JIbVBOb2k0NkkxS3MzelBxZW5KMzhTRWpVdi9BNm9q?=
 =?utf-8?B?V2JybVNxYUFEZ1BKbEI1YldqTnFkZjVzalloQ2s0dVNmOXNBUlNuUGJtTEJm?=
 =?utf-8?B?dUhwRG53b1BaWGtlQSt0UmdMcjJQcTlvbk9wQ1VMMVRZejYzek1JazhPNm91?=
 =?utf-8?B?TFNBNHI1Qko2bnYyRVE2N1pJSFdWRWlxRGZjbndHRjJpNzdsMk42ZGtEdGVm?=
 =?utf-8?B?Yndyb2llUmxSYjBBMEhQMTFacVlNUEw3dVYvTmZwOGxxMVBMcjhRRFdhSFN5?=
 =?utf-8?B?Y1hiL3A3eDZoaXV5UGVsZjhocG9XSmNJcktvQWdvRWZtVGtBSHc5MFU0RHg0?=
 =?utf-8?B?QVM3SkJOVFlNVUlNcDViRHNzMDJhVVRvZFMwbW53ZlFsMjJqU3pVajM0K1ZK?=
 =?utf-8?B?VEVlNDE5cnZSQXVmdE5nai9ENzdMM0N0eWtiUlhwZ2Npc1A3bnBnVVRlSUgw?=
 =?utf-8?B?SnJ2ZmV1S0F3akhMalJ0ZDZjSUs0RE5GNFpSZTltRFpHM0REbVk1Wm0yc2Ro?=
 =?utf-8?B?VDFJc0xKNXJ4aW1HV0FGYkI1bkVVVWkvMUtmSU9GRzZZWUY5WFZuZ1MvL3Rt?=
 =?utf-8?B?ZWtrWG9XREZic2ZmWkkrQmlmVUNjSVdQZXB1enNTYWl2YjlIU0tQeGU0S1ow?=
 =?utf-8?B?QmZBZTc3QzNqVS9mcE5PM0l3OGdzSGlROExzKzdOMUhncjgzNElLNjZoeXhm?=
 =?utf-8?B?UVAvRHhlamh1K0I2OGZTRFBtSW1LZXcwVXZuSFJzRGpTNWk5TGdva0JHWTFU?=
 =?utf-8?B?Z2lyNkxEN3ZlRG0vTDhSS1Vna2xOeTc4VFN4RTBmVmhSR1NNekd0VlJLMnhZ?=
 =?utf-8?B?aC9OZ24vNTNXNkhaR3UrT3RFSWtqOGUwSUt6UUltMll2K2VkazJaRDlMOWty?=
 =?utf-8?B?WUxVZkRVdzdVYXhPUHdQRlVDaUsyVnFRNHE2OWw1c01DTlgwQ2hkZnFBaVYy?=
 =?utf-8?B?QkMvcnFadXQ4c2JxU0tsNWU5Y2tNOWE0ZmdtaDlqdEx4Y0RoQndYVVRORXpE?=
 =?utf-8?B?ZUlheENZeUFZWGNxZ095QXM4VXpYUmd6TnB3OVdrUWpGT2dUckNZTVk1T2Fu?=
 =?utf-8?B?V08rMUtVUU4yakxLQlBOYyswVHVRMFhZSkFWVWx0a20yNTQ1VGNCZ0t2YUgr?=
 =?utf-8?B?dWtHR2tmQlY5UW1WUkdPNmRJZ1dxazI1TDZLZXhqS2tUOWV6blhUd2ZWYmhY?=
 =?utf-8?B?a3VsYU9sRnpNQ0dvYlJCdGFCclF1SW9INUtVOTBEbWxmcGY1SFk0dDhucXF6?=
 =?utf-8?B?RXA4M21LWUZ2T1YyTGRRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVI2dC92TjdXVjhaUGlNRjF0eXVGeW9jdTU5NFZiUk9hMVQwdVZBSVkvL3E1?=
 =?utf-8?B?NEluaGtuN2k3ejRVWkxyOVdGM2JzOFB0OVRFU1FkOXNhUE9MRlczWnZwNGZ3?=
 =?utf-8?B?c2N2dWZ0K1FFdWMrTlQwR1ZneUtHTXR4NVJ2V2lDMUxXMDZvLzEreDRBeWk2?=
 =?utf-8?B?M25wU1o1K2VCSmdDNDFDRTNPOUNja2JXbTR4YmE1eFRSV2hpTHJOSDVkZ2lI?=
 =?utf-8?B?R3p0S1VRMGtuWkpEaE9wWEt5YVg2OERvWFczMTNRN1c4VmdOM1UzWmtKOWpQ?=
 =?utf-8?B?eWtXa0hrR24xd2dTdXY0ZkVIaGNsSC9yN1VVTlo3bk9kTHYvSC9iK0FBL29k?=
 =?utf-8?B?SG51L0lqY2kxa0hibmhZRnU4MHRvSTZsNzEzN3B4aG5YeWExSUpWRVlxQW0x?=
 =?utf-8?B?dVpLZE1XUktwbUx6bjFxanRYNUl0eTdmYnVzSXpOeW5EUUJ0Wkp3TmlnMmFW?=
 =?utf-8?B?Nm9iK3pTWUMydFVUbyt2QStiUUJ2TjdtNFBwc29lVWVxaHBHTEh6Vjc5ZHZC?=
 =?utf-8?B?L2gwekNWUWExdnZzL1hhWEl6UndRZGNJOGg3SHZDdmxtSStzdm9Zd2pVZmhu?=
 =?utf-8?B?TnpMeTlmc29tUENnK09rbURreUFGU0RuRHZBUGlOdmpoZVV6WkpuTjU0ZVNr?=
 =?utf-8?B?NUhReUZpUWFnNFZVV01MSlhmeGNaczA5c0pMRDh2Tm1VVkdlT3U0NTAvbmpZ?=
 =?utf-8?B?MUJCd0E0anczaUQrc2ZhaDRVVHM0R1gzYktlS0JwMUtCQkJDWU1nOTVvZTJB?=
 =?utf-8?B?bWdCclpnbnF2aFR5ZWhXbHJVaHd2RlJxa2RxWUZ0aGd0OGdsQWpoYk4xOWxj?=
 =?utf-8?B?ZmJuSURLMy9oQlByeXV4OCtmM0pSaUtwcVl6cEVNSEdqMHBZcC9CaS9EaEt0?=
 =?utf-8?B?bXg4c3lFdVp0eXNzTUJZcHJCcU11Qit4QnVTaGk3RkVsMTFQVXBpOCtBN0Q1?=
 =?utf-8?B?VklmTGp2L3JGQWRwdmlacUh0cUNwWDhVMlVzOHNtM1JNRGJaRXdRNGhEMVZV?=
 =?utf-8?B?SWxHdWdBc0Q5WndJTkdCb0sxcXJyK3NXK3Y4OHJPdldLcFZEZERxT2VnVHNV?=
 =?utf-8?B?RG8zbHZuV29teU9xY0lERGt4RUt2NUhsU3A4UlRVUnpyWElpNlJNMnMxSkxo?=
 =?utf-8?B?eTFEWUZvU2JvTEpnc3ZPUlNZcDFrLzU5UzRvTzhpa3BUeFR1Y2pueWZqT0J2?=
 =?utf-8?B?TzZSYldSNU5RK0VqQVdiT1l5UFVNN3JCSHcxM3ZPdklaZit0QXdNcGQvUnM5?=
 =?utf-8?B?UGtTTWdZcVI4UzRVZ2VCOGlVblM2bkh1QncyeW1aOEFSWTN6NENtanNzMkRP?=
 =?utf-8?B?eXRvVGltaFV3aGRkZWZ2SDNPRXZyb1I4RVNlMktGOENuSkx5VmQ2T3hlOUVN?=
 =?utf-8?B?c1FUQVhScld5OVQ2cjAxV3J4cFMvMUJXWjkyOFhLSzA2blBvdEs4eGN6UWFw?=
 =?utf-8?B?WEkxVWovcm9uSnlId2lkK1F3ZzVwSzE0SHJFZEZuUE9DZVlmTEhvMlgwZ3c4?=
 =?utf-8?B?NlZjYzFnYlpMdzNKTENCdUF6TjVtbVhMUUR6dzFkQkJsNGdEZVhsdUQwNSto?=
 =?utf-8?B?dlJyQWdEcTB2dC82MzN3aWg1R2pUeGZsUGNrZTNmSTNScXBkVXhEanZid1RO?=
 =?utf-8?B?TVkzb0s0ODN6ZEhPeHlxQkwvdy9FOXdrTWtKZ24wZDI1cUJ5MWppS0ZISk5S?=
 =?utf-8?B?R0dCeXR3SmZpV2h2bEYzUVBYK2FkZzVtbkQ1aGZLQ0dqUTJBVFlPVFB6dmFY?=
 =?utf-8?B?Q1F6MVM5b3VXbzhGbklRNFUzNmtiZkpxbFRnZmlLK3UvSnY0VHhSU1crbnBn?=
 =?utf-8?B?d3F5Njlaa1kvR1NqYkl5OFhudjVZblBUTCtVYjdtMFMvWEY2OVdHY2JXNmJo?=
 =?utf-8?B?SzVJb0N6VU95bDkzaUdBMUZqeElGVkcyaUQweXpNeGZ3b0VyNWhnL0RJZ2Fj?=
 =?utf-8?B?L1NsR3N4VDl6WEkrWEtDL3NFNlFaTmdSTG56YllHQlVwajFidGNqeDRVbmF2?=
 =?utf-8?B?OUpycHhtSVlLMUZzT2Z1TGRPNWJqT1NzbXdlb0Urbjh3RVE4M2M2bzNyelJ0?=
 =?utf-8?B?N2xiMnBvcGhRenlVWG9vSk5iWTFadm1ESWFMOFdBWDdWeXZXdkptMGIwc3Nx?=
 =?utf-8?Q?X9VU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0b05e6-f95c-4f4d-e7d7-08dca76069b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 19:32:51.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiOVSvuEJLVWfQ5ShrAvYvPE6FwNYcmAsJa5jR8MuZ1Tw+NLj9iU+x13H8bDbJbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-07-17 16:10, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2239cfa0-6f41-4d8a-9915-0ec1829e248d@amd.com">
      <blockquote type="cite" style="color: #007cff;">@@ -603,8 +606,6
        @@ struct queue {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gang_ctx_gpu_addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo;
        <br>
      </blockquote>
      <br>
      If the wptr_bo_gart is GART-mapped and freed in the same place as
      the gang_ctx_bo, then maybe it makes sense to keep the two
      together in this structure. It also avoids having two different
      reference to the same BO in the same queue_properties structure
      above.
      <br>
    </blockquote>
    <p>Yes, agree it makes sense to keep it inside struct queue and
      rename to wptr_bo_gart for GART mapping and unmapping. Add wptr_bo
      to struct queue_properties for queue wptr acquire and release.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:2239cfa0-6f41-4d8a-9915-0ec1829e248d@amd.com">
      <br>
      Other than that, this patch looks good to me.
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite" style="color: #007cff;">&nbsp; };
        <br>
        &nbsp; &nbsp; enum KFD_MQD_TYPE {
      </blockquote>
    </blockquote>
  </body>
</html>
