Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60655C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 16:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B766510EC84;
	Tue, 26 Mar 2024 16:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fPhSvwb5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2118.outbound.protection.outlook.com [40.107.223.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9202310EC84
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 16:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na+lKttYciqxwcIz5f+TQVDxCxTf1iQBdWqcdXhDOy2SaDLh6FZV0HeSrwU3QcPHHmeZxGu+xe0K1yVfJWgrPMru68KOFTJFAP9Kt5N7DviPIEDly0e0ySE59mySD0Lm8EKEblwhvgVAmAopM9dbbhjzSSmZBaYwBMrPBNzKGIwLXgVdhprU2XONtSP8xe9dLbSURy5qiiYxrix3pH+kbW5BM6i+ogDy3r8bKywldjSao7IagoxAT0UgNB3Gq0msMFCFN3Aw4Yubd04f/kDJuKif8+ABNFPKYpz+nX7SEcHjT5W0DxHEn/U9cg1lNdOEDOcuiTYJWl9Ffz6/fHdCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gv5NtqLJIy6vx+9L0V9Qet1hW/BYa6C/ykJvVumldg=;
 b=L5DL4ZhkpOHX9V5804Vw4g+gXYwfrXlhR++i6DZlRwS5tscMb0TbaqQgNZbcvPYZO3pExrlPC9xr5eXkdScahb9BlzThQw5gXIAr46/Q5AwduErc7L7iLi7Y96Xzdv6aoJp1qVHP3FDe7mthhjWitIJQ1lubruoIN6pLrnI9UV4zHtvnNUBvu0jqcossF3Jjecm4zDwm7gyzreAocSDoYLYUW/8vqyTib3ofTcw3cna8/kCdX3eVU5IbM6lpwEcT2QauQPmO36pKihbCFOOxeCGh85TH/+woq1qiDsjbmF1MBi0RDdshKvezbXAoO3i+ns+aP8KIyugRR3f6QZrwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gv5NtqLJIy6vx+9L0V9Qet1hW/BYa6C/ykJvVumldg=;
 b=fPhSvwb5a/RVn5kXyELTyjaFsKhkestKt2SfOx5S/A7qsTJ3aIL48PAqnaVQf+LJM7+Cc45v2b7Yh8DGjfMkJwUp6pPzUxPxWZXHgu6i+kPYk6+g9rw2pPipiWAyCXKffhbXWV7mTBCnnwK2g0qmlOeCXT7ajGk1c/sFRbU7kkE=
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 16:34:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:34:46 +0000
Content-Type: multipart/alternative;
 boundary="------------New1LBWGmTQvfDcOVdU96LLi"
Message-ID: <67735439-e3d1-4c25-ba85-1d6a195b589d@amd.com>
Date: Tue, 26 Mar 2024 12:34:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
Content-Language: en-US
To: "Alam, Dewan" <Dewan.Alam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Zhaochen" <Zhaochen.Zhang@amd.com>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20240313174344.2580-1-dewan.alam@amd.com>
 <c0c126f3-c379-4a68-bb89-2c4aa505679b@amd.com>
 <SA3PR12MB790204F7976709B88A9302BF8B352@SA3PR12MB7902.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <SA3PR12MB790204F7976709B88A9302BF8B352@SA3PR12MB7902.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4085:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j43uqIOhzNaedpLwCooRdIgPmw5pExuVW+3Rqg5R4Rg130ocmGbPlLp9Oi3aeBdgby7exCK64qbmKwcPlmXDiXoUJmynbdcdYD0O4L8o0x4QKdZNhgJq+NiPktBLC1b+jSqCy/VA6hgkUY5ji+wm05pyK+XJuW28q9ydQTH/Hxyc/EYCDmoVODfYS+duNY+NcKELAKrNMpMYq37TRcerIXNqsXKvB9x86HLDaG0snDnpGYwxPfplYQ9wNaeoK/3juqsUiFj0COmZ4bA6xJfdQ3o2dj7ctgiBu8BmJkArR7Q9/3SxhECmd++bpnZ5raJFlPQPONBZOFw+Cku5hLGalECkSiSIoXkfBW8Q5CGknOPExa43Ok3z1SnsJ+iDoO9uhvPIpzOmjE1LMsPyQ28pnqU++OLBn7RyfKJundxvxBxgrPut0S7P3ZzHiivWOwCLu+QF+2D/bLyerJr3hPOvfqGRDlinpcylDZhYiSB0khYC7ZkoH0Qf3oy6j4ywiheKfduREup/FDSO+8U2LRPEv5BmBGLWdq5Z9aRzcoKSv+QB3q8kbemmqHtj4HAh/6s6qv09do6V+3YXMX+IAYLzHuuGETeS7ukHXunU/TzojFT0Fb32L8Dtq+P+OgI+3JpMCnTJa3AXPwW0rSXBaqU/bN2hzJxVKIjN4a6mGlTZLEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVIMmpjd1FTbjJiaVhIZC9Wd2pDNkhZaGNSRzI3UlFYNTJ4WDAxOU1rdUFK?=
 =?utf-8?B?ZDJtUityR3lndmNZQm5HL2VKQnVuSitjRXRSM3VuN0cxcEJJR1VKcERoeDVo?=
 =?utf-8?B?bmFJZzRyU1I5VkxGWTZMNmYwZXNsMkErWXFlNG9FSjliSTBNL1ZDS0tFck9a?=
 =?utf-8?B?L3BzVE5kWlF1RXVNMUFFa0o2TFNiVlg3R1VCY3Nadm1PSStzS1YzTTVjWGhI?=
 =?utf-8?B?Y3NWWEdraHRHVm1YWmxVME5LeGNQV3MwdkxiVUNKYWozdXlERWNCSTJXWDJl?=
 =?utf-8?B?WWFyeXpobFZIZkxXRzBjZ3BOdGFwLzB5bHRtSlVCUFNZa0RQYmxwb1J1RXZO?=
 =?utf-8?B?aVdRTUJiN3phMnUwaTArc1FQUkpvdVZyWXQyQ0Q1V2xRS2pwZWQyakNLcFQ5?=
 =?utf-8?B?cGx6Q09QMG81U3N2bElKRmlMZVpVUCtWODhZa3JVcDRWd3dINVhNcFBaNkI3?=
 =?utf-8?B?bEZlNWUvbkZiazRMbHYrQXpFRUN6dzgxS1ZEc0x2SFBDcUZhd0xOMDQ3QVVD?=
 =?utf-8?B?Vis3a1o3ckhNNldMcFdJbFQ1TmgvR2x1TGZId3RDZ3VnMURFT1IzRCtkc0kz?=
 =?utf-8?B?OEpLblNoYWhZdnplSHQ0dlpob2dzQk9pRGYzMnZJRFY0aE5yT2MvdVp2cFlw?=
 =?utf-8?B?ZFdYR1NDeFZrTWdzcFFjLy9hTzhkQnlFQ1RTdmwyTWkrY1QwbkFKelNLaTl3?=
 =?utf-8?B?aU9xQjF5Y0lwN2kzOEp1MWRoV0NPNW90Z3FCT2VVZjZNcWlUNzJVa2NTUmsx?=
 =?utf-8?B?MmFqZ2tXanNOa01yZ0ZlaDBWZ0tIVTNEZEh6MGpSZzRSdlNEa2trVkNNMEhL?=
 =?utf-8?B?d1RsNEd6NFNsMmJKY2Rvb0xNbDd6NnMwRXpyVjh1UmEweWZTcWhTWGJQbjJQ?=
 =?utf-8?B?N1EwVzN5Q1hhOUowcWE0ckIrTEFjNnErc3ZSM2lPNURKN2w2K1hLRm8rbVhB?=
 =?utf-8?B?YUlwWGRaVWtUR2xzYmMvbGQ4TGd4b0QwS1RnRkNPL1krN1d3U2ZraDdoc3lL?=
 =?utf-8?B?aDI4dVJxQms2bDlKcHhBOEk0ejBPOGZMTXlVV3prY05ONzk4L3oxNHZycURz?=
 =?utf-8?B?aU5sZDh2Yk1BL2dPcVMxakxuT1lRRVJEdTBEMmg5cXhWR2VlR2dvM2xKMFJQ?=
 =?utf-8?B?eElMdDZsb25JbUx5bm9BcTNXSmRuaFQzMUpoZkQwY1JBVWp5MHRkYWNWSXJ5?=
 =?utf-8?B?QzFHWVEzT0svUDVENFBWOVZYUENVakQvZVJlT1BmV2dwSjZkSzZSRDhmSGxl?=
 =?utf-8?B?K0tQQlB3YkxBNWRYM2tmWUdhOTdGOXJza1d4TFFvNWZKVFVjR2haZ1Rja0Vq?=
 =?utf-8?B?WFBCZFpScXMrVTY2VFhzZ2pOMVlZdzhyRjdrUThFRlB1RVM5aHV3anNwdFEw?=
 =?utf-8?B?NnFHNlgvN1phTjkzaTV2dFh0QjBGNlZCRjlyYmxsNUFhb2tJZmhiUnRpRWx6?=
 =?utf-8?B?bW9IbTVGUHpiNUNwMmdlclQvbVM2eitxWXVwUS84L1d5WHZvTlF6UDlQd1Ju?=
 =?utf-8?B?VzBzNW85RHgvYXJ4VEVFdVVueDU5eGVscnUrc0cwTnBhd2JIY3NpSGJQa0xI?=
 =?utf-8?B?YmNJeUJBYUd5eDA3N1FhWDBiSXJSZmg2ZWQra2pRMm05eGxVY0ZXWXhlL0tv?=
 =?utf-8?B?WDY3dDUrM1AzUmh1dGV4Vkx6LzRya3JKQ1hWTU5Dc3hPN3gwd0NhSXkvaFZM?=
 =?utf-8?B?U3RGckgzeTBKaEJPUGR2dHRzQTJ2TU5sMnNieE1YQUtkU1FvazJDNmViYThE?=
 =?utf-8?B?L0dDWXVET1prNU5YSXEzczdPdGVLTnNoM2paTVBxcXRzZjl2cnRtS3hlVFIx?=
 =?utf-8?B?TlZ1UzRqWk5aVk9YU3ZDR1ZPK1VKY2pBRWMxWE1hQ3B3UVFLdjJrZ0FaR3l1?=
 =?utf-8?B?S25CKy8yR2dvaXN4SUFHUkQyY202RHZ2UkdSRy82VzFYZnRPRVYzSzFvYWlk?=
 =?utf-8?B?WEFyOTlSZ09ieXBrOCtJQzc4azhUOW93eGpFai94T2JSd3dXNmx6RkRaR21O?=
 =?utf-8?B?TDgweWMrcEVieVd4emFLaWc1ZUtqbDZ2N25HZUFYbE0rR0k0OFhnRlU2bU9Y?=
 =?utf-8?B?UEZkVXBLakNjeUhhbDZJZS8zc2ZhVTdBdHFYNzJFenkyaXBucExMdjFENFd5?=
 =?utf-8?Q?jVitHbBN38PA4XT4A/UhGSa+b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857e73fa-91aa-41b0-ff07-08dc4db2a5e0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 16:34:46.3362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4HOlKe6HfjC6/f/8B20qfv/zQKqDSyJhr0RA88ounfyn0qYWDS0rLC5vB0DMKNivm0WXtU/8MWQP2m0yw6v8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

--------------New1LBWGmTQvfDcOVdU96LLi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-26 12:04, Alam, Dewan wrote:
> [AMD Official Use Only - General]
>
> Looping in +@Zhang, Zhaochen
>
> CAM control register can only be written by PF. VF can only read the register. In SRIOV VF, the write won't work.
> In SRIOV case, CAM's enablement is controlled by the host. Hence, we think the enablement status should be decided by the register reading.

Thank you for clarifying that. With that in mind, I would suggest 
changes to the commit headline and description to avoid confusion:

drm/amdgpu: Confirm IH retry CAM enablement by reading the register

Under SRIOV, the IH CAM cannot be enabled by the guest. The host controls
this register. In the guest driver, read the register to confirm whether
the CAM was enabled.

Regards,
   Felix


>
> Thanks,
> Dewan
>
> -----Original Message-----
> From: Kuehling, Felix<Felix.Kuehling@amd.com>
> Sent: Wednesday, March 13, 2024 3:46 PM
> To: Alam, Dewan<Dewan.Alam@amd.com>;amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking<Hawking.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
>
> On 2024-03-13 13:43, Dewan Alam wrote:
>> IH Retry CAM should be enabled by register reads instead of always being set to true.
> This explanation sounds odd. Your code is still writing the register first. What's the reason for reading back the register? I assume it's not needed for enabling the CAM, but to check whether it was enabled successfully. What are the configurations where it cannot be enabled successfully?
>
> Two more nit-picks inline ...
>
>
>> Signed-off-by: Dewan Alam<dewan.alam@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 15 +++++++++++----
>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> index b9e785846637..c330f5a88a06 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>> @@ -337,13 +337,20 @@ static int vega20_ih_irq_init(struct
>> amdgpu_device *adev)
>>
>>        /* Enable IH Retry CAM */
>>        if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
>> -         amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
>> +         amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
>> +{
>>                WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
>>                               ENABLE, 1);
>> -     else
>> +             adev->irq.retry_cam_enabled = REG_GET_FIELD(
>> +                     RREG32_SOC15(OSSSYS, 0,
>> +                             mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN),
>> +                             IH_RETRY_INT_CAM_CNTL_ALDEBARAN, ENABLE);
>> +             } else {
> Indentation looks wrong here.
>
>>                WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
>> -
>> -     adev->irq.retry_cam_enabled = true;
>> +             adev->irq.retry_cam_enabled = REG_GET_FIELD(
>> +                     RREG32_SOC15(OSSSYS, 0,
>> +                             mmIH_RETRY_INT_CAM_CNTL),
>> +                             IH_RETRY_INT_CAM_CNTL, ENABLE);
>> +             }
> Wrong indentation.
>
> Regards,
>     Felix
>
>>        /* enable interrupts */
>>        ret = vega20_ih_toggle_interrupts(adev, true);
--------------New1LBWGmTQvfDcOVdU96LLi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-03-26 12:04, Alam, Dewan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SA3PR12MB790204F7976709B88A9302BF8B352@SA3PR12MB7902.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[AMD Official Use Only - General]

