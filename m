Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552DEA4FC1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 13:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8B110E2ED;
	Mon, 23 Feb 2026 13:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="msP0yd43";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013070.outbound.protection.outlook.com
 [40.93.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D892710E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 13:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWlkIvSJ9zVR4WUKKx8rDlJrIFfLj9F5fD8x0nOLF0Lt7SFYU2E5UpAlvsioMJcdUFDErAM93HBLRpr7Dpdg42VlZny0qdPslQ6z+FSe9eJQiqbt3jtt7WxPFF9+9RnTuV/4lJ8+UqtiNGoybJvfEtQPnJbUeGumQHkEJHybY+mY4CVTC5OU9pNn1i37cafz14VfWA1z+S/2vXZ3Nfq+XalYNhCaMvf7n5WWjBuRYW7Dkwqa8xhN8D8nOJTrFTocMh1TMS+PiTyB27EcbLyP7IwlTTwgOnuAFh4aowQw4lPNKwRo+T1CWuM5H/qvedDhCoDmZTaO/NrIqOq9cwjsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd2mkvrfov8SjYsaMwiGI/hlg6FimyJua+RNLEkWVGU=;
 b=LhcuXoS8HEsrreYwhS7ZpznpybLVh9TCt0mS3h1FY/MWiPcF9YjffvX4RmoA9F44UXS5nc2+rKLYQOkieIyu1WTAdfsXSbRWWxJ52CL6Ocog1ftT+FHbjUufuVSvI9Q7kUrfszwo6tRUcNMAq962glKZHTxZbydMI6sMAksepaYcMbnHunUhHyW/Gwsls/64RhR253k1R335alH0kSMuw4ljXhY3CunULgvFPSV4yN6yievkq5UFNoYoF8XPmqbAIbaT6acbEJKgFax/jq4RodQP0n9gG/xlmdZ/f/6fetf5AaVTIpmB6z8uwXnpbc6Pu+cW89tgaSx8cpgbcVsJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd2mkvrfov8SjYsaMwiGI/hlg6FimyJua+RNLEkWVGU=;
 b=msP0yd43xX9kVdcIkAivG46Qh3iZw0/iZYS4kkaMOl+U5+RLDX0/t/ucj46uCApb6+lAOzrXtPkXQBjFXFEuMoI1qtodkEbJ6pon7WfnaLM4CwiXGJmNXezudZWPN3njH3/LUm3T6dySBb8ni2AnOJ4audoJQNAo14rDzxvXEqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 13:58:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 13:58:46 +0000
Message-ID: <0047be6b-9fd3-4424-8498-cb7aed30f38b@amd.com>
Date: Mon, 23 Feb 2026 19:28:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_wait_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
 <20260223124141.10641-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260223124141.10641-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::12) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ebdc016-aa66-490f-8e6d-08de72e3a94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTZhL1VZSHJ4MmVjRklRVHVaVWpjOERPbjBEL1oySWN6Wk8ycFV5Z2tjY1Vh?=
 =?utf-8?B?V1VoMUhPbVdGalFaWDJMdnVqdE83bjI4TEFpVFVPV01NV2g1bGtyTk9aODBS?=
 =?utf-8?B?Wkdacm1jYjZ4MWE4YmFVWXlERGhPa0ZuNzJ4bGY0WnlVWWRUMG1vUFBGK09s?=
 =?utf-8?B?U1Y3SkxEVFBIU2ZZVVVybXJJN3FsSzNsNHQ1bUlrNEpIVWFjTEZqS3BKZ2l0?=
 =?utf-8?B?b3JHVWZvWEZabVR6V2RYdXZIRSthVXhPUTRXeUIzQzM4L2xBa1NSTWZCWmF6?=
 =?utf-8?B?REs3RU5KajQ4QitKVGpvMHp0V0J4K3BtYjZUMUF6MHpmOVU3ekkzbTlxV2xu?=
 =?utf-8?B?MXNuZzMvTTMrMFVWRndhSGdRTFF1UWpzckcyaTloZWgyckUvaWIrSVJ2cmhw?=
 =?utf-8?B?aGNWMzBRWS9xd0pBNWZUU2ZPaXZ0NTNHRFZndFRENGY0R0NQQlMrTW9weFlu?=
 =?utf-8?B?a0d1cXJJOHVxcHdNOWpRSmI2T0dDOEw3aVY4S2w4SWlMQW41bXBDc1V6a0dZ?=
 =?utf-8?B?dktobi80SmJFRFdFRTJxUnppUWFhZ3VqMnVWYThUNTJVNXF6UGpNS0J5QVI4?=
 =?utf-8?B?a1M2VTlPVy9NUHBOVXAxMFRoVDQ2akx1b3pqS3R3bzJOdkkwelFmK3hUeS80?=
 =?utf-8?B?eDFpc0xrQk9NbVRmU2VzM3d2bmtSVkNlS0h5Y1NUQjM0S29MZ3JQUisvdlNI?=
 =?utf-8?B?QmpxdWVpb1dSTGoyT3RwZlk1WElmbW40R0hpVFJIYlFUUFpNK0t4bWFZQnVu?=
 =?utf-8?B?bUpBeEdka1ZadVdUYkdlM2ZBTWp5R3hpcmpOeWRoQ29KRFViWmhiN0czRWl2?=
 =?utf-8?B?SDVpSDg1WFFzeW1aYnFyZEc2bGRlaFY0L1hMdFFyaTZGZWFTR2V0dHhqNnBn?=
 =?utf-8?B?V2lqclVyU2s3Q1E5Y0F5QTFkbU9WN2lXbUxpanZqZWcwUzRuamtYYitnRC8x?=
 =?utf-8?B?L1JyL2txZ2cva2xZUWM1Z096N29pZjBqTzIvOFR4aXZ6anJ6aFNISmN6Ykwv?=
 =?utf-8?B?aXVGMGF4VTd6YVlMNmMrSjNodUZjN2ZJc3k0RDQyODJJcUhDRzF4bU1QcTdm?=
 =?utf-8?B?UUJRNjR6R1hLRTM0MGhVc1QxS2ZNNU4wYzA0UXhyUC9abUQ1TFF4OTdObm4z?=
 =?utf-8?B?TXVjWjdzM0c2VmU5RlV5UVR6K2VZOGpFUzVKZHE1c05TUGIyOVJPSXd5U1I3?=
 =?utf-8?B?Z29wejNOWUU0VjBad3hOZFp5Sy9jWDhHMVpmUDJta3BZQmtrVFFGOXMzaVMr?=
 =?utf-8?B?NlRYYktKQzNHK3dDLzRKMGdQRkg5Nm0wbFozcTNjdlo2czNmY20vd3VSZkxy?=
 =?utf-8?B?STFWNm5QaUFZVVVoQUIxWXhGRmQxWXFBTEkybU14K1ByRHlkZWhSME9YdjlK?=
 =?utf-8?B?N2RCMVl3bzZnYVl6Nm9MWkplYnN0NjQvUWF5bmExUXAyUGx1WTJUMzNxU1Br?=
 =?utf-8?B?cndvT0RibjNvVVZuZmR2M1g1V2lNSS93S3NqbmpuTGN0NSs5cGIveFdKNy9U?=
 =?utf-8?B?T2tWQ1BBM1U1QmU5bVRGa2ZtZHUzZmorT3BXVFBIemdUY2pyN2J1YlNhdXVy?=
 =?utf-8?B?TjJaOXNETVdlbm5CTVgydUV2ZjJmSmdsQW1xeFR6Qk1ZK3Q1MVZPUnl5WDNT?=
 =?utf-8?B?TGk5SUtxanRZMWt5VDB0bmh4WTl1UEtnRDdNaGRNaGc4TVV1ZE5paXRpUEh5?=
 =?utf-8?B?K1RYWUkrWFlJOU15TEJHVlg2amI0Um1nd05zR0tnM0lDWmw0bU12NVd4V2Q5?=
 =?utf-8?B?ZFo0ZjFGQzV5cnh1SUpxbk5GSkgxTVBHeWc2eHFTeWY1ano5c2NmK0NPVnZt?=
 =?utf-8?B?Y0Q4OVJDWklRMDRqQnhJamZNWDRpMEJ3TGZiVDhGNjNXcUZnOEhnZVlvMGhx?=
 =?utf-8?B?ZFV5K0lDRXBtNk5CQ1VtU3cxUDdOc0lZZXd3R0htSUZmMlZzQklMUElMeFJB?=
 =?utf-8?B?SGdjbnNTeG9lemEzckkxeERiVzVWaU9vOVBieGhPVkxnY1RFSGJIcFJrUDNa?=
 =?utf-8?B?R3J2RU1zUXhMTE5jV2xLVWhDcURkS29EZjFHcW5nTTNwNmVicUQwa3VSdzlO?=
 =?utf-8?B?WFZURHFUZnZRMngzL3Q1aFQ3c2hqYi9hRnRCSTFLUVlYczFOVElBWmJSaUJS?=
 =?utf-8?Q?FvXI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdCaVd4aCtJVHcrZGdZQVlGMUVxNGNBK2w0bklqVlgxVHdDQjhaS1dUS25O?=
 =?utf-8?B?ZkRwVi9Lc1ZtRG1hUHhGODhwbFN1OVp0VmFhQ2IxWmV1bXYxTng1TTlIS1dF?=
 =?utf-8?B?K2ovLzdGank1Y25wMXdtekx4RzlFNndTRmlQYk1uRkNldElqcmFVYngyK2w5?=
 =?utf-8?B?Nk5CdE45bllpZVQvYzVRc3NGSmc5N2VJQTQ4eTc1REdwN0pmaWhIS2FCMC9m?=
 =?utf-8?B?Q2dTZHFvNkN3RzB2NjloS0RHZTRYSnFEc0pTSHJza2ZOakRGemp5bEJwTHM1?=
 =?utf-8?B?TzIyMHZkNjNHakExSUh5TENYWXlXNU9YY01sOVZZcDZiQmIxTy9iLzErRWFD?=
 =?utf-8?B?T28yMFh2VjN0Qi9DSDREVnV6ZDBpeEZLbE5CWWpiN1ZzTXZQZi9wQzE5ME5q?=
 =?utf-8?B?YW5oYmNsYUEzUXViVVpWcG1TUFFjQXlVRXJISmZDcWRWTWRPellFenhTVGtF?=
 =?utf-8?B?OHUrakpuekQyOUlXRHhtZTN2N1p2L3FvcHFhRUE0cFNVUVc2NlFGLzQvcDB6?=
 =?utf-8?B?R0hwYkNGd1JuZmlpbHNnLzQ3YVlOdVN1UDR3NU84Umc1Tm5PQjlOaG9DTVBV?=
 =?utf-8?B?RWU5ZnAvYWNMYTI5TlBsVFNUSi94MnQ0TGZMUStpWWI4SHFMMDJHMU9JaFhn?=
 =?utf-8?B?ejUxaDRya3NoOUhqZDdpdzJkMWVOaGJTbWROZDhuaGxWdHBYOVRISkVXNElz?=
 =?utf-8?B?bWoraldNeTFRRUtubFR1UXVVMzUyYU51ZmVIZUtyVFBLY1p1N2trbFNLQkhW?=
 =?utf-8?B?QW9JT2FxMmhIdWVVMDQyamRjMXBMTmRFTitsWHhyWGlMRno0Uk5kT0FMNllM?=
 =?utf-8?B?THpDaXhtbWFpYys5SVVQU1drYlJ0WW1uZUt5K241S0dkdkxVZ3pnN0lKM0Nv?=
 =?utf-8?B?dzg5TWRQcnpDQjVhTTVmcmNFRUlJSllqUGxYWE5YUG1yU0FpczM0R0tFRHBh?=
 =?utf-8?B?aHBvK1hIZlcrQ2s3M2kwT3dPSzBtYkJOOFZtYlVWbzF6alJtY01pVDFPbFM3?=
 =?utf-8?B?UDFwZTFiY1lDQWRnVEpUakR3SStlRHc0U3dIaWVjMHJ4VUo0TkUwVXlCaG5X?=
 =?utf-8?B?eWJEWUJqYk9oTXlpQndzL29Zd1UzaThKZWVOQ3UrQ29NVm5FS29uZWtnOGlz?=
 =?utf-8?B?UjFmcGRBMjQxdzdiMTFnSTRLNU5wK015SWo4M3l5UTJPTlZyNnNxS1p5K1NP?=
 =?utf-8?B?ZDFUSTRRZ1hySnV1dm15VUhXWG5ycVg4VnpuRWJaY0VHcVZFODdWSjU0b293?=
 =?utf-8?B?Wm43UEQ1bllkQVlyTG1DeE90RUxJazNGYTljRjhET2hnWmoxVGJ0SEFodW5P?=
 =?utf-8?B?dk0vbXhPeWtMM2FOZ2d2L3VXTUs4Z2p4SHEzQ3hUWGgwRG1vajZxOENyQ2hR?=
 =?utf-8?B?T0JBYlZaQzZwdUx1OG1NWVlDUm03OGtvWUkxVWZ2dldEV2RhL25LWENTd3Q3?=
 =?utf-8?B?b0U2ZDRLQnFSaklpZXJaS29yOUt3Q2hjZElOZVpPMWIvL01kTC9HNnRlSW02?=
 =?utf-8?B?VnZESjlvV2FzcW9zNy9oc0Q0SGNYSEViNnJIMEpLMStKUnJhZnVpR1A4YmF6?=
 =?utf-8?B?dks0VW5qVU8wRGZPbTVvcExXRU9venpuUlVEMmpsdVlQZmZXcGY0aTkvWTlH?=
 =?utf-8?B?V0pGQlgzVCtMc09iSjFIZUlDaktPS3ZFdmRFcDRGMkwzcERDODk0YjBGUXpX?=
 =?utf-8?B?Qno5cTRjck5DcmhDRjB4R2lYS21xaDNIZ3ZRbHV5T01aNjN4ZjdWaUpaWEts?=
 =?utf-8?B?SVNiOTBmbW11VFplMlVHNWgrS2VzeGJvWDRsUnk1bmtGbWltOVVqYWxLWHI3?=
 =?utf-8?B?WFFxbkxiY1dyek4yQnQ1OUhHc0FwaXlGNFo1Tmo5bFhkV3VsUnE3ZnNlOUhG?=
 =?utf-8?B?NEN2Y2ZKUDBlY05ESDhlZmxFdExGV1JaeXdudEE3VEhPSTFZRXBGS2lUbFNO?=
 =?utf-8?B?VnRvMEljS2tmRkV0VHZBTUk1UnZqczUzS2htL3NHV2xFZmtqYVRmWmNkcjdm?=
 =?utf-8?B?VjRyNjlaTlo2T0ZENU1Qb3c3V3dOemZhSmpDb01sVDBmT0lzRSsrL0dBRmtk?=
 =?utf-8?B?QjQxVXhnQWhnZXdWTzNUV1EvVGFoR0w5RFBjem9yanZRNUpTbHFzcnJxQkRw?=
 =?utf-8?B?aFhDcXhpQVcxOVUyQ1pOS2VuVkNDaWVvRVlRbXBFaEI1bjhOS0p1NXM3L0o0?=
 =?utf-8?B?MmxIcnhjQmhyOVFIaHZhT1VLVzZsM2pnV0Mvbm9VSnpINGZPUEkycXRUcHQ5?=
 =?utf-8?B?aFVmcTBYa3djcCtXRlJWaDBpcGl1aEFrV2YyRkRGVGgvc0VyUmNlanFIV1cw?=
 =?utf-8?B?L3RZZWI2WFE0aEtzMzFlR2J4UnJSN1NST2t5QldJRlA3dys4NUFOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebdc016-aa66-490f-8e6d-08de72e3a94a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 13:58:45.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfQyjxoFbQMpy0MjBGEgTvhcd1RSlhE2h+qGmytFwwrK5RNhpvmvWF/w+ZmrdQ5+60JAczdK6jHH4DgqKyWQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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


