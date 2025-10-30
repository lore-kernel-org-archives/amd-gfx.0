Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EAECCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B359E10E977;
	Thu, 30 Oct 2025 15:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X4pvZfnO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCC110E977
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svXPLaKwqjgZ5lieBu1xb/WTs1IZyDmMayxLgajgYJXwrKvsqn3CiXRnaH+s5PVmtuHtk/c8DTHPA1QuV7TH28KQLvQbFifVt2CHnyVa1+bY15Vb+9ILq3N+utoeFn61stUy4JcjHV1OmChC4e9eH/OqZTizoolO4EjHgFuqTwqQD427TVirkeOtTrnWm4AAZA0gKwX0KL+PdnTEDdET3Vs3S32Inav0W3AvbQuSNzPXNntvh6Y88Ib+OOPF4Zbx+9G1jLFrtjF7aGLlpKXNMCHgGH9eHyoIm4X95qCrv4CEC/LGMzvGYNMHs8S6IH6dF9ytLT1wrXpOVDx5OFUxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzpckvSKH/D2dKgzbTH+2Jw8KiTdc68eE9MwbUanzww=;
 b=EHGjMITtJuJIb4RgyDbvEgxlzApTGMHyreD4nw9/QifRQAy/L0J+QDnJ71vB21ShZI7WqXS+G2Vifd9bxLspHA9SNt5ONJPFdp/bsXVxPZeP6An6hS/xajUFidXC+vcw8iRp/ap92uEsqmms/bdQtnUeEYlJ2TxWU+/bcEh4+CSPBUP+ISj/dC2JVPgyJmos+9ont6tIbnrv/NZhtcWd5IneXKrupz55jhaWWzaGnmqTTl32jugVozbvWiFTs0aCabYLMV8AqOa81l1jdECyZCeF4+W+cq4+DB7Jh9lYaYLMFo2TR7uSP+vxOjFjpt/8Jp7H+RSJuNFq0+vmNIlj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzpckvSKH/D2dKgzbTH+2Jw8KiTdc68eE9MwbUanzww=;
 b=X4pvZfnOnS/tWL/DBkwtbgrn1H3s7az131omhYdfgFItTnY+hGoYiXl5z1vsYGB8zE9feU9E6Fr8HhgBNYJuoXv03Opp8Rjx6eEKYD8a/Arz96ZlW3sqXjINQTsqXlN5R1DAw9NzLzjE4LDfCqv57DGiEUZN0ZEoRDS5cikgLKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:37:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 15:37:34 +0000
Message-ID: <0a2f37d4-fd43-40b6-86d5-a0355bc770a7@amd.com>
Date: Thu, 30 Oct 2025 10:37:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bob.beckett@collabora.com
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
 <CAGwozwHnROrncN_bLAVqrd=XEV6FGS+sTLJx=wsXqx9GNsNiFQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwHnROrncN_bLAVqrd=XEV6FGS+sTLJx=wsXqx9GNsNiFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:806:121::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c25d3c-f8f6-447b-0a32-08de17ca3f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjdmeDNEb0EzbjlyeGxhQnVDbnlMbnk1TWk0U2xPZkZjdThPSzJ1b1N0VVF0?=
 =?utf-8?B?STJBUFYvWEk0Vld5aTJIdXZsL0F4Q0pXQnBLYlBTYm4zeTh0L3Q2U2E2dURK?=
 =?utf-8?B?cjhLNVN3ODNzN3pobjY4Mk94NHdwWERJRng3Mld1Nm5qOEZuaTh6a1lhbWxx?=
 =?utf-8?B?cG93NHcxblliRkdHdWRDNWZQUm1zNG9YMXVvbWZRU2d2T0VSVCtGcGVUSlk2?=
 =?utf-8?B?SjI4T1RBRDhjMVplTXNEcTJ3L2JzVVFUUVpOdVNQOVBVa1IrOWY1VGIzTUxW?=
 =?utf-8?B?RktHcHZ1Q1gyQzFueStMVitFd1VKTmZFTmN6blBNaStzL1NIdVhFbWVjSVUw?=
 =?utf-8?B?cVI5SElQSUU0dTRNUnNyeGhpU3NnVGR3MWtMM3FibU80WkFFYm5pazcvR0Na?=
 =?utf-8?B?ZmhhOCtNWGJqYU1vSFVkdW9jT2NES052bDR0S0MzQjB2SmNndE82L1NuS1JE?=
 =?utf-8?B?RExyNEpzVXFoSnFsWTBzQnJjaDRqUnU3REpTSENLTUcrRVc1d1hoTjY4Z2RO?=
 =?utf-8?B?K0FKNEZ0d1drNWdBZm9kcndUMkl2eWtlNXJiZ25iMG5uNDd3Y0dndERzZFBo?=
 =?utf-8?B?MzVoRk4vNmhJektOUEUxaGExTkxodWpxS3NvT1IyWk9TUjZ1RGNySmJ0cTc1?=
 =?utf-8?B?NUVndEJqQWVpK2N6aThVSHZsUDc2QW9CMXVFVW1zOC9oVDd0OGU0bVlMMk9U?=
 =?utf-8?B?OHJqZlN2dktGQTYyTkxXVU90ZytDS1E2aUlQZzRzSWtpTWE2cjdRTDVIR1ls?=
 =?utf-8?B?Y2NBK3Erc3dpazV1Wi9FazF6cGgvOG1LdG8yaG1YSEU1MWRtTHJVRlp0cXJJ?=
 =?utf-8?B?UzFmL1QzY1pqSVlrZ0Fsa2x5eEFRWHpocG1qQkFoM1lvU0ZwUU1DK2dpWGZv?=
 =?utf-8?B?ckhIZG9ESjJNb3dGK0FXS0hHa2pLV1JLWEFSSldMbFEwRlpPcWN2VytGaTVW?=
 =?utf-8?B?WDc1djhCRk1UUmJVMTdNSE00SEJNU2RmMEhjdGFqaFJ5dW1YSEtlSjRaYVRZ?=
 =?utf-8?B?TmFkYzVodGhldVV2NmR2dEd1UHAxZXVlMC93a0NOWTdUeWJ4VnZpd29YNDdx?=
 =?utf-8?B?TWplQXJkckJCSk5ibUJhdTcyT0F2MXMva2w4NHB4V1B0YmU5Y0NFcmFUTDBC?=
 =?utf-8?B?TzBTOHpiejd5TmZjYmtJbTFVQkNUNHJnUXh3RVRMVGl5elZPUm9BanU5N2Ew?=
 =?utf-8?B?N3hQUktlOGNQL2xseXVaUU9iYndXTHJQZHZwQzQxZXVQS1NqNVE1VXhLbitK?=
 =?utf-8?B?am1vK2lJVzZXWkR2MnNxSE9GNXI5R0l6TE1xaWtOdUFIbFJjaTlKSE43VllC?=
 =?utf-8?B?Si83RVpZUzhFbHlHVTFlekZRSE1IMEN6WUg1ditzcVc4dmU2VVpwV3lHZnBE?=
 =?utf-8?B?R1RNMHBOMGdRajZQRk9BMDF5aUZVUkxDb0tRaCsxcU5FZEI2WXo3ZWNiMU5z?=
 =?utf-8?B?TytxR0YxM3dHTTY5UC8xSW9tWnpHMDlZbTMwaEF0U1hMQTBicG96dFF0RzdT?=
 =?utf-8?B?M0ZxWm1McW9GKzAxd09SSloxTUxSeDQzcE51YU5wUlYwQ0RjYnZuSjBQMWwv?=
 =?utf-8?B?a0JpLzBTT1RBTDc2a1RMSDFaTndpNXNaTkt1UitrNUxML3VpQ2F2YWoyTG5k?=
 =?utf-8?B?S0J6OVpqTFZPUnRnWTBJakNDaXlZZjQrYW43eDB2bWxscllINkpVM0MyTUt0?=
 =?utf-8?B?SzU2ZE5rbXNlRFZRb2s5U3hwZVJsV0puWUVZcWNXWDV0RllybGJDaGxpR3lP?=
 =?utf-8?B?VlFiMERSNUg1VU5EZUZ4UHpiR2ZmakU4WFpuaVpnTUZkRDNVb3RBWWZqNzhk?=
 =?utf-8?B?SUtsQnA2SkYrK2dJRVFzU3lVWkFBWWNLbTROdjdJaDRxSnNCM3VwS09VR0ZI?=
 =?utf-8?B?cUZPWHQ4OTdtb2lKTTZqUHpoQnlhb3RycWJ1OU9iNmlPM1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm93UWtLZlFrdFdIR3pMRmM2aXJqbzVIL3l6WU0vbmhRRFdUbEpWZHhxV2F1?=
 =?utf-8?B?QzdQVnY0VkF2QUtuaHJDVm1GY3VnRFlEdUhmZkczQ1NoTHZhL0FndElXOFU1?=
 =?utf-8?B?UVhHR0dYdHFaaWZzMXowRGJPeHlTeDFxZDJoNGphOURXamh3WjM0aVBrT1FI?=
 =?utf-8?B?RDUwazRMUDg3dEhJUTZGMTBtZ3B3ZHVxdktWQTZaVW96bEhXYzRUNnlndThy?=
 =?utf-8?B?VGRwMkxheks1ei9IYVBqdW40Z3Q0Y1l1SmNsR0JUdjhuZGUzcUtuN3lYRXVn?=
 =?utf-8?B?VUdTcG5JeEVsR3pYT0RKQjdHeXE1cXBSZkdGdzBiVTAweXBOd29hdkpOZmVC?=
 =?utf-8?B?RHBFNS9JanRMQWRkcUhLcEhZZmdrL29ONVNxbGVCTFBtQzJPbnM1dVI2UjhN?=
 =?utf-8?B?TGZBVVR4ZmcxYVVsbzJ5c1BPSjVjWmV3eXM3UlNPZnZjbnRpcFMzeU1lbXVM?=
 =?utf-8?B?cVVIN1p5VHJ5UmdKaXNIeTFHZXhadDlqQk1IbUpnaXRKNGJqQzVyTnNaTGhm?=
 =?utf-8?B?N3pTaEtWbGJGRTc3MStNbUpuVmNXcHYwb2ZzRU1rSzVzRFlHUVB5Y0tmYW1T?=
 =?utf-8?B?cXUxMHJ0M3ptclRKcEE5SzZMZXVqRVg3UFdHZVpkSGtDc1pjWHRUN1B3YjM4?=
 =?utf-8?B?Z2ZqZXpCOEFmVG03Zm5xZHFnNjZIWEpraHN4aTNYRWRhZEdBWlB6Rm90MC9B?=
 =?utf-8?B?WjZXZCtud2t3T1I5MTFSYjdIOTduWTJ1MWpmb296ZDVPamdEL2x3SGtBYTQ0?=
 =?utf-8?B?QmQ1d3JDWFhrTlJQblc4RFUvOVhENTZHSEhteE9majdLTjRvL0FabVV3Yys4?=
 =?utf-8?B?ZHBSVjdhZXNIOTM0TitNcGtDUmRXZkF3aDhZbVhtVUZWNnRvS0J4R2MyczJO?=
 =?utf-8?B?bkRRT3VYaXN1SUx5bDdlR0N0L1dSampOdE55d09ueTgvVzR3RGh1Z2lrWGgz?=
 =?utf-8?B?bFlVMEg5SThhODJSS0h0TTNrWURlc3VkVXBKYmF5RlcycktDOEVDSFZodisr?=
 =?utf-8?B?by82d052ZXI3d1BKZytOSXZaZ2F6czFpZXppbGtnUkRzSFR6cHFwY2FIdGdI?=
 =?utf-8?B?QnRRakRtcU1pNzhBcklyRVJISFd4dTNNYWYrZTh5T1FCMnRIek5FeHZKaHBO?=
 =?utf-8?B?Qm9RditmYlduNGQzK3RSR042Wlhuc0tzQkFReUNmV2FmUE56MGNzRjhwZDIy?=
 =?utf-8?B?ZnptVDFxaGpjaENpY2NnVXA3SUtORWdSNUFmbisvcnh6QzcxK1I1cWJtSU42?=
 =?utf-8?B?Q3hyR1ZzU0RZeDVKZklNeTZDZEhZand4bE1RdUlGcG1SaFV1bVpxcStGczJQ?=
 =?utf-8?B?NEdyNy9TK24ycW80dzRta3ZHd25jQUVya1hRb285aHlJQnA4Rzh6c0RKdEhq?=
 =?utf-8?B?RXRsVE4vbXBuU1RBMit2VkpGRktyVHFTUDBGNi9sYWQ0VldleDBzQy8vTHg1?=
 =?utf-8?B?UjRTb0ZtSUZBTHZxWjluL2tZN0Q4aFhXNnJER3I5c1J2L3dROWxpcTNPWnEy?=
 =?utf-8?B?V0hHbTRMRnAwN1N5WWFWeXIyanFyUE1tNUR2VEcvVDdxVW54cWdvMmZlTzY0?=
 =?utf-8?B?amF2S3lORVdjOWJIR290SWd3R2FTMmNub3Z1bmZ1MTA4dmw1K1VCdkg0SGJ6?=
 =?utf-8?B?NU9PUmRKb0d4S3FjODFib3dPcVQrR2s5aDU1dUx4eWZESXhpR0NwUkZLUU9V?=
 =?utf-8?B?QW9jeGhBaUdCSVhaT2hmSUJMQ1NIdHR3M0p5czIwNm1rb01vMUhxeFM5OWlr?=
 =?utf-8?B?MFBqK0VETlpWN1BUTmQ1Tmd1NitIeDVSZmxSOTA4ZVlRUzc4TmNEY1AxblQ0?=
 =?utf-8?B?OWZUcnp5aW9ITC9xNnYyMXVaMUNJNE9GQkUydndHUkVMOHorR054NEpaR3c5?=
 =?utf-8?B?R0x5bEYxSHI1d1UrNTdtWkJGbm9FcVVoaHRHWjBRMy9xTFBRQmtSRkRydzQ3?=
 =?utf-8?B?WnA3d1VqaGZ0RUtKdHpaV25ucjBnT09xckZManJvSzJienN6QjdPQVg1eWhG?=
 =?utf-8?B?RWpsS1hnZmtuNWVzVHBpZnpnOC9JOWVYR2QrSFdsblp1RW1ucDZuVUNKRytQ?=
 =?utf-8?B?Y2RrVU56eE9NeTMveGRiMUhISDJwVHQ0RWdEbmI4QXd2WHM1MHJ1RVBUcFBj?=
 =?utf-8?Q?m4StmX5uRLvUYJrEhOswgCuDb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c25d3c-f8f6-447b-0a32-08de17ca3f05
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:37:34.4276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raTpOR6tc1+kLmSP7KHehSbg1QUH+yPxgvb/orEudLt/BzgL5cwtSMvQHpjRcHdZh3dTX+K+yOXzb7ExiorEdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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



