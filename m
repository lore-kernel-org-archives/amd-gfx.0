Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15362D37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C0410E19F;
	Thu, 17 Oct 2024 13:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XVrJCwP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4167810E19F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrEjseiO+ag4iqE+Eg41y69nqiHiSiWujoBHBe/cnFbPtPtvW9peIttAEyKGvIe2mQlBXuE4zTtcJHy1+Z6fZe+5CUFvKEneZvw1+oNrq2MxKSygEDycdjVhSxN1TxKEKzz7OSt3RuQIVsUzyerZ/Eq4WdjeJIYW47Lpb3lMdJjC2m4XD63lcAE47HHbEZuahGudgEG7t6p8MbAtwzm70032RCT9C/RQ2NxWPTnoqvlXx+31+llFw3WmGtqVu0SGjNRfGsHUbsttOYRL6bUoZb7BgjHdOV/Jp8vmYFSOUSIFaOIa1g913AhNd2B7qozhWXcHeyBECZk+yZ0FfALhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGDKSfsvX4Do31Si+IWlJTpi5eu318VmkxLa8FSGPSk=;
 b=a8OWbECBUFoJVMX4oOKMsoFKNU84iXWSnuoW2YlQrBsVIw8MU3M9YHJAQEqYwHtXgl/Fr3WfF/uEx92nabfD2GnZ7fyCW7t6wen55yA5uba2y9IUI4w2yY275K7ujZ3BpMzTb0i1M5e8D1kMX/y6hlm0NlnZCxDZ3gxOQ7DZJEHUYnBlNHVq0HBOzgcgOV+hgmaZ4HpDwN+icSL3D6+fflV1s1FYQOF142IzNyXSXhC8RQ6EMK5Ujl3wKcZsB1eGiDbVCkBDjsJLsS9J8RLvlzePIFH328llmO6Wm/2DvARZtRM4XxRcot6UxGGVgKPmnwVc8+MFNVdJ8VviMQx5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGDKSfsvX4Do31Si+IWlJTpi5eu318VmkxLa8FSGPSk=;
 b=2XVrJCwPzThVgsj/90KwpIX4dy53PdtkB8yla5wcw2XPpA782Vv6fn7T1bGs8VnMIs3QoVqPbRBZqHh2h6FOYPQV+JAGBMbxXNyisyiHeWlT5bOvBiL0jqcdNZgEeBgUc0evZ1fu5vQOHCa7I8GPhB1nB6L7e2/GPgFIr3gWOZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:15:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 13:15:43 +0000
Content-Type: multipart/alternative;
 boundary="------------ON8xIjR09K1Mcj5A0VCzfEdB"
Message-ID: <29963d81-41d4-4b80-804c-8792a286e892@amd.com>
Date: Thu, 17 Oct 2024 15:15:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/15] drm/amdgpu: validate get_clockgating_state
 before use
