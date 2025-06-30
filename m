Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A373C8302D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 09:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC7310E0C5;
	Mon, 30 Jun 2025 09:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jPKs5T7x";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A56E10E0C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 09:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPjd25X5bJaanBtVbolk929RPPJBuwu4m7GBNLMJQyr5LwPqHOYQnjRKUKLguKuRkF3zj84dYKP3mkxAF7da2KwGOMPejnx+9CrL4lzgOm7nZU2CMhUQJC6rFyDBgMgRbbf3V5FdQLzAlg6ZB+mSo44lmbp+JOWetlMeadnujBzaMu8g6Mv6z2gIQo9L6QYXnYsu0lRihp1AgiuFBmlCSCuaKKOJFMv2thYrhynRLo7/aic37R3K00ZoXsSSDN2lwcufYGfwft71pWkpXj9maG1I699F0ndveAvafgrsLnysf8N2IE+6+Z7VfbgI6uvs8Jh4gLc9YJilSeByIld1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzMjLyOB0yXQpLsm/PkiU55vZquGn7YpgdozNgwrWm8=;
 b=lTL3QO2NB9p1UvasWQskvBz21dlluWnYACd+VBR+BexgFm5fC/q3xQzyg4bUcssvtT6zdZM6SeaWkzaJQ7z5cUmrzdG0adx1MXyeCa30d6TrTQHZeyiF/CCG4CdyZbDY7gyzOSEW0LKY3zDyHYIEcNjIzvPL+NduMtixpx9QILbBlUwCdDI6tQBpthOUZisSDBgfwNCLaDBu2h3ux69w6shoHwSoXgpQNHqdB0iH6amRWDcH5ncHozTHXsYP2Bhk6DIPzhX49Lc8hqwHSpsA75CSdJmbmxdEcZhrDO18hu8Y96Y7tFoM+SUzSShcxZRKxW1FhhMzPCFlXDn86wnAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzMjLyOB0yXQpLsm/PkiU55vZquGn7YpgdozNgwrWm8=;
 b=jPKs5T7x0SH16ncJbS888Ut2UwswOgXBP9D3PKtH7v8vsGUB3+KjODHvuQDR4mBlOV6aLp15J80Q7rZSv8DImv18VZQOuqetBsjP6faGDn5OeTU0TYqfNYuZVCX/zVq37lGfP3qSrJPIhW8apVbdrTDEoecajwiSC19Kr4iXzNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Mon, 30 Jun
 2025 09:55:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 09:55:55 +0000
