Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BA4C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 14:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F19E10E39A;
	Mon, 21 Sep 2026 14:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQUF5Rqe";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D4D10E39A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARiKr27iBxHoOWYa6OXnRZOiCOhZC1XquxToM29TEna0TtMxwH2ByUYGSm3MZjj8V9F4KIgLP5il7mdj8sucije5Yt71JM8bAwmM8bKkx637EAE3HG6czSCjKccM9Ys9aDwYU6GTp0hurEi6RT5o4qE3h+ErAdM251cBUhrzern3slQtnMYm3elzyAvRhAOPGmQWMFT4wd/l1i+cq5wSU6pzQTd3A05HTopV9NR38pTQc4P8DbkXJcL9/BqoMAlwnhWJ/tmEnL3PBG5DdF+isIE3vpXTJ0UWdih6c29Om6DKDKVmbF7VVEVE9dq5ZSvg3+VkKKvTAHLkAyt6Iqcn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgvwMB+0YUGyd0h5eYBpuzaMbWmo9KysghCEPIbAq8Q=;
 b=jkKNLfPyLDX66EL+oNFMhMXfNM2jjX9gONhSD6kmimqCjqiMHtrvq/wK3W89q0ga5lf8opRwZZL8g5ma9x83kq+eirFkvB80PbKv+OEcLpGw1IBe4r96AlvAZnl7NzjTTrQCqyXb133tuXIO5RSxlRj9hwO61mI2TrUIjmKn9MHRa3zrc4twkl/amz74kuic5j+u/QH5Ef+T4ciKS1ZhqHW+jpvPbrUA8zLDd8hFTFkkgKvWDLqsWQDyhPjeEzMV+Hw9HnwqRMGu7zJ2P0dGuHGvfCf5b7cUHOVHaHFUi6Rs8Bj7FuR2VuYLP8Jp6NEc0WpS9StW7om5l40ZKBTaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgvwMB+0YUGyd0h5eYBpuzaMbWmo9KysghCEPIbAq8Q=;
 b=FQUF5RqeEQZRKI6MLf7CIv+puvH89dbmgXc81ITZ/RBIWO60yKkpJ3I+HlN+Ty9Pbqpf3mmCE0j80uEtvULBUCjndm6SQh5w0IVh/kHXsrlfkfe/2omPjElwMUY7Q1N3nZmIC2Xd8kdFO4SEplx3OSAB8UwiDXjsHffvKNDDStg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 14:15:48 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 14:15:46 +0000
Content-Type: multipart/alternative;
 boundary="------------HxZLbcoaHfwtDy9Vbri5BNMs"
Message-ID: <d31a471f-3d50-447d-aed6-ec1d24a0ecaa@amd.com>
Date: Mon, 21 Sep 2026 19:45:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: reserve the VM root BO around CWSR
 param validation
To: "Lazar, Lijo" <lijo.lazar@amd.com>, James Zhu <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, jamesz@amd.com
References: <20260918200444.450067-1-James.Zhu@amd.com>
 <20260921134538.3673161-1-James.Zhu@amd.com>
 <f76638fa-3697-42ac-ac4b-fb3034e85bed@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <f76638fa-3697-42ac-ac4b-fb3034e85bed@amd.com>
