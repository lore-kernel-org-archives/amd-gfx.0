Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD39C369AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 14:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011E10EBD3;
	Fri, 11 Apr 2025 14:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbgJnuF1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB18810EBD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 14:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSZ4EFUhpYr/hC9Tc5NV+R1sUtGD1vpkUKXa/7FBqrHjHUKQN1b+Ou8y47/IUumqBtZAGXXf2RyXyK9DKS52LPN7BB9OwK1htziI8ygONNHJbUBpquRbdjSX3DwMcxHaHREoRG6B7Jcyo/2fQtQFBK92NlAnzzMLVygY75zX92sbgUIvX2bioqWDZNNxlv/Qi41hBOkI+po+LyJGIi3sHH5r2L2c2aQmJEkUxF++wgZ5hlR1T95YDjpWTE3gqGJmAHZHeUhCNTYyNia+APrO6xqbalQi47VP/kTq1jee2DsHydhvuWBcZXBrAHAbGgsPlMOVljhh5xItNJJsHPWlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbVRy+LuBuJXR7XBwBo9DhQFpdVg29NkgUEYe/4cIrg=;
 b=Mtd1x0adcZ0OrN1z31raZ1VOZqSAcXNuQV8uURBDvR94orLWc3qe8jN11RM3DXx30Ljlp0/QrzLHMMiQ4i+UajWW6XdXhhGX/HJS6CycS2czuAy/s9ZTQhEgwiwsZJkwx50M0yIywOsSrEomiCu+hunb1FV/GPabzGsMTzG00/qgMuwGWrJOEFXq2rreoT101L/YFHxfiQM7WpMwJV8Jgf3TqKrZX3ubuNkzkU7Y+8d1zuOF+8cPr70LFNRke6KX2MXG/cRSy4vvCeI3T11/HQyNWcMQk/OBQ71EiXWmtcnlQSWDkLIjzYyaxnx85Wuqo3s7khHC2ydr+pFHMdaz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbVRy+LuBuJXR7XBwBo9DhQFpdVg29NkgUEYe/4cIrg=;
 b=kbgJnuF1NZ1jC2qo0w1jR+gygADrPZVxjU03jYLgBLGloHhFDX6+O1Q6rqn0GNUMZrStDTg05wi5tIoJYi3ZDxEui0LPRa2PnlSHsqq7V0K1EmeLQ0p2N6bPEzLUM5PSF8HHQtVVkQ4RAx90Qq0YakVik49A4Ek3IJQnEdjA0Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SJ5PPF816B88375.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 14:39:28 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 14:39:28 +0000
Message-ID: <ed5bc14b-bf57-40c9-829f-6609eaab9b39@amd.com>
Date: Fri, 11 Apr 2025 20:09:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx: replace a comma with a semicolon
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250411142007.2742502-1-alexander.deucher@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250411142007.2742502-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9c2ee5-da2b-4178-dac1-08dd7906a96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVBKb0U4aFhvT0VzM2lZMFhNYk5xbnlJQyswM3g2YXFWU29UTG5TODZVMHpG?=
 =?utf-8?B?bTVKOTVncUZaS2FlSmJnODdFL0xhSFkwUTlHalhlTnQvSWk0VzhIbnVHcjFY?=
 =?utf-8?B?ZzFmU3NXTFRSSkNQMWZ2aVhsOVc5M21RMG1jZkxtK25icWNYbk5vN1B6YmxD?=
 =?utf-8?B?UXh1RnoxdlF3dFJtMWx4a0JxSGRuZFNDWGFiY2s3MnBVb2VRMUgyUzl4bjRw?=
 =?utf-8?B?QzhzMVRLQy8xNGVGdHV2aURNNGFJU1duRjh4UlhUUjZoU3ZvbXNLK3laWDFG?=
 =?utf-8?B?OVR5eXFvOXZhMThtWWZyeDNuZDJjYkJSUzF4c2VzQ2ViL1RHcllQdzZOUkR5?=
 =?utf-8?B?VTgyM1liQU1jR1ozS1NOQ3h1WG0yNlg5cTh4cFgwUjZjMGRpRjFqR21KRFZp?=
 =?utf-8?B?QldCZHBGL2FnTEVjQ3c1VmtCdU5QYUE0VGk2aG5LZFp1QkNYSU5LUytqVCs3?=
 =?utf-8?B?dTQ2elVZUUJwUk0xa1oyK0dqZ0tMRUdVaGZlTWYzNEpmVXhOTy9YaGV0Mlds?=
 =?utf-8?B?blVBUWtYV3JVOUpnMVlxZjNUZWJPaWwwQ1VOdzFoaW5vVkluWWFKczNLR2E5?=
 =?utf-8?B?UzF4TXJST3Nqc1RFU2NtelRrcTAyS0pHc3ViU21OY0kzOW82VU9IRXRSQmpE?=
 =?utf-8?B?dngvVis2RVZaRkdWN2ZZakhnYVczaDFWUzFQaVZ0ay9SNFREK0xIK2Fpdmdv?=
 =?utf-8?B?K05HWWNUSXllaXlyVUJKYm05UG1nanQ2L3owWVBBOFFUUk9Pa0tVdGlwdkMz?=
 =?utf-8?B?Tmswa2hGZFRiMFA1bUo2VGNRRlJpd0FjWFlFWEFteXNyazhtMTFHeExaZFY1?=
 =?utf-8?B?RGM5QURZQjBiOGZhczg1am1KNEdCWVAyZldJY2xNbmtjVkY3OFpQTUFacEdv?=
 =?utf-8?B?MzlVSUpsMHlpRmpycW9UQTBjeU8rYUZBVkxMNVIyV0wwNldIRTF4TWoyRWN1?=
 =?utf-8?B?UEZnQ1RkTDJ5V3BEb2dWOXNiOW9PRy9UcDc0WTBVOThnSWNhOE9xSVI1R1Rz?=
 =?utf-8?B?clJBbWdtSGZ3RndpNHB0VWs4TFJxTVB2SDlCQ0drY2IwemJsTkFZLzF1VjdC?=
 =?utf-8?B?RlN0WEZyQ05qcisrWDBadkU3WkFuN0swblplZVpQSHRleWxDLzhGRHBIRjV2?=
 =?utf-8?B?emIzcFZCb1NYbTQ0cG1YbUNLVlFhN2dhQVhGK1RiZWdveS9yYWZwWnl1b0kx?=
 =?utf-8?B?dEFVSDBwckdsMlhxQmxmS21sellESzB1bWFpWDhCK3RhY3FkLzk5dG8vMkUw?=
 =?utf-8?B?dU9nNHdQTDRyL2FUNnFMSlZaRURrU21kZGF6MXA2VjE4R2VMRWhiUTVYc0FR?=
 =?utf-8?B?aXNLT0V6Qk1YbFRwa0R0SlpTdzh2aGhJc2V0dUlKQkh1N1c3ek9kVHhDdWQy?=
 =?utf-8?B?M0FRb0FFL3B1Ym42cW1MTU9RdG8zUjNaVnMySWw1RFl3cTBTeXU4L0xlVGF1?=
 =?utf-8?B?alpHV3lNQnZLZ3VIWGdJZ1JVTld5S2t0TFREWWpaWFNiQXYrN2dYa1lpaWNz?=
 =?utf-8?B?K2MyYzhNdE1tcWttSnV6eG03ZnM3cUd0dGNNWEt4bS82QWdOSlZIVXBUdHgx?=
 =?utf-8?B?azYxKzRPVUVDdGptSlhDbXExTDMrMGR5Y2pZUWk0RDlzK3F3bDdVd3hrS0lG?=
 =?utf-8?B?SGJRR2pxbDBST0tONlY2MGFrQlVTVEVFbWh5MlAza2c5QzRRck9RRFk2YVdD?=
 =?utf-8?B?dys0ODZ5YlprbDE5UFFmdVp2cmQ0NHlFSXQwK3l3VHpqWDBEdlhnOFRPd1pO?=
 =?utf-8?B?RzdxdmxuYU16VTNjQ0dFdXdDT3hjUWtEYjhxTTg5T0w1TUVBMzdzSThqcjZX?=
 =?utf-8?B?ZDdDTFg5cE5QZFJhaDY2Sm9UNWZyZ1ZBSDIzZnhVSjE3Nm4zZmhGTXB6Ni9S?=
 =?utf-8?B?eFBRdVBERlAyY1R5K3dPcnNXYlpNQ2gvVnVLV2habDN0Ym9abnFjSUM3YUpU?=
 =?utf-8?Q?ZG3LYVXNnIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFSOExyL2JYTXd4RnArZktBckJqSkZZRlVrRmN0QWZFSnpSOW9PTmU2TmU2?=
 =?utf-8?B?THltZVZ0QytDbTVFYmJFakdiR3ZrTWp0bXAxNWw4WVVMWHh4c0kyVzBnSGRM?=
 =?utf-8?B?UDA0eHpWWnVMNDdicjdxSVpHN3J0OU11UVBrTzBrUXExM01rMU1CdVhCYmVu?=
 =?utf-8?B?aDQ0SHlZb2J4enk3OU9xQ29mMWxmNEw2T0g1ZWJUdWR2L05mbVNSWTJSYklh?=
 =?utf-8?B?WmpEaGduck9VSHBrc3BScS9DcDRhd0NuSUNRdWdHN25oZ0Z5VjUwdC95Z0xV?=
 =?utf-8?B?bmZUbXJDays4MXJpTTlhZnVDTzVQMWtlZTd1U1RQcHdvL2xnSjhsdmhHdU5O?=
 =?utf-8?B?Z0kxaXk2ODBSdHY0NWg2UzdyV3dpRFVSZ2RlU2w5bkpMZTd5TU1LK3ozSEx3?=
 =?utf-8?B?MlI2YklZQWFEdnh5ZVhHNTVkRlMrZlVZZzE1R29mWjJXVXNtOXNrY1p4eE1W?=
 =?utf-8?B?NDFqOHJ5cXdSdFJMcWI1VFhqdHpLaW9MT2twT25lTlY1V3FHN1B4ZlBDVjJW?=
 =?utf-8?B?L2NWSUl2Vll6VEg0dVB5SzNlcHhDWUthOUxBSDRxQkg0NVlIV0JCNmZiSnVq?=
 =?utf-8?B?bU1VWDVMblAwd3dBcFU4N21QMnlnU2lvcEVKY0VRMklHenZZaEZHVUxYaG5w?=
 =?utf-8?B?ZGhiWHNNWjJTU2N6dEU2YllBc1N0UUUxdzZicUM2OUNjcDZrNDFpMzE3OVEv?=
 =?utf-8?B?aW83bElGNWpsTTQ2aWtvYkxWdG0wbS9udnBYUHFZZUZua1lJSEU4TGwzemxL?=
 =?utf-8?B?NHM3SENKWE9IYTM1TE1oeXFveFNZaVpHNWY0eTNCdlRuRURIclhaZTkycERW?=
 =?utf-8?B?Zk1VazQremNYVFJQQ2RlZmFyVUl1aktiK1VWNXZhZW5OZy84dmgxT3FNb3Ev?=
 =?utf-8?B?T0lXcG93cjlnUzVnYlc2UlFmNit2VHAvbkF3YjFCK01pSmhsQ2Nvci9hZjEx?=
 =?utf-8?B?Y2FDTlo0OUdaVkRLOTE3eEFNYVlsanFCalFLcms4MDJXdlg4SkgzMVJaOS9E?=
 =?utf-8?B?UTRHUjJtOHMxbi9MakRVTWNRVXRJbW5JY2tiNTh1Z0oweUtuM2pXNlc3OE9D?=
 =?utf-8?B?d2E2ZHY3QWNwYmdIRjRhdW1PQ2lOcHFXRmhyWHROVENsU3JvYUVBZldFaTlN?=
 =?utf-8?B?NjZHRExERmF6SkxjNDdRSTNQVzFPMXVMQUhMdzNHYTBWZURuUHNXU2RCbk03?=
 =?utf-8?B?b0h3bWRtN3JoQlZVL3VQcTR2bHQ5VWNTWm96WS9nbDlDYlFkSU12clYvSmlm?=
 =?utf-8?B?bXEyTFhHTFJyTXBkYUs1b2VyMG5Wdk1Qc3VrUFNRTDROYjJkbm93emJDWjRI?=
 =?utf-8?B?Rll4ZzJuK2IybWpqQjlFNHcwZGlyL0kveTNPdWoyOUFaSjI4RDNDdDlRTXF1?=
 =?utf-8?B?VE41dFV1UFhXN3J4TmJjdFowTEJ3NmRoa0x1dDRrbkFKWmd2T3lkd1dSbmd0?=
 =?utf-8?B?MWhZOGZ5RTA3R0c4dDJrUkM5OURCY1BQalRiN2JPTTdTaEhUYWRjVkJVZE5V?=
 =?utf-8?B?b3FhYThIWkpsVWpSdmN2NUdEcCtSQkVLM0FrMW5nSDNBRktWcDVYWXZCdmd1?=
 =?utf-8?B?MFNsc1JMSmxUWS9YOWkzeVlLNUxhQTYrZzIvcGlka2JybmF3YTlxV1oxNEJZ?=
 =?utf-8?B?aHl6aENlZ2xydG9sYXZpb2phMEQ1TXRzMlJtSDhJYTR2dmI3S1FpTXlXKzlB?=
 =?utf-8?B?TDZYbDRJSTlKd3VHOXZlb2t0eC95TkttMWh0anNTY0pheUM5elVBMGUvOG9Z?=
 =?utf-8?B?MWxPSG9RK2J0MHE1aFFWQ2wzcFVQanNNajBQZTBHWHZQMTJNbW1saldBbTZa?=
 =?utf-8?B?TWc5ZGUzRWxwZ3czcHh6NGRHRXltN2JLOXJnQmt4MDhzUW10bHplOE55TkNs?=
 =?utf-8?B?V0NNcFNIcStXRWczRlJNYmxrbDJpUUdSZlRNSUtjdG9WdG9ndkJUeHJLWkJp?=
 =?utf-8?B?aVR2anJHY0RnV2l0KytqRkg0U09KMWVOSXZpVGdGaCtFdGNZTlpqeDRzcmJO?=
 =?utf-8?B?WGwrTnpiR0w3TEVNMXhha1Jtc2FmKy85QkxVWmdVamU3UmN5d2ZLTElMWXA5?=
 =?utf-8?B?OWxEZFFGemRvYnQ4RGhUTWJVNXM0WlplTks3Q1owVEtQRkdubnhIS3BaYmN1?=
 =?utf-8?Q?Jv1Id1DfDbwIVmYd5fR3G7u28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9c2ee5-da2b-4178-dac1-08dd7906a96a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 14:39:27.9840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO/3z9HNvZ9xoNBBS6E/ioli/bY90ohsGcyGsfPwgAcwNTUIJmeh62DsoXen9boFqyGPk6jnUP+2thaT1d3khA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375
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


On 4/11/2025 7:50 PM, Alex Deucher wrote:
> Not techincally wrong, but I think a semicolon was
> intended here.
>
> Fixes: 6cc6e61788f7 ("drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v3")
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f1b87b177f4e3..c206c3b371ad0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1460,7 +1460,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   	 * the cleaner shader on each submission. The value just need to change
>   	 * for each submission and is otherwise meaningless.
>   	 */
> -	owner = (void *)(unsigned long)atomic_inc_return(&counter),
> +	owner = (void *)(unsigned long)atomic_inc_return(&counter);
>   
>   	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
>   				     64, 0, &job);


Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


