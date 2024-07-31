Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A60C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 15:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9733510E66B;
	Wed, 31 Jul 2024 15:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zbOvRKvV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004A110E66B
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 15:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yF0UOrvZpXzltCOzQP5gJkZq1cYWcO0xxk8kNsL1F/+h1gunOI81rJm3osGStFjB+YcGWt5hFWXN1DgNDsw6QuSA1kpaYT1zRQ8O0VXl3QJQA4ReDUTG6m7EprW0KGZvkH+FlGyRy2PoDnqgIdaUEJSn6+NZn0gYET48qyFYHD5Y13HnrEA/DRPzJqtp+Lift1zVI0F9658LFm4Lh+3+QYLVJebcCBgBqYWwBljhKY1IYxWhc48ZyQ+W+TXWiHLAyXAcOQWxafyIwvhnZKys7YLJLzFIlAMU82i0Q8lsuX9x5btPJRRq7+8zNYabIllU6JENj7s3ej8zxXulMEGJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJXKy9e5RLcgl0EED0HzjLDJfbqTuc1Gw6PoHlhzxrM=;
 b=Phamajiy0uX6KbDoHOtsbjO6TM6a0CrFiwCqraoR3ocv3DPvb9vnrKBIKZJvegMdl6iDO7GvqgRGJ0RHjbteuS0tROCWpKaYJrgzKvc+M4WLKSnJ1qICWcTVopr+ETY3lSl5wnmnPRH+SyxXZcpcwoQ4S3X2t/k2UIoxhr6dl4SflLP4J2ow4770HfaAzblS1v+iUcpcweCH8RXv/lR9OSK5LA+ivpFVdLBtkGFM/A91yiOqhQPsoOHnn4u+rD31rgnwFlYsE5Qgwt/B9dnHeOnSUhVMwzy1WgllWSKhIaI6yMFetUO7R/bmAsJEXCyGgqCcxWPg5L6FhXtX+sTCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJXKy9e5RLcgl0EED0HzjLDJfbqTuc1Gw6PoHlhzxrM=;
 b=zbOvRKvVdOvCOezwAEj0/kSpHI1yXapWXBC2qpm0JTjZQQTfVSM39mXnNvLwpDupeM0WIYSnk3G1qdnHnRuRnKRiwTIFfjJLYpHA3x3XSuC3VJh29vs3UhieMPPfb7g0t5K/wxOLR8OVfgDE7qqS5PsJmqOhyWwM8tAgOfsNRKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 15:49:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 15:49:01 +0000
Message-ID: <0bfd96fb-b64e-5b14-f60d-5c848aa8efbb@amd.com>
Date: Wed, 31 Jul 2024 11:48:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: change kgd2kfd_init_zone sequence during
 device_init
