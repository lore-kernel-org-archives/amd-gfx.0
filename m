Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ED1EED60A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 14:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883C310E1D4;
	Thu, 12 Sep 2024 14:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jZbZr6nH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A90710E1D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 14:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mScIUNhJRNMc8EaBk2fHPkh1oS518EjRO83gQkZoqVrGQr5HqwbcW9rGIptzP7uf5JqPkQoe/a8GCj7hdy2xY50KJePfUZR1W4Ttoi/crZVSDFsUIIWLY51pacaVZCquF4OclS115uAHR655r27xeyGxl3dPW4S4yYwmkdW7hWxrPB0NwK6umzc4bKZb+utOrUKEu06CAJ1N/qtSKoWZJluzv0MxdgJmcm8djBRuCxJTtjUgeA2iyOJz8lf6cCU/QscDKmnpx7d0xrhQRB+oiFH7UOT3caHv1tkGNLbUR2ZHU46gKNZheTDGz7hZv5QFjQU13DxIhvA+jfIwD2Z2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWjODZoixbO/FCcm5zEfnUEWsCYhjlK+3I48UOH/GCU=;
 b=HmrAbHFn92otlx0HQZJKbxEf5/HfL7uvcotFoxdSvzOAJ0li37dTXody5SVJ35axpcENGOZkZ8/S+JPhdsfJ9mdFiCGVEdt2DCmatqt6QYlY/vnLPyJM9fFpFSbsA6UDlRIHR2MpkIbo6CPUpaEvB9XekBMX30CR5dbaW5Z9t4PAr26ad07mHwlUuzj802aq8dk3BrF0deX7Mn/QHO9FPLC8Balm25GMhHdLtqP/H2e6C2ut+du/u37/ZHA1J8k21AIbHh7tPmSkyiF74kz3TcqjrBrCQMVqwGyaTyPAOFvQZxDtvir+GaJpjEA1ePX5b1m96hlD23g14t5mw7JRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWjODZoixbO/FCcm5zEfnUEWsCYhjlK+3I48UOH/GCU=;
 b=jZbZr6nHu46f27IJUJw33IDQaCPSjytGYiJkB+x4dVajogAS6fe6HyArPFvC/x9XYOsFGGnsGLGj6rX7BsaPMG1fevf58Cv6Vxgf1Z+tlGXil4HdCAdVtN9lb9ja3IY77FXCToEtENtgUIGkHUYHCfnyM+/m8EYehVhC81AaYig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 14:26:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.025; Thu, 12 Sep 2024
 14:26:08 +0000
