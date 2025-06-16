Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ACAC71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 14:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36079890B6;
	Mon, 16 Jun 2025 14:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wXM+q3op";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26ABD890B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 14:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUOk/XcQKu4aQJGh1tVPOEYjaCiOoZ+pM+dRjqlNFKEIfpzkC40rPg+zrS2DE0s7nSyfrx4HKzs7QDYpv6W+Bm8nmmXr4zM9w8P+tJwQKGwuGds97PTQZxiT6+E5qOK6BIPaCbAmPFyBupvW/OpZJ5KyuQv8FBxrT8bmRvM8OgncPjTmBLXzs6qKhD98ye33N599+r1osxqer6y8IKiIWXl0PGcypM2z72b+qFZBJZ6+H32V4mfbetIjmbuAhDEf91tIM6n5Tk3G4ClsWMzRXnhl0120KmsmwF5JShC0EPY5rZWjQyJcYljkMhryQulU5BQjgPPPE2C/lFC+/+OdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4I+LNC/COELRoWExs18ClQMAxDnX6KDkP7nlc/CCsw=;
 b=VqUSs7jTmpHGW56V0dqfZREf0HmvrmMWgrD0ub4cmGvcktrPzzkchIp31DN5rw/mwUFd0XMP5FVvHk4S5x3dIydy2+2wxp7LrPvCReWOuf8WJMTre/t2iFZxd+d1RjrHw/YeXg+3exfuI95UujlAVUx7N9ZnBFaPB5jEUaYm8x1rtrpKrTn+fMnGQQPJA9xttFI71KTnD0fdhuilZh9PpdorHsZE6q1+UBKLu2NHyj7kwp6LYmx0xBfmXo17VzyVne4qKtxUu7i6hO5wPmGGGjKPk8zyHg6tVgCSTcdD1wZ/5ZXiiFCZLe7s5YWPySV9jgfH36fGd07j4TMoChlNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4I+LNC/COELRoWExs18ClQMAxDnX6KDkP7nlc/CCsw=;
 b=wXM+q3op/0sR5hoeEmTn+pSMhROFl4WtCkdVUklWjjTurcRkbMz8MZ9l2OG2MzcRc3a/6aW1Ply0Fj0Y61iNFrCCh0/jWScuz+flyHukdz/HC2YqRld/AyaUjXk/JYXYYNwDMJouyPUqjhKWMA02rnhA76oTVVrbPd7w1jKOrp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Mon, 16 Jun 2025 14:02:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 14:02:47 +0000
