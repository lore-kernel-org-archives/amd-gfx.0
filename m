Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C56C54756
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 07:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901AB10E8EE;
	Thu, 22 May 2025 07:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zKcDTY3O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B6510F058
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 07:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCV7nZJEpftG9QCDFb7Ggp3hlCeqSQEucffzfbQRNdQh9UmB9jIEvstBYW6BQy2VE8CsLlcwg/aQBGi67U0j3xLhZ7saNqQnIekKALu7ALpGmnhGsLlpxmGwdD6+f9S6qWtZ+tkhpi04IAAYwljY9txdQDmhfmaHEqSzALd/EAoqvWKaBVPLzT7jCr8h77pgOSnKw+EGMO8on2vYI0QRiMnRKkNh8htWI1SCDAkkL8WJJUqx7s/2LFM0pBDloR8NkPFzFUs3dZ/RjIOzzq8DvPGXNfKRxJFME+BpCw6myKKcRtkl0xQj3BxqKH4CaVte0GUnfqvWDM7FMIab1SX+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsG7ExY/mQ7Zskb75bpv6vCKkYo3SRAYP32mK5qvytc=;
 b=X0VZydO4mxuxLA4Rv3LNGZ54+QO1FVYbP4+Tw00IlJ6/m5jA77uXDTy+tyljpZIkw5yziDKJu7KnNWMwUmSd4pnsJHqVDPPbnJ3h2dAfih6xwomYSisAfpzqjvYWHd2p786k60lmHpqXbjxR3FSOoQsWHL2i7xGLgmppb+UibdeJgmq+QqbTSjlYgYfbd+NE8MnSv42tPR9s5mbqb8iwjqiQ31Narj8SceORQ8eIVPGn6k3AcEKGQ1EHEDXR4LCPyRV5ZHzk5IWA+T7c/ksFMPHdVKy+x9CSnc1EPflJafi6KPlqH6sMW82sfNB6dcoBmCBHveeJQTZVjSHZbjnzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsG7ExY/mQ7Zskb75bpv6vCKkYo3SRAYP32mK5qvytc=;
 b=zKcDTY3OwuVGD/Azskt9VSqvmVIRbpHEeAPFMfNTMpEjZB9iigc9eCrCxJkH8g0KCSL7HZNaV8gS5QG+ELYJmg0QQlkXTdcoLt8cUdW16+UC4mqpGRNNRIAKohHtfc54bTupA4RWGt2xncwJNFNmCyLfMdqhZudQNkQNXKlDeJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 07:07:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:07:58 +0000
