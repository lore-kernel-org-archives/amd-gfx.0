Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9585EE9A03B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 04:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3462B10E4F0;
	Wed, 18 Feb 2026 04:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g2hBVI8d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1487D10E4F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 04:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5cFpIrtzbhnR+VHh6ti/oVlYnoZgTMlJuyHv4w05G4kVuwWJ86KpgF2XKvTglZgplGMwJN989g0FpEhqbh45Yb5qvU4wDJJnffPNF1kePN3GOSM6204an2w5cbZGi4r7y9TkhO8OKQeqCREnXwHOKnLPbvlPIBi3p8eS/SPKkj8O9cpKR591aTU86u6LEOOaGh/r+bmB9EaMBLN/GJ0yrAoaeQAs0z6Rq8lhaHj8zouQgL3Hdk9KSSAk1pv8NRkt/Qt/CJhO9QPNsOzF6x+ed9/fUMOHq2iY6Q0Y/za4yQ3BTJTa9ckHetxJkoxHYSeNDyHoCj99Vx0B67vwqpCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYQXtYJobTVIAtNFDOd8KjznzUwjVdSexLZ1uzUQrm0=;
 b=lr0gkn0ms466iJ1ADrXI8DAOh1B5QxNl4tar5WWrCbuqcZVno8zVQqXs0QpqgmHVZORa/iCGgDCvzOaHsaZkwE8tv9/eYk9PDbXT0wUIfnFxq4GNFFHNTbKEL/I8dku1aWJD4lMQDPxnGQyzFuMUZkli+F+eKweBStGGZe2EutL9SjTLgxFe2gkEdiqQQ68kNdpTpd0ED0JHx7EcxLjCVVdQ+Py+nV86lzJ/pCQlL0TCeAkJhWo5JnMSv4E97LTIkEaqhiqbMMCQUa7kMMA2naOCXH8nVEy0jPWMMf8VV6dMKHCRxe1zkjlfJcDX46l+mKseU8ReDM4lvoiW3zhQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYQXtYJobTVIAtNFDOd8KjznzUwjVdSexLZ1uzUQrm0=;
 b=g2hBVI8dBUnGfSTntQCZg6g9R0yIT1TnND7YiRGMl482A8hRiJ6kE4GXiMFY+MsMIzYhcgpN7itUFYuAoMdZhpRlyC0oHIEq2x485MD+LpYne4IOgmhKDYc1kNwxBMN9E9K6QqCJPwzfDAOMJDfOpqgrEZrJZk9a4e59i8aKPEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 04:53:11 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 04:53:11 +0000
