Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC95E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 09:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDEE10ED1E;
	Thu, 12 Dec 2024 09:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qs9c9bx2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373AB10ED1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 09:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6NZYf3Gf6esl1YkdKLgEyjJGh+J4RG9oLCNOUDqLaUY2mmUCtauGpRKRc23eg7JRsDZ29YlnPofA/HXrFgw5xQOVX3x8KHIyxpW7lfgOi3BMEAKVqk2GOTxpi1rSx4FkoJcnsKX4+7N4VwCBSAegVinxCS236+bwcHNjLIx3VWD9/IAth7CPBoyuaXdy21QS0Y1QEAn+clQZ1bDYZl4pB8MCtAXulBPW966KWe8eyvGgxkKij4S1ADnjvWfVaapgku8L8LhiD9j8aaao12AeCvNIEx1rhM3njFPoCZy9VG8GlmbiBm7XRo9VgxaE25I1CG9FlMrcTMA6qwNsicglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LeYyI7MFY2xMRtSDsW3TzJ2RHhTLP8fTMYS9fVdbWA=;
 b=b7I1YoId3Lljyn4W0sqQdW5Kqr32XxOQAQO67bl5UzKuhcRzSrzax6zs7VXNp2E/NLB1s5SL8FmsxDNGLMLSY+Sz1YXoJAHZw1K+zAi43MZus9Ktuo9ZY5R3NpclL/TD0NranRSfNXpVOgEP+m685Qc8yQkO9gyUHu/CKhvoAiwEXFFmxacJv5Sh5oTzD7X0xwMf+UP1NHp8pvssJRZRGPllOWtlFlXpgdTQgbzZh1FpOYnXVMBCX5rmp+JCTcui/e0VeBnPYks3a/1bSOu0GZWUUYUlLO7QkZOLvx6URjrqsT1EFo43zO47itCmxXw/PCgR/tBnvKR5VVrDLjqsaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LeYyI7MFY2xMRtSDsW3TzJ2RHhTLP8fTMYS9fVdbWA=;
 b=Qs9c9bx2lE2Xi7LqrjTlQIXBH+oW7mHdu6IzbkIRciRA5Yii0hSGJdn9/VNwCpU87UsmtzzAcYqRop14TgfCtR76p+kWEwJ8vF7felaAUL6/VVtubD7X5/or9IFLPkU9oLtiO0yeZYiSYYdsn0IS+QK0hbBXYCpIwGROXqRwij8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 09:47:13 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 09:47:13 +0000
