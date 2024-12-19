Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6346E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F0810E2A5;
	Thu, 19 Dec 2024 14:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NguTjxUY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E2E10E2A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 14:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOPubPtzruhiok3++yAqjBh19tTe+ajThXxume4+eqlfdQI5UrSkRL1WNni08yRnFWlqFU0LE54nWFNJc3dY9BBjphfIF76IibxHhFuT3N/nxXL4/tjxM1aWytxuvOM8EI3ihSGStGKN9p4Ddjx//yEe8sxotbOYzDcF4DDwYc2T8PfGLJ6W5FVCuNB10tNFbtd+qmOdD/PYqgkW/lqVvW7pWUL004DStFEHCSLPHYPsvBJ/P7oGxnprHc1d4EfMTcRCpXRRUu8RDS1Y5gwqM9hiOYQF+qyHqXpRZL1WhUx2TBGnHxLGvaTree+0NBPcq3K8gxrLEA9Vzn0xRZp13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPeGSKY4LE2+dbKTcgtkLRCR2IZqIiLIMsEG+Qmdt7U=;
 b=zJwUjVUW6jZ8oK5asagAF+h61AhFlEaZButaVIpjYR2hXIy60agURl/VwK31V88Yg0D4HiTRZMv/g8ANa9kKJ9avt5SpwSNoXcHL7T0fKeScY2eObvpa4I1Gg+tVj/iFijTYONCodFbvyzr4JuOhdl3iJC79Zhowrehn5Y11HlGrCoFpgHN5gyHRafkqpxPqWnrzZPQH6ciuspOSdJbvn2Gb4aBo1LJFQ/tCZ2oyDD/RAHdicN/oSRa4Pb/d+MvqSaYJFcRefi21y7MXl0f5194w4tgI8xhu+A0aJex8QM8OOn/srZ7Rc6z+h0KfZRv9V9N6QwZAhFk2cyOXyvlnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPeGSKY4LE2+dbKTcgtkLRCR2IZqIiLIMsEG+Qmdt7U=;
 b=NguTjxUYXQhbgHcG06qTTttByrZZ+oY9NEtvAXbeiOSgztOEWzpS6RkOyb1Eo0xmT9/2WV+g2qHM9cI1bwBvvjANNiJsqQHKHcntpc0XYPuJRR5WxzJtZ1bn8q57qN5YZ/RaLLbh/N3uKMaajNLta9AhAJs/8HQPQJP4fGDrDDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 14:58:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 14:58:50 +0000
