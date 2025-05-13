Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4ACC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 21:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB6E10E219;
	Tue, 13 May 2025 21:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKURVbO9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07E110E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 21:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfRRwFIs2uKOesMdfi030l74+IoQgHauzuZOUjchyZSEEJyeQoaXeoM13TvR6/w17upujaHfD0ZhWEdvqSFzcq6p9RpvX34VAbUX3mGo/YwPQ9zVeZI8wXMahDziAIWYTkwD8olBO762ovDz+MD03NJNCwz/UlMNRTZ/mdgVPT2p9qPkv44yYGm5cPKiDzxVPBjL4nTaZDMD7qnhKvvFHT9lqP9aaesnZbwXyoX6ABj0BMrd2mXHjTE9zzwqlxvJLQR2y6TKb6CzUZhB8SenwuWYDJp5pT+LRCsbQGJOaPvTbwJfzcx2RHzgZTd02uL8hAP3yb7YVdLdynx/unu4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uhSEGBScNtzRBOe68y2OGrObVDke8+/1GRHj4Yo1rY=;
 b=Z3rV+wtvQIGHsEtZ2Gm9qjv7goFc5mGpqvCzuIS9uiLlnNlBjSCxCsf7ycycsTNe5bLGyGDk1pB9+5YqZE2f4ZKdmkJkaJaThGcdluGnFYk+av/92byhALncGz9tcQDuy4B9oTN1R4UQAO0ZL1gp3K1tmasjPNTwjayr/hfRlFp1gcUYDDtHG3P1UexJuBsh5W02YaqUZpMPaxv8XzC79t1M6tH3QoS8xqCJRCiHnVCShTr+hIXDU4BT7ARoMhHCWBYxI+0L7rIFO7IXZ2rHa+vVRgXlHPdPFHtqvchLn5wXQk7JL5I8ST8XkeHD1HkgrMczdI4po9o62oL73U27AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhSEGBScNtzRBOe68y2OGrObVDke8+/1GRHj4Yo1rY=;
 b=FKURVbO9AbVsyivCsde0dAjGsC39tB5QYx0G5aZB0j1pMv6EeMlCX3KH9hUIEpMYFNNXLjdBP9mUd/U0Fl+41VLOcYXatgnwZhxSuJ3otYlOW2UeIv6929cyHV+Psm5r+fAPdQURo3YHk1Kk4+9ilwOR7BJIFjTmatbXAeG0Qxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 21:13:55 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Tue, 13 May 2025
 21:13:55 +0000
Message-ID: <d004d45c-d73e-44d0-a3b0-0ec2ef1681a8@amd.com>
Date: Tue, 13 May 2025 17:13:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu: read back register after written for
 VCN v4.0.0 and v5.0.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com, Mario Limonciello <mario.limonciello@amd.com>
