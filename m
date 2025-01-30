Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD47C0219B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5600B10E90A;
	Thu, 30 Jan 2025 09:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Noy+bCNx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07C510E90A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLfkIGRMSQjQclLOdaoPtJCjZMf1KrVxwmNEwNcUE9l5c1qJmyGGWqUX9V5jE2BMor2jZeFgCMx1kCDiHMXXraGgKXokm4DzACumiLVRfD71APS5C6A4Yd0XnD+9uG1G9cYr5hDB0LoOMYOyYGOhBQVH7FWce/4qfPPi2inq4JTVKVjYE3dASjeLZqDcvpXaTm4bk80bKZ65VOnYuJXgfEAdac55F2G006sHyMB47q7ATLnwNEEfanPA4EupWCCjpPst/b5t4ZD6l+sCjVoM9Qxf2XnlRyAtc7KKmcwbQZ7LlYxWjMY1nIEknOMbs2Nshs5kmTkdZv2pud7IFk8ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU8xlhVwXpG0ofQDnJDBvJNsos0hwcU1AnoGV1vvOIo=;
 b=pOuwBG+/zO6tgQ2rZXhun2c++FvMU6td9z2+LJYxuJ0J3glvIROpMe0axFqVuricFlm62tJb9t2+wkiUwFz9IjtYylBWXDuofK7yCJNKNFRDQq8mafVMfdAY4rd541U06Y1QFFMg2jq3xgLO8faQXDdJPH9/ucf04P8bWndSBWWVnWtu4xzpar1e4Y1IbbsIi/hxrJ01el2nkvdE9dhrdNzCzXFFd5iX8qOZ30/19cUo8wyHhnfWyQhsE0IShjtfcUYlkIQyJGqBHzQl7GLB4IH2Vp8C3/+LXN76qLBKXkJ13Ha4wQHEN5pGKtvfBcFmFtScb244u3PFj97EbBR4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU8xlhVwXpG0ofQDnJDBvJNsos0hwcU1AnoGV1vvOIo=;
 b=Noy+bCNxnvLJ/ohIoyZHFilaLEupms/E0My9b1scDe95hlT0eF3ZMmLbPcaYZpsmECIMmkaUtwrlObUxq1hr6CpaV1K2LnseuAPxMBzaalduA8Y8Jz6ePUVZ/HrGLyVKy7nHWmrjqTSRTGmb6PpTLX/f7O5N7cE1SMM7nOFusgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:39:26 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Thu, 30 Jan 2025
 09:39:26 +0000
