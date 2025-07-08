Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EFEC83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 09:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7384910E169;
	Tue,  8 Jul 2025 09:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJN6TzvR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBCF10E169
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 09:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4WjUpxr8dIK675v+bi67zhQb+cF7i/4ftoCw1oDA/R7EQgJGW7LnSICCQj71EYlaJ9+RljPISoXlZ9RC+iGOMqW1Yar0wYXWvsxoklRMoSD19EFQV6kPvEQJiFDnFFImIvSQrxH1ZRkwbJefF0SjyIHY6iJebkNeiV35cZYpd0yotGO5Y4auwzmwhYMpdxNYY9EG4R54NBFjx9ClAGrOIPJcpRZHTSspHV/DRx2GqoxUaTZzaaE75orBp6C8jehr8eOoxFzlCGBPR1JVkM4bzLkvY8N1dQ9zXYpT75/drnd78TxH9Mtm0AVXg0K8JHZvevNxjoUYz1G0p9zYjV7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZEXHgacyqP1lKq980K7bB8RDdUbUK9PsGZp8AfpFjE=;
 b=n1DrtdUtngKRrCHeXK8KcWMtkrGqa5Q6bJEFASujORdSGBdB4YQUoVSvRn5a57HKUxOJ68+m0dRHrBiv7+y9WJHZL3i3oFswu0iCPDqMooxZvuwx9MZdcMpbrlJVTwSe2sYqu4VOv/smCRUPftXexCFXBezPe9Diw6ahHSzb6OTSXQWgGlI8A00ewdS1Uf3/XT4gJmdrZqHUxpwv4RC5KktuFFlsX++wSnJW24BC+nRM1fRSbXSHeJougu+ftkEsW/jWgUT8caX+v3agNQSjaq0i6sOATus+kVy0TWiUmE9Lq0H50SHiQuaw0XIaXj+5Y9TyRtOlzvlO8YOnzeqbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZEXHgacyqP1lKq980K7bB8RDdUbUK9PsGZp8AfpFjE=;
 b=VJN6TzvR6OGOok4xTD4ryBSc1XoGVswlWTQm4Q0JrPAriHUA1udoFx9lgMqfQiJ/4i2kvFPXOaQwlDuYHO9llVsNq3OOUGgFnrImprsspLjTc9paUXQ6n2Lur2UKnYbTUfWM4pDvsCajDOwJFYWkannP6C6ehfDMNmnmRRoAcKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 8 Jul
 2025 09:18:29 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:18:29 +0000
