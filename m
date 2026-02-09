Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402BAE7E0BC
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 17:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C2010E43C;
	Mon,  9 Feb 2026 17:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBbicHt8";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD8A10E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 17:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGx+N0t8xxZGowd3DamNWOPKtnuRrPIelxFuErweecC1dqNN7nZ7K13NQApc+JPxG5Sldkb/Gi8Pk5Rriepbn0vICPeA2lo7TaVwLDjbG7PyxCiDX9DexSVDtp+S3CBDW9p/FIjCNSDBW5fHXB3rfwBUgbf4GjsZowtiUqd6RUZM6hn3fhGnIX8qgftObLnUIJOstsbJ8gKNA4TzmaA+MtFqMFAzER0E+1mbHSbyd8BWANQniEISc0XTD4Mh+Mt8tFGjhpENkb8akGYCn44m3OTiNiuYeFlVGmlk8RkcnNR7aVllKTVWaX7UVSy5ywD+zIqzbvbPU0TRkOQYvKoZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYREz0X1+1mq06nKssjg+xLCR16+6Bk6jlQVoXYEfKE=;
 b=rdLQCSahCfwbKvBlAI03UBrN843QryCotDXV8zVXFfAEbr/m9AkisXPPu1AjeaM9YeSxx/ZZQVgroU4JUtQGX5YDeyTCQu/74p4/tXy1BImFN6eDj6XT6Mn8x5iMFz+fujTkcL8zFyNrS0CInLW4CiKEn6oEWtQl2CX/0RZ3EovVWUvJ4M5wLRFvwYaccT1DkNcEJiRxSjxEDN98+LbHXIv6AupKK9Sz3gjwVx5kozvF68lsSHd234fBqd4K6K1gmFRBMefH+I1RBN1Gq6C/Z+NxJjcw+Cxrjv3PoF9gHfOD7X5MInhw0YX8pXZz7lIiSZqp6S4a9bXOrRhb+dUGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYREz0X1+1mq06nKssjg+xLCR16+6Bk6jlQVoXYEfKE=;
 b=LBbicHt8PDO04Gg0ZJ+cShezCZOnZr4qnYyhm7SnZwONyHbDsXDsVBV1YEc/ayExRsO7A9gHEjdUq9xkqDCvl1Ia9YHU6Gu8E/WXKuIacvDiGacILooL2oVRXydGVNQRCGGk6B6CROV84oAsJks4VeQcGCibHfTh0Ta3tiIMF5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 17:21:40 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:21:40 +0000
