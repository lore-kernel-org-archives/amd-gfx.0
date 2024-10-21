Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1474AD15DBD
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 16:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2A810E561;
	Mon, 21 Oct 2024 16:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t7DOn4Nt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B743910E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 16:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEHXNvW7+dz+zw5NPhab/JUhmm82/WSQCNUdSFW9jnKdlLQ5bapYBdgcsq5R4gmQgq7gs+18/2GsSkntaCNil4O3BzxeyepZpqhmhpcjb6TXCPfE2BqBC2rOhg3S37CFN25DS72bcMzNGuBXQiKd49wFLMLLpfLG+9l0S+owExbKVLzYnT5otTPhtPznw2lUNHpizCzY8+9qimmQbEhG8ja87rLRDn+54IMPuEiks+f+lgUotlgo1v3FhmLQrG+j17SLTs0njpPVw7c+lSfdwgirhCY39kT2OeKr3NCIumbQuv93BzDg3/NMMjV5TSLkj4HFdNX3U2fUrLwOXcd+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPefEDV5/ua+eOEi6JbLKoSpzGxAb0KS/QYi+1nefwI=;
 b=GOr/psjR9HzFrkvavCulY5XmylWyRN2v+FJaa55ugUcm+MAbu6x4aVcl1bijUwM1NIZkErd94FadAjyy7SHFTHAvVSZR7dR9u591jPeF5AiAuP3ldJQEC4swncYO5z+2QyfUX1otwRWEJlyO9ked+M5fQM3BujKJi8pOEiY6DMexgGR0xvXq5Vw6iIu7DIkGyS+19xfo8qPj57e3/CJxb60Vy6oH7lZh4Sk05CqClG6h/htwdwAixnh5k8bg7IOxXI5oBQtrUdRiFamwinrjYrbhFFTfwCmv9Z7zreBkK68yyiq8r7vR/sSjF/YUJOaIs778y5agsCZaAhRLfxbwqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPefEDV5/ua+eOEi6JbLKoSpzGxAb0KS/QYi+1nefwI=;
 b=t7DOn4Nt4iV9uHOmACZcgDqMyAjhlN1nYjtu7rgqd0BR40eICwVxk2EOvIR99KeH7ToweCTgBmBG5dAn5DaLvn0sB+JyzOZblKlG2x/f52DWVRuFt0a6r3lLcAtDt11J4NRh3qBoarrsFljkatmmNcOB8SjAqmKHHtKZrrSnFeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:47:05 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%5]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:47:05 +0000
Subject: Re: [PATCH v6 00/12] validate/clean the functions of ip funcs
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241018132327.1638247-1-sunil.khatri@amd.com>
 <6339ba5b-70f3-47b6-8989-5fbff8edec14@amd.com>
 <42b66e1d-0efd-8d60-2dfe-39a7405bc7dd@amd.com>
 <BL1PR12MB51448ECF0CACC1CABA45FB80F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <e925694d-64b6-cc32-9026-18da0c361f96@amd.com>
