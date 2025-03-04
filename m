Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA3C282D2
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 15:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A27910E637;
	Tue,  4 Mar 2025 15:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EefdbmNm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43CD10E62A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 15:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7m2KCWSHqkt34En5mBg7wmM+w31BdRVlrDOrLuO1ZDhtU0Sc4Etz45fUPKWYwfupzcMYdc8SJvFWA1hbpG/6YpKBCWRO448IC3iIKc2AQ3bS/h6jmMcnbMCeS6oqOh4cqnCaJun9Fxv/wJ2zQG4lFkbAFzZFmdx646ZbfGIW+9gM2y6mj2nkvPqxZRI+FKGH3vOjNnaK5imLgXOBuklz9XsMTkfSr5CenW6gGziL4keKIJMjvrQGLek2bhk3YFSbrXqLBSxYttTpcG0WlcgekV8sphmqGzchB+BKBVJmpsXRf0lgo4O1Ai5w3pJ2Zl9PWV9V7TSrV4kTJgygvC03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71oZ111zKwt7Ir6tn8B4q0TgRXxpIXve2HY0I4zKt6o=;
 b=P9XSVMDvqp5ERQfYG+xlwLMOgg2QIfDMIn2d+WXtu1yLBeFWiBpzf8tmJ5pJTeI3O5uwQfhCZzYrRplbH1VfsXPIl9YluBQ7sbK/W1SzaFW+xpcB0Go7Z8M2sUg6WlOBJ8/2QTs8cFBGs5U3w/WOABPh4BOuEDdmxZmoyrIlndKudlLFD+wpiU5lKGVey/o1TvuWBk3ScADfIR6gesTUU8CQSYRhbS2TT+7eQrbsOeNYm7rZCQo4MSvYdlbsEkDCC9gz526sDLOf9bdrK/eGVr6dVZiESTkrX2MVldjt3i5EQonXJ2JBOtvYr4S2yzjauUL9lDPUDLnLZmEmox+8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71oZ111zKwt7Ir6tn8B4q0TgRXxpIXve2HY0I4zKt6o=;
 b=EefdbmNmmHvspwH2IrnpzcaAHmcZmbe4dlHh4iLhBUJo16r0BB3m2SMiBP/fVc7Db0eZsnGBFwPYlh4nL+ogV3ZCCW0j9eWeZZvxLJPWKYxAeATqDR5MIw4fZsnjW1DRGsaGVVYDI/BHZKFMAcAIOzcTFKg9GAMLdQsF+fxMzCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 15:18:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 15:18:10 +0000
Message-ID: <65540eed-7510-4fd8-b90e-1eb0a377a84e@amd.com>
Date: Tue, 4 Mar 2025 10:18:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: remove unnecessary cpu domain validation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: jamesz@amd.com
References: <20250303184508.2277310-1-James.Zhu@amd.com>
 <71929ed1-6c22-47dc-9f9a-a4bc15b21629@amd.com>
 <f487c2da-fa5f-4186-a556-005617d603b5@amd.com>
 <f295a68b-c1b0-4109-9369-71d9b80a6e44@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <f295a68b-c1b0-4109-9369-71d9b80a6e44@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fff0a2d-4c90-40c7-61dd-08dd5b2fc63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0cvcXkvNlVJKzY3aWRaYzRNNm1EWkZ2dG10NCtrT2NPZUx2QmtSbWdhT0lE?=
 =?utf-8?B?eTF6UEYzdGl1aVdHL1V3Szg0eUhHOTZjMW8yVExKeVJwU1FOc0Y2VkJTaFlh?=
 =?utf-8?B?Q3IvUWQvOXB1cGVwbDlaTmFFTU82RDNRSURpaStvWSt0NWZFT1lmdUlOOUdU?=
 =?utf-8?B?NWpXRUdkM1RGT0JaNFpveERkbGFseldOV3gweU5KdmEreUVMdlM2Mjcvd21w?=
 =?utf-8?B?SXhlQXJZM2pHV2QwK3FwUFNhb0R1YnY3N3JCeHp4UmFyMnUzNzhkTy9mSlND?=
 =?utf-8?B?bXkybFFwc2hkbFVIT01rcW1tdHZWaXN6VXh1aWhScVVEQktRUmhFYWwwK2x4?=
 =?utf-8?B?aldoS3F3YVlCZ3ZoK1F3RXBkZzVJNER5UHp0R3RiNkVNcmNRNzY3bGNhNWtp?=
 =?utf-8?B?UFJUSHVXUjRJdVZaSHIxUkhOSGhyUWVrcnRabGoxeTVhZHV2ekpDZjAxa1hj?=
 =?utf-8?B?ajNKR2UxemJqZDNKUVFiQmM2UEUzNGJlaUs5YWpTaHg0Y3pWMGtXeU5JRU93?=
 =?utf-8?B?elNrMFNueGFqNG1VZFhOT3hJNHYvTDlETEp4ZTZZOHU0bWswRkF5Q1M3b2RQ?=
 =?utf-8?B?cnJsZGQ4SlZTV25GcG1wQyt1bzZiekNCY1dId2VOOVhPWWFYVW5mUTcybDhp?=
 =?utf-8?B?cmlkRS85Wk05RmdDVFp0NGNSbDA3VkhVeVhNdTVnY0FqUTFsUnBIK1pDYUdR?=
 =?utf-8?B?WUdJMkhDT3UzbTQwU3VQSmlYTEZKVDBxMFdGSnhHQWU4clNoOEdvcndDT1I2?=
 =?utf-8?B?aG1TQ29hc21nUnozS0hFcmw3Z3IrLzAxa1RwTkpHSktzZVFWZjdiRkhWamVV?=
 =?utf-8?B?Qm5HMDlEZmlZaUUycDNGbERhTnJQYU5Wdkdxc3lwdGNKWTl2QU9seG9ja3hY?=
 =?utf-8?B?L05NNzRlK0VjMk5BOFdwL2JvWUZRT3lxNHU5dHp0RnNLVmRpUk1TUVJxUDQ0?=
 =?utf-8?B?a3p1TWtVNWM1QWc2VUw3TzZFT3JpU08vb08rOFhveXlpRENnTTNsQWtvQkhE?=
 =?utf-8?B?d01FM09rNzZvMTh5ZnJDTGdiRXpub0VnKzkxaFovT25iS3dRZ1lDc0g5TnNI?=
 =?utf-8?B?ZEN6RjVDQUtneDNoUlVEdzhQTmRiUUlyWVJPbUVmc2FLZUU3SUJIR2c3c1pE?=
 =?utf-8?B?UGE1bldQaDVrYUgyT2c0NVNxU3Z2UXJmTGxTTTgxVzNvSDlCbDNGMUZkU3Vi?=
 =?utf-8?B?SEhscG0vaFFuTW55VWJLTE5xekRRUjJ2TGNvVkx6NGxOeW02VnNWS1NWWkM1?=
 =?utf-8?B?bFl4TlJYeXhvOHRobGQ1aW5XVzVvNHR3RWJpL2FjOUVUVStMazJRU2VKTVE5?=
 =?utf-8?B?UnAxdHhZbEhaaFM2VlNNMTlxTXZGZEd3RHRrUDdZOGY3ZXc0bUw5NFg5T3JX?=
 =?utf-8?B?UXFKRTY3OE5VNUNZTG1aTnZYMWdSN0YyWm1zRlV2VXArN0JvNmkwSmtXekt5?=
 =?utf-8?B?VHovRlF4TGxybmZPZlpmSTkzQzZ6MXgrL2lKWkdDa1lxY0pnWEJZdW5uamls?=
 =?utf-8?B?UGFrV01lQnNQVzgreng0V29RWXpTaTFRUkRVUjR3dVhMUGFEZytOM2g4ekhw?=
 =?utf-8?B?RFZDcE84bGZQU3kyU3BnUmpaWWJyVEQzdHpRYnR3ZUhKd2ppaE5VVXdPclR6?=
 =?utf-8?B?WllXdGtaZk9YTjZPNm40Q3VteFdoU0NicW9xSGtvc1hxUzNxbGdvMHRGZ3NV?=
 =?utf-8?B?RExQZHFRTEkwdWYyQnc5SVExcmd6S3Q3TFBYN0Zvd1dEZENWYjc0MW1ybnp0?=
 =?utf-8?B?SHF1QklwMXZqWDBFQklLQXIwWGJRcHppVWpseEFQYWIrY0hGYk4rOUhXcTFL?=
 =?utf-8?B?K0xyTkthVU9aZ0tNeWx2a2JsNDRTa05Lbms1Y3ppRUhiSmFEd1JOZzFGRnkv?=
 =?utf-8?Q?59urXgA12KKiQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRMM1lSbWlRMmdiN0NMSnBoR3luTTgrY3BtaDVGT0xqQTdieDVPYUFmRDBJ?=
 =?utf-8?B?bjA4K0V6clByKzR5NitsbHBjQ1JtbENmVDFidFg0MHVkOUNkQVJRdHppNGY3?=
 =?utf-8?B?R09xelduMlhieGdtU0RidUY3cjNpR1JpTWZCY0tXUGxIeFZSalc2Ymc1eE5o?=
 =?utf-8?B?cFY4Y0dPd0RvMjBnc1Yxc09NU3E4TDJYNVM4ZWVUWGlSbGhvUGVzUnRWek8w?=
 =?utf-8?B?eDBOeTB4N0hmTXlmbGhRamtOR1AvZlJaSnNyWFk3WkpRWEd0UTgwZ0gvc3RL?=
 =?utf-8?B?RGo4UXBWUlh4aEpsK0JsVmtoek9ER0k2bjhpSUE3alZxdkE3OEkxRHkvQlZn?=
 =?utf-8?B?MG1JMnBqenBvZk80cWJCVmhMV3lqYnIyNG1vdUljcytJRm4vNGhjV3AvM0ll?=
 =?utf-8?B?VWNqTTY3R01rODFNYnhOamJvelphWEZkbEY3RU94MjVTZXByZFEzb2V0eDln?=
 =?utf-8?B?QWxaK2dlTEhIaE1oOTRucVQvdWo4c1lNUzJ1SkRoamkzYmNmcFlMSnlNdkVz?=
 =?utf-8?B?N0Rja2hDaVV2bU43cWZjMW45RUdYWStkRXVCd0tROUgwUjhjOWVLdm5IbExu?=
 =?utf-8?B?QjA5TzQrK20vVHV2ZXJ0d3RmZFJHQmJCRUJjN2QrMEZmNnAxZ1BMdVpma0tJ?=
 =?utf-8?B?a2N2S1FNK1ZyaHVYRzJoVzQydlRIUWZQUEM0V1Q0cWZrUC9CTlg1dWhkK280?=
 =?utf-8?B?Zlg4Tm40KzZ4Y21HTVB0Y0M4WUdwN1c5bldsbWNzSTZscXU4V2c0NXlmT3pN?=
 =?utf-8?B?cmVQNXNyTVJSNGd2blZqZy9na1owbXdUT1BCVjc5cjdaRldJTmUzeDRDendq?=
 =?utf-8?B?cHI1bzZKc3NTTWtROHROWjNZVDQyNnFzT3BoSGlXYXQyV24rWlByWnFsaFF4?=
 =?utf-8?B?L0VtSHhkUEpOdFovbUFzelZ2a3U2RjYyNDI2cjhITm5QMFZLeEh3RWhzcGNn?=
 =?utf-8?B?MzJEZ055OHMxRzVhNVZUcUNpSVZMRTFiWGJYOVNkWUZNbkRBVTVzZDZ3WHpv?=
 =?utf-8?B?eTZZek5ZbFoyQXZUM0FycFlPS3JXeEVxZEQ3YXgxZ0pManM0TUlXcTZhZG0z?=
 =?utf-8?B?R0NLeW8xZ0dUMHh6eEg1cUZFT1Zic1pnZCtJQVUzVmZ4SjdIckQ0SE1ub240?=
 =?utf-8?B?ZFM1Umc1WG5OMFppNEZaM3k3MC8wanV3VGFkK2JzcDlmSzg1a0xOMC9YMDFV?=
 =?utf-8?B?R2RGekQ1U0U2T0R4TGttY2VxVVJucDQraU5iNEFwSXJrdCszVkFuS09sWGQ5?=
 =?utf-8?B?Q2dpTUtMSGFvVU9pQXZsQ0ZmdmgyQWx0OGtTUVZnNFpCMXFoL3k2aVAvYmJz?=
 =?utf-8?B?SUI4QkNYK05YNmw0WnUzaEs3YWIvc2FnWnFEeWRtVGFKU1RRMitDbWM3UWFO?=
 =?utf-8?B?bGI4aW8xSnVIOEF3RkdRRFdTbHFxeEtCUHNkVkVFWGRVaG9LSTdpUVQrNG9h?=
 =?utf-8?B?RmpyaHI4R1hleUFWdUJ3cEFiZlA5Wms4bU92aHlqdUw2cCsvc05ieDFFck80?=
 =?utf-8?B?cmRCUVJITC9wSGR2UFlYQ2F0NG5yaGRzakUyaVZ4S2NtV0NhcGg3MVRoUkpG?=
 =?utf-8?B?eENzRktja0p0d3dHQjUvcWFuWUw1WHZ3ZVFaZUF0WnVvbmRCYzRaM1dqMmov?=
 =?utf-8?B?amNFbkpVd0MwRlFVVFVreTY5eklZSjRrTWNjTlpNNnltQnloWFFZZ2Y5WTI5?=
 =?utf-8?B?ZEhGY2tYSGd6alRjUTZmYXZjcll3WlFkWVZyWUN0YndSUS9wOVp4NzdXeURW?=
 =?utf-8?B?aXNoc2c2a1FRbmZLejB0VmJLaUV0Q3h3ams1SmlSaWFpWVdVT1ZjVTRyM0Fy?=
 =?utf-8?B?K2tWUVRrbDR0TkhraG9LcFBsL2ZLSDJldjhIcThMZ2xvMHBWS3k3ajZYMUNw?=
 =?utf-8?B?QjZFb29VOGFxU0IzdDBUWWdIQ2VndWFNdVFrcHQ0bWZQTFJpaFNIMGVtdHNp?=
 =?utf-8?B?TkVTZzE2c3VYZy96YVd0Vitra1BoemNtSElzcCtYTDdvMkZWd0EzdFh5eFI4?=
 =?utf-8?B?UnlzRDhSYzIwWEM1dXNWZExEWUJ3SEhnNy90MTJVSEJYVDN3cUNPMUNOaEs0?=
 =?utf-8?B?UnJSZW5qSVdMU3VXbWY4SzRzWVc2YUNjTW1Fb0xGdXN4REttK2JCQUNubTcw?=
 =?utf-8?Q?DBPSKJ9i6+Xn2U5JBEs7lWsn5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fff0a2d-4c90-40c7-61dd-08dd5b2fc63c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:18:10.5402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1v8SJI3iRsciqb09q1Bi/zkCD3EAkvED6vuYq4QRr9VCDLK3XexnbjJml89Eae1zzUvfTMnt6vx3FmKbwwSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

On 2025-03-04 5:38, Christian König wrote:
>
> Am 03.03.25 um 22:01 schrieb Felix Kuehling:
>> On 2025-03-03 13:48, Christian König wrote:
>>> Am 03.03.25 um 19:45 schrieb James Zhu:
>>>> before move to GTT domain.
>>> That might not be unnecessary. We sometimes intentionally move BOs to the CPU domain to invalidate all VM mappings.
>> We discussed this in our VM sync meeting this morning, and I wasn't 100% sure either. In this case it's causing a nearly live-lock of mutual evictions when two processes share the same BO and have both their eviction fences on the shared reservation object.
>>
>> I was thinking the VM invalidation should be taken care of by the DMABuf move notifier, so this explicit invalidation seemed redundant. Is there a way we can test or otherwise verify that we're not missing anything?
> We used this hack to validate into system domain and then GTT for userptrs, but I can't think of any reason to do this for DMA-buf imports.

OK, I had the same intuition. In that case the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Regards,
> Christian.
>
>> Thanks,
>>   Felix
>>
>>
>>> Christian.
>>>
>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
>>>>  1 file changed, 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 62ca12e94581..2ac6d4fa0601 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -595,12 +595,6 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
>>>>  {
>>>>  	struct ttm_operation_ctx ctx = {.interruptible = true};
>>>>  	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
>>>> -	int ret;
>>>> -
>>>> -	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>>>> -	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>> -	if (ret)
>>>> -		return ret;
>>>>  
>>>>  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>  	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