Message-ID: <fd21fe0d-ff57-4903-8cc0-1810570dec3f@amd.com>
Date: Thu, 12 Dec 2024 15:17:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/48] drm/amdgpu/vcn2.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241210225337.75394-1-alexander.deucher@amd.com>
 <20241210225337.75394-15-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241210225337.75394-15-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: c627c453-0ca3-4a29-737e-08dd1a91f463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akhmNklsTTZuREdPeEJZV0VOc3ZiK2hsYnhNcU11ZlRqV1ZpYTFHclVXeGRH?=
 =?utf-8?B?bzQwUFRIVlcreVdTTDFCSFRpQXlVclFyWGVHWWIzbGV5bTZYc085MTFNcktF?=
 =?utf-8?B?a1I1NE92RHpDZ2hnU3BwbXZmSHZwdG5tbGhDSXFud0NQbU0rcndNeExyc3hq?=
 =?utf-8?B?Y3VPVCtTbWFkYVM2dzMxNzNKUGxyN0hXbENLTFJyYVo0QS9KUWJhRE5OMzVH?=
 =?utf-8?B?ZGVlTDEyV09xWVhlVVpxZzdrVkhRRVRBSnlseDJ3WFlYQXhCS2RucmxmdUtW?=
 =?utf-8?B?eS9OOUcvY2FrMFZueTgrRlU0bk9OSGFLR3BBdXlYQjVyeUZLSE81VG5TUHl4?=
 =?utf-8?B?QWxBWGV5dzJ3Q09iRDRZUDZuQ01SRSswZXdmM2ozblRnMEE2RkZCR3FNbFdn?=
 =?utf-8?B?TzgyMmJVVTN0dG9GVkFsNWVYSWliU1R0NFdJY2xVSCtQd2ZVbTB4aTVJTElh?=
 =?utf-8?B?cUFUZEo5TTZ2RnFMblpXeEwvcUNsdkE5NzVoMnpQVDkyWDZuamNKK1duQmFS?=
 =?utf-8?B?SXBWbCtxR3hjbUpBZDB6VHljajkrRVpqdWQwYUYwc25nS3BDa0ZNTS9WdU9W?=
 =?utf-8?B?cnJxMW1oTVhsa0tKNnZ3TGw2amFibzNXYXE2cDNmdW10L3pzMHpteldKMm8z?=
 =?utf-8?B?TEdMNXJmS0czU0JZR29WVWRDRnNobUcvUWh5R3ZZOGNpR1JWVTFQVy9HOVRu?=
 =?utf-8?B?UTRjV05sbHRucVpXOXZZbmNWKzF4QTlHYTlJemFJYWx1c1RxcW5mZDI5c0s2?=
 =?utf-8?B?enoyQ1NmcWZlaStUNTdWbTBQeUswQzZGdXdBb1VuSm1sdCtaS2luZlh0M0tn?=
 =?utf-8?B?QWJrRmpVUnhqSmlmOUJxaGNDdi9YR2lKMEVHVEJFd3JyTnBtcFd2cmxYVko1?=
 =?utf-8?B?a1M3SWN2V1NqUUlTd3BrVjdCZllVRDM3U3NaVlZSRXNocERSdlVlbEtpUTdC?=
 =?utf-8?B?REw4ZXM1bXFUbTAyVm1MZlB0R01LV2xjUHZFd2N2U3VUTzY1T3lHOThoVDNk?=
 =?utf-8?B?b0hneHlDZWphUDdKdmZwaEpvU2w1K0o2ekUwZHUvUVJ1Szh1N0NGSTRvOE0z?=
 =?utf-8?B?aXJncEl5K3p3clRLWVh6aHRZbUMwcklkTTFhN245c3dYMzRkWXhwRExrVUJN?=
 =?utf-8?B?b3VwVVpmcE1SQVBvb1ErT2JjR3QvMlVwSUZBWGRLbE9NYXFpeWJTcDZjUWM0?=
 =?utf-8?B?V0VidjRnWDVHK2l2WnBvQ3dleU1kMVRjOUNiM0x2UEU4aWdEenM4aUdka3N4?=
 =?utf-8?B?OERBNGthMDJsb2NVbUJaSE5kMEVENzFjVmoyeXNySXd1b2VHcnBNd2Fvc1ZQ?=
 =?utf-8?B?N2xUVWNqNnJ4L1g3MHZKMnRZMnJ0M29NNDdqRkY1ZVQ4MkQ1NEZ3TmQ1dEN6?=
 =?utf-8?B?MDY2SHRwUW9SZFhtdUpZV1NpYTM3UnN0blFTaW03K293R1JkNDNFOXl1Mkwx?=
 =?utf-8?B?Q0plY1F5d3dhSGNjTlJITjA3a2piZ3dVQU93VlFBbEE3eDJsSktGeEhvVzV2?=
 =?utf-8?B?M2NRKzc2MTJCS2F4NENITlluMGJaaGhWdnJzQ0lET2RzczBTaHovV3V0MTNq?=
 =?utf-8?B?NjRpWXhvcEFlNXZHMWtyaVEwQnNCRk1Nb0hCNnFrK2dNSnVkVDB3aUJDS1RC?=
 =?utf-8?B?NHhENnZBaFQ0Y2FtMjJ5N3ZTdEFoQ1I5US9kNlpFS2Zob3lMcGxXUnhhd1Ur?=
 =?utf-8?B?ajBZcGZzb0pMd3NIRC94RWtsSktqWktjRXI4N1FmUk5FQng5ZGVUNERndDB1?=
 =?utf-8?B?aFh2MWZXUzJXSVU5L2ljYkhUUHJQa3VvTFpQNEJiTzlvZ3IrMHB6TVpMb0Ji?=
 =?utf-8?B?cTErTW9uaDVhT2todUhDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2pqbWlSN1lic05aUklWaStERFpaM3lETzVZeFdub29FdW51ZFovL0p2elRr?=
 =?utf-8?B?TThGZlNESDdwRlUwWkJNazhHYW9lemxzMFhkRTg1OXcxWEVCajV3VWdUNmZO?=
 =?utf-8?B?UGxEWVZ2TmFQY3p3bHVHRlorQnhFamFDd1JIL0hvZFhHMlZTWkpUMEVOYnBO?=
 =?utf-8?B?aW1CQXFncXVIb2h3ck40U3gvSU84U0hGSVYzMjNyRU9OWVFHcmovbjdGWXFp?=
 =?utf-8?B?ZUdEbzF1ejQ5ZmZIZ2E4dy93cVg4SkIveFVhN0c0MHVFbHM4c3V1dXB4Z2Fa?=
 =?utf-8?B?OXV4eUZLbGpLaVFWMWN1bHR6T0UrbVFPLzlGY0JYa05jRnNrZ25vSlVpSHpk?=
 =?utf-8?B?WmlQeVBkVTI0SEI5Zk95VDRYUll3c0NQNUFnQVdCRjdjeWQ5VmtuTDY3M3hP?=
 =?utf-8?B?dUtVaVI0OG5lZWZHWTh3dGxjQ2k5VXU0L0pMQmsvQ1B6RGNxNTJ3N2RsNFNG?=
 =?utf-8?B?U0VEa2RTM09yVlgva0J5cGZmMTZDZHpOWTBYdXFIQTZrQ215d3EwRUo3ZUwz?=
 =?utf-8?B?SlB2cE1najdHcmpuZUdlY0JQRTczUlpNTUI4SmE4ZVBXM3NjNnFXdCtmRWNV?=
 =?utf-8?B?TXRtZ3FCMW1oOWkybmtsTXRSUjlXZ01uSWRXdlZ3bGhnb25VSGpOL1VGV2tl?=
 =?utf-8?B?TTNCV25LQ1c5ZHhZSVU0YkQ1a2hrSEQ5YVdEZG81bGNRQlZ3cVNyYXIwang5?=
 =?utf-8?B?N284NlZGanJBejR0eXdmWHI1Zkw3S0UvQUV6eUZhd3Y5VGVKQXFEbk15ZjFk?=
 =?utf-8?B?RVZrbStiTERCdW1mdGtrbjF1ZG9reEdub2prWHZaRFg1RTl1cGhzRXZCN043?=
 =?utf-8?B?K2EzRXZoSUl4UHNoN1IzeGJVTlI4aHQ2aHArb250SEZPYmtTc2dOZDdvTTVi?=
 =?utf-8?B?QTNBbkEwaDZqL0lBaDVUbUwxUlhqbmZuaWdjZmduQmtVUmFZaHJXeXpRWk82?=
 =?utf-8?B?NzJvNHdxWkpiWEVIL3FBL01nYktJN1lRWTgzcVlWVFJTcUVIM2FRNlVvU0x6?=
 =?utf-8?B?dlpiRVQrR0dYUUN0eFl6MXZUckVoQWlqTnM1UUNuMzNWU3RndlZ0R1ZNVmpV?=
 =?utf-8?B?cVZrQlBReFZEeXlobC9UQm9DVFRtME5nVG5TaXFKa05MK1VYMktQV0ZtSmMx?=
 =?utf-8?B?L2w3S092K2FpejA1UHBJbHZMcHhOQXk0MklKTS9CZnZOSlVFVVVzRTBHelY1?=
 =?utf-8?B?UXQ1aGxNVGZQNzFrdVh3Q1U2cUhmamNlRkQyc1VocHh6OC9oNkFRWkpieU1C?=
 =?utf-8?B?YTgyR0pzU2EvNWhJSk92NmVPclVtOUR5SENTNEdBSmlnVmdRNk82eVd6dFNM?=
 =?utf-8?B?ajc3MUlLeURnYlFKOWxrQlBTMnhEZ3RZRHBwT0JWeU85OEdTeVlwcXY3d05M?=
 =?utf-8?B?YzE3NlVxNGR1cFZhbU13ODRjcjFMeDJJZERmN1dFaFp0bnVLR2wrby9lNTlU?=
 =?utf-8?B?Q29TZHZJWjNIbmU3WnA2VFZna3B4eDVFR3pkSGVZZWdWNEVCYTJiN2RqWWhq?=
 =?utf-8?B?RTlaOUZsaW4vZk5uMU5TUHRHazljS25RdWFIb3dvR3hvQkxzaWQxbEErSHNm?=
 =?utf-8?B?RkhiWHRNUXE1a2YzamVWbksrN2wweUc0b0c4TVp0dXdtNUIvMU01d0lNYlRH?=
 =?utf-8?B?SUZEWjk5RHYwM25uREYxUWRqSlZweG9GWFpoWFJmSFRyd0pVODFFakdUODRw?=
 =?utf-8?B?d1Zmc2hIdXJkZkFVR20zeDV5YVVBT2NIdDl0SjFlSkVIdEFad0sza29Sb1Vt?=
 =?utf-8?B?VEFXT1ArNEFMZGJzYTA5MDV1NkVIMFBPelk4ZXVFTy9SUUhheU5VMVRJK1dI?=
 =?utf-8?B?bnl4VVZaUmRIZ0dObFAwam4zeUs4Vzdwa09OSXA4QXByYTgyejJud1NrM29H?=
 =?utf-8?B?bWRXbURHTnRuTTZBSWpaVVlVQnZTNTZrNWtHSXAycDFwYmR4WmYzaXdQMkJq?=
 =?utf-8?B?OC96RGdZQ2ZaVThxVjgydUk0S3VxVCsvaFkrd3VZblJwM1hTZWZUb1lRRlJh?=
 =?utf-8?B?VkxJZzVJaFdjaU9rOUI0aXZTSmJSVVBNajB1Y3BLcU1CTkdKVXVUVEpaUnhO?=
 =?utf-8?B?cWtGbGdUMklIRllDMnp1SlpaVG85d2dKTGQwMk9qako5cE5jOXRCWVJ2ODBZ?=
 =?utf-8?Q?LBhSP6JoB7MqSm2hsOZ5YbSB4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c627c453-0ca3-4a29-737e-08dd1a91f463
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:47:13.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj98DTYu0+BdP1PD3pDO/osRR8pgYilK4iJ/DdUdsP0q+LwaH/1uYZg+7nncbmjf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938
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



On 12/11/2024 4:23 AM, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
> 
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 66 ++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 3902e0d239d8d..b42b369a386da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -370,8 +370,9 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
>   *
>   * Let the VCN memory controller know it's offsets
>   */
> -static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
> +static void vcn_v2_0_mc_resume(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>  	uint32_t offset;
>  
> @@ -426,8 +427,10 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
>  	WREG32_SOC15(UVD, 0, mmUVD_GFX10_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>  }
>  
> -static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
> +static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					bool indirect)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>  	uint32_t offset;
>  
> @@ -525,12 +528,13 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
>  /**
>   * vcn_v2_0_disable_clock_gating - disable VCN clock gating
>   *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>   *
>   * Disable clock gating for VCN block
>   */
> -static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t data;
>  
>  	if (amdgpu_sriov_vf(adev))
> @@ -634,9 +638,10 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
>  	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
>  }
>  
> -static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
> +static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  		uint8_t sram_sel, uint8_t indirect)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t reg_data = 0;
>  
>  	/* enable sw clock gating control */
> @@ -685,12 +690,13 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
>  /**
>   * vcn_v2_0_enable_clock_gating - enable VCN clock gating
>   *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>   *
>   * Enable clock gating for VCN block
>   */
> -static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t data = 0;
>  
>  	if (amdgpu_sriov_vf(adev))
> @@ -743,8 +749,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
>  	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
>  }
>  
> -static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t data = 0;
>  
>  	if (amdgpu_sriov_vf(adev))
> @@ -792,8 +799,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
>  	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
>  }
>  
> -static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t data = 0;
>  
>  	if (amdgpu_sriov_vf(adev))
> @@ -834,13 +842,14 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
>  	}
>  }
>  
> -static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
> +static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
>  	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>  	uint32_t rb_bufsz, tmp;
>  
> -	vcn_v2_0_enable_static_power_gating(adev);
> +	vcn_v2_0_enable_static_power_gating(vinst);
>  
>  	/* enable dynamic power gating mode */
>  	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
> @@ -852,7 +861,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>  		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst->dpg_sram_cpu_addr;
>  
>  	/* enable clock gating */
> -	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
> +	vcn_v2_0_clock_gating_dpg_mode(vinst, 0, indirect);
>  
>  	/* enable VCPU clock */
>  	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -901,7 +910,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>  		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>  		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>  
> -	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
> +	vcn_v2_0_mc_resume_dpg_mode(vinst, indirect);
>  
>  	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
>  		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> @@ -969,8 +978,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>  	return 0;
>  }
>  
> -static int vcn_v2_0_start(struct amdgpu_device *adev)
> +static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
>  	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>  	uint32_t rb_bufsz, tmp;
> @@ -981,16 +991,16 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>  		amdgpu_dpm_enable_vcn(adev, true, 0);
>  
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indirect_sram);
> +		return vcn_v2_0_start_dpg_mode(vinst, adev->vcn.inst->indirect_sram);
>  
> -	vcn_v2_0_disable_static_power_gating(adev);
> +	vcn_v2_0_disable_static_power_gating(vinst);
>  
>  	/* set uvd status busy */
>  	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>  	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
>  
>  	/*SW clock gating */
> -	vcn_v2_0_disable_clock_gating(adev);
> +	vcn_v2_0_disable_clock_gating(vinst);
>  
>  	/* enable VCPU clock */
>  	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CNTL),
> @@ -1034,7 +1044,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>  		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>  		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>  
> -	vcn_v2_0_mc_resume(adev);
> +	vcn_v2_0_mc_resume(vinst);
>  
>  	/* release VCPU reset to boot */
>  	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET), 0,
> @@ -1142,8 +1152,9 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> -static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
> +static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>  	uint32_t tmp;
>  
> @@ -1172,13 +1183,14 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> -static int vcn_v2_0_stop(struct amdgpu_device *adev)
> +static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
>  {
> +	struct amdgpu_device *adev = vinst->adev;
>  	uint32_t tmp;
>  	int r;
>  
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v2_0_stop_dpg_mode(adev);
> +		r = vcn_v2_0_stop_dpg_mode(vinst);
>  		if (r)
>  			return r;
>  		goto power_off;
> @@ -1230,8 +1242,8 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
>  	/* clear status */
>  	WREG32_SOC15(VCN, 0, mmUVD_STATUS, 0);
>  
> -	vcn_v2_0_enable_clock_gating(adev);
> -	vcn_v2_0_enable_static_power_gating(adev);
> +	vcn_v2_0_enable_clock_gating(vinst);
> +	vcn_v2_0_enable_static_power_gating(vinst);
>  
>  power_off:
>  	if (adev->pm.dpm_enabled)
> @@ -1348,10 +1360,10 @@ static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  		/* wait for STATUS to clear */
>  		if (!vcn_v2_0_is_idle(adev))
>  			return -EBUSY;
> -		vcn_v2_0_enable_clock_gating(adev);
> +		vcn_v2_0_enable_clock_gating(adev->vcn.inst);

Consider &adev->vcn.inst[0] for readability.

Thanks,
Lijo

>  	} else {
>  		/* disable HW gating and enable Sw gating */
> -		vcn_v2_0_disable_clock_gating(adev);
> +		vcn_v2_0_disable_clock_gating(adev->vcn.inst);
>  	}
>  	return 0;
>  }
> @@ -1818,9 +1830,9 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		return 0;
>  
>  	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_0_stop(adev);
> +		ret = vcn_v2_0_stop(adev->vcn.inst);
>  	else
> -		ret = vcn_v2_0_start(adev);
> +		ret = vcn_v2_0_start(adev->vcn.inst);
>  
>  	if (!ret)
>  		adev->vcn.inst->cur_state = state;

