Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B73CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 16:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB2010EE9E;
	Fri,  3 May 2024 16:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q1GCWnso";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C69010E900
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 16:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbvrN4lHk4dUc3cRLjdSGENLMG71/j8pAnAdvEZguk1ijojzbNlIwLetcd4iXqBfQAEPDvSkHN4h9VC8qZVwPCi6krPzfkLVimthp6r0mgg4WxVc6GGPGLqEeFBL4hxj6hdSmeah8OcU+5VqumpHCgFdiFoEC4KxgDmDsRM3qqXJ4F9Cq50fWfk3V2sHCNAs/JJN7GlMvu3/WVE/2Vij/a2o4kg3GZ5DW292GkYaOdbS0te1a3npkvSMXAzqUhnVUy0AP5uX3bkCq7foF4zjDboAuUgTrjiB5e7rhFj114wDQ2Fzauup/d67PFhj4l1KaIZTekYSN45ArCfyUbjQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar4IBsqlR0+66MilmbRcpJuCTAj149RYta0SiFeV0FA=;
 b=DPwqwzhkpmuTMz4G1VxpSYMaN5W2seZcYCVjh2KhSj1q7RvR4P7p0Zm3B+c+ISnwaqariPajyXOz6PM9uffYtxvOO6eV7c9om2ueXa1EDbg3Jxhw3Bif1fJj7wgcIEyaDgkSMnYwUQ9OX+U4aOoSFrYlGG05V99w8Gq6hin6nhBAS+O1aptmdDdUPWgyOvKKt3e3yNOKFjCpR04A9zSG4e9xyGO5q3lEN7/NKY6YLukiAnMr44LrBZsXsolcaIsDBhFQM+oAHH4V8K5nWSa70g09JuiJFxivRnR3F5iWg8rNEyHl/Lj+VCAr951DFkjbyVsIdugMcqS0vbuaPZ+suw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar4IBsqlR0+66MilmbRcpJuCTAj149RYta0SiFeV0FA=;
 b=Q1GCWnsoazWPAtKrRN1++MhvBOVIIoW7ynL02wrOXFbiQ1tnm+hGdAkQSkkmzP6Ic7KG49LOpzFpByR87Ym4AJl0DycKLn1ewer+Xhzx2VEIIg53D9L3p8KAES0xDUXT/L9icBXl50sMiDs1Nw6steBEmPJ1XVw7mjkZKqD+7Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 16:09:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:09:35 +0000
Message-ID: <76aca882-f1f7-4edf-8dcb-2098dc1a52a3@amd.com>
Date: Fri, 3 May 2024 21:39:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu: add compute registers in ip dump for
 gfx10
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-4-sunil.khatri@amd.com>
 <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
 <5681bd76-f01e-491d-982d-2448aaf4f9af@amd.com>