References: <20250513182307.642953-1-David.Wu3@amd.com>
 <20250513182307.642953-2-David.Wu3@amd.com>
 <CADnq5_PYHhPoRRgToDjJr58utMGLvyKhUtt+WdZvL6B_w2YjBA@mail.gmail.com>
 <732058a7-c995-4ca4-bd8e-04df669122ba@amd.com>
 <CADnq5_M2-3T8thYY-BtDOt_w+rxHFgyuPNCVnwyTY35kwKGsFw@mail.gmail.com>
 <e1e19625-faa1-409e-98f6-67c0cd240f61@amd.com>
 <CADnq5_OnS8WR6OFNJmcH-eSVVq4YGuYrCCcXRT7h9P+P4ui_iQ@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_OnS8WR6OFNJmcH-eSVVq4YGuYrCCcXRT7h9P+P4ui_iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::22) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd4cdd0-7439-4cd0-3249-08dd9263119f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDU2dUl5TmZtYmFCVHBENGZnRjk0V29wT1hzRGpwek9PelpjbmZpWFlwMFZp?=
 =?utf-8?B?Q2cyTEFEUWhOSkhveTdJNmNPSDk3Mmp6d1VNY1hobUdNclB1RTR3Q3h4emI1?=
 =?utf-8?B?SXZYKzJKZStuMXdLNEdxSXBuSTR3Q2pocGtJaXVFbzlxaXVDUTAvcEpDTHc1?=
 =?utf-8?B?cW5oQzhRVm9BOGdEMXE1cDhtelJvd05pbUlnR245ZEZZcFBZSmE3QkxGd0pJ?=
 =?utf-8?B?MjkwZkVtMi8vMTN5TkhIWDk0N1ZuaUcxalhNRXp6NElXajBFOHNhNldFMS9Y?=
 =?utf-8?B?bVFYQ0F5N0VsbEdVVzNaNStveHp4U0VEcVdUWTZOWk9McWRyR2U3bUp2QmRt?=
 =?utf-8?B?WTgzOE1QS1lmcFM5SjhuNE1LM1dLcUc5aWNlMStiMFRYQnVUMXRMTmd6eVJq?=
 =?utf-8?B?ZTJ2Y3hkeG1kRTZ6M05tdnh3UTFEQXY1S3FKZitpNGpSRXlEUkFaVTBSZ0xq?=
 =?utf-8?B?UHp6Wk9OMzJYdUVhejJnakszek1IYmhXWWZtK21xWXU0OWhSUk5CdXVjdlB2?=
 =?utf-8?B?T2VNWGM1VDI1QThwVW5kTE42WU1icjFaWmFxVzFDMkJPZGVpb3hYUldOemIy?=
 =?utf-8?B?Z0dXdkUwSGpRNjNnQW5UbCsvV0QvZUFnd1N3ZE5pc2lTMHQ2TEhDRHJuVWJR?=
 =?utf-8?B?cmxJRExiaWk1KzRXVnU2YW53ZCtRVEp4MjRjU3VUc0RubDFoWnBrczdpWjZi?=
 =?utf-8?B?WTYyQ0lnVlpWdGRxVURHVENyUGl6bDl6dzMyY1ZCcFhVNE9DbmVOZythRnpL?=
 =?utf-8?B?YU9TZ1kreFUzb3NVeXhuUm1tVmpMa2NLQjBEeTNqeG1KbkVKcGVpOWNHQVNw?=
 =?utf-8?B?QTJSRWEzTWd2UHFPUHVqSFlFYXdlK3E5Y3MzRFFoWlhka1IxQ0MrQjh2Wk85?=
 =?utf-8?B?YXIzM0pqOTJjb0o2aUZBbEw5YjRZTzdMK3o1V2oxSmw5TDVwcnAxWXB5NlRM?=
 =?utf-8?B?QTExOURwUnAxbm16SS90SXVudU15RHVVMUlsekhMeHduamRNb3d5VUFldVpr?=
 =?utf-8?B?b0RVNGo2M0FkNnhrV1BzK2R5THpXZUZVOGxTSWl5TG9qai9SK0ZqcUNVQmRC?=
 =?utf-8?B?WDloa3VMUTQ1R1ZKaWFlZlM1Rk9IeHJBRVF2Nnk2Z2FPRHBJWnl3VkRBYnpu?=
 =?utf-8?B?MkVEc0hNY3FBOHdTL3d3YjdHVXB6NUxoTEtvV1lCa01kL0dTYWpZNnBXdFV5?=
 =?utf-8?B?cjltWXpaVEh6ZkJUSFNMZndxL3IySVRVR0pabHFqMWpuU2s2Z2F5SzAzUnhy?=
 =?utf-8?B?bnFqY29ScnRuOXZuRVIzRHYxdFRqQ04zMEpFaFRSaXpXemczSGtOaXM5eTR0?=
 =?utf-8?B?cWxsbWQ2RkszY3R2Q2JQOVNoaHNiejFmRU1iaWFGSURrL1FrMDZZNXBmeEJm?=
 =?utf-8?B?REpRdm5qY0JQSUJyWERVMFR3ZzIrNW5jR05rdEVsRzJQR0pJbTdMc0VsNm91?=
 =?utf-8?B?NzN2djdHNHY0cXdwcklGL0xudjJsUTNLL2NnZk1TMXM1WjVDRExQYkFyTWhT?=
 =?utf-8?B?Tml0Y0NORis2VWVWcUpJaGZYclgvT296ZUE5Q3lNTjJwaWd0VVNYYWY5Lzhz?=
 =?utf-8?B?azJBQU1pNTE4cEVoNFJkVFJxaUJUbWNPOTBKWEtKVTZKNk51RGZEcWk3aW4r?=
 =?utf-8?B?MTBMTkh6Wk02Vlh2NEs1QzN1UUZxMG8yc3hlaUxFVEttWHlrMHczY0hxVFFr?=
 =?utf-8?B?TjdNMUlUd2dWOElZdjFEcFlUcjg4dWFRRkY2cG1BUzNzNW13Qlo0bzhuN1Vy?=
 =?utf-8?B?TjB5OFJDZmpXMGtsNWg1ZHJWSkFjbjJQRktlanhsSm1TK0ZqTEJFUmFFSXFS?=
 =?utf-8?B?cGNZOU1ST3hzaHE4S2dhTzFXY09VejZmRXpWajlzN3RHS0M1RjZEOEt3REU0?=
 =?utf-8?B?dHoyWFNzODNiMm1WRWpNSUVSeFZ4c3gyQzh6UHJmWjV5N05oNjF6OGtFTHVm?=
 =?utf-8?Q?hydhOutwNxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHZqaGdGRlg0UWM1SklINUZBaklhc3daNXB6Q3hSTlBPMUF0UFdJRkIxM1hZ?=
 =?utf-8?B?V1lZU1E3MzBkNmw5ZVBGbVNncGx0aUNyWWlyYi9rQ2MrSjJVSGZoRnk5WDdY?=
 =?utf-8?B?bFpCc2tTUUZ1b2czd1dwUENRb2xsL28weld1WnM4S2ozRm8yMTFJTDY0S29Z?=
 =?utf-8?B?Yk04STA0NGZ5TDY0SG1TaEZnVFcwUXltdDR4TXlUMWhPVGg5UjhTbVlLMEtm?=
 =?utf-8?B?L0R2UlRIdlMvRlYwb3NuYjZyNUQ3RWo3Wm1sbE1kWEt5bnB3SThydVRHOEJX?=
 =?utf-8?B?TjFuc3BkQlIzT3NsMGd5bTZBSlNYRFZoWnVRbTNXZ2JCQWMxSmNEWDhEczg4?=
 =?utf-8?B?U0VXSm5mZVJydVlxK1FBakUyMDFCMDUvbWk2RFR0QjNlOXY4d3JjUmE0MGxo?=
 =?utf-8?B?UE85WkVWQ1liNWM1Q0pua2I4NmgrbVhzQTNGNk5nOXp2L0t4VnFvbEllSEdV?=
 =?utf-8?B?V0VDRE5KaG5oZk9XUmNBLy9ESFZlYUNkb1p5ZUtaVDllSG5ZcnhhRTFPaGhm?=
 =?utf-8?B?N0F1RjBKejdTTTBHaVJxVklmTzN2RWE4OFNvckt4UEpUTW04dnArWXJhUFM4?=
 =?utf-8?B?eHVMYnFmSzVHY1I3MWxDci81cFJaUFAzSnJ0RjQrb01NU3VVNmE4WXgzZW1Y?=
 =?utf-8?B?NitOSGhPM0dCdzFTenJzRlpRR2lMY0pTT0xXM25pVExiS1A4K0ZmeGRNNmVL?=
 =?utf-8?B?QXZZTWtUc0FLRFpDZ3RjY08rYWpxVndhV01kWVZLL2YrZGcvcTZUa3lPdFJj?=
 =?utf-8?B?MmhqRncyYVNlLzZsa25rZXRxSzQ3L2Jqa3kxNDNKK1BZQTU4aXNYVDh6cTJF?=
 =?utf-8?B?WkJOM3FtT2swTHJwOEFpbGR1YVJBckh0S0hZTXN5TDg4ZFhibU1QajYzK0JG?=
 =?utf-8?B?VnlxM1VXcFVLdVc0dkVuSzZyWnBxeG1JWDAzWjdic2tablpDSmdST21iL3ph?=
 =?utf-8?B?cnBxNW5wWmJFSkdmZXhHckRmd0t0akRUQXhCeEk0NXluRDEwS2k3dmovdnJN?=
 =?utf-8?B?eG14S2xRcTQ3MFlCcDY1T0kyYUlVQTlBYTNNN2ZCZWFNVnJ4NEtKU1R4NXh0?=
 =?utf-8?B?NkhlQlhBQ0xvSmx3WDRXTnR6c1JLWDZZaUFaM3J4NFdZQ01QdE1RZUdtR1Js?=
 =?utf-8?B?NURwbFZnOVRXMXpoU2tKWGN0dGdEcmdiRVk4YzJFTHZhZzJxZ1lmYXluVlZP?=
 =?utf-8?B?aFBmVm9LME04QWx0SnF1WW5HQmRmSmREbWxTWitsQk5VTkdUVVpxQ0k5aWhH?=
 =?utf-8?B?Z2lINDMxeXM0SnlYRi8xR1A3UzFqRys1eWtaRERzalpDQ21zOVF5NlNEMldo?=
 =?utf-8?B?QjFOWm92QnNwb2d5bGxkV3BGSWJaZytXRXFjNUNHUnRqRkVHMS9Kd3k5eEkz?=
 =?utf-8?B?NWpxcWs5Ni84NFJxQjVHM0NDVVJnMVYyeWlGbzdNNS9YNGFiV0FaTkxNb1Fq?=
 =?utf-8?B?eGNZckk3WmNteHBUNEdzT3BMRFhHVy82cWZvS01BRjBlcjlvVXBSSFFMclJT?=
 =?utf-8?B?c1pvUnVTY3kwMnl1S0VMSFpDTkd3ZHI2cnFQbnJXdUNNUzVGS1FrOTQwZTBm?=
 =?utf-8?B?dm8xRncrNkJaNC95VEdidTNxbkdhbXRsUFN6dDNJc2VNYWJtS2VkYm5kZlU1?=
 =?utf-8?B?cXBVZlVMaXZ3cW1heUFvODJ1aTk2eHhvZEVMMU1Dek0yYksybG0yZk50MG9N?=
 =?utf-8?B?N056WGREWXhNNEkyTUVZVzN4Q2VNQUV1RVhjYlR4MGROa3ppN3RjVTRtN1hH?=
 =?utf-8?B?Z2FYUWszSGtaOVpvVGRiWjBXWm9CL1dGSTJpdlJHWWdQckFRQTVTS2h5cVI4?=
 =?utf-8?B?U2dIaTFCanNLTjhySTdHQlBEL2JTMzQ3UURUS2hoSGY3S01ldGNuaVA5RStw?=
 =?utf-8?B?aUx0a2VaaE5DWkppbDJHMDUzYTdqbktkMytZWnhmVnhla0tFdDNYWUs5NUJs?=
 =?utf-8?B?NkZOOGs1RTlhQ3Z1MjFuU0ZTc2h6bjJyQWhEcFpJMWsxV21MQWVvWFRxYUVk?=
 =?utf-8?B?bUl2UkFqa1pnTlVEc1F2R1c0eUpMeWhudTM1UWVpT2JkdWt2Wnl6QlVhOFFm?=
 =?utf-8?B?cCtiY1dPajRIbnpqYm9LRlg5aXVCNkZ3MVFvU3lBM0tRQ0FMSUdxQjFPenlo?=
 =?utf-8?Q?DPi4aEUemGUxnrEB93rm5GqcM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd4cdd0-7439-4cd0-3249-08dd9263119f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 21:13:55.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vTKPhO84glvHxGWTCPxYtmGe4ibVjDbDEAVeZm3LkzcROEVkNRuCKloyaCrIf52l9ta7UDYZ2tCuU/iVYYqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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


