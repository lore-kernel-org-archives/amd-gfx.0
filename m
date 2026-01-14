Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5069D3CC82
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 22:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2734C10E69C;
	Wed, 14 Jan 2026 22:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWYRXg1l";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A35210E69C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 22:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqppEXMsfSNbFVNIxwo4+bn3EEkv5tDngaT4kKrK4a+/MvmjCc784fXhvfy+UFa0rvRKSYLDconvGgOhtomJvCrv8P7uxaad7SMw1fBZKvvy/jnyNi8du8/a9Q9fJua+u8ZpgXc5pJ2grANP1M1KKbpx0sSfx5Mdp/H6hQkTIBPf6geeJsRL3MMQNZW5O8HkGX3gYu9zgsoQxQNf31XIdM0fMKBjo/IdPy10IbigLixfX1gYyq858Rc/2rDEdB0v0EytUQBHWuKjUn5mqDVE3qqeLu1/ZUinucQjVegPRbhOcqKG43EoNW6nvntSxSsOUOh/PHD22VZwgXuzT39+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAGECNUg2ww4Onni5muSxPQjoxv1hrNnWuDV1DUdx8Y=;
 b=gn9eUWqZOFEHbqprNm2qYB+LUzgdOAvAJEpUiOVXQs0vjAHtO7xYtGiB29MYnksF1/lim986FqGnVsG2J+qb2eZJpB7vNDZmjfDjI86uIW8ePc/yPHescQDiGQR5aqiKHgN6CFhW2r5s3apYzpZqalcDUZ1xBven8MADorikNhXqzeumshoC94X0xgDKv5Xp3KkX4R9S1MwsK86VUxiVq9w+6tWpT56LOw5X9g6y8ydQViY5azVm1mxZID0D8rxaFw+MZKGzowwmXHlNMU261fXMzclLyBaxkDWhidmz6wWk8p3S5FvMH12FiV+nwSetBg2uSL4ByG4r6QiIX7zXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAGECNUg2ww4Onni5muSxPQjoxv1hrNnWuDV1DUdx8Y=;
 b=yWYRXg1lsmS2xZ174JxwTfGdCZlcqJrQSUAHk2KuXdKFkeaIYnHSqKqIh6/p5ttPpOmzMp3mc4unNeC+B/gJIvheMVSDuCYrQc8f7UXWrVbY2H0nQ4PEVTFshjvPp36ng9dLxtkFEGG04Iv4dPYKCQ/GAU0/hmz5WqM7WUwjz7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:23:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 22:23:48 +0000
