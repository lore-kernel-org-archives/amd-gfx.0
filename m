Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3203C1B0FF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984CD10EB1E;
	Thu, 27 Feb 2025 15:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IRSk3QHK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432EE10EB1E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMAbC/NZLD8zbX5xQnEQ61I54f97FFtwpIJzht5KgGMvjQPdm2iT2THorHfUORIaUe+Mn825KbB15Wz41HX+ChvAW40/oVJ0erTJO1VbLDvnDBkcV/z8CjECS8ah4Ya+dYxQVi/jHp1OxjbmkbvJfbt/g+NTJO6VWsS2HXVqVLBLoDlipZdYUGQ9tvdBy3/pSjaHqxcBkpEb5Hu/X+FJQ6O/kJ0JBZcxCReNRus+l1qXvGBhfgHg+LUpBsU2MhrKUzL9XOfmiqNZgOVXgB6Mpn7oIhs4vVIzDt8Wz0ePr+xgECpJgHFCgOg3g3vP61SbOnixxVNqJYez/koof0pr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BCNsYOE3ULKGKIQpZAt9hhQfCZhWHavP69XSwMHhyg=;
 b=yJ4U0trIm0+okuEPIDZtxX63+KXeERUgEjrqBwT2UhVOu/sgP0IYyLrlUhzvnVaMdjqzLl0S0kuD/T8kxG4dQMQK9jixIiMB7Fnqi2o0BwXpJ9XOXsxPuqzQXk9naSPw22UpVRpKT31N1Dlvc3+qeQ+0O0YzHg5xa3JGLBhpeX0SrXxb2isQNAM0gUnfIjPOCWGgNrUzwBzPZWeP2FM33fIqvUdjZgY7koHEJTrN8a8mLcjqYf8f2hmj5lfwSfeoaBGx+QpE1fwOkqll1fXfIit4BRXraqCoIpzJJfE0hp42cBX5oOSJ+yEbjdHddmtrKAClZl0j7l/9i1q0e4Bokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BCNsYOE3ULKGKIQpZAt9hhQfCZhWHavP69XSwMHhyg=;
 b=IRSk3QHKGwbo7FctzuzjoE0yazLlbz+TGKNrXCpx0OEnKZ88zYluR1pEQwsSEMkJ2i0WT9aY1eKUJggqM/10SVGQMvYjNbcco4mkiEN6nB6vmYLW6exqVROHUm1QrJSPYU4JnlHKOC/Ca/uAtv6h2lwTYVvaNcSFSQ4YvhvKviA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 15:46:10 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:46:10 +0000
Subject: Re: [PATCH v3] drm/amdgpu: fix the memleak caused by fence not
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 sunil.khatri@amd.com, Le Ma <le.ma@amd.com>
References: <20250218145322.1500-1-Arvind.Yadav@amd.com>
 <b453f96c-ec53-48cc-9179-7dd70012c561@amd.com>
 <def5c837-f2bc-3667-fa18-b755c1392d35@amd.com>
 <b3e0a1ad-eca8-4d3f-bd0f-2a505758627e@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <dc4245f7-5ee8-7567-c56e-0066d62e8473@amd.com>
