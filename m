Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE1DCCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3023010EA06;
	Thu,  9 Oct 2025 12:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VdF0rWv2";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDC310EA06
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 12:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO82LSaSYtU5FsCpUKXQFpkVht5VePk5tk3LXVilN+QZGKI115eSbZ22mGF0gb2JDkyaNJ+XrSMn5SnKbIGe8uTSgyYUMgTCupqRr0nN/IlY70iqotua8PsaPn1qoPwtbb0DP0/fcFloDFLHE5eF8fnUf+OrwXfV4qpQNyVVGH+GCzmuPHjtof4csyofnNbLlKU91QwdIyk86sr25X/XNw1itFekb2hsP8/cn3d7KYbiFJ/PxGMekZ/gaJx/oJPebslphFP89+ymfVNkn7myv27DknH7WCU0dFv6zdnuw8BRorP+EldbylJEYE7TZfmzHyN7VhfaXJM66OL9Qvr1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuJDzOwWIr6wp80Zl6PK4fP4FjL1LPcu153gFZJ6iS8=;
 b=DYpDg7xAdW0cXahBmLdgPYoXZ25YIHdnUYTvUayqIITgn5h1qvrSXK+EC6Y9QzlLxjYRmVwS4FSnHpUDO9NhuY98vQZhvk9409fgx0I4ykly15EhhooX9qW/PiL1jNXTUyL6e2yFd+FEGyUHZx6DiHOmEV7kN39H7NLkjv8QtDi2kFCisyOCFtH9SUxM24sLs++OYwjUrFgjx2c3qgmvtyDdlqXXbzNif1nqXr1uUm0V4uFLWAnjRheIimCwrf1IWLMNM8+oTs5YumCdBn33DRD0K2Ag4pTMD+hW5draxVU+DBSJv3O6+BAvSr1wm+Qa1RnsnMvDE8+kx/D62JjBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuJDzOwWIr6wp80Zl6PK4fP4FjL1LPcu153gFZJ6iS8=;
 b=VdF0rWv21nCIbCwMPd1asgEni+WimoDZYN3fqACexpvJcPoqG0Te+e6xk+tRsA/qPI/bjtPrbC22/Fd1mS5n4SLlWrZcu0QzzTiFRN4wI6S8TaUQ00cloNX+9jHQ/LtTd/1H0b0lsCl82S7xU8CucyWv8w5DEaWHTLPDm9gTX5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:26:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 12:26:33 +0000
