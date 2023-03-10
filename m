Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5641C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 06:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B6610E960;
	Fri, 10 Mar 2023 06:50:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0043D10E960
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 06:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofl74v062pYmiQH7PF8HkwKFP5aetpFCoFKA+ZG7inu/++VLVMX523J3hL881kAJHGIXs71grqw2xFMuw8mTS0rLZzHppJRPEfzlQ99M1OVSbX6sERoiUhuRHJMCUqSFQT0iAzjv+SWaFHMRuS4KuRTqQNdndMePzy5h/RVdprfb//P7BcyLwp0QMUg1MNW2VyA0IMJrhcHG0cyZoq3UGRvwgvH/HPfmhJnc/IbzqRM54gSE0zFuOaLWH29whzMy7fwux0a4auz1Y1d2sxY2D06IBISyixGam6hLbWYpk/SOQ4rC49HdwLuFGBtCIX0yf5I4kNPDOtZIBmrLc5ixwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHSRYqslk7qYHvgeOMWLdLpD6/tKbKLaZ+yviP6xRHY=;
 b=m6NncXO75KyC1WlID1OhY0M9jsCYP1Irf3NbQoedv8dPgeBfFGpcGirLpOIDiTytaVJJGWAWbA4A9B3AZFJ5FKrXQGK+XIQ13tKkDoC31ybJqi/Cp+Wm4S/Sy0pWBimsQ9hRq+Y88/02bpXMnk0CUxPWQBknVgezS1ccIWIFD3nkwUdgkYD1E64OEVAXovr1/4Ut2w4aB5fiDKalW6IqrpfrkFaqgkFm6EK56U/MskA7csHsxY7T4sTwPU4dl3QoDAW70h1kt1b+AxowHjLzQYL0fSSu8OUX9ok2fv8KBTS5uKwFTco6LGc760iqX08R8WdGmZFgB3NPWxmEc4g2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHSRYqslk7qYHvgeOMWLdLpD6/tKbKLaZ+yviP6xRHY=;
 b=0mZkRg7Q9Pm1HC+ChWQA8iIjoSZi370Fpl842ZXAPmpIWJSEa4USmX7eIqStp+v6eAZ+HfWvIANUF0qZa4Y30hLmaIaJS4QuMtsx7M6GuSpt8/z5W/pVc9iP9yf226Zj0s/hbmprWISfORQS1xWXMbjKuhaUFnCMF6EhY1Nsekg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:50:18 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7803:31cb:36cb:b2bb]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7803:31cb:36cb:b2bb%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 06:50:18 +0000
Message-ID: <5dca6022-9581-9aaf-4adb-33a8ca1453e3@amd.com>
Date: Fri, 10 Mar 2023 12:20:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] amd/display/debugfs: add sysfs entry to read PSR
 residency from firmware
Content-Language: en-US
From: "S, Shirish" <sshankar@amd.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Shirish S <shirish.s@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20230308071035.98892-1-shirish.s@amd.com>
 <bb743d26-edd3-d60e-96a7-95b70dcb72f2@amd.com>
 <77cbac84-77fd-ae86-dbdb-cecbcdc5e384@amd.com>