Message-ID: <c2a1df28-4759-45a2-bd06-8b3fe32c2709@amd.com>
Date: Thu, 12 Sep 2024 19:56:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on
 SMU13.0.6
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240911180545.519385-1-kent.russell@amd.com>
 <BL1PR12MB5898A1F8EC72E916C63958B2859B2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5898A1F8EC72E916C63958B2859B2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0163.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: be5ba9ec-f0cd-4bde-9fb0-08dcd336d7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFJXSzJCTDdMeXBoVk45SERLY0wvM2J0WE1UK0JBekszU1U2cU9sMGJzZ1ZO?=
 =?utf-8?B?RUhLamEvb0kybXV4dnVKaC82Ym1DQ0tWQ211c2p3dlY5Z1JTRUJ2TkFIclp6?=
 =?utf-8?B?cGtSaGlxQlNic2lzRnUvK1RXcmtsalZVVlBHcWZoSitSQjU4eS9TdllJM3Va?=
 =?utf-8?B?WklCVXE2elhQdHdCUDdYS2NTUkJkSHVoVjNPZFQrcWhtY0l6Mk9aUkVwdG8z?=
 =?utf-8?B?UTA0WUhFa0pxdDBNWDFud2U5cThHNWJYU0FBdEpVQ3A5b29mUU9GZmpuQVVJ?=
 =?utf-8?B?ZlV1OGIzQmVmMlFxQ3l5NERtQWpIOVh5QVQveUNmdi94R0JEdGtDZzZFQXdO?=
 =?utf-8?B?bTRzdVE5bWVuMWpKazN2elMxb25TUWMraGNxVmZPMzdQcVFYdzdvRXNKekZQ?=
 =?utf-8?B?L0NvNFYwSlY2clVrdFk3S3FMNEw4cHpRZDIwRGJhS28xWXRlQ1FiWVd4cHNH?=
 =?utf-8?B?M2l3aGp1S2xSaUxvSmgvbkU1OVM0WWdUWnRHS1RtV3VVTnYzLzJSaHh0TjAx?=
 =?utf-8?B?UklTTStZYWZRYjZVTFZueVN1ektrU0htNW02cW1uaStkYWhzdStkM28vWHR1?=
 =?utf-8?B?aUk1WkErb3hGa1A2SFJpN25Va0JOd0tLRnNXTi9DUWFiUGxQakdRUCtRazJV?=
 =?utf-8?B?ajNLZzNmYkpWMEE5VG1mZy9lUWxmYWx5N2JZa25CZldINzhlN2haKzh1dUZo?=
 =?utf-8?B?azYzNk5JUCtIbDR0bDVlenl5V3YvcStudDd0Zmt5UkJLWDZIenQ3NStCZVJn?=
 =?utf-8?B?NzU5bldyYk5Tc3BNc3crWjJGdE51UVRKQjh0TEN1YklORFJ3bUd2bUtmR3lV?=
 =?utf-8?B?RFJoYWVNTTZtN3BwaHM3MmZrMkNSWTB1UUJLTjlNWXUvZE9jVE01WW5ZU0Fm?=
 =?utf-8?B?VzllYVVURGRjeFcvNkdKbUJoUjVHUlB4NVJsRnJXT1NUbU5hdDZ5c1ZQcmNw?=
 =?utf-8?B?SDNaWnE5NFdtM0lBUzA5SjdnUm9CeGNTenU5WTBMcXA0OXZBQVF4NlVIK3ZU?=
 =?utf-8?B?cDdCeTBmSGo0QXVHT0tWVWlHNW1kcyt5TG9MZVFWV2RxRnlta21oeFVtRUNS?=
 =?utf-8?B?YTNpQWFYREk1UWdzcE9aYzlJcjJNSUI4OWduaFBNV0Y3QkVoWm1pWklpTndx?=
 =?utf-8?B?ZlZBV1dqUi8yQTJoeldGZ3BFR2VSWHhLWks3ZVNXdHo4azA0N2lYSytIalZm?=
 =?utf-8?B?cUpHa21pZ0Q2UDNiaFQ0RWcwK2hBT0h0OEJOaWZDblA4WTF6K2Q5ZllwdmZr?=
 =?utf-8?B?YWVmLzd2dFk4cjczZE10NEppakczZmtGYm1FTmxVMFZzcktRMHpxeEQ4MnZ1?=
 =?utf-8?B?VHpKTFpSdklIeTJuNnpVeTRBWFhhRzdHaGw5QVJWZGo3MnN4Nm5sb2ZqYXJm?=
 =?utf-8?B?YzIrUGc5T2ovZWYramNQZUkrd0dsYk03cWwyeCthbkRtcjhFNGZYVU9IcDZm?=
 =?utf-8?B?Q2pDSlBJZlJ2aFFqUVhnZTBPV0dBdDQweVFueWdYcitNN0s2Z2w0WkZSYWVm?=
 =?utf-8?B?ZVJXSDlZbVhhQzhNR0F4QTlDRWp2aGc3bTlwemxRQ2pNOXRUanFxZTU5d3Fo?=
 =?utf-8?B?NXlsZ2dzemFUWnhQSDBISVNRVlpHNURxRG9mSXpOQ3VMK1JCNGpQcDB2VXRT?=
 =?utf-8?B?YkwyWWE4d0hIREptVFVibExnbHYyTnk4VmpyVGNRR3pNY3B0OHEzS05xZDNW?=
 =?utf-8?B?ZUdqTVY0SlVEb2FrN2NWOEhJVHB5UEdLVzdneWJ1OWlZTGxPdUVTOURXMjc5?=
 =?utf-8?B?eWNXYzJWY2ttbXlSMEwvSFdGTzl6VkRCVFdDbHBtZ0tHeGR4eEMvWVpXUUdN?=
 =?utf-8?B?NHBuTVhHQk5pbXNIWWZ3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlUNW1CRi9PZGt0MzFXOEdVR1duc2dKUk11emVnNGhYSzgzSWRpMVpvSDhj?=
 =?utf-8?B?NE94R09VQ3BRYlFZbkNjeFU3YVJlaWhhVDJ0YVFKenlMVE5LK2sycWlkOVY4?=
 =?utf-8?B?dFhBcTR6bkgrcFp1dnhXWDZ4QXpXSkNHRUt3R3NRQkE0dDhoL29jdTBka1Nm?=
 =?utf-8?B?WCt3a1gxdWxnQjNrZjV4Y1VYNjA2OUFVeVEwSDQza1FmY0RVQXhlVFpNUDg4?=
 =?utf-8?B?VmQxYjZzRVZSY2xXT1NrUXQ3MlB6K1JKb1hLVnQxRGg3VytFcU1MSGMwSTJ4?=
 =?utf-8?B?ZTFSYldJaVR3c3p0cmhSc2ZVd0hTK2FDVXoxTmZJVC9Jc3QyWmRHUDlYdnly?=
 =?utf-8?B?a0sxMzNLZXp6ZGFrUmhPR2xsWWZGTDBLMCtpQ2dEYXlZZXZvdWQrU2l3TFRx?=
 =?utf-8?B?VnRqeEhPeGcvZFNzQ0dKRkNIdEh0Um1DdjQvWjk2VTR5Qm40cVJrMFcrSFhv?=
 =?utf-8?B?dU0vUSsvWFBWNVVMR291aE1vNlh1NEVtQXBtVkRtN0pYVnJRUWJKNmNLeXh4?=
 =?utf-8?B?QkorTCswbTM3NEh2QVNHV3JPTXdBT1NheG16b2Q2U252ZWxzQUtWM2JBMkhE?=
 =?utf-8?B?QWpjTW1FWFl2ZzYvVUFxNVB6WFg1MVJqb2NCOVBXZm40T3RjM0pOME83TUpJ?=
 =?utf-8?B?bUhBUVZMOElIQk4zU0VLL1pFYW9ZOGp5NC9EY1RLbk1ta1dKMjNUZG91Tkhr?=
 =?utf-8?B?czNkTTI3ZDl0QzBRUzkxSURyZW9CR2l4L09DWjRBbHAvTDJXOWdGQWJ1OU9l?=
 =?utf-8?B?aThKNFFvb1l3ZEpqSHFMV2l2UEpadVpYbXA1d0pGL0hRY0F1aGtPMk1NR2Ey?=
 =?utf-8?B?RnFzajIzd0paSUdaZGphbTMvai9uNXl4eUhobUtKU2s1OW1vOXdCSC9vSS9v?=
 =?utf-8?B?MDN3RGRmY1RIMlQzdTFUWmFyUFluKzVxMUtNNUJYb1pmbkNoZ0kyRlVHbnFH?=
 =?utf-8?B?R004alA5RHZYczlsZlp6OXo0WnN1bkVsdlNMSnlkTzB3ZURiZjdJMFdvWkJ1?=
 =?utf-8?B?VHdsNkNGeDVpMUU1UjJ4RzE1U1h0SFFCYjRzSENUVUl3WlFTeWtZVFhGSmhH?=
 =?utf-8?B?dDdSbzVPcVpsbFVueG9iQ0kwQzNCT3p2bVdoeVV1TG5DbWV3Q21NcUs3a3dJ?=
 =?utf-8?B?VzFMYWVRVkVXblRlS1BYcklDdWJ1RDFhU1hncXRWYytjOGpWNDdtREk5dWlO?=
 =?utf-8?B?ZmZBNUhUME9SWERTV2RRczN3VDBjcHZwK2t6WktkQlQwa25CR0M3VHhzWmdK?=
 =?utf-8?B?N1ZMdEtPU1hhQ0RIVGNJMm9OckNzWXl0SlRPQTlWeEdIUlR6L0NxeElTaTJC?=
 =?utf-8?B?d3phUjBTMnZORDNyUmIrZW9WQk5HUWxLUkUrY21naXRZOEt0dzFlVGN2ekxO?=
 =?utf-8?B?cTl3czN2Y1ZNUWNoUGdRanppOGxGTTB3YnlMaUVhTXBFUUFhWGxtRWJuSkpy?=
 =?utf-8?B?WmRoR2NVOUFnM2JteDZhWWh0OUZqYi9PUTVEV2xoV1JwWlJZUjR0NUxnTzJM?=
 =?utf-8?B?TWtOZEtWTVpVNW42SStIcFNMaFhENHUwSXJQZHdMdVZFQm1lWFhsUFArQWt4?=
 =?utf-8?B?VXhXa0lrWUlscy9VR1U5enhkcnlOSnp0Vlh6UElmTFlzUTY2eFNnVVhUWWxi?=
 =?utf-8?B?ZkFJcGdlS0pXZTI0OExRNzVKNEtEWnlGUGZ0ZEJ3Sjh3bkhhOWkrN0VtTklt?=
 =?utf-8?B?UFBaY0FmdjFvSnVQNFpMUlh1cGZ4ZVFiRnMybS8zUSsyczlmenR1T0dheWVN?=
 =?utf-8?B?UWNDeG80b3VoV3JSVUVMYW55KzVaK0YycERhZWs4ZkRMUTY4WjlGbGVqNVFu?=
 =?utf-8?B?NjlHcDlsUmxmNlJpcHVKUytHako2MkZZZ09KZzljdDNaTkExQVN0dThGanpo?=
 =?utf-8?B?M0d6SjdkeDBySm1Sb1pYcjB1SCsvS2hHSHJuMk41RzYwNVJ0NVhtV1RodnhL?=
 =?utf-8?B?SSt1ZXYwQlpqU2dtZXI2WEQxazhHcm0xcjFzMU9TVm9kd3hpdmtzL29OTklY?=
 =?utf-8?B?TFNVaVgzdnFBaXVwTlBPTnV3cWhKcmU2TENBU2piZStuRXZxVFBOZkFPQkhK?=
 =?utf-8?B?dGRRdXNudG56VEVVeXcxdzN5a0hUd2J6aUZoekRmdVZGaG1yaGlvUjI2bXVx?=
 =?utf-8?Q?RD459WDb0RGgHopIvS8ERiF29?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5ba9ec-f0cd-4bde-9fb0-08dcd336d7f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 14:26:08.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aETVHXD2MJv8NF0IL15LueUfiExc66hWdpfEbDv74VbBa0H0T/Uo5ge3PsMXIasm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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



