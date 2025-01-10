Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E58E7719E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 15:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0124210F101;
	Fri, 10 Jan 2025 15:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HFCVtJvL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B467110E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 15:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnXccKvc+ZrcQKEMPAoQfqDKSSbhqDl47P3L1bOS7DWFnccX6O2KZXf9F8B2soUHSZLxKp/91A/k/hdcKahs/HJVAk7fGWB1NLUPu+eck2WvO4QhKeeYQCkckkFaA3XFVeoOoE5NZvWH35BqMY/U4y6T9uXM5u1EgD6Ogxapf3W0g0NtjaIsg8Ys5VuFe/OS7ftBVz078lFyllpdR0OWOHzDgVtEZcJMAoZ5KRkmEEQ8qTcAY1ll2fUeqK8pywTtHsxEMyrJGjvsHaxZzrrf3Sl0zNlkjOetFgWeC7qp6aACPjuXQbqJ18DUf+dsv5MbGx62RAIz+mATTbcguRkrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gg55OIG1RniEjMhzmt+2QqOuArINMdX3JEqjtJ8V4M=;
 b=dtdmW7PBAc1i3+zn+UX6l7250PTdhCvPPfzsYRX6Wxn4KOgUMgdQGh4sDbalGPPVTcEMqRpKYZDx9Oln8MFUcIylUt4mEmbpvNw0WS4JSGfNbDi7KLn1BbOjSolfLEGsm7lR0kKLgqQZlFQMRfmPSbzgio6Yjct0Udc7SEsAQEZLPGXEwuzU29/i/Ef94ThVChEFP1P+b4lp1wshcftYx3aUQNgzJwEmMmQVwbGvYU0bpZmRdm63neBjxKZMMrSn09hb7MM8exT4HiAHHcxzqYSQzSpwP1ZWefS6rX2x/BN8SV1vE/Ir7uxz1pJn1EVy5O5GsGqbsPc/rVw2YxFS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gg55OIG1RniEjMhzmt+2QqOuArINMdX3JEqjtJ8V4M=;
 b=HFCVtJvLV73njHfaiWIKCXZ5BuzGC1UmfmTdzhkO3065+DJGDhWPjY9p7Vy4n7lgQTjBL5GrTyfE3rsIHBMPZbbr/BdvUnxsbWvcD9foyuvoV/laqpbR+lHvN74EcwpDZOb8OcqhWzkNS6qlWVWS3e4qk/9qxYFgX6tBtrnW+MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 15:17:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 15:17:48 +0000
