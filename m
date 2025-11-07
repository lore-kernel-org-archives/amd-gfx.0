Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E379DCCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 10:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865F310EA5A;
	Fri,  7 Nov 2025 10:01:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5oUsiqf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880B210EA5A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 10:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ6ZKVL6B/IF1P/yH1o/Nut7n3V/0KjmBWfMwBDgJn6Sr5W9QDAluhwPlWKSJAlEc5LI917rwIdM5B/y9LVz6FM0SgNJGU9YUK2OeKtGx4e5Sj8k/pzZZxFFAOPQs5BR/aNa5YaRzswmGR/ZWoPQBZ/x5C/Ezliu42QMsB70Z/przDH6TUL0FuWCAn++gIaKiATKzACoMpts64mlquOnT8+3KMgUeFar0lBy+XGBBa0CRjH3hpQFENH03ake5DaF9Y48fvyMi3B7otPJ1QA4xFhIbyJM26TvrSt4+XEts7fbXRYx7/OfvY4SnFhPxk1knayT/YwIhd0XsUwoZWL4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9iroCEIukLO7NsfMBnOUT9ZVjwqObi22E+GBm0jLnQ=;
 b=ccG7o8hgh1MgqOqtZkgHQm7vO5eWfCxgKz747TDDWo9Za2OnxUqcf+LxPJDMKRD7xCVrxwFZlDJeUQ98ycTmTgHafFQh9k2bSGZSrW8LFycAJsIAT3IKf53R+Nnc+rIYE4WFZLeSsgLNMa/TdfTPxcFzRWHo8luAM51ddX/LFrEsnQeQ8okH0fFvYdxjE0AJJ+Qbs+lcATgEBgSz140QOb1QRIStl6RVwzjUZKXh/IKtz5cwuVnlzBmxvpLoOiLKTmjRPsY29LWQk7dBMjNETSuKNzaaEw16myx01UK0eb/G+kAEcefNzHRUi+H+aGrEuUDwA3QTZN7ttSWqI0lMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9iroCEIukLO7NsfMBnOUT9ZVjwqObi22E+GBm0jLnQ=;
 b=l5oUsiqfmfe9IGi4nwfqwBR6NniTN9vKLVgzY447pfc4CZyvWb1q3e4TDBsZ6Jd+/ijlqbhet//RYXgn8gBaoAVCpt3KEV1AQzeekWtEBAcaAGUjem9VlTfASTwclE2KLNhvxvN4JKy0jWMh4eLhkiH2Z53NR4zvoDkfw82SfpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 10:01:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:01:24 +0000