Date: Thu, 27 Feb 2025 21:16:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <b3e0a1ad-eca8-4d3f-bd0f-2a505758627e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: f36c7c51-6517-4e26-898a-08dd5745db38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2VITUtkMXVLZDZseHY2Zm5oTTV3R1k2bXozbzVyTXAwWitjMmg5aVJkM1RI?=
 =?utf-8?B?aUxIZXJxeVU5RkxxVnh0UGIySE1LMUZUVlVqOTNHelpWTEpienROeHlNbTRs?=
 =?utf-8?B?b3NGNWY0TnI2Q3BsQlJ0cFdGdnA5VWFoN1RnTDYvanlTSUkwV3dBWWhDampZ?=
 =?utf-8?B?b3RBUHpyRlZaRG94RU9DZ250cUxsdVhDV1F4YWxwa01yODFIVG1FYzJHRzIr?=
 =?utf-8?B?TXJ0MUYvdVlmanJlOVJPTTFic05zV1ZQSk9raHJjaUdUODBHSHFEMm5CdVll?=
 =?utf-8?B?SmRDQXQ2c0hiL3lvSER0Tzc3ZGU1cWZSUnpSdVZuMi8vUjBsSFFrb0FqalJ1?=
 =?utf-8?B?SVlzYmsyS1RNVlVzUmtqSzExS01VblZrMkZUdXBjLzhDWVZ4dnZZOXdJZENv?=
 =?utf-8?B?bXRrZnEyTGJPREF1Wis1Q0ltRlR1dEVkVXRzNDViTDl0Zmo0TDNlSTBMOVZo?=
 =?utf-8?B?Z2xSdjZMZTdGQXY2cklPSWY3Qm5tdlY5c01BbnU3VlhpVmJQVEhvak9WVFlp?=
 =?utf-8?B?VXo4VzVaWWhYMUdIZXJHbHVIemNaSGhyODFOTTVDaXlnQUhIZzhyOVkwZnJl?=
 =?utf-8?B?bHJLWDJlR1lSQ3hJUGRkK05reTRwRzJ0SWlmZXZ3aWV2ZW4yaVZZZ08vWTQv?=
 =?utf-8?B?ZUE0ZUZ3MXQ0d3lOemliYkl5OVhsS1AwS3JwRXdsa1I5dzZEcldGbVhYemlp?=
 =?utf-8?B?OXoydVp2L2VRd1hBQnN2a21iK0hNdDJWbGt5WVpwdHcyWUlyME1RbGs3QlVD?=
 =?utf-8?B?QjR2UzBGZC9lRFNJUFp2YjhpaFJlR1daMVlMOWJMTjd5ZzRIMXRyUEd2WFZk?=
 =?utf-8?B?bG1CSUVBemUwRjRPVnV4Uk03TU8vRUt1SXhjeVBDdTU2bkxwMkxXS3hHaWt0?=
 =?utf-8?B?TDJhMEFhM09GSVFBRm1aZWJPMXgydHlHUWw2M0FjZS9uUng3K0lwbEljKzhJ?=
 =?utf-8?B?NDBNbmw5ZVk5NlljbFpWMEVYbTVxMHh5cDVGUkk0VFpQc2wvakYxVS9qMTFZ?=
 =?utf-8?B?VnRQaVJIbEN1dUFyRkhFa3g4TWtZa093TXRpYlhSU2xSWXdVanVNVytBanRk?=
 =?utf-8?B?anZibEpqTyt1U2ZoVUd3QjFEUWp1dUxDOHB5b0VoL1UwUWNKM0hIQ2lsRjhZ?=
 =?utf-8?B?UVQxQVN6Nk1mckd4OUp0QisyeUt0WHJaNzFnbGtMcG5RYmRVQ3MrMTY0RmNI?=
 =?utf-8?B?SGd6QnM1d1hwbWQ5RHBiYm5WV3ZoVS9SRzNSZ1lRb0YrZEpGMk9CMkx4Q2NN?=
 =?utf-8?B?K1dLWlBYMEhuUDF0YW1KN283aEVYMitLcGZyNWl1NUhFeWI0YUxsZ1F3N1dO?=
 =?utf-8?B?MTJneWdQWkUyK2ZGTzZiZk95b01xdW1OaTBUZFdBUC9xQzhWMUZvZzcxcFlD?=
 =?utf-8?B?U05QY29IcFpPcWZlcTU1V3dtVy9CRXNmYlRGVVQ0Wk5RcUlMTUxPWHdkdnNP?=
 =?utf-8?B?Y284dUlhOGxxY2lHZENmYUQ1bGxqMklXamF2VldVbCtweFVtL0ZUeFhDSXVv?=
 =?utf-8?B?WjAyWFlMVUdZanVUMjhFK3BTWmcxMGVCV1Q1MG9ZaXB5WEpsbUFoSFEwYTBv?=
 =?utf-8?B?Z3ltR2VPblNPUkdFTXgwaWVIbGZsWGR6ZlNTQUZpd044VWZyZ091TDNPSTZ0?=
 =?utf-8?B?UjM4aWIzVjFkbkRmbEkxOW0vUjd3c3RrNFJMbGNjdmpxYjAxYVVkOTBHZ0Vq?=
 =?utf-8?B?M2hXbDVnbnI0Y1FuclVuT2JvT29PU1NWc0ZKZWxLbVYxaWJ6cFNWTVViUXRx?=
 =?utf-8?B?Z1diNllWTEhRWHYyV3RaaDRGTlVGMSt4NFBJdDhNNWZRdU4yeEhnUUxLVUY4?=
 =?utf-8?B?clloN05UWU9mVVpaT1E4NCtyYXRKYnVabnB5TkZBWVJ6RSs5RFplZVh3bThC?=
 =?utf-8?Q?pp343cC79MfjV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRHWVVsMys1WHJQaGo2ck1lTVlxVFVaSUdXdFlxb0VqWmVWQVYrYmdHcUtS?=
 =?utf-8?B?UVN0dEtjMTFJZU1CTjJZZDBpNm81bk1uUmtyQWVRbnlKTXhZZlBzSUN6NWdv?=
 =?utf-8?B?TVdtRXJaK2N3dXFqOCsrNXVjdFVDWDJFSXVuNzhpaHRNbDJMc2htVm5UODBx?=
 =?utf-8?B?WmFXLy80TkcvQ0puODVjbUQreGt0aitFOURXSnlsUWFFbklMT0NIZ0FCVWow?=
 =?utf-8?B?c3BtK2llamt6NUVZMzRzN3p0dHpUbFJyMVQyejBoVkw1NzhKNDRMdFR2enpu?=
 =?utf-8?B?NnUrQW03Q2VVaGZHNXFORkllZ0Zzbml2U0twcUhMU2NIN3d0RjNTYVBtV1FQ?=
 =?utf-8?B?WVM4OW4yRVZFZ0Fna1dsNXVERTczZFZheWR2eVFsR1p4TEhvR3VMWUpGNE5F?=
 =?utf-8?B?aE9kaGZIYnRCR0ZzbjdMY2lCalRENnlrNmtwZjBDb0wxYkl6SVVjckwxTm9C?=
 =?utf-8?B?SUlTcW80enlQdllmaTQxdCtGL0ZFbDgvMGdkUW53STZoaUM4Z0Nkc0kxOENk?=
 =?utf-8?B?TmI3Y1JTYnBBYmNFdExXWitQWFB3VDdRZk5oTGJwSWk3czk4L2hwMnBNVzcx?=
 =?utf-8?B?SHZLb2k1L1BNQVRyY3BuOThQdXNZRjlRcUIyKzJHZTA4S1V5aWQ1ZHJRcEJP?=
 =?utf-8?B?akR6YjBnZWJZK25kQitTZGdPdzFWaGsyYU5qRXQ3NEgvRm1SOW44cTh1RWFP?=
 =?utf-8?B?YlV1aWVjZ2x3NHlobWVBeFFqU25CSkcyYW0wZ091V1JWTnUwV09SZFgzVU0v?=
 =?utf-8?B?SitGQjFYSUpNRWF6ZE1MV3R1KzJPZ3YycktjNjNOSTRNVm5SelN5L1ZBdFkv?=
 =?utf-8?B?aTEwMmJ0UTNEdDU1SnczdkJyUHc5TllYTTBDTWh0QVdqeEJRclFMMEhZZnZH?=
 =?utf-8?B?MUNvcExvd2xwbWtOaHNHNktDclZDK2FmdytvV0pONG9hT0c4SnVHT0Z5VGpX?=
 =?utf-8?B?VTQ4VTFuMnFjcWl6KzNpa3k0MTZRay9vdCtRRDRFTVR1YlA3SDNUSFpIbXpZ?=
 =?utf-8?B?NHZNOWRUNnh4N1oyRVlmUVRHOWdyK3lLNzJ1KzlVTEhnU3dKVUVkSkFKVzM5?=
 =?utf-8?B?bkNEU01iMnR3c1lxMVNTWVJGaVQ0OEdWNjVNMUQyZTd6N29ZcGRVcWVxUTNR?=
 =?utf-8?B?aUtHU0JSd0d6NUxQM2pSeVdwTjhHV0hUQWdoY2loT0ViZXkyVWlxaTA0aXE5?=
 =?utf-8?B?MmtZWVM1SVZ5YUtZNzQ5RnFVTS9xbktiQVpvaWVIUmFDeGVtVjU3Sk8rUXlk?=
 =?utf-8?B?NUFjM210L0VaSTh5Zlh6Q1p0QjFGL2ZUL3V6cEZ4Q0pnbURQT1ZkNHhkSDRQ?=
 =?utf-8?B?VXRZLytWTkRvR3hmN04yMVQvbjNWVEZFQ1RHYmtJMlFsRkxsUFhzOXc3akV0?=
 =?utf-8?B?eGlYTS9aZDYvMnNTMDlmdzlpUldJR3ZrREpqelh5WHZ4NkNpYmdUby9ITmhx?=
 =?utf-8?B?NnJzbFp5dFFuN1JaNEQxVDNEUVNVOHhObzk3N0l0cjQzMndBRTFVaUd3RU9G?=
 =?utf-8?B?Nm9ia0NIdDZqK2xlRCtobnpOcE1McUoyajVrSnpFVW1MMzJuT0lkVDNYK3lS?=
 =?utf-8?B?aHc3NVIrK043N2JCUHVCM3V1SFpFNTdZYWpMOGoyempZZmdIT2JhMUpDalJ6?=
 =?utf-8?B?V004Vy9mb3JEVWdOU0F3OHRQUlJKWlQzbmdTY1Z6Tm9wTzVBMnA2RXBsUVU0?=
 =?utf-8?B?eTF0Uk1vVHl2RXo2bGpabFp0S2Z6d0I1RnJ5QTRNSzh4V0x2UVlPYjF5akZI?=
 =?utf-8?B?aTd2eUVUU0t2V3RGRHZ5bi9qbjl4eGRvYlNzckQ0MU5hWUVzL3p3LzhWQWlX?=
 =?utf-8?B?cHkrUDd2cXZ1UUtxZ3N4VldEMndwcjdCTmRRZDVJZVVzcUlsSVA2U3lyTWtt?=
 =?utf-8?B?ZUlmUnovbjVvRlJlbWtneVpOTitEenptK0l2V2pJbWg0VjBLUTB2OTRvYzhy?=
 =?utf-8?B?dlQwUCtqMXZMRWg0ZXcvN1RPTHcrSk9meWZrUnEyOEhDcVhuRUpqSDlOdmdy?=
 =?utf-8?B?TVpHVkJXRGYvYkFFOUF4ZnVZYm02cURqSlFwT05IaEFWRGZhZ2ptakUxQWdl?=
 =?utf-8?B?SXNvSWpwSUxyd3lpcnRaSHJkdnpLYUJNVzU2TFdveUNhVTMxMHRXRVBRenNH?=
 =?utf-8?Q?o+0T3p/KhCtswFy19X8yecQzs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36c7c51-6517-4e26-898a-08dd5745db38
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:46:09.9842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzjAA5D2iFR+fn41YPRazjI/1PQ3Rzit0O/1jZxSGhD8NxMuU3ExHc7M7bDAxSZbWVreKmEv0DeQ8hMTCA2cxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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


On 2/27/2025 9:12 PM, Christian König wrote:
> No, no that's wrong.
>
> That timeline_syncobj is NULL is not an error. In other words when args->vm_timeline_syncobj_out == 0 then amdgpu_gem_update_timeline_node() should just set timeline_syncobj=NULL and return 0.
>
> The error happens only if either args->vm_timeline_syncobj_out has a handler we can't find or if we fail to allocate memory for the timeline_chain.
>
> In this case the return value should be EINVAl or ENOMEM and then we absolutely should abort the operation.
Noted.
Thank you,
Arvind
