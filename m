Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC3D44C48
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 13:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6233010E75F;
	Thu, 15 Jan 2026 13:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wgninGob";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E3A10E75F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 13:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKho2NnPpcue4YawxFNxBTL8qVQGS2V5efeXIqqgxqrBXYr8AY47xKKOaELX3C71J8hby7VKU69pgYCZdVXe6ipHeMb5abyDBfr1bbKbYYg70pjML1/JjYv+G5EEZGaP5NFYxnZEEH2p7/xp2pCnFUedW2Gr4CNYxC8lqp5KEhmoFsJFWMjsN5UQUnwj60rAcdOj++iWL5bmdMRaUw/JahplRuA1xqnq/Gthv9n/zp5dTCvk/d6b5fEPVmPXpBwSHNhTsNP6s2pY39UCWLlzvd8jcsWrj8ec7+nGZHFqcJcY8Al3237E7yv9QvANMqhLTQrPvWT7y10iY4uIgkCm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7huJ3r83XBpmHRdAqVNtEq5dpCxCKG/bZMwQyhQYQk=;
 b=UEg8x850HA6acJUfxyFYSQ5eRz4+uCWCMZlPNvV5gRaVPjdDRh3VomeXp78UGQOWx0yXqb+zPVUKWw5vIGqZ5UjK9dQ74pX9k91P0UVGe1VvUI3gm8ZmpQIJ4cg9jAsEa+1GiEVz9oOlQ16cLKjBfCPku9MSZPgA7y0GahsCrU+TGCP9P7u/u0y71R58t7JZgHCXMOu8zqj7gGDHLO+KjIukcaWs4lcWC1MrQrFFFRZbcltcEjiXhg/JLMWyj8JCE8/9SJc/KbYN4O9SdyNy8XmHz0n/LAqpFyOyhXaxcIRtEIFZWBii95tklL0eRWm+/5uxvPIbEhE7jWNmExYa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7huJ3r83XBpmHRdAqVNtEq5dpCxCKG/bZMwQyhQYQk=;
 b=wgninGobyVOZjm01PihThShxTRQwy04epECZtkPY3bIrdOpOpoV/uJyV/8p65gK7+0W2ponJchMl5iiowv18m6eSumWqD9Mqbxzes3sMwAxUbm6ppN5CJbsk85abxUvGRBP9dAPnLGo8mm4PxjkbKXcAJuVF1tqATJ+k9fCy/LM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 13:49:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:49:45 +0000
Message-ID: <089d57a5-bd02-4310-a095-fe10104b5315@amd.com>
Date: Thu, 15 Jan 2026 14:49:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amdgpu: free hw_vm_fence when fail in
 amdgpu_job_alloc
