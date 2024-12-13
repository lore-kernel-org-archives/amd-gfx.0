Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1ECE7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A145110EFBF;
	Fri, 13 Dec 2024 10:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vZrS6Bcf";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1266C10EFBF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvDR4oGyrUSEdYffocEM90CoX3gBVlgJKZktib1kXcXHPIeWBKfIljtq4zu3Qv/BQzMY4Pyx/MCLZj1SqsMz0g3yHBBnyBJTpwaoWeJuIlbBQgSjYBCWt7+xpvwnl/SmC5X1XeX/yKbD4VfB55EL6/Ct6nSrSdijIjcWbEBeeuwb5I/ka5+ICj1VW1xT9TsV3RywNHGEBXH0QWQJHhfojmzbfDez9HGsupfCi8hDCNyZ7bSZZpClkesicwba+W11t7ohlFB1HNIod+WKz7oXjrumK5Jn/cRVUN6VyyIiE5mu1p9VHS7RnMYxsHFBIN3wQt7xyMFlhauMRTD6LfY85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw5UPpz+zxkzYHDD55f/VewdbuU4VZY4RapafcgD0c4=;
 b=NOfQTMcVw8oPhQ8eT67hOyLBBiXEGubax64RTNvNo8aH9XxhY5TIP0tbgliCJm74zdLago8YbGOBovtnwYs/cV+2xVna8k6TSFi0q2tIIoeCe1KkXEQGj5UPUdIKXcRhZxXvWXfmLpFSKKGR/z1zMnFJNNlZ4yEXYc9VyDlauqDDnT6hPi3sjhSvMptLylfzKSVgWRgtq4m8KI5K6GmBhKErWOcHQ0d/KXdUWusM8kFTVxIBa0BdyL5YaKaIrlviX2M0h985Md8kp50bnRwOr3GxyBSE1IZs2WFcGngvESLof0JHudWEeGYMZWQXYsqzwC2VNTEbiNXXMbq5BtAq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw5UPpz+zxkzYHDD55f/VewdbuU4VZY4RapafcgD0c4=;
 b=vZrS6BcfEkpxrNRET6QXsthi8rK8uQVwRnn83s10y1mu7u0lsh4irtwSgRJEQ7JM9hEa41tSCrljxXO3USwyT1XpezRtDCS/ofGqH87NTahzGTaxQMG8VPGsNhcsVJclPhLvB+b5SsZLQo6VLDzLdKBWYPgR8V0R0Hb9fE72V4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 10:55:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:55:19 +0000
