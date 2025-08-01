Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A3C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 16:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8727F10E1ED;
	Fri,  1 Aug 2025 16:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nTUHQwYh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5518810E1ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 16:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWjBXA1uBnkPTiea82/KmrVxszY9AjRojhW4qj2PwInaoNkTwv1xeG6DkLJM8G0IDYL3f6/pkUNT9KiFejZic8KXLaI705gU2P1t+M5WlIVE4xowpze2j5H2ld08JiJGIP1mivusDlIXlrI20U2Uzg0xKyxHH7XKSyZ5oF0rEndeqz0L5Pw8oL0n69fReHMyiq0wxYoG+88D2Ft5DofR17QJm0jIEu1Bz87MqvkgaEzxwyM+IM7/fm1zv/gjzXsxLD5x3zVwxbf1EdjqCs+nUoQxiT9kB+j2+Ah8TvJE0XQCEJznaiujoICfo4xXDTz5/KfLn3aWXbzVaaje6QwNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3jqe+gb161pGKh0UeyvC0wFR3QRh82ANS89HkD0KKQ=;
 b=UgDluP2BN55HRqzgqPXs9M3lo1EujgZjfPcjyJmdtqQlsC3oBRTiED0/Dmj4Hi91LZB3Tw0bA1PSh2oUPmUIr88YQawVRDDSWElHXYUIJNd1RIZO/OEpdCMNHCHxB8Ey3xK0SDxtAozohd2fxX5jBy4yaSZhObk+xZn9qtCg58RODmnE2hU9cQw+44EomxVTgxQu80kA4t827UsuAz/tmq91Eoc/Qx1gqomwd2HcU4zJkNU1WtlbB0/CbrUfgivUw5h8FmsZm5dBK+8LE5kUyBFYc2kutn4rK0xgDnBfUwY3I9nc/1XLIur8KVbQ1/f0pYqN+gB6WFnv0BCGSp2Ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3jqe+gb161pGKh0UeyvC0wFR3QRh82ANS89HkD0KKQ=;
 b=nTUHQwYhqbbR8nCKV/pSv2fv/gm7rVxa1SN4B44VGhKav2ca0V/Hc7jF+1QQpWiRnrmc6tmek8IlAK4+trbt3qnLBR4udiERKJkRDRwgPopvEuoG3fmQNT+Ygucx2mc0/riHjvq2rpPHUKTrSV0qv/RMc4L4jixEONObFcgHymM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 16:05:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 16:05:26 +0000
