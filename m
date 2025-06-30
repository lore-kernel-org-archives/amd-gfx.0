Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC1C83000
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 03:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0ADD10E17E;
	Mon, 30 Jun 2025 03:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C7PD2F+/";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E0B10E17E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 03:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clerFj/ocA463Jf2JC97Nf1QkJCpvQZ8ZY8gMVlTsWCK5zqXCAbMa0YRq2lZLtQ1ErY/+zaa3PgCKeRXfysuBnjxloraCzBmiTl5vJP3uZFGcRegaE6lpyRDTd6zROM+roSkH2+ig94TWXpeusQ1YyBehBWBgVLpQtG0qu1ajE3PcpNNwBbHVjCcRz4ttwMKGDumeCbl0wph0y6hTQOFWZNZg24TorkZ6ecuHnbdOVUDG8zF8bE19D+btKpt6aBidJpjFogyPsxGSLXv66xw452+KMK+FEj32C8I/qFEu91j1oCvO0N39/0ahp3YvQodbov0CrXa4QKu9sYsmFAh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY/w0iAoeMwM5wOOrmQ2TTyq0/GqQiXg5B4iystlQrA=;
 b=CKyUeoAtKNHGzh4/1uRqfGJUdwph6ggGr9SMl8GzoOShn7cA+UjZeONXVjyJhQaVbknhnRVBbsCrh1xCsdOsfXkkPcuuRJtNmz4Itibt4DCzWjN4flOqU8lAfiX8GXYwN9jOIV93wuC7YCJ9tVI1z36y6+iND6ION/0ReiN4XmMS4nyV2KEYnIwq5TYZUzeXvgS9rRenfPGZJOqwGPeZguLXzdca68Ob+nwEBAyhK/ZRM/raRXa4Y+Eh4bFHVjThiAcf+3xsN6BrVGgxbCzrW7u2W8KwCKfcJd6MoY0gIQuKqYQZ6rcvixLv6BCsgRqImW8fc9bRZE8pIudd/6lVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY/w0iAoeMwM5wOOrmQ2TTyq0/GqQiXg5B4iystlQrA=;
 b=C7PD2F+/ySLK6PKq11EsoCFVgyhBtBxz54jsvhwwyPVKcr4iIjGBamIi5na09DLLdLKjmXdxAJMlM2wSb7DuY6gR3CTe6FvfLEmgOc7cnFq0d6G9M4ouylQi2SOOpanQAQqAmxdGhHuBnKlh8aOdZ2IpYi67eYWWyZ2xaEyAUIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.18; Mon, 30 Jun 2025 03:23:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 03:23:48 +0000