Looping in +@Zhang, Zhaochen

CAM control register can only be written by PF. VF can only read the register. In SRIOV VF, the write won't work.
In SRIOV case, CAM's enablement is controlled by the host. Hence, we think the enablement status should be decided by the register reading.</pre>
    </blockquote>
    <p>Thank you for clarifying that. With that in mind, I would suggest
      changes to the commit headline and description to avoid confusion:</p>
    <pre>drm/amdgpu: Confirm IH retry CAM enablement by reading the register

Under SRIOV, the IH CAM cannot be enabled by the guest. The host controls
this register. In the guest driver, read the register to confirm whether
the CAM was enabled.
</pre>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:SA3PR12MB790204F7976709B88A9302BF8B352@SA3PR12MB7902.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Dewan

-----Original Message-----
From: Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Sent: Wednesday, March 13, 2024 3:46 PM
To: Alam, Dewan <a class="moz-txt-link-rfc2396E" href="mailto:Dewan.Alam@amd.com">&lt;Dewan.Alam@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>
Subject: Re: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read

On 2024-03-13 13:43, Dewan Alam wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">IH Retry CAM should be enabled by register reads instead of always being set to true.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">This explanation sounds odd. Your code is still writing the register first. What's the reason for reading back the register? I assume it's not needed for enabling the CAM, but to check whether it was enabled successfully. What are the configurations where it cannot be enabled successfully?

