Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96A9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 03:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BA461056
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 03:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86BA461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5406E0EA;
	Fri, 29 Oct 2021 03:19:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9B26E0EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 03:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRXRR2xZBjDhdpE4LVpRC2+6ywGXN8h417MQOj554qNSt7WsKaQ4v1GplMahwTJII8AZQAV9cHh41E6oTQcReCiUC3qSNQo3y3IHwwdGtCn8336RrsVAWm3keZ3YFPNHkkeEgHFSYKgIOBB1FX4oWqjj9i3zLBL+1fuMmOgHibda2XbAmC/n4NCjwHoBILi533xVmkX9LThIrA04Cn+cOX0lciGJnP5uKppU64DvuIy9QcztIYvKQ9HuojFBlJtEqkGEjXpQdGRS3T50MRMQsprpOwwRsa6fSy4BsV701BelwyBgI6UpqZaJAEXew1Bv1dYLXPBmybwytuVUzXajNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esa+GjXtTzTiak5U+iZjhZ7ecmPqDrImI2jEsBq2P/Y=;
 b=E4KY/xHsgohbo9Kz8wST+T1r2EIi9JsbzTvZUtR6EkChxB4JbIMQS0sWmtGNP8R6p8haKrn2BH5b1NbYCsNcq+eQ7AuzaY2Nja3yBvX+HPHTyG1+uJuT1J4NhREFg3OS819s2CPVpU3SzAyzYbCzyjekucvKhvyy/l+nGS35zIAL70CZzrjS1o7V4VY+NylpUY0/tx79rmp9LccgXkIEkvp6rxD1fDI0ltOw5lBdnTSmwv5MEyodzzBda89XVFh8j+E0FgwDFxQGv5zXPdTDTQTZ6CorcnmUmjWwpUBjg68dNg1N1etgWpX4MZidfvk/riEeoy7+Nalg3VL6LAtrwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esa+GjXtTzTiak5U+iZjhZ7ecmPqDrImI2jEsBq2P/Y=;
 b=03X1rHvIql8n9aECHnhPBDy9Fj1UtP7xl4Ac7AQUncGS4TG04P1ONrsXbP6UjBq5MemXZCa+75ZM1xs21jBUxpTkLw61WoZywIDe6i5akUAxQr34Hc0kXjXiNNikto1LREF2RIoSRHNjRpmeLfhMQndqcIfIw3R//H5w018mKcQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 03:19:47 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::7cbc:2454:74b9:f4ea%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 03:19:47 +0000
Message-ID: <7c10a524-db12-4245-333f-3bc9141dda42@amd.com>
Date: Thu, 28 Oct 2021 22:18:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Huang Rui <ray.huang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20211028155336.2990-1-mario.limonciello@amd.com>
 <YXtd7LmF7Brsjrpk@hr-amd>
 <CADnq5_Oq_foFBO3fDCa=Zij53J_ULp=brHkMOm6h_9j0ow1J8w@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_Oq_foFBO3fDCa=Zij53J_ULp=brHkMOm6h_9j0ow1J8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::27) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [192.168.2.8] (76.251.167.31) by
 SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Fri, 29 Oct 2021 03:19:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa455e2-082b-4e64-5f61-08d99a8af5a8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25428537504500EB7E59323CE2879@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3CrfvqPEg2xpFy7Fd0eL7B3a4xOlerIVeQT/6SAbGgsTrvMvslZNOw16VvhmteI3UnvsVAyq3Pmv2iJBYF6pyzoa6JWnoz0Tnx4HIsMA1BVZyOBertEFM65MU6vgzTFBmHrZaxdAYhC2RdCv51PbEbMGKs8vy0sKkCweKpZgMF5t9nFRW2c7wDf7i9lLyBbqlF1FMuq0gak6ID1Pi6iHWDcejeN8KhCcODwHVWrTwOvh5lI0elUF4n52i/0NxzTQFpsB7hGjTA8Ctf3JbA+0bBj1dFDi2BMRD4RqNgIkUZs7SdlyhZZTmXeCUtTJPJB+5NLpCZa2SxxdtJo4XEez2+Egg3HbO7wq15gKZffZ0VSiHeQdBFfHHF0SIvh2d08nC1AmhyEtJiQnpbHarUJ9D6UGZcNy+5Gn1NlwbFGJKQDIY4kC5h/k+yUgf/UcaqD0ImnviM5NeCNiCDNPrww5K3YP/Ezc1/F1J3ZXjkvWhwV5iUeido0PuERzt0qBiBi6kspKN34RrRDXUnpJfK/NFw6TFsZruvwzioa2NMSJh3knROIYNlkSqaWwXjyKdxTlURp2Nwn2XdLOvh4CYGYfs5FTPGZ7hr57ChCkoT7ELzpyi6CZX4z4WW0UCHIPfGHD4/6KAM4Of8GQYKK4MmztN12gFc0tvUKUnI2FJ+lOwfqFqTBdObHeAFHuNp7ASQahDAmcWllvB1wX8Ib7yQJ7lXWj9rtvXxHGbvb5JSaqtbXZk2ER+5jI+tqpqC6mfbP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(53546011)(4326008)(316002)(86362001)(38100700002)(2906002)(31696002)(6636002)(2616005)(6486002)(26005)(110136005)(19627235002)(956004)(186003)(16576012)(30864003)(6666004)(66946007)(66556008)(508600001)(5660300002)(8676002)(66476007)(8936002)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1xZmhVcnF4cXNUMUtsVmM5RWRRV0p0MEt5Y1dHU01hZUNQRG1GZDFkMnVD?=
 =?utf-8?B?YjlMbjQyUHg3K3EzRTgzdk5WckRGTGJOZkhDZE9uTURzSno2cmcwTTdzeTZZ?=
 =?utf-8?B?MzcydDFuV3IyYnloeFNKRmFwT0ZqdnlraEtwaVFJNTd4NHg4MGFDb00wcFVZ?=
 =?utf-8?B?RnZjUWlVM2Q2MFptZ1MxRXU1KzZsVlZlWGEyZStxNXFhYUQwYjFjMXBlOThG?=
 =?utf-8?B?VFFZYm5hNlVlM1pjNTZwTnR5RXRZVjFmYVBDQ05pU1NQdmVHQU43ai94SW5H?=
 =?utf-8?B?Z1B5TFJ3VDFmQ0hIVDh5UEdkWW96MjduYTE2WUkvY1hudkhoMExYbTB0OHdy?=
 =?utf-8?B?b3crNGZWY1J5c3Y2OUFuRkJqWXB0d0FjL1VGMDBQTzNXOTRsb1NHcHhqd2tk?=
 =?utf-8?B?cUJVa25qNUVybkQ1QmhjRkZSZnY0M3hKSm1jcHVzNnRQQUtIcW42VVZtRU5M?=
 =?utf-8?B?VVVWQ1VMTXRGNDk1VWIzaFc1dE5NUktYL1lUSlFxQXBid08xbXJ1VnBqMS9l?=
 =?utf-8?B?dlNveGRXMllVTUJ0WUxncW5NQS9JanRGL1FHeGtSSG11YlNsbTNQN3ZEdHJZ?=
 =?utf-8?B?SDUwcHJTRHRqWVV4bk93RUhUOVFmN0pNdEt1YU1pOEpvLzc0TFV5TmR3MFBx?=
 =?utf-8?B?WlBHdkdsdWI3TWxtcUpHbVFUV1dIYW5iQTFPSStTYjcwRUFqY1J0QjhlcUx6?=
 =?utf-8?B?WmFWczQ2Z2pJNWRLT29ObU1sQ3FzTjFJNkZoM0FaUWYvRlZSQmFyVUJka0N2?=
 =?utf-8?B?SmNwdGdYdSs1UUExclZHR3NPQThPcklaSWUwcjJ0K1ZHbktUUjhUcjM3NXpF?=
 =?utf-8?B?SSsvampDWHBld1NvSGt6MU9iclk4YmNRL0JTL3lyOGVUaWc2bGs5WjRBcktW?=
 =?utf-8?B?Y2NVaWQ2NEkzOGZISHd2VGc5OU9XSlYvVStac0Q2ZGFjV0hnN0NOUGlVTXJh?=
 =?utf-8?B?eDFhbVFEdWpybnlpZ1pUR1JWUE5kcU5mNUNNQzZvcmlwc0hhL3lzRjk4QkN4?=
 =?utf-8?B?MWUwNVJ0Sk5GL0o2ZXcwUUQraGlpZHpTMS9MWmtSZXhML1FTaDdMQ0ovSE9v?=
 =?utf-8?B?cm8xM2ROSkgwSnRKOXE1U3ZacWN0d1IzNDIvZVF2L2Q0NnlycHJvYTJ5SDVK?=
 =?utf-8?B?WlNFTTl1UnVMQmJOMHVISUF1V3BzcFVpNGxlY2ZGUEJJRnhRUHVsL0xsQmFw?=
 =?utf-8?B?K1hYV0dPU2tDNnRVYXo4RExicDhOTVZDUFhHK3YxYTIvNmlwQkE1eWJ2QXl0?=
 =?utf-8?B?Ky9IMDhJdUZudE1YMVVsd3RXcTBNalpDOVNkUXRmOWVBWXBmTFhEYTduZ1pD?=
 =?utf-8?B?L0NjMVFYWjV5NU9XK2QxZ1N6SGRzUnFITTVSZDJUVmVXdHVNKzFndVdXOEZG?=
 =?utf-8?B?S2NrejdoRHNGcjBqRmJhUXlVVjNZT1dSVmo2TkJIeDU1STdEb3g1RlVGR1ZF?=
 =?utf-8?B?cUU2ODFCVzhFNlJBN1d2QmgxZUhPL0FaZFg2cUExNis0N25xR01lUjFrUG5D?=
 =?utf-8?B?Sk9RdnA3V1ZuYXBuNkYzU1V0RXNzbmNWZ1J2bVVQQWRRVnlGZDZuR2FaMXRG?=
 =?utf-8?B?elNZZFF1QnJRODFvTVIzOXZ6VFliYjFnc0plSHFJemp3Vm1JTFVkOUNmSVpz?=
 =?utf-8?B?V1NSR2VoNnNQcHZuWkU0d3o1eWVZZHhRVk80SEJSbi95ZElkZ3pyMUZnYldI?=
 =?utf-8?B?UEloMm9tcm9lcjQralJ1YTFPM2VHM3FvSW1kaHZuMlZadTBmeXZUVXF1WExE?=
 =?utf-8?B?cWNZMUVneFU1djFWTGVZU0YyZGVhbXZVT2pGdzNQckxNR3pmT0Fkd2Y5dG9k?=
 =?utf-8?B?SE1KaGl1SFNLT3BqenNRUnR0aElLTlZPbjA0R0dBejR4ODYxUGRQc0hVUkxm?=
 =?utf-8?B?ZFBKWWhjOGlINXNqT2wrWnJQbDRBNFQ2ZkY4N1A5aGtXTThaUGlFalY4S25j?=
 =?utf-8?B?RmtCekJyZS85SFFNdGEzd0JvcHdjbTNsSnZmMlRvMGJ2MHFLa1I2bXJCUHgv?=
 =?utf-8?B?Mzc0amFjd245d0R4ZEF4VWZYVEtxbGZMVkZXVE9WZGFzNEhZaUNKWkoyOGZN?=
 =?utf-8?B?REF2elhTRzJqQk1rYVd1ZEprZVRWUXVBQ0s0QkdoMWd6bUltZDZhWEFuMCsz?=
 =?utf-8?B?VnF4Y0FuV2daWkdNOWFnd1pUYWdLbHgydkEvUW5VSUFQQjVhWGxpTnhacEsz?=
 =?utf-8?Q?tMLskfm/F1bwUZ4h7ciMN44=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa455e2-082b-4e64-5f61-08d99a8af5a8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 03:19:46.9064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn7W8pDB8CntmtYcdb276ddn6qUIop0yKmCWgRV5TDNYvDGDh001wLR6JLYtORMnVRa1+0le6ZYG/3JWu8NdHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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

