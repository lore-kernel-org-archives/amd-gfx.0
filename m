Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C66C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBA910E5F0;
	Tue, 13 May 2025 19:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4zXcZFZ1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35D610E5F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKdWjmvDtAJdcfZudkW5Ykm5q0ayMPVzLhsMzOLWs/Ipcyuzhtb95qgee+yQq53aQiXNayTUfhKuiXYIZfdbaOOVrphjnRh0Eo5+HyWoRlBwKuvCsWzlsMe5gNKMSlxg/RylOBuutx1tQ0qcI17YPtmS21w/+xhOCGHw3x2u5x3KUKcl0Ydq5goiBmBBuSlh0EBaq3UehHmuzLir3aMJ3bVK2APfFSvEVjZJSArBIBch0jvSYFXeu9a73o9Tu3sQCmg6hx3F+Cth7u4tM75sO9Tm8oXlqeJlg/nDU2n3KIBmxLAhlK7tJAsJBSsJjqJxQBUB3NoKtUJxm/2Z90vW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrPNG5sc9e5RSdevWR4Y0xFE0QxXgwZsqiA9V3R1J3w=;
 b=j6ozjXpgDtafMfq8Yv7gFvx8wYs69ewVyqXuPlx6EuWMHayxZ56E5neyiHD/SJSwERBoqtE/MBKLPa84/fZZXreq+uWdjTmOKzyWSi2pl4qfhJAGBTBbwYErr07RdonwwxnBCjSDU7vY2uO+3J4VpDl8vOy4PzufEyWCFQjz09iufRjNlshtSxzfN5+mlrGoIaexhJh+sW91irrJZKsAamZeJMkM3tRE6uoO6uZUVB/JvjBKc7F29H6g9IHBisD7Ce0LMzU2dzasxFI3OXMJTZ7/sQzItMaEsZsNG5gMUgdTGhqYo5pC9/YEwqi08HAwwuUFsl5pW4uShgjq2WaUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrPNG5sc9e5RSdevWR4Y0xFE0QxXgwZsqiA9V3R1J3w=;
 b=4zXcZFZ1j0qBIALF+mZbW11SzhELHO0CyZdIOMg+QCmVjomanuxAER7FW8uwmSh7kwGmR1LYCE9YEp6MT5c7byWOsLabcsNXUySqYHNlO2mz0/A7j+tZJiFfp76r06ninOyWVquUlXp14bNdRBWaqJ64GFAUtZlKSUt7+qmEH9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by BL4PR12MB9722.namprd12.prod.outlook.com (2603:10b6:208:4ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 13 May
 2025 19:01:40 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Tue, 13 May 2025
 19:01:39 +0000
Content-Type: multipart/alternative;
 boundary="------------CZXPZOY9CMf5nFk1Z6Bgey6i"
Message-ID: <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
Date: Tue, 13 May 2025 15:01:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
 <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
X-ClientProxiedBy: YQBPR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::43) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|BL4PR12MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 970364fa-619e-47dc-7297-08dd92509792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODBhSU4wREMvL0M5VngvcE1JSmFFdHM0SDZNbFRjT0RKMDF4MFZYa05KWGxM?=
 =?utf-8?B?WUhVY3V5RUEwN1VnaVhEVjlwb3pWOXVZZEE4V0dIR2UrMWlGMGl1R0xzR1pM?=
 =?utf-8?B?WkNMMk8vbmdZWFlPenZtVkFXSFdkdjUwcjVzandpZG0xeEFtM0x6T0lBYVgv?=
 =?utf-8?B?SGlqNmlZT0xxWit2dlJNd2RQZ2hJKzhGbVRiRXM2c3NxWk9QWXM0Yjk2ZTBG?=
 =?utf-8?B?M0FXVXhzcUlXOU5Yd09SMDVacG5SVHA3U0V4U2cyNU9Zb2d6cGdLZFNlUmIx?=
 =?utf-8?B?RXVXaFBzQ212YVY5UUpGRDlKQ0d4VWY2SFpMcVh0U1BXWk1NNFd3N0FSY0R6?=
 =?utf-8?B?T2JtbFlKV09yOVA1QjB3ZXlrZjhzR043WkRSaHVvaHF1MlNjNjAyUjlteDlk?=
 =?utf-8?B?SUt1YnNoWG56aDNSdVZBVjBTRWhzK1JPS0lmNVFIOHh0eHp3ZXJjbkV1bTBZ?=
 =?utf-8?B?RmlxWEVkR3Vaa2VVZGhXWG5IbEJ5RnBrb043R3A4bFJyR3RMZy9JRzZtZDNq?=
 =?utf-8?B?c0orcDhheTNlL1dqTHpzSGVoRXAvNnIyaXFZM0E2MDlXQjVoZ05FSSt6MnF2?=
 =?utf-8?B?eHd5eGprbWVZOUVmU2Q2VVhzekVhRUhIQzZMTmpKR0QrYUdleitqS2lUclRn?=
 =?utf-8?B?bFZtUGI1cE1VZlZvT1I2S3o2UkRGSmlUbU9vUU1qdndZbXJxaW9BSmFCb1BU?=
 =?utf-8?B?NUFSd1A3WHRReExFUUw4c1ZPT0Y3QlFJZlgyNHEreWFHUGF6dFBBMEx1MzMy?=
 =?utf-8?B?YTRuZWNESVVrcHBIcnNJcDdjcHNvZFZQRHgwOStNb2NyZUkydWxYTWRPLzEr?=
 =?utf-8?B?MVFCQ1grMTBkWFFRdS8wRTJ4bmJRcmZiVUlDL1ZpdWU4ZmJ5YjlRRmJmM3hk?=
 =?utf-8?B?WkJDYjZVcml3UWZPTXFISnVaR2RxYUFwYjY1aGNFYklqam5WaERPWWtNaUpl?=
 =?utf-8?B?QnVwUGd4dzRvbXFCMncrb29weERhUnV2MlhIRCtYSis5T0VjZG40QVJaMm91?=
 =?utf-8?B?Sk0vMHVUUHl3SzYyYk5SWDh6MWU3VS9RTHVKTmRiM3RSOGlmNVZKb2tjT0Jx?=
 =?utf-8?B?bWFsSHhyVFV2aWZtSlM0SlVpcVlMWXVQZGhFeUtObmNEUjhwNWtJcmw3RXNo?=
 =?utf-8?B?NEo3YjVQMU1hV095ZFJHL09naDhlc2NHd0IwdjJDY21VY1RqN2RJUmlqS292?=
 =?utf-8?B?V3Zob0poeDBUMHJ5ZFdMdWtoTi85WEd0ZHYxb0NGeG1ZOWlrR1dpb1FFTnlI?=
 =?utf-8?B?UGY5eklNWExnaUczNVc0VU9iTlJIWmZpWS81QmlJamFMdkM4TTIxRWhQRVRK?=
 =?utf-8?B?clE1V25zWC9EaFBzcHZUZEZnTFVZSGc1WU9INUZraDhvNDN4R1FHenY0eHQ4?=
 =?utf-8?B?UGFEUzF4a2JPdm85UmdPaVVVaWt3bjFCcmxRNTQwYzQrL09odC8xRndhdkpp?=
 =?utf-8?B?clI5SStRR3JjeGRVdEJ6NHZZWWRwd0ZwVnJUY0oxeklOR0VqOE1TWnlLU1JB?=
 =?utf-8?B?RDYxRGxrTmRRY0xuTld6cTZWWjU2T3JrZFJIMHFZVm50THFNOXpYaDlPWVkr?=
 =?utf-8?B?bm5pMzlqdWFHR3ZwYTEvTHloU3FzdzBjUVpxMi9wdXc1UmZHaDRpb1pYQnJp?=
 =?utf-8?B?dUFINDRxOGFoTU0rSVlFaWt0RmRacjRzRmpRMHI4NTVlcjcyOGl1TmdqdVlB?=
 =?utf-8?B?ejF6VnZKUWkzZUc1WHpqSnR2bUZzNmlRMjlYdEVjSFphK01INXN2eHBhTmll?=
 =?utf-8?B?V2x5R2kzSGdUUURGbExYZUJMQTN1WUt2NHVNK3hmVXMvVzNSaW4rYTExeXJs?=
 =?utf-8?B?aXpLSFJQaHJLcmtnZFBKL2xpcHFjTlNzN1ZiaEdNMWdVWkhtTmNVVXIrQjdw?=
 =?utf-8?B?M0s5ZnFCOFhpUVZvY1djNzBiYkJ5Lzl2VXlXbkZONVBVMnRYaXR5dnluQ2tQ?=
 =?utf-8?Q?t9qRgqfgKbQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmk5NXJMTFRFWFlLelZRelJYbFZvdDQrSUpKSlRvZmRnZ0tkb2lQenplNnlJ?=
 =?utf-8?B?bStPT0tZU2p4ZlpkRWhneGlOWktNUnFYMWNESnFDL2NmZFhKT3F6akh5WGI5?=
 =?utf-8?B?VjJVS2lLczZGaHIzYXBvTFZjSWxnNmJlTzFWY29hQjdGZ0pXRzAvU1N2Njhk?=
 =?utf-8?B?RTdrdmFCQ1ZocXBUN3VxMEdUdmFBamZMSEVCWGx4QUw2Vk13L01GNENQbHp1?=
 =?utf-8?B?Y0J0em4ySktYMk52VWw4c0VidFpOeWtGblB0NEw4RW9HZi9zampUcy9iNmlh?=
 =?utf-8?B?YlBXdHFwampZQ1pBOHBucmJaeWpVM0NwMXk5eUR4ZnliazBuQS9RVS9INldS?=
 =?utf-8?B?NGVxUFl3dG9HaEc4OFVpRTJ0QzIzdHo4VlN2a04xZmd4RXlLUmZtTkxXK0d6?=
 =?utf-8?B?c3k3a2RGSjk3OVNTMGxWblY5SnZhS1BGL0tNTEp1WU9jZUJlVFl0akFjZGpW?=
 =?utf-8?B?eDI0ZXY0cHNrSk9UYXRPZjE4SzJEcnhQTllTY1ZrbnhCMWxmZDlsTjZaWVli?=
 =?utf-8?B?Q1pLQjhXZDZDcnd6U3VJSDljQmc0aW80WXM3OVRmTTM3bzJnM3RuWW9IY0t0?=
 =?utf-8?B?dFVDUU5VcTdEam9Xc1hWSWtrY0t1aSs5Ui9QNFRrQ0NXV01zeUxob29veGxS?=
 =?utf-8?B?Y3d3cjFDcWZhUkE3MklCbHhEUHNEbnEvVXdZYTE0WUU5UTB5YTluYTdMbFln?=
 =?utf-8?B?RXlsVkpqTmZBS2tZamZSSzFqcVhUMnhEUlJ2Z3ozUXd2K05OZUxmS05HMEVJ?=
 =?utf-8?B?d3dQVzd2ZXZrVDFmQVg4bUVsZVdLYUdWVVZtZmFNVWViZ3BJOFdKb3l1dEUx?=
 =?utf-8?B?UUsrdFBPUjRvRDEwUjgwcHNFbkJ0TkFHa3lRODBMOTFKMWkxenU2NGk5dVBD?=
 =?utf-8?B?UUQ2bGR0OThvSkdpSm1RUnNSY20wMUlHVmlWUEtQRHZyOUE5MmRpMnJGMDRz?=
 =?utf-8?B?ZU1pUTlGN1lRZnRqdXFNQ0NoNVVuR2dHdFVZR1BndSt5aWxyQXBnZm1aUnUz?=
 =?utf-8?B?ZTA2QUZJbjdUK1BzaXhwQXFvMXIxSmllMWFXRFl1djhZTlljWGl6SEtRdjc0?=
 =?utf-8?B?YlZlZEtKWHFabUN1ZDZLK1VZV3p3VXdQbXVwTi91aWF1ZHhJWUFKOG10MGRQ?=
 =?utf-8?B?UEdJamVyL01aMk9yV1psU0JkM05xR3ZubTJiVllpZVFSTkI2WkI1aTBaR25k?=
 =?utf-8?B?NmlQRGttUFpRY3hHd2tzbEdGcC9NdThhdGxWTkcwZXoxRWFYRGhic3FHQVpk?=
 =?utf-8?B?d0RyY1VkMVBZRG5FQlBkZzZGWkxkc3dVZzd1ZFJWUXJreXZtcW5YMWx4SXhH?=
 =?utf-8?B?WWl4MFNwWkc1SUtqd2xtRlJnQTVlbENBeHRsT2xxaGtMaWlaWURTTnRkNWNp?=
 =?utf-8?B?RWtKSVM4T002cWoxQ1NyWHBsaUtJaEp2NU9pR0ZITUUvQmZqRjRmc3hIeFRj?=
 =?utf-8?B?ZzRmZ1czZFo1SnJrZFZYQktJSGdLdFgxV3FmakRnalAxMi9aWk1vRXhzTjh0?=
 =?utf-8?B?aDVsR050LzB3bDN3NkRTL3ZOcHpxaFZ3VGxDVEhNNFlIdENUeTFOMDRsa3lT?=
 =?utf-8?B?Mk9RYlo4RysrOURJNm4wSlFqK0Zxd0pIWXd5MVVYYi9XNEpCQjdSWUZYZXF4?=
 =?utf-8?B?bmdqRmJ4YWRhMEF0OENuL2tJSWlVaWdRYUNPZmphcTZiOVNjcElMTGE4UTZ5?=
 =?utf-8?B?OHpyWDFVSCs4bHZLN2VKeExZd3JmU2s0QmVqZWNMZGlScmRsM3hKczV3SDlV?=
 =?utf-8?B?TFBTVUZxRGkzV1lXZWFvZGtWelBHSlUyaXZKUEF2L3BLTVlRTGpjeU9VdDRW?=
 =?utf-8?B?aTlDQjNBVEdNa0orSG02L2F3WHk2L3kvZWRJUmZJSlA2bmluZW01YXNpVmJX?=
 =?utf-8?B?NUJTcE9xYWFjWTExNEU1ODE4bTlHanFJdDd3NkQyUzZYb1JFdWY0OG43d2ZM?=
 =?utf-8?B?ZnRJeW0xcFNaWk1iNUh6R1JKTlp6RWoyM0p0dzZUaUsvS0ptcGJYT2wwdHJF?=
 =?utf-8?B?NDgraUF2UjZqRkFJamtlNGxSSllPdWNrY01xbnBsVHRYbGJVSzQzVzNHQnh4?=
 =?utf-8?B?YkNFRmx1ZWZPbE5aektsUzVabTZvV0VXdE9VbCtMeW56ZFJEUGgxbkFBZTgy?=
 =?utf-8?Q?0bzG9puNg9leurJWsOvOSadTS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970364fa-619e-47dc-7297-08dd92509792
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:01:39.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3raOnof44AUQ58Ant9h6N5N60Ln4IRrmdpqYFdSLCPVIFcI0bk7K8Uok01YjlxIYA86qmp6ashbzYHN5/eqOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9722
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