Date: Mon, 21 Oct 2024 22:16:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <BL1PR12MB51448ECF0CACC1CABA45FB80F7432@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PNYP287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::35) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc878cd-d06a-498e-effc-08dcf1effe95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmltQWRaTUprcUNVaUs5S1JQUkZmUkdMdDZYenpJcXpPYjJFWjN4Vi90Y2pj?=
 =?utf-8?B?dHZxRmhBeGFVbW1zQVdxOG5GMWl2cFcrNkdmRmo2c096MkZyalhrcUNHOEFv?=
 =?utf-8?B?ODlQVVBINXpiekF0NjhmRkhGbFNCbEo4TnRHMENJdG41MEUwK2lYbWRRU0lR?=
 =?utf-8?B?d0Q1QXhCeVR6WnozMnd6aUpmUHE0bFZkTGJHWnFTVHBLOWxpN3FKekRIQzg3?=
 =?utf-8?B?MkxDeG5WVXV1dHBwaGlONFZSVUNwK1ZXQ0lKQnZNSkdVVTZmR2NTa0J1d2pS?=
 =?utf-8?B?NmV2eEE0dTZENXFpUFNwdmhHWm54VGdtekxSTTlSSkVLS2FzSTN3MEZTeEZE?=
 =?utf-8?B?S1lDVkJ0Y1QvbVRkanlEVDRQaHJETjRTYnRSMFRraEFTanZDR0w3V1VjY1Ju?=
 =?utf-8?B?eHo2eUpld0t5WVQyLzhqOGpPTjFhL0xFcGc2b254anhRWVF2OHFreVROK1h5?=
 =?utf-8?B?WGJjVndDVjdEREdlVDU4UkFsbWphMUN3TDlzaEMvMWg3bFUyQ0F2b2VYZE5Z?=
 =?utf-8?B?a2hmbWZPUitzbGNndUgyTERWaXR1L2s5SE1GMFI5dFJ0bWJ4dEpoWStyc0Vs?=
 =?utf-8?B?M1FBUHlDU2FmMEhycldqc2gwUWZWQkM0RU1uWVFhby9zVTBnYTdZOHYzcEdZ?=
 =?utf-8?B?ZjNGYS9ic0tLVXJHNitQREZiYkhBMHlucDQrMUw5dVpiM1NLR2pPc2dVSjha?=
 =?utf-8?B?V3hVemQ5RmJ6NHcxeVRkd1hsQWF3RVJ5SjRhU2E2blVOY2gvc25vN3VCVjIw?=
 =?utf-8?B?Z1pnZkJNY01CWWZqbVk4a2YvbUpiV3VuQUdmN3BhbkV1TWJpcUJFYVNwZTFY?=
 =?utf-8?B?bzB4cHd4Qkt2dzVTWEJYaUNMd1U4QTNHTnd4U2Q2cnBnQzVtNks5ZGdGdExt?=
 =?utf-8?B?OWJSdjlyVUNCQXdOZFRPMWhUbVFyNFFMc2lyUGNIT2I5Wjgwc3J5Sms1ZTJG?=
 =?utf-8?B?NVZ6VmwzM0ZKMmZLYWVRVzBhbkVyTVRraW51MHVMbW9VNHJ4cmNnZEozazdX?=
 =?utf-8?B?K1ZHWUFSdXZ1U05QOGExdXoveXlYa0ppeDBGRExpclIwMzVNZGNvbmZVdmFM?=
 =?utf-8?B?N2JDOFJ6L0hBWEdsbG5SUG9UMWI1VUd3bEllVGxZaVkxZndCYkg3djMvSlNZ?=
 =?utf-8?B?M3NEcG9IYnYxbmFjS3BBWHZiRXp2dEdhakVSQTZOSTNnWC9sYVFOMU5aeVpt?=
 =?utf-8?B?Z0F5c2R6b2NMOWtSaVhqZkwzcEtiWEhPZjRFbmk1aVRuTEd5VW11b0xtb29t?=
 =?utf-8?B?NmVIYlltbUhScWxSM09SU0RnSC82cVNrcjFNWVZQWHlGVWt5ZS9jU1JCU1I2?=
 =?utf-8?B?VUJUOHRaWEI0VFVwZUZsd0tBSXJqVWluNkFYWnBRaWpMYVRmc2hrZlY1Qksw?=
 =?utf-8?B?cW4xeS9Mc09KMHh3WlNVc3RSRkR6cFdtcngzaE1GcEFhc0cvREdsb1JIT0hs?=
 =?utf-8?B?R0x2VERuTUVlcW96Wm9QTVdwQ2ZIZ3NHSWhFMWZ0WEhFeE1DY0FuYjFFSExj?=
 =?utf-8?B?QW1RVElKSCtaVlo0Tkg2RGFieitaZW1jWGlwQjhuVnNXcThGa3NzaXRsTEpE?=
 =?utf-8?B?dnR2dG1ubVovSWNDdmNIWHNPbWZDSS9wMisxN2FqZmJ1cENUUDFPRUpXVEpw?=
 =?utf-8?B?N0FwRm5VLzZVVjFaNE5FUklmaUxhemp1RkF4dkJ4S2VZbFBUVFJEdnNyTmVW?=
 =?utf-8?B?TU91elJLQWRpNzJ1OThrMXBTc2IxNlJLN0l6RTdRK0tTdExlYlFVbXgyYzQ1?=
 =?utf-8?Q?HByJLrLBsrH+bYMo1POUXkgBZywB2WkVwgTvIMP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjMzdHV4Z3dDVFhwL0dMbzB5cUhZS25sOFgwVUNjdldhLyt2REJwUjUrM09G?=
 =?utf-8?B?aWZGQ2pXMGV0cTZlL0ptWDM0RmxaU2l4b2pndlZvazZoQzdta0FON1JpT2lR?=
 =?utf-8?B?Wld2UURWL3d3RVJNemtrcGxkelZOWEtrNStnbnhjRjZRaTA1Tk9pZHA0dFhX?=
 =?utf-8?B?cWFOS1E0d3hFYlYxaFhvUE4wMTFnMzRHdzJvSm1qTVpXdzdrdGlSRmN3R2Vy?=
 =?utf-8?B?MDQvSEI2dkFIRlpybklaejB0bUVDdG9Wczc1Snk3YmpUZlJ1eExWNTdMczdz?=
 =?utf-8?B?OUJzV2JTSUxsckxPcG1DV3FlNVZmZk9UTGlFRGZZQ2hkTG9seC9kTzNkcGpq?=
 =?utf-8?B?SUZwQ0w4ZUxuZ0NwTFE2OFZrbzlyOEc3UWh3U1pxTERNTmJ2eHRveldsTitR?=
 =?utf-8?B?QVU5Wm1zdFpIcW41UUtPRjRyM0E2cGR5Sk5teGI2MHBNbFFwdCtvUzNEZzBv?=
 =?utf-8?B?QzEzckNiVS81QSs4RXJDU3VHK1NYeWZyVnF0UnRBdnN5NERkQWJwb21aWmxq?=
 =?utf-8?B?ZXhRWGdabnJqN0JtY2JsclB3VjM4Tzd4S3dVOFh0Rjd0ejR6MjJaWUxobFRV?=
 =?utf-8?B?TFBiUzhGVG9DbDE0eko4QkI4SjBraDN6NHRkSUVmejJSaFVuOHdQMkZaY3Ja?=
 =?utf-8?B?c04yd3k5WnpySnRybGpnRk1Jb21kRVJmN0Ztd0tFMktsY2FMTmR0ZERTM2FI?=
 =?utf-8?B?dTRhVXRCK0ZMSldmektKNU9xTzJtMDVTdTJnN3B3U2sxK3pDNHh4QytueWE5?=
 =?utf-8?B?OXA3MEhnMlZzWU5CTnQ5T2YxWlg3THV2TFJXVVBTSm55dHdWLzFERGI5UzIw?=
 =?utf-8?B?cWFMT3JTUTVuMTdZa08rbkFabnR2SHJoaEpyT1huRHBkenhERXcwTzRGZW1K?=
 =?utf-8?B?UjJYSGVuNlE5TlFlS3BSakZiRDA0dXF1aUpKb2NCR1Z2eUhNMEVrSGZza1Rt?=
 =?utf-8?B?Zk1PWmdpWkpTTGVudVBNNW0xcGRpRXhLM3pTamhOM3BJbUhGZ0xjbE8xUU9X?=
 =?utf-8?B?MXo5OXA4aVFrSHdBTDJLT1V1dlVqU3BSUzNFUEo5d3RueVJBUndIZjhkTVYv?=
 =?utf-8?B?SnRhQy9kT09LUnpTcExCWWV3OUM4UkYrWjFlK1RxdnhxQXRKMTFsN0NYUUpk?=
 =?utf-8?B?ZGpxdkNILzNYWDNPWnFzeFBTVUt1NEtmVGF3MUF3Vjk3ekpjRkxab204THhN?=
 =?utf-8?B?ekgzdmc2SHpsdStaUk9XczFmYVZXbjdIRUptUDEwK0dUTXlxeXA4YW9qTjFI?=
 =?utf-8?B?UnYwbjcwTlMxbHVaalg3bzJBM1pxRk5WcDJrWURoVXkvYmQ1Y3Nkam5RSWtk?=
 =?utf-8?B?SGQxMTJ3YlZybUtyamFjUWhTd3JVZTlzTHM5TVFLVlBiVnl5YzNwL3ppOFBJ?=
 =?utf-8?B?NkVXQ3ZaSGtDZHQ5WGErenJadm1nU0xWYVc3RUM0QWdmWXU0RndNa1dndzlB?=
 =?utf-8?B?VmNSdWV6WWtXRmUwc2JLOXUyUEhBME52RnY1UDY4NUlqMG8zSmxEM3Q1UjlL?=
 =?utf-8?B?dWRUQkZ4ejNOMFg0WWJJR2kxY1FsRlZUb1pZMnB4cjVONzFUVmtTK1VHVWpn?=
 =?utf-8?B?RllCMTNIODdnaUVUK0N3YWszbU9QeHA0ZVZhMmdkcjJCYmFsUWtHY2h4aVpI?=
 =?utf-8?B?Zk55Q3gvQXhseWVnQ1JqZllvZjZKSW1EWjRrMzJTOWd5TmRoT2ZXTTBreTlv?=
 =?utf-8?B?MUlUMmFtTFExWDJ3L2ZpT0JKaFNiaWFpUk9OVnJEUktXUW12ajNmVjA4K21p?=
 =?utf-8?B?eUhUc3hpeWQzYXdlQmpINUhLRGoxem9CNXlzZnJTQXhHZm9pOWg5U0o5S0t5?=
 =?utf-8?B?ZTNJL2c2MVo4ZkhucGQ5VWJ2dDk3aWxSdlpDNUtCYjdQUFNCcmowM2xCenk2?=
 =?utf-8?B?bTR3Zkl3d25KQlR0MXNjVW5BRlpxTm83azhHR2NRRTBERFVmTnhlblFwZ3Ni?=
 =?utf-8?B?bXBKREttRTdZU2JBakk3aEo1cGVRQlRuOTlGeU9mb1lBWm4xcm5lazY2ZUNP?=
 =?utf-8?B?c0RJdzB0RmtNM3QvYXRQY2VtZ01DbGhjNWR0bE9EVkhGUkJ2VlNoVEszM3VU?=
 =?utf-8?B?amZjYW1ZYWQ0U3hjNWRGZno5TDJuU3c2L0FIYm5ISkJKR3o4dTA3VWRpNDN5?=
 =?utf-8?Q?LknsYwA6naP3C7g3Js8rc/ICZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc878cd-d06a-498e-effc-08dcf1effe95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:47:05.3996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+7J3r3h39KJBqxKJNimG5TEwMhHmhBqxd/jJ5bdXAMTKjYAf6NrzkNdJnxfVqogldbDVd06FQHH/0iBXu1hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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