On 2025-05-13 17:01, Alex Deucher wrote:
> On Tue, May 13, 2025 at 4:33 PM David Wu <davidwu2@amd.com> wrote:
>>
>> On 2025-05-13 15:29, Alex Deucher wrote:
>>> On Tue, May 13, 2025 at 3:01 PM David Wu <davidwu2@amd.com> wrote:
>>>> On 2025-05-13 14:40, Alex Deucher wrote:
>>>>
>>>> On Tue, May 13, 2025 at 2:23 PM David (Ming Qiang) Wu <David.Wu3@amd.com> wrote:
>>>>
>>>> V2: not to add extra read-back in vcn_v4_0_start and vcn_v5_0_0_start as
>>>>       there are read-back calls already. New comments for better understanding.
>>>>
>>>> Similar to the previous changes made for VCN v4.0.5, the addition of
>>>> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
>>>> prevent potential race conditions, even though such issues have not
>>>> been observed yet. This change ensures consistency across different
>>>> VCN variants and helps avoid similar issues on newer or closely
>>>> related GPUs. The overhead introduced by this read-back is negligible.
>>>>
>>>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Maybe split this into two patches, one for vcn 4 and one for vcn 5.
>>>> That will make it easier to backport to stable.  What about other
>>>> VCNs?
>>>>
>>>> will split.
>>>>
>>>> This applies to those VCNs where regVCN_RB1_DB_CRTL is used for setting doorbell index, which
>>>>
>>>> means VCN 4 and up - all of them are covered (similar code is already there for those not in this patch).
>>> Sure that prevents the doorbell from getting missed, but what about
>>> other registers setup in the VCN start() functions?  What if some of
>>> those are still pending when the doorbell is rung for other VCNs?
>> I think adding a read-back is needed if there is any concern about race
>> condition.
>> If we only concern about start() it should be easy to add. The question
>> is how we will know there is
>> a race condition. Adding read back everywhere when missing after write
>> is not a solution I think.
>> For any VCN functions we need to check carefully
>> (eg. vcn_v4_0_unified_ring_set_wptr()) in case it adds too much
>> overhead and actually not needed (at least haven't seen the issue).
>> Any suggestion as to where we should add or at the moment for _start()?
>> I can work on it for sure or leave it for
>> future improvement.
> I think _start() makes the most sense because it will only be called
> when we power on the VCN instance.  As long as work keeps coming in,
> it will stay on.  The race is theoretically possible on any VCN
> instance.  E.g., when the first VCN job comes in, VCN gets powered on,
> and then we call _start() to program what we need.  After that, we
> ring the doorbell to kick off the job.  The programming sequence in
> _start() could still be in flight on the PCIe bus when the doorbell
> gets rung.  Which is apparently exactly what happens when we hit this
> issue on VCN 4.x and 5.x.  On VCN the doorbell gets ignored because it
> races with the doorbell id register, but on other VCNs, the doorbell
> getting missed may not happen, but it could be something else that
> races, e.g., ring size.
well - right. For production we enable DPG which is now protected.
the other register write at the end of _start() is for non-DPG case.
I can add read-back there just in case.
I guess for other issues/potential race conditions we need to investigate
case by case. Sounds OK?

David

>
> Alex
>
>> David
>>
>>> Alex
>>>
>>>> David
>>>>
>>>> Alex
>>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>>>>    2 files changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> index 8fff470bce873..070a2a8cdf6f4 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>> @@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>>>>                           ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>>>                           VCN_RB1_DB_CTRL__EN_MASK);
>>>>
>>>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>>>> +        * it may introduce race conditions */
>>>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> index 27dcc6f37a730..77c27a317e4c8 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>> @@ -794,6 +794,10 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>>                   ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>>>                   VCN_RB1_DB_CTRL__EN_MASK);
>>>>
>>>> +       /* Keeping one read-back to ensure all register writes are done, otherwise
>>>> +        * it may introduce race conditions */
>>>> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>> --
>>>> 2.34.1
>>>>