Message-ID: <95dab445-9720-4b10-8a1d-2ee76933ff6b@amd.com>
Date: Thu, 9 Oct 2025 14:26:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Shravankumar.Gande@amd.com
References: <20251009033047.25004-1-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009033047.25004-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aba6f02-b2e7-4015-237b-08de072f14f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFN6L3F2M1NBQlhBUEl1K2lXdzdkWlNzY3JyL0FWM3N6aTNiS0FUMGZnSzhN?=
 =?utf-8?B?VEV6T0o0NFlqRTZZVzRQTHlmMHFRYXk2bksyc0ZPbTZjbXZneHJjdFFBYUhL?=
 =?utf-8?B?ZnJ1VElvMFpiZVRVK1czVmtpTEtpZjVtbThhQjVDaHp2STA4VVp2S0VGUmRC?=
 =?utf-8?B?RXpIdHFlRnlLRTQ1WS9yRnAvV3h5UEZHRlB5NW1xK3JHdmR0d0lDWVdiOStP?=
 =?utf-8?B?UkMybGd1Q0RtUklrSFJJNHNzNm10ZEFkMkoxTmQ1ZmhmNFB2Nk9nMzhLTnRw?=
 =?utf-8?B?TnduTk9IbGp3Vzd2cUN5dUFpRlhzZ1RzVVp6Tk1ieW1XekIrNlVsNEppOHpP?=
 =?utf-8?B?NDg2YzI2M3VSUTdnV0x6VUtMZE12aGlTRVloTkF3Slk2RnY2NVk0R1hya0Fn?=
 =?utf-8?B?N0FoRTNlQlN1dUFvN1IwUHlmRWlGZ0kzQVNJTXhTbU9Ka2ZsQWlhcFVzRWdm?=
 =?utf-8?B?OUFKSVJQUkd3WWRzdTNMUlZDQ0FvT1A0QkNFQmtzTU5FbkE0RGhuS2YrUUhT?=
 =?utf-8?B?akJGaG5GUHE2Ulc4QUJZME1ockxteFkwOFEwOVU0YWpTNGhneFJ0TTdDblJK?=
 =?utf-8?B?QUpXSGpZV3h1SC8vQWRqSTBWZzMvdk1kcnMwT1NocXNKUUQvaGY2a2VRc3ly?=
 =?utf-8?B?Y0twdk5PQVBGem5CMDNLQ2R5SCtpcWUzVVc5b0dZYjJVd3ZsYlBRYS9WcDd3?=
 =?utf-8?B?N3prMjFFWElTUTFFbFJIbHZZR2MyRFBmVnhzR1labHljYzFGS010YmovNmxi?=
 =?utf-8?B?MVBWV3NpNU41azVXczg3ckszbjhuSzJQMzlQYzNiMW90SXNFV0k5RUYvTHdE?=
 =?utf-8?B?NklQRmdheEFKc3kxUTV6YVdVa3BFRFJWRCtUWEF5Y2xidWdoZUh3UTMveERY?=
 =?utf-8?B?dTMrVmk5S1Z0eHlraVdZUkd5VDFQZ1FGYUtHL2ltQ1dPMWZMWGFRYUFnUjFV?=
 =?utf-8?B?ZWN2QmE5ODg5YXBuMVdrVGpMVGdYcTVXeVRieFoyUmFXZ3p5WTBaaGJ1Y0c1?=
 =?utf-8?B?eWVLazIzYXN4aWtCTXJmRjNjTXlEYkY1M2gvSFNjSDRzZWNQeVpMaEZRYXZO?=
 =?utf-8?B?Umk4YzZEVWZtQ0pvSTE4azBmYlFVb0szcjFkWFdqZ2Nha0VWb0tVVHd3dTh5?=
 =?utf-8?B?VExQWlZzSkRBbms2OUhtajQ1VG9rYVdBdWtVRjFsVmhaQnNLVzRJb1Bsb0Rv?=
 =?utf-8?B?MEZCOWV3TlZSTFBiVllUNDV6MEVHK1Rmdjg2bVJ5WjhMNTVvNmF1a1lhTDBa?=
 =?utf-8?B?dDlRMDF5eVJHZ0pIQmlJc0xEbFNvVC9jMjVuamJpYUlHWkR6S3V5YXBpdjA0?=
 =?utf-8?B?QU1TN3lqZWk5c0VOdWx0clVURU54SDFEclZrdkpxbkU0eUFxcWhEQUx2QjFZ?=
 =?utf-8?B?N0NtSTQyYm5KS0orVnpJRWtHS0NHdjJ0ZU5HRm56T2xwaTdnbzk4M3dqMjF4?=
 =?utf-8?B?WW5lUitmWTNlWHgyTXkyWTRyYVRFQzd2ejJZMkZjYjBWZW0yanJHdGdZWm45?=
 =?utf-8?B?ZHU3c2tieFF0SEV2S3JVY0c0UkFVbEpOZDl1bFhwVnlZYWdwN2JrcU9hQTIv?=
 =?utf-8?B?M3Bxbi9XUzFwSjZaUEpkbGsvZUVSZCtFUmFHZmFhdTN1dGkxY1U0WmdjbFlw?=
 =?utf-8?B?TWhTbm43R0lnV3lFbFVnTWFtbWFQcU5qWmxhemFOejlRdEtFQ1E2cUtOS2FN?=
 =?utf-8?B?ZzJTMjdPRnUzVElqMGNkd1JoUmdZRDlVdmllNHBYczBoNFFsWUNMM1V1b3o5?=
 =?utf-8?B?SGhyL2U2R1VYaGRWK3NXbVdEV2ZWYkZUME1Iek9Rczc5WEkxOUsyZ0Z6bi9T?=
 =?utf-8?B?M1lXRDlLTzM1NlB3eW5QSFZHMVJrM3djdmRyQjJWUXV6NElTcDJScmRUclJ1?=
 =?utf-8?B?RDhka0lwcFdKb1hpZVJ4Vzdpa3k0OXJOeEV0ckJoajlsMDIzM2tjZTJUL3ZQ?=
 =?utf-8?Q?oKsE7xIGbmZjQzweAD5KcAdH2uPtN6if?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T044RTludStvMFZRdERZWlVaL1U2UUErVXFFcDZIeXp6L2Q3NVFBcUVaYVZK?=
 =?utf-8?B?VjgweUljTnQwUWg1cnVMSkIvcGhXRGx4NnBEa3MyY29pRXhKYTR2eHhqc2x4?=
 =?utf-8?B?aFBMa3laMFVWZ3Qxa2ZRbnkwYzV6bjVHOWk1YmhFVWFhbzY4SmVHbHBROS9U?=
 =?utf-8?B?UC96U29ib3duR2tZczYxU2VNQUxXT0IrTHNpSnVRdXpUaVNON3hwQnoxcXFi?=
 =?utf-8?B?MXlueFN5LzVsc0lSZ2J6QkJ0N2hXN1FWV01pYXFtWUNoYmQyS3FrdC96NlZF?=
 =?utf-8?B?QlJ6Q2Y1WlJ5SS9hVkV2NXVvRUU2MGdYbWMyWDk2MkVSS0VmN2pNaWYybkg4?=
 =?utf-8?B?WGZwdmNtM2NVVjR5cTR3N1JFUDFlcDdWWC90cUxkdnQwdkVFU0FkTW5ubWFM?=
 =?utf-8?B?SERHdXBVK3BJUFNINGM2VmJDb2tHaW5lY0FPUjAzNHFWMUhQbmFmZmJwUFF5?=
 =?utf-8?B?MS9ZTURuak0xd1B5QVhBb0RIbVFyWnhGWmpMUGdnTGpJclVESVR6Q3VkcG9W?=
 =?utf-8?B?ZU9kbXhaYnRldWRTQXJ5L0ZvU0VlTzh4d1FKOFgrTzg2ODkrS3JkU0JaY0pv?=
 =?utf-8?B?eWpyLzlsdkV2U2FCWjAzbzVzQU9aeDh5VVZjMUlxekI3dXdlRElsVUU1ZnZh?=
 =?utf-8?B?M24vTDNSUzM4TTJSTHMzb2wvU1A3UFRaMEdJQWdialEyemYzcURicDlwSXAv?=
 =?utf-8?B?ajEyU2ZkQ2NIT2xwcENucUcrUyt6c3poWHNtQkM0dmpFbUFkQTA5Zzk0ekFn?=
 =?utf-8?B?ZmpoT2wwWUZBN1pRcUtSeHRGdWhwWWxrN3NkTGpEVm5jbjlXeXNzYllXblJo?=
 =?utf-8?B?V2JUVjRkVnVZaWdjREYrN0wzSGxuc0NPS1BVRzdac2w0MFhPNEtmc1lPRGpI?=
 =?utf-8?B?eVdoR0dIbWIvM3lueXBONm1WazAya2g3SG1FOXdIdDN3OXZycUZJWkp6Uk1I?=
 =?utf-8?B?UHc3N2NNd0lmZmVRUWRvdGcvN01aVVZJMFNqcFJvc0lRY0xQY0loc1pqdmxx?=
 =?utf-8?B?SklJZlJoK0t5R216MU9DVjBqakJlZTlQdjMwQ3RDanB1dFlTTEk2MXcrbUMy?=
 =?utf-8?B?WHpFUkNWeDRiNEkyNDFTODExakRkY2hFOTVuQkExUWZZRDUzWThxdXV0ZGhn?=
 =?utf-8?B?dU13dHJsZ1lHSTZtNUxBTmRLdml2TTk2T0FzUFBNN2lsOUtIdU9BeTFYNHdU?=
 =?utf-8?B?ZG1JcTgyNmdqVllWUk92dXdoa21SNU9tZENHdmZ4UndVOE1KRENEQ3N3VHlY?=
 =?utf-8?B?Z242UERwU3ZMY2ZZWWtUYmdob3ZQVTA1ek5pcmpJMkc1RVYrOTkxM2R5bldz?=
 =?utf-8?B?WXNSWWZZMDlJaVNLb2pVSEhUQXRXVklGc2xzcU04eDhLay9wTGZhc0EwaE4v?=
 =?utf-8?B?Tzc5S3JsTDMxUUdHM2NvdTJZM3A1dWs1Qno5MjZCZmE3VTBJeVdSa3MyTGxW?=
 =?utf-8?B?UWZ3S1pVb0VTRklZS1owVXZXVytIdDdWTFVHUHNiRUdyWENvM0ZQa25TV1o5?=
 =?utf-8?B?bXRFbUFQU3JXSW5qMjJVVGtRV1MvN2JQeXNhSFBmWmx6ZTFEVFFRaDN2YW1M?=
 =?utf-8?B?QnpzbDFTM011Sy93eTFaWmZVc0tCMjBBeEE3RitUQlpscExQRnhpZUdqOGZL?=
 =?utf-8?B?QUpqazFtT2pyd2lDUllVa2ltRVRsNGR3dEFmL2J3YkU0SWFkM1lDcGF4UGl6?=
 =?utf-8?B?bWltVDB3Skp4YVBKazMyWFNSUzRBbmZVQWxvSno1OUdTeVZ6ZmpLLy9EeXV2?=
 =?utf-8?B?NXA3S291eFU4b2V4OUc5d3JmR3J3M09acGU5UmhDSzdnVFBaRHIrN0xTS2NP?=
 =?utf-8?B?dVJZczZ4Z1A4RGtVczdSc05JZGg0OEtyWXZyVGQ0Z3k2Sk01Q05jUG90YnAw?=
 =?utf-8?B?Z0NpNG0zUWsybXJyNTJGSmhONThCY2ZxYjNkMHMxK1VRYXZGRUxQejJxMWtX?=
 =?utf-8?B?eFpHQ3JVZjU3Y2lveXA5eU4xWW84eE9FMWlGbmZCMzIzN0dOZnJhN3A3UG82?=
 =?utf-8?B?U09sVlZ0RTM1ZnJmZEp1cSs0bjBzMjY0dGVWRjNwVTZ5NUFQOTlCYTBjQ2tQ?=
 =?utf-8?B?Wm9URFVCWGwrdGNMN2JEUG9GOHlWanREMEYzMHlMZ2JYUXdUYTJzL25ZN1Rq?=
 =?utf-8?Q?U4RBiqSPVC3YBqhr85MB16K7g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aba6f02-b2e7-4015-237b-08de072f14f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 12:26:33.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqlJZwFxxU7H6QsTxMtFNWBc7JIwIcP7Ta/WEeZsxdLO03weo0pPVs9BpB4hjfA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