Message-ID: <a9e4963e-22d6-46d8-8adc-1eaf6d9a2731@amd.com>
Date: Mon, 30 Jun 2025 08:53:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix error with dev_info_once usage
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
References: <20250628073143.1249393-1-lijo.lazar@amd.com>
 <BN9PR12MB52572F2ED6EDD778FC4ADA88FC47A@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB52572F2ED6EDD778FC4ADA88FC47A@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: dee099a1-2489-4548-8b90-08ddb78586a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y282TWZLL1F4Wkx1dWtyMXc1V0EzUmJuWHFub1RhNk1wMkZjc0g2RGE1ZmJL?=
 =?utf-8?B?Sm1ycG1IdUZvMUJqK2d6SUR2THdHQmlUTkRkYThqM2VCNVdrNUJRTWRNeTdl?=
 =?utf-8?B?Vk5uZ1JnSVkrSWVTMnp6VVFRTFdvcEZoMDAvMjdVTXllSzVzVHlFMHlaSFVx?=
 =?utf-8?B?WkNSNmFvc0FnckE2T1JZZ01keS9OVlRoaU1KM1BkVERjUjVveUlacU0zS1pZ?=
 =?utf-8?B?cnY2eW1laDlWL3hISW9SSForRzB0Y2pRRHU1ZUdCemNoOXhMM21SMnVURnRU?=
 =?utf-8?B?OTA3OFVpRG9maVNMMlNtTzFxK3ZIUTUrbHVvSUlLbG5jMEFFL3B0KzJBK2F5?=
 =?utf-8?B?YlhDd0Y2cy9MNXhuRzlVcVUyUVQ5SG9lNFZKQ2J2Y1dVMDhubnhoMTJ3NVll?=
 =?utf-8?B?aVJVMGFwSlIycFBKNFFVdm1RQXBaeGloZWovN1lSM1RMVmRZVVNYMWhLM1NO?=
 =?utf-8?B?UTV0aDFZMU1zYkwyWFdGOXJrZ0ZXa09uNDBHbU1ldnVVQ1o5RGpvaittVTZr?=
 =?utf-8?B?eGRjS1V0NmtHVGZBQ3hSeHRudVB1WUtrWlIzNHZOOCtJTk8wYTNBblVkdDFP?=
 =?utf-8?B?aWNkdE9nWERqSmNBMmpOU0FNSFNockhPeVUvMzBxUjc5WlJBU0hKRXUwWUZs?=
 =?utf-8?B?akExZStUSUROeVFVcFp0MGhXODlNOGg0MTA4TVc4KzlNQWVTVnNFbnEzaTR3?=
 =?utf-8?B?b0VFOTV4ZElQOWpKOC9IR0RSSDdHazV5OVVtRnJBaTRiWXZOU1p5eUl6K3lJ?=
 =?utf-8?B?a1RoM3diK2Y2eldITHFjU0tzeXJacy9rdTFvS2RDZ0dtdk1wSVM1Y3BBbStY?=
 =?utf-8?B?azdQWnVFc09mNUpZa2NGVzdmSDBBbWY1Q2M2MCtRSkp2N0hESG5Ib2ZJR2Zi?=
 =?utf-8?B?OFdNY2FmclJicE55WVl2OWJoRXk4UDJ3ZiswU2kza2FiQVorU2N2b2hqNkdR?=
 =?utf-8?B?WGVacHlkdXUxTEp2dmxaUWk0dnBuV25SRzlBREc4YnpzNkFRNzd2RTFkZW1s?=
 =?utf-8?B?aE5iZGdvR0JoSDl6TUkxWUE0ZHhpOGk0eFpCaVgySnBkYTlhUUdtMUVHdng4?=
 =?utf-8?B?TGdrMXhyREtPZTh1UVJuTjdDWUdBUlJwUk43VmJIdWh3WGRMK3RjTEU3dmRm?=
 =?utf-8?B?L3lqOWl6YkVUc0d6ME9yZ2FOWFpzaGVqdTU1M1VaakJSNTNFckxrdHlvSDJt?=
 =?utf-8?B?bExKcjFVVGtveXczNHNCMU5TTXFwclRtc1MwaTI5QW0va1lycDJGbnMxd0RS?=
 =?utf-8?B?ZEFHc0RGL28zQUJsWXNvZFNTaFJUcDl1ZWd4STZXZmVrczhpZ3pLL2lVWmp1?=
 =?utf-8?B?ZE5ULzI0a1ZkdjY3RHc1ZjFmbkw4Tm5FY3Q0RkdKcHRFT2hZeHV5VTFTVEhl?=
 =?utf-8?B?UlNKYTUrdzc1UDVsd3FyMFBLcVY2dmdEZW5PYThXT0FIM0NjMzl2K0J0UlhE?=
 =?utf-8?B?OFBMblFCdmhaSnNEMTM5aGpuUERKRVlsSHZ3bGhaam56OHpJTWV6VU5Ia3BU?=
 =?utf-8?B?WnhKOWFzY3NWck1ha3kzbU1IdWtENy9yM3lSK3VuaE8ycnFNdFREbzh1Vm1F?=
 =?utf-8?B?dXFNNUVZYkVZL0J5VGlnQTlldTZLYUhiNW5uM1h2TDNLSXpoTDJoK1YzaFMr?=
 =?utf-8?B?UlZJWVZlYXZDeFE1ZVBIM2htWnYranJZUFFWK3FEaEcrR050ZTVoT2I4bzl3?=
 =?utf-8?B?ZytlN1dRZTFYUmUyUFJFcFd4NmdmUGdHbVUzdXcycHJHU0NnRU1PUTFVWEFs?=
 =?utf-8?B?K1hYaGNlMGVPWTQvb0dkSVBBR21kTDhqenRxdTIzQTRHNnFCMytJWDBuNXUv?=
 =?utf-8?B?NEVZakpBNk9hS3BiOUt3Z3hjTDY3TkhySVowa0VCRUZNZ1AyekJubE1KRE4r?=
 =?utf-8?B?WmU0QmUwRVZHZytjM3Rjb1NWa0ZBcHA4RkRrYmR6cU80SUxzMzVRK1E1VGNR?=
 =?utf-8?Q?TKzbrQDIJLw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0l4M3JJc2hjUnVxa0RzZTBiOFZIeXVLNzV5L0JQQm1LMG1JUUdHSll4OUVv?=
 =?utf-8?B?RjFqYXdyNnNobXQveFlHUTE2YW1TSjEyUXdmN2dOemhLZWZZbHNjSG5QY05U?=
 =?utf-8?B?TmVOSS9zOGhLaW1WRDlYajlSMS9rQWVob1NRQ3J6V3lqanFqdks5ckpmOW04?=
 =?utf-8?B?a0R2OWdBNWN6dmUzaXdSaEVoZ1JhYjNpOE1KeTRvWHVFekk1dzRyVTI5QUw4?=
 =?utf-8?B?U1J3dGNDZ2IwbG9ZWlpCMG1DdlZiNU9ZMFNCT21EdklFdnlpVUZwdiszaHRi?=
 =?utf-8?B?K2RGQ3pab3g1clB6Z2JPYk03LytiTHpYMCtKSXk2VUFybDIwYk5QcUZvNk9j?=
 =?utf-8?B?blZNaHF1T0VXdk5Bc3ZsYU5YSzJQSGFneU8ySm1vNHQwS2xKVFhxNTE1czN4?=
 =?utf-8?B?RExYTFpIcWxVZDlxUHEvYUpUTi9lUHhndTE0ZFUvaDdNNkw0MHEwWE5wOUw4?=
 =?utf-8?B?Nkg5SnhROEJ1RHloM1duTVBlZWEvTTBtTnFTM2U0bEZGOUt3MkRBWm9XT3Rh?=
 =?utf-8?B?M3RMdkNxSXhFcVp2WEhDcGZ2ZnNBYUtka0YwQjhIdDlFOWpqU1ZweG9KY2dH?=
 =?utf-8?B?a0FNdEt6TjZIMG5nNjAwVnR1SSs3cUVEeW1XZml5ZEZMOVp2dFAzdmY2U0VJ?=
 =?utf-8?B?V3VMcXRQeGh5dkhnMkZuZkR6YngxUTFzTm1qbk1zUlJGR3ZMeGJBRVBwQ2E3?=
 =?utf-8?B?RjFuQUV6bkQ1N1d6aG5uOWxGNC9WUEg3K0xpcFFXNzNmd1FUTFJHWDFXNDMy?=
 =?utf-8?B?blhKTm8xT08zbmhJOUpjR0dKdnUxTmh6R09DbUVYNzZqR01ETTdDUlVoZkNB?=
 =?utf-8?B?TDJnaFc2VlIwVzRMdkhlUEllUVIrUC95Z3Job2lPZCszaTVhTVN0V2ZUZHdJ?=
 =?utf-8?B?RmNmMmVHbnNTeE12QU5SZjJsRlVjR05IZC8zejBVRENoQk5mOURlb0R1eFIw?=
 =?utf-8?B?SDZXT2orKy9QTlF5WVAvMmJhaWdoSG4vQXJxMjVzdmZjVWcrTzFRRENZWnVo?=
 =?utf-8?B?eldIYU5ZN2pBNndqVzZkdEk5SFZmY0NmM2V2Qm9LN0d5SDJiS2VkVmorZS9q?=
 =?utf-8?B?OE5ZMWlEbFAvTC9pUkZqeGlNb0ZyVGlYaGNzblYrQUNXSjRjak1JUnZoTmhN?=
 =?utf-8?B?bmU1NnYvaU5tL3dhSlZqblhNaDhBU3JDcVdiMzZrVnFuQnFzbWJXcTlaSmlR?=
 =?utf-8?B?ZnBad2FRRlBocFh1WWplTVFKK0lDNHUrZDQ3TEdFaDhrcnBTRW1lSmhUYWNB?=
 =?utf-8?B?c21JVnZlZFJReW1sNzFBMGlGOERLZU1JL0cyZDR2TEZjWmVsRmtKWFJoSU83?=
 =?utf-8?B?aHFlaUQyb0JUQXlNN3ExbHlOM3Y0UDZCbnpUR2JSUzkwWDdCU0JWQWZ5b2VS?=
 =?utf-8?B?ZHpZVG9xLytVRDVmNXFVTkZlekczSnphVjhaYmpDcCtRY29obWprZHY4UFk5?=
 =?utf-8?B?WTBmK3ZHZnk1bFpZNXVGWVpIL2FoRDdyZ0xQeEllc1A1SVdlVStsVGZkOVgv?=
 =?utf-8?B?UjhpWnJGVkdVcUMzUVFZQjVtdzZzYjg5bU13SUJGTjhGYU1RTzgxN0tuOVpL?=
 =?utf-8?B?MFRnRTg0WWpNc2NaT0RmdDUvaWxmNzhvWFlabjBieHpReUlIQUhPSGRETm53?=
 =?utf-8?B?eFJiMm5TRmJuekR3Z2s0MHpQYVpRaHYyOFNmbGQxbXZtWTdibzBtR1JIUDBm?=
 =?utf-8?B?RnEvTEdSTmdzNnlPeTZ2R2dWNTRPTmd1cDhlN2hFdWVhUmJ3ZkdSb0JidjNT?=
 =?utf-8?B?eTcrZWJnYzBpWmo0YU93ZXQrdGJkcU15YkdYekNKcUtmK3lWekwwY05UMytU?=
 =?utf-8?B?b09FMmFla21zTDhNVUJ3SDZFVHlVT3ByNTNvNnpOb2FPR1dVZ09GY1kvVE81?=
 =?utf-8?B?QjIzMmNjS09KR1ZaQ3ZCUmQ5YVcyWGtqMERZRHdkK1E0c0lqeTlHN1JpaEdk?=
 =?utf-8?B?cmJOSXBXdHVtSGN3TXQ2RTJEUEJOenhTSVliS2VEZjB2WDhQQUJXSU9nbmpU?=
 =?utf-8?B?S09ORDBxa1V0M0p6V3RLcGlnVEZKMFV5ZGxvV1VxWk5EcFlMWFRwQk1nRldy?=
 =?utf-8?B?bkQxd09saDFKNnFMenpPU0ZBaitQbk1BZ2NVbjFDRDBZUmoyVWk3aFdoSXlt?=
 =?utf-8?Q?6fvgMvJCqTOX3m+hOPCo/qZg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee099a1-2489-4548-8b90-08ddb78586a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 03:23:47.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOmR6QTsPvy+7cT9zbrHOMKKxR7hIQQm0rp2Hs8buztYpYqpLd1XDkU+BHmM5B/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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



