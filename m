Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED1EC369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 17:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AD710E371;
	Thu, 10 Apr 2025 17:26:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="llqp5K42";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB15410E371
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 17:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlTFqYlnu+sud7KG2w9oA5OuKgvs6LIn/fbD00zpgvmcTXmJKByUa7hKS1Q2zJ9jJVsEmwgX8ItC7l4hGk1a9DMWL55h0R0Htx68o9OjlDwXJdRioCcYdKw+RRRw+snhzvIoQx/DixqEV6XcMS/RajTo+p7MEvpCJWADYnEwDkAYPt2scbXeSZJpqSGmH9glZsfLAZRXo+o7Z2OyW/NctP4lZOUeEfOF5q5I/xl9GfA59bGNWzRe/G0Pu8rQze8I+MGL70KJ7MmG13ePD0mGiHfil3lyEOxcVDjXoxu3sqiHD3ZlbuTze8AOTU8YTgn45O0LoV1IFYaDpeNL+VyxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1U1CCJPnhT0cTe77HVP53oNW1LVhxJPOyYBM9CbbF8=;
 b=KxK1i/ZVB32nk5SI/6r5C3UF24Wcap+YIBkkzps9sy0PXP3DBQS6/E4+pPl/gHn9eOshJaJW66oEHt7yTMvDR4AlZ1U2CuhaPFANuLc8/4Ed21/r0e5Oxu5UGQtK2bfIs93+c63iiDv7i0igtQdiYubfJSSqzM80hqWvlScvm2pt6ksVzthjogwj3h8g5pYyO0Cj2uapnyE2Nq5WzGfLx93Jqxq9/iJfEIEO+oSblKkXjVP62vWkqd9SAMuolm230IPLi9RKEDCajKt0LHJ5f0gxM6FdXHJLhUoHX2jXBIgy7NrAGZkjOq1hBdMgDBYkeFy50nX3udU/O1kM+oiIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1U1CCJPnhT0cTe77HVP53oNW1LVhxJPOyYBM9CbbF8=;
 b=llqp5K42kiMuK1/Es8yZJzq4ZWyK8Ti3efxIDbWVPkgYZH9loW0+vDU4LvokIPvkdiXw7LtzKK7+QXqwXtoLH/Gznc14+jOZPTTBamKjnQfLrO9FNNNKPo1brmqXZjb3/+O9q3xkv8TYYMYAG4JERPemehw9wmMutsyV1Lyvsk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 17:26:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 17:26:10 +0000
Message-ID: <b95d5f38-d5eb-4a7c-a261-8ef11b20a29c@amd.com>
Date: Thu, 10 Apr 2025 12:26:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: pmc: Require at least 2.5 seconds
 between HW sleep cycles
To: amd-gfx@lists.freedesktop.org
References: <20250410172411.10075-1-mario.limonciello@amd.com>
 <20250410172411.10075-2-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250410172411.10075-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 83d62461-2dc9-42f5-2fbd-08dd7854c8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDJqbmZDU1lVWC9OOXU4bldocys1NEEwQ2lTdURlVUh2bEZKQnNPL2QyL2Y0?=
 =?utf-8?B?NXBTMDd5bWZmVHQyMnBsZEdLeEcvd3BxQ0NGNTlaNEVpZ3YzOWFSbkVpTGdk?=
 =?utf-8?B?eVZDT3BRbkRTb2FBNEU0ZjFkcXdFRXZnZG9lSzIwQkI5VzRSSFZOWEgvZ0ZJ?=
 =?utf-8?B?aDMvWVJVWGo2dm93UG5kRHE3MGorUUtEK1hibk1mWk1mUVlMQ1JYNkZFTzNv?=
 =?utf-8?B?bnZwRE1TQVpUMnBXL2o4SEliTllwcSs0TmIrYk1UQ3NrVkd4RlVsSmk3M1lM?=
 =?utf-8?B?NU5PaXVRRkt1eUx2MHIzNkVZZ0IzODQ2NGV2dEF0SnJLLzhJTnBKeEhkWERH?=
 =?utf-8?B?VzNSL0k5RnVGTjNwNkV4cTJZRkdXWVptU0dGek1VZWptcDhMdWVkZ2d5eTJG?=
 =?utf-8?B?cEY4SVZwZXZVWnFibzdHdTd6bUtSWENBVDBhZ1RmMU1NUnMyQW9Jak5OYURh?=
 =?utf-8?B?QTloT1VYdXMyOFRadmYrMWd2OEZVaW1UeC9jSkdkZE13bmg3c0Qycm5pbTBB?=
 =?utf-8?B?SzR6dzVkRzc3UnhrRS85MkZWeDBKN2dYVWpsUDErZklKaUdsUko2c0RNY1Y2?=
 =?utf-8?B?UUJ5WUNjNnhBTllpWFB4R3BMcEpweEFsODdkOTV1SXU3V1hxQjdBZmFaTVdz?=
 =?utf-8?B?cVdrRGlENmxnTjVjNmdpNTFYNTVlM0laY2M4QnZ0MG1EYnpwWXZyNmRpczl3?=
 =?utf-8?B?NG8yV25hVnNreGxPdFpGTnpUdmtDTGFGZndROXV0MExQQ2crRHFYb1IyTXpE?=
 =?utf-8?B?eS9SN1dQQ1hWUUJlQkZhb2JxQ2pnQUF4T21OcnNmeGlMNmplaVZtTDNNOHBw?=
 =?utf-8?B?dHMzWHZrTXdJbk8wazcyR1pML29uVU5QaS9NaWE1SlhWTTl2SmZHWVRsRXFM?=
 =?utf-8?B?YllyUmFFeENSVS9EcDVEK1l0bTVVMWpGWmNud1ZEU2NveXFRa2dIYW8vK0N4?=
 =?utf-8?B?eERGb2JUdXVrMGtoODNTSU9IdFNRTGdoOUwrR2pRTHFJNnFoaks3NkxheHR6?=
 =?utf-8?B?WFNHMzRCK01TSVF4cEthWk90Z1NBSS8zN3NDQ3pDUmpzL2tsYnZjM1ZwT1hW?=
 =?utf-8?B?Si9CVmpzU01wVjk5Q1gyWGZ6K1N4clIxMDhNNitJd1IxY05mdU9Vd3FMNFZO?=
 =?utf-8?B?aFBzQVR4WlJ5c1hua2k3cFJuOFJBUjdLUEJWVzZ4aGh3VFBpanFiVXdTNXNE?=
 =?utf-8?B?UjB6d3pRNytocGRLaXZHSzlwY2hxUEFScTlDS09hdklaMTY1dDhnZENGWTVQ?=
 =?utf-8?B?cjgwY0dUeU5mcEx0bDV2WEljYTMzMC9ZZ0xBWGdJY3Jza2xNbW1yV0VKNGRx?=
 =?utf-8?B?MmwxTFNKcXJ2aDdHSUd1bWRNNENCTVRxYzBtQUNmNXNNb2pMaUwzUC9JdzN6?=
 =?utf-8?B?Wi80KzJEVVJxYjJ4b2xpeDlGdVZBcjcrb0x1ZXpLYUJZcy9Ha0c0U2J1TmNl?=
 =?utf-8?B?aDFsbnQ5ZlhQbG5oQU5iT2FDMG45cUoxdjBWZnZkT3NtdmYyMERzTmZQTzBM?=
 =?utf-8?B?MUEvS3p2V1VpaWwxOWV6YVg4ZVd4WTArbnNFYnhSaW9SVXpqaldPdnpWM2Ft?=
 =?utf-8?B?akt6L2dlZytTakxlWXlXMFFkMWE1cDZSZ1lOTDFnSVRITnBiOEE2ekNobG5Y?=
 =?utf-8?B?MzB6UFppWldUbnoydUp0VXRMd3RORVZaM3VHT3FGV2pzdmxNajBjbEtmTmFZ?=
 =?utf-8?B?eWxjenhWSXQvY0RwMG1veXo2VkZWRVVBNEJ0VzkwbjVUcDJWY0RiMDNhRXZF?=
 =?utf-8?B?OXM4VndiTFRCTXlRRU9icXFmWFZGc29mOWxLQkFMWm9RaE81OGVDZFhuTk5E?=
 =?utf-8?B?UHlBYzY4UDFtVzM5N1ZGbmNnZEVuYzRHSVFnMUViQ2tDT1VwQitTYU5nYXRw?=
 =?utf-8?B?TDR3dWZkQ1hrQUdpNHRYemZESGtOTnhoN01ySDcvR0hrNzE4V2pETnQ5Tzh3?=
 =?utf-8?Q?qlXf0FLpF0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG9LTytjanQ1WUpDSUJzcldKaElRaVF1QmpYb3dwdlE5VVo1QllBNm1OQXBR?=
 =?utf-8?B?VXBnR1pLQmN2ZU5odFJPUGFMbHBHQ0VKd2ZyUWlUUTN5b1RJLytEcVYrbzlH?=
 =?utf-8?B?ODVMVTZxWnJBakJyMXdYTit3ZVpJd2s5aFdwaTI3WDY5VTNIdHRkQkhSa1pZ?=
 =?utf-8?B?cDBlb2tadkEzYXUzQVozWnpRSXVRbEJCaG5pekVJR0RNcGlrc0hRd2ttSzI4?=
 =?utf-8?B?VlQvcFFKaEFzbDBiLzF1QUtHV21vY21NWkhEc2IrS3hGOEJ6cE9RR3B5cDRY?=
 =?utf-8?B?SVBUQkZldEU4WEM1VnRtLzVINXlZV014alBXV3JRYmpQeVo3cnBBT2lxU1Rm?=
 =?utf-8?B?RWUzbUJncmpxRDdTZHdSS05TZjZ4czdSWFYrYzVrVXRlUWdtTU9qdzB2VE1T?=
 =?utf-8?B?czNjK3dHRHV2eklNdGl1UUt2d0tvUTdBclQrMlJRc0kybmVLeDR5aFkwR1hj?=
 =?utf-8?B?MitYQUhIUW9DRzhDMnJGcVBuUVlIa2ZSNkVVZWd1cEkzVHFodmhoc3A1amU2?=
 =?utf-8?B?bXI3Y0s2dzB2WTV3TkdCTWF2blB0SmhyaDBxR3VTbm1sM3lLcmticDE2UXpF?=
 =?utf-8?B?Z1prUytyTUQzL0ZoaGlwd2dIWlJQVmNUMDJ6TnUxUWxsVzhpUGtHbm1OWXBS?=
 =?utf-8?B?aDlQdit1ZE56V1lCak14bWhlWnh6Y1ljcG95OG9lTlF2eSt6TmsvR2hpUlB0?=
 =?utf-8?B?VndXcGpPdldxNnFlcSttaFJ5TFVwR0tXaEF5REYyVTUvTlZFb2hvc1dyblBL?=
 =?utf-8?B?OFg2bC9GbG9VT0M4VXRYMEVCZXg2MkpUenNlNnJhYXg3WTdWa1kxeG1GRTRa?=
 =?utf-8?B?WGhvUmdHUXQvd0FQbnBLOGJuaFo4MkxnRGlNRExhV3BkYzNmdlhzMWlhRUdt?=
 =?utf-8?B?QWxFcSsyaGFQRDFwWVJySEVkaFVTRU1tSTZKQmcyc0V2by9BdFo4akE0KzZp?=
 =?utf-8?B?eHQ0bzV0MmM3cUxzRjd0cUZybTI1Y1oxRGFrak5jM0JlM0ZpbnZwSnhjYllq?=
 =?utf-8?B?b0lCZG5KM1dFVE1SbTh3RDZ1R3c4ZVhhUEo1bFJMUE9VeEJxS1VYSzFWaFc0?=
 =?utf-8?B?cWFub2lWNG94RWFKL05YTmU2NmlDK0h0a2U5NDVuVGpvT0luLzY0NVVwWTVF?=
 =?utf-8?B?Ym9XRnplejJzSTdxRnlpOWpJNldnV3cxWk1MRGFTVkxqQTVFaXRXV3dNRFBn?=
 =?utf-8?B?TVBrc2piNlFhNlhhNDlqSHpGUFFGM1BsZ0pkb1k3OWZMQzZQSXRjWk55eFo1?=
 =?utf-8?B?TFFyQ2FIbkxiaG4yL09qMUhGdlZ5aFp6Q1hxM0FtSEh6R2NLRXhnZTVaVDFp?=
 =?utf-8?B?NFRQc1BCZElNM3pvMmRjQ3RKMUF0VjhjaHd6cHN3K21KUDM3Y3JJaWZRSG44?=
 =?utf-8?B?eVVJbUpsalhjWWVwN0FJeldjRGtZeGN2RHVQSHZWeFFSSWQ1M1pZbWQ0dmN4?=
 =?utf-8?B?cUVzZkFLelhVNjgzTU84bTFMT2NOemxFZ0xwQ25PaHRReUlmOTJxb1ZvZmlI?=
 =?utf-8?B?bjZHV0pxVU80cVhNUk9mUkxDWmxuL0JPL0hnYUQ2QmhJV1pUbGVKcSswT2xM?=
 =?utf-8?B?SkhTNnJESkphMHM2VnpYRStnVXNkQTZYLzdzaUpSUUxrbndkSUh0eTNDTG9r?=
 =?utf-8?B?bUxBdkNKMjZaTTkzUEtCOVQ0eUFnNm84R2NKZm4rdjh2TUNuVGtDUzV4OUc2?=
 =?utf-8?B?UFhEN2w0bUlMUlNDaFFlVVZQaXdMRVZGdzhqZGtOV1BjRFJKbGN5L1lsM0xV?=
 =?utf-8?B?VHQ0SmtlMmliS0NJZFVndUlYTlJVQkg5U1hvRnB3OUdDbG1Wb1ZRWVpjYTRC?=
 =?utf-8?B?ZWs1SnFlcE1Cc2YrTU9UeTJxZmk5dS80dHhqWitOb2VUQ28vRzFqQ3hSNXIr?=
 =?utf-8?B?a1BKY2hEWW9aWTBNclgyNlV6elNNR0o2WmtuZVk3aGdPMFppME5NWnFBa2lv?=
 =?utf-8?B?ZEhiLzlkbVpTZlhQRWRJOTcwK294djNGODZTUDF3QkJIOWpWMHc3eWZPL04w?=
 =?utf-8?B?blVEL1NlOGRkbGNxVUgyTFRwaituZ0dQdmFsalA3RERrM2UwbEcwemtFcVFl?=
 =?utf-8?B?dVZRdGcxSjc0amJPUG5LZTlZb2lodWVsZE05dVRyWHVpOHpFR29qVUtIMDI5?=
 =?utf-8?Q?QdCqLrc6HEKKhdbRIVdTNHGd9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d62461-2dc9-42f5-2fbd-08dd7854c8e0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:26:10.1297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J17G066HvR05M9vLZkd/q+PKtQelsvXl8tTebyn01kn+z8XVGW2+U3uMkVQtbZ/ixGDIciDCIsqzp5+L5PUkZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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

On 4/10/2025 12:24 PM, Mario Limonciello wrote:
> When an APU exits HW sleep with no active wake sources the Linux kernel will
> rapidly assert that the APU can enter back into HW sleep. This happens in a
> few ms. Contrasting this to Windows, Windows can take 10s of seconds to
> enter back into the resiliency phase for Modern Standby.
> 
> For some situations this can be problematic because it can cause leakage
> from VDDCR_SOC to VDD_MISC and force VDD_MISC outside of the electrical
> design guide specifications. On some designs this will trip the over
> voltage protection feature (OVP) of the voltage regulator module, but it
> could cause APU damage as well.
> 
> To prevent this risk, add an explicit sleep call so that future attempts
> to enter into HW sleep will have enough time to settle. This will occur
> while the screen is dark and only on cases that the APU should enter HW
> sleep again, so it shouldn't be noticeable to any user.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This patch went to the wrong list; disregard for now.
