Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826E9CDE003
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 13:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD2910EB3D;
	Thu, 26 Sep 2024 13:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qv7STxcY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006FC10EB3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 13:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edZB89pDSvJoQ1yHwCSstVtdX85iF+jOSMArygjT/qLtqtPyqjm9bOuHbNLoZQOyX3LxFwIJKPOhsR4JoS3+wSQY85GwYUE6UZj87kgJrAUsQoYu+w8sVrhBTcUjVeahmq61B7Z7PYO34HNo00YTFRgavVXXCFB2mtjRAYHciJW0hejxRkubE/cKBfiGeLBZsoc2iAMz/x9TPZzucJw12xSKihP3SUCuiYZynqovj9EPYvw4Tf7E6tH1seIoEFYS/Os9DnfstTvWpdpEWExaWVFbh8Dk8KJFmtlHV6dUATnLqikO7dRUC/Hz3gCnr092iPZc6V+V/U/mUqRRdQKfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZRTXHwHG7iZdKuk5pUxcwxBS95WWkSwUTOmtge+8QY=;
 b=bRiLYwTtW6ZoGvTdQSbSoGeTg4TTCh0ZKqBbgld6O7tn3BHor5/caRbIRO2SJraImgjb8SF5vRU5wmLIt9X6zdZ8Met9gj3NISffd9esO6CYIfs7gk+nJ2jKjrQMjQdpzVJgK89y6QOspULo312x26FvVNHjDfTIAzZsbDYJwhaggqZPxj4/PYxpUhPAd7PF44Ju3ubaHipIgWaORsFqQ58t4UoK9o+iHXPXnkv0v/kakxqDDf22zIqTfah4H5PUryoA8MoKruxtNsqM9mTBH31lOFye7YqJGDqpoquYLZ2GPOazpy3qSe7MJsDOHSt46FhP5IP+C+ux6vu7J0g10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZRTXHwHG7iZdKuk5pUxcwxBS95WWkSwUTOmtge+8QY=;
 b=Qv7STxcYteVxD745aw21BP/TUTF/v/zpY5IXLLhI2UvVDeZReC4OaouHPDvajA5cWAUxIz2l76tXQjcr8eZEMg3TknfiGKbN9zclT+Gd9rtXCcv8m3ui+u1FF84INXjj/oY6jMmcBfu4PWBRIZEgK1cDnKV8noYrKNaKKpgkLNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 13:18:25 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 13:18:25 +0000
