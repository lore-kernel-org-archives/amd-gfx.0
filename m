Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C45C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 04:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DFD10E12C;
	Mon, 10 Feb 2025 04:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWhaZ5cZ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ED410E12C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 04:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJm/XmnEjhkrJKtrFc5904V72WSt4IjfeSw6iuw2sQRdkf9vEQ5diuBlnfvtkW+Ctsxs4LnonW4kl6bWh9TvI98pYJxZjxa6e9o+2KruaG1/f2MOoyQn0+TVjIm1O4nLe/2z0yr35m+ukW6hDo8YBPA75YU09jSiFDJaUn80eQ5HppNUzsfNiGWq19nlC+KaUSEBS/T8R8JahZgTuvuxt3BICquVztn/uBeuZ6dPnYlxwPk8hzkRG2NoI6sHkHxQnCUI8SbYsak+LOHMkGgpiZ/1UaA0GKsXFlhm1NvfNF4B3/Hp5UA6y5BDvXqTuMx9SpIbuInvsRQ553EbspzmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tMLsDWtEmTAiPuawJ7a6VO9WVPG4ChqWL4WJB+5ESc=;
 b=sHWmlj9cFDVZj6MVU45/4yuxJmme+9k1LRjTUK/GXsRYPPP6bYQkKm79E1Wm5l1W6aSk9lD/9JEynjlNNQ26ET1C3OZaCy9xv7wgcO2B+hfVW5g6SEEt8fdgS21tN+xIi4Q4IUu5nG2RdydCIeb9yWTXuVxlJsUQFSEcy7mWpu0soPP5KMLJht39GPZYCir0WxPtM15QKC7gH9IsgFjRGfmC4kFYcVguCz2c6CSuyNs6vNIp8YmcVcRzYumkkfAVsv+cWoGUyeXJPwcQy8ZisCPKbJMRjo7cvhEBH0gvIydIzMx32vnGN/AjXsIBegWkdgieYltBdHtJmtandgg/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tMLsDWtEmTAiPuawJ7a6VO9WVPG4ChqWL4WJB+5ESc=;
 b=vWhaZ5cZDZLbXEffS7odIsv/k16M7X9a295LvnqH/gbsedjapLV506bU6EC2FSfgIfRZaV6xZ1g7JBkzClGhPPWBKrg9onfJMUgi0mxhBsSpok8QTXFJ28zaQPanLivsrfNc5xQhhp5MoX7PzCAU4g5dq6+VV99JQz1cwY9JVbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 04:49:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 04:49:24 +0000
