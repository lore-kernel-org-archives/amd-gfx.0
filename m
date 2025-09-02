Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313CCA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 15:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070EE10E7C4;
	Tue,  2 Sep 2025 15:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k649dzVZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7798E10E7C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 15:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9jngni4KayKAwzdBfnFyRqoMLr344jcD9JAfOqTODghPRnYiZMXY3Thbtlo5r2arJaUT+XMpcwssHCt+V807zXzytC5l7Y6JjkZrf6W2BmMiuPXKpo4yUJIiej7vVvaV8rnUDbK5iompMFQoYx1AhGzO5/JaM0hN3faPmaCeira0c4lDXWWDzVBR5Z63V/zJxax7e4NYtuUMajwUDW3l+caMfmIcYUX7jSMbMT0FN5Aq8Oa1v0q9Z9z4ZnIX+KB5furcF6epfXamd+kbMQhSfrVXkCevJ+paY9vl1x+WOWaNpHbwfv/PsDTJbYA9jXMvgtSsn8loNBjt9rwuNdTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHToWyQ8w1/MvHK8jaFLjO8Tg4tE0DrxvlK6kduN26o=;
 b=RLl6k/lOCxqcbDtO42Tv4Htzp1CE5PLx78Q7A7L10rrSAQH+kGOrPTqS9JXdwZmM4ziZF/AncWE69N15cKAjPpHrluSju50PcLOHkke4hW0bCh9pZVfgdPmPY9QtaKxovOgOcBUzuEanaGaxLrB6pkKDl1NXGABE2KiO0Z6VXjXPhatJhItE+0eZQ/k26ApHg/3w2fcKT7sLI2+FqvL+465JBj8+DXS8EDzD8bQ078+ACa4YOSeOBW3SBjIYlimUhQF+R+2LB7RdrbkkkSvL+R3adBo3+Bin9bj0EMc+wEvVf1+fByMtx8+nE9DKSBYFpwi1r/WbQ8/PxxJ7O70byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHToWyQ8w1/MvHK8jaFLjO8Tg4tE0DrxvlK6kduN26o=;
 b=k649dzVZzAaEHu3Ogz3G7o1TKXCXGTFSOsPJZh2kw2ldcDRdPWwi8O1DAWakE+I/TnFVI5PHPHBz4ONLWjM4leQTS9tvKVi59fuDBlXJwglxiQPeTRek2XxFc06EvR79OgpYvB9sAAmCuPg6KFjU8xM+vToDgIOxLKF50/rIVoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:48:07 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:48:06 +0000
