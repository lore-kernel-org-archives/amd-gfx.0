Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4189AC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 06:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA7010E956;
	Fri, 10 Mar 2023 06:30:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BD910E95D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 06:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv/wNbzmp7kkRVi/KUxgxRJPa7mRxlb+aT/Xe7VncnMvj1F1+9tiAJ1+zNAxCJXX3FBo0FI9OsZM2xBkZpWBm4Q81A8IzSo5NAsSduATvB6hRpMnuPd9KLltlM9O2HXqxDB4JN7QZKaCB3QqQB2iu0PNN6fCk6c/kZMPks6uZtRvUhrJiMOkYWRLXh5KXPw7e2pH2Qaceuh8WVkAebyp0DgXuq90f3QKkHKea8nWNAgjzIod9yUgdylMhDFPx+0cZp8vYHolAC2VXxK0kG+YXMBHgbXimIUp5sCzs16k/J60ijIK8rQbYnem7jnD13op94+VMPTJUK7Nk5icfzEmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUXcAMwaX56bf6+xzRROfgYdnrXKSyKaOM/44FwYnfY=;
 b=C/8YQFs2QQf04yr3usMRxRTL/AGp6dqFzldmZv0+8VpolXd4QAeXHg2iakUUI5fIi5hNZAZBav80CUm5fRpBIogikTxnfLiFr1QKqufR5bJgjMZyuc4coh8L/WrkDlt24zOjmpcuq8ZYs9QoU+3co2tE+gd2hyAlL6j+/zRv1XmA5H53h0UdvBT1oBOR34oKduMkFhAcMCD2ZLs/fNzj6kDYs+57OFebbKjpdCEWYNx/KjAdGuRGOnot2sVL5FXzPaquUnX7rKcTRyAbeNNljLAkU7Iov3rQMqiILq5SNYiHY1L9cmsD7GlM8AB2DQTW3IYNIYh6kzHvXHjJ+7k6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUXcAMwaX56bf6+xzRROfgYdnrXKSyKaOM/44FwYnfY=;
 b=02xcDl3cGGxAWGKE9XcnAGffjVsibCGddHeEaxd/yGNTEsK2U5AQst7wfZGUuhqwDA94YLkPb+y0StHaVUjvuiqeEkerzBqvNzDxaIkhzb21GtuaLpXUfLtlmpllBjmEDS9q9LnPKHPC3nE1209cblfzTOkgWLvF7/be2cKtSeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Fri, 10 Mar
 2023 06:30:25 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7803:31cb:36cb:b2bb]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::7803:31cb:36cb:b2bb%12]) with mapi id 15.20.6178.019; Fri, 10 Mar
 2023 06:30:25 +0000
