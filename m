Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EACC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 13:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADDC10E11B;
	Tue, 24 May 2022 13:26:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4483010E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 13:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7/ii+6ABJSs+LXC5gnELmlK36eg7sYBQP3dNZVbExN//w9iN7LgPkFdTiVkyEgY7xLsiJDx16azijoYVe4cR0QDlWEIe7Lo8QnsYMQXKpuhGDhzUhM6AI+E5NvdB7FtHvV4q00PWtn59oacpTGXAI43kuLFV7Jn9j+8UFStDXvXqzq1MluEEDbQD9jMDtDY722mTUmtU/sDDiO2eHII53JrnRNaeCJLjTEy2Kj7OIKSlKWRUwNscRxCtvcNoOpcFOkRap1Lqk4ageDdoGbAY60oMBibMNv73I5QzXW4ArY7mLWkBp6+NiWn4zt1UBNRHzeMQ2xm7+KnjzMwXUe44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqH/Z5f/yX+aYEe4WZRkclIw6JbJparfJPaObIbpp38=;
 b=kVRiMQ8hSlWiZGOI10/9qXn4MRr0EerQ+uAWYA3a9HiFkh/lxnWb9s2yzblL0e2d95YvWrFot9dUMjnUFcR8zK8n5lrvI3q67/gAzeyxOdcgZVtMRPIudSTArrESMl4FABINAAHls0OCwT0HP7iWnQ1QSLnwOW/5xVGX6fc6V0G2NCU1gA29nMICIWsZROrtv2tVdYvsJS6FIM8rfh/PGK2VyaZALbPxe2umninBPUfVZaDn+V+swInRMWF33ruf8xvtm4waCFDSV8+mM+wIq197KCjP7sv6f+mxeGcvdCdDwPIk6zYjTtKnyPTkJchHOE1g4c1pcQc/YLW6drI4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqH/Z5f/yX+aYEe4WZRkclIw6JbJparfJPaObIbpp38=;
 b=wZRr88HWwsvgeB7tbJQD/9/T5kbCR2I/vyeBLpKmM7mzZs6QvTmGxtF5FAD8K4IaIdszJY1Idh8l2vsEfr9QabZYDGrUwYXPHMnjGh1PiXR1DdIsbW51EOqXDAGfGrkK9HUbJ6wdNuuF0EQCUaiIgrBztXRl2iThH2VH2nLRFT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1702.namprd12.prod.outlook.com (2603:10b6:903:11f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 13:26:03 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c59:9713:48a5:da53%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 13:26:03 +0000
Message-ID: <343298d6-f023-a57d-1ef5-259ba991d8d9@amd.com>
Date: Tue, 24 May 2022 18:55:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Return auto perf level, if unsupported
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220524123614.1487039-1-lijo.lazar@amd.com>
 <CADnq5_MHNLHuxLrKheqgcB4_AsaVGrJRGB+1y7LgbHLnV=4ftw@mail.gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MHNLHuxLrKheqgcB4_AsaVGrJRGB+1y7LgbHLnV=4ftw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f267c29-1881-423b-3c95-08da3d88f2f5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1702:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1702854BD22802CDD3B3C92A97D79@CY4PR12MB1702.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyR/d1tL4Wm7i8sDNCwfq1uhC035fK3bdKxeBspPEwl69RRzYPYSLLJOYCQN1n2RyKYw4eR8kef5sb1tla/ykL8g0xWHxCiCcFit4J075SHudtk8EHbZX9G1ELYD/aYfhgnLyyk8ugicCl+nlMIEbF3klfdr8Liuc5Kc9u/L4M73poQmR2lc5qWet9xiRB9E8j1L1wsEUtcbta8MnGkse09uUXzwuRbwGu/iAfmPyT4PpCKiOybMH0zipRQucicviYehY13FmHuBNe7kXXniIlJP3ua36kJvx9Sa14wErPJvkgOeCntRecjW9lxgTDv5ZwiSBNenGbOm4NjzIoizCmlLp3HVEA7paBM39HpNPmX+2njCD5Pgq2/WVzuvyC+I6KKkQjgf1n3UcQ4FoeZJBPRhdatWskA9AEQguBk440eNzhrOF75UjTpSK46KPnQQdK7pWyGS+ofZ2mpRzJ+bh1tvBnSELweJwyMl2oEY2qCe1yVgLHNFrRPUqxX9S27IK000U6MqrS6BZjDdvSsRhBwMfVH2PeJAlzO7R76n3JilVqtJ+o33QBxzebbfno16N8WV4IY78voxbmyoL68G0xD8jOJdEUEA88M0fxZfs1NpEfeq5mllOMMQ6xz+RgGjYkvtr5uHgZFMRcRhIaX6nUD8YRHNw9Cw0/zpphJn8oWEUKnfotWyJRgkv0XX7WUgbVf9mY0ldtg7LiYxFyZmOQE5YcYwg9Kxwt9BJ6Dfk1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(26005)(38100700002)(36756003)(8936002)(53546011)(2616005)(54906003)(6666004)(186003)(6916009)(6486002)(508600001)(6512007)(6506007)(316002)(83380400001)(8676002)(66556008)(66476007)(4326008)(86362001)(66946007)(2906002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dmenFuOEpEQVBIMjFJTmlBaUpVazNPL0FaU0d4M3o2YUgzU3Bqb1h5WU5G?=
 =?utf-8?B?bkZOcUhlYXhGWXVQV1dxZXByeHZRazhiMWJOSHFmenAxbjJtVWJWU2VFWGEy?=
 =?utf-8?B?dDhnQS9sdWVibUFFRWszdlVmTVlGeVgvcjdCTGpJMlAzTGZ5dHRiZ1c5NitJ?=
 =?utf-8?B?anVYWTdTTXdSVHIvRE5KaENyVUQ1MThTSFpLNmxRMEIvRTVYQ0VkWkxrT2Qr?=
 =?utf-8?B?dExpdFRWMlIrZ2VEd0kxM0oxbEh6UEc5N3ZFa213SWN1cVhnRXdzalUzT2Yz?=
 =?utf-8?B?QzY5VXNJMlBrQ211RDB1dXgxc2hUKzExcTZCbFR6L1Z5VHVyN3JadmFmbEFD?=
 =?utf-8?B?bm9lYXpabDdiT1lrZDhBRlNvNzRFa0w3ZDVpVXV0REZkb2pjNTJoY0k5d1NH?=
 =?utf-8?B?ekV2UEVjWTFDSElCUjlXU3ZHdGd3ZTZ5MlJXMm51LzF6RlBpQXNzRzIyOEIz?=
 =?utf-8?B?d0NjZ21IUUZOR2liWGczcFArdnE3Z21HL0hCTzBhRWs5UDhMWnpHdU9sNERL?=
 =?utf-8?B?TnFPMXhUTEg1ekxJRkpCOGJMc25DQW9KeklnUFNiMzcreW9GLyszMmJrYlZ2?=
 =?utf-8?B?bXRIOEZ3dW5sU2o4Yzl6N0VWRC9vaEhLTUdJR240MnJyajBXUW9sd1pFZjJV?=
 =?utf-8?B?MldCaFROcXF1SGtXYVVrbFUvNWk1bHlQNGsvajRTQ1RYR21uQnlJeHZPYi9m?=
 =?utf-8?B?anBlZGFkYTB4V0hjV2J2TlpDUEhXTnZ4ckNOQzVUZ080TGszQk11VjI5Q3NR?=
 =?utf-8?B?dFUveGo5TlBNbHB5STdnMGhuTzV0VkZaVXczWnpGVGtYaDZGTlY2UnNzajZF?=
 =?utf-8?B?ZVZqZjY1MmZndjZRT2F0cFpKVVhDRHFaZnNsNzVFWDd5M3Q4RG5KRkErSHBm?=
 =?utf-8?B?eHN2S2Jkbis2U0xvWjVidHhZaFZSTmtGY2NUMDJpQnNjSzBIYWFYTWp5NVJw?=
 =?utf-8?B?OWdnM2dvQmVrbzVZZnljRENreTJCNFFkTGZ5d3Rxa1Q5SmE1Ym5vRERWc1pV?=
 =?utf-8?B?Q3FHeHdZMWpMVzVKQjlMSG9ZRWRzcXN6OTVhKzdBUDBCbkRxSWFCZUhaTDRJ?=
 =?utf-8?B?RXRmajhMOVMyUSt2S042MWNYbjkyWlRZdzltQXlVSk5TUlNxNVlGekh1bjRO?=
 =?utf-8?B?bEovQVY5ekFNNkVpdVF0NUlOWXBQcHl4OEd5dENuSnhoY0ZVTUxlTURGL3JE?=
 =?utf-8?B?V0ZGTHlWYVlZaUkyNFc1OVR6QlRYM1FRUmpmd1ZYYkVsMkJENlFGaklpMjlT?=
 =?utf-8?B?K0VCanJvRzdoZWZXMHBacVdTR3RCM3MrUFR2V2dTTVVzUWx6NDlpQnJhNGFK?=
 =?utf-8?B?ZWtnalJRY1c0c1B2YnRGS3d4Q3RnVmljZnBLaFc2ZVd0SmhsOTBYa0VkNlh1?=
 =?utf-8?B?RkZNckpzb25kSU1sNURkejRVZk9KNk1NY2ZTOTE2NFdoZ2t1cE4vZGx5VW8x?=
 =?utf-8?B?V0sxalVpTHd0dXduUFMvZnBxLytaQlUrU1RtMDJuMm5FWEx3YlRBVDRxa0VQ?=
 =?utf-8?B?Q0paMURmQTFjRElBR1RXTTNEdkN6NWlDSC9HenlLS1RZdE50bUZLa1EwRUQv?=
 =?utf-8?B?L0lyWlhOYzVxNXlvcXVDRm0zeWpJcTV4d0pYWWI4ZDZPWUQwU2cvWFFnenBS?=
 =?utf-8?B?Y3Zzc29Cck1OeTIweFVvdnZ2NmJmT0lNVVdlRkpBaEhySmRJckl4VnJZclJ0?=
 =?utf-8?B?emMvcTJjWmlnUmQvRlpyOGduNGMrbjl5Nk1TdXVJcVBVUXA5UGY1Q1NGNmFF?=
 =?utf-8?B?a2VLZG1SVGN1Rm1vY2dlUW5oNE15dVMzeEhNN0ZSUlM5VUNkeXlKSHFqbHBD?=
 =?utf-8?B?M3p5MmFLUWlzcW54TmRGeGp5cFlyWjlHMTlPUDlvK2xRRWNsL05TQSs3MXV0?=
 =?utf-8?B?MDQ1Q0NMZG9pbGR4b3lRcnhNY0ZKb2hlTEhHVmFtMDRuMG92Y2dsU1JmWUtN?=
 =?utf-8?B?NmtOOHVudXBVanBVTVdzNVVNcXJlN1FUV0xlUXp6ZUxxM0FrS0Z4czFkR3dU?=
 =?utf-8?B?am5FajZKK3pZOWpEYkt3UVRvaVdSWDMvb0EvMGpqMmZNamt1YndiQUYzSy84?=
 =?utf-8?B?TXZHd0hrSVM3Y2FXN0IycFg5NFZ2UGEvUmhXcDd5Z0pjMjIwd3VYR25OYXVC?=
 =?utf-8?B?OUtvanZtK09Yb2RwejZUN1ZtZ3dSVnBUeTNIaXhpQ3QwT1RxdjI4RDNrMWlh?=
 =?utf-8?B?T2ZUSml6czBkVlRITmY4bXlSSkFYSTYzMGxxeTErQXBkNTlJRkRJSnVyeFV0?=
 =?utf-8?B?TmhEMXRBS0VGWFYra0R4WDU1MFRLUlpQUjV6R0FMMmxRMUZXTmg4SUVXZDQy?=
 =?utf-8?B?V1Q5a1owcld6citnc21hMUFvbGhYbXJaRVZVbWNiYWk5UW8zYi9XUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f267c29-1881-423b-3c95-08da3d88f2f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 13:26:03.0944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HYsIqcp6WkG8SC13LupQmqaDdRZxUZ2xFWq1dr1dWXWys609e44vOigfq7edrd9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1702
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/24/2022 6:49 PM, Alex Deucher wrote:
> On Tue, May 24, 2022 at 8:36 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> When powerplay is not enabled, return AUTO as default level.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 5472f9936feb..d1bf073adf54 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -770,6 +770,9 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
>>          const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>          enum amd_dpm_forced_level level;
>>
>> +       if (!pp_funcs)
>> +               return AMD_DPM_FORCED_LEVEL_AUTO;
> 
> Maybe LOW?  Either way,

Picked AUTO as that maps with AMDGPU_CTX_STABLE_PSTATE_NONE.

Thanks,
Lijo

> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> +
>>          mutex_lock(&adev->pm.mutex);
>>          if (pp_funcs->get_performance_level)
>>                  level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
>> --
>> 2.25.1
>>
