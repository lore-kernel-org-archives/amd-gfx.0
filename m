Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A97C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 06:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F9110E00C;
	Thu,  1 Jun 2023 06:14:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D766A10E00C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 06:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVb6DP4J2NoitraT/A35x3CWPBG35EYSf9FCtD1FfBkzYr++OhUvZMxMGp8Gts71dorA1VRq64EMlsWeCFd4mllLDYuIBma+jYlqEzPwPHYivlxaIKxIvOQh1v2sMCZMDkVz+gDw8dVjdLAkuSB8Zu/cTQ3/kQFkZRTlUGk/wKCrSasE1UP1962Kkd3WJUdorz1rKiiip5dGPm/N/p4lMKDCBLT1ibh8qZ7mgTTexYeH2RIbpDGbGixWVGb1mY1cVNE6imNYIDP0j2c/4MYNm5JC3c1e5ObZPI38ayHoRSHDG5nw2SfLhE7QNHgbA41mEYzbOBr/IcxDJ1E/7BcmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MjMfkE4rL2i/xKKGnn2B301fd+nZ46rClnmBUKRAEo=;
 b=UUhES95DuRmf3lQIIo6gpZVXBd5NzAS2JwAJ1jmJMMY6Iec9ZtGPAIDQKGEfPGWiBQzPNvYG5/9RJdsVEg758KfJIpVFjivNyxZty30mKbOR7CkgBM+g7X+ZJWAGEDF17uJ53r5IfmE3eMU9pVIMTLh6OiwMwdaLZse1RVQsT3v8JSEdSi4LhHflnRiK1+2l7+hG7w7soK9aIWAzIDRE3VTXMdJhJ9tgfB5sMoyOpLx6GMqY9QMU60chSxnAwHfmx707BsU5gFR6V0kfhu9Zyyps/xHoYfe65+O1E2mtsyxbYsgovp68JNY0tzbvQJQXOTeqltTDU7/dzKJNs1z46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MjMfkE4rL2i/xKKGnn2B301fd+nZ46rClnmBUKRAEo=;
 b=BI+OSudPpKkUFewR+H+On7lj/jaJdX1NcOyUmhOTYn8JRQUhR409aN3GZ5qvHHg6tZAlpLAaOfQk/1NyPHJBf+3Vvz1EA/VUo8Ea10u0Rq60THovZN3e6zpTiVtFgC0a7N80puEo96bDTto0KH+MlzBoHigvyf0uaH7mneuo3s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Thu, 1 Jun
 2023 06:14:04 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::8c24:7fdf:3262:8920]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::8c24:7fdf:3262:8920%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 06:14:03 +0000
Content-Type: multipart/alternative;
 boundary="------------0jTwzhf122NMgCnL005seb3X"