Message-ID: <f3ee0730-f850-405c-b701-92c75de12f02@amd.com>
Date: Thu, 26 Sep 2024 18:48:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for
 debugfs getters
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
 <a760b202-560a-4824-8362-1e9a9fde2dfa@amd.com>
 <887489b1-d5ba-4a8b-bb57-68784173def0@damsy.net>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <887489b1-d5ba-4a8b-bb57-68784173def0@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ced1071-fda9-413b-0c9d-08dcde2db35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWNCNFJ6d2xhaDFZbnFkMm9qbGtVVnFxdE9MMlk3ZzFJSG1vYzlpSmFxYm94?=
 =?utf-8?B?SjNXeHFSckNNWkpERG8yRys2MkhzWDYzdElmbG9NTEJOaHBzdFZuRHoxOFVn?=
 =?utf-8?B?Y1FrekNSbFJqL2pxS0I5SElldVhZeGNQMVp4Yk9lWHdvSE9sMEZWb1pPWmUx?=
 =?utf-8?B?TU1qdXdPcmpoSHEzVXVsWWh3Rk9QdVVWa2RLcUs0dnlnR0RhblNrNHVHM2F5?=
 =?utf-8?B?OThaaW5yQUxJRXFtRlVWM1hIenFKNmVCRENMVk1hMmJsUUd4N01nL2JHT0Y3?=
 =?utf-8?B?SDM2S1BxSXBwMkJiYnh4c0IwaFFFdGRVT3o5dkE5ZWJTRDh0SzJSYTBWRHFt?=
 =?utf-8?B?eitud2VyQXpWVndodmRDRjE2a25NR25KejdBaFRocWtsMm15TndBZVFtNmxr?=
 =?utf-8?B?YjlCMjFKMGZvaXZCMEFTV3JvSmpmdGFtb0RGZktRVkVDZXRvLzB5bVh4THM1?=
 =?utf-8?B?QjQxOC9jMjBBWWhxSnRJemJOWlRJd1I3NWYzZ1VaVmpsdjZNY3QvWkhnN3RF?=
 =?utf-8?B?b1NtcVhUbENtRGR3WmNmMVhxTnl1a2Q2b3h6aHRhMERnZGgvOXBFRUpUTDJS?=
 =?utf-8?B?ZGtadXZ4NUFDWkRZWkpEVHVIZ3FtUWJxZWlTN2tUSTVzclIzNWZqRlk2eTJt?=
 =?utf-8?B?RDQvd09kOWxOR2dZZDRHZlpYVFRHY2FBcmN3eDJLNzRUVVBtV0psK2IxWDg2?=
 =?utf-8?B?aXRKZEJUb0h1R3lVdHpIWXU4WHJEWHVnYlpFTzVSY2c5MnA5NFRCRUZNbXZi?=
 =?utf-8?B?cmc4MlYwVGNxcHhDNTNHbCs4UlIzUlhvR1FoRkZkekRsRENHbkROckV5OW9v?=
 =?utf-8?B?OW1mVEUveWFnc05nbTcrZWxoTmVSVW9OL0FuZ1FFNnBwTyt5ZUpUOXNrNmdF?=
 =?utf-8?B?dW1pM0VpbWNuR0g1ZWtDK3hsditvNnNjaGttWTBjQm1XNkwyeXF6aUV4R2Fv?=
 =?utf-8?B?MWRsS2owcTFBU0tXb1BzTzJXRDJvS0F4M1k1Mmtjd2xEZFZMcENSdVhXRW1l?=
 =?utf-8?B?elNSRE44MWtXUCtyTTFPMzJYNmtUTHJsV3BnQ21MakN1VFVtSEI0ODkwVS9N?=
 =?utf-8?B?b1NTNGNpbjJjUHhrUm1wRkhzeHJIa2FYMG8yOWgxOU5pMDlxMktEZHFxTzA1?=
 =?utf-8?B?cXZoemo3YS9od3R3UmxzRllYZkdpZ3A5dW5oeUFlVUtVL3pSUXo4R2lkSm1D?=
 =?utf-8?B?KzFXNEpUT3NhUll2aytaMnY2U0ZiNzlpY3FhQk94VGpDRGFtc1JITTE3Q0Y1?=
 =?utf-8?B?U2ZmRHVFaFAwejlTVDdWVEFjTHJaUnNuTFpnak0yQmhlbVZnbCt3WXVkWTg2?=
 =?utf-8?B?VEcwWHF3R1NWQkxENE12RE95Z1lwQlpsZFllRDBTWmNTZXd3a2lEVW9BNmVp?=
 =?utf-8?B?bXpuRUk3NXUxckM3QkFya0F5VzU3Z1IvY2ZVdUgyMThwZnZUaTlPTUdNVnl4?=
 =?utf-8?B?Q2JodDV0SjZHV0paVTdmb1hiMjhkNU9EL3RVbHZVbHd0cUVhVHEwdyt1UVBh?=
 =?utf-8?B?Ky9EcDhQN282T2RFMmlhSW9YdnZtaGNOTVhlNnhTM24vNGd2TTVhSXRUV2hs?=
 =?utf-8?B?QUhBaWZ0ODRITTRrQ0F0RktXTXFKdnRueDZNQ3BoT3g4RlBUQ0w3cisrVjhi?=
 =?utf-8?B?SDUwSDAyVjk0WmNRc0xYRFdBTkZmRWZoMXBnVDRJOUd1WmJ5eFJHN2FpWjkw?=
 =?utf-8?B?THlkUTgxdEVEUlp3TDJhM1JyRXozVG13MnNNcFk2UlQzTGY4RkdZWGg3RzRL?=
 =?utf-8?B?MTQ5RmEyd3FNOGgvRnFvWktBZWJNTGZHbHRoRk9GT0llY1VTWS9kNHZ2Y2s3?=
 =?utf-8?B?aXhad2NjMGdsejlSSzdpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1IyVjdiMDF1alRlcTkwNWVtZTM1ZWdKTVFGMDRkaHowbElHeDNhTnlNTlhC?=
 =?utf-8?B?b1lHRWNFa3ZvVGtMcU50V0Y2ZWVRV0g4RkxCa2k4NUpBQkZ4YW5XcVptcDNt?=
 =?utf-8?B?andXTSsrTThoRlllYUtYNWhnT3BIOTF5WXU2aHRoejhGZUFNYjlHUkdaZ2R1?=
 =?utf-8?B?V09waG1ocHpkcUxkUlZHQ2tqL3VUMTRrWjJ2Ry9sMnhiTTVseWs5S2pKbFA5?=
 =?utf-8?B?ZnBMSTYvVUFXbE1XTzhrbjBlMTFoVEJBa0QyVkNiMUVXMW9WVUE2L1V3TTl1?=
 =?utf-8?B?cUk4ZVVGWWpkLzd3VkRvMndtKzhRci9xYVFSSFZxOFp0OHB1VzI3enVGOWwy?=
 =?utf-8?B?akk0ZmRrMzVsZVp2K00wallLSkJKVS9UREU1TFZ3MXFiZEhGczNkWGUzdkhT?=
 =?utf-8?B?TldSZk96QU9LTUVDbkdYR0lZUExweEM5WDlHMmhLbjhxRzRqNlpCZzNnRTZW?=
 =?utf-8?B?eXpyS2Q1UFArQVpiM0tKZFJiUGc1dmJaVU9IcW1ZdG5Wb2w4dVBNeXNVY1BL?=
 =?utf-8?B?dGJ0U1FIQ242Wm81aEVzZmZVUURpcW5OUlhUOFc0MHpxb2g5ZW1UcDRkWnV2?=
 =?utf-8?B?c0o4Unh1NUVMR29VWEV3QlJXTC9yZm1iakVYY29WNWEwSDRHTHF3Q3RyL3hu?=
 =?utf-8?B?M0ZkakxrMmJEL09TOG5RNVFwbkxwRjhpVUsrdlhHSXhIMWZiUkhZRC85Nk5Y?=
 =?utf-8?B?RlVOK1FkY1crcXNrZWlqUTdSdkZlNUpoS2NQYVVKNkZ4bVgvSlkyOWlLb1B3?=
 =?utf-8?B?RFFDM3BQU2ZGQnZwa2VxYzVwYU9nQkpmOUJnWldvd3BKYzB0NU5Ub2N5MlZ3?=
 =?utf-8?B?UlpxOVRaTFJkK0FIVlA1YzVTNHdzY1AxSG5qT0U0NFpJSjRBeHNlSXhIQ25Z?=
 =?utf-8?B?R0d0YWg2bEVQZVVuenNnRmZ0VzVBYXFFN3hDSkg5Rk93ZE9jQWd0WWNJNlVY?=
 =?utf-8?B?TUQ5WVpWNkhudlUrbWdSMml4dUxjYUJUeThVQnRQUk9KUUt5V29UY0JMRWo4?=
 =?utf-8?B?U1UwQzBkRkZtUmNHVGFGT20ycUd0YWlaZ1V5THBVRmdwZC9jeXp4b0JqUnNV?=
 =?utf-8?B?K2Z5dCt6Qlc3b3dFN1FtS2h2eFU3d1RjUjJWSnNvU3FBY1BjMEFFSFRFY0Zx?=
 =?utf-8?B?SlErZkZmalprWjVodk1PWHVmOXoyNGFIU09RUWM2TmIzMi9FUExDK2NvcGVI?=
 =?utf-8?B?bVJrRVRzaEMyMmk2eDNEdkVPcnJidkNFQTc1QjhWOSs2ZzBnamZZTU02Tyts?=
 =?utf-8?B?dTJVdFJCVXhuVFJIa0tjamxodEY5U0RYUjI0MkZjY1NoSjdTaCtuN0J3T0J4?=
 =?utf-8?B?Q3NVZXJrYzJTb0pYMDh5NkJHZHdrUjJqaTlrYXloWDNmSTRmVVg2ZkVFdDRB?=
 =?utf-8?B?dXdHYUtTazYyNnVTT0ZrY1BZcFV6azd3MEFzeDVXbmdjQ3pHUlF6blpaMU5S?=
 =?utf-8?B?TjBiUFgxdnZzM1l3UTU3a1BRRnVXN0EyMk1HSlNWMDlqZ2RJWlZZdTRsY0s5?=
 =?utf-8?B?Z3RpWFlMaWVJS21qbmFBc0RhWEQxYUwvTDhEbG1uREMrcVhGV29pRit1S3JC?=
 =?utf-8?B?WVUvK1JEWFdhS2dzalhJKytvSEJQWE1CMGcwOTFpS2V2aFpCZFZzTkhzdFpr?=
 =?utf-8?B?SjFtTGx2U1JhSEwrMzJ1enpjYjZVODQ0Sy9CaTBUMHA5TXhXaFE0bUE3TG9Q?=
 =?utf-8?B?ZjF1T09jTEpQY1huQ0lWNUVFVXFmYlBJRElON2RQQW81Zy9nRWtDclMyOGh4?=
 =?utf-8?B?SkdvWnZqUG80d1FTaFM4cFAwZklDeDJhYVBjc1dIbUFzN1hCZjdLSlh4eVpu?=
 =?utf-8?B?a3ZnYUJ0TTIvMmhzUDRjYlpkN1FXaHA0WFRObUpYUUFMQlBqaTJNWVhHM2Uw?=
 =?utf-8?B?aXNJOXVQdng0M25tdFlZN0p3emFmRldobUpXWU82VGJTWXNmSWtMRmkvYU1J?=
 =?utf-8?B?ZjJkSnFnaHpMYjJROUhjUDBPT2ovNmZha2pqS1pXTVlHbU94bWZTYk14bVFI?=
 =?utf-8?B?SmFzZFhVVnJZQUJwTjN4MTlNMkRUUzZvdzVDVDhzS0J4MSt1Szk0RGo5VjEw?=
 =?utf-8?B?M3hhZmRVbXpqc28rUmh3dnoxUkpxdnpjMWVSRWtuNGhjdHFkcFhqL1dTK2hL?=
 =?utf-8?Q?tJb5T+lMOsPg5SjcerejgvLha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced1071-fda9-413b-0c9d-08dcde2db35f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 13:18:24.9801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h39hiBDUw9l/bsGd97/6zYBKBHfR1de5oNWutxy5rc0Bb+avNCdG2o2i3bQeJT+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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



