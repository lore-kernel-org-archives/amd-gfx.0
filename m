Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A10C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 17:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBA2112D9A;
	Tue, 16 Apr 2024 17:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUkErzhm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A008112D9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 17:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2gxrS3xpxD9792Zs7v0Cngb9iBDKJDsNr6g9Bnip4ixgcWwzYZtKBCBiauUnnFpOYyaaLmcSOCzSnWUYYyc3JlLQ/kK9+xHJpey5C0OEtRZvwqIv0veh6kLcKVGuf98i3olO5YOHH21bo89XZ5OYqBUVtuG4s/GWrFSdNjooLc0oymx+mYew97yQdZr35mAaRJJ3NmrxoUgTwg65YUKyR7DAa/5pw7eGCd+ewZqB0xO/S8Oz+xqznh+keZzubnRZeaUTjwtiatsL14Lo+nHNCbh6kTGgRrFX8p8LbYwYDu4tgORs2ZxSeS9VE/FCKV4WF+JOWi4MZHevIg6Ny5RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4Un7MvPZbV3DvvcS6ZP7IWXBdbGJtdmpAZKrtX9nz8=;
 b=e1H8+V5ZUCav1WqSoQ4FUlUovkE4Se3HJKHf35Bf5pcMeRLKwA+DGiRO16EzZUFDBt+Snf1Cr6CFnJpOE/SybEaME6isvmHtZilLsK/7EaKDAmPpzxRzXSFUjIi7fSgWnsVQtRPoyNqrYfQRJ6U8h4ZgikiKmHq7zw6l08m4S6fxN7xvK08vB0IZAxmGYANFsA6YxbJ2XKlzww5GjGB+oFhC9Db7BXAx8AqOXukQSZ1ES5P5sQVIu/rZJ1iRtmadU+zGvVG92QPtBRSg8r0IpTU0xKSc8tCSQwc0aGHbYCBMhTOE7QyEC5wuNrIAHTXNEzazPLFqnYWbSKEhrGBnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4Un7MvPZbV3DvvcS6ZP7IWXBdbGJtdmpAZKrtX9nz8=;
 b=dUkErzhmePmSgYlKvokWtDlbbN1kdIN3W38dH+TmsQVMUHBgE2N7AwwhoYvYzYS9figBvJa25csjZGg5vF13dl7U3KnPiERF8Rw+4+OudDFGZC4WC7HeFpWiTGO7+icibN7/++lHr3zA2X5b4dpWf1LUNo2sPXtFeXokf+iBJVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:37:03 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:37:03 +0000