Message-ID: <df24a814-66b4-40c8-a2a2-63c2cf9e2524@amd.com>
Date: Mon, 30 Jun 2025 11:55:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-4-Prike.Liang@amd.com>
 <eeed45e4-3b24-4f53-883a-cffc70914570@amd.com>
 <DS7PR12MB6005BD07952DF27735E0459DFB45A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005BD07952DF27735E0459DFB45A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 068a983d-3769-481f-f820-08ddb7bc4e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHRYT29KQ3BBQy82SHVjM2Nmbks5Y3ladSszNFk0cklkdDA2UG42RHJOUGdy?=
 =?utf-8?B?Smtud01PREQxUUcwQWtOaGI3S2RPM0xyWVJRTlFCVHZvbnBRdDRnclo1MjdU?=
 =?utf-8?B?Smo2RU42UHhnTTM4WGJzUFpoNFArZWpNT1Z3OTZUaFNpLzFJZEpSVmxzV0Jy?=
 =?utf-8?B?WE5FTXN0eWpwNkUwbEN6NU1XOTZkbWhHOC9EL2FJZ1U2eUxiY2JSYzNPTU5o?=
 =?utf-8?B?QStBVm9ubExSN3pEZGVhZmxJRmtDRmdKRXV4Mk1oMm5Tbm1rU3pSalVuckpm?=
 =?utf-8?B?c1hmWU5WeE1YWGxVemxzWE9BbDA2K0F4WDVsWWZWMVFBUTA1aWp1eEgvNjkv?=
 =?utf-8?B?bVJMejZMWTF3QkFReW51TjEvRXFDNmNnWUM2Y2NRTUNaQzdIUnhobllPcUZp?=
 =?utf-8?B?b2FHWUdlakVMVTd2SXFRYnFySlhmVysyMm1EVG5JR2Qxc3g3YlBjODVhSHhP?=
 =?utf-8?B?eC9TNDFoSHF6K2VKSXhYNnJlbnlseXVta3B0eTdhMU1UZmwvNFVIR0l3MTVM?=
 =?utf-8?B?ODZncDlXRm4vSUpQZ00zRGFSV01BY3Y1UUlmUXBhc1dkWFozN1FYR1ExWFpS?=
 =?utf-8?B?V2t4L1ZETkIyUWo4UTJyTzAzNmdUd3pxMldoRDJ3Q0l5bytBNkwzY05RZytk?=
 =?utf-8?B?UnJzRWhZaGxtWWo1c1B6Vk5qaS9tWnBDY2tLMnlwT2dXYmphZllwaWdhdmhh?=
 =?utf-8?B?U0NXKythNVFHZG0rRkd4NXhabFdUY1ExQ3pmR1AycjVSRGZDMVozOFFYTFB5?=
 =?utf-8?B?WUJYS2s3UmJ6L0krbVdLbGZCQmpzbnI4Z3FpeWFuOStaRnFLaURpeHJFcDhL?=
 =?utf-8?B?UGM2QnNUbnZvcitsdkZCM3Z2L1NkOGhscjU0UjdlSlgyY3VOQXdTZSttN3F0?=
 =?utf-8?B?SjI0L1lvSDdPY3RWNUlzY2Y1QlFNNWRDUVkrVnpzdmszVWEyR2pmVUJISHRO?=
 =?utf-8?B?MWJvbC9yOHpMMEpZeHNpeFkzbXNlQlE0TGo4d3NVR3RHVnlNU3FEdXRlYitu?=
 =?utf-8?B?c3BOaDZIWkRKazF3Y2hmSkloWU1ZTEVaY0pYR2xzaUk1Z1R6U0ZnOVk3VVkr?=
 =?utf-8?B?NysybnlkVXZZSG5TcG91bEszSXVpVlZjN0ErTEVqL3gxcVRrc2xabXgyZzgz?=
 =?utf-8?B?K2VKdTQvTVZ0b0htcTBHZnJyK21hci9YVTVkanZvRUZ1M3VVWTBLeFlHYS9F?=
 =?utf-8?B?RzA3dlFBbEYyZVVkTVo3MlRUY0UxeHZPUnZ0a24xaVFodXJJRHJyaklOc1hP?=
 =?utf-8?B?Z1FEQ3lBYlhLUXJvMVJsNWpLTk1sQ1NsaVc3WGlkR3A1bUFVRmZibUFrWUZs?=
 =?utf-8?B?OGdTRThjYTRvWEMwMkhpcDQ2eFdmTGVrMHFNQ3JWU2REb2tRQ2RPdlpKME9w?=
 =?utf-8?B?NnFpdXlJQXpQdCswb0VFYnNyRkRoVkNVa2lTcEtKSFhERWZtdzQrY2M4dTg0?=
 =?utf-8?B?cDh5WWx4NFY4TDFpNHlrTWdScnJiMVhEdnhZdTN5RysyMVhxU0pBY1BxL09u?=
 =?utf-8?B?TkZVRmFPcVp2SHVDWk8yNUpqeEdmYzB4eUNNMEU4aHhrbjBJTmxLeHpSQy95?=
 =?utf-8?B?ZEZubjd2c3UyU1N5cWdMK2R4b0cwc2JUcWxzZy81OC9IRit1ZE1tMWFBTDRW?=
 =?utf-8?B?VGJybHp6Tmo5MGw3ZGZkOEdBZFJ2ZG1uUFlzMTFFek5Ycisyd0R4aGN2aEpX?=
 =?utf-8?B?VGxvZmRRM2VITFJuRXBQZVJuVEZaK09vWlZjVFRULzhqQU1UdDY0RG5PUFFU?=
 =?utf-8?B?YUdtSDg3NlBpYVRwcDNYSnJRaUNDQ3loWVRTdjc1Q1d5ZnNPUmNoalJ1K0ZV?=
 =?utf-8?B?ZHNwNU5SQi9icXhCL1NTZXZKQU9pa0xTTXVPTmo2ZnllU2g3dmdJNWZ3TzYv?=
 =?utf-8?B?ZUhiMjd5dzhxMU4zZXBlRis0dUVhV3NZZm1VYWZqSjREeEhYU29YZ0ZUbVNw?=
 =?utf-8?Q?cGANrmrp0yY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2YwWlFuMnpnem1ySzM3dlhNbXBSUUlvSFEvcTYrbXZ6RDN0M3dxdlMxVHZG?=
 =?utf-8?B?b3NxZzdiQVhvRFA0NmR3RXVDblJVUXRYTW93UFR1NnVnNWk3M2dtNVp2RExx?=
 =?utf-8?B?RmFuMVlqRGhiOVh4SDh0U1AwMUliZlcrZmpMNVNHbndyUzdGVWxIOVF4NExD?=
 =?utf-8?B?eXNHQldkMzJjYzJIKzZmdFRmTm5rL3U4eUhQNmtmUHB4SDJFRUgzUWcyNzAw?=
 =?utf-8?B?V0h5Wm5FK2t0UkhpL0cwVE1HQmFpbEFsVzNIL1IreWNrUlVHR01CTDlNTFEv?=
 =?utf-8?B?czlwOFpPYU5vZk9Yd290dWdBT0dyN0wvWVZ5aUQ4NnQ3TTFtdThYcktBYktR?=
 =?utf-8?B?bVlQVUlZN3FGTmNDSjBBNHl3dTFBOW9HNDlQVG5CSU16UGRCOGVoaDhGZ0xx?=
 =?utf-8?B?UHJOQkJZZ2h1SUdiV2dvd1o2NjJuN0dva2pHMHp6UjRlTk5WRzJ0ZE1RMWUy?=
 =?utf-8?B?TGZGbkNzWW81aUZSa0FmVTJsS3VpSHhobHgxMXVvV1REOU1hWGRxa1YvSUtz?=
 =?utf-8?B?NTlIVy9idDZ3SzdEbUtsSHJvbmZpbUJZMDg1TlN4TWJqaUI2TExjVVNsQTB5?=
 =?utf-8?B?ajN4RmgwNnRFeWNQWE5sNzZSekkzcnBTSjF1T24rMXZWMnQ2ZTBuWmxOTWw1?=
 =?utf-8?B?ZFRsY0tjanlCV05CcnlONEIzS1pPblczUGMvNzBPUGVXU1ZLRzBpVmllclY3?=
 =?utf-8?B?eDJEWE94aUZiam1wbDFLNHpoN2NPVjBkRGVGald2dFlqd0RISS9jRGtNVWlV?=
 =?utf-8?B?RW9PY0dGZnN6cXRNbmpzTHQ1dGJlMjczSXhMbHVVWTlKL0VTNkZQVTFaMXNQ?=
 =?utf-8?B?OFBLa0t5TE8wTkVWQjhYUDRadjg0YlErVVJMVHc0amJQam1kZ0NGYzRZRlVT?=
 =?utf-8?B?N0dVa0JxNm13YTNlSUYxTENWSFYva0JqQkxDcnVzb2twVDFmZ1N3bGREQTBS?=
 =?utf-8?B?QitpSVBCalNTK2w4dmdXSVB3eGxIRWJxT3VrQmRDeHViUEIvbjVUTDdKZ25F?=
 =?utf-8?B?VWQ4cktGTlhGRUs3aHlGZC9OMkZoMWUxSUhVOE12c2NFRHJrMEduT0Zzbk43?=
 =?utf-8?B?cmh3a2tQMWpnNlFRZ0JtTS9YUE5JRGlXQ3Z5eWE4bE9pcEs3bndVTUVjR0dh?=
 =?utf-8?B?NlJvenhvaVhURzExTkR6SXVZQ3hmTEVXNTdlSnh0VUZIWWZXZDZ3b0oxekVV?=
 =?utf-8?B?SUlHV1ZkL2JrK3ozKzJuSDdGVlN3cDE1SFV0NG1USnZkSm8xdERIWkg3dWdr?=
 =?utf-8?B?SHVlWG1hTncyaG9rajNxQjBYaWlQMytFUW53WkhXYnFpZUZkbU14R2psY3Nj?=
 =?utf-8?B?ek5wMXE3SDZvcTY3OFJ5dGpsaHhpb1hqdnFsSjlhKzZXc0FiVHlBWGQ1aHhV?=
 =?utf-8?B?SStMRnplRFdyZW5oeVBkQ2l2Y25iK1VRekpLaEltdUdORlE3akZ1elJKVHp6?=
 =?utf-8?B?YVUvS213NG4xTFMzQlh0UlNVQjEwcFZ5VTdRN0xTNTQ0SlJ1aWJhU25IN1Fa?=
 =?utf-8?B?N2NhSmZRUHI4M0ViN2duM3B4aXhwbGVybktCbmtEMGNmNUJ2dHBLTzJMUC9m?=
 =?utf-8?B?MEhyWFhuaGdjazBoZFJZSzJWbXJkZFRVaHRqTXNKZ0RGZHlZVnVKZTNSbFAz?=
 =?utf-8?B?ZUtNYWJ6RmhZODRxNkFhcm9NWVlac2ptS3Nud0pjNmZpcFZGT1pMK0FKUGZI?=
 =?utf-8?B?d3VmV1NRZi9jWGJGVE1hRERIMXVZbFNKNVZyeThPZEU1cnFwWWFRN1JGOFlO?=
 =?utf-8?B?NUswR3llN0dXNHUrLzEzUkRjUG9sRlczV0J3K3FrNXN1US9SaG1YOFJKWjRx?=
 =?utf-8?B?R3JzenV0SFAxOHM5cWZRMVp2WTlkUGxQUmJHUFpzbG5YdnRWR2VkOXhtbUpr?=
 =?utf-8?B?eXlsMGppVDY3Mk1TWXprdE0xZGZCd3dvUk5uR0dZdHQrM2NWbWptZisvRHJa?=
 =?utf-8?B?M09iSnZzVHFtY0lOZERIMGNXNEpYQ2gyaUo4WnNpMFJlblcxRVdTMlE4QjlR?=
 =?utf-8?B?TVhCZFBKVXpHSmVidWlXTmxzZVk1SWpzcUY0WFQ4STF2ZlZOWFdKZGlhL0FW?=
 =?utf-8?B?blJQTzRJLzFONldzTVRTY2Z1QWNLd2I1dms3ak1SM3pYUzZwSlZGZDZtTmxh?=
 =?utf-8?Q?vKnjsBcq5g2NJavfvrScLKO2f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068a983d-3769-481f-f820-08ddb7bc4e16
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:55:55.2082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+qv49Cr9/Hq+cbmiuOVZTPHA6XPsOumfAT0bcCtWdeckEIZF59vxKlAb0Wx+nXU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
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

