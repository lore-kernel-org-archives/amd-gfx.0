Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DFAE63F2A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 04:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B8C010E11E;
	Mon, 16 Feb 2026 04:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCDCZ0l3";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1F610E11E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 04:33:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMzisQGN47ugDO+PYn4Pi6J6TCsjvyqysOKC+JHPhmTTYtZgvQItp6FLEZYoVQ6Tr8vkqRRCRarh7oYkpNoZIIEmK+HRbQOoH4WBEf1744C3U8t/oTiJ+P/8K/fpoYFkK7BDEMbo52ZzA7RDQZuQNy19UNQ8EUzMKDruZG03qso2HxMUCFEKLbtHjeeCDPjwoMLdYFRxymwv4Ow4Fq1MhxpCybtGOMnTovNSZg+F6nv9c51S7W5q3wswPBZ6NXX/siGzCKDwWQF9xlpQdvceatze0KSCpJSUoyZcWmD3HsPMeakVCPZPQhMU18nUV9mUfJgjvxw47DGJFVoqy5aSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0wfo9eBbVhuvZPejOq1Q5nJs8Wan7CES2uEzQ/gdHA=;
 b=U1AFrpALfWGCI9JTPxu46HLC4MgloIZfBu8A/laiOdLY88kEkrjABRq8d/TmG2qMyBg5AwoCHKHp44d2xc+g/nDX7afb4mO3VFCM4Zi7u/69rTH2zvuf28OL04lspyOWn5PBBhmz+5LS6V4B4mf849OEMNrsc1ou6h/f/jlVj0eVRSmFcahLowrG3ux9+T4PHEM+bIOGB5Q00aiV5/ixRhFEuj+9CEYAEdur9nY7zjmZQKpJdMQIwjGnm/T4h7crJk9mHokSoPgzoLEda7XnF3TTuSLJtuUHkgXM9qJ2IqHNC8gzAOZl4sdCzBGJS8hOket6u82GglOIPiu3nJt7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0wfo9eBbVhuvZPejOq1Q5nJs8Wan7CES2uEzQ/gdHA=;
 b=pCDCZ0l3ZSBhcGLZvmv+G41dhyu8LHIZVGaGDUrNgc2xBOpGAUjdcZiz5salby3mWXfQst2+TmPiNR33ySuWnN4D3uIrw2IucWqQBKfz6o99R+m9LawVCQQqHanedF0oc8OaVJ4GbQFinSqj3HpYLr3mtdEtv0Esdz9iWR3iD30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:33:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 04:33:12 +0000
Message-ID: <61a2dac8-f145-4777-91b1-5f12e0c37ec2@amd.com>
Date: Sun, 15 Feb 2026 21:33:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] drm/amd/display: Add support for external DP bridge
 encoders in DC
From: Alex Hung <alex.hung@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <aYn9dPS0R5lh7hQO@atmagalia> <b98dca3d-15b3-4202-94eb-cd4063ec12a5@amd.com>
 <4945608.vXUDI8C0e8@timur-hyperion>
 <1667a2b2-ee16-495b-b3cd-e1a39b6a33ef@amd.com>