Message-ID: <5324e3ed-514c-443e-835e-3741d102fae6@amd.com>
Date: Fri, 1 Aug 2025 12:05:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/10] amdkfd: identify a secondary kfd process by its
 id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
 <20250801085556.8504-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250801085556.8504-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b318f8-42ed-4d47-7843-08ddd1153a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVhvWnJUeGdUK0p4ZHgrOEtpVkRHSUJCbW5nTytHNG8xclhteXcrZXlDNy9I?=
 =?utf-8?B?Nm40aGh4eVoxMzdXTEZEQUJwWTFSQ0NkbE1aM2xhWnQ2cVVVamJjRlVQVFZ0?=
 =?utf-8?B?T21xRjFVZGNXSXpVc3F5SVVRT3Y3cXNhbENBaDRpcjlMVlRTZ1B5T0htTXRV?=
 =?utf-8?B?VUlhdUQ2Y3BDNExjeWhtbTJFV1YyQWNTQm1aVUdwc0VXeFpaTjg3ZDN4dEND?=
 =?utf-8?B?Q0EzMXRGaEY2enZRSWIwYnZ6czhOdDhJQVBHcVRydUE1TFVPbjdMaDNFaGZx?=
 =?utf-8?B?anVUZitWTm5OQitGN2QwWkx0SGt1Uis5ak5aSGNLdXVsMnpuL2FwWTdOWS93?=
 =?utf-8?B?VEJYUHZSbUJVaCtrQ1R6em5kUkNQaDV0a21Wa0ZGS2tuRlNMUnhsb0plRzBv?=
 =?utf-8?B?b0ZCTnM1aXN0b0w0eU9HT3JUOFE1aWZWREpTRFNEcE5sZGtwNTNiaHRHcFI3?=
 =?utf-8?B?UzJyclNaSlBCdHZiTEkyb0hna0FIcFZVaTF6K1BGQjlCUnp1d29MQmZWa01D?=
 =?utf-8?B?ekxuOHRaL2JwWTYwc2Ura25Xak1nMUlwZHJKS055SWRLaDZvNFl1SFgvTEo5?=
 =?utf-8?B?OGZOTWxPVmgvdWFxTWFTV0tQbk1ucGViMm9RRXd2bmJjaDVEUUlFMHRiYVo3?=
 =?utf-8?B?SFB0M01NSmgrclUyNk9LTG55a09KVTNhK1BLcVVCUTJ0RDAwdDVlVWQvdlEy?=
 =?utf-8?B?blcrb2wvd0QvVWw4WnhVNzNETllrbmVGMkdvdjJqTXBsOFhrZUlhVlVHdHl1?=
 =?utf-8?B?bDV1akpPdnZZZncwb3JaVGtmSzg2TWU2UUgrRWRVcEdKRHYyTUVNdFVyakxZ?=
 =?utf-8?B?L1RSV0I2Q3IrbFgyanEwcmd3Q1Exbk4zSTFmWEx6amJBT0FXSzh5OHpIeFIv?=
 =?utf-8?B?bTdKaS9QTmJBMEFlOUVLWHFBdCsraWRhcGRsaHRtWHNueFUvMGlWMXpPdUps?=
 =?utf-8?B?YWNyM0d4aldpbDJOeDZMaEllWXJKN3ZjclpVeEZOWVZ1eHZrbjlST3dFb050?=
 =?utf-8?B?MEh1RUFsQ2pVRGR3aXZhQkhIb1REUDRMR0RQRDIrQ3FiNUxzdkxjT3NGa25j?=
 =?utf-8?B?UmxOZTJwMTIvaXhJckdJV2NieDgzeEowR0w0VFBZYVhTYXlhNDZvWGNWZ004?=
 =?utf-8?B?TzRzZXBMNHJEeHQ4cENNWGZrM0hEY1kzQVVqejBJOCtld1Mvd01kUlF5WGQ5?=
 =?utf-8?B?SWZBajBUOGIxM3ZKRHFJdUkwb3QrT01xVjNhNVRoenpFT1FQK3ptaXQ3WEZE?=
 =?utf-8?B?eFFEYVVnM213bnNIYkNNZCtMVWRwb1VienVmc2M5MER2OU5OSU5UUnRTWGFl?=
 =?utf-8?B?OVNUcWdtME1XM0pFcHk5em9aazNkUXYxa3hzN0d1L0t0UVBDbk9XUFp3RG9Y?=
 =?utf-8?B?cXpMZTVkZHhodkxEWlNzTEFjbTNYWEExVXNMcmxSN0Ywc0w1VG5vcjhnc1k2?=
 =?utf-8?B?cHRmd0pUZG5mQ2cyMGoxYW5hRmtxU1JBS0d3dkdmNlVoNkJwOTQ4SXZrYkI3?=
 =?utf-8?B?V1FuNXV2czEybldrNTZlY3pEZFpVdkVUcysvSnAvRDBDSU1JeUZHSFR3ZitO?=
 =?utf-8?B?TVNJcXpJVWd5NjR0YnpvWlkxWDVUZ1RqbXdRa2lHa1dkcURDM2xvcU9VSngw?=
 =?utf-8?B?MUQvZG9TMnNpVkZuNVlHeDZGWVp2Y0I2bXNyTEpEc0ZCVFJaY3VlWnUvOGpr?=
 =?utf-8?B?VWFoeldFNGVLc0ROeE5SNmZvQ3FQTVVVYzY4YmEwWi9lWnNFdzlnKzk1blVv?=
 =?utf-8?B?WmRXYTkyTnZ6TElFdEhKd3BMZk8vaUowbXhGWEYzUUpIdkU4dlhFb2FCaEdn?=
 =?utf-8?B?L3lGbTFOaGlmdkl0dStVMXEwWjFkQzhzSjJDQjN5QWJQanpuZXh4clB6NVZF?=
 =?utf-8?B?bEpDSHdJemhBRUxjL0lXKzNKYlYrYUNvZG9reEcwVWU5cEYrUFlaZ3NtOTBa?=
 =?utf-8?Q?g2m6mrAn+I0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTd1d2FXZ2xkdVpZWmdQMk8xN1huUWRnbUlpSXkxaENQQnFQSHhTUkFNL3hE?=
 =?utf-8?B?MW5wTEpySzg4emtJeVZPMVFtMjluYlZwT3VuSWp4TENKd3hnU1liTk83QU9U?=
 =?utf-8?B?aDBJSnNkRlY3ZWdqTzE4bEFLL2htaDJ4WWpwWUZ6cG1GaEQ1MjdRMFVCVi9T?=
 =?utf-8?B?NTEybTBORnpHT0VGcGxBc2pCb0pobTZPL1laRCsyV3VhM2txL2xEYWpWSFNY?=
 =?utf-8?B?T2VBWkRkOU51UDJ1dDU5UFp6L3ROQ0NQUjNBMkloQzVZemZoOHN2QUI5NURR?=
 =?utf-8?B?Yk8xdEJvSGY4ejVSZHZacHNtM0tlNFhwMDVzTnBEY3VXNjZqM2RyLzU5MjE0?=
 =?utf-8?B?Y1g5ZkdtWmp5cGlpdlhsOE9jV2tobUpJZnBxTXNNSmtXWU1QWHQrSUR3WmRi?=
 =?utf-8?B?RUcwVXBqVGFoZDdtUUlhN1FQSE1iTzBtd0xYTjUxOHVRc2hGVmxUbENMcGVZ?=
 =?utf-8?B?bitzRnFRWmEzdU9SSXNwRjFuTDl3Y1JLWWlXQk1aU2prOU1tVVhEeFBaVjA5?=
 =?utf-8?B?ZFFHTDVHREYrekMvdmg4K0tTQTZTM3ROU2RXK28zYTdUVWNWNXlYVmdXb2R1?=
 =?utf-8?B?a3FpTnJmUTcxSE5JNTBiWmU1SG5ReFhTWU4rbHBhV2NsZVcvM0R0L1luWVcx?=
 =?utf-8?B?RFExWUlXUjYyK241UERRMnBNTlNiMnRYTy9rYlRleEhLZURGV3hYbExHdzBP?=
 =?utf-8?B?QWsrcU1ZSFdwZFJOY1N6Vlg3N1FSUncwcDhHVzlRbHpXL0Nxdi9pRS9iMjQv?=
 =?utf-8?B?V3VOZml4VlFEUlFyNnBHb0tzS3pJeVBIZGM4Y0U2OUF0Y3I3YkVRdUQ1Z0V1?=
 =?utf-8?B?QjFMUzZDN3BoZ1dCWW8wM2NseWdIdDNWUGZTTzhlbFFXQUxsR2JNYlZiYzVF?=
 =?utf-8?B?NjN0MzNkcHFFOEw3dW9qU3VKOWRRUW14Q1NoalVnVW9OeStXM1o3UVdFaWhB?=
 =?utf-8?B?aUpOMHh0Nm1jVnhobStEK3dZWkdpVE9lTFpvV3VaVWZKUFYzbkxHQzVVU0ll?=
 =?utf-8?B?K2tnc2RzeHM2dlNMNmhKWmZ6Y0VCY2lOeWw3a1pvSUFOc29BQW0zQytvUlRL?=
 =?utf-8?B?cjQyRkcydTQwaUtDWnYxaXJhS0xRaWNIMy9JTFpUM3UyVFIzbXd4VjdPem9R?=
 =?utf-8?B?cTlpMFl3eEhnOVR6SWZ1UFBqV1J0OTlQQkhUZ0RzcG5ERENqR0NuWUh6Q0x4?=
 =?utf-8?B?bzBvOS95bTBzWHhlTEZ5a2VuUzRqNkFGQzVLRkYrTUYxQjNDV2ROUnREUmdF?=
 =?utf-8?B?MTI1djJLZ0VsK2hWWVViZkh6Z1hISHRoV1I5M3NuTVY0U1lNbVVuTE1zbzZC?=
 =?utf-8?B?emFSa1FwM3VHbXZvbUtRK2g1djhMWXV6SkxudTN2SmhWd1BvMU1ON2RYaENM?=
 =?utf-8?B?MG9vNU14QUR6bmRSUy9TSVMxNytGL1l5Q29XTkZNQXhEZnp5bU5YS09CNS9H?=
 =?utf-8?B?aGt4NU4vbTZhS0M4bnNWM3NSNFoyQXRxSUR5Ykphdm9jMDY4TmJOeUYrVTh1?=
 =?utf-8?B?ZmlNSDVUOVg1MXh2Y25EbEdQYXpNNVpDU1RpelU5Nzh4dnp4cjMrKzFXUWpU?=
 =?utf-8?B?TTlhY01HaFRabXUwVVF4TFZ1aUxUWnZCSy9BK2RNR0MrOWNEVU5UV0xJVHFz?=
 =?utf-8?B?QnZ6TE9KUHRLWTBqcHp1Qjc2WEJ6eG5GaWtwOWFmTGJ6ZXhiajVheitLU0cv?=
 =?utf-8?B?dzFodVExa3o5T3pscGFJdEJQS1l2R0N1WnNHZnR6YUJvMnlGbnErL1FNNTdB?=
 =?utf-8?B?dE1rZzZHTlFjTE1uSTdXMGRoQVdhdWJiNVp1WGYyMVdrS3l3MmJXcWFQNU90?=
 =?utf-8?B?ekx6cFRvVnB3Z1B6bjg3U25INWxNTDVjRUxteUZRK3lyRG9OK3N6bUdZVlMy?=
 =?utf-8?B?YU1Dd0NWM2dNTEp3RWZFckNVZnJ0QWNXN291WEpaOC92N0FSTExTWHdzQm1O?=
 =?utf-8?B?dmVocSs4MTF4OG0rN3Qzc2M5VDdEWHNaS1paZ1VENzRaZ0lXUkZ3MlA4SytB?=
 =?utf-8?B?MWMrTjVLMmNDZjFveTJuYWg5WG1qRjErQ011bEVJc0kzTXJjWFdGeklFOTdO?=
 =?utf-8?B?RTRUdWZGVTNTSE5HSTQ3RGw5NU90OG9ZOUVpeFZkQ3BTc2VtZU5kMTk5RnlI?=
 =?utf-8?Q?YVdw+N4fbxIBWme88FLVtaMOb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b318f8-42ed-4d47-7843-08ddd1153a61
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 16:05:26.2717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0hy19d2Lag7e60stWmpBYluGIMaJrfMzw35inG741l4TLOhvBtmdhwbUjcD2Ze0PVEkWS4DpBO3UcwJGK+Vfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
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


