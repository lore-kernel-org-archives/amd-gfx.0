Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C155C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 14:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FB110E93D;
	Fri,  8 Aug 2025 14:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwRJl2jB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEB710E93C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 14:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7iHPcJeTNnTD5kFlzVfIwjuD9vYEjThThK6Td0txyj7uT9ll8VHCUi5zRV2s+cj/DHxnYzgGcvAfdXpdClrSLMApVF2IUKk5urUgIy2CmnYeM6be3sc344g8PVS3rS9EqpOQZX/fjKRp3IacDU/8XxSeNdgPopX6e69I39tr0a5n4/QsQJdbYEkqa44MI4bMsgx0n3svRyTEKXkqmpovwddsQrKW2CSLPF6HE+GA6rm+qpbaX4tSFUg5WgKE9/RE/1qwNH7eurpsS0M/m64eY7qPx+bIrGhNdSXBQN+QUCvwxRgO1fk3wcbvbtx9cGXuNpxONzEEmebuOS5oclk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amfk6mZwYKklCub8KBkmXE4itqX9vVqBvKw3FLTAnOE=;
 b=UGJenu+oz7mD37jud44kPBxym7oxahRlo9E7p7UGc8m3KB+FcLidxYRKYDfvSP79WIoDD1oc4XA0UeOUthHEWe8HHvpEwFfG6cXo/xpLZROpYsR062dCZDeSamUexSnEOGxQ5iZtdbS/g2BqMtXsd4gcUVLo8bE04hxcZl+oqQzLcb8ryDR/nfkRQryoFTOp3WKibBv0Rw1fDutDQ0Aw6EGd3OshTDpag6erAi0rnjAmCH5bS1hCN21RiEIxXUN01oQnB0sf1Vz8rIODlRd+bEKY91FeKBnJPnTeeJLQQxDeFMDmp0VTqldLwbs/k++K/Sd+HoPtW3pfKrHqTL246w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amfk6mZwYKklCub8KBkmXE4itqX9vVqBvKw3FLTAnOE=;
 b=lwRJl2jBmFlZMXwOq6zBqPJc8RnD2fPzfSbSDb4eHwZXf7ByTR9OPwWsR0w2nRKTLXHBQRKzgkfVX0R3emQqyTLs7bdxIW7kqo/n8tsZiG/Xf57xU3I71EtssbDHhVfP1XVnNJjwFeHqZf5lC3uPpUO+Ns/6d5Ev77caxMU4tig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 14:13:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Fri, 8 Aug 2025
 14:13:19 +0000
Message-ID: <6f5e0a35-3a45-4762-943e-e342d06fde12@amd.com>
Date: Fri, 8 Aug 2025 10:13:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Heng Zhou <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Philipp Stanner <phasta@kernel.org>
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com
References: <20250808031427.3131402-1-Heng.Zhou@amd.com>
 <de752482-b57a-42c8-9ab2-6d60ba7c9498@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <de752482-b57a-42c8-9ab2-6d60ba7c9498@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb39190-a708-4bf1-bd28-08ddd685b9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmpoczRxakxyRWthbUlYS2EycjVGZWpGN1FVcHlxaXZBUTFwc0MwRmVOOUFX?=
 =?utf-8?B?L1NmMFU3RlpObDQ5L2VoSUFTSVJMSStEMnZ3YlVIc09pMlluVVBhdkM3eGtl?=
 =?utf-8?B?bGh1em5hbFdFN1A2UmY5V2NCOVQ0VUJRYkFRcy8vcU0rYTVsdjU1SVU5MHZX?=
 =?utf-8?B?emdqVTMvTVdrSWpwRTE5dGhLRG1iVGZ2TDVpeE5SUUF0aDJTT0FSY2IwZWh6?=
 =?utf-8?B?aDBZSGxyaFZseDhPcCsySUlnYm5HZkdoNldWaTBiRmNQNVRCazNXV3dUVGV6?=
 =?utf-8?B?QlQyaFliMVFDeDBuelAwWUd6b0dvVmxxYy8zejN2amZqZVYzTEZsV0Y4QnBC?=
 =?utf-8?B?eU5nckkwc2JmTUZ6aVlKd1R4dENNRjBqQVUrUUxwOUdRM2dzSGN6Qkoxd0N2?=
 =?utf-8?B?MllBOXJ4SU9EK1FNbzlEWE1GQlY5YkV5bzNJWmw3VHc4VzhKQ3lsZUZPb1hL?=
 =?utf-8?B?bVJNN0s1US9XNHVHM0RiOXoxckRDcStuM0YrRlhCeDBRVU1hb1Yyc09YQk11?=
 =?utf-8?B?Rld6UzY5bkNPV0RCVVV5WFFOWVlzNy9Bd29ydXQydGhQTVptUllZMDk3Tnpx?=
 =?utf-8?B?MDlhdjVnamNhNmExODNsYzRRbnJjNldOQTNtd0dwcW5xSkdoN1kzWmIwTGZw?=
 =?utf-8?B?L2JPSEdYUjBxeVhkQ1A4RU50K0R2TjBrVnZHSjJsOFgzcFM4S0J6L1JBRDl0?=
 =?utf-8?B?b1ZPODQ4V3F5SVQ1OVFHREMzWGUrR2pPYXJQanN0SEh0Z1UzTSt2bDhKVUFD?=
 =?utf-8?B?TkdOSEd4VG9udU1JaGhGTmRnTVNhaGNlMm1qcGZhR3MwS2NnRjJVZUR6YUtB?=
 =?utf-8?B?d3hXYVBuL29iNkRlczV1TlUxSCtHMmxieGFsZHRRcDk3NTJOOXpwaE5va2d6?=
 =?utf-8?B?ekIraStSOUl2dVB2TDNRTzZQN0o1YVExZjl6OG5ibzlZNC9jZnoyQUx0cG02?=
 =?utf-8?B?cGgxblZwVGpqQjhVREFCUHFHeTYvKzRFbmsrY1hQVXlqRjJyelp4cW5RNlBU?=
 =?utf-8?B?SkRlTER6MFNaNE5DdGxQL0M0VGQyeU9tRmtLTzlQa1RBa2h5TStjWVV4aW9w?=
 =?utf-8?B?UEZDSS92SlZsdjQwRGtLSkxBM013Mmt6MllwcWtRcWpobTh3ZFhLUmtTd2V1?=
 =?utf-8?B?Z0pwRkk0aW5LWXlQNGdvTjRCWjhYUTdvYlBTekI1U1k3VFlHbjBGRGlEYUlm?=
 =?utf-8?B?VitwQ3ZoWkU5VFg3dGxkV3NQUTUzWXRtSTJJR2VGeG9VTldWV0FVcktqd1Yx?=
 =?utf-8?B?bnNPM3RyaUkvOGdkU2dHbXlOa1hLY2h6Y2pIVlM1WXpoRFEyWFFJRER6L0Fl?=
 =?utf-8?B?K3czWEpCSzVLdWEwK2ZZck0zeHNnaEdDUDZZMXlKSExsSlFTN09oNkxWWnVO?=
 =?utf-8?B?QzR5M0hVc2JXRDEwMXRuaFpEdFVuZ1NXbitrVC96VmNaOW1PSTFtMFhDS1dj?=
 =?utf-8?B?QnQ3VEpZWmdxcC8vdG1KU3puUVVYajcxVW5EcGp2WUZjc2pEcHorY3JiUm9w?=
 =?utf-8?B?T2kzSk5yMVBDMXNVZUxxamhZcVRHNnhMZTBsRnFHRVJaZmIxdUZiaFVrd3lB?=
 =?utf-8?B?UDZwekE2aThudHJITUJPZ01TQXNVQmFsem0rWUZtYTNXbHowUEFkOU9wakVj?=
 =?utf-8?B?clF0ZnpWdThYZjhxdUF4S21SWkZtcVE4d0lTcE5admpReEVENCs1ZHlJampE?=
 =?utf-8?B?VVVJMHVPWGFGais1M1dsZzBpRmw4aTloeDkxTWVWMmNwTll2YWF2S0daUS9H?=
 =?utf-8?B?dWwxMUVVbXE4WVE0YkQvL0p4T2M3WWx0V2ZmL1RFSmo2ck44UXFGVTJ0dlVC?=
 =?utf-8?B?RWdLWlM2dG9TWmFmcWVqdkQ1Q1EyNVpUelI4RitFeFNvMmx4di8wWVUyT2Ur?=
 =?utf-8?B?TURySEx1bk8wQjhkYzBPS2Vxc2VuajZESGlud01kOHlXTWJHVjhETi9KeUgx?=
 =?utf-8?Q?5A2TYZPlCdI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRTVzJoaWx4QmVpdlJWYllacGZ2bTNmZU9PMTZLY3VWRUYrNG5lTEk1Ynh2?=
 =?utf-8?B?V1NPSWhHSGZjK1dRWVc2Tkc1U3NDMEp3TmVIY0hIa3RTbkZwMEpaVnRiSG9C?=
 =?utf-8?B?TFY0MDRqZGM5VG5NemhlazhGR255V0hjUGZTUXlPQXZCQWtrUTlCMWsyczRw?=
 =?utf-8?B?UXh6dURPMExiazFLZXNDYnJuanNQY05sMVlHRnA5LzdhZi85UnNzTThPSFNO?=
 =?utf-8?B?WXZQcFVJa0pvdnBERi85UVF3QkwrSzM5WGdzd0NjaHRlMkU1OWVySThoNEN5?=
 =?utf-8?B?d1VIRVRsYVorZHlobE1tWjMwTXVpMEp1UEcxZEJxN1NTWEFjYllQQW1pZHBy?=
 =?utf-8?B?RUViRUdobnBaVEY4ZDF0YlR6UjhZd3AxTE1YMEtvNDhQdW14cVFoY0owS2dZ?=
 =?utf-8?B?eVhLZ1FLbTNSRHFxcnBQVTRCQXlJS0wrM0lYbFJrZ0l3QVprdXFVNmxhQ3pn?=
 =?utf-8?B?RnkxV3JDbTdSU0xNSEROK1pKNjQ1STZ6bm5XQU5QeFpJUTNmbDNpT0dLcEZJ?=
 =?utf-8?B?eGQrb1FaOWx4YVJPM3ZIMEU4TThZZ3pCbmYvUXY2d1NuaEtIUkNZS3dXRStn?=
 =?utf-8?B?SU5yandjNjZjNG50a3k2Y0tVc1JxemlXQjNibUpZNnZGS0pNVFl2R2JWaW1F?=
 =?utf-8?B?WFA1eFJmbG54WEpldHZwdXBhT042Y3dpTnRBdFljNXljRVVzQlZNc2pJaDQ4?=
 =?utf-8?B?KzY0RzEvdytNZTVhOW4xa0k2N2NabGtpb3JBdGpJS3hKRlhsWTVUUmVYUGtN?=
 =?utf-8?B?dHcvdjRWWjRzaWM4NW9XR2t6TEw1ZC9ET2s1QjJYUU9iSEVRWXFqOFhoV3hn?=
 =?utf-8?B?MmZJQ1pRWnhNNUppSUEvLzMzUUZWR0hadlk5enBqMGpoWlNmRjA2SWh1VTVR?=
 =?utf-8?B?VkU4ZEtWNksxYnNhNTJuQUtFYjIza2tkaU43UDBsUzFXVVo1aElJMEdLd3hU?=
 =?utf-8?B?NTJQOEN6YzhOWEVhcEg1UkRQQXRtYnJ2RVdoVy91clhJb0J5Q2YzUEc4U09t?=
 =?utf-8?B?OHBJZTBMOXRQME5wdUNiTThuYTZQczN6Z0NqZSs3MEJXU1VrbFFTamJ5V20v?=
 =?utf-8?B?ZHlZMnB0QmFWd3lLR01ZWGduOHVBNWhUcFRiejJ6THVEUFdBYkFvVWRyNVdr?=
 =?utf-8?B?cVhoN2VnaVlNVEtKY1U0M1lVeVIrYlEyMTcvd3dKMi91YmZ6RkRIK2ZFeWw3?=
 =?utf-8?B?MmU2TE1LT09uUG1mTnlNbENicHhndGRjSlBVM3RIVE5xSDRqbGhheUJXb3VV?=
 =?utf-8?B?eFFTeWJjQ0hLT0oyNloweGRoRGRUb0pxTUtnMVhrK1pqZHdrRzBnY0UvRUdu?=
 =?utf-8?B?ODBGMXpvVHM4MzdMKzRLOXJ2ZGpYUXVveTdBckNPakkrZG1VNUREYWtHTy9T?=
 =?utf-8?B?ZURXZmJEc3pER21aQ04zalg0UkJkalNCKzg0WWhxRWt4RE1kL2RBRGVZUDdk?=
 =?utf-8?B?Slo5N2N2aVJqN2Q2bThMWG9zMVg3bVA2d0tjeU1tSUJIeUxhc1I0WUwwNWJ6?=
 =?utf-8?B?S3FVa0FHbEVtem9WYUtKN1htb1h2c3Ftc25iMi9Fc1VyTHI5UHU3UGtNM1I0?=
 =?utf-8?B?cTUwMS9aNWcrTEROQ05nMUhxcUtSZ1doTkJLWllCNWNyL0JhblZUNmdBcUJ3?=
 =?utf-8?B?WVNsS0p4V3N6WnlVZXQxcnRMZllUWElwbGZNWHZaQWFYaDF5Z0NLRHNodWQx?=
 =?utf-8?B?aUQxR2tBbzdhN2w1MnJiM1NIVHp3amFid0NTaUR0Q3pPL0FDUkhhZ0lBWTBF?=
 =?utf-8?B?bDNZRVhiakt0RFZyT2dQa1N2YUhQdW5McE0vM2xiVnRMQlpzSXU1VjROTngz?=
 =?utf-8?B?RlVqL01jdVhRQU5mYnBGVURyaVFwL3MyYmFGRk1qZmlwWW9vVncwME5KMm5h?=
 =?utf-8?B?U3NkRTJyVmVZdGxEYkF5Y3BnVFplMHF5bXR3UHhTVjViYUR3a3hSaEFNaTRJ?=
 =?utf-8?B?MlBLZElMNW9rMzR4UXFNQXRETmxxWE82N1JZc1VZU2lTRkIyVjNnL3BFak1N?=
 =?utf-8?B?cFhsMC9OeFM2ZXNxTU9OVVpQZjI0ZGh2NHRxUHFPaUtKa1FvV3ZmdTFhTU5I?=
 =?utf-8?B?RnNoVmtNZWZEWTlqRlJXUUIvMlpmc25OYnFCbHFYNFo3cThNbU05TUxPdSt6?=
 =?utf-8?Q?gZYgd/1qk21hMaNKVvcVpVgCA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb39190-a708-4bf1-bd28-08ddd685b9a4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:13:19.2504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lD9aSSpejHwYDnte+Q2m04JXbRRBNkgoENbSjTLq2/WF4R9j/JClqO2nSzwx51FmgQJGgfrE1qqYHaXU/ukxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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


On 2025-08-08 5:21, Christian König wrote:
>
> On 08.08.25 05:14, Heng Zhou wrote:
>> If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
>> So, such kind of amdgpu_bo_va should be updated separately before
>> amdgpu_vm_handle_moved.
>>
>> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 8 ++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h           | 1 +
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 37d8a7034a7e..e795b2970620 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2970,6 +2970,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>>  		struct amdgpu_device *adev = amdgpu_ttm_adev(
>>  			peer_vm->root.bo->tbo.bdev);
>>  
>> +		ret = amdgpu_vm_handle_prt_moved(adev,peer_vm);
>> +		if (ret) {
>> +			pr_debug("Memory eviction: handle PRT moved failed. Try again\n");
>> +			goto validate_map_fail;
>> +		}
>> +
>>  		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
>>  		if (ret) {
>>  			pr_debug("Memory eviction: handle moved failed. Try again\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 283dd44f04b0..2c2a93f22ba0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1569,6 +1569,14 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>  
>>  }
>>  
>> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>> +{
>> +	struct amdgpu_fpriv *fpriv;
>> +
>> +	fpriv = container_of(vm, struct amdgpu_fpriv, vm);
> That's an absolute no-go from inside the VM code.
>
> You could maybe do that in the KFD code, but Felix and Philip need to decide that.

We're calling amdgpu_vm_handle_moved in amdgpu_amdkfd_gpuvm_restore_process_bos to update mappings of BOs that are not managed by KFD. I don't think we care about PRT BOs, though. They are not useful for compute work.

What is the problem you're trying to fix here? Is amdgpu_vm_handle_moved crashing because of the PRT BO? In that case I'd try to make amdgpu_vm_handle_moved more robust to handle that situation gracefully (i.e. ignoring PRT BOs).

Regards,
  Felix


>
> Regards,
> Christian.
>
>> +	return amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
>> +}
>> +
>>  /**
>>   * amdgpu_vm_handle_moved - handle moved BOs in the PT
>>   *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f9549f6b3d1f..853a66f9fd2e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -504,6 +504,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>  int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>  			  struct amdgpu_vm *vm,
>>  			  struct dma_fence **fence);
>> +int amdgpu_vm_handle_prt_moved(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>>  int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>  			   struct amdgpu_vm *vm,
>>  			   struct ww_acquire_ctx *ticket);