Message-ID: <623ba663-7660-4b68-ac86-282b4964fca5@amd.com>
Date: Tue, 16 Apr 2024 23:07:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/amdgpu: add ip dump for each ip in devcoredump
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-7-sunil.khatri@amd.com>
 <CADnq5_O=TWub8iPkGWNiADT4J5JX3ExQdn+vTs5x8VsZQaiOFA@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_O=TWub8iPkGWNiADT4J5JX3ExQdn+vTs5x8VsZQaiOFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feeaa3c-aa98-4b3f-92f8-08dc5e3bd40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2pcldYMhHZVli8JQlDIy7PqTW+soKvvdrtrGr8VhFmQdVnhuuvCRa2R+PPOE+h5CN9RHjHGSy8lNYWWWZrKB3Lk7+SId1c8/fbu8OeTIaPSv4P0zEJbWPYb5uRgMBDNE804lkFlS5mJ+JXXLRSjB9mT4MAls3KkWbc9RAknPfLfpbqJscn0CycbP4wvWb6SZsHaRylJDU9ztaT8qT92tXM8wUcN4PucAwzeZWkrHHCa2RVb8enddbusCG9fZpz8UOxT8hGb3KGLg5OgAx3K4OwIlIYM6yiZr/gzfim2Ba7SOQhUAVUI1XR1yREj5yf+P/TOwMda9EypHhlUb0AaG21BbtnAPBIMi/rnWKmml/4KFZZQhZ4WTog/my6LOh6qCToqBo5UGdr11vflOyI0HbRiLKG6awtpWpCkr0KcyjrgQbIYXKx6/Ua1s/FrZWgWleWe1gno/D/ZtJEDWLXqszKzJL0I6qCTjw9kWyJrTJiAezEGfAHZQB7/4xOvuGbGHQ++N8C0DCO/gMGsmWqlLxoR5zJJEI2/ND6z5SICQXTmAfdAS8EvyPu9IU4ZhMlVc09ghkQuxjml8ot97xAZhQZXsVSCtOYEC+ZmkK+6ybqbsFBCpmQhL0lg6+Iv0XfNaoS8JIFYOjbGSD5SPenjOL8Vjmc79wzjeN0G5YhILiUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjZnZ3YvVjdtdVpkK29PcDFqTnBCbGR1WmFGdDR5bFd1cEJZNmJ0cWRwTXlo?=
 =?utf-8?B?aktvK0pCMUVCOU5HUERrbnpPb1hiNnVWcVl3YWQvMlZLMjl4b1l0YndnV3Fy?=
 =?utf-8?B?R1F5eVJjcVRQUDFFcTBiR1d5SkN1M0tQOVVTSTFJMjkvQTRqRTREOGgwenBy?=
 =?utf-8?B?V3FDZHRIeWxndnpFbVYzdUFYUElTT2dWaGFrdFU5ejJpcHUyWEcrZHF4ZjBp?=
 =?utf-8?B?UVVzTG5ua1lYZWpraW1Nc0MxTUlYZyswdXA4WjhsVFJNNkZPU2MxemxUeitt?=
 =?utf-8?B?dUxOUHo3K0tHVTBYa3h6MWpzWGMzTEdNc3BLejdpcm51dTdKN1F1ZHZ4MEhM?=
 =?utf-8?B?MEJKUk1BZXQzLzFsbDVURDZSb04rVGdZcGt2SFgycjBjUmJaYlIxSUo3bnc5?=
 =?utf-8?B?MS94clhQODNLaTZWWmdYNXJOVGtkQlo0RmZqenU1UkZvcmdJT3AyNTQwRmVB?=
 =?utf-8?B?S0xZeXFudjNqNnhicVFkVUNVbUdQTUorTkdiQ3pFZ1N1SW0xbmdWNUZtOTNv?=
 =?utf-8?B?VThoVzMvelcwa0FhdjhkSG1yR0wyTHlJNlJoazE2TXJFbzRwRVMxZEwwQm9p?=
 =?utf-8?B?bkNxdzhlTE9qMlZuRlhmSkQzMDJtMjBQZ2FYbWhvWDVOZzdob01INWlTUUFx?=
 =?utf-8?B?MnpqMW1iRTcyZ2xoUW1Ha0I1SEIreEd2RDZzVWd3UmxqalQ4Qk9MMlNMSWt1?=
 =?utf-8?B?ODlHc0pXRy9DVnVkMUFuTWdJWFJKYSswZjZGdUd1cGVoaS8wdlNSOVJyaDhG?=
 =?utf-8?B?ZG5lbjFqNlFtTW9vaWdwTkkvWFgyYU9mYkJ1Rm5xeGpoTXdWMzd0S3BqUWZs?=
 =?utf-8?B?RVR5S01zZnRrcHMxRWFMcU5qNnFWcTBJcnRzUE5VYlExaUtkQnYrRGlGdzIy?=
 =?utf-8?B?cTBSU241dFA0Wkp1MU9YQjQxN2NEdVMxencrRTlWMFh6OW92ZTJnSjU3M3hW?=
 =?utf-8?B?bmcyUDdSaWIvUVMxemRsZXV1RHFnTVhzemMxeEc1RjdFVjZiWHMrNlBLOWVU?=
 =?utf-8?B?NGtNWFNTYmNoTStnTWhHekhSb01ERGdCd2hOM0graW5TVUpnT0tMUmFjRzdM?=
 =?utf-8?B?L0Y5b3dOTXlBa0l1SEtwT0pLZGN3KzVuMzh5dnNYNitieTRScmt4OVhjMzBW?=
 =?utf-8?B?SjQwSllGdlRodDNWeUNvVmh0WWRnME9nNjdWVUtFQm1MRmpPSEJPVndCUjN5?=
 =?utf-8?B?OHdZSGd2WVVyNGVqbnQ0ZHo2VjNmNms1QTJqRWFKUVNaaGZ2V0dadkxacmtu?=
 =?utf-8?B?RklmZ2FtWUdsbnpDZ3lrSzF1Zjl6aEdiWEgyVGFhWks0a09YeXNqajcybnR5?=
 =?utf-8?B?eVRMa1FFdi9zcFozUlY5dDZUU051cVphNk1UbFlQMkE1L3lxMXpDZzN3SUsy?=
 =?utf-8?B?S0syQmM0MW85dzA3T0IrVjJ0WDVpSXBCSVhkNDhtZzFkVDgrcW1rU2Z4M0I3?=
 =?utf-8?B?QmNOeU5IVVNibE1XbGo5dlVGTElrSXlCNE45K1RMYnZyOFplSjRxUzlhTEY4?=
 =?utf-8?B?Z1hlbWdaK0x5MS9ML1pPbkxYQjlJdVR6UVpleFE2dWtzTG45dDBHSUlGK3Jw?=
 =?utf-8?B?Y0ZuVzdlS29Nd0M3aEphZzg2b0gwVkRGZjU2UHB1aTlJSFYrNEk0aDdhZ1NJ?=
 =?utf-8?B?aFJLLytnNjg0c0c2NHlJbVlrWWZFZXhXc2d1VElHWWxVMGpadktEN1IrREFW?=
 =?utf-8?B?NlFoZ2g4Y2dpaGhIa09YbjFGcE90ZU5BUjJDU2g1SWVUYVFqRC9uSlowYzl2?=
 =?utf-8?B?cThBN0dJeU4rNkZ0Zk9BcGE0Z21pa1JFRHZ4QzgyblhrOEZNYTVLOTFZSndn?=
 =?utf-8?B?TVNXd1g2QTJ2eXYvdVJ0bFB0VENvNVpoMmQ1UFBkdGRLTWxrS1cvRmtlbUg3?=
 =?utf-8?B?ZGxFUXcrRmtacUV0NVhkTzNvUUxrbjdzM3c3bGJpUEZJWHBDM3hIRUNsb1dK?=
 =?utf-8?B?M0lwM2FRL3VBN2RlUkt4c0FvRm9VaS9FMU05V1NtdmQxeWxKZ2N3ejNFNG9S?=
 =?utf-8?B?SHRNakJNYkFtQ3RtYmdLcjdyQ3lGTnZzMFR0Um5ZOHhvT0pDK2FlK0tsUlg3?=
 =?utf-8?B?REF5dkxhcnRZdlNxRnp6MGY1TGtLdTB5RzYyeTFLMktvNGRJT0xPYlNORlFl?=
 =?utf-8?Q?iZvmHm4auOejKgb/SZI8JXPog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feeaa3c-aa98-4b3f-92f8-08dc5e3bd40d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:37:03.6714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdJ6eJrOkC0jSv4Vk3g0evY8F2tVoAgch9rmfCxDlTYKiP33Go5KQU6F/bvquaOz/y8g8tA/JbROk8YeV8rHRg==
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