X-ClientProxiedBy: MA5PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::7) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 956d1062-4963-4723-0d59-08df17ead437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|8096899003|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: InSLTvwdsdT/ROuPQtF1atM69ZuuQnikwiIhTIfmOv+sY2zRwg6MH0SFHZPqpNzw8rEsR6yxXikxeSslVIQPSROFD3ShClT/+GyuPz7KjfuAvHIBlqFyOQsCzmAZbmYvxO8GGYtUzyGfgisY2+tVdukKf1VBLPZsQ3GgnCmr3pQqqqTe4Vtnj4zqWNHWmTumjZ/VPrHpVq9IhKQMW3WvDhTp4u4Mn+T+LYh/zIUQRPmlzzeXEI8e0mPTvI52Z/0kEn/5ManPOzRS2CBv/nsChZ4fopWKCFlbO0KSQnAuG2Uivkn21K0LPZjxrwZCogsPGTOz2LTYluraD39uX5Bl/2Wc4PwBjhNym82NNgR7TWv1Z3YgavBNkeFrm4NJA44ASvd/26/8xtNO3A9pgMbs56owAKa3/jPow/Fg5MRy5VQBWNANVPdx/vmDR3j1V7PN59SrhvjiYEscO0Il2RQTBSL445oqbAoWpFgRT5NelYE0BfwqUAY6xO53wfoo+4Qp+AKgC/fwjYT2w4+oz/8K6FTXKAmMzfzBxd/9uhgGliaVhp/WIGOAeodHfcxTymoNoq1neUME3GJ+7qi5tQeJhmDIsy0KQ53EjhehCqUSXz6rfUxoCxrubt+OCpJJiEhXbc9OUAzhoS7YhjaWgMT+MoIlJe47T1izenWyy9ykatc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(8096899003)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTlabDJVbElzUGRQeWpNVVNZa28zUkF6dnJzMFlUMFZYbVByajdHeUxlLzlv?=
 =?utf-8?B?Q3R0dExsNTdFbnk4THAwQkg5cHRlWi9ySkxEcGxlbC9jakZKbjJwaFd5NG5s?=
 =?utf-8?B?SVVxRko0VzRwblVDQXZlQnAreWJwQTBpWmRqdGZMaUgrWnZRMGZvWTZQMzhI?=
 =?utf-8?B?RG9CdjNQSHNVM2E0ZGhvNW5tN2F4YTZzVW5sZHIyTHl4WmxDa1pNWFFnbHFD?=
 =?utf-8?B?dDUzQ3NZd2VJVWhJU0pjeFpsNjBqblhxTDB0UFp2SlVDbHY0MHg1MWF6eWZG?=
 =?utf-8?B?V1Ziblh6VktwZldwaGlVMFVTUDd6WVdQRVQyTGpBbmFXWG9FSW5XZ0ZINU81?=
 =?utf-8?B?cnBxR2JGQ2JENnB3VS94OU5zV3hxVGx2NEhESm9mazVqMlQ3OFM2OGxiUEI1?=
 =?utf-8?B?VnRLeXRtUHExemZHU2ZySW1xQzVMbjgxOVcvVUFRaE83Rnk4TmxaMTNZV3JK?=
 =?utf-8?B?SUZEcGdVM1FaR3VVT3dRMFI2RVJGOFpDRnlaakg5eFliZmFvRDRmZWtmWXB6?=
 =?utf-8?B?QWtLcEFmUG9Kci9uYWNUNFF0WERPSCsvMlhrKytOQXJYOG5qakFWMzV2MmFj?=
 =?utf-8?B?ZXBVRE8zNzFaaTJTdzNlRE13U0dxT09sb3RhcEZKdndXdGRvbTJRVE9mOWFp?=
 =?utf-8?B?N1FUM0x4dzhlQi9HN2cwOGdldTJJMzltUlEvc3BlNUJSb1dNZXF6TU82cWgx?=
 =?utf-8?B?cXpBNCt6Vy9pN2lBSm1ZWXQzQjd0L09IMFc2ZE5rSWNBV2hXRXFrWm5UU1lz?=
 =?utf-8?B?ZE9GdUFJbEpCOTNlSms5Vlc2b2ZoUXlndE80a0NJNTVkK2RxNHlhbEVnOTdF?=
 =?utf-8?B?TGJyT211bUI2U0tUVXA5T1hrYzhOSWkwT0I3S2VvL0RIdExyVGJQMnVEODBl?=
 =?utf-8?B?aVVXZUx1UUNlV216Y3VLR2FKQVM0cHBSempIZkw5Y2p1a3dHY21UOFZ4TXJM?=
 =?utf-8?B?VzdDaUZOQjFyV29CYi85QXM5M01mNU1vdnAwdkV4V2NCK05NbGNoWkU5S1M4?=
 =?utf-8?B?d2xuVllqenRaMzBKeFdzUUo1OEp3bjZhNjdDbk1EZVRXL1JodVZHbVRvQlVG?=
 =?utf-8?B?TW8rZkNRUlNXcTVmT2VTWjNXenJpTys5akM5WTY1dUY1cUxYMFBwS0pXVzdp?=
 =?utf-8?B?cDZ0MGQzRWVyV1BHUmgycmVySThacmM4UmFRMmJyQ1VVby9BRS9SN0FpSS81?=
 =?utf-8?B?YUJMcFRBNnJadWJUb2YwY1N4SlFpeFQrTXo2dE1PRlViaDEzTGplUlFDbktD?=
 =?utf-8?B?eGxwbTlrQVQyV1RpVUxLZ1prQnhvS2FUM0FaRjBUR2psVXp6cTRoY05aTnpQ?=
 =?utf-8?B?bWhROGx5Q0JwUythZEFLdU5PaUpYbGhxOXBHRXdQeURxbGM5U3pEWVhjUDRq?=
 =?utf-8?B?K05TVXNtMCtISjBBVjRkdHFvWHBrNVdlVll3NVVRNFEvZGZDdURGbm1venZt?=
 =?utf-8?B?bXhnT3N5UlJndUxQdjhTblhTUmlnUllyaEhLSWVTMnNmeUd0ZjJVQVJoSzc4?=
 =?utf-8?B?SHVhNmU1MGlBaExobGRiVkt5ZUp2UjdLdTUrOG9FdmJ3cjlWZEg3UkhtcFBD?=
 =?utf-8?B?bWlDWHVLSGVYU21xaExuNWRiOTNOTkp3dTMvUWRpckdzMEh1RXAyMXQvNTJC?=
 =?utf-8?B?UEpVc2VVeXVOZGszbVBlVDN3YTRhMVJJZlUwcHhrZ1Y2L1BUSDNiS0ZYTGMw?=
 =?utf-8?B?QjVGUm9MbGdKRWRsTmdKQTZkdGlEeFFEK3B6SlBWY1kwUGhQQ01QYzZ2MzR4?=
 =?utf-8?B?UVo1MGlTLzBBTU9hbFBnQXlvem5ZZ3VSb3I2RkpkNUIwN0RwQ1FrMUl6SU1Z?=
 =?utf-8?B?TjFUYmt0RExqaWhFaWNhZFdxOE1kV1dqZFFpQVFDamRSY3ZlemNwSHFCM3Fr?=
 =?utf-8?B?KzN2VkNIbnRXMEhVVXBCNUxPWEZaVkJKcXZ6Y2NNZ0RmMWc4NXlGL0UwOVFB?=
 =?utf-8?B?dkJnYXdWZWFIanB5UVlqTkpySUlPaGQxUlIwdDMyRHVmbEw1WGhjYjM0RFBG?=
 =?utf-8?B?dW9qVzFtL1g2WUdhbDJpRE9mWTU0R3pDbGZOcHpKWWhibzBxUTltUEZYWDNm?=
 =?utf-8?B?Wlh3TE92N284ZlY4Y2JJKytGSlZLaDE1SjVzWWVIV0FIeGsyemhEcWVOWTBr?=
 =?utf-8?B?TVY5eExmVVk5YmFCVk1rVTBSVktTcEFUSDhrcGRuRkJ3SE9FWG5CUEpqaUsz?=
 =?utf-8?B?Tm1pZW5yK1diR2tROXYwWTZlYWREcWxINktHY2FGQ3U3cm1vaVBqeUVrc25w?=
 =?utf-8?B?U1BYMCtsVG5lZjlkSTBGc0k0Nkx4bFA0Wmt0MS9YSVNPZGdIcFR5QzZCcjBV?=
 =?utf-8?Q?DCEuNffZG8K6YkaN4K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956d1062-4963-4723-0d59-08df17ead437
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 14:15:46.2425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYyuet+IQRQ241PCrs21bxjV+sb/UivrxTT0VvAQSka5sQDbFC7asJVlIOoAAkz37NyzGVzkRmk81ZOSXVSZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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