Message-ID: <6955d2b7-2dc0-4161-b97d-5377b6d81a5a@amd.com>
Date: Thu, 22 May 2025 12:37:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] drm/amdgpu: update xgmi info and vram_base_offset
 on resume
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com, Jiang Liu <gerry@linux.alibaba.com>
References: <20250522034350.433219-1-guoqing.zhang@amd.com>
 <20250522034350.433219-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522034350.433219-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247a485-57c7-4a52-27c5-08dd98ff6208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUxPWUNlYVoxNzUrdHEybk9HNWlJTk0yRUI2YnlDTHZCYVdaL3puQnV0V2lD?=
 =?utf-8?B?NHpMUElUNXRHWEVPYkdtNTFPYTh0Y3dIbXJkUmQrSzZLM1ZnZkRaUnhMUDhO?=
 =?utf-8?B?b2F6Z2lKWlM4aEovV2NucENYOGs4TzBuOWVNWGZ4NUU5bUxVMTJTZUYxMHkx?=
 =?utf-8?B?RTVVWUR0TzVyNS83Vjg4cGFPYWFsem9uNGJjTEtpN2h2dXRzaTVEa3FCVnJs?=
 =?utf-8?B?eWZ4c2l5ZmxmT25Ra1ZjLy8rbFVZbXVzbVVLeHdvZjhjV1lzL3pZMkRxRVAz?=
 =?utf-8?B?OGFJQStCK2swSzU1MnlWcG9NblVwNnd3bkVhZ2owM3FUZjhvVEViUWlBTnM3?=
 =?utf-8?B?T3NTeHJaV3JMQmtpRjRoYVlmTU9UOE1NQ2JnRVRvcmVEYVA4S00wMUhJdlp5?=
 =?utf-8?B?ZDZLS2tWbWc5WCtySDlkdFZZWXJ0VlFMdUZBazVnT3dUcElBWFhMNkc1RXRC?=
 =?utf-8?B?dXNRSUg0OUNFUjlUNk9RVDFRMHo2Y0RyUjhZVmRWMy9mNnJJak1jbkN4b1hY?=
 =?utf-8?B?OHU5STBVTG1UZzJ6RWljSUIrcjE4a250S0ZZM3VrQjFNMS85M2dza2o5UGxt?=
 =?utf-8?B?aU9UMXBrNU5zNGJIOS9QR1ZzbXlWZWlsQ2F6NHhHRFE4RUZNOWdyY1RBTjFu?=
 =?utf-8?B?TmpHK3o4b3RML3JJc2tDZlBSdEpuZS80K1FzbzczSHZoU29kbnZQMW5NM1NE?=
 =?utf-8?B?ZGU3VWNPMUpnVlJWRUoranMwOGwxL3A3UEQ4citLVzB2THc4NjZVQ1dJWjln?=
 =?utf-8?B?NnpYeVpYTDVkV1VUdk53V05GVUdsSlZacHprQTVEU2hjRjNvVk5KRE50WFRI?=
 =?utf-8?B?cnBhdUhJV1l0YXBYZ2FNS2x2YkdmTm5ETU9MMk9FYnVnWUNSVW0zaHBBanB5?=
 =?utf-8?B?VDNoU2FJNWRqcVh3NWdWTG9SaDRNNnNLczh1akdXWGVWNXZxMW4xbDdwZkhq?=
 =?utf-8?B?a2E5K0YxVTlMc0RtbW5xR1V6bDRwZlJmYjdLamhtWS95NjVodHVncVBLK1dP?=
 =?utf-8?B?dmtUUnczb0NJcm15SnY3ZVNvODk5YzlmWXJxTitqOG1zVFZSQzV0UHRrYkk3?=
 =?utf-8?B?NjViUUFDN0NjSFQ4c3Bna0owb2NCZVF2YWlpMWNQY1JVK3ZKRGhSVmxsYmVl?=
 =?utf-8?B?bDM5NS9uQ3JWeXNaMFFLYnVBYWh4dGtqejB1emdhT1lEamYvY3dSNHN0dHl4?=
 =?utf-8?B?WE9uL1E4bGYvbHAzQ2ZzU3NXNjNSS1BEWFJRZVhxUWViM0Z3MXBncmV2Wksz?=
 =?utf-8?B?NFdveWZveHgvd2Rtd01XWlV1eTU0UjZxMjdYK2tsNHh3TWtLYWt0ZlR5WnJN?=
 =?utf-8?B?NkdYUlRzVVE4ZHFaTUVUTlV4NkkvUERxbjhUMUZQWitjZExiQjA1Qm9ab1Fh?=
 =?utf-8?B?T2dRU20rNzFtR1NONFNmWGpFUno4SUMwV0ZrRnozbGV2S2tzbFNBVmc2NkFY?=
 =?utf-8?B?WnhYSSs3TmhsYXIvRTVEc3ZHTDZnT3hEN3k2R1d1bDAwa0xhWUltaC8wSjNt?=
 =?utf-8?B?ZTB6NnQvSlJUYzlhU3R5RDh1S3pFWWNjZy9jYVZBcC9ZSXJobHZPSjN1Tmhz?=
 =?utf-8?B?a3hteGU5RFI2aWMvaDZtS1lxVzJHOUpSVVN4RVJSMUo2T2tkM3ltVkZpMlRw?=
 =?utf-8?B?Ynp1TEhYTFN4ckwyYkxxeEp3dUxEZmFoQnRuVU9tVWYrdmk1eU9seCthR0pm?=
 =?utf-8?B?ejBXSVpjS25DdVlWbVM1Wm9lYTNCNmdLcTlDTzR2QVptc3VWQnVST2dxZ0tW?=
 =?utf-8?B?Smo4TGhEYjZPSVAxdjBERFBOeGszZXd2a1R1SVJ4TS9NWlB3Q2lKdDBLMHJk?=
 =?utf-8?B?MFFqN3RmcTljOFpsT2UycXF2dlhIRGo3aVhjcFVJa1RKZ1A1V05heU1lemM4?=
 =?utf-8?B?U0JpTFlzemF0L0lqN3ZEQnEwMlhhdklvanZHQWVlZEtiMFp4WGVjUVlzU2pm?=
 =?utf-8?Q?2dCgZMg9M+I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGo1RHU0Y1dWY2FUMVdCYXJVZjdRYjV5eHR0S0NTcVJqNmo3dW05RjUwL0pP?=
 =?utf-8?B?Wkg0S3NmbDloMUNlUnJUSTV5ci9NV1Z3SE5STXZRM1g2cXJTNWdrVHNVSGF1?=
 =?utf-8?B?V2t5ZWFaWEJZNnJKM2t1bnJkWXBqeVMwTU9RWHlKS0JVeXFHMzROdW52MVgw?=
 =?utf-8?B?MUowMlFtVk9KZFIvK1ErcEJsV2MwWW92MkVwd2taZit4b1pudy9mcU9FQU1E?=
 =?utf-8?B?QUR2NnVUZDNtcWM5Y1VJNTFFSnplYzBCN25XWXFJY3RVcE93eWh5ZnVzZ2Jh?=
 =?utf-8?B?aGwvUisrODBESEtBTUZBOXlGQTlLSys3b29tdDY0VjZFaXlDVjR0QXY4VG9J?=
 =?utf-8?B?OTNFWEFRaDlERzBHS3BLcFpLOVpGOTA2RmtzcitlU0FkTnBhSVgyeFpTcXJG?=
 =?utf-8?B?NVByeWo1VXQ4WTBFTldmYmlEMVdseVIvU0FETVBoK1JESEU3UUdqVGQzSGZ6?=
 =?utf-8?B?NXBCN3NXWi9VN0ZqYlJUdkdqZ3Q1cVArQ3JvZlhrc04rblBLVk9icW91aitH?=
 =?utf-8?B?VTJOUWN5ZGloODM3SHFGdCtPWmVZUWNoM3FLMmhjRVVsZUdhOVByT3pReGJ1?=
 =?utf-8?B?UnRYT1lGSnVmc0Q4Z3RBb1ZPbWErQUlzMjRYQ205alN5a0I3dkhWaXlzNVgr?=
 =?utf-8?B?L1F0dmhiUHdZdzZmZ2hyUkFQdnBRNGtvRzdaYithSEYrVnlTaEtjQldwTjE5?=
 =?utf-8?B?d3VhOExWZXpHRW93ZFhXNzBRUXJkcGp1UGljSFQ3K2k2bmtPeG9Eek4vMHBO?=
 =?utf-8?B?OEFHRjU2d012NkpGRkE4bTR5S3diTVFCSFcxMnlNdmtlbFpNZXR3d3NGZkJZ?=
 =?utf-8?B?WElYSVRSZnZ0bHVleTR0RCtNSUQyc3RxV2YyTnNyc1NZOUx0bnVDTWUvMEJi?=
 =?utf-8?B?Z2c2OVdhWGp1YTNUc0JkZUJoWFNsR09BQkIvYmhUT2E3NG5GTUp1NnpEUEd2?=
 =?utf-8?B?UVllL2ZIcGRhOThKMkx1UUY5RHROemtFcUt0U2xtRTJBVHZFZTBYK2tLaXV4?=
 =?utf-8?B?NlhhcXIzb01yM0xmS0NraU5iV3NCZEFQRVR0bUJjby9PQkY0clMreXRwdzEz?=
 =?utf-8?B?bTd5dXRtT3NRZDNwaUZMUzBXdThDa0l5T215K2RJalkwRUtSaDVlc1BKWkhO?=
 =?utf-8?B?ZExVQ1J4dFBORlNtZFhZSkRZY01GbTBhZ3Q4aUE4dExtbExDSlBlTWg4SkFZ?=
 =?utf-8?B?S2wwNlNONUFZdUNaalRTOFpvNkJWV1FzcEpvdi9yeUNqeGFXbkRKdzNyVnJo?=
 =?utf-8?B?MHJaNnNQOEZ3cWR3bm5JdnBvTE82elkrTVdJWHVIdW4wbDYvVnpHWVlCaTJj?=
 =?utf-8?B?UWpzQ0hpM3pZUG1Hbno2YWJKaXNXR1ZOdGt2QWlDWGJRc0JTV0tjZWt2Qkt4?=
 =?utf-8?B?OFBhMDBnYjFwZGkzTWh6QjJRa2FsZ3lRSXVHTXpJcmdhU0MyUXBkTDNUbGMw?=
 =?utf-8?B?UzYxS2VuanlMMnNpRURyUDg3STdpUWR2MjVkeVJPbFBFcHFNWnlpSzZxNGU0?=
 =?utf-8?B?SkpBNWM1aWw5Y29FNnZIcHRUazg0Z1IrWTA2dWQxcTBWaEhnZWp1T1lwWFVi?=
 =?utf-8?B?OGNKSGpmeFdIODY0NzRkWlpueUlTbUV6NmJlWlJIWktMbm1HME5xbEVqOEN5?=
 =?utf-8?B?UURWNEZ3NDl5NVhaSUVDUUtFZ2FPZ2tuZmllK0lzb1lzblVXVEpGY2VWN3Fp?=
 =?utf-8?B?VzhTMlVXTlBLNmNYRXJsN21HT0JDZUxHOC9sdHU1UnpaY1BmT0JQTFNzN0Zo?=
 =?utf-8?B?cGFiVVJrNzhZZC9ldUZna1o2UHFXWVVaOXFGTkFNQTh3VnI5M0xsUUlZYzFz?=
 =?utf-8?B?dUQ3bEw1UE4vWkZFV1lSUmoxYWJ1ZFJJOXdvSUxkOVFQSEtBU1dGcWVha2V0?=
 =?utf-8?B?d0JQM256NWU0NDZEMTB4U2J6UXpFZGhOeS81b3hCVWRFYXFqYjhkckFmcDhJ?=
 =?utf-8?B?OW1RN25leElza3l5cndQMU0xVEd4Q015eGoxZUtKR09CQ3E3ZTFmeVgvbnlO?=
 =?utf-8?B?b2lSU1VVenFtM1lKeC9rWXZYTDM4M2FNYzVZYzhBZ3VnYjdhM0NzU2VJaG94?=
 =?utf-8?B?OFhOdzF5cWpJOFh0dklUVFhDbTJIV0pGY2VwUStUU0hPeUNPOFBKREk4eXlL?=
 =?utf-8?Q?VQqH9WZeoi8Y30QDAz1px6R48?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247a485-57c7-4a52-27c5-08dd98ff6208
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:07:58.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yss9QaAphbPJOG2YmZLGxAEx7jJ+Ujp3utSsJZGizmkvkkvWASTQYTZNAVC1w+q4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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



On 5/22/2025 9:13 AM, Samuel Zhang wrote:
> For SRIOV VM env with XGMI enabled systems, XGMI physical node id may
> change when hibernate and resume with different VF.
> 
> Update XGMI info and vram_base_offset on resume for gfx444 SRIOV env.
> Add amdgpu_virt_xgmi_migrate_enabled() as the feature flag.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 +++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d477a901af84..e5bb46effb6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2732,6 +2732,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	if (!amdgpu_device_pcie_dynamic_switching_supported(adev))
>  		adev->pm.pp_feature &= ~PP_PCIE_DPM_MASK;
>  
> +	adev->virt.is_xgmi_node_migrate_enabled = false;
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->virt.is_xgmi_node_migrate_enabled =
> +			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
> +	}
> +
>  	total = true;
>  	for (i = 0; i < adev->num_ip_blocks; i++) {
>  		ip_block = &adev->ip_blocks[i];
> @@ -5040,6 +5046,28 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  }
>  
> +static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
> +{
> +	int r;
> +	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
> +
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +		return 0;
> +
> +	r = adev->gfxhub.funcs->get_xgmi_info(adev);
> +	if (r)
> +		return r;
> +
> +	dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
> +		prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
> +
> +	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +	adev->vm_manager.vram_base_offset +=
> +		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_resume - initiate device resume
>   *
> @@ -5061,6 +5089,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  			return r;
>  	}
>  
> +	r = amdgpu_virt_resume(adev);

You may restrict this to VF only for now -
	if (amdgpu_sriov_vf(adev)) {
		r = amdgpu_virt_resume(adev);
		...
	}

Thanks,
Lijo

> +	if (r)
> +		goto exit;
> +
>  	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>  		return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index df03dba67ab8..532b92628171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -295,6 +295,9 @@ struct amdgpu_virt {
>  	union amd_sriov_ras_caps ras_telemetry_en_caps;
>  	struct amdgpu_virt_ras ras;
>  	struct amd_sriov_ras_telemetry_error_count count_cache;
> +
> +	/* hibernate and resume with different VF feature for xgmi enabled system */
> +	bool is_xgmi_node_migrate_enabled;
>  };
>  
>  struct amdgpu_video_codec_info;
> @@ -376,6 +379,10 @@ static inline bool is_virtual_machine(void)
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>  #define amdgpu_sriov_is_mes_info_enable(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_MES_INFO_ENABLE)
> +
> +#define amdgpu_virt_xgmi_migrate_enabled(adev) \
> +	((adev)->virt.is_xgmi_node_migrate_enabled)
> +
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>  int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);