Content-Language: en-US
In-Reply-To: <1667a2b2-ee16-495b-b3cd-e1a39b6a33ef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb72be9-b298-465d-a2e4-08de6d147e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YllCVUNmRWV6cVJNVnhNQnMvZXR6dm1yRGlEZDRhSmNxcDlPb0dNV0VrOTJK?=
 =?utf-8?B?bVlFcnExN2xXOHBzMWZLSCtmK3UzVWg1NFdWVnFRY3kxR3VGRjZHMFRRSXBx?=
 =?utf-8?B?VmtKNVQ5NGdqanQxVTBtZFV1OUwycHZzRkJuSjVSRTFJNEFuVEZjaTVvOWRW?=
 =?utf-8?B?QlRyWmxJSWszUGVGOUxDMnZFVFpqdXYwb3hUOTV4aEFnZ3RCQlByUC9ma0h0?=
 =?utf-8?B?YmU5RXgzcTFMNWNYYmNmcHczZEJoaUhiZDQxakdKSlNGU1BpdDhjMjRIa1hp?=
 =?utf-8?B?dE9LcjJ4c1BUaSt6aFVDVHV6aThjbFZXbFVLdVNrbUJoT2dVY0taZGFjc2xk?=
 =?utf-8?B?WTgxTjRmQUg1eDBCeXZRRjE3L2hrbVZGRHJ3VC9XU2NmVXZKSElBNHJNcjA4?=
 =?utf-8?B?b0ozanQrWnJTV1IrTnFHbDZIMEg3a0tLcGtBQlF0THhRWUpBK050U205RFN5?=
 =?utf-8?B?Y0JYTVJ2Q2Z3YTFkL1JsaC9OalJMaFM1UVNQcDJ1cjR4OTUxSmlhaDhFMjlp?=
 =?utf-8?B?RXJDa3BSTzB3cVE1b2JKdWlxM2dGdXFpU3hEL3ZLK1RJTTJKVGZNTmNkYmR2?=
 =?utf-8?B?MFNyem1ScUJPcGo1VW5YSnY4d2pmZ2VoS0dmQ3FFOUJrMUZhcVNna3NLWjd5?=
 =?utf-8?B?NG0zTFVIV0lCM01ZTk1Yd0xqSnBPZExGMmszeVROcEtKbnVibWtKQnE3Rkx3?=
 =?utf-8?B?dldiM3d3NHFqVEUxaW1kaHVQWkQxQkYvREY2bTUxQXk2azB3SFB4VDQ3Rk0y?=
 =?utf-8?B?dmovN01ta3JOSUtkS3I4RllpUkZ2TU9YZjkyT3hZL1hRTVRSY3ZIMTdzYjVN?=
 =?utf-8?B?QzlvQ3ZxVUIyYXpZVmozUW1yNHZnZUxvdDBibW15blNIa1Y2elprbEp2VCtx?=
 =?utf-8?B?UFJYQ0syUDhUVEVuajJySzFRRUVKODk2ekRJN3h1M0MxTU1LT1gxV3N5T0NJ?=
 =?utf-8?B?RERrWVRKSGg5Rk0yTUFQcDRvODZUZENPU0syQXdJb3VFMHNZK2t6aW9uSVBZ?=
 =?utf-8?B?K2RsQ0FHQ3FqT3VvL1BmR2F0UWJxai8wNmhLMUhKMEVBYmdaY2FNamwrSVVa?=
 =?utf-8?B?Qytrb0xMZjY2M1ZhSVRpNVI4VjFtTXVvY0N0TmxyYnNNSFRGVjJ5TXhpNWRL?=
 =?utf-8?B?VnhKMWVYTlBFcTF2R2lZUU9YRnUxTkZRUVFabFROOHBReUowZVFZcHN0NlUw?=
 =?utf-8?B?bGthMGtkd3FSY1A2Q1Vxeko1THJ4RzJORnNFQ2VaMmp4dlYxcFpEYlNmdS90?=
 =?utf-8?B?cWFhcG8yOHhITms1Smh1K05GcHhuMEcrN2RnTnJnZHN3c0JYYTJ6czEvZkpy?=
 =?utf-8?B?Y0lUYVVrNFJUVlgvOFQwQlBzWXR0V0J1ZkgyZ3ErZ29USjRVYTVMZ2UydjdC?=
 =?utf-8?B?b3JZQzNuZkRaa1o3UTY2YVhud0M5djZHZUF6c093VXlrQURLRFZXQThnZDhO?=
 =?utf-8?B?Q0M2UzZ4YmpKM1FWTWp4Qm9lWTZYaloyMHlxWnRXMGM2VWZDcFp0SUpSMzFq?=
 =?utf-8?B?NDErM2V6SkN0d0R1V3NUUW9Cb050aVNnR0t3UDE1SzZoS1BJWDNocVFBd1k0?=
 =?utf-8?B?SXcyRDBnYWJ6QXI0UUlVRUVoOE9kR1lZcUVXQ0d1YUh1Szk1THo3Z0N4UEM2?=
 =?utf-8?B?dE0wWWQrc2VWQTI4Yjg5VWZVNHVRb0s5dFgvOFRtV01rUWtYbXY1c1BORVdv?=
 =?utf-8?B?b2pJVHdSbnRjMjRyK2kxYnlkTjFSTGp1cmdHV0Mvc2pLZzF6V0Jyamp3UDN1?=
 =?utf-8?B?TlFIUFd0YjE2eVlzOWtEdU9yVUU3MUdmM2ZUaEdmYWhiNEpQTnR5RWUzTlJv?=
 =?utf-8?B?NWhsQUZ3OEhGQ25uOWhBYWduRTZlcmZQb2syMDgvQ3RiQTNOS1YyYzh6NkJJ?=
 =?utf-8?B?Rk5OM0VMYTF2WlRWZ2FHQzRsSVEyUFVuMG9jT2w1amFFQUkwQStUK2dsZ2Ru?=
 =?utf-8?B?YmNwSTZIbkdSREhQMFdqUTREaFpKMFE3a09UbFJnZEY2UEEyR2V6SDZhK3gz?=
 =?utf-8?B?WENHRGVyWVFtUERPVmZHNitjNGJScW8rM3VPajRIQ3E3ZWN0RnBYWHFySFEw?=
 =?utf-8?B?SFA0Um9WcVlBNFprekVacmkyTnZkMlkxcmk2clZJSTF6UmRkTmhZT2tST1hR?=
 =?utf-8?Q?DOMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJ0L2xNYk9VVUwya0JQdnpQVHROUkFFalVOZDJsL3ptMVM2Q2tOZ0tSeTFu?=
 =?utf-8?B?ZjRKYWFTOHpQWnhuWG15M0lOUFh1RGdmV3pEYnp2OUEzVXNxbnRqZkJhQXVm?=
 =?utf-8?B?SjdMQVpEanQ3eHFreFpWeDByUkRtQzlWeGlLcEU3dC85RnFyeFR6VEw0NEZz?=
 =?utf-8?B?MUdlN3BONU5mUXNLQ05xL3Z1cDBpM216Sm9ucEZRbFZ1NmlHakxNa1JpS0FZ?=
 =?utf-8?B?MTlYODhRaXNCV2xwMHBSekJZREs5M2tYWmNURDF0MlJDcTVKNXdqQ2ZtdjVh?=
 =?utf-8?B?bTIxcWZUWUdBQWlDbnlqSTROVHhaRXBWUzZMbUM5eDgvbU9nNkxjaGxKa20y?=
 =?utf-8?B?KzVoK3JYNXpmSzdLM1o1S1JhZjdOYm1ZVERiM3NweVcrK2JYWk1QRWs5azRI?=
 =?utf-8?B?WjNSbGIwZWxrZTU5Uk1vcjlJV0l4cCtpeXR2eG1TTHlTRURGT3oxaDJrZ1Vo?=
 =?utf-8?B?dENaSlBobTc1UzNxZ3RFZmR3Z1lOV285SXJYWDc2NHBPcnNwaDdQNnQzSmRD?=
 =?utf-8?B?UGdhclZRUWpNTHp4amgxMjl6RWFVcjZGUHVtRlFpZ1ZpSVFySzExMUZoV0pP?=
 =?utf-8?B?N055bktOUThEKzFab2dOYWJ3T3N5aTRNNnJJRlA4a25EVUZWLzExbUZLK05N?=
 =?utf-8?B?UExKOFFoamU1YXo5T2JCblltdVg3RVdPaTJUQStMU25SZnhZNkx3WVhQdUdm?=
 =?utf-8?B?RHJ2MkpoaWxpcHVIMUg3TkJjT2lIemhwVHdiMUVVM082Wk1ReGw2VGlRbUZ2?=
 =?utf-8?B?bXMvazQ3ai9wdmpDSkhDQmcxZEhCNmsrbzNaTmdPUVRyMWZ4YWZzME5tR24r?=
 =?utf-8?B?Uk5BZ2F3c2hyczRWREw5UStHbHlQQ1IyMkVaU0d4bXk2VGNYa3dTckVLUTlP?=
 =?utf-8?B?WWZnVlZLTlIvTVg1SG1BQzgxblRWWktKdE94WGpObjEzeUJOSmRnU0ZmdUZy?=
 =?utf-8?B?VVI2VUxxa0oxWkRndW5EdjdWdUgvd3FEUzIwTkJkNUlXNE45THVROXAzN2Jn?=
 =?utf-8?B?TUxkdGxOSVZXRTl5dWNvcU83SWFXTjJiM09yb3haZi9qZVhZNmZXUDJuSjdZ?=
 =?utf-8?B?NWlUZE10ZXlVT2tES2g0ejJhajVncTNWODlzRmI0TFJQTVpXWU10Tnh4b1FG?=
 =?utf-8?B?VXdEMDlxRHMrTDJ6dEtSYVB2anc4ZFQ0MVRWN3hJYmViempuTnRabXdnSks1?=
 =?utf-8?B?akNNUmFEMjlIYWZWWVNEUmVaUjh5Z3VnUzBEL0RsSGRCc0tkaUo5a1pCVnZ5?=
 =?utf-8?B?T3g2RmpaUGp3ZjEzSTk4RXpBckZCNGVrTXdNLzNzL1NmRGNQWjBjeERTeFpw?=
 =?utf-8?B?VVpxeU9NeGN4ZHAxVFBPVi9XY0lNb3ZOeXFuYnFSN0F2WTNNRUFBTVM4TFBu?=
 =?utf-8?B?UWtlY3FxRHNBWmZBSi9JSWxVcmk0M25EdDZoQUl6ZEJoR2ZGRW1sUmkrRktN?=
 =?utf-8?B?VkFRd3hZaVMwV0ZoU29FTiszZ05LMDZpVEF5dWtuM0p3OTRJbis2VDk1SmpU?=
 =?utf-8?B?cnM4aXJZT2JrV3BVVTVBU1p3MkRscmVnUEhvWCtNMUEyamNoNXpBWmVDajZz?=
 =?utf-8?B?Y3dhRUx3T1A5VmwyMmFyd1VndkpJZlE3QTRqY1FvSTJkNDBHbW1XeVR5bjBu?=
 =?utf-8?B?cTcyV045cDUrbVhzR2lLYm5tVWh1eTM2Um9tNmJoaWwzWFVyRXdyYWdHTllW?=
 =?utf-8?B?NzV0eVdLOEpDdHMvaGtJMzlGcURvYzFGNzJCNmJ5d0Q4azQ3M1hVZEhhMk9X?=
 =?utf-8?B?UEQ2dmtOb3lwOGtRS28xWkFMOUlFN2dSMnhVWnZwWlc2ZUo5b21YWE40RWRF?=
 =?utf-8?B?R01FNVAxYVpyYzd3TStxNXNQR2xUUEhZN254R1ZWbDVGK1BjV0JFWG9vUXQ3?=
 =?utf-8?B?K1VSSENZamI3K0NRMXlrb2xXYzFhV2QwTjkyaHNraXV2WERxdE5OL251RFYv?=
 =?utf-8?B?SU1ISnNNVjdYc3J5clJQNnlyRlpsUkE4VFhob25ScDg1Q2dXblJSRFhGNzN5?=
 =?utf-8?B?RHFWWEYwVlptczVWTHZPdlJvcUJ2TGRscjJaZTJiTkZkVUVuRUoxN1BBdnJL?=
 =?utf-8?B?UmUxUUxrUlhSaUNmKzdKa1RialdTOFFZeGlvWUNPQTZuYkplSjlNa0NRYWlx?=
 =?utf-8?B?TVZ3TUdYV0N5Z0ZwbFlHQTVsT3VuYWZCcXUwWW8zb2sxWHlTejduYjh4NG1m?=
 =?utf-8?B?K0JjdkY3bUFMK2xTREVyektIQXpmbngrcmR2MS85dVlnbXRkblBlNnhpdUlT?=
 =?utf-8?B?MEROZm9EK2VobHc3V3VDZnpCVEhVQUE2S1JJdzc3Wm9wcVRST1dlNkg2TXNP?=
 =?utf-8?Q?D92aWCRpQqwLbv1/4C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb72be9-b298-465d-a2e4-08de6d147e7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:33:12.5495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 706o8zpIkx9/JBhjGQSxtb064c2iLIqh0i6YLBbWFJx4Qq6At+Sct4kD2Ptj6wfwNqk2IiVVp1gM8aIYgz0hbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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



On 2/9/26 16:14, Alex Hung wrote:
> 
> 
> On 2/9/26 15:10, Timur Kristóf wrote:
>> On Monday, February 9, 2026 7:12:23 PM Central European Standard Time 
>> Alex
>> Hung wrote:
>>> On 2/9/26 08:35, Rodrigo Siqueira wrote:
>>>>
>>>> Hi Alex, Dan, Tom,
>>>>
>>>> This series is the last to enable amdgpu as the default for all GFX7
>>>> GPUs. In this sense, could you include this series in the weekly
>>>> promotion to check whether everything looks ok from a feature
>>>> perspective?
>>>
>>> This series was included in promotion test in previous week and no
>>> issues were found. However, it breaks CI tests and we will figure out
>>> what the causes are.
>>>
>>
>> Hi,
>>
>> Can you say which tests are broken, and on which GPUs?
>> And which patch of the series is responsible?
> 
> Some internal diag tests failed so we will into them ourselves. I don't 
> know which patches are the cause and I will provide updates later.

They are from changes of function definitions where the tools use. We 
should be able to change them accordingly.

This series is Reviewed-by: Alex Hung <alex.hung@amd.com>

> 
>>
>> Thanks,
>> Timur
>>
>>
>>
>>
>>
> 

