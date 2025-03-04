Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA86C282D3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 07:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74CA10E50C;
	Tue,  4 Mar 2025 07:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h8uYvCTK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9211E10E50C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 07:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M51NmiQQWUgbKjNiAbUPqPnK2NXUegY53QYJLmicu6x2NR8GNOKkqHzr+hA8U1WZVOzJn7h+wGl4n9w8RSQHXdOI+rZECNQ0kc5nA1mmQe00loZUsCqo6W9DUdu2J72pNk++775yUpsdJ4Nj0+KcKJCZ+i58xAr7yswen22rh5nwVwcO+mwG5U/RDBwIb+lC9aFzo0fg0XbOcMv0B+8mh/t0AYT63+aqT3fxtvVLg+AzBY7SY9m0EztRv7pOl0pM8ycsHK7CrDwGlHW/qx/vE2LKLlnyQ5whcCuf0umhJrtmPwXB5w/bz7eoMMvh7rWbSiobs52P0xmWpHVH8docMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRGuMc0whh3mbFxaQJZTRurixgSU2uVVQ+cKUMdoO5w=;
 b=qIWb7kr2j70LUun84dqmL84Ju2eNk23u0vlstlEA6mxeFIKP6atei5cqG9zC/kxWV0dpt9UipbSN3WjCcAZ1COQtuqFriWidPOXFMopSpJa9uK+GzuwytyOraNbV97yLCF2BrBQDpW6czAMrv/V24nCP/reFRlnNsAl2ErUqZagGvE3nwTApxET/evQ3BdfJx9/hHQsFMhzQEfoQYi0vmC3gjVut3BvUAasdHYr/aq9g/xU/UwWyNGGNSwYSEUJt/J2LAmujhthbfH91zajhSGG2tdCyHssvNJysGv0Xkve+m03KRtpO3JsH51+9Ti503FNXUI9g8ysSnDkOglg+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRGuMc0whh3mbFxaQJZTRurixgSU2uVVQ+cKUMdoO5w=;
 b=h8uYvCTKn6vbJx6aVsDi8TvNxDGwEBcnHKV9f5LxGmiWxBb0r+3i+teE7ccmxkVGqOrWJ+vscPigpLSlw2lExgl1qbKCx0qgX33gyoVuHRhZqtEMYtPIBbu9/igS+rWqexdDOpW7GijGE07qhdCHTwZHP7KTd4oUNEfT5dGz88M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 07:40:21 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 07:40:21 +0000
