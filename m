Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0552FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 04:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E8410E14D;
	Tue, 15 Feb 2022 04:05:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2245410E14D
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 04:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEN0TP9kY8jZADD5G44BEou9fH4gtsSIUjg11Wl6uueRPLesRgxKvVllrrhoB4OqbpZQl2KnsqdmurxQRqMPPyovFhfjjNGPzJ6qhpY5izAggT90zI8GnwObDhw9CB4qDCce81YEUFtIgH6ByYh28+JAnGBoKVatA0gKZTbq5ZsirXdMCsMj8r0ZniYJSqrrF9+SRHjuIMDkO3OOyyPFulaxX+yqtq0vIi9hEtQ65HFakcpTRUXh0i3msD+0PhaDTrD4sm2O5vGX9SaIxI0pmuYNyUVtM+zO6oWs5Kq5TksDozeqwv9cZIDK5BO/4PVLBLbdPEW59EUrsJHcOBM2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5TlQLTjV6hUGUzCSa2MRhCHS2R6jdEJ9NPJDpeO/0M=;
 b=XnPh/4jHXfWCalykAu9sodQXX48IZK24XYiODw8ECdu+3lkQwOabrxLsO3K2m08X5XgXbMxYaPFPU0x9ktEA87GbI1OMXF1Cn6j3qJpevUfLXFilFD4CiYr1VuQqEJMOKNDGIHpwQn1X3rCLrKAt3AXXNJ2vS36p7GwsntZ/vd67tiXVRBQsDUBu+/xDKEsS9iJx8P9BYGKQpYdJ4XowXaAJIkEarz+b9d1Lv6FSmEF3jDW5ZpWnqq7pKh5Wwlab6YPChAaSVHFPmgvgr871JpWRn26kZgwdiR26Cq0R+MK6gL/MOPEtRTRbVVkdk1l2P6cD47z+qQfEHJYBQtrEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5TlQLTjV6hUGUzCSa2MRhCHS2R6jdEJ9NPJDpeO/0M=;
 b=mx6eWswUqPSRUh1RPJHcb4srz6XcvjVtBnc5wiNLTwfJ3JEToY72t/L6DlYWoOzCwtwBq/dUmLViVNitZCYDhvJZug+EsIvl+rPFRYhQaScFrjC7veqp4gtaP5JGk3dJalOfwfdiCnJDoc23HbWVOimCSzckIjYwfXKzwGHk6lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 04:05:45 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::d169:60e:5534:9be5]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::d169:60e:5534:9be5%3]) with mapi id 15.20.4975.017; Tue, 15 Feb 2022
 04:05:45 +0000
Content-Type: multipart/alternative;
 boundary="------------iWlcJ67l1NE0tqr0cSebrcw0"
