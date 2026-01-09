Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B825D277C1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 23:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB2610E0BA;
	Fri,  9 Jan 2026 23:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XK3woA3D";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA8710E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 23:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je9U3GsK3/RZ6fhjK56a2Ce3HHwS5pDFkL78eAVhdL3QqdRPt+lflRaRTLcafejFWzq5K/x1fDocRvkzINsOrGlIMJkxJLZjwdszxXnYEgHFkqMkBTImwVFT4nXXK5QkDMuMiFdLaEOCPHRaMz7JhmM3zFvbkz0XH0kttvrU7gSVBrtmpf/EJP00ROVgdBdydKphsu7XrF3KhH2FEfeT8imyky6GjvhG8CbaAcI0AT71xoV/F5Xlswbsum4HzsquATRRyElsHacJV00zL0gUJM1L36ShJuL4pIiRLSedeEXk8BlnxRnoRKLxSgqMC4UcN5vMcUGVF+UtSWpddUkS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeWgbEYeaj40rcObOaxOWr4AL/LKkrdoEXbgW9hPEo8=;
 b=INoBMTwWGHPVkAhAOC0kVXys5pR+mAPEEHfwRXCsfQi1w9ir7D4p+FCs4qYMyuQkgTps9Kxu0LPJtkGGXaiITWPeq9EUo6maZnRtZWMu1wcxgKJ+Q3t1akQiE1b861osDJGtMi4QlRexf2ZlrixPqRF3Q14W0fk3gXEeGgJ5x38C2Iw9mB62rbVkO9NHaRUQ1Sk7hn9Gjpjr1qBzBOElpjgWKd8Clr0Q9Mkam7tAm2LwAXMWWWhyOUwi9mimdutcH1CyopoSzrvYMg5b9MEX2eUZiOkS/PsZLAukndOWIdyPaz0ywRmsnLGafwo5mKYdTt2FcRnf7BQEJsTETuDdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeWgbEYeaj40rcObOaxOWr4AL/LKkrdoEXbgW9hPEo8=;
 b=XK3woA3Dbh4CMd7BZCGXDWdADxfU30xzjOKeeALOmKUsaAjvSgXXXPOlZeENjlYMw6MCqtMzZWpZl6rYKIv5YuvbihO5OlzWUPiP4ZMr3v4HmoFMBzOUDR8zHDcmvgaa9kz6tMUrjHWcF5V4/mVCNd50PkzuaU59m995xekb7Rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MW6PR12MB8915.namprd12.prod.outlook.com (2603:10b6:303:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 23:19:29 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9499.005; Fri, 9 Jan 2026
 23:19:29 +0000
Message-ID: <b755d8e8-e314-49c7-be0a-ef3ee69bbaf7@amd.com>
Date: Fri, 9 Jan 2026 18:19:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com, kent.russell@amd.com,
 jay.cornwall@amd.com
References: <20260107192341.3521748-1-Philip.Yang@amd.com>
 <20260107192341.3521748-3-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260107192341.3521748-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::32)
 To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MW6PR12MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe51c0c-ba13-459f-3efe-08de4fd589b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmFUb25HNWgreTFySDRvblpkRDlnTkpzZHVnMm12dHlLZzNZVHhjc3NKanlG?=
 =?utf-8?B?bG5QUFFCeWpXSmllclNkS25zV2x2YUJmVnVHbStVMHZrUUJQTnBucFd0cStE?=
 =?utf-8?B?ajRvamRlOEVQRTBBY3JBNG44Z0hMOVQ2bWM2c0RLV1poR3JEVCtJSFNnYXJa?=
 =?utf-8?B?RTJRVjE2Uk1Rd08xanMxYk5DbU1JcVpvdlpaeGpjSnNHTkh5d0V6ZTFZb1hp?=
 =?utf-8?B?cmgzZFVtdGl4WFdTcy93RHh0NkduMWlJQ0hxV1R1cjhjaVU5SFhUdjZzWUpl?=
 =?utf-8?B?dEQ4V3oyTE9mbDhFN1VzbWJtandmZ1Jtc0EwNnNpTnV5SHl2Zk9XN2gybU4w?=
 =?utf-8?B?RkUzOEFQM1NuNjA4UUZXZGo3RmovY3RQdHJ0UnFqZGY2aXNQWjFiRXhXSmhB?=
 =?utf-8?B?cCtORDZFYWFlS0ozZURVUEMrakJtU1lpTzlvYXNBSjFUcVdFZUU2VDB3L3FM?=
 =?utf-8?B?MDBwWDZuNXBGNnVVZUNOaVo3WjIreWsxRmUvTlB5a3JPdWlwVzhxSUZJVytj?=
 =?utf-8?B?aGlscFZEaVpqYjhOT0lHelZ2cHZGVGFlcWc0UERwYm15YS9ZU245Q3k2eHM2?=
 =?utf-8?B?RFlBb3hZZkhwdWVoVjhzVndhT21JZE5TQ0hRWlNCMXg4WjNHeU1jclROZXhY?=
 =?utf-8?B?U25kMXBIOHdLL055U3pNdGRjL0RYSzd2MGlzeHptajNDMVFSSTd5TERkRWx3?=
 =?utf-8?B?bnVtZ1NIb2RhTEwzdXBoNmJNanBGR1JZYzhzU0dacUd6VFkwYjhUT1YvN2tr?=
 =?utf-8?B?STA2dmpIOXBKSEh5bHIrUFYwY3A0RitsY3ZLSzV0eEIxc1ZWcmFtd0VsOFFl?=
 =?utf-8?B?dnFOZmVoV0MrZlRTN0NLeVhoc0JpRjBTSWYyQUJNU1d0TlNhM1p5Q083cDVm?=
 =?utf-8?B?OENGbjdYc283cWtQTHBMaDY4OEZyUFJQeWVVZTFkVWROcXpwSnZTRldFZDJE?=
 =?utf-8?B?QnhOSzNwaHkrTnNsUEFadUQwNmFUOTNRSkFEek4vMHM4MEdPZEs4MWJxalEw?=
 =?utf-8?B?amQwS2FvM1hubS9wVnlOY0NZdlRGczFhY1pXQ0wrcU9LdkpML1pCdStPajRj?=
 =?utf-8?B?c0NSVjM4WW5lZVZ6WC9uRFZTVWI5MG5OY0Y2Yy9RN04xZ1V1RWJlbllMRU9H?=
 =?utf-8?B?czJJVjU0N0NSemNvRUYwS2dhNExyVk1Gd3BqTERMem90S013c0RqRlBwSk5B?=
 =?utf-8?B?Ry90SWgrbWhpOXVNTWlLUjliODJieUJUVzJ3eHkyZFF2dnZhZUQ5QUlGRnhN?=
 =?utf-8?B?QVlQV0xjZktmOVB4M2Y0a2ZhZkdibTRXMjVvd1FMSDBSc1ovbWJjcTFkYW9T?=
 =?utf-8?B?NEVHbDR2VDRBbTJPUEo5RFFHK0hydGora05YUlBIZkxQbXM2bTY2WFZzYmdN?=
 =?utf-8?B?N3RsMkdpV29sQ1JSc003eDd6ZGZDbGFOc1p1aGRSZVdaVHZGdGt2RWpXVVlG?=
 =?utf-8?B?WU85RngwT0p5YVdxcndPc0JUNWJUKzBoWDlsdlBmUHF2ZzNHcExXdzg4dndY?=
 =?utf-8?B?YWVlM2JnVlJsbEVwY2k0SnRHVWJ5bGIxMjZhNTBqVVNvdmgzRGg0Tk00R3Zl?=
 =?utf-8?B?SmlGU0hKUFl4QTBvbmdzUWplYU9Bc04zRTNSN2VHcGFpLzNuNXZ4cGJ3L3lT?=
 =?utf-8?B?ME43MzhYM3I2N3R3SUwvUnN2Q0RTS2JTSEgwZDJhL3dERGxPaUxYWDdlZHhJ?=
 =?utf-8?B?ZlVkOEQ5ZEIzR3R5MmxEaGU4SXZldWgrOHpvODZMWE5sNWM2cWd1cnZXazdB?=
 =?utf-8?B?cnNmcDhwVnJ0NGJCQUxsS25EODlWSWJYSGNlTXNDd1ZqMC9zYXVWOTQ2UlVq?=
 =?utf-8?B?SHFCVk96K3l0QVpFdjVJbDd2cHE2T1orQU1PSU1ZRjBDMjNCYmpuU1VlK0or?=
 =?utf-8?B?NHQxdFZBcy9GMk5kZG1hVmNHN2NJSVNwN1pHQVg5QTV1TTlZQWp3Y2pKdXln?=
 =?utf-8?Q?PwjUZ1WmfBdZ/P0uCCWDKm0ntG7xth+8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlMbWVBckRyV0FtbitqSXRQNWFoWHVscDI0eUg3VnFudWFoY2FnKy9RcmFP?=
 =?utf-8?B?UHhRdUIzbEllMloxMVkySi8wWGVNM2h4d2pQTXBzaWFzZThGTzlaU1R6aEhL?=
 =?utf-8?B?bmNkYm9NT0RZYTQ5N2hZZFpxQ0lpZE11SGVqY0t1OStUa0QrU3lCenJYZ1g1?=
 =?utf-8?B?VFlkY1BlbkRPajA0U0FsR1VPTWxoTXNPdFkwRmJKRk9KR0YvQW8rVWIzdUhN?=
 =?utf-8?B?amVrWlNTSmhpZUlyN2ptSnhrMldIdEJEK1NlRHBWRjFyZWNOdGJBcHBhQXV6?=
 =?utf-8?B?eFh0SjdYQUtLbnBnLzFuekNEYU5Fa3NEU0NZbU5iMUdGbkNGSEdpMmZDOEVF?=
 =?utf-8?B?d0VTVitzb0VBRmwwQkkrQ3h5eTFNTkUzM0hHWDBCcm5EeVJZNDBhUWt1SG1u?=
 =?utf-8?B?aytNVS95NFMyOFlDU0w3OGFsUXkwdUF5TksreElLMVpwWHpjOW1CL202U2Mx?=
 =?utf-8?B?MnJNOFNPbER1cUVBeDFFNUhOTUVRRmpOU2lqK3Y2U1IwRzMxTnNaQXNkcHZv?=
 =?utf-8?B?SHhPL1dhZWdOYkVZak5zSVpKbW1GdlJGbDd0bHo2bjBqK3ZKNHlCd0NRck9Y?=
 =?utf-8?B?ckk1K2ptaXhseFdEVjJqZ2M2MXc0Ky9ZYmJrM1lTQlh5dkdPdU11eWFDUFd0?=
 =?utf-8?B?VmtwekFmazNxaXJVWEFvZHpZVVZ1ditONEpDVTFESUlEbFR1OWExN3JTVm9M?=
 =?utf-8?B?eVlYeWY1bmR0eHBmMVdEbEhYK3c5RWJhQzNlR3QzMkYyc0djSEJhR1ZWTDF5?=
 =?utf-8?B?V3p4RjdJSkJyM2dwSXBJWFpUbGQ2N2VxT3M2UUNTSVRBSE5kd3JneVU5eUJt?=
 =?utf-8?B?dHBLbDlVYWdaNGlHeWZPc2Jmc1E5cWF5Y1A3a2c5UmVaNnZxUmk2aHhFQ1Q0?=
 =?utf-8?B?eDl1YWVMNnJwOTRPeVlNZjRIVURTSUVCbzdmVk5RQkMzaXRrZUVBRFJ2N3Er?=
 =?utf-8?B?NmlqSXBxS3Vzb2hpODZyY3JkNGZROEhxa0MrV2Y3Y0hPTy90UGZhR0VFK1BM?=
 =?utf-8?B?aUNSR3owZnJJckZGSW9Bc3ZpeDJyelhoZjJaZGpJdDRuNmZ4TWhPNnpBRGg1?=
 =?utf-8?B?K1ZVcWN4Y3NqWjMyb1VHdlR5NDMyKzRRWkpENnNKUitKYjFsLzhlTFErb3ZS?=
 =?utf-8?B?bWVQenZrMnpJbmpqWmM2NE00aFROYmZReGpXSkFWbFF6aG10VlJHRVpsTnQv?=
 =?utf-8?B?R2dRcyt2bE05V2dtNVU2ZFZDVVFNTC90NFZtQitkL0ZoNVVHTkxKUHk1dlAx?=
 =?utf-8?B?bkIyQzFTdVd3TWVYV2l4WUFidmpPYmpjRnhacUlDZXhuWXpCTFl4WktVeXF0?=
 =?utf-8?B?RkpLSGNVRkFJU29sSnU1TXpqTlpycEs0REJBa0NCOFV4blNIMTBhOFRmUnVO?=
 =?utf-8?B?Z0VhUEhVRzhhQmxmdWljUSs1MzFwcVpFUTh5djNTTkhWcWtrb3gwdEx4c0dn?=
 =?utf-8?B?UWNUZkEyUnJyZXRyYjBzYTdvWmltMDZ5cFBCakNpRDcyRUw0Z0FmVDFUSHoz?=
 =?utf-8?B?WmJsSjRpOSsrWG1Tc3Btd2R5cENrOEdGMVF5UkdtMUZHNkRDTWdkTzVuUHBm?=
 =?utf-8?B?WEZWT01sNE0rL0RaNE9zcFBCQkxtZlhyYnVQL29ZVVNyRFhoclBXRzA5R0FY?=
 =?utf-8?B?VW10Z2N0UmFSYlBlQ1NwN0E0YmRvQzhtbEM1bExSMVNvbDRZdW5hNkhMMENz?=
 =?utf-8?B?bTVEWTRRcHpxMkJ4SDVzbUo3MzFuMXB6Y1YrOWhOQmJXbDl3NFZkcWxycVV0?=
 =?utf-8?B?RnFzMDRGMC9Bb1R4TGh3U0cwVTRFNSs3ZWhHZ09CWFB2VUlvNjhTRGxQSDlX?=
 =?utf-8?B?ZVVWUENIaHVLN1Q2NWRpZVcvMVBRbXBWeEVha0FRak4vVS8wUXpUekptNWs2?=
 =?utf-8?B?QVdVUm9vajkvaTYzWDFiRHc0TGdrR0NyK3g3VG1ZbVpLWENXdUtWTGRyYjY4?=
 =?utf-8?B?RkQwR3BZTmpBemJUVlBmYmlEM2FJSkkyUWlhV0xMalNjQkFwaWVpRDlOazY0?=
 =?utf-8?B?UnBXUlhJeEl1cDRsNTU4ZkpXR254Y0YzK29kbG5WZmVGdEcyakVmbW1La1ZY?=
 =?utf-8?B?RlZSa1hzcnREVVpoUEFGYjl4cXQ2b3JWYW9pdjV0Y2VNMm5VTHFWRzI0TjhC?=
 =?utf-8?B?Z29xdkxJK1VOS0RIdnA4d01TSzhuVFBDVklsSG1aai9MNW5IN3V5REx0aDRF?=
 =?utf-8?B?RkVLUWVQbHpGd0RLVWFoQVYwRFFzenE5dE9KejUwV3Z3bzE2MU1URzJybG9n?=
 =?utf-8?B?c1d6eFp0WlE1Z1hVeU5na2IrYStVMTdJVnlWOC82Sms1cW5YVWowL3lwSUdU?=
 =?utf-8?B?eC82Rnkwcy8rekxkK1FCclRocXBEcUpobGo5WlZmTlM1dktvdTdDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe51c0c-ba13-459f-3efe-08de4fd589b2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 23:19:29.2269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnAMjuBJtcloM4dk2VRVMqT9n0R3Yofybqp0XXSbmn3u4DZeJQoRvZfpBpIDAPO0hQQLzNVC1owiezdM1tXjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8915
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

