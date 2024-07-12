Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22023C2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 14:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DA310E112;
	Fri, 12 Jul 2024 14:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXq5ykxD";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23EDC10E112
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 14:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bx2gdI95QqqVtGqmtIy+zMl2S4GvCrilAwBnLBhPOS6bfOG/bbIudkUyKj6CvxGiyqbIXUlXo7vEeLei0uq7/xlvSLQMgvjghdykbcTVhFnx0iajMyHKc/G3TJwoHVzgOWorAdU9Gh79Wtl2N7N/Q9j/mjT2m9UhAE3aKHpTmc3fZI7zbOLDsshO96tS9I9Efoa/q3BuWj2nQdgafUXOKRGHxEThe12faqaeSHBKmz48bA8kJQt7KO2i7pgC+h2iutg5Vnz9lAI/GXBGPKy8mc8QIvzyoEN+adKuLxbosjB+aW3YWyK2h/BDor4OovUTk0BGGTejeC9NUFxI+ufkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDNIZlkbrz9LSq/QyHokx2HEJXx0giq5lsWC+XKM0I=;
 b=k6DDfLRzQZwz00KULPuWtDD14Fh3zZpIrex5UBV93YQAVtADmhQ/vyz9Rc6w9V3EodB3IeGoO/c4vVLu+ZkMSBoHEnO4J19gu3eLMAxvegv/fvyJU40ehTXF4RZwGwnRj9wVAj9kUFKpbnJ52PctamHxN7610aTPiUk/Kv7nNSHZgmO60IXJK9CgAdDZXe2CBmvD34ymkNeWVdeA7zw9M9jJbF6HxWbn/oXhPAtZEdhkJXtUvR2fuglRIb8SkV36HpuvBdccQCO4+7uQUZreyN+guICK/6OGFtxSGhp/dGaRvAVc37ZXsifTQwXmwjtn9t54dpHYz1Qr+WOz+3UUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnDNIZlkbrz9LSq/QyHokx2HEJXx0giq5lsWC+XKM0I=;
 b=tXq5ykxDDRztbD9JCqr1oaAkgu+3/8KzLzz1GjZPdWjfAhC403CmsD0hYPUY+3pOzhGMbUqRseqdJx+FR0SounZmhb7otfqjIAMEjcvfIUXdKhHLOwsIPTRW1aUqU0c/S+Luns/GJK8VR/3c0LaPDF1x/O2E2eG/yj6sB3jkCa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Fri, 12 Jul
 2024 14:56:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:56:30 +0000