To: Jiqian Chen <Jiqian.Chen@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>
References: <20260115025313.620844-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260115025313.620844-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 844e3773-f4be-46ab-f1ba-08de543cf0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGdMWU1DeGx3c0FCZHM0VVEzYU5DMnJUeHB4b0c4SW1BMk1aTzM5TDg4UFJh?=
 =?utf-8?B?M3VUTjlqdzVLdzFNQTlCZWlXb3F1aTN0TnJ3NVZtNnppNTRUZnhSTHA5NHhv?=
 =?utf-8?B?c1Z1dkYyUC9rMnZET0p3TlhIeTZtcmR4RUtJL3JrTkdWdFg5SUhwcU5ZRW04?=
 =?utf-8?B?Y1RhT2hmUWpaWkVBQ09mdGRuK1dYWU5UWU5SMGlrcVdoZDY0WkYrQ2VvUTgz?=
 =?utf-8?B?dDJMT291Q29SY3RWdWFBZnk5b21iNlVCcGpvTnAzM2FNVjdjV2x4U2NwdXdk?=
 =?utf-8?B?SG9PMWxIRXRiOG5TRlEycW5sZURsYTF2Z1ZKZHhTTFdUaVg1cVpCRG9TZEJp?=
 =?utf-8?B?Rlh0Y3ZYdHRiK216bHFFTzhYNWl1dGFPSWxQZmxJVHAzZXl4aWgyQVR0bXpa?=
 =?utf-8?B?U09oVUxmbUJyNTZQY0FIWmwvU1MrZjBHMnlnVENWN21qc0gxQVA3YzV1VTNO?=
 =?utf-8?B?MEpjc2FPMjNJRDEwYVIzbjVKaUlGdHlvVWJnbXpzTVh1VGNJME05YkwyVm05?=
 =?utf-8?B?Rzc5UVNmOGNtS1ZGdlVhdE5DZkpmOUZzQk1FU2s2cFc3OVZIOHpXaXpSNDZR?=
 =?utf-8?B?Tmdka3pZeXBVMXB5alpQNHQwQXE1SGsybHRaanAvaHFnbWpXZnlDN1l1dlRm?=
 =?utf-8?B?S0FVOFpHMUdlOTYwYzVoMm5tZ2EyQUc4ZW5KR1dKcExndXRLSDl5cW9iOWFu?=
 =?utf-8?B?S2x5WFM5Q0o5V1NQWXBqUnJJbG96eXlZREpLdU9vYVk3cmYyYStmb2hpY25D?=
 =?utf-8?B?dUY3blM2MVdPSUZDczI0N0pFSFNQUnlEQXRUaGY5Ni9kUFFJcWliaG4yN1ZD?=
 =?utf-8?B?T1VHekJsWHgwUkpYM0FoWUJsak9wMHJkK0s0UEV0OWFyeXRmdVhzLzh5T2ZS?=
 =?utf-8?B?WXd2Q01aTUI1NzhzSFZOVUMraW9MbGJ3emN3SkROZUZzcDdzWDdJRTBYZzNt?=
 =?utf-8?B?Nm54Wk43TnBjbUY4Z1ZGM0lOcmVDd1VxMXpZeGl2U3V5QjFkVm03TzlzdXhj?=
 =?utf-8?B?TmtBUUpBbXkvV2owWW5wMDJQbHgramc2bzgwdXFKSHRzVXVFMWthQ3VJOTJh?=
 =?utf-8?B?NVBoOFh0U0FaNGs2V2ZKT29VRjd4NVJQWkcwWEVqU2grUml3RExFd2dRN0R6?=
 =?utf-8?B?QldGUFlESmFmT3lYQjE3MW1Yd3drdkpQVUN6M3ZTYjhZK1pMdmVtVSt4N1FX?=
 =?utf-8?B?MUswL1RQU1BJdnRDL2NQWVNlOVBOM05TSzBDV0VDNTJ5Q0VQeVQ2KzFzb2Rq?=
 =?utf-8?B?YWZEMmdPM1JxZTVwMHQyaURmQWNjWEY5YjI3SytTeHYzNzdFLzRVUG8yeDVC?=
 =?utf-8?B?N0lFb21DU1VRdzFvK1gyTXU1WS9lWFhVZzNwK0RaeVozT2pkMFFmTnRjMmhi?=
 =?utf-8?B?and0YVNrS0FBcE93Yk53L3NRdENVOFJ5Mk5yWlJuaXU3REtTMkIxTDdiS1Zh?=
 =?utf-8?B?S2JHUHEwSktyMzBMNVRicGxlcnJKeWRONWxXeTJzSmcwaGRYdFpOZnJHdkFl?=
 =?utf-8?B?RlZJVHEzODYwOVF6K2svM0lqTU5RR0FBV0pZQ1BoVDBKSGlWRlhLdUFuTkdM?=
 =?utf-8?B?eURQSlk5MXdZaUs5cmUxZFFXYVJNRlFFeEhNNEVHQlFCTHl5Zkh1b3N0VWl1?=
 =?utf-8?B?SHlaS1pVOExDUytiWkwyY0N0aGZUaGxHWFhaTEpzSHcyTEZidHhkcnZKeUE0?=
 =?utf-8?B?NnpKU3ZlR1JCbTZ3bEMwdWdmWEd4bEFBY2RyMmZzaXdmKzlZZTJyQnowZVpy?=
 =?utf-8?B?SnByaCs2MmdrczIzVHJyN1A2bG9vWkJJaGhDcTRWZTFzWS8xOFUxcS85UUxT?=
 =?utf-8?B?dHhUZzRsNk9ZZHNDd2Q5TW1uZkJkSmlFb3phMGE5ZmkrUmc4bVByU20zZ1hT?=
 =?utf-8?B?R3N3dWZNbS9MaHNPcWFVNk16V2pRcU9SNlBzK215VkhMOUFDNkljdmtyUHFr?=
 =?utf-8?B?RXZpNlhqWldOeS9IT2t0Uy9jUkg0UVZMemJBQUIzUzJyb3NFUHcxbm1jb2Fq?=
 =?utf-8?B?eTFTTFJLbzQvZGxSdVR4V0lqdUZUaENINllrY0lsbUsxdUF1aEZlYnJFZU5v?=
 =?utf-8?B?S1k3ODFRWkNtSjE2OEZBQmJ5aVhDRFg1TWpXNUJWOEZ0KzJlMW1yTVBCNVFv?=
 =?utf-8?Q?KHZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFkQVlQOG5BSFdSVWNBcFdSaEhVaHdXSjBPbytreGpyejJrWmFZeWJyK1hn?=
 =?utf-8?B?akZRMG5yLzZRbGhaQjFyZ0o3aEhVZUR1Y1pzdEtBN2FvOGRLTzlRZ3F6b3VO?=
 =?utf-8?B?WTNBZVJIV1ErVlhHRFcwT2drUXRNRy8rTHFnZDRiekdPNEsvL3NSRXZYaGgv?=
 =?utf-8?B?Tng4ampZZzZrbHNPUm9XbWNWbjVobmptTGRQenFrbXJ1SkNVZU5xOWlVa21F?=
 =?utf-8?B?MVNpY0lydEJxNDVURWZFT1ZVSWt3WHY4UVZWK1ZRK0tDRUFzbVNCeEJWeU40?=
 =?utf-8?B?QzdjMDVwM1JML2lFa1BaMFRzUzNiU1NEZEJnTGdqMlFSRlJLR0VzK0RrQnF2?=
 =?utf-8?B?ZE9vT2ErS2p4cTNpUmhsVUZLY2xKMVJRMVNoako5Tzc2OFNER25EZFI4U1pr?=
 =?utf-8?B?RTliNkF6NTlKOUhRcWdNY2duSGFtT2xpYmlGSjVLUEhnUS94UWRiR21qekZw?=
 =?utf-8?B?c1FrY2xQSVFYcXpFVVJ0b1BDZGlVSTFVTngvMitHY0RHMjd4TE9pVUxKL0J3?=
 =?utf-8?B?Uy90eDhack1YblNqNTBHZHNWeGtCRlc4cVhLemV3YjgzOStJdm8zRVY2Z2dR?=
 =?utf-8?B?WlNPK29KZ0hnelcyY1NydDgzbzlaQlMxSEpNcEZ3cjgzMHp3TGFqNGRiMVpE?=
 =?utf-8?B?ZmVIeWhySk95UDZoaGd6cEhvaHNhMzNidDdlamJINFUrU1FaaE1GaUdoQTA4?=
 =?utf-8?B?SXdMSTV4OXIra0NMS2ZjMVRDZXdwT0NycHpOZTdEbGZ4clN6eGdBaHJybk1q?=
 =?utf-8?B?UGNPRGRzeDFnREhiUFVCanRTVXFpYS9HNitUY1U5UW9CdFA0bGpGUnAwaEYr?=
 =?utf-8?B?TVRPUXdadHNTRjMxZGZ2dlJ2Z3JFb2s2ZE9Ec0pqU2t2SVo1N1M2NnZaMmtW?=
 =?utf-8?B?b1hRSThKQnUzUTVyQVBEbGJISWZONzhKYUQybUtZVDBsckZmc05LSnJyd292?=
 =?utf-8?B?T0tMZU43UCs3azl5bk02b1ZtR1diMk5KMnVydTlUcUVTUU1MbVNnczFqK25s?=
 =?utf-8?B?Tlo4UEZMN2VNMUl4bEtDY2t3VksyUDlmVngvbVRtR2MyWkJBNEdsSHZKV1N0?=
 =?utf-8?B?bzNXakdIRTJzZmF6eFVWZFJBVEhkWnNXajRBWVRIN0hRbGY1Nk5sZFhyK0V1?=
 =?utf-8?B?ei9wT3MwT1FkWVgzb2I0aWVlYTBiS24xcjRDRndvaFQ3Y1B5NkhIUkJqd1N5?=
 =?utf-8?B?Z3NTUlI0NUMxK2tEVE5lZkVJNGJWSlRoQVhCdUpxVE5SNVB3N2pTa2J2MGhY?=
 =?utf-8?B?TkFVNVFadHhUbVFFbk5ValUzZFhLWkNhYlB2WXNKMng5cFBqQzBQbk85cGl6?=
 =?utf-8?B?VHJnS0dsZkR5V2pzR2hpWDdrK1pnSnlFOHhtbHdUdW52NytEbGNWOFZPRk1W?=
 =?utf-8?B?Mzk5em02MTVpYzhXVHpld0J2ZEhKRk1QZVdXMnAxdlFvaHBvT3RrMHByTDFu?=
 =?utf-8?B?RmpIOVpNamh1UWhVQWpyZmZXMExCWkxMd3h4bkRxdTN0WVBOYVN4M3MwdXBV?=
 =?utf-8?B?MmRLU0JUTlBiczR5SXA4RWRNSURxcytUTXRMaWhvdFllL0NoOUt4cDhNempX?=
 =?utf-8?B?WmorUERKNG5PbVVMem5BYjNtUXNCMlFiVldueGhsay9PZnI0bC95YmlVZnVq?=
 =?utf-8?B?Mkx4T283Q3puTmlCUU53QzdJM1ZNb0w4cmRlYlA3NHJvK1BTN2FqRHRWZzRJ?=
 =?utf-8?B?anBWdk9YVWNtTUtvaWVHZ295b3ZLODZRU0JlbHl1anI0YVdtQktWNmZnWGRr?=
 =?utf-8?B?MzZVRllGUFFvN2RCT3pxbzBJbkg0WGVQRjlyQk9oVXlYVGdqWHFCWTBxbWFG?=
 =?utf-8?B?UmlrMlM3SDBYVTZvdGxvN1laRGh5Q1hjY05HdkZOSzBlOFF3ZFl4RG1Yc3Q0?=
 =?utf-8?B?WXdoUjBybzhxVHQrZDNiTTFxbXRSVzBRMFIwalVObC9nd2dycDA4Si9oVitx?=
 =?utf-8?B?c0lCZGo4Y0ZuTkwxV1FpenNDZWZwYU4rZ2Z0cTZ1VndHbTJtaWNKcUtvd1h4?=
 =?utf-8?B?V01XcDRPSTlDVERRT3dDM2IzRzdySWhydmYxVHhGSUgyR0w0M0dPVHQ3Mm5H?=
 =?utf-8?B?cjZxTGtxZFg1aVZodWxHRjdnN28vNzhLM2Q5WFNXU1NqVm9sOWM4NHNiTVNI?=
 =?utf-8?B?blpOSzh0RVlBenMvVlVvZTZXWFZVMFdzeXYyLytSRDRLd1BkY2M5Uk9DeHNU?=
 =?utf-8?B?ODJBdUxFMU1teVNQV3cxZUdCekoyakxxNGw5QVNHSEpibnd2WjJ0d2VrMkZv?=
 =?utf-8?B?SDkxRWU2a3VzaWtSd01FazVVT01wN0hqNjJNTExkSldOb0diUFI5aUV5bC9z?=
 =?utf-8?Q?srtc02qzUu6OqRoQuR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844e3773-f4be-46ab-f1ba-08de543cf0d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:49:45.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP7JR4P7OxWs04IaaTEB0X1ScYoHCN5xao7ljBWvqf+z6//YO5gy+91GhPYONuSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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

On 1/15/26 03:53, Jiqian Chen wrote:
> If drm_sched_job_init fails, hw_vm_fence is not freed currently,
> then cause memory leak.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
> v1->v2 changes:
> * assign the return code of drm_sched_job_init and check that instead.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 7f5d01164897..72e1bfd3fe4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -219,8 +219,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!entity)
>  		return 0;
>  
> -	return drm_sched_job_init(&(*job)->base, entity, 1, owner,
> -				  drm_client_id);
> +	r = drm_sched_job_init(&(*job)->base, entity, 1, owner, drm_client_id);
> +	if (!r) {
> +		return 0;
> +	}

Please drop the extra {}, and use checkpatch.pl. That tool should complain about stuff like that.

Apart from that looks good to me,
Christian.

> +
> +	kfree((*job)->hw_vm_fence);
>  
>  err_fence:
>  	kfree((*job)->hw_fence);

