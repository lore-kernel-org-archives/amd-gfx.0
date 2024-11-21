Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DE1D7877E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 15:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2503C10E281;
	Thu, 21 Nov 2024 15:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GruIvkfq";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C356010E281
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 15:27:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIqPVVCM8BQB/M2LiSc7XC0NIwP3aGzmeRGC93s3/GweahVkJok32c1vYaKnTCDCDnVjq4JhQV7kmwPcVmpEfQAl8wRrpU62xL0Gis55grKin9CfbziPp7ZZU+1wRjD2bxaSFqYEgJ+tQuZsK/aEelG5SfF+wL93sv4fBUNGXxyIkz+tVJuV8HzKqVcllEGkLanyU38gWxCfYp6WQ4JN/xkWCCz3QV54crr/h3ngZ2vwI81to9Yt0EzOmm5BLTY7JtPVeCwnBWphu36JXIAgyOsFN1MWX7BcDptFss0fTsbR8p4Onj4s+wKRrhwnPolqn7Am4iCWQ0MQhMzrZho6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKUivTVo3MNgiEZXigOF8u77OJtlWaiNNUDDdyDRZKc=;
 b=o4N53wZDvzT8UBT7a+8tib4V+W3lb3R1ra+GNf7ggLkzWYPengVXmM4H+iMOpt7WuasPEQNa/PscIBJLW2nL8/JRGK9S2/tVN3rhXwcA3gt6JNOYARHbLNMwzZnYn61/WjhW5+pmPzTfDOjHiMP1fOKVEXeN8B+Jwah620Cgm16xcMs3wBaILp/+Wh/92ujnfVTGhaOicpZ3hd8aYNub8QDFbPqFT4Bg0d9ccB2XJIMFiaEMQLJ7K8armBn1+MwSAVqQvi62VgsM+CouBb90Jvf8MpSp0lhM4L3jDMOg/jWxG3lQlks5miTiWq9BNzUPEr7WrvijuN3Yyj7h4oDNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKUivTVo3MNgiEZXigOF8u77OJtlWaiNNUDDdyDRZKc=;
 b=GruIvkfqm9QvkSJAarNrWXZpkqOF0paeY1fYlwiGd6Q/3y4rD+cXJvXzJ8mtzRr3uzs8sMuBWdsoBxVU/ZI1/WoRcffHo0//USWoRL6wNAdoiiGrg23Ua/6k3QcFWSH5BSx0o3dC2lW/HOrvHg9HRklXYVy53xYWZDesSmE2T6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 15:27:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 15:27:11 +0000
