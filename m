Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8322BD111A8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 09:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217E710E119;
	Mon,  1 Dec 2025 09:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5B982Ifu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497DE10E119
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 09:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRv/mhspu//j8925NVIXHHrt4WYFf8y2aAbw+/2l8EUJlSJAIf55N2z/qSE5Il41qV9zqTUwkNU0FCGWl/1W4V0Azjg98INYadoJLJijMv9JTpVdHyKdPw8CgIi+HFREpUGzyFODgO7eeT1wt8MFb1P7JwqcSzbRxqMuOEIbciADIcncK0AZzussus1m4srwdWPjNhfd6XOL+FSGXXpBXws7Kq/PktLVwgI2lAVm5cZ7emJd/Dh6jxjqe3dKVuVtHYUd8Dq5Cx75IJOqVPQhA5d02X9Wcr04G0E7hC1oJDO6AkRI6OIeZPNrnSuV5Oi9sy84KwqiEfzbI54G/WyiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XczslId314TymJqXazrHPboTuoAKiGAFghbWahUtAPU=;
 b=CtWy0xH9AX7zOPkaqG6pZnIM4k1w0bw8UJYA7VYsEluJkgVplZuYcA6lJOE8ZV0DSbiOoKx8WmGZYNJXKpnXheSKsWaofquHxAEq6HOgzh2tfQIBjiJklopYS9PNO6qIGjK1k52yUjwiudHloQD8wNYFK5Npgp86Iu/5HgYdbssUGyuX7EvJFtURuD43XUyxyi3Z6fQ01SjfBMRkZPmH7lZCt8ureJfusTF0WNvOT/AZX3DiQ6NoQ14aURo2lHy0ZYDQdpcbYPdiR5NLqeoTYTHtxvx13mrNYWUOJiZ4msNzAGRkHqant53FECFSHrGhJKAhUnhNLBEA04QeCO087g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XczslId314TymJqXazrHPboTuoAKiGAFghbWahUtAPU=;
 b=5B982IfunKzMha85aECtj3lwDBn8W433NEPqXoYCNeGHjJO2/569wsnIND/e6SKR6CBpxw/tOPDVSIDpzvdHga+bMl3t2MJf201AFRmLzLuzjZgWDuAHDipxmd3TbX+U77ZZgqLmiRWUMYmRkllS4vA8mu9Gk1Hgs2eJzUAwkLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:53:07 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:53:07 +0000
