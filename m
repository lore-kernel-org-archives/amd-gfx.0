Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB68D591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 07:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F9710E5DB;
	Tue, 19 Nov 2024 07:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k0ZMrK7l";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A43B10E5E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 07:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkDi/wrTHtV/4HgBQWu/C1vrsQRbvJNSBNaErDJ0/eKKKkGQraf+FHSXwFd37aBkbahyXuUgovYafXUF+Le1ZC2py/BNWhyl4VpleuVF/lg5hiBLsbj6+Hh9TnmW4UkkUqwz+KqYQH22aSfumQGkZHVE55rj0AOo7HlZ/hhTkNHSAWU9w6ORnjIO1GBddB/Amvw2DY8PFoPBNkv/8g0vHYDoDdRLy+hYKbnqtRlGN4cRfr9NHBpLOHFDkFFzWt6S2I5HSnYaWmVWoxZEldAg3EBjeKtXvFfSr82vhYZlzKKimzAZ7dqir8Le817Ycn/Ua/pL3SlrtSNIN9hWYTjCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG+9HUUEGQNBUpNXRukdEW3C0g3a5YaPV5eY+DVR/fQ=;
 b=tcYXVtmt1A6ioPbDz21pBHK3IYFWIbkeAAMGxPJTys0/D8YRPe+yZouT1TxsfiQHCKSRrJmY8jDDLekRj+k4OEqc5RrNddhyjcXQp5rvWWV7JAh1LXIyjIi3wTAy1hLfjGr4uETSSbzkGpFYv8Rr5mUm7QGGpGWfqKE6mJbT0g7Q8SDO6e96yyExfCfE8HC6GB80HBCO4LZu/tmdZACJ/zWDDznTu9lGdu0qwoNs4A4XtNc1GHZsMrXmM8u8/1UQPHxmN3Vzbi53eMbqBSq1E3bNhqDfSV/ypDtumPpz7jcPc/igrxznHGGi86p6a4blzZSQnIgkPJvvAAqfnDkshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG+9HUUEGQNBUpNXRukdEW3C0g3a5YaPV5eY+DVR/fQ=;
 b=k0ZMrK7l5nr9+y9bVrcjal8P/lG/BQ/SJJlwVBANhxWX8pX5fNnt+yXNojBBy6zLJGYnrhvi1xlT9uKY7R0AX2YS/NB7/WIVy1QJrqKDYs5g0qUYwPoqtWj3IjRR6x1kEshV6sfEND4lIMp9X3hOwG7AcRjgECxZ9eGJIVsLzj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.20; Tue, 19 Nov 2024 07:08:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 07:08:28 +0000
