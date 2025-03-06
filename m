Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E600C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC10E10EAA2;
	Thu,  6 Mar 2025 20:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lt4eD2Ky";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572B210E11B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:13:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCwZZ7m0HZLhZYoMF5yXXxHYxVqhR0YTI5MBrzzIRIj1gf5FPqijcwfBxwvKk3aEXrS/dONnpDbQ92jZv7cQrmpoSSaWHmjc/7ZOfrQcB2Bf4Tro0D3us3Mfp14qCjFWFQQxm5okb3cHiKWvTOtVsT9TydcZBFOvAuWrf4Mz9dz99rJVvralD04LW7m6lszVDXVqL3RYzm/ZVILSYckQykAZb5FOhJr7A6ZuzhoaFFqW0GRMurIVOfY7fZgWSAsJIpeUtv2NikD97iHMtzwuj9zEvn6/SFP+dD2P2Nyzf5+EY805y93yotU87njG/ittwFPPNMSWe+BY6kQSHNhQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYv2vIeko4XPLLkvRaFVu4qxDalzi4fgkWBzqOmvG3I=;
 b=wpODZHEcXILH71WJ/dOx3TEIp3KN1SNO2tYdiRMr31Z/vWdwSH7fheV9/yz++L6A78EL5eEiH5gSBqbJWYh6OtRlIziU5ciHyDysHwqIcHgMhM2CugoD6PyXT4YO6G91YqCEkjnBBsCY/tIVDjHsxxBfdrhIs3vccer+CwJ16TYNbfJO5420umQibggaJXb4K4UZQFsjvHQB8D5HGDQsYVg7s/AVPcOEVIYv0FCGB3b3Og5005vg/7tR/Ktj4rKIyUrkHyGyMXg0aQQSK34zF/FSGq/ypkxo8npZquuY9mUI7bO3P8pgUe2Gurry5yiocGD7aehUjBnNy0VTKWnB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYv2vIeko4XPLLkvRaFVu4qxDalzi4fgkWBzqOmvG3I=;
 b=lt4eD2Kyf6BKw8koJWdTNg8XTKTZd9w5mj3du+vQJhKvhGyqKvkvHSGjCw2ldbKtCXf/VlyZeXnHgkR+lGFWYUdxNVqcofF1cgAlfYEolyFJcMBA+yfOSTBJDb5L8SRhYAJDhUHCGpE9eotWwXTZ816zN7ovDwVa+x/2oM85I08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 20:13:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:13:32 +0000