On 9/26/2024 5:56 PM, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 26/09/2024 à 11:27, Lazar, Lijo a écrit :
>>
>>
>> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
>>> Don't wake up the GPU for reading pm values. Instead, take a runtime
>>> powermanagement ref when trying to read it iff the GPU is already
>>> awake.
>>>
>>> This avoids spurious wake ups (eg: from applets).
>>>
>>> We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
>>> about "is the GPU awake?" not about "is the GPU awake and something else
>>> prevents suspend?".
>>
>> One possible downside of this approach is - let's say an application
>> tries this way on a BACO enabled device (device is visible on bus, but
>> powered off due to runtime PM)
>>
>>     Get current clock level
>>     If (success) && (not desired clock level)
>>         Set clock level
>>         Submit some jobs to run at set clock level
>>
>> This type of approach won't work since get clock level() itself will
>> fail. That said, I don't know if there is any app out there does
>> something like this.
> 
> Yes, this would break this pattern but I don't see why it would be used.
> 
> If this theoretical concern becomes real because an application reports
> a breakage after this series is merged, we can figure out how to best
> deal with it.
> 

Right, will see if Alex/Kenneth has any comments.

That apart, the series looks good to me.

Thanks,
Lijo

> Pierr-Eric
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
>>>   1 file changed, 69 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index c8f34b1a4d8e..f1f339b75380 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>>   @@ -268,9 +268,9 @@ static ssize_t
>>> amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         level = amdgpu_dpm_get_performance_level(adev);
>>>   @@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>>           memset(&data, 0, sizeof(data));
>>> @@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>>   @@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_pp_table(adev, &table);
>>>   @@ -840,9 +840,9 @@ static ssize_t
>>> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>>>           ret = amdgpu_dpm_emit_clock_levels(adev,
>>> od_clocks[clk_index], buf, &size);
>>> @@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>>       if (size <= 0)
>>> @@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>>>       if (ret == -ENOENT)
>>> @@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         value = amdgpu_dpm_get_sclk_od(adev);
>>>   @@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         value = amdgpu_dpm_get_mclk_od(adev);
>>>   @@ -1379,9 +1379,9 @@ static ssize_t
>>> amdgpu_get_pp_power_profile_mode(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>>       if (size <= 0)
>>> @@ -1467,9 +1467,9 @@ static int
>>> amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    r = pm_runtime_resume_and_get(adev->dev);
>>> -    if (r < 0)
>>> -        return r;
>>> +    r = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (r <= 0)
>>> +        return r ?: -EPERM;
>>>         /* get the sensor value */
>>>       r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>> @@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device
>>> *dev,
>>>       if (!adev->asic_funcs->get_pcie_usage)
>>>           return -ENODATA;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>>>   @@ -1711,9 +1711,9 @@ static ssize_t
>>> amdgpu_get_apu_thermal_cap(struct device *dev,
>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>>>       if (!ret)
>>> @@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>>>   @@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(ddev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(ddev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>>       if (size <= 0)
>>> @@ -2700,9 +2700,9 @@ static ssize_t
>>> amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>   @@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct
>>> device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>>   @@ -2855,9 +2855,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_input(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>>   @@ -2916,9 +2916,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_target(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    err = pm_runtime_resume_and_get(adev->dev);
>>> -    if (err < 0)
>>> -        return err;
>>> +    err = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (err <= 0)
>>> +        return err ?: -EPERM;
>>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>>   @@ -2986,9 +2986,9 @@ static ssize_t
>>> amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>>   @@ -3152,9 +3152,9 @@ static ssize_t
>>> amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    r = pm_runtime_resume_and_get(adev->dev);
>>> -    if (r < 0)
>>> -        return r;
>>> +    r = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (r <= 0)
>>> +        return r ?: -EPERM;
>>>         r = amdgpu_dpm_get_power_limit(adev, &limit,
>>>                         pp_limit_level, power_type);
>>> @@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct
>>> amdgpu_device *adev,
>>>       if (adev->in_suspend && !adev->in_runpm)
>>>           return -EPERM;
>>>   -    ret = pm_runtime_resume_and_get(adev->dev);
>>> -    if (ret < 0)
>>> -        return ret;
>>> +    ret = pm_runtime_get_if_active(adev->dev, true);
>>> +    if (ret <= 0)
>>> +        return ret ?: -EPERM;
>>>         size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>>>       if (size == 0)
