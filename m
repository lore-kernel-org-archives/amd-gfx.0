Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E57606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCDF+KpQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4A010E0CB;
	Wed, 28 Oct 2026 19:24:23 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F70110E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 19:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wosCAXCL6CTtWLuA349dsXwZ/VaLxX6gB3f58V7jRI9cZbIZHly4NUSd/w8mfM20WZF2gR3FaYP942h8b1Lg9mklPpMfXYS5VGSxAJTD9jwifDbFOpR9xfCPhcS1OYl00Z1mIeAEhLEjGwhcOThnGjyyRnrwIHVrhD1vCSiECjr8iVUOcnEpkm8rxur2mKbvwFU50sOkfcmL43Wj7lPRv3K578U9A+O4zb3QlQR8URzWFdQSgGQrGz14DYuoXtCYeTzVtcs7PKWM5IyBJEksSUTpXjv1mxpdMzrh/9R57jNNrFEV3ZEr5ASg0wUMZm14XzQ6FVuhiT0ZxiwokoU1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0DBoWpnz9o0e7hOGJtgXyhKSIWj/H31w0VKXrrubvQ=;
 b=UrFDx8FzGzDGD0XMJxtC7mQDxbRTBAYQZa+n/tVCBdG+yMcvPgp5QOzRCYgu2A0eeDOqL+CvR62cetX0BW1s6OFBbPsD619JgCSGMyu8QI35hZKNyRUyKMHzRUpuWjLGC4P9iUPtcMkr58dyC2iXVeI/4h3OZKboHmnL6NZfB9FIBmw8Wx0KKGtt+QHmn+N9JcG14L7s18tp+4ULgPlyL5jqS7ldClnO9bAi2CnLzNAqc+vQ+qjY1nzvxySxnJcVijo8OVGDNx2oUeaskgGrAIYQmLNbneTyH7ggSFP0BM1AgfTov98l+/qUJyaDMcY/2G0Git96/4cCfOJzuofP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0DBoWpnz9o0e7hOGJtgXyhKSIWj/H31w0VKXrrubvQ=;
 b=rCDF+KpQFp95JQZiFXoPeN54QZFfN28eyj5AxZGoU0MaHgPPcfElSG/v3J87haIIaIu9eoacqC8/xGUJhyFdFi/pOUoE0utt501peZAcM4BzAVhYLWiiRYXtEN4zgfCgPXQQVg2yRxDj/ib2QPMINeGWwXp1hA58acMZNngYbpw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:24:14 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 19:24:14 +0000
