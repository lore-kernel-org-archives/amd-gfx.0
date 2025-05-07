Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CECC3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 11:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0D010E16E;
	Wed,  7 May 2025 11:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QaQITKr";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC2910E16E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 11:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bysMEqdbKRwKzp3K9tQm/VM1AG8URqu0SXUGCZ775wXF3O4s4pi9qR/6nOdghe45pbTiAEO3BrvjXe9luIsNg1vP7KPQhto1T5ZNBxBleZq0gS+ImsWcr6MxZufltxQesygjze+b1YSEqKXGG5rXNKd4DeNsylyyEjpKtcyh+Z6+yWlWP4fdvXZF4q7AA4jcPj8LjKQRGfeQZ+jeZyrR7H1qyx0s1epxxiDscz+hzVx+c7KrZQHr082c4FIg27QLmXGHwesG6WjZ5a3uYVUL46tbYKd4boS4PqpxQU5PsPqPRfF3+GRSKgMo6sXERCBhl0NcOUN75oCFWwmAc0GNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/sZu19/sFOoWkokmhrlsLNhnO+TV/2VNZogRcUHM1o=;
 b=CmA+VRO0O9uAD4MrlJaARp+2pmZv0tCaMM3A4NSPl27/y+MXRxc/4bvLrvkSRQHQdy3Yw6cguXUJFvToPctW8AFU2a2btgE0/anmGlw8W8+Zhvp50ZbdGZ/ut0RhTaurVoQjy4KwLZcfvtP/u9XbK2BgPJNqWLx9m9TJ5zUN/y32gUDNeO6PDCHICPDRIpZyjAATUmFut2hGs1Ie7h70DAc1LvRX1ShlKKaVeuackGCTFNuM+EoZNruu2FS5Qhzvb3tjTpaakykKGvDbyL8JJ5hlbEoPplaCKOohd0yg+rOJ5WQRIok6Han5QdkwOJZc+JqEsOBlhGiMxwaiS0mXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/sZu19/sFOoWkokmhrlsLNhnO+TV/2VNZogRcUHM1o=;
 b=0QaQITKrx25E7gNG/QDirp8lSJQmA0WZcTIlGm7ze1yaTgx0cCrkJS8z6dS5KdYN0q7FyTSM+ObitfUakZwhFAQVhD0kVaPEbTp8L+1OWP+RFI3giZkfsdq54w3U3J4Vbf7s8o1UZXsPAOnXTd5Rze01TAmiqTJLDuArk0gMUk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 11:03:32 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 11:03:32 +0000
Message-ID: <13a13f7a-2a6a-42f8-8a06-ebf892bf06f6@amd.com>
Date: Wed, 7 May 2025 19:03:23 +0800
User-Agent: Mozilla Thunderbird
From: Sam <guoqzhan@amd.com>
Subject: Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id and GMC
 configs on resume
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
References: <20250506093629.249792-1-guoqing.zhang@amd.com>
 <354d063e-ba67-469f-a945-d8c6467f6c11@amd.com>
 <DM4PR12MB59371DC0E9B611C568CE395CE588A@DM4PR12MB5937.namprd12.prod.outlook.com>
 <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