Message-ID: <63395b0c-f5a5-41c0-89eb-e8d474cfdff4@amd.com>
Date: Tue, 17 Feb 2026 21:53:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amd/display: Fix disabling fastboot on DCE 6-8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
 <20260202112508.43000-3-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260202112508.43000-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f69131-cf23-4fec-a0d5-08de6ea99de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzRGRWNHR0Q4MHZ5S0RlQ3hvMnFOVThYTjgvekJWOFpqTWhUU0RrOGY4OTZZ?=
 =?utf-8?B?ajBHckMzTllGdHpLaWlSN0Qxd3U1TDRuS1pFamF1SnpsQ2xpNkQwc3lWTm45?=
 =?utf-8?B?aGljMHl1eWJXSGlKc2lDTjBGcCtsR3NoTzAyZ3FPU0Z2MjlVRktFcU9JeUtj?=
 =?utf-8?B?SkcvZ0N3QWllclpWSFRsZGVnSGV1cThnTGlYb0ZJa3JsdjkwWlhCNW4yd29q?=
 =?utf-8?B?eUNvQy9zeXZSWGcwRWZGYk9IaTFVTzFxNG9BdmRTcklhWXpVVGZCUG1rQ2V2?=
 =?utf-8?B?bE9IbTNDTlQ5YXd1UE1xRlcxZVpDNHZydEVGZXJCcjMwUFJNUVhCRlpVczhu?=
 =?utf-8?B?bGNYZXlkM3N4K0ZqZDJYZDJyM2VjbmpzYkFsMTU3QkhHUDlBaG9oYTZuS2du?=
 =?utf-8?B?eVh4VDFheS9QQ1l0cUxZL2dKTUg2aU5jR2JPengrUzdRRjlBMWNJc0RRWmJz?=
 =?utf-8?B?TWdYdHdJTWlSejVrSUxDSEh0N1ErVllhYndGM1IzWWRoUjkrYVN1dzV6V0Rx?=
 =?utf-8?B?OE01SitVSnp2NGkrNnZiN0hkQ25sTVp5UUduVUFmblVSdVdhekVDckErd3Vh?=
 =?utf-8?B?OTM0TnZtRU82THgvbW9raGk3K2VrVHlHcGluNTBzT2M0MlQwdDV6MVhZY0VH?=
 =?utf-8?B?UWtQamdWRm1wYnBzNjRVSUE2c2FzcUoxSldMU3FsZEVSbTIrT1BCU2dETTBv?=
 =?utf-8?B?Qi9XVXp4dmptdm53UDY1V1ZPN0E5QnRac2RoSVRkcE9uMzViem8rbFRmWG43?=
 =?utf-8?B?ZndVSzVyaWV0bTJWRU5ST1FwR0ZRTVlLVXhUNTVRdkl5eTlJcE1HVUliYmVr?=
 =?utf-8?B?b3ZWOHBRMEd1aFFFZUdWSHNjLzdiM0I3Ni9sR0pXcndpeWVmK3JMNUR6UmZH?=
 =?utf-8?B?Ni9QRE9SQmwwSHNVQ0Zpd0h4U3VYbjBRVk5IS0grWk1zN3JhVkwvQWs2aUVn?=
 =?utf-8?B?QXAreEtrdjdvNkxCM3d4NlRzc0tKc0FRL0RzWXJYTGwwK04wdHJxdytrd1R2?=
 =?utf-8?B?cnFYNUQrUXVZVmlmRkV5b09HNWt5bnkzK09LdVhoTDBSZHN4aVpQa1BmRndJ?=
 =?utf-8?B?WTVXa0JOUExwcGxQcnRjTUFKVjA0TXMwbk50V003RkJ0R2s3bEdvaU85aExZ?=
 =?utf-8?B?RERLMW5Xa016MjRMREQreTBvTlI3dUJKOTRCVFdTYWpPUjk2L3AwSys0cCtT?=
 =?utf-8?B?ZnFaVHFUaUFtUXc0b0VHREd4RTUzR2t2MVFhV3J0RXpvUnJqaUhZQXNVRVkr?=
 =?utf-8?B?NzRjK3BGTjQ4UFZZLzZwZFcyTk5qNnphdXhoR3ZYNjF6dnR4blpLV2dOcXFP?=
 =?utf-8?B?c2U4VmhqOEZlMWp3L2VwYjI3M0FRcFNlckYvc2hKeS9vNHZheUxBSjcrYmNt?=
 =?utf-8?B?TkliQk9oVzZqcGRLWEVIQWVkcEVxQjliMm5JNmVXRXlETmFoYUFjby9GWGZj?=
 =?utf-8?B?Yy9uQUdZczArRzB0cC96ZzVzWkZTdE1NUkZrazIzYlk1OU1CK21vbjlCL0Y3?=
 =?utf-8?B?cVZreUNRTnpMME9jWFJmWmRsdExHSGs4YVRRZG9uS3kyY1JwckFiSGI0amJK?=
 =?utf-8?B?d2FtekpEcmVJdHk2UE1qbkZ0K0Jyc3I5SkpXaU44Z2xOa3ZYTzNVMHhLQ2to?=
 =?utf-8?B?U1pJcUhqSGVYdEs5NCs0YzA1V2JJRHN6NEw4cCswa0toSWNWbnlVdEsyeWNu?=
 =?utf-8?B?d1NCWDVsUGpObUhhTmMvRlV4NmFxOU9HQlVsY1ZCY0diZ3VDV3o2dTUvVlVG?=
 =?utf-8?B?NXJ6RENDL1JJdVlyVGs4N0p5Ri9JOGZHalNVOFBkMzdISTJBc245Vkh2aVB2?=
 =?utf-8?B?ZTJLcEl4VW4rb1JTWlhQbzNjZkVwWWVmOVVpNWpxZlo3OWtjRVBoSFZVc3Zt?=
 =?utf-8?B?dkw5azhiTytVR0FUZjZkV2w4dFVDZU85ZC91SG1hbTJycFhKNDZDRkRIb3dl?=
 =?utf-8?B?dTdkcWZVWUNIVHM1VTVIZnZocW9VZ1RkYUFCRkw1aUswVC8zQk1QRjFhNlYx?=
 =?utf-8?B?SlhnRkx5UlR4N1FVMFcvUVpqS1Z4cTNEaVdwYUVQVkxOekpUT1VabWppWjZW?=
 =?utf-8?B?TUVBQ1J1VVhFcHdnaTB2RjBJcTcvNlF0ckJiclVCVnJRMk1vVVk0L3VTK3or?=
 =?utf-8?Q?ZTJw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUwxOFZiVDhHczExNUdjcndGRmtDQzd3S2lucFpDUlUxaVBDQzdkSHlpRGdP?=
 =?utf-8?B?d2ttaGNxYUVhV0lhWEl6akYwYWkxdGRJVjVRTmVtcDNRajRQVTl6TFExTXFC?=
 =?utf-8?B?clR1c01sQThMWjlMbzRvaUR5azNzQmhZdnBwQThoUStwUW0yeW5PZjM5WEFn?=
 =?utf-8?B?eTgyUkJsb0NPSVF5cElta3NLOXpheGZucDl5Q0pmbjg4M0VwQ0oxaG05NHBs?=
 =?utf-8?B?a1FYQldwK09NTDZMTDBjR01jMUJPVDRRdDBIQ1FzRWR0cjdtVWFDWVBhSXNC?=
 =?utf-8?B?aVpVWU9NQWI2YVViK0R1Vk5qYTYxMzVkRDNyNlg3a0RBbnhNcHpQd2pQZUhm?=
 =?utf-8?B?ZXREVlUvc3FZU1hhdm1kZzhjUUJKcTFrYVIwaG1OK1pXVmJYRi9rRkREZkxW?=
 =?utf-8?B?bjVHaTRRMzAyMWRZNlRrUGV0NUFFRnI3ZDVyc3FrSUVGMWRXK0VqQWhxOTNq?=
 =?utf-8?B?Q0JsNE5tRWxGdWY4ZDNQRTRDbHFXY3FBSEVLUjRkVU01MkU5NVpCWFRCcE4z?=
 =?utf-8?B?cnZnM3RNUkw1THc2TzRPL1EyQldrekN5UGdKSlZGOWVneDdIRlZxQytxM09O?=
 =?utf-8?B?Z1NxV0krRndUalJkd01HUFUrN29wSTlnYVhHUTJZVWdUMzd0MmdmNnZuYld2?=
 =?utf-8?B?d3hNUmxjL3RXNjYwMXF0MWRsMVF1NWxXdnNVS2xJRm1jekdIZmJ1emtDd1lp?=
 =?utf-8?B?TEpXZVVXdmNHNU4ranUwb3JNSkpxNHpFbm9EcjdzaHJOL2ZsMnZ3eEZHMG9Q?=
 =?utf-8?B?K3VQamM0S2krRlo3SFZ2RC93S1prU2hOYXpoV1hxSnh3L3U0cEZLeVduL0VU?=
 =?utf-8?B?ZWdNRnBPTEgwamJRWmhnMGtrb3JzV1JuMGVOMnVSbmY0UEJuYkZ0WXQzTDJt?=
 =?utf-8?B?aHNCbHhwSllHYW12UjRBWkY5THI1NDd3VStXeWxBU05nbEZ6bVNFRnd0Rm9p?=
 =?utf-8?B?eXJqdU05eWFsaFpqa2YyWTlJVTZ5VG91TGgrSE9oc0puS2x0STRjd28zQmRF?=
 =?utf-8?B?Mm5WMkR1UzNFYTBuUGlpOXhkbStnNFUwd0Z1Nk9PVUtvU211QVBPOU5HRmpG?=
 =?utf-8?B?c2dTYzZIQmJMQWM0T2Q5Y3Y4aWJoV3ZUWFdoZmR0bEUwcFFIMEY2ODJlOXY4?=
 =?utf-8?B?V2tlRkNaelVORzFjMlFPZDZtbENWS3B1NVZpVnhGeGVMZ2NTSVhpWGRFL3dC?=
 =?utf-8?B?Y1lKaTJTRy9FZ3liRzVNVytIVktrZmR2eEhFUU1lOG00Vk81TVg2ZWxYczJQ?=
 =?utf-8?B?eCtJK0JncnVRQ1JTNzh2d0hSem1oVEFpTFNqZHRaK0tnZS9kNEIxTkhPRnZJ?=
 =?utf-8?B?YitmL05RVTh6c2VEbmFvVlpzdys5TmJnQy85M21aeWtTUjlrN0x6MTU2NEtm?=
 =?utf-8?B?L1djNk1oNmppblNjYjEzanlhSzFFYVpyYnR3QzNZMGF2RG1hRjVaQTI1Rlgz?=
 =?utf-8?B?ejdTZmxJTHRxSU01cFRORlZHRjVYMndjelpBVGlXbGlBRG9SVUJacFMvWFpM?=
 =?utf-8?B?dHQ0SEE3OW9iMk8zckQ1UVBZQWxoN2lIMFM3bG11NjM3TEtJOVhOQnJ2TUJ0?=
 =?utf-8?B?M050L2RoZHFrYUZxRjRDUSsyaXdXZ0R3YnZCTDQ4Ylg3US9XUnFjNzJIaEs5?=
 =?utf-8?B?OGt3cFVFOHU5bGNZU09ycy9tWDJOUUlNUmEzYTh4YXJVbVpSeXB1eUg3ZmVy?=
 =?utf-8?B?N01wVjRiUzhDOXNIc2xwNGZJUUxPQis0MFhENTZyd2xxVjVXNGVoeGRCSmF3?=
 =?utf-8?B?bW8veDNnTVJrMVVkak8yd3NnUlpwWU5BS3lsbHNsNHZPeUg3NVNIdkNmZ0VM?=
 =?utf-8?B?cnNuTEZsZEtlTkErcFRmRWs1Q3V6cjlUWEtxQUgyeStGRW1Lamt3QTIwcDJY?=
 =?utf-8?B?Qk12dnc4bk1ZekZ2Y3BtQVBCQ0owS0syTUNpNVFwa1lhbnl0b2ZrcVNhQjhy?=
 =?utf-8?B?cEM1VGNKMnFGdDlYWGw5Y0xDM1RqNTFoTHRHNDJORTVld2YxVjg0MFBYU1hp?=
 =?utf-8?B?K0tiNG1EaExBWHBJMS9NT05LbkM5NjdRZUNtZzd1SCtzS3FLcVNoOGJPRzJH?=
 =?utf-8?B?TzRwNW9BNHFhU1NvUm5uMjBnaURWWjh5N1hmQ0NZR3hXTlVGand0Z0h2Rk93?=
 =?utf-8?B?WW9HOFRkVTBVSG5zV2dhSndtMVNNUE9WUFB2Z0J2NTJ0eG1FS0pUQlFidEpy?=
 =?utf-8?B?UDFLWkgyc3ZOMnZNZm9pSHh1NGJTNHNjY2RVMDMxUG5vYlBEQVdWY2dBZzJR?=
 =?utf-8?B?ZzNKT3l3OC9oSnhhdEZkWGxCbDE1ZVBUbmZhclN4eWQ3T1hQT05kaWZIWjIv?=
 =?utf-8?Q?KT0ue8OF7cz5lG5PmO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f69131-cf23-4fec-a0d5-08de6ea99de2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 04:53:11.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUTl1K0Ol+fVJaQqTez6OBu0I+erPsd+A2gnlzKEwcbUsaBiEy+nqYpYJDW6IhkGOK9sR9FQzvG1a0zJc95A+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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

Another commit fixed it: 15ccad9e246a drm/amd/display: Correct logic 
check error for fastboot, and thus this patch can be dropped.

On 2/2/26 04:25, Timur Kristóf wrote:
> The fast boot optimization should be enabled when the current
> display controller engine version is DCE 10 or newer.
> 
> This was a typo.
> By mistake, it was enabled for older than DCE 10.
> 
> Fixes: 7495962cbceb ("drm/amd/display: Disable fastboot on DCE 6 too")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Tested-by: Mauro Rossi <issor.oruam@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 4659e1b489ba..bd3a9f008699 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1965,7 +1965,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>   	get_edp_streams(context, edp_streams, &edp_stream_num);
>   
>   	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
> -	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
> +	if (edp_num && edp_stream_num && dc->ctx->dce_version >= DCE_VERSION_10_0) {
>   		for (i = 0; i < edp_num; i++) {
>   			edp_link = edp_links[i];
>   			if (edp_link != edp_streams[0]->link)