On 10/28/2021 22:08, Alex Deucher wrote:
> On Thu, Oct 28, 2021 at 10:35 PM Huang Rui <ray.huang@amd.com> wrote:
>>
>> On Thu, Oct 28, 2021 at 10:53:36AM -0500, Mario Limonciello wrote:
>>> Although this has been plumbed for Renoir, Green Sardine, Van Gogh,
>>> and Yellow Carp the functionality in the SMU doesn't do anything for
>>
>> I double confirmed them in the firmware. These messages are actually
>> existed in SMU firmware of Renoir, Van Gogh, and Green Sardine, we should
>> not remove them in these platforms.
> 
> I heard that at least on renoir variants, the messages still exist,
> but they no longer do anything. >
> Alex
> 
> 
>>
>> And for Yellow Carp, it is better to use a firmware check to skip the
>> function than remove them entirely in case somebody doesn't upgrade his/her
>> SBIOS.

For YC even on older SBIOS the function is a no-op and doesn't "do 
anything" from my understanding.

>>
>> Thanks,
>> Ray
>>
>>> these APUs.  Drop the associated code with them.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
>>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
>>>   .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
>>>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87 -------------------
>>>   4 files changed, 2 insertions(+), 262 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>>> index 1d3447991d0c..23d24173bc5d 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
>>> @@ -51,7 +51,7 @@
>>>   #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
>>>   #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
>>>   #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
>>> -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
>>> +#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
>>>   #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
>>>   #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
>>>   #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
>>> @@ -63,7 +63,7 @@
>>>   #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
>>>   #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
>>>   #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
>>> -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
>>> +#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
>>>   #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
>>>   #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
>>>   #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> index 421f38e8dada..2451d990d577 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>> @@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>>>        MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,               0),
>>>        MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                0),
>>>        MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,             0),
>>> -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          0),
>>>        MSG_MAP(SetHardMinIspiclkByFreq,        PPSMC_MSG_SetHardMinIspiclkByFreq,      0),
>>>        MSG_MAP(SetHardMinIspxclkByFreq,        PPSMC_MSG_SetHardMinIspxclkByFreq,      0),
>>>        MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        0),
>>> @@ -182,14 +181,6 @@ static struct cmn2asic_mapping vangogh_table_map[SMU_TABLE_COUNT] = {
>>>        TAB_MAP_VALID(DPMCLOCKS),
>>>   };
>>>
>>> -static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
>>> -};
>>> -
>>>   static const uint8_t vangogh_throttler_map[] = {
>>>        [THROTTLER_STATUS_BIT_SPL]      = (SMU_THROTTLER_SPL_BIT),
>>>        [THROTTLER_STATUS_BIT_FPPT]     = (SMU_THROTTLER_FPPT_BIT),
>>> @@ -1010,80 +1001,6 @@ static int vangogh_get_dpm_ultimate_freq(struct smu_context *smu,
>>>        return ret;
>>>   }
>>>
>>> -static int vangogh_get_power_profile_mode(struct smu_context *smu,
>>> -                                        char *buf)
>>> -{
>>> -     static const char *profile_name[] = {
>>> -                                     "BOOTUP_DEFAULT",
>>> -                                     "3D_FULL_SCREEN",
>>> -                                     "POWER_SAVING",
>>> -                                     "VIDEO",
>>> -                                     "VR",
>>> -                                     "COMPUTE",
>>> -                                     "CUSTOM"};
>>> -     uint32_t i, size = 0;
>>> -     int16_t workload_type = 0;
>>> -
>>> -     if (!buf)
>>> -             return -EINVAL;
>>> -
>>> -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
>>> -             /*
>>> -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
>>> -              * Not all profile modes are supported on vangogh.
>>> -              */
>>> -             workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                            CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                            i);
>>> -
>>> -             if (workload_type < 0)
>>> -                     continue;
>>> -
>>> -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
>>> -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
>>> -     }
>>> -
>>> -     return size;
>>> -}
>>> -
>>> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> -{
>>> -     int workload_type, ret;
>>> -     uint32_t profile_mode = input[size];
>>> -
>>> -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> -             return 0;
>>> -
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
>>> -                                     profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>> -                                 1 << workload_type,
>>> -                                 NULL);
>>> -     if (ret) {
>>> -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>>> -                                     workload_type);
>>> -             return ret;
>>> -     }
>>> -
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> -}
>>> -
>>>   static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
>>>                                          enum smu_clk_type clk_type,
>>>                                          uint32_t min,
>>> @@ -2190,8 +2107,6 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>>>        .set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
>>>        .system_features_control = vangogh_system_features_control,
>>>        .feature_is_enabled = smu_cmn_feature_is_enabled,
>>> -     .set_power_profile_mode = vangogh_set_power_profile_mode,
>>> -     .get_power_profile_mode = vangogh_get_power_profile_mode,
>>>        .get_dpm_clock_table = vangogh_get_dpm_clock_table,
>>>        .force_clk_levels = vangogh_force_clk_levels,
>>>        .set_performance_level = vangogh_set_performance_level,
>>> @@ -2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>>>        smu->message_map = vangogh_message_map;
>>>        smu->feature_map = vangogh_feature_mask_map;
>>>        smu->table_map = vangogh_table_map;
>>> -     smu->workload_map = vangogh_workload_map;
>>>        smu->is_apu = true;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> index 145f13b8c977..21da7989f1ba 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>>> @@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
>>>        MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
>>>        MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
>>>        MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
>>> -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
>>>        MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,              1),
>>>        MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,                  1),
>>>        MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,              1),
>>> @@ -120,14 +119,6 @@ static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
>>>        TAB_MAP_VALID(SMU_METRICS),
>>>   };
>>>
>>> -static struct cmn2asic_mapping renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
>>> -};
>>> -
>>>   static const uint8_t renoir_throttler_map[] = {
>>>        [THROTTLER_STATUS_BIT_SPL]              = (SMU_THROTTLER_SPL_BIT),
>>>        [THROTTLER_STATUS_BIT_FPPT]             = (SMU_THROTTLER_FPPT_BIT),
>>> @@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>>>        return ret;
>>>   }
>>>
>>> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
>>> -{
>>> -     int workload_type, ret;
>>> -     uint32_t profile_mode = input[size];
>>> -
>>> -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> -             return 0;
>>> -
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             /*
>>> -              * TODO: If some case need switch to powersave/default power mode
>>> -              * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
>>> -              */
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>> -                                 1 << workload_type,
>>> -                                 NULL);
>>> -     if (ret) {
>>> -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
>>> -             return ret;
>>> -     }
>>> -
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> -}
>>> -
>>>   static int renoir_set_peak_clock_by_device(struct smu_context *smu)
>>>   {
>>>        int ret = 0;
>>> @@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
>>>        return 0;
>>>   }
>>>
>>> -static int renoir_get_power_profile_mode(struct smu_context *smu,
>>> -                                        char *buf)
>>> -{
>>> -     static const char *profile_name[] = {
>>> -                                     "BOOTUP_DEFAULT",
>>> -                                     "3D_FULL_SCREEN",
>>> -                                     "POWER_SAVING",
>>> -                                     "VIDEO",
>>> -                                     "VR",
>>> -                                     "COMPUTE",
>>> -                                     "CUSTOM"};
>>> -     uint32_t i, size = 0;
>>> -     int16_t workload_type = 0;
>>> -
>>> -     if (!buf)
>>> -             return -EINVAL;
>>> -
>>> -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
>>> -             /*
>>> -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
>>> -              * Not all profile modes are supported on arcturus.
>>> -              */
>>> -             workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                            CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                            i);
>>> -             if (workload_type < 0)
>>> -                     continue;
>>> -
>>> -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
>>> -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
>>> -     }
>>> -
>>> -     return size;
>>> -}
>>> -
>>>   static int renoir_get_smu_metrics_data(struct smu_context *smu,
>>>                                       MetricsMember_t member,
>>>                                       uint32_t *value)
>>> @@ -1389,11 +1305,9 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>>>        .dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
>>>        .dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
>>>        .force_clk_levels = renoir_force_clk_levels,
>>> -     .set_power_profile_mode = renoir_set_power_profile_mode,
>>>        .set_performance_level = renoir_set_performance_level,
>>>        .get_dpm_clock_table = renoir_get_dpm_clock_table,
>>>        .set_watermarks_table = renoir_set_watermarks_table,
>>> -     .get_power_profile_mode = renoir_get_power_profile_mode,
>>>        .read_sensor = renoir_read_sensor,
>>>        .check_fw_status = smu_v12_0_check_fw_status,
>>>        .check_fw_version = smu_v12_0_check_fw_version,
>>> @@ -1429,7 +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
>>>        smu->message_map = renoir_message_map;
>>>        smu->clock_map = renoir_clk_map;
>>>        smu->table_map = renoir_table_map;
>>> -     smu->workload_map = renoir_workload_map;
>>>        smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
>>>        smu->is_apu = true;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> index a403657151ba..8215bbf5ed7c 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>> @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] =
>>>        MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,                 1),
>>>        MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,                   1),
>>>        MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
>>> -     MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
>>>        MSG_MAP(PrepareMp1ForUnload,            PPSMC_MSG_PrepareMp1ForUnload,      1),
>>>        MSG_MAP(SetDriverDramAddrHigh,          PPSMC_MSG_SetDriverDramAddrHigh,        1),
>>>        MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverDramAddrLow,         1),
>>> @@ -135,14 +134,6 @@ static struct cmn2asic_mapping yellow_carp_table_map[SMU_TABLE_COUNT] = {
>>>        TAB_MAP_VALID(CUSTOM_DPM),
>>>        TAB_MAP_VALID(DPMCLOCKS),
>>>   };
>>> -
>>> -static struct cmn2asic_mapping yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,         WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,                WORKLOAD_PPLIB_VIDEO_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,                   WORKLOAD_PPLIB_VR_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,              WORKLOAD_PPLIB_COMPUTE_BIT),
>>> -     WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,               WORKLOAD_PPLIB_CUSTOM_BIT),
>>> -};
>>>
>>>   static int yellow_carp_init_smc_tables(struct smu_context *smu)
>>>   {
>>> @@ -543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct smu_context *smu,
>>>        return 0;
>>>   }
>>>
>>> -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
>>> -                                             char *buf)
>>> -{
>>> -     static const char *profile_name[] = {
>>> -                                     "BOOTUP_DEFAULT",
>>> -                                     "3D_FULL_SCREEN",
>>> -                                     "POWER_SAVING",
>>> -                                     "VIDEO",
>>> -                                     "VR",
>>> -                                     "COMPUTE",
>>> -                                     "CUSTOM"};
>>> -     uint32_t i, size = 0;
>>> -     int16_t workload_type = 0;
>>> -
>>> -     if (!buf)
>>> -             return -EINVAL;
>>> -
>>> -     for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
>>> -             /*
>>> -              * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT.
>>> -              * Not all profile modes are supported on yellow carp.
>>> -              */
>>> -             workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                            CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                            i);
>>> -
>>> -             if (workload_type < 0)
>>> -                     continue;
>>> -
>>> -             size += sysfs_emit_at(buf, size, "%2d %14s%s\n",
>>> -                     i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
>>> -     }
>>> -
>>> -     return size;
>>> -}
>>> -
>>> -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
>>> -                                             long *input, uint32_t size)
>>> -{
>>> -     int workload_type, ret;
>>> -     uint32_t profile_mode = input[size];
>>> -
>>> -     if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
>>> -             dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
>>> -                     profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>>> -             return 0;
>>> -
>>> -     /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>>> -     workload_type = smu_cmn_to_asic_specific_index(smu,
>>> -                                                    CMN2ASIC_MAPPING_WORKLOAD,
>>> -                                                    profile_mode);
>>> -     if (workload_type < 0) {
>>> -             dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on YELLOWCARP\n",
>>> -                                     profile_mode);
>>> -             return -EINVAL;
>>> -     }
>>> -
>>> -     ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>>> -                                 1 << workload_type,
>>> -                                 NULL);
>>> -     if (ret) {
>>> -             dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>>> -                                     workload_type);
>>> -             return ret;
>>> -     }
>>> -
>>> -     smu->power_profile_mode = profile_mode;
>>> -
>>> -     return 0;
>>> -}
>>> -
>>>   static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
>>>                                                void **table)
>>>   {
>>> @@ -1238,8 +1154,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
>>>        .read_sensor = yellow_carp_read_sensor,
>>>        .is_dpm_running = yellow_carp_is_dpm_running,
>>>        .set_watermarks_table = yellow_carp_set_watermarks_table,
>>> -     .get_power_profile_mode = yellow_carp_get_power_profile_mode,
>>> -     .set_power_profile_mode = yellow_carp_set_power_profile_mode,
>>>        .get_gpu_metrics = yellow_carp_get_gpu_metrics,
>>>        .get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
>>>        .get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>>> @@ -1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
>>>        smu->message_map = yellow_carp_message_map;
>>>        smu->feature_map = yellow_carp_feature_mask_map;
>>>        smu->table_map = yellow_carp_table_map;
>>> -     smu->workload_map = yellow_carp_workload_map;
>>>        smu->is_apu = true;
>>>   }
>>> --
>>> 2.25.1
>>>

