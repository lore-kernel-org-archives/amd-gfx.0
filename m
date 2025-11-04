Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412DDCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D0F10E284;
	Tue,  4 Nov 2025 13:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7xm0C+9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311A810E284
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2dtNSK1kJTmmJZJDo26MUAt2MTXK1oclNvyxfE5xYeBukbeyaVjhIE80z+2zcK1iPRzrSs+/AUh84ot1lM01iV0RnBQL+c+fe/DDaZypw4xEgKxbhUxRisoKtQOsu8ng7OQSnU3VF/gHmBk36oKssh9kvkaXIX9YFVzwxjN26X6ltfuOb/E5NZs22FIxJwG+lxK1I2Ayf9PuFLwD+njN2271NjE1MuVU1d8Dpcw+BJgDe7FDqFJsBE2y/Vcj3DztinFoffq8BMiiG/zhVNflA0o/FzdyeDjvl7xLtErJKevx3FV4WJVWsLH3zZ7sQnwu9UnCqE9HyrZ9CN3teuiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7//shykWQafQ43863hJNApdvKf4UFIX9BF8Jvy5eBo=;
 b=lGif5nfRFjQ1g0UPquVeVLZDYtd1emfON8mzN0eKdtu9Hfak2RJpFKIkVXACf3TYwkfs3X5v4SCVofBgvr19vTzfQI/wF9n23qtxkdxaPo/gizNMowwFOgd49Qtc8PKfEXC+r8XSw5tTWrxIDEpSP2Pbq2FZ4Myu/1l14LmkLcpXOuYvs9+FU39B3OrxTfQN/LMxNuI9s2x/KqHANjVsk96pdXSbWd22gq1YRdwUXosfz3ylCMUwUkFjkLbEH6hZmTncjTkyXhzcb1bwNz2PAuEpHrW3QPOBFngyKFfpWbnoAm7kiDS8iDPQDjQlgbiw4c5cQEPxa4nl2tl8cmlkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7//shykWQafQ43863hJNApdvKf4UFIX9BF8Jvy5eBo=;
 b=w7xm0C+9lEo5emc0dy8gA7HhO+XFuuwTG/Moy9IYOVmQtsm0KdPgMHBz2X2cLPoU1EHXGv2gYSC33OyrgU/fbTIQfDazZ2ACusMhrAiU7GjxdoQKrv1WcjPdZeEyFg8kEItOHrVPPq3ChFUg8Lh1QQiD4/4akGmoXFHus0wUo9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 13:44:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 13:44:11 +0000