Message-ID: <fc04a871-ca55-4104-bedc-01581b36a646@amd.com>
Date: Tue, 2 Sep 2025 11:48:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Re-enable common modes for eDP and LVDS
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
References: <20250828140856.2887993-1-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250828140856.2887993-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: a066d8c1-12dd-4d9c-48da-08ddea381c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9LL1V1WWlYZjBVQisxSGpVbGhKdk15SzRQZ1ZjaURsMEp0MlBVeVRUT1dx?=
 =?utf-8?B?K2xvcFFrSGlFYVFBOFdCZmxwbUNuRUQ4bm02bENjSDlXdmtsZzBMMXc4dWZ2?=
 =?utf-8?B?eDJ3U0g3NGNVNE8xNkNwZjkyVTlpZzNkYmN6TFpRbjJENzB0eUVWR25HQk1o?=
 =?utf-8?B?eExCQmJ1YzNKeDFPSmhqNXNGTmR4b2YwVGlKQi9BNFNpdElPRkFJdDBnNHZB?=
 =?utf-8?B?M2RoMG9yWHczbzFJZTd3NzZydGdpemtyVXZ2VjRPR3N3WGgyUElWV0FITTEr?=
 =?utf-8?B?U1liWnExQnFobHFHSGpZM2hEL2ZaNDA5NG5IY2xnd3N0UDRVWlJDMzlqMC9q?=
 =?utf-8?B?aGxPL1dwL1d1dTFET0prWkRLNnd1NnF1ZitBMk8xeGdlZEpiaDIxT1BrRk9F?=
 =?utf-8?B?SzY3QmlVYW0vRzFaWGR5enRHR096Rm5Sc1hhaFdqL3BMSlprQzhpZVoxamRl?=
 =?utf-8?B?SGZHa05EblJEd0JMVnd0N1pmUnB5OVU4RUc1MU43U3doa2NSRW9OeGZnRHNN?=
 =?utf-8?B?b0piRGtOd0RMNHYxWGpXZGNKRk5LcWhzTDRHRms2QkI1Z1ltbVZIYkpTN0pV?=
 =?utf-8?B?M0pHZStQVDB6YlRDYmRFRm5QNVB1b09JRWxHMTFxRnA0MmMvc3hNdlpZQ0th?=
 =?utf-8?B?VWJXOG5HcStibElZclJSYmVRNEJXRlZVb1VabjU2NXhqSEdQZHExL05SZC9j?=
 =?utf-8?B?SXE2UDZUOWJIei9YSEVVNlBCRkV5cmFiSHRjZzN4M2tvNkdKVUlDTGlOeG5w?=
 =?utf-8?B?VThjT2hCSU5kdEhKQlFYOEpYWElaWWJFclRqTEsrd2hpUWg2TkszZXdPc2cz?=
 =?utf-8?B?T2tlZW4zUDAwa0Iwdm1FdmJPMGc2RmJqbnh6ZEN4V1ZTdmtrOE1TSXpIeURN?=
 =?utf-8?B?YUI1Y25IRkYvUCtuV2ZobEhTZkNjWjQrU2pVM1o4dUxzd2IvMFVjaEk1TjdH?=
 =?utf-8?B?SlpQNy82Uys1QVpsRGxVamgxVjFDYVFsWXlCUnJOdk9qWi9pQjVwT1ZDaXBW?=
 =?utf-8?B?NWh0Um1FWjZLT2hPUGlyRURxY1FlYzc3c25vWXo1cGlIaGovckJQT2tQYkVQ?=
 =?utf-8?B?RnBnY3dScFFCUEVpVmJXOFYrZERudkxSTi9VMWdWOXdZQzNXYi9ONCt0YVFN?=
 =?utf-8?B?bmlLSUVKUkFBK0llRVA2ajFnZ054WGNiWFdMUlR3WnNOU2VRUlFYWk4rSXQz?=
 =?utf-8?B?Wi94TzNqUXg5WEVWSlpkTHJNQ2pYaVJWK203bXZlbStrQUZ6VWNLMC9MQmZY?=
 =?utf-8?B?clFDWEQ1aE5keUl3ZXF5WW5JZjJnODNOZEg0bkd5R1JUNVZHNmJvSnp5QU8w?=
 =?utf-8?B?R2xBSGYvRzJUa2MxazRYYm0vY2s3TzdrQ3BYY3JORTlwcnhCWjFtRVV1QW14?=
 =?utf-8?B?eGc0YjNNUU1yUEhMVm1GS2FJZTZXd3NFU0x1blZYNWsrVHNGZk1KVitabjRj?=
 =?utf-8?B?ZDNFb2lUK1hKVEdwN1cvL1RFSFlnN1ZVSThJS1Q4VUxLdERPdHhxQ3h6cDhC?=
 =?utf-8?B?MFZWWWlXdmMvUW1LK0Mrd1ExUnpDTGJnc1JQRHVtUGw1bWpjL2hYaGxxc1A0?=
 =?utf-8?B?QzBIRGFSNlBYNmREWFBRSjhBNmtSdDlueGMzRzRqazZWWmJSdWtKeVdnQll0?=
 =?utf-8?B?VU1mdzFGTXhsajA2ek9SZXRnL1NxbFJYWTM1MHZHbzA4Y1hKWEo4eFVCUGdy?=
 =?utf-8?B?ekJUUG1yYzFVQ004K1NMRGkyaVgxQ3QwbzVFUlhMeFp6Vm0zc3o0ZWd6dytV?=
 =?utf-8?B?bmVkVjRpTDFxMWNOVkRYSlhvYVlCUk0wWERMbktHbzVOb2k1RXUxUERTeHFr?=
 =?utf-8?Q?5gj4uCsfFzFzkU3OKLXAaaMj/p1TAsbDx2HDc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dBVFEvTDBJOTNJN1dmM20xMnRqYTlCZUxvRzE5U0dFZ0RyY25oSHBZZnZi?=
 =?utf-8?B?TS9oOG9lczJqMjVZL3B6UmN0akhvbEhOMHl6Wkw0QU9lYktZZTg5blI0VWth?=
 =?utf-8?B?cUplSmZCaExsTm1uVlV2WmxrMzJ3a2MvUWVCMHFjazlMWnFUOFUrajVpcWRI?=
 =?utf-8?B?b1VCODA2RUFvR0NHanhOd1ZScjVudEQwRGlJbXlqL0NCM0NYTThhQWthMUxQ?=
 =?utf-8?B?Tll2T0dnSzZOOTVZS3kvaGJJU205Q1VJWGZIMXJxVENYdjFwK0tKRjVZKzdy?=
 =?utf-8?B?VXJVeXdKYmF1U296Y3Noemp0WE8xV3cwNTFYcDE5TktUZmhmeVhUcXBjQkl3?=
 =?utf-8?B?TnBEbkZCcHgrVUNLcDZQSXlFTWEwdVRRKy9NbEd2Q3VzQzA3NTVMbDlDajYw?=
 =?utf-8?B?N3F0R2owaGZKRGRFYUNKOGo3anFiY2N1ZGJhcG9KZXFReGlNNytpL3hWcHJI?=
 =?utf-8?B?VURwMnQwci9veml5WjNqRlZmQ2RQeStSQ21ZMjBWZ25waWZuUWFVaDZLbnpu?=
 =?utf-8?B?UXJYRmxtWmxLWFN5S0lQalFHUjdNMXpyNVFaNkdLbC90a0Mvak1rYWQzUGJ6?=
 =?utf-8?B?UStLbkF2KzBhWWtUb3Bid3Rzb29VZnFmTXFQTUQ0Ym5UeXVmVVA0UnZVOGpE?=
 =?utf-8?B?TUg5ZTdGdEJsK29nMjFLdVF6NGVKSUVrMWVCeXI2TzdLQ0d2aE0rdXFzMmtO?=
 =?utf-8?B?N0hJc201b2M5WWpuckZBd25vM1F6TExGZlBRQ1pWcnpvRm5zcTR5eTNIT2la?=
 =?utf-8?B?a0V5bWxPcXNnR0dpV1lpZ3NRS25KSlBiY3llRHhwUlFTa1VpNGZXY0NoYkdP?=
 =?utf-8?B?eGlvbkZQTkdzTFNRM05DbWlzS0t0S3VqYS9udUxnRUNzd2c1RStvNzlZeDhF?=
 =?utf-8?B?MWhHK0pmbGhjTUovaTVWRWw0a2pUd3h5Q2xEZFFaQkdIMHNEOFdVbnl2Vko3?=
 =?utf-8?B?Y0Y3eW1SUWJCWWJJUGhEdVE0cnJ2bEgvMWhwM0RYYjA3WkNQbDRkVUN6azBv?=
 =?utf-8?B?QlEyQURkYUdiSnBOVHNzWGw1ZWZVckFHRHplSnROZ0ZtVFVUZERSVjZuUEZ2?=
 =?utf-8?B?ZmV0anF1Mlc1Uis5OEdqV1FNeW1qYy9mMHUrZVFHdStBTjc1bWw1T2pSdUov?=
 =?utf-8?B?Z3pxS25pWlYvdGN4QWpLNVhaU1RqS3VyRUNoSGI0cXo0SlNQUnN3Rm5LR0RG?=
 =?utf-8?B?THlXUmIvUGdWWmgwUEdBR1ZnTlZpU2YvZjJEbWtSbmhubzFKQU5ib0dWWExV?=
 =?utf-8?B?V0E3ZnBZNEZkd1dCNXZ1NDh5aERXOGwyVlJ3dllaTmQwMy9mMlVGeWMvSG4x?=
 =?utf-8?B?b0g5T0hYVFNka0pnNzVQb2czMFhWMVpPNFFpaGVhVzRHTVBDbS8zZkN2dW5S?=
 =?utf-8?B?KzJxZXE4Unk4QXlhMHArc0JLZURNNmVmRWk5c2o1Zjd0dXJxMjIxS01kVGx5?=
 =?utf-8?B?YlhMVzA0bCs1b1dORmZ5c0hjQnpWVW95aDNiWWYxYVNhNnUwbDZhWUJVSytI?=
 =?utf-8?B?KzhGM2VGT0FKU3c3YTNjYVBlZDRPdmJOWWJUL2pRU1l0aWI0R2hlcmdiMjUw?=
 =?utf-8?B?TS82L0xVREwyQ0Qra043c1J1N3BHTDBNMmVobEc0aDV0aG4zUlNZbUZacWxP?=
 =?utf-8?B?YmxJZXNjb3hhc3JqS1B4S1JYNDRVRGZuNDlzU1kzZi9jMGh6aFJVYnovQTFi?=
 =?utf-8?B?cDduNVBZY2tIWmN4bXRiUHpPb1NSVzJyRjY3NDZ2Smp2Z1hDRlJJS0ZjZVRT?=
 =?utf-8?B?TURST3BzVEtTbmIzZHp3NkVJY1dzbEZza1FFdzBnb0gwMHFCaTZ0SFRVa1Jq?=
 =?utf-8?B?NEJxNzdtNjRsSFBzcUFyUVhIYzBvNk9oc3dnY1JycWZwNWE2SWpGdmE4eTdC?=
 =?utf-8?B?c0RSVk4wTThLUU1iY2J0RFpHNE12QjI1MGdld1ZEYitqL0NOQ29mQm1HUEYy?=
 =?utf-8?B?VEVERlZJc2NWRVpUWDk3SEMvK1lpRXZ3Uzd5Wmp3OXpSZ3hMaitpRXY5a3l3?=
 =?utf-8?B?YURXWE9ONXdkSk5HYTRCNDhZUGFIQUJpOUFib0Zxa3FvYnFBN2R2YmZpSko1?=
 =?utf-8?B?YksydkVweUJzaFpRNmdrSzNXRjZuUm9najF0RnUwVTBZeEYxYys2Y09vU0FG?=
 =?utf-8?Q?dBdrMh0MjyPEBzCM4kwQ7OD0w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a066d8c1-12dd-4d9c-48da-08ddea381c0d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:48:06.8949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/M0yq1zpT2rLyE+4Q6d99uYDUKp0AQqbX1AtxemVhg2WrvE1UEhJwYOo9XL88OQbLCxKYF95HdpmK+jbihp6A==
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



