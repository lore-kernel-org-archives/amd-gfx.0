Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A36C021AA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 06:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9447910E1FC;
	Wed, 19 Feb 2025 06:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="npEnrL06";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFEA510E1FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+EK1ry2cOP4hPJ1Dm+d5x3safdeiVUJHnQtjtkF1s8OJvWk7KTNktqDtoTcm2HeBlHwby+lzqhjAegrXFr+vGY6NgMrqMJH/EAcIA8HaVb/rlc3/P8lbbfV/GGIJpZT5n+IS2cRGg4FP5uWA4Q/NNudSx9uPD6zwagu3IIkmbSA+tB8AhlThYk/X7nhuWI0UsNAzdlkL0dwMEhO1fXMKGDVc9tvtC0YTKwVfjx4A1pUdMtuiwqUsVRX5l2rFkX7xhIjRMyzieyYmn6xGp8Bnjtn94nbPtSQPvfDd+Arj9ZT02NlN3a32mdm4GhEeJqhJoeg0QwIgBIKQ3p2IOQuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em2OEgS0dF+RuXH+Ra9XwD6frdzcBwTPpomr+pPV3oE=;
 b=DnrK7X/6obNz/MEz4eQH/d/73reo4/83ffBBuae/UqgIlucRNLBcL5l6jktHB9W+HT6B7u/3duzUgtgbM1eLU3pgtqKzEK3Xcqn3Qx/nqGUDvMCf4P7yIUnJ23r1WJfDgAT396iuVWILPNfsvmuplJR5pl2xgK1SDMH/vc74lx01mvRYAEO4RxV8bCvk8t41izDS/dI+Vw7z90MGVc+8dFBeGr5Z9o3U8reetglSLvYAcZ54azSnXcWpcXbWcjH5Ln2DuFbeY+vbeIuE2qkdbqyMNHtN0Q9RxXuUaZOXzxxBZPGqHtJ051ebmltg1a88vItBQSSFC+a1DLvluwph4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em2OEgS0dF+RuXH+Ra9XwD6frdzcBwTPpomr+pPV3oE=;
 b=npEnrL06kXkqN7XAnkHA5P7JdqY73sYaLoq+j3wGw76OxgKTOjF0hJdLdqKN5AwuJwOnWLz6cS+tfZ/vBx4O4Kqp8TOaEVaVYfTVyXvez839kHTLiv3At0wC82X7/1aH/t21QjANuDbCUEWRV5ToDLe9mz5Fy2yQk14LK0NAVwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 06:25:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:25:04 +0000