On 9/12/2024 2:42 AM, Russell, Kent wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Fixed the typo locally.
> 
>> -----Original Message-----
>> From: Russell, Kent <Kent.Russell@amd.com>
>> Sent: Wednesday, September 11, 2024 2:06 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Russell, Kent <Kent.Russell@amd.com>
>> Subject: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on SMU13.0.6
>>
>> During init, there can be some collisions on the i2c bus that result in
>> the EEPROM read failing. This has been mitigated in the PMFW to a
>> degree, but there is still a small chance that the bus will be busy.
>> When the read fails during RAS init, that disables page retirement
>> altogether, which is obviously not ideal. To try to avoid that
>> situation, set the eeprom_read function to retry once if the first read
>> fails, specifically for smu_v13_0_6.
>>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 9974c9f8135e..65d24c2f7e24 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -2107,8 +2107,12 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter
>> *i2c_adap,
>>       }
>>       mutex_lock(&adev->pm.mutex);
>>       r = smu_v13_0_6_request_i2c_xfer(smu, req);
>> -     if (r)
>> -             goto fail;
>> +     if (r) {
>> +             /* Rrtry once, in case of an i2c collision */
> Rrtry->Retry
>> +             r = smu_v13_0_6_request_i2c_xfer(smu, req);
>> +             if (r)
>> +                     goto fail;
>> +     }
>>
>>       for (c = i = 0; i < num_msgs; i++) {
>>               if (!(msg[i].flags & I2C_M_RD)) {
>> --
>> 2.34.1
> 
