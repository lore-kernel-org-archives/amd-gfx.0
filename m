Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B271CC282D0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 09:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A21C10E54C;
	Tue,  4 Mar 2025 09:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ClY5KL2A";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EF910E54C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 09:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE3nLe4at2RlvSozON5dfqpWF0sBwIjqVi+EF9WW7R0wHzPoIDsjo8AstjMTSKqahgY3VBtEqxDvnsKo0fhX0rLY0iDp846yuPPwNiSZdnm+O5SUgXir33QZT99TQY9/sj2oVwe8jirtoOEfZ4IJusv45aRXrw1FwAtvk1xY2eoUqcQyozdvFEa1uhY6W4wn8rRIjrPwWFsNRt3ej8PmgivyJuwO1/U57bgdY4Tr3ahYoeKHcRsEIQLqnIf0fbB5HFWq3kXTh58gEBB4gkRsOm/LgWtKPelzr4k8KyuFbrA3nEKfeozCmF2ObhvupytwoyF4YiZ7qjW04L2BDjJp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkPrLMhF+TwmhXbcH3YWYDPILHQYP5WUSExxRCkSRSE=;
 b=BC2xcot7qwkAyyiE/dB+BKFG0aLV5r+GPYSQhdWvQBbRP8rFbHhZ3XGkcfb5fPtBL0Tkh7/95/DwLREivXlKpPo1lDmjYoV5VblaCL1vfe4F+yICsD6C9AYEjn6L7xRYYoo0/EqzYnWkZl8aR0tskh1p+wuw1UiLu5xeqBUHWshCrX6PlC/A0FgwB5yMwT11ozjirO0a+3mGwBiBxxyig7Y0LKvpDYp7W6yXb5O4FkP4UqiUAJn7CoH+v8RO7Vpw21H8Cl1Ewz0l7pKfTtjKsMkKUv6EcDpnz2lcCvZKBaNL0JWPyj4xjpYkvJBs10G+fdExufiAFgOMNt+gqb9LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkPrLMhF+TwmhXbcH3YWYDPILHQYP5WUSExxRCkSRSE=;
 b=ClY5KL2AE7j8XKebgo/nitETYiuCzAFH4eM/meuc5HNPiutmV3iOhAtDbT4faBOVftJ6jxLBuo14sW2xnaCfBcMbaEoE2907ytIBqsSL4DR93I821wWAdzpPtppV7BO7EzzewHFey2lInKDUHdzAhuHSlxpMm+tLww11SPj0SuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 09:40:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:40:29 +0000
Message-ID: <79ebf38b-924a-4c4c-97cc-a2985d319a27@amd.com>
Date: Tue, 4 Mar 2025 10:40:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: fix the memleak caused by fence not
 released
To: Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com,
 sunil.khatri@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Le Ma <le.ma@amd.com>