Message-ID: <2acec921-b01c-7d83-9965-580d2805cdee@amd.com>
Date: Fri, 10 Jan 2025 10:17:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
 svm_range_restore_pages issue
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250103022615.1399054-1-Emily.Deng@amd.com>
 <62496e35-e23c-4d10-a5b1-99978665cebc@amd.com>
 <PH0PR12MB54177A7932BF4D91A8A41FE38F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417D0B508B3DECD240478E48F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <22e5cee7-52f4-ef08-b44b-e4fb96027ea9@amd.com>
 <PH0PR12MB54172D04315DCA27E581B2CD8F122@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com>
 <2015756a-974d-67a2-d875-9b90a1a9b1f3@amd.com>
 <4925dfbe-9a0f-4c73-989f-d2b1d7784161@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <4925dfbe-9a0f-4c73-989f-d2b1d7784161@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9ee47c-af51-4f11-0bfa-08dd3189f0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWFacURRV3JLTmRWRHc0RHJudkZFd0xvYVhWZFVVdG1HNkZQa2FLNGlWTTk5?=
 =?utf-8?B?ZFIvc0ZRaVQ5cDd3Q2ZVb0FQMDBOS3M1cVhLMUZpUG1qRzVuMjlNc0MwdGND?=
 =?utf-8?B?L3pTUzMyZ0VCRzZPYm56Nng3cVZjWU1qVGZRRVNEbDdGcXlnNVN0eU5GYkVk?=
 =?utf-8?B?V0RCQVVLWjlKeXA5WlNyZlROekp4QkFleXV6aFVTbXBKMVZLNm1aYnZ6VlR3?=
 =?utf-8?B?dnZ3dUVXVXRCVEgzcWlhczQ5Ri8rdEdiVDZPbmhkUW1PUnk4YnBCUTU3N0Zt?=
 =?utf-8?B?TlRBbHo4aCtkc3hnVGg1dG9VbVBXNmhLL25Sb0dYd3ZZRndHNmZ0R1ZOcU1i?=
 =?utf-8?B?RGJuUXp2OHZrR05LQTZpbTVJUVQyTnZqbHVITmRJaGYzQ3F6d2ZqN0lQc04x?=
 =?utf-8?B?aXE1ZFdwSElQdGVkcCtMOERMSjc5aGtHcVh0MzFoT1NhZVpWVHlEV1ZlTi9E?=
 =?utf-8?B?bkljYU5vdkRFVnB2UjZrblBsbjZZbnIrQ2Nka0ZYcFhrNkNBMkZ0RmtPbDlz?=
 =?utf-8?B?ODRHaG1XWHg3dVJ0VFhrMkljckVhRkRLNHQwdC94cHMxRVhEQTBSb21hdUY2?=
 =?utf-8?B?RGIxaWoyelpGdDdlcGZDYXRDOTltUmtZc2JHb3VBN3JlWWxqVHB1S1kvYm5i?=
 =?utf-8?B?T2FDdGJIcHIxZ25wVU9KamZsZVhwYkdueTYrSVVjMStabEhpZUVKTHdBTHRW?=
 =?utf-8?B?VnJ4K2R1bEJhNkxEdU5rcEVkZlZUeTFOVTZjek85UG5GME5pVVU4UGthYk02?=
 =?utf-8?B?aUpzSjNpZktuQXN1Z3pJbEQvSXhYSnp3dWNNUXhjSE5vZW1OTTRZdUxyVHd0?=
 =?utf-8?B?ZTg4QXhXcFNJNFFpeGxoNERQTmNtOW1EWTkvcnBZc3R4ZWk2aEZ6TmFVM2Iy?=
 =?utf-8?B?VndBUnNOU2d0cFVIaGhCSms5ZHBZZ2hEQVpXNXUwSnlYK0xSR013L1Fpbjc5?=
 =?utf-8?B?bXllTGJJc0RRV2VtY3V1QTQ4Nk9NWHZDdzhpekJYb3hNMVNWV2VJRWlaU0RY?=
 =?utf-8?B?QmZtRGVQR3VEUmRxVVNpWXJFYlkrY2NFZkdYazV3QTJ3ZHFtUGJRTFh0Vll3?=
 =?utf-8?B?SjQwYndydnpZTzZWV3c4d2licHM5ZFVkTGp2SjBVRVpZSWpRMGZOVW16RnRV?=
 =?utf-8?B?dlpBL2FNbkdzZWh4cEJ3TCtONXBvY1ZsanBYaHpsRllQVnNtRzFPelBtNjVx?=
 =?utf-8?B?c1libGJvYXZCdnIrdUp3bDdrdnQwWkhidGJVTnF5QlExdjc3Smh1Vm8yOFFr?=
 =?utf-8?B?MmduTDVKM3RnTkJxbHpObWxFc09JalJRcU9wWkN1OVZIMmRJdTVWSUJlNGZy?=
 =?utf-8?B?WEZyWDFsSjVBRHJ3cVJnNUlTY2UyeEZSRFN4d3F5U25GYytxcEFraEZoci91?=
 =?utf-8?B?SEpFci9oRTB1OVlCZmU5bHJaV3VPTzRWZHM0Y0xpUHZCeHNEOFUzRFBjRVJB?=
 =?utf-8?B?N1RSSktLcE8xcmRKN2JPVzdoQ2hxazliVHhvb3cvN1B0cWdJSUlYRHRWRC9X?=
 =?utf-8?B?dWxrVFZqTzNBN2JrVFhmUXBMZGhtY096Mk9rYWZuTCtlUS9hazlucHd1WjBM?=
 =?utf-8?B?ZC91b1M2eXBTZmVPUGFHZFJ6Y3RJRG0vT0s5N3hoaytsN2lmNjNnZjJNWGNB?=
 =?utf-8?B?UWF6dGtsSDNjUzlFT0NBOSs5WGFHS1IwaDMwMnFGTHZFV1M3c2k0S1ZZbXdz?=
 =?utf-8?B?Nzk1b0JNbFpiTTdjYTRoQlBLNzJ4dTVWTG5UMVo0SENqY0JSeis5WGF0R1Aw?=
 =?utf-8?B?MUF5dVp5NHQ5dUFMUkI1cE45eXNWQVVnekFHZVRRMWg5RGVMYzVEVjYvYjJ1?=
 =?utf-8?B?VVZSZmJSZUxISjJYK29SejJvRDZ3dEhMajNsWFE2S1RpMHV4TEtJMzMxek80?=
 =?utf-8?Q?gstB0oog/NVVz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFMyY09kWi8vemhRbWpVbzdlVUlIRFVWdmV6RTZacEJ4ZytIMDdXYmdYVDd2?=
 =?utf-8?B?NTJEZGp6MmFUbXhXMDJtSk1Fb0gzVm5mdHBzaU5OTTRLRG1TNzNkc0k3S2lh?=
 =?utf-8?B?TktZTjdFbGxaMFpaRTFVZjN6OEJMTWJkOVVSTGhNL003WHM1dDRrbVh1cS9r?=
 =?utf-8?B?OEtKa0cwRWg4czArQkw3eHU2N3hRUWRCNm9NamZyUVNmMktiQTZZUFE5WTlB?=
 =?utf-8?B?bERWb3RDOW1sSEJSOFcvWFQ4RE1QdWlac0FKSXBSYStNVWZZUFBtOXdjajNJ?=
 =?utf-8?B?WFRhYXo2c2hybnM3SnFibVhWRUNUVTBoaWU5UE9wU3hRTENldU1ucHp3R0ln?=
 =?utf-8?B?RzBwZ3I0K1JTY1dFREh3TGt5eTQvZlVzVFU3SkYySU15b05QdHRsRnpEREw5?=
 =?utf-8?B?cDhTTms2aUpRdVhRTFkrdERhKzhHUUJlQ3EzOFExcExmcjJQREJlYXpLVFc0?=
 =?utf-8?B?dG9QQU5wSTVtZTFNOHZTNXBzVVdQZEI0YWlJUTBjR0xqcnVTVEhnQ1NrRzAz?=
 =?utf-8?B?QWg1MHBvb3BsNkp0STZkNlFVeXZlaVN6VCtsUVA2RWQ4WkJMelF5bGtmVk84?=
 =?utf-8?B?aE5vbzNuSUpBdzFoNjVEY0lKeXV1RHh3T1g5MHR2UHo2c1dkUkxsQkY2Mjg5?=
 =?utf-8?B?RnR4eFEyMHY0L3g4VFBSRFpXMHlYMWNyQ0NJODkrT2t6S1h3UzhIQm9YMVZF?=
 =?utf-8?B?NkNNQ3IzTWQ3OHdQd0t5K3BQQlVEb1FzdVdDTmVGcDBOZXdkemhjdUh3UWFE?=
 =?utf-8?B?S3BPSnJkUVgzWnFaYSttZkJGNzRDVHU3dU9WSVp4RVZvaWpZK3BkbXBOcUlj?=
 =?utf-8?B?R3hIODNycmlxc3U3ajgrcWc3YlNaRnpMQ2YwTnEyaXRYRStBMXZROXFUS2pn?=
 =?utf-8?B?RHdNcXZFbGZGeTF3MlVOTkt6YTdHZjhPS0UzWXBISldQZmhLZHdaZG56QzBs?=
 =?utf-8?B?VHphT2cwRTVTeHZRVndEZUNReFNQZmgzYnlXSTRmcVZ6dThyalBHNUM5RzN5?=
 =?utf-8?B?T3FCUnRORTRhd2Znak1IcWg0Y1hXNGdHUHZrWmRmUkdncVhBdS9jbU5sbHp6?=
 =?utf-8?B?ZCtEem0rOVBKWlhuc3V5dXBwQjBxL0Mrcmg1ZWViSVB3Q2orTWVwaWNoNkc1?=
 =?utf-8?B?cnB5OFQxS3ZSQjcvc0lCNGhVZTlOeHlsaVQrMHVBY29wTUUyTzl4ZWNhdkRQ?=
 =?utf-8?B?MEFFV3lMSkVkaGdsWnFReURmTzlxaW5mcmtEUnVvVUdMUm9XdEdTR0FGZHR1?=
 =?utf-8?B?eXZ0Q0VwcUJTNTdibmhCejJNMi9KdFI1NThYZ094UHNOcFR2VGI3bE8veTZy?=
 =?utf-8?B?UUV1S2lkcjhjdHJ2bWhEMm1taDd5RTR6bG15YVh5Zzd6OEIrVDNCTTBnN3pw?=
 =?utf-8?B?YXIyWFRYdXJubkxJTGNlVmhGcm5nU0x2UlJWMnhjRnJzaURLcFdCQ25Wb0hm?=
 =?utf-8?B?R1EydlVkOUgvQTdGR1BrUzg4dG5Hc3cxM3RSeHJ6TGNVeCs2bkY5YVZ2RG5Y?=
 =?utf-8?B?VjU3bjlSUWFqUS9GK24xSUZ4QjFXcW9naGFmWnBPTlVQTHF3SmpNWmIzTERW?=
 =?utf-8?B?L2JBcExVc1U4Y3VPRWgvTXB2NDZZYWlLUnNUWkVIR1hqc3pCc1hIOUFQYVhT?=
 =?utf-8?B?T1I1cU9kTXdYNEc1ZzdSZitkSmVtMm4yS3o2ZGJCb0VjcHlYT1Y1aWtzZ0pB?=
 =?utf-8?B?ZEUrTUdNSVJGZllrc3ZnVXlNcFdvM0tOQTVGQk9LR2huQ21DL3doNDEzTmVl?=
 =?utf-8?B?RVk2R2NEQ2QwVWxqUmpjUXR4dEJQd1hSb1BINzB5eVJmMjBscnBqOWx1czJG?=
 =?utf-8?B?bGRuc1FNalg1d3VlektRRkVTRnAxU3lvV2lVMmNHQnB5dXpOVUp5eVBpS0kv?=
 =?utf-8?B?dW1Udkxkc3hDMCtuNXE4N0wrNTNMLzVPdzZrQ2M3VUVqcm1KVmQxa1pEa0JQ?=
 =?utf-8?B?ZktFV054M2d6VjFkYU1MbVZyZ3Foa1dEWjlvMHFoOVZ5ZmNHbnE3emN6bEFx?=
 =?utf-8?B?Qzhqei9ZQ3ZwOHRFaTF5WExkUnk3NU5pL2JPZkVpMnM3VUw3ZFZRN1c0MGVX?=
 =?utf-8?B?NUp5MXNnOWZleTdhakN4d0tmUXl4cUE3RzhmZlhUekp4R3pTWE1DbFlUMC91?=
 =?utf-8?Q?KstGi6CZ8A8iQurVl9xA88rjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9ee47c-af51-4f11-0bfa-08dd3189f0b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:17:47.7076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwtSu0EWJicVKVuhJpTnFSzgsLxdaUBCchroTVs0zpH2hvYwuP84kGnaqLZSCSv4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-09 12:14, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4925dfbe-9a0f-4c73-989f-d2b1d7784161@amd.com">
      <br>
      On 2025-01-08 20:11, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2025-01-07 22:08, Deng, Emily wrote:
        <br>
        <blockquote type="cite">
          <br>
          [AMD Official Use Only - AMD Internal Distribution Only]
          <br>
          <br>
          <br>
          Hi Philip,
          <br>
          <br>
          It still has the deadlock, maybe the best way is trying to
          remove the delayed free pt work.
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] INFO: task
          kfdtest:5827 blocked for more than 122 seconds.
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000290&gt;] Tainted:
          G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE K&nbsp;&nbsp; 5.10.134-17.2.al8.x86_64 #1
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000243&gt;] &quot;echo 0 &gt;
          /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
          message.
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000317&gt;]
          task:kfdtest&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 5827 ppid:&nbsp; 5756
          flags:0x00004080
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] Call Trace:
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000006&gt;]
          __schedule+0x1ba/0x490
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
          usleep_range+0x90/0x90
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          schedule+0x46/0xb0
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]
          schedule_timeout+0x12a/0x140
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]&nbsp; ?
          __prepare_to_swait+0x4f/0x70
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          __wait_for_common+0xb1/0x160
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000004&gt;]
          flush_workqueue+0x12f/0x410
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000126&gt;]
          svm_range_map_to_gpu+0x1b8/0x730 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000078&gt;]
          svm_range_validate_and_map+0x978/0xd30 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000065&gt;]
          svm_range_set_attr+0x55f/0xb20 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000060&gt;]
          kfd_ioctl+0x208/0x540 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000058&gt;]&nbsp; ?
          kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000004&gt;]&nbsp; ?
          vm_mmap_pgoff+0xf2/0x120
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          __x64_sys_ioctl+0x88/0xc0
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]
          do_syscall_64+0x2e/0x50
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          entry_SYSCALL_64_after_hwframe+0x62/0xc7
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000008&gt;] RIP:
          0033:0x7f8c472617db
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;] RSP:
          002b:00007ffd2908a688 EFLAGS: 00000246 ORIG_RAX:
          0000000000000010
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] RAX:
          ffffffffffffffda RBX: 00007ffd2908a6fc RCX: 00007f8c472617db
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] RDX:
          00007ffd2908a6c0 RSI: 00000000c0384b20 RDI: 0000000000000003
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] RBP:
          00007ffd2908a6c0 R08: 0000000000000000 R09: 0000000000000000
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;] R10:
          00007f70f467f000 R11: 0000000000000246 R12: 00000000c0384b20
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000000&gt;] R13:
          0000000000000003 R14: 0000000000200000 R15: 00007ffd2908a770
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;] INFO: task
          kworker/u129:7:5942 blocked for more than 122 seconds.
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.001897&gt;] Tainted:
          G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE K&nbsp;&nbsp; 5.10.134-17.2.al8.x86_64 #1
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000247&gt;] &quot;echo 0 &gt;
          /proc/sys/kernel/hung_task_timeout_secs&quot; disables this
          message.
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000315&gt;]
          task:kworker/u129:7&nbsp; state:D stack:&nbsp;&nbsp;&nbsp; 0 pid: 5942 ppid:&nbsp;&nbsp;&nbsp;&nbsp; 2
          flags:0x00004080
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000067&gt;] Workqueue:
          amdgpu_recycle amdgpu_vm_pt_free_work [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;] Call Trace:
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]
          __schedule+0x1ba/0x490
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
          newidle_balance+0x16a/0x3b0
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]
          schedule+0x46/0xb0
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          schedule_preempt_disabled+0xa/0x10
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]
          __ww_mutex_lock.constprop.0+0x390/0x6e0
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000045&gt;]
          amdgpu_vm_pt_free_work+0x97/0x160 [amdgpu]
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000003&gt;]
          process_one_work+0x1ad/0x380
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]
          worker_thread+0x49/0x310
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]&nbsp; ?
          process_one_work+0x380/0x380
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000001&gt;]
          kthread+0x118/0x140
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]&nbsp; ?
          __kthread_bind_mask+0x60/0x60
          <br>
          <br>
          [Wed Jan&nbsp; 8 10:35:44 2025 &lt;&nbsp;&nbsp;&nbsp; 0.000002&gt;]
          ret_from_fork+0x1f/0x30
          <br>
          <br>
        </blockquote>
        Move flush_workqueue to the beginning of
        svm_range_validate_and_map should fix the deadlock, deadlock is
        because it is after svm_range_reserve_bos. Also there is no
        concurrent unmap mmu notifier callback to free pt bo as mmap
        read lock is taken outside svm_range_validate_and_map.
        <br>
        <br>
      </blockquote>
      I don't think the mmap_read_lock protects you from concurrent MMU
      notifiers. I believe we have made that assumption in the past and
      it proved to be incorrect.
      <br>
      <br>
    </blockquote>
    <p>Thanks for the reminding, yes, if we cannot prevent concurrent
      MMU notifier, there is race condition, flush work can not fix the
      issue completely.</p>
    <p>We are testing another approach , unmap only clear page table
      leaves.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:4925dfbe-9a0f-4c73-989f-d2b1d7784161@amd.com">Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Ideally it is enough to flush work
        amdgpu_vm_pt_free_work (not flush queue system_wq), but
        svm_range_validate_and_map cannot get the correct vm to flush.
        <br>
        <br>
        adev-&gt;wq is shared by all processes and all xcp partitions,
        maybe better to add wq to KFD process info, but right now
        amdgpu_vm_update_range cannot access KFD process info.
        <br>
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <br>
        <blockquote type="cite">Emily Deng
          <br>
          <br>
          Best Wishes
          <br>
          <br>
          *From:*amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
          *On Behalf Of *Deng, Emily
          <br>
          *Sent:* Wednesday, January 8, 2025 8:34 AM
          <br>
          *To:* Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Kuehling,
          Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>;
          <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Koenig, Christian
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
          <br>
          *Subject:* RE: [PATCH v2] drm/amdgpu: Fix the looply call
          svm_range_restore_pages issue
          <br>
          <br>
          [AMD Official Use Only - AMD Internal Distribution Only]
          <br>
          <br>
          [AMD Official Use Only - AMD Internal Distribution Only]
          <br>
          <br>
          *From:*Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
          <br>
          *Sent:* Tuesday, January 7, 2025 11:19 PM
          <br>
          *To:* Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>; Kuehling, Felix
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>;
          Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Koenig, Christian
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
          <br>
          *Subject:* Re: [PATCH v2] drm/amdgpu: Fix the looply call
          svm_range_restore_pages issue
          <br>
          <br>
          On 2025-01-07 07:30, Deng, Emily wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; [AMD Official Use Only - AMD Internal Distribution Only]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Hi Felix,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; You are right, it is easily to hit deadlock, don't
          know why LOCKDEP doesn't catch this. Need to find another
          solution.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Hi Philip,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Do you have a solution for this delay free pt?
          <br>
          <br>
          Thanks for debugging this case, I had a patch to not free PTB
          bo when unmapping from GPU, but it will waste VRAM memory. My
          test case also passed with the tlb flush fence fix, I don't
          see the no-retry fault generated any more.
          <br>
          <br>
          The deadlock is probably from svm_range_unmap_from_gpu -&gt;
          flush_workqueue(adev-&gt;wq), this is from mmu notifier
          callback, actually we only need flush pt_free_work before
          mapping to gpu, please remove the flush_workqueue in unmap
          from gpu. If deadlock still happens, please post the
          backtrace.
          <br>
          <br>
          [Emily]Yes, you are right, will try to remove flush_workqueue
          in unmap from gpu to have a try. Will send a v3.
          <br>
          <br>
          I think you don't need add new adev-&gt;wq, use default
          system_wq and flush_work.
          <br>
          <br>
          [Emily]No, it doesn’t allow to flush a system_wq in driver, it
          will trigger a kernel warning, as lots of other work will be
          put in system_wq. I have tried this.
          <br>
          <br>
          Regards,
          <br>
          <br>
          Philip
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Emily Deng
          <br>
          <br>
          &nbsp;&nbsp;&nbsp; Best Wishes
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----Original Message-----
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From: Deng, Emily<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;mailto:Emily.Deng@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent: Tuesday, January 7, 2025 10:34 AM
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: Deng, Emily<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;mailto:Emily.Deng@amd.com&gt;</a>; Kuehling, Felix
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;mailto:Felix.Kuehling@amd.com&gt;</a>;amd-gfx@lists.freedesktop.org;
          Yang, Philip
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;mailto:Philip.Yang@amd.com&gt;</a>; Koenig,
          Christian<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;mailto:Christian.Koenig@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply
          call svm_range_restore_pages
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; issue
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMD Official Use Only - AMD Internal Distribution
          Only]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ping....
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; How about this? Currently it is easily to reproduce
          the issue on our environment. We
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need this change to fix it.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Emily Deng
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Best Wishes
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----Original Message-----
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From:
          amd-gfx<a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;mailto:amd-gfx-bounces@lists.freedesktop.org&gt;</a>&nbsp; On
          Behalf Of
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Deng, Emily
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent: Monday, January 6, 2025 9:52 AM
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: Kuehling, Felix<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;mailto:Felix.Kuehling@amd.com&gt;</a>;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Yang,
          Philip<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;mailto:Philip.Yang@amd.com&gt;</a>;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Koenig, Christian<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;mailto:Christian.Koenig@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply
          call
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_restore_pages issue
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMD Official Use Only - AMD Internal Distribution
          Only]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [AMD Official Use Only - AMD Internal Distribution
          Only]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----Original Message-----
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From: Kuehling,
          Felix<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;mailto:Felix.Kuehling@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent: Saturday, January 4, 2025 7:18 AM
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: Deng, Emily<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;mailto:Emily.Deng@amd.com&gt;</a>;amd-gfx@lists.freedesktop.org;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yang, Philip<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;mailto:Philip.Yang@amd.com&gt;</a>; Koenig, Christian
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;mailto:Christian.Koenig@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subject: Re: [PATCH v2] drm/amdgpu: Fix the
          looply call
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_restore_pages issue
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 2025-01-02 21:26, Emily Deng wrote:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As the delayed free pt, the wanted freed
          bo has been reused which
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; will cause unexpected page fault, and then
          call svm_range_restore_pages.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Detail as below:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.It wants to free the pt in follow code,
          but it is not freed
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; immediately and used
          “schedule_work(&amp;vm-&gt;pt_free_work);”.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.276838] Call Trace:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.276841]&nbsp; dump_stack+0x63/0xa0
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.276887]&nbsp;
          amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.276932]&nbsp;
          amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.276990]&nbsp;
          svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277046]&nbsp;
          svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277050]&nbsp; ?
          __alloc_pages_nodemask+0x19f/0x3e0
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277051]&nbsp;
          mn_itree_invalidate+0x72/0xc0
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277052]&nbsp;
          __mmu_notifier_invalidate_range_start+0x48/0x60
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277054]&nbsp;
          migrate_vma_collect+0xf6/0x100
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277055]&nbsp;
          migrate_vma_setup+0xcf/0x120
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [&nbsp;&nbsp; 92.277109]&nbsp;
          svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.Call
          svm_range_map_to_gpu-&gt;amdgpu_vm_update_range to update the
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page table, at this time it will use the
          same entry bo which is the
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; want free bo in step1.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3.Then it executes the pt_free_work to
          free the bo. At this time,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the GPU access memory will cause page
          fault as pt bo has been freed.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And then it will call
          svm_range_restore_pages again.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; How to fix?
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Add a workqueue, and flush the workqueue
          each time before updating page
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I think this is kind of a known issue in the
          GPUVM code. Philip was
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; looking at it before.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Just flushing a workqueue may seem like a
          simple and elegant solution,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but I'm afraid it introduces lock dependency
          issues. By flushing the
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workqueue, you're effectively creating a lock
          dependency of the MMU
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; notifier on any locks held inside the worker
          function. You now get a
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; circular lock dependency with any of those
          locks and memory reclaim. I
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; think LOCKDEP would be able to catch that if
          you compile your kernel
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with that
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature enabled.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The proper solution is to prevent delayed
          freeing of page tables if
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; they happened to get reused, or prevent reuse
          of page tables if they
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; are flagged for
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delayed freeing.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Felix
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks, already enabled LOCKDEP while compiling
          the kernel. The delay
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; work seems for other reasons, I am not sure
          whether it could be deleted completely.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Emily Deng
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Best Wishes
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Emily
          Deng<a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>&nbsp;
          <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;mailto:Emily.Deng@amd.com&gt;</a>
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 7 +++++--
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
          drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 +++++-
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
          drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 +++
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 5 files changed, 15 insertions(+), 3
          deletions(-)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 93c352b08969..cbf68ad1c8d0 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -1188,6 +1188,7 @@ struct amdgpu_device
          {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          enforce_isolation_mutex;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_init_level *init_lvl;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; struct workqueue_struct *wq;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; };
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; static inline uint32_t
          amdgpu_ip_version(const struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device *adev, diff --git
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index f30548f4c3b3..5b4835bc81b3 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -2069,6 +2069,7 @@ int
          amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ret = reserve_bo_and_vm(mem, avm,
          &amp;ctx);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 9d6ffe38b48a..500d97cd9114 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -2607,7 +2607,7 @@ void
          amdgpu_vm_fini(struct amdgpu_device
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adev,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev,
          vm);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          flush_work(&amp;vm-&gt;pt_free_work);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;
          cancel_work_sync(&amp;vm-&gt;pt_free_work);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; root =
          amdgpu_bo_ref(vm-&gt;root.bo);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          amdgpu_vm_put_task_info(vm-&gt;task_info);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -2708,6 +2708,8 @@ void
          amdgpu_vm_manager_init(struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adev)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; #endif
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          xa_init_flags(&amp;adev-&gt;vm_manager.pasids,
          XA_FLAGS_LOCK_IRQ);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; adev-&gt;wq =
          alloc_workqueue(&quot;amdgpu_recycle&quot;,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          WQ_MEM_RECLAIM | WQ_HIGHPRI |
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WQ_UNBOUND, 16);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /**
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -2721,7 +2723,8 @@ void
          amdgpu_vm_manager_fini(struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adev)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; {
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          WARN_ON(!xa_empty(&amp;adev-&gt;vm_manager.pasids));
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          xa_destroy(&amp;adev-&gt;vm_manager.pasids);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; destroy_workqueue(adev-&gt;wq);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vmid_mgr_fini(adev);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index f78a0434a48f..1204406215ee 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -554,15 +554,19 @@ void
          amdgpu_vm_pt_free_work(struct work_struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *work)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; vm = container_of(work, struct
          amdgpu_vm, pt_free_work);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s\n&quot;, __func__);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
          spin_unlock(&amp;vm-&gt;status_lock);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 1\n&quot;, __func__);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini
          ensure vm-&gt;root.bo is valid. */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo,
          true);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 2\n&quot;, __func__);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry,
          next, &amp;pt_freed, vm_status)
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; printk(&quot;Emily:%s 3\n&quot;, __func__);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -589,7 +593,7 @@ void
          amdgpu_vm_pt_free_list(struct amdgpu_device
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adev,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          spin_lock(&amp;vm-&gt;status_lock);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          list_splice_init(&amp;params-&gt;tlb_flush_waitlist,
          &amp;vm-&gt;pt_freed);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          spin_unlock(&amp;vm-&gt;status_lock);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          schedule_work(&amp;vm-&gt;pt_free_work);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_work(adev-&gt;wq,
          &amp;vm-&gt;pt_free_work);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git
          a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 3e2911895c74..55edf96d5a95 100644
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -1314,6 +1314,7 @@
          svm_range_unmap_from_gpu(struct amdgpu_device
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *adev, struct amdgpu_vm *vm,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; uint64_t init_pte_value = 0;
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start,
          last);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev,
          vm, false, true, true,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, NULL,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last,
          init_pte_value, 0, 0, NULL,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, @@ -1422,6
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +1423,8
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ svm_range_map_to_gpu(struct
          kfd_process_device *pdd, struct
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *prange,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * different memory
          partition based on fpfn/lpfn, we should use
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * same
          vm_manager.vram_base_offset regardless memory partition.
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(adev-&gt;wq);
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
          true,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          NULL, last_start, prange-&gt;start + i,
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          pte_flags,
          <br>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