On 27.06.25 15:51, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, June 25, 2025 3:56 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v4 04/11] drm/amdgpu: validate userq buffer virtual address
>> and size
>>
>> On 24.06.25 10:45, Prike Liang wrote:
>>> It needs to validate the userq object virtual address whether it is
>>> validated in vm mapping.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44
>>> ++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |
>>> 2 +  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 25 ++++++++++++
>>>  3 files changed, 71 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index acaea4416ed2..a20f7ccbe98e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -31,6 +31,8 @@
>>>  #include "amdgpu_userq.h"
>>>  #include "amdgpu_userq_fence.h"
>>>
>>> +#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >>
>>> +AMDGPU_GPU_PAGE_SHIFT
>>
>> That doesn't seem to make sense to me. Why is that needed?
> This will help for aligning the userq object VA and then to be used for comparing with the VA range to validate the userq input userq VA whether it is resident in a valid mapping.

Yeah and exactly that doesn't seem to make sense. Please completely drop that define.

This code belong into the VM handling.

Regards,
Christian.

> 
>> Christian
>>
>>> +
>>>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)  {
>>>     int i;
>>> @@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct
>> amdgpu_device *adev)
>>>     return userq_ip_mask;
>>>  }
>>>
>>> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>>> +                           u64 expected_size)
>>> +{
>>> +   struct amdgpu_bo_va_mapping *va_map;
>>> +   u64 user_addr;
>>> +   u64 size;
>>> +   int r;
>>> +
>>> +   user_addr = amdgpu_userq_va_align(addr);
>>> +   size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
>>> +
>>> +   r = amdgpu_bo_reserve(vm->root.bo, false);
>>> +   if (r)
>>> +           return r;
>>> +
>>> +   va_map = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>>> +   if (!va_map)
>>> +           goto out_err;
>>> +   /* Only validate the userq whether resident in the VM mapping range */
>>> +   if (user_addr >= va_map->start &&
>>> +       (size != 0 && user_addr + size - 1 <= va_map->last)) {
>>> +           amdgpu_bo_unreserve(vm->root.bo);
>>> +           return 0;
>>> +   }
>>> +
>>> +out_err:
>>> +   amdgpu_bo_unreserve(vm->root.bo);
>>> +   return -EINVAL;
>>> +}
>>> +
>>>  static int
>>>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>>>                       struct amdgpu_usermode_queue *queue) @@ -391,6
>> +423,14 @@
>>> amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>             r = -EINVAL;
>>>             goto unlock;
>>>     }
>>> +   /* Validate the userq virtual address.*/
>>> +   if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args-
>>> in.queue_size) ||
>>> +       amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va,
>> PAGE_SIZE) ||
>>> +       amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va,
>> PAGE_SIZE)) {
>>> +           drm_file_err(uq_mgr->file, "Usermode queue input virt address is
>> invalid\n");
>>> +           r = -EINVAL;
>>> +           goto unlock;
>>> +   }
>>>
>>>     queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>>>     if (!queue) {
>>> @@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct
>> drm_device *dev,
>>>                     return -EINVAL;
>>>             }
>>>
>>> +           /* As the queue_va and wptr_va etc are the useq cpu access address
>> and they
>>> +            * are also come from the user space IOCTL request, so they may
>> need a access_ok()
>>> +            * check before trying accessing them.
>>> +            */
>>>             if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
>>>                 args->in.queue_va == 0 ||
>>>                 args->in.queue_size == 0) {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index ec040c2fd6c9..704935ca0c36 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -132,4 +132,6 @@ int
>>> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>> int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>                                                u32 idx);
>>>
>>> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>>> +                   u64 expected_size);
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index dbacdfcb6f7b..4615d3fba530 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct
>> amdgpu_userq_mgr *uq_mgr,
>>>     struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
>>>     struct drm_amdgpu_userq_in *mqd_user = args_in;
>>>     struct amdgpu_mqd_prop *userq_props;
>>> +   struct amdgpu_gfx_shadow_info shadow_info;
>>>     int r;
>>>
>>>     /* Structure to initialize MQD for userqueue using generic MQD init
>>> function */ @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct
>> amdgpu_userq_mgr *uq_mgr,
>>>     userq_props->doorbell_index = queue->doorbell_index;
>>>     userq_props->fence_address = queue->fence_drv->gpu_addr;
>>>
>>> +   if (adev->gfx.funcs->get_gfx_shadow_info)
>>> +           adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
>>>     if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>>>             struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>>>
>>> @@ -247,6 +250,13 @@ static int mes_userq_mqd_create(struct
>> amdgpu_userq_mgr *uq_mgr,
>>>                     goto free_mqd;
>>>             }
>>>
>>> +           if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd-
>>> eop_va,
>>> +                                   max_t(u32, PAGE_SIZE,
>> AMDGPU_GPU_PAGE_SIZE))) {
>>> +                   drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
>>> +                   r = -EINVAL;
>>> +                   goto free_mqd;
>>> +           }
>>> +
>>>             userq_props->eop_gpu_addr = compute_mqd->eop_va;
>>>             userq_props->hqd_pipe_priority =
>> AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>>             userq_props->hqd_queue_priority =
>>> AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>>> @@ -274,6 +284,14 @@ static int mes_userq_mqd_create(struct
>> amdgpu_userq_mgr *uq_mgr,
>>>             userq_props->csa_addr = mqd_gfx_v11->csa_va;
>>>             userq_props->tmz_queue =
>>>                     mqd_user->flags &
>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>>> +
>>> +           if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11-
>>> shadow_va,
>>> +                                   shadow_info.shadow_size)) {
>>> +                   drm_file_err(uq_mgr->file, "shadow VA is invalid\n");
>>> +                   r = -EINVAL;
>>> +                   goto free_mqd;
>>> +           }
>>> +
>>>             kfree(mqd_gfx_v11);
>>>     } else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
>>>             struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11; @@
>> -291,6
>>> +309,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>                     goto free_mqd;
>>>             }
>>>
>>> +           if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11-
>>> csa_va,
>>> +                                   shadow_info.csa_size)) {
>>> +                   drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
>>> +                   r = -EINVAL;
>>> +                   goto free_mqd;
>>> +           }
>>> +
>>>             userq_props->csa_addr = mqd_sdma_v11->csa_va;
>>>             kfree(mqd_sdma_v11);
>>>     }
> 