To: "Khatri, Sunil" <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-16-sunil.khatri@amd.com>
 <1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com>
 <58fef7b7-79cc-48ae-c632-199c44ed1f0e@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <58fef7b7-79cc-48ae-c632-199c44ed1f0e@amd.com>
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: a96f6a41-580c-42f7-b43f-08dceeadce26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1VPNVA1OGVFRlpvL2Q0NUZ3UkpWSGsvK0ZQQmRHdU1zRStyUzNWeURLZHkx?=
 =?utf-8?B?Y3hvRTk1Y1JnOG81TkZuVXpZNTh1bzZXNHJUeGRUYXhQb1hoR2NWZU0xdWll?=
 =?utf-8?B?cEJTR0pnSm1RU09YQTBWTGlnS3kxRFhISmp4cFNwdmdqYlN6eHNHV2tOTDZu?=
 =?utf-8?B?Nk5pbmFLM0ltYzVKQlF0RzlyOEw3b01mSWdpSWxvZ25KSDUzN3J5MTJxS2pq?=
 =?utf-8?B?OHRhOXdNUWlQY3hkNSttOVpVSjY1SC9HOC9pRFFieGl1QXVmU1FRc1VoYlZw?=
 =?utf-8?B?MkQ0MWR4VlplY05kVjBuc1M5Y2xpRUZkYTErdjQzTlBxcXBnalMraklEa1BC?=
 =?utf-8?B?VDdxMktmMndJSHpoeFBScDFVRDlRSHZrbU9GMDMybWxCY1ppTS9rTlJJUXJQ?=
 =?utf-8?B?S2VOWjlrSXpGc0tsTjdlU051WFRXYms0ejQ4cVhxWDB1MlR0aVBwUG1Hck5l?=
 =?utf-8?B?dDlHdHhLUm1CVmZZYTFKWFFkYUJZZzR0TkRJUi95bHlzVjZqVjdtVHpxcXhP?=
 =?utf-8?B?clkrMG9MM0hxZnB3UmFuWFhPdTljR29QNU5VdURvZmJCVENNQnFWN2NSeHdO?=
 =?utf-8?B?YTZvb1lLazV5a3UrNXFPVzlGWTNMWitBaWVnUmttVGYrWVpyaVlrRUFMaGpO?=
 =?utf-8?B?djUyU2xlS0tTeGFQTnZaZ2todG02L1NyWXV2RlVTMW51N2hnNGtTWHFNTytZ?=
 =?utf-8?B?VXVqSFgyU2xvWnJRdlB0SHFwa3dXSytGZTZxdDVCU1ArOHZnOUhBRVJjT2Zk?=
 =?utf-8?B?T1hCWFRsSC9PektWZTRCRHU2bVdxb1RHUjZKWFBIeUdlbEd1NDFHcDcvbHow?=
 =?utf-8?B?VXV6M1I3aHBadGlWOHJmeXphRzdzWjJGYTZHbTgrRmh3UzEwbUhISVlVcHpD?=
 =?utf-8?B?dzhwZVIvb1EvZllubmpYTnVac29PK1gyTFI2TDlxZDAvM0RGbFE3KzRoL3lW?=
 =?utf-8?B?YytFR0ZLSlphVlFEUVZvdWxETVJSSWlHTTdsT2dYUStCcDRJWnE2d1lBeGEz?=
 =?utf-8?B?Z29QZTFqblczQ2N2d3VYRlFBZXdYazRuMkxvUzR2NVFxUUJRUTRzR3JqbXpI?=
 =?utf-8?B?V2JocWVKL0IrejUyajNpdE5JWG14TzQwbFMxYmd5bU9WakxFMVNiR0kycVc1?=
 =?utf-8?B?Q2h2UnNyTDY2QjZLWVc4KzZuUW15VFpMMXZnYmNTelg4SC81cFF3Z1lwODVE?=
 =?utf-8?B?ZTFqSlEybEJDcUN6MWY5NjVNVzNxZEZKUkVyaGJ0SnV5bzFnSGh3R1hhUXFv?=
 =?utf-8?B?clB5SEY0Q1hRQXU4ZktBNDFnSjI3bU82YnA3WlRSSDZoNjNEWWM3M251UXZn?=
 =?utf-8?B?ancvRDJUSExJVUVjOVllbit5ZXlJU3V4ZFRPS2V4QVc1cmFxUitzZzFZNU1Y?=
 =?utf-8?B?VVkxM1dZaS8yNnVjSGZsa2ZuZzhQTFh3eDEzUitvTHYwNkRXOGlRb2lBcXN1?=
 =?utf-8?B?bjNqZzlnSGJLaWFteGU0QTVwSnh0S0dMRVVqRk1BZGI4WWl2NEUyLzR0c1Bl?=
 =?utf-8?B?enBqaGNxUC9aYjBQekRPREk3WHozcWJyQU9mSnJnZWJxdjhYMTBmOVRpWFlH?=
 =?utf-8?B?MS96bFNWUkduZGNBRldXTUFzVHFFRWg5Z2ZUOW1FenIzaDN4T1Awb0FscFk5?=
 =?utf-8?B?QnN0YzUwaTVVOS9zcStXam5qdGRXTTY0QnFROXdLTFlmK0tWZUVHRWY0V20z?=
 =?utf-8?B?L2hFcnRrTjlPWXdSQlJSWjFCWXpEMzNLUXdUOGg5UituMjBKR3c5ZmpRbTU5?=
 =?utf-8?Q?gJXK4DFJ9iJC0otbJJRp8xUDuFmgxT2ezU0vY3a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBVSS9sZENzQ3RBeHpkSkVXYnArcVBIcTRNaDJQdGVnK2o1VmtzNStFeDg1?=
 =?utf-8?B?RjZNWWJUZ25mbDZnbWR1T0xnK2VxbWhEYWVqWkRmZ0NJaUs2eXNmOXZRdndt?=
 =?utf-8?B?YTZ3UHYyUFRDK2hGR3hmdXlFaDBMb1k5MW0xZjYybkZGT2RZY3JQek54VnFq?=
 =?utf-8?B?UEJTVmNDaG5LMjlyVlBGbStVQXdFRHBKbE45ZE5MT0hIdE8zdnRyRVMzTGZq?=
 =?utf-8?B?QnhyUjMvVTJqUlNoUFZEdDdnT2JmVjZHYUV1NzFxL3hmb0lYeDVLL05qODhY?=
 =?utf-8?B?RTBlc0QwRGt3bkVEUmJ0RXBpNlptSS9IOGdhOU1OVDd0NkhVaVo0MWV6N0dl?=
 =?utf-8?B?ZlBNeC9JWnlkVTZITEJTQmNQNGdxL0t0VFAxQWlFcWJUUzFhV09wVEd0TG1u?=
 =?utf-8?B?aHRudFdDeUhtMmhFbGpXdk5YL3hKbStURU11WlBjczlQUVYwK21jd3YzMTVT?=
 =?utf-8?B?cjAvNDRvOWlNR2VPeWllQkFXam9CdTJOMk5UY0VxVDRUOEk2d1NndGpNcGRF?=
 =?utf-8?B?VjBDS2t3RnVURllyZ1QrLzM3MGpsTFo4aEpKcHRBd2hsTHdGZ1ZQTjdyeU15?=
 =?utf-8?B?dm12azVHQnBTMUVYbE0rSUlLMW9XWmlwRXBlNlRnY2pCTFlVWG5VQXo4TTZZ?=
 =?utf-8?B?TjJrUjh5L29MY0ZZdmNqTW8vZjlBTzFzWmpSVnBaMU05QlgrMDJIWUVBNVBJ?=
 =?utf-8?B?eWhERGtOYldwOGFlckRscUJlVTgrUUxKeElWbVA0OVhnVWZWaEZNdkZma3FU?=
 =?utf-8?B?a3FIa2lLa3o1LzhuQTN2TThFaC82dkJqdXNPYlluM1ZjMldRMTlCdHFNUkNG?=
 =?utf-8?B?NXBYZnYzakdFU0EyMEF4SSt1b0tHdkJCN1ZrVlJzb2hxRjM0NXNxUGYzT2Nr?=
 =?utf-8?B?UnloTWc3OEh0NEpFc1B2ay9TNkE1Qnh2cDdLY2h4aHgxbVEvaFFZRmZVMHdM?=
 =?utf-8?B?cmVBNzA3KzEwcEFoeE03NVFrODVtenZvNGRqWXFvVlhVMks2cE5lU3l5UHpP?=
 =?utf-8?B?Yjd5dmUwK3VWUWtNaHVxdlBPRjZpV1FXUUdPT1NmT2srN3hoaElFNmtOZENZ?=
 =?utf-8?B?dm5XUVc2QU91TWRBYVlTQWdQamZxZ1Y4N2p1Z3M4SFhJMFQrVzExMDN4bEE2?=
 =?utf-8?B?VlIzOXo4Ym1mUWNIVjJFVWNRSFl4bGtBSC8rT2xUME15dGZ5VVZiTFJqU3pM?=
 =?utf-8?B?SzBhOHdGZ1VERDRrazNOWFRwK1VDbDVnc1VHSXRNTlhFU04wVGh6WnpqbVpn?=
 =?utf-8?B?TUF5ajNzbklaSEE5eHZQVUJXQmVaTFhBRXlQMGpkUFAvaHozVGFnYms2djhn?=
 =?utf-8?B?TERxRmx3aXl3bDFnZ1hQZlBPN3VGSW1Zb09IZ01qRjl0YjZibnZvWDF5WklE?=
 =?utf-8?B?bFVENTQrblUza01EU1JsZVBYZWdvZmVUd0NqMUlIMnRKazF6NlhqeDdiVUpF?=
 =?utf-8?B?UWM0T0o5UjhrMko3NXhLTkZVMFRLczJtblQ1MnFyY2xXVWRzWnc3UUpabDNN?=
 =?utf-8?B?R2xJYjNyMGpOdWc2Tjg1NEp2c05UT1NlMXlKa0tJd1RpR3ZoRDByM1E0dkJB?=
 =?utf-8?B?YzhlNGxVTHdmT0QveStUaFE0Mktja0VtRk9XRmthY2x6MzBCY2hFVGJZeXBh?=
 =?utf-8?B?aHBzNHNadGFxdWxReXdhcmpRN2lVV3pITDNvY1hlMFhEMlZZZ2t2ZDNzNUZv?=
 =?utf-8?B?b2ZXdTRNdG5QWUxSU1lGaUxpZFFwR3IvM0lMVmtob1pzZ0tKTVFVUUZObGxH?=
 =?utf-8?B?T24rYzgrNG9EbzJYd2ZsMG9wdzF5L2tUYVhkUVVPRU1QQlRMN1ZvRzc1UUVP?=
 =?utf-8?B?UTJuZ3RkS3FSRG45d2w1bFZ4ZzhPR1RocmI0cGFzMUtHUTR3MTlSUFc0MUJi?=
 =?utf-8?B?UDkrRERWZk5reitoZDEwVmkwcWpQdlgwalA0NWlwZ0JtTEU0ZkxkVUhGQlhv?=
 =?utf-8?B?a0RZMER4Q2FvZnI4bHl2MlpuaUlLR0VoSmJoZ0dyS1B5TlRtTDhVSDNtNmR1?=
 =?utf-8?B?YmxCeVNxa01UQUlvcjRIL2g3UnZwb0M4QVZLL01VZnUrTyt6MzRtQU11Q0dz?=
 =?utf-8?B?UFFZdnBJcnl2aFZGK3JVeUdDMkdKUHpzZGg0OElOZHhFSWZBbVM2U3NHQzZV?=
 =?utf-8?Q?vuGI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96f6a41-580c-42f7-b43f-08dceeadce26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:15:43.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hsKp76acnmrpkOsOK/JnSJREa2Eqt9A1gz19U+7nR4Qe+Nw9bBOnnooUssN8n/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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