Message-ID: <f2619422-5862-4a80-8c47-7ad2bfd5ee5a@amd.com>
Date: Thu, 21 Nov 2024 16:27:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jonathan.kim@amd.com
References: <20241111193323.278768-1-xiaogang.chen@amd.com>
 <6013a2b2-7e49-49e4-af90-8ea156a9722e@amd.com>
 <d8884052-8b31-4928-adfe-1f5dd5b09cde@amd.com>
 <e34a587c-a215-4212-a452-70afaeb89cb3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e34a587c-a215-4212-a452-70afaeb89cb3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f99a836-f65e-4851-f542-08dd0a40f838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BGYmVERG9KS21Nbmg4SDZENXdTYnM0YWRISVF1ZzlNRGZWTGh0eDQxOFg3?=
 =?utf-8?B?eWpvSndtM1NqeEtRS3ZKN0ovY3BMQnNaVW5NK2NRdVBBM0JBd0psQ2lWd1Vv?=
 =?utf-8?B?VU1KSnBmYUNmRHZvZkNJM0JQUTFKSnpEcENaU3RPaE1qMUM2enNLTVdXN1ZQ?=
 =?utf-8?B?Qk1TcGtLV0M1ZzAyZWVpRWFFUDl1eWlLbEFjeTlmcHdha096UHdENkNXUWZP?=
 =?utf-8?B?ZHJwMlRxUUhLcXNhcGovaUVRcnUxTGdTb254SjgwQk9YRGVCTkFmc0MrY2Nq?=
 =?utf-8?B?VkFEOWhoNDRVcTREdUpiOEUvUCswMWVrTy9mNGY1RU95TkxiZllGNUIxMURH?=
 =?utf-8?B?Z0hQUEhYZmxYdjk4VCs0N0hwd1FVczdMaEdhMVU0cC9hOWVOeFArdVFVVlFN?=
 =?utf-8?B?bEZmcjM2cURyZ2F6bWQyY1VwZTdSa2QwS1g3eGtsMC9IbklUWEVpM0ZZT0JP?=
 =?utf-8?B?eFVTRlNXQ2UxMVY2Tk5KcW02RXRadUJ2c3dKWGc4VFp1RXdhWlg2TEZaaFZy?=
 =?utf-8?B?MlBLSGNPZ3Q1RFdwQ05QVnBFWEp1RnBEcFRBR2ROd0tKa1VyN2hteENPZ0gz?=
 =?utf-8?B?OFNsaG5pYnRFRklkVk1MSHNMUFNySElRbFN5UVVhRHFleWVyam1BeDlqREZY?=
 =?utf-8?B?MFhwMnBBRndsZVQ2SXlRM3FINGowUk10NkRYOTJkcnhWSklPbE1zM2liR2pF?=
 =?utf-8?B?cDdIRjV3SEpBa1RqMXVDa0VLaTY0ellDTkJDMDRBa0ZTc3lkcldTNG92c1pH?=
 =?utf-8?B?S1dPZXV4NGtIeTcxYWMyRE0zemtHMVJvcTVVNmRPTytDQWxLbUlTdHBtSk1X?=
 =?utf-8?B?WHM1ckdaWlRrL052T2txcWJkeUFFRU5hNnYxVDlIZmlEeWJPNStnUi9iTDlB?=
 =?utf-8?B?SEl6Z3h3c2V4d2x1Mk1xdnpTZnBaMTEwc05zYkVyTC9jMDQ5Ky9OSys3aG44?=
 =?utf-8?B?ajVLdHJhdldNN3pZaWlsdWpkUWZEVm1scEpscGM1Y2tDU3VQcytWTUN2TnRC?=
 =?utf-8?B?NlZMVkQyNkJuY3FvS2M5UGRzcGs0cS9wS1ZLS0RsYTY0dEdzUXE5NHZPWEVV?=
 =?utf-8?B?cysxUy82Y1pPdDU3NVhEMG4vSHU1SW9xRnRKNWJESWNMRW0vazhqWlNWN2xY?=
 =?utf-8?B?K0FnNFJUMmNqcWpxTDJjQVViMzBENGZkUFBpMExjbDVVTzNlYUNValRnZldi?=
 =?utf-8?B?YnFCbHNYR0prcm5lM052MnJaSitYUVRBTmpLdFN0MVJEMmxpVXNHeXJBQkZ5?=
 =?utf-8?B?amdrMDdXZlJrbU96d0V4REZoSTNCbTFDTlNKQnVLZStjeFZXdzFXWTRVWExE?=
 =?utf-8?B?ZmVJZXN1OVU1bXJ3dnlnM1NHOFo2L2FwcDZmWlhrR3JOeGF4MFVhYU5ndHlS?=
 =?utf-8?B?VDI3RktZZjNZVndiNzNacnV0aE5XZmtTUHgrYitXeG1vTjlrLzlqRXVKUFlP?=
 =?utf-8?B?QlVyY1M2NjhpQzJTNjlyQkVtWmJWdFpNdkxmcEwwSEZVQy9xWDI5MjBxYTVB?=
 =?utf-8?B?T01waEVvQ0Zoc0llWmJ5NWgrSmFDak5GWHN4V1U1NVlwczZrRGVFMjZXM0xE?=
 =?utf-8?B?cVhaQzFVaEdpZUlBelBZQmVwb2k2NmYrRHBqbWt1aVhXejdISkczaGRhOXlU?=
 =?utf-8?B?NkFpMmNEN1RBeS94NmltNnl2ODh3UjhVbExqNTFIMzVvc2FaZFJ4L2M5YmIr?=
 =?utf-8?B?dzRJemloaGlvcjFqSG9ZZmxYSXZkTk5MTFJTMmRwL0F0R3pLaXVwOTVHbE1u?=
 =?utf-8?Q?qYh/axsFn2L0oZ+1B7Dt+sPCgGBZoS/JQZ+74Zn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGFjem0zLzlnYTViM2tvamkxZXVDRjlkcTRsVkhqd3hoYzJKVFp4Q2dsTENn?=
 =?utf-8?B?ZER1a1R0K2Y5bDNSWGo3Y2g2aWNKSmJIZzNuZXNJcnZYdTNKZE1kL0svdHBB?=
 =?utf-8?B?S3VqbFFrZTA2SHA3cGFxa055dWxEclNxVzRiL0loNTBxWFpCckN3V29mUVU1?=
 =?utf-8?B?WklpdlpQNTZIZ2V2bFMxdFVYNDFORXFWTzB6eDRzQmpCMEJsTTd0dnh5Unhm?=
 =?utf-8?B?TXgrenU4S1RUWnBYeDdqSFppRWZnYzdkUC94cDBIZ28rdkJjRDRyTmFvVE13?=
 =?utf-8?B?ZGFDSm44c1pzRDVScXo1UFo5cytPclROMy9IMVgwZjVVMUFmOW1MTDN2S0RU?=
 =?utf-8?B?cSsyQ1pKQnpJSElRMVlZOTFTSk8zVndXeWlLSjhBNmdFWFBhZTUzeWM3cUZ1?=
 =?utf-8?B?ZVdyYWMrTWhURGNpTDBCaUx1ZHZoVlBDREw4STByNEpZYWRMeWtoZ0NoaHNv?=
 =?utf-8?B?VThkY1Y1SzFFZ2xkUFVRMVZHU1l5UzcrSlJWUUE2Q1ZxdkNkU1RHeE9xNUNU?=
 =?utf-8?B?dFo2ODFuWU1zV0t6VlAreWxXODZWcXdjR0FTTzd5Tm9CdzliNFQwTmkvWlhj?=
 =?utf-8?B?T3JUS2dyd2xyWVFJd2lwakZsaTkvSk5LZk0zMXkzU09YbHdjWmRobUVzYWFZ?=
 =?utf-8?B?dXFueUl2ekZBMlRsR21HL3RwL0VQODRXM0o0QnNHMVd3eWRFdjdNa1A3NGh3?=
 =?utf-8?B?bjQybGlPcC9XL3MyNUNocU1ibHg4VkNLeHVMUTRZQTZ1UXNVOVE0QkFRUFNl?=
 =?utf-8?B?N1B3L1czU3BCT3B6R212R0NpT0hKQXQwRlRXVjljL0doUzEvMGlPNlJ2MFVm?=
 =?utf-8?B?Ymo5QnBkWlh1VWhmSnpiK05lRFV5cC8wNk5mdXJ2c0YvVzJlNmd3Y0ZPaVA5?=
 =?utf-8?B?S21leUxCR0RTVDdacjk5M2MrcTBWejRLazNvZERiUFRGaWF4NXRQdzloSVNl?=
 =?utf-8?B?TC82Vlg4bmpwU3NwRmkxUmRXMmdsYVRDOGJaNnFCOWNBK1JhSEF5SW1QTG5P?=
 =?utf-8?B?L0R4T3JRYUdDaEJwblcrOHZPd2Q1YmpVVHBJQ2hVS25iTkFxbjRRU1VuS3pR?=
 =?utf-8?B?OEMvclc3cWY1YjAxREdza0FBMXlQUDVEZDJBeGNjU0YrZlVKU3dSaXdvdzBh?=
 =?utf-8?B?ZUM4VDZqaUhuWFFlVTdnRW5Yam1yeEVUWFJiQVlNVitoeDRXU3dmQVpvYWdX?=
 =?utf-8?B?eTloenBHU3cyM3pydUVVejd1QTFIS0NqREZ1K1JqQ0d4am85SEFqNVhKVERk?=
 =?utf-8?B?ZExhOWhOL1daUEhaVWZGT3M5cTBmVk5IQTRiMjBhbW92c3cweVhYUS9yZGw2?=
 =?utf-8?B?aU1nVk9wVko5SWhQeUxsakRvbUtwRVlXVGNSR0ZnWHFjM1FqdWlPeElqYnIx?=
 =?utf-8?B?L3g5eHBuYTV4Tkp0ME5SWExKUTlwakc5c2lQVUV2MVY5cVc3VE15TmJ6VjdX?=
 =?utf-8?B?a0N1RkRNWGVVSzBJSDhDQS9MTXQvTWw5SU9tMUtHYkxXMlM2cldnRjc3MGIx?=
 =?utf-8?B?U1o3RzNEd2F6NG9VTDBkbGhzdmhNODlWenUyZTNndnpGN1FRNFY0RGJCVm50?=
 =?utf-8?B?emZmdWhQTU5sc1M3MmQwUGVqNjQzYnhkSXd6bnlaVHFCM25wMWFmTlUwOU9Y?=
 =?utf-8?B?VGVDRGpNRkVreGQ2TURYQjlQYjAxVkN2MXV1UExGTDhwOFZ4SWN5UnhTN2Jo?=
 =?utf-8?B?QmlscWxuTm5YbEs2YXI2dkNSQlMwNVZFN3JvRXgzTk9Lb3B3ZmxaRW9lM1BI?=
 =?utf-8?B?aVptd1lkUERBMmxIMFozVnh6OFNCVjR4ckVVRWpQR2RyRFVYbVRlSzVOMC9q?=
 =?utf-8?B?UWNMamhhN2JoNU1uWWo1OCt2RUtjcDFFU3ZJWVR0N1EzdHcyNVZuM1k1aGtq?=
 =?utf-8?B?NXFvaXYzRzFXSFYvMkFUdjdhK1Irc3RmSUtIVVlWWnVSa0Q3aWRpdXdHWlJN?=
 =?utf-8?B?aXpSTmtUK1NVNGU1NzFORitta21LRk9vTFZ6bTljaGZnTDhucWl1alJjajFs?=
 =?utf-8?B?bnQ0SG8zOTVkYzhUUzRWdmlVOWJRSldGN0dPcWNETmcrbVVZb05zbGlBUVRI?=
 =?utf-8?B?cFBxRExmeVZ5NkdBTXBsTDQxMkh4ZEVNSzN5VTFwZHdMYWt1VFYwVk81REU1?=
 =?utf-8?Q?vNFqEyJGygoyufrXYCYHwpJEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f99a836-f65e-4851-f542-08dd0a40f838
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:27:11.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMq2i4gUmI7N+xKmJkmwxS5ehA+rIqujAi6J+xMlHef6ZvRybi5s/HD0yebhEksx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