In-Reply-To: <77cbac84-77fd-ae86-dbdb-cecbcdc5e384@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::29) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: ee262c33-9f19-4448-c853-08db2133b56a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FT96zKQgjk2nWIMmrYnS0DS8lkppO0j+R7gSgvS4+f9VoapapTXIi3YZFacryZxdQ6jG/q2CjrHjLhCGfv5/vF56W/y1L+k6+lS5T+D7O40V6/rVP5jXlhyU5JC9Rb3ZEQqVpEogY8YmBwimHgh/LrDRrQ2BhYMZMpOffuF+V28jMCooBz+Gq3eRxZHJP0+WY+g+LA3DUGqXkvqPs2jYDOYkcmaZA/sMQD51K4BvhlTp6GWch7i0wSSWMdpuqPuJj5mlagVyM7uSVs3NPU3bO3rVB7CPDUm0SEL8R78t+Yv9UABXu7ZU0Ny1kckMaSbtyZMPyw4KmLzbY/lbmP0Hn6VNKHJbzQ1xmEga1k+5m2vApBqxjrtGWfvte6m/nCEbnVShUry/0gJ5Pyk83SjcaywugIYjN6VsHVeuGjb6qX+AIPE0yKAOvKjwdTo87rzBwaiD4h/6WcEhPynMLc8XK6SYb2qqcx2PzWvWrxH/B0V1tsf0iYestPcAiKCgywop7qllWktz3LTQHwWdEvQX8lujQ6uA8YCle68DowGqP0ONJJ3001jFEa868OyoHET5Q/+PmgC+Oh0SI/B0fw7W8jZrGhUt2bCqF6KuEcFKaWlpdhHku/C23DnKpkvkLwm2h/UHjnXd7+WjEARGMZduFoyjMGrKYtW6qvEOwOO8nlygrsQuE1Drx4wJG9Po6iI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199018)(6486002)(186003)(966005)(36756003)(31696002)(6636002)(316002)(110136005)(38100700002)(31686004)(6512007)(6506007)(83380400001)(26005)(53546011)(2616005)(6666004)(66556008)(66476007)(2906002)(5660300002)(41300700001)(478600001)(8936002)(8676002)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FEVEhxcjg3cGR4UnFVVWRVZUNsSVBJcW50UkYraE1zbXVuTjYzRjd0WEh2?=
 =?utf-8?B?cDR0bHBhZVhBOUNVcG5IbkwzTlBKWTJBcmxxN3VpREF0bEN4R0gyZ2NtVUNm?=
 =?utf-8?B?YVFQdmZpS3laNUxDQm9jbTVGRVlWbGdVMndGWENHb0hDZUNNMFBQb09VUmk3?=
 =?utf-8?B?bi9UZjNSVTZ5TXNSRGdsN2JHRVZ0TEFvVGNUYjRmYUw2ZVdEZTd2bkVsRGQ0?=
 =?utf-8?B?aTdSYWpZbUJwVURtMkFBRXZjbHZ5Yk91dytDcnZKRHF3aHRPNFFTZFc1RFRr?=
 =?utf-8?B?emJlc3hDOGNZeUtRZlhCMXpJeUFncFBPcDR1SHFHMmxMbkpoSjlNU3RPS0dT?=
 =?utf-8?B?SlB2RmNzVmd6RURwMUNlWFpEenk5eEdlY0tvczBrUnVjWE44QVp2eHhndGla?=
 =?utf-8?B?VzhOQTZYRTkyZjJpVVp2RUdNS0pwWXhGRDFQZmJsL2kwZGZ2Z2QzTVQrZDUw?=
 =?utf-8?B?M2NGMUdXQzVhQkdSZDFmYi9POGFoM1NNQlhlNE1ZNEFjVytPNkZOVlJpNjg4?=
 =?utf-8?B?cVkyMmZQQlVBcVRNL3BYVS95WllwZjRNTUR6Qy9rZEJkdmlvWE4xNGQ0TXRk?=
 =?utf-8?B?eHpFR216K1hyY1ZialpuMmpBYS9yNjV4ZkdYcFM3VHdwN1FNd2w1VUxmTlJR?=
 =?utf-8?B?M21kMGFrYUtZZHJXVzluczk1NnJRREVQbzY1cFp6Zys0eUhIYm5weXNpdHRC?=
 =?utf-8?B?clV6YlFrT3JHVzhmUWErdGZQN2dSbjZXWmtqZnhlQ1o3NmhyRVI5amVSWVEy?=
 =?utf-8?B?WVJ5ZmliN2VvODY3QlJkOVZUV0FzUnZteDlXMFlkNDRSN3llRTdxcmovZkx2?=
 =?utf-8?B?QkpTY05yWGh0VnowWndSWHhUZkYvT2Z6RXBFOGMyd0pJc2p3cDNwNmxuWTBp?=
 =?utf-8?B?WGV4Ykw2bU5CamdqNy8rdENCVHdtejU2aEUvN2RmaDVWOHhXMi9kRk85K1Bz?=
 =?utf-8?B?VXBLUzE5NEpmQ29lUy94Kys1TXlKTG13Tk1aQnlBTHRsL0pPek82dk9YQnha?=
 =?utf-8?B?eE1GY2pkQSt4NSs0R2E2aUVHWk9XcUJDNzcwUzdpQmNEUFJNVWE0SlFaTFRU?=
 =?utf-8?B?ZkVWZ0wvK0xXY2NBNWdxanlja29USkFUWHlmN01CUjVuclIxbHlCOXRGTkQx?=
 =?utf-8?B?dFdzTDB0bDU4OEREYi9oZDhjTHpwbTZHSlNkSFFPQ3ZFMEJTeDdOalZ3eWt5?=
 =?utf-8?B?YU5zaDhuMXBYdEtsZTBsekZpRlBBdmNwNjJTOGxJNWRSL0sxd3BTWU53dUY4?=
 =?utf-8?B?U3p2ZmdCb0NrakpqcWE5QndEaWdDcU5HRis5eFozTmcveGpSY2VTeVR6YzNX?=
 =?utf-8?B?Z25sZlpGQm45eUVDZmxLOHdQd3NmMC9DYzNxY3ZWNkNjT3VtbXNaYW4wcVow?=
 =?utf-8?B?VGxnaDFZZm8xTWJzVzBWUlViNHpTNGRBMVNCTWZHcm5DSGUvZ2NTZHZvZXFq?=
 =?utf-8?B?Q0JCSXZDYVdJZ2dFd1RkcC9jSVM0VVdQakFTU1YwdGJXMy9vSlltc3A0cEJa?=
 =?utf-8?B?RWgwR1U5cnUwcVVvNXZJWjRMbXFXYXV0SVBOMFljbTAreE9RaDhVcU9DYlA1?=
 =?utf-8?B?ZGpzZFJFY2dxblVoZWdGUUFUMnUxZzJlZEtJbWpKbFBsS2FyUHNINmZTdDlB?=
 =?utf-8?B?bHJjSG40RFJDSktESE1SMURVNUg0c3B6RnVyNFBvQ0JWMms2ak5XNm5kVTZF?=
 =?utf-8?B?a01mTlpEZ2UyTEkwSTVEb2RUbFhRNEdjUk1vNWw5Z053a0tuRm5TWkJUQnJE?=
 =?utf-8?B?bHhZSFpkbTNVNGE4T0FYMkU1enhjSmVaOHExSGkvSjdWWjF2Yzh0OXR5Myt4?=
 =?utf-8?B?aGNhek9kNjRTRE4zRGpKUFV0MEVOMXNIbmZnRGp2VUE0VjVRN0xPcDAybFY1?=
 =?utf-8?B?Z2V2aVFJSWtWaUYvMkthdkhmeFNWcWd6WU9kaldCZGRZREwwaU9WRXNra2xn?=
 =?utf-8?B?eVM4YlZvQlJ5cHRzSnByV3hNUE9HZFRoam1pb0tOdys2S3pWRjM2U2FnYzlx?=
 =?utf-8?B?MGVEaCt2TUxwSENWaFZtaWJZaXRUK3hhYjZ6UUVHeDVHbmltcWswTW96Y2tv?=
 =?utf-8?B?WU9qT1J4YjFqQnM4d2svaUtnUGRYdGtlQmJRRnpzQ1laQ2ltNmpwTXVwTER4?=
 =?utf-8?Q?QWwS5/oR+BFwe1F/pRMJ/1h+1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee262c33-9f19-4448-c853-08db2133b56a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:50:18.1123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiWnq0zPvPs/QRrpDEg9U4sjcVXYVHQkno/rK+QjTnhgp3M1LDpx86+H5l6/msqbQOM9elYPTquXvrHrgQAO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/10/2023 12:00 PM, S, Shirish wrote:
>
> On 3/8/2023 11:52 PM, Hamza Mahfooz wrote:
>>
>> On 3/8/23 02:10, Shirish S wrote:
>>> [Why]
>>> Currently there aren't any methods to determine PSR state residency.
>>>
>>> [How]
>>> create a sysfs entry for reading residency and internally hook it up
>>> to existing functionality of reading PSR residency from firmware.
>>>
>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>> ---
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 
>>> +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git 
>>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> index abf7895d1608..8ff2802db5b5 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>>> @@ -27,6 +27,7 @@
>>>   #include <linux/uaccess.h>
>>>     #include "dc.h"
>>> +#include "dc_link.h"
>>
>> Please drop this include, the relevant function should already be
>> accessible from dc.h.
>
> Good catch. Removed and respun the patch 
> (https://patchwork.freedesktop.org/patch/526211/)
>
> Pls review.
>
> Regards,
>
> Shirish S

Well, the code structure has been changed now since : "0078c924e733 
drm/amd/display: move eDP panel control logic to link_edp_panel_control"

Now "dc.h" no more includes "link.h".


>>
>>>   #include "amdgpu.h"
>>>   #include "amdgpu_dm.h"
>>>   #include "amdgpu_dm_debugfs.h"
>>> @@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
>>>       return 0;
>>>   }
>>>   +/*
>>> + *  Read PSR state residency
>>> + */
>>> +static int psr_read_residency(void *data, u64 *val)
>>> +{
>>> +    struct amdgpu_dm_connector *connector = data;
>>> +    struct dc_link *link = connector->dc_link;
>>> +    u32 residency;
>>> +
>>> +    dc_link_get_psr_residency(link, &residency);
>>
>> Did you mean to use link_get_psr_residency() here?

Yes, my code was a bit older, have incorporated final changes in new 
patch: https://patchwork.freedesktop.org/patch/526213/

Pls review.

Regards,

Shirish S

>>
>>> +
>>> +    *val = (u64)residency;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * Set dmcub trace event IRQ enable or disable.
>>>    * Usage to enable dmcub trace event IRQ: echo 1 > 
>>> /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
>>> @@ -2828,6 +2845,7 @@ 
>>> DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, 
>>> dmcub_trace_event_state_g
>>>                dmcub_trace_event_state_set, "%llu\n");
>>>     DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
>>> +DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, 
>>> NULL, "%llu\n");
>>>     DEFINE_SHOW_ATTRIBUTE(current_backlight);
>>>   DEFINE_SHOW_ATTRIBUTE(target_backlight);
>>> @@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct 
>>> amdgpu_dm_connector *connector)
>>>       if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
>>>           debugfs_create_file_unsafe("psr_capability", 0444, dir, 
>>> connector, &psr_capability_fops);
>>>           debugfs_create_file_unsafe("psr_state", 0444, dir, 
>>> connector, &psr_fops);
>>> +        debugfs_create_file_unsafe("psr_residency", 0444, dir, 
>>> connector, &psr_residency_fops);
>>>           debugfs_create_file("amdgpu_current_backlight_pwm", 0444, 
>>> dir, connector,
>>>                       &current_backlight_fops);
>>>           debugfs_create_file("amdgpu_target_backlight_pwm", 0444, 
>>> dir, connector,
>>