Message-ID: <1fd9a618-13e2-4969-a3aa-1997005cb322@amd.com>
Date: Wed, 19 Feb 2025 11:54:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove redundant logic in GC v9.4.3
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20250217051435.10996-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20250217051435.10996-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 906a8e76-6d69-402a-9d2b-08dd50ae25ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnJlbXRSRWx3Sk11WTU3b1BVVDIzdHRrQSs2M0M2RHc2UHFteDBZWWloZmpw?=
 =?utf-8?B?bVZZNTIvQlJQbU5UMFZURnBXTVlNaldTTUMvR1VHdExTbUo0L0tYZkR4K3Fx?=
 =?utf-8?B?eHNVV2dxU3pneURHbWt6bkRHSEFWSUNPQU1aYzdxNE8ybTA2STduQkxZZGl1?=
 =?utf-8?B?M3BXdnNIOTVrWmI0K3FmZk5VeXVwTHlkTDBJaHZlVGE3ekhkNkVSQStVRDk1?=
 =?utf-8?B?RnQyZnh2RGx0VDdLd1hiWUhTTElOb0VVUTZUNXM1UDVhOHFKbzdXUmN5SEl5?=
 =?utf-8?B?Wi9zd2xjSnJwUk5DbTQwbm9saWFOTXFtSDJEVUtNYjU2SGh2bGJnNWd0enJv?=
 =?utf-8?B?aVNzZWVoVm1TVFpXUVNkUGhianVWdUp4bFBmWTNtOVl1SC9mRTY4VTFtbmEz?=
 =?utf-8?B?SjRNM3BSMlNObCt2SXA3Um1oaC9vb01aYUkxa3JZM2d1QlJUQk9tZGswN3VQ?=
 =?utf-8?B?U28zRVNmVWxtQVBSZmNzeTV3c29jQVYrRDFtcUJFNU9VTk5yTnF1N3ZRZnZ1?=
 =?utf-8?B?N1dJUjlGV1JrQVErYkxIeGM3MFRzczJoSmRBUmhQY1NQWklhRm40VlFCVmI3?=
 =?utf-8?B?ZmJJcUo2Q05PRyt5YjlTNlFuMHdTa1NaN0JUYXBXUjhTZHA2RVRnZWx5dGlz?=
 =?utf-8?B?ZUFMUjdRS3Z5V29zL3BqSkRUZlExc2dwdzRzbERYV0hTMkgwdVhBQ2JTVitx?=
 =?utf-8?B?eUdITkhnbGlDYkFMQU5TT2NJWFc1ZnArN2hiQUozMzZCMHp0RGkzZWdSL1Zq?=
 =?utf-8?B?Z1RzakJrM0hQaDlLSHVyMEtWVjBMa1BMMEorS1dXVjRENkVKWVZNdkUvalNP?=
 =?utf-8?B?Y0I4OTNpcnIyRUFIZHJPc2VHWmxzWHlXZ1FSS1B0K3F4RVRVNndXaHNiRlh5?=
 =?utf-8?B?L25MRkIvMlp0b3F6NmFaU2psclRpcVhzTE1oNTdEc240MnF0RnI4MGZZREtX?=
 =?utf-8?B?MFBwUHFxNmk5MWcveU5NNzlZeXgrUEJyYTN2YmlFeEtSb0FLZi9KT0crbHNK?=
 =?utf-8?B?ZHNBb1BwWEphWXErbE94QjR6eEk4YU01bU81ajlQUjZnU1dzYncveFZQakpp?=
 =?utf-8?B?aG1RVFY3alhHZ2ZTY28vTlZsR3NVTVNuUm1oN08zeVpMVFFncDRvOEJOa1I5?=
 =?utf-8?B?M1BncE82dmk3QVZzMnBQVGF4U0VMSUxSbzlRYStMUSt6YlhYbVFqL0FIN3lE?=
 =?utf-8?B?Mkwrc1JNR09KcS90cmp6ZGZ4MXJ5WmYxWWJCVG5MQWFRWVlxTGY2blphTUlS?=
 =?utf-8?B?eWN3QTBnSm9uSVlXekhlSENTdVhLYlZTZXpFTDBRUVN1ZDJLSm9BdFdjdlo5?=
 =?utf-8?B?bDcxR04vYTZ6TFBIeDVGYzV1b2RDY1U1ODR5SmJneVMxMVZQWmJ5YkoxRWhv?=
 =?utf-8?B?T3ZxUzBNY3V3WlpzUTFjcHlUSTNoU2dHRnVwZFZCOGU0QnJkMFVGNFNVT0s3?=
 =?utf-8?B?Z2xkWW9oVVFYM2xnSmVMK3BLb3FWOHFBdFQ4YkRVL2syRFhJVldtbGljRVYv?=
 =?utf-8?B?WVpMTjQ3UVBLWUdjdlJlMitrekpNdEROOXVIeEN3VUc1UnZsZEJhNkFlaVha?=
 =?utf-8?B?WWVVa21iOEJGSHl1WW9wUUZaaUZvM0ZyWHBQdnRocDBaWjlXZUdjL1BwM09J?=
 =?utf-8?B?QlNldS9KRjRaUE1jZDRKbG8yZ2tPbzZYYWtYUGVlNmtJcEJKZVJPOGlJYmo1?=
 =?utf-8?B?Z0tMdmFQbzFnNEJ4dFV5TnV1eXNOZU8vWTZZckpDR3dQWjRMTHg3ei83UERj?=
 =?utf-8?B?WEJMT1lJdGRFQ0hKTDJ4dUlIUUcxNTMxNTlKeFdZcEp2bDRrdjFmb21NWlIy?=
 =?utf-8?B?d1BkR2pGY1ZaRTExWkljc2JsZmR5QmFnZEhSc3RsajZVSERyMStCaCtaMzZE?=
 =?utf-8?Q?YBuzZbPf9ei5m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZubTBiSmg5cGtkNXdKbHJkaFhybXM5SmVKWVY0VjdpWEFqNzJUOENmbTR2?=
 =?utf-8?B?dUxIV0FHRnhzV2lYRWROQzkrdXM4dCs1VjdFWGtVMDlucU5EOXJjQ0RsRDRJ?=
 =?utf-8?B?Q3ZTWUFDLzZid0Zobmo5cmFMLy81YzdBS3NnRklTVWo5WHF0MU9uVDkvSnBl?=
 =?utf-8?B?NTJWNU14M3N2YkgrY1N5QXBUMWxEeXVjVUV6T0lFTEx0SHJJT1lzVDd0enJK?=
 =?utf-8?B?d1RNa3ZUWXJEZWNIcWlrcDR0bDk2N1JTWkt4dmx1MjhyNFBXY3N1T25zaVhL?=
 =?utf-8?B?cDRxVFZGU0MwYkV6eGJmU2ppdzNDRU1JaGlsb1B1LzVSODRtQXB4SGx2ZVM3?=
 =?utf-8?B?K3AwR1NrU1crUEFQUk9kK0l1eXZTbmRIRDJUWUVJdDFMVXVuWlo4OTJGczBY?=
 =?utf-8?B?U0owb3BjdUM5dlhaY25HV0IzVldFWVBqeDNJZHlKMWlKZ3pjUGlGZ0ZEWnBF?=
 =?utf-8?B?M2xERmxjMUZOd1ZQVUdBTDVaM1RWSWdZRGprWndTbk5RZmlsdTI3aXZXVGtz?=
 =?utf-8?B?WVgraGhsbFErb2kvdHhiWVl4bUZ4U3FXUnhpaVNzQ2VJR1pQbDI0cWVmU1VB?=
 =?utf-8?B?b2F2U3AydXBtMS9LdEcxR2M4elU3TkdBUmlZNjZyK0cyWW1POEhwWjVoMCtm?=
 =?utf-8?B?Zk5DVU0xczljSTUrd0htaFBUc2RpWUU5am1BMmRFVjVReXQ5dnNyVDdrcWI0?=
 =?utf-8?B?UmJjck1rVTdrZzdJUXk4RExET1g2eGpyU2ZnM1pvdnZtOWZuNXU0UFRBSXl2?=
 =?utf-8?B?WEtzZzU3bDExMWFrNksxMjJxVDhKNnEveDRBWS9IODBSa3I4OXNNdG5JUy96?=
 =?utf-8?B?dGhldlh2UVIxNDA4aS9KNVR3UHhSUUxmbVdOMzB2dm9iaGRnbGl2ZHpucVJO?=
 =?utf-8?B?NmtkNmZ5Tk9OdFRGOHVYTGNjREZHUlhsUDhXaUloOXFpSG43R1pNbjR4OGRa?=
 =?utf-8?B?VE8wajF6WWU4UkNLZUlCVXhWYlgyZFQvUGZLUGxDUUpPS3RYWVl4SzlXT1ZN?=
 =?utf-8?B?SXBRWkVpM0JzRFBuWUZtZzV4aVVpL2JiY1VqdlZDazdDeGx3MFRQQkR5M3NJ?=
 =?utf-8?B?aFJUWVZ3dFBobGYzajV2bHJ5V2ZQZ1MwTHJNa0JzSjBuS29Xc29zbzV6NFZT?=
 =?utf-8?B?SG1wTlpCRUhRNTluUmFvOXUvaFFBMCtFZGtsOEZNRjJQc1ZyRG12elZ3Vm8r?=
 =?utf-8?B?MThOa00rSDJualU5QkNIL1JOUE0rT2psMGoycWNXRnJMV1FtRUxVc3I5QVh0?=
 =?utf-8?B?cnlRWVptcnVYdzJHT1R3L1Nzb3BnQ2pKL1JFckdtWnp6ZU5VTlBrMmk5NkVK?=
 =?utf-8?B?L0ducVd4SU5ud1ozSUl2TFI2bk53OUs1N2k1UTYydWFrT0x3N01yb3doWVVs?=
 =?utf-8?B?Uzk3by8wakRHTVhOY1VnM3JySHBwellvMDRCR2p5VU1PdGQ1YmpHeVFqYTA2?=
 =?utf-8?B?ek9penRXRG55TmppUkN0aU9XdkVYRWQvNFZhZUh0dVhTMWhMTDFFUUNWb2Nn?=
 =?utf-8?B?YWhhckJXeHEvbXZVeDQ4bFVISE1mS2J5dmJKWlZUcWxkUWR1WGxOZkU0cWpV?=
 =?utf-8?B?Nk9udER5UEVaN2V4SXVRRDM5WFFOZnhHcnMvczgzZVFqK3BaR0V0dmZlNGNK?=
 =?utf-8?B?WXloMGZZcXY3MU5uaUVIUE9QbFZTcjVhY0wrK1d2WGpkOE1QYkowOU9mT3dZ?=
 =?utf-8?B?eGYreGVaMjRXUlpBdnczckt0Skh3aXNJUXVMVTA5V0RTMlJ5NFM2elEvK2ZR?=
 =?utf-8?B?N1VqQUNWcGw1ODk1d3F1UWN0cjdOSFNVQmU1S3RyQXkvRXRKV3NmVnRVbWFB?=
 =?utf-8?B?YUNkeTJYby9rUjFpSjBIWDhhYUFEYnhaalRRZklqSnlQNzcxRE5FVktpTDJC?=
 =?utf-8?B?ajJkNXpPbmpyeFNWVUZvVlVEZW5IQjRjd2RHODBaNWJScVZ0WXNPanJ6VUUx?=
 =?utf-8?B?elc3VWFweDdvQVo2TWg0YnRNWVFJL0V4UGdXNzhtRFVpa1pSTk1RdG82UjlI?=
 =?utf-8?B?T1RJU0tQN2hwNGhybkd6SkpoWW1JR0RYVlNWSkhtUnh0UmpCQ0ZRM1B3Skly?=
 =?utf-8?B?VTdzeDVCTmlsRkJsclNIbHBsRWNhOTJuRTJjWHhLUC9MYWNVbi9ZVVNGYXU1?=
 =?utf-8?Q?4FnZhyhWZG60nyQu0ZqyjTX/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906a8e76-6d69-402a-9d2b-08dd50ae25ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:25:04.7432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEHAkiXejOJGlRgv3oA1muJJW/jmiJ/r/QqHOZicw6iig7TGjQ31ZmzdMGg2jg20
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

