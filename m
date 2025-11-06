Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA4CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A1710E942;
	Thu,  6 Nov 2025 16:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sB7UpZiD";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1386A10E942
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrhJKH5YRcCjOvgPypC/zSzc099hgDHFqYcjgy1PMTnj09IIZc6C9MwMCvOjG+zx7w1oVSatZ0vIDtfDfj6KgmdVMA3BeRmTRw+LE0d19BaR6ruqRilKYqBclwn7JFh61HF4eOM1mktSxthYMAogtNw+Ui6AtyW55E43Y4TuNUvJcMWUe/RDnIOMrD646DwTbPUwYEbI7kKbCgIndpe/mUOUMPSNZJNeQfGn3g6z7W3K06312jWTeuEOCRkTbY5rAqIN0bgtd9nSQcaGH3tBUIYCnwMcEXb+AGsiv+UL9HA4Jf/vg+BjIt4M8lteGEdGUY8AcoIIwhhuFKkKVofYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPNG4Rz9LQ17Z1VELvuiXJ+JVwtGFs/uYJc2CTOqN+g=;
 b=hz38H1ykNauqf55cMlEMZ0MqgTMbn9af8JdFQC/7UVMFHV+aWBrByPAIH3h1yf2PK5ONewr1B/6IAIIBSfUc4gIDEZPoXv3aoQHhqwMRpQGWh92w/8j9lzZ7aYWoSiRTr6iT6CM0JYLQuwzFK+91pOJrGQ+ZBdP4JlxHiUXJXZ15ivtLEDpzw51HINX/inSDP441c+ebeMuDqdqJYV5p3ldSI1q05TFg2bChCevs63lpegUY/mMF/fbEjEQfVtrgOrEye8bci82Wmlu/zjMkvzJgURAcHS1ddJnJZYIY87N0PcACdM1PSs4xgXDJJbBaLPN3fyuRW9Alry04RVzhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPNG4Rz9LQ17Z1VELvuiXJ+JVwtGFs/uYJc2CTOqN+g=;
 b=sB7UpZiDK6PN8EvhGLPI3x1/3IcDhfVn19hVof+A6+5RFi6Uc+O/YViZjhVPxS2i6dzAhFaE0Cj3TEzpgf1+ovUQhQIpeDpPN+x2AbI7LVERSvw97ox3maW9ZDI3xMTmoWzFCEKNC7U6QJbdr3d+UokyvWdtFq8CjAP7GllGtOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 16:14:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:14:01 +0000
Message-ID: <f932c3a6-05ce-4878-ae58-cd4050d4ef43@amd.com>
Date: Thu, 6 Nov 2025 21:43:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/pm: Enable ppt1 caps for smu_v13_0_12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106153328.3783505-1-asad.kamal@amd.com>
 <20251106153328.3783505-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106153328.3783505-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a9c68b-2e83-4adb-6581-08de1d4f7f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVRiWDBYYmdYT1lPUW5Oc005UHR1OWdKL283ajRlUDUxM05jZ0d2cjlUZzZU?=
 =?utf-8?B?K2h5SkFnWFg1Z2tLVWlXMFRFZjkweVl3V2dGSWQrSCtWNW90bzFtcUhVcWo2?=
 =?utf-8?B?RzVxblJhM0J0bmQ0ZnZhcGxkSU13bHZxQVdER09PQlVDRTdTUHJhdlREOFRo?=
 =?utf-8?B?RWUxcmhQWTlDME91NVlOMTVEY2wrYTRXdS9DeEdYZ0RXV1BJZmlvN3M0UENI?=
 =?utf-8?B?SURObk12a1FnS1doZWM5aXM4U2g4NzVNNEs4Y2ticWR0VE9pL3FIdHlkejdq?=
 =?utf-8?B?WTI3bklodktXTFhNalN2T1l5UHFCTUh2Wk1RbEVqNXBmeGQvRVFYQ2JTd0gy?=
 =?utf-8?B?UWJwWEsydCswUWFVNG10WkNNcWszZ2I0UnE0eklwUEVFWG9Ra2xLZWFkZjdS?=
 =?utf-8?B?aGhMYXlMQlFUVmZna0RSeGU2TktpNHBrNDVFeDNEdUFxeUZPRXdKekRwa05o?=
 =?utf-8?B?MkdxTCthL1MzNXNlbnRTQjRIRWtHKzFuQUR6SzJIeXFLS0JlQU1JQThlL2tY?=
 =?utf-8?B?UlZubWxaRmsrT1J2UlQ5akh2bFpYUXNYN204TnJvSExVNVFHRW5RbDBJbUlt?=
 =?utf-8?B?RHR4WW5YWW1NdDdmcEVsaWNuNFo0b1hscDRKdHVaN0NiM0taSkljOFluV3R2?=
 =?utf-8?B?Vm9nTnZidmZwNC9TNFdTUnhoUm9LbVE0ZGVhYXBkNmYxeUcvTTZpSWZHdWNC?=
 =?utf-8?B?dDBwL3RFcHZoVkY0bE5iUkxhREdJcElkYWNJSDRTRUtiRmYxSmFYQUsyRlIz?=
 =?utf-8?B?TUlJbHlSMFd5ZUxFSFlGbVI4bTZETkRib09Id1NibjZPUjAwdndqeWhZVkVW?=
 =?utf-8?B?V09zb2pPWTEyUVBxVFVrY09sVGhUcldqaXFjRStySVNIOThsaHRCVDVGdngw?=
 =?utf-8?B?ZGU2VEtnV25LdVVIV0xyZytMZGs2cXdzZ3Q5VFV0TVFKS1FQVm4xVXhudDBH?=
 =?utf-8?B?RnVHZm1DREdpbTVLSkpNL0RSTGRWZStkczBtL3prVUJQQVkwNWlaMTlrOTJU?=
 =?utf-8?B?S1FoS1dRM1ZBaDErVG9sN2JkM2ZnNVN0bDVKMjBzaXhXa2pQbGRzUnVUdlBG?=
 =?utf-8?B?aHU5NlJWeTBrLytoUTVNcDBtZm85TkhLTnRiS1dRZ3BGUmdIbHZVQ295N25Y?=
 =?utf-8?B?RjV4L2pIeHlTL0J2cXJ6WVJtKzhPb0NwVzJJT2tBekIya0ZjUDJNMW4vaDY3?=
 =?utf-8?B?RjBxOGdZT1Bxbk1BU3Z1dVpHdHQyK0lmZjZYaTFzSnFQOG9lcDVNT3ZXeWVk?=
 =?utf-8?B?ZXNMWVBDRzhmcmN6di9SV1FEdmpYSE1TUkVjQ1pMcFRaSXdTS2ZTdXhiTnRR?=
 =?utf-8?B?NFhRS2RlRFhBNVVDTzZTaGRlQkZuK011aTZCVWNVOUZnMzlWWlNqQzNNN1Qx?=
 =?utf-8?B?VWZ5cy8zK1R2VTk3clBPM0xoMU1pRk9BTEc5K3lzL0VYSDFCM2VaZ3lPK25S?=
 =?utf-8?B?cjNBTUtZaHpQbW5IcGI2cGxldXhEZHhVU1RjWGV6Y21jRDBieXA5djh2b2FD?=
 =?utf-8?B?elN3Y3RTa3lyTTFneWd4T3oxR1J4eTUva0hmZVNoQ0tKOVlEc3Vsc1pVZmhO?=
 =?utf-8?B?QzZTa2J5am9SWkVnWnN5OEI5WE1OaHh3NUE2elZFVVdSU2VLYWszMjlaRndH?=
 =?utf-8?B?THV5L3lGOUZiNFNnZ3E3TEg5RjJrUW5qYWM1OGhHMGFyVWNGTzZwRk9oYzVz?=
 =?utf-8?B?ZkpEWGx0Wnd4RDFIMWVScEVuMGZXbElPZXBRd24wNG1QRVdNNFRsTTJTb0tr?=
 =?utf-8?B?aHNtUzJKaU9XQUpqalBkYjFOQURRc0Z6a1hPeXBDVXdwUGNmWjNDNDA3WjBD?=
 =?utf-8?B?aU53Z2JmRDNCMXJTZ0lqdUpER25GdS85VW03WW1rYVcvelRlcitKY25ONVAy?=
 =?utf-8?B?WTNHRFdBbE5NcnZHY09Vei9BUGhGeitjVVgrV3lHanhYczJRSGNqUEE1dnVs?=
 =?utf-8?Q?HANAPtFEtYayp/sEuspyeyH267v6SDEU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkpYaThPUEk1T1JGcnIzOWRhOU5Md0VvMmpsWjdEbDlEU2xrWEJBK0RNYUxF?=
 =?utf-8?B?a0UzazE1eFBlZ21qMlVQTXIxcjhYcmVPUlZQaXpJUDlSVjNuK2x4K1dpQy8x?=
 =?utf-8?B?S1k5dmtKRElZVmdLajFPZFBIdlhpcTIvMlM0SFdTdGlzM3Q2TW1LaVVVYnNH?=
 =?utf-8?B?bi9ncitlRW9pQXFRZWRTWllGZTdoeEdCVitZa2tzM05NaVhvOUdYLzNuNzRm?=
 =?utf-8?B?MnFqcFhDbHBxazBrQm1YVWVQemZGc3RKS3lpY3hQUVhyWXRNSUJUZEtUa0tJ?=
 =?utf-8?B?QnRONDQrSGowMmpsN3hKZXpOK2RtV0FaYnVOcEpadEw0bUFQS3lZbnE3bHV5?=
 =?utf-8?B?enhUeW00MmlFa1BKSnhXQXlxeEg4OHZLRUNlcThtRlVvczgvN0NzaUlYZ1VJ?=
 =?utf-8?B?aHp1UzBoc254YkJycEZDR1hYYnRzWERadm9LNTYrTFZKbHdRUjRZQkxXN1li?=
 =?utf-8?B?SHZmOFYrRTBCVHFQRGNkSmg4cWtVZDVRN0xTTVd3ZmlBV0luc2hwRG9IY1VC?=
 =?utf-8?B?WmtRY1dYQ2prTkI5NjFiaTJ6eXRmQzBDV3pXaTN1YVF6d1hLQzlsQ1VNSld3?=
 =?utf-8?B?VmduWE9nZHBrSDJRWVBFaVRaTkZJOFFEdlpTWmN0dTFkbWtvUW9pRyt6VVo0?=
 =?utf-8?B?aWlrMTE1U2RpanJvU21BdkVoT0p1S2VXS3BZb0dXYUVpUWc3NVUxWkxENzZC?=
 =?utf-8?B?T2Z2TGRHK2JQNDBTY2E5clUxSEd6cGlsMXpPRXFEU2g0MXIwNVFxZW1wZG95?=
 =?utf-8?B?OXB1NFdyK0JSMjltSE1uT21DQ0NSQlN3dGloNVRvS3ZuN0VvMXhHMEYrTXJh?=
 =?utf-8?B?RVNBYjFqdDBSbE9BWCtZRGsrdHBWcFhhZmc5OGlZVS9GMEduNXpxTE1xYnZF?=
 =?utf-8?B?STFmWnRTcnh0dG1RM3Y3YnU5bHFGd0Z5cDhmeWpFOEh5TmszeE0yZktmYW10?=
 =?utf-8?B?cUVBcjlBQnZXUU9xVjJNU1RlVXlOTmRXZ1lCTGxWbnM2SkwvT1U4QzlWRzdO?=
 =?utf-8?B?MjFsZjc4T09yaTYvd3pQNWtiOGc2anlmZmpGTHBGQVA2N2tVclpxbmg4cmlk?=
 =?utf-8?B?NmlmWkhod1JWeERxVXVtamN1emZiUHBmcERQYjN4VlIvUksxazdXMmtvUVRx?=
 =?utf-8?B?V1BtdTlBSjZZL3VZbkVySXhEdmRxZVpsRTFOWHFKK3ZBWERKdjFhbUdrK3Iv?=
 =?utf-8?B?NzByMkRjazU2cDBsUmFla3BPamI0cXNlMnJKRit6NDRqWTk5bW9odWdOVjdM?=
 =?utf-8?B?bVMwUVpFVVZGcmtPQjY0M3ZIRlJoMUJhTXgwaDZGRWZOcHIyWWtBVGhSUTho?=
 =?utf-8?B?K1pDTEp3ZUVsaDBqSVBPdm9PQkdodEFPcEpwazJsZjkwRGQ3ZFFQVlVxL3l6?=
 =?utf-8?B?R2hkbDZaUER1YUxjSVQrY0hEM1VtQWxWV0VjMHVtZU1yNDNpdDZqT0ZONnBq?=
 =?utf-8?B?Vkx4aVpWZzlJSnQ1VXh6VVQrQ3VzWThGcEllYk1mbUZ5UkhPYnNCcTROc3NK?=
 =?utf-8?B?Vi9odmZjN3V3d0NHUDdaZFdFMkg0Uk5kRW9FemlzNTBpYXM0TXE4a1Exd3dT?=
 =?utf-8?B?NjZTQ3UxdnhCRlJZN2J5RWtjVjFOK1hudXpUbWNXc3RJbnF6aUwxTk9KaWJH?=
 =?utf-8?B?d2ljbkJXcDZpRXB0dUdmb0xiQVlZZVNHOEJwTUEzYWZjYmxOaHNQdU5KcGRH?=
 =?utf-8?B?RHVxckNSWElRazdIb25TYjVFVW1zTm9XeXdkbXRqK1ZiNTA5YkJtcE4yREE5?=
 =?utf-8?B?N1VaQkxvSmk1ZjUrdDgyZCtJWmloamRDdDA5c2xNc3VKS0RCZGtFQ1NZN1dE?=
 =?utf-8?B?ZVNtWjFTd0dJWWpBOFcvbzM2Z29aUHJUZzh4NGpscGw4VHBwRmw0dDhFYy9C?=
 =?utf-8?B?VUVXVE5vc3MvelQzYUJuVzBVSWNseTBVMC82MzVKa3ovaUlSRnVWcUZJaFFn?=
 =?utf-8?B?Zkdncklya2Q4aUpXZ3dZVExrQ2d6Qll6K0V4bG9uWjltamIxQ2lUdGxqeXdw?=
 =?utf-8?B?ZExjVmZ6ekJlVWxDak1WWld6dTVxTnVzUEVMK2pHMzcrQUp2S0ZPZGNtOVc4?=
 =?utf-8?B?djcyZC9pNEVVK3RNZ21tWVRLQnNvYUN0WDN4aWxpSHRZWDU2QkxXbkR0Qk9B?=
 =?utf-8?Q?/+A8pPt69cvq/J3eXMaZNnfzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a9c68b-2e83-4adb-6581-08de1d4f7f8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:14:01.7867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TX4LoXjJqh6+hJHf3Gop0Zl4TRYn1yfBz+ehUl4nJxphnRRcSJZJsCcdjC2mGqrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104
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



On 11/6/2025 9:03 PM, Asad Kamal wrote:
> Enable ppt1 caps to fetch and configure ppt1 for smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Patches 1, 2, 4 are

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

For 3, power2_average can be kept for now and later be removed separately.

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index f9e04df7e472..44e1cd821eec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -356,6 +356,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
>   	if (fw_ver > 0x04560900)
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>   
> +	if (fw_ver >= 0x04560D00)
> +		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
> +
>   	if (fw_ver >= 0x04560700) {
>   		if (fw_ver >= 0x04560900) {
>   			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));