Content-Language: en-US
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240731081059.312219-1-shikang.fan@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240731081059.312219-1-shikang.fan@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0de7d7-9c1b-4156-5edd-08dcb1784c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1NRNGlmdE5LcDlNcGhNT1Z5RlNjazg5MW5VVDZmQXljUlozMExHZWk3Q3ZK?=
 =?utf-8?B?aExBMlQ4SFMyS0JhVmZ5RldRVlh0dGNYd3pMcDkyNHkyc2hZZTMwQk12eExy?=
 =?utf-8?B?OVNHQVFnbGJlM21OelI4blY2a01JcDcwMUJDNWpuM01MRVc1UFpXVzVJU0RM?=
 =?utf-8?B?WW90MmF4ZmMzdThYTGt6dTE3WldJTnBJdUk0MStsZisxTURKSGEyWWpFZm1Q?=
 =?utf-8?B?ZCtzQ0ZTSXhGelFjSmN6cUFvM0dPcmNMeG9QdDFiRlJJcnlxcGM4WmVDZUV0?=
 =?utf-8?B?eXROSkRFRks1K3FtUDhNZW0veEVyRE1Ed0oxU2UrZU9lNWZBV3grN0dZQy85?=
 =?utf-8?B?YTNydjI0OFBKOUc3bGNhSXVqUzhoUC9qbnBCM2tuVGhFclRVUW1JVTdJdVNz?=
 =?utf-8?B?RDdhbU9nelFyTkJad2NJc2dVanhVSFlvNHJjd29YczB4Vk4xUWtzWVBxRVcv?=
 =?utf-8?B?eElHYnc0MnkvOTdCSTFHTVRoeitxeXd6ZVpiZWtRY1hYQlBSZHh2enFiRm5x?=
 =?utf-8?B?eVJxRG1UMndxMTlOeXlNdC9XWHcxdW8rVUowdHpvU1NGaWFnb1E5YzErL2Jl?=
 =?utf-8?B?K1pEOHBPUmNXdHJtMktFRjF4bTB1RVhySVMrNzJsVWZ0L3FjSjVrQ0hxdmdY?=
 =?utf-8?B?dkxjTWtncjlBdmYwZ3VpVUkrYjBpOUZwMUJGaGpJcGRuTnYzdm5lQWJUR0F4?=
 =?utf-8?B?cjZXMWM1UWVNY3FPWXZCY0YzQVFWZG5QQjh5VC8rQWpHVDA1MGFwOTQrRG9L?=
 =?utf-8?B?cUJCUmRJd3JSKzdtYXpVODRKWGNjbTErUUxhNGJiVDNoYW9rRE9tQndwRWcv?=
 =?utf-8?B?Z1NZUlE1WC9nVVc5ZnpYQ1RSN3NqazlpakxTZFdZUlI4TFVtSW52SnVDSnpJ?=
 =?utf-8?B?MW1Zay90MkhVeFJhT0JEeDRPMW92MjZFZmxnU3hxMEx6SlJualU4KzBBSkk2?=
 =?utf-8?B?QURYWHJsbTUvY2F2a3dZQWpTNmlUZVh4MUZOYUtmZ2lFd1M1bk9pNklUMElI?=
 =?utf-8?B?Y1BJRkhJUzBpMml5U1IxczBsaHBBeXRMWGg5U254dFRLcXk3Yk8wVU9iSzRC?=
 =?utf-8?B?eWFmQ3lTT2dhSG93MDYvZTJSbW02REc5WXo0Rk5hVnJFczF4SFNRbm00Um5L?=
 =?utf-8?B?M1hHZERBbUVKSy9rQWZZMG91cW1ic09Mb1RHYUZIZUhiRm9ZSmlSa29YcGhl?=
 =?utf-8?B?WUFhTlY0MkR3amM2YXFEOUVBN2tJNGdtMWNlNjEwd2ZpcWx5Q2J2T3VKV1N3?=
 =?utf-8?B?ZklIQUdESUdyVUFtYXljR01VYW1YbkYxdDl2ajlzamVUMWxaR25aWDQyeVA3?=
 =?utf-8?B?NmFRMzYzaEhjZ1Y0c2ZLT1psbkc0V0E0VGw5TFNHL0FEK3NORitoVUtlTjY2?=
 =?utf-8?B?WGxKbGVMWFhGSGdJWWw3bFp3Z0k0SHo2cXZwUnF4TzhlVmcrVzJUY0JmcjhO?=
 =?utf-8?B?LzFKL1MwdGlULzhRdDkyVU9ybDEveVJKazQxdExDU09UZ2ZTbFRjTTQ2YzVN?=
 =?utf-8?B?YlBCbDdzek9pV1Bsa3lMYkRadnMrUi9VNjg3dTUxeEpBL2pJN3hpaUJYQlZF?=
 =?utf-8?B?YjVTSjFyeVE4Sk1qL0xwcDNHOVZ5NDRQa0JmUFlmYU5NUUFwZ3VMM2s0WDRE?=
 =?utf-8?B?Z2pad2pKSERVRnBIa0I2bGVSamE5cXE2cEZFblAzWS9rK0grM3hIUnZ5UTRM?=
 =?utf-8?B?bm5lM1lZTFFzdk9CRmZmOUd1YksyRThrRG1pSE4zNlJJUzNSaDZjK1llK1V6?=
 =?utf-8?B?L1RTWWtkUmhXVGhIWUZreUNQLzRKV1cwS0FIOUdIV1U3UWkvZHBhSnlEWm9z?=
 =?utf-8?B?Rld1RFczRzgyT2ViT1RkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpsZUpzL20rYi9zbHF4MmM0VEFORjBLSmdOQnRMODFRT3VhTDdVZFVvVlpZ?=
 =?utf-8?B?eUtzQThad2hwV1NkSkRUUXdnYmtESkFuZXZSWkxiYmlSNXFBaTRVV1hrNDdr?=
 =?utf-8?B?SDZmOTYrNkNXSjBLdEdhMytZM2tkSHl2RW5nMVZDcXFQMVFNKzVoejBVWWRO?=
 =?utf-8?B?aUpsVzVZWHlXMDVmN01TV0k0Q2RHSmhkRWdmOVMyRnNNWmYxSzNYMjI4N3A0?=
 =?utf-8?B?UGt3MkkyOUVreWpQV0p2eUhDN2ExNWpURG9Vb2REN3ZkNUIweThHakJjMkFQ?=
 =?utf-8?B?UUNLTXlaSExKZWkvdTIzVTZ1cnE0elc5UHQ1TkF0VE5GcDJpa1VJYTlBMDdD?=
 =?utf-8?B?QTNqN3JnUTlCTXRrT3U0OXJOSWVuUHFpNEc0OFFndlRwdFRGN29KN3RtcXdM?=
 =?utf-8?B?OWFDckFrWDhMdHZZTk53aVRzTHpiTDBESzVoSWRobE1pTkRjV1ZUSkVoNUtq?=
 =?utf-8?B?cVhTUTYxcGdiUW5QZjl1ZnN1ajJldmxqQ3BrMzVwUjAvMHpVQzRxYXp6SGsr?=
 =?utf-8?B?VnFxWVFRK0hNOGtXZ05HU1Z6RnNVeVVRRWJmZjZwRmtsNnRNb05qaDRZT25O?=
 =?utf-8?B?QVhkRDN1TlhGMlRLK0pZZFZnSCt3NTNBdUdDdnR0RWZhM1lneVlFbkxqU045?=
 =?utf-8?B?ZXRwNm9uZjlaZndJeGNiR2NXc0w4YVQzclBHYmpHdWRYVW52aUlmeThMWG9s?=
 =?utf-8?B?a21Cb3FmZlJHZ3JjbWUyRGJGRDlTUmYzYVBKWjFvcHhZb1M5MXJkZzMvY0k2?=
 =?utf-8?B?cEZjMjJQVElwdVdFTzYvR3ByVmROK2JNbjRlK1h6emlsOVdvZEo3K3lFQWtT?=
 =?utf-8?B?Z1JWY3ZqaWpyVHkwRmMzcG13ZGhoSk1DY2tKeVRzS3FNRWZiQWFHcy83cElp?=
 =?utf-8?B?WmJJYXJuZTVnbTJsSWZxczdIR0VkNVFiRWpFMEdLbWVGNFBqTFFLckNENkxh?=
 =?utf-8?B?bkJlbmV1VWw1ZEtwcG9NM1o1RFBoaFhZclA3RmpOcHRNdU0xa2ZMdEdxK04r?=
 =?utf-8?B?Z0g3UVhDYWNJRDVJQWp1QTJIK1A4ZVRacVZqc3JCcTlNdWZOYjh1amtnZENS?=
 =?utf-8?B?RDVPV21GZWNZbWM1Ym1lWnYyRkJMMnAzYW5OUVVva0RhWHVRMlhZVTArclV1?=
 =?utf-8?B?eXoxRGpHWXliY1RjQ3NyU1hJU092Umgrbld6a3hyVWdOOHpMcVpwS2hrM2R2?=
 =?utf-8?B?WUFnWC82S0VhVjlNOEdyWFhhQXZyeGEyMHdHNEJ1NzU5c2M4LzNHeGl5L3lM?=
 =?utf-8?B?eEVzQzNuOXRkOU8vQkpUWjNLSGgrUWJwYnArS3IrUTcxYUx2aHlrb2xQMVI0?=
 =?utf-8?B?RFJuTkFIYlIzempuVlVtUjJyWGFEYy9QRjJHNjFteXhaNTVNVjloOUc1RGRN?=
 =?utf-8?B?djFFenM3V3VVWWQ3MWdMOTIzUi9ZS3dRcDEvY09XU3VTMVMrSSt1L0ViZ3lv?=
 =?utf-8?B?R2lFVjM4Q3lhTlREWit1bWZ4YzBZUFpVRGtVRk0wYk9Ec05ReHFnYXpHZFdM?=
 =?utf-8?B?TmxOMHFOZm53ek9ZQ2Rwd1RYOW5LSW5hVTBrcWNXSW05TFlBc1BwSW5zT0Rw?=
 =?utf-8?B?ZEZERlh0djRXU1RSRE9hY2NZTC9kNUtQcVkzak1yMFpWSGZ5WDVZMjJsMUdx?=
 =?utf-8?B?Q2J3OTE5bmg0d0pyaHdQd1Nyd3M3TzBrTWxlWkxDTlMwd1JZZXpITHBkWjBS?=
 =?utf-8?B?SlZsMWpNZnAydWlxckxFajhidTkxbmZXT1k0RWY0WHJQVmxoRnRCRkh1Mkd4?=
 =?utf-8?B?NTIrcTRlbkNRMEV0OG5nNVhQTjZoejk3N3pyaEtGb1Q0eGo3U1luR2kvZy8y?=
 =?utf-8?B?bjhsQXVWMTF2bGdDem96ZENGQzFHUWJTb2dVdjYwbWRDWDIzR1luTlpjdXdr?=
 =?utf-8?B?c3pldEJzVzRPbEp2Z3J4UWN0Kzcvb2tQdDc0bnhtdUVWREc0bkl6RWlCWTd6?=
 =?utf-8?B?ZVdYN1UwV2o1dm91cTZXOVBTeW9HOStPTStibGsrYjJCTFcwWWJQSWJXc2pF?=
 =?utf-8?B?K3lYWnhFRU8wYTRSNU9OTXpCM05JUFRqZ2dsWG1nRXMyWGZZMGhyc0dQNWlZ?=
 =?utf-8?B?ZncxcFpPL0JtdUEwTTQwa0tJK3FrR3NjOHhVcVpJRHlzMTRDeDZhYy80anRF?=
 =?utf-8?Q?zMOA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0de7d7-9c1b-4156-5edd-08dcb1784c1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:49:01.2450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZ8QFRQFHsSqC4B+GW8aKVcsuBMZNkmVCCi32Mtw6qKCWu0+rqmvANxbc4eMvLMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
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
    <div class="moz-cite-prefix">On 2024-07-31 04:10, Shikang Fan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240731081059.312219-1-shikang.fan@amd.com">
      <pre class="moz-quote-pre" wrap="">Move kgd2kfd_init _zone_device() after release_full_gpu()
