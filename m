Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF09C25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 07:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E2310E2AE;
	Tue,  4 Jun 2024 07:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3EKZkVkK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A3610E2AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 07:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3WqIkimceNNWCXf1KmRX4fJSo6y19lXrDPJAeG7a4ii3ieoBADWYVimZQbm6cTjZt8Vreto/vzNAF9g5jhTjlpBIqgTXQek0lmTr+VI22JCUowMMUtnNwX+FfgdKdlJOaDdrJ/hjjehkY3sAOI/P61+oicsFERPMb4BYX6tvVOVqbajQbGhtMpw39WE2VTHKLKz2ayLI03HgOAjTGfBVyOolwq3GIW2pHEfG6G6JFYKnYFqVZjE12Nz+jArE2RdjbQvDIlAWF4A6P7HcO87A+fk6+RWbuS5hDNXpI70MWFThYADc3IuLlA8iSM2FPNd/6JtUxYPg471JM2763E3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFJHxk9UsKFuJTBGfxd2lqync6QlxNZPb6ZRSU3pxRg=;
 b=ZYBK8i6UoxGxuSRYmBApHxlTW1yLOcR1bDcsoLmTqWfubuLpzfoXXvEuzTCpOX1KnX3+lfmlcCW5kci07j7M7ZUaZ/bNV5TxY00DWxDA+JdME0driSFll+nejnzEmuk6tc9CYGY49J82GDg6CCDsDiz13G9pZdDdGnLSnVUQKQIV91k7hdt9wNTS/9IOd52OnIy83GyeVk9yFUSDIcZVeSE6L3kdm7MxxhRz3m6p5ERvsEOH5uIk/KtJFep/eGRhQrsllOwH6ZTWJU6BTgdCMzPuPKnPZyWeh9kRUy6f6jTDq1KOIkM/PMhxyGSBqToOUdM5sZGIPKeWcBBb+kayCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFJHxk9UsKFuJTBGfxd2lqync6QlxNZPb6ZRSU3pxRg=;
 b=3EKZkVkKc7jm8Jc6b5XkzIiR5pG2Y/L7OLvsEWVu5XqoQbcYrgSHE7F3PKDMEC7vPDtVIuy0Jmzwb/T5ntYC+uGc2oSUPt6D5DGwO3Cxoa81Gj9NJvE4wvCY8/GT+Ct9gp4N3IYNBgsye0koBdEq8GczvSbosmSHa7jL5eE0KeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 07:26:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7633.017; Tue, 4 Jun 2024
 07:26:28 +0000
