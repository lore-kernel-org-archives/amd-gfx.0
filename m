Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E46BEE20A2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 13:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA20B10E5FC;
	Fri,  6 Feb 2026 13:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QX+s7+b9";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A4110E5FC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y09pGxycujDUkERIDV1iOaT0X/iTed0eZHb+y67mqsTe7nBmvvqOLzAlQeUGXY8NVFRCSE2nE7bhLoEezKzsB/0pSfTdtvBx8hT4nLbiO7mW29ayTA7eZ24NsD9sxihgaCarZIpo1zXxqWqJTsNpYUcHmP3A/lLYXlXw4Anw0xueMaM0EvKi1l+JEZuTo66GyunV9RFybJLlxjdVKm7zKgF5Z3JDKYYA5h6TNVeSf47ErlsDNv25RtEXl9P6SON84Zm4KKBwsgnyK2LMK2sgbe0bj8mFtPUCMX+4/CTIfl9LxrKYJHfdCMwwHwJSgbzj61QH1FEKV8HPD6g4YV3Fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpA/lmWruzU3tUjbpeSD0hEP3Wng55RovpXo0GS8Bno=;
 b=vRgnn2WUfoTcUksW7/GMi22haIJxCaO9lLDZd238ZHz7is0vo+cqkgTXCRBapQVtlSw/TPnL2IvgRwjbSoHFt9wQ/zg4gwsnwFvpIRF+SVTTK+dUd1jGrH5eh5QdMoO4iMfJXqgdwF+B30Qi48s+tvgqX7TV0+HTr1E7SCgIcMnyXVbcF2EDw2eNOaptM0NYdMSWr0NRapWs1Fg1I5m8XC3y+tLIXs0Cd9YWss3gXhTw2zL7385f4nFNp/KHp9MRNIvQYTGEXY+/VIril4yOrdpE5RCy6kUkx+lDFeTDSNk6s1agBM6uQYXq+9odLThfCAI51VbQHjW3cWKi2SvPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpA/lmWruzU3tUjbpeSD0hEP3Wng55RovpXo0GS8Bno=;
 b=QX+s7+b9jyVH0fB6XmYDtfLjZbyelD47wWkwxyx6I0dlfxATVmXQqdpR0MGb/ysQOa682dFsu0c6u7a95CX+dTcagcq0uJ1jqwhrdN7qbM6SS6mbjRzC7G0qkR3yztCxmt4Lcz926tYio9ZCnBWIR+tdHEzmRxOkkBPP5RYnHZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 13:19:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 13:19:37 +0000