Message-ID: <d2978e96-512b-4826-94a4-fd09f747b570@amd.com>
Date: Thu, 19 Dec 2024 15:58:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "tvrtko.ursulin@igalia.com" <tvrtko.ursulin@igalia.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <868538e7-fb2f-4f75-8a7c-a995a733e8b0@amd.com>
 <20241216174924.2292-1-Yunxiang.Li@amd.com>
 <836c0549-159e-4c3c-8a96-a01eed47e35b@amd.com>
 <SA1PR12MB8599AAA4F68C3E1306739CD4ED062@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB8599AAA4F68C3E1306739CD4ED062@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3d2eb7-cda8-49d4-6ffb-08dd203da576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWxBZTFYcnVlZHJMam1DSk9KQkQyZDJOb0JFQTZtaEp4aGlOd3RpaHdobDAr?=
 =?utf-8?B?L3ZlYXQxNXZmZTZoeGoyRURScXdHSjVaRktab05tWlcvYVNOam92Z3FucnRQ?=
 =?utf-8?B?N3VOdktDVHNldE9GQ3ZITVpQN2Z1K0QxRkd3MFVXcDljdHUxNE5yVEJqS3pr?=
 =?utf-8?B?VUc4cG5pck40SWhTYzJOUmR5SHdqaGZHNHBvOTBBNEk1NkZtMGpZT3pxZDdN?=
 =?utf-8?B?MllHeEtOS3VCN21FUHNkWlRkYUxUVG5ac280Q1o5dW5nUjRHN2RkMVd0bVBh?=
 =?utf-8?B?TXdMSEgzT0dYeGNEVDhnN2RVV1FvVDBZVWJDNGFlNFVPbXpMMFFON1hkbzVq?=
 =?utf-8?B?ZnJMUG9vRk9DTU5sejZ5M1ZLVGdOOS94eTBEeG5COVlMWVdkY1BvQ1Z3cUg2?=
 =?utf-8?B?ZHBkTDMzOFlQR2dxaGVPMlY2ZmphNXp3OEpjYU5uaWIwMjVvVzkveldNbUhL?=
 =?utf-8?B?ZytWSGdaKzFsc1dVTmNRMG1yVVlHa2dqVi8wRkhhOEVEbVBZcGp4RW5lRE03?=
 =?utf-8?B?TjU5SWNYY000NE1OYUxVRGxqcXkwRTBOTFVFZWRFcHdiRGYra0FYbzNUTmFB?=
 =?utf-8?B?QkVSWWpNbWNhdmxsMFk4R1JLU0dIYzB1VlBDSDJya0NRQWxNbHgzTHpFaHhL?=
 =?utf-8?B?UVB0dGdmc3phamMyNVJmS3Fnd2g4YVFyVVovekZhRlhaUnJ6ekpaYTJsMkxy?=
 =?utf-8?B?RDhLczFXM1FZSGNVUThmWFdmYUtlK0M5UHpqUjRCeldEQlFpTGZQUVFJcFBF?=
 =?utf-8?B?OFBSQWh6bVh0ZnRNalJpbHB5aEVBMWlVU01WWk1aWjNBOWVUdHB1YXJSa0Ns?=
 =?utf-8?B?UVBaT2krK1MzckRuQXovQkxvRmhpeVM0cXZwaUdQbTQ2Tk5Tb1dGbEFPaE52?=
 =?utf-8?B?UmlxWkltZFJ1RU42dUV1TzdtWEdiRFU4dHI3cElTNjRwOW9KQWk3ckJnV1U4?=
 =?utf-8?B?MmxvZU9WaHQwanovbXJ1bURPY3h4WFdFMmNrNE0rU0RGSjg2OUYzdWNqU1lB?=
 =?utf-8?B?dllYV2FtQWZ0bGk0UTVDRGRsaXhVUnRmY2szbklYU2Rlc1NFVHdnN2duSWNL?=
 =?utf-8?B?NVBVRGZ1cDlWcGQreTUvU0gxZ0s3VFhuWkVLQkZBVVo3T0p6NjFuV1c2cjEw?=
 =?utf-8?B?Y3VYUWJEMWMrT2JVeTAwS3JpMlF0UnU0WUNwa05xVXRmT1VDTGhFcW43aGxx?=
 =?utf-8?B?ZVExc1p5R01QcmxMT3dZaEtIMk91MnE2cno2MXRNUHljd2J5S0IxQ1Nia3Vo?=
 =?utf-8?B?WnFzaVZJMlJrKzFtcU5iUVpuTUJFaEdvRTFnNEcxR1F6bUhlamRFK0VjZU5U?=
 =?utf-8?B?Vm92T1NsWWduR3M0QTFCNXZRTUd3T3IzSjVYdURMUVhjMkx6SjhHUG1NbVZo?=
 =?utf-8?B?c09YbkRSUjltVlVQYktUc1prM0JCdEhXRlkwRHdWRjRyNXNvOUtqZUlFSFcv?=
 =?utf-8?B?ejYzbS90N2VwTXNNZ2FYZHg5SFp0MEx4S3paT3VhVEhWOC9PSXJVN2JQaDFC?=
 =?utf-8?B?bFM3U2cxRFhXVGsvWmRDZHZMRks1K1NLM0dHRFZKTjVDNnY4SisrNkNYSzlQ?=
 =?utf-8?B?U0U2T2R2bENnZERPQnovdmZSazl4a0FaOUFsYjJIZWxKVTNvbUhDTkZYbVhZ?=
 =?utf-8?B?Qit6N2FVSnVwWWVDVmVXc2VmRHRjbDYwbGhBdDNGaFRwaEFCRDJXZ21QT0xK?=
 =?utf-8?B?YWRhT2trdkp4WDNMeXZTV2xhT09ybzhpR2trOUJ3WDBKaUFZOUlUVFVjYjBo?=
 =?utf-8?B?blJ6bWpYbVU3d0ZZUzZlKys5NmJHcXBxSVVzYUh6elJZUm9tb1l5bSszQkZU?=
 =?utf-8?B?THhKckJybzlVL3MrTHVGNU1DaU9LU1dtNTRXelluVDF3T3NlNXNnVndjYm1O?=
 =?utf-8?Q?VPazP81uI6bFR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejkvWDRqZC85L212d1hZMktNOGh3NFNWeUEvY3h2Ni9OQ0VtSXJxUHhnZmFq?=
 =?utf-8?B?aE80cUF5T0d2N2JwTC9YTlhJZDN3NXZpMDFHM25oM0lyd2I5K0FaeitrMFQw?=
 =?utf-8?B?aUo1WEZVcmhMTVFOTXRQUmF2bEwrUG5GZ3I0NW90TGFoNkwvRldJc1pYamNG?=
 =?utf-8?B?T2JTaFVSN3BiNmFGOWdKRmI4MEtLL2dMQUREUDhPUUhwYUtHWWRtaFc2S01N?=
 =?utf-8?B?a0NoU3dsQUgyZXFlL2xaOHBWTHdHemdWMGY0S2FRSDNoYm5qMHd3VzQzMlBD?=
 =?utf-8?B?YXNNRmI0S1R4bkg4ZzlneHBkRHFUSFdoVmpGQk9mdHFkMERuOS9uL0lyUjhy?=
 =?utf-8?B?YXNPS2lyT2U2MWs1bjVMOGNGa2hTUTBZM3FFMUVvcENVNDgvNDE1eHRTSDAy?=
 =?utf-8?B?QzFtOU5xOWwrZkRlbUo5VGhuS0xZTmFBZjBpWTNHN3FqdXZ4MUpuQVI4aEVQ?=
 =?utf-8?B?QmhOaWFDbStyU2JWaGNZekhXdktUMDRPWlNYa21raUE3ZWtmN1JVRXJTQk9u?=
 =?utf-8?B?aUQxQnk5bW1LdDVzN1RmNDVZQ29FcTg2amlyVEs1ajJwZSt4cGZMbGMwazNN?=
 =?utf-8?B?eDFqUzRqZXRsKzBnbEo1S3hjVjM3V3EwSFV2RjBDcmZrSEFqYVltTEdvVW5m?=
 =?utf-8?B?UmdsNEZNRG9veVNiWXdkbEtBY0IwNHRvQkU2N2NaajFYL0ErWEVBMDBEWTBz?=
 =?utf-8?B?QUpFZ2cwbkZzNlY0L2NHT3czMERzNzBkZXp0Y1BGdzVTSWs1cEwxVUhQdm1o?=
 =?utf-8?B?NDhhSlZTQndUd2hWRGIrdGI5VWV3QmsycVFOTFJQUUZ1MGRFZHN2eVA1dG5p?=
 =?utf-8?B?Q3IxS3QvT0pkS1gvN2pqV2dZVENzWkhxcTRHbncvL3BmSHAwTGlOSmdVRnhH?=
 =?utf-8?B?bTUvM1RKaENzQWMxWTJYUzh5MVFRTnM0N2NIVTVGT3VGTGwwbzlmcG93RStL?=
 =?utf-8?B?TXJaL04razFab0x5ZjVaYzF4aDlBUlM1WEVsUmVmUlN5djBpdjVJYkJ5N0pE?=
 =?utf-8?B?amFQaTRSdmdrdUhZVkVobnFWVTRjMzhYYk5xT2JCQmFmNG5GM1UxbkZ2TWt5?=
 =?utf-8?B?cncrMGh4TmI4NGgramNtQnlYWDhRbmNEUDFUUEJOeE50aUswVUF5R2I5RXlL?=
 =?utf-8?B?SktJNTZCV3ZRY3ljMFd2Y3ljQXRqaEhSSHc5alUyVTJIUktpMXY1dW5xZUk2?=
 =?utf-8?B?MWZtR3lIT0FBRXIrS3R4NjhvSkdGaEM3bjlicjN5NGdSREExR1MxQ0dHdXdU?=
 =?utf-8?B?RlV0cHYwTUsyV1ZRb3RGWlhjMS9SWUxMWjdyQ2JteWIvRWxvd2NxMVYyakFS?=
 =?utf-8?B?RU5meHNWSVlzVVdURUdSb2lGcTB0K05VZENiTm5GLzg1ekNEa3hHaWpBU0Rm?=
 =?utf-8?B?c2cxSExCZDcxdktrZGh1aTVaaGxaSWN4aWN2aUFJNXBaeGFpeG1lbTViVVNX?=
 =?utf-8?B?YkNVazJLanVhRi8rS2ZaYys4VmRncXltZ1hyeXlhWTQ0L3VKa3dMU2E3eWpR?=
 =?utf-8?B?NmVUSnlWTWx5d25qdDkra0ZiS0U2UXh2blgyY3Irbko0OFJQbE5LczlLMTZE?=
 =?utf-8?B?RXRudmtKZGtHL3doRzNDQUM3TzBMZ25Jd3RDS01tZ21OckJYTGo1ZmlVU0Ja?=
 =?utf-8?B?bm1mM0RodFNubGZWeC9id21qWFlvUkpPby9Cbzl1VTFraTU2cUtkUDBrbVAx?=
 =?utf-8?B?LzhqVC9INnNpVXRzTnNKTk93dnZPMWh6azcyaCs4SzR1bTdiUGVNTG1QT3J5?=
 =?utf-8?B?TEZwdUQyeVNZcG1EQ3hUN0pLTGNGUmJaOXVKQldyZmp6SGpDSmRaZ0JZMFpw?=
 =?utf-8?B?QlhhdUJrcGJjTFN0OTNCalp6TWpsRTNWcVNhZFJJOWU0L1pWRmFhUEUwYVRM?=
 =?utf-8?B?VEs0a0NmNFR0R0JnWEM2T01IM0twUGlQR0NrZ2dNT0VVUlRheG44QzU5MXg0?=
 =?utf-8?B?L3dtaEpkYVVzUWE3RnFjTlNBYUFKSVBLVzhLdHdIRUcwb2c0NlJwYk9DYk11?=
 =?utf-8?B?bnlBLzRROGplK21iQ0R3ajZXZXNlMkU4TjVtMzlzVENVVUhXQnRkZWo2NWQ5?=
 =?utf-8?B?K0ZGZVh1cmxuOGpBTG1lZU4xN1BKN2lUbU8zdllwcEJxR3ZTSTJ4MTc5cHdi?=
 =?utf-8?Q?fBqwpTiP2LErh5X5zrk0YkbI1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d2eb7-cda8-49d4-6ffb-08dd203da576
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 14:58:50.0683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcxTiPbEG+6C0U3K2Mmp26GZsuFUW/p9m8NJVzLP4oxCBUuMiVCaApMy6VE16ebn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