--------------CZXPZOY9CMf5nFk1Z6Bgey6i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-05-13 14:40, Alex Deucher wrote:
> On Tue, May 13, 2025 at 2:23 PM David (Ming Qiang) Wu<David.Wu3@amd.com>  wrote:
>> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
>>      there are read-back calls already. New comments for better understanding.
>>
>> Similar to the previous changes made for VCN v4.0.5, the addition of
>> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
>> prevent potential race conditions, even though such issues have not
>> been observed yet. This change ensures consistency across different
>> VCN variants and helps avoid similar issues on newer or closely
>> related GPUs. The overhead introduced by this read-back is negligible.
>>
>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>> Reviewed-by: Mario Limonciello<mario.limonciello@amd.com>
> Maybe split this into two patches, one for vcn 4 and one for vcn 5.
> That will make it easier to backport to stable.  What about other
> VCNs?

will split.

This applies to those VCNs where regVCN_RB1_DB_CRTL is used for setting 
doorbell index, which

means VCN 4 and up - all of them are covered (similar code is already 
there for those not in this patch).

David

>
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> index 8fff470bce873..070a2a8cdf6f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>>                          ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                          VCN_RB1_DB_CTRL__EN_MASK);
>>
>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>> +        * it may introduce race conditions */
>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>> +
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> index 27dcc6f37a730..77c27a317e4c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>                  ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>                  VCN_RB1_DB_CTRL__EN_MASK);
>>
>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>> +        * it may introduce race conditions */
>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>> +
>>          return 0;
>>   }
>>
>> --
>> 2.34.1
>>
--------------CZXPZOY9CMf5nFk1Z6Bgey6i
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-05-13 14:40, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, May 13, 2025 at 2:23 PM David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
    there are read-back calls already. New comments for better understanding.

