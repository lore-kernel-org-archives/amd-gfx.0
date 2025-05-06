Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF31DC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6251B10E1E1;
	Tue,  6 May 2025 08:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qn4pT26E";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF4D610E1E1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX4Dzoih5S4d1MGs+EswOdE8VC71OSpfEnx4V6iCd1yl5z45cYBuyg70pqne3tsKET/Jkik4rmxeVYPXuXS0yVYOtNYEpurwKMGMnrNHpCGf9tvrqFT91KTCrHP/2I/Sotuot+3E1XjAWW5WMQqDmnO/h09xQT09rMVhc0XiH/KOWsn+ADbTwX12Fh2Y2/YrOnlvpqaZVs+EDzVR0B5w11G7puHzcvGkij1lBpqGuZuNhkb6B9k1RCFZQwZUU2ed1sw4lkugVHQsNKintcTDpAY4odXLASk5BFcZFIrCc/Ci3YiJ7abnYb84LHPeSeVkbr1gZb37R8s/9Ms1fPVPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IIDLej4wnkAqmxy86DlEoDIm3TQ2UC6fdwl0MhZ2gU=;
 b=wn83kduyl6mYhMuqdQHFSbphPFHrIp3sDfwxVj09+ey9iAok1ZdS4i2bYJ8aiYl1X0vFqFH7EVXA6/BI4N42rEt4AtklIgFIlLeRFouVL2w4Tf9NEVQrS8DN70YwYasgNF17fTfRjUBYZyl53ZpBNBQz4F1D+A9r0BpNXsCzDdZxOrsJsTMlSBly6vHBNwb+GQdRP7i1Y1hVGxkQQraa3ggJ//zrSpEm7bPhMJXAOBJxIEH486vyw8dNWfbB5Ons4ktZcptWVHpIIjm3N1m4YLSxRUt+x97mjWjmNdhfQCH7rNChyeSMN904bh8rThlfVWXlPsRIvAQBL603kCciOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IIDLej4wnkAqmxy86DlEoDIm3TQ2UC6fdwl0MhZ2gU=;
 b=Qn4pT26E/eO1mKpVOuOI4n7OYPF0LhRnbrYY9tTkDSR+d9o2FoqfN0i5r2fciaAGR085sIQFjzUeDStTJljK60Znh82naHAsmqpt/iYI/DtajpKKaGEnG07+Xk93ZIcHTGg1bi8+QwtOws1sU30TqVU2Kj94VaonD3QCVKIUbFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:38:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 08:38:34 +0000
