Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85239E7719A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2025 03:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E5810E55D;
	Sat, 11 Jan 2025 03:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="admTtf/y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E814910E555
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 03:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE9BWEx22iKgGWPtuhuWh22xs6ulyx+0bZl4hxTTHt3eausmq0EBULsVgAkf6Z+p4IkmiSdHpnXUo59cadq7eIqV+n7YyZOm0BarqcJAgk8rb7bS2zDDlVTXrpKhhFHsykl6HPMmc43usR56+1dXxonx9f+qlNwWIrlQFSj5Ud93X5/3MYPjbHzbOQjaUQHNVN+988LXntcU82FWzWv4un2YGpJTRteqH5QxzPgFRbWWIHpBAYQ2fpsk2VEl8JYEcPntEn6WHV9qJ58Viin5lHwgSFFyZWv3uvDCh9GhPcr7odRN1gng+fH8CE35ysygA02GnVC1qi7QLcARbVLqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d/PEd9vx21R6wSJU5Az5FUBxqG91bm45+2BYiLy//k=;
 b=fwtsnhq4g8ta2I6Z94mQU9D/nKTwGkGuu6gpfediFiBuDloVyA7ejDyodiQOJ/93DTA87iY/qZwtNQwgjHpgUtiCkHCVkihZreai/IAL8sWcINk0hUUqdTOtVTLRXs0UX8mOt9HIwNv9qP1kf/vCFRC+XoZMd88A13TQL2J7IPAbXt80+v9OnRVA3xZTkKq2QEJ1Z8y2qijiz1L0v7KliOx8ogIXGcemUXRUYI6vj90cHdnEIWcIaRZAxGvuBftNV4hyrLkdmT8k92IlkQYOS+FlqjddIvW4/ErHP5nksuqKW2f5sBPoU25GQ41d535PKuBnF7s3PfPYpUJxhSdDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d/PEd9vx21R6wSJU5Az5FUBxqG91bm45+2BYiLy//k=;
 b=admTtf/y7OmOHGKzYS1FWL3+bmOfGJSde0y7lhkKQtOLatPAQymj6OfdrAL7zIAfyd9vAri4m4nncAs/auC1yM3xyH7W0CPEJo0hHouZQDAztPGjsFtAG4Oa7lmNfI+kVJsLY+f3pzYN94J38RXJOIHANSGI52AIsHYz4eg5y8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 03:36:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Sat, 11 Jan 2025
 03:36:58 +0000
Message-ID: <fe31a1d4-d137-4d0e-8a63-321a5c365512@amd.com>
Date: Sat, 11 Jan 2025 09:06:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20250108200121.2808908-1-jonathan.kim@amd.com>
 <0ab5d4aa-ac2c-4108-99e5-902f73f827bb@amd.com>
 <CY8PR12MB7435645F2AB787B7BC57BB0A85132@CY8PR12MB7435.namprd12.prod.outlook.com>
 <f7a71dc8-7643-431e-8c92-ade74619ef2c@amd.com>
 <CY8PR12MB743599F7DD753244994863C6851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <9600acc2-b6fc-4c22-a9d6-061250cf75e0@amd.com>
 <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB74358329999D20A4899DA18D851C2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2126879a-f8f8-4af8-e042-08dd31f133a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUtLZ2xQbXhINWtpZDVTRDlzOWtZZFJqSmJ2Y25ZMnNpYitTL2IzWXF4Uk81?=
 =?utf-8?B?VWdveUxBUVR5bTVhbWtZMTNaUlR2RVNwdHdxOHFXcVUrUjNpRWQrWWhoR2Mr?=
 =?utf-8?B?elNVUGZKU1dXNjI3OTBOdlBZMzR5N09FRzJqZkZMT2haWmlieEFnQUw2djNy?=
 =?utf-8?B?TlVMeHU5UXIrUlVkNlQ3TjlUMGFoWHR6bk1UOTkzNlpZcTZ1M0QyY0ZmRmdJ?=
 =?utf-8?B?N1pzbDBWVTU0VmdsZStZWG9WcXVJNkFJNHFQbUZQZTQ4K1g0di81RS8xV0RC?=
 =?utf-8?B?VWpweTJqTEsvZmd5M0dTZ0JYdW5TT0hhUWRLOXdLRjJUeXFibXVkRnh6ZFc4?=
 =?utf-8?B?U3I2SmVwVWgzSnFPUkczelNLcUhVT3NSRi8ya0hFZE5iVTl6ZUl4TEhBVHNw?=
 =?utf-8?B?ZmVsclQ5ZTNUcjNoZEtCcDlLZC9OMWZUbjZJZzBFdGNvTXFTRHI1Z2dIM29y?=
 =?utf-8?B?OGNxS3ZPeUZpRTNwVEZIa0pIOHJDWlF0aWZuRklXQ0JibDdNcVM2TVVlanQw?=
 =?utf-8?B?dEdPRWNKY3JNRDQrbUE1MzZXSSttWWtQOXVINktBeWg2dS9kQlNiUngyZGcv?=
 =?utf-8?B?K0o1S1pFYmFVYVEzYkF3Wit1V0k0RSs5OUl2V0lvU21JSmJ6blNQb0M2eTRM?=
 =?utf-8?B?OGhUMEo4a3JrYnRrdmFxdk9Ja2pMZFFCckthZ0NOcWZNeWlENWRWSTBMV3dr?=
 =?utf-8?B?V1VZSWJzV0p1KzRsMUE5U3hjeklCVjJmZ1lKeG5aM29TSndkdW1PVk1YOFlo?=
 =?utf-8?B?Ykk2SFhtSWFnZlpJT3oyelBFd2dpOEw2d0NuRXp1RXFXckJHSEd0Qjl1OHoz?=
 =?utf-8?B?b0ZKcy9qV3RoRFdQcGYvbmZzQk1iRHR3TzgyQ3kwbkhQdCtxMW5NbGNybkp0?=
 =?utf-8?B?eTVNeElCdlFWSk82eTM0a3dnRm5WMmh0WkNNYlFZVnI1OERqREYvS0VReW1o?=
 =?utf-8?B?Sk5oYVRXNHVnc3hTKzN6cTd2cDcxVjluM2UxVnluek1MKzZmZ3JobEltbEFm?=
 =?utf-8?B?NmMybzZ2VVZzN2Y3SFl1N0oxbGZ2ejArMVcrdDluTmhEcUl5Z2Q2WlNrdGF3?=
 =?utf-8?B?TUhFTUppaXREZHF0bUtjRFZ4QVBvOEovNmpPMWRIdy9QcmlhbHpPRkk0ZlE4?=
 =?utf-8?B?SmdmNnJ5MmNZK3NFTVdyTUVkV3ZNN2sra1UzOS9uV2R3MU9hRTk0UHpOOWNU?=
 =?utf-8?B?aVZSL0pTQ0lINExsdzI0M2t0UFZSdm9LeFpEUkc5NDVGdHpLK1dReDlLNE8x?=
 =?utf-8?B?eXZMZVFsTnpkekROQlFLeGZ2V2wzc1lSVTZLYmIySWpNYkltZmZ6NHE3NFNa?=
 =?utf-8?B?YThrL1VIZVZaN2oraXRkc1lFK0hraTdDRnF5QTQ2SnhWcG9QVkY0Q2V2NGFI?=
 =?utf-8?B?NUFRRFp2SFNTMVlGSUVoWUhNSElXTm04dTdXR0FHSGpiZWpSdVc1KzJ3allG?=
 =?utf-8?B?cFNQVU1CbW1DRFVaazl3bmVLTFdGR1BjUzBhSUZkVFN3S2V5SmxUNnFvVTVi?=
 =?utf-8?B?bllFL0E0U29KU2NYTFJUQ1dqVXA1dlNweHZKekQ4TTFjQzdwbm9BdUxWU3Vl?=
 =?utf-8?B?S3JQWFJnZ3hHMVNqMmwvTVQwZFM1dlZZN3lPaVpvUEx2YldnSHIwK0VNZGNH?=
 =?utf-8?B?MHFmczBzVk5qRVR5ZStzSEV5U2Q2T3poemxVRUI0cmR5YmdMZ2lnRjVUcyt3?=
 =?utf-8?B?bUhPcDQyeVpsVHNKUUIwRm1NbS9OSEhNdGdLNVE1Q1J5Nk1XYkw0dWRWOGE2?=
 =?utf-8?B?SnBEeGh4VC8zY29XL3lrOWVGLzNHMitNWmY3bUo3WlhsRWRsYXZ0aXBTNVFQ?=
 =?utf-8?B?ekFrbGwwN0hNOHZQcjFXcWt5T0JoNy9ZdnpkQkliL0I0WG5UY3h3MmgrUkFp?=
 =?utf-8?Q?VynjJYM69/+Ia?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm53Y0lXVW8zMXVjZEdFdkZUNXN2MjdSNWI3QTIwcy9xbFp4YWdFL1A5Zm9o?=
 =?utf-8?B?SW56WWRTb3c0dUNEUzBleHNQWEdMZlRVS1JHeEtwUVB2MzJ0WGlWS1FMQllu?=
 =?utf-8?B?OUcwTDVWYVI3RlNGY1ZJTGIxQmJVVTVqaXNlVmlTVGU2SWtSV0pUbC8rQ0Nn?=
 =?utf-8?B?THI5Ti9xanJFQXlLaFRQaFhBb3hLSDlsMlFZdU9GcEVpSXBOb1BsUTlZMU1L?=
 =?utf-8?B?TFR4amZUTTFDUUcyelV5b3VZekNCS2phTWtVbGx2ZnJsbnR2Yzh2WXpxL3Vh?=
 =?utf-8?B?L0dkell3aG9CeU96NDVrREJ5YmVmVmdHYXFTYUV0Zy8xdlJTTDRIUDUrY2Jy?=
 =?utf-8?B?VXVadm9iWVV3UC9maVJ6clF4RkRQSm8xRktyS1hWTks4ZS80dGNGZlhaZHVq?=
 =?utf-8?B?YndjUzVlOHpNaUs1YTRISnUxWURmQm5BbDl2MHVSRzB6TGsyaUJyOUs3R0Rh?=
 =?utf-8?B?OGF1MVdPZUZ0TzNISHVwakM0UmdHSnBla1FOZ3lmY1cyL2tRUDQ5MlVCRVYx?=
 =?utf-8?B?OUlJcSt5VjJHdUc3UnZacXZneWx6K3J2VHdRdTlUdGtBV1VoWnkyTUFxM0VS?=
 =?utf-8?B?cmk5azdiUDdWU0NPZEZPSHdiTWhOVkFtN0cyTUhZY2Q5QmFCdjkzN3lvblU1?=
 =?utf-8?B?VG1jU1FsUlBBdWpRWWN1bklVWWw2T1JmSUdXM3JaRXkyekFVWW5xSTlPUVJJ?=
 =?utf-8?B?dmNoUDQ5VFNSbTdGZlp2ZVNXM2l0ZjJWTjF5akttSGtDdlIzZDdYOVowQ2xF?=
 =?utf-8?B?SVpiYUJjSXlVNkdCTFlveHphazgyb0JKMWRCU3hlWnJPTnBnN1pEa3dFZDYv?=
 =?utf-8?B?bU9GSDFrK1hLRXhFNG5Xam85QVZaK1FrUWRRL0g1dnUwV21VVXRXQitDWXR4?=
 =?utf-8?B?VUVUUCtmSXI5U0wwclZENndrTksvSnNteUwxZXJjbks0SlhiMDloUW8wRlBP?=
 =?utf-8?B?eDBIRGc1dFIyb3FqQUo5MERsaFp5d1NybjZVWHkxVEZBdGQvYmpMUEkybXBs?=
 =?utf-8?B?RFdyamUrVDI0c2JHY0E4S0Y5QTNqRWd4eVFDRWx5V1JkMUpqSzVTTldFRFdp?=
 =?utf-8?B?TWE2Z1VCbnZRZG1CYTJvQ2I3MlQrUHN5OTNtd1QrMlZycnRremk0elg1bWVN?=
 =?utf-8?B?WlE3YVNMS0tTQUNma2oyYlpUelJPZkhMbTB0VHY3OFNQbTZzWTNnUmxQZWZB?=
 =?utf-8?B?WCs3MkhHRDRxK2w2OE9zRWRrNEF0MjR0Nm5MWjliMFAyV0NvbjM0L1MzN1Bu?=
 =?utf-8?B?TkxmSGxuU0pHUFhDQmFhbmVjdkpTV3FHK05KdWV0RkZMQnRXVUlrR2pJVTNF?=
 =?utf-8?B?U2ZhNHI5YTNJRGlwb1FmNmorb1hMeFpZNm05K3J5aDlFenQ3SnlzeGtlZVp2?=
 =?utf-8?B?d1l4S3grL25uK0N6WGNHc3Fobk56Rkc0ZjVTSU5kVnlyZXR3ZmwvamZHc2Mw?=
 =?utf-8?B?NUpsSU9ZQ0VhZ1dWSEJiWWJqeTNlVVg5VWhtMUkrek4wVHZST3hPMzdxQXNW?=
 =?utf-8?B?RzBvWGRTRDZGbzZmZVozQ1YyVzBUU1ZhTVhQN2RRYXNVai9wTURIYzdkaEE5?=
 =?utf-8?B?MkE0RXpjOGpZVURyREhMMmRVMGRVSkdPV21SUE01T1NNYXllMGtWeEY4OVY4?=
 =?utf-8?B?VnBBdHhOaDdYcWsrRWZDU0d5MGg0MHNIYVd3Ullsa1RXYVRoMWxiajNVVFhq?=
 =?utf-8?B?U3gxUXAzbkJWN3VpWE8zenhqU20xT2Z3Rm5QWjluWlMrMTN2TFRFTzNzeDRK?=
 =?utf-8?B?NUpnQTgrK3ovaUV0V0plKzVuOWhJNnlSVDBMZVZOMXRkMDBGYUlGUXQ1Ynlr?=
 =?utf-8?B?RUg1VGNsUlBhWm5Hc3RVTXdrMWRnbEI4d3AyQlhYT3BZUlR6Nmp5c3MrRVg0?=
 =?utf-8?B?VHNzbHZZSy8rcXBJejZCY2ZNZXJveUgvVldGaDF4RUxjcDFqcDA1ZHNpdndM?=
 =?utf-8?B?TFJ3TEdqblU3S1c0cDJodVJQOExEb3NYb3FCS1gyckRwQm0wYS85anZFWXJj?=
 =?utf-8?B?QnlBaVZEc1JkbkJwdWx3ZFd1dGtDcWcrSG5mYWZ4MzhaTDhLZDNNTUlrVXdO?=
 =?utf-8?B?VzZuZ1RXamxSVFczbmRMeDBLOTB0bVBONVRoZjhFb0RDK0ZyT3oySm44ekZo?=
 =?utf-8?Q?9wsmwbGpnNNtfHZY0/lkLxGi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2126879a-f8f8-4af8-e042-08dd31f133a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:36:58.2996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBI3u8orXrbEz2x9jZ6qAfJ18r3ge4ZuglYqHXnXc7tWNqrF6fC6PN6K93vvtqc1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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



On 1/11/2025 2:53 AM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 10, 2025 11:29 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>
>>
>>
>> On 1/10/2025 9:43 PM, Kim, Jonathan wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, January 9, 2025 10:39 PM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue reset
>>>>
>>>>
>>>>
>>>> On 1/9/2025 8:27 PM, Kim, Jonathan wrote:
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, January 9, 2025 1:14 AM
>>>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix gpu recovery disable with per queue
>> reset
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/9/2025 1:31 AM, Jonathan Kim wrote:
>>>>>>> Per queue reset should be bypassed when gpu recovery is disabled
>>>>>>> with module parameter.
>>>>>>>
>>>>>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
>>>>>>>  1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>> index cc66ebb7bae1..441568163e20 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
>>>>>>> @@ -1131,6 +1131,9 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
>>>>>> amdgpu_device *adev,
>>>>>>>     uint32_t low, high;
>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>
>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>> +           return 0;
>>>>>>> +
>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>
>>>>>>> @@ -1179,6 +1182,9 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
>>>> amdgpu_device
>>>>>> *adev,
>>>>>>>     uint32_t low, high, pipe_reset_data = 0;
>>>>>>>     uint64_t queue_addr = 0;
>>>>>>>
>>>>>>> +   if (!amdgpu_gpu_recovery)
>>>>>>> +           return 0;
>>>>>>> +
>>>>>>
>>>>>> I think the right place for this check is not inside callback, should be
>>>>>> from the place where the callback gets called.
>>>>>
>>>>> I don't think it really matters.  We're going to have different reset types in the
>> future
>>>> that my come from different callers.
>>>>> It's probably easier to remember to put the bypass where the reset is actually
>>>> happening.
>>>>>
>>>>
>>>> If I want to define something like amdgpu_gpu_recovery=2 (don't do queue
>>>> reset but perform other resets), then it matters.
>>>
>>> I don't get why that matters.
>>> This callback alone, for example, calls 2 types of resets within itself (queue then
>> pipe).
>>> If you wanted partial resets between queue and pipe in this case, you'd have to
>> branch test within the callback itself.
>>> GPU reset bypass checks are invisible to the KFD section of the code as well.
>>>
>>>>
>>>> Since this is a callback, keeping it at the wrapper place may be more
>>>> maintainable rather than keeping the check for gfx10/11/12 etc.
>>>
>>> Maybe not.  MES is preemption checks are not like MEC preemption checks at all.
>>> And we probably don't want to jam other future IP resets into a single caller.
>>> If you look at the kfd2kgd callbacks, most are pretty much copy and paste from one
>> generation to another.
>>> I don't see how putting the test in the callback makes it less maintainable.
>>>
>>
>> My thought process was this could be put in - reset_queues_on_hws_hang
>> and anything similar handles MES based queue resets. What you are saying
>> there won't be anything like reset_queue_by_mes() for MES based resets.
>> Is that correct?
> 
> No the opposite.  But now we'd have to remember to put it in 2 places where there's still no visible test for gpu reset bypass in the same file.
> SDMA resets are also being implemented and will probably have to be called in different places in the KFD as well.
> We can look at consolidating this later as more devices and IPs get done if it makes sense to abstract this stuff.
> My point is, the callback does the reset and returns a reset status.
> Bypassing by fail return seems easier to remember and leverage.

Ok, we have SDMA queue reset called from job timeouts. If it's getting
called from KFD too, will look at consolidating that one.

BTW, if this is returning a fake success, won't it result in a print
like queue reset succeeded which gives the false impression that queue
reset happened? Or, should it return a different error code like
'ECANCELED' since operation is intentionally skipped through module param

Thanks,
Lijo

> That being said, putting the test in hqd_get_pq_addr was probably overkill, but I don't think anyone really cares to use it with gpu recovery off on its own at the moment.
> 
> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>> Jon
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Jon
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>>     kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
>>>>>>>     amdgpu_gfx_rlc_enter_safe_mode(adev, inst);
>>>>>>>
>>>>>
>>>
> 

