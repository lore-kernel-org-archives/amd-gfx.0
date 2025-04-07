Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31252C3601E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 13:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D4410E465;
	Mon,  7 Apr 2025 13:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMimBgdD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABC610E458
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 13:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu3zwFR5pGxZX5RCc4bQsEtzbFGM2vD8SGanFy1jkqnMZ9jzkUVmIPebP4iE+o2G+va3WKJSPZiT8WjaMr2kyMQT7T4PcQQ3RtU6haLDsSTUNMDciRvhGzqz7yKfFE8nhrtUFpZ9YXctbE10Nhdq9iuWOX2bfZmLI0YMxfbE4hxfIL34wKiBoRFt26MJPArszyWd5JsBKx5SSHOh8sZh5vB2fUN8Po5bvSErBiYxJFUc+fkBGzi3O5Sdula91crheRmGu2IRqxuty7XYDo7cKmwNPhMwNgBhhNphFKbVg/YnY75rxdM1Zf/9qss8aEXFmT1G8YArC8BBiSUc5uhfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noj6dGayZqOpPZoRL6Q1rGGrGrDTfVDBUbjr+C0e7QM=;
 b=ZnM96Pjxrfk7GxWUPPcbDUUyGHTbKMiAPql8XWDQ9zVkcFH0LU6jhn8cjErWj8co1xKV5w0aPz/s6Fpb03iRmo42VU9diCWtKzWZI8ZFaVFOy2IP4/pSGAt7GAWs7PX9n0lO10PgVGXrd0XBIxjap65H68Ve3k6bEqQh4ISWpgBFFDz5yNlffnUB81ZSNndDVHQ5Q7ZavcGU4k+8BS5cu0WAmWKFmB1+7/Jj2TeitMIzUdaiml/5zPZOPBlaoKLX+otUslA3jqHrD7ccwp/DvBlibBLpeKg5pRNPGrJ+QtFsgoSNIbUe+LDLKIejGmfM5gRd3FlVRsKHEaeCvckZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noj6dGayZqOpPZoRL6Q1rGGrGrDTfVDBUbjr+C0e7QM=;
 b=QMimBgdDG8ft/RTUGeVuonCfydfj5P1+gZmAUv88D8nWhhxYwxM8uIJFtyFi5bT+FeEikrPIeC0778SQNM+BMIJQMONcuhTpdt+Nrpuw9vhVYXD4yVd3THdnF+Qf7vHmZMdK+ruc3VImRvGfemso9CnppO+G7coBXwI/nv/Vscs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Mon, 7 Apr 2025 13:27:47 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 13:27:47 +0000
Content-Type: multipart/alternative;
 boundary="------------k7Ok86utOx14hyf7zS09u8et"
Message-ID: <119debd2-b6a0-4d7a-87ce-7b80486d95ee@amd.com>
Date: Mon, 7 Apr 2025 18:57:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: dump full CP packet header FIFOs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250320165634.1245798-1-alexander.deucher@amd.com>
 <CADnq5_O1TWAx9neJmNtAQ+kmn+85NHsfzoMr5P_fbz=ZRNpoHw@mail.gmail.com>
 <04635121-c8ca-42ba-a56b-20357702c929@amd.com>
 <CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: ad254fe3-ab4c-4293-d6b4-08dd75d7fcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVKdlM0VTJBeHNnWkRkekRNWDJPS0RYL1ZHcHZJNmloeXNXNWtQRjF1d2FO?=
 =?utf-8?B?djdyZVRXVGxhQ2YzWU1vZ3cxZjk2UkZ0YVRjeFI0aVM3blZsZEVkWWZPUVBi?=
 =?utf-8?B?YVdwdDdZbUlvOHg5UGx1REs3YnRDYzcwZkdLZittN3l3Kzc3ck02ZzE3Ni8w?=
 =?utf-8?B?b3dwY3BSdHhSVnJOZThMdFJzUk9XelNyYSt0MjRGR2VoQ0xVeTJJb3UxS01m?=
 =?utf-8?B?aTRteU5wWjczL2dENkI1NUdLdzNGYUdvVUw4OUg3ejFidklIWEhPTGgwazZZ?=
 =?utf-8?B?NnRrRDQ5YXNKYXRUSjFUZjlWMFhOZzdTaU5BRzBHVStwekVIbHljNEhRbkVM?=
 =?utf-8?B?bytFV3cvK3p2dzdLaUVCSm9iQkZtMEEyMzRRZ25kT3ZTQmFvUHgxcEpSR0Rz?=
 =?utf-8?B?YWg5MTljallkYlNQZTVqWGZKcGl6MnBFQ0F0QjFRY3BBZFZqZzFVYWVwV0FG?=
 =?utf-8?B?OXhQMWRQZlh2K2xFcTBwaThOK3FZK1NQVm5VTG04MGJzOVpnTk9BdjBqQUYv?=
 =?utf-8?B?akppaTBsRmRqZjdaYXJGSmo0cjhHQk1HVDYwV1M0Qi9OV1oxWUZ6MSthSURx?=
 =?utf-8?B?NGZhSWZjMTJWbmFRRzdwZGdDWnhoQlh5NmgydWplaENFbnhNZGUzcnF0R1VG?=
 =?utf-8?B?TkZ1SjNwNkxpQmlUY0dJNFlYblJBNHNkL0d2ZytWMFQ1Z0ZUbUIrSmJUWjZu?=
 =?utf-8?B?OTlaMTZTNUVrUXhOS3M5SytjbFZQQ0ZvOExCcDFid0RmazV3NExiKzVTU1NQ?=
 =?utf-8?B?UnVFSFg3WFphemtRdTFUZG5KVDMwa1hkZ0xTWHV4ek9vVGt0WWJaVmY2U0pn?=
 =?utf-8?B?djcyc25tWHhDUEluSXR3ZFBHK2ZERmJSMVFnWW12aU9yMVpBQWozSVR0dDhF?=
 =?utf-8?B?S3Vib1F6QStxWDhVSEJtTWl5VDNGOTVSVmw0U1ZQTzZwY2hQNGwxSnlPUE9m?=
 =?utf-8?B?VVh5b0ZVSGlBbFdPMGZWL1JFWGVra2xkeDlQbVA5dzVSNUh0K2dwMnNKZXpS?=
 =?utf-8?B?VXU0bGpmZG03UCtob1R2N1Jta0pGMWd1clQ1VFNEOGNMYlZrWVNBd0V3V0Mr?=
 =?utf-8?B?WGFuaEt4Tlc3eG1sdDdwZlI3OFNPMVRqS0dtVnIrQld6OWh2NmJaQkVBcjIz?=
 =?utf-8?B?VFRFVGdtMkI1N2lWOVJVdjAzOU5QZmxreTFmWUpPNDZuV0huQmxhanFWT2ZG?=
 =?utf-8?B?czJnRW9xaGNjMFZlMmQ0T2NudTJTdWxOTkt1RTNoemVnVGJ0REVYSGNtR20y?=
 =?utf-8?B?aEJDZHc0Smx3WkpKZEtxTHNFRWdmd2xRUTQwYXVLNEJGU2hhemMxRUtYOG44?=
 =?utf-8?B?aFExeGwyVGpHVXJFcFVQYkZQeVlqSnBxaGNDWWxCR0wxRllMNFNTVzFocEpv?=
 =?utf-8?B?VENoQXhnRk8xZUgyQjVmcHp6TGFxb09QWXZJYTgrT1dtd3VJOVFENXBZMTZt?=
 =?utf-8?B?b3FtSExXNG5FSlRYTEdKcjB3ajJqYklURTdhR05kTzRlVUFMNEpsRFcwZ2pI?=
 =?utf-8?B?Z0h5U1VBS3R6alhzY0ZkR3gvTWNLTG9sMVQvc0JGempIUGJUa2RoM3NpK3lo?=
 =?utf-8?B?T3JtS1BPRlowTk45bjVuekZ5WmJrcVlCTitZbEsvV0VWOXA0dFE4Nk5STnQy?=
 =?utf-8?B?aUw2SGlqQzIzcXNKUTY4Zm1FalE5amNpclh6Nm1yOUZ0aXZFVHZYSDBBMTdp?=
 =?utf-8?B?NVQ1alk4NmNyS0YzajZYRm1MdTlWb1FtU2tFLzRTbml6Z3ZTZXU1OXRsa2ow?=
 =?utf-8?B?b0xhWFFiNExudkhoRjMwUnRTbDBLRWRGbXJEZG1PeUlTa0w5TWszd3B0ZjB3?=
 =?utf-8?B?V25XMG52QzVmVlIxbzhBdDByNTRJckJKZnQ3RWtIZmtHaXZkL1l2MGl2VGtO?=
 =?utf-8?Q?lmHOT25h3gcNK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkFWTXpnbzYxZWdrWEF6eGlaSGIwT1EwenNMc3VKcC91bEVZMEJrK3dzZlJz?=
 =?utf-8?B?VEwwYmVPdFFjZE4xTkRlTEdjSkFZckZwMERWd2YyYzYzUmpwcGljaGtBalZS?=
 =?utf-8?B?ZC85R2lNL1kvUjVCRjJjYm8xRWFsQjNnaVUxTGNmcG5VQnh1M2wzNzlCKysy?=
 =?utf-8?B?K0oyeTBUdG44WXRXQTZ2WkZIc3oyU0hqNktDYUJkTURJU0ZYM3VURU8zVERH?=
 =?utf-8?B?bkdYVkk4QzNxVnpuUW55NTc3U2FNbFJGSUhmSDVsbyt0bG5CRlhOWXp3M291?=
 =?utf-8?B?NDZEUi8ybU5mYWovQXg0aFFOdncvRmxFUVpLUUw3UWhhQ3ZVSkhBMzdBdGp4?=
 =?utf-8?B?WStGejVXT1FmUXZHdEN6bzhMVzlrMGNKYnRiYk1NdUtpYlVieFNzdkFPTXl0?=
 =?utf-8?B?MzRpTXY5YWJNM3hSN2ozT3c3MDBOa0RTU2JQRVJUcU52ZTIzUTZsSUNnRjVz?=
 =?utf-8?B?Y1pXaGQvNlh0dHFhUzI2dlV6ajJrcHBKcXArRGRaSlhHMEtnbTY5dURyaDA1?=
 =?utf-8?B?RVlVSW4wZVFWaTdGLzk2SHhUWE1Lb2NVd2xYMVZOL0MzM2Fza3hPRmNCRkZS?=
 =?utf-8?B?aStFRlp6ckh0M1BmWXRFaXhyRWpwczVBeEU2VEw4bld0UTQrOVRtejJSNGpw?=
 =?utf-8?B?ZG9nUTBnUG5FOC81dWR2dTE2MVNYSHcxSFdERC9jUGZvczlLait0dyswcWk4?=
 =?utf-8?B?N0JqSjBXaEcxajZkUy9ZeFlyTnNqVW9RallSOCtuOU5YY0NSQ2RmZG1RbG9k?=
 =?utf-8?B?VXhpSXRBN1ZJVjBOV25BMnRmWjJKWUY0cENzK25JNVZmcXRuM2dHZnFLZzU2?=
 =?utf-8?B?ZXpSTzhGb3E4WGJ1MnpEbG50ekEwNUtjSVNNMHlRdjRZbFh2a2hEZll1akY3?=
 =?utf-8?B?ZEVFZnJlb1dhQmQ0NDF6d2s2RE1ESDNYVzVhN0NFWFVSMWxEbUpMRFpNNzBT?=
 =?utf-8?B?ZzVSVG0wVmhRMXYrVHhrYzVvNDRGM2xXZmRCTUxjSGF6Tmw5WTFxbjRxT0Nv?=
 =?utf-8?B?dDI0K0FYRVdYaGc0blErOFZRUzRBVGM0enhaNldPQUZBem0zcXBUeWZUUW01?=
 =?utf-8?B?bXpVZ0F4enRhb3h6RGdFcWJoSVhqaXBkNU9xWTQzT3FtOU5ubmhMTlVJRnV2?=
 =?utf-8?B?R0NsM1V3ZitWT0RNUkpIRVI4TlNMWTV0Z1AxR1crTi9xTXQ3QVp2aW1SNFpM?=
 =?utf-8?B?eG9vbC81aWhNR0drRWlHbDN1RFllMDNhVm96anI3MGdZQXFFOFZLTjc1Rm9W?=
 =?utf-8?B?Yk9GZ1I1MGxtUjRWcE5oQzZIcXdkbW5hYVNtVzY2QS9rY2N3bWJ5YWEyM2t3?=
 =?utf-8?B?ckFDMTRZaVBXN1BxK0RKNGlOVjNzUEZuRW1hRWRTSlU3aHFTcWcwQnNDOXpB?=
 =?utf-8?B?ZnU5T0F1ZFlKdXNVZUVNR2htemwrZmJyVVc5K0paQjVodTBZbnJwNmFEQUc1?=
 =?utf-8?B?a1JGY0ltNWFyU21icGw4K09EUk9Pd3lSTCtoNlhZcEpvb2J0UjVid1dqNjUw?=
 =?utf-8?B?ZEkzaG1LbnFkVXVpVGZBVUxxR0Zna1ZGZ080bWUvYndLQS9tT09MV1N3S0Nu?=
 =?utf-8?B?RlhyWENzRTl0ZlF3S05qbVlreURjcDF2Yk1kMmpvRzVTUEgrczlpVE9sd3hs?=
 =?utf-8?B?Y3R0OFdNdmo1eVJPZmRkUU1wSUhMbnM2YmRQYVc5ak5taGdQODFXOENPdEFm?=
 =?utf-8?B?TE5vNmxsTjAvcm1Xa2VBdjA5Smd1MjhUUGpBUU9QQy9IMTRYak80OGZoZDdi?=
 =?utf-8?B?d0NackFWNUxsTzZNY3hoTnpNc0tnNWpwVkxnRkZjb3RXWDF3eUQrQTRjQ1lC?=
 =?utf-8?B?SjV0Yi9aei9XM2JGUW11TERlL3I0SW9pYy96c0IxNDJtTzFGUks1UU1lY1Av?=
 =?utf-8?B?Ry9iZmpzZkRsNldwTERMZE93QXp3NzN0SE8rZ0VpSmh1ZU5YUi9HMHlycVA4?=
 =?utf-8?B?Yk9ZSm5sUmh4bUU5Njg4SnlsaEdUWC84Q09GMVhRUXBpc1B3QS9EY3pucnBI?=
 =?utf-8?B?NWY5Ujk3Zk5GTVRnbW1XZkE2YmMxTzlscXFTUU53V1VkekE3Q2pHS0s1ZmFl?=
 =?utf-8?B?M0tVOWJmZXNHY3J6T0RML1ByVGNickk0VVBpa000VU5CZUVjSmNxOWxOSTJn?=
 =?utf-8?Q?N4PUM+hbCxrTV7x3uaifLYiEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad254fe3-ab4c-4293-d6b4-08dd75d7fcc3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:27:47.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7GydTe7+zpDmY7z9ito9nwQ7SJjFG2pKdub1DwsPJWHub8rHHHHPjvWIEfP0/dUumrV5yUWOoSkyyrqp3BBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
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

--------------k7Ok86utOx14hyf7zS09u8et
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/7/2025 6:26 PM, Alex Deucher wrote:
> On Mon, Apr 7, 2025 at 6:14 AM Khatri, Sunil<sukhatri@amd.com> wrote:
>>
>> On 3/25/2025 1:18 AM, Alex Deucher wrote:
>>
>> ping on this series?
>>
>> Alex
>>
>> On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>>
>> In dev core dump, dump the full header fifo for
>> each queue. Each FIFO has 8 entries.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index f4dfa1418b740..64342160ff7d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
>> -       /* cp header registers */
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>>          /* SE status registers */
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>> +       /* packet headers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>>
>> Reading this register in a loop will give value of each queue or we are reading same register again and again ?
> The register is an accessor for the header FIFO in the queue hardware.
> The FIFO is 8 entries deep so if you read the register 8 times, you
> can dump the full FIFO.
>
> Thanks for this information. I was kind of thinking the same but dint know it works directly and need not to change the way we read like setting grbm etc.
>
>> for (i = 0; i < reg_count; i++)
>>                  adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i])); With above loop arent we reading same offset again for
>>
>> mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times. How are we making sure we are reading from different queues ?
> The me/pipes/queues are indexed via soc15_grbm_select().
>
> Alex
>
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
>>   };
>>
>>   static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>> @@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
>>   };
>>
>>   enum ta_ras_gfx_subblock {
>> @@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
>>                          for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>>                                  drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       drm_printf(p, "%-50s \t 0x%08x\n",
>> -                                                  gc_cp_reg_list_9[reg].reg_name,
>> -                                                  adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          "mmCP_MEC_ME2_HEADER_DUMP",
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>> +                                       else
>> +                                               drm_printf(p, "%-50s \t 0x%08x\n",
>> +                                                          gc_cp_reg_list_9[reg].reg_name,
>> +                                                          adev->gfx.ip_dump_compute_queues[index + reg]);
>>                                  }
>>                                  index += reg_count;
>>                          }
>> @@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
>>                                  soc15_grbm_select(adev, 1 + i, j, k, 0, 0);
>>
>>                                  for (reg = 0; reg < reg_count; reg++) {
>> -                                       adev->gfx.ip_dump_compute_queues[index + reg] =
>> -                                               RREG32(SOC15_REG_ENTRY_OFFSET(
>> -                                                       gc_cp_reg_list_9[reg]));
>> +                                       if (i && gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
>> +                                       else
>> +                                               adev->gfx.ip_dump_compute_queues[index + reg] =
>> +                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
>> +                                                                      gc_cp_reg_list_9[reg]));
>>
>> When value of (i != 0), arent we reading same register i.e mmCP_MEC_ME1_HEADER_DUMP 8 times, how are we making sure when we read it again its reading for another queue ?
>>
>> Regards
>> Sunil Khatri
I am assuming here also same explanation applies that when we read the 
same register again we are getting the next value in the queue but why 
use this value of offset mmCP_MEC_ME1_HEADER_DUMP but read the register 
mmCP_MEC_ME2_HEADER_DUMP ??


For i=0, we are dumping mmCP_MEC_ME2_HEADER_DUMP but for value of i >0 
we are dumping mmCP_MEC_ME1_HEADER_DUMP ? Is that because 
mmCP_MEC_ME1_HEADER_DUMP belongs to MEC1 i.e for mec0 and for i > 0 i.e 
MEC2 we need to read mmCP_MEC_ME2_HEADER_DUMP ?

>>
>>                                  }
>>                                  index += reg_count;
>>                          }
>> --
>> 2.49.0
>>
--------------k7Ok86utOx14hyf7zS09u8et
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/7/2025 6:26 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, Apr 7, 2025 at 6:14 AM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 3/25/2025 1:18 AM, Alex Deucher wrote:

ping on this series?

Alex

On Thu, Mar 20, 2025 at 12:57 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:

In dev core dump, dump the full header fifo for
each queue. Each FIFO has 8 entries.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 62 +++++++++++++++++++++------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f4dfa1418b740..64342160ff7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -225,17 +225,36 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] = {
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
        SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
-       /* cp header registers */
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
-       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
        /* SE status registers */
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
        SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
-       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
+       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
+       /* packet headers */
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),

Reading this register in a loop will give value of each queue or we are reading same register again and again ?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The register is an accessor for the header FIFO in the queue hardware.
The FIFO is 8 entries deep so if you read the register 8 times, you
can dump the full FIFO.

Thanks for this information. I was kind of thinking the same but dint know it works directly and need not to change the way we read like setting grbm etc. 

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">for (i = 0; i &lt; reg_count; i++)
                adev-&gt;gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_9[i])); With above loop arent we reading same offset again for

mmCP_CE_HEADER_DUMP,mmCP_PFP_HEADER_DUMP and mmCP_ME_HEADER_DUMP 8 times. How are we making sure we are reading from different queues ?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The me/pipes/queues are indexed via soc15_grbm_select().

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP)
 };

 static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
@@ -277,6 +296,14 @@ static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_9[] = {
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GFX_STATUS),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
+       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP)
 };

 enum ta_ras_gfx_subblock {
@@ -7340,9 +7367,14 @@ static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer
                        for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
                                drm_printf(p, &quot;\nmec %d, pipe %d, queue %d\n&quot;, i, j, k);
                                for (reg = 0; reg &lt; reg_count; reg++) {
-                                       drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
-                                                  gc_cp_reg_list_9[reg].reg_name,
-                                                  adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
+                                       if (i &amp;&amp; gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+                                               drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                                          &quot;mmCP_MEC_ME2_HEADER_DUMP&quot;,
+                                                          adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
+                                       else
+                                               drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+                                                          gc_cp_reg_list_9[reg].reg_name,
+                                                          adev-&gt;gfx.ip_dump_compute_queues[index + reg]);
                                }
                                index += reg_count;
                        }
@@ -7379,9 +7411,13 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
                                soc15_grbm_select(adev, 1 + i, j, k, 0, 0);

                                for (reg = 0; reg &lt; reg_count; reg++) {
-                                       adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
-                                               RREG32(SOC15_REG_ENTRY_OFFSET(
-                                                       gc_cp_reg_list_9[reg]));
+                                       if (i &amp;&amp; gc_cp_reg_list_9[reg].reg_offset == mmCP_MEC_ME1_HEADER_DUMP)
+                                               adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
+                                                       RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME2_HEADER_DUMP));
+                                       else
+                                               adev-&gt;gfx.ip_dump_compute_queues[index + reg] =
+                                                       RREG32(SOC15_REG_ENTRY_OFFSET(
+                                                                      gc_cp_reg_list_9[reg]));

When value of (i != 0), arent we reading same register i.e mmCP_MEC_ME1_HEADER_DUMP 8 times, how are we making sure when we read it again its reading for another queue ?

Regards
Sunil Khatri</pre>
      </blockquote>
    </blockquote>
    I am assuming here also same explanation applies that when we read
    the same register again we are getting the next value in the queue
    but why use this value <span style="white-space: pre-wrap">of offset mmCP_MEC_ME1_HEADER_DUMP but read the register  </span><span style="white-space: pre-wrap">mmCP_MEC_ME2_HEADER_DUMP ??
</span>
    <p><br>
    </p>
    <p>For i=0, we are dumping <span style="white-space: pre-wrap">mmCP_MEC_ME2_HEADER_DUMP but for value of i &gt;0 we are dumping </span><span style="white-space: pre-wrap">mmCP_MEC_ME1_HEADER_DUMP ? 

Is that  because </span><span style="white-space: pre-wrap">mmCP_MEC_ME1_HEADER_DUMP belongs to MEC1 i.e for mec0 and for i &gt; 0 i.e MEC2 we need to read </span><span style="white-space: pre-wrap">mmCP_MEC_ME2_HEADER_DUMP ?</span></p>
    <blockquote type="cite" cite="mid:CADnq5_OZCnYtfMPKN1CH4nDLEJsfpQvnSxLPJE=EjH9C=N_vJA@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

                                }
                                index += reg_count;
                        }
--
2.49.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------k7Ok86utOx14hyf7zS09u8et--