Message-ID: <f0bbffa2-3b34-4f36-9fb2-44bcbcb5b8a3@amd.com>
Date: Fri, 7 Nov 2025 11:01:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] drm/amdgpu/vce: Save/restore and pin VCPU BO for
 all VCE (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>,
 "Dong, Ruijing" <Ruijing.Dong@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-7-timur.kristof@gmail.com>
 <991f6d36-81e4-42d2-b301-0755fa00ffde@amd.com>
 <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b7eb6efea5606c6d9b6d1bcdea6552b3602517bf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: 5115b130-4589-4f97-451e-08de1de49c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUpTaUlkWFZIZkVFSStibGtuRkxSK3NVSWZBeEkydEhmVVc3Z1pNSmJlREN6?=
 =?utf-8?B?MHFwM3JnQUI2YkYrZmdaNlBSNmo5WldpR01mRG9LYUF0dFRrWElqRXM2YzF3?=
 =?utf-8?B?a1ZIUG9KTXgwejNwVCtxQzIrN210V1dScVZmc0U5SUJVUnp3UnV4STBENEZz?=
 =?utf-8?B?Q2lIQmRHa21nSUJHbEVFZTJWTTV2cTVERVJjNWk0V1FqQ0dkREcrbkI2YUU5?=
 =?utf-8?B?VEVvb05ES1VkOW1hVE8zeHB3M3BBRWJFOUhxL0wxSnpad3d6aTk4cDVlclJE?=
 =?utf-8?B?dkZqbVBXL1hWOGlyQ21zVHBMY2hxT2c1NzhhRG5iQTNpSVBPU2ppbUtCQXZT?=
 =?utf-8?B?TlpENVhteUljbWJadzliRlhxMjlzek5IcGdaZ2J0bENpNTBaZ2R4S2JFL0Qx?=
 =?utf-8?B?eVF2aGdDdGxLRmxXSUJ0b0lJWGhGcWhJa1ZUNWxmMTJYeHFrb1VDVFA1b1Bw?=
 =?utf-8?B?UHRGNnRIQVJXaWE5Vm5jL05yajRCRUNJMDdZUlZTQnNVWm5yeFFsM3lmb2tQ?=
 =?utf-8?B?SEdnVnhYNEJtTjM1Y2ZRZCttd0hyYkhnNXR0SzB6MXNrWStEZDdHZm9WZndQ?=
 =?utf-8?B?MFcrSGU5cmVWTys1OGtwUnE2Wlg5NXRyOGRhTFNYUnZkc09jSmRMTzFKdGVr?=
 =?utf-8?B?ZTFHSTNFTVNGZkJDVUhCSUY0azQzVmtOMkJVRXZiOGFxc3lpeGZ0RVI4NVR2?=
 =?utf-8?B?Rks0UDFJb3pZejRUWFpTSXROMHcxUEF6dlo5S3ZNMk5TczlJVFNlQ01DV3A1?=
 =?utf-8?B?VHgzQzRRQ01UbE9lQklNSWdma1pIOGcrc2xGZWxxS2sxS0dFaGlKRFg0bEt1?=
 =?utf-8?B?d1d2RlBFRS93S0xIcDFCRFczdG5vVHYyNE5USTYwcjR5NWU4cWV1QjdiWU9y?=
 =?utf-8?B?bHpmMktidnVYbURKbUplTE93OXpKYndxOFpmdm41OFpiTjFBL0hoRjB4QTEr?=
 =?utf-8?B?L0VoQytMaitTZjBWRm9RbUJzY250RFkwd01QUW5oTmUyalJja0VmMzFiR2VG?=
 =?utf-8?B?eHF4cTBzTHV6ZXFodmVhTlZVcm81QWhnbzRPRDBPb1RuMUl3dVdBd01FZ2tE?=
 =?utf-8?B?aU40NFpEUk80MStwUmpEaDNzS1FJNWRIbzJ1RmVNZW5IV1h6VlA4YnZId1hR?=
 =?utf-8?B?elhrU1FZQkFXTmI0QTRacThHZnl4TzREeVVuSlQwWTlvZTVTMGVOMnA0OU1T?=
 =?utf-8?B?NkVUa2NJdyt1T1d3YTM3dGJTZ2VnWFcwZTROSmg2V1pzZWZ2N2xGNnYzaXEr?=
 =?utf-8?B?WXI1TTNqT1hEZnd0ektUSURaRXBTZStjU2wwVE9STkRxTklzUTRsQm45aGh1?=
 =?utf-8?B?N0pDeUwzMGI0eWZOZzVTdkk1VXdOMTVhdUtRVmpJT1VnNDU4WU5jUThxS2VW?=
 =?utf-8?B?czd6bkxZTWpKVnRSOVJDTDBSU1JwdFluRWJraStJN2toVHBCWUpvbmdRTVdY?=
 =?utf-8?B?Q1pCOXlEQUl2U3FXbXhRWTZrTTVQcXBnRWUzS3l3S1hpRE5kVmxQRUQ3bVgy?=
 =?utf-8?B?N0RxK2NSV1g0aWVCMTFXSEhjeTNSMjg1alI0OTBLNllrSk5ESnJrYXVBYjRy?=
 =?utf-8?B?blpOS3g4WGM0QUpuZzRyNzE1bU9CZ2tXbERzOEVkUTdzZkVLVmZBZEMvU2Vo?=
 =?utf-8?B?N05CS1QrejUxSzlJMFI3SlAwR3NXanBnaVVnQ29OeW45OXY4QlAyTGgvUjN4?=
 =?utf-8?B?ME1BcWdTRVBTZnZTNFRaSnVGT3dGVVd4NmlGNmVzVC83ZGFXZEFzSzExclY3?=
 =?utf-8?B?L1NjN1I3RUg2RS90VGZkR3A4UU1uVmhpUzYxVEJpTzN4aTd6N1VvZTk1bUZ6?=
 =?utf-8?B?U2didDU3dkZHNU1DMGc0UG5oQ08rTWp4K01HWmkwR05MSWliU1R4R21nUWlK?=
 =?utf-8?B?ZVB2ZlhKN1BTVHBEbjYvaU1yREFpd3ZPaS9yRWRpRzdUc3VnMi9xVTE0TSs3?=
 =?utf-8?Q?jJVq6IEMe2hi7NAn0YzzyTpjBETR8P7i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnF3NzUzL0RQS1gyMUN5dVQ3SzNRV241L2M3WUE4V3l2OC8rV0pjcWpETWlO?=
 =?utf-8?B?MWpzUXFBbitjK2RHR0NVV2V2OXpYYk5wQUZvTzRhOE9SdkRyUVVOQSt4WHZz?=
 =?utf-8?B?bEJBVURqY0hScmZ2UjVGVXBDWWl0M2J4SUFFQlNCSG9aMW5DSHhQbng0YVM2?=
 =?utf-8?B?V0pWN1VFWGJxNkxPMzRUNFRRVzVnSHBJNDA2Mi9FcXFRem5RbmFIUTAwb0NW?=
 =?utf-8?B?WHFLMGVOR0Q1Y0MvcWhTVlAzdC9Oaml0M1ZuZ1NLdkpqNy8rcU5vRXVXYkVP?=
 =?utf-8?B?aHhUZmtORmRrRlVCeW9jUC9JdTJKelgzUnJaL0toNk9vaWk2L3dzeDhqdXF6?=
 =?utf-8?B?blovR3B0Q2MvcGdrR3d0bnNBMnVPL0o4elFuRERvQ1JaTUkxZFJUbEVISFpD?=
 =?utf-8?B?WjdvMWZtajM1dWcxYlN3RHRjZGhVZHpaYS9HM3hQMUFiZGl3akVzQ08yaHdT?=
 =?utf-8?B?U3dGMzFvRXhHYkZZRmh3L1doTko5clBlTCtlWEpTa0JXQkN5VURpY0pqZTdM?=
 =?utf-8?B?d0R2dS8vK3RtMVR5aXV3RTNYUlhsMGVJdGdtbjVrK2VkVzZNS2lXSDl2MDVO?=
 =?utf-8?B?c0xOT0lLMUhLc2dQR3U2TkJrK3AzT2xia1AxWk9NSFhmVitBYjZaL2phWFJP?=
 =?utf-8?B?ZDlNdjhYWTlvdjdzb0FSdGlqVksrZUpOcHJyNHdxcEJSc2xBNWdwOGVQc0t3?=
 =?utf-8?B?ejFCbm02a0cwUDZzZ2ZobW15cTBQOHNnV0hORWZOeGxSeFJ6a2p0dEVxZUxY?=
 =?utf-8?B?alE5ZTEvUFF0YWhYS01JOEcvcDN5MnNkeTJmc0g0REVpeVFac2pFRnA3ajNN?=
 =?utf-8?B?VTkraFU5K3ZjdDhUMXE5QWJOaG45eXM4RDd2Y2EwZitNRFZqMmN4NlF1Y2kr?=
 =?utf-8?B?RWkxTGRhL2JpN2xmV1BvZi81ZEhlelBCUTkzZ0ltaEdoM0pwR1FFdDlMUkJi?=
 =?utf-8?B?S3BJN2Z4V0p3K1JYdmxJUFlZS1VVc01VdlJMUWNyVE1LMFdxelpsMTBTR01x?=
 =?utf-8?B?OHllRmlVZUpVU05oemJPeXlKMnlINFgyRnFLaE1YcWl2YWxMYVF1SllFcnFB?=
 =?utf-8?B?MGRDaFdTYVJvd2FEY2VvRUhNdFVrd21XcVJONDZaaTdHbDdySTJudW52dFZR?=
 =?utf-8?B?MlRubXRTaDh6b1lhQmtEZVgvREJsa3NWTmF0TnZITWM1Q0g2TUl6QnE3akYz?=
 =?utf-8?B?SUR6UlZ2QVB0a1dSYnhrUzFkVHR6cDdlc1NvRWwzMnVZVmF0RStZSENSZU5z?=
 =?utf-8?B?Zmo0eFpneDJxSTIrV0dCc0FMMWFJRTR4VmV1MVdPcFhKSGp0NW5LUXByOU9r?=
 =?utf-8?B?cy9jQjEvckprU0Jaa0cwYU05bFNkRGMxQzFiMzNKTjFXZHlWWjRGRUxCQUIw?=
 =?utf-8?B?TlUzemJ1OFJQSU9FZ0x4UWZ6RUZQbXZUMGFrdEo3NlBHeDJibDJ6VDFFMXBY?=
 =?utf-8?B?YmEycExOU2s3N0JSQU9ZQWJQN2pNSWZoOU9iNkZCWlF6WGRXdnROUVlXSnNz?=
 =?utf-8?B?VG1zTlhuRDdRSHN4M3g5UzNIQ2xJQUo4THBaMSs2cjFiTXkrak5jZ2N0V0tS?=
 =?utf-8?B?V2dKdFFOb0oyOHJHTGVxbGwvVm9DcjFkM0JQVW8xN1VSVS91c2M3S1J1L2Js?=
 =?utf-8?B?L1Fyc0MxN2V4bHZQMGV5RUpxSlVPeGZQdkVvbHhnMDBhTG5LREd5eTB2eFFN?=
 =?utf-8?B?NU50S0JlWkhBYkFsV1R3L2RqN25DY1FaTThkclJKdEdUMmNjMktqSHRuQllQ?=
 =?utf-8?B?QXBLWmFRSThid1F5dXl6T05GQUtrazRISDJad0haTVpTZzRJVVN2UUhlRytD?=
 =?utf-8?B?Qis0SExFQXRhSTg1K2Rvb2NWOWlDK2Y3SCt2ZXZJcjdGdUswTzlQV2tYSXpZ?=
 =?utf-8?B?TXpQQkpFRElDbWEvR0tiWCsybUo5dmZMZDEzVTNhS05vTVdCSGpvNVNOSGtM?=
 =?utf-8?B?dkZOcGIwSTkxQVNTZ2IxcnBiekZ1NEVuTUV3Y1paYmswN0ZuM3VjSnYwZUg1?=
 =?utf-8?B?eXBoR3JRZW4zbytkdTlTV3l4S29jb3dia2tmQ2xFcjVnaXhkN3R6L0Vudmdv?=
 =?utf-8?B?SlRiNW9NcVkwVmF3NG1Vc0Q0cXVjcURDWUthQUttM2lHaVpVUFRrTngvMUx3?=
 =?utf-8?Q?8edO5pChEdiHK3cuRRGSJKxs8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5115b130-4589-4f97-451e-08de1de49c56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:01:24.7368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI0jawwpjlTH3MESQde4a3w/faS/e/AwzmLt2mm2CWahKvOHpYzgDSP3o9MuR+qo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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

On 11/7/25 10:53, Timur Kristóf wrote:
> On Fri, 2025-11-07 at 10:49 +0100, Christian König wrote:
>> On 11/6/25 19:44, Timur Kristóf wrote:
>>> VCE uses the VCPU BO to keep track of currently active
>>> encoding sessions. To make sure the VCE functions correctly
>>> after suspend/resume, save the VCPU BO to system RAM on
>>> suspend and restore it on resume.
>>>
>>> Additionally, make sure to keep the VCPU BO pinned.
>>> The VCPU BO needs to stay at the same location before and after
>>> sleep/resume because the FW code is not relocatable once it's
>>> started.
>>>
>>> Unfortunately this is not enough to make VCE suspend work when
>>> there are encoding sessions active, so don't allow that yet.
>>
>> The question if this is the right approach or not can only Leo and
>> Ruijing answer.
>>
>> If we can get VCE1-3 to keep session working after suspend/resume we
>> should make this change otherwise we should rather make all old
>> sessions invalid after suspend/resume and only re-load the FW.
>>
>> Anyway I think you should make the removal of "amdgpu_bo_kmap(adev-
>>> vce.vcpu_bo, &cpu_addr);" a separate patch, cause that seems to be a
>> good cleanup no matter what.
>>
> 
> This change is necessary for the VCE1 code when it loads the firmware
> signature. Without this patch, we would need to call reserve(), kmap(),
> kunmap(), kunreserve() in vce_v1_0_load_fw_signature().
> 
> Let me know which approach you prefer.

