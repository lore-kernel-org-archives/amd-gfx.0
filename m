Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC02C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 21:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C1410E167;
	Wed, 28 May 2025 21:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iYTYYxq9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B94D10E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 21:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsfyMqJrnwJe+kbsBWDSY/iwdYKO5kJ6Ol0m/rlbSX3PqNa0tP2ixgClvk1zARY94DrvG+UX6rZaXv5VDSNCWk6R+5AqzpVWG8haFc6GzqtXnA3cXZNm7OWmrwe1ecMNDNijjiVyHcGBo0wq2ABfDAtQCE0Vor8OLEYkq15oU0ULqDYlvtrVgz4ZlhiVmGGt5NkpMDU7b/R0oHp9qEZc74ljgdy0qU4BpGwnDoBBLYqfwwpbGoeABSCBKPiK/9te2mlqOYGpO1PD0IaPWTsBMMxysMYlh7dOiberuXiLhpSIrFPyXsjI6ClzHuXsxvv2ZbA+MUWkbPv1L982xFFlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3nNDPVX4lKnGOsK9tL4cmg7Sh5AXVxyyyEN2Zpfou0=;
 b=QXwsMDz9qGh01OHF3ZVHM7U2RpLP6mfdIxtM887YU2kKJ/fNSHbAQI1QtrOIqhwv+UfAesBxLuavy97Kee1xAcLaqBG55KlmQdiuebKdvdEalx63TJ5F1sGwy3gEikao1jLIS1OUpKSUfWAdBylhy7fmKhyFn4fh2ZT3JezZ2BiSdjk8/7/BibJBC0bPoYBqoyMsB1X14lsrGTy3MeXfWwb8c6YaZCkV/deWsdNeGmnk1lYGikb/ws59BzdOxDzYtRRpkgDSfFxDlKsreRcFdDZ2pejzUY2U/TkDNC/3csSwz2x11inUgbB+7+66/xObAHOd57nxahESb2yLh2fZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3nNDPVX4lKnGOsK9tL4cmg7Sh5AXVxyyyEN2Zpfou0=;
 b=iYTYYxq99WbJTFcbZEmqMkNP2JohfLf4sMiHIzs/ewsW8NpZ8ROvjUITSNOMmJggPS3xxbPrrW+WoI5gZo0LTfpXEfHytofVlJYGYev7CXRaxY2t0gjy0OcXLHJduDzaOMsIRyPIizbQcMRvPtX90lYJ6peVCwi965iyPRaEl7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Wed, 28 May 2025 21:14:47 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 21:14:46 +0000
Content-Type: multipart/alternative;
 boundary="------------4JpfwWr5colXG9Zr6JXCB1aZ"
Message-ID: <c00201a6-dbbd-4f10-9501-b7387c1977f2@amd.com>
Date: Wed, 28 May 2025 16:14:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Should to return the evict error
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250521035654.17581-1-Emily.Deng@amd.com>
 <PH0PR12MB5417991052F0D5ABED1D99528F99A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <93eec18b-b05f-403b-a6ea-c082efba44ec@amd.com>
 <PH0PR12MB5417AB0F878176D2041900D18F65A@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54178912FD347C37BF8915388F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH0PR12MB54178912FD347C37BF8915388F67A@PH0PR12MB5417.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:806:28::13) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6517c971-0c65-4af6-7d38-08dd9e2cac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVjY0taU09VTXM3NXAxQ2dUTFNSdE5Qd0VEK1NhaE42eGVHTDhPeUtvQXR2?=
 =?utf-8?B?WVJOR2tzTUcvL3FwZ2hlTlVPZHE4VjNWQnZ0LzNXcnU3UlRMTTNxUFd4aWgr?=
 =?utf-8?B?bjhWaTFFQk9acGMzUDFob1BkNGswMnhSQ1d4LzJwbm5SUlZrZ2RZZTBlVllX?=
 =?utf-8?B?YVNJNWdQOXU0THB4ck1YanlHUHNGMGt5aWRLUjIwbGJyd1N3NjdEK1U1SXRx?=
 =?utf-8?B?MmQwM0JnODZzUWgvVURWbXVQaURZUHlPeGFiaUlkK3cwclI2aitIVlZkMHBh?=
 =?utf-8?B?MmNyeWZjeHdWSDlCb0JlQ3J6c0YyVHZBZ2xtRmlYNENqWm1JWUV1VTNmNkhZ?=
 =?utf-8?B?Ny9sQjJVTHNDNW9mV25UZkxFV0pMb0pwMjZ5YzlVejFNMkxIbldvZlRqMTNS?=
 =?utf-8?B?ckswVTRiWFpzZmVnMDNSdlhNbjkyVXRTZkVsM1hLaitydzZmU2FZRzVZKzhz?=
 =?utf-8?B?L1dsRVNIOXJKVG15dmVBWFBjYkd3UU1xZXppYXF6bFBCVnpKSkkzOE5Bcjh6?=
 =?utf-8?B?T2ZkSzhTVjNzdDhGT3NMTWFJbFM1Q0tjNUYxdHd1bXQvUStXN3FPdWZFVDVY?=
 =?utf-8?B?aUVhYmQ4MFQ4aVNZYmdOaGZwSm9ISWdINmI0cExkZVVYMDJaRXVXY0FPNFNV?=
 =?utf-8?B?dEF4VXZpbjJaTkZuNE1OTmhpSndLK0VmYUNXdFByTHd0SnA4S2w4em4yaDRs?=
 =?utf-8?B?a2c5bnFaTi9DL2h0Zk5rQnB3MG44dTVFeHBkZitSelBkUE1aSWRaL2Erdkhp?=
 =?utf-8?B?bTJ0eTJjc21hREZiK3hBcXJaWVA5NmltMC9KZDJac1VSNFlIMHFiRkUxMGVr?=
 =?utf-8?B?M2M1RENsOWJNaE9KVmZraVFrTW1JbUNVWlB5c2YyTE9jazRaOG42TWwzdTVQ?=
 =?utf-8?B?UmRHSkVjN05sZFZ4R1FpeGRZUDZOSTU5WGFrNzlUZksxM3NtS3RkOFpRV0Z5?=
 =?utf-8?B?SXFxSFRJMWZ0cGV3WndTQUliOGdSc2szdWxGdnBSa2ErcjAwZjM0bzIydjlC?=
 =?utf-8?B?WjMrT1FodUJQem54eW5RQ3RiYWk3UHBXd3pkbUl4VElGb094WUh6VzJnMUhx?=
 =?utf-8?B?azZ1VitVR2ZpZDZwVXJpOVQ3aTArRVRMSU9BTmp5SjQ0d1h5SnhMWlYxNXQv?=
 =?utf-8?B?aGkzbFpnWC9aN2Z3MklJWUJvY2lnYWV4cmJmT05id3NtaDVQUC94TG9ITGM0?=
 =?utf-8?B?bndua1lVcXpoK0hKQVdyOGQ4alo1bDIwL3NpYXc3YW1Ganlpd2hKWHNZWVFs?=
 =?utf-8?B?aTBYTVhTOVR4elh4MmRaYzRMVXNWNUNJTU82dFRQU1FaaTBzT2U3SXc2Rng4?=
 =?utf-8?B?NDViY0tRRDlpbEhQOC9ySXBuMWYyZ1NwTHhxMWFoTlM4WlJLNUYzdVFiU1o4?=
 =?utf-8?B?MUFnVm0wVzA3aUJaVlZNOUI4TmppaWdqQXJmOU9qd0VmNW9LMGdLVndmZ0M3?=
 =?utf-8?B?QmFSbzZqN0dSbGZUUW5aTUhOL2IvaWRpNkZOOEhIaXZUd1hzck9VSElEQWJU?=
 =?utf-8?B?UURmZTd2WUEyMEwzbTlEZEdTeW1xTU1xWlhZVlRRWCtTejRFYVpmVFhpTlVG?=
 =?utf-8?B?NWd4NTg4RmY0V2lsMWhXWDVDWnB4TTNCYTlLVi9paXJEa2dZMUtHb3lCMURy?=
 =?utf-8?B?d1BrUmx5MXVBa1lQVExBNHJBVHFZbXYvSWhGdktDcllZUG5mOHJmVjNzMGpj?=
 =?utf-8?B?UHlnOE13NmRISld0bnI4NTVsWDA4TC9Oa0s0dFRiNGx2UmFVbjVkY2V1UGlJ?=
 =?utf-8?B?MXlJL0pSR2RpYUhPbUQ4dkhUSFRrNy8wYUcvbEZhSSsxOThiNDZLbU5PaFRp?=
 =?utf-8?B?OTBWUE5kSU44clRvOFB2cmRyVUNHcXVyVmdvSmt1WmU1SFJVU0lDVWtLNVI3?=
 =?utf-8?B?ZTA0MFA0MUVjYnFFQjRiOGRkMThXT2lzcUpLQ2xGbG85cmEyckYrZ2Z6Wmdy?=
 =?utf-8?Q?Nhl7BzSBJM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lzc25abEtMck9ybVU2RGtmSElJSWFtdXhKZWxwMXh3MW43TXNSdVJ3RG14?=
 =?utf-8?B?WThNc1QvS29kMnNQSFBsbU1EVkhuNGRJRFhFZ0VZL3Q0cUlpVVBMQkRMR2cy?=
 =?utf-8?B?ZzJKV05IY0pJMWFRbk5wb3dQZzBmTEtieUZ4RUJkZTFoWkEyZTd0eElDSUUw?=
 =?utf-8?B?SlRibEFLOU1NaGF5SjFwak5tTDFzM2JIYjdkK0sxZjFlRVlOZm5ZOWFFcnIv?=
 =?utf-8?B?eWlzKzEwT2M1Sko5cWdOYUh1T3ByUFA3VGRQR2dGREk2WEVCTFFMem13dTVO?=
 =?utf-8?B?UjEyNWp2UkhXSi9tSDNPTVRXSVU3YUM1RStPdnUvY2hrYlV5OGN6Y1R0SVJi?=
 =?utf-8?B?UUdMekNOcytnRW9GS1QxMlRFTDhpeEhhRmtzbmxFUW9MRGxpSitKdFJhV2Z4?=
 =?utf-8?B?VmlyL1VUYWlCUGkvS3g0T2s2L0JEZURUbEVuaUFpSjNUVDBsVzBNYVRlYWRE?=
 =?utf-8?B?ckNpekVzTS9CdmF0MXJ2NVl4KzhIeHZ3WGU5bzQ2SGhIY3ZYRGRBL3lIV1FG?=
 =?utf-8?B?R09weWRJWkw3d2NHSFB2SC9ONkQyWEMwME5KdkNUVG0vOXJFeXN4Znk3aXVV?=
 =?utf-8?B?b0ZSY2NvNnpzaVcvT2JOYm40THNDZVoxTGcwaE1acW1vWlRpZzJDMDFTdnZx?=
 =?utf-8?B?ZFBhNmhaUWE0VkkvenFvUXF1Q0FTYUlQb1ZqNkxGc3ZIZEd2Rk9VK2hVWGYz?=
 =?utf-8?B?bXRiNmUxWDVzM2NUWkdwN2UxQVNoUkQwb2ZwSG9wUlpnVndBMEcrSUpmNVJv?=
 =?utf-8?B?Um1ITnhhMmtNd2JsdXZiU0FlbTFKcnB6dGZQK3p5OHg4b01kYVdsaUVTU3Nx?=
 =?utf-8?B?VE5jbnZndUpkcFZEZjUwTFgwdWl0eUJKaTBKNkFJcEpST0x5bzJ1WC9qWFAx?=
 =?utf-8?B?cGFpQjROViszZ3FBUXlHL1htSHF2UHdaRmx4T21XOUlYRXNjMW0zengrd05w?=
 =?utf-8?B?VzZvbWh5YUFhOVhOMXc2SSs1YytwYWZNS0lhRkpqR3ZTVHkwdDZiYmdiSFhq?=
 =?utf-8?B?Ukl2cHNQVXJ0Q2dCc2VQbkxPbGlFTXIxdzBBMGhac0FReTl5WHB6WnI2V3h4?=
 =?utf-8?B?dXhjdWJXcWtoMmt5bEd4cmN4UnNSTlNuNlpBd1FlbFVFMU1LaXo5bEdWMkZC?=
 =?utf-8?B?dEVINDBlZkRSa2RPZDFZYzJYWThSVmQ1blZwVmdJelVScDZyanJEcFBYQUVG?=
 =?utf-8?B?TVNZSlRRb1ZZN0pzSGtOLy9Jbkxqbk9sWXJsaytkeDFlcFQ5MTU2c0drZmkx?=
 =?utf-8?B?dnBSSDFtblFoRVpYTzJqdnZTTzRwT2ZPdlIxcHUzNXloVlViQ0tLK2VMOVB6?=
 =?utf-8?B?bHFqeitEbTFzRHVuSGdzMFV3NTVLZTk1eGhmME15di9UOFlPK1IrYkgzYWNh?=
 =?utf-8?B?dUZFUENrWEVpZllTNEkwWlhHeVNWMGVBL0RuOVF0UmlJelZRMURTK2I3cDNI?=
 =?utf-8?B?cUo4TmhKMEZTU0prVEhlZmFPektDTDdmcHBpam1uaVgyamtpZm9aWGRWcnls?=
 =?utf-8?B?dmNZdzRtc2VTbU9aSnRYWC8wcy9oN3kwRkprT1ZwcDhQUjI4Z1R4OGRpVWs4?=
 =?utf-8?B?Q0hXdTdqUDdyMnJoazliZ3pRT2NCd0pMdWJKMld1U1h3WjhhczVIcjM1V2FB?=
 =?utf-8?B?WjVNbHJ6c0NFdlNqdE1tL2pOeVgwa2ljbDMrVEJhQ0FSRnFGd3hKQVVIVzEr?=
 =?utf-8?B?TzdLSTF0VzAzcm9EM3FsUXdHYWxka0tOTWoyV2NTTWZDL3FGcjdnNkQ0V1F6?=
 =?utf-8?B?bkJ3TDZ0aDZaSzgrOUpDbDl1S2tZTDFQZHRmclAvRnVkaHdZc1ZoZUREc25B?=
 =?utf-8?B?alhydDlOWmtxVUNEampVMWZUak1HU3RiQW9GOGNFTUtqeVBKOTJENldLZ0pO?=
 =?utf-8?B?NFdCalVyRVFzeE5zOTFVQnlkSlJkdlViNDYvTHA5eWJzcXdwRXJXaVdIWWk4?=
 =?utf-8?B?enJuNjd1NnhFVmlsL3RGUnl1NjBhVmczSG9POFE4UkNyclB5Y0Rnc0s0cTZy?=
 =?utf-8?B?SXljK2NNRWRPMFA1UVlQZHR1bldTZm05V0krTnZnci82N2NxbmdVNldZZHd0?=
 =?utf-8?B?MFBiRXl0VHVXRS93SyttUUY1OGw4NGJIZ3FITDhMQ2lTNHJkNXUyZytYTmd1?=
 =?utf-8?Q?HPdY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517c971-0c65-4af6-7d38-08dd9e2cac27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 21:14:46.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7uyG82M9z+y2+PjJ9bgtddAhkS9VBAMb4domJRFiNgfJ6sr1gFZv+x5Q+2lrf9j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

--------------4JpfwWr5colXG9Zr6JXCB1aZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/28/2025 1:19 AM, Deng, Emily wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Deng, Emily
> *Sent:* Monday, May 26, 2025 9:51 AM
> *To:* Chen, Xiaogang <Xiaogang.Chen@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Subject:* RE: [PATCH v2] drm/ttm: Should to return the evict error
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Friday, May 23, 2025 6:27 AM
> *To:* Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH v2] drm/ttm: Should to return the evict error
>
> On 5/21/2025 9:42 PM, Deng, Emily wrote:
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     Ping......
>
>     Emily Deng
>
>     Best Wishes
>
>         -----Original Message-----
>
>         From: Emily Deng<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>
>         Sent: Wednesday, May 21, 2025 11:57 AM
>
>         To:amd-gfx@lists.freedesktop.org
>
>         Cc: Deng, Emily<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>
>         Subject: [PATCH v2] drm/ttm: Should to return the evict error
>
>         For the evict fail case, the evict error should be returned.
>
>         v2: Consider ENOENT case.
>
>         Signed-off-by: Emily Deng<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>
>         ---
>
>         drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----
>
>         1 file changed, 4 insertions(+), 4 deletions(-)
>
>         diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
>
>         index 097716bd248a..abf104ae9d35 100644
>
>         --- a/drivers/gpu/drm/ttm/ttm_resource.c
>
>         +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>
>         @@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device
>
>         *bdev,
>
>                        .force_alloc = true
>
>                };
>
>                struct dma_fence *fence;
>
>         -      int ret;
>
>         +      int ret, evict_ret = 0;
>
>                do {
>
>         -              ret = ttm_bo_evict_first(bdev, man, &ctx);
>
>         +              evict_ret = ttm_bo_evict_first(bdev, man, &ctx);
>
>                        cond_resched();
>
>         -      } while (!ret);
>
>         +      } while (!evict_ret);
>
>                spin_lock(&man->move_lock);
>
>                fence = dma_fence_get(man->move);
>
>         @@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>
>                                return ret;
>
>                }
>
>         -      return 0;
>
>         +      return (evict_ret == -ENOENT) ? 0 : evict_ret;
>
>         }
>
> Can you explain why you care ENOENT(No such file or directory) 
> specifically?
>
> Regards
>
> Xiaogang
>
> For ENOENT, it simply means the resource or file doesn't exist—it 
> doesn't indicate an error during eviction. We only need to focus on 
> actual eviction-related errors.
>
I think I know what you mean. But I have a different view on that. 
ttm_resource_manager_evict_all release all resources associated with a 
ttm_resource_manager(man). It is part of memory manager cleanup 
sequence. Even it fail(no matter what reason is) I think the following 
memory manager cleanup should still continue going, then the returned 
error value should not be used to stop following clean up.