Message-ID: <07918320-9ff8-444a-840f-e7ca38a4d1e6@amd.com>
Date: Mon, 1 Dec 2025 09:53:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Trap handler support for expert scheduling
 mode
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251114204840.857161-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20251114204840.857161-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::21) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: d376c240-444e-442c-5614-08de30bf6dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clV4dGQrdzQ5b1BWYjU5YUJIcUJXc2VtMnFaUkVSeDNBeVUraVZud3puSGRE?=
 =?utf-8?B?Mjd3SXk3R3VRNjdSeHNXazVuN2M5ZTNmZHo0THUrYlQ1OE9CZVNYeHVob0w0?=
 =?utf-8?B?YmlzTkxkVDc1R1lldElSZHU5WVBycGVNQURqcUZYcVRvQlVneWQ4QlVCLzJh?=
 =?utf-8?B?SktoQVg4TkRDSVpUUHVNbUZnTFZqR2ZIQ3JiNytKQ2FZOU1EY3ZZdmQ3Z3N0?=
 =?utf-8?B?L3dlVTVmaEJQZTBDS0ZnUVkzTVFjOGtCbDFXK3ZnYTFUTXlsRG1WUk1RUmdn?=
 =?utf-8?B?R3pnclUxeXhLZkVxRDlhVHRYSUVLb3VsRUUxdVVHQk5ndlVOa2xMeE96ZmJY?=
 =?utf-8?B?WXJyRlBjYk0rUlM1SThSeU9EWFVYSng5cGRRK3hIWFRLU0ZkUDVBVkgyVHZ0?=
 =?utf-8?B?eWh1UFN6amNFN2F6QXg0SWtucGJqdFhhM0thb24vVmZsaFR5RkxIdWtPWW9M?=
 =?utf-8?B?dEMvT1Bqb0ErZ0Vsb1FwYWo0djFBU3NDTlo3NjJ5RDM3Q2JSbTRvcVBpRXVX?=
 =?utf-8?B?L1R0QnpWVFZ1bnhNQ2JFS0RZSnNNd0JmdGJSVVRHWXphTVJXT2xDcVkyMCtI?=
 =?utf-8?B?UitkZ0hlZkxwMXoxbnk3aEdDVU1rZVlmSUMvYXptOEZYdFlVanBVaWZPOVg3?=
 =?utf-8?B?Tk85U3ZaQ2dYWkY2cDAweWZCSUJoYVBDb0tFUys1ZytYdmswcjNnWEc0VEh2?=
 =?utf-8?B?aTRYeTBYaUNQY1lvTVRiSlAxUnpRMG4vU05zdkVGYWhVTWwvQkdMdjFDNk1X?=
 =?utf-8?B?K1phcmo4RVcyczVuVURVSnpxVDlOejZ5VE9IOERkYytGMHc1dlhZQUZoL3R4?=
 =?utf-8?B?djlXaThuenJtTVdDT21iVzFrOEdpZU1mNEJYN2pwM0JqY05ud0dKaHFjZlp1?=
 =?utf-8?B?cmtnN1MzdEV4UmpXMFNJdFVVa3NNaWZHU3l5bUVLNTFJOHJvMkdSVTdPMjZG?=
 =?utf-8?B?RTFENi9RZTZvdUNKeFJnRjhSQ3NseEd4N2czQUZMeE9pQ1VqNDg4YWkwZXpC?=
 =?utf-8?B?elBjcEF4Y2RISGZrQms0a1hVK3JuMC9FSU1pUHU0Rk4wQ3UrNlJ6VExvVk1m?=
 =?utf-8?B?N3BXZ0s0Ym1oRkVnUVEwZjdqYzRzak9jRHJHbkFweHU4UDQyY05OOGF1MGQ4?=
 =?utf-8?B?Uk85UVhEZE9hOU1YeW9uajIxOUE1V0VDbG5pN3grTXZ3bjgyTDJRdXBaaWQ4?=
 =?utf-8?B?STErS2ZyRmdqUHhqeDhNb3VueGxRVmhySmlpQ0xzQVkxUGx5K2pLQkZqbHF6?=
 =?utf-8?B?eGN0TlhxQm5TMzU2Qm5TeGZQNmpJeER3cDFwTGlPWmxMRzlCeDd6NWlHK0h1?=
 =?utf-8?B?bWt5azRBWHF0SHYrWVF1TnBnVFNOU3BvaGptMTNxeGpLZVkrTHdETmxtazcy?=
 =?utf-8?B?dmhTdHNKRmVSUXRhNjRQZmJLYWxhcm5lWUN2ZGEzMDJIVEFpWW5vVnJTVGtp?=
 =?utf-8?B?UTdIUVhqQktvNUE4VjFYQTJGT3VMQlpmRnh1MkFGR2hEdWp6MXhEVDRiVldL?=
 =?utf-8?B?K1FIV29ERXNKY0VDbmRQYWFSck9VVm5ieFUvYW8wUE9reUZ1N3VaNGc2Z0Zj?=
 =?utf-8?B?MFJXdDg1MVNha2NjbWdiTnZzSkk0czcwY1prRnNkN0VkWGgza2xtdWRnajhm?=
 =?utf-8?B?NVk2VHc3TFg3a1VlQ1N2VnM0NTZ5ZThiZWZBeDJrcVJPMVhYUS9KRktiRkpj?=
 =?utf-8?B?eFBPeEtVRnNGcTFzc2xPdVlIZ1BNYmFha3ZoQm5QQVpPdHR5VlY1ZkJKUTFy?=
 =?utf-8?B?aG0rczVidCtvNzhTNEMwc0czWEtzVGVKL2NaYkl1NFgzcUV2citxNzJBc1Zw?=
 =?utf-8?B?ZTJITWE2NlM5SlpxcWgxSkd5OVJjbHFnbS9ZTkNrZjVXQWdiTWJ0WVFtMnJa?=
 =?utf-8?B?T3Raa0VSRW9NcWFmY2ZWcFBBeHI0c3JyS29kY3U0YWpkU0pXS0xRSGlLbW5q?=
 =?utf-8?Q?XciSlLI3OSTOxfFA3CtbJyxs9FMpe/7M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpnNG9rTXFoQlFwWDRTVG53V1F3Y2E0NHVKN00wQ3oxZnNwVGg1aGRWSHV3?=
 =?utf-8?B?M0NmbFNKVmpYNlE3NThGR0djTkE1TEYrc0hJdkhGZlBQVDVjN0t1RDJ0Z3dj?=
 =?utf-8?B?NzBYWXo1aHhjeXdTbmNvS3ZaVFpCOE41VDVEOGxlaTYzdWlEY1lOekVUNkpp?=
 =?utf-8?B?Tks4RCtkTkl0NE5Cc3FIRFJLbTF6RDFQaS9rZkJkQTN6bVZtZVVCR0xTQnoy?=
 =?utf-8?B?Wk9rYVljazZHWU5lUTYxSkZMYUtLZE1qWU80MUZFSFZ3N01abGZTbmRyTjFJ?=
 =?utf-8?B?TGp6d3pYL01NSWVGZk91cXFVMUsyRzZEcGJhZWdadnFURGJVdlNoeWt1MkU4?=
 =?utf-8?B?aXJNMmdzL3BDRklNS1lMS1hxOWhwckg2OTN1ZlNnc3FMMUdJeHpGZTEremJk?=
 =?utf-8?B?MUNqT2NCRkFtSUErNEdIdzUzaUxhbkFqYzcyL1pGT3BRUDVIQ1dpU3B0aUtC?=
 =?utf-8?B?NXl6RUROOXdKQnc3NmlHWDJTZXBiTU81Q01VSlQ1c2xFN3RnRXNhK0JQVU9s?=
 =?utf-8?B?d05zT1VZN1Z4a1VrS1gvQ2RDMzlLWFFoaWdJNDAzT2tGMFJzaVR3MEE0T2Qz?=
 =?utf-8?B?ZEtUY1B4MFlwUm16bmJ6SWp3UDU0WHEyemZkMWN1c01CaGRqSzEzYndyc0VZ?=
 =?utf-8?B?a3E1T0FUM1VlOFFPSmtpSWxrUUh2Z3VUaWhUdUY3eUtnNFp2T3pkd0o3aUM1?=
 =?utf-8?B?WGlSV0ovczdjUXpuSXczQ2l0L1Ewb09TNHJJenQ5UVdQYzFNU2pWS3JmOXlG?=
 =?utf-8?B?TUNQT2pSamIrYklhcExuQThFOEYyQlMvNmN6QjRZZGhRU1owR1R2MFlPWE9x?=
 =?utf-8?B?V3QyUXBvb0pRbk4yQTcwT01vejl2RkFQZytkSktySmRhcGdQOXdEZDN2M1Rt?=
 =?utf-8?B?cVBJMWtDM2lvOXhvRS9TVSsxK253MFNJd0djU0VLWkRuUGNTNmlhUk50TWpX?=
 =?utf-8?B?bVl0cFFFSUtHWXFSTG42NllBa0FaT2NueENreURsa0VGWk5hbzQ5QjNSbmgz?=
 =?utf-8?B?NnROSFBQcklPTGdPQ1lnSEljc0R5bGhBdUU5aUdOazE1L1BFMEFOOXpSdzQy?=
 =?utf-8?B?WkJxcytaYmpNQVBHUjJWRlA5Z0tqU0VURGF3OHRHWCtINXdBcEdZR2Fpa2xQ?=
 =?utf-8?B?cmZPRFFtZm5zNHVIY2hxaGRpbkw2QkhZRXUxdmRFY1pSMEpCNEtkYWU0OHhO?=
 =?utf-8?B?R2ovYzFNSWxhN21NMTFydGhTejRNaVBIS3d4cnBKdHZ3dUlxVkVyR255OTF4?=
 =?utf-8?B?MlFiNGFVaTZyUjZucFhTNTgwR0wwTnErcEp0OCtGcm1UUU5nYVpncDFNS25u?=
 =?utf-8?B?RHozV0VsTzMyWlZzdUtrd01KM1d0a0pzY3p3V3l0M3dCV0tnQktwTWJoQlo3?=
 =?utf-8?B?TVJENzZFcnZ0M1c5MTgxbFFMZ0lLZHB0Vit4aUZOMXZ2UzJmekpLSTVWNWtN?=
 =?utf-8?B?MVBzOENhUnFFd1VDM1VldlRpNU8rdDZVWUlaaFJlc0VVWUtGSnRQSlBwb0d2?=
 =?utf-8?B?Yk9mTlEwTE81VElXbUpVVE5uc3hIRVhCd082cnpGVEUwY3ZKcTM5bDlFejg1?=
 =?utf-8?B?L2hNc01KTXliTGp5RGVwY0licnRzTng4NEZFQjZlNGY5L3pNcEdjditnOUxZ?=
 =?utf-8?B?ZVQ0ZmJaVkdMeGM4b2s0SUpBTkhhdVNVdFNDVHYycmRCUmw0SllDYmxEQU04?=
 =?utf-8?B?Wm5xejhtaW5xWnNiYU14QUY2NmNFZTZ5VWx0Q1BnV1QyQUdFRnRvd0RTeEZ6?=
 =?utf-8?B?TndZMzA4ZXZXeEt5OUJzcFRscER5K3FHb3dZcmJ3cXBkbi9sVzJuZndjUW93?=
 =?utf-8?B?cEo5OUpzdWtiRlZydHl4c2oyaE9mUW5aeHNicE9JSkFkNVNtWVlERjloL1VQ?=
 =?utf-8?B?UjhrcCsxby9pZXVCS1pEWmRxQ0FkMk5kL3VVVEZrbGtMV3pFUEVDb09XWlpF?=
 =?utf-8?B?aDBIM0hkTDEwREVXRHZCSFdJWTE1UG9LelBNb05vTVozcUdlWnRMa2xTMlVR?=
 =?utf-8?B?dWZNMk0xOE1ZZFBGTTRMeFNOb0Y1eVNyNVVVVU5jWFpMOXlLdStVdkljREFT?=
 =?utf-8?B?VHg4NXJ6V28raUMyMEEyTnBKWEZJY0xRWTRoSE9ISHRubGFQS0lNem1idWVQ?=
 =?utf-8?Q?O3M34Kn2sF4Lt8WgAKFAVuJni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d376c240-444e-442c-5614-08de30bf6dc6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:53:07.3939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1CkX2giEgFXlHaVLgrMe69zR++n8tSBBrvYRyD+U5tLvioTxyvUzdiW9EiuBbCeNlbj4SDezeBojgiXC/GQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460
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