Message-ID: <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
Date: Tue, 4 Nov 2025 14:44:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-10-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251103222333.37817-10-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfe8bfe-5988-441e-2e8c-08de1ba83c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzBHQm1ibHJHV3NmRC9mUFYyZ25wR29oMWRxUmdqTTV4eWJGdWN1cTRRWWhU?=
 =?utf-8?B?b2VyV1VpMzRod0hiVEFGUDRiQ3QvMzU4aGZhRFRLeEJ2bGYxRW1DZVhyNG16?=
 =?utf-8?B?c0xqaTNWZmxnSzR2UndTOW9SaHdFcWhDTTIrOHJQKzl6d2FWOEorN0IwQi9i?=
 =?utf-8?B?OFozY2VCNUpMbGY1dmE0VkhTRHpsZ0FhZTBTNVdoa3dtOFJoS2F0UnBUbUVu?=
 =?utf-8?B?M3ZjRjJ0b2pjSlVaZWlOc1lsZ1lQM2JjUklHek1oclNEcUgweCtlc25HTmk4?=
 =?utf-8?B?bHBPdUlpQlp2NG0yL2xMZzVORVBONldaa0dsbnlaM3BVV3FDR3o5VHNhNVg3?=
 =?utf-8?B?Y0NFTlZDU2xhRVMrdGZRY2tObWZ4YVBaUzU2T2ZCaEFaVTNsdkNPVjk2b1pz?=
 =?utf-8?B?RU5SNjF3RnBjeis5a2JnQ0l4SnBBS3F5TWltM3RhSEdycmlVb042S2pxeDNR?=
 =?utf-8?B?bTVCVnB4YTR1MXhEZngzUFVkQ0owWXJocFdWSzROb1doaGpHVFBZOUV5VnBE?=
 =?utf-8?B?TjRFNndFUEwvQXQybkRRdGwrWm5QODB6czBQd1h0Q0c3VzdTdHFsdHRkV1Yz?=
 =?utf-8?B?cFFzR0lYdEN4UFF5VkhXY0prM3psRURMWjJWTzBTM0xJN1ppbDNORnFVdlFr?=
 =?utf-8?B?THV5RVR0eERRVzNGUnh6UmpJZWJVZC9nWTZzT2p0MS9nbm5jUlRXdmMreVVy?=
 =?utf-8?B?TS92ZjFzakQwZElRaTNGV3p1dW1hTC9nZno4RDIxcXBGZXkxSmV6OFltaXdp?=
 =?utf-8?B?UzJSZXZBeGp1L0xOV0RKZUNkazVlbzB0alJ2aklLR3lEKy9FZzgxcC9wVW5K?=
 =?utf-8?B?RmNMbVQzTU8wL0RjTmxCbmMyY1VaUW5ZRzh4WkZ6Y2ZUM2ZuT25oRHVZZ2V6?=
 =?utf-8?B?M3dpbzJHSVdRcnB1TitNTWpucE4yRVBROFE0WFcxMkRlL3Rsa3VnRWZNUWdW?=
 =?utf-8?B?bmxsaDdCdGVFUGVFZjhML2JzK2xlaHJpNVBDd0VVSGsvd2xNSzFDZ2hiYmIr?=
 =?utf-8?B?YlVSb3dqbWxvS2dkM0p5Y0J5bVA1U2J6aXQvM25SaC92VWxVWXpkalBjSmNa?=
 =?utf-8?B?SEQzaTNUdi80aExqK1RUV3I2d2xDeVpqSzlrT2xxTmFuRm9GbmVyQTJuMlZS?=
 =?utf-8?B?U0xCRnVrZHF0c2Q2K3NNMVZaejRjMUFIWEZiTk5uTjZTaFh3NHJzWjFadEdr?=
 =?utf-8?B?bEMrenV0UlpicXpiejFBMy9KeGtMV3lOaWN2d2ZXNUxLbHRZd0NsRlpKRVNP?=
 =?utf-8?B?dE54Mm5UT2hFTzBvdmJCMHJyOUt1ZlNUZ29ZcFFhdnhOVkZlZ1llWThpTGpW?=
 =?utf-8?B?end0S1pObHJHbWxlS2hqZmZFeERIMnZscUNIcWJuc24zdmE3eHBrSCtpRDFB?=
 =?utf-8?B?STQ2Q1ZXUTdDNDF4VkVkMm8zVGpsaEU3NXlScEJDR1RtQlVIOTBEM0RDYW9V?=
 =?utf-8?B?M25ablhQUk1CYm1sanF6TCs3ZWN5Zjg3bm52eFh0YUJtMzVSM1h2b1JiVDQ3?=
 =?utf-8?B?YTFMK3BHNTlmQzdkdkRaZ2FJMHBtVE5XVk1qcG1QNDN2WjNXT21WNXRxQ2tS?=
 =?utf-8?B?L3p5Nzg3L3ZMUHpjUXZocW51SmZDUm5YSHRPWmFXcHZQMHpUTHVSa3dkbUlX?=
 =?utf-8?B?ZFJDR2ZXUnRxaUVvSHNTQUhzeUNKUW94NnBtWGJEbFhzZTRJVWJKNEdSUGN5?=
 =?utf-8?B?UnRlRVRYUEd6WUVpc2pNb1YrVExYYmhkZkZQZFhYWCtPcmZOOVJaN2E0VVpC?=
 =?utf-8?B?dXpvVW9KRmtEeDZTNGJMeUlTd1VJSFJUR3FQU0lhdW9vVjFtaFZDSU5ZOHN5?=
 =?utf-8?B?Vy84U01YdkE5Vzd1RHZlbWpLQjdZVTFlMWFuSGlHUml0RmliTTdZWlVJeGJo?=
 =?utf-8?B?N1RJcXhrQzRkbk96MXlPZ1ZjdDlUNGJZV05hZ24wWHRkdVlHSGp0YW5pb0xy?=
 =?utf-8?Q?77RxHUC+QxNSdDkSsbZJLX2wyehM/D2I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZRSWhqaW01dlUyblpiU3VvdUNTM2dPUytPc3UwZHRwRm4ydmxxd3I1clEr?=
 =?utf-8?B?QmxIUWVTUXE0MFNFZDgvcVVUbjFaWGpoZ081Mlg0bFc0OHg2anhKYTlGRGQy?=
 =?utf-8?B?ZmhqVmd0NkI5SGlEc0pReTBzeUY3UEtMcFNxakp0Z0hqMU5IQ0JVQytwa1NK?=
 =?utf-8?B?azBvNmR4YmJpRFRweXhmcTBDaVpKMXZJQXY3OG5sbHNueXZmd05lNGRmTjQv?=
 =?utf-8?B?TUQzbVVJL2x2UDYwa3FDbVB4d0NjNEtSRGdFVVdmMC9jU2EyMElXVTlRL1BB?=
 =?utf-8?B?ODhXTVpEZVFoNmNDWUt5MHVBM1ZzSFhuMVdXQmMvZ0RrRURBazZHcDVLTkNM?=
 =?utf-8?B?QW1DZitrQXNjNHlSd1lBMS8xaExXMjZ0VVN6cHNIU0ZINHJtVXQyaU5UdGE4?=
 =?utf-8?B?aDhTdHU5R29ZQWlkbVUycG1xVU1CT2dtdzBuc1RxRUlneVRSYkZpb0ROdC83?=
 =?utf-8?B?SjdhNndNbXpVUERLZ01sdm05USt3bytVUllhb3RvT2p1ZWpOeEhnRFVBTWNC?=
 =?utf-8?B?K1BxQnd1aThuWDVPR3R1N0UvTGR2ZTM5K242VEZGOTFhYTJNbVYrS0RFVWp4?=
 =?utf-8?B?eEJ5LytocXVhZHdCOGxDUzJncVNvU29sVWg1cHdHcFhLNW1rRDU2TlE2VllF?=
 =?utf-8?B?MFk4d3EyR1dWTC9PR0hXK0hnemVQalMxZktKVlBtaitMZkhIbnlJZUZrSFNV?=
 =?utf-8?B?OGYrZVBsYStmaTZwcjlHekk2VnNNaUZiWVJQa2JEV3R2K0JmVHBRVDgzNVk2?=
 =?utf-8?B?TGV0Ymh0NURzQTZ2MUxhL0lWd1lCemdIZU1JT1p1STU1TmxoUnM3WldXa3dC?=
 =?utf-8?B?enJWbHdzK09IK3Q2eWZqZDlLazVUQkpudGljQjhoWUgvaXRBRkgybkNBcDNp?=
 =?utf-8?B?ZEhySERXR3hTdmU3QjFDM1NKM3ZQSVlyNnZyby9tL1V4SXVCMTNqZTFyRTRE?=
 =?utf-8?B?SE1DS1YyVTRlSk1IVHdHS3FkZUFWVXNvdE9hYlViUDBNRXJqWnU0R2x5TVZH?=
 =?utf-8?B?UTA4OUcvODQ4NGFUYnNqdjE4aHFOcGNYdmNoYm5GRi9pMnl5dDgrbkJjeFZI?=
 =?utf-8?B?TDlkdVIyU1NLT2pEdy9OTDk1V29kcVM4Mmc3Z1NhWTkzdlRzZlJTQUZQYkRr?=
 =?utf-8?B?YlZMM01Sb00waFhEUUFVZU8xaXR1ZTVBR0t2eGlDWGZzSW9mSzlDQVE5eklT?=
 =?utf-8?B?WXdtNlJLZFV4enNEb00vWHVzQVZDTENyNkRabjdwZzlHSFF3dm9zaEdzVUsv?=
 =?utf-8?B?eDlRb1ROT3J1dmZ3RmJQSEdBS0lQOFVYemtha2V6N2d5VUZBTnNxVmVBZ29a?=
 =?utf-8?B?eUd4YWxQZHY3VVowU2w0c1pWVDNlTjAyTjJ6eXNWT3hEaWdwcVhPRFl3TFRN?=
 =?utf-8?B?bXZwQW1SQlRLM1NLWDNvRDMyS0VNYVIwQTV1WVo1V21CTjhVRmJBaDN2Q1BV?=
 =?utf-8?B?dWtEemVmNmxQbjJxNmxjdDI3b01XUUZ3dHpKM0VMZTRQTUprSlFNcDY0Sk5n?=
 =?utf-8?B?STZjd3Rna3lRMEVvQThQN1Z4VkRPQWtlTmNrL0ovY2tOdGszSlJjaWJIVVRL?=
 =?utf-8?B?dHd2dkxIcVBsdzN3Uk9aMVhoVlFQbHRESkRmWXdUZXJZUkpzRjhNT1gzS3Na?=
 =?utf-8?B?Wk8vSUNJYXRsRTlVeVp5V3FMVWhqUkdxR28zb24xVzFKQTlNSTFDSkdKWDZ6?=
 =?utf-8?B?UWxGUVhXaFpQRXhJWngrT2FwdnE0cEUydFhxZkhYd3ByWXFOVzRQV3hZN3VN?=
 =?utf-8?B?UU1nNDdDSW5nV1dRYVZpWGVTNWY3bGJZZlFQT1VXV1lKdU5WSHZ0RnZFam5j?=
 =?utf-8?B?OEhNVm43b1ZaVXNQR1FyZXZmTjhwejVESDJFM2lYZFpYT2Uwa3JFMzVFYXc4?=
 =?utf-8?B?QkI3cHZXKzNrR0NuQ29iUXpCRXk3L2VWRFBtZVg2L2FEampKeUFQaFJnMElv?=
 =?utf-8?B?SEFNSWFWcENOWnRYRE1YTGE3QTlxSGI1eXJyK0VvNG5pUVg1RW1zcjZvdUdj?=
 =?utf-8?B?Um83a3VCejYzV2EydW5aK1JKQWQwWkRrT2E5UldYNHQ1Q1NHc0QrallwZ0VI?=
 =?utf-8?B?TjhVMm5PU29SQTgyODNGVmRTNTJjSmxaME5qemlITFRPcTlSM1VkVXVEcUdx?=
 =?utf-8?Q?YQZl9pCAmmA8kPmwEhxW2WJtR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfe8bfe-5988-441e-2e8c-08de1ba83c3c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:44:11.4765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Scyo6dJsxpia1u6yeOQmXDlp7T3AH4a5fEe65eA+X7K67FGkmvdFP3kzj3cfZrxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310
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