Message-ID: <444b6f3f-7993-4445-ad7a-9ad6c4cd6c16@amd.com>
Date: Mon, 10 Feb 2025 10:19:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
 <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY8PR12MB7435933A1D8983F4661D762285F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804A35C24B56EDA46BCB73097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY8PR12MB743582FDD84CAE8D43B2154F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB743582FDD84CAE8D43B2154F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f29b14-1116-4c20-3e89-08dd498e4a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2l0bzhVNW44K2RuOVlaVDcwelgyNkhTS1Y2TnBTV2M0N1o4UWZ0Nnl6WjdH?=
 =?utf-8?B?S0E5V213SHF1WDg2M0UrTmZ6Vy84bzRxWUJLeHVjWDNqNTliRU9qN205Rm1a?=
 =?utf-8?B?bC8xU1VhSE8xVmRLbVpwZTYra0VwL0E5eDB4Zk1BZUk1bjg4Skpwc0tDTDJw?=
 =?utf-8?B?RHFGd3JJRlJLUGRXMWpyZHBYMWQzRE9QV0FPSjZvcnZoV1ZsTHJjV0hVSWs4?=
 =?utf-8?B?RUtYSUtOd3pnc1hEZ3BXWDJNRUhncUZiMEltKzhNeUNrK1V6My9JbU5ybVNI?=
 =?utf-8?B?UUpWODRzNHhRenkvN3B3QzE4Rk9rRnEyeDd1QUlRWkJIQlpQcElUdVp1U2pZ?=
 =?utf-8?B?c2VkMnhUSDV0RXE3TmZ4eGlVeXJ1aWtCTUJZa1dHZW1FQkF1VnZWcUcxR0ZE?=
 =?utf-8?B?Z3BiY1NqdDJ3Y3hRMlFRU3oyb015NmVWanVCdkU1K3JpVVRtcFVqVzI1UzhC?=
 =?utf-8?B?N0lqRGlBN2hFdnNQYWNEUUtXb3FXZ0N4N0wyeklVRUxpNHFTWEtodVMrZkZM?=
 =?utf-8?B?VjRBcW5zYzNnQlA5Sjc1VHlRWGZLTDVkTC9QeHRlNExtYnB4WmNjaWxMbU5y?=
 =?utf-8?B?Q1hpYVNEaUwwdEcrb1UvT2dsZVgvNVRpM1oyMmRyM2ZTTHR2TXJsTkxZUXl1?=
 =?utf-8?B?SVdjNnlJaTVMWDFQcFU4ZHRzazRrMWRFQ21jZGdZdEtFV0xCRnU1VjdibGFI?=
 =?utf-8?B?eXFRaE9hUUxMeFVnSVJsRWJhT3BiTm9tZVJLTUJabU54aHByb2cxdHh6YlA2?=
 =?utf-8?B?NzNMNnBLODBFNTcxOXNXMUJLOTRZMzlCc012MDQzeVRCL2tRWk00NEVPWnlH?=
 =?utf-8?B?UkFlaTV5L0MzSWtIZUJLU3d6VlBlbkswbDRmeW14akhrOXo5ZmIxUTdLbi9Z?=
 =?utf-8?B?ME5EbkFUTGRTaWlMcWNSblg3c3hmQjNBbHJQaFFCbHVoNWF5OEdJNE9ZamNY?=
 =?utf-8?B?WFdTRFo5ak1PcTgxeStxUVQyVWcyNi9YWnVqRTlXVGlNYTVnaGh3Smxyc0xE?=
 =?utf-8?B?aXByb3lPQi96eHdKK25TS2xOVkJaQkVqRi8yaWVNbm9RR0R5K2xrVUk2NytK?=
 =?utf-8?B?RXhYdGZzRVR2anFUZVhPbzI0ci9XRGd4V2hDN3VSYk9UZFA4d2dSYWRkblRv?=
 =?utf-8?B?a0NrMWtRNjdhd2dyVUJGck5SMVdKTU5rVmtLUmRXeERONUN3QjAxSEpSQTdR?=
 =?utf-8?B?dDJOWTd6QjZwRW9xblNnVnArc2Y5VkhIWVFkdy9RVGdaVE9wbWxyaWV6aGIv?=
 =?utf-8?B?K0p5ckVwNGhCNnBXV2RQbnh3YXd5Z1hFMWR0VUFDak8wRVFmeWtSK0NJTmdS?=
 =?utf-8?B?WTdibjVLc3BiRXkvcnBYRGlLaUd1Y3E2UU9yVDk2VWUwdXVzbXNMbXcvY1cw?=
 =?utf-8?B?dXNOR3V4K2dnTUZCRXBqVGdpN0EwYmNXYW1SN1BWQVViNlJBVWVhTi84aisz?=
 =?utf-8?B?OXM4Y0kyeEpZcG9mL1p4R1Znc0N5bk0za3laVnJyaUpGZjA3aWw3elVaVlZh?=
 =?utf-8?B?dzlZMW9leGhxaEtBWFN3d0JwcmNLSnBCbXZsM0ViTnpHUEFFTlY4Yzl0WWx3?=
 =?utf-8?B?WGNpNUplNkxZdmpzZzc4QmpCT0RHK1FKT3c4eGVQM3JKejIydlpiT29WZnNU?=
 =?utf-8?B?YmVjT3lkRmVHL1JGU3pLclB5TnQrd2FGOTgxaHRsclIyVkJidXo1UWMzdU9Z?=
 =?utf-8?B?cENibjdjbEo2K0RsckhSWThXN0JwYW9KRjQ3RkdNY2JnYjJNVjhjL1JDSTNT?=
 =?utf-8?B?L3dJalEvdWtHZDhTanE5cGxZT040MllwTjN1eVBDbHo3MU14akNtdFp5bm1r?=
 =?utf-8?B?Z1FYMnN5OCtWVDBDWkNFMVlTd3pSSFdoV0xqN21BY3JhelhhR0FwTkpUZVM1?=
 =?utf-8?Q?219iQP/Wx7JxP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9GZVBsZWRFdGM2M0UxNE5FeFBSUnJJVkphNUVlOHp6MGdTaXJad0JhQ2dN?=
 =?utf-8?B?L01jL2JVTFEvSkdCMkk0aVJ3UWJBTExUTUdJQTQ3TTFnKzM5WFVmRDRZVFov?=
 =?utf-8?B?dEFNcitlOXVTNGFWSkZqYmdKMFFWSkFWei9zSWpYUUR3UHkyNTZ1R0JSMHB1?=
 =?utf-8?B?VW9qNU1OaHA4Q1drV282SEtKNlZWdkNWai9JRXRjdXBGSkNrbjNpUDIyYnVE?=
 =?utf-8?B?SWc2MlV4L1NGSXVCZUNNL2I4dWVENkRVNFJJQmRpa0lHajk5bERjT2ZwMUdT?=
 =?utf-8?B?bFhHSGs0THdqUkJUZHFxNjF2TnoxQVN5dTlvQVhCRmpQYmhQK3c2RjgxWTNv?=
 =?utf-8?B?REdYamMzQmVkdDRGTWZMQytmTEw1bStRQWFBMit4ZDhTb1EwYmRLN3Y5Q0I3?=
 =?utf-8?B?OGVTT3kwMCtiaU9XZzQwUkgrdVZwZm5FbCsxQTFuRG54QlZFQUVXUlpLQzdH?=
 =?utf-8?B?TCtNcklVNHFoZW8zVmhPV2RSSURVRC8zakptcjZBWWZ0S2lXeEFZNmtTa0F5?=
 =?utf-8?B?RWJvY3FFUGcrRWNmWjNlbXh4ZUVXUjNnRjZtdE1GaitwTnVJY2VmN1FsY1lx?=
 =?utf-8?B?RHFFZis5T09iQmJSZTdzeXRkNFI1cXdIOTBIeHRvQWlGQXZrWkZrRDE1VWx4?=
 =?utf-8?B?SXJvTkVLb2VRUGlQK3lVVTVnQjVwcWhoNEdSamIyTXMvT011Wi80L01NWDRI?=
 =?utf-8?B?eTU1NzZSM0pQSzg3MkhNTEZLT0VhSWQwNHhJVXlZL3pmVzRuZlZRZFRZUXZu?=
 =?utf-8?B?VXJMS21LakM4aXVMaC9WaGZSMlZiN1ZNNmd1S2tKTEY0QmlnN2hHMmJwY3dG?=
 =?utf-8?B?bm9kVzFYOGNqYzZWYm9zTkZtL3Q5cjFVaEkvRjhadlNYN2k3Umg3c250NS9I?=
 =?utf-8?B?dTZ0eUZiUDk1MXJ4Qng5NkZNWE1XVjI2Y0tzb2dVRHlhQmRxa2JZV2UxWCtr?=
 =?utf-8?B?ZWFBVHhmUm9JQWhTUVd2bVJ5VFdubFRtR2U2WjJONDVPYWpuWjQ1R0hMWS9q?=
 =?utf-8?B?TW9nTEwwYWVRenhudGhVMU1JRVFGOEg4OWJHSHR1SkJZa0gzVEw1U1BWWnBR?=
 =?utf-8?B?VUxGU1d1QlpJZi9HUU50d3F0RFR1RHNPaTJFOHFHQ0pRTzFTbWRDN1JrRW5P?=
 =?utf-8?B?SmZ5UHZRalArbVVxQi9YUFRzV01KME9VVzdXSTdLK3ZiVVhaVXNJOXphbkdv?=
 =?utf-8?B?Q1NaajhFYkxGYzFtMEhoelpDRi96NmxGZXQ0YUFlT3U1dDF4ei9PNXRzTEgx?=
 =?utf-8?B?OENxbU1QVExnUDZVTHIxY2FCNThhcUNMQjZqRU9POGZLQWM2U2R2R1V0OHlx?=
 =?utf-8?B?R1dlOXRDbTR4UUlaTzI2cmI1WHBvNlhWb042ZlNuNVdVSmNRL2RBT1Vtdjls?=
 =?utf-8?B?aEI2SmZ2QnNwekhYR0U3OG1NNWhHQXhlOWhxSDJxd0ROL0U5WjRVaGdDUHR2?=
 =?utf-8?B?enQxNmhNQTQ4WStNRnZTSGZqU0o3WTdsS245eWVBY0s4L3hmU05oU00vZVh1?=
 =?utf-8?B?QThZY0JJakdPdExoZTI3enc4NTRGRXVoYTB2bUNSZUU3U3BxaXVpbkxkQ1I1?=
 =?utf-8?B?S2g4Z01KdGc2QU5PRk11WTRSdVdsT1c5QUFjY3FFWHRUcmZib2dqTFR3dzRS?=
 =?utf-8?B?V2xISkFXVUdjN2k3cjJkMlpKcW9zSm9MSCtCOWhNTDVrRVpYNmdaY2tLUkZR?=
 =?utf-8?B?QVljeXdFU0RYazZVUG1zMWNaUExhY0Z5TWxoaVQ4eUZFVTY5dzB5QTY1VGpN?=
 =?utf-8?B?cFR6RFl3WTVmVmdQTWlRVTVPUDlwTnEwOGNuN3RJTTlHWVhTOVczTTlrWlh1?=
 =?utf-8?B?N2M3VjFRZDFtZEMzbDd4QkRHSW90OEVBaGFrWmpTWTEyR2NEQkNhTXVpZWgr?=
 =?utf-8?B?cTRpU1lCc3ZXU09ydkhtU2R4a3JMZ0FSc0xSdng2WDlZSlBqWnd3S2N5NXU3?=
 =?utf-8?B?UDh5YUV3NmNpL3B4eTRzNG9GTFMzRnBiUWszdURmSnhJbjF6ak1Pd1dOK3c0?=
 =?utf-8?B?WVVKekFhdlUrQ0dlNG9WZWYxNVV1TDMvVENGMDFLbmF6ekFCN0xxM2wvSU1R?=
 =?utf-8?B?WXdOUU9LRkNNMjRjaDg0c1FZbzVTVnRPbFZiY0V1SUp4WHJwdEd6VSswSDJM?=
 =?utf-8?Q?7vvgmi1ti4sy2pWOgUayptHFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f29b14-1116-4c20-3e89-08dd498e4a35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 04:49:23.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUEssKUxVsA3EYidVw/Tlis1U/5LaoYM9tGFM+EDTprRwlroA0oeF68g6O3YScot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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



On 2/8/2025 3:15 AM, Kim, Jonathan wrote:
> [Public]
> 
> 
> I think part of the problem is that gmc.xgmi.supported has weird usage
> and definition.
> 
> It’s partly says that it has potential to be supported by IP version,
> but doesn’t actually say anything about real support but assumed say it
> has real support in amdgpu_xgmi.c usage.
> 
> Real support is determined by gfxhub_...get_xgmi_info which has comments
> ->         /* PF_MAX_REGION=0 means xgmi is disabled */ and error
> returns on failure to read.
> 
> On top of that, the gmc.xgmi.supported field gets set by both
> amdgpu_discovery.c based on XGMI HW IP but is also set by gmc_v9_0.c
> early init base on GC version.
> 
> I think you’re locked into doing a wrapper on a wrapper because the way
> gmc.xgmi.supported is set has become spaghetti code.
> 
> If that gets clean up, and we do your suggestion of pulling xgmi related
> info into early init i.e. get info based on actual verification that
> gfxhub says xgmi is ok,  I think the series would start to make much
> more sense.
> 

There are more inputs from Hawking as well. I think that till solve xgmi
supported being set at different places. Will send a v2.

Thanks,
Lijo
>  
> 
> Jon
> 
>  
> 
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Friday, February 7, 2025 12:35 PM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com>
> *Subject:* Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
> 
>  
> 
> [Public]
> 
>  
> 
> Another try.. if it helps (you or someone else)
> 
>  
> 
> This series introduces two functions for maintenance.
> 
>  
> 
> amdgpu_xgmi_init_info - This is to initialize any XGM related static
> information. Now it's called as soon as XGMI version is discovered. Now,
> if that is causing some confusion, then I could rename to
> xgmi_early_init and call from device early init. The intent of the
> function is to initialise any static info related to XGMI.
> 
>  
> 
> amdgpu_xgmi_get_max_bandwidth - Assumes all links are uniform and
> provides the max theoretical bandwidth. Currently, the calculation is
> simple as width * speed. In future, this may change based on IP version
> like speed * width * x_factor or get the bandwidth from FW etc. Caller
> is expected to get this uniform interface for any XGMI IP version.
> 
>  
> 
> And lastly, both functions are maintained in amdgpu_xgmi.c
> 
>  
> 
> Thanks,
> 
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:*Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
> *Sent:* Friday, February 7, 2025 9:58:30 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> <amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
> *Subject:* RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during
> discovery
> 
>  
> 
> [Public]
> 
>  
> 
> Well … I don’t know what other feedback I can give here then.
> 
> We’re bouncing back and forth talking about language/function/logical
> structure or whatever.
> 
> I’m of the opinion that there are too many unnecessary wrappers here and
> am biased to unbroken steps that make it easier to debug/dev later on
> (at least for me).
> 
> Maybe someone else has a different opinion.
> 
>  
> 
> Jon
> 
>  
> 
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
> *Sent:* Friday, February 7, 2025 11:06 AM
> *To:* Kim, Jonathan <Jonathan.Kim@amd.com
> <mailto:Jonathan.Kim@amd.com>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
> *Subject:* Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
> 
>  
> 
> [Public]
> 
>  
> 
> It so happens that driver gets part of the XGMI information through
> registers in GMC. The intent of those registers is to help GMC to
> figure out memory access when device part of XGMI hive. Driver using
> those regs doesn't mean XGMI is like a sub ip of GMC, it remains separate.
> 
>  
> 
> Thanks,
> 
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:*Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
> *Sent:* Friday, February 7, 2025 9:26:28 PM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> <amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
> *Subject:* RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during
> discovery
> 
>  
> 
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> Sent: Friday, February 7, 2025 10:18 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>
>>
>>
>> On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
>> > [Public]
>> >
>> >> -----Original Message-----
>> >> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >> Sent: Friday, February 7, 2025 9:20 AM
>> >> To: Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >> Cc: Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>> >> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>> >>
>> >>
>> >>
>> >> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
>> >>> [Public]
>> >>>
>> >>>> -----Original Message-----
>> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >>>> Sent: Thursday, February 6, 2025 10:56 PM
>> >>>> To: Kim, Jonathan <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>; amd-
> gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>> >>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>> >>>>
>> >>>>
>> >>>>
>> >>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
>> >>>>> [Public]
>> >>>>>
>> >>>>>> -----Original Message-----
>> >>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >>>>>> Sent: Thursday, February 6, 2025 8:13 AM
>> >>>>>> To: amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>;
> Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>; Kim, Jonathan
>> >>>>>> <Jonathan.Kim@amd.com <mailto:Jonathan.Kim@amd.com>>
>> >>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>> >>>>>>
>> >>>>>> Initialize xgmi related static information during discovery.
>> >>>>>>
>> >>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com <mailto:lijo.lazar@amd.com>>
>> >>>>>> ---
>> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++--
>> ----
>> >>>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>>>>> index eca431e52038..d4eade2bd4d3 100644
>> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>>>>> @@ -2502,6 +2502,19 @@ static int
>> >>>> amdgpu_discovery_set_isp_ip_blocks(struct
>> >>>>>> amdgpu_device *adev)
>> >>>>>>       return 0;
>> >>>>>>  }
>> >>>>>>
>> >>>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
>> >>>>>> +{
>> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>> >>>>>> +             adev->gmc.xgmi.supported = true;
>> >>>>>> +
>> >>>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> >>>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>> >>>>>> +             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>> >>>>>
>> >>>>> Can this stuff get rolled into xgm_init_info and called directly into
>> >>>> amdgpu_discovery_set_ip_blocks?
>> >>>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separate things
>> >>>> seems a little confusing.
>> >>>>>
>> >>>>
>> >>>> Intent is like this -
>> >>>>       Set IP version info. This is the job of discovery and kept inside
>> >>>> amdgpu_discovery.
>> >>>>       Set any static information derived out of IP versions and not available
>> >>>> in discovery tables. This is kept outside of discovery file.
>> >>>
>> >>>
>> >>> Then why are you proposing to set up static information in the discovery file in
>> the
>> >> first place?
>> >>
>> >> I didn't understand that statement. The function - amdgpu_xgmi_init_info
>> >> - called from discovery sets up the derived information. Only IP version
>> >> info is set inside discovery.
>> >
>> > Snip from you're last response:
>> >>>>       Set any static information derived out of IP versions and not available
>> >>>> in discovery tables. This is kept outside of discovery file.
>> > You're calling amdgpu_discovery_set_xgmi_info which calls
>> amdgpu_xgmi_init_info which is setting static derived information in the discovery
>> file.
>> > A wrapper called in a wrapper is still doing the opposite of what you're saying int
>> the snip above.
>> > If you're trying to avoid this and keep discovery clean, call xgmi_init_info in
>> amdgpu_device.c somewhere after the IP blocks are set.
>> > And put xgmi_supported definitions in xgmi_init_info since that doesn't count as IP
>> version setting.
>> >
>>
>> This is only about structural segregation - like the place where we want
>> to maintain xgmi related data. Functions setting IP versions and
>> information from discovery table is kept inside discovery. Any function
>> which adds further static data out of the IP version is kept in the IP
>> related file.
>>
>> This is not about a logical separation like xgmi related information
>> derived from an IP version shouldn't be set at discovery phase.
> 
> Yeah I get it, there's function in language structure but I could also
> argue that language structures should point to function.
> Otherwise, we could end up with a bunch of word salad.
> I wonder if it makes more sense to roll up speed and width info
> somewhere in GFXHUB initialization.
> The xGMI information is GMC based and xgmi_supported doesn't rely on IP
> versioning IIRC but rather the number of physical nodes determined by
> the memory controller.
> e.g. gfxhub_v2_1_get_xgmi_info.
> Then that would take the pressure off all this file reference jumping
> and version checking.
> 
> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>> > Jon
>> >
>> >>
>> >> Thanks,
>> >> Lijo
>> >>
>> >>>
>> >>> Jon
>> >>>
>> >>>>
>> >>>> Thanks,
>> >>>> Lijo
>> >>>>
>> >>>>>> +
>> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
>> >>>>>
>> >>>>> Maybe roll this check into xgmi_init_info i.e. void early return if null.
>> >>>>>
>> >>>>>> +             amdgpu_xgmi_init_info(adev);
>> >>>>>> +}
>> >>>>>> +
>> >>>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>> >>>>>>  {
>> >>>>>>       int r;
>> >>>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
>> >>>>>> amdgpu_device *adev)
>> >>>>>>               break;
>> >>>>>>       }
>> >>>>>>
>> >>>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>> >>>>>> -             adev->gmc.xgmi.supported = true;
>> >>>>>> -
>> >>>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> >>>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>> >>>>>> -             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>> >>>>>> +     amdgpu_discovery_set_xgmi_info(adev);
>> >>>>>
>> >>>>> If you do the suggestions above, you can just call amdgpu_xgmi_init_info
>> >>>> unconditionally.
>> >>>>>
>> >>>>> Jon
>> >>>>>>
>> >>>>>>       /* set NBIO version */
>> >>>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>> >>>>>> --
>> >>>>>> 2.25.1
>> >>>>>
>> >>>
>> >
> 