Two more nit-picks inline ...


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: Dewan Alam <a class="moz-txt-link-rfc2396E" href="mailto:dewan.alam@amd.com">&lt;dewan.alam@amd.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 15 +++++++++++----
  1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index b9e785846637..c330f5a88a06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -337,13 +337,20 @@ static int vega20_ih_irq_init(struct
amdgpu_device *adev)

      /* Enable IH Retry CAM */
      if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
-         amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
+         amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
+{
              WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
                             ENABLE, 1);
-     else
+             adev-&gt;irq.retry_cam_enabled = REG_GET_FIELD(
+                     RREG32_SOC15(OSSSYS, 0,
+                             mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN),
+                             IH_RETRY_INT_CAM_CNTL_ALDEBARAN, ENABLE);
+             } else {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Indentation looks wrong here.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">              WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
-
-     adev-&gt;irq.retry_cam_enabled = true;
+             adev-&gt;irq.retry_cam_enabled = REG_GET_FIELD(
+                     RREG32_SOC15(OSSSYS, 0,
+                             mmIH_RETRY_INT_CAM_CNTL),
+                             IH_RETRY_INT_CAM_CNTL, ENABLE);
+             }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Wrong indentation.

Regards,
   Felix

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
      /* enable interrupts */
      ret = vega20_ih_toggle_interrupts(adev, true);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------New1LBWGmTQvfDcOVdU96LLi--
