Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405BBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 17:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6798210EB65;
	Thu, 29 Sep 2022 17:19:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739E710EB65
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 17:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGpZJq/eJS6+u5vulkH4BjBNR44cdjz6CAwPnOweR4ElzX9ofy9FNz6nXamJhOS8m41sOwtWv3kfihJCt8tOM5AiEnHP3MtBkbloZoHwpJjeTJdKlaB/x3zy+rAFDC5Zj//c03qvZaDSRN7gjL1jne/hLcB1+EsnBbmNHp0HC3VLlaSr/ML3kxo73nH12L741jSC9dIoPmA9B5lhviU1nBw/+jo/IvCEHV86wXRFOIiADIpfHhvOs5Yl0X6ugFBu7Hol19LBEzu8Vl7fz1g6i+1lzVWrl9zoqKn6F2whirMOR60EnwAGdjMRRUS8xAp45Q/wOSztG67bqEiQj5cDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWHxnMgzOzigItaPUpPFdn8UXW18N2He5BBZqdLpzAM=;
 b=WVAWJQB8jB8B5o9EvYYUkJRqNLlRUq1fiRxxc6WDqshhg1CCxQQWyNR2qtSjmMkxiE2iodacFg2NEM/SzMxcblUYKETbRo1mobEXKwBRgdGDWiMZC6bcth4tTk/+r3TVKOv2dfW81bLWITui5fJCxeToj2dXNiebbA6/VlNd5yR1nif+O0+z+IVsRGHZ2LnwhwxR8LhnVBAYa2qIhp+QQrSgtUrBheUV7v2ToYkpotd6m1+1AuH/mVtn/PQ+t5hkEReVva5xFss+1jEgSi5kjx6A+1tVzYONVryoXg+WA8NcxjIgH1EGGrf7CSQt4Nmwpld9rV5xedWbJMEBSCDmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWHxnMgzOzigItaPUpPFdn8UXW18N2He5BBZqdLpzAM=;
 b=eSUTlD/sErbesdWjfwtumdwMbm4AxyQfZLmB0KhVcnC9WdBNN82WKIaO0/7OW8mNNkE39oJdScb2CvmxdRvcenh9GxSUcDSjgR1EMyPg/x7SbSL1uxMtQVeiR0R75wLtiwPA2Hio3Gm7/xSrXxg/cLl2ADb3re4bmMGCqdo3PEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 17:19:14 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::4a3:339a:79f8:f60d]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::4a3:339a:79f8:f60d%10]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 17:19:14 +0000
Content-Type: multipart/alternative;
 boundary="------------FnSGBOL0a8eSZYmad0DIFwJv"
