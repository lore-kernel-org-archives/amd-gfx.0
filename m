Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171E2C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 16:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C45210E4FB;
	Tue,  7 Jul 2026 16:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2C35kCp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0554C89D4D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 16:25:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9zHw6y8Q0y/uG/SVYifFa1tpfpNRWW3PzWH4KCqDIctKrvJz/SFGD2kvEAQYGEFYCOGpZCDRdrS5cdeMF0Efz82H+w0CqLuir9m2Sy9sNzHsQN1RiSjNGE0n4xmeE5mi0vmki/kp4znrRLsLrquGEkC4S6+3S9HlkRFM5ieVWIYbl1rl0pWPfuWBrMcV5uhyp8u5yqAJAHuo1qHKbZy92Z0hkg1gaxSKTTez92JT/esC4XUa44wvwwAMKIz9WYJrI/vH8EPqW+dIlhUz2vjyXsC2W5lEchu36P6icLrmwIhJHv6HVNwhNbZR2YFfsNmwDsxXlbIZclMx0DjsSHUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XFLGPxqakv8LpqgyxDXihKrnDkEcuPXe1zUVj27lRQ=;
 b=cwfyCtXV6f+lvs9boaa/uZdNUrx3UqhUC6skOszBCOx0s1y+6nLfYCFbPKNNaD+jmr+9ZVUiWAuYcln/MHXr1/MzklzZlrcysSYY2ZJDq54atWD4PAULptpj327BhI3viWGRrFhjgdcdCvsMIBWJJgBA4tKVurEE9Pq/XK1qo6s2ekoxrQtpDwE53MZ0N6lkXppPDp6166vTlcmObt+eTSZiDfyIy/vYtXWsWve3gMP1GYnvO396+sBlmspuOLVlpCw7MxvOwc9CrvRCpV1M1C8FGfstmK8/P5CV5pnssvc8VpbE70+j98gVnmtHQofIfkEWNbvE36g3dHURlVDvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XFLGPxqakv8LpqgyxDXihKrnDkEcuPXe1zUVj27lRQ=;
 b=v2C35kCpTeHNEmuusjP0lPANg4+ofmAlr04bNJ+5lFlzn9Xpw2Nh5x88HZY3dvsyxGsOGDAVIx7AxcRRMZ7q8vxMdbcmArpCdxZbZ52N5ZSEKc0oiKo5ai65UXWtpYsq0sHZVEDzNKlI0xTdBgc4zENfNZ37D6b2I+H1128Rvog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 16:25:38 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 16:25:38 +0000
Content-Type: multipart/alternative;
 boundary="------------2bU2Gz5NyNKjg4M7VQvuMV3D"
Message-ID: <c16e8451-5d2c-4a36-93ab-a345739c3a1c@amd.com>
Date: Tue, 7 Jul 2026 12:25:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gx12.1: Add ip dump support
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
 <CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com>
X-ClientProxiedBy: YT3PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::26) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: dca0cf84-881e-4a96-e961-08dedc4460c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|8096899003|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: sfRBmbuh9+RXp+5vMKB4N3YIOe4yyqrQxFjGUE5TFBwAoFRjv1xzIlS6MR3jXLIwCwQbO8Lt3zJz+o+WJeIQWw+FsE918DPUqipXRSfdiD7N9SKlF1ItKvoXNkrswhjaTBNrMdkpKQBukZNQOqWa+qbAYCFJNDuVcjMYmtgpA7kfRhLECatbLXtwakGmR21vqB4a/GkCrZAaQzICgmLAfypKTBcnfCGPhRJEaYycuF36qwHtcIiQq/c6q8bLLQg62CbdyhLF9HRcXjXkXZF326Bls9tzM66j9GLkwr9P33ufPIwI7dvrnFWDBZuK/yZwytne14GK7hnozES6KPtlOIDqD3trGaTeviS1FFhNW5EcSocJQ2py+3NJ5pCJTKeCQGY8CFP7/4BGC/9rhU1OmXRGyjR3dFbATAQtuOs8+rsUJPwz46dadFvZsdioyiD9uLwQqB3ybKLQMPrslojWeonruXqOgkrfB60gFhrLW7xvzBP+dPHtRTAbmZW41htkfCCdvuMtQuWkeHCmD3hyAuieb7pp0RnHEWqmIQiZucIj52hdB5wWntFz6t986MfzUoIebWfrSbKhWffuRqOfUDG/ju9xzAbXaIC+Rwx7vUky/wGkEWZNn1eKNs9QauYPbRJ3gR/SNMBDMH1n05i0TCfsP2dOb/r7CQqZooGrIgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(8096899003)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHY5eEpKbjZ3WDdJOEMwK3F3RlREZ0V0NlI5dE9EM1VHY2V0V2themd4R3pI?=
 =?utf-8?B?TzRXVEpFZU9uQnlIUW1QOGlVOHIvRUxVTndNbGpBL2lXNnVhZndXMEdEanlC?=
 =?utf-8?B?MDlsb1hyV09pVFNNTkdOMmQ3c0RHUXUwUWFHWE5PQnoxZVJNbFord2ZSU2tu?=
 =?utf-8?B?MTlCVWNxbG5XeWtmVHp0Z2xwNGU2KzVHR090a2hxQ2ZRQlRJN2IrM0EvK2c3?=
 =?utf-8?B?VklCSnprMUkyZnhUaWFXVW03WmsvQVFXV2oyL2xDN21LZUVQTEVnZjhHcGpz?=
 =?utf-8?B?VFNibytNWElPVUUvKzMwZGJHczB1WlFmYTUyTDYvUVNrd1NqUGdMZS9xMXlI?=
 =?utf-8?B?cnNObGdNVTA5YlA3WFdackN6ZUZIQ1E3aE9PNjJnUm9ucVl2L1psOVEzS3Rj?=
 =?utf-8?B?alBJeUR4MTRteG4wdmlPUzYvNEQrVjVXSTJqVkR5VTJndUF0MjVRZldHVnJS?=
 =?utf-8?B?RUg4dG90bUNpSnJEemVFMFp0ZW5YRDJPQ1FMSjBPL3FGaTREZVBTeUJNcTBE?=
 =?utf-8?B?eGliZlpHaHRGOFljWllxTkxScEJGU1l4NlBEZFkrTnJBSS81c0pyNEJLb3Bx?=
 =?utf-8?B?dEdtSW5nN3Z2RnFESWNEdXNOcjZ6RVVQS05BQkpMdVppWnZuWUxPVnpuUFk5?=
 =?utf-8?B?L3B2eExOOE1uZmUvcWVVeUZnUCtSaE4vVUhhOE1TZ2FWck4wV3dCeVdhVk4w?=
 =?utf-8?B?aEJzSVkyWXROSEtHYVNtalBndFJmK2pERndkZVFISWVqMW1ONFVVN2t0blkr?=
 =?utf-8?B?TTYrcGZON0tRUkVYdlA3SEo2Y0FPVnNDaDg2elJZenY3eWZpL0cvVStHaUMz?=
 =?utf-8?B?M2NodlVOWlZRQ3FEY0hLYVpUOFI5ZVBwOFdPSnBDVGptMldmSnBOY0ZDRE9v?=
 =?utf-8?B?OEtXYWpJMGtrOEJjWmpvaHpkZE9BZ1h6VXBxVVU1c2lKQ3AwcS8yZm9Lam56?=
 =?utf-8?B?dzVyNEwrK3lYSzIvTjUxSHJKTlpzTGZuRTQvbUk2VWs5NkVqQ0VIMkR3VUZr?=
 =?utf-8?B?VHlhTGc5akNXTHlFT2VpUVBEeTRKRm8vcWVhWjV1ZkFxUFRDN1BMR1M1MFJh?=
 =?utf-8?B?ZWNEOWRqSXhkemVjWG1BQ0J0eXVCWGdmYm5qNWwxWXdnUWJURFBzMTNBT3R3?=
 =?utf-8?B?cERKaGExdVRvSmlHZGFVSFBncjFvSVI4NEtzcjJkMjlEWmZwY2NPMEs0RElL?=
 =?utf-8?B?K3BuVTU5UzVvMWFqRDlzUitycWFiQkgvbzNJdmJCSmJJTS9EdmY5TlNwMjY0?=
 =?utf-8?B?MDhsck1ST2ljY29HVXF0N25nMGtPRE85YU9rRG9GRTdBNGRwNU4rRVhxbjFn?=
 =?utf-8?B?UkdnSUU1a3RRYXh5NUg5OU5lbkpvaFpsZGZrdnZWYjVNM1BockJFQ0tHNkN3?=
 =?utf-8?B?UlZWM3IzNFFzNXdKaDEwT3BuM2swejM0RmdCVHYzcmNZdDIvVEY0eitpaUQ1?=
 =?utf-8?B?eW9KNzFLTFlPKzJKNlo5TENOVzlIcTYxZEVGeTFyWDhhL3pOU0dUcm8yQnhw?=
 =?utf-8?B?dE8zbTlMOEI4VlpNdjhRenduUy94NUNuRmVXeDUvWDAvdU9oMktabVB1b21Z?=
 =?utf-8?B?aDVsY21OeGhsd0Z6c0FIRmtnTVFpd1Vmbmlqa3pneUsvT1BhemJOZEptNFNM?=
 =?utf-8?B?TUF0TWQ4eHZPTGFObmtZSmlQZURWU0dHdUlUcDRXWkRJb1RrWWNEMzk5Mkpo?=
 =?utf-8?B?VmlDMjBacmJnRnVyVXp0RW9hdVhtQ3V2RGd6U1VkMTQveU9hZFBORWljQnpi?=
 =?utf-8?B?dWhFWHpGSU12eitQUzdiRHY3VlhUQUFwY2Q2WFdJdUNWQjhEaG9nYUhwVG5Y?=
 =?utf-8?B?NktzWEljOXVwOEpzbG1rRzlOYm5ETGliOW55RTJTOEZCbG1QdGU2b0NmWXh6?=
 =?utf-8?B?cUdHYWh6cjIrTnNlRjBVWXpWVGIraUdZbGliWmdBazgxc3FHY2xxMVI2MnNn?=
 =?utf-8?B?MURVN0l3YlN6a3FFR2x2Yk5vVHEzVXR1YUw1SWt2YUhjOTdDS2pCbWY2ajQz?=
 =?utf-8?B?UFA5cUkvUTlzZVNjVm90RkpHbUhhNE5weDFzaEI4NUhWSDJOS3dFTzRWWDdP?=
 =?utf-8?B?VG02VlpxazRkWW4reWFSR1cxeGYraWloQS80SlltRnYwRGtTYWNHekNMMFNO?=
 =?utf-8?B?aHhWZW5SZEZpL24yTnBGSkM3N01SRWowNmJOYmRML0xpN3NtTGx0d2poSzlt?=
 =?utf-8?B?ZysvRHZLcHNhTldqekR1dUJFcGpuUGp5SVBiS0N4YjVtNmp4bVFIZmFWaG1H?=
 =?utf-8?B?eStlS3pBNnNMMmh0MEY1WllyTExaTTFnbm9jZ0VQQ2Z6dW9nM202UXd1SjZX?=
 =?utf-8?B?cXllcURya3RRZEtDMEMrbXlNd2lKeHVxbHdSRmpKMDFSQ3hHemRPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca0cf84-881e-4a96-e961-08dedc4460c8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:25:38.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGYtQv6KhnQwhsVdcs//gOtTMgArlqKCbh/76o8lWHSe+DIXH1N2ywZjest1m8epy1fn51sW+2Q7EgvkTbeXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
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

--------------2bU2Gz5NyNKjg4M7VQvuMV3D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

s/gx12.1/gfx12.1 in the patch headline.


On 7/6/2026 11:01 AM, Alex Deucher wrote:
> Ping?
>
> On Mon, Jun 29, 2026 at 4:28 PM Alex Deucher<alexdeucher@gmail.com> wrote:
>> Ping?
>>
>> On Thu, Jun 18, 2026 at 5:04 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>>> Add support for dumping IP register state.
>>>
>>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
>>>   1 file changed, 275 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> index 5bdf2512f1540..ec4346a6c2af2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>>>           (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
>>>           (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>>>
>>> +
>>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
>>> +       /* cp header registers */
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
>>> +       /* SE status registers */
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
>>> +};
>>> +
>>> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
>>> +       /* compute registers */
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
>>> +       /* cp header registers */
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
>>> +};
>>> +
>>>   static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
>>>   static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>>>   static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
>>> @@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>>>          return 0;
>>>   }
>>>
>>> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
>>> +{
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>>> +       uint32_t *ptr, inst, num_xcc;
>>> +
>>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>>> +
>>> +       ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
>>> +       if (!ptr) {
>>> +               DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
>>> +               adev->gfx.ip_dump_core = NULL;
>>> +       } else {
>>> +               adev->gfx.ip_dump_core = ptr;
>>> +       }
>>> +
>>> +       /* Allocate memory for compute queue registers for all the instances */
>>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>>> +       inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>>> +               adev->gfx.mec.num_queue_per_pipe;
>>> +
>>> +       ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
>>> +       if (!ptr) {
>>> +               DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
>>> +               adev->gfx.ip_dump_compute_queues = NULL;
>>> +       } else {
>>> +               adev->gfx.ip_dump_compute_queues = ptr;
>>> +       }
>>> +}
>>> +
>>> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
>>> +                              struct drm_printer *p)
>>> +{
>>> +       struct amdgpu_device *adev = ip_block->adev;
>>> +       uint32_t i, j, k;
>>> +       uint32_t xcc_id, xcc_offset, inst_offset;
>>> +       uint32_t num_xcc, reg, num_inst;
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>>> +
>>> +       if (!adev->gfx.ip_dump_core)
>>> +               return;
>>> +
>>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>>> +       drm_printf(p, "Number of Instances:%d\n", num_xcc);
>>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>>> +               xcc_offset = xcc_id * reg_count;
>>> +               drm_printf(p, "\nInstance id:%d\n", xcc_id);
>>> +               for (i = 0; i < reg_count; i++)
>>> +                       drm_printf(p, "%-50s \t 0x%08x\n",
>>> +                                  gc_reg_list_12_1[i].reg_name,
>>> +                                  adev->gfx.ip_dump_core[xcc_offset + i]);
>>> +       }
>>> +
>>> +       /* print compute queue registers for all instances */
>>> +       if (!adev->gfx.ip_dump_compute_queues)
>>> +               return;
>>> +
>>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>>> +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n",
>>> +                  num_xcc,
>>> +                  adev->gfx.mec.num_mec,
>>> +                  adev->gfx.mec.num_pipe_per_mec,
>>> +                  adev->gfx.mec.num_queue_per_pipe);
>>> +
>>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>>> +               xcc_offset = xcc_id * reg_count * num_inst;
num_inst is never initialized here.
>>> +               inst_offset = 0;
>>> +               for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>>> +                       for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>>> +                               for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>> +                                       drm_printf(p,
>>> +                                                  "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
>>> +                                                   xcc_id, i, j, k);
>>> +                                       for (reg = 0; reg < reg_count; reg++) {
>>> +                                               drm_printf(p,
>>> +                                                          "%-50s \t 0x%08x\n",
>>> +                                                          gc_cp_reg_list_12_1[reg].reg_name,
>>> +                                                          adev->gfx.ip_dump_compute_queues
>>> +                                                          [xcc_offset + inst_offset +
>>> +                                                           reg]);
>>> +                                       }
>>> +                                       inst_offset += reg_count;
>>> +                               }
>>> +                       }
>>> +               }
>>> +       }
>>> +}
>>> +
>>> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +       struct amdgpu_device *adev = ip_block->adev;
>>> +       uint32_t i, j, k;
>>> +       uint32_t num_xcc, reg, num_inst;
>>> +       uint32_t xcc_id, xcc_offset, inst_offset;
>>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
>>> +
>>> +       if (!adev->gfx.ip_dump_core)
>>> +               return;
>>> +
>>> +       num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>>> +
>>> +       amdgpu_gfx_off_ctrl(adev, false);
>>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>>> +               xcc_offset = xcc_id * reg_count;
>>> +               for (i = 0; i < reg_count; i++)
>>> +                       adev->gfx.ip_dump_core[xcc_offset + i] =
>>> +                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
>>> +                                                                  GET_INST(GC, xcc_id)));
>>> +       }
>>> +       amdgpu_gfx_off_ctrl(adev, true);
>>> +
>>> +       /* dump compute queue registers for all instances */
>>> +       if (!adev->gfx.ip_dump_compute_queues)
>>> +               return;
>>> +
>>> +       num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
>>> +               adev->gfx.mec.num_queue_per_pipe;
>>> +       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
>>> +       amdgpu_gfx_off_ctrl(adev, false);
>>> +       mutex_lock(&adev->srbm_mutex);
>>> +       for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
>>> +               xcc_offset = xcc_id * reg_count * num_inst;
>>> +               inst_offset = 0;
>>> +               for (i = 0; i < adev->gfx.mec.num_mec; i++) {
>>> +                       for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>>> +                               for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>> +                                       /* ME0 is for GFX so start from 1 for CP */
>>> +                                       soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
>>> +                                                            GET_INST(GC, xcc_id));
>>> +
>>> +                                       for (reg = 0; reg < reg_count; reg++) {
>>> +                                               adev->gfx.ip_dump_compute_queues
>>> +                                                       [xcc_offset +
>>> +                                                        inst_offset + reg] =
>>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>>> +                                                                      gc_cp_reg_list_12_1[reg],
>>> +                                                                      GET_INST(GC, xcc_id)));
>>> +                                       }
>>> +                                       inst_offset += reg_count;
>>> +                               }
>>> +                       }
>>> +               }
>>> +       }
>>> +       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
>>> +       mutex_unlock(&adev->srbm_mutex);
>>> +       amdgpu_gfx_off_ctrl(adev, true);
Do we support GFX OFF on GFX 12.1? .
>>> +}
>>> +
>>>   static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>>>   {
>>>          uint16_t major_ver, minor_ver;
>>> @@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>>>          if (r)
>>>                  return r;
>>>
>>> +       gfx_v12_1_alloc_ip_dump(adev);
>>> +
>>>          r = amdgpu_gfx_sysfs_init(adev);
>>>          if (r)

You may want to free the IP dump memory if the sysfs init fails or do 
the alloc after the sysfs init.

Regards,

Mukul

>>>                  return r;
>>> @@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
>>>          gfx_v12_1_free_microcode(adev);
>>>          amdgpu_gfx_sysfs_fini(adev);
>>>
>>> +       kfree(adev->gfx.ip_dump_core);
>>> +       kfree(adev->gfx.ip_dump_compute_queues);
>>> +
>>>          return 0;
>>>   }
>>>
>>> @@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
>>>          .set_clockgating_state = gfx_v12_1_set_clockgating_state,
>>>          .set_powergating_state = gfx_v12_1_set_powergating_state,
>>>          .get_clockgating_state = gfx_v12_1_get_clockgating_state,
>>> +       .dump_ip_state = gfx_v12_1_ip_dump,
>>> +       .print_ip_state = gfx_v12_1_ip_print,
>>>   };
>>>
>>>   static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
>>> --
>>> 2.54.0
>>>
--------------2bU2Gz5NyNKjg4M7VQvuMV3D
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">s/gx12.1/gfx12.1 in the patch headline.</font></p>
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix">On 7/6/2026 11:01 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Ping?