In this case definately make removal of amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr) a separate patch.

I want to get initial VCE1 working and landed independent of what Leo/Ruijing say to suspend/resume.

Can be that suspend/resume is then still broken, but that is also the case for VCE2-3 then.

Regards,
Christian.

> 
>>
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 44 ++++++++-------------
>>>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   | 52 ++++-----------------
>>> ----
>>>  2 files changed, 24 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> index 2297608c5191..4beec5b56c4f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>> @@ -206,6 +206,10 @@ int amdgpu_vce_sw_init(struct amdgpu_device
>>> *adev, unsigned long size)
>>>  	if (!adev->vce.fw)
>>>  		return -ENOENT;
>>>  
>>> +	adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
>>> +	if (!adev->vce.saved_bo)
>>> +		return -ENOMEM;
>>> +
>>>  	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>>>  				    AMDGPU_GEM_DOMAIN_VRAM |
>>>  				    AMDGPU_GEM_DOMAIN_GTT,
>>> @@ -254,6 +258,9 @@ int amdgpu_vce_sw_fini(struct amdgpu_device
>>> *adev)
>>>  	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev-
>>>> vce.gpu_addr,
>>>  		(void **)&adev->vce.cpu_addr);
>>>  
>>> +	kvfree(adev->vce.saved_bo);
>>> +	adev->vce.saved_bo = NULL;
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -290,13 +297,19 @@ int amdgpu_vce_entity_init(struct
>>> amdgpu_device *adev, struct amdgpu_ring *ring)
>>>   */
>>>  int amdgpu_vce_suspend(struct amdgpu_device *adev)
>>>  {
>>> -	int i;
>>> +	int i, idx;
>>>  
>>>  	cancel_delayed_work_sync(&adev->vce.idle_work);
>>>  
>>>  	if (adev->vce.vcpu_bo == NULL)
>>>  		return 0;
>>>  
>>> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> +		memcpy_fromio(adev->vce.saved_bo, adev-
>>>> vce.cpu_addr,
>>> +			      amdgpu_bo_size(adev->vce.vcpu_bo));
>>> +		drm_dev_exit(idx);
>>> +	}
>>> +
>>>  	for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
>>>  		if (atomic_read(&adev->vce.handles[i]))
>>>  			break;
>>> @@ -316,40 +329,17 @@ int amdgpu_vce_suspend(struct amdgpu_device
>>> *adev)
>>>   */
>>>  int amdgpu_vce_resume(struct amdgpu_device *adev)
>>>  {
>>> -	void *cpu_addr;
>>> -	const struct common_firmware_header *hdr;
>>> -	unsigned int offset;
>>> -	int r, idx;
>>> +	int idx;
>>>  
>>>  	if (adev->vce.vcpu_bo == NULL)
>>>  		return -EINVAL;
>>>  
>>> -	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
>>> -	if (r) {
>>> -		dev_err(adev->dev, "(%d) failed to reserve VCE
>>> bo\n", r);
>>> -		return r;
>>> -	}
>>> -
>>> -	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr);
>>> -	if (r) {
>>> -		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>> -		dev_err(adev->dev, "(%d) VCE map failed\n", r);
>>> -		return r;
>>> -	}
>>> -
>>> -	hdr = (const struct common_firmware_header *)adev->vce.fw-
>>>> data;
>>> -	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>>> -
>>>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> -		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
>>> -			    adev->vce.fw->size - offset);
>>> +		memcpy_toio(adev->vce.cpu_addr, adev-
>>>> vce.saved_bo,
>>> +			    amdgpu_bo_size(adev->vce.vcpu_bo));
>>>  		drm_dev_exit(idx);
>>>  	}
>>>  
>>> -	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
>>> -
>>> -	amdgpu_bo_unreserve(adev->vce.vcpu_bo);
>>> -
>>>  	return 0;
>>>  }
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> index 2d64002bed61..21b6656b2f41 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> @@ -448,14 +448,8 @@ static int vce_v4_0_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>  		return r;
>>>  
>>>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>> -		const struct common_firmware_header *hdr;
>>> -		unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
>>> -
>>> -		adev->vce.saved_bo = kvmalloc(size, GFP_KERNEL);
>>> -		if (!adev->vce.saved_bo)
>>> -			return -ENOMEM;
>>> -
>>> -		hdr = (const struct common_firmware_header *)adev-
>>>> vce.fw->data;
>>> +		const struct common_firmware_header *hdr =
>>> +			(const struct common_firmware_header
>>> *)adev->vce.fw->data;
>>>  		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].ucode_id
>>> = AMDGPU_UCODE_ID_VCE;
>>>  		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw =
>>> adev->vce.fw;
>>>  		adev->firmware.fw_size +=
>>> @@ -506,11 +500,6 @@ static int vce_v4_0_sw_fini(struct
>>> amdgpu_ip_block *ip_block)
>>>  	/* free MM table */
>>>  	amdgpu_virt_free_mm_table(adev);
>>>  
>>> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>> -		kvfree(adev->vce.saved_bo);
>>> -		adev->vce.saved_bo = NULL;
>>> -	}
>>> -
>>>  	r = amdgpu_vce_suspend(adev);
>>>  	if (r)
>>>  		return r;
>>> @@ -561,20 +550,7 @@ static int vce_v4_0_hw_fini(struct
>>> amdgpu_ip_block *ip_block)
>>>  static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>>>  {
>>>  	struct amdgpu_device *adev = ip_block->adev;
>>> -	int r, idx;
>>> -
>>> -	if (adev->vce.vcpu_bo == NULL)
>>> -		return 0;
>>> -
>>> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> -		if (adev->firmware.load_type ==
>>> AMDGPU_FW_LOAD_PSP) {
>>> -			unsigned size = amdgpu_bo_size(adev-
>>>> vce.vcpu_bo);
>>> -			void *ptr = adev->vce.cpu_addr;
>>> -
>>> -			memcpy_fromio(adev->vce.saved_bo, ptr,
>>> size);
>>> -		}
>>> -		drm_dev_exit(idx);
>>> -	}
>>> +	int r;
>>>  
>>>  	/*
>>>  	 * Proper cleanups before halting the HW engine:
>>> @@ -609,25 +585,11 @@ static int vce_v4_0_suspend(struct
>>> amdgpu_ip_block *ip_block)
>>>  static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
>>>  {
>>>  	struct amdgpu_device *adev = ip_block->adev;
>>> -	int r, idx;
>>> -
>>> -	if (adev->vce.vcpu_bo == NULL)
>>> -		return -EINVAL;
>>> -
>>> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>> -
>>> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> -			unsigned size = amdgpu_bo_size(adev-
>>>> vce.vcpu_bo);
>>> -			void *ptr = adev->vce.cpu_addr;
>>> +	int r;
>>>  
>>> -			memcpy_toio(ptr, adev->vce.saved_bo,
>>> size);
>>> -			drm_dev_exit(idx);
>>> -		}
>>> -	} else {
>>> -		r = amdgpu_vce_resume(adev);
>>> -		if (r)
>>> -			return r;
>>> -	}
>>> +	r = amdgpu_vce_resume(adev);
>>> +	if (r)
>>> +		return r;
>>>  
>>>  	return vce_v4_0_hw_init(ip_block);
>>>  }