Message-ID: <a6196528-370d-4059-9566-9dcdec150064@amd.com>
Date: Wed, 28 Oct 2026 14:24:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
To: "Indic, Vladimir" <Vladimir.Indic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Six, Lancelot" <Lancelot.Six@amd.com>
References: <20261022204858.4143484-1-jay.cornwall@amd.com>
 <CH1PR12MB9598F7D782297E89C405FB4F9A6F2@CH1PR12MB9598.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <CH1PR12MB9598F7D782297E89C405FB4F9A6F2@CH1PR12MB9598.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:806:a7::21) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 93deffb9-0b98-4668-9a34-08df35290d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261026140227099003|4143699003|261028144727099003|11063799006|56012099006|261026121527099003|261021121427099003|10067099003|261022105027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bMSqGeJ0/ZMWW/FsZUFLoVSksNM0uFBnFpzxUhb0mP0S8ss8jLtLicTI/yVfIY38x8KpMJhwHs83HIrEKb4+ahYtxl6yuf78hWVSCpUCV9SN0yeX1btMR0L6mXuvGPN3DZ/32Z8Q1Q0b4iFu5tFE6Bp9HK3MZHwHjP5KeCfy/Ti7iaIm73haVWh6TnCCjafrs+Yc8fpuSmrnGyra1sZCW3P1jO9tzPKWN14MJ+AiOBgG5GKOqKPtux7L53Ars1CS6bmtZ2GJOFhSXDgopAsBwuCelVss3EELbbwOGbx+aClMd251gnrC7BT0YSwpz/W2fAz6MZvtVnsvHy5GUgd/uapItDTOX41bJed+bY1aO4Z7SC+HQfe8L/7b34MJs0vLQ9wsorDaUwC+S3KwfQWTRsJlgA8TOonZvIKAXrSPHI7buh/YjyvGDhmkC49WMmS+5ADxjVyihdY0QXvNI6XE7En5ediSRSiGUTPSxsEzkYvBe1UPdUAIiBYYkh36e7jM/d5qaGlF+djNnSgRos7gA7c+VTYr2d5HmU5onkdnfn5x7AIg0oXFBV+A3CZp1HBplJqH1y2rG7nSuobEf+VgcoWhBcCZDerAyxxyzON/l5amoE/XjTPxWOaODbPh7cMrOxiT4Mg/fR/ORY12Nwvq/qhU1TNGojunJX+vqx++o4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261026140227099003)(4143699003)(261028144727099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261022105027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEM0MU1SSDNURkMzMWp1N2ZuR3hJZlhqbmFXQjltK1UrNENITnpmb1dMWTB0?=
 =?utf-8?B?WmJhV2J4ZFBXVXVINGhWYUt6dVRnSVQzMFYrQisxRkdLNytGY3RMUGVtY2tW?=
 =?utf-8?B?ZWU4N2tVUGdBaDZNRGNZVzF2U2V4UDlkYTJuL2JVd2djaHZPNWR4KzdSS0ZI?=
 =?utf-8?B?L3NvZGo3Sk1zS0JteWR2ZHVQSS9NbWFYb01pVFYzVjczQmdwcXVGcEg5Mksw?=
 =?utf-8?B?OVBTNlN3YnkyMnRrVHFuTHoyVzY1QklJVHFyMzJRMVZTUFNRdUJkQS9uZGRZ?=
 =?utf-8?B?TDdqK09TRWMzbzdxb1VRODdhWks1RmRaVlY0S0o1UVZndXNTWUx2NE5NRGxn?=
 =?utf-8?B?Mm55bjVqblF6SExJbkdVdHlVTnZ2OFRCcFBnMFh6YzJnUlhBVGVVMzRXekhw?=
 =?utf-8?B?UXNOSmc4NzJFU2VIb01zNDRmbG1GT0hKdnNEeGtRa3lWaC8va2RCUVEzVDdG?=
 =?utf-8?B?UEpsSzVIcG5sVGExdVFOUXBTZlEyd3JiWkVSTzZPM3BlZ1p6Q0dQU0owN0Fm?=
 =?utf-8?B?Tnl1WjNLbEFneDNvUmVjZ0N6dDJ0RzI5bUQ1WTdWY1RrMUNETU9hV0s2OUZm?=
 =?utf-8?B?bDdMY1ptdzRpM1BveXNPOXBQMlpYVnpEUnVVZWFlN096QzE5azIweXZaYlZS?=
 =?utf-8?B?NUdzenl4YlZGaVA4RFNSZkl0WTV1NVJsTHlMRUJCQ2RkSTZzWm1nVEZVdmJt?=
 =?utf-8?B?cFBTeXFYNlBkdUJkdGJ1WElaYm5MNmY1Z3NWRUNTQWxsTzFXK3dyUTkxdlpk?=
 =?utf-8?B?TjhINHM1T3hLdnBncjdvaGlTejJuT3FHY1RDUDN0cVlaTCtwU1NYamRvVWox?=
 =?utf-8?B?Q3NLOTQzT2Z1UEZab3lCNWRCbmR6c09EVE9VcFBtR0ZnMG5sT2g3bzhEU1Yy?=
 =?utf-8?B?NVk2bHZkNk9JN1QwenIvWTlTRmVES2Z5MGw0a2JtRXBOQzIvdzVyTHNWUGM0?=
 =?utf-8?B?VjF3RjB3TUY1aFZLY3pBcElrRlc3a2tSVUdKM2dsWHBKaXBrU3BabkNRTUdK?=
 =?utf-8?B?YXNGQjVmOFRLSDZYK3lsQzNQcVZnQ0tMM1Y1RmtJNmdtUWJ2UnZONWZhWUpn?=
 =?utf-8?B?UExNM3NTU3B1NXlIY0UwbTBzNFcvNVlGV0dhQS9wb3A4TDZnQkxLZklMVFUx?=
 =?utf-8?B?eThxdlBMVTkrTzFsMVdvb01KUzlOWVIwS3pGRlNwTmFLR0V0UFBrckYraFlN?=
 =?utf-8?B?OUJkazJ3SkdicmJKTllZZVoyMnc2cnovRU5teXdMSi9yaEtHRU1SOTArTzhq?=
 =?utf-8?B?UFhpbXk1bXlHb0VId2tKaEwyRHJkeFhLMyt3OE1XRDFHblFWMnNjdElacVYw?=
 =?utf-8?B?eW5Da09aNk9CYXJRZGw3V1VjUG5jckxjVXZOSGN4NjJ2azhGYis0VHpIdUZP?=
 =?utf-8?B?ZXMzazN1UE1LaG5lNC96MUxhd05PRDlrNGRkaXoxTFNFR0N1aE9EN1hOWlRU?=
 =?utf-8?B?elJVcHgxWHZwOFpKdTVIWUgrMjM2ang0KzU2dkhqa05tRE90ZGlURWowRHN0?=
 =?utf-8?B?ZGc5ejdZK1dTd2NYL1JldHdtWTlrdkl4Z0ozcEVvWnVCcytYS1dJNUUxRmFL?=
 =?utf-8?B?LzJtVU1CWlc4M2Q2TmlZNExrT3ZpZlBaSzFHcTlURmV0aTdGQXVRU1dwL0t1?=
 =?utf-8?B?dnVYdFc3eEFDZlVlR0w5aytGRG8ySkNsTHh2V0czUTBSSmc2NjlpZmF5QmlS?=
 =?utf-8?B?UUZIWUdOd2hkSFRZRmxtcGx2S3h1N3BaekkvaWZnT1M3VlZZTnlTdjJzem1l?=
 =?utf-8?B?cUVNOHJDODd0ekMvQXRKaUZNSXpGUFUybGJBN0FSRElyZGRRV2JEUkpDdVNW?=
 =?utf-8?B?anF0ajBPOUUvYUhtSHh1THRaNVZGN2Q0d3MzNCt6TWk5TWhXVGcyYUtxS0J3?=
 =?utf-8?B?YXpRYlByZVk3TVRJVG43NDVRNWdWQ08rV21Ja2dMNCtLVHVjRXZDR05mZks4?=
 =?utf-8?B?b3JTeERqdEpJeVg5eEJVWjNqTHcybTc5SHptbHpSK3Y1UFlXbWw5RnpZbDBV?=
 =?utf-8?B?SnBZeFh4UmUwd3V5YXpZQ3hoSUZmcXpkMVJHajNkZWUva2wxcHhuSXFoMXB4?=
 =?utf-8?B?dUlNcU9jS0VGeFhJb2Z6TUJDQnZldXBXUWhmR2RxdXB0UVB1OTNrbmZXT05E?=
 =?utf-8?B?S0d0SVNHL0FwbTNQVW13OHhjUUYwRExLMkhZb1E0WHdxZmRJOXFGa0I5eEJp?=
 =?utf-8?B?OEVUakJWcmc1bjRQQlFJRVdEUlNpK2lQMVlRUHNJMEdJYW80NGp6QjRyUEcv?=
 =?utf-8?B?aGxCZHFHOWN0Nkd5ckNwYWVSNzZ4YzlaZUtDUTUrV1hicmRwL0hnbERHbU9J?=
 =?utf-8?Q?qVzNnXgz7cvUCq8vPJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93deffb9-0b98-4668-9a34-08df35290d2c
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:24:14.2588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUCE7g2sHqwT9a+3sIZuOiSRrdELcYmLGZpzjbBPL3t3V1VsIQrOS2nVhX574FAPdpy1xk7qoSbrZONm49RMvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:41, Indic, Vladimir wrote:

> One minor nit regarding the, but I believe this will never be hit.
> (kfd->adev->rev_id & 0xF) == 0 is inconsistent with the rest of the driver.
> gfx_v12_1.c — the exact same GC 12.1.0 IP block — uses plain adev->rev_id == 0
> in two places (microcode selection) to distinguish A0 from later steppings, no
> masking. If rev_id can ever have bits set  above the low nibble for this chip,
> the masked check here could disagree with the unmasked check elsewhere about
> what counts as "revision 0." Worth confirming with the author whether the mask
> is intentional (and if so, why gfx_v12_1.c doesn't need it too), otherwise
> align  to == 0 for consistency.

In gfx 12.1 adev->rev_id encodes three different die IDs: XCD, AID, and 
MID. (See the SOC_V1_0_DIE_REV macro in soc_v1_0.c.)

A direct comparison with zero would check that all three revisions are 
zero. I suspect this is unintentional - the code in question is 
concerned with the XCD - but works because all three are zero on the 
ASIC being targeted.