On Mon, Jun 29, 2026 at 4:28 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Ping?

On Thu, Jun 18, 2026 at 5:04 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Add support for dumping IP register state.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 5bdf2512f1540..ec4346a6c2af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -69,6 +69,127 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_12_1_0_rlc_1.bin&quot;);
         (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 &lt;&lt; SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
         (3 &lt;&lt; SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))

+
+static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+       /* cp header registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+       /* SE status registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+};
+
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
+       /* compute registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+       /* cp header registers */
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+};
+
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
        return 0;
 }

+static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
+{
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+       uint32_t *ptr, inst, num_xcc;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+       ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+       if (!ptr) {
+               DRM_ERROR(&quot;Failed to allocate memory for GFX IP Dump\n&quot;);
+               adev-&gt;gfx.ip_dump_core = NULL;
+       } else {
+               adev-&gt;gfx.ip_dump_core = ptr;
+       }
+
+       /* Allocate memory for compute queue registers for all the instances */
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+               adev-&gt;gfx.mec.num_queue_per_pipe;
+
+       ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+       if (!ptr) {
+               DRM_ERROR(&quot;Failed to allocate memory for Compute Queues IP Dump\n&quot;);
+               adev-&gt;gfx.ip_dump_compute_queues = NULL;
+       } else {
+               adev-&gt;gfx.ip_dump_compute_queues = ptr;
+       }
+}
+
+static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
+                              struct drm_printer *p)
+{
+       struct amdgpu_device *adev = ip_block-&gt;adev;
+       uint32_t i, j, k;
+       uint32_t xcc_id, xcc_offset, inst_offset;
+       uint32_t num_xcc, reg, num_inst;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+       if (!adev-&gt;gfx.ip_dump_core)
+               return;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+       drm_printf(p, &quot;Number of Instances:%d\n&quot;, num_xcc);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count;
+               drm_printf(p, &quot;\nInstance id:%d\n&quot;, xcc_id);
+               for (i = 0; i &lt; reg_count; i++)
+                       drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                  gc_reg_list_12_1[i].reg_name,
+                                  adev-&gt;gfx.ip_dump_core[xcc_offset + i]);
+       }
+
+       /* print compute queue registers for all instances */
+       if (!adev-&gt;gfx.ip_dump_compute_queues)
+               return;
+
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       drm_printf(p, &quot;\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n&quot;,
+                  num_xcc,
+                  adev-&gt;gfx.mec.num_mec,
+                  adev-&gt;gfx.mec.num_pipe_per_mec,
+                  adev-&gt;gfx.mec.num_queue_per_pipe);
+
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count * num_inst;</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    num_inst is never initialized here.
    <blockquote type="cite" cite="mid:CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