Message-ID: <1de2e4a6-0744-4e4e-9f6c-d2d230b236c0@amd.com>
Date: Tue, 8 Jul 2025 11:18:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-7-Prike.Liang@amd.com>
 <ce86ea02-f0f2-4f09-a168-22f89c9efaf5@amd.com>
 <DS7PR12MB6005CB25950A54FD330618E5FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005CB25950A54FD330618E5FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2875933b-78f7-4623-ae17-08ddbe0066d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXlyc0psUDErenpqejFiWHNxamJsT0sxVFVuZmQvclV3cG91VGlZYXRSZmlw?=
 =?utf-8?B?NFVZVG1wSjBqdFJuVlNTaXA0aVZLNWcrOVFZVEgxUHpOcHRLODErc0hlNXk3?=
 =?utf-8?B?SnpmYWNrWVVFbDRtSmF5VFM5Nnl4QzFWajdQQzQ1Wm0yWW9sM2puZFQzdTdB?=
 =?utf-8?B?ZG5RbVhCTk9sb05ONU1QdEpvTisvMWV1dCtVcE5mWWgxRlpNaGNhMWZEa3gr?=
 =?utf-8?B?dTZNMU9SSUgzLzFOK2VabHRVa0FIY3paZjREdW1tcHlSVXAwRWhlZDJnQ1Zh?=
 =?utf-8?B?TXN4d0p5SDhvWklFZlh5aGRibXVTOTlFdW9iR2ZYdm5kRXhadEYyR0NGaGVi?=
 =?utf-8?B?U1J3NlorcTVBZzE5SGpMRHhaS3JPRVFNVFdZWS9BNmJ5cXNrL2s0aDZsWFFw?=
 =?utf-8?B?WjZSZ1NMZ1U3enk0Z1hjK3Z4V0FDZmdheGtIMzRNMUp4eno0ejR2b2ZQOUti?=
 =?utf-8?B?cUNycGtHdktSVVRlN3pWdGZBay9TYUFqWXR5RWh2VE1TV3hlQnNZL0N6bVBV?=
 =?utf-8?B?OG4rM25qQmtldmtZbGc1ZzArZmxINFVRSjFDY09UdmVTb2VScE0rcmdBL3d4?=
 =?utf-8?B?aHRVUnVmVUp3ZExXS21uM2tuN1dsUUtaNi9nVmh3ZmZXZGVrYnRDaWJwUWFP?=
 =?utf-8?B?cThua05TSnI1SVVLZitRZEh5eTQzS2EwZGtzYTd5dVUzVzF3R3RndDJKc0I4?=
 =?utf-8?B?OHRtaXVBYzNkVjRsKzhMdTlyYkxERTZqaDRwSWZiZUNRUEV4Z29NM1RCWUVy?=
 =?utf-8?B?UHlEUWJVZzgzUkw3Z1pIQjl5WER5SmhNYTVaemdSelF0WDd3RkNzTzdXMmNt?=
 =?utf-8?B?Wm4yamdNY2N4NzMxanFMR05pOHNaNm8vMWhrZ2swNUlFQkZEWFdEdHB2WXNa?=
 =?utf-8?B?TnEzeDZBUWV6aXRZV1JzaStkdnZZM055ckxmcHB0QXByTVhvRW9IdEZUOTl5?=
 =?utf-8?B?VjdjcmVnSC9nOTh0S1UyZ1VqL2JNTVRFWlpHVjJhY3BKaUFRMThSTjF2Y1dl?=
 =?utf-8?B?dVJ2ekxnQlB5TGVLT1RsRFVQZkNIY1JDV0k1dTg4ZGhNUUVGaktrWW9HYjR0?=
 =?utf-8?B?VG0xbDNYQ3E1aHk5VE9yQzRLckZVVkV2UDIwNjZDVXNzbHJESERIQWxOWTJn?=
 =?utf-8?B?aFNESy8wem5nRnpwMk5QbFFVelRTRWR3ak9YRHo4aXZNVjZ2d3ozZ0FJYTg0?=
 =?utf-8?B?NXFlSGhWT3VNV0RmWStJZjhIQVhPSVNDMW1DZk1PNCtjM0hKRjAwZG9pcFI3?=
 =?utf-8?B?dUZ5QmZ3enNqc1VkdElQbllrWit5R0FNbmhncWdYMEtsVkdDQ1lOamNqaUpt?=
 =?utf-8?B?c1BlTmxTSmViUXl1SXBUbjA2UnZtc01UQnV2dmtmem11RExOL3pLN1VXdnRO?=
 =?utf-8?B?YklQMmRzOUhVR2p2bnprYURFOVA3OUlwejZSTmxncCtlK1g0bmZ5RDR0Rldj?=
 =?utf-8?B?OEMyNUVLSW05SysxTlYrRTAxMjhxcmhxb3JmQmtiMkI1UjVnT01MVzl3UHVN?=
 =?utf-8?B?SENRNFdTekNncURqQjdSdERWRGJyNWdGazBKSU9WTEhvL3Y5NUg5RE5TTVpF?=
 =?utf-8?B?SzhkN0g2bXhjbzR2MHRJNnBLSGg3bmorT3NqSStNZ3ZLWmVDS3FzRkJUMGFG?=
 =?utf-8?B?ZVRSZkFZQlIvUlNDWVNZZ2NvcEdrcEQ3OElRaTRKVmN6aGE3RmNDQzRVcmhD?=
 =?utf-8?B?RFFFR2c0dkFpUnN0Wmo2ekVNOHJMcGcwK3NSVFowYmJXSUFKUkM4UHlqZEgx?=
 =?utf-8?B?ZUlXcFk4ZVJMS1hDTGtuSThSdHM2WHV1QW8wQmlTL0s0VlFETlZMa0RUak80?=
 =?utf-8?B?U0U5STVOOGxEczM4K3BNVTVLQTBGaDVZNkRXQlphTmdqRXFPYWVxQlJSUFh5?=
 =?utf-8?B?UWJGVk9IMVE0RXdSL3BQM3BnZHRnZUdEYVlqbFQ1UjZlYlNXTlRYbWJuWmJC?=
 =?utf-8?Q?6trQovSoGEE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3R4eTB1ODNYYUt0KzhBQVNsTUlvVi9RWTB0dy85cHBHWUVxUFBxY0tpY0tZ?=
 =?utf-8?B?Y2p2RWpFak1DbnhkMVR6bll4OFJwRlFCNDZpcE14ang2QWwxRS9PNmxoRWpC?=
 =?utf-8?B?YXJWYkFySittTnJ4ejdPRlgwbllobzZNWXFkYklnd0dmWmF3YXZrbnM2WC80?=
 =?utf-8?B?enBLbEhZMlgrQkNlRWVpZUlBSGdWSzlIcnhQRXgwaU5HN2VRaFFyS25XaUVz?=
 =?utf-8?B?TDNmSDFsakhickYyY0dqdVJJV0tEMFMzZ2RVV08vbVdtVTBPeXAxUWVFcG5H?=
 =?utf-8?B?eXlQL2UybkZZdkFlZDJ0RlNodmFrWG1TVkovZmNLSXZrcUN2d3VyNUYxU2hu?=
 =?utf-8?B?QnAxRUpGMXNQTmxMWkhIMndWcnJ6TURJby91UDRGTmpodXlRcXd1R2loWmZl?=
 =?utf-8?B?MFRjUWdtRVk1RzNKRFJBV3VvekovMVNNNEhBSTNoQjB1TkNlVlNtUXNnV1dh?=
 =?utf-8?B?TmZFU0trY0x5NE9jcUczNlZQVmgvcFpEUmIrZG81aWNCbXhvdGNhTlhvNGZi?=
 =?utf-8?B?S05tR3BLRUM2b3A2dCtNcTh1NHZwdm1RelQvbUtDV0lIcHdyZHpMaHhwTjQ3?=
 =?utf-8?B?c0tkU3kxOHJGb1ZMdkxnL0ZjTTBXZk9jaERBYWQ5OXJWMDhqRzEzeFFEdVY4?=
 =?utf-8?B?SG01RmJUY3daV1h4WXc4SnQ1ZmZLNG1Ha2lJU3VVNDV1YjZBeXppQmZPN3lE?=
 =?utf-8?B?bFJONGg2R0pGOUtmTGV6TDc1TEJ1R21GL2dKbjBBY3VDc2ZCTENkdnJLNnVD?=
 =?utf-8?B?YTFWRU42NjE1MHg0RzhLOUhtSWRLTzNidDdvTFZHdmpNa2tYNWtUejBWbmRY?=
 =?utf-8?B?UmFXem9XL0hneSs2Vm94ZXdzMHhuQWl5clZpL3FycXR5T1pRcG9YVXg2bVBn?=
 =?utf-8?B?Q2lVNFBLd21pSm9VU2lVcG02eWtXdk5MTTRVdzFDTjZXTno4UnVKVzJQY3FI?=
 =?utf-8?B?TW5JQUIxSGJGNEdYbzN2amEyY2RzSmlXYTdxTVZRWjEvU3JPOXF5VE95eUpF?=
 =?utf-8?B?aUxGMkx5Umh0YmFLRW0vVGpPTStQcWV4T0c3b21SMTlpS0NraGx3Q3RSR2I3?=
 =?utf-8?B?RkpsdEJWUlVoNU95MG1PbE9qeUJlV3MvV1drOFpoY0tPMGVwT0ZzVlFnbHl4?=
 =?utf-8?B?ZEJFbHl1TSt5WlZZK25VdER1Szl6NnoxeEVEcVZNNDBFU0JzQklBWmIwekQz?=
 =?utf-8?B?bFljSlo1b0NZSVBoTDI4a0xnaVlFK2NydFZjSlVZM3hnWGN1L1pFeGZ6Qm1R?=
 =?utf-8?B?TUFFNWt3M2JsMjF1REdSQUttR3dtRURza1U2emt4SUo1SEN5UVZmSG1aZzNH?=
 =?utf-8?B?V0hsTVlNdG4xbWp4WEE3azBWbDNqU1VKUTBpczJXTzY1cXlnQzdjekVkZnpm?=
 =?utf-8?B?bldnOHZDY3BKeUw3NzFSbUFYUXQyNzFFNk5GcHZIV0U2WUVsejUvV01WdDFq?=
 =?utf-8?B?VkQrUS9ndzRVR0FpaTU5M1pTcktXUzV3cldyZW1EYmNFNXYrM3YwVzQxTTJ3?=
 =?utf-8?B?cGNqbW56LzhWL0FmMENMS3FSR2gvZmcwdWcxTHBRV0hrQWxnVXJ2SUpZek9x?=
 =?utf-8?B?RlRXMnVha0VGbkNNVFJSWFh4WDhvRnNjVEl4djRTVFRjZ2tFckcyMkJhT24r?=
 =?utf-8?B?OTk5eVVlS2xMeVJGakxZSUdVbUpUV0pSS0JMZUE1Z29rNWF0aU45dzU4eE9I?=
 =?utf-8?B?MnJ1NnArNHJ3UmZQSU5sZ0JtSzFQTHE3Z0dqS1ZldVF5TFBPSHpEcmxrV0tL?=
 =?utf-8?B?dGhwRUxmSlZLQ1FFaWxRaGhrWGplVU1aekVvU3ZPZjFKMUhwcmRYYXhTS1Qx?=
 =?utf-8?B?Mlc5S1dYa0FXK3JPZjNUSDIzZnlzSUlXdjVxZ3ZpbG9TT2pIdE96djdCS0lk?=
 =?utf-8?B?V0tnRk04WkRhMWgrS3lWc2dlUjlrcmJJSFU3bkNjS3JvSW9INStLb2JSQUxv?=
 =?utf-8?B?bTd2aUtpVWpocmVBdXR6N0c2THM3WSs0ODBTd0VRRFY2SEdBekFTWXMvNWtz?=
 =?utf-8?B?Zjd2MjV5bENIdE5LS0xPdVZkWnB1RmpSdndOeHVVWXYwNHR6M3FBTEI0Zm96?=
 =?utf-8?B?a1NqTFBQWEtSRUFINlpYUmJCYzQ4RnhTTzdxZFZTMWlMNjMveXl6bHM0ZGIr?=
 =?utf-8?Q?CLCsNzKFtjnZSKfuz/k7OLfBn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2875933b-78f7-4623-ae17-08ddbe0066d7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:18:29.3841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OmMqqPj59E9BRXNlzZbRyiaYUqBrsQYF/5/2Uht9xwP8wnmUoRv+cv6pJnAots+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

On 08.07.25 09:32, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, July 7, 2025 5:37 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
>>
>>
>>
>> On 04.07.25 12:33, Prike Liang wrote:
>>> This helper can validate the userq whether can be unmapped prior to
>>> the userq VA GEM unmap.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 78
>>> +++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |
>>> 3 +
>>>  2 files changed, 81 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 25a35ab7395b..30838e5279bd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1180,3 +1180,81 @@ int
>> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>     mutex_unlock(&adev->userq_mutex);
>>>     return ret;
>>>  }
>>> +
>>> +static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct
>> amdgpu_usermode_queue *queue,
>>> +                                                   uint64_t va)
>>> +{
>>> +   va = va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;
>>
>> Still clear NAK to doing that here.
> It seems there's no existing VM helper for aligning the userspace VA into gem mapping range.
> Without such alignment change, could you please give more detail how to covert the VA between the user input and GEM mapping range?

Ok sounds like I wasn't clear enough what the problem is: Don't convert the VA between the user input and the GEM mapping ranges!

Instead when the queue is resumed validate the VAs and make sure that all of them are mapped. See amdgpu_cs_find_mapping() for an example.

When any of them are not mapped correctly then don't resume the queue.

As second step we then need to figure out how to suspend the queue when any of those mappings change.

Regards,
Christian.

> 
>>> +
>>> +   switch (queue->queue_type) {
>>> +   case AMDGPU_HW_IP_GFX:
>>> +           if (queue->queue_va == va ||
>>> +               queue->wptr_va  == va ||
>>> +               queue->rptr_va  == va ||
>>> +               queue->shadow_va == va ||
>>> +               queue->csa_va  == va)
>>> +                   return true;
>>> +           break;
>>> +   case AMDGPU_HW_IP_COMPUTE:
>>> +             if (queue->queue_va == va ||
>>> +                 queue->wptr_va == va ||
>>> +                 queue->rptr_va  == va ||
>>> +                 queue->eop_va  == va)
>>> +                   return true;
>>> +           break;
>>> +   case AMDGPU_HW_IP_DMA:
>>> +           if (queue->queue_va == va ||
>>> +               queue->wptr_va == va ||
>>> +               queue->rptr_va == va ||
>>> +               queue->csa_va == va)
>>> +                   return true;
>>> +           break;
>>> +   default:
>>> +           break;
>>> +   }
>>> +
>>> +   return false;
>>> +}
>>> +
>>> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
>>> +                           uint64_t va)
>>
>> I don't see an user of this function?
>>
>>> +{
>>> +   struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
>>> +   struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>> +
>>> +   if (&fpriv->vm == vm) {
>>
>> This check is complete nosense.
>>
>>> +           struct amdgpu_usermode_queue *queue;
>>> +           int queue_id, r = 0;
>>> +
>>> +           if (mutex_trylock(&uq_mgr->userq_mutex)) {
>>> +                   /* If here the userq bo is busy and needs to deactivate and
>> prevent reusing it.*/
>>> +                   idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>>> +                           struct dma_fence *f = queue->last_fence;
>>> +
>>> +
>>> +                           if
>> (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
>>> +                                   dev_dbg(uq_mgr->adev->dev, "queue(id:%d)
>> not belond to vm:%p\n",
>>> +                                           queue_id,vm);
>>> +                                   continue;
>>> +                           }
>>> +
>>> +                           if (f && !dma_fence_is_signaled(f)) {
>>> +
>>> +                                   dev_warn(uq_mgr->adev->dev, "try to unmap
>> the busy queue(id:%d):%p under vm:%p\n",
>>> +                                           queue_id, queue, vm);
>>> +                                   /* Need to set a resonable state for avoiding
>> reusing this queue*/
>>> +                                   queue->state =
>> AMDGPU_USERQ_STATE_HUNG;
>>> +                                   r++;
>>> +                           }
>>> +                   }
>>> +                   mutex_unlock(&uq_mgr->userq_mutex);
>>> +                   return r;
>>> +           } else {
>>> +                   /* do we need a try lock again before return*/
>>> +                   return -EBUSY;
>>> +           }
>>> +
>>> +   }
>>> +
>>> +   return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index 194ec7a6b3b2..08c49d738ec1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -31,6 +31,7 @@
>>>  #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence,
>>> base)  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv,
>>> userq_mgr)  #define work_to_uq_mgr(w, name) container_of(w, struct
>>> amdgpu_userq_mgr, name)
>>> +#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
>>
>> NAK to that, the VM should not be casted to fpriv.
>>
>>>
>>>  enum amdgpu_userq_state {
>>>     AMDGPU_USERQ_STATE_UNMAPPED = 0,
>>> @@ -148,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct
>>> amdgpu_vm *vm,  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
>>> u64 addr);  int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>>>                     struct amdgpu_usermode_queue *queue);
>>> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
>>> +                           uint64_t va);
>>>  #endif
> 

