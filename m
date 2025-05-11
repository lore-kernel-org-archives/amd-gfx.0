Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2865FC3ABCB
	for <amd-gfx@archiver.kernel.org>; Sun, 11 May 2025 20:34:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F3410E060;
	Sun, 11 May 2025 20:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y5RdtLu5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C8910E089
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 May 2025 20:33:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JngSHCZb7Td9/NSPQo22A3Pio4f79fMo2JuF6rHbhXCJMD2fdx2+GafO8g4Q8fBNErsqrbMZ3QSoKqiBCnQGap0NBsDuWOW/O6AlpxkiVLBvZKs/xCEyZu9u8yR8MjppD7Ocp1V2RKJlpehYpBkS6jlMLYnxFIqyq9BqIjHvZfwFRabQxo3IqtgaOeU2qnS++3/4FYnLvzs5hPOXdTou2UH7XcYcTgGr3dhMOSw5KXl2CL/QsSaA49+t+1MKc6LKu+Ps1YOwj+UeVu3SiXwGElOtrzTfDw6XZ743h/xstDcNBMOSqLPH3mHNTqEsADx4iwD+46WQxts44BgxtkSziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL1wT5JDwwlNXRdZsIVQ/UspurnycMy7cm1eDjhw8cs=;
 b=Tx5r7L3AFez5MyTi72L82aZ5ARNrfejRGJvwIF2wmg4R7pXpkJK0BfseRySOBXIRh7rKVmONPGL0pq58cs+Sv1KPlLbbknDxIVexJS3jlgm/JoMiT4m9HPdhzrI1ra5tYf4WSI3eMW72qvDS9PHjH9eBIFqIAUWNKL3HtQtrEbY2EEGl0/ABdjoFLaBepEbBFbCWlv7xQz4zp7f1zD0CfUE6BapK7p3QUZPu/t8e2676nWsSXQutkkOnrlYfQlEeLOzPK8PloWeyL9bMQKTiywSA4b482OSrnuAZ7XEBfOYJiLAhRioFEytpQ+pg6NWefk7/q6tQqzV5KZJNrxRG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL1wT5JDwwlNXRdZsIVQ/UspurnycMy7cm1eDjhw8cs=;
 b=Y5RdtLu5IYpBM79wozD9u5jv3k3aEiJqfXHKYWkAY3Ggpqnh7wziDvP+Q1i/Zc/ysF/3fJIU5vw5BHceMDTHeX/sAt43ltx3a8Y3wStN/jTd4s8MnNoj5CIToPh/Q7u4PPq29E86cb0K4I8WUETizJHt6sHeJpRMlmgE09uapMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 11 May
 2025 20:33:35 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%5]) with mapi id 15.20.8722.027; Sun, 11 May 2025
 20:33:35 +0000
Message-ID: <fbf53dc5-01f0-496c-88b0-86eada7c5a91@amd.com>
Date: Mon, 12 May 2025 02:03:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
To: John Olender <john.olender@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
 <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
 <2150d713-d9bf-400e-b51b-aee835431991@amd.com>
 <474bf7c1-f42a-4738-8ce0-24fced3b051c@gmail.com>
 <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