+               inst_offset = 0;
+               for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+                       for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+                               for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+                                       drm_printf(p,
+                                                  &quot;\nxcc:%d mec:%d, pipe:%d, queue:%d\n&quot;,
+                                                   xcc_id, i, j, k);
+                                       for (reg = 0; reg &lt; reg_count; reg++) {
+                                               drm_printf(p,
+                                                          &quot;%-50s \t 0x%08x\n&quot;,
+                                                          gc_cp_reg_list_12_1[reg].reg_name,
+                                                          adev-&gt;gfx.ip_dump_compute_queues
+                                                          [xcc_offset + inst_offset +
+                                                           reg]);
+                                       }
+                                       inst_offset += reg_count;
+                               }
+                       }
+               }
+       }
+}
+
+static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
+{
+       struct amdgpu_device *adev = ip_block-&gt;adev;
+       uint32_t i, j, k;
+       uint32_t num_xcc, reg, num_inst;
+       uint32_t xcc_id, xcc_offset, inst_offset;
+       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+       if (!adev-&gt;gfx.ip_dump_core)
+               return;
+
+       num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+       amdgpu_gfx_off_ctrl(adev, false);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count;
+               for (i = 0; i &lt; reg_count; i++)
+                       adev-&gt;gfx.ip_dump_core[xcc_offset + i] =
+                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
+                                                                  GET_INST(GC, xcc_id)));
+       }
+       amdgpu_gfx_off_ctrl(adev, true);
+
+       /* dump compute queue registers for all instances */
+       if (!adev-&gt;gfx.ip_dump_compute_queues)
+               return;
+
+       num_inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+               adev-&gt;gfx.mec.num_queue_per_pipe;
+       reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+       amdgpu_gfx_off_ctrl(adev, false);
+       mutex_lock(&amp;adev-&gt;srbm_mutex);
+       for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+               xcc_offset = xcc_id * reg_count * num_inst;
+               inst_offset = 0;
+               for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+                       for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+                               for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+                                       /* ME0 is for GFX so start from 1 for CP */
+                                       soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
+                                                            GET_INST(GC, xcc_id));
+
+                                       for (reg = 0; reg &lt; reg_count; reg++) {
+                                               adev-&gt;gfx.ip_dump_compute_queues
+                                                       [xcc_offset +
+                                                        inst_offset + reg] =
+                                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+                                                                      gc_cp_reg_list_12_1[reg],
+                                                                      GET_INST(GC, xcc_id)));
+                                       }
+                                       inst_offset += reg_count;
+                               }
+                       }
+               }
+       }
+       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
+       mutex_unlock(&amp;adev-&gt;srbm_mutex);
+       amdgpu_gfx_off_ctrl(adev, true);</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    Do we support GFX OFF on GFX 12.1? .
    <blockquote type="cite" cite="mid:CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
+}
+
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
        uint16_t major_ver, minor_ver;
@@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
        if (r)
                return r;

+       gfx_v12_1_alloc_ip_dump(adev);
+
        r = amdgpu_gfx_sysfs_init(adev);
        if (r)</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>You may want to free the IP dump memory if the sysfs init fails
      or do the alloc after the sysfs init.</p>
    <p>Regards,</p>
    <p>Mukul</p>
    <blockquote type="cite" cite="mid:CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
                return r;
@@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
        gfx_v12_1_free_microcode(adev);
        amdgpu_gfx_sysfs_fini(adev);

+       kfree(adev-&gt;gfx.ip_dump_core);
+       kfree(adev-&gt;gfx.ip_dump_compute_queues);
+
        return 0;
 }

@@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
        .set_clockgating_state = gfx_v12_1_set_clockgating_state,
        .set_powergating_state = gfx_v12_1_set_powergating_state,
        .get_clockgating_state = gfx_v12_1_get_clockgating_state,
+       .dump_ip_state = gfx_v12_1_ip_dump,
+       .print_ip_state = gfx_v12_1_ip_print,
 };

 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
--
2.54.0

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------2bU2Gz5NyNKjg4M7VQvuMV3D--