On 10/21/2024 10:11 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Friday, October 18, 2024 10:07 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v6 00/12] validate/clean the functions of ip funcs
>>
>>
>> On 10/18/2024 7:08 PM, Christian König wrote:
>>> Patches #2, #3 and #12 are Acked-by: Christian König
>>> <christian.koenig@amd.com>
>>>
>>> The rest are Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>> Maybe give others till Monday to take a look as well, could be that
>>> Alex, Lijo or somebody else point out that we are ignoring the suspend
>>> return code during XGMI hive reset for a good reason.
>>>
>>> If nobody objects by Monday feel free to commit the whole series.
>>>
>> Sure Christian, Thanks for review. Will wait till Monday evening and if no objections i
>> will commit.
> The return codes from hw_fini and suspend were ignored because we want to make sure all of the IPs are put into a quiescent state.  If one of them has a problem, we don't want to skip the rest.  Whether or not we should just swallow the errors or save then and then return a error after everything is suspended is open to debate.

As discussed with you Alex. We have reverted it back to the original 
behavior. So it will quies as expected if any ip fails and continue to 
progress for other IPs.

Regards
Sunil Khatri

> Alex
>
>>> Thanks,
>>> Christian.
>>>
>>> Am 18.10.24 um 15:23 schrieb Sunil Khatri:
>>>> v6: Fixed the missing return statement on suspend and update the code
>>>>       with V5 comments.
>>>>
>>>> v5: Fixed review comments. Dropped hw_fini patch and need to look
>>>>       further why such functions exists. hw_init/hw_fini are mandatory
>>>>       functions and we should have a valid definition.
>>>>
>>>> v4: hw_init/hw_fini functions are mandatory and raise error message
>>>> if
>>>>       these functions are not defined.
>>>>
>>>> v3: Added 2 new patches to clean get_clocking_state and hw_init
>>>>       validation.
>>>>
>>>> Sunil Khatri (12):
>>>>     drm/amdgpu: validate hw_fini before function call
>>>>     drm/amdgpu: return error if phase2 suspend fails
>>>>     drm/amdgpu: return error on suspend failure
>>>>     drm/amdgpu: validate suspend before function call
>>>>     drm/amdgpu: validate resume before function call
>>>>     drm/amdgpu: validate wait_for_idle before function call
>>>>     drm/amdgpu: clean the dummy resume functions
>>>>     drm/amdgpu: clean the dummy suspend functions
>>>>     drm/amdgpu: clean the dummy wait_for_idle functions
>>>>     drm/amdgpu: clean the dummy soft_reset functions
>>>>     drm/amdgpu: Clean the functions pointer set as NULL
>>>>     drm/amdgpu: clean unused functions of uvd/vcn/vce
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  24 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 150 ++++++----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  25 --
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  10 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  19 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/cik.c              |  15 +-
>>>>    drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>>>>    drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/nv.c               |  14 -
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/si.c               |  21 --
>>>>    drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  30 +-
>>>>    drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  20 +-
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>>>>    drivers/gpu/drm/amd/amdgpu/soc21.c            |  14 -
>>>>    drivers/gpu/drm/amd/amdgpu/soc24.c            |  12 -
>>>>    drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 275
>>>> ------------------
>>>>    drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>>>>    drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 274
>>>> -----------------
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>>>>    drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>>>>    drivers/gpu/drm/amd/amdgpu/vi.c               |  14 -
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>>>>    drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>>>>    78 files changed, 114 insertions(+), 1122 deletions(-)
>>>>