Message-ID: <748a49bd-0726-46b1-a94e-6c4333fb219c@amd.com>
Date: Fri, 12 Jul 2024 10:56:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Huang, Trigger" <Trigger.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "cao, lin" <lin.cao@amd.com>
References: <20240711090947.478919-1-YuanShang.Mao@amd.com>
 <SA1PR12MB74429E91B411DEEF22D29B70FEA52@SA1PR12MB7442.namprd12.prod.outlook.com>
 <d7d59834-7907-4100-8f7e-4c864674f00e@gmail.com>
 <PH0PR12MB542037268A58AEDF49E84D35E0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <PH0PR12MB5420453D1FF4C3834CDCFB4EE0A62@PH0PR12MB5420.namprd12.prod.outlook.com>
 <ad162a88-7549-4fc0-9102-3f45b1e8ef73@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ad162a88-7549-4fc0-9102-3f45b1e8ef73@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f739b8-b0be-4d62-9610-08dca282d063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VERIT3FDMWphMGZaaW9QM21Sa0VlUzZMQ21OYXpISi9oUHJQbCtFdnJLUVl3?=
 =?utf-8?B?aGhGRU5ob2R2dkZya1lXTStiNWI0bnJicm1TYVd6QUF5czVaQXpZTHVKZWlq?=
 =?utf-8?B?RS9nQlNMNVQyTm92OWxTeVI3RUtXdjNWSk9JQk1PaWtrcVhVU2NVbGZvY2Fz?=
 =?utf-8?B?VkhXSTRKbGRpT3lFbEtGWFAxZ0dWZHhvN1J1Rk1kN0YweUxoU3czejhBSmRv?=
 =?utf-8?B?U3EvbU1JRFFMMlc3Tkt5UnlTRFd2VjIzeHpqYVUzNDdTSndHRHZWOUhEOERz?=
 =?utf-8?B?d0NYL0lyQXpHYmcrR2JSODhpRnBIWXgrdWp1R05VMUlQR1cvc21oSkk1a2M3?=
 =?utf-8?B?VkhndzhMcEkrYWJ6alhaWGxOMUpRZEpDSWpBdUFxQ2xQbmRUaUo5WW9wbXA2?=
 =?utf-8?B?RFVtYVoyVWpFYm9rdjNXMmFRYTM5NGJSbjNvazRiRWZLemNKTkw5dGhlWUpv?=
 =?utf-8?B?OURwb0o3TmlvaHEzKzNHelFYNXBKRTFybkZKV0xxSi82dytodFJ5MEwrNHl6?=
 =?utf-8?B?K0RlaXdHbjRMMFNvZkdmVTdHbWpJV05WcmxiL28yNjViajRpdXc0SWpCYzc3?=
 =?utf-8?B?WnBWd3FacTRHcGRDaUhVN0szeGpvNWVpUFRwc1B4UkpTRkVKbGdHdUR2a0kx?=
 =?utf-8?B?RVh0YUc1TmlMdUV5MExzeFRXUkgxZ04rYk42M1hZRXZUaVI0Q29wTzdwZGZJ?=
 =?utf-8?B?MEgwclJXRmFaanVKTzRINk5wcmh5aUF5QlZUMEV4M2JpT3I2akZpODFMUGtF?=
 =?utf-8?B?dkhidXc1ZkRtM2k5V0ZNWE1JUDljK2pJNysrTTd0WnJ4V3N5eXJSaGYvTFNY?=
 =?utf-8?B?UUN0dlNIckQxdW81Wjh2dnFveXBrVDlHL0JnUW1lcnZsUnIwZkthOU1jaWVr?=
 =?utf-8?B?M0Y1VmFoV3gycU9OQ0hxWTdqM1lCRU9Vbzh3QzJXTGcxRm5mQklQSThYUWZ5?=
 =?utf-8?B?Rk1VZFBIN1Fsako0bmQxaVJSQ3BVc1kwRGlXK2dUMmFyZHVhSU9UQXRKN0py?=
 =?utf-8?B?WkdFbGRjbzd4U251RU1FNW9mWmJvOHBsZUlMNVJMbjRjQlhVUXA0eEpjNXFz?=
 =?utf-8?B?RFBqSDZyaXBjdGZ2WlRlNmtlaVNOWjNzUHFKQkpzdXRIMFJ5dU96RlI4SHBG?=
 =?utf-8?B?ZXpUMmsraWlrUENCZVNtdGZJT3I1Nmx4TDFLek1uczU4V1EyMWUyb3RCTGFQ?=
 =?utf-8?B?YkVNWXFSRWp0ejRPUGlFTExpYVU4S25CSk9uSlNzZ1pHMjRKUDdKTENSYkxn?=
 =?utf-8?B?SlcwMTNaYkFFclNWa1MvRnNxQUFPOXVMNlplM0pueGJZMnlvN20xanYxdkcv?=
 =?utf-8?B?eXhSOFVGaUNQZEZ1ZFk0ZkR6L0pCWUZlUWRYV1k0ZzdRZ1NLWmFmbTRiSDV3?=
 =?utf-8?B?U1lQaDI2ODhwMVVpUENUUjFoOGlhaEhBODhCZC9DYUNqWlcvUmgzR2pEOXcx?=
 =?utf-8?B?MzFOUjVpNG5MK1ByWi9MZzY0YkFPaytQbUtJVlpkR2ZGckE4bXY3V2pTUGRl?=
 =?utf-8?B?cW1tZUd0RzF3amFnWVR6QlAzUU15OVdCRXlLTkM1VUtxeW42VVFveU9MRGJo?=
 =?utf-8?B?dWVsb3htL3NRWk8yeGdFZGErYlE3bzV4L1RtdE9LYzR6Y2Y2eUZaS2ZJdEF3?=
 =?utf-8?B?ZjBldnlnQ2M1cDVQMHBaN1NzZDFEaTRNZkthcG9xcUk1K3V6Q2pNTnlHS3la?=
 =?utf-8?B?SGlQSjFkYXhrSHpDaGM3UXNsOHl1cVFUYitoeUxvQzBhY0gyd29wcXY1Rm84?=
 =?utf-8?B?TW91QmdNb0FmU2l4NlVNSm0rT1dtOEZPMFRQb1B2M2RaS2J4RThBVHBGM2ZY?=
 =?utf-8?B?NDd2QzdjN05OY2JrR3BlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEl2M2Mwb1dvTGtpU0NvbFROWEhDK0lNVzY5OGwvRU9BV1BKU3JXTDU4MVB2?=
 =?utf-8?B?VzBLMGdPSEpJMVNvcFBpSXQrTUMxQ3AvLzlvbjJ2YWJEb2I2UlNhNjI0OFFw?=
 =?utf-8?B?czN0anZvZ2dqd3Q1UzZRcTJxUUdqTG5tcFlkT1NlUDk1N3k1Kyt3Vzl0S1pZ?=
 =?utf-8?B?bDEzU0pVbHFTdHZaeUdlOUlpci8yaG81SW9SMmlNUmUxT0gzc29LOTV6bVZC?=
 =?utf-8?B?LzFEeWZVT2FCVUtFMkVKZUFEeTJIdnYrV21vazVGK3pBZXN3V0RmT2hQakxP?=
 =?utf-8?B?UXd4c1N5Y2NheHdpQitwQTY1NWhqNnZsZ2g0SXU4VUtvdVlrZ1hLeFpuWHZk?=
 =?utf-8?B?SUFma2E2OGMyaDZvc2MyRXg3UmFWNkNyRERWVy9ybmRDUmQzOUM3bTdncXJM?=
 =?utf-8?B?Wi9mSTRLWDNWWUpaNDNieE5jZ0Z4Yzc4ay9ET1R0TkUyakhxcXJPb0ptUW9j?=
 =?utf-8?B?L3J3Y0Myd3lSLzI4Wks0TUcreDhPd2R2MlR6VVg2eUdqcFQ4NGlad1NZUkgw?=
 =?utf-8?B?SEFUK2RYWkNaNVNpV2xuWm1NbUkwMmhhNmJjdm9DQjQ2YUd4T1BIa3FjcWl6?=
 =?utf-8?B?WC9PTUFLNHZBUFBhQkZsZGg2bkFKK0lZSDdNdHRNdTJlc3A1Snl6U2MwZkgr?=
 =?utf-8?B?Ni9ZV3BUZVpQQ2M3bTZpd3ErWlRyRi9hK2FtZ1hCaUxyVkJ5a2ZXSS9QUWF5?=
 =?utf-8?B?NmsvR1lLV1lmMDRFcFZCdFNxcWxrcWc2ZExRZU9CdzBGeXNmQ3MyNkQwcllh?=
 =?utf-8?B?Nm52UWM1Ny9NZ1pZNkZNdFNQSDY4V2dmSEd2dGFLUkg5cjRvaUNjNFlaTGJ3?=
 =?utf-8?B?MlBrNFZmYkttRldRV05FYVdJMjRKdWloaDJEbm8ya3ZpNUsxRjR3OHRVZHBU?=
 =?utf-8?B?bTNEVHBqdkRvT0JCMitQMHgvYzlDWmRMYmp0clphaVcvMSt1bDc5RnkrLyt1?=
 =?utf-8?B?SjhxTStXL2lSN25GK2JyRUVvQ3l6dE54dXhkZEFUNmJyakx4REJ3Q0RkWHZq?=
 =?utf-8?B?NGNsd3B6TEFyb2lsaDhQRmlXdkpyTDNnTkoyWTV5aWlKRm1QQXNFREdhRE55?=
 =?utf-8?B?UmJxektKbVQvQkRDWUllQ0N4MkdNYkVMd08zSzgyVnJKdjZxaDZiREJja0d5?=
 =?utf-8?B?dTl6aExmTEliVS9OTWx0aVlZOTNJZzgzVjVnTGFRSm1QMEI0MG9iM1IyeFJZ?=
 =?utf-8?B?NG9yTG5JVGtKWnRyNWlIL3NjdU9tV2h2eHNjZlEyd1dra2pmN3ZnTllhTVo4?=
 =?utf-8?B?NDJNejB2N2lxWU9MYlR4dWNxVXJlZ0x0RHVPREIxckowdlp1UFVMdHBReGZi?=
 =?utf-8?B?N3lkYVlwQ2xndjJRbVROZFl1aEJoWU12SEhUaDJWL2hwSWNTM3Y3OVQzbnJq?=
 =?utf-8?B?d3dxYjJxd0diczNqcGdMVURsR0hPWFVRczNoK3BLNEdxLzM5TXMwYkR3QjR3?=
 =?utf-8?B?VDVSZDh6cGl6Tk13TnJqSjNCb2pEUmVHT09PR2t4TnBCZkNwdGtmanR5WnJG?=
 =?utf-8?B?UkNLRnB6V0FzR2NMZzRDTGxIS1BUUVptdzVKcHdEOTJRZXFNOGxCcUhNU3FM?=
 =?utf-8?B?RmQ4dTc0MTU1OTZBOVBxN0owbGdhUFFkazQva0NXeDI1Wm9ReDVEclAvRnN0?=
 =?utf-8?B?VGo3TWUwc29rUmVLblhEMDhxREIrRmJBTURZZi9Ya05xWXFxYzZuZi9MeGpU?=
 =?utf-8?B?MC9FdHhRWGtLSmtIZmZQek05YStZQ2pXVWhjZGVsL3JQaE01MHV1T2NKZS9a?=
 =?utf-8?B?Q092aks1MjA0QTJQM0NZSVFHRGJlbUhzVDUzODlPVkJOcm5qTkx3ZVJuQjhV?=
 =?utf-8?B?U0pXZ25FTVBERlFYdEpRQ3Z6cGZuSlk1alFzOWZrRXJ0dGNoRjJlcUQrTFRJ?=
 =?utf-8?B?ZkVZTnVtSk8raDdFbEQ5QTUvVWRzbFl4TWxJOTJVN3pOSGg5WkVLbmdCNzg2?=
 =?utf-8?B?Q3piSkFIc284NWQxcUl3bmxzdDg5YUhTS1YrN211ak1YNmRpNVNxaXNNbzBl?=
 =?utf-8?B?MWpGT1RYdEw2KzFWejM4SSt2MHdPSW9CZExITVlVOEVXQm5zN09lbHZESzBk?=
 =?utf-8?B?ZDYyZko0OXlMS1oxMjNUeTFqVm4wY2dva1FMd0pRL25OdExpMzVuQkhJeGFY?=
 =?utf-8?Q?OTC2YfsdgIOwwrSsf/1UXAukn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f739b8-b0be-4d62-9610-08dca282d063
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:56:30.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DcJWUBrRNbCrztCVESc+Dqhp0VD1jd47nMDpqndegxqO46zHjKLn9n4rcvH1kmq+FveRErh1XcuWJtbYSSwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