--------------ON8xIjR09K1Mcj5A0VCzfEdB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.10.24 um 14:55 schrieb Khatri, Sunil:
>
> On 10/17/2024 5:50 PM, Christian König wrote:
>
>> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>>> Validate the function pointer for get_clockgating_state
>>> before making a function call.
>>
>> Oh, I'm not sure if that is necessary or not. The NBIO, HDP and SMUIO 
>> functions are not IP specific.
>>
> For many socs this check is added and only missing in the 
> files/functions mentioned below. SOC where these functions are called 
> are nv_common, soc15_common, soc21_common, soc24_common
> eg: SOC15 already have these changes and its safe to add for other 
> socs that i mentioned above.

You mean that the checks are in almost all places, but here they are 
missing? Mhm, that's strange.

Let me investigate that further,
Christian.

> soc15_common_get_clockgating_state Regards Sunil
>> Christian.
>>
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/nv.c    | 9 ++++++---
>>>   drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
>>>   drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++--
>>>   3 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> index 6b72169be8f8..40c720b32c59 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -1084,11 +1084,14 @@ static void 
>>> nv_common_get_clockgating_state(void *handle, u64 *flags)
>>>       if (amdgpu_sriov_vf(adev))
>>>           *flags = 0;
>>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>>   -    adev->smuio.funcs->get_clock_gating_state(adev, flags);
>>> +    if (adev->smuio.funcs && 
>>> adev->smuio.funcs->get_clock_gating_state)
>>> +        adev->smuio.funcs->get_clock_gating_state(adev, flags);
>>>   }
>>>     static const struct amd_ip_funcs nv_common_ip_funcs = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c 
>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> index 1c07ebdc0d1f..196286be35b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> @@ -975,9 +975,11 @@ static void 
>>> soc21_common_get_clockgating_state(void *handle, u64 *flags)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>>   }
>>>     static const struct amd_ip_funcs soc21_common_ip_funcs = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c 
>>> b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> index 3af10ef4b793..f4278a0fa8f7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
>>> @@ -564,9 +564,11 @@ static void 
>>> soc24_common_get_clockgating_state(void *handle, u64 *flags)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   -    adev->nbio.funcs->get_clockgating_state(adev, flags);
>>> +    if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
>>> +        adev->nbio.funcs->get_clockgating_state(adev, flags);
>>>   -    adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>> +    if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>>> +        adev->hdp.funcs->get_clock_gating_state(adev, flags);
>>>         return;
>>>   }
>>