Message-ID: <77cbac84-77fd-ae86-dbdb-cecbcdc5e384@amd.com>
Date: Fri, 10 Mar 2023 12:00:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] amd/display/debugfs: add sysfs entry to read PSR
 residency from firmware
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, Shirish S <shirish.s@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20230308071035.98892-1-shirish.s@amd.com>
 <bb743d26-edd3-d60e-96a7-95b70dcb72f2@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <bb743d26-edd3-d60e-96a7-95b70dcb72f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 809f0337-d590-4b57-56c7-08db2130ee9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xPR3WoludV5dQP5slLUeO6Y379wb1VD3btNLhvb3NBOrYKAf0HcUW8uO/0XWoQVgJdbpvOKld+2oKAtNOuIXgnd3St3H1e9Yd4/XMDjDfzxQtka4qAnRfzKp8ygUOllmYAn3o4CHc0YZQW4HZ/vJawUqMjZUoBF9zeiI11YaFv9e1emKU5kGumuKxYnix7iNbmrgdoNY6g4cnOOt74R1aiq+pZ75Re3qbaT8eUDOEdECsYafIN5ZuyXfJAzmljIQj+8eCrEBeMKHl4z5tE1+jR+mPhTcG1UdUBJnObaRgQRBKrZwAZ7bCgWKW+EcztmFv0PhKLntpVxfIUwO9gaaccn/mW1/xtWd34COJqO7dVsp/JKjjwp1WLW5sfG0y0l3lkija/jtiTzkb7FJj9808tdawvBclDXRpslzpmUN0jWjmwG5FDDg3Ibuvfir15ExtChP4ZQWsyIPd8voM7KxLC1k71u8sJHb62CVfkWt0QCvttSQFvixeaf7nhe3pA343DFUmsVgz4lcmS7/5J8d7v268izimA5qb5JWK38n7ixKzTKFl051Ei+jjDa2kZcu2DxSi1aLn/aC55QxZC7fr5qgXtmLtIY0dERPoObiMhIC4W87OMJXP7STom9ItEsZSPn0o5p3/frzhx9im95StyVbhQXU0BchQM/5IoJEK0pbcMD/+6uN1QOxhZA5Amq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(38100700002)(31696002)(5660300002)(41300700001)(36756003)(66946007)(8936002)(4326008)(66556008)(66476007)(83380400001)(2906002)(6506007)(53546011)(26005)(186003)(2616005)(316002)(478600001)(6666004)(110136005)(6636002)(8676002)(31686004)(6486002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFFpKzFJWE5mdWtsZmJMYmpucDN2RDdEUmZXWUFWYWhBbGhTRERKRFovV01Q?=
 =?utf-8?B?SlJJaUI1KzhwZlkyM3UwZ2k2M3BtVnEvZ04yQzlWY3dZVlF2akpReVVYNzFo?=
 =?utf-8?B?SVRxOXBTZmlLWkRaQnBJaHY5dTlaZ1hkUlIwcFRya1FtRm5TUWl5dnBqT3gv?=
 =?utf-8?B?cXF5YlZWc0NzYW5naXNJdGQvdXpwbVlrSEZKVm9pc2ZNNSs3VEVFVnBzbHJR?=
 =?utf-8?B?eHM1L09IUEtlSCtwdUVsK1JuSjBVVi9LOFJCT3JIL21EK2E0bGRqOXRBWVV3?=
 =?utf-8?B?YWMzQ3M1ZVFXRUFtZThid0VRT2dvbEhoMHdEdmZNZ0JIbW1xaDlBQW53NGJY?=
 =?utf-8?B?MUtSRlNoMTFoUkl6b2N4eW83T0pvQVpvRWY4U2tlQWFOOGYwK2p0NEMwMi9J?=
 =?utf-8?B?anZ1ME9JRFZFdHVCc3hsejE1b3JwaTZDYWdkQU1lZGlhTjB6ekJlMkhjTEFI?=
 =?utf-8?B?c1Q5MDNsWElRYUdnZ2lZQ0FiZWcxR1BDV1JXQWt6c1RrRHk2VWpRNlp0cUtK?=
 =?utf-8?B?WExmd0NTZzEwbGRJRkxpdC9kdGtTWHZUTi9LZmUxWncwSzczanNWNWxZeGRJ?=
 =?utf-8?B?Und0OGR5TXF4VFFoZkppQmtsdWJUbVd6akNEbnpjcXB0Q0FpRDZjRTI1RFJv?=
 =?utf-8?B?WDVpNFVCVUQycENMY0hacEdVczJHZk5YZmZOUmUrbjlLdkdMK1R5MEtYOWFT?=
 =?utf-8?B?TjJvTCtoUWhlS2g2NWZXWkFBRWpKWEFNcTYxTm5lRkRFVm9hcDN2Nm5iUyt0?=
 =?utf-8?B?T3Q5YmphOEFPZHJqNEhZSlYrVEtMMjNXNENUUDNzVjZtWXlxYVN5Qm1ibmlO?=
 =?utf-8?B?V21EaGJjaWk4ckV5Szg1Q1huVlpLdytEMnUvZ1J4b3dCcWtVS2ErRklOakJv?=
 =?utf-8?B?VzY2eGxrMG81M2VrT201L0FRWnBETklIZnY3M0ZLTUoxZklGS3NpbE5NL0pm?=
 =?utf-8?B?RnEwcG0yY1lvL3RPR09jQVM3azZLdDBqdmZWN0ZrdnNvaldNRDBHZE4rVVM1?=
 =?utf-8?B?bFluT0JseHFUTVM3SW9oUHpGd0x5TlNxcTJYOXR0YWtkdUE1R0Y1d1YzbDNC?=
 =?utf-8?B?bDZKeFh4K3cxd2tqWW5zZ3JrQWRzd294Z2ZNRlNHdUFPMGEzV1E4OEVZbHZ1?=
 =?utf-8?B?bkF6amU5UU5ZRVdaTnpRdEtrbVlCWU1UbUtaVitjSVFrRFdGRjRzbTVTcEto?=
 =?utf-8?B?TWZVRXBpbEhtdmt6aG1RNFNrUzNqOUYwandpbnNEekdOSzJ0cXZ5UHgxN3FX?=
 =?utf-8?B?N3RmaG9BOW52Y3dBZkVGRFd6aUtRTHFkN3Bzc09CZmIvdDlpVUNuZnVXTDVO?=
 =?utf-8?B?Y1dlU3BOQStqcXhYY3JVRUFVazJVWTF4ZitRQSt4azZRUUwwK1R3Q3RPV2lE?=
 =?utf-8?B?Z0hwRkZpbitKQTdTQlBrVXpyMzZKZ0Jkb1YyeDFZelRtaFNtcy9oeGFEWkxy?=
 =?utf-8?B?SU1YTTZYdmt6QU5UQ2hnd01tZXpCSlcwNWd3Z2NZekdLNVA5Vy9vaFJEQVpy?=
 =?utf-8?B?NHhVTXNwc0lmUEFIa2Judk1Kck9jTGZnVGRyeEFhczdaejUyclNCV3duMHp4?=
 =?utf-8?B?YTM5TWJlRDdwaHJpYVV4Q2hLdWJHRnJuSkhYZmpha0ZIeWtENlVtb1F6aTVa?=
 =?utf-8?B?WmZDSDNHcGJ2S0dtQzhqT3VpbkoxRlVtTDFDRmo4YWFpYnhoR05vOVljTXpq?=
 =?utf-8?B?M090bGsvNHQ1Y0JBcTNnMWdpVDBPZXNEc0Y2eWViNldoWHpwT05uTDNsYTRL?=
 =?utf-8?B?T1hGTFgwdGZKWUxqcm8wVk0zaldyQitNdWFsYndrbDMrRUs3VnY0aURicEM3?=
 =?utf-8?B?Y0c3bWpLMXJBU2FjdDNYY1J5bXkyYUZxY2dWeDM0VkQrc3Q0dzROUXZjY2lD?=
 =?utf-8?B?ZTBFcEhtOEJ6aXU5THJWdFVWUlpzOWZ6UzZBOXZlMUovYnQ1Vm5vVUVBbWFL?=
 =?utf-8?B?TVJMdEtxdWRnak1KN29FY0U4anFvSXIxS1piTUpNSC9XWVAvQ0M5bXZWdVFM?=
 =?utf-8?B?cVFSaFNvcndKaEZyeTg2Y2d1TGZRdzBOY25paTNRSW5KY3Z6NU0xRmRhVU52?=
 =?utf-8?B?dFlwSmFhenRSZko1dGVIcEYwQW82Z3JoaE85bUJzSndLSDdXUnZtcXFyMUFi?=
 =?utf-8?Q?D2Dlo09Vpr4J0whG8CxqXnc7u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809f0337-d590-4b57-56c7-08db2130ee9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:30:25.2736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klCAVwH27SnRpTy0aD1cAg/epUUgDJLtlPqoA4gHerUlSisIG0qV400+UcTo9ufVH2N9Isd0bTl8FRnyHfwLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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


On 3/8/2023 11:52 PM, Hamza Mahfooz wrote:
>
> On 3/8/23 02:10, Shirish S wrote:
>> [Why]
>> Currently there aren't any methods to determine PSR state residency.
>>
>> [How]
>> create a sysfs entry for reading residency and internally hook it up
>> to existing functionality of reading PSR residency from firmware.
>>
>> Signed-off-by: Shirish S <shirish.s@amd.com>
>> ---
>>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git 
>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index abf7895d1608..8ff2802db5b5 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/uaccess.h>
>>     #include "dc.h"
>> +#include "dc_link.h"
>
> Please drop this include, the relevant function should already be
> accessible from dc.h.

Good catch. Removed and respun the patch 
(https://patchwork.freedesktop.org/patch/526211/)

Pls review.

Regards,

Shirish S

>
>>   #include "amdgpu.h"
>>   #include "amdgpu_dm.h"
>>   #include "amdgpu_dm_debugfs.h"
>> @@ -2793,6 +2794,22 @@ static int psr_get(void *data, u64 *val)
>>       return 0;
>>   }
>>   +/*
>> + *  Read PSR state residency
>> + */
>> +static int psr_read_residency(void *data, u64 *val)
>> +{
>> +    struct amdgpu_dm_connector *connector = data;
>> +    struct dc_link *link = connector->dc_link;
>> +    u32 residency;
>> +
>> +    dc_link_get_psr_residency(link, &residency);
>
> Did you mean to use link_get_psr_residency() here?
>
>> +
>> +    *val = (u64)residency;
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Set dmcub trace event IRQ enable or disable.
>>    * Usage to enable dmcub trace event IRQ: echo 1 > 
>> /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
>> @@ -2828,6 +2845,7 @@ 
>> DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, 
>> dmcub_trace_event_state_g
>>                dmcub_trace_event_state_set, "%llu\n");
>>     DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
>> +DEFINE_DEBUGFS_ATTRIBUTE(psr_residency_fops, psr_read_residency, 
>> NULL, "%llu\n");
>>     DEFINE_SHOW_ATTRIBUTE(current_backlight);
>>   DEFINE_SHOW_ATTRIBUTE(target_backlight);
>> @@ -2991,6 +3009,7 @@ void connector_debugfs_init(struct 
>> amdgpu_dm_connector *connector)
>>       if (connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
>>           debugfs_create_file_unsafe("psr_capability", 0444, dir, 
>> connector, &psr_capability_fops);
>>           debugfs_create_file_unsafe("psr_state", 0444, dir, 
>> connector, &psr_fops);
>> +        debugfs_create_file_unsafe("psr_residency", 0444, dir, 
>> connector, &psr_residency_fops);
>>           debugfs_create_file("amdgpu_current_backlight_pwm", 0444, 
>> dir, connector,
>>                       &current_backlight_fops);
>>           debugfs_create_file("amdgpu_target_backlight_pwm", 0444, 
>> dir, connector,
>