Message-ID: <a6038bb6-d180-49e2-b063-6a0135f13648@amd.com>
Date: Mon, 9 Feb 2026 10:21:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-5-timur.kristof@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260118173150.19790-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 25df67b3-6aa8-40d7-ab75-08de67ffb00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlpVSG1VVUgydzgweGJHeEZZcjhmcHQ0Z211VmVOM04wbjZjTVh5TC9OZ0Rl?=
 =?utf-8?B?SGV6YXQ5b1NBUWI0endDN0RFUjRKZkhPQWtqWW5aRTN2VDMzR2NpVmx5OUY1?=
 =?utf-8?B?TjhVOFg1YklpS1lzUlNsZ2ZEbDkxWHVHWjBOUnNzMFNGWHZVVFJmZ1R5ZkdF?=
 =?utf-8?B?QzUzNVBvbUxYcGZmdEhXbklhY21aMzhMT1hveXZJY1VOQlJjbEU1ekprekFB?=
 =?utf-8?B?blY4Ukp6SDJNaENtNFVzd2tUYjBjU2JNRzhmbkxXY3IwcndIY0xqMVROTGdq?=
 =?utf-8?B?cjA2K21LTXFIT21YeG0yWndrb1UvNXBZRk1pN0lhYXJpZzRiZDNqM2o2Z0lo?=
 =?utf-8?B?SGZzSjVZV3Z4LzQ4ZXpWUW5wdUFYSjVEd1R0eTJrUHlpZ09McnJQTmZrNzVN?=
 =?utf-8?B?OTlkZnpROG1SdHdwVW9CamxSQ1ZwSmpVdEJwNFZkanAxYnNNRCtmVHVoa09W?=
 =?utf-8?B?R0lOT25PK3lGb2d0T3VBZlgvYnc2bnpoNEhPVmpJWlRodjE0N1JJNkFEaFNT?=
 =?utf-8?B?b1FMT20rRzF2SXNzbjhVOW1CTVhraGlsQnlKdGg5eDJvSlBNYXRKOHBCd2gr?=
 =?utf-8?B?YjlyOEJTVTB6TWwwKzQzNC9URjhPVEFxYjNSRWIxQUY1bTl6NzJ2NzdqOUxF?=
 =?utf-8?B?eTJZOXpwb2JGbzQzRkVhb2t2a3diSkdJZnI2WDFmUmJseGxndWhuZ2FFeG13?=
 =?utf-8?B?L3hUY1RCOWY5dTdoRlp0T0xsQnFwampnUDJRdVpGQ3dncUZsdEt0STh2WUlr?=
 =?utf-8?B?c0U1eWExeFdZUzltVDhOalV1bGZNR05uNU1rWkJURzM0N0ZLYktUQmY3N01M?=
 =?utf-8?B?dWxoMVNzQkNnWHcvUHV5a1NwdU1NMTc3KzNBU3VwZ1V6ZzMxUTFtajNOMDA3?=
 =?utf-8?B?bGpCcktMV0x2a0xIR0NlYzhrNUx3cVc0UGp3blFUL255Q3dob0l4WHg0NUFn?=
 =?utf-8?B?aWRyVm1lWlJUbWhVNE8xR0JyaHRnMVdJVlp3UWg1UjhoTWJPUDAxZnpVTkRP?=
 =?utf-8?B?N1lIRjlQRmJUNFViNkNubmhUMndjN1lzanZTRGluMGdldWJ4Yzg1dFdBUE1K?=
 =?utf-8?B?Y0M3SG9HaklYdEdSSzlBVUNETXpZdWtOTlBkamxxWk5rbU9vWlRPczQyU1hX?=
 =?utf-8?B?d1FycGliSjRTcUlEelFlY1c3VnhwRWxnUjRLdXROYkFCK0JoclRwVFd5SXJw?=
 =?utf-8?B?ZHI5ZVFTR1JHcU5FYUduSmdmNnAxd0lhcWdYNkRZWHlTZTE3d3ZGU1VLZjRJ?=
 =?utf-8?B?MUMwQ0k3Y1FSWnBRWm5XZjVhdHlhemU0VHR1dHU3Qm00UEZ2VWhIT085TWUx?=
 =?utf-8?B?YURNTmtrZWh6TmxIVlBsMUEwMGhaVzFRbmtiSkpUdXhPREhnd0ozVVlVYmJp?=
 =?utf-8?B?eVkrbWd0VGZnYUlqYWVtZFMyRU5XbDJpTDE0cjlQdEV2VERKdUVNWWM5SUFH?=
 =?utf-8?B?KzBMblY3Vm51NjFkRXFZLy9XRUZuSUx1bzFocXo4VnRLaWt6dXp4NDBrZk1M?=
 =?utf-8?B?RGxrMTRFaWhTdWdqZEV0ZWRkSG5STFBYUnNiUFFVVkZCUSswU3hUMmlrbW40?=
 =?utf-8?B?ZGdkdW5ISEZjM0R0ZnRKUGViUVRTUCtPY1VGUk5BMzVna3RKalE5U212amJS?=
 =?utf-8?B?TTgxNWNtM3hlOFFKUUUxVDF4dEMzSkpzWkxtMGhsODFMdVBaUldKbUx1NVdC?=
 =?utf-8?B?VUE3Z0FIYjJDcGh0NVVUYVJ1WCtZRzlxTXJUb2hoekxJamt3YTl5L2grbW9P?=
 =?utf-8?B?Zlk2UDVnRDk3RldjVnIvdWFzaUtDd2FoVnpVV25Oc3RYbFVXcDd0dHFnVUNo?=
 =?utf-8?B?cjN4UGwxY2V4Y0R6NU0zaUlBZStJbnd0Y3BNcnV2c3RMRUhmc0ZRRTNodERF?=
 =?utf-8?B?RjR4bC9rS0piL2l0QXpnZmZBYnNmalVQcUZzKzJnVElVa29qRzRDY2pDVnlv?=
 =?utf-8?B?Z2lIZDA1YjF2QlpNZE9BS2pQZkZuL0FqRjdBdSt5UTAyZ2VCZWtlT0Vtbllh?=
 =?utf-8?B?V3FUQ1VtakJGK05kc1ZpUHlTeVBvRjAvRXdVTlRBQnpFR25LbUpDUndoVWZw?=
 =?utf-8?B?cWRzNlkrTWF5SCtNZTJLc1ZMVEsrNmMyUUUvcUJDZFJqQXBFMWhEaEc1RWU2?=
 =?utf-8?Q?3gk0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vis3V0tDMXJITHprb3oxWm5KMnBpQ1NCc1JmQXRFTElrOWcrY2cwdjRaUTlZ?=
 =?utf-8?B?eWpSNGkyNU1ZRGZOMUV3MkZYVVYwdFhlNFVvRmN3VmNCUUVxaXVGS01Cb0lL?=
 =?utf-8?B?V3NqR3VmWU5WMEZ1MnlLVlQxVlh0QVN1TUZKRnk5ZmNMaU81NWQ4dDFtNjlL?=
 =?utf-8?B?ZTJxNlRmTlZOMEZhZ0pkWDA2K1pteGdiV0Z5blhCTUkzQlprUzl5aGNsc0Jt?=
 =?utf-8?B?bk5Tc0N3Sk5YOEpSYjIvbWlmdk1zOHF0dlRlRnJQRXZQbXdYb0FidHNxeG5l?=
 =?utf-8?B?RGdnVmc4NGowd3dIWkZYSHE4K0Q4THRuQ3lXTnRBODFYL2xuWFFERjIxKzRS?=
 =?utf-8?B?c1plZTZaMlhndk1vOS9PazJ4Rllra1FZWEZsODhETTRJNkJEODZueWwwc1dI?=
 =?utf-8?B?TnlzMjFjT1BzbFphMHM1NDQ5Mk1tV3I5NUQrS1d4RHdUV2x0aUZNRlJXMXpw?=
 =?utf-8?B?UVVXOENHK3pYL1VWZWpQUVdzeTBibklnNHZYUEY1SkNuVEs4ZUZoWVhFYzIy?=
 =?utf-8?B?bXlUdHhFTGcxdTBFOGhiTS9PVU56N0JZYTRSZ0FqbmpiM0hKcWdYYXY2cy9p?=
 =?utf-8?B?cEFNemh0WVNuYnlNdXB4a3VaVDFsKy95V0tnN01TVUtrUDN4c2U0aWtsTEk5?=
 =?utf-8?B?RTZjT215MGRVMmZwVXZ1bDZCclUvNDJOQitqU292aXRSVTh2bEc1NW5zNTNj?=
 =?utf-8?B?V2dzM0RnVjFjNU1VVktiL1VnUTI0RUxuZXppRnppcGFZNVQxRkdCRUxXRHo5?=
 =?utf-8?B?ZG1YU3oyWEdrK21zN1lab3FnbmUvVk0xajVWT2s4bVorclBodThnVXlNbUxp?=
 =?utf-8?B?NnFOYUorVENwRmJHYXZYc2hiaFJuUHdlUWY1RGlReXFJU1I2THdGaTNBdEhS?=
 =?utf-8?B?azV0VVNycnFMRmV6WW5LcC9XdlNWNXk2S1oyVzFoM1M5Rmk2eFRYTU9TY2Z0?=
 =?utf-8?B?R0NBbU9JMEc5VzJ3ZU95cEFFODAvYUxyTU56VWRjOS9ocFVPdUxrNTZjRGN6?=
 =?utf-8?B?MVpVLzNEUU12ejA1U2dkRWlkc0JXdFhlejZKM2xSbmtpZDQyWGVkWlN5cVl5?=
 =?utf-8?B?UXoyRDhlNlFZWFBQZThlYW5ibmkwTzByZ0Y3STVBOFE3aE80YWhYNWlrb2l0?=
 =?utf-8?B?dGkxZ0dwQ1hIVkMxS1pKYkxxWkFLaFk1bGxudjBvNzFyZHJIYW9wczlJV1RN?=
 =?utf-8?B?RW5SWEVrZm5IdlBoTEpzM29ySFJGY3dDWGRUSUpxYloxRGVMRnVDTXJRN25M?=
 =?utf-8?B?eWRMSm5PRlZzTVJSbE5Oc1hSUG5DMkVnOUhVanB1WjhPWDBSUks2WXAycFdy?=
 =?utf-8?B?UlVzVzFPOGQ3MXlCQmRBNkN5b1pnQ0x6STRmSnJQT0tCVW9oSHBTVDBJekxa?=
 =?utf-8?B?ZngwZVkyUFEzTThFR1NZaDBobjhqT1BuMlcya0NmM1l3SU0xMUo4S0IvRU5M?=
 =?utf-8?B?bFFHcFlUQkNHT2dGRndiWFM2WERjOXlxdk1QOXd3VHNnbU9TYXBhZ0pmd3VU?=
 =?utf-8?B?WlVLRlBrdkptMVZtY2tZUFJBR0ZTdld0VTd3dDQ3dzB5bWVYMEQwSDVsRklt?=
 =?utf-8?B?M3FweEVNYWNNZmhOSjF5Y2VWL0hqWUhsS1diTzRkOFF5RkpYdlY2ejVDUWMz?=
 =?utf-8?B?YjFDQnpxSCtENWhoZzZBN1ZISmF3Ry8rNVhqa0FEcHhDSTJrMnZDYVNDZnc4?=
 =?utf-8?B?VVFTdlY3MFhkYUpMeWZING1YNUo4bkdwemxIVTFsa29wTVZiVXUzbDJwOHBU?=
 =?utf-8?B?T2sxVmlhanRCVW44MWZaYlZ0OFYzV0FySkl1WUdrak1nUTdsWDU3NnRWZ0pX?=
 =?utf-8?B?R0JsZGVWWXhnaVl4N3NUT0ZFcmtwMTg0cTd2a2hoeVBVUVVzWXFBbDJFSzE5?=
 =?utf-8?B?STNUWUw0K1BuVlBZMHNVOXBWbkxWK0VQb2gxWXBCc3B2WnhxYnJoL0lPRjU5?=
 =?utf-8?B?QWZHOXlINGFxdy9oY0h5aVhkdkJTaGVCenVMYnZNSlI5RFJsbkxOM24wVDZ1?=
 =?utf-8?B?bkRnN20vYWFzTmExMFhRSDlLSjNiQm1FdmQvMjJVL0w2T3lzTWRWTWdMQTM2?=
 =?utf-8?B?MGJyWGZzdFRwUTNDWEY3YTVRZmM2T1BvYitnM04yV2cwYnJ2WldhNmdzNmV4?=
 =?utf-8?B?V2VtY0tBRzA5RTZwQ2ZSZGhOWjQwZVRpbHNWZDdOd0pTVUxtQWx0b0h6MFJV?=
 =?utf-8?B?eU9Qdi9xTlFyaWNjSEQ2Z29zV0NIREpEdklMSzlsaFJyWWJmbzlVbVNGUnlT?=
 =?utf-8?B?VkVqV1EzUS9sZDRRM2Q5WkhsM2FLWkg5MFhhZW1tSVVUNHQzME9JSDNnM3I5?=
 =?utf-8?Q?1y5EiMK8cLF43JvrVk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df67b3-6aa8-40d7-ab75-08de67ffb00e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:21:40.3150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG+e8KqMTh8i8B92T6yHhorS+atrCso0D7ktfdU0ZsorPJnfpdXwBhNoXJNuN9ubxsizpOediEu6KmKtbhyB6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