--------------HxZLbcoaHfwtDy9Vbri5BNMs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/21/2026 7:29 PM, Lazar, Lijo wrote:
>
>
> On 21-Sep-26 7:15 PM, James Zhu wrote:
>> amdgpu_userq_input_trap_params_validate() ends up in
>> amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
>> updates bo_va->userq_va_mapped, so it requires the caller to hold the
>> vm->root.bo reservation. The CWSR branch of mes_userq_mqd_create() 
>> called
>> it without that reservation, tripping the dma_resv_assert_held() on 
>> every
>> compute queue creation when trap handling is enabled:
>>
>>   WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
>>   amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
>>   Call Trace:
>>    mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
>>    amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
>>    drm_ioctl_kernel+0xb3/0x110 [drm]
>>
>> Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
>> other input VA validations in the same function.
>>
>> Fixes: 7ca9abf4ac38 ("drm/amdgpu: Add user save area params to mqd 
>> input")
>>
>
> Hi Alex/Srini,
>
> Which branch are these patches based on? I don't see any cwsr patch 
> upstream yet, probably that makes Fixes irrelevant.

These patches are based on |<exact-branch-name>| from the 
unified-interface tree, not upstream drm-next. The CWSR/userq changes 
are already present in that branch.

Thanks, Srini

--------------HxZLbcoaHfwtDy9Vbri5BNMs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/21/2026 7:29 PM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:f76638fa-3697-42ac-ac4b-fb3034e85bed@amd.com">
      <br>
      <br>
      On 21-Sep-26 7:15 PM, James Zhu wrote:
      <br>
      <blockquote type="cite">amdgpu_userq_input_trap_params_validate()
        ends up in
        <br>
        amdgpu_userq_input_va_validate(), which walks the VM mapping
        tree and
        <br>
        updates bo_va-&gt;userq_va_mapped, so it requires the caller to
        hold the
        <br>
        vm-&gt;root.bo reservation. The CWSR branch of
        mes_userq_mqd_create() called
        <br>
        it without that reservation, tripping the dma_resv_assert_held()
        on every
        <br>
        compute queue creation when trap handling is enabled:
        <br>
        <br>
        &nbsp; WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
        <br>
        &nbsp; amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
        <br>
        &nbsp; Call Trace:
        <br>
        &nbsp;&nbsp; mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
        <br>
        &nbsp;&nbsp; amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
        <br>
        &nbsp;&nbsp; drm_ioctl_kernel+0xb3/0x110 [drm]
        <br>
        <br>
        Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve()
        like the
        <br>
        other input VA validations in the same function.
        <br>
        <br>
        Fixes: 7ca9abf4ac38 (&quot;drm/amdgpu: Add user save area params to
        mqd input&quot;)
        <br>
        <br>
      </blockquote>
      <br>
      Hi Alex/Srini,
      <br>
      <br>
      Which branch are these patches based on? I don't see any cwsr
      patch upstream yet, probably that makes Fixes irrelevant.
      <br>
    </blockquote>
    <p>
      <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">These
        patches are based on <code>&lt;exact-branch-name&gt;</code>
        from the unified-interface tree, not upstream drm-next. The
        CWSR/userq changes are already present in that branch.</div>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px"><br>
      </div>
      <div style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">Thanks,
        Srini</div>
      <br>
    </p>
  </body>
</html>

--------------HxZLbcoaHfwtDy9Vbri5BNMs--