<Ping>

On 2/17/2025 10:44 AM, Lijo Lazar wrote:
> GFXOFF check is not need for GC v9.4.3. Also, save/restore list is
> available by default.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index f4635fc8a7ca..f1d6f4b92e99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -563,17 +563,6 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
>  	return err;
>  }
>  
> -static bool gfx_v9_4_3_should_disable_gfxoff(struct pci_dev *pdev)
> -{
> -	return true;
> -}
> -
> -static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
> -{
> -	if (gfx_v9_4_3_should_disable_gfxoff(adev->pdev))
> -		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -}
> -
>  static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  					  const char *chip_name)
>  {
> @@ -600,8 +589,6 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  	adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
>  	adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
>  
> -	gfx_v9_4_3_check_if_need_gfxoff(adev);
> -
>  out:
>  	if (err)
>  		amdgpu_ucode_release(&adev->gfx.mec_fw);
> @@ -1360,10 +1347,8 @@ static void gfx_v9_4_3_xcc_init_pg(struct amdgpu_device *adev, int xcc_id)
>  {
>  	/*
>  	 * Rlc save restore list is workable since v2_1.
> -	 * And it's needed by gfxoff feature.
>  	 */
> -	if (adev->gfx.rlc.is_rlc_v2_1)
> -		gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
> +	gfx_v9_4_3_xcc_enable_save_restore_machine(adev, xcc_id);
>  }
>  
>  static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)

