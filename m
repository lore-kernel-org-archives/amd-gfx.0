Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0823C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 07:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C6510E70A;
	Wed, 12 Mar 2025 07:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OkSXXLgf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EB410E70A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 07:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+yUsWOvZZD0MPEdoHK4pWZZrMuuhDHkCWXiuORO53KBcaTfp9+/GSuHb9QyeRUuOLVL4xrAw3k4mkypK6cNAOlpyxhQdQrE5MRr9LUnUITqI4ktmEHBlACkyVpSYsqsb0udKSFRo/NYC4kRlXIKQPhKrylKcBVFjCQ9rw49Irwhylo+wcgOq2aXevdKjF1lGDDcvu+YKvT8humW9kzdh2qWkIkEuxRQv+31pYaVSdWIgB5dLsMephW4Z8AGP5QMnZHEBJ3YQlcs4Rwd+RxzwKPb2bLZJtod3VY/HeCu3z0lvO8TsVWMnI4vuIS4bCfuoT4iL6/ik/9+kSRVlAEEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ywvs09csPCdIYdQfsW3xfTr4ypvHyOi/Kvyn4UX7QE=;
 b=PLePw/oxs1u3GEGE6ErqKLUd3NNrbUREzBRzA7N0ElKPyZzi2FnyqmTDC/k92IHDXVSW5xtJ88Z3yhR8Soy98GUSLaIpsCW+YjwiHL0bRoFczmW91srYHwzQGFyLV5aS9jgLsZxsnAudsNR1gkoSRhawS8/Zn8xyKfmQ8pWgMhdwvaBi68il2EYYp0bL1pHO+cVYU5VyCpd02yLRvwZ9tRn9Ypvuvs4ldoXDrJF4PgU3tUa032PqMZTe5wERh+XB0z25TiA+n4j/I+x3ajKmXbsrbPf6lkn5EkfYBInp4+EGiiYbmaRBBKQOP46YPUkOqJ/suyEp8h77yJrldMVsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ywvs09csPCdIYdQfsW3xfTr4ypvHyOi/Kvyn4UX7QE=;
 b=OkSXXLgfMPsDseZcnl5k59M3MfJAVcRpNefruay4XuMDfTR9EKOZd4UfoByDOwrW30Jrnxiz+mu+pJFE4LcpcxfvxV6QAxtSsmN6Rc4ZKcrkFuTJ6GPdRG9f+RfSG8lEuZLgbK7Dzt836y7ub0hbvilanrhDDDGMLFJET6DgX5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 07:39:46 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:39:46 +0000
Content-Type: multipart/alternative;
 boundary="------------yS9Sm5Fd8DSVUIW8WX9TVuGh"
Message-ID: <22e95ef0-4b07-41a6-b1c9-a5cd123a49e2@amd.com>
Date: Wed, 12 Mar 2025 15:39:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereferences in
 dm_update_crtc_state()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Roman Li <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20250312023409.2687233-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: TPYP295CA0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::7)
 To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 12208e95-e2c4-4f3c-b215-08dd61390f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmZ3WmlKZlJUNEdvWS9kSUtueGNsd24rNktJdWJPT0FQSmhPK0pXRmNJdi8r?=
 =?utf-8?B?ODJyTEgxZi9PTEl5RlI2bWwyem5nK3JQc004WEw3cXpReXJObXNlN0J0Q0Rw?=
 =?utf-8?B?RFB1MlpqaThTRlRtTGk1ZklOMUJncWVoWEdBY1NDZWQxRGU5emJwY2wrUWV5?=
 =?utf-8?B?T3pEdDUweEZoazVsWmV1eUw1VG5kSEVuenhQbDZ0RDd1dVFKTXBjejFGcFRq?=
 =?utf-8?B?YS9NSzBHalMzcTZxelZiQkNrL3lTWWw0djNKcHNFaWU0c1doU3J2OUlORjgw?=
 =?utf-8?B?aXNDZnFlYXE5RUZVR2hPanMxNkFZUVJFbFBCdFcwVXRtNm05RW1teWpCbVRy?=
 =?utf-8?B?VGpxT1A1clVFNTdYVzU4bXlFZ05zRkZJMnRhbFpaRnFleTNSMXpWNTNRSXQ2?=
 =?utf-8?B?c0NzdHNjK2NSNk1BN3M5Y044M3ZWSGZPWUIzZno5c1VvME93cUZaSmhtWW04?=
 =?utf-8?B?VFlRT1BiWDlFRlNLTVFhL3NlS3N5SlBNdDRGQnNQOFZxZ1p2Zm5sSHpvbkFD?=
 =?utf-8?B?aVd3cFNieWovZFVqamNBZDFQMG55STFPdXkrNzgvUFArMEFycDdWWm1OYTAr?=
 =?utf-8?B?eHE5Zzc1NjEvTDhEWDJCT2xaOExWTXVBVHVWQkV6ekNIczZGcGNlMVF5QVNI?=
 =?utf-8?B?dUVad0swRTkvRCtBUlR3eFZhNFloYTBuQjFBa1poUms3ZkJQeUsydEdsMWNn?=
 =?utf-8?B?WUx4bjA5S3pBUUxFRkRkZlZSVUJFNG51Y0dkNXgyMHFMeS9ENFJYV1ZHR2Nl?=
 =?utf-8?B?TVV1ek0rRlI1N0w0RjFEOURVeEVQdUpuZHFTNnFUTzdVcWFVL3VmaWFOOG9V?=
 =?utf-8?B?N3d4b3ZHYkxtRktpMXlRS3R6TVMrVy9GQ2VtMFdnQ0R4QW85MHdiNUV6WjRo?=
 =?utf-8?B?S0xabGVvb3FTQ3R4eXgxdGZYNktUQVZ5QlRXdHdzVHdwNGduVFdVMllZeEYv?=
 =?utf-8?B?VmhDMWtBWHJGN2JZcmY0TlpKaURkUWtPaFVnckRIOWNDTmlXTlU5dVczMUhr?=
 =?utf-8?B?TVRsOG1iSnhHTG82ZkgwbGpwUXRsVDZ3YTVwVkxDVEJrdmhEMHBMNU1GcmJn?=
 =?utf-8?B?eEc3SjlnOUllZ3BHSk50dUUzRjlQcEV4UXJxZ1hNOHpVUUJCUXdFTEoydzRw?=
 =?utf-8?B?RytGT0xjak5FUnljSklNK0xjdWxpQVU5bVpFUE1RS2FQSzRhZ2hhdEowRFU3?=
 =?utf-8?B?NldaVkI3allWZE90Z1BLRWpFRjVDNTN4SGJ4aGczRGdIbC9wMTFHLzhCWlpD?=
 =?utf-8?B?ZEdRQzEvQUlEUnl2VE5WbEErZDRjaGtXdDVyNS9COG5hNThsRFVxWTdWUzVt?=
 =?utf-8?B?aXVmL1RTNGZQUnNJOFN3c3BmV2gvRytVTDR2eDJXL2djaUtMYWNKeXMrSTh4?=
 =?utf-8?B?T28yUXVuVWlRcmQrVjc0UVd5YnJwOENDd3ZaR2grQkZ5clpNRGRTbXl6d3Zh?=
 =?utf-8?B?aHY2WkZ3bW9Nalk0ZG5KT0U1c2F2eDhRbFljODZKQWtrMVZFK2VvaEpPeDVK?=
 =?utf-8?B?UjZicngzQXFmUUZzTjBFcFFuc3ozeko4bVRXYlpYUy9aa0FRbU5oclJGcVNh?=
 =?utf-8?B?QUo4L0pJSWpEaVA2RE1SV29XR2F6dmFaelhPcE94SzZMaUVxeEx1ajhELzhZ?=
 =?utf-8?B?VU5LQlhSKzRlV2dRK0VuWWF6T2IwbWtra0JRWjIzZFN2REJyUXlsdS93dCsw?=
 =?utf-8?B?ZTFiRDZmRmRyb1VJS1haTjArTHA0V1RCaU1XcEVlSzhRL0JqV2h5ZGNGTW44?=
 =?utf-8?B?U05EQ0t1ZWVGUlR4eSt1RVAwSUdsR0JhLzdIa0N4a1pMWWk1bEVvRjc4VzhC?=
 =?utf-8?B?WG10ZzRMb3dEeTZEcHJxd3NHTFpISHRRMG9BQ2hjQ2pQQWFTeThDdG9RWWIw?=
 =?utf-8?Q?AiKSOzAXL81x6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU16S0dZWDFaRFN5NXdVc2R1bDRGeCsyUGVnRzAvU3lxZDV5Nmx4ZjV3anZx?=
 =?utf-8?B?OVVBeThybm12dWdmenV2QWw0Z09Iek9Pb1FoajFjQmEyM3lXZHhZSmc1SG0w?=
 =?utf-8?B?MmxESHVVcHFTY1Z3RGNSUEY2WTZlZ3FlVXRsc1lnSzI2RzVjQTJUYXh6UGhp?=
 =?utf-8?B?dWY1UHBUYmVETUFqa012M3JhMVBEazBJUjBFN3NjYTNRZXBHZXJSNWo5T3Nj?=
 =?utf-8?B?bWZDSzZnZjl4NWs2U2krUyszcUtYUVpiSnJPOW5uQTBNOWRodEVyR1IrVWhP?=
 =?utf-8?B?YzAwSFFCc00vdEx6KzRnY2M1bExjbGM2NkhqejMraGdybkhjMndvTFFNc3Zq?=
 =?utf-8?B?djNDWVJxNzNhNEUvT2h2NWk2bkxSNWxYWnNFak9yQkI5c3diMEFtS0tRdWxz?=
 =?utf-8?B?VFAzRS80SVlaN2lvMEVWd00xeXh5ZlR3RVNNZk1ZNG50Z1l4NzhSaXRCMlEx?=
 =?utf-8?B?emNLY1EyR09FWXRxeWlDY2dYMnlKbFk2T2h1Tm5pSXRjcWNCZ21YN1A0eXRq?=
 =?utf-8?B?VU9pR0IxNDlrUGFZN2FRM2JocjZvcXMyTHJDNHJCZ0tuVzhlVU96anBacGp4?=
 =?utf-8?B?UFZnTUdNVDFZeksxS1g0NjVNTlYrRmJ5SHg3NUhoenREakNMVktZOFMvM2Iw?=
 =?utf-8?B?bm10ZjlENGNoZUgxbWFDdG94S2pEa055d1dzMjF5U0lzRGh1WU14enY3cjM2?=
 =?utf-8?B?WkFQc0dQQVg4V2xTVnhmTUtLSUhyam5LaVo3blJycTVFU3g5SFRJZ2JRcDNm?=
 =?utf-8?B?citDb3NQQmdHMVpzakE4SlJoZlVnQnRwZmFPN0loN1N2S1JJcHRENjMvVVBX?=
 =?utf-8?B?M2d4K2NtUGljUXV1RDJuVGQ4RXZ2Zm5BamQwTElZTUNISlNPaEhYMGQ5R3B3?=
 =?utf-8?B?RThQRmZPV05sQS9XWlFnV04xN1kvamZyNWYwZkdrZVI3VEFXQmdaQk5yZVNE?=
 =?utf-8?B?M1Rxbi9yT2xUYnNUKzlkelVRNGdDMFJsMXFzbmF4SW1PYWI4MWtZK0czTkJs?=
 =?utf-8?B?ZFlGSzN0c3hsRXhBemJSQ2ZFSCtpMnhoT0YyYURwZmRKZThweDZCL09LUE5I?=
 =?utf-8?B?NkdKOGZuaXlvSU5iTFE0bFJXR1ZoVStlQUNLNDlhODROTXpqTHlid1RpZXpB?=
 =?utf-8?B?dm8zcjhieWFkWlMyY0FCRFM0Y29aMFlYQysvYUNZbDJwZndHNi9NWWxNRUh2?=
 =?utf-8?B?T3UyWS9JV0pPS1h5blRsbmJ3QitOYVVyMVRpdnRXVXhTTTBqVFF4d2U3OUhv?=
 =?utf-8?B?T3hGKzE2OVZGbEV3MGd3L2hpWTRWOGRoM0xrKzJpK2J5SU9vRzlOVWtyaXRF?=
 =?utf-8?B?djhqN2s5WlgxVmpZYU9lZ0RoMkJ0VGd2REVvNGI3b29VMWZhVzJ4a1FRd1Iy?=
 =?utf-8?B?Y25QVkhoSTZOWDJ1cFc3L1VWaU0zVVl6VkU4QVY5Vm1QY3o0YmNyY3Ivb1hm?=
 =?utf-8?B?RC9Gbm45ZlZHeWpIVFQ2OGF0SDdQRjRseDdodkljMDlIRStRTG1PbmpLRGlK?=
 =?utf-8?B?SjlFMzlvOFpMdklqZ1pUT3dkbXNJSnVsS2NRQnpuQ0RYZVFHQkFUbXlTZXp2?=
 =?utf-8?B?NVU4TkU0Q3R2RzNIMkRJRk9uTG9FMkhLWTRBVURidytucW9USW4yVWlzb3hO?=
 =?utf-8?B?QVlnMnBXRy9NeGNkeFJTRmNjbzRzVGtOQ091aTdRMGkvM3hLVGVLbUtjaTVq?=
 =?utf-8?B?ZnJEa1hLNmQ5M201S1VwdFRkbnNYRDZQekhPQ3lJN1dQTDBKN2Z0WC80UUtv?=
 =?utf-8?B?Tk5Xa3Jyc2lYRTkveFFrYnpZZVA5aVhoTlpFRmxQRHZHb3BxeVBwV2JVRk93?=
 =?utf-8?B?V3JtU1ZhaWdvQUhBcm5GNHJzNGdZR2tUdUxST2UyMHd3V3JhZHZOWHV5dVJi?=
 =?utf-8?B?UEFBeTlWQzhXcSsyazkxSitWNHF1VUNNTDg5WU1XZDNGQXVUbVZtaC9UdFlK?=
 =?utf-8?B?RXREQ0N3cWp6U0w1M25ISFE2dUZrekxCNzliNlV5ZFIyWDloUW5tM2RBS2Z0?=
 =?utf-8?B?QWp3eDE1OGh1YjlFUWZUdmVHYkZ4T3BJa3BkVzduQ2RWZzA1cTRPbVlsM2dL?=
 =?utf-8?B?K3VuYzU2anB0YmsreHdDRXBQeVBvMGUwTHYvck9VT0ZFZWNmMFlGOVNVR2ZC?=
 =?utf-8?Q?METQjDyZxNoI2KB56DHWOlE/9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12208e95-e2c4-4f3c-b215-08dd61390f84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 07:39:46.0800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW3Hk7TFXFkQeYOExu8mEzad/ZdxlMxQvEKjg5OFkfaiSPneWb0UpTxfsNxLQUI5obQBfjSZFkzrAhRBzOZb5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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