On 11/3/25 23:23, Timur Kristóf wrote:
> Some harvested chips may not have any IP blocks,
> or we may not have the firmware for the IP blocks.
> In these cases, the query should return that no video
> codec is supported.
> 
> v2:
> - When codecs is NULL, treat that as empty codec list.

I'm still not sure if returning an error instead wouldn't be better.

@Alex and Leo what do you guys think?

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b3e6b3fcdf2c..71eceac58fb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  			-EFAULT : 0;
>  	}
>  	case AMDGPU_INFO_VIDEO_CAPS: {
> -		const struct amdgpu_video_codecs *codecs;
> +		const struct amdgpu_video_codecs *codecs = NULL;
>  		struct drm_amdgpu_info_video_caps *caps;
> +		u32 codec_count;
>  		int r;
>  
>  		if (!adev->asic_funcs->query_video_codecs)
> @@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		if (!caps)
>  			return -ENOMEM;
>  
> -		for (i = 0; i < codecs->codec_count; i++) {
> +		codec_count = codecs ? codecs->codec_count : 0;
> +
> +		for (i = 0; i < codec_count; i++) {
>  			int idx = codecs->codec_array[i].codec_type;
>  
>  			switch (idx) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index 9cd63b4177bf..b755238c2c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs cik_video_codecs_decode =
>  static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				  const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_BONAIRE:
>  	case CHIP_HAWAII:
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e0f139de7991..9468c03bdb1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs hainan_video_codecs_decode =
>  static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				 const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_VERDE:
>  	case CHIP_TAHITI:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index a611a7345125..f0e4193cf722 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs cz_video_codecs_decode =
>  static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
>  				 const struct amdgpu_video_codecs **codecs)
>  {
> +	const enum amd_ip_block_type ip =
> +		encode ? AMD_IP_BLOCK_TYPE_VCE : AMD_IP_BLOCK_TYPE_UVD;
> +
> +	if (!amdgpu_device_ip_is_valid(adev, ip))
> +		return 0;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_TOPAZ:
>  		if (encode)