Content-Language: en-US
In-Reply-To: <5a80dd63-3dab-4117-afd1-b25a2a8d1725@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0007.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::17) To DM4PR12MB5937.namprd12.prod.outlook.com
 (2603:10b6:8:68::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5937:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d08738-3cb3-4361-b7ca-08dd8d56ce06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnk4OFAwSTdEZlYrSkdBWk15VSt1c1ozZWpJZ2wyOTl6dFhRTEhaTXNwMW9R?=
 =?utf-8?B?OWptdi9pOTVzNW0xUFppb1JXbGc4cUNwMnIybXVsZHFIQ2RUOExZSGFGL2ZH?=
 =?utf-8?B?U2lzWXZEOWZXQzh0ZjJqQVJDRWVIaTliZzVpL0IwOFdyVmJEUHZhQ0UrNDRP?=
 =?utf-8?B?MER2V24xcm9nR0l4YTRnZGF6bUpncDk4bHU4dXZQS0FodWtSSXVTckUwRTBz?=
 =?utf-8?B?LzBEUG9uQVRPMXBjNGpuWE0vM0dxbDVRS3Noc0lTYTFUVTVnNXFXbE9PdzJi?=
 =?utf-8?B?YzR4QVJQVENqTUtoWHlCbURWQlNlMHQ0ajhuQ24zT0treitITUZjRklBYmRT?=
 =?utf-8?B?UURWUkc5NFE2S1UrQU9CTnVUYWc2L2s3TUZXTDJFOG9GNFBRa3NSMHhkN2pu?=
 =?utf-8?B?WVliM2IrSkExRjVrKzBKTlpEZ3pqWnkra1BIV0FaNXZkelRLSWVMWGxhZ29Y?=
 =?utf-8?B?RXhiUFFteTRJejlZbmhqNDVsd0pJMHppY3I0NTlCblh0U1BDR3kxSFYzTVJn?=
 =?utf-8?B?czZTRFZSVHJpUUJ3dUZ6SUtid3hJSnJONmxnTERPOGk5Y2pwN3FmeDZqb3Fq?=
 =?utf-8?B?K3hLOEtFeW9BcDFXL0x4c2NpRnBIZjRPZXQzWnV2U0ZZMysxeVFQZFgzbnVQ?=
 =?utf-8?B?ZUFHcTUrZDBiTHBYWUN6WVhFY29OcGdLVGVENHJIMmtnMm1Qc01jbzVlVVBQ?=
 =?utf-8?B?MnBSOG4yRmhYRjNiWkw1TklKRGFFVkd6M3g4RlhmS3o1akd5QWxEK3ZYMkUw?=
 =?utf-8?B?VzdodUM1bXVtSHdWY3V4T1cwS2VybU5nK2lGemEvb0ZzMjcyb1VzNHZVUXFa?=
 =?utf-8?B?QmdMRnpXVFhqcHoxeG1yaDlKcEhtU2J6bmhkdUFpNVgydjBLVkNqWGcvdk1R?=
 =?utf-8?B?WFZrQWFQWXNlVjM5N0s5d1NENlo5amtWcC9tYncvcldQRVowM3lxYW9PbEtn?=
 =?utf-8?B?Z1ZRK01JVlJmSDBtTzFxak8vK2I1aUR1Q3c3NitqMDhlT0s5eXpIUVRhNUVx?=
 =?utf-8?B?UGtMek1WTHVqaFUzcXoyc2VVemJIU1NUazlmQmw1L21WYWdoZjRyK293bEVP?=
 =?utf-8?B?Q3BSWjdGTGlaMmJGKzFPU3AyNFhpaEd2N3YyMVRYazAvY3dRL011RlhkUERm?=
 =?utf-8?B?bGlWR2p3RkZ3b0Y4ZjBVZGZ2SkRGMlRnUmNmZGtDUmtndmU0R0p5aS9rTTNx?=
 =?utf-8?B?R1Z0OG84OVlDcW8yK2NIUGgrK3dUdHhVNnlGWDc1cENzSjJ3YzVyZnV1RTJ5?=
 =?utf-8?B?S29HNUFvWVNMblFNR28vajg1Q093NE1UQjhHNzB4akMvd1R5aHpNVm1hOXpX?=
 =?utf-8?B?dWZjOU84SjZRTTY2b1FoWkIwYzY2Yzh3V3ZrcVRpM3VRZ0FNRGlWdlF2elNM?=
 =?utf-8?B?SXFIWWNoWG8xY1FwcU5mcHJVUVduZUc5czVQU1JVMzFiYlJVK2pYdzdyUExH?=
 =?utf-8?B?dEllbVgwOEc1M1ArUGx1SGhFYmowNUxHbXRPQ2tuZk5QOFhyRHprN3plbVBn?=
 =?utf-8?B?dEFYN25RdjQ5Sk1UUHZmSWYzVUw0bHk4QjZXRTcyNUhwZ0hTQzNrUFhPQXhU?=
 =?utf-8?B?NkxQd1BsRXQyRXlMWDR5MFFTV0NwcHM4cUFXWFU3WU5FRzFyZVNBWFRPQUsz?=
 =?utf-8?B?U1JhRU1wY2Q3M1o5K21QL3NFV2plTXF5UFhzTzV1QUNjeHZENDJhMm52blZK?=
 =?utf-8?B?Tm5LWlcxU0x0UXhkcSt4QmxseUtidjZmVEovOXFmQWc4SnBkNXRJRWpnWENG?=
 =?utf-8?B?azZsdTVkdzNGYXVJN3B2bUd3TEFhOFlEQ0NxMWtlckhxZ0NtV2Q0UFVBUERL?=
 =?utf-8?B?TnlVS094cE9Fci9VQlYvb2wvb3hQSDZyY2hJK3AxUVJJd1BISkpHZXNrMEdu?=
 =?utf-8?B?clB5eDA1emI0RUtPMFNlb3E0RlkvNEJSZ3B2NjB6Z2QxRGNybzZ5bXZxQnJ1?=
 =?utf-8?Q?cG0/UzLJw7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU15dHROd3R0bXVvSjV0eVU5d3ZkQ3hFT05lck9GcVA4VTUvcVlKZWxsbXpk?=
 =?utf-8?B?L0pVS1lqODBMUXdVZEFRb0JHTDd3WDVmWDcvczNoTVp6MmUrbndWZlFmMnQ2?=
 =?utf-8?B?Z0gyV2tYUlBSSDlpa3ZUdkVER0JURHV4RVBOQkFsamt0T3h4dkc2WEpveEs4?=
 =?utf-8?B?QUptN3JxbTUvMXNWaGw3ZExXQVhXQVBoM1BnbmJsek12ZXIxZVg4bENUdFpU?=
 =?utf-8?B?Si9GR3BNMTc5RlMvZHFOY3JsMFJFT01id3AxT1FLY01mODJXcW94ek85eDlv?=
 =?utf-8?B?b0Fnb3lQaUx4eHJXNzFYTzN0OTNwRGt6WkwzQU5pWmo1T2VUTFlZc1pGeWcv?=
 =?utf-8?B?VmZEVVlJUjBZMmRQaXJuK1RISW15MDZEZzM0VjF2UXZ4OGwxbS9qVGFWKzZ0?=
 =?utf-8?B?emdwSlJsUUVmWVU0c0hWVkx4d3o5MFlvejR1K1M3T2dCMytUYys5YmhYSlNp?=
 =?utf-8?B?R2ZqS3VQZElkTVNDQXBKQzR2Q1lkaFBDbVFwR09OYzQvREZYcU9pQjJBQWN5?=
 =?utf-8?B?bEZxOEZ2MER2Nzg1ZUcvdTVma0JnZGVWL3RuS1poWFZRSDdBZFByL3dqU25Z?=
 =?utf-8?B?S3cxK2pYZVhhNFdxSEMvKzllK2xPMTR4QmhLVXVGM1ZCUXpOLzRsakdidUlC?=
 =?utf-8?B?UHo3ZnduOHIzdE9JQjMwRVpsank2TmQrNnhGdG1MV3IyT1hxWDhHTE9BL3F6?=
 =?utf-8?B?L0hlblhreldUa29yWUNFMDNKQ21ObnhWTjBhVGxBMElsUW1YSW0rZVo5ZDB5?=
 =?utf-8?B?NUdrc2tvcHN6eUY0MlJyVWZaMEFJMTVCKzJ4N1RuRnBGT1NaaFBYU3pjYUJB?=
 =?utf-8?B?dFhsWWpLL25TUHRUWm14bkNNVmRieVNlTlpJSlViUmxnT0R4VTNsWWlZcnI1?=
 =?utf-8?B?WWJqd1VpeTd5UFBuYy9Ucnh6S0o2ZDYvclJuUUZKaE5veFdUYThWM0YrTGJB?=
 =?utf-8?B?d0oza1g0cFRvRkpOTFdybzdPNnRpeHNLQnRGVzVGbEt5ak1WVkZ0MGtjOWk1?=
 =?utf-8?B?TFJCU0o5QkwxbTlKSjkvSUR4Q2dQT2R6VTY1Nmtjc0k5aStmTWlqN3lqL0JV?=
 =?utf-8?B?RlpWd1RISmRQV0IwZk1FK0ZHa3NIK2tZT0JsWEh3bzhuYXJtblNrVDUyVDBt?=
 =?utf-8?B?aCsxeWxBVnRNRnc4ZTcxYXlKR2k3cjJITTZLQndyRWZLRFk0eS9tN01JMDN5?=
 =?utf-8?B?U3lZT1AzZ1VHQTlkUDJKbjZ2Nzh1UnFnTEQzWU9iUjN3bnFnQlYzc3ZDMlRz?=
 =?utf-8?B?UW1aeGk4Z1IxWTE1TlpvcnlZU2I2VldUblc0cm1iSlM5cmdFNjVYS1ZpRjQv?=
 =?utf-8?B?aEdQMkZxb2R2OENuV1hENzVBRTJUWnBrU252ZzlPV0ZjbTdaWXdEQ3d6eVcx?=
 =?utf-8?B?VTJIQXVaR2lrWkRiaTV0QTZRZmtpTENSdys1TGJrY1NrT2ZRUTJac0lRWE14?=
 =?utf-8?B?ZmxvUjNYZnE1L3Fka3NoM2I2ZW00RGN5TkZJOWU1Q2ZlMlRTTEt1M0cvQy9h?=
 =?utf-8?B?bjBqSm9PTDlFUlNJdnJiUHpxMHRGd28za1hkdkZvVzNWMnFMSmZRWkN5cUY4?=
 =?utf-8?B?dGpsRjdJN1czYU10dmQyRjdLVkZwQmpWSWRIWUFVK0kxNEZ5V0FHUWFIWU81?=
 =?utf-8?B?KzJyM3JKa2ZNMHpxcWtrcHdEK041Mm5CTjVtV1BwUWlKc3RrK3VFcWZsdEFr?=
 =?utf-8?B?UnR4aTVlZWJGMXYzcEE3WE1IVVN4RG5QOXpJVFRVamFqYlR2YmRXSk9aQlVU?=
 =?utf-8?B?bmxwYjBaSDFkeC9QdDZyUHhRdFBkVVJiZHhwcTNBWDdQRlVYZXByQS9GTkVB?=
 =?utf-8?B?T3VDOENwL1hUcm5odENpQVlvUG9UWHd3ZXRzWHc4QUlub3dpNkNncDJUakgv?=
 =?utf-8?B?Z1hmd2ZZUGMwL2NBNDd6ek5KcUJ2UUtIekk1MVlEcXBtZ2w5QklFY3NZWi9D?=
 =?utf-8?B?L0VvVEdXNWJ5MDJkMXU3MTRCK0pPYVlFTnNZaUhudmQ1Wm1vbDVDak5hNDRs?=
 =?utf-8?B?WFpHdk50WXZBTjZkVThNUEkxd01NN0VhNEFUTnM1YzJXRmx5Wi9tci9ac01s?=
 =?utf-8?B?cHBoWGF5VjBNZloyMFB0ZjczaHg5SzRzRmN3M2piRU92VVpnVU84bXRVZnhq?=
 =?utf-8?Q?Q0WFbj9k7+qHGwreDKTLQckp4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d08738-3cb3-4361-b7ca-08dd8d56ce06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:03:32.3707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1zfFOx7xq27uQT8mEmQC+pHvLglGm0rlZIB+exQsej8bgSMNphRehXjN3thcnL62chCOT+v19JY11MCegczgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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


On 2025/5/7 18:03, Lazar, Lijo wrote:
> On 5/7/2025 11:52 AM, Zhang, GuoQing (Sam) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>>   
>>
>>> Please keep in mind that this is not the only scenario addressed by the
>>> driver - for ex: a resume sequence is executed after a device reset.
>>> This patch itself introduces unwanted sequences for other commonly used
>>> usecases. Please rework on the series without breaking existing usecases.
>>> Thanks,
>>> Lijo
>>   
>>
>> Hi @Lazar, Lijo<mailto:Lijo.Lazar@amd.com>, Thank you for the feedback.
>>
>>   
>>
>> I also think the new code should be inside a check so that new code is
>> executed only on resume with different VF and do not break existing
>> usecases. Following is the implementation of this approach I can think of.
>>
>> - introduce new field `prev_physical_node_id ` in `struct amdgpu_xgmi `.
>> update the fields on resume.
>>
>> - put new code inside code block `if (prev_physical_node_id  !=
>> physical_node_id )`
>>
>>
> Can this happen only with XGMI under this condition? Any other method
> possible like preparing a 'unique signature' and matching it to identify
> if it resumed on an identically configured system?

Yes, this hibernate-resume with different VF feature is only for devices 
with XGMI. Detecting XGMI node id change is the only way I can think of 
to identify the case. It's also a very simple way.

@Koenig, Christian <mailto:Christian.Koenig@amd.com> Are you OK with 
this approach, adding a check for the new code sequence?

> Regardless, instead of having a direct check, better to wrap it inside
> something like
> 	if (amdgpu_virt_need_migration()) or something more appropriate.

Yes, I will do that. Thank you!

Regards
Sam

>   
> Thanks,
> Lijo
>
>> Is this approach acceptable? If not, can you suggest a better approach?
>> @Lazar, Lijo<mailto:Lijo.Lazar@amd.com> @Koenig, Christian
>> <mailto:Christian.Koenig@amd.com> Thank you!
>>
>>   
>>
>> Regards
>>
>> Sam
>>
>>   
>>
>> *From: *Lazar, Lijo<Lijo.Lazar@amd.com>
>> *Date: *Tuesday, May 6, 2025 at 19:55
>> *To: *Zhang, GuoQing (Sam)<GuoQing.Zhang@amd.com>, amd-
>> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc: *Zhao, Victor<Victor.Zhao@amd.com>, Chang, HaiJun
>> <HaiJun.Chang@amd.com>, Koenig, Christian<Christian.Koenig@amd.com>,
>> Deucher, Alexander<Alexander.Deucher@amd.com>, Zhang, Owen(SRDC)
>> <Owen.Zhang2@amd.com>, Ma, Qing (Mark)<Qing.Ma@amd.com>, Jiang Liu
>> <gerry@linux.alibaba.com>
>> *Subject: *Re: [PATCH v3 1/7] drm/amdgpu: update XGMI physical node id
>> and GMC configs on resume
>>
>>
>>
>> On 5/6/2025 3:06 PM, Samuel Zhang wrote:
>>> For virtual machine with vGPUs in SRIOV single device mode and XGMI
>>> is enabled, XGMI physical node ids may change when waking up from
>>> hiberation with different vGPU devices. So update XGMI physical node
>>> ids on resume.
>>>
>> Please keep in mind that this is not the only scenario addressed by the
>> driver - for ex: a resume sequence is executed after a device reset.
>> This patch itself introduces unwanted sequences for other commonly used
>> usecases. Please rework on the series without breaking existing usecases.
>>
>> Thanks,
>> Lijo
>>
>>> Update GPU memory controller configuration on resume if XGMI physical
>>> node ids are changed.
>>>
>>> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
>>> Signed-off-by: Samuel Zhang<guoqing.zhang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 +--
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  4 ++++
>>>    3 files changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_device.c
>>> index d477a901af84..e795af5067e5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5040,6 +5040,27 @@ int amdgpu_device_suspend(struct drm_device
>> *dev, bool notify_clients)
>>>          return 0;
>>>    }
>>>   
>>> +static int amdgpu_device_update_xgmi_info(struct amdgpu_device *adev)
>>> +{
>>> +     int r;
>>> +     unsigned int prev_physical_node_id;
>>> +
>>> +     /* Get xgmi info again for sriov to detect device changes */
>>> +     if (amdgpu_sriov_vf(adev) &&
>>> +         !(adev->flags & AMD_IS_APU) &&
>>> +         adev->gmc.xgmi.supported &&
>>> +         !adev->gmc.xgmi.connected_to_cpu) {
>>> +             prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>>> +             r = adev->gfxhub.funcs->get_xgmi_info(adev);
>>> +             if (r)
>>> +                     return r;
>>> +
>>> +             dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>> +                     prev_physical_node_id, adev-
>>> gmc.xgmi.physical_node_id);
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_device_resume - initiate device resume
>>>     *
>>> @@ -5059,6 +5080,9 @@ int amdgpu_device_resume(struct drm_device *dev,
>> bool notify_clients)
>>>                  r = amdgpu_virt_request_full_gpu(adev, true);
>>>                  if (r)
>>>                          return r;
>>> +             r = amdgpu_device_update_xgmi_info(adev);
>>> +             if (r)
>>> +                     return r;
>>>          }
>>>   
>>>          if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/
>> drm/amd/amdgpu/amdgpu_gmc.c
>>> index d1fa5e8e3937..a2abddf3c110 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -1298,8 +1298,7 @@ int amdgpu_gmc_get_nps_memranges(struct
>> amdgpu_device *adev,
>>>          if (!mem_ranges || !exp_ranges)
>>>                  return -EINVAL;
>>>   
>>> -     refresh = (adev->init_lvl->level !=
>> AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>> -               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>>> +     refresh = true;
>>>          ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
>>>                                              &range_cnt, refresh);
>>>   
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
>> amd/amdgpu/gmc_v9_0.c
>>> index 59385da80185..1eb451a3743b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -2533,6 +2533,10 @@ static int gmc_v9_0_resume(struct
>> amdgpu_ip_block *ip_block)
>>>          struct amdgpu_device *adev = ip_block->adev;
>>>          int r;
>>>   
>>> +     r = gmc_v9_0_mc_init(adev);
>>> +     if (r)
>>> +             return r;
>>> +
>>>          /* If a reset is done for NPS mode switch, read the memory range
>>>           * information again.
>>>           */
