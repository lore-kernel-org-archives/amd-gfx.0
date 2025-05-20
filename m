Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D07C54E71
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 23:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919F310E5EE;
	Tue, 20 May 2025 23:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4JYBAUVj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE05E10E5EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 23:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0a0f8J4NgyJX8PUwQvpyO3xoSZYM90p+sjoz8u7rqlttXItogmorXGhyZbN4242lODWgyOzcl0Jo4tQwtUfjAODihrdhcwMaF5Sdd+j7os0zWenWvPOhr1ScdUIW2VvBV/lKzL76OOd12zGeeawGCOgbq3VpBUIUogHG3b4LqdzChw0JKyBfGpIQBF1qGiYtNkGurRrWDvkScHS/V0u4saF35SHRry2sg6Aiggn8ibV8FKm9j41750eoNtitYoJR93XDKH0SHHvVWc1ooskhciKqXEyB7t+5O4r9dDzVn2KMmZsYxGdgagUlhwHLeq5/pTJ5ZtM6hJfU0Sw+QxsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntijeZUCsNAX+9PabVWQcesebi5cvxZatnBtnw7AlRg=;
 b=fizMfKocW+q+9PYu5c5sW6VXYCRX7Q9pG5PMsKkXirusB+FNACRTCBff5oJQ3ISyV+t4Fn+O/nLnMSdwhQW30o4JfulMhJhmKJbEj766cNaZ+sRDWncHBn3rPQfoGAlNOzomXPeIjur5qUbZpc4nhIhG3LywUZ7+HU1HKrnX62uDK00iCAprPUsVSnbm2JVMOeTDYLP+/9OT27722WcJXhzIC9ZEz1LrJI6rQahtON/fgGnLiB6kbDuHHCjgAPOEgkV4lc23FmQcvSmhvuXomq7u7hzJtXykbe4FWGfOhEsmQC5ZUnpmanIDeAunfYRNZ9LAHRIr7ctqi/fTTz8t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntijeZUCsNAX+9PabVWQcesebi5cvxZatnBtnw7AlRg=;
 b=4JYBAUVjxit/HgSx2Hb7m7V5GO0BxcI7vVn7a3n8U/9mbZTeCQmRG/HRI8vezQz8u2cIWqJRti+yTcnGE2ivuTMoG2SkPm+Ck9kyVMl0WNf7iYhZOub44Q6wn0+6GmRqUSCrf3wxaGPkWoIYXAgAwhDOkWSIyb5Rv55ezDIM5ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 23:12:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 23:12:13 +0000
Message-ID: <6779be17-2f5a-48e9-9c19-7ba8fcde07e3@amd.com>
Date: Tue, 20 May 2025 17:12:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: only collect data if debug
 gamut_remap is available
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250513213912.179079-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250513213912.179079-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::32) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: d46d5d71-c23a-4087-e65f-08dd97f3c123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWFObTV4T0g4S3R0V244ZGJPZy9LNUZWWitQcmMvUnFoQWZuU2E1M0ZKU004?=
 =?utf-8?B?cVdTNGlaM1duVmVadnlMNG91L2xtQlYzRTNsZ2QrK0N0d3pmOWdRdDc2dGJI?=
 =?utf-8?B?OXY2eGlSY1N3WjJUeWlIZlEyS3lMVUlTcGtjZEw3YlFPaFJSV0ZEUU8wSFJ2?=
 =?utf-8?B?Y0Q3aUlTQmJ4MU1mTHZwL05JRjZ3c0llY0FZSEJIMmE4aUZyeGdtU1JMN0NB?=
 =?utf-8?B?M0xPQitidFpNaXFUQk0zM2RWaGxmZDJaalJiNVFPSFphelUwMlJnYTZwQ0gr?=
 =?utf-8?B?VW1oS2FyT3lRc2FPOGVyaHVBSEJMNmlFdHE3V0ZGYkpDTUxGRFJqd0MzRlEw?=
 =?utf-8?B?Z0ZoamxhYm1ZWjlkUkgxSFkyeG5OOFR3NUZ2S2grNVJHZ3pNOStrbHc5UG9V?=
 =?utf-8?B?RkUrSkZlc1pkcVJodm5zWHhkUmxNODd3U2wrbWZ6cmFhZk15T0VUUUVXUUh5?=
 =?utf-8?B?dFRMMFpKYWJrRWIvZzVHTjJVUkFvTG9SMDV1TEdKRnJmZXlIV2NseGtmcTZw?=
 =?utf-8?B?WXRTbFpteWRBM1ZDbVJTOExJb3d0bzBZL014MW5sRFNBRW5KaGNFM2hOUnVp?=
 =?utf-8?B?Sm0zL2c1eGFTalRoVWZlS0FSR0N4KzJmZVpVMUFCRWhUT0NGUDNJU25OZ2R4?=
 =?utf-8?B?WE1PMEgzV3AzL2ZxUHFZbGpZU2lkdSszSGZoZkM2WEJhY1JYUDgva1NqVjI1?=
 =?utf-8?B?WitGeENXbEZ6SFQyemtPWHB4L0ZGYlIxbWFNdVB5dWpkdkp1MllNdE5yNEJr?=
 =?utf-8?B?WEFKTTFUaGloTnRkUjBGUEp6ODlXTVlRWUNMdjVoMGNINjc0Ni80Y2tRNmtk?=
 =?utf-8?B?N1RDWnZubXJzYXVMN3IyRXFWelgvWGduNXZXcGN5VWZLTzJWMmxjYlp1RmFU?=
 =?utf-8?B?b3IvdUc0MVE2c3c1RmVsbXd0SElWQ21Eb1FWdzVvQmFFYnRjNkl5REFFTnVC?=
 =?utf-8?B?cnRITTJtY2hhRTJDN2Z2NWxlcGovVnJQQ0V4ZWVpcys0b1BKd0ZvRlkwcU56?=
 =?utf-8?B?am91ZWJ5S0JpNEt4YW5reElpdEdvUE1STXJXNnBBeEdvdFFlV3Z6cnRTUWpJ?=
 =?utf-8?B?YTlyRGNHQmkyVzhuTkZTMmpDakVQNWtIMjFTNjRDdTVreEZZMi9iSzNkalpK?=
 =?utf-8?B?U3RIemV3T2FhM1U3K2QwazViSVIyTFVLZXRKODJ1NG1qNzBsN0tCRm1JaTF2?=
 =?utf-8?B?VnhEVTh3VnluZC9lQ2d5T2ZKaGV1N0F6b3drTzQyeXBOL1VZVW8rakVETHB6?=
 =?utf-8?B?Umlpb0NCNVBHOC9OLzcyRkVuMlhURzllRDRNdWMxRUVYWW1EdVZYL0p1RVJY?=
 =?utf-8?B?RU5aaU9GZEpyRTgzZXEyWlBMcDF1WU5tMjZLZzdIbDJWNFlyR2k0ZzJLMVMr?=
 =?utf-8?B?L2NZVnIwL1ZBOC8yLzBjMnRjUWtmVkFMSUtOY09RY1ZUOXBNK2lteURLRjhx?=
 =?utf-8?B?d1RTYjQ4MW9JeExxNEZvK2orS1l3MjRCdkJpcTF0S3JZTnRkeXljSzEzMGRV?=
 =?utf-8?B?Mit4RTg4V3Zhb1BqeWF4RUQ1Z2hmOHp1NjNoQ3dEcUl0cWdWTDlHNlgzbElk?=
 =?utf-8?B?Vnk5dW44K3hYQTYyZGpqNldaVnpDaG80SXRTcEdPa2FsT1dWenB1cTdzQkl4?=
 =?utf-8?B?R0lvOFQ2TlpnQnY5WnVFSm1VTTZUUWdxMDVkWDd3QVA3amhtWTdQdFcrK2xY?=
 =?utf-8?B?dXllREE3aWxNUjdSL09xMUxhSWt6V0s0SGdCQjQxZ1REcWJDMWZtV2xock5h?=
 =?utf-8?B?anBMZW9wYTVYd0JOUE02a3NFSEVJajVOblpxbU9sUm5nMkxERGlZQXFHd09r?=
 =?utf-8?B?elZPK3JYZC9DV0Z6em03a0x5MjVFSFhMclErY3dwM0d3M0hBdHhGM3l2Qlc1?=
 =?utf-8?B?SkRIWFZWblYwRXVNV1ZmUHAvTDJVdVRKQ0R1N24yaUdGdUtxb0ptTmV3VWpw?=
 =?utf-8?Q?j1Gqood59Pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEtvNmQwMEVJa1ppK0dSejVlNGRXRGxiTFRPT0pPQW1mUGE2WGhOc3VPeXFi?=
 =?utf-8?B?eGJOek45NDlqS3NDei8rcUw0VTRhWkJkU1pQMStRUk1WY0VQSkZLcVB2YlpS?=
 =?utf-8?B?UUJESkw2ang3V2I1Q0pnQkJsTTRaV1BqT25VK054UjhkRzF6Yy9PMC91WWRh?=
 =?utf-8?B?aExzalczb05UVlVwbWJydlJhZGNSKytPUENkelRXNzZhVG1UR1NmWU5Yakl4?=
 =?utf-8?B?c3BpbnVsZ2xCaUgxL3Y3QUJsL2tyaE85SW05c2hrY2ZTSnRQVGpHZG9ET2lx?=
 =?utf-8?B?VEJKa0VPVzJQU2xXdjUvZGdvOGtNUkRrYkxMdXc1bk96aTVEZnYyMzJYa21T?=
 =?utf-8?B?aVNYYzJmcm1zY2NKOThiRU9DMnFMNUlZNGhIYWdYZ1NLNFdETUhjckxqUDFk?=
 =?utf-8?B?VXo3NWk1SnZFSUVwWXlXdHBTMThpVTM4WG9PTUxWNDAydUpvRGJZTVpqSHRK?=
 =?utf-8?B?bmhCZVBFQ3labWpXc0s1a0phMVJrQW1OUkJYRkpyWEFBWXNsTGt5dUVhblNN?=
 =?utf-8?B?ZGpFR2FqQTlrQUN4UHVvT0Y3Q3d1blVKM21Ic2JIRERHdk5CUVk5N1F1OHlG?=
 =?utf-8?B?Tm1XeTdBTmtPbmJtRDg0Wllvd1JHTTRSdCtiaHBZQWNQdVQ3Z3lLQnYxZHFN?=
 =?utf-8?B?TjJDWXFMclZoMjFvN2tOeU5nUjdmb1pMQURaSXNHd1cxd1BxU2k5bEhvODJa?=
 =?utf-8?B?MjhITmU1TGNacmt0NGFYRUloL2xxWStJb1I2WG93WjUwWFNFa3E4VVlUYk9Y?=
 =?utf-8?B?OWp4VzIyUDZJRkJxTy9rWllBYXVSbS8ybEREdzFWejZDdFBuU3ZoNkl4TWVw?=
 =?utf-8?B?VFc4QXlibjNTQ1ZDR0I5VS9LeGxEZVlXcm9wWWplenYrZllKVjVUdGR1dnFI?=
 =?utf-8?B?c21rdXJHaXFvRTExckZRMjM2Y1BEdmovL2tRbFZvYjNjbldmSUlsVCtFTVNu?=
 =?utf-8?B?czBGd092RDZZcy9lenBKcHB1K3VCMkFKZXpSNG9nbmRyTzgzOEJBNGRMUUdm?=
 =?utf-8?B?bUdGTEZlbitGMHk2cE9tZ0dodStzZTJzZlY2MHV6d0hOcE9LVm1YRzM3TDBX?=
 =?utf-8?B?d21XMzZJSm1zUlNVbU11bHhGUi9ZOTZNVHNlMzlJdVF4b2d5cWh1ZzJ3bW9n?=
 =?utf-8?B?Ym1RWGlESjFDVUw1MzRvRXJGK3FsOWNXS29YZ3E4VGtuOC9TRlRTUURPT0FY?=
 =?utf-8?B?Z2pEZ3gzK2xHT2ZmSGZEckhEekthbFNMUmVmaDg0OFNZU0oyUXcvQTllQklE?=
 =?utf-8?B?KzRRbjdMdExKdDRPMDM2M3BUd1MvYUVjRnBxaEQ5RjV1M0VGSklUa3dEN3Nm?=
 =?utf-8?B?dUlVZ2tCK0h3dzM2d1ZyeUc5Z2ZmbnZqQTNFYUdFMkNUQjBkVUxTWUM0QUVY?=
 =?utf-8?B?SjdlUnZNOUlwS2NaNGxFNGN0RmljZUJpRmpCRUpVYVRWem02Nk5wNjYyZUJt?=
 =?utf-8?B?SnF1RDNBb2lZR3E0RnpORXA1VDZpeVdpNVdyMjFkVndlZXJ1YmEyYTZESUpu?=
 =?utf-8?B?eGttR1FPRThqUkwyNlhwUGk3RndDM3Y4L3ZwMVF6VnZ3YUpsQU42RFBlSGpJ?=
 =?utf-8?B?dFp0TEFSK29DMzZyc280cExoL09XdW93MGttcUQ5a1VITGxRMFhaMkttQnZC?=
 =?utf-8?B?dFJmN0ZtaXYwcGlUS3o1clVUTjNIVTZ0Ky9ESU9ZSkNmQmxSTm5GeUk4MDZZ?=
 =?utf-8?B?TzBTc0p2TjhpOEFWbUhGeHlZWWRqUWZwb0dnZEs3WUJ0TXlRUHVaWW9YV1hz?=
 =?utf-8?B?S3Z2UWpDcHdKbDVXN0lWVHc3YjBoaC9tMkQ5SXJHbDBMUkp5U2lJcTlOZWRj?=
 =?utf-8?B?amc3bldWUWFHSmpIcXFZcnJVMzNmU0FlemZIei8zalFqRjFRTDhaRHBtU1hq?=
 =?utf-8?B?SjkvVytlNzA3NU15YXZINTYzN1hWK1dYbXVzdE92TXIxVXNsL0lRZ0FnaEFS?=
 =?utf-8?B?akF6YlVBdncwOVdLT2xsNjJzL25HZGRpUjU2MlVNYVdBT1dWT3RQSkIwRFVM?=
 =?utf-8?B?azgvR2RCMzY5dTNPZ1dTK3N5OXdWSnYzTkRMM3FUa0xlTUxWYlJNdlo3YjNx?=
 =?utf-8?B?YnlHT2NDempXN2lnWlFrWWRrUXloZDI4OVFrbmU4aTQ0UHFHRHY1bVZxcHJD?=
 =?utf-8?Q?+ERP8ajBRW38MX8yrTXxtlcRB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d5d71-c23a-4087-e65f-08dd97f3c123
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 23:12:13.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdVuzQUOvX8vVBy48X2ckcTPxvjQnldSUinPzHUkrtaSve2tebv/VQj50u2RVE0QC70F0k3K8ttAz5CopGhRhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 5/13/25 15:38, Melissa Wen wrote:
> Color gamut_remap state log may be not avaiable for some hw versions, so
> prevent null pointer dereference by checking if there is a function to
> collect data for this hw version.
> 
> v2:
> - initialize is_gamut_remap_available (Alex H)
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 26 +++++++++++++------
>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 24 ++++++++++++-----
>   2 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 858288c3b1ac..c277df12c817 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -76,6 +76,7 @@ void dcn20_log_color_state(struct dc *dc,
>   {
>   	struct dc_context *dc_ctx = dc->ctx;
>   	struct resource_pool *pool = dc->res_pool;
> +	bool is_gamut_remap_available = false;
>   	int i;
>   
>   	DTN_INFO("DPP:  DGAM mode  SHAPER mode  3DLUT mode  3DLUT bit depth"
> @@ -89,15 +90,15 @@ void dcn20_log_color_state(struct dc *dc,
>   		struct dcn_dpp_state s = {0};
>   
>   		dpp->funcs->dpp_read_state(dpp, &s);
> -		dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
> +		if (dpp->funcs->dpp_get_gamut_remap) {
> +			dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
> +			is_gamut_remap_available = true;
> +		}
>   
>   		if (!s.is_enabled)
>   			continue;
>   
> -		DTN_INFO("[%2d]:  %8s  %11s  %10s  %15s  %10s  %9s  %12s  "
> -			 "%010lld %010lld %010lld %010lld "
> -			 "%010lld %010lld %010lld %010lld "
> -			 "%010lld %010lld %010lld %010lld",
> +		DTN_INFO("[%2d]:  %8s  %11s  %10s  %15s  %10s  %9s",
>   			dpp->inst,
>   			(s.dgam_lut_mode == 0) ? "Bypass" :
>   			 ((s.dgam_lut_mode == 1) ? "sRGB" :
> @@ -114,10 +115,17 @@ void dcn20_log_color_state(struct dc *dc,
>   			(s.lut3d_bit_depth <= 0) ? "12-bit" : "10-bit",
>   			(s.lut3d_size == 0) ? "17x17x17" : "9x9x9",
>   			(s.rgam_lut_mode == 1) ? "RAM A" :
> -			 ((s.rgam_lut_mode == 1) ? "RAM B" : "Bypass"),
> +			 ((s.rgam_lut_mode == 1) ? "RAM B" : "Bypass"));
> +
> +		if (is_gamut_remap_available) {
> +			DTN_INFO("  %12s  "
> +				 "%010lld %010lld %010lld %010lld "
> +				 "%010lld %010lld %010lld %010lld "
> +				 "%010lld %010lld %010lld %010lld",
> +
>   			(s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
> -			 ((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
> -								   "SW"),
> +				((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
> +									  "SW"),
>   			s.gamut_remap.temperature_matrix[0].value,
>   			s.gamut_remap.temperature_matrix[1].value,
>   			s.gamut_remap.temperature_matrix[2].value,
> @@ -130,6 +138,8 @@ void dcn20_log_color_state(struct dc *dc,
>   			s.gamut_remap.temperature_matrix[9].value,
>   			s.gamut_remap.temperature_matrix[10].value,
>   			s.gamut_remap.temperature_matrix[11].value);
> +		}
> +
>   		DTN_INFO("\n");
>   	}
>   	DTN_INFO("\n");
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index e89ebfda4873..37a239219dfe 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -74,6 +74,7 @@ void dcn30_log_color_state(struct dc *dc,
>   {
>   	struct dc_context *dc_ctx = dc->ctx;
>   	struct resource_pool *pool = dc->res_pool;
> +	bool is_gamut_remap_available = false;
>   	int i;
>   
>   	DTN_INFO("DPP:  DGAM ROM  DGAM ROM type  DGAM LUT  SHAPER mode"
> @@ -88,16 +89,16 @@ void dcn30_log_color_state(struct dc *dc,
>   		struct dcn_dpp_state s = {0};
>   
>   		dpp->funcs->dpp_read_state(dpp, &s);
> -		dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
> +
> +		if (dpp->funcs->dpp_get_gamut_remap) {
> +			dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
> +			is_gamut_remap_available = true;
> +		}
>   
>   		if (!s.is_enabled)
>   			continue;
>   
> -		DTN_INFO("[%2d]:  %7x  %13s  %8s  %11s  %10s  %15s  %10s  %9s"
> -			 "  %12s  "
> -			 "%010lld %010lld %010lld %010lld "
> -			 "%010lld %010lld %010lld %010lld "
> -			 "%010lld %010lld %010lld %010lld",
> +		DTN_INFO("[%2d]:  %7x  %13s  %8s  %11s  %10s  %15s  %10s  %9s",
>   			dpp->inst,
>   			s.pre_dgam_mode,
>   			(s.pre_dgam_select == 0) ? "sRGB" :
> @@ -121,7 +122,14 @@ void dcn30_log_color_state(struct dc *dc,
>   			(s.lut3d_size == 0) ? "17x17x17" : "9x9x9",
>   			(s.rgam_lut_mode == 0) ? "Bypass" :
>   			 ((s.rgam_lut_mode == 1) ? "RAM A" :
> -						   "RAM B"),
> +						   "RAM B"));
> +
> +		if (is_gamut_remap_available) {
> +			DTN_INFO("  %12s  "
> +				 "%010lld %010lld %010lld %010lld "
> +				 "%010lld %010lld %010lld %010lld "
> +				 "%010lld %010lld %010lld %010lld",
> +
>   			(s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
>   				((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
>   									  "SW"),
> @@ -137,6 +145,8 @@ void dcn30_log_color_state(struct dc *dc,
>   			s.gamut_remap.temperature_matrix[9].value,
>   			s.gamut_remap.temperature_matrix[10].value,
>   			s.gamut_remap.temperature_matrix[11].value);
> +		}
> +
>   		DTN_INFO("\n");
>   	}
>   	DTN_INFO("\n");

