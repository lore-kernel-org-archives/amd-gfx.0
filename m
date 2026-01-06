Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEDECD0435
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 04:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9B110E17F;
	Tue,  6 Jan 2026 04:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b28sAztI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E6410E17F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 04:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6UEjF/KsOdWbZ2Mt/5FrRVVRGFb4wmY+EV5S60Uv5m401qM1fHJc1CAuqA5T9G3sr7l4mu74kBsa/W3RnUSVKQfp9xU59BpLiyfOv3cICj36DEYcQlXPrrsWddwAvdC8u8NBJEikbmiSjkvMbM5v0EX1c/cZIJQjErbOqnJ3Wl2OUg1jroXs95NovInmEKZcTARiNJIHHMXBwl/IbQe1iNU9Src8CcvDMjF2X5pzv2f+2HCZtkRJsHq7x6PLG0NVJdeT+D6ADRUc/SFSiZrdnvESc4QUkvgV+ZY5sI/tCcpAI8M7nCF+hplY+o4MtIE8gV1Lsz7gV/3JlTzOarq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUtfySM3zaw/89D5+hHkOKF6kGEVUd7rAqs0JIutQx4=;
 b=wUp8zWtPJAIfxTH5fWxUICgGfLkiZ7vZtKdJwTsIgpD/SOUabltxhQvSvcgGW/8F1eRvb5s0b+hVS+/9cqnGGcDD1A5exKUexfxsyst3gX1A4xJob+teOOXXFMxaZEDi8JtWEUTAZIIoI5iCUEGzWQ6k0v1YID9N1hXrA2jbHYeeyk57Q1Ff2h8Py0N5G/WvzgVggWCzF5GlC0ZxaV6h5f2ffzU402B32V/ffmBK7WiJhf9pCuASKPlrqjKdh3hFk3WEt9f0HrjnlECUgydRsP1cl7YFHcZslQKzu1Ojirc8GYitCpTfSubfScjaADZwpE+PtDHzIVK8mZTo3rce2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUtfySM3zaw/89D5+hHkOKF6kGEVUd7rAqs0JIutQx4=;
 b=b28sAztImxEu1Jn4n9Xfg0q48RcNUYs6gS3hRCWtY+LUh4lvubAqV9jnN9ME08gxP3Z7UBQs5hIiN7YojK0+SlBv63LZG73rnpkN/d24EQ5MRQ14VEEe8A5nI/tH57SIcXyzKgsKqx4axcTSduHJ4LMoH0xu43BnPZ0uo76OPXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by CH1PR12MB9575.namprd12.prod.outlook.com (2603:10b6:610:2ad::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 04:49:34 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 04:49:33 +0000
Message-ID: <92af9f9e-8b05-4a01-b0bc-44efd1598e63@amd.com>
Date: Tue, 6 Jan 2026 10:19:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
To: Alex Deucher <alexdeucher@gmail.com>, Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Yifan1.Zhang@amd.com
References: <20251226081800.2475186-1-perry.yuan@amd.com>
 <CADnq5_MSrvCuE6_=kx2xNw38-XZUVVa5sp_-3WUhVV2+Ey4RGw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MSrvCuE6_=kx2xNw38-XZUVVa5sp_-3WUhVV2+Ey4RGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|CH1PR12MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: f39f7f04-aa6d-42b1-1b2a-08de4cdefc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVEvaWNad1RTMjRoeTNtZlNzWjdPa1JYSEZlc1hHR3NOb3pLWXRNandVNkxt?=
 =?utf-8?B?MmZWYjFjdU15ajZBNGtqR1F3RXVUaHordS8xb3VqSW1RQUNya2ZRUzhqZnNL?=
 =?utf-8?B?bFo3RTc3anova25hbmNaT1hqeTZ5YkhUY3k3N2IwTnBzMGczS1g0MTJUUDhS?=
 =?utf-8?B?UDdqTEJQZWR1Qm9IQzRkQTVpc2FHVWJObnQ0NzhZYjFGTEg1UEZsbFh6b0JE?=
 =?utf-8?B?QVBWdmgreE9zZTNkanBrYmpSWGFsdWw5ZGZQTnhRUXVFTm5TNXhocEpzemRm?=
 =?utf-8?B?d3dFSUlKQTVmNnhXVjUxYTVHZjh5ajJEQWs2UFF3UjJDV3pYSlcvS3k2SytU?=
 =?utf-8?B?b2xDdC9kVFY3ZzVSdE4rWXRnRk1QMmdNYStmNXB5QmRJUlhOVnhJRzczZVBG?=
 =?utf-8?B?OXZ1U05wYkhraHVFL28xWUx2VVhicVVoWnhDNHVsY2NxcWovK2R6bzRqODlY?=
 =?utf-8?B?NVQ1RVJac2VUaW9kS3lYaXlUQld1NEpWSTBpV2lYdUNGUWdESjFIeDRyaWJI?=
 =?utf-8?B?Q3puRHk1S09FbGk4dDlxMTRCUXBRYk9Jc1A5UFByeG9uMFp1OE1wdU0vaVdR?=
 =?utf-8?B?YXRWT3FaYWtaUGFTaXg4bktlUDRwdGhQOUpsbWpjUVUrTnVZS3JkYnlma1kx?=
 =?utf-8?B?cExEY3RNQWE1M2Y4bTNxTVFCbzc3c3JBZldFZGxUdmltTGE5cko0YjJ1S001?=
 =?utf-8?B?Z2N4L2xxaTBaYVA5b2NGRXFGZlVoUk9KTVg0TEVXY2ZMaUE1L0VsSmJPakpi?=
 =?utf-8?B?TTl5OXBBaTR2L1R6TEtqR21qbVJBQ1BHUFRmUkd1YVdyK1JpOFllWXl6amdr?=
 =?utf-8?B?OXdSTTY5eU03U3IraldROFFVV2tMYnBlVW9sOTVoMzdEZ3R3ZzdzcURBQm5k?=
 =?utf-8?B?Q09IclpGeFR3ai9SSUhhaTBZQ09GSFI3QUdEZkEwd05lNmtaNk9jdSsrcktv?=
 =?utf-8?B?bkFaMU1XcmRYd1JSbXNDNTN0dnEzOUE2R0lJUWtwenhaL3F5OTRCSktzcStq?=
 =?utf-8?B?Y09OVDE1R3plV0ZnaCtGbWlWcjJodTk5TVROM05GLytXd2szVEZVTTcvcURr?=
 =?utf-8?B?S05XbmhzMTNLdm5LenlKQVMvNzE4Vk5Wb2gyQWE4RVpEYm5paGh3aWt2U3JD?=
 =?utf-8?B?S0taTnV4V3BYUEk2RjZsQ0kydUpNc0N6NFU4L2xZY2FBcm9XNlJ4WERZbWQz?=
 =?utf-8?B?aDJHYVZrWE81UjN1bnpDMXliL3RSZE9SQUt4ckFhaG5UanJXUit6YkM5UXBM?=
 =?utf-8?B?U2V5OGJDckdUNHQ4WFA2cjU3UjlHVkxTaDdPdVRBaEc5T0VBclhRQnFaTFIz?=
 =?utf-8?B?Z1QxZDZyYjJreDhsMUhqbzN2dzlBZVRYZC81amZCNzV5bTFvWTdPTkcxQVNt?=
 =?utf-8?B?MkkrM1I4ZzB6V3k1U0tuMUI0RmpZcnlZM0x1djNzVldua2ZyWjFNTlhmMVpz?=
 =?utf-8?B?YU1lQXg1UUhLdUh6NVgyN0ZxS3RNeVVwNzFia1lOdjR0MjRldGJPUHViNkFP?=
 =?utf-8?B?L3hvT052MWlaMXVnenBOc3NvUUJXR3NMb3FlODNsRVJKeloxNDdHVU9kK3RG?=
 =?utf-8?B?QnBhNVlFcFJDbENhSmd2ZThQdzA3TUZCeC93TU01SHVCN0xWcmNVcS9KeExO?=
 =?utf-8?B?UzlqQW00ZGsxcGI3elc2N0NEOW9Cc2dxMXMxb3RkWUdiNTl0NVY5UWY4Y1Rh?=
 =?utf-8?B?cmhnZ0hQbERyNVc3QUVlSThqcTVmVWx4U0UxdlJCam5jaWlBdTJrRDkwZHFp?=
 =?utf-8?B?cjVhUW02dzhUVFJydzhnLzRpWHU0UVAvcTNndVltd2V2UC9HeC9ld0NyWHFD?=
 =?utf-8?B?eDhDeHpUL0pwTjVZMTdBZGJsTDJYZi9JSVpJbWVQU09rTi9NZWQ4a0FlSUJ1?=
 =?utf-8?B?eEJBUWlrYXhkVmZhaFE1VndBM3FhMG5WZmVZekV0VEZVNzcyWWx1NGdvUGpz?=
 =?utf-8?Q?FBPmCdMDlC43YjVYiSVrWYanKSNQsxJF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFMbkRLSFBHT0dNYlNjOFFMT3FJb0JVbHIwZmpINnBLYlVzck8wVStCcFhR?=
 =?utf-8?B?UHNCamlCTERyRlIyWjAwMnhCYVphWUVzc2wrS1FEVml4Y0pwbEl1MVVVd3NO?=
 =?utf-8?B?Q3hDanhkZktySlc5ZnY5Tmhpa1gvQnNxay8zaVFXRWVpdmtYcVlpUURkME0v?=
 =?utf-8?B?VFFqMnQ0YUVwQTdweUtNN0hFTVh3L2pJZFp6a2V3ZUJqRjlNNXRUUVlhRWJX?=
 =?utf-8?B?L2lzZ01XU2dnSU5USURUbThkK0lyN3BuUDRjYWo2MWRFS09nT2YrL3VlcitQ?=
 =?utf-8?B?aDZxbmVjeHM4dnhhTUY1THhWRUFQcVkyT01LRU5RSjJQckJtV1JlWHB3eGRi?=
 =?utf-8?B?QVBEejZibXBROVIrNUxLeDRPYjdBaWRZTWpJblViZktSV0pRbUUyMDdBTnBR?=
 =?utf-8?B?SWtEeE9Xd2VUQkdTb3VqTXF6T0tVNFIrTlpHQ1NRaUY4OVlXRTh2RHc3YlVD?=
 =?utf-8?B?OU8xbXlRWFNFWlFmMVJJZVdqdE9UMUNDVTVNNHkyU0dkblZOeWNLNS82OWdx?=
 =?utf-8?B?QnlHWFVRRTliUHJ3ZUo4UnVRemxwQlFKTk1qWVlKSE1NWWRqYlJlWWs4S245?=
 =?utf-8?B?YTJnYWN0OTlCN0xkZjdoeThjTVl4MDBUd3hGaWp0UEJYRHR1MHRDWTZ3cEZj?=
 =?utf-8?B?RFBNazhNN0h1eUNXR1lORTBoTlRyMkVqQVBoSGYyM1VzS20zLy9tbWQ3Nzlm?=
 =?utf-8?B?dFZEU3A5M2RlVEFqRWpDbUM3MHM3MEJxd1JOTVRHTFpNNjE0d2pnc0RRT29m?=
 =?utf-8?B?S05ZeXVLeXJDUSs3MlN3ZzYxdXNmMTBOTjMrZ2UwRVdab25BdmVnRGpFZThm?=
 =?utf-8?B?RVRzSzNxL1lzQUNkb2NRa1k2dlYxTWY2Si9DaEtUejBGTFJBYVczWDFsd0sv?=
 =?utf-8?B?dTV6ZmpDWVI5dlo5VmNNa1ZyODZPbzVPVlo5NXNPUGh5L21GazdJbzdKTTI1?=
 =?utf-8?B?VnlPVGg3am1zRFp1dFZzU2w2NS9XeG1rdWNubEhQc082YkxuM1FIOVUwVStX?=
 =?utf-8?B?RDZEZk42SzB4WHladHZMZGhCQnpuK3U3L1RLVTd1bEpoY3JCWjBqM1MxaVRQ?=
 =?utf-8?B?SUpJM3BaeHVCTnY4aXpxelZpeE1zcnJYd00yREVvUzg1UFhkTlRHQmZVR3RZ?=
 =?utf-8?B?NjdQN3FYQW9RenM3YzZpOXNVb2dQb05vMHBQaHlmWWZNS1UrK1krL0toY3JD?=
 =?utf-8?B?dXFMR1hTaS8yZ2t5VzcvcnB4SHVsYS8xTGdUOEt5YUgrV2ZHOUxNajZQN0xv?=
 =?utf-8?B?V2xvL1RiUGcxcFBuMDg1bndxV2s4d21jY0NxRmdMN0RnemV4NVRqOVdyL3Bm?=
 =?utf-8?B?R2k4dGVuRmhLKzBSTFVtNTFmM2ZxQXY4WG9QUy9oejI4UVp3bUFKSiszR2ph?=
 =?utf-8?B?RDhtWjlGQi8yckZSeFVWUTZqamlHNXVpeDNuaXZha2gxdmNEZDY5ZG40aHR3?=
 =?utf-8?B?c2xnQ3R1VzJrbVllRmxMQ1hvZ2U1b3pqTGVsZEpBeFFSeEREYzV0NTFEeFpD?=
 =?utf-8?B?dWRTdEV4ZHUwUFh3WVB4SmFvRUtvLzNRczFIOVRMMndFd29wd1h1UGlCTG5h?=
 =?utf-8?B?djJoUW9sZWNzVFBmeThUT1RHTjFCckhnR3QyY2FzSkJoYVRNWk1QcStvMW0w?=
 =?utf-8?B?a2lrcjR3MXJDcm5hWEcraGRFRmUzeDVRckZ2Z1BIZFg4OUdoK21vL20rYnRB?=
 =?utf-8?B?YmxXNjlMaFhiNnc0ZTB1L3I0ek02REc3R1V3M2I2amVJdjhuQjVoMVpJVkpN?=
 =?utf-8?B?WHFJQnM1KzFRakVWL0g2dmF3WXAxQnJ4VmNxb0ZHa2JKV2plU05qUWhMMHpP?=
 =?utf-8?B?RmRGRkF2SzlsUlZYZEtBdG5EaStYTEFNNCtBZUxvbktiQ0VtdXJ4QXlLdFlW?=
 =?utf-8?B?aEtmZUpneTRienc3dU9PN0drZEN1RDlQL3hyUE9Od0xIU28xNEVKUllrV3hZ?=
 =?utf-8?B?OStJakM3ZElsWU9NY2MxbkxPazE0OU9zdm1kSE5GS2hRYkFIWEFvRVdVTVp6?=
 =?utf-8?B?ZFczOUVoZlFnRCs3Ym0xWXcxQm9SMElBZmFYdm9XZmw4SVF2SjVTNlY5b1NH?=
 =?utf-8?B?Ylp2VUZPcGxDSkNzWnYxRTcrSUpHSjNVSlpVV1N2UDV2TUk0Y0NmQTFYOURV?=
 =?utf-8?B?QXQrUXFrVTdGQmxMMEZoTjk5WGpqMDFGclBMTWQ2RURJb0xDbVlSbEdLcW9C?=
 =?utf-8?B?Zk1abkl2dTFwVk8xaUV2WnNkaGdlS1VCdU9uZjNVdEJHZVpyb1VuejJ5d3B4?=
 =?utf-8?B?by9ZclNCWUYyMk9yVXZWK2puaGtvU3pWb3RPMUJJUFVBeTVsY2liM3VaRTdO?=
 =?utf-8?Q?MBI7qHHewf7gUqNWsj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39f7f04-aa6d-42b1-1b2a-08de4cdefc34
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 04:49:33.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkmQf/UOlmJ9sA4hdHF/nJ/NToNGA+QPgk5LLpcIFYByyCF+URBq0yHFribR2DuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9575
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



On 06-Jan-26 4:09 AM, Alex Deucher wrote:
> On Fri, Dec 26, 2025 at 4:36 AM Perry Yuan <perry.yuan@amd.com> wrote:
>>
>> During Mode 1 reset, the ASIC undergoes a reset cycle and becomes
>> temporarily inaccessible via PCIe. Any attempt to access MMIO registers
>> during this window (e.g., from interrupt handlers or other driver threads)
>> can result in uncompleted PCIe transactions, leading to NMI panics or
>> system hangs.
>>
>> To prevent this, set the `no_hw_access` flag to true immediately after
>> triggering the reset. This signals other driver components to skip
>> register accesses while the device is offline.
>>
>> A memory barrier `smp_mb()` is added to ensure the flag update is
>> globally visible to all cores before the driver enters the sleep/wait
>> state.
> 
> Seems like it would make sense to extend this to all asics which
> support mode1 reset.
> 

This doesn't look like a good idea, it's more like a shortcut. Ideally, 
there shouldn't be any access since suspend of all IP blocks get called 
during mode-1.

Actual fix should be at the place where driver accesses hardware (if 
any). That indicates some logic issues within driver.

Thanks,
Lijo

> Alex
> 
>>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 3 +++
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 7 ++++++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 9 +++++++--
>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 824c5489ec85..75b1b78c0437 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5776,6 +5776,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>          if (ret)
>>                  goto mode1_reset_failed;
>>
>> +       /* enable mmio access after mode 1 reset completed */
>> +       adev->no_hw_access = false;
>> +
>>          amdgpu_device_load_pci_state(adev->pdev);
>>          ret = amdgpu_psp_wait_for_bootloader(adev);
>>          if (ret)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index 8e35d501e81d..dcb169b25916 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -2850,8 +2850,13 @@ static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
>>                  break;
>>          }
>>
>> -       if (!ret)
>> +       if (!ret) {
>> +               /* disable mmio access while doing mode 1 reset*/
>> +               smu->adev->no_hw_access = true;
>> +               /* ensure no_hw_access is globally visible before any MMIO */
>> +               smp_mb();
>>                  msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>> +       }
>>
>>          return ret;
>>   }
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> index af1bc7b4350b..b1016debdf06 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> @@ -2069,10 +2069,15 @@ static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
>>
>>          ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
>>          if (!ret) {
>> -               if (amdgpu_emu_mode == 1)
>> +               if (amdgpu_emu_mode == 1) {
>>                          msleep(50000);
>> -               else
>> +               } else {
>> +                       /* disable mmio access while doing mode 1 reset*/
>> +                       smu->adev->no_hw_access = true;
>> +                       /* ensure no_hw_access is globally visible before any MMIO */
>> +                       smp_mb();
>>                          msleep(1000);
>> +               }
>>          }
>>
>>          return ret;
>> --
>> 2.34.1
>>