as it takes long time for asics with huge bar size and it could
potentially hit full access timeout for SRIOV during init.

Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3a43754e7f10..4494fa7ae70f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2930,10 +2930,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev-&gt;gmc.xgmi.pending_reset) {
-		kgd2kfd_init_zone_device(adev);
+	if (!adev-&gt;gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
-	}
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -4362,6 +4360,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&amp;adev-&gt;delayed_init_work);
 	}
 
+	/* On asics with huge bar size, memremap_pages can take long time
+	 * and potentially leading to full access timeout for SRIOV. Move
+	 * init_zone_device() after exit full gpu
+	 */
+	if (!adev-&gt;gmc.xgmi.pending_reset)
+		kgd2kfd_init_zone_device(adev);
+</pre>
    </blockquote>
    <p>This change will not work because KFD amdgpu_amdkfd_device_init
      check KFD_IS_SVM_API_SUPPORTED, it always return false, as a
      result, SVM API is not enabled for user space.</p>
    <p>Maybe you can move two function calls together here, if there is
      no other init dependency issue. <br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; /* Don't init kfd if whole hive need to be reset during init
      */<br>
      &nbsp;&nbsp; &nbsp;if (!adev-&gt;gmc.xgmi.pending_reset) {<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_init_zone_device(adev);<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
      &nbsp;&nbsp; &nbsp;}<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240731081059.312219-1-shikang.fan@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
</pre>
    </blockquote>
  </body>
</html>
