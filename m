Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D9EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 17:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A584112D97;
	Tue, 16 Apr 2024 17:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6+AhXqM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78796112D97
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 17:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifkhPJryetambTuk1d1mEz//gCPN+JBVmlQjyvXku7b4XUdiX0p3XglLtOmqLaZIePRorgNdhWzTB3a/yu+8zj0VdVNO7HVR5ge7kW6LP9sBPfquXm9CmNucfuCC4j0cn2OzNptuA62H5KklhodnJhtMcuOgUT2fRguWvIXpYWtjeDaZAz8iO6Z2zBRC5wrqnyWHRKnLDykshLWNF09SNQ38a7pvVsUPg73DlGsMBl194ZPsCKaAB5KvOxVtYFvjoFaR+JQQHCDdQutz6jRW/Bfs6tn+tTuVDC5FAMWXiibPhhhV8FHsU3zEjs+i7wYxVsSOzWIQYJIJDgX/s+uW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlUt/VU44Bdro95H0EiuPE3lbr36gFBk1UuUkFwJNBA=;
 b=gX1GcaEqoQXbY3m+1Cv3SUWXbji7YTew3uJBsTzEPL+Fm4S1IXOusgikGiiWA9zuWOryYC96RJPjBfTxp07Hk1GMsPaqEX6MIJfRnkCsCQYEf73FrnQH1ASBvTyfo1b+7lYcb+9YHSTUlBu7aunT0TBXIIWtmvFm3n17JUbsdBU5a/kF4ZgeXm49uh9CRVJNe/vBZVzcwwSbfEoQRU9dL/8hWmiNOF6Yi8i63emy4g7g5fdMoyQy4QissC4+4B8V53yQZiwNZVDlRMvwvm6tnUHL5nXGIBbkkH9KJAagUouZIEHuwrVAt9vS6q5hFg7r3m53sFV2pOCrvxdXUS7hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlUt/VU44Bdro95H0EiuPE3lbr36gFBk1UuUkFwJNBA=;
 b=b6+AhXqM8KZiST2T6EnJlwKzCiuiL714TDk3MIsRwo9138Zhe75ryFTzWhAMxXbt0Jo7pUC0KCRrF6S8rGI2kyOo5wVyFS6A6aHiXrwmSp9lfcdijU02dfmmvYjcIQujZCHBTRoXztAabJEk1VU+e7oBnjekS1RaMMzqDEY8xi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:36:33 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:36:33 +0000
Content-Type: multipart/alternative;
 boundary="------------17giONIVM6nzzfi3fK00xJBW"