On 23-02-2026 06:11 pm, Tvrtko Ursulin wrote:
> Use the existing helper instead of open coding it
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 ++++++-------------
>   1 file changed, 23 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index ee6f03f75b41..d779671bd0db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -610,44 +610,29 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			    struct drm_file *filp)
>   {
> -	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
> -	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
> -	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct drm_amdgpu_userq_wait *wait_info = data;
> +	const unsigned int num_write_bo_handles = wait_info->num_bo_write_handles;
> +	const unsigned int num_read_bo_handles = wait_info->num_bo_read_handles;
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> +	struct drm_gem_object **gobj_write, **gobj_read;
> +	u32 *timeline_points, *timeline_handles;
>   	struct amdgpu_usermode_queue *waitq;
> -	struct drm_gem_object **gobj_write;
> -	struct drm_gem_object **gobj_read;
> +	u32 *syncobj_handles, num_syncobj;
>   	struct dma_fence **fences = NULL;
>   	u16 num_points, num_fences = 0;
> -	int r, i, rentry, wentry, cnt;
>   	struct drm_exec exec;
> +	int r, i, cnt;
>   
>   	if (!amdgpu_userq_enabled(dev))
>   		return -ENOTSUPP;
>   
> -	num_read_bo_handles = wait_info->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
> -				      size_mul(sizeof(u32), num_read_bo_handles));
> -	if (IS_ERR(bo_handles_read))
> -		return PTR_ERR(bo_handles_read);
> -
> -	num_write_bo_handles = wait_info->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
> -				       size_mul(sizeof(u32), num_write_bo_handles));
> -	if (IS_ERR(bo_handles_write)) {
> -		r = PTR_ERR(bo_handles_write);
> -		goto free_bo_handles_read;
> -	}
> -
>   	num_syncobj = wait_info->num_syncobj_handles;
>   	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>   				      size_mul(sizeof(u32), num_syncobj));
> -	if (IS_ERR(syncobj_handles)) {
> -		r = PTR_ERR(syncobj_handles);
> -		goto free_bo_handles_write;
> -	}
> +	if (IS_ERR(syncobj_handles))
> +		return PTR_ERR(syncobj_handles);
>   
>   	num_points = wait_info->num_syncobj_timeline_handles;
>   	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> @@ -664,33 +649,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		goto free_timeline_handles;
>   	}
>   
> -	gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
> -	if (!gobj_read) {
> -		r = -ENOMEM;
> +	r = drm_gem_objects_lookup(filp,
> +				   u64_to_user_ptr(wait_info->bo_read_handles),
> +				   num_read_bo_handles,
> +				   &gobj_read);

If i am not wrong even using the helper function will not avoid an OOM 
situation in case num_read_bo_handles is a very big number? This is just 
using the helper to reorganize the code but not having additonal 
checks... and alos valid only on drm gem objects type...

Regards
Sunil Khatri

> +	if (r)
>   		goto free_timeline_points;
> -	}
>   
> -	for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
> -		gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
> -		if (!gobj_read[rentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_read;
> -		}
> -	}
> -
> -	gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
> -	if (!gobj_write) {
> -		r = -ENOMEM;
> +	r = drm_gem_objects_lookup(filp,
> +				   u64_to_user_ptr(wait_info->bo_write_handles),
> +				   num_write_bo_handles,
> +				   &gobj_write);
> +	if (r)
>   		goto put_gobj_read;
> -	}
> -
> -	for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
> -		gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
> -		if (!gobj_write[wentry]) {
> -			r = -ENOENT;
> -			goto put_gobj_write;
> -		}
> -	}
>   
>   	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>   		      (num_read_bo_handles + num_write_bo_handles));
> @@ -947,12 +918,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   exec_fini:
>   	drm_exec_fini(&exec);
>   put_gobj_write:
> -	while (wentry-- > 0)
> -		drm_gem_object_put(gobj_write[wentry]);
> +	for (i = 0; i < num_write_bo_handles; i++)
> +		drm_gem_object_put(gobj_write[i]);
>   	kfree(gobj_write);
>   put_gobj_read:
> -	while (rentry-- > 0)
> -		drm_gem_object_put(gobj_read[rentry]);
> +	for (i = 0; i < num_read_bo_handles; i++)
> +		drm_gem_object_put(gobj_read[i]);;
>   	kfree(gobj_read);
>   free_timeline_points:
>   	kfree(timeline_points);
> @@ -960,10 +931,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   	kfree(timeline_handles);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
> -free_bo_handles_write:
> -	kfree(bo_handles_write);
> -free_bo_handles_read:
> -	kfree(bo_handles_read);
>   
>   	return r;
>   }