Content-Language: en-US
In-Reply-To: <70f66e11-7baa-4aed-ac88-f823305001e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 554c9222-5616-4747-16a0-08dd90cb19f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXpxODgwVkpHTjc0a1kvQk1ENWp3T3p2dlR5ejlSYzYxait0T2hSeTZmWERm?=
 =?utf-8?B?RTRIZnZKMCtpZzMwd2FiVUsyTmZvUTcyeFFhZkRTaHkrVXNlQWU3SmpzdThr?=
 =?utf-8?B?c0gwclFaTkJOcStOcHdkRG9oYTkvNzFSaUtQenkwa0RTNWlMN2tFTkpza0lS?=
 =?utf-8?B?TlFOcC9UZTZzbVdzc2U1NjB1aU1UOEhLOFRHTjRqQ3U5dUs2TW94SE9scVRy?=
 =?utf-8?B?Vk5rSXp5Ry9walptVVNMWkVZeVdmVnhjM0liWU1SbWE0d0pRbHdBSWFpa2Ns?=
 =?utf-8?B?K0pBWlRGVDUvZ2ZybXZGbEdZSkFucDJ3dndNbFJoa1RiMXB6NEpXTm80TkhG?=
 =?utf-8?B?ZjVXT3cvSnFYajlodlJzNkxEWFhjTWJSaVJEdTB5ZnAxQStHaWMrYUZCODY2?=
 =?utf-8?B?VGJVRU1mdlZLOHpTZERWYXQ3eDdYOUJzVDFGZ0lrRWxnQ2hwSlVOUHZIejFE?=
 =?utf-8?B?VGlWTENDdVE3Y2FjQ2RDS2c3RlgwUDRydjFKL3J1dDhKZEZPbjVNMDBxcW41?=
 =?utf-8?B?V29GNG9UbFNTTVdUWEN2RjZjS3ZUMzU1elZHRmJjYlpCMUEvREcwNmVKMHY1?=
 =?utf-8?B?WGRGdHp6WEFwOXBtemNYMEY5d2hTdHlpZ3pWTGdrS2lIanB4UTdhS2xKZGE1?=
 =?utf-8?B?WVQ4MHRUOTBnR2dxQnJtaG9lb2g5T01ZRG1oRkt2TFA3VWdCaEZJbk9FTlZG?=
 =?utf-8?B?c1ppdjkrcS8zL2FqTlV0Sm1QeUNhTlorNzJhNlhTMlQ2b0sybVl4Q1lFVDlI?=
 =?utf-8?B?MFBQaTR2TjN1dTRIN3RnRTVsaW1WYWRKcTVwM0hUWWtWTnhZYlBzVzNudmRV?=
 =?utf-8?B?SGQwMFhJdEZ1TktKRUc4U096VG1PY3FSUGRpUllOdjJkTU1ZakRQekdlc0Vx?=
 =?utf-8?B?NGFuL3hqVkk5ZE1ZWkR5R0hnaEx3NG5FWkJ3dEw0OVE2clgwdEtSa3JNN3E0?=
 =?utf-8?B?M21VT1RKMGQ1TzdKU0lXbTM1N3RBdlRLWkpPb2VCM3hWNHJWejFzMnZ3V2dw?=
 =?utf-8?B?cmRyU3pkU3J2bXkwV1FDVnBhdlE3bFkwQldCc0tuaXIxODJTMk5Kc2l3amhw?=
 =?utf-8?B?dHZGWFloQ05lWFFQRDVHWndvRmRZdFJCLzBvSWZpRWg5V1dXZmpKV1FzSHQ4?=
 =?utf-8?B?NDlKaGVlbHFtMFplRmd0OGozMnBiL3hhMlhrK2ZrT09YRnM2Vkdzb3hCenN1?=
 =?utf-8?B?eFc2L3plUENtcTNlc2s1cW1SVUt6VzJDbVUyWDZNbnJzMUFUM1kvaXNMZnA4?=
 =?utf-8?B?RDg0NGR0RDdxQnpDMFZjcGVZaDFiZXNCWS9keXVLdklsZlVlMHVuTjAwMHVx?=
 =?utf-8?B?YzA2ck5VQ01Mcms0WVBYcmJUVDhFMkI0LzBYMW9MdU16bzk1NkQ4WVh2ZWdE?=
 =?utf-8?B?dVRya2dmZmVBU3o0Vkk4MzZYTGJrSkl2YmlMQXp3NVJYT3lMSGhBRUFPZ3Uz?=
 =?utf-8?B?WGFVWEV4ai9CdVJlZU53YXk4Y0Q0Qzd4Q1d4R3dYbHNucGRxMlQzbkJacHhv?=
 =?utf-8?B?c0ZRVkFhNFlXSEt0YVZiSVJGWUl3S1U4NlJjYWFJeWNaZ3ZOb2ZodzhIUG9q?=
 =?utf-8?B?cEV0RkcwRFdvOWVsbjM0czJodUdzNkF4b1h1OU5OT3M4L04yclN6UkVVd09o?=
 =?utf-8?B?TTdPRW51ditybVRyQW1GNitFMjVWZ3ZNT0svWFIzb2FJZzEvWEI0RGYzVUtG?=
 =?utf-8?B?MXZJcFdWaTg2YnFoazRZZGEvNDRKQitTQWJLTm5NMlowcUNoVFdKNFptK2RH?=
 =?utf-8?B?bFpiY1dZdnpyTlFSZ1VoTWJjSlFZR0pBbGFxV2w0YVR2RklSL1JEdTdqcHN0?=
 =?utf-8?Q?9WEuO/nAKS4McD+nnyqylvx/DaBLxAV95qrM4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFdWSmRLcHFwbDRhc21Bd1d0TDJkUnBGcEU0bkFHNVRIYXFKL3lUcnh6TTlh?=
 =?utf-8?B?R0VCY243Tmg3QmJ2bkxkYXczNUl6YzVrRklmT1B4Yk5IZ3RyQXZreFBNNkJL?=
 =?utf-8?B?K0kxdXNFdEJRcFVQVUdGZ0NvaXMySHVWS3RWOW1BZ3BiajRvOG5wNUt1M1Zo?=
 =?utf-8?B?K1ovazRZZ3pHekF1akMzeFFaNnpzam5IQnN5dWUwWU5BZmliWVhVZDk2VVFo?=
 =?utf-8?B?UEJzTWxmWFo5VVA3dDRWQVMxaGNRTitXaWZJT2lEQncwazhOTXh2aldndWY1?=
 =?utf-8?B?a3BEVFdzYnZMb0drdmx3S3ZrWUx4MjZWNk4vYTNiY0dGZ0xZTzVDTHc1Qml0?=
 =?utf-8?B?ZUlKR21sZCtOUzRHNlpnOUlxYkFnY25yVWVxQmZjbklRRWduNkdTVUF4Y3VM?=
 =?utf-8?B?SDJGUVlCTjkxL0hTQ1JTZXEzbGgxQ3Vhc0dBNTZjS2pEdlJSVkxyam5rVXhq?=
 =?utf-8?B?QVhPNjViS1krd1dLbFVpakVlRmtaN0svRzR3bGJUeG5UVUlGWWQxSDJoQWU4?=
 =?utf-8?B?MGl0amQ1RWU4RG5yR29YTitLRG5KcjlOZkJJdFU2VDhlQzhiWHdYQlhWdWhC?=
 =?utf-8?B?TDIzT0hRQUs5QWVvTmR6a0RIR3ZzK2VFU21lNWZDTVN2eXBISGg0VTJrLzdh?=
 =?utf-8?B?YmNSczgxeHBlOGxBbThFWWkyeFZlSmpWUFFCSXlEWDFoRlV4c05LTmc4c0JQ?=
 =?utf-8?B?cExEWElnK0I4MDNCQnFROWtmdGxoTUtzSmlnblRtU1h6aUxoYUFSNUV1MjlL?=
 =?utf-8?B?Y3Ntek5qSU14cklVdDZwYmNPU3F2UmN6YkVMM3FJRzFNdUVNb1pORFl0MGJZ?=
 =?utf-8?B?cHgvMzBtbWdwbzl3bjRUdDY0UjlOOGRnaXVLeHQzQ3lZU3dhOFhmZEF5VVYr?=
 =?utf-8?B?TWJVem9DYVNXQ0xzQlhVY0VDU1YrWG4yREpBWEVSQkY0bEc3bEMxYVlXRElp?=
 =?utf-8?B?cjNvQTg3ZnV2d2tEdGtiQjQ2REEraWRIaUtLRS9UcnYxQ1pJZ3Zsb3l3cklZ?=
 =?utf-8?B?ek16KzVCYTB3Z3d0NzBLSjlWdnZyZmVkY2prV2RnSnJhc0FPcjlEb1JkN3FV?=
 =?utf-8?B?TDB3QWl2WU0xRWQydzMrMVhKVkVxT0hyZFBpSjd5YXVYb1YxVkxCT05MWnNr?=
 =?utf-8?B?bjMvdUpIMVNvd2Iwc2ptNWd3VDhnQVU1MkNvUEZwaTB5NHlNaEpuRWtPQm1r?=
 =?utf-8?B?RXgrOWNqemRRNzM0ZUdBN3ArMXhQeWNHNHo2S05wWlJvSVF4SWVwRGgxTGFY?=
 =?utf-8?B?VnI0R3N6L0hxelBDa01uWWtRcmlUZzNqTWFRNGNlOC84TkNjUUZhNDlPakY1?=
 =?utf-8?B?aFJDVWsvRmE5eEJNblZjektzY2FkYm00RGIzOXorNWtWcHhOa0xSeE94RmQ3?=
 =?utf-8?B?MGxycVI1N0pIQ2xrY1EwK3hLY1hzZ1ZNZFppdVpDd0NRZWJ5bDJvT2dGaU5u?=
 =?utf-8?B?dFVKV21qZzUvSmJMVERFVGY4RStVbEs4UDBWVW1GaWZsLzNSNGJTS0l5akQ1?=
 =?utf-8?B?b2JSZnJqZmtHeXQ2K3J4UjdqNk5NaWR3RkpVaW9XOFhDQ1h6MWJ6Q0JwVjM4?=
 =?utf-8?B?M1FhcXpSZ3FOcnNVdC9DTnBhZG4zRGFZWlZYZlBMWjdTWnU3amNEamFsU0tX?=
 =?utf-8?B?WGNaRjM5WlhXVVNQVlBOcXljMnUyRDNVVG5kRlozN2w4bVNKdE1qZ1RxZDA5?=
 =?utf-8?B?WHRlU3ByNjlQTUFhN0hweU8vajNaQmR1QWRXOXQwdDNNKzlGdUUwZjJ0blZ6?=
 =?utf-8?B?aUMxQ0IvMGFLanVLM2hBeDlIcm9MUkxQZ3djdk5USmhscFZ1bWFYaXdXUlNQ?=
 =?utf-8?B?TGlITVNodDVNVVZaNHozck1MY0tRZHFLVjJRZDNMK01OL0JIQ1BzeUZXMHJz?=
 =?utf-8?B?WEpuTW9SWFExMGRBREZUUjlRT3B3NEovZFlqZE1NeXhINWYyQWJjd2NGeGRa?=
 =?utf-8?B?YkZXT3Z6a0ZvUkdyTHdOUU5mN1FhT0Y3czlJWnVoWXprRytKUlVwRmxPV3Bi?=
 =?utf-8?B?TXdXWXkxOUZkd1c0QVZuTllYeGMrTkN2cjRmTzY0ZWN5NnIyWE9uampYc2Iw?=
 =?utf-8?B?YS8zSGJ2N3lIRUpBemtRb3pIQi9TNnQxWEZKWUl3ZGpRdDd1YU1ramJRQXdL?=
 =?utf-8?Q?8y9Bz9TA+++Dhbgg6BV0/ZWL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554c9222-5616-4747-16a0-08dd90cb19f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 20:33:34.9217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ujgS6PbdrbG+1zK/Rc/lj1nvSDTZQxSswHNJ9RxUihXKVW862F5CybmrOB2grPVEPNSoLFz15T+a6bCXfrXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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