In-Reply-To: <5681bd76-f01e-491d-982d-2448aaf4f9af@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 95466c87-0def-442d-bf9a-08dc6b8b6d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0pIbEkzMitzQlRxUU9mQUJ2dDVGbEpKM0xabytpeWNRdm5HUG1ZWUY3bGk0?=
 =?utf-8?B?cU9mUXVGeTVHUnE0bDBpNGN3UFg1Z290MzhYZk5OUUJXOUFHcFVQK1VlNVFk?=
 =?utf-8?B?ZTE2ZDVZVUhpMzZSSzNENEN5bEx5cmtCcUtSOUExUk9WMklSK09qcTRkNVlO?=
 =?utf-8?B?NFM2K0E1c0ZnZThkVEplSjhRa2xPbU0yK1VQdElwWWU3UmN5bWQ0Vmg4WGVZ?=
 =?utf-8?B?c1NNRkdCbHVsTXZ5RHduNU9xQldyRnZmYVVUQXgrODMzTTJyNks4Tk81aXV3?=
 =?utf-8?B?Y3BkMVUxWlpvWldLK0RkRXBQUVNzQ1hEVlBHUFNDRGtaMy8vQ0g3L3JQaTJD?=
 =?utf-8?B?QmRzckhFalFxU0dvRFZSRHlBa0RCUHY4Q1NEVEhFai80YXp4RmNJa0w1SkRO?=
 =?utf-8?B?VWQwQmRkMWI0dE5Ub2lHV0lIRkZiTnNUUktMejdDdU12YXdFWHIrNzkxSkxm?=
 =?utf-8?B?ZFZZOUo0b3kwaE04NFYwemU4b0VZL2FpaGNVT0l2UmpCOHArYjdQQnhOYlBp?=
 =?utf-8?B?ZVRQbVY4TnN1WXF4WUZyWEZ6M0V2ZEVHNTJkNWZodzRjaGlhcjB5eHBXRnZw?=
 =?utf-8?B?bHh0azlYenA1Z3NrQ3BGMVhYV2JTRTBsWHNuMW4xaEtFOGRseHFTL2dROXhM?=
 =?utf-8?B?TlU3dWc2NEZpbmlBZEl0c2NOdk4yVTlhVTEvYXA0WGcxdTFSQnIvbHJXeXRl?=
 =?utf-8?B?TU5xVWI5Ymk3dzErNXN0dEJjelhWU1hFUDNLZXRpcjRhNFpuK2plSGNBUVJi?=
 =?utf-8?B?UFdHZ0ZJQmx6WlhiZVNPbXJ4bytYb2N4ZlZ2VHFsbzlHVHloQ1VFZllZUUs2?=
 =?utf-8?B?UlYrdmhzKzI1Nkc2bmJOSTNTemNtc052SW5pUXFZVHhCazFPS29YbzlWeG0y?=
 =?utf-8?B?Wkpqb3lkR2Z2M3FzNjE0WWloVWMwWmw0OWE4dURFNGNabURRY29DSy9qdHd5?=
 =?utf-8?B?OUljRk5Gbk03ZmZnRkdSWHZZTzVrQ2VEMGdhNXNoT2NDbnkxM1dIWUt0Vkli?=
 =?utf-8?B?VmlETllvc1J0eXU0THFJOFNyaC9nbk1acFR5ektNTlJiZjRsQkpmMXVuQUUy?=
 =?utf-8?B?QkhOM3dZT3d2U0J0d1k2aFpZVy8zNXpQMUJKR2w3WHpWSjdsdzJSK25aYnF3?=
 =?utf-8?B?MEpDMXk5QzNCVlJBZE1Gck5OWWRHbTZ0ODJPQTU1SmNQd3BiNmtCWjVIeWdp?=
 =?utf-8?B?bWh3Y1V4QTMzTFYva2k0SFkwUk1vOFRCV1NKVVVIRVYzTlNZRlRDUVZIUk9B?=
 =?utf-8?B?Qml0dHFSYURLT3Y1a2pFNEZVR1VXWGthZEc5cG1kZ2ZOTmVoc01wdnF3YmQv?=
 =?utf-8?B?MTk5QXdzdGJtTHMzcmtuZGpHMmxNb210ODJ0dGd2MTkwNkw4REV4clV5MFRX?=
 =?utf-8?B?OHZiWXlxdjBCSFBNQW5ybTFWanh5Yno3MEhjZloyK3kvSHNBWVpLcm5zZmJK?=
 =?utf-8?B?RzlienBDbis1YmRPdjIxdDE2WXVmUE1kRmRXYUN2SzZ5cFNWUlpoYVNDbW1D?=
 =?utf-8?B?QmtsTEYxZlc3QlNwQmNibFlLeklBOGptZk5CZkNLVUVTV2N5alFEMzVnQTRN?=
 =?utf-8?B?dmpFejZjNUtrVWhNczYrMjh0eDRLM0xiei9RT0FkVVBZYlErRWp2V3N2VzRX?=
 =?utf-8?B?SWlHNk1OZVhXRTdNRTZPWVJnKzgrTGtTT0xzQ2Nmei9CVG9LSlVuaFg2cCty?=
 =?utf-8?B?clNhMWhVRHVueEpjVU5HVG41ckFLNTM5d1l5c1JiS2U0NWs1emtucnZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBkQjJ6cjUyNmpKZFpVZkpKYVhCN2JBMUk1Y2xmUS9LVUYzWSswajRDcEZH?=
 =?utf-8?B?enRFb3RBMTJiNUVhOENnN3JMamlFWDJhSTB3MzArcC9kQkVCQ1EvTzV2Y1VV?=
 =?utf-8?B?bGo3bWJBclkwV0w0MGk4UHoxZis2c29JK1VUUnowNnZqRWxuUTVQOXcvUWRF?=
 =?utf-8?B?SmQ4SnJFWVdReUl4QWJETEhFQWtWWVVmZDh2N2ZGb1gwRWIvSitjZ0t4YUNY?=
 =?utf-8?B?eC9SbFN2ZjkwWkRsK0duMG1qK0k5ajdGWVlpMGhmSVp0ZVgxSG5ydFdkdStB?=
 =?utf-8?B?SERZc2h0MVBDdXlROWVZZ2NxVGZCOXpCbXc3Y0kxNXJNQmZyLzdwSk95d044?=
 =?utf-8?B?U21NQmY2cDFsa1JHU0dtK29WYkZJOUo2OGNFd2w3U2VQTzlBbHVqVVdPUFg0?=
 =?utf-8?B?TE1wOW81Q1cxSkVocjREVDhlTFcvR2NaZlFkaWlLQkx6Y2l0VGZoUVhiMURm?=
 =?utf-8?B?L1dhV0s3L3ZaT291dVM5YWN2OVlsQklrU1RQSHRhMnBZM3htZlZDTkNqbW5U?=
 =?utf-8?B?TGtlR1BJbTROdmFEOVdkUUJDWXRVWWhOR2NyMGlQWWcvTXU0N3hkTzBybFdE?=
 =?utf-8?B?RGV2b0xlQ2o0KytaV2NQRGZvM3hhalFwNlVSblI5ZlZKazgvc0l4emhZOFIx?=
 =?utf-8?B?czUwd09BYlNhYXljRWh3WGM2THlBbXFFK1VBZXhFV24yU3piUnRkVVlPN04y?=
 =?utf-8?B?a0pLMW9FcXp1L1RIOGFLSXAzVE5rSWs4cjFOaVVlMG03TU5nbmxHMVI2bVNt?=
 =?utf-8?B?TE1ubUtqL05YTityUlZGTkhuWGVtd2c3eVQ5a2hxaVh0VGdOU2V0Z2RFN2hs?=
 =?utf-8?B?eXBoZzZhWmMvYStXZzk2M1UzWnlwZmUvM2lhcmhQcTJTbGwyTGk5bmFhZWwz?=
 =?utf-8?B?YkFYNWF6TS9OT0pyN1l5bTFFeUxFb3RZMHZRTENialh4YVJLbGZLdlhYSTVH?=
 =?utf-8?B?MjJXZVJBNVBUYnN5bzdINmQ0aktOc2dNclFhWFFmakJ1Mm4vQ0RoN216dVRh?=
 =?utf-8?B?Q2VieFhNQTBZS1ZSU2tYaXhDZDMyMm16VTN2OWQrSVRNK1hhRkVEZG5pNEhx?=
 =?utf-8?B?RzY5U3d5VklPVDBKOW10aTN3RWNKVVpsSm05Z3lJN0djcWtkQmNlMjRHRzB6?=
 =?utf-8?B?RjJOUkZIWjN0c1JXbmhJd0VIZ3BET3FTK3QxNGJ6K3BxdVBvSUo0WkhaTUN6?=
 =?utf-8?B?MVdiT2UybW00Y05SNGlJalBORWlNczVpMW41L1FCRzBIelhrWDNTYWxGV3B2?=
 =?utf-8?B?NnBKK3FIYmJWLzgyZmlsZ1hzZTBaZ3hKNGorWGhYMlZ5VzN6Tk53YnVZcWdV?=
 =?utf-8?B?TnpsV0tyQno0WXp0ZnRGTjUra1crckc4UitsWGgzS1Mrd0EyVFd3RmJLWXdG?=
 =?utf-8?B?cTY1Qm0yY2I5RittUFZPYVY3RkJMdXZQc1R1ZnFYQXl6VFdRbUxEQ0E3SkJ5?=
 =?utf-8?B?akFNTkJaaThqcmRwRFI3TlNGenhERy8rdVU5UFRhNjd0eERwb1BuN0VCdGZ2?=
 =?utf-8?B?L0JMRG5xQWYrQVRKOVJtZVRLbGJHb1VaNjVhK24zdHRKYS9lcHJTVjMxaWhi?=
 =?utf-8?B?N2xSY2lCTDkyRDJFWUhlMExrRURheWxFcFZYbG9icC90bXQ3bzArL0pqbmdB?=
 =?utf-8?B?THdBRXhsdGJrVkFOcCswUmd0Q3dsU3BKbnFWZ3Y2WFlzYmw5L2hGUlYycDZT?=
 =?utf-8?B?M0FZeDF4cExVZDFZKzhRVTdPT1FlTEtpd3pwNGVHMjBpSEF5b1A1cWN2RCtL?=
 =?utf-8?B?bjYvb2NHMG1rcVFoRXowUHVrcDAybXBwT3RHRXgwNTljcE1GU0xUejMydlNZ?=
 =?utf-8?B?Y1Vpa2gzSFI5cXZBSU1lSnpPWElTNlQxZTA0eTVUOGJsM2NjSmhOaTVhQ0JO?=
 =?utf-8?B?aGtiSEtDVVNyVWpNSGEybkN5RU9Ubnp2TGZWWUN0ME51aVlabWZTYnV5WFBt?=
 =?utf-8?B?c1BGeHFidmR2T2sxTUFsV01VNG96MXNENGwvbHljMFZUdjlzWnY1aWRJTDVj?=
 =?utf-8?B?WjJHR0RDQVQva2pBQ3h0S1lmUW9DWGpaVVpSNXRUeGRFL2xqMjFNOHN0VDAw?=
 =?utf-8?B?dTNYMlpmZldXUlBrbGRUeXZlVVg5dXEwbUFRQkcwL0ZwMDF6dGlvazNGcW44?=
 =?utf-8?Q?uybVnFRtKllk60JaFac50WV09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95466c87-0def-442d-bf9a-08dc6b8b6d08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:09:35.6982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2rM/hXzRIo/IIF9y2HoGzan0oCL8Y+0ehmSkAYkAUDqvPgyvo7m2dfwTa9nYU48qUiEu6WmNJV7a1+fm1bYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857
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