I think @Christian König can give judgment on it.

Regards

Xiaogang

> Emily Deng
>
> Best Wishes
>
>         EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>
>         --
>
>         2.34.1
>
--------------4JpfwWr5colXG9Zr6JXCB1aZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/28/2025 1:19 AM, Deng, Emily
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB54178912FD347C37BF8915388F67A@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    amd-gfx
                    <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                    <b>On Behalf Of </b>Deng, Emily<br>
                    <b>Sent:</b> Monday, May 26, 2025 9:51 AM<br>
                    <b>To:</b> Chen, Xiaogang
                    <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> RE: [PATCH v2] drm/ttm: Should to
                    return the evict error<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                  Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
                      <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xiaogang.Chen@amd.com</a>&gt;
                          <br>
                          <b>Sent:</b> Friday, May 23, 2025 6:27 AM<br>
                          <b>To:</b> Deng, Emily &lt;<a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Emily.Deng@amd.com</a>&gt;;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                          <b>Subject:</b> Re: [PATCH v2] drm/ttm: Should
                          to return the evict error<o:p></o:p></span></p>
                    </div>
                  </div>
                  <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                  <p><o:p>&nbsp;</o:p></p>
                  <div>
                    <p class="MsoNormal">On 5/21/2025 9:42 PM, Deng,
                      Emily wrote:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>Ping......<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>Emily Deng<o:p></o:p></pre>
                    <pre>Best Wishes<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <pre>-----Original Message-----<o:p></o:p></pre>
                      <pre>From: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>Sent: Wednesday, May 21, 2025 11:57 AM<o:p></o:p></pre>
                      <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                      <pre>Cc: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>Subject: [PATCH v2] drm/ttm: Should to return the evict error<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>For the evict fail case, the evict error should be returned.<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>v2: Consider ENOENT case.<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                      <pre>---<o:p></o:p></pre>
                      <pre>drivers/gpu/drm/ttm/ttm_resource.c | 8 ++++----<o:p></o:p></pre>
                      <pre>1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c<o:p></o:p></pre>
                      <pre>index 097716bd248a..abf104ae9d35 100644<o:p></o:p></pre>
                      <pre>--- a/drivers/gpu/drm/ttm/ttm_resource.c<o:p></o:p></pre>
                      <pre>+++ b/drivers/gpu/drm/ttm/ttm_resource.c<o:p></o:p></pre>
                      <pre>@@ -511,12 +511,12 @@ int ttm_resource_manager_evict_all(struct ttm_device<o:p></o:p></pre>
                      <pre>*bdev,<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_alloc = true<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, evict_ret = 0;<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = ttm_bo_evict_first(bdev, man, &amp;ctx);<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evict_ret = ttm_bo_evict_first(bdev, man, &amp;ctx);<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cond_resched();<o:p></o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (!ret);<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (!evict_ret);<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;man-&gt;move_lock);<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence = dma_fence_get(man-&gt;move);<o:p></o:p></pre>
                      <pre>@@ -529,7 +529,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></pre>
                      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                      <pre><o:p>&nbsp;</o:p></pre>
                      <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></pre>
                      <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (evict_ret == -ENOENT) ? 0 : evict_ret;<o:p></o:p></pre>
                      <pre>}<o:p></o:p></pre>
                    </blockquote>
                  </blockquote>
                  <p>Can you explain why you care ENOENT(No such file or
                    directory) specifically?<o:p></o:p></p>
                  <p>Regards<o:p></o:p></p>
                  <p>Xiaogang<o:p></o:p></p>
                  <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">For
                      ENOENT, it simply means the resource or file
                      doesn't exist—it doesn't indicate an error during
                      eviction. We only need to focus on actual
                      eviction-related errors.</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I think I know what you mean. But I have a different view on
      that. ttm_resource_manager_evict_all release all resources
      associated with a ttm_resource_manager(man). It is part of memory
      manager cleanup sequence. Even it fail(no matter what reason is) I
      think the following memory manager cleanup should still continue
      going, then the returned error value should not be used to stop
      following clean up.</p>
    <p>I think @Christian König can give judgment on it.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB54178912FD347C37BF8915388F67A@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
            <div>
              <div>
                <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
                  <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily Deng<o:p></o:p></span></p>
                  <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best Wishes<o:p></o:p></span></p>
                </div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>EXPORT_SYMBOL(ttm_resource_manager_evict_all);<o:p></o:p></pre>
                    <pre><o:p>&nbsp;</o:p></pre>
                    <pre>--<o:p></o:p></pre>
                    <pre>2.34.1<o:p></o:p></pre>
                  </blockquote>
                  <pre><o:p>&nbsp;</o:p></pre>
                </blockquote>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------4JpfwWr5colXG9Zr6JXCB1aZ--