Message-ID: <21fe0149-188b-4510-99b4-35a54805401f@amd.com>
Date: Tue, 4 Jun 2024 12:56:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: add reset cause in gpu pre-reset smi event
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20240603181258.170580-1-jinhuieric.huang@amd.com>
 <20240603181258.170580-2-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240603181258.170580-2-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 062bde4e-95b0-4acd-d89c-08dc8467a634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0IybXovQlNyek8zTHk0NWo4Wnp0UUU3dDFFQVN2MkEzWVdWckxZOUptRW94?=
 =?utf-8?B?MFBIdTJhRGFzc0dlMDNnUmhZV2tnMk9lWGE4WUZ3cEZLdDJXbk93L1ZxRlN0?=
 =?utf-8?B?N2xRanN5eGxvM1pmMHEybzh1bDdVRi9yc0lydjVSN0lKbTVXWkVZLzVUZFcw?=
 =?utf-8?B?MWtjYW9oaGF6T2ZmZkxmOXd6aVZKd0daTWY2TFozcHFnclRxL2w5aS9PUFNa?=
 =?utf-8?B?eHRYN3hLUmM1R08vbmtnMmVhRUUyMHJ0V1NhTTIrODByM2xiM2ttK08xYmFz?=
 =?utf-8?B?MWo2SzdMb1dURllkVHd2ajhuTzVRdUlXVk9yN2lhd2ZYNS93c1UybDJHQnFB?=
 =?utf-8?B?VVBxOHJGSjdwZ2swcG9zT3pSMW5SY1BZMHJwTTh0ZnIrcUV3R0YwT1FVbU9Y?=
 =?utf-8?B?bUlBaElMS3ZoRzBMZUdYMExYcjFjUVRyNHp0WWtvU2Z1V0NVWEVnM0tGOXpR?=
 =?utf-8?B?TXZkQVJsVWYyWjZQR09DZFN0YVlVRVFEdVBRMkUwZG1VUDFPc0w2U1YrMnBJ?=
 =?utf-8?B?aDU5TDFmS1Y4OUEwUjRmUlFzZmxaVFBVZTA0dlZhQ3hrSjBiM0lpd3FGRmNB?=
 =?utf-8?B?OUZwdmF1VVFXWHNLUXdNbnEzcVc5RHlBZjZwWXBXR0dMYWl1WlB2T08raWtP?=
 =?utf-8?B?Wkt1bDlHRmcrUFhUSkR4NndUNzAwMUpObFd1MG9VY0l1YldNNGhZTVhtYk94?=
 =?utf-8?B?ZGF3S3h4d1VBV2lOMnNZU1lNL3VQdXdUUjN2NStDVzkwdHgveHMwb0JNanF5?=
 =?utf-8?B?RDNOYUdIdFliK2x4WGdIVTBWUWpTeDQwOSs1aHgvb0oyTjZWMXlqZ1BQd0hK?=
 =?utf-8?B?YXlWVU9BZ1hNY2crZW5hditwcWQrcGZ5VEp6UzlneHdHOVhzUjE0QVBuOGd5?=
 =?utf-8?B?d2RKR203V1pXcjFNSHQwbHZsU0txT1FISFNQbFAwWi9ZMWwwbkg0bXdNcDI0?=
 =?utf-8?B?c1pWTnFSVXlrOHdkU3RBUnROMkJjcUdOcEdXbGhpNkUycHlqU0NRWFd5amxW?=
 =?utf-8?B?bnZXWG5xeTlCZE9jTW9IUm1jR2NRSm9SczU2YzhwVjV6cUwvK3FWZ0o3R2RL?=
 =?utf-8?B?SFE2eFJpN3Y1RGVJUHhjd1RrM2M5UUhHb29Lcmp4OEc1ZU9wSGRRa1pvb2xB?=
 =?utf-8?B?RTUxNndoeTBqaGRMeTcxWHNLUzROaWZsUmpFSkd0UThpUVp3Q2dFNEJUNzhk?=
 =?utf-8?B?QXFmYVRjMFFZUlJDWkFIeE9nWDhrRFB2MjFJUVRoRXFRUFp5a1RsalJOVHRx?=
 =?utf-8?B?bkdnNHpaYUZCUFFrTU44N2Fva0ZyelF0Y2lLRnBZREJLcmJPdWd3S3kxYlNR?=
 =?utf-8?B?TFlBakFTTjI1Q1RCQXpQcnBEeS9iVUxhampuS1E1SFRkZFZyMnZFRU02Q1JL?=
 =?utf-8?B?RmkxT09QZUpmRVFHYzI1MjRjdjRReWIrLzhOMGUzbC84MGlVWUIwMDB3Q1N2?=
 =?utf-8?B?ZVl6R3JVZzBiN25wWnJnTmtIY1orSTU0SFBudm1lR2JIY1F6b09DTG5nRlYz?=
 =?utf-8?B?NWpGMU5mVU5XbDhiWHVoVGRBT2NTOXM5Nk1jOGNqUU9qeDk4cXhOWVJVdTJh?=
 =?utf-8?B?Yk5TY2tMaTlBT1dFU2tIejBjUitOTUdYYVRqcU9BdFhTQUFHWkxyU0djN1A5?=
 =?utf-8?B?RDNQU3pXNmFqNFFBVDFwU2hQV1NjYTZqUTRnT1VQV2hQRXBDQjhEbEh4cXRn?=
 =?utf-8?B?MzVyaW9iSnNrMUxFeWlZSG5PWThPTTgxcUxyL3RVY1A1V1R4VjdFbWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkhkMis2VTNvUnd6YzBTRzZKN3ZYdnlxL095MlFNUEJGajlYRWNiMDVpQk05?=
 =?utf-8?B?RHpwRVVabEdrM0l4VUlnYjJBMzZpbjRKZWFOR0JEblMxdXV5SXdNcFdtbUhw?=
 =?utf-8?B?U3dvS3pWZXFJQXR3VmRIMVZWemx3VU5sZVpWV0UxOGZIbUczQWZBdnE4TU1u?=
 =?utf-8?B?ZVcvbW56WVJ0UGhlUU8yUXZuN2VObGRXMHZEcEthUGY2QVF2QU53STNDQlhB?=
 =?utf-8?B?SUVUZG5UeUVWaWR4N1k4bmF3dVltRkdBVGcxbjBqeWhxNVhtT2VVSzQ5ZGpC?=
 =?utf-8?B?eUtrd0RFQWhkSWFJM1BnQkZNYnUvVzFtNnVKVG1GSzZQQ0pLWE5OQTJ1NVBt?=
 =?utf-8?B?cmxNdVFlWmlVWHVLcjM2RXJ3R0YzdWRrOHYveDIwVGFtaFJHMjExeDQ4VURD?=
 =?utf-8?B?QmtwYzUxeUIwMVMyejE0cmM5T2FSSGhZbUp5RFJ6NzFSZGROV3dmRE1lZEF4?=
 =?utf-8?B?TnF5cXZaSHd5bnZKSjg3YnlPMHRFaExYU3A3ZDZuclhuY0wwaHl5Q210cFJo?=
 =?utf-8?B?WHpxMVZBZktkVkVvZFNvcnh2T0RKQzJLdnZDS1ZpODh4cHBGMVI4Q2duOUdR?=
 =?utf-8?B?MFFyZjZxYlFlS1VjakdFT2h4a051em1OSlo3TFR3VFh0NzVzVWxLY2hVckh2?=
 =?utf-8?B?MThGaEFzMnRlT2t6bVZiNklVUjlNeERpK2FQNEpxWWp2WGF4eVdUZEZPallS?=
 =?utf-8?B?TGdKc3lTZlEzS3lTSTBybi9mb1ZTQk80R1lwYVp4cWVrZWxyTFF4amxFNHh4?=
 =?utf-8?B?YWhESzFuQXVzdzIyS1lrR2tnSE1jRXpJcUIwT0c2bmFLMllPMlJiWEZQamov?=
 =?utf-8?B?bHVkaFNmRktlc1ZYcmwyZFI0YlJWMnVkOGpiM3Q2QkxZeXlCL2JmejF5RVMw?=
 =?utf-8?B?V0VTTjdNQVA0TGdwVk01ek0vdVZ1a3Z2M3h6MlhuYXdkVHhpMEVtSHROaS9y?=
 =?utf-8?B?WGI0Uy9COExPT0oyaVF2b0E1OG5DWFVKTHArdnVhT3J0cDVnVlpQQ3VNUW5W?=
 =?utf-8?B?R3oweTViRGoyeFNsVUpqNUU2VTN2TXJWcEV5bzlHRTYxQlBOd3hhMy93UUxv?=
 =?utf-8?B?aUJ1cWh1YTBlc01JYlJIMmo1djVpUElPNXBGd0JoYXFDb2F6Z3dsNTVxeUNV?=
 =?utf-8?B?c2lLcDlNOFM3REorNDVLQXZpMHRhUkN1R3JmWHlhUm5uT3lRMW9oMDc2eHls?=
 =?utf-8?B?MHdCVGRHcFphYmJuVWZoUHNjWG02VVBOYVVXblFVeHZKZk55TmwvOVpvbXNj?=
 =?utf-8?B?R0RVVHo4Yy9jVnB5US9QL2xUTS9CK282bVZCbnh3ZzBzTGpqdUVYYjUxV1FR?=
 =?utf-8?B?VDE2RXNyNGNCUThoK3YzMjBXbWhDZmVFWEsyYzd5VDE0WHRmRkRvNmFoYU5x?=
 =?utf-8?B?aFpXZExDSFVaSGkrK3pzSkROVXVOS0Vqb0tjbjNOejhqN2F5aGVwMnBYbGlJ?=
 =?utf-8?B?Ym00eFNSaW1lL2lPakJmdlFTU2krKzd6SnYrb3REZ1NJYXhjNlJBdzM1QWly?=
 =?utf-8?B?TkhaN1A0ZXIwQldvbk1pK2haMW1NMCtkZnVpUHFmSHJLT09iZjVLY2dEa3JR?=
 =?utf-8?B?a0JoQ3dMRFJjMzNDS0JodXREUlVHRUFKRThRQnlKZVVPMWs4Z2U2MzdIUVlW?=
 =?utf-8?B?UWV4N1JPMGJMYkg0ZEFJZE9OMTVPRzhvUVkxU3kyenpqMmd0N1B1ZER2V0th?=
 =?utf-8?B?ZERTRFpRYnIvUTdsTDNaQU5hYUsvbkg0YzZZSmp0clVvU01oNUY4aDlZV1c5?=
 =?utf-8?B?NWxDdmdRZFlsM2xhNm5xYTgwOFJrNkl1OTZMT0VrbEtTdzRhbnFrRDZRakVn?=
 =?utf-8?B?RVFoWENzaXVoRGtYMnVrN1QzVDh3Zlo4TFVvb2dXaXlIQ3VXWXNKZFZFWStY?=
 =?utf-8?B?dUtLVTBCKzkwQ2tZQlRRaHIrY2Y3ayswY3U1M0N6NXl3MmdzVUQ0MWNRdGRu?=
 =?utf-8?B?bUtRS2lqV0V3Rlh5TS93Z2kybFM0ME1RajdnMzRUNEdERFMvdVE4QXhUZCt2?=
 =?utf-8?B?VFAzekFBM2ZpVUlnMjc1SzRiemFlQUxSRmZvTGdjUjJBMnZEd2tHN0xXeFJn?=
 =?utf-8?B?aUFyWkh0R2Z5dlFPelhDbWxXVEVrb09CajBwVDFKaFplSmlORDZWbUhGZndj?=
 =?utf-8?Q?tR0NCQEJrTqIIlz8lbtvDXG9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062bde4e-95b0-4acd-d89c-08dc8467a634
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 07:26:28.8487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQsGq69MaBQYyIcq5nfomkhtvH2fmnmBKErjsXGiIIc2fkefceI0u59NT+z2il6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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