On 4/16/2024 7:29 PM, Alex Deucher wrote:
> On Tue, Apr 16, 2024 at 8:08 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Add ip dump for each ip of the asic in the
>> devcoredump for all the ips where a callback
>> is registered for register dump.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index 64fe564b8036..70167f63b4f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -262,6 +262,21 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>          drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
>>          drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
>>
>> +       /* dump the ip state for each ip */
>> +       drm_printf(&p, "Register Dump\n");
>> +       for (int i = 0; i < coredump->adev->num_ip_blocks; i++) {
>> +               if (coredump->adev->ip_blocks[i].version->funcs->print_ip_state) {
>> +                       drm_printf(&p, "IP: %s\n",
>> +                                  coredump->adev->ip_blocks[i]
>> +                                          .version->funcs->name);
>> +                       drm_printf(&p, "Offset \t Value\n");
> I think we can drop the drm_printf line above if we use register names
> rather than offsets in the print functions.  This also allows IPs to
> dump stuff besides registers if they want.

Noted

Sunil

>
> Alex
>
>> +                       coredump->adev->ip_blocks[i]
>> +                               .version->funcs->print_ip_state(
>> +                                       (void *)coredump->adev, &p);
>> +                       drm_printf(&p, "\n");
>> +               }
>> +       }
>> +
>>          /* Add ring buffer information */
>>          drm_printf(&p, "Ring buffer information\n");
>>          for (int i = 0; i < coredump->adev->num_rings; i++) {
>> --
>> 2.34.1
>>