Message-ID: <a586ea64-b3b8-475e-a033-b1835fe4d276@amd.com>
Date: Thu, 6 Mar 2025 14:13:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Fail initialization earlier when DC is
 disabled
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250306185752.50871-1-mario.limonciello@amd.com>
 <CADnq5_NUZwNK_h05mbAD7iba1JjDj=CtQ5=fRb_0VDpgaFzG6g@mail.gmail.com>
 <858ce1da-673a-4cef-a1d3-c062a9ffa64c@amd.com>
 <CADnq5_NooJigP55UB6beFRSa_n3bnk4Sy8za1BvQ_sRg2Ta3Ow@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NooJigP55UB6beFRSa_n3bnk4Sy8za1BvQ_sRg2Ta3Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0085.namprd12.prod.outlook.com
 (2603:10b6:802:21::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1984ff92-b7c0-4fce-9fef-08dd5ceb5df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R200OXN0blRjZElkS1FnU2dNVEpldWV4blltaHNPQTNKbllHYjBraG5YNE4r?=
 =?utf-8?B?QU04MXZpNFdQU2dtQ2twYkszeVpzT2I0Y25sVXJrUEdzR1k4TnpJcjVZNWRu?=
 =?utf-8?B?eWZ6L1EzcWNVWFdGbjR5TTUzRzZLcWphNDc2YTNRa09KMC9oUCtkbWpJbmtr?=
 =?utf-8?B?T0R2amk4SzRSNVU0dW9wMzd5TVFteHZYMmJOYlFDb25KR1o2QTZ3TGswYnFi?=
 =?utf-8?B?cU4vMk8ySlBXUTZCVWE3Sk9ULzQ4VHYyMHVQTTVheXlocXhhUC9KVkFzcmVQ?=
 =?utf-8?B?QVdwc1g2UWhZdkhNWE5OcmFrVXJwRzNqc1VpYzJjQkVwYnNjUU5ESEE0VmlJ?=
 =?utf-8?B?ZkxVMHp1YnBZaEplbEtBVWxqaUxYd0c0OEVMb0ZBNUpGM21Nc29SWDF6cjcr?=
 =?utf-8?B?SkIvWFpmanhRb0VLQngwQjgyK3gxclVzbmdyeE1XZDd4bzQzQVlDYmZnWFpX?=
 =?utf-8?B?bW14UHJVbU0wSTFIa1dTQUhlNnlGMERBMWFJcVhyNFYydWtCVTR6cnNHZ0pG?=
 =?utf-8?B?M2ZDNHNMY2dZSDlPV0Q1Z25qMGE0NVVyb3JXQndNbFFORDdXdVVqVlBTRlk2?=
 =?utf-8?B?eEdIYXNXUWU2Z2tnUjJXV2w1dXc1c202SnNXTzZFeTlyalFpekpTWGlSMWpP?=
 =?utf-8?B?SEhZRno2a2l0OWJJbTNHRFFQa0dJVUZRUjJBc3k3NmtHam9XaXlqMlFzNUk1?=
 =?utf-8?B?VkVQdmlRYk5LMWtxeDROVVJFWHFzdWdXb3dSWUxRN3l1WjdPS1RHcC9OYVhO?=
 =?utf-8?B?bERDNEVvYVBIb3h0WXc5bW96ZnVCUWlmbmdXY2krM1IzVUUwMVZDRDZSLy9o?=
 =?utf-8?B?UTllNnlhaDV5M2w5Y0lPRTFvaXVEZWk4bG5kV1AvYXZFQ0NiK1ZxRlM1R01J?=
 =?utf-8?B?eFhtSnpuMElVQWJ6M1BjZGVNZmFFRW82Z2FZNld6MjFPZFhIdXMwRWtlT3FO?=
 =?utf-8?B?N2RKWVgvRzZia09MTmFVUFR4SG5NQW40S0RZODArSzVnTG1WREFOUndjYlpS?=
 =?utf-8?B?d2o0dGx2eERkNFhRZkRmcGNmSlN5N1EzUjNyTkJNemtsQ3U0bVRzNlRsa2lh?=
 =?utf-8?B?MDJZRnNxMDEwYzhuWTlVd2t4VmJjQVJ2UG5jMzh1QW0xTjh1OVdyMzZ5bmUw?=
 =?utf-8?B?SHRMZEFCL3lUdERPRUZpUHowN0xKVGlmdWhPWUZNcDZtbEFnOHFRNm1XOEMz?=
 =?utf-8?B?YTh2NXdjaVMrTXFQRnBKUndBckZDQUc4S3c4bFlLK0FoblRVQlFlMEpveUhM?=
 =?utf-8?B?SDFhbGNtNDR0ZVRDZXdyTHRiaDNuc0d0NU5BYVhzZnh5b1ROamZKa0llV2tY?=
 =?utf-8?B?OHFSeXFNZzVTNTJkdG8vbnZsYWhxRlhNREo5bUM5c09ONzBHYzMwV1pFMnBS?=
 =?utf-8?B?UlJTRDJaMVYrYndpOW1FRFp0dHpQb25WT2Q3UXlDdXJ2Tm5wN0Yxc2hWVlJl?=
 =?utf-8?B?dktraGFDNHJLeGJvNU9KdVJlbEtFR3ZYMGFZVTRuR3ZVSDcvTmlROVZTakRa?=
 =?utf-8?B?bVJHbm12NlExWFF3U0ZwTFFMVUQ5WlRFcEI1UjMzcmhxZnpvZjdsYXhkbkNU?=
 =?utf-8?B?UzBBRlFVMUVNdWVuM0NmdHU4L2M4MkhaYjd2U0s5ZlFFZWQ3MjdYNFdyQk9a?=
 =?utf-8?B?WTk3RUhLUGJNK1Vrblo5WG5sUGxJb2hMWCtGMDQwdzQ1NnZ3T0FUL25KYUlD?=
 =?utf-8?B?T1l0eW4wajRMcm5ybWVSQkV2WnU1dGs5U0E4cmNUQzFTT1d5NDBseTdZMU9q?=
 =?utf-8?B?a0pyTG5uSDlzTklIT05zNFEwd0dOM0FtdGczdDBQT3pJdmpuTEVCbyttNnpT?=
 =?utf-8?B?MWRYdUNEWmNuVTNRc1FnTmRSdTlqSGNZeU43OHZwQlhRTUVYY3dRUVo4VzlN?=
 =?utf-8?Q?vS4QNvK4eBsqp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE1COTN4WTI4bDFVU0I4WWZsN2wvS2JoZy83dUhzWU5XV0tTYzNmYlFkOS9o?=
 =?utf-8?B?T1RwK1FGSUtYajJmUW8xcWFFS2RLWllFa1d6L0NqN2ptNGhXVEFDNkdqZkJL?=
 =?utf-8?B?dUlWUU5PcGRjeWRua3NZOFZNbUQrWjRSS2JheHh0UE9WU3FWQ0RFYzVlaTRB?=
 =?utf-8?B?RzloZG1uRnZFa08zc2NzVWZLZzNnclUvaXNZa3FIb0tNTHJuNlhZaENQZ29E?=
 =?utf-8?B?eXU3YjllUWFoUmxGRGZaaWhuUHZEa0dBS0dIcXJDeTBmRFA0MlI0RkwrdmJ2?=
 =?utf-8?B?T3lJVHAyb203dHBOVWRzM2RGM1dhVkRGaTdPcEhYckxtMmJQU0Fvd3pla0RT?=
 =?utf-8?B?WlEyWGNiMko2bTNMRVhoYzNQWDB1UjhFTnpyd1liU2Y1NGtkK3JXb1NBYlph?=
 =?utf-8?B?SFRDdWZIWklGb2FpSkhuWVpMS0FMU0N0MW5HdVM1Szh4NzZUaG52aWdORElY?=
 =?utf-8?B?cDMxWUlYaDk5OUpkWTRKRGRwWFRYdDVkNzdvaFRua2RaSVVDVEJ0OU1yRlNz?=
 =?utf-8?B?SlpmbHBYMVJpNmZBdzVSY05yNlBjLzZsZzNEZFVQT2Y1ejhvN1lveUpXV0Ir?=
 =?utf-8?B?M0lzS1BuVWVNMFdmcG9jVVJzbXArT25GcjZ0ZEhJY2lFTmh6R1dEM2t1aGQ5?=
 =?utf-8?B?NDJ3aHJkdzdlcVJnTjVTdVVCRE54S0R0OUtWODlXZi9sS2lYcHpDNTA0NGhX?=
 =?utf-8?B?aUx2c2MvbEsweHc4OTA0SlE4UjBLQWlZVmV1akhHM2JaYU5DWW5XRkpJbDJk?=
 =?utf-8?B?VWQwbkJXaXgxK1dRTFJraUoveGFKWElISkJyQjdpeDRyV2pORDZiRjNYWncz?=
 =?utf-8?B?ZU9kc2VBUUs1a2x5d1VjWEcvYVBmalNiUUFnSURDaXlnSUdWZDVZZUJvQmVR?=
 =?utf-8?B?cnpDdzBwNFJVYXR5MEFvZEZLVmx5cTlsbHY2Z3Y5ZmlHbG9EOXBKQkgwZitp?=
 =?utf-8?B?eXRZZm1UUm5JOVc3U1hicHpYVlUwaUNwNUtEd2VLejhUbFhUN3UwcTlwREU3?=
 =?utf-8?B?OFk5RFY2TlVpRnlRM0RyQWI1RHg2SllrSGtWUjRVMnNVellaUXRPODVHb3NR?=
 =?utf-8?B?bjVvTnJ6K2RQYVNrMkZXV29udEZRbkdnN0t3OVk2bmg2Q24xdjBFVUFKa2Fa?=
 =?utf-8?B?YmJ0cU1aY3ZVa2tyRW50MWhEcnZCZVdGVXpyemQxa1RycWozTE82eHJmY1g3?=
 =?utf-8?B?N3lPZEZiVlNWYjgwdGpNQ3JTaDdoRXZGbHRXKzZuVGRFeGZhaTZDYkdEOGoz?=
 =?utf-8?B?KzhJbHlWR0g3cmpHUXNuTWxqajlmRVQxWUVVVnpjMXdJei9jbEV3UlBCZlFF?=
 =?utf-8?B?aENWemNRUThNOVhTOExXbHQreUgrbko3QlRXdTJVVG5DdkFiWko5dEhuaW8x?=
 =?utf-8?B?S2ozcERaNmFQN1c5R3Q2SWFaMlBPQTY0YzdFTEdOWEV1NTdiRXh6UlZIRUZx?=
 =?utf-8?B?R1dlelZiR0ZzRUp6cTBSUTRieVA0UEJPT2JlTElJcmJVM2taOXlkTzJ2bWFR?=
 =?utf-8?B?Y08xNUJoTUFQMkdNaWVRTEhnaERtditOaUp0TFlmSmZ0Ylh3ZXprOVplSkpk?=
 =?utf-8?B?SkZISmpZZE9yNFFHcU9rdXdoSzFRaHNkMVNIRTZQdWY2aC9scFBQamgvUUlP?=
 =?utf-8?B?d0xsdllCQk9BZExicjg2SDNRZHJaamxxalc2d3hIaHg1bVpzbHdBY0xlWDAz?=
 =?utf-8?B?ZWRQci93ck1paHdoZFc4N1FxQll6MzBPU2EzY09scjNabmhwWmdFVU43ZTEz?=
 =?utf-8?B?Y2ZBeWJOV1pFeDZoQ3dGSENjQjBQMlpjeTRIemdKMW9TbzdwdmNRWTBDazZN?=
 =?utf-8?B?VldWYjZ2YXh1UmxwWld3NmhLYWM2TkpnMXl1dEVMR0UyVWM5b1NQY1k5ZXh0?=
 =?utf-8?B?d3E5TThlTXVMMm1NeFpyT21WV0FnTkt3ODIyWnJpOHVVSWdhV21mbTBNRGxj?=
 =?utf-8?B?OGtpcXpRMjlnNTdTQmFmRzJtd0lVMXU1bXpNcWJ6cjFtQ09JNmtzbFh2T1Z4?=
 =?utf-8?B?Q1g2U2R0dU0xSG53OHpLdDdYcko1S3R0QnpaZG5MUmRlZkxNWUE5bVNESnox?=
 =?utf-8?B?b2VibGJwTFZOdW9mN3ZDRkR6VGF0WnpxY0JtWktGUVJ0SG5NZGRuT3JUKzl5?=
 =?utf-8?Q?pZdDU9M5fCYuP4fZKNowlOOav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1984ff92-b7c0-4fce-9fef-08dd5ceb5df9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:13:32.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPDP0ud1oDqUygKpl5rPkB5/4eSFC6IUnw9/mZK8LC5tQErTXWQ9YXr9uQ5pyI7ea/xOerh1NxdK7mUWgqILqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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

On 3/6/2025 14:11, Alex Deucher wrote:
> On Thu, Mar 6, 2025 at 2:31 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 3/6/2025 13:19, Alex Deucher wrote:
>>> On Thu, Mar 6, 2025 at 1:58 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> Modern APU and dGPU require DC support to be able to light up the
>>>> display.  If DC support has been disabled either by kernel config
>>>> or by kernel command line the screen will visibly freeze when the
>>>> driver finishes early init.
>>>>
>>>> As it's known before early init is done whether DC support is required
>>>> detect this during discovery and bail if DC support was disabled
>>>> for any reason.  This will ensure that the existing framebuffer
>>>> provided by efifb or simpledrm keeps working.
>>>
>>> I think there are a couple of corner cases we need to handle:
>>> 1. if adev->enable_virtual_display is set.  The user has configured
>>> virtual displays and hence they want to use them rather than the
>>> actual physical displays.  This is useful with GPUs in servers or for
>>> early bring up.
>>   > 2. If the board supports DCN IP, but all it's been fused off due to>
>> silicon flaws (e.g., adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK).
>>> In that case, we don't want to fail.
>>
>> In that case I wonder if it's better to use
>> amdgpu_device_asic_has_dc_support() instead of
>> amdgpu_device_has_dc_support() which should cover both of those concerns.
> 
> That should work, or maybe just warn once in
> amdgpu_device_asic_has_dc_support().  E.g., something like:
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1b9b4f8daf531..c986e619dbe99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3988,6 +3988,8 @@ bool amdgpu_device_asic_has_dc_support(enum
> amd_asic_type asic_type)
>                   */
>                  return amdgpu_dc > 0;
>          default:
> +               if (amdgpu_dc == 0)
> +                       DRM_INFO_ONCE("Display Core has been disable
> via kernel parameter, No display!\n");
>                  return amdgpu_dc != 0;
>   #else
>          default:
> 

The problem is without a display that message will probably not be seen 
unless someone knows to look for journalctl -k -b-1 or similar.

So my main concern is that people who shoot themselves in the foot at 
least have a display to see the hole in their foot.

I'll have a try with my other idea and follow up with a v3 if I'm happy 
with that.

> 
>>
>>>
>>> Alex
>>>
>>>>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v2:
>>>>    * Update commit message justification
>>>>    * Add correct "default" handling
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++------
>>>>    1 file changed, 33 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> index a4258127083d..24f532de6322 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>> @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>>                   return 0;
>>>>           }
>>>>
>>>> -       if (!amdgpu_device_has_dc_support(adev))
>>>> -               return 0;
>>>> -
>>>> -#if defined(CONFIG_DRM_AMD_DC)
>>>>           if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>>>                   switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
>>>>                   case IP_VERSION(1, 0, 0):
>>>> @@ -2166,39 +2162,63 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>>>                   case IP_VERSION(3, 5, 1):
>>>>                   case IP_VERSION(3, 6, 0):
>>>>                   case IP_VERSION(4, 1, 0):
>>>> +                       if (!amdgpu_device_has_dc_support(adev)) {
>>>> +                               dev_err(adev->dev,
>>>> +                                       "DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
>>>> +                                       amdgpu_ip_version(adev, DCE_HWIP, 0));
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +
>>>>                           /* TODO: Fix IP version. DC code expects version 4.0.1 */
>>>>                           if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
>>>>                                   adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
>>>>
>>>> +#if defined(CONFIG_DRM_AMD_DC)
>>>>                           if (amdgpu_sriov_vf(adev))
>>>>                                   amdgpu_discovery_set_sriov_display(adev);
>>>>                           else
>>>>                                   amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>>>                           break;
>>>> +#endif
>>>>                   default:
>>>> -                       dev_err(adev->dev,
>>>> -                               "Failed to add dm ip block(DCE_HWIP:0x%x)\n",
>>>> -                               amdgpu_ip_version(adev, DCE_HWIP, 0));
>>>> -                       return -EINVAL;
>>>> +                       if (amdgpu_device_has_dc_support(adev)) {
>>>> +                               dev_err(adev->dev,
>>>> +                                       "Failed to add dm ip block(DCE_HWIP:0x%x)\n",
>>>> +                                       amdgpu_ip_version(adev, DCE_HWIP, 0));
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +                       return 0;
>>>>                   }
>>>>           } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>>>>                   switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
>>>>                   case IP_VERSION(12, 0, 0):
>>>>                   case IP_VERSION(12, 0, 1):
>>>>                   case IP_VERSION(12, 1, 0):
>>>> +
>>>> +               if (!amdgpu_device_has_dc_support(adev)) {
>>>> +                       dev_err(adev->dev,
>>>> +                               "DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
>>>> +                               amdgpu_ip_version(adev, DCI_HWIP, 0));
>>>> +                       return -EINVAL;
>>>> +               }
>>>> +
>>>> +#if defined(CONFIG_DRM_AMD_DC)
>>>>                           if (amdgpu_sriov_vf(adev))
>>>>                                   amdgpu_discovery_set_sriov_display(adev);
>>>>                           else
>>>>                                   amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>>>                           break;
>>>> +#endif
>>>>                   default:
>>>> -                       dev_err(adev->dev,
>>>> -                               "Failed to add dm ip block(DCI_HWIP:0x%x)\n",
>>>> -                               amdgpu_ip_version(adev, DCI_HWIP, 0));
>>>> -                       return -EINVAL;
>>>> +                       if (amdgpu_device_has_dc_support(adev)) {
>>>> +                               dev_err(adev->dev,
>>>> +                                       "Failed to add dm ip block(DCI_HWIP:0x%x)\n",
>>>> +                                       amdgpu_ip_version(adev, DCI_HWIP, 0));
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +                       return 0;
>>>>                   }
>>>>           }
>>>> -#endif
>>>>           return 0;
>>>>    }
>>>>
>>>> --
>>>> 2.48.1
>>>>
>>

