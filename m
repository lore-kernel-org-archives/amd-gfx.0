Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1978BE7E0C0
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BD910E3BB;
	Mon,  9 Feb 2026 10:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMYbNpDz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DE910E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 10:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T72MnHdB8Q6RRgxQvThKsHVFSi0GNGYV4ceP2uwj7/o3gmuQlAlAzvvgJRvcLgAhUGi8z5dlfHWfo+6YqRZJBdUC7P96oo6xwlufALXGcwxL4rG2lVZOM+O/zu5Oi7yNDzcAgE1ZxRuAdzoF0WugXGchABSTe5kUjKV34dyhYKcOyG4w58S9EWdI6PBman/+EzNu8aoZ/vBiR1Xf6xWWrQCrFrzJC+CwpFlLEKa13odShj9YP/zVWS7n689Zlr5Xf4X/gTiJHjrWtvEWQ2IAmwjKm1PNBEPQ39Mc75Ib9irywQag46jkn9cjAZdhKsbnRpjIQoecHBPKnRqg9A6/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yp7r7Y9SC0jQnxendW2bkuoLu69l/vlURVXzFlhBSc=;
 b=hgyyxHk9sBlYwTVWSO04XDzkDTwPpVawGKAgQ+UBkCfeuY9dOuJixkDHgN6HZWjt5ODENhddqV4wh3x/xHmWCWoKqPDqeSTGxA69rwxXiPPTM9effKVecYF0xKuxmjXt3diPbB9HnCFT7wItzuIJ5VzGi3rBVmdRzc1K2I/Ff0fCifiqJLBQuc9K4hTnXnMW2LX8w1N52/GHaBrp5RBaY0gabooorhbawqPSDpNNZ4M9cyGkYzTjY+tzCJoHu09Kog46aBPJYp4ZHSzXYm09DTWVo6XYx/oLRd2euO+diACZTHFOoWH+Lq70JSDD9uOz8upFbO+TTtHiO/pDoIXF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yp7r7Y9SC0jQnxendW2bkuoLu69l/vlURVXzFlhBSc=;
 b=kMYbNpDzqa2SWvmNwR3fhBxIYmUvXeVUGFD+eZNLevEtCcMpfvjcKKz34X1uyP7ipplSEARR58omiOGDku21ydmSIQZaQJCFwBZQG31Ndi3YzpO71nZ8nwHKSaFxCy8eVr9CZb/3G1oJ0smzuH3tJ1Dk76YvlWg+o16t7/m1SW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:17:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:17:09 +0000
Message-ID: <6f67ecad-6f22-49d3-9486-fa67de989069@amd.com>
Date: Mon, 9 Feb 2026 15:47:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/11] drm/amdgpu: Add support for update_table for
 SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
 <20260209045649.59979-3-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260209045649.59979-3-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4216f6-7e8a-4cc7-29ee-08de67c4626a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0dYUjEzTmVFbGF3SGE1UDFkVm83eWVoZCtRRGc3emJPYlZybGVITGRmVE9F?=
 =?utf-8?B?VEdvVEdxWHBla2FGSVp3VHAyZkJRVFVITHVONnJOanN6SEszOWFFWUdFWHVl?=
 =?utf-8?B?citqOW9Rb0U3NldYTWxORFVkQ0xjdHBBOTVlN1FNOVpGWnNoRCthTnYybUk1?=
 =?utf-8?B?cnczU0lDWmExaHdWaEdmVU1MYVFYUjZ4ZTZzVEhjck14VEdFRUl4UFljVFdz?=
 =?utf-8?B?ZjhPdjFwOUcyV2Mra0VRSmwwRUM1ZC9JWTFZeVFqQVhTZTVnbGs2WVV6N1lY?=
 =?utf-8?B?a0J5WTB6c1FxWHVTcC9SNkg0R0R3d1NuNVFWc2JoZ3NQTzFMcmtPQnl6QmFJ?=
 =?utf-8?B?OXlDUldKeXYzQjNhRWFtZWJISEgyQ0VrdExpNnBBcnFXcTIrZWVzMklIOHgv?=
 =?utf-8?B?SXdFVHp5RmdEbnJUbkF4OU1UZGtQN1QrVzdFbzZSM3RjbXAvM2dPdDlSWkpi?=
 =?utf-8?B?Q3hNTWFmZllaekZReFdDOXBxaFk1ZDFycjVSUUk0Nm9EVXJ5bHovYklpNUNN?=
 =?utf-8?B?Vk1nSEN3WE5QWkFLRHRXbTF4ZTgzLy81S05NMFdRSVRzbkd1Z3J4aGY0bnM5?=
 =?utf-8?B?RnZmeUk2WE5FdmhybDZGdHNQMzNVZ0V6S1ZteTdqQ0RUdlJLTkd1ZitCRFRE?=
 =?utf-8?B?L281WTZ3RUhOaDVNTmYyNVkzSWtzUTExMExoMDFlS2E1VVU3TEpqK3ZGajR2?=
 =?utf-8?B?aDR5NHQ3S3dHRHFOKzJEckhZQ0VYa3lEUCsrRjlYdUlhQVBYSUFycTB0ZGNr?=
 =?utf-8?B?dXM1SEZuU0xrWWZodVpoSFN2Lzh1ZlJRTzdDS3NmRzZ5WGF2U2prTyt6K2N0?=
 =?utf-8?B?cVlrY1YvZ2h5Y1NQSUFvOU1QeG5rWmVIWTJUVVoyNDU2M0hKeGQ0elgralIw?=
 =?utf-8?B?ZTVFTWVPampURDlJWlhScjkwVk9hZzByMXNzZmZ5MXFWY2YrTXN4Sk5JdlFG?=
 =?utf-8?B?Ym5MMjMwQys5NmVjdHZNbExLbjJTTU5Kb2xMa3pwNlpHYzVrRmxjMmZOR3VQ?=
 =?utf-8?B?bzhwMHB4YlpPT2oxWEkwdjJFbDdOODVPWDg3OUh3LytSOTNGWFdlYUk0M0Uw?=
 =?utf-8?B?QXp0UGxha3duTmI0ZXJiQWZqVlhNeDFvUjBRYnJxVHN0WjAzN2V5QWxtK0F6?=
 =?utf-8?B?VktjN2ExNEcrbW9OMzJ6UE1PMjYvbDl1TjBvdXBha3paSENyOUNsdUNpcTlo?=
 =?utf-8?B?dzZyVDNIS2dJUFRjOEkwZWVWQ0d6aU0zcVA3NytUdnlJUkpIemhPMkY2bFBI?=
 =?utf-8?B?cE5zU2ZiTkdKcWJRb0FyWVdWZ20zK3JtU1o3STB6OXBQaE5QNGNoQXVsNGEy?=
 =?utf-8?B?T3RtKzduNENJMU4zbWtNbENSSEtDTXdYakM4MFFLOUY2VUd5c0VyQUZWY1oy?=
 =?utf-8?B?bncvNWlvQUYxeHpRT3JHNm50elBhVHE4UEd1UnJpbFJGbmFHeHVwVVRYbi9F?=
 =?utf-8?B?eDB3dnRvL2ozaXhPREk5TkhEdnNJNDFUelFiQXNmWnpUT1R2OWdGaG5NbWhk?=
 =?utf-8?B?TXNSNEliSDFhaXppaFVlTW1KdW82clFickVpMDlHZWZkQTdZOWxqd2ZQUERq?=
 =?utf-8?B?TXhSdWQwYVlHWFExT3VyOVpRRW9EM3ljQTFJcW40Ykhxd045am5hOWM1NWxT?=
 =?utf-8?B?WGtQSzFucDc3NWE5YTR1NEo1L1ppd1U0ajNFc2xnRFpIM3J6cno1Z0V4VDB5?=
 =?utf-8?B?dHAxL2p6cys4RzA0SnU2ZXoxM0VYeG1yVVJxdEpOVHZtUERpdUc2TzZpbzYw?=
 =?utf-8?B?R0N0S0RjUnRQOXJSTTU5VkUvdmhPTkVVMWFpendOZ29lWGZvZzM2VGFwUDFh?=
 =?utf-8?B?YjBmejRiMW1acjZac2VvZjJRUWF5MDlRaVhacG5EeHdqVHNQUjJpaDFTT21Z?=
 =?utf-8?B?L2ZBeFZMbzF4QjRYZTJwUTcvWWRkVytuazBNbStJOS9iZXdUaGIyVVBLdG05?=
 =?utf-8?B?ejgxK3JtOWtNaXBOQk52NWI2YnBMS1kveGNvVlVuMzBoL1c2dGR2Y0c5RTRY?=
 =?utf-8?B?dUcxZ3F4WXJrc1ZOOUNhMEJxd0tLOEhSN3lBZTZOOTNLOWc4RDNwYlNvRndl?=
 =?utf-8?B?OCtIZHZpbWlvbVk5WkVXb3pCTkphMjZYc1d2NEs4N3NZeFM1SHZrOXJ5WlY2?=
 =?utf-8?Q?+dIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BwbWFOb0pIRlZkbU1DdTZwR0JYVkVxNFpUSVZTZTdsVko5T3F0dG5YZkV1?=
 =?utf-8?B?WW9Welg5M2dSakg5TGV6cjdkL055RmJyUlF3WHN2SEMzdlpUWG93ZTZyYkM3?=
 =?utf-8?B?RTN2QWs2LzBtR3RXVlY2NitOcWZrK1VCZlU5K1VvbXJqZ2ZuV0Fsc1B1a1Bi?=
 =?utf-8?B?OW5JWTFJUUJaR1VYbllMOTViY3JUSUdTTk1CRmFCZ3YyQTR2M1UvdktqT05t?=
 =?utf-8?B?b24rMGJ1TDRwNC9lcWlueWNsenNnL1ZLN0QwY1lGVUUzT1M5UXFLU21mbFk5?=
 =?utf-8?B?cE84Rjl0dnRIY3Q1RklDT29acEFjdVkyM2VlMzZJNkxFL0FLK1N6Y3MxeWVC?=
 =?utf-8?B?RkorblRyZVk0bTlzRVJDbHpjc3BuM0dmS2JjNFRVUGoyaHBwblY3UndlSFQy?=
 =?utf-8?B?Rkk4dFZ0OWl3Y21kRzlBMjk4SjVZM2xuanBpVVFzRUJGOUE0VHBZcGtuQzB4?=
 =?utf-8?B?em9kYmhhN3VGaW13UUN5Zm10S2dxUWpQSVc0eUhGWkE4allYMVUraVBBWXZ1?=
 =?utf-8?B?R1UyaGhxSnh5VEhkd1BBZ25tcUhIVVZmVjdqTmkxNmJaQlpjMERZK1RmOFE3?=
 =?utf-8?B?NEhUeVNobUlGQUJicnMrSjJmUGFiQVRjNzlKQ1B0OXdQS3ZSamdtM1pob1p2?=
 =?utf-8?B?MzUvVzQvS081c2RpeGtwQ1QwcERhVmRTQkFaU2k4YUVWZXpJQnhzOU1VR1Jj?=
 =?utf-8?B?TnBKTmpoK3dmTGhGUFF2d1Z1ZGV3Q21weEhoZjUxazd1Tjh6V0RmMlo1Q3Z0?=
 =?utf-8?B?OVhNWmxvTDA2bXB3ZS9nM1RhbDB2dU95UmlOQjBBNEFISVE5WFhUR3Vha1VW?=
 =?utf-8?B?cUxpeVlGdG9YQmExNUlVbXdBRlNNYSs0eHIyUVJ5b2QxMVFpR2tqYmJhczJv?=
 =?utf-8?B?VkhDMlloZ2Q0dStsdHpFanZRbk1hYXFvOXl2QzJ5UDNTUWwya3l3QWV5ZWJH?=
 =?utf-8?B?ZXZrVmlxc0cxTUk5T2Irek1YWTY4RHVtNXBVcDlpbHhpamtoUmljVEZ3SGxQ?=
 =?utf-8?B?TVZETUtmaFkzTElma21LRytWZE9FSEhNOWlHUEZHTUIvdE1ZZG4wUk5GRWxT?=
 =?utf-8?B?NnlSejFLYTBiUzZNZkpiVFREUlBiWlErU29oL3k5T1FNb1dOc1VRRXYxUGxQ?=
 =?utf-8?B?RUxoMTFwMHRpMjIvQklrNlBza09EYkxzRW1kNUx4a3NMWkovVDFVdDU1Szk0?=
 =?utf-8?B?T2RjK0ZSVlhCeVp1eUxmaFNzR21nVVNleTZ4aWNVaFVwSzZsc1YvTmJlb1Fp?=
 =?utf-8?B?WkVQT1ppa1VaMHA5aWR3N1YxOXM3V0NqV2VzdURNRU5TSVBjcVYxNlo4NXdm?=
 =?utf-8?B?RGR0bk9LL3VuMHJJRXhjaGtTNC9CNlAvTUpXdlF0WkFqbjlPMks5dW1WeW1N?=
 =?utf-8?B?YzlVMGNWb21KRkppNzdEWWNUTU5jSjRFenI4L1ZQRXZVTjNpcmh4VitXWlN5?=
 =?utf-8?B?NGpOUHBpRGZaUHE1aFN6VUNjMzNHWVM4Mm5WekhDVW42eWdPNnNCNU5yMGwv?=
 =?utf-8?B?U0VJc3dISTl3M0piVHhic2tYY1l5V0UvYmJXNzRvb2IzVEFHTmRFdUJTZS9x?=
 =?utf-8?B?SXpMNWJMNFQ0cXIxd0RYMHJ5WGlFNmFwZmlLMmU5ZjBMZkNlbXpxTVZCVHFV?=
 =?utf-8?B?YTlvWmRtREhkNXUxTURpZmpwMFV6RFQrZ25hMWp1REI3VGNOUmZnMGJlcFhU?=
 =?utf-8?B?R09MeFhSdXllMlhLQUt2U04xZTg4OU9UTmptdnIvRzU2c0ZIQkZFbk5TSEVl?=
 =?utf-8?B?TXJHUFhTa2h1bjIrM29LUmNsc1MyWGp4S21jQjY0OHZ5ME5mRy96eVlCSmlD?=
 =?utf-8?B?Um52QjJzem1CMGRvWnhCOFZON043blBuNm1TK0hCTGdCMDFoVmhEN0l0WUZn?=
 =?utf-8?B?Zmg3bE9iOW1nVE1hOEw2NWhsSHMvTDk4a1drWGhTTHREaGVwLzRCK1Nvb0Zw?=
 =?utf-8?B?c0tDaUQ4ZEVLRVh4NEdNMHA3Rmd2ZG1nd09GTHNST3p6YUFtUktHQkE3aDRX?=
 =?utf-8?B?eFEvbWgwQTB5ZzgyTzBWUmJ3MmpCSjVPYUNjQk9ST2dDZHhDR3NWQWxlV2pn?=
 =?utf-8?B?R292ZmpJZnIwMlNSOTFTdWR5QWtFT1JUWUVrSU5GL3VNUk93QVFBdkRmNi8v?=
 =?utf-8?B?UVFhMitFZDRWb2E1ZEswUExBYmlZRlhrQTVyUDB3V3JFMXl5bjd5OC8zYndB?=
 =?utf-8?B?d0w0dGZvSzVmVVlFRldkSkNOTHEzbE1yN2g3eWFVbyswd1cySUloblgzQ0tu?=
 =?utf-8?B?UmxXdnZSL1dMWDFGczFLcGEwUWFJQnNFMUJxanZSZllDaHNsT2x5SmQ5aStn?=
 =?utf-8?B?S1VCV1pCZFlRWUhNaE1RMkpNSkFpNktSZnJ4RFBDWUFUVi81NkZ0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4216f6-7e8a-4cc7-29ee-08de67c4626a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:17:09.8972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibx175R5CHLjDnqY8ItTwou9I5Bf7t5S+qO/hxDQNDliEWaCPKQxzLixUNgoDoB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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



On 09-Feb-26 10:26 AM, Pratik Vishwakarma wrote:
> Add update_table for SMU 15_0_0
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |  5 ++
>   .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    | 60 +++++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 14e8d8c7a80a..af87c31ca9a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -241,5 +241,10 @@ int smu_v15_0_enable_thermal_alert(struct smu_context *smu);
>   
>   int smu_v15_0_disable_thermal_alert(struct smu_context *smu);
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument, void *table_data,
> +			 bool drv2smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index a2854d528bab..fe18af12aaf1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1726,6 +1726,66 @@ int smu_v15_0_set_gfx_power_up_by_imu(struct smu_context *smu)
>   	return ret;
>   }
>   
> +int smu_v15_0_0_update_table(struct smu_context *smu,
> +			 enum smu_table_id table_index,
> +			 int argument,
> +			 void *table_data,
> +			 bool drv2smu)
> +{
> +	struct smu_table_context *smu_table = &smu->smu_table;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct smu_table *table = &smu_table->driver_table;
> +	int table_id = smu_cmn_to_asic_specific_index(smu,
> +						      CMN2ASIC_MAPPING_TABLE,
> +						      table_index);
> +	uint64_t address;
> +	uint32_t table_size;
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!table_data || table_index >= SMU_TABLE_COUNT || table_id < 0)
> +		return -EINVAL;
> +
> +	table_size = smu_table->tables[table_index].size;
> +
> +	if (drv2smu) {
> +		memcpy(table->cpu_addr, table_data, table_size);
> +		/*
> +		 * Flush hdp cache: to guard the content seen by
> +		 * GPU is consitent with CPU.
> +		 */
> +		amdgpu_hdp_flush(adev, NULL);
> +	}
> +
> +	address = table->mc_address;
> +
> +	struct smu_msg_args args = {
> +		.msg = drv2smu ?
> +				SMU_MSG_TransferTableDram2Smu :
> +				SMU_MSG_TransferTableSmu2Dram,
> +		.num_args = 3,
> +		.num_out_args = 0,
> +		.flags = SMU_MSG_FLAG_ASYNC | SMU_MSG_FLAG_LOCK_HELD,

These flags are not correct. First one indicates, it's an asynchronous 
call and this one is not. Second one says caller already holds the mutex 
which is also incorrect. Just clear all the flags.
> +		.timeout = 0,

This is also incorrect, just use the default timeout.

Thanks,
Lijo

> +	};
> +
> +	args.args[0] = table_id;
> +	args.args[1] = (uint32_t)lower_32_bits(address);
> +	args.args[2] = (uint32_t)upper_32_bits(address);
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!drv2smu) {
> +		amdgpu_hdp_invalidate(adev, NULL);
> +		memcpy(table_data, table->cpu_addr, table_size);
> +	}
> +
> +	return 0;
> +}
> +
>   int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;