Message-ID: <739d0c7a-3da3-503b-e806-21cb930ba2c4@amd.com>
Date: Tue, 15 Feb 2022 12:05:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amd/pm: enable pm sysfs write for one VF mode
Content-Language: en-US
To: Yiqing Yao <yiqing.yao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124100122.1634569-1-yiqing.yao@amd.com>
From: "Yao, Yiqing(James)" <yiqinyao@amd.com>
In-Reply-To: <20220124100122.1634569-1-yiqing.yao@amd.com>
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To MN2PR12MB2975.namprd12.prod.outlook.com
 (2603:10b6:208:ce::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b811f5c-0a56-4e7f-e2c2-08d9f0387084
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4338D3C789AE4FD3D557F06D85349@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIJ7Mph/XIxvFMu14ZwhiU0z8hPlKqKa0HZ2ob7JI0RfBtKmNv6paW2lSd/8nwBD0Yq0Qhd785qnu6uOFA9UK5xwySoxp0fHYnQ4TUj8SOC7VNFEJBu8Zzy4hgrCZRdTGNRNNRTwXGJ8+cCVihVEBF0yEUcnRG2AeF217g5u09h/YHc51+PbA65O1RwTZ5e+4B8FNxkOt+lI8Mle90bzENWMRyRi0qGhGpvc7o0I1HmcTpnMO0qxfYRwNW9Tr+tQ2XhWpxyiR+623kSgAGO2/BwwoCiybY5Mkoifd2Htt5mJFaPE9lp/J763IePCL3+YBKSv/GTD75gwIR5mpjyuyY6WfUXCOsmaDoIgbQKvNmgv1awXS4b2mYvxQAYQNxEXZ8dfjGtZVnHFGQQsIUqIrzYvcRQF2jz9cHuE19aFM/lPmnN9o62FdlvS4GnXCMBNezKm0PE589LhFNd8JBvDf59aokkSP35V9F4HE5pkdDW33l6Con2ax3Ud2oQPdmVpYUF/NLxEduT/HRz5tJtcDkY29FUwMuG0dK1/t5D+Lq+pGfixzUuiPFhiKFRNolZNYiJIr8CFvS/wO5D7rDLmAKHY7RxL9wUXLcRMtbCqgY/60/j5IY87f/azOU/fhu6pbOvMprH/kSDK4Vv5kURtR/P1ieqcZUeMKqYe7PHI0Cp/7KMT/J9YCzGsopc1kB5zBcI2WB9Z3x1xgG8vLMgE8vjrT0JNKCS5prTyvi0G0Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2975.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2616005)(186003)(31686004)(26005)(2906002)(36756003)(6506007)(8936002)(6666004)(316002)(66476007)(4326008)(66556008)(8676002)(66946007)(31696002)(508600001)(6486002)(53546011)(6512007)(83380400001)(33964004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkllRFc3VFE4SU91U0ZpY1o0aWk5LzRuSklzRHhjZzZQOUM3eVFkS3lKY292?=
 =?utf-8?B?Rld4Z080OGg2Q1NpV2JRb0J6Wlk3OFZOWndpVGlRdzhDUDkzTlhzcXFHNG1H?=
 =?utf-8?B?cXpHYnNSMHZnTGVyRGZmZkZQbGNqZGl0U05zL3BldDM3SThsTWNkS0ZCdllQ?=
 =?utf-8?B?N24ybzh4MVQ2K20rc1ZKaU5CYUJPQ3JOakVqMXZ2b1JtY2NWQTZCZTd6VlZM?=
 =?utf-8?B?WEZYejA3Q0tybkN0UVduQUVHaEpZd1ViZGkzWkFPekVUN3g3R2hDMkdyUVVv?=
 =?utf-8?B?NUJqcXBLa0g3TVVBSTdGR3pSUUlYazhkYUZ6bnN4ZDlIeVZ6V09CQzdoSFdZ?=
 =?utf-8?B?UHpSYjJCZzA1aGlKZjZRZ0puRG1rNUVrb3pXN2VKZTNRMnVFd0tSRmRSbExF?=
 =?utf-8?B?ZThPeHZ0YXl4M0xxMFlMSDhYY3VuSXl3d0pOV2p4SDdvTGFaYzA1QWdrYVg4?=
 =?utf-8?B?cmNPTnlJZWppd2ZvbFc3VFM4MUhGUGhJaldhQmJ2KzlKYk55MjRId2E4RjEz?=
 =?utf-8?B?czBrVlVucUwvdWVTbWwxUnZGeGo5T05uV05VVDhVTUdPbEFEaXhmbm9uRnZm?=
 =?utf-8?B?TDdWRzA5bzVOdEFZSTNxaTZrWVdvY2huaEtsTk5QcUZ3ZlJuc0FoZ3dRU1ZC?=
 =?utf-8?B?aE5mQ1hlN3NMcGxWYlRlaEtXaWpoZnJoRjlwOVZnRElYYnd5d2VkMGxiV0JH?=
 =?utf-8?B?T2tIUDBMK0pPaGU5Q0s2RFNIWWJXRVh2VmFFMElqUDJZTCs2OXhMVU1YRHdW?=
 =?utf-8?B?YjVQNUs5YmswaXpvaW0ya2JWRmJ3Tyt4NGtWS3RkeUIxVWxZMXB0b1JKYnFo?=
 =?utf-8?B?UXEvbmpsbm5RNndBNFdyWVZMYTVvakxtZ3VxQm1ZTGY4bkJmajYvZjBjMTR6?=
 =?utf-8?B?OTdEcktYcFVvN1FhN3NjT0xnbXBzdUd5SXRrQUFodFlkbzFxWFYrenlZSXB4?=
 =?utf-8?B?ZGhKaDM4WktPdUk5bXFqazFBMVovNEc4NjBGRjFUZFVlNGdNRHVjV241Qkwz?=
 =?utf-8?B?K3c4c2pmQ0xHb2xpUG84dWM2emtTVEd6bHJreFZvLy9DVXUreTFmc2R4SDlB?=
 =?utf-8?B?cFZDenVOOHhPMkNnMG51UXA3UjJENWRnNVVLU1QxOUZaRGxDYmFYdGFFL0N2?=
 =?utf-8?B?MUVtdFhtRy9TZkJpc09VcmhRblJMMTVwNVhaNU1aRkdrVmZIYzdaOVFJSzZm?=
 =?utf-8?B?d2tzNFg2T3E0Ty96QUZvOUUzNmYyYWplMDhhbG4wNTFZYVJvL3RKL3M0dFBD?=
 =?utf-8?B?NGdLeWJFUFVQYU5vYTJnd3ZYaFRSUzMxVDFkSjdjeCtRUHhoODltWXJIdndo?=
 =?utf-8?B?SFJRVnhURU13STdWTk45ZWtvMHNkbXlQRFVINHlXZXRhV3ZpRjR0bDlranIv?=
 =?utf-8?B?a081eEZyeU42aFRCZjlkc3VDcStucWV6bzZqbjBBLzVhaXhPWUxzVGZuMjh6?=
 =?utf-8?B?bGFzdXRnYmJSTlcyTklyRENvUG1ZN3RCR0sreUovUmYxOWtrSi8xcjkrVjZE?=
 =?utf-8?B?VGozRWtoUXIxazdWdWR3N29DbFBQTlFncjlrWEhaZCswc1IydnZtdy9Ndkg1?=
 =?utf-8?B?YStIZk5wS1ZGTGZOWVRGRmgzRm8rcjkrUm9jcTJBNGlZSkN3UVJnWkVaRHNp?=
 =?utf-8?B?SExSRTZkZGJnTEJmRWt1TURrNnpTTENZY1MyeWptSFAxODJ5NjB4OFBvN3ps?=
 =?utf-8?B?OHhjYmNZa21ZdlZMVEhLMnU0TFV5YjhGSEMycGlGSEt2bXROMCtRcm9ZL0lm?=
 =?utf-8?B?MHRaWGo1OFRyZW5qQXJaUDVhTTVBaTlPcDhFVUE5Z0ZmTktUbVdBdlp5dzRk?=
 =?utf-8?B?RERiamt2ZjNMaDIzR0R1L0R4bGQ1MzhBWURKRXV6ejBmdnRpOW1iN1h0UzNR?=
 =?utf-8?B?RG5xczJSa1ZhVXJ5WjR1T0Q0ZGVLeFRoVTg2SmFwemlNRndiWGRzKzY4QkZR?=
 =?utf-8?B?YnlRMlNKVE5INlN5bDZiR2ZLNXZ6dElybSt5ZHA4VUZ5bWRWTWppMHhxM1lW?=
 =?utf-8?B?ZGRScnNTblpEcnRmakJYc3drQStFaUhFSXFvWkNjSDdub0hzZFFScXJOV1o3?=
 =?utf-8?B?S00yd2tuSVhGVmFtWHRJdXlEQ2pEQ2gyUjFHTDZmWW0wTnVIMnF3UTk2RzNG?=
 =?utf-8?B?R0RzWEROWVpBTnByV2VBdXZheWR2ZVd4QU5DSmQwLzY3ZzczL3lZeUNoS2U4?=
 =?utf-8?Q?49aVD/r+wl8YZ485ScQzPa4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b811f5c-0a56-4e7f-e2c2-08d9f0387084
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2975.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 04:05:44.9821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3jGQOPVOk926RQx0kkfhjGLmSb+l5CN+6lFdTE+M6/LWOKlSGeJ0aWrKasYHRA0rMLCK0W5Twl7tfinyM/nag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
Cc: Monk.liu@amd.com, marina.nikolic@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------iWlcJ67l1NE0tqr0cSebrcw0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/2022 10:54 AM, Liu, Monk wrote:

> [AMD Official Use Only]
>
> Reviewed-by: Monk.liu@amd.com
>
> Thanks
>
> -------------------------------------------------------------------
>
> Monk Liu | Cloud GPU & Virtualization Solution | AMD
>

On 1/24/2022 6:01 PM, Yiqing Yao wrote:
> [why]
> pm sysfs should be writable in one VF mode as is in passthrough
>
> [how]
> do not remove write access on pm sysfs if device is in one VF mode
>
> Fixes: 4436ea3c43a7 ("amdgpu/pm: Make sysfs pm attributes as read-only for VFs")
> Signed-off-by: Yiqing Yao<yiqing.yao@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 837a31a46596..5250032a2ffb 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2006,8 +2006,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   		}
>   	}
>   
> -	/* setting should not be allowed from VF */
> -	if (amdgpu_sriov_vf(adev)) {
> +	/* setting should not be allowed from VF if not in one VF mode */
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
>   		dev_attr->attr.mode &= ~S_IWUGO;
>   		dev_attr->store = NULL;
>   	}
--------------iWlcJ67l1NE0tqr0cSebrcw0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <p>On 2/14/2022 10:54 AM, Liu, Monk wrote:
      <blockquote type="cite">
        
        <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
        <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
        <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}@font-face
	{font-family:"\@MS PGothic";}@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}@font-face
	{font-family:"\@Microsoft YaHei";}@font-face
	{font-family:-apple-system;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.xxmsonormal, li.xxmsonormal, div.xxmsonormal
	{mso-style-name:x_x_msonormal;
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}p.xxxmsonormal, li.xxxmsonormal, div.xxxmsonormal
	{mso-style-name:x_x_xmsonormal;
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}p.xxxmsipheadera4477989, li.xxxmsipheadera4477989, div.xxxmsipheadera4477989
	{mso-style-name:x_x_xmsipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:JA;}span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
        <div class="WordSection1">
          <p class="msipheadera4477989" style="margin:0cm"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only]</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;MS
              PGothic&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal">Reviewed-by: <a href="mailto:Monk.liu@amd" class="moz-txt-link-freetext">Monk.liu@amd</a>.com<o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div>
            <p class="MsoNormal">Thanks <o:p></o:p></p>
            <p class="MsoNormal">-------------------------------------------------------------------<o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:10.0pt">Monk Liu
                | <span style="color:red">
                  C</span>loud GPU &amp; <span style="color:red">V</span>irtualization
                <span style="color:red">
                  S</span>olution | AMD<o:p></o:p></span></p>
            <o:p></o:p>
          </div>
          <o:p></o:p>
          <div>
            <div>
              <div>
                <div>
                  <div>
                    <div>
                      <div>
                        <div>
                          <div>
                            <div>
                              <div>
                                <div>
                                  <div>
                                    <div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </blockquote>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/24/2022 6:01 PM, Yiqing Yao wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220124100122.1634569-1-yiqing.yao@amd.com">
      <pre class="moz-quote-pre" wrap="">[why]
pm sysfs should be writable in one VF mode as is in passthrough

[how]
do not remove write access on pm sysfs if device is in one VF mode

Fixes: 4436ea3c43a7 (&quot;amdgpu/pm: Make sysfs pm attributes as read-only for VFs&quot;)
Signed-off-by: Yiqing Yao <a class="moz-txt-link-rfc2396E" href="mailto:yiqing.yao@amd.com">&lt;yiqing.yao@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 837a31a46596..5250032a2ffb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2006,8 +2006,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
-	/* setting should not be allowed from VF */
-	if (amdgpu_sriov_vf(adev)) {
+	/* setting should not be allowed from VF if not in one VF mode */
+	if (amdgpu_sriov_vf(adev) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev)) {
 		dev_attr-&gt;attr.mode &amp;= ~S_IWUGO;
 		dev_attr-&gt;store = NULL;
 	}
</pre>
    </blockquote>
  </body>
</html>

--------------iWlcJ67l1NE0tqr0cSebrcw0--