On 2025-08-01 4:55, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index de701d72aa5c..a6e12c705734 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -995,6 +995,9 @@ struct kfd_process {
>  	/* Tracks debug per-vmid request for debug flags */
>  	u32 dbg_flags;
>  
> +	/* kfd process id */
> +	u16 id;
> +
>  	atomic_t poison;
>  	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
>  	bool queues_paused;
> @@ -1009,6 +1012,9 @@ struct kfd_process {
>  
>  	/* indicating whether this is a primary kfd_process */
>  	bool primary;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
>  };
>  
>  #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 440fde75d1e4..117e524f4fb3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>  
>  DEFINE_SRCU(kfd_processes_srcu);
>  
> +#define KFD_PROCESS_ID_MIN 1
> +#define KFD_PROCESS_ID_WIDTH 16
> +
>  /* For process termination handling */
>  static struct workqueue_struct *kfd_process_wq;
>  
> @@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>  
>  int kfd_create_process_sysfs(struct kfd_process *process)
>  {
> +	struct kfd_process *primary_process;
>  	int ret;
>  
>  	if (process->kobj) {
> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>  		pr_warn("Creating procfs kobject failed");
>  		return -ENOMEM;
>  	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->primary)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -ESRCH;
> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>  	if (ret) {
>  		pr_warn("Creating procfs pid directory failed");
>  		kobject_put(process->kobj);
> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>  	return 0;
>  }
>  
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	u16 ret;
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary) {
> +		process->id = 0;
> +
> +		return 0;
> +	}
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -ESRCH;
> +
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
> +	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
> +	if (ret < 0)

Ret is an unsigned type. It cannot be < 0. ida_alloc_range returns int. I'd recommend making ret an int as well.


> +		goto out;
> +
> +	process->id = ret;
> +	ret = 0;
> +
> +out:
> +	kfd_unref_process(primary_process);
> +
> +	return ret;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->id);
> +
> +	kfd_unref_process(primary_process);
> +}
> +
>  struct kfd_process *kfd_create_process(struct task_struct *thread)
>  {
>  	struct kfd_process *process;
> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>  	if (ef)
>  		dma_fence_signal(ef);
>  
> +	if (!p->primary)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>  	kfd_process_remove_sysfs(p);
>  	kfd_debugfs_remove_process(p);
>  
> @@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  	process->queues_paused = false;
>  	process->primary = primary;
>  
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_id;
> +	}
> +
>  	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>  	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>  	process->last_restore_timestamp = get_jiffies_64();
> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  			goto err_register_notifier;
>  		}
>  		BUG_ON(mn != &process->mmu_notifier);
> +
> +		ida_init(&process->id_table);

You should only init this for the primary process since you're only calling ida_destroy on the primary process.

Regards,
  Felix


>  	}
>  
>  	kfd_unref_process(process);
> @@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  err_process_pqm_init:
>  	kfd_event_free_process(process);
>  err_event_init:
> +	kfd_process_free_id(process);
> +err_alloc_id:
>  	mutex_destroy(&process->mutex);
>  	kfree(process);
>  err_alloc_process:
