Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16653D35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A076C10E63C;
	Wed, 28 Jan 2026 10:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWatQdmm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F4910E63C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glhAS4uNx0Yg2jn6w5I/HPeJ/LRcSVJaxo3FaOtCY64xJNYq70n0HkO9ATHiz2zC39fOT3kXFAIwYGUc/VgRa2U73HzwVOL1k/hT7Ehz+tGkmYtFXTFvecPsKlFUnl26pWRK3hcwu6euHBE6u0965GLgqNln/wmhu8w54qOsPvUPKan2kESk1NDNfrgAHq7voxT951nK6fCH/XDGSVS7nbeQgufxWwMNXhndDFrtrPfI/HDfO3CHI1idfTOgD8/MRhjpOBVQrP3Sowisg2o6LNp2t1E8pbLt19jUrf6I2l//bSozGBb6RU5klp3EIG9KMgtEEHg2PStsromE/PQi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93AUsCRSNNw82yy6uwDxhjb/LIG0+QN/W7TWNj0YMxc=;
 b=OxdWEFM+qUF21TdyryEwhOpSIp1PXca4jwHyFge7FAU8mBDwBwXAp8pGEMX3k+kXLY3PXcbLRzX701JaZzaXrU+b7/Jn8xBITlcISMZ1NCsUaPN/kImOCfB6axJKlvy6cB4yS8zxhGI6p4lKmBjLMqLFV34CmHjDyNzbIwsQbp6n6JPDugOd3h6ewudEUY+YTUmTSbab3uaUz01GxED76MtNOFhqlF0Q79cHQrJKezq8mD5LCBr86eAD4wSBSbwuLIGR/uStZhORku8XNGJr372kzCZVdGzb+CLpWgNo8Bh7iKw96/bUDeb0+aGHR0KGyBZ1FKciXWaUEZVaRAsb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93AUsCRSNNw82yy6uwDxhjb/LIG0+QN/W7TWNj0YMxc=;
 b=WWatQdmm5dlLcxlyRGDCAcw1M//t1qKYQwHjIp9tjI/DI3JMPq7I1mF1yI7JjKSXEr/PRgAGeqKVB6ZnhPR2ncDjP/bGfJarVKJBDxROXp3dBgDl4d0V/q5NWqTz2DNDUHTp0qu+qKEoPq+pd2JGCyKizj3iYVosTO8jMuFxhKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 28 Jan
 2026 10:45:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9542.009; Wed, 28 Jan 2026
 10:45:26 +0000
Message-ID: <d8050829-e927-406b-bf16-d38c314456d6@amd.com>
Date: Wed, 28 Jan 2026 11:45:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
To: "Wang, Beyond" <Wang.Beyond@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Jin, Jason(Yong)" <JasonYong.Jin@amd.com>
References: <SJ0PR12MB69035C332189D35E4D5A81C6F797A@SJ0PR12MB6903.namprd12.prod.outlook.com>
 <547a73eb-edca-40c3-a22b-8403dba49a30@amd.com>
 <SJ0PR12MB6903D0FB966D83323492C65CF791A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ0PR12MB6903D0FB966D83323492C65CF791A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:408:113::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: eadbc598-22c3-4938-b616-08de5e5a58ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3M3dUxmYjJOSVF6Tkx0QitTeVYya04zMlFwdG5xRXo5RnJhVVlhUXdCWEs5?=
 =?utf-8?B?bURoS1crMzQ1UnlRSUxYeXhIY1ppSjAyVDB3a3lBSEliMEt4VmkwQmVQT2s2?=
 =?utf-8?B?cjUyMjFVS0JwZEFaMmtHWGhEY2pzSDJNeXJiZVkxYjhCblZEeTRTbWx4SW5r?=
 =?utf-8?B?NnZteGpKVzBQTTB6R3Z4Um5yT3Z4T3k4WTQxbWVzWkdiTDlPYmV3ekxZZHFB?=
 =?utf-8?B?U3ByeitUbEIwZmE1QTF4UVNseHRRSHBwZ0VNL3FsS1UwTTczUWRoemhiZlI3?=
 =?utf-8?B?VVp2L0xGQzFackVpVjEyMUZYZ3Z2VDZWRm1yMDQ2WTB5bTFSaWRFVldUR01s?=
 =?utf-8?B?TVdOcWVyNUhMc0lhZktmbWs4aU1iOVNRSXF1QUVjLy9zNlZWYmQ0K0E3NHgv?=
 =?utf-8?B?MUtBSC94aEVNRTlLd1lKV01vSGljRVM1VElJN0t4V090b0N6TXRkOHhjRzdr?=
 =?utf-8?B?d2tUSC84SVpQV0JhdktqMnd0cnJ0amFGN3NQRDJHUjdKMFFUYy9PMXQrdS9I?=
 =?utf-8?B?d0ptSFFRd0JvaGcvNDd2ZS9sVlMxcTdpUTBLN1pVZUYza0xtcVYyUkNsTmlw?=
 =?utf-8?B?Q0VMT090NEh2SmFjUDJzSjNLdGV3dWRoellWV2FjUVNEb01TUFVoMU1DOXJj?=
 =?utf-8?B?clBua2ZoNTBIclA2enRUTy9reUxsV3g2U2hMdThGcXdrSktKQU5jNWVLZU1D?=
 =?utf-8?B?NHdpc0ZGckV2Smp5MVpSLzJEaUJpNVo1RFZ2ZjZDQkluNHRMUC9WeEd1eWV6?=
 =?utf-8?B?M3FMZmE1RXlYdlZoSitVenNseXJ3N1NVQ3BVa2luMmNPSm5Vby9MTGUxNUpM?=
 =?utf-8?B?Z1hlMGM3WVVIRXUrYUNHaUtqOS9yNEFGc0lMaklWZ01Qd040cmZlbER0czNU?=
 =?utf-8?B?dEpIRmpSL25XOEdqWVlYaHFUd0pNOWZ0OENNa0VIaVJYNzlEa0JqN28vckRF?=
 =?utf-8?B?QWk1Y0VjZXVleGEwQ0kyR3B5bmd6VVFwNVFIZUc0djVJQThFN1BwZFR2VjlF?=
 =?utf-8?B?dEQwNk9HaVN3cGRIcWYzVjRXUmczYkVsYTZaTmR0NDQwWm9XZW9GNkl0YWIy?=
 =?utf-8?B?MElCZDl3Mi9DLzljUHUzUEszYmlHd3dVSkpWbTV5T1RLSnJGUk5wQ1hkSFR4?=
 =?utf-8?B?WHlLYkpZYllTV1dpWEY2SVprZm9GcmpGZVhIR3Q4dkVTRTUxc3Z3NHlIVTFC?=
 =?utf-8?B?UUlBd2sreEtHVWJXYlRBZndabnhFbDZ3eStoakRCMVlXL1hOcCtmRXBUZlJU?=
 =?utf-8?B?Z2JzNU5CeUZjd2xyc0NkMVl5QUlkV0xZM1RTNllESmswUFBFN1NpbVc0ckcx?=
 =?utf-8?B?NjhsZ2FmLzQvSVdINE8yNjR1RjlaY1BvcFVvRFA2U1RxbFJPek9PaE5Sd2Qr?=
 =?utf-8?B?TXdFZjRWbktpN2k4WjVBM0QxaFV5NUtocGx3d0VxeFFLNUZxSzEvRUlNTnhq?=
 =?utf-8?B?ZVk1M2NPN2hUZEsvbEJLTG9uU1BlaGdJZ1M5MlV4T3NDdVQ2NTBnUmVrOEd2?=
 =?utf-8?B?ejdjTkNNVVFBZnNaRStFRHlqZmJ1SU41aUF1QngxaW9idEtsSGw2WHV1WXhk?=
 =?utf-8?B?OGE2cVVLcnJEeVRudFJUT21ZQ2RVZnBlcnl5N1RWTjg2VDZ2NE1GdU1SWjk4?=
 =?utf-8?B?UE1NUElOdC9ZcVNCT05KSzNxR0Qxcno5Y1daRmg5TzJYeHlkVTJERCtKSisr?=
 =?utf-8?B?WkdlYkRBN0s2b29rRXhWM0sybDB6ZDZob1pNOC9wZmZHdGc5bE5BaDlzMVRr?=
 =?utf-8?B?VVViNGFOVlBoSnRCVWJoZCs1WUwxQURsZ1cyc0FOeVRBeUhIMXp6NXVFQ2JO?=
 =?utf-8?B?cHVrL0dmUE1hQ3k0eGZ4MFhBK1E5OHZXK3RhN1VSSXBPZSs3L1BqcUtuQ0tZ?=
 =?utf-8?B?RTdoV0o2S2pUSmNHTXFpdUJBaEcvcld6SDBJcnFvNzhTb0R2U01OUmdWa1ha?=
 =?utf-8?B?UmJzejhwMFBraHI1MWdZYkNlOWN2ZW01NFpqMUdiRFp3ZCtBU2dsQi9xdTBz?=
 =?utf-8?B?S0tra1E2L0EwQ1VMSUt2Z09tVFpMdGl2NUFXWW1lZ2F4djZTc01hL2pCTGxV?=
 =?utf-8?B?QU1qWnFSa3EzVGxvZEdsQU5melVCUVRBSFVMRndOaDFCT2ZEU2pYenQyWEZW?=
 =?utf-8?Q?VjpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktvT2d0dklIT1BSdmFYVW5yME1aTWtYZ3VZVjNYUU1pRE1SRGgzQUxCU2po?=
 =?utf-8?B?cTlLUnQ1SWh5cXVzVjhJVVVGNFZKV3lPMUJzaWJmNlc0L3B1cFluaEZobUdH?=
 =?utf-8?B?M3JJRWFhRWhOUXdkSkMvZlpaOTkxWS94UmdNVGhqcFFBQk4zSmpvRzBkbDlW?=
 =?utf-8?B?UmNLWFdpUGs1SXZrQk9lVG1UUHFJd0dpbDFTYTlsZlpVZEgraS9QN1JsSWph?=
 =?utf-8?B?eGxqWUdUY1dPVmczT2s5TzE2QnR3Qk9jR29veGtvdXR2OS94eTJrYmdHQVZ4?=
 =?utf-8?B?NGNsS1VNRWxqZXF5WUFrYzJxZWE1TnRicG1sQlJPT2NaZG56V0owUUJNb2Ey?=
 =?utf-8?B?blVhSjhTcGJ3U1FyNFZwbEhlVVN0bFdwaWo4WCsvdWhEZEJaTTJFUWdJK095?=
 =?utf-8?B?cmsxa1Irc002N2JwWlEzWm40UVpQTDVjTWdPMEpVZHA3VGt0RXdzc2pVL3hX?=
 =?utf-8?B?dGZhbitLVzZwREh4aTFJR3NwajByUlc3b0tVVWhua2JqZ0daQnhhM2FwVC9U?=
 =?utf-8?B?amRtQmlTZ0lUMFlSeEVHMWhMNTlXOEdQVEp4bGRBWFNiazRjaTdtSG1tZFlY?=
 =?utf-8?B?UG13aG43SVdNVEtGa0xPTDBxcFlGMyt4Z0d3VE80TTRuMW9sb3BJN2Yrajd4?=
 =?utf-8?B?Rm84eHE0NGFGbXhzV2dNcVpjaFl5NlV5dit1Ukx3aG15ckZpSy9OTWpEYTFl?=
 =?utf-8?B?VzZ4Yks4S3FNNlFzOEtOdzVzb2RtRGxlL0l4NHFqdFNZNDBmbkNOSUpwZDlu?=
 =?utf-8?B?bVhxNDdRWHZ3SWZiZUhtSVcvMWxUSGU0djlwTFZFenVvMzRBTUFjdnUzS3c5?=
 =?utf-8?B?YkRvUXduQitNaUxPOEdHd3Z2ZTk5MC9PbzRKaERlM0xobStEaStoMUIyeGV2?=
 =?utf-8?B?c1E3Z0FQVWUxUnFGOVczdFluUHZwWFRpQkM5SWlFTGI2bkRtV1BJdWpRSEd3?=
 =?utf-8?B?OW0rejVLZVJ0VjdpcnJwY2FFMUdFK1dXbVF3TStxcjUzTEk5bnRwU3VaOEtp?=
 =?utf-8?B?ZTFjRFpaU1Yyb3hKbGVBa1NNYjVwcndFb3V2bEFDK1ptcWJqWVgyY0RDdzQ3?=
 =?utf-8?B?bE9TaEw2QjdYbnJDNjQzVytHUU51MGR3b2lRQXVzN1NFMlZDNWpIL2FnSHdV?=
 =?utf-8?B?RmZ3VUhGY0Y0U3drSllYOFhjc2NidklBK3phQ2ZQS0FMUGVscXlsemhNQ1JK?=
 =?utf-8?B?VzVNamtWM05GSkNIdkt1N3FaVzdNY2xwanNKakY4VEhFMkJYOXQ1UVB5bVM5?=
 =?utf-8?B?alp4Y3hsTmVINkxpVzVmK0FyR2R6SlltaDA3ZWFxQmV0WGpwU2hWaUpweWpI?=
 =?utf-8?B?NlVrblg2eHZ1OTNSNnVnQXdEbmZ5QUxJa0dyaWdOR3VPMHladytkSHAvdnBh?=
 =?utf-8?B?ODBOdko0VHh0S1NYUHp4TlhROWF3N21IWW01amRNcm1Od3UyeTNyS1VobERl?=
 =?utf-8?B?S1dKUmdFT09MSVhMY2FRZ0ViYUNEZEpSMDJWQVdiWlFEZ0dXM0I3Nmk2cVQw?=
 =?utf-8?B?VnVOWDVCRS9zOXZsYk5sbkp4WnhHQXg0c2VURXlQVUZhZUdZQXEyZlBDcFJM?=
 =?utf-8?B?RXRNa3VuKzlZbXNNaXdhZVVvbWxSMjdrazdTWTVEWEtvZEJ1YStNZ1AvMjQv?=
 =?utf-8?B?bzBGQU8rdjdzT2ZUbGc0NVA1RFZ6d3N2eXRPcWE5NXJnMjdaWFR2OXVVMTJh?=
 =?utf-8?B?SUc0alVNT1JTKzMySUd1K0xEbXRxeThnU1FoeUVQaENRbENDRlZpWUVaZEZJ?=
 =?utf-8?B?eGc5TWRMTklzODZXb0VJRVkzSWt5c2xYck9VNHhjMUk2Nlg1ZzI3KzFuWDNE?=
 =?utf-8?B?OFczL3lQZU5qOGNXMWluUG54dnBLcjRERXcya0QweDZzL0dadUpLWnlzc1JT?=
 =?utf-8?B?OXNCSFpzKy8zc291clBnL3hWM29iUkRzUWx0STk0NGRCbytRMUc4YTE1TWYx?=
 =?utf-8?B?TWJaREhPY0owcFAwZ1UrZEV1cWt3WkduWUYrazlxSDY2dHRKODhuY0dUYWlo?=
 =?utf-8?B?ZGs0cDRoR3VHSWVJRUFJb2JBUkhEWUY0c3ZOWHBLYjRrelFzUzIxczh4anIw?=
 =?utf-8?B?Qm9TeThrUTM0cmVCRlplOS9sRlhRYVVoNjRsSTRlMDZSSVNxUzhCcCtXbHZB?=
 =?utf-8?B?UmFOQ0t1aU5EU3AwT2JpSVl1SDk2VFkyK1R2cGRvbytMdlpic3ZHdzU0bUI0?=
 =?utf-8?B?TXJXdDBUUHlzZXFYUlUvMTEyUlpreTRTeit4RmNoWTliQzVhbUdEeE9TWi9s?=
 =?utf-8?B?WGIzdUppRW82NGFBRXpsWmZ0STJGU0hJQzYvUUJ0R1JkaWtaL2dISDNpeU15?=
 =?utf-8?Q?Ub0DKQsiDNJRIBYB18?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadbc598-22c3-4938-b616-08de5e5a58ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:45:26.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By4i9So42tq+diwzz2B4mJf/c/cfQrYDDrzOr5S3OCxtmqNDkNh9dOBEobLhEr2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
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

On 1/28/26 04:31, Wang, Beyond wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
>=20
> I see.
>=20
> "Additional to that BO lists are not really used that much any more, Open=
GL Mesa has completely dropped them IIRC and RADV isn't using them either."
>=20
> I suppose this is a corner case, here I'm facing a Vulkan App uses lots o=
f VK_EXT_external_memory_host,=C2=A0 these kind of BOs created from amdgpu_=
gem_userptr_ioctl,
> and can not be VM_ALWAYS_VALID, that make UMD have to pass all of them to=
 KMD on each command buffer submission, this makes amdgpu_cs_parser_bos tak=
e
> much longer(~1.5ms on strix1), that's why I'm trying to reuse the bo_list=
 handle instead of let KMD creating temporary bo_list on each submission.

Yeah that is completely expected and can't be optimized much.

As far as I can see there really isn't much you can do except avoiding to u=
se userptrs.

This functionality is only really made for temporary uploads and can't be u=
sed as performant replacement for buffer allocations.

Regards,
Christian.

>=20
> Any other suggestions will be grateful.
>=20
> Thanks,
> Beyond
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:*=C2=A0Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:*=C2=A0Tuesday, January 27, 2026 7:47 PM
> *To:*=C2=A0Wang, Beyond <Wang.Beyond@amd.com>; amd-gfx@lists.freedesktop.=
org <amd-gfx@lists.freedesktop.org>
> *Cc:*=C2=A0Deucher, Alexander <Alexander.Deucher@amd.com>; Jin, Jason(Yon=
g) <JasonYong.Jin@amd.com>
> *Subject:*=C2=A0Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free whe=
n reusing a bo_list handle
>=20
> On 1/27/26 04:12, Wang, Beyond wrote:
>> [Public]
>>
>>
>> When a bo_list handle was reused across multi command submission, reusin=
g
>> of those allocated HMM range structure can avoid redundant allocate/free
>> operations on each submission.
>> Doing this way benefits the amdgpu_cs_parser_bos time, especially for
>> large bo_list
>=20
> And creates a massive security issue, so clear NAK to that.
>=20
> That we have the HMM range in the BO list is extremely questionable to be=
gin with but wasn't doable otherwise in the past.
>=20
> Additional to that BO lists are not really used that much any more, OpenG=
L Mesa has completely dropped them IIRC and RADV isn't using them either.
>=20
> Regards,
> Christian.
>=20
>>
>> Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
>> ---
>> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | =C2=A04 +++-
>> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c =C2=A0 =C2=A0 =C2=A0| 16 ++=
+++++++-------
>> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c =C2=A0 =C2=A0 | 19 +++++++=
++++++++++++
>> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h =C2=A0 =C2=A0 | =C2=A02 ++
>> =C2=A04 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_bo_list.c
>> index 66fb37b64388..9c662369d292 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0refcount);
>> =C2=A0 =C2=A0 struct amdgpu_bo_list_entry *e;
>>
>> - =C2=A0 amdgpu_bo_list_for_each_entry(e, list)
>> + =C2=A0 amdgpu_bo_list_for_each_entry(e, list) {
>> + =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_free(e->range);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_bo_unref(&e->bo);
>> + =C2=A0 }
>> =C2=A0 =C2=A0 call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
>> =C2=A0}
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_cs.c
>> index ecdfe6cb36cc..fc195fa2c0c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool userpage_invalidated =3D false;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_bo *bo =3D e->bo;
>>
>> - =C2=A0 =C2=A0 =C2=A0 e->range =3D amdgpu_hmm_range_alloc(NULL);
>> - =C2=A0 =C2=A0 =C2=A0 if (unlikely(!e->range))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 if (!e->range) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e->range =3D amdgpu_hmm_range_alloc=
(NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(!e->range))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_reset(e->range);
>> + =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_ttm_tt_get_user_pages(bo, e->ra=
nge);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r)
>> @@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
>>
>> =C2=A0out_free_user_pages:
>> =C2=A0 =C2=A0 amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>> - =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_free(e->range);
>> - =C2=A0 =C2=A0 =C2=A0 e->range =3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_reset(e->range);
>> =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 mutex_unlock(&p->bo_list->bo_list_mutex);
>> =C2=A0 =C2=A0 return r;
>> @@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parse=
r *p,
>> =C2=A0 =C2=A0 r =3D 0;
>> =C2=A0 =C2=A0 amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 r |=3D !amdgpu_hmm_range_valid(e->range);
>> - =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_free(e->range);
>> - =C2=A0 =C2=A0 =C2=A0 e->range =3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 amdgpu_hmm_range_reset(e->range);
>> =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 if (r) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D -EAGAIN;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_hmm.c
>> index 90d26d820bac..5b72ea5a3db7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(str=
uct amdgpu_bo *bo)
>> =C2=A0 =C2=A0 return range;
>> =C2=A0}
>>
>> +/**
>> + * amdgpu_hmm_range_reset - reset an AMDGPU HMM range
>> + * @range: pointer to the range object to reset
>> + *
>> + * Free the hmm_pfns associated with range, but keep the allocated stru=
ct range
>> + * for reuse, in order to avoid repeated allocation/free overhead when =
the same
>> + * bo_list handle reused across multiple command submissions.
>> + *
>> + * Return: void
>> + */
>> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)
>> +{
>> + =C2=A0 if (!range)
>> + =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 kvfree(range->hmm_range.hmm_pfns);
>> + =C2=A0 range->hmm_range.hmm_pfns =3D NULL;
>> +}
>> +
>> =C2=A0/**
>> =C2=A0 * amdgpu_hmm_range_free - release an AMDGPU HMM range
>> =C2=A0 * @range: pointer to the range object to free
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_hmm.h
>> index 140bc9cd57b4..558f3f22c617 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>> @@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_not=
ifier *notifier,
>> =C2=A0#if defined(CONFIG_HMM_MIRROR)
>> =C2=A0bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
>> =C2=A0struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *=
bo);
>> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);
>> =C2=A0void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>> =C2=A0int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>> =C2=A0void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
>> @@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_rang=
e_alloc(struct amdgpu_bo *
>> =C2=A0 =C2=A0 return NULL;
>> =C2=A0}
>>
>> +static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *rang=
e) {}
>> =C2=A0static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *=
range) {}
>> =C2=A0#endif
>>
>> --
>> 2.43.0
>=20