Message-ID: <13836d37-3f09-4278-8599-ee8f3886e255@amd.com>
Date: Tue, 4 Mar 2025 15:40:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: initialize svm lists at where they are defined
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250221092355.336312-1-lingshan.zhu@amd.com>
 <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <c0fd1f01-ed4f-494d-8e9e-ae092a6ef1e1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0140.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: d6128358-8375-4ac5-f6fa-08dd5aefd107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEVHRy93bWEvdUlBSHE2WHo0OGV5d2c5dFY1UStoZHEycFpIYjZZZkZxK1RW?=
 =?utf-8?B?VTJCY2dxVEVWRkFHWUwrVmVFVGxBNjhGcEV6ODBzUjhXeXR5NmgzTXduT014?=
 =?utf-8?B?STcrcis1dGdwVWg5aWNPZnIyZnFjQnhOOGFRTmxTeENKWkljS2plZGdrL1NE?=
 =?utf-8?B?NTNDYTdDYzhiOHRvN0ZsRVdkRnRkbW1QS3lrVytIL0FPNFIvUWFubjduRjJ4?=
 =?utf-8?B?ZEFaNTJXWjdsQ3FqKzJzamljVi90ck52OUpLSWNRNm9YVDZpNWcySGVRMXBh?=
 =?utf-8?B?WW1Jd2dXMllNZFp2Tk0yN3ZoTDBzNHRhR3JhUFo1MFEzWVhxamptV1dEVEdJ?=
 =?utf-8?B?YXI0a0pnWUZtRng1NCtRdFdrZWdyUTAyM0NtT1ZNYmU5S3ViS0c5WlB0NVdn?=
 =?utf-8?B?VWxWTWYvSTlSMGo5QXdPek9TZVdJRkkrM0kxSUptcmdBOWNnM2M4UmhQRUdJ?=
 =?utf-8?B?UWR4S09lelJxQk9iQldXeTdyendKL3JZNWxEQlhIMCtUbTd0amtVZEFVWmtt?=
 =?utf-8?B?WnByamR4Z1E3S3g5Yi91ZXI2d3VuZERyV0kyUGhqNmJsa21HTWxPa3Y3cWYv?=
 =?utf-8?B?YTFJRkQrdCtZalFhdjBkbVd3YkhYRFZTYnZIS3p3Q2djNjVkU1FhVFJZR00x?=
 =?utf-8?B?WHVnRkRHMXMwbzhFSlVlNXc3YlA1ODBFVERpY3FIa0xSUlhLZ0pxcVVwVzBD?=
 =?utf-8?B?RGU3TGNUSUZHTDBYWjcweEp0NzBBUWhiVjNBL05GSzdzc2J3WmpvazNuWDhP?=
 =?utf-8?B?QkZuZm9HcnZIdlF2S2lVb0wvWjN6MEU0NHliVmNUWGQ5ZDhTTkpueWpCTUxN?=
 =?utf-8?B?dnU0OXJYaFJ5UDFzYU8wZU9FdVNsSFV6VnZSV1pLS2xkQjZEdGxrU3o2ZTJM?=
 =?utf-8?B?WUNZMURaTEVzVlQyenYzbkl0LzNqMnFXRjFZY2h2QTFNcXN0QXh0MjdubVBs?=
 =?utf-8?B?WFdUMmxUbVlQamZWM2xMcGtmT0l0dmx0aHdxWlJkWFduLzdDMCtKQTNWeUlJ?=
 =?utf-8?B?LzlMQVk5RTQzWjZ2Mi9QTmZSMUt0aXVxeU9xNVpybU0yV2FGbURPOSt2a2xJ?=
 =?utf-8?B?OVVVOU1SNEZjWk05eTJwUGpja09JWUJBZG9ZQzZjUXk2Q1ZhcVptbXQvdVVN?=
 =?utf-8?B?aDhYUHRNa1Z6eVcxcy8yZExvdHEwVVhFbzFmczRTSDc4V0tlSHRwaWkxeENP?=
 =?utf-8?B?Uy9aZTNLZEVqNVljT0xQemxwRmlnVzJHbG82QzFYd210ZUlUdy9YaUxjZmZj?=
 =?utf-8?B?NWNGR2JBcm50eWd2bkVSeXE3U1FtblpVcVExTCsxdzU4VEpHdGdwWDBpQ2Zv?=
 =?utf-8?B?TkpTSHk3SlBZcVB6bytaUXc1UjY4KzJDeitFVVkrUDVaeDdEVUEvYTZPT0kv?=
 =?utf-8?B?dUxTejZYZDh0NStabWxFZ1gvV0ZvenRreDJyK0gyYUM1MzByWElPYUxsSFJ1?=
 =?utf-8?B?cERwVkFYdHJzU3VaR0dieUFBeTNTRExnZVZRc05xOUdrNGdFYkdoY1N3QnBP?=
 =?utf-8?B?eGY4VlFMWVoxSnBFMmQvVFFUT1gxSnZ6QnhmbG1ZakNRenpKbm9lMUpGS3VJ?=
 =?utf-8?B?MWp6a0ljb1hvbzJYVlM5aGJFZTFheWpBcXhJUEJJakJCQTVmNXhvalcvWE54?=
 =?utf-8?B?RzBZK3Y0MzE5SnMrV3RpZmcwdm5UaFk2VmpVd3JsVWJaV0pHLzJpT3g5Y3lN?=
 =?utf-8?B?UXJaeXRINVl1S3MzRjJSa3plWU1ldmlsbGdhdFdSYVFyUUJDdThxVHhNRXlC?=
 =?utf-8?B?MG5nNzdMakZyVmxIa29KZFBFVVo2bGU4ZjUrU3BnQU9vOUN0ZC9SQTQyK3du?=
 =?utf-8?B?UzQ5YWZob3B3SXBNOEJRU2NJY0JmTnlUQ0U1Wkw0RXNjbWhPRE12eEtSa0VH?=
 =?utf-8?Q?0IYFpDptA31c9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWplOXNXQ3lJTTAvckRZNStRQ3MxVlV5aXlGeG9vc3Y2b3pGb0g4SVZYQmJC?=
 =?utf-8?B?NWZVNUZ4NGhLTWYvVHd4c05xb0hDdmV4aUk0VGo2S0loNHJYWGw0QTYxVVZT?=
 =?utf-8?B?dU54ZWljZ0Fmd1ExR0tueE1qakQ0MmJFWXVJaTNsREJCN3Y2aWFoK3lxNk9q?=
 =?utf-8?B?by9TRXpUa1BmOUVhN0ppZ1F2YkhjNWdmeC9IVXZMOW9EbmxRSmVEYVdTeGF3?=
 =?utf-8?B?U0RxUU9vODlZeVZ2WWk4YkJ0dk0xUUZoaS93OURKaEdnV2YxcEhiUnVEWS8x?=
 =?utf-8?B?MlM1OHAvZ0NENkxOQ3ZhdUtoZ0dkVlR4azdOdUc5RStEcVVVU3pNR0h3Tmds?=
 =?utf-8?B?Q1RMTTg2c3RvaFI4U0xWcjc2YlJORXByRDE5RTlKZFJRZWZmV0tFL2lpY0Z2?=
 =?utf-8?B?b0xkZlZwTzlvdWc5bHp6Y1ZuUnBWbXpJZE5pOTA2b2JQM2ZzU2c4N2xrWGVO?=
 =?utf-8?B?MmFOc3ZYT2hJZlFnYVhlak5tKzVXSDA5ZVlKWnlHR1FIWGFmSEF1SWZRaFQ3?=
 =?utf-8?B?ZjBZYllRSUI0Nm1yRDROTTZJbU5vU1N1L0VKUmd1OXR5VE9aTFB4ZEc1ZFJi?=
 =?utf-8?B?ZFJiVDFoMVU4WEtyNXdsSk8yaFRrSlhyN05MRzRHSjRXVVFMbmFLZ2c4ZW8v?=
 =?utf-8?B?OEtNSlNEMFFaTGxDQkJBQTNFeGVlM1BIUTRKZHNzZUxrUzBOcEdrL2xaSFVK?=
 =?utf-8?B?NWdNbWNGNnh3Smc5eWZ4bHJxTVJ3MUNsUElTQmExY251SEhPeXVvUk1Kc2RQ?=
 =?utf-8?B?bTdMdWgzdzA0M2IwTm1HdmdvNzNXbkFKaHBsMS91OG5IMzlEdkgyTnBVeVlj?=
 =?utf-8?B?YVVURUxBeTJBVkxQRytZakhHdHJiNUVPVVdOM3lBa08rUVBIVGJlWC9qL214?=
 =?utf-8?B?TEw3aUhCZm5tbkJyWGJQQm5JUTlKT3M0QnY0cXBMQ29MZElabWszamlMekhR?=
 =?utf-8?B?U3NWRUZoc1IvWmZqaEhhSjZjcWRRWHdBTUFsMWE4MURMZklrRUxDL2ZtcEFy?=
 =?utf-8?B?WFRaSU1jaHBSQjZKY1JFOWw1eE5IblRvZlptNzhDN3BKbmJKOCtXWHFENkIz?=
 =?utf-8?B?ekp1UWI1ME9VTmFZdlUvTnhLeFZyeW4xWkVHeGF2NUpPQlpZcWgxaEZTTHVR?=
 =?utf-8?B?dk80S2E1SXhuS1NveXVMd1hZaUlSazlObTUxOTcwSFVPU2ZCQ09xbzA0M3Vt?=
 =?utf-8?B?OHQ0bzgzTG1uWnA2dGRmOXV1VXpFUGVqY2dDTkZMVHkzd1JTaGc5L1ZnQjA4?=
 =?utf-8?B?MFc4N2x4ODFLazNtME84UnlmbXRFeXc5YUhqaUJBSkszdVhKL01lbysyeWhH?=
 =?utf-8?B?ZXhIMmNLR2s3cWVTbjQ0YWVIT0U0aEtUTnZNRmNRVit0NENSSzNOTGNuL2Zl?=
 =?utf-8?B?SmRnaXAvZEQycmsvME5jcWlYMlVGVFhMdHl2UFV0RkRCZk8wWXpUcmMzc2Qz?=
 =?utf-8?B?TTVQQ3NlMXhpT2tCaHVObmxOb2JNM1dUaU5TQWxURFJVVUs0S1R6eG03TWty?=
 =?utf-8?B?M0JyakVCSytWZm5kRkJWdGFEdDZTQlZlUUN5WUZKdER3Y0E1bnpwZnBsUTdT?=
 =?utf-8?B?Z1RCYU9WRld4bGJZUkVKQmF3NUhXQzgwVUlXRVNRbkRLT2oyOTdVbGMySllF?=
 =?utf-8?B?QU1YNU5vQ1AwanF0ZEV5YWVKczBQNVl3Z05qSXpTTU5sWFRpcjVqYzlIUDRV?=
 =?utf-8?B?M3g3T0QxVURtTDhtdDU0NTZaS0tlQkdMbllSS3RCY0FnVzlXQ1hTZVFiLzdE?=
 =?utf-8?B?OW55dDMwdUNkbS90RmVCSXpzMmhtTGhhMDByQlhSdTZ5QkJDSEM1R3pqNVoy?=
 =?utf-8?B?a2RmT0RqOXJ0VTdBR0s3Zmc2MlB0SktsUGhUWWpSaE55Rk1ndjlHZmRUV2JJ?=
 =?utf-8?B?NmhZTEtaOEw0OXpQSE91SjlsN3pEYkwvSXh6T1NtNHgrNmdaY3NmVjd2RHRN?=
 =?utf-8?B?dkJzVmdrVzFMN0hka3lZSUFEbFEzYWpiaWVkd2FRUnhMRzRiNzMra1ZuUlRY?=
 =?utf-8?B?bG5wOGE4cnJlem9vd1hLUHFtZjFhaHV4OUc1NGhSYVNuUWZOdzdMUER4QjNw?=
 =?utf-8?B?K3FWd2ZXTjNjOXlZU1ZKRklQcjVxYW5McmtiRjFOM2s1SStqM3RscDA3SkFo?=
 =?utf-8?Q?0xmfCfXm0wbzyRp06JMVCTdd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6128358-8375-4ac5-f6fa-08dd5aefd107
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 07:40:20.9901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+VVOqosw8IkvIue3oK8OVVfTl3OMZReFsM5ulvb4xTkSI7om9Bf5olnzn69AifdA4xa/nMYHiL+FqNFNJR0Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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