Message-ID: <3747fa9a-032d-45fd-969f-d4744fa4b466@amd.com>
Date: Tue, 6 May 2025 10:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-4-Prike.Liang@amd.com>
 <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
 <DS7PR12MB6005615C194915A4C862CBF1FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005615C194915A4C862CBF1FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 21870c41-efae-4a57-c556-08dd8c796355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnFGczltZzBYSWdIaVFzcXJsMDNhNXVpeUNIVEFhRm9SQlBZRGIwa3M2U2pl?=
 =?utf-8?B?b3pFM3hmV3VyUDVLSlFxMWlUZVFpWEVYVWo1eFdMcGRYZEZ0VEliR3BPNit3?=
 =?utf-8?B?VmVma3JDZGE1a25lc05CWnQyUmJ2dTJndkx2dlNIYU14VTBncmplRlJsRFJv?=
 =?utf-8?B?QWdoSHpYZzd4K01kcUhuKzZzMVJmOTRqTnFnNkhrR1RtOGhJQThpZUZRdDVr?=
 =?utf-8?B?NGxQeUlxSWhtQk9iaWJhVWVyUmdRM010ZVhYZU9td0VSK016TXgxOE1qRTdM?=
 =?utf-8?B?WkY5aGhIL2FEck5UZWxGRS9OUExZZmU0TGJZRS9FWENDQ0g1UFh0akVjNCtD?=
 =?utf-8?B?d29EZ3JJWlR6eERVenJLUVdOR1hSS3ZTWWpJZVd2TWFod2grMTF4OVpLdU5I?=
 =?utf-8?B?ZVgyc0phRFVSbmFDTkF1NWROeVhVUU92WmptTlNHUytPSHVsbzlINlhCdjBU?=
 =?utf-8?B?VjdZZHpFekh4SjlmSHRNZ2lScmpNOC9DRHJtZVVoOTQ1UnV4UEJWbVlITVJM?=
 =?utf-8?B?K2JPSmNlYm5QR0doS0hjdzJFRjA2Z1NkM2JpK3U3cTRyeU1WaVVaNEVWS2pn?=
 =?utf-8?B?SzJTVm5FZ1BhWWxuTHllbCt4dUZGamd6ZUxlaytSTkZ6Mm5XN3pwQ0ZPRjFa?=
 =?utf-8?B?S0pmRUJPb1dzMzdKMHZUdFRZVVU5a0NUbklBc0lSV2JtWXBRc0hSNDhuNzB1?=
 =?utf-8?B?Y2tOdUZpNExLc0Q5RlRlLzQrbEZ2VFJXRE52cjF0cGtYaHMwL2V3bGdzbUo0?=
 =?utf-8?B?UXlPVVVGMmYyN24xQVFjT0U2YzFFOFp4QUxVMUhXUzBTZWtSLzRNUjE0SGtH?=
 =?utf-8?B?WFlZdnczOGZMdVYrSTE0R0FiRUt1aUVwL0Q1MHMrZzZPMW45azVPL3hiSHlE?=
 =?utf-8?B?bU9PcHFRclhMRm12YVBjUVlvdGpiclFxQmpNdllGalozZFQ0RVFEU2FhT29x?=
 =?utf-8?B?eVpVOVlUbnVpbjRXYXJUcE5yQUcwNkxBb1JSOXJFeXJkcUdyWUJIZXNTaVBq?=
 =?utf-8?B?T2ZoOWJJSE9uTDE2YlBKVUFReXg4cm1RUXhEN3YxQ2FQenVWWEZOa2dNdkpV?=
 =?utf-8?B?cjB0SjhqVitYOWVCTS91TGg3VVE2TlBNeGtWTElKTWtpTWw5RmlpWmJVd244?=
 =?utf-8?B?UjE1d2lzK3YvRXFUZnd4Rm1FUXZURk92dm14YnlRdC8rSmpmQnh0cFB6UHFl?=
 =?utf-8?B?OG92KzkyUG5WNTd0R1p4bFhEUm1FbzI1SFpTSnRmNFptK21RMnV4LzhBNXNQ?=
 =?utf-8?B?eGQrSWFWWm9YRVJyV3E2MDBidklrTUhnbnJyNmEwOUNRUkMyT3owTjU1MUpN?=
 =?utf-8?B?bEE4eVJQYUVMc2d5MXdaMWs0NHI3VkM3L2hPcXA5OXQ1cEcreHNvWTFEVTVr?=
 =?utf-8?B?cDk1NW9ZK041Y2lpUVBTU3hLNW1NZ0NtdzVxbVdOQ0l1RnZodkZoSVNUYzB3?=
 =?utf-8?B?QXd1ZUVJZXZ3NkUvRStRMEpZOU82ZzNZZm9wUS8wcEsyWVlwdWFpbEp5Q2NU?=
 =?utf-8?B?bXFDdmpaNFoxM0kxRHdPU1c4Tmx6b0ZiamgzQ0pEd25vNjhySlVZd2Zoendm?=
 =?utf-8?B?aTVmclROWmtjUXhvSm96YW92ZUxmdThXWktDanFBQnp5Y1JHMmFFWEVyQkMv?=
 =?utf-8?B?amhvbWtxbTFCbmFJUGtsZjVOOVl6ZmtuZlpiYW9xVmg2N0Z4aUZzdGdjWFlF?=
 =?utf-8?B?c1VBaWZKSlR4T292TEZtZHExNkpwRzMzU2psMU9vV0RLeU1sQmRxVkJuTjd1?=
 =?utf-8?B?c3NxZ1B0eFpqNjV4MHJUL0c5eUpYdWVINEViOGJDV1pqM2w2RzZSYktjMFpO?=
 =?utf-8?B?czVKWFhTTERYOUNqdGdvZkNjajVLdkJNRUJBWk8zbW02YzlRY2FscFFmU0hR?=
 =?utf-8?B?Z0hZYktoVEc1S1VXZk85WU55QUYwa0ZjK2dOR1ozcGZZeVRpNEMyU3dsME1v?=
 =?utf-8?Q?1jsFhWqSyBI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFp3cVEzYmVxblduZzd1QysrZ0cxZDYwZGxxN2hhNitISlBxZkNpQWVjY04z?=
 =?utf-8?B?VklidjhtTkRCKzkyYk1QZno0bHVwWTJCZFdNNGQvbnFkUlllYlZOR05KY0Ix?=
 =?utf-8?B?d1VxQmhxS3FyeW16THAvMGdpWXgvUEpmbkE3T09TVjNValNZM1JNYjloRnp5?=
 =?utf-8?B?dWkyWXA1UmxxeFJyYlRqTm5PR3grdUF3T0preHhaZjNtaWg4WCt6Rm1weEFy?=
 =?utf-8?B?cnpzZEFsTTE5ZmFGNFFRcEIxZjdNSHBmekNTVU01a1N3UGk0Tnh2T0NTcnBx?=
 =?utf-8?B?NEFkOSt5VWxUUWdGbTloWmVTWmlIenRxQ2VQS0I3VVBmUTdFTUhTMzRXMmtx?=
 =?utf-8?B?UG9uUXNtV1VrL05kZHhJL2VzTEhyOXI5Tjg3UjN6cjJiRnNkZ2VYUkR5WnB5?=
 =?utf-8?B?eXFDT1hSM0YvZUt0b1FZVU41Q3RwNXhTUFZMaHNzdk4wWEpoUldCVUdjN2NR?=
 =?utf-8?B?SDYybFVWS1pxZkkyYjBNb2orWERxWjNPZVhtTk1RcEd4WUJxQ0k5UWxML0Vn?=
 =?utf-8?B?TVJlcG9mQ1Q2MjB2VFoydDhnRTZnOWFtUkI0YlJ5MmtzeEFEM1RDempZanBT?=
 =?utf-8?B?WEl4ZmIzZ2F5a250UndEZFJRczN1azZ4R1kvRDY2TXdncVlqd2dkRUF4SVZl?=
 =?utf-8?B?blJPTUZJRmM5Q0Nxc2FpeGhGSld2cXVGd1V1c3RzYjJ4bFlXeDBHQTBOMWFQ?=
 =?utf-8?B?Y1RLbHJSaEtPUXUrcFd4MXp6NGVOU3NneGtndk9WVDA5MWVON3BtaDExL21z?=
 =?utf-8?B?L3E2RGtzWDNHR1IwVTNMNnBWSjRGT25xODZvTFZpb3Bhb2lLQnhpZ3ZtU0xz?=
 =?utf-8?B?Q29GYWw3T3k0a2lVdDNxVjRGUE5pL2EvOW5EQklBRkU5TTJHeXdRMStXYnEx?=
 =?utf-8?B?K0MrOHoySVo4QzlLTkxKbVVkZFZaVTBwTTBjbjNGcHJLYUxmMkpQV2g0TXVt?=
 =?utf-8?B?bDd2SzBsdkZsaXhHN1FCZDVMc3paV1ZoenUzQldwS1hXTEZ6TnUwQldKc2Er?=
 =?utf-8?B?cWsrRzVzdmJDZzZTVU9NZnllTmhyKzR6SG4xcGYyVDFlUmZ6Y0gwWld6dkZk?=
 =?utf-8?B?Nm1zWU41Zjc3ZVNHbkhtbHVUMnhGV0JtU1JteWRIYWRCZ21YNkREb2NUWUpX?=
 =?utf-8?B?TzNLWjZLNmlDWlJwZTlXNERLOXFmaWpJaFArSGZremd4M28zOE9NQ1djZE5w?=
 =?utf-8?B?eFZ5UWJsZURmV2FjSVM0Z1FFMjg0ZjdXQjlDdHJrdVBweFFtc3FHREp0UEdI?=
 =?utf-8?B?MWhhNkZLYi9ZbmhPTjI0VmFGb3BNLzBBWXhVL2Q3dWEzemdsU0tTOGpwaVFQ?=
 =?utf-8?B?VDhuQVJCVU5BdGYzRWRnRjJsTlYweUpjdEpabDBGb01xZmtBbDFWMHczSmVH?=
 =?utf-8?B?Nk9oOWVaeS8ycEFnOG5IODN2UlR3T0p0ZHNCdTZhcnpPWEJ0Y2NJaDMxZE5W?=
 =?utf-8?B?TlJ3bUxSM2Y4OWo1Sk5yU2hESjBaNTFwTFVxczVXNUk3T3FHQkZkNG5haFFv?=
 =?utf-8?B?UDVkbFVSa0R2YkY3TDJ6RFQrcDNXNGlRanNmU2VFS1EwM3dhcDl0WTlpQ0xW?=
 =?utf-8?B?TVlqZC92Mit0K0JIaFhubm1PZFF4cTE5ODVzSlAxV1hmM3Z5QmFBVHZ1bHpR?=
 =?utf-8?B?d3hsN1NxMTZBeE5GaW12NDQ1elZ6N0JMalJwZGo0TitHbnRUZFhEekh3c3J3?=
 =?utf-8?B?a2ZEdm55YzlLYWJ4ZzNRUHJPR3oyTUQ4SUY3MDMwYUhKdTlSY3NlTndBZG1B?=
 =?utf-8?B?enduQ3k4SUhFVmo5UXNEb09aNnF2eVBFTUxOWVlwN0ticEJMNGNSWnU4dmx6?=
 =?utf-8?B?Qkp3aHAyMXdiYXhEREpWTkZWWXdXYnB5ZmYvSS9vMmgxZmVyYkJZak13UE9s?=
 =?utf-8?B?bjQ3MVl4RWNrZDgyMEI0cUxObUFicEhCNExrWTZQMEtObTFHQTczSXBhMjFz?=
 =?utf-8?B?cng2LzZSQnFWM0NWdDVBSm56UFBhZjdSRVpLUXZxczRiM1dBWGpWUmRSUDlT?=
 =?utf-8?B?T3dOTmZodm9yalZPTk5FOENpMEJXTTJuaEJ4ZURNMmlyQkJEOEZCMDg0WWdP?=
 =?utf-8?B?YitWRUFpaEJqbGRuQ08xZkpxc055eCtjcWpieVlQcWN1d1g2UEUwNlBvMTQz?=
 =?utf-8?Q?tJVa0dIdr6CrmybONtRIaXXe0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21870c41-efae-4a57-c556-08dd8c796355
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:38:34.3689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiRS74TJS8gOWJJTKhWpP2G5i38vGma7HaWOd05+QqAyMWfh96YDqLnRFNGuX8VK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

On 5/6/25 10:22, Liang, Prike wrote:
>>> -   /* attach gfx eviction fence */
>>> +   /* attach gfx the validated eviction fence */
>>>     r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>>>     if (r) {
>>>             DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
>>> +           amdgpu_bo_unreserve(abo);
>> Adding this here looks like the only valid fix in the patch.
> As the eviction fence will be invalidated until the user queue is created from the user space, here it requires validating the eviction fence before trying to attach and detach it to the reservation.
> I will try to draft a patch for validating the eviction fence at attach/detach separately with this attach error handler change.


No, that is clearly incorrect.

See the eviction fence works like this:

Validating thread
* Create new eviction fence
* Publish eviction fence
* Lock all BOs
* Replace eviction fence

Attaching:
* Lock BO
* Attach current eviction fence
* Unlock BO

Detaching:
* Lock BO
* Unconditionally detach all possible eviction fences, no matter if new or old.
* Unlock BO

This order is necessary or otherwise you break the logic here.

Any additional check will completely mess that up because it makes the operation racy.

Regards,
Christian.

> 
> Thanks,
> Prike
> 
>>
>> Regards,
>> Christian.
>>
>>>             return r;
>>>     }
>>>