Message-ID: <de91def0-4de8-307f-dc89-b5c744506452@amd.com>
Date: Thu, 1 Jun 2023 11:43:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: change reserved vram info print
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: b7741513-0fd4-4770-291d-08db626765de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kkWwtHsLBkje+/cBg5blheTuFjDkZgScUyIsNR3cEoXZDtpWvI/SiIgcMqLQRmpRkz1YsxpybooCWxyFzLLMGQbYcdAggLYQZOBzSj8paMgpm9CQg/tk8wUK13lSjlrlsmQyqHSimue4H51HTbyuKjgPWsXoXNRuhfkzXPywCrwg8vwYbjxe/cNvMryaUitcxgIIDFYFHbgI4wl/kN0xuDhuLM24SXAOSTQ77IwosKEN/sVvlNxnwAkpZkE6ygLmUIyReIs3uopXChTQzsmm6HoLif2WdW97LePNr4W9j/BO02/nDbFyWOMM1J2me7/jSzVKH+KrQhHjI8yHtodApitNxkA6BJD+gWr/OYPLdU02CeL71y+6O029evhO9xjvPxi1MHa3+YLAOrBSGiKt9C2rDu61uKKtKSor6hbMM+u7smsJSn/0VNwnO+GP+PGYKHBwJi72JVsBEQY43h32zHGKIWG132MznZsPsUymYSq2kOrbBqN4ryssW4S/AoRE3Ks9TsqAftSGNszfcwzU+oCSUaUGh/CFFZy25D7J4s09cmJoQXsluLdi3Rj3mjYVu3fwZOiHYrVDxhRptrRSX7UJNsWQ1nXb/zau9fp7h4AsMNeF/Ltx+Xiu/X6NpS+fbKQ32s6EAttbyS3E5ShTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(31696002)(86362001)(41300700001)(33964004)(6486002)(4326008)(6666004)(36756003)(316002)(66946007)(66556008)(66476007)(5660300002)(478600001)(2906002)(186003)(6506007)(31686004)(26005)(6512007)(83380400001)(8936002)(2616005)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWdEM3J4dDJNSzFDYmxLVUZ6SDRiYjRCd3NnL0RWNG55a2hTU0NXQmNSZnFF?=
 =?utf-8?B?N2h3Yll2UXl6dWlnL0lCemVtYWtqZEF4c0hKTGFZOExhRlpFaFFGYnp0RktO?=
 =?utf-8?B?aGJ4VEpIRWxqZk9GdzdPZjBqaGF0blFhRFJiNWptTVR1TUlFeDRqc3hhc0lv?=
 =?utf-8?B?ZGhDcUg2Qzd1K0luOVFrbnFGc01ZZUhSR2ZSYUZWbm95eWsxRCtqSzJqWnZV?=
 =?utf-8?B?STJtZjUwQUpjU1pTdnpYcEw3VUNXWFRYRVRHaks4aFNMVFkxeEF0VlZkM1NH?=
 =?utf-8?B?bmN2K3Evc0F2cGYrcUtoUnFiUEZ4VmdLQnFkMDlKUW9sTUFYRnhWYkxGTVhr?=
 =?utf-8?B?S2MvVS9ZMnJYMUNYcVZMQ280c01DRm1IUy81RmJSaWpZSFc4ekpWd3I3VzNY?=
 =?utf-8?B?c2FyWmZ2SDd3UzZXRFZwMmxmakZmWTlGWGpiKzVSR1poWWl3QVhZYjZpNUlr?=
 =?utf-8?B?UVI4S3VVMWwvY2dMMmkrSnFqeHZpRmlWNmp5WmZMaHVwZ1BaSk1LcytNMk5Q?=
 =?utf-8?B?enlPRmFRdVZHaVFvZXlyVGNtdlE1QnRWTTdUakwwVmRYVFdkS0UwK3ZBRmlG?=
 =?utf-8?B?T3AxTHNxUHdXa2NWSG0rc3Z5WWY5eE5KeDZjdWlDeTU4RlRSdCtxd1Y1NVRT?=
 =?utf-8?B?QWJyNW9vNE5ESWxlclA1azVYYVVoYjVWQjF1RWVQMjhyTEtUUjFTTyt1WXpq?=
 =?utf-8?B?ZXB2aW00NnJNN0J3SHY3d0Y2dTJyWlNjbVRHSUFyRDkvR0Uyd1M1UWZ0dmtP?=
 =?utf-8?B?Q3hPSE80dTRlYjFtbVgvdXpFMlBXTnE1QVRkN2tveUxKQ0FNT3A3bzNGSGZS?=
 =?utf-8?B?aUZuTWpqSThhOWdHNWpMd1M4WjdadWpoUjJ0SmJjeEJob1phNWNOa2drT0kv?=
 =?utf-8?B?Q0wvMFZLMWJZZ0tNaFhJS0psc1Y3bitWS3VVelJ5c2NFNWloRE1jMGE4YlFI?=
 =?utf-8?B?T0NXMTJkUit2aDBpQU9mK2V2N3dHTUF2SVVaVlNwWi9ja2JLTWxBbW1sUzYx?=
 =?utf-8?B?bi9QTWZjM0ZmRiswYlFKMlAycXcwVHFsVXJyMSt6eHZ3L3l5SGl0R0ZvTmlI?=
 =?utf-8?B?MFVwellrR1hVQUlkaEZOVzI3ak1PQU1uREozbVNGNWxHMjFpeW5US09ENUcx?=
 =?utf-8?B?bUVsaGJxMFlCYjVBTTNxbnBjeUJ2R3crdlU4K0NENmxVUHBYWSt1VjVFdkZq?=
 =?utf-8?B?UmlNYVV3YUY1dmxIa0orS3lWdmp2ZDdFYUNVTW9lcFRQWmpQYzU2bCtORk9q?=
 =?utf-8?B?NkJna0JmcDU4YUJncU5PWEg1U2ZQd3FGZWliQkhmRm1NMHpqN29SKzZkRkhQ?=
 =?utf-8?B?WHNtb0hzUUJWZnJNeS9xaUVGNjhxRjhGQVA5NHphb3JXOHVJVFhmY291Y01I?=
 =?utf-8?B?c2RVMVkySnJLS0VyYlE4S0V4QmtURjVDdHN1dXRwNmFTQnZzdHZNdFY0d0RD?=
 =?utf-8?B?NWl3cGNDdE1Ld2svYURicFBTUzlDZkFnai9IT0s3SkJBODdDSWdyRW9VdmZI?=
 =?utf-8?B?NnZqc3Y0ckg3Yk9lMXAzV1Z6U1hzTFU1SnczcDNoRE1HZ2Vjb1BRYmlCcjlW?=
 =?utf-8?B?ZmpldTJCMDNTWWpIT3J1THlkWUt2MjNuV3dlY0JuNW9ORVBLT2VqbmF2ZTZa?=
 =?utf-8?B?emh5OGM1MDh6elVCeXdpREZOWUZIQjhDSXg5Wk1KalJmVjFZVTFrRXdqVG1L?=
 =?utf-8?B?L2lieFFZOGJPcUIyQnZ5RURFZ3lPUFJWV3Z6Y3hVVjhxRGN4aHEyL3grWjJW?=
 =?utf-8?B?QXViQW12cG9FblkycDlSREVMQ1JnWHJkZUt2QTkxWnNid3dXN3J5aEZYQmJY?=
 =?utf-8?B?TzlDSkI5ZUJxUnB3Mis3VG1DRjlwVFdpcCsyWmE0QnBkaUZjaFh6Vml6Q0dU?=
 =?utf-8?B?NEFnL0lpWUF6U3dMVFF5K09pZGxrM2NBaEF1bmN1MVBQSkNoOW8yczFJelhV?=
 =?utf-8?B?ZmM4ck9vWXdTdUpwT0hPSitJOWRFd001S2hXMnFWSjBxMWNGelVieHVxblVN?=
 =?utf-8?B?OWpVWkNPUjNvRzZVYmhUZWlIaWFqSGJOMDN6OHFyUXNNbDVsV3dUYkdGVjZO?=
 =?utf-8?B?eXVRYUp3azBBQUQvZmxUbFBVWkZuZEFRK3k4QVRabkRiK3RFSEExdGlDS0VY?=
 =?utf-8?Q?Eo1xaUUYfDtVlap3IMrIEHewE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7741513-0fd4-4770-291d-08db626765de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 06:14:03.7974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NthjHye34pSMwb2OpvvC4C1Jou2nR3T9pMGpD6tXPezazsnj6jSCvspFwM9vjHIINGacrnYMsoqVcNJQlmlHNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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
