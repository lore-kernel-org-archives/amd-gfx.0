Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB31E98E06
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF07A10E113;
	Mon, 23 Feb 2026 08:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xdu31grh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AF610E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 08:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crBhSEGXGUDcLMb94ZIdVds/7VM/a2xfHcZc4YnWHLG/QPem5ue0ziL5JOly/bOCuSVVPRf4t4f3cXVUSU8WQ0QR6z2fWmdxByNhSITRExVV1HnfZN/oBdpbqcskh40bTIFyHXCklp+466fr9VhiolPeo0iE72RiULc5apzdp1XdFkiHj6vrqxjN2SCNsl531VVyh+2UnPIawajOvlZIlbuSu8l6CZTrTh18eqzmIEFyK6+vSqKkymWjfNZOqdLF2JfATcq2MWysIpO67cHnvTmr8n6U8lqNxEw7NUZX+x8N9DQ77jpVCexnURifukp0L2bmGJDw0chg3/IGlBQsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz6tV4NQ3csio0OE2+BiJKLUlAjKCwiDS+1EhoK9CJs=;
 b=iE0THn0zzgH2KUEszHIKUPtRTLo+wffhTpwuSswlc0Qz+ER/dD7VA5dxDl88kXmuuuj2WFJQcDsaxe6IDMxD5mLh+KFOebTOoT9Vwd2J3qunafYLHReQsjpgiRBPHEygcGrR+52EeWFQq9ccMBLVjhHHX4dY6aBT18RTzZ1lTofnSWRn/oLstGGbk76ncojw+Gs+s6nR7SLhC0LCg5++sMxYM6M1VIP2bhId/emm9DUzTS3MW7wjPmhTBgzJMdKwD2VnsxMfNKM0e3+3oSS19uoEot1UHF/xPYDfwaQxesD7+KLi7c8MLO94QreAgn/EOyLcRLwDBC1nhCIT6FMRag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz6tV4NQ3csio0OE2+BiJKLUlAjKCwiDS+1EhoK9CJs=;
 b=xdu31grhdUbkj41JIio50aBm0HjjkMKjgOvhgrn7SdeFdoqhoRkYEixCpw/0pfT8svh/qKqAPdx9kLY58kP0xQv1f7FdLQPsVHv+vpsLmOLsWPx28MSTjW8TDzaGX+5L9IS11m2QnjlG96D5gTCf8Gc6XChDoeeZqL+u4430l2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 08:21:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:21:40 +0000
