Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359BCE7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 14:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D077210E05B;
	Fri, 10 Jan 2025 14:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GRFfmRzf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06CA810E05B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 14:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4Z7isoStwBnWpgGJRHVH8Tx6w8H7E4mOaCB5ZdYLDwDLbrmpBJEofL9IcvrLTL4rWXRm0jyBn2lYxu001HS/P7DvO0ivxtodxD0dHt+/rZ3CB3tHTlTTeAPUoA3z9U8J8eM06V/Y5Nl+F85XN4+9dGGQGdnMaVeMyUrmEJq5GZiB7dlUCfzaaBMZ7lQShj0+zXZVD+0iIHyeZdzO9VDQyVgGKeZ4nGsILBeNI6qxs5TnBd5LguYaM/jX+EVeH/VOKYdrjSmuXA0uCTvEQdHYfZMwJOrs+1cQOXg6wDs17jCWm7fHeBSEtN7nkEZF3SLNa6sdyEnRso8FC6ATmo6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcsPfLXaTnc5LRaW62KKOfc9yRqgWafablvHp2CJw1c=;
 b=i7oECJ0tfUWc7WN7MX9JVC8avHE4SJLbrIdGuSYLUSViPPgOzhYlIRATInffhSlMmg363ZaNoCOQGhXBskjiqiav+9m3ZJKLIXjMQOxYkJvyxEk4pa+bqMSbI67c0lUzJ7hm0QI8nRLBS9XFVxeFRZJoPEYXMDwBpW65W2JzevmOjwDyciueZlMwklbw4nkIpH1bgZ3HAY2LUKRMoKlXZB2+ddiremFvom9NUI5jDZoPNkhkbwPVrTBhMESbK1Jbb4XGvQqvB2N5+DfE1GXhYQzugFmdUMiBteEzCMsqDdGaWXc35meXX2zpMAFrNP7pDy9Qv3X62tLTGNxTKwla3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcsPfLXaTnc5LRaW62KKOfc9yRqgWafablvHp2CJw1c=;
 b=GRFfmRzf/BRYHQSUpk/HW9pceP+T+l0ID/07aABUgV16a6V6UhfckxRXlc0GCQyJfFoX8fjZYhrZcFNE87Tpo1enm/096m3HjpmcdreDusBXgTKM90xcPCq0EheV7uMFPkVympmqxj+8DItlz3Nd2hf2QQIG7NiiNpA6DIiGnmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 14:37:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 14:37:34 +0000