On 6/29/2025 1:16 PM, Zhang, Hawking wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
> +                                      enum amd_asic_type asic_type)
> 
> You may also consider using amdgpu_device * as input parameter. either way works for me. The patch is
> 

This function gets called once in probe as well before adev is created,
hence used pci_dev.

Thanks,
Lijo

> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> 
> Regards,
> Hawking
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Saturday, June 28, 2025 15:32
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; kernel test robot <lkp@intel.com>
> Subject: [PATCH] drm/amdgpu: Fix error with dev_info_once usage
> 
> Fixes error with dev_info_once usage in amdgpu_device_asic_has_dc_support.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506281140.mXfWT3EN-lkp@intel.com/
> Fixes: f408cc771c33 ("drm/amdgpu: Convert from DRM_* to dev_*")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7427986992d6..1b61e0d27ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1390,7 +1390,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,  void amdgpu_device_indirect_wreg64_ext(struct amdgpu_device *adev,
>                                    u64 reg_addr, u64 reg_data);
>  u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev); -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
> +                                      enum amd_asic_type asic_type);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
> 
>  void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 334e442c95ef..95e9f7285351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4099,12 +4099,14 @@ static void amdgpu_device_detect_sriov_bios(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
> + * @pdev : pci device context
>   * @asic_type: AMD asic type
>   *
>   * Check if there is DC (new modesetting infrastructre) support for an asic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
> +                                      enum amd_asic_type asic_type)
>  {
>         switch (asic_type) {
>  #ifdef CONFIG_DRM_AMDGPU_SI
> @@ -4148,7 +4150,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>         default:
>                 if (amdgpu_dc > 0)
>                         dev_info_once(
> -                               adev->dev,
> +                               &pdev->dev,
>                                 "Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
>                 return false;
>  #endif
> @@ -4168,7 +4170,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>             (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
>                 return false;
> 
> -       return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +       return amdgpu_device_asic_has_dc_support(adev->pdev, adev->asic_type);
>  }
> 
>  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2bb02fe9c880..b299e15bb5e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2327,7 +2327,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>                 amdgpu_aspm = 0;
> 
>         if (amdgpu_virtual_display ||
> -           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +           amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
>                 supports_atomic = true;
> 
>         if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
> --
> 2.49.0
> 