--------------yS9Sm5Fd8DSVUIW8WX9TVuGh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The original code will check the drm_new_conn_state if it's valid in here

10712                 if (IS_ERR(drm_new_conn_state)) {

After that the drm_new_conn_state does not touch by anyone before call the

--> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,

I think it should be no issue in this case.

We call the PTR_ERR_OR_ZERO() just because we need to get the error code 
and return to the caller.

  10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);

Maybe it's just a false warning?

Tom

On 3/12/2025 10:34 AM, Srinivasan Shanmugam wrote:
> Added checks for NULL values after retrieving drm_new_conn_state and
> drm_old_conn_state to prevent dereferencing NULL pointers.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
> 	warn: 'drm_new_conn_state' can also be NULL
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
>      10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>      10673                          struct drm_atomic_state *state,
>      10674                          struct drm_crtc *crtc,
>      10675                          struct drm_crtc_state *old_crtc_state,
>      10676                          struct drm_crtc_state *new_crtc_state,
>      10677                          bool enable,
>      10678                          bool *lock_and_validation_needed)
>      10679 {
>      10680         struct dm_atomic_state *dm_state = NULL;
>      10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>      10682         struct dc_stream_state *new_stream;
>      10683         int ret = 0;
>      10684
>      ...
>      10703
>      10704         /* TODO This hack should go away */
>      10705         if (connector && enable) {
>      10706                 /* Make sure fake sink is created in plug-in scenario */
>      10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
>      10708                                                                         connector);
>
> drm_atomic_get_new_connector_state() can't return error pointers, only NULL.
>
>      10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
>      10710                                                                         connector);
>      10711
>      10712                 if (IS_ERR(drm_new_conn_state)) {
>                                       ^^^^^^^^^^^^^^^^^^
>
>      10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
>
> Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.
>
>      10714                         goto fail;
>      10715                 }
>      10716
>      ...
>      10748
>      10749                 dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
>      10750
> --> 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
>                                                       ^^^^^^^^^^^^^^^^^^ Unchecked dereference
>
>      10752                                            &new_stream->hdr_static_metadata);
>      10753                 if (ret)
>      10754                         goto fail;
>      10755
>
> Cc: Harry Wentland<harry.wentland@amd.com>
> Cc: Nicholas Kazlauskas<nicholas.kazlauskas@amd.com>
> Cc: Tom Chung<chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira<Rodrigo.Siqueira@amd.com>
> Cc: Roman Li<roman.li@amd.com>
> Cc: Alex Hung<alex.hung@amd.com>
> Cc: Aurabindo Pillai<aurabindo.pillai@amd.com>
> Reported-by: Dan Carpenter<dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1b92930119cc..e3df11662fff 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10727,11 +10727,20 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
>   									connector);
>   
> -		if (IS_ERR(drm_new_conn_state)) {
> -			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
> -			goto fail;
> +		/* Check if drm_new_conn_state is valid */
> +		if (drm_new_conn_state) {
> +			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
> +
> +			/* Attempt to fill HDR info packet */
> +			ret = fill_hdr_info_packet(drm_new_conn_state,
> +						   &new_stream->hdr_static_metadata);
> +			if (ret)
> +				goto fail;
>   		}
>   
> +		if (drm_old_conn_state)
> +			dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
> +
>   		dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
>   		dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
>   
> @@ -10766,11 +10775,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   
>   		dm_new_crtc_state->abm_level = dm_new_conn_state->abm_level;
>   
> -		ret = fill_hdr_info_packet(drm_new_conn_state,
> -					   &new_stream->hdr_static_metadata);
> -		if (ret)
> -			goto fail;
> -
>   		/*
>   		 * If we already removed the old stream from the context
>   		 * (and set the new stream to NULL) then we can't reuse
--------------yS9Sm5Fd8DSVUIW8WX9TVuGh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>The original code will check the drm_new_conn_state if it's valid
      in here</p>
    <pre wrap="" class="moz-quote-pre">10712                 if (IS_ERR(drm_new_conn_state)) {</pre>
    <p>After that the drm_new_conn_state does not touch by anyone before
      call the <br>
    </p>
    <pre wrap="" class="moz-quote-pre">--&gt; 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,</pre>
    <p></p>
    <p>I think it should be no issue in this case.</p>
    <p>We call the <span style="white-space: pre-wrap">PTR_ERR_OR_ZERO() just because we need to get the error code and return to the caller.</span></p>
    <pre wrap="" class="moz-quote-pre"> 10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
</pre>
    <p>Maybe it's just a false warning?<br>
    </p>
    <p>Tom<br>
    </p>
    <p></p>
    <div class="moz-cite-prefix">On 3/12/2025 10:34 AM, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250312023409.2687233-1-srinivasan.shanmugam@amd.com">
      <pre wrap="" class="moz-quote-pre">Added checks for NULL values after retrieving drm_new_conn_state and
drm_old_conn_state to prevent dereferencing NULL pointers.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:10751 dm_update_crtc_state()
	warn: 'drm_new_conn_state' can also be NULL

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    10672 static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
    10673                          struct drm_atomic_state *state,
    10674                          struct drm_crtc *crtc,
    10675                          struct drm_crtc_state *old_crtc_state,
    10676                          struct drm_crtc_state *new_crtc_state,
    10677                          bool enable,
    10678                          bool *lock_and_validation_needed)
    10679 {
    10680         struct dm_atomic_state *dm_state = NULL;
    10681         struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
    10682         struct dc_stream_state *new_stream;
    10683         int ret = 0;
    10684
    ...
    10703
    10704         /* TODO This hack should go away */
    10705         if (connector &amp;&amp; enable) {
    10706                 /* Make sure fake sink is created in plug-in scenario */
    10707                 drm_new_conn_state = drm_atomic_get_new_connector_state(state,
    10708                                                                         connector);

drm_atomic_get_new_connector_state() can't return error pointers, only NULL.

    10709                 drm_old_conn_state = drm_atomic_get_old_connector_state(state,
    10710                                                                         connector);
    10711
    10712                 if (IS_ERR(drm_new_conn_state)) {
                                     ^^^^^^^^^^^^^^^^^^

    10713                         ret = PTR_ERR_OR_ZERO(drm_new_conn_state);

Calling PTR_ERR_OR_ZERO() doesn't make sense.  It can't be success.

    10714                         goto fail;
    10715                 }
    10716
    ...
    10748
    10749                 dm_new_crtc_state-&gt;abm_level = dm_new_conn_state-&gt;abm_level;
    10750
--&gt; 10751                 ret = fill_hdr_info_packet(drm_new_conn_state,
                                                     ^^^^^^^^^^^^^^^^^^ Unchecked dereference

    10752                                            &amp;new_stream-&gt;hdr_static_metadata);
    10753                 if (ret)
    10754                         goto fail;
    10755

Cc: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a>
Cc: Nicholas Kazlauskas <a class="moz-txt-link-rfc2396E" href="mailto:nicholas.kazlauskas@amd.com">&lt;nicholas.kazlauskas@amd.com&gt;</a>
Cc: Tom Chung <a class="moz-txt-link-rfc2396E" href="mailto:chiahsuan.chung@amd.com">&lt;chiahsuan.chung@amd.com&gt;</a>
Cc: Rodrigo Siqueira <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a>
Cc: Roman Li <a class="moz-txt-link-rfc2396E" href="mailto:roman.li@amd.com">&lt;roman.li@amd.com&gt;</a>
Cc: Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a>
Cc: Aurabindo Pillai <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a>
Reported-by: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:dan.carpenter@linaro.org">&lt;dan.carpenter@linaro.org&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1b92930119cc..e3df11662fff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10727,11 +10727,20 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		drm_old_conn_state = drm_atomic_get_old_connector_state(state,
 									connector);
 
-		if (IS_ERR(drm_new_conn_state)) {
-			ret = PTR_ERR_OR_ZERO(drm_new_conn_state);
-			goto fail;
+		/* Check if drm_new_conn_state is valid */
+		if (drm_new_conn_state) {
+			dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
+
+			/* Attempt to fill HDR info packet */
+			ret = fill_hdr_info_packet(drm_new_conn_state,
+						   &amp;new_stream-&gt;hdr_static_metadata);
+			if (ret)
+				goto fail;
 		}
 
+		if (drm_old_conn_state)
+			dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
+
 		dm_new_conn_state = to_dm_connector_state(drm_new_conn_state);
 		dm_old_conn_state = to_dm_connector_state(drm_old_conn_state);
 
@@ -10766,11 +10775,6 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		dm_new_crtc_state-&gt;abm_level = dm_new_conn_state-&gt;abm_level;
 
-		ret = fill_hdr_info_packet(drm_new_conn_state,
-					   &amp;new_stream-&gt;hdr_static_metadata);
-		if (ret)
-			goto fail;
-
 		/*
 		 * If we already removed the old stream from the context
 		 * (and set the new stream to NULL) then we can't reuse
</pre>
    </blockquote>
  </body>
</html>

--------------yS9Sm5Fd8DSVUIW8WX9TVuGh--