Message-ID: <a55ecb91-8aa2-41c5-bd76-b3ffa7d6c23c@amd.com>
Date: Mon, 23 Feb 2026 13:51:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
 <3c4c8c6c-5bcd-426a-bd39-fb24db8fc5f5@amd.com>
 <b05a405a-c9a3-4276-85df-daf223fd2a7b@ursulin.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <b05a405a-c9a3-4276-85df-daf223fd2a7b@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: cb06087e-a9d1-48ff-bd91-08de72b491c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXg3ZVVNUVUwaG9nUm5NOFlySzJ1b0J3bFU0QkpNWVNtVzZSQ2dtQ2U5TjJH?=
 =?utf-8?B?d3RjQkRlU3F0V3IrRUc3N1FsSVBvVXJrakcxWEJXZGpHakFlLzR3T2d0VFg3?=
 =?utf-8?B?a3o2VUZhYkpzSzFrWWI4cVJPV2ZDVlNkVFkrNUgxTXpESHpPbUg2MDdJNlJL?=
 =?utf-8?B?a1dNRmpoZHdNaEVWQUFhRldDcWw4V0hhTEwrSTgxNzUyQ1c5RjVwbVpqOXNV?=
 =?utf-8?B?VnFpeklHNzRhc25jMWxBNVYvWXUzZ0hVYm9tQ0xxbHVVL0FjRElaTCtjTER1?=
 =?utf-8?B?UUUxU0dKamZ6TWNJWUtRbG83NE5qMi9oQmxjdGdJVVFMTU52OE9qclVpaWU5?=
 =?utf-8?B?SjNaRUVidFIrWE5nQ21tbm1DSFNtUzd3dy9aM2pDVDZTclgrdWQ1STRvWTRN?=
 =?utf-8?B?YnI3SUpMZ243bWluZitEYlk5MXoxL1p2NGE2VmpDclpWZWdGMTVsQnRCTXBJ?=
 =?utf-8?B?OHUvaFNlYXlISDZNWG83dll4c3RWSE9ZZE5sOG5Yc0x6L1Z5TUpGY1hNYjUz?=
 =?utf-8?B?YWRhTG94bE9FZ0ljcHE0L2ZncCt4ZXVIL3QreVFrVVFqaldOVDk4WmxqYkRL?=
 =?utf-8?B?M0NrVGsyZmI1aVgwajZZeFJnNEVNOTR3ZnM5MExDZUhudHZUZDJldWxKR21Y?=
 =?utf-8?B?NW5nSjgyeFZLT0FDUzNRUVhGWndFaDM2RDd2bC81ZVBrUEFoaU9QZ1dqcG0v?=
 =?utf-8?B?Zmt3bzA2ZWsrZ2NZVmFQWm1mQ0pXd1dWYVZ6MnUwVTFHQ0lTR0RUNUxCQzBN?=
 =?utf-8?B?VTFEYVVseTlMaThlcUNabVBJc1dyZEJZYmpVcWErN3FpcG9TaUF0bHR1SUtC?=
 =?utf-8?B?VzdHalg1NlFrTEM1b2hsR0tidkxVM2FXN1hRY2NKTitIa0k5ZHorVEsvaEFB?=
 =?utf-8?B?OFVrUlhEcEdaenJWOWJsaE15Q2hrRWd5YjA5NHZ6UWZVcVBxaTNGSk5Ld0xl?=
 =?utf-8?B?Y0pNR3JDWmVQbVBHNWxBa3BKN1loTEtXVm94ZEZNOU5neUF3RFNsZ1NyeXl4?=
 =?utf-8?B?UFdEQ3V3dG03UUNQMGtFN2NBdnBaM0F1a0cwdy8wcVZYQ3Zzdk85ZHcvL3p2?=
 =?utf-8?B?dnpCL0FIeS8wWGFJYXVFVkxERnBYYllnQnJJS0xsR3BYRGdXNksvTWM0UmJv?=
 =?utf-8?B?YkgyRDB4b1NUZG1nTHEvM0gvNjc4VElmS2ovdUlSNVNkbjRJUkYzelVBeWtM?=
 =?utf-8?B?MXZKSVdoeHpuaWN1UFB1WkJiUnJleGNJdWhPSGhseUtkYUtDL29LZUpTVi9M?=
 =?utf-8?B?UFp1cjVuQ1JsK3ZwUnNNVnFsa241NjJJYWxITlFkRDJaMDAvcUR0b3d5REFU?=
 =?utf-8?B?ckFTNDJURE5JVVFLV0p0aHNOUDJyNTErS2Uxa1dDUUVsd1Y4OWZNR2dmQ2Jm?=
 =?utf-8?B?d3lHdzRqV2lxYkkrTnZ3TmJ0OW1QUm11S1ZvSVZackNGUUJTTlRFd0dxZTZ5?=
 =?utf-8?B?Zkt3c1ZkN0JRMXBxbmdQN212QzdsNzgySWNpMGtzS0xxcjFYK3A0SnBwMTBv?=
 =?utf-8?B?WSt0dDBCMW55eHhHZEtmUVNYV0d6SlBoSFdOT3FWSEFHRy9kRjBKM0FlMlhM?=
 =?utf-8?B?ZHJvUmFoYUlUSC9GT0k0emtIZjBIZzN1dTNPTW51dGhRZzdZZGxyZ29waG1u?=
 =?utf-8?B?WXdaOTUyVmNEUk92VUpHaDNVTFArK01yanFaN2NlRi9HVENPWE9MU3ZQaDBx?=
 =?utf-8?B?MGNJVFhxeWF6Z1lTYVMvODhMeGxtV2NSMGFWUHd3akhaQ052YlFtbTdTS3Rj?=
 =?utf-8?B?U1hmdzhobmVoanltUVJQeFV6RXQ5MHBoUFZYT1FkOUVJOE93d3g0c1VDUUxL?=
 =?utf-8?B?NVAvR1FuTlhPQmpCaWRiNDdyd3pQT1RWNjFxWlgvNklQL2RJK2t6UFB6bzlh?=
 =?utf-8?B?ZkZBTDk0WVJPQUh4YnFKMGFiZHllOFdGbVp4NC9JaXNNT1F2QzYwbExyM0JF?=
 =?utf-8?B?bU1FMDRrM1cyWGVLL3VHdk1HQVI4UjJDTG04aC9VOURzQ0g0NENsWG96UGxO?=
 =?utf-8?B?bDJvVFRyOVVvMG10V01nem10d09kbjFxTW1FMndIcTEvb25tUklxMHRhTXFY?=
 =?utf-8?B?RUV6UmpnK2cwOGI2ZGYwZm54RlRtdWlKbnNvVi94S21PRE40aEpLNWhod1BQ?=
 =?utf-8?Q?xuZAAKBF7Ch4ZJN9GtiEg9HIS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUc2OTVhcnluNTV0ZUh5bFlqcU9Fa0paZTBPcDNDaFJBR28zWGFtb0czdnFi?=
 =?utf-8?B?NXVucisyOTRHbjNyWm4xTEp1Y0k1VWJZdFJwaWRXVVBpbFFwN0J2bUtBM3hs?=
 =?utf-8?B?MElpcUF6LzZ1RGZtYUJiMnY5ZkJWekgvMC8zYWR0cTJkT2RqNXNDMExMU1I4?=
 =?utf-8?B?cHJya1pLTkdTVzl3aVNlcUVhNmtPcFFYL3ZnVElta3RXYjJPWjRuc09oVE9j?=
 =?utf-8?B?dk9Rc3lwaCtMdXdzYTVXck80UTBwMGZSLyszZVp0UnBKUDRDUGdTRmZIdnBs?=
 =?utf-8?B?MDBwYkg5eVhJMTlDVldPUW5WSk83b0FGSWRSdnRQaVNVWW1OWjNEVmZCRFpj?=
 =?utf-8?B?N0NSUTNDQTZ1bU9MRS93cks4c2hVZGNyQ0ZaVEdFRXZOMkNlYmNJdzVBTzJ5?=
 =?utf-8?B?WGdhQVYrQkoxK2tPc0NHVUdWbFVKWEh3SUJiT0xMc01QcHU1NkZXUktDVEpX?=
 =?utf-8?B?U1lhRGpWUEM5ZzZNczRZWk1oUXBXcjM4NmljWVpuT0wrYVZVWDUyQzNFa2x2?=
 =?utf-8?B?VzhSR2YxcW02Um9ndmMrYzE0TnQvUmxvM09SOFZ6T2xHcmFMcGhYKzhTQ1FX?=
 =?utf-8?B?NUpGVzI3NVpRbWxXZXNGY0RCRkVwemxUZGNuRENsRjQxUjc5QXpkcW9FWTJj?=
 =?utf-8?B?RnVrTDJKYzZYL1BMaDd6T3N4VTlWeVZ1clJTaHc3QkNaU2s5T3g4NHNpY09k?=
 =?utf-8?B?Rmc1RHdFaUtqWFd1UE5lYVZxZDc5VjJYTVAwWHVhRHFScHVyWVo0Q0ZtRCt4?=
 =?utf-8?B?NThYTm1HQmJ4bHRJZU1hN0lLRGVVN0o0MmpieXVnZE81N2RVL3VkRDN0NnFS?=
 =?utf-8?B?b2pjRWpBRkEzb2hFd3puV0IwKy9MQjlpRTZRcnpqSVRCd2dzS3ovZ2QraDNE?=
 =?utf-8?B?SUF5VmZSazFNV0lsR2RPYXhRZVorM1UyYU5BUzA3aDVyQ2FEU2NOeHZoMUFo?=
 =?utf-8?B?c1Uxcy9EblFUWE9ZQ3F3SlZLc0V0Tm9lS3lUSkpWMHVSN3FCTCs3QlNuVk5Y?=
 =?utf-8?B?N3VPNTE3bzkvZDQ2ZGZwMUtsNis3RWxOYzExUmd4U2JzN1hvVTJWK01ybzEy?=
 =?utf-8?B?ZVdxT3IvYmFHdWdobzV1UmJuUndQeUlHT1d3aEUvaW42T3dNWDJ0NXJzaFhk?=
 =?utf-8?B?NXdQRWlCdk40VjVjcmFqY1BGWlk1ZUUxL0I3alFMdVdNNVRJMVhGM0NrejY4?=
 =?utf-8?B?NERWM0MxcWhYNkVlWFZRMlhhanVKWWhtdzJqMllYUU5qT0J0UmFTenBqUlJD?=
 =?utf-8?B?U2FXejA4dDJZcFl6djIrdWJDSzVKZGJRWmxtM2FlY0RtQklXNEtpeWxpSUZN?=
 =?utf-8?B?S0xvTXFEb2UrUDh1SGFoR0M2OVZYT0RrVTdFazQyRmtrM1FJR1BPL2d1VmdG?=
 =?utf-8?B?Q3VHWDdSY3pBa2doTU41R0FoRVJrVjFCdGo5VUJESDN4UGR2VCtBaURTVm42?=
 =?utf-8?B?a0dKa0h5Y2hXY3RzZ0Excy9EaFZydGYrY1RKNzBWeGhOU2FHdFh2bG8ydlZr?=
 =?utf-8?B?UXJTYUk5NUw0YW9QTStncUtzRUJML05STEY4c3lqQTU5UWhwOU9nN0laSkg0?=
 =?utf-8?B?Z2RpckdkZ2pnRmxwQXZNZnN5YWpFUG5yYVB3UjR2R3drVEtHbHExK3E3YjBT?=
 =?utf-8?B?QUhvcTc4eFZLaGF4THFDOGE4eUFQaDg1TWZpTUN0eWlRMStyMGZxMFBSQnNH?=
 =?utf-8?B?bkRBT3lOQVQrWE1TQ0I5QklITjRWcmtQY01YZC9hVk4xay8zWEo3Qzl3dmlp?=
 =?utf-8?B?d3FMKzFyeUFhdjRJN1laNjUvZEFGcURKT0pZbWVlSXVyeXFiVWJoOW0wd1hK?=
 =?utf-8?B?dzJqMHh4cFprKzJ4enFrU2FsYm5qcW1vM2htRy9VZWtFcnhiWkVDZjVsZmpl?=
 =?utf-8?B?WDNEZkFtZzdKcWgxeGNMc21ZcGF6S1owVVphRzJaTkluckhvV2VqdjZWRXl1?=
 =?utf-8?B?a3lBeU5NN2hib2JaMXhKdytYUnN2U05MOER2UTJDSEF3REtEdzBIUHY4eHdD?=
 =?utf-8?B?Mit2aDBKbkJFSEZDWkhqTkFsZGNxZVZhcWVocEtnU0lTamtOWDRmWjFtQ3Er?=
 =?utf-8?B?TUJycWxrVWw0R1VWOVVoRUdHRlMrTUczNno5VU9BeUI1WTlVTzZvSnBqc0to?=
 =?utf-8?B?b0YvOFkvcCtwVVZ1TU41WjBieG4wUis4d0xVeUZGQS9HdnUyWXlWU2NuSDE5?=
 =?utf-8?B?ZzNEOWRoZ1hHS3pkUWd2dUw1WVBEcnpkRE9WaXVKb21ReDRmeVorN3Y5ZUVj?=
 =?utf-8?B?UVZSUG9WSDlVUjlFZ1JGSnZDMmp5U2ZwLytodTJUYUtyK1lQU1VKN1JLQjZ2?=
 =?utf-8?B?NDYvcGhsc2JUbXZJNmxVWVNndFI5bDZQZmxYZHducDdyRVVtdS92dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06087e-a9d1-48ff-bd91-08de72b491c8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 08:21:40.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzGtXjd1QwXkP5B20jx6ZJdi23RM8J6PX+i0JkdfAaPfLgjf/bG7KaRCrEsG3HZqUJnWtpA/ewWL339Rapxshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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