KFD eviction fences are triggered by the enable_signaling callback on the eviction fence. Any move operations scheduled by amdgpu_bo_move are held up by the GPU scheduler until the eviction fence is signaled by the KFD eviction handler, which only happens after the user mode queues are stopped.

As I understand it, VM BO invalidation does not unmap anything from the page table itself. So the KFD queues are OK continue running until the eviction handler stops them and signals the fence.

However, if amdgpu_vm_handle_moved gets called before the eviction fence is signaled, then there could be a problem. In applications that do compute-graphics interop, the VM is shared between compute and graphics. So graphics and compute submissions at the same time are possible. @Christian, this is a concequence of using libdrm and insisting that each process uses only a single VM per GPU.

Regards,
  Felix

On 2024-07-12 3:39, Christian König wrote:
> Hi River,
> 
> well that isn't an error at all, this is perfectly expected behavior.
> 
> The VMs used by the KFD process are currently not meant to be used by classic CS at the same time.
> 
> This is one of the reasons for that.
> 
> Regards,
> Christian.
> 
> Am 12.07.24 um 09:35 schrieb YuanShang Mao (River):
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Add more info and CC @Kuehling, Felix @cao, lin
>>
>> In amdgpu_amdkfd_fence.c, there is a design description:
>>
>> /* Eviction Fence
>>   * Fence helper functions to deal with KFD memory eviction.
>>   * Big Idea - Since KFD submissions are done by user queues, a BO cannot be
>>   *  evicted unless all the user queues for that process are evicted.
>>   *
>>   * All the BOs in a process share an eviction fence. When process X wants
>>   * to map VRAM memory but TTM can't find enough space, TTM will attempt to
>>   * evict BOs from its LRU list. TTM checks if the BO is valuable to evict
>>   * by calling ttm_device_funcs->eviction_valuable().
>>   *
>>   * ttm_device_funcs->eviction_valuable() - will return false if the BO belongs
>>   *  to process X. Otherwise, it will return true to indicate BO can be
>>   *  evicted by TTM.
>>   *
>>   * If ttm_device_funcs->eviction_valuable returns true, then TTM will continue
>>   * the evcition process for that BO by calling ttm_bo_evict --> amdgpu_bo_move
>>   * --> amdgpu_copy_buffer(). This sets up job in GPU scheduler.
>>   *
>>   * GPU Scheduler (amd_sched_main) - sets up a cb (fence_add_callback) to
>>   *  nofity when the BO is free to move. fence_add_callback --> enable_signaling
>>   *  --> amdgpu_amdkfd_fence.enable_signaling
>>   *
>>   * amdgpu_amdkfd_fence.enable_signaling - Start a work item that will quiesce
>>   * user queues and signal fence. The work item will also start another delayed
>>   * work item to restore BOs
>>   */
>>
>> If mark BOs as invalidated before submitting job to move the buffer, user queue is still active.
>> During the time before user queue is evicted, if a drm job achieve, amdgpu_cs_vm_handling will call amdgpu_vm_handle_moved to clear the ptes of
>> Invalidated BOs. Then page fault happens because compute shader is still accessing the "invalidated" BO.
>>
>> I am not familiar with amdgpu_vm_bo state machine, so I don’t know if it is an code error or an design error.
>>
>> Thanks
>> River
>>
>>
>> -----Original Message-----
>> From: YuanShang Mao (River)
>> Sent: Friday, July 12, 2024 10:55 AM
>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Cc: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>
>> We need to make sure that all BOs of an active kfd process validated. Moving buffer will trigger process eviction.
>> If mark it as invalided before process eviction, related kfd process is still active and may attempt to access this invalidated BO.
>>
>> Agree with Trigger. Seems kfd eviction should been synced to move notify, not the move action.
>>
>> Thanks
>> River
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Thursday, July 11, 2024 8:39 PM
>> To: Huang, Trigger <Trigger.Huang@amd.com>; YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>
>> Yeah, completely agree. This patch doesn't really make sense.
>>
>> Please explain why you would want to do this?
>>
>> Regards,
>> Christian.
>>
>> Am 11.07.24 um 13:56 schrieb Huang, Trigger:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> This patch seems to be wrong.
>>> Quite a lot of preparations have been done in amdgpu_bo_move_notify
>>> For example, amdgpu_bo_kunmap() will be called to prevent the BO from being accessed by CPU. If not called, the CPU may attempt to access the BO while it is being moved.
>>>
>>> Thanks,
>>> Trigger
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> YuanShang
>>>> Sent: Thursday, July 11, 2024 5:10 PM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao
>>>> (River) <YuanShang.Mao@amd.com>
>>>> Subject: [PATCH] drm/amdgpu: Mark amdgpu_bo as invalid after moved
>>>>
>>>> Caution: This message originated from an External Source. Use proper
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> It leads to race condition if amdgpu_bo is marked as invalid before
>>>> it is really moved.
>>>>
>>>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 29e4b5875872..a29d5132ad3d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -519,8 +519,8 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>
>>>>           if (!old_mem || (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>                            bo->ttm == NULL)) {
>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   ttm_bo_move_null(bo, new_mem);
>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   return 0;
>>>>           }
>>>>           if (old_mem->mem_type == AMDGPU_GEM_DOMAIN_DGMA || @@ -
>>>> 530,8 +530,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object
>>>> *bo, bool evict,
>>>>           if (old_mem->mem_type == TTM_PL_SYSTEM &&
>>>>               (new_mem->mem_type == TTM_PL_TT ||
>>>>                new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   ttm_bo_move_null(bo, new_mem);
>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   return 0;
>>>>           }
>>>>           if ((old_mem->mem_type == TTM_PL_TT || @@ -542,9 +542,9 @@
>>>> static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>>>>                           return r;
>>>>
>>>>                   amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   ttm_resource_free(bo, &bo->resource);
>>>>                   ttm_bo_assign_mem(bo, new_mem);
>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   return 0;
>>>>           }
>>>>
>>>> @@ -557,8 +557,8 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>               new_mem->mem_type == AMDGPU_PL_OA ||
>>>>               new_mem->mem_type == AMDGPU_PL_DOORBELL) {
>>>>                   /* Nothing to save here */
>>>> -               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   ttm_bo_move_null(bo, new_mem);
>>>> +               amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>                   return 0;
>>>>           }
>>>>
>>>> @@ -583,11 +583,11 @@ static int amdgpu_bo_move(struct
>>>> ttm_buffer_object *bo, bool evict,
>>>>                   return -EMULTIHOP;
>>>>           }
>>>>
>>>> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>           if (adev->mman.buffer_funcs_enabled)
>>>>                   r = amdgpu_move_blit(bo, evict, new_mem, old_mem);
>>>>           else
>>>>                   r = -ENODEV;
>>>> +       amdgpu_bo_move_notify(bo, evict, new_mem);
>>>>
>>>>           if (r) {
>>>>                   /* Check that all memory is CPU accessible */
>>>> -- 
>>>> 2.25.1
> 