Message-ID: <21419f15-8be2-45a2-817b-5b3b80e93136@amd.com>
Date: Tue, 16 Apr 2024 23:06:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/amdgpu: add support for gfx v10 print
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-5-sunil.khatri@amd.com>
 <CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com>
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab3dc95-6ab2-44d0-bdcd-08dc5e3bc1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPWwmAJJZgz/k5NB0mYgO2nu4oIR9kffbOBjyAWJh+FuObkqjQBX4iLdVf7dj+s/SJJzqVK9iPCIKfPS5khiCreQwEwDbhaQ2X4+9CZ8iTX1ryRjDHvv9rVtIjsNWe7IPxCgv+fW6F05jXwR+/yhcnJWjV1ZPh9DXuhp9nyy7FAclPHIjIULS2NM6zDeHQZIQlaGS9uOjvHwod+cSgcfsrFfOfACmfHJNYJFveuL3pWBcZ5aDuLeg1rfNbeEPzbkFkAEs3SH+NLZIqtjlthicLSN1WplEBpjZZlQ1udvPoRPm1ZhhmuJIfzI62Z56gkiZZAdYzgMGQyLly+GPSZ8J7uNWQQ1efyW59Ku5m5HDJRVWKnKlyQHLGakQ5MIH9zXNiljt2nLDQbHeKps7KcwwzeoZTFJEVpF7iKtTif3nT+2dw2T06OWOlOY4IOLM7DDmknzw2HRPyt97t2DxF1uxr9n53PaiI+RTrx+8J/V5HXAADiGIDq+ns0X+bezNEzaQ5bmOQcHvQ5Wy1x5OYGxTEkmcgb6cnpa/b5ImagRWGOkdtJh/hs+uGofYRYHuKbDvgOGeQ3Hjk3lLLlAswsPh+md39oamJlSNBYDJRPxhNMJOqHgIxjggPcy/VscSWpdU7z4ntb7bODzV72NiohJoIZNcfj683oAe6kG5sVQfgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFCUWpsVUVYL3hEcGNhQk45bDN0dUtVcnRxWTVVL3Q0QjlWRnlSYWtXZWIr?=
 =?utf-8?B?aHZ6RXo3NDlPUlhRd09OWmtRMkFIeWpPZXFZTVhVSE9lbXBjUHF0YnRydFN2?=
 =?utf-8?B?MHFJL2N6eU9WeDF0T0VPZXJwKzJtV0hFN1VEcEtsNGxUSmNiNktjajk2UXdm?=
 =?utf-8?B?eTBsZ2RwTjdjam9Fb3hNN1JBZkhCNVVVLzhPa2V0VjhRVFNobmtYaHhXeGJI?=
 =?utf-8?B?bm5mVW5QNS9acWZZWktCTmRYOExoWmhtdElpTE1DVHJSMklXeURPZHFwd0kv?=
 =?utf-8?B?d0RrQTUybllxS2d3eDAwRTJ2WStoRWNLNkNUandVakJOMUZ0dUJQcFo0ejNF?=
 =?utf-8?B?RUtWcEhzUFhKdlVjNExlcXVtanFJWXBJL0NsRzNMNUVBRWprNi92NnNUb3pL?=
 =?utf-8?B?N25tc1VWWVhSTFY2THA3WStRdVpDUlhIREJwU2ZvZ1BkWG83Ti9YbUt4Ulp2?=
 =?utf-8?B?K1lNN1dTWDlUTTBDZFdpZkpZYVJObUZlWExCQ253ZHplOE9lMHhvVVBsVjNx?=
 =?utf-8?B?eTk1WjE0b0pWMmlKMUl0NzFRekhkaEpLVUQzUGdxN2pQV1RJL3o0NTNBeVFq?=
 =?utf-8?B?a0YyYUxNa0UxZTVVN3FCdjlJb3ppMW1WOXN0LzQ0bmgwVW10TnRpYWsxQUh4?=
 =?utf-8?B?ZjJpeW14QUY0L1psUllIdWM1ejJhYktjc3V5aXZFRjRQUjFqdVZEbkdQc3M3?=
 =?utf-8?B?M2tHVGIxOTZkTWt0c2FwUGdJakxTWnFGZ28yVlVwZ2FvYlkwTVJUZ0VQK2Z4?=
 =?utf-8?B?aWRiK0Z2V1lHTlBwN3ZvRFA1a25HS2RucDhWdWZnWTB5THB6Mlh6OWpXNml1?=
 =?utf-8?B?dGtqSGtGSVUrUmMzb3pUYUZodk5qa3ZoNlhzQS9Bay9laFJYNXpLUnBMbFFr?=
 =?utf-8?B?RWVETzRIK3IwaHFJRXl5d3lYbDB5OGxXNWJkdlJRQUNVenN6U0RtemxhSWhp?=
 =?utf-8?B?VHFZemVEaFlhSEJvMGlqYlRaWUd0RE9RRWEzRGkrbXZrQkl4U1RCV0xKeEZm?=
 =?utf-8?B?Nzg2ZGlqY2c4Mll4aDVNOC85aUl1OGN2NEFLT2czT0FHa2ZYaXFNa3pYNVkv?=
 =?utf-8?B?bDd5N1ljOEdsRzR3TXh4OS95RHZxNkJBcFZ3YTlRM2FZVElHQzF6MDhPSFZ5?=
 =?utf-8?B?NGg0THo2Z2V0YWlmTy82NFdON2h2cTVqUXhjNythSWRRTEIvM1Y5MjllSWRz?=
 =?utf-8?B?d3JhWDlQczl6MEhvMEtXaENSWGtiMEx4dG5FUWtFUURsd3BNSENhaTRkc0xU?=
 =?utf-8?B?UGVVaTNQRU1GbEFWaWxZZGVmK2lPbzFrRzkrS0h1WGxEeFRxWW50Z0NtQ3F3?=
 =?utf-8?B?N2xMUTBSc3cyWXZDa3pFUDZBcTlqRFAxVzNmcHFxWFZ5TGNLbVhtdlVCejEv?=
 =?utf-8?B?dTZmbitMNmRjTDhXTWl0c1BTWlhXTENESndRZkpOV2p6YWdDZGx3aWl2NUlP?=
 =?utf-8?B?bVpEUnlscTZnLzA5SlEvSlF3VTJQeHNXRC9KZWVIb21OVnFTMDBzdFR2YTl1?=
 =?utf-8?B?eXNGWEY2YW05K0tKcmFkVjRxUEE4VzU0WnlnRnBrTWpwYzVSTWRLa25QbmU5?=
 =?utf-8?B?dU44MHlhaWwwRXFpWCtRMDRQT25nZlJDT29VaVhqV0QxT0wySDRMRS9QZWVq?=
 =?utf-8?B?ZDNlMkdOdC9mZkIrRFFqYzJHUDN0aml6VVhJU3VLTkR0S0JGKzk4REl1UEFp?=
 =?utf-8?B?WWd0RWVPZ1lmSHJ6KzBwZm12MUZwSXpXUk1IbXRKdVdWU09xQ2o1U2lPWklN?=
 =?utf-8?B?Y3Ztc0h3Y2xpRjlsRFdka0s2RnVkUk81Qk9aMUVNMlRZNzlzOGhLejBITW4z?=
 =?utf-8?B?Wnd3b3pOeVpVWWVWaGp5Wk5TVmswekFTNnZLOTNxTFZCVlo4WnYrazM2ajQv?=
 =?utf-8?B?ZHNid251NkdYaGIzQy95OFdNbmxKQzNhOERWZnFhYWZucUVPNURDV2lTSlpV?=
 =?utf-8?B?OUNoODdaZ2pnckdrTU16cjRhNnZudnRaeTNhVTJ6bGlxbjBWU0VobC9CaHN6?=
 =?utf-8?B?TlNiUmFMdjF2RElBZzFhS1psU0s1dCtrN09jdkVVcENBR3J2VzZldDY4Y2NR?=
 =?utf-8?B?WmJBTVFEVVFyUktZaVpGSlcxMTBhVGt4SWtOMXZ5L2hheFg0aTV0Kyt5ZjdJ?=
 =?utf-8?Q?93N3V7Tyg5xx9zC8A/2+mYff1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab3dc95-6ab2-44d0-bdcd-08dc5e3bc1d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:36:33.0830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrV1avFX6ftZJ7YcMhngL29kxq7v4mOUFkfTFteDyzz7snYvFr0graCwTFiIGElQzqrNsy/rom+prXJvnv+LwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