On 23-02-2026 01:41 pm, Tvrtko Ursulin wrote:
>
>
> On 23/02/2026 04:31, Khatri, Sunil wrote:
>> Applied the changes @Tvrtko Ursulin <tursulin@ursulin.net>
>
> Thank you! I am glad they still applied!
>
> Also, you were suggesting in your last week's reply to "Please make 
> sure the changes are made for all memdup_user". There are also patches 
> in that series which convert to drm_gem_objects_lookup() which remove 
> some more, but, for those I think I need to check if they need 
> tweaking after
> dbce431756f8 ("drm/gem: Make drm_gem_objects_lookup() self-cleaning on 
> failure v6"). Maybe it just works though. I will wait until the ones 
> you merge appear in some branch and check.

I am in process to merge only two changes patch no 6 and 7 in the 
series. There were conflicts but i fixed those but still there are some 
more memdup_user which i will fix with a patch which are left after 
these 2 patches gets merged.

Also if you want to take that up its ok with me. Let me know.

Regards
Sunil Khatri

>
> Regards,
>
> Tvrtko
>
>> On 20-02-2026 06:49 pm, Khatri, Sunil wrote:
>>>
>>> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>>>
>>>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>>>> memdup_user could return invalid memory allocation if
>>>>> there is an integer overflow. Using memdup_array_user
>>>>> make sure we validate the size requirements upfront
>>>>> and return with an error.
>>>>
>>>> FYI:
>>>>
>>>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1- 
>>>> tvrtko.ursulin@igalia.com/
>>> Are you awaiting for anything to merge the changes Tvrtko or they 
>>> are merged in drm upstream already? Since issue is reported now so 
>>> we need to fix this.
>>>
>>>>
>>>> And later:
>>>>
>>>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7- 
>>>> christian.koenig@amd.com/.
>>> Yeah i am aware of these Christian changes and we decided we will 
>>> fix the issues first and reorganize the code later as needed along 
>>> with Christian changes. So we are going to push the changes
>>>
>>> on the existing code base first.
>>>
>>> regards
>>> Sunil khatri
>>>
>>>>
>>>> Regards,
>>>>
>>>> Tvrtko
>>>>
>>>>>
>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> ---
>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++ 
>>>>> +----------
>>>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 212056d4ddf0..a6eb703b62c4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>> drm_device *dev, void *data,
>>>>>           return -ENOTSUPP;
>>>>>         num_syncobj_handles = args->num_syncobj_handles;
>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args- 
>>>>> >syncobj_handles),
>>>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args- 
>>>>> >syncobj_handles),
>>>>> +                        num_syncobj_handles, sizeof(u32));
>>>>>       if (IS_ERR(syncobj_handles))
>>>>>           return PTR_ERR(syncobj_handles);
>>>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>> drm_device *dev, void *data,
>>>>>       }
>>>>>         num_read_bo_handles = args->num_bo_read_handles;
>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args- 
>>>>> >bo_read_handles),
>>>>> -                      sizeof(u32) * num_read_bo_handles);
>>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args- 
>>>>> >bo_read_handles),
>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>       if (IS_ERR(bo_handles_read)) {
>>>>>           r = PTR_ERR(bo_handles_read);
>>>>>           goto free_syncobj;
>>>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>> drm_device *dev, void *data,
>>>>>       }
>>>>>         num_write_bo_handles = args->num_bo_write_handles;
>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args- 
>>>>> >bo_write_handles),
>>>>> -                       sizeof(u32) * num_write_bo_handles);
>>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args- 
>>>>> >bo_write_handles),
>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>           goto put_gobj_read;
>>>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct 
>>>>> drm_device *dev, void *data,
>>>>>           return -ENOTSUPP;
>>>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>>>>> >bo_read_handles),
>>>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>>>> +    bo_handles_read = 
>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_read_handles),
>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>       if (IS_ERR(bo_handles_read))
>>>>>           return PTR_ERR(bo_handles_read);
>>>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>>>>> >bo_write_handles),
>>>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>>>> +    bo_handles_write = 
>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_write_handles),
>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>           goto free_bo_handles_read;
>>>>>       }
>>>>>         num_syncobj = wait_info->num_syncobj_handles;
>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>> >syncobj_handles),
>>>>> -                      size_mul(sizeof(u32), num_syncobj));
>>>>> +    syncobj_handles = 
>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >syncobj_handles),
>>>>> +                        num_syncobj, sizeof(u32));
>>>>>       if (IS_ERR(syncobj_handles)) {
>>>>>           r = PTR_ERR(syncobj_handles);
>>>>>           goto free_bo_handles_write;
>>>>>       }
>>>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>> >syncobj_timeline_handles),
>>>>> -                       sizeof(u32) * num_points);
>>>>> +    timeline_handles = 
>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>> >syncobj_timeline_handles),
>>>>> +                         num_points, sizeof(u32));
>>>>>       if (IS_ERR(timeline_handles)) {
>>>>>           r = PTR_ERR(timeline_handles);
>>>>>           goto free_syncobj_handles;
>>>>>       }
>>>>>   -    timeline_points = memdup_user(u64_to_user_ptr(wait_info- 
>>>>> >syncobj_timeline_points),
>>>>> -                      sizeof(u32) * num_points);
>>>>> +    timeline_points = 
>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>> >syncobj_timeline_points),
>>>>> +                        num_points, sizeof(u32));
>>>>>       if (IS_ERR(timeline_points)) {
>>>>>           r = PTR_ERR(timeline_points);
>>>>>           goto free_timeline_handles;
>>>>
>