On 5/3/2024 9:18 PM, Khatri, Sunil wrote:
>
> On 5/3/2024 8:52 PM, Alex Deucher wrote:
>> On Fri, May 3, 2024 at 4:45 AM Sunil Khatri <sunil.khatri@amd.com> 
>> wrote:
>>> add compute registers in set of registers to dump
>>> during ip dump for gfx10.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42 
>>> +++++++++++++++++++++++++-
>>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 953df202953a..00c7a842ea3b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -378,7 +378,47 @@ static const struct amdgpu_hwip_reg_entry 
>>> gc_reg_list_10_1[] = {
>>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>>> +       /* compute registers */
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
>> The registers in patches 3 and 4 are multi-instance, so we should
>> ideally print every instance of them rather than just one.  Use
>> nv_grbm_select() to select the pipes and queues.  Make sure to protect
>> access using the adev->srbm_mutex mutex.
>>
>> E.g., for the compute registers (patch 3):
>>      mutex_lock(&adev->srbm_mutex);
>>          for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>>                  for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>>                         for (k = 0; k < 
>> adev->gfx.mec.num_queue_per_pipe; k++) {
>>                   drm_printf("mec %d, pipe %d, queue %d\n", i, j, k);
>>                  nv_grbm_select(adev, i, j, k, 0);
>>                         for (reg = 0; reg < ARRAY_SIZE(compute_regs); 
>> reg++)
>>                         drm_printf(...RREG(compute_regs[reg]));
>>                      }
>>                  }
>>      }
>>      nv_grbm_select(adev, 0, 0, 0, 0);
>>      mutex_unlock(&adev->srbm_mutex);
>>
>> For gfx registers (patch 4):
>>
>>      mutex_lock(&adev->srbm_mutex);
>>          for (i = 0; i < adev->gfx.me.num_me; ++i) {
>>                  for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
>>                      for (k = 0; k < adev->gfx.me.num_queue_per_pipe; 
>> k++) {
>>                                drm_printf("me %d, pipe %d, queue 
>> %d\n", i, j, k);
>>                                  nv_grbm_select(adev, i, j, k, 0);
>>                         for (reg = 0; reg < ARRAY_SIZE(gfx_regs); reg++)
>>                         drm_printf(...RREG(gfx_regs[reg]));
I see one problem here, we dump the registers in memory allocated first 
and read before and store and then dump later when user read the 
devcoredump file. Here we do not know how many registers are there 
considering multiple me and then pipe per me and queue per pipe.

Should we run this loop in advance to count no of elements while 
allocating memory or (count = gfx.me.num_me * 
adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_queue_per_pipe. No 
matter what we do we need to save these registers in advance.

Also another problem in printing drm_printf("me %d, pipe %d, queue 
%d\n", i, j, k); Need to think how we can do that ...

>>              }
>>                  }
>>          }
>>      nv_grbm_select(adev, 0, 0, 0, 0);
>>      mutex_unlock(&adev->srbm_mutex);
>
> Thanks for pointing that out and suggesting the sample code of how it 
> should be. Will take care of this in next patch set.
>
> Regards
>
> Sunil
>
>>
>> Alex
>>
>>>   };
>>>
>>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>> -- 
>>> 2.34.1
>>>