Message-ID: <282432e7-5e90-4ad7-9374-1aec9f202cff@amd.com>
Date: Fri, 13 Dec 2024 11:55:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] drm/amdgpu: Apply sign extension to seq64
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-7-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241212142533.2164946-7-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: e51218d7-c97c-4c68-8f7f-08dd1b64a245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDZ1YVdRclVXdENnSXZPMWxZODU5bE5kV0tESnpBMWJGMTB4ZG03OHgxRlZo?=
 =?utf-8?B?dEsvZkFCQVZXZzhoYWl5dm9QSHFmNlJWUDhoTmVwZCtRamxVc0JyV2d5VFdl?=
 =?utf-8?B?NmJaQkFvZmo1eDdiamZ3SFdIMkk5OHVSc1d1b3VrRjJvWjJpb25hVkkwOXoz?=
 =?utf-8?B?QXpMSmwyS1YvYlBBQlg5UXRvZFg3OHNRTDhQQ3NhNDA1cVlPRlh5aUVUWGh3?=
 =?utf-8?B?UFFlaWUzdnQrcit3VTA0bGpHWG05L043TGdQbFpDZCtsNUwyMTBCMGZ4T0Nz?=
 =?utf-8?B?VmpsTUFxemY5SytpT3ZGZVRoMk1KL0tPV1BxOS9IQ3h0NTIyNjhISHZGc2g4?=
 =?utf-8?B?RGpHcVlOMkhYYkdaSDIyRVoydHVWbGdrQmw0SnJPU0ZiSXZPUWFETzBZeVhy?=
 =?utf-8?B?NHpLQWw1bXZXMWEzZzZKaFV6RHdzUGRtL09aS3lIcWFXWUMyOU9Yd2NORWdN?=
 =?utf-8?B?L1BnaEQwOWR5aFJHRHNoNnA2QXRFL3JBYXRoajJ2NWxmRmZ5ZDJvQUQvZFZx?=
 =?utf-8?B?aUNlMEJSNzYwUnFqMUd0SU11SzVRd1hXcFp0dE1pdnFuR0N6WktIR1d0Znd3?=
 =?utf-8?B?WlJiYis1YjI4TWRya0xvc050VGlWUTRqMWd6TnM0YjdiNlViS2pMSVBuN29s?=
 =?utf-8?B?a0taemNuaUhrZyt0RTFrTS9iU0x0VzdWaXJiOUVOMHE0WUh4TkR3dnFGTkhy?=
 =?utf-8?B?SmVvT2pESG5NTFNvRkpnNDU4Tlk3eS9CeXpET1BRUWcxaFFrWGZEYkJReWJN?=
 =?utf-8?B?WDZJckV1MnVKRFRqLzN4eTJ6MjJaa1ZDQWhBM3IzWnJnM01HVjZXby83SjdF?=
 =?utf-8?B?cHNsRDQweU1jRXRWZnVQWDhqT2tOWWVDdGtEN0daaE93ekgxRFA4OU14ekxl?=
 =?utf-8?B?M2QyYUc4bTliVDBoaWd1R05mRUtVckFHNjNNTHZQdlJoZUxJa3NLTUI2L2o3?=
 =?utf-8?B?ejFQZ3VzZ1FNcTFzN2ZYeWNUSmNUTE81aGp0YThEeHl2TCtTS051ejFBb0ts?=
 =?utf-8?B?bU93eTIreWI3KzBTc0haYmI0VGZrME1tTVJISVRJMnlNTXpiM0hBRkZrbG5q?=
 =?utf-8?B?RHMrZy80TmkyaDBscDR2a2VIcGdtMThGa2kzRm1hZEVHbFJER2NLS2NkdkFl?=
 =?utf-8?B?NXhLTEhIVC9Rckp2dGpsQTEvVDVJN3BxbDBtaE9id053YkNhck1pMlk3QzU0?=
 =?utf-8?B?MHpnNVVwQXhqR0VEbnZDaFBjd1BBdmVvZlZPRytkekZmWTN1T251V09ieFEz?=
 =?utf-8?B?YTJPZGVuQlZ5QUp6NGhtdE04Q3VBOHJBanJxSVo1eHJBT3ZXY0Y0VTZ3Sm5I?=
 =?utf-8?B?OEV3RHJIK2FQdXhjUzloT2NnUXMvbnlJc2hBd08zV0NVZStEV01nRWRXU2RE?=
 =?utf-8?B?bjE3Uk5kbjg0WUxObHJFY09DODZ6Ry9JVXJ2d2YxQk56bmd4K05jMSsxMldE?=
 =?utf-8?B?V1RWaitaYmZKY0xIQXlvQWFVbUJPYXdGMFdaNzNzaUpLR1RZR203TFp2WjFv?=
 =?utf-8?B?cTE1cEtDMXB6b2VVdGhsWDJDQ1cvU0tFc2h0VitLaytQbmc3aXdNUHprOFpH?=
 =?utf-8?B?RWR6Y0lHa21UQkU2ajZvWDB5VTJkU1RXdnAyQ3JyUW1GcUJ1eTNTMFp5VUVC?=
 =?utf-8?B?ZzBmT2c0ZE5Ka1J5WitadDg2L3NEc2pOZDJ0NnpEdkVYZUJpZlVyMEpGbUpw?=
 =?utf-8?B?OWF5MFNIRk1RS3RsbkpZZWRXVlpzWmwwOTdLdWZMMlZNRXQ4dmNDK2NYSkN2?=
 =?utf-8?B?U3NIZkpBRi9PbjlzYzJMb3ZkYTUyTVZ3QUNDcTE5R0R0WXVUTytDZDVxTFVK?=
 =?utf-8?Q?OYcgbk3yB4DbB19QHm5gQ4HXBfjRpWO/XnUTg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRGQ2M3cEE3TUV2anZzWnBZTTNuTEU5dlBYVGpvWVpqdW41QXpBSlJ2QVVS?=
 =?utf-8?B?K0M2eVNRTlRPUDFsNUVpek9NM1h6MmE1Tmdqa3dxWlJKOFYxNjlpV1cxWldX?=
 =?utf-8?B?N1JIcURJNVBERnA4dXVyMjkrVDdIaWpyWFJJZ2NOQXJqNDFHTUpGa29CaUVZ?=
 =?utf-8?B?VmVlempIVmVUTHN3Vms1RE1jdEtXWEhKUEV3OXNmT0l1ZCthdTBtbVhVWG9O?=
 =?utf-8?B?aHM1WXZJVUJWcURMbG83aEhCdWdpVm5hbitzWno2eTROVUxDWTlnVm9NdXFt?=
 =?utf-8?B?d24rSHNmWkVEaWFVQlZRQmU2bVViczlDcnB0aGdLRjdwVEZJd0kzVmNWcmdm?=
 =?utf-8?B?OGMzZTErMXFQUFhFU203TWs3aGx5dEwrT0RjNHF2RmpqZG1rOXJtRWJqTk1u?=
 =?utf-8?B?OTNHL2lzbXlDYWd6OTZwQSs3QlpUV3JIazZTNTFlZnh5TVlzSUxDYU1uYm5E?=
 =?utf-8?B?akFlYklGTzJ1c0puZFBOb3B0RW80dng4cCtQQWhOenRrU2hJb3BWQjcwbWFX?=
 =?utf-8?B?ckd1Uk1VZitJVUJMTWpDSmZGSy9ZR2p3SVM3QzZjcHZRNkkvNEhlTmJDTmhy?=
 =?utf-8?B?d0JaaGptNTBvMHhwSnVzcW1qc3JJT2k3VDVMMjJwaG1xcm90eGI5YlU3dTls?=
 =?utf-8?B?UU1ESXgrY1hTRjJuNkxlY0dFdGY1NzJES3ZNcmJUbXZSemdTV09pQkJHSmNO?=
 =?utf-8?B?YURUUUxNQnJCVk82RFhIenIvTkMrTWF1eWNTY3AxMlFUd0lrS1lTcEl2ZGpU?=
 =?utf-8?B?WFV1eTFxc2NkV1BRWjEvZ2pCTkhOQjVWQ1BQdTd1MTNlMlJUaE5Sb0gzQWhD?=
 =?utf-8?B?QVJ6VmcvaXdMNHF0YzZSTUpBN3poUGVSVnZOdjdzK29NcTVMbWppQVFlSThB?=
 =?utf-8?B?RzliMVBJNTROUktWZ3p5eVBnUjh0azBjUXoreXZZUEJ4bFl3aDZRcmdvYS9I?=
 =?utf-8?B?TFJ5RHZkVUJxTzhzRkRzS0ptdGV4NHZtbTJNcTZ6c3pCMVNyUExSc0FUeUhG?=
 =?utf-8?B?c3FjNUlYZUwvdmlHdjlBRFEwT24wdXJVWmxreFBLME5tUnFuN1cvTzFUcUZH?=
 =?utf-8?B?VWJMazRrajdxOFoyNU04RU5CMkIxQUkyYjZwcDJnQ0trMk5IVUNsTDlQT2I4?=
 =?utf-8?B?cUg4dUtvRG84R3RLeUkvYjRWWUc2QlZ2VUlRT0FscnU0UUtpZUVqeUhXV2Jv?=
 =?utf-8?B?TjJYNXA4Q3M5b25MNTBOTkJpTERPNWFuK1RaNTM1SFBENmRjbVV5OXJhSWd0?=
 =?utf-8?B?YkJwTjh0VVlUYXlBYWE0c2hrZTVmdmNKa3BBQkNjeHpwYU9jNHNXb1JLdmZj?=
 =?utf-8?B?dklsc3pmbG9YLytJd09MaklyMmg5L1Z2Vnpjei9KZDlBN3hVMWg2b3N3L1da?=
 =?utf-8?B?aTlLai9kVUttYjMrRll6bHpJQ1BXYmx0NEFucGtjWkIwSWlaamtFT2pVWWFS?=
 =?utf-8?B?SDI0VDZ3VzZjOVArTHh2RHB5R25uSlRlNWgvNmhCMXo1bjZJaVhBUHhSMkhU?=
 =?utf-8?B?UXNuUVlyTVVnU3Z3UW8vRWE0Y052cnpVQUJwc2tPVzdsTnZ1RytHalRlZW5w?=
 =?utf-8?B?bElBWTFDQTdaak5sOVo3a01uRmRsbU5GTWU3WkI1elV2b0NpVjhLYzhGSG4r?=
 =?utf-8?B?UGlXMTJWVU9Ca01ZVVZ0ZEtjYTF3OTMwcVZoMWpMRmg3bWlTeTVPVDVmeTRJ?=
 =?utf-8?B?cFErU24relJaMHMyMXNDaU5tK2RtZjlBZDI3V2JSb3JKMzRwQ1pINnVsZjQ5?=
 =?utf-8?B?V2FJVGJhNzJ5RlRhUGJ4RWNKQlRBUG5zdTJ0bjlRcXFxWS8rMTZQVXZRdmpF?=
 =?utf-8?B?dkFlU01YSkhSQmcxT2Ewdlhjb0V3Rlk0VjRLQk45UEZubzVrUUJVcEhJc2c3?=
 =?utf-8?B?UCtCbitXR2hDTU5lclRyTFg5UEMwMFl2SEZVOExuNk5zN0kwUHRGK2R2ZzdV?=
 =?utf-8?B?emVPV1ovaDQzWkNRajFxaE5nWHlGWGw3TW5FUVJEM0FZd0VDUi85eG8yb1di?=
 =?utf-8?B?MjNOTEUrWFQydkhDWjFlY21IamJmMklVekR6K1h2a1orcVVqVm1mK2JOcThW?=
 =?utf-8?B?OXYrSzlZalE1Tzh2ZWt4US8rS1BjMTc1aU03cm5MZDE1OWk5ZGVEMDZlTFJs?=
 =?utf-8?Q?InKK39rvggusnJH/theMxsIe4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51218d7-c97c-4c68-8f7f-08dd1b64a245
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:55:19.2242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKBbaakMD2L9vTigItNeMsTb4J2fvW7mskYc+SoVFRJseVrdriNX012J4yPcP2Cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> Apply sign extension to seq64 va address.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 898d215a8d99..2de1a844282e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -45,7 +45,11 @@
>    */
>   static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   {
> -	return AMDGPU_VA_RESERVED_SEQ64_START(adev);
> +	u64 addr = AMDGPU_VA_RESERVED_SEQ64_START(adev);
> +
> +	addr = amdgpu_gmc_sign_extend(addr);
> +
> +	return addr;
>   }
>   
>   /**
> @@ -88,7 +92,7 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		goto error;
>   	}
>   
> -	seq64_addr = amdgpu_seq64_get_va_base(adev);
> +	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
>   	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>   			     AMDGPU_PTE_READABLE);
>   	if (r) {