Message-ID: <ae799cdb-91cd-4eee-8d0f-ad7762b1482e@amd.com>
Date: Wed, 14 Jan 2026 17:23:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix double deletion of validate_list
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com
References: <20260111225505.437415-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260111225505.437415-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0304.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 299bd64d-c11f-45d5-1edb-08de53bb969b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFB0cXhHMmM0QU0vcmRNN0tuUnBGQWRvZkRrVEh1SnJERGt2WDl2RlVNZ2VC?=
 =?utf-8?B?V2REU1g4SzQveUpTWnc4akRrOEhDeGNKZGxKNitINldZcXgvVDVzVVhqSmtj?=
 =?utf-8?B?ci9nY043cFA5NWlxeFJDT0l2NFFXVC9LUjYzLzBPc1ByNlVnemRlWmRCMGp1?=
 =?utf-8?B?eGdrbGRqdmwyeVZNVTBQa2J0NlRIUjlYKzRTd0dzRHF3R0V2RTlWUWVGS0hr?=
 =?utf-8?B?QWRUczNub1BDVm95N0hmRGpaa09HVGxiUWcrc2VjR0tyUnRxSXFvNldxdXgv?=
 =?utf-8?B?QjAxc2gxZkVTbjNXeUFIWFFEbnpacFg2ZWpEbG1QbFl0ejNxUjUzM1k0cE9k?=
 =?utf-8?B?dkpDOHRDNVBObGNWVFJubk51QXhFRmVhT24wcUZjZDZVNFBEUEVEV2I2cDB2?=
 =?utf-8?B?UGdDbmR5YzNlQnRvY0h2UDNDTzI5Y0duSWR4SGUzYnlKOS9qaTcrTng5dXRn?=
 =?utf-8?B?SDFneDVId0Ura0YzNjdMK3IweUtUbktTZUg0a2tScHNPSHZyS1cybWs4cWxG?=
 =?utf-8?B?TjBrcmVsSXhlQUhhUHVrOExCdXNCT21PcC82UVRBTjJscHk4T3dQbllyNVNC?=
 =?utf-8?B?RHZsTjFtNy83b0c3UUxXVDdRcUhNNkxHT0o1M1BNRlVXRVhNcEwxWTZlNVM5?=
 =?utf-8?B?bElWei9IWnpQcUpmVURnbm80aktyTm95NU5oQVgwb2RHRHFwQWhEajhaTDFG?=
 =?utf-8?B?a0NYT0UrRENEVXZuMUpiU3UyeGJOODl4VEE0ZllXQTF0bGJNQU12UEI2WGFI?=
 =?utf-8?B?VFNBQXhzdWlxd2g4VnA4RjZORGFVUFFoaEFPcWhacjV3ek42U1lyUFFabHN6?=
 =?utf-8?B?eEZQdkFSWVpuMDJLLzV4by9JRnRjWllNQVBpVkNweWxISkplUExCa3VGMEtm?=
 =?utf-8?B?THRqRTdhOGdkenRSNGU5ZlVLbDhnaGtuV1FjOGZ5T3NQR1hlVktBQS9GalZC?=
 =?utf-8?B?QWZsQmRteE9HODlDL0lvdUdxdUROWStwaGJPOG9pZXNHMzMxalBpYjJXR3l6?=
 =?utf-8?B?eEw3c1lURzBrb0ZnU2svZ3FJakd2Ri9pUFFicDhZL0J2cGNXYVRUREJCcHlu?=
 =?utf-8?B?LzFqUmM1TDdDVHkvMnNmSTZEVVRzdE5XbUo2NkN2cjB6elAxbm54Y3ZLaHRr?=
 =?utf-8?B?eTltTEc0RTJrbHcwVXB4cUFPTHh4VmE5NEVkWlhNcmc5YlB6bGNJS09OZmtG?=
 =?utf-8?B?QjF3K2JQZHBiNjhpbGpQODBNcEFiSnZkU240UUM0Rzl3VFdIZWhaaEpxRW5S?=
 =?utf-8?B?bVVaRmt1YXVmRnoxZCtWZzI5NlBkUlZOb2QzV1F5TzU0Qk5jMS82MkQvN2JH?=
 =?utf-8?B?cm5ua3F3MmZsUUQxNUVlRUl5U2hCR3pvbmIxN2VVakF5NEE1d0hmaTFISXgz?=
 =?utf-8?B?TmFZMVpLZEU5T0F4ejNNcjZ6L1J2Uzk1bW1OWVZHMFY5RzVGbXdVQ0VobTly?=
 =?utf-8?B?T09mT1BNQytMRURncUtOakYyK2Z4WThHRm5vVDRPT25JOU5pc08zczNocmxC?=
 =?utf-8?B?Q2loT3dsRk93cENrVWdPNDh4ZmtZN1EzZTJBeGl3YXJEVjRlb1NUN2hRUGti?=
 =?utf-8?B?Z2tiQW1yS0RhVHhJUFBydm45K1VqOXZOR0o3eEw0RU9vOVVHMWtENUlFTWZu?=
 =?utf-8?B?VUFHZktOZTYrQ1hhN2RjOGtqVmJMR2J0clBwVjBSd3cvcitNU3pDQkg0VGRB?=
 =?utf-8?B?cU84cXpIK0U2a011QlRVN2xFTHVETXJqV2xmZFl4ZkI2K1lDL1RkVTlJTkVJ?=
 =?utf-8?B?Umt3RE5UQ0FQSmdIOE8rcmlmcG5KWHRHZE5GV0NrNnpFcFVvWHFBK0Q5ZnRn?=
 =?utf-8?B?bVcySW1nL0Eyb3ZWWlBmM2VwZVROdGxiUlNxVm01WTRWQUJCRE1CcExtb3Fa?=
 =?utf-8?B?MTdVNWRRRHRRZmZYRmNMMDdRODNzUGxvQTBxdWYzTjZvdnlxRWhmYlJmc2xZ?=
 =?utf-8?B?dEJ0SDJZRHMvcVJyeVFybDBia1NCeENKbXo0Tjh4RFRiTWlQOTVicm1UdUJl?=
 =?utf-8?B?b3lSMFQyQlBXVWMzd0RYeHh1UXBoZ0hmZGs4Snl3UmUvOWM2Z1RIM1E4cEVS?=
 =?utf-8?B?RXM3VFNid3lLR1Q0Sjhib3RyOVNraWk5R3hHaFhPRTNHcWlya3RuZ1oyd05Z?=
 =?utf-8?Q?ROcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2daQmcrWWRKOXc2bDh3d1F4dVhhRGFDSS9RMUJhMnpyUUxITWJBMFYzeXNp?=
 =?utf-8?B?M3c4djZjc3k3Vmx2TTR2TDlTdysvN1VsdDAxQ1RNQzBFZkF2NGp3SitrTlln?=
 =?utf-8?B?Wmp1VXNITEtWZE1nUlRCTEptT0t0b2REdzgwNnVLS3BZbzJ6a3AwK1NnekVQ?=
 =?utf-8?B?S2lmV1FlNG5DWTh6MVJsYUt4OFdJaVZydkxyQ3lROTBNTjNXUkRzYUc5L3dD?=
 =?utf-8?B?N05pOU8vODJiYzRMRjVURTRxT2hyRzdRSDU0YXhmeVkvb1hOVVc3cGVTd1Ux?=
 =?utf-8?B?TXJtUm8vSTlOKytnWHZEMWVRLzhITm1aMFJSQTBvc1g5dDNBbVpDYitkaEpm?=
 =?utf-8?B?Q1A3dm9TazJkd3IyYVA2cWljbzVMYWluMVh3bWxubXVwVDIwZHljcWRFYUh6?=
 =?utf-8?B?Q2J4YXVEYXd2dHJ6RERpVDl0TGJJeGJVUWJ0YkNYdW9MZjBqa0Y2MURLcW5i?=
 =?utf-8?B?enkxb3BwWk9oWHJ1VlN4VTRXeEFLeGkrQ2wrKytML2k1bmtIOFlxVkdjK1pI?=
 =?utf-8?B?ZDRtTThtY2hCVWJJakhuUS85U3F6ZEZ0QWxlR0N1eFZQaDNPN1R4VHFsU3Fq?=
 =?utf-8?B?bDlETXlHTFVEcHpUQnNuanR0TTNmRDRYenFtTlpRQ0ErR1p1b2dKQVVycnVV?=
 =?utf-8?B?aGJkNnhiVHhYc0taVVA5MVVic0xxK0lZTFRlaWdtQkE4YWRHVW1aTEhTOXVq?=
 =?utf-8?B?aUwweFp2aDBkcU9ETEpSODVaVHdQLzdqZElzR1owTGhSdGkwMmhKd3BaS3ov?=
 =?utf-8?B?dzZuYnRQU0JVQjVCQ1hjWlQzT0IzK25EaGUwV0NkU0Qvd01BRUdEQ1NsQjBZ?=
 =?utf-8?B?TjNFdzdPUlI0WDM2L0lDNXNEQmhuYlNmd3dTRHFkbkhidWZFUWhNbTlzYmpC?=
 =?utf-8?B?QWF2NHYrSXZBKy9oOG0vTVF0anJWcXpZTDFYVmJRcnJoVjhnYVcxZEh2Q3ln?=
 =?utf-8?B?U2E2NjE3M3NQK3lkZlgyczdoVmRBbWtsOHcvQndQUXdUUDNKdFVwNCtoVk9N?=
 =?utf-8?B?RVVwcmF4MWFIVFBNdXM5RHB5SkxOaU91ZEl2QWNCb2hTZUlLZ1FISGFISUth?=
 =?utf-8?B?Nitncm4yZU5OeUh4VnFabm5HS05sNXNhQTVQNUZsRnBMdDZyODJLWnRZaURH?=
 =?utf-8?B?NmVzVnd1YmZSRDE3ZGdGTkFOTjNFVmxVTEdyeldQOG84SEZqT1RaSWE5Uktm?=
 =?utf-8?B?KzcyOENkQXFnTVVjQ2VOeHpUbzNwV2t3NWhya1NpeTdHUFZtWEJXbjJVckMz?=
 =?utf-8?B?bVFnbmhJRXZ2bVJNVnFUbjczaE5zRjV2R09LaEhCNExhQ0lMK2d4SE9DOGZs?=
 =?utf-8?B?T3B2Uks3djJzcGkzL1p5eFdML2UzRk5vS09qMTN6OHliaC9wMzRKNkNWaXBw?=
 =?utf-8?B?OEdia1djZWpLMVZPMlBpSHlMMHRtQkRxK0lzNWNmU1JmMlBhR3A0N0FhZUxT?=
 =?utf-8?B?a083OVl5OTB0LzZiK3BJaFZFSEF5ejYxRlVVdkxsTWhWcUY4c096ZmhWbGY5?=
 =?utf-8?B?Zi9JR1o4NVdOOVNBa0pYLytqSW9Qb2ZpcUoxWHpCakpJQzhrc0M5ME1zZlYx?=
 =?utf-8?B?UStxUm5RREpudWVZUWE4TEF2ZHFOdjVrS1ZPdkt4MGZzaElic2dCNDRvYkFG?=
 =?utf-8?B?b3M1d1NlYUJqQktYUHJQWHhlS3BNaWF1M3F6dTYwaGZaaEM2b1FyR256djg0?=
 =?utf-8?B?YkRsY3BlSFA3ZW85TjU1VGlzR2liTUV4SDVPMXBIWkp1T1lKTEJ3ZFhaY3dr?=
 =?utf-8?B?a1M5MXlWUnR3TlZIY3ZxbGtKOHlBelJlQzhKdHpheDRTVzB4ZVR3YmtRZ0Nq?=
 =?utf-8?B?Uy9JZEx6dldQdWtOdHNzM3NRWFBCM29WNlNPdVBBSms1Y1dzYVNXdnFFZDg3?=
 =?utf-8?B?SEFPcmtBVW00TTdvZFozZWRPRitmK01ibzFmbmQwcWdCaTNISHZFc0VFU3JV?=
 =?utf-8?B?YTZObWVtem5XSmpreGlEY1d1Z0xNb0ZmYkFVaVFQU1dkaW1pb0hwTE1Hd0px?=
 =?utf-8?B?QkxPdjI0QUxQaHZGUDgxYlhaZFJBR2hsOTlEVFZMbHV0bTNOSE85ajMvS1Jh?=
 =?utf-8?B?TS9iOE8vcjE5TUxOMlhrNGJTUjlUUVJjbm9FOS8ySGdTb3hkWXgvd2x4ay9t?=
 =?utf-8?B?RHlMalpud1JSQ1dPMStyaDdSaVkvRDBIbnJnQUFTSnRZcjRrWmRsbjVPY0Fo?=
 =?utf-8?B?dysrQ1RYVmQzVDRlWldBck9sNXo0dnhWVnVRWGVQL1k1MTVnR2tUQ3J1OElL?=
 =?utf-8?B?bHBmdHlJQ0ZMaWxhZkpHSHNFdVlQNUt0SU0zWHBVa2tkMm1QTk5PMTE3MGJj?=
 =?utf-8?Q?jWnK+XkqkjuEhrcYfu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299bd64d-c11f-45d5-1edb-08de53bb969b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:23:48.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hcXwjspUQFJiRE+tgS63J4/B91fneOFzXi5FjinH5DEzHDoRTIOVCcdfPViAb7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
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



On 2026-01-11 17:55, Harish Kasiviswanathan wrote:
> If amdgpu_amdkfd_gpuvm_free_memory_of_gpu() fails after kgd_mem is
> removed from validate_list, the mem handle still lingers in the KFD idr.
> This means when process is terminated,
> kfd_process_free_outstanding_kfd_bos() will call
> amdgpu_amdkfd_gpuvm_free_memory_of_gpu() again resulting in double
> deletion.
>
> To avoid this -
>   (a) Check if list is empty before deleting it
>   (b) Rearragne amdgpu_amdkfd_gpuvm_free_memory_of_gpu() such that it can
>       be safely called again if it returns failure the first time.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Looks good to me.
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 88fc430b9425..ff0f80483b1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1924,21 +1924,21 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   
>   	/* Make sure restore workers don't access the BO any more */
>   	mutex_lock(&process_info->lock);
> -	list_del(&mem->validate_list);
> +	if (!list_empty(&mem->validate_list))
> +		list_del_init(&mem->validate_list);
>   	mutex_unlock(&process_info->lock);
>   
> +	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
> +	if (unlikely(ret))
> +		return ret;
> +
>   	/* Cleanup user pages and MMU notifiers */
>   	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>   		amdgpu_hmm_unregister(mem->bo);
> -		mutex_lock(&process_info->notifier_lock);
>   		amdgpu_hmm_range_free(mem->range);
> -		mutex_unlock(&process_info->notifier_lock);
> +		mem->range = NULL;
>   	}
>   
> -	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
> -	if (unlikely(ret))
> -		return ret;
> -
>   	amdgpu_amdkfd_remove_eviction_fence(mem->bo,
>   					process_info->eviction_fence);
>   	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,