Message-ID: <4c335137-d809-454f-b2fe-e849ae6cdca4@amd.com>
Date: Thu, 30 Jan 2025 15:09:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable gfx clock gating for gfx950
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Cc: Le Ma <le.ma@amd.com>
References: <20250130073141.2219121-1-Mangesh.Gadre@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250130073141.2219121-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::51) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b23dee-04ba-411a-2916-08dd4111fc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkhVbVd2bzZBTUtVbkwxSVAxbnRxZ3dqT0k4c2lnSmdKb3hyRjdDaXVEL0dH?=
 =?utf-8?B?bUFhTy8rMTZRWU5wMmtsc3kwL1BsY1NuejRFY3pMZ2JFV2RiMDJid0trcDlY?=
 =?utf-8?B?QXhNM3p0aEV6dlJIc3dYeHRFVnhmZGExTWtBT2VGckwyZjRycjVDMXRYUGFh?=
 =?utf-8?B?RWFRcVBMV080QzEwWU5FVTlDSWZjaGVNQ0QzcnVXTW4yRHJndTdITkN3MCtI?=
 =?utf-8?B?Rm1TYXNIRjZFY2hqRFJPcUJhZzZxU0xnQjFpMVpvdXBVdzljTGVXdTB0Qlg1?=
 =?utf-8?B?V3JPYW9FUVhacTA1NlpjN1VqOUNpcEJ6d3FLeDVCQkhtOXhzWEhLWERiNTdq?=
 =?utf-8?B?UlM3QStCMjc5a3JZTytGZWNDVGZUeHlibldSRno1MGhnVDZxeHpYZnMwRlVL?=
 =?utf-8?B?YnNOVUNyMHI2eWE4RmxSVkhFZHkxZDdTcittMG1oZktobHdmMjZmdHRCNFRl?=
 =?utf-8?B?bjJDV0JzOVowMHVaUExRYjFMZXRxaGNjTWlNU3hYZS9md0pSUjJFcTZKbU9m?=
 =?utf-8?B?T1Q2MTlmYnF4QTJBc3UvV0FURXJIODZaZ1prRHowR3dyQ2NpVmdPZVpkblJD?=
 =?utf-8?B?NTNXZmxETmsrWHdqQzJCZHc2UTI4N1VwWlZ2VzdRaU84aExGSTdwY09yN3FF?=
 =?utf-8?B?cWdzdW1HeEJRUDlkMlZ0WWNUbyt0RVdnNDBSL0x1aTRCejZEQ2hNZG9iZk9u?=
 =?utf-8?B?YjYrSlF2QTVhNmlrYStwRE85TS9keGpaUVM0SGRzTmJhZmRmY3VpYmVjck15?=
 =?utf-8?B?NWYrOHZSd1FjaE9QdGR4eUhHcTVVaTRHRGhwbUliY0hkVnM1ZzkrbUQ4SkJR?=
 =?utf-8?B?TFhkWU1PMjVXRUNQMlpOWjRzR2ltWVFaNkFscVlUZWFiemJPMUhrU01XSjgv?=
 =?utf-8?B?d2w5eUUxQUZPQThXTnNjQ1ZIemUzN0ZrQ04xalI3WmUzSjVLQVRra1Q0UlZH?=
 =?utf-8?B?S1V4YjNGOGN2Z25na1RrdnZ1NnQ1MFN5eWlRZWJqSFM5UHNGT3dUVmdyZjMy?=
 =?utf-8?B?NGVUTGFEQUsxcy9RZnVsbGxCSlY2Vi9iTWVoREVGeExQMUlCM2pGenl2NkND?=
 =?utf-8?B?OG1TTHRrRU96NTBHK0xPSEpYN05XT1ZPVjcyODFndWQzcGkwYmE3ZzB0N2dK?=
 =?utf-8?B?OHpCc3RFWkxTRTF0WXNDVnhzODNjcDJDVi9LRUM4TllTd0x3NGRHcjdSOFNR?=
 =?utf-8?B?ZTQ0R2ZQS0NSV3N4MGRZZ2tDNUllNEZ1aCswclE1NGJwMUVwL0NMcCtWdzk2?=
 =?utf-8?B?eFFZVGRMTWtRVXJYSFk3YjR3NWJVT3VRRE5Cd0xaQWg0Mlc0RDltWFV1RzNs?=
 =?utf-8?B?Q1cvTlo3WFBkcFkralVwT2xEWGhyNnhhanNDdWhpMGJrR3dpakovZkdJN0JG?=
 =?utf-8?B?bmpsb1I3cURocWpYaXRqWE04WHZkL2U2MHNhZzF6RjlaVlRPM3A3bDZLaTlE?=
 =?utf-8?B?RDhxdTBiTEdyaGNwa1F1VC9lbjRvbjhkS2JoSWtmWlUrc2RKVlR2QnJaZkl4?=
 =?utf-8?B?VXJlQUFhbzdDT0lMMHJvbkR3WmpLTStGSVlRRlF4S3ZET1NnbnRobVFtN0V4?=
 =?utf-8?B?M0tLN2F0b25hMkZOODk2Nm03TnJTNklKcEtVVEdKOFk1cjZsVVNjdDhwekJi?=
 =?utf-8?B?KzgrTjFYYktvQ21zSXhNRFBTUTZkRm5BWk9YMUdvT29iZjhJVFZiVGhTRWln?=
 =?utf-8?B?cE1NbHM2WVhqWE95Myt4RWNkaG9oVUFOeEFxdGtSZmNHNXkzemh1eU4xalln?=
 =?utf-8?B?dGlMSnhKaHVZYzhpc0hBOGNheExtMmVlNGkvN1NnN1RuZ1FlMnhsOURlUmlK?=
 =?utf-8?B?NXlYN3NnZW1SVlUwdmJFM1BYLzR3dkoxRzVRZVBRMW9nc3crRk40ZWpyL1A2?=
 =?utf-8?Q?Rm0zI7zr6e3zx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1nSHdRZE52Zk5BeXZJZjJHKzRDV1lNbzhEbURYR0VvcHh2dVhCSWRwZFJX?=
 =?utf-8?B?a09xdDlnUlpCUStGQlB6Skdmak9mazQxZHVtYTFuRFhCVEFUbHZLL3V2RzRx?=
 =?utf-8?B?Mk43OW03OU9qQy9GdittM2xVZy84SUJwNFBjZ3lUWXU0cENFSzNubzg4Nk80?=
 =?utf-8?B?emVMZ1lDZUp2NElRbEZaYlVnMFVwSUltc0pYYVp6cHE5M3JKTUhGa0VWbzRU?=
 =?utf-8?B?YUZJWmFDV2NzTGdUV2ErL1pNREtaaGpycHRYQ2JpbHFPQTh1OVpmdTZSRzBH?=
 =?utf-8?B?aCtUZHNwd1VmOHpEeWFseWhEQ1V0dUR1L0RRK1EyeUxKWnJodXg4WDNaUGxH?=
 =?utf-8?B?WWR5VmFJLzh3RDdOUkttb0NRdDc4S2lCM2wrMkJvc0xBNmVJdGQ1SGVTUkdo?=
 =?utf-8?B?N1J5TFMvN1hGN2FzbXJ4ZWZPQ2Z3ejRQNzRpYlRJWElVTXZsRVlaUVQxWW9J?=
 =?utf-8?B?OTZBSUpaMkV1aUdNSmFEUUk4ekhvbFdtUlprOGpIUENDR0pnc3J3TG0wajB2?=
 =?utf-8?B?anRHTmJjWnNoQ3N5anhOaFh0NGpzSk5NVlFEVmlNRkhTR3EvZ3NsbWNUUmFN?=
 =?utf-8?B?Q25sZDlPTGNPeEM5Z1QrbWFBb1dwVnJqQ214QVlQYmwvVU1vS2Z3YXJzNzFY?=
 =?utf-8?B?SVF6RWZ3VFk3SzFXTHcrR0oyRW81NlN5SlBPaUFkOTUvckFub0ZoKy90Rk5H?=
 =?utf-8?B?UnZmMi80c3JQUk1ocU91NFdrR2d1b2ZYOThkZDI5L2JCUlBLUi9vVmhqN0pO?=
 =?utf-8?B?Z01OOGNoRlg4b2F0dGlUcWIwcGptcEY1T1ZHZ293bWN1ZUpTRnZ2QlNzYi9t?=
 =?utf-8?B?WVd0a1ZQSmFMWnJnNkswSEZDVHlxM1pRcjdEOWl0Qk5pVk1BdlBYY2x3Vk5J?=
 =?utf-8?B?QWJMcG0zS3c3b3QwdU85NFR6NTRaYXQ0eDYzSlhWbjkwcmltbUljUjY0MlVI?=
 =?utf-8?B?VWo5M3ROK3VtSFNXYXNOU0UxZHBXVFV6a2I3WmpGeDZJZXYxQVJOOVErOEZ2?=
 =?utf-8?B?STdGU202ZkV5Rm9hMmVSSWZHSDFwTnNlck96cmF0Sk5pS2ltczh6OFJ0c01i?=
 =?utf-8?B?bGs1bldQVHEzejh6WWd3N0pDUWl0SkZSejlGdVBmTGUrMkg4Ty9kOXN0c244?=
 =?utf-8?B?S3pqbXpFaDlIb3VpS0UzcTY1ck5iTjUvVHUvdGJnamNNVUFjVC90eVVKQjEw?=
 =?utf-8?B?UEFoZjNkTTRVNHc4SDkxYlMyOUdxU25xcTJaa1JkYk9BM0lOQXZpZGVVeXNT?=
 =?utf-8?B?Y09OSWFzKzYwNFNrc3NRVXJveUhKMjFueFhSbFZsN3M4Mkwzdi9mbXRXYzI3?=
 =?utf-8?B?dlVsMFVndjNjcEhFNjJSaGxXTlN3RVdlWXVVYWp1bGM5YURqVDh6Z0psTGhZ?=
 =?utf-8?B?cFJEZzZiOWNRa2psS09IUUZvQ1pVNjNpbUsvWmJER2xlaWo3UGZMQkcwUDlZ?=
 =?utf-8?B?V0l0SnBWUjVWT2tyNjlGZUg2VjBQSnJqZzMvVVNLQ2dHZElNTWNPdUVkbmNX?=
 =?utf-8?B?ZDFqR3U2M2JxU3VoQkorK0VIZzZpc0ptLzVNYlBCNHZhbUorRTZ4R2JvUWZL?=
 =?utf-8?B?WGNzS3FNRHpwNnRIVktXZmQyeE9LdmRiUTZPWVRTSER3YlJoRzlwMzFKRGh0?=
 =?utf-8?B?dTFibjduSTFkeFdQbXd0YmFVc0VZMjcwaUFQcWRhTUlrckdCVVpMV1lIMHRu?=
 =?utf-8?B?VFF4Vld2K3lac09KRW52aERuV3BPTm53UTlFdndzN0lSNVZBQ0QzSGJiSExp?=
 =?utf-8?B?TGZMMXZPMk5SUUNMQ3dnRVQyTTZjZjNxZjYyRnE3dmdpN2E1ckJ5T1BCWHY0?=
 =?utf-8?B?OHBKbHJFaUtVWFhGdFBOWDVJOWh3Vlg4c3lYbEEyNTJzRFhCVkJjTUpSeURr?=
 =?utf-8?B?dEFtY2JoSHp2UTdkcTdsV3FkdUd6TzB4M0YwRHVWZTFLNVFidUtVK283WmNy?=
 =?utf-8?B?UXdsbjYyYStNeFZ1Qy9oRmhvbUVBcm9NS0ljUHFoV1hTcFJnQzNFTWpLcE8z?=
 =?utf-8?B?SlY5QUdvU1dIMDJuS2Q3R0VIOU5VMElDQnlqRG4wdERpVWZvYnQxYXF5S0ZB?=
 =?utf-8?B?L29aL0lIempNMjZTSVFYSHZob04ycTNMZ1NuRzQ4SHQ5ZGZSd0hUSlBBMGlr?=
 =?utf-8?Q?NUTom4uXbXSVmv0+SFZHTg+bN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b23dee-04ba-411a-2916-08dd4111fc61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:39:26.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B82ib6GRUGWY0eqcPUcUNO+xEv67GwidKE05AMmR+smIxIFOEkRyNmOkhULTsRNR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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



On 1/30/2025 1:01 PM, Mangesh Gadre wrote:
> From: Le Ma <le.ma@amd.com>
> 
> The CGCG residency can be observed with the change.
> 
> Signed-off-by: Le Ma <le.ma@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

This can be dropped, no longer needed after -

"drm/amdgpu: Clean up GFX v9.4.3 IP version checks"

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..28a2310a049e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2798,6 +2798,7 @@ static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>  	case IP_VERSION(9, 4, 3):
>  	case IP_VERSION(9, 4, 4):
> +	case IP_VERSION(9, 5, 0):
>  		for (i = 0; i < num_xcc; i++)
>  			gfx_v9_4_3_xcc_update_gfx_clock_gating(
>  				adev, state == AMD_CG_STATE_GATE, i);