Am 19.12.24 um 15:55 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, December 19, 2024 5:07
>> Am 16.12.24 um 18:49 schrieb Yunxiang Li:
>>> Before, every time fdinfo is queried we try to lock all the BOs in the
>>> VM and calculate memory usage from scratch. This works okay if the
>>> fdinfo is rarely read and the VMs don't have a ton of BOs. If either
>>> of these conditions is not true, we get a massive performance hit.
>>>
>>> In this new revision, we track the BOs as they change states. This way
>>> when the fdinfo is queried we only need to take the status lock and
>>> copy out the usage stats with minimal impact to the runtime
>>> performance. With this new approach however, we would no longer be
>>> able to track active buffers.
>>>
>>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> How do we want to merge this? Do we already have the required acks and rbs for
>> the patches who touch documentation and general DRM code?
> Yep, I think all patches have been reviewed.

Please rebase the full set on drm-misc-next and send it to me once more 
(just me, not the mailing list).

I'm going to push it upstream through drm-misc.

Regards,
Christian.

>
> Teddy
>
>> Regards,
>> Christian.
>>
>>> ---
>>> v12: call update_shared in amdgpu_dma_buf_attach
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |   3 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c  |  18 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |   3 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 110 ++++-------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   4 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   4 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 205 +++++++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  23 ++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   1 +
>>>    9 files changed, 232 insertions(+), 139 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index b144404902255..9f627caedc3f6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -36,6 +36,7 @@
>>>    #include "amdgpu_gem.h"
>>>    #include "amdgpu_dma_buf.h"
>>>    #include "amdgpu_xgmi.h"
>>> +#include "amdgpu_vm.h"
>>>    #include <drm/amdgpu_drm.h>
>>>    #include <drm/ttm/ttm_tt.h>
>>>    #include <linux/dma-buf.h>
>>> @@ -60,6 +61,8 @@ static int amdgpu_dma_buf_attach(struct dma_buf
>> *dmabuf,
>>>      if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>>>              attach->peer2peer = false;
>>>
>>> +   amdgpu_vm_bo_update_shared(bo);
>>> +
>>>      return 0;
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> index 7717e3e4f05b5..91d638098889d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>>> @@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>      struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>      struct amdgpu_vm *vm = &fpriv->vm;
>>>
>>> -   struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
>>> +   struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>>      ktime_t usage[AMDGPU_HW_IP_NUM];
>>>      const char *pl_name[] = {
>>>              [TTM_PL_VRAM] = "vram",
>>> @@ -72,15 +72,8 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>              [AMDGPU_PL_DOORBELL] = "doorbell",
>>>      };
>>>      unsigned int hw_ip, i;
>>> -   int ret;
>>> -
>>> -   ret = amdgpu_bo_reserve(vm->root.bo, false);
>>> -   if (ret)
>>> -           return;
>>> -
>>> -   amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
>>> -   amdgpu_bo_unreserve(vm->root.bo);
>>>
>>> +   amdgpu_vm_get_memory(vm, stats);
>>>      amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
>>>
>>>      /*
>>> @@ -97,7 +90,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p,
>>> struct drm_file *file)
>>>
>>>              drm_print_memory_stats(p,
>>>                                     &stats[i].drm,
>>> -                                  DRM_GEM_OBJECT_ACTIVE |
>>>                                     DRM_GEM_OBJECT_RESIDENT |
>>>                                     DRM_GEM_OBJECT_PURGEABLE,
>>>                                     pl_name[i]);
>>> @@ -115,9 +107,11 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct
>> drm_file *file)
>>>      drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
>>>                 stats[TTM_PL_VRAM].evicted/1024UL);
>>>      drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
>>> -              stats[TTM_PL_VRAM].requested/1024UL);
>>> +              (stats[TTM_PL_VRAM].drm.shared +
>>> +               stats[TTM_PL_VRAM].drm.private) / 1024UL);
>>>      drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>>> -              stats[TTM_PL_TT].requested/1024UL);
>>> +              (stats[TTM_PL_TT].drm.shared +
>>> +               stats[TTM_PL_TT].drm.private) / 1024UL);
>>>
>>>      for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>>>              if (!usage[hw_ip])
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index fe7ae45500639..9f1382ff9d813 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -43,6 +43,7 @@
>>>    #include "amdgpu_dma_buf.h"
>>>    #include "amdgpu_hmm.h"
>>>    #include "amdgpu_xgmi.h"
>>> +#include "amdgpu_vm.h"
>>>
>>>    static int
>>>    amdgpu_gem_add_input_fence(struct drm_file *filp, @@ -288,6 +289,7
>>> @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>>>      if (r)
>>>              return r;
>>>
>>> +   amdgpu_vm_bo_update_shared(abo);
>>>      bo_va = amdgpu_vm_bo_find(vm, abo);
>>>      if (!bo_va)
>>>              bo_va = amdgpu_vm_bo_add(adev, vm, abo); @@ -362,6 +364,7
>> @@
>>> static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>>              goto out_unlock;
>>>
>>>      amdgpu_vm_bo_del(adev, bo_va);
>>> +   amdgpu_vm_bo_update_shared(bo);
>>>      if (!amdgpu_vm_ready(vm))
>>>              goto out_unlock;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 951b20e40fd35..96f4b8904e9a6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1258,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object
>> *bo,
>>>              return;
>>>
>>>      abo = ttm_to_amdgpu_bo(bo);
>>> -   amdgpu_vm_bo_invalidate(abo, evict);
>>> +   amdgpu_vm_bo_move(abo, new_mem, evict);
>>>
>>>      amdgpu_bo_kunmap(abo);
>>>
>>> @@ -1271,75 +1271,6 @@ void amdgpu_bo_move_notify(struct
>> ttm_buffer_object *bo,
>>>                           old_mem ? old_mem->mem_type : -1);
>>>    }
>>>
>>> -void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int sz)
>>> -{
>>> -   const unsigned int domain_to_pl[] = {
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_CPU)]      = TTM_PL_SYSTEM,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GTT)]      = TTM_PL_TT,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_VRAM)]     = TTM_PL_VRAM,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GDS)]      =
>> AMDGPU_PL_GDS,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_GWS)]      =
>> AMDGPU_PL_GWS,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_OA)]       = AMDGPU_PL_OA,
>>> -           [ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] =
>> AMDGPU_PL_DOORBELL,
>>> -   };
>>> -   struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>> -   struct ttm_resource *res = bo->tbo.resource;
>>> -   struct drm_gem_object *obj = &bo->tbo.base;
>>> -   uint64_t size = amdgpu_bo_size(bo);
>>> -   unsigned int type;
>>> -
>>> -   if (!res) {
>>> -           /*
>>> -            * If no backing store use one of the preferred domain for basic
>>> -            * stats. We take the MSB since that should give a reasonable
>>> -            * view.
>>> -            */
>>> -           BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
>>> -                        TTM_PL_VRAM < TTM_PL_SYSTEM);
>>> -           type = fls(bo->preferred_domains &
>> AMDGPU_GEM_DOMAIN_MASK);
>>> -           if (!type)
>>> -                   return;
>>> -           type--;
>>> -           if (drm_WARN_ON_ONCE(&adev->ddev,
>>> -                                type >= ARRAY_SIZE(domain_to_pl)))
>>> -                   return;
>>> -           type = domain_to_pl[type];
>>> -   } else {
>>> -           type = res->mem_type;
>>> -   }
>>> -
>>> -   if (drm_WARN_ON_ONCE(&adev->ddev, type >= sz))
>>> -           return;
>>> -
>>> -   /* DRM stats common fields: */
>>> -
>>> -   if (drm_gem_object_is_shared_for_memory_stats(obj))
>>> -           stats[type].drm.shared += size;
>>> -   else
>>> -           stats[type].drm.private += size;
>>> -
>>> -   if (res) {
>>> -           stats[type].drm.resident += size;
>>> -
>>> -           if (!dma_resv_test_signaled(obj->resv,
>> DMA_RESV_USAGE_BOOKKEEP))
>>> -                   stats[type].drm.active += size;
>>> -           else if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>> -                   stats[type].drm.purgeable += size;
>>> -   }
>>> -
>>> -   /* amdgpu specific stats: */
>>> -
>>> -   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>> -           stats[TTM_PL_VRAM].requested += size;
>>> -           if (type != TTM_PL_VRAM)
>>> -                   stats[TTM_PL_VRAM].evicted += size;
>>> -   } else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
>>> -           stats[TTM_PL_TT].requested += size;
>>> -   }
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_bo_release_notify - notification about a BO being released
>>>     * @bo: pointer to a buffer object
>>> @@ -1554,6 +1485,45 @@ u64 amdgpu_bo_gpu_offset_no_check(struct
>> amdgpu_bo *bo)
>>>      return amdgpu_gmc_sign_extend(offset);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_bo_mem_stats_placement - bo placement for memory accounting
>>> + * @bo:    the buffer object we should look at
>>> + *
>>> + * BO can have multiple preferred placements, to avoid double
>>> +counting we want
>>> + * to file it under a single placement for memory stats.
>>> + * Luckily, if we take the highest set bit in preferred_domains the
>>> +result is
>>> + * quite sensible.
>>> + *
>>> + * Returns:
>>> + * Which of the placements should the BO be accounted under.
>>> + */
>>> +uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo) {
>>> +   uint32_t domain = bo->preferred_domains &
>> AMDGPU_GEM_DOMAIN_MASK;
>>> +
>>> +   if (!domain)
>>> +           return TTM_PL_SYSTEM;
>>> +
>>> +   switch (rounddown_pow_of_two(domain)) {
>>> +   case AMDGPU_GEM_DOMAIN_CPU:
>>> +           return TTM_PL_SYSTEM;
>>> +   case AMDGPU_GEM_DOMAIN_GTT:
>>> +           return TTM_PL_TT;
>>> +   case AMDGPU_GEM_DOMAIN_VRAM:
>>> +           return TTM_PL_VRAM;
>>> +   case AMDGPU_GEM_DOMAIN_GDS:
>>> +           return AMDGPU_PL_GDS;
>>> +   case AMDGPU_GEM_DOMAIN_GWS:
>>> +           return AMDGPU_PL_GWS;
>>> +   case AMDGPU_GEM_DOMAIN_OA:
>>> +           return AMDGPU_PL_OA;
>>> +   case AMDGPU_GEM_DOMAIN_DOORBELL:
>>> +           return AMDGPU_PL_DOORBELL;
>>> +   default:
>>> +           return TTM_PL_SYSTEM;
>>> +   }
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_bo_get_preferred_domain - get preferred domain
>>>     * @adev: amdgpu device object
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> index ab3fe7b42da7a..375448627f7bc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>> @@ -305,9 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device
>> *adev, struct dma_resv *resv,
>>>    int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
>>>    u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>>>    u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo); -void
>>> amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size);
>>> +uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
>>>    uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>>>                                          uint32_t domain);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 2852a6064c9ac..461fb8090ae04 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -26,15 +26,15 @@
>>>
>>>    #include <linux/dma-direction.h>
>>>    #include <drm/gpu_scheduler.h>
>>> +#include <drm/ttm/ttm_placement.h>
>>>    #include "amdgpu_vram_mgr.h"
>>> -#include "amdgpu.h"
>>>
>>>    #define AMDGPU_PL_GDS             (TTM_PL_PRIV + 0)
>>>    #define AMDGPU_PL_GWS             (TTM_PL_PRIV + 1)
>>>    #define AMDGPU_PL_OA              (TTM_PL_PRIV + 2)
>>>    #define AMDGPU_PL_PREEMPT (TTM_PL_PRIV + 3)
>>>    #define AMDGPU_PL_DOORBELL        (TTM_PL_PRIV + 4)
>>> -#define __AMDGPU_PL_LAST   (TTM_PL_PRIV + 4)
>>> +#define __AMDGPU_PL_NUM    (TTM_PL_PRIV + 5)
>>>
>>>    #define AMDGPU_GTT_MAX_TRANSFER_SIZE      512
>>>    #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS   2
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 1adca13bfb7f7..bd206ead2e9c0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -36,6 +36,7 @@
>>>    #include <drm/ttm/ttm_tt.h>
>>>    #include <drm/drm_exec.h>
>>>    #include "amdgpu.h"
>>> +#include "amdgpu_vm.h"
>>>    #include "amdgpu_trace.h"
>>>    #include "amdgpu_amdkfd.h"
>>>    #include "amdgpu_gmc.h"
>>> @@ -310,6 +311,111 @@ static void
>> amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>>      spin_unlock(&vm->status_lock);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_update_shared - helper to update shared memory stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + *
>>> + * Takes the vm status_lock and updates the shared memory stat. If
>>> +the basic
>>> + * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need
>>> +to be called
>>> + * as well.
>>> + */
>>> +static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +   struct amdgpu_bo *bo = base->bo;
>>> +   uint64_t size = amdgpu_bo_size(bo);
>>> +   uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>> +   bool shared;
>>> +
>>> +   spin_lock(&vm->status_lock);
>>> +   shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>> +   if (base->shared != shared) {
>>> +           base->shared = shared;
>>> +           if (shared) {
>>> +                   vm->stats[bo_memtype].drm.shared += size;
>>> +                   vm->stats[bo_memtype].drm.private -= size;
>>> +           } else {
>>> +                   vm->stats[bo_memtype].drm.shared -= size;
>>> +                   vm->stats[bo_memtype].drm.private += size;
>>> +           }
>>> +   }
>>> +   spin_unlock(&vm->status_lock);
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_bo_update_shared - callback when bo gets shared/unshared
>>> + * @bo: amdgpu buffer object
>>> + *
>>> + * Update the per VM stats for all the vm if needed from private to
>>> +shared or
>>> + * vice versa.
>>> + */
>>> +void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo) {
>>> +   struct amdgpu_vm_bo_base *base;
>>> +
>>> +   for (base = bo->vm_bo; base; base = base->next)
>>> +           amdgpu_vm_update_shared(base);
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_update_stats_locked - helper to update normal memory
>>> +stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + * @res:  the ttm_resource to use for the purpose of accounting, may or may not
>>> + *        be bo->tbo.resource
>>> + * @sign: if we should add (+1) or subtract (-1) from the stat
>>> + *
>>> + * Caller need to have the vm status_lock held. Useful for when
>>> +multiple update
>>> + * need to happen at the same time.
>>> + */
>>> +static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base
>> *base,
>>> +                       struct ttm_resource *res, int sign) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +   struct amdgpu_bo *bo = base->bo;
>>> +   int64_t size = sign * amdgpu_bo_size(bo);
>>> +   uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>> +
>>> +   /* For drm-total- and drm-shared-, BO are accounted by their preferred
>>> +    * placement, see also amdgpu_bo_mem_stats_placement.
>>> +    */
>>> +   if (base->shared)
>>> +           vm->stats[bo_memtype].drm.shared += size;
>>> +   else
>>> +           vm->stats[bo_memtype].drm.private += size;
>>> +
>>> +   if (res && res->mem_type < __AMDGPU_PL_NUM) {
>>> +           uint32_t res_memtype = res->mem_type;
>>> +
>>> +           vm->stats[res_memtype].drm.resident += size;
>>> +           /* BO only count as purgeable if it is resident,
>>> +            * since otherwise there's nothing to purge.
>>> +            */
>>> +           if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>> +                   vm->stats[res_memtype].drm.purgeable += size;
>>> +           if (!(bo->preferred_domains &
>> amdgpu_mem_type_to_domain(res_memtype)))
>>> +                   vm->stats[bo_memtype].evicted += size;
>>> +   }
>>> +}
>>> +
>>> +/**
>>> + * amdgpu_vm_update_stats - helper to update normal memory stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + * @res:  the ttm_resource to use for the purpose of accounting, may or may not
>>> + *        be bo->tbo.resource
>>> + * @sign: if we should add (+1) or subtract (-1) from the stat
>>> + *
>>> + * Updates the basic memory stat when bo is added/deleted/moved.
>>> + */
>>> +void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>> +                       struct ttm_resource *res, int sign) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +
>>> +   spin_lock(&vm->status_lock);
>>> +   amdgpu_vm_update_stats_locked(base, res, sign);
>>> +   spin_unlock(&vm->status_lock);
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
>>>     *
>>> @@ -333,6 +439,11 @@ void amdgpu_vm_bo_base_init(struct
>> amdgpu_vm_bo_base *base,
>>>      base->next = bo->vm_bo;
>>>      bo->vm_bo = base;
>>>
>>> +   spin_lock(&vm->status_lock);
>>> +   base->shared = drm_gem_object_is_shared_for_memory_stats(&bo-
>>> tbo.base);
>>> +   amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>>> +   spin_unlock(&vm->status_lock);
>>> +
>>>      if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>>              return;
>>>
>>> @@ -1083,53 +1194,11 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>      return r;
>>>    }
>>>
>>> -static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>>> -                               struct amdgpu_mem_stats *stats,
>>> -                               unsigned int size)
>>> -{
>>> -   struct amdgpu_vm *vm = bo_va->base.vm;
>>> -   struct amdgpu_bo *bo = bo_va->base.bo;
>>> -
>>> -   if (!bo)
>>> -           return;
>>> -
>>> -   /*
>>> -    * For now ignore BOs which are currently locked and potentially
>>> -    * changing their location.
>>> -    */
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>> -       !dma_resv_trylock(bo->tbo.base.resv))
>>> -           return;
>>> -
>>> -   amdgpu_bo_get_memory(bo, stats, size);
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>> -           dma_resv_unlock(bo->tbo.base.resv);
>>> -}
>>> -
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size)
>>> +                     struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>>    {
>>> -   struct amdgpu_bo_va *bo_va, *tmp;
>>> -
>>>      spin_lock(&vm->status_lock);
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> -
>>> -   list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
>>> -           amdgpu_vm_bo_get_memory(bo_va, stats, size);
>>> +   memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
>>>      spin_unlock(&vm->status_lock);
>>>    }
>>>
>>> @@ -2076,6 +2145,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device
>> *adev,
>>>                      if (*base != &bo_va->base)
>>>                              continue;
>>>
>>> +                   amdgpu_vm_update_stats(*base, bo->tbo.resource, -1);
>>>                      *base = bo_va->base.next;
>>>                      break;
>>>              }
>>> @@ -2174,6 +2244,32 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo
>> *bo, bool evicted)
>>>      }
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_bo_move - handle BO move
>>> + *
>>> + * @bo: amdgpu buffer object
>>> + * @new_mem: the new placement of the BO move
>>> + * @evicted: is the BO evicted
>>> + *
>>> + * Update the memory stats for the new placement and mark @bo as invalid.
>>> + */
>>> +void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource
>> *new_mem,
>>> +                  bool evicted)
>>> +{
>>> +   struct amdgpu_vm_bo_base *bo_base;
>>> +
>>> +   for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>> +           struct amdgpu_vm *vm = bo_base->vm;
>>> +
>>> +           spin_lock(&vm->status_lock);
>>> +           amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>>> +           amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
>>> +           spin_unlock(&vm->status_lock);
>>> +   }
>>> +
>>> +   amdgpu_vm_bo_invalidate(bo, evicted); }
>>> +
>>>    /**
>>>     * amdgpu_vm_get_block_size - calculate VM page table size as power of two
>>>     *
>>> @@ -2593,6 +2689,16 @@ void amdgpu_vm_release_compute(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>>      vm->is_compute_context = false;
>>>    }
>>>
>>> +static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm) {
>>> +   for (int i = 0; i < __AMDGPU_PL_NUM; ++i) {
>>> +           if (!(drm_memory_stats_is_zero(&vm->stats[i].drm) &&
>>> +                 vm->stats[i].evicted == 0))
>>> +                   return false;
>>> +   }
>>> +   return true;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_vm_fini - tear down a vm instance
>>>     *
>>> @@ -2616,7 +2722,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm)
>>>
>>>      root = amdgpu_bo_ref(vm->root.bo);
>>>      amdgpu_bo_reserve(root, true);
>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>      amdgpu_vm_set_pasid(adev, vm, 0);
>>>      dma_fence_wait(vm->last_unlocked, false);
>>>      dma_fence_put(vm->last_unlocked);
>>> @@ -2665,6 +2770,16 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm)
>>>      }
>>>
>>>      ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
>>> +
>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>> +
>>> +           dev_warn(adev->dev,
>>> +                    "VM memory stats for proc %s(%d) task %s(%d) is non-zero
>> when fini\n",
>>> +                    ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>> +   }
>>> +
>>> +   amdgpu_vm_put_task_info(vm->task_info);
>>>    }
>>>
>>>    /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 6a1b344e15e1b..a3e128e373bc6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -35,6 +35,7 @@
>>>    #include "amdgpu_sync.h"
>>>    #include "amdgpu_ring.h"
>>>    #include "amdgpu_ids.h"
>>> +#include "amdgpu_ttm.h"
>>>
>>>    struct drm_exec;
>>>
>>> @@ -202,9 +203,13 @@ struct amdgpu_vm_bo_base {
>>>      /* protected by bo being reserved */
>>>      struct amdgpu_vm_bo_base        *next;
>>>
>>> -   /* protected by spinlock */
>>> +   /* protected by vm status_lock */
>>>      struct list_head                vm_status;
>>>
>>> +   /* if the bo is counted as shared in mem stats
>>> +    * protected by vm status_lock */
>>> +   bool                            shared;
>>> +
>>>      /* protected by the BO being reserved */
>>>      bool                            moved;
>>>    };
>>> @@ -324,10 +329,7 @@ struct amdgpu_vm_fault_info {
>>>    struct amdgpu_mem_stats {
>>>      struct drm_memory_stats drm;
>>>
>>> -   /* buffers that requested this placement */
>>> -   uint64_t requested;
>>> -   /* buffers that requested this placement
>>> -    * but are currently evicted */
>>> +   /* buffers that requested this placement but are currently evicted
>>> +*/
>>>      uint64_t evicted;
>>>    };
>>>
>>> @@ -345,6 +347,9 @@ struct amdgpu_vm {
>>>      /* Lock to protect vm_bo add/del/move on all lists of vm */
>>>      spinlock_t              status_lock;
>>>
>>> +   /* Memory statistics for this vm, protected by status_lock */
>>> +   struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>> +
>>>      /* Per-VM and PT BOs who needs a validation */
>>>      struct list_head        evicted;
>>>
>>> @@ -525,6 +530,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device
>> *adev,
>>>                      bool clear);
>>>    bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
>>>    void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
>>> +void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>> +                       struct ttm_resource *new_res, int sign); void
>>> +amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo); void
>>> +amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>>> +                  bool evicted);
>>>    uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
>>>    struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
>>>                                     struct amdgpu_bo *bo);
>>> @@ -575,8 +585,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm
>> *vm);
>>>    void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>>>                              struct amdgpu_vm *vm);
>>>    void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>> -                     struct amdgpu_mem_stats *stats,
>>> -                     unsigned int size);
>>> +                     struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
>>>
>>>    int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                     struct amdgpu_bo_vm *vmbo, bool immediate); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index f78a0434a48fa..b0bf216821152 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -537,6 +537,7 @@ static void amdgpu_vm_pt_free(struct
>> amdgpu_vm_bo_base *entry)
>>>      if (!entry->bo)
>>>              return;
>>>
>>> +   amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
>>>      entry->bo->vm_bo = NULL;
>>>      ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>>