Hi,

I thought I replied to the list, but only replied to the author.

This looks good to me, thanks.
I noted one possible improvement lower, could be added in a later patch.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>

Best,
Lancelot.

On 14/11/2025 20:48, Jay Cornwall wrote:
> The trap may be entered with dependency checking disabled.
> Wait for dependency counters and save/restore scheduling mode.
> 
> v2:
> 
> Use ttmp1 instead of ttmp11. ttmp11 is not zero-initialized.
> While the trap handler does zero this field before use, a user-mode
> second-level trap handler could not rely on this being zero when
> using an older kernel mode driver.
> 
> v3:
> 
> Use ttmp11 primarily but copy to ttmp1 before jumping to the
> second level trap handler. ttmp1 is inspectable by a debugger.
> Unexpected bits in the unused space may regress existing software.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 62 +++++++++++--------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 37 +++++++++++
>   2 files changed, 73 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index 0320163b6e74..f98c735b2905 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -3644,14 +3644,18 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
>   };
>   
>   static const uint32_t cwsr_trap_gfx12_hex[] = {
> -	0xbfa00001, 0xbfa002a2,
> -	0xb0804009, 0xb8f8f804,
> +	0xbfa00001, 0xbfa002b2,
> +	0xb0804009, 0xb8eef81a,
> +	0xbf880000, 0xb980081a,
> +	0x00000000, 0xb8f8f804,
> +	0x9177ff77, 0x0c000000,
> +	0x846e9a6e, 0x8c776e77,
>   	0x9178ff78, 0x00008c00,
>   	0xb8fbf811, 0x8b6eff78,
>   	0x00004000, 0xbfa10008,
>   	0x8b6eff7b, 0x00000080,
>   	0xbfa20018, 0x8b6ea07b,
> -	0xbfa20042, 0xbf830010,
> +	0xbfa2004a, 0xbf830010,
>   	0xb8fbf811, 0xbfa0fffb,
>   	0x8b6eff7b, 0x00000bd0,
>   	0xbfa20010, 0xb8eef812,
> @@ -3662,28 +3666,32 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xf0000000, 0xbfa20005,
>   	0x8b6fff6f, 0x00000200,
>   	0xbfa20002, 0x8b6ea07b,
> -	0xbfa2002c, 0xbefa4d82,
> +	0xbfa20034, 0xbefa4d82,
>   	0xbf8a0000, 0x84fa887a,
>   	0xbf0d8f7b, 0xbfa10002,
>   	0x8c7bff7b, 0xffff0000,
> -	0xf4601bbd, 0xf8000010,
> -	0xbf8a0000, 0x846e976e,
> -	0x9177ff77, 0x00800000,
> -	0x8c776e77, 0xf4603bbd,
> -	0xf8000000, 0xbf8a0000,
> -	0xf4603ebd, 0xf8000008,
> -	0xbf8a0000, 0x8bee6e6e,
> -	0xbfa10001, 0xbe80486e,
> -	0x8b6eff6d, 0xf0000000,
> -	0xbfa20009, 0xb8eef811,
> -	0x8b6eff6e, 0x00000080,
> -	0xbfa20007, 0x8c78ff78,
> -	0x00004000, 0x80ec886c,
> -	0x82ed806d, 0xbfa00002,
> -	0x806c846c, 0x826d806d,
> -	0x8b6dff6d, 0x0000ffff,
> -	0x8bfe7e7e, 0x8bea6a6a,
> -	0x85788978, 0xb9783244,
> +	0x8b6eff77, 0x0c000000,
> +	0x916dff6d, 0x0c000000,
> +	0x8c6d6e6d, 0xf4601bbd,
> +	0xf8000010, 0xbf8a0000,
> +	0x846e976e, 0x9177ff77,
> +	0x00800000, 0x8c776e77,
> +	0xf4603bbd, 0xf8000000,
> +	0xbf8a0000, 0xf4603ebd,
> +	0xf8000008, 0xbf8a0000,
> +	0x8bee6e6e, 0xbfa10001,
> +	0xbe80486e, 0x8b6eff6d,
> +	0xf0000000, 0xbfa20009,
> +	0xb8eef811, 0x8b6eff6e,
> +	0x00000080, 0xbfa20007,
> +	0x8c78ff78, 0x00004000,
> +	0x80ec886c, 0x82ed806d,
> +	0xbfa00002, 0x806c846c,
> +	0x826d806d, 0x8b6dff6d,
> +	0x0000ffff, 0x8bfe7e7e,
> +	0x8bea6a6a, 0x85788978,
> +	0x936eff77, 0x0002001a,
> +	0xb96ef81a, 0xb9783244,
>   	0xbe804a6c, 0xb8faf802,
>   	0xbf0d987a, 0xbfa10001,
>   	0xbfb00000, 0x8b6dff6d,
> @@ -3981,7 +3989,7 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0x008ce800, 0x00000000,
>   	0x807d817d, 0x8070ff70,
>   	0x00000080, 0xbf0a7b7d,
> -	0xbfa2fff7, 0xbfa0016e,
> +	0xbfa2fff7, 0xbfa00171,
>   	0xbef4007e, 0x8b75ff7f,
>   	0x0000ffff, 0x8c75ff75,
>   	0x00040000, 0xbef60080,
> @@ -4163,12 +4171,14 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
>   	0xf8000074, 0xbf8a0000,
>   	0x8b6dff6d, 0x0000ffff,
>   	0x8bfe7e7e, 0x8bea6a6a,
> -	0xb97af804, 0xbe804ec2,
> -	0xbf94fffe, 0xbe804a6c,
> +	0x936eff77, 0x0002001a,
> +	0xb96ef81a, 0xb97af804,
>   	0xbe804ec2, 0xbf94fffe,
> -	0xbfb10000, 0xbf9f0000,
> +	0xbe804a6c, 0xbe804ec2,
> +	0xbf94fffe, 0xbfb10000,
>   	0xbf9f0000, 0xbf9f0000,
>   	0xbf9f0000, 0xbf9f0000,
> +	0xbf9f0000, 0x00000000,
>   };
>   
>   static const uint32_t cwsr_trap_gfx9_5_0_hex[] = {
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index 5a1a1b1f897f..07999b4649de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -78,9 +78,16 @@ var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
>   var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
> +
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT		= 0
> +var SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE		= 2
> +
>   var BARRIER_STATE_SIGNAL_OFFSET			= 16
>   var BARRIER_STATE_VALID_OFFSET			= 0
>   
> +var TTMP11_SCHED_MODE_SHIFT			= 26
> +var TTMP11_SCHED_MODE_SIZE			= 2
> +var TTMP11_SCHED_MODE_MASK			= 0xC000000
>   var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
>   var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
>   
> @@ -160,8 +167,19 @@ L_JUMP_TO_RESTORE:
>   	s_branch	L_RESTORE
>   
>   L_SKIP_RESTORE:
> +	// Assume most relaxed scheduling mode is set. Save and revert to normal mode.
> +	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_SCHED_MODE)

Could be hwreg(HW_REG_WAVE_SCHED_MODE, 0, 2)

> +	s_wait_alu	0
> +	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_SCHED_MODE, \
> +		SQ_WAVE_SCHED_MODE_DEP_MODE_SHIFT, SQ_WAVE_SCHED_MODE_DEP_MODE_SIZE), 0
> +
>   	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
>   
> +	// Save SCHED_MODE[1:0] into ttmp11[27:26].
> +	s_andn2_b32	ttmp11, ttmp11, TTMP11_SCHED_MODE_MASK
> +	s_lshl_b32	ttmp2, ttmp2, TTMP11_SCHED_MODE_SHIFT
> +	s_or_b32	ttmp11, ttmp11, ttmp2
> +
>   	// Clear SPI_PRIO: do not save with elevated priority.
>   	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
>   	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
> @@ -238,6 +256,13 @@ L_FETCH_2ND_TRAP:
>   	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
>   	s_or_b32	ttmp15, ttmp15, 0xFFFF0000
>   L_NO_SIGN_EXTEND_TMA:
> +#if ASIC_FAMILY == CHIP_GFX12
> +	// Move SCHED_MODE[1:0] from ttmp11 to unused bits in ttmp1[27:26] (return PC_HI).
> +	// The second-level trap will restore from ttmp1 for backwards compatibility.
> +	s_and_b32	ttmp2, ttmp11, TTMP11_SCHED_MODE_MASK
> +	s_andn2_b32	ttmp1, ttmp1, TTMP11_SCHED_MODE_MASK
> +	s_or_b32	ttmp1, ttmp1, ttmp2
> +#endif
>   
>   	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS		// debug trap enabled flag
>   	s_wait_idle
> @@ -287,6 +312,10 @@ L_EXIT_TRAP:
>   	// STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
>   	// Only restore fields which the trap handler changes.
>   	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +
> +	// Assume relaxed scheduling mode after this point.
> +	restore_sched_mode(ttmp2)
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
>   		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
>   
> @@ -1043,6 +1072,9 @@ L_SKIP_BARRIER_RESTORE:
>   	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
>   	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
>   
> +	// Assume relaxed scheduling mode after this point.
> +	restore_sched_mode(s_restore_tmp)
> +
>   	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
>   
>   	// Make barrier and LDS state visible to all waves in the group.
> @@ -1134,3 +1166,8 @@ function valu_sgpr_hazard
>   	end
>   #endif
>   end
> +
> +function restore_sched_mode(s_tmp)
> +	s_bfe_u32	s_tmp, ttmp11, (TTMP11_SCHED_MODE_SHIFT | (TTMP11_SCHED_MODE_SIZE << 0x10))
> +	s_setreg_b32	hwreg(HW_REG_WAVE_SCHED_MODE), s_tmp
> +end