Message-ID: <bb920412-e241-5f60-c96c-ba994e8a2f3a@amd.com>
Date: Thu, 29 Sep 2022 13:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable VCN DPG for GC11_0_1
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20220929165023.103134-1-sonny.jiang@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20220929165023.103134-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ef8be2-2f46-469c-a913-08daa23ebb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRYjuderJC5tVEnphu7k6TOL/hQFZWOLQcft+qGFHAm5fW9LikHSpjk0sc8VW0SzmGdl3Ls3IrwS+eXDeBPV307y1OgETrM+Te8k+k4rewn0Bs4tME9LJqW0Jt/N4LoL+Ll3cnF2Xe4vq7nFUg96ztDUW7P1Aii5tuJ1sv7DU+yWrumnB+QVqS3MoCWqq9YUEegl1SRAlhns51i6qkhcxyibYyKB3ZivOHpdTg8MKh58VH5b0V/D0q3JJrivVVjqJde+9oVs6JOry4CDH8ajYDYDUWPeHel2WYUMX0hsRrsWSjpqTZ8GVI912bLyc7MwpGa6BrbeoxvZ96lhzHqOEXmpyyN7zo+yrIS4pYEgo/7XJf9Iew7u0CNRUk3uZddP/ynJmOFG/XH2erNzHgP6ALqhl9xjB8Crz1lk9TXd+HeJL271/mUDMktuySBp9EZdDVFZqsC2s+33lfA2QYDXqkXOOsJJm0S0FF8ONNE3AePmT4AxZ/mK0sINEcfnv+F4xnzAUd+PqQjHZplAZeMoPz6O6h4fM9bx+sOkTujbsBX+tDtSCLSwnsxB2HZmZ6adCIW5QDOsn6VZLFHyg4gjVBPN7bMul3uTJfCtOpf2u2ZiO7A8r3+GBaz7QEQclpHQpzFRihAEd9i9Bk6tAMrm+f4oXxe4La+v0YBoYo0NkPhIpyIKmT1HoUbRyqCAzN3VXBT2FbzqCXRSNIU25ubHTRTb/4VkUaZldU43poDuCXj0Lxg3oiNZakJey8QR57rrjHJvvQ1KeEdbTseGNhazZISUJAnfcnEXdWXJNXtH4Ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(31686004)(36756003)(5660300002)(26005)(66556008)(6506007)(41300700001)(66476007)(6666004)(8676002)(31696002)(38100700002)(2616005)(186003)(2906002)(33964004)(478600001)(53546011)(6916009)(66946007)(6512007)(8936002)(316002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhUbW04Z0gvY0FoMEhVempseHlCaVJZSGY2K25WLzRhU3BaOXV6VDdrbFVB?=
 =?utf-8?B?a0NHamdFMDFFVWRoYVhDenRLT2FKdlIzWW11YS94WTZIa1Y4UXV6aE5JQ0Y4?=
 =?utf-8?B?T2RSZzRvL3lnU1doSEVCRVI1UUJiRnRqYjhScFM1b0lSRW41cENaNExkaTdt?=
 =?utf-8?B?SGhId21DY1RPRzEvV1lIelVJTnJ4Q1hkNmhQQ3JwZWxVbE1Za3BjMTE2MG80?=
 =?utf-8?B?YnB3KzNRdEg0dWJVWnBBWUFuaDZjZk9jR29FaDd2N2czRHpjb3dtUmZ0Rml2?=
 =?utf-8?B?MU9yeG1hVXBXQmtydXJHMEJZTFE5VXF3SW1rU2c2RHhwOUNmbTN5a0l6ZTZz?=
 =?utf-8?B?YzlibDM3cXBFQS96eGxLSGJpV2R4aEJCOTNHL2VaZWgwa3drb1N0aVA3a3dB?=
 =?utf-8?B?cUdsSFVtYU03ZzR1VTlPRkljcHQybFhVZDdQdTBEejJxWWFhWWFLeWZXQVFw?=
 =?utf-8?B?RlJCRnJwMS9aNTVpYVRXOUF4akdacGh0bXo1MmRjS3JDYWFzMWZEWVdqV3I1?=
 =?utf-8?B?QStpMjU3MnhwSG84cDlzV0JlNHpjRlpTb3hCMXBJRUMxTThzeExzSlVGMSsy?=
 =?utf-8?B?QVpINDh1V1dSdDllelNmOWMyNmpQbVNvV2pTbjBQbHhaR29YQ0FsRVNsKzJy?=
 =?utf-8?B?RG96QU5hcXJYYzlXSk44Q3cya2FvU1NLMVFMSElBZzdkbVRvbnVtRnhYQWVu?=
 =?utf-8?B?bEpGeThEQ0hNRWJNRGk1OGZ6dGtqU04yVTcrdFVCWFVuakQwZ1cvTXBKcjFl?=
 =?utf-8?B?UWpQMjBmSHdyY2Y1M1BvU1ZWa0VrT1lSZUhxdkpScEhpZTFFT0hsUWoyMTZp?=
 =?utf-8?B?WEI2SmxvUFV2R3duaWVFNHJ6YUJNQUU1SjRZdFBrUk9NSmtzNVJUTVlZTkFo?=
 =?utf-8?B?Z2h4ZVlmWlB4ckp0cWdZWUdCRmRKczc1YUJsVGZuZ2tHckpxVkFIVCtvMWda?=
 =?utf-8?B?eHNNSVdLdFpMZGVGbC8rUDBETWNvdDZmNEJtK0xVUHJXekNjS29neXNCdmo1?=
 =?utf-8?B?bE9aRVRvK0UxdCsvamdJMmxuVnUwckUxdjhmNjkyOXpTY1BZVmY5VDRSKzEv?=
 =?utf-8?B?WGplWDVmT09DTWcrSzdJVXNwakIwdy83VndzVUpEQmxXUFh2NFFsellUOUtF?=
 =?utf-8?B?Ui9wejZ1bXY4aG1SV2VoNEszbHZlb0tZWVhuNzZ1ZnREalhSWTFsNk96ckky?=
 =?utf-8?B?aFlId3R2ditTLy9GM3EzOXp5SE40bERpb2U0NlFRK2gwT3Bqd1UzTkhuU3hV?=
 =?utf-8?B?RTBnckVwZklaRVJmTmpVRENhZVVIYXEwUjR1cDNWVkxjNFVLU05yejFqS2lw?=
 =?utf-8?B?VnhDN0VaRng0K1RuRGJ2dkIxYjViMmt2dnVVN3crNGFMRHVOclFmUGJWVE50?=
 =?utf-8?B?ZGxlRWgwNS9HUWtnK0R2Slpmc2xWRTYxU0tVZU5ESFNxU0dFV0ZianVWVkVj?=
 =?utf-8?B?TXdMald1VHRTT1ZCd2l6emdJQ2NLUENIb1ZXTEZJVlZWL0hrb0duZzRkSzNM?=
 =?utf-8?B?SmY3R0xSNlpQVmtDeFZPdmJQMFhML0p1SCtTaU13WGlvdlZ2dytObFo2cGpU?=
 =?utf-8?B?bHVsdWEvdDBwQmlSWkRmb3BhQUVTLzVVQnNpU0EvMHZRU1JFaG9SVkJDalla?=
 =?utf-8?B?UjhSNFZPRzRWaWRzSVhzZFlKbnRhejUvL1QyWnFNalprektmaDE2b1hHUUsy?=
 =?utf-8?B?OVlNbDBrR3JCSXlCMC9FVDc5d3BBelRwcTBpSkYzcUdMU1pvYm03L1ZDTExF?=
 =?utf-8?B?VkVIRkI4ckpYWWlXb2hNZExUandqdUU3V1V1TXk3d3RPdVZaWU1WK2w3ajlm?=
 =?utf-8?B?clJqZjdKMkU3aHlLMExHSmpxWTRJeS9LMCtiWFhybU5pMmN0aFFsVFVkYW9I?=
 =?utf-8?B?R2RqRnF0ZzFZYmt0amswVncwamorR0pKbWZDNSt3bE85TVZYY1hCbDgxYnZL?=
 =?utf-8?B?d3p1ZTUxRDE2ZUpRUFBiTkl0SUp3aTBGd0VCNDBUYWZaNmdxRlBWS3VRTVgz?=
 =?utf-8?B?NTFiL0wwcllnZ09nTWNaRDBJU0pzMDZJSGhGQjRhMlJ4MVI0Q1ZwN081TUlr?=
 =?utf-8?B?NXBwcUhEalJmdHpLeHc0akpOQjIxeDZYQ0dvVEJJWm5QQzFweHBuWDVFVXpu?=
 =?utf-8?Q?6WRyD8Zi7yGdqlnBoicfaZPrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef8be2-2f46-469c-a913-08daa23ebb1f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 17:19:13.9151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coAo/X6Omv1MPQZw1b4YrVMMwMoPtcQt7qC7+Txdp5jeR8W/6Nd03KQWWe3ccwM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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

--------------FnSGBOL0a8eSZYmad0DIFwJv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by:JamesZhu<James.Zhu@amd.com>fortheseries.

On 2022-09-29 12:50 p.m., Sonny Jiang wrote:
> Enable VCN DPG on GC11_0_1
>
> Signed-off-by: Sonny Jiang<sonny.jiang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 5f0d6983714a..16b757664a35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -629,6 +629,7 @@ static int soc21_common_early_init(void *handle)
>   			AMD_CG_SUPPORT_JPEG_MGCG;
>   		adev->pg_flags =
>   			AMD_PG_SUPPORT_GFX_PG |
> +			AMD_PG_SUPPORT_VCN_DPG |
>   			AMD_PG_SUPPORT_JPEG;
>   		adev->external_rev_id = adev->rev_id + 0x1;
>   		break;
--------------FnSGBOL0a8eSZYmad0DIFwJv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a><span style=" color:#c0c0c0;"> </span><span style=" color:#ff9d04;">for</span><span style=" color:#c0c0c0;"> </span>the<span style=" color:#c0c0c0;"> </span>series.<span style=" color:#c0c0c0;"> </span></pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2022-09-29 12:50 p.m., Sonny Jiang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220929165023.103134-1-sonny.jiang@amd.com">
      <pre class="moz-quote-pre" wrap="">Enable VCN DPG on GC11_0_1

Signed-off-by: Sonny Jiang <a class="moz-txt-link-rfc2396E" href="mailto:sonny.jiang@amd.com">&lt;sonny.jiang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 5f0d6983714a..16b757664a35 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -629,6 +629,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev-&gt;pg_flags =
 			AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev-&gt;external_rev_id = adev-&gt;rev_id + 0x1;
 		break;
</pre>
    </blockquote>
  </body>
</html>

--------------FnSGBOL0a8eSZYmad0DIFwJv--