Message-ID: <22379bf8-fcad-4581-a69b-512ed5733512@amd.com>
Date: Fri, 6 Feb 2026 18:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] drm/admgpu: Update metrics_table for SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
 <20260206112449.45381-4-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206112449.45381-4-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 49838352-aa02-4312-eccc-08de65826050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUt5QW9LQW5QeGMvek44c3VFK1d2Q1hEOFdBQy9OU0JQakZhcnN3T0VRcjVs?=
 =?utf-8?B?MUlmTFRJY29wbHVHZXAxblh3MnNuVWJzY05odTZEQU11OVNKVFFDTmZjcitM?=
 =?utf-8?B?S1p1bllxRVQ4WlRmTmxicmk4aEJ1S2VvODhZbmxib2pmWWJGY2YvTzI4UWN4?=
 =?utf-8?B?TkkyOVQ3bXNpRDRZL2tOazNreSswcXhVZCtCVWZFN2FnWGU5WGhjT284dG5Q?=
 =?utf-8?B?aVRQeG9WV0VBMmJDdW8yU0Q3RlphdHRtTVRLbUl6akV5cEZnOWpPTUorVWdJ?=
 =?utf-8?B?MnlNc3JEUDE0Y0dvemNpVm5VTzIxKzZzbUFvRUxiMzRvR3lhNHp2WFZMSTMx?=
 =?utf-8?B?Q2w0U2d5Zmx5Vkd3ZWRkNHNBcEEwSGpEay9MNFpkZ21sd3o1ZmsvTXo1MW56?=
 =?utf-8?B?UytjcmZGYVpjbmxqZlVaYUI2dnU2UzBkZ2NLT3BUZmw5TUZvcDVuUFZBVE5X?=
 =?utf-8?B?Y0tkNkdHMXlMSG9EZHZEZFQxM1F0R01CRlFVcWw2dUg0K3d4VFRhdUYwdjhU?=
 =?utf-8?B?eU51RzllbEE1L0pkWHpCMDJad1IybjJJQzBuckYvYUR5dmZxeXh0em1YbUd2?=
 =?utf-8?B?ZlNhZUkwUEEwcDVyR1dDdENZVzFzZjBQaVhITXlqL3JLU0VBMXJnUXpSVlEz?=
 =?utf-8?B?TEdBeWRaWi9DK2wzaTRuQ0VwZWluQXdzdlpUUmtIWFlnT2NmOGxTU0wxTXh6?=
 =?utf-8?B?SFc2RG1pcVR0bXVKZjE1WW03LzlTd1VJN3NNWnY3b0NDc1Q5LzBTdnc4V3A0?=
 =?utf-8?B?eWZscUJZbTFtYmIyM2ZDNHMveTljdnBvYWhWbFNDd3pUd0Z0dC9QTEV5UzhW?=
 =?utf-8?B?ZTVWS3pjU3dLbmptMExqMTVBMHdwdDFHRGcvV0MxTWVpYm5NblFaUzl2SnAz?=
 =?utf-8?B?MTFUSGtMZUw4R25WYi9OSjFjMnB2K0RVUnlGSEtVSUwybnUvcjlNdThxM0VO?=
 =?utf-8?B?ekR5WmthMXJlYm5LaVYvK0ZlN3NDa3YwaE5lZ3hYdGFMd3VMaGRJN0dnMy9u?=
 =?utf-8?B?Zzc5Z3lPQmRTdDI3WlBNZDMzODZZMHhQZVdsWVRaeTdKcVRsRk9EcStjZHlJ?=
 =?utf-8?B?aSsvQ2hpbHc0Z1VZcnR2NDVyLzB2L0NhSVFKUG9mbmliQWMyemJCcCt1WGFz?=
 =?utf-8?B?eGNpYm1KU0hUUG5UWm1wZnpWby8vSUtrQnFBQjBhYWdUa3pMSWJCNmxiQU1p?=
 =?utf-8?B?TmxjM1ZtMHZVL3h2QXRVdEU3VjRzblhUVmNzS1FaRi90aTFwNDJNbDd2eGt0?=
 =?utf-8?B?Ulk5S2JKV2tueWVBc0RvQyswR29BUUZlbWxYRGZiRmRQWi91VEh0Z1pMbVdH?=
 =?utf-8?B?VXU0R2lRZTdWZWlKY2pDVjZjOVphU2IzZWRhZHQvMXBWUmEwLytMQmhtSVFX?=
 =?utf-8?B?c29HdVJiaVV1RDRUaU85N0NWOWZkNUZEeGVQeHgvTVhjYXhKUjZEaEt0eS9M?=
 =?utf-8?B?NFUvTktWTStISEc4SG55bVhwK21YRm1zZFJZYThDRmd5a1VSbnNkbU9kZ1lp?=
 =?utf-8?B?d1BqUUhFd3V2cUR5bVdsVlhTQzRhL1hqK2E5bWQzQUxkTFk1a2grWWl0cXla?=
 =?utf-8?B?TmxreS83TDRwRXNjWDlXamJiVEQ0WFFhdTNWSHFhQXFBMEJrVDVSQjFzYUdq?=
 =?utf-8?B?ZTEwdDI4eVNGc1lhWDJydkgzVlJPak5PaDI5dUs4cm9JVCtYeGc0K1NENlR1?=
 =?utf-8?B?NWJWbVhtaldFdHhzaHYxMTg3czdGYWNVNTVOdUIwVklLSGlQUm1zdkRRKzV4?=
 =?utf-8?B?MmV3YzFvODdsdW5mdFJMUGFMR0VqR256UDRSNFh0V2c0cVpCUUpaNlc4Z05k?=
 =?utf-8?B?VEZUZ0ZGSCtYeTBsWmtWTWRjL1M5c0tvRGJVdG1uUkg1Q0lrSXdSOThqSlVX?=
 =?utf-8?B?UXVlVWlKRGxhVGZZdVpTTUlRZWM2QlRCMlJnSFRNTjlTYjBzNHpybVh5ZHNs?=
 =?utf-8?B?bzhPYjZ4TDVpNXNvYjJZZHR0TUcxVGtIcklON2tIbWQxNnVrNG1IdHZVTXdq?=
 =?utf-8?B?N0Jma2paaVF1Tk01djdGNmhDSUkreExVa1VHYlpTdERzOStIaFZzUE8yNlA2?=
 =?utf-8?B?Z2pmVlB6dXI3SmNKK2x1bkpYRGsrRHo5Vkk4ZkxNN2d5OUZjNUF6cGlvUUZK?=
 =?utf-8?Q?Vnw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MExySkZselhaSXdrelhkR1pqRzlXZ2xmbzdiTnFXVGxuRkVhR2FBcHNpMlp2?=
 =?utf-8?B?Y0t2c1hKTWpYNnhWVUtVT3B4SFRoRUp6T3V4dGQwWC9xMU0xcElLSFNKb0c5?=
 =?utf-8?B?WHMzOVBWV1RyWjNaYWI0cUYySmUzUjRnZGpHQlk3dUpHaythV2RiTkxPZXdz?=
 =?utf-8?B?Vk9najhVSkIwUVUvL1pDQVVRUnhvV2U0LzdIcWdFV3RjeldxWTdRNVo1d0wz?=
 =?utf-8?B?MkJNOU9BVzU0RUw5eWp3VWhsaERJamdpNWpNVjN0bFhia04rYUpLTzlDaTBO?=
 =?utf-8?B?dXVvVUVpdjNSR0FBOFdibEp2bSs2MGJjcXlrKzJKMkRlRi9uejIwNEUvOXpS?=
 =?utf-8?B?Rzl6cDJWSXZ0UzcyVjdPRmhTdlhweHB3SWVXMzhNbnc2bFNIQ1g5VG9KQk4x?=
 =?utf-8?B?cnVuZmNPRkJMczg5ejkwQ2dyVFA4Y2ZRMEk5Q1pDLzVqanI0cUZzWDltVTdI?=
 =?utf-8?B?QzN0MUlvWGRFYlpmM1JiTmxRL1ZxaFliZjRRVHgxcGZXTENFZmM0OFo2bWNj?=
 =?utf-8?B?ek50b2FGUUNEZDQxU3V3dEJQN0Zmb0RYRGpLZ2dqak9hTWRjVUpQYmpVajVT?=
 =?utf-8?B?TkRVc2ZvTFZ2WTErTkZ1cFF2b3MwVnUzdmtVVlU4Q2ZTeVJ3VCtQZWFLODY5?=
 =?utf-8?B?VnI5emhWcC8yUWZFRFdSUEdrZGdUZ1lwUWRjWHF6Sm9rTmJTVTliMHJqK3VS?=
 =?utf-8?B?Z3pPbjdFakplSmRiMzJKS1hyZEpUbWZWRU1NNE92anVOVFBjOG1SNDJKWXRj?=
 =?utf-8?B?N0Jndk92RmlZeXJaSXdQZWJFWXZJS291SHRqTUNHa01rMHBDRXlQMEFwd0Zw?=
 =?utf-8?B?bDRwWndMTmNCd055eGVMT0lDVWdGTzVmbUNIbjZNa05IWWlhYjYrb3Z4NlpW?=
 =?utf-8?B?Sk0wWlhzWjl6RUpYY3R6SUhiVE1Rd0RSTzdIcGVHbnljMmFaaDVxTElTdjJw?=
 =?utf-8?B?S3RPRG43OUtSQ1c5MVJLNzQzRFFMTEtFalgxNTl6Y2ovRE5rcmZySVlHK1hY?=
 =?utf-8?B?MHpLQjNaaU5HWlZ1cm0vMDVaTStXNVpoWllvY1Q5QlFkakVkUiswekRoYTNM?=
 =?utf-8?B?ZzZkVUNnRjZYZzhmbk5ZVW1DYjNId2NRUDMrZzVWVVYrcG5LQ043bHY0RVor?=
 =?utf-8?B?YnF4dGw0eXlTTWx2RWVaNXQzTzNYWlJRM2JuRHZkbDR3VHkzOVZzb2hSSTRT?=
 =?utf-8?B?YnBKbzNTRWNCTWs0NmhGaWFwelEvT00zcm5NcVkzanNpeVNkMEo2TmNJZVla?=
 =?utf-8?B?Qy9SdzdoYlAralZ3cjRIdXlrVlM3YW5MKy9iOHc5U0pmc2lsekVhMVpUd2FM?=
 =?utf-8?B?WndFQURiSlYxWGJ2SnQxemJOaTJpQjNRM3ovMHd6NE1PbUlVQ0VvaTdPUEVa?=
 =?utf-8?B?Tys1QzhVUlNVWjA0KzFsK0pvUFJqeTdDRUtsM2xLeUw1MGdVNnV3Wjl3Zyto?=
 =?utf-8?B?anhmTkpUWjJKN2FoVTR4cmMzUlAreTlaZHZ5NE4zcy9zVXRVcm5waTd5YURk?=
 =?utf-8?B?NE8ySllXdUJiWmxIT2ExNktMOEZaNTdWOTlyOGpGaUpFdSs5UW5nbXNmWHlJ?=
 =?utf-8?B?WTgrVDdpajdIeG41L2VaZzdVT2o5dUlranhJTGQ4ZVFhUEs0eExCeGlzMmZT?=
 =?utf-8?B?RDFQSUJ0alFrNnJXTUY2UGpONmN6MXFuU0VsN3haakVtc3dITGkzSk82Skwy?=
 =?utf-8?B?U3pNZlgweThEK05lbnU2ekdjdlI5NG5nMzRRS1NYaFpwQkFQdEZuU0svQlpK?=
 =?utf-8?B?RXR4THA5a0VWL1RMQm80d09nM3VJc2tqYW9ta1lGNXNaMDk2UytEaFBVR09n?=
 =?utf-8?B?U0Y5RG1Bc3NqQTlzZGpRdlFNUXZscWVBM3VxQUo4cG45T2Q1ZGwvM25MWFpO?=
 =?utf-8?B?Y2ZTTWRleWRZUzhoYXlkU1FuOUozbWVueVFXRm0yYVhPdTdsbG1nZUtQMDlV?=
 =?utf-8?B?eHFVWnBFUXR5QTFTbkNzdUIyMmNqV2sxK1l0YjNkb052YlBHSzNVQmJFRTNj?=
 =?utf-8?B?cXZqUSsxaW9NYWUyUTZMOWJTUVVpaDlxTlZSN3JBcTl5WVV5cGVoblJTQk1G?=
 =?utf-8?B?akhub3lPL0xycmlacHo4Y09pWkd5cVJYRHpxdmpmYnZMMDFQZzNYWXZHTUJ3?=
 =?utf-8?B?VkhPdFNPOTNKRkhlOVBMSFRLN0MzTHVYYTk4TDk5TiszbTliMFh2ZWJXOUpk?=
 =?utf-8?B?KzkrSTBiZ3oreTlIUjVpazBWQ3l6RGpRVWRadHYrNDA1UlVaVkpXVTNzUGRR?=
 =?utf-8?B?bDJzK3BOUi9jWkpBV1ZyR3JhMmhhUTdNb0lLR0hERW44ZEpPY1Fjc3U4R1px?=
 =?utf-8?B?ZDJ4bEVqYnZkcDZQT2tQSmlqTlFzcnVTNFZJeU5MSGJiRWVBVFdXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49838352-aa02-4312-eccc-08de65826050
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 13:19:37.4240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaFCFU2Rslp1doXlHOuZi40K5Ge9lHTFvPJuvIAGnczT+xe+CdOSK27enVzzYnK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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



On 06-Feb-26 4:54 PM, Pratik Vishwakarma wrote:
> Use multi param based get op for metrics_table
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
>   1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index d58b0bc2bf78..2987ff1b13e4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -246,6 +246,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +							void *metrics_table,
> +							bool bypass_cache)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	uint32_t table_size =
> +			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
> +	int ret = 0;

This init may be dropped.

Thanks,
Lijo

> +
> +	if (bypass_cache ||
> +		!smu_table->metrics_time ||
> +		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
> +		ret = smu_v15_0_0_update_table(smu,
> +						SMU_TABLE_SMU_METRICS,
> +						0,
> +						smu_table->metrics_table,
> +						false);
> +		if (ret) {
> +			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
> +			return ret;
> +		}
> +		smu_table->metrics_time = jiffies;
> +	}
> +
> +	if (metrics_table)
> +		memcpy(metrics_table, smu_table->metrics_table, table_size);
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>   					    MetricsMember_t member,
>   					    uint32_t *value)
> @@ -255,7 +285,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>   	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
>   	int ret = 0;
>   
> -	ret = smu_cmn_get_metrics_table(smu, NULL, false);
> +	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
>   	if (ret)
>   		return ret;
>   
> @@ -530,7 +560,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> -	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
> +	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);
>   	if (ret)
>   		return ret;
>   