Cc: Tao.Zhou1@amd.com, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------0jTwzhf122NMgCnL005seb3X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>


On 5/25/2023 2:20 PM, YiPeng Chai wrote
> The link object of mgr->reserved_pages is the blocks
> variable in struct amdgpu_vram_reservation, not the
> link variable in struct drm_buddy_block.
>
> Signed-off-by: YiPeng Chai<YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 89d35d194f2c..c7085a747b03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   {
>   	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
>   	struct drm_buddy *mm = &mgr->mm;
> -	struct drm_buddy_block *block;
> +	struct amdgpu_vram_reservation *rsv;
>   
>   	drm_printf(printer, "  vis usage:%llu\n",
>   		   amdgpu_vram_mgr_vis_usage(mgr));
> @@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
>   	drm_buddy_print(mm, printer);
>   
>   	drm_printf(printer, "reserved:\n");
> -	list_for_each_entry(block, &mgr->reserved_pages, link)
> -		drm_buddy_block_print(mm, block, printer);
> +	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
> +		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
> +			rsv->start, rsv->start + rsv->size, rsv->size);
>   	mutex_unlock(&mgr->lock);
>   }
>   

--------------0jTwzhf122NMgCnL005seb3X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Reviewed-by:
      Arunpravin Paneer Selvam &lt;<a href="mailto:Arunpravin.PaneerSelvam@amd.com" class="moz-txt-link-freetext">Arunpravin.PaneerSelvam@amd.com</a>&gt;</p>
    <br>
    <div class="moz-cite-prefix">On 5/25/2023 2:20 PM, YiPeng Chai wrote<br>
    </div>
    <blockquote type="cite" cite="mid:20230525085026.1316196-1-YiPeng.Chai@amd.com">
      <pre class="moz-quote-pre" wrap="">The link object of mgr-&gt;reserved_pages is the blocks
variable in struct amdgpu_vram_reservation, not the
link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <a class="moz-txt-link-rfc2396E" href="mailto:YiPeng.Chai@amd.com">&lt;YiPeng.Chai@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 89d35d194f2c..c7085a747b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &amp;mgr-&gt;mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, &quot;  vis usage:%llu\n&quot;,
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, &quot;reserved:\n&quot;);
-	list_for_each_entry(block, &amp;mgr-&gt;reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &amp;mgr-&gt;reserved_pages, blocks)
+		drm_printf(printer, &quot;%#018llx-%#018llx: %llu\n&quot;,
+			rsv-&gt;start, rsv-&gt;start + rsv-&gt;size, rsv-&gt;size);
 	mutex_unlock(&amp;mgr-&gt;lock);
 }
 
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0jTwzhf122NMgCnL005seb3X--