On 2026-01-07 14:23, Philip Yang wrote:
> To reduce queue switch latency further, move MQD to VRAM domain, CP
> access MQD and control stack via FB aperture, this requires contiguous
> pages.
>
> After MQD is initialized, updated or restored, flush HDP to guarantee
> the data is written to HBM and GPU cache is invalidated, then CP will
> read the new MQD.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Patches 1 and 2 are

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++++++++++++++-
>   2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 39c0b5a385c9..c1ffae9e96d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
>   	bp.size = size;
>   	bp.byte_align = PAGE_SIZE;
>   	bp.domain = domain;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index d234db138182..d867dccae675 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -109,6 +109,17 @@ static void set_priority(struct v9_mqd *m, struct queue_properties *q)
>   	m->cp_hqd_queue_priority = q->priority;
>   }
>   
> +static bool mqd_on_vram(struct amdgpu_device *adev)
> +{
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 5, 0):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   		struct queue_properties *q)
>   {
> @@ -139,7 +150,8 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>   			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>   			NUM_XCC(node->xcc_mask),
> -			AMDGPU_GEM_DOMAIN_GTT,
> +			mqd_on_vram(node->adev) ? AMDGPU_GEM_DOMAIN_VRAM :
> +						  AMDGPU_GEM_DOMAIN_GTT,
>   			&(mqd_mem_obj->mem),
>   			&(mqd_mem_obj->gpu_addr),
>   			(void *)&(mqd_mem_obj->cpu_ptr), true);
> @@ -739,6 +751,9 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   			*gart_addr = xcc_gart_addr;
>   		}
>   	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
>   
>   static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
> @@ -775,6 +790,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
>   		}
>   	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
>   
>   static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
> @@ -813,6 +831,9 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   					(uint8_t *)ctl_stack_src + xcc *  mqd_ctl_stack_size,
>   					mqd_ctl_stack_size);
>   	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   enum kfd_preempt_type type, unsigned int timeout,
