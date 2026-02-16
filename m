Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64752E63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 17:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0577710E09B;
	Mon, 16 Feb 2026 17:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pUJTL2iI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C52510E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 17:49:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0ffXvMJVRw7U2NQU4zyrMMUwBe8RuMQANsbYojn/t6CGJXuCLEozBhnO0zD50sUf786fXHTFgeaeRa1Lm4ecvdiHATSyiEwlro0WtQUOPcKHu39QS1dtNvy+mmBOFGSk0Vcicj7Ca7u8wpDCGJ6gl6UCojJRS3Mbs7Vb1Q0CYXT4bZkp63trwVbROKAMn0exVyNv3p4Lpxwnf5SdMrHyCKt1/LmHpffkNAN7046QQizhAu523euVzWEpOnSWaqUhXOFIB1N0VOiCIRYGHb+AzjLmdPpMLkWnKm31szk293a/2umVuoAr43xpOQVTvPZLY1Sb66bxIEtJ45YdiHSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BFA0KuyJl39b6pYXHB/8DFuk66TiS22iSICZ2SlaNI=;
 b=JEng/hrFlN81p25AWDSVAeH+6Bj4V3awUh855CoDT+qszyO059xvxp2Eu49ey+PaSxEQJl0WtITxpy63eFFaQdsu/dg8BLOcNdC1ekGHthry8rVeZ05O3KDoBEjv/AuMqSFL3GEkYn1wpPYVdw/EeB3DSfczWGfdm9nDmVO90qIny+RnF+f+6YoajZ95emZlY52moOMtyHnwbYY6oLj+VsBubkD/Gq0EbDkPWHY/GQXetcUO6sk/XwDnJOL6rJLgnxa+9oGT+0h/2wBdDW/6FSsGAjLMml9vLHsQ10OG02wmNuo5vfSAwJLyEAcYAAYzEm16f9seLRYrvxbLtsaD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BFA0KuyJl39b6pYXHB/8DFuk66TiS22iSICZ2SlaNI=;
 b=pUJTL2iIduiDWWS3NyjFQowFG330NQzJ7+RGgPt0hR5/Cq1Ubie3ntbKMAs6NhRlm8c2EZB0E0He2SzvlL8OR9E7UIR2zMKXGBcPUrOfJRgxEP/Wt2PEEQwtwHMr6pd5XgHTd9UOnNwWsUF4CV9QMpk9bpiWT9PAEfucmaWIy34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:49:28 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:49:26 +0000
