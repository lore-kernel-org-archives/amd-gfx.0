Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D999E77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 17:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA9610EC15;
	Wed,  8 Jan 2025 17:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RqPyvNEt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7966410EC15
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 17:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXDSIxEq4++6Enokv3QMLdAqLIe+H504ffjLmf2Q4pWb3s5v4rlStczVjhRctHwpzdDBtYq6lhPKcHPVx826sJD7AQBMsDvKBuDM1bCq/r3Jiz2+qDQTCunY6lQoYBEtAyMVJbMrpDirRVTtIBrfgImhOHTXUhEE8/+NAy872Z8S0DtShlK+of9g4pHAW0elVqxiTQsJp8ZyKKTNpeFlDWuUZB5yB3JBwt9h/S6c4SlQYHIPqQkctJjskeowiyvAzKvhzd0x90GSo2e01WnmA1Ug0v/q6iMvF91uy/jOdhDZk1qY38ejgULS2OqJhPoAJVNxL1Dp9E+aA5q7Qv/35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkI4tiH5NoTaGD+I0axE6ZWvjmDpymRbAbMPRuzIcpE=;
 b=VB0PRKpXPwk1OoAUA7NDkF/Zjf5Gir9GdWqF5JkzTGBNcq5FkxH8/znPPhimznC0nNELvLe+57Qw8BeP4n4p8eVUgxgYGEOTVQ6uLHXKHqmhHyp8wMgxoz/AaoziPfUxkPQ7U43JFzcsU0Fatqns9LwAezkAJH+yvdbTWtRRE6YOUyB9R2yw+w4JQAz/GnSbgLlUoznFSZ1c+uIXiwXoRUzHLGs+3e1g3JfOpzhPgdHuiVJZzm+m9mxv3RcBdpZnKwAkk0YlOCXlfXF3I2N79e0vIztBpNFh3ZplcmkoRgEeq++Az4Q63SJRLU8OPCym9wUD1N3RSMz6khRA/a3rMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkI4tiH5NoTaGD+I0axE6ZWvjmDpymRbAbMPRuzIcpE=;
 b=RqPyvNEtALUQ5JGYret1eUuASx2aWewAJQYSgU84kr+2bJNGX7SjK0zmxBNXh6uz4BSe9uRZeITB+Q/gUXCAIahWhVGkrfIvxVZ74Me2BzRn8UzEDyXNdGgHotw22xc2KQqDPWSiqVa6VYXzp8FGrYMWqGt8lZgOSB5GSscCCn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 17:04:11 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 17:04:11 +0000
Message-ID: <c82d1b49-2ff7-4727-b378-e854b49ba139@amd.com>
Date: Wed, 8 Jan 2025 11:04:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/13] drm/amdgpu: make IP block state machine works
 in stack like way
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
 <d8d9a5e10dc0cfb8a9d625eccae714a1634d28e5.1736344725.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d8d9a5e10dc0cfb8a9d625eccae714a1634d28e5.1736344725.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:805:ca::27) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef951d4-2f71-435c-910f-08dd300678fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVV1dE80SjZVNzhSOCtGOVJnTnluRG9nV1NseWVoUWk5bGlhMldTTkNNdFc0?=
 =?utf-8?B?ZXRJUnlnTjBOenJQUjNrQ2E4VkZrNnVPN21sUTNwU2xweitHZThDTm5yQ2pH?=
 =?utf-8?B?aTBvMUpGSnU0Y1pYUUp5b1BNV0VvSTJZRWxmSjM2K2JmTklCUU9vSW16QWs2?=
 =?utf-8?B?YSs3UE5XbXVxL1QvQVVlUEVhbU5TNFRPNU9WL0JaWUtNcXVPM2JhVGFIQ1c5?=
 =?utf-8?B?Z1hGNWlNL2NMUE5CN3Y1SUlqeXI1cC9SeC8zM21GMUU5azhtUjh3b0N6QVdY?=
 =?utf-8?B?QnlURXV4NTdlanpiRjFXUmR2NlcrZmlZMi9VOWJoSUhvc2F3Q0JSVk55UVdP?=
 =?utf-8?B?eUVDQ0dzcWYzRm1xZ0tDK2tRSloxWlJJaWVaNUVuV3hlV2dZNGtRTmJNODJp?=
 =?utf-8?B?QXk2RjA2d1ExUm84MFlYTjRuMldGTm9kTEFOUnQyekxyUUJCbUtyeUxld2xD?=
 =?utf-8?B?b21BTlg4U1RsR3B2bUpXcVN5Q2lOSVh0UHZnYzlWZ2htd01KOGl3VytCcW9n?=
 =?utf-8?B?VGNwSmFvTlFXcjV0blNMd0NoK0thc25rUWlMa1dZYkR5V2p1Mk9MTHJXQ3Vp?=
 =?utf-8?B?MTljZkh1bmVBV1FMQ0ZmL3crejJ4L2FSM1Q0REZaU1ZUM1Y2MERZeHEveERX?=
 =?utf-8?B?VnBwZ3hERk9YVGNjMWhIWmVWQ01IajZWV0xRZFZwRDA0Qmw5TWZPb3VCQmox?=
 =?utf-8?B?eHpFM2xQSEpZUno3eVMwWkFzOGJLMkdsRHZXa2tidEFVR0lVUWhibFpDMzcy?=
 =?utf-8?B?SHpqTG5HMlpmbHBJL2x3bnk1d3pnMDJCd1hMbm9OWHpyWG1VaFBDR0w4cWw2?=
 =?utf-8?B?RmpyYXVONFpzQnlKWW9WN1ZsVWNiYUJlUSttTTYvR1hwTzJwTnZiVU5BTTcv?=
 =?utf-8?B?MXJlK25Cb2tWQSs5TmJLY20vTHFHNDNXd1IvSWxBMnQzc0ZNZGNHUWtLOHpP?=
 =?utf-8?B?NHJxN0g4ak50SXFvYTdmVlB0Ulp1OEJKYlFEL29NdTZJdFlSdXNMaC9qdmUv?=
 =?utf-8?B?R3dDeXhaTkZSS2FkQ0VnR1lnWE1rTTlzdk1hcHBDVXlwOXpQdXd3bUp3bDVu?=
 =?utf-8?B?blV4NzBOUmhHdVdCQk9UckdMaEUzWDlOd3VEblNWczYxcy9WQWo0M0w1d0p0?=
 =?utf-8?B?OGxocjZKclhpUFJ2NlJBV0hxY2pFTHhCVlJsZm5OUkZIQ2ppeGgxSTMxcGNZ?=
 =?utf-8?B?OUhmOTlSUHBMcWV1aEM0SW9lcG53ZVUvd2JKa0hJdXoyd21zUDJjOU1qRDV4?=
 =?utf-8?B?ODF5UkRqMkV1ZWRVclF1UXR2MER5czFkL2YyalhaM2xyYytFSFppejRBdjNC?=
 =?utf-8?B?TmxSb0R4STNrcUxEdmtueklaM3NnZ0w0WmxXcUlCREJ6VjZLUDFmNzRaM3RY?=
 =?utf-8?B?bjRpOTBHU0ppaFlmU0lwaENsRGtET0dIMGJXdnVKNkdabFJHTXZCSWkxSUdD?=
 =?utf-8?B?bWJnZHc3WWlrL25KRzRkWXZhMGVERlR0TWZrQ0lBdG9nelF1aW9vcy9Ub2tJ?=
 =?utf-8?B?VFRRbmR6dGdHRXRwalJOUWZoR25iQm43YVo4VFhhdnpEQWF5bEtadnpleWNn?=
 =?utf-8?B?YzZnTW5IS0FBWWFWRGtubm5tR3VCRk9iV3JLUHFFWW0yOC9RaXhSV0RzWndw?=
 =?utf-8?B?aTQ0bHpkNkdOdEJqRnZVU1JNQW54UlU2eWRHaFhsTjNSaEhFMC9VcjJnM0hC?=
 =?utf-8?B?NHFMZjE3MVlyVDRCeFBuc2ptait0ZHd1QTBxbnhWUEhaY1BQc1N1ejRZUXgz?=
 =?utf-8?B?SmZBNkkybnRkb25JOG80OEs3eWlteTVrczFGSEU0MVBGMWtOUTFGemdpTHNG?=
 =?utf-8?B?b2huZ1M5U3lsRk9Tam83dUdodFF0K1VtcVJna28wVFpOZEg3TUkvVm8rMExT?=
 =?utf-8?B?L2k3RjNsYVhLbzN5dU85dXp1cUhWZzBiY09HclBRN3JBNUZTUys1SUl5aTBm?=
 =?utf-8?Q?GpKxUCX9Uag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRuOEFWbGJTS3RQSE0yY2FUVS85c292Tlhkd0VSa2FoNlBSTkdLTWtnNy9P?=
 =?utf-8?B?amlkcFQwN2JoTGZrTHI4YkJPNWp2eWFUUDhFZnBYRHhFVHZLVldJTXNGNVVW?=
 =?utf-8?B?OW9pRklhUTlyVXB5Sk96Zkd4d3pRUFZuTDhMcXJDVDFpNkVsUDgyQlJmMnZX?=
 =?utf-8?B?TFpvVDMxdy9WY29rYzhXSVVYMzhFRnpxaUc4a1YvRERWSTczUUQ3V1kwRkV2?=
 =?utf-8?B?NTJHZ3pHUnh6amMwTm5CUnR4ZDAva3NCUWFTSkgwTzI4Ynlaa1hUdWc2ZndQ?=
 =?utf-8?B?U3ZXd295SFh0MlE0d2tkTWtiaXc0dUg0RDV2b2ROLzVneS9SZXdVRkoyVzFZ?=
 =?utf-8?B?dEc0aUdDZnNxT2wrbVVSb00rZHAzT2ZrS3ZzbzlqU1ZEVHNnNTZuS1FzWktk?=
 =?utf-8?B?SjlFclVQSHlXNGFvenQwSzB5NURDSHdIK3h0NmM5Rjh4WHJqQTJrbFoyYXYx?=
 =?utf-8?B?c3JTaXBYa21WdVpRNWs2TUhiUEtJT2V5RzhMRHRRWUp3dW5TYWhBU1IwcTZw?=
 =?utf-8?B?RU83WElOMDJYOHBDS0tCWmpnZjRodXROVXErbXluQ09jb3Y3SWppNzlJZ0Rz?=
 =?utf-8?B?UHo2VURXYmlLU0FHanhUTUttZXQ5aGErejVyZ3FKdlVwQjNNbEF0bWh5d1Uw?=
 =?utf-8?B?SXVjZFBEdy9KY1lETkVFdWxPSEp5L3BaQmdQekRLMlVKN1AxUnpEbzZheHRv?=
 =?utf-8?B?WFE2bGNUaEQ5cE9HZWFSVVBEVkhLSW1oNW45endTK2tCOFJLQzQ4MitYbmdY?=
 =?utf-8?B?QUp3VEpaRzdKVzlyWVJ1RWd3WjJVWlZBcnpndTBIRDU0MWlzMVB6M29BdGcw?=
 =?utf-8?B?RXkrak8vUzd1dEc2UDQ1UWp0SEY4d01nTCt6dlRBWVpHU2hSYkxrdGdvRkVm?=
 =?utf-8?B?Y1l5cUpLMkdrNHRra2xZZ1FKc0t3alN0M0ZuZDAvSEpod3N3aXZSNnI2SzFx?=
 =?utf-8?B?SWluRGF0TEFyTW5MQzBqKzhUbC81YjE4blRVM0oyOGE3Y1NQWnFsTTcxRTlu?=
 =?utf-8?B?L3NTc2czeE5aT0E3dHNveWtOVkVHWEM3MjhrZ015QW51SHRsYkxmdG9QRld2?=
 =?utf-8?B?RHhJN3BpWlY3cVRESVpIMVR4YlBDZzhtQ2d1dFpUdEtBaEE5ME1zTDJCbncv?=
 =?utf-8?B?TUtrMVNVTEIyNUtkV2w0M01XWmpnUjFSOHI4N0FlMElnWk95MmFrMnZ4Zm04?=
 =?utf-8?B?QjV1QjI5Qm5mbUNRR3BhNUFJZG1NeGR4Mmx1QXUwaE9rNjZXS2lDUDVrUmMv?=
 =?utf-8?B?RXVER3JMS3phc2lGOWtPRjFMbHd6NVhxU1dmRTZuU1g1TXYyTFBKQ3czR2NN?=
 =?utf-8?B?TzhucHlrbHFneUlZVWRnTEpxL29LQ09teTVwRnJtcEJGWlRxN0VGVkxIQ3pU?=
 =?utf-8?B?OVlLMk91d2JWdEl4TGw3RVA0STVzQk9yWXVMUGlJV29BcWQrdjFKSm5XMzJa?=
 =?utf-8?B?eWo2Z1pVRDVHUXJveUY3dmFJRDdyYi91RWFWajVydW9yaVJvSHFhYXBLd2J1?=
 =?utf-8?B?U1cvcUhiZXhhVkJEUGpZMDlyWXpzdTQ0UVp0ZW9YUi9GRFlpRVpheXd2WHNF?=
 =?utf-8?B?WW1KQmF3eDlYUnhpY3k4Vm5qeVdTQVdrKzduQUgzVGVIVVQ4L2JKZm1hNGVJ?=
 =?utf-8?B?a2pONmE0Q29hSnZENEJSNEtaTkMwa1k5M3dCSmlNbFluTEJRTG1xb0k2QWFp?=
 =?utf-8?B?SktUZzRoVlk3YTFCWHFNUVNCM0pyWi8wZjBRY2JBMUVhYkJvRm5Gb3NlclFz?=
 =?utf-8?B?NW9WR29aU3NwZEs1VCtQV0ExTzNzYzBNYXB0UFF1eXNtangwemw5a1FPbU1r?=
 =?utf-8?B?VE9mODdKU0xtMU42RlhOQmhLTkpYelJ6Z0xtaDhyOEl3NklGRjFTeEdyNmZk?=
 =?utf-8?B?RGpWTU0xcUZDcnlpZWJTZ3ZIQUZBWjBMT3kyRkhDYVlWRk9Qdm9wdHpLZ2xP?=
 =?utf-8?B?N2E1V081TUJ2NlRRU2cwTEJ0VG5GQ1ZiSzZRVTRaZVU1dHlrdDN6TUpHTWEr?=
 =?utf-8?B?bzJvWFBxaUQwbUEyV3hYQ0h6aXJzdFcrYnJIalcwd2NHeWdHTE9WU2xrbGpC?=
 =?utf-8?B?OTA2LzFHSG9oTU8vRjJaVTZGS2lJazVER0FHNHZETWJqSWd2b2VEek5KYkZj?=
 =?utf-8?Q?6OojrJmsFN7RZm2sUhNcDId19?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef951d4-2f71-435c-910f-08dd300678fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:04:11.5853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5UrvUPSmqBOYzxv978J6gXl4Np4V7okgRddG8VLlxxNcWO76kjEN23Bbi+41mqZ0XG6Mf7mFcJo6JoDYpzvQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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

On 1/8/2025 08:00, Jiang Liu wrote:
> There are some mismatch between IP block state machine and its associated
> status flags, especially about the meaning of `status.late_initialized`.
> So let's make the state machine and associated status flas work in stack-like

s/flas/flag/

> way as below:
> Callback	Status
> early_init:	valid = true
> sw_init: 	sw = true
> hw_init:	hw = true
> late_init:	late_initialized = true
> early_fini:	late_initialized = false
> hw_fini:	hw = false
> sw_fini:	sw = false
> late_fini:	valid = false

Would you mind also putting this into kerneldoc?  I think it would be 
really helpful for others to be able to follow in the future why there 
are so many variables and what they all mean.

> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0e69c7c7fe1f..36a33a391411 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3332,6 +3332,8 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   			DRM_DEBUG("early_fini of IP block <%s> failed %d\n",
>   				  adev->ip_blocks[i].version->funcs->name, r);
>   		}
> +
> +		adev->ip_blocks[i].status.late_initialized = false;
>   	}
>   
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> @@ -3407,15 +3409,14 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   				  adev->ip_blocks[i].version->funcs->name, r);
>   		}
>   		adev->ip_blocks[i].status.sw = false;
> -		adev->ip_blocks[i].status.valid = false;
>   	}
>   
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> -		if (!adev->ip_blocks[i].status.late_initialized)
> +		if (!adev->ip_blocks[i].status.valid)
>   			continue;
>   		if (adev->ip_blocks[i].version->funcs->late_fini)
>   			adev->ip_blocks[i].version->funcs->late_fini(&adev->ip_blocks[i]);
> -		adev->ip_blocks[i].status.late_initialized = false;
> +		adev->ip_blocks[i].status.valid = false;
>   	}
>   
>   	amdgpu_ras_fini(adev);

