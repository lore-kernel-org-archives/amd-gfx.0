Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3102CD3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C65110E6C9;
	Wed, 10 Dec 2025 09:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q45sRn3t";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE9F10E282
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 09:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhikby6GHBO7u/W8ldsXt8NzfErZjiytig0vTA3KKOvEI4Poukf9JjSAuO7XfNGqjjPd8XvUa38aUQ5vUCei59da0A1sOwfe0yi8pW+ao7urAl8/5Oge5h+Zi3OfP8eKjnK83ccAN3Rm5evZKds1sHYuSaoBpo8B7X6f33CQDp6VmKM9PpKesRTIxz+Bqh9jtc1gJ5dDWVvnMBHl1wkOctk49cvJq1zOzVOLkQhKxQWjOrf1LJhIqoz7RnjFzzsznFT/AI7mcpbbx59l9AJiBDKbwkPEHCgmIKNBsaCA/5Sp2XW/oiejQqXMwHRqAgVKE1HAIAZp9kzsmKyu0tgkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgQyOyjVzZDRx/UQQHrB1xHCFJZmiLS7vHdzTzz2Cc8=;
 b=XAIEhds+v9ZvQ3COhSqxDuG23PLWlWMuYLbeGdtAqgxED4Jerj6aq0G2vvvpH+vZrRM0CpCyXAukzbkKOmzMDER49a/+m/yOQjNw2ZrQy0WS3Vtia2QfwSrtndhuQ4gG8n3DY4VagARqOWGyy1Lcd9hP/KiUMNiZh1NCM/souFjcHbLJRBxhKIh3yXLM2TdROwMb/7cU7g2Tlf/tfT+UK+nIe6HTqYrVG6lLZqNLCznY7N79kFZFCgJ+G1tI2phJh7mJEu7iXwat7cZ/sqAWYWu6q50lPQ8zvuiXWHH+siDb7HCgW10oZ9gIgyR+l98Az3QRGnK59HnUw0w3jJRp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgQyOyjVzZDRx/UQQHrB1xHCFJZmiLS7vHdzTzz2Cc8=;
 b=q45sRn3tWHeOFKfSYyX4tJVHNZLV+jBO0wK0iwZ7gT2Led5Ir8l/eoDkijvuxlvWQlyVA/kIwnW/vvASL82J1MtsjgjQnzVlS8GuNXGjdNNm0l5AU7s0pZR3Wh1LP9OXIGnsQQzDh+z17jsD8W5vOh25hxigrFMDLvo+FCLXZXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 09:55:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 09:55:25 +0000
Message-ID: <3278f3d4-69bc-48fa-bbad-c9acfe2d75ad@amd.com>
Date: Wed, 10 Dec 2025 10:55:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add sync function for specific reservation
 usage and update VM sync
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
References: <20251210092752.1416361-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251210092752.1416361-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a25dcf-6304-41f0-8877-08de37d23dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFRkYWljSTdXWVpvQVJpd3BKcFcyR0EzODlnSVMxOFpvcXBwbkkya0dDMGlT?=
 =?utf-8?B?dklxalIrVTRVRGFBYW1sOXZFUWJCbTlLUjFFa051VG1KQVh2bzZ0bVVqb1BJ?=
 =?utf-8?B?VlduOEFmVCtpQXFNc3dDbCtOY0VOVHp6VVpkQVdVcmhJYjhOL3JrZ01BUndt?=
 =?utf-8?B?a3pNYTR3Y2RpZmVTQ0k4VkJRckNsclFESU5oMWt2VTR1eXRqQ04vR25EWGpH?=
 =?utf-8?B?dHlBWVdXakxrMW1ZZytTbWc5L1dXTFVLRThsMEFlWkJPVEJZZUtFZlQwL3Y4?=
 =?utf-8?B?R3lQOXNwTXJRcW1nMU9qNTM4MVdaUnVQNkxCTzhoTnMwdm5zZi8xR1JobUMy?=
 =?utf-8?B?UElUYUFjeVpPSmVHcUhRamVBSi9sUmtldnRINnJxN1ZpbXZNazRjV3Nncmky?=
 =?utf-8?B?dHhKZTlES0xzaHpiRkJPZkRRbkNYd091M2hraENjUWRBOVZYNG1jcUxTVGZo?=
 =?utf-8?B?WnVVeHY1dVVReTJMM3lDZk9YdGRMZ2lxa1lqWlQxNUIyOUpRQXRuNWRBeHR1?=
 =?utf-8?B?OFYxb3pGcW5xQ1I1RmQrT01OdW1PZ0g5Y3J1dkdzcmpPNEg5VWFWUmkyS0VE?=
 =?utf-8?B?aEtLNm1wdVZXdTllempJMXhwbkE2N1RDSUFBeXB6S1d2QUQ1SGJaNGpjSXRk?=
 =?utf-8?B?N1QzWTdCaHdtTWVsenREOWJHTWZwTmpwZFBaT3FzWjhwWm0ySXB2WEtMWkZk?=
 =?utf-8?B?djhIQk5UT1RJT1J0K3ZGTnB0K1o4MVk0emFKZGRmUlFtTDdaczJTSlpWRHR1?=
 =?utf-8?B?T1Z2ZUhOL0JmQ01acENsUXZKdHJ1cVNIYzBnRVZZZFFjUTd5eXBxSFlzanpG?=
 =?utf-8?B?YWtmdWpRemluaGNZUG82dGg0MElrMG93Z2ZFRU5wZExMdG9zZ2VIWnFxdldM?=
 =?utf-8?B?bVRPT2srY1NseXZMWnVFdXl4YkR0QlZadDIwVk5MWGNsNHBpYjEzb0lYTjVv?=
 =?utf-8?B?MDhaVUVlODVncnBHeG1uaERvMkZkVE4zZVJhQStiMTZ2Q3o3MnBiVlRma1pv?=
 =?utf-8?B?UDMyZkI4WlJMeDlIMmlsRVZvRWEzeFRUelozWXlYaDRsSzBYbFcwejBIa1FV?=
 =?utf-8?B?VnpwdVZCdG8rWUx4ZU44SVZFUmRvdU8wWXJLV0J3QU9kLzc4ZWQ5M0w3SURW?=
 =?utf-8?B?VEtFdGRvaytnb0RoMXJyMjJzTXBTMHBWRGFUT2RzV1BxYzA0MGJJeUJWdXNP?=
 =?utf-8?B?eVhoRjIxSUM3bmNNRWhQQVI5Sm5KVUZLRms2cmZ0MG5hc0czNGt2elpucStw?=
 =?utf-8?B?R24yTS8xVVh5YkFTKy9DcmttR21TVFNXL2dXM013R3pzR2grdW93dWZUNkZ5?=
 =?utf-8?B?dW41dlN1SUY3Z2twT1ZtbmFveFZLSnpCTy9mOS95c2x1QVgyVFptdFBVUlBE?=
 =?utf-8?B?S1ozbkU2emVJdWV3NXh5bXdERWp3Q2NhcWE4RzIxRVBqWkZQc2dzejg1WHNZ?=
 =?utf-8?B?bUFwQmU1VE5rS3dkSmJlT1kwMkdpZ1h3TFhzV1ZtVzJoVGl0Umc3elAxWW1P?=
 =?utf-8?B?OEloazdidFZESE9keldVZm9SUEpxU2Nrc2d6QzN2ZUNONEhJYU4rM0xYYklU?=
 =?utf-8?B?U3BRL1dxVFJWd1RFNWNqRzljM3lYM0tBV3ZhcFoxakJRUE9qbnJtOU54cmJn?=
 =?utf-8?B?cmsyNnYrRE5tZWtjcHZYRWFOcUdsTTdkbDQzT1YwNHhtWk5pdDlhbktqbkt1?=
 =?utf-8?B?bVQvaDFnVzdwYm1ERHh6NVB5MXNFRXVjQzYwY1Nlb3RuWk1mSEVobTFZYzhK?=
 =?utf-8?B?NHNPNTJtd0JYZXRmdUR5UWl6d0YybjRiRzd4b3FVOWNSNUc2WFlIQUtYYWZj?=
 =?utf-8?B?dC9kZHBRRUwrL0VERXhMZERKcElZT1ZwV2xxM3JrTGNEYnl6UWNBbEtvRmN2?=
 =?utf-8?B?Ri8rQmVtZWpaRXhrWUVZVm1KMGt2MEpyUTVGdVFuYzJOMDVqZitReTJTelph?=
 =?utf-8?Q?5ty/upW6ObnOOyCbMZy8eNEDvzjhOlEF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri9ZVnQ2VWU0NWxJWUltUzZIdUVUalB5VVVITDVEWWVQQmNJNlRoQ3pIUFlM?=
 =?utf-8?B?bTE0Y0JEQTZPS0dHdXdubENUKys4NTRRTkMzMExGaHgvVGhsN3YvY1J6QTFI?=
 =?utf-8?B?SUVaelZ1bjVXdll3Vmp3Zi95Q2lxV1RPTXVSTnZLbnQwcjVGVkMwZCtsek5l?=
 =?utf-8?B?NDd5blhnd0ZSWTFROUs3bGtxOEFKODk4S3BydjNJQU52YWNFSUhWaVYzaC9Z?=
 =?utf-8?B?SkZWNk1QcmpZUHFBQVNlbHJxeHUyZTB2S21udExZSmpWaHJjSlNMbnNMY3ho?=
 =?utf-8?B?Rzhab2RjdjY4dElYclVCTEJuU2R5ckplR3dBbithQ0VvNHo5YkRSajZoZ0xp?=
 =?utf-8?B?anAvcTZVZ1BQbWVaWVkvY0hpb3pHRlVuNktmNnBTTTNVeXJqZXpYbDNyRmZh?=
 =?utf-8?B?Q25YcnZ5NGtxVUtqSUJWNlZIZTlVOWJjdktQREh2WGh2bnVZeFNvSWExaEhy?=
 =?utf-8?B?RVZWWU9lNjZDTU1BbDBDV1RhbnM1c1VBK1U5TGxvM05BQUl5ek9vcnlRVU8x?=
 =?utf-8?B?ZndEUUova2tSeVEvOU1qeU5IdlNrazJWWDdmQXd6MFZZUEprL3VNSGN5cEdQ?=
 =?utf-8?B?MlhlazJaV3VBN3RTbkhmOVJJeXQ3eHEweERMaGRLMGNRdWpOOVV4TFpSbktl?=
 =?utf-8?B?NWM3aWp4UlVsL2srVE1xSXNOQzBZOWN3cE82cy9jQzdxOUQ3dDkvUGV6b1oy?=
 =?utf-8?B?TXN4Q3J6bGEzejBPbnlYaCtGeTh0WmVQeHNWUTRtcGNCT0NjN3dEMll5cWky?=
 =?utf-8?B?VmJ1aU9sWUpOSmloWklXZ2NSclc5ZlNGL0ZsWnFuejVwWUdCVkZMOXkyNWY4?=
 =?utf-8?B?ZnRhYmVZMG1YSnkzRWVaQTVVSXVya3FlN21naGYyVEY4RjRLQmwwYWEycEI1?=
 =?utf-8?B?SXZDS1IybkRDUkV1Q1Z2MTJqZ3VBbHR0eEI1S0tDUVVDSVFHMFZJV0M3UFZU?=
 =?utf-8?B?eUFneUxjdDd3VkFLSll4TlpqTHZVWDVBSC9hL1dFNnpMRGJHUUlmMGY5WTdQ?=
 =?utf-8?B?Zy9YbGtPSDBrTE4rTGhFSmd4dEFiR3BHRFRJd1lpL2VyRWZOUXZVSU5mck1p?=
 =?utf-8?B?Zno5djQzSGgvanlHOXpNYjdtZ0pUd2E3OWxYOGMvQXZvT2JzWWQyTEZwTlNP?=
 =?utf-8?B?dlRVWDc3UkZIZzVnQzE2MjgvdkxsL2x5cjFCdmI0b2M2amNQN2xCamF0NFpr?=
 =?utf-8?B?T2ZCMHc2ZUVZdlFpYjRMRmo3MlkzSnFnM0FXWXlONG9jZXYxZnRJelRJdmgw?=
 =?utf-8?B?MUlodDdsa241cWNMMnd2azFoQlViU3l6UHJzMlFjVXVqbGtWQ2ZQOHNyMTlT?=
 =?utf-8?B?UWs5WEIvRWRJd2pyNEZZK1lUV2tvRW10WE9uN2VxRWFJN2hrVG40R1NtMVlC?=
 =?utf-8?B?dnErdW9ERUlQaFNrOGtnZDU3MFV1bVNMY2FqQ2RybXpyUUFGOU0wZ2dEaEsv?=
 =?utf-8?B?NXZuRTBERkZieFlRTnJnNGo0Z05iK3p0TC9nTG0yYjFXWHBCY2pTTFI1NWdI?=
 =?utf-8?B?K2FIREllVXcrQXFqdkhqQURzRDVPMjkxQzNrWVlVQWoxdlQxaTBHZ2FFNFlG?=
 =?utf-8?B?YkRBemsvRjJQVDg4KzA2OUIzcVVsZ0pBVk0rUzBob0doalZubFFGTUpISkVz?=
 =?utf-8?B?V2ZZQVVaQm5jUmFpUWYzM1hKWXZBdEtWL2NBZ0dEaDhXL0VvZjg0MjlpYUZS?=
 =?utf-8?B?U0pFdnNNeXpCbUFxQVIvRWJPQlc3RHRJT1FVMGszRVRSRHByczh4U04wbkZE?=
 =?utf-8?B?aHhid2Y1OExaNkJjQ3RQbzQ5YlpnRlZjZ1BnQUlvVEhMMm1wV3JBTVJTaHJE?=
 =?utf-8?B?Y0IvN2toaEJodFlTRHhGMGVVcUJpMnpYZkZuUmtLR2xXT1JsVDFKcUVzTm1U?=
 =?utf-8?B?MXVXNVpDNDlzVjdyK3Y1VTRZRUxQSXREcmd5eHA4VDdmbWNSeUtBOHptWGw1?=
 =?utf-8?B?MVRTbXJ2emFXUHZSc3EzeFhFMmN4N2RXZVR6d1pwQVJQRUVRNHcxeVI0bGZ1?=
 =?utf-8?B?NlVvQzU1emUyWHpqTGw5L2xFNjlvOVlmUVNmRHNkSjZKWmtGTXdCaEFLZjNs?=
 =?utf-8?B?enZEdkpBUFJEQk1VTEN5eWlFSU0zZTg1RktTbm1oZUUrZ2F5ZTBMU1Mwc2da?=
 =?utf-8?Q?dGEC4Q+dvP4G79XBPsdy5w1l3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a25dcf-6304-41f0-8877-08de37d23dd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 09:55:25.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUMOfka8AhWqTxX/SSuhYNiLexWcHHahZTmB5N/wG12pkJlCaIezUTuA2nlG0SG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