On 3/4/2025 1:49 PM, Felix Kuehling wrote:
> On 2025-02-21 4:23, Zhu Lingshan wrote:
>> This commit initialized svm lists at where they are
>> defined. This is defensive programing for security
>> and consistency.
>>
>> Initalizing variables ensures that their states are
>> always valid, avoiding issues caused by
>> uninitialized variables that could lead to
>> unpredictable behaviros.
> The lists are clearly documented as output parameters in the svm_range_add function definition. I think it's more readable to do the list initialization in svm_range_add to keep the logic of the caller more readable. One suggestion inline that would move the initialization to the caller without cluttering the calling function's code.
>
>
>> And we should not assume the callee would always
>> initialize them
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index bd3e20d981e0..cbc997449379 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2130,11 +2130,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>>  
>>  	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>>  
>> -	INIT_LIST_HEAD(update_list);
>> -	INIT_LIST_HEAD(insert_list);
>> -	INIT_LIST_HEAD(remove_list);
>>  	INIT_LIST_HEAD(&new_list);
>> -	INIT_LIST_HEAD(remap_list);
>>  
>>  	node = interval_tree_iter_first(&svms->objects, start, last);
>>  	while (node) {
>> @@ -3635,6 +3631,11 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>  	if (r)
>>  		return r;
>>  
>> +	INIT_LIST_HEAD(&update_list);
>> +	INIT_LIST_HEAD(&insert_list);
>> +	INIT_LIST_HEAD(&remove_list);
>> +	INIT_LIST_HEAD(&remap_list);
>> +
> You could initialize these where they are defined by replacing the struct list_head ... definitions with
>
> 	LIST_HEAD(update_list);
> 	LIST_HEAD(insert_list);
Yes, this is better, I will use LIST_HEAD and remove the initialization in  svm_range_add because we don't need to init them twice

By the way, I am not sure the lists are "output parameters", usually an output parameter should carry some information for other functions,
but here the lists are just defined, even not initialized, and are on the stack. Actually the callee only fills the lists and the caller itself use
the lists. I suggest to remove the "output parameters" in the code comments.

Thanks
Lingshan
> 	...
>
> Regards,
>   Felix
>
>
>>  	svms = &p->svms;
>>  
>>  	mutex_lock(&process_info->lock);

