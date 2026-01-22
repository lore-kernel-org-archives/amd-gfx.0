Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C36CD3EE9C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 17:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF4410E0BE;
	Thu, 22 Jan 2026 17:22:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxSIBPdi";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C103B10E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 17:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLgfNzuQ8vqWHjkUO/JPAMvoPSMfKaHFtsNQ35sIf2HDvSTQ4TxbMvzLLS3bAlLYKVtmOXrden9h7HABxSb3+fP7ZREwI9SaKpcc0777DWsZKLaaM5DYjq8d8HrqQgJliOatjXa5FNFj4DMUj1sXfcGuWivxi7pcklgepbtLvikRJwt1CPa7HxlDkLSlDu9zFgGy3xqzKuwB8BtL1oj3WcjLfx4cdbQnIHRrh12Q3NapinrjwZ1g151/iqPi0983KVVapUi4Jdp5cfJUFav01Ee7AqYP+v/BGTneUdV+UM3NmK09JWEPocZHMprKmSefwzSBNvjCFdCD7joc4XFtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXdGJOjHkurn/OHJl2I4juFsxmq93FkHMFH+P5dY6JY=;
 b=UQwl+rwdBHLtnWbWNliZ9iXNqGFgCeqU6wuTBb26VJHvUwbUnsZg1WhhKFR6fyQPHLoqtaKNDxob6GZWdbPNuH8l5e+v6OXGjj/kBfj42uWiO2tABcTUeJ29geko0snFCnCkN6ggEqBj2dqoCAJHUgJ/qtjhr8M/36c7y1u+14bb4Jdv0dnPx74zBdqx25aRPCXr7xCPh/hC+lDyTJ3ZEYuRMRhKQM9MeTPUpOfnp1Xs8XQdxxqd3EGPsVdQN/90ONbgAjlhJu9FEawHTYl4u9ES7Ydx6pTSpvzKgU7YwMCQAacvV71PzOUynEimXGaJxL3M9UMVPxIRcSw7XBjYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXdGJOjHkurn/OHJl2I4juFsxmq93FkHMFH+P5dY6JY=;
 b=lxSIBPdiPA7eZWudId0CBpTj0dZSmBucoxsktKTrYEeqWkCDwZNckfv0aTNimfyRKxvuzTk5tRqAdKHsfVZuPeHhlmuDlBGname9/rwuecJ4+C8DNkLGxSEjY+NrwIFEBnbX38ose+BmkL1A5aRZWHp1uiZlSLfj43hVEWnr798=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 17:22:32 +0000