Message-ID: <71166c0c-6b0b-4f20-8a3f-5110a673c5b3@amd.com>
Date: Mon, 16 Jun 2025 19:32:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org,
 Kenneth Feng <Kenneth.Feng@amd.com>
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 64068ca9-56aa-43e9-1196-08ddacde78b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlBVUG92eWVIdVhMS24vYTkyQ2IrZEJRTmtuMFlNUWxiSWNySllJeDJZRldX?=
 =?utf-8?B?RnZTL3R3cWhzYnZSNHNBSXlRcU9xMnJGNEl1Y1F1cCs1am0vcTd6Q3U4VVov?=
 =?utf-8?B?LzhwK0hDMEFSaVczTmdYVGUwSGVGSmlpUlFDRGNvMWRIZll4SHU1UnN6clpN?=
 =?utf-8?B?MGh2WVNWZyt6MGZDTnVKRmdRL2pTeFd0YUd1NkxTVTVlT3UxVTBBbDhCa1Bl?=
 =?utf-8?B?dzN3WnZqb0hQaDVzL2cxYjE2OFptYlFKOXpxWk55QzU4OEpYTHFDSzhnTGVB?=
 =?utf-8?B?VzcyanJUSS9aT2VLeHBlS0sxeklnS3IyZFNlcE5Xd1FoNlMxUXh5eG9xNGw1?=
 =?utf-8?B?WmtjTEZJUXJ2UDdkNndFREpMTnpOMGtwaGpnK3BYWDNaRnVLdkFPNEFlemVC?=
 =?utf-8?B?d1ltdU5kaS82MVRYWHBaQUFjUTZ1aWZJNXVrL0x4VkROZXRRMDlJY0FTRHVG?=
 =?utf-8?B?MUYrczdjVnkvQ1YvVUNMOFM2ZTdHNEFlaC9LMURvWFI4M2NnbUFxbkE4MVMw?=
 =?utf-8?B?NlVrS0ptTEVyOEU3MEwydDNFRE84aGVTcHBUOUQ4cXlYS2xvMzhRMk11NHd3?=
 =?utf-8?B?WHIwcmFlajFFSDNXU2FNeXAzRXFGZ3VMT1dVUDQ3QWY0czAva2VldjFzSzQv?=
 =?utf-8?B?aUZaMEZoWUpJR0ZPUzFTYkhHUEJCL0hnUEtUcGw4UlpNNS8vZ3hENUkwZUk0?=
 =?utf-8?B?Rmo5ZXBDU3pPc0gxZWtreFZjZkpJSGIrcjhYZ0V1R3dyTmcwUElMOEQzNllP?=
 =?utf-8?B?d3ZFK1QzOWlvdURzcVBHQW9pZjJvbVI5L3diUDJMQnBqWTliV0R3SDFXaldt?=
 =?utf-8?B?OElrd1d6QWlqejczRjBXRkFmbHJ2VnUvOGM5K1J3TWtQSzRhaThnT1Y0R3Fx?=
 =?utf-8?B?M0ZVOVRNWTBQbmU4ZDJiVVkrNkFoWlFJWVV1K20vRUN4anozQnN4WEZjeG96?=
 =?utf-8?B?RTh3ZERMT2NZd2ZmTXljSi82R3BVR3lSQU1DSml0NzFoM1p1Q3pGTGZzVGhp?=
 =?utf-8?B?NFRFOUFkSXBzSUNzNjBFNVpDOTBWOG9pL2Z4YzVkejdEektOekhQQkJRekJT?=
 =?utf-8?B?bW5sYnBDRWt2NXUvaCtmeXhteTZrMDFSd3NHN0crbTBva0dnSzdFRmhyVUVv?=
 =?utf-8?B?Sjh1VC91M0M4Tm04N3gvbnNXQTVpb0o0VjV3LzdibjR6Z25TYVl6UjR2UE15?=
 =?utf-8?B?djRyK3BqNmlMR2NPMWduSFBYQ2g3ZjdJQTljemtFUGtmalF1SjhTYUNpMXNC?=
 =?utf-8?B?UnVnUm1ZNGxLRGRVWEtrM1NzNEVTcTFyaFhhQ0x2NnRTZ0RKQnYvTUtoWThs?=
 =?utf-8?B?WWRoTUdoMVN4ZTFrRjIxZk1tTUVEWk5ER0N4QVFWeld1T1RxTUpYMG40bnVC?=
 =?utf-8?B?bzcxTU5NUytoZ0ZMeG8wdDdEK2dvdGdUQjlUVnkzWHZ2TlRxN1JXcGp2ZTF2?=
 =?utf-8?B?RTlBWDVEQldLeE0zWHJ5QXZGc00xNFFabHdxaWh0TDhZdXlCQjNQZEhZTDFJ?=
 =?utf-8?B?ZDFuc1JGWUVBRjUvQTI3TEUrZUNaayt0SWJUSk9UVUJwNjZ2bmtBQVJ1U21D?=
 =?utf-8?B?Z0FYZGlZWFFieUNKaWVaRTRKaUo3dHRXaE5HazlLRkMzYjdSdkZSSzBabUx6?=
 =?utf-8?B?WThzWDEzd2VWTGZNZUpmSnhId0thbTBOaG8zclQzZ0cyVUtqaUlSQktPWlZD?=
 =?utf-8?B?WXg0QjlOMUIzTkorMTZPN1QxMkhTN2IvWDFCQm81ZjY5dURud3FMSzg1WXRR?=
 =?utf-8?B?SHJBUHNNQUFmK2hsSFdpVk5nakxEcURnTXkvYXdaTldlM1R0SzlkMzlLTXVR?=
 =?utf-8?B?R0FNOVRkR1Fwc05wMDNJVkVZL1NTMXE4elZSWmJ5OXE4MzF1UStIa1NISlM5?=
 =?utf-8?B?b0xxVktwczh3aU82MkJtSHRYcldMSXRaZVF0MGJkK2pzZlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0NGdCtueWJDWFNWNkJ0REIyNldlcUl2ZWMwTlVJWjZQWW1rMXBJbUltbTV3?=
 =?utf-8?B?cnd5RldRaTBtb1VzKzNsTjBYay9SYk1CQ2s5bWN6djhucGkwYTVJZnlhNCt2?=
 =?utf-8?B?dVNFMDE3aFp4NEZXbmxCcTlkVVk3eDR3RHIxQXRwdk5DdTVxVlZnU2NwQ0lS?=
 =?utf-8?B?SlRldlhlNThwcytqZHRUTzNkeFk1ekcvVGZDV0s2WXJCeHFCRk1EK1dORWtw?=
 =?utf-8?B?VDhtalptMWVzMmlLdUwvYjA1QStrcis5WXNwdkJ1YWF5cEJTckJ5VDhBUjVU?=
 =?utf-8?B?RTMzcGNKbnZMOGlTNUJtUTZ4YlptdkxmdWM4V3pxb3IzMTZtdkRGT0JFcjR5?=
 =?utf-8?B?R2FPNncwVE9lQmVRNWF3eml4aE9OeEdDM2dSb25mZjNOODBOdTZxTnpZWkZC?=
 =?utf-8?B?bWxxa1RmNUpMN3RTSzRNQVVCQk1vN3V0REU5MzdiREIyQ05neWwrd2NDMzlF?=
 =?utf-8?B?S2owanN2dzNuZmFmRUpkTFIwUmRCYUszY3BDN0tsWWtUQ3BMWTdIalV0RjFa?=
 =?utf-8?B?V3FmSHZyOVhhUVFsejN0cEk1bHl2b1FPaTNxVUgrbE9MNUhOZHN1WTZzSEUy?=
 =?utf-8?B?T0JtRFA3bWV0YXVGTk9lYlR2Mndjc1NRUi9qN1kybXBwdzZ2dTJxRkJRN1ZU?=
 =?utf-8?B?UUs2QUdSLzg5d3dmRys1UkR5cEFqaWpuRkx5NklOSzgwNGV5L1I5UVZIRCtE?=
 =?utf-8?B?dURQRmlraTIzeGlQMHBXaXZvTHVnVHZvOFM3bW9yZ0lyUnlzUXBrdy9MTC93?=
 =?utf-8?B?eDZ1QUUvY0Nxb1lKQ2c4MWxSSHRkZ0Q3N3kzbUgwclZ1K2RtNWxyd2NTN0dI?=
 =?utf-8?B?SU10QWdZc3FRMmFZd2I3UE56a1NtSjJNL1Q4SXNSdkkra2FOQnJyQ3FpeUR2?=
 =?utf-8?B?ck1PektNZGcvcUIyTnlCdndNSmdRZXRDZG9pcnJoci91ZzhGR1RGTUMxUFc3?=
 =?utf-8?B?MlM0RzV1L3F6OEhPN3l5ekVZbW94ZzZneEx5Z3NuckVJalg1VTF3SEhKei9L?=
 =?utf-8?B?aWlVSVRXd3R4NHViS1hDQk9oQUF2MEhSYS9HYy9qclMvSWF2cXVVa3JtdzhX?=
 =?utf-8?B?K3NnZUg1aW1TTzV3bnlKNEJ4M3YxWjd3bkR4ZmNCMTJWZSs4YmphcWV3L2li?=
 =?utf-8?B?ZUFpbExSQzhiREEwVTZ5MkVIYXZCTEdNajdGQUhSN1Q3dWZvWUhOQUFzcHJM?=
 =?utf-8?B?YTZta01JMEp3RGE1T0hGUUptL1lxOVJsRHlIREI1VXJtRXhKWHgxKzVaT202?=
 =?utf-8?B?SVNzSHRldm9GV3g3K1RHSlNqODZZbTRIc0lmSU5yUWJLZm4wRlFvcUVQc3pq?=
 =?utf-8?B?Qnp0NHJGbFFLTjhkbUEwbENjU01PbndKVEl4Q05zb1pPdnVIWUJLcVN5Y2hW?=
 =?utf-8?B?QWJxS3BBcUpxN3BVN2o1T09DYU8wYVZFWTFXOHA0eVEvQzU3Qzlwb3h0a0VZ?=
 =?utf-8?B?c2liQUc2SUx3U2FuNXZYcjQ0NHloVC9nTVY4bVJOekVRSFVWMXV4QVdoSzFK?=
 =?utf-8?B?SklDM0RnOWtTYlBLdC9rdzJTUkVjMGk3MmVHTkhHK3pHQ0RwRHZnWkdjdkEz?=
 =?utf-8?B?V3Y4bmdYOWYrTG5Lb0l6RXZMeHFWRWRIalFCeVdSaEFYZ3RaaGtwNWtzUGw5?=
 =?utf-8?B?VW5NdnFDTTgrdkltYzBoSG91MXJ5cWJwT0dRUksra3Z1YTNwUUptYWxyRGpa?=
 =?utf-8?B?WkNHeGJCWGZOUkVkVWdXQlF5UWZIRG5GazR4Mld4cWhYMnl5M0R0YTBDWDZN?=
 =?utf-8?B?aTlRMEVpODdIMG5zT0daUS9JVGV0Z21pU2pSODdjWnd6OVBTVlF2THR2ZlRo?=
 =?utf-8?B?SEhSRldZWE5FbHdqWjJ5QWl3am1YNVJTNEFkZDQ3Q3BscksyWU9JV0lIcEVr?=
 =?utf-8?B?Rld5c090NGV3ZU9PVzFzemlXMGM1ZUNpcjNCUmxnSTcva1lzczdoY2p5MHAx?=
 =?utf-8?B?T1NPQyt1OGlTUjJTMXZEbE1ieE9xVnNzRENxWnZ5aFFpR2UzTThCZXh4UVVZ?=
 =?utf-8?B?T2VaWTE1NWJzS0o2WDNzS3FKNTlCV3dxN2ZzaENvNDYwTlI4NGhydXo2RGR4?=
 =?utf-8?B?Tjk1QUdMTE44M00wMG8zUVhMQWF5Y21pdzZ3YmxJTkp0NnQ2cTloUGs0TVZP?=
 =?utf-8?Q?yjqT/KbQBQaYLkv1teCjTir9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64068ca9-56aa-43e9-1196-08ddacde78b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:02:46.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKfVsPvGwj0GwEYy6361Uh67j6t1bRsqxhQcb/1mSgcFInzKHT4KakAZMjWl4lKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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



On 6/16/2025 3:09 PM, Peter Zijlstra wrote:
> Hi guys,
> 
> My (Intel Sapphire Rapids) workstation has a RX 7800 XT and when I kexec
> a bunch of times, the amdgpu driver gets upset and barfs on boot.
> 
> It starts like so:
> 
> [   16.926489] amdgpu 0000:19:00.0: amdgpu: Found VCN firmware Version ENC: 1.23 DEC: 9 VEP: 0 Revision: 16
> [   16.980590] amdgpu 0000:19:00.0: amdgpu: reserve 0xa700000 from 0x83e0000000 for PSP TMR
> [   19.204585] amdgpu 0000:19:00.0: amdgpu: failed to load ucode SMC(0x32)
> [   19.227333] amdgpu 0000:19:00.0: amdgpu: psp gfx command LOAD_IP_FW(0x6) failed and response status is (0x0)
> [   19.256420] amdgpu 0000:19:00.0: amdgpu: PSP load smu failed!
> [   19.467875] [drm:psp_v13_0_ring_destroy [amdgpu]] *ERROR* Fail to stop psp ring
> [   19.491771] amdgpu 0000:19:00.0: amdgpu: PSP firmware loading failed
> [   19.513372] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of IP block <psp> failed -22
> [   19.540397] amdgpu 0000:19:00.0: amdgpu: amdgpu_device_ip_init failed
> [   19.562177] amdgpu 0000:19:00.0: amdgpu: Fatal error during GPU init
> [   19.583785] amdgpu 0000:19:00.0: amdgpu: amdgpu: finishing device.
> [   19.605474] ------------[ cut here ]------------
> [   19.615370] WARNING: CPU: 0 PID: 704 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:631 amdgpu_irq_put+0x46/0x70 [amdgpu]
> [   19.638375] Modules linked in: rndis_host hid_generic cdc_ether usbhid usbnet mii hid amdgpu(+) amdxcp gpu_sched drm_panel_backlight_quirks drm_buddy drm_ttm_helper ttm video wmi drm_exec drm_suballoc_helper drm_display_helper ast ah
> ci cec rc_core iTCO_wdt libahci drm_shmem_helper xhci_pci drm_client_lib intel_pmc_bxt libata xhci_hcd iTCO_vendor_support igb nvme watchdog drm_kms_helper idxd atlantic intel_lpss_pci usbcore scsi_mod i2c_algo_bit drm nvme_core i2c_i80
> 1 idxd_bus crc16 intel_lpss macsec dca i2c_smbus idma64 scsi_common ucsi_acpi typec_ucsi typec roles usb_common pinctrl_alderlake button efivarfs
> [   19.754852] CPU: 0 UID: 0 PID: 704 Comm: kworker/0:5 Not tainted 6.15.0-dirty #51 PREEMPT(full)
> [   19.773770] Hardware name: Supermicro SYS-531A-I/X13SRA-TF, BIOS 1.1b 08/01/2023
> [   19.789693] Workqueue: events work_for_cpu_fn
> [   19.799066] RIP: 0010:amdgpu_irq_put+0x46/0x70 [amdgpu]
> [   19.810480] Code: c0 74 33 48 8b 4e 10 48 83 39 00 74 29 89 d1 48 8d 04 88 8b 08 85 c9 74 11 f0 ff 08 74 07 31 c0 c3 cc cc cc cc e9 5a fd ff ff <0f> 0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc cc
> [   19.851066] RSP: 0018:ff55eefd81aafd48 EFLAGS: 00010246
> [   19.862314] RAX: ff466ca3653aac00 RBX: ff466ca2d7f98b40 RCX: 0000000000000000
> [   19.877675] RDX: 0000000000000000 RSI: ff466ca2d7fa5990 RDI: ff466ca2d7f80000
> [   19.893037] RBP: ff466ca2d7f90388 R08: 0000000000000000 R09: ff55eefd81aafb10
> [   19.908401] R10: ff466cc1ffcd2fa8 R11: 0000000000000003 R12: ff466ca2d7f90830
> [   19.923763] R13: ff466ca2d7f80010 R14: ff466ca2d7f80000 R15: ff466ca2d7fa5990
> [   19.939132] FS:  0000000000000000(0000) GS:ff466cc1db2ee000(0000) knlGS:0000000000000000
> [   19.956551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   19.968920] CR2: 00007f45f54e3de8 CR3: 000000207e624003 CR4: 0000000000f71ef0
> [   19.984282] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   19.999645] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   20.015010] PKRU: 55555554
> [   20.020820] Call Trace:
> [   20.026075]  <TASK>
> [   20.030581]  amdgpu_fence_driver_hw_fini+0xfc/0x130 [amdgpu]
> [   20.042894]  amdgpu_device_fini_hw+0xb7/0x2c6 [amdgpu]
> [   20.054152]  amdgpu_driver_load_kms.cold+0x18/0x2e [amdgpu]
> [   20.066323]  amdgpu_pci_probe+0x1cf/0x470 [amdgpu]
> [   20.076775]  local_pci_probe+0x42/0x90
> [   20.084839]  work_for_cpu_fn+0x17/0x30
> [   20.092899]  process_one_work+0x188/0x340
> [   20.101523]  worker_thread+0x256/0x3a0
> [   20.109584]  ? __pfx_worker_thread+0x10/0x10
> [   20.118767]  kthread+0xf9/0x240
> [   20.125519]  ? __pfx_kthread+0x10/0x10
> [   20.133578]  ret_from_fork+0x31/0x50
> [   20.141268]  ? __pfx_kthread+0x10/0x10
> [   20.149326]  ret_from_fork_asm+0x1a/0x30
> [   20.157765]  </TASK>
> [   20.162457] ---[ end trace 0000000000000000 ]---
> 
> and then continues to barf for a while longer. Full dmesg attached.
> 
> When I do a full power cycle its okay again for a few kexecs, but will
> ultimately go unhappy again.
> 
> I'm doing a 'normal' systemctl kexec, which I figure should more or less
> shut things down normally. Its not like a crash-kexec -- which is a
> whole other story and can be expected to cause trouble.

From the log -

[   16.512201] amdgpu 0000:19:00.0: amdgpu: GPU mode1 reset
[   16.531581] amdgpu 0000:19:00.0: amdgpu: SMU: valid command, bad
prerequisites: index:2 param:0x00000000 message:GetSmuVersion
[   16.564138] amdgpu 0000:19:00.0: amdgpu: GPU psp mode1 reset

It looks like PMFW responsible for reset is not in good shape and then
driver is taking an unexpected code path which breaks PSP as well.

Kenneth, any thoughts?

Thanks,
Lijo