--------------ON8xIjR09K1Mcj5A0VCzfEdB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 17.10.24 um 14:55 schrieb Khatri, Sunil:<br>
    <blockquote type="cite" cite="mid:58fef7b7-79cc-48ae-c632-199c44ed1f0e@amd.com">
      
      <p>On 10/17/2024 5:50 PM, Christian König wrote: </p>
      <blockquote type="cite" cite="mid:1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com">Am
        17.10.24 um 12:06 schrieb Sunil Khatri: <br>
        <blockquote type="cite">Validate the function pointer for
          get_clockgating_state <br>
          before making a function call. <br>
        </blockquote>
        <br>
        Oh, I'm not sure if that is necessary or not. The NBIO, HDP and
        SMUIO functions are not IP specific. <br>
        <br>
      </blockquote>
      For many socs this check is added and only missing in the
      files/functions mentioned below. SOC where these functions are
      called are nv_common, soc15_common, soc21_common, soc24_common<br>
      eg: SOC15 already have these changes and its safe to add for other
      socs that i mentioned above.<br>
    </blockquote>
    <br>
    You mean that the checks are in almost all places, but here they are
    missing? Mhm, that's strange.<br>
    <br>
    Let me investigate that further,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:58fef7b7-79cc-48ae-c632-199c44ed1f0e@amd.com">
      <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #dcdcaa;">soc15_common_get_clockgating_state