Hi Timur,

I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI is 
not set, or with the following change to Makefile. Can you check?

diff --git drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile 
drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 60021671b386..57d492b90986 100644
--- drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -30,17 +30,6 @@ AMD_DAL_CLK_MGR = $(addprefix 
$(AMDDALPATH)/dc/clk_mgr/,$(CLK_MGR))
  AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR)


-ifdef CONFIG_DRM_AMD_DC_SI
-###############################################################################
-# DCE 60
-###############################################################################
-CLK_MGR_DCE60 = dce60_clk_mgr.o
-
-AMD_DAL_CLK_MGR_DCE60 = $(addprefix 
$(AMDDALPATH)/dc/clk_mgr/dce60/,$(CLK_MGR_DCE60))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCE60)
-endif
-
  ###############################################################################
  # DCE 100 and DCE8x
  ###############################################################################


On 1/18/26 10:31, Timur Kristóf wrote:
> dce60_clk_mgr was basically identical to dce_clk_mgr other than
> a few minor details. They can be all handled in the same file,
> reducing duplicated code and easing the maintenance burden for
> old DCE versions.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 ++++++--
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 142 ------------------
>   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -----
>   4 files changed, 52 insertions(+), 202 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 15cf13ec5302..9206eb8b0365 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -34,7 +34,6 @@
>   #include "dce110/dce110_clk_mgr.h"
>   #include "dce112/dce112_clk_mgr.h"
>   #include "dce120/dce120_clk_mgr.h"
> -#include "dce60/dce60_clk_mgr.h"
>   #include "dcn10/rv1_clk_mgr.h"
>   #include "dcn10/rv2_clk_mgr.h"
>   #include "dcn20/dcn20_clk_mgr.h"
> @@ -150,16 +149,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>   
>   	switch (asic_id.chip_family) {
>   #if defined(CONFIG_DRM_AMD_DC_SI)
> -	case FAMILY_SI: {
> -		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
> -
> -		if (clk_mgr == NULL) {
> -			BREAK_TO_DEBUGGER();
> -			return NULL;
> -		}
> -		dce60_clk_mgr_construct(ctx, clk_mgr);
> -		return &clk_mgr->base;
> -	}
> +	case FAMILY_SI:
>   #endif
>   	case FAMILY_CI:
>   	case FAMILY_KV: {
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 6131ede2db7a..d02d03c154b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -62,6 +62,18 @@ static const struct clk_mgr_mask disp_clk_mask = {
>   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>   };
>   
> +/* Max clock values for each state indexed by "enum clocks_state": */
> +static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> +/* ClocksStateInvalid - should not be used */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> +{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> +/* ClocksStateLow */
> +{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> +/* ClocksStateNominal */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> +/* ClocksStatePerformance */
> +{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
>   
>   /* Max clock values for each state indexed by "enum clocks_state": */
>   static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
> @@ -126,8 +138,25 @@ int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_r
>   	return dp_ref_clk_khz;
>   }
>   
> +static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> +{
> +	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> +	struct dc_context *ctx = clk_mgr_base->ctx;
> +	int dp_ref_clk_khz = 0;
> +
> +	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> +		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> +	else
> +		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> +
> +	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> +}
> +
>   int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>   {
> +	if (clk_mgr_base->ctx->dce_version <= DCE_VERSION_6_4)
> +		return dce60_get_dp_ref_freq_khz(clk_mgr_base);
> +
>   	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>   	int dprefclk_wdivider;
>   	int dprefclk_src_sel;
> @@ -441,27 +470,37 @@ void dce_clk_mgr_construct(
>   	struct clk_mgr *base = &clk_mgr->base;
>   	struct dm_pp_static_clock_info static_clk_info = {0};
>   
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce80_max_clks_by_state,
> -		sizeof(dce80_max_clks_by_state));
> +	if (ctx->dce_version <= DCE_VERSION_6_4)
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce60_max_clks_by_state,
> +			sizeof(dce60_max_clks_by_state));
> +	else
> +		memcpy(clk_mgr->max_clks_by_state,
> +			dce80_max_clks_by_state,
> +			sizeof(dce80_max_clks_by_state));
> +
>   
>   	base->ctx = ctx;
>   	base->funcs = &dce_funcs;
>   
> -	clk_mgr->regs = &disp_clk_regs;
> -	clk_mgr->clk_mgr_shift = &disp_clk_shift;
> -	clk_mgr->clk_mgr_mask = &disp_clk_mask;
> -	clk_mgr->dfs_bypass_disp_clk = 0;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		clk_mgr->regs = &disp_clk_regs;
> +		clk_mgr->clk_mgr_shift = &disp_clk_shift;
> +		clk_mgr->clk_mgr_mask = &disp_clk_mask;
> +	}
>   
> +	clk_mgr->dfs_bypass_disp_clk = 0;
>   	clk_mgr->dprefclk_ss_percentage = 0;
>   	clk_mgr->dprefclk_ss_divider = 1000;
>   	clk_mgr->ss_on_dprefclk = false;
>   
> -	if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> -		clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> -	else
> -		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> -	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	if (ctx->dce_version >= DCE_VERSION_8_0) {
> +		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> +			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
> +		else
> +			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
> +		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
> +	}
>   
>   	base->clks.max_supported_dispclk_khz =
>   		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> @@ -469,4 +508,3 @@ void dce_clk_mgr_construct(
>   	dce_clock_read_integrated_info(clk_mgr);
>   	dce_clock_read_ss_info(clk_mgr);
>   }
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> deleted file mode 100644
> index 1fdf344efe1a..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#include "dccg.h"
> -#include "clk_mgr_internal.h"
> -#include "dce100/dce_clk_mgr.h"
> -#include "dce110/dce110_clk_mgr.h"
> -#include "dce60_clk_mgr.h"
> -#include "reg_helper.h"
> -#include "dmcu.h"
> -#include "core_types.h"
> -#include "dal_asic_id.h"
> -
> -/*
> - * Currently the register shifts and masks in this file are used for dce60
> - * which has no DPREFCLK_CNTL register
> - * TODO: remove this when DENTIST_DISPCLK_CNTL
> - * is moved to dccg, where it belongs
> - */
> -#include "dce/dce_6_0_d.h"
> -#include "dce/dce_6_0_sh_mask.h"
> -
> -/* Max clock values for each state indexed by "enum clocks_state": */
> -static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
> -/* ClocksStateInvalid - should not be used */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> -{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
> -/* ClocksStateLow */
> -{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
> -/* ClocksStateNominal */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
> -/* ClocksStatePerformance */
> -{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
> -
> -static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> -{
> -	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dc_context *ctx = clk_mgr_base->ctx;
> -	int dp_ref_clk_khz = 0;
> -
> -	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> -		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
> -	else
> -		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
> -
> -	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> -}
> -
> -static void dce60_pplib_apply_display_requirements(
> -	struct dc *dc,
> -	struct dc_state *context)
> -{
> -	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
> -
> -	dce110_fill_display_configs(context, pp_display_cfg);
> -
> -	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
> -		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
> -}
> -
> -static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
> -			struct dc_state *context,
> -			bool safe_to_lower)
> -{
> -	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	struct dm_pp_power_level_change_request level_change_req;
> -	const int max_disp_clk =
> -		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
> -
> -	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
> -	/* get max clock state from PPLIB */
> -	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
> -			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
> -		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
> -			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
> -	}
> -
> -	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
> -		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
> -		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
> -	}
> -	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc, context);
> -}
> -
> -
> -
> -
> -
> -
> -
> -
> -static struct clk_mgr_funcs dce60_funcs = {
> -	.get_dp_ref_clk_frequency = dce60_get_dp_ref_freq_khz,
> -	.update_clocks = dce60_update_clocks
> -};
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr)
> -{
> -	struct clk_mgr *base = &clk_mgr->base;
> -
> -	dce_clk_mgr_construct(ctx, clk_mgr);
> -
> -	memcpy(clk_mgr->max_clks_by_state,
> -		dce60_max_clks_by_state,
> -		sizeof(dce60_max_clks_by_state));
> -
> -	clk_mgr->regs = NULL;
> -	clk_mgr->clk_mgr_shift = NULL;
> -	clk_mgr->clk_mgr_mask = NULL;
> -	clk_mgr->base.funcs = &dce60_funcs;
> -
> -	base->clks.max_supported_dispclk_khz =
> -		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> -}
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> deleted file mode 100644
> index eca3e5168089..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/*
> - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the "Software"),
> - * to deal in the Software without restriction, including without limitation
> - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
> -#define DAL_DC_DCE_DCE60_CLK_MGR_H_
> -
> -#include "dc.h"
> -
> -void dce60_clk_mgr_construct(
> -		struct dc_context *ctx,
> -		struct clk_mgr_internal *clk_mgr_dce);
> -
> -#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */

