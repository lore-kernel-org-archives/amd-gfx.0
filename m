Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D44DC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 12:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E18289854;
	Tue, 14 Jul 2026 12:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jk2cFoLW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7EB10ED29
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 12:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTNQgp6VCjhiK05RLW3Gy5QedbJGfCVBmfw45YWz45Sw0lOTJwi11W+D6uJix6Wfb8Lpce1e3wZpNHtbG1pB6FQSKGTq+1mfwRaodQ68ol3i8YzYSkMiXZWmyiqQN9NCV9ADViYlAtNUBeF6h2GG/fS2pWrPtzRvS0dhyilzp7KzPgF0alyPYS/sm3PGEiJy2qsPpLxWjBK+xjOV0tH74MbGlA/MakloQumuvaqZxiSaZBrWugNp0r+pB6RbOi7o5CQCBKHNKWN6FUyGsFxw+zoHrAhdGtbVPrgD6EohaMj9fmo/Tr+R1TAEHWGij6LqvZCdyVECw/2RmCtK6PZm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7uEE8e6J4NfsXTlc8lDM/Ul8gIXOTYGrUvDhDnVM7w=;
 b=mFyH1/IDIqy+K7OR1ECVvahQtoANqr4aIGL94CeowN822xLmzNeb5YE/WZ3FGDPeyRYSWgMtIWW6GQ6TyLKn57z2ZwDqeATZ9ZQ/kZEVtpQ7009vkGlPm8adkIgdQhcf6VODnEA/gJACBKR7BxJO7NIznnU7k0plqHKZr2yT+ZNnRatZhHC6VbFjEcHUI5jAWBivKGoXc+BYsZXuEg3i+qOkU5cWKj9vYfUYy/7TK3I59QPYqAYt7TuoaYVZlzlb+0w/EzlMuB37wK8BmUiF5PqIzTfVZ8yNUhxQHmdd4Zgs7fnoXIGG9oxBLI2PkQ4REtKSPmQwPYMDIl3ishWIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7uEE8e6J4NfsXTlc8lDM/Ul8gIXOTYGrUvDhDnVM7w=;
 b=Jk2cFoLWWy4z3JJUojiqLu1RrDrejuW7EM4n7uhUpRhNepkJVcoeOr3PY1KHHagq78ZlwkdBa6cuz+sc/9wLCzm0+s3IbuGpFAVua3EgHzW9rUUoQle3yrzerLaux28R1K1pb7MTZs3W7zcDje+3ZG8UVfqCnIAcuvkfz1UVsiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 14 Jul
 2026 12:49:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 12:49:56 +0000
Message-ID: <66b5afb7-bc91-41ed-8ebd-4d7a6f2ac77a@amd.com>
Date: Tue, 14 Jul 2026 14:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/5] drm/amdgpu: Add wait-event manager and per-file
 lifetime plumbing
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260714081023.3395485-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8e4322-6924-4164-c67e-08dee1a667e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|6133799003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: nIlha6fdAHZwPngHOU5Be1vr38jY02AoLoFQCJ9f2x4TL79CqiF6YfMspB6tDBE5+bguemF+tlpn/XRKbOMQemC6Grrexp4QyqtPzp4E8AeNtFDTuomxz/NFJIY/OIuYyxPpeYrqLX99ouEpCL4UE5xlcqqP6c+WkLs+QR0/xPQNlnXDcqHvbyitWjUt7bNvoVVXNgU4srD7e7oCIDYfXS+3UtryC954Y1bCQIFa05aDS5/aLpjE5GBACpP0lCpavxqnWMwWA3hn6u3nE6jER1xT17x9ZI4z7WLR7/u4CBZ4rWGsTJm9EdwaISbPdrinrTmlAXJl13Evb6+A5W3x1f4jJYYof3UGEQgbPd26yxkoaTuis5HEjTc0r7CiX44QJQYiTKX09yiEG78uqlc1+TXRe8yOlzPnu1w54+26Na71SaCZAS3TuPHaY+UxFT8JLASZ8mOvVFymqhfA2ZEEvdVz0+l7h8LenViCKGSmiOpHq69R5ORE99uctGv1M9AnaKK1JTU5ww7LBm+d3RCuy9zIFM+aZkKleNMT8ts9rM9tStL8M6xMgaUr9rUIOP5Bfi3L6oQ//jesZME+8my8aJeuHDucrbEX9tiJ/L+ITGgkRGnLpPnYRZ+ePvCU4Bsjpm+Kxoq8+mRoU86XaIoDB64YkW6AuKKwMMLHKh21ZWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTJYdzhwd21kV2lFTm9tYzhEcFNsV0haOW5GbzRVNkVyR0V6OERBbFZHWUpu?=
 =?utf-8?B?S3I0NlFjalpNYjYxdmJDVGlsbGpnREg0OVpXNzU4SFZya0VjQkxHemJNQXcr?=
 =?utf-8?B?N3c2cTlsTHY1OEwvQkl2S3BOQUlvZTRXVVgvRHdIa0c2bHBOWEJnQ0Q2TEZo?=
 =?utf-8?B?N0NUblE3RjZmR2tBa054cncvN0Evd1Uyb0t3NDZraUlzeHpkdUllUTBMWS9z?=
 =?utf-8?B?QW1JTithM2JwMDFFT1NvN0hYZmtDcERMazIrQ0Y4ZkFxaGIzazZiWVV1Tysx?=
 =?utf-8?B?ZTZ4ZjhNNTI4MUlUbTJ4ZWRsb014bWplSURlbzE5b1k3NXkxY2kyUzdxTE8w?=
 =?utf-8?B?UVpQYTRPRjBOSG1RNXJIc1BCekZUSEQzZ0ZLcThjc1hORXFnRVE0YVVLcmJz?=
 =?utf-8?B?VExuajFQRWVWMUhDOGgrQ0dzQXAxM085aWxYaFcrMGVKREllWFpwUHFVSTdm?=
 =?utf-8?B?RWNseitSaG5UWWtyckRPOWdLNWhmL3VVQ3c5em8xL2Z5UU82dWJiRkh4bUlL?=
 =?utf-8?B?Ym5YZzJMdHBrMzVWUDd5dU43NWNmQXRSS0xhMVlPVkdMK2tKKzluTHZWeTBW?=
 =?utf-8?B?UGMwd2hmU0FXdTBxZVY1bkFDWXZsRk1rTkFUbWUzZ2hROHFJcUx6Q0hleW1D?=
 =?utf-8?B?dmp6Y0J2ZWtXa0NiSFozUGRsM0RpemJ6U2ZaRjZBci80cy9aVEljcVlCbnJQ?=
 =?utf-8?B?R2E2aWgyWUZKdE8vSG83NVJhRTIzNGtmTXdiZmtrY20ydGVISTloY2RLVnlB?=
 =?utf-8?B?cjk4eHBYbXdGSW5pMUV3S29TYWxXRXgrN1g5Y2xoaFJqY29yYXJpcjNZMGtF?=
 =?utf-8?B?NVVwYWw0eFBzT3lNYlowczJXVHVCMTlTckRRc2YzVHZFSzd0K045VEVOSWR1?=
 =?utf-8?B?QmhoSytGTWFwbVJ5d201Z3ZMWUFwMy8xU3BKa0hoMUErZmJid3JwY2oxdm9P?=
 =?utf-8?B?THVJaGVuaThRTDRRdElHQ2tkazNpeDVkQThRZzJhejVWOFJMV09heUU1ODh3?=
 =?utf-8?B?cU1QN3BOeTh4emVQUERRWWg4Rmo2RXc2djlEOEJyUmlzV29KYXdidHYwR0Vn?=
 =?utf-8?B?Y254OFNXQUkzZ09NeG1SbmRNWExWYVNaSnJjK3VFcUNydHg5Sjdnd1lhWHVL?=
 =?utf-8?B?NmVLSGVQb2phUXk5SXNVNDBnV1ZsaldmTXlmSG01dUphcnNTZm1kUGZqQTVj?=
 =?utf-8?B?NDBvcjhTMU5jcEZFK3RWNnV6NGFJamR4UVA5MzVDakxIT3BhV1FFaWVrS3p6?=
 =?utf-8?B?Q3hnUG5lZlhLUWo3a01nT094RkhpZDkxOHF4MmVVRyswYm9UNjJhMmdvd3pJ?=
 =?utf-8?B?Y0tJWDVkc2FzaFN1VXJkN0czcmwxRXlFTG4ydUNFSmthVXUvV1pYSk94bk9r?=
 =?utf-8?B?M2hzcmhyTXlGaEZJa0RXUHlXTWo1QXVROVhUUzhjWDFRaHJFNHZKSUN4Zmxl?=
 =?utf-8?B?MWZhcE84Q0tnSWZWTVBrVmdiYmQzaTFLcEdueE0wREQ5UDRObW1VNEZUNnNP?=
 =?utf-8?B?SDM1dzF0aG4zR1lFNzlyYXNRVFZkd01kWlBKUkpMc3U3aG4rdFJqK3R2b3RW?=
 =?utf-8?B?VG4rdVZmVTNKT2RvN3Y2SUgyNmxoZ09mTStNQVBSSDNrNm8zeGNzTm5Tengz?=
 =?utf-8?B?RnNkTFRVYlQwSFZSV2hCUmllWGxBdDBRU2RZUWJNc0xYbXd2OUxOdXdyMnd3?=
 =?utf-8?B?RDgrMVhtcStUckxFeWdXbncxOVZ4ZXVncmM5N0xjYTMxK05UMkROV0FIV0Iy?=
 =?utf-8?B?WmhYc2hieFo5S3lRSlJtcXR2bDNSN1BOOWJQSmorSER1LzZSUUlBZWw4UUZM?=
 =?utf-8?B?aWEvcWhCOS9nb0xTdXlxZ2hQUzB4UWp6eWFySFV2aEhVOTJrekFoZW9LYjJs?=
 =?utf-8?B?TWZhRzFmM0xXa2VKWXJUMG1neGlVOXFyRURKZWpmWFhtWGhiZ2pjeFZQT2tq?=
 =?utf-8?B?T3Q4SmZIOE4rQ2paSFd4YjVmOWVpMHQ2ZitKamVmajc4OEVJVEhPSjhIN1ZH?=
 =?utf-8?B?ZkhOdUkrVkRPbG9BWjNDOVMwMkNBY2JBenJUTkExTnVzMUpJVmdjQStONHhY?=
 =?utf-8?B?bDBSbXhteWE1cG1keVpZVy9LN1N5SFIrSkhzKzgyWm1aUWFvRnlBNVlFb1pG?=
 =?utf-8?B?WmRWSnl5TUFYMnhlckkxQTZPQ3FITHpBU0tWMWgrSml0L0gzb1VGbHIyeHFu?=
 =?utf-8?B?MTNsQjdGbDNLUENNVnB0UlIybTlRdjJIUS8zRWwvMFg4RjlIRktGYlJqVjY2?=
 =?utf-8?B?anBjYVJpcy9FSmIwWXUrei9LSTJFSldDMW5GUy9Cd0E1cEhDKzFpRUh0QTJm?=
 =?utf-8?Q?muaIcIiQjWWAK9IBGA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8e4322-6924-4164-c67e-08dee1a667e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 12:49:55.8839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSOXy7gKUB2YA+3IQNobVcBG9Oqq2nueVFNRvJyqC8y6ueG8ivrNDEjYK9srb2Bk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

On 7/14/26 10:10, Srinivasan Shanmugam wrote:
> Add the per-file WAIT_EVENT manager and lifetime plumbing used to store
> and retrieve event records for render-node clients.
> 
> The manager maintains a list of pending WAIT_EVENT records, supports
> blocking waits from userspace, copies the first matching event record to
> userspace, and enforces single-consumer semantics by removing records
> once they are consumed.
> 
> Register the WAIT_EVENT ioctl so render-node clients can access the
> per-file WAIT_EVENT manager.
> 
> For queue-scoped events, queue_id is resolved to the corresponding
> usermode queue object at the ioctl boundary. Pending records are matched
> using queue pointer equality rather than queue_id values, avoiding
> internal routing through reusable userspace handles.
> 
> Pending WAIT_EVENT records hold queue references while queued. Those
> references are released when records are consumed, explicitly removed,
> or destroyed during manager teardown.
> 
> Embed the WAIT_EVENT manager in amdgpu_fpriv and tie its lifetime to
> drm_file. Initialize the manager during file open and destroy it during
> file close so that pending records are cleaned up and blocked waiters
> are released before file-private state is freed.
> 
> Changes since v8:
> - Squashed "Register WAIT_EVENT ioctl" into "Add wait-event manager and
>   per-file lifetime plumbing", as suggested by Alex.

As I said for patch #1 as well absolute timeout please! See amdgpu_gem_wait_idle_ioctl() for an example.

Generally a bit more kerneldoc on the functions would be nice to have, but not a must have.

Apart from that looks good on first glance.

Regards,
Christian.

> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.c    | 286 ++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_wait_event.h    |  74 +++++
>  6 files changed, 370 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index b7897f98436c..c4cee6a6bc64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> -	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o
> +	amdgpu_wb.o amdgpu_cwsr.o amdgpu_events.o amdgpu_eventfd.o amdgpu_wait_event.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4f42888e2647..91f1dc737aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -104,6 +104,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_eventfd.h"
> +#include "amdgpu_wait_event.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_lockdep.h"
>  #include "amdgpu_cper.h"
> @@ -427,13 +428,15 @@ struct amdgpu_fpriv {
>  	uint32_t		xcp_id;
>  
>  	struct amdgpu_eventfd_mgr	eventfd_mgr;
> +	struct amdgpu_wait_event_mgr	wait_event_mgr;
>  };
>  
>  struct drm_device;
>  struct drm_file;
>  
>  int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
> -
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e90cf67c1cd8..b738a1bdf9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3097,6 +3097,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index ccc9c3f8aba7..72bea83d7408 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1681,6 +1681,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	}
>  
>  	amdgpu_eventfd_mgr_init(&fpriv->eventfd_mgr);
> +	amdgpu_wait_event_mgr_init(&fpriv->wait_event_mgr);
>  
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0) {
> @@ -1754,6 +1755,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (pasid)
>  		amdgpu_pasid_free(pasid);
>  
> +	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
>  	kfree(fpriv);
>  
>  out_suspend:
> @@ -1784,8 +1786,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> -	/* Drop all subscriptions before fpriv goes away. */
> +	/* Drop eventfd subscriptions and pending wait-event records. */
>  	amdgpu_eventfd_mgr_fini(&fpriv->eventfd_mgr);
> +	amdgpu_wait_event_mgr_fini(&fpriv->wait_event_mgr);
>  
>  	pm_runtime_get_sync(dev->dev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> new file mode 100644
> index 000000000000..f98de1d94b56
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.c
> @@ -0,0 +1,286 @@
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/jiffies.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_userq_internal.h"
> +#include "amdgpu_wait_event.h"
> +
> +static long amdgpu_wait_event_to_jiffies(__s64 timeout_ns)
> +{
> +	unsigned long long t;
> +	long timeout;
> +
> +	if (timeout_ns < 0)
> +		return MAX_SCHEDULE_TIMEOUT;
> +	if (timeout_ns == 0)
> +		return 0;
> +
> +	t = nsecs_to_jiffies(timeout_ns);
> +	if (t > MAX_SCHEDULE_TIMEOUT)
> +		timeout = MAX_SCHEDULE_TIMEOUT - 1;
> +	else
> +		timeout = t;
> +
> +	return timeout ?: 1;
> +}
> +
> +static bool amdgpu_wait_event_valid_type(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +	case DRM_AMDGPU_EVENT_TYPE_GPU_RESET:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void
> +amdgpu_wait_event_record_free(struct amdgpu_wait_event_record *rec)
> +{
> +	if (!rec)
> +		return;
> +
> +	if (rec->queue)
> +		amdgpu_userq_put(rec->queue);
> +
> +	kfree(rec);
> +}
> +
> +static bool
> +amdgpu_wait_event_match(const struct drm_amdgpu_wait_event *args,
> +			struct amdgpu_usermode_queue *queue,
> +			const struct amdgpu_wait_event_record *rec)
> +{
> +	if (rec->data.event_type != args->event_type)
> +		return false;
> +
> +	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type))
> +		return rec->queue == queue;
> +
> +	return !queue;
> +}
> +
> +static bool
> +amdgpu_wait_event_has_match(struct amdgpu_wait_event_mgr *mgr,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec;
> +	bool found = false;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry(rec, &mgr->pending, node) {
> +		if (amdgpu_wait_event_match(args, queue, rec)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	return found;
> +}
> +
> +static struct amdgpu_wait_event_record *
> +amdgpu_wait_event_pop_match(struct amdgpu_wait_event_mgr *mgr,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp, *found = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
> +		if (amdgpu_wait_event_match(args, queue, rec)) {
> +			list_del(&rec->node);
> +			found = rec;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	return found;
> +}
> +
> +static int
> +amdgpu_wait_event_get_queue(struct amdgpu_fpriv *fpriv,
> +			    const struct drm_amdgpu_wait_event *args,
> +			    struct amdgpu_usermode_queue **queue)
> +{
> +	*queue = NULL;
> +
> +	if (!amdgpu_wait_event_valid_type(args->event_type))
> +		return -EINVAL;
> +
> +	if (amdgpu_wait_event_type_is_queue_scoped(args->event_type)) {
> +		if (!args->queue_id)
> +			return -EINVAL;
> +
> +		*queue = amdgpu_userq_get(&fpriv->userq_mgr, args->queue_id);
> +		if (!*queue)
> +			return -ENOENT;
> +
> +		return 0;
> +	}
> +
> +	if (args->queue_id)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr)
> +{
> +	spin_lock_init(&mgr->lock);
> +	init_waitqueue_head(&mgr->wq);
> +	INIT_LIST_HEAD(&mgr->pending);
> +	atomic64_set(&mgr->seqno, 0);
> +	mgr->dead = false;
> +}
> +
> +void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(removed);
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	mgr->dead = true;
> +	list_splice_init(&mgr->pending, &removed);
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	list_for_each_entry_safe(rec, tmp, &removed, node) {
> +		list_del(&rec->node);
> +		amdgpu_wait_event_record_free(rec);
> +	}
> +
> +	wake_up_interruptible_all(&mgr->wq);
> +}
> +
> +void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
> +				    struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_wait_event_record *rec, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(removed);
> +
> +	if (!mgr || !queue)
> +		return;
> +
> +	spin_lock_irqsave(&mgr->lock, flags);
> +	list_for_each_entry_safe(rec, tmp, &mgr->pending, node) {
> +		if (rec->queue != queue)
> +			continue;
> +
> +		list_move_tail(&rec->node, &removed);
> +	}
> +	spin_unlock_irqrestore(&mgr->lock, flags);
> +
> +	list_for_each_entry_safe(rec, tmp, &removed, node) {
> +		list_del(&rec->node);
> +		amdgpu_wait_event_record_free(rec);
> +	}
> +
> +	wake_up_interruptible_all(&mgr->wq);
> +}
> +
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_wait_event *args = data;
> +	struct amdgpu_usermode_queue *queue = NULL;
> +	struct amdgpu_wait_event_mgr *mgr;
> +	struct amdgpu_wait_event_record *rec;
> +	long timeout;
> +	int ret;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +
> +	if (args->flags || !args->event_type || !args->out_ptr)
> +		return -EINVAL;
> +
> +	if (args->out_size < sizeof(struct drm_amdgpu_wait_event_data))
> +		return -EINVAL;
> +
> +	ret = amdgpu_wait_event_get_queue(fpriv, args, &queue);
> +	if (ret)
> +		return ret;
> +
> +	mgr = &fpriv->wait_event_mgr;
> +	timeout = amdgpu_wait_event_to_jiffies(args->timeout_ns);
> +
> +	for (;;) {
> +		rec = amdgpu_wait_event_pop_match(mgr, args, queue);
> +		if (rec)
> +			break;
> +
> +		if (READ_ONCE(mgr->dead)) {
> +			ret = -EIO;
> +			goto out_put_queue;
> +		}
> +
> +		if (signal_pending(current)) {
> +			ret = -ERESTARTSYS;
> +			goto out_put_queue;
> +		}
> +
> +		if (!timeout) {
> +			ret = -ETIME;
> +			goto out_put_queue;
> +		}
> +
> +		timeout = wait_event_interruptible_timeout(mgr->wq,
> +							   READ_ONCE(mgr->dead) ||
> +							   amdgpu_wait_event_has_match(mgr, args, queue),
> +							   timeout);
> +		if (timeout < 0) {
> +			ret = timeout;
> +			goto out_put_queue;
> +		}
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(args->out_ptr), &rec->data,
> +			 sizeof(rec->data)))
> +		ret = -EFAULT;
> +	else
> +		ret = 0;
> +
> +	amdgpu_wait_event_record_free(rec);
> +
> +out_put_queue:
> +	if (queue)
> +		amdgpu_userq_put(queue);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> new file mode 100644
> index 000000000000..e887fffdc4ac
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_WAIT_EVENT_H__
> +#define __AMDGPU_WAIT_EVENT_H__
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/wait.h>
> +#include <linux/atomic.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_file.h>
> +#include <uapi/drm/amdgpu_drm.h>
> +
> +struct amdgpu_usermode_queue;
> +
> +struct amdgpu_wait_event_record {
> +	struct list_head node;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_amdgpu_wait_event_data data;
> +};
> +
> +struct amdgpu_wait_event_mgr {
> +	/* Used when adding, removing, or checking pending events. */
> +	spinlock_t lock;
> +	wait_queue_head_t wq;
> +	struct list_head pending;
> +	atomic64_t seqno;
> +	bool dead;
> +};
> +
> +void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
> +void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
> +
> +void amdgpu_wait_event_remove_queue(struct amdgpu_wait_event_mgr *mgr,
> +				    struct amdgpu_usermode_queue *queue);
> +
> +int amdgpu_wait_event_drm_ioctl(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
> +
> +static inline bool amdgpu_wait_event_type_is_queue_scoped(u32 event_type)
> +{
> +	switch (event_type) {
> +	case DRM_AMDGPU_EVENT_TYPE_USERQ_EOP:
> +	case DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET:
> +	case DRM_AMDGPU_EVENT_TYPE_SCRATCH:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +#endif /* __AMDGPU_WAIT_EVENT_H__ */

