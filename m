Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D88D73EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BD4010E8FE;
	Fri, 30 Jan 2026 05:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cD92taHi";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC8510E8F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvAUu47BFH1LKUojY09en5ZsxdrVqmnq1cRQHgpgX0C9WfahhtdrVIpgLW9NSFlFlO+iOft2HNBtxt+8PmoffoHH+sXYVVPMw+3w3uBxgUdNZjjlE7Kfnkrn4DmxFOBzEKh77hD6aJNQW9KFPgm0Mh/jIw7ohQMrSp3tStMaeL3EZi0Qeo9Dm/AbMON2DWmNpEpqcPSf56u1QxTM84vqQaKH+wvPxEppvj7m1XJsKV/9OK0htPxDAuWYaMw8xqQyU9nBjbXnJocudkkxN5wyuiZKZ/B6OgvmFGyGRtvE70dA1t0W/RkYsy9Sz6BzIdG2/QGHV6oGPlpXfxtLFBcrHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibk+chDCN0jZhqZAFbwFhmBU7XKmBSjlB0tgJfYidcc=;
 b=Pn8whs9FU09qR8+0G1tvJJn9T587+N692A+lzipnqZgNU+R8ZhEhEoHiH0OWs8lU0f6kO0hlzh9pc5d16dmo0aYA1oAT+V8QKg8XcU5pqRMp9D1rXOuqSYfhBCcEzTr6g81/dMYBf3rKbrm3kyflA2C0PYiRd1399+4f3B1qY7szN91CFxwFktOB7+UVSCB2TDg8HSnM/jm6BJJt95tBsxBERr5IJmkfpYz1XrRyGgTDKomCU3rhWOvzB3Rl2CuQ+JUTjLopfs4xef39DSLJWjzTJPAeNDryG8NlrGwWRWdI0iIMxisXwkUvLIR6L6g5iyDanipY4QjQK2jaHdwRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibk+chDCN0jZhqZAFbwFhmBU7XKmBSjlB0tgJfYidcc=;
 b=cD92taHi5ZLgYjG7rm2UOV+AF906aR1YCPTaQNIGxjn4xBDAlceAWgU6TlWf3I95TQZ1jnCbP0RdYhoQqkWraRQhArLAXe8lVbPCeDrEyh81bBfSGzwxpXd33Gh1NHwwbBCB4pdBpeGToVgvVHxPKfjW1mYCDQB2OCz/SDombh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 05:48:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:48:46 +0000
Message-ID: <60ffa101-d99e-45b1-b40d-f89d2e937345@amd.com>
Date: Fri, 30 Jan 2026 11:18:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] drm/amd/ras: Add table reset func for pmfw eeprom
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-6-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-6-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: c023100d-172c-49c9-fac0-08de5fc33b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yit0VGdmcC9DbWZweUdVS2dkM1BRNHFGNUIxYlo1K2JWMEt6Y2ZZZDcrb2pU?=
 =?utf-8?B?L3QvM2QreWJuNTNQVTJ4eGowT3pyTm4rOWJnVS81S0kycENwSnZldEhqcGNl?=
 =?utf-8?B?WHkzWnZPb0kzWkhaTWUrNnhXSG5sVkp4bnQvT0MwcFZwVlRCWUplU1l4TGpo?=
 =?utf-8?B?aEQxTHpIOGlxdHFkbzBQaDc4M0lNUE53WWEvVk5oSWJSVjJiL2M1bERSME5N?=
 =?utf-8?B?OG13M0RMemQ3U2pVVGJ3NFNUSzVnc1A1dWtrOHByUmlQSVlsWnJMdm1kZTdS?=
 =?utf-8?B?U1ZzaTZ4VjVWOWY0MTlPWlRMTm1LSW1EOXY2N1BGMjBNTFhqMHdIK1IxTmF6?=
 =?utf-8?B?T3FyQmFVRWV5ZW9CQU5VQ2FLOWZPZm14dk1KU091d0NjNzN2UnJCcCs5Ym5Q?=
 =?utf-8?B?MEVubzE3bDdXQkdySjJ2TzRQVCtHaHBRRFpsS1h6dFlzOFhtMVh5aThEOUZ6?=
 =?utf-8?B?aVl5MDZHbk1yR0FHVk1WL3FCNGplcTBZdkN5eWM2U2VmYmx3SlVoYmw5OExs?=
 =?utf-8?B?ZFNLRTBBNTdIbmNrMm5NTTRYOE5hUXdaTCtLNTIzekZsb21JZlVQMFlSWWx2?=
 =?utf-8?B?M0NOWnRVQ1dzQktBVnZrTFdHRmk5cXFWSFJpN0I0ME1wRWlibXcwenhPeXU1?=
 =?utf-8?B?WkE1TFI2cWw2azZhMC9IMk5uc2J1Zm9XS2c5ODZjaURMazFsR1hGK0UvdWhD?=
 =?utf-8?B?NHcxaWFDRlMrSitYVlpzTThyeDMwSG91cHFQRHpaSW5IWmZCdmhxUlQ0ZVo4?=
 =?utf-8?B?WW9kZGMzWlJTUHJGMi9JV1lEVnZyQjIxMHpEa1p1SmxUa0JvR01Ea1pkNEhl?=
 =?utf-8?B?NDMyajZPOW9lTGN1aGc1cTAvdnlpdGxMUmNZM2cyZkVneWx6Y0U2Sm90cEto?=
 =?utf-8?B?ZnpEZjJIV1Mxb1hzenpNU3NJb0lKQ0NwSnd3alNycldkSlR6SWdTbVkvaUVT?=
 =?utf-8?B?L05qR3NROEFRN0ZDbnA2UUFBMExiNlV1RjN3NERWeE13bW52ZzJvbTRCUGRt?=
 =?utf-8?B?WUpOcWh4VHgzdVc5MVZvUG1tNmppVE1GbU9pQ1BOZS9qVGdMc0hYNmtxUjdo?=
 =?utf-8?B?RlJOL0dtU0t0L1RuZDhiVE1aQUJneUQvczRwMGR3Y2N2NU4yTy9rYnBGVm9R?=
 =?utf-8?B?Zm1kV2RxL3NGeTVXd2NlaGxuaHJ2VmNTL1huazZDSG1uSEpQdTVwejZtSlpn?=
 =?utf-8?B?anR0bXpramtsN3dBM2Y3bkRta01ORFpYeHNFNysvQ1dQelE0M3FqS2oxZ3Rh?=
 =?utf-8?B?RmxzaVBjbk1FRlI3UUt5ZWwrUnVYbzVEUHl3WnFDeGc0bkQ2TGUxZXRHRFJL?=
 =?utf-8?B?UTVVY2JnNFNHbnRVcXZBN1VRNzFrTGZaRWEyY1ZPb1B3SWMyV2JSWDE2Qkx3?=
 =?utf-8?B?V1FnRCs2Y3l4MFN5bHlEbGpKMndzOGhIbFlES3NJUU8yMnFZUDdqaTU2eERU?=
 =?utf-8?B?Uk96a2JLRnJQYk9HMVRPQlJxenAzeURpNEprK2FMQThUc0lmMm5QK0piTjho?=
 =?utf-8?B?M0MwRW9BM2pmeUgzd0JjbjdrS2JrUTUwVm1UbGptc2gyWjk3Qi9ITHI0OGNO?=
 =?utf-8?B?eTZuL2xLS2Jxb3NPOWFNWi9jTmhuRWkrQy9NYTZEZzBYdFYydEJmeW51NjU5?=
 =?utf-8?B?dktGRlFVMy8rcEJBSy9JckVJdFhsQ0ZmZXN1SG1FL0FVZXBwRFhXdjR5OEQ4?=
 =?utf-8?B?clZKL1Z5QmVCWWx0QVAzWGdrWTExdWZjLys5c3ZxY3NONEU5aERxL0w1TVZi?=
 =?utf-8?B?RWdoR3lnWFMyNDlZTnZsN1JaeUEzaURnSDk5dGpvUnl4YlZYVUFTRlBHd0wx?=
 =?utf-8?B?MmFzV1pBbmVwV25qeDQ0YlVEWk1RNk5ISXZ3b2swN3dpMEUrT2J6MFJjYitq?=
 =?utf-8?B?OVkyanlDdzcrWlZPUm1WNDU3RS9RUXFlQ2tjZHJCMnpSSDQ3T3VHWURuejRK?=
 =?utf-8?B?bjRGVjJYRlNOQjBiVjdoOEZXWEluT002K0xPZDBqUWQ1aCtKYU1oTjVoNm84?=
 =?utf-8?B?RFZIT21wN1dkNDkwaldPbXZtUk5LV01Vd0dOc2ZxTlRYeFg0M01CclNrVWV5?=
 =?utf-8?B?ZXpYTUVHQ0tIUmhVSkxKQ3I3S2FRNkNqSjFDWUNIY0YwUm5HR0hhaXJjcTRp?=
 =?utf-8?Q?eZFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpYT0ZHL2RLUTg0SEZEOW92cmtkYllUSCtleGpPaEJaK0oyRWVabTQxYTgz?=
 =?utf-8?B?Rms0OE5OMjZYWEt3MzFKaGpHRGZLYzZRSzRDc29DSnY0MDlMVm5PeGVVVy9N?=
 =?utf-8?B?ZG05WEF2aXI4dmxidHNxM2wxWFdHV0t3UzBzeFFjbU5odW5ZeUl0c2JPNlJw?=
 =?utf-8?B?U2ZkZG5KNDJiK2JGNkhtUXZ2enBKcHIvNk5tRmFaZUdkekJwTDRQMm5JL0Fm?=
 =?utf-8?B?YUQzaGd5azYwTnltQTVLRTFFMnBiYmo0WGtrVXRzVStZWjEySU1nNWNFMHNk?=
 =?utf-8?B?L3NpV2Q1RHRKQ3NwOW00VWZaeWVsaFUwWEZseU1HaTZ2WCt0dTJSQVd1MFFX?=
 =?utf-8?B?SXpLSlFKZFFoVVBzV2VzZGgveDczMEprUEhuV2lrOWZZOUhOejk0OW9PSFBP?=
 =?utf-8?B?Qy9sN1pyd2pTWE0zQTVnZSs0U0tWU0NvRzNUU0dqcEptWXVtTzBaZ2dMZjg0?=
 =?utf-8?B?WklndTgzZzBrRGtFZ1h4aERHNWZVb29lTWhRSjhTSW5lVFhyTDVZTXpPby9Z?=
 =?utf-8?B?blBvQlBLd2ZzSGEycGVvQ244RTFrNWxuSklPOWhRbVlnRTVCTHd1VHpkVXhJ?=
 =?utf-8?B?MlI2T3FzdE1xYzJhTklNWkdnU1VlekdtSld0bGlLblNLdks0QVIxL0JiVWhx?=
 =?utf-8?B?bkFnTWhxT2diYzNUd0NHMHg3ZU9aZzZXbEwrZjRhTkJKV0JZWlRxZDkxTW95?=
 =?utf-8?B?VzE3Ull0UTM2NXJWRGkyanpIcnR4R2FJZ1U2ZjBTUVd1eEY0eWxPQWFVWmk2?=
 =?utf-8?B?eG1NVTB5RlRUYjk4ODl2c3djNU1SQzVJWVNpSjFIRHBnaXZaa3h4OUlVZUxs?=
 =?utf-8?B?bEQ4OG1YTmhSSFY3SFJMZXRHUVBFVFNYWkdhNVRpa0JPbUhMMlNPOFZlVXNK?=
 =?utf-8?B?VWp3VHNsUy8zOG5oQVZnV1diNXI0VVJVbXY1ckdoQWpBcERZWWE1dEpENWpP?=
 =?utf-8?B?TDEyNUtuLzF2a2k4VUd1c3V0UVRMWWpjUzNudXh4b2J4UHZJR0VjWkRkdEMx?=
 =?utf-8?B?WFp0NFc5c3Q1dHFSOHI0aytFR2NkMWw4VGxkSm1IYUcvZjlMRTFzRStMeHdT?=
 =?utf-8?B?MW4wSGhEQ0Y0UTc0ZTREZ3dobmlDYUJSbUFUNzNldlNlbG9aK2lrdnNuc01q?=
 =?utf-8?B?RFVsdytSZElaR0d2eG5Qc1pNcW9Sb0QyMmtVM3QxT3dKWWtBZExOV1RUaHlo?=
 =?utf-8?B?WTBGYjhaUUVaUnU2SUNtS0ZLQVpObkFTWFVjbmtKMkNGRFZZVGw3dmx5OUlP?=
 =?utf-8?B?MWs4NjlCOFpkTzBpZkFsVllONXlNeG41d3I2NmQ3clVHTEVmQytwd1ZPaVJW?=
 =?utf-8?B?SklSeW1UWi9FUnBCM2g5cmNmQ3hxV29KVGphNlgrc0tzaE5MUDBRRmUwYnRE?=
 =?utf-8?B?ZDM1VDhzamRnNkxnS0k1RVdWUmF1M0VRY1JoR1RuYlVhNmtqZTVncnlka0tM?=
 =?utf-8?B?SDV2ZEFYalYzRlhqVC84bi9OK1Fkd25JZUFIYThwcjlIZFpIaStNbW1QYVhz?=
 =?utf-8?B?dkpPeG5pY212UmJVcDBqWTJya0JTaWJNQk81L2pLdTdDaFVpdkVaZXVFaVBZ?=
 =?utf-8?B?aTlqRTlwOUZiZUdHcnJkM09zR252Yks2MjFNVnAvcFVzWDFnTVNrMlR4TjVX?=
 =?utf-8?B?TWpjNUc2bDhXMVFlRUUxMm9PQUliN2hzbm1TSjZVUkFBWWJGbFlkSkZpL1Jp?=
 =?utf-8?B?SDNMbHRvMU95bE8ySy9MZXMxNld4akNBU1pZSUQ0dGZHaGJnV0loc3A2U1d4?=
 =?utf-8?B?eGZDcys4WmNoQ1l6VEZQWlJrOUcwUnAzbDlNSGtCZWV5VkxGWndZSnlpVzVS?=
 =?utf-8?B?TkNBVE1zZVhMS1NFWmhoNkZ3N3NhZFk5L0pTTE1lQXY0dS9ObWxaakNhazNR?=
 =?utf-8?B?b3V2eHhicGdKaG5ObDdKRGV1TGM4V3hxNTduYlhlMHVjVHdLOXdXNTdoa21F?=
 =?utf-8?B?cnU4dHVCTXh5ZmszYmFCNG1SbDJ1S0d2Q2Y4MitaSE9YUjhpRHd2V1gvbUpu?=
 =?utf-8?B?dllNUU1jWXFCRG85OWtkaXQ4RmZxUk15dTBVUjhwM21yTEVwOGVWK0ZHOU9Q?=
 =?utf-8?B?VmxyY2lmZzk2VlJNUkRWWFFlbmhnb2puSENDMHpVY3pvNjBJNVIwZHEwQkFJ?=
 =?utf-8?B?WUdqcGxGMDFBZ1VLUFNqdHFRaFRDSWVBZFYwNzdZcDFyNHVoZHk3dTFjRTI1?=
 =?utf-8?B?OERpeXZFZGUzNHA1NXNGZGJHaEVQZkhteldjeUhYVG9IN3dUc2sxWEM3Rmha?=
 =?utf-8?B?ZWdRSklJQUVVS3A5QU9mbGh1VUVsSStPU05ZYWNmc2tnYVl3Wk00RC9FQVdK?=
 =?utf-8?B?aTBkTzV0SHZkT2psRHZLejh2RmNSUVRWZkdIWGdVUHdENHVKR3RMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c023100d-172c-49c9-fac0-08de5fc33b88
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:48:45.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N304A3darsRcHhB6hdfRYJcSmZ1JbpHlpK7zpXd5isg8CCgEtU6IgvkLBTpemcdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add table reset func for pmfw eeprom, add smu eeprom control
> structure
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/rascore/ras.h         |  1 +
>   drivers/gpu/drm/amd/ras/rascore/ras_cmd.c     |  9 ++++--
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 29 +++++++++++++++++++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   | 26 +++++++++++++++++
>   4 files changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 6e223eff522c..ae10d853c565 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -313,6 +313,7 @@ struct ras_core_context {
>   
>   	bool ras_eeprom_supported;
>   	struct ras_eeprom_control ras_eeprom;
> +	struct ras_fw_eeprom_control ras_fw_eeprom;
>   
>   	struct ras_psp ras_psp;
>   	struct ras_umc ras_umc;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> index 94e6d7420d94..4f89810d85a1 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
> @@ -146,8 +146,13 @@ static int ras_cmd_clear_bad_page_info(struct ras_core_context *ras_core,
>   	if (cmd->input_size != sizeof(struct ras_cmd_dev_handle))
>   		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
>   
> -	if (ras_eeprom_reset_table(ras_core))
> -		return RAS_CMD__ERROR_GENERIC;
> +	if (ras_fw_eeprom_supported(ras_core)) {
> +		if (ras_fw_eeprom_reset_table(ras_core))
> +			return RAS_CMD__ERROR_GENERIC;
> +	} else {
> +		if (ras_eeprom_reset_table(ras_core))
> +			return RAS_CMD__ERROR_GENERIC;
> +	}
>   
>   	if (ras_umc_clean_badpage_data(ras_core))
>   		return RAS_CMD__ERROR_GENERIC;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index f880fc49477d..ae63e7394829 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -161,3 +161,32 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
>   	return sys_func->mp1_send_eeprom_msg(ras_core,
>   			RAS_SMU_EraseRasTable, 0, result);
>   }
> +
> +int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
> +{
> +	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
> +	u32 erase_res = 0;
> +	int res;
> +
> +	mutex_lock(&control->ras_tbl_mutex);
> +
> +	res = ras_fw_erase_ras_table(ras_core, &erase_res);

Except this call, everything else looks like a common logic. For ex: 
num_recs, bitmap etc. looks like common for eeprom as a whole and not 
specific to fw eeprom.

Thanks,
Lijo

> +	if (res || erase_res) {
> +		RAS_DEV_WARN(ras_core->dev, "RAS EEPROM reset failed, res:%d result:%d",
> +									res, erase_res);
> +		if (!res)
> +			res = -EIO;
> +	}
> +
> +	control->ras_num_recs = 0;
> +	control->bad_channel_bitmap = 0;
> +	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
> +		&control->ras_num_recs);
> +	ras_core_event_notify(ras_core, RAS_EVENT_ID__UPDATE_BAD_CHANNEL_BITMAP,
> +		&control->bad_channel_bitmap);
> +	control->update_channel_flag = false;
> +
> +	mutex_unlock(&control->ras_tbl_mutex);
> +
> +	return res;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index 46f45e82a3f3..a1003db3c33b 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -24,6 +24,31 @@
>   #ifndef __RAS_EEPROM_FW_H__
>   #define __RAS_EEPROM_FW_H__
>   
> +struct ras_fw_eeprom_control {
> +	uint32_t version;
> +	/* record threshold */
> +	int record_threshold_config;
> +	uint32_t record_threshold_count;
> +	bool update_channel_flag;
> +
> +	/* Number of records in the table.
> +	 */
> +	u32 ras_num_recs;
> +
> +	/* Maximum possible number of records
> +	 * we could store, i.e. the maximum capacity
> +	 * of the table.
> +	 */
> +	u32 ras_max_record_count;
> +
> +	/* Protect table access via this mutex.
> +	 */
> +	struct mutex ras_tbl_mutex;
> +
> +	/* Record channel info which occurred bad pages
> +	 */
> +	u32 bad_channel_bitmap;
> +};
>   
>   void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
>   bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
> @@ -41,5 +66,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
>   				    uint16_t index, uint64_t *ipid);
>   int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
>   				   uint32_t *result);
> +int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
>   
>   #endif

