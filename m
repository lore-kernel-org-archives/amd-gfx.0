Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9BBC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 15:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F024B10EAB5;
	Thu, 20 Jun 2024 15:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="trwiyoVD";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C2710EAB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 15:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuTRK6I3bRPiORth3DONdCDlWNgyWy7MzAbHCy5O/we2MhmxCTcYJqhKQJfFASoQCbGM0VmwoWZafJmlGTmzeC/LOMeMQghvIKSZIZX2Yp96Paoq7v9M+DkO9C+guiU+4UpCiNOVamWoQOS4LKBYteJa1I7GC2Lp7MgsDt0EDCfG9wGNB4Q9By1JcTIbTK6g8uHgE+VGrmvyhaoLaVIgi9V8w4UZ57340c8DTR+TIkZh7tCj2ztaT+9jSx5WO7jNFOvU8te7ky4ckaBP4FfsRcpg9EmBlzPJGARwIyqEPOVKIPfxIIQ5meZnm7WgFz7GmRUYSVNduDjiiexKijNFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksFF/lKkHVvExAmmhCGqOVep/Letco5m6u/Mwjj2XfQ=;
 b=UNmoDMSF2o8FromvWGo+wz6Ev7VOIWJhJS2h/9YiY2+9+mQ9bUfW1uE9CGPT5lEJIRcgSyAh18f8STsSRNot/9Q83lbxOtaWllMMHnfS56LJtkNADZYtwUNmfP28qFfJdU2jd3jDC0GP3hrmsV+wZEumdL56p59RYFQ3vEXdqBQDigJf6SniA3hOEFUQO2fgx/jqqFHzN1dbdyOheK2tVvG+T3R6KyvVRNwZgZNLnIGJuE2qZElSYilMcSEjxB0ya3Ouqq95ILRCpOOc8zatp/NeeSj7vxCYcoBsvRggbGo8aZkDd1Hqn/XOZ98qqUjKPUF+D394DLDBmzgJ9G865w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksFF/lKkHVvExAmmhCGqOVep/Letco5m6u/Mwjj2XfQ=;
 b=trwiyoVDxNs+19rkBGkNH/2wPy86kuTT4M4R77vnm2KU6+IOpeKTTjkFjly2t6l6+l1FDgSEnrbmpx9FUOix6Rp2MX7C9M2t2ThwXIJTCz/1AJN3lCuVDNH1SF8PhL3WqOutY8oVOytQA/jNOEuXFNIoH/76x6avyWP3WfINTZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 15:48:38 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 15:48:38 +0000