On 12/10/25 10:20, Jesse.Zhang wrote:
> This patch introduces a new function `amdgpu_sync_resv_usage` that allows
> syncing fences of a specific usage from a reservation object, replacing
> the hardcoded DMA_RESV_USAGE_READ in the original `amdgpu_sync_resv`.
> 
> The original `amdgpu_sync_resv` is modified to call the new function with
> DMA_RESV_USAGE_READ to maintain backward compatibility.
> 
> In `amdgpu_vm_bo_update`, we update the sync call to use
> `amdgpu_sync_resv_usage` with DMA_RESV_USAGE_BOOKKEEP.
> This ensures we properly sync with bookkeeping fences (e.g., related to
> memory eviction, migration) when updating VM mappings.

Clear NAK. VM updates should *never* sync to eviction fences.

This is clearly just a broken workaround and not fixing the underlying bug.

Regards,
Christian.

> 
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 49 ++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 10 ++++-
>  3 files changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index d6ae9974c952..9665eed65b5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -229,31 +229,30 @@ static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
>  }
>  
>  /**
> - * amdgpu_sync_resv - sync to a reservation object
> - *
> - * @adev: amdgpu device
> - * @sync: sync object to add fences from reservation object to
> - * @resv: reservation object with embedded fence
> - * @mode: how owner affects which fences we sync to
> - * @owner: owner of the planned job submission
> - *
> - * Sync to the fence
> + * amdgpu_sync_resv_usage - Sync fences of a specific usage from a reservation object
> + * @adev: AMDGPU device
> + * @sync: Sync object
> + * @resv: Reservation object
> + * @mode: Sync mode (affects which fences are selected)
> + * @owner: Owner identifier
> + * @usage: Target fence usage (e.g., DMA_RESV_USAGE_BOOKKEEP)
> + *
> + * Collects fences of the specified usage from the reservation and adds them to the sync object
>   */
> -int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> -		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
> -		     void *owner)
> +int amdgpu_sync_resv_usage(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> +			   struct dma_resv *resv, enum amdgpu_sync_mode mode,
> +			   void *owner, uint64_t usage)
>  {
>  	struct dma_resv_iter cursor;
>  	struct dma_fence *f;
>  	int r;
>  
> -	if (resv == NULL)
> +	if (!resv)
>  		return -EINVAL;
> -	/* Implicitly sync only to KERNEL, WRITE and READ */
> -	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
> +
> +	dma_resv_for_each_fence(&cursor, resv, usage, f) {
>  		dma_fence_chain_for_each(f, f) {
>  			struct dma_fence *tmp = dma_fence_chain_contained(f);
> -
>  			if (amdgpu_sync_test_fence(adev, mode, owner, tmp)) {
>  				r = amdgpu_sync_fence(sync, f, GFP_KERNEL);
>  				dma_fence_put(f);
> @@ -266,6 +265,24 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_sync_resv - sync to a reservation object
> + *
> + * @adev: amdgpu device
> + * @sync: sync object to add fences from reservation object to
> + * @resv: reservation object with embedded fence
> + * @mode: how owner affects which fences we sync to
> + * @owner: owner of the planned job submission
> + *
> + * Sync to the fence
> + */
> +int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> +		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
> +		     void *owner)
> +{
> +	 return amdgpu_sync_resv_usage(adev, sync, resv, mode, owner, DMA_RESV_USAGE_READ);
> +}
> +
>  /**
>   * amdgpu_sync_kfd - sync to KFD fences
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> index 51eb4382c91e..1f875b1e9d2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> @@ -52,6 +52,9 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f,
>  int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>  		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
>  		     void *owner);
> +int amdgpu_sync_resv_usage(struct amdgpu_device *adev, struct amdgpu_sync *sync,
> +                          struct dma_resv *resv, enum amdgpu_sync_mode mode,
> +                          void *owner, uint64_t usage);
>  int amdgpu_sync_kfd(struct amdgpu_sync *sync, struct dma_resv *resv);
>  struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
>  				     struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0eccb31793ca..f470b7e5489a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1313,8 +1313,14 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  			pages_addr = bo->tbo.ttm->dma_address;
>  
>  		/* Implicitly sync to moving fences before mapping anything */
> -		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_EXPLICIT, vm);
> +		if (vm->update_funcs == &amdgpu_vm_sdma_funcs)
> +			r = amdgpu_sync_resv_usage(adev, &sync, bo->tbo.base.resv,
> +					AMDGPU_SYNC_EXPLICIT, vm,
> +					DMA_RESV_USAGE_BOOKKEEP);
> +		else
> +			r = amdgpu_sync_resv_usage(adev, &sync, bo->tbo.base.resv,
> +					AMDGPU_SYNC_EXPLICIT, vm,
> +					DMA_RESV_USAGE_READ);
>  		if (r)
>  			goto error_free;
>  	}

