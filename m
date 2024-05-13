Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714C2C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 06:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A9F10E13B;
	Mon, 13 May 2024 06:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/nfcgnv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A435E10E13B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 06:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdOXLgctZvMLlIhcXPuxXaoJ4x4Sc+vwHPrF0RrIjzq8FppxCq2hEunKLMdNu5i3WEH6SFivFsOEyTkDp4ElFc/7w2Rw35b6REtJ0oYzPfmus4kIWfurQoxPzP6m8X7JAamRiwOqnLBeVUo1lF2INzHxY6wiLPTCZDIdKJsZDjDaEMLt+7GujYVV8tNc0NwfgU3QNpfOQEFFR2OkNuhEkclXJQsl4DmQm7IqjdpwhVJxzj0UXu1lh2b6gmqFSsiyFelh02OLIZYnG3jLKRbTCIzhgljKItTDMQyizAx3sTTrsDTKwhBTYpBQGVeHA9YQgeY5qvmmc/3hp2HoII2AOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNWomc415Vg1VGeQcgJXNITtsrzVcnZ1QRIN5g3at/o=;
 b=flEwqM/Uec4cDJC/QAcHyLIJHhxBSredHecZIpNfCLBD5vO2thwyODR+EG0aYh+EPM3nJ1Bl1+9axqyp1jPTIgF4Nk9ZsOVL2ds3kC2afmpttq3V1TZIUivywa8HfqYzDdGBB1bJ1KrlmLpOyZEu/O94/x28lCZHR9mt5r5w2bEEubFM8+Bj4OKVDdUQg3HXGxWZwaLtwG13yialOz7FqsnUpYsuFwWthUkFoool+WK4jOre1dgWMu6TsZQNymRrU+XYTIa7sqb2Zpfpt/Y8WlRiHqkn4ZWYZceBupopZ+ujNaERJBROw781axgvWph99NUZ29H3f9RdXMncuJMBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNWomc415Vg1VGeQcgJXNITtsrzVcnZ1QRIN5g3at/o=;
 b=g/nfcgnvJ4JaVM81M7wRIO5ImbpURpSdmazLQshFbNmAyYp1TGPaZAXcN8zzVMrTPLL5mO05a1spJu7LcU8rvWWRwfmY4+mH/Se3bKmC3QzKOQVTCBZc398U26A41XovKo24BFl90rcvZCeEb3u0b8rs3XinuxHs2noBVxEab5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 06:19:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 06:19:51 +0000
Message-ID: <bc98da56-d04d-4742-af3d-a4950faf7502@amd.com>
Date: Mon, 13 May 2024 11:49:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Add Ring Hang Events
To: Ori Messinger <Ori.Messinger@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240513041414.130959-1-Ori.Messinger@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240513041414.130959-1-Ori.Messinger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c85539-8237-4365-ee4b-08dc7314b2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sks0eFlUQTAvbVhaaTVtemlrSXJvbmFNSkh3c2FsV1ZFSi9NYXJzSXJ2UnBy?=
 =?utf-8?B?QmpjWW1SYVF6UEw4U1JnMWF4Q28vYkFQMEJUNlBqTmZoTGZtQTdjd1N2Vmpx?=
 =?utf-8?B?UXlhdWFGUlpTejczV0ZBOEVRUXdnVC9DNUNDT2ZMeC9NM093bHpLNDRnbXdh?=
 =?utf-8?B?dkR3RzN4NFQ2ZUpucUc5L05wbEQ1NGJMTFNOTHRGMTlpMUdKWXNBNmRLajk5?=
 =?utf-8?B?anRWUTBYNkRjZzVYWWcwUUNhVlhFYlA0cnRZRnM1UWQrcDc2WU5IeGlpRkpl?=
 =?utf-8?B?UUlKYVFGd09QS0VuYnlRSFhtU3NndE5YeVJvcEhaQXNNMzFFQVczbWZob3F1?=
 =?utf-8?B?K0sycUVXR05UWTh2clB5bmM2MENUL0cwczUzQVpVOWRuU2tYc042Qk81VlY2?=
 =?utf-8?B?b1AwM2djdnJGZ2hHa2o3d1NOWkRYcERIY0Z6bzBadGJsbHc2VXlIdkRLVzJU?=
 =?utf-8?B?Q1lFcG5TSEhUSzFxVkUyR0g2YUNtNzJIUXFLWUVxZkFtNDdLYlMxWDJicWpS?=
 =?utf-8?B?c2xPRmFsbXh3Um1BNVBoK1E0OGpnZlhUWXpBS214VW5PUE9ZSldDenMvejFS?=
 =?utf-8?B?RlZBVzdrbVNWOXFDTTdvbjZVZTVSYTIvcThxMFJXVTF1REpTdFNNOGVlQ3dN?=
 =?utf-8?B?cW5pTzlLekd6R3duWkRja1VwVndVN1Jia3NyMWFtZHo5MzAxTnA3TU00dHZm?=
 =?utf-8?B?d0k5K0tKemRwakQzbzVlbDBqN2I0cHQvMG9jNkhjaXgxN2g2cjZXY0ZEL2lI?=
 =?utf-8?B?ZEdZamUvcXkwQTRoRVVJMEoya1F3dnpCM20rL1lPNms4ZXpxZ1NTY2ZZY3Rz?=
 =?utf-8?B?UFI4U1JrT3UySTM1US9qTmhMWjA1eFU4TE43TUhZVUd4QjIwaTJ5eWN4Mitu?=
 =?utf-8?B?OXFFQ3czdGtaelJHSDVMRklrWVFCWjJ3UUYvRXNQTUp4TUEySnltYXdqOTU3?=
 =?utf-8?B?eXNPMkIwL1pSWVdBNlZWOUl1cFV6aEh6MHZpSlNYOFhjdUcrcERkYjRMMGpY?=
 =?utf-8?B?RGhab1RheVpKZ2xJL2lrbW9LM3lBOFJpdkl5UzUzSDc1bXk4ZFlnZUxaZTN6?=
 =?utf-8?B?NGRqYjFwY1RDWmtnc2h6S014ZndIZUxmMjVOQlpnVHhTOHJHVDY3bG1XOCs0?=
 =?utf-8?B?enlNREdSR0pxeVo4MEYvZ1NLbEF2ZENLYkZkN1llLzAydVhUN0JNYXlhVnhY?=
 =?utf-8?B?YmI5N3R2NHZ1NVJOMTRobWlIRTN0VGZscktVb1g0THZtL3VZSkNRcXl6ZW15?=
 =?utf-8?B?eUJBclBDY01jZlp0c1U1YXlsWm1SWG9od0dmVDlaL1NDWGZGbTM1TkVqSmV6?=
 =?utf-8?B?VXNqRGd2dXVqbW5RVXpuTkdkZ2VuVjNHY21aLzdoSmswbDJhOUtNTHpIcWZt?=
 =?utf-8?B?ZWVvR0xLT0t0ZUZ4MmVSdy8wMmhKclRIYVN0b05QckJsVzNzUnBKYy9oWklj?=
 =?utf-8?B?V3N6UlRqeFdHVitzV2pQbGV5T1kzbzFXcWFLdnNtU1l3NE5rYW5rV2lpRUhW?=
 =?utf-8?B?MUNpNmx5Ky8zQkp0V0kzaGFQOU9IemZpdGNxbXlkV3lPOXFtaHJXei9uUXBC?=
 =?utf-8?B?RmVOYWhvNnpVeXFGMWRnM2VmSHRhZVBFRC95UEhyWm1zOGw1REFuM1J4cW9S?=
 =?utf-8?B?TWF4MFFKYStmRUVEVGswMlhsTURqZzA0TWMrWm1SL1liQzkyL0dlaThFN1hq?=
 =?utf-8?B?VHU2R3UvWTBxUmlRcGQwcVE5dnVSdjRSd1lqc0hPWDg1ZGJyV2pKeTBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmxySmpNU05rMHdlTUs4eFpaK2pzd3MxN0RBdkEvenNoc3dDY2lRditWUDBt?=
 =?utf-8?B?SDNIMExiTVE5b1NxakZXL2VYZjFhYzJzc1hBS1RpZGIrMWxGd0Fac0xqaDRG?=
 =?utf-8?B?RzhkMjdSTm5PZTdNZk1NTk5XQlptREhadGpnOVRtbjg3RVUwSE8zdmM3VERq?=
 =?utf-8?B?a2EyanM1U1doUU5WcWFTa2Q1VUNVSWV5S2pyeDc4Tkw0c2E3c1hpVG5rR254?=
 =?utf-8?B?ek9tRndiajJxOCs5NmdVajdEVzd4ckZGWUpCdFhPKzhmaElEYXB3TldNYVM5?=
 =?utf-8?B?Q0VoQ3VsRDNBajI4Rlp6QWpjdFBWWnZRMjBWcTZDK1psSG9JL216T29ZRXFZ?=
 =?utf-8?B?R0JKbEtTR0hxWWc2blVQWEk4ZHRpcmhlM1RuYmh2MTZNU2JQUVgreGtNbTlJ?=
 =?utf-8?B?MG9Hc3RxVFBNNUI2aEpVQmRtYmUrWkg1dHpvWk0vZU5PWThwNnFhaVY4OU8x?=
 =?utf-8?B?TFB6cysyRTRkYi83dG9Ucjc0a0N3NG80VDR5T3dvVjFtRUV4OHdpeFF1b1d4?=
 =?utf-8?B?SlMvVzJZdm5UajZGb2pXOFJkL0xoeEdEWTJDeFp1MFVOZG5KdFFTQThaSjlS?=
 =?utf-8?B?QS9LdjFlWHBHRnVHTkttNG13YWtDS3liQ3JFelh1bVFXajB6M3lVbmVwMnRj?=
 =?utf-8?B?ekdWcjdrZWQ0N3EwNWRFZmJkT1RKTUZ2aDkwd29VSlUzZlBZdVI1enZURjRW?=
 =?utf-8?B?MVdtU0NrUjJOcUhNMXZJclhOVCtmT0ozcFFvdDV6N1hvdFhhQ1NEZXhyMnVB?=
 =?utf-8?B?SXJVZ0VVUCtmVWdqMXVBWGJSemh5T2RsZktSZ0NhbHVxelNqamRvOG52SENV?=
 =?utf-8?B?TDlQNXFaNlJVYWlVTzltMG5pZnN1aFg2aUQ1SlFuS29nVjQ3MkJSelVFV0xX?=
 =?utf-8?B?Vk5KVXdnVURscVpYbk5YYXpGTWFFRWY0OFkxWHpGU1BmbjdQNzJ5a0g4VkpC?=
 =?utf-8?B?WU5JR2hsTzlxamtvYzB3UnU5RTYvYlQ1U3NrMGlwNkkvaGlxQk9BRkNkdm1k?=
 =?utf-8?B?T0FkajloNWJUVUpONFhYbjd1WUs3S1JqaWZvTks0cUFMQXJ3cjJCUUtZNXlM?=
 =?utf-8?B?ZHNzNEJjVlpiZDI4OHR6SlduMHpMRzBrRmQyKzJldWVxMGRJZFRVNTJVbi81?=
 =?utf-8?B?cDlNUGpFK01ydW5QK3YrU0N0YTQrMWVldDgzZVRXektYL212ZUdva2VqbXZF?=
 =?utf-8?B?VDVJUlU0am43OFEzUC9kaFhRNHdLZmZ4aHd2L29YNldjd1d1Ky9Jb1ZlZEMv?=
 =?utf-8?B?LzR0VWlwemdiWEtNR3BUendjZSt5cWF4YWM3MGZlekg2RXVJdmhqbW9UdlZE?=
 =?utf-8?B?Uy9oMXNHUEo5dFovUzh3d1c1V3cwWnA3WEpqR0hDUGNiNUZjVFJuL2c0cHVq?=
 =?utf-8?B?UU5sNkJsTG93ZW5YclpqalBRMW1qelZDc3BOMGZsc3JVSVliWFhlS2VDNWNR?=
 =?utf-8?B?N2JRcDZvNzV0Tlh2UEJySnpmTVo4TFFIY0hqRWpJTmsrc0YrM0xTdlRUZTNZ?=
 =?utf-8?B?RG85bU1kN3grcS9RY2tPRERrbnYxVjh4ZDhpcjArUVFYNG5OeUdRNDFyOGpZ?=
 =?utf-8?B?V2crUUltYUpoRTVtSXJIMUxsa2tIaEczK1IrcFA4NWJNNHZXMUJFWkI2R09z?=
 =?utf-8?B?MVZRTWREZ2N3c3UxMjhXTnlSazdjT28vQ3FNL1pCZC9OWkVnMDZkYTZ5SUFr?=
 =?utf-8?B?ZjBuWUY5TWdqZXNacGVreFpxUmFodjJwQ09LQ3BqcldYSTZwTVI1UUxKTWlC?=
 =?utf-8?B?ZU5UTW8vSC9Pa0dYeTk4TGd6clh6a3IxU3ZBUUZwQnV5TC9XM0R0Mm1yYlVO?=
 =?utf-8?B?bXBSaWk2eE5LTWJNbC8wV3NwMTZ0MTNLYmNmdnovT2ZhY0tHSmMwb3NLVlFU?=
 =?utf-8?B?dVhxcGlpSm1rdDZBZHpnbGt6cXBxVFhtcHkvRXRGYWluVTQ5cUM0MHg0THVz?=
 =?utf-8?B?b0xvbXI3V1J6SEVHQUwxUGlCRzIyUmhNWThNWlEvTVdCdVhhcm1DVjA0VDZv?=
 =?utf-8?B?UVM0d2RQYWJWZVJ6MVNHeURlUExhWjNIeklERWgwWEY1ekMvWHZ1U0pWeUY4?=
 =?utf-8?B?cjlaZmtCaVhEUEpGYkxqRGdWeWh4MEs2SFVSYVJKaXdZVklUUUtXcDRhQndy?=
 =?utf-8?Q?Y731byYzTYCMmsmdMpmcaEEwZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c85539-8237-4365-ee4b-08dc7314b2bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 06:19:51.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui8PZPLjgIheufyqgKGMo49txAn9Zl/WzDpgvij9WnN4iyYvHAPSpd3OGt1v8UB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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



On 5/13/2024 9:44 AM, Ori Messinger wrote:
> This patch adds 'ring hang' events to the driver.
> This is done by adding a 'reset_ring_hang' bool variable to the
> struct 'amdgpu_reset_context' in the amdgpu_reset.h file.
> The purpose for this 'reset_ring_hang' variable is whenever a GPU
> reset is initiated due to a ring hang, the reset_ring_hang should
> be set to 'true'.
> 
> Additionally, the reset cause is passed into the kfd smi event as
> a string, and is displayed in dmesg as an error.
> 
> This 'amdgpu_reset_context' struct is now also passed
> through across all relevant functions, and another event type
> "KFD_SMI_EVENT_RING_HANG" is added to the kfd_smi_event enum.
> 
> Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
> Change-Id: I6af3022eb1b4514201c9430d635ff87f167ad6f7
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  |  9 ++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c     |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  7 ++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
>  include/uapi/linux/kfd_ioctl.h              | 15 ++++++++-------
>  10 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index e3738d417245..f1c6dc939cc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>  
>  	reset_context.method = AMD_RESET_METHOD_NONE;
>  	reset_context.reset_req_dev = adev;
> +	reset_context.reset_ring_hang = true;
> +	strscpy(reset_context.reset_cause, "hws_hang", sizeof(reset_context.reset_cause));

Please add only reset cause as an enum to reset context. There is no
need for a separate variable like ring hang.

For a user ring that induces a HWS hang, that may be identified
separately or identified generically with "HWS hang" as the reason. HWS
hang also could be caused by RAS error.

A possible list is -

DRIVER_TRIGGERED (suspend/reset on init etc)
JOB HANG,
HWS HANG,
USER TRIGGERED,
RAS ERROR,

The description string for reset cause may be obtained separately with
something like below which returns the details - no need to add them to
reset context and pass around.

amdgpu_reset_get_reset_desc(reset_context);

If reset is caused by a specific job, reset context already has a job
pointer. From there you may get more details like device/partition id,
job id, ring name etc. and provide the description. For RAS errors,
there is already detailed dmesg log of IP which caused issue. So only
device could be sufficient.

> +	DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);

Please don't use DRM_*. They are deprecated. Use either drm_err() or
dev_err() - they help to identify the device also.

Thanks,
Lijo

>  	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  
>  	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> @@ -261,12 +264,12 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>  	return r;
>  }
>  
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
>  {
>  	int r = 0;
>  
>  	if (adev->kfd.dev)
> -		r = kgd2kfd_pre_reset(adev->kfd.dev);
> +		r = kgd2kfd_pre_reset(adev->kfd.dev, reset_context);
>  
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..c9030d8b8308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>  };
>  
>  struct amdgpu_device;
> +struct amdgpu_reset_context;
>  
>  enum kfd_mem_attachment_type {
>  	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
> @@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>  
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>  
> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
> +			    struct amdgpu_reset_context *reset_context);
>  
>  int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>  
> @@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> +		      struct amdgpu_reset_context *reset_context);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
>  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>  void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
> @@ -459,7 +462,7 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  	return 0;
>  }
>  
> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>  {
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 00fe3c2d5431..b18f37426b5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5772,7 +5772,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  
>  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>  
> -		amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>  
>  		/*
>  		 * Mark these ASICs to be reseted as untracked first
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..c3e32f21aa49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -77,6 +77,22 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  		reset_context.method = AMD_RESET_METHOD_NONE;
>  		reset_context.reset_req_dev = adev;
> +		reset_context.reset_ring_hang = true;
> +		if (ring->name) {
> +			/* Ensure buffer length of 64 is not exceeded during copy of ring->name  */
> +			size_t name_length;
> +
> +			for (name_length = 0; name_length < sizeof(reset_context.reset_cause) - 6 &&
> +			     ring->name[name_length] != '\0'; name_length++) {
> +				reset_context.reset_cause[name_length] = ring->name[name_length];
> +			}
> +			strscpy(reset_context.reset_cause + name_length, "_hang",
> +				sizeof(reset_context.reset_cause) - name_length);
> +		} else {
> +			strscpy(reset_context.reset_cause, "unknown_hang",
> +				sizeof(reset_context.reset_cause));
> +		}
> +		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
>  		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>  
>  		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 1dd13ed3b7b5..e2d65c5c17c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2479,6 +2479,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>  		reset_context.method = AMD_RESET_METHOD_NONE;
>  		reset_context.reset_req_dev = adev;
>  
> +		reset_context.reset_ring_hang = true;
> +		strscpy(reset_context.reset_cause, "ras_hang", sizeof(reset_context.reset_cause));
> +		DRM_ERROR("Reset cause: %s\n", reset_context.reset_cause);
> +
>  		/* Perform full reset in fatal error mode */
>  		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
>  			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 5a9cc043b858..757284ab36e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ struct amdgpu_reset_context {
>  	struct amdgpu_hive_info *hive;
>  	struct list_head *reset_device_list;
>  	unsigned long flags;
> +	bool reset_ring_hang;
> +	char reset_cause[64];
>  };
>  
>  struct amdgpu_reset_handler {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 6b15e55811b6..88171f24496b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -35,6 +35,7 @@
>  #include "kfd_migrate.h"
>  #include "amdgpu.h"
>  #include "amdgpu_xcp.h"
> +#include "amdgpu_reset.h"
>  
>  #define MQD_SIZE_ALIGNED 768
>  
> @@ -931,7 +932,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  	kfree(kfd);
>  }
>  
> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> +int kgd2kfd_pre_reset(struct kfd_dev *kfd, struct amdgpu_reset_context *reset_context)
>  {
>  	struct kfd_node *node;
>  	int i;
> @@ -941,7 +942,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>  
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
> -		kfd_smi_event_update_gpu_reset(node, false);
> +		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>  		node->dqm->ops.pre_reset(node->dqm);
>  	}
>  
> @@ -981,7 +982,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
>  		atomic_set(&node->sram_ecc_flag, 0);
> -		kfd_smi_event_update_gpu_reset(node, true);
> +		kfd_smi_event_update_gpu_reset(node, true, NULL);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 06ac835190f9..3ffe4b61fe4f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu_vm.h"
>  #include "kfd_priv.h"
>  #include "kfd_smi_events.h"
> +#include "amdgpu_reset.h"
>  
>  struct kfd_smi_client {
>  	struct list_head list;
> @@ -215,7 +216,8 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>  	add_event_to_kfifo(pid, dev, event, fifo_in, len);
>  }
>  
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context)
>  {
>  	unsigned int event;
>  
> @@ -224,6 +226,9 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>  	} else {
>  		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>  		++(dev->reset_seq_num);
> +		if (reset_context && reset_context->reset_ring_hang)
> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_RING_HANG, "%s\n",
> +					  reset_context->reset_cause);
>  	}
>  	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index fa95c2dfd587..85010b8307f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -24,11 +24,14 @@
>  #ifndef KFD_SMI_EVENTS_H_INCLUDED
>  #define KFD_SMI_EVENTS_H_INCLUDED
>  
> +struct amdgpu_reset_context;
> +
>  int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
>  void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
>  void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>  					     uint64_t throttle_bitmask);
> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
> +				    struct amdgpu_reset_context *reset_context);
>  void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>  				    unsigned long address, bool write_fault,
>  				    ktime_t ts);
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 285a36601dc9..7c94d2c7da13 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -519,13 +519,14 @@ enum kfd_smi_event {
>  	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
>  	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
>  	KFD_SMI_EVENT_GPU_POST_RESET = 4,
> -	KFD_SMI_EVENT_MIGRATE_START = 5,
> -	KFD_SMI_EVENT_MIGRATE_END = 6,
> -	KFD_SMI_EVENT_PAGE_FAULT_START = 7,
> -	KFD_SMI_EVENT_PAGE_FAULT_END = 8,
> -	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
> -	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
> -	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
> +	KFD_SMI_EVENT_RING_HANG = 5,
> +	KFD_SMI_EVENT_MIGRATE_START = 6,
> +	KFD_SMI_EVENT_MIGRATE_END = 7,
> +	KFD_SMI_EVENT_PAGE_FAULT_START = 8,
> +	KFD_SMI_EVENT_PAGE_FAULT_END = 9,
> +	KFD_SMI_EVENT_QUEUE_EVICTION = 10,
> +	KFD_SMI_EVENT_QUEUE_RESTORE = 11,
> +	KFD_SMI_EVENT_UNMAP_FROM_GPU = 12,
>  
>  	/*
>  	 * max event number, as a flag bit to get events from all processes,