Message-ID: <351e1524-9568-415b-bae5-ffb458a473cd@amd.com>
Date: Thu, 20 Jun 2024 11:48:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove redundant code and semicolons
To: amd-gfx@lists.freedesktop.org
References: <20240620081052.56439-1-jiapeng.chong@linux.alibaba.com>
 <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_NevWHt2p17WipaAmw1q-CzxCe_shYwSe3iLBx7KDV1zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::35) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1204fa-1c2c-4bf1-9f8c-08dc91407374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFVHbWZJYittL1hJcnRiSGdvYTkwcVU2VmdsZ3laL2J4VkpFVFhmTGJJNzk2?=
 =?utf-8?B?Q01LVmtDSWgvNDh5RUVWUHNXWG53U2ZzNWJnSENMVklabHFPNjJpdEpoSzZP?=
 =?utf-8?B?MWY2NHpEblg0RmgvK1hyemc3YzRha0VvbHF5c0Z3QU4vNnp1NXpUNkVuMGJS?=
 =?utf-8?B?SnAwcHBTWmdLUklXUlJ0KzNoNlV2eUNsdzdmaVNrT1V0NzZUK1crczNHUzFE?=
 =?utf-8?B?N1JaMmdQTy9TWXBXZEp0dVhyY0YwQ2xneGF3S0l0Z3FHTlExYUNCdnVFSHZ5?=
 =?utf-8?B?aXl4YjBmNHh2MXQyekgxSjMzT2psVmI3eGpLQTRnaUt0WjRFVmo3MVBJdTlo?=
 =?utf-8?B?andRMkliZ2kycGh0Y3NyMGdRQ2ZVbVFLaWFHLzRaeTZXT3dnRWRkZmJ3Q2px?=
 =?utf-8?B?OUVKdW96VFVKb2tBQ0E4Q0hSV2JQSVdDZVhobC94WG5BbHNFTGtVTFM5V1Ra?=
 =?utf-8?B?aEF1cisxZDRSZlRiTFl4NUhFSHIzOEhmN3J4SU1OZUdSTm8rdEFTNEZYZlF1?=
 =?utf-8?B?VWRRRVZOYTV6L1owQlJ3cFV5MGRmL241OVdTTVRZVWF4V0pmc0hSYTM0QmFS?=
 =?utf-8?B?cHJMb25rT1ZJbzdZbXJUaGxCT0tZSEcwcVlQNEd1OE1YNlZvWmQ0T2dVa0VJ?=
 =?utf-8?B?cno4UVJ2OW5nS05LSDRJYjJaZEV3emFqWXJFMzdZbGdhR2xjN0w4c2lKUzRY?=
 =?utf-8?B?NzdHSE9HRTVsVzltd3VxN0FJZTZDV1NGdGVYU3VESlpjS3REbU9KVHQ4YVFM?=
 =?utf-8?B?ZUxiV0FTb0lOOEFzR3FLMEl1cnpOV1pKWU9ucWhENGkvOWZLUStVb3ZjVVR5?=
 =?utf-8?B?eFNhYXlQOC8yRnJlbkpSOXdnUDJHOVlXWnpmSFVVY2Y1OGl1QTdMc3R0WmVK?=
 =?utf-8?B?cEpWbXFVbHdrYjVKbzVRaTd0OER3cUd4T0FnditoUEJBcFEyK0Q4RWRRZnpm?=
 =?utf-8?B?NmZQN0VtUGYxaTRPeTB4NmhmVVJEbmVDSVY2enVEcWhHazFiQ0hBc2pSYTN5?=
 =?utf-8?B?U2VSKzBDQWJBUWk5OTZ4NGVIS3l1eUM1QzN1aDZEU3ZQOUg3SkRWdmY3bVpk?=
 =?utf-8?B?aXpnZWpubHF1MlRrUmlKb1d2dUd6QmllRTN0aldTUURPNHAxMXVlcW9RYlkr?=
 =?utf-8?B?UGZoY29JRE02YnVkOEVOUDBQdE8rbUdoeXlDTkNyaUk2dkRXVHZCL1QrWmFM?=
 =?utf-8?B?cGhHaTFWVjg2K0dIbVdWNGJxalBEeGZEd3ozekdiMnA1MDhmTG0vTzNhb2FX?=
 =?utf-8?B?NEx1VHdxS0huOGNEOTZxdVQ3MzkzcDNlK1RKOElQN3B4UHpaWHYvVi9PZG56?=
 =?utf-8?B?YSsvRmVOMnUzc3dTYkxpYTNNNFpYZEFlU0MyenM4MHQvaDBmUTJGMlIwaDN2?=
 =?utf-8?B?MFg1SE4rNm5SR1RoS2VPdTQrZzFsR1UwcWVLWDEzUXZ6QzRvZlpFaHU0Uit5?=
 =?utf-8?B?bm1VTE80bmFtMDlQRjhxUERuSmdxd3ZEM3dTTzQ0S2pEZ2hNNndIZk84ZjEv?=
 =?utf-8?B?OGlCVks4YkhhN05pdnRRdzNxZlMvUlNpa1pyVUlRL09Da2w3bkVwSzBWNmFX?=
 =?utf-8?B?eVUweDJoRFRxVkMrbDBseDQyaVgyQjZqYmhzeXJmZmV1anBqdW53aVlhY0lq?=
 =?utf-8?B?YVFJdTBRQ1ZZbjNLeFhzMVBkUVhVWlRWUmw1c3A2ZEZ5eDQvNWRYQ2NiUDFl?=
 =?utf-8?Q?TOEkhotpWgWdKmv7WgKK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NSOWp5Z1graTVFbmpuL1JiR1QvT1I3S1drS3FiUGZ1TzdWQVFrRXd1MG5O?=
 =?utf-8?B?QVNWWU5FSkROc3F1YnU4K2pQRkd6MjR5em1ldXExUXh6T2J2R041NFMxZm9Y?=
 =?utf-8?B?UTQ4YnJTOFpQTEc1MksrdHZodmZ2ZHltWlZ1QWpsWFRlak93UVRheGpYZ3RX?=
 =?utf-8?B?Nlh0U1ZxdW1TdWVMWURVRXNmRnFOaXVjcnVWVWo5K3BldWpNNTZaVnVwRnU0?=
 =?utf-8?B?bHArU3c0WERIM2R1Qk8rN1lsVUJVWXFpWTAzYjFpUHdpQVBjUTdvcENyZ1NU?=
 =?utf-8?B?WkhlaEhIRmtKYkdzUkFBTDJGTHI0TEp0UXY5c0pYSWdGUDRqS1MrZXZMYmFu?=
 =?utf-8?B?aHU5eW5TQlNCUUo1eTFUL2VFa1FiMklVT0xsVFkwRlUrRW1XYVlyYTlPSzVT?=
 =?utf-8?B?bjZMd3B4bHduNmlXTzA3QWRtcCs2c0NzcnBFTHkzZTJpOExaWXhNL01xTjl3?=
 =?utf-8?B?SHV1ZVdQcUxIdk1Fb1NwUmRITFllaGl1cjRoVW4wRzdadWQrV1pUeFQzOENR?=
 =?utf-8?B?UEZuRGh6dWZXcnNWajZCK0dTK21sU2xsa1RKRndoN0UyTnVXbm93TUVsUmMw?=
 =?utf-8?B?cGZGWkF5bXhFU3dyNksvU0IxMUJFQVNaZHZSb0UvdEd5QnI5aUJoZmRTK291?=
 =?utf-8?B?MG1wY0dja1RzVnJGZVRmQ2ZUa05OdVpsZW5zRGZ6bFBhZHNja0VyVlBLZFMw?=
 =?utf-8?B?V1ZteHVVNHpJUG1MdUFXWkJweUMzOTNWRHZWa0tlYkRoeWpaMVFBK0d6RXFR?=
 =?utf-8?B?WmJuVFJqY0ovSDZ1VlJmQ2dNbGlDZFdnTk1PU0RtZlpLaUhyRTRmSXNmMkhw?=
 =?utf-8?B?SUlSNUdMcUVGNHA4L2FIZWVHNnpYeTlnalBiN1ltOXA5MmRQdXNVL2hsLzFB?=
 =?utf-8?B?QTR2SjBSelFKMVkycmN3SjdtTmg1OW5tYVhqb2FGaWRJMXJtbi9XOHljTXJQ?=
 =?utf-8?B?bkZRSWVaWWZTUDRPakdqWU00M0h0WHhDUUg3cFBzSjNuMjUzSXZ1T2NUVml0?=
 =?utf-8?B?L2o1OUhXTVBlamdTanR1WGJoQkNDNFp3My8zU3JBcmlZV1F3YnNJc2VVa1Vs?=
 =?utf-8?B?UFJkY1RuNGZneUxDdzNYVjBPZzdwUkxXeTFQRDM1YlpkdHM0dmNNaDdWbC9u?=
 =?utf-8?B?S1RISFIwRjJjaHgraE9UUUFkZlc1eWZQdlpXZFg4TWZ1UVM3ME5IM3FteFJo?=
 =?utf-8?B?TDMvUkU5c0k2WXcxOWJmcGlGcEI4WXlKZkJxanlCdTBrKzcxNnJEQ1NhbUVS?=
 =?utf-8?B?QVVHWXNxOTM1ZFhsd1RiWFhJRXdnNWV4T2FvS2toS0EyV2puazRSc2pGWDFY?=
 =?utf-8?B?RFlaUjF5UXoyOXpPamFPSnhSdzZmSXJubDNxNjk1bDBla1dESXM3K3YyTVFH?=
 =?utf-8?B?ZnFOOGdWVDF1Yk1XZzNmWm5xSXAzbHRoek5GeDlMeS8zZVF6MlptdGxrenN3?=
 =?utf-8?B?bUc0WXhFV1hUamdXMnlGa0EzUWgvQjU3WWViYlUrN3NIWGVidms3dGwyZXpn?=
 =?utf-8?B?ajUvdXlpRUc1bDVRNEQxeGhQQXB4ZmpLeFZKY0pZOHdza3Y0c3liOWwrNmhV?=
 =?utf-8?B?cDJlVUlITE5tM1d6b0dkRlpvQUxvbTJXRy9kbG81S25HNHlILytVUHFkRXlj?=
 =?utf-8?B?c2xaYW9EZlVXcS9ORkNQRlF4OTdyYXlIeW1lQ1FhWFREeHZ2WERDbi93Mkdo?=
 =?utf-8?B?MlNkSzZYejJWS1hJalVYMTBRazg0dVU5WFBwOXZwYm9KdHRNbE15TXB0Q25p?=
 =?utf-8?B?T0Z2bjM0UlBnWEdVU1lnS1NMTUlHWnRXTmw1bDVtV1JaQ1d4dkw4S1k3N2xq?=
 =?utf-8?B?Rmt0MHRiRVdOQjVyM2JWVVBxMUhrYU1mdVhpV0ZyUDdoV01vRDNaTG9xS1Zn?=
 =?utf-8?B?QUpZdkRleE11VjMzNzFXN0YrTllEOC9OQzZKV1M3cFc0OGFuMUp6Z1N4U2tW?=
 =?utf-8?B?U2lYS1ZaVDRLQklpRE1zaUovcmRXRktQSys3aHV1bzVCeE1pdmUycmE0dkhH?=
 =?utf-8?B?SnR0eVVjbFVCWDVpSlpHOFNFVi96RnBkMFNrRHRjNlJVa3BqSlUyZ0NDTSts?=
 =?utf-8?B?bjN0aDQyVmtaMEE4ZTNPeW9vcTFrQW5GdjUvUGxpdXEyRTZLVCt4ZjV5SU04?=
 =?utf-8?Q?H+zMyMyMWKkCWHL5I16sSYLXg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1204fa-1c2c-4bf1-9f8c-08dc91407374
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 15:48:38.2980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxL748zxZ2MMlJc/QzXmlSnSIVCMUQ4v14FyhzxTBvDKLx8d57wm255dGzuONwjX8CRsJFuFz1ckD9AfhbHY7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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

I think the "break;" there is to silence the compilation warning - it is 
ugly but needed.

David

On 2024-06-20 11:38, Alex Deucher wrote:
> Applied.  Thanks!
>
> Alex
>
> On Thu, Jun 20, 2024 at 5:07 AM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
>> No functional modification involved.
>>
>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3171:2-3: Unneeded semicolon.
>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3185:2-3: Unneeded semicolon.
>> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c:3200:2-3: Unneeded semicolon.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9365
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>> ---
>>   .../dml21/src/dml2_core/dml2_core_shared.c    | 46 +++++++++----------
>>   1 file changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>> index cfa4c4475821..1a9895b1833f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
>> @@ -3142,62 +3142,62 @@ static unsigned int dml_get_tile_block_size_bytes(enum dml2_swizzle_mode sw_mode
>>   {
>>          switch (sw_mode) {
>>          case (dml2_sw_linear):
>> -               return 256; break;
>> +               return 256;
>>          case (dml2_sw_256b_2d):
>> -               return 256; break;
>> +               return 256;
>>          case (dml2_sw_4kb_2d):
>> -               return 4096; break;
>> +               return 4096;
>>          case (dml2_sw_64kb_2d):
>> -               return 65536; break;
>> +               return 65536;
>>          case (dml2_sw_256kb_2d):
>> -               return 262144; break;
>> +               return 262144;
>>          case (dml2_gfx11_sw_linear):
>> -               return 256; break;
>> +               return 256;
>>          case (dml2_gfx11_sw_64kb_d):
>> -               return 65536; break;
>> +               return 65536;
>>          case (dml2_gfx11_sw_64kb_d_t):
>> -               return 65536; break;
>> +               return 65536;
>>          case (dml2_gfx11_sw_64kb_d_x):
>> -               return 65536; break;
>> +               return 65536;
>>          case (dml2_gfx11_sw_64kb_r_x):
>> -               return 65536; break;
>> +               return 65536;
>>          case (dml2_gfx11_sw_256kb_d_x):
>> -               return 262144; break;
>> +               return 262144;
>>          case (dml2_gfx11_sw_256kb_r_x):
>> -               return 262144; break;
>> +               return 262144;
>>          default:
>>                  DML2_ASSERT(0);
>>                  return 256;
>> -       };
>> +       }
>>   }
>>
>>   const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
>>   {
>>          switch (bw_type) {
>>          case (dml2_core_internal_bw_sdp):
>> -               return("dml2_core_internal_bw_sdp"); break;
>> +               return("dml2_core_internal_bw_sdp");
>>          case (dml2_core_internal_bw_dram):
>> -               return("dml2_core_internal_bw_dram"); break;
>> +               return("dml2_core_internal_bw_dram");
>>          case (dml2_core_internal_bw_max):
>> -               return("dml2_core_internal_bw_max"); break;
>> +               return("dml2_core_internal_bw_max");
>>          default:
>> -               return("dml2_core_internal_bw_unknown"); break;
>> -       };
>> +               return("dml2_core_internal_bw_unknown");
>> +       }
>>   }
>>
>>   const char *dml2_core_internal_soc_state_type_str(enum dml2_core_internal_soc_state_type dml2_core_internal_soc_state_type)
>>   {
>>          switch (dml2_core_internal_soc_state_type) {
>>          case (dml2_core_internal_soc_state_sys_idle):
>> -               return("dml2_core_internal_soc_state_sys_idle"); break;
>> +               return("dml2_core_internal_soc_state_sys_idle");
>>          case (dml2_core_internal_soc_state_sys_active):
>> -               return("dml2_core_internal_soc_state_sys_active"); break;
>> +               return("dml2_core_internal_soc_state_sys_active");
>>          case (dml2_core_internal_soc_state_svp_prefetch):
>> -               return("dml2_core_internal_soc_state_svp_prefetch"); break;
>> +               return("dml2_core_internal_soc_state_svp_prefetch");
>>          case dml2_core_internal_soc_state_max:
>>          default:
>> -               return("dml2_core_internal_soc_state_unknown"); break;
>> -       };
>> +               return("dml2_core_internal_soc_state_unknown");
>> +       }
>>   }
>>
>>   static bool dml_is_vertical_rotation(enum dml2_rotation_angle Scan)
>> --
>> 2.20.1.7.g153144c
>>