On 10/24/2025 12:14 PM, Antheas Kapenekakis wrote:
> On Fri, 24 Oct 2025 at 19:08, Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Fix the flows for S0ix.  There is no need to stop
>> rlc or reintialize PMFW in S0ix.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>>   2 files changed, 9 insertions(+)
> 
> Sleep failed on the Deck the same way as Mario's attempt

Can you please test patch 2/2 from this series and patch 1/5 from this one:

https://lore.kernel.org/amd-gfx/20251026042942.549389-2-superm1@kernel.org/

I expect that everything GPU wise works with those 2 combined, can you 
confirm?

> 
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 10d42267085b0..5bee02f0ba867 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
>>              smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
>>                  return 0;
>>
>> +       /* vangogh s0ix */
>> +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
>> +            amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
>> +           adev->in_s0ix)
>> +               return 0;
>> +
>>          /*
>>           * For gpu reset, runpm and hibernation through BACO,
>>           * BACO feature has to be kept enabled.
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> index 53579208cffb4..9626da2dba584 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> @@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>>          uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
>>                  adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>>
>> +       if (adev->in_s0ix)
>> +               return 0;
>> +
>>          /* allow message will be sent after enable message on Vangogh*/
>>          if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>                          (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>> --
>> 2.51.0
>>
>>
> 
> 

