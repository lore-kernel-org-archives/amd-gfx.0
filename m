Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B4CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 15:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA53C10E425;
	Mon,  3 Nov 2025 15:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sEfY2bXR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E967710E421
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 15:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+PtVvx1bHNV/9Z125Aehc8k9lkqpvqrTvsGZzVweyYvkb2a8h9eOUJdxZuQbNuWpSSnxdB1kOHNyaVBdaZeXxTpwb6AqDF3Z5+qkglG/j79dh0DYZMGjqpKv6mk8nBKzAUTupqo+PySoiWMVMnuTyljCe4H5snMfsscnuh9QN/RaCEvXUDDXueOxXuhLvwS99gmYYI3TBWSOiGEosKyHhzZme3+IM0w4ftK0G9g4TuDpWjx63KkCECK7A56dfOLlu4d2Z82Mssats/tynKkIcNdWsRNSihwt77NlS3kzqQZYiQmBNf3izaYRostPJA4HyuL/A8btCsHgOT1uA3SnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu79WV0azrZBGFjzHU5D/OfZPrdD59LPcQvhp7sUKdM=;
 b=Yw1pNQ5qi668i1MAbcXmeUR3w68d1Dre1KlwT2zLXTfct/hkittjQGfB5Y1UFXldHnjVtdeJno3kPgtNJgBr+JlE21VlZtexy4ln3NYQeYuThJM16Cd6bLqUvlD//Q0moPzPxheqxlFdSh2nL8O2G3B1t0A5mqJIpnKitGnWCi0phrUJs+Sb0b7+q6lwI2m3+Y0uQpnrBsX852R2r51sHMGrsctkCZ1/F7X2RBjGcaIG0dCNlb4D5tvMjcmD5ynDYePSPcfQAWtDWAR05YqYvEdTCZtQeb5/+Eex2Pwf4nM5nltp44vIv08JnyeT/7D/RGTWma8bDjGIF9bo7SCrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu79WV0azrZBGFjzHU5D/OfZPrdD59LPcQvhp7sUKdM=;
 b=sEfY2bXRXg45KA+aKC7Sd8vlp0qCECuiUGeBbjgGVvj/C4fw8aWciQIHfy7GuOkX5tiyZeeu6pm3lDE2LBgRAmLSn4sP2FogkixOTwUUyoeHwHCq/fmQdS4He7JtWjAHq1Y65rTcHhPBoxbfLlcSiHA3ZOhpDEMaOZOs0OU3VCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:26:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:26:52 +0000
Message-ID: <c982e61c-976e-49de-af88-5bedde45eab9@amd.com>
Date: Mon, 3 Nov 2025 16:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
To: Saleemkhan Jamadar <saleemkhan083@gmail.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20251103152401.9304-1-saleemkhan083@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103152401.9304-1-saleemkhan083@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0885.namprd03.prod.outlook.com
 (2603:10b6:408:13c::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e20368d-6a51-454b-580b-08de1aed69e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGI1SWFyd1dwUm4vMjA0Z0NTR2sxbk9MYktvanB1dFZWY01EKzd2OURqNjBZ?=
 =?utf-8?B?YmV6d2dtYXFtZ1EvNXdQclBWKzIzNnFCb1BLTG1BZk43SmZxNFBiRjNDeDFH?=
 =?utf-8?B?czdlRnVCQVJvVm4vRlZMVXh5ZFRwaGR6MXp2V0hCYWNHYXE4ZFk1RVN4SkJp?=
 =?utf-8?B?bTRCZXhSL3YwM1pSc1dHbVR0ZDhNSm11aGgreHBaWWcwK24xOXFEdGsvcEIr?=
 =?utf-8?B?dkg3N1J5TjZsdHpSaEF1bTh0eUVzampKSUIxd0d6UzA0SkFINkY4VlZJcEdi?=
 =?utf-8?B?VE1Td1g1ZFp0UHhObW01UXlXZTIzeGMyZy9SSnR0aFk4enNzemFKYXhoeXQx?=
 =?utf-8?B?NGhRdGZEWDNMQlk2bUc0c01zaE4vQy85WXAyblViczUzY09kVENTRkdwdjU2?=
 =?utf-8?B?WFd0aFhyWjBWNGdGODhselV0dmV6NDNTYmxaVTIzUlRWZnhkSnFUK3pneVNW?=
 =?utf-8?B?MlNMUUxRdk02Z0xnUDJIcld2UXpNMG8xdStBRUNmOFN0RW1WbDY3U1dpZm1y?=
 =?utf-8?B?eWhBazVnVmppTUVzN1hQWm4rSnEzbnJiajR5dWdnTDV6cFFub1Rsa1lDY3Ft?=
 =?utf-8?B?ZVRPU2tGVVFTbWgyMXkydnVoeHcrdDN2OUJrN1lVMnh6WFpxaWw3UHR0UmNX?=
 =?utf-8?B?UnA2ZnREN2dkelF6RXU4YmNMaDBCajNTazlyZHpMcjgvcDFDUVpuVGljbHZZ?=
 =?utf-8?B?aGIwbGk5d3JuTnVlYkh3U1Q4ckl4aWlKL09zUHg1bFFzK0l4U0ZjblRxMUsx?=
 =?utf-8?B?aW5mR1hwdmhKN1lHQTN5ck1LWGRpc2tTLzIzcU4xdlVQb2VqRW00d2JjaXRV?=
 =?utf-8?B?WnkzRXgyeUlnNC9jWDdyVTlsNjMwOW53Y0h0VWdxT2w3cXRDdmxIRm9WMXdl?=
 =?utf-8?B?NjcyZmVDMFBDVjZYM2s2Q2xKSzdXY2JBY1c2VXVuRG5Na3UveEZGUDlSL2Z5?=
 =?utf-8?B?akF5dkJOSXNQSHJ4TFp2UzJIUkhuQ1YxbkNnTzM1OEhWdVZqd1c5K2t1WGxh?=
 =?utf-8?B?S0RRbVl2cng0bDMvNS96dXkweG03ekxqY1lxOS9MdEZiY0dqWXpLV1FWSkEw?=
 =?utf-8?B?c1lvMHg2RVU1K3EySUV1dWFIRW52Vm84V2FPZnBwTjhNS29uSzgra3ljNEF0?=
 =?utf-8?B?alN0U09rbDRTaTZXZWpCRldKcGlWdzdrWEdRejRpU29CWGlCOHhTV2ROMXlQ?=
 =?utf-8?B?Ukx1TzJxbnIveXB5YlFSZkRLMTlDcTNhYWNrL0dXNjRBbTF1M29PUVNzckov?=
 =?utf-8?B?RFUxWTI5ZnJDTUF3dnFDMFNzOW9TbklxelovZEt2SjBLOG5kZllkbFZjN0lC?=
 =?utf-8?B?Mk02MGRRSkRYLzdQUHVzaFdCMFlWYlVTN3dwUFY4SVlRUzAvRmFrQ1RDV2Zu?=
 =?utf-8?B?OTNtdHcvS0ZVRDRYZ1F2ZStjdytCZjdpMmJNWUplUVB1cEdXZHY2cWp4dlpQ?=
 =?utf-8?B?azFxNVJkZktjQ1ZVWEZNdFFSMXZ5ZUkyM0lRb1EzV0kwNUx4ODY4ZTI2aHN0?=
 =?utf-8?B?UXFmWmdqdmlFR1g0c0VSallpc0N3ZWFLVW52Qk16L1R5ZmdORk0xdi9OVmxn?=
 =?utf-8?B?SWFKa1UvVlAyUmFiNjdSSnlSc0U5bWFsMm1Jd0IreFMrOURGa2xsdklLbEcv?=
 =?utf-8?B?UU42ekNTMDF2SzRGSTBvN3dxeFNPQzBsbjUyMEZ0dWx4TTMyY2tycU8ySVBB?=
 =?utf-8?B?L0JKN1JpVmllQmVqRjFXSW90VVNaWnN0VzlmV0xKMWxkd2RVWXkvYnlPcmNw?=
 =?utf-8?B?TG9YZHFlSGdXYW5hVWtQekxKcm1MOXI1V3Nad3c2KzlDTFE1QjJKcENnWHE3?=
 =?utf-8?B?UzRySm50cGdZblkxK0lrUkV2emc3emNJN2UxWXNBMjJXeDNYb2FUQ1dxTVNi?=
 =?utf-8?B?MEpSZC84K3U5RnlYVi9iUW14S1VvTEppWmlwM0pCTzBFdEhBa2poZnlEdy85?=
 =?utf-8?Q?zwzOFosVZWQRi6iCJeLIgTavKX6YM01/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pwSzFaY3NxejB3bDh0QmN5ay91eU82YTlJNXhQY2RjNTVaYW5hTE4rNnNr?=
 =?utf-8?B?OTkrQjNQU01acjcxOE1NcGIxOHNqRXZiVzU5SU5BRWJZRVpSNHZMZnk4QUM5?=
 =?utf-8?B?RVRXVzZXZ3VnZkhNdkdHMjVrVUcyK1MyTWRNeStwR1JpYldMbnk5UEIyZUJD?=
 =?utf-8?B?OUxPY2gxa01ENDlUZU5yV0NwcWVZM3B1QjhyVDBnSFQ3cjBaTFhjTlpHNzdJ?=
 =?utf-8?B?ZXNUd2J1UHNscmZuQ1VzQTA0eDRnMytqNktlT05VaElKV0diQ3J3QmxpOG03?=
 =?utf-8?B?NVMwMzJJZHNkUHhKQm9WdFJJU2NWYUx6RlNpc2dwOVFPTVJjTVZ4WGxzN1Ev?=
 =?utf-8?B?cUJJaHFkMjZnQ3Rvd0ExSjdDcU5VNzVHem5lWEY5NUxDYnhld0t4WHVWbTF2?=
 =?utf-8?B?OVd6YzA2WjNXOFpIemVTQnZxdnRmYi9JdGZWTkpob2RwL044ZG1XQnA1WHZ3?=
 =?utf-8?B?WlA4bjRIL1ZzR1RKMzRQYytLeGdkUi9QeURETGhwRkl6aWhmcU8yMEZDRzZ2?=
 =?utf-8?B?OVZYeGNUQXpvbGE0eC9hYk5MOFAzVlU2TjFhSjlmSGNOMUdGRGJRZjJJdm9V?=
 =?utf-8?B?Yjdpc1Z0cysvWVpnR0JTYkZWcEhiZDRUT2RLdWF0cnlWa0VpRXJOYWVISld6?=
 =?utf-8?B?MzIrbHhic2RrS05Vdnd4ejcvc1BQQVdpc215Tmg0cjM5ZTJhUEJVUVN1UVVn?=
 =?utf-8?B?Qitpa2hKZGllUkNNVTZwWkpVdDA2cFpLU3FaM3hacDREZG9na2x4K2N1OEg5?=
 =?utf-8?B?YUROeFZWZTRtS0R0dUk0WmFPaVMrRGxQRGQxNU9QVUNsdHBiR2p2Y05oZDdn?=
 =?utf-8?B?ZVV0MXBaQWtmSGNnekhla0NjUGRyTUlFYmYxS3pkclFRbUovVmIyWG5qdVlH?=
 =?utf-8?B?TUxaSXk0Y1hGcXlJQjBFckNGSDV6MXdTME04NnBDdFNobjRmdWFKWkszcjN1?=
 =?utf-8?B?STk5a3N1WDhRU0ZGL2szeDVtbXNJaFp3aVM4UGd5aUZHVCs1c2dPUzVVbGRR?=
 =?utf-8?B?TmN6NGJyWWV5RjA5VVlpcEZUTzMybVFvVllZMzU2NGFyamxaVTNhRjZQY1cx?=
 =?utf-8?B?aWpwQ2VzN1FYZUxOdXVQVVFTZURqNC9FbjBHcTkyeEoreXVtVXdIbW9sNEM4?=
 =?utf-8?B?czVjMXdrQ0pLdWJHMzVWNkhlQVd4UG8yNE9WeDRRZ0tkT1R1dVliMVh0ak1X?=
 =?utf-8?B?SDR6VThiNWxtR1p3elVCSzU5NXBXUWVBSXg0dGc1VmpTQ3JldElJWE1GS0dl?=
 =?utf-8?B?bEI2elV4dEdmbUlZYjZlaTNjdkVMWmgzdHI1aDRLQ3R4Q0FTOTV2elphRVJv?=
 =?utf-8?B?T2Jnb2U2WUVwa1dDayszdzN0NERnQTltaWFHcHJieXRXNEdyL0FYVUpZNys3?=
 =?utf-8?B?OWxFTUd3bHQ2NFFKcTdGbzdIRGhpK2Z6YlM0eXNQSkRJSm90RTYrNFhCMFhE?=
 =?utf-8?B?a1ZGdDkxQ0k0bmUrOUdUdFpNbFd5MUE0ZThlVXRpRGdDWW8xVExHRGxJN20w?=
 =?utf-8?B?a0doTzQvbks0MVBFS3JVT2h0b1laK0lIRytRR292WVNhR20zaGZHOGhYa25B?=
 =?utf-8?B?Wk1IMTZwUTNxc0syYTFKYWMyZG42SGdNOGU1T3ExVnFreUtDK3FrM1Z4RUNt?=
 =?utf-8?B?TEdnREFFeEwzeXVKSC9yNHI0QXZjMkpiT2pjUkQ0eUlweFFoYS9QRjJ4V1pX?=
 =?utf-8?B?clo3M1pjRngzMjFBbGZhYTM3TFEwZFVBUjlCZnVXd1dyNXE3eHVabzVLTUdD?=
 =?utf-8?B?Tmd0N3RNUEJCbjQ0MjhkQVNWZit0cHhjbFlHYWYyTHRDWHFtWURtZU9CdHZP?=
 =?utf-8?B?K1R6RlRtalI1cVNDeCtXUVYxdU5lZnFsQlFjMUdrczhnTiszVmozc1Y3WTdD?=
 =?utf-8?B?b3EvZjBCajRkTlFWazJ3elpjQ2l5dFVkcTBWNFRkYldudE1mUFdmM0o2UE5w?=
 =?utf-8?B?WHY4S1ltZ01YMDNtRjdESEdOaSsvMTl2c05FdllEVHZvUkcyUE1wOHZUR3NX?=
 =?utf-8?B?YmgxWUFwamtFUy8zd2U1OVJaeVJIRXBtTUVoaC92TWJXd3kwb2lEeFJCbEdM?=
 =?utf-8?B?K3NXNHZYSzlUVXYyamtaN3pOcXNKdWZiTEhSRW0yNEg3QnRkY0ZwdG9EVFhy?=
 =?utf-8?Q?TmTlk0BGBqhz64Vu+nQqgUXj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e20368d-6a51-454b-580b-08de1aed69e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:26:52.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0aEgfP5Gii3A405QDH9WagzArKAW4kJq7KVUdZ4+avO4tsmWvKWYCkvNuztslvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
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



On 11/3/25 16:24, Saleemkhan Jamadar wrote:
> This should not be used indiviually, use amdgpu_bo_gpu_offset
> with bo reserved.
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c       | 10 +++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 3040437d99c2..bc7858567321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
>  {
>  	int db_bo_offset;
>  
> -	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
> +	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
>  
>  	/* doorbell index is 32 bit but doorbell's size can be 32 bit
>  	 * or 64 bit, so *db_size(in byte)/4 for alignment.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b1ee9473d628..0a244f80426c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -93,7 +93,15 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>  		return ret;
>  	}
>  
> -	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> +	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve wptr bo\n");
> +		return ret;
> +	}
> +
> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> +	amdgpu_bo_unreserve(wptr_obj->obj);

The problem here is that the return value of amdgpu_bo_gpu_offset() can change as soon as you unlock the BO.

So that wptr BO either need to be pinned or fenced for this to work.

Regards,
Christian.

> +
>  	return 0;
>  }
>  