On 09.10.25 05:30, Ellen Pan wrote:
> - During guest driver init, asa VFs receive PF msg to
> 	init dynamic critical region(v2), VFs reuse fw_vram_usage_*
> 	 from ttm to store critical region tables in a 5MB chunk.
> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 33 +++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++++++
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 96bd0185f936..4ba34ba74671 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1943,23 +1943,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	if (r)
>  		return r;
>  
> -	/*
> -	 *The reserved vram for driver must be pinned to the specified
> -	 *place on the VRAM, so reserve it early.
> -	 */
> -	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> -	if (r)
> -		return r;
> -
> -	/*
> -	 * only NAVI10 and onwards ASIC support for IP discovery.
> -	 * If IP discovery enabled, a block of memory should be
> -	 * reserved for IP discovey.
> -	 */
> -	if (adev->mman.discovery_bin) {
> -		r = amdgpu_ttm_reserve_tmr(adev);
> +	/* VFs using dynamic critical regions(v2) won't need to reserve for below memory */
> +	if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)) {

That comment says what is done, but not why it is done.

> +		/*
> +		 *The reserved vram for driver must be pinned to the specified
> +		 *place on the VRAM, so reserve it early.
> +		 */
> +		r = amdgpu_ttm_drv_reserve_vram_init(adev);
>  		if (r)
>  			return r;
> +
> +		/*
> +		 * only NAVI10 and onwards ASIC support for IP discovery.
> +		 * If IP discovery enabled, a block of memory should be
> +		 * reserved for IP discovey.

While at it there are a couple of typos in the comment, please fix.

> +		 */
> +		if (adev->mman.discovery_bin) {
> +			r = amdgpu_ttm_reserve_tmr(adev);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	/* allocate memory as required for VGA
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 46c19e96086a..e9dbab53cb06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -931,6 +931,14 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>  		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
>  			init_data_hdr->bad_page_size_in_kb;
>  
> +		/* reserved memory starts from crit region base offset with the size of 5MB */
> +		adev->mman.fw_vram_usage_start_offset = adev->virt.crit_region_base_offset;
> +		adev->mman.fw_vram_usage_size = adev->virt.crit_region_size_in_kb << 10;
> +		DRM_INFO("critical region v%d requested to reserve memory start at %08x with %d KB.\n",
> +			  init_data_hdr->version,
> +			  adev->mman.fw_vram_usage_start_offset,
> +			  adev->mman.fw_vram_usage_size >> 10);
> +

Same as on the other patch, using dev_info might be more adequate than DRM_INFO.

Regards,
Christian.

>  		adev->virt.init_data_done = true;
>  		break;
>  	default:

