Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B6D5E140
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 08:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282A310E041;
	Mon, 11 Nov 2024 08:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pd+4tYke";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A729710E041
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 08:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUU5wQJ05hh6jOirqy11i2ijl53DV7mCbOe6/PwsUY0feSHzT9H+UzQZzUEQ6a5CIb7z7FMKX+IJXFqPb8gOEX0uTK+55JnmxaZp93BnsdqDOTLGNQUn1fUxjVtfJbwIZu9UAGYgfwscpQSooiUUw+LWki/Gc1vkNpmjMlDQmyzs6MHr1+vLydpxLRqXAbGPjbxqCEqrGjFw88D7y7oe/VJXaitqMla/sxYgp9ImXGV8w74UoeBa5YEw63DjGDY6NQrF8rTpcfKEi2yughHe+EvYQb6RP2DmvgRVFQsn6W9bCBrdnD7OwZQbDZdGcUIh+TeFcyt1VBlKs/uMcARKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M94fpHqoctxqURL7lkW9dOqghjDDc9mIhYBGxCLk9jE=;
 b=YPFo0+EArHs5H3/w9VcGxKvspISAcBnSosREsM5lg8A0kr6gGRjwA58y4hcmBH/eEdesIQ2nIWoJYJzY0ke/fZnpJR24UwBvq/F7fU9FBjwlcwdmW5xsnid4IVX1pWbaEKHOSy91kqurDNIden3+DI3DBVYz7VSV2gpzxsa4yfEYWlbt+6wABebH7gc0UR1iZJfafMgqaBGK0ArJhTTt9EiFWgMre/2atIsZuL+pmHiJ4b2sUUY6ld19ndRd+NTnG56gKxjA2JQnQ2/g8FGMRlQmd9mxbShQJMzhfz/peB2vbuXqutrogFR7Ty1Pt+y5mVkPuz8kklm4boOub2TnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M94fpHqoctxqURL7lkW9dOqghjDDc9mIhYBGxCLk9jE=;
 b=pd+4tYkeOpj2OP8lqSPDp70rFyJBuEq1xyFVQ05YuPvCylaq+nq8Au/GoVRV+l9JJIETUX+H+OK37JkCQ3OuXUS9Ri9Bw+eCOzSo4jGxy5GlCCTxq0NzYLhsWPadVC3tNjmbUAqDV5CFDGuJanHeEqq87X4DG9cW5ATEBjz0z9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 08:08:17 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:08:16 +0000
Message-ID: <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
Date: Mon, 11 Nov 2024 16:08:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
 <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::7) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2f247f-aa27-4cff-2d0c-08dd0227ff40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnRnVHFGd28xczlBOUo1MUFvemhwb1dWeDNkaklZT3JSY21aSnBGMXhjcy9L?=
 =?utf-8?B?bXB4eWtnTHZGcmpNTzdWOTZRL3IxNENmVlljUUpWTHI4T2lxREt5SXZjSlVI?=
 =?utf-8?B?MUJBcTlmK0xocUtWVnNWZUw4ZzVNSDVibmtXbEp0K3FjZUJCbWkzUHJmK0hO?=
 =?utf-8?B?elhRZit3M0JpZFQzeHNiK0tjellldUxmY2s0SmZXL0ZZTnZPV0ZzakN5MXRz?=
 =?utf-8?B?akh3U2JMek9BVXhhaHJRVEtQMSs2VUs5M2R5YUpOZ3JNcUFtaEs2Y1ZHQ3Q4?=
 =?utf-8?B?aG5UNDVneXdYVUhHWFYrc29pQWJ6NWhBQkRFRFJxcWpmQzV5OWVIS05kQmN3?=
 =?utf-8?B?ekwxaTBNMHRoUmFBSGl4MW9BZUI5UzExek5JVnNMTkorRTFnYnc2RHNBVDVq?=
 =?utf-8?B?cC8wQTlmOFl4RjQwckdkbW5SV0Z0YTc5eTlGbm1sWHVkVUVSbDdOejBHczhz?=
 =?utf-8?B?ZHE4WU1DS3V2Q1V4VUhrQ3ZIUDZ1NEFVUjM5blRBMGdmZGNMYXdRcFJGUm8z?=
 =?utf-8?B?TGxPYWlrT2c1cUx0blEwSDB4UGs0Rzh0bk0wYVNERU9JRE8zTS9ZaUNVVE1H?=
 =?utf-8?B?U2pVbWZUc1ZOUHNqZUdnVzRUTUZZVW5NSmZIUDhsKzZtNnM4OWkyRURyZ2wz?=
 =?utf-8?B?UTZHTW5YeW14MGhvNVk4QVZwQStxWVFEU2VNVzFrbnVMdlFiY3BDa2FiczRJ?=
 =?utf-8?B?NG1DZTZVcnJzaHVlV1hBSCs3dVEzcDJSdG1nSFZLeHVzeVZ1aVlMMndTTE1v?=
 =?utf-8?B?Tm9xYWhXb24rU1Q1VktWUXVaa0RNMmY1VnZtcTVCSHZzOWdVSCtoeUpsRWhQ?=
 =?utf-8?B?Wm5CdTNwczlOL3JiQnJPUmdMaWVVYVVGOGRzTUYyQ0t6cjZWd2Q0UE5jYXh3?=
 =?utf-8?B?dUQ4QzVYSXhtQ0t5M0NSd2JWYk1zMG1zRE5ScG55WW1VT3ZQcjE4MGc5WjJT?=
 =?utf-8?B?OVduVkEzS0szM0doSXFNWmsyNG82QllHcFZmaDE4T09CbTZ5T2k3NDROb1pw?=
 =?utf-8?B?emE1RXFqN3l1TmZ5ZS9BdG5pMVRwNmpwK1Q0ZUwzMnBBa0pVdnlBYjJMa2xF?=
 =?utf-8?B?bWpsalg2a0ZVM2hJRmF4eGdRYVNEMXhtazNXOHVZWldyam9DR3hlaERWQmdp?=
 =?utf-8?B?YUpoL1V6eG9hdDZZNEpVbmtsWjdidlhQeUhCRHNPaFFjcWthNEJaeVZmM2cw?=
 =?utf-8?B?ZnkxSjVqcWszNUxGSUV5bVA1UG45L2ZlV3V0Z2IxS0ZjVEFzbG9RMHBZajlX?=
 =?utf-8?B?NC9sc2MxSUE2SGdiU2NVYjBzQ0lCMWZ3bTF6ZHZrU1BVSFNZRy9lVDlLM2d6?=
 =?utf-8?B?TjlkQnRhZElhWC8wWkRRbzczWm4rK3ZkUzRRbGpBVkRMTHk4N3YwS3VhWWhE?=
 =?utf-8?B?SCtubXBNZDRwT21hYU9vTGVKMDUzTFJUbGNCMHdzU2Q4bTlEUUFtU1BwbHh4?=
 =?utf-8?B?N3VDK0JGU2FSK0dnOWJYdEpEVUZXZFdycnZoWWNQbE5GeFNzWHovS0tQYlRP?=
 =?utf-8?B?WjRpQTNoY3ZPa1VCK1hnODR1Mmd0WnREQm1MTmQ5YlNSUTJnSU9vQldFM2R6?=
 =?utf-8?B?enByRVlwdDkxdktOckdzdjdmVE8yaDY0bWlwcXN5SUpRRmVwVGRnanJhUG51?=
 =?utf-8?B?VFF3RmhNZUh2M3FGZkRJQWg0U2R3bkw3VnBVTjl0eXE0dCtXR09OVUlrb1pP?=
 =?utf-8?B?MkI1aHJvQisxZW1mU0FlSmpJUUM0ZkczYnY0V1dCd3UwY2ZWdjhiTlVOVVpt?=
 =?utf-8?Q?QZUz+FCUV8QFxPnXF3YU6OzFasrzSiETa2bhkSe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhtK2FhVjhPWDMwd1B2WEZNWmc4eDQ2RGIrQU91bVBINUx5WkRhcHFwMGQ0?=
 =?utf-8?B?K3pIVEkyQzNxMlpxZjZLV1gyblRsNnMzVndoV0lvSFN6QmQ5Z0VRZTJ6cVpZ?=
 =?utf-8?B?WWpaQmtVa1pmcUFndXk5SXR2eW1mMjRPemF1UVVCSDRmd21oNkRMM1ZGajZ3?=
 =?utf-8?B?cDJXUitaM24vbVBkV1g4RStIcExENUpXekNBa0pZMW5ZZE55YzlHY2gzSk52?=
 =?utf-8?B?REVPUjhpdWJ1SWQ1cjRmUUx1eFdid1NsMDVZRzVtbTgvd0k1RkZaS1Z2bjYv?=
 =?utf-8?B?UFZXRGdmQ25DU1NvM1hzWXNkTzlYdnl3dyswcENEbmRHWUZRRzErOFdHaDh0?=
 =?utf-8?B?bXNpMFlEa0lic3hQL0RsR3FQL2wyOU84T1R2RHZBUGpnZW01VXd2ZDFiK1Yx?=
 =?utf-8?B?N1NrcFZNTjNBaUluSUg5M3FnYW54Uk01LzErbmNMc3FzMGNqclRWejVlb1dK?=
 =?utf-8?B?NGQ2d2lGcnU5S3JoblZBSlJUeVh3ZHBweTdHUnUxVlRrYTZ3MVBqYWdPeTVt?=
 =?utf-8?B?SUFJZXZqRFI1aGxlcnQvNjFzTDJhUmFVVlJTdXdZNUxkN0Y2NjdTSFdTaEc5?=
 =?utf-8?B?Ykg0T3k3SlFwTjJGWVV5Mk04L1VUY1ljSlNSbXdESm51MkcrdVNRS3JPMzQ3?=
 =?utf-8?B?UklMbEhsYkFJSi9rV2RZeE40S2dNSFVaeWZiUm5NeTJSaUk3WUdnVUEyZ2dR?=
 =?utf-8?B?R2UwL1RTTXdOTGN5M3J4L0J0VDk1OVJHR3ZQL3JzVG0zTEJTZFFNMjlrMXY0?=
 =?utf-8?B?T0NReDh6U1duclZmU3dwT2JvR3lRQXZUb25taVpLbnVUT0krUUZ2WHpjWXlM?=
 =?utf-8?B?OTZwdUYvamc3cTNvQTdjMkF5UHlWWEFDM1pDSjhQY2EwdGJlenM0a3NZV0FF?=
 =?utf-8?B?czV1RTlYS0o2dXErbWl4aFZlUTZ2NDhmTFJwY0lqejk5UmVVYUtwSVpVOFIr?=
 =?utf-8?B?bTBOaS85ZWdGK3RCVWFrUXIzTkNpMnV3SU1VVUx1em0waEh3KzhMOHNtV3c1?=
 =?utf-8?B?bWQ4OEhPanRKRWJtR0t0UWhVUUo2N09aSVVVdDl0OUhRRmVtbkt2L1FiRG1R?=
 =?utf-8?B?UW54cDhIVmZ4RG0wb1hoMEtLODRyTzhMd3VqRDQrWmFmMmQ2Yks3M1lEdGtj?=
 =?utf-8?B?czgzOUNSdnpxT2k2REhvdC9tMW02N0NlYXZ0WDd5YjZENEtFR3pFbHhocURT?=
 =?utf-8?B?UEV1WDlUVjkvaXJYdzhWMVVRcjhTMUlCbllNRnFTeGw0ZzZRUy9lUHNLS1N4?=
 =?utf-8?B?ZmJES1B6VE9ENjdUZ1ZVZEhNbnJXUmhPdDF4dnJVVmhMN2dRM2l6SlJYUjYv?=
 =?utf-8?B?dTEvVXRUREQ4Um1ybDlmbzV2WXpGbmZMeUNoQVhkR0dTSVJJOUZ4eEVjcWt3?=
 =?utf-8?B?NXc5QVZ3STZ5VUdMQWx5YmMvTllJcEg2YzFqQWZDbUU2RzA3NWI3NDMrODJU?=
 =?utf-8?B?L21vVFBha0FYZXB6N0xaRWxVdkhVSmFZdFlZYisyNDBlSXRTTkJvY1FqcXJU?=
 =?utf-8?B?WmZWdGZaQ2ZodUwxZVNodlR3aWNzSWsxNENkVzdQcFFodVhiY1BIWXRjOTNk?=
 =?utf-8?B?T1Z5WTBvK3djS2FnOW5jWUd1MHpybS81Tks0d0JQcy8vTmRyOVd5M0NDQjRj?=
 =?utf-8?B?cEtZc1lHR21vQ3F5QTB6VGFEbTI5WmhPb2J4amxBQ0ZsUGFMRWFsUWhXT0o2?=
 =?utf-8?B?WTNYZTdoazNEbzY1OWVCbk1uRmlLaUVRNTBkeHVGVGN1a2U0blhidm9YSGVR?=
 =?utf-8?B?VnNxU1lUa2cydmxoNjhabFVPVnFxWG9tV1Z2ZWFCU0hwaVFvNklMaG16RTBL?=
 =?utf-8?B?YnRPUXNaSStWNU9EQVNpQmdDNDA4N1lPdFJ6Yk1RNHdBME9wTUpEYUtUNkkz?=
 =?utf-8?B?QlR6MFRjK0FnN1NkRUk0eW1MK1JGOVdSYlFNb3ZoZmlWaHBQY2pDZWxqUnBZ?=
 =?utf-8?B?ZVJFV3MwM1FsVGpwZzVkSUQ5VmdqWkRxM0JJRm9WME50dDVDU2ZzTVA4ZXUv?=
 =?utf-8?B?emFad3pTMmRDZWw1SnpHMFl1NDNiK29QeVZSbEJwcUphc2FxYkkybGlmOXZn?=
 =?utf-8?B?N3pZa3UrTTZMYXFPeE1uUFhONjBvdUZjQ01weUR3b1RqRzRXd0s1dlpJVTBm?=
 =?utf-8?Q?5RtApgSQiUy4p1qB0gol5j42T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2f247f-aa27-4cff-2d0c-08dd0227ff40
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:08:16.8277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbMYIZppQCrJIjQ7umYwL2bZ/+zJWi/wdEENAlLe1jn2RpkKvahzGtyNFLdGr+cLEMliNnQL7zcLBkjvB/rNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
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

On 11/5/2024 4:50 AM, Felix Kuehling wrote:
>
> On 2024-10-31 22:35, Zhu Lingshan wrote:
>> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>>> The ioctl functions may fail, causing the args unreliable.
>>>> Therefore, the args should not be copied to user space.
>>>>
>>>> The return code provides enough information for
>>>> error handling in user space.
>>>>
>>>> This commit checks the return code of the ioctl functions
>>>> and handles errors appropriately when they fail.
>>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
>> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
>>
>> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
>>
>> usually the return code provides enough information for the user space programs.
> I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.
Still the questions:
1) how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? 2) what if the user space program doing pulling mode, pull the args before error code returned. Memory changes are usually faster than error code.
>
> You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.
>
> Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.
If a user space program needs to read arguments to do error recovery, then it is a buggy user space program that should be fixed.
Usually the error code provides enough information for error handling. Why our KFD user space are exceptive?

Thanks
Lingshan
>
> Regards,
>   Felix
>
>> Thanks
>> Lingshan
>>> Regards,
>>>   Felix
>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>  	}
>>>>  
>>>>  	retcode = func(filep, process, kdata);
>>>> +	if (retcode)
>>>> +		goto err_retcode;
>>>>  
>>>>  	if (cmd & IOC_OUT)
>>>>  		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>  	if (kdata != stack_kdata)
>>>>  		kfree(kdata);
>>>>  
>>>> +err_retcode:
>>>>  	if (retcode)
>>>>  		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>>  				nr, arg, retcode);