References: <20250303144703.5373-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250303144703.5373-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f1721c-54d8-4a12-d819-08dd5b009971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZC9WcUlYOEltczB4blY3ZWtkNDlCb0ZpSiswSHpReXZWUlAzYzdmeXFBWVRs?=
 =?utf-8?B?TjFMWnR4ZGI5WUdhRkxkM1doNUNxQWsycG1HR2JiUnVFY1R1NnNkeFVPaW5T?=
 =?utf-8?B?Smp2djJpU2dCYzA2b0pEdytVY2F6TTZPa0F2ckcyOGxSNGt6RDFHNUJPUTRY?=
 =?utf-8?B?cjhZT2wwbFpBVk01T3V5eTEzSEFIY3IwVUNOUHZpRmFpRUtmQmRzMWVwU2RJ?=
 =?utf-8?B?cDhTRXZQM3ZlOXdFa09kZnVrYyt0U0FlUXg5QmdZWmEra0Q2TnFENWV4QWxU?=
 =?utf-8?B?UEx6S0h5cW1qNkNsMExvVnN1Z1l5UmM1aTFTQ2laOW0xcnVvaCtXS2h2K1Zy?=
 =?utf-8?B?bEdkUHBibDNMTTAzWlhyM2wrMXI2WWFqUmdhU0pJWmZwUWppUTltRFNTeFla?=
 =?utf-8?B?N3M1Zng3TnJmQXFBNXdWbXVqOTBudTc2eHIwVUcxNGlFOXRoYXR4c3AvNlZo?=
 =?utf-8?B?N3ZhTW1PY2RMWVBnVTNmYml5OENydUpwR0JLaVozbERPMS9vT2dNTHJoMmNl?=
 =?utf-8?B?bVk2OGl0U1lEcUkybndqdUxZNS96SzFjaDhQbHloeWs1dTBYZy8yQTY2MmZL?=
 =?utf-8?B?MWVORW9Gdjlwek5JY2VnR1N5NTlZVjI5d2dnZ1lhVys4QXZkZmUxT2loV1VG?=
 =?utf-8?B?QVlWMXBjTXVQaysvZDNFdGRoTlVBN3VNODBuZHAvN1UxVlJUMGpPaEFjVEZU?=
 =?utf-8?B?bElTNjF1Y3FBZ3l2TUxORVBKQlBNVDRRSEtvekFzM1h6SmhlbWVUUkNzR2wy?=
 =?utf-8?B?K25YcTBUdnMrRWRLOXR1R1JpR3JQZ2hCclJQS0c3ZlNjdnRESUMwUi9JTEhv?=
 =?utf-8?B?UUYrbVgwNEZlODI3ZHBIKzgxbFJVL0VtY2IrWldPYkNnMDlLMVlrRk5zdmhE?=
 =?utf-8?B?Yk5xRXZtNXh5NkNuajkvL2RjTDNSUTI2dkxxVGp0eEZSdWNSK3h2K29MV3Vq?=
 =?utf-8?B?Q3hSdUlxK1N6Z0RGdXVEQzIwOFFSVFZNb1hubzlVMVptVTVMandrS21vdytq?=
 =?utf-8?B?bGRwdE5hdWtoaFZBeWxzS0xoOFQva2l6NDYvbDhWS2tjMXV5SmpXQmNsOUdu?=
 =?utf-8?B?UG53K3J3c3VXOEtsVFVFa3RFcVI1dHJnR2oxYVl4bTU5NHU2dTRWc0hIdCtk?=
 =?utf-8?B?aTBXeU9DbVVmS2NhNWRWVTBwMFhiRFB6K2szMW5QWXZpQkhLZUVhZ2NyeVVE?=
 =?utf-8?B?RFVaY3I0dW9sTEZLNXZHeXBJTS9HbmtsK1RmZG40WGMyOXRkNmM0TmIxUWFu?=
 =?utf-8?B?MnUzTzJpcW1vY2ExaURDZlJwOWJ4dTlOa2U3ZXNnd09aRSttSDZ1aUc4Uk4w?=
 =?utf-8?B?ekQ4TzQ1NnBJRzF5ZDVXaUg1cTVDckxlL0Z6OXZJeGg2dTI1WE5TVzZSLyty?=
 =?utf-8?B?SzhDaVBzVlozWS9DNGhqK0Jkd3didGFDS0dnS0djMWpOTnFOQ2xXK2oyMHpR?=
 =?utf-8?B?QS91UFkwcUhBNUU1Slp0cWJlbGZ4eGZzM2s3YUhrWjBzYUc1dW9TNVpmNzQ4?=
 =?utf-8?B?Z2dDKzIzWkxLNFpocHQzdU1XVnVaVlRPUGIvemxEeXdLVHhNVHJBTzByZmt6?=
 =?utf-8?B?eVBQRGdtMUtmZnZtUjg3SWRRZkc5cEcvdzdJSk8rOGY2djAxblYrdXd3Sk92?=
 =?utf-8?B?UTNTRXprREZ5dEJiR3VLSVhhdjdUUzVSU0NqSmhRNCtQcFBXNGEvR0U4RVNi?=
 =?utf-8?B?RFJFbWh3aW51Q2xPbHlUdFJiN0MrZWxKZEFuMnhXMjcrRWxmaDVkeXJKZUR1?=
 =?utf-8?B?OW1qeEtsRFEyQTZ0a1RIUTd0c0E0Lyt1Ymd0VEZyZENFQVJ1UWczMFR6OTZG?=
 =?utf-8?B?QnRGVlNzZTMxcS9aMHlzTjhFbm1NRFFaZTVMRVk2dHY3VC9NLytVTU9kcERw?=
 =?utf-8?Q?6u/a48viojilt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUMyRkR2QVdpNko1bys2YVNKamdiNkVqa0lYcm10ZWdJcU9Sc3B4bGlkbG5l?=
 =?utf-8?B?c2kyVzc1ZTFucXF4SDd0SnZEaDVHR001VlBFZkV3cWxlek9ENjF2MUdqV1ho?=
 =?utf-8?B?TlRYTThuaTZvMzFYQ1dpSHZEUkNwNGIwVy91TkNmQU0zYWY1ak43NlF2Nk83?=
 =?utf-8?B?cXdqSDFXMngvUE1Eb3JJanArV3c0MUdvNHVvcVYyL1lDZk1zRkZlUGhmSFlr?=
 =?utf-8?B?NUJERExBa21jdUFRZW5zOWF4cVo0RkVuLzZheFM5RnZ0T0lkK2hyM1RQbHRB?=
 =?utf-8?B?d2tIb2dnbUszVVpmdlZpRHpoRFhwMEhpTDBWZWE1cG4ySU1lMm90SEozNkRx?=
 =?utf-8?B?SndRbm1JNEJuQ1pVcGwrbjNnTmZxeXRNTXl6aU84QnV4cXVHYXViOTBNZFZs?=
 =?utf-8?B?NTRtN0xmTjhiaHNVZENyYXM2SEVPMTd3eCt5MFQ0ZHplUnU4cmpPZkd6dlND?=
 =?utf-8?B?QUs3RTJ2WC9ZS2NPWnV4UlFtM2wrTWdzUktxYVRqa0hrWHFqODZ1cVFsNHRS?=
 =?utf-8?B?dkRBOXExT0ZXWkhlQUJ6Ykhwa1hXeGwvTVhTRFVRa3NCSkoxVDd5ZnhTZTFU?=
 =?utf-8?B?YXQyTVBDNk5EcGtTRm1MaWQ0bndwWXhVNk1GOTlkQ2RldWdVT0pkMGU4YlZ2?=
 =?utf-8?B?SlRLNk9SWUFCOE1YZFN0bmpsTldUZW5uc3h2Q3phVVR5OXdxYXltVHpZcktl?=
 =?utf-8?B?UThJY1lXWXZwMm9VNkduZlpnaXI2L2hkeFZMZnM1LzNqc00rZDUydW1BV3hI?=
 =?utf-8?B?R3ZtemkvWDlMN3N3KzJaZHBYa2lFSUEvZXdXeWpBbGFZVlJEb2lSOG9OQi8r?=
 =?utf-8?B?dnUvNFVWMHdTOStkSkdaOWRWMlpFUVBpcVdRSzQ0RW5wdzBna1BsengrMjBx?=
 =?utf-8?B?RkZCV3R4ckg5TDJRT3pXSndzbjc2T1d0elAwZ0UwekRBVEFwTnBDVHBVYmRr?=
 =?utf-8?B?ZDRQRTNTTG9hWDB3NzdSRVV4bGRGYU1WZHk5WWxxT2NlSDExaTZBbXpjdnZC?=
 =?utf-8?B?Y0thSk1lWWxWbTZRclpZdHVxd2hnMTQ4azgvWnVYT1Z1c3ZiQVNWbmhGZ1dC?=
 =?utf-8?B?ZFQzd09sRTNwazY5UjByVXl0VWdQYk05Uk1LUnFhNFVocURVa3FzdDZyRk43?=
 =?utf-8?B?eXJUczhBc1V4UUM3MkNZRnM1KytDNVl3b2MrSG8vMVhxNU1Wdk45M2xSZkpw?=
 =?utf-8?B?ZXpBd1gzTzU3SUdPVFkwQVV5TWpnM2pJK2NYRDJBTURreENCckc3cEFZRDFN?=
 =?utf-8?B?emZWQW11SWo0OGNzeUJndi9ydHIvVkwwUGwwU0hIcjU4K2FRSkI4T016b1lo?=
 =?utf-8?B?MW5UUnhGSVVGVGNBbDhqL3pCVnFEZmE4MlRYNDM1Y0hjMHZnWFZBWi9JZGV1?=
 =?utf-8?B?RE4wcm1HUEQ0K0I5b2JFMzZ4WU5vS1dyTnJkOUZXNFA5OFd5SUJMZys1VVlv?=
 =?utf-8?B?bTdmOTJMd2hUanZaVUV6NnNUMUtnQzBKajN0SDVWK3dxRUJEQkxlSHc5VTRT?=
 =?utf-8?B?ekVjZ2RQQktJaFVGZ0tpWDQvc0dXaVJ3Y0dTcFRSWlhlcVdlRDZEYVJ2TmZI?=
 =?utf-8?B?Q2xVUGV5SCtKa1MxM3NzbmdtSEg2OHpLdGlqT2VIZjRRek52aGRWSUZ4VEl2?=
 =?utf-8?B?cTAyWi94R21ZRk9ZUHU5alUycGVJZnlzWVhFSWhzR05RTVpmU1ovNzVmMkxu?=
 =?utf-8?B?Ti91RTN1VWZQZVVrWmZRMzlOSytyUCtFVjh1N3VFa1poOGFRazlERmtYZGR4?=
 =?utf-8?B?ZVRXNzhxZUt3YjhXYU55dkNRMVBqNWlDSndWbVh1TGwxMlVBajY1TldmN1ZR?=
 =?utf-8?B?ZjNSSTlDbXhYVW16dGg2SVZsTG51em9SQ2h2WXRKQ1IvRWdwY0tiYjROYSts?=
 =?utf-8?B?QkRFbUNxUGpWUXlCQkl6dFUyVkgwdGFOYVZVNk81OUx1ME9HQnJXUnladE4y?=
 =?utf-8?B?S3BzbytqU1M1S29ZVTl3Q1NHMlcvTlZjTDQ1eEtsS0pxYlg0VW5NcDBGQTRO?=
 =?utf-8?B?eWhvS0xiRFplWFdyTERMWm56azVxMktKT0p1Q2tDY01WK1dMRTZ1YjQzemxx?=
 =?utf-8?B?WXUyK1VIa25XRktNbURpdnRvRVFSNHVGZHY3NStvZDhxYWlab05wTTZ3UzNJ?=
 =?utf-8?Q?NyUdLTICjaS9KNXKNbea5EbWM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f1721c-54d8-4a12-d819-08dd5b009971
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 09:40:29.0325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuLJMxRa8bnVuYsN3xZDTiwkkIZR3C4TOIzMRfqpFOKcwT14zDSUJ0Q2WFDrjGe3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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