On 5/3/2025 5:53 PM, Paneer Selvam, Arunpravin wrote:
>
>
> On 5/2/2025 9:02 PM, John Olender wrote:
>> On 4/30/25 5:44 PM, Paneer Selvam, Arunpravin wrote:
>>>
>>> On 5/1/2025 2:50 AM, Alex Deucher wrote:
>>>> + Christian
>>>>
>>>> On Tue, Apr 29, 2025 at 7:24 AM John Olender <john.olender@gmail.com>
>>>> wrote:
>>>>> The drm_mm allocator tolerated being passed end > mm->size, but the
>>>>> drm_buddy allocator does not.
>>>>>
>>>>> Restore the pre-buddy-allocator behavior of allowing such placements.
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
>>>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>>> This looks correct to me.
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>> I was thinking that we should return an error when lpfn > man->size.
>>>
>>> Regards,
>>> Arun.
>> This patch restores the previous behavior in the spirit of "Do not crash
>> the kernel".  The existing uvd placements are pretty clear in their
>> intent and were accepted until the switch to drm_buddy.  I think it's
>> fair to consider their style as expected.
>>
>> With that in mind, I'm not sure amdgpu_vram_mgr is the place this change
>> really belongs.  That is, I think it's worth asking:
>>
>> 1) Why does drm_mm accept end > mm->size without complaint?
>> 2) Why doesn't drm_buddy do the same?
>
> I remember that during the development of DRM buddy , we had a 
> discussion with Intel folks and decided to
> return an error in DRM buddy when end > mm->size. This was done to 
> ensure that, at the driver level,  lpfn
> has the correct value.
>
> I will modify this at drm_buddy to match with drm_mm and send the patch.
After giving it some thought, I think it is more effective to implement 
this tolerance at the VRAM manager level
and allow the DRM buddy manager to perform a strict validation, as this 
is necessary for other graphics drivers
(e.g., i915).

Regards,
Arun.
>
> Regards,
> Arun.
>>
>> Thanks,
>> John
>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/
>>>>> gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> index 2d7f82e98df9..abdc52b0895a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>> ttm_resource_manager *man,
>>>>>           int r;
>>>>>
>>>>>           lpfn = (u64)place->lpfn << PAGE_SHIFT;
>>>>> -       if (!lpfn)
>>>>> +       if (!lpfn || lpfn > man->size)
>>>>>                   lpfn = man->size;
>>>>>
>>>>>           fpfn = (u64)place->fpfn << PAGE_SHIFT;
>>>>> -- 
>>>>> 2.47.2
>>>>>
>