Message-ID: <26d4a94a-68d3-4ab5-8f45-7b3d3f6aa1e0@amd.com>
Date: Tue, 19 Nov 2024 12:38:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: skip the power source check on smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241119070452.438808-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241119070452.438808-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ad79b-6a11-4cca-a9bb-08dd0868f79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEw1TGtOd3ZQb1p4Unp5Z1NXOWVuQlhFbUV0VEdWNzZrUVN2UUFXaWdXMjZh?=
 =?utf-8?B?aEZHTUwvb1VRaTUrMkZLRTE1WXJKOUVUb2VYTEkzOW5Eem5tTzk3Qk1hYlF2?=
 =?utf-8?B?YXpNRnFTeVdqUEhsMitjSjhkL0FRY0FuT2FDU1p3aEFjdDNjRWNweHlRL05P?=
 =?utf-8?B?dlM4dVlEbXlROGloTUJPVDJkNjFaUm9BZy83NVVPUnRwSVNBQTMxbm9SS2tQ?=
 =?utf-8?B?dlRwamNGSVEwWCtkNXYwMVhSNDZCUkg3VitjTmFYNWJkZU1UblJpSGMzakdD?=
 =?utf-8?B?WFBUME9iYUpGemYrTXRoMkc1T2xKMEFwL1orWmIvc3FOTXAyTmZNR0ZnbnRz?=
 =?utf-8?B?ZzliSHJPTWJLc1N6TmpzYllwaUE5UzMxQlh5LzYxUjN1ZFRCMHBIMmZFdGYv?=
 =?utf-8?B?aGk4aGdMYVpBeld5cTFRTnFKSmcwL2RTUElkVkcyUnYya0NhTHg1VVlFSjhC?=
 =?utf-8?B?SUZHclR5WkphR0VnTmwwV254M1VXenNqZjVkbStUQndsWlFzUE5OV2pPcTZm?=
 =?utf-8?B?TjJPTTkwa0hDUlNzQ0tEbUVxV1hBbkdvTk44UC9mbGVZMHhNdlo4RVE0YW92?=
 =?utf-8?B?V1dNMmhid21qNUNKd2VmdlN6RThnQTZMdVNmTUhSeTdZcVc5RHQ5dXJuYzBl?=
 =?utf-8?B?c3dVNWhjNURRMmI4V2FOejQ4U3pkdzZvem1XK2g3Q2xxeHhvUzB4SUVER3ln?=
 =?utf-8?B?NWoxdGFFTzBoMWdtbWRzUGtHNkpJTzN3dUgwWGhtQzdQc2ZpT0FrczZvL3M5?=
 =?utf-8?B?Sjl1WlE3MkIzZ1E2aVJscnhIdFB5aUtjeXg0YjUwMUgwZFBtVWlFb2puVUVp?=
 =?utf-8?B?OUdQN2V3QWkxTjJrY2c3WXRMT3J3QjFyTTh6dXFVU3plQnoxZWp0OGJhakpX?=
 =?utf-8?B?dDBUYzkyMVNnVml1K01iRjRNVUlUZFppMWtLU1BNd1d6M2lPMGVKUGlraXFR?=
 =?utf-8?B?U1k5VSt3Ujd4cCtsNmxUcTQ2NXE0WEgrZE5ZNmR1UWFseHV2czhLeWoybXZX?=
 =?utf-8?B?amZuRGptekdYNHBDdVJWdnFOU25Fd3lrREpHbmlWcGlhTEU2d0ZVbWduZXVy?=
 =?utf-8?B?Y0dIYlJzd0VCWnE0VUw4Tjg1TzNlVDJ6dWRBMk9qdk0xZ0FQLzJqbkErRTVN?=
 =?utf-8?B?RkxuWGtrL2lsZ0loUVIxTDllRVdqSE1GNUw5RDMrNkl0YXRTcUlYQlRtRlV1?=
 =?utf-8?B?TUNad010cXJRK056aENxRkRqZWs0WVNVRE50QTNTK1BZbzJRMlVvc0twY0VM?=
 =?utf-8?B?MkNmOFkxYnJqNFpkdzJGaStOQ1h5czhqSWxrSWlFenlvM0pzZEc2SGZwVWNI?=
 =?utf-8?B?TWdmaEhZcTY4TzNlUS84RW9WVDFQQ1h1cytYSDZhTVZMQmxybDJ5WXJuQ3do?=
 =?utf-8?B?RWo5cVBodkVNcDVBUVVLYUJPL2V0Z2srcDZHbzFacnBSVDVIMHI0b01IRHk5?=
 =?utf-8?B?WllmSkE2MEdwL1JtVkpVOEthVGEySU04TTBSZlRURjYyOTZMU3FIdTZjSkN1?=
 =?utf-8?B?ZHI4azlEL1p2b0lLTmFoTmR6aEp0aEExNVlMa2twdUgybkhacXFHbUVrNC9L?=
 =?utf-8?B?emlFclNQbmtZczlOVlY0U0hSWGpyTW9WZzUwZjJlOHU3Z1N4aEh2L2JWcDVY?=
 =?utf-8?B?LzNwN1Z0bWRHTTJ6Vis0bWthT3Z6SU52OTlzR1ZtOS9JMjc5T0VBU2l1b2N4?=
 =?utf-8?B?djNraTFadEp6ejN4amU5Rms5bjNtdThNOE9BZ1Y0bnFIQndpQytRRnZmQ3pU?=
 =?utf-8?Q?c59vPLslIMOe6nC6GF3MAcppvz6wVZdOC+KBfEp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3cwNWdjdTZxL2NKbHM1Ky96M2tEMG5MeHBwSCt2RXBBaCs3UVFYZ29Ya0Vq?=
 =?utf-8?B?TC9aY2ROYTFPdTNIWE5DNXNyRkZpRitLUThsa09GRFRHMEM1WVl2TjJsdEMx?=
 =?utf-8?B?WXpRV3ljWC90S2Naa3ZxUUw4dGtlekVvSTVPYlIyblE2cE4rZU44L01yRGdU?=
 =?utf-8?B?UkVRelpFVmVRRmp2YVNzRG1VL1V3NzgreXNqSEN6ZTRYS1hIU0V1dCtPa2hG?=
 =?utf-8?B?VFpPZDM0TENjdDhydzlOUVhqV0VHeTJYVno3UUVGbTFNbG1mWkRpQlN5N0o1?=
 =?utf-8?B?VHgycDcyNVNqNUxSUC9obWZJT0xKT0N0VS8xa0E3MlErVWk3QnZUS3ZsTlg0?=
 =?utf-8?B?V1l3cDBYQmVjZ3BFSDN1Q2FXZGMxWWowZlRSRkF5YXRyL0ZlYnJsdlJqYW1H?=
 =?utf-8?B?U0xmS1hyQTR4b2puVVRmd0Zoa0REbkwwUlcxV2VVdm5oam1DVGkwOG1uR1Q2?=
 =?utf-8?B?WkJadW96d2dVdllLaXNMa3owRkxUZmNDUzBTZXVJVndiRW9JS1hGY3BVYmIx?=
 =?utf-8?B?R284L09IdjBYYzdUdHRJdUVqQXJvT2hkbC8wUTMwckpKT3pCZUxxeU1OSlBU?=
 =?utf-8?B?NzVSQ3NvWUJNWkZyMTlNazV5RktMR1o1em1YaVJTbzAwUC9kMktWamQ2MENM?=
 =?utf-8?B?WHNMd01Galo3UlpycHBnalZHQnQ4ZHV3L2RtdnJJSll5L0N4SlJ4bXZDSWgv?=
 =?utf-8?B?cXBYSCtraEdEYWhxTCtQNE96R1MrZGhsbmJvOUpKUDAweExGMkxMdmpwVWpl?=
 =?utf-8?B?OC9CQzJQMWFHd01XTmJvV2t4RHA5SzFyalE3TXAzRFRJT0w4cGNmNDRaZXF4?=
 =?utf-8?B?MkJpZ1pXd1hFcjhSazQ1U0dKMmpjV3NUQkpQdS9qenZsSG9uZGZFb3R1bXlO?=
 =?utf-8?B?dDdsdFpDL2szMHUycEIvb3RmdHVMNGN6K2dwUDdNRmNNbGZMR3VaS29Mdkpx?=
 =?utf-8?B?WkJKWHpudUdrSnJSUEtuU0dFR2o3TGJ4T0lTelg5OTZtdWVZTGw4a3pRbkNW?=
 =?utf-8?B?ZXpUTGo3V1RLczY5WUszYjNnVk9wOUxsNlpDZlY0a2dSV1o5WThSQ1d3eVIy?=
 =?utf-8?B?RFhwUi9ZZlM1VTBWK0M1cnpXbnRPZW04YzZmczBxdTlOSnhaTCthUVR5TGJX?=
 =?utf-8?B?Ny9mVlhlOThJWFhHbVBvdUtRUkNjc2ZRT2hlemxwVWR5UVBhNk4yZ2c0K0FE?=
 =?utf-8?B?NmYvbVNnL3BwT1N0TjNhMTFIV2g5K1V0Sklkd3pzSEo5NE5Ed0wycloyUmZy?=
 =?utf-8?B?UmNienlydzBreFluc3Q0Q0VSaE1ObnVLVkhNeTBMWEh6dnVLbkVIRlhrbXZu?=
 =?utf-8?B?SEk1Uzh1a2xHVk5ZbEtJTkZYL3U2QjBhbStHOTF2V2VwL3dmMnh3Zjh0cTR5?=
 =?utf-8?B?NG9OS2Z5QWkvclExYzVCb2N6ZlN4Y1E5blRNUFYwbTRuQnJRckxvY3NoMFJV?=
 =?utf-8?B?TmFrSURYNjdqU2ROTmMyOG5aK0tBUjRaRnVlM2t4ZzVweWxNenRUYUk1dDh5?=
 =?utf-8?B?M05GM0hZMVR4QmdSTm1sZVJuQ1YyYm1uVnBzUTAzZzlwSk1lNWx0Z0Vhb0dH?=
 =?utf-8?B?cHV2Ti9pbjZ6d2dYWS9sMkdDRXVROVFyMFRQNU80dlFqYVpRS0JSTTBsaThq?=
 =?utf-8?B?ekhVdUVHbDZCNWJQd2lVWERBRmJobm1Ga2NiMHpzOHZnTG5iT2lVV0YwdDAz?=
 =?utf-8?B?REs1OVNKK0QwVjdhU3RWVmlVWGFaUVRjaFFmTzRVTmY5ZkZWRXoraEp0eGw1?=
 =?utf-8?B?b0ZsYWdGQ0JMZWRFdWFDaUh0M24wNndwYjBuV0w2Slh0bzdvbklabUI1ODkr?=
 =?utf-8?B?eDNRcHVXNUNXbWNWTUw2TnlPNjdLWHdQdmUyZTRveTc3YWgvUU14UmsrNnd3?=
 =?utf-8?B?dE9IUzE5Q2cycnFmMm9sMER5NGdPUDkzWFlPTGVNblFOcFB2Y0cvQUdOQUZP?=
 =?utf-8?B?UW9weXdnNlZsZzJMcWJKK0plVXdlUlZjaWNlK3pRMVpmSmkwZU14N2szd281?=
 =?utf-8?B?LzdTYTdjbUgrSjN1VnlGT3YyQi9oQ1BldzQwQm5FTlA4UnlpSEM3L0dvTEd6?=
 =?utf-8?B?UHQ4MFVDcDRFSVF3ZXpDWGR0ZUQxVk9JZFdmYjhKYVJPQjdQcDNIODAwTDBG?=
 =?utf-8?Q?lRP0ZGkOJrCHoMKGATdVSw9Z/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ad79b-6a11-4cca-a9bb-08dd0868f79f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:08:28.3742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEwtj1BESw93aC6yRRUSB8yYjHwJ+1YqMnI/cELVtClAhA6mIRyUFVdKKwCdrh3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367
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



On 11/19/2024 12:34 PM, Kenneth Feng wrote:
> skip the power source check on smu v14.0.2/3
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Should the commit message be 'Skip setting power source'?

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..837281e49d72 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2753,7 +2753,6 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
>  	.get_unique_id = smu_v14_0_2_get_unique_id,
>  	.get_power_limit = smu_v14_0_2_get_power_limit,
>  	.set_power_limit = smu_v14_0_2_set_power_limit,
> -	.set_power_source = smu_v14_0_set_power_source,
>  	.get_power_profile_mode = smu_v14_0_2_get_power_profile_mode,
>  	.set_power_profile_mode = smu_v14_0_2_set_power_profile_mode,
>  	.run_btc = smu_v14_0_run_btc,