Regards
Sunil 
</span></div></div>
      <blockquote type="cite" cite="mid:1f534179-6ffe-446c-ba20-6b5ab4da8db3@gmail.com">Christian.
        <br>
        <br>
        <blockquote type="cite"> <br>
          Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com" moz-do-not-send="true">&lt;sunil.khatri@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp; | 9 ++++++--- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++-- <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++-- <br>
          &nbsp; 3 files changed, 14 insertions(+), 7 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
          b/drivers/gpu/drm/amd/amdgpu/nv.c <br>
          index 6b72169be8f8..40c720b32c59 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/nv.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/nv.c <br>
          @@ -1084,11 +1084,14 @@ static void
          nv_common_get_clockgating_state(void *handle, u64 *flags) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *flags = 0; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
          adev-&gt;nbio.funcs-&gt;get_clockgating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
          adev-&gt;hdp.funcs-&gt;get_clock_gating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;smuio.funcs &amp;&amp;
          adev-&gt;smuio.funcs-&gt;get_clock_gating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;smuio.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          &nbsp; } <br>
          &nbsp; &nbsp; static const struct amd_ip_funcs nv_common_ip_funcs = { <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
          b/drivers/gpu/drm/amd/amdgpu/soc21.c <br>
          index 1c07ebdc0d1f..196286be35b4 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/soc21.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c <br>
          @@ -975,9 +975,11 @@ static void
          soc21_common_get_clockgating_state(void *handle, u64 *flags) <br>
          &nbsp; { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
          *)handle; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
          adev-&gt;nbio.funcs-&gt;get_clockgating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
          adev-&gt;hdp.funcs-&gt;get_clock_gating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          &nbsp; } <br>
          &nbsp; &nbsp; static const struct amd_ip_funcs soc21_common_ip_funcs = {
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c
          b/drivers/gpu/drm/amd/amdgpu/soc24.c <br>
          index 3af10ef4b793..f4278a0fa8f7 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/soc24.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c <br>
          @@ -564,9 +564,11 @@ static void
          soc24_common_get_clockgating_state(void *handle, u64 *flags) <br>
          &nbsp; { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = (struct amdgpu_device
          *)handle; <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;nbio.funcs &amp;&amp;
          adev-&gt;nbio.funcs-&gt;get_clockgating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;get_clockgating_state(adev,
          flags); <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          +&nbsp;&nbsp;&nbsp; if (adev-&gt;hdp.funcs &amp;&amp;
          adev-&gt;hdp.funcs-&gt;get_clock_gating_state) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get_clock_gating_state(adev,
          flags); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return; <br>
          &nbsp; } <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------ON8xIjR09K1Mcj5A0VCzfEdB--