Am 03.03.25 um 15:47 schrieb Arvind Yadav:
> Encountering a taint issue during the unloading of gpu_sched
> due to the fence not being released/put. In this context,
> amdgpu_vm_clear_freed is responsible for creating a job to
> update the page table (PT). It allocates kmem_cache for
> drm_sched_fence and returns the finished fence associated
> with job->base.s_fence. In case of Usermode queue this finished
> fence is added to the timeline sync object through
> amdgpu_gem_update_bo_mapping, which is utilized by user
> space to ensure the completion of the PT update.
>
> [  508.900587] =============================================================================
> [  508.900605] BUG drm_sched_fence (Tainted: G                 N): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
> [  508.900617] -----------------------------------------------------------------------------
>
> [  508.900627] Slab 0xffffe0cc04548780 objects=32 used=2 fp=0xffff8ea81521f000 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
> [  508.900645] CPU: 3 UID: 0 PID: 2337 Comm: rmmod Tainted: G                 N 6.12.0+ #1
> [  508.900651] Tainted: [N]=TEST
> [  508.900653] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
> [  508.900656] Call Trace:
> [  508.900659]  <TASK>
> [  508.900665]  dump_stack_lvl+0x70/0x90
> [  508.900674]  dump_stack+0x14/0x20
> [  508.900678]  slab_err+0xcb/0x110
> [  508.900687]  ? srso_return_thunk+0x5/0x5f
> [  508.900692]  ? try_to_grab_pending+0xd3/0x1d0
> [  508.900697]  ? srso_return_thunk+0x5/0x5f
> [  508.900701]  ? mutex_lock+0x17/0x50
> [  508.900708]  __kmem_cache_shutdown+0x144/0x2d0
> [  508.900713]  ? flush_rcu_work+0x50/0x60
> [  508.900719]  kmem_cache_destroy+0x46/0x1f0
> [  508.900728]  drm_sched_fence_slab_fini+0x19/0x970 [gpu_sched]
> [  508.900736]  __do_sys_delete_module.constprop.0+0x184/0x320
> [  508.900744]  ? srso_return_thunk+0x5/0x5f
> [  508.900747]  ? debug_smp_processor_id+0x1b/0x30
> [  508.900754]  __x64_sys_delete_module+0x16/0x20
> [  508.900758]  x64_sys_call+0xdf/0x20d0
> [  508.900763]  do_syscall_64+0x51/0x120
> [  508.900769]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> v2: call dma_fence_put in amdgpu_gem_va_update_vm
> v3: Addressed review comments from Christian.
>     - calling amdgpu_gem_update_timeline_node before switch.
>     - puting a dma_fence in case of error or !timeline_syncobj.
> v4: Addressed review comments from Christian.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Le Ma <le.ma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 28 ++++++++++++++-----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8b67aae6c2fe..c1d8cee7894b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -931,6 +931,14 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		bo_va = NULL;
>  	}
>  
> +	r = amdgpu_gem_update_timeline_node(filp,
> +					    args->vm_timeline_syncobj_out,
> +					    args->vm_timeline_point,
> +					    &timeline_syncobj,
> +					    &timeline_chain);
> +	if (r)
> +		goto error;
> +
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
> @@ -957,22 +965,18 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		break;
>  	}
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> -
> -		r = amdgpu_gem_update_timeline_node(filp,
> -						    args->vm_timeline_syncobj_out,
> -						    args->vm_timeline_point,
> -						    &timeline_syncobj,
> -						    &timeline_chain);
> -
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>  						args->operation);
>  
> -		if (!r)
> +		if (timeline_syncobj)
>  			amdgpu_gem_update_bo_mapping(filp, bo_va,
> -						     args->operation,
> -						     args->vm_timeline_point,
> -						     fence, timeline_syncobj,
> -						     timeline_chain);
> +					     args->operation,
> +					     args->vm_timeline_point,
> +					     fence, timeline_syncobj,
> +					     timeline_chain);
> +		else
> +			dma_fence_put(fence);
> +
>  	}
>  
>  error:

