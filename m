Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFA0E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 03:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5480A10E4BD;
	Fri, 10 Jan 2025 03:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpCdGKx6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2010E4BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 03:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EshDkdxK268UPAR/rhKINY8CI/fh1Ny/dWFtcte4ftEUWw4Cg6TElHcE+x9ooqEcVdvYQgPqNKceUcJOQWrSpN+xSmQw7dg/q1bwxw8qFXcySNykKAr7rIqd2vtAuOZbeU9xU3Qxn6l/dzlywemRjrWrRr8qQgYRzMzv6em051Yzmoe30w/zt/4jI7VPVDrIstr1VayY/dq2CDAcYoXGPeZOdCPs63PBiZmqnPjgsFZVmkypgbDvKECzcJtcWBkC315ohh7zbkzMTMbSDBP5EN75XtEP1GrUCBhkFXqKGqU/0yP8E+upCY0q8AOb2pu2EvKOC0UC4jm+hLycATFmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiIuQlx//98L8M5ED/Qi0+wRlkEMB4GBDiy6WjKowk8=;
 b=WoyFkGVj7dpFo7lWD5H069LyPsgT4ccuy94devDiL/V0eO9/6WUL5XkxuAWJklRhRffTIo2Z16HUcG/NFLevNlEpYS3Np01GBi4aAdHTFmTdRgTUlaMP+Ukqd9WiutOx+sHm91mTaqz9yMnqQ3/97/kcwd9PPCIzAElxgXByNx1vj9jskdeGyhlfj8poxv762PwIXPi022KwcD1MUpm7hzooz+KBRMD1n54abKoR9oSKKWAWYCQyCD+SGZs+H/+4Uk4ZxM/45QoFVjhKryWVp9HCPs2q/j8zHzPgnNqNBn6DFckArhi6R8pVDWXbk1yTJ35WI7uzoHVKETGQSZeymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiIuQlx//98L8M5ED/Qi0+wRlkEMB4GBDiy6WjKowk8=;
 b=XpCdGKx6HZNvE9jBWsqtpwsOid+zgs0qbn7hxEMhxpZcFM7ZSf/mh/c+Qxwf+deg2oCIaFQGW3TKbVzemt3IJn63+YyvzoXLPAHiz+7DdLiCMX6hAvYsnbgG5FuiIyUapWql1wAUmxoye9/WNjXCw6BQSehP+2aaTpqpuMBSg6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.13; Fri, 10 Jan 2025 03:30:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 03:30:57 +0000
Message-ID: <7bf342e7-72ad-4ed0-a45d-ad933db28753@amd.com>
Date: Fri, 10 Jan 2025 09:00:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, kenneth.feng@amd.com
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
 <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c091c36-8abf-49d1-17c4-08dd312731ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckxkb0diTXd4YUhKNGlTWC9WTDlJSVhtbGVGcDNJeEorWndKejJ6cUJoWkFI?=
 =?utf-8?B?V1BKOGZFeXJFNHRWbkEyS0I4VzJpK3c1ZjVua0dYbGVOQ3V1WkJ1bGdqbWI1?=
 =?utf-8?B?TjlEWjZURG1NaUIzT2Y1YnJzd1NVWkdRWnpNZ0d0M3J0SzFVOFp4WGQwT0dJ?=
 =?utf-8?B?UW1oSWhIWlFqbC9IaGtUZjEyS29zWWFsV2lsYW1uN05mRmlGTEFpQ0Q4REcx?=
 =?utf-8?B?aEJ0NnlCTHBxWUxmNjZRbDRSWUk4Vkt2aC94K215S1dFUnNvUko0VmtvSkgx?=
 =?utf-8?B?YzJLczE2UWdqUjF1ZE9IQlZUSExHczByMlQvVytBT1c4WDNFVDF2QVdhWGhm?=
 =?utf-8?B?bFRTaGhZSGJQRE1GWkRBaWh2aGNFYU96eXg2alhzWXVtZmV0dTdqbktlaDBU?=
 =?utf-8?B?bjNndFBscC9XMVBwb3Bmakl1WDJsNUFUeDd5N3VkeElKZGJUaGxJSXlLTDh5?=
 =?utf-8?B?ZkVUa0ZrNTVXUjBYTkYyTFZoZzAwUjhTcnRLdGJvOUttc0QwdUxaV2p0WUxp?=
 =?utf-8?B?SW9Ycm1rd0hUU1pVclhNWDdsVElGQVEvRDc5LzRHYzBwcDhWbXNSRXhleXFE?=
 =?utf-8?B?Z2Y4aU51UVdBYXdycHNDaDUrM0dkN2ZIc08xN21UblROYWVQeGhPUGlYWDFP?=
 =?utf-8?B?UXZuNjNtcDFrUkxTeXp0UEl4eDRzZExabUpRN0o3OWl1clpKdGdFMHByN0ZL?=
 =?utf-8?B?eHFqQ2VGT2Z2VWNqNnNRMS9LOWlES2cwbTJzMkNwYVJoTzlRKzJ5SU84ZFh4?=
 =?utf-8?B?Zm1xT0lwdGg4cXcrYjFFOEkvei9zQUowdC94N0Nuek40Q3lEZ2dtMk4rc2RE?=
 =?utf-8?B?ZDdRT2tjU2x4U0pmN0QvOURMekFzOGNlUnRUeTJVYllQNEtoN2lVRkw3VjU3?=
 =?utf-8?B?ekE2YlBhc0lwZ1FDUUJGS0pNUVd2YkZVaURRTFB0WnJ6aHRPNnozbFV1QzIz?=
 =?utf-8?B?OUlEcnJWRm5VQ1h6VkRyYXZ6SFVHVzIxUFFTV2FJellYZDV4TkZybVVvYjNU?=
 =?utf-8?B?Tk1UeHJ2M1BLWS9OSmpiMWF3RzBqQkk2L2lIWnlpWG9PZlNWbjVIazNoUms0?=
 =?utf-8?B?V3BzR2p5Tk9iU2dMdTN3YlMyaSt6YVdvNm5JMkVqUFhNY1BTS3FSTnFON2ls?=
 =?utf-8?B?Rm1DN3AxaUlKNHN0dGNIdFBGNE9JaExIcWwyKzRPZWtUTFBEdGkxa3JYRHJB?=
 =?utf-8?B?SmRCUm1wcmlQK1dPU0hyaENaUkhYN3BHekhUTmEyQXpIT3Y2QUtVM0x1K1Q3?=
 =?utf-8?B?SXFOQi9iYnh2cVZHQTlUNlJVcVcrMFdNSXJSVUFVc09PZlIwYUN0R3grU3gw?=
 =?utf-8?B?KytVVTRhaW5kTUVHMkRZZlpLdithOS9uTUIwSTRubG5CSGFwNGJ1VURKVmtN?=
 =?utf-8?B?K0FGcElXQkFlcEs3SEh3aThWN0xHUlh5YzlyMVVURUVzaGFVUFhXcktSWEVp?=
 =?utf-8?B?Qk05MVhhODcrU0pZNGQwckxGcE9ud0xwNVBVMjBydUVZQ0d6dzNZL2dKeDVN?=
 =?utf-8?B?YS95QmQzaWxGOThuTUViNksrK3ArL2ZQcXBEZWs3T3VqdktrOVIvb3prc0ky?=
 =?utf-8?B?QytEMnIyZTVZY3B1Slc0T1BUZVU0THQ4aHA1ZmwyZ1BDQ0E5TDFCbEZZcHBs?=
 =?utf-8?B?VDFBZkFaaEF4WFROekVwYXo5SGVZWnJpRGl0aXE5WmhCTXI3ZmcxeU9ESkp5?=
 =?utf-8?B?Uk55dGhSdzRnTDlHUW9INnh2d2FVUGNRTXVXUDc2Q2V5WVlBTml1R3M5Rm5Y?=
 =?utf-8?B?YUxhUGl6djY4d0QweHY4WGt3NGtJYXJhSW0vTEUxeVhsd2d2YXZ5a01pZVVk?=
 =?utf-8?B?dkZkU3piVW9zVks2a25uWlUyc2hOd0x6L0pUNnk1a1RodXZQYWVzeXo2Wk1S?=
 =?utf-8?Q?abEsk8/yuFMhr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmtWc2pIYlpHZDVwWmNyVERBNWJ6MjJoaEh6MjFuc2JxZ1IwcUlLcU1uTEZl?=
 =?utf-8?B?cFRhaCsyaGxTLzR6aHVWSU9COWEzMUozQkhvR3N5M05DTi8wclBkRWlOSUV4?=
 =?utf-8?B?OXlPQ2E5OG5TYXlwdWRXcE4zclFXMVd6cHR5b3dsNDJPVW5sTlE1UUFyQ1RU?=
 =?utf-8?B?SlhMWkJQSEtxSUhnZ3pyUWZTWkRlK2dmeVVxVHFGN2NXdnBzVmJkNUpXVU5M?=
 =?utf-8?B?TkhzMGQrVStocGtiaDRlSjBGZFlMeXNWSnpSRVNMOFNVbVlHS2VLNGZsWnVp?=
 =?utf-8?B?a2NmS2FicVBHM0FMNmduZHMxemp2WldIZm9LY0I1NDlYbUp4WklqYS9ENk5Q?=
 =?utf-8?B?QlNwYTRENE85ZGwxM2FQSUhFRWliNkRQVG92QktJS2duTVRXSlFmWDJ6WEJN?=
 =?utf-8?B?NCtFeVdYYzZZbEM4dVBPVlB0TlJWSHhEQzlaRXd6UEU0dStNbTFZQml0Rmp1?=
 =?utf-8?B?SzJHVndWSHJaTElOUnhnSUdXZjNmMHdTNHN2V2ZONHNraXk3OWtlS01ackFL?=
 =?utf-8?B?STZtZ1lpV2JUM3E0TmhxNXJ4MjM1TXFRbDFkOTR6SGpKMHZNUVYzZXAvdDBD?=
 =?utf-8?B?dURkVEhUMVp1UitWN1ZTQkZTMDVKWVUvS2xFYmVZdmxOaUVwaXR6VTlCcmxR?=
 =?utf-8?B?cU1WMHdEbXFoYTlsLzhDSHBSVVExS3p3dnZDRlNNb3lNV2g0NEdQMlhNZUFj?=
 =?utf-8?B?MU1LUytkVWg5azV5Q2loYUx3ckovVzJPaWJiYjhyMi9lMHFrYlhvTjZCc1BM?=
 =?utf-8?B?dHBvZXlwK0VWQmpmMENpVTVPbW1KT09aTm5tU3NGSWIrak93RmFzZ3BVbG9h?=
 =?utf-8?B?RVZBM0VBNmVrM2FCa0VmMlNlL2IyQnBPc09kNGIvQkZ5eGdSU0x3VnJkVHRJ?=
 =?utf-8?B?Q2F5L2JJM1VuZkVVRmNWWWlHczE3NXFHRVBKZnRNRlZYVko4T0QwNXZaYlZO?=
 =?utf-8?B?cmU4Qy9taFFHZlRINnlibFdhTDY4OWEwUG9mR20zSFhrY1lSZGJGTXB6Nnpw?=
 =?utf-8?B?RVNqS21wR0Zxa20vYnVNMVp4ZkllRjc0M3RuQm42blc3L2o0TjZOSXJZNk4x?=
 =?utf-8?B?QnI5RFBJdFloRm5xWGVkRWpYQ055NDRGKytKTnNOVDV2cStJc0NGZXZYMXFv?=
 =?utf-8?B?emlPU1ZaZ2ZnTHcwM2EwbHdZU3Jjd09mNkhJTnFMak5PNElIVHl1OG55YUEy?=
 =?utf-8?B?aVYxM3JjV1JydDRMa3pmdE5PSGtMT210WHpDZFpYN3FSbVZpcVg2VVBWRE1I?=
 =?utf-8?B?UmF2OWlVc21BNkMwWUlVQ045VS9aUHJlVmFyS2g5aFAvcEY1VnFlZXZWblQr?=
 =?utf-8?B?UFA3blNNM3BpS3hibTRRZzgyVmw3SVpaWlpwN3dZZXYrZTA0MTdya1l3SXpk?=
 =?utf-8?B?SjVZYmFqMW05Snl3aHVhYWhwVHNlY3NWeFhRbzN3N3h6NHlvcmJJWU0xczNC?=
 =?utf-8?B?TmV0RXIvT0JpRTUvdDNHOVNsYTlDMWdtaWlXbjgzZkU2VnlIWGNKNm80QnI4?=
 =?utf-8?B?YldhdlNpbjg2MjdTTWxacUJKeFE4VVlZdnFEaXhEM2hoQ3ZHamxhMW9OWHZB?=
 =?utf-8?B?OXd6ekNHOENPcnlLaFZMSU5hS3VqNlVZNDErRVdjWUdkYzg5WnIvQWFOZTVY?=
 =?utf-8?B?azlvS2MrQXluOGM1NmR4THB4RnoxTlJNb1NkU2psQ3RIaVN0S3cvaU5RdTA1?=
 =?utf-8?B?c0ovQjdyb251dld1UFAvMVNacFVTTnp4T1djVkFYVGNpUDcwamlxWDFSVUZq?=
 =?utf-8?B?UW9PYlkwbXhqaFk1Q3h3RVBCQ2VvTzRzVmozS1E4SkNzUlI5WSs0VUJQb25i?=
 =?utf-8?B?RmZzYktJbWwreU9haEFZMXgxZi92aDdIdWdlZUJFRWYyQ3VUcXJVeHRvdHRI?=
 =?utf-8?B?ZnFBd1Y4aTlXeWtVNzN2RlFpU083VXZxMU9JVmFXcFpIakVjUmFlY3daN1Ay?=
 =?utf-8?B?MXhYaDVhRU9mM3JLYWZRbDdvQ3Z2ZmpRc1N0ZmJpLy9rT2Q0VlNVb3lYaWp4?=
 =?utf-8?B?UHJVbkJRa1BMTUwwMUxiVWY3aFRSMExXcEFCcnZ6d0xhd2k2RFQyaUVqNzFO?=
 =?utf-8?B?WjdQSEMweG53dUUrMC9tSWpEem1raVk5Uytaa1RCS2NhNkdhMDJWYnBKQy9x?=
 =?utf-8?Q?MUNERkycbXoBcFPRpXJr8e2E3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c091c36-8abf-49d1-17c4-08dd312731ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 03:30:57.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHYWrUzXxz1YbK1HWCCi5XAwJNcy3PQysvycJEbEc3L4n5DXwso1vzD5npPbtn0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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



On 1/9/2025 10:36 PM, Alex Deucher wrote:
> On Thu, Jan 9, 2025 at 12:59 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 1/9/2025 4:26 AM, Alex Deucher wrote:
>>> Add helpers to switch the workload profile dynamically when
>>> commands are submitted.  This allows us to switch to
>>> the FULLSCREEN3D or COMPUTE profile when work is submitted.
>>> Add a delayed work handler to delay switching out of the
>>> selected profile if additional work comes in.  This works
>>> the same as the VIDEO profile for VCN.  This lets dynamically
>>> enable workload profiles on the fly and then move back
>>> to the default when there is no work.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
>>>  2 files changed, 68 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 6d5d81f0dc4e7..c542617121393 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>>>       mutex_unlock(&adev->enforce_isolation_mutex);
>>>  }
>>>
>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
>>> +{
>>> +     struct amdgpu_device *adev =
>>> +             container_of(work, struct amdgpu_device, gfx.idle_work.work);
>>> +     enum PP_SMC_POWER_PROFILE profile;
>>> +     u32 i, fences = 0;
>>> +     int r;
>>> +
>>> +     if (adev->gfx.num_gfx_rings)
>>> +             profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> +     else
>>> +             profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>
>> Since profile selection is in generic code, it makes sense to first
>> check if the profile is supported for the family. Otherwise, this needs
>> to be passed by the respective GFX family.
> 
> The generic code already handles this.  If you select an unsupported
> profile, it's ignored when the mask is updated.
> 

That is strange. Does that mean user never gets an error if user
attempts to set an unsupported profile?

Another problem is this could override the user set profile now. Is that
intended? In the current logic, whenever user sets a profile, the
current profile is removed. With this one, another profile gets added
and the user preference could be ignored depending on the priority.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> +
>>> +     for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
>>> +             fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
>>> +     for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
>>> +             fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
>>> +     if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
>>> +             r = amdgpu_dpm_switch_power_profile(adev, profile, false);
>>> +             if (r)
>>> +                     dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>> +                              profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>> +                              "fullscreen 3D" : "compute");
>>> +     } else {
>>> +             schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>>> +{
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     enum PP_SMC_POWER_PROFILE profile;
>>> +     int r;
>>> +
>>> +     if (adev->gfx.num_gfx_rings)
>>> +             profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>> +     else
>>> +             profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>> +
>>> +     atomic_inc(&adev->gfx.total_submission_cnt);
>>> +
>>> +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
>>> +             r = amdgpu_dpm_switch_power_profile(adev, profile, true);
>>> +             if (r)
>>> +                     dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>> +                              profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>> +                              "fullscreen 3D" : "compute");
>>> +     }
>>> +}
>>> +
>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
>>> +{
>>> +     atomic_dec(&ring->adev->gfx.total_submission_cnt);
>>> +
>>> +     schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
>>> +}
>>> +
>>>  /*
>>>   * debugfs for to enable/disable gfx job submission to specific core.
>>>   */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index 7f9e261f47f11..6c84598caec21 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>>>
>>> +/* 1 second timeout */
>>> +#define GFX_PROFILE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
>>> +
>>>  enum amdgpu_gfx_partition {
>>>       AMDGPU_SPX_PARTITION_MODE = 0,
>>>       AMDGPU_DPX_PARTITION_MODE = 1,
>>> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
>>>       bool                            kfd_sch_inactive[MAX_XCP];
>>>       unsigned long                   enforce_isolation_jiffies[MAX_XCP];
>>>       unsigned long                   enforce_isolation_time[MAX_XCP];
>>> +
>>> +     atomic_t                        total_submission_cnt;
>>> +     struct delayed_work             idle_work;
>>>  };
>>>
>>>  struct amdgpu_gfx_ras_reg_entry {
>>> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
>>> +
>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
>>> +
>>>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>>>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>>>
>>