Received: from PH0PR12MB7094.namprd12.prod.outlook.com
 ([fe80::2cad:74be:a45f:89e6]) by PH0PR12MB7094.namprd12.prod.outlook.com
 ([fe80::2cad:74be:a45f:89e6%7]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 17:22:31 +0000
Message-ID: <df0d27d7-0230-4d61-92b7-3ab9d4ea68dd@amd.com>
Date: Thu, 22 Jan 2026 22:52:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, alexander.deucher@amd.com, kenneth.feng@amd.com
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
 <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
 <CADnq5_MxLO-9xyJr4jELJhiuXVVqAbpy58j0sw=BiMBHHG=a8A@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MxLO-9xyJr4jELJhiuXVVqAbpy58j0sw=BiMBHHG=a8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::11) To PH0PR12MB7094.namprd12.prod.outlook.com
 (2603:10b6:510:21d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7094:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e43925-763f-4edd-4161-08de59dad30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjdQTEszazlZSzBzT2c3SVNoblVFMnZlQWlCa1R4U1JnS0NFR1VOczA5eVl3?=
 =?utf-8?B?Rzc3dlF6cS9kSkgzMU14S0ozTElnMkd3NFNsWlVBZm9nbUJ2YlI2WXdrUzNL?=
 =?utf-8?B?UUJEdWx0L0xUdzh3SVpCZWZKT2EwTUZ5cExaT21CckFCcTBRM1NqcU1iYmdq?=
 =?utf-8?B?MDZGdGdSVmVSa3drZDZha0MrWEkrSkh0cnlqYVp2WHR6Yng1STNxSkZINzc4?=
 =?utf-8?B?Wi9OanlkMGt4YU1LK3RFdHlKL0laWmlHbFV4TGFaMkZNRGxtSnBuUWdrdGE0?=
 =?utf-8?B?akQ5dzlPMmhnVFdxbTVDZGtFQ1VqeE5OcSt1SjVTNXE3dThub2l2eVJXSzkz?=
 =?utf-8?B?UkRHMWVlajM3Z2tXVDZzS3VWSWxOajJRTERaR1NWTmVwU3JuVG1wWEJlNXRG?=
 =?utf-8?B?aTV5SFVjeVBTN3htY3RXNjlHQ1FYRi92bHQvYzg1YTFEMXM3VWsrQ3RoazQ5?=
 =?utf-8?B?NzVCVEF0dWlBeWpkVjdOa215YVFRbkNEbEtTYitUa0tPZU1lRW5IQ1YwNmhI?=
 =?utf-8?B?OXN3MnJxV1hTb1FvY2FMY2toMEllc0p6TU1kS2MyWC83MS9aaTBEZE8wMGw4?=
 =?utf-8?B?eW92TkcwdmRCTG9CWGNGWDBBMGcwOEdsM3JxSXRGUUs2WngwSjFMU2o5QWYr?=
 =?utf-8?B?QWF1V2NqRkVpb3QvUGxlZ0pBUURBTjdyWlRwL1UrZ0xIUDNTVmpYZU01OVo2?=
 =?utf-8?B?TkV5cmIvcEtybWdBMWttN1VPQ3AwM002eUw4NDFpa3JQZG1zbUR6TWxaOVZ0?=
 =?utf-8?B?OG9yamJTWFhUUnVTQit3UTNBVlRIZkZDZWpKbXRNUFpYbVA2djFaQ0NnbTI2?=
 =?utf-8?B?NG56OGd1YWY4NTBIdDNHaHJiMnJ0Q0ZmRWVxSW4vbEJqWkEwekNxbFFVTUJB?=
 =?utf-8?B?Y1VqNk40VE5UUy9PdlVzOTF1TlNhelNmM2tNOVRVKzgxOFBRa2RsOUFWNFB0?=
 =?utf-8?B?WFZqMUNLa1Y0cmpTdEpYYWY5ODZINUtHbkQxUmYwQSs0bmh1aDVBclFYbXdK?=
 =?utf-8?B?ZkZPNkpLZE9BMi9hb3lFYS9xSkZnY3JZMUpoaW1NOWZ3dTJHU08rb2EwMlFp?=
 =?utf-8?B?cnZlejZmejNoNXY1T3pqT2VZenFGbDFSOURVSUkvYUZsc1VvQVJESHRncVVR?=
 =?utf-8?B?M1pnZ1BGWlNVNmRMME1zZmFaSEtXbGEyTzgvUzd3dFREdDEyWW8wcldhS241?=
 =?utf-8?B?Q1VtaGVDNHlGNFVENmN5VjhBbHFiNE9Uci9MTjIrbVd2b1c5cWs2TWcxM01F?=
 =?utf-8?B?Y084cjVMMlRTeWdYRGdEMmUvR3lhVEMrRTR5eXNJYjNjT3lnVXJGNDNUNmtW?=
 =?utf-8?B?NUcxbkFHUmZLSUdkQTU0R2ovYVVBb1liYXJiTVA2SmNCN0s3RDFjTnRGL0dr?=
 =?utf-8?B?ZzVJQnhCcnZTYy9lZ0w0L0VIeExxQU9DMmEvMit6TFViazc2REIwbEVkZm1q?=
 =?utf-8?B?bEd5Y0RCZWxyWDJkdjgwc04vQXh6UkdoYy9vUDJ3ZTBEdDIyM1pMYlM5dncr?=
 =?utf-8?B?bHhJZEdCVVFqWVFnNUxKQjZjZ0liUVFZWHZTQ2x5SEp2Rkxab3N2NGhDay9G?=
 =?utf-8?B?R1M1YXJLbUkxaFZTZ295VlkzdTllbmRuZG45TUZhZERKWURWbGVDbUdwSHhD?=
 =?utf-8?B?RXlUY2kyTVpuSFcwTVkwU3dWQ1hqaEJaR3ArNVVETlh3a25WUGdJSWlnK3Rx?=
 =?utf-8?B?TWxtWHZnTUxzSGRCT0V2M3l0TmtMakp5U25oWFpKSXdDRDNLNlFEeWJyNkxP?=
 =?utf-8?B?MC96UytIRTFEZ0JnQkc0dkN1dWFRVkdhdWRFRmg1eCtOM2J2M2w2UVRlRVU5?=
 =?utf-8?B?THlqRnlKcDFlWEFKMVpBZXE1bkdsNlh2RisrQkN1ZUk5UEZpOVV6TzV1MWZ6?=
 =?utf-8?B?cGFCV1JlSDNiNkxsVWhOcnRzbDA1Nms4RzdOTmZ6ZDZsWGM0SmNrL1RjSExs?=
 =?utf-8?B?b21wdktIbDVzLzR5aWdQTTdzUVlFVGRHcVdmazliMVE2enJPN0tvekZ0S2U2?=
 =?utf-8?B?UHoyTEtGekNZdTZ4cTQ1ZVk0MjErbUs4cy82RDFhU1NiRjJ4ZVprQ0U4QUlr?=
 =?utf-8?B?c3ZMdW1QU2ErY0ZrN01TOGlXeW8zSi9STnp5aEJRREdERzdncEdSQ295Y3di?=
 =?utf-8?Q?e1tM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7094.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHc0REw4NGlwOUlLQ09GUXZ0aHpKWjVDYW0rQU9Oblh3b0NmWVVlSnpPbFJ0?=
 =?utf-8?B?ZXQ2YWtsSlZIUXlOT0VoMVIybnpWdUNkTDFqL21pZFprS3N4aHFaQk5MVmo5?=
 =?utf-8?B?dTlLNjJ2TVpub0JSUS93Uk1Gb0w5a0pqRDVaN2h2MC8yNVh3dGlTTnNybFZz?=
 =?utf-8?B?ZVNjdVJmR05tckxCVmt5OGxBREorVGNiaDYrSWJ4Q3Y2NWJTY09lTENZbVNz?=
 =?utf-8?B?N0xwNURYNk5MZ0JQR2ZlbHJOZFREdm1NdTZGT1V3Yk1RT3U2N0hJQWJYWFVn?=
 =?utf-8?B?azk2dHJVYVcrNW5EN0tjdWJTVm5jWlJhWnc3UHo2emlhckJjUkYwZjg4MDA3?=
 =?utf-8?B?NGloTmw5MU91S2xVN2VkTTIwWUFZU3I2YlNNYjJHYUR3L0xHYTJPTE5nelB1?=
 =?utf-8?B?LzlGaElqZU5wMGNSZ0cwSVdNWi9GdlNiSUVhWG9ZN29XV1lCODBhQ1JkMS9z?=
 =?utf-8?B?QjRxeGRoU0N6djV2ZnVKaXN6bENUVm9aR2JRZW5oYWROcjRqT0tHaVhIaFJj?=
 =?utf-8?B?WWRGdnFEZ0wyNVo1Q2hKSzlzdHFvUW50ZmNwR1NzUVVxZ1hHc3ByekNWZHp5?=
 =?utf-8?B?dnI3ZHRKdTdnemdnaGVLby90SnZoSFdkdVYzVlRreURlbFROc0tIUEtlUWpV?=
 =?utf-8?B?YlR6WXA2Y012cnJydzYyc0VGM0xHbm5zUmhrZHNIWFRkQ05jUVcvY3BuMlhp?=
 =?utf-8?B?b2VvYjVIRzJIclhIV1RRVTB6VExOc3RNSEZpOWduazc5RS9vaHIvSE9tTDV3?=
 =?utf-8?B?aEEzeVlOYnRLeFhGV3orTWJWcjQyTWZIb0FMVmZubnVuODM3Tmt2N3owald0?=
 =?utf-8?B?Yy9ITyswTmJ1Q21nS2hOYVBScXFyUXZxS0NwK25nekdNcHljYkZmYjByU2ll?=
 =?utf-8?B?SDZSQVB0dzZTWUN1MG5VaG5LSlJGRTVMUVBPK29KRXpTK29YN0ZibzlzWE83?=
 =?utf-8?B?SU1XNXdmazFLZ0VWcm5melk3WnlJZGtGeEZhRWhHckhrTENidTN5SUhRQ0xF?=
 =?utf-8?B?bUw0aVlwZGdWQ0FyS3ZKd3MycFMyaE5LRHVFMG5aNHNCNStDb1lKc2JNbGtM?=
 =?utf-8?B?aTVlTEZkdG9FQmNtaWplSWRyWUxobnZHazlWaE1tbk9Jb3lnN3JQSXlnUDVV?=
 =?utf-8?B?S2pQaW1sOGxVekVPUWV4Zzc1SFo2TTZrZExFZGdMb0Z4ZytlMU9kR0s0b2N1?=
 =?utf-8?B?L1BYdGhsbEVxRjVDRzBjT3ZENE8zMW84SzVvRU9aeVZ0RFBHNi9uRnBRUjE4?=
 =?utf-8?B?K2pGS2ZyM1Z6MmNpSjRVMXBjUW1PRCtiVndwV3RwV2NVWUk5UzlNNEYweVMx?=
 =?utf-8?B?TkpsU1NTR2h2YXdvSkxFL3JTVVVmdzhkZXV5bE9DMCtkdWFNT29ZQmU4b3Mr?=
 =?utf-8?B?ZVlGaEovL0JiOXp3NVFDUy95RW9DOUFTb3JXRFdFdjdiS2c4Y1dUTit0Ukc2?=
 =?utf-8?B?Z3ZzVXlaZDVLS1oxRklTT3VNcGQ3cXRmenZZT0NFTmFQS2pRMHZjUlBuSlly?=
 =?utf-8?B?aXhKaGZHYWhxZldqdnhrOHVsT2JoaklraUkrVWllRGd6TG1TTWlIMllrQldQ?=
 =?utf-8?B?eTB0djJjb21lRHJUU3p3aEVZWE43aHlGNUQwUFZWUitTNG9abUZnQiticUxt?=
 =?utf-8?B?SElCeWlQcVdvcC9KV2lib3I0bmo2cEkzUG5CNTU5NHBkVXdIdm9kblY3emtC?=
 =?utf-8?B?eGFnK1BVam1HdTFzZS9NZ1FERFAvTDdpYkJzY2NrbFh0WlRDNlBUTDQxNlNJ?=
 =?utf-8?B?NlZiWjhCWDVNYTZURTlhSXFuN0hqMDBINXRQd1lleGE1bWxBNlFSQnJoc1Jx?=
 =?utf-8?B?aEJNM0NuVVM1bXRSRGlSb3dNQTk2V1ArWWdVc0lwamNIMDFoWTczTTR1UlF5?=
 =?utf-8?B?MVp3ZHVMU0t6SmhVRlhaVm1sd0lOMERCQ0ZIWjZCMzh1VHd4WFZLQnd2c2xO?=
 =?utf-8?B?SmpFTWZGZGJwZTVKSS8wbnVlS0tJV25rUC9jeVMrYTFRKysxbEdoZGZNaytj?=
 =?utf-8?B?c3hGcFpOSzNuemlaRTk0ai8yaXphZVg1YzhVaHNKMmZnUTBVaGFHYllNOWt3?=
 =?utf-8?B?OUhadmc3NkdIcVlrWC84QVp3OENPUW82bTl3UVVhM0IwZGxPZzgrU2NpWG4r?=
 =?utf-8?B?OWtNbVhVaC9LUFVBU3lrdjJTczN1WWFScjhQZzV3ZmxXc3FqdnB3dWJMeXFO?=
 =?utf-8?B?ZWZwdmYvOExPNVQwcnFXbkM2cVpMdFpaQjdBK2pUYk5aY0dNb0wrRmJNclNI?=
 =?utf-8?B?RFo5bHR2ZHU3cXBmT2FqQjhkckJZVVZqNk1MVVkvM2grbXFHM0h6dWF5b2tG?=
 =?utf-8?B?QkgzV0JDMnBGbm9KV0ZqSlc4eFVNcVNaWjRPQVRpMTdMbFJ6dnVUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e43925-763f-4edd-4161-08de59dad30c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:22:31.5797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0P+kfkVQ99Ti8ows7/PL3SnIiSkPIOE6OIk7zmN+KBkhP6bPKYVdHeyEDCWuTwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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



On 22-Jan-26 10:32 PM, Alex Deucher wrote:
> On Wed, Jan 21, 2026 at 1:27 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 21-Jan-26 8:44 AM, Yang Wang wrote:
>>> resolve the issue where some freq frequencies cannot be set correctly
>>> due to insufficient floating-point precision.
>>>
>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>>> index efeaa3d57712..b0d6b7b0946d 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
>>> @@ -55,6 +55,7 @@
>>>    #define SMUQ10_TO_UINT(x) ((x) >> 10)
>>>    #define SMUQ10_FRAC(x) ((x) & 0x3ff)
>>>    #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
>>> +#define SMU_V13_SOFT_FREQ_ROUND(x)   ((x) + 1)
>>>
>>>    extern const int pmfw_decoded_link_speed[5];
>>>    extern const int pmfw_decoded_link_width[7];
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 51f96fdcec24..e27ea0879429 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1554,6 +1554,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
>>>                return clk_id;
>>>
>>>        if (max > 0) {
>>> +             max = SMU_V13_SOFT_FREQ_ROUND(max);
>>
>> Looks more like a firmware issue. Isn't firmware supposed to round it to
>> the closest DPM level frequency?
> 
> Arguably yes, but at this point, it's easier to fix in the driver for
> existing programs considering all of the firmware out in the wild.
> 

The question then is will just (x + 1) alone get to the right frequency? 
Or should the logic be like what firmware is expected to do to find the 
nearest dpm frequency?

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>>                if (automatic)
>>>                        param = (uint32_t)((clk_id << 16) | 0xffff);
>>>                else
>>> @@ -1565,6 +1566,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
>>>        }
>>>
>>>        if (min > 0) {
>>> +             min = SMU_V13_SOFT_FREQ_ROUND(min);
> 
> Does min need this too or just max?  Same question on smu14.  With
> that clarified the patch is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Alex
> 
> 
>>>                if (automatic)
>>>                        param = (uint32_t)((clk_id << 16) | 0);
>>>                else
>>

