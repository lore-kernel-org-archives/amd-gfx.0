Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976E5C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 18:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F3E10E0BC;
	Tue, 29 Jul 2025 18:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cY//ymGI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0DB10E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 18:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDAk3vxBkIyGXXmQVwqS6bUCJpb7+0MfGv39qnXcqJDfI8Naa9Nj4xqYeY4eopM/Kw7/jtSxv7hSTK96Nq3byO5UrxXQNuJbjOgq+F0s0BhUu8Wazo3+ozQ2CYpPiMP0NMeoFkoIqiBt22MHK8Z1UR3e2h/aDnLyNH8L7DEJR56H8pNg++mS13Sz2oQ+8rAuy1G/lWSiYYDEZZzbbdQLIiLpvcPUjI7lN6cY+5V7LDdWRGgs9yMbx6R0yu5YOMuuUJXyzfly2E1jrHRenY/e2y5g0d6g8DmHhloktsXCE3FqSEcf6js8Htio5xTF3fggSeicSbsGVTTixoFVyEnmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZgTgwEtcvOTKAeDNwYfhECXwKdlX6P2o1Q87eOhSQU=;
 b=ULiz9opyNtsirYsBrjxwWeG/0l0eh0+R6Q3WOBuTFo7uIjItBNK6vGzMemk2eubJReRX5S/9yZD4H3r2grPQenhWGln1Jfqu4UqnhvgiPtt0TE4t3Udo/lFwc0dDU7JEEeNYuKLdZgyLEbgRx8wBxeDvkafnLwgKQgTyWCnzc9mj9B5MIsacff5k59eaSIbf4BrVb1JEkdKTWw3g8iNJ6Ek7QOp63r4vSxjZK8y6TKq4iSOKfxlk9SJ9pRsv/lME/n6rQBr10G5VCOwyfQIYrh/6BLCgPqSlYpbtDGBIIJmXdJ4tk+iCrw6UlOvR9eKzJKDLvXfRC/0nF+NZvAZvog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZgTgwEtcvOTKAeDNwYfhECXwKdlX6P2o1Q87eOhSQU=;
 b=cY//ymGItR+3b05/Dr92nHwV1noQElZ7Y/HzTHeco2IC52WKH3sJZOvEGcAjnabhjIYnpZCU/pm27Le4xXLpu3kOnw5HuqZzM5sOI5SiN/S0nRycqmDnf0zDqNVcXCikI6vjoYNAJqeTe5ibe/R4W3sTydEfnPIhuPJSDYmQnWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 18:06:27 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 18:06:26 +0000
Message-ID: <06c41d3c-2f5a-4368-8b2e-aa718c2af96c@amd.com>
Date: Tue, 29 Jul 2025 14:06:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] drm/amd/display: Introduce MAX_LINK_ENCODERS
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-4-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ad5d38-08aa-452c-b00a-08ddcecaa2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHgweTNsU0Q3bCtzNktiaGFLOVEzWG9DRU1LclYweE1vMlA5akJvNFFjRDFx?=
 =?utf-8?B?c2RvSzRhZzFWQWpPa0p1OHZmY0p2WWVIdkJZc3hkWWQ4cGp4dlhvNzV6cFZI?=
 =?utf-8?B?aUxCcDJJbFRYSlVCL05DRFg1REFrNkFIRThVbytGbkJKR0JFNEpUOXNHNisv?=
 =?utf-8?B?TDNFOVd5UjhHb3pZdDhhSVFoRHNLVmdIUE9TL0RobEExSVJ6Z0dsMExKY2NV?=
 =?utf-8?B?NzQwenlXbTQ4VnVydXY0OWk2c045Y0QySCtBZWFVeHNCVlhQNWUvS284MHMy?=
 =?utf-8?B?enA4TmFJNk84bnc4clNxOHB3RFJjQ29YSFVieGpVYUhOai80R3ZqRU4weU5z?=
 =?utf-8?B?c3pUWVMyTHA1NG1vZ0Z0emhWMG5FdTdiZFZhSmRRSVozalpLV1pxTUVoZTcx?=
 =?utf-8?B?VENaSkdRSUdGUGl6NlRUNEpmd3pyM1puSEtrQVpXUTR3VDlIMmZibjAyN3BV?=
 =?utf-8?B?akZ6ckVVL2EwSDlqbGp2M1VFTWFSWEVneStCcWl0SlhrakhlNUh4L2Y3RDhV?=
 =?utf-8?B?MW5VMVZxczB5N2RjSGpTTE91TExkNDRoUVZjdFl2NmEyQTZMK1FKOXVqaEZl?=
 =?utf-8?B?K3d0V3NwejhTaXY0ZnRSSmhxdXNIV3lGb3ZWWmtyVU5vRGxwMUx0T3k5dXE1?=
 =?utf-8?B?TWdYMDJ0R2JiazNGNUVEQjY5ano4SUZ0R2tpZjhiWm1GQXVISm55djIwbnZ1?=
 =?utf-8?B?UFpMZXNpWUgrV0ZKL0VsZmJwQUJySkRBNlRGc293UXVnTnA1ckFjdnNPdmpS?=
 =?utf-8?B?RWovc1BTdDNqWHArUGRhamNJL3p6cmoyTzlxZ0lsbzJJbzRtWW1NdDVaS0pM?=
 =?utf-8?B?L0RLaWlvMXk4OTZXNjN6NVpOLzhIZ1VNQjhaL25PN3IxVlRJZ1U1M3lTNU53?=
 =?utf-8?B?clpQY2VYQm42djFOMzhDZjV6cUtoSVVvZHVTNG1TQ3ZESC9sYlVSaWloTEM2?=
 =?utf-8?B?Tlgvcyt3a21xcGJBVThHY2I5cmdqQnI4UGZhaGtyY0lGdDNEeFIrOWtYZW9m?=
 =?utf-8?B?OXhqZzZ3RmZ4c3paY2ZYQnUvZ0lTRGh3UHAxZ1Z6MDBid0hMRU5aUktVTCsy?=
 =?utf-8?B?ZjRNcSttWVJsakZVRHNmSE5DcjZBb3RNaVdkd2FhT05qRHpHNlkzV3c3eGh3?=
 =?utf-8?B?MHpXK0lZV2N1RXpQT0llcXgxWEc2aTNtRnUwOXo0RWkwY3p5MDFLa2dSUzhj?=
 =?utf-8?B?MlNKZDh2c0lHak0rK1VGeCtHMGhibk5FUjh4ckJNdlFFNnZ0M3J4bkg2c3FT?=
 =?utf-8?B?U3pVa3JoYWpDZmplVTRyaUF5NmtXNVZNVU1yc0FTSWRPaitqNmY5U002S1Zk?=
 =?utf-8?B?VWd2OUxiMjJmUktzZlVBZzNsNCt6a21qREVmdm1YNUZmOW52aU8xSXM0OEtx?=
 =?utf-8?B?emhBZUhIbGd2djJ5SkFJVlBlUVVuVHBCeStFaUNwMks3SjluRGdBbktKRTdL?=
 =?utf-8?B?VWp0Tmwzd2hOdHNlVjgwNEw4eWJSb3VWR3NSYUE4c28zTXZib3R4TFlENU91?=
 =?utf-8?B?Q2xHSkFVYU55NDFPMHgxOXpKTkdKZ2JySzgrUXFoL1ZBRUdGWjk0OEpMUm9X?=
 =?utf-8?B?c0ZXWEZ6UXl3ZVBZaVVjQ0NIc3BhZlVwMllReXJkbWRiL09RQ1VmZE9SbEhT?=
 =?utf-8?B?dFZWc1JDMVZ3emU5Z3dtZFRGOE1ZdFpzZVdNYTRSVVpudkJGTmRTNldURWdK?=
 =?utf-8?B?ZDdPUUJBbE9qZ2VreEdSMjU3MGdqNmhQZjBudjAyWFZDN29icjBzREwzVi9i?=
 =?utf-8?B?MmJmNUh6MmR3OUp5OTlBNUVKNTNacFlrU0xRZGJMTlZ2VHJRVnhHRkdhUENp?=
 =?utf-8?B?c1JQbjNZNndsRzIzdUZvdkVQbjhoMzFWRFhGQTBxL0NyRWNiN2N4WnFHSTh2?=
 =?utf-8?B?dTVvcDY1bDZKS1FpMjE2bDBRaVdGUHBVUEpvTExhcnNZdVdZZVVQYmltelpN?=
 =?utf-8?Q?buUzLS+gBk0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGk2bGZRaVNCS1llQllXdkEzVGljNmFDekduSTV3emlHS3VteGI0L1Z2MzR0?=
 =?utf-8?B?eEduNnBKT3NkWTVMaWF4UHB5eVRocTAwcTRWQVdGK3lCd2tDNDlqaEtjUkhB?=
 =?utf-8?B?Y0gzOWpuSE5SOHpGV2MvNXQvbFhZekpnYkRLQlFPQzhYdCtDWmFtbFpPNzdM?=
 =?utf-8?B?R3h5R0lYMXB4K0JiUHFuUGtKMnREQndOSkdFT2Q4cEZRNFZEOHBKRXJnMVNh?=
 =?utf-8?B?UFNaNUNBY2t1eDlyclFyS0xqMW5TZktweTJJUVMvNG9JQ2UxaEZKWTExK1RW?=
 =?utf-8?B?VVozakJPeTdyK0t0aCtIS0oyaUtiVWZRTmtwK0lkTkJUMUdnZ2t2ZkZRWUlQ?=
 =?utf-8?B?MGxBTXlVUExqbFRTMncvYTRjUm01WkJnTW5wT2J6Y05qY0kzMnlpeldSNHJH?=
 =?utf-8?B?M0M0Y3lKTlN6SlI3WHUzeElucXZnd3hrd1N2SjJ2SXFJeFErYVhxK1hBNlRU?=
 =?utf-8?B?UDNpQSs4ZU9Db2FjNm5GWWt6Z0s3VjA5clNWaTdidTBHcGVpL0hNWFAxZW1r?=
 =?utf-8?B?UXJDZzRKSGVLLzZLS0loSDJWQmNnQ3pHbmZPSWdCa05VWU4yek9Ed1RLWGh1?=
 =?utf-8?B?bzVtZkpNZ2hKUzRjNyszc3diRFRGNGRxK0tNaWVWQ0VoejRaOWp4OWtCNks2?=
 =?utf-8?B?VFllRUl1R0kxa0g5bUhvMG9OWHpkZ3p4c0lWVTVHVmdYdkhDWnA3YWo4ZjNI?=
 =?utf-8?B?WS9hdXN2NXA4cnlCb2RXWEJHU2lUZXZFWlcxNUZuYUIvaFZQNi81TnVxUmhn?=
 =?utf-8?B?bDFoZUlGeUpFaVFCem9uNnBvVnBncldJNmhLaUl5b2FCMGVyYTJZcG8yWHY1?=
 =?utf-8?B?c21yVDBPWk83RnJqdjlwbHA1WXQwWGFLOGpKb2lId2NvNmNFZlcvQksxamZJ?=
 =?utf-8?B?Uy9hUUR5NXNRT3VTOUV2amJmdW9KSEMrU0ZySzhFMkxmMy9lSGVIWmI2RGZQ?=
 =?utf-8?B?cDhkRnhpMWNyRlp2a09JalpWY2dRek9zakFyNzBvZnFIVjBZbjMwcW9vY0Qx?=
 =?utf-8?B?SEJtNWVkN1NHTjdDTWFzU1VvTG5tQVhUV3pKMkQrSk90SjMvRmZHN0FTMnRr?=
 =?utf-8?B?MndRUmJrRzBNWS9pMnlSdGdjblR3cTJrZnBNemdlVGQ3SldwQ2lGSzhXTS82?=
 =?utf-8?B?VmIzZzMrekxjejZPVXV0dmpUeXR1dHkzaU9LdC91M0hGTWErdnpJTXRoNG50?=
 =?utf-8?B?Q1VyWWk2MTBuK1BQUGNFT2N3TkZOREc5VlpYM0JELy9qK3dHdFB0LzBsM2FP?=
 =?utf-8?B?SGdMMDZQOUpNbHFoUS95TmFOSVc3S0J0YitnSjdZeExudXNmd2ppZ2t2SGZ2?=
 =?utf-8?B?Q0JheDBldlp2SVVER1VlOHZvRWFMOFlsbjN1NkMxV0ttN2ZYUHhEYXpqT0hu?=
 =?utf-8?B?cGtWSDlMaVYzVDdBbTNJcldkSTV0WldUNWNzdVoxWmJKbkQyZ1hvc2p6Mkdo?=
 =?utf-8?B?VGRiSlZ6Y3o0alRGc2tNSDRXZk5iTUl0Z2xzRUt4djBOajFMeHMwcGZ5MVJC?=
 =?utf-8?B?ZWJ0aENmMmI0RXlSenpFQlJrNFBobHVEdXIvbHVGQUZRYUdhM0RVSU9vVnow?=
 =?utf-8?B?Q0Mya1pUZDRUeE9WT25GOWNoQmM4M1dVSUgyTklpUlBHU3VHN01sZTlWVUVv?=
 =?utf-8?B?UHQ3cUpwQ3I0MUtpR21PdWxhaWFETnNQKy9CVjhQazVDajY4UUloSldUVjV2?=
 =?utf-8?B?cVJVajErWnc3UHhiVzk5aGpReTJjOENxYzU0cjJMd0YwclZmWjgzZE8xWG9k?=
 =?utf-8?B?elVjV2dMZUtKTkhndWpFS3dnMnYvRUtRN3FJejVkN1hUMHNGOEJYc2hGUmw2?=
 =?utf-8?B?NEJTdmFTRXg0djVyTlVCdGZmYlBjQUNwQkJyTVV3dDBMYys1OUxtWlo1REFO?=
 =?utf-8?B?azkvWHRNcHVUQXBnS0RKY3lDaHRPTnJZVDROeXp0UTZZZUNSYW8vVWU0Sndq?=
 =?utf-8?B?Q0pZY0FwaFlGS3h2NC8vWjdyeHVLa1MweC9ZemY1K1haM0V0NmZVRzl5d1F6?=
 =?utf-8?B?YmE5OE95VjdIRTR0eXAxbFdtdU1QZ3dJZS9ENTZIVWZWR3dBajV2Y3ZNL2RN?=
 =?utf-8?B?alVaOVBUdE9ZenBWQWNRMUlSa0ZyVXIxQTFDQ3FoczlnWk92ZHV1KzJpd0Ir?=
 =?utf-8?Q?VjkgssHgPdg1CE0H5HWeq21Mv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ad5d38-08aa-452c-b00a-08ddcecaa2aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 18:06:26.6224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHE+KdLbFc5zsSgpBDC6jvyMITTueDUM2kESNVvsFP58u5VuFA2eoxYH6WRbM0OJIih/MkT+FlGVh5T4muYIVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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



On 2025-07-23 11:57, Timur Kristóf wrote:
> We are going to support analog encoders as well, not just digital,
> so we need to make space for them in various arrays.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  4 ++--
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  8 +++----
>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 24 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> index 814f68d76257..d86482611b3f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
> @@ -522,10 +522,10 @@ struct link_encoder *link_enc_cfg_get_link_enc_used_by_link(
>  struct link_encoder *link_enc_cfg_get_next_avail_link_enc(struct dc *dc)
>  {
>  	struct link_encoder *link_enc = NULL;
> -	enum engine_id encs_assigned[MAX_DIG_LINK_ENCODERS];
> +	enum engine_id encs_assigned[MAX_LINK_ENCODERS];
>  	int i;
>  
> -	for (i = 0; i < MAX_DIG_LINK_ENCODERS; i++)
> +	for (i = 0; i < MAX_LINK_ENCODERS; i++)
>  		encs_assigned[i] = ENGINE_ID_UNKNOWN;
>  
>  	/* Add assigned encoders to list. */
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> index f0d7185153b2..55daf348293e 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> @@ -274,7 +274,7 @@ struct resource_pool {
>  	/* An array for accessing the link encoder objects that have been created.
>  	 * Index in array corresponds to engine ID - viz. 0: ENGINE_ID_DIGA
>  	 */
> -	struct link_encoder *link_encoders[MAX_DIG_LINK_ENCODERS];
> +	struct link_encoder *link_encoders[MAX_LINK_ENCODERS];
>  	/* Number of DIG link encoder objects created - i.e. number of valid
>  	 * entries in link_encoders array.
>  	 */
> @@ -508,7 +508,7 @@ struct pipe_ctx {
>  struct link_enc_cfg_context {
>  	enum link_enc_cfg_mode mode;
>  	struct link_enc_assignment link_enc_assignments[MAX_PIPES];
> -	enum engine_id link_enc_avail[MAX_DIG_LINK_ENCODERS];
> +	enum engine_id link_enc_avail[MAX_LINK_ENCODERS];
>  	struct link_enc_assignment transient_assignments[MAX_PIPES];
>  };
>  
> @@ -520,8 +520,8 @@ struct resource_context {
>  	uint8_t dp_clock_source_ref_count;
>  	bool is_dsc_acquired[MAX_PIPES];
>  	struct link_enc_cfg_context link_enc_cfg_ctx;
> -	unsigned int dio_link_enc_to_link_idx[MAX_DIG_LINK_ENCODERS];
> -	int dio_link_enc_ref_cnts[MAX_DIG_LINK_ENCODERS];
> +	unsigned int dio_link_enc_to_link_idx[MAX_LINK_ENCODERS];
> +	int dio_link_enc_ref_cnts[MAX_LINK_ENCODERS];
>  	bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
>  	unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
>  	int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> index 41c76ba9ba56..dc9b9f22c75b 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
> @@ -45,7 +45,31 @@
>  #define MAX_PIPES 6
>  #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
>  #define MAX_LINKS (MAX_PIPES * 2 +2)
> +
> +/**
> + * define MAX_DIG_LINK_ENCODERS - maximum number of digital encoders
> + *
> + * Digital encoders are ENGINE_ID_DIGA...G, there are at most 7,
> + * although not every GPU may have that many.
> + */
>  #define MAX_DIG_LINK_ENCODERS 7
> +
> +/**
> + * define MAX_DIG_LINK_ENCODERS - maximum number of analog link encoders

_DAC_, not _DIG_

Harry

> + *
> + * Analog encoders are ENGINE_ID_DACA/B, there are at most 2,
> + * although not every GPU may have that many. Modern GPUs typically
> + * don't have analog encoders.
> + */
> +#define MAX_DAC_LINK_ENCODERS 2
> +
> +/**
> + * define MAX_LINK_ENCODERS - maximum number link encoders in total
> + *
> + * This includes both analog and digital encoders.
> + */
> +#define MAX_LINK_ENCODERS (MAX_DIG_LINK_ENCODERS + MAX_DAC_LINK_ENCODERS)
> +
>  #define MAX_DWB_PIPES	1
>  #define MAX_HPO_DP2_ENCODERS	4
>  #define MAX_HPO_DP2_LINK_ENCODERS	4