Message-ID: <28f8397b-0f2a-4738-22e6-734abc21f0a9@amd.com>
Date: Fri, 10 Jan 2025 09:37:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250110074924.1441364-1-Emily.Deng@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250110074924.1441364-1-Emily.Deng@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d983685-153f-403e-0caf-08dd31845249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mjd2YlhIZnl5MWhGN3V3Z3UvYzdpdjZrRHVES0hlZTVPWEVGT0ZLUVNnRVJ0?=
 =?utf-8?B?a2VRTkVhbFNSQ0xsL2cwaXZVTTNzREQ0NXc5L2E1aC82MXRVSC9WbWoxR1lL?=
 =?utf-8?B?bjl4VDEvMnJwUHhGdUdXZjQ5ZDBJY0h5UEFCRDNYZ0syYkxFSnl2Mk9OUWdu?=
 =?utf-8?B?bkV1NXo0UE9vQjIrVU8xYjVSbktHRVRVTmdNTXFhL2N6TlNBcjJ3eEt3VjhR?=
 =?utf-8?B?bEdHdHgrRUR1eVhUbnArckU0bXFNVHdvTXd3bEF5MStxaVNRazdTRU9CRjJ6?=
 =?utf-8?B?bHF6UXhibVNuODZGZEtMNkVNOThCU1N2Q25SL3ZvYS9KazJjWHZkVlRLR3Nh?=
 =?utf-8?B?eEMrQmhrY2tkcjZrMldDWFhEaTZGcEdhR2Nnb3ZqZUladnZvVy9TZm56Qysz?=
 =?utf-8?B?REFyZ1Y4V2lMMWpoNk9QSGc2TWg2UVZJakJ1cHdoSHhMMHd4eG5Tek9tUmZX?=
 =?utf-8?B?MlVaQjJJWFRWV1pDN0lJY2JnRHFXa0M1N2lNemhuL0pDcWdpOHE1bWpmeXcv?=
 =?utf-8?B?THp4RGY0VmxVRFRNL0xlZjFVbUYyMG40UEY5aXZtMEo3R3ppdkVBb3RjR1po?=
 =?utf-8?B?ZFZvdnhaT0NvNnZucUQzOUw5K0pEeGF4S2JxcDlWaXZwTHhxK09JaWZYWUlo?=
 =?utf-8?B?aFVZdXRyUVd5Qkh4dGdjYXV0VlRvdzEvUkh0NytPWER6TFRybGJNc25qM0hQ?=
 =?utf-8?B?bVNBYWZCWmNkN2cvMGNIZjB3SDBrcUlONEpBZnJYN2NVSFdVQ1B1ZjFNaDd4?=
 =?utf-8?B?ejVBOU9PNDZVWkRFY1lYVGRRam5lM1A4R2JmdlhOclkwcGxZMWg1bnhGUHQ2?=
 =?utf-8?B?S2pRQXEreFo5UGE4dFJ0Ulo2T0ZqdzFDbWZXLzd4SWVvZi9Id2FXS2lxazlp?=
 =?utf-8?B?MHRUVGxtUGVRSE5wVXdEYU5qY09oWWtvNGlvdHJaL2JkOURnTTMyMUo0MUZj?=
 =?utf-8?B?UTg4QjNacUYyQW8xRnNOc0t1ZzFHLzltc1dpU2F2K1FjRXNIUm1Dakoza3hS?=
 =?utf-8?B?dFgwejQ3N0d0TlF4YWRCUnVPTEJZS1MxV3ZTZ3JSelUzSiszRkdOQk0yWnln?=
 =?utf-8?B?ZStUVVRMYm1mQVZPRVNFbncyWG5YMnFxZTg5RW5WOFp4M0RhMXlMWXVtZWo0?=
 =?utf-8?B?czhsYU16Y0xZRGdOK2NYSXEwVEJvSnFIUk1WYTlzYUJwQm82K1Nnclh6ZCtT?=
 =?utf-8?B?cDAySlVYakVBckF2Q1pYYTlPaE5JNU9FdkxqeUFoc2xBV2NqbzB4blVZZ0Fw?=
 =?utf-8?B?ZmcvUk90N1I1RHpwZmFKZXk1eldnUmdycFd5VXorTkdBaThYaEk0TnVYNWtD?=
 =?utf-8?B?bDNWYmtnS242L3Q2REVsclRwZ2tnTTFha3dFVEMvN0gxZ01JdUlBZ2x4bnpX?=
 =?utf-8?B?bUNHNXdOaU1BT1cxcWt1amt1MGlYVFhwaUViaFVXcE5uKzVZVFJuRVdGNVNJ?=
 =?utf-8?B?MjJqcmZ0SFllbWhtWS9SM2ZyN1N6UFhINHJNeGRWOHJDakVxdWtvSlNuQi9o?=
 =?utf-8?B?a3ZlOWpSSzdFVDRQNUdHWG13bkh6a2NnMmEwcy9sWDJxejYvaDVwYTFMd2VQ?=
 =?utf-8?B?RXFLN0FudDFpOGNXeG9KWnAwNUtoTVI1dFVDWmJ1Z0VzVzhSc0luOVBxeWdn?=
 =?utf-8?B?RG1XdktOV3A5Qmk0VUw3aHZLYk5BL2JlWjBncmthQllYaGhLeXJoUTNad1Y1?=
 =?utf-8?B?eTU3VXY5WU1zSFQ0My9acUNiUmVHOWdYeTlOMHhFN2h5Z3g1aXRXN3VoRXFK?=
 =?utf-8?B?eWpJem1BWStzRDhvSCt6QVF3NUJIN041MXdwL1Z1NUxUdjBSbUR0THZVdFp6?=
 =?utf-8?B?RnRkeFZIZm15YVM5Ky80ci9BREdVUVRHNDBKL01HZTltQ25SUjZFS2dVT0NG?=
 =?utf-8?Q?5sZpzyCwcrs3/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdkQW5ZL0ZNRnl0NVpReFVXdDY1Q1NUYmQ0UjBYSnVlaklkazVBdExSRzli?=
 =?utf-8?B?cm1zdis4U3FjUTB6WkJDSHZjQjBSS0Q4MFVqdlVvTTRCYmx2bVZYb0Y5blZu?=
 =?utf-8?B?RTJyaU9xMWlZU09PaEMxdDJjdWZObzRJOFNtUGZaL056NEIvUDlvcnZJN2Nx?=
 =?utf-8?B?RTdKSUFhUGZ3eFpGVlJFd2s1enN3VlJweTZVa0xsazJQMWJRQWlwRCtQOXpF?=
 =?utf-8?B?SElCK05hcmN1VndwVWsyalZGZ1lPbW43ZW1oR1hyYjZvT1hsN1NwWW10Z3lq?=
 =?utf-8?B?dkpzZE5Kdy9QYVh5QndsaWZtaHViTTVIU05LeFZzOHF5dk5BQ1VQMjlnQzBs?=
 =?utf-8?B?cmdGRTlyMVY4M0pjUGF6OEN5VEtGdTZNYktEeE9yc2FBS0JnUGRUR3ZjVElV?=
 =?utf-8?B?aElFSGMyck05YS9nNjlUT0JIMUZlZXU0Z1pBY0tsbTRkRTNZYk5FWDRHMklC?=
 =?utf-8?B?aFV0a1ZoSVVuS3Z4elJULy80MW9vdnZXVFVvTXg3bi9YNFlwcnFLODdQU2Ns?=
 =?utf-8?B?aEJuSHNNUjVmNlhPR1FhdTZmQlljR2cyR25KOWZoUDBuODlRbHFDcHJBMDRk?=
 =?utf-8?B?YzFaV1h6MkVFcFBJSUJRdVBUUjAvMVh4cDhZZisxT1VPSU9jVmZ2K2tLd09q?=
 =?utf-8?B?OXAvbkNxU3I5Y2VEZW5KN0ZYZmIrNDFuM2JDeWlIVjkwbVhRdFR0MXh2a2lu?=
 =?utf-8?B?QU9BL1k2b2E4TEIyUVJrb0ZiMkpNZVJXNVBLWDBvUlZwZlRXKzRHUzBHcDI5?=
 =?utf-8?B?ZzVxamlpa25yYzBpUVE5OUd4dWpkOFkvNytabkIxT040V1ZKMTM2Tkc1ckdW?=
 =?utf-8?B?WmI0S3oySE81ZzA5aFNmQ1VpYkl2OHozblhtejVaUHBoQ3FIYk9sOURMOU52?=
 =?utf-8?B?Tm5XT1NlWlY3WnQwN0NubDVzRy9NMWRQMzNqU0RTZ3d4a1pWbEpBaUk2MXY4?=
 =?utf-8?B?dXFWV0tHRG1hYkx2dHZsQWxtdDZaZGJtUmlzQnZtZjlIRTJ3aHlFOGhEZ0l3?=
 =?utf-8?B?bFBjaEk0dDNRWjNUbDFWazVoYXNFTVRJY29aQ2FzOXV5ZW5wQ1g4R3NkK2RP?=
 =?utf-8?B?b0xNc29jaTNGeGFVb1ZOc1prSXNERVc2cGRBZVFrTGhHaFpVRGkrNXcrMjU5?=
 =?utf-8?B?Zm4zcjBWVjRBNmx4YW1Jc09EOEFMOVkybEhEVmpVQ2FYL3JBcUMvTjFXa1V4?=
 =?utf-8?B?Q2tOSmptdE9IU0hIWnVKUXJzYWh2MUY5R3hpdFM5c1VSMFNpNExqaHZTYkY0?=
 =?utf-8?B?QjFrK2U4eGlVM0Q0ckFQRytlZkxVaDBSa2oyNjIwVU5lRjQ5cXBud1pEMHNG?=
 =?utf-8?B?dEllN0huVis0T3ZDWnVzQ2U2emw1cE9LQlVSYk1SM294UjVNMjFjNzZ6T1N6?=
 =?utf-8?B?R2ZFZTIvaXVsdUV2ZUFvODhWVFBPSWhSMXhGNVlxekpVVmtNV0Q2Wkx1RXZy?=
 =?utf-8?B?T0h6OUQ2T3F5dWovSXhIQjVJSDhVbnhpdVlNcjN2emtqbElXVE1sRUdGRCtm?=
 =?utf-8?B?TlBoQW5hMmQzODdUM1Z2VzhhbEdGakdSb2dDanJRUFVsbUtodFZXN0VjbnBu?=
 =?utf-8?B?M0VaVXo2WGs3bzRzcDRVOFdaYUNUSU9jSW5VVkVINnFTWm5PL3UwdW50WEhx?=
 =?utf-8?B?aXEwVzl2UFBVTnk5a09kSDhVZk9MWGo5bForUEt5WUVJZWVzZmVGakdpK1hD?=
 =?utf-8?B?UjVvMndQZ0RINXNEUUJOR05NdUpPcjVqdEV0NmYrdldURjg0TTM3YUJvS3Av?=
 =?utf-8?B?ekI1c1g1QXFaZWJjKzBrQ1JORWduQmJyb0h0aFNaNE9xcFdFaXZWbUEyKzZM?=
 =?utf-8?B?djZXRkorR1RxUExNUkltUEJjSHFnZ3owaHR1UnY0eWR2MERDNkxzTFBmZ1pT?=
 =?utf-8?B?MmhNdmZCK2Q2U0k2aFlmcjZDS0RyeTBOWWd6V253SE15NEdsbTViUUI3TTRz?=
 =?utf-8?B?OXdTVEwxR3N1SVMybVlpRm82UGxpNDZ1RmRyazlQcGZ3d2pGM0ZBZXljRVNZ?=
 =?utf-8?B?WTNZU29LNmc0a3Ftek5VUVRJSG1HTnVkM1hxK3JjZThLZVM4cHZ5d3o0OG1L?=
 =?utf-8?B?SVB1S2txd1RXU0thNUFOZzFRUUk2ZE54djFOOVdDZmFSOUZRekZLc2RTaEdu?=
 =?utf-8?Q?HYAE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d983685-153f-403e-0caf-08dd31845249
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:37:34.4199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MjtQrQ6ES3dlDUjA2eFBIXXUAC4sJE3fJRa+qGurDTb2ISaoITcic2RhLprD5uD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-10 02:49, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250110074924.1441364-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

v2:
Add mpages to break the loop earlier.

v3:
Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.</pre>
    </blockquote>
    <p>The error handling need below change, with that fixed, this patch
      is</p>
    <p>Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20250110074924.1441364-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..bfaccabeb3a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; i &lt; npages; i++) {
+	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
 		struct page *spage;
 
-		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
-
+		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
+			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
+			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+			mpages++;
+		}
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,</pre>
    </blockquote>
    &nbsp;out_free_vram_pages:<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);<br>
    -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (i--) {<br>
    +<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; npages &amp;&amp; mpages; i++) {<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dst[i])<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_put_vram_page(adev, dst[i]);<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = 0;<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages--;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
    <br>
    <blockquote type="cite" cite="mid:20250110074924.1441364-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>