Am 21.11.24 um 16:22 schrieb Felix Kuehling:
> On 2024-11-20 22:58, Chen, Xiaogang wrote:
>>>>    @@ -1822,15 +1804,20 @@ struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>>>>    {
>>>>        struct kfd_process *p, *ret_p = NULL;
>>>>        unsigned int temp;
>>>> +    int i;
>>>>          int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>          hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>> -        if (p->pasid == pasid) {
>>>> -            kref_get(&p->ref);
>>>> -            ret_p = p;
>>>> -            break;
>>>> +        for (i = 0; i < p->n_pdds; i++) {
>>>> +            if (p->pdds[i]->pasid == pasid) {
>>>> +                kref_get(&p->ref);
>>>> +                ret_p = p;
>>>> +                break;
>>>> +            }
>>> I think this won't work correctly. The same PASID can be used for different processes on different GPUs because each adev manages its own PASID->amdgpu_vm lookup table. So kfd_lookup_process_by_pasid needs a new parameter that identifies the GPU adev, and you should only compare pasids, if the adev matches.
>> I think it is the main concern here: the pasid used here is global in driver by amdgpu_pasid_alloc(16) at amdgpu_driver_open_kms.  Each time a render node(partition) got opened, a new pasid value is generated. Its lifetime is until render node got closed. A pdd just uses this pasid.  And each adev has its own xarray which saves pasids for this adev.
> I think I had a misunderstanding here. I saw the xarray in adev and assumed that each adev allocated PASIDs independently. But there is also a global amdgpu_pasid_ida that I missed. If the PASID allocation is global in the amdgpu_pasid_ida, then each PASID uniquely identifies a VM your code should be fine.
>
> @Christian, we discussed the number of PASIDs consumed on systems with many GPUs and partitions. If the PASIDs are managed globally, then running out of PASIDs is a concern. Do you think we should change this?

I think we could change it, but I'm not sure if we should.

IIRC there used to be some KFD requirement that PASIDs were global 
unique, but could be that this was dropped together with ATC support.

Regards,
Christian.

>
> Regards,
>    Felix
>
>> Regards
>>
>> Xiaogang