--------------17giONIVM6nzzfi3fK00xJBW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/2024 7:27 PM, Alex Deucher wrote:
> On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri<sunil.khatri@amd.com>  wrote:
>> Add support to print ip information to be
>> used to print registers in devcoredump
>> buffer.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 822bee932041..a7c2a3ddd613 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -9268,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>
>> +static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       uint32_t i;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +
>> +       if (!adev->gfx.ip_dump)
>> +               return;
>> +
>> +       for (i = 0; i < reg_count; i++)
>> +               drm_printf(p, "0x%04x \t 0x%08x\n",
>> +                          adev->gfx.ip_dump[i].offset,
> Print the name of the register rather than the offset here to make it
> output easier to read.  See my comments from patch 2.

Just register name and value is fine or we need the offset too.

Also i am assuming stringify the macro is good enough ?
eg:

#definemmGRBM_STATUS0x0da4
so printing register name exactly like mmGRBM_STATUS is acceptable ? we 
dont need to remove mm as it makes it complicated.
>
>> +                          adev->gfx.ip_dump[i].value);
>> +}
>> +
>>   static void gfx_v10_ip_dump(void *handle)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@ -9300,7 +9315,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>          .set_powergating_state = gfx_v10_0_set_powergating_state,
>>          .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>>          .dump_ip_state = gfx_v10_ip_dump,
>> -       .print_ip_state = NULL,
>> +       .print_ip_state = gfx_v10_ip_print,
>>   };
>>
>>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> --
>> 2.34.1
>>
--------------17giONIVM6nzzfi3fK00xJBW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/16/2024 7:27 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Add support to print ip information to be
used to print registers in devcoredump
buffer.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 822bee932041..a7c2a3ddd613 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9268,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
        amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }

+static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
+{
+       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+       uint32_t i;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
+
+       if (!adev-&gt;gfx.ip_dump)
+               return;
+
+       for (i = 0; i &lt; reg_count; i++)
+               drm_printf(p, &quot;0x%04x \t 0x%08x\n&quot;,
+                          adev-&gt;gfx.ip_dump[i].offset,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Print the name of the register rather than the offset here to make it
output easier to read.  See my comments from patch 2.</pre>
    </blockquote>
    <p>Just register name and value is fine or we need the offset too. <br>
    </p>
    <p>Also i am assuming stringify the macro is good enough ?<br>
      eg:<br>
    </p>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #c586c0;">#define</span><span style="color: #569cd6;"> </span><span style="color: #569cd6;">mmGRBM_STATUS</span><span style="color: #569cd6;"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="color: #b5cea8;">0x0da4</span></div><div><span style="color: #b5cea8;">so printing register name exactly like mmGRBM_STATUS is acceptable ? we dont need to remove mm as it makes it complicated. 
</span></div></div>
    <blockquote type="cite" cite="mid:CADnq5_ODDOi4vOXyH7m1J3DJ54+PG__K0vzm8fQ=TT0vPTQX4w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+                          adev-&gt;gfx.ip_dump[i].value);
+}
+
 static void gfx_v10_ip_dump(void *handle)
 {
        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -9300,7 +9315,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
        .set_powergating_state = gfx_v10_0_set_powergating_state,
        .get_clockgating_state = gfx_v10_0_get_clockgating_state,
        .dump_ip_state = gfx_v10_ip_dump,
-       .print_ip_state = NULL,
+       .print_ip_state = gfx_v10_ip_print,
 };

 static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------17giONIVM6nzzfi3fK00xJBW--