On 6/3/2024 11:42 PM, Eric Huang wrote:
> reset cause is requested by customer as additional
> info for gpu reset smi event.
> 
> v2: integerate reset sources suggested by Lijo Lazar
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

This series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

I think SMI needs to get all reset cause descriptions. Are you planning
to fill reset source at other places also?

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  | 10 +++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 16 ++++++++++++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
>  6 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e3738d417245..eb601b41d9d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>  
>  	reset_context.method = AMD_RESET_METHOD_NONE;
>  	reset_context.reset_req_dev = adev;
> +	reset_context.src = adev->enable_mes ?
> +			    AMDGPU_RESET_SRC_MES :
> +			    AMDGPU_RESET_SRC_HWS;
>  	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..7e945a4790bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>  };
>  
>  struct amdgpu_device;
> +struct amdgpu_reset_context;
>  
>  enum kfd_mem_attachment_type {
>  	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
> @@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>  
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>  
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +			    struct amdgpu_reset_context *reset_context);
>  
>  int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>  
> @@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +		      struct amdgpu_reset_context *reset_context);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
>  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> @@ -459,7 +462,8 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  	return 0;
>  }
>  
> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +				struct amdgpu_reset_context *reset_context)
>  {
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6711836054f9..4096cb3e937e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5775,7 +5775,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>  
> -		amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>  
>  		/*
>  		 * Mark these ASICs to be reseted as untracked first
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fba9b9a258a5..52be4e340fb1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  	kfree(kfd);
>  }
>  
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +		      struct amdgpu_reset_context *reset_context)
>  {
>  	struct kfd_node *node;
>  	int i;
> @@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>  
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
> -		kfd_smi_event_update_gpu_reset(node, false);
> +		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>  		node->dqm->ops.pre_reset(node->dqm);
>  	}
>  
> @@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
>  		atomic_set(&node->sram_ecc_flag, 0);
> -		kfd_smi_event_update_gpu_reset(node, true);
> +		kfd_smi_event_update_gpu_reset(node, true, NULL);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 06ac835190f9..ea6a8e43bd5b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu_vm.h"
>  #include "kfd_priv.h"
>  #include "kfd_smi_events.h"
> +#include "amdgpu_reset.h"
>  
>  struct kfd_smi_client {
>  	struct list_head list;
> @@ -215,9 +216,11 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>  	add_event_to_kfifo(pid, dev, event, fifo_in, len);
>  }
>  
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context)
>  {
>  	unsigned int event;
> +	char reset_cause[64];
>  
>  	if (post_reset) {
>  		event = KFD_SMI_EVENT_GPU_POST_RESET;
> @@ -225,7 +228,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>  		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>  		++(dev->reset_seq_num);
>  	}
> -	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
> +
> +	memset(reset_cause, 0, sizeof(reset_cause));
> +
> +	if (reset_context)
> +		amdgpu_reset_get_desc(reset_context, reset_cause,
> +				      sizeof(reset_cause));
> +
> +	kfd_smi_event_add(0, dev, event, "%x %s\n",
> +			  dev->reset_seq_num,
> +			  reset_cause);
>  }
>  
>  void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index fa95c2dfd587..85010b8307f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -24,11 +24,14 @@
>  #ifndef KFD_SMI_EVENTS_H_INCLUDED
>  #define KFD_SMI_EVENTS_H_INCLUDED
>  
> +struct amdgpu_reset_context;
> +
>  int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
>  void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
>  void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>  					     uint64_t throttle_bitmask);
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context);
>  void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>  				    unsigned long address, bool write_fault,
>  				    ktime_t ts);