On 2025-08-28 10:08, Mario Limonciello (AMD) wrote:
> [Why]
> Although compositors will add their own modes, Xorg won't use it's own
> modes and will only stick to modes advertised by the driver. This mean a
> user that used to pick 1024x768 could no longer access it unless the
> panel's native resolution was 1024x768.
> 
> [How]
> Revert commit 6d396e7ac1ce3 ("drm/amd/display: Disable common modes for
> LVDS") and commit 7948afb46af92 ("drm/amd/display: Disable common modes
> for eDP").
> 
> The panel will still use scaling for any non-native modes due to
> commit 978fa2f6d0b12 ("drm/amd/display: Use scaling for non-native
> resolutions on eDP")
> 
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4538
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d533bd633f163..bb156c26a08ee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8440,8 +8440,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
>  				drm_add_modes_noedid(connector, 1920, 1080);
>  	} else {
>  		amdgpu_dm_connector_ddc_get_modes(connector, drm_edid);
> -		if (encoder && (connector->connector_type != DRM_MODE_CONNECTOR_eDP) &&
> -		    (connector->connector_type != DRM_MODE_CONNECTOR_LVDS))
> +		if (encoder)
>  			amdgpu_dm_connector_add_common_modes(encoder, connector);
>  		amdgpu_dm_connector_add_freesync_modes(connector, drm_edid);
>  	}