Similar to the previous changes made for VCN v4.0.5, the addition of
register read-back support in VCN v4.0.0 and v5.0.0 is intended to
prevent potential race conditions, even though such issues have not
been observed yet. This change ensures consistency across different
VCN variants and helps avoid similar issues on newer or closely
related GPUs. The overhead introduced by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
Reviewed-by: Mario Limonciello <a class="moz-txt-link-rfc2396E" href="mailto:mario.limonciello@amd.com">&lt;mario.limonciello@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Maybe split this into two patches, one for vcn 4 and one for vcn 5.
That will make it easier to backport to stable.  What about other
VCNs?</pre>
    </blockquote>
    <p>will split.</p>
    <p>This applies to those VCNs where regVCN_RB1_DB_CRTL is used for
      setting doorbell index, which <br>
    </p>
    <p>means VCN 4 and up - all of them are covered (similar code is
      already there for those not in this patch).</p>
    <p>David<br>
    </p>
    <p>
      <style type="text/css">this p, li { white-space: pre-wrap; }</style></p>
    <blockquote type="cite" cite="mid:CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce873..070a2a8cdf6f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
                        ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
                        VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, otherwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 27dcc6f37a730..77c27a317e4c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
                ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
                VCN_RB1_DB_CTRL__EN_MASK);

+       /* Keeping one read-back to ensure all register writes are done, otherwise
+        * it may introduce race conditions */
+       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
        return 0;
 }

--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CZXPZOY9CMf5nFk1Z6Bgey6i--