Message-ID: <acb8eb50-d356-449d-9c0d-3b090eadf7ed@amd.com>
Date: Mon, 16 Feb 2026 10:49:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <2869796.vuYhMxLoTh@timur-hyperion>
 <376e868d-8962-416f-bdd9-a1eaf1094cc3@amd.com> <3689606.dWV9SEqChM@timur-max>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <3689606.dWV9SEqChM@timur-max>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f66500-0f04-4708-e546-08de6d83b9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?byszRXVMRlFTOXBhSGdEcStCWDI3V0xJT3Z4d2NiSWh0NjVUOHpVcm42d29n?=
 =?utf-8?B?NlNSQk91YzhGRXJtZ0V3U0NzVHR6dk5XQkJUOEl3bFJsMTNCU1EvRXlEdFhZ?=
 =?utf-8?B?TE45VTNEYm0vNCtKUUxYWi9NRXBJRlR3WFNZK3plbEttSktnNW5CZkp2azY1?=
 =?utf-8?B?dlk2bjR2ZDVONERJWTZSdVJMa1lLZ3RhM2hCdVo3NE9wRlFiU3lTZjYxNWY2?=
 =?utf-8?B?YmtCZW9Pb0N3RXdCL2FqZUV4cCt0MHhWTEFrU2IwODkyZkZ1Vm5PSjdvbk5K?=
 =?utf-8?B?L3MrZSszNWxqak1jZEovL3FhUWhXMlJ2cUJmdUJwR1JiR29CMjJsQ0NYbG0x?=
 =?utf-8?B?cUJsSU9rUXlReFF3YjVPK1ZuZEJNcDlRZ3RtTFh0RjRraXhLeHNzZ0FKbElx?=
 =?utf-8?B?L2g3NUh2bzErRmdZZmFINkVTSGlpNVlhY3FHSzNKZXdtUHVoLzNwbEJ2Z1Zy?=
 =?utf-8?B?cUJLd0F5UFdwQUpLOGp0REZneHdaSkEvaU9ZaHJrUEExV3ppUGVJNktjbU1C?=
 =?utf-8?B?V1E5NmdmdnM5czFhNUlUTEdQaTc2cWNCOHA0b0RhYzFNMlJ1Tm8vMC9tYkQz?=
 =?utf-8?B?VXVGN21VaGxPeW9QWHUzejcyUjFYRm8vWUxUSXZpblVuK25MbHBoaFYvdXIz?=
 =?utf-8?B?OWlGZThCdDdZWGc0WlpDU2lZcG1kVHBIeUZrL01lQnM5YUtaa0VtazkyVVRN?=
 =?utf-8?B?NjM5NVlvT0dSQzczc0llSkRyaHpsOHFzc0d6d1U0VWF5ckV3TTRnWk95NnlP?=
 =?utf-8?B?V04raWx1U2Vsenk5Tm9qUThLUEtFMjhYMlJBTEE2djJmVGo3cC9pYmZ2TFBQ?=
 =?utf-8?B?c1RocVV2QlJ1WWJDWjZ1RmFnU2ZhTy9RRXVTcmgwdHgxT01kYUJ3dVduU0Iw?=
 =?utf-8?B?dHpGVEVoZkM5d0Qyby9EWUxML2VKenEyQWUzQlRReEJ6cjhoa2F6K3lWTFI3?=
 =?utf-8?B?Q3U4VFhjb0REYWJrb25OOEd5cm8vMG1qTUl3TFowZ3pTMngxdm03eTRQQnE2?=
 =?utf-8?B?cWR0cWlBeEdzN1laYndhV2JVbi8zVnpid21pNmg1b3BpL0xLK1NYdG90Z3pK?=
 =?utf-8?B?ai8xUlE0Zll6OXg4N2lhUVdyc1ByejZRTzZFZWgwdGNhWCtKZC9GV2VOWFMx?=
 =?utf-8?B?Yy9jekFFanZjOGFacEtUdGErL3llN0lYZFQrRmdrRVdrZDNCYlBTSEdCWi9Z?=
 =?utf-8?B?aHZOcjJYYk0zTWxUR1VUMjREU3E5S09UK3liZk9JQkFMNEQvRTczRUpxMTRj?=
 =?utf-8?B?UnFnUnVJeGZJdWkwaGVGa2RHSStJNDdqRm8vNERZQnJCY2lhb3Bib0VWVkhh?=
 =?utf-8?B?QnR4ZXJmUXhvUnR2U1dSSEVrYWk3Uk5XUXRGME45YWMyMlBZajJmbVVVaEhN?=
 =?utf-8?B?RXJRN0VmWmFvRlBsNWUwYkl1dmlWRzY3cFJucTMvL1I5OVIzT3dSem1VODNu?=
 =?utf-8?B?TUQvNVV0OWN2dnY1KzBtQkJYbFBlWHRGZUNqc2dkNjdvNzN6OXZmbUtHME1r?=
 =?utf-8?B?S0FiblVkaUNZSVcxbmJvbHlWcVpGMlZ2NW5sUktUaGxqNHBWSXJpVnRwV1pn?=
 =?utf-8?B?b1dyOVRFejhzaXR6YmE1cjMyMVNZTVJnOUFOQ1RjRTMrTnJ6cVdmdGlWRUFq?=
 =?utf-8?B?WXNQQzgxYTRGS0NRTEhCSFZwYndPTmRuSE5mVEUvd1NUb3U3VU9VTnhGdkR5?=
 =?utf-8?B?SkhNTHJzMzJrUHU1Y2NQRDlPdXFiblp5TXBKSXBvZ2tiMGk1R3ZHUngxZ25R?=
 =?utf-8?B?N3BIQm5BVjRRYnZ1b3dWZ29nZERTdTZxZjMzOUdJMG5HRVNtY3VGWVZrclZ5?=
 =?utf-8?B?VXhULzI4S3NjSVJyYnhYbzNGL1Z0cjNtbXV2c1BUUnN4ZXZIeC8vRFJQeEJR?=
 =?utf-8?B?ME9mc3BPdGNGVGd2VGM1UXlnNlpFaEtGT0VFVDg5dXVHUzhUSEc2eHdmYkcx?=
 =?utf-8?B?RmwwMmtVcC9LMnNlYlpyeTB0Zit6S1RnMXBYRHVzVmV5b0ZPREM4VVJsenFN?=
 =?utf-8?B?Qm0zVUhMcFZ5VHN1VllTZDNucEN5TTdZQWRVdUd2ZFZ1TmVwODdZbmRaSmJm?=
 =?utf-8?B?eVZIRm9zZ3RwOXpnVEN4dVJNamlXUDUwRGUyeXEvMi9qY0FqaGFJZVFsRmoy?=
 =?utf-8?Q?S+pY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhBTnNZaGVnYUNKMDcrcHprQ1JvUTJsSXBrOXBqaHpIYklnc0tubXZFN29p?=
 =?utf-8?B?OEFwOXRPMUtTQmJseDloSlJwd1hoRXpVN1MvV0pGeVE4aldaNk96RjZwVFFJ?=
 =?utf-8?B?QXJEME0yN252bkY4TVJZczhoVTJpNVVIcERCcWJMdHY0SUpVVnVlZ3drOUk4?=
 =?utf-8?B?Y0xkY2FxT2FReHdGSWhEdXhsYi9PTFdTb0N4akRvTzlJazJOVGhWSll5TnBo?=
 =?utf-8?B?NDBlR1BXcVMxek5LbXIrMXNIb29CS01yLzBsdlI3RzJHdFFiTEhtcmx5Qnls?=
 =?utf-8?B?eW1PSTJxOS8rWTVaellJR0dFTVBaek1EdnBRNDl1Mzd2UlZTS2R6RDRFblZZ?=
 =?utf-8?B?cGhteEVTUCtIRlU4UkZSbjAzQURocXNsenJGL2o0WDk3KzdnYzBhbFhMUXRH?=
 =?utf-8?B?Y2NURDZ1TzFaRzl5LzAxMC9VcXp2N2ltZ2tsaTVYRndqY2VRSU80QmUyb2x1?=
 =?utf-8?B?cmRTVndRMEFIZEY5ZDFpTjFXamZKU29GOFYxaDJUMkUzRVIzRllHTlFOaWNx?=
 =?utf-8?B?UUNXMGZIbkM4YmhvWWpRNGF5SnJKcGtITDV5MjhSUVowcHo0dnAvZ3F2VFFU?=
 =?utf-8?B?Ymw0QzhsSXRGK0s2VllKM0pIY0VLN21JTW95dFA3Z1RPcnF5b3Y0MlZ1UUgy?=
 =?utf-8?B?ajJNSXdHSTBScjJYWVJLR0JrSlQzbmhCN1ExS2pHY245azR5eC91d2p3RTR0?=
 =?utf-8?B?QzJkdXk2QjYwdWJUZnowbERTSnRZWmh1Y1ZsRW1ERE5IRVJ3Z2FQdkUyKzl3?=
 =?utf-8?B?V1Y0VDZNa1RUMDN6L1Z4UFd0Z2wzam1paUM3RHhiendwUkRoTHE1OUNnZHZn?=
 =?utf-8?B?ZGo5M2NRMmFIY0NYVUc3YUdscWxWU1JvbnR5eVB3aWQzZlNuRlZmM1B2MVNO?=
 =?utf-8?B?T3J4YWF4SXU4TFlWcVpCUHMxRnZmc0Fvb3hqTHIxZWhmS1NWRTd0NzNmUE4x?=
 =?utf-8?B?M0NVQVhOMWpKUW8yMDQ3b2xkY0R5TUtRa3pEZmhJU0FENlA3WnJKejhjZDQv?=
 =?utf-8?B?WEZ2YlRrUm5xdXdld3N2d1pxYjUyOGhtODl2R2tkZlpBOGlkUlAwMHFUSlZ3?=
 =?utf-8?B?ekxxRUhUQVJuWUIyeW5oK2JsQTlvWngvdi9rd1V1Y0ZBTWN4NDMvYnhIYWVC?=
 =?utf-8?B?UkFXcC81akc4QjVOcmljWkJQVWZJVEl6MmtKbHk1KzBiUURKbHNjcGd1Uko0?=
 =?utf-8?B?UldmUSttdXBxSUdUZUowQkdIbDdkczRpV0dkYWIvMVk1dlJqRTFuMituWXEv?=
 =?utf-8?B?YmhWbDkrWW5UQUdGTWJQT0ZWeUZrMnE4QjBZT1lRQnFaRzFjbUhIc3NGeHhj?=
 =?utf-8?B?V05ZR1JoSkFaa3JBbG5wUDNURjdmd2RLcmFYNCtmdFovcEN1SDloQ2tzRURS?=
 =?utf-8?B?Q2xldjdpOG9tdDJoMHd6b1lGazh3T3FINHhtbmdoN1ZwakI4Wk04RXBTdnNT?=
 =?utf-8?B?S3VYTFhucFRPTjkwU3ZEUzNlcnR0TVFxNjNBNWtWWHZPQkwrMDlNZDU2eHF4?=
 =?utf-8?B?UTZSdzNSb2dSckJjbTZMeElwRFZ6bllwRlFWK3VrQjhuNGNIM2xCVXNMWWl3?=
 =?utf-8?B?UEFhaXRic3ZxKzZyenh1Mm52cE1jUjI3WUttV0hmNlBQaFNrcXpCbnl3NFky?=
 =?utf-8?B?SC80K2h6ODRaUXR1RFVDa3B1S1lSWHRHbnZtVmNzRDEzaXFMWU1jUGhqcTll?=
 =?utf-8?B?bm5uTlBTRlRTMFNOOFA5OHMwZG1oTlZycnd4VjdBVGk0aHJQbFMzbUZRMU9H?=
 =?utf-8?B?SVo2WjhyMHNrck9vTnpJTWRUak0ydm5Camdrdk5nV2RuWkRWc1k5Z3NTeE5T?=
 =?utf-8?B?Rk5MMUJjK0Z4SW1TeE81M1FBOWxDNkdwZmJPaEU2OTdIYlZlOVU5T1hwUG1i?=
 =?utf-8?B?RlBocVZRN0szM1J5eE1lZHpvN0NmRjExOHFvYjlHYjJWQWhrTU1tSEVGMGRx?=
 =?utf-8?B?ampMdlRqOHVyV0x4dGFYY0hhVEhZMjc2OWhIK3dIVGNUQnVUSnMvS0xRUUZu?=
 =?utf-8?B?NDVtMG9WcVNBMjNmbWFSKzBSY0EwOElwT2YreWU3dEpnWjdBekRkL3ZxL3Jr?=
 =?utf-8?B?MzNIQ2x5Wk9yeUprTWYyd3c2Q3NRZkxYOU5ybXo1bDJKbU9MZ0xQaUVjVWJJ?=
 =?utf-8?B?UG80SDV2ZWV1ZktRWFg1SHpmMDdXek9yK0lPZUEra2htRTd5b25uQTA0czVV?=
 =?utf-8?B?SVYvRW1lS1RTL095TGoyd0tNbkdNR1V1ODEzcEoyamhjMXViUlFqdHFEQkpX?=
 =?utf-8?B?T0xCMTZyc3UwOE1pR2FHcHdDQXhsSDFhOFlCOWRhek1KUHlocVdaaE9ORU1I?=
 =?utf-8?Q?Vj6Fxgy5OuYFC9ksN2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f66500-0f04-4708-e546-08de6d83b9e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:49:26.1705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF7VEgsNX6guAPYkHSs95SBtBRhEpisaBIiE1WX1oJrAakv0YZfvdyVAsSz0/7vnm5QUc5bpILbrGsrAjl4xpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420
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



On 2/16/26 08:19, Timur Kristóf wrote:
> On 2026. február 15., vasárnap 6:06:33 közép-európai téli idő Alex Hung wrote:
>> On 2/9/26 15:11, Timur Kristóf wrote:
>>> On Monday, February 9, 2026 6:21:38 PM Central European Standard Time Alex
>>>
>>> Hung wrote:
>>>> Hi Timur,
>>>>
>>>> I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI is
>>>> not set, or with the following change to Makefile. Can you check?
>>>
>>> Hi Alex,
>>>
>>> I didn't see any problem when I submitted the patch, but it's possible
>>> that I overlooked something. I will fix it in the second version.
>>>
>>> Thanks,
>>> Timur
>>
>> I can fix them them manually.
>>
>> This series is Reviewed-by: Alex Hung <alex.hung@amd.com>
> 
> Thank you Alex.
> 
> I will send a second version of this series where I fix this and the other
> feedback that I received.

I pushed this series to amd-staging-drm-next and you can send a new series.

> 
> Timur
> 
> 

